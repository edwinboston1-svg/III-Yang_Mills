/* photon.c -- THE GAUGE-INVARIANT GAUSSIAN FIBRE OF THE 4D PHOTON (the development MF, 2026-11-02).  Abelian lattice gauge field, Gaussian
 * weight (beta/2) sum_p F_p^2 (beta drops out of every rate: the fibre covariance scales as 1/beta).  Gauge-invariant coarse data:
 *   H (the holonomy map's content): Phi_{mu nu}(Y) = the flux of F_{mu nu} through the flat L x L square at L Y in the (mu, nu) plane
 *     (= the loop integral of A around the coarse plaquette of the holonomy map, by Stokes);
 *   A (averaged): the same flux averaged over the L^2 parallel translates of the square inside the block (a 4D box average of F_{mu nu}).
 * Fine observable: F_12 at offset a = (a0, a0, a0, a0).  The fibre covariance Cov(F_12(L X + a), F_12(L Y + a) | Phi) is gauge invariant,
 * so it is computed with Feynman-gauge covariances <A_mu A_nu>(p) = delta_{mu nu}/lambda(p) (gauge-invariant correlations are the same in
 * every gauge).  Per coarse momentum K: aliases p_n, the 6-vector of coarse data, S(K) = sum_n G(p_n) <F F*>(p_n) G(p_n)^dagger (6 x 6,
 * Hermitian, rank 3 for H), conditioning by the pseudo-inverse (12 x 12 real symmetric Jacobi; eigenvalues below 1e-11 max dropped).
 * ROAD A only: the K_perp = 0 sector along direction dir, M1 half-shifted points; prints C0(D) and the rate.
 * usage: photon L map(H|A) M1 a0 dir      build: gcc -O2 -fopenmp -o photon.exe photon.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
typedef double complex cplx;
#define PI 3.14159265358979323846
static int L, AVG = 0;
static const int PL[6][2] = { {0,1}, {0,2}, {0,3}, {1,2}, {1,3}, {2,3} };
static double lam(const double *p) { double s = 0; for (int m = 0; m < 4; m++) s += 2 * (1 - cos(p[m])); return s; }
/* <F_{mu nu}(p) conj F_{rho sig}(p)> with Fhat_{mu nu} = (e^{i p_mu} - 1) A_nu - (e^{i p_nu} - 1) A_mu, <A A*> = delta / lambda */
static cplx FF(const double *p, int mu, int nu, int rho, int sig) {
  cplx e[4]; for (int m = 0; m < 4; m++) e[m] = cexp(I * p[m]) - 1;
  cplx s = 0; if (nu == sig) s += e[mu] * conj(e[rho]); if (nu == rho) s -= e[mu] * conj(e[sig]); if (mu == sig) s -= e[nu] * conj(e[rho]); if (mu == rho) s += e[nu] * conj(e[sig]);
  return s / lam(p); }
/* the coarse kernel of plane P: sum over the square (and for A, the average over the transverse translates), flux density (1/L^2) */
static cplx Gk(const double *p, int P) { int mu = PL[P][0], nu = PL[P][1]; cplx g = 1;
  for (int m = 0; m < 4; m++) { cplx s = 0; for (int z = 0; z < L; z++) s += cexp(I * p[m] * z);
    if (m == mu || m == nu) g *= s / L; else if (AVG) g *= s / L; }
  return g; }
/* 12 x 12 real symmetric Jacobi eigen-decomposition */
static void jacobi(int n, double *a, double *v, double *d) {
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) v[i * n + j] = (i == j);
  for (int sweep = 0; sweep < 100; sweep++) { double off = 0; for (int i = 0; i < n; i++) for (int j = i + 1; j < n; j++) off += a[i * n + j] * a[i * n + j];
    if (off < 1e-30) break;
    for (int p = 0; p < n; p++) for (int q = p + 1; q < n; q++) { double apq = a[p * n + q]; if (fabs(apq) < 1e-300) continue;
      double th = (a[q * n + q] - a[p * n + p]) / (2 * apq), t = (th >= 0 ? 1 : -1) / (fabs(th) + sqrt(th * th + 1)), c = 1 / sqrt(t * t + 1), s = t * c;
      for (int k = 0; k < n; k++) { double akp = a[k * n + p], akq = a[k * n + q]; a[k * n + p] = c * akp - s * akq; a[k * n + q] = s * akp + c * akq; }
      for (int k = 0; k < n; k++) { double apk = a[p * n + k], aqk = a[q * n + k]; a[p * n + k] = c * apk - s * aqk; a[q * n + k] = s * apk + c * aqk; }
      for (int k = 0; k < n; k++) { double vkp = v[k * n + p], vkq = v[k * n + q]; v[k * n + p] = c * vkp - s * vkq; v[k * n + q] = s * vkp + c * vkq; } } }
  for (int i = 0; i < n; i++) d[i] = a[i * n + i]; }
/* T(K) for the F_12 - F_12 fibre covariance at offsets a, a (one coarse momentum) */
static cplx symbol(const double *K, const int *a, int *rank) {
  long NAL = (long)L * L * L * L; cplx S[6][6] = {{0}}, u[6] = {0}; cplx R = 0;
  for (long i = 0; i < NAL; i++) { long r = i; double p[4]; for (int m = 0; m < 4; m++) { int c = (int)(r % L); r /= L; int n = c - L / 2 + 1; p[m] = (K[m] + 2 * PI * n) / L; }
    double pa = 0; for (int m = 0; m < 4; m++) pa += p[m] * a[m];
    cplx g[6]; for (int P = 0; P < 6; P++) g[P] = Gk(p, P);
    R += FF(p, 0, 1, 0, 1);
    for (int P = 0; P < 6; P++) { u[P] += cexp(I * pa) * FF(p, 0, 1, PL[P][0], PL[P][1]) * conj(g[P]);
      for (int Q = 0; Q < 6; Q++) S[P][Q] += g[P] * FF(p, PL[P][0], PL[P][1], PL[Q][0], PL[Q][1]) * conj(g[Q]); } }
  /* pseudo-inverse of the Hermitian S via the real 12 x 12 embedding [[A, -B], [B, A]] */
  double A12[144], V[144], D[12];
  for (int i = 0; i < 6; i++) for (int j = 0; j < 6; j++) { double re = creal(S[i][j]), im = cimag(S[i][j]); A12[i * 12 + j] = re; A12[(i + 6) * 12 + (j + 6)] = re; A12[i * 12 + (j + 6)] = -im; A12[(i + 6) * 12 + j] = im; }
  jacobi(12, A12, V, D); double dmax = 0; for (int k = 0; k < 12; k++) if (fabs(D[k]) > dmax) dmax = fabs(D[k]);
  /* u^dagger S^+ u: with the embedding, x = (Re u, Im u) and u^dagger S^+ u = x^T S12^+ x (each complex eigenvalue appears twice) */
  double x[12]; for (int i = 0; i < 6; i++) { x[i] = creal(u[i]); x[i + 6] = -cimag(u[i]);   /* w = conj(u): the correction is w^dagger S^+ w */ }
  double q = 0; int rk = 0; for (int k = 0; k < 12; k++) { if (fabs(D[k]) < 1e-11 * dmax) continue; rk++; double pr = 0; for (int i = 0; i < 12; i++) pr += V[i * 12 + k] * x[i]; q += pr * pr / D[k]; }
  *rank = rk / 2;
  return R - q; }
int main(int argc, char **argv) {
  if (argc < 6) { fprintf(stderr, "usage: photon L map(H|A) M1 a0 dir\n"); return 1; }
  L = atoi(argv[1]); AVG = (argv[2][0] == 'A'); int M1 = atoi(argv[3]); int a0 = atoi(argv[4]); int dir = atoi(argv[5]);
  int a[4] = { a0, a0, a0, a0 };
  int Dmax = M1 / 4; cplx *T = malloc(sizeof(cplx) * M1); int *rk = malloc(sizeof(int) * M1);
  #pragma omp parallel for schedule(dynamic)
  for (int j = 0; j < M1; j++) { double K[4] = {0}; K[dir] = -PI + 2 * PI * (j + 0.5) / M1; T[j] = symbol(K, a, &rk[j]); }
  int rmin = 99, rmax = 0; for (int j = 0; j < M1; j++) { if (rk[j] < rmin) rmin = rk[j]; if (rk[j] > rmax) rmax = rk[j]; }
  printf("PHOTON L=%d map=%s M1=%d a0=%d dir=%d rank_of_S in [%d, %d]\n", L, AVG ? "A" : "H", M1, a0, dir, rmin, rmax);
  double c[1024];
  for (int D = 0; D <= Dmax; D++) { cplx s = 0; for (int j = 0; j < M1; j++) { double Kd = -PI + 2 * PI * (j + 0.5) / M1; s += cexp(-I * Kd * D) * T[j]; } c[D] = creal(s) / (M1 * pow(L, 4)); }
  for (int D = 0; D <= Dmax; D++) printf("P L=%d %s dir=%d D=%d C0=%.15e%s\n", L, AVG ? "A" : "H", dir, D, c[D], D > 0 ? "" : "");
  /* the rate: log(|c(D1)|/|c(D2)|)/(D2 - D1), D2 the last D with |c| > 1e-11 |c(0)|, D1 = max(3, D2/2) */
  int D2 = 0; for (int D = 1; D <= Dmax; D++) { if (fabs(c[D]) > 1e-11 * fabs(c[0])) D2 = D; else break; }
  int D1 = D2 / 2; if (D1 < 3) D1 = 3;
  if (D2 > D1) printf("PHOTON-RATE L=%d map=%s dir=%d kappa=%.6f (D1=%d D2=%d) local=%.6f\n", L, AVG ? "A" : "H", dir, log(fabs(c[D1] / c[D2])) / (D2 - D1), D1, D2, log(fabs(c[D2 - 1] / c[D2])));
  else printf("PHOTON-RATE L=%d map=%s dir=%d kappa=fast (|C0| below 1e-11 by D=%d)\n", L, AVG ? "A" : "H", dir, D2 + 1);
  return 0; }
