/* tilt2.c -- the second reader's L2 form of (8.7), tested: for a law pi of (X, Y) and a tilt e^delta,
 *   rho(e^delta pi) <= e^{(o_X + o_Y)/2} rho(pi) + 1 - e^{-2 Delta},
 * o_X = max_y osc_x delta(x, y), o_Y = max_x osc_y delta(x, y), Delta = max_{y, y'} osc_x [delta(x, y) - delta(x, y')] (the mixed difference).
 * Proof on the page REVIEW.md (product tilt: M' = D1 M D2 and Weyl's sigma_2(rank one + B) <= ||B||; mixed part: Holley-Stroock on the two-site gap). */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
static unsigned long long S = 0x123456789ABCDEFULL;
static double urand(void) { S ^= S << 13; S ^= S >> 7; S ^= S << 17; return (S >> 11) * (1.0 / 9007199254740992.0); }
static double grand(void) { double u = urand() + 1e-300, v = urand(); return sqrt(-2 * log(u)) * cos(2 * M_PI * v); }
static void jacobi(int n, double *a, double *ev) {
  for (int sweep = 0; sweep < 300; sweep++) { double off = 0, tot = 0; for (int p = 0; p < n; p++) for (int q = 0; q < n; q++) { tot += a[p * n + q] * a[p * n + q]; if (q > p) off += a[p * n + q] * a[p * n + q]; } if (off <= 1e-30 * tot || off < 1e-300) break;
    for (int p = 0; p < n; p++) for (int q = p + 1; q < n; q++) { if (fabs(a[p * n + q]) < 1e-300) continue;
      double th = (a[q * n + q] - a[p * n + p]) / (2 * a[p * n + q]); double t = (th >= 0 ? 1 : -1) / (fabs(th) + sqrt(th * th + 1)); double c = 1 / sqrt(t * t + 1), s = t * c;
      for (int k = 0; k < n; k++) { double akp = a[k * n + p], akq = a[k * n + q]; a[k * n + p] = c * akp - s * akq; a[k * n + q] = s * akp + c * akq; }
      for (int k = 0; k < n; k++) { double apk = a[p * n + k], aqk = a[q * n + k]; a[p * n + k] = c * apk - s * aqk; a[q * n + k] = s * apk + c * aqk; } } }
  for (int i = 0; i < n; i++) ev[i] = a[i * n + i];
  for (int i = 0; i < n; i++) for (int j = i + 1; j < n; j++) if (ev[j] > ev[i]) { double t = ev[i]; ev[i] = ev[j]; ev[j] = t; } }
static double maxcorr(int n, const double *p) { double pa[16] = {0}, pb[16] = {0}, s = 0; for (int i = 0; i < n * n; i++) s += p[i];
  for (int a = 0; a < n; a++) for (int b = 0; b < n; b++) { pa[a] += p[a * n + b] / s; pb[b] += p[a * n + b] / s; }
  double M[256], H[256], ev[16]; for (int a = 0; a < n; a++) for (int b = 0; b < n; b++) M[a * n + b] = p[a * n + b] / s / sqrt(pa[a] * pb[b]);
  for (int a = 0; a < n; a++) for (int c = 0; c < n; c++) { double t = 0; for (int b = 0; b < n; b++) t += M[a * n + b] * M[c * n + b]; H[a * n + c] = t; }
  jacobi(n, H, ev); return ev[1] > 0 ? sqrt(ev[1]) : 0; }
int main(int argc, char **argv) { if (argc > 1) S ^= (unsigned long long)atoll(argv[1]) * 0x9E3779B97F4A7C15ULL; double worst = 0, wr0 = 0, wr1 = 0, wb = 0; long n_tight = 0;
  for (int t = 0; t < 300000; t++) { int q = 2 + t % 4; double p[256], d[256], pp[256]; double J = 0.05 + 2.5 * urand();
    for (int i = 0; i < q * q; i++) p[i] = exp(0.7 * grand() + J * grand());
    double s1 = 2 * urand(), s2 = 2 * urand(), s12 = (t % 4 == 0) ? 0 : 0.6 * urand(); double g1[16], g2[16];
    for (int a = 0; a < q; a++) g1[a] = grand(); for (int b = 0; b < q; b++) g2[b] = grand();
    for (int a = 0; a < q; a++) for (int b = 0; b < q; b++) d[a * q + b] = s1 * g1[a] + s2 * g2[b] + s12 * grand();
    double oX = 0, oY = 0, Dl = 0;
    for (int b = 0; b < q; b++) { double mn = 1e300, mx = -1e300; for (int a = 0; a < q; a++) { if (d[a * q + b] < mn) mn = d[a * q + b]; if (d[a * q + b] > mx) mx = d[a * q + b]; } if (mx - mn > oX) oX = mx - mn; }
    for (int a = 0; a < q; a++) { double mn = 1e300, mx = -1e300; for (int b = 0; b < q; b++) { if (d[a * q + b] < mn) mn = d[a * q + b]; if (d[a * q + b] > mx) mx = d[a * q + b]; } if (mx - mn > oY) oY = mx - mn; }
    for (int b = 0; b < q; b++) for (int b2 = 0; b2 < q; b2++) { double mn = 1e300, mx = -1e300; for (int a = 0; a < q; a++) { double v = d[a * q + b] - d[a * q + b2]; if (v < mn) mn = v; if (v > mx) mx = v; } if (mx - mn > Dl) Dl = mx - mn; }
    for (int i = 0; i < q * q; i++) pp[i] = p[i] * exp(d[i]);
    double r0 = maxcorr(q, p), r1 = maxcorr(q, pp), bound = exp((oX + oY) / 2) * r0 + 1 - exp(-2 * Dl);
    if (r1 / bound > worst) { worst = r1 / bound; wr0 = r0; wr1 = r1; wb = bound; } if (r1 / bound > 0.99) n_tight++; }
  printf("TILT2 rho(e^delta pi) <= e^{(oX+oY)/2} rho(pi) + 1 - e^{-2 Delta}: 300000 laws (q = 2..5), worst ratio %.12f (rho %.6f -> %.6f, bound %.6f), %ld within 1%% of the bound %s\n", worst, wr0, wr1, wb, n_tight, worst <= 1 + 1e-9 ? "[HELD]" : "[FAILS]");
  return 0; }
