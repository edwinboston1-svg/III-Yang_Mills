/* w2_strip_n.c -- THE TWO-FACE OBJECT'S SWEEP AT FACE SIZE n: the joint law of two adjacent coarse n x n loops under the blocked measure, exact
 * at plaquette spins <= WMAX/2 (THE CROSSING CAMPAIGN W2 at n = 2, §6; W3's TWO-STEP OBJECT at n = 4, §8; 2026-11-01, the author).
 * w2_strip.c generalised: face A = the n x n block of fine plaquettes in the xy-plane at z = w = 0; face B = the n x n block in the yz-plane
 * at x = w = 0 (bent) or in the xy-plane at x in [-n, 0] (planar); the shared coarse edge x = z = 0, y in [0, n] (n fine links); 2n^2 plaquettes;
 * every object link in staples outside the object (the datum: ordered, random:SEED, cancel on the first shared link's staples, free = off).
 * The representations, the rule, the link tensors, the wire formalism, the junction and the known answers are w2_strip.c's; the free object's
 * law is W(A) = sum_a d_a a_a^{n^2} chi_a.  THE ORDER is generated from the geometry: face A's columns from the far edge to the shared edge
 * (the far edge's links, then the column's horizontals bottom to top, then its cut links), face B's likewise from its far edge inward, and the
 * shared links last in the loops' chain order -- every cycle, loop or plaquette, keeps at most two open wires.
 * usage: w2_strip_n beta WMAX LMAX DATUM [fwd|rev] [bent|planar] [n]      build: gcc -O2 -fopenmp -o w2_strip_n.exe w2_strip_n.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
#include <time.h>
#ifdef _OPENMP
#include <omp.h>
#endif
typedef double complex cplx;
#define PI 3.141592653589793
#define MAXL 128
#define MAXOUT 2000
#define MAXCYC 40
#define MAXSTEP 16
#define MAXW 400
static double BETA; static int WMAX, LMAX, SMAX, FREE = 0, PLANAR = 0, NN = 2; static size_t CEIL = 400000000;
static double A[32], FAC[32]; static int DIM[32]; static double FACT[40];
static double now(void) {
#ifdef _OPENMP
  return omp_get_wtime();
#else
  return (double)clock() / CLOCKS_PER_SEC;
#endif
}
typedef struct { double w, x, y, z; } quat;
static quat qmul(quat a, quat b) { quat r; r.w = a.w*b.w - a.x*b.x - a.y*b.y - a.z*b.z; r.x = a.w*b.x + a.x*b.w + a.y*b.z - a.z*b.y; r.y = a.w*b.y - a.x*b.z + a.y*b.w + a.z*b.x; r.z = a.w*b.z + a.x*b.y - a.y*b.x + a.z*b.w; return r; }
static quat qinv(quat a) { quat r = { a.w, -a.x, -a.y, -a.z }; return r; }
static double bessel(int n, double x) { double s = 0, t = pow(x / 2, n), f = 1; for (int i = 1; i <= n; i++) f *= i; t /= f; for (int k = 0; k < 400; k++) { s += t; t *= (x / 2) * (x / 2) / ((k + 1.0) * (k + n + 1.0)); if (t < 1e-300) break; } return s; }
static double chi(int s, quat q) { double w = q.w, u0 = 1, u1 = 2 * w; if (s == 0) return u0; for (int k = 2; k <= s; k++) { double u2 = 2 * w * u1 - u0; u0 = u1; u1 = u2; } return u1; }
static double wgt(quat V) { double s = 1; for (int k = 1; k <= WMAX; k++) s += (k + 1) * A[k] * chi(k, V); return s; }
static int GENINV = 0;
static void Dsub(int s, quat q, cplx *D) {
  cplx a = q.w + I * q.x, b = q.y + I * q.z, ab = q.w - I * q.x, nbb = -q.y + I * q.z;
  cplx poly[40], np[40];
  for (int qq = 0; qq <= s; qq++) { int len = 1; poly[0] = 1;
    for (int r = 0; r < qq; r++) { for (int k = 0; k <= len; k++) np[k] = 0; for (int k = 0; k < len; k++) { np[k + 1] += poly[k] * a; np[k] += poly[k] * b; } len++; for (int k = 0; k < len; k++) poly[k] = np[k]; }
    for (int r = 0; r < s - qq; r++) { for (int k = 0; k <= len; k++) np[k] = 0; for (int k = 0; k < len; k++) { np[k + 1] += poly[k] * nbb; np[k] += poly[k] * ab; } len++; for (int k = 0; k < len; k++) poly[k] = np[k]; }
    for (int p = 0; p <= s; p++) { double sc = sqrt(FACT[p] * FACT[s - p] / (FACT[qq] * FACT[s - qq])); D[p * (s + 1) + qq] = poly[p] * sc; } } }
static void rep(int s, quat q, cplx *D) { if (s == 0) { D[0] = 1; return; } Dsub(s, GENINV ? qinv(q) : q, D); }
static int NPT; static quat *RU; static double *RW;
static void gauss_legendre(int n, double *x, double *w) { for (int i = 1; i <= n; i++) { double z = cos(PI * (i - 0.25) / (n + 0.5)), dp = 0;
    for (int it = 0; it < 200; it++) { double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2 * k - 1) * z * p1 - (k - 1) * p0) / k; p0 = p1; p1 = p2; } dp = n * (z * p1 - p0) / (z * z - 1); double z1 = z; z = z1 - p1 / dp; if (fabs(z - z1) < 1e-15) break; }
    double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2 * k - 1) * z * p1 - (k - 1) * p0) / k; p0 = p1; p1 = p2; } dp = n * (z * p1 - p0) / (z * z - 1); x[i - 1] = z; w[i - 1] = 2 / ((1 - z * z) * dp * dp); } }
static void make_rule(int deg) { int nth = (deg + 2) / 2, ngl = (deg + 2) / 2, naz = deg + 1; double gx[400], gw[400]; gauss_legendre(ngl, gx, gw);
  NPT = nth * ngl * naz; RU = malloc(sizeof(quat) * NPT); RW = malloc(sizeof(double) * NPT); int n = 0;
  for (int k = 1; k <= nth; k++) { double th = k * PI / (nth + 1), wt = 2 * sin(th) * sin(th) / (nth + 1);
    for (int j = 0; j < ngl; j++) { double t = gx[j], st = sqrt(1 - t * t);
      for (int l = 0; l < naz; l++) { double ph = 2 * PI * l / naz; quat u = { cos(th), sin(th) * st * cos(ph), sin(th) * st * sin(ph), sin(th) * t }; RU[n] = u; RW[n] = wt * gw[j] / 2 / naz; n++; } } } }
/* ---- the object */
static int NL = 0; static int LB[MAXL][4], LD[MAXL];
static int NOUT = 0; static int OB[MAXOUT][4], OD[MAXOUT];
static int lkey(const int *b, int d, int create) { for (int i = 0; i < NL; i++) if (LD[i] == d && !memcmp(LB[i], b, sizeof(int) * 4)) return i; if (!create) return -1; if (NL >= MAXL) { fprintf(stderr, "too many links\n"); exit(1); } memcpy(LB[NL], b, sizeof(int) * 4); LD[NL] = d; return NL++; }
static int okey(const int *b, int d) { for (int i = 0; i < NOUT; i++) if (OD[i] == d && !memcmp(OB[i], b, sizeof(int) * 4)) return i; if (NOUT >= MAXOUT) { fprintf(stderr, "too many outside links\n"); exit(1); } memcpy(OB[NOUT], b, sizeof(int) * 4); OD[NOUT] = d; return NOUT++; }
static int NCYC, NP, LOOPA, LOOPB;
static int NSTEP[MAXCYC], STEPL[MAXCYC][MAXSTEP], STEPS[MAXCYC][MAXSTEP], ISLOOP[MAXCYC], NWIRE[MAXCYC], WBASE[MAXCYC]; static int NW = 0; static int WCYC[MAXW];
static int PB[MAXCYC][4], PD1[MAXCYC], PD2[MAXCYC];
static int NSTAP[MAXL]; static int STAP[MAXL][6][3][2];
static int SHARED0 = -1;
static int is_obj_plaq(const int *b, int d1, int d2) { for (int p = 0; p < NP; p++) if (PD1[p] == d1 && PD2[p] == d2 && !memcmp(PB[p], b, sizeof(int) * 4)) return 1; return 0; }
static void add_plaq(int p, int x, int y, int z, int d1, int d2) { int b[4] = { x, y, z, 0 }; memcpy(PB[p], b, sizeof b); PD1[p] = d1; PD2[p] = d2;
  int q[4]; NSTEP[p] = 4; ISLOOP[p] = 0;
  STEPL[p][0] = lkey(b, d1, 1); STEPS[p][0] = 1;
  memcpy(q, b, sizeof q); q[d1 - 1]++; STEPL[p][1] = lkey(q, d2, 1); STEPS[p][1] = 1;
  memcpy(q, b, sizeof q); q[d2 - 1]++; STEPL[p][2] = lkey(q, d1, 1); STEPS[p][2] = -1;
  STEPL[p][3] = lkey(b, d2, 1); STEPS[p][3] = -1; }
static void add_loop_step(int c, int i, int x, int y, int z, int d, int sgn) { int b[4] = { x, y, z, 0 }; int l = lkey(b, d, 0); if (l < 0) { fprintf(stderr, "loop link (%d,%d,%d,%d) not an object link\n", x, y, z, d); exit(1); } STEPL[c][i] = l; STEPS[c][i] = sgn; }
static int order[MAXL], NORD = 0;
static void push_order(int x, int y, int z, int d) { int b[4] = { x, y, z, 0 }; int l = lkey(b, d, 0); if (l < 0) { fprintf(stderr, "order link (%d,%d,%d,%d) missing\n", x, y, z, d); exit(1); } for (int i = 0; i < NORD; i++) if (order[i] == l) { fprintf(stderr, "order repeats link %d\n", l); exit(1); } order[NORD++] = l; }
static void build(void) { int n = NN; NP = 2 * n * n; NCYC = NP + 2; LOOPA = NP; LOOPB = NP + 1;
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) add_plaq(j + n * i, i, j, 0, 1, 2);                      /* face A: column i (x in [i, i+1]), row j */
  for (int k = 0; k < n; k++) for (int j = 0; j < n; j++) { if (PLANAR) add_plaq(n * n + j + n * k, -1 - k, j, 0, 1, 2); else add_plaq(n * n + j + n * k, 0, j, k, 2, 3); }   /* face B: column k, row j */
  if (NL != 2 * n * (n + 1) * 2 - n) { fprintf(stderr, "object links: %d, not %d\n", NL, 2 * n * (n + 1) * 2 - n); exit(1); }
  /* THE BASEPOINT IS THE TOP OF THE SHARED EDGE, (0, n, 0) (05:4x: so that both loop chains stay contiguous under the sweep below; the class and
     channel moments are invariant under the choice, both loops being conjugated by one element).  Loop A around face A counterclockwise in
     (x, y): down the shared edge, +x along y = 0, up at x = n, -x along y = n */
  NSTEP[LOOPA] = 4 * n; ISLOOP[LOOPA] = 1; NSTEP[LOOPB] = 4 * n; ISLOOP[LOOPB] = 1; { int s = 0;
    for (int j = n - 1; j >= 0; j--) add_loop_step(LOOPA, s++, 0, j, 0, 2, -1); for (int i = 0; i < n; i++) add_loop_step(LOOPA, s++, i, 0, 0, 1, 1);
    for (int j = 0; j < n; j++) add_loop_step(LOOPA, s++, n, j, 0, 2, 1); for (int i = n - 1; i >= 0; i--) add_loop_step(LOOPA, s++, i, n, 0, 1, -1); }
  { int s = 0; if (PLANAR) {   /* loop B around [-n, 0] x [0, n] counterclockwise from (0, n): -x along y = n, down at x = -n, +x along y = 0, up the shared edge */
      for (int i = 0; i < n; i++) add_loop_step(LOOPB, s++, -1 - i, n, 0, 1, -1); for (int j = n - 1; j >= 0; j--) add_loop_step(LOOPB, s++, -n, j, 0, 2, -1);
      for (int i = 0; i < n; i++) add_loop_step(LOOPB, s++, -n + i, 0, 0, 1, 1); for (int j = 0; j < n; j++) add_loop_step(LOOPB, s++, 0, j, 0, 2, 1); }
    else {                       /* loop B around face B counterclockwise in (y, z) from (0, n, 0): up at y = n, -y along z = n, down at y = 0, up the shared edge */
      for (int k = 0; k < n; k++) add_loop_step(LOOPB, s++, 0, n, k, 3, 1); for (int j = n - 1; j >= 0; j--) add_loop_step(LOOPB, s++, 0, j, n, 2, -1);
      for (int k = n - 1; k >= 0; k--) add_loop_step(LOOPB, s++, 0, 0, k, 3, -1); for (int j = 0; j < n; j++) add_loop_step(LOOPB, s++, 0, j, 0, 2, 1); } }
  for (int c = 0; c < NCYC; c++) { NWIRE[c] = ISLOOP[c] ? NSTEP[c] + 1 : NSTEP[c]; WBASE[c] = NW; for (int i = 0; i < NWIRE[c]; i++) WCYC[NW + i] = c; NW += NWIRE[c]; }
  if (NW > MAXW) { fprintf(stderr, "too many wires\n"); exit(1); }
  { int b0[4] = { 0, 0, 0, 0 }; SHARED0 = lkey(b0, 2, 0); }
  for (int l = 0; l < NL; l++) { int *p = LB[l], d = LD[l]; int pd[4]; memcpy(pd, p, sizeof pd); pd[d - 1]++; NSTAP[l] = 0;
    for (int k = 1; k <= 4; k++) { if (k == d) continue;
      for (int si = 0; si < 2; si++) { int s = si ? -1 : 1; int base[4]; memcpy(base, p, sizeof base); if (s < 0) base[k - 1]--;
        int d1 = d < k ? d : k, d2 = d < k ? k : d; if (is_obj_plaq(base, d1, d2)) continue;
        int ns = NSTAP[l]; int q[4];
        if (s > 0) { STAP[l][ns][0][0] = okey(pd, k); STAP[l][ns][0][1] = 1; } else { memcpy(q, pd, sizeof q); q[k - 1] -= 1; STAP[l][ns][0][0] = okey(q, k); STAP[l][ns][0][1] = -1; }
        memcpy(q, p, sizeof q); q[k - 1] += s; STAP[l][ns][1][0] = okey(q, d); STAP[l][ns][1][1] = -1;
        if (s > 0) { STAP[l][ns][2][0] = okey(p, k); STAP[l][ns][2][1] = -1; } else { memcpy(q, p, sizeof q); q[k - 1] -= 1; STAP[l][ns][2][0] = okey(q, k); STAP[l][ns][2][1] = 1; }
        NSTAP[l]++; } } }
  /* THE ORDER (05:4x, after the 23 GB run: the first order deferred the shared links to the end and kept face A's near column open through
     face B's sweep -- eight plaquettes open, 14^8 states): face A far to near by columns; THE SHARED LINKS AT ONCE (closing A's near column);
     face B by ROWS from the shared edge outward, the row's own links first, then the links to the next row; every plaquette has at most two
     open wires and both loop chains are contiguous at every step */
  for (int j = 0; j < n; j++) push_order(n, j, 0, 2);                                                   /* A's far edge */
  for (int i = n - 1; i >= 0; i--) { for (int j = 0; j <= n; j++) push_order(i, j, 0, 1); if (i > 0) for (int j = 0; j < n; j++) push_order(i, j, 0, 2); }
  for (int j = 0; j < n; j++) push_order(0, j, 0, 2);                                                   /* the shared links, both chains' order */
  /* face B by SLABS parallel to the shared edge, from it outward (05:5x: a sweep by rows kept every shared-edge plaquette open, seven at n = 4;
     the slab sweep keeps four, at the price of the loop chain growing from both junction wires -- d_c^4 in place of d_c^2 -- which the count
     carries): slab k's own links (the z-links through it), then the links to slab k + 1 (its tops; the far slab's in the chain's order) */
  if (PLANAR) { for (int i = 0; i < n; i++) { for (int j = 0; j <= n; j++) push_order(-1 - i, j, 0, 1); for (int j = n - 1; j >= 0; j--) push_order(-1 - i, j, 0, 2); } }
  else { for (int k = 0; k < n; k++) { for (int j = 0; j <= n; j++) push_order(0, j, k, 3); for (int j = n - 1; j >= 0; j--) push_order(0, j, k + 1, 2); } }
  if (NORD != NL) { fprintf(stderr, "the order holds %d of %d links\n", NORD, NL); exit(1); } }
static quat staple(int l, int k, const quat *dat) { quat T = { 1, 0, 0, 0 }; for (int j = 0; j < 3; j++) { quat V = dat[STAP[l][k][j][0]]; if (STAP[l][k][j][1] < 0) V = qinv(V); T = qmul(T, V); } return T; }
static int NSLOT[MAXL], SLC[MAXL][4], SLS[MAXL][4];
static void slots(void) { for (int l = 0; l < NL; l++) NSLOT[l] = 0; for (int c = 0; c < NCYC; c++) for (int i = 0; i < NSTEP[c]; i++) { int l = STEPL[c][i]; if (NSLOT[l] >= 4) { fprintf(stderr, "link %d in more than four cycles\n", l); exit(1); } SLC[l][NSLOT[l]] = c; SLS[l][NSLOT[l]] = i; NSLOT[l]++; } }
static int win(int c, int i) { return WBASE[c] + i; }
static int wout(int c, int i) { return ISLOOP[c] ? WBASE[c] + i + 1 : WBASE[c] + (i + 1) % NSTEP[c]; }
static cplx *RM; static size_t RSTR;
static cplx *rmat(int pt, int s, int inv) { return RM + ((size_t)pt * (SMAX + 1) * 2 + (size_t)s * 2 + inv) * RSTR; }
static cplx **LT[MAXL]; static double *SW[MAXL]; static int LCAP[MAXL][4], LNBLK[MAXL];
static int cap_of(int c) { return ISLOOP[c] ? LMAX : WMAX; }
static void link_tensor(int l, const quat *dat) { int m = NSLOT[l]; int nblk = 1; for (int j = 0; j < m; j++) { LCAP[l][j] = cap_of(SLC[l][j]); nblk *= LCAP[l][j] + 1; } LNBLK[l] = nblk;
  SW[l] = malloc(sizeof(double) * NPT); for (int pt = 0; pt < NPT; pt++) { double w = RW[pt]; if (!FREE) for (int k = 0; k < NSTAP[l]; k++) { quat T = staple(l, k, dat); w *= wgt(qmul(RU[pt], T)); } SW[l][pt] = w; }
  LT[l] = calloc(nblk, sizeof(cplx *));
  #pragma omp parallel for schedule(dynamic)
  for (int b = 0; b < nblk; b++) { int sp[4], bb = b, size = 1; for (int j = 0; j < m; j++) { sp[j] = bb % (LCAP[l][j] + 1); bb /= LCAP[l][j] + 1; size *= DIM[sp[j]] * DIM[sp[j]]; }
    cplx *B = calloc(size, sizeof(cplx)); LT[l][b] = B;
    for (int pt = 0; pt < NPT; pt++) { double w = SW[l][pt]; const cplx *R[4]; for (int j = 0; j < m; j++) R[j] = rmat(pt, sp[j], STEPS[SLC[l][j]][SLS[l][j]] < 0);
      if (m == 1) { int d0 = DIM[sp[0]]; for (int i = 0; i < d0 * d0; i++) B[i] += w * R[0][i]; }
      else if (m == 2) { int d0 = DIM[sp[0]], d1 = DIM[sp[1]]; for (int i = 0; i < d0 * d0; i++) { cplx f = w * R[0][i]; cplx *out = B + (size_t)i * d1 * d1; for (int k = 0; k < d1 * d1; k++) out[k] += f * R[1][k]; } }
      else if (m == 3) { int d0 = DIM[sp[0]], d1 = DIM[sp[1]], d2 = DIM[sp[2]]; for (int i = 0; i < d0 * d0; i++) { cplx f = w * R[0][i]; for (int k = 0; k < d1 * d1; k++) { cplx g = f * R[1][k]; cplx *out = B + ((size_t)i * d1 * d1 + k) * d2 * d2; for (int q = 0; q < d2 * d2; q++) out[q] += g * R[2][q]; } } }
      else { int d0 = DIM[sp[0]], d1 = DIM[sp[1]], d2 = DIM[sp[2]], d3 = DIM[sp[3]]; for (int i = 0; i < d0 * d0; i++) { cplx f = w * R[0][i]; for (int k = 0; k < d1 * d1; k++) { cplx g = f * R[1][k]; for (int q = 0; q < d2 * d2; q++) { cplx h = g * R[2][q]; cplx *out = B + (((size_t)i * d1 * d1 + k) * d2 * d2 + q) * d3 * d3; for (int r = 0; r < d3 * d3; r++) out[r] += h * R[3][r]; } } } } } } }
typedef struct { int nopen, open[128]; int ncyc, cyc[40]; int nblk; cplx **blk; size_t *size; } state_t;
static int LSPIN[MAXCYC];
static int in_list(int x, const int *L, int n) { for (int i = 0; i < n; i++) if (L[i] == x) return i; return -1; }
static void free_state(state_t *S) { for (int b = 0; b < S->nblk; b++) free(S->blk[b]); free(S->blk); free(S->size); }
/* THE SLICED SWEEP (10:1x; the weld of S1 §27 (m‴)'s fixed-leg split onto this engine, read to the author by two side readers and by the author):
   the four junction wires wAin, wAout, wBin, wBout each belong to ONE chain step, are born open at that step's link, are never contracted,
   and are closed only by the final trace (the class moment) or the channel projection -- so the final tensor F over them is what the sweep
   computes, and clamping a junction wire at a value is an exact slice of F.  W2_SLICE=full runs every (q, r, q', r') slice and assembles F
   entry by entry (the class moment AND the channels, as the unsliced sweep gives them); W2_SLICE=diag runs the d_a d_c diagonal slices
   (the class moment alone, the channels refused by name).  The A-part of the order (face A's columns, before the shared links, index NA) is
   swept once per class and kept as a snapshot; each slice is gathered from it (a wire already open is sliced by a strided gather, a wire not
   yet born is clamped at birth through FIXV in process()), then the shared links and face B's slabs are swept on the slice.  Face B's chain,
   which the slab sweep grows from both junction wires (d_c^4), is carried at its two growing ends alone (d_c^2), and face A's junction pair
   (d_a^2) leaves the state: the peak falls by d_a^2 d_c^2 (81 at loop spin 1), the multiply-adds of the B-part are unchanged in total, the
   A-part is paid once.  Unset, every byte of the output is the unsliced engine's. */
static int FIXV[MAXW]; static int SLICE = 0; static int CMAX = -1;   /* CMAX: the cap on face B's loop representation (W2_CMAX; a ladder reads c = 0 alone), LMAX unless set */
static void gather_state(const state_t *S, state_t *D, const int *fw, const int *fv, int nf) {
  int pos[8]; for (int i = 0; i < nf; i++) { pos[i] = in_list(fw[i], S->open, S->nopen); if (pos[i] < 0) { fprintf(stderr, "gather: wire %d is not open\n", fw[i]); exit(1); } }
  D->nopen = 0; for (int i = 0; i < S->nopen; i++) if (in_list(S->open[i], fw, nf) < 0) D->open[D->nopen++] = S->open[i];
  D->ncyc = S->ncyc; memcpy(D->cyc, S->cyc, sizeof(int) * S->ncyc); D->nblk = S->nblk; D->blk = calloc(D->nblk, sizeof(cplx *)); D->size = calloc(D->nblk, sizeof(size_t));
  for (int bn = 0; bn < S->nblk; bn++) { if (!S->blk[bn]) continue;
    int spin[MAXCYC]; for (int c = 0; c < NCYC; c++) spin[c] = ISLOOP[c] ? LSPIN[c] : -1;
    { int bb = bn; for (int i = 0; i < S->ncyc; i++) { spin[S->cyc[i]] = bb % (WMAX + 1); bb /= WMAX + 1; } }
    size_t sstr[128]; { size_t mul = 1; for (int i = S->nopen - 1; i >= 0; i--) { sstr[i] = mul; mul *= DIM[spin[WCYC[S->open[i]]]]; } }
    size_t base = 0; for (int i = 0; i < nf; i++) { if (fv[i] >= DIM[spin[WCYC[fw[i]]]]) { fprintf(stderr, "gather: value %d past the wire's dimension\n", fv[i]); exit(1); } base += (size_t)fv[i] * sstr[pos[i]]; }
    int kd[128]; size_t ks[128], nsize = 1; int nk = 0; for (int i = 0; i < S->nopen; i++) if (in_list(S->open[i], fw, nf) < 0) { kd[nk] = DIM[spin[WCYC[S->open[i]]]]; ks[nk] = sstr[i]; nsize *= kd[nk]; nk++; }
    cplx *NB = calloc(nsize, sizeof(cplx)); if (!NB) { fprintf(stderr, "out of memory at a gathered state of %zu entries\n", nsize); exit(3); } D->blk[bn] = NB; D->size[bn] = nsize;
    const cplx *OB_ = S->blk[bn];
    #pragma omp parallel for schedule(static)
    for (long long e = 0; e < (long long)nsize; e++) { size_t rem = e, o = base; for (int k = nk - 1; k >= 0; k--) { size_t ix = rem % kd[k]; rem /= kd[k]; o += ix * ks[k]; } NB[e] = OB_[o]; } } }
static void process(state_t *S, int l) {
  int m = NSLOT[l]; int sw[8], nsw = 0; for (int j = 0; j < m; j++) { sw[nsw++] = win(SLC[l][j], SLS[l][j]); sw[nsw++] = wout(SLC[l][j], SLS[l][j]); }
  int contracted[8], ncon = 0, newer[8], nnew = 0, fixed[8], nfix = 0; for (int i = 0; i < nsw; i++) { if (in_list(sw[i], S->open, S->nopen) >= 0) contracted[ncon++] = sw[i]; else if (FIXV[sw[i]] >= 0) fixed[nfix++] = sw[i]; else newer[nnew++] = sw[i]; }
  state_t N; N.nopen = 0; for (int i = 0; i < S->nopen; i++) if (in_list(S->open[i], contracted, ncon) < 0) N.open[N.nopen++] = S->open[i]; for (int i = 0; i < nnew; i++) N.open[N.nopen++] = newer[i];
  N.ncyc = 0; for (int i = 0; i < S->ncyc; i++) { int c = S->cyc[i], has = 0; for (int w = 0; w < N.nopen; w++) if (WCYC[N.open[w]] == c) has = 1; if (has) N.cyc[N.ncyc++] = c; }
  for (int w = 0; w < N.nopen; w++) { int c = WCYC[N.open[w]]; if (ISLOOP[c]) continue; if (in_list(c, N.cyc, N.ncyc) < 0) N.cyc[N.ncyc++] = c; }
  int closed[40], nclosed = 0; for (int i = 0; i < S->ncyc; i++) if (in_list(S->cyc[i], N.cyc, N.ncyc) < 0) closed[nclosed++] = S->cyc[i];
  N.nblk = 1; for (int i = 0; i < N.ncyc; i++) N.nblk *= WMAX + 1; N.blk = calloc(N.nblk, sizeof(cplx *)); N.size = calloc(N.nblk, sizeof(size_t));
  int nclblk = 1; for (int i = 0; i < nclosed; i++) nclblk *= WMAX + 1;
  for (int bn = 0; bn < N.nblk; bn++) {
    int spin[MAXCYC]; for (int c = 0; c < NCYC; c++) spin[c] = ISLOOP[c] ? LSPIN[c] : -1;
    { int bb = bn; for (int i = 0; i < N.ncyc; i++) { spin[N.cyc[i]] = bb % (WMAX + 1); bb /= WMAX + 1; } }
    int ndim[128]; size_t nsize = 1; for (int w = 0; w < N.nopen; w++) { ndim[w] = DIM[spin[WCYC[N.open[w]]]]; nsize *= ndim[w]; }
    cplx *NB = calloc(nsize, sizeof(cplx)); if (!NB) { fprintf(stderr, "out of memory at a state of %zu entries\n", nsize); exit(3); } N.blk[bn] = NB; N.size[bn] = nsize;
    for (int bc = 0; bc < nclblk; bc++) {
      double fw = 1; { int bb = bc; for (int i = 0; i < nclosed; i++) { int s = bb % (WMAX + 1); bb /= WMAX + 1; spin[closed[i]] = s; fw *= FAC[s]; } }
      if (fw == 0) continue;
      int bo = 0; { int mul = 1; for (int i = 0; i < S->ncyc; i++) { bo += spin[S->cyc[i]] * mul; mul *= WMAX + 1; } }
      int bt = 0; { int mul = 1; for (int j = 0; j < m; j++) { bt += spin[SLC[l][j]] * mul; mul *= LCAP[l][j] + 1; } }
      const cplx *OB_ = S->blk[bo]; const cplx *TB = LT[l][bt]; if (!OB_ || !TB) continue;
      size_t ostr[128], tstr[8]; { size_t mul = 1; for (int i = S->nopen - 1; i >= 0; i--) { ostr[i] = mul; mul *= DIM[spin[WCYC[S->open[i]]]]; } }
      { size_t mul = 1; for (int i = nsw - 1; i >= 0; i--) { tstr[i] = mul; mul *= DIM[spin[WCYC[sw[i]]]]; } }
      size_t fixoff = 0; for (int i = 0; i < nfix; i++) fixoff += (size_t)FIXV[fixed[i]] * tstr[in_list(fixed[i], sw, nsw)];   /* a clamped junction wire enters the link tensor as that one slice and never the state */
      size_t nos[128], nts[128]; for (int w = 0; w < N.nopen; w++) { int io = in_list(N.open[w], S->open, S->nopen), it = in_list(N.open[w], sw, nsw); nos[w] = io >= 0 ? ostr[io] : 0; nts[w] = it >= 0 ? tstr[it] : 0; }
      int cdim[8]; size_t cos_[8], cts[8]; for (int i = 0; i < ncon; i++) { int io = in_list(contracted[i], S->open, S->nopen), it = in_list(contracted[i], sw, nsw); cdim[i] = DIM[spin[WCYC[contracted[i]]]]; cos_[i] = ostr[io]; cts[i] = tstr[it]; }
      size_t ncomb = 1; for (int i = 0; i < ncon; i++) ncomb *= cdim[i];
      #pragma omp parallel for schedule(static)
      for (long long e = 0; e < (long long)nsize; e++) { size_t rem = e, oo = 0, to = fixoff; for (int w = N.nopen - 1; w >= 0; w--) { size_t ix = rem % ndim[w]; rem /= ndim[w]; oo += ix * nos[w]; to += ix * nts[w]; }
        cplx acc = 0; size_t ci[8] = {0};
        for (size_t q = 0; q < ncomb; q++) { size_t o2 = oo, t2 = to; for (int i = 0; i < ncon; i++) { o2 += ci[i] * cos_[i]; t2 += ci[i] * cts[i]; } acc += OB_[o2] * TB[t2];
          for (int i = ncon - 1; i >= 0; i--) { if (++ci[i] < (size_t)cdim[i]) break; ci[i] = 0; } }
        NB[e] += fw * acc; } } }
  free_state(S); *S = N; }
static void projector(int a, int c, int k, cplx *P) { int da = DIM[a], dc = DIM[c]; size_t n = (size_t)da * dc; memset(P, 0, sizeof(cplx) * n * n); cplx Ra[256], Rc[256];
  for (int pt = 0; pt < NPT; pt++) { double w = RW[pt] * DIM[k] * chi(k, RU[pt]); rep(a, RU[pt], Ra); rep(c, RU[pt], Rc);
    for (int q = 0; q < da; q++) for (int qp = 0; qp < dc; qp++) for (int r = 0; r < da; r++) for (int rp = 0; rp < dc; rp++) P[((size_t)q * dc + qp) * n + (size_t)r * dc + rp] += w * Ra[q * da + r] * Rc[qp * dc + rp]; } }
int main(int argc, char **argv) {
  if (argc < 5) { fprintf(stderr, "usage: w2_strip_n beta WMAX LMAX DATUM [fwd|rev] [bent|planar] [n]   DATUM = free | ordered | random:SEED | cancel\n"); return 1; }
  BETA = atof(argv[1]); WMAX = atoi(argv[2]); LMAX = atoi(argv[3]); const char *datum = argv[4]; int rev = (argc > 5 && !strcmp(argv[5], "rev"));
  PLANAR = (argc > 6 && !strcmp(argv[6], "planar")); if (argc > 7) NN = atoi(argv[7]);
  CEIL = getenv("W2_CEIL") ? (size_t)atoll(getenv("W2_CEIL")) : (size_t)400000000;   /* the state ceiling: 4e8 entries (6.4 GB), refused above it by name */
  if (WMAX > 15 || LMAX > 15 || WMAX < 0 || LMAX < 0 || NN < 1 || NN > 4) { fprintf(stderr, "caps or n out of range\n"); return 1; }
  SMAX = WMAX > LMAX ? WMAX : LMAX; FREE = !strcmp(datum, "free");
  FACT[0] = 1; for (int i = 1; i < 40; i++) FACT[i] = FACT[i - 1] * i;
  for (int s = 0; s <= 30; s++) { A[s] = bessel(s + 1, BETA) / bessel(1, BETA); DIM[s] = s + 1; FAC[s] = (s <= WMAX) ? (s + 1) * A[s] : 0; }
  double t0 = now();
  { quat q1 = {0.5, 0.5, 0.5, 0.5}, q2 = {1 / sqrt(2), 0, 1 / sqrt(2), 0}, q3 = {0.6, 0, 0.8, 0}; quat q12 = qmul(q1, q2); int bad = 0;
    for (int trial = 0; trial < 2; trial++) { GENINV = trial; double dmax = 0; for (int s = 1; s <= SMAX; s++) { int d = s + 1; cplx P[256], X1[256], X2[256], Y[256]; rep(s, q12, P); rep(s, q1, X1); rep(s, q2, X2);
        for (int i = 0; i < d; i++) for (int j = 0; j < d; j++) { cplx acc = 0; for (int k = 0; k < d; k++) acc += X1[i * d + k] * X2[k * d + j]; Y[i * d + j] = acc; }
        for (int i = 0; i < d * d; i++) if (cabs(Y[i] - P[i]) > dmax) dmax = cabs(Y[i] - P[i]); }
      if (dmax < 1e-12) break; if (trial == 1) { fprintf(stderr, "neither substitution composes\n"); return 1; } }
    for (int s = 0; s <= SMAX; s++) { int d = s + 1; cplx X[256]; rep(s, q3, X); cplx tr = 0; for (int i = 0; i < d; i++) tr += X[i * d + i]; if (fabs(creal(tr) - chi(s, q3)) > 1e-12 || fabs(cimag(tr)) > 1e-12) bad++; }
    printf("W2-KAT representations to spin %d/2 (GENINV=%d): homomorphism and traces [%s]\n", SMAX, GENINV, bad ? "FAILED" : "MET"); if (bad) return 1; }
  build(); slots();
  int n5 = 0, n4 = 0, nother = 0; for (int l = 0; l < NL; l++) { if (NSTAP[l] == 5) n5++; else if (NSTAP[l] == 4) n4++; else nother++; }
  if (nother) { fprintf(stderr, "a link with neither four nor five staples\n"); return 1; }
  int deg = 0; for (int l = 0; l < NL; l++) { int d = NSTAP[l] * WMAX; for (int j = 0; j < NSLOT[l]; j++) d += cap_of(SLC[l][j]); if (d > deg) deg = d; } if (deg < 12) deg = 12; make_rule(deg);
  printf("W2-OBJECT %s n=%d plaquettes=%d links=%d (shared=%d) outside=%d staples five=%d four=%d; rule degree %d, %d points; beta=%g WMAX=%d LMAX=%d datum=%s order=%s\n", PLANAR ? "planar" : "bent", NN, NP, NL, SHARED0, NOUT, n5, n4, deg, NPT, BETA, WMAX, LMAX, datum, rev ? "rev" : "fwd");
  quat *DATA = malloc(sizeof(quat) * (NOUT + 1)); for (int i = 0; i < NOUT; i++) { quat e = { 1, 0, 0, 0 }; DATA[i] = e; }
  if (!strcmp(datum, "cancel")) { quat want[4] = { {1,0,0,0}, {-1,0,0,0}, {0,1,0,0}, {0,-1,0,0} }; if (NSTAP[SHARED0] != 4) { fprintf(stderr, "the shared link has %d staples, not 4\n", NSTAP[SHARED0]); return 1; } for (int k = 0; k < 4; k++) DATA[STAP[SHARED0][k][1][0]] = qinv(want[k]); }
  else if (!strncmp(datum, "random:", 7)) {   /* THE HAAR-RANDOM DATUM SEEDED BY GEOMETRY (05:0x): each outside link's quaternion is a function of its
      coordinates, its direction and the seed, never of the link's index -- so the same link gets the same datum in every engine, at every n and
      in both objects (the index-seeded datum of w2_strip.c parted from this one at n = 2: a different numbering, a different datum) */
    unsigned long long seed = (unsigned long long)atoll(datum + 7);
    for (int i = 0; i < NOUT; i++) { unsigned long long h = seed * 0x9E3779B97F4A7C15ULL + 0x1234567ULL; for (int j = 0; j < 4; j++) h = (h ^ (unsigned long long)(OB[i][j] + 1000003)) * 0xBF58476D1CE4E5B9ULL; h = (h ^ (unsigned long long)(OD[i] * 7919)) * 0x94D049BB133111EBULL;
      double g[4], nn = 0; for (int j = 0; j < 4; j += 2) { h ^= h >> 31; h *= 0xD6E8FEB86659FD93ULL; h ^= h >> 32; double u1 = ((h >> 11) + 1.0) / 9007199254740994.0; h ^= h >> 29; h *= 0xBF58476D1CE4E5B9ULL; h ^= h >> 32; double u2 = (h >> 11) / 9007199254740992.0; double r = sqrt(-2 * log(u1)); g[j] = r * cos(2 * PI * u2); g[j + 1] = r * sin(2 * PI * u2); }
      for (int j = 0; j < 4; j++) nn += g[j] * g[j]; nn = sqrt(nn); quat q = { g[0] / nn, g[1] / nn, g[2] / nn, g[3] / nn }; DATA[i] = q; } }
  else if (strcmp(datum, "ordered") && strcmp(datum, "free")) { fprintf(stderr, "unknown datum %s\n", datum); return 1; }
  /* THE INFLUENCE LADDER (the campaign's §9, 06:3x): W2_ROT="<outside link index>:<angle>" left-multiplies that one outside link by the
     rotation by the angle about the x-axis of su(2) (the quaternion (cos a/2, sin a/2, 0, 0)); W2_LIST=1 prints every outside link's
     coordinates and direction once, so a reader can group them by distance and class */
  if (getenv("W2_LIST")) for (int i = 0; i < NOUT; i++) printf("W2-OUT %d %d %d %d %d %d\n", i, OB[i][0], OB[i][1], OB[i][2], OB[i][3], OD[i]);
  /* THE WHOLE DATUM FROM A FILE (the campaign's §16, 19:4x): W2_DATUM=<file> with one line per outside link, "<index> <w> <x> <y> <z>" in the
     engine's own W2-OUT index order (the index checked, the quaternion normalised, a missing or repeated index REFUSED), replacing the named
     datum's values link by link after the named datum is built -- so the worst-configuration ascent can hand the engine any outside */
  if (getenv("W2_DATUM")) { FILE *df = fopen(getenv("W2_DATUM"), "r"); if (!df) { fprintf(stderr, "W2_DATUM: cannot open %s\n", getenv("W2_DATUM")); return 1; }
    int seen[MAXOUT]; memset(seen, 0, sizeof seen); int idx; double dw, dx, dy, dz; int nread = 0;
    while (fscanf(df, "%d %lf %lf %lf %lf", &idx, &dw, &dx, &dy, &dz) == 5) { if (idx < 0 || idx >= NOUT) { fprintf(stderr, "W2_DATUM: index %d outside 0..%d\n", idx, NOUT - 1); return 1; }
      if (seen[idx]) { fprintf(stderr, "W2_DATUM: index %d repeated\n", idx); return 1; } double nn = sqrt(dw * dw + dx * dx + dy * dy + dz * dz); if (nn < 1e-12) { fprintf(stderr, "W2_DATUM: a zero quaternion at %d\n", idx); return 1; }
      quat q = { dw / nn, dx / nn, dy / nn, dz / nn }; DATA[idx] = q; seen[idx] = 1; nread++; }
    fclose(df); if (nread != NOUT) { fprintf(stderr, "W2_DATUM: %d of %d outside links given\n", nread, NOUT); return 1; }
    printf("W2-DATUM %s: all %d outside links set from the file (the named datum %s overridden link by link)\n", getenv("W2_DATUM"), NOUT, datum); }
  /* the datum written into every dump (19:5x): one W2-DATA line per outside link, in the file's own format, so a dump record carries the outside it was read at */
  if (getenv("W2_DUMPF")) for (int i = 0; i < NOUT; i++) printf("W2-DATA %d %.17g %.17g %.17g %.17g\n", i, DATA[i].w, DATA[i].x, DATA[i].y, DATA[i].z);
  int ROTL = -1; double ROTA = 0; if (getenv("W2_ROT")) { if (sscanf(getenv("W2_ROT"), "%d:%lf", &ROTL, &ROTA) != 2 || ROTL < 0 || ROTL >= NOUT) { fprintf(stderr, "W2_ROT must be <index 0..%d>:<angle>\n", NOUT - 1); return 1; }
    quat r = { cos(ROTA / 2), sin(ROTA / 2), 0, 0 }; DATA[ROTL] = qmul(r, DATA[ROTL]); printf("W2-ROT link %d (%d,%d,%d,%d dir %d) by %.6f\n", ROTL, OB[ROTL][0], OB[ROTL][1], OB[ROTL][2], OB[ROTL][3], OD[ROTL], ROTA); }
  /* THE OSCILLATION INSTRUMENT (§9 ADDENDUM, 10:5x): W2_SET="<outside link index>:<w>:<x>:<y>:<z>" left-multiplies that one link by the unit
     quaternion (w, x, y, z)/|·| -- any value of the link, not one angle about one axis -- so a sweep over a grid of quaternions reads the
     range of the coarse loop's moments over the link's value at a fixed datum, the single-link influence's sup that a Dobrushin row takes */
  if (getenv("W2_SET")) { int sl = -1; double sw, sx, sy, sz; if (sscanf(getenv("W2_SET"), "%d:%lf:%lf:%lf:%lf", &sl, &sw, &sx, &sy, &sz) != 5 || sl < 0 || sl >= NOUT) { fprintf(stderr, "W2_SET must be <index 0..%d>:<w>:<x>:<y>:<z>\n", NOUT - 1); return 1; }
    double nn = sqrt(sw * sw + sx * sx + sy * sy + sz * sz); if (nn < 1e-12) { fprintf(stderr, "W2_SET: a zero quaternion\n"); return 1; } quat q = { sw / nn, sx / nn, sy / nn, sz / nn }; DATA[sl] = qmul(q, DATA[sl]);
    printf("W2-SET link %d (%d,%d,%d,%d dir %d) left-multiplied by (%.9f,%.9f,%.9f,%.9f)\n", sl, OB[sl][0], OB[sl][1], OB[sl][2], OB[sl][3], OD[sl], q.w, q.x, q.y, q.z); }
  RSTR = (size_t)(SMAX + 1) * (SMAX + 1); RM = malloc(sizeof(cplx) * (size_t)NPT * (SMAX + 1) * 2 * RSTR);
  #pragma omp parallel for schedule(static)
  for (int pt = 0; pt < NPT; pt++) for (int s = 0; s <= SMAX; s++) { rep(s, RU[pt], rmat(pt, s, 0)); rep(s, qinv(RU[pt]), rmat(pt, s, 1)); }
  for (int l = 0; l < NL; l++) link_tensor(l, DATA);
  printf("W2-TENSORS built in %.1f s\n", now() - t0);
  if (rev) for (int i = 0; i < NORD / 2; i++) { int t = order[i]; order[i] = order[NORD - 1 - i]; order[NORD - 1 - i] = t; }
  int wAin = win(LOOPA, 0), wAout = wout(LOOPA, NSTEP[LOOPA] - 1), wBin = win(LOOPB, 0), wBout = wout(LOOPB, NSTEP[LOOPB] - 1);
  int NA = -1; for (int i = 0; i < NORD; i++) if (order[i] == SHARED0) { NA = i; break; }
  for (int w = 0; w < NW; w++) FIXV[w] = -1;
  if (getenv("W2_SLICE")) { const char *sm = getenv("W2_SLICE"); SLICE = !strcmp(sm, "diag") ? 2 : (!strcmp(sm, "full") ? 1 : 0);
    if (!SLICE) { fprintf(stderr, "W2_SLICE must be full or diag\n"); return 1; }
    if (rev) { fprintf(stderr, "W2_SLICE is for the forward order (face A's part is cached before the shared links)\n"); return 1; }
    if (NA < 0) { fprintf(stderr, "the first shared link is not in the order\n"); return 1; }
    printf("W2-SLICED mode=%s: the junction wires clamped in an outer loop of slices; face A's part (order index %d of %d) swept once per class and gathered per slice\n", SLICE == 2 ? "diag" : "full", NA, NORD); }
  CMAX = LMAX; if (getenv("W2_CMAX")) { CMAX = atoi(getenv("W2_CMAX")); if (CMAX < 0 || CMAX > LMAX) { fprintf(stderr, "W2_CMAX must be 0..%d\n", LMAX); return 1; }
    printf("W2-CMAX %d: face B's loop representation capped at %d/2 for this run (the classes a <= %d, c <= %d; the connected moments and channels for c <= %d alone)\n", CMAX, CMAX, LMAX, CMAX, CMAX); }
  double Z = 0; static double CLS[16][16];
  for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= CMAX; c++) { double ts = now(); LSPIN[LOOPA] = a; LSPIN[LOOPB] = c;
    state_t S; S.nopen = 0; S.ncyc = 0; S.nblk = 1; S.blk = calloc(1, sizeof(cplx *)); S.size = calloc(1, sizeof(size_t)); S.blk[0] = calloc(1, sizeof(cplx)); S.blk[0][0] = 1; S.size[0] = 1;
    int da = DIM[a], dc = DIM[c]; size_t sA_in = 0, sA_out = 0, sB_in = 0, sB_out = 0; const cplx *F = NULL; cplx *Fs = NULL; int nslices = 0; char slicenote[64] = "";
    int nsweep = SLICE ? NA : NORD;
    size_t maxstate = 1; int maxopen = 0; for (int i = 0; i < nsweep; i++) { process(&S, order[i]); size_t tot = 0; for (int b = 0; b < S.nblk; b++) tot += S.size[b]; if (tot > maxstate) maxstate = tot; if (S.ncyc > maxopen) maxopen = S.ncyc;
      if (tot > CEIL) { fprintf(stderr, "W2-REFUSED: the state reached %zu entries after link %d of %d (%d plaquettes open), above the ceiling %zu (W2_CEIL)\n", tot, i + 1, NORD, S.ncyc, CEIL); return 3; } }
    if (SLICE) {   /* the snapshot S holds face A's part; every slice is gathered from it and swept through the shared links and face B */
      int jw[4] = { wAin, wAout, wBin, wBout }; Fs = calloc((size_t)da * da * dc * dc, sizeof(cplx)); sA_in = (size_t)da * dc * dc; sA_out = (size_t)dc * dc; sB_in = dc; sB_out = 1;
      for (int q = 0; q < da; q++) for (int r = 0; r < da; r++) for (int qp = 0; qp < dc; qp++) for (int rp = 0; rp < dc; rp++) { if (SLICE == 2 && (q != r || qp != rp)) continue;
        int jv[4] = { q, r, qp, rp }, gw[4], gv[4], ng = 0; for (int i = 0; i < 4; i++) { if (in_list(jw[i], S.open, S.nopen) >= 0) { gw[ng] = jw[i]; gv[ng] = jv[i]; ng++; } else FIXV[jw[i]] = jv[i]; }
        state_t T; gather_state(&S, &T, gw, gv, ng);
        for (int i = NA; i < NORD; i++) { process(&T, order[i]); size_t tot = 0; for (int b = 0; b < T.nblk; b++) tot += T.size[b]; if (tot > maxstate) maxstate = tot; if (T.ncyc > maxopen) maxopen = T.ncyc;
          if (tot > CEIL) { fprintf(stderr, "W2-REFUSED: the sliced state reached %zu entries after link %d of %d (%d plaquettes open), above the ceiling %zu (W2_CEIL)\n", tot, i + 1, NORD, T.ncyc, CEIL); return 3; } }
        for (int i = 0; i < 4; i++) FIXV[jw[i]] = -1;
        if (T.ncyc != 0 || T.nblk != 1 || T.nopen != 0) { fprintf(stderr, "a slice ended with %d open wires and %d open cycles\n", T.nopen, T.ncyc); return 1; }
        Fs[q * sA_in + r * sA_out + qp * sB_in + rp * sB_out] = T.blk[0][0]; nslices++; free_state(&T); }
      F = Fs; snprintf(slicenote, sizeof slicenote, "; %d slices", nslices); }
    else {
    if (S.ncyc != 0 || S.nblk != 1) { fprintf(stderr, "plaquette cycles still open at the end\n"); return 1; }
    int pos[4] = { in_list(wAin, S.open, S.nopen), in_list(wAout, S.open, S.nopen), in_list(wBin, S.open, S.nopen), in_list(wBout, S.open, S.nopen) };
    if (S.nopen != 4) { fprintf(stderr, "%d open wires at the end, not 4\n", S.nopen); return 1; }
    for (int i = 0; i < 4; i++) if (pos[i] < 0) { fprintf(stderr, "junction wire %d not open at the end\n", i); return 1; }
    size_t str[4]; { size_t mul = 1; int dims[4]; for (int i = 0; i < 4; i++) dims[i] = DIM[LSPIN[WCYC[S.open[i]]]]; for (int i = 3; i >= 0; i--) { str[i] = mul; mul *= dims[i]; } }
    sA_in = str[pos[0]]; sA_out = str[pos[1]]; sB_in = str[pos[2]]; sB_out = str[pos[3]];
    F = S.blk[0]; }
    cplx cls = 0; for (int r = 0; r < da; r++) for (int rp = 0; rp < dc; rp++) cls += F[r * sA_in + r * sA_out + rp * sB_in + rp * sB_out];
    if (a == 0 && c == 0) Z = creal(cls);
    /* THE DUMP (the campaign's §14, 17:1x): W2_DUMPF=1 prints the junction tensor F^{ac}(r, q, r', q') = E[D^a(A)_{rq} D^c(B)_{r'q'}] (unnormalised; Z on its
       own line, GENINV with it) entry by entry, the index order the class moment's (r the A-in wire, q the A-out, r' the B-in, q' the B-out) --
       the (8.5) reader w2_dob.c reconstructs the joint law from it; unset, the output is byte-identical */
    if (getenv("W2_DUMPF")) { if (a == 0 && c == 0) printf("W2-FHEAD GENINV=%d Z=%.17e LMAX=%d\n", GENINV, Z, LMAX);
      for (int r = 0; r < da; r++) for (int q = 0; q < da; q++) for (int rp = 0; rp < dc; rp++) for (int qp = 0; qp < dc; qp++) { cplx v = F[r * sA_in + q * sA_out + rp * sB_in + qp * sB_out];
        printf("W2-F a=%d c=%d r=%d q=%d rp=%d qp=%d %+.17e %+.17e\n", a, c, r, q, rp, qp, creal(v), cimag(v)); } }
    CLS[a][c] = creal(cls) / Z;
    printf("W2-CLASS a=%d c=%d E[chi_a(A) chi_c(B)] = %+.12e (imag %.1e; max state %zu, open plaquettes at most %d; %.1f s%s)\n", a, c, creal(cls) / Z, cimag(cls) / Z, maxstate, maxopen, now() - ts, slicenote);
    if (a > 0 && c > 0 && SLICE == 2) printf("W2-CHANNEL a=%d c=%d REFUSED: the diagonal slices hold the class moment only\n", a, c);
    else if (a > 0 && c > 0) { size_t nn = (size_t)da * dc; cplx *P = malloc(sizeof(cplx) * nn * nn), *Psum = calloc(nn * nn, sizeof(cplx)); double chsum = 0;
      for (int k = abs(a - c); k <= a + c; k += 2) { projector(a, c, k, P); for (size_t i = 0; i < nn * nn; i++) Psum[i] += P[i];
        double idem = 0; for (size_t i = 0; i < nn; i++) for (size_t j = 0; j < nn; j++) { cplx acc = 0; for (size_t q = 0; q < nn; q++) acc += P[i * nn + q] * P[q * nn + j]; if (cabs(acc - P[i * nn + j]) > idem) idem = cabs(acc - P[i * nn + j]); }
        cplx f = 0; for (int q = 0; q < da; q++) for (int qp = 0; qp < dc; qp++) for (int r = 0; r < da; r++) for (int rp = 0; rp < dc; rp++) f += P[((size_t)q * dc + qp) * nn + (size_t)r * dc + rp] * F[r * sA_in + q * sA_out + rp * sB_in + qp * sB_out];
        chsum += creal(f) / Z;
        printf("W2-CHANNEL a=%d c=%d k=%d f_k = %+.12e (imag %.1e; P_k idempotent to %.1e; f_k/E = %.9f, free law d_k/(d_a d_c) = %.9f)\n", a, c, k, creal(f) / Z, cimag(f) / Z, idem, creal(f) / Z / CLS[a][c], (double)DIM[k] / (da * dc)); }
      double pid = 0; for (size_t i = 0; i < nn; i++) for (size_t j = 0; j < nn; j++) { cplx want = (i == j) ? 1 : 0; if (cabs(Psum[i * nn + j] - want) > pid) pid = cabs(Psum[i * nn + j] - want); }
      printf("W2-CHANNEL-SUM a=%d c=%d sum_k f_k = %+.12e against the class moment %+.12e (sum_k P_k = 1 to %.1e)\n", a, c, chsum, CLS[a][c], pid); free(P); free(Psum); }
    free_state(&S); free(Fs); }
  printf("W2-Z beta=%g datum=%s n=%d Z = %.12e\n", BETA, datum, NN, Z);
  int badfree = 0; for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= CMAX; c++) { double conn = CLS[a][c] - CLS[a][0] * CLS[0][c];
    printf("W2-CONN a=%d c=%d <chi_a chi_c>_c = %+.12e (marginals %+.9e, %+.9e)\n", a, c, conn, CLS[a][0], CLS[0][c]);
    if (FREE) { double wantA = (a <= WMAX) ? DIM[a] * pow(A[a], NN * NN) : 0; if (fabs(CLS[a][0] - wantA) > 1e-9 * (1 + fabs(wantA)) || fabs(conn) > 1e-9) badfree++; } }
  if (FREE) printf("W2-KAT FREE n=%d: Z = 1 [%s]; E[chi_a(A)] = d_a a_a^(n^2) and every connected pair zero [%s]\n", NN, fabs(Z - 1) < 1e-9 ? "MET" : "FAILED", badfree ? "FAILED" : "MET");
  printf("W2-DONE %.1f s\n", now() - t0); return 0; }
