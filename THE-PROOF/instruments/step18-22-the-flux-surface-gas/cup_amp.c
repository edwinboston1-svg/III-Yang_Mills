/* cup_amp.c -- THE NECK'S SMALLEST INSTANCE, EXACT: the five-plaquette cup's amplitude with mixed spins (S1 §25 (m), (m′); 2026-11-01, the author
 * author).  A lone wall p′ (the bottom face of a unit cube) at spin k, the cup (the cube's other five faces) at spin j, and at each of the four
 * waist links (the bottom face's edges) the leaf's continuation: one outside plaquette at spin ½ whose two matrix indices at that link stay OPEN
 * -- the amplitude is a tensor over the four legs' index pairs, (2·2)^4 = 256 entries, the Haar integral over the cube's twelve links of the
 * six faces' characters and the four legs' matrices, taken by the two-face engine's wire method (w2_strip_n.c) on this one object.  Printed for
 * the uniform case (j = ½, k = 1: S7's lone wall) and the mixed ones (j = 3/2 with k = 1 and 2; j = 5/2 with k = 2 and 3) the Frobenius norm and the
 * largest entry; the RATIO mixed / uniform of the norms is the topological factor (m′) bounds by the channel count 2 (the coefficients d_j a_j
 * being outside the integral).  A leg's orientation is a convention; every case is read with the same one.
 * usage: cup_amp J2 K2    (the cup's spin as 2j, the wall's as 2k)      build: gcc -O2 -o cup_amp.exe cup_amp.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
typedef double complex cplx;
#define PI 3.141592653589793
static int SMAX; static int DIM[32]; static double FACT[40];
typedef struct { double w, x, y, z; } quat;
static quat qinv(quat a) { quat r = { a.w, -a.x, -a.y, -a.z }; return r; }
static int GENINV = 1;
static void Dsub(int s, quat q, cplx *D) {
  cplx a = q.w + I * q.x, b = q.y + I * q.z, ab = q.w - I * q.x, nbb = -q.y + I * q.z;
  cplx poly[40], np[40];
  for (int qq = 0; qq <= s; qq++) { int len = 1; poly[0] = 1;
    for (int r = 0; r < qq; r++) { for (int k = 0; k <= len; k++) np[k] = 0; for (int k = 0; k < len; k++) { np[k + 1] += poly[k] * a; np[k] += poly[k] * b; } len++; for (int k = 0; k < len; k++) poly[k] = np[k]; }
    for (int r = 0; r < s - qq; r++) { for (int k = 0; k <= len; k++) np[k] = 0; for (int k = 0; k < len; k++) { np[k + 1] += poly[k] * nbb; np[k] += poly[k] * ab; } len++; for (int k = 0; k < len; k++) poly[k] = np[k]; }
    for (int p = 0; p <= s; p++) { double sc = sqrt(FACT[p] * FACT[s - p] / (FACT[qq] * FACT[s - qq])); D[p * (s + 1) + qq] = poly[p] * sc; } } }
static void rep(int s, quat q, cplx *D) { if (s == 0) { D[0] = 1; return; } Dsub(s, GENINV ? qinv(q) : q, D); }
static int NPT; static quat *RU; static double *RW;
static void gauss_legendre(int n, double *x, double *w) { for (int i = 1; i <= n; i++) { double z = cos(PI * (i - 0.25) / (n + 0.5)), dp = 0;
    for (int it = 0; it < 200; it++) { double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2 * k - 1) * z * p1 - (k - 1) * p0) / k; p0 = p1; p1 = p2; } dp = n * (z * p1 - p0) / (z * z - 1); double z1 = z; z = z1 - p1 / dp; if (fabs(z - z1) < 1e-15) break; }
    double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2 * k - 1) * z * p1 - (k - 1) * p0) / k; p0 = p1; p1 = p2; } dp = n * (z * p1 - p0) / (z * z - 1); x[i - 1] = z; w[i - 1] = 2 / ((1 - z * z) * dp * dp); } }
static void make_rule(int deg) { int nth = (deg + 2) / 2, ngl = (deg + 2) / 2, naz = deg + 1; double gx[400], gw[400]; gauss_legendre(ngl, gx, gw);
  NPT = nth * ngl * naz; RU = malloc(sizeof(quat) * NPT); RW = malloc(sizeof(double) * NPT); int n = 0;
  for (int k = 1; k <= nth; k++) { double th = k * PI / (nth + 1), wt = 2 * sin(th) * sin(th) / (nth + 1);
    for (int j = 0; j < ngl; j++) { double t = gx[j], st = sqrt(1 - t * t);
      for (int l = 0; l < naz; l++) { double ph = 2 * PI * l / naz; quat u = { cos(th), sin(th) * st * cos(ph), sin(th) * st * sin(ph), sin(th) * t }; RU[n] = u; RW[n] = wt * gw[j] / 2 / naz; n++; } } } }
/* ---- the cube: links (base, dir), faces as cycles, four legs as one-step cycles with open ends */
static int NL = 0; static int LB[12][3], LD[12];
static int lkey(int x, int y, int z, int d, int create) { for (int i = 0; i < NL; i++) if (LD[i] == d && LB[i][0] == x && LB[i][1] == y && LB[i][2] == z) return i; if (!create) return -1; LB[NL][0] = x; LB[NL][1] = y; LB[NL][2] = z; LD[NL] = d; return NL++; }
#define NCYC 10
static int NSTEP[NCYC], STEPL[NCYC][4], STEPS[NCYC][4], OPENC[NCYC], NWIRE[NCYC], WBASE[NCYC], SPIN[NCYC]; static int NW = 0; static int WCYC[64];
static void add_face(int c, int x, int y, int z, int d1, int d2) { int q[3]; NSTEP[c] = 4; OPENC[c] = 0;
  STEPL[c][0] = lkey(x, y, z, d1, 1); STEPS[c][0] = 1;
  q[0] = x; q[1] = y; q[2] = z; q[d1 - 1]++; STEPL[c][1] = lkey(q[0], q[1], q[2], d2, 1); STEPS[c][1] = 1;
  q[0] = x; q[1] = y; q[2] = z; q[d2 - 1]++; STEPL[c][2] = lkey(q[0], q[1], q[2], d1, 1); STEPS[c][2] = -1;
  STEPL[c][3] = lkey(x, y, z, d2, 1); STEPS[c][3] = -1; }
static int NSLOT[12], SLC[12][4], SLS[12][4];
static int win(int c, int i) { return WBASE[c] + i; }
static int wout(int c, int i) { return OPENC[c] ? WBASE[c] + i + 1 : WBASE[c] + (i + 1) % NSTEP[c]; }
static cplx *RM; static size_t RSTR;
static cplx *rmat(int pt, int s, int inv) { return RM + ((size_t)pt * (SMAX + 1) * 2 + (size_t)s * 2 + inv) * RSTR; }
static cplx *LT[12];
static void link_tensor(int l) { int m = NSLOT[l]; int size = 1; int sp[4]; for (int j = 0; j < m; j++) { sp[j] = SPIN[SLC[l][j]]; size *= DIM[sp[j]] * DIM[sp[j]]; }
  cplx *B = calloc(size, sizeof(cplx)); LT[l] = B;
  for (int pt = 0; pt < NPT; pt++) { double w = RW[pt]; const cplx *R[4]; for (int j = 0; j < m; j++) R[j] = rmat(pt, sp[j], STEPS[SLC[l][j]][SLS[l][j]] < 0);
    int dd[4]; for (int j = 0; j < m; j++) dd[j] = DIM[sp[j]] * DIM[sp[j]];
    if (m == 2) { for (int i = 0; i < dd[0]; i++) { cplx f = w * R[0][i]; for (int k = 0; k < dd[1]; k++) B[(size_t)i * dd[1] + k] += f * R[1][k]; } }
    else if (m == 3) { for (int i = 0; i < dd[0]; i++) { cplx f = w * R[0][i]; for (int k = 0; k < dd[1]; k++) { cplx g = f * R[1][k]; for (int q = 0; q < dd[2]; q++) B[((size_t)i * dd[1] + k) * dd[2] + q] += g * R[2][q]; } } }
    else { fprintf(stderr, "a link with %d slots\n", m); exit(1); } } }
typedef struct { int nopen, open[64]; size_t size; cplx *v; } state_t;
static int in_list(int x, const int *L, int n) { for (int i = 0; i < n; i++) if (L[i] == x) return i; return -1; }
static void process(state_t *S, int l) {
  int m = NSLOT[l]; int sw[8], nsw = 0; for (int j = 0; j < m; j++) { sw[nsw++] = win(SLC[l][j], SLS[l][j]); sw[nsw++] = wout(SLC[l][j], SLS[l][j]); }
  int contracted[8], ncon = 0, newer[8], nnew = 0; for (int i = 0; i < nsw; i++) { if (in_list(sw[i], S->open, S->nopen) >= 0) contracted[ncon++] = sw[i]; else newer[nnew++] = sw[i]; }
  state_t N; N.nopen = 0; for (int i = 0; i < S->nopen; i++) if (in_list(S->open[i], contracted, ncon) < 0) N.open[N.nopen++] = S->open[i]; for (int i = 0; i < nnew; i++) N.open[N.nopen++] = newer[i];
  int ndim[64]; size_t nsize = 1; for (int w = 0; w < N.nopen; w++) { ndim[w] = DIM[SPIN[WCYC[N.open[w]]]]; nsize *= ndim[w]; }
  cplx *NB = calloc(nsize, sizeof(cplx)); N.size = nsize; N.v = NB;
  size_t ostr[64], tstr[8]; { size_t mul = 1; for (int i = S->nopen - 1; i >= 0; i--) { ostr[i] = mul; mul *= DIM[SPIN[WCYC[S->open[i]]]]; } }
  { size_t mul = 1; for (int i = nsw - 1; i >= 0; i--) { tstr[i] = mul; mul *= DIM[SPIN[WCYC[sw[i]]]]; } }
  size_t nos[64], nts[64]; for (int w = 0; w < N.nopen; w++) { int io = in_list(N.open[w], S->open, S->nopen), it = in_list(N.open[w], sw, nsw); nos[w] = io >= 0 ? ostr[io] : 0; nts[w] = it >= 0 ? tstr[it] : 0; }
  int cdim[8]; size_t cos_[8], cts[8]; for (int i = 0; i < ncon; i++) { int io = in_list(contracted[i], S->open, S->nopen), it = in_list(contracted[i], sw, nsw); cdim[i] = DIM[SPIN[WCYC[contracted[i]]]]; cos_[i] = ostr[io]; cts[i] = tstr[it]; }
  size_t ncomb = 1; for (int i = 0; i < ncon; i++) ncomb *= cdim[i];
  for (size_t e = 0; e < nsize; e++) { size_t rem = e, oo = 0, to = 0; for (int w = N.nopen - 1; w >= 0; w--) { size_t ix = rem % ndim[w]; rem /= ndim[w]; oo += ix * nos[w]; to += ix * nts[w]; }
    cplx acc = 0; size_t ci[8] = {0};
    for (size_t q = 0; q < ncomb; q++) { size_t o2 = oo, t2 = to; for (int i = 0; i < ncon; i++) { o2 += ci[i] * cos_[i]; t2 += ci[i] * cts[i]; } acc += S->v[o2] * LT[l][t2];
      for (int i = ncon - 1; i >= 0; i--) { if (++ci[i] < (size_t)cdim[i]) break; ci[i] = 0; } }
    NB[e] = acc; }
  free(S->v); *S = N; }
static double run_case(int j2, int k2, double *maxent) {
  /* the six faces: 0 bottom (the wall), 1 top, 2 front, 3 back, 4 left, 5 right; the four legs at the bottom's edges */
  NL = 0; NW = 0;
  add_face(0, 0, 0, 0, 1, 2); add_face(1, 0, 0, 1, 1, 2); add_face(2, 0, 0, 0, 1, 3); add_face(3, 0, 1, 0, 1, 3); add_face(4, 0, 0, 0, 2, 3); add_face(5, 1, 0, 0, 2, 3);
  if (NL != 12) { fprintf(stderr, "cube links %d\n", NL); exit(1); }
  for (int g = 0; g < 4; g++) { int c = 6 + g; NSTEP[c] = 1; OPENC[c] = 1; STEPL[c][0] = STEPL[0][g]; STEPS[c][0] = 1; }
  SPIN[0] = k2; for (int c = 1; c < 6; c++) SPIN[c] = j2; for (int c = 6; c < 10; c++) SPIN[c] = getenv("CUP_LEG") ? atoi(getenv("CUP_LEG")) : 1;   /* CUP_LEG=0: no legs, the closed cube (its known answer d^{chi - n}: 1/16 at spin 1/2) */
  for (int c = 0; c < NCYC; c++) { NWIRE[c] = OPENC[c] ? NSTEP[c] + 1 : NSTEP[c]; WBASE[c] = NW; for (int i = 0; i < NWIRE[c]; i++) WCYC[NW + i] = c; NW += NWIRE[c]; }
  for (int l = 0; l < NL; l++) NSLOT[l] = 0; for (int c = 0; c < NCYC; c++) for (int i = 0; i < NSTEP[c]; i++) { int l = STEPL[c][i]; SLC[l][NSLOT[l]] = c; SLS[l][NSLOT[l]] = i; NSLOT[l]++; }
  for (int l = 0; l < NL; l++) link_tensor(l);
  state_t S; S.nopen = 0; S.size = 1; S.v = calloc(1, sizeof(cplx)); S.v[0] = 1;
  /* the order: the top face's links, the four verticals, the bottom's (the waist) last */
  int order[12]; int no = 0; for (int i = 0; i < 4; i++) order[no++] = STEPL[1][i]; for (int l = 0; l < NL; l++) if (LD[l] == 3) order[no++] = l; for (int i = 0; i < 4; i++) order[no++] = STEPL[0][i];
  if (no != 12) { fprintf(stderr, "order %d\n", no); exit(1); }
  for (int i = 0; i < 12; i++) { process(&S, order[i]); for (int l = 0; l < NL; l++) ; }
  if (S.nopen != 8) { fprintf(stderr, "%d open wires at the end, not 8\n", S.nopen); exit(1); }
  double nrm = 0, mx = 0; for (size_t e = 0; e < S.size; e++) { double a = cabs(S.v[e]); nrm += a * a; if (a > mx) mx = a; }
  for (int l = 0; l < NL; l++) free(LT[l]); free(S.v); *maxent = mx; return sqrt(nrm); }
int main(int argc, char **argv) {
  FACT[0] = 1; for (int i = 1; i < 40; i++) FACT[i] = FACT[i - 1] * i; for (int s = 0; s < 32; s++) DIM[s] = s + 1;
  int cases[8][2] = { {1, 2}, {3, 2}, {3, 4}, {5, 4}, {5, 6}, {1, 0}, {1, 1}, {3, 3} };   /* (2j, 2k): the uniform wall; the mixed; the no-wall control (k = 0: the cup alone, which must vanish... the bottom at spin 0 with the legs open) */
  SMAX = 6; RSTR = (size_t)(SMAX + 1) * (SMAX + 1); make_rule(20);
  RM = malloc(sizeof(cplx) * (size_t)NPT * (SMAX + 1) * 2 * RSTR);
  for (int pt = 0; pt < NPT; pt++) for (int s = 0; s <= SMAX; s++) { rep(s, RU[pt], rmat(pt, s, 0)); rep(s, qinv(RU[pt]), rmat(pt, s, 1)); }
  double u = 0, umax = 0;
  for (int i = 0; i < 8; i++) { int j2 = cases[i][0], k2 = cases[i][1]; if (j2 > SMAX || k2 > SMAX) continue; double mx; double nrm = run_case(j2, k2, &mx); if (i == 0) { u = nrm; umax = mx; }
    printf("CUP j=%d/2 k=%d/2: |T|_F = %.9e max|entry| = %.9e  ratio to the uniform wall (j=1/2, k=1): norm %.6e max %.6e  rule %d points\n", j2, k2, nrm, mx, u > 0 ? nrm / u : 0, umax > 0 ? mx / umax : 0, NPT); }
  return 0; }
