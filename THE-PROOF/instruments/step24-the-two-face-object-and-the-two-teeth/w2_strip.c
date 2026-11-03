/* w2_strip.c -- THE TWO-FACE OBJECT'S SWEEP: the joint law of two adjacent coarse 2x2 loops under the one-step blocked measure, exact at
 * plaquette spins <= WMAX/2 (THE CROSSING CAMPAIGN W2, 2026-11-01, the author; the count and the design on the campaign page section 6).
 * The object: face A = the 2x2 block of fine plaquettes in the xy-plane at z = w = 0, face B = the 2x2 block in the yz-plane at x = w = 0,
 * sharing the coarse edge x = z = 0, y in [0, 2] (the two fine links y in [0,1], [1,2]).  Eight plaquettes, twenty-two links; every object link
 * also lies in staples outside the object (five on a private edge link, four on a shared edge link and on a cross link), whose other links are
 * THE DATUM (ordered = identity, random:SEED = Haar, cancel = g41's cancelling quadruple on the first shared link's staples, free = staples off).
 * The representations are g41's (symmetric powers of the fundamental, the substitution checked at load); every plaquette weight is
 * w(V) = sum_{s <= WMAX} (s+1) a_s chi_{s/2}(V), a_s = I_{s+1}/I_1 (g41's convention); the coarse loops A and B carry representations a, c <= LMAX
 * as chains of matrices D^a(U^{+-1}) along their eight links, closed at the basepoint (0,0,0,0) through a junction: the identity for the class
 * moment E[chi_a(A) chi_c(B)], the projector P_k onto the spin-k channel of a (x) c for the relative-orientation moments f_k.
 * THE SWEEP IS MATRIX-FREE (the campaign's count): one state vector over the open wires of the ten cycles (eight plaquettes, two loops), each
 * link's tensor -- the Haar quadrature of the representation matrices on it against the product of its staples' weights, as g41's link tensors --
 * contracted into the state in turn, from face A's far column to face B's far column; a plaquette's spin becomes a block index when its first
 * link is processed and is summed with (s+1) a_s when its last is; the loops' spins are fixed per sweep.  The order can be reversed (rev) as an
 * internal consistency check; the KNOWN ANSWERS are the free object's (K1: W(A,B) = W(A) W(B) with E[chi_a(A)] = d_a a_a^4 and f_k/E = d_k/(d_a d_c);
 * K2: Z = 1) and the representation and projector identities at load.
 * usage: w2_strip beta WMAX LMAX DATUM [fwd|rev]      DATUM = free | ordered | random:SEED | cancel
 * build: gcc -O2 -fopenmp -o w2_strip.exe w2_strip.c -lm */
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
static double BETA; static int WMAX, LMAX, SMAX, FREE = 0, PLANAR = 0;
static double A[32], FAC[32]; static int DIM[32]; static double FACT[40];
static double now(void) {
#ifdef _OPENMP
  return omp_get_wtime();
#else
  return (double)clock() / CLOCKS_PER_SEC;
#endif
}
/* ---- quaternions and representations (g41's) */
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
/* ---- the quadrature rule (g41's) */
static int NPT; static quat *RU; static double *RW;
static void gauss_legendre(int n, double *x, double *w) { for (int i = 1; i <= n; i++) { double z = cos(PI * (i - 0.25) / (n + 0.5)), dp = 0;
    for (int it = 0; it < 200; it++) { double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2 * k - 1) * z * p1 - (k - 1) * p0) / k; p0 = p1; p1 = p2; } dp = n * (z * p1 - p0) / (z * z - 1); double z1 = z; z = z1 - p1 / dp; if (fabs(z - z1) < 1e-15) break; }
    double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2 * k - 1) * z * p1 - (k - 1) * p0) / k; p0 = p1; p1 = p2; } dp = n * (z * p1 - p0) / (z * z - 1); x[i - 1] = z; w[i - 1] = 2 / ((1 - z * z) * dp * dp); } }
static void make_rule(int deg) { int nth = (deg + 2) / 2, ngl = (deg + 2) / 2, naz = deg + 1; double gx[400], gw[400]; gauss_legendre(ngl, gx, gw);
  NPT = nth * ngl * naz; RU = malloc(sizeof(quat) * NPT); RW = malloc(sizeof(double) * NPT); int n = 0;
  for (int k = 1; k <= nth; k++) { double th = k * PI / (nth + 1), wt = 2 * sin(th) * sin(th) / (nth + 1);
    for (int j = 0; j < ngl; j++) { double t = gx[j], st = sqrt(1 - t * t);
      for (int l = 0; l < naz; l++) { double ph = 2 * PI * l / naz; quat u = { cos(th), sin(th) * st * cos(ph), sin(th) * st * sin(ph), sin(th) * t }; RU[n] = u; RW[n] = wt * gw[j] / 2 / naz; n++; } } } }
/* ---- the object: links, plaquettes, loops, staples, outside links */
static int NL = 0; static int LB[64][4], LD[64];                /* object links: base, direction (1..4) */
static int NOUT = 0; static int OB[400][4], OD[400];            /* outside links */
static int lkey(const int *b, int d, int create) { for (int i = 0; i < NL; i++) if (LD[i] == d && !memcmp(LB[i], b, sizeof(int) * 4)) return i; if (!create) return -1; memcpy(LB[NL], b, sizeof(int) * 4); LD[NL] = d; return NL++; }
static int okey(const int *b, int d) { for (int i = 0; i < NOUT; i++) if (OD[i] == d && !memcmp(OB[i], b, sizeof(int) * 4)) return i; memcpy(OB[NOUT], b, sizeof(int) * 4); OD[NOUT] = d; return NOUT++; }
#define NCYC 10
static int NSTEP[NCYC], STEPL[NCYC][8], STEPS[NCYC][8], ISLOOP[NCYC], NWIRE[NCYC], WBASE[NCYC]; static int NW = 0; static int WCYC[128];
static int PB[8][4], PD1[8], PD2[8];
static int NSTAP[64]; static int STAP[64][6][3][2];             /* per link, its staples, three outside links each: (index, sign) */
static int SHARED0 = -1;
static int is_obj_plaq(const int *b, int d1, int d2) { for (int p = 0; p < 8; p++) if (PD1[p] == d1 && PD2[p] == d2 && !memcmp(PB[p], b, sizeof(int) * 4)) return 1; return 0; }
static void add_plaq(int p, int x, int y, int z, int d1, int d2) { int b[4] = { x, y, z, 0 }; memcpy(PB[p], b, sizeof b); PD1[p] = d1; PD2[p] = d2;
  int q[4]; NSTEP[p] = 4; ISLOOP[p] = 0;
  STEPL[p][0] = lkey(b, d1, 1); STEPS[p][0] = 1;
  memcpy(q, b, sizeof q); q[d1 - 1]++; STEPL[p][1] = lkey(q, d2, 1); STEPS[p][1] = 1;
  memcpy(q, b, sizeof q); q[d2 - 1]++; STEPL[p][2] = lkey(q, d1, 1); STEPS[p][2] = -1;
  STEPL[p][3] = lkey(b, d2, 1); STEPS[p][3] = -1; }
static void add_loop_step(int c, int i, int x, int y, int z, int d, int sgn) { int b[4] = { x, y, z, 0 }; int l = lkey(b, d, 0); if (l < 0) { fprintf(stderr, "loop link (%d,%d,%d,%d) not an object link\n", x, y, z, d); exit(1); } STEPL[c][i] = l; STEPS[c][i] = sgn; }
static void build(void) {
  add_plaq(0, 1, 0, 0, 1, 2); add_plaq(1, 1, 1, 0, 1, 2); add_plaq(2, 0, 0, 0, 1, 2); add_plaq(3, 0, 1, 0, 1, 2);   /* face A: far column, near column */
  if (PLANAR) { add_plaq(4, -1, 0, 0, 1, 2); add_plaq(5, -1, 1, 0, 1, 2); add_plaq(6, -2, 0, 0, 1, 2); add_plaq(7, -2, 1, 0, 1, 2); }   /* the planar face B: x in [-2, 0] */
  else { add_plaq(4, 0, 0, 0, 2, 3); add_plaq(5, 0, 1, 0, 2, 3); add_plaq(6, 0, 0, 1, 2, 3); add_plaq(7, 0, 1, 1, 2, 3); }   /* face B: near column, far column */
  if (NL != 22) { fprintf(stderr, "object links: %d, not 22\n", NL); exit(1); }
  /* loop A around face A, based at the origin, counterclockwise in (x, y); loop B around face B, based at the origin, counterclockwise in (y, z) */
  NSTEP[8] = 8; ISLOOP[8] = 1; NSTEP[9] = 8; ISLOOP[9] = 1;
  add_loop_step(8, 0, 0, 0, 0, 1, 1); add_loop_step(8, 1, 1, 0, 0, 1, 1); add_loop_step(8, 2, 2, 0, 0, 2, 1); add_loop_step(8, 3, 2, 1, 0, 2, 1);
  add_loop_step(8, 4, 1, 2, 0, 1, -1); add_loop_step(8, 5, 0, 2, 0, 1, -1); add_loop_step(8, 6, 0, 1, 0, 2, -1); add_loop_step(8, 7, 0, 0, 0, 2, -1);
  if (PLANAR) {   /* loop B around [-2, 0] x [0, 2] in the xy-plane, based at the origin, counterclockwise: up the shared edge, then -x, then down, then +x */
    add_loop_step(9, 0, 0, 0, 0, 2, 1); add_loop_step(9, 1, 0, 1, 0, 2, 1); add_loop_step(9, 2, -1, 2, 0, 1, -1); add_loop_step(9, 3, -2, 2, 0, 1, -1);
    add_loop_step(9, 4, -2, 1, 0, 2, -1); add_loop_step(9, 5, -2, 0, 0, 2, -1); add_loop_step(9, 6, -2, 0, 0, 1, 1); add_loop_step(9, 7, -1, 0, 0, 1, 1); }
  else {
  add_loop_step(9, 0, 0, 0, 0, 2, 1); add_loop_step(9, 1, 0, 1, 0, 2, 1); add_loop_step(9, 2, 0, 2, 0, 3, 1); add_loop_step(9, 3, 0, 2, 1, 3, 1);
  add_loop_step(9, 4, 0, 1, 2, 2, -1); add_loop_step(9, 5, 0, 0, 2, 2, -1); add_loop_step(9, 6, 0, 0, 1, 3, -1); add_loop_step(9, 7, 0, 0, 0, 3, -1); }
  /* wires: a plaquette has 4 (cyclic), a loop 9 (wire 0 the junction's "in", wire 8 the junction's "out") */
  for (int c = 0; c < NCYC; c++) { NWIRE[c] = ISLOOP[c] ? NSTEP[c] + 1 : NSTEP[c]; WBASE[c] = NW; for (int i = 0; i < NWIRE[c]; i++) WCYC[NW + i] = c; NW += NWIRE[c]; }
  /* staples: for each object link (b, d), each k != d and side +-, the plaquette {d, k} at base b or b - e_k; an object plaquette is skipped */
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
  int n5 = 0, n4 = 0; for (int l = 0; l < NL; l++) { if (NSTAP[l] == 5) n5++; else if (NSTAP[l] == 4) n4++; else { fprintf(stderr, "link %d has %d staples\n", l, NSTAP[l]); exit(1); } }
  if (n5 != 12 || n4 != 10) { fprintf(stderr, "staple census %d five / %d four, not 12 / 10\n", n5, n4); exit(1); } }
static quat staple(int l, int k, const quat *dat) { quat T = { 1, 0, 0, 0 }; for (int j = 0; j < 3; j++) { quat V = dat[STAP[l][k][j][0]]; if (STAP[l][k][j][1] < 0) V = qinv(V); T = qmul(T, V); } return T; }
/* ---- slots: for each link, the (cycle, step) pairs using it */
static int NSLOT[64], SLC[64][4], SLS[64][4];
static void slots(void) { for (int l = 0; l < NL; l++) NSLOT[l] = 0; for (int c = 0; c < NCYC; c++) for (int i = 0; i < NSTEP[c]; i++) { int l = STEPL[c][i]; SLC[l][NSLOT[l]] = c; SLS[l][NSLOT[l]] = i; NSLOT[l]++; } }
static int win(int c, int i) { return WBASE[c] + i; }
static int wout(int c, int i) { return ISLOOP[c] ? WBASE[c] + i + 1 : WBASE[c] + (i + 1) % NSTEP[c]; }
/* ---- the representation matrices at every point, both orientations: R[pt][s][inv] = D^s(U^{+-1}), (s+1)x(s+1) row-major */
static cplx *RM; static size_t RSTR;
static cplx *rmat(int pt, int s, int inv) { return RM + ((size_t)pt * (SMAX + 1) * 2 + (size_t)s * 2 + inv) * RSTR; }
/* ---- the link tensors: per link, per spin block (mixed radix over its slots, radix cap+1 each: WMAX+1 for a plaquette, LMAX+1 for a loop), dense over (in_1,out_1,...,in_m,out_m) */
static cplx **LT[64]; static double *SW[64]; static int LCAP[64][4], LNBLK[64];
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
/* ---- the state: open wires in order, open plaquette cycles in order (their spins the block index), one dense block per spin assignment */
typedef struct { int nopen, open[64]; int ncyc, cyc[16]; int nblk; cplx **blk; size_t *size; } state_t;
static int LSPIN[NCYC];                                   /* the loops' fixed spins (a for cycle 8, c for cycle 9) */
static int in_list(int x, const int *L, int n) { for (int i = 0; i < n; i++) if (L[i] == x) return i; return -1; }
static void free_state(state_t *S) { for (int b = 0; b < S->nblk; b++) free(S->blk[b]); free(S->blk); free(S->size); }
/* process link l: contract its tensor into the state */
static void process(state_t *S, int l) {
  int m = NSLOT[l]; int sw[8], nsw = 0; for (int j = 0; j < m; j++) { sw[nsw++] = win(SLC[l][j], SLS[l][j]); sw[nsw++] = wout(SLC[l][j], SLS[l][j]); }
  int contracted[8], ncon = 0, newer[8], nnew = 0; for (int i = 0; i < nsw; i++) { if (in_list(sw[i], S->open, S->nopen) >= 0) contracted[ncon++] = sw[i]; else newer[nnew++] = sw[i]; }
  state_t N; N.nopen = 0; for (int i = 0; i < S->nopen; i++) if (in_list(S->open[i], contracted, ncon) < 0) N.open[N.nopen++] = S->open[i]; for (int i = 0; i < nnew; i++) N.open[N.nopen++] = newer[i];
  /* the open plaquette cycles after: those with a wire in N.open, the old order kept, the newly opened appended */
  N.ncyc = 0; for (int i = 0; i < S->ncyc; i++) { int c = S->cyc[i], has = 0; for (int w = 0; w < N.nopen; w++) if (WCYC[N.open[w]] == c) has = 1; if (has) N.cyc[N.ncyc++] = c; }
  for (int w = 0; w < N.nopen; w++) { int c = WCYC[N.open[w]]; if (ISLOOP[c]) continue; if (in_list(c, N.cyc, N.ncyc) < 0) N.cyc[N.ncyc++] = c; }
  int closed[16], nclosed = 0; for (int i = 0; i < S->ncyc; i++) if (in_list(S->cyc[i], N.cyc, N.ncyc) < 0) closed[nclosed++] = S->cyc[i];
  N.nblk = 1; for (int i = 0; i < N.ncyc; i++) N.nblk *= WMAX + 1; N.blk = calloc(N.nblk, sizeof(cplx *)); N.size = calloc(N.nblk, sizeof(size_t));
  int nclblk = 1; for (int i = 0; i < nclosed; i++) nclblk *= WMAX + 1;
  for (int bn = 0; bn < N.nblk; bn++) {
    int spin[NCYC]; for (int c = 0; c < NCYC; c++) spin[c] = ISLOOP[c] ? LSPIN[c] : -1;
    { int bb = bn; for (int i = 0; i < N.ncyc; i++) { spin[N.cyc[i]] = bb % (WMAX + 1); bb /= WMAX + 1; } }
    /* the new block's dims and size */
    int ndim[64]; size_t nsize = 1; for (int w = 0; w < N.nopen; w++) { ndim[w] = DIM[spin[WCYC[N.open[w]]]]; nsize *= ndim[w]; }
    cplx *NB = calloc(nsize, sizeof(cplx)); N.blk[bn] = NB; N.size[bn] = nsize;
    for (int bc = 0; bc < nclblk; bc++) {
      double fw = 1; { int bb = bc; for (int i = 0; i < nclosed; i++) { int s = bb % (WMAX + 1); bb /= WMAX + 1; spin[closed[i]] = s; fw *= FAC[s]; } }
      if (fw == 0) continue;
      /* every slot cycle's spin is now known (open after, closed here, or a loop); the old block, the tensor block */
      int bo = 0; { int mul = 1; for (int i = 0; i < S->ncyc; i++) { bo += spin[S->cyc[i]] * mul; mul *= WMAX + 1; } }
      int bt = 0; { int mul = 1; for (int j = 0; j < m; j++) { bt += spin[SLC[l][j]] * mul; mul *= LCAP[l][j] + 1; } }
      const cplx *OB_ = S->blk[bo]; const cplx *TB = LT[l][bt]; if (!OB_ || !TB) continue;
      /* strides: old block over S->open, tensor over sw (slot order), new over N.open; dims by spins */
      size_t ostr[64], tstr[8]; { size_t mul = 1; for (int i = S->nopen - 1; i >= 0; i--) { ostr[i] = mul; mul *= DIM[spin[WCYC[S->open[i]]]]; } }
      { size_t mul = 1; for (int i = nsw - 1; i >= 0; i--) { tstr[i] = mul; mul *= DIM[spin[WCYC[sw[i]]]]; } }
      /* each new wire: its dim, its old stride (0 if not old), its tensor stride (0 if not a slot wire); each contracted wire: dim, old stride, tensor stride */
      size_t nos[64], nts[64]; for (int w = 0; w < N.nopen; w++) { int io = in_list(N.open[w], S->open, S->nopen), it = in_list(N.open[w], sw, nsw); nos[w] = io >= 0 ? ostr[io] : 0; nts[w] = it >= 0 ? tstr[it] : 0; }
      int cdim[8]; size_t cos_[8], cts[8]; for (int i = 0; i < ncon; i++) { int io = in_list(contracted[i], S->open, S->nopen), it = in_list(contracted[i], sw, nsw); cdim[i] = DIM[spin[WCYC[contracted[i]]]]; cos_[i] = ostr[io]; cts[i] = tstr[it]; }
      size_t ncomb = 1; for (int i = 0; i < ncon; i++) ncomb *= cdim[i];
      #pragma omp parallel for schedule(static)
      for (long long e = 0; e < (long long)nsize; e++) { size_t rem = e, oo = 0, to = 0; for (int w = N.nopen - 1; w >= 0; w--) { size_t ix = rem % ndim[w]; rem /= ndim[w]; oo += ix * nos[w]; to += ix * nts[w]; }
        cplx acc = 0; size_t ci[8] = {0};
        for (size_t q = 0; q < ncomb; q++) { size_t o2 = oo, t2 = to; for (int i = 0; i < ncon; i++) { o2 += ci[i] * cos_[i]; t2 += ci[i] * cts[i]; } acc += OB_[o2] * TB[t2];
          for (int i = ncon - 1; i >= 0; i--) { if (++ci[i] < (size_t)cdim[i]) break; ci[i] = 0; } }
        NB[e] += fw * acc; } } }
  free_state(S); *S = N; }
/* ---- the projector P_k on a (x) c: P[(q q'),(r r')] = d_k int chi_k(g) D^a(g)_{q r} D^c(g)_{q' r'}; by the rule, exact at degree a + c + k */
static void projector(int a, int c, int k, cplx *P) { int da = DIM[a], dc = DIM[c]; size_t n = (size_t)da * dc; memset(P, 0, sizeof(cplx) * n * n); cplx Ra[64], Rc[64];
  for (int pt = 0; pt < NPT; pt++) { double w = RW[pt] * DIM[k] * chi(k, RU[pt]); rep(a, RU[pt], Ra); rep(c, RU[pt], Rc);
    for (int q = 0; q < da; q++) for (int qp = 0; qp < dc; qp++) for (int r = 0; r < da; r++) for (int rp = 0; rp < dc; rp++) P[((size_t)q * dc + qp) * n + (size_t)r * dc + rp] += w * Ra[q * da + r] * Rc[qp * dc + rp]; } }
int main(int argc, char **argv) {
  if (argc < 5) { fprintf(stderr, "usage: w2_strip beta WMAX LMAX DATUM [fwd|rev] [planar]   DATUM = free | ordered | random:SEED | cancel\n"); return 1; }
  BETA = atof(argv[1]); WMAX = atoi(argv[2]); LMAX = atoi(argv[3]); const char *datum = argv[4]; int rev = (argc > 5 && !strcmp(argv[5], "rev"));
  if (WMAX > 15 || LMAX > 15 || WMAX < 0 || LMAX < 0) { fprintf(stderr, "caps out of range\n"); return 1; }
  PLANAR = (argc > 6 && !strcmp(argv[6], "planar"));
  SMAX = WMAX > LMAX ? WMAX : LMAX; FREE = !strcmp(datum, "free");
  FACT[0] = 1; for (int i = 1; i < 40; i++) FACT[i] = FACT[i - 1] * i;
  for (int s = 0; s <= 30; s++) { A[s] = bessel(s + 1, BETA) / bessel(1, BETA); DIM[s] = s + 1; FAC[s] = (s <= WMAX) ? (s + 1) * A[s] : 0; }
  double t0 = now();
  /* representation KAT (g41's): the substitution that composes as a homomorphism, traces = chi */
  { quat q1 = {0.5, 0.5, 0.5, 0.5}, q2 = {1 / sqrt(2), 0, 1 / sqrt(2), 0}, q3 = {0.6, 0, 0.8, 0}; quat q12 = qmul(q1, q2); int bad = 0;
    for (int trial = 0; trial < 2; trial++) { GENINV = trial; double dmax = 0; for (int s = 1; s <= SMAX; s++) { int d = s + 1; cplx P[256], X1[256], X2[256], Y[256]; rep(s, q12, P); rep(s, q1, X1); rep(s, q2, X2);
        for (int i = 0; i < d; i++) for (int j = 0; j < d; j++) { cplx acc = 0; for (int k = 0; k < d; k++) acc += X1[i * d + k] * X2[k * d + j]; Y[i * d + j] = acc; }
        for (int i = 0; i < d * d; i++) if (cabs(Y[i] - P[i]) > dmax) dmax = cabs(Y[i] - P[i]); }
      if (dmax < 1e-12) break; if (trial == 1) { fprintf(stderr, "neither substitution composes\n"); return 1; } }
    for (int s = 0; s <= SMAX; s++) { int d = s + 1; cplx X[256]; rep(s, q3, X); cplx tr = 0; for (int i = 0; i < d; i++) tr += X[i * d + i]; if (fabs(creal(tr) - chi(s, q3)) > 1e-12 || fabs(cimag(tr)) > 1e-12) bad++; }
    printf("W2-KAT representations to spin %d/2 (GENINV=%d): homomorphism and traces [%s]\n", SMAX, GENINV, bad ? "FAILED" : "MET"); if (bad) return 1; }
  build(); slots();
  /* the rule: exact at the largest integrand degree, the slots' spins plus WMAX per staple */
  int deg = 0; for (int l = 0; l < NL; l++) { int d = NSTAP[l] * WMAX; for (int j = 0; j < NSLOT[l]; j++) d += cap_of(SLC[l][j]); if (d > deg) deg = d; } if (deg < 12) deg = 12; make_rule(deg);
  printf("W2-OBJECT %s links=%d (shared=%d) outside=%d staples five/four by census; rule degree %d, %d points; beta=%g WMAX=%d LMAX=%d datum=%s order=%s\n", PLANAR ? "planar" : "bent", NL, SHARED0, NOUT, deg, NPT, BETA, WMAX, LMAX, datum, rev ? "rev" : "fwd");
  /* the datum */
  quat *DATA = malloc(sizeof(quat) * (NOUT + 1)); for (int i = 0; i < NOUT; i++) { quat e = { 1, 0, 0, 0 }; DATA[i] = e; }
  if (!strcmp(datum, "cancel")) { quat want[4] = { {1,0,0,0}, {-1,0,0,0}, {0,1,0,0}, {0,-1,0,0} }; if (NSTAP[SHARED0] != 4) { fprintf(stderr, "the shared link has %d staples, not 4\n", NSTAP[SHARED0]); return 1; } for (int k = 0; k < 4; k++) DATA[STAP[SHARED0][k][1][0]] = qinv(want[k]); }
  else if (!strncmp(datum, "random:", 7)) { srand(atoi(datum + 7)); for (int i = 0; i < NOUT; i++) { double g[4], n = 0; for (int j = 0; j < 4; j++) { double u1 = (rand() + 1.0) / (RAND_MAX + 2.0), u2 = rand() / (RAND_MAX + 1.0); g[j] = sqrt(-2 * log(u1)) * cos(2 * PI * u2); n += g[j] * g[j]; } n = sqrt(n); quat q = { g[0] / n, g[1] / n, g[2] / n, g[3] / n }; DATA[i] = q; } }
  else if (strcmp(datum, "ordered") && strcmp(datum, "free")) { fprintf(stderr, "unknown datum %s\n", datum); return 1; }
  /* the representation matrices at every point */
  RSTR = (size_t)(SMAX + 1) * (SMAX + 1); RM = malloc(sizeof(cplx) * (size_t)NPT * (SMAX + 1) * 2 * RSTR);
  #pragma omp parallel for schedule(static)
  for (int pt = 0; pt < NPT; pt++) for (int s = 0; s <= SMAX; s++) { rep(s, RU[pt], rmat(pt, s, 0)); rep(s, qinv(RU[pt]), rmat(pt, s, 1)); }
  /* the link tensors */
  for (int l = 0; l < NL; l++) link_tensor(l, DATA);
  printf("W2-TENSORS built in %.1f s\n", now() - t0);
  /* the processing order: face A's far column (private links), the A cut, A's near column (private), the shared links, then B's links in loop B's chain order (B[2], the near cross, the B cut, B[3], B[4], the far cross, B[5], B[6], and B[7] last) so that every cycle, loop or plaquette, has at most two open wires at any moment */
  int order[22], no = 0; { int seqp[22][4] = { {1,0,0,1},{2,0,0,2},{1,1,0,1},{2,1,0,2},{1,2,0,1}, {1,0,0,2},{1,1,0,2}, {0,0,0,1},{0,1,0,1},{0,2,0,1}, {0,1,0,2},{0,0,0,2},
      {-1,2,0,1},{-1,1,0,1}, {-1,0,0,2},{-1,1,0,2}, {-2,2,0,1},{-2,1,0,2},{-2,1,0,1},{-2,0,0,2},{-2,0,0,1},{-1,0,0,1} };
    int seq[22][4] = { {1,0,0,1},{2,0,0,2},{1,1,0,1},{2,1,0,2},{1,2,0,1}, {1,0,0,2},{1,1,0,2}, {0,0,0,1},{0,1,0,1},{0,2,0,1}, {0,1,0,2},{0,0,0,2},
      {0,2,0,3},{0,1,0,3}, {0,0,1,2},{0,1,1,2}, {0,2,1,3},{0,1,2,2},{0,1,1,3},{0,0,2,2},{0,0,1,3},{0,0,0,3} };
    if (PLANAR) memcpy(seq, seqp, sizeof seq);
    for (int i = 0; i < 22; i++) { int b[4] = { seq[i][0], seq[i][1], seq[i][2], 0 }; int l = lkey(b, seq[i][3], 0); if (l < 0) { fprintf(stderr, "order link %d missing\n", i); return 1; } if (in_list(l, order, no) >= 0) { fprintf(stderr, "order repeats link %d\n", l); return 1; } order[no++] = l; }
    if (no != 22) return 1; if (rev) for (int i = 0; i < 11; i++) { int t = order[i]; order[i] = order[21 - i]; order[21 - i] = t; } }
  /* the sweeps: one per (a, c); the junction wires at the end */
  int wAin = win(8, 0), wAout = wout(8, 7), wBin = win(9, 0), wBout = wout(9, 7);
  double Z = 0; static double CLS[16][16];
  for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= LMAX; c++) { double ts = now(); LSPIN[8] = a; LSPIN[9] = c;
    state_t S; S.nopen = 0; S.ncyc = 0; S.nblk = 1; S.blk = calloc(1, sizeof(cplx *)); S.size = calloc(1, sizeof(size_t)); S.blk[0] = calloc(1, sizeof(cplx)); S.blk[0][0] = 1; S.size[0] = 1;
    size_t maxstate = 1; for (int i = 0; i < 22; i++) { process(&S, order[i]); size_t tot = 0; for (int b = 0; b < S.nblk; b++) tot += S.size[b]; if (tot > maxstate) maxstate = tot; }
    if (S.ncyc != 0 || S.nblk != 1) { fprintf(stderr, "plaquette cycles still open at the end\n"); return 1; }
    int da = DIM[a], dc = DIM[c]; int pos[4] = { in_list(wAin, S.open, S.nopen), in_list(wAout, S.open, S.nopen), in_list(wBin, S.open, S.nopen), in_list(wBout, S.open, S.nopen) };
    for (int i = 0; i < 4; i++) if (pos[i] < 0 && !((i < 2 && a == 0) || (i >= 2 && c == 0))) { fprintf(stderr, "junction wire %d not open at the end\n", i); return 1; }
    if (S.nopen != 4) { fprintf(stderr, "%d open wires at the end, not 4\n", S.nopen); return 1; }
    size_t str[4]; { size_t mul = 1; int dims[4]; for (int i = 0; i < 4; i++) dims[i] = DIM[LSPIN[WCYC[S.open[i]]]]; for (int i = 3; i >= 0; i--) { str[i] = mul; mul *= dims[i]; } }
    size_t sA_in = str[pos[0]], sA_out = str[pos[1]], sB_in = str[pos[2]], sB_out = str[pos[3]];
    const cplx *F = S.blk[0];
    /* the class moment: in = out on both chains */
    cplx cls = 0; for (int r = 0; r < da; r++) for (int rp = 0; rp < dc; rp++) cls += F[r * sA_in + r * sA_out + rp * sB_in + rp * sB_out];
    if (a == 0 && c == 0) Z = creal(cls);
    CLS[a][c] = creal(cls) / Z;
    printf("W2-CLASS a=%d c=%d E[chi_a(A) chi_c(B)] = %+.12e (imag %.1e; max state %zu; %.1f s)\n", a, c, creal(cls) / Z, cimag(cls) / Z, maxstate, now() - ts);
    /* the channels k in a (x) c */
    if (a > 0 && c > 0) { size_t n = (size_t)da * dc; cplx *P = malloc(sizeof(cplx) * n * n), *Psum = calloc(n * n, sizeof(cplx)); double chsum = 0;
      for (int k = abs(a - c); k <= a + c; k += 2) { projector(a, c, k, P); for (size_t i = 0; i < n * n; i++) Psum[i] += P[i];
        double idem = 0; for (size_t i = 0; i < n; i++) for (size_t j = 0; j < n; j++) { cplx acc = 0; for (size_t q = 0; q < n; q++) acc += P[i * n + q] * P[q * n + j]; if (cabs(acc - P[i * n + j]) > idem) idem = cabs(acc - P[i * n + j]); }
        cplx f = 0; for (int q = 0; q < da; q++) for (int qp = 0; qp < dc; qp++) for (int r = 0; r < da; r++) for (int rp = 0; rp < dc; rp++) f += P[((size_t)q * dc + qp) * n + (size_t)r * dc + rp] * F[r * sA_in + q * sA_out + rp * sB_in + qp * sB_out];
        chsum += creal(f) / Z;
        printf("W2-CHANNEL a=%d c=%d k=%d f_k = %+.12e (imag %.1e; P_k idempotent to %.1e; f_k/E = %.9f, free law d_k/(d_a d_c) = %.9f)\n", a, c, k, creal(f) / Z, cimag(f) / Z, idem, creal(f) / Z / CLS[a][c], (double)DIM[k] / (da * dc)); }
      double pid = 0; for (size_t i = 0; i < n; i++) for (size_t j = 0; j < n; j++) { cplx want = (i == j) ? 1 : 0; if (cabs(Psum[i * n + j] - want) > pid) pid = cabs(Psum[i * n + j] - want); }
      printf("W2-CHANNEL-SUM a=%d c=%d sum_k f_k = %+.12e against the class moment %+.12e (sum_k P_k = 1 to %.1e)\n", a, c, chsum, CLS[a][c], pid); free(P); free(Psum); }
    free_state(&S); }
  printf("W2-Z beta=%g datum=%s Z = %.12e\n", BETA, datum, Z);
  /* the connected table and the free object's known answers */
  int badfree = 0; for (int a = 0; a <= LMAX; a++) for (int c = 0; c <= LMAX; c++) { double conn = CLS[a][c] - CLS[a][0] * CLS[0][c];
    printf("W2-CONN a=%d c=%d <chi_a chi_c>_c = %+.12e (marginals %+.9e, %+.9e)\n", a, c, conn, CLS[a][0], CLS[0][c]);
    if (FREE) { double wantA = (a <= WMAX) ? DIM[a] * pow(A[a], 4) : 0; if (fabs(CLS[a][0] - wantA) > 1e-9 * (1 + fabs(wantA)) || fabs(conn) > 1e-9) badfree++; } }
  if (FREE) printf("W2-KAT FREE: Z = 1 [%s]; E[chi_a(A)] = d_a a_a^4 and every connected pair zero [%s]\n", fabs(Z - 1) < 1e-9 ? "MET" : "FAILED", badfree ? "FAILED" : "MET");
  printf("W2-DONE %.1f s\n", now() - t0); return 0; }
