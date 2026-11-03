/* oneblock_abelian.c -- THE ABELIAN ONE-BLOCK FORM OF LEMMA T_loc' (ΑΠΕΡΑΝΤΟΝ Addendum III, the 03:1x section), READ EXACTLY ENOUGH.
 *
 *   THE OBJECT.  Fine torus Z_N^4 with link angles a_nu(x), the free action S_f(a) = 1/2 sum_x sum_{mu<nu} f_{mu nu}(x)^2,
 *   f_{mu nu}(x) = a_mu(x) + a_nu(x+mu) - a_mu(x+nu) - a_nu(x).  Coarse torus Z_{N'}^4, N = L N', block(y) = {x : floor(x/L) = y}.
 *   THE AVERAGING Q, gauge-covariant: the coarse link v_mu(y) is the average over the L^3 straight lines of the block in direction
 *   mu of the angle of a path from the block corner Ly to the corner Ly + L mu: a staircase within the near face to the line's start
 *   (the perpendicular coordinates in ascending order), the L links of the line, the reverse staircase within the far face back to the
 *   corner.  A fine gauge transformation phi changes every such path by phi(Ly + L mu) - phi(Ly), so v changes by the coarse gradient
 *   of phi at the corners: Q is covariant, and a constant field c maps to L c (the face legs cancel path by path).  A linear potential
 *   a_nu = f x_mu maps to a coarse field of constant plaquette L^2 f, whose coarse action equals its fine action exactly in d = 4; and
 *   that linear field is the constrained MINIMIZER (for admissible a + b with Qb = 0 the cross term f sum_x (db)_{mu nu} is a total
 *   difference, zero by periodicity), so the one-block difference vanishes exactly on constant flux -- the desk theorem.  What is
 *   READ here is the rest: DELTA(v) := min_{Qa = v} S_f(a) - S_c(v), S_c the coarse free action in the same normalization, on coarse
 *   plane waves of momentum K, where the claim is that it carries NO |K|^2 part (dimension four) and is O(|K|^4) (dimension six) with
 *   a coefficient falling as L^{-2}: the tree-level contraction of T_loc', theta = 1.
 *   THE ROAD.  Everything is diagonal in the coarse momentum K in (2 pi/N') Z^4: the fine momenta with L k = K mod 2 pi are the L^4
 *   aliases k_s = K/L + 2 pi s/L.  With d_mu(k) = e^{i k_mu} - 1, S_f = 1/(2 N^4) sum_k a^H M(k) a with M = |d|^2 I - d d^H (the gauge
 *   null vector d), and v^(K) = L^{-4} sum_s Q_s a^(k_s) with (Q_s)_{mu rho} = q^_{mu rho}(-k_s), q^ the Fourier transform of the
 *   path-average coefficients of block 0.  Writing a_s = a_s^perp + d_s phi_s: M_s a_s = |d_s|^2 a_s^perp, and Q_s d_s = d'(K) :=
 *   (e^{i K_mu} - 1)_mu for EVERY alias (the corner gradient; checked numerically below), so the gauge part only moves v along d'.
 *   The constrained minimum is a weighted least norm: with P the projector onto d'^perp in C^4 and
 *       G(K) = P [ sum_s Q_s P_s^perp Q_s^H / |d_s|^2 ] P,      P_s^perp = I - d_s d_s^H/|d_s|^2,
 *   min_{Qa = v} S_f = (L^8/(2 N^4)) v^H G^+ v, while S_c's form is (1/(2 N'^4)) v^H (|d'|^2 I - d' d'^H) v; both annihilate d'.
 *   The dimensionless difference on d'^perp:  DELTA~(K) = L^4 G^+ - |d'|^2 I  (so that DELTA(K) = DELTA~ /(2 N'^4) per unit |v^|^2),
 *   read by its three eigenvalues on d'^perp against |d'|^2 ~ |K|^2 and |d'|^4.  CONTROLS: L = 1 gives DELTA~ = 0 identically (the
 *   dead world); Q_s d_s - d'(K) = 0 for every alias (the covariance of the path average, the one formula the whole road rests on).
 *   THE SECOND ROAD (sharing no line): on N = 4, L = 2 the constrained minimum in POSITION SPACE by the KKT system -- M (1024 x 1024,
 *   singular on the gauge directions, regularized by eps on the diagonal, the value's error O(eps |a|^2)), the 64 path-average
 *   constraints, the Schur complement -- for the coarse plane wave v_2(y) = (-1)^{y_1} (K = (pi,0,0,0), polarization e_2), against the
 *   momentum road's (L^8/(2 N^4)) |v^|^2 (G^+)_{22} = 128 (G^+)_{22}, and the coarse action 32 by both roads.
 *   MODES:  kat            the two-road check and the controls;
 *           scan L NP DIR  DELTA~'s eigenvalues at K = n (2 pi/NP) DIR, n = 1..NP/2, with lambda/|d'|^2 and lambda/|d'|^4 (DIR = x: the
 *                          axis (1,0,0,0); xy: (1,1,0,0); xyzt: (1,1,1,1)).
 *   gcc -O2 -std=c99 oneblock_abelian.c -o oneblock_abelian -lm.  Doubles: a READING; the exact statements are the desk's.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

typedef double complex cx;
#define MAXL 6
#define BOX ((MAXL + 1) * (MAXL + 1) * (MAXL + 1) * (MAXL + 1))

/* ---- the path average of block 0: q[mu][rho][z], z in [0, L]^4 (index z0 + (L+1)(z1 + (L+1)(z2 + (L+1) z3))) */
static int L_;
static double q[4][4][BOX];
static int zidx(const int z[4]) { int s = L_ + 1; return z[0] + s * (z[1] + s * (z[2] + s * z[3])); }
static void add_link(int mu, const int z[4], int rho, double w) { q[mu][rho][zidx(z)] += w; }
static void build_paths(int L) {
  L_ = L; memset(q, 0, sizeof q);
  double w = 1.0 / (double) (L * L * L);
  for (int mu = 0; mu < 4; mu++) {
    int perp[3], np = 0; for (int r = 0; r < 4; r++) if (r != mu) perp[np++] = r;
    for (int t0 = 0; t0 < L; t0++) for (int t1 = 0; t1 < L; t1++) for (int t2 = 0; t2 < L; t2++) {
      int t[3] = { t0, t1, t2 }, z[4] = { 0, 0, 0, 0 };
      /* near face: ascending perpendicular order, forward links */
      for (int j = 0; j < 3; j++) for (int k = 0; k < t[j]; k++) { add_link(mu, z, perp[j], w); z[perp[j]]++; }
      /* the line */
      for (int k = 0; k < L; k++) { add_link(mu, z, mu, w); z[mu]++; }
      /* far face: descending order, backward links (the link (x - rho, rho) traversed from x) */
      for (int j = 2; j >= 0; j--) for (int k = 0; k < t[j]; k++) { z[perp[j]]--; add_link(mu, z, perp[j], -w); }
      for (int r = 0; r < 4; r++) if (z[r] != (r == mu ? L : 0)) { fprintf(stderr, "path does not end at the far corner\n"); exit(9); }
    }
  }
}
/* q^_{mu rho}(k) = sum_z q e^{-i k.z} */
static cx qhat(int mu, int rho, const double k[4]) {
  cx s = 0; int z[4];
  for (z[3] = 0; z[3] <= L_; z[3]++) for (z[2] = 0; z[2] <= L_; z[2]++) for (z[1] = 0; z[1] <= L_; z[1]++) for (z[0] = 0; z[0] <= L_; z[0]++) {
    double c = q[mu][rho][zidx(z)]; if (c == 0) continue;
    double ph = -(k[0] * z[0] + k[1] * z[1] + k[2] * z[2] + k[3] * z[3]);
    s += c * (cos(ph) + I * sin(ph));
  }
  return s;
}

/* ---- small complex linear algebra */
static void herm_inv3(cx A[3][3], cx B[3][3]) {        /* B = A^{-1}, 3x3, by cofactors */
  cx det = A[0][0] * (A[1][1] * A[2][2] - A[1][2] * A[2][1]) - A[0][1] * (A[1][0] * A[2][2] - A[1][2] * A[2][0]) + A[0][2] * (A[1][0] * A[2][1] - A[1][1] * A[2][0]);
  if (cabs(det) == 0) { fprintf(stderr, "singular 3x3\n"); exit(8); }
  B[0][0] = (A[1][1] * A[2][2] - A[1][2] * A[2][1]) / det; B[0][1] = (A[0][2] * A[2][1] - A[0][1] * A[2][2]) / det; B[0][2] = (A[0][1] * A[1][2] - A[0][2] * A[1][1]) / det;
  B[1][0] = (A[1][2] * A[2][0] - A[1][0] * A[2][2]) / det; B[1][1] = (A[0][0] * A[2][2] - A[0][2] * A[2][0]) / det; B[1][2] = (A[0][2] * A[1][0] - A[0][0] * A[1][2]) / det;
  B[2][0] = (A[1][0] * A[2][1] - A[1][1] * A[2][0]) / det; B[2][1] = (A[0][1] * A[2][0] - A[0][0] * A[2][1]) / det; B[2][2] = (A[0][0] * A[1][1] - A[0][1] * A[1][0]) / det;
}
/* eigenvalues of a 3x3 Hermitian matrix: the real symmetric 6x6 embedding [[Re, -Im],[Im, Re]] by cyclic Jacobi (pairs) */
static void herm_eig3(cx H[3][3], double ev[3]) {
  double A[6][6];
  for (int i = 0; i < 3; i++) for (int j = 0; j < 3; j++) { A[i][j] = creal(H[i][j]); A[i + 3][j + 3] = creal(H[i][j]); A[i][j + 3] = -cimag(H[i][j]); A[i + 3][j] = cimag(H[i][j]); }
  for (int sweep = 0; sweep < 60; sweep++) {
    double off = 0; for (int i = 0; i < 6; i++) for (int j = i + 1; j < 6; j++) off += A[i][j] * A[i][j];
    if (off < 1e-30) break;
    for (int p = 0; p < 6; p++) for (int qq = p + 1; qq < 6; qq++) {
      if (fabs(A[p][qq]) < 1e-300) continue;
      double th = 0.5 * atan2(2 * A[p][qq], A[qq][qq] - A[p][p]), c = cos(th), s = sin(th);
      for (int k = 0; k < 6; k++) { double akp = A[k][p], akq = A[k][qq]; A[k][p] = c * akp - s * akq; A[k][qq] = s * akp + c * akq; }
      for (int k = 0; k < 6; k++) { double apk = A[p][k], aqk = A[qq][k]; A[p][k] = c * apk - s * aqk; A[qq][k] = s * apk + c * aqk; }
    }
  }
  double d[6]; for (int i = 0; i < 6; i++) d[i] = A[i][i];
  for (int i = 0; i < 6; i++) for (int j = i + 1; j < 6; j++) if (d[j] < d[i]) { double t = d[i]; d[i] = d[j]; d[j] = t; }
  ev[0] = d[0]; ev[1] = d[2]; ev[2] = d[4];   /* each eigenvalue twice in the embedding */
}

/* ---- the per-K computation: DELTA~ on d'^perp, its eigenvalues; returns |d'|^2; also the covariance defect and G^+ in the basis */
static double perK(int L, int NP, const double K[4], double ev[3], double *covdef, cx Gp3[3][3], cx B[4][3]) {
  int N = L * NP; (void) N;
  cx dp[4]; double dp2 = 0;
  for (int m = 0; m < 4; m++) { dp[m] = cexp(I * K[m]) - 1.0; dp2 += cabs(dp[m]) * cabs(dp[m]); }
  /* an orthonormal basis of d'^perp: Gram-Schmidt on e_j, skipping the j most parallel to d' */
  int skip = 0; double best = -1; for (int m = 0; m < 4; m++) if (cabs(dp[m]) > best) { best = cabs(dp[m]); skip = m; }
  int nb = 0; cx u[3][4];
  for (int m = 0; m < 4; m++) {
    if (m == skip) continue;
    cx w[4] = { 0, 0, 0, 0 }; w[m] = 1.0;
    /* remove the d' component, then the previous basis vectors */
    cx c = 0; for (int r = 0; r < 4; r++) c += conj(dp[r]) * w[r]; for (int r = 0; r < 4; r++) w[r] -= dp[r] * c / dp2;
    for (int b = 0; b < nb; b++) { cx cc = 0; for (int r = 0; r < 4; r++) cc += conj(u[b][r]) * w[r]; for (int r = 0; r < 4; r++) w[r] -= u[b][r] * cc; }
    double nn = 0; for (int r = 0; r < 4; r++) nn += cabs(w[r]) * cabs(w[r]); nn = sqrt(nn);
    for (int r = 0; r < 4; r++) u[nb][r] = w[r] / nn; nb++;
  }
  for (int r = 0; r < 4; r++) for (int b = 0; b < 3; b++) B[r][b] = u[b][r];
  /* G = sum_s Q_s P_s^perp Q_s^H / |d_s|^2 over the aliases; the covariance defect max_s |Q_s d_s - d'| */
  cx G[4][4]; memset(G, 0, sizeof G); *covdef = 0;
  int s[4];
  for (s[3] = 0; s[3] < L; s[3]++) for (s[2] = 0; s[2] < L; s[2]++) for (s[1] = 0; s[1] < L; s[1]++) for (s[0] = 0; s[0] < L; s[0]++) {
    double k[4], mk[4]; cx d[4]; double d2 = 0;
    for (int m = 0; m < 4; m++) { k[m] = K[m] / L + 2 * M_PI * s[m] / L; mk[m] = -k[m]; d[m] = cexp(I * k[m]) - 1.0; d2 += cabs(d[m]) * cabs(d[m]); }
    cx Q[4][4]; for (int m = 0; m < 4; m++) for (int r = 0; r < 4; r++) Q[m][r] = qhat(m, r, mk);
    /* covariance: Q_s d_s should equal d' */
    for (int m = 0; m < 4; m++) { cx t = 0; for (int r = 0; r < 4; r++) t += Q[m][r] * d[r]; double e = cabs(t - dp[m]); if (e > *covdef) *covdef = e; }
    if (d2 < 1e-24) continue;                       /* the k = 0 alias (only at K = 0): no contribution */
    cx QP[4][4];                                    /* Q_s P_s^perp */
    for (int m = 0; m < 4; m++) for (int r = 0; r < 4; r++) { cx t = 0; for (int rr = 0; rr < 4; rr++) t += Q[m][rr] * ((rr == r ? 1.0 : 0.0) - d[rr] * conj(d[r]) / d2); QP[m][r] = t; }
    for (int m = 0; m < 4; m++) for (int mm = 0; mm < 4; mm++) { cx t = 0; for (int r = 0; r < 4; r++) t += QP[m][r] * conj(QP[mm][r]); G[m][mm] += t / d2; }
  }
  /* G3 = B^H G B; G^+ on d'^perp = B G3^{-1} B^H; DELTA~_3 = L^4 G3^{-1} - |d'|^2 I */
  cx G3[3][3], Gi[3][3];
  for (int a = 0; a < 3; a++) for (int b = 0; b < 3; b++) { cx t = 0; for (int r = 0; r < 4; r++) for (int rr = 0; rr < 4; rr++) t += conj(B[r][a]) * G[r][rr] * B[rr][b]; G3[a][b] = t; }
  herm_inv3(G3, Gi);
  for (int a = 0; a < 3; a++) for (int b = 0; b < 3; b++) Gp3[a][b] = Gi[a][b];
  cx D3[3][3]; double L4 = (double) L * L * L * L;
  for (int a = 0; a < 3; a++) for (int b = 0; b < 3; b++) D3[a][b] = L4 * Gi[a][b] - (a == b ? dp2 : 0.0);
  herm_eig3(D3, ev);
  return dp2;
}

/* ---- the position-space road on N = 4, L = 2 */
static int N4 = 4;
static int site(int x0, int x1, int x2, int x3) { return ((x0 & 3)) + 4 * ((x1 & 3) + 4 * ((x2 & 3) + 4 * (x3 & 3))); }
static int link_(int xs[4], int nu) { return 4 * site(xs[0], xs[1], xs[2], xs[3]) + nu; }
static void chol_solve(double *A, int n, double *b) {   /* A SPD n x n (row-major), in place Cholesky, solve A x = b into b */
  for (int j = 0; j < n; j++) {
    double sum = A[j * n + j]; for (int k = 0; k < j; k++) sum -= A[j * n + k] * A[j * n + k];
    if (sum <= 0) { fprintf(stderr, "not SPD at %d\n", j); exit(7); }
    A[j * n + j] = sqrt(sum);
    for (int i = j + 1; i < n; i++) { double t = A[i * n + j]; for (int k = 0; k < j; k++) t -= A[i * n + k] * A[j * n + k]; A[i * n + j] = t / A[j * n + j]; }
  }
  for (int i = 0; i < n; i++) { double t = b[i]; for (int k = 0; k < i; k++) t -= A[i * n + k] * b[k]; b[i] = t / A[i * n + i]; }
  for (int i = n - 1; i >= 0; i--) { double t = b[i]; for (int k = i + 1; k < n; k++) t -= A[k * n + i] * b[k]; b[i] = t / A[i * n + i]; }
}
static double position_road(double eps, double *Sc_out, double *cdef_out) {
  const int n = 4 * 256, m = 64, L = 2;
  double *M = calloc((size_t) n * n, sizeof *M), *C = calloc((size_t) m * n, sizeof *C);
  /* M = sum over plaquettes of the outer product of the plaquette row */
  for (int x3 = 0; x3 < 4; x3++) for (int x2 = 0; x2 < 4; x2++) for (int x1 = 0; x1 < 4; x1++) for (int x0 = 0; x0 < 4; x0++)
    for (int mu = 0; mu < 4; mu++) for (int nu = mu + 1; nu < 4; nu++) {
      int xs[4] = { x0, x1, x2, x3 }, xm[4] = { x0, x1, x2, x3 }, xn[4] = { x0, x1, x2, x3 }; xm[mu]++; xn[nu]++;
      int idx[4] = { link_(xs, mu), link_(xm, nu), link_(xn, mu), link_(xs, nu) }; double sg[4] = { 1, 1, -1, -1 };
      for (int a = 0; a < 4; a++) for (int b = 0; b < 4; b++) M[(size_t) idx[a] * n + idx[b]] += sg[a] * sg[b];
    }
  /* the constraints: v_mu(y) = sum over the paths of block y (the translates of block 0's) */
  build_paths(L);
  for (int y3 = 0; y3 < 2; y3++) for (int y2 = 0; y2 < 2; y2++) for (int y1 = 0; y1 < 2; y1++) for (int y0 = 0; y0 < 2; y0++) for (int mu = 0; mu < 4; mu++) {
    int row = 4 * (y0 + 2 * (y1 + 2 * (y2 + 2 * y3))) + mu; int z[4];
    for (z[3] = 0; z[3] <= L; z[3]++) for (z[2] = 0; z[2] <= L; z[2]++) for (z[1] = 0; z[1] <= L; z[1]++) for (z[0] = 0; z[0] <= L; z[0]++)
      for (int rho = 0; rho < 4; rho++) { double c = q[mu][rho][zidx(z)]; if (c == 0) continue; int xs[4] = { L * y0 + z[0], L * y1 + z[1], L * y2 + z[2], L * y3 + z[3] }; C[(size_t) row * n + link_(xs, rho)] += c; }
  }
  /* the coarse plane wave v_2(y) = (-1)^{y_1} and its coarse action in position space */
  double w[64]; for (int r = 0; r < m; r++) w[r] = 0;
  for (int y3 = 0; y3 < 2; y3++) for (int y2 = 0; y2 < 2; y2++) for (int y1 = 0; y1 < 2; y1++) for (int y0 = 0; y0 < 2; y0++) w[4 * (y0 + 2 * (y1 + 2 * (y2 + 2 * y3))) + 2] = (y1 & 1) ? -1.0 : 1.0;
  double Sc = 0;
  for (int y3 = 0; y3 < 2; y3++) for (int y2 = 0; y2 < 2; y2++) for (int y1 = 0; y1 < 2; y1++) for (int y0 = 0; y0 < 2; y0++) {
    int ys[4] = { y0, y1, y2, y3 };
    for (int mu = 0; mu < 4; mu++) for (int nu = mu + 1; nu < 4; nu++) {
      int ym[4] = { y0, y1, y2, y3 }, yn[4] = { y0, y1, y2, y3 }; ym[mu] = (ym[mu] + 1) & 1; yn[nu] = (yn[nu] + 1) & 1;
#define V(Y, R) w[4 * ((Y)[0] + 2 * ((Y)[1] + 2 * ((Y)[2] + 2 * (Y)[3]))) + (R)]
      double F = V(ys, mu) + V(ym, nu) - V(yn, mu) - V(ys, nu); Sc += 0.5 * F * F;
    }
  }
  *Sc_out = Sc;
  /* the Schur complement with the regularization eps on M: the value V(eps) = V0 + a eps + b eps^2 + ..., extrapolated by the caller */
  double *A = malloc((size_t) n * n * sizeof *A); memcpy(A, M, (size_t) n * n * sizeof *A); for (int i = 0; i < n; i++) A[(size_t) i * n + i] += eps;
  /* Cholesky once (in place), then solve for the 64 columns of C^T */
  for (int j = 0; j < n; j++) {
    double sum = A[(size_t) j * n + j]; for (int k = 0; k < j; k++) sum -= A[(size_t) j * n + k] * A[(size_t) j * n + k];
    A[(size_t) j * n + j] = sqrt(sum);
    for (int i = j + 1; i < n; i++) { double t = A[(size_t) i * n + j]; for (int k = 0; k < j; k++) t -= A[(size_t) i * n + k] * A[(size_t) j * n + k]; A[(size_t) i * n + j] = t / A[(size_t) j * n + j]; }
  }
  double *Y = malloc((size_t) m * n * sizeof *Y);
  for (int r = 0; r < m; r++) {
    double *b = Y + (size_t) r * n; for (int i = 0; i < n; i++) b[i] = C[(size_t) r * n + i];
    for (int i = 0; i < n; i++) { double t = b[i]; for (int k = 0; k < i; k++) t -= A[(size_t) i * n + k] * b[k]; b[i] = t / A[(size_t) i * n + i]; }
    for (int i = n - 1; i >= 0; i--) { double t = b[i]; for (int k = i + 1; k < n; k++) t -= A[(size_t) k * n + i] * b[k]; b[i] = t / A[(size_t) i * n + i]; }
  }
  double S[64 * 64]; for (int r = 0; r < m; r++) for (int c2 = 0; c2 < m; c2++) { double t = 0; for (int i = 0; i < n; i++) t += C[(size_t) r * n + i] * Y[(size_t) c2 * n + i]; S[r * m + c2] = t; }
  double lam[64]; for (int r = 0; r < m; r++) lam[r] = w[r];
  chol_solve(S, m, lam);                          /* lam = S^{-1} w; a = Y^T lam (sign immaterial for the value) */
  double *a = calloc(n, sizeof *a); for (int r = 0; r < m; r++) for (int i = 0; i < n; i++) a[i] += Y[(size_t) r * n + i] * lam[r];
  double val = 0; for (int i = 0; i < n; i++) { double t = 0; for (int j = 0; j < n; j++) t += M[(size_t) i * n + j] * a[j]; val += a[i] * t; } val *= 0.5;
  double cmax = 0; for (int r = 0; r < m; r++) { double t = 0; for (int i = 0; i < n; i++) t += C[(size_t) r * n + i] * a[i]; double e = fabs(t - w[r]); if (e > cmax) cmax = e; }
  printf("ONEBLOCK-POSITION N=4 L=2 K=(pi,0,0,0) pol=e2 eps=%.1e Sf_min(eps)=%.12f constraint_defect=%.2e Sc=%.12f ;\n", eps, val, cmax, Sc);
  *cdef_out = cmax;
  free(M); free(C); free(A); free(Y); free(a);
  return val;
}

static void scan(int L, int NP, const char *dir) {
  double D[4] = { 1, 0, 0, 0 };
  if (!strcmp(dir, "xy")) { D[1] = 1; } else if (!strcmp(dir, "xyzt")) { D[1] = D[2] = D[3] = 1; }
  build_paths(L);
  printf("ONEBLOCK-SCAN L=%d NP=%d dir=%s (K = n*2pi/NP*dir; DELTA~ = L^4 G^+ - |d'|^2 on d'^perp; lambda its eigenvalues) ;\n", L, NP, dir);
  for (int n = 1; n <= NP / 2; n++) {
    double K[4]; for (int m = 0; m < 4; m++) K[m] = 2 * M_PI * n * D[m] / NP;
    double ev[3], cov; cx Gp[3][3], B[4][3];
    double dp2 = perK(L, NP, K, ev, &cov, Gp, B);
    printf("ONEBLOCK n=%d |K|^2=%.10f |d'|^2=%.10f lambda=[%.10e, %.10e, %.10e] lambda/|d'|^2=[%.6e, %.6e, %.6e] lambda/|d'|^4=[%.6e, %.6e, %.6e] covariance_defect=%.1e ;\n",
           n, (K[0] * K[0] + K[1] * K[1] + K[2] * K[2] + K[3] * K[3]), dp2, ev[0], ev[1], ev[2], ev[0] / dp2, ev[1] / dp2, ev[2] / dp2, ev[0] / (dp2 * dp2), ev[1] / (dp2 * dp2), ev[2] / (dp2 * dp2), cov);
  }
}

int main(int argc, char **argv) {
  const char *mode = argc > 1 ? argv[1] : "kat";
  if (!strcmp(mode, "kat")) {
    /* control 1: L = 1 is the dead world, DELTA~ = 0 */
    build_paths(1); { double K[4] = { 2 * M_PI * 3 / 16, 2 * M_PI * 1 / 16, 0, 0 }, ev[3], cov; cx Gp[3][3], B[4][3]; perK(1, 16, K, ev, &cov, Gp, B);
      printf("ONEBLOCK-KAT L=1 (no blocking) lambda=[%.3e, %.3e, %.3e] covariance_defect=%.1e (DELTA~ must vanish) ;\n", ev[0], ev[1], ev[2], cov); }
    /* control 2: the momentum road at N = 4, L = 2, K = (pi,0,0,0), e_2: Sf_min = 128 (G^+)_{22} in the e-basis */
    build_paths(2); { double K[4] = { M_PI, 0, 0, 0 }, ev[3], cov; cx Gp[3][3], B[4][3]; double dp2 = perK(2, 2, K, ev, &cov, Gp, B);
      /* (G^+)_{22} = e_2^H B Gp B^H e_2 */
      cx t = 0; for (int a = 0; a < 3; a++) for (int b = 0; b < 3; b++) t += conj(B[2][a]) * Gp[a][b] * B[2][b];
      double Sf_mom = 128.0 * creal(t), Sc_mom = 0.5 / 16.0 * dp2 * 256.0;
      printf("ONEBLOCK-MOMENTUM N=4 L=2 K=(pi,0,0,0) pol=e2 Sf_min=%.12f Sc=%.12f covariance_defect=%.1e ;\n", Sf_mom, Sc_mom, cov);
      /* the position road at three regularizations, Richardson-extrapolated to eps = 0 (V = V0 + a eps + b eps^2) */
      double Sc_pos, c1, c2, c3, e1 = 4e-4;
      double V1 = position_road(e1, &Sc_pos, &c1), V2 = position_road(e1 / 2, &Sc_pos, &c2), V3 = position_road(e1 / 4, &Sc_pos, &c3);
      double Sf_pos = (8 * V3 - 6 * V2 + V1) / 3;
      double rel = fabs(Sf_pos - Sf_mom) / fabs(Sf_mom);
      printf("ONEBLOCK-KAT two roads: Sf_min momentum=%.12f position(Richardson over eps=%.0e,%.0e,%.0e)=%.12f rel_diff=%.2e ; Sc momentum=%.12f position=%.12f ; verdict=%s ;\n",
             Sf_mom, e1, e1 / 2, e1 / 4, Sf_pos, rel, Sc_mom, Sc_pos, (rel < 1e-7 && fabs(Sc_mom - Sc_pos) < 1e-9) ? "MET" : "PART");
    }
  } else if (!strcmp(mode, "scan")) {
    int L = argc > 2 ? atoi(argv[2]) : 2, NP = argc > 3 ? atoi(argv[3]) : 64; const char *dir = argc > 4 ? argv[4] : "x";
    if (L < 1 || L > MAXL) { fprintf(stderr, "L in 1..%d\n", MAXL); return 2; }
    scan(L, NP, dir);
  } else { fprintf(stderr, "modes: kat | scan L NP dir\n"); return 2; }
  printf("ONEBLOCK-END ;\n");
  return 0;
}
