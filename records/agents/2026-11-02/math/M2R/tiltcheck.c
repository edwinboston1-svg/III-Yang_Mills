/* tiltcheck.c -- the L2 counterpart of Proposition 8.4's (8.7), read on random two-variable laws (double precision; readings).
 * (a) Holley-Stroock on the two-site heat-bath gap: rho(h pi) <= 1 - e^{-o}(1 - rho(pi)), o = osc log h over BOTH variables.
 * (b) product tilts h = a(x) b(y) (no mixed term): is rho(h pi) <= e^{c (oa + ob)} rho(pi), and with which c? (the worst
 *     log(rho'/rho)/(oa + ob) is printed; a mixed-difference form of (8.7) in L2 needs such a multiplicative bound).
 * (c) the same for a pi close to independence (rho small), where an additive form would be useless.
 * usage: tiltcheck SEED   build: gcc -O2 -o tiltcheck.exe tiltcheck.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
static unsigned long long S = 0x9E3779B97F4A7C15ULL;
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
static double maxcorr(int na, int nb, const double *p) { double pa[16] = {0}, pb[16] = {0}, s = 0; for (int i = 0; i < na * nb; i++) s += p[i];
  for (int a = 0; a < na; a++) for (int b = 0; b < nb; b++) { pa[a] += p[a * nb + b] / s; pb[b] += p[a * nb + b] / s; }
  double M[256], H[256], ev[16]; for (int a = 0; a < na; a++) for (int b = 0; b < nb; b++) M[a * nb + b] = p[a * nb + b] / s / sqrt(pa[a] * pb[b]);
  for (int a = 0; a < na; a++) for (int c = 0; c < na; c++) { double t = 0; for (int b = 0; b < nb; b++) t += M[a * nb + b] * M[c * nb + b]; H[a * na + c] = t; }
  jacobi(na, H, ev); return ev[1] > 0 ? sqrt(ev[1]) : 0; }
int main(int argc, char **argv) { if (argc > 1) S ^= (unsigned long long)atoll(argv[1]) * 0xBF58476D1CE4E5B9ULL;
  double worstHS = 0, worstprod = 0, worstprod_small = 0, rho_at = 0, rp_at = 0, oa_at = 0, ob_at = 0;
  for (int t = 0; t < 200000; t++) { int q = 2 + t % 4; double p[256], h[256], pp[256]; double J = (t % 3 == 2) ? 0.02 : 0.3 + 2 * urand();
    for (int a = 0; a < q; a++) for (int b = 0; b < q; b++) p[a * q + b] = exp(0.8 * grand()) * exp(J * grand());   /* J = 0.02: a nearly independent law only if the first factor is a product -- see below */
    if (t % 3 == 2) { double u[16], v[16]; for (int a = 0; a < q; a++) u[a] = exp(grand()); for (int b = 0; b < q; b++) v[b] = exp(grand()); for (int a = 0; a < q; a++) for (int b = 0; b < q; b++) p[a * q + b] = u[a] * v[b] * exp(J * grand()); }
    double r0 = maxcorr(q, q, p);
    /* (a) a general tilt of oscillation o */
    double o = 1.5 * urand(), mn = 1e300, mx = -1e300; for (int i = 0; i < q * q; i++) { h[i] = o * urand(); if (h[i] < mn) mn = h[i]; if (h[i] > mx) mx = h[i]; } double oo = mx - mn;
    for (int i = 0; i < q * q; i++) pp[i] = p[i] * exp(h[i]); double r1 = maxcorr(q, q, pp); double bound = 1 - exp(-oo) * (1 - r0); if (r1 / bound > worstHS) worstHS = r1 / bound;
    /* (b) a product tilt */
    double la[16], lb[16], amn = 1e300, amx = -1e300, bmn = 1e300, bmx = -1e300; double sa = 2 * urand(), sb = 2 * urand();
    for (int a = 0; a < q; a++) { la[a] = sa * urand(); if (la[a] < amn) amn = la[a]; if (la[a] > amx) amx = la[a]; } for (int b = 0; b < q; b++) { lb[b] = sb * urand(); if (lb[b] < bmn) bmn = lb[b]; if (lb[b] > bmx) bmx = lb[b]; }
    double oa = amx - amn, ob = bmx - bmn; for (int a = 0; a < q; a++) for (int b = 0; b < q; b++) pp[a * q + b] = p[a * q + b] * exp(la[a] + lb[b]); double r2 = maxcorr(q, q, pp);
    if (r0 > 1e-6 && oa + ob > 1e-3) { double c = log(r2 / r0) / (oa + ob); if (t % 3 == 2) { if (c > worstprod_small) worstprod_small = c; } else if (c > worstprod) { worstprod = c; rho_at = r0; rp_at = r2; oa_at = oa; ob_at = ob; } } }
  printf("TILT (a) Holley-Stroock: worst rho(h pi) / (1 - e^{-o}(1 - rho(pi))) = %.12f %s\n", worstHS, worstHS <= 1 + 1e-9 ? "[HELD]" : "[FAILS]");
  printf("TILT (b) product tilts: worst log(rho'/rho)/(oa + ob) = %.6f (at rho %.6f -> %.6f, oa %.3f ob %.3f); a multiplicative bound rho' <= e^{c(oa+ob)} rho holds on the sample with c = this value\n", worstprod, rho_at, rp_at, oa_at, ob_at);
  printf("TILT (c) nearly independent laws (rho small): worst log(rho'/rho)/(oa + ob) = %.6f\n", worstprod_small);
  return 0; }
