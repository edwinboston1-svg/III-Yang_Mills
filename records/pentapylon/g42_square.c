/* g42_square.c -- THE SU(2) 2x2 SQUARE'S RING IN C (ΠΕΝΤΑΠΥΛΟΝ G42, 2026-10-29 07:3x EDT, the desktop seat): a line-for-line port of g34_su2_square.pl
 * (the twelve links of the 2x2 planar square in the xy-plane of Z^4, four faces in a ring around the centre, the big loop W(2,2) resolved and carried
 * round the ring, face 0 resolved for the plaquette; every plaquette weight w(V) = sum_{s <= WMAX} (s+1) a_s chi_{s/2}(V); 104 outside links in g34's
 * okey order).  The representations, the rule and the link tensors are g41's (validated on the cube).  A datum can be READ from a file of 104
 * quaternions (one per line, g34's outside-link order), so the perl and C instruments are compared on identical data.
 * MODES: kat (the free square: ZRES[l][l] = f_l^3/(2l+1)^3, Z = 1, E[chi_1/2(W)] = 2a_1^4, E[chi_1/2(P_0)] = 2a_1), base (Z, W(1,1), W(2,2), the loop's
 * characters, beta_eff(2a) by the one-plaquette law), near (a near-ordered datum eps x a fixed direction read from G42_DIRFILE, scanned over eps),
 * hess (the second-order coefficient of W(2,2) along each of NDIR random directions).  usage: g42_square beta MODE WMAX LMAX S0MAX [args]
 * env G42_DATAFILE=path (the datum)   build: gcc -O2 -fopenmp -o g42_square.exe g42_square.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
#include <time.h>
typedef double complex cplx;
#define PI 3.141592653589793
static double BETA; static int WMAX, LMAX, S0MAX, SMAX;
static double A[40], FAC[40]; static int DIM[40]; static double FACT[40];
typedef struct { double w, x, y, z; } quat;
static quat qmul(quat a, quat b) { quat r; r.w = a.w*b.w - a.x*b.x - a.y*b.y - a.z*b.z; r.x = a.w*b.x + a.x*b.w + a.y*b.z - a.z*b.y; r.y = a.w*b.y - a.x*b.z + a.y*b.w + a.z*b.x; r.z = a.w*b.z + a.x*b.y - a.y*b.x + a.z*b.w; return r; }
static quat qinv(quat a) { quat r = { a.w, -a.x, -a.y, -a.z }; return r; }
static double bessel(int n, double x) { double s = 0, t = pow(x / 2, n), f = 1; for (int i = 1; i <= n; i++) f *= i; t /= f; for (int k = 0; k < 400; k++) { s += t; t *= (x / 2) * (x / 2) / ((k + 1.0) * (k + 1.0 + n)); if (t < 1e-19 * s) break; } return s; }
static double chi(int s, quat q) { double w = q.w, u0 = 1, u1 = 2 * w; if (s == 0) return u0; for (int k = 2; k <= s; k++) { double u2 = 2 * w * u1 - u0; u0 = u1; u1 = u2; } return u1; }
static double wgt(quat V) { double s = 1; for (int k = 1; k <= WMAX; k++) s += (k + 1) * A[k] * chi(k, V); return s; }
static int GENINV = 0;
static void Dsub(int s, quat q, cplx *D) { cplx a = q.w + I * q.x, b = q.y + I * q.z, ab = q.w - I * q.x, nbb = -q.y + I * q.z; cplx poly[40], np[40];
  for (int qq = 0; qq <= s; qq++) { int len = 1; poly[0] = 1;
    for (int r = 0; r < qq; r++) { for (int k = 0; k <= len; k++) np[k] = 0; for (int k = 0; k < len; k++) { np[k + 1] += poly[k] * a; np[k] += poly[k] * b; } len++; for (int k = 0; k < len; k++) poly[k] = np[k]; }
    for (int r = 0; r < s - qq; r++) { for (int k = 0; k <= len; k++) np[k] = 0; for (int k = 0; k < len; k++) { np[k + 1] += poly[k] * nbb; np[k] += poly[k] * ab; } len++; for (int k = 0; k < len; k++) poly[k] = np[k]; }
    for (int p = 0; p <= s; p++) { double sc = sqrt(FACT[p] * FACT[s - p] / (FACT[qq] * FACT[s - qq])); D[p * (s + 1) + qq] = poly[p] * sc; } } }
static void rep(int s, quat q, cplx *D) { if (s == 0) { D[0] = 1; return; } Dsub(s, GENINV ? qinv(q) : q, D); }
static int NPT; static quat *RU; static double *RW;
static void gauss_legendre(int n, double *x, double *w) { for (int i = 1; i <= n; i++) { double z = cos(PI * (i - 0.25) / (n + 0.5)), dp = 0;
    for (int it = 0; it < 200; it++) { double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2 * k - 1) * z * p1 - (k - 1) * p0) / k; p0 = p1; p1 = p2; } dp = n * (z * p1 - p0) / (z * z - 1); double dx = p1 / dp; z -= dx; if (fabs(dx) < 1e-16) break; }
    double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2 * k - 1) * z * p1 - (k - 1) * p0) / k; p0 = p1; p1 = p2; } dp = n * (z * p1 - p0) / (z * z - 1); x[i - 1] = z; w[i - 1] = 2 / ((1 - z * z) * dp * dp); } }
static void make_rule(int deg) { int nth = (deg + 2) / 2, ngl = (deg + 2) / 2, naz = deg + 1; double gx[200], gw[200]; gauss_legendre(ngl, gx, gw);
  NPT = nth * ngl * naz; RU = malloc(sizeof(quat) * NPT); RW = malloc(sizeof(double) * NPT); int n = 0;
  for (int k = 1; k <= nth; k++) { double th = k * PI / (nth + 1), wt = 2 * sin(th) * sin(th) / (nth + 1);
    for (int j = 0; j < ngl; j++) { double t = gx[j], st = sqrt(1 - t * t);
      for (int l = 0; l < naz; l++) { double ph = 2 * PI * l / naz; quat u = { cos(th), sin(th) * st * cos(ph), sin(th) * st * sin(ph), sin(th) * t }; RU[n] = u; RW[n] = wt * gw[j] / 2 / naz; n++; } } } }
/* ---- the square: edges in perl's sort order of the names X00 X01 X02 X10 X11 X12 Y00 Y01 Y10 Y11 Y20 Y21; X(x,y): (x,y)->(x+1,y); Y(x,y): (x,y)->(x,y+1) */
static const char *ENAME[12] = { "X00", "X01", "X02", "X10", "X11", "X12", "Y00", "Y01", "Y10", "Y11", "Y20", "Y21" };
static int EB[12][4], ED[12];
static int eidx(const char *n) { for (int i = 0; i < 12; i++) if (!strcmp(ENAME[i], n)) return i; fprintf(stderr, "no edge %s\n", n); exit(1); }
static int FACE[4][4], FSG[4][4]; static int SPOKE[4]; static int LOOPE[8], LOOPS[8];
static int NOUT = 0; static int OUTB[200][4], OUTD[200];
static int okey(int *b, int d) { for (int i = 0; i < NOUT; i++) if (OUTD[i] == d && !memcmp(OUTB[i], b, sizeof(int) * 4)) return i; memcpy(OUTB[NOUT], b, sizeof(int) * 4); OUTD[NOUT] = d; return NOUT++; }
static int NDANG[12], DANG[12][6][3][2];
static int SLOTF[12][2], SLOTM[12][2], SLOTS[12][2];   /* face index 0..3, or 4 = the loop */
static int CAP[5]; static int PREVPOS[4], NEXTPOS[4], LSEQ[4][2];
static void face(int x, int y, int *e, int *s) { char n[8]; sprintf(n, "X%d%d", x, y); e[0] = eidx(n); s[0] = 1; sprintf(n, "Y%d%d", x + 1, y); e[1] = eidx(n); s[1] = 1; sprintf(n, "X%d%d", x, y + 1); e[2] = eidx(n); s[2] = -1; sprintf(n, "Y%d%d", x, y); e[3] = eidx(n); s[3] = -1; }
static void build_square(void) {
  for (int i = 0; i < 12; i++) { int x = ENAME[i][1] - '0', y = ENAME[i][2] - '0'; EB[i][0] = x; EB[i][1] = y; EB[i][2] = 0; EB[i][3] = 0; ED[i] = (ENAME[i][0] == 'X') ? 1 : 2; }
  int fx[4] = {0, 1, 1, 0}, fy[4] = {0, 0, 1, 1}; for (int i = 0; i < 4; i++) face(fx[i], fy[i], FACE[i], FSG[i]);
  SPOKE[0] = eidx("Y10"); SPOKE[1] = eidx("X11"); SPOKE[2] = eidx("Y11"); SPOKE[3] = eidx("X01");
  const char *ln[8] = { "X00", "X10", "Y20", "Y21", "X12", "X02", "Y01", "Y00" }; int ls[8] = { 1, 1, 1, 1, -1, -1, -1, -1 }; for (int m = 0; m < 8; m++) { LOOPE[m] = eidx(ln[m]); LOOPS[m] = ls[m]; }
  int cnt[12] = {0}; for (int i = 0; i < 4; i++) for (int m = 0; m < 4; m++) { int e = FACE[i][m]; SLOTF[e][cnt[e]] = i; SLOTM[e][cnt[e]] = m; SLOTS[e][cnt[e]] = FSG[i][m]; cnt[e]++; }
  for (int m = 0; m < 8; m++) { int e = LOOPE[m]; SLOTF[e][cnt[e]] = 4; SLOTM[e][cnt[e]] = m; SLOTS[e][cnt[e]] = LOOPS[m]; cnt[e]++; }
  for (int e = 0; e < 12; e++) if (cnt[e] != 2) { fprintf(stderr, "edge %s has %d slots\n", ENAME[e], cnt[e]); exit(1); }
  for (int i = 0; i < 4; i++) { int prev = SPOKE[(i + 3) % 4], next = SPOKE[i]; for (int m = 0; m < 4; m++) { if (FACE[i][m] == prev) PREVPOS[i] = m; if (FACE[i][m] == next) NEXTPOS[i] = m; }
    int outer[2], no = 0; for (int m = 0; m < 4; m++) { int e = FACE[i][m]; if (e != prev && e != next) outer[no++] = e; } int lp[2]; for (int k = 0; k < 2; k++) for (int m = 0; m < 8; m++) if (LOOPE[m] == outer[k]) lp[k] = m;
    if (lp[0] > lp[1]) { int t = outer[0]; outer[0] = outer[1]; outer[1] = t; t = lp[0]; lp[0] = lp[1]; lp[1] = t; } if (lp[0] == 0 && lp[1] == 7) { int t = outer[0]; outer[0] = outer[1]; outer[1] = t; }
    LSEQ[i][0] = outer[0]; LSEQ[i][1] = outer[1]; }
  /* the staples in g34's okey order: edges in sorted order, k = 1..4 (k != d); sides: k >= 3: (1, -1); in-plane: the outer side only (c = 0: -1; c = 2: +1) */
  for (int e = 0; e < 12; e++) { int *p = EB[e], d = ED[e]; int pd[4]; memcpy(pd, p, sizeof pd); pd[d - 1] += 1; int ns = 0;
    for (int k = 1; k <= 4; k++) { if (k == d) continue; int sides[2], nsd = 0; if (k >= 3) { sides[0] = 1; sides[1] = -1; nsd = 2; } else { int c = p[k - 1]; if (c == 0) { sides[0] = -1; nsd = 1; } else if (c == 2) { sides[0] = 1; nsd = 1; } }
      for (int si = 0; si < nsd; si++) { int s = sides[si]; int q[4];
        if (s > 0) { DANG[e][ns][0][0] = okey(pd, k); DANG[e][ns][0][1] = 1; } else { memcpy(q, pd, sizeof q); q[k - 1] -= 1; DANG[e][ns][0][0] = okey(q, k); DANG[e][ns][0][1] = -1; }
        memcpy(q, p, sizeof q); q[k - 1] += s; DANG[e][ns][1][0] = okey(q, d); DANG[e][ns][1][1] = -1;
        if (s > 0) { DANG[e][ns][2][0] = okey(p, k); DANG[e][ns][2][1] = -1; } else { memcpy(q, p, sizeof q); q[k - 1] -= 1; DANG[e][ns][2][0] = okey(q, k); DANG[e][ns][2][1] = 1; }
        ns++; } }
    NDANG[e] = ns; }
  if (NOUT != 104) { fprintf(stderr, "outside links: %d, not 104\n", NOUT); exit(1); }
  CAP[0] = S0MAX; CAP[1] = CAP[2] = CAP[3] = WMAX; CAP[4] = LMAX; }
static quat staple(int e, int k, quat *dat) { quat T = { 1, 0, 0, 0 }; for (int j = 0; j < 3; j++) { quat V = dat[DANG[e][k][j][0]]; if (DANG[e][k][j][1] < 0) V = qinv(V); T = qmul(T, V); } return T; }
static int FREE = 0;
typedef struct { cplx *blk[16][16]; } ltens; static ltens LT[12];
static void linktensor(int e, quat *dat) { int f1 = SLOTF[e][0], f2 = SLOTF[e][1]; int c1 = CAP[f1], c2 = CAP[f2]; int sg1 = SLOTS[e][0], sg2 = SLOTS[e][1];
  quat T[6]; int nt = FREE ? 0 : NDANG[e]; for (int k = 0; k < nt; k++) T[k] = staple(e, k, dat);
  for (int s1 = 0; s1 <= c1; s1++) for (int s2 = 0; s2 <= c2; s2++) { int d1 = DIM[s1], d2 = DIM[s2]; if (LT[e].blk[s1][s2]) free(LT[e].blk[s1][s2]); LT[e].blk[s1][s2] = calloc((size_t)d1 * d1 * d2 * d2, sizeof(cplx)); }
  #pragma omp parallel
  { cplx R1[16][256], R2[16][256]; cplx *loc[16][16]; for (int s1 = 0; s1 <= c1; s1++) for (int s2 = 0; s2 <= c2; s2++) loc[s1][s2] = calloc((size_t)DIM[s1] * DIM[s1] * DIM[s2] * DIM[s2], sizeof(cplx));
    #pragma omp for schedule(static)
    for (int pt = 0; pt < NPT; pt++) { quat U = RU[pt]; double w = RW[pt]; for (int k = 0; k < nt; k++) w *= wgt(qmul(U, T[k]));
      quat U1 = sg1 > 0 ? U : qinv(U), U2 = sg2 > 0 ? U : qinv(U); for (int s = 0; s <= c1; s++) rep(s, U1, R1[s]); for (int s = 0; s <= c2; s++) rep(s, U2, R2[s]);
      for (int s1 = 0; s1 <= c1; s1++) { int d1 = DIM[s1]; for (int s2 = 0; s2 <= c2; s2++) { int d2 = DIM[s2]; cplx *B = loc[s1][s2];
        for (int ab = 0; ab < d1 * d1; ab++) { cplx fa = R1[s1][ab] * w; for (int cd = 0; cd < d2 * d2; cd++) B[ab * d2 * d2 + cd] += fa * R2[s2][cd]; } } } }
    #pragma omp critical
    { for (int s1 = 0; s1 <= c1; s1++) for (int s2 = 0; s2 <= c2; s2++) { size_t n = (size_t)DIM[s1] * DIM[s1] * DIM[s2] * DIM[s2]; for (size_t i = 0; i < n; i++) LT[e].blk[s1][s2][i] += loc[s1][s2][i]; free(loc[s1][s2]); } } } }
static inline cplx tget(int e, int fA, int sA, int iA, int oA, int sB, int iB, int oB) {
  if (SLOTF[e][0] == fA) { int d1 = DIM[sA], d2 = DIM[sB]; return LT[e].blk[sA][sB][((iA * d1 + oA) * d2 + iB) * d2 + oB]; }
  else { int d1 = DIM[sB], d2 = DIM[sA]; return LT[e].blk[sB][sA][((iB * d1 + oB) * d2 + iA) * d2 + oA]; } }
/* ---- the ring: sector = the loop spin l; cut c (0..3) carries face_c's spin s <= CAP[c] and the pair (p, q); state = (li NS(c) + soff + p d + q) */
static int NSC[4], SOFF[4][16]; static double ZRES[16][16], ZIM[16][16], RELIM;
static void ring_all(void) {
  for (int c = 0; c < 4; c++) { int n = 0; for (int s = 0; s <= CAP[c]; s++) { SOFF[c][s] = n; n += DIM[s] * DIM[s]; } NSC[c] = n; }
  memset(ZRES, 0, sizeof ZRES); memset(ZIM, 0, sizeof ZIM);
  for (int l = 0; l <= LMAX; l++) { int dl = DIM[l]; int nc[5]; for (int c = 0; c < 4; c++) nc[c] = dl * NSC[c]; nc[4] = nc[0];
    cplx *M[4]; for (int i = 0; i < 4; i++) M[i] = calloc((size_t)nc[i] * nc[i + 1], sizeof(cplx));
    for (int i = 0; i < 4; i++) { int fa = i, fb = (i + 1) % 4; int cin = CAP[fa], cout = CAP[fb]; int kp = PREVPOS[i], kn = NEXTPOS[i]; int fr[2], nf = 0; for (int m = 0; m < 4; m++) if (m != kp && m != (kp + 1) % 4) fr[nf++] = m;
      int o1 = LSEQ[i][0], o2 = LSEQ[i][1]; int m1 = -1, m2 = -1; for (int m = 0; m < 4; m++) { if (FACE[i][m] == o1) m1 = m; if (FACE[i][m] == o2) m2 = m; } int nxt = SPOKE[i];
      #pragma omp parallel for collapse(2) schedule(dynamic)
      for (int li = 0; li < dl; li++) for (int s = 0; s <= cin; s++) { int ds = DIM[s]; double fac = (i == 0) ? 1 : FAC[s];
        for (int p = 0; p < ds; p++) for (int q = 0; q < ds; q++) { int zi = li * NSC[i] + SOFF[i][s] + p * ds + q;
          for (int lo = 0; lo < dl; lo++) for (int s2 = 0; s2 <= cout; s2++) { int ds2 = DIM[s2]; for (int p2 = 0; p2 < ds2; p2++) for (int q2 = 0; q2 < ds2; q2++) {
            cplx acc = 0; int v[4];
            for (int va = 0; va < ds; va++) for (int vb = 0; vb < ds; vb++) { v[kp] = p; v[(kp + 1) % 4] = q; v[fr[0]] = va; v[fr[1]] = vb;
              cplx fn = tget(nxt, fa, s, v[kn], v[(kn + 1) % 4], s2, p2, q2); if (fn == 0) continue;
              for (int lm = 0; lm < dl; lm++) { cplx f1 = tget(o1, fa, s, v[m1], v[(m1 + 1) % 4], l, li, lm); if (f1 == 0) continue; cplx f2 = tget(o2, fa, s, v[m2], v[(m2 + 1) % 4], l, lm, lo); acc += f1 * f2 * fn; } }
            int zo = lo * NSC[(i + 1) % 4] + SOFF[(i + 1) % 4][s2] + p2 * ds2 + q2; M[i][(size_t)zi * nc[i + 1] + zo] = acc * fac; } } } } }
    cplx *X = calloc((size_t)nc[2] * nc[0], sizeof(cplx)), *Q = calloc((size_t)nc[1] * nc[0], sizeof(cplx));
    for (int r = 0; r < nc[2]; r++) for (int k = 0; k < nc[3]; k++) { cplx m = M[2][(size_t)r * nc[3] + k]; if (m == 0) continue; for (int c = 0; c < nc[0]; c++) X[(size_t)r * nc[0] + c] += m * M[3][(size_t)k * nc[0] + c]; }
    for (int r = 0; r < nc[1]; r++) for (int k = 0; k < nc[2]; k++) { cplx m = M[1][(size_t)r * nc[2] + k]; if (m == 0) continue; for (int c = 0; c < nc[0]; c++) Q[(size_t)r * nc[0] + c] += m * X[(size_t)k * nc[0] + c]; }
    for (int li = 0; li < dl; li++) for (int s = 0; s <= CAP[0]; s++) { int ds = DIM[s]; for (int p = 0; p < ds; p++) for (int q = 0; q < ds; q++) { int z = li * NSC[0] + SOFF[0][s] + p * ds + q; cplx d = 0; for (int k = 0; k < nc[1]; k++) d += M[0][(size_t)z * nc[1] + k] * Q[(size_t)k * nc[0] + z]; ZRES[l][s] += creal(d); ZIM[l][s] += cimag(d); } }
    for (int i = 0; i < 4; i++) free(M[i]); free(X); free(Q); }
  double big = 0, worst = 0; for (int a = 0; a < 16; a++) for (int b = 0; b < 16; b++) { if (fabs(ZRES[a][b]) > big) big = fabs(ZRES[a][b]); if (fabs(ZIM[a][b]) > worst) worst = fabs(ZIM[a][b]); }
  RELIM = big > 0 ? worst / big : 0; if (RELIM > 1e-9) { fprintf(stderr, "sector traces not real: %.3e of %.3e\n", worst, big); exit(4); } }
static double Zof(void) { double z = 0; for (int s = 0; s <= WMAX; s++) z += FAC[s] * ZRES[0][s]; return z; }
static double Eloop(int a) { double z = 0; for (int s = 0; s <= WMAX; s++) z += FAC[s] * ZRES[a][s]; return z / Zof(); }
static double Eplaq(int a) { double z = 0; for (int s = 0; s <= WMAX; s++) for (int k = abs(s - a); k <= s + a; k += 2) { if (k > S0MAX) { fprintf(stderr, "face0 cap %d below %d\n", S0MAX, k); exit(2); } z += FAC[s] * ZRES[0][k]; } return z / Zof(); }
static double beff(double w) { if (w <= 0) return 0; double lo = 0, hi = 60; for (int it = 0; it < 200; it++) { double mid = (lo + hi) / 2; if (bessel(2, mid) / bessel(1, mid) < w) lo = mid; else hi = mid; } return (lo + hi) / 2; }
static quat DATA[200];
static void compute(quat *dat) { for (int e = 0; e < 12; e++) linktensor(e, dat); ring_all(); }
static double now(void) { return (double)clock() / CLOCKS_PER_SEC; }
static int readquats(const char *path, quat *out, int n) { FILE *f = fopen(path, "r"); if (!f) { fprintf(stderr, "cannot read %s\n", path); exit(1); } for (int i = 0; i < n; i++) { if (fscanf(f, "%lf %lf %lf %lf", &out[i].w, &out[i].x, &out[i].y, &out[i].z) != 4) { fprintf(stderr, "%s: %d quaternions, not %d\n", path, i, n); exit(1); } } fclose(f); return n; }
int main(int argc, char **argv) {
  if (argc < 6) { fprintf(stderr, "usage: g42_square beta MODE WMAX LMAX S0MAX [args]\n"); return 1; }
  BETA = atof(argv[1]); const char *MODE = argv[2]; WMAX = atoi(argv[3]); LMAX = atoi(argv[4]); S0MAX = atoi(argv[5]);
  SMAX = WMAX; if (LMAX > SMAX) SMAX = LMAX; if (S0MAX > SMAX) SMAX = S0MAX; if (SMAX > 15) return 1; if (S0MAX <= WMAX) { fprintf(stderr, "face0 cap must exceed WMAX\n"); return 1; }
  FACT[0] = 1; for (int i = 1; i < 40; i++) FACT[i] = FACT[i - 1] * i;
  for (int s = 0; s < 40; s++) { A[s] = bessel(s + 1, BETA) / bessel(1, BETA); DIM[s] = s + 1; FAC[s] = (s <= WMAX) ? (s + 1) * A[s] : 0; }
  { quat q1 = {0.5, 0.5, 0.5, 0.5}, q2 = {1 / sqrt(2), 0, 1 / sqrt(2), 0}, q3 = {0.6, 0, 0.8, 0}; quat q12 = qmul(q1, q2); int bad = 0;
    for (int trial = 0; trial < 2; trial++) { GENINV = trial; double dmax = 0; for (int s = 1; s <= SMAX; s++) { int d = s + 1; cplx P[256], X1[256], X2[256]; rep(s, q12, P); rep(s, q1, X1); rep(s, q2, X2);
        for (int i = 0; i < d; i++) for (int j = 0; j < d; j++) { cplx acc = 0; for (int k = 0; k < d; k++) acc += X1[i * d + k] * X2[k * d + j]; double df = cabs(acc - P[i * d + j]); if (df > dmax) dmax = df; } } if (dmax < 1e-12) break; if (trial == 1) bad++; }
    for (int s = 0; s <= SMAX; s++) { int d = s + 1; cplx X[256]; rep(s, q3, X); cplx tr = 0; for (int i = 0; i < d; i++) tr += X[i * d + i]; if (fabs(creal(tr) - chi(s, q3)) > 1e-12 || fabs(cimag(tr)) > 1e-12) bad++; }
    printf("G42-KAT representations to spin %d/2 (GENINV=%d) [%s]\n", SMAX, GENINV, bad ? "FAILED" : "MET"); if (bad) return 1; }
  build_square(); int deg = 0; for (int e = 0; e < 12; e++) { int d = CAP[SLOTF[e][0]] + CAP[SLOTF[e][1]] + NDANG[e] * WMAX; if (d > deg) deg = d; } if (deg < 12) deg = 12; make_rule(deg);
  { double cat = 1, wsum = 0; int bad = 0; for (int i = 0; i < NPT; i++) wsum += RW[i]; if (fabs(wsum - 1) > 1e-13) bad++; for (int k = 1; k <= deg / 2; k++) { cat = cat * 2 * (2 * k - 1) / (k + 1); double m = 0; for (int i = 0; i < NPT; i++) m += RW[i] * pow(RU[i].w, 2 * k); if (fabs(m - cat / pow(4, k)) > 1e-13 * (1 + cat / pow(4, k))) bad++; }
    printf("G42-KAT RULE%d (%d points) [%s]\n", deg, NPT, bad ? "FAILED" : "MET"); if (bad) return 1; }
  double minw = 1e9; for (int k = 0; k <= 4000; k++) { double th = PI * k / 4000; quat V = { cos(th), sin(th), 0, 0 }; double v = wgt(V); if (v < minw) minw = v; }
  printf("G42 beta=%g MODE=%s WMAX=%d caps loop=%d face0=%d; a_1=%.6f a_2=%.6f; the truncated weight's minimum %.6f%s\n", BETA, MODE, WMAX, LMAX, S0MAX, A[1], A[2], minw, minw > 0 ? "" : " NOT POSITIVE"); if (minw <= 0) return 3;
  for (int i = 0; i < NOUT; i++) { quat one = {1, 0, 0, 0}; DATA[i] = one; }
  const char *df = getenv("G42_DATAFILE"); if (df) readquats(df, DATA, NOUT);
  double t0 = now();
  if (!strcmp(MODE, "kat")) { FREE = 1; compute(DATA); FREE = 0; int bad = 0; for (int l = 0; l <= LMAX; l++) for (int s = 0; s <= S0MAX; s++) { double ex = (l == s && l <= WMAX) ? pow(FAC[l], 3) / pow(DIM[l], 3) : 0; if (fabs(ZRES[l][s] - ex) > 1e-10 * (1 + ex)) bad++; }
    double Z = Zof(), ew = Eloop(1), ep = Eplaq(1); if (fabs(Z - 1) > 1e-10 || fabs(ew - 2 * pow(A[1], 4)) > 1e-10 || fabs(ep - 2 * A[1]) > 1e-10) bad++;
    printf("G42-KAT the free square: Z = %.12f (1); E[chi_1/2(W(2,2))] = %.12f (2a_1^4 = %.12f); E[chi_1/2(P_0)] = %.12f (2a_1 = %.12f) [%s] (%.1f s)\n", Z, ew, 2 * pow(A[1], 4), ep, 2 * A[1], bad ? "FAILED" : "MET", now() - t0); return bad; }
  if (!strcmp(MODE, "base")) { compute(DATA); double Z = Zof(), w11 = Eplaq(1) / 2, w22 = Eloop(1) / 2;
    printf("G42-BASE beta=%g WMAX=%d datum=%s Z = %.9e (sector traces real to %.1e); W(1,1) = %.9f; W(2,2) = %.9f; the loop's characters", BETA, WMAX, df ? df : "ordered", Z, RELIM, w11, w22); for (int a = 0; a <= LMAX; a++) printf("%s%.6f", a ? "," : " ", Eloop(a)); printf("; beta_eff(2a) = %.6f (ratio %.4f) (%.1f s)\n", beff(w22), beff(w22) / BETA, now() - t0); return 0; }
  if (!strcmp(MODE, "near")) { /* direction file: 104 lines of su(2) vectors (x, y, z); the datum exp(eps n) per link; eps from argv */
    const char *dirf = getenv("G42_DIRFILE"); if (!dirf) { fprintf(stderr, "G42_DIRFILE needed\n"); return 1; } FILE *f = fopen(dirf, "r"); double nv[200][3]; for (int i = 0; i < NOUT; i++) if (fscanf(f, "%lf %lf %lf", &nv[i][0], &nv[i][1], &nv[i][2]) != 3) { fprintf(stderr, "direction file short\n"); return 1; } fclose(f);
    compute(DATA); double w11o = Eplaq(1) / 2, w22o = Eloop(1) / 2; printf("G42-NEAR beta=%g WMAX=%d ordered W(1,1) = %.12f W(2,2) = %.12f\n", BETA, WMAX, w11o, w22o);
    for (int ai = 6; ai < argc; ai++) { double eps = atof(argv[ai]); quat dd[200]; for (int i = 0; i < NOUT; i++) { double r = sqrt(nv[i][0] * nv[i][0] + nv[i][1] * nv[i][1] + nv[i][2] * nv[i][2]); double a = eps * r; quat q = { cos(a), r > 0 ? sin(a) * nv[i][0] / r : 0, r > 0 ? sin(a) * nv[i][1] / r : 0, r > 0 ? sin(a) * nv[i][2] / r : 0 }; dd[i] = q; }
      compute(dd); double w11 = Eplaq(1) / 2, w22 = Eloop(1) / 2; printf("G42-NEAR eps=%g dW(1,1) = %+.6e (/eps^2 %+.6f) dW(2,2) = %+.6e (/eps^2 %+.6f) (sector traces real to %.1e) (%.1f s)\n", eps, w11 - w11o, (w11 - w11o) / (eps * eps), w22 - w22o, (w22 - w22o) / (eps * eps), RELIM, now() - t0); fflush(stdout); }
    return 0; }
  fprintf(stderr, "unknown mode %s\n", MODE); return 1; }
