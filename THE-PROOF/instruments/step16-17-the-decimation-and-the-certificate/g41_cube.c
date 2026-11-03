/* g41_cube.c -- THE SU(2) CUBE'S RING CONTRACTION IN C, THE WEIGHT TRUNCATED AT SPIN WMAX/2 (ΠΕΝΤΑΠΥΛΟΝ G41, 2026-10-29 06:5x EDT, the author;
 * RESULTS 16.32: the spin-1 truncation moved the square's blocked coupling at 2.2 by 40 %, so every cube reading at 2.2 is re-read at spins <= 2 here).
 * A LINE-FOR-LINE PORT of g31_cube_pair.pl (itself g26/g14's construction): the twelve links of a unit 3-cube in Z^4, its six faces, every cube link
 * with four external plaquettes on 88 outside links (the data); every plaquette weight w(V) = sum_{s <= WMAX} (s+1) a_s chi_{s/2}(V), a_s = I_{s+1}/I_1;
 * the top face, side face 0 and the bottom face RESOLVED (weight 1, their sectors widened to TMAX, S0MAX, BMAX), the other three sides at WMAX; the
 * ring of four columns (t_i, b_i, v_{i+1}); ZRES[t][s][b] from the trace split by the resolved faces' spins; every moment by the fusion rule.  The
 * representations are the symmetric powers of the fundamental for every spin (the inverse substitution, which composes as a homomorphism -- checked
 * at load with the traces against chi), the rule the product rule at the derived degree (its moments against Catalan at load).  The outside links are
 * indexed in g31's order (the same okey() call sequence), so a datum index means the same link in both.
 * MODES: kat (the free cube against its closed form), base (Z, E[chi_a] of the three resolved faces, the connected pairs top x side0 and top x bottom),
 * resp (for each of the 14 link classes of 16.20 S2 -- read from a class file, or the two verticals -- and a grid of rotation angles: the response of
 * E[chi_1/2(top)]/2 and the TV of the top face's truncated class law), worst (the cancelling datum on t0 and the un-cancelling rotations of its first
 * middle link).  usage: g41_cube beta MODE WMAX TMAX S0MAX BMAX [angles...]   env G41_DATUM=ordered|cancel|random:SEED|near:SEED:EPS  G41_LINKS="i j .."
 * build: gcc -O2 -fopenmp -o g41_cube.exe g41_cube.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
#include <time.h>
typedef double complex cplx;
#define PI 3.141592653589793
static double BETA; static int WMAX, TMAX, S0MAX, BMAX, SMAX;
static double A[32], FAC[32]; static int DIM[32];
static double FACT[40];
/* ---- quaternions */
typedef struct { double w, x, y, z; } quat;
static quat qmul(quat a, quat b) { quat r; r.w = a.w*b.w - a.x*b.x - a.y*b.y - a.z*b.z; r.x = a.w*b.x + a.x*b.w + a.y*b.z - a.z*b.y; r.y = a.w*b.y - a.x*b.z + a.y*b.w + a.z*b.x; r.z = a.w*b.z + a.x*b.y - a.y*b.x + a.z*b.w; return r; }
static quat qinv(quat a) { quat r = { a.w, -a.x, -a.y, -a.z }; return r; }
static double bessel(int n, double x) { double s = 0, t = pow(x / 2, n), f = 1; for (int i = 1; i <= n; i++) f *= i; t /= f; for (int k = 0; k < 400; k++) { s += t; t *= (x / 2) * (x / 2) / ((k + 1.0) * (k + 1.0 + n)); if (t < 1e-19 * s) break; } return s; }
static double chi(int s, quat q) { double w = q.w, u0 = 1, u1 = 2 * w; if (s == 0) return u0; for (int k = 2; k <= s; k++) { double u2 = 2 * w * u1 - u0; u0 = u1; u1 = u2; } return u1; }
static double wgt(quat V) { double s = 1; for (int k = 1; k <= WMAX; k++) s += (k + 1) * A[k] * chi(k, V); return s; }
/* the spin-s/2 representation on the symmetric power (g31's Dsub), D[p][qq], with the substitution by q (GENINV=0) or q^-1 (GENINV=1) */
static int GENINV = 0;
static void Dsub(int s, quat q, cplx *D) {         /* D is (s+1) x (s+1), row-major D[p*(s+1)+qq] */
  cplx a = q.w + I * q.x, b = q.y + I * q.z, ab = q.w - I * q.x, nbb = -q.y + I * q.z;
  cplx poly[40], np[40];
  for (int qq = 0; qq <= s; qq++) { int len = 1; poly[0] = 1;
    for (int r = 0; r < qq; r++) { for (int k = 0; k <= len; k++) np[k] = 0; for (int k = 0; k < len; k++) { np[k + 1] += poly[k] * a; np[k] += poly[k] * b; } len++; for (int k = 0; k < len; k++) poly[k] = np[k]; }
    for (int r = 0; r < s - qq; r++) { for (int k = 0; k <= len; k++) np[k] = 0; for (int k = 0; k < len; k++) { np[k + 1] += poly[k] * nbb; np[k] += poly[k] * ab; } len++; for (int k = 0; k < len; k++) poly[k] = np[k]; }
    for (int p = 0; p <= s; p++) { double sc = sqrt(FACT[p] * FACT[s - p] / (FACT[qq] * FACT[s - qq])); D[p * (s + 1) + qq] = poly[p] * sc; } } }
static void rep(int s, quat q, cplx *D) { if (s == 0) { D[0] = 1; return; } Dsub(s, GENINV ? qinv(q) : q, D); }
/* ---- the rule */
static int NPT; static quat *RU; static double *RW;
static void gauss_legendre(int n, double *x, double *w) { for (int i = 1; i <= n; i++) { double z = cos(PI * (i - 0.25) / (n + 0.5)), dp = 0;
    for (int it = 0; it < 200; it++) { double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2 * k - 1) * z * p1 - (k - 1) * p0) / k; p0 = p1; p1 = p2; } dp = n * (z * p1 - p0) / (z * z - 1); double dx = p1 / dp; z -= dx; if (fabs(dx) < 1e-16) break; }
    double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2 * k - 1) * z * p1 - (k - 1) * p0) / k; p0 = p1; p1 = p2; } dp = n * (z * p1 - p0) / (z * z - 1); x[i - 1] = z; w[i - 1] = 2 / ((1 - z * z) * dp * dp); } }
static void make_rule(int deg) { int nth = (deg + 2) / 2, ngl = (deg + 2) / 2, naz = deg + 1; double gx[200], gw[200]; gauss_legendre(ngl, gx, gw);
  NPT = nth * ngl * naz; RU = malloc(sizeof(quat) * NPT); RW = malloc(sizeof(double) * NPT); int n = 0;
  for (int k = 1; k <= nth; k++) { double th = k * PI / (nth + 1), wt = 2 * sin(th) * sin(th) / (nth + 1);
    for (int j = 0; j < ngl; j++) { double t = gx[j], st = sqrt(1 - t * t);
      for (int l = 0; l < naz; l++) { double ph = 2 * PI * l / naz; quat u = { cos(th), sin(th) * st * cos(ph), sin(th) * st * sin(ph), sin(th) * t }; RU[n] = u; RW[n] = wt * gw[j] / 2 / naz; n++; } } } }
/* ---- the cube (g14's construction, g31's order) */
typedef struct { int base[4], dir, sgn; } edge_t;
static const char *ENAME[12] = { "b0", "b1", "b2", "b3", "t0", "t1", "t2", "t3", "v0", "v1", "v2", "v3" };   /* perl's sort order of the edge names */
static edge_t EDGE[12];
static int FACECYC[6][4], FACESGN[6][4];          /* faces in perl's sort order: bottom, side0, side1, side2, side3, top */
static const char *FNAME[6] = { "bottom", "side0", "side1", "side2", "side3", "top" };
static int NOUT = 0; static int OUTB[200][4], OUTD[200];
static int okey(int *b, int d) { for (int i = 0; i < NOUT; i++) { if (OUTD[i] == d && !memcmp(OUTB[i], b, sizeof(int) * 4)) return i; } memcpy(OUTB[NOUT], b, sizeof(int) * 4); OUTD[NOUT] = d; return NOUT++; }
static int DANG[12][4][3][2];                     /* per edge, its four staples, three outside links each: (index, sign) */
static int SLOTF[12][2], SLOTM[12][2], SLOTS[12][2];   /* per edge: its two faces (in perl's sort order of face names), cycle position, sign */
static int CAP[6];
static int eidx(const char *n) { for (int i = 0; i < 12; i++) if (!strcmp(ENAME[i], n)) return i; return -1; }
static void build_cube(void) {
  int C[4][2] = { {0,0}, {1,0}, {1,1}, {0,1} };
  for (int i = 0; i < 4; i++) { int n = (i + 1) % 4; int x0 = C[i][0], y0 = C[i][1], x1 = C[n][0], y1 = C[n][1]; int dir = (x1 != x0) ? 1 : 2; int fwd = (x1 + y1 > x0 + y0) ? 1 : -1; int bx = fwd > 0 ? x0 : x1, by = fwd > 0 ? y0 : y1;
    edge_t b = { {bx, by, 0, 0}, dir, fwd }, t = { {bx, by, 1, 0}, dir, fwd }, v = { {x0, y0, 0, 0}, 3, 1 }; EDGE[i] = b; EDGE[4 + i] = t; EDGE[8 + i] = v; }
  /* faces: bottom (0) = b_i with sgn; top (5) = t_i with sgn; side_i (1+i) = [b_i sgn, v_n +1, t_i -sgn, v_i -1] */
  for (int i = 0; i < 4; i++) { FACECYC[0][i] = i; FACESGN[0][i] = EDGE[i].sgn; FACECYC[5][i] = 4 + i; FACESGN[5][i] = EDGE[4 + i].sgn; }
  for (int i = 0; i < 4; i++) { int n = (i + 1) % 4; FACECYC[1 + i][0] = i; FACESGN[1 + i][0] = EDGE[i].sgn; FACECYC[1 + i][1] = 8 + n; FACESGN[1 + i][1] = 1; FACECYC[1 + i][2] = 4 + i; FACESGN[1 + i][2] = -EDGE[4 + i].sgn; FACECYC[1 + i][3] = 8 + i; FACESGN[1 + i][3] = -1; }
  /* the dangling staples, in g31's okey order: edges in perl's sort order, k = 1..4 (k != d), sides, then l1, l2, l3 */
  for (int e = 0; e < 12; e++) { int *p = EDGE[e].base, d = EDGE[e].dir; int pd[4]; memcpy(pd, p, sizeof pd); pd[d - 1] += 1; int ns = 0;
    for (int k = 1; k <= 4; k++) { if (k == d) continue; int sides[2], nsd; if (k == 4) { sides[0] = 1; sides[1] = -1; nsd = 2; } else { sides[0] = (p[k - 1] == 1) ? 1 : -1; nsd = 1; }
      for (int si = 0; si < nsd; si++) { int s = sides[si]; int q[4];
        if (s > 0) { DANG[e][ns][0][0] = okey(pd, k); DANG[e][ns][0][1] = 1; } else { memcpy(q, pd, sizeof q); q[k - 1] -= 1; DANG[e][ns][0][0] = okey(q, k); DANG[e][ns][0][1] = -1; }
        memcpy(q, p, sizeof q); q[k - 1] += s; DANG[e][ns][1][0] = okey(q, d); DANG[e][ns][1][1] = -1;
        if (s > 0) { DANG[e][ns][2][0] = okey(p, k); DANG[e][ns][2][1] = -1; } else { memcpy(q, p, sizeof q); q[k - 1] -= 1; DANG[e][ns][2][0] = okey(q, k); DANG[e][ns][2][1] = 1; }
        ns++; } }
    if (ns != 4) { fprintf(stderr, "edge %s has %d staples\n", ENAME[e], ns); exit(1); } }
  if (NOUT != 88) { fprintf(stderr, "outside links: %d, not 88\n", NOUT); exit(1); }
  int cnt[12] = {0}; for (int f = 0; f < 6; f++) for (int m = 0; m < 4; m++) { int e = FACECYC[f][m]; SLOTF[e][cnt[e]] = f; SLOTM[e][cnt[e]] = m; SLOTS[e][cnt[e]] = FACESGN[f][m]; cnt[e]++; }
  for (int e = 0; e < 12; e++) if (cnt[e] != 2) { fprintf(stderr, "edge %s in %d faces\n", ENAME[e], cnt[e]); exit(1); }
  CAP[0] = BMAX; CAP[1] = S0MAX; CAP[2] = CAP[3] = CAP[4] = WMAX; CAP[5] = TMAX; }
static quat staple(int e, int k, quat *dat) { quat T = { 1, 0, 0, 0 }; for (int j = 0; j < 3; j++) { quat V = dat[DANG[e][k][j][0]]; if (DANG[e][k][j][1] < 0) V = qinv(V); T = qmul(T, V); } return T; }
/* ---- link tensors: LT[e] = block (s1, s2) of size d1^2 d2^2, index ((a d1 + b) d2 + c) d2 + d; s1 in the first slot's face cap, s2 in the second */
static int FREE = 0;
typedef struct { cplx *blk[16][16]; } ltens;
static ltens LT[12];
static void linktensor(int e, quat *dat) { int f1 = SLOTF[e][0], f2 = SLOTF[e][1]; int c1 = CAP[f1], c2 = CAP[f2]; int sg1 = SLOTS[e][0], sg2 = SLOTS[e][1];
  quat T[4]; for (int k = 0; k < 4; k++) T[k] = staple(e, k, dat);
  for (int s1 = 0; s1 <= c1; s1++) for (int s2 = 0; s2 <= c2; s2++) { int d1 = DIM[s1], d2 = DIM[s2]; if (LT[e].blk[s1][s2]) free(LT[e].blk[s1][s2]); LT[e].blk[s1][s2] = calloc((size_t)d1 * d1 * d2 * d2, sizeof(cplx)); }
  cplx R1[16][256], R2[16][256];
  for (int pt = 0; pt < NPT; pt++) { quat U = RU[pt]; double w = RW[pt]; if (!FREE) for (int k = 0; k < 4; k++) w *= wgt(qmul(U, T[k]));
    quat U1 = sg1 > 0 ? U : qinv(U), U2 = sg2 > 0 ? U : qinv(U);
    for (int s = 0; s <= c1; s++) rep(s, U1, R1[s]); for (int s = 0; s <= c2; s++) rep(s, U2, R2[s]);
    for (int s1 = 0; s1 <= c1; s1++) { int d1 = DIM[s1]; for (int s2 = 0; s2 <= c2; s2++) { int d2 = DIM[s2]; cplx *B = LT[e].blk[s1][s2];
      for (int ab = 0; ab < d1 * d1; ab++) { cplx f1 = R1[s1][ab] * w; for (int cd = 0; cd < d2 * d2; cd++) B[ab * d2 * d2 + cd] += f1 * R2[s2][cd]; } } } } }
/* tensorget(e, face A with (sA, iA, oA), face B with (sB, iB, oB)): g31's convention */
static inline cplx tget(int e, int fA, int sA, int iA, int oA, int sB, int iB, int oB) {
  if (SLOTF[e][0] == fA) { int d1 = DIM[sA], d2 = DIM[sB]; return LT[e].blk[sA][sB][((iA * d1 + oA) * d2 + iB) * d2 + oB]; }
  else { int d1 = DIM[sB], d2 = DIM[sA]; return LT[e].blk[sB][sA][((iB * d1 + oB) * d2 + iA) * d2 + oA]; } }
/* ---- the ring per sector (tT, tB): cut c (0..3) carries side_c's spin s <= CAP[side_c] with indices (p, q); state = ((ti dB + bi) NS(c) + soff + p d + q) */
static int NSC[4], SOFF[4][16];
static double ZRES[16][16][16], ZIM[16][16][16]; static double RELIM = 0; static int DROP = 0;
static void ring_all(void) {
  for (int c = 0; c < 4; c++) { int cap = CAP[1 + c]; int n = 0; for (int s = 0; s <= cap; s++) { SOFF[c][s] = n; n += DIM[s] * DIM[s]; } NSC[c] = n; }
  memset(ZRES, 0, sizeof ZRES);
  #pragma omp parallel for collapse(2) schedule(dynamic)
  for (int tT = 0; tT <= TMAX; tT++) for (int tB = 0; tB <= BMAX; tB++) {
    int dT = DIM[tT], dB = DIM[tB]; int nc[5]; for (int c = 0; c < 4; c++) nc[c] = dT * dB * NSC[c]; nc[4] = nc[0];
    cplx *M[4]; for (int i = 0; i < 4; i++) M[i] = calloc((size_t)nc[i] * nc[i + 1], sizeof(cplx));
    for (int i = 0; i < 4; i++) { int n = (i + 1) % 4; int t = 4 + i, b = i, v = 8 + n; int sf = 1 + i, sn = 1 + n; int ci = i, co = (i + 1) % 4; int cin = CAP[sf], cout = CAP[sn];
      for (int ti = 0; ti < dT; ti++) for (int bi = 0; bi < dB; bi++) for (int sS = 0; sS <= cin; sS++) { int dS = DIM[sS]; for (int tv = 0; tv < dS; tv++) for (int vb = 0; vb < dS; vb++) {
        int zi = (ti * dB + bi) * NSC[ci] + SOFF[ci][sS] + tv * dS + vb; double fac = (i == 0) ? 1 : FAC[sS];
        for (int to = 0; to < dT; to++) for (int bo = 0; bo < dB; bo++) for (int sS2 = 0; sS2 <= cout; sS2++) { int dS2 = DIM[sS2]; for (int tvn = 0; tvn < dS2; tvn++) for (int vbn = 0; vbn < dS2; vbn++) {
          cplx acc = 0;
          for (int bv = 0; bv < dS; bv++) { cplx fb = tget(b, 0, tB, bi, bo, sS, vb, bv); if (fb == 0) continue;
            for (int vt = 0; vt < dS; vt++) { cplx fv = tget(v, sf, sS, bv, vt, sS2, tvn, vbn); if (fv == 0) continue; cplx ft = tget(t, 5, tT, ti, to, sS, vt, tv); acc += fb * fv * ft; } }
          int zo = (to * dB + bo) * NSC[co] + SOFF[co][sS2] + tvn * dS2 + vbn; M[i][(size_t)zi * nc[i + 1] + zo] = acc * fac; } } } } }
    /* Q = M1 M2 M3 (n1 x n0), then the diagonal of M0 Q split by the cut-0 side spin */
    cplx *X = calloc((size_t)nc[2] * nc[0], sizeof(cplx)), *Q = calloc((size_t)nc[1] * nc[0], sizeof(cplx));
    for (int r = 0; r < nc[2]; r++) for (int k = 0; k < nc[3]; k++) { cplx m = M[2][(size_t)r * nc[3] + k]; if (m == 0) continue; cplx *row = &M[3][(size_t)k * nc[0]], *out = &X[(size_t)r * nc[0]]; for (int c = 0; c < nc[0]; c++) out[c] += m * row[c]; }
    for (int r = 0; r < nc[1]; r++) for (int k = 0; k < nc[2]; k++) { cplx m = M[1][(size_t)r * nc[2] + k]; if (m == 0) continue; cplx *row = &X[(size_t)k * nc[0]], *out = &Q[(size_t)r * nc[0]]; for (int c = 0; c < nc[0]; c++) out[c] += m * row[c]; }
    double zr[16] = {0}, zi_[16] = {0};
    for (int ti = 0; ti < dT; ti++) for (int bi = 0; bi < dB; bi++) for (int sS = 0; sS <= CAP[1]; sS++) { int dS = DIM[sS]; for (int p = 0; p < dS; p++) for (int q = 0; q < dS; q++) {
      int z = (ti * dB + bi) * NSC[0] + SOFF[0][sS] + p * dS + q; cplx d = 0; for (int k = 0; k < nc[1]; k++) d += M[0][(size_t)z * nc[1] + k] * Q[(size_t)k * nc[0] + z]; zr[sS] += creal(d); zi_[sS] += cimag(d); } }
    for (int sS = 0; sS <= CAP[1]; sS++) { ZRES[tT][sS][tB] = zr[sS]; ZIM[tT][sS][tB] = zi_[sS]; }
    for (int i = 0; i < 4; i++) free(M[i]); free(X); free(Q); }
  double big = 0, worst = 0; for (int a = 0; a < 16; a++) for (int b = 0; b < 16; b++) for (int c = 0; c < 16; c++) { if (fabs(ZRES[a][b][c]) > big) big = fabs(ZRES[a][b][c]); if (fabs(ZIM[a][b][c]) > worst) worst = fabs(ZIM[a][b][c]); }
  RELIM = big > 0 ? worst / big : 0; if (RELIM > 1e-9) { fprintf(stderr, "the sector traces are not real: largest imaginary part %.3e of the largest sector %.3e\n", worst, big); exit(4); } }
static void fuse(int s, int a, int *ks, int *n) { *n = 0; for (int k = abs(s - a); k <= s + a; k += 2) ks[(*n)++] = k; }
/* moment: insT/insS/insB = the character index inserted at top/side0/bottom (-1 = none) */
static double moment(int insT, int insS, int insB) { double sum = 0; int kt[40], ks[40], kb[40], nt, ns, nb;
  for (int t = 0; t <= WMAX; t++) for (int s = 0; s <= WMAX; s++) for (int b = 0; b <= WMAX; b++) { double w = FAC[t] * FAC[s] * FAC[b]; if (w == 0) continue;
    if (insT >= 0) fuse(t, insT, kt, &nt); else { kt[0] = t; nt = 1; } if (insS >= 0) fuse(s, insS, ks, &ns); else { ks[0] = s; ns = 1; } if (insB >= 0) fuse(b, insB, kb, &nb); else { kb[0] = b; nb = 1; }
    for (int i = 0; i < nt; i++) { if (kt[i] > TMAX) { if (DROP) continue; fprintf(stderr, "top cap %d below %d\n", TMAX, kt[i]); exit(2); } for (int j = 0; j < ns; j++) { if (ks[j] > S0MAX) { if (DROP) continue; fprintf(stderr, "side0 cap %d below %d\n", S0MAX, ks[j]); exit(2); } for (int k = 0; k < nb; k++) { if (kb[k] > BMAX) { if (DROP) continue; fprintf(stderr, "bottom cap %d below %d\n", BMAX, kb[k]); exit(2); } sum += w * ZRES[kt[i]][ks[j]][kb[k]]; } } } }
  return sum; }
static quat *D0; static quat DATA[200];
static void compute_all(quat *dat) { for (int e = 0; e < 12; e++) linktensor(e, dat); ring_all(); }
/* the top face's truncated class law at characters k <= TMAX - WMAX, on a theta grid */
#define NQ 720
static void toplaw(double Z, double *p) { int K = TMAX - WMAX; double c[40]; for (int k = 0; k <= K; k++) c[k] = moment(k, -1, -1) / Z;
  for (int q = 0; q < NQ; q++) { double th = PI * (q + 0.5) / NQ, s = 0; for (int k = 0; k <= K; k++) s += c[k] * sin((k + 1) * th) / sin(th); p[q] = s * (2 / PI) * sin(th) * sin(th); } }
static double tvd(double *p, double *q) { double s = 0; for (int i = 0; i < NQ; i++) s += fabs(p[i] - q[i]); return 0.5 * s * PI / NQ; }
static double now(void) { return (double)clock() / CLOCKS_PER_SEC; }
int main(int argc, char **argv) {
  if (argc < 7) { fprintf(stderr, "usage: g41_cube beta MODE WMAX TMAX S0MAX BMAX [angles]\n"); return 1; }
  BETA = atof(argv[1]); const char *MODE = argv[2]; WMAX = atoi(argv[3]); TMAX = atoi(argv[4]); S0MAX = atoi(argv[5]); BMAX = atoi(argv[6]);
  SMAX = WMAX; if (TMAX > SMAX) SMAX = TMAX; if (S0MAX > SMAX) SMAX = S0MAX; if (BMAX > SMAX) SMAX = BMAX; if (SMAX > 15) { fprintf(stderr, "caps too large\n"); return 1; }
  FACT[0] = 1; for (int i = 1; i < 40; i++) FACT[i] = FACT[i - 1] * i;
  for (int s = 0; s <= 30; s++) { A[s] = bessel(s + 1, BETA) / bessel(1, BETA); DIM[s] = s + 1; FAC[s] = (s <= WMAX) ? (s + 1) * A[s] : 0; }
  /* representation KAT: choose the substitution that composes, traces = chi */
  { quat q1 = {0.5, 0.5, 0.5, 0.5}, q2 = {1 / sqrt(2), 0, 1 / sqrt(2), 0}, q3 = {0.6, 0, 0.8, 0}; quat q12 = qmul(q1, q2); int bad = 0; double worst = 0;
    for (int trial = 0; trial < 2; trial++) { GENINV = trial; double dmax = 0; for (int s = 1; s <= SMAX; s++) { int d = s + 1; cplx P[256], X1[256], X2[256], Y[256]; rep(s, q12, P); rep(s, q1, X1); rep(s, q2, X2);
        for (int i = 0; i < d; i++) for (int j = 0; j < d; j++) { cplx acc = 0; for (int k = 0; k < d; k++) acc += X1[i * d + k] * X2[k * d + j]; Y[i * d + j] = acc; double df = cabs(Y[i * d + j] - P[i * d + j]); if (df > dmax) dmax = df; } }
      if (dmax < 1e-12) break; if (trial == 1) bad++; worst = dmax; }
    for (int s = 0; s <= SMAX; s++) { int d = s + 1; cplx X[256]; rep(s, q3, X); cplx tr = 0; for (int i = 0; i < d; i++) tr += X[i * d + i]; if (fabs(creal(tr) - chi(s, q3)) > 1e-12 || fabs(cimag(tr)) > 1e-12) bad++; }
    printf("G41-KAT representations to spin %d/2 (GENINV=%d): homomorphism and traces [%s]\n", SMAX, GENINV, bad ? "FAILED" : "MET"); if (bad) return 1; (void)worst; }
  int deg = 0; /* the link integrand's degree: its two faces' caps + four staples x WMAX */
  build_cube(); for (int e = 0; e < 12; e++) { int d = CAP[SLOTF[e][0]] + CAP[SLOTF[e][1]] + 4 * WMAX; if (d > deg) deg = d; } if (deg < 12) deg = 12; make_rule(deg);
  { double cat = 1, wsum = 0; int bad = 0; for (int i = 0; i < NPT; i++) wsum += RW[i]; if (fabs(wsum - 1) > 1e-13) bad++;
    for (int k = 1; k <= deg / 2; k++) { cat = cat * 2 * (2 * k - 1) / (k + 1); double m = 0; for (int i = 0; i < NPT; i++) m += RW[i] * pow(RU[i].w, 2 * k); if (fabs(m - cat / pow(4, k)) > 1e-13 * (1 + cat / pow(4, k))) bad++; }
    printf("G41-KAT RULE%d (%d points): the even moments to degree %d [%s]\n", deg, NPT, 2 * (deg / 2), bad ? "FAILED" : "MET"); if (bad) return 1; }
  double minw = 1e9; for (int k = 0; k <= 4000; k++) { double th = PI * k / 4000; quat V = { cos(th), sin(th), 0, 0 }; double v = wgt(V); if (v < minw) minw = v; }
  printf("G41 beta=%g MODE=%s WMAX=%d caps top=%d side0=%d bottom=%d; a_1=%.6f a_2=%.6f; the truncated weight's minimum %.6f%s\n", BETA, MODE, WMAX, TMAX, S0MAX, BMAX, A[1], A[2], minw, minw > 0 ? "" : " NOT POSITIVE");
  if (minw <= 0) return 3;
  for (int i = 0; i < NOUT; i++) { quat one = {1, 0, 0, 0}; DATA[i] = one; }
  const char *datum = getenv("G41_DATUM"); if (!datum) datum = "ordered"; if (getenv("G41_DROP")) DROP = atoi(getenv("G41_DROP"));
  if (!strcmp(datum, "cancel")) { quat want[4] = { {1,0,0,0}, {-1,0,0,0}, {0,1,0,0}, {0,-1,0,0} }; int t0 = eidx("t0"); for (int k = 0; k < 4; k++) DATA[DANG[t0][k][1][0]] = qinv(want[k]); }
  else if (!strncmp(datum, "random:", 7)) { srand(atoi(datum + 7)); for (int i = 0; i < NOUT; i++) { double g[4], n = 0; for (int j = 0; j < 4; j++) { double u1 = (rand() + 1.0) / (RAND_MAX + 2.0), u2 = rand() / (RAND_MAX + 1.0); g[j] = sqrt(-2 * log(u1)) * cos(2 * PI * u2); n += g[j] * g[j]; } n = sqrt(n); quat q = { g[0] / n, g[1] / n, g[2] / n, g[3] / n }; DATA[i] = q; } }
  else if (strcmp(datum, "ordered")) { fprintf(stderr, "unknown datum %s\n", datum); return 1; }
  if (!strcmp(MODE, "keys")) { for (int i = 0; i < NOUT; i++) printf("G41-KEY %d %d,%d,%d,%d:%d\n", i, OUTB[i][0], OUTB[i][1], OUTB[i][2], OUTB[i][3], OUTD[i]); return 0; }
  double t0c = now();
  if (!strcmp(MODE, "kat")) { FREE = 1; compute_all(DATA); int bad = 0;
    for (int t = 0; t <= TMAX; t++) for (int s = 0; s <= S0MAX; s++) for (int b = 0; b <= BMAX; b++) { double v = ZRES[t][s][b], ex = (t == s && s == b && t <= WMAX) ? pow(FAC[t], 3) / pow(DIM[t], 4) : (t == s && s == b ? 0 : 0); if (fabs(v - ex) > 1e-10 * (1 + fabs(ex))) bad++; }
    double Z = moment(-1, -1, -1), Zc = 0, Z1 = 0, Z12 = 0; for (int j = 0; j <= WMAX; j++) { Zc += pow(FAC[j], 6) / pow(DIM[j], 4); double g = (j >= 1 ? FAC[j - 1] : 0) + (j + 1 <= WMAX ? FAC[j + 1] : 0); Z1 += g * pow(FAC[j], 5) / pow(DIM[j], 4); Z12 += g * g * pow(FAC[j], 4) / pow(DIM[j], 4); }
    double e1 = moment(1, -1, -1) / Z, e12s = moment(1, 1, -1) / Z, e12b = moment(1, -1, 1) / Z;
    if (fabs(Z - Zc) > 1e-10 * Zc || fabs(e1 - Z1 / Zc) > 1e-10 || fabs(e12s - Z12 / Zc) > 1e-10 || fabs(e12b - Z12 / Zc) > 1e-10) bad++;
    printf("G41-KAT the free cube: Z = %.12e (closed form %.12e); E[chi_1/2(top)] = %.12f (%.12f); E[chi chi] top-side0 %.12f top-bottom %.12f (%.12f) [%s] (%.1f s)\n", Z, Zc, e1, Z1 / Zc, e12s, e12b, Z12 / Zc, bad ? "FAILED" : "MET", now() - t0c); return bad ? 1 : 0; }
  compute_all(DATA); double Z = moment(-1, -1, -1); double eT = moment(1, -1, -1) / Z;
  printf("G41-BASE beta=%g WMAX=%d datum=%s%s Z = %.9e (sector traces real to %.1e); E[tr U_top] = E[chi_1/2(top)] = %.9f; E[tr U_side0] = %.9f; E[tr U_bottom] = %.9f (%.1f s)\n", BETA, WMAX, datum, DROP ? " (DROP past the caps)" : "", Z, RELIM, eT, S0MAX > WMAX ? moment(-1, 1, -1) / Z : -9.0, BMAX > WMAX ? moment(-1, -1, 1) / Z : -9.0, now() - t0c);   /* -9 = not read at these caps */
  if (!strcmp(MODE, "base")) { if (TMAX >= WMAX + 2 && S0MAX >= WMAX + 1 && BMAX >= WMAX + 1) { double eS = moment(-1, 1, -1) / Z, eB = moment(-1, -1, 1) / Z, eT1 = moment(2, -1, -1) / Z;
      printf("G41-PAIR beta=%g datum=%s ADJACENT <chi_1/2(top) chi_1/2(side0)>_c = %+.9f; <chi_1(top) chi_1/2(side0)>_c = %+.9f; OPPOSITE <chi_1/2(top) chi_1/2(bottom)>_c = %+.9f; <chi_1(top) chi_1/2(bottom)>_c = %+.9f; E[chi_1(top)] = %.9f\n", BETA, datum, moment(1, 1, -1) / Z - eT * eS, moment(2, 1, -1) / Z - eT1 * eS, moment(1, -1, 1) / Z - eT * eB, moment(2, -1, 1) / Z - eT1 * eB, eT1); }
    return 0; }
  if (!strcmp(MODE, "resp") || !strcmp(MODE, "worst")) {
    int nang = argc - 7; double ang[64]; for (int i = 0; i < nang && i < 64; i++) ang[i] = atof(argv[7 + i]); if (nang == 0) { nang = 12; for (int i = 0; i < 12; i++) ang[i] = 15 * (i + 1); }
    quat base[200]; memcpy(base, DATA, sizeof(quat) * NOUT); int links[200], nl = 0;
    if (!strcmp(MODE, "worst")) { int t0 = eidx("t0"); quat want[4] = { {1,0,0,0}, {-1,0,0,0}, {0,1,0,0}, {0,-1,0,0} }; for (int k = 0; k < 4; k++) base[DANG[t0][k][1][0]] = qinv(want[k]);
      int b1[4] = {1, 0, 1, 0}; links[nl++] = DANG[t0][0][1][0]; links[nl++] = okey(b1, 3); }
    else { const char *ls = getenv("G41_LINKS"); if (ls) { char buf[2000]; strncpy(buf, ls, 1999); buf[1999] = 0; for (char *tk = strtok(buf, " ,"); tk; tk = strtok(NULL, " ,")) links[nl++] = atoi(tk); } else { int u[4] = {0, 0, -1, 0}, up[4] = {0, 0, 1, 0}; links[nl++] = okey(u, 3); links[nl++] = okey(up, 3); } }
    compute_all(base); double Zb = moment(-1, -1, -1), eb = moment(1, -1, -1) / Zb; double pb[NQ]; toplaw(Zb, pb);
    printf("G41-RESP-BASE beta=%g WMAX=%d datum=%s%s E[tr U_top] = %.9f (%.1f s)\n", BETA, WMAX, datum, !strcmp(MODE, "worst") ? "+cancel(t0)" : "", eb, now() - t0c);
    for (int li = 0; li < nl; li++) { int lk = links[li]; double mx = 0, mt = 0, tvx = 0, tvt = 0;
      for (int ai = 0; ai < nang; ai++) { double a = ang[ai] * PI / 180; quat g = { cos(a), sin(a), 0, 0 }; quat dd[200]; memcpy(dd, base, sizeof(quat) * NOUT); dd[lk] = qmul(g, base[lk]);
        compute_all(dd); double Zd = moment(-1, -1, -1), ed = moment(1, -1, -1) / Zd; double pd[NQ]; toplaw(Zd, pd); double tv = tvd(pd, pb);
        printf("G41-RESP-STEP link=%d (%d,%d,%d,%d:%d) angle=%g dE=%+.9f TV=%.9f (%.1f s)\n", lk, OUTB[lk][0], OUTB[lk][1], OUTB[lk][2], OUTB[lk][3], OUTD[lk], ang[ai], ed - eb, tv, now() - t0c); fflush(stdout);
        if (fabs(ed - eb) > mx) { mx = fabs(ed - eb); mt = ang[ai]; } if (tv > tvx) { tvx = tv; tvt = ang[ai]; } }
      printf("G41-RESP beta=%g WMAX=%d link=%d (%d,%d,%d,%d:%d): sup |dE[tr U_top]| = %.9f at %g deg; sup TV of the top face's truncated law = %.9f at %g deg (%.1f s)\n", BETA, WMAX, lk, OUTB[lk][0], OUTB[lk][1], OUTB[lk][2], OUTB[lk][3], OUTD[lk], mx, mt, tvx, tvt, now() - t0c); fflush(stdout); }
    return 0; }
  fprintf(stderr, "unknown mode %s\n", MODE); return 1; }
