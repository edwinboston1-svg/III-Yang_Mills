/* l2check.c -- the second reader's sighted tests of M2's Proposition 1.1, Lemma 2.1, Theorem 2.3, Proposition 2.5, Lemma 7.2 and
 * Lemmas 5.1/7.1 on random finite systems (double precision; a reading, not a certificate: every inequality is reported as the worst
 * ratio lhs/rhs over the trials, and a ratio above 1 + 1e-9 is a counterexample, printed in full).
 * usage: l2check SEED   build: gcc -O2 -o l2check.exe l2check.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
static unsigned long long S = 88172645463325252ULL;
static double urand(void) { S ^= S << 13; S ^= S >> 7; S ^= S << 17; return (S >> 11) * (1.0 / 9007199254740992.0); }
static double grand(void) { double u = urand() + 1e-300, v = urand(); return sqrt(-2 * log(u)) * cos(2 * M_PI * v); }
/* Jacobi eigenvalues (and vectors) of a real symmetric n x n matrix a (destroyed); ev sorted descending with vectors in columns of V */
static void jacobi(int n, double *a, double *ev, double *V) {
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) V[i * n + j] = (i == j);
  for (int sweep = 0; sweep < 200; sweep++) { double off = 0, tot = 0; for (int p = 0; p < n; p++) for (int q = 0; q < n; q++) { tot += a[p * n + q] * a[p * n + q]; if (q > p) off += a[p * n + q] * a[p * n + q]; } if (off <= 1e-30 * tot || off < 1e-300) break;
    for (int p = 0; p < n; p++) for (int q = p + 1; q < n; q++) { if (fabs(a[p * n + q]) < 1e-300) continue;
      double th = (a[q * n + q] - a[p * n + p]) / (2 * a[p * n + q]); double t = (th >= 0 ? 1 : -1) / (fabs(th) + sqrt(th * th + 1)); double c = 1 / sqrt(t * t + 1), s = t * c;
      for (int k = 0; k < n; k++) { double akp = a[k * n + p], akq = a[k * n + q]; a[k * n + p] = c * akp - s * akq; a[k * n + q] = s * akp + c * akq; }
      for (int k = 0; k < n; k++) { double apk = a[p * n + k], aqk = a[q * n + k]; a[p * n + k] = c * apk - s * aqk; a[q * n + k] = s * apk + c * aqk; }
      for (int k = 0; k < n; k++) { double vkp = V[k * n + p], vkq = V[k * n + q]; V[k * n + p] = c * vkp - s * vkq; V[k * n + q] = s * vkp + c * vkq; } } }
  for (int i = 0; i < n; i++) ev[i] = a[i * n + i];
  for (int i = 0; i < n; i++) for (int j = i + 1; j < n; j++) if (ev[j] > ev[i]) { double t = ev[i]; ev[i] = ev[j]; ev[j] = t; for (int k = 0; k < n; k++) { t = V[k * n + i]; V[k * n + i] = V[k * n + j]; V[k * n + j] = t; } } }
/* maximal correlation of a joint law p[a*nb+b] (positive): the second singular value of p/sqrt(pa pb) */
static double maxcorr(int na, int nb, const double *p) { double pa[64] = {0}, pb[64] = {0}; for (int a = 0; a < na; a++) for (int b = 0; b < nb; b++) { pa[a] += p[a * nb + b]; pb[b] += p[a * nb + b]; }
  double M[64 * 64], H[64 * 64], ev[64], V[64 * 64]; for (int a = 0; a < na; a++) for (int b = 0; b < nb; b++) M[a * nb + b] = p[a * nb + b] / sqrt(pa[a] * pb[b]);
  for (int a = 0; a < na; a++) for (int c = 0; c < na; c++) { double t = 0; for (int b = 0; b < nb; b++) t += M[a * nb + b] * M[c * nb + b]; H[a * na + c] = t; }
  jacobi(na, H, ev, V); double r2 = na > 1 ? ev[1] : 0; return r2 > 0 ? sqrt(r2) : 0; }
/* Dobrushin coefficient of the influence of b on a under joint p: max_{b,b'} TV(p(.|b), p(.|b')) */
static double tvinf(int na, int nb, const double *p) { double best = 0; double pb[64] = {0}; for (int a = 0; a < na; a++) for (int b = 0; b < nb; b++) pb[b] += p[a * nb + b];
  for (int b = 0; b < nb; b++) for (int b2 = b + 1; b2 < nb; b2++) { double t = 0; for (int a = 0; a < na; a++) t += fabs(p[a * nb + b] / pb[b] - p[a * nb + b2] / pb[b2]); if (t / 2 > best) best = t / 2; } return best; }
static double worst[16]; static const char *wname[16] = { "P1.1 chi2 identity |rel err|", "P1.1(iv) ||P^k||_L20 / delta(P^k)", "P1.1(ii) | ||P||_L20 - lam1/lam0 |",
  "L2.1 lz(KyF) / (lz(F) + R ly(F))", "T2.3 (1 - rho(R)) / gap(-L)", "T2.3 |Cov| / (l(F)^T D l(G))", "P2.5 rho_xi^2 / (C(y|z)C(z|y))", "P2.5 R / sqrt(C(y,z)C(z,y))",
  "L7.2 ||(I-Q)PF|| / (||(I-Q)F|| + c||(I-P)F||)", "L5.1 rho_xi(A,B) / (sup rho_w + rhoA rhoB)", "L7.1 rho_xi(A,B) / (sqrt(MA MB) E rho_w + rhoA rhoB)", "T2.3 Var / ((1-rho(R))^-1 sum E Var)",
  "L2.1 tightness: best lz(KyF)/(lz(F)+R ly(F)) over adversarial F", "P2.5 binary pairs: |rho^2 / (C(y|z)C(z|y)) - 1| (EQUALITY expected)", "", "" };
static void upd(int k, double v) { if (v > worst[k]) worst[k] = v; }
/* ---------------------------------------------------------------- Part A: Proposition 1.1 on random symmetric positive kernels */
static void partA(int n, int kk) { double T[64 * 64], A[64 * 64], ev[64], V[64 * 64];
  for (int i = 0; i < n; i++) for (int j = i; j < n; j++) { double x = exp(1.5 * grand()); T[i * n + j] = T[j * n + i] = x; }
  memcpy(A, T, sizeof(double) * n * n); jacobi(n, A, ev, V); double l0 = ev[0]; double psi[64]; double sgn = V[0] > 0 ? 1 : -1; for (int i = 0; i < n; i++) psi[i] = sgn * V[i * n + 0];
  double l1 = 0; for (int i = 1; i < n; i++) if (fabs(ev[i]) > l1) l1 = fabs(ev[i]);
  double P[64 * 64], Pk[64 * 64], tmp[64 * 64]; for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) P[i * n + j] = T[i * n + j] * psi[j] / (l0 * psi[i]);
  memcpy(Pk, P, sizeof(double) * n * n); for (int s = 1; s < kk; s++) { for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) { double t = 0; for (int m = 0; m < n; m++) t += Pk[i * n + m] * P[m * n + j]; tmp[i * n + j] = t; } memcpy(Pk, tmp, sizeof(double) * n * n); }
  double pi[64]; for (int i = 0; i < n; i++) pi[i] = psi[i] * psi[i];
  double chi2 = 0; for (int x = 0; x < n; x++) { double c = 0; for (int y = 0; y < n; y++) { double d = Pk[x * n + y] / pi[y]; c += (d - 1) * (d - 1) * pi[y]; } chi2 += c * pi[x]; }
  double sum = 0; for (int i = 1; i < n; i++) sum += pow(ev[i] / l0, 2 * kk);
  upd(0, fabs(chi2 - sum) / (sum + 1e-300));
  double delta = 0; for (int x = 0; x < n; x++) for (int y = x + 1; y < n; y++) { double t = 0; for (int z = 0; z < n; z++) t += fabs(Pk[x * n + z] - Pk[y * n + z]); if (t / 2 > delta) delta = t / 2; }
  /* ||P^k|| on L^2_0(pi) via the symmetrisation D P^k D^-1, projected off psi */
  double Sm[64 * 64]; for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) Sm[i * n + j] = psi[i] * Pk[i * n + j] / psi[j];
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) Sm[i * n + j] -= pow(1.0, kk) * psi[i] * psi[j];
  double SS[64 * 64]; for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) { double t = 0; for (int m = 0; m < n; m++) t += Sm[m * n + i] * Sm[m * n + j]; SS[i * n + j] = t; }
  jacobi(n, SS, ev, V); double nrm = sqrt(ev[0] > 0 ? ev[0] : 0);
  upd(1, nrm / delta); upd(2, fabs(pow(nrm, 1.0 / kk) - l1 / l0)); }
/* ---------------------------------------------------------------- Part B: Lemma 2.1, Theorem 2.3, Proposition 2.5 */
static int NS, Q, NST; static double LAM[4096];
static int dig(int x, int s) { for (int i = 0; i < s; i++) x /= Q; return x % Q; }
static int setd(int x, int s, int v) { int p = 1; for (int i = 0; i < s; i++) p *= Q; return x - dig(x, s) * p + v * p; }
static void Kop(int y, const double *F, double *out) { for (int x = 0; x < NST; x++) { double z = 0, acc = 0; for (int a = 0; a < Q; a++) { int xa = setd(x, y, a); z += LAM[xa]; acc += LAM[xa] * F[xa]; } out[x] = acc / z; } }
static double l2n(const double *F) { double t = 0; for (int x = 0; x < NST; x++) t += LAM[x] * F[x] * F[x]; return sqrt(t); }
static double ell(int y, const double *F) { double K[4096], D[4096]; Kop(y, F, K); for (int x = 0; x < NST; x++) D[x] = F[x] - K[x]; return l2n(D); }
static void partB(int ns, int q, double strength) { NS = ns; Q = q; NST = 1; for (int i = 0; i < ns; i++) NST *= q;
  double J[8][8][8][8], h[8][8]; for (int i = 0; i < ns; i++) for (int a = 0; a < q; a++) h[i][a] = grand();
  for (int i = 0; i < ns; i++) for (int j = 0; j < ns; j++) for (int a = 0; a < q; a++) for (int b = 0; b < q; b++) J[i][j][a][b] = (i < j) ? strength * grand() : 0;
  double Z = 0; for (int x = 0; x < NST; x++) { double e = 0; for (int i = 0; i < ns; i++) { e += h[i][dig(x, i)]; for (int j = i + 1; j < ns; j++) e += J[i][j][dig(x, i)][dig(x, j)]; } LAM[x] = exp(e); Z += LAM[x]; }
  for (int x = 0; x < NST; x++) LAM[x] /= Z;
  /* R, C, the currency */
  double R[8][8] = {{0}}, C[8][8] = {{0}};
  for (int y = 0; y < ns; y++) for (int z = 0; z < ns; z++) { if (y == z) continue;
    for (int x = 0; x < NST; x++) { if (dig(x, y) || dig(x, z)) continue;   /* x enumerates the environments xi (digits y, z zero) */
      double p[64]; for (int a = 0; a < q; a++) for (int b = 0; b < q; b++) p[a * q + b] = LAM[setd(setd(x, y, a), z, b)];
      double s = 0; for (int i = 0; i < q * q; i++) s += p[i]; for (int i = 0; i < q * q; i++) p[i] /= s;
      double rho = maxcorr(q, q, p); double cyz = tvinf(q, q, p); double pt[64]; for (int a = 0; a < q; a++) for (int b = 0; b < q; b++) pt[b * q + a] = p[a * q + b]; double czy = tvinf(q, q, pt);
      if (rho > R[y][z]) R[y][z] = rho; if (cyz > C[y][z]) C[y][z] = cyz;   /* C[y][z]: influence of z on y */
      if (cyz * czy > 1e-14) { if (q == 2) upd(13, fabs(rho * rho / (cyz * czy) - 1)); else upd(6, rho * rho / (cyz * czy)); } } }
  for (int y = 0; y < ns; y++) for (int z = 0; z < ns; z++) if (y != z && C[y][z] * C[z][y] > 1e-14) upd(7, R[y][z] / sqrt(C[y][z] * C[z][y]));
  double Rm[64], ev[64], V[64 * 64]; for (int y = 0; y < ns; y++) for (int z = 0; z < ns; z++) Rm[y * ns + z] = R[y][z]; double Rc[64]; memcpy(Rc, Rm, sizeof Rc); jacobi(ns, Rc, ev, V); double rhoR = ev[0];
  /* gap of -L via the symmetrisation of sum_y K_y */
  static double Lm[4096 * 64]; if (NST > 81) return;
  static double Lsym[81 * 81], evL[81], VL[81 * 81]; for (int i = 0; i < NST * NST; i++) Lsym[i] = 0;
  for (int y = 0; y < ns; y++) for (int x = 0; x < NST; x++) { double zz = 0; for (int a = 0; a < q; a++) zz += LAM[setd(x, y, a)]; for (int a = 0; a < q; a++) { int xa = setd(x, y, a); Lsym[x * NST + xa] += sqrt(LAM[x]) * (LAM[xa] / zz) / sqrt(LAM[xa]); } }
  for (int x = 0; x < NST; x++) Lsym[x * NST + x] -= ns;
  jacobi(NST, Lsym, evL, VL); double gap = -evL[1];
  if (rhoR < 1) upd(4, (1 - rhoR) / gap);
  (void)Lm;
  /* (I - R)^-1 */
  double D[64]; { double A2[64], inv[64]; for (int i = 0; i < ns; i++) for (int j = 0; j < ns; j++) { A2[i * ns + j] = (i == j) - Rm[i * ns + j]; inv[i * ns + j] = (i == j); }
    for (int c = 0; c < ns; c++) { int piv = c; for (int r = c + 1; r < ns; r++) if (fabs(A2[r * ns + c]) > fabs(A2[piv * ns + c])) piv = r;
      for (int k = 0; k < ns; k++) { double t = A2[c * ns + k]; A2[c * ns + k] = A2[piv * ns + k]; A2[piv * ns + k] = t; t = inv[c * ns + k]; inv[c * ns + k] = inv[piv * ns + k]; inv[piv * ns + k] = t; }
      double d = A2[c * ns + c]; for (int k = 0; k < ns; k++) { A2[c * ns + k] /= d; inv[c * ns + k] /= d; }
      for (int r = 0; r < ns; r++) if (r != c) { double f = A2[r * ns + c]; for (int k = 0; k < ns; k++) { A2[r * ns + k] -= f * A2[c * ns + k]; inv[r * ns + k] -= f * inv[c * ns + k]; } } }
    memcpy(D, inv, sizeof D); }
  for (int trial = 0; trial < 60; trial++) { double F[4096], G[4096], KF[4096];
    int mode = trial % 3;   /* 0: dense random; 1: a function of two sites; 2: a smooth function of the sum */
    for (int x = 0; x < NST; x++) { if (mode == 0) { F[x] = grand(); G[x] = grand(); } else if (mode == 1) { F[x] = sin(1.3 * dig(x, 0) + 0.7 * dig(x, 1) + trial); G[x] = cos(0.9 * dig(x, ns - 1) + 2.1 * dig(x, ns - 2) * trial); }
      else { int s = 0; for (int i = 0; i < ns; i++) s += dig(x, i) * (i + 1); F[x] = cos(0.37 * s + trial); G[x] = sin(0.53 * s * s / (1.0 + ns) - trial); } }
    for (int y = 0; y < ns; y++) { Kop(y, F, KF); for (int z = 0; z < ns; z++) { if (z == y) continue; double lhs = ell(z, KF), rhs = ell(z, F) + R[y][z] * ell(y, F); if (rhs > 1e-14) upd(3, lhs / rhs); } }
    double mF = 0, mG = 0, mFG = 0; for (int x = 0; x < NST; x++) { mF += LAM[x] * F[x]; mG += LAM[x] * G[x]; mFG += LAM[x] * F[x] * G[x]; }
    double lF[8], lG[8]; for (int y = 0; y < ns; y++) { lF[y] = ell(y, F); lG[y] = ell(y, G); }
    double bound = 0; for (int x = 0; x < ns; x++) for (int y = 0; y < ns; y++) bound += lF[x] * D[x * ns + y] * lG[y];
    if (rhoR < 1 && bound > 1e-14) upd(5, fabs(mFG - mF * mG) / bound);
    double var = 0; for (int x = 0; x < NST; x++) var += LAM[x] * (F[x] - mF) * (F[x] - mF); double se = 0; for (int y = 0; y < ns; y++) se += lF[y] * lF[y];
    if (rhoR < 1) upd(11, var / (se / (1 - rhoR))); }
  /* adversarial F for Lemma 2.1: F = the top singular function pair at the worst environment, and its perturbations */
  for (int y = 0; y < ns; y++) for (int z = 0; z < ns; z++) { if (y == z) continue; double bestr = 0;
    for (int trial = 0; trial < 40; trial++) { double F[4096], KF[4096]; double al = urand() * 2 - 1, be = urand() * 2 - 1;
      for (int x = 0; x < NST; x++) F[x] = al * sin(2.0 * dig(x, y) + trial) + be * cos(1.7 * dig(x, z) - 0.3 * trial) + 0.2 * grand() * (trial % 2);
      Kop(y, F, KF); double lhs = ell(z, KF), rhs = ell(z, F) + R[y][z] * ell(y, F); if (rhs > 1e-14 && lhs / rhs > bestr) bestr = lhs / rhs; }
    upd(12, bestr); } }
/* ---------------------------------------------------------------- Part C: Lemma 7.2 on random subspaces with a planted intersection */
static void partC(int n, int dm, int dn, int dint) { double Mb[64 * 64], Nb[64 * 64]; int mm = dm + dint, nn = dn + dint;
  double common[64 * 64]; for (int i = 0; i < n * dint; i++) common[i] = grand();
  for (int i = 0; i < n; i++) { for (int k = 0; k < dint; k++) { Mb[i * mm + k] = common[i * dint + k]; Nb[i * nn + k] = common[i * dint + k]; } for (int k = dint; k < mm; k++) Mb[i * mm + k] = grand(); for (int k = dint; k < nn; k++) Nb[i * nn + k] = grand(); }
  /* projections by Gram-Schmidt */
  double P[64 * 64], Qp[64 * 64], Pn[64 * 64];
  double *bases[3] = { Mb, Nb, common }; int dims[3] = { mm, nn, dint }; double *outs[3] = { P, Qp, Pn };
  for (int w = 0; w < 3; w++) { int d = dims[w]; double *B = bases[w]; double Ob[64 * 64]; int r = 0;
    for (int k = 0; k < d; k++) { double v[64]; for (int i = 0; i < n; i++) v[i] = B[i * d + k];
      for (int it = 0; it < 2; it++) for (int j = 0; j < r; j++) { double dp = 0; for (int i = 0; i < n; i++) dp += v[i] * Ob[i * 64 + j]; for (int i = 0; i < n; i++) v[i] -= dp * Ob[i * 64 + j]; }
      double nv = 0; for (int i = 0; i < n; i++) nv += v[i] * v[i]; nv = sqrt(nv); if (nv < 1e-10) continue; for (int i = 0; i < n; i++) Ob[i * 64 + r] = v[i] / nv; r++; }
    for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) { double t = 0; for (int k = 0; k < r; k++) t += Ob[i * 64 + k] * Ob[j * 64 + k]; outs[w][i * n + j] = t; } }
  if (dint == 0) for (int i = 0; i < n * n; i++) Pn[i] = 0;
  double X[64 * 64]; for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) { double t = 0; for (int k = 0; k < n; k++) t += P[i * n + k] * Qp[k * n + j]; X[i * n + j] = t - Pn[i * n + j]; }
  double XX[64 * 64], ev[64], V[64 * 64]; for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) { double t = 0; for (int k = 0; k < n; k++) t += X[k * n + i] * X[k * n + j]; XX[i * n + j] = t; } jacobi(n, XX, ev, V); double c = sqrt(ev[0] > 0 ? ev[0] : 0);
  for (int trial = 0; trial < 400; trial++) { double F[64], PF[64], a1[64], a2[64], a3[64];
    for (int i = 0; i < n; i++) F[i] = grand(); if (trial % 4 == 1) { for (int i = 0; i < n; i++) { double t = 0; for (int k = 0; k < n; k++) t += P[i * n + k] * F[k]; F[i] = t + 0.05 * grand(); } }
    for (int i = 0; i < n; i++) { double t = 0; for (int k = 0; k < n; k++) t += P[i * n + k] * F[k]; PF[i] = t; }
    double n1 = 0, n2 = 0, n3 = 0; for (int i = 0; i < n; i++) { double t1 = 0, t2 = 0; for (int k = 0; k < n; k++) { t1 += Qp[i * n + k] * PF[k]; t2 += Qp[i * n + k] * F[k]; } a1[i] = PF[i] - t1; a2[i] = F[i] - t2; a3[i] = F[i] - PF[i]; n1 += a1[i] * a1[i]; n2 += a2[i] * a2[i]; n3 += a3[i] * a3[i]; }
    double rhs = sqrt(n2) + c * sqrt(n3); if (rhs > 1e-12) upd(8, sqrt(n1) / rhs); } }
/* ---------------------------------------------------------------- Part D: Lemmas 5.1 and 7.1: A, B, xi, w2 with xi a function of omega = (xi, w2) */
static void partD(int q, int qw, double strength) { int n = q * q * qw * qw; double p[16384];
  double Jab[8][8], Jaw[8][8], Jbw[8][8], Jax[8][8], Jbx[8][8], Jxw[8][8]; for (int a = 0; a < 8; a++) for (int b = 0; b < 8; b++) { Jab[a][b] = 0.6 * strength * grand(); Jaw[a][b] = strength * grand(); Jbw[a][b] = strength * grand(); Jax[a][b] = strength * grand(); Jbx[a][b] = strength * grand(); Jxw[a][b] = grand(); }
  double Z = 0; for (int a = 0; a < q; a++) for (int b = 0; b < q; b++) for (int x = 0; x < qw; x++) for (int w = 0; w < qw; w++) { double e = Jab[a][b] + Jaw[a][w] + Jbw[b][w] + Jax[a][x] + Jbx[b][x] + Jxw[x][w]; int i = ((a * q + b) * qw + x) * qw + w; p[i] = exp(e); Z += p[i]; }
  (void)n; for (int x = 0; x < qw; x++) { /* condition on xi = x */
    double pab[64] = {0}, paw[64] = {0}, pbw[64] = {0}, pw[64] = {0}, s = 0; double supro = 0, Ero = 0, MA = 0, MB = 0;
    for (int a = 0; a < q; a++) for (int b = 0; b < q; b++) for (int w = 0; w < qw; w++) s += p[((a * q + b) * qw + x) * qw + w];
    for (int a = 0; a < q; a++) for (int b = 0; b < q; b++) for (int w = 0; w < qw; w++) { double v = p[((a * q + b) * qw + x) * qw + w] / s; pab[a * q + b] += v; paw[a * qw + w] += v; pbw[b * qw + w] += v; pw[w] += v; }
    double pa[8] = {0}, pb[8] = {0}; for (int a = 0; a < q; a++) for (int b = 0; b < q; b++) { pa[a] += pab[a * q + b]; pb[b] += pab[a * q + b]; }
    for (int w = 0; w < qw; w++) { double po[64]; double so = 0; for (int a = 0; a < q; a++) for (int b = 0; b < q; b++) { po[a * q + b] = p[((a * q + b) * qw + x) * qw + w]; so += po[a * q + b]; } for (int i = 0; i < q * q; i++) po[i] /= so;
      double r = maxcorr(q, q, po); if (r > supro) supro = r; Ero += pw[w] * r;
      double poa[8] = {0}, pob[8] = {0}; for (int a = 0; a < q; a++) for (int b = 0; b < q; b++) { poa[a] += po[a * q + b]; pob[b] += po[a * q + b]; }
      for (int a = 0; a < q; a++) if (poa[a] / pa[a] > MA) MA = poa[a] / pa[a]; for (int b = 0; b < q; b++) if (pob[b] / pb[b] > MB) MB = pob[b] / pb[b]; }
    double rxi = maxcorr(q, q, pab), rA = maxcorr(q, qw, paw), rB = maxcorr(q, qw, pbw);
    upd(9, rxi / (supro + rA * rB)); upd(10, rxi / (sqrt(MA * MB) * Ero + rA * rB)); } }
int main(int argc, char **argv) { if (argc > 1) S ^= (unsigned long long)atoll(argv[1]) * 0x9E3779B97F4A7C15ULL; for (int i = 0; i < 16; i++) worst[i] = 0;
  for (int t = 0; t < 300; t++) partA(3 + t % 12, 1 + t % 5);
  int ncases = 0; for (int t = 0; t < 120; t++) { int ns = 3 + t % 2, q = 2 + (t / 2) % 3; if (ns == 4 && q > 3) q = 3; double st = 0.3 + 2.5 * urand(); partB(ns, q, st); ncases++; }
  for (int t = 0; t < 200; t++) partC(8 + t % 8, 1 + t % 3, 1 + (t / 3) % 3, t % 3);
  for (int t = 0; t < 300; t++) partD(2 + t % 3, 2 + (t / 3) % 3, 0.3 + 2 * urand());
  for (int k = 0; k < 14; k++) printf("L2CHECK %-70s worst %.12f %s\n", wname[k], worst[k], (k == 0 || k == 2 || k == 13) ? (worst[k] < 1e-8 ? "[identity MET]" : "[IDENTITY FAILS]") : (k == 12 ? "[tightness, no claim]" : (worst[k] <= 1 + 1e-9 ? "[inequality HELD]" : "[COUNTEREXAMPLE]")));
  printf("L2CHECK cases: 300 kernels, %d Gibbs systems (3-4 sites, 2-4 states, 60 F/G pairs each), 200 projection pairs x 400 vectors, 300 mixture systems x every xi\n", ncases);
  return 0; }
