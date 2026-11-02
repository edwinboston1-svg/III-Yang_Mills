/* hbu1.c -- M7b (2026-11-02): THE TYPICAL DATUM FOR THE ABELIAN CONTROL (a READING: Monte Carlo, never a proof input).
 * U(1) Wilson action S = -beta sum_p cos theta_p on an L^4 torus; heat bath: given the staple sum S = |S| e^{i phi}, the link angle is von Mises
 * with concentration beta |S| about -phi (Best-Fisher sampler).  Measures the n x n loops (n = 1, 2, 4): E[cos Phi_A] (U(1)'s own coefficient,
 * d = 1) and the adjacent coarse pair's connected correlation E[cos Phi_A cos Phi_B] - E[cos]^2, planar and bent, per configuration.
 * usage: hbu1 L beta ntherm nmeas nskip seed */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
static int L, V; static double *T, BETA;
static unsigned long long RS = 88172645463325252ULL;
static double rnd(void) { RS ^= RS << 13; RS ^= RS >> 7; RS ^= RS << 17; return ((RS >> 11) + 0.5) / 9007199254740992.0; }
static int idx(const int *x) { return ((x[0] * L + x[1]) * L + x[2]) * L + x[3]; }
static void shift(const int *x, int mu, int s, int *y) { memcpy(y, x, 4 * sizeof(int)); y[mu] = (y[mu] + s + L) % L; }
static double *lk(const int *x, int mu) { return &T[idx(x) * 4 + mu]; }
static double vonmises(double k) { /* Best-Fisher 1979 */ if (k < 1e-8) return 2 * M_PI * rnd() - M_PI;
  double tau = 1 + sqrt(1 + 4 * k * k), rho = (tau - sqrt(2 * tau)) / (2 * k), r = (1 + rho * rho) / (2 * rho);
  while (1) { double u1 = rnd(), z = cos(M_PI * u1), f = (1 + r * z) / (r + z), c = k * (r - f), u2 = rnd();
    if (c * (2 - c) - u2 > 0 || log(c / u2) + 1 - c >= 0) { double u3 = rnd(); double th = acos(f); return u3 > 0.5 ? th : -th; } } }
static void update(const int *x, int mu) { double sr = 0, si = 0; int xp[4], y[4], z[4]; shift(x, mu, 1, xp);
  for (int nu = 0; nu < 4; nu++) { if (nu == mu) continue;
    shift(x, nu, 1, y); double a = *lk(xp, nu) - *lk(y, mu) - *lk(x, nu); sr += cos(a); si += sin(a);
    shift(xp, nu, -1, z); shift(x, nu, -1, y); double b = -*lk(z, nu) - *lk(y, mu) + *lk(y, nu); sr += cos(b); si += sin(b); }
  double k = sqrt(sr * sr + si * si), phi = atan2(si, sr); *lk(x, mu) = vonmises(BETA * k) - phi; }
static double path(const int *x0, int mu, int len) { double P = 0; int x[4]; memcpy(x, x0, sizeof x);
  if (len >= 0) { for (int i = 0; i < len; i++) { P += *lk(x, mu); shift(x, mu, 1, x); } } else { for (int i = 0; i < -len; i++) { shift(x, mu, -1, x); P -= *lk(x, mu); } } return P; }
static double loop(const int *x, int mu, int nu, int n) { int y[4]; double P = path(x, mu, n); memcpy(y, x, sizeof y); y[mu] = (y[mu] + n) % L;
  P += path(y, nu, n); y[nu] = (y[nu] + n) % L; P += path(y, mu, -n); y[mu] = (y[mu] - n + L) % L; P += path(y, nu, -n); return P; }
int main(int argc, char **argv) {
  if (argc < 7) { fprintf(stderr, "usage: hbu1 L beta ntherm nmeas nskip seed\n"); return 1; }
  L = atoi(argv[1]); BETA = atof(argv[2]); int nth = atoi(argv[3]), nme = atoi(argv[4]), nsk = atoi(argv[5]); RS ^= (unsigned long long)atoll(argv[6]) * 0x9E3779B97F4A7C15ULL;
  V = L * L * L * L; T = calloc(V * 4, sizeof(double)); int ns[3] = { 2, 4, 8 };
  static double cm[3][4096], cp[3][4096], cb[3][4096]; int ncfg = 0;
  for (int sweep = 0; sweep < nth + nme * nsk; sweep++) { int x[4];
    for (x[0] = 0; x[0] < L; x[0]++) for (x[1] = 0; x[1] < L; x[1]++) for (x[2] = 0; x[2] < L; x[2]++) for (x[3] = 0; x[3] < L; x[3]++) for (int mu = 0; mu < 4; mu++) update(x, mu);
    if (sweep >= nth && (sweep - nth) % nsk == nsk - 1 && ncfg < 4096) {
      for (int in = 0; in < 3; in++) { int n = ns[in]; double m = 0, pp = 0, pb = 0, c0 = 0, c1 = 0, c2 = 0;
        for (x[0] = 0; x[0] < L; x[0]++) for (x[1] = 0; x[1] < L; x[1]++) for (x[2] = 0; x[2] < L; x[2]++) for (x[3] = 0; x[3] < L; x[3]++)
          for (int mu = 0; mu < 4; mu++) for (int nu = 0; nu < 4; nu++) { if (mu == nu) continue; double A = cos(loop(x, mu, nu, n));
            if (mu < nu) { m += A; c0++; }
            { int y[4]; shift(x, mu, -n, y); pp += A * cos(loop(y, mu, nu, n)); c1++; }
            for (int rho = 0; rho < 4; rho++) { if (rho == mu || rho == nu) continue; for (int sg = 0; sg < 2; sg++) { int y[4]; if (sg) shift(x, rho, -n, y); else memcpy(y, x, sizeof y); pb += A * cos(loop(y, rho, nu, n)); c2++; } } }
        cm[in][ncfg] = m / c0; cp[in][ncfg] = pp / c1; cb[in][ncfg] = pb / c2; }
      ncfg++; fprintf(stderr, "cfg %d: W11 %.5f W22 %.5f W44 %.6f\n", ncfg, cm[0][ncfg-1], cm[1][ncfg-1], cm[2][ncfg-1]); } }
  printf("HBU1 L=%d beta=%g ntherm=%d nmeas=%d nskip=%d seed=%s: %d configurations\n", L, BETA, nth, nme, nsk, argv[6], ncfg);
  for (int in = 0; in < 3; in++) { double s[3] = { 0 }, v[3] = { 0 }; double *arr[3] = { cm[in], cp[in], cb[in] };
    for (int k = 0; k < 3; k++) { for (int i = 0; i < ncfg; i++) s[k] += arr[k][i]; s[k] /= ncfg; for (int i = 0; i < ncfg; i++) v[k] += (arr[k][i] - s[k]) * (arr[k][i] - s[k]); v[k] = sqrt(v[k] / (ncfg - 1) / ncfg); }
    printf("HBU1-LOOP n=%d E[cos Phi] = %.6e +- %.1e; E[cos Phi_A cos Phi_B] planar %.6e +- %.1e (connected %.3e), bent %.6e +- %.1e (connected %.3e)\n", ns[in], s[0], v[0], s[1], v[1], s[1] - s[0] * s[0], s[2], v[2], s[2] - s[0] * s[0]); }
  return 0; }
