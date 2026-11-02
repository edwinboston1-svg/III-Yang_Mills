/* m4r_misc.c -- M4R's arithmetic checks for M4's §1b/§9 per-step criterion and for the applicability of Theorem 4.1's
 * hypothesis. Double precision.
 * (1) c(2) = 8 b0 ln 2 with b0 = 11 N/(48 pi^2), N = 2; the admissible uniform loss c(2) - 1.75/K for K = 7, 8, 10, 20, 100;
 *     the rung-1 discrepancy 2.34 - (2.2 - c(2)).
 * (2) the record's hierarchical (MK) budget: from beta = 2.2, B7 in [2.0760, 2.0791] (THE GROUND, content4.js), and
 *     B_k >= (24/pi) beta_k, so beta_MK(7) <= 2.0791 pi/24; the cumulative sum of M4's criterion over the first seven MK rungs
 *     telescopes to 2.2 - beta_MK(7).
 * (3) a lower bound on one entry of the fibre's single-link Dobrushin matrix at beta: the conditional law of a link given its
 *     six staples is vMF on S^3 with parameter w = beta * (sum of staples); with the five other staples summing to zero (five
 *     unit vectors at 72 degrees), changing the neighbour link j moves the sixth staple from e to -e, so
 *     C(i,j) >= TV(vMF(beta e), vMF(-beta e)) = [int_0^1 2 sinh(beta c) (2/pi) sqrt(1-c^2) dc] / [2 I_1(beta)/beta].
 *     Each link has 18 neighbours, so the row sum is >= 18 times that.
 * build: gcc -O2 -o m4r_misc.exe m4r_misc.c -lm */
#include <stdio.h>
#include <math.h>
static const double PI = 3.14159265358979323846;
static double I1(double b) { double s = 0, t = b / 2; for (int k = 0; k < 300; k++) { s += t; t *= (b / 2) * (b / 2) / ((k + 1.0) * (k + 2.0)); } return s; }
static double tv_vmf(double b) { int N = 200000; double num = 0; for (int i = 0; i < N; i++) { double c = (i + 0.5) / N; num += 2 * sinh(b * c) * (2 / PI) * sqrt(1 - c * c) / N; } return num / (2 * I1(b) / b); }
int main(void) {
  double b0 = 11.0 * 2 / (48 * PI * PI), c2 = 8 * b0 * log(2.0);
  printf("M4R-C2 b0 = %.9f, c(2) = 8 b0 ln 2 = %.9f (M4 writes 0.25752)\n", b0, c2);
  int Ks[5] = { 7, 8, 10, 20, 100 }; for (int i = 0; i < 5; i++) printf("M4R-DELTA K = %3d: admissible uniform loss c(2) - 1.75/K = %+.6f\n", Ks[i], c2 - 1.75 / Ks[i]);
  printf("M4R-DELTA as K -> infinity the admissible uniform loss tends to c(2) = %.6f; the one-loop K needed for zero loss: 1.75/c(2) = %.3f steps\n", c2, 1.75 / c2);
  printf("M4R-RUNG1 delta_1 = 2.34 - (2.2 - c(2)) = %.6f\n", 2.34 - (2.2 - c2));
  double b7 = 2.0791 * PI / 24, b7lo = 2.0760 * PI / 24 * 0; (void)b7lo;
  printf("M4R-MK from 2.2: beta_MK(7) <= B7_upper pi/24 = %.6f, so sum_{k<7}(c(2) - delta_k) = 2.2 - beta_MK(7) >= %.6f against the required 2.2 - 0.45 = 1.75 [%s]\n", b7, 2.2 - b7, 2.2 - b7 >= 1.75 ? "MET at K = 7" : "not met");
  printf("M4R-MK from 2.3: beta_MK(7) <= 4.9420 pi/24 = %.6f; beta_MK(8) <= 0.28192 pi/24 = %.6f\n", 4.9420 * PI / 24, 0.28192 * PI / 24);
  double bs[6] = { 0.131, 0.2452, 0.4764, 1.0, 2.2, 3.0 };
  for (int i = 0; i < 6; i++) { double t = tv_vmf(bs[i]); printf("M4R-FIBRE beta = %.4f: C(i,j) >= TV(vMF(beta e), vMF(-beta e)) = %.6f, so the single-link row sum >= 18 x that = %.4f; the record's linear bound 18*4*beta/(3 pi) = %.4f\n", bs[i], t, 18 * t, 18 * 4 * bs[i] / (3 * PI)); }
  return 0; }
