/* l2dob.c -- M2's L2 reader: the MAXIMAL CORRELATION of the two coarse loops of the two-face object at a fine datum, beside the
 * total variation coefficient C of THE GROUND's (8.5), from the engine's junction-tensor dump (W2-F lines, SU(2)) or the U(1) engine's
 * joint moments (U1-CLASS lines).  The representation code (Dsub, rep) and the quadrature rule are w2_strip_n.c's / w2_dob.c's,
 * copied verbatim so that the convention is the record's.
 * p(U,V) = sum_{a,c<=L} d_a d_c sum P^{ac}_{rq,r'q'} conj D^a(U)_{rq} conj D^c(V)_{r'q'},  P = F/Z = E[D^a(A) D^c(B)].
 * c = p - p_A p_B = sum_{a,c>=1} G_{ij} phi_i(U) psi_j(V),  phi_i = d_a conj D^a_{rq},  G = P^{ac} - P^{a0} P^{0c}.
 * ROAD A: rho = s_max(L^dag G M), Phi = L L^dag, Psi = M M^dag, Phi_{ii'} = int conj(phi_i) phi_i' / p_A, Psi_{jj'} = int psi_j conj(psi_j') / p_B.
 * ROAD B: rho = s_max(K), K_{uv} = sqrt(w_u w_v) c(U_u,V_v) / sqrt(p_A(U_u) p_B(V_v)) on a product rule.
 * TV: C_grid = max over pairs (V,V') on a sub-rule of 1/2 int |p(U|V) - p(U|V')| dU  (a grid LOWER bound on the supremum).
 * usage: l2dob <record> [degA=30] [degB=20] [degTV=12]      l2dob SYN2 eps | SYNU eps | SYNU2 eps     (known answers)
 * build: gcc -O2 -fopenmp -o l2dob.exe l2dob.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
#ifdef _OPENMP
#include <omp.h>
#endif
typedef double complex cplx;
#define PI 3.141592653589793
typedef struct { double w, x, y, z; } quat;
static quat qmul(quat a, quat b) { quat r; r.w = a.w*b.w - a.x*b.x - a.y*b.y - a.z*b.z; r.x = a.w*b.x + a.x*b.w + a.y*b.z - a.z*b.y; r.y = a.w*b.y - a.x*b.z + a.y*b.w + a.z*b.x; r.z = a.w*b.z + a.x*b.y - a.y*b.x + a.z*b.w; return r; }
static quat qinv(quat a) { quat r = { a.w, -a.x, -a.y, -a.z }; return r; }
static double FACT[40]; static int GENINV = 0;
static double chi(int s, quat q) { double w = q.w, u0 = 1, u1 = 2 * w; if (s == 0) return u0; for (int k = 2; k <= s; k++) { double u2 = 2 * w * u1 - u0; u0 = u1; u1 = u2; } return u1; }
static void Dsub(int s, quat q, cplx *D) {
  cplx a = q.w + I * q.x, b = q.y + I * q.z, ab = q.w - I * q.x, nbb = -q.y + I * q.z;
  cplx poly[40], np[40];
  for (int qq = 0; qq <= s; qq++) { int len = 1; poly[0] = 1;
    for (int r = 0; r < qq; r++) { for (int k = 0; k <= len; k++) np[k] = 0; for (int k = 0; k < len; k++) { np[k + 1] += poly[k] * a; np[k] += poly[k] * b; } len++; for (int k = 0; k < len; k++) poly[k] = np[k]; }
    for (int r = 0; r < s - qq; r++) { for (int k = 0; k <= len; k++) np[k] = 0; for (int k = 0; k < len; k++) { np[k + 1] += poly[k] * nbb; np[k] += poly[k] * ab; } len++; for (int k = 0; k < len; k++) poly[k] = np[k]; }
    for (int p = 0; p <= s; p++) { double sc = sqrt(FACT[p] * FACT[s - p] / (FACT[qq] * FACT[s - qq])); D[p * (s + 1) + qq] = poly[p] * sc; } } }
static void rep(int s, quat q, cplx *D) { if (s == 0) { D[0] = 1; return; } Dsub(s, GENINV ? qinv(q) : q, D); }
static void gauss_legendre(int n, double *x, double *w) { for (int i = 1; i <= n; i++) { double z = cos(PI * (i - 0.25) / (n + 0.5)), dp = 0;
    for (int it = 0; it < 200; it++) { double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2 * k - 1) * z * p1 - (k - 1) * p0) / k; p0 = p1; p1 = p2; } dp = n * (z * p1 - p0) / (z * z - 1); double z1 = z; z = z1 - p1 / dp; if (fabs(z - z1) < 1e-15) break; }
    double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2 * k - 1) * z * p1 - (k - 1) * p0) / k; p0 = p1; p1 = p2; } dp = n * (z * p1 - p0) / (z * z - 1); x[i - 1] = z; w[i - 1] = 2 / ((1 - z * z) * dp * dp); } }
static int make_rule(int deg, quat **RUo, double **RWo) { int nth = (deg + 2) / 2, ngl = (deg + 2) / 2, naz = deg + 1; double gx[400], gw[400]; gauss_legendre(ngl, gx, gw);
  int NPT = nth * ngl * naz; quat *RU = malloc(sizeof(quat) * NPT); double *RW = malloc(sizeof(double) * NPT); int n = 0;
  for (int k = 1; k <= nth; k++) { double th = k * PI / (nth + 1), wt = 2 * sin(th) * sin(th) / (nth + 1);
    for (int j = 0; j < ngl; j++) { double t = gx[j], st = sqrt(1 - t * t);
      for (int l = 0; l < naz; l++) { double ph = 2 * PI * l / naz; quat u = { cos(th), sin(th) * st * cos(ph), sin(th) * st * sin(ph), sin(th) * t }; RU[n] = u; RW[n] = wt * gw[j] / 2 / naz; n++; } } }
  *RUo = RU; *RWo = RW; return NPT; }

/* ---------------- linear algebra: complex Hermitian Cholesky, real symmetric Jacobi ---------------- */
static int cchol(int n, const cplx *A, cplx *L) { /* A = L L^dag, L lower triangular */ memset(L, 0, sizeof(cplx) * n * n);
  for (int j = 0; j < n; j++) { double d = creal(A[j * n + j]); for (int k = 0; k < j; k++) d -= creal(L[j * n + k] * conj(L[j * n + k])); if (d <= 0) return 0; L[j * n + j] = sqrt(d);
    for (int i = j + 1; i < n; i++) { cplx s = A[i * n + j]; for (int k = 0; k < j; k++) s -= L[i * n + k] * conj(L[j * n + k]); L[i * n + j] = s / creal(L[j * n + j]); } } return 1; }
static void jacobi(int n, double *a, double *ev) { /* real symmetric, eigenvalues into ev */ for (int sweep = 0; sweep < 100; sweep++) { double off = 0; for (int p = 0; p < n; p++) for (int q = p + 1; q < n; q++) off += a[p * n + q] * a[p * n + q]; if (off < 1e-30) break;
    for (int p = 0; p < n; p++) for (int q = p + 1; q < n; q++) { double apq = a[p * n + q]; if (fabs(apq) < 1e-300) continue; double th = (a[q * n + q] - a[p * n + p]) / (2 * apq); double t = (th >= 0 ? 1 : -1) / (fabs(th) + sqrt(th * th + 1)); double c = 1 / sqrt(t * t + 1), s = t * c;
      for (int k = 0; k < n; k++) { double akp = a[k * n + p], akq = a[k * n + q]; a[k * n + p] = c * akp - s * akq; a[k * n + q] = s * akp + c * akq; }
      for (int k = 0; k < n; k++) { double apk = a[p * n + k], aqk = a[q * n + k]; a[p * n + k] = c * apk - s * aqk; a[q * n + k] = s * apk + c * aqk; } } }
  for (int i = 0; i < n; i++) ev[i] = a[i * n + i]; }
static int cmpd(const void *x, const void *y) { double a = *(const double *)x, b = *(const double *)y; return a < b ? 1 : (a > b ? -1 : 0); }
/* singular values of the n x m complex matrix X: eigenvalues of X X^dag via the real 2n embedding (each doubled); returns sorted s */
static int csvals(int n, int m, const cplx *X, double *s) { cplx *H = calloc((size_t)n * n, sizeof(cplx)); for (int i = 0; i < n; i++) for (int k = 0; k < n; k++) { cplx t = 0; for (int j = 0; j < m; j++) t += X[i * m + j] * conj(X[k * m + j]); H[i * n + k] = t; }
  int N2 = 2 * n; double *R = calloc((size_t)N2 * N2, sizeof(double)), *ev = calloc(N2, sizeof(double));
  for (int i = 0; i < n; i++) for (int k = 0; k < n; k++) { double re = creal(H[i * n + k]), im = cimag(H[i * n + k]); R[i * N2 + k] = re; R[(i + n) * N2 + k + n] = re; R[i * N2 + k + n] = -im; R[(i + n) * N2 + k] = im; }
  jacobi(N2, R, ev); qsort(ev, N2, sizeof(double), cmpd); for (int i = 0; i < n; i++) s[i] = sqrt(ev[2 * i] > 0 ? ev[2 * i] : 0); free(H); free(R); free(ev); return n; }

/* ---------------- the SU(2) record ---------------- */
static int LMAX = -1, GENREC = -1; static double Z = 0; static int DIM[16]; static cplx *FH[16][16];
static inline size_t fidx(int da, int dc, int r, int q, int rp, int qp) { return ((size_t)(r * da + q)) * dc * dc + rp * dc + qp; }
static void alloc_F(void) { for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= LMAX; c++) { DIM[a] = a + 1; DIM[c] = c + 1; FH[a][c] = calloc((size_t)DIM[a] * DIM[a] * DIM[c] * DIM[c], sizeof(cplx)); } }
static int read_su2(const char *path) { FILE *f = fopen(path, "r"); if (!f) { fprintf(stderr, "cannot open %s\n", path); exit(1); } char line[4096]; int nf = 0;
  while (fgets(line, sizeof line, f)) {
    if (!strncmp(line, "W2-FHEAD", 8)) { if (sscanf(line, "W2-FHEAD GENINV=%d Z=%le LMAX=%d", &GENREC, &Z, &LMAX) != 3) { fprintf(stderr, "bad FHEAD\n"); exit(1); } alloc_F(); }
    else if (!strncmp(line, "W2-F ", 5)) { int a, c, r, q, rp, qp; double re, im; if (sscanf(line, "W2-F a=%d c=%d r=%d q=%d rp=%d qp=%d %le %le", &a, &c, &r, &q, &rp, &qp, &re, &im) != 8) { fprintf(stderr, "bad F line\n"); exit(1); }
      FH[a][c][fidx(DIM[a], DIM[c], r, q, rp, qp)] = (re + I * im) / Z; nf++; } }
  fclose(f); return nf; }

/* ---------------- U(1) record: M[a+L][c+L] = E[e^{i a Phi_A} e^{i c Phi_B}] ---------------- */
static int UL = -1; static cplx UM[64][64]; static int UHAS[64][64];
static int read_u1(const char *path) { FILE *f = fopen(path, "r"); if (!f) { fprintf(stderr, "cannot open %s\n", path); exit(1); } char line[4096]; int n = 0;
  while (fgets(line, sizeof line, f)) { if (!strncmp(line, "U1-OBJECT", 9)) { char *p = strstr(line, "LMAX="); if (p) UL = atoi(p + 5); }
    else if (!strncmp(line, "U1-CLASS ", 9)) { int a, c; double re, im; if (sscanf(line, "U1-CLASS a=%d c=%d E[e^{ia Phi_A} e^{ic Phi_B}] = %le %le", &a, &c, &re, &im) == 4) { if (UL < 0) { fprintf(stderr, "U1 LMAX unknown\n"); exit(1); } UM[a + UL][c + UL] = re + I * im; UHAS[a + UL][c + UL] = 1; n++; } } }
  fclose(f);
  /* fill by conjugation symmetry M_{-a,-c} = conj M_{a,c} (a real density) */
  for (int a = -UL; a <= UL; a++) for (int c = -UL; c <= UL; c++) if (!UHAS[a + UL][c + UL] && UHAS[-a + UL][-c + UL]) { UM[a + UL][c + UL] = conj(UM[-a + UL][-c + UL]); UHAS[a + UL][c + UL] = 2; }
  int miss = 0; for (int a = -UL; a <= UL; a++) for (int c = -UL; c <= UL; c++) if (!UHAS[a + UL][c + UL]) miss++;
  if (miss) { fprintf(stderr, "U1: %d moments missing after conjugation\n", miss); exit(1); } return n; }

/* ---------------- the SU(2) computation ---------------- */
static void su2_run(int degA, int degB, int degTV, const char *tag) {
  int NB = 0, BOFF[16]; for (int a = 1; a <= LMAX; a++) { BOFF[a] = NB; NB += DIM[a] * DIM[a]; }
  /* G_{ij} */ cplx *G = calloc((size_t)NB * NB, sizeof(cplx)); double gmax = 0, gfro = 0;
  for (int a = 1; a <= LMAX; a++) for (int c = 1; c <= LMAX; c++) { int da = DIM[a], dc = DIM[c];
    for (int r = 0; r < da; r++) for (int q = 0; q < da; q++) for (int rp = 0; rp < dc; rp++) for (int qp = 0; qp < dc; qp++) {
      cplx v = FH[a][c][fidx(da, dc, r, q, rp, qp)] - FH[a][0][fidx(da, 1, r, q, 0, 0)] * FH[0][c][fidx(1, dc, 0, 0, rp, qp)];
      G[(size_t)(BOFF[a] + r * da + q) * NB + BOFF[c] + rp * dc + qp] = v; if (cabs(v) > gmax) gmax = cabs(v); gfro += creal(v * conj(v)); } }
  /* sigma_H: the Haar-orthonormal basis sqrt(d_a) D^a_{rq}; c = sum G_ij phi_i psi_j with phi_i = d_a conj D = sqrt(d_a) (sqrt(d_a) conj D) */
  cplx *GH = calloc((size_t)NB * NB, sizeof(cplx)); for (int a = 1; a <= LMAX; a++) for (int c = 1; c <= LMAX; c++) for (int i = 0; i < DIM[a] * DIM[a]; i++) for (int j = 0; j < DIM[c] * DIM[c]; j++) { size_t k = (size_t)(BOFF[a] + i) * NB + BOFF[c] + j; GH[k] = G[k] * sqrt((double)DIM[a] * DIM[c]); }
  double *sH = calloc(NB, sizeof(double)); csvals(NB, NB, GH, sH);
  /* ROAD A on the degA rule */
  quat *RU; double *RW; int NU = make_rule(degA, &RU, &RW); int NA = 0, AOFF[16]; for (int a = 0; a <= LMAX; a++) { AOFF[a] = NA; NA += DIM[a] * DIM[a]; }
  cplx *DU = malloc(sizeof(cplx) * (size_t)NU * NA); double *pA = malloc(sizeof(double) * NU), *pB = malloc(sizeof(double) * NU);
  #pragma omp parallel for
  for (int u = 0; u < NU; u++) { for (int a = 0; a <= LMAX; a++) rep(a, RU[u], DU + (size_t)u * NA + AOFF[a]);
    cplx sa = 0, sb = 0; for (int a = 0; a <= LMAX; a++) { int da = DIM[a]; for (int rq = 0; rq < da * da; rq++) { cplx d = conj(DU[(size_t)u * NA + AOFF[a] + rq]); sa += da * d * FH[a][0][(size_t)rq]; sb += da * d * FH[0][a][(size_t)rq]; } }
    pA[u] = creal(sa); pB[u] = creal(sb); }
  double minA = 1e9, minB = 1e9, sumA = 0, sumB = 0; for (int u = 0; u < NU; u++) { if (pA[u] < minA) minA = pA[u]; if (pB[u] < minB) minB = pB[u]; sumA += RW[u] * pA[u]; sumB += RW[u] * pB[u]; }
  printf("L2DOB-MARG %s degA=%d (%d points): int p_A = %.12f, int p_B = %.12f; min p_A %.6e, min p_B %.6e -> %s\n", tag, degA, NU, sumA, sumB, minA, minB, (minA > 0 && minB > 0) ? "POSITIVE" : "SIGNED: ROAD A REFUSED");
  double rhoA = -1; double *sA = calloc(NB, sizeof(double));
  if (minA > 0 && minB > 0) { cplx *Phi = calloc((size_t)NB * NB, sizeof(cplx)), *Psi = calloc((size_t)NB * NB, sizeof(cplx));
    for (int u = 0; u < NU; u++) { double wa = RW[u] / pA[u], wb = RW[u] / pB[u];
      for (int a = 1; a <= LMAX; a++) for (int i = 0; i < DIM[a] * DIM[a]; i++) { cplx fi = DIM[a] * conj(DU[(size_t)u * NA + AOFF[a] + i]);
        for (int a2 = 1; a2 <= LMAX; a2++) for (int i2 = 0; i2 < DIM[a2] * DIM[a2]; i2++) { cplx fj = DIM[a2] * conj(DU[(size_t)u * NA + AOFF[a2] + i2]);
          Phi[(size_t)(BOFF[a] + i) * NB + BOFF[a2] + i2] += wa * conj(fi) * fj; Psi[(size_t)(BOFF[a] + i) * NB + BOFF[a2] + i2] += wb * fi * conj(fj); } } }
    cplx *Lc = calloc((size_t)NB * NB, sizeof(cplx)), *Mc = calloc((size_t)NB * NB, sizeof(cplx));
    if (!cchol(NB, Phi, Lc) || !cchol(NB, Psi, Mc)) printf("L2DOB-ROADA %s: Cholesky REFUSED (Gram not positive definite)\n", tag);
    else { cplx *T1 = calloc((size_t)NB * NB, sizeof(cplx)), *X = calloc((size_t)NB * NB, sizeof(cplx));
      for (int i = 0; i < NB; i++) for (int j = 0; j < NB; j++) { cplx s = 0; for (int k = 0; k < NB; k++) s += G[(size_t)i * NB + k] * Mc[(size_t)k * NB + j]; T1[(size_t)i * NB + j] = s; }  /* G M */
      for (int i = 0; i < NB; i++) for (int j = 0; j < NB; j++) { cplx s = 0; for (int k = 0; k < NB; k++) s += conj(Lc[(size_t)k * NB + i]) * T1[(size_t)k * NB + j]; X[(size_t)i * NB + j] = s; }  /* L^dag G M */
      csvals(NB, NB, X, sA); rhoA = sA[0]; free(T1); free(X); }
    free(Phi); free(Psi); free(Lc); free(Mc); }
  printf("L2DOB-ROADA %s rho = %.9f   (next singular values %.3e %.3e %.3e %.3e)\n", tag, rhoA, sA[1], sA[2], sA[3], sA[4]);
  printf("L2DOB-HAAR %s sigma_H = %.9f   (next %.3e %.3e %.3e); max|G| %.3e, Frobenius %.3e\n", tag, sH[0], sH[1], sH[2], sH[3], gmax, sqrt(gfro));
  /* ROAD B and TV on the degB rule (U and V) */
  quat *RV; double *RWV; int NV = make_rule(degB, &RV, &RWV);
  cplx *DV = malloc(sizeof(cplx) * (size_t)NV * NA); double *qA = malloc(sizeof(double) * NV), *qB = malloc(sizeof(double) * NV);
  #pragma omp parallel for
  for (int v = 0; v < NV; v++) { for (int a = 0; a <= LMAX; a++) rep(a, RV[v], DV + (size_t)v * NA + AOFF[a]);
    cplx sa = 0, sb = 0; for (int a = 0; a <= LMAX; a++) { int da = DIM[a]; for (int rq = 0; rq < da * da; rq++) { cplx d = conj(DV[(size_t)v * NA + AOFF[a] + rq]); sa += da * d * FH[a][0][(size_t)rq]; sb += da * d * FH[0][a][(size_t)rq]; } }
    qA[v] = creal(sa); qB[v] = creal(sb); }
  /* H[v][i] = sum_c d_c sum F^{a c}_{i, j} conj D^c_j(V_v): p(U_u, V_v) = Re sum_a d_a sum_i conj D^a_i(U_u) H[v][a,i] */
  cplx *H = malloc(sizeof(cplx) * (size_t)NV * NA);
  #pragma omp parallel for
  for (int v = 0; v < NV; v++) for (int a = 0; a <= LMAX; a++) { int da = DIM[a]; for (int i = 0; i < da * da; i++) { cplx s = 0; for (int c = 0; c <= LMAX; c++) { int dc = DIM[c]; const cplx *Fb = FH[a][c] + (size_t)i * dc * dc; cplx t = 0; for (int j = 0; j < dc * dc; j++) t += Fb[j] * conj(DV[(size_t)v * NA + AOFF[c] + j]); s += dc * t; } H[(size_t)v * NA + AOFF[a] + i] = s; } }
  double *P = malloc(sizeof(double) * (size_t)NV * NV); long long nneg = 0; double pmin = 1e9;
  #pragma omp parallel for reduction(+:nneg)
  for (int u = 0; u < NV; u++) for (int v = 0; v < NV; v++) { cplx s = 0; for (int a = 0; a <= LMAX; a++) { int da = DIM[a]; for (int i = 0; i < da * da; i++) s += da * conj(DV[(size_t)u * NA + AOFF[a] + i]) * H[(size_t)v * NA + AOFF[a] + i]; } P[(size_t)u * NV + v] = creal(s); if (creal(s) < 0) nneg++; }
  for (size_t k = 0; k < (size_t)NV * NV; k++) if (P[k] < pmin) pmin = P[k];
  printf("L2DOB-CENSUS %s joint density on %d x %d (degB=%d): min %.6e, negative at %lld\n", tag, NV, NV, degB, pmin, nneg);
  /* ROAD B: K_{uv} = sqrt(w_u w_v) (P - pA pB)/sqrt(pA pB); power iteration on K^T K */
  double rhoB = -1; int okB = 1; for (int v = 0; v < NV; v++) if (qA[v] <= 0 || qB[v] <= 0) okB = 0;
  if (okB) { double *K = malloc(sizeof(double) * (size_t)NV * NV);
    for (int u = 0; u < NV; u++) for (int v = 0; v < NV; v++) K[(size_t)u * NV + v] = sqrt(RWV[u] * RWV[v]) * (P[(size_t)u * NV + v] - qA[u] * qB[v]) / sqrt(qA[u] * qB[v]);
    double *x = malloc(sizeof(double) * NV), *y = malloc(sizeof(double) * NV); for (int v = 0; v < NV; v++) x[v] = 1.0 + 0.37 * sin(1.7 * v + 0.3) + 0.11 * cos(5.3 * v);
    double lam = 0, lamold = -1; for (int it = 0; it < 3000; it++) {
      #pragma omp parallel for
      for (int u = 0; u < NV; u++) { double s = 0; for (int v = 0; v < NV; v++) s += K[(size_t)u * NV + v] * x[v]; y[u] = s; }
      #pragma omp parallel for
      for (int v = 0; v < NV; v++) { double s = 0; for (int u = 0; u < NV; u++) s += K[(size_t)u * NV + v] * y[u]; x[v] = s; }
      double nrm = 0; for (int v = 0; v < NV; v++) nrm += x[v] * x[v]; nrm = sqrt(nrm); for (int v = 0; v < NV; v++) x[v] /= nrm; lam = nrm;
      if (it > 50 && fabs(lam - lamold) < 1e-14 * lam) break; lamold = lam; }
    rhoB = sqrt(lam); free(K); free(x); free(y); }
  printf("L2DOB-ROADB %s rho = %.9f (degB=%d, %d points)%s\n", tag, rhoB, degB, NV, okB ? "" : " REFUSED: a marginal not positive on the rule");
  /* TV on a sub-rule of V's */
  quat *RT; double *RWT; int NT = make_rule(degTV, &RT, &RWT); cplx *HT = malloc(sizeof(cplx) * (size_t)NT * NA); double *qBT = malloc(sizeof(double) * NT); cplx *DT = malloc(sizeof(cplx) * (size_t)NT * NA);
  for (int t = 0; t < NT; t++) { for (int a = 0; a <= LMAX; a++) rep(a, RT[t], DT + (size_t)t * NA + AOFF[a]); }
  #pragma omp parallel for
  for (int t = 0; t < NT; t++) for (int a = 0; a <= LMAX; a++) { int da = DIM[a]; for (int i = 0; i < da * da; i++) { cplx s = 0; for (int c = 0; c <= LMAX; c++) { int dc = DIM[c]; const cplx *Fb = FH[a][c] + (size_t)i * dc * dc; cplx tt = 0; for (int j = 0; j < dc * dc; j++) tt += Fb[j] * conj(DT[(size_t)t * NA + AOFF[c] + j]); s += dc * tt; } HT[(size_t)t * NA + AOFF[a] + i] = s; } }
  for (int t = 0; t < NT; t++) qBT[t] = creal(HT[(size_t)t * NA + AOFF[0]]);
  double *CU = malloc(sizeof(double) * (size_t)NT * NU); /* conditional density p(U_u | V_t) on the degB rule in U */
  #pragma omp parallel for
  for (int t = 0; t < NT; t++) for (int u = 0; u < NU; u++) { cplx s = 0; for (int a = 0; a <= LMAX; a++) { int da = DIM[a]; for (int i = 0; i < da * da; i++) s += da * conj(DU[(size_t)u * NA + AOFF[a] + i]) * HT[(size_t)t * NA + AOFF[a] + i]; } CU[(size_t)t * NU + u] = creal(s) / qBT[t]; }
  double best = 0; int bt1 = -1, bt2 = -1;
  #pragma omp parallel
  { double lb = 0; int l1 = -1, l2 = -1;
    #pragma omp for schedule(dynamic)
    for (int t1 = 0; t1 < NT; t1++) for (int t2 = t1 + 1; t2 < NT; t2++) { double s = 0; for (int u = 0; u < NU; u++) s += RW[u] * fabs(CU[(size_t)t1 * NU + u] - CU[(size_t)t2 * NU + u]); s *= 0.5; if (s > lb) { lb = s; l1 = t1; l2 = t2; } }
    #pragma omp critical
    { if (lb > best) { best = lb; bt1 = l1; bt2 = l2; } } }
  printf("L2DOB-TV %s C_grid = %.9f (V on the degree-%d rule, %d points, U on degree %d) at angles %.4f %.4f\n", tag, best, degTV, NT, degB, bt1 >= 0 ? 2 * acos(RT[bt1].w) : -1, bt2 >= 0 ? 2 * acos(RT[bt2].w) : -1);
  /* local ascent on (V, V') from the grid maximiser and from the pair (1, -1): a refined LOWER bound on the supremum */
  { double *c1 = malloc(sizeof(double) * NU), *c2 = malloc(sizeof(double) * NU); cplx Hv[512];
    #define CONDV(Vq, out) do { for (int a_ = 0; a_ <= LMAX; a_++) { int da_ = DIM[a_]; cplx Dc_[16][256]; for (int c_ = 0; c_ <= LMAX; c_++) rep(c_, Vq, Dc_[c_]); for (int i_ = 0; i_ < da_ * da_; i_++) { cplx s_ = 0; for (int c_ = 0; c_ <= LMAX; c_++) { int dc_ = DIM[c_]; const cplx *Fb_ = FH[a_][c_] + (size_t)i_ * dc_ * dc_; cplx t_ = 0; for (int j_ = 0; j_ < dc_ * dc_; j_++) t_ += Fb_[j_] * conj(Dc_[c_][j_]); s_ += dc_ * t_; } Hv[AOFF[a_] + i_] = s_; } } \
      double pb_ = creal(Hv[AOFF[0]]); for (int u_ = 0; u_ < NU; u_++) { cplx s_ = 0; for (int a_ = 0; a_ <= LMAX; a_++) { int da_ = DIM[a_]; for (int i_ = 0; i_ < da_ * da_; i_++) s_ += da_ * conj(DU[(size_t)u_ * NA + AOFF[a_] + i_]) * Hv[AOFF[a_] + i_]; } out[u_] = creal(s_) / pb_; } } while (0)
    quat starts[3][2]; int ns = 0; if (bt1 >= 0) { starts[ns][0] = RT[bt1]; starts[ns][1] = RT[bt2]; ns++; } { quat e = { 1, 0, 0, 0 }, m = { -1, 0, 0, 0 }; starts[ns][0] = e; starts[ns][1] = m; ns++; }
    double bestR = best; unsigned long long seed = 88172645463325252ULL;
    for (int st = 0; st < ns; st++) { quat V1 = starts[st][0], V2 = starts[st][1]; CONDV(V1, c1); CONDV(V2, c2); double cur = 0; for (int u = 0; u < NU; u++) cur += RW[u] * fabs(c1[u] - c2[u]); cur *= 0.5;
      for (int it = 0; it < 1500; it++) { double step = 0.4 * pow(0.995, it); int which = it & 1; quat Vn = which ? V2 : V1; double dq[4];
        for (int k = 0; k < 4; k++) { seed ^= seed << 13; seed ^= seed >> 7; seed ^= seed << 17; dq[k] = ((seed >> 11) * (1.0 / 9007199254740992.0) - 0.5) * 2 * step; }
        quat Vt = { Vn.w + dq[0], Vn.x + dq[1], Vn.y + dq[2], Vn.z + dq[3] }; double nn = sqrt(Vt.w * Vt.w + Vt.x * Vt.x + Vt.y * Vt.y + Vt.z * Vt.z); Vt.w /= nn; Vt.x /= nn; Vt.y /= nn; Vt.z /= nn;
        double *ct = malloc(sizeof(double) * NU); CONDV(Vt, ct); double val = 0; for (int u = 0; u < NU; u++) val += RW[u] * fabs(ct[u] - (which ? c1[u] : c2[u])); val *= 0.5;
        if (val > cur) { cur = val; if (which) { V2 = Vt; memcpy(c2, ct, sizeof(double) * NU); } else { V1 = Vt; memcpy(c1, ct, sizeof(double) * NU); } } free(ct); }
      if (cur > bestR) bestR = cur; printf("L2DOB-TV-ASCENT %s start %d: C = %.9f at angles %.4f %.4f\n", tag, st, cur, 2 * acos(fmin(1, fmax(-1, V1.w))), 2 * acos(fmin(1, fmax(-1, V2.w)))); }
    best = bestR; free(c1); free(c2); }
  printf("L2DOB-RESULT %s rhoA=%.9f rhoB=%.9f sigmaH=%.9f Cgrid=%.9f rho/C=%.6f\n", tag, rhoA, rhoB, sH[0], best, best > 0 ? rhoA / best : -1); }

/* ---------------- the U(1) computation ---------------- */
static void u1_run(int ngrid, const char *tag) { int L = UL, NB = 2 * L; int idx[64]; int nb = 0; for (int a = -L; a <= L; a++) if (a != 0) idx[nb++] = a;
  cplx *G = calloc((size_t)NB * NB, sizeof(cplx)); for (int i = 0; i < NB; i++) for (int j = 0; j < NB; j++) { int a = idx[i], c = idx[j]; G[(size_t)i * NB + j] = UM[a + L][c + L] - UM[a + L][L] * UM[L][c + L]; }
  /* density w.r.t. dphi dpsi/(2pi)^2: p = sum M_{ac} e^{-i a phi} e^{-i c psi}; phi_a = e^{-i a phi} */
  double *pA = malloc(sizeof(double) * ngrid), *pB = malloc(sizeof(double) * ngrid); double mA = 1e9, mB = 1e9;
  for (int g = 0; g < ngrid; g++) { double x = 2 * PI * g / ngrid; cplx sa = 0, sb = 0; for (int a = -L; a <= L; a++) { sa += UM[a + L][L] * cexp(-I * a * x); sb += UM[L][a + L] * cexp(-I * a * x); } pA[g] = creal(sa); pB[g] = creal(sb); if (pA[g] < mA) mA = pA[g]; if (pB[g] < mB) mB = pB[g]; }
  double rhoA = -1; double sA[128] = { 0 };
  if (mA > 0 && mB > 0) { cplx *Phi = calloc((size_t)NB * NB, sizeof(cplx)), *Psi = calloc((size_t)NB * NB, sizeof(cplx));
    for (int g = 0; g < ngrid; g++) { double x = 2 * PI * g / ngrid, w = 1.0 / ngrid; for (int i = 0; i < NB; i++) for (int k = 0; k < NB; k++) { cplx fi = cexp(-I * idx[i] * x), fk = cexp(-I * idx[k] * x); Phi[(size_t)i * NB + k] += w * conj(fi) * fk / pA[g]; Psi[(size_t)i * NB + k] += w * fi * conj(fk) / pB[g]; } }
    cplx *Lc = calloc((size_t)NB * NB, sizeof(cplx)), *Mc = calloc((size_t)NB * NB, sizeof(cplx));
    if (cchol(NB, Phi, Lc) && cchol(NB, Psi, Mc)) { cplx *T1 = calloc((size_t)NB * NB, sizeof(cplx)), *X = calloc((size_t)NB * NB, sizeof(cplx));
      for (int i = 0; i < NB; i++) for (int j = 0; j < NB; j++) { cplx s = 0; for (int k = 0; k < NB; k++) s += G[(size_t)i * NB + k] * Mc[(size_t)k * NB + j]; T1[(size_t)i * NB + j] = s; }
      for (int i = 0; i < NB; i++) for (int j = 0; j < NB; j++) { cplx s = 0; for (int k = 0; k < NB; k++) s += conj(Lc[(size_t)k * NB + i]) * T1[(size_t)k * NB + j]; X[(size_t)i * NB + j] = s; }
      csvals(NB, NB, X, sA); rhoA = sA[0]; } }
  /* Haar-orthonormal: phi_a already orthonormal */ double sH[128]; csvals(NB, NB, G, sH);
  /* ROAD B and TV on the grid */ int NG = ngrid; double *P = malloc(sizeof(double) * (size_t)NG * NG); long long nneg = 0;
  for (int g = 0; g < NG; g++) for (int h = 0; h < NG; h++) { double x = 2 * PI * g / NG, y = 2 * PI * h / NG; cplx s = 0; for (int a = -L; a <= L; a++) for (int c = -L; c <= L; c++) s += UM[a + L][c + L] * cexp(-I * (a * x + c * y)); P[(size_t)g * NG + h] = creal(s); if (creal(s) < 0) nneg++; }
  double *K = malloc(sizeof(double) * (size_t)NG * NG); for (int g = 0; g < NG; g++) for (int h = 0; h < NG; h++) K[(size_t)g * NG + h] = (P[(size_t)g * NG + h] - pA[g] * pB[h]) / sqrt(pA[g] * pB[h]) / NG;
  double *x = malloc(sizeof(double) * NG), *y = malloc(sizeof(double) * NG); for (int v = 0; v < NG; v++) x[v] = 1.0 + 0.37 * sin(1.7 * v + 0.3) + 0.11 * cos(5.3 * v);
  double lam = 0, lamold = -1; for (int it = 0; it < 5000; it++) { for (int u = 0; u < NG; u++) { double s = 0; for (int v = 0; v < NG; v++) s += K[(size_t)u * NG + v] * x[v]; y[u] = s; } for (int v = 0; v < NG; v++) { double s = 0; for (int u = 0; u < NG; u++) s += K[(size_t)u * NG + v] * y[u]; x[v] = s; }
    double nrm = 0; for (int v = 0; v < NG; v++) nrm += x[v] * x[v]; nrm = sqrt(nrm); for (int v = 0; v < NG; v++) x[v] /= nrm; lam = nrm; if (it > 50 && fabs(lam - lamold) < 1e-14 * lam) break; lamold = lam; }
  double rhoB = sqrt(lam);
  double best = 0; for (int h1 = 0; h1 < NG; h1++) for (int h2 = h1 + 1; h2 < NG; h2++) { double s = 0; for (int g = 0; g < NG; g++) s += fabs(P[(size_t)g * NG + h1] / pB[h1] - P[(size_t)g * NG + h2] / pB[h2]) / NG; s *= 0.5; if (s > best) best = s; }
  printf("L2DOB-U1 %s L=%d grid %d: min p_A %.4e min p_B %.4e, joint negative at %lld; rhoA=%.9f rhoB=%.9f sigmaH=%.9f (next %.3e %.3e) Cgrid=%.9f rho/C=%.6f\n", tag, L, NG, mA, mB, nneg, rhoA, rhoB, sH[0], sA[1], sA[2], best, best > 0 ? rhoA / best : -1); }

int main(int argc, char **argv) { FACT[0] = 1; for (int i = 1; i < 40; i++) FACT[i] = FACT[i - 1] * i;
  if (argc < 2) { fprintf(stderr, "usage: l2dob <record> [degA] [degB] [degTV] | SYN2 eps | SYNU eps | SYNU2 eps\n"); return 1; }
  /* KR: the representation homomorphism decides GENINV, as w2_dob does */
  { int ok[2] = { 1, 1 }; for (int g = 0; g < 2; g++) { GENINV = g; for (int t = 0; t < 20; t++) { quat q1 = { cos(0.3 + t), sin(0.3 + t) * 0.6, sin(0.3 + t) * 0.0, sin(0.3 + t) * 0.8 }, q2 = { cos(1.1 * t + 0.2), sin(1.1 * t + 0.2) * 0.48, sin(1.1 * t + 0.2) * 0.6, sin(1.1 * t + 0.2) * 0.64 };
        for (int s = 1; s <= 4; s++) { cplx D1[64], D2[64], D12[64]; rep(s, q1, D1); rep(s, q2, D2); rep(s, qmul(q1, q2), D12); int d = s + 1; for (int i = 0; i < d; i++) for (int j = 0; j < d; j++) { cplx m = 0; for (int k = 0; k < d; k++) m += D1[i * d + k] * D2[k * d + j]; if (cabs(m - D12[i * d + j]) > 1e-10) ok[g] = 0; } } } }
    GENINV = ok[1] ? 1 : 0; printf("L2DOB-KAT KR homomorphism: GENINV=0 %s, GENINV=1 %s -> GENINV=%d\n", ok[0] ? "MET" : "fails", ok[1] ? "MET" : "fails", GENINV); }
  int degA = argc > 2 ? atoi(argv[2]) : 30, degB = argc > 3 ? atoi(argv[3]) : 20, degTV = argc > 4 ? atoi(argv[4]) : 12;
  if (!strcmp(argv[1], "SYN2")) { double eps = argc > 2 ? atof(argv[2]) : 0.05; LMAX = 2; alloc_F(); degA = 30; degB = 20; degTV = 12;
    FH[0][0][0] = 1; /* P^{11}_{rq,r'q'} = eps delta_rq delta_r'q' / 4: p = 1 + eps chi_1/2(U) chi_1/2(V) */
    for (int r = 0; r < 2; r++) for (int rp = 0; rp < 2; rp++) FH[1][1][fidx(2, 2, r, r, rp, rp)] = eps / 4;
    char tag[64]; snprintf(tag, sizeof tag, "SYN2(eps=%g)", eps); su2_run(degA, degB, degTV, tag); printf("L2DOB-KAT SYN2 expected rho = %.9f, C = 16 eps/(3 pi) = %.9f\n", eps, 16 * eps / (3 * PI)); return 0; }
  if (!strcmp(argv[1], "SYNU") || !strcmp(argv[1], "SYNU2")) { double eps = argc > 2 ? atof(argv[2]) : 0.05; UL = 2; for (int a = -2; a <= 2; a++) for (int c = -2; c <= 2; c++) UM[a + 2][c + 2] = 0; UM[2][2] = 1;
    /* SYNU: p = 1 + 2 eps cos(phi) cos(psi) = 1 + (eps/2)(e^{i phi}+e^{-i phi})(e^{i psi}+e^{-i psi}); M_{ac} = coefficient of e^{-i a phi} e^{-i c psi} */
    UM[1 + 2][1 + 2] = UM[-1 + 2][-1 + 2] = UM[1 + 2][-1 + 2] = UM[-1 + 2][1 + 2] = eps / 2;
    if (!strcmp(argv[1], "SYNU2")) { UM[2][1 + 2] = UM[2][-1 + 2] = 0.3; UM[1 + 2][2] = UM[-1 + 2][2] = 0.25; } /* non-uniform marginals */
    char tag[64]; snprintf(tag, sizeof tag, "%s(eps=%g)", argv[1], eps); u1_run(720, tag); printf("L2DOB-KAT %s expected (uniform marginals only) rho = %.9f, C = 4 eps/pi = %.9f\n", argv[1], eps, 4 * eps / PI); return 0; }
  /* SCHUR mode: the ordered datum's conjugation invariance makes F^{ac}/Z = sum_k f_k int chi_k(g) D^a(g) (x) D^c(g) dg; f_k from the record's
     W2-CHANNEL lines (a, c >= 1) and W2-CLASS lines (a = 0 or c = 0: the only channel is k = a + c) */
  if (!strcmp(argv[1], "SCHUR") && argc > 2) { const char *path = argv[2]; FILE *fs = fopen(path, "r"); if (!fs) { fprintf(stderr, "cannot open %s\n", path); return 1; } char ln[4096]; double fk[8][8][16]; int hk[8][8][16]; memset(hk, 0, sizeof hk); double cls[8][8]; int hc[8][8]; memset(hc, 0, sizeof hc);
    while (fgets(ln, sizeof ln, fs)) { if (!strncmp(ln, "W2-OBJECT", 9)) { char *p = strstr(ln, "LMAX="); if (p) LMAX = atoi(p + 5); }
      else if (!strncmp(ln, "W2-CLASS ", 9)) { int a, c; double v; if (sscanf(ln, "W2-CLASS a=%d c=%d E[chi_a(A) chi_c(B)] = %le", &a, &c, &v) == 3 && a < 8 && c < 8) { cls[a][c] = v; hc[a][c] = 1; } }
      else if (!strncmp(ln, "W2-CHANNEL ", 11) && strstr(ln, "f_k = ")) { int a, c, k; double v; if (sscanf(ln, "W2-CHANNEL a=%d c=%d k=%d f_k = %le", &a, &c, &k, &v) == 4 && a < 8 && c < 8 && k < 16) { fk[a][c][k] = v; hk[a][c][k] = 1; } } }
    fclose(fs); if (LMAX < 1) { fprintf(stderr, "SCHUR: no LMAX\n"); return 1; } alloc_F(); quat *RS; double *WS; int NS = make_rule(30, &RS, &WS);
    int missing = 0;
    for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= LMAX; c++) { int da = DIM[a], dc = DIM[c]; double fl[16]; int hl[16]; memset(hl, 0, sizeof hl);
      if (a == 0 || c == 0) { if (!hc[a][c]) { missing++; continue; } fl[a + c] = cls[a][c]; hl[a + c] = 1; } else { for (int k = abs(a - c); k <= a + c; k += 2) { if (!hk[a][c][k]) { missing++; continue; } fl[k] = fk[a][c][k]; hl[k] = 1; } }
      for (int u = 0; u < NS; u++) { cplx Da[256], Dc[256]; rep(a, RS[u], Da); rep(c, RS[u], Dc); double wch = 0; for (int k = 0; k < 16; k++) if (hl[k]) wch += fl[k] * chi(k, RS[u]); wch *= WS[u];
        for (int r = 0; r < da; r++) for (int q = 0; q < da; q++) for (int rp = 0; rp < dc; rp++) for (int qp = 0; qp < dc; qp++) FH[a][c][fidx(da, dc, r, q, rp, qp)] += wch * Da[r * da + q] * Dc[rp * dc + qp]; } }
    double chk = 0; for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= LMAX; c++) if (hc[a][c]) { int da = DIM[a], dc = DIM[c]; cplx t = 0; for (int r = 0; r < da; r++) for (int rp = 0; rp < dc; rp++) t += FH[a][c][fidx(da, dc, r, r, rp, rp)]; double e = fabs(creal(t) - cls[a][c]); if (e > chk) chk = e; }
    const char *bs = strrchr(path, '/'); bs = bs ? bs + 1 : path; char tag[512]; snprintf(tag, sizeof tag, "%s[SCHUR]", bs);
    printf("L2DOB-SCHUR %s: LMAX=%d, %d channel blocks missing; class moments recovered from the reconstruction to %.2e [%s]\n", bs, LMAX, missing, chk, (missing == 0 && chk < 1e-10) ? "MET" : "FAILED");
    if (missing == 0 && chk < 1e-10) su2_run(argc > 3 ? atoi(argv[3]) : 30, argc > 4 ? atoi(argv[4]) : 20, argc > 5 ? atoi(argv[5]) : 12, tag); return 0; }
  /* a record */
  FILE *f = fopen(argv[1], "r"); if (!f) { fprintf(stderr, "cannot open %s\n", argv[1]); return 1; } char line[4096]; int isU1 = 0; if (fgets(line, sizeof line, f) && !strncmp(line, "U1-", 3)) isU1 = 1; fclose(f);
  const char *base = strrchr(argv[1], '/'); base = base ? base + 1 : argv[1];
  if (isU1) { int n = read_u1(argv[1]); printf("L2DOB-RECORD %s: U(1), LMAX=%d, %d moments read\n", base, UL, n); u1_run(degA > 100 ? degA : 720, base); }
  else { int n = read_su2(argv[1]); printf("L2DOB-RECORD %s: SU(2), LMAX=%d, GENINV(record)=%d, %d F entries\n", base, LMAX, GENREC, n); if (GENREC != GENINV) printf("L2DOB-KAT KR GENINV disagrees with the record: REFUSED\n"); else su2_run(degA, degB, degTV, base); }
  return 0; }
