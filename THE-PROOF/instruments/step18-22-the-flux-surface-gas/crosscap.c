/* crosscap.c -- THE FOUR GLUING RULES OF A HAAR LINK INTEGRAL ON SU(2), CHECKED EXACTLY (S1 A1-exact, 2026-11-01 10:4x EST; the author):
 * for the spin-j representation D = D^j, d = 2j + 1, and fixed X, Y in SU(2),
 *   (G1)  int da chi(X a) chi(a^-1 Y)  = (1/d) chi(X Y)                 -- two faces merged along a link traversed oppositely
 *   (G1') int da chi(X a) chi(Y a)     = (1/d) chi(X Y^-1)              -- two faces merged along a link traversed in the SAME direction
 *   (G2)  int da chi(a X a^-1 Y)       = (1/d) chi(X) chi(Y)            -- a link within one face, traversed oppositely (a handle's pinch)
 *   (G2') int da chi(a X a Y)          = ((-1)^{2j}/d) chi(X Y^-1)      -- a link within one face, traversed in the same direction (a cross-cap)
 * The integrand is a polynomial of degree 2 in the entries of D(a), hence of degree 4j in a's quaternion coordinates; the engine's rule of
 * degree deg >= 4j (make_rule, Gauss-Legendre x trapezoid x Chebyshev-U, exact to its degree) integrates it exactly, so a residual at 1e-13
 * is the rule's roundoff and a residual of order 1 is a wrong law.  X, Y are fixed quaternions of no special form.  The functions are the
 * engine's own (w2_strip_n.c: qmul, qinv, Dsub/rep, gauss_legendre, make_rule), copied so this file composes nothing and can be read whole.
 * build: gcc -O2 -o crosscap.exe crosscap.c -lm      usage: crosscap [deg]   (deg >= 8 for spins to 2; 12 by default) */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
typedef double complex cplx;
#define PI 3.141592653589793
typedef struct { double w, x, y, z; } quat;
static quat qmul(quat a, quat b) { quat r; r.w = a.w*b.w - a.x*b.x - a.y*b.y - a.z*b.z; r.x = a.w*b.x + a.x*b.w + a.y*b.z - a.z*b.y; r.y = a.w*b.y - a.x*b.z + a.y*b.w + a.z*b.x; r.z = a.w*b.z + a.x*b.y - a.y*b.x + a.z*b.w; return r; }
static quat qinv(quat a) { quat r = { a.w, -a.x, -a.y, -a.z }; return r; }
static double FACT[40];
static void Dsub(int s, quat q, cplx *D) {
  cplx a = q.w + I * q.x, b = q.y + I * q.z, ab = q.w - I * q.x, nbb = -q.y + I * q.z;
  cplx poly[40], np[40];
  for (int qq = 0; qq <= s; qq++) { int len = 1; poly[0] = 1;
    for (int r = 0; r < qq; r++) { for (int k = 0; k <= len; k++) np[k] = 0; for (int k = 0; k < len; k++) { np[k + 1] += poly[k] * a; np[k] += poly[k] * b; } len++; for (int k = 0; k < len; k++) poly[k] = np[k]; }
    for (int r = 0; r < s - qq; r++) { for (int k = 0; k <= len; k++) np[k] = 0; for (int k = 0; k < len; k++) { np[k + 1] += poly[k] * nbb; np[k] += poly[k] * ab; } len++; for (int k = 0; k < len; k++) poly[k] = np[k]; }
    for (int p = 0; p <= s; p++) { double sc = sqrt(FACT[p] * FACT[s - p] / (FACT[qq] * FACT[s - qq])); D[p * (s + 1) + qq] = poly[p] * sc; } } }
static int GENINV = 1;   /* the engine's substitution that makes D a homomorphism (W2-KAT reads GENINV=1); re-verified below */
static void rep(int s, quat q, cplx *D) { if (s == 0) { D[0] = 1; return; } Dsub(s, GENINV ? qinv(q) : q, D); }
static void mmul(int d, const cplx *A, const cplx *B, cplx *C) { for (int i = 0; i < d; i++) for (int j = 0; j < d; j++) { cplx acc = 0; for (int k = 0; k < d; k++) acc += A[i * d + k] * B[k * d + j]; C[i * d + j] = acc; } }
static cplx mtr(int d, const cplx *A) { cplx t = 0; for (int i = 0; i < d; i++) t += A[i * d + i]; return t; }
static int NPT; static quat *RU; static double *RW;
static void gauss_legendre(int n, double *x, double *w) { for (int i = 1; i <= n; i++) { double z = cos(PI * (i - 0.25) / (n + 0.5)), dp = 0;
    for (int it = 0; it < 200; it++) { double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2 * k - 1) * z * p1 - (k - 1) * p0) / k; p0 = p1; p1 = p2; } dp = n * (z * p1 - p0) / (z * z - 1); double z1 = z; z = z1 - p1 / dp; if (fabs(z - z1) < 1e-15) break; }
    double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2 * k - 1) * z * p1 - (k - 1) * p0) / k; p0 = p1; p1 = p2; } dp = n * (z * p1 - p0) / (z * z - 1); x[i - 1] = z; w[i - 1] = 2 / ((1 - z * z) * dp * dp); } }
static void make_rule(int deg) { int nth = (deg + 2) / 2, ngl = (deg + 2) / 2, naz = deg + 1; double gx[400], gw[400]; gauss_legendre(ngl, gx, gw);
  NPT = nth * ngl * naz; RU = malloc(sizeof(quat) * NPT); RW = malloc(sizeof(double) * NPT); int n = 0;
  for (int k = 1; k <= nth; k++) { double th = k * PI / (nth + 1), wt = 2 * sin(th) * sin(th) / (nth + 1);
    for (int j = 0; j < ngl; j++) { double t = gx[j], st = sqrt(1 - t * t);
      for (int l = 0; l < naz; l++) { double ph = 2 * PI * l / naz; quat u = { cos(th), sin(th) * st * cos(ph), sin(th) * st * sin(ph), sin(th) * t }; RU[n] = u; RW[n] = wt * gw[j] / 2 / naz; n++; } } } }
int main(int argc, char **argv) {
  int deg = argc > 1 ? atoi(argv[1]) : 12; if (deg < 8 || deg > 40) { fprintf(stderr, "deg 8..40\n"); return 1; }
  FACT[0] = 1; for (int i = 1; i < 40; i++) FACT[i] = FACT[i - 1] * i;
  make_rule(deg); printf("CROSSCAP rule degree %d, %d points; normalisation sum w = %.15f\n", deg, NPT, ({ double s = 0; for (int p = 0; p < NPT; p++) s += RW[p]; s; }));
  quat X = { 0.36, -0.48, 0.64, 0.48 }, Y = { 0.6, 0.0, -0.64, 0.48 };   /* |X| = sqrt(.1296+.2304+.4096+.2304) = 1; |Y| = sqrt(.36+.4096+.2304) = 1 */
  { double nx = sqrt(X.w*X.w + X.x*X.x + X.y*X.y + X.z*X.z), ny = sqrt(Y.w*Y.w + Y.x*Y.x + Y.y*Y.y + Y.z*Y.z); X.w /= nx; X.x /= nx; X.y /= nx; X.z /= nx; Y.w /= ny; Y.x /= ny; Y.y /= ny; Y.z /= ny; }
  int bad = 0;
  for (int s = 1; s <= 4; s++) { int d = s + 1; cplx DX[25], DY[25], DYi[25], DXY[25], DXYi[25], Da[25], Dai[25], T1[25], T2[25], T3[25];
    rep(s, X, DX); rep(s, Y, DY); rep(s, qinv(Y), DYi); rep(s, qmul(X, Y), DXY); rep(s, qmul(X, qinv(Y)), DXYi);
    /* the homomorphism re-verified on this rule's first point */
    { cplx P[25], Q[25]; rep(s, qmul(RU[0], X), P); rep(s, RU[0], Da); mmul(d, Da, DX, Q); double e = 0; for (int i = 0; i < d * d; i++) if (cabs(P[i] - Q[i]) > e) e = cabs(P[i] - Q[i]); if (e > 1e-12) { printf("CROSSCAP j=%d/2 homomorphism FAILED (%.1e)\n", s, e); bad++; } }
    cplx g1 = 0, g1p = 0, g2 = 0, g2p = 0;
    for (int p = 0; p < NPT; p++) { rep(s, RU[p], Da); rep(s, qinv(RU[p]), Dai);
      mmul(d, DX, Da, T1); mmul(d, Dai, DY, T2); g1 += RW[p] * mtr(d, T1) * mtr(d, T2);          /* chi(Xa) chi(a^-1 Y) */
      mmul(d, DY, Da, T3); g1p += RW[p] * mtr(d, T1) * mtr(d, T3);                                /* chi(Xa) chi(Ya) */
      mmul(d, Da, DX, T1); mmul(d, T1, Dai, T2); mmul(d, T2, DY, T3); g2 += RW[p] * mtr(d, T3);  /* chi(a X a^-1 Y) */
      mmul(d, Da, DX, T1); mmul(d, T1, Da, T2); mmul(d, T2, DY, T3); g2p += RW[p] * mtr(d, T3); } /* chi(a X a Y) */
    double sgn = (s % 2) ? -1 : 1;   /* (-1)^{2j}, 2j = s */
    cplx w1 = mtr(d, DXY) / d, w1p = mtr(d, DXYi) / d, w2 = mtr(d, DX) * mtr(d, DY) / d, w2p = sgn * mtr(d, DXYi) / d;
    double e1 = cabs(g1 - w1), e1p = cabs(g1p - w1p), e2 = cabs(g2 - w2), e2p = cabs(g2p - w2p);
    printf("CROSSCAP j=%d/2 d=%d: G1 %+.12f vs %+.12f (%.1e); G1' %+.12f vs %+.12f (%.1e); G2 %+.12f vs %+.12f (%.1e); G2' %+.12f vs %+.12f (%.1e) [%s]\n", s, d, creal(g1), creal(w1), e1, creal(g1p), creal(w1p), e1p, creal(g2), creal(w2), e2, creal(g2p), creal(w2p), e2p, (e1 < 1e-10 && e1p < 1e-10 && e2 < 1e-10 && e2p < 1e-10) ? "MET" : "FAILED");
    if (!(e1 < 1e-10 && e1p < 1e-10 && e2 < 1e-10 && e2p < 1e-10)) bad++;
    /* the sign's own witness: the Frobenius-Schur indicator int chi_j(a^2) da = (-1)^{2j}, and the Klein bottle's one-face word a a b b = 1/d */
    cplx fs = 0; for (int p = 0; p < NPT; p++) { rep(s, qmul(RU[p], RU[p]), Da); fs += RW[p] * mtr(d, Da); }
    cplx kb = 0; for (int p = 0; p < NPT; p++) { rep(s, qmul(RU[p], RU[p]), Da); for (int q = 0; q < NPT; q++) { rep(s, qmul(RU[q], RU[q]), Dai); mmul(d, Da, Dai, T1); kb += RW[p] * RW[q] * mtr(d, T1); } }
    printf("CROSSCAP j=%d/2: Frobenius-Schur int chi(a^2) = %+.12f (law %+d); Klein bottle a a b b = %+.12f (law 1/d = %+.12f) [%s]\n", s, creal(fs), (int)sgn, creal(kb), 1.0 / d, (cabs(fs - sgn) < 1e-10 && cabs(kb - 1.0 / d) < 1e-10) ? "MET" : "FAILED");
    if (!(cabs(fs - sgn) < 1e-10 && cabs(kb - 1.0 / d) < 1e-10)) bad++; }
  printf("CROSSCAP %s\n", bad ? "FAILED" : "ALL MET"); return bad ? 1 : 0; }
