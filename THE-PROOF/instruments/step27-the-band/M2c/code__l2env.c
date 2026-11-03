/* l2env.c -- M2c: THE COARSE ENVIRONMENT IMPOSED.  Reads the chain engine's dump (W2-FC lines: F^{ace}(r,q,r',q',p,p') = Z E[D^a(A)_{rq}
 * D^c(B)_{r'q'} D^e(g)_{pp'}], g = h_N^{-1} the clockwise in-object path of the neighbouring coarse loop N), conditions on the coarse value C of
 * N's holonomy H_N = h_N R through the exterior profile t_e = E[chi_e(R)]/d_e of the rest R of N's loop (independent, central):
 *     P^{ac}(C) = E[D^a(A) D^c(B) | H_N = C] = N^{ac}(C) / N^{00}(C),   N^{ac}(C) = sum_e d_e t_e sum_{pp'} F^{ace}_{..pp'} D^e(C)_{p'p}
 * (since chi_e(h^{-1} C) = chi_e(g C) = sum_{pp'} D^e(g)_{pp'} D^e(C)_{p'p}), and reads the maximal correlation of the conditional pair by M2's
 * ROAD A (Gram method on the degree-degA rule; the representation code and rule copied verbatim from l2dob.c / the engine), the alignments
 * m_A = E[chi_1/2(A) | C]/2, m_B, and kappa = rho/(m_A m_B).
 * THE CERTIFICATE (M2c Lemma E2): for C(phi) = (cos phi, sin phi n), phi in [0, pi], every P^{ac}(phi) is a ratio of trigonometric polynomials of
 * degree <= LN, and |rho(phi) - rho(phi')| <= |phi - phi'| L_rho with L_rho the explicit sup-norm bound of the phi-derivative of the normalised
 * kernel k = p/sqrt(p_A p_B) (Weyl's inequality for the second singular value), printed with the grid maximum: sup_phi rho <= max_k rho(phi_k) +
 * L_rho dphi/2.
 * usage: l2env <record> <profile> <mode> [args]
 *   profile: none | pin:<m>:<r>  (t_e = (I_{e+1}(r)/I_1(r))^m) | t:<t1>,<t2>,...   (t_e for e = 1, 2, ...; t_0 = 1)
 *   mode:    point <w> <x> <y> <z>            one coarse value C (normalised)
 *            scan <nphi> <nx> <ny> <nz>       C(phi) = (cos phi, sin phi n) on nphi+1 points of [0, pi], with the certificate
 *            conj <w> <x> <y> <z> <ntrial>    the symmetry check: rho(C) against rho(g C g^-1) for random g
 *            haar                             the K-E1 known answer: int p(A,B|C) p_H(C) dC = p(A,B) on a rule in C
 * build: gcc -O2 -fopenmp -o l2env.exe l2env.c -lm */
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
static double FACT[40]; static int GENINV = 1;
static void Dsub(int s, quat q, cplx *D) {
  cplx a = q.w + I * q.x, b = q.y + I * q.z, ab = q.w - I * q.x, nbb = -q.y + I * q.z;
  cplx poly[40], np[40];
  for (int qq = 0; qq <= s; qq++) { int len = 1; poly[0] = 1;
    for (int r = 0; r < qq; r++) { for (int k = 0; k <= len; k++) np[k] = 0; for (int k = 0; k < len; k++) { np[k + 1] += poly[k] * a; np[k] += poly[k] * b; } len++; for (int k = 0; k < len; k++) poly[k] = np[k]; }
    for (int r = 0; r < s - qq; r++) { for (int k = 0; k <= len; k++) np[k] = 0; for (int k = 0; k < len; k++) { np[k + 1] += poly[k] * nbb; np[k] += poly[k] * ab; } len++; for (int k = 0; k < len; k++) poly[k] = np[k]; }
    for (int p = 0; p <= s; p++) { double sc = sqrt(FACT[p] * FACT[s - p] / (FACT[qq] * FACT[s - qq])); D[p * (s + 1) + qq] = poly[p] * sc; } } }
static void rep(int s, quat q, cplx *D) { if (s == 0) { D[0] = 1; return; } Dsub(s, GENINV ? qinv(q) : q, D); }
static double chi(int s, quat q) { double w = q.w, u0 = 1, u1 = 2 * w; if (s == 0) return u0; for (int k = 2; k <= s; k++) { double u2 = 2 * w * u1 - u0; u0 = u1; u1 = u2; } return u1; }
static void gauss_legendre(int n, double *x, double *w) { for (int i = 1; i <= n; i++) { double z = cos(PI * (i - 0.25) / (n + 0.5)), dp = 0;
    for (int it = 0; it < 200; it++) { double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2 * k - 1) * z * p1 - (k - 1) * p0) / k; p0 = p1; p1 = p2; } dp = n * (z * p1 - p0) / (z * z - 1); double z1 = z; z = z1 - p1 / dp; if (fabs(z - z1) < 1e-15) break; }
    double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2 * k - 1) * z * p1 - (k - 1) * p0) / k; p0 = p1; p1 = p2; } dp = n * (z * p1 - p0) / (z * z - 1); x[i - 1] = z; w[i - 1] = 2 / ((1 - z * z) * dp * dp); } }
static int make_rule(int deg, quat **RUo, double **RWo) { int nth = (deg + 2) / 2, ngl = (deg + 2) / 2, naz = deg + 1; double gx[400], gw[400]; gauss_legendre(ngl, gx, gw);
  int NPT = nth * ngl * naz; quat *RU = malloc(sizeof(quat) * NPT); double *RW = malloc(sizeof(double) * NPT); int n = 0;
  for (int k = 1; k <= nth; k++) { double th = k * PI / (nth + 1), wt = 2 * sin(th) * sin(th) / (nth + 1);
    for (int j = 0; j < ngl; j++) { double t = gx[j], st = sqrt(1 - t * t);
      for (int l = 0; l < naz; l++) { double ph = 2 * PI * l / naz; quat u = { cos(th), sin(th) * st * cos(ph), sin(th) * st * sin(ph), sin(th) * t }; RU[n] = u; RW[n] = wt * gw[j] / 2 / naz; n++; } } }
  *RUo = RU; *RWo = RW; return NPT; }
static double bessel(int n, double x) { double s = 0, t = pow(x / 2, n), f = 1; for (int i = 1; i <= n; i++) f *= i; t /= f; for (int k = 0; k < 600; k++) { s += t; t *= (x / 2) * (x / 2) / ((k + 1.0) * (k + n + 1.0)); if (t < 1e-300 || t < 1e-18 * s) break; } return s; }
/* ---------- linear algebra (l2dob.c's) ---------- */
static int cchol(int n, const cplx *A, cplx *L) { memset(L, 0, sizeof(cplx) * n * n);
  for (int j = 0; j < n; j++) { double d = creal(A[j * n + j]); for (int k = 0; k < j; k++) d -= creal(L[j * n + k] * conj(L[j * n + k])); if (d <= 0) return 0; L[j * n + j] = sqrt(d);
    for (int i = j + 1; i < n; i++) { cplx s = A[i * n + j]; for (int k = 0; k < j; k++) s -= L[i * n + k] * conj(L[j * n + k]); L[i * n + j] = s / creal(L[j * n + j]); } } return 1; }
static void jacobi(int n, double *a, double *ev) { for (int sweep = 0; sweep < 100; sweep++) { double off = 0; for (int p = 0; p < n; p++) for (int q = p + 1; q < n; q++) off += a[p * n + q] * a[p * n + q]; if (off < 1e-30) break;
    for (int p = 0; p < n; p++) for (int q = p + 1; q < n; q++) { double apq = a[p * n + q]; if (fabs(apq) < 1e-300) continue; double th = (a[q * n + q] - a[p * n + p]) / (2 * apq); double t = (th >= 0 ? 1 : -1) / (fabs(th) + sqrt(th * th + 1)); double c = 1 / sqrt(t * t + 1), s = t * c;
      for (int k = 0; k < n; k++) { double akp = a[k * n + p], akq = a[k * n + q]; a[k * n + p] = c * akp - s * akq; a[k * n + q] = s * akp + c * akq; }
      for (int k = 0; k < n; k++) { double apk = a[p * n + k], aqk = a[q * n + k]; a[p * n + k] = c * apk - s * aqk; a[q * n + k] = s * apk + c * aqk; } } }
  for (int i = 0; i < n; i++) ev[i] = a[i * n + i]; }
static int cmpd(const void *x, const void *y) { double a = *(const double *)x, b = *(const double *)y; return a < b ? 1 : (a > b ? -1 : 0); }
static int csvals(int n, int m, const cplx *X, double *s) { cplx *H = calloc((size_t)n * n, sizeof(cplx)); for (int i = 0; i < n; i++) for (int k = 0; k < n; k++) { cplx t = 0; for (int j = 0; j < m; j++) t += X[i * m + j] * conj(X[k * m + j]); H[i * n + k] = t; }
  int N2 = 2 * n; double *R = calloc((size_t)N2 * N2, sizeof(double)), *ev = calloc(N2, sizeof(double));
  for (int i = 0; i < n; i++) for (int k = 0; k < n; k++) { double re = creal(H[i * n + k]), im = cimag(H[i * n + k]); R[i * N2 + k] = re; R[(i + n) * N2 + k + n] = re; R[i * N2 + k + n] = -im; R[(i + n) * N2 + k] = im; }
  jacobi(N2, R, ev); qsort(ev, N2, sizeof(double), cmpd); for (int i = 0; i < n; i++) s[i] = sqrt(ev[2 * i] > 0 ? ev[2 * i] : 0); free(H); free(R); free(ev); return n; }
/* ---------- the record ---------- */
static int LMAX = -1, CMAX = -1, LN = -1; static double Z = 0; static int DIM[16];
static cplx *FC[8][8][8];   /* FC[a][c][e][((r*da+q)*dc*dc + rp*dc+qp)*de*de + p*de+pp] / Z */
static size_t fcidx(int a, int c, int e, int r, int q, int rp, int qp, int p, int pp) { int da = DIM[a], dc = DIM[c], de = DIM[e]; return (((size_t)(r * da + q) * dc * dc + rp * dc + qp) * de * de) + p * de + pp; }
static void read_rec(const char *path) { FILE *f = fopen(path, "r"); if (!f) { fprintf(stderr, "cannot open %s\n", path); exit(1); } char line[4096]; int nf = 0;
  for (int s = 0; s < 16; s++) DIM[s] = s + 1;
  while (fgets(line, sizeof line, f)) {
    if (!strncmp(line, "W2-FCHEAD", 9)) { int nch; if (sscanf(line, "W2-FCHEAD GENINV=%d Z=%le LMAX=%d CMAX=%d LN=%d NCHAIN=%d", &GENINV, &Z, &LMAX, &CMAX, &LN, &nch) != 6 || nch != 1) { fprintf(stderr, "bad FCHEAD (one chain only)\n"); exit(1); }
      for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= CMAX; c++) for (int e = 0; e <= LN; e++) FC[a][c][e] = calloc((size_t)DIM[a] * DIM[a] * DIM[c] * DIM[c] * DIM[e] * DIM[e], sizeof(cplx)); }
    else if (!strncmp(line, "W2-FC ", 6)) { int a, c, e, r, q, rp, qp, p, pp; double re, im;
      if (sscanf(line, "W2-FC a=%d c=%d e=%d r=%d q=%d rp=%d qp=%d p=%d pp=%d %le %le", &a, &c, &e, &r, &q, &rp, &qp, &p, &pp, &re, &im) != 11) { fprintf(stderr, "bad FC line\n"); exit(1); }
      FC[a][c][e][fcidx(a, c, e, r, q, rp, qp, p, pp)] = (re + I * im) / Z; nf++; } }
  fclose(f); if (LMAX < 0) { fprintf(stderr, "no FCHEAD in %s\n", path); exit(1); }
  if (CMAX != LMAX) { fprintf(stderr, "the reader needs CMAX = LMAX\n"); exit(1); }
  printf("L2ENV-RECORD %s: %d entries, LMAX=%d LN=%d GENINV=%d Z=%.6e\n", path, nf, LMAX, LN, GENINV, Z); }
static double TE[16];   /* the profile t_e, t_0 = 1 */
static void set_profile(const char *s) { for (int e = 0; e < 16; e++) TE[e] = (e == 0); if (!strcmp(s, "none")) return;
  if (!strncmp(s, "pin:", 4)) { int m; double r; if (sscanf(s + 4, "%d:%lf", &m, &r) != 2) { fprintf(stderr, "pin:<m>:<r>\n"); exit(1); } double i1 = bessel(1, r); for (int e = 1; e < 16; e++) TE[e] = pow(bessel(e + 1, r) / i1, m); return; }
  if (!strncmp(s, "t:", 2)) { char buf[512]; strncpy(buf, s + 2, 511); buf[511] = 0; int e = 1; for (char *t = strtok(buf, ","); t && e < 16; t = strtok(NULL, ",")) TE[e++] = atof(t); return; }
  fprintf(stderr, "unknown profile %s\n", s); exit(1); }
/* P^{ac}(C) into PC[a][c] (normalised by N^{00}); returns N^{00}(C) = the hybrid density of H_N at C relative to Haar */
static cplx *PC[8][8];
static double condition(quat C) { cplx De[8][64]; for (int e = 0; e <= LN; e++) rep(e, C, De[e]);
  for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= CMAX; c++) { int da = DIM[a], dc = DIM[c]; size_t nac = (size_t)da * da * dc * dc;
    if (!PC[a][c]) PC[a][c] = calloc(nac, sizeof(cplx)); memset(PC[a][c], 0, sizeof(cplx) * nac);
    for (int e = 0; e <= LN; e++) { if (TE[e] == 0) continue; int de = DIM[e]; double wgt = de * TE[e];
      for (size_t i = 0; i < nac; i++) { cplx s = 0; const cplx *Fb = FC[a][c][e] + i * de * de; for (int p = 0; p < de; p++) for (int pp = 0; pp < de; pp++) s += Fb[p * de + pp] * De[e][pp * de + p]; PC[a][c][i] += wgt * s; } } }
  double n00 = creal(PC[0][0][0]); for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= CMAX; c++) { size_t nac = (size_t)DIM[a] * DIM[a] * DIM[c] * DIM[c]; for (size_t i = 0; i < nac; i++) PC[a][c][i] /= n00; }
  return n00; }
/* ROAD A on PC (l2dob's su2_run, its Road A part) */
static int NU = 0, NAA = 0, AOFF[16]; static quat *RU; static double *RW; static cplx *DU;
static void rule_init(int degA) { NU = make_rule(degA, &RU, &RW); NAA = 0; for (int a = 0; a <= LMAX; a++) { AOFF[a] = NAA; NAA += DIM[a] * DIM[a]; } DU = malloc(sizeof(cplx) * (size_t)NU * NAA);
  for (int u = 0; u < NU; u++) for (int a = 0; a <= LMAX; a++) rep(a, RU[u], DU + (size_t)u * NAA + AOFF[a]); }
static double roadA(double *minpA, double *minpB, double *rho2) {
  int NB = 0, BOFF[16]; for (int a = 1; a <= LMAX; a++) { BOFF[a] = NB; NB += DIM[a] * DIM[a]; }
  cplx *G = calloc((size_t)NB * NB, sizeof(cplx));
  for (int a = 1; a <= LMAX; a++) for (int c = 1; c <= CMAX; c++) { int da = DIM[a], dc = DIM[c];
    for (int i = 0; i < da * da; i++) for (int j = 0; j < dc * dc; j++) G[(size_t)(BOFF[a] + i) * NB + BOFF[c] + j] = PC[a][c][(size_t)i * dc * dc + j] - PC[a][0][i] * PC[0][c][j]; }
  double mA = 1e9, mB = 1e9; double *pA = malloc(sizeof(double) * NU), *pB = malloc(sizeof(double) * NU);
  for (int u = 0; u < NU; u++) { cplx sa = 0, sb = 0; for (int a = 0; a <= LMAX; a++) { int da = DIM[a]; for (int rq = 0; rq < da * da; rq++) { cplx d = conj(DU[(size_t)u * NAA + AOFF[a] + rq]); sa += da * d * PC[a][0][rq]; sb += da * d * PC[0][a][rq]; } }
    pA[u] = creal(sa); pB[u] = creal(sb); if (pA[u] < mA) mA = pA[u]; if (pB[u] < mB) mB = pB[u]; }
  *minpA = mA; *minpB = mB; double rho = -1; *rho2 = -1;
  if (mA > 0 && mB > 0) { cplx *Phi = calloc((size_t)NB * NB, sizeof(cplx)), *Psi = calloc((size_t)NB * NB, sizeof(cplx));
    for (int u = 0; u < NU; u++) { double wa = RW[u] / pA[u], wb = RW[u] / pB[u];
      for (int a = 1; a <= LMAX; a++) for (int i = 0; i < DIM[a] * DIM[a]; i++) { cplx fi = DIM[a] * conj(DU[(size_t)u * NAA + AOFF[a] + i]);
        for (int a2 = 1; a2 <= LMAX; a2++) for (int i2 = 0; i2 < DIM[a2] * DIM[a2]; i2++) { cplx fj = DIM[a2] * conj(DU[(size_t)u * NAA + AOFF[a2] + i2]);
          Phi[(size_t)(BOFF[a] + i) * NB + BOFF[a2] + i2] += wa * conj(fi) * fj; Psi[(size_t)(BOFF[a] + i) * NB + BOFF[a2] + i2] += wb * fi * conj(fj); } } }
    cplx *Lc = calloc((size_t)NB * NB, sizeof(cplx)), *Mc = calloc((size_t)NB * NB, sizeof(cplx));
    if (cchol(NB, Phi, Lc) && cchol(NB, Psi, Mc)) { cplx *T1 = calloc((size_t)NB * NB, sizeof(cplx)), *X = calloc((size_t)NB * NB, sizeof(cplx)); double *sA = calloc(NB, sizeof(double));
      for (int i = 0; i < NB; i++) for (int j = 0; j < NB; j++) { cplx s = 0; for (int k = 0; k < NB; k++) s += G[(size_t)i * NB + k] * Mc[(size_t)k * NB + j]; T1[(size_t)i * NB + j] = s; }
      for (int i = 0; i < NB; i++) for (int j = 0; j < NB; j++) { cplx s = 0; for (int k = 0; k < NB; k++) s += conj(Lc[(size_t)k * NB + i]) * T1[(size_t)k * NB + j]; X[(size_t)i * NB + j] = s; }
      csvals(NB, NB, X, sA); rho = sA[0]; *rho2 = NB > 1 ? sA[1] : 0; free(T1); free(X); free(sA); }
    free(Phi); free(Psi); free(Lc); free(Mc); }
  free(G); free(pA); free(pB); return rho; }
/* the crude rigorous constants of Lemma E2 at the current PC: s = sum_{(a,c) != (0,0)} d_a d_c sqrt(d_a d_c) ||P^{ac}||_F, s_A, s_B */
static void crude(double *s, double *sA, double *sB) { *s = 0; *sA = 0; *sB = 0;
  for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= CMAX; c++) { if (a == 0 && c == 0) continue; int da = DIM[a], dc = DIM[c]; double f = 0; size_t nac = (size_t)da * da * dc * dc;
    for (size_t i = 0; i < nac; i++) f += creal(PC[a][c][i] * conj(PC[a][c][i])); f = sqrt(f); double t = da * dc * sqrt((double)da * dc) * f; *s += t; if (c == 0) *sA += t; if (a == 0) *sB += t; } }
static quat Cphi(double phi, quat n) { double nn = sqrt(n.x * n.x + n.y * n.y + n.z * n.z); quat C = { cos(phi), sin(phi) * n.x / nn, sin(phi) * n.y / nn, sin(phi) * n.z / nn }; return C; }
int main(int argc, char **argv) {
  if (argc < 4) { fprintf(stderr, "usage: l2env <record> <profile> <mode> [args]\n"); return 1; }
  FACT[0] = 1; for (int i = 1; i < 40; i++) FACT[i] = FACT[i - 1] * i;
  read_rec(argv[1]); set_profile(argv[2]); rule_init(30);
  printf("L2ENV-PROFILE %s:", argv[2]); for (int e = 0; e <= LN; e++) printf(" t_%d=%.9f", e, TE[e]); printf("\n");
  /* the kernel's positivity on the class circle (it is a density of R only where positive): K(phi) = sum_e d_e t_e chi_e */
  { double kmin = 1e9; for (int k = 0; k <= 2000; k++) { double phi = PI * k / 2000; quat C = { cos(phi), sin(phi), 0, 0 }; double K = 0; for (int e = 0; e <= LN; e++) K += DIM[e] * TE[e] * chi(e, C); if (K < kmin) kmin = K; }
    printf("L2ENV-KERNEL min over the class circle of sum_{e<=LN} d_e t_e chi_e = %.6e -> %s\n", kmin, kmin > 0 ? "POSITIVE" : "SIGNED (the truncated profile is not a density)"); }
  const char *mode = argv[3];
  if (!strcmp(mode, "point")) { quat C = { atof(argv[4]), atof(argv[5]), atof(argv[6]), atof(argv[7]) }; double nn = sqrt(C.w * C.w + C.x * C.x + C.y * C.y + C.z * C.z); C.w /= nn; C.x /= nn; C.y /= nn; C.z /= nn;
    double n00 = condition(C), mA, mB, r2; double rho = roadA(&mA, &mB, &r2); double s, sA, sB; crude(&s, &sA, &sB);
    double eA = creal(PC[1][0][0] + PC[1][0][3]), eB = creal(PC[0][1][0] + PC[0][1][3]);
    printf("L2ENV-POINT C=(%.6f,%.6f,%.6f,%.6f) pH=%.9f rho=%.9f (next %.3e) E[chi(A)]=%.9f E[chi(B)]=%.9f kappa=%.6f min pA %.4f min pB %.4f crude s=%.4f\n", C.w, C.x, C.y, C.z, n00, rho, r2, eA, eB, rho / (eA * eB / 4), mA, mB, s); return 0; }
  if (!strcmp(mode, "conj")) { quat C = { atof(argv[4]), atof(argv[5]), atof(argv[6]), atof(argv[7]) }; int nt = atoi(argv[8]); double nn = sqrt(C.w * C.w + C.x * C.x + C.y * C.y + C.z * C.z); C.w /= nn; C.x /= nn; C.y /= nn; C.z /= nn;
    double mA, mB, r2; condition(C); double rho0 = roadA(&mA, &mB, &r2); double worst = 0; unsigned long long sd = 0x9E3779B97F4A7C15ULL;
    for (int t = 0; t < nt; t++) { double g4[4], gn = 0; for (int k = 0; k < 4; k++) { sd ^= sd << 13; sd ^= sd >> 7; sd ^= sd << 17; g4[k] = ((sd >> 11) * (1.0 / 9007199254740992.0)) - 0.5; gn += g4[k] * g4[k]; } gn = sqrt(gn);
      quat g = { g4[0] / gn, g4[1] / gn, g4[2] / gn, g4[3] / gn }; quat Cg = qmul(qmul(g, C), qinv(g)); condition(Cg); double rho = roadA(&mA, &mB, &r2); double d = fabs(rho - rho0); if (d > worst) worst = d;
      printf("L2ENV-CONJ trial %d: rho(gCg^-1) = %.12f against rho(C) = %.12f\n", t, rho, rho0); }
    printf("L2ENV-CONJ max |rho(gCg^-1) - rho(C)| = %.3e over %d trials\n", worst, nt); return 0; }
  if (!strcmp(mode, "haar")) {   /* K-E1: int p(A,B | C) p_H(C) dC = p(A,B): the C-average of N^{ac}(C) on a rule equals F^{ac0}/Z */
    quat *RC; double *RWC; int NC = make_rule(4 * LN + 4, &RC, &RWC); double worst = 0, big = 0;
    for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= CMAX; c++) { int da = DIM[a], dc = DIM[c]; size_t nac = (size_t)da * da * dc * dc; cplx *acc = calloc(nac, sizeof(cplx));
      for (int k = 0; k < NC; k++) { double n00 = condition(RC[k]); for (size_t i = 0; i < nac; i++) acc[i] += RWC[k] * n00 * PC[a][c][i]; }
      for (size_t i = 0; i < nac; i++) { double d = cabs(acc[i] - FC[a][c][0][i]); if (d > worst) worst = d; if (cabs(FC[a][c][0][i]) > big) big = cabs(FC[a][c][0][i]); } free(acc); }
    printf("L2ENV-KAT-E1 int p(A,B|C) p_H(C) dC against p(A,B): max |diff| %.3e (max entry %.3e) on a %d-point rule in C -> %s\n", worst, big, NC, worst < 1e-12 * (1 + big) ? "MET" : "FAILED"); return 0; }
  if (!strcmp(mode, "scan")) { int np = atoi(argv[4]); quat n = { 0, atof(argv[5]), atof(argv[6]), atof(argv[7]) };
    double best = -1, bphi = 0, worstmin = 1e9, smax = 0, sAmax = 0, sBmax = 0, rmin = 1e9, rphimin = 0; double *rh = malloc(sizeof(double) * (np + 1));
    double eAlo = 1e9, eAhi = -1e9;
    for (int k = 0; k <= np; k++) { double phi = PI * k / np; quat C = Cphi(phi, n); double n00 = condition(C), mA, mB, r2; double rho = roadA(&mA, &mB, &r2); rh[k] = rho;
      double s, sA, sB; crude(&s, &sA, &sB); if (s > smax) smax = s; if (sA > sAmax) sAmax = sA; if (sB > sBmax) sBmax = sB;
      double eA = creal(PC[1][0][0] + PC[1][0][3]), eB = creal(PC[0][1][0] + PC[0][1][3]); if (eA < eAlo) eAlo = eA; if (eA > eAhi) eAhi = eA;
      if (mA < worstmin) worstmin = mA; if (mB < worstmin) worstmin = mB; if (rho > best) { best = rho; bphi = phi; } if (rho < rmin) { rmin = rho; rphimin = phi; }
      if (k % (np / 20 > 0 ? np / 20 : 1) == 0) printf("L2ENV-SCAN phi=%.6f pH=%.6f rho=%.9f E[chi(A)]=%.6f E[chi(B)]=%.6f kappa=%.4f minp %.4f %.4f s=%.4f\n", phi, n00, rho, eA, eB, rho / (eA * eB / 4), mA, mB, s); }
    /* Lemma E2's constant: alpha, beta bounds from the phi-derivative by central differences cannot be a proof, so the derivative is bounded from the
       DUMP: ||d/dphi N^{ac}||_F <= sum_e d_e t_e e sum_{pp'} ||F^{ace}_{..pp'}||_F (|d/dphi D^e(C(phi))_{p'p}| <= e, Bernstein), N^{00} >= nmin */
    double nmin = 1e9; for (int k = 0; k <= 20 * np; k++) { double phi = PI * k / (20 * np); quat C = Cphi(phi, n); double n00 = condition(C); if (n00 < nmin) nmin = n00; }
    double dn00 = 0; double nsup[8][8], dsup[8][8];
    for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= CMAX; c++) { int da = DIM[a], dc = DIM[c]; size_t nac = (size_t)da * da * dc * dc; double S0 = 0, S1 = 0;
      for (int e = 0; e <= LN; e++) { int de = DIM[e]; double fe = 0; for (int p = 0; p < de; p++) for (int pp = 0; pp < de; pp++) { double ff = 0; for (size_t i = 0; i < nac; i++) { cplx v = FC[a][c][e][i * de * de + p * de + pp]; ff += creal(v * conj(v)); } fe += sqrt(ff); }
        S0 += de * fabs(TE[e]) * fe; S1 += de * fabs(TE[e]) * e * fe; }
      nsup[a][c] = S0; dsup[a][c] = S1; if (a == 0 && c == 0) dn00 = S1; }
    double nmin_rig = nmin - (PI / (20 * np)) / 2 * dn00;   /* the grid minimum of the trigonometric polynomial N^{00}, less half a step times its derivative bound */
    double s_rig = 0, sA_rig = 0, sB_rig = 0, sd_rig = 0, sdA = 0, sdB = 0;
    for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= CMAX; c++) { if (a == 0 && c == 0) continue; int da = DIM[a], dc = DIM[c]; double w = da * dc * sqrt((double)da * dc);
      double al = nsup[a][c] / nmin_rig, be = dsup[a][c] / nmin_rig + nsup[a][c] * dn00 / (nmin_rig * nmin_rig);   /* ||P|| <= ||N||/N00, ||P'|| <= ||N'||/N00 + ||N|| |N00'|/N00^2 */
      s_rig += w * al; sd_rig += w * be; if (c == 0) { sA_rig += w * al; sdA += w * be; } if (a == 0) { sB_rig += w * al; sdB += w * be; } }
    printf("L2ENV-CERT-INPUT N00 grid min %.6e (20x grid), rigorous min %.6e; sup ||N^{00}'|| <= %.4e; rigorous s = %.4f, s_A = %.4f, s_B = %.4f; s' = %.4f, s'_A = %.4f, s'_B = %.4f\n", nmin, nmin_rig, dn00, s_rig, sA_rig, sB_rig, sd_rig, sdA, sdB);
    if (nmin_rig > 0 && sA_rig < 1 && sB_rig < 1) {
      double Lrho = sd_rig / sqrt((1 - sA_rig) * (1 - sB_rig)) + 0.5 * (1 + s_rig) / sqrt((1 - sA_rig) * (1 - sB_rig)) * (sdA / (1 - sA_rig) + sdB / (1 - sB_rig));   /* M2c 10:3x: (1 + s), not sqrt(1 + s) -- Lemma E2 as written on the page */
      double dphi = PI / np; printf("L2ENV-CERT Lemma E2: positivity of p_C on SU(2)^2 for every phi certified iff s < 1: %s (s = %.4f); L_rho <= %.6e; grid step %.3e -> sup_phi rho <= %.9f + %.3e = %.9f (grid max at phi = %.6f; grid min %.9f at phi = %.6f)\n",
        s_rig < 1 ? "CERTIFIED" : "NOT CERTIFIED", s_rig, Lrho, dphi, best, Lrho * dphi / 2, best + Lrho * dphi / 2, bphi, rmin, rphimin); }
    else printf("L2ENV-CERT REFUSED: the crude bounds do not certify (N00 min %.3e, s_A %.3f, s_B %.3f)\n", nmin_rig, sA_rig, sB_rig);
    printf("L2ENV-SCAN-RESULT grid max rho = %.9f at phi = %.6f; grid min %.9f at phi = %.6f; E[chi(A)] range [%.6f, %.6f]; min marginal %.4f\n", best, bphi, rmin, rphimin, eAlo, eAhi, worstmin);
    return 0; }
  fprintf(stderr, "unknown mode %s\n", mode); return 1; }
