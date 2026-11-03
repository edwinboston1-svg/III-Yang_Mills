/* photon.c -- M2c: THE PROVED U(1) CONTROL.  The free lattice photon (non-compact U(1), S = (beta/2) sum_p F_p^2, F = dA) on Z^4, massless at
 * every beta.  Gauge-invariant moments are exact in Feynman gauge: <A_mu(x) A_nu(y)> = delta_{mu nu} G(x - y)/beta, G = (-Delta)^{-1}, computed
 * as G(x) = int_0^inf prod_mu e^{-2t} I_{|x_mu|}(2t) dt (the heat-kernel form of the lattice Green's function), e^{-x} I_k(x) by Miller's
 * backward recurrence normalised by sum_k I_k = e^x (x <= 4000) and by Hankel's expansion beyond, the t-integral by the trapezoid rule in
 * u = log t with the asymptotic tail added.  KATs: G(0) = 0.1549334, G(e1) = G(0) - 1/8.
 * The coarse variables: the FLUX Phi_A = circulation of A around the n x n coarse loop (non-compact), and the HOLONOMY e^{i Phi_A} (compact,
 * the two-face construction's variable), whose joint law is a bivariate wrapped normal; its maximal correlation by Road B on a grid (the second
 * singular value of the normalised kernel), KAT: |r| at small variance.
 * THE PINNED OBJECT: a set of links integrated, every plaquette touching them kept with its other links pinned at 0 (the ordered datum; a
 * Gaussian's conditional covariance does not depend on the datum), Q = sum_p d_p d_p^T restricted to the object links, Cov = Q^{-1}/beta.
 * usage: photon kat | photon true <n> <betaV list> | photon pinned <n> <ring w> <betaV list> | photon tail <n> <betaV> | photon env <n> <w> <betaV>
 * build: gcc -O2 -fopenmp -o photon.exe photon.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define PI 3.141592653589793
#define KMAX 72
/* ---------------- the lattice Green's function ---------------- */
static int NUG = 0; static double *UT, *UW; static double (*GT)[KMAX + 1]; static double TMAXG;
static void ek_miller(double x, double *out) { /* out[k] = e^{-x} I_k(x), k = 0..KMAX */
  if (x == 0) { out[0] = 1; for (int k = 1; k <= KMAX; k++) out[k] = 0; return; }
  if (x > 4000) { for (int k = 0; k <= KMAX; k++) { double mu = 4.0 * k * k, term = 1, s = 1; for (int j = 1; j < 40; j++) { double nt = -term * (mu - (2.0 * j - 1) * (2.0 * j - 1)) / (j * 8.0 * x); if (fabs(nt) > fabs(term)) break; term = nt; s += term; if (fabs(term) < 1e-17) break; } out[k] = s / sqrt(2 * PI * x); } return; }
  int M = KMAX + 40 + (int)(14 * sqrt(x)); double *I = malloc(sizeof(double) * (M + 2)); I[M + 1] = 0; I[M] = 1e-300;
  for (int k = M; k >= 1; k--) { I[k - 1] = (2.0 * k / x) * I[k] + I[k + 1]; if (I[k - 1] > 1e250) { for (int j = k - 1; j <= M + 1; j++) I[j] *= 1e-250; } }
  double S = I[0]; for (int k = 1; k <= M; k++) S += 2 * I[k]; for (int k = 0; k <= KMAX; k++) out[k] = I[k] / S; free(I); }
static void green_init(void) { double umin = -22, umax = log(2e6), h = 0.005; NUG = (int)((umax - umin) / h) + 1; UT = malloc(sizeof(double) * NUG); UW = malloc(sizeof(double) * NUG); GT = malloc(sizeof(*GT) * NUG);
  for (int i = 0; i < NUG; i++) { double u = umin + i * h; UT[i] = exp(u); UW[i] = h * UT[i] * ((i == 0 || i == NUG - 1) ? 0.5 : 1.0); }
  #pragma omp parallel for schedule(dynamic)
  for (int i = 0; i < NUG; i++) ek_miller(2 * UT[i], GT[i]);
  TMAXG = UT[NUG - 1]; }
#define GB 73
static double *GMEMO;   /* indexed by the sorted absolute coordinates a <= b <= c <= d < GB */
static double green(const int *x) { int a[4]; for (int i = 0; i < 4; i++) a[i] = abs(x[i]); for (int i = 0; i < 4; i++) for (int j = i + 1; j < 4; j++) if (a[j] < a[i]) { int t = a[i]; a[i] = a[j]; a[j] = t; }
  if (a[3] > KMAX || a[3] >= GB) { fprintf(stderr, "green: displacement %d beyond the table\n", a[3]); exit(1); }
  size_t idx = (((size_t)a[0] * GB + a[1]) * GB + a[2]) * GB + a[3]; double v = GMEMO[idx]; if (!isnan(v)) return v;
  double s = 0; for (int i = 0; i < NUG; i++) s += UW[i] * GT[i][a[0]] * GT[i][a[1]] * GT[i][a[2]] * GT[i][a[3]];
  double T = TMAXG, sk = 0; for (int i = 0; i < 4; i++) sk += 4.0 * a[i] * a[i] - 1; s += (1.0 / (16 * PI * PI)) * (1.0 / T - sk / (32.0 * T * T));
  GMEMO[idx] = s; return s; }
/* ---------------- links, loops ---------------- */
typedef struct { int x[4]; int d; int s; } slink;
static int rect_loop(slink *L, const int *c, int mu, int nu, int nmu, int nnu) { /* counterclockwise in (mu, nu) from corner c */ int k = 0, p[4]; memcpy(p, c, sizeof p);
  for (int i = 0; i < nmu; i++) { memcpy(L[k].x, p, sizeof p); L[k].d = mu; L[k].s = 1; k++; p[mu]++; }
  for (int i = 0; i < nnu; i++) { memcpy(L[k].x, p, sizeof p); L[k].d = nu; L[k].s = 1; k++; p[nu]++; }
  for (int i = 0; i < nmu; i++) { p[mu]--; memcpy(L[k].x, p, sizeof p); L[k].d = mu; L[k].s = -1; k++; }
  for (int i = 0; i < nnu; i++) { p[nu]--; memcpy(L[k].x, p, sizeof p); L[k].d = nu; L[k].s = -1; k++; }
  return k; }
static double true_cov(const slink *A, int na, const slink *B, int nb) { double s = 0;
  for (int i = 0; i < na; i++) for (int j = 0; j < nb; j++) { if (A[i].d != B[j].d) continue; int dx[4]; for (int m = 0; m < 4; m++) dx[m] = A[i].x[m] - B[j].x[m]; s += A[i].s * B[j].s * green(dx); }
  return s; }   /* times 1/beta */
/* ---------------- the wrapped bivariate normal's maximal correlation (Road B) ---------------- */
static double wrapped_rho(double va, double vb, double c, int NG) {
  if (va < 1e-12 || vb < 1e-12) return 0; double det = va * vb - c * c; if (det <= 0) return 1;
  double *P = malloc(sizeof(double) * NG * NG), *pa = calloc(NG, sizeof(double)), *pb = calloc(NG, sizeof(double)); double dt = 2 * PI / NG;
  int MA = 2 + (int)(4 * sqrt(va) / (2 * PI)), MB = 2 + (int)(4 * sqrt(vb) / (2 * PI));
  double ia = vb / det, ib = va / det, ic = -c / det, nrm = 1.0 / (2 * PI * sqrt(det));
  #pragma omp parallel for
  for (int i = 0; i < NG; i++) { double th = -PI + (i + 0.5) * dt; for (int j = 0; j < NG; j++) { double ph = -PI + (j + 0.5) * dt, s = 0;
      for (int m = -MA; m <= MA; m++) { double u = th + 2 * PI * m; for (int mp = -MB; mp <= MB; mp++) { double v = ph + 2 * PI * mp; double q = ia * u * u + 2 * ic * u * v + ib * v * v; if (q < 1400) s += exp(-0.5 * q); } }
      P[(size_t)i * NG + j] = s * nrm; } }
  for (int i = 0; i < NG; i++) for (int j = 0; j < NG; j++) { pa[i] += P[(size_t)i * NG + j] * dt; pb[j] += P[(size_t)i * NG + j] * dt; }
  double *u = malloc(sizeof(double) * NG), *v = malloc(sizeof(double) * NG); double su = 0, sv = 0; for (int i = 0; i < NG; i++) { u[i] = sqrt(pa[i] * dt); v[i] = sqrt(pb[i] * dt); su += u[i] * u[i]; sv += v[i] * v[i]; }
  su = sqrt(su); sv = sqrt(sv); for (int i = 0; i < NG; i++) { u[i] /= su; v[i] /= sv; }
  double *K = malloc(sizeof(double) * NG * NG); for (int i = 0; i < NG; i++) for (int j = 0; j < NG; j++) K[(size_t)i * NG + j] = (pa[i] > 1e-280 && pb[j] > 1e-280) ? dt * P[(size_t)i * NG + j] / (sqrt(pa[i]) * sqrt(pb[j])) : 0;
  double s1 = 0; for (int i = 0; i < NG; i++) for (int j = 0; j < NG; j++) s1 += u[i] * K[(size_t)i * NG + j] * v[j];   /* the top singular value, 1 to the grid */
  for (int i = 0; i < NG; i++) for (int j = 0; j < NG; j++) K[(size_t)i * NG + j] -= s1 * u[i] * v[j];
  double *x = malloc(sizeof(double) * NG), *y = malloc(sizeof(double) * NG); for (int j = 0; j < NG; j++) x[j] = sin(1.3 * j + 0.2) + 0.3 * cos(4.1 * j) + 0.01 * j;
  double lam = 0, old = -1; for (int it = 0; it < 4000; it++) { for (int i = 0; i < NG; i++) { double s = 0; for (int j = 0; j < NG; j++) s += K[(size_t)i * NG + j] * x[j]; y[i] = s; }
    for (int j = 0; j < NG; j++) { double s = 0; for (int i = 0; i < NG; i++) s += K[(size_t)i * NG + j] * y[i]; x[j] = s; }
    double nn = 0; for (int j = 0; j < NG; j++) nn += x[j] * x[j]; nn = sqrt(nn); if (nn == 0) break; for (int j = 0; j < NG; j++) x[j] /= nn; lam = nn; if (it > 30 && fabs(lam - old) < 1e-15 * (lam + 1e-300)) break; old = lam; }
  free(P); free(pa); free(pb); free(u); free(v); free(K); free(x); free(y); return sqrt(lam); }
/* ---------------- the pinned object ---------------- */
#define MAXOL 8000
static int NOL = 0; static int OLX[MAXOL][4], OLD[MAXOL];
static int olink(const int *x, int d, int create) { for (int i = 0; i < NOL; i++) if (OLD[i] == d && !memcmp(OLX[i], x, sizeof(int) * 4)) return i; if (!create) return -1; if (NOL >= MAXOL) { fprintf(stderr, "too many object links\n"); exit(1); } memcpy(OLX[NOL], x, sizeof(int) * 4); OLD[NOL] = d; return NOL++; }
static void plaq_links(const int *b, int mu, int nu, int lx[4][4], int ld[4], int ls[4]) { int p[4];
  memcpy(lx[0], b, sizeof p); ld[0] = mu; ls[0] = 1;
  memcpy(p, b, sizeof p); p[mu]++; memcpy(lx[1], p, sizeof p); ld[1] = nu; ls[1] = 1;
  memcpy(p, b, sizeof p); p[nu]++; memcpy(lx[2], p, sizeof p); ld[2] = mu; ls[2] = -1;
  memcpy(lx[3], b, sizeof p); ld[3] = nu; ls[3] = -1; }
static double *QM = NULL;   /* dense NOL x NOL, then its Cholesky factor */
static void build_Q(void) { int N = NOL; QM = calloc((size_t)N * N, sizeof(double));
  /* every plaquette containing an object link, once: enumerate from each object link the 6 plaquettes, canonical key = (base, mu < nu) */
  int cap = 6 * N + 16, np = 0; int (*PK)[6] = malloc(sizeof(*PK) * cap);
  for (int l = 0; l < N; l++) { int mu = OLD[l]; for (int nu = 0; nu < 4; nu++) { if (nu == mu) continue; for (int sd = 0; sd < 2; sd++) { int b[4]; memcpy(b, OLX[l], sizeof b); if (sd) b[nu]--;
        int m1 = mu < nu ? mu : nu, m2 = mu < nu ? nu : mu; int key[6] = { b[0], b[1], b[2], b[3], m1, m2 }; int dup = 0; for (int q = 0; q < np; q++) if (!memcmp(PK[q], key, sizeof key)) { dup = 1; break; } if (!dup) { memcpy(PK[np], key, sizeof key); np++; } } } }
  for (int q = 0; q < np; q++) { int lx[4][4], ld[4], ls[4]; plaq_links(PK[q], PK[q][4], PK[q][5], lx, ld, ls); int id[4]; for (int k = 0; k < 4; k++) id[k] = olink(lx[k], ld[k], 0);
    for (int a = 0; a < 4; a++) { if (id[a] < 0) continue; for (int b2 = 0; b2 < 4; b2++) { if (id[b2] < 0) continue; QM[(size_t)id[a] * N + id[b2]] += ls[a] * ls[b2]; } } }
  free(PK);
  for (int j = 0; j < N; j++) { double d = QM[(size_t)j * N + j]; for (int k = 0; k < j; k++) d -= QM[(size_t)j * N + k] * QM[(size_t)j * N + k]; if (d <= 0) { fprintf(stderr, "Q not positive definite at %d\n", j); exit(1); } d = sqrt(d); QM[(size_t)j * N + j] = d;
    #pragma omp parallel for
    for (int i = j + 1; i < N; i++) { double s = QM[(size_t)i * N + j]; for (int k = 0; k < j; k++) s -= QM[(size_t)i * N + k] * QM[(size_t)j * N + k]; QM[(size_t)i * N + j] = s / d; } } }
static void solveQ(const double *b, double *x) { int N = NOL; double *y = malloc(sizeof(double) * N);
  for (int i = 0; i < N; i++) { double s = b[i]; for (int k = 0; k < i; k++) s -= QM[(size_t)i * N + k] * y[k]; y[i] = s / QM[(size_t)i * N + i]; }
  for (int i = N - 1; i >= 0; i--) { double s = y[i]; for (int k = i + 1; k < N; k++) s -= QM[(size_t)k * N + i] * x[k]; x[i] = s / QM[(size_t)i * N + i]; } free(y); }
static void loop_vec(const slink *L, int nl, double *c) { for (int i = 0; i < NOL; i++) c[i] = 0; for (int k = 0; k < nl; k++) { int id = olink(L[k].x, L[k].d, 0); if (id < 0) { fprintf(stderr, "a loop link is not an object link\n"); exit(1); } c[id] += L[k].s; } }
static double dot(const double *a, const double *b) { double s = 0; for (int i = 0; i < NOL; i++) s += a[i] * b[i]; return s; }
static void add_plane_region(int x0, int x1, int y0, int y1, int mu, int nu) { /* all links of the plaquettes [x0,x1) x [y0,y1) in plane (mu, nu) at the origin */
  for (int i = x0; i < x1; i++) for (int j = y0; j < y1; j++) { int b[4] = { 0, 0, 0, 0 }; b[mu] = i; b[nu] = j; int lx[4][4], ld[4], ls[4]; plaq_links(b, mu, nu, lx, ld, ls); for (int k = 0; k < 4; k++) olink(lx[k], ld[k], 1); } }
static void report(const char *tag, int n, double va, double vb, double cab, const double *betas, int nb) {
  double r = cab / sqrt(va * vb); printf("PHOTON-%s n=%d  beta*Var(A)=%.9f beta*Var(B)=%.9f beta*Cov=%.9f  non-compact r=%.9f", tag, n, va, vb, cab, r);
  for (int k = 0; k < nb; k++) { double b = betas[k]; double rw = wrapped_rho(va / b, vb / b, cab / b, (va / b < 0.4) ? 512 : 256); printf("  [betaV=%g: sigma2=%.4f rho_wr=%.6e]", b, va / b, rw); } printf("\n"); }
int main(int argc, char **argv) {
  if (argc < 2) { fprintf(stderr, "usage: photon kat | true n betas | pinned n w betas | tail n betaV\n"); return 1; }
  green_init(); size_t gsz = (size_t)GB * GB * GB * GB; GMEMO = malloc(sizeof(double) * gsz); for (size_t i = 0; i < gsz; i++) GMEMO[i] = NAN;
  if (!strcmp(argv[1], "kat")) { int z[4] = { 0, 0, 0, 0 }, e[4] = { 1, 0, 0, 0 }, e2[4] = { 1, 1, 0, 0 }; double g0 = green(z), g1 = green(e);
    printf("PHOTON-KAT G(0) = %.10f (known 0.1549334) ; G(e1) = %.10f, G(0) - G(e1) = %.10f (1/8 = 0.125) ; G(1,1,0,0) = %.10f\n", g0, g1, g0 - g1, green(e2));
    /* the lattice Laplace identity at a second site: 8 G(e1) - sum of G at the eight neighbours of e1 = 0 */
    int nb[8][4] = { {2,0,0,0}, {0,0,0,0}, {1,1,0,0}, {1,-1,0,0}, {1,0,1,0}, {1,0,-1,0}, {1,0,0,1}, {1,0,0,-1} }; double s = 8 * g1; for (int k = 0; k < 8; k++) s -= green(nb[k]); printf("PHOTON-KAT (-Delta G)(e1) = %.3e (should be 0)\n", s);
    { int far[4] = { 20, 0, 0, 0 }; double ga = green(far); printf("PHOTON-KAT G(20 e1) = %.6e against the continuum 1/(4 pi^2 r^2) = %.6e\n", ga, 1 / (4 * PI * PI * 400.0)); }
    double rws = wrapped_rho(0.01, 0.01, 0.003, 512), rwl = wrapped_rho(9, 9, 2.25, 256); printf("PHOTON-KAT wrapped: sigma2 = 0.01, r = 0.3 -> rho = %.6f ; sigma2 = 9, r = 0.25 -> rho = %.6e against e^{-sigma2 (1-r)} (e^{c} - 1) e^{-sigma2} / e^{...}: e^{-9}(e^{2.25}-1) = %.6e\n", rws, rwl, exp(-9) * (exp(2.25) - 1)); return 0; }
  if (!strcmp(argv[1], "true")) { int n = atoi(argv[2]); double betas[16]; int nb = 0; for (int i = 3; i < argc && nb < 16; i++) betas[nb++] = atof(argv[i]);
    slink A[4 * KMAX], B[4 * KMAX]; int o[4] = { 0, 0, 0, 0 };
    int na = rect_loop(A, o, 0, 1, n, n); double va = true_cov(A, na, A, na);
    int om[4] = { -n, 0, 0, 0 }; int nbp = rect_loop(B, om, 0, 1, n, n); double cp = true_cov(A, na, B, nbp); report("TRUE-PLANAR", n, va, va, cp, betas, nb);
    /* bent: B in the (1,2) plane (y, z) at x = 0, sharing A's edge x = 0, y in [0, n] */
    int nbb = rect_loop(B, o, 1, 2, n, n); double cb = true_cov(A, na, B, nbb); report("TRUE-BENT", n, va, va, cb, betas, nb);
    printf("PHOTON-ROW-TRUE n=%d non-compact edge-adjacent row 4|r_pl| + 16|r_bent| = %.6f\n", n, 4 * fabs(cp / va) + 16 * fabs(cb / va));
    for (int k = 0; k < nb; k++) { double b = betas[k]; double rp = wrapped_rho(va / b, va / b, cp / b, (va / b < 0.4) ? 512 : 256), rb = wrapped_rho(va / b, va / b, cb / b, (va / b < 0.4) ? 512 : 256);
      printf("PHOTON-ROW-TRUE n=%d betaV=%g compact edge-adjacent row 4 rho_pl + 16 rho_bent = %.6e (rho_pl %.4e, rho_bent %.4e, sigma2 %.4f)\n", n, b, 4 * rp + 16 * rb, rp, rb, va / b); }
    return 0; }
  /* M2c 10:4x THE AVERAGED COARSE LOOP: Phibar_A = (1/n^2) sum over the n^2 translates of the n x n loop in its two transverse directions within
     the block (each translate gauge invariant; translates of one loop share no link).  Var and the edge-adjacent covariances by translation
     invariance: sum over the transverse offset delta of (n - |d1|)(n - |d2|) Cov(Phi_0, Phi_delta) / n^4.  Planar neighbour: the loop shifted -n
     in x, averaged over the same transverse (z, w) plane.  Bent neighbour: the loop in the (y, z) plane at x = 0 averaged over its own transverse
     (x, w) translates t_x in [0, n) (inside the block x in [0, n)) and t_w; A averaged over (t_z, t_w). */
  if (!strcmp(argv[1], "avg")) { int n = atoi(argv[2]); double betas[16]; int nb = 0; for (int i = 3; i < argc && nb < 16; i++) betas[nb++] = atof(argv[i]);
    slink A[4 * KMAX], B[4 * KMAX]; double vA = 0, cP = 0, cB = 0;
    for (int d1 = -(n - 1); d1 <= n - 1; d1++) for (int d2 = -(n - 1); d2 <= n - 1; d2++) { double wgt = (double)(n - abs(d1)) * (n - abs(d2)) / ((double)n * n * n * n);
      int o[4] = { 0, 0, 0, 0 }, od[4] = { 0, 0, d1, d2 }, om[4] = { -n, 0, d1, d2 }; int na = rect_loop(A, o, 0, 1, n, n), nbv = rect_loop(B, od, 0, 1, n, n); vA += wgt * true_cov(A, na, B, nbv);
      nbv = rect_loop(B, om, 0, 1, n, n); cP += wgt * true_cov(A, na, B, nbv); }
    /* bent: A's translate (tz, tw), B's translate (tx, tw'); B at x = tx in the (1,2) plane from (tx, 0, 0, tw') */
    for (int tz = 0; tz < n; tz++) for (int tw = 0; tw < n; tw++) for (int tx = 0; tx < n; tx++) for (int tw2 = 0; tw2 < n; tw2++) {
      int oa[4] = { 0, 0, tz, tw }, ob[4] = { tx, 0, 0, tw2 }; int na = rect_loop(A, oa, 0, 1, n, n), nbv = rect_loop(B, ob, 1, 2, n, n); cB += true_cov(A, na, B, nbv) / ((double)n * n * n * n); }
    double rP = cP / vA, rB = cB / vA; printf("PHOTON-AVG n=%d beta*Var(Phibar)=%.9f  r_planar=%.6f r_bent=%.6f  flux row 4|r_pl|+16|r_bent| = %.6f\n", n, vA, rP, rB, 4 * fabs(rP) + 16 * fabs(rB));
    for (int k = 0; k < nb; k++) { double b = betas[k]; double rp = wrapped_rho(vA / b, vA / b, cP / b, (vA / b < 0.4) ? 512 : 256), rb = wrapped_rho(vA / b, vA / b, cB / b, (vA / b < 0.4) ? 512 : 256);
      printf("PHOTON-AVG n=%d betaV=%g sigma2=%.5f compact rho_pl=%.6e rho_bent=%.6e compact row = %.6f   [path-holonomy beta_eff = beta/(2 beta Var): averaged %.4f]\n", n, b, vA / b, rp, rb, 4 * rp + 16 * rb, 1 / (2 * vA / b)); }
    return 0; }
  if (!strcmp(argv[1], "tail")) { int n = atoi(argv[2]); double b = atof(argv[3]); slink A[4 * KMAX], B[4 * KMAX]; int o[4] = { 0, 0, 0, 0 }; int na = rect_loop(A, o, 0, 1, n, n); double va = true_cov(A, na, A, na);
    for (int R = n; R <= 4 * n && R <= KMAX - n; R += n) { int oz[4] = { 0, 0, R, 0 }; int nb2 = rect_loop(B, oz, 0, 1, n, n); double c = true_cov(A, na, B, nb2);
      printf("PHOTON-TAIL n=%d parallel loop displaced %d in z: r = %.6e (R^4 r = %.4e), compact rho_wr(betaV=%g) = %.4e\n", n, R, c / va, pow(R, 4) * c / va, b, wrapped_rho(va / b, va / b, c / b, 256)); }
    return 0; }
  if (!strcmp(argv[1], "pinned")) { int n = atoi(argv[2]), w = atoi(argv[3]); double betas[16]; int nb = 0; for (int i = 4; i < argc && nb < 16; i++) betas[nb++] = atof(argv[i]);
    add_plane_region(-n - w, n + w, -w, n + w, 0, 1);   /* the planar pair's rectangle [-n, n) x [0, n) and a ring of width w, all in the (0,1) plane */
    build_Q(); slink A[4 * KMAX], B[4 * KMAX]; int o[4] = { 0, 0, 0, 0 }, om[4] = { -n, 0, 0, 0 }; int na = rect_loop(A, o, 0, 1, n, n), nbp = rect_loop(B, om, 0, 1, n, n);
    double *ca = malloc(sizeof(double) * NOL), *cb = malloc(sizeof(double) * NOL), *xa = malloc(sizeof(double) * NOL); loop_vec(A, na, ca); loop_vec(B, nbp, cb); solveQ(ca, xa);
    double va = dot(ca, xa), cab = dot(cb, xa); double *xb = malloc(sizeof(double) * NOL); solveQ(cb, xb); double vb = dot(cb, xb);
    char tag[64]; snprintf(tag, sizeof tag, "PINNED-PLANAR-w%d", w); printf("PHOTON-PINNED n=%d ring w=%d: %d object links\n", n, w, NOL); report(tag, n, va, vb, cab, betas, nb); return 0; }
  if (!strcmp(argv[1], "pinnedbent")) { int n = atoi(argv[2]); double betas[16]; int nb = 0; for (int i = 3; i < argc && nb < 16; i++) betas[nb++] = atof(argv[i]);
    add_plane_region(0, n, 0, n, 0, 1); add_plane_region(0, n, 0, n, 1, 2);   /* face A in (0,1), face B in (1,2) at x = 0; every touching plaquette kept (the corners included) */
    build_Q(); slink A[4 * KMAX], B[4 * KMAX]; int o[4] = { 0, 0, 0, 0 }; int na = rect_loop(A, o, 0, 1, n, n), nbb = rect_loop(B, o, 1, 2, n, n);
    double *ca = malloc(sizeof(double) * NOL), *cb = malloc(sizeof(double) * NOL), *xa = malloc(sizeof(double) * NOL), *xb = malloc(sizeof(double) * NOL); loop_vec(A, na, ca); loop_vec(B, nbb, cb); solveQ(ca, xa); solveQ(cb, xb);
    printf("PHOTON-PINNED-BENT n=%d: %d object links\n", n, NOL); report("PINNED-BENT", n, dot(ca, xa), dot(cb, xb), dot(cb, xa), betas, nb); return 0; }
  fprintf(stderr, "unknown mode\n"); return 1; }
