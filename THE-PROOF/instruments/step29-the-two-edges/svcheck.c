/* svcheck.c -- THE SINGULAR VALUES OF A DUMPED TRANSFER MATRIX (the author, 2026-11-03 02:4x EST; the author's (v) as it
   set it: sigma_1/sigma_2 of the dump is an invariant of the datum under the whole residual gauge group, where the eigenvalue gap is
   invariant under its periodic subgroup only).  M = T^H T is Hermitian positive; its eigenvalues are the squared singular values, read by
   the same complex Hessenberg QR as eigcheck.c (Householder, Francis single shift, Wilkinson's shift, deflation against the neighbours or
   the norm) -- on a Hermitian matrix the Hessenberg form is tridiagonal and the shifts real; the trace identity tr M = |T|_F^2 checked.
   USAGE: svcheck <dump> [name] -> SV name n sigma_1 sigma_2 sigma_3 s1/s2 s1/s3 trace-defect */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
#include <io.h>
#include <fcntl.h>
typedef double complex C;
static int n; static C *H;
#define A(i,j) H[(size_t)(i)*n + (j)]
static void hessenberg(void) {
  for (int k = 0; k < n - 2; k++) { double alpha = 0; for (int i = k + 1; i < n; i++) alpha += cabs(A(i,k)) * cabs(A(i,k)); alpha = sqrt(alpha); if (alpha < 1e-300) continue;
    C x0 = A(k+1,k); C ph = (cabs(x0) > 0) ? x0 / cabs(x0) : 1; C *v = malloc(sizeof(C) * n); for (int i = 0; i < n; i++) v[i] = 0;
    v[k+1] = x0 + ph * alpha; for (int i = k + 2; i < n; i++) v[i] = A(i,k); double vn = 0; for (int i = k + 1; i < n; i++) vn += cabs(v[i]) * cabs(v[i]); if (vn < 1e-300) { free(v); continue; }
    for (int j = 0; j < n; j++) { C s = 0; for (int i = k + 1; i < n; i++) s += conj(v[i]) * A(i,j); s *= 2 / vn; for (int i = k + 1; i < n; i++) A(i,j) -= v[i] * s; }
    for (int i = 0; i < n; i++) { C s = 0; for (int j = k + 1; j < n; j++) s += A(i,j) * v[j]; s *= 2 / vn; for (int j = k + 1; j < n; j++) A(i,j) -= s * conj(v[j]); }
    for (int i = k + 2; i < n; i++) A(i,k) = 0; free(v); } }
static void givens(C x, C y, double *c, C *s) { double r = sqrt(cabs(x)*cabs(x) + cabs(y)*cabs(y)); if (r < 1e-300) { *c = 1; *s = 0; return; }
  if (cabs(x) < 1e-300) { *c = 0; *s = 1; return; } *c = cabs(x) / r; *s = (x / cabs(x)) * conj(y) / r; }
static void rot(int k, double c, C s, int lo, int hi, int j0) {
  for (int j = j0; j <= hi; j++) { C a = A(k,j), b = A(k+1,j); A(k,j) = c * a + s * b; A(k+1,j) = -conj(s) * a + c * b; }
  int rmax = k + 2 < hi ? k + 2 : hi; for (int i = lo; i <= rmax; i++) { C a = A(i,k), b = A(i,k+1); A(i,k) = c * a + conj(s) * b; A(i,k+1) = -s * a + c * b; } }
static int qr_eigen(C *ev) { int hi = n - 1, lo, it = 0; double fro = 0; for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) fro += cabs(A(i,j)) * cabs(A(i,j)); fro = sqrt(fro);
  while (hi >= 0) { if (hi == 0) { ev[0] = A(0,0); break; }
    for (lo = hi; lo > 0; lo--) { double sd = cabs(A(lo,lo-1)), dg = cabs(A(lo,lo)) + cabs(A(lo-1,lo-1)); if (sd <= 1e-15 * (dg > 1e-300 ? dg : 1e-300) || sd <= 1e-17 * fro) { A(lo,lo-1) = 0; break; } }
    if (lo == hi) { ev[hi] = A(hi,hi); hi--; it = 0; continue; }
    if (++it > 1000) return 1;
    C a = A(hi-1,hi-1), b = A(hi-1,hi), c = A(hi,hi-1), d = A(hi,hi); C tr = a + d, det = a*d - b*c; C disc = csqrt(tr*tr/4 - det); C m1 = tr/2 + disc, m2 = tr/2 - disc;
    C mu = (cabs(m1 - d) < cabs(m2 - d)) ? m1 : m2; if (it % 11 == 10) mu = cabs(A(hi,hi-1)) + cabs(A(hi-1,hi-2 >= lo ? hi-2 : lo));
    double cs; C sn; givens(A(lo,lo) - mu, A(lo+1,lo), &cs, &sn); rot(lo, cs, sn, lo, hi, lo);
    for (int k = lo + 1; k < hi; k++) { givens(A(k,k-1), A(k+1,k-1), &cs, &sn); rot(k, cs, sn, lo, hi, k - 1); A(k+1,k-1) = 0; } }
  return 0; }
static int cmpd(const void *a, const void *b) { double x = creal(*(const C *)a), y = creal(*(const C *)b); return (x < y) - (x > y); }
int main(int argc, char **argv) { _setmode(_fileno(stdout), _O_BINARY);
  if (argc < 2) { fprintf(stderr, "usage: svcheck <dump> [name]\n"); return 2; }
  const char *name = argc > 2 ? argv[2] : argv[1];
  FILE *f = fopen(argv[1], "r"); if (!f) { printf("SV %s REFUSED no-file\n", name); return 2; }
  char head[1024]; if (!fgets(head, sizeof head, f)) return 2; int n1, n2; if (sscanf(head, "# T %d x %d", &n1, &n2) != 2 || n1 != n2 || n1 < 2) { printf("SV %s REFUSED header\n", name); return 2; }
  n = n1; C *T = malloc(sizeof(C) * n * n); for (size_t i = 0; i < (size_t)n * n; i++) { double re, im; if (fscanf(f, "%lf %lf", &re, &im) != 2) { printf("SV %s REFUSED short\n", name); return 2; } T[i] = re + im * I; }
  fclose(f);
  /* M = T^H T, scaled by |T|_F^2 so that the eigenvalues lie in [0, 1] (the ordered dump spans 1e-7..7e17) */
  double fro2 = 0; for (size_t i = 0; i < (size_t)n * n; i++) fro2 += cabs(T[i]) * cabs(T[i]);
  H = malloc(sizeof(C) * n * n); for (int i = 0; i < n; i++) for (int j = i; j < n; j++) { C s = 0; for (int k = 0; k < n; k++) s += conj(T[(size_t)k*n+i]) * T[(size_t)k*n+j]; s /= fro2; A(i,j) = s; A(j,i) = conj(s); }
  double tr = 0; for (int i = 0; i < n; i++) tr += creal(A(i,i));
  hessenberg(); C *ev = malloc(sizeof(C) * n); if (qr_eigen(ev)) { printf("SV %s REFUSED no-convergence\n", name); return 3; }
  qsort(ev, n, sizeof(C), cmpd); double esum = 0, imx = 0; for (int i = 0; i < n; i++) { esum += creal(ev[i]); if (fabs(cimag(ev[i])) > imx) imx = fabs(cimag(ev[i])); }
  double s1 = sqrt(fmax(creal(ev[0]), 0) * fro2), s2 = sqrt(fmax(creal(ev[1]), 0) * fro2), s3 = sqrt(fmax(creal(ev[2]), 0) * fro2);
  printf("SV %s n=%d sigma_1 %.12e sigma_2 %.12e sigma_3 %.12e s1/s2 %.9f s1/s3 %.9f trace-defect %.2e max-imag %.1e (|T|_F^2 %.6e)\n", name, n, s1, s2, s3, s1 / s2, s1 / s3, fabs(esum - tr) / (tr > 0 ? tr : 1), imx, fro2);
  return 0; }
