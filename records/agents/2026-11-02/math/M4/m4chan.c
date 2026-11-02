/* m4chan.c -- M4's CHANNEL reader: the maximal correlation of the two coarse loops of the two-face object at a fine datum,
 * SPLIT BY THE CENTRE (A -> -A): the SO(3) (integer-spin) channel rho_EE, the O-channel blocks of Lemma 3.1 (f_perp with
 * E[f_perp | A~] = 0), the half-integer Peter-Weyl channel, and Lemma 3.2's label sensitivities tau_A, tau_B with the vortex
 * free energy F = log p(U,V) - log p(-U,V).
 * The representation code (Dsub, rep), the product rule, the dump reader and the SCHUR reconstruction are copied VERBATIM from
 * M2's l2dob.c (which copied them from the engine w2_strip_n.c / w2_dob.c), so the convention is the record's.
 * Real orthonormal Peter-Weyl basis: per block a (spin a/2) the real span of sqrt(d_a) D^a_{rq}, orthonormalised on an exact rule.
 * usage: m4chan SU2 <dump> [degG=30] [degT=16] | m4chan SCHUR <record> [degG] [degT] | m4chan U1 <dump> [NG=2048] [NT=256]
 *        m4chan SYN {chi|chiE|chiM|chiA} | m4chan SYNU {1|2}
 * build: gcc -O2 -o m4chan.exe m4chan.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
#undef I
#define CI _Complex_I
typedef double complex cplx;
#define PI 3.141592653589793
typedef struct { double w, x, y, z; } quat;
static quat qmul(quat a, quat b) { quat r; r.w = a.w*b.w - a.x*b.x - a.y*b.y - a.z*b.z; r.x = a.w*b.x + a.x*b.w + a.y*b.z - a.z*b.y; r.y = a.w*b.y - a.x*b.z + a.y*b.w + a.z*b.x; r.z = a.w*b.z + a.x*b.y - a.y*b.x + a.z*b.w; return r; }
static quat qinv(quat a) { quat r = { a.w, -a.x, -a.y, -a.z }; return r; }
static double FACT[40]; static int GENINV = 0;
static double chi(int s, quat q) { double w = q.w, u0 = 1, u1 = 2 * w; if (s == 0) return u0; for (int k = 2; k <= s; k++) { double u2 = 2 * w * u1 - u0; u0 = u1; u1 = u2; } return u1; }
static void Dsub(int s, quat q, cplx *D) {
  cplx a = q.w + CI * q.x, b = q.y + CI * q.z, ab = q.w - CI * q.x, nbb = -q.y + CI * q.z;
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

/* ---------------- real symmetric eigen-decomposition with vectors (cyclic Jacobi) ---------------- */
static void jacobi_v(int n, double *a, double *ev, double *V) { /* a destroyed; V columns = eigenvectors (V[i*n+k] = component i of vector k) */
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) V[i * n + j] = (i == j);
  for (int sweep = 0; sweep < 200; sweep++) { double off = 0, tot = 0; for (int p = 0; p < n; p++) for (int q = 0; q < n; q++) { if (p != q) off += a[p * n + q] * a[p * n + q]; tot += a[p * n + q] * a[p * n + q]; } if (off <= 1e-30 * (tot > 1e-300 ? tot : 1)) break;
    for (int p = 0; p < n; p++) for (int q = p + 1; q < n; q++) { double apq = a[p * n + q]; if (fabs(apq) < 1e-300) continue; double th = (a[q * n + q] - a[p * n + p]) / (2 * apq); double t = (th >= 0 ? 1 : -1) / (fabs(th) + sqrt(th * th + 1)); double c = 1 / sqrt(t * t + 1), s = t * c;
      for (int k = 0; k < n; k++) { double akp = a[k * n + p], akq = a[k * n + q]; a[k * n + p] = c * akp - s * akq; a[k * n + q] = s * akp + c * akq; }
      for (int k = 0; k < n; k++) { double apk = a[p * n + k], aqk = a[q * n + k]; a[p * n + k] = c * apk - s * aqk; a[q * n + k] = s * apk + c * aqk; }
      for (int k = 0; k < n; k++) { double vkp = V[k * n + p], vkq = V[k * n + q]; V[k * n + p] = c * vkp - s * vkq; V[k * n + q] = s * vkp + c * vkq; } } }
  for (int i = 0; i < n; i++) ev[i] = a[i * n + i]; }
/* f(S) for symmetric S (n x n): out = V diag(f(ev)) V^T; mode 0: sqrt (clip <0 to 0), mode 1: inverse sqrt (only on ev > tol, pseudo), mode 2: inverse */
static void symfun(int n, const double *S, double *out, int mode, double *minev) { double *a = malloc(sizeof(double) * n * n), *V = malloc(sizeof(double) * n * n), *ev = malloc(sizeof(double) * n);
  memcpy(a, S, sizeof(double) * n * n); jacobi_v(n, a, ev, V); double mn = 1e300; for (int k = 0; k < n; k++) if (ev[k] < mn) mn = ev[k]; if (minev) *minev = mn;
  double emax = 0; for (int k = 0; k < n; k++) if (fabs(ev[k]) > emax) emax = fabs(ev[k]);
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) { double s = 0; for (int k = 0; k < n; k++) { double f;
        if (mode == 0) f = ev[k] > 0 ? sqrt(ev[k]) : 0; else if (mode == 1) f = ev[k] > 1e-13 * emax ? 1 / sqrt(ev[k]) : 0; else f = ev[k] > 1e-13 * emax ? 1 / ev[k] : 0;
        s += V[i * n + k] * f * V[j * n + k]; } out[i * n + j] = s; }
  free(a); free(V); free(ev); }
/* largest singular value of the n x m real matrix X */
static double smax(int n, int m, const double *X) { double *H = calloc((size_t)n * n, sizeof(double)), *V = malloc(sizeof(double) * n * n), *ev = malloc(sizeof(double) * n);
  for (int i = 0; i < n; i++) for (int k = 0; k < n; k++) { double t = 0; for (int j = 0; j < m; j++) t += X[i * m + j] * X[k * m + j]; H[i * n + k] = t; }
  jacobi_v(n, H, ev, V); double mx = 0; for (int i = 0; i < n; i++) if (ev[i] > mx) mx = ev[i]; free(H); free(V); free(ev); return sqrt(mx); }
/* ||A^{1/2} G B^{1/2}||, all n x n, with A12 = A^{1/2} and B12 = B^{1/2} supplied */
static double blocknorm(int n, const double *A12, const double *G, const double *B12) { double *T = malloc(sizeof(double) * n * n), *X = malloc(sizeof(double) * n * n);
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) { double s = 0; for (int k = 0; k < n; k++) s += G[i * n + k] * B12[k * n + j]; T[i * n + j] = s; }
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) { double s = 0; for (int k = 0; k < n; k++) s += A12[i * n + k] * T[k * n + j]; X[i * n + j] = s; }
  double r = smax(n, n, X); free(T); free(X); return r; }

/* ---------------- the SU(2) record (verbatim from l2dob.c) ---------------- */
static int LMAX = -1, GENREC = -1; static double Z = 0; static int DIM[16]; static cplx *FH[16][16];
static inline size_t fidx(int da, int dc, int r, int q, int rp, int qp) { return ((size_t)(r * da + q)) * dc * dc + rp * dc + qp; }
static void alloc_F(void) { for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= LMAX; c++) { DIM[a] = a + 1; DIM[c] = c + 1; FH[a][c] = calloc((size_t)DIM[a] * DIM[a] * DIM[c] * DIM[c], sizeof(cplx)); } }
static int read_su2(const char *path) { FILE *f = fopen(path, "r"); if (!f) { fprintf(stderr, "cannot open %s\n", path); exit(1); } char line[4096]; int nf = 0;
  while (fgets(line, sizeof line, f)) {
    if (!strncmp(line, "W2-FHEAD", 8)) { if (sscanf(line, "W2-FHEAD GENINV=%d Z=%le LMAX=%d", &GENREC, &Z, &LMAX) != 3) { fprintf(stderr, "bad FHEAD\n"); exit(1); } alloc_F(); }
    else if (!strncmp(line, "W2-F ", 5)) { int a, c, r, q, rp, qp; double re, im; if (sscanf(line, "W2-F a=%d c=%d r=%d q=%d rp=%d qp=%d %le %le", &a, &c, &r, &q, &rp, &qp, &re, &im) != 8) { fprintf(stderr, "bad F line\n"); exit(1); }
      FH[a][c][fidx(DIM[a], DIM[c], r, q, rp, qp)] = (re + CI * im) / Z; nf++; } }
  fclose(f); return nf; }

/* ---------------- U(1) record (verbatim from l2dob.c) ---------------- */
static int UL = -1; static cplx UM[64][64]; static int UHAS[64][64];
static int read_u1(const char *path) { FILE *f = fopen(path, "r"); if (!f) { fprintf(stderr, "cannot open %s\n", path); exit(1); } char line[4096]; int n = 0;
  while (fgets(line, sizeof line, f)) { if (!strncmp(line, "U1-OBJECT", 9)) { char *p = strstr(line, "LMAX="); if (p) UL = atoi(p + 5); }
    else if (!strncmp(line, "U1-CLASS ", 9)) { int a, c; double re, im; if (sscanf(line, "U1-CLASS a=%d c=%d E[e^{ia Phi_A} e^{ic Phi_B}] = %le %le", &a, &c, &re, &im) == 4) { if (UL < 0) { fprintf(stderr, "U1 LMAX unknown\n"); exit(1); } UM[a + UL][c + UL] = re + CI * im; UHAS[a + UL][c + UL] = 1; n++; } } }
  fclose(f);
  for (int a = -UL; a <= UL; a++) for (int c = -UL; c <= UL; c++) if (!UHAS[a + UL][c + UL] && UHAS[-a + UL][-c + UL]) { UM[a + UL][c + UL] = conj(UM[-a + UL][-c + UL]); UHAS[a + UL][c + UL] = 2; }
  int miss = 0; for (int a = -UL; a <= UL; a++) for (int c = -UL; c <= UL; c++) if (!UHAS[a + UL][c + UL]) miss++;
  if (miss) { fprintf(stderr, "U1: %d moments missing after conjugation\n", miss); exit(1); } return n; }

/* ---------------- the channel analysis, common to both groups ----------------
 * NB real basis functions indexed 0..NB-1 with 0 the constant; par[I] in {0,1}; P[I*NB+J] = E[e_I(A) e_J(B)] (the joint law's
 * real Peter-Weyl coefficients), EV(u,I) = e_I at grid point u of a rule with weights W (the rule integrates against normalized Haar),
 * EVT(u,I) the same on the tau rule. e_I(-U) = (-1)^{par I} e_I(U). */
static void channel_run(const char *tag, int NB, const int *par, const double *P, int NG, const double *W, const double *EV, int NT, const double *WT, const double *EVT) {
  int n = NB - 1; /* nonconstant indices 1..NB-1 mapped to 0..n-1 */
  double *m = malloc(sizeof(double) * NB), *nn = malloc(sizeof(double) * NB); for (int I = 0; I < NB; I++) { m[I] = P[I * NB + 0]; nn[I] = P[0 * NB + I]; }
  double *G = calloc((size_t)n * n, sizeof(double)); for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) G[i * n + j] = P[(i + 1) * NB + (j + 1)] - m[i + 1] * nn[j + 1];
  /* the Grams on the G rule */
  double *PhA = calloc((size_t)n * n, sizeof(double)), *PhB = calloc((size_t)n * n, sizeof(double)), *EA = calloc((size_t)n * n, sizeof(double)), *EB = calloc((size_t)n * n, sizeof(double));
  double *KA = calloc((size_t)n * n, sizeof(double)), *KB = calloc((size_t)n * n, sizeof(double)), *QA = calloc((size_t)n * n, sizeof(double)), *QB = calloc((size_t)n * n, sizeof(double));
  double minpA = 1e300, minpB = 1e300; double *kA = malloc(sizeof(double) * n), *kB = malloc(sizeof(double) * n);
  for (int u = 0; u < NG; u++) { const double *e = EV + (size_t)u * NB; double pAp = 0, pAm = 0, pBp = 0, pBm = 0;
    for (int I = 0; I < NB; I++) { double sg = par[I] ? -1 : 1; pAp += m[I] * e[I]; pAm += m[I] * sg * e[I]; pBp += nn[I] * e[I]; pBm += nn[I] * sg * e[I]; }
    if (pAp < minpA) minpA = pAp; if (pAm < minpA) minpA = pAm; if (pBp < minpB) minpB = pBp; if (pBm < minpB) minpB = pBm;
    if (pAp <= 0 || pAm <= 0 || pBp <= 0 || pBm <= 0) continue; /* refused below */
    double aA = 1 / pAp, bA = 1 / pAm, aB = 1 / pBp, bB = 1 / pBm, sA = 0.5 * (aA + bA), sB = 0.5 * (aB + bB), evA = 0.5 * (pAp + pAm), evB = 0.5 * (pBp + pBm);
    for (int i = 0; i < n; i++) { int I = i + 1; double sg = par[I] ? -1 : 1; kA[i] = 0.5 * (e[I] * aA - sg * e[I] * bA); kB[i] = 0.5 * (e[I] * aB - sg * e[I] * bB); }
    for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) { int I = i + 1, J = j + 1; double sg = ((par[I] + par[J]) & 1) ? -1 : 1, ee = e[I] * e[J], w = W[u];
      PhA[i * n + j] += w * ee * 0.5 * (aA + sg * bA); PhB[i * n + j] += w * ee * 0.5 * (aB + sg * bB);
      if (!par[I] && !par[J]) { EA[i * n + j] += w * ee / evA; EB[i * n + j] += w * ee / evB; }
      if (par[I] && par[J]) { QA[i * n + j] += w * ee / evA; QB[i * n + j] += w * ee / evB; }
      KA[i * n + j] += w * kA[i] * kA[j] / sA; KB[i * n + j] += w * kB[i] * kB[j] / sB; } }
  if (minpA <= 0 || minpB <= 0) { printf("M4CHAN-REFUSED %s: a marginal is not positive on the rule (min p_A %.3e, min p_B %.3e)\n", tag, minpA, minpB); return; }
  double dsum = 0; for (int k = 0; k < n * n; k++) { double d1 = fabs(PhA[k] - EA[k] - KA[k]), d2 = fabs(PhB[k] - EB[k] - KB[k]); if (d1 > dsum) dsum = d1; if (d2 > dsum) dsum = d2; }
  printf("M4CHAN-KAT %s K-sum: max|Phi - E - K| = %.3e [%s]\n", tag, dsum, dsum < 1e-11 ? "MET" : "FAILED");
  double *A12 = malloc(sizeof(double) * n * n), *B12 = malloc(sizeof(double) * n * n), *EA12 = malloc(sizeof(double) * n * n), *EB12 = malloc(sizeof(double) * n * n), *KA12 = malloc(sizeof(double) * n * n), *KB12 = malloc(sizeof(double) * n * n), mev;
  symfun(n, PhA, A12, 0, &mev); symfun(n, PhB, B12, 0, NULL); symfun(n, EA, EA12, 0, NULL); symfun(n, EB, EB12, 0, NULL); symfun(n, KA, KA12, 0, NULL); symfun(n, KB, KB12, 0, NULL);
  double rho = blocknorm(n, A12, G, B12), rEE = blocknorm(n, EA12, G, EB12), rOO = blocknorm(n, KA12, G, KB12), rEO = blocknorm(n, EA12, G, KB12), rOE = blocknorm(n, KA12, G, EB12);
  double rOd = blocknorm(n, KA12, G, B12), rdO = blocknorm(n, A12, G, KB12);
  /* the half-integer Peter-Weyl channel: N = (Phi^ev_oo)^{-1} - m_o m_o^T on odd indices */
  int no = 0, oi[256]; for (int i = 0; i < n; i++) if (par[i + 1]) oi[no++] = i; double rPW = -1;
  if (no > 0) { double *Qa = malloc(sizeof(double) * no * no), *Qb = malloc(sizeof(double) * no * no), *Na = malloc(sizeof(double) * no * no), *Nb = malloc(sizeof(double) * no * no), *Gs = malloc(sizeof(double) * no * no);
    for (int i = 0; i < no; i++) for (int j = 0; j < no; j++) { Qa[i * no + j] = QA[oi[i] * n + oi[j]]; Qb[i * no + j] = QB[oi[i] * n + oi[j]]; Gs[i * no + j] = G[oi[i] * n + oi[j]]; }
    double *Qai = malloc(sizeof(double) * no * no), *Qbi = malloc(sizeof(double) * no * no); symfun(no, Qa, Qai, 2, NULL); symfun(no, Qb, Qbi, 2, NULL);
    for (int i = 0; i < no; i++) for (int j = 0; j < no; j++) { Na[i * no + j] = Qai[i * no + j] - m[oi[i] + 1] * m[oi[j] + 1]; Nb[i * no + j] = Qbi[i * no + j] - nn[oi[i] + 1] * nn[oi[j] + 1]; }
    double *Nai = malloc(sizeof(double) * no * no), *Nbi = malloc(sizeof(double) * no * no); symfun(no, Na, Nai, 1, NULL); symfun(no, Nb, Nbi, 1, NULL);
    rPW = blocknorm(no, Nai, Gs, Nbi); free(Qa); free(Qb); free(Na); free(Nb); free(Gs); free(Qai); free(Qbi); free(Nai); free(Nbi); }
  /* Lemma 3.2(i) on the tau rule: tau_A (A's label against B), tau_B (B's label against A) */
  double tauA = 0, tauB = 0, DelA = 0, DelB = 0, FmA = 0, FmB = 0, pmin = 1e300; int bad = 0;
  double *rowp = malloc(sizeof(double) * NB), *rowm = malloc(sizeof(double) * NB);
  for (int side = 0; side < 2; side++) {
    for (int u = 0; u < NT; u++) { const double *e = EVT + (size_t)u * NB; /* the orbit variable's point U (A for side 0, B for side 1) */
      for (int J = 0; J < NB; J++) { double sp = 0, sm = 0; for (int I = 0; I < NB; I++) { double c = side == 0 ? P[I * NB + J] : P[J * NB + I]; double sg = par[I] ? -1 : 1; sp += c * e[I]; sm += c * sg * e[I]; } rowp[J] = sp; rowm[J] = sm; }
      double mp = 0, mm = 0; for (int I = 0; I < NB; I++) { double c = side == 0 ? m[I] : nn[I]; double sg = par[I] ? -1 : 1; mp += c * e[I]; mm += c * sg * e[I]; }
      double t0 = (mp - mm) / (mp + mm); double S0 = 0, S1 = 0, S2 = 0, Fmx = -1e300, Fmn = 1e300;
      static double tv[200000], ov[200000]; int nv = 0; /* two-pass variance (the one-pass form left a sqrt-of-roundoff floor ~1e-8) */
      for (int v = 0; v < NT; v++) { const double *f = EVT + (size_t)v * NB; double pp = 0, pm = 0; for (int J = 0; J < NB; J++) { pp += rowp[J] * f[J]; pm += rowm[J] * f[J]; }
        if (pp < pmin) pmin = pp; if (pm < pmin) pmin = pm; if (pp <= 0 || pm <= 0) { bad = 1; continue; }
        double t = (pp - pm) / (pp + pm), om = WT[v] * (pp + pm); S0 += om; S1 += om * t; tv[nv] = t; ov[nv] = om; nv++; double F = log(pp / pm); if (F > Fmx) Fmx = F; if (F < Fmn) Fmn = F; }
      double mean = S1 / S0; for (int k = 0; k < nv; k++) S2 += ov[k] * (tv[k] - mean) * (tv[k] - mean); double var = S2 / S0; if (var < 0) var = 0; double r = sqrt(var) / sqrt(1 - t0 * t0);
      if (side == 0) { if (r > tauA) tauA = r; if (Fmx - Fmn > DelA) DelA = Fmx - Fmn; if (fabs(Fmx) > FmA) FmA = fabs(Fmx); if (fabs(Fmn) > FmA) FmA = fabs(Fmn); }
      else { if (r > tauB) tauB = r; if (Fmx - Fmn > DelB) DelB = Fmx - Fmn; if (fabs(Fmx) > FmB) FmB = fabs(Fmx); if (fabs(Fmn) > FmB) FmB = fabs(Fmn); } } }
  double bA = 0.25 * DelA * cosh(0.5 * FmA), bB = 0.25 * DelB * cosh(0.5 * FmB);
  double L31 = sqrt(rEE * rEE + tauA * tauA + tauB * tauB), EXB = sqrt(rEE * rEE + rEO * rEO + rOd * rOd);
  printf("M4CHAN-POS %s min joint density on the tau rule %.4e%s; min p_A %.4e, min p_B %.4e; min eigenvalue of Phi_A %.3e\n", tag, pmin, bad ? " SIGNED: tau REFUSED" : "", minpA, minpB, mev);
  printf("M4CHAN-RHO %s rho = %.9f | SO(3) channel rho_EE = %.9f | O-channel: rho_OO = %.9f rho_EO = %.9f rho_OE = %.9f rho_O. = %.9f rho_.O = %.9f | half-integer PW rho_oo = %.9f\n", tag, rho, rEE, rOO, rEO, rOE, rOd, rdO, rPW);
  printf("M4CHAN-SHARE %s rho_EE/rho = %.6f   rho_OO/rho = %.6f   rho_EE/rho_OO^2 = %.6g\n", tag, rho > 0 ? rEE / rho : -1, rho > 0 ? rOO / rho : -1, rOO > 0 ? rEE / (rOO * rOO) : -1);
  if (!bad) printf("M4CHAN-TAU %s tau_A = %.9f tau_B = %.9f | Delta_A = osc_V F = %.6g (max|F| %.6g) -> bound %.6g | Delta_B = %.6g (max|F| %.6g) -> bound %.6g [tau <= bound: %s]\n", tag, tauA, tauB, DelA, FmA, bA, DelB, FmB, bB, (tauA <= bA * (1 + 1e-9) + 1e-14 && tauB <= bB * (1 + 1e-9) + 1e-14) ? "MET" : "FAILED");
  printf("M4CHAN-BOUND %s Lemma 3.1: (rho_EE^2 + tau_A^2 + tau_B^2)^(1/2) = %.9f, ratio to rho %.4f [%s]; exact blocks (rho_EE^2 + rho_EO^2 + rho_O.^2)^(1/2) = %.9f [%s]\n", tag, L31, rho > 0 ? L31 / rho : -1, (!bad && L31 >= rho * (1 - 1e-7)) ? "MET" : (bad ? "n/a" : "FAILED"), EXB, EXB >= rho * (1 - 1e-7) ? "MET" : "FAILED");
  free(m); free(nn); free(G); free(PhA); free(PhB); free(EA); free(EB); free(KA); free(KB); free(QA); free(QB); free(kA); free(kB); free(A12); free(B12); free(EA12); free(EB12); free(KA12); free(KB12); free(rowp); free(rowm); }

/* ---------------- SU(2): the real basis and the transform from the dump ---------------- */
static int RB_NB, RB_BOFF[16], RB_BSZ[16]; static int RB_par[512]; static double *RB_COEF[16]; /* per block a: (a+1)^2 real functions, each = sum_k COEF[r][k] * g_k, g_{2k} = Re(sqrt(d) D_k), g_{2k+1} = Im(...) */
static void su2_basis(void) { quat *RU; double *RW; int NU = make_rule(2 * LMAX + 4, &RU, &RW); RB_NB = 0;
  for (int a = 0; a <= LMAX; a++) { int K = (a + 1) * (a + 1), M = 2 * K; RB_BOFF[a] = RB_NB; RB_BSZ[a] = K; RB_COEF[a] = calloc((size_t)K * M, sizeof(double));
    if (a == 0) { RB_COEF[0][0] = 1; RB_par[RB_NB] = 0; RB_NB += 1; continue; }
    double *Gm = calloc((size_t)M * M, sizeof(double)), *g = malloc(sizeof(double) * M); cplx D[256]; double sd = sqrt((double)(a + 1));
    for (int u = 0; u < NU; u++) { rep(a, RU[u], D); for (int k = 0; k < K; k++) { g[2 * k] = sd * creal(D[k]); g[2 * k + 1] = sd * cimag(D[k]); }
      for (int i = 0; i < M; i++) for (int j = 0; j < M; j++) Gm[i * M + j] += RW[u] * g[i] * g[j]; }
    double *V = malloc(sizeof(double) * M * M), *ev = malloc(sizeof(double) * M); jacobi_v(M, Gm, ev, V); int kept = 0;
    for (int k = 0; k < M; k++) if (ev[k] > 0.25) { for (int i = 0; i < M; i++) RB_COEF[a][kept * M + i] = V[i * M + k] / sqrt(ev[k]); kept++; }
    if (kept != K) { fprintf(stderr, "basis block %d: kept %d of %d\n", a, kept, K); exit(1); }
    for (int k = 0; k < K; k++) RB_par[RB_NB + k] = a & 1; RB_NB += K; free(Gm); free(g); free(V); free(ev); }
  free(RU); free(RW); }
static void su2_eval(quat U, double *e) { cplx D[256]; for (int a = 0; a <= LMAX; a++) { int K = RB_BSZ[a], M = 2 * K; if (a == 0) { e[0] = 1; continue; } rep(a, U, D); double sd = sqrt((double)(a + 1)), g[512];
    for (int k = 0; k < K; k++) { g[2 * k] = sd * creal(D[k]); g[2 * k + 1] = sd * cimag(D[k]); }
    for (int r = 0; r < K; r++) { double s = 0; for (int i = 0; i < M; i++) s += RB_COEF[a][r * M + i] * g[i]; e[RB_BOFF[a] + r] = s; } } }
static void su2_run(const char *tag, int degG, int degT) {
  su2_basis(); int NB = RB_NB;
  /* transform M^a(rq, I) = d_a int conj(D^a_rq) e_I on an exact rule */
  quat *RU; double *RW; int NU = make_rule(2 * LMAX + 4, &RU, &RW); cplx *TM[16]; for (int a = 0; a <= LMAX; a++) TM[a] = calloc((size_t)DIM[a] * DIM[a] * NB, sizeof(cplx));
  double *e = malloc(sizeof(double) * NB); cplx D[256];
  for (int u = 0; u < NU; u++) { su2_eval(RU[u], e); for (int a = 0; a <= LMAX; a++) { rep(a, RU[u], D); int K = DIM[a] * DIM[a]; for (int k = 0; k < K; k++) for (int I = RB_BOFF[a]; I < RB_BOFF[a] + RB_BSZ[a]; I++) TM[a][(size_t)k * NB + I] += RW[u] * DIM[a] * conj(D[k]) * e[I]; } }
  double *P = calloc((size_t)NB * NB, sizeof(double)); double imax = 0;
  for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= LMAX; c++) { int da = DIM[a], dc = DIM[c];
    for (int I = RB_BOFF[a]; I < RB_BOFF[a] + RB_BSZ[a]; I++) for (int J = RB_BOFF[c]; J < RB_BOFF[c] + RB_BSZ[c]; J++) { cplx s = 0;
        for (int k = 0; k < da * da; k++) { cplx tk = TM[a][(size_t)k * NB + I]; if (tk == 0) continue; for (int l = 0; l < dc * dc; l++) s += FH[a][c][(size_t)k * dc * dc + l] * tk * TM[c][(size_t)l * NB + J]; }
        P[I * NB + J] = creal(s); if (fabs(cimag(s)) > imax) imax = fabs(cimag(s)); } }
  printf("M4CHAN-KAT %s K-real: P(0,0) = %.15f, max|Im P| = %.3e [%s]; basis %d real functions to spin %d/2\n", tag, P[0], imax, (fabs(P[0] - 1) < 1e-10 && imax < 1e-10) ? "MET" : "FAILED", NB, LMAX);
  quat *RG; double *WG; int NG = make_rule(degG, &RG, &WG); double *EV = malloc(sizeof(double) * (size_t)NG * NB); for (int u = 0; u < NG; u++) su2_eval(RG[u], EV + (size_t)u * NB);
  quat *RT; double *WT; int NT = make_rule(degT, &RT, &WT); double *EVT = malloc(sizeof(double) * (size_t)NT * NB); for (int u = 0; u < NT; u++) su2_eval(RT[u], EVT + (size_t)u * NB);
  char t2[600]; snprintf(t2, sizeof t2, "%s[G%d,T%d]", tag, degG, degT);
  channel_run(t2, NB, RB_par, P, NG, WG, EV, NT, WT, EVT); }

/* ---------------- U(1): basis 1, sqrt2 cos n phi, sqrt2 sin n phi ---------------- */
static void u1_eval(int L, double x, double *e) { e[0] = 1; for (int k = 1; k <= L; k++) { e[2 * k - 1] = sqrt(2.0) * cos(k * x); e[2 * k] = sqrt(2.0) * sin(k * x); } }
static void u1_run(const char *tag, int NGr, int NTr) { int L = UL, NB = 2 * L + 1; int par[256]; par[0] = 0; for (int k = 1; k <= L; k++) { par[2 * k - 1] = k & 1; par[2 * k] = k & 1; }
  int Nq = 8 * L + 8; double *P = calloc((size_t)NB * NB, sizeof(double)), *e1 = malloc(sizeof(double) * NB), *e2 = malloc(sizeof(double) * NB); double imax = 0;
  for (int g = 0; g < Nq; g++) for (int h = 0; h < Nq; h++) { double x = 2 * PI * g / Nq, y = 2 * PI * h / Nq; cplx s = 0; for (int a = -L; a <= L; a++) for (int c = -L; c <= L; c++) s += UM[a + L][c + L] * cexp(-CI * (a * x + c * y)); if (fabs(cimag(s)) > imax) imax = fabs(cimag(s));
    u1_eval(L, x, e1); u1_eval(L, y, e2); for (int i = 0; i < NB; i++) for (int j = 0; j < NB; j++) P[i * NB + j] += creal(s) * e1[i] * e2[j] / ((double)Nq * Nq); }
  printf("M4CHAN-KAT %s K-real: P(0,0) = %.15f, max|Im p| on the grid = %.3e [%s]; basis %d real functions to charge %d\n", tag, P[0], imax, (fabs(P[0] - 1) < 1e-10 && imax < 1e-10) ? "MET" : "FAILED", NB, L);
  double *W = malloc(sizeof(double) * NGr), *EV = malloc(sizeof(double) * (size_t)NGr * NB); for (int g = 0; g < NGr; g++) { W[g] = 1.0 / NGr; u1_eval(L, 2 * PI * g / NGr, EV + (size_t)g * NB); }
  double *WT = malloc(sizeof(double) * NTr), *EVT = malloc(sizeof(double) * (size_t)NTr * NB); for (int g = 0; g < NTr; g++) { WT[g] = 1.0 / NTr; u1_eval(L, 2 * PI * g / NTr, EVT + (size_t)g * NB); }
  char t2[600]; snprintf(t2, sizeof t2, "%s[NG%d,NT%d]", tag, NGr, NTr); channel_run(t2, NB, par, P, NGr, W, EV, NTr, WT, EVT); }

int main(int argc, char **argv) { FACT[0] = 1; for (int i = 1; i < 40; i++) FACT[i] = FACT[i - 1] * i;
  if (argc < 2) { fprintf(stderr, "usage: see header\n"); return 1; }
  { int ok[2] = { 1, 1 }; for (int g = 0; g < 2; g++) { GENINV = g; for (int t = 0; t < 20; t++) { quat q1 = { cos(0.3 + t), sin(0.3 + t) * 0.6, sin(0.3 + t) * 0.0, sin(0.3 + t) * 0.8 }, q2 = { cos(1.1 * t + 0.2), sin(1.1 * t + 0.2) * 0.48, sin(1.1 * t + 0.2) * 0.6, sin(1.1 * t + 0.2) * 0.64 };
        for (int s = 1; s <= 4; s++) { cplx D1[64], D2[64], D12[64]; rep(s, q1, D1); rep(s, q2, D2); rep(s, qmul(q1, q2), D12); int d = s + 1; for (int i = 0; i < d; i++) for (int j = 0; j < d; j++) { cplx mm = 0; for (int k = 0; k < d; k++) mm += D1[i * d + k] * D2[k * d + j]; if (cabs(mm - D12[i * d + j]) > 1e-10) ok[g] = 0; } } } }
    GENINV = ok[1] ? 1 : 0; printf("M4CHAN-KAT KR homomorphism: GENINV=0 %s, GENINV=1 %s -> GENINV=%d\n", ok[0] ? "MET" : "fails", ok[1] ? "MET" : "fails", GENINV); }
  if (!strcmp(argv[1], "SYN")) { const char *kind = argc > 2 ? argv[2] : "chi"; LMAX = 2; alloc_F(); FH[0][0][0] = 1; double e1 = 0.05, e2 = 0.03;
    if (!strcmp(kind, "chi") || !strcmp(kind, "chiM") || !strcmp(kind, "chiA")) for (int r = 0; r < 2; r++) for (int rp = 0; rp < 2; rp++) FH[1][1][fidx(2, 2, r, r, rp, rp)] = e1 / 4;
    if (!strcmp(kind, "chiE") || !strcmp(kind, "chiM")) for (int r = 0; r < 3; r++) for (int rp = 0; rp < 3; rp++) FH[2][2][fidx(3, 3, r, r, rp, rp)] = (!strcmp(kind, "chiE") ? e1 : e2) / 9;
    if (!strcmp(kind, "chiA")) for (int r = 0; r < 2; r++) FH[1][0][fidx(2, 1, r, r, 0, 0)] = 0.2 / 2; /* p_A = 1 + 0.2 chi_1/2(U): a non-symmetric marginal */
    char tag[64]; snprintf(tag, sizeof tag, "SYN-%s", kind); su2_run(tag, 30, 16);
    printf("M4CHAN-KAT %s expected: chi: rho=rho_OO=rho_oo=0.05, rho_EE=0, tau_A=tau_B=0.10 | chiE: rho=rho_EE=0.05, rho_OO=0, tau=0 | chiM: rho=0.05, rho_EE=0.03, rho_OO=0.05 | chiA: consistency only\n", tag); return 0; }
  if (!strcmp(argv[1], "SYNU")) { int k = argc > 2 ? atoi(argv[2]) : 1; double eps = 0.05; UL = 2; for (int a = -2; a <= 2; a++) for (int c = -2; c <= 2; c++) UM[a + 2][c + 2] = 0; UM[2][2] = 1;
    UM[k + 2][k + 2] = UM[-k + 2][-k + 2] = UM[k + 2][-k + 2] = UM[-k + 2][k + 2] = eps / 2; char tag[64]; snprintf(tag, sizeof tag, "SYNU-%d", k); u1_run(tag, 2048, 256);
    printf("M4CHAN-KAT %s expected: k=1: rho=rho_OO=0.05, rho_EE=0, tau_A=tau_B=%.9f | k=2: rho=rho_EE=0.05, rho_OO=0, tau=0\n", tag, sqrt(2.0) * eps); return 0; }
  if (!strcmp(argv[1], "SU2") && argc > 2) { int n = read_su2(argv[2]); const char *base = strrchr(argv[2], '/'); base = base ? base + 1 : argv[2];
    printf("M4CHAN-RECORD %s: SU(2), LMAX=%d, GENINV(record)=%d, %d F entries\n", base, LMAX, GENREC, n); if (GENREC != GENINV) { printf("M4CHAN-KAT KR GENINV disagrees with the record: REFUSED\n"); return 1; }
    su2_run(base, argc > 3 ? atoi(argv[3]) : 30, argc > 4 ? atoi(argv[4]) : 16); return 0; }
  if (!strcmp(argv[1], "SCHUR") && argc > 2) { const char *path = argv[2]; FILE *fs = fopen(path, "r"); if (!fs) { fprintf(stderr, "cannot open %s\n", path); return 1; } char ln[4096]; static double fk[8][8][16]; static int hk[8][8][16]; double cls[8][8]; int hc[8][8]; memset(hk, 0, sizeof hk); memset(hc, 0, sizeof hc);
    while (fgets(ln, sizeof ln, fs)) { if (!strncmp(ln, "W2-OBJECT", 9)) { char *p = strstr(ln, "LMAX="); if (p) LMAX = atoi(p + 5); }
      else if (!strncmp(ln, "W2-CLASS ", 9)) { int a, c; double v; if (sscanf(ln, "W2-CLASS a=%d c=%d E[chi_a(A) chi_c(B)] = %le", &a, &c, &v) == 3 && a < 8 && c < 8) { cls[a][c] = v; hc[a][c] = 1; } }
      else if (!strncmp(ln, "W2-CHANNEL ", 11) && strstr(ln, "f_k = ")) { int a, c, k; double v; if (sscanf(ln, "W2-CHANNEL a=%d c=%d k=%d f_k = %le", &a, &c, &k, &v) == 4 && a < 8 && c < 8 && k < 16) { fk[a][c][k] = v; hk[a][c][k] = 1; } } }
    fclose(fs); if (LMAX < 1) { fprintf(stderr, "SCHUR: no LMAX\n"); return 1; } alloc_F(); quat *RS; double *WS; int NS = make_rule(30, &RS, &WS); int missing = 0;
    for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= LMAX; c++) { int da = DIM[a], dc = DIM[c]; double fl[16]; int hl[16]; memset(hl, 0, sizeof hl);
      if (a == 0 || c == 0) { if (!hc[a][c]) { missing++; continue; } fl[a + c] = cls[a][c]; hl[a + c] = 1; } else { for (int k = abs(a - c); k <= a + c; k += 2) { if (!hk[a][c][k]) { missing++; continue; } fl[k] = fk[a][c][k]; hl[k] = 1; } }
      for (int u = 0; u < NS; u++) { cplx Da[256], Dc[256]; rep(a, RS[u], Da); rep(c, RS[u], Dc); double wch = 0; for (int k = 0; k < 16; k++) if (hl[k]) wch += fl[k] * chi(k, RS[u]); wch *= WS[u];
        for (int r = 0; r < da; r++) for (int q = 0; q < da; q++) for (int rp = 0; rp < dc; rp++) for (int qp = 0; qp < dc; qp++) FH[a][c][fidx(da, dc, r, q, rp, qp)] += wch * Da[r * da + q] * Dc[rp * dc + qp]; } }
    double chk = 0; for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= LMAX; c++) if (hc[a][c]) { int da = DIM[a], dc = DIM[c]; cplx t = 0; for (int r = 0; r < da; r++) for (int rp = 0; rp < dc; rp++) t += FH[a][c][fidx(da, dc, r, r, rp, rp)]; double e = fabs(creal(t) - cls[a][c]); if (e > chk) chk = e; }
    const char *bs = strrchr(path, '/'); bs = bs ? bs + 1 : path; char tag[512]; snprintf(tag, sizeof tag, "%s[SCHUR]", bs);
    printf("M4CHAN-SCHUR %s: LMAX=%d, %d channel blocks missing; class moments recovered to %.2e [%s]\n", bs, LMAX, missing, chk, (missing == 0 && chk < 1e-10) ? "MET" : "FAILED");
    if (missing == 0 && chk < 1e-10) su2_run(tag, argc > 3 ? atoi(argv[3]) : 30, argc > 4 ? atoi(argv[4]) : 16); return 0; }
  if (!strcmp(argv[1], "U1") && argc > 2) { int n = read_u1(argv[2]); const char *base = strrchr(argv[2], '/'); base = base ? base + 1 : argv[2];
    printf("M4CHAN-RECORD %s: U(1), LMAX=%d, %d moments read\n", base, UL, n); u1_run(base, argc > 3 ? atoi(argv[3]) : 2048, argc > 4 ? atoi(argv[4]) : 256); return 0; }
  fprintf(stderr, "unknown mode\n"); return 1; }
