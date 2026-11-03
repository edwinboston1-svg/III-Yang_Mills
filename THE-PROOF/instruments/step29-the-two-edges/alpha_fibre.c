/* alpha_fibre.c -- THE SINGLE-SITE DOBRUSHIN ROW SUM ON THE REALIZABLE DOMAIN (2026-11-03 04:xx EST; the author).
   THE CORRECTION (found by the author the author at the desk, relayed by the author; the campaign page's §33 addendum note 2):
   alpha_su2.txt's lower bounds were taken at the reversed staple pair |V| = |V'| = 1 at angle pi (beta <= 0.5) or at the bound's
   argmax cell midpoint (beta = 1.0, 2.2), and
     - on a TWO-STAPLE fibre (V = S1 + S2, V' = S1' + S2, one neighbour's change moving S1 -> S1') the reversed pair is NOT REALIZABLE:
       the Gram matrix of (S1, S2, S1') at that pair has determinant -1 < 0 -- so every six-neighbour REFUSED line of that record
       (beta = 0.40 ... 2.2) is a refusal of the BOX |V| <= 10, |V'| <= 12 and not of the realizable fibre; its closures stand
       (a closure on a larger domain is a closure on the realizable one);
     - in the BULK (six staples) the reversed pair IS realizable (S1 = u, S1' = -u, the other five staples summing to zero), so the
       bulk refusals from beta = 0.14 stand; but the argmax midpoints at beta = 1.0 and 2.2 -- (0.97, 1.10, 166 deg) and
       (1.02, 1.03, 179 deg) -- lie OUTSIDE the move constraint |V - V'| <= 2 (|V - V'|^2 = 4.22, 4.24: the cell straddled the
       boundary and its midpoint was taken), so the printed 7.365 and 13.39 are withdrawn; the realizable lower bounds there are the
       reversed pair's 18 tau(beta).
   THIS INSTRUMENT composes alpha_su2.c's enclosures unchanged (the file is included; its main renamed) and reads
     (1) THE BULK column again with a REALIZABILITY TEST on the lower bound's point: the reversed pair always; the bound's argmax
         midpoint only when |V - V'| <= 2 exactly, |V'| <= 6, and |V| <= 4 (sufficient: then any unit S1 on the sphere
         {S : |S| = 1, |S + (V' - V)| = 1} leaves |V - S1| <= 5, which five unit staples carry); the point is NAMED on the line;
     (2) THE REALIZABLE FIBRE column: the domain is the Gram triple (a, b, c) = (<S1,S2>, <S1',S2>, <S1,S1'>) in [-1, 1]^3 with
         D(a, b, c) = 1 + 2abc - a^2 - b^2 - c^2 >= 0 (three unit vectors in R^4 realize exactly the positive semidefinite Gram
         matrices; the 2 x 2 minors hold on [-1, 1]); |V|^2 = 2 + 2a, |V'|^2 = 2 + 2b, <V, V'> = 1 + a + b + c, and
         |V - V'|^2 = 2 - 2c <= 4 automatically.  The upper bound: alpha_su2.c's KL bound over every cell whose D can be >= 0 (the
         multilinear 2abc at the cell's corners, the squares at their minima), the cell mapped to intervals of (beta|V|, beta|V'|,
         cos phi) -- a cell near |V| |V'| = 0 takes cos phi in [-1, 1].  The lower bound: the exact TV enclosed (tv_enc, N x N) at a
         STRICTLY realizable point (D > 1e-9) found by a scan of a fast Simpson TV over the PSD grid and a local refinement.
     (3) THE BOX COLUMN OF RECORD (|V| <= 10, |V'| <= 12) beside it, so the two are read together.
   KAT (the known answers, the foreign anchors named): tau(2.2) = L_1(2.2)/I_1(2.2) = 0.735601941590609720 (modified Struve over
   modified Bessel, the single-link influence's closed form, 320 bits at the desk of the author) must lie inside tv_enc(2.2, 2.2, pi);
   the reversed pair's triple (-1/2, -1/2, -1) must be REFUSED by the Gram test (D = -1); D(0, 0, 0) = 1 admitted, D(1, 1, 1) = 0 the
   boundary S1 = S2 = S1' where V = V' and the TV encloses zero; the author's realizable reading at 2.2, 0.6941 (fibre_tv.c, a grid
   reading, at most the true sup), must lie inside this instrument's realizable [lo, hi] at 2.2.
   The assumption is alpha_su2.c's, stated once there: the C library's exp, log, sin, cos within two ulps, every operation carrying
   the margin 1 + 2^-49.  Output in binary mode: LF records. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define main alpha_su2_main
#include "alpha_su2.c"
#undef main

static const double TAU22 = 0.735601941590609720;   /* tau(2.2) = L_1/I_1, the foreign anchor */
static const double IIIE32_REAL22 = 0.6941;          /* the author's realizable reading at 2.2 (fibre_tv.c) */

/* a float Z and a fast Simpson TV for the scans (readings; the certified numbers come from tv_enc) */
static double Zf(double x) { double lo, hi; Z_enc(x, &lo, &hi); return 0.5 * (lo + hi); }
static double tvf(double x1, double x2, double phi, int N) { double z1 = Zf(x1), z2 = Zf(x2), cf = cos(phi), sf = sin(phi), h = M_PI / N, s = 0;
  for (int i = 0; i <= N; i++) { double th = i * h, wi = (i == 0 || i == N) ? 1 : (i % 2 ? 4 : 2); double st = sin(th), ct = cos(th); double f1 = exp(x1 * ct) / z1; double row = 0;
    for (int j = 0; j <= N; j++) { double ps = j * h, wj = (j == 0 || j == N) ? 1 : (j % 2 ? 4 : 2); double c2 = cf * ct + sf * st * cos(ps); double f2 = exp(x2 * c2) / z2; row += wj * fabs(f1 - f2) * sin(ps); }
    s += wi * row * st * st; }
  return 0.5 * s * h * h / 9 / M_PI; }

/* the Gram determinant and its upper end over a cell */
static double gramD(double a, double b, double c) { return 1 + 2 * a * b * c - a * a - b * b - c * c; }
static double sqmin(double lo, double hi) { return (lo <= 0 && hi >= 0) ? 0 : fmin(lo * lo, hi * hi); }
static double gramD_hi(double a0, double a1, double b0, double b1, double c0, double c1) {
  double m = -1e9, as[2] = { a0, a1 }, bs[2] = { b0, b1 }, cs[2] = { c0, c1 };
  for (int i = 0; i < 2; i++) for (int j = 0; j < 2; j++) for (int k = 0; k < 2; k++) { double t = 2 * as[i] * bs[j] * cs[k]; if (t > m) m = t; }
  return up(1 + m - sqmin(a0, a1) - sqmin(b0, b1) - sqmin(c0, c1)) + 1e-12; }

/* a point (a, b, c) to (|V|, |V'|, phi) */
static void gram_point(double a, double b, double c, double *v, double *w, double *phi) {
  *v = sqrt(fmax(0, 2 + 2 * a)); *w = sqrt(fmax(0, 2 + 2 * b)); double d = *v * *w;
  if (d < 1e-12) { *phi = 0; return; } double cf = (1 + a + b + c) / d; if (cf > 1) cf = 1; if (cf < -1) cf = -1; *phi = acos(cf); }

/* a cell of (a, b, c) to intervals of (beta|V|, beta|V'|, cos phi) */
static void gram_cell(double beta, double a0, double a1, double b0, double b1, double c0, double c1,
                      double *x0, double *x1, double *y0, double *y1, double *cf0, double *cf1) {
  double v0 = sqrt(fmax(0, 2 + 2 * a0)), v1 = sqrt(fmax(0, 2 + 2 * a1)), w0 = sqrt(fmax(0, 2 + 2 * b0)), w1 = sqrt(fmax(0, 2 + 2 * b1));
  *x0 = dn(beta * v0); *x1 = up(beta * v1); *y0 = dn(beta * w0); *y1 = up(beta * w1);
  double n0 = 1 + a0 + b0 + c0, n1 = 1 + a1 + b1 + c1, d0 = v0 * w0, d1 = v1 * w1;
  if (d0 < 1e-6) { *cf0 = -1; *cf1 = 1; return; }
  double q[4] = { n0 / d0, n0 / d1, n1 / d0, n1 / d1 }; double lo = q[0], hi = q[0];
  for (int i = 1; i < 4; i++) { if (q[i] < lo) lo = q[i]; if (q[i] > hi) hi = q[i]; }
  lo = dn(lo) - 1e-12; hi = up(hi) + 1e-12; if (lo < -1) lo = -1; if (hi > 1) hi = 1; if (lo > hi) lo = hi; *cf0 = lo; *cf1 = hi; }

/* the upper bound over the realizable fibre: the KL bound's maximum over every cell whose D can be >= 0 */
static double sup_fibre(double beta, int G, double *aa, double *ab, double *ac) { double best = 0; int cells = 0, kept = 0;
  for (int i = 0; i < G; i++) { double a0 = -1 + 2.0 * i / G, a1 = -1 + 2.0 * (i + 1) / G;
    for (int j = 0; j < G; j++) { double b0 = -1 + 2.0 * j / G, b1 = -1 + 2.0 * (j + 1) / G;
      for (int k = 0; k < G; k++) { double c0 = -1 + 2.0 * k / G, c1 = -1 + 2.0 * (k + 1) / G; cells++;
        if (gramD_hi(a0, a1, b0, b1, c0, c1) < 0) continue; kept++;
        double x0, x1, y0, y1, cf0, cf1; gram_cell(beta, a0, a1, b0, b1, c0, c1, &x0, &x1, &y0, &y1, &cf0, &cf1);
        double k1 = kl_hi(x0, x1, y0, y1, cf0, cf1), k2 = kl_hi(y0, y1, x0, x1, cf0, cf1);
        double bd = fmin(tvbound(k1), tvbound(k2)); if (bd > best) { best = bd; *aa = 0.5 * (a0 + a1); *ab = 0.5 * (b0 + b1); *ac = 0.5 * (c0 + c1); } } } }
  (void)cells; (void)kept; return best; }

/* the lower bound: the exact TV enclosed at the best strictly realizable point of a scan (Simpson readings choose; tv_enc certifies) */
static double lo_fibre(double beta, int N, double *pa, double *pb, double *pc, double *tvhi) {
  int S = 24; double ba = 0, bb = 0, bc = 0, bt = -1;
  for (int i = 0; i <= S; i++) for (int j = 0; j <= S; j++) for (int k = 0; k <= S; k++) {
    double a = -1 + 2.0 * i / S, b = -1 + 2.0 * j / S, c = -1 + 2.0 * k / S; if (gramD(a, b, c) <= 1e-9) continue;
    double v, w, phi; gram_point(a, b, c, &v, &w, &phi); double t = tvf(beta * v, beta * w, phi, 60); if (t > bt) { bt = t; ba = a; bb = b; bc = c; } }
  for (int round = 0; round < 3; round++) { double step = (2.0 / S) / (1 << round); double ca = ba, cb = bb, cc = bc;
    for (int i = -4; i <= 4; i++) for (int j = -4; j <= 4; j++) for (int k = -4; k <= 4; k++) {
      double a = ca + i * step / 4, b = cb + j * step / 4, c = cc + k * step / 4;
      if (a < -1 || a > 1 || b < -1 || b > 1 || c < -1 || c > 1 || gramD(a, b, c) <= 1e-9) continue;
      double v, w, phi; gram_point(a, b, c, &v, &w, &phi); double t = tvf(beta * v, beta * w, phi, 100); if (t > bt) { bt = t; ba = a; bb = b; bc = c; } } }
  double v, w, phi, lo, hi; gram_point(ba, bb, bc, &v, &w, &phi); tv_enc(beta * v, beta * w, phi, N, &lo, &hi);
  *pa = ba; *pb = bb; *pc = bc; *tvhi = hi; return lo; }

/* the bulk's lower bound with the realizability test, the point named */
static double lo_bulk(double beta, int N, double av, double aw, double ap, char *where, size_t wn) {
  double lo1, hi1; tv_enc(beta, beta, M_PI, N, &lo1, &hi1); double lo = lo1; snprintf(where, wn, "reversed-pair");
  double d2 = av * av + aw * aw - 2 * av * aw * cos(ap);
  if (d2 <= 4.0 && aw <= 6.0 && av <= 4.0) { double lo2, hi2; tv_enc(beta * av, beta * aw, ap, N, &lo2, &hi2);
    if (lo2 > lo) { lo = lo2; snprintf(where, wn, "argmax(%.2f,%.2f,%.0f)", av, aw, ap * 180 / M_PI); } }
  return lo; }

static int katf(int N, int G) { int bad = 0; double lo, hi;
  tv_enc(2.2, 2.2, M_PI, N, &lo, &hi); printf("KAT tau(2.2) = %.18f (L_1/I_1, the closed form) against the reversed pair's enclosure [%.12f, %.12f]: %s\n", TAU22, lo, hi, (lo <= TAU22 && TAU22 <= hi) ? "INSIDE" : "OUTSIDE"); if (!(lo <= TAU22 && TAU22 <= hi)) bad++;
  double d = gramD(-0.5, -0.5, -1); printf("KAT the reversed pair's Gram triple (-1/2, -1/2, -1): D = %.3f -> %s on a two-staple fibre\n", d, d < 0 ? "REFUSED (unrealizable)" : "ADMITTED"); if (!(d < 0)) bad++;
  double d0 = gramD(0, 0, 0), d1 = gramD(1, 1, 1); printf("KAT D(0,0,0) = %.3f admitted, D(1,1,1) = %.3f the boundary S1 = S2 = S1'\n", d0, d1); if (!(d0 > 0 && fabs(d1) < 1e-12)) bad++;
  tv_enc(2.2 * 2, 2.2 * 2, 0, N, &lo, &hi); printf("KAT at the boundary V = V' (|V| = 2, beta = 2.2) the TV encloses zero: [%.3e, %.3e]\n", lo, hi); if (!(lo <= 0 && hi >= 0)) bad++;
  double v, w, phi; gram_point(-0.5, -0.5, -1, &v, &w, &phi); printf("KAT the map at the reversed triple: |V| %.3f |V'| %.3f phi %.1f deg (the pair itself; the triple is refused above)\n", v, w, phi * 180 / M_PI);
  double aa, ab, ac, pa, pb, pc, tvh; double s = sup_fibre(2.2, G, &aa, &ab, &ac); double l = lo_fibre(2.2, N, &pa, &pb, &pc, &tvh);
  printf("KAT the realizable fibre at beta = 2.2: sup TV in [%.4f, %.4f] (bound argmax a %.3f b %.3f c %.3f; lower point a %.4f b %.4f c %.4f, D = %.4f); the author's reading %.4f %s\n", l, s, aa, ab, ac, pa, pb, pc, gramD(pa, pb, pc), IIIE32_REAL22, (IIIE32_REAL22 <= s + 1e-9 && fabs(l - IIIE32_REAL22) < 0.01) ? "INSIDE" : "OUTSIDE");
  if (!(IIIE32_REAL22 <= s + 1e-9 && fabs(l - IIIE32_REAL22) < 0.01)) bad++;
  printf(bad ? "KAT FAILED %d\n" : "KAT MET\n", bad); return bad; }

int main(int argc, char **argv) { _setmode(_fileno(stdout), _O_BINARY);
  int G = 120, N = 1500;
  if (argc > 1 && !strcmp(argv[1], "--kat")) return katf(argc > 2 ? atoi(argv[2]) : 1500, argc > 3 ? atoi(argv[3]) : 120);
  if (argc > 1) G = atoi(argv[1]); if (argc > 2) N = atoi(argv[2]);
  double betas[64] = { 0.02, 0.03, 0.05, 0.07, 0.09, 0.10, 0.11, 0.12, 0.13, 0.14, 0.15, 0.20, 0.25, 0.30, 0.35, 0.40, 0.45, 0.50, 0.55, 0.60, 0.70, 0.80, 1.0, 2.2 }; int nbeta = 24;
  if (argc > 3 && !strcmp(argv[3], "--betas")) { nbeta = 0; for (int i = 4; i < argc && nbeta < 64; i++) betas[nbeta++] = atof(argv[i]); }   /* a chosen list (the threshold's bisection) */
  printf("ALPHAF the single-site Dobrushin row sum of the SU(2) Wilson weight, m = 1, on the REALIZABLE domains (the correction of alpha_su2.txt): bulk n = 18 over the box |V| <= 6, |V'| <= 8 with the lower bound's point realizability-tested and named; the two-staple fibre n = 6 over the Gram domain {(a,b,c) : 1 + 2abc - a^2 - b^2 - c^2 >= 0}; the box column of record (|V| <= 10, |V'| <= 12) beside it; the KL bound on a %d^3 cell grid, the exact TV enclosed at N = %d\n", G, N);
  for (int bi = 0; bi < nbeta; bi++) { double beta = betas[bi]; double av, aw, ap, av2, aw2, ap2, aa, ab, ac, pa, pb, pc, tvh; char where[64];
    double s18 = sup_hi(beta, 6, 1, G, &av, &aw, &ap); double lob = lo_bulk(beta, N, av, aw, ap, where, sizeof where);
    double sbox = sup_hi(beta, 10, 1, G, &av2, &aw2, &ap2);
    double sf = sup_fibre(beta, G, &aa, &ab, &ac); double lf = lo_fibre(beta, N, &pa, &pb, &pc, &tvh);
    printf("ALPHAF beta=%.3f  bulk[box |V|<=6 |V'|<=8; lower at %s]: sup TV in [%.4f, %.4f] alpha_18 in [%.3f, %.3f] %s  |  fibre[realizable Gram domain]: sup TV in [%.4f, %.4f] (bound argmax a %.2f b %.2f c %.2f; lower point a %.3f b %.3f c %.3f D %.3f -> |V| %.2f |V'| %.2f) alpha_6 in [%.3f, %.3f] %s  |  box-of-record[|V|<=10 |V'|<=12]: alpha_6 <= %.3f\n",
      beta, where, lob, s18, 18 * lob, 18 * s18, 18 * s18 < 1 ? "CERTIFIED-CLOSED" : (18 * lob >= 1 ? "REFUSED" : "open"),
      lf, sf, aa, ab, ac, pa, pb, pc, gramD(pa, pb, pc), sqrt(fmax(0, 2 + 2 * pa)), sqrt(fmax(0, 2 + 2 * pb)), 6 * lf, 6 * sf, 6 * sf < 1 ? "CERTIFIED-CLOSED" : (6 * lf >= 1 ? "REFUSED" : "open"), 6 * sbox);
    fflush(stdout); }
  printf("ALPHAF END\n"); return 0; }
