/* inv_test.c -- the LU inverse of eig_cert.c checked on random matrices at the development's scale: max |R J - I| row sum */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
typedef double complex cplx;
static cplx *cmat(int r, int c) { return calloc((size_t) r * c, sizeof(cplx)); }
static int lu_factor(cplx *L, int m, int *piv) {
  for (int k = 0; k < m; k++) {
    int p = k; double best = cabs(L[(size_t) k * m + k]);
    for (int i = k + 1; i < m; i++) { double v = cabs(L[(size_t) i * m + k]); if (v > best) { best = v; p = i; } }
    piv[k] = p;
    if (p != k) for (int j = 0; j < m; j++) { cplx t = L[(size_t) k * m + j]; L[(size_t) k * m + j] = L[(size_t) p * m + j]; L[(size_t) p * m + j] = t; }
    if (L[(size_t) k * m + k] == 0) return 0;
    for (int i = k + 1; i < m; i++) { cplx f = L[(size_t) i * m + k] / L[(size_t) k * m + k]; L[(size_t) i * m + k] = f; for (int j = k + 1; j < m; j++) L[(size_t) i * m + j] -= f * L[(size_t) k * m + j]; }
  }
  return 1;
}
static void lu_solve(const cplx *L, int m, const int *piv, cplx *b) {
  for (int k = 0; k < m; k++) if (piv[k] != k) { cplx t = b[k]; b[k] = b[piv[k]]; b[piv[k]] = t; }   /* every interchange first (P A = L U), then L, then U */
  for (int k = 0; k < m; k++) for (int i = k + 1; i < m; i++) b[i] -= L[(size_t) i * m + k] * b[k];
  for (int k = m - 1; k >= 0; k--) { for (int i = k + 1; i < m; i++) b[k] -= L[(size_t) k * m + i] * b[i]; b[k] /= L[(size_t) k * m + k]; }
}
static cplx *inverse(const cplx *Mx, int m) {
  cplx *L = cmat(m, m); memcpy(L, Mx, (size_t) m * m * sizeof(cplx)); int *piv = malloc(sizeof(int) * m);
  if (!lu_factor(L, m, piv)) { free(L); free(piv); return NULL; }
  cplx *R = cmat(m, m); cplx *col = cmat(m, 1);
  for (int j = 0; j < m; j++) { for (int i = 0; i < m; i++) col[i] = (i == j); lu_solve(L, m, piv, col); for (int i = 0; i < m; i++) R[(size_t) i * m + j] = col[i]; }
  free(L); free(piv); free(col); return R;
}
int main(void) {
  for (int trial = 0; trial < 3; trial++) { int m = (trial == 0) ? 5 : (trial == 1) ? 60 : 196; double scale = (trial == 2) ? 1e17 : 1;
    cplx *J = cmat(m, m); srand(7 + trial);
    for (int i = 0; i < m * m; i++) J[i] = scale * ((rand() / (double) RAND_MAX - 0.5) + I * (rand() / (double) RAND_MAX - 0.5));
    cplx *R = inverse(J, m); double worst = 0;
    for (int i = 0; i < m; i++) { double rs = 0; for (int j = 0; j < m; j++) { cplx s = 0; for (int t = 0; t < m; t++) s += R[(size_t) i * m + t] * J[(size_t) t * m + j]; s -= (i == j); rs += cabs(s); } if (rs > worst) worst = rs; }
    printf("m=%d scale=%.0e max row sum |RJ - I| = %.3e\n", m, scale, worst); free(J); free(R); }
  return 0;
}
