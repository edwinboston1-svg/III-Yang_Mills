/* cei_spectrum.c -- THE SPECTRUM of a dumped transfer matrix (campaign 31.15 RESULTS 6): the whole eigenvalue list of the cell's transfer
   operator T (the file CEI_TRANSFER_OUT writes: a header `# T n x n ...` then n*n lines `re im`, row-major), by Householder reduction to
   Hessenberg form and the shifted QR iteration (Wilkinson shift from the trailing 2x2, Givens steps on the active block, an exceptional shift
   every tenth iteration), complex throughout, no library -- the textbook algorithm (Francis 1961; Golub--Van Loan 7.5), W = 0.  The Wielandt
   chain in the engine cannot converge on a non-normal T whose members come in conjugate pairs of equal modulus (the Haar data), so its
   members past the first are Rayleigh readings; this reads every eigenvalue once.  Eigenvalues sorted by modulus; the gap is |l_1|/|l_2| over
   the whole spectrum (at a Haar datum every mode is physical); the trace identity sum l_k = tr T is printed as the internal check.
   KNOWN ANSWERS (--kat): [[0,-1],[1,0]] -> +-i; [[1,2],[3,4]] -> (5 +- sqrt 33)/2; the 4-cycle -> the fourth roots of unity; the companion
   matrix of (x-1)...(x-5) -> 1..5; CONTROL: [[1,2],[-3,4]] (one entry bent) parts from the planted (5 +- sqrt 33)/2 by its complex pair.
   The engine's known answer: the ordered W2 matrix's top ten moduli must equal the chain's converged members (3.609719768774e+18;
   6.975065477680e+16 x3; 2.324414315771e+15; 8.289475025996e+14 x5), read by the shell.
   build: gcc -O2 -o cei_spectrum.exe cei_spectrum.c -lm     usage: cei_spectrum T.txt [NTOP]  |  cei_spectrum --kat */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <float.h>
#include <complex.h>
typedef double complex cplx;
static int n; static cplx *H;
#define A(i,j) H[(size_t)(i)*n+(j)]

static void hessenberg(void) {
  for (int k = 0; k + 2 < n; k++) {
    double xnorm = 0; for (int i = k + 1; i < n; i++) xnorm += creal(A(i,k)) * creal(A(i,k)) + cimag(A(i,k)) * cimag(A(i,k));
    xnorm = sqrt(xnorm); if (xnorm == 0) continue;
    cplx x0 = A(k + 1, k); double a0 = cabs(x0); cplx phase = (a0 == 0) ? 1.0 : x0 / a0;
    int m = n - k - 1; cplx *v = malloc(sizeof(cplx) * m); double vn2 = 0;
    for (int i = 0; i < m; i++) v[i] = A(k + 1 + i, k);
    v[0] += phase * xnorm;
    for (int i = 0; i < m; i++) vn2 += creal(v[i]) * creal(v[i]) + cimag(v[i]) * cimag(v[i]);
    if (vn2 == 0) { free(v); continue; }
    for (int j = k; j < n; j++) { cplx s = 0; for (int i = 0; i < m; i++) s += conj(v[i]) * A(k + 1 + i, j); s *= 2.0 / vn2; for (int i = 0; i < m; i++) A(k + 1 + i, j) -= v[i] * s; }
    for (int i = 0; i < n; i++) { cplx s = 0; for (int j = 0; j < m; j++) s += A(i, k + 1 + j) * v[j]; s *= 2.0 / vn2; for (int j = 0; j < m; j++) A(i, k + 1 + j) -= s * conj(v[j]); }
    for (int i = k + 2; i < n; i++) A(i, k) = 0;
    free(v);
  }
}
static int qr_eigs(cplx *eig) {
  int hi = n - 1, iter = 0, total = 0;
  while (hi >= 0) {
    if (hi == 0) { eig[0] = A(0,0); hi--; continue; }
    int lo = hi;
    while (lo > 0) { double s = cabs(A(lo - 1, lo - 1)) + cabs(A(lo, lo)); if (s == 0) s = 1; if (cabs(A(lo, lo - 1)) <= DBL_EPSILON * s) { A(lo, lo - 1) = 0; break; } lo--; }
    if (lo == hi) { eig[hi] = A(hi, hi); hi--; iter = 0; continue; }
    cplx a = A(hi - 1, hi - 1), b = A(hi - 1, hi), c = A(hi, hi - 1), d = A(hi, hi);
    cplx tr = a + d, det = a * d - b * c, disc = csqrt(tr * tr / 4.0 - det);
    cplx mu1 = tr / 2.0 + disc, mu2 = tr / 2.0 - disc, mu = (cabs(mu1 - d) < cabs(mu2 - d)) ? mu1 : mu2;
    iter++; total++;
    if (iter % 11 == 10) mu = d + cabs(A(hi, hi - 1)) * (0.75 + 0.5 * I);
    if (iter > 500) { fprintf(stderr, "CEI-SPECTRUM REFUSED: no convergence at hi = %d after 500 steps\n", hi); return -1; }
    for (int i = lo; i <= hi; i++) A(i, i) -= mu;
    int nb = hi - lo; cplx *gc = malloc(sizeof(cplx) * nb), *gs = malloc(sizeof(cplx) * nb);
    for (int k = lo; k < hi; k++) {
      cplx x = A(k, k), y = A(k + 1, k); double r = sqrt(cabs(x) * cabs(x) + cabs(y) * cabs(y));
      cplx cc = (r == 0) ? 1.0 : x / r, ss = (r == 0) ? 0.0 : y / r; gc[k - lo] = cc; gs[k - lo] = ss;
      for (int j = k; j <= hi; j++) { cplx p = A(k, j), q = A(k + 1, j); A(k, j) = conj(cc) * p + conj(ss) * q; A(k + 1, j) = -ss * p + cc * q; }
    }
    for (int k = lo; k < hi; k++) {
      cplx cc = gc[k - lo], ss = gs[k - lo]; int imax = (k + 1 <= hi) ? k + 1 : hi;
      for (int i = lo; i <= imax; i++) { cplx p = A(i, k), q = A(i, k + 1); A(i, k) = p * cc + q * ss; A(i, k + 1) = -p * conj(ss) + q * conj(cc); }
    }
    for (int i = lo; i <= hi; i++) A(i, i) += mu;
    free(gc); free(gs);
  }
  return total;
}
static int bymod(const void *p, const void *q) { double a = cabs(*(const cplx *)p), b = cabs(*(const cplx *)q); return (a < b) - (a > b); }
static int solve(cplx *eig, cplx *trace) { *trace = 0; for (int i = 0; i < n; i++) *trace += A(i, i); hessenberg(); int t = qr_eigs(eig); if (t < 0) return -1; qsort(eig, n, sizeof(cplx), bymod); return t; }
static int kat_case(const char *name, const double *re, const double *im, int nn, const double *wre, const double *wim, int bend) {
  n = nn; H = calloc((size_t)n * n, sizeof(cplx)); for (int i = 0; i < n * n; i++) H[i] = re[i] + im[i] * I;
  cplx *eig = malloc(sizeof(cplx) * n), tr; solve(eig, &tr);
  /* match the planted spectrum as a multiset: each planted value must be met by one computed value within 1e-12 (relative to the largest modulus) */
  double scale = 0; for (int i = 0; i < n; i++) if (cabs(eig[i]) > scale) scale = cabs(eig[i]); if (scale == 0) scale = 1;
  int *used = calloc(n, sizeof(int)), met = 0;
  for (int i = 0; i < n; i++) { cplx w = wre[i] + wim[i] * I; for (int j = 0; j < n; j++) if (!used[j] && cabs(eig[j] - w) <= 1e-12 * scale) { used[j] = 1; met++; break; } }
  printf("  KAT %-40s %d of %d planted eigenvalues met%s", name, met, n, bend ? "" : "\n");
  if (bend) printf(" -- %s\n", (met < n) ? "the bent matrix PARTS from the planted spectrum (SIGHTED)" : "the bent matrix MEETS the planted spectrum (BLIND)");
  free(H); free(eig); free(used); return bend ? (met < n) : (met == n);
}
int main(int argc, char **argv) {
  if (argc >= 2 && !strcmp(argv[1], "--kat")) {
    int ok = 0; printf("CEI-SPECTRUM KAT\n");
    { double re[4] = {0, -1, 1, 0}, im[4] = {0, 0, 0, 0}, wre[2] = {0, 0}, wim[2] = {1, -1}; ok += kat_case("[[0,-1],[1,0]] -> +-i", re, im, 2, wre, wim, 0); }
    { double re[4] = {1, 2, 3, 4}, im[4] = {0}, wre[2] = {(5 + sqrt(33.0)) / 2, (5 - sqrt(33.0)) / 2}, wim[2] = {0, 0}; ok += kat_case("[[1,2],[3,4]] -> (5 +- sqrt 33)/2", re, im, 2, wre, wim, 0); }
    { double re[16] = {0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0}, im[16] = {0}, wre[4] = {1, 0, -1, 0}, wim[4] = {0, 1, 0, -1}; ok += kat_case("the 4-cycle -> the fourth roots of unity", re, im, 4, wre, wim, 0); }
    { double re[25] = {15, -85, 225, -274, 120,  1, 0, 0, 0, 0,  0, 1, 0, 0, 0,  0, 0, 1, 0, 0,  0, 0, 0, 1, 0}, im[25] = {0}, wre[5] = {1, 2, 3, 4, 5}, wim[5] = {0}; ok += kat_case("companion of (x-1)...(x-5) -> 1..5", re, im, 5, wre, wim, 0); }
    { double re[4] = {1, 2, -3, 4}, im[4] = {0}, wre[2] = {(5 + sqrt(33.0)) / 2, (5 - sqrt(33.0)) / 2}, wim[2] = {0, 0}; ok += kat_case("CONTROL [[1,2],[-3,4]] against (5 +- sqrt 33)/2", re, im, 2, wre, wim, 1); }
    printf("CEI-SPECTRUM KAT %s: %d of 5\n", ok == 5 ? "MET" : "FAILED", ok); return ok == 5 ? 0 : 2;
  }
  if (argc < 2) { fprintf(stderr, "usage: cei_spectrum T.txt [NTOP] | --kat\n"); return 1; }
  int ntop = (argc >= 3) ? atoi(argv[2]) : 12;
  FILE *f = fopen(argv[1], "r"); if (!f) { fprintf(stderr, "CEI-SPECTRUM REFUSED: cannot open %s\n", argv[1]); return 1; }
  char head[1024]; if (!fgets(head, sizeof head, f)) return 1; int n1, n2; if (sscanf(head, "# T %d x %d", &n1, &n2) != 2 || n1 != n2 || n1 < 1) { fprintf(stderr, "CEI-SPECTRUM REFUSED: the header is not `# T n x n`: %s", head); return 1; }
  n = n1; H = malloc((size_t)n * n * sizeof(cplx)); if (!H) return 3;
  for (size_t i = 0; i < (size_t)n * n; i++) { double re, im; if (fscanf(f, "%lf %lf", &re, &im) != 2) { fprintf(stderr, "CEI-SPECTRUM REFUSED: short file at entry %zu of %zu\n", i, (size_t)n * n); return 1; } H[i] = re + im * I; }
  fclose(f);
  double amax = 0; for (size_t i = 0; i < (size_t)n * n; i++) if (cabs(H[i]) > amax) amax = cabs(H[i]);
  cplx *eig = malloc(sizeof(cplx) * n), tr; int steps = solve(eig, &tr); if (steps < 0) return 4;
  cplx sum = 0; for (int i = 0; i < n; i++) sum += eig[i];
  printf("CEI-SPECTRUM %s: n = %d, |T| max %.6e, %d QR steps; trace check |sum l - tr T| / |tr T| = %.2e\n", argv[1], n, amax, steps, cabs(sum - tr) / (cabs(tr) > 0 ? cabs(tr) : 1));
  double l1 = cabs(eig[0]);
  for (int k = 0; k < ntop && k < n; k++) printf("  l_%-3d |l| = %.12e  re %+.12e  im %+.12e  |l_1|/|l| = %.6f\n", k + 1, cabs(eig[k]), creal(eig[k]), cimag(eig[k]), l1 / cabs(eig[k]));
  if (n >= 2) printf("CEI-SPECTRUM-GAP |l_1|/|l_2| = %.6f (ln %.4f per cell); |l_1|/|l_3| = %.6f\n", l1 / cabs(eig[1]), log(l1 / cabs(eig[1])), (n >= 3) ? l1 / cabs(eig[2]) : 0.0);
  free(H); free(eig); return 0;
}
