/* cei_dtn.c -- THE FREE EXTERIOR INTEGRATED ONTO THE FACE OBJECT: the gauge-invariant Dirichlet-to-Neumann form S of the free photon
 * (one colour, the quadratic plaquette form sum_p (dA_p)^2 per unit beta) on the 22 object links of EI's bent two-face object, the exterior
 * links integrated exactly at Gaussian order (THE CROSSING CAMPAIGN §31.13, lead (1) in its correct form).  S = P_OO - P_OX P_XX^+ P_XO with
 * the pseudo-inverse on the exterior by conjugate gradients (P_XX is singular on the exterior's interior gauge modes, and the right-hand sides
 * are orthogonal to them, so CG converges and the Schur complement is unique).  The exterior is a box of radius R around the object with the
 * links beyond it at zero; S converges in R like the massless response.  KNOWN ANSWERS: (i) with R = 0 (no exterior link) S = P_OO exactly;
 * (ii) every gauge mode of an object vertex, restricted to the object links, lies in S's kernel (the exterior integral is gauge invariant);
 * (iii) S is symmetric; (iv) S <= P_OO (the exterior can only soften the pinning): every diagonal entry falls.  OUTPUT: S (22 x 22), P_OO, the
 * diagonal correction kappa_i = S_ii - P_ii per object link (the engine's self-energy weight e^{beta |kappa_i| (1 - 1/2 tr U_i)}), and the
 * off-diagonal norm of the correction C = P_OO - S against its diagonal norm (the priced remainder of the diagonal approximation).
 * usage: cei_dtn R [tol]      build: gcc -O2 -o cei_dtn.exe cei_dtn.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
static int R = 4; static double TOL = 1e-12;
static int LO0, LO1, LO2, LO3, HI0, HI1, HI2, HI3;            /* the box */
static int NS0, NS1, NS2, NS3;
static int inbox(int x0, int x1, int x2, int x3) { return x0 >= LO0 && x0 <= HI0 && x1 >= LO1 && x1 <= HI1 && x2 >= LO2 && x2 <= HI2 && x3 >= LO3 && x3 <= HI3; }
static long sid(int x0, int x1, int x2, int x3) { return (((long)(x0 - LO0) * NS1 + (x1 - LO1)) * NS2 + (x2 - LO2)) * NS3 + (x3 - LO3); }
/* a link (x, mu) exists iff x and x + e_mu are in the box; its id is 4 * sid + (mu - 1) */
static long lid(int x0, int x1, int x2, int x3, int mu) { int y[4] = { x0, x1, x2, x3 }; y[mu - 1]++; if (!inbox(x0, x1, x2, x3) || !inbox(y[0], y[1], y[2], y[3])) return -1; return 4 * sid(x0, x1, x2, x3) + (mu - 1); }
static int isobj(int x0, int x1, int x2, int x3, int mu) {       /* the 22 object links (cei_gauss_face.awk's table) */
  if (x3 != 0) return 0;
  if (mu == 1) return (x2 == 0 && x0 >= 0 && x0 <= 1 && x1 >= 0 && x1 <= 2);
  if (mu == 2) return ((x2 == 0 && x0 >= 0 && x0 <= 2 && x1 >= 0 && x1 <= 1) || (x0 == 0 && x2 >= 0 && x2 <= 2 && x1 >= 0 && x1 <= 1));
  if (mu == 3) return (x0 == 0 && x1 >= 0 && x1 <= 2 && x2 >= 0 && x2 <= 1);
  return 0; }
/* sparse symmetric P in CSR-like fixed rows: each link in at most 6 plaquettes, each coupling it to 3 others: <= 19 entries */
#define MAXNZ 24
static long NL; static int *NNZ; static long *COL; static double *VAL; static char *ISO; static int *OIDX;   /* OIDX[link] = object index or -1 */
static int NFACE[22], NCORN[22], NSTP[22], NTHREE[22]; static double PK[22][22];   /* per object link: its plaquettes by object-link count 4 / 2 / 1 / 3; PK the kept form (face + corner plaquettes) */
static void addP(long i, long j, double v) { for (int k = 0; k < NNZ[i]; k++) if (COL[i * MAXNZ + k] == j) { VAL[i * MAXNZ + k] += v; return; } if (NNZ[i] >= MAXNZ) { fprintf(stderr, "row overflow\n"); exit(2); } COL[i * MAXNZ + NNZ[i]] = j; VAL[i * MAXNZ + NNZ[i]] = v; NNZ[i]++; }
static void build(void) {
  LO0 = -R; HI0 = 2 + R; LO1 = -R; HI1 = 2 + R; LO2 = -R; HI2 = 2 + R; LO3 = -R; HI3 = R;
  NS0 = HI0 - LO0 + 1; NS1 = HI1 - LO1 + 1; NS2 = HI2 - LO2 + 1; NS3 = HI3 - LO3 + 1;
  NL = 4L * NS0 * NS1 * NS2 * NS3;
  NNZ = calloc(NL, sizeof(int)); COL = malloc(sizeof(long) * NL * MAXNZ); VAL = malloc(sizeof(double) * NL * MAXNZ); ISO = calloc(NL, 1); OIDX = malloc(sizeof(int) * NL);
  if (!NNZ || !COL || !VAL || !ISO || !OIDX) { fprintf(stderr, "out of memory\n"); exit(3); }
  for (long l = 0; l < NL; l++) OIDX[l] = -1;
  /* the object links first, in cei_gauss_face.awk's enumeration order */
  { int no = 0;
    for (int x0 = 0; x0 <= 2; x0++) for (int x1 = 0; x1 <= 2; x1++) for (int x2 = 0; x2 <= 2; x2++) for (int mu = 1; mu <= 3; mu++) if (isobj(x0, x1, x2, 0, mu)) { long l = lid(x0, x1, x2, 0, mu); if (l < 0) { fprintf(stderr, "an object link is outside the box\n"); exit(2); } ISO[l] = 1; OIDX[l] = no++; }
    if (no != 22) { fprintf(stderr, "%d object links, not 22\n", no); exit(2); } }
  for (int a = 0; a < 22; a++) { NFACE[a] = NCORN[a] = NSTP[a] = NTHREE[a] = 0; for (int c = 0; c < 22; c++) PK[a][c] = 0; }
  /* every plaquette with at least one existing link */
  for (int x0 = LO0 - 1; x0 <= HI0; x0++) for (int x1 = LO1 - 1; x1 <= HI1; x1++) for (int x2 = LO2 - 1; x2 <= HI2; x2++) for (int x3 = LO3 - 1; x3 <= HI3; x3++)
    for (int mu = 1; mu <= 4; mu++) for (int nu = mu + 1; nu <= 4; nu++) {
      int b[4] = { x0, x1, x2, x3 }, q[4]; long L[4]; double s[4] = { 1, 1, -1, -1 };
      L[0] = lid(b[0], b[1], b[2], b[3], mu);
      memcpy(q, b, sizeof q); q[mu - 1]++; L[1] = lid(q[0], q[1], q[2], q[3], nu);
      memcpy(q, b, sizeof q); q[nu - 1]++; L[2] = lid(q[0], q[1], q[2], q[3], mu);
      L[3] = lid(b[0], b[1], b[2], b[3], nu);
      int any = 0, nobj = 0; for (int k = 0; k < 4; k++) if (L[k] >= 0) { any = 1; if (ISO[L[k]]) nobj++; } if (!any) continue;
      for (int k = 0; k < 4; k++) for (int m = 0; m < 4; m++) if (L[k] >= 0 && L[m] >= 0) addP(L[k], L[m], s[k] * s[m]);
      for (int k = 0; k < 4; k++) if (L[k] >= 0 && ISO[L[k]]) { int a = OIDX[L[k]]; if (nobj == 4) NFACE[a]++; else if (nobj == 2) NCORN[a]++; else if (nobj == 1) NSTP[a]++; else NTHREE[a]++; }
      if (nobj == 4 || nobj == 2) for (int k = 0; k < 4; k++) for (int m = 0; m < 4; m++) if (L[k] >= 0 && L[m] >= 0 && ISO[L[k]] && ISO[L[m]]) PK[OIDX[L[k]]][OIDX[L[m]]] += s[k] * s[m]; } }
/* y = P_XX x on exterior vectors (object entries ignored and kept 0) */
static void mulXX(const double *x, double *y) { for (long i = 0; i < NL; i++) { if (ISO[i]) { y[i] = 0; continue; } double s = 0; for (int k = 0; k < NNZ[i]; k++) { long j = COL[i * MAXNZ + k]; if (!ISO[j]) s += VAL[i * MAXNZ + k] * x[j]; } y[i] = s; } }
static double dotX(const double *a, const double *b) { double s = 0; for (long i = 0; i < NL; i++) if (!ISO[i]) s += a[i] * b[i]; return s; }
static int cg(const double *b, double *x, int maxit, double *resout) {   /* P_XX x = b, x starts at 0 */
  double *r = malloc(sizeof(double) * NL), *p = malloc(sizeof(double) * NL), *Ap = malloc(sizeof(double) * NL);
  for (long i = 0; i < NL; i++) { x[i] = 0; r[i] = ISO[i] ? 0 : b[i]; p[i] = r[i]; }
  double rr = dotX(r, r), b0 = sqrt(dotX(b, b)); int it = 0;
  if (b0 == 0) { *resout = 0; free(r); free(p); free(Ap); return 0; }
  for (it = 0; it < maxit; it++) { mulXX(p, Ap); double pAp = dotX(p, Ap); if (pAp <= 0) break; double al = rr / pAp;
    for (long i = 0; i < NL; i++) if (!ISO[i]) { x[i] += al * p[i]; r[i] -= al * Ap[i]; }
    double rr2 = dotX(r, r); if (sqrt(rr2) < TOL * b0) { rr = rr2; it++; break; } double be = rr2 / rr; rr = rr2; for (long i = 0; i < NL; i++) if (!ISO[i]) p[i] = r[i] + be * p[i]; }
  *resout = sqrt(rr) / b0; free(r); free(p); free(Ap); return it; }
/* ---- THE EXTERIOR'S GAUSSIAN MARGINAL ON THE ENGINE'S OUTSIDE LINKS (mode "marg", campaign 31.14): the exterior-only form F = P_ext + D D^T
   (the plaquettes with no object link, plus the Feynman gauge term -- the squared divergence at every vertex -- which fixes the gauge without
   changing any gauge-invariant marginal, the Faddeev-Popov determinant being a constant for a linear gauge; the engine's reading is invariant
   under gauge transformations at every vertex, so any gauge serves), the covariance (4/beta) F^{-1} on the outside links (one CG solve per link),
   its eigen-decomposition by Jacobi, printed for the cubature (cei_cub.awk).  The straddling plaquettes are NOT in F: the engine carries them
   whole at each datum.  usage: cei_dtn R tol marg <outside-link list "x y z t d"> beta */
static int NNZ2v(long i) { return NNZ[i]; }
static void marg(const char *listfile, double beta) {
  /* a second sparse matrix in the same arrays: rebuild NNZ/COL/VAL as F over the exterior links */
  for (long i = 0; i < NL; i++) NNZ[i] = 0;
  for (int x0 = LO0 - 1; x0 <= HI0; x0++) for (int x1 = LO1 - 1; x1 <= HI1; x1++) for (int x2 = LO2 - 1; x2 <= HI2; x2++) for (int x3 = LO3 - 1; x3 <= HI3; x3++)
    for (int mu = 1; mu <= 4; mu++) for (int nu = mu + 1; nu <= 4; nu++) {
      int b[4] = { x0, x1, x2, x3 }, q[4]; long L[4]; double s[4] = { 1, 1, -1, -1 };
      L[0] = lid(b[0], b[1], b[2], b[3], mu); memcpy(q, b, sizeof q); q[mu - 1]++; L[1] = lid(q[0], q[1], q[2], q[3], nu);
      memcpy(q, b, sizeof q); q[nu - 1]++; L[2] = lid(q[0], q[1], q[2], q[3], mu); L[3] = lid(b[0], b[1], b[2], b[3], nu);
      int any = 0, nobj = 0; for (int k = 0; k < 4; k++) if (L[k] >= 0) { any = 1; if (ISO[L[k]]) nobj++; } if (!any || nobj) continue;
      for (int k = 0; k < 4; k++) for (int m = 0; m < 4; m++) if (L[k] >= 0 && L[m] >= 0) addP(L[k], L[m], s[k] * s[m]); }
  /* the Feynman term: at every vertex v of the box, (div a)_v = sum_mu a(v, mu) - a(v - e_mu, mu) over existing exterior links */
  long ngt = 0;
  for (int x0 = LO0; x0 <= HI0; x0++) for (int x1 = LO1; x1 <= HI1; x1++) for (int x2 = LO2; x2 <= HI2; x2++) for (int x3 = LO3; x3 <= HI3; x3++) {
    long inc[8]; double sg[8]; int n = 0; int v[4] = { x0, x1, x2, x3 };
    for (int mu = 1; mu <= 4; mu++) { long l = lid(v[0], v[1], v[2], v[3], mu); if (l >= 0 && !ISO[l]) { inc[n] = l; sg[n] = 1; n++; }
      int u[4]; memcpy(u, v, sizeof u); u[mu - 1]--; l = lid(u[0], u[1], u[2], u[3], mu); if (l >= 0 && !ISO[l]) { inc[n] = l; sg[n] = -1; n++; } }
    for (int a = 0; a < n; a++) for (int c = 0; c < n; c++) addP(inc[a], inc[c], sg[a] * sg[c]); ngt++; }
  /* the outside links */
  FILE *f = fopen(listfile, "r"); if (!f) { fprintf(stderr, "marg: cannot open %s\n", listfile); exit(2); }
  int NE = 0; long EL[512]; int EX[512][5]; int b[4], d;
  while (fscanf(f, "%d %d %d %d %d", &b[0], &b[1], &b[2], &b[3], &d) == 5) { long l = lid(b[0], b[1], b[2], b[3], d); if (l < 0) { fprintf(stderr, "marg: outside link (%d,%d,%d,%d) d%d outside the box\n", b[0], b[1], b[2], b[3], d); exit(2); }
    if (ISO[l]) { fprintf(stderr, "marg: (%d,%d,%d,%d) d%d is an object link\n", b[0], b[1], b[2], b[3], d); exit(2); } if (NE >= 512) { fprintf(stderr, "marg: too many outside links\n"); exit(2); }
    EL[NE] = l; for (int k = 0; k < 4; k++) EX[NE][k] = b[k]; EX[NE][4] = d; NE++; char rest[256]; if (!fgets(rest, sizeof rest, f)) break; }
  fclose(f);
  printf("MARG R=%d: the exterior-only form with the Feynman gauge term over %ld vertices; %d outside links; beta %g; covariance (4/beta) F^{-1} by CG to %g\n", R, ngt, NE, beta, TOL);
  double *bv = malloc(sizeof(double) * NL), *y = malloc(sizeof(double) * NL); static double COV[512][512]; int itmax = 0; double resmax = 0;
  for (int e = 0; e < NE; e++) { for (long i = 0; i < NL; i++) bv[i] = 0; bv[EL[e]] = 1; double res; int it = cg(bv, y, 50000, &res); if (it > itmax) itmax = it; if (res > resmax) resmax = res;
    for (int c = 0; c < NE; c++) COV[e][c] = (4 / beta) * y[EL[c]]; }
  double asym = 0; for (int e = 0; e < NE; e++) for (int c = e + 1; c < NE; c++) { double dd = COV[e][c] - COV[c][e]; if (dd < 0) dd = -dd; if (dd > asym) asym = dd; double m = (COV[e][c] + COV[c][e]) / 2; COV[e][c] = m; COV[c][e] = m; }
  printf("  CG: at most %d iterations, worst relative residual %.2e; KAT symmetric: max |Cov - Cov^T| = %.2e (symmetrised after)\n", itmax, resmax, asym);
  double vmin = 1e9, vmax = 0; for (int e = 0; e < NE; e++) { if (COV[e][e] < vmin) vmin = COV[e][e]; if (COV[e][e] > vmax) vmax = COV[e][e]; }
  printf("  per-colour link variance in [%.6f, %.6f] (rms angle per link over three colours in [%.4f, %.4f] radians); the infinite-lattice Feynman-gauge value far from any object would be (4/beta) 0.1549 = %.4f\n", vmin, vmax, sqrt(3 * vmin), sqrt(3 * vmax), 4 * 0.1549 / beta);
  for (int e = 0; e < NE; e++) printf("MARG-LINK %d %d %d %d %d %d %.12f\n", e, EX[e][0], EX[e][1], EX[e][2], EX[e][3], EX[e][4], COV[e][e]);
  /* Jacobi eigen-decomposition */
  static double A[512][512], V[512][512]; for (int i = 0; i < NE; i++) for (int j = 0; j < NE; j++) { A[i][j] = COV[i][j]; V[i][j] = (i == j); }
  int sweep; for (sweep = 0; sweep < 100; sweep++) { double off = 0; for (int i = 0; i < NE; i++) for (int j = i + 1; j < NE; j++) off += A[i][j] * A[i][j]; if (off < 1e-30) break;
    for (int p = 0; p < NE; p++) for (int q = p + 1; q < NE; q++) { if (A[p][q] == 0) continue; double th = (A[q][q] - A[p][p]) / (2 * A[p][q]); double t = (th >= 0 ? 1 : -1) / (fabs(th) + sqrt(th * th + 1)); double c = 1 / sqrt(t * t + 1), s = t * c;
      for (int k = 0; k < NE; k++) { double akp = A[k][p], akq = A[k][q]; A[k][p] = c * akp - s * akq; A[k][q] = s * akp + c * akq; }
      for (int k = 0; k < NE; k++) { double apk = A[p][k], aqk = A[q][k]; A[p][k] = c * apk - s * aqk; A[q][k] = s * apk + c * aqk; }
      for (int k = 0; k < NE; k++) { double vkp = V[k][p], vkq = V[k][q]; V[k][p] = c * vkp - s * vkq; V[k][q] = s * vkp + c * vkq; } } }
  int ord[512]; for (int i = 0; i < NE; i++) ord[i] = i; for (int i = 0; i < NE; i++) for (int j = i + 1; j < NE; j++) if (A[ord[j]][ord[j]] > A[ord[i]][ord[i]]) { int t = ord[i]; ord[i] = ord[j]; ord[j] = t; }
  double rmax = 0, tr = 0; for (int i = 0; i < NE; i++) { tr += A[i][i]; for (int j = 0; j < NE; j++) { double r = 0; for (int k = 0; k < NE; k++) r += V[i][k] * A[k][k] * V[j][k]; double dd = fabs(r - COV[i][j]); if (dd > rmax) rmax = dd; } }
  int npos = 0; for (int i = 0; i < NE; i++) if (A[i][i] > 1e-12 * A[ord[0]][ord[0]]) npos++;
  printf("  JACOBI %d sweeps; trace %.6f; reconstruction max |V D V^T - Cov| = %.1e; eigenvalues: largest %.6f, smallest %.3e, %d of %d above 1e-12 of the largest (KAT positive definite: %s)\n", sweep, tr, rmax, A[ord[0]][ord[0]], A[ord[NE - 1]][ord[NE - 1]], npos, NE, A[ord[NE - 1]][ord[NE - 1]] > 0 ? "YES" : "NO");
  for (int m = 0; m < NE; m++) { int k = ord[m]; printf("MARG-EIG %d %.12f", m, A[k][k]); for (int i = 0; i < NE; i++) printf(" %.10f", V[i][k]); printf("\n"); }
  free(bv); free(y); }
int main(int argc, char **argv) {
  if (argc > 1) R = atoi(argv[1]); if (argc > 2) TOL = atof(argv[2]);
  build();
  if (argc > 5 && !strcmp(argv[3], "marg")) { marg(argv[4], atof(argv[5])); return 0; }
  long nx = 0; for (long i = 0; i < NL; i++) if (!ISO[i]) nx++;
  printf("CEI-DTN R=%d box %dx%dx%dx%d sites, %ld links (%ld exterior, 22 object), tol %g\n", R, NS0, NS1, NS2, NS3, NL, nx, TOL);
  long OL[22]; for (long l = 0; l < NL; l++) if (ISO[l]) OL[OIDX[l]] = l;
  double POO[22][22], S[22][22]; for (int a = 0; a < 22; a++) for (int c = 0; c < 22; c++) { POO[a][c] = 0; S[a][c] = 0; }
  for (int a = 0; a < 22; a++) { long i = OL[a]; for (int k = 0; k < NNZ[i]; k++) { long j = COL[i * MAXNZ + k]; if (ISO[j]) POO[a][OIDX[j]] += VAL[i * MAXNZ + k]; } }
  double *b = malloc(sizeof(double) * NL), *y = malloc(sizeof(double) * NL); int itmax = 0; double resmax = 0;
  for (int c = 0; c < 22; c++) {   /* b = P_XO e_c ; y = P_XX^+ b ; S[.][c] = POO[.][c] - P_OX y */
    for (long i = 0; i < NL; i++) b[i] = 0;
    long jc = OL[c]; for (int k = 0; k < NNZ[jc]; k++) { long i = COL[jc * MAXNZ + k]; if (!ISO[i]) b[i] = VAL[jc * MAXNZ + k]; }
    double res; int it = cg(b, y, 20000, &res); if (it > itmax) itmax = it; if (res > resmax) resmax = res;
    for (int a = 0; a < 22; a++) { long ia = OL[a]; double s = 0; for (int k = 0; k < NNZ[ia]; k++) { long j = COL[ia * MAXNZ + k]; if (!ISO[j]) s += VAL[ia * MAXNZ + k] * y[j]; } S[a][c] = POO[a][c] - s; } }
  printf("  CG: at most %d iterations, worst relative residual %.2e\n", itmax, resmax);
  /* known answers */
  double asym = 0; for (int a = 0; a < 22; a++) for (int c = 0; c < 22; c++) { double d = S[a][c] - S[c][a]; if (d < 0) d = -d; if (d > asym) asym = d; }
  int fell = 0; for (int a = 0; a < 22; a++) if (S[a][a] < POO[a][a] - 1e-9) fell++;
  /* the object vertices' gauge modes restricted to the object links: S g must vanish */
  double gmax = 0; int ng = 0;
  for (int x0 = 0; x0 <= 2; x0++) for (int x1 = 0; x1 <= 2; x1++) for (int x2 = 0; x2 <= 2; x2++) { double g[22]; int touches = 0; for (int a = 0; a < 22; a++) g[a] = 0;
    for (int mu = 1; mu <= 3; mu++) { int y4[4] = { x0, x1, x2, 0 }; if (isobj(x0, x1, x2, 0, mu)) { g[OIDX[lid(x0, x1, x2, 0, mu)]] -= 1; touches = 1; } y4[mu - 1]--; if (isobj(y4[0], y4[1], y4[2], 0, mu)) { g[OIDX[lid(y4[0], y4[1], y4[2], 0, mu)]] += 1; touches = 1; } }
    if (!touches) continue; ng++; for (int a = 0; a < 22; a++) { double s = 0; for (int c = 0; c < 22; c++) s += S[a][c] * g[c]; if (s < 0) s = -s; if (s > gmax) gmax = s; } }
  double offC = 0, diagC = 0, offP = 0; for (int a = 0; a < 22; a++) for (int c = 0; c < 22; c++) { double C = POO[a][c] - S[a][c]; if (a == c) diagC += C * C; else { offC += C * C; offP += POO[a][c] * POO[a][c]; } }
  printf("  KAT symmetric: max |S - S^T| = %.2e; KAT softening: %d of 22 diagonals fell; KAT gauge: %d object vertices, max |S g| = %.2e (the exterior integral is gauge invariant)\n", asym, fell, ng, gmax);
  printf("  the correction C = P_OO - S: ||diag C||_F = %.6f, ||offdiag C||_F = %.6f (ratio %.4f); ||offdiag P_OO||_F = %.6f\n", sqrt(diagC), sqrt(offC), sqrt(offC / diagC), sqrt(offP));
  printf("  per object link: index coords dir  P_ii  S_ii  S_ii - P_ii\n");
  for (int a = 0; a < 22; a++) { long l = OL[a]; long s = l / 4; int mu = (int)(l % 4) + 1; int x3 = (int)(s % NS3) + LO3; s /= NS3; int x2 = (int)(s % NS2) + LO2; s /= NS2; int x1 = (int)(s % NS1) + LO1; s /= NS1; int x0 = (int)s + LO0;
    printf("  DTN-LINK %2d (%d,%d,%d,%d) d%d  %.1f  %.9f  %+.9f\n", a, x0, x1, x2, x3, mu, POO[a][a], S[a][a], S[a][a] - POO[a][a]); }
  /* THE KEPT FORM AND THE SELF-ENERGY: the engine keeps the face plaquettes (4 object links) exactly and the corner plaquettes (2 object links,
     the exterior pair at the datum) as cycles; the exterior's effect on a link beyond those is kappa_i = S_ii - PK_ii, an effective staple count
     (the ordered datum's value is the staple count nstap_i); the remainder R = S - PK off its diagonal is the pair wall the diagonal model drops */
  int three = 0; double dR = 0, oR = 0; for (int a = 0; a < 22; a++) { three += NTHREE[a]; for (int c = 0; c < 22; c++) { double r = S[a][c] - PK[a][c]; if (a == c) dR += r * r; else oR += r * r; } }
  printf("  DTN-KEPT plaquettes with three object links: %d (must be 0); the remainder R = S - P_kept: ||diag R||_F = %.6f (the self-energies), ||offdiag R||_F = %.6f (the pair wall), ratio %.4f\n", three, sqrt(dR), sqrt(oR), sqrt(oR / dR));
  printf("  per object link: x y z d  nface ncorner nstap  S_ii  kappa_i = S_ii - nface - ncorner  (the engine's CEI_SELF input is 'x y z d kappa')\n");
  for (int a = 0; a < 22; a++) { long l = OL[a]; long s = l / 4; int mu = (int)(l % 4) + 1; s /= NS3; int x2 = (int)(s % NS2) + LO2; s /= NS2; int x1 = (int)(s % NS1) + LO1; s /= NS1; int x0 = (int)s + LO0;
    printf("  DTN-KEFF %d %d %d %d  %d %d %d  %.9f  %.9f\n", x0, x1, x2, mu, NFACE[a], NCORN[a], NSTP[a], S[a][a], S[a][a] - PK[a][a]); }
  printf("  S (22 x 22, row-major, %%.10f):\n"); for (int a = 0; a < 22; a++) { printf("  DTN-S"); for (int c = 0; c < 22; c++) printf(" %.10f", S[a][c]); printf("\n"); }
  printf("  P_OO (22 x 22, the ordered datum's form on the object):\n"); for (int a = 0; a < 22; a++) { printf("  DTN-P"); for (int c = 0; c < 22; c++) printf(" %.10f", POO[a][c]); printf("\n"); }
  return 0; }
