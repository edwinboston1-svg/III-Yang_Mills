/* cup_box.c -- THE NECK'S SECOND INSTANCE, EXACT: the box L x 1 x 1 whose bottom L faces are the wall (spin k) and whose other faces are the
 * cup (spin j), with the leaf's continuation at the bottom's boundary links (2L + 2 legs at spin ½, their index pairs open); the Haar integral
 * over the box's links by the wire method, the tensor over the legs' index pairs, its Frobenius norm against the uniform assignment (the cup at
 * ½, the wall at 1).  cup_amp.c is the case L = 1 (its ratio (d_½/d_j)^4, one power per attachment link); here L = 2 has six attachment links
 * and a two-plaquette wall with one interior link -- the test of the general form (d_½/d_j)^{|boundary links of the wall|}.
 * usage: cup_box L J2 K2 [LEG2]    build: gcc -O2 -o cup_box.exe cup_box.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
typedef double complex cplx;
#define PI 3.141592653589793
static int SMAX; static int DIM[32]; static double FACT[40];
typedef struct { double w, x, y, z; } quat;
static quat qinv(quat a) { quat r = { a.w, -a.x, -a.y, -a.z }; return r; }
static int GENINV = 1;
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
#define MAXL 64
#define MAXC 40
static int NL = 0; static int LB[MAXL][3], LD[MAXL];
static int lkey(int x, int y, int z, int d, int create) { for (int i = 0; i < NL; i++) if (LD[i] == d && LB[i][0] == x && LB[i][1] == y && LB[i][2] == z) return i; if (!create) return -1; LB[NL][0] = x; LB[NL][1] = y; LB[NL][2] = z; LD[NL] = d; return NL++; }
static int NCYC = 0; static int NSTEP[MAXC], STEPL[MAXC][4], STEPS[MAXC][4], OPENC[MAXC], NWIRE[MAXC], WBASE[MAXC], SPIN[MAXC]; static int NW = 0; static int WCYC[256];
static int add_face(int x, int y, int z, int d1, int d2, int spin) { int c = NCYC++; int q[3]; NSTEP[c] = 4; OPENC[c] = 0; SPIN[c] = spin;
  STEPL[c][0] = lkey(x, y, z, d1, 1); STEPS[c][0] = 1;
  q[0] = x; q[1] = y; q[2] = z; q[d1 - 1]++; STEPL[c][1] = lkey(q[0], q[1], q[2], d2, 1); STEPS[c][1] = 1;
  q[0] = x; q[1] = y; q[2] = z; q[d2 - 1]++; STEPL[c][2] = lkey(q[0], q[1], q[2], d1, 1); STEPS[c][2] = -1;
  STEPL[c][3] = lkey(x, y, z, d2, 1); STEPS[c][3] = -1; return c; }
static int add_leg(int l, int spin) { int c = NCYC++; NSTEP[c] = 1; OPENC[c] = 1; STEPL[c][0] = l; STEPS[c][0] = 1; SPIN[c] = spin; return c; }
static int NSLOT[MAXL], SLC[MAXL][6], SLS[MAXL][6];
static int win(int c, int i) { return WBASE[c] + i; }
static int wout(int c, int i) { return OPENC[c] ? WBASE[c] + i + 1 : WBASE[c] + (i + 1) % NSTEP[c]; }
static cplx *RM; static size_t RSTR;
static cplx *rmat(int pt, int s, int inv) { return RM + ((size_t)pt * (SMAX + 1) * 2 + (size_t)s * 2 + inv) * RSTR; }
static cplx *LT[MAXL];
/* THE FIXED LEGS (07:5x): CUP_FIX=k takes the first k legs (link order) out of the state -- their index pair (a, b) is set by an outer loop
 * over all d_leg^{2k} values and the leg's factor D^{leg}(U)_{ab} multiplies the link's weight; |T|_F^2 is the sum of the runs' squares, an
 * EXACT split (every run is a slice of the same tensor), so the peak state falls by d_leg^{2k} at the price of d_leg^{2k} runs.  Controls:
 * every k reads the same norm (L = 1, 2 to the digit). */
static int NFIX = 0, NFIXREQ = 0, FIXL[16], FIXA[16], FIXB[16], FIXS = 1, ISLEG[MAXL];
static int fixidx(int l) { for (int f = 0; f < NFIX; f++) if (FIXL[f] == l) return f; return -1; }
static void link_tensor(int l) { int m = NSLOT[l]; size_t size = 1; int sp[6], dd[6]; for (int j = 0; j < m; j++) { sp[j] = SPIN[SLC[l][j]]; dd[j] = DIM[sp[j]] * DIM[sp[j]]; size *= dd[j]; }
  cplx *B = calloc(size, sizeof(cplx)); LT[l] = B; size_t str[6]; { size_t mul = 1; for (int j = m - 1; j >= 0; j--) { str[j] = mul; mul *= dd[j]; } }
  for (int pt = 0; pt < NPT; pt++) { cplx w = RW[pt]; int fx = fixidx(l); if (fx >= 0) w *= rmat(pt, FIXS, 0)[FIXA[fx] * (FIXS + 1) + FIXB[fx]]; const cplx *R[6]; for (int j = 0; j < m; j++) R[j] = rmat(pt, sp[j], STEPS[SLC[l][j]][SLS[l][j]] < 0);
    int ix[6] = {0}; for (size_t e = 0; e < size; e++) { cplx f = w; for (int j = 0; j < m; j++) f *= R[j][ix[j]]; B[e] += f; for (int j = m - 1; j >= 0; j--) { if (++ix[j] < dd[j]) break; ix[j] = 0; } } } }
typedef struct { int nopen, open[256]; size_t size; cplx *v; } state_t;
static int in_list(int x, const int *L, int n) { for (int i = 0; i < n; i++) if (L[i] == x) return i; return -1; }
static void process(state_t *S, int l) {
  int m = NSLOT[l]; int sw[12], nsw = 0; for (int j = 0; j < m; j++) { sw[nsw++] = win(SLC[l][j], SLS[l][j]); sw[nsw++] = wout(SLC[l][j], SLS[l][j]); }
  int contracted[12], ncon = 0, newer[12], nnew = 0; for (int i = 0; i < nsw; i++) { if (in_list(sw[i], S->open, S->nopen) >= 0) contracted[ncon++] = sw[i]; else newer[nnew++] = sw[i]; }
  state_t N; N.nopen = 0; for (int i = 0; i < S->nopen; i++) if (in_list(S->open[i], contracted, ncon) < 0) N.open[N.nopen++] = S->open[i]; for (int i = 0; i < nnew; i++) N.open[N.nopen++] = newer[i];
  int ndim[256]; size_t nsize = 1; for (int w = 0; w < N.nopen; w++) { ndim[w] = DIM[SPIN[WCYC[N.open[w]]]]; nsize *= ndim[w]; }
  cplx *NB = calloc(nsize, sizeof(cplx)); if (!NB) { fprintf(stderr, "out of memory at %zu\n", nsize); exit(3); } N.size = nsize; N.v = NB;
  size_t ostr[256], tstr[12]; { size_t mul = 1; for (int i = S->nopen - 1; i >= 0; i--) { ostr[i] = mul; mul *= DIM[SPIN[WCYC[S->open[i]]]]; } }
  { size_t mul = 1; for (int i = nsw - 1; i >= 0; i--) { tstr[i] = mul; mul *= DIM[SPIN[WCYC[sw[i]]]]; } }
  size_t nos[256], nts[256]; for (int w = 0; w < N.nopen; w++) { int io = in_list(N.open[w], S->open, S->nopen), it = in_list(N.open[w], sw, nsw); nos[w] = io >= 0 ? ostr[io] : 0; nts[w] = it >= 0 ? tstr[it] : 0; }
  int cdim[12]; size_t cos_[12], cts[12]; for (int i = 0; i < ncon; i++) { int io = in_list(contracted[i], S->open, S->nopen), it = in_list(contracted[i], sw, nsw); cdim[i] = DIM[SPIN[WCYC[contracted[i]]]]; cos_[i] = ostr[io]; cts[i] = tstr[it]; }
  size_t ncomb = 1; for (int i = 0; i < ncon; i++) ncomb *= cdim[i];
  for (size_t e = 0; e < nsize; e++) { size_t rem = e, oo = 0, to = 0; for (int w = N.nopen - 1; w >= 0; w--) { size_t ix = rem % ndim[w]; rem /= ndim[w]; oo += ix * nos[w]; to += ix * nts[w]; }
    cplx acc = 0; size_t ci[12] = {0};
    for (size_t q = 0; q < ncomb; q++) { size_t o2 = oo, t2 = to; for (int i = 0; i < ncon; i++) { o2 += ci[i] * cos_[i]; t2 += ci[i] * cts[i]; } acc += S->v[o2] * LT[l][t2];
      for (int i = ncon - 1; i >= 0; i--) { if (++ci[i] < (size_t)cdim[i]) break; ci[i] = 0; } }
    NB[e] = acc; }
  free(S->v); *S = N; }
static size_t MAXST;
static double run_case(int L, int j2, int k2, int leg2, double *maxent, int *nlegs) {
  NL = 0; NW = 0; NCYC = 0; NFIX = 0; FIXS = leg2; for (int l = 0; l < MAXL; l++) ISLEG[l] = 0;
  /* the box [0,L] x [0,1] x [0,1]: bottom faces (the wall) at z = 0 for x = 0..L-1; the cup: top, front (y = 0), back (y = 1), left (x = 0), right (x = L) */
  int bump = getenv("CUP_BUMP") != NULL, ends = getenv("CUP_ENDS") != NULL, nwall;
  if (ends) {
    /* CUP_ENDS, THE TUBE (09:0x): the walls are the two END faces x = 0 and x = L at spin k, the cup the four long sides (bottom, top, front,
     * back) over x = 0..L-1 at spin j -- an ANNULUS, chi = 0 -- and the legs the two walls' eight boundary links; at L = 3 the cup's d^{chi - n}
     * reads 2^-12, "per wall link" 2^-8, "plaquettes + boundary links - 1" 2^-9: the three laws part three ways on one run. */
    add_face(0, 0, 0, 2, 3, k2); add_face(L, 0, 0, 2, 3, k2); nwall = 2;
    for (int x = 0; x < L; x++) { add_face(x, 0, 0, 1, 2, j2); add_face(x, 0, 1, 1, 2, j2); add_face(x, 0, 0, 1, 3, j2); add_face(x, 1, 0, 1, 3, j2); }
  } else {
    for (int x = 0; x < L; x++) add_face(x, 0, 0, 1, 2, k2); nwall = L;
    /* CUP_BUMP (08:2x): the top face over x = 0 replaced by a unit cube's five faces -- four more cup faces, the wall and its links unchanged;
     * parts "one power per wall link" (exponent 3L + 1 either way) from the cup's own d^{chi - n} (exponent 3L + 5) */
    for (int x = 0; x < L; x++) { if (!(bump && x == 0)) add_face(x, 0, 1, 1, 2, j2); add_face(x, 0, 0, 1, 3, j2); add_face(x, 1, 0, 1, 3, j2); }
    if (bump) { add_face(0, 0, 1, 1, 3, j2); add_face(0, 1, 1, 1, 3, j2); add_face(0, 0, 1, 2, 3, j2); add_face(1, 0, 1, 2, 3, j2); add_face(0, 0, 2, 1, 2, j2); }
    add_face(0, 0, 0, 2, 3, j2); add_face(L, 0, 0, 2, 3, j2); }
  /* the legs: every link that lies in exactly one WALL face (the wall faces are the first nwall cycles), at spin leg2 */
  int nleg = 0; if (leg2 > 0) for (int l = 0; l < NL; l++) { int cnt = 0; for (int c = 0; c < nwall; c++) for (int i = 0; i < 4; i++) if (STEPL[c][i] == l) cnt++; if (cnt == 1) { ISLEG[l] = 1; if (NFIX < NFIXREQ) FIXL[NFIX++] = l; else add_leg(l, leg2); nleg++; } }
  *nlegs = nleg;
  for (int c = 0; c < NCYC; c++) { NWIRE[c] = OPENC[c] ? NSTEP[c] + 1 : NSTEP[c]; WBASE[c] = NW; for (int i = 0; i < NWIRE[c]; i++) WCYC[NW + i] = c; NW += NWIRE[c]; }
  for (int l = 0; l < NL; l++) NSLOT[l] = 0; for (int c = 0; c < NCYC; c++) for (int i = 0; i < NSTEP[c]; i++) { int l = STEPL[c][i]; SLC[l][NSLOT[l]] = c; SLS[l][NSLOT[l]] = i; NSLOT[l]++; }
  for (int l = 0; l < NL; l++) link_tensor(l);
  state_t S; S.nopen = 0; S.size = 1; S.v = calloc(1, sizeof(cplx)); S.v[0] = 1;
  /* the order (07:3x): A SWEEP ALONG x -- every link keyed by 2x + [the link runs along x], ascending, so the cut between x = a and a + 1 leaves
   * open the four faces straddling it (two wires each) and the legs behind it; the top-first order opened every side face's two wires at once,
   * 4^16 = 2^32 states at L = 3 with the cup at 3/2 (its own refusal, cup_box_L3.2026-11-01a.txt). The order moves no number: L = 1, 2 re-read to the digit.
   * Within a key the LEGS GO LAST (07:5x): a leg's two wires stay open to the end, so it is opened as late as its slab allows, and at the far
   * end the end face opens only after the top and the sides have closed -- the x-sweep's peak 4^8 · 2^{2·legs} (2^32 at L = 3) falls by 2^2..2^3. */
  /* CUP_ORDER=z (08:4x): the sweep along z instead -- key 2z + [the link runs along z]; the wall closes inside its own slab and the cut
   * between z-planes crosses the side faces only (four at L = 1, 2L + 2 in general), so a TALL object (the bump) is cheap where the x-sweep,
   * built for a LONG box, opens every face across the x = 0 | 1 cut at L = 1. The order moves no number (controls below). */
  int zorder = getenv("CUP_ORDER") != NULL && getenv("CUP_ORDER")[0] == 'z';
  int order[MAXL], no = 0; for (int key = 0; key <= (zorder ? 5 : 2 * L + 1); key++) for (int pass = 0; pass < 2; pass++) for (int l = 0; l < NL; l++) if ((zorder ? 2 * LB[l][2] + (LD[l] == 3) : 2 * LB[l][0] + (LD[l] == 1)) == key && ISLEG[l] == pass) order[no++] = l;
  if (no != NL) { fprintf(stderr, "order %d of %d\n", no, NL); exit(1); }
  size_t maxst = 1; int trace = getenv("CUP_TRACE") != NULL; for (int i = 0; i < NL; i++) { process(&S, order[i]); if (S.size > maxst) maxst = S.size; if (trace) fprintf(stderr, "trace %2d link %2d at (%d,%d,%d) dir %d: state %zu open %d\n", i, order[i], LB[order[i]][0], LB[order[i]][1], LB[order[i]][2], LD[order[i]], S.size, S.nopen); } MAXST = maxst;
  double nrm = 0, mx = 0; for (size_t e = 0; e < S.size; e++) { double a = cabs(S.v[e]); nrm += a * a; if (a > mx) mx = a; }
  for (int l = 0; l < NL; l++) free(LT[l]); free(S.v); *maxent = mx; return sqrt(nrm); }
int main(int argc, char **argv) {
  if (argc < 4) { fprintf(stderr, "usage: cup_box L J2 K2 [LEG2]\n"); return 1; }
  int L = atoi(argv[1]), j2 = atoi(argv[2]), k2 = atoi(argv[3]), leg2 = argc > 4 ? atoi(argv[4]) : 1;
  FACT[0] = 1; for (int i = 1; i < 40; i++) FACT[i] = FACT[i - 1] * i; for (int s = 0; s < 32; s++) DIM[s] = s + 1;
  SMAX = 8; RSTR = (size_t)(SMAX + 1) * (SMAX + 1); make_rule(2 * (j2 > k2 ? j2 : k2) + leg2 + 2 > 12 ? 2 * (j2 > k2 ? j2 : k2) + leg2 + 2 : 12);
  RM = malloc(sizeof(cplx) * (size_t)NPT * (SMAX + 1) * 2 * RSTR);
  for (int pt = 0; pt < NPT; pt++) for (int s = 0; s <= SMAX; s++) { rep(s, RU[pt], rmat(pt, s, 0)); rep(s, qinv(RU[pt]), rmat(pt, s, 1)); }
  NFIXREQ = getenv("CUP_FIX") ? atoi(getenv("CUP_FIX")) : 0; if (leg2 == 0) NFIXREQ = 0; if (NFIXREQ > 16) NFIXREQ = 16;
  int dl = DIM[leg2]; long ncomb = 1; for (int f = 0; f < NFIXREQ; f++) ncomb *= dl * dl;
  double mx = 0, nrm2 = 0; int nl = 0; size_t maxst_all = 0;
  for (long combo = 0; combo < ncomb; combo++) { long r = combo; for (int f = 0; f < NFIXREQ; f++) { FIXA[f] = r % dl; r /= dl; FIXB[f] = r % dl; r /= dl; }
    double m1; double nrm = run_case(L, j2, k2, leg2, &m1, &nl); nrm2 += nrm * nrm; if (m1 > mx) mx = m1; if (MAXST > maxst_all) maxst_all = MAXST;
    if (getenv("CUP_TRACE")) fprintf(stderr, "combo %ld of %ld: |slice|_F = %.9e peak %zu\n", combo + 1, ncomb, nrm, MAXST); }
  printf("CUPBOX L=%d j=%d/2 k=%d/2 legs=%d at spin %d/2: links=%d |T|_F = %.9e max|entry| = %.9e rule %d points maxstate=%zu fixed=%d\n", L, j2, k2, nl, leg2, NL, sqrt(nrm2), mx, NPT, maxst_all, NFIXREQ);
  return 0; }
