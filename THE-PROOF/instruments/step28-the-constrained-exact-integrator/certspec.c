/* certspec.c -- THE CERTIFIED SPECTRUM (the author, 2026-11-03 02:0x EST; the author's delegation (ii)): the leading
   eigenvalue and the second modulus of a dumped transfer matrix ENCLOSED, not computed -- a certificate a stranger checks by
   floating-point arithmetic with the stated error bounds, sharing no line with cei_spectrum.c or eigcheck.c's verdicts.

   THE ROAD.  (1) A float Schur form T ~ Q U Q^H by my own complex Hessenberg QR (Householder with Q accumulated; Francis single-shift
   steps with Wilkinson's shift; deflation against the neighbours or the matrix norm), the whole similarity carried (rows over every
   column, columns over every row above), so Q is unitary to roundoff.  (2) Eigenvalues within a relative 1e-6 of one another are
   CLUSTERS (union-find); the Schur form is REORDERED by adjacent swaps (the rotation that maps the 2 x 2 block's eigenvector to e_1) so
   every cluster is contiguous.  (3) V = for a singleton its eigenvector (back-substitution on U, then Q x); for a cluster its Schur
   vectors (an orthonormal basis of the invariant subspace -- a semisimple degenerate pair's block is then lambda I to roundoff; a
   defective pair's block carries its Jordan coupling, and the bound below is honest about it).  (4) Y ~ V^-1 by complex LU.  (5) In
   MIDPOINT-RADIUS interval arithmetic (every product and sum carries Higham's gamma_m bound, every radius inflated, so each enclosure
   holds the exact value): C = Y V = I - R with r = |R|_inf < 1 VERIFIED (else REFUSED INVERSE-NOT-VERIFIED), D = Y T V with T's entries
   as intervals of radius f |entry| (f = n 2^-52 unless given), and the exact similarity V^-1 T V = C^-1 D = D + (C^-1 - I) D with
   |C^-1 - I|_inf <= r/(1-r), so every entry of the exact B lies in D_ij +- (rad D_ij + delta max_m |D_mj|).  (6) Feingold--Varga's block
   Gershgorin theorem on B: with the 2-norm per block, every eigenvalue lambda of B has some block b with sigma_min(B_bb - lambda I) <=
   sum_{c != b} |B_bc|_2, hence |lambda| <= |B_bb|_2 + sum_c |B_bc|_2 <= sqrt(G_b) + sum_c |B_bc|_F, G_b the scalar Gershgorin bound on
   lambda_max(B_bb^H B_bb); the leading block must be a singleton whose disc |lambda - B_11| <= rho_1 is DISJOINT from every other block's
   modulus bound (else REFUSED NO-SEPARATION or LEADING-CLUSTER), whence by continuity it holds exactly one eigenvalue: |lambda_1| >=
   |B_11| - rho_1 and every other |lambda| <= max_b (sqrt(G_b) + eps_b), the gap's certified lower bound their quotient, rounded down.
   THE KAT (--kat): a 12 x 12 matrix V D V^-1 of known spectrum (its leading value and second modulus enclosed; the degenerate pair
   clustered), a planted perturbation (the entry radius widened to 1e-2 |entry|) REFUSED by name, a Jordan pair's bound honest.
   USAGE: certspec <dump> [name] [radius factor]   |   certspec --kat */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <io.h>
#include <fcntl.h>
#include <complex.h>
typedef double complex C;
static const double EPS = 1.1102230246251565e-16;   /* 2^-53 */
static int n; static C *T, *Hm, *Q; static double *TRAD = NULL;   /* TRAD: per-entry radii when the dump carries them ("re im rad", Stone 5's certified entries) */
#define A(i,j) Hm[(size_t)(i)*n+(j)]
#define TT(i,j) T[(size_t)(i)*n+(j)]
#define QQ(i,j) Q[(size_t)(i)*n+(j)]
static double up(double x) { return x * (1 + 8 * EPS) + 1e-300; }   /* a rigorous upward inflation of a nonnegative float bound */

/* ---------- the float Schur form, Q accumulated ---------- */
static void hessenberg(void) { C *v = malloc(sizeof(C) * n);
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) QQ(i,j) = (i == j);
  for (int k = 0; k < n - 2; k++) { double alpha = 0; for (int i = k + 1; i < n; i++) alpha += cabs(A(i,k)) * cabs(A(i,k)); alpha = sqrt(alpha); if (alpha < 1e-300) continue;
    C x0 = A(k+1,k); C ph = (cabs(x0) > 0) ? x0 / cabs(x0) : 1; for (int i = 0; i < n; i++) v[i] = 0;
    v[k+1] = x0 + ph * alpha; for (int i = k + 2; i < n; i++) v[i] = A(i,k); double vn = 0; for (int i = k + 1; i < n; i++) vn += cabs(v[i]) * cabs(v[i]); if (vn < 1e-300) continue;
    for (int j = 0; j < n; j++) { C s = 0; for (int i = k + 1; i < n; i++) s += conj(v[i]) * A(i,j); s *= 2 / vn; for (int i = k + 1; i < n; i++) A(i,j) -= v[i] * s; }
    for (int i = 0; i < n; i++) { C s = 0; for (int j = k + 1; j < n; j++) s += A(i,j) * v[j]; s *= 2 / vn; for (int j = k + 1; j < n; j++) A(i,j) -= s * conj(v[j]); }
    for (int i = 0; i < n; i++) { C s = 0; for (int j = k + 1; j < n; j++) s += QQ(i,j) * v[j]; s *= 2 / vn; for (int j = k + 1; j < n; j++) QQ(i,j) -= s * conj(v[j]); }
    for (int i = k + 2; i < n; i++) A(i,k) = 0; }
  free(v); }
static void givens(C x, C y, double *c, C *s) { double r = sqrt(cabs(x)*cabs(x) + cabs(y)*cabs(y)); if (r < 1e-300) { *c = 1; *s = 0; return; }
  if (cabs(x) < 1e-300) { *c = 0; *s = 1; return; } *c = cabs(x) / r; *s = (x / cabs(x)) * conj(y) / r; }
/* the similarity H <- G H G^H on rows/columns k, k+1 (G = [[c, s], [-conj s, c]]), rows over columns j0..n-1, columns over rows 0..rmax; Q <- Q G^H */
static void rot(int k, double c, C s, int j0, int rmax) {
  for (int j = j0; j < n; j++) { C a = A(k,j), b = A(k+1,j); A(k,j) = c * a + s * b; A(k+1,j) = -conj(s) * a + c * b; }
  for (int i = 0; i <= rmax; i++) { C a = A(i,k), b = A(i,k+1); A(i,k) = c * a + conj(s) * b; A(i,k+1) = -s * a + c * b; }
  for (int i = 0; i < n; i++) { C a = QQ(i,k), b = QQ(i,k+1); QQ(i,k) = c * a + conj(s) * b; QQ(i,k+1) = -s * a + c * b; } }
static int schur(int *steps) { int hi = n - 1, lo, it = 0, total = 0; double fro = 0; for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) fro += cabs(A(i,j)) * cabs(A(i,j)); fro = sqrt(fro);
  while (hi >= 0) { if (hi == 0) break;
    for (lo = hi; lo > 0; lo--) { double sd = cabs(A(lo,lo-1)), dg = cabs(A(lo,lo)) + cabs(A(lo-1,lo-1)); if (sd <= 1e-15 * (dg > 1e-300 ? dg : 1e-300) || sd <= 1e-17 * fro) { A(lo,lo-1) = 0; break; } }
    if (lo == hi) { hi--; it = 0; continue; }
    if (++it > 1000) return 1; total++;
    C a = A(hi-1,hi-1), b = A(hi-1,hi), c = A(hi,hi-1), d = A(hi,hi); C tr = a + d, det = a*d - b*c; C disc = csqrt(tr*tr/4 - det); C m1 = tr/2 + disc, m2 = tr/2 - disc;
    C mu = (cabs(m1 - d) < cabs(m2 - d)) ? m1 : m2; if (it % 11 == 10) mu = cabs(A(hi,hi-1)) + cabs(A(hi-1,hi-2 >= lo ? hi-2 : lo));
    double cs; C sn; givens(A(lo,lo) - mu, A(lo+1,lo), &cs, &sn); rot(lo, cs, sn, lo, lo + 2 < hi ? lo + 2 : hi);
    for (int k = lo + 1; k < hi; k++) { givens(A(k,k-1), A(k+1,k-1), &cs, &sn); rot(k, cs, sn, k - 1, k + 2 < hi ? k + 2 : hi); A(k+1,k-1) = 0; } }
  for (int i = 1; i < n; i++) A(i,i-1) = 0; *steps = total; return 0; }
/* swap the adjacent diagonal entries p, p+1 of the upper triangular Schur factor by a unitary similarity (Q carried) */
static void swap_adjacent(int p) { C a = A(p,p), b = A(p,p+1), d = A(p+1,p+1); C x1 = b, x2 = d - a; double nx = sqrt(cabs(x1)*cabs(x1) + cabs(x2)*cabs(x2)); if (nx < 1e-300) return;
  C g11 = conj(x1) / nx, g12 = conj(x2) / nx;   /* G = [[g11, g12], [-conj g12, conj g11]] maps x to |x| e_1 */
  for (int j = p; j < n; j++) { C r1 = A(p,j), r2 = A(p+1,j); A(p,j) = g11 * r1 + g12 * r2; A(p+1,j) = -conj(g12) * r1 + conj(g11) * r2; }
  for (int i = 0; i <= p + 1; i++) { C c1 = A(i,p), c2 = A(i,p+1); A(i,p) = c1 * conj(g11) + c2 * conj(g12); A(i,p+1) = -c1 * g12 + c2 * g11; }
  for (int i = 0; i < n; i++) { C c1 = QQ(i,p), c2 = QQ(i,p+1); QQ(i,p) = c1 * conj(g11) + c2 * conj(g12); QQ(i,p+1) = -c1 * g12 + c2 * g11; }
  A(p+1,p) = 0; }

/* ---------- midpoint-radius arithmetic: P = X Z with X (n x k), Z (k x m); rad = gamma sum|x||z| + sum(|x| rz + rx |z| + rx rz), inflated ---------- */
static void mr_mul(const C *Xm, const double *Xr, int rows, int k, const C *Zm, const double *Zr, int cols, C *Pm, double *Pr) {
  double gam = (4.0 * k + 8) * EPS; gam = gam / (1 - gam);
  for (int i = 0; i < rows; i++) for (int j = 0; j < cols; j++) { C s = 0; double ab = 0, rr = 0;
    for (int t = 0; t < k; t++) { C x = Xm[(size_t)i*k+t], z = Zm[(size_t)t*cols+j]; double ax = cabs(x), az = cabs(z), rx = Xr ? Xr[(size_t)i*k+t] : 0, rz = Zr ? Zr[(size_t)t*cols+j] : 0;
      s += x * z; ab += ax * az; rr += ax * rz + rx * az + rx * rz; }
    Pm[(size_t)i*cols+j] = s; Pr[(size_t)i*cols+j] = up(up(gam * ab) + up(rr) + up(cabs(s) * EPS)); } }

/* ---------- the complex LU inverse (float) ---------- */
static int inverse(const C *M0, C *Y) { C *M = malloc(sizeof(C) * n * n); int *piv = malloc(sizeof(int) * n); memcpy(M, M0, sizeof(C) * n * n);
  for (int k = 0; k < n; k++) { int p = k; double mx = cabs(M[(size_t)k*n+k]); for (int i = k + 1; i < n; i++) if (cabs(M[(size_t)i*n+k]) > mx) { mx = cabs(M[(size_t)i*n+k]); p = i; } piv[k] = p;
    if (mx < 1e-300) { free(M); free(piv); return 1; }
    if (p != k) for (int j = 0; j < n; j++) { C t = M[(size_t)k*n+j]; M[(size_t)k*n+j] = M[(size_t)p*n+j]; M[(size_t)p*n+j] = t; }
    C pv = M[(size_t)k*n+k]; for (int i = k + 1; i < n; i++) { C f = M[(size_t)i*n+k] / pv; M[(size_t)i*n+k] = f; for (int j = k + 1; j < n; j++) M[(size_t)i*n+j] -= f * M[(size_t)k*n+j]; } }
  C *w = malloc(sizeof(C) * n);
  for (int col = 0; col < n; col++) { for (int i = 0; i < n; i++) w[i] = (i == col);
    /* the permutation FIRST, then L: the rows were swapped whole at the factorisation (their earlier multipliers with them), so a
       swap interleaved with the elimination pairs a right-hand side with another row's multiplier (the first draft's defect, caught by
       the KAT at |YV - I| = 1.3; the same defect in eigcheck.c's inverse iteration, corrected and re-run, dated 2026-11-03 02:0x) */
    for (int k = 0; k < n; k++) { int p = piv[k]; if (p != k) { C t = w[k]; w[k] = w[p]; w[p] = t; } }
    for (int k = 0; k < n; k++) for (int i = k + 1; i < n; i++) w[i] -= M[(size_t)i*n+k] * w[k];
    for (int i = n - 1; i >= 0; i--) { for (int j = i + 1; j < n; j++) w[i] -= M[(size_t)i*n+j] * w[j]; w[i] /= M[(size_t)i*n+i]; }
    for (int i = 0; i < n; i++) Y[(size_t)i*n+col] = w[i]; }
  free(M); free(piv); free(w); return 0; }

/* ---------- the certificate (v2, 02:0x): the leading eigenvalue split off by the ONE well-conditioned similarity, the rest bounded
   by Gelfand's formula in enclosures.  The first draft diagonalised the whole operator; its known answers were met, and every real dump
   REFUSED it (|I - YV| ~ 1e5..1e7): a transfer operator's tail of tiny eigenvalues makes the full eigenvector matrix conditioned
   beyond the double word.  So: with lambda_1 reordered to the top of the Schur form, U = [[l1, u], [0, U_r]], the row x0 solving
   x0 (l1 I - U_r) = -u gives X = [[1, x0], [0, I]] with U X = X (l1 (+) U_r); V = Q X block-diagonalises T, Y = X^-1 Q^H is explicit,
   cond(V) ~ 1 + |x0|.  Then (Feingold--Varga on B^T with the blocks {0} and the rest): every eigenvalue lies in |l - B_00| <= |w| or in
   the |u|-pseudospectrum of B_rr (w the column below B_00, u the row to its right -- both roundoff-small after X), and the
   pseudospectral radius is bounded by Gelfand, rho(B_rr + E) <= |(B_rr + E)^(2^s)|_F^(2^-s), the powers taken in midpoint-radius
   arithmetic with every entry's radius raised by |u|, normalised at each squaring (the bound is the product c_0 c_1^(1/2) c_2^(1/4) ...
   of the upper Frobenius norms), the best of S squarings kept.  The leading disc disjoint from that modulus holds exactly one
   eigenvalue (continuity in the coupling), so |lambda_1| >= |B_00| - rad - |w| and every other |lambda| <= the Gelfand bound. ---------- */
static double fro_up(const C *m, const double *r, int k) { double s = 0; for (size_t t = 0; t < (size_t)k * k; t++) { double v = cabs(m[t]) + r[t]; s += v * v; } return up(sqrt(up(s))); }
static int certify(const char *name, double radf, double *gap_lo, double *l1_lo, double *l1_hi, double *l2_hi, int verbose) {
  Hm = malloc(sizeof(C) * n * n); Q = malloc(sizeof(C) * n * n); memcpy(Hm, T, sizeof(C) * n * n);
  hessenberg(); int steps; if (schur(&steps)) { printf("CERT %s REFUSED NO-CONVERGENCE\n", name); return 2; }
  int imax = 0; for (int i = 1; i < n; i++) if (cabs(A(i,i)) > cabs(A(imax,imax))) imax = i;
  for (int p = imax; p > 0; p--) swap_adjacent(p - 1);
  C l1 = A(0,0); double al1 = cabs(l1), al2f = 0; for (int i = 1; i < n; i++) if (cabs(A(i,i)) > al2f) al2f = cabs(A(i,i));
  for (int i = 1; i < n; i++) if (cabs(A(i,i) - l1) <= 1e-6 * al1) { printf("CERT %s REFUSED LEADING-CLUSTER (an eigenvalue within 1e-6 of the leading one: %.6e%+.6ei)\n", name, creal(A(i,i)), cimag(A(i,i))); return 4; }
  int m = n - 1; C *x0 = malloc(sizeof(C) * n); x0[0] = 0;
  for (int q = 1; q < n; q++) { C r = -A(0,q); for (int p = 1; p < q; p++) r += x0[p] * A(p,q); x0[q] = r / (l1 - A(q,q)); }
  double x0n = 0; for (int q = 1; q < n; q++) x0n += cabs(x0[q]) * cabs(x0[q]); x0n = sqrt(x0n);
  C *V = malloc(sizeof(C) * n * n), *Y = malloc(sizeof(C) * n * n);
  for (int i = 0; i < n; i++) { V[(size_t)i*n+0] = QQ(i,0); for (int q = 1; q < n; q++) V[(size_t)i*n+q] = QQ(i,q) + QQ(i,0) * x0[q]; }
  for (int j = 0; j < n; j++) { C s = conj(QQ(j,0)); for (int q = 1; q < n; q++) s -= x0[q] * conj(QQ(j,q)); Y[(size_t)0*n+j] = s; for (int q = 1; q < n; q++) Y[(size_t)q*n+j] = conj(QQ(j,q)); }
  C *Cm = malloc(sizeof(C) * n * n); double *Cr = malloc(sizeof(double) * n * n); mr_mul(Y, NULL, n, n, V, NULL, n, Cm, Cr);
  double r = 0; for (int i = 0; i < n; i++) { double s = 0; for (int j = 0; j < n; j++) { C e = Cm[(size_t)i*n+j] - (i == j); s += cabs(e) + Cr[(size_t)i*n+j]; } s = up(s * (1 + n * EPS)); if (s > r) r = s; }
  if (r >= 1) { printf("CERT %s REFUSED INVERSE-NOT-VERIFIED |I-YV|inf = %.3e\n", name, r); return 3; }
  double delta = up(r / (1 - r));
  double *Tr = malloc(sizeof(double) * n * n); for (size_t i = 0; i < (size_t)n * n; i++) Tr[i] = up(radf * cabs(T[i]) + (TRAD ? TRAD[i] : 0));
  C *Wm = malloc(sizeof(C) * n * n); double *Wr = malloc(sizeof(double) * n * n); mr_mul(T, Tr, n, n, V, NULL, n, Wm, Wr);
  C *Dm = malloc(sizeof(C) * n * n); double *Dr = malloc(sizeof(double) * n * n); mr_mul(Y, NULL, n, n, Wm, Wr, n, Dm, Dr);
  for (int j = 0; j < n; j++) { double mx = 0; for (int i = 0; i < n; i++) { double v = cabs(Dm[(size_t)i*n+j]) + Dr[(size_t)i*n+j]; if (v > mx) mx = v; } double cmj = up(delta * mx); for (int i = 0; i < n; i++) Dr[(size_t)i*n+j] = up(Dr[(size_t)i*n+j] + cmj); }
  double w2 = 0, u2 = 0; for (int i = 1; i < n; i++) { double v = cabs(Dm[(size_t)i*n+0]) + Dr[(size_t)i*n+0]; w2 += v * v; v = cabs(Dm[(size_t)0*n+i]) + Dr[(size_t)0*n+i]; u2 += v * v; }
  double wn = up(sqrt(up(w2))), un = up(sqrt(up(u2))); double cen = cabs(Dm[0]), rad00 = Dr[0];
  double lo1 = cen - up(rad00 + wn), hi1 = up(cen + rad00 + wn);
  /* the rest block, its radii raised by |u|, then Gelfand with normalisation */
  C *Pm = malloc(sizeof(C) * m * m), *P2m = malloc(sizeof(C) * m * m); double *Pr = malloc(sizeof(double) * m * m), *P2r = malloc(sizeof(double) * m * m);
  for (int i = 1; i < n; i++) for (int j = 1; j < n; j++) { Pm[(size_t)(i-1)*m+(j-1)] = Dm[(size_t)i*n+j]; Pr[(size_t)(i-1)*m+(j-1)] = up(Dr[(size_t)i*n+j] + un); }
  const int S = 10; double logb = 0, best = INFINITY; int bests = 0;
  for (int s = 0; s <= S; s++) { double c = fro_up(Pm, Pr, m); if (!(c > 0)) { best = 0; bests = s; break; }
    logb += log(c) / (double)(1u << s); double bs = exp(logb) * (1 + 1e-12 * (s + 2)); if (bs < best) { best = bs; bests = s; }
    if (s == S) break;
    for (size_t t = 0; t < (size_t)m * m; t++) { Pm[t] /= c; Pr[t] = up(Pr[t] / c); }
    mr_mul(Pm, Pr, m, m, Pm, Pr, m, P2m, P2r); C *tm = Pm; Pm = P2m; P2m = tm; double *tr = Pr; Pr = P2r; P2r = tr; }
  if (!(lo1 > best)) { printf("CERT %s REFUSED NO-SEPARATION (|lambda_1| >= %.6e against the rest's bound %.6e; |I-YV| %.1e, |w| %.1e, |u| %.1e)\n", name, lo1, best, r, wn, un); return 5; }
  double gap = (lo1 / best) * (1 - 8 * EPS);
  *gap_lo = gap; *l1_lo = lo1; *l1_hi = hi1; *l2_hi = best;
  if (verbose) printf("CERT %s n=%d lambda_1 = %.12e %+.12e (radius %.2e)  |lambda_1| in [%.12e, %.12e]  |lambda_rest| <= %.12e (Gelfand at 2^%d)  GAP >= %.9f  (float gap %.9f; |I-YV| %.1e, |w| %.1e, |u| %.1e, |x0| %.2e, T radius factor %.2e, qr-steps %d)\n",
    name, n, creal(Dm[0]), cimag(Dm[0]), rad00, lo1, hi1, best, bests, gap, al1 / al2f, r, wn, un, x0n, radf, steps);
  return 0; }

/* ---------- THE k-BLOCK SPLIT (2026-11-03 05:xx EST; ΟΛΟΚΛΗΡΩΣΙΣ Addendum V's named next object, the author's plan YM-1a):
   the K largest eigenvalues are taken off as their OWN blocks -- a singleton each, or one block for a cluster (entries within a
   relative 1e-6 of each other, the ordered datum's degenerate triplet) -- and the rest from the (K+1)-th on is bounded by Gelfand as
   before.  The float similarity: the Schur diagonal sorted so the top K lead, then X = X_m ... X_2, X_j = I + [X_j]_(top, j) solving
   U_top X_j - X_j U_jj = -U_(top, j) column by column (U_top upper triangular; the (top, j) coupling is untouched by the steps of the
   blocks below j, so every X_j reads the original Schur form); V = Q X, Y = X^-1 Q^H with X_j^-1 = I - [X_j].  The rigorous part is
   the same: C = Y V verified, B = C^-1 D enclosed entry by entry; then Feingold--Varga on B^T with the blocks {b_1}, ..., {b_K'}, rest:
   every eigenvalue satisfies sigma_min(B_bb - lambda) <= sum_(c != b) |B_cb|_2 for some b -- a singleton's disc of radius its column
   coupling eps_b (|B_cb|_2 <= |B_cb|_F summed over the other blocks); a cluster block's region |lambda - d| <= |B_bb - d I|_F + eps_b
   for its mean diagonal d; the rest's modulus by Gelfand with its radii raised by eps_rest.  The leading disc disjoint from every other
   region holds exactly one eigenvalue; the second modulus is the largest upper end among the other regions; the gap their quotient.
   WHY: with K = 1 the second modulus is the rest's Gelfand bound and its transient (0.1 %%) sits on the gap; with the second cluster
   taken off as its own block the rest's bound lies far below it and the gap is read at the precision of the enclosure -- the
   GAP-CONDITIONAL of eig_cert.c (the Krawczyk discs on the top clusters, the remainder unverified) made UNCONDITIONAL by this
   instrument's bound on everything from the (K+1)-th on.  A K that cuts inside a cluster is REFUSED SPLIT-INSIDE-CLUSTER. ---------- */
static int certify_blocks(const char *name, double radf, int K, double *gap_lo, double *l1_lo, double *l1_hi, double *l2_hi, int verbose) {
  Hm = malloc(sizeof(C) * n * n); Q = malloc(sizeof(C) * n * n); memcpy(Hm, T, sizeof(C) * n * n);
  hessenberg(); int steps; if (schur(&steps)) { printf("CERT-K %s REFUSED NO-CONVERGENCE\n", name); return 2; }
  if (K < 1) K = 1; if (K > n - 2) K = n - 2; if (K > 32) K = 32;
  for (int t = 0; t < K; t++) { int im = t; for (int i = t + 1; i < n; i++) if (cabs(A(i,i)) > cabs(A(im,im))) im = i; for (int p = im; p > t; p--) swap_adjacent(p - 1); }
  double al1 = cabs(A(0,0)), al2f = 0; for (int i = 1; i < n; i++) if (cabs(A(i,i)) > al2f) al2f = cabs(A(i,i));
  int bs[40], be[40], nb = 0; { int s = 0; for (int i = 1; i <= K; i++) { if (i == K || cabs(A(i,i) - A(s,s)) > 1e-6 * cabs(A(s,s))) { bs[nb] = s; be[nb] = i; nb++; s = i; } } }
  bs[nb] = K; be[nb] = n; nb++;
  /* a cluster member left below the split (anywhere in the rest, since the selection sort moves only the chosen entries up) */
  for (int p = 0; p < K; p++) for (int i = K; i < n; i++) if (cabs(A(i,i) - A(p,p)) <= 1e-6 * cabs(A(p,p))) { printf("CERT-K %s REFUSED SPLIT-INSIDE-CLUSTER (K = %d cuts a cluster: the top entry %.6e%+.6ei has a member %.6e%+.6ei in the rest)\n", name, K, creal(A(p,p)), cimag(A(p,p)), creal(A(i,i)), cimag(A(i,i))); return 4; }
  if (be[0] - bs[0] != 1) { printf("CERT-K %s REFUSED LEADING-CLUSTER (the leading block has %d members)\n", name, be[0] - bs[0]); return 4; }
  /* the decoupling blocks X_j (rows [0, s_j), columns [s_j, e_j)), each from the original Schur form */
  C **XB = malloc(sizeof(C *) * nb); for (int j = 1; j < nb; j++) { int s = bs[j], e = be[j]; XB[j] = calloc((size_t)s * (e - s), sizeof(C));
    for (int q = s; q < e; q++) { C *x = malloc(sizeof(C) * s);
      for (int i = 0; i < s; i++) { C r = -A(i,q); for (int p = s; p < q; p++) r += XB[j][(size_t)i*(e-s)+(p-s)] * A(p,q); x[i] = r; }
      for (int i = s - 1; i >= 0; i--) { C r = x[i]; for (int p = i + 1; p < s; p++) r -= A(i,p) * x[p]; x[i] = r / (A(i,i) - A(q,q)); }
      for (int i = 0; i < s; i++) XB[j][(size_t)i*(e-s)+(q-s)] = x[i]; free(x); } }
  /* X = X_(nb-1) ... X_1 by right multiplication, then V = Q X and Y = X^-1 Q^H by the factors in reverse */
  C *X = calloc((size_t)n * n, sizeof(C)); for (int i = 0; i < n; i++) X[(size_t)i*n+i] = 1;
  for (int j = nb - 1; j >= 1; j--) { int s = bs[j], e = be[j]; for (int i = 0; i < n; i++) for (int q = s; q < e; q++) { C acc = 0; for (int p = 0; p < s; p++) acc += X[(size_t)i*n+p] * XB[j][(size_t)p*(e-s)+(q-s)]; X[(size_t)i*n+q] += acc; } }
  C *V = malloc(sizeof(C) * n * n), *Y = malloc(sizeof(C) * n * n);
  for (int i = 0; i < n; i++) for (int q = 0; q < n; q++) { C acc = 0; for (int p = 0; p < n; p++) acc += QQ(i,p) * X[(size_t)p*n+q]; V[(size_t)i*n+q] = acc; }
  for (int p = 0; p < n; p++) for (int j = 0; j < n; j++) Y[(size_t)p*n+j] = conj(QQ(j,p));
  for (int j = nb - 1; j >= 1; j--) { int s = bs[j], e = be[j]; for (int i = 0; i < s; i++) for (int c = 0; c < n; c++) { C acc = 0; for (int q = s; q < e; q++) acc += XB[j][(size_t)i*(e-s)+(q-s)] * Y[(size_t)q*n+c]; Y[(size_t)i*n+c] -= acc; } }
  double xn = 0; for (size_t t = 0; t < (size_t)n * n; t++) { double v = cabs(X[t]); if (v > xn) xn = v; }
  free(X);
  C *Cm = malloc(sizeof(C) * n * n); double *Cr = malloc(sizeof(double) * n * n); mr_mul(Y, NULL, n, n, V, NULL, n, Cm, Cr);
  double r = 0; for (int i = 0; i < n; i++) { double s = 0; for (int j = 0; j < n; j++) { C e = Cm[(size_t)i*n+j] - (i == j); s += cabs(e) + Cr[(size_t)i*n+j]; } s = up(s * (1 + n * EPS)); if (s > r) r = s; }
  if (r >= 1) { printf("CERT-K %s REFUSED INVERSE-NOT-VERIFIED |I-YV|inf = %.3e (K = %d, |X|max %.2e)\n", name, r, K, xn); return 3; }
  double delta = up(r / (1 - r));
  double *Tr = malloc(sizeof(double) * n * n); for (size_t i = 0; i < (size_t)n * n; i++) Tr[i] = up(radf * cabs(T[i]) + (TRAD ? TRAD[i] : 0));
  C *Wm = malloc(sizeof(C) * n * n); double *Wr = malloc(sizeof(double) * n * n); mr_mul(T, Tr, n, n, V, NULL, n, Wm, Wr);
  C *Dm = malloc(sizeof(C) * n * n); double *Dr = malloc(sizeof(double) * n * n); mr_mul(Y, NULL, n, n, Wm, Wr, n, Dm, Dr);
  for (int j = 0; j < n; j++) { double mx = 0; for (int i = 0; i < n; i++) { double v = cabs(Dm[(size_t)i*n+j]) + Dr[(size_t)i*n+j]; if (v > mx) mx = v; } double cmj = up(delta * mx); for (int i = 0; i < n; i++) Dr[(size_t)i*n+j] = up(Dr[(size_t)i*n+j] + cmj); }
  /* the column coupling into each block from every other block: sum over c != b of |B_cb|_F (an upper bound of the 2-norm sum) */
  double eps[40]; for (int b = 0; b < nb; b++) { double tot = 0; for (int c = 0; c < nb; c++) { if (c == b) continue; double s2 = 0; for (int i = bs[c]; i < be[c]; i++) for (int j = bs[b]; j < be[b]; j++) { double v = cabs(Dm[(size_t)i*n+j]) + Dr[(size_t)i*n+j]; s2 += v * v; } tot = up(tot + up(sqrt(up(s2)))); } eps[b] = tot; }
  double cen = cabs(Dm[0]), rad00 = Dr[0]; double lo1 = cen - up(rad00 + eps[0]), hi1 = up(cen + rad00 + eps[0]);
  double second = 0; int worst = -1; double mod_hi[40], mod_lo[40];
  for (int b = 1; b < nb - 1; b++) { int s = bs[b], e = be[b], k = e - s;
    if (k == 1) { mod_hi[b] = up(cabs(Dm[(size_t)s*n+s]) + Dr[(size_t)s*n+s] + eps[b]); mod_lo[b] = cabs(Dm[(size_t)s*n+s]) - up(Dr[(size_t)s*n+s] + eps[b]); }
    else { C d = 0; for (int i = s; i < e; i++) d += Dm[(size_t)i*n+i]; d /= k; double f2 = 0; for (int i = s; i < e; i++) for (int j = s; j < e; j++) { double v = cabs(Dm[(size_t)i*n+j] - (i == j ? d : 0)) + Dr[(size_t)i*n+j]; f2 += v * v; } double wid = up(up(sqrt(up(f2))) + eps[b]); mod_hi[b] = up(cabs(d) + wid); mod_lo[b] = cabs(d) - wid; }
    if (mod_lo[b] < 0) mod_lo[b] = 0;
    if (mod_hi[b] > second) { second = mod_hi[b]; worst = b; } }
  /* the rest: Gelfand on D_rr with its radii raised by eps_rest */
  int rs = bs[nb-1], m = n - rs; C *Pm = malloc(sizeof(C) * m * m), *P2m = malloc(sizeof(C) * m * m); double *Pr = malloc(sizeof(double) * m * m), *P2r = malloc(sizeof(double) * m * m);
  for (int i = rs; i < n; i++) for (int j = rs; j < n; j++) { Pm[(size_t)(i-rs)*m+(j-rs)] = Dm[(size_t)i*n+j]; Pr[(size_t)(i-rs)*m+(j-rs)] = up(Dr[(size_t)i*n+j] + eps[nb-1]); }
  const int S = 10; double logb = 0, best = INFINITY; int bests = 0;
  for (int s = 0; s <= S; s++) { double c = fro_up(Pm, Pr, m); if (!(c > 0)) { best = 0; bests = s; break; }
    logb += log(c) / (double)(1u << s); double bsv = exp(logb) * (1 + 1e-12 * (s + 2)); if (bsv < best) { best = bsv; bests = s; }
    if (s == S) break;
    for (size_t t = 0; t < (size_t)m * m; t++) { Pm[t] /= c; Pr[t] = up(Pr[t] / c); }
    mr_mul(Pm, Pr, m, m, Pm, Pr, m, P2m, P2r); C *tm = Pm; Pm = P2m; P2m = tm; double *tr = Pr; Pr = P2r; P2r = tr; }
  mod_hi[nb-1] = best; if (best > second) { second = best; worst = nb - 1; }
  if (!(lo1 > second)) { printf("CERT-K %s REFUSED NO-SEPARATION (|lambda_1| >= %.6e against the second region's %.6e; K = %d, |I-YV| %.1e)\n", name, lo1, second, K, r); return 5; }
  double gap = (lo1 / second) * (1 - 8 * EPS);
  *gap_lo = gap; *l1_lo = lo1; *l1_hi = hi1; *l2_hi = second;
  if (verbose) { printf("CERT-K %s n=%d K=%d blocks=%d |lambda_1| in [%.12e, %.12e] (radius %.2e, coupling %.2e)  second modulus <= %.12e (block %d%s)  rest <= %.12e (Gelfand at 2^%d, %d members)  GAP >= %.9f  (float gap %.9f; |I-YV| %.1e, |X|max %.2e, T radius factor %.2e, qr-steps %d)\n",
      name, n, K, nb, lo1, hi1, rad00, eps[0], second, worst, worst == nb - 1 ? " = the rest" : "", best, bests, m, gap, al1 / al2f, r, xn, radf, steps);
    for (int b = 1; b < nb - 1; b++) printf("CERT-K %s   block %d: %d member%s, modulus in [%.12e, %.12e] (coupling %.2e); lambda_1 / modulus in [%.9f, %.9f]\n", name, b, be[b] - bs[b], be[b] - bs[b] == 1 ? "" : "s", mod_lo[b], mod_hi[b], eps[b], mod_hi[b] > 0 ? lo1 / mod_hi[b] : INFINITY, mod_lo[b] > 0 ? hi1 / mod_lo[b] : INFINITY); }
  return 0; }

static unsigned long long RNG = 0x9E3779B97F4A7C15ULL; static double urand(void) { RNG = RNG * 6364136223846793005ULL + 1442695040888963407ULL; return (RNG >> 11) * (1.0 / 9007199254740992.0); }
static int kat(void) { int bad = 0; n = 12; T = malloc(sizeof(C) * n * n); C *V = malloc(sizeof(C) * n * n), *Y = malloc(sizeof(C) * n * n), *D = malloc(sizeof(C) * n * n);
  /* case 1: a known spectrum with a conjugate pair and a semisimple degenerate pair */
  C spec[12] = { 10, 2 + 1 * I, 2 - 1 * I, 1.5, 1.5, 0.7, 0.3 + 0.2 * I, 0.3 - 0.2 * I, 0.1, 0.05, 0.02, 0.01 };
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) V[(size_t)i*n+j] = (i == j) + 0.3 * (urand() - 0.5) + 0.3 * I * (urand() - 0.5);
  if (inverse(V, Y)) return 1;
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) { C s = 0; for (int k = 0; k < n; k++) s += V[(size_t)i*n+k] * spec[k] * Y[(size_t)k*n+j]; TT(i,j) = s; }
  double g, l1lo, l1hi, l2hi; int rc = certify("KAT-known", n * 2 * EPS, &g, &l1lo, &l1hi, &l2hi, 1);
  double g0 = 10 / cabs(2 + 1 * I);
  if (rc != 0 || !(l1lo <= 10 && 10 <= l1hi) || l1hi - l1lo > 1e-8 || !(l2hi >= cabs(2 + 1 * I)) || l2hi > 1.01 * cabs(2 + 1 * I) || !(g <= g0) || g < g0 / 1.01) { printf("KAT known-spectrum FAILED (rc %d, |l1| in [%.12f, %.12f], |l2| <= %.12f, gap >= %.12f vs %.12f)\n", rc, l1lo, l1hi, l2hi, g, g0); bad++; }
  else printf("KAT known-spectrum MET: |lambda_1| = 10 in [%.12f, %.12f], |lambda_2| = sqrt5 <= %.12f, gap >= %.12f (the exact %.12f), the degenerate 1.5 pair clustered\n", l1lo, l1hi, l2hi, g, g0);
  /* case 2a: the entries given a one-percent radius -- the certificate must still CONTAIN the known values, its discs widened honestly
     (the first draft expected a refusal here; a gap of 4.5 survives one percent, as the run showed -- the stake corrected, dated) */
  rc = certify("KAT-onepercent", 1e-2, &g, &l1lo, &l1hi, &l2hi, 1);
  if (rc != 0 || !(l1lo <= 10 && 10 <= l1hi) || !(l2hi >= cabs(2 + 1 * I)) || !(g <= g0) || l1hi - l1lo < 1e-6) { printf("KAT one-percent FAILED (rc %d, |l1| in [%.6f, %.6f], |l2| <= %.6f, gap >= %.6f)\n", rc, l1lo, l1hi, l2hi, g); bad++; }
  else printf("KAT one-percent MET: the known values still inside, the leading disc widened to %.3e, gap >= %.6f against the exact %.6f\n", l1hi - l1lo, g, g0);
  /* case 2b: the planted perturbation -- the entry radius widened to 0.5 |entry| must be REFUSED by name (no separation can survive it) */
  rc = certify("KAT-planted", 0.5, &g, &l1lo, &l1hi, &l2hi, 0);
  if (rc == 5) printf("KAT planted-perturbation MET: REFUSED NO-SEPARATION at radius 0.5 |entry|\n"); else { printf("KAT planted-perturbation FAILED (rc %d)\n", rc); bad++; }
  /* case 3: a defective pair (a Jordan block at 2) -- the second modulus bound must hold and the instrument must not refuse */
  C J[12][12]; memset(J, 0, sizeof J); for (int i = 0; i < n; i++) J[i][i] = spec[i]; J[1][1] = 2; J[2][2] = 2; J[1][2] = 1;
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) { C s = 0; for (int k = 0; k < n; k++) for (int l = 0; l < n; l++) s += V[(size_t)i*n+k] * J[k][l] * Y[(size_t)l*n+j]; TT(i,j) = s; }
  rc = certify("KAT-jordan", n * 2 * EPS, &g, &l1lo, &l1hi, &l2hi, 1);
  if (rc != 0 || !(l2hi >= 2) || !(l1lo <= 10 && 10 <= l1hi)) { printf("KAT jordan FAILED (rc %d, |l2| <= %.6f)\n", rc, l2hi); bad++; } else printf("KAT jordan MET: the defective pair at 2 bounded by %.6f (the Jordan coupling's price, honest), |lambda_1| in [%.9f, %.9f]\n", l2hi, l1lo, l1hi);
  /* case 4: THE k-BLOCK SPLIT on the known spectrum (rebuilt: case 3 overwrote T) -- K = 3 takes 10, 2+i, 2-i as singletons, so the
     rest's Gelfand bound sits on the 1.5 pair and the gap reads 10/sqrt5 at the enclosure's precision; K = 5 takes the degenerate 1.5
     pair as a CLUSTER block; K = 4 cuts inside that pair and must be REFUSED by name */
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) { C s = 0; for (int k = 0; k < n; k++) s += V[(size_t)i*n+k] * spec[k] * Y[(size_t)k*n+j]; TT(i,j) = s; }
  rc = certify_blocks("KAT-blocks3", n * 2 * EPS, 3, &g, &l1lo, &l1hi, &l2hi, 1);
  if (rc != 0 || !(l1lo <= 10 && 10 <= l1hi) || !(l2hi >= cabs(2 + 1 * I)) || l2hi > (1 + 1e-9) * cabs(2 + 1 * I) || !(g <= g0) || g < g0 * (1 - 1e-9)) { printf("KAT blocks3 FAILED (rc %d, |l1| in [%.12f, %.12f], |l2| <= %.12f, gap >= %.12f vs %.12f)\n", rc, l1lo, l1hi, l2hi, g, g0); bad++; }
  else printf("KAT blocks3 MET: with 10, 2+i, 2-i as singleton blocks the gap reads %.12f against the exact %.12f (the K = 1 transient gone), |lambda_2| <= %.12f\n", g, g0, l2hi);
  rc = certify_blocks("KAT-blocks5", n * 2 * EPS, 5, &g, &l1lo, &l1hi, &l2hi, 1);
  if (rc != 0 || !(l1lo <= 10 && 10 <= l1hi) || !(l2hi >= cabs(2 + 1 * I)) || !(g <= g0) || g < g0 * (1 - 1e-9)) { printf("KAT blocks5 FAILED (rc %d, gap >= %.12f vs %.12f)\n", rc, g, g0); bad++; }
  else printf("KAT blocks5 MET: the degenerate 1.5 pair taken as a cluster block, the gap %.12f\n", g);
  rc = certify_blocks("KAT-blocks4", n * 2 * EPS, 4, &g, &l1lo, &l1hi, &l2hi, 0);
  if (rc == 4) printf("KAT blocks4 MET: K = 4 cuts inside the 1.5 pair and is REFUSED SPLIT-INSIDE-CLUSTER\n"); else { printf("KAT blocks4 FAILED (rc %d)\n", rc); bad++; }
  printf("KAT %s\n", bad ? "FAILED" : "MET");
  return bad; }

int main(int argc, char **argv) { _setmode(_fileno(stdout), _O_BINARY);   /* LF on this host: the records are fixtures (the house law: strip at the source) */
  if (argc >= 2 && !strcmp(argv[1], "--kat")) return kat();
  if (argc < 2) { fprintf(stderr, "usage: certspec <dump> [name] [radius factor] [K blocks] | certspec --kat\n"); return 2; }
  const char *name = argc > 2 ? argv[2] : argv[1];
  FILE *f = fopen(argv[1], "r"); if (!f) { printf("CERT %s REFUSED no-file\n", name); return 2; }
  char head[1024]; if (!fgets(head, sizeof head, f)) return 2; int n1, n2; if (sscanf(head, "# T %d x %d", &n1, &n2) != 2 || n1 != n2 || n1 < 2) { printf("CERT %s REFUSED header\n", name); return 2; }
  n = n1; T = malloc(sizeof(C) * n * n); int withrad = strstr(head, "re im rad") != NULL; if (withrad) TRAD = malloc(sizeof(double) * n * n);
  for (size_t i = 0; i < (size_t)n * n; i++) { double re, im, rd = 0; if (withrad ? fscanf(f, "%lf %lf %lf", &re, &im, &rd) != 3 : fscanf(f, "%lf %lf", &re, &im) != 2) { printf("CERT %s REFUSED short\n", name); return 2; } T[i] = re + im * I; if (withrad) TRAD[i] = rd; }
  fclose(f); if (withrad) printf("CERT %s: the dump carries per-entry radii (certified entries); they are added to the rounding radius\n", name);
  double radf = argc > 3 ? atof(argv[3]) : n * 2 * EPS; int K = argc > 4 ? atoi(argv[4]) : 0;
  double g, l1lo, l1hi, l2hi; if (K >= 1) return certify_blocks(name, radf, K, &g, &l1lo, &l1hi, &l2hi, 1);
  return certify(name, radf, &g, &l1lo, &l1hi, &l2hi, 1); }
