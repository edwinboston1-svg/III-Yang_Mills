/* hb.c -- M7b (2026-11-02): THE TYPICAL DATUM, READ (a READING, never a proof input: Monte Carlo).
 * SU(2) Wilson action on an L^4 torus at beta (S = -beta/2 sum_p tr U_p), Kennedy-Pendleton heat bath with an overrelaxation-free update,
 * measuring on each saved configuration, over every site and every plane:
 *   the n x n coarse loops (n = 1, 2, 4) -- the holonomy block map's coarse plaquette at one and two blocking steps --
 *   E[chi_1/2(A)], E[chi_1(A)], and the PAIR moments E[chi_a(A) chi_c(B)] (a, c <= 2) for two adjacent coarse n x n loops sharing an edge,
 *   in the PLANAR geometry (B in the same plane, across the shared edge) and the BENT geometry (B in an orthogonal plane, sharing the edge).
 * The average of the pinned two-face object's E[chi_a(A) chi_c(B) | omega] over omega drawn from the Wilson measure IS this marginal moment
 * (the tower property), so these are the fibre-averaged (unconstrained) values the pinned engines bracket.
 * KAT: beta -> 0 gives E[chi_1/2(1x1)] -> beta/2 ... ; the 1x1 plaquette at beta = 2.2 is the literature's 0.5688 (tr U / 2).
 * usage: hb L beta ntherm nmeas nskip seed                  build: gcc -O2 -fopenmp -o hb.exe hb.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
typedef struct { double w, x, y, z; } q4;
static q4 qm(q4 a, q4 b) { q4 r; r.w = a.w*b.w - a.x*b.x - a.y*b.y - a.z*b.z; r.x = a.w*b.x + a.x*b.w + a.y*b.z - a.z*b.y; r.y = a.w*b.y - a.x*b.z + a.y*b.w + a.z*b.x; r.z = a.w*b.z + a.x*b.y - a.y*b.x + a.z*b.w; return r; }
static q4 qc(q4 a) { q4 r = { a.w, -a.x, -a.y, -a.z }; return r; }
static q4 qadd(q4 a, q4 b) { q4 r = { a.w + b.w, a.x + b.x, a.y + b.y, a.z + b.z }; return r; }
static int L, V; static q4 *U; static double BETA;
static unsigned long long RS = 88172645463325252ULL;
static double rnd(void) { RS ^= RS << 13; RS ^= RS >> 7; RS ^= RS << 17; return ((RS >> 11) + 0.5) / 9007199254740992.0; }
static int idx(const int *x) { return ((x[0] * L + x[1]) * L + x[2]) * L + x[3]; }
static void shift(const int *x, int mu, int s, int *y) { memcpy(y, x, 4 * sizeof(int)); y[mu] = (y[mu] + s + L) % L; }
static q4 *lk(const int *x, int mu) { return &U[idx(x) * 4 + mu]; }
static q4 staple(const int *x, int mu) { q4 S = { 0, 0, 0, 0 }; int xp[4], y[4], z[4];
  shift(x, mu, 1, xp);
  for (int nu = 0; nu < 4; nu++) { if (nu == mu) continue;
    /* forward: U_nu(x+mu) U_mu(x+nu)^dag U_nu(x)^dag */
    shift(x, nu, 1, y); q4 a = qm(qm(*lk(xp, nu), qc(*lk(y, mu))), qc(*lk(x, nu))); S = qadd(S, a);
    /* backward: U_nu(x+mu-nu)^dag U_mu(x-nu)^dag U_nu(x-nu) */
    shift(xp, nu, -1, z); shift(x, nu, -1, y); q4 b = qm(qm(qc(*lk(z, nu)), qc(*lk(y, mu))), *lk(y, nu)); S = qadd(S, b); }
  return S; }
/* the local action: beta/2 tr(U_mu(x) S) = beta * Re(U S)_w; heat bath: X = U S/|S| distributed ~ e^{beta k x0} sqrt(1-x0^2) */
static void update(const int *x, int mu) { q4 S = staple(x, mu); double k = sqrt(S.w*S.w + S.x*S.x + S.y*S.y + S.z*S.z); if (k < 1e-12) return;
  q4 Sh = { S.w / k, S.x / k, S.y / k, S.z / k }; double a = BETA * k, x0;
  while (1) { /* Kennedy-Pendleton */ double r1 = rnd(), r2 = rnd(), r3 = rnd(), r4 = rnd(); double c = cos(2 * M_PI * r2);
    double lam2 = -(log(r1) + c * c * log(r3)) / (2 * a); if (r4 * r4 <= 1 - lam2) { x0 = 1 - 2 * lam2; break; } }
  double rr = sqrt(fmax(0, 1 - x0 * x0)), ct = 2 * rnd() - 1, ph = 2 * M_PI * rnd(), st = sqrt(1 - ct * ct);
  q4 X = { x0, rr * st * cos(ph), rr * st * sin(ph), rr * ct };
  *lk(x, mu) = qm(X, qc(Sh)); }   /* U = X S^dag/|S| so that U S/|S| = X */
static q4 path(const int *x0, int mu, int len) { q4 P = { 1, 0, 0, 0 }; int x[4]; memcpy(x, x0, sizeof x);
  if (len >= 0) { for (int i = 0; i < len; i++) { P = qm(P, *lk(x, mu)); shift(x, mu, 1, x); } }
  else { for (int i = 0; i < -len; i++) { shift(x, mu, -1, x); P = qm(P, qc(*lk(x, mu))); } }
  return P; }
/* the n x n loop at x in the (mu, nu) plane, counterclockwise: +mu n, +nu n, -mu n, -nu n */
static q4 loop(const int *x, int mu, int nu, int n) { int y[4]; q4 P = path(x, mu, n); memcpy(y, x, sizeof y); y[mu] = (y[mu] + n) % L;
  P = qm(P, path(y, nu, n)); y[nu] = (y[nu] + n) % L; P = qm(P, path(y, mu, -n)); y[mu] = (y[mu] - n + L) % L; P = qm(P, path(y, nu, -n)); return P; }
static double chi(int s, double w) { double u0 = 1, u1 = 2 * w; if (s == 0) return 1; for (int k = 2; k <= s; k++) { double u2 = 2 * w * u1 - u0; u0 = u1; u1 = u2; } return u1; }
int main(int argc, char **argv) {
  if (argc < 7) { fprintf(stderr, "usage: hb L beta ntherm nmeas nskip seed\n"); return 1; }
  L = atoi(argv[1]); BETA = atof(argv[2]); int nth = atoi(argv[3]), nme = atoi(argv[4]), nsk = atoi(argv[5]); RS ^= (unsigned long long)atoll(argv[6]) * 0x9E3779B97F4A7C15ULL;
  V = L * L * L * L; U = malloc(sizeof(q4) * V * 4); for (int i = 0; i < V * 4; i++) { q4 e = { 1, 0, 0, 0 }; U[i] = e; }
  int ns[3] = { 1, 2, 4 };
  /* accumulators: per n: marginals chi_a (a = 1, 2), planar pair (a,c), bent pair (a,c); per-configuration means kept for error bars */
  static double M[3][3], PP[3][3][3], PB[3][3][3]; static double cfgM[3][3][4096], cfgPP[3][3][3][4096], cfgPB[3][3][3][4096]; int ncfg = 0;
  for (int sweep = 0; sweep < nth + nme * nsk; sweep++) {
    int x[4]; for (x[0] = 0; x[0] < L; x[0]++) for (x[1] = 0; x[1] < L; x[1]++) for (x[2] = 0; x[2] < L; x[2]++) for (x[3] = 0; x[3] < L; x[3]++) for (int mu = 0; mu < 4; mu++) update(x, mu);
    if (sweep >= nth && (sweep - nth) % nsk == nsk - 1 && ncfg < 4096) {
      double m[3][3] = {{0}}, pp[3][3][3] = {{{0}}}, pb[3][3][3] = {{{0}}}; double cnt[3] = { 0 }, cntp[3] = { 0 }, cntb[3] = { 0 };
      for (int in = 0; in < 3; in++) { int n = ns[in];
        for (x[0] = 0; x[0] < L; x[0]++) for (x[1] = 0; x[1] < L; x[1]++) for (x[2] = 0; x[2] < L; x[2]++) for (x[3] = 0; x[3] < L; x[3]++)
          for (int mu = 0; mu < 4; mu++) for (int nu = 0; nu < 4; nu++) { if (mu == nu) continue;
            /* A: the n x n loop in the (mu, nu) plane at x, shared edge = the nu-edge at x (x to x + n nu) */
            q4 A = loop(x, mu, nu, n); double ca[3] = { 1, chi(1, A.w), chi(2, A.w) };
            if (mu < nu) { for (int a = 1; a <= 2; a++) m[in][a] += ca[a]; cnt[in] += 1; }
            /* planar B: the n x n loop in the same plane on the other side of the shared nu-edge: at x - n mu */
            { int y[4]; shift(x, mu, -n, y); q4 B = loop(y, mu, nu, n); double cb[3] = { 1, chi(1, B.w), chi(2, B.w) };
              for (int a = 0; a <= 2; a++) for (int c = 0; c <= 2; c++) pp[in][a][c] += ca[a] * cb[c]; cntp[in] += 1; }
            /* bent B: the n x n loop in the (rho, nu) plane at x sharing the nu-edge, rho != mu, nu (two choices, both orientations of rho) */
            for (int rho = 0; rho < 4; rho++) { if (rho == mu || rho == nu) continue;
              for (int sg = 0; sg < 2; sg++) { int y[4]; if (sg) shift(x, rho, -n, y); else memcpy(y, x, sizeof y); q4 B = loop(y, rho, nu, n); double cb[3] = { 1, chi(1, B.w), chi(2, B.w) };
                for (int a = 0; a <= 2; a++) for (int c = 0; c <= 2; c++) pb[in][a][c] += ca[a] * cb[c]; cntb[in] += 1; } } } }
      for (int in = 0; in < 3; in++) { for (int a = 1; a <= 2; a++) { m[in][a] /= cnt[in]; M[in][a] += m[in][a]; cfgM[in][a][ncfg] = m[in][a]; }
        for (int a = 0; a <= 2; a++) for (int c = 0; c <= 2; c++) { pp[in][a][c] /= cntp[in]; pb[in][a][c] /= cntb[in]; PP[in][a][c] += pp[in][a][c]; PB[in][a][c] += pb[in][a][c]; cfgPP[in][a][c][ncfg] = pp[in][a][c]; cfgPB[in][a][c][ncfg] = pb[in][a][c]; } }
      ncfg++; fprintf(stderr, "cfg %d: plaq %.5f  W22 %.5f  W44 %.6f\n", ncfg, m[0][1] / 2, m[1][1] / 2, m[2][1] / 2); } }
  printf("HB L=%d beta=%g ntherm=%d nmeas=%d nskip=%d seed=%s: %d configurations\n", L, BETA, nth, nme, nsk, argv[6], ncfg);
  for (int in = 0; in < 3; in++) { int n = ns[in];
    for (int a = 1; a <= 2; a++) { double mu_ = M[in][a] / ncfg, v = 0; for (int i = 0; i < ncfg; i++) v += (cfgM[in][a][i] - mu_) * (cfgM[in][a][i] - mu_); double se = sqrt(v / (ncfg - 1) / ncfg);
      printf("HB-MARG n=%d a=%d E[chi_a(A)] = %+.8e +- %.2e   aprime = %+.8e\n", n, a, mu_, se, mu_ / (a + 1)); }
    for (int g = 0; g < 2; g++) for (int a = 0; a <= 2; a++) for (int c = 0; c <= 2; c++) { double *P = g ? &PB[in][a][c] : &PP[in][a][c]; double mu_ = *P / ncfg, v = 0;
        for (int i = 0; i < ncfg; i++) { double t = g ? cfgPB[in][a][c][i] : cfgPP[in][a][c][i]; v += (t - mu_) * (t - mu_); } double se = sqrt(v / (ncfg - 1) / ncfg);
        printf("W2-CLASS a=%d c=%d E[chi_a(A) chi_c(B)] = %+.12e (geometry %s n=%d; MC stat err %.2e)\n", 2 * 0 + a, c, mu_, g ? "BENT" : "PLANAR", n, se); } }
  return 0; }
