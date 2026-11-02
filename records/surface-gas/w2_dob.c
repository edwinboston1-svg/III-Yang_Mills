/* w2_dob.c -- THE (8.5) READER: THE GROUND's interdependence coefficient between the two coarse loops of the two-face object at a fine datum,
 * from the engine's junction tensor (W2_DUMPF=1 on w2_strip_n.c; THE CROSSING CAMPAIGN §14, 2026-11-01, the trunk seat).
 * The record holds F^{ac}(r, q, r', q') = E[D^a(A)_{rq} D^c(B)_{r'q'}] (unnormalised, Z on the FHEAD line) for a, c <= LMAX; the joint law of the two
 * loops truncated at loop representation LMAX is, by Peter-Weyl, p(U, V) = (1/Z) sum_{a,c} d_a d_c sum F^{ac}(r,q,r',q') conj D^a(U)_{rq} conj D^c(V)_{r'q'};
 * (8.5) for y = A, y' = B at the datum: C = sup_{V,V'} || p(.|B=V) - p(.|B=V') ||_TV, TV = sup_E |.| = half the L1 norm; beside it the tilt bound's
 * Delta = sup_{V,V'} osc_U [log p(U|V) - log p(U|V')] and 1 - e^{-Delta} >= C (Proposition 8.4).  Every supremum is taken on a grid with a local
 * refinement about the maximiser and is therefore a LOWER bound on the group's; the truncated density's sign is censused first and a TV or a Delta
 * is REFUSED BY NAME where the truncated joint density or the conditioning marginal is not positive.  The representation code and the quadrature
 * are the engine's own, copied verbatim, so that the convention is the engine's.  Controls (printed MET/FAILED): K0 the rule integrates the
 * characters' orthogonality; KR the representation homomorphism and the record's GENINV; K2 the class moments from the dump against the record's;
 * K2' the Peter-Weyl round trip F -> p -> F on the rule; K3 the channels f_k from the dump against the record's; K4 the Schur residual
 * |F/Z - sum_k (f_k/d_k) P_k| (a KAT at the ordered datum, a reading elsewhere); K5 two rule degrees must agree on C.
 * usage: w2_dob <record> [deg=30] [deg2=60] [vdeg=12] [refine=24]      build: gcc -O2 -fopenmp -o w2_dob.exe w2_dob.c -lm */
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
/* ---- the record */
static int LMAX = -1, GENREC = -1; static double Z = 0; static int DIM[16];
static cplx *FH[16][16]; static int FCNT[16][16]; static double CLSREC[16][16]; static int HASCLS[16][16]; static double FKREC[16][16][16]; static int HASFK[16][16][16];
static inline size_t fidx(int da, int dc, int r, int q, int rp, int qp) { return ((size_t)(r * da + q)) * dc * dc + rp * dc + qp; }
static void read_record(const char *path, int allow_nodump) { FILE *f = fopen(path, "r"); if (!f) { fprintf(stderr, "cannot open %s\n", path); exit(1); } char line[4096];
  while (fgets(line, sizeof line, f)) {
    if (!strncmp(line, "W2-FHEAD", 8)) { if (sscanf(line, "W2-FHEAD GENINV=%d Z=%le LMAX=%d", &GENREC, &Z, &LMAX) != 3) { fprintf(stderr, "bad FHEAD\n"); exit(1); }
      for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= LMAX; c++) { DIM[a] = a + 1; DIM[c] = c + 1; FH[a][c] = calloc((size_t)DIM[a] * DIM[a] * DIM[c] * DIM[c], sizeof(cplx)); FCNT[a][c] = 0; } }
    else if (!strncmp(line, "W2-F ", 5)) { int a, c, r, q, rp, qp; double re, im; if (sscanf(line, "W2-F a=%d c=%d r=%d q=%d rp=%d qp=%d %le %le", &a, &c, &r, &q, &rp, &qp, &re, &im) != 8) { fprintf(stderr, "bad F line\n"); exit(1); }
      if (LMAX < 0 || a > LMAX || c > LMAX) { fprintf(stderr, "F entry out of range\n"); exit(1); } FH[a][c][fidx(DIM[a], DIM[c], r, q, rp, qp)] = (re + I * im) / Z; FCNT[a][c]++; }
    else if (!strncmp(line, "W2-CLASS ", 9)) { int a, c; double v; if (sscanf(line, "W2-CLASS a=%d c=%d E[chi_a(A) chi_c(B)] = %le", &a, &c, &v) == 3 && a < 16 && c < 16) { CLSREC[a][c] = v; HASCLS[a][c] = 1; } }
    else if (!strncmp(line, "W2-CHANNEL ", 11) && strstr(line, "f_k = ")) { int a, c, k; double v; if (sscanf(line, "W2-CHANNEL a=%d c=%d k=%d f_k = %le", &a, &c, &k, &v) == 4 && a < 16 && c < 16 && k < 16) { FKREC[a][c][k] = v; HASFK[a][c][k] = 1; } } }
  fclose(f); if (LMAX < 0) { if (allow_nodump) return; fprintf(stderr, "no W2-FHEAD line: not a dump record\n"); exit(1); }
  for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= LMAX; c++) { int want = DIM[a] * DIM[a] * DIM[c] * DIM[c]; if (FCNT[a][c] != want) { fprintf(stderr, "W2DOB-REFUSED: the (%d,%d) block holds %d of %d entries (a partial dump, W2_CMAX below LMAX?)\n", a, c, FCNT[a][c], want); exit(2); } } }
/* ---- the density on a grid: H[v][a][rq] = sum_c d_c sum_{r'q'} F[a][c][rq][r'q'] conj D^c(V)_{r'q'};  p(U, V) = sum_a d_a sum_{rq} conj D^a(U)_{rq} H[v][a][rq] */
static int NA; static int AOFF[16];   /* the (a, rq) slots packed: AOFF[a] the offset, NA the total */
static void hvec(quat V, cplx *H) { cplx DV[16][256]; for (int c = 0; c <= LMAX; c++) rep(c, V, DV[c]);
  for (int a = 0; a <= LMAX; a++) { int da = DIM[a]; for (int rq = 0; rq < da * da; rq++) { cplx s = 0; for (int c = 0; c <= LMAX; c++) { int dc = DIM[c]; const cplx *Fb = FH[a][c] + (size_t)rq * dc * dc; cplx t2 = 0; for (int t = 0; t < dc * dc; t++) t2 += Fb[t] * conj(DV[c][t]); s += dc * t2; } H[AOFF[a] + rq] = s; } } }
static double pdens(const cplx *DUa, const cplx *H) { cplx s = 0; for (int a = 0; a <= LMAX; a++) { int da = DIM[a]; const cplx *D = DUa + AOFF[a]; const cplx *h = H + AOFF[a]; cplx t = 0; for (int rq = 0; rq < da * da; rq++) t += conj(D[rq]) * h[rq]; s += da * t; } return creal(s); }
static void dvec(quat U, cplx *DU) { for (int a = 0; a <= LMAX; a++) rep(a, U, DU + AOFF[a]); }
static double marg_B(const cplx *H) { return creal(H[AOFF[0]]); }   /* a = 0, d_0 = 1: p_B(V) = sum_c d_c sum F[0][c][0][r'q'] conj D^c(V) */
static void projector(int a, int c, int k, cplx *P, int NPT, const quat *RU, const double *RW) { int da = DIM[a], dc = DIM[c]; size_t n = (size_t)da * dc; memset(P, 0, sizeof(cplx) * n * n); cplx Ra[256], Rc[256];
  for (int pt = 0; pt < NPT; pt++) { double w = RW[pt] * DIM[k] * chi(k, RU[pt]); rep(a, RU[pt], Ra); rep(c, RU[pt], Rc);
    for (int q = 0; q < da; q++) for (int qp = 0; qp < dc; qp++) for (int r = 0; r < da; r++) for (int rp = 0; rp < dc; rp++) P[((size_t)q * dc + qp) * n + (size_t)r * dc + rp] += w * Ra[q * da + r] * Rc[qp * dc + rp]; } }
static double angle_of(quat q) { double w = q.w; if (w > 1) w = 1; if (w < -1) w = -1; return 2 * acos(w); }
static quat small_rot(int dir, double eps) { /* 26 directions on the unit 3-ball's shell + the axes: dir in 0..25 */ double v[3] = {0, 0, 0}; int d = dir;
  if (d < 6) { v[d / 2] = (d % 2) ? -1 : 1; } else { d -= 6; int sx = (d % 3) - 1; d /= 3; int sy = (d % 3) - 1; d /= 3; int sz = (d % 3) - 1; v[0] = sx; v[1] = sy; v[2] = sz; }
  double nn = sqrt(v[0] * v[0] + v[1] * v[1] + v[2] * v[2]); if (nn < 1e-12) { quat e = { 1, 0, 0, 0 }; return e; } double h = eps / 2; quat r = { cos(h), sin(h) * v[0] / nn, sin(h) * v[1] / nn, sin(h) * v[2] / nn }; return r; }
int main(int argc, char **argv) {
  if (argc < 2) { fprintf(stderr, "usage: w2_dob <record> [deg=30] [deg2=60] [vdeg=12] [refine=24]\n"); return 1; }
  int deg = argc > 2 ? atoi(argv[2]) : 30, deg2 = argc > 3 ? atoi(argv[3]) : 60, vdeg = argc > 4 ? atoi(argv[4]) : 12, nref = argc > 5 ? atoi(argv[5]) : 24;
  FACT[0] = 1; for (int i = 1; i < 40; i++) FACT[i] = FACT[i - 1] * i;
  for (int k = 0; k < 16; k++) DIM[k] = k + 1;   /* every spin's dimension, the channels k reaching 2 LMAX (the first draft set DIM to LMAX only and the k > LMAX projectors had dimension 0) */
  int SCHUR = (argc > 6 && !strcmp(argv[6], "schur"));
  read_record(argv[1], SCHUR);
  if (SCHUR) { /* THE SCHUR RECONSTRUCTION: a record with the class moments and the channels but no dump (the landed W3L2 two-step records) read under the
                  ordered datum's invariance, F/Z = sum_k (f_k/d_k) P_k, E[D^c(B)] = (E[chi_c]/d_c) I -- valid at the ordered datum alone (K4), said on every line */
    if (LMAX < 0) { LMAX = 0; while (LMAX + 1 < 16 && HASCLS[LMAX + 1][0]) LMAX++; GENREC = 1; Z = 1; for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= LMAX; c++) { FH[a][c] = calloc((size_t)DIM[a] * DIM[a] * DIM[c] * DIM[c], sizeof(cplx)); FCNT[a][c] = DIM[a] * DIM[a] * DIM[c] * DIM[c]; } }
    else { fprintf(stderr, "schur: the record already holds a dump; read it without the flag\n"); return 1; }
    printf("W2DOB-SCHUR-MODE: F reconstructed from the record's class moments and channels under the ORDERED datum's simultaneous-conjugation invariance (valid there alone); LMAX read as %d\n", LMAX); }
  NA = 0; for (int a = 0; a <= LMAX; a++) { AOFF[a] = NA; NA += DIM[a] * DIM[a]; }
  printf("W2DOB-RECORD %s: LMAX=%d (loop representations to spin %d/2), Z=%.17e, GENINV(record)=%d, %d blocks\n", argv[1], LMAX, LMAX, Z, GENREC, (LMAX + 1) * (LMAX + 1));
  /* KR: the representation convention, derived as the engine derives it, must be the record's */
  { quat q1 = {0.5, 0.5, 0.5, 0.5}, q2 = {1 / sqrt(2), 0, 1 / sqrt(2), 0}; quat q12 = qmul(q1, q2); int found = -1;
    for (int trial = 0; trial < 2; trial++) { GENINV = trial; double dmax = 0; for (int s = 1; s <= LMAX; s++) { int d = s + 1; cplx P[256], X1[256], X2[256]; rep(s, q12, P); rep(s, q1, X1); rep(s, q2, X2);
        for (int i = 0; i < d; i++) for (int j = 0; j < d; j++) { cplx acc = 0; for (int k = 0; k < d; k++) acc += X1[i * d + k] * X2[k * d + j]; if (cabs(acc - P[i * d + j]) > dmax) dmax = cabs(acc - P[i * d + j]); } }
      if (dmax < 1e-12) { found = trial; break; } }
    printf("W2DOB-KAT KR representation homomorphism: GENINV=%d derived, record's %d [%s]\n", found, GENREC, found == GENREC ? "MET" : "FAILED"); if (found != GENREC) return 1; GENINV = GENREC; }
  quat *RU, *RU2, *RV; double *RW, *RW2, *RWV; int NU = make_rule(deg, &RU, &RW), NU2 = make_rule(deg2, &RU2, &RW2), NV = make_rule(vdeg, &RV, &RWV);
  /* K0: the rule's weights sum to one and the characters are orthonormal on it to spin LMAX (degree 2 LMAX) */
  { double sw = 0, worst = 0; for (int i = 0; i < NU; i++) sw += RW[i]; for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= LMAX; c++) { double s = 0; for (int i = 0; i < NU; i++) s += RW[i] * chi(a, RU[i]) * chi(c, RU[i]); double e = fabs(s - (a == c)); if (e > worst) worst = e; }
    printf("W2DOB-KAT K0 rule degree %d (%d points): weights sum %.15f, character orthonormality to %.1e [%s]\n", deg, NU, sw, worst, (fabs(sw - 1) < 1e-12 && worst < 1e-12) ? "MET" : "FAILED"); }
  if (SCHUR) { /* the reconstruction proper, on the rule: F/Z = sum_k (f_k/d_k) P_k, the channel of a = 0 or c = 0 the class moment itself */
    for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= LMAX; c++) { int da = DIM[a], dc = DIM[c]; size_t nn = (size_t)da * dc; cplx *P = malloc(sizeof(cplx) * nn * nn);
      for (int k = abs(a - c); k <= a + c; k += 2) { double fk; if (a == 0 || c == 0) { if (!HASCLS[a][c]) { fprintf(stderr, "schur: no class moment at (%d,%d)\n", a, c); return 2; } fk = CLSREC[a][c]; }
        else { if (!HASFK[a][c][k]) { fprintf(stderr, "schur: no channel line at (%d,%d) k=%d\n", a, c, k); return 2; } fk = FKREC[a][c][k]; }
        projector(a, c, k, P, NU, RU, RW); double lam = fk / DIM[k];
        for (int q = 0; q < da; q++) for (int qp = 0; qp < dc; qp++) for (int r = 0; r < da; r++) for (int rp = 0; rp < dc; rp++) FH[a][c][fidx(da, dc, r, q, rp, qp)] += lam * P[((size_t)q * dc + qp) * nn + (size_t)r * dc + rp]; }
      free(P); } }
  /* K2: the class moments from the dump against the record's */
  { double worst = 0; int n = 0; for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= LMAX; c++) { int da = DIM[a], dc = DIM[c]; cplx s = 0; for (int r = 0; r < da; r++) for (int rp = 0; rp < dc; rp++) s += FH[a][c][fidx(da, dc, r, r, rp, rp)];
      if (HASCLS[a][c]) { double e = fabs(creal(s) - CLSREC[a][c]) / (1 + fabs(CLSREC[a][c])); if (e > worst) worst = e; n++; } }
    printf("W2DOB-KAT K2 class moments from the dump against the record's %d lines: worst relative difference %.1e [%s]\n", n, worst, (n == (LMAX + 1) * (LMAX + 1) && worst < 1e-9) ? "MET" : "FAILED"); }
  /* the density tables: DU on both rules, H on the V grid */
  cplx *DU = malloc(sizeof(cplx) * (size_t)NU * NA), *DU2 = malloc(sizeof(cplx) * (size_t)NU2 * NA), *HV = malloc(sizeof(cplx) * (size_t)NV * NA);
  for (int u = 0; u < NU; u++) dvec(RU[u], DU + (size_t)u * NA); for (int u = 0; u < NU2; u++) dvec(RU2[u], DU2 + (size_t)u * NA); for (int v = 0; v < NV; v++) hvec(RV[v], HV + (size_t)v * NA);
  /* K3 and K4: the channels and the Schur residual */
  { double worst3 = 0, worst4 = 0; int n3 = 0;
    for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= LMAX; c++) { int da = DIM[a], dc = DIM[c]; size_t nn = (size_t)da * dc; cplx *P = malloc(sizeof(cplx) * nn * nn), *S = calloc(nn * nn, sizeof(cplx));
      for (int k = abs(a - c); k <= a + c; k += 2) { projector(a, c, k, P, NU, RU, RW);
        cplx f = 0; for (int q = 0; q < da; q++) for (int qp = 0; qp < dc; qp++) for (int r = 0; r < da; r++) for (int rp = 0; rp < dc; rp++) f += P[((size_t)q * dc + qp) * nn + (size_t)r * dc + rp] * FH[a][c][fidx(da, dc, r, q, rp, qp)];
        if (a > 0 && c > 0 && HASFK[a][c][k]) { double e = fabs(creal(f) - FKREC[a][c][k]) / (1 + fabs(FKREC[a][c][k])); if (e > worst3) worst3 = e; n3++; }
        double lam = creal(f) / DIM[k]; for (size_t i = 0; i < nn * nn; i++) S[i] += lam * P[i]; }
      /* the residual F - sum_k lam_k P_k, F read as the matrix [(q,qp),(r,rp)] -> F(r,q,rp,qp) in the channel code's convention */
      double res = 0; for (int q = 0; q < da; q++) for (int qp = 0; qp < dc; qp++) for (int r = 0; r < da; r++) for (int rp = 0; rp < dc; rp++) { cplx d = S[((size_t)q * dc + qp) * nn + (size_t)r * dc + rp] - FH[a][c][fidx(da, dc, r, q, rp, qp)]; if (cabs(d) > res) res = cabs(d); }
      printf("W2DOB-SCHUR a=%d c=%d residual |F/Z - sum_k (f_k/d_k) P_k| = %.3e\n", a, c, res); if (res > worst4) worst4 = res; free(P); free(S); }
    printf("W2DOB-KAT K3 channels from the dump against the record's %d lines: worst relative difference %.1e [%s]\n", n3, worst3, worst3 < 1e-9 ? "MET" : (n3 ? "FAILED" : "NO-LINES"));
    printf("W2DOB-K4 Schur residual over all blocks %.3e: %s\n", worst4, worst4 < 1e-9 ? "the joint law is invariant under simultaneous conjugation to roundoff (the ordered datum's KAT: MET)" : "the invariance is BROKEN by this datum (a reading, not a failure; a KAT only at the ordered datum)"); }
  /* THE POSITIVITY CENSUS on the U rule x V grid */
  double *PUV = malloc(sizeof(double) * (size_t)NU * NV), *PB = malloc(sizeof(double) * NV); double minp = 1e300, maxp = -1e300, minpb = 1e300; long long nneg = 0;
  for (int v = 0; v < NV; v++) { PB[v] = marg_B(HV + (size_t)v * NA); if (PB[v] < minpb) minpb = PB[v]; }
  #pragma omp parallel for reduction(min:minp) reduction(max:maxp) reduction(+:nneg)
  for (int v = 0; v < NV; v++) for (int u = 0; u < NU; u++) { double p = pdens(DU + (size_t)u * NA, HV + (size_t)v * NA); PUV[(size_t)v * NU + u] = p; if (p < minp) minp = p; if (p > maxp) maxp = p; if (p < 0) nneg++; }
  double minpa = 1e300; { cplx *H1 = malloc(sizeof(cplx) * NA); quat e = { 1, 0, 0, 0 }; (void)e; /* p_A(U) = sum_v-free: the a-row with c = 0 */
    for (int u = 0; u < NU; u++) { cplx s = 0; for (int a = 0; a <= LMAX; a++) { int da = DIM[a]; for (int rq = 0; rq < da * da; rq++) s += da * conj(DU[(size_t)u * NA + AOFF[a] + rq]) * FH[a][0][(size_t)rq]; } if (creal(s) < minpa) minpa = creal(s); } free(H1); }
  /* K2': the Peter-Weyl round trip F -> p -> F, U on the deg rule and V on the V grid (a rule exact to degree vdeg >= 2 LMAX, which the integrand needs) */
  { double worst = 0; cplx *MU = malloc(sizeof(cplx) * (size_t)NV * NA);   /* MU[v][a][rq] = sum_u RW[u] p(u,v) D^a(U)_{rq} */
    #pragma omp parallel for schedule(static)
    for (int v = 0; v < NV; v++) { for (int i = 0; i < NA; i++) MU[(size_t)v * NA + i] = 0; for (int u = 0; u < NU; u++) { double w = RW[u] * PUV[(size_t)v * NU + u]; for (int i = 0; i < NA; i++) MU[(size_t)v * NA + i] += w * DU[(size_t)u * NA + i]; } }
    for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= LMAX; c++) { int da = DIM[a], dc = DIM[c];
      for (int r = 0; r < da; r++) for (int q = 0; q < da; q++) for (int rp = 0; rp < dc; rp++) for (int qp = 0; qp < dc; qp++) { cplx acc = 0; for (int v = 0; v < NV; v++) { cplx DVc[256]; rep(c, RV[v], DVc); acc += RWV[v] * DVc[rp * dc + qp] * MU[(size_t)v * NA + AOFF[a] + r * da + q]; }
        double e = cabs(acc - FH[a][c][fidx(da, dc, r, q, rp, qp)]); if (e > worst) worst = e; } }
    printf("W2DOB-KAT K2' Peter-Weyl round trip F -> p -> F (U on the degree-%d rule, V on the degree-%d grid): worst absolute difference %.1e [%s]\n", deg, vdeg, worst, worst < 1e-9 ? "MET" : "FAILED"); free(MU); }
  int signed_joint = (minp < -1e-12 * (maxp > 0 ? maxp : 1)), signed_margB = (minpb <= 0);
  printf("W2DOB-CENSUS joint density on %d x %d points: min %.6e max %.6e, negative at %lld (%.3f %%); marginal p_B min %.6e on the V grid, marginal p_A min %.6e on the U rule -> joint %s, p_B %s\n", NU, NV, minp, maxp, nneg, 100.0 * nneg / ((double)NU * NV), minpb, minpa, signed_joint ? "SIGNED" : "POSITIVE", signed_margB ? "NOT POSITIVE" : "POSITIVE");
  /* THE SUP OVER (V, V') ON THE GRID: TV and Delta */
  double bestTV = -1; int bv = -1, bvp = -1; double bestD = -1; int dv = -1, dvp = -1; long long nref_pairs = 0, npairs = 0;
  #pragma omp parallel
  { double lTV = -1; int lv = -1, lvp = -1; double lD = -1; int ldv = -1, ldvp = -1; long long lref = 0, lpairs = 0;
    #pragma omp for schedule(dynamic)
    for (int v = 0; v < NV; v++) { if (PB[v] <= 0) continue; for (int vp = v + 1; vp < NV; vp++) { if (PB[vp] <= 0) continue; lpairs++;
        double tv = 0, lmax = -1e300, lmin = 1e300; int ok = 1; const double *pv = PUV + (size_t)v * NU, *pvp = PUV + (size_t)vp * NU;
        for (int u = 0; u < NU; u++) { double x = pv[u] / PB[v], y = pvp[u] / PB[vp]; tv += RW[u] * fabs(x - y); if (x > 0 && y > 0) { double L = log(x) - log(y); if (L > lmax) lmax = L; if (L < lmin) lmin = L; } else ok = 0; }
        tv *= 0.5; if (tv > lTV) { lTV = tv; lv = v; lvp = vp; }
        if (ok) { double D = lmax - lmin; if (D > lD) { lD = D; ldv = v; ldvp = vp; } } else lref++; } }
    #pragma omp critical
    { if (lTV > bestTV) { bestTV = lTV; bv = lv; bvp = lvp; } if (lD > bestD) { bestD = lD; dv = ldv; dvp = ldvp; } nref_pairs += lref; npairs += lpairs; } }
  printf("W2DOB-GRID V grid degree %d (%d points), %lld pairs read, %lld pairs refused for Delta (a non-positive conditional): grid sup TV %.9f at V=(angle %.4f) V'=(angle %.4f), rel. angle %.4f; grid sup Delta %s\n", vdeg, NV, npairs, nref_pairs, bestTV, bv >= 0 ? angle_of(RV[bv]) : -1, bvp >= 0 ? angle_of(RV[bvp]) : -1, (bv >= 0 && bvp >= 0) ? angle_of(qmul(qinv(RV[bv]), RV[bvp])) : -1, bestD >= 0 ? "" : "REFUSED everywhere");
  if (bestD >= 0) printf("W2DOB-GRID-DELTA %.9f at V=(angle %.4f) V'=(angle %.4f)\n", bestD, angle_of(RV[dv]), angle_of(RV[dvp]));
  /* THE LOCAL REFINEMENT about the maximiser: hill-climb over small rotations of V and V' (26 directions, halving radius), on the deg rule and then on deg2 */
  double Cref[2] = { bestTV, bestTV }, Dref = bestD; quat V0 = RV[bv], V1 = RV[bvp]; quat W0 = (dv >= 0) ? RV[dv] : V0, W1 = (dvp >= 0) ? RV[dvp] : V1;
  for (int pass = 0; pass < 2; pass++) { int n = pass ? NU2 : NU; const quat *R = pass ? RU2 : RU; const double *W = pass ? RW2 : RW; const cplx *D = pass ? DU2 : DU;
    cplx *Ha = malloc(sizeof(cplx) * NA), *Hb = malloc(sizeof(cplx) * NA); double *pa = malloc(sizeof(double) * n), *pb = malloc(sizeof(double) * n);
    /* the macro's accumulator is tvacc, never t: the first draft named it t, which SHADOWED the caller's `double t` at every neighbour, so the caller's t stayed
       uninitialised, every comparison with it was false and the climb accepted no move while reporting the grid value (caught by the degree-20 grid's lower maximum, 17:3x) */
    #define EVAL_TV(VA, VB, OUT) { hvec(VA, Ha); hvec(VB, Hb); double qa = marg_B(Ha), qb = marg_B(Hb); double tvacc = 0; if (qa > 0 && qb > 0) { for (int u = 0; u < n; u++) { pa[u] = pdens(D + (size_t)u * NA, Ha) / qa; pb[u] = pdens(D + (size_t)u * NA, Hb) / qb; tvacc += W[u] * fabs(pa[u] - pb[u]); } OUT = 0.5 * tvacc; } else OUT = -1; }
    double cur; EVAL_TV(V0, V1, cur); double eps = 0.5; int steps = 0; int dbg = getenv("W2DOB_DEBUG") != NULL;
    for (int it = 0; it < nref * 6 && eps > 1e-5; it++) { int moved = 0; double tbest = -2;
      for (int side = 0; side < 2 && !moved; side++) for (int dir = 0; dir < 26 && !moved; dir++) { quat r = small_rot(dir, eps); quat A = side ? V0 : qmul(r, V0), B = side ? qmul(r, V1) : V1; double t; EVAL_TV(A, B, t); if (t > tbest) tbest = t; if (t > cur + 1e-13) { cur = t; V0 = A; V1 = B; moved = 1; steps++; } }
      if (dbg) printf("W2DOB-DEBUG pass %d it %d eps %.4f cur %.9f best neighbour %.9f moved %d\n", pass, it, eps, cur, tbest, moved);
      if (!moved) eps *= 0.5; }
    Cref[pass] = cur; printf("W2DOB-C rule degree %d (%d points): C = %.9f after %d accepted moves (grid %.9f, movement %+.2e) at V=(angle %.4f) V'=(angle %.4f), rel. angle %.4f\n", pass ? deg2 : deg, n, cur, steps, bestTV, cur - bestTV, angle_of(V0), angle_of(V1), angle_of(qmul(qinv(V0), V1)));
    if (pass == 0 && bestD >= 0) { /* Delta's refinement on the deg rule */
      #define EVAL_D(VA, VB, OUT) { hvec(VA, Ha); hvec(VB, Hb); double qa = marg_B(Ha), qb = marg_B(Hb); double lmax = -1e300, lmin = 1e300; int ok = (qa > 0 && qb > 0); if (ok) for (int u = 0; u < n; u++) { double x = pdens(D + (size_t)u * NA, Ha) / qa, y = pdens(D + (size_t)u * NA, Hb) / qb; if (x > 0 && y > 0) { double L = log(x) - log(y); if (L > lmax) lmax = L; if (L < lmin) lmin = L; } else { ok = 0; break; } } OUT = ok ? lmax - lmin : -1; }
      double curD; EVAL_D(W0, W1, curD); double epsD = 0.5; int stepsD = 0;
      for (int it = 0; it < nref * 6 && epsD > 1e-5; it++) { int moved = 0;
        for (int side = 0; side < 2 && !moved; side++) for (int dir = 0; dir < 26 && !moved; dir++) { quat r = small_rot(dir, epsD); quat A = side ? W0 : qmul(r, W0), B = side ? qmul(r, W1) : W1; double t; EVAL_D(A, B, t); if (t > curD + 1e-13) { curD = t; W0 = A; W1 = B; moved = 1; stepsD++; } }
        if (!moved) epsD *= 0.5; }
      Dref = curD; printf("W2DOB-DELTA rule degree %d: Delta = %.9f after %d accepted moves (grid %.9f, movement %+.2e) at V=(angle %.4f) V'=(angle %.4f); the tilt bound 1 - e^-Delta = %.9f\n", deg, curD, stepsD, bestD, curD - bestD, angle_of(W0), angle_of(W1), 1 - exp(-curD)); }
    free(Ha); free(Hb); free(pa); free(pb); }
  double C = Cref[1] > Cref[0] ? Cref[1] : Cref[0]; double rel = fabs(Cref[1] - Cref[0]) / (C > 1e-6 ? C : 1e-6);   /* the floor 1e-6: at the free datum both values are roundoff and their ratio means nothing */
  printf("W2DOB-KAT K5 the two rules (degrees %d, %d) on C: %.9f against %.9f, relative difference %.2e [%s]\n", deg, deg2, Cref[0], Cref[1], rel, rel < 1e-3 ? "MET" : "FAILED");
  if (signed_joint || signed_margB) printf("W2DOB-REFUSED C: the truncated joint density is %s and the conditioning marginal is %s on the grid -- the numbers above are an L1 distance between SIGNED truncated laws, not a total variation; no C is read from this record at this cap\n", signed_joint ? "SIGNED" : "positive", signed_margB ? "NOT POSITIVE" : "positive");
  else { printf("W2DOB-RESULT C(A,B) at the datum = %.9f (a grid-refined LOWER bound on the group's supremum; loop representations to spin %d/2); tilt bound 1 - e^-Delta = %s; ratio C/bound = %s; S20 (twenty adjacent coarse plaquettes, the bent column, kappa -> 0) = %.6f %s\n", C, LMAX, Dref >= 0 ? "see W2DOB-DELTA" : "REFUSED", Dref >= 0 ? "see below" : "REFUSED", 20 * C, 20 * C > 1 ? "> 1 (survives the grid)" : "< 1 (the grid cannot certify it)");
    if (Dref >= 0) printf("W2DOB-RATIO C / (1 - e^-Delta) = %.6f (Delta = %.9f, bound %.9f)\n", C / (1 - exp(-Dref)), Dref, 1 - exp(-Dref)); }
  printf("W2DOB-DONE\n"); return 0; }
