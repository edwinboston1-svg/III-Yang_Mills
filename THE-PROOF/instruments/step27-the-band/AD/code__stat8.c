/* stat8.c -- AD: the score-matching statistics of ymc.c EXTENDED by the five length-8 polygon classes (spin 1/2), computed OFFLINE on
 * saved coarse configurations (ymc.c's .coarseN file: nconf x NC^4 x 4 quaternions).  Features 0..11 exactly as ymc.c (loops.h), features
 * 12..16 the 8-link classes (loops8.h: extent 1x3, 2x2, unit cube, 1x1x2 box, unit tesseract).  Output: a .stats file readable by fit.py
 * (NFEAT = 17, one block size).  G: su2 (3 generators) only.
 * usage: stat8 COARSEFILE NC nconf beta n outprefix
 * build: gcc -O3 -march=native -fopenmp -o stat8.exe stat8.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <omp.h>
#include "loops.h"
#include "loops8.h"
typedef struct { double w, x, y, z; } quat;
static inline quat qmul(quat a, quat b) { quat r; r.w = a.w*b.w - a.x*b.x - a.y*b.y - a.z*b.z; r.x = a.w*b.x + a.x*b.w + a.y*b.z - a.z*b.y;
  r.y = a.w*b.y - a.x*b.z + a.y*b.w + a.z*b.x; r.z = a.w*b.z + a.x*b.y - a.y*b.x + a.z*b.w; return r; }
static inline quat qconj(quat a) { quat r = { a.w, -a.x, -a.y, -a.z }; return r; }
static const quat QONE = { 1, 0, 0, 0 };
#define NREP 3
#define NF12 (NFAM * NREP)
#define NFEAT (NF12 + NCL8)
static int NC; static quat *Vc;
static inline int sidx(const int c[4]) { return ((((c[0] % NC + NC) % NC) * NC + (c[1] % NC + NC) % NC) * NC + (c[2] % NC + NC) % NC) * NC + (c[3] % NC + NC) % NC; }
static inline void gfun(int rep, double x, double *g, double *g1, double *g2) {
  if (rep == 0) { *g = x; *g1 = 1; *g2 = 0; } else if (rep == 1) { *g = (4*x*x - 1) / 3; *g1 = 8*x/3; *g2 = 8.0/3; } else { *g = 2*x*x*x - x; *g1 = 6*x*x - 1; *g2 = 12*x; } }
typedef struct { double M[NFEAT][NFEAT], b[NFEAT], gavg[NFEAT]; long long nlink, nloop; } stats_t;
int main(int argc, char **argv) {
  if (argc < 7) { fprintf(stderr, "usage: stat8 COARSEFILE NC nconf beta n outprefix\n"); return 1; }
  NC = atoi(argv[2]); int nconf = atoi(argv[3]); double beta = atof(argv[4]); int n = atoi(argv[5]);
  int NVC = NC * NC * NC * NC; Vc = malloc(sizeof(quat) * NVC * 4);
  FILE *fi = fopen(argv[1], "rb"); if (!fi) { fprintf(stderr, "cannot open %s\n", argv[1]); return 1; }
  char fn[512]; snprintf(fn, sizeof fn, "%s.stats", argv[6]); FILE *fo = fopen(fn, "wb");
  int hdr[8] = { 1, NC * n, 1, NFEAT, NREP, NFAM, nconf, 0 }; fwrite(hdr, sizeof(int), 8, fo); fwrite(&n, sizeof(int), 1, fo); fwrite(&beta, sizeof(double), 1, fo);
  double t0 = omp_get_wtime();
  for (int cf = 0; cf < nconf; cf++) {
    if (fread(Vc, sizeof(quat), (size_t)NVC * 4, fi) != (size_t)NVC * 4) { fprintf(stderr, "short read at conf %d\n", cf); break; }
    stats_t st; memset(&st, 0, sizeof st);
    #pragma omp parallel
    { stats_t loc; memset(&loc, 0, sizeof loc);
      #pragma omp for schedule(static)
      for (int Yi = 0; Yi < NVC; Yi++) { int Yc[4], r = Yi; for (int a = 3; a >= 0; a--) { Yc[a] = r % NC; r /= NC; }
        for (int mu = 0; mu < 4; mu++) {
          double G[NFEAT][3], Lp[NFEAT]; memset(G, 0, sizeof G); memset(Lp, 0, sizeof Lp);
          quat Vcc = Vc[Yi * 4 + mu];
          for (int ii = 0; ii < NINC; ii++) { const int *in = INC[mu][ii]; int li = in[0], pos = in[5], sg = in[6]; int fam = LOOP_FAM[li], len = FAM_LEN[fam];
            int x[4]; for (int a = 0; a < 4; a++) x[a] = Yc[a] + in[1 + a] + LOOP_ST[li][a];
            quat q[6];
            for (int k = 0; k < len; k++) { int d = LOOP_STEP[li][k][0], s = LOOP_STEP[li][k][1];
              if (s > 0) { q[k] = Vc[sidx(x) * 4 + d]; x[d]++; } else { x[d]--; q[k] = qconj(Vc[sidx(x) * 4 + d]); } }
            quat Pp = QONE; for (int k = 1; k < len; k++) Pp = qmul(Pp, q[(pos + k) % len]);
            quat Q = qmul(Vcc, sg > 0 ? Pp : qconj(Pp)); double xx = Q.w, v2 = 1 - xx * xx;
            for (int rep = 0; rep < NREP; rep++) { double g, g1, g2; gfun(rep, xx, &g, &g1, &g2); int f = fam * NREP + rep;
              G[f][0] += -g1 * Q.x; G[f][1] += -g1 * Q.y; G[f][2] += -g1 * Q.z; Lp[f] += g2 * v2 - 3 * xx * g1;
              if (pos == 0) loc.gavg[f] += g; } }
          for (int e = 0; e < N8; e++) { int cl = L8CLS[mu][e]; quat Pp = QONE;
            for (int k = 1; k < 8; k++) { const signed char *l = L8[mu][e][k]; int x[4] = { Yc[0] + l[0], Yc[1] + l[1], Yc[2] + l[2], Yc[3] + l[3] };
              quat q = Vc[sidx(x) * 4 + l[4]]; Pp = qmul(Pp, l[5] > 0 ? q : qconj(q)); }
            quat Q = qmul(Vcc, Pp); double xx = Q.w, v2 = 1 - xx * xx; int f = NF12 + cl;
            G[f][0] += -Q.x; G[f][1] += -Q.y; G[f][2] += -Q.z; Lp[f] += -3 * xx; (void)v2;
            loc.gavg[f] += xx; }                                     /* every incidence: the class average = gavg / (nlink x class count) */
          for (int a = 0; a < NFEAT; a++) { loc.b[a] += Lp[a]; for (int bb = 0; bb < NFEAT; bb++) loc.M[a][bb] += G[a][0]*G[bb][0] + G[a][1]*G[bb][1] + G[a][2]*G[bb][2]; }
          loc.nlink++; } }
      #pragma omp critical
      { for (int a = 0; a < NFEAT; a++) { st.b[a] += loc.b[a]; st.gavg[a] += loc.gavg[a]; for (int bb = 0; bb < NFEAT; bb++) st.M[a][bb] += loc.M[a][bb]; } st.nlink += loc.nlink; } }
    double pl = 0, qm = 0, qmin = 0; fwrite(&pl, sizeof(double), 1, fo); fwrite(&qm, sizeof(double), 1, fo); fwrite(&qmin, sizeof(double), 1, fo); fwrite(&st, sizeof st, 1, fo);
    if (cf % 50 == 0) { printf("conf %d  <8-link class averages> %.6f %.6f %.6f %.6f %.6f  t=%.1fs\n", cf, st.gavg[12] / (st.nlink * 24.0), st.gavg[13] / (st.nlink * 60.0),
                               st.gavg[14] / (st.nlink * 48.0), st.gavg[15] / (st.nlink * 1440.0), st.gavg[16] / (st.nlink * 1296.0), omp_get_wtime() - t0); fflush(stdout); } }
  fclose(fo); fclose(fi); printf("DONE %.1fs\n", omp_get_wtime() - t0); return 0; }
