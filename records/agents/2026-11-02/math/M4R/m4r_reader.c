/* m4r_reader.c -- M4R's independent recheck of M4's channel readings (rec/chan_*.txt). Double precision; a CHECK, not a
 * certificate.
 *
 * SU(2) cells at the ORDERED datum: every outside link is 1, so the law of the two loop holonomies (A,B) is invariant under
 * simultaneous conjugation and is fixed by the dump's PRINTED SCALARS alone -- the class moments E[chi_a(A) chi_c(B)]
 * (W2-CLASS lines) and the channel coefficients f_k = E[tr P_k (D^a(A) (x) D^c(B))] (W2-CHANNEL lines):
 *     p(A,B) = sum_{a,c,k} (d_a d_c / d_k) f^{ac}_k Phi^{ac}_k(A,B),   Phi^{ac}_k(A,B) = tr[P_k (D^a(A) (x) D^c(B))],
 * with P_k the isotypic projector of the diagonal action. Phi is basis-independent, so ANY realisation of the irreps gives the
 * same function: here D^1 = the 2x2 quaternion matrix, D^2 = the rotation v -> q v q* (real 3x3), and P_k by group averaging on
 * this file's own rule. Nothing of the engine's Dsub, of M2's l2dob.c or of M4's real Peter-Weyl basis is used.
 * Maximal correlations are computed as singular values of the DISCRETE law pi_ij = w_i w_j p(U_i,V_j) on a centre-symmetric
 * product rule (theta Chebyshev-2, z Gauss-Legendre, even azimuth), by subspace iteration: rho = sigma_2 of the normalised
 * matrix; the SO(3) channel on the quotient by U -> -U; the O-blocks in the per-pair basis (e_p, o_p).
 * tau: Lemma 3.2(i)'s exact formula rho(L_A, B | A~) = sd(t)/sqrt(1 - t0^2), evaluated at U of angle theta (conjugation
 * invariance: it depends on theta only), on a fine theta grid INCLUDING theta = 0 (U = 1), and on M4's degree-16 theta nodes
 * k pi/10 for comparison with its record.
 * U(1) cells: p(phi,psi) = sum_{a,c} M_ac e^{-i(a phi + c psi)} from U1-CLASS lines, the same discrete computations.
 *
 * usage: m4r_reader SU2O <dump> [Nth Nz Nph]  |  m4r_reader U1 <dump> [N]
 * build: gcc -O2 -o m4r_reader.exe m4r_reader.c -lm
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
typedef double complex cx;
static const double PI = 3.14159265358979323846;

/* ---------------- quaternions and the two irreps ---------------- */
typedef struct { double w, x, y, z; } qt;
static qt qm(qt a, qt b) { qt r; r.w = a.w*b.w - a.x*b.x - a.y*b.y - a.z*b.z; r.x = a.w*b.x + a.x*b.w + a.y*b.z - a.z*b.y;
  r.y = a.w*b.y - a.x*b.z + a.y*b.w + a.z*b.x; r.z = a.w*b.z + a.x*b.y - a.y*b.x + a.z*b.w; return r; }
static qt qc(qt a) { qt r = { a.w, -a.x, -a.y, -a.z }; return r; }
static qt qneg(qt a) { qt r = { -a.w, -a.x, -a.y, -a.z }; return r; }
/* D[a] stored row-major d x d, a = twice the spin: a=0 -> [1], a=1 -> 2x2, a=2 -> 3x3 rotation */
static void irr(int a, qt q, cx *D) {
  if (a == 0) { D[0] = 1; return; }
  if (a == 1) { D[0] = q.w + I*q.x; D[1] = q.y + I*q.z; D[2] = -q.y + I*q.z; D[3] = q.w - I*q.x; return; }
  qt e[3] = { {0,1,0,0}, {0,0,1,0}, {0,0,0,1} };
  for (int j = 0; j < 3; j++) { qt r = qm(qm(q, e[j]), qc(q)); D[0*3+j] = r.x; D[1*3+j] = r.y; D[2*3+j] = r.z; } }
static double chi(int k, double th) { double s = sin(th); if (fabs(s) < 1e-14) { double c = cos(th); return (k + 1) * pow(c > 0 ? 1 : -1, k); } return sin((k + 1) * th) / s; }
static double qangle(qt q) { double w = q.w; if (w > 1) w = 1; if (w < -1) w = -1; return acos(w); }

/* ---------------- rules ---------------- */
static void gl(int n, double *x, double *w) { for (int i = 0; i < n; i++) { double z = cos(PI * (i + 0.75) / (n + 0.5)), pp = 0;
    for (int it = 0; it < 100; it++) { double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2.0*k - 1) * z * p1 - (k - 1.0) * p0) / k; p0 = p1; p1 = p2; }
      pp = n * (z * p1 - p0) / (z * z - 1); double z1 = z; z = z1 - p1 / pp; if (fabs(z - z1) < 1e-16) break; }
    x[i] = z; w[i] = 2 / ((1 - z * z) * pp * pp); } }
typedef struct { int n, Nth, Nz, Nph; qt *U; double *w; int *anti; } rule;
static rule mkrule(int Nth, int Nz, int Nph) { rule R; R.Nth = Nth; R.Nz = Nz; R.Nph = Nph; R.n = Nth * Nz * Nph;
  R.U = malloc(sizeof(qt) * R.n); R.w = malloc(sizeof(double) * R.n); R.anti = malloc(sizeof(int) * R.n);
  double *zx = malloc(sizeof(double) * Nz), *zw = malloc(sizeof(double) * Nz); gl(Nz, zx, zw);
  /* sort z ascending so that the antipode of index l is Nz-1-l */
  for (int i = 0; i < Nz; i++) for (int j = i + 1; j < Nz; j++) if (zx[j] < zx[i]) { double t = zx[i]; zx[i] = zx[j]; zx[j] = t; t = zw[i]; zw[i] = zw[j]; zw[j] = t; }
  for (int k = 0; k < Nth; k++) { double th = (k + 1) * PI / (Nth + 1), wt = 2 * sin(th) * sin(th) / (Nth + 1);
    for (int l = 0; l < Nz; l++) for (int m = 0; m < Nph; m++) { double ph = 2 * PI * m / Nph, s = sqrt(1 - zx[l] * zx[l]);
        int idx = (k * Nz + l) * Nph + m; qt u = { cos(th), sin(th) * s * cos(ph), sin(th) * s * sin(ph), sin(th) * zx[l] };
        R.U[idx] = u; R.w[idx] = wt * zw[l] / 2 / Nph;
        R.anti[idx] = ((Nth - 1 - k) * Nz + (Nz - 1 - l)) * Nph + (m + Nph / 2) % Nph; } }
  free(zx); free(zw); return R; }

/* ---------------- dense linear algebra ---------------- */
static void jacobi(int n, double *a, double *ev, double *V) { for (int i = 0; i < n * n; i++) V[i] = 0; for (int i = 0; i < n; i++) V[i * n + i] = 1;
  for (int sw = 0; sw < 100; sw++) { double off = 0; for (int p = 0; p < n; p++) for (int q = p + 1; q < n; q++) off += a[p * n + q] * a[p * n + q]; if (off < 1e-30) break;
    for (int p = 0; p < n; p++) for (int q = p + 1; q < n; q++) { double apq = a[p * n + q]; if (fabs(apq) < 1e-300) continue;
        double th = (a[q * n + q] - a[p * n + p]) / (2 * apq), t = (th >= 0 ? 1 : -1) / (fabs(th) + sqrt(th * th + 1)), c = 1 / sqrt(t * t + 1), s = t * c;
        for (int k = 0; k < n; k++) { double x = a[k * n + p], y = a[k * n + q]; a[k * n + p] = c * x - s * y; a[k * n + q] = s * x + c * y; }
        for (int k = 0; k < n; k++) { double x = a[p * n + k], y = a[q * n + k]; a[p * n + k] = c * x - s * y; a[q * n + k] = s * x + c * y; }
        for (int k = 0; k < n; k++) { double x = V[k * n + p], y = V[k * n + q]; V[k * n + p] = c * x - s * y; V[k * n + q] = s * x + c * y; } } }
  for (int i = 0; i < n; i++) ev[i] = a[i * n + i]; }
/* top singular values of X (m x n, row-major, leading dim ld, column offset c0) minus s1 * u v^T (if u != NULL);
 * subspace iteration with K vectors, Rayleigh-Ritz; returns sigma_1..sigma_nr in out */
static unsigned long long rs = 88172645463325252ULL; static double urand(void) { rs ^= rs << 13; rs ^= rs >> 7; rs ^= rs << 17; return (rs >> 11) * (1.0 / 9007199254740992.0); }
static void topsv(int m, int n, const double *X, const double *u, const double *v, double s1, int K, int iters, int nr, double *out) {
  double *Q = malloc(sizeof(double) * n * K), *Y = malloc(sizeof(double) * m * K), *Z = malloc(sizeof(double) * n * K);
  for (int i = 0; i < n * K; i++) Q[i] = urand() - 0.5;
  for (int it = 0; it <= iters; it++) {
    /* orthonormalise Q (columns, stored Q[i*K+c]) by modified Gram-Schmidt, twice */
    for (int pass = 0; pass < 2; pass++) for (int c = 0; c < K; c++) { for (int d = 0; d < c; d++) { double s = 0; for (int i = 0; i < n; i++) s += Q[i * K + c] * Q[i * K + d]; for (int i = 0; i < n; i++) Q[i * K + c] -= s * Q[i * K + d]; }
        double nn = 0; for (int i = 0; i < n; i++) nn += Q[i * K + c] * Q[i * K + c]; nn = sqrt(nn); if (nn < 1e-300) nn = 1; for (int i = 0; i < n; i++) Q[i * K + c] /= nn; }
    /* Y = X' Q */
    for (int r = 0; r < m; r++) { const double *xr = X + (size_t)r * n; for (int c = 0; c < K; c++) { double s = 0; for (int j = 0; j < n; j++) s += xr[j] * Q[j * K + c]; Y[r * K + c] = s; } }
    if (u) for (int c = 0; c < K; c++) { double vq = 0; for (int j = 0; j < n; j++) vq += v[j] * Q[j * K + c]; for (int r = 0; r < m; r++) Y[r * K + c] -= s1 * u[r] * vq; }
    if (it == iters) break;
    /* Z = X'^T Y */
    for (int j = 0; j < n * K; j++) Z[j] = 0;
    for (int r = 0; r < m; r++) { const double *xr = X + (size_t)r * n; for (int j = 0; j < n; j++) { double xv = xr[j]; for (int c = 0; c < K; c++) Z[j * K + c] += xv * Y[r * K + c]; } }
    if (u) for (int c = 0; c < K; c++) { double uy = 0; for (int r = 0; r < m; r++) uy += u[r] * Y[r * K + c]; for (int j = 0; j < n; j++) Z[j * K + c] -= s1 * v[j] * uy; }
    memcpy(Q, Z, sizeof(double) * n * K); }
  /* Rayleigh-Ritz on Y^T Y = Q^T X'^T X' Q */
  double *H = malloc(sizeof(double) * K * K), *ev = malloc(sizeof(double) * K), *V = malloc(sizeof(double) * K * K);
  for (int a = 0; a < K; a++) for (int b = 0; b < K; b++) { double s = 0; for (int r = 0; r < m; r++) s += Y[r * K + a] * Y[r * K + b]; H[a * K + b] = s; }
  jacobi(K, H, ev, V); for (int a = 0; a < K; a++) for (int b = a + 1; b < K; b++) if (ev[b] > ev[a]) { double t = ev[a]; ev[a] = ev[b]; ev[b] = t; }
  for (int i = 0; i < nr; i++) out[i] = sqrt(ev[i] > 0 ? ev[i] : 0);
  free(Q); free(Y); free(Z); free(H); free(ev); free(V); }

/* ---------------- the channel analysis of a discrete law on a centre-symmetric rule ----------------
 * pi[i*n+j], i on A's rule, j on B's rule (same rule), anti[] the antipode map. */
static void analyse(const char *tag, int n, const double *pi, const int *anti) {
  double *pA = calloc(n, sizeof(double)), *pB = calloc(n, sizeof(double)), tot = 0, pmin = 1e300;
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) { double x = pi[(size_t)i * n + j]; pA[i] += x; pB[j] += x; tot += x; if (x < pmin) pmin = x; }
  printf("M4R-LAW %s n=%d total mass %.15f, min pi_ij %.3e%s\n", tag, n, tot, pmin, pmin <= 0 ? "  NOT POSITIVE" : "");
  double *M = malloc(sizeof(double) * (size_t)n * n), *u = malloc(sizeof(double) * n), *v = malloc(sizeof(double) * n);
  for (int i = 0; i < n; i++) { u[i] = sqrt(pA[i]); v[i] = sqrt(pB[i]); }
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) M[(size_t)i * n + j] = pi[(size_t)i * n + j] / (u[i] * v[j]);
  double e1 = 0, e2 = 0; for (int i = 0; i < n; i++) { double s = 0; for (int j = 0; j < n; j++) s += M[(size_t)i * n + j] * v[j]; e1 = fmax(e1, fabs(s - u[i])); }
  for (int j = 0; j < n; j++) { double s = 0; for (int i = 0; i < n; i++) s += M[(size_t)i * n + j] * u[i]; e2 = fmax(e2, fabs(s - v[j])); }
  printf("M4R-TOP %s the marginal pair is a singular pair of value 1: |Mv-u| %.2e, |M^T u - v| %.2e\n", tag, e1, e2);
  double sv[6]; topsv(n, n, M, u, v, 1.0, 10, 400, 4, sv);
  printf("M4R-RHO %s rho (all functions) = %.9f   next singular values %.9f %.9f %.9f\n", tag, sv[0], sv[1], sv[2], sv[3]);
  double rho = sv[0];
  /* per-pair basis: pairs p = (i, anti[i]) with i < anti[i] */
  int np = 0; int *pi1 = malloc(sizeof(int) * n), *pi2 = malloc(sizeof(int) * n); for (int i = 0; i < n; i++) if (i < anti[i]) { pi1[np] = i; pi2[np] = anti[i]; np++; }
  if (2 * np != n) { printf("M4R-PAIRS %s: the rule is not centre-symmetric (%d pairs for %d points) -- REFUSED\n", tag, np, n); return; }
  /* A side: e_p = (u_i, u_i')/nA_p, o_p = (u_i', -u_i)/nA_p ; B side likewise with v */
  double *EE = malloc(sizeof(double) * np * np), *EO = malloc(sizeof(double) * np * np), *OE = malloc(sizeof(double) * np * np), *OO = malloc(sizeof(double) * np * np);
  double *ue = malloc(sizeof(double) * np), *ve = malloc(sizeof(double) * np);
  for (int p = 0; p < np; p++) { ue[p] = sqrt(pA[pi1[p]] + pA[pi2[p]]); ve[p] = sqrt(pB[pi1[p]] + pB[pi2[p]]); }
  for (int p = 0; p < np; p++) { int i1 = pi1[p], i2 = pi2[p]; double na = ue[p], ea1 = u[i1] / na, ea2 = u[i2] / na, oa1 = u[i2] / na, oa2 = -u[i1] / na;
    for (int q = 0; q < np; q++) { int j1 = pi1[q], j2 = pi2[q]; double nb = ve[q], eb1 = v[j1] / nb, eb2 = v[j2] / nb, ob1 = v[j2] / nb, ob2 = -v[j1] / nb;
      double m11 = M[(size_t)i1 * n + j1], m12 = M[(size_t)i1 * n + j2], m21 = M[(size_t)i2 * n + j1], m22 = M[(size_t)i2 * n + j2];
      EE[p * np + q] = ea1 * (m11 * eb1 + m12 * eb2) + ea2 * (m21 * eb1 + m22 * eb2);
      EO[p * np + q] = ea1 * (m11 * ob1 + m12 * ob2) + ea2 * (m21 * ob1 + m22 * ob2);
      OE[p * np + q] = oa1 * (m11 * eb1 + m12 * eb2) + oa2 * (m21 * eb1 + m22 * eb2);
      OO[p * np + q] = oa1 * (m11 * ob1 + m12 * ob2) + oa2 * (m21 * ob1 + m22 * ob2); } }
  double s_ee[4], s_eo[4], s_oe[4], s_oo[4];
  topsv(np, np, EE, ue, ve, 1.0, 8, 400, 2, s_ee); topsv(np, np, EO, NULL, NULL, 0, 8, 400, 2, s_eo); topsv(np, np, OE, NULL, NULL, 0, 8, 400, 2, s_oe); topsv(np, np, OO, NULL, NULL, 0, 8, 400, 2, s_oo);
  /* rho_O. : rows O_A, all columns -> [OE OO] (np x 2np) */
  double *OR = malloc(sizeof(double) * np * 2 * np); for (int p = 0; p < np; p++) for (int q = 0; q < np; q++) { OR[(size_t)p * 2 * np + q] = OE[p * np + q]; OR[(size_t)p * 2 * np + np + q] = OO[p * np + q]; }
  double s_or[4]; topsv(np, 2 * np, OR, NULL, NULL, 0, 8, 400, 2, s_or);
  /* the half-integer channel: centred odd functions. odd vectors x_p = (u_i, -u_i')/ue_p ; c_p = <u, x_p> = (pA_i - pA_i')/ue_p */
  double *ca = malloc(sizeof(double) * np), *cb = malloc(sizeof(double) * np), c2a = 0, c2b = 0;
  for (int p = 0; p < np; p++) { ca[p] = (pA[pi1[p]] - pA[pi2[p]]) / ue[p]; cb[p] = (pB[pi1[p]] - pB[pi2[p]]) / ve[p]; c2a += ca[p] * ca[p]; c2b += cb[p] * cb[p]; }
  /* compressed matrix on the odd subspaces: H_pq = x_p^T M y_q ; the centred odd subspace is P_{u perp}(odd); with
   * Gram G = I - c c^T (since x_p are orthonormal and u_{|odd} = sum c_p x_p), sigma_max of G^{-1/2} (H - c d^T ... ) */
  double *H = malloc(sizeof(double) * np * np);
  for (int p = 0; p < np; p++) { int i1 = pi1[p], i2 = pi2[p]; double xa1 = u[i1] / ue[p], xa2 = -u[i2] / ue[p];
    for (int q = 0; q < np; q++) { int j1 = pi1[q], j2 = pi2[q]; double yb1 = v[j1] / ve[q], yb2 = -v[j2] / ve[q];
      H[p * np + q] = xa1 * (M[(size_t)i1 * n + j1] * yb1 + M[(size_t)i1 * n + j2] * yb2) + xa2 * (M[(size_t)i2 * n + j1] * yb1 + M[(size_t)i2 * n + j2] * yb2); } }
  /* (P_u x)^T M (P_v y) = x^T M y - (u^T x)(u^T M y) ... = H - c (v.y)... with M^T u = v and M v = u: x^T M y - (u.x)(v.y) */
  for (int p = 0; p < np; p++) for (int q = 0; q < np; q++) H[p * np + q] -= ca[p] * cb[q];
  double ga = c2a > 0 ? (1 / sqrt(1 - c2a) - 1) / c2a : 0, gb = c2b > 0 ? (1 / sqrt(1 - c2b) - 1) / c2b : 0;
  /* Hn = (I + ga ca ca^T) H (I + gb cb cb^T) */
  double *t1 = calloc(np, sizeof(double)), *t2 = calloc(np, sizeof(double));
  for (int q = 0; q < np; q++) { double s = 0; for (int p = 0; p < np; p++) s += ca[p] * H[p * np + q]; t1[q] = s; }
  for (int p = 0; p < np; p++) for (int q = 0; q < np; q++) H[p * np + q] += ga * ca[p] * t1[q];
  for (int p = 0; p < np; p++) { double s = 0; for (int q = 0; q < np; q++) s += H[p * np + q] * cb[q]; t2[p] = s; }
  for (int p = 0; p < np; p++) for (int q = 0; q < np; q++) H[p * np + q] += gb * t2[p] * cb[q];
  double s_pw[4]; topsv(np, np, H, NULL, NULL, 0, 8, 400, 2, s_pw);
  double exb = sqrt(s_ee[0] * s_ee[0] + s_eo[0] * s_eo[0] + s_or[0] * s_or[0]);
  printf("M4R-CHAN %s rho_EE = %.9f | rho_OO = %.9f rho_EO = %.9f rho_OE = %.9f rho_O. = %.9f | half-integer rho_oo = %.9f\n", tag, s_ee[0], s_oo[0], s_eo[0], s_oe[0], s_or[0], s_pw[0]);
  printf("M4R-SHARE %s rho_EE/rho = %.6f rho_OO/rho = %.6f rho_EE/rho_OO^2 = %.6g | exact block bound %.9f (ratio %.7f) %s\n", tag, s_ee[0] / rho, s_oo[0] / rho, s_ee[0] / (s_oo[0] * s_oo[0]), exb, exb / rho, exb >= rho * (1 - 1e-9) ? "[MET]" : "[FAILED]");
  free(pA); free(pB); free(M); free(u); free(v); free(pi1); free(pi2); free(EE); free(EO); free(OE); free(OO); free(ue); free(ve); free(OR); free(ca); free(cb); free(H); free(t1); free(t2); }

/* ---------------- SU(2) ordered: the law from the scalars ---------------- */
static double FK[3][3][5]; static int HK[3][3][5]; static double CLS[3][3]; static int HC[3][3];
static cx PK[3][3][5][81]; /* projector on V_a (x) V_c, dimension (da dc)^2, index ((r*dc+r')*(da*dc) + (q*dc+q')) */
static void build_projectors(void) { rule R = mkrule(10, 8, 12); /* exact for spin <= 4 integrands */
  for (int a = 0; a <= 2; a++) for (int c = 0; c <= 2; c++) { int da = a + 1, dc = c + 1, D = da * dc;
      for (int k = abs(a - c); k <= a + c; k += 2) { cx *P = PK[a][c][k]; for (int t = 0; t < D * D; t++) P[t] = 0;
        for (int g = 0; g < R.n; g++) { cx Da[9], Dc[9]; irr(a, R.U[g], Da); irr(c, R.U[g], Dc); double wch = R.w[g] * (k + 1) * chi(k, qangle(R.U[g]));
          for (int r = 0; r < da; r++) for (int rp = 0; rp < dc; rp++) for (int q = 0; q < da; q++) for (int qp = 0; qp < dc; qp++)
            P[(r * dc + rp) * D + (q * dc + qp)] += wch * Da[r * da + q] * Dc[rp * dc + qp]; }
        /* checks: idempotent, hermitian, trace = d_k */
        double ide = 0, her = 0; cx tr = 0; for (int x = 0; x < D; x++) { tr += P[x * D + x]; for (int y = 0; y < D; y++) { cx s = 0; for (int z = 0; z < D; z++) s += P[x * D + z] * P[z * D + y]; ide = fmax(ide, cabs(s - P[x * D + y])); her = fmax(her, cabs(P[x * D + y] - conj(P[y * D + x]))); } }
        if (ide > 1e-12 || her > 1e-12 || cabs(tr - (k + 1)) > 1e-12) { printf("M4R-PROJ a=%d c=%d k=%d idempotent %.1e hermitian %.1e trace %.6f  FAILED\n", a, c, k, ide, her, creal(tr)); exit(1); } } }
  printf("M4R-PROJ all P_k (a,c <= 2) idempotent, hermitian, trace d_k to 1e-12 [MET]\n"); }
/* p(A,B) = sum_a sum_{r,q} D^a(A)[r][q] W^a(B)[r][q],  W^a(B)[r][q] = sum_{c,k} (d_a d_c/d_k) f_k sum_{r',q'} P[(q,q'),(r,r')] D^c(B)[r'][q'] */
typedef struct { cx w[3][9]; } wm; typedef struct { cx d[3][9]; } dm;
static void Wmat(qt B, wm *W) { cx Dc[3][9]; for (int c = 0; c <= 2; c++) irr(c, B, Dc[c]);
  for (int a = 0; a <= 2; a++) { int da = a + 1; for (int t = 0; t < 9; t++) W->w[a][t] = 0;
    for (int c = 0; c <= 2; c++) { int dc = c + 1, D = da * dc;
      for (int k = abs(a - c); k <= a + c; k += 2) { if (!HK[a][c][k]) continue; cx *P = PK[a][c][k]; double coef = (double)(da * dc) / (k + 1) * FK[a][c][k];
        for (int r = 0; r < da; r++) for (int q = 0; q < da; q++) { cx s = 0; for (int rp = 0; rp < dc; rp++) for (int qp = 0; qp < dc; qp++) s += P[(q * dc + qp) * D + (r * dc + rp)] * Dc[c][rp * dc + qp]; W->w[a][r * da + q] += coef * s; } } } } }
static void Dmat(qt A, dm *Dd) { for (int a = 0; a <= 2; a++) irr(a, A, Dd->d[a]); }
static double pfast(const dm *Dd, const wm *W) { cx s = 0; for (int a = 0; a <= 2; a++) { int K = (a + 1) * (a + 1); for (int t = 0; t < K; t++) s += Dd->d[a][t] * W->w[a][t]; } return creal(s); }
static double p_su2(qt A, qt B) { dm Dd; wm W; Dmat(A, &Dd); Wmat(B, &W); return pfast(&Dd, &W); }
/* the slow, literal formula, kept as a known answer for pfast */
static double p_su2_literal(qt A, qt B) { cx Da[3][9], Dc[3][9]; for (int a = 0; a <= 2; a++) { irr(a, A, Da[a]); irr(a, B, Dc[a]); }
  cx s = 0;
  for (int a = 0; a <= 2; a++) for (int c = 0; c <= 2; c++) { int da = a + 1, dc = c + 1, D = da * dc;
      for (int k = abs(a - c); k <= a + c; k += 2) { if (!HK[a][c][k]) continue; cx *P = PK[a][c][k]; cx phi = 0;
        for (int r = 0; r < da; r++) for (int rp = 0; rp < dc; rp++) for (int q = 0; q < da; q++) for (int qp = 0; qp < dc; qp++)
          phi += P[(q * dc + qp) * D + (r * dc + rp)] * Da[a][r * da + q] * Dc[c][rp * dc + qp];
        s += (double)(da * dc) / (k + 1) * FK[a][c][k] * phi; } }
  return creal(s); }
static double pA_su2(qt A) { double th = qangle(A); return 1 + CLS[1][0] * chi(1, th) + CLS[2][0] * chi(2, th); }
static double pB_su2(qt B) { double th = qangle(B); return 1 + CLS[0][1] * chi(1, th) + CLS[0][2] * chi(2, th); }
static void read_su2o(const char *path) { FILE *f = fopen(path, "r"); if (!f) { fprintf(stderr, "cannot open %s\n", path); exit(1); } char ln[4096];
  while (fgets(ln, sizeof ln, f)) { int a, c, k; double x;
    if (sscanf(ln, "W2-CLASS a=%d c=%d E[chi_a(A) chi_c(B)] = %le", &a, &c, &x) == 3 && a <= 2 && c <= 2) { CLS[a][c] = x; HC[a][c] = 1; }
    else if (sscanf(ln, "W2-CHANNEL a=%d c=%d k=%d f_k = %le", &a, &c, &k, &x) == 4 && a <= 2 && c <= 2) { FK[a][c][k] = x; HK[a][c][k] = 1; } }
  fclose(f);
  for (int a = 0; a <= 2; a++) for (int c = 0; c <= 2; c++) { if (!HC[a][c]) { fprintf(stderr, "missing class (%d,%d)\n", a, c); exit(1); }
      if (a == 0 || c == 0) { FK[a][c][a + c] = CLS[a][c]; HK[a][c][a + c] = 1; }
      else { double s = 0; for (int k = abs(a - c); k <= a + c; k += 2) { if (!HK[a][c][k]) { fprintf(stderr, "missing channel (%d,%d,%d)\n", a, c, k); exit(1); } s += FK[a][c][k]; }
        if (fabs(s - CLS[a][c]) > 1e-12) { fprintf(stderr, "channel sum mismatch at (%d,%d)\n", a, c); exit(1); } } } }
/* rho(L, other | orbit) at the orbit point of angle th (axis fixed; conjugation invariance makes the axis immaterial, which is
 * checked once with a second axis); side 0: A's label against B; side 1: B's label against A. Fine rule R for the other variable,
 * with its D's and W's precomputed. Returns r; o = osc F, fm = max |F|, dm_ = |weighted mean of t - t0|. */
static rule TR; static dm *TRD; static wm *TRW;
static double tau_at(int side, double th, double ax, double ay, double az, double *o, double *fm, double *dmean) {
  qt U = { cos(th), sin(th) * ax, sin(th) * ay, sin(th) * az }, Um = qneg(U); dm DU, DUm; wm WU, WUm;
  if (side == 0) { Dmat(U, &DU); Dmat(Um, &DUm); } else { Wmat(U, &WU); Wmat(Um, &WUm); }
  double mp = side == 0 ? pA_su2(U) : pB_su2(U), mm = side == 0 ? pA_su2(Um) : pB_su2(Um), t0 = (mp - mm) / (mp + mm);
  double S0 = 0, S1 = 0, S2 = 0, Fmx = -1e300, Fmn = 1e300; static double tv[80000], ov[80000];
  for (int j = 0; j < TR.n; j++) { double pp = side == 0 ? pfast(&DU, &TRW[j]) : pfast(&TRD[j], &WU), pm = side == 0 ? pfast(&DUm, &TRW[j]) : pfast(&TRD[j], &WUm);
    double t = (pp - pm) / (pp + pm), om = TR.w[j] * (pp + pm); tv[j] = t; ov[j] = om; S0 += om; S1 += om * t; double F = log(pp / pm); if (F > Fmx) Fmx = F; if (F < Fmn) Fmn = F; }
  double mean = S1 / S0; for (int j = 0; j < TR.n; j++) S2 += ov[j] * (tv[j] - mean) * (tv[j] - mean);
  if (o) *o = Fmx - Fmn; if (fm) *fm = fmax(fabs(Fmx), fabs(Fmn)); if (dmean) *dmean = fabs(mean - t0);
  return sqrt(S2 / S0) / sqrt(1 - t0 * t0); }
static void tau_su2(const char *tag, int side) {
  double best = 0, bestth = 0, osc = 0, fmx = 0, grid16 = 0, devmean = 0, o, fm, dmn;
  int NTH = 400;
  for (int it = 0; it <= NTH; it++) { double th = (PI / 2) * it / NTH; double r = tau_at(side, th, 0.48, 0.6, 0.64, &o, &fm, &dmn);
    if (r > best) { best = r; bestth = th; } osc = fmax(osc, o); fmx = fmax(fmx, fm); devmean = fmax(devmean, dmn);
    if (it == 0) printf("M4R-TAU %s side %c at U = 1 (theta = 0): rho(L, other | orbit) = %.9f, osc F there %.6f\n", tag, side ? 'B' : 'A', r, o); }
  for (int k = 1; k <= 9; k++) { double r = tau_at(side, k * PI / 10, 0.48, 0.6, 0.64, NULL, NULL, NULL); if (r > grid16) grid16 = r; }
  double r1 = tau_at(side, 0.7, 0.48, 0.6, 0.64, NULL, NULL, NULL), r2 = tau_at(side, 0.7, 0.0, 0.0, 1.0, NULL, NULL, NULL);
  printf("M4R-TAU %s side %c: sup over theta in [0,pi/2] (%d+1 points, theta = 0 included) = %.9f at theta = %.4f | on M4's degree-16 thetas k pi/10: %.9f | osc F = %.6f, max|F| = %.6f | max|mean t - t0| = %.1e | axis check %.2e\n",
         tag, side ? 'B' : 'A', NTH, best, bestth, grid16, osc, fmx, devmean, fabs(r1 - r2)); }
static void run_su2o(const char *path, int Nth, int Nz, int Nph) {
  read_su2o(path); build_projectors();
  const char *b = strrchr(path, '/'); b = b ? b + 1 : path; char tag[512]; snprintf(tag, sizeof tag, "%s[%d,%d,%d]", b, Nth, Nz, Nph);
  printf("M4R-INPUT %s E[chi_1/2(A)] = %.12f E[chi_1(A)] = %.12f E[chi_1/2 chi_1/2] = %.12f f_0 = %.6e f_2 = %.6e\n", b, CLS[1][0], CLS[2][0], CLS[1][1], FK[1][1][0], FK[1][1][2]);
  /* known answer for the fast evaluator against the literal formula */
  { double e = 0; for (int t = 0; t < 40; t++) { qt A = { cos(0.31 * t + 0.2), sin(0.31 * t + 0.2) * 0.6, sin(0.31 * t + 0.2) * 0.0, sin(0.31 * t + 0.2) * 0.8 }, B = { cos(0.77 * t + 1.1), sin(0.77 * t + 1.1) * 0.36, sin(0.77 * t + 1.1) * 0.48, sin(0.77 * t + 1.1) * 0.8 };
      e = fmax(e, fabs(p_su2(A, B) - p_su2_literal(A, B))); } printf("M4R-FAST pfast against the literal formula: %.1e [%s]\n", e, e < 1e-12 ? "MET" : "FAILED"); }
  rule R = mkrule(Nth, Nz, Nph); int n = R.n; double *pi = malloc(sizeof(double) * (size_t)n * n);
  dm *RD = malloc(sizeof(dm) * n); wm *RW = malloc(sizeof(wm) * n); for (int i = 0; i < n; i++) { Dmat(R.U[i], &RD[i]); Wmat(R.U[i], &RW[i]); }
  double margerr = 0, margerrB = 0; double *colsum = calloc(n, sizeof(double));
  for (int i = 0; i < n; i++) { double s = 0; for (int j = 0; j < n; j++) { double x = R.w[i] * R.w[j] * pfast(&RD[i], &RW[j]); pi[(size_t)i * n + j] = x; s += x; colsum[j] += x; } margerr = fmax(margerr, fabs(s / R.w[i] - pA_su2(R.U[i]))); }
  for (int j = 0; j < n; j++) margerrB = fmax(margerrB, fabs(colsum[j] / R.w[j] - pB_su2(R.U[j])));
  double antierr = 0; for (int i = 0; i < n; i++) { qt a = R.U[R.anti[i]], m = qneg(R.U[i]); antierr = fmax(antierr, fabs(a.w - m.w) + fabs(a.x - m.x) + fabs(a.y - m.y) + fabs(a.z - m.z)); }
  printf("M4R-RULE %s %d points, antipode map exact to %.1e; row sums / w_i against p_A: max dev %.2e; column sums against p_B: %.2e\n", tag, n, antierr, margerr, margerrB);
  analyse(tag, n, pi, R.anti); free(pi); free(RD); free(RW); free(colsum);
  TR = mkrule(20, 14, 28); TRD = malloc(sizeof(dm) * TR.n); TRW = malloc(sizeof(wm) * TR.n); for (int j = 0; j < TR.n; j++) { Dmat(TR.U[j], &TRD[j]); Wmat(TR.U[j], &TRW[j]); }
  tau_su2(b, 0); tau_su2(b, 1); }

/* ---------------- U(1) ---------------- */
static int UL = -1; static cx UM[64][64]; static int UH[64][64];
static void read_u1(const char *path) { FILE *f = fopen(path, "r"); if (!f) { fprintf(stderr, "cannot open %s\n", path); exit(1); } char ln[4096];
  while (fgets(ln, sizeof ln, f)) { if (!strncmp(ln, "U1-OBJECT", 9)) { char *p = strstr(ln, "LMAX="); if (p) UL = atoi(p + 5); }
    else { int a, c; double re, im; if (sscanf(ln, "U1-CLASS a=%d c=%d E[e^{ia Phi_A} e^{ic Phi_B}] = %le %le", &a, &c, &re, &im) == 4) { UM[a + 31][c + 31] = re + I * im; UH[a + 31][c + 31] = 1; } } }
  fclose(f); if (UL < 0) { fprintf(stderr, "no LMAX\n"); exit(1); }
  for (int a = -UL; a <= UL; a++) for (int c = -UL; c <= UL; c++) if (!UH[a + 31][c + 31] && UH[-a + 31][-c + 31]) { UM[a + 31][c + 31] = conj(UM[-a + 31][-c + 31]); UH[a + 31][c + 31] = 2; }
  for (int a = -UL; a <= UL; a++) for (int c = -UL; c <= UL; c++) if (!UH[a + 31][c + 31]) { fprintf(stderr, "U1 moment (%d,%d) missing\n", a, c); exit(1); } }
static double p_u1(double x, double y) { cx s = 0; for (int a = -UL; a <= UL; a++) for (int c = -UL; c <= UL; c++) s += UM[a + 31][c + 31] * cexp(-I * (a * x + c * y)); return creal(s); }
static double pA_u1(double x) { cx s = 0; for (int a = -UL; a <= UL; a++) s += UM[a + 31][31] * cexp(-I * a * x); return creal(s); }
static double pB_u1(double y) { cx s = 0; for (int c = -UL; c <= UL; c++) s += UM[31][c + 31] * cexp(-I * c * y); return creal(s); }
static void run_u1(const char *path, int N) { read_u1(path); const char *b = strrchr(path, '/'); b = b ? b + 1 : path; char tag[512]; snprintf(tag, sizeof tag, "%s[N%d]", b, N);
  double *pi = malloc(sizeof(double) * (size_t)N * N); int *anti = malloc(sizeof(int) * N);
  for (int g = 0; g < N; g++) { anti[g] = (g + N / 2) % N; for (int h = 0; h < N; h++) pi[(size_t)g * N + h] = p_u1(2 * PI * g / N, 2 * PI * h / N) / ((double)N * N); }
  analyse(tag, N, pi, anti); free(pi);
  int NV = 2048, NU = 4096; static cx EY[2048][64];
  for (int h = 0; h < NV; h++) for (int c = -UL; c <= UL; c++) EY[h][c + 31] = cexp(-I * c * (2 * PI * h / NV));
  for (int side = 0; side < 2; side++) { double best = 0, bx = 0, osc = 0, fmx = 0, g256 = 0;
    for (int g = 0; g < NU; g++) { double x = 2 * PI * g / NU; double S0 = 0, S1 = 0, S2 = 0, Fmx = -1e300, Fmn = 1e300; static double tv[4096], ov[4096];
      double mp = side == 0 ? pA_u1(x) : pB_u1(x), mm = side == 0 ? pA_u1(x + PI) : pB_u1(x + PI), t0 = (mp - mm) / (mp + mm);
      cx gp[64], gm[64]; /* side 0: gp[c] = sum_a M_ac e^{-i a x}; side 1: gp[a] = sum_c M_ac e^{-i c x} */
      for (int s = -UL; s <= UL; s++) { cx sp = 0, sm = 0; for (int o = -UL; o <= UL; o++) { cx m = side == 0 ? UM[o + 31][s + 31] : UM[s + 31][o + 31]; sp += m * cexp(-I * o * x); sm += m * cexp(-I * o * (x + PI)); } gp[s + 31] = sp; gm[s + 31] = sm; }
      for (int h = 0; h < NV; h++) { cx sp = 0, sm = 0; for (int s = -UL; s <= UL; s++) { sp += gp[s + 31] * EY[h][s + 31]; sm += gm[s + 31] * EY[h][s + 31]; } double pp = creal(sp), pm = creal(sm);
        double t = (pp - pm) / (pp + pm), om = (pp + pm) / NV; tv[h] = t; ov[h] = om; S0 += om; S1 += om * t; double F = log(pp / pm); if (F > Fmx) Fmx = F; if (F < Fmn) Fmn = F; }
      double mean = S1 / S0; for (int h = 0; h < NV; h++) S2 += ov[h] * (tv[h] - mean) * (tv[h] - mean); double r = sqrt(S2 / S0) / sqrt(1 - t0 * t0);
      if (r > best) { best = r; bx = x; } if (g % (NU / 256) == 0 && r > g256) g256 = r; if (Fmx - Fmn > osc) osc = Fmx - Fmn; fmx = fmax(fmx, fmax(fabs(Fmx), fabs(Fmn))); }
    printf("M4R-TAU %s side %c: sup over %d points = %.9f at phi = %.5f | on M4's 256-point grid: %.9f | osc F = %.6f max|F| = %.6f\n", tag, side ? 'B' : 'A', NU, best, bx, g256, osc, fmx); } }

int main(int argc, char **argv) {
  if (argc < 3) { fprintf(stderr, "usage: m4r_reader SU2O <dump> [Nth Nz Nph] | U1 <dump> [N]\n"); return 1; }
  /* sighted check of the irreps: homomorphism */
  { double err = 0; for (int t = 0; t < 50; t++) { qt a = { cos(0.7 * t + 0.1), sin(0.7 * t + 0.1) * 0.36, sin(0.7 * t + 0.1) * 0.48, sin(0.7 * t + 0.1) * 0.8 }, b = { cos(1.3 * t + 0.4), sin(1.3 * t + 0.4) * 0.6, -sin(1.3 * t + 0.4) * 0.8, 0 };
      for (int k = 1; k <= 2; k++) { int d = k + 1; cx Da[9], Db[9], Dab[9]; irr(k, a, Da); irr(k, b, Db); irr(k, qm(a, b), Dab);
        for (int i = 0; i < d; i++) for (int j = 0; j < d; j++) { cx s = 0; for (int m = 0; m < d; m++) s += Da[i * d + m] * Db[m * d + j]; err = fmax(err, cabs(s - Dab[i * d + j])); }
        cx tr = 0; for (int i = 0; i < d; i++) tr += Da[i * d + i]; err = fmax(err, cabs(tr - chi(k, qangle(a)))); } }
    printf("M4R-IRR homomorphism and characters of D^1, D^2 to %.1e [%s]\n", err, err < 1e-12 ? "MET" : "FAILED"); }
  if (!strcmp(argv[1], "SU2O")) run_su2o(argv[2], argc > 3 ? atoi(argv[3]) : 12, argc > 4 ? atoi(argv[4]) : 8, argc > 5 ? atoi(argv[5]) : 16);
  else if (!strcmp(argv[1], "U1")) run_u1(argv[2], argc > 3 ? atoi(argv[3]) : 512);
  else { fprintf(stderr, "unknown mode\n"); return 1; }
  return 0; }
