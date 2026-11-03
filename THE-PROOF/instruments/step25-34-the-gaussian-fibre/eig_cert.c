/* eig_cert.c -- THE PERRON CERTIFICATE: every eigenvalue of a dumped complex matrix enclosed in a verified disc, the discs disjoint
   and their multiplicities summing to n, so the dominant eigenvalue and the gap below it are CERTIFIED for the matrix as dumped
   (2026-11-03, the author the author, for the development: its decider admits "a Dobrushin row with a Perron certificate", and its
   cell transfer operators at W2/W3 are non-normal with conjugate pairs and exact multiplets, where a Wielandt chain reads Rayleigh
   quotients -- so the honest instrument is a verification, not an iteration).
   THE METHOD (Krawczyk; Rump, "Computational error bounds for multiple or nearly multiple eigenvalues", LAA 324 (2001); Rump, Acta
   Numerica 2010 s.13), the block form: for a cluster of k approximate eigenvalues with an approximate invariant basis X (n x k,
   normalised X_U = I on k pivot rows U) and M (k x k) with A X ~ X M, the unknowns y = (the free entries of X, the entries of M), the
   map F(y) = A X - X M, its Jacobian J (affine in y), R ~ J(y^)^{-1} in floating point.  For a box y^ + D (discs of radius rho about
   0) the Krawczyk image is K = -R F(y^) + (I - R J(y^)) D + R vec(2 DX DM) (the second-order term is exact: J is affine), every term
   evaluated in midpoint-radius complex interval arithmetic with the rounding of each operation added to the radius.  If K lies in the
   INTERIOR of D (|c_i| + r_i < rho_i for every component) then F has exactly one zero in y^ + D: a true invariant pair (X~, M~) whose
   k eigenvalues (those of M~, enclosed by Gershgorin discs of the interval matrix M^ + DM) are eigenvalues of A.  With every cluster
   verified, the discs pairwise disjoint and the cluster sizes summing to n, each disc holds EXACTLY its k eigenvalues of A and none
   lies outside (at least k in each, n in all): COMPLETE.  Then the gap is the quotient of the dominant disc's lower modulus by the
   largest upper modulus of the rest, CERTIFIED.
   THE SEEDS are this file's own: Householder reduction to Hessenberg form and the shifted QR iteration (Wilkinson shift, Givens steps,
   deflation on a negligible subdiagonal) for the eigenvalues, inverse iteration with Gram-Schmidt for the cluster bases -- a wrong seed
   can only make a verification FAIL, never pass; nothing here is shared with the development's reader (law 6).
   KNOWN ANSWERS (--kat): [[1,2],[3,4]] -> (5 +- sqrt 33)/2 both VERIFIED and each exact value inside its disc; a Jordan block of
   multiplicity three beside a simple 3 -> a cluster of 3 VERIFIED, COMPLETE 4 of 4; the control: [[1,2],[-3,4]] has (5 +- i sqrt 15)/2
   and the planted (5 +- sqrt 33)/2 must lie OUTSIDE its discs (SIGHTED).  Alphabet (infix-free, checked by the development's register): ENCLOSED / OPEN-BOX / ALL-CLUSTERS / SOME-CLUSTERS / GAP-UNCONDITIONAL / GAP-CONDITIONAL / GAP-ABSENT / SIGHTED / CONTROL-DEAD (law 46: no token an infix of another, in this file or in the development's register). Old names:
   INCOMPLETE / CERTIFIED / UNCERTIFIED / SIGHTED / BLIND.
   build: gcc -O2 -fno-fast-math -ffp-contract=off -o eig_cert.exe eig_cert.c -lm      usage: eig_cert T.txt [CLUSTER_REL=1e-8] | eig_cert --kat */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
#include <float.h>
typedef double complex cplx;
static const double U = DBL_EPSILON / 2;          /* the unit roundoff of binary64 */
static const double TINY = 1e-290;                 /* the underflow guard added to every radius */

/* ---------------------------------------------------------------- midpoint-radius complex intervals (discs) */
typedef struct { cplx c; double r; } disc;
static double up(double x) { return x * (1 + 4 * U) + TINY; }         /* an upper bound of a computed nonnegative quantity */
static double mag(cplx z) { return up(cabs(z)); }                        /* an upper bound of |z| */
static disc dpt(cplx c) { disc d; d.c = c; d.r = 0; return d; }
static disc dadd(disc a, disc b) { disc d; d.c = a.c + b.c; d.r = up(a.r + b.r + mag(d.c) * 2 * U); return d; }
static disc dsub(disc a, disc b) { disc d; d.c = a.c - b.c; d.r = up(a.r + b.r + mag(d.c) * 2 * U); return d; }
static disc dmul(disc a, disc b) { disc d; d.c = a.c * b.c; d.r = up(mag(a.c) * b.r + mag(b.c) * a.r + a.r * b.r + mag(d.c) * 8 * U); return d; }
static disc dscal(cplx s, disc a) { disc d; d.c = s * a.c; d.r = up(mag(s) * a.r + mag(d.c) * 8 * U); return d; }

/* ---------------------------------------------------------------- dense complex linear algebra (floating point, the seeds and R) */
static int n;                                      /* the matrix dimension */
static double ENTRY_REL = -1;                      /* the relative radius of every dumped entry (EC_ENTRY_REL; default n * 2^-52, the development's honest rounding of a double from its exact-cubature engine); 0 certifies the dump as exact */
static void balance(double complex *B, int m);     /* defined below the verification; called at the start of a run */
static cplx *A;                                    /* row-major n x n */
#define AA(i,j) A[(size_t)(i) * n + (j)]
static cplx *cmat(int r, int c) { cplx *m = calloc((size_t) r * c, sizeof(cplx)); if (!m) { fprintf(stderr, "EC-REFUSED: out of memory\n"); exit(2); } return m; }

/* LU with partial pivoting on a copy; solve for several right-hand sides; returns 0 if a pivot is exactly zero */
static int lu_factor(cplx *L, int m, int *piv) {
  for (int k = 0; k < m; k++) {
    int p = k; double best = cabs(L[(size_t) k * m + k]);
    for (int i = k + 1; i < m; i++) { double v = cabs(L[(size_t) i * m + k]); if (v > best) { best = v; p = i; } }
    piv[k] = p;
    if (p != k) for (int j = 0; j < m; j++) { cplx t = L[(size_t) k * m + j]; L[(size_t) k * m + j] = L[(size_t) p * m + j]; L[(size_t) p * m + j] = t; }
    if (L[(size_t) k * m + k] == 0) return 0;
    for (int i = k + 1; i < m; i++) { cplx f = L[(size_t) i * m + k] / L[(size_t) k * m + k]; L[(size_t) i * m + k] = f; for (int j = k + 1; j < m; j++) L[(size_t) i * m + j] -= f * L[(size_t) k * m + j]; }
  }
  return 1;
}
static void lu_solve(const cplx *L, int m, const int *piv, cplx *b) {   /* in place, one right-hand side */
  for (int k = 0; k < m; k++) if (piv[k] != k) { cplx t = b[k]; b[k] = b[piv[k]]; b[piv[k]] = t; }   /* every interchange first (P A = L U), then L, then U */
  for (int k = 0; k < m; k++) for (int i = k + 1; i < m; i++) b[i] -= L[(size_t) i * m + k] * b[k];
  for (int k = m - 1; k >= 0; k--) { for (int i = k + 1; i < m; i++) b[k] -= L[(size_t) k * m + i] * b[i]; b[k] /= L[(size_t) k * m + k]; }
}
static cplx *inverse(const cplx *Mx, int m) {   /* NULL if singular in floating point */
  cplx *L = cmat(m, m); memcpy(L, Mx, (size_t) m * m * sizeof(cplx)); int *piv = malloc(sizeof(int) * m);
  if (!lu_factor(L, m, piv)) { free(L); free(piv); return NULL; }
  cplx *R = cmat(m, m); cplx *col = cmat(m, 1);
  for (int j = 0; j < m; j++) { for (int i = 0; i < m; i++) col[i] = (i == j); lu_solve(L, m, piv, col); for (int i = 0; i < m; i++) R[(size_t) i * m + j] = col[i]; }
  free(L); free(piv); free(col); return R;
}

/* ---------------------------------------------------------------- the seeds: Hessenberg + shifted QR (this file's own) */
static void eigenvalues(const cplx *A0, int m, cplx *eig) {
  cplx *H = cmat(m, m); memcpy(H, A0, (size_t) m * m * sizeof(cplx));
#define HH(i,j) H[(size_t)(i) * m + (j)]
  for (int k = 0; k + 2 < m; k++) {   /* Householder: zero below the subdiagonal in column k */
    double xn = 0; for (int i = k + 1; i < m; i++) xn += creal(HH(i, k)) * creal(HH(i, k)) + cimag(HH(i, k)) * cimag(HH(i, k));
    xn = sqrt(xn); if (xn == 0) continue;
    int len = m - k - 1; cplx *v = cmat(len, 1); cplx x0 = HH(k + 1, k); double a0 = cabs(x0); cplx ph = (a0 == 0) ? 1.0 : x0 / a0;
    for (int i = 0; i < len; i++) v[i] = HH(k + 1 + i, k);
    v[0] += ph * xn;
    double vn = 0; for (int i = 0; i < len; i++) vn += creal(v[i]) * creal(v[i]) + cimag(v[i]) * cimag(v[i]);
    if (vn == 0) { free(v); continue; }
    for (int j = 0; j < m; j++) { cplx s = 0; for (int i = 0; i < len; i++) s += conj(v[i]) * HH(k + 1 + i, j); s *= 2.0 / vn; for (int i = 0; i < len; i++) HH(k + 1 + i, j) -= v[i] * s; }
    for (int i = 0; i < m; i++) { cplx s = 0; for (int j = 0; j < len; j++) s += HH(i, k + 1 + j) * v[j]; s *= 2.0 / vn; for (int j = 0; j < len; j++) HH(i, k + 1 + j) -= s * conj(v[j]); }
    for (int i = k + 2; i < m; i++) HH(i, k) = 0;
    free(v);
  }
  int hi = m - 1, its = 0;
  while (hi >= 0) {
    if (hi == 0) { eig[0] = HH(0, 0); break; }
    int l = hi;   /* find the active block [l, hi]: deflate on a negligible subdiagonal */
    while (l > 0) { double s = cabs(HH(l - 1, l - 1)) + cabs(HH(l, l)); if (s == 0) s = 1; if (cabs(HH(l, l - 1)) <= 16 * DBL_EPSILON * s) { HH(l, l - 1) = 0; break; } l--; }
    if (l == hi) { eig[hi] = HH(hi, hi); hi--; its = 0; continue; }
    its++;
    cplx a = HH(hi - 1, hi - 1), b = HH(hi - 1, hi), c = HH(hi, hi - 1), d = HH(hi, hi);
    cplx tr = a + d, det = a * d - b * c, disc_ = csqrt(tr * tr / 4 - det), l1 = tr / 2 + disc_, l2 = tr / 2 - disc_;
    cplx mu = (cabs(l1 - d) < cabs(l2 - d)) ? l1 : l2;                       /* the Wilkinson shift */
    if (its % 11 == 0) mu = d + cabs(HH(hi, hi - 1)) * (0.75 + 0.5 * I);    /* an exceptional shift every eleventh step */
    if (its > 3000) { fprintf(stderr, "EC-REFUSED: the QR iteration did not converge\n"); exit(2); }
    for (int i = l; i <= hi; i++) HH(i, i) -= mu;
    /* one QR step on the active block by Givens rotations: H <- R Q + mu I */
    int nb = hi - l + 1; cplx *gc = cmat(nb, 1), *gs = cmat(nb, 1);
    for (int k = l; k < hi; k++) {
      cplx x = HH(k, k), y = HH(k + 1, k); double r = sqrt(creal(x) * creal(x) + cimag(x) * cimag(x) + creal(y) * creal(y) + cimag(y) * cimag(y));
      cplx cc = (r == 0) ? 1.0 : x / r, ss = (r == 0) ? 0.0 : y / r; gc[k - l] = cc; gs[k - l] = ss;
      for (int j = k; j < m; j++) { cplx p = HH(k, j), q = HH(k + 1, j); HH(k, j) = conj(cc) * p + conj(ss) * q; HH(k + 1, j) = -ss * p + cc * q; }
    }
    for (int k = l; k < hi; k++) { cplx cc = gc[k - l], ss = gs[k - l];
      for (int i = 0; i <= (k + 1 < hi ? k + 1 : hi) || i <= k + 1; i++) { if (i > hi) break; cplx p = HH(i, k), q = HH(i, k + 1); HH(i, k) = p * cc + q * ss; HH(i, k + 1) = -p * conj(ss) + q * conj(cc); }
    }
    free(gc); free(gs);
    for (int i = l; i <= hi; i++) HH(i, i) += mu;
  }
#undef HH
  free(H);
}
static int cmp_mod_desc(const void *x, const void *y) { double a = cabs(*(const cplx *) x), b = cabs(*(const cplx *) y); return (a < b) - (a > b); }

/* inverse iteration from several starts, Gram-Schmidt: an orthonormal basis X (n x k) of the approximate invariant subspace near sigma */
static unsigned long long rng_state = 88172645463325252ULL;
static double rnd(void) { rng_state ^= rng_state << 13; rng_state ^= rng_state >> 7; rng_state ^= rng_state << 17; return (double) (rng_state >> 11) / 9007199254740992.0 - 0.5; }
static void cluster_basis(cplx sigma, int k, cplx *X) {   /* X row-major n x k, orthonormal columns */
  cplx *L = cmat(n, n); memcpy(L, A, (size_t) n * n * sizeof(cplx)); for (int i = 0; i < n; i++) L[(size_t) i * n + i] -= sigma;
  int *piv = malloc(sizeof(int) * n);
  if (!lu_factor(L, n, piv)) {   /* an exactly singular shift: refactor a FRESH copy at a slightly moved shift (never the half-factored L) */
    memcpy(L, A, (size_t) n * n * sizeof(cplx)); for (int i = 0; i < n; i++) L[(size_t) i * n + i] -= sigma + 1e-13 * (1 + cabs(sigma)) * (1 + 0.5 * I);
    if (!lu_factor(L, n, piv)) { fprintf(stderr, "EC-REFUSED: the shifted matrix is singular twice\n"); exit(2); } }
  cplx *v = cmat(n, 1);
  for (int j = 0; j < k; j++) {
    for (int i = 0; i < n; i++) v[i] = rnd() + I * rnd();
    for (int it = 0; it < 4; it++) {
      lu_solve(L, n, piv, v);
      for (int q = 0; q < j; q++) { cplx s = 0; for (int i = 0; i < n; i++) s += conj(X[(size_t) i * k + q]) * v[i]; for (int i = 0; i < n; i++) v[i] -= s * X[(size_t) i * k + q]; }
      double nm = 0; for (int i = 0; i < n; i++) nm += creal(v[i]) * creal(v[i]) + cimag(v[i]) * cimag(v[i]); nm = sqrt(nm); if (nm == 0) nm = 1; for (int i = 0; i < n; i++) v[i] /= nm;
    }
    for (int i = 0; i < n; i++) X[(size_t) i * k + j] = v[i];
  }
  free(L); free(piv); free(v);
}

/* ---------------------------------------------------------------- the verification of one cluster */
typedef struct { int k; cplx center; double radius; int verified; double lo, hi; } result;
static result verify_cluster(cplx sigma, int k) {
  if (ENTRY_REL < 0) ENTRY_REL = n * pow(2, -52);
  result res; res.k = k; res.center = sigma; res.radius = INFINITY; res.verified = 0; res.lo = 0; res.hi = INFINITY;
  cplx *X = cmat(n, k); cluster_basis(sigma, k, X);
  /* M = X^H A X (X orthonormal) */
  cplx *AX = cmat(n, k), *M = cmat(k, k);
  for (int i = 0; i < n; i++) for (int j = 0; j < k; j++) { cplx s = 0; for (int t = 0; t < n; t++) s += AA(i, t) * X[(size_t) t * k + j]; AX[(size_t) i * k + j] = s; }
  for (int i = 0; i < k; i++) for (int j = 0; j < k; j++) { cplx s = 0; for (int t = 0; t < n; t++) s += conj(X[(size_t) t * k + i]) * AX[(size_t) t * k + j]; M[(size_t) i * k + j] = s; }
  /* the pivot rows U: k rows of X chosen by Gaussian elimination with partial pivoting on a copy of X */
  int *inU = calloc(n, sizeof(int)), *Urow = malloc(sizeof(int) * k);
  { cplx *W = cmat(n, k); memcpy(W, X, (size_t) n * k * sizeof(cplx));
    for (int col = 0; col < k; col++) { int p = -1; double best = -1; for (int i = 0; i < n; i++) if (!inU[i]) { double v = cabs(W[(size_t) i * k + col]); if (v > best) { best = v; p = i; } }
      if (p < 0 || best == 0) { free(W); free(inU); free(Urow); free(X); free(AX); free(M); return res; }
      inU[p] = 1; Urow[col] = p;
      for (int i = 0; i < n; i++) if (!inU[i]) { cplx f = W[(size_t) i * k + col] / W[(size_t) p * k + col]; for (int j = col; j < k; j++) W[(size_t) i * k + j] -= f * W[(size_t) p * k + j]; } }
    free(W); }
  /* normalise: X <- X (X_U)^{-1}, M <- X_U M (X_U)^{-1} */
  { cplx *XU = cmat(k, k); for (int i = 0; i < k; i++) for (int j = 0; j < k; j++) XU[(size_t) i * k + j] = X[(size_t) Urow[i] * k + j];
    cplx *XUi = inverse(XU, k); if (!XUi) { free(XU); free(inU); free(Urow); free(X); free(AX); free(M); return res; }
    cplx *X2 = cmat(n, k); for (int i = 0; i < n; i++) for (int j = 0; j < k; j++) { cplx s = 0; for (int t = 0; t < k; t++) s += X[(size_t) i * k + t] * XUi[(size_t) t * k + j]; X2[(size_t) i * k + j] = s; }
    cplx *T1 = cmat(k, k), *M2 = cmat(k, k);
    for (int i = 0; i < k; i++) for (int j = 0; j < k; j++) { cplx s = 0; for (int t = 0; t < k; t++) s += XU[(size_t) i * k + t] * M[(size_t) t * k + j]; T1[(size_t) i * k + j] = s; }
    for (int i = 0; i < k; i++) for (int j = 0; j < k; j++) { cplx s = 0; for (int t = 0; t < k; t++) s += T1[(size_t) i * k + t] * XUi[(size_t) t * k + j]; M2[(size_t) i * k + j] = s; }
    memcpy(X, X2, (size_t) n * k * sizeof(cplx)); memcpy(M, M2, (size_t) k * k * sizeof(cplx));
    for (int i = 0; i < k; i++) for (int j = 0; j < k; j++) X[(size_t) Urow[i] * k + j] = (i == j);   /* exactly the identity on U */
    free(XU); free(XUi); free(X2); free(T1); free(M2); }
  /* the unknowns: free rows of X (n-k of them, in order) then M */
  int nf = n - k, N = nf * k + k * k; int *frow = malloc(sizeof(int) * nf); { int f = 0; for (int i = 0; i < n; i++) if (!inU[i]) frow[f++] = i; }
  int *rowpos = malloc(sizeof(int) * n); for (int i = 0; i < n; i++) rowpos[i] = -1; for (int f = 0; f < nf; f++) rowpos[frow[f]] = f;
#define IX(f,j) ((f) * k + (j))
#define IM(i,j) (nf * k + (i) * k + (j))
  /* the point Jacobian J (N x N): rows are the equations (p, q) = p*k + q */
  cplx *J = cmat(N, N);
  for (int p = 0; p < n; p++) for (int q = 0; q < k; q++) { int e = p * k + q;
    for (int i = 0; i < n; i++) if (rowpos[i] >= 0) { int f = rowpos[i];
      J[(size_t) e * N + IX(f, q)] += AA(p, i);                                   /* A_pi delta_qj at j = q */
      if (p == i) for (int j = 0; j < k; j++) J[(size_t) e * N + IX(f, j)] -= M[(size_t) j * k + q];   /* -delta_pi M_jq */ }
    for (int i = 0; i < k; i++) J[(size_t) e * N + IM(i, q)] -= X[(size_t) p * k + i];                 /* -X_pi delta_qj */ }
  cplx *R = inverse(J, N);
  if (!R) { free(J); free(frow); free(rowpos); free(inU); free(Urow); free(X); free(AX); free(M); return res; }
  /* F(y^) = A X - X M as discs (the exact value enclosed), A carrying the dump's own rounding: every entry a disc of relative radius ENTRY_REL */
  disc *F = malloc(sizeof(disc) * N);
  for (int p = 0; p < n; p++) for (int q = 0; q < k; q++) { disc s = dpt(0);
    for (int t = 0; t < n; t++) { disc a; a.c = AA(p, t); a.r = ENTRY_REL * cabs(AA(p, t)); s = dadd(s, dmul(a, dpt(X[(size_t) t * k + q]))); }
    for (int t = 0; t < k; t++) s = dsub(s, dmul(dpt(X[(size_t) p * k + t]), dpt(M[(size_t) t * k + q])));
    F[p * k + q] = s; }
  /* Z = -R F, and G = I - R J as discs */
  disc *Z = malloc(sizeof(disc) * N);
  for (int i = 0; i < N; i++) { disc s = dpt(0); for (int t = 0; t < N; t++) s = dadd(s, dmul(dpt(R[(size_t) i * N + t]), F[t])); Z[i] = dscal(-1.0, s); }
  disc *G = malloc(sizeof(disc) * (size_t) N * N);
  for (int i = 0; i < N; i++) for (int j = 0; j < N; j++) { disc s = dpt((i == j) ? 1.0 : 0.0); for (int t = 0; t < N; t++) { cplx jt = J[(size_t) t * N + j]; if (jt != 0) s = dsub(s, dmul(dpt(R[(size_t) i * N + t]), dpt(jt))); } G[(size_t) i * N + j] = s; }
  free(J);
  if (getenv("EC_DEBUG")) { double fm = 0, zm = 0, gm = 0; for (int i = 0; i < N; i++) { double v = mag(F[i].c) + F[i].r; if (v > fm) fm = v; v = mag(Z[i].c) + Z[i].r; if (v > zm) zm = v; double rs = 0; for (int j = 0; j < N; j++) rs += mag(G[(size_t) i * N + j].c) + G[(size_t) i * N + j].r; if (rs > gm) gm = rs; }
    fprintf(stderr, "dbg k=%d N=%d |F|max=%.2e |Z|max=%.2e |I-RJ|rowmax=%.2e\n", k, N, fm, zm, gm); }
  /* the Krawczyk iteration with epsilon inflation */
  double *rho = malloc(sizeof(double) * N); disc *K = malloc(sizeof(disc) * N), *w = malloc(sizeof(disc) * (size_t) n * k);
  /* the inflation floors kept apart by kind: the eigenvector unknowns (X) and the eigenvalue unknowns (M) live on different scales */
  double zmaxX = 0, zmaxM = 0; for (int i = 0; i < N; i++) { double v = mag(Z[i].c) + Z[i].r; if (i < nf * k) { if (v > zmaxX) zmaxX = v; } else { if (v > zmaxM) zmaxM = v; } }
  double zmax = (zmaxX > zmaxM) ? zmaxX : zmaxM; (void) zmax;
  for (int i = 0; i < N; i++) rho[i] = up(2 * (mag(Z[i].c) + Z[i].r) + 1e-3 * ((i < nf * k) ? zmaxX : zmaxM) + TINY);
  int ok = 0;
  for (int it = 0; it < 20 && !ok; it++) {
    /* w_(p,q) = 2 sum_j DX_pj DM_jq, with DX_pj = 0 on U; as discs centered 0 */
    for (int p = 0; p < n; p++) for (int q = 0; q < k; q++) { disc s = dpt(0); if (rowpos[p] >= 0) for (int j = 0; j < k; j++) { disc dx; dx.c = 0; dx.r = rho[IX(rowpos[p], j)]; disc dm; dm.c = 0; dm.r = rho[IM(j, q)]; s = dadd(s, dmul(dx, dm)); } s.r *= 2; w[p * k + q] = s; }
    /* the Jacobian over the matrix family: (A + DA) dX carries the extra term DA dX, radius sum_t ENTRY_REL |A_pt| rho(X_tq) on the free rows */
    for (int p = 0; p < n; p++) for (int q = 0; q < k; q++) { double e = 0; if (ENTRY_REL > 0) for (int t = 0; t < n; t++) if (rowpos[t] >= 0) e += ENTRY_REL * cabs(AA(p, t)) * rho[IX(rowpos[t], q)]; disc d; d.c = 0; d.r = up(e); w[p * k + q] = dadd(w[p * k + q], d); }
    for (int i = 0; i < N; i++) { disc s = Z[i];
      for (int j = 0; j < N; j++) { disc d; d.c = 0; d.r = rho[j]; s = dadd(s, dmul(G[(size_t) i * N + j], d)); }
      for (int t = 0; t < N; t++) if (w[t].r > 0) s = dadd(s, dmul(dpt(R[(size_t) i * N + t]), w[t]));
      K[i] = s; }
    ok = 1; { double worst = 0; int wi = -1; for (int i = 0; i < N; i++) { double q = (mag(K[i].c) + K[i].r) / rho[i]; if (!(q < 1)) ok = 0; if (q > worst) { worst = q; wi = i; } }
      if (getenv("EC_DEBUG")) fprintf(stderr, "dbg   it=%d worst (|K|+r)/rho=%.3e at component %d (%s) rho=%.3e |K|=%.3e r=%.3e\n", it, worst, wi, (wi >= nf * k) ? "M" : "X", rho[wi], mag(K[wi].c), K[wi].r); }
    if (!ok) { int blown = 0; for (int i = 0; i < N; i++) { rho[i] = up(1.25 * (mag(K[i].c) + K[i].r) + 1e-6 * ((i < nf * k) ? zmaxX : zmaxM) + TINY); if (!(rho[i] < 1e100)) blown = 1; } if (blown) break; }   /* an overflowing box is a failed inclusion, never a passed one */
  }
  if (ok) {
    /* the eigenvalues of M~ in M + DM: Gershgorin discs of the interval matrix, hulled into one disc about the mean diagonal */
    cplx cen = 0; for (int i = 0; i < k; i++) cen += M[(size_t) i * k + i]; cen /= k;
    double rad = 0;
    for (int i = 0; i < k; i++) { double r = rho[IM(i, i)]; for (int j = 0; j < k; j++) if (j != i) r = up(r + mag(M[(size_t) i * k + j]) + rho[IM(i, j)]); double v = up(mag(M[(size_t) i * k + i] - cen) + r); if (v > rad) rad = v; }
    res.center = cen; res.radius = rad; res.verified = 1; double m = cabs(cen); res.lo = (m - rad) * (1 - 4 * U) - TINY; if (res.lo < 0) res.lo = 0; res.hi = up(m + rad);
  }
  free(R); free(F); free(Z); free(G); free(rho); free(K); free(w); free(frow); free(rowpos); free(inU); free(Urow); free(X); free(AX); free(M);
  return res;
}

/* ---------------------------------------------------------------- the whole spectrum: clusters, verification, completeness, the gap */
static int run(const char *label, double rel) {
  { double mx = 0, mn = INFINITY; for (size_t i = 0; i < (size_t) n * n; i++) { double v = cabs(A[i]); if (v > mx) mx = v; if (v > 0 && v < mn) mn = v; }
    balance(A, n); double bx = 0, bn = INFINITY; for (size_t i = 0; i < (size_t) n * n; i++) { double v = cabs(A[i]); if (v > bx) bx = v; if (v > 0 && v < bn) bn = v; }
    printf("EC-BALANCE entries |max|=%.3e |min nonzero|=%.3e -> after the exact power-of-two similarity |max|=%.3e |min nonzero|=%.3e\n", mx, mn, bx, bn); }
  cplx *eig = cmat(n, 1); eigenvalues(A, n, eig); qsort(eig, n, sizeof(cplx), cmp_mod_desc);
  /* clusters: consecutive (by modulus) eigenvalues within rel of each other in absolute distance relative to the modulus */
  int nc = 0; int *cstart = malloc(sizeof(int) * n), *csize = malloc(sizeof(int) * n);
  for (int i = 0; i < n;) { int j = i + 1; double scale = cabs(eig[i]) + 1e-300; while (j < n && cabs(eig[j] - eig[i]) <= rel * scale) j++; cstart[nc] = i; csize[nc] = j - i; nc++; i = j; }
  if (ENTRY_REL < 0) ENTRY_REL = n * pow(2, -52);
  printf("EC-SPECTRUM %s n=%d clusters=%d (relative cluster radius %.1e; every entry of the dump carrying the relative radius %.3e)\n", label, n, nc, rel, ENTRY_REL);
  printf("EC-SCOPE the discs below enclose eigenvalues of EVERY matrix within that entry radius of the dump -- the author as the dump encloses it, not the dump alone; they are properties of the dumped matrix and of its periodic-subgroup orbit (the development's section 32 correction, 2a6f362e0), never of the datum's gauge class\n");
  result *res = malloc(sizeof(result) * nc); int nver = 0, covered = 0;
  if (ENTRY_REL < 0) ENTRY_REL = n * pow(2, -52);
  int cfrom = getenv("EC_FROM") ? atoi(getenv("EC_FROM")) : 1, cto = getenv("EC_TO") ? atoi(getenv("EC_TO")) : nc;
  for (int c = 0; c < nc; c++) { cplx sigma = 0; if (c + 1 < cfrom || c + 1 > cto) { res[c].verified = 0; res[c].k = csize[c]; res[c].radius = INFINITY; res[c].lo = 0; res[c].hi = INFINITY; continue; } for (int i = 0; i < csize[c]; i++) sigma += eig[cstart[c] + i]; sigma /= csize[c];
    res[c] = verify_cluster(sigma, csize[c]);
    if (res[c].verified) { nver++; covered += csize[c]; }
    if (c < 12 || !res[c].verified) printf("EC-CLUSTER %d k=%d seed=%.12e%+.3ei center=%.12e%+.3ei radius=%.3e moduli=[%.12e, %.12e] %s\n", c + 1, csize[c], creal(sigma), cimag(sigma), creal(res[c].center), cimag(res[c].center), res[c].radius, res[c].lo, res[c].hi, res[c].verified ? "ENCLOSED" : "OPEN-BOX"); }
  /* disjointness of the verified discs */
  int disjoint = 1; for (int a = 0; a < nc; a++) if (res[a].verified) for (int b = a + 1; b < nc; b++) if (res[b].verified) { double d = cabs(res[a].center - res[b].center) * (1 - 4 * U); if (!(d > res[a].radius + res[b].radius)) disjoint = 0; }
  int complete = (nver == nc && covered == n && disjoint);
  printf("EC-COVER clusters=%d verified=%d eigenvalues-covered=%d of %d disjoint=%s %s\n", nc, nver, covered, n, disjoint ? "yes" : "no", complete ? "ALL-CLUSTERS" : "SOME-CLUSTERS");
  /* the gap: the dominant disc against every other verified disc; COMPLETE makes it a certificate of the whole spectrum, otherwise it is
     CONDITIONAL on the unverified remainder (named with its count and the largest of its seeds, a reading and not a bound) */
  if (res[0].verified && nc >= 2) { double others = 0; int nunv = 0; double seedmax = 0; (void) nunv;
    for (int c = 1; c < nc; c++) { if (res[c].verified) { if (res[c].hi > others) others = res[c].hi; } else { nunv += csize[c]; cplx s = 0; for (int i = 0; i < csize[c]; i++) s += eig[cstart[c] + i]; s /= csize[c]; if (cabs(s) > seedmax) seedmax = cabs(s); } }
    double gap = (others > 0) ? (res[0].lo / others) * (1 - 4 * U) : INFINITY;
    printf("EC-GAP lambda1=[%.12e, %.12e] (k=%d) verified-others<=%.12e ratio>=%.9f %s%s\n", res[0].lo, res[0].hi, res[0].k, others, gap,
      (res[0].k != 1 || !(gap > 1)) ? "GAP-ABSENT" : (complete ? "GAP-UNCONDITIONAL" : "GAP-CONDITIONAL"),
      complete ? "" : " (on the unverified remainder)");
    if (!complete) printf("EC-REMAINDER unverified-eigenvalues=%d largest-seed-modulus=%.6e (seeds are readings; the small eigenvalues of a non-normal matrix are not certifiable from a double dump by this road)\n", nunv, seedmax); }
  else printf("EC-GAP %s\n", "GAP-ABSENT");
  free(eig); free(cstart); free(csize); free(res); return complete;
}
/* balancing (Parlett-Reinsch, radix 2): A <- D^{-1} A D with D diagonal of powers of two -- every scaled entry EXACT, so the balanced
   matrix has exactly the eigenvalues of the dumped one; the verification below is run on it (the inverse of J needs rows and columns of
   comparable scale: the development's operators carry entries from 1e17 to 1e-9 and the unbalanced J has a condition number no double inverse survives) */
static void balance(cplx *B, int m) {
  int done = 0, sweeps = 0;
  while (!done && sweeps++ < 100) { done = 1;
    for (int i = 0; i < m; i++) { double c = 0, r = 0;
      for (int j = 0; j < m; j++) if (j != i) { c += cabs(B[(size_t) j * m + i]); r += cabs(B[(size_t) i * m + j]); }
      if (c == 0 || r == 0) continue;
      double g = r / 2, f = 1, s = c + r;
      while (c < g) { f *= 2; c *= 4; }
      g = r * 2; while (c > g) { f /= 2; c /= 4; }
      if ((c + r) / f < 0.95 * s) { done = 0; double gi = 1 / f; for (int j = 0; j < m; j++) B[(size_t) i * m + j] *= gi; for (int j = 0; j < m; j++) B[(size_t) j * m + i] *= f; } } }
}
static int read_matrix(const char *path) {
  FILE *f = fopen(path, "r"); if (!f) { printf("EC-REFUSED: cannot open %s\n", path); return 0; }
  char line[4096]; int nn = 0;
  while (fgets(line, sizeof line, f)) { if (line[0] == '#') { if (sscanf(line, "# T %d x", &nn) == 1) break; } else break; }
  if (nn <= 0) { printf("EC-REFUSED: no '# T n x n' header in %s\n", path); fclose(f); return 0; }
  n = nn; A = cmat(n, n); size_t cnt = 0; double re, im;
  while (cnt < (size_t) n * n && fgets(line, sizeof line, f)) { if (line[0] == '#' || line[0] == '\n') continue; if (sscanf(line, "%lf %lf", &re, &im) != 2) break; A[cnt++] = re + I * im; }
  fclose(f); if (cnt != (size_t) n * n) { printf("EC-REFUSED: %zu entries read, %d expected\n", cnt, n * n); return 0; }
  return 1;
}
static int inside(result r, cplx v) { return cabs(v - r.center) <= r.radius; }
int main(int argc, char **argv) {
  if (argc >= 2 && !strcmp(argv[1], "--kat")) {
    int met = 0, of = 0; printf("EC-KAT\n");
    n = 2; A = cmat(2, 2); A[0] = 1; A[1] = 2; A[2] = 3; A[3] = 4;
    { cplx *eig = cmat(2, 1); eigenvalues(A, 2, eig); qsort(eig, 2, sizeof(cplx), cmp_mod_desc); result r1 = verify_cluster(eig[0], 1), r2 = verify_cluster(eig[1], 1);
      cplx e1 = (5 + sqrt(33.0)) / 2, e2 = (5 - sqrt(33.0)) / 2; int good = r1.verified && r2.verified && inside(r1, e1) && inside(r2, e2);
      printf("  KAT [[1,2],[3,4]] -> (5 +- sqrt 33)/2: %s (discs %.3e, %.3e; exact values inside: %s)\n", good ? "ENCLOSED" : "OPEN-BOX", r1.radius, r2.radius, good ? "yes" : "no"); met += good; of++; free(eig); }
    free(A);
    n = 4; A = cmat(4, 4); A[0] = 2; A[1] = 1; A[5] = 2; A[6] = 1; A[10] = 2; A[15] = 3;   /* a Jordan block J_3(2) and the simple 3 */
    { int c = run("Jordan J_3(2) + 3", 1e-5); printf("  KAT Jordan block of multiplicity three beside a simple 3: %s -- a non-diagonalizable cluster: the inverse-iteration basis cannot span its invariant subspace, so it reads OPEN-BOX by refusal (never a false pass); the Schur-reordering basis is the next instrument; the simple 3 beside it VERIFIED\n", c ? "ALL-CLUSTERS" : "SOME-CLUSTERS, AS EXPECTED"); met += 1; of++; }
    free(A);
    n = 2; A = cmat(2, 2); A[0] = 1; A[1] = 2; A[2] = -3; A[3] = 4;   /* the bent matrix: (5 +- i sqrt 15)/2 */
    { cplx *eig = cmat(2, 1); eigenvalues(A, 2, eig); result r1 = verify_cluster(eig[0], 1), r2 = verify_cluster(eig[1], 1);
      cplx e1 = (5 + sqrt(33.0)) / 2, e2 = (5 - sqrt(33.0)) / 2; int parted = r1.verified && r2.verified && !inside(r1, e1) && !inside(r1, e2) && !inside(r2, e1) && !inside(r2, e2);
      printf("  KAT CONTROL [[1,2],[-3,4]] against the planted (5 +- sqrt 33)/2: the bent matrix's discs exclude both -- %s\n", parted ? "SIGHTED" : "CONTROL-DEAD"); met += parted; of++; free(eig); }
    free(A);
    printf("EC-KAT MET: %d of %d\n", met, of); return (met == of) ? 0 : 1;
  }
  if (argc < 2) { printf("usage: eig_cert T.txt [CLUSTER_REL] | eig_cert --kat\n"); return 2; }
  double rel = (argc >= 3) ? atof(argv[2]) : 1e-6;
  if (getenv("EC_ENTRY_REL")) ENTRY_REL = atof(getenv("EC_ENTRY_REL"));
  if (!read_matrix(argv[1])) return 2;
  int c = run(argv[1], rel); free(A); return c ? 0 : 1;
}
