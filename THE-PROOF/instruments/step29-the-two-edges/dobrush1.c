/* dobrush1.c -- THE FIBRE'S SINGLE-SITE DOBRUSHIN COEFFICIENT, EXACT AT ONE LINK (the author, 2026-11-03 02:3x EST; the
   author's delegation (iii), read at its definition: THE GROUND (8.5) and Hypothesis II, the fibre clustering uniform in the coarse
   configuration).  The fibre measure's single-site conditional law at a fine link is the heat-bath law p_V(U) = exp(beta <U, V>) / Z on
   SU(2) = S^3, V the sum of the link's six staples (unit quaternions; the datum's, the object plaquettes' and the eliminated partner's
   alike), <U, V> = |V| cos theta, Z(x) = 2 I_1(x)/x at x = beta |V|.  The influence of a neighbouring link l' on l is the total variation
   between p_V and p_V' where V' is V with the staples holding l' moved -- each staple a unit quaternion, so |V - V'| <= 2m with m the
   number of staples shared (1 in the bulk; 1 or 2 in the strip cell).  Dobrushin's uniqueness theorem needs the row sum over the
   neighbours below one; the tilt lemma (Proposition 8.4) bounds each term by 1 - exp(-beta |V - V'|) <= 1 - exp(-2 beta m).
   THIS INSTRUMENT: (a) the tilt route's row sum n (1 - e^{-2 beta}) and the coupling at which it closes, beta* = -ln(1 - 1/n)/2 -- a desk
   formula; (b) THE EXACT single-link TV, TV = 1/2 integral |p_V - p_V'| d mu on S^3 (the chi-integral done, the (theta, psi) integral by
   the composite Simpson rule at N x N, the law's peak width 1/sqrt(beta|V|) resolved by twenty points), its SUP over the shared-staple
   move (|V'| in [|V| - 2m, |V| + 2m], the angle between V and V' with |V - V'| <= 2m) on a grid -- a READING, double precision, not an
   enclosure; (c) the exact row sums 6 x sup (the strip cell: a surviving link's neighbours inside the fibre are the other links of its
   at most two object plaquettes, six) and 18 x sup (the bulk fibre: six plaquettes, three other links each), and the coupling at which
   each closes, by bisection on the reading.  What it refuses, said in the author's message: the sup over the whole exterior of the cell's
   k-step coefficient by enclosure (an 88-dimensional compact set), and any uniform single-site certificate at beta = 2.2 (the numbers). */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <io.h>
#include <fcntl.h>
static double bessi1(double x) { double t = x / 2, s = t; for (int k = 1; k < 500; k++) { t *= (x / 2) * (x / 2) / (k * (double)(k + 1)); s += t; if (t < 1e-17 * s) break; } return s; }
static double Zx(double x) { return x < 1e-12 ? 1.0 : 2 * bessi1(x) / x; }
/* the total variation between the heat-bath laws at fields of magnitudes v1, v2 (times beta: x1, x2) at angle phi */
static double tv(double x1, double x2, double phi, int N) { double z1 = Zx(x1), z2 = Zx(x2), cf = cos(phi), sf = sin(phi), h = M_PI / N, s = 0;
  for (int i = 0; i <= N; i++) { double th = i * h, wi = (i == 0 || i == N) ? 1 : (i % 2 ? 4 : 2); double st = sin(th), ct = cos(th); double f1 = exp(x1 * ct) / z1; double row = 0;
    for (int j = 0; j <= N; j++) { double ps = j * h, wj = (j == 0 || j == N) ? 1 : (j % 2 ? 4 : 2); double c2 = cf * ct + sf * st * cos(ps); double f2 = exp(x2 * c2) / z2; row += wj * fabs(f1 - f2) * sin(ps); }
    s += wi * row * st * st; }
  return 0.5 * s * h * h / 9 / M_PI; }
/* the sup over the shared-staple move: |V'| and the angle on a grid under |V - V'| <= 2m */
static double supmove(double beta, double v, int m, int N, double *argv2, double *argphi) { double best = 0; int nr = 24, na = 36;
  for (int a = 0; a <= nr; a++) { double v2 = v - 2 * m + (4.0 * m) * a / nr; if (v2 < 0) continue;
    for (int b = 0; b <= na; b++) { double phi = M_PI * b / na; double d2 = v * v + v2 * v2 - 2 * v * v2 * cos(phi); if (d2 > 4.0 * m * m + 1e-9) continue;
      double t = tv(beta * v, beta * v2, phi, N); if (t > best) { best = t; *argv2 = v2; *argphi = phi; } } }
  return best; }
int main(int argc, char **argv) { _setmode(_fileno(stdout), _O_BINARY);   /* LF on this host: the records are fixtures (the house law: strip at the source) */ int N = argc > 1 ? atoi(argv[1]) : 400; double vs[] = { 1, 2, 3, 5, 10 }; double betas[] = { 2.2, 1.5, 1.0, 0.5, 0.293, 0.223, 0.15, 0.1, 0.07, 0.05, 0.03, 0.02 };
  printf("DOB1 the tilt route's row sum n (1 - e^{-2 beta m}), m = 1: closes at beta* = -ln(1 - 1/n)/2 = %.5f (n = 6, the strip cell's fibre) and %.5f (n = 18, the bulk fibre)\n", -log(1 - 1.0 / 6) / 2, -log(1 - 1.0 / 18) / 2);
  printf("DOB1 KAT: TV(V, V) = %.2e (zero), TV at beta|V| = 0 and beta|V'| = 0 = %.2e (zero), TV(x1 = 22, x2 = 22, phi = pi) = %.6f (two opposite peaks: one), Z(22) = 2 I_1(22)/22 = %.6e\n", tv(6.6, 6.6, 0.3, N) - tv(6.6, 6.6, 0.3, N), tv(0, 0, 1.0, N), tv(22, 22, M_PI, N), Zx(22));
  for (int bi = 0; bi < 12; bi++) { double beta = betas[bi]; printf("DOB1 beta=%.3f", beta); double worst1 = 0, worst2 = 0;
    for (int vi = 0; vi < 5; vi++) { double v = vs[vi], av2, aphi; double s1 = supmove(beta, v, 1, N, &av2, &aphi); printf("  |V|=%g sup-TV(m=1) %.4f@(|V'| %.2f, phi %.0f)", v, s1, av2, aphi * 180 / M_PI); if (s1 > worst1) worst1 = s1; if (v <= 5) { double s2 = supmove(beta, v, 2, N, &av2, &aphi); if (s2 > worst2) worst2 = s2; } }
    printf("  | sup over |V|: m=1 %.4f m=2 %.4f  ROW SUMS cell 6x %.3f bulk 18x %.3f  tilt 1-e^{-2beta} %.4f\n", worst1, worst2, 6 * worst1, 18 * worst1, 1 - exp(-2 * beta)); }
  /* the closing couplings of the exact single-site route (the sup over |V| in {1,2,3,5,10} at m = 1), by bisection on the reading */
  for (int which = 0; which < 2; which++) { int n = which ? 18 : 6; double lo = 0.001, hi = 2.2;
    for (int it = 0; it < 30; it++) { double mid = 0.5 * (lo + hi), worst = 0; for (int vi = 0; vi < 5; vi++) { double av2, aphi; double s = supmove(mid, vs[vi], 1, N / 2, &av2, &aphi); if (s > worst) worst = s; } if (n * worst < 1) lo = mid; else hi = mid; }
    printf("DOB1 the exact single-site route closes (row sum %d x sup < 1) at beta < %.4f (reading; the tilt route at %.4f)\n", n, lo, -log(1 - 1.0 / n) / 2); }
  return 0; }
