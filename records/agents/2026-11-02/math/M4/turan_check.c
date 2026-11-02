/* turan_check.c -- the Wilson weight's normalised character coefficients kappa_j = I_{2j+1}(b)/I_1(b) (SU(2), b = beta) and
 * I_n(b)/I_0(b) (U(1)): the SO(3)-to-vortex slaving ratio kappa_1/kappa_{1/2}^2 = I_3 I_1 / I_2^2 (SU(2)) and I_2 I_0/I_1^2 (U(1)),
 * and the log-concavity margins I_{n+1}^2 - I_n I_{n+2} > 0 by the series (every coefficient positive), checked numerically.
 * build: gcc -O2 -o turan_check.exe turan_check.c -lm */
#include <stdio.h>
#include <math.h>
static double In(int n, double x) { /* series, fine for x <= 20 */ double s = 0, t = pow(x / 2, n); for (int k = 1; k <= n; k++) t /= k; for (int k = 0; k < 400; k++) { s += t; t *= (x / 2) * (x / 2) / ((k + 1.0) * (k + 1.0 + n)); if (t < 1e-300) break; } return s; }
int main(void) { double bs[] = { 0.1, 0.4764, 1.0, 2.2, 2.3, 3.0, 5.0, 10.0 };
  printf("TURAN beta | SU(2): a_1/2 = I2/I1, a_1 = I3/I1, a_1/a_1/2^2 | U(1): c1 = I1/I0, c2 = I2/I0, c2/c1^2 | min over n<=12 of (I_{n+1}^2 - I_n I_{n+2})/I_{n+1}^2\n");
  for (int i = 0; i < 8; i++) { double b = bs[i]; double I0 = In(0, b), I1 = In(1, b), I2 = In(2, b), I3 = In(3, b);
    double mn = 1e9; for (int n = 0; n <= 12; n++) { double a = In(n, b), c = In(n + 1, b), d = In(n + 2, b); double m = (c * c - a * d) / (c * c); if (m < mn) mn = m; }
    printf("TURAN %6.4f | %.9f %.9f %.6f | %.9f %.9f %.6f | %.3e\n", b, I2 / I1, I3 / I1, (I3 / I1) / ((I2 / I1) * (I2 / I1)), I1 / I0, I2 / I0, (I2 / I0) / ((I1 / I0) * (I1 / I0)), mn); }
  return 0; }
