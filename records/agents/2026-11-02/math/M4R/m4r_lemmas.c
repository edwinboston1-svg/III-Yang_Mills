/* m4r_lemmas.c -- M4R's sighted tests of M4's Lemma 3.1, Corollary 3.1', Lemma 3.2 (i),(ii) on random finite laws, and the
 * hidden-label instance against the converse sentence of Theorem 3.3. Double precision; exact linear algebra on small matrices.
 *
 * A space with a free action of a finite abelian group G of order g is modelled as X = {orbits} x G, x = (o, h), the action
 * k.(o, h) = (o, k+h) (Z_g: addition mod g; Z2xZ2: xor on two bits). The label of x is h (section h = 0).
 * For each random joint law pi(x, y) > 0:
 *   rho      = maximal correlation of (X, Y)               (second singular value of pi/sqrt(piX piY))
 *   rhot     = maximal correlation of the orbits (Xt, Yt)
 *   tauX     = max over orbits o of the maximal correlation of (L_X, Y) under the conditional law given Xt = o; tauY likewise
 *   rho_EE, rho_EO, rho_O.  the block norms of Corollary 3.1' (E = functions of the orbit, O = {f : E[f | Xt] = 0})
 * and the inequalities  rho <= sqrt(rhot^2 + tauX^2 + tauY^2),  rho <= sqrt(rho_EE^2 + rho_EO^2 + rho_O.^2),  rho_O. <= tauX,
 * rho_EO <= tauY, rhot = rho_EE;  Lemma 3.2(i) (G = Z2): rho(L_X,Y|o) = sd(t)/sqrt(1 - t0^2) (identity) and
 * tauX <= (1/4) max_x osc_y F cosh(max|F|/2);  Lemma 3.2(ii): tauX <= 2 sinh(DeltaX), DeltaX = max_x max_k osc_y F_k.
 * A ratio lhs/rhs above 1 + 1e-9 is a counterexample and is printed.
 * build: gcc -O2 -o m4r_lemmas.exe m4r_lemmas.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
static unsigned long long rs = 0x9E3779B97F4A7C15ULL;
static double ur(void) { rs ^= rs << 13; rs ^= rs >> 7; rs ^= rs << 17; return (rs >> 11) * (1.0 / 9007199254740992.0); }
static double nr(void) { double u = ur(), v = ur(); if (u < 1e-300) u = 1e-300; return sqrt(-2 * log(u)) * cos(6.283185307179586 * v); }
static void jac(int n, double *a, double *ev) { double *V = NULL; (void)V;
  for (int sw = 0; sw < 200; sw++) { double off = 0; for (int p = 0; p < n; p++) for (int q = p + 1; q < n; q++) off += a[p * n + q] * a[p * n + q]; if (off < 1e-32) break;
    for (int p = 0; p < n; p++) for (int q = p + 1; q < n; q++) { double apq = a[p * n + q]; if (fabs(apq) < 1e-300) continue;
        double th = (a[q * n + q] - a[p * n + p]) / (2 * apq), t = (th >= 0 ? 1 : -1) / (fabs(th) + sqrt(th * th + 1)), c = 1 / sqrt(t * t + 1), s = t * c;
        for (int k = 0; k < n; k++) { double x = a[k * n + p], y = a[k * n + q]; a[k * n + p] = c * x - s * y; a[k * n + q] = s * x + c * y; }
        for (int k = 0; k < n; k++) { double x = a[p * n + k], y = a[q * n + k]; a[p * n + k] = c * x - s * y; a[q * n + k] = s * x + c * y; } } }
  for (int i = 0; i < n; i++) ev[i] = a[i * n + i]; }
/* singular values of the m x n matrix A (row-major), sorted descending, into sv (min(m,n) of them) */
static void svals(int m, int n, const double *A, double *sv) { int k = n; double *H = calloc((size_t)k * k, sizeof(double)), *ev = malloc(sizeof(double) * k);
  for (int i = 0; i < k; i++) for (int j = 0; j < k; j++) { double s = 0; for (int r = 0; r < m; r++) s += A[r * n + i] * A[r * n + j]; H[i * k + j] = s; }
  jac(k, H, ev); for (int i = 0; i < k; i++) for (int j = i + 1; j < k; j++) if (ev[j] > ev[i]) { double t = ev[i]; ev[i] = ev[j]; ev[j] = t; }
  int r = m < n ? m : n; for (int i = 0; i < r; i++) sv[i] = sqrt(ev[i] > 0 ? ev[i] : 0); free(H); free(ev); }
/* maximal correlation of a joint table P (m x n, positive, any total) */
static double maxcorr(int m, int n, const double *P) { double *a = calloc(m, sizeof(double)), *b = calloc(n, sizeof(double)), tot = 0;
  for (int i = 0; i < m; i++) for (int j = 0; j < n; j++) { a[i] += P[i * n + j]; b[j] += P[i * n + j]; tot += P[i * n + j]; }
  double *M = malloc(sizeof(double) * m * n); for (int i = 0; i < m; i++) for (int j = 0; j < n; j++) M[i * n + j] = P[i * n + j] / sqrt(a[i] * b[j]);
  double sv[64]; svals(m, n, M, sv); double r = (m < 2 || n < 2) ? 0 : sv[1]; free(a); free(b); free(M); return r; }
static int GKIND; static int g_of(void) { return GKIND == 0 ? 2 : GKIND == 1 ? 3 : 4; } /* 0: Z2, 1: Z3, 2: Z2xZ2 */
static int gop(int k, int h) { if (GKIND == 0) return (k + h) & 1; if (GKIND == 1) return (k + h) % 3; return k ^ h; }
int main(void) {
  double worst[12]; const char *nm[12] = { "L3.1: rho/sqrt(rhot^2+tauX^2+tauY^2)", "C3.1': rho/sqrt(rEE^2+rEO^2+rO.^2)", "C3.1': rho_O./tauX", "C3.1': rho_EO/tauY",
    "rhot vs rho_EE |diff|", "L3.2(i) identity |sd(t)/sqrt(1-t0^2) - svd|", "L3.2(i): tauX/((1/4) osc F cosh(max|F|/2))", "L3.2(ii): tauX/(2 sinh DeltaX)",
    "rhot/rho (must be <= 1)", "price: sqrt(rhot^2+tauX^2+tauY^2)/rho (min over cases)", "", "" };
  long ncase = 0;
  for (int GK = 0; GK < 3; GK++) { GKIND = GK; int g = g_of(); for (int w = 0; w < 12; w++) worst[w] = 0; worst[9] = 1e300;
    for (int cs = 0; cs < 6000; cs++) { int mo = 1 + (int)(ur() * 4), no = 1 + (int)(ur() * 4); int m = mo * g, n = no * g; int regime = cs % 4; double s = regime == 0 ? 0.2 : regime == 1 ? 1.0 : regime == 2 ? 3.0 : 6.0;
      double P[1024]; double Z = 0;
      for (int i = 0; i < m; i++) for (int j = 0; j < n; j++) { double e = regime == 3 ? s * (ur() < 0.15 ? nr() : 0.05 * nr()) : s * nr(); P[i * n + j] = exp(e); Z += P[i * n + j]; }
      for (int t = 0; t < m * n; t++) P[t] /= Z;
      /* index: x = o*g + h */
      double rho = maxcorr(m, n, P);
      double Pt[64]; for (int a = 0; a < mo; a++) for (int b = 0; b < no; b++) { double s2 = 0; for (int h = 0; h < g; h++) for (int k = 0; k < g; k++) s2 += P[(a * g + h) * n + (b * g + k)]; Pt[a * no + b] = s2; }
      double rhot = (mo > 1 && no > 1) ? maxcorr(mo, no, Pt) : 0;
      double tauX = 0, tauY = 0, idd = 0, b32i = 0, DX = 0;
      for (int a = 0; a < mo; a++) { double C[256]; for (int h = 0; h < g; h++) for (int j = 0; j < n; j++) C[h * n + j] = P[(a * g + h) * n + j]; double r = maxcorr(g, n, C); if (r > tauX) tauX = r;
        if (g == 2) { /* Lemma 3.2(i) identity and bound */
          double S0 = 0, S1 = 0, S2 = 0, pa0 = 0, pa1 = 0, Fmx = -1e300, Fmn = 1e300, oscF = 0; for (int j = 0; j < n; j++) { pa0 += C[j]; pa1 += C[n + j]; }
          double t0 = (pa0 - pa1) / (pa0 + pa1); for (int j = 0; j < n; j++) { double t = (C[j] - C[n + j]) / (C[j] + C[n + j]), om = C[j] + C[n + j]; S0 += om; S1 += om * t; double F = log(C[j] / C[n + j]); if (F > Fmx) Fmx = F; if (F < Fmn) Fmn = F; }
          double mean = S1 / S0; for (int j = 0; j < n; j++) { double t = (C[j] - C[n + j]) / (C[j] + C[n + j]), om = C[j] + C[n + j]; S2 += om * (t - mean) * (t - mean); }
          double rr = sqrt(S2 / S0) / sqrt(1 - t0 * t0); if (fabs(rr - r) > idd) idd = fabs(rr - r); oscF = Fmx - Fmn; double maxF = fmax(fabs(Fmx), fabs(Fmn));
          /* the bound uses ess sup over x of osc and ess sup |F|: take per-orbit values and the global max below */
          static double gosc, gmax; if (a == 0) { gosc = 0; gmax = 0; } if (oscF > gosc) gosc = oscF; if (maxF > gmax) gmax = maxF; b32i = 0.25 * gosc * cosh(0.5 * gmax); }
        /* Lemma 3.2(ii): F_k(x,y) = log p(x,y) - log p(kx,y), osc over y, max over x in the orbit and k */
        for (int h = 0; h < g; h++) for (int k = 1; k < g; k++) { double mx = -1e300, mn = 1e300; int hk = gop(k, h); for (int j = 0; j < n; j++) { double F = log(C[h * n + j] / C[hk * n + j]); if (F > mx) mx = F; if (F < mn) mn = F; } if (mx - mn > DX) DX = mx - mn; } }
      for (int b = 0; b < no; b++) { double C[256]; for (int k = 0; k < g; k++) for (int i = 0; i < m; i++) C[k * m + i] = P[i * n + (b * g + k)]; double r = maxcorr(g, m, C); if (r > tauY) tauY = r; }
      /* Corollary 3.1' blocks in normalised coordinates */
      double pX[64] = {0}, pY[64] = {0}; for (int i = 0; i < m; i++) for (int j = 0; j < n; j++) { pX[i] += P[i * n + j]; pY[j] += P[i * n + j]; }
      double M[1024]; for (int i = 0; i < m; i++) for (int j = 0; j < n; j++) M[i * n + j] = P[i * n + j] / sqrt(pX[i] * pY[j]);
      /* orthonormal bases: E_X spanned by e_o (sqrt pX on orbit o, normalised); O_X = orthogonal complement inside each orbit block (Gram-Schmidt) */
      double BX[64 * 64], BY[64 * 64]; int isE_X[64], isE_Y[64]; int cX = 0, cY = 0;
      for (int pass = 0; pass < 2; pass++) { int mm = pass ? n : m, oo = pass ? no : mo; double *pp = pass ? pY : pX, *B = pass ? BY : BX; int *isE = pass ? isE_Y : isE_X; int c = 0;
        for (int o = 0; o < oo; o++) { /* E vector */ double nn = 0; for (int h = 0; h < g; h++) nn += pp[o * g + h]; for (int i = 0; i < mm; i++) B[c * mm + i] = 0; for (int h = 0; h < g; h++) B[c * mm + o * g + h] = sqrt(pp[o * g + h] / nn); isE[c] = 1; c++;
          for (int h = 1; h < g; h++) { double v[64] = {0}; v[o * g + h] = 1; for (int d = c - h; d < c; d++) { double s2 = 0; for (int i = 0; i < mm; i++) s2 += v[i] * B[d * mm + i]; for (int i = 0; i < mm; i++) v[i] -= s2 * B[d * mm + i]; }
            double nv = 0; for (int i = 0; i < mm; i++) nv += v[i] * v[i]; nv = sqrt(nv); for (int i = 0; i < mm; i++) B[c * mm + i] = v[i] / nv; isE[c] = 0; c++; } }
        if (pass) cY = c; else cX = c; }
      /* Mh = BX M BY^T, then remove the constant pair (the E-vectors' combination sqrt(pX)) by deflation in the EE block */
      double Mh[1024]; for (int a = 0; a < cX; a++) for (int b = 0; b < cY; b++) { double s2 = 0; for (int i = 0; i < m; i++) for (int j = 0; j < n; j++) s2 += BX[a * m + i] * M[i * n + j] * BY[b * n + j]; Mh[a * cY + b] = s2; }
      double ue[64], ve[64]; int nE = 0, nEy = 0; for (int a = 0; a < cX; a++) if (isE_X[a]) { double s2 = 0; for (int i = 0; i < m; i++) s2 += BX[a * m + i] * sqrt(pX[i]); ue[nE++] = s2; }
      for (int b = 0; b < cY; b++) if (isE_Y[b]) { double s2 = 0; for (int j = 0; j < n; j++) s2 += BY[b * n + j] * sqrt(pY[j]); ve[nEy++] = s2; }
      double EE[256], EO[1024], OR[1024]; int ia = 0; int nO = cX - nE, nOy = cY - nEy;
      for (int a = 0; a < cX; a++) { if (!isE_X[a]) continue; int jb = 0, ko = 0; for (int b = 0; b < cY; b++) { if (isE_Y[b]) EE[ia * nEy + jb++] = Mh[a * cY + b]; else EO[ia * nOy + ko++] = Mh[a * cY + b]; } ia++; }
      for (int a = 0; a < nE; a++) for (int b = 0; b < nEy; b++) EE[a * nEy + b] -= ue[a] * ve[b];
      int io = 0; for (int a = 0; a < cX; a++) { if (isE_X[a]) continue; for (int b = 0; b < cY; b++) OR[io * cY + b] = Mh[a * cY + b]; io++; }
      double sv[64]; svals(nE, nEy, EE, sv); double rEE = sv[0];
      double rEO = 0; if (nOy > 0) { svals(nE, nOy, EO, sv); rEO = sv[0]; }
      double rOd = 0; if (nO > 0) { svals(nO, cY, OR, sv); rOd = sv[0]; }
      double L31 = sqrt(rhot * rhot + tauX * tauX + tauY * tauY), EXB = sqrt(rEE * rEE + rEO * rEO + rOd * rOd);
      double r0 = rho / fmax(L31, 1e-300), r1 = rho / fmax(EXB, 1e-300), r2 = tauX > 1e-14 ? rOd / tauX : 0, r3 = tauY > 1e-14 ? rEO / tauY : 0;
      if (r0 > worst[0]) worst[0] = r0; if (r1 > worst[1]) worst[1] = r1; if (r2 > worst[2]) worst[2] = r2; if (r3 > worst[3]) worst[3] = r3;
      if (fabs(rhot - rEE) > worst[4]) worst[4] = fabs(rhot - rEE); if (idd > worst[5]) worst[5] = idd;
      if (g == 2 && b32i > 0 && tauX / b32i > worst[6]) worst[6] = tauX / b32i;
      if (DX > 0 && tauX / (2 * sinh(DX)) > worst[7]) worst[7] = tauX / (2 * sinh(DX));
      if (rho > 1e-12 && rhot / rho > worst[8]) worst[8] = rhot / rho; if (rho > 1e-6 && L31 / rho < worst[9]) worst[9] = L31 / rho;
      if (r0 > 1 + 1e-9 || r1 > 1 + 1e-9 || r2 > 1 + 1e-9 || r3 > 1 + 1e-9) printf("M4R-COUNTEREXAMPLE G%d case %d: %g %g %g %g\n", GK, cs, r0, r1, r2, r3);
      ncase++; }
    printf("M4R-LEMMAS group %s, 6000 random laws (orbits 1..4 per side, four strength regimes):\n", GK == 0 ? "Z2" : GK == 1 ? "Z3" : "Z2xZ2");
    for (int w = 0; w < 10; w++) { if (GK != 0 && (w == 5 || w == 6)) continue; printf("   worst %-60s %.12f\n", nm[w], worst[w]); } }
  /* ---- the hidden-label instance: three sites y, z, w with X = orbits{0,1} x Z2 each ----
   * law: L_w uniform; orbit of w uniform; given L_w = l, orbits of y and z independent with P(o = 0 | l) = (l ? 0.8 : 0.2);
   * labels of y and z uniform and independent of everything. Then given the FULL environment v_w (orbit and label), (v_y, v_z)
   * are independent: rho = 0 and so R~ (SO(3) channel conditioned on the SU(2) environment) = 0; given only the projected
   * environment (the orbit of w), the orbits of y and z are correlated through the hidden label L_w. */
  { double P[4][4][4]; /* v = o*2 + l */
    for (int vy = 0; vy < 4; vy++) for (int vz = 0; vz < 4; vz++) for (int vw = 0; vw < 4; vw++) { int oy = vy >> 1, oz = vz >> 1, lw = vw & 1;
          double py = lw ? (oy == 0 ? 0.8 : 0.2) : (oy == 0 ? 0.2 : 0.8), pz = lw ? (oz == 0 ? 0.8 : 0.2) : (oz == 0 ? 0.2 : 0.8);
          P[vy][vz][vw] = 0.25 * 0.5 * py * 0.5 * pz; } /* 1/4 for v_w (orbit, label), 1/2 for each label of y, z */
    double rfull = 0, rtfull = 0, rproj = 0;
    for (int vw = 0; vw < 4; vw++) { double C[16]; for (int a = 0; a < 4; a++) for (int b = 0; b < 4; b++) C[a * 4 + b] = P[a][b][vw]; double r = maxcorr(4, 4, C); if (r > rfull) rfull = r;
      double Ct[4] = {0}; for (int a = 0; a < 4; a++) for (int b = 0; b < 4; b++) Ct[(a >> 1) * 2 + (b >> 1)] += P[a][b][vw]; double rt = maxcorr(2, 2, Ct); if (rt > rtfull) rtfull = rt; }
    for (int ow = 0; ow < 2; ow++) { double Ct[4] = {0}; for (int a = 0; a < 4; a++) for (int b = 0; b < 4; b++) for (int lw = 0; lw < 2; lw++) Ct[(a >> 1) * 2 + (b >> 1)] += P[a][b][ow * 2 + lw]; double r = maxcorr(2, 2, Ct); if (r > rproj) rproj = r; }
    printf("M4R-HIDDEN-LABEL given the full environment v_w: rho(v_y, v_z) = %.12f, SO(3) channel R~(y,z) = %.12f; given only the projected environment (orbit of w): rho(orbit_y, orbit_z) = %.12f (exact: 0.36)\n", rfull, rtfull, rproj); }
  return 0; }
