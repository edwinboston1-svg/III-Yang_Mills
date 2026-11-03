/* eigcheck.c -- THE SECOND ROAD TO THE GAP NUMBERS (the author, 2026-11-03 01:3x EST): the whole spectrum of a dumped
   transfer matrix ("# T n x n (row-major; re im)", then n*n lines "re im") by the complex Hessenberg QR algorithm -- Householder reduction,
   Francis single-shift steps with Wilkinson's shift, deflation on a small subdiagonal -- sharing no line with cei_spectrum.c; the
   eigenvalues sorted by modulus, the trace identity checked, |l_1|/|l_2| and |l_1|/|l_3| printed, and the two leading eigenvalues
   re-verified by inverse iteration at themselves (a complex LU with partial pivoting; the residual |T v - l v| / |v| printed).
   USAGE: eigcheck <dump> [name]  ->  EIG name l_1 re im  l_2 re im  l_3 re im  gap12 gap13 trace-defect residual-1 residual-2 iters */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <io.h>
#include <fcntl.h>
#include <complex.h>
typedef double complex C;
static int n; static C *H, *T;
#define A(i,j) H[(size_t)(i)*n + (j)]
#define TT(i,j) T[(size_t)(i)*n + (j)]

static void hessenberg(void) {   /* Householder reduction to upper Hessenberg, in place */
  for (int k = 0; k < n - 2; k++) { double alpha = 0; for (int i = k + 1; i < n; i++) alpha += cabs(A(i,k)) * cabs(A(i,k)); alpha = sqrt(alpha); if (alpha < 1e-300) continue;
    C x0 = A(k+1,k); C ph = (cabs(x0) > 0) ? x0 / cabs(x0) : 1; C *v = malloc(sizeof(C) * n); for (int i = 0; i < n; i++) v[i] = 0;
    v[k+1] = x0 + ph * alpha; for (int i = k + 2; i < n; i++) v[i] = A(i,k); double vn = 0; for (int i = k + 1; i < n; i++) vn += cabs(v[i]) * cabs(v[i]); if (vn < 1e-300) { free(v); continue; }
    /* H <- (I - 2 v v^H / vn) H (I - 2 v v^H / vn) */
    for (int j = 0; j < n; j++) { C s = 0; for (int i = k + 1; i < n; i++) s += conj(v[i]) * A(i,j); s *= 2 / vn; for (int i = k + 1; i < n; i++) A(i,j) -= v[i] * s; }
    for (int i = 0; i < n; i++) { C s = 0; for (int j = k + 1; j < n; j++) s += A(i,j) * v[j]; s *= 2 / vn; for (int j = k + 1; j < n; j++) A(i,j) -= s * conj(v[j]); }
    for (int i = k + 2; i < n; i++) A(i,k) = 0; free(v); } }

static void givens(C x, C y, double *c, C *s) { double r = sqrt(cabs(x)*cabs(x) + cabs(y)*cabs(y)); if (r < 1e-300) { *c = 1; *s = 0; return; }
  if (cabs(x) < 1e-300) { *c = 0; *s = 1; return; } *c = cabs(x) / r; *s = (x / cabs(x)) * conj(y) / r; }
/* rows k, k+1 from column j0 to hi; then columns k, k+1 from row lo to min(k+2, hi) */
static void rot(int k, double c, C s, int lo, int hi, int j0) {
  for (int j = j0; j <= hi; j++) { C a = A(k,j), b = A(k+1,j); A(k,j) = c * a + s * b; A(k+1,j) = -conj(s) * a + c * b; }
  int rmax = k + 2 < hi ? k + 2 : hi; for (int i = lo; i <= rmax; i++) { C a = A(i,k), b = A(i,k+1); A(i,k) = c * a + conj(s) * b; A(i,k+1) = -s * a + c * b; } }

static int qr_eigen(C *ev, int *iters) {   /* the Schur form's diagonal; returns 0, or 1 if a block failed to converge */
  int hi = n - 1, lo, it = 0, total = 0; double fro = 0; for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) fro += cabs(A(i,j)) * cabs(A(i,j)); fro = sqrt(fro);
  while (hi >= 0) {
    if (hi == 0) { ev[0] = A(0,0); break; }
    /* deflate: find the active block [lo, hi] -- a subdiagonal small against its neighbours OR against the whole matrix (the ordered
       datum's entries span 1e-7 .. 7e17, so an eigenvalue below the norm's roundoff floor is zero to this instrument and said so) */
    for (lo = hi; lo > 0; lo--) { double sd = cabs(A(lo,lo-1)), dg = cabs(A(lo,lo)) + cabs(A(lo-1,lo-1)); if (sd <= 1e-15 * (dg > 1e-300 ? dg : 1e-300) || sd <= 1e-17 * fro) { A(lo,lo-1) = 0; break; } }
    if (lo == hi) { ev[hi] = A(hi,hi); hi--; it = 0; continue; }
    if (++it > 1000) return 1; total++;
    /* Wilkinson's shift from the trailing 2 x 2 of the active block */
    C a = A(hi-1,hi-1), b = A(hi-1,hi), c = A(hi,hi-1), d = A(hi,hi); C tr = a + d, det = a*d - b*c; C disc = csqrt(tr*tr/4 - det); C m1 = tr/2 + disc, m2 = tr/2 - disc;
    C mu = (cabs(m1 - d) < cabs(m2 - d)) ? m1 : m2; if (it % 11 == 10) mu = cabs(A(hi,hi-1)) + cabs(A(hi-1,hi-2 >= lo ? hi-2 : lo));   /* an exceptional shift */
    /* Francis single-shift step on [lo, hi] */
    double cs; C sn; givens(A(lo,lo) - mu, A(lo+1,lo), &cs, &sn); rot(lo, cs, sn, lo, hi, lo);
    for (int k = lo + 1; k < hi; k++) { givens(A(k,k-1), A(k+1,k-1), &cs, &sn); rot(k, cs, sn, lo, hi, k - 1); A(k+1,k-1) = 0; } }
  *iters = total; return 0; }

/* inverse iteration at the shift sigma on the ORIGINAL matrix: returns the Rayleigh quotient and the residual */
static C invit(C sigma, double *resid) { C *M = malloc(sizeof(C) * n * n); int *piv = malloc(sizeof(int) * n); for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) M[(size_t)i*n+j] = TT(i,j) - (i == j ? sigma : 0);
  for (int k = 0; k < n; k++) { int p = k; double mx = cabs(M[(size_t)k*n+k]); for (int i = k + 1; i < n; i++) if (cabs(M[(size_t)i*n+k]) > mx) { mx = cabs(M[(size_t)i*n+k]); p = i; } piv[k] = p;
    if (p != k) for (int j = 0; j < n; j++) { C t = M[(size_t)k*n+j]; M[(size_t)k*n+j] = M[(size_t)p*n+j]; M[(size_t)p*n+j] = t; }
    C pv = M[(size_t)k*n+k]; if (cabs(pv) < 1e-300) pv = M[(size_t)k*n+k] = 1e-300;
    for (int i = k + 1; i < n; i++) { C f = M[(size_t)i*n+k] / pv; M[(size_t)i*n+k] = f; for (int j = k + 1; j < n; j++) M[(size_t)i*n+j] -= f * M[(size_t)k*n+j]; } }
  C *v = malloc(sizeof(C) * n), *w = malloc(sizeof(C) * n); for (int i = 0; i < n; i++) v[i] = 1.0 / (1 + i) + 0.3 * I / (2 + i);
  for (int step = 0; step < 12; step++) { for (int i = 0; i < n; i++) w[i] = v[i];
    /* the permutation FIRST, then L (the first draft interleaved the swaps with the elimination, pairing a right-hand side with another
       row's multiplier -- caught by certspec.c's KAT on 2026-11-03 02:0x; corrected here and the record re-run, dated) */
    for (int k = 0; k < n; k++) { int p = piv[k]; if (p != k) { C t = w[k]; w[k] = w[p]; w[p] = t; } }
    for (int k = 0; k < n; k++) for (int i = k + 1; i < n; i++) w[i] -= M[(size_t)i*n+k] * w[k];
    for (int i = n - 1; i >= 0; i--) { for (int j = i + 1; j < n; j++) w[i] -= M[(size_t)i*n+j] * w[j]; w[i] /= M[(size_t)i*n+i]; }
    double nn = 0; for (int i = 0; i < n; i++) nn += cabs(w[i]) * cabs(w[i]); nn = sqrt(nn); for (int i = 0; i < n; i++) v[i] = w[i] / nn; }
  C num = 0; double den = 0; for (int i = 0; i < n; i++) { C tv = 0; for (int j = 0; j < n; j++) tv += TT(i,j) * v[j]; w[i] = tv; num += conj(v[i]) * tv; den += cabs(v[i]) * cabs(v[i]); }
  C lam = num / den; double r = 0; for (int i = 0; i < n; i++) r += cabs(w[i] - lam * v[i]) * cabs(w[i] - lam * v[i]); *resid = sqrt(r);
  free(M); free(piv); free(v); free(w); return lam; }

static int cmpmod(const void *a, const void *b) { double x = cabs(*(const C *)a), y = cabs(*(const C *)b); return (x < y) - (x > y); }
int main(int argc, char **argv) { _setmode(_fileno(stdout), _O_BINARY);   /* LF on this host: the records are fixtures (the house law: strip at the source) */
  if (argc < 2) { fprintf(stderr, "usage: eigcheck <dump> [name]\n"); return 2; }
  const char *name = argc > 2 ? argv[2] : argv[1];
  FILE *f = fopen(argv[1], "r"); if (!f) { printf("EIG %s REFUSED no-file\n", name); return 2; }
  char head[1024]; if (!fgets(head, sizeof head, f)) { printf("EIG %s REFUSED no-header\n", name); return 2; }
  int n1, n2; if (sscanf(head, "# T %d x %d", &n1, &n2) != 2 || n1 != n2 || n1 < 2 || n1 > 4096) { printf("EIG %s REFUSED header [%s]\n", name, head); return 2; }
  n = n1; H = malloc(sizeof(C) * n * n); T = malloc(sizeof(C) * n * n);
  for (size_t i = 0; i < (size_t)n * n; i++) { double re, im; if (fscanf(f, "%lf %lf", &re, &im) != 2) { printf("EIG %s REFUSED short at %zu\n", name, i); return 2; } T[i] = re + im * I; H[i] = T[i]; }
  fclose(f);
  C trace = 0; for (int i = 0; i < n; i++) trace += TT(i,i);
  hessenberg(); C *ev = malloc(sizeof(C) * n); int iters = 0; int bad = qr_eigen(ev, &iters);
  if (bad) { printf("EIG %s REFUSED no-convergence\n", name); return 3; }
  qsort(ev, n, sizeof(C), cmpmod); C esum = 0; for (int i = 0; i < n; i++) esum += ev[i];
  double r1, r2; C l1 = invit(ev[0], &r1), l2 = invit(ev[1], &r2);
  printf("EIG %s n=%d l_1 %.12e %+.12e  l_2 %.12e %+.12e  l_3 %.12e %+.12e  gap12 %.6f gap13 %.6f  trace-defect %.2e  invit-1 %.12e %+.12e resid %.1e  invit-2 %.12e %+.12e resid %.1e  qr-steps %d\n",
    name, n, creal(ev[0]), cimag(ev[0]), creal(ev[1]), cimag(ev[1]), creal(ev[2]), cimag(ev[2]), cabs(ev[0]) / cabs(ev[1]), cabs(ev[0]) / cabs(ev[2]), cabs(esum - trace) / (cabs(trace) > 0 ? cabs(trace) : 1),
    creal(l1), cimag(l1), r1 / cabs(l1), creal(l2), cimag(l2), r2 / cabs(l2), iters);
  return 0; }
