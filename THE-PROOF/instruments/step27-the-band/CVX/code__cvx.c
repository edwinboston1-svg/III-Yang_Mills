/* cvx.c -- CVX's house engine: the convexity radius of the SU(2) Wilson action on M8's linear slice, in C.
 *
 * WHAT IT PROVES AND WHAT IT REFUSES.  The operator's order of 2026-11-02 14:5x: no Python instrument; every number of
 * WORK.md sections 3-26 was produced in Python and is a FOREIGN ANCHOR that this engine must reproduce.  This file is the run of
 * record for section 27 on.  It composes nothing beyond libc and libm; libm (sin, cos, log, sqrt) is used ONLY by readings and
 * random starts.  Every certified quantity is either
 *   (i)  exact integer / int128-rational arithmetic (the slice, its kernel basis K with C0 K = 0 checked exactly, the Taylor
 *        tensors D4F(0), D5F(0) by exact univariate series and polarisation), or
 *   (ii) a verified Cholesky (float factor, rigorous residual bound, gamma_{n+2}), or
 *   (iii) ball arithmetic (midpoint, radius; every radius inflated by (1 + 4*2^-52) per operation; cos and sin r / r as series in
 *        r^2 with an explicit alternating tail bound, no libm, no sqrt) for the action S at exact rational configurations.
 * An int128 overflow in the rational RREF is a REFUSAL BY NAME, never a silent wrap.
 *
 * Coordinates: M8's additive exponential [EXP] coordinates, U = exp(i B.sigma); quaternion q(phi) = (cos r, -sinc(r) phi),
 * (1/2) tr(U1 U2 ...) = Re(q1 q2 ...); plaquette F = 1 - Re(q(phi1) q(phi2) q(-phi3) q(-phi4)), s = (1,1,-1,-1).
 * Tori: L = 2 half-open blocks on (4,2,2,2); L = 3 centred blocks on (6,3,3,3) (M8, M8b; WORK.md section 0).
 *
 * Modes (every run prints its command line):
 *   cvx kat L                        the anchors: slice, free gap, plaquette KATs, O1, (L=2) the Python three-point anchor
 *   cvx chain L blocks.npy b1,b2,..  THEOREM CVX re-derived: Taylor tensors, Lemma R constants, Lemma M LMIs, Finsler per b
 *   cvx remread L blocks.npy b1,..   the exact-remainder ceiling (READING)
 *   cvx climb L fam s1,s2,.. out     item 2: ray scan + gradient climb at fixed sup norm; writes dyadic coefficients
 *   cvx cert3 L cfgfile eps          the derivative-free three-point non-convexity certificate in ball arithmetic
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <math.h>
#include <time.h>

typedef __int128 i128;
static const double U53 = 1.1102230246251565e-16;   /* 2^-53 */
static const double EPSB = 2.220446049250313e-16;   /* 2^-52 > u: ball arithmetic's rounding unit */
static const int SGN[4] = {1, 1, -1, -1};
static const int TRI[4][3] = {{0,1,2},{0,1,3},{0,2,3},{1,2,3}};
static int SIG3[4];

static double wall(void) { struct timespec t; clock_gettime(CLOCK_MONOTONIC, &t); return t.tv_sec + 1e-9 * t.tv_nsec; }
static double T0W;
static void *xcalloc(size_t n, size_t s) {
    void *p = calloc(n ? n : 1, s);
    if (!p) { printf("REFUSED: out of memory (%zu x %zu bytes)\n", n, s); exit(3); }
    return p;
}
#define NEW(type, n) ((type *)xcalloc((size_t)(n), sizeof(type)))

/* ------------------------------------------------------------------ RNG (splitmix64; readings and starts only) */
static uint64_t RS = 20261102ULL;
static uint64_t rnext(void) {
    uint64_t z = (RS += 0x9E3779B97F4A7C15ULL);
    z = (z ^ (z >> 30)) * 0xBF58476D1CE4E5B9ULL; z = (z ^ (z >> 27)) * 0x94D049BB133111EBULL; return z ^ (z >> 31);
}
static double runif(void) { return (double)(rnext() >> 11) * (1.0 / 9007199254740992.0); }
static double rnorm(void) { double a = runif(), b = runif(); if (a < 1e-300) a = 1e-300; return sqrt(-2 * log(a)) * cos(6.283185307179586 * b); }

/* ------------------------------------------------------------------ dense linear algebra */
static double dot(int n, const double *a, const double *b) { double s = 0; for (int i = 0; i < n; i++) s += a[i] * b[i]; return s; }
static double nrm(int n, const double *a) { return sqrt(dot(n, a, a)); }

/* cyclic Jacobi: A (n x n, symmetric, destroyed) -> w ascending, V columns (row-major V[i*n+j] = component i of vector j) */
static void jacobi(int n, double *A, double *w, double *V) {
    for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) V[i * n + j] = (i == j);
    for (int sweep = 0; sweep < 100; sweep++) {
        double off = 0, dia = 0;
        for (int i = 0; i < n; i++) { dia += A[i * n + i] * A[i * n + i]; for (int j = i + 1; j < n; j++) off += A[i * n + j] * A[i * n + j]; }
        if (off <= 1e-32 * (dia + 1e-300)) break;
        for (int p = 0; p < n; p++) for (int q = p + 1; q < n; q++) {
            double apq = A[p * n + q];
            if (fabs(apq) < 1e-300) continue;
            double th = (A[q * n + q] - A[p * n + p]) / (2 * apq);
            double t = (th >= 0 ? 1.0 : -1.0) / (fabs(th) + sqrt(th * th + 1));
            double c = 1 / sqrt(t * t + 1), s = t * c;
            for (int k = 0; k < n; k++) {
                if (k == p || k == q) continue;
                double akp = A[k * n + p], akq = A[k * n + q];
                A[k * n + p] = A[p * n + k] = c * akp - s * akq;
                A[k * n + q] = A[q * n + k] = s * akp + c * akq;
            }
            A[p * n + p] -= t * apq; A[q * n + q] += t * apq; A[p * n + q] = A[q * n + p] = 0;
            for (int k = 0; k < n; k++) { double vp = V[k * n + p], vq = V[k * n + q]; V[k * n + p] = c * vp - s * vq; V[k * n + q] = s * vp + c * vq; }
        }
    }
    for (int i = 0; i < n; i++) w[i] = A[i * n + i];
    for (int i = 0; i < n; i++) {   /* selection sort ascending, columns of V follow */
        int m = i; for (int j = i + 1; j < n; j++) if (w[j] < w[m]) m = j;
        if (m != i) { double t = w[i]; w[i] = w[m]; w[m] = t; for (int k = 0; k < n; k++) { t = V[k * n + i]; V[k * n + i] = V[k * n + m]; V[k * n + m] = t; } }
    }
}
static double lmin_sym(int n, const double *A) {   /* reading */
    double *B = NEW(double, n * n), *w = NEW(double, n), *V = NEW(double, n * n);
    memcpy(B, A, sizeof(double) * n * n); jacobi(n, B, w, V);
    double r = w[0]; free(B); free(w); free(V); return r;
}
static double lmax_sym(int n, const double *A) {
    double *B = NEW(double, n * n), *w = NEW(double, n), *V = NEW(double, n * n);
    memcpy(B, A, sizeof(double) * n * n); jacobi(n, B, w, V);
    double r = w[n - 1]; free(B); free(w); free(V); return r;
}

/* implicit QL on a symmetric tridiagonal (d[0..n-1], e[0..n-2] off-diagonal; e has length n), eigenvectors in z (n x n row-major) */
static int tqli(int n, double *d, double *e, double *z) {
    for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) z[i * n + j] = (i == j);
    if (n > 0) e[n - 1] = 0;
    for (int l = 0; l < n; l++) {
        int iter = 0, m;
        do {
            for (m = l; m < n - 1; m++) { double dd = fabs(d[m]) + fabs(d[m + 1]); if (fabs(e[m]) <= 2.220446049250313e-16 * dd) break; }
            if (m != l) {
                if (iter++ == 200) return -1;
                double g = (d[l + 1] - d[l]) / (2.0 * e[l]);
                double r = hypot(g, 1.0);
                g = d[m] - d[l] + e[l] / (g + (g >= 0 ? fabs(r) : -fabs(r)));
                double s = 1, c = 1, p = 0; int i;
                for (i = m - 1; i >= l; i--) {
                    double f = s * e[i], b = c * e[i];
                    e[i + 1] = (r = hypot(f, g));
                    if (r == 0.0) { d[i + 1] -= p; e[m] = 0.0; break; }
                    s = f / r; c = g / r; g = d[i + 1] - p; r = (d[i] - g) * s + 2.0 * c * b; d[i + 1] = g + (p = s * r); g = c * r - b;
                    for (int k = 0; k < n; k++) { f = z[k * n + i + 1]; z[k * n + i + 1] = s * z[k * n + i] + c * f; z[k * n + i] = c * z[k * n + i] - s * f; }
                }
                if (r == 0.0 && i >= l) continue;
                d[l] -= p; e[l] = g; e[m] = 0.0;
            }
        } while (m != l);
    }
    return 0;
}

/* Lanczos with full reorthogonalisation: smallest eigenpair of a symmetric operator; x in: guess, out: unit Ritz vector */
typedef void (*mvfun)(void *ctx, const double *x, double *y);
static double lanczos_min(int n, mvfun mv, void *ctx, double *x, int m, double tol, int maxrs, double *res_out) {
    if (m > n) m = n;
    double *V = NEW(double, (size_t)(m + 1) * n), *w = NEW(double, n), *al = NEW(double, m), *be = NEW(double, m + 1);
    double *d = NEW(double, m), *e = NEW(double, m), *Z = NEW(double, m * m);
    double theta = 0, res = 1e300;
    for (int rs = 0; rs < maxrs; rs++) {
        double nx = nrm(n, x);
        if (nx < 1e-300) { for (int i = 0; i < n; i++) x[i] = rnorm(); nx = nrm(n, x); }
        for (int i = 0; i < n; i++) V[i] = x[i] / nx;
        int mj = m; be[0] = 0;
        for (int j = 0; j < m; j++) {
            double *vj = V + (size_t)j * n;
            mv(ctx, vj, w);
            al[j] = dot(n, w, vj);
            for (int i = 0; i < n; i++) w[i] -= al[j] * vj[i] + (j > 0 ? be[j] * V[(size_t)(j - 1) * n + i] : 0);
            for (int pass = 0; pass < 2; pass++) for (int t = 0; t <= j; t++) {
                double *vt = V + (size_t)t * n; double h = dot(n, w, vt);
                for (int i = 0; i < n; i++) w[i] -= h * vt[i];
            }
            be[j + 1] = nrm(n, w);
            if (be[j + 1] < 1e-13 * (fabs(al[j]) + 1e-300) || j == m - 1) { mj = j + 1; break; }
            for (int i = 0; i < n; i++) V[(size_t)(j + 1) * n + i] = w[i] / be[j + 1];
        }
        for (int i = 0; i < mj; i++) { d[i] = al[i]; e[i] = (i + 1 < mj) ? be[i + 1] : 0; }
        if (tqli(mj, d, e, Z) != 0) { printf("REFUSED: tqli did not converge\n"); exit(4); }
        int im = 0; for (int i = 1; i < mj; i++) if (d[i] < d[im]) im = i;
        theta = d[im];
        for (int i = 0; i < n; i++) { double s = 0; for (int t = 0; t < mj; t++) s += Z[t * mj + im] * V[(size_t)t * n + i]; x[i] = s; }
        double nn = nrm(n, x); for (int i = 0; i < n; i++) x[i] /= nn;
        /* true residual */
        mv(ctx, x, w); res = 0; for (int i = 0; i < n; i++) { double r = w[i] - theta * x[i]; res += r * r; } res = sqrt(res);
        if (res < tol) break;
    }
    if (res_out) *res_out = res;
    free(V); free(w); free(al); free(be); free(d); free(e); free(Z);
    return theta;
}

/* VERIFIED CHOLESKY: lambda_min(A_true) >= delta - rbound, |A_true - A| <= EA entrywise (EA may be NULL).  Returns -INFINITY if
 * the float factorisation of A - delta I breaks down.  Rc_ij = fl(As_ij - sum_k L_ik L_jk) recursively; the true residual
 * E = A_true - delta I - L L^T obeys |E_ij| <= EA_ij + u|As_ij| + |Rc_ij| + gamma_{n+2}(|As_ij| + (|L||L|^T)_ij), and
 * ||E||_2 <= max_i sum_j |E_ij|, the sum inflated by (1 + 4 n u).  L L^T is PSD, hence the bound. */
static double verified_lmin_lower(int n, const double *A, double delta, const double *EA, double *rb_out) {
    double *L = NEW(double, (size_t)n * n);
    for (int i = 0; i < n; i++) for (int j = 0; j <= i; j++) {
        double s = A[(size_t)i * n + j] - (i == j ? delta : 0);
        for (int k = 0; k < j; k++) s -= L[(size_t)i * n + k] * L[(size_t)j * n + k];
        if (i == j) { if (!(s > 0)) { free(L); if (rb_out) *rb_out = NAN; return -INFINITY; } L[(size_t)i * n + i] = sqrt(s); }
        else L[(size_t)i * n + j] = s / L[(size_t)j * n + j];
    }
    double g = (n + 2) * U53 / (1 - (n + 2) * U53), worst = 0;
    for (int i = 0; i < n; i++) {
        double row = 0;
        for (int j = 0; j < n; j++) {
            double as = A[(size_t)i * n + j] - (i == j ? delta : 0);
            double rc = as, al = 0; int kk = i < j ? i : j;
            for (int k = 0; k <= kk; k++) { rc -= L[(size_t)i * n + k] * L[(size_t)j * n + k]; al += fabs(L[(size_t)i * n + k] * L[(size_t)j * n + k]); }
            double bnd = fabs(rc) + U53 * fabs(as) + g * (fabs(as) + al) + (EA ? EA[(size_t)i * n + j] : 0);
            row += bnd;
        }
        if (row > worst) worst = row;
    }
    worst = worst * (1 + 4 * n * U53) + 1e-300;
    free(L);
    if (rb_out) *rb_out = worst;
    return delta - worst;
}

/* ------------------------------------------------------------------ int128 fractions (exact; overflow = refusal by name) */
typedef struct { i128 n, d; } frac;
static const i128 FLIM = ((i128)1) << 62;
static i128 iab(i128 x) { return x < 0 ? -x : x; }
static i128 gcd128(i128 a, i128 b) { a = iab(a); b = iab(b); while (b) { i128 t = a % b; a = b; b = t; } return a; }
static void ovf(const char *where) { printf("REFUSED: int128 rational overflow in %s (a magnitude reached 2^62)\n", where); exit(5); }
static frac fmk(i128 n, i128 d, const char *where) {
    if (d == 0) { printf("REFUSED: zero denominator in %s\n", where); exit(5); }
    if (d < 0) { n = -n; d = -d; }
    i128 g = gcd128(n, d); if (g > 1) { n /= g; d /= g; }
    if (n == 0) d = 1;
    if (iab(n) >= FLIM || d >= FLIM) ovf(where);
    frac f = {n, d}; return f;
}
static frac fadd(frac a, frac b, const char *w) { return fmk(a.n * b.d + b.n * a.d, a.d * b.d, w); }
static frac fsub(frac a, frac b, const char *w) { return fmk(a.n * b.d - b.n * a.d, a.d * b.d, w); }
static frac fmul(frac a, frac b, const char *w) { return fmk(a.n * b.n, a.d * b.d, w); }
static frac fdiv(frac a, frac b, const char *w) { return fmk(a.n * b.d, a.d * b.n, w); }
static frac fint(long long v) { frac f = {(i128)v, 1}; return f; }
static double fdbl(frac f) { return (double)f.n / (double)f.d; }

/* ------------------------------------------------------------------ the torus and its slice */
typedef struct {
    int L, e[4], nS, nLk, nP, nQ, nG, m, rank, k;
    int *plaq, *coarse, *Q0, *G0, *piv, *freec, *ispiv;
    frac *R;          /* rank x k: RREF entry of pivot row i at free column freec[j] */
    double *T0;       /* nLk x k orthonormal basis of V0 */
    double *H0c;      /* nLk x nLk */
    double *Kd;       /* nLk x k: the exact basis K as doubles (K[f_j][j] = 1, K[piv_i][j] = -R_ij) */
} Torus;

static int sidx(const Torus *T, const int *x) {
    int y[4]; for (int a = 0; a < 4; a++) { y[a] = x[a] % T->e[a]; if (y[a] < 0) y[a] += T->e[a]; }
    return ((y[0] * T->e[1] + y[1]) * T->e[2] + y[2]) * T->e[3] + y[3];
}
static int lid(const Torus *T, const int *x, int mu) { return 4 * sidx(T, x) + mu; }
static void site_of(const Torus *T, int s, int *x) {
    x[3] = s % T->e[3]; s /= T->e[3]; x[2] = s % T->e[2]; s /= T->e[2]; x[1] = s % T->e[1]; s /= T->e[1]; x[0] = s;
}

static int nperm_list(int *nz, int nnz, int perms[24][4]) {   /* all permutations of nz (lexicographic like itertools) */
    int cnt = 0;
    if (nnz == 0) { return 1; }
    int idx[4] = {0, 1, 2, 3};
    /* generate permutations of positions 0..nnz-1 in lexicographic order (itertools.permutations order) */
    int a[4]; for (int i = 0; i < nnz; i++) a[i] = i;
    while (1) {
        for (int i = 0; i < nnz; i++) perms[cnt][i] = nz[a[i]];
        cnt++;
        int i = nnz - 2; while (i >= 0 && a[i] > a[i + 1]) i--;
        if (i < 0) break;
        int j = nnz - 1; while (a[j] < a[i]) j--;
        int t = a[i]; a[i] = a[j]; a[j] = t;
        for (int l = i + 1, r = nnz - 1; l < r; l++, r--) { t = a[l]; a[l] = a[r]; a[r] = t; }
    }
    (void)idx;
    return cnt;
}

static void torus_build(Torus *T, int L) {
    memset(T, 0, sizeof(*T));
    T->L = L;
    if (L == 2) { T->e[0] = 4; T->e[1] = 2; T->e[2] = 2; T->e[3] = 2; } else { T->e[0] = 6; T->e[1] = 3; T->e[2] = 3; T->e[3] = 3; }
    T->nS = T->e[0] * T->e[1] * T->e[2] * T->e[3]; T->nLk = 4 * T->nS; T->nP = 6 * T->nS;
    T->plaq = NEW(int, 4 * T->nP); T->coarse = NEW(int, T->nS);
    int np = 0, x[4], y[4];
    for (int s = 0; s < T->nS; s++) {
        site_of(T, s, x);
        int c = 1; for (int a = 0; a < 4; a++) if (x[a] % L != 0) c = 0;
        T->coarse[s] = c;
        for (int mu = 0; mu < 4; mu++) for (int nu = mu + 1; nu < 4; nu++) {
            int *p = T->plaq + 4 * np;
            p[0] = lid(T, x, mu);
            memcpy(y, x, sizeof y); y[mu]++; p[1] = lid(T, y, nu);
            memcpy(y, x, sizeof y); y[nu]++; p[2] = lid(T, y, mu);
            p[3] = lid(T, x, nu);
            np++;
        }
    }
    /* gauge columns at non-coarse sites, stored as rows of length nLk */
    int nG = 0; for (int s = 0; s < T->nS; s++) if (!T->coarse[s]) nG++;
    T->nG = nG; T->G0 = NEW(int, (size_t)nG * T->nLk);
    int g = 0;
    for (int s = 0; s < T->nS; s++) {
        if (T->coarse[s]) continue;
        site_of(T, s, x);
        for (int mu = 0; mu < 4; mu++) {
            T->G0[(size_t)g * T->nLk + lid(T, x, mu)] -= 1;
            memcpy(y, x, sizeof y); y[mu]--; T->G0[(size_t)g * T->nLk + lid(T, y, mu)] += 1;
        }
        g++;
    }
    /* Balaban's linearised average, integer-scaled by SCALE = L^4 * 24 */
    int nC = 0; for (int s = 0; s < T->nS; s++) if (T->coarse[s]) nC++;
    T->nQ = 4 * nC; T->Q0 = NEW(int, (size_t)T->nQ * T->nLk);
    int q = 0;
    int nb = (L == 2) ? 16 : 81;
    for (int s = 0; s < T->nS; s++) {
        if (!T->coarse[s]) continue;
        int yy[4]; site_of(T, s, yy);
        for (int mu = 0; mu < 4; mu++) {
            int *row = T->Q0 + (size_t)q * T->nLk;
            for (int bi = 0; bi < nb; bi++) {
                int nv[4], t = bi;
                for (int a = 3; a >= 0; a--) { if (L == 2) { nv[a] = t % 2; t /= 2; } else { nv[a] = t % 3 - 1; t /= 3; } }
                for (int j = 0; j < L; j++) { int z[4]; for (int a = 0; a < 4; a++) z[a] = yy[a] + nv[a] + (a == mu ? j : 0); row[lid(T, z, mu)] += 24; }
                int nz[4], nnz = 0; for (int a = 0; a < 4; a++) if (nv[a] != 0) nz[nnz++] = a;
                int perms[24][4]; int np2 = nperm_list(nz, nnz, perms);
                int w = 24 / np2;
                for (int side = 0; side < 2; side++) {
                    int start[4]; memcpy(start, yy, sizeof start); int sign = 1;
                    if (side == 1) { start[mu] += L; sign = -1; }
                    if (nnz == 0) continue;
                    for (int pi = 0; pi < np2; pi++) {
                        int z[4]; memcpy(z, start, sizeof z);
                        for (int r = 0; r < nnz; r++) {
                            int nu = perms[pi][r];
                            for (int c = 0; c < abs(nv[nu]); c++) {
                                if (nv[nu] > 0) { row[lid(T, z, nu)] += sign * w; z[nu]++; }
                                else { z[nu]--; row[lid(T, z, nu)] -= sign * w; }
                            }
                        }
                    }
                }
            }
            q++;
        }
    }
    /* H0c = curl^T curl */
    T->H0c = NEW(double, (size_t)T->nLk * T->nLk);
    for (int p = 0; p < T->nP; p++) for (int i = 0; i < 4; i++) for (int j = 0; j < 4; j++)
        T->H0c[(size_t)T->plaq[4 * p + i] * T->nLk + T->plaq[4 * p + j]] += SGN[i] * SGN[j];
    /* exact RREF of C0 = [Q0; G0^T] */
    int m = T->nQ + T->nG, n = T->nLk; T->m = m;
    frac *M = NEW(frac, (size_t)m * n);
    for (int i = 0; i < m; i++) for (int j = 0; j < n; j++) {
        int v = (i < T->nQ) ? T->Q0[(size_t)i * n + j] : T->G0[(size_t)(i - T->nQ) * n + j];
        M[(size_t)i * n + j] = fint(v);
    }
    int *piv = NEW(int, m); int r = 0;
    for (int c = 0; c < n && r < m; c++) {
        int p = -1; for (int i = r; i < m; i++) if (M[(size_t)i * n + c].n != 0) { p = i; break; }
        if (p < 0) continue;
        if (p != r) for (int j = 0; j < n; j++) { frac t = M[(size_t)p * n + j]; M[(size_t)p * n + j] = M[(size_t)r * n + j]; M[(size_t)r * n + j] = t; }
        frac inv = fdiv(fint(1), M[(size_t)r * n + c], "RREF pivot");
        for (int j = 0; j < n; j++) if (M[(size_t)r * n + j].n != 0) M[(size_t)r * n + j] = fmul(M[(size_t)r * n + j], inv, "RREF scale");
        for (int i = 0; i < m; i++) {
            if (i == r || M[(size_t)i * n + c].n == 0) continue;
            frac f = M[(size_t)i * n + c];
            for (int j = 0; j < n; j++) if (M[(size_t)r * n + j].n != 0)
                M[(size_t)i * n + j] = fsub(M[(size_t)i * n + j], fmul(f, M[(size_t)r * n + j], "RREF elim"), "RREF elim");
        }
        piv[r++] = c;
    }
    T->rank = r; T->k = n - r; T->piv = piv;
    T->ispiv = NEW(int, n); for (int i = 0; i < r; i++) T->ispiv[piv[i]] = 1;
    T->freec = NEW(int, T->k); { int j = 0; for (int c = 0; c < n; c++) if (!T->ispiv[c]) T->freec[j++] = c; }
    T->R = NEW(frac, (size_t)r * T->k);
    for (int i = 0; i < r; i++) for (int j = 0; j < T->k; j++) T->R[(size_t)i * T->k + j] = M[(size_t)i * n + T->freec[j]];
    free(M);
    /* the exact basis as doubles, then an orthonormal basis by modified Gram-Schmidt twice */
    int k = T->k;
    T->Kd = NEW(double, (size_t)n * k); T->T0 = NEW(double, (size_t)n * k);
    for (int j = 0; j < k; j++) {
        T->Kd[(size_t)T->freec[j] * k + j] = 1.0;
        for (int i = 0; i < r; i++) T->Kd[(size_t)piv[i] * k + j] = -fdbl(T->R[(size_t)i * k + j]);
    }
    double *col = NEW(double, n);
    for (int j = 0; j < k; j++) {
        for (int i = 0; i < n; i++) col[i] = T->Kd[(size_t)i * k + j];
        for (int pass = 0; pass < 2; pass++) for (int t = 0; t < j; t++) {
            double h = 0; for (int i = 0; i < n; i++) h += col[i] * T->T0[(size_t)i * k + t];
            for (int i = 0; i < n; i++) col[i] -= h * T->T0[(size_t)i * k + t];
        }
        double nn = nrm(n, col); for (int i = 0; i < n; i++) T->T0[(size_t)i * k + j] = col[i] / nn;
    }
    free(col);
}

/* exact check C0 K = 0 (rational) */
static long long check_C0K(const Torus *T) {
    int n = T->nLk, k = T->k; long long nz = 0;
    for (int row = 0; row < T->m; row++) {
        const int *c0 = (row < T->nQ) ? T->Q0 + (size_t)row * n : T->G0 + (size_t)(row - T->nQ) * n;
        for (int j = 0; j < k; j++) {
            frac s = fint(c0[T->freec[j]]);
            for (int i = 0; i < T->rank; i++) { int v = c0[T->piv[i]]; if (!v) continue; s = fsub(s, fmul(fint(v), T->R[(size_t)i * k + j], "C0K"), "C0K"); }
            if (s.n != 0) nz++;
        }
    }
    return nz;
}

/* T0^T M T0 (k x k) for a sparse-ish nLk x nLk matrix M */
static void restrict_mat(const Torus *T, const double *M, double *out) {
    int n = T->nLk, k = T->k; double *tmp = NEW(double, (size_t)n * k);
    for (int l = 0; l < n; l++) { const double *mr = M + (size_t)l * n; double *tr = tmp + (size_t)l * k;
        for (int m = 0; m < n; m++) { double v = mr[m]; if (v == 0) continue; const double *t0 = T->T0 + (size_t)m * k; for (int j = 0; j < k; j++) tr[j] += v * t0[j]; } }
    for (int i = 0; i < k; i++) for (int j = 0; j < k; j++) out[i * k + j] = 0;
    for (int l = 0; l < n; l++) { const double *t0 = T->T0 + (size_t)l * k, *tr = tmp + (size_t)l * k;
        for (int i = 0; i < k; i++) { double a = t0[i]; if (a == 0) continue; double *o = out + (size_t)i * k; for (int j = 0; j < k; j++) o[j] += a * tr[j]; } }
    free(tmp);
}

/* ------------------------------------------------------------------ quaternions, jets, the plaquette */
static void qm(const double *p, const double *q, double *o) {
    double o0 = p[0] * q[0] - p[1] * q[1] - p[2] * q[2] - p[3] * q[3];
    double o1 = p[0] * q[1] + q[0] * p[1] + p[2] * q[3] - p[3] * q[2];
    double o2 = p[0] * q[2] + q[0] * p[2] + p[3] * q[1] - p[1] * q[3];
    double o3 = p[0] * q[3] + q[0] * p[3] + p[1] * q[2] - p[2] * q[1];
    o[0] = o0; o[1] = o1; o[2] = o2; o[3] = o3;
}
static double qre(const double *p, const double *q) { return p[0] * q[0] - p[1] * q[1] - p[2] * q[2] - p[3] * q[3]; }

/* cos r, A = sin r / r, B = (r cos r - sin r)/r^3, C = (3 sin r - 3 r cos r - r^2 sin r)/r^5 as series in x = r^2 */
static void series_abc(double x, double *cs, double *A, double *B, double *C) {
    double c = 1, a = 1, u = -1.0 / 6.0, w = 1.0 / 120.0;
    double sc = 1, sa = 1, sb = 2 * u, scc = 2 * 2 * 2 * w;   /* k=0 terms; B starts k=1: 2k u_k; C starts k=2: 2k(2k-2) w_k */
    for (int k = 1; k < 40; k++) {
        c *= -x / ((2.0 * k - 1) * (2.0 * k)); sc += c;
        a *= -x / ((2.0 * k) * (2.0 * k + 1)); sa += a;
        if (k >= 2) { u *= -x / ((2.0 * k) * (2.0 * k + 1)); sb += 2.0 * k * u; }
        if (k >= 3) { w *= -x / ((2.0 * k) * (2.0 * k + 1)); scc += 2.0 * k * (2.0 * k - 2) * w; }
        if (fabs(c) + fabs(a) + fabs(u) + fabs(w) < 1e-22 * (1 + fabs(sc) + fabs(sa))) break;
    }
    *cs = sc; *A = sa; *B = sb; *C = scc;
}
static void qjet(const double *ph, double *q, double dq[3][4], double d2q[3][3][4]) {
    double x = ph[0] * ph[0] + ph[1] * ph[1] + ph[2] * ph[2], cs, A, B, C;
    series_abc(x, &cs, &A, &B, &C);
    q[0] = cs; for (int k = 0; k < 3; k++) q[1 + k] = -A * ph[k];
    if (!dq) return;
    for (int a = 0; a < 3; a++) {
        dq[a][0] = -A * ph[a];
        for (int k = 0; k < 3; k++) dq[a][1 + k] = -((a == k) * A + B * ph[a] * ph[k]);
    }
    if (!d2q) return;
    for (int a = 0; a < 3; a++) for (int b = 0; b < 3; b++) {
        d2q[a][b][0] = -((a == b) * A + B * ph[a] * ph[b]);
        for (int k = 0; k < 3; k++)
            d2q[a][b][1 + k] = -(B * (ph[b] * (a == k) + ph[a] * (b == k) + (a == b) * ph[k]) + C * ph[a] * ph[b] * ph[k]);
    }
}
static double plaq_val(const double *ph) {
    double f[4][4], P[4];
    for (int i = 0; i < 4; i++) { double s[3] = {SGN[i] * ph[3 * i], SGN[i] * ph[3 * i + 1], SGN[i] * ph[3 * i + 2]}; qjet(s, f[i], NULL, NULL); }
    qm(f[0], f[1], P); qm(P, f[2], P); qm(P, f[3], P);
    return 1.0 - P[0];
}
/* the analytic Hessian of F in the 12 [EXP] coordinates */
static void plaq_hess(const double *ph, double *H) {
    double f[4][4], df[4][3][4], d2f[4][3][3][4], dqt[3][4];
    for (int i = 0; i < 4; i++) {
        double s[3] = {SGN[i] * ph[3 * i], SGN[i] * ph[3 * i + 1], SGN[i] * ph[3 * i + 2]};
        qjet(s, f[i], dqt, d2f[i]);
        for (int a = 0; a < 3; a++) for (int c = 0; c < 4; c++) df[i][a][c] = SGN[i] * dqt[a][c];
    }
    double P[5][4], S[5][4];
    P[0][0] = 1; P[0][1] = P[0][2] = P[0][3] = 0;
    for (int i = 0; i < 4; i++) qm(P[i], f[i], P[i + 1]);
    S[4][0] = 1; S[4][1] = S[4][2] = S[4][3] = 0;
    for (int i = 3; i >= 0; i--) qm(f[i], S[i + 1], S[i]);
    for (int i = 0; i < 4; i++) {
        for (int a = 0; a < 3; a++) for (int b = 0; b < 3; b++) {
            double t[4]; qm(P[i], d2f[i][a][b], t);
            H[(3 * i + a) * 12 + 3 * i + b] = -qre(t, S[i + 1]);
        }
        for (int j = i + 1; j < 4; j++) {
            double Mq[4] = {1, 0, 0, 0};
            for (int l = i + 1; l < j; l++) qm(Mq, f[l], Mq);
            double La[3][4], MR[3][4];
            for (int a = 0; a < 3; a++) qm(P[i], df[i][a], La[a]);
            for (int b = 0; b < 3; b++) { double t[4]; qm(df[j][b], S[j + 1], t); qm(Mq, t, MR[b]); }
            for (int a = 0; a < 3; a++) for (int b = 0; b < 3; b++) {
                double v = -qre(La[a], MR[b]);
                H[(3 * i + a) * 12 + 3 * j + b] = v; H[(3 * j + b) * 12 + 3 * i + a] = v;
            }
        }
    }
}
/* the cubic-vertex Hessian h1(phi) (linear in phi) */
static void cross_add(double *H, int i, int j, const double *w, double sc) {   /* H[i,j] += sc [w]_x ; H[j,i] += sc [w]_x^T */
    double X[3][3] = {{0, -w[2], w[1]}, {w[2], 0, -w[0]}, {-w[1], w[0], 0}};
    for (int a = 0; a < 3; a++) for (int b = 0; b < 3; b++) { H[(3 * i + a) * 12 + 3 * j + b] += sc * X[a][b]; H[(3 * j + b) * 12 + 3 * i + a] += sc * X[a][b]; }
}
static void plaq_h1(const double *ph, double *H) {
    memset(H, 0, 144 * sizeof(double));
    for (int t = 0; t < 4; t++) {
        int a = TRI[t][0], b = TRI[t][1], c = TRI[t][2]; double sg = SIG3[t];
        cross_add(H, a, b, ph + 3 * c, -sg); cross_add(H, a, c, ph + 3 * b, sg); cross_add(H, b, c, ph + 3 * a, -sg);
    }
}

/* ------------------------------------------------------------------ global operators */
typedef struct { const Torus *T; double *hb; } HOp;   /* per-plaquette 12x12 blocks */
static void hblocks(const Torus *T, const double *B, double *hb, int which /*0 hess, 1 h1*/) {
    double ph[12];
    for (int p = 0; p < T->nP; p++) {
        for (int i = 0; i < 4; i++) for (int a = 0; a < 3; a++) ph[3 * i + a] = B[3 * T->plaq[4 * p + i] + a];
        if (which == 0) plaq_hess(ph, hb + 144 * (size_t)p); else plaq_h1(ph, hb + 144 * (size_t)p);
    }
}
static void Hv_full(const Torus *T, const double *hb, const double *x, double *y) {   /* y = sum_p P_p^T h_p P_p x, length 3 nLk */
    memset(y, 0, sizeof(double) * 3 * T->nLk);
    double xl[12], yl[12];
    for (int p = 0; p < T->nP; p++) {
        const int *pl = T->plaq + 4 * p; const double *h = hb + 144 * (size_t)p;
        for (int i = 0; i < 4; i++) for (int a = 0; a < 3; a++) xl[3 * i + a] = x[3 * pl[i] + a];
        for (int r = 0; r < 12; r++) { double s = 0; for (int c = 0; c < 12; c++) s += h[r * 12 + c] * xl[c]; yl[r] = s; }
        for (int i = 0; i < 4; i++) for (int a = 0; a < 3; a++) y[3 * pl[i] + a] += yl[3 * i + a];
    }
}
static void Tmul(const Torus *T, const double *c, double *x) {   /* x = (T0 (x) I3) c ; c length 3k (index 3j+a) */
    int k = T->k;
    for (int l = 0; l < T->nLk; l++) for (int a = 0; a < 3; a++) {
        double s = 0; const double *row = T->T0 + (size_t)l * k; for (int j = 0; j < k; j++) s += row[j] * c[3 * j + a]; x[3 * l + a] = s;
    }
}
static void Ttmul(const Torus *T, const double *x, double *c) {   /* c = (T0 (x) I3)^T x */
    int k = T->k; memset(c, 0, sizeof(double) * 3 * k);
    for (int l = 0; l < T->nLk; l++) { const double *row = T->T0 + (size_t)l * k;
        for (int a = 0; a < 3; a++) { double v = x[3 * l + a]; if (v == 0) continue; for (int j = 0; j < k; j++) c[3 * j + a] += row[j] * v; } }
}
typedef struct { const Torus *T; const double *hb; double *z, *y; double sign; } RCtx;
static void mv_restricted(void *ctx, const double *c, double *out) {
    RCtx *R = (RCtx *)ctx; Tmul(R->T, c, R->z); Hv_full(R->T, R->hb, R->z, R->y); Ttmul(R->T, R->y, out);
    if (R->sign != 1.0) for (int i = 0; i < 3 * R->T->k; i++) out[i] *= R->sign;
}
/* lambda_min(Hess S(B)|_V) and its unit eigenvector (coefficients y, length 3k) */
static double lam_min_B(const Torus *T, const double *B, double *y, double *res) {
    int n = 3 * T->k;
    double *hb = NEW(double, 144 * (size_t)T->nP); hblocks(T, B, hb, 0);
    RCtx R = {T, hb, NEW(double, 3 * T->nLk), NEW(double, 3 * T->nLk), 1.0};
    double lm = lanczos_min(n, mv_restricted, &R, y, n < 80 ? n : 80, 1e-10, 40, res);
    free(R.z); free(R.y); free(hb);
    return lm;
}
static double supn(const Torus *T, const double *B) {
    double m = 0; for (int l = 0; l < T->nLk; l++) { double r = B[3 * l] * B[3 * l] + B[3 * l + 1] * B[3 * l + 1] + B[3 * l + 2] * B[3 * l + 2]; if (r > m) m = r; }
    return sqrt(m);
}
static double max_plaq_angle(const Torus *T, const double *B) {
    double ph[12], m = 0;
    for (int p = 0; p < T->nP; p++) {
        for (int i = 0; i < 4; i++) for (int a = 0; a < 3; a++) ph[3 * i + a] = B[3 * T->plaq[4 * p + i] + a];
        double c = 1 - plaq_val(ph); if (c > 1) c = 1; if (c < -1) c = -1; double th = acos(c); if (th > m) m = th;
    }
    return m;
}
/* m_l(v) = d/dB_l [v^T H1(B) v] */
static void m_vectors(const Torus *T, const double *v, double *mv) {
    memset(mv, 0, sizeof(double) * 3 * T->nLk);
    for (int p = 0; p < T->nP; p++) {
        const int *pl = T->plaq + 4 * p; const double *vl[4];
        for (int i = 0; i < 4; i++) vl[i] = v + 3 * pl[i];
        for (int t = 0; t < 4; t++) {
            int a = TRI[t][0], b = TRI[t][1], c = TRI[t][2]; double sg = 2.0 * SIG3[t];
            double x[3];
            x[0] = vl[a][1] * vl[b][2] - vl[a][2] * vl[b][1]; x[1] = vl[a][2] * vl[b][0] - vl[a][0] * vl[b][2]; x[2] = vl[a][0] * vl[b][1] - vl[a][1] * vl[b][0];
            for (int k = 0; k < 3; k++) mv[3 * pl[c] + k] += sg * x[k];
            x[0] = vl[c][1] * vl[a][2] - vl[c][2] * vl[a][1]; x[1] = vl[c][2] * vl[a][0] - vl[c][0] * vl[a][2]; x[2] = vl[c][0] * vl[a][1] - vl[c][1] * vl[a][0];
            for (int k = 0; k < 3; k++) mv[3 * pl[b] + k] += sg * x[k];
            x[0] = vl[b][1] * vl[c][2] - vl[b][2] * vl[c][1]; x[1] = vl[b][2] * vl[c][0] - vl[b][0] * vl[c][2]; x[2] = vl[b][0] * vl[c][1] - vl[b][1] * vl[c][0];
            for (int k = 0; k < 3; k++) mv[3 * pl[a] + k] += sg * x[k];
        }
    }
}
static double vH0v(const Torus *T, const double *v) {
    double s = 0;
    for (int p = 0; p < T->nP; p++) { const int *pl = T->plaq + 4 * p;
        for (int a = 0; a < 3; a++) { double c = 0; for (int i = 0; i < 4; i++) c += SGN[i] * v[3 * pl[i] + a]; s += c * c; } }
    return s;
}

/* ------------------------------------------------------------------ O1: the linear-box oracle, alternating maximisation */
typedef struct { const Torus *T; const double *W; double *hb, *c1, *z, *y, *c2; } O1Ctx;
static void Wmul(int k, const double *W, const double *c, double *o) {   /* (W (x) I3) c */
    for (int j = 0; j < k; j++) for (int a = 0; a < 3; a++) { double s = 0; for (int i = 0; i < k; i++) s += W[j * k + i] * c[3 * i + a]; o[3 * j + a] = s; }
}
static void mv_o1(void *ctx, const double *x, double *out) {   /* out = -(W T^T K T W) x, K = -H1(u): minimise -> top of A */
    O1Ctx *O = (O1Ctx *)ctx; const Torus *T = O->T; int k = T->k;
    Wmul(k, O->W, x, O->c1); Tmul(T, O->c1, O->z); Hv_full(T, O->hb, O->z, O->y); Ttmul(T, O->y, O->c2); Wmul(k, O->W, O->c2, out);
    /* Hv_full with h1(u) gives +H1(u) z; A = W T^T (-H1) T W, and we return -A x = +W T^T H1 T W x */
}
static double o1_run(const Torus *T, int nstart, double *ubest, int verbose) {
    int k = T->k, n = 3 * k;
    double *A0 = NEW(double, k * k), *w0 = NEW(double, k), *V0 = NEW(double, k * k), *W = NEW(double, k * k);
    restrict_mat(T, T->H0c, A0);
    jacobi(k, A0, w0, V0);
    for (int i = 0; i < k; i++) for (int j = 0; j < k; j++) { double s = 0; for (int t = 0; t < k; t++) s += V0[i * k + t] * V0[j * k + t] / sqrt(w0[t]); W[i * k + j] = s; }
    O1Ctx O = {T, W, NEW(double, 144 * (size_t)T->nP), NEW(double, n), NEW(double, 3 * T->nLk), NEW(double, 3 * T->nLk), NEW(double, n)};
    double *y = NEW(double, n), *c = NEW(double, n), *v = NEW(double, 3 * T->nLk), *mm = NEW(double, 3 * T->nLk), *u = NEW(double, 3 * T->nLk);
    double best = 0;
    for (int st = 0; st < nstart; st++) {
        for (int i = 0; i < n; i++) y[i] = rnorm();
        double told = 0, t = 0;
        for (int it = 0; it < 80; it++) {
            Wmul(k, W, y, c); Tmul(T, c, v);
            m_vectors(T, v, mm);
            double sm = 0;
            for (int l = 0; l < T->nLk; l++) {
                double r = sqrt(mm[3 * l] * mm[3 * l] + mm[3 * l + 1] * mm[3 * l + 1] + mm[3 * l + 2] * mm[3 * l + 2]); sm += r;
                for (int a = 0; a < 3; a++) u[3 * l + a] = r > 0 ? -mm[3 * l + a] / r : 0;
            }
            t = sm / vH0v(T, v);
            if (it > 0 && t - told < 1e-10 * t) break;
            told = t;
            hblocks(T, u, O.hb, 1);
            double res; lanczos_min(n, mv_o1, &O, y, n < 100 ? n : 100, 1e-10, 20, &res);
        }
        if (verbose) printf("   O1 start %2d: t = %.6f (b_lin %.5f)  [%.1f s]\n", st, t, 1 / t, wall() - T0W);
        fflush(stdout);
        if (t > best) { best = t; memcpy(ubest, u, sizeof(double) * 3 * T->nLk); }
    }
    free(A0); free(w0); free(V0); free(W); free(O.hb); free(O.c1); free(O.z); free(O.y); free(O.c2); free(y); free(c); free(v); free(mm); free(u);
    return best;
}
/* orthogonal projection onto V: P_V x = T T^T x */
static void projV(const Torus *T, const double *x, double *o) { double *c = NEW(double, 3 * T->k); Ttmul(T, x, c); Tmul(T, c, o); free(c); }

/* ------------------------------------------------------------------ ball arithmetic and the action S */
typedef struct { double m, r; } ball;
static ball bmk(double m, double r) { ball b = {m, r}; return b; }
static ball bfix(double m, double r) { ball b = {m, r * (1 + 4 * EPSB) + 1e-320}; return b; }
static ball badd(ball a, ball b) { double m = a.m + b.m; return bfix(m, a.r + b.r + EPSB * fabs(m)); }
static ball bsub(ball a, ball b) { double m = a.m - b.m; return bfix(m, a.r + b.r + EPSB * fabs(m)); }
static ball bmul(ball a, ball b) { double m = a.m * b.m; return bfix(m, fabs(a.m) * b.r + fabs(b.m) * a.r + a.r * b.r + EPSB * fabs(m)); }
static ball bdivi(ball a, double d) { double m = a.m / d; return bfix(m, a.r / fabs(d) + EPSB * fabs(m)); }   /* d an exact double */
static ball bneg(ball a) { ball b = {-a.m, a.r}; return b; }
/* cos r and sin r / r from x = r^2 (a ball, x >= 0): 24 terms + the alternating tail bound X^K/(2K)!, X^K/(2K+1)! (X <= 4) */
static void bcos_sinc(ball x, ball *cs, ball *sc) {
    double X = x.m + x.r; if (X > 4.0) { printf("REFUSED: link angle beyond 2 in a certified evaluation\n"); exit(6); }
    ball c = bmk(1, 0), a = bmk(1, 0), sumc = bmk(1, 0), suma = bmk(1, 0);
    int K = 24;
    for (int k = 1; k < K; k++) {
        c = bdivi(bneg(bmul(c, x)), (2.0 * k - 1) * (2.0 * k)); sumc = badd(sumc, c);
        a = bdivi(bneg(bmul(a, x)), (2.0 * k) * (2.0 * k + 1)); suma = badd(suma, a);
    }
    double tc = 1, ta = 1; for (int k = 1; k <= K; k++) { tc *= X / ((2.0 * k - 1) * (2.0 * k)); ta *= X / ((2.0 * k) * (2.0 * k + 1)); }
    sumc.r = (sumc.r + tc * 2) * (1 + 4 * EPSB); suma.r = (suma.r + ta * 2) * (1 + 4 * EPSB);
    *cs = sumc; *sc = suma;
}
static void bqm(const ball *p, const ball *q, ball *o) {
    ball t[4];
    t[0] = bsub(bsub(bsub(bmul(p[0], q[0]), bmul(p[1], q[1])), bmul(p[2], q[2])), bmul(p[3], q[3]));
    t[1] = bsub(badd(badd(bmul(p[0], q[1]), bmul(q[0], p[1])), bmul(p[2], q[3])), bmul(p[3], q[2]));
    t[2] = bsub(badd(badd(bmul(p[0], q[2]), bmul(q[0], p[2])), bmul(p[3], q[1])), bmul(p[1], q[3]));
    t[3] = bsub(badd(badd(bmul(p[0], q[3]), bmul(q[0], p[3])), bmul(p[1], q[2])), bmul(p[2], q[1]));
    for (int i = 0; i < 4; i++) o[i] = t[i];
}
/* S(B) per unit beta in ball arithmetic; Bb: 3 nLk balls */
static ball S_ball(const Torus *T, const ball *Bb) {
    ball *Q = NEW(ball, 4 * (size_t)T->nLk);
    for (int l = 0; l < T->nLk; l++) {
        const ball *b = Bb + 3 * l;
        ball x = badd(badd(bmul(b[0], b[0]), bmul(b[1], b[1])), bmul(b[2], b[2]));
        ball cs, sc; bcos_sinc(x, &cs, &sc);
        Q[4 * l] = cs; for (int a = 0; a < 3; a++) Q[4 * l + 1 + a] = bneg(bmul(sc, b[a]));
    }
    ball tot = bmk(0, 0);
    for (int p = 0; p < T->nP; p++) {
        const int *pl = T->plaq + 4 * p; ball P[4], C3[4], C4[4];
        for (int i = 0; i < 4; i++) { C3[i] = Q[4 * pl[2] + i]; C4[i] = Q[4 * pl[3] + i]; }
        for (int i = 1; i < 4; i++) { C3[i] = bneg(C3[i]); C4[i] = bneg(C4[i]); }
        bqm(Q + 4 * pl[0], Q + 4 * pl[1], P); bqm(P, C3, P); bqm(P, C4, P);
        tot = badd(tot, bsub(bmk(1, 0), P[0]));
    }
    free(Q); return tot;
}
static double S_float(const Torus *T, const double *B) {
    double ph[12], s = 0;
    for (int p = 0; p < T->nP; p++) { for (int i = 0; i < 4; i++) for (int a = 0; a < 3; a++) ph[3 * i + a] = B[3 * T->plaq[4 * p + i] + a]; s += plaq_val(ph); }
    return s;
}

/* exact configuration from dyadic coefficients on the free coordinates: B*_l,a = c_{j,a} (l = f_j) or -sum_j R_ij c_{j,a} (l = piv_i).
 * cint: k x 3 integers, value = cint / 2^30.  Output balls (rigorous enclosures of the exact rationals). */
static void exact_config(const Torus *T, const long long *cint, ball *Bb) {
    int k = T->k; const double SC = 1073741824.0;
    for (int l = 0; l < 3 * T->nLk; l++) Bb[l] = bmk(0, 0);
    for (int j = 0; j < k; j++) for (int a = 0; a < 3; a++) Bb[3 * T->freec[j] + a] = bmk((double)cint[3 * j + a] / SC, 0);   /* exact: |cint| < 2^53 */
    for (int i = 0; i < T->rank; i++) for (int a = 0; a < 3; a++) {
        ball s = bmk(0, 0);
        for (int j = 0; j < k; j++) {
            frac R = T->R[(size_t)i * k + j]; if (R.n == 0 || cint[3 * j + a] == 0) continue;
            double rm = (double)R.n / (double)R.d; ball rb = bmk(rm, 4 * EPSB * fabs(rm) + 1e-320);
            s = badd(s, bmul(rb, bmk((double)cint[3 * j + a] / SC, 0)));
        }
        Bb[3 * T->piv[i] + a] = bneg(s);
    }
}
static void coeffs_of(const Torus *T, const double *B, long long *cint) {   /* free coordinates of B, rounded to 2^-30 */
    for (int j = 0; j < T->k; j++) for (int a = 0; a < 3; a++) cint[3 * j + a] = llround(B[3 * T->freec[j] + a] * 1073741824.0);
}
/* the three-point certificate: returns the second difference ball; *bprime = rigorous upper bound of the three points' sup radius */
static ball three_point(const Torus *T, const long long *cB, const long long *cW, long long epsnum, long long epsden, double *bprime) {
    int k = T->k, n = 3 * T->nLk;
    long long *cp = NEW(long long, 3 * k), *cm = NEW(long long, 3 * k);
    /* B +- eps w with eps = epsnum/epsden: integer coefficients over 2^30 * epsden: we keep 2^30 scaling by requiring epsden | 2^30 */
    if ((1073741824LL % epsden) != 0) { printf("REFUSED: eps denominator must divide 2^30\n"); exit(7); }
    long long f = 1073741824LL / epsden;   /* eps * cW / 2^30 = epsnum * cW / (epsden 2^30): exact only if we rescale; use 2^30 grid */
    (void)f;
    ball *B0 = NEW(ball, n), *Bp = NEW(ball, n), *Bm = NEW(ball, n), *Wb = NEW(ball, n);
    exact_config(T, cB, B0); exact_config(T, cW, Wb);
    ball e = bdivi(bmk((double)epsnum, 0), (double)epsden);   /* exact: epsden a power of two */
    for (int i = 0; i < n; i++) { Bp[i] = badd(B0[i], bmul(e, Wb[i])); Bm[i] = bsub(B0[i], bmul(e, Wb[i])); }
    double sup2 = 0;
    ball *Ps[3] = {B0, Bp, Bm};
    for (int t = 0; t < 3; t++) for (int l = 0; l < T->nLk; l++) {
        ball x = badd(badd(bmul(Ps[t][3 * l], Ps[t][3 * l]), bmul(Ps[t][3 * l + 1], Ps[t][3 * l + 1])), bmul(Ps[t][3 * l + 2], Ps[t][3 * l + 2]));
        double up = x.m + x.r; if (up > sup2) sup2 = up;
    }
    *bprime = sqrt(sup2) * (1 + 8 * EPSB) + 1e-300;
    ball S0 = S_ball(T, B0), Sp = S_ball(T, Bp), Sm = S_ball(T, Bm);
    ball D = bsub(badd(Sp, Sm), badd(S0, S0));
    free(cp); free(cm); free(B0); free(Bp); free(Bm); free(Wb);
    return D;
}

/* ------------------------------------------------------------------ npy reader (little-endian float64, C order) */
static double *read_npy(const char *path, int *count) {
    FILE *f = fopen(path, "rb"); if (!f) { printf("REFUSED: cannot open %s\n", path); exit(8); }
    unsigned char h[10]; if (fread(h, 1, 10, f) != 10 || memcmp(h, "\x93NUMPY", 6) != 0) { printf("REFUSED: %s not npy\n", path); exit(8); }
    int hl = h[8] | (h[9] << 8); char *hdr = NEW(char, hl + 1); if ((int)fread(hdr, 1, hl, f) != hl) { printf("REFUSED: short header\n"); exit(8); }
    if (!strstr(hdr, "'<f8'") || strstr(hdr, "True")) { printf("REFUSED: %s is not little-endian float64 C-order: %s\n", path, hdr); exit(8); }
    char *sh = strstr(hdr, "'shape': ("); int tot = 1; if (sh) { sh += 10; while (*sh && *sh != ')') { if (*sh >= '0' && *sh <= '9') { tot *= (int)strtol(sh, &sh, 10); } else sh++; } }
    double *d = NEW(double, tot); if ((int)fread(d, sizeof(double), tot, f) != tot) { printf("REFUSED: short data in %s\n", path); exit(8); }
    fclose(f); free(hdr); *count = tot; return d;
}

/* ------------------------------------------------------------------ exact Taylor tensors of F at 0 (univariate series + polarisation) */
/* F(t x) = sum_n t^n F_n(x); each link factor q(s_i t x_i) has t^{2j}: ((-1)^j rho^j/(2j)!, 0) and t^{2j+1}: (0, -(-1)^j rho^j/(2j+1)! s_i x_i) */
static void Fn_exact(const long long *x, frac *Fout /* degrees 0..5 */) {
    static const long long FAC[6] = {1, 1, 2, 6, 24, 120};
    frac q[4][6][4];
    for (int i = 0; i < 4; i++) {
        long long rho = x[3 * i] * x[3 * i] + x[3 * i + 1] * x[3 * i + 1] + x[3 * i + 2] * x[3 * i + 2];
        for (int d = 0; d < 6; d++) for (int c = 0; c < 4; c++) q[i][d][c] = fint(0);
        for (int d = 0; d < 6; d++) {
            int j = d / 2; long long pw = 1; for (int t = 0; t < j; t++) pw *= rho;
            long long sgn = (j % 2) ? -1 : 1;
            if (d % 2 == 0) q[i][d][0] = fmk((i128)sgn * pw, FAC[d], "taylor");
            else for (int c = 0; c < 3; c++) q[i][d][1 + c] = fmk(-(i128)sgn * pw * SGN[i] * x[3 * i + c], FAC[d], "taylor");
        }
    }
    frac P[6][4], Nw[6][4];
    for (int d = 0; d < 6; d++) for (int c = 0; c < 4; c++) P[d][c] = q[0][d][c];
    for (int i = 1; i < 4; i++) {
        for (int d = 0; d < 6; d++) for (int c = 0; c < 4; c++) Nw[d][c] = fint(0);
        for (int d1 = 0; d1 < 6; d1++) for (int d2 = 0; d1 + d2 < 6; d2++) {
            const frac *p = P[d1], *r = q[i][d2];
            frac o0 = fsub(fsub(fsub(fmul(p[0], r[0], "t"), fmul(p[1], r[1], "t"), "t"), fmul(p[2], r[2], "t"), "t"), fmul(p[3], r[3], "t"), "t");
            frac o1 = fsub(fadd(fadd(fmul(p[0], r[1], "t"), fmul(r[0], p[1], "t"), "t"), fmul(p[2], r[3], "t"), "t"), fmul(p[3], r[2], "t"), "t");
            frac o2 = fsub(fadd(fadd(fmul(p[0], r[2], "t"), fmul(r[0], p[2], "t"), "t"), fmul(p[3], r[1], "t"), "t"), fmul(p[1], r[3], "t"), "t");
            frac o3 = fsub(fadd(fadd(fmul(p[0], r[3], "t"), fmul(r[0], p[3], "t"), "t"), fmul(p[1], r[2], "t"), "t"), fmul(p[2], r[1], "t"), "t");
            int d = d1 + d2;
            Nw[d][0] = fadd(Nw[d][0], o0, "t"); Nw[d][1] = fadd(Nw[d][1], o1, "t"); Nw[d][2] = fadd(Nw[d][2], o2, "t"); Nw[d][3] = fadd(Nw[d][3], o3, "t");
        }
        memcpy(P, Nw, sizeof P);
    }
    for (int d = 0; d < 6; d++) Fout[d] = fmk(-P[d][0].n, P[d][0].d, "taylor");
    Fout[0] = fadd(Fout[0], fint(1), "taylor");
}
/* D^n F(0)[e_{i1},...,e_{in}] = 2^-n sum_eps (prod eps) F_n(sum eps_r e_{ir}) */
static frac Dn_entry(int nd, const int *idx) {
    frac acc = fint(0);
    for (int msk = 0; msk < (1 << nd); msk++) {
        long long x[12] = {0}; int sg = 1;
        for (int r = 0; r < nd; r++) { int e = (msk >> r) & 1 ? -1 : 1; sg *= e; x[idx[r]] += e; }
        frac F[6]; Fn_exact(x, F);
        acc = sg > 0 ? fadd(acc, F[nd], "polar") : fsub(acc, F[nd], "polar");
    }
    return fmk(acc.n, acc.d * ((i128)1 << nd), "polar");
}

/* ------------------------------------------------------------------ the climb (item 2) */
typedef struct { const Torus *T; double s, p; } ClimbP;
static double pnorm(const Torus *T, const double *B, double p) {
    double m = supn(T, B); if (m == 0) return 0; double s = 0;
    for (int l = 0; l < T->nLk; l++) { double r = sqrt(B[3 * l] * B[3 * l] + B[3 * l + 1] * B[3 * l + 1] + B[3 * l + 2] * B[3 * l + 2]) / m; s += pow(r, p); }
    return m * pow(s, 1.0 / p);
}
static void scale_to(const Torus *T, double *c, double s, double p) {   /* c (3k) scaled so that the p-norm of B = T c equals s */
    double *B = NEW(double, 3 * T->nLk); Tmul(T, c, B); double pn = pnorm(T, B, p);
    for (int i = 0; i < 3 * T->k; i++) c[i] *= s / pn; free(B);
}
/* gradient of lambda_min wrt c: Tt [H(B + h w) w - H(B - h w) w]/(2h) */
static void grad_lmin(const Torus *T, const double *B, const double *y, double *g) {
    int n3 = 3 * T->nLk; double h = 1e-4;
    double *w = NEW(double, n3), *Bp = NEW(double, n3), *Bm = NEW(double, n3), *hb = NEW(double, 144 * (size_t)T->nP), *y1 = NEW(double, n3), *y2 = NEW(double, n3);
    Tmul(T, y, w);
    for (int i = 0; i < n3; i++) { Bp[i] = B[i] + h * w[i]; Bm[i] = B[i] - h * w[i]; }
    hblocks(T, Bp, hb, 0); Hv_full(T, hb, w, y1);
    hblocks(T, Bm, hb, 0); Hv_full(T, hb, w, y2);
    for (int i = 0; i < n3; i++) y1[i] = (y1[i] - y2[i]) / (2 * h);
    Ttmul(T, y1, g);
    free(w); free(Bp); free(Bm); free(hb); free(y1); free(y2);
}
/* gradient of the p-norm wrt c */
static void grad_pnorm(const Torus *T, const double *B, double p, double *g) {
    int n3 = 3 * T->nLk; double *gl = NEW(double, n3); double P = pnorm(T, B, p), m = supn(T, B);
    for (int l = 0; l < T->nLk; l++) {
        double r = sqrt(B[3 * l] * B[3 * l] + B[3 * l + 1] * B[3 * l + 1] + B[3 * l + 2] * B[3 * l + 2]);
        if (r == 0) continue;
        double f = pow(r / m, p - 2) * pow(m / P, p - 1) / m;   /* |B_l|^{p-2} B_l / P^{p-1} */
        for (int a = 0; a < 3; a++) gl[3 * l + a] = f * B[3 * l + a];
    }
    Ttmul(T, gl, g); free(gl);
}
/* climb at fixed p-norm s from coefficients c (in/out); returns lambda_min; y in/out eigenvector */
static double climb_at(const Torus *T, double *c, double s, double p, int nit, double *y, int verbose) {
    int n = 3 * T->k, n3 = 3 * T->nLk;
    double *B = NEW(double, n3), *g = NEW(double, n), *gp = NEW(double, n), *cn = NEW(double, n), *yn = NEW(double, n), *Bn = NEW(double, n3);
    scale_to(T, c, s, p); Tmul(T, c, B);
    double res, lam = lam_min_B(T, B, y, &res), eta = 0.05 * s;
    for (int it = 0; it < nit; it++) {
        grad_lmin(T, B, y, g); grad_pnorm(T, B, p, gp);
        double gg = dot(n, g, gp) / dot(n, gp, gp);
        for (int i = 0; i < n; i++) g[i] -= gg * gp[i];
        double gn = nrm(n, g); if (gn < 1e-14) break;
        int acc = 0;
        for (int ls = 0; ls < 12; ls++) {
            for (int i = 0; i < n; i++) cn[i] = c[i] - eta * g[i] / gn * nrm(n, c);
            scale_to(T, cn, s, p); Tmul(T, cn, Bn); memcpy(yn, y, sizeof(double) * n);
            double ln = lam_min_B(T, Bn, yn, &res);
            if (ln < lam - 1e-12) { memcpy(c, cn, sizeof(double) * n); memcpy(B, Bn, sizeof(double) * n3); memcpy(y, yn, sizeof(double) * n); lam = ln; eta *= 1.5; acc = 1; break; }
            eta *= 0.4;
        }
        if (!acc || eta < 1e-7) break;
        if (verbose && it % 20 == 0) { printf("      it %3d lambda_min %.6f eta %.2e sup %.5f [%.0f s]\n", it, lam, eta, supn(T, B), wall() - T0W); fflush(stdout); }
    }
    free(B); free(g); free(gp); free(cn); free(yn); free(Bn);
    return lam;
}

/* ------------------------------------------------------------------ helpers for families */
static void family_seed(const Torus *T, const char *fam, double *Bhat) {
    int n3 = 3 * T->nLk; double *x = NEW(double, n3);
    if (!strcmp(fam, "o1")) {
        double t = o1_run(T, T->L == 2 ? 16 : 12, x, 1);
        printf("   O1 (C): t* = %.6f -> b_lin = %.6f\n", t, 1 / t);
    } else if (!strcmp(fam, "link0") || !strcmp(fam, "link1")) {   /* single link: (x = 0, mu) along e3 */
        int mu = fam[4] - '0'; x[3 * mu + 2] = 1.0;
    } else if (!strcmp(fam, "plaqA")) {   /* plaquette (x = 0; 0,1) curl pattern along e3 (abelian) */
        for (int i = 0; i < 4; i++) x[3 * T->plaq[4 * 0 + i] + 2] = SGN[i];
    } else if (!strcmp(fam, "plaqN")) {   /* plaquette (x = 0; 0,1), links along e1, e2, e1, e2 with the curl signs (non-abelian) */
        int col[4] = {0, 1, 0, 1};
        for (int i = 0; i < 4; i++) x[3 * T->plaq[4 * 0 + i] + col[i]] = SGN[i];
    } else if (!strncmp(fam, "file:", 5)) {   /* warm start from a written configuration (midpoints of its exact enclosure) */
        FILE *f = fopen(fam + 5, "r"); int Lf, kf; double lmf, supf;
        if (!f || fscanf(f, "L %d k %d lambda_min %lf sup %lf\n", &Lf, &kf, &lmf, &supf) != 4 || Lf != T->L || kf != T->k) { printf("REFUSED: seed file %s\n", fam + 5); exit(9); }
        long long *cB = NEW(long long, 3 * T->k), cw; for (int i = 0; i < 3 * T->k; i++) if (fscanf(f, "%lld %lld", &cB[i], &cw) != 2) { printf("REFUSED: short seed\n"); exit(9); }
        fclose(f); ball *bb = NEW(ball, n3); exact_config(T, cB, bb); for (int i = 0; i < n3; i++) x[i] = bb[i].m; free(bb); free(cB);
        const char *nz = getenv("CVX_NOISE"); if (nz) { double a = atof(nz), s0 = supn(T, x); for (int i = 0; i < n3; i++) x[i] += a * s0 * rnorm(); printf("   seed noise %.3f x sup\n", a); }
    } else { printf("REFUSED: unknown family %s\n", fam); exit(9); }
    projV(T, x, Bhat);
    double sn = supn(T, Bhat); for (int i = 0; i < n3; i++) Bhat[i] /= sn;
    printf("   family %s: |P_V x|/|x| = %.4f; seed normalised to sup norm 1\n", fam, sn > 0 ? nrm(n3, Bhat) * sn / nrm(n3, x) : 0);
    free(x);
}

/* ------------------------------------------------------------------ the per-link star majorant */
typedef struct {
    int *n;          /* support size per link (the link itself included) */
    int **idx;       /* support links, sorted */
    int *np;         /* plaquettes containing the link (6) */
    int **pl, **pc;  /* plaquette ids and the link's position c in each */
    int **loc;       /* for each (link, plaquette t): the star-local index of the plaquette's 4 links */
    double **T;      /* s x s real antisymmetric: K_l = -i T_l, T_l = sum_{p contains l} P_p^T (Om^(c)/2) P_p */
} Star;
static void build_stars(const Torus *T, Star *S) {
    int nL = T->nLk;
    S->n = NEW(int, nL); S->idx = NEW(int *, nL); S->np = NEW(int, nL); S->pl = NEW(int *, nL); S->pc = NEW(int *, nL); S->loc = NEW(int *, nL); S->T = NEW(double *, nL);
    for (int l = 0; l < nL; l++) { S->pl[l] = NEW(int, 8); S->pc[l] = NEW(int, 8); }
    for (int p = 0; p < T->nP; p++) for (int c = 0; c < 4; c++) { int l = T->plaq[4 * p + c]; if (S->np[l] >= 8) { printf("REFUSED: link in more than 8 plaquettes\n"); exit(30); } S->pl[l][S->np[l]] = p; S->pc[l][S->np[l]] = c; S->np[l]++; }
    for (int l = 0; l < nL; l++) {
        int tmp[64], m = 0;
        for (int t = 0; t < S->np[l]; t++) for (int i = 0; i < 4; i++) { int x = T->plaq[4 * S->pl[l][t] + i], seen = 0; for (int j = 0; j < m; j++) if (tmp[j] == x) seen = 1; if (!seen) tmp[m++] = x; }
        for (int i = 0; i < m; i++) for (int j = i + 1; j < m; j++) if (tmp[j] < tmp[i]) { int t2 = tmp[i]; tmp[i] = tmp[j]; tmp[j] = t2; }
        S->n[l] = m; S->idx[l] = NEW(int, m); memcpy(S->idx[l], tmp, sizeof(int) * m);
        S->loc[l] = NEW(int, 4 * S->np[l]);
        for (int t = 0; t < S->np[l]; t++) for (int i = 0; i < 4; i++) { int x = T->plaq[4 * S->pl[l][t] + i]; for (int j = 0; j < m; j++) if (tmp[j] == x) S->loc[l][4 * t + i] = j; }
        S->T[l] = NEW(double, m * m);
        for (int t = 0; t < S->np[l]; t++) { int c = S->pc[l][t];
            for (int tr = 0; tr < 4; tr++) {
                int a = TRI[tr][0], b = TRI[tr][1], cc = TRI[tr][2], i, j; double sg = SIG3[tr];
                if (cc == c) { i = a; j = b; } else if (b == c) { i = cc; j = a; } else if (a == c) { i = b; j = cc; } else continue;
                int li = S->loc[l][4 * t + i], lj = S->loc[l][4 * t + j];
                S->T[l][li * m + lj] += sg; S->T[l][lj * m + li] -= sg;     /* Om/2 with Om[i][j] += 2 sg */
            } }
    }
}
static void star_embed(int s, const double *q, const double *Tm, double *E) {   /* [[q, -T],[T, q]] */
    int n = 2 * s;
    for (int i = 0; i < s; i++) for (int j = 0; j < s; j++) {
        E[i * n + j] = q[i * s + j]; E[(i + s) * n + j + s] = q[i * s + j];
        E[i * n + j + s] = -Tm[i * s + j]; E[(i + s) * n + j] = Tm[i * s + j];
    }
}
/* q_l = Y_l - lambda_min(E(Y_l)) I; nu = lambda_max(W T0^T Qt T0 W) by Lanczos; returns nu and fills g = T0 W z (top vector) */
typedef struct { const Torus *T; const double *W; const double *Qt; double *a, *b, *c; } NuCtx;
static void mv_nu(void *ctx, const double *x, double *y) {   /* y = -(W T0^T Qt T0 W) x */
    NuCtx *N = (NuCtx *)ctx; const Torus *T = N->T; int k = T->k, n = T->nLk;
    for (int i = 0; i < k; i++) { double s = 0; for (int j = 0; j < k; j++) s += N->W[i * k + j] * x[j]; N->a[i] = s; }
    for (int l = 0; l < n; l++) { double s = 0; const double *r = T->T0 + (size_t)l * k; for (int j = 0; j < k; j++) s += r[j] * N->a[j]; N->b[l] = s; }
    for (int l = 0; l < n; l++) { double s = 0; const double *r = N->Qt + (size_t)l * n; for (int m = 0; m < n; m++) if (r[m] != 0) s += r[m] * N->b[m]; N->c[l] = s; }
    for (int j = 0; j < k; j++) { double s = 0; for (int l = 0; l < n; l++) s += T->T0[(size_t)l * k + j] * N->c[l]; N->a[j] = s; }
    for (int i = 0; i < k; i++) { double s = 0; for (int j = 0; j < k; j++) s += N->W[i * k + j] * N->a[j]; y[i] = -s; }
}
static double star_nu(const Torus *T, const Star *S, double **Y, double **q, double **e1, double **e2, double *Qt, const double *W, double *z, double *g) {
    int nL = T->nLk, k = T->k;
    memset(Qt, 0, sizeof(double) * nL * nL);
    for (int l = 0; l < nL; l++) {
        int s = S->n[l], n2 = 2 * s; double *E = NEW(double, n2 * n2), *w = NEW(double, n2), *V = NEW(double, n2 * n2);
        star_embed(s, Y[l], S->T[l], E); jacobi(n2, E, w, V);
        double lm = w[0];
        for (int i = 0; i < s; i++) for (int j = 0; j < s; j++) q[l][i * s + j] = Y[l][i * s + j] - (i == j ? lm : 0);
        for (int i = 0; i < s; i++) { e1[l][i] = V[i * n2 + 0]; e2[l][i] = V[(i + s) * n2 + 0]; }
        for (int i = 0; i < s; i++) for (int j = 0; j < s; j++) Qt[(size_t)S->idx[l][i] * nL + S->idx[l][j]] += q[l][i * s + j];
        free(E); free(w); free(V);
    }
    NuCtx N = {T, W, Qt, NEW(double, k), NEW(double, nL), NEW(double, nL)};
    double res; double nu = -lanczos_min(k, mv_nu, &N, z, k < 90 ? k : 90, 1e-10, 30, &res);
    double *a = NEW(double, k);
    for (int i = 0; i < k; i++) { double s = 0; for (int j = 0; j < k; j++) s += W[i * k + j] * z[j]; a[i] = s; }
    for (int l = 0; l < nL; l++) { double s = 0; const double *r = T->T0 + (size_t)l * k; for (int j = 0; j < k; j++) s += r[j] * a[j]; g[l] = s; }
    free(a); free(N.a); free(N.b); free(N.c);
    return nu;
}

/* ------------------------------------------------------------------ MAIN */
int main(int argc, char **argv) {
    T0W = wall();
    for (int t = 0; t < 4; t++) SIG3[t] = -SGN[TRI[t][0]] * SGN[TRI[t][1]] * SGN[TRI[t][2]];
    if (getenv("CVX_SEED")) RS = strtoull(getenv("CVX_SEED"), NULL, 10);
    printf("cmd:"); for (int i = 0; i < argc; i++) printf(" %s", argv[i]);
    printf("  (CVX_SEED=%s CVX_NOISE=%s)\n", getenv("CVX_SEED") ? getenv("CVX_SEED") : "-", getenv("CVX_NOISE") ? getenv("CVX_NOISE") : "-");
    if (argc < 3) { printf("usage: see header\n"); return 1; }
    const char *mode = argv[1]; int L = atoi(argv[2]);
    Torus T; torus_build(&T, L);
    int n3 = 3 * T.nLk, k = T.k;
    printf("torus (%d,%d,%d,%d), L = %d: sites %d, links %d, plaquettes %d; constraints %d (Q %d + gauge %d), exact rank %d, dim V0 = %d  [%.1f s]\n",
           T.e[0], T.e[1], T.e[2], T.e[3], L, T.nS, T.nLk, T.nP, T.m, T.nQ, T.nG, T.rank, k, wall() - T0W);
    { long long nz = check_C0K(&T); printf("exact check C0 K = 0 over the rationals: %lld nonzero entries (%s)  [%.1f s]\n", nz, nz ? "FAILED" : "EXACT", wall() - T0W);
      if (nz) return 10; }
    { long long qg = 0; for (int i = 0; i < T.nQ; i++) for (int g = 0; g < T.nG; g++) { long long s = 0; for (int l = 0; l < T.nLk; l++) s += (long long)T.Q0[(size_t)i * T.nLk + l] * T.G0[(size_t)g * T.nLk + l]; if (s) qg++; }
      int mx = 0; for (int i = 0; i < T.nQ * T.nLk; i++) if (abs(T.Q0[i]) > mx) mx = abs(T.Q0[i]);
      printf("Q0 G0 = 0 in integers: %lld nonzero entries; max |Q0| = %d (SCALE %d)\n", qg, mx, L * L * L * L * 24); }
    { int cnt = 0, ok = 1; int *pt = NEW(int, T.nLk); for (int p = 0; p < T.nP; p++) for (int i = 0; i < 4; i++) { pt[T.plaq[4 * p + i]]++; for (int j = 0; j < i; j++) if (T.plaq[4 * p + i] == T.plaq[4 * p + j]) ok = 0; }
      for (int l = 0; l < T.nLk; l++) if (pt[l] != 6) cnt++;
      printf("every link in exactly six plaquettes, four distinct links per plaquette: %s\n", (cnt == 0 && ok) ? "OK" : "FAILED"); free(pt); }

    if (!strcmp(mode, "kat")) {
        /* free gap per colour (Jacobi on T0^T H0c T0) */
        double *A0 = NEW(double, k * k);
        restrict_mat(&T, T.H0c, A0);
        double *w0 = NEW(double, k), *V0 = NEW(double, k * k); jacobi(k, A0, w0, V0);
        printf("per-colour free slice spectrum: %.10f %.10f %.10f %.10f %.10f %.10f ...  [%.1f s]\n", w0[0], w0[1], w0[2], w0[3], w0[4], w0[5], wall() - T0W);
        double *B = NEW(double, n3), *y = NEW(double, 3 * k), res;
        for (int i = 0; i < 3 * k; i++) y[i] = rnorm();
        double lm0 = lam_min_B(&T, B, y, &res);
        printf("full 3-colour slice at B = 0, assembled analytic Hessian, Lanczos: lambda_min = %.10f (residual %.1e)\n", lm0, res);
        /* plaquette KATs */
        double ph[12], H[144], H1[144], Hp[144], Hm[144], worst = 0, worst1 = 0, worstv = 0;
        for (int smp = 0; smp < 200; smp++) {
            for (int i = 0; i < 12; i++) ph[i] = (runif() * 2 - 1) * 0.6;
            plaq_hess(ph, H);
            /* finite-difference Hessian of plaq_val (central, step 1e-4) */
            double hh = 1e-4;
            for (int a = 0; a < 12; a++) for (int b = 0; b < 12; b++) {
                double q[12]; double f[4];
                for (int s1 = 0; s1 < 4; s1++) { memcpy(q, ph, sizeof q); q[a] += (s1 & 1 ? -hh : hh); q[b] += (s1 & 2 ? -hh : hh); f[s1] = plaq_val(q); }
                double fd = (f[0] - f[1] - f[2] + f[3]) / (4 * hh * hh);
                if (fabs(fd - H[a * 12 + b]) > worst) worst = fabs(fd - H[a * 12 + b]);
            }
            double t = 1e-4, pp[12], pm[12];
            for (int i = 0; i < 12; i++) { pp[i] = t * ph[i]; pm[i] = -t * ph[i]; }
            plaq_hess(pp, Hp); plaq_hess(pm, Hm); plaq_h1(ph, H1);
            for (int i = 0; i < 144; i++) { double d = fabs((Hp[i] - Hm[i]) / (2 * t) - H1[i]); if (d > worst1) worst1 = d; }
            double v = plaq_val(ph); double v2 = 0; { double f[4][4], P[4]; for (int i = 0; i < 4; i++) { double s[3] = {SGN[i] * ph[3 * i], SGN[i] * ph[3 * i + 1], SGN[i] * ph[3 * i + 2]};
                double r = sqrt(s[0] * s[0] + s[1] * s[1] + s[2] * s[2]); f[i][0] = cos(r); for (int c = 0; c < 3; c++) f[i][1 + c] = -(r > 0 ? sin(r) / r : 1) * s[c]; }
                qm(f[0], f[1], P); qm(P, f[2], P); qm(P, f[3], P); v2 = 1 - P[0]; }
            if (fabs(v - v2) > worstv) worstv = fabs(v - v2);
        }
        printf("plaquette KAT (200 random phi, |phi_i^a| <= 0.6): F series vs libm %.2e; analytic Hessian vs finite differences %.2e; h1 vs central difference of h(t phi) %.2e\n", worstv, worst, worst1);
        /* H(0) assembled equals kron(H0c, I3) */
        { double *hb = NEW(double, 144 * (size_t)T.nP); memset(B, 0, sizeof(double) * n3); hblocks(&T, B, hb, 0);
          double *x = NEW(double, n3), *yy = NEW(double, n3), dm = 0;
          for (int trial = 0; trial < 5; trial++) { for (int i = 0; i < n3; i++) x[i] = rnorm(); Hv_full(&T, hb, x, yy);
            for (int l = 0; l < T.nLk; l++) for (int a = 0; a < 3; a++) { double s = 0; for (int m = 0; m < T.nLk; m++) s += T.H0c[(size_t)l * T.nLk + m] * x[3 * m + a]; if (fabs(s - yy[3 * l + a]) > dm) dm = fabs(s - yy[3 * l + a]); } }
          printf("assembled H(0) x vs kron(curl^T curl, I3) x on 5 random x: %.1e\n", dm); free(hb); free(x); free(yy); }
        /* O1 */
        double *u = NEW(double, n3);
        double t = o1_run(&T, L == 2 ? 16 : 12, u, 1);
        printf("O1 (C): t* = %.6f -> b_lin = %.6f   (Python anchor: %s)  [%.1f s]\n", t, 1 / t, L == 2 ? "4.071829" : "4.939235", wall() - T0W);
        double *Pu = NEW(double, n3); projV(&T, u, Pu);
        double sn = supn(&T, Pu);
        printf("   |P_V u|/|u| = %.4f; sup norm of P_V u = %.4f\n", nrm(n3, Pu) / nrm(n3, u), sn);
        for (int i = 0; i < n3; i++) Pu[i] /= sn;
        double ss[8] = {0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55};
        for (int si = 0; si < 8; si++) {
            for (int i = 0; i < n3; i++) B[i] = ss[si] * Pu[i];
            for (int i = 0; i < 3 * k; i++) y[i] = rnorm();
            double lm = lam_min_B(&T, B, y, &res);
            printf("   projected O1 ray, sup norm %.3f: lambda_min = % .6f (max plaquette angle %.4f)\n", ss[si], lm, max_plaq_angle(&T, B));
        }
        /* the Python three-point anchor (L = 2) */
        if (L == 2 && argc >= 4) {
            int cnt; double *Bpy = read_npy(argv[3], &cnt);
            if (cnt != n3) { printf("REFUSED: anchor size %d != %d\n", cnt, n3); return 11; }
            double *c = NEW(double, 3 * k); Ttmul(&T, Bpy, c); double *Bv = NEW(double, n3); Tmul(&T, c, Bv);
            double dv = 0; for (int i = 0; i < n3; i++) if (fabs(Bv[i] - Bpy[i]) > dv) dv = fabs(Bv[i] - Bpy[i]);
            for (int i = 0; i < 3 * k; i++) y[i] = rnorm();
            double lm = lam_min_B(&T, Bpy, y, &res);
            printf("anchor rec/upper_L2_B.npy: distance from V %.1e; sup norm %.6f; lambda_min (C) = %.6f (Python: -0.22347)\n", dv, supn(&T, Bpy), lm);
            long long *cB = NEW(long long, 3 * k), *cW = NEW(long long, 3 * k);
            double *wl = NEW(double, n3); Tmul(&T, y, wl);
            coeffs_of(&T, Bpy, cB); coeffs_of(&T, wl, cW);
            long long eps[2][2] = {{1, 50}, {1, 100}};
            for (int e = 0; e < 2; e++) {
                /* eps = 1/50 is not dyadic: the Python used Fraction(1,50); here eps enters as a ball (1/50 rounded, radius included) */
                double bp; ball D;
                {   /* general eps ball */
                    int nn = 3 * T.nLk;
                    ball *B0 = NEW(ball, nn), *Bp = NEW(ball, nn), *Bm = NEW(ball, nn), *Wb = NEW(ball, nn);
                    exact_config(&T, cB, B0); exact_config(&T, cW, Wb);
                    ball ee = bdivi(bmk((double)eps[e][0], 0), (double)eps[e][1]);
                    for (int i = 0; i < nn; i++) { Bp[i] = badd(B0[i], bmul(ee, Wb[i])); Bm[i] = bsub(B0[i], bmul(ee, Wb[i])); }
                    double sup2 = 0; ball *Ps[3] = {B0, Bp, Bm};
                    for (int tt = 0; tt < 3; tt++) for (int l = 0; l < T.nLk; l++) { ball x = badd(badd(bmul(Ps[tt][3 * l], Ps[tt][3 * l]), bmul(Ps[tt][3 * l + 1], Ps[tt][3 * l + 1])), bmul(Ps[tt][3 * l + 2], Ps[tt][3 * l + 2])); if (x.m + x.r > sup2) sup2 = x.m + x.r; }
                    bp = sqrt(sup2) * (1 + 8 * EPSB);
                    ball S0 = S_ball(&T, B0), Sp = S_ball(&T, Bp), Sm = S_ball(&T, Bm);
                    D = bsub(badd(Sp, Sm), badd(S0, S0));
                    free(B0); free(Bp); free(Bm); free(Wb);
                }
                printf("   eps = %lld/%lld: second difference in [%.12e, %.12e] (ball arithmetic); three points' sup link radius <= %.10f -> %s\n",
                       eps[e][0], eps[e][1], D.m - D.r, D.m + D.r, bp, (D.m + D.r < 0) ? "NOT CONVEX on D_b' (certified)" : "not certified");
            }
            printf("   (Python anchor: -8.938191126e-5 at 1/50 within 0.402713655250; -2.2346419337e-5 at 1/100 within 0.401325199469)\n");
        }
        printf("KAT done [%.1f s]\n", wall() - T0W);
        return 0;
    }

    if (!strcmp(mode, "climb")) {
        /* cvx climb L fam s1,s2,... outprefix nit */
        const char *fam = argv[3]; const char *outp = argc > 5 ? argv[5] : "climb"; int nit = argc > 6 ? atoi(argv[6]) : 150;
        double sl[64]; int ns = 0; { char *s = strdup(argv[4]), *tok = strtok(s, ","); while (tok && ns < 64) { sl[ns++] = atof(tok); tok = strtok(NULL, ","); } }
        double *Bhat = NEW(double, n3); family_seed(&T, fam, Bhat);
        double *B = NEW(double, n3), *y = NEW(double, 3 * k), res;
        /* the ray scan */
        printf("   the ray s * seed:\n");
        double sray = -1, lprev = 0, sprev = 0;
        for (int si = 0; si < 40; si++) {
            double s = 0.05 * (si + 1); for (int i = 0; i < n3; i++) B[i] = s * Bhat[i];
            for (int i = 0; i < 3 * k; i++) y[i] = rnorm();
            double lm = lam_min_B(&T, B, y, &res);
            printf("      ray sup %.3f: lambda_min = % .6f (max plaquette angle %.4f)\n", s, lm, max_plaq_angle(&T, B)); fflush(stdout);
            if (lm < 0 && sray < 0) { sray = sprev + (s - sprev) * lprev / (lprev - lm); break; }
            lprev = lm; sprev = s;
            if (s > 1.95) break;
        }
        printf("   ray crossing (linear interpolation, READING): %.5f\n", sray);
        /* climbs at the requested sup norms (p-norm held), from the seed scaled */
        double *c = NEW(double, 3 * k); Ttmul(&T, Bhat, c);
        double p = 64;
        for (int si = 0; si < ns; si++) {
            double s = sl[si];
            for (int i = 0; i < 3 * k; i++) y[i] = rnorm();
            double lm = climb_at(&T, c, s, p, nit, y, 1);
            Tmul(&T, c, B);
            printf("   CLIMB at p-norm %.4f: lambda_min = % .6f, actual sup norm %.6f, max plaquette angle %.4f  [%.0f s]\n", s, lm, supn(&T, B), max_plaq_angle(&T, B), wall() - T0W);
            char fn[512]; snprintf(fn, sizeof fn, "%s_s%.4f.cfg", outp, s);
            FILE *f = fopen(fn, "w");
            if (f) { long long *cB = NEW(long long, 3 * k), *cW = NEW(long long, 3 * k); double *wl = NEW(double, n3); Tmul(&T, y, wl);
                coeffs_of(&T, B, cB); coeffs_of(&T, wl, cW);
                fprintf(f, "L %d k %d lambda_min %.12e sup %.12e\n", L, k, lm, supn(&T, B));
                for (int i = 0; i < 3 * k; i++) fprintf(f, "%lld %lld\n", cB[i], cW[i]);
                fclose(f); free(cB); free(cW); free(wl); printf("      configuration written: %s\n", fn); }
            fflush(stdout);
        }
        printf("climb done [%.1f s]\n", wall() - T0W);
        return 0;
    }

    if (!strcmp(mode, "cert3")) {
        /* cvx cert3 L cfgfile epsden1,epsden2,... (eps = 1/epsden, epsden a power of two) */
        FILE *f = fopen(argv[3], "r"); if (!f) { printf("REFUSED: no config %s\n", argv[3]); return 12; }
        int Lf, kf; double lmf, supf; if (fscanf(f, "L %d k %d lambda_min %lf sup %lf\n", &Lf, &kf, &lmf, &supf) != 4 || Lf != L || kf != k) { printf("REFUSED: config header\n"); return 12; }
        long long *cB = NEW(long long, 3 * k), *cW = NEW(long long, 3 * k);
        for (int i = 0; i < 3 * k; i++) if (fscanf(f, "%lld %lld", &cB[i], &cW[i]) != 2) { printf("REFUSED: short config\n"); return 12; }
        fclose(f);
        printf("config %s: recorded lambda_min %.6f at sup %.6f; exact point B* = K c (C0 K = 0 checked exactly above)\n", argv[3], lmf, supf);
        char *s = strdup(argv[4]), *tok = strtok(s, ",");
        while (tok) {
            long long ed = atoll(tok); double bp; ball D = three_point(&T, cB, cW, 1, ed, &bp);
            printf("   eps = 1/%lld: second difference S(B*+eps w) + S(B*-eps w) - 2 S(B*) in [%.12e, %.12e]; sup link radius of the three points <= %.10f -> %s\n",
                   ed, D.m - D.r, D.m + D.r, bp, (D.m + D.r < 0) ? "CERTIFIED: S is NOT convex on D_b'" : "not certified");
            fflush(stdout);
            tok = strtok(NULL, ",");
        }
        printf("cert3 done [%.1f s]\n", wall() - T0W);
        return 0;
    }

    if (!strcmp(mode, "star")) {
        /* cvx star L blocks.npy niter outfile : THE PER-LINK STAR MAJORANT (Lemma M on the star of a link, every plaquette's phase shared) */
        int niter = atoi(argv[4]); const char *outf = argv[5];
        Star St; build_stars(&T, &St);
        int smax = 0; long long tot = 0; for (int l = 0; l < T.nLk; l++) { if (St.n[l] > smax) smax = St.n[l]; tot += St.n[l]; }
        printf("stars: max support %d links, mean %.2f (the link itself included; its row of T is zero)\n", smax, (double)tot / T.nLk);
        /* KAT: M_l(e3)[v] = sum_{p contains l} h1(e3 at position c)[v_p] == 2 a^T T_l b, a = v^1, b = v^2 on the star */
        { double worst = 0, ph[12], H1[144], xl[12];
          for (int trial = 0; trial < 20; trial++) {
              int l = (int)(runif() * T.nLk); double *v = NEW(double, n3); for (int i = 0; i < n3; i++) v[i] = rnorm();
              double lhs = 0;
              for (int t = 0; t < St.np[l]; t++) { int p = St.pl[l][t], c = St.pc[l][t]; memset(ph, 0, sizeof ph); ph[3 * c + 2] = 1; plaq_h1(ph, H1);
                  for (int i = 0; i < 4; i++) for (int a = 0; a < 3; a++) xl[3 * i + a] = v[3 * T.plaq[4 * p + i] + a];
                  for (int r = 0; r < 12; r++) for (int cc = 0; cc < 12; cc++) lhs += xl[r] * H1[r * 12 + cc] * xl[cc]; }
              double rhs = 0; int s = St.n[l];
              for (int i = 0; i < s; i++) for (int j = 0; j < s; j++) rhs += 2 * v[3 * St.idx[l][i]] * St.T[l][i * s + j] * v[3 * St.idx[l][j] + 1];
              if (fabs(lhs - rhs) > worst) worst = fabs(lhs - rhs); free(v);
          }
          printf("KAT: |M_l(e3)[v] - 2 a^T T_l b| max over 20 random (l, v) = %.2e\n", worst); if (worst > 1e-10) { printf("REFUSED: star KAT\n"); return 20; } }
        /* initial q_l from the 4-block majorant: q_l = sum_{p contains l} P_p^T x^(c_p(l)) P_p on the star */
        int cnt; double *raw = read_npy(argv[3], &cnt); if (cnt != 64) { printf("REFUSED: blocks file\n"); return 13; }
        double **Y = NEW(double *, T.nLk);
        for (int l = 0; l < T.nLk; l++) { int s = St.n[l]; Y[l] = NEW(double, s * s);
            for (int t = 0; t < St.np[l]; t++) { int p = St.pl[l][t], c = St.pc[l][t];
                for (int i = 0; i < 4; i++) for (int j = 0; j < 4; j++) { int a = St.loc[l][4 * t + i], b = St.loc[l][4 * t + j]; Y[l][a * s + b] += raw[c * 16 + i * 4 + j]; } } }
        double *Qt = NEW(double, (size_t)T.nLk * T.nLk), *Hr = NEW(double, k * k), *W = NEW(double, k * k);
        restrict_mat(&T, T.H0c, Hr);
        { double *w = NEW(double, k), *V = NEW(double, k * k); jacobi(k, Hr, w, V);
          for (int i = 0; i < k; i++) for (int j = 0; j < k; j++) { double s = 0; for (int t = 0; t < k; t++) s += V[i * k + t] * V[j * k + t] / sqrt(w[t]); W[i * k + j] = s; }
          free(w); free(V); }
        double **q = NEW(double *, T.nLk), **e1 = NEW(double *, T.nLk), **e2 = NEW(double *, T.nLk);
        for (int l = 0; l < T.nLk; l++) { q[l] = NEW(double, St.n[l] * St.n[l]); e1[l] = NEW(double, St.n[l]); e2[l] = NEW(double, St.n[l]); }
        double *g = NEW(double, T.nLk), *z = NEW(double, k);
        for (int i = 0; i < k; i++) z[i] = rnorm();
        double nu0 = star_nu(&T, &St, Y, q, e1, e2, Qt, W, z, g);
        printf("initial (the 4-block majorant spread onto the stars): nu = %.6f (the block chain's nu 12.099701 at L = 2)  [%.1f s]\n", nu0, wall() - T0W);
        double best = nu0; double **Yb = NEW(double *, T.nLk); for (int l = 0; l < T.nLk; l++) { Yb[l] = NEW(double, St.n[l] * St.n[l]); memcpy(Yb[l], Y[l], sizeof(double) * St.n[l] * St.n[l]); }
        double eta = 0.05;
        for (int it = 1; it <= niter; it++) {
            /* subgradient: G_l = g_l g_l^T - |g_l|^2 (e1 e1^T + e2 e2^T) */
            double gn2 = 0;
            for (int l = 0; l < T.nLk; l++) { int s = St.n[l]; double gl2 = 0; for (int i = 0; i < s; i++) gl2 += g[St.idx[l][i]] * g[St.idx[l][i]];
                for (int i = 0; i < s; i++) for (int j = 0; j < s; j++) { double G = g[St.idx[l][i]] * g[St.idx[l][j]] - gl2 * (e1[l][i] * e1[l][j] + e2[l][i] * e2[l][j]); gn2 += G * G; } }
            double gn = sqrt(gn2) + 1e-300;
            for (int l = 0; l < T.nLk; l++) { int s = St.n[l]; double gl2 = 0; for (int i = 0; i < s; i++) gl2 += g[St.idx[l][i]] * g[St.idx[l][i]];
                for (int i = 0; i < s; i++) for (int j = 0; j < s; j++) Y[l][i * s + j] -= eta * (g[St.idx[l][i]] * g[St.idx[l][j]] - gl2 * (e1[l][i] * e1[l][j] + e2[l][i] * e2[l][j])) / gn; }
            double nu = star_nu(&T, &St, Y, q, e1, e2, Qt, W, z, g);
            if (nu < best - 1e-9) { best = nu; eta *= 1.03; for (int l = 0; l < T.nLk; l++) memcpy(Yb[l], Y[l], sizeof(double) * St.n[l] * St.n[l]); }
            else if (it % 25 == 0) { eta *= 0.7; for (int l = 0; l < T.nLk; l++) memcpy(Y[l], Yb[l], sizeof(double) * St.n[l] * St.n[l]); nu = star_nu(&T, &St, Y, q, e1, e2, Qt, W, z, g); }
            if (it % 100 == 0) { printf("   it %5d: nu = %.6f (best %.6f, b_lin %.5f) eta %.2e  [%.0f s]\n", it, nu, best, 1 / best, eta, wall() - T0W); fflush(stdout); }
            if (eta < 1e-6) break;
        }
        /* the best: q_l = Y_l - lambda_min(E(Y_l)) I + 1e-6 I, rounded to 2^-24; verified; written */
        (void)star_nu(&T, &St, Yb, q, e1, e2, Qt, W, z, g);
        FILE *f = fopen(outf, "w"); if (!f) { printf("REFUSED: cannot write %s\n", outf); return 21; }
        fprintf(f, "STARQ L %d nLk %d\n", L, T.nLk);
        int okall = 1; double worstlo = 1e300;
        for (int l = 0; l < T.nLk; l++) { int s = St.n[l];
            for (int i = 0; i < s; i++) q[l][i * s + i] += 1e-6;
            for (int i = 0; i < s * s; i++) q[l][i] = nearbyint(q[l][i] * 16777216.0) / 16777216.0;
            for (int i = 0; i < s; i++) for (int j = 0; j < i; j++) q[l][j * s + i] = q[l][i * s + j];
            double *E = NEW(double, 4 * s * s); star_embed(s, q[l], St.T[l], E);
            double rb, lo = verified_lmin_lower(2 * s, E, 1e-10, NULL, &rb); free(E);
            if (!(lo > 0)) okall = 0; if (lo < worstlo) worstlo = lo;
            fprintf(f, "%d %d", l, s); for (int i = 0; i < s; i++) fprintf(f, " %d", St.idx[l][i]);
            for (int i = 0; i < s * s; i++) fprintf(f, " %lld", (long long)llround(q[l][i] * 16777216.0)); fprintf(f, "\n"); }
        fclose(f);
        printf("best nu = %.6f (b_lin of this majorant %.5f); all %d star LMIs verified: %s (worst verified lambda_min %.3e); written %s  [%.0f s]\n",
               best, 1 / best, T.nLk, okall ? "YES" : "NO", worstlo, outf, wall() - T0W);
        return okall ? 0 : 22;
    }

    if (!strcmp(mode, "chain") || !strcmp(mode, "remread")) {
      double *Qt = NEW(double, (size_t)T.nLk * T.nLk);
      double X[16] = {0};
      if (!strncmp(argv[3], "Q:", 2)) {
        /* a star-majorant file: re-verify EVERY star LMI from the file, then Qt = sum_l q_l */
        Star St; build_stars(&T, &St);
        FILE *f = fopen(argv[3] + 2, "r"); int Lf, nf; if (!f || fscanf(f, "STARQ L %d nLk %d\n", &Lf, &nf) != 2 || Lf != L || nf != T.nLk) { printf("REFUSED: star file\n"); return 23; }
        int okall = 1; double worstlo = 1e300;
        for (int l = 0; l < T.nLk; l++) { int ll, s; if (fscanf(f, "%d %d", &ll, &s) != 2 || ll != l || s != St.n[l]) { printf("REFUSED: star file row %d\n", l); return 23; }
            int idx[64]; for (int i = 0; i < s; i++) { if (fscanf(f, "%d", &idx[i]) != 1 || idx[i] != St.idx[l][i]) { printf("REFUSED: star support %d\n", l); return 23; } }
            double *qq = NEW(double, s * s); for (int i = 0; i < s * s; i++) { long long v; if (fscanf(f, "%lld", &v) != 1) { printf("REFUSED: short star\n"); return 23; } qq[i] = (double)v / 16777216.0; }
            for (int i = 0; i < s; i++) for (int j = 0; j < s; j++) if (qq[i * s + j] != qq[j * s + i]) { printf("REFUSED: asymmetric q_%d\n", l); return 23; }
            double *E = NEW(double, 4 * s * s); star_embed(s, qq, St.T[l], E);
            double rb, lo = verified_lmin_lower(2 * s, E, 1e-10, NULL, &rb); free(E);
            if (!(lo > 0)) okall = 0; if (lo < worstlo) worstlo = lo;
            for (int i = 0; i < s; i++) for (int j = 0; j < s; j++) Qt[(size_t)idx[i] * T.nLk + idx[j]] += qq[i * s + j];
            free(qq); }
        fclose(f);
        printf("STAR MAJORANT (generalised Lemma M): all %d star LMIs [[q, -T],[T, q]] re-verified from the file: %s (worst verified lambda_min %.3e)\n", T.nLk, okall ? "PSD" : "FAILED", worstlo);
        if (!okall) { printf("REFUSED: a star LMI failed\n"); return 14; }
      } else {
        /* blocks of the shaped majorant */
        int cnt; double *raw = read_npy(argv[3], &cnt); if (cnt != 64) { printf("REFUSED: blocks file has %d entries\n", cnt); return 13; }
        double xb[4][16];
        for (int c = 0; c < 4; c++) for (int i = 0; i < 4; i++) for (int j = 0; j < 4; j++) {
            double v = raw[c * 16 + i * 4 + j] + (i == j ? 1e-6 : 0);
            xb[c][i * 4 + j] = nearbyint(v * 16777216.0) / 16777216.0;
        }
        for (int c = 0; c < 4; c++) for (int i = 0; i < 16; i++) X[i] += xb[c][i];
        printf("shaped majorant blocks (dyadic 2^-24, after a 1e-6 shift); X = sum_c x^(c):\n");
        for (int i = 0; i < 4; i++) printf("   [% .8f % .8f % .8f % .8f]\n", X[i * 4], X[i * 4 + 1], X[i * 4 + 2], X[i * 4 + 3]);
        /* LEMMA M: x^(c) - K^(c) PSD via the 8x8 real embedding [[x, -Om/2],[Om/2, x]] */
        int okM = 1;
        for (int c = 0; c < 4; c++) {
            double Om[16] = {0};
            for (int t = 0; t < 4; t++) {
                int a = TRI[t][0], b = TRI[t][1], cc = TRI[t][2], i, j; double sg = SIG3[t];
                if (cc == c) { i = a; j = b; } else if (b == c) { i = cc; j = a; } else if (a == c) { i = b; j = cc; } else continue;
                Om[i * 4 + j] += 2 * sg; Om[j * 4 + i] -= 2 * sg;
            }
            double E[64];
            for (int i = 0; i < 4; i++) for (int j = 0; j < 4; j++) {
                E[i * 8 + j] = xb[c][i * 4 + j]; E[(i + 4) * 8 + j + 4] = xb[c][i * 4 + j];
                E[i * 8 + j + 4] = -Om[i * 4 + j] / 2; E[(i + 4) * 8 + j] = Om[i * 4 + j] / 2;
            }
            double rb, lo = verified_lmin_lower(8, E, 1e-10, NULL, &rb);
            printf("LEMMA M block %d: verified lambda_min(x - K) >= %.3e (residual bound %.1e) -> %s\n", c, lo, rb, lo > 0 ? "PSD" : "FAILED");
            if (!(lo > 0)) okM = 0;
        }
        if (!okM) { printf("REFUSED: a Lemma M LMI failed\n"); return 14; }
        /* the per-colour majorant Qt = sum_p P_p^T X P_p */
        for (int p = 0; p < T.nP; p++) for (int i = 0; i < 4; i++) for (int j = 0; j < 4; j++) Qt[(size_t)T.plaq[4 * p + i] * T.nLk + T.plaq[4 * p + j]] += X[i * 4 + j];
      }
        /* congruence helper: k x k restriction */
        double *Mr = NEW(double, k * k), *tmp = NEW(double, (size_t)T.nLk * k);
        #define RESTRICT(MAT) restrict_mat(&T, (MAT), Mr)
        double *M = NEW(double, (size_t)T.nLk * T.nLk);
        double blist[64]; int nb = 0; { char *s = strdup(argv[4]), *tok = strtok(s, ","); while (tok && nb < 64) { blist[nb++] = nearbyint(atof(tok) * 65536.0) / 65536.0; tok = strtok(NULL, ","); } }
        RESTRICT(Qt);
        { double *A0 = NEW(double, (size_t)T.nLk * T.nLk); memcpy(A0, T.H0c, sizeof(double) * T.nLk * T.nLk); double *Hr = NEW(double, k * k);
          double *Mq = Mr; Mr = Hr; RESTRICT(A0); Mr = Mq; /* Hr = H0 restricted, Mq = Qt restricted */
          double *w = NEW(double, k), *V = NEW(double, k * k); double *Hc = NEW(double, k * k); memcpy(Hc, Hr, sizeof(double) * k * k); jacobi(k, Hc, w, V);
          double *W = NEW(double, k * k); for (int i = 0; i < k; i++) for (int j = 0; j < k; j++) { double s = 0; for (int t = 0; t < k; t++) s += V[i * k + t] * V[j * k + t] / sqrt(w[t]); W[i * k + j] = s; }
          double *Z = NEW(double, k * k), *Z2 = NEW(double, k * k);
          for (int i = 0; i < k; i++) for (int j = 0; j < k; j++) { double s = 0; for (int t = 0; t < k; t++) s += W[i * k + t] * Mq[t * k + j]; Z[i * k + j] = s; }
          for (int i = 0; i < k; i++) for (int j = 0; j < k; j++) { double s = 0; for (int t = 0; t < k; t++) s += Z[i * k + t] * W[t * k + j]; Z2[i * k + j] = s; }
          printf("nu = lambda_max(Qt relative to H0 on V0) = %.6f (Python anchor %s); gamma0 reading %.10f\n", lmax_sym(k, Z2), L == 2 ? "12.099701" : "24.543486", w[0]);
          free(A0); free(Hr); free(w); free(V); free(Hc); free(W); free(Z); free(Z2); }

        if (!strcmp(mode, "remread")) {
            /* the exact-remainder ceiling (READING): rho_ex(alpha, b) = max over (ball_b)^4 of lambda_max(-(h(phi) - (1-alpha) h0 + b X (x) I3)) */
            double alist[8] = {0.0, 0.03, 0.06, 0.1, 0.15, 0.2, 0.3, 0.4};
            for (int bi = 0; bi < nb; bi++) {
                double b = blist[bi], bestc = -1e9, besta = 0, bestrho = 0;
                for (int ai = 0; ai < 8; ai++) {
                    double al = alist[ai];
                    /* global reading lambda_min((1-alpha) H0c - b Qt | V0) */
                    for (size_t i = 0; i < (size_t)T.nLk * T.nLk; i++) M[i] = (1 - al) * T.H0c[i] - b * Qt[i];
                    RESTRICT(M); double lg = lmin_sym(k, Mr);
                    /* multistart local maximisation over phi of lambda_max(-G(phi)) */
                    double rho = -1e9;
                    for (int st = 0; st < 60; st++) {
                        double ph[12], Hh[144], G[144];
                        for (int i = 0; i < 4; i++) { double v[3] = {rnorm(), rnorm(), rnorm()}; double nv = nrm(3, v); double rr = b * (st % 3 == 0 ? 1.0 : cbrt(runif())); for (int a = 0; a < 3; a++) ph[3 * i + a] = rr * v[a] / nv; }
                        double step = 0.3 * b, cur = -1e9;
                        for (int it = 0; it < 400 && step > 1e-6 * b; it++) {
                            double bestv = -1e9, bestph[12]; int moved = 0;
                            for (int trial = 0; trial < 13; trial++) {
                                double q[12]; memcpy(q, ph, sizeof q);
                                if (trial > 0) { int coord = (int)(runif() * 12); q[coord] += (runif() < 0.5 ? -1 : 1) * step; if (trial > 6) for (int i = 0; i < 12; i++) q[i] += step * 0.3 * rnorm(); }
                                for (int i = 0; i < 4; i++) { double nv = nrm(3, q + 3 * i); if (nv > b) for (int a = 0; a < 3; a++) q[3 * i + a] *= b / nv; }
                                plaq_hess(q, Hh);
                                for (int r = 0; r < 12; r++) for (int cc = 0; cc < 12; cc++) {
                                    int i = r / 3, a = r % 3, j = cc / 3, bb = cc % 3;
                                    double h0 = (a == bb) ? SGN[i] * SGN[j] : 0;
                                    G[r * 12 + cc] = -(Hh[r * 12 + cc] - (1 - al) * h0 + ((a == bb) ? b * X[i * 4 + j] : 0));
                                }
                                double v = lmax_sym(12, G);
                                if (trial == 0) { if (v > cur) cur = v; continue; }
                                if (v > bestv) { bestv = v; memcpy(bestph, q, sizeof q); }
                            }
                            if (bestv > cur) { cur = bestv; memcpy(ph, bestph, sizeof ph); moved = 1; step *= 1.2; } else step *= 0.6;
                            (void)moved;
                        }
                        if (cur > rho) rho = cur;
                    }
                    double cpred = lg - 6 * rho;
                    printf("   b = %.6f alpha = %.3f: lambda_min((1-alpha)H0 - b Qt | V0) = %.5f, exact per-plaquette rho = %.6f (rho/b^2 = %.3f) -> c READING %.5f\n", b, al, lg, rho, rho / (b * b), cpred);
                    fflush(stdout);
                    if (cpred > bestc) { bestc = cpred; besta = al; bestrho = rho; }
                }
                printf("EXACT-REMAINDER CHAIN b = %.6f: best alpha %.3f, rho %.6f -> c READING %.5f  [%.0f s]\n", b, besta, bestrho, bestc, wall() - T0W);
                fflush(stdout);
            }
            return 0;
        }

        /* LEMMA R constants from the EXACT Taylor tensors, recomputed here */
        frac *D4 = NEW(frac, 12 * 12 * 12 * 12); int maxden4 = 1;
        for (int a = 0; a < 12; a++) for (int b = a; b < 12; b++) for (int c = b; c < 12; c++) for (int d = c; d < 12; d++) {
            int idx[4] = {a, b, c, d}; frac v = Dn_entry(4, idx);
            if ((3 * v.n) % v.d != 0) { printf("REFUSED: D4 entry not in Z/3\n"); return 15; }
            if (v.d > maxden4) maxden4 = (int)v.d;
            int pp[4]; int perm[24][4]; int np = nperm_list(idx, 4, perm);   /* all orderings */
            for (int t = 0; t < np; t++) { for (int r = 0; r < 4; r++) pp[r] = perm[t][r]; D4[((pp[0] * 12 + pp[1]) * 12 + pp[2]) * 12 + pp[3]] = v; }
        }
        printf("D4F(0): exact, every entry in Z/3 (largest denominator %d)  [%.1f s]\n", maxden4, wall() - T0W);
        /* consistency with the degree-2 and degree-3 parts: h0 and the cubic vertex */
        { int bad = 0; for (int a = 0; a < 12; a++) for (int b = 0; b < 12; b++) { int idx[2] = {a, b}; frac v = Dn_entry(2, idx); double h0 = (a % 3 == b % 3) ? SGN[a / 3] * SGN[b / 3] : 0; if (fabs(fdbl(v) - h0) > 0) bad++; }
          double ph[12], H1[144]; int bad3 = 0;
          for (int c = 0; c < 12; c++) { memset(ph, 0, sizeof ph); ph[c] = 1; plaq_h1(ph, H1);
            for (int a = 0; a < 12; a++) for (int b = 0; b < 12; b++) { int idx[3] = {a, b, c}; frac v = Dn_entry(3, idx); if (fabs(fdbl(v) - H1[a * 12 + b]) > 0) bad3++; } }
          printf("D2F(0) = h0 exactly: %d mismatches; D3F(0)[e_c] = h1(e_c) exactly: %d mismatches\n", bad, bad3); }
        frac *D5 = NEW(frac, 248832); int maxden5 = 1;
        for (int a = 0; a < 12; a++) for (int b = a; b < 12; b++) for (int c = b; c < 12; c++) for (int d = c; d < 12; d++) for (int e = d; e < 12; e++) {
            int idx[5] = {a, b, c, d, e}; frac v = Dn_entry(5, idx);
            if ((3 * v.n) % v.d != 0) { printf("REFUSED: D5 entry not in Z/3\n"); return 15; }
            if (v.d > maxden5) maxden5 = (int)v.d;
            /* fill all orderings: permutations of 5 */
            int a5[5] = {0, 1, 2, 3, 4};
            while (1) {
                D5[((((idx[a5[0]] * 12 + idx[a5[1]]) * 12 + idx[a5[2]]) * 12 + idx[a5[3]]) * 12) + idx[a5[4]]] = v;
                int i = 3; while (i >= 0 && a5[i] > a5[i + 1]) i--; if (i < 0) break;
                int j = 4; while (a5[j] < a5[i]) j--; int t = a5[i]; a5[i] = a5[j]; a5[j] = t;
                for (int l = i + 1, r = 4; l < r; l++, r--) { t = a5[l]; a5[l] = a5[r]; a5[r] = t; }
            }
        }
        printf("D5F(0): exact, every entry in Z/3 (largest denominator %d)  [%.1f s]\n", maxden5, wall() - T0W);
        /* Tint (144x144) = 3 D4 reshaped (k,a),(l,b) from D4[k][l][a][b]; T = Tint / 6 */
        long long *Tint = NEW(long long, 144 * 144);
        for (int kk = 0; kk < 12; kk++) for (int a = 0; a < 12; a++) for (int l = 0; l < 12; l++) for (int b = 0; b < 12; b++) {
            frac v = D4[((kk * 12 + l) * 12 + a) * 12 + b]; Tint[(kk * 12 + a) * 144 + l * 12 + b] = (long long)(3 * v.n / v.d);
        }
        /* U U^T integer: Uint (144 x 1728) = 3 D5[k][l][a][b][c] at row (k,a), column (l,b,c) */
        long long *UU = NEW(long long, 144 * 144);
        { long long *Ui = NEW(long long, 144 * 1728);
          for (int kk = 0; kk < 12; kk++) for (int l = 0; l < 12; l++) for (int a = 0; a < 12; a++) for (int b = 0; b < 12; b++) for (int c = 0; c < 12; c++) {
              frac v = D5[(((kk * 12 + l) * 12 + a) * 12 + b) * 12 + c]; Ui[(size_t)(kk * 12 + a) * 1728 + (l * 12 + b) * 12 + c] = (long long)(3 * v.n / v.d); }
          for (int i = 0; i < 144; i++) for (int j = 0; j < 144; j++) { long long s = 0; for (int t = 0; t < 1728; t++) s += Ui[(size_t)i * 1728 + t] * Ui[(size_t)j * 1728 + t]; UU[i * 144 + j] = s; }
          free(Ui); }
        /* certify lambda_max(S) <= mu for S = Sint / scale via verified Cholesky of mu*scale I - Sint */
        double sig2read, sig2cert;
        { double *A = NEW(double, 144 * 144); for (int i = 0; i < 144 * 144; i++) A[i] = (double)UU[i]; sig2read = lmax_sym(144, A);
          sig2cert = -1;
          double facs[5] = {1 + 1e-6, 1 + 1e-4, 1 + 1e-2, 1.05, 1.2};
          for (int fi = 0; fi < 5 && sig2cert < 0; fi++) { double mu = sig2read * facs[fi] + 1e-12;
              double *E = NEW(double, 144 * 144), *EA = NEW(double, 144 * 144);
              for (int i = 0; i < 144 * 144; i++) E[i] = -(double)UU[i];
              for (int i = 0; i < 144; i++) { E[i * 145] += mu; EA[i * 145] = 4 * U53 * (fabs(mu) + fabs((double)UU[i * 145])); }
              double rb, lo = verified_lmin_lower(144, E, 1e-9 * (mu > 1 ? mu : 1), EA, &rb); if (lo >= 0) sig2cert = mu; free(E); free(EA); }
          free(A); }
        if (sig2cert < 0) { printf("REFUSED: sigma_max(U) not certified\n"); return 16; }
        double smax = sqrt(sig2cert) / 18.0 * (1 + 8 * EPSB);
        printf("sigma_max(U): READING %.6f, CERTIFIED <= %.6f (Python anchor 5.033225)\n", sqrt(sig2read) / 18.0, smax);
        double C5 = 8 * smax * (1 + 8 * EPSB), C6 = 1024.0 / 24.0 * (1 + 8 * EPSB);
        int aps[11] = {0, 2, 4, 6, 8, 10, 12, 16, 20, 32, 64}; double C4[11];
        for (int ai = 0; ai < 11; ai++) {
            int ap = aps[ai];
            double *S = NEW(double, 144 * 144);
            for (int i = 0; i < 144; i++) for (int j = 0; j < 144; j++) {
                int kk = i / 12, a = i % 12, l = j / 12, b = j % 12;
                double h0 = (kk % 3 == l % 3) ? SGN[kk / 3] * SGN[l / 3] : 0;
                S[i * 144 + j] = (double)(-4 * Tint[i * 144 + j]) - 6.0 * ap * h0 * (a == b);   /* = 24 (-T - (ap/4) h0 (x) I), integers */
            }
            double lr = lmax_sym(144, S) / 24.0, mucert = -1;
            if (lr <= 0) { C4[ai] = 0; printf("   alpha' = %2d: lambda_max <= 0 (READING) -> c4 = 0\n", ap); free(S); continue; }
            double facs[5] = {1 + 1e-6, 1 + 1e-4, 1 + 1e-2, 1.05, 1.2};
            for (int fi = 0; fi < 5 && mucert < 0; fi++) {
                double mu = lr * facs[fi] + 1e-12; double *E = NEW(double, 144 * 144), *EA = NEW(double, 144 * 144);
                for (int i = 0; i < 144 * 144; i++) E[i] = -S[i];
                for (int i = 0; i < 144; i++) { E[i * 145] += mu * 24.0; EA[i * 145] = 4 * U53 * (fabs(mu * 24.0) + fabs(S[i * 145])); }
                double rb, lo = verified_lmin_lower(144, E, 1e-9 * (mu * 24 > 1 ? mu * 24 : 1), EA, &rb); if (lo >= 0) mucert = mu; free(E); free(EA);
            }
            if (mucert < 0) { printf("REFUSED: c4(%d) not certified\n", ap); return 16; }
            C4[ai] = 4 * mucert * (1 + 8 * EPSB);
            printf("   alpha' = %2d: lambda_max(-T - (alpha'/4) h0 x I) READING %.6f, CERTIFIED <= %.6f -> c4 = %.4f\n", ap, lr, mucert, C4[ai]);
            free(S);
        }
        /* the global step per b (Finsler + verified Cholesky), exactly as section 15 */
        double *QtQ = NEW(double, (size_t)T.nLk * T.nLk), *GGt = NEW(double, (size_t)T.nLk * T.nLk);
        for (int i = 0; i < T.nLk; i++) for (int j = 0; j < T.nLk; j++) { long long s = 0, g = 0;
            for (int q = 0; q < T.nQ; q++) s += (long long)T.Q0[(size_t)q * T.nLk + i] * T.Q0[(size_t)q * T.nLk + j];
            for (int q = 0; q < T.nG; q++) g += (long long)T.G0[(size_t)q * T.nLk + i] * T.G0[(size_t)q * T.nLk + j];
            QtQ[(size_t)i * T.nLk + j] = (double)s; GGt[(size_t)i * T.nLk + j] = (double)g; }
        double sqmin2, sgmin2;
        { double *A = NEW(double, T.nQ * T.nQ); for (int i = 0; i < T.nQ; i++) for (int j = 0; j < T.nQ; j++) { long long s = 0; for (int l = 0; l < T.nLk; l++) s += (long long)T.Q0[(size_t)i * T.nLk + l] * T.Q0[(size_t)j * T.nLk + l]; A[i * T.nQ + j] = (double)s; }
          sqmin2 = lmin_sym(T.nQ, A); free(A);
          A = NEW(double, T.nG * T.nG); for (int i = 0; i < T.nG; i++) for (int j = 0; j < T.nG; j++) { long long s = 0; for (int l = 0; l < T.nLk; l++) s += (long long)T.G0[(size_t)i * T.nLk + l] * T.G0[(size_t)j * T.nLk + l]; A[i * T.nG + j] = (double)s; }
          sgmin2 = lmin_sym(T.nG, A); free(A); }
        printf("smallest singular values: Q0 %.4f, G0 %.4f (Python anchor L=2: 172.967, 0.6561; L=3: 648.000, 0.2919)\n", sqrt(sqmin2), sqrt(sgmin2));
        double *A = NEW(double, (size_t)T.nLk * T.nLk), *EA = NEW(double, (size_t)T.nLk * T.nLk);
        for (int bi = 0; bi < nb; bi++) {
            double b = blist[bi], best = -1e9; int bai = -1; double blg = 0, brho = 0;
            for (int ai = 0; ai < 11; ai++) {
                double al = aps[ai] * b * b; if (al >= 1) continue;
                for (size_t i = 0; i < (size_t)T.nLk * T.nLk; i++) M[i] = (1 - al) * T.H0c[i] - b * Qt[i];
                RESTRICT(M); double lg = lmin_sym(k, Mr);
                double rho = (C4[ai] * b * b + C5 * b * b * b + C6 * b * b * b * b) * (1 + 1e-12) + 1e-300;
                if (lg - 6 * rho > best) { best = lg - 6 * rho; bai = ai; blg = lg; brho = rho; }
            }
            printf("b = %.6f: best alpha' = %d (alpha %.5f): lambda_min((1-alpha)H0 - bQt | V0) READING %.5f, 6 rho = %.5f -> c READING %.5f\n", b, aps[bai], aps[bai] * b * b, blg, 6 * brho, best);
            if (best <= 0) { printf("      [no certificate attempted]\n"); continue; }
            double al = aps[bai] * b * b, mu = 6 * brho + 0.5 * best;
            for (size_t i = 0; i < (size_t)T.nLk * T.nLk; i++) M[i] = (1 - al) * T.H0c[i] - b * Qt[i];
            double normM = 0; for (int i = 0; i < T.nLk; i++) { double s = 0; for (int j = 0; j < T.nLk; j++) s += fabs(M[(size_t)i * T.nLk + j] - (i == j ? mu : 0)); if (s > normM) normM = s; }
            double target = 4 * (normM + normM * normM / (0.5 * best));
            double kQ = pow(2.0, ceil(log2(target / sqmin2))), kG = pow(2.0, ceil(log2(target / sgmin2)));
            for (size_t i = 0; i < (size_t)T.nLk * T.nLk; i++) {
                int ii = (int)(i / T.nLk), jj = (int)(i % T.nLk);
                A[i] = M[i] - (ii == jj ? mu : 0) + kQ * QtQ[i] + kG * GGt[i];
                EA[i] = 4 * U53 * (fabs(M[i]) + kQ * fabs(QtQ[i]) + kG * fabs(GGt[i]) + (ii == jj ? mu : 0));
            }
            double rb, lo = verified_lmin_lower(T.nLk, A, 0.25 * 0.5 * best, EA, &rb);
            printf("      Finsler kQ = 2^%d, kG = 2^%d: verified lambda_min(A) >= %.6e (residual bound %.2e) -> %s: lambda_min(Hess S|V) >= %.5f on D_b\n",
                   (int)log2(kQ), (int)log2(kG), lo, rb, lo >= 0 ? "CERTIFIED" : "NOT CERTIFIED", lo >= 0 ? mu - 6 * brho : NAN);
            fflush(stdout);
        }
        printf("chain done [%.1f s]\n", wall() - T0W);
        return 0;
    }
    printf("unknown mode\n");
    return 1;
}
