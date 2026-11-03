/* su2mh.c -- THE JOINT CLASS LAW OF TWO ADJACENT n x n WILSON LOOPS UNDER THE SU(2) WILSON MEASURE, read by Monte Carlo on the periodic L^D
 * lattice with EXACT single-link integration (multihit) of every loop link that shares no plaquette with another integrated one (PM,
 * 2026-11-02).  The pair: base site s, directions mu (A on the +mu side) and nu (the shared edge from s to s + n nu); A = P_A S^-1 and B = S P_B,
 * both counter-clockwise in the (mu, nu) plane; every site and every ordered pair (mu, nu) is a placement.  For each placement and each channel
 * (a, c) in {0,1,2}^2 (a = twice A's spin) the estimator of chi_a(A) chi_c(B) is computed twice: PLAIN (the links as they are) and MH (the
 * integrated links replaced by their exact conditional means; the shared ones in the doubled representation conj(M_a) (x) M_c).
 * Links: unit quaternions U(x, x+e_mu), Hamilton product, the convention of MIR's heatbath.c / w2_strip_n.c; the Wilson action
 * beta sum_p (1 - 1/2 tr U_p); a link's local weight exp(beta (U S).w), S its staple sum.  Spin 1/2: M_1(q) = w - i(x s1 + y s2 + z s3)
 * (a homomorphism of the Hamilton product); spin 1: M_2(q) = the rotation v -> q v q^-1 (real).  KATs at start: homomorphism, traces,
 * projector idempotence and completeness.
 * usage: su2mh D L BETA n SEED NTHERM NSEP NMEAS NOR OUTFILE     build: gcc -O2 -fopenmp -o su2mh.exe su2mh.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
#include <stdint.h>
#include <omp.h>
typedef double complex cplx;
typedef struct { double w, x, y, z; } quat;
#define PI 3.141592653589793
static int D, LS, NN; static long V; static double BETA;
static quat *U; static long *UPT, *DNT; static int *PAR;
static quat qmul(quat a, quat b) { quat r; r.w = a.w*b.w - a.x*b.x - a.y*b.y - a.z*b.z; r.x = a.w*b.x + a.x*b.w + a.y*b.z - a.z*b.y; r.y = a.w*b.y - a.x*b.z + a.y*b.w + a.z*b.x; r.z = a.w*b.z + a.x*b.y - a.y*b.x + a.z*b.w; return r; }
static quat qinv(quat a) { quat r = { a.w, -a.x, -a.y, -a.z }; return r; }
/* ---- rng: one splitmix64 stream per thread */
static uint64_t *RS;
static double rnd(int t) { uint64_t z = (RS[8 * t] += 0x9E3779B97F4A7C15ULL); z = (z ^ (z >> 30)) * 0xBF58476D1CE4E5B9ULL; z = (z ^ (z >> 27)) * 0x94D049BB133111EBULL; z ^= z >> 31; return ((z >> 11) + 0.5) * (1.0 / 9007199254740992.0); }
/* ---- the lattice */
static long site_of(const int *c) { long s = 0; for (int i = 0; i < D; i++) s = s * LS + ((c[i] % LS) + LS) % LS; return s; }
static void coords(long s, int *c) { for (int i = D - 1; i >= 0; i--) { c[i] = s % LS; s /= LS; } }
static long shift(long s, int mu, int k) { int c[4]; coords(s, c); c[mu] += k; return site_of(c); }
static quat stsum(long s, int mu) { quat S = {0, 0, 0, 0};
  for (int nu = 0; nu < D; nu++) { if (nu == mu) continue; long sm = UPT[s * D + mu], sn = UPT[s * D + nu], sd = DNT[s * D + nu], smd = DNT[sm * D + nu];
    quat f = qmul(qmul(U[sm * D + nu], qinv(U[sn * D + mu])), qinv(U[s * D + nu]));
    quat b = qmul(qmul(qinv(U[smd * D + nu]), qinv(U[sd * D + mu])), U[sd * D + nu]);
    S.w += f.w + b.w; S.x += f.x + b.x; S.y += f.y + b.y; S.z += f.z + b.z; }
  return S; }
static quat randdir(int t, double a0) { double r = sqrt(fmax(0, 1 - a0 * a0)), ct = 2 * rnd(t) - 1, st = sqrt(fmax(0, 1 - ct * ct)), ph = 2 * PI * rnd(t); quat q = { a0, r * st * cos(ph), r * st * sin(ph), r * ct }; return q; }
static void hb(int t, long s, int mu) { quat S = stsum(s, mu); double k = sqrt(S.w*S.w + S.x*S.x + S.y*S.y + S.z*S.z); if (k < 1e-12) { U[s * D + mu] = randdir(t, 2 * rnd(t) - 1); return; }
  quat v = { S.w / k, S.x / k, S.y / k, S.z / k }; double al = BETA * k, a0;
  for (;;) { double r1 = rnd(t), r2 = rnd(t), r3 = rnd(t), r4 = rnd(t); double c = cos(2 * PI * r2); double X = -(log(r1) + c * c * log(r3)) / al; if (r4 * r4 <= 1 - X / 2) { a0 = 1 - X; break; } }
  U[s * D + mu] = qmul(randdir(t, a0), qinv(v)); }
static void orx(long s, int mu) { quat S = stsum(s, mu); double k = sqrt(S.w*S.w + S.x*S.x + S.y*S.y + S.z*S.z); if (k < 1e-12) return; quat v = { S.w / k, S.x / k, S.y / k, S.z / k };
  U[s * D + mu] = qmul(qmul(qinv(v), qinv(U[s * D + mu])), qinv(v)); }
static void sweep(int nor) {
  for (int mu = 0; mu < D; mu++) for (int p = 0; p < 2; p++) {
    #pragma omp parallel for schedule(static)
    for (long s = 0; s < V; s++) if (PAR[s] == p) hb(omp_get_thread_num(), s, mu); }
  for (int r = 0; r < nor; r++) for (int mu = 0; mu < D; mu++) for (int p = 0; p < 2; p++) {
    #pragma omp parallel for schedule(static)
    for (long s = 0; s < V; s++) if (PAR[s] == p) orx(s, mu); } }
static double plaq(void) { double t = 0;
  #pragma omp parallel for reduction(+:t) schedule(static)
  for (long s = 0; s < V; s++) for (int mu = 0; mu < D; mu++) for (int nu = mu + 1; nu < D; nu++) { long sm = UPT[s * D + mu], sn = UPT[s * D + nu];
    t += qmul(qmul(qmul(U[s * D + mu], U[sm * D + nu]), qinv(U[sn * D + mu])), qinv(U[s * D + nu])).w; }
  return t / (V * D * (D - 1) / 2.0); }
/* ---- representations: M_1 (spin 1/2, 2x2 complex) and M_2 (spin 1, 3x3 real stored complex) */
static int DIMR[3] = { 1, 2, 3 };
static void repm(int a, quat q, cplx *M) {
  if (a == 0) { M[0] = 1; return; }
  if (a == 1) { M[0] = q.w - I * q.z; M[1] = -q.y - I * q.x; M[2] = q.y - I * q.x; M[3] = q.w + I * q.z; return; }
  double w = q.w, x = q.x, y = q.y, z = q.z;
  M[0] = 1 - 2*(y*y + z*z); M[1] = 2*(x*y - w*z); M[2] = 2*(x*z + w*y);
  M[3] = 2*(x*y + w*z); M[4] = 1 - 2*(x*x + z*z); M[5] = 2*(y*z - w*x);
  M[6] = 2*(x*z - w*y); M[7] = 2*(y*z + w*x); M[8] = 1 - 2*(x*x + y*y); }
static void matmul(int d, const cplx *A, const cplx *B, cplx *C) { cplx T[81]; for (int i = 0; i < d; i++) for (int j = 0; j < d; j++) { cplx s = 0; for (int k = 0; k < d; k++) s += A[i * d + k] * B[k * d + j]; T[i * d + j] = s; } memcpy(C, T, sizeof(cplx) * d * d); }
static void dagger(int d, const cplx *A, cplx *B) { for (int i = 0; i < d; i++) for (int j = 0; j < d; j++) B[j * d + i] = conj(A[i * d + j]); }
/* Y_ac(g) = conj(M_a(g)) (x) M_c(g), row (i, k) = i d_c + k, column (j, l) = j d_c + l */
static void repY(int a, int c, quat q, cplx *Y) { cplx Ma[9], Mc[9]; repm(a, q, Ma); repm(c, q, Mc); int da = DIMR[a], dc = DIMR[c], n = da * dc;
  for (int i = 0; i < da; i++) for (int k = 0; k < dc; k++) for (int j = 0; j < da; j++) for (int l = 0; l < dc; l++) Y[(i * dc + k) * n + j * dc + l] = conj(Ma[i * da + j]) * Mc[k * dc + l]; }
/* the isotypic projectors of Y_ac: PROJ[a][c][K2] (K2 = twice the spin), Pi_K = d_K int chi_K(g) Y(g) dg, by an exact product rule */
static cplx PROJ[3][3][5][81];
static double chiK(int K2, double w) { double th = acos(fmax(-1, fmin(1, w))); if (fabs(sin(th)) < 1e-14) { double sgn = (w > 0) ? 1 : ((K2 % 2) ? -1 : 1); return sgn * (K2 + 1); } return sin((K2 + 1) * th) / sin(th); }
static void gauss_legendre(int n, double *x, double *w) { for (int i = 1; i <= n; i++) { double z = cos(PI * (i - 0.25) / (n + 0.5)), dp = 0;
    for (int it = 0; it < 200; it++) { double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2 * k - 1) * z * p1 - (k - 1) * p0) / k; p0 = p1; p1 = p2; } dp = n * (z * p1 - p0) / (z * z - 1); double z1 = z; z = z1 - p1 / dp; if (fabs(z - z1) < 1e-15) break; }
    double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2 * k - 1) * z * p1 - (k - 1) * p0) / k; p0 = p1; p1 = p2; } dp = n * (z * p1 - p0) / (z * z - 1); x[i - 1] = z; w[i - 1] = 2 / ((1 - z * z) * dp * dp); } }
static int build_projectors(void) { int deg = 24, nth = (deg + 2) / 2, ngl = (deg + 2) / 2, naz = deg + 1; double gx[64], gw[64]; gauss_legendre(ngl, gx, gw); int bad = 0;
  memset(PROJ, 0, sizeof PROJ);
  for (int k = 1; k <= nth; k++) { double th = k * PI / (nth + 1), wt = 2 * sin(th) * sin(th) / (nth + 1);
    for (int j = 0; j < ngl; j++) { double t = gx[j], st = sqrt(1 - t * t);
      for (int l = 0; l < naz; l++) { double ph = 2 * PI * l / naz; quat g = { cos(th), sin(th) * st * cos(ph), sin(th) * st * sin(ph), sin(th) * t }; double wq = wt * gw[j] / 2 / naz;
        for (int a = 1; a <= 2; a++) for (int c = 1; c <= 2; c++) { cplx Y[81]; repY(a, c, g, Y); int n = DIMR[a] * DIMR[c];
          for (int K2 = abs(a - c); K2 <= a + c; K2 += 2) { double f = (K2 + 1) * chiK(K2, g.w) * wq; for (int i = 0; i < n * n; i++) PROJ[a][c][K2][i] += f * Y[i]; } } } } }
  for (int a = 1; a <= 2; a++) for (int c = 1; c <= 2; c++) { int n = DIMR[a] * DIMR[c]; cplx Sum[81] = {0}; double idem = 0, comp = 0;
    for (int K2 = abs(a - c); K2 <= a + c; K2 += 2) { cplx P2[81]; matmul(n, PROJ[a][c][K2], PROJ[a][c][K2], P2); for (int i = 0; i < n * n; i++) { if (cabs(P2[i] - PROJ[a][c][K2][i]) > idem) idem = cabs(P2[i] - PROJ[a][c][K2][i]); Sum[i] += PROJ[a][c][K2][i]; }
      cplx tr = 0; for (int i = 0; i < n; i++) tr += PROJ[a][c][K2][i * n + i]; if (fabs(creal(tr) - (K2 + 1)) > 1e-10) bad++; }
    for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) { double e = cabs(Sum[i * n + j] - (i == j ? 1 : 0)); if (e > comp) comp = e; }
    printf("SU2MH-KAT projectors a=%d c=%d: idempotent to %.1e, complete to %.1e\n", a, c, idem, comp); if (idem > 1e-10 || comp > 1e-10) bad++; }
  return bad; }
/* ---- modified Bessel ratios c(m) = I_m(x)/I_1(x), m = 1..5 */
static void bratio(double x, double *c) { double In[7]; for (int m = 0; m <= 6; m++) { double t = 1, s = 0; for (int i = 1; i <= m; i++) t *= (x / 2) / i; for (int k = 0; k < 400; k++) { s += t; t *= (x / 2) * (x / 2) / ((k + 1.0) * (k + m + 1.0)); if (t < 1e-18 * s) break; } In[m] = s; }
  for (int m = 1; m <= 5; m++) c[m] = (x < 1e-300) ? (m == 1 ? 1 : 0) : In[m] / In[1]; }
/* ---- per-link data at measurement */
static cplx (*LM1)[4], (*LM2)[9], (*HM1)[4], (*HM2)[9]; static quat *VINV; static double (*CB)[6];
static void prep_links(void) {
  #pragma omp parallel for schedule(static)
  for (long s = 0; s < V; s++) for (int mu = 0; mu < D; mu++) { long l = s * D + mu; quat S = stsum(s, mu); double k = sqrt(S.w*S.w + S.x*S.x + S.y*S.y + S.z*S.z);
    quat v = { 1, 0, 0, 0 }; if (k > 1e-12) { v.w = S.w / k; v.x = S.x / k; v.y = S.y / k; v.z = S.z / k; } quat vi = qinv(v); VINV[l] = vi; bratio(BETA * k, CB[l]);
    repm(1, U[l], LM1[l]); repm(2, U[l], LM2[l]); cplx t1[4], t2[9]; repm(1, vi, t1); repm(2, vi, t2);
    for (int i = 0; i < 4; i++) HM1[l][i] = CB[l][2] * t1[i]; for (int i = 0; i < 9; i++) HM2[l][i] = CB[l][3] * t2[i]; } }
static const cplx *linkmat(int a, long l, int mh) { if (a == 1) return mh ? HM1[l] : LM1[l]; return mh ? HM2[l] : LM2[l]; }
/* E[Y_ac(U)] for an integrated shared link, or Y_ac(U) */
static void sharedY(int a, int c, long l, int mh, quat q, cplx *Y) { int n = DIMR[a] * DIMR[c];
  if (!mh) { repY(a, c, q, Y); return; }
  cplx Yv[81], Mix[81] = {0}; repY(a, c, VINV[l], Yv); for (int K2 = abs(a - c); K2 <= a + c; K2 += 2) { double ck = CB[l][K2 + 1]; for (int i = 0; i < n * n; i++) Mix[i] += ck * PROJ[a][c][K2][i]; }
  matmul(n, Mix, Yv, Y); }
/* ---- one placement: the 9 channels, PLAIN and MH */
static void placement(long s, int mu, int nu, double out[2][3][3]) {
  int n = NN; long lA[64], lB[64], lS[16]; int bA[64], bB[64], iA[64], iB[64], iS[16]; int na = 0, nb = 0;
  for (int i = 0; i < n; i++) { lA[na] = shift(s, mu, i) * D + mu; bA[na] = 0; iA[na] = 1; na++; }
  for (int i = 0; i < n; i++) { long st = shift(shift(s, mu, n), nu, i); lA[na] = st * D + nu; bA[na] = 0; iA[na] = (i >= 1 && i <= n - 2); na++; }
  for (int i = 0; i < n; i++) { long st = shift(shift(s, mu, n - 1 - i), nu, n); lA[na] = st * D + mu; bA[na] = 1; iA[na] = 1; na++; }
  for (int i = 0; i < n; i++) { long st = shift(shift(s, mu, -(i + 1)), nu, n); lB[nb] = st * D + mu; bB[nb] = 1; iB[nb] = 1; nb++; }
  for (int i = 0; i < n; i++) { int j = n - 1 - i; long st = shift(shift(s, mu, -n), nu, j); lB[nb] = st * D + nu; bB[nb] = 1; iB[nb] = (j >= 1 && j <= n - 2); nb++; }
  for (int i = 0; i < n; i++) { long st = shift(s, mu, -n + i); lB[nb] = st * D + mu; bB[nb] = 0; iB[nb] = 1; nb++; }
  for (int i = 0; i < n; i++) { lS[i] = shift(s, nu, i) * D + nu; iS[i] = (i >= 1 && i <= n - 2); }
  for (int mh = 0; mh < 2; mh++) {
    cplx PA[3][9], PB[3][9], SA[3][9];
    for (int a = 1; a <= 2; a++) { int d = DIMR[a]; cplx P[9], T[9];
      for (int i = 0; i < d * d; i++) P[i] = (i % (d + 1) == 0) ? 1 : 0;
      for (int k = 0; k < na; k++) { const cplx *M = linkmat(a, lA[k], mh && iA[k]); if (bA[k]) { dagger(d, M, T); matmul(d, P, T, P); } else matmul(d, P, M, P); }
      memcpy(PA[a], P, sizeof(cplx) * d * d);
      for (int i = 0; i < d * d; i++) P[i] = (i % (d + 1) == 0) ? 1 : 0;
      for (int k = 0; k < nb; k++) { const cplx *M = linkmat(a, lB[k], mh && iB[k]); if (bB[k]) { dagger(d, M, T); matmul(d, P, T, P); } else matmul(d, P, M, P); }
      memcpy(PB[a], P, sizeof(cplx) * d * d);
      for (int i = 0; i < d * d; i++) P[i] = (i % (d + 1) == 0) ? 1 : 0;
      for (int k = 0; k < n; k++) { const cplx *M = linkmat(a, lS[k], mh && iS[k]); matmul(d, P, M, P); }
      memcpy(SA[a], P, sizeof(cplx) * d * d); }
    out[mh][0][0] = 1;
    for (int a = 1; a <= 2; a++) { int d = DIMR[a]; cplx tA = 0, tB = 0;
      for (int i = 0; i < d; i++) for (int j = 0; j < d; j++) { tA += PA[a][i * d + j] * conj(SA[a][i * d + j]); tB += SA[a][i * d + j] * PB[a][j * d + i]; }
      out[mh][a][0] = creal(tA); out[mh][0][a] = creal(tB); }
    for (int a = 1; a <= 2; a++) for (int c = 1; c <= 2; c++) { int da = DIMR[a], dc = DIMR[c], nn = da * dc; cplx X[81], Y[81];
      for (int i = 0; i < nn * nn; i++) X[i] = (i % (nn + 1) == 0) ? 1 : 0;
      for (int k = 0; k < n; k++) { sharedY(a, c, lS[k], mh && iS[k], U[lS[k]], Y); matmul(nn, X, Y, X); }
      cplx t = 0; for (int i = 0; i < da; i++) for (int j = 0; j < da; j++) for (int k = 0; k < dc; k++) for (int l = 0; l < dc; l++) t += PA[a][i * da + j] * PB[c][l * dc + k] * X[(i * dc + k) * nn + j * dc + l];
      out[mh][a][c] = creal(t); } } }
int main(int argc, char **argv) {
  if (argc < 11) { fprintf(stderr, "usage: su2mh D L BETA n SEED NTHERM NSEP NMEAS NOR OUTFILE\n"); return 1; }
  D = atoi(argv[1]); LS = atoi(argv[2]); BETA = atof(argv[3]); NN = atoi(argv[4]); uint64_t seed = strtoull(argv[5], 0, 10); int nth = atoi(argv[6]), nsep = atoi(argv[7]), nmeas = atoi(argv[8]), nor = atoi(argv[9]);
  if (D < 2 || D > 4 || LS % 2 || NN < 2 || 2 * NN + 1 > LS) { fprintf(stderr, "need D in 2..4, L even, n >= 2, 2n + 1 <= L\n"); return 1; }
  V = 1; for (int i = 0; i < D; i++) V *= LS;
  U = malloc(sizeof(quat) * V * D); UPT = malloc(sizeof(long) * V * D); DNT = malloc(sizeof(long) * V * D); PAR = malloc(sizeof(int) * V);
  LM1 = malloc(sizeof(*LM1) * V * D); LM2 = malloc(sizeof(*LM2) * V * D); HM1 = malloc(sizeof(*HM1) * V * D); HM2 = malloc(sizeof(*HM2) * V * D); VINV = malloc(sizeof(quat) * V * D); CB = malloc(sizeof(*CB) * V * D);
  for (long s = 0; s < V; s++) { int c[4], sum = 0; coords(s, c); for (int i = 0; i < D; i++) sum += c[i]; PAR[s] = sum % 2; for (int mu = 0; mu < D; mu++) { UPT[s * D + mu] = shift(s, mu, 1); DNT[s * D + mu] = shift(s, mu, -1); quat e = {1, 0, 0, 0}; U[s * D + mu] = e; } }
  int nthr = omp_get_max_threads(); RS = calloc(8 * nthr, sizeof(uint64_t)); for (int t = 0; t < nthr; t++) RS[8 * t] = seed * 0x2545F4914F6CDD1DULL + 7919ULL * (t + 1);
  /* KATs: homomorphism and traces of M_1, M_2; projectors */
  { quat q1 = {0.5, 0.5, 0.5, 0.5}, q2 = {0.6, 0.0, 0.8, 0.0}, q3 = {cos(0.7), sin(0.7) * 0.6, 0, sin(0.7) * 0.8}; int bad = 0;
    for (int a = 1; a <= 2; a++) { int d = DIMR[a]; cplx A1[9], A2[9], A12[9], P[9]; repm(a, q1, A1); repm(a, q2, A2); repm(a, qmul(q1, q2), A12); matmul(d, A1, A2, P); for (int i = 0; i < d * d; i++) if (cabs(P[i] - A12[i]) > 1e-12) bad++;
      cplx A3[9]; repm(a, q3, A3); cplx tr = 0; for (int i = 0; i < d; i++) tr += A3[i * d + i]; if (fabs(creal(tr) - chiK(a, q3.w)) > 1e-12) bad++; }
    printf("SU2MH-KAT M_1, M_2 homomorphisms and traces [%s]\n", bad ? "FAILED" : "MET"); if (bad) return 1;
    if (build_projectors()) { printf("SU2MH-KAT projectors FAILED\n"); return 1; } }
  { double c[6]; bratio(2.2, c); printf("SU2MH a_j(beta) = I_{2j+1}/I_1 at beta=%g: a_1/2 = %.10f a_1 = %.10f a_3/2 = %.10f a_2 = %.10f\n", BETA, c[2], c[3], c[4], c[5]); bratio(BETA, c);
    printf("SU2MH at this beta: a_1/2 = %.10f a_1 = %.10f\n", c[2], c[3]); }
  FILE *fo = fopen(argv[10], "w"); if (!fo) { fprintf(stderr, "cannot open %s\n", argv[10]); return 1; }
  fprintf(fo, "# su2mh D=%d L=%d beta=%g n=%d seed=%llu ntherm=%d nsep=%d nmeas=%d nor=%d threads=%d\n", D, LS, BETA, NN, (unsigned long long)seed, nth, nsep, nmeas, nor, nthr);
  fprintf(fo, "# per configuration: k plaq, then PLAIN[a][c] for a,c in 0..2 (row-major), then MH[a][c]; averages over V*D*(D-1) placements\n");
  double t0 = omp_get_wtime();
  for (int it = 0; it < nth; it++) { sweep(nor); if (it % 50 == 0) { printf("SU2MH therm %d plaq %.6f (%.0f s)\n", it, plaq(), omp_get_wtime() - t0); fflush(stdout); } }
  long npl = V * D * (D - 1);
  for (int m = 0; m < nmeas; m++) {
    for (int it = 0; it < nsep; it++) sweep(nor);
    double pl = plaq(); prep_links();
    double acc[2][3][3] = {{{0}}};
    #pragma omp parallel
    { double loc[2][3][3] = {{{0}}};
      #pragma omp for schedule(dynamic, 64)
      for (long s = 0; s < V; s++) for (int mu = 0; mu < D; mu++) for (int nu = 0; nu < D; nu++) { if (nu == mu) continue; double o[2][3][3]; placement(s, mu, nu, o);
        for (int h = 0; h < 2; h++) for (int a = 0; a < 3; a++) for (int c = 0; c < 3; c++) loc[h][a][c] += o[h][a][c]; }
      #pragma omp critical
      for (int h = 0; h < 2; h++) for (int a = 0; a < 3; a++) for (int c = 0; c < 3; c++) acc[h][a][c] += loc[h][a][c]; }
    fprintf(fo, "%d %.10f", m, pl); for (int h = 0; h < 2; h++) for (int a = 0; a < 3; a++) for (int c = 0; c < 3; c++) fprintf(fo, " %.10e", acc[h][a][c] / npl); fprintf(fo, "\n"); fflush(fo);
    if (m % 10 == 0) { printf("SU2MH meas %d plaq %.6f MH: A1 %.4e A2 %.4e (2,1) %.4e (1,2) %.4e (%.0f s)\n", m, pl, acc[1][1][0] / npl, acc[1][2][0] / npl, acc[1][2][1] / npl, acc[1][1][2] / npl, omp_get_wtime() - t0); fflush(stdout); } }
  fclose(fo); printf("SU2MH-DONE %.1f s\n", omp_get_wtime() - t0); return 0; }
