/* blockfree.c -- M2c: THE NEXT OBJECT'S FIRST COMPUTATION.  In Feynman gauge the photon's link components are independent massless lattice
 * fields, and the averaged coarse link variable Abar_mu(Y) = n^{-3} sum_{x in block(Y)} A_mu(x) (the average of the n^3 parallel line integrals
 * through the block) is the block sum of a free field.  Its CONDITIONAL row -- sum_{Y' != Y} |H_{YY'}| / H_{YY}, H the precision of the coarse
 * Gaussian family (partial correlations, = conditional maximal correlations for a Gaussian) -- is computed exactly on a coarse torus of side LC:
 *   C^(K) = sum_{m in Z_n^4} prod_rho |S_n(k_rho)|^2 / (n^6 (khat^2 + M2)),  k = (K + 2 pi m)/n,  |S_n(k)|^2 = sin^2(nk/2)/sin^2(k/2),
 *   H(Y) = LC^{-4} sum_K e^{iKY} / C^(K)   (the K = 0 mode: H^(0) = 1/C^(0) = 0 when M2 = 0, the zero mode of Lemma P),
 * for the massless (M2 = 0) and massive (M2 = m^2) fields, n = 1, 2, 4 (LC = 16).  KAT: n = 1, M2 = 0 gives H = -Delta, row exactly 1;
 * n = 1, M2 > 0 gives row 8/(8 + M2).
 * usage: blockfree <n> <LC> <M2> [radius]     build: gcc -O2 -fopenmp -o blockfree.exe blockfree.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define PI 3.141592653589793
int main(int argc, char **argv) {
  if (argc < 4) { fprintf(stderr, "usage: blockfree n LC M2 [radius]\n"); return 1; }
  int n = atoi(argv[1]), LC = atoi(argv[2]); double M2 = atof(argv[3]); int RAD = argc > 4 ? atoi(argv[4]) : 3;
  int NK = LC * LC * LC * LC; double *Hh = malloc(sizeof(double) * NK);
  #pragma omp parallel for schedule(dynamic)
  for (int idx = 0; idx < NK; idx++) { int K[4], r = idx; for (int d = 0; d < 4; d++) { K[d] = r % LC; r /= LC; }
    double Cs = 0; int nm = 1; for (int d = 0; d < 4; d++) nm *= n;
    for (int mi = 0; mi < nm; mi++) { int mm[4], q = mi; for (int d = 0; d < 4; d++) { mm[d] = q % n; q /= n; }
      double k[4], kh2 = 0, S = 1; for (int d = 0; d < 4; d++) { k[d] = (2 * PI * K[d] / LC + 2 * PI * mm[d]) / n; kh2 += 4 * sin(k[d] / 2) * sin(k[d] / 2);
        double s2 = sin(k[d] / 2); double num = sin(n * k[d] / 2); S *= (fabs(s2) < 1e-14) ? (double)n * n : num * num / (s2 * s2); }
      if (kh2 + M2 < 1e-300) { Cs = INFINITY; break; } Cs += S / ((double)n * n * n * n * n * n * (kh2 + M2)); }
    Hh[idx] = isinf(Cs) ? 0.0 : 1.0 / Cs; }
  /* H(Y) for |Y_d| <= RAD by direct inverse transform (real: C^ is even) */
  int W = 2 * RAD + 1, NY = W * W * W * W; double *H = calloc(NY, sizeof(double));
  #pragma omp parallel for schedule(dynamic)
  for (int iy = 0; iy < NY; iy++) { int Y[4], r = iy; for (int d = 0; d < 4; d++) { Y[d] = r % W - RAD; r /= W; } double s = 0;
    for (int idx = 0; idx < NK; idx++) { int K[4], q = idx; for (int d = 0; d < 4; d++) { K[d] = q % LC; q /= LC; } double ph = 0; for (int d = 0; d < 4; d++) ph += 2 * PI * K[d] * Y[d] / LC; s += Hh[idx] * cos(ph); }
    H[iy] = s / NK; }
  int i0 = 0; { int r = 1; for (int d = 0; d < 4; d++) { i0 += RAD * r; r *= W; } }
  double h0 = H[i0], row = 0, rowpos = 0, adj = 0, maxpos = 0; double shell[16] = { 0 };
  for (int iy = 0; iy < NY; iy++) { if (iy == i0) continue; int Y[4], r = iy, dist = 0; for (int d = 0; d < 4; d++) { Y[d] = r % W - RAD; r /= W; if (abs(Y[d]) > dist) dist = abs(Y[d]); }
    double v = H[iy] / h0; row += fabs(v); shell[dist] += fabs(v); if (v > 0) { rowpos += v; if (v > maxpos) maxpos = v; } if (dist == 1) adj += fabs(v); }
  double tot = 0; for (int iy = 0; iy < NY; iy++) tot += H[iy];
  printf("BLOCKFREE n=%d LC=%d M2=%g: H(0)=%.10f  conditional row (|Y-Y'|<=%d) = %.10f  [adjacent (sup-distance 1) %.10f; positive entries %.3e, largest %.3e]  sum_Y H(Y)/H(0) = %.3e\n", n, LC, M2, h0, RAD, row, adj, rowpos, maxpos, tot / h0);
  printf("BLOCKFREE n=%d M2=%g shells:", n, M2); for (int d = 1; d <= RAD; d++) printf(" d=%d %.6e", d, shell[d]); printf("\n");
  return 0; }
