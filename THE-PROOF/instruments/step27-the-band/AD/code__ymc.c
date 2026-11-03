/* ymc.c -- AD: ONE code for every theory of the averaged-row reading (the development AD, 2026-11-02).
 *
 * SAMPLERS (the exterior integrated: the whole periodic N^4 lattice is sampled, nothing pinned):
 *   G = su2   : Wilson weight exp(beta * Re U_p) (= exp(1/2 beta tr U_p), THE GROUND's normalisation), exact heat bath per link
 *               (Haar-proposal rejection for alpha = beta|A| < 2, Kennedy-Pendleton otherwise) + overrelaxation, checkerboard, OpenMP.
 *   G = vil   : Villain U(1) at beta_V, sampled EXACTLY in its zero-monopole, zero-twist sector: the non-compact photon in Feynman gauge
 *               (A = F^-1[F[eta]/sqrt(beta k^2)], eta white, separable DFT), plus a uniform constant, angles mod 2 pi. Links stored as the
 *               quaternions cos t + k sin t, so the SAME averaging map and the SAME statistics run on them.
 * THE AVERAGING MAP (WORK.md §1): V_mu(Y) = N( sum_{x in B_Y} T(x) Line_mu(x) T(x + n e_mu)^-1 ), T = the axial tree (0,1,2,3) from the block
 *   centre, the same tree in every block and every direction; n = 1 is the identity map.
 * STATISTICS (score matching = Galerkin Schwinger-Dyson): for the coarse link c and the features F_(f,r) = sum over loops of family f
 *   (plaquette, rectangle, chair, parallelogram; loops.h) of g_r(Re V_loop), r = SU(2) spins 1/2, 1, 3/2 (chi_j/d_j) or U(1) charges 1,2,3
 *   (cos k t): grad_c F (left Lie derivatives) and Lap_c F; per configuration the sums M = sum_c grad F . grad F^T and b = sum_c Lap F.
 *   The fit (fit.py) is theta = -M^-1 b for the action S = -sum theta_(f,r) F_(f,r).
 * usage: ymc G beta N nlist(e.g. 1,2,4) seed ntherm nsep nconf outprefix [nsub1] [savecoarse_n]
 * build: gcc -O3 -march=native -fopenmp -o ymc.exe ymc.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <omp.h>
#include "loops.h"

typedef struct { double w, x, y, z; } quat;
static inline quat qmul(quat a, quat b) { quat r; r.w = a.w*b.w - a.x*b.x - a.y*b.y - a.z*b.z; r.x = a.w*b.x + a.x*b.w + a.y*b.z - a.z*b.y;
  r.y = a.w*b.y - a.x*b.z + a.y*b.w + a.z*b.x; r.z = a.w*b.z + a.x*b.y - a.y*b.x + a.z*b.w; return r; }
static inline quat qconj(quat a) { quat r = { a.w, -a.x, -a.y, -a.z }; return r; }
static inline quat qadd(quat a, quat b) { quat r = { a.w + b.w, a.x + b.x, a.y + b.y, a.z + b.z }; return r; }
static inline double qnorm(quat a) { return sqrt(a.w*a.w + a.x*a.x + a.y*a.y + a.z*a.z); }
static inline quat qscale(quat a, double s) { quat r = { a.w*s, a.x*s, a.y*s, a.z*s }; return r; }
static const quat QONE = { 1, 0, 0, 0 };

static int N, NV, GSU2, NG;     /* NG = number of generators: 3 (SU(2)) or 1 (U(1)) */
static double BETA;
static quat *U;                 /* U[site*4 + mu] */

/* ---------------------------------------------------------------- RNG: splitmix64 per thread */
typedef struct { unsigned long long s; } rng_t;
static inline double rnd(rng_t *r) { r->s += 0x9E3779B97F4A7C15ULL; unsigned long long z = r->s; z = (z ^ (z >> 30)) * 0xBF58476D1CE4E5B9ULL;
  z = (z ^ (z >> 27)) * 0x94D049BB133111EBULL; z ^= z >> 31; return ((z >> 11) + 0.5) * (1.0 / 9007199254740992.0); }
static inline double gauss(rng_t *r) { double u1 = rnd(r), u2 = rnd(r); return sqrt(-2 * log(u1)) * cos(2 * M_PI * u2); }

/* ---------------------------------------------------------------- geometry on the fine lattice */
static inline int sidx(const int c[4], int L) { return ((((c[0] % L + L) % L) * L + (c[1] % L + L) % L) * L + (c[2] % L + L) % L) * L + (c[3] % L + L) % L; }
static inline void scoord(int s, int c[4], int L) { c[3] = s % L; s /= L; c[2] = s % L; s /= L; c[1] = s % L; s /= L; c[0] = s; }
static int *UPN, *DNN;          /* UPN[s*4+mu] = s + e_mu, DNN = s - e_mu */

static quat staple(int s, int mu) { quat S = { 0, 0, 0, 0 };
  for (int nu = 0; nu < 4; nu++) { if (nu == mu) continue; int sm = UPN[s*4+mu], sn = UPN[s*4+nu], sd = DNN[s*4+nu], smd = DNN[sm*4+nu];
    quat f = qmul(qmul(U[sm*4+nu], qconj(U[sn*4+mu])), qconj(U[s*4+nu]));
    quat b = qmul(qmul(qconj(U[smd*4+nu]), qconj(U[sd*4+mu])), U[sd*4+nu]);
    S = qadd(S, qadd(f, b)); }
  return S; }      /* sum of the six staples W with Re(U W) the plaquette */

static quat randsu2_a0(double a0, rng_t *r) { double rr = sqrt(fmax(0, 1 - a0*a0)), ct = 2*rnd(r) - 1, st = sqrt(fmax(0, 1 - ct*ct)), ph = 2*M_PI*rnd(r);
  quat q = { a0, rr*st*cos(ph), rr*st*sin(ph), rr*ct }; return q; }

static void heatbath(int s, int mu, rng_t *r) {
  quat S = staple(s, mu); double k = qnorm(S);
  double al = BETA * k, a0;
  if (al < 2.0) {   /* Haar proposal for a0 (density ~ sqrt(1 - a0^2)), accept with exp(al (a0 - 1)) */
    for (;;) { double a, b; do { a = 2*rnd(r) - 1; b = rnd(r); } while (b * b > 1 - a*a); /* a ~ semicircle */
      if (rnd(r) < exp(al * (a - 1))) { a0 = a; break; } }
  } else {          /* Kennedy-Pendleton */
    for (;;) { double r1 = rnd(r), r2 = rnd(r), r3 = rnd(r), r4 = rnd(r); double c = cos(2*M_PI*r2); double X = -(log(r1) + c*c*log(r3)) / al;
      if (r4*r4 <= 1 - X/2) { a0 = 1 - X; break; } }
  }
  quat v = (k < 1e-14) ? QONE : qscale(S, 1.0 / k);
  /* W = U v has density exp(al W.w) Haar; U = W v^-1 */
  U[s*4+mu] = qmul(randsu2_a0(a0, r), qconj(v)); }

static void overrelax(int s, int mu) { quat S = staple(s, mu); double k = qnorm(S); if (k < 1e-14) return; quat v = qscale(S, 1.0 / k);
  U[s*4+mu] = qmul(qmul(qconj(v), qconj(U[s*4+mu])), qconj(v)); }

static int *PAR;  /* parity lists */
static int NPAR[2];
static rng_t *TR;
static void sweep(int nor) {
  for (int mu = 0; mu < 4; mu++) for (int p = 0; p < 2; p++) {
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < NPAR[p]; i++) { int s = PAR[p * NV + i]; heatbath(s, mu, &TR[omp_get_thread_num()]); } }
  for (int o = 0; o < nor; o++) for (int mu = 0; mu < 4; mu++) for (int p = 0; p < 2; p++) {
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < NPAR[p]; i++) overrelax(PAR[p * NV + i], mu); } }

static double plaq_avg(void) { double t = 0;
  #pragma omp parallel for reduction(+:t)
  for (int s = 0; s < NV; s++) for (int mu = 0; mu < 4; mu++) for (int nu = mu + 1; nu < 4; nu++) { int sm = UPN[s*4+mu], sn = UPN[s*4+nu];
    t += qmul(qmul(qmul(U[s*4+mu], U[sm*4+nu]), qconj(U[sn*4+mu])), qconj(U[s*4+nu])).w; }
  return t / (6.0 * NV); }

/* ---------------------------------------------------------------- Villain sampler: separable DFT */
static double *TWC, *TWS;    /* cos, sin of 2 pi j k / N */
static void dft_axis(double *re, double *im, int axis, int sign) {
  int stride = 1; for (int a = 3; a > axis; a--) stride *= N;
  int nlines = NV / N;
  #pragma omp parallel
  { double *br = malloc(sizeof(double) * N), *bi = malloc(sizeof(double) * N);
    #pragma omp for schedule(static)
    for (int l = 0; l < nlines; l++) {
      /* the base index of line l: decompose l over the other three axes */
      int rem = l, base = 0, mult = 1; int c[4]; int k = 0;
      for (int a = 3; a >= 0; a--) { if (a == axis) { c[a] = 0; continue; } c[a] = rem % N; rem /= N; }
      (void)k; (void)mult; base = ((c[0] * N + c[1]) * N + c[2]) * N + c[3];
      for (int j = 0; j < N; j++) { double sr = 0, si = 0;
        for (int t = 0; t < N; t++) { int ph = (j * t) % N; double cr = TWC[ph], ci = sign * TWS[ph]; double xr = re[base + t * stride], xi = im[base + t * stride];
          sr += xr * cr - xi * ci; si += xr * ci + xi * cr; }
        br[j] = sr; bi[j] = si; }
      for (int j = 0; j < N; j++) { re[base + j * stride] = br[j]; im[base + j * stride] = bi[j]; } }
    free(br); free(bi); } }
static void villain_sample(rng_t *r) {
  double *re = malloc(sizeof(double) * NV), *im = malloc(sizeof(double) * NV), *m = malloc(sizeof(double) * NV);
  for (int s = 0; s < NV; s++) { int c[4]; scoord(s, c, N); double k2 = 0; for (int a = 0; a < 4; a++) k2 += 4 * pow(sin(M_PI * c[a] / N), 2);
    m[s] = (s == 0) ? 0.0 : 1.0 / sqrt(BETA * k2); }
  for (int mu = 0; mu < 4; mu++) {
    for (int s = 0; s < NV; s++) { re[s] = gauss(r); im[s] = 0; }
    for (int a = 0; a < 4; a++) dft_axis(re, im, a, -1);
    for (int s = 0; s < NV; s++) { re[s] *= m[s]; im[s] *= m[s]; }
    for (int a = 0; a < 4; a++) dft_axis(re, im, a, +1);
    double cst = 2 * M_PI * rnd(r);
    for (int s = 0; s < NV; s++) { double t = re[s] / NV + cst; quat q = { cos(t), 0, 0, sin(t) }; U[s*4+mu] = q; } }
  free(re); free(im); free(m); }

/* ---------------------------------------------------------------- the averaging map */
static quat *Vc;        /* coarse links Vc[Y*4 + mu] */
static int NC;          /* coarse side */
static double QMIN, QSUM; static long QCNT;
static void average_map(int n) {
  NC = N / n; int NVC = NC * NC * NC * NC; int h = n / 2;
  /* tree transporters T(x) for every fine site x (from its block's centre) */
  quat *T = malloc(sizeof(quat) * NV);
  #pragma omp parallel for schedule(static)
  for (int Yi = 0; Yi < NVC; Yi++) { int Yc[4]; scoord(Yi, Yc, NC); int cen[4]; for (int a = 0; a < 4; a++) cen[a] = n * Yc[a] + h;
    for (int o = 0; o < n * n * n * n; o++) { int oc[4], r = o; for (int a = 3; a >= 0; a--) { oc[a] = r % n; r /= n; }
      int x[4] = { cen[0], cen[1], cen[2], cen[3] }; quat t = QONE;
      for (int a = 0; a < 4; a++) { int target = n * Yc[a] + oc[a];
        while (x[a] < target) { t = qmul(t, U[sidx(x, N) * 4 + a]); x[a]++; }
        while (x[a] > target) { x[a]--; t = qmul(t, qconj(U[sidx(x, N) * 4 + a])); } }
      T[sidx(x, N)] = t; } }
  double qmin = 1e9, qs = 0; long qc = 0;
  #pragma omp parallel for schedule(static) reduction(+:qs, qc) reduction(min:qmin)
  for (int Yi = 0; Yi < NVC; Yi++) { int Yc[4]; scoord(Yi, Yc, NC);
    for (int mu = 0; mu < 4; mu++) { quat sum = { 0, 0, 0, 0 };
      for (int o = 0; o < n * n * n * n; o++) { int oc[4], r = o; for (int a = 3; a >= 0; a--) { oc[a] = r % n; r /= n; }
        int x[4]; for (int a = 0; a < 4; a++) x[a] = n * Yc[a] + oc[a];
        int s0 = sidx(x, N); quat t = T[s0]; int y[4] = { x[0], x[1], x[2], x[3] };
        for (int k = 0; k < n; k++) { t = qmul(t, U[sidx(y, N) * 4 + mu]); y[mu]++; }
        t = qmul(t, qconj(T[sidx(y, N)]));
        sum = qadd(sum, t); }
      double nr = qnorm(sum); qs += nr / (n * n * n * n); qc++; if (nr / (n * n * n * n) < qmin) qmin = nr / (n * n * n * n);
      Vc[Yi * 4 + mu] = qscale(sum, 1.0 / nr); } }
  QMIN = qmin; QSUM = qs; QCNT = qc;
  free(T); }

/* ---------------------------------------------------------------- the score-matching statistics on the coarse lattice */
#define NREP 3
#define NFEAT (NFAM * NREP)
static inline void gfun(int rep, double x, double *g, double *g1, double *g2) {
  if (GSU2) { if (rep == 0) { *g = x; *g1 = 1; *g2 = 0; } else if (rep == 1) { *g = (4*x*x - 1) / 3; *g1 = 8*x/3; *g2 = 8.0/3; }
              else { *g = 2*x*x*x - x; *g1 = 6*x*x - 1; *g2 = 12*x; } }
  else { if (rep == 0) { *g = x; *g1 = 1; *g2 = 0; } else if (rep == 1) { *g = 2*x*x - 1; *g1 = 4*x; *g2 = 4; }
         else { *g = 4*x*x*x - 3*x; *g1 = 12*x*x - 3; *g2 = 24*x; } } }

typedef struct { double M[NFEAT][NFEAT], b[NFEAT], gavg[NFEAT]; long long nlink, nloop; } stats_t;

static void coarse_stats(stats_t *st, int sub, rng_t *r) {
  int NVC = NC * NC * NC * NC; memset(st, 0, sizeof(*st));
  /* subsample: every sub-th coarse site (random offset) */
  int off = sub > 1 ? (int)(rnd(r) * sub) : 0;
  #pragma omp parallel
  { stats_t loc; memset(&loc, 0, sizeof(loc));
    #pragma omp for schedule(static)
    for (int Yi = off; Yi < NVC; Yi += sub) { int Yc[4]; scoord(Yi, Yc, NC);
      for (int mu = 0; mu < 4; mu++) {
        double G[NFEAT][3]; double Lp[NFEAT]; memset(G, 0, sizeof(G)); memset(Lp, 0, sizeof(Lp));
        quat Vcc = Vc[Yi * 4 + mu];
        for (int ii = 0; ii < NINC; ii++) { const int *in = INC[mu][ii]; int li = in[0], pos = in[5], sg = in[6]; int fam = LOOP_FAM[li]; int len = FAM_LEN[fam];
          int x[4]; for (int a = 0; a < 4; a++) x[a] = Yc[a] + in[1 + a] + LOOP_ST[li][a];
          quat q[6];
          for (int k = 0; k < len; k++) { int d = LOOP_STEP[li][k][0], s = LOOP_STEP[li][k][1];
            if (s > 0) { q[k] = Vc[sidx(x, NC) * 4 + d]; x[d]++; } else { x[d]--; q[k] = qconj(Vc[sidx(x, NC) * 4 + d]); } }
          quat Pp = QONE; for (int k = 1; k < len; k++) Pp = qmul(Pp, q[(pos + k) % len]);
          quat Q = qmul(Vcc, sg > 0 ? Pp : qconj(Pp));
          double xx = Q.w, v2 = 1 - xx * xx;   /* |vector part|^2 */
          for (int rep = 0; rep < NREP; rep++) { double g, g1, g2; gfun(rep, xx, &g, &g1, &g2); int f = fam * NREP + rep;
            G[f][0] += -g1 * Q.x; G[f][1] += -g1 * Q.y; G[f][2] += -g1 * Q.z;
            Lp[f] += g2 * v2 - NG * xx * g1;
            if (pos == 0) loc.gavg[f] += g; }     /* each loop counted once: at its first link, when that link is c */
        }
        for (int a = 0; a < NFEAT; a++) { loc.b[a] += Lp[a]; for (int bb = 0; bb < NFEAT; bb++) loc.M[a][bb] += G[a][0]*G[bb][0] + G[a][1]*G[bb][1] + G[a][2]*G[bb][2]; }
        loc.nlink++; } }
    #pragma omp critical
    { for (int a = 0; a < NFEAT; a++) { st->b[a] += loc.b[a]; st->gavg[a] += loc.gavg[a]; for (int bb = 0; bb < NFEAT; bb++) st->M[a][bb] += loc.M[a][bb]; }
      st->nlink += loc.nlink; } } }

int main(int argc, char **argv) {
  if (argc < 10) { fprintf(stderr, "usage: ymc G(su2|vil) beta N nlist seed ntherm nsep nconf outprefix [nsub1] [savecoarse_n]\n"); return 1; }
  GSU2 = (strcmp(argv[1], "su2") == 0); NG = GSU2 ? 3 : 1; BETA = atof(argv[2]); N = atoi(argv[3]);
  int nl[8], nn = 0; { char buf[64]; strncpy(buf, argv[4], 63); buf[63] = 0; for (char *t = strtok(buf, ","); t && nn < 8; t = strtok(NULL, ",")) nl[nn++] = atoi(t); }
  unsigned long long seed = strtoull(argv[5], 0, 10); int nth = atoi(argv[6]), nsep = atoi(argv[7]), nconf = atoi(argv[8]); const char *pre = argv[9];
  int nsub1 = argc > 10 ? atoi(argv[10]) : 1; int savec = argc > 11 ? atoi(argv[11]) : 0;
  for (int i = 0; i < nn; i++) if (N % nl[i]) { fprintf(stderr, "N %% n != 0\n"); return 1; }
  NV = N * N * N * N; U = malloc(sizeof(quat) * NV * 4); UPN = malloc(sizeof(int) * NV * 4); DNN = malloc(sizeof(int) * NV * 4);
  Vc = malloc(sizeof(quat) * NV * 4);
  for (int s = 0; s < NV; s++) { int c[4]; scoord(s, c, N); for (int mu = 0; mu < 4; mu++) { c[mu]++; UPN[s*4+mu] = sidx(c, N); c[mu] -= 2; DNN[s*4+mu] = sidx(c, N); c[mu]++; } }
  PAR = malloc(sizeof(int) * 2 * NV); NPAR[0] = NPAR[1] = 0;
  for (int s = 0; s < NV; s++) { int c[4]; scoord(s, c, N); int p = (c[0] + c[1] + c[2] + c[3]) & 1; PAR[p * NV + NPAR[p]++] = s; }
  int nthr = omp_get_max_threads(); TR = malloc(sizeof(rng_t) * nthr);
  for (int t = 0; t < nthr; t++) TR[t].s = seed * 0x2545F4914F6CDD1DULL + 7919ULL * (t + 1);
  rng_t mr = { seed * 0x9E3779B97F4A7C15ULL + 12345 };
  TWC = malloc(sizeof(double) * N); TWS = malloc(sizeof(double) * N); for (int j = 0; j < N; j++) { TWC[j] = cos(2 * M_PI * j / N); TWS[j] = sin(2 * M_PI * j / N); }
  for (int s = 0; s < NV * 4; s++) U[s] = QONE;
  char fn[512]; snprintf(fn, sizeof fn, "%s.stats", pre); FILE *fo = fopen(fn, "wb"); if (!fo) { fprintf(stderr, "cannot open %s\n", fn); return 1; }
  FILE *fc = NULL; if (savec) { snprintf(fn, sizeof fn, "%s.coarse%d", pre, savec); fc = fopen(fn, "wb"); }
  int hdr[8] = { GSU2, N, nn, NFEAT, NREP, NFAM, nconf, savec }; fwrite(hdr, sizeof(int), 8, fo); fwrite(nl, sizeof(int), nn, fo); fwrite(&BETA, sizeof(double), 1, fo);
  printf("YMC G=%s beta=%.6f N=%d threads=%d nlist=", GSU2 ? "su2" : "vil", BETA, N, nthr); for (int i = 0; i < nn; i++) printf("%d%s", nl[i], i + 1 < nn ? "," : "\n");
  if (GSU2) { for (int it = 0; it < nth; it++) { sweep(4); if (it % 50 == 0) { printf("therm %d plaq %.6f\n", it, plaq_avg()); fflush(stdout); } } }
  double t0 = omp_get_wtime();
  for (int cf = 0; cf < nconf; cf++) {
    if (GSU2) { for (int k = 0; k < nsep; k++) sweep(4); } else villain_sample(&mr);
    double pl = plaq_avg(); fwrite(&pl, sizeof(double), 1, fo);
    for (int i = 0; i < nn; i++) { int n = nl[i]; average_map(n); stats_t st; coarse_stats(&st, n == 1 ? nsub1 : 1, &mr);
      double qm = QSUM / QCNT; fwrite(&qm, sizeof(double), 1, fo); fwrite(&QMIN, sizeof(double), 1, fo); fwrite(&st, sizeof(st), 1, fo);
      if (fc && n == savec) fwrite(Vc, sizeof(quat), (size_t)NC * NC * NC * NC * 4, fc);
      if (cf % 20 == 0) printf("conf %d n=%d plaq %.6f |qbar| mean %.4f min %.4f  <g_plaq,r0> %.6f  nlink %lld  t=%.1fs\n", cf, n, pl, qm, QMIN,
                               st.gavg[0] / (6.0 * NC * NC * NC * NC / (n == 1 ? nsub1 : 1)), st.nlink, omp_get_wtime() - t0); }
    fflush(stdout); }
  fclose(fo); if (fc) fclose(fc);
  printf("DONE %d configurations, %.1f s\n", nconf, omp_get_wtime() - t0);
  return 0; }
