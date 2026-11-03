/* alpha_su2.c -- THE ENCLOSED SINGLE-SITE DOBRUSHIN ROW SUM OF THE SU(2) WILSON WEIGHT, alpha_SU(2)(beta) (the author,
   2026-11-03 02:5x–03:1x EST; the author's delegation (iv): the per-group input Step 6 needs in the form MG2 never had -- alpha_G as the
   ENCLOSED single-site row sum -- and the certified boundary of the single-site cone that dobrush1.c read).

   THE OBJECT.  A fine link's conditional law under the Wilson weight is p_V(U) = e^{beta <U,V>}/Z(beta|V|) on SU(2) = S^3, V the sum of
   its staples (unit quaternions), Z(x) = 2 I_1(x)/x.  A neighbour sharing m staples moves V to V' with |V - V'| <= 2m; Dobrushin's
   interdependence coefficient of the pair is sup TV(p_V, p_V') over the exterior, and by the invariance of the Haar measure under
   U -> gUh the TV depends on (|V|, |V'|, the angle phi) alone.  Dobrushin's uniqueness theorem: if the row sum alpha = sum over the n
   neighbours of the coefficients is below one, the measure is unique and clusters exponentially, uniformly in the boundary condition
   -- so alpha_SU(2)(beta) = n sup TV certifies the single-site cone.  n = 18 in the bulk (six plaquettes, three other links each), 6 in
   the strip cell's fibre; |V| <= M (6 in the bulk; 10 at a paired survivor of the strip).

   THE UPPER BOUND, rigorous and cheap: the relative entropy of two heat-bath laws is explicit -- with x = beta|V|, x' = beta|V'| and
   r(x) = E_V[cos theta] = I_2(x)/I_1(x),  KL(p_V ‖ p_V') = beta <m_V, V - V'> + ln Z(x') - ln Z(x) = r(x)(x - x' cos phi) + ln Z(x') -
   ln Z(x) -- and TV <= min( sqrt(KL/2) [Pinsker], sqrt(1 - e^{-KL}) [Bretagnolle--Huber] ) in either direction.  The sup over the
   compact domain is taken on a grid of CELLS in (|V|, |V'|, phi) with every quantity an interval over the cell (I_1, I_2 by their
   series with the ratio tail bound; r and Z monotone in x; the products and quotients by interval arithmetic; cells wholly outside
   |V - V'| <= 2m skipped, the rest kept): alpha_hi = n max over cells of the bound's upper end.  (A first draft took the exact TV's
   sup by branch and bound under the tilt lemma's Lipschitz modulus 2 beta |dV|; the modulus is near sharp at small beta, the TV is
   nearly flat across the domain there, and the grid it demanded was 10^9 evaluations -- withdrawn, 02:5x, dated.)
   THE LOWER BOUND, rigorous: the exact TV enclosed cell by cell on an N x N (theta, psi) grid at the best configuration (monotone
   factors, interval arithmetic, every sum inflated; the width first order in 1/N), so alpha_lo = n TV_lo there.  The cone is CERTIFIED
   where alpha_hi < 1 and REFUSED where alpha_lo >= 1.
   THE ASSUMPTION STATED ONCE: the C library's exp, log, sin, cos within two ulps (every call and every operation carries the margin
   1 + 2^-49 in place of directed rounding); a stranger re-runs with fesetround if the margin is doubted.
   USAGE: alpha_su2 [grid] [N]  -> ALPHA lines per beta;  --kat the known answers (Z(22) and r(2.2) against an independent gawk -M series). */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <io.h>
#include <fcntl.h>
static const double MG = 1 + 1.7763568394002505e-15;   /* 1 + 2^-49 */
static double up(double x) { return x >= 0 ? x * MG + 1e-300 : x / MG; }
static double dn(double x) { return x >= 0 ? x / MG : x * MG - 1e-300; }
static void bessi_enc(int nu, double x, double *lo, double *hi) { if (x < 0) x = -x; double t = 1; for (int k = 1; k <= nu; k++) t *= (x / 2) / k; double s = t; int k; double ratio = 0;
  for (k = 1; k < 4000; k++) { t *= (x / 2) * (x / 2) / (k * (double)(k + nu)); s += t; ratio = (x / 2) * (x / 2) / ((k + 1) * (double)(k + 1 + nu)); if (ratio < 0.5 && t < 1e-17 * s) break; }
  double tail = up(t * ratio / (1 - ratio)); *lo = dn(s * (1 - 4e-15 * k)); *hi = up(s * (1 + 4e-15 * k) + tail); }
static void Z_enc(double x, double *lo, double *hi) { if (x < 1e-300) { *lo = dn(1); *hi = up(1); return; } double a, b; bessi_enc(1, x, &a, &b); *lo = dn(2 * a / x); *hi = up(2 * b / x); }
static void r_enc(double x, double *lo, double *hi) { if (x < 1e-300) { *lo = 0; *hi = 0; return; } double a1, b1, a2, b2; bessi_enc(1, x, &a1, &b1); bessi_enc(2, x, &a2, &b2); *lo = dn(a2 / b1); *hi = up(b2 / a1); }
/* the exact TV enclosed at (x1, x2, phi) on N x N cells */
static void tv_enc(double x1, double x2, double phi, int N, double *tvlo, double *tvhi) {
  double z1lo, z1hi, z2lo, z2hi; Z_enc(x1, &z1lo, &z1hi); Z_enc(x2, &z2lo, &z2hi);
  double cf = cos(phi), sf = sin(phi); double cflo = dn(cf), cfhi = up(cf), sflo = dn(sf), sfhi = up(sf); if (sflo < 0) sflo = 0;
  double h = M_PI / N, slo = 0, shi = 0;
  for (int i = 0; i < N; i++) { double ta = i * h, tb = (i + 1) * h; double c_lo = dn(cos(tb)), c_hi = up(cos(ta));
    double sta = sin(ta), stb = sin(tb), s_lo, s_hi; if (tb <= M_PI / 2) { s_lo = dn(sta); s_hi = up(stb); } else if (ta >= M_PI / 2) { s_lo = dn(stb); s_hi = up(sta); } else { s_lo = dn(fmin(sta, stb)); s_hi = 1; } if (s_lo < 0) s_lo = 0;
    double f1lo = dn(dn(exp(x1 * c_lo)) / z1hi), f1hi = up(up(exp(x1 * c_hi)) / z1lo); double w1lo = dn(s_lo * s_lo), w1hi = up(s_hi * s_hi);
    for (int j = 0; j < N; j++) { double pa = j * h, pb = (j + 1) * h; double p_lo = dn(cos(pb)), p_hi = up(cos(pa));
      double spa = sin(pa), spb = sin(pb), sp_lo, sp_hi; if (pb <= M_PI / 2) { sp_lo = dn(spa); sp_hi = up(spb); } else if (pa >= M_PI / 2) { sp_lo = dn(spb); sp_hi = up(spa); } else { sp_lo = dn(fmin(spa, spb)); sp_hi = 1; } if (sp_lo < 0) sp_lo = 0;
      double a1 = cflo * c_lo, a2 = cflo * c_hi, a3 = cfhi * c_lo, a4 = cfhi * c_hi; double t1lo = fmin(fmin(a1, a2), fmin(a3, a4)), t1hi = fmax(fmax(a1, a2), fmax(a3, a4));
      double b1 = s_lo * p_lo, b2 = s_lo * p_hi, b3 = s_hi * p_lo, b4 = s_hi * p_hi; double sclo = fmin(fmin(b1, b2), fmin(b3, b4)), schi = fmax(fmax(b1, b2), fmax(b3, b4));
      double t2lo = fmin(sflo * sclo, sfhi * sclo), t2hi = fmax(sflo * schi, sfhi * schi); double c2lo = dn(t1lo + t2lo), c2hi = up(t1hi + t2hi);
      double f2lo = dn(dn(exp(x2 * c2lo)) / z2hi), f2hi = up(up(exp(x2 * c2hi)) / z2lo);
      double dlo = fmax(0, fmax(f1lo - f2hi, f2lo - f1hi)), dhi = fmax(0, fmax(f1hi - f2lo, f2hi - f1lo));
      double wlo = dn(w1lo * sp_lo), whi = up(w1hi * sp_hi); slo += dn(dlo * wlo); shi = up(shi + up(dhi * whi)); } }
  double cell = h * h; *tvlo = dn(0.5 * slo * cell / M_PI); *tvhi = up(0.5 * shi * cell / M_PI); }
/* KL(p_x ‖ p_x') upper end over a cell: x in [x0,x1], x' in [y0,y1], cos phi in [c0,c1] */
static double kl_hi(double x0, double x1, double y0, double y1, double c0, double c1) {
  double rlo, rhi, rl2, rh2; r_enc(x0, &rlo, &rl2); r_enc(x1, &rh2, &rhi); (void)rl2; (void)rh2;   /* r increasing: r(x) in [r_lo(x0), r_hi(x1)] */
  double zlo, zhi, ylo, yhi; Z_enc(x0, &zlo, &zhi); Z_enc(y1, &ylo, &yhi); (void)ylo; (void)zhi;  /* Z increasing: ln Z(x') - ln Z(x) <= ln Z_hi(y1) - ln Z_lo(x0) */
  /* (x - x' cos phi) upper end: x1 - min over the cell of x' cos phi */
  double m = fmin(fmin(y0 * c0, y0 * c1), fmin(y1 * c0, y1 * c1)); double ahi = up(x1 - m); double term = ahi >= 0 ? up(rhi * ahi) : dn(rlo * ahi);
  /* (the first build took Z_hi of the WRONG law here -- Z(x) for Z(x') -- and the KAT at (3.0, 3.2) read a bound of 0.0000 below the
     exact TV's 0.0235: an unsound bound, caught before any value was recorded; corrected 03:0x, dated) */
  return up(term + up(log(yhi)) - dn(log(zlo))); }
static double tvbound(double kl) { if (kl < 0) kl = 0; double a = sqrt(kl / 2), b = sqrt(fmax(0, 1 - exp(-kl))); return up(fmin(fmin(a, b), 1)); }
/* the sup of the TV bound over |V| in [0, M], |V'| in [0, M + 2m], phi in [0, pi] with |V - V'| <= 2m, on a (G, G, G) cell grid */
static double sup_hi(double beta, double M, int m, int G, double *av, double *aw, double *ap) { double best = 0; double Wmax = M + 2 * m;
  for (int a = 0; a < G; a++) { double v0 = M * a / G, v1 = M * (a + 1) / G;
    for (int b = 0; b < G; b++) { double w0 = Wmax * b / G, w1 = Wmax * (b + 1) / G;
      for (int c = 0; c < G; c++) { double p0 = M_PI * c / G, p1 = M_PI * (c + 1) / G; double c0 = dn(cos(p1)), c1 = up(cos(p0));
        /* the minimum of |V - V'|^2 over the cell: at cos phi = c1 and the magnitudes nearest */
        double dmin = 1e9; double vs[2] = { v0, v1 }, ws[2] = { w0, w1 }; for (int i = 0; i < 2; i++) { double v = vs[i], w = v < w0 ? w0 : (v > w1 ? w1 : v); double d = v * v + w * w - 2 * v * w * c1; if (d < dmin) dmin = d; }
        for (int i = 0; i < 2; i++) { double w = ws[i], v = w < v0 ? v0 : (w > v1 ? v1 : w); double d = v * v + w * w - 2 * v * w * c1; if (d < dmin) dmin = d; }
        if (dmin > 4.0 * m * m * (1 + 1e-9)) continue;
        double k1 = kl_hi(beta * v0, beta * v1, beta * w0, beta * w1, c0, c1), k2 = kl_hi(beta * w0, beta * w1, beta * v0, beta * v1, c0, c1);
        double bd = fmin(tvbound(k1), tvbound(k2)); if (bd > best) { best = bd; *av = 0.5 * (v0 + v1); *aw = 0.5 * (w0 + w1); *ap = 0.5 * (p0 + p1); } } } }
  return best; }
static int kat(int N) { int bad = 0; double lo, hi;
  Z_enc(22, &lo, &hi); printf("KAT Z(22) enclosed in [%.12e, %.12e] against gawk -M's 27239964.26157990724785 (inside: %s)\n", lo, hi, (lo <= 27239964.26157990724785 && hi >= 27239964.26157990724785) ? "yes" : "NO"); if (!(lo <= 27239964.26157990724785 && hi >= 27239964.26157990724785)) bad++;
  r_enc(2.2, &lo, &hi); printf("KAT r(2.2) = I_2/I_1 enclosed in [%.12f, %.12f] against gawk -M's 0.46447902527042 (inside: %s)\n", lo, hi, (lo <= 0.46447902527042 && hi >= 0.46447902527042) ? "yes" : "NO"); if (!(lo <= 0.46447902527042 && hi >= 0.46447902527042)) bad++;
  double k = kl_hi(2.2, 2.2, 2.2, 2.2, 1, 1); printf("KAT KL(V ‖ V) upper end at x = 2.2: %.3e (zero to the margin)\n", k); if (!(k >= 0 && k < 1e-12)) bad++;
  tv_enc(6.6, 6.6, 0.0, N, &lo, &hi); printf("KAT TV(V, V) at x = 6.6 enclosed in [%.3e, %.3e] (zero inside)\n", lo, hi); if (!(lo <= 0 && hi >= 0)) bad++;
  tv_enc(22, 22, M_PI, N, &lo, &hi); printf("KAT two opposite peaks at x = 22 enclosed in [%.6f, %.6f] (one inside)\n", lo, hi); if (!(lo <= 1 && hi >= 1 - 1e-9)) bad++;
  double lo2, hi2; tv_enc(2.2, 2.2, M_PI, N / 4, &lo2, &hi2); tv_enc(2.2, 2.2, M_PI, N, &lo, &hi); printf("KAT the enclosure's width at x = 2.2, phi = pi: %.3e at N/4, %.3e at N (ratio %.2f, four expected)\n", hi2 - lo2, hi - lo, (hi2 - lo2) / (hi - lo)); if (!((hi2 - lo2) / (hi - lo) > 2.5)) bad++;
  double b = fmin(tvbound(kl_hi(2.2, 2.2, 2.2, 2.2, -1, -1)), tvbound(kl_hi(2.2, 2.2, 2.2, 2.2, -1, -1))); printf("KAT the staple reversed at beta = 2.2, |V| = |V'| = 1: the exact TV in [%.4f, %.4f], the KL bound %.4f (above it, as a bound must be: %s)\n", lo, hi, b, b >= lo ? "yes" : "NO"); if (!(b >= lo)) bad++;
  tv_enc(3.0, 3.2, 0.0, N, &lo, &hi); b = fmin(tvbound(kl_hi(3.0, 3.0, 3.2, 3.2, 1, 1)), tvbound(kl_hi(3.2, 3.2, 3.0, 3.0, 1, 1))); printf("KAT TV(3.0, 3.2) at phi = 0 in [%.4f, %.4f], the KL bound %.4f, the tilt bound %.4f (ordered: %s)\n", lo, hi, b, 1 - exp(-0.4), (b >= lo && b <= 1 - exp(-0.4)) ? "yes" : "NO"); if (!(b >= lo && b <= 1 - exp(-0.4))) bad++;
  double w = kl_hi(2.2, 2.2, 2.2, 2.2, 1, 1); (void)w; printf("KAT %s\n", bad ? "FAILED" : "MET"); return bad; }
int main(int argc, char **argv) { _setmode(_fileno(stdout), _O_BINARY);
  if (argc > 1 && !strcmp(argv[1], "--kat")) return kat(argc > 2 ? atoi(argv[2]) : 2000);
  int G = argc > 1 ? atoi(argv[1]) : 120, N = argc > 2 ? atoi(argv[2]) : 1500;
  double betas[] = { 0.02, 0.03, 0.05, 0.07, 0.09, 0.10, 0.11, 0.12, 0.13, 0.14, 0.15, 0.20, 0.25, 0.30, 0.35, 0.40, 0.45, 0.50, 1.0, 2.2 }; int nbeta = 20;
  printf("ALPHA the enclosed single-site row sum of the SU(2) Wilson weight, m = 1: the upper bound by Pinsker / Bretagnolle-Huber on the explicit relative entropy, the sup over a %d^3 cell grid in (|V|, |V'|, phi); the lower bound the exact TV enclosed at the best cell (N = %d); bulk n = 18, M = 6; the strip cell n = 6, M = 10\n", G, N);
  for (int bi = 0; bi < nbeta; bi++) { double beta = betas[bi]; double av, aw, ap, av2, aw2, ap2;
    double s18 = sup_hi(beta, 6, 1, G, &av, &aw, &ap); double s6 = sup_hi(beta, 10, 1, G, &av2, &aw2, &ap2);
    /* the lower bound: the exact TV at the readings' maximiser (|V| = 1, the staple reversed) and at the bound's own argmax */
    double lo1, hi1, lo2, hi2; tv_enc(beta * 1, beta * 1, M_PI, N, &lo1, &hi1); tv_enc(beta * av, beta * aw, ap, N, &lo2, &hi2); double lo = fmax(lo1, lo2);
    printf("ALPHA beta=%.3f  bulk: sup TV in [%.4f, %.4f] (the bound's argmax |V| %.2f |V'| %.2f phi %.0f)  alpha_18 in [%.3f, %.3f] %s  |  cell: sup TV <= %.4f  alpha_6 in [%.3f, %.3f] %s  |  tilt 18(1-e^{-2beta}) = %.3f\n",
      beta, lo, s18, av, aw, ap * 180 / M_PI, 18 * lo, 18 * s18, 18 * s18 < 1 ? "CERTIFIED-CLOSED" : (18 * lo >= 1 ? "REFUSED" : "open"), s6, 6 * lo, 6 * s6, 6 * s6 < 1 ? "CERTIFIED-CLOSED" : (6 * lo >= 1 ? "REFUSED" : "open"), 18 * (1 - exp(-2 * beta))); fflush(stdout); }
  return 0; }
