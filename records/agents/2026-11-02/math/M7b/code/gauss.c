/* gauss.c -- M7b (2026-11-02): THE FREE PHOTON'S COARSE LOOPS, the beta_V -> infinity limit of the Villain action (Guth 1980, Froehlich-Spencer
 * 1982: the Coulomb phase at large beta_V).  In Feynman gauge <A_mu(x) A_nu(y)> = delta_{mu nu} G(x - y)/beta, G = (-Delta)^{-1} on Z^4, so for
 * closed loops C, C' (gauge invariant; additive constants in G cancel because a closed loop's current sums to zero in each direction)
 *   beta <Phi_C Phi_C'> = int d^4k/(2 pi)^4  sum_mu J^C_mu(k) conj(J^C'_mu(k)) / K(k),   K = sum_mu 4 sin^2(k_mu/2),
 * J^C_mu(k) = sum over the loop's mu-links of eps e^{i k.x_link}.  Loops in the (1,2) plane depend on k1, k2 only, and the k3, k4 integral of 1/K is
 * the two-dimensional lattice Green's function at mass c = 4 sin^2(k1/2) + 4 sin^2(k2/2): g2(c) = K_ell(4/(c+4)) / (pi (c+4)/2) (complete elliptic
 * integral of modulus 4/(c+4), by the AGM); the bent partner in the (3,2) plane needs k1, k2, k3 and g1(c) = 1/sqrt(c (c + 4)).
 * Prints, per n, beta<Phi_A^2>, beta<Phi_A Phi_B> (planar, bent); the Gaussian law then gives E[e^{i Phi}] = exp(-<Phi^2>/2) and the pair's
 * relative content in the channel (+1, -1) or (+1, +1) as exp(-+ <Phi_A Phi_B>) - 1.  Midpoint rule on M^2 (planar) and M^3 (bent) cells, two M
 * printed so the convergence is read.  usage: gauss M n1 n2 ... */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <complex.h>
typedef double complex cplx;
static double kell(double k) { double a = 1, b = sqrt(1 - k * k); for (int i = 0; i < 60; i++) { double an = (a + b) / 2, bn = sqrt(a * b); a = an; b = bn; if (fabs(a - b) < 1e-16 * a) break; } return M_PI / (2 * a); }
static double g2(double c) { double z = (c + 4) / 2; return kell(2 / z) / (M_PI * z); }
static double g1(double c) { return 1 / sqrt(c * (c + 4)); }
/* the n x n loop at the origin in the (p, q) plane, counterclockwise: +p along q = 0 (links at p = j + 1/2), +q at p = n, -p at q = n, -q at p = 0 */
static cplx edge(double k, int n) { cplx s = 0; for (int j = 0; j < n; j++) s += cexp(I * k * (j + 0.5)); return s; }
int main(int argc, char **argv) {
  int M = atoi(argv[1]);
  for (int ai = 2; ai < argc; ai++) { int n = atoi(argv[ai]); double h = 2 * M_PI / M;
    /* planar: A at origin in (1,2); B at -n e1 in (1,2) (shares the edge x1 = 0) */
    double sAA = 0, sAB = 0;
    for (int i = 0; i < M; i++) for (int j = 0; j < M; j++) { double k1 = -M_PI + (i + 0.5) * h, k2 = -M_PI + (j + 0.5) * h;
      double c = 4 * sin(k1 / 2) * sin(k1 / 2) + 4 * sin(k2 / 2) * sin(k2 / 2); double g = g2(c);
      cplx e1 = edge(k1, n), e2 = edge(k2, n);
      cplx JA1 = e1 * (1 - cexp(I * k2 * n)), JA2 = e2 * (cexp(I * k1 * n) - 1);
      cplx sh = cexp(-I * k1 * n); cplx JB1 = JA1 * sh, JB2 = JA2 * sh;
      sAA += (creal(JA1 * conj(JA1)) + creal(JA2 * conj(JA2))) * g; sAB += creal(JA1 * conj(JB1) + JA2 * conj(JB2)) * g; }
    sAA *= h * h / (4 * M_PI * M_PI); sAB *= h * h / (4 * M_PI * M_PI);
    /* bent: B in the (3,2) plane at the origin, counterclockwise in (3,2): +3 along x2 = 0, +2 at x3 = n, -3 at x2 = n, -2 at x3 = 0; its 2-links at x3 = 0
       coincide with A's 2-links at x1 = 0, both traversed as -2 (the SAME sense; the planar partner traverses it oppositely); cross term only through mu = 2 */
    int Mb = M / 2 < 64 ? M / 2 : 64; double hb = 2 * M_PI / Mb, sB = 0;
    for (int i = 0; i < Mb; i++) for (int j = 0; j < Mb; j++) for (int l = 0; l < Mb; l++) { double k1 = -M_PI + (i + 0.5) * hb, k2 = -M_PI + (j + 0.5) * hb, k3 = -M_PI + (l + 0.5) * hb;
      double c = 4 * sin(k1 / 2) * sin(k1 / 2) + 4 * sin(k2 / 2) * sin(k2 / 2) + 4 * sin(k3 / 2) * sin(k3 / 2);
      cplx JA2 = edge(k2, n) * (cexp(I * k1 * n) - 1); cplx JB2 = edge(k2, n) * (cexp(I * k3 * n) - 1);
      sB += creal(JA2 * conj(JB2)) * g1(c); }
    sB *= hb * hb * hb / (8 * M_PI * M_PI * M_PI);
    printf("GAUSS n=%d M=%d: beta<Phi_A^2> = %.6f  beta<Phi_A Phi_B> planar = %.6f  bent = %.6f\n", n, M, sAA, sAB, sB); }
  return 0; }
