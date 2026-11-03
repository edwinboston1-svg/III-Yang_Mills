/* w2_strip_n.c -- THE TWO-FACE OBJECT'S SWEEP AT FACE SIZE n: the joint law of two adjacent coarse n x n loops under the blocked measure, exact
 * at plaquette spins <= WMAX/2 (THE CROSSING CAMPAIGN W2 at n = 2, §6; W3's TWO-STEP OBJECT at n = 4, §8; 2026-11-01, the author).
 * w2_strip.c generalised: face A = the n x n block of fine plaquettes in the xy-plane at z = w = 0; face B = the n x n block in the yz-plane
 * at x = w = 0 (bent) or in the xy-plane at x in [-n, 0] (planar); the shared coarse edge x = z = 0, y in [0, n] (n fine links); 2n^2 plaquettes;
 * every object link in staples outside the object (the datum: ordered, random:SEED, cancel on the first shared link's staples, free = off).
 * The representations, the rule, the link tensors, the wire formalism, the junction and the known answers are w2_strip.c's; the free object's
 * law is W(A) = sum_a d_a a_a^{n^2} chi_a.  THE ORDER is generated from the geometry: face A's columns from the far edge to the shared edge
 * (the far edge's links, then the column's horizontals bottom to top, then its cut links), face B's likewise from its far edge inward, and the
 * shared links last in the loops' chain order -- every cycle, loop or plaquette, keeps at most two open wires.
 * usage: w2_strip_n beta WMAX LMAX DATUM [fwd|rev] [bent|planar] [n]      build: gcc -O2 -fopenmp -o w2_strip_n.exe w2_strip_n.c -lm
 *
 * w2e.c -- THE CORRECTED ENGINE (the development EI, 2026-11-02 13:0x EST; the campaign's §18 defect and the author's fixes 1 and 2).
 * (1) THE CORNERS: a non-face plaquette holding two or more object links is a CORNER CYCLE of the network, registered once, never a
 *     staple (the record entered each of the bent object's n + 1 corner plaquettes twice as a staple, each time reading the other object
 *     link from the datum).  Its steps are its object links in cyclic order; the outside links between two object steps fold into the
 *     preceding step as a fixed right multiplier M read from the datum, so the step's matrix is D^s(U^sigma M) and the cycle's trace is
 *     chi_s(U_p) exactly; its spins run to WMAX with closing weight FAC[s], the truncated weight the record's staples used.  The corner
 *     cycles are numbered after the two loops, so with no corners every wire and block index is the record's.  W2_CORNER=staple
 *     reproduces the record (the defect) byte for byte.  FREE turns the corners off with the staples.  THE ORDER of the bent object
 *     with corners sweeps the near region along y (x(j), z(j), s(j)), each corner open only between its two steps.
 * (2) W2_GEOM=1 prints every plaquette the engine integrates (FACE / CORNER / STAPLE with its object link), the object links and the
 *     outside links -- the geometry known answer's engine side (eigeom.awk enumerates the same from the page's definition).
 * (3) W2_GAUGE="x,y,z,w:qw:qx:qy:qz" gauge-transforms the datum at the vertex v: every GENUINE outside link leaving v is left-multiplied
 *     by g, every one entering v right-multiplied by g^-1 (an outside entry carrying an object link's coordinates -- the record's phantom --
 *     is not a link and is left alone, counted).  Every class moment and channel is invariant under it at every vertex.
 * (4) W2_DATUMC=<file>: the outside by COORDINATES ("x y z w dir qw qx qy qz" per line), every outside link required, extra lines (a
 *     record's phantoms) skipped and counted -- so one datum reaches engines with different outside numberings.
 * (5) THE LADDER MODE of w2_strip_l.c ported (W2_LADDER=1), its affected sets widened by the corner multipliers.
 * (6) W2_WEIGHT=sq (fix 2): every plaquette weight h_J^2, h the Wilson weight at beta/2 truncated at s <= WMAX/2 (WMAX even), the
 *     coefficients by Clebsch-Gordan, normalised to a unit chi_0 coefficient; non-negative on the group, spins <= WMAX.  Unset: the record.
 * build: gcc -O2 -fopenmp -o w2e.exe w2e.c -lm */
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
#define MAXCYC 48
#define MAXSTEP 16
#define MAXW 400
#define MAXCORN 8
static double BETA; static int WMAX, LMAX, SMAX, FREE = 0, PLANAR = 0, NN = 2; static size_t CEIL = 400000000;
static int CORNERMODE = 1;   /* 1: the corners as cycles (the correction); 0: W2_CORNER=staple, the record's staple loop (the defect) */
static int SQW = 0;          /* W2_WEIGHT=sq: the squared truncation (fix 2) */
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
static double wgt(quat V) { double s = 1; if (SQW) { for (int k = 1; k <= WMAX; k++) s += FAC[k] * chi(k, V); return s; } for (int k = 1; k <= WMAX; k++) s += (k + 1) * A[k] * chi(k, V); return s; }
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
/* THE CORNER CYCLES (EI): the fixed right multiplier of a cycle step -- the outside links between it and the next object step, in order */
static int NCORN = 0, CORN0 = 0; static int STEPMN[MAXCYC][MAXSTEP], STEPMO[MAXCYC][MAXSTEP][3], STEPMS[MAXCYC][MAXSTEP][3];
/* ---- cei_face (the author, 2026-11-02 17:3x EST): THE SINGLE-PATH FACE FIBRE BY SUBSTITUTION, exact in epsilon (campaign §31.10-§31.11).
   With CEI_SUBST=1 (n = 2 only) each of the seven coarse edges of the two loops -- a straight path of two fine links, U_p^{sp} U_e^{se} = c in
   the loop's order -- has its last link e eliminated: U_e^{se} = U_p^{-sp} c.  Every cycle's step on e with sign tau becomes a step on p:
   tau = se gives D(U_p^{-sp} . c . M) (the constant c BEFORE the step's datum multipliers M); tau = -se gives D(c^-1 U_p^{sp} M), the c^-1
   folded into the preceding step's right multiplier AFTER its own.  The eliminated link's staples become the partner's "inverse staples",
   read at U_e = (U_p^{-sp} c)^{se}.  The loop cycles are DROPPED (their holonomies are constants of the fibre), which keeps every link within
   the engine's four slots.  The fine observables come from PER-PLAQUETTE SOURCE WEIGHTS: a plaquette tilted by chi_1 closes with
   FAC[s-1] + FAC[s+1], so <1/2 tr U_p> = Z'_p / (2 Z) and the connected pair is Z''_pq/(4Z) - Z'_p Z'_q/(4 Z^2), four sweeps.
   Unset, every byte of the output is w2e.c's. ---- */
static int CEI = 0;                                                   /* CEI_SUBST=1 */
static quat CEIC = { 1, 0, 0, 0 };                                    /* the coarse datum c (CEI_C="w:x:y:z", a unit quaternion; the identity unset) */
static int STEPPRE[MAXCYC][MAXSTEP], STEPPOST[MAXCYC][MAXSTEP];       /* constant multipliers: PRE before the datum multipliers, POST after */
static quat STEPPREQ[MAXCYC][MAXSTEP], STEPPOSTQ[MAXCYC][MAXSTEP];
static int ELIM[MAXL], NELIM = 0;                                     /* the eliminated links */
static int NISTAP[MAXL], ISTAP[MAXL][8][3][2], ISIGP[MAXL][8], ISIGE[MAXL][8];   /* the partner's inverse staples: the eliminated link's staples, with the path signs */
static double PFAC[MAXCYC][32];                                       /* per-cycle closing weights: FAC, or the chi_1 source on a source plaquette */
static int NSRC = 0, SRC[2];                                          /* CEI_SRC="p" or "p,q": face plaquette indices 0..NP-1 */
static int CEIORD[MAXL], NCEIORD = 0;                                 /* CEI_ORDER=<file>: "x y z d" per line (ordsub's best order), eliminated links skipped */
static int CLAMPC = -1, CLAMPS = -1, CLAMPWA = -1, CLAMPWB = -1;      /* CEI_CLAMP="cycle:wireA:wireB" (campaign §31.13, lead 2): one cycle's spin and two of its wires fixed per slice, the slices summed outside -- an exact rearrangement of the sum that takes the peak from (sum d_s^2)^K to (sum d_s^2)^(K-1) */
static int PEAKLIST = 0;                                              /* CEI_PEAK=1: list the open wires at the peak step, with their cycles */
static int PROFILE = 0;                                               /* CEI_PROFILE=1: one line per step of the first sweep -- the state's size, the open cycles with their open-wire counts */
static int BRANCH = 1;                                                /* the source branch: the configurations share the sweep up to the first source closing (CEI_NOBRANCH=1 runs each whole) */
static int SELFON = 0, KSELF = 0, ELIMOF[MAXL];                       /* CEI_SELF=<file> (campaign 31.14, lead 1 in its diagonal form): per object link "x y z d kappa", the exterior's Gaussian
                                                                         self-energy as an effective staple count -- the link's weight exp(kappa beta (1/2 tr U - 1)) in characters to KSELF
                                                                         (CEI_KSELF, WMAX + 4 unset) in place of its staples at a datum; an eliminated link's rides on its partner's value */
static double KEFF[MAXL], FS[MAXL][32];
static int STRIPK = 0;                                                /* CEI_STRIP=K (campaign 31.15): the object a planar strip of K coarse cells (faces f = 0..K-1 at x in [-(f-1)n - n, -(f-1)n],
                                                                         face 0 EI's face A, face 1 EI's planar face B), K loops, 3K + 1 coarse edges; the substitution eliminates one link per
                                                                         edge; the two-point function along the strip at separations fn + 1 between face 0's far column and face f's */
static void plaq_edges(const int *base, int d1, int d2, int E[4][4], int ED[4], int SG[4]) {   /* the plaquette's boundary in add_plaq's convention */
  memcpy(E[0], base, sizeof(int) * 4); ED[0] = d1; SG[0] = 1;
  memcpy(E[1], base, sizeof(int) * 4); E[1][d1 - 1]++; ED[1] = d2; SG[1] = 1;
  memcpy(E[2], base, sizeof(int) * 4); E[2][d2 - 1]++; ED[2] = d1; SG[2] = -1;
  memcpy(E[3], base, sizeof(int) * 4); ED[3] = d2; SG[3] = -1; }
static int plaq_nobj(const int *base, int d1, int d2) { int E[4][4], ED[4], SG[4]; plaq_edges(base, d1, d2, E, ED, SG); int n = 0; for (int i = 0; i < 4; i++) if (lkey(E[i], ED[i], 0) >= 0) n++; return n; }
static void add_corner(const int *base, int d1, int d2) {
  for (int i = 0; i < NCORN; i++) { int c = CORN0 + i; if (PD1[c] == d1 && PD2[c] == d2 && !memcmp(PB[c], base, sizeof(int) * 4)) return; }   /* registered once */
  if (NCORN >= MAXCORN || CORN0 + NCORN >= MAXCYC) { fprintf(stderr, "too many corner cycles\n"); exit(1); }
  int c = CORN0 + NCORN++; memcpy(PB[c], base, sizeof(int) * 4); PD1[c] = d1; PD2[c] = d2; ISLOOP[c] = 0; NSTEP[c] = 0;
  int E[4][4], ED[4], SG[4]; plaq_edges(base, d1, d2, E, ED, SG); int ob[4], r = -1; for (int i = 0; i < 4; i++) { ob[i] = lkey(E[i], ED[i], 0); if (ob[i] >= 0 && r < 0) r = i; }
  int st = -1; for (int t = 0; t < 4; t++) { int i = (r + t) % 4;
    if (ob[i] >= 0) { st = NSTEP[c]++; STEPL[c][st] = ob[i]; STEPS[c][st] = SG[i]; STEPMN[c][st] = 0; }
    else { int m = STEPMN[c][st]++; STEPMO[c][st][m] = okey(E[i], ED[i]); STEPMS[c][st][m] = SG[i]; } } }
static void add_plaq(int p, int x, int y, int z, int d1, int d2) { int b[4] = { x, y, z, 0 }; memcpy(PB[p], b, sizeof b); PD1[p] = d1; PD2[p] = d2;
  int q[4]; NSTEP[p] = 4; ISLOOP[p] = 0;
  STEPL[p][0] = lkey(b, d1, 1); STEPS[p][0] = 1;
  memcpy(q, b, sizeof q); q[d1 - 1]++; STEPL[p][1] = lkey(q, d2, 1); STEPS[p][1] = 1;
  memcpy(q, b, sizeof q); q[d2 - 1]++; STEPL[p][2] = lkey(q, d1, 1); STEPS[p][2] = -1;
  STEPL[p][3] = lkey(b, d2, 1); STEPS[p][3] = -1; }
static void add_loop_step(int c, int i, int x, int y, int z, int d, int sgn) { int b[4] = { x, y, z, 0 }; int l = lkey(b, d, 0); if (l < 0) { fprintf(stderr, "loop link (%d,%d,%d,%d) not an object link\n", x, y, z, d); exit(1); } STEPL[c][i] = l; STEPS[c][i] = sgn; }
static int order[MAXL], NORD = 0;
static void push_order(int x, int y, int z, int d) { int b[4] = { x, y, z, 0 }; int l = lkey(b, d, 0); if (l < 0) { fprintf(stderr, "order link (%d,%d,%d,%d) missing\n", x, y, z, d); exit(1); } for (int i = 0; i < NORD; i++) if (order[i] == l) { fprintf(stderr, "order repeats link %d\n", l); exit(1); } order[NORD++] = l; }
static void build(void) { int n = NN; NP = 2 * n * n; NCYC = NP + 2; LOOPA = NP; LOOPB = NP + 1; CORN0 = NP + 2; NCORN = 0;
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
        if (CORNERMODE && !FREE && plaq_nobj(base, d1, d2) >= 2) { add_corner(base, d1, d2); continue; }   /* EI: a corner is a cycle, never a staple */
        int ns = NSTAP[l]; int q[4];
        if (s > 0) { STAP[l][ns][0][0] = okey(pd, k); STAP[l][ns][0][1] = 1; } else { memcpy(q, pd, sizeof q); q[k - 1] -= 1; STAP[l][ns][0][0] = okey(q, k); STAP[l][ns][0][1] = -1; }
        memcpy(q, p, sizeof q); q[k - 1] += s; STAP[l][ns][1][0] = okey(q, d); STAP[l][ns][1][1] = -1;
        if (s > 0) { STAP[l][ns][2][0] = okey(p, k); STAP[l][ns][2][1] = -1; } else { memcpy(q, p, sizeof q); q[k - 1] -= 1; STAP[l][ns][2][0] = okey(q, k); STAP[l][ns][2][1] = 1; }
        NSTAP[l]++; } } }
  /* EI: the corner cycles' wires, after the faces' and the loops' (so with no corners every wire index is the record's) */
  for (int i = 0; i < NCORN; i++) { int c = CORN0 + i; NWIRE[c] = NSTEP[c]; WBASE[c] = NW; for (int w = 0; w < NWIRE[c]; w++) WCYC[NW + w] = c; NW += NWIRE[c]; }
  NCYC = CORN0 + NCORN; if (NW > MAXW) { fprintf(stderr, "too many wires\n"); exit(1); }
  if (NCORN > 0) {   /* EI: THE ORDER WITH CORNERS -- face A's far edge and columns n-1..1 as the record; THE NEAR REGION ALONG y: x(j), z(j), s(j);
                        face B's slabs as the record (slab 0's z-links done in the near region).  Each corner open only between x(j) and z(j). */
    if (PLANAR) { fprintf(stderr, "a planar object with corner cycles: the geometry is not the one this order was written for\n"); exit(1); }
    for (int j = 0; j < n; j++) push_order(n, j, 0, 2);
    for (int i = n - 1; i >= 1; i--) { for (int j = 0; j <= n; j++) push_order(i, j, 0, 1); for (int j = 0; j < n; j++) push_order(i, j, 0, 2); }
    for (int j = 0; j <= n; j++) { push_order(0, j, 0, 1); push_order(0, j, 0, 3); if (j < n) push_order(0, j, 0, 2); }
    for (int k = 0; k < n; k++) { if (k > 0) for (int j = 0; j <= n; j++) push_order(0, j, k, 3); for (int j = n - 1; j >= 0; j--) push_order(0, j, k + 1, 2); }
    if (NORD != NL) { fprintf(stderr, "the order holds %d of %d links\n", NORD, NL); exit(1); }
    return; }
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
/* ---- cei_face: the loops dropped, the substitution, the partner staples, the order file ---- */
static void cei_renumber_wires(void) { NW = 0; for (int c = 0; c < NCYC; c++) { NWIRE[c] = ISLOOP[c] ? NSTEP[c] + 1 : NSTEP[c]; WBASE[c] = NW; for (int i = 0; i < NWIRE[c]; i++) WCYC[NW + i] = c; NW += NWIRE[c]; }
  if (NW > MAXW) { fprintf(stderr, "too many wires after the cei rebuild\n"); exit(1); } }
static void cei_drop_loops(void) { NSTEP[LOOPA] = 0; NSTEP[LOOPB] = 0; ISLOOP[LOOPA] = 0; ISLOOP[LOOPB] = 0; cei_renumber_wires();
  printf("CEI-DROP: the two loop cycles dropped (their holonomies are constants of the fibre, or trivial at spin 0); %d wires\n", NW); }
static void cei_replace(int c, int st, int p, int sp, int se) {   /* the step st of cycle c sits on the eliminated link e with sign tau */
  int tau = STEPS[c][st];
  if (tau == se) { STEPL[c][st] = p; STEPS[c][st] = -sp; STEPPRE[c][st] = 1; STEPPREQ[c][st] = CEIC; }
  else { STEPL[c][st] = p; STEPS[c][st] = sp; int prev = (st + NSTEP[c] - 1) % NSTEP[c];
    quat ci = qinv(CEIC); if (STEPPOST[c][prev]) STEPPOSTQ[c][prev] = qmul(STEPPOSTQ[c][prev], ci); else { STEPPOST[c][prev] = 1; STEPPOSTQ[c][prev] = ci; } } }
/* THE STRIP (campaign 31.15): K planar coarse cells in one row, built like EI's build() -- face 0 is face A, face 1 is the planar face B, face f
   lies at x in [-(f-1)n - n, -(f-1)n]; loop f runs counterclockwise from the top of its right edge (face 0's from the top of the shared edge, as
   EI's); no corners (a planar object has none); the staples as EI's; the order from CEI_ORDER (required).  At K = 2 it is EI's planar object
   cycle for cycle and wire for wire (the known answer: the two builders' readings byte-identical). */
static void cei_build_strip(void) { int n = NN, K = STRIPK; NP = K * n * n; NCYC = NP + K; LOOPA = NP; LOOPB = NP + 1; CORN0 = NP + K; NCORN = 0;
  if (NP + K > MAXCYC) { fprintf(stderr, "CEI_STRIP: %d cycles exceed MAXCYC %d\n", NP + K, MAXCYC); exit(1); }
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) add_plaq(j + n * i, i, j, 0, 1, 2);
  for (int f = 1; f < K; f++) for (int k = 0; k < n; k++) for (int j = 0; j < n; j++) add_plaq(f * n * n + j + n * k, -(f - 1) * n - 1 - k, j, 0, 1, 2);
  if (NL != K * n * (2 * n + 1) + n) { fprintf(stderr, "strip links: %d, not %d\n", NL, K * n * (2 * n + 1) + n); exit(1); }
  for (int f = 0; f < K; f++) { int c = NP + f; NSTEP[c] = 4 * n; ISLOOP[c] = 1; int s = 0;
    if (f == 0) { for (int j = n - 1; j >= 0; j--) add_loop_step(c, s++, 0, j, 0, 2, -1); for (int i = 0; i < n; i++) add_loop_step(c, s++, i, 0, 0, 1, 1);
      for (int j = 0; j < n; j++) add_loop_step(c, s++, n, j, 0, 2, 1); for (int i = n - 1; i >= 0; i--) add_loop_step(c, s++, i, n, 0, 1, -1); }
    else { int xr = -(f - 1) * n, xl = -f * n;
      for (int i = 0; i < n; i++) add_loop_step(c, s++, xr - 1 - i, n, 0, 1, -1); for (int j = n - 1; j >= 0; j--) add_loop_step(c, s++, xl, j, 0, 2, -1);
      for (int i = 0; i < n; i++) add_loop_step(c, s++, xl + i, 0, 0, 1, 1); for (int j = 0; j < n; j++) add_loop_step(c, s++, xr, j, 0, 2, 1); } }
  NW = 0; for (int c = 0; c < NCYC; c++) { NWIRE[c] = ISLOOP[c] ? NSTEP[c] + 1 : NSTEP[c]; WBASE[c] = NW; for (int i = 0; i < NWIRE[c]; i++) WCYC[NW + i] = c; NW += NWIRE[c]; }
  if (NW > MAXW) { fprintf(stderr, "too many wires\n"); exit(1); }
  { int b0[4] = { 0, 0, 0, 0 }; SHARED0 = lkey(b0, 2, 0); }
  for (int l = 0; l < NL; l++) { int *p = LB[l], d = LD[l]; int pd[4]; memcpy(pd, p, sizeof pd); pd[d - 1]++; NSTAP[l] = 0;
    for (int k = 1; k <= 4; k++) { if (k == d) continue;
      for (int si = 0; si < 2; si++) { int s = si ? -1 : 1; int base[4]; memcpy(base, p, sizeof base); if (s < 0) base[k - 1]--;
        int d1 = d < k ? d : k, d2 = d < k ? k : d; if (is_obj_plaq(base, d1, d2)) continue;
        if (plaq_nobj(base, d1, d2) >= 2) { fprintf(stderr, "CEI_STRIP: a non-face plaquette with two object links (a corner) in a planar strip\n"); exit(1); }
        int ns = NSTAP[l]; int q[4];
        if (s > 0) { STAP[l][ns][0][0] = okey(pd, k); STAP[l][ns][0][1] = 1; } else { memcpy(q, pd, sizeof q); q[k - 1] -= 1; STAP[l][ns][0][0] = okey(q, k); STAP[l][ns][0][1] = -1; }
        memcpy(q, p, sizeof q); q[k - 1] += s; STAP[l][ns][1][0] = okey(q, d); STAP[l][ns][1][1] = -1;
        if (s > 0) { STAP[l][ns][2][0] = okey(p, k); STAP[l][ns][2][1] = -1; } else { memcpy(q, p, sizeof q); q[k - 1] -= 1; STAP[l][ns][2][0] = okey(q, k); STAP[l][ns][2][1] = 1; }
        NSTAP[l]++; } } }
  NORD = 0;   /* the order comes from CEI_ORDER */
  printf("CEI-STRIP K=%d n=%d: %d plaquettes, %d loops, %d links, %d outside links, %d wires\n", K, n, NP, K, NL, NOUT, NW); }
static void cei_substitute(void) { int n = NN;
  if (n != 2) { fprintf(stderr, "CEI_SUBST REFUSED: the substitution is written for n = 2 (one partner link per edge)\n"); exit(1); }
  if (PLANAR && !STRIPK) { fprintf(stderr, "CEI_SUBST REFUSED: the bent object, or a strip (CEI_STRIP=K)\n"); exit(1); }
  if (FREE) { fprintf(stderr, "CEI_SUBST REFUSED at the free datum (the corners are off there; the substituted object is read at a datum)\n"); exit(1); }
  int EL[64][2], ES[64][2], NE = 0, K = STRIPK ? STRIPK : 2;   /* the 3K + 1 edges: links and signs in loop order (loop 0's four; every later loop's first three, its fourth being the edge shared with the loop before) */
  for (int e = 0; e < 4; e++) { for (int k = 0; k < 2; k++) { EL[NE][k] = STEPL[LOOPA][2 * e + k]; ES[NE][k] = STEPS[LOOPA][2 * e + k]; } NE++; }
  for (int f = 1; f < K; f++) for (int e = 0; e < 3; e++) { for (int k = 0; k < 2; k++) { EL[NE][k] = STEPL[NP + f][2 * e + k]; ES[NE][k] = STEPS[NP + f][2 * e + k]; } NE++; }
  for (int l = 0; l < NL; l++) { ELIM[l] = 0; NISTAP[l] = 0; ELIMOF[l] = -1; }
  for (int f = 0; f < K; f++) { NSTEP[NP + f] = 0; ISLOOP[NP + f] = 0; }   /* the loops dropped: every edge's product is the constant c */
  for (int e = 0; e < NE; e++) { int p = EL[e][0], sp = ES[e][0], el = EL[e][1], se = ES[e][1];
    if (ELIM[el] || ELIM[p]) { fprintf(stderr, "CEI_SUBST: an edge's link already eliminated\n"); exit(1); }
    for (int c = 0; c < NCYC; c++) for (int st = 0; st < NSTEP[c]; st++) if (STEPL[c][st] == el) cei_replace(c, st, p, sp, se);
    for (int k = 0; k < NSTAP[el]; k++) { int m = NISTAP[p]; if (m >= 8) { fprintf(stderr, "CEI_SUBST: too many inverse staples\n"); exit(1); }
      memcpy(ISTAP[p][m], STAP[el][k], sizeof(int) * 3 * 2); ISIGP[p][m] = sp; ISIGE[p][m] = se; NISTAP[p]++; }
    ELIM[el] = 1; NELIM++; ELIMOF[p] = el; }   /* the eliminated link keeps its staple list (the cancel datum reads the shared link's); no tensor is ever built for it */
  int twice = 0; for (int c = 0; c < NCYC; c++) for (int i = 0; i < NSTEP[c]; i++) for (int j = i + 1; j < NSTEP[c]; j++) if (STEPL[c][i] == STEPL[c][j]) twice++;
  cei_renumber_wires();
  printf("CEI-SUBST: %d coarse edges fixed at c = (%.6f,%.6f,%.6f,%.6f) by substitution; %d links eliminated, %d survive; the loop cycles dropped; %d cycle(s) hold a link at two steps; %d wires\n", NE, CEIC.w, CEIC.x, CEIC.y, CEIC.z, NELIM, NL - NELIM, twice, NW); }
static quat cei_partner_value(int l, int k, quat U) {   /* U_e = (U_p^{-sp} c)^{se} at U_p = U */
  quat q = (ISIGP[l][k] > 0) ? qinv(U) : U; q = qmul(q, CEIC); if (ISIGE[l][k] < 0) q = qinv(q); return q; }
static void cei_source(int c) { for (int q = 0; q <= WMAX; q++) PFAC[c][q] = (q > 0 ? FAC[q - 1] : 0) + (q + 1 <= WMAX ? FAC[q + 1] : 0); }   /* the chi_1 source on cycle c: chi_1 chi_q = chi_{q-1} + chi_{q+1} */
static double wself(int l, quat V) { double s = 1; for (int k = 1; k <= KSELF; k++) s += FS[l][k] * chi(k, V); return s; }   /* the self-energy weight, normalised at spin 0 like wgt */
static void cei_read_self(const char *file) {   /* "x y z d kappa" per object link: FS[l][k] = (k + 1) I_{k+1}(kappa beta) / I_1(kappa beta), the Wilson coefficients at coupling kappa beta */
  FILE *f = fopen(file, "r"); if (!f) { fprintf(stderr, "CEI_SELF: cannot open %s\n", file); exit(1); }
  int seen[MAXL]; for (int l = 0; l < NL; l++) seen[l] = 0; int x, y, z, d; double kap; int n = 0;
  while (fscanf(f, "%d %d %d %d %lf", &x, &y, &z, &d, &kap) == 5) { int b[4] = { x, y, z, 0 }; int l = lkey(b, d, 0); if (l < 0) { fprintf(stderr, "CEI_SELF: no link (%d,%d,%d) d%d\n", x, y, z, d); exit(1); }
    if (seen[l]) { fprintf(stderr, "CEI_SELF: link (%d,%d,%d) d%d given twice\n", x, y, z, d); exit(1); } if (kap < 0) { fprintf(stderr, "CEI_SELF: a negative kappa at (%d,%d,%d) d%d\n", x, y, z, d); exit(1); }
    seen[l] = 1; KEFF[l] = kap; n++; }
  fclose(f); for (int l = 0; l < NL; l++) if (!seen[l]) { fprintf(stderr, "CEI_SELF: link %d (%d,%d,%d) d%d has no kappa\n", l, LB[l][0], LB[l][1], LB[l][2], LD[l]); exit(1); }
  if (KSELF <= 0) KSELF = WMAX + 4; if (KSELF > 31) KSELF = 31; double kmin = 1e9, kmax = 0, tailmax = 0;
  for (int l = 0; l < NL; l++) { double kb = KEFF[l] * BETA; for (int k = 0; k < 32; k++) FS[l][k] = 0; FS[l][0] = 1; if (kb > 0) { double i1 = bessel(1, kb); for (int k = 1; k <= KSELF; k++) FS[l][k] = (k + 1) * bessel(k + 1, kb) / i1;
      double tail = 0; for (int k = KSELF + 1; k <= 31; k++) tail += (k + 1) * (k + 1) * bessel(k + 1, kb) / i1; if (tail > tailmax) tailmax = tail; }
    if (KEFF[l] < kmin) kmin = KEFF[l]; if (KEFF[l] > kmax) kmax = KEFF[l]; }
  SELFON = 1; printf("CEI-SELF %s: %d links, kappa in [%.6f, %.6f], KSELF=%d, the weight's truncation tail at most %.2e (sum of |coefficient| x dimension past the cap)\n", file, n, kmin, kmax, KSELF, tailmax); }
static void cei_read_datum(const char *file, quat *DATA) {   /* the datum from a file: "x y z t d w x y z" per outside link (a unit quaternion; normalised here); every outside link must be given */
  FILE *f = fopen(file, "r"); if (!f) { fprintf(stderr, "datum file: cannot open %s\n", file); exit(1); }
  int seen[MAXOUT]; for (int i = 0; i < NOUT; i++) seen[i] = 0; int b[4], d; double w, x, y, z; int n = 0, extra = 0;
  while (fscanf(f, "%d %d %d %d %d %lf %lf %lf %lf", &b[0], &b[1], &b[2], &b[3], &d, &w, &x, &y, &z) == 9) { int i = -1; for (int k = 0; k < NOUT; k++) if (OD[k] == d && !memcmp(OB[k], b, sizeof(int) * 4)) { i = k; break; }
    if (i < 0) { extra++; continue; } if (seen[i]) { fprintf(stderr, "datum file: link (%d,%d,%d,%d) d%d given twice\n", b[0], b[1], b[2], b[3], d); exit(1); }
    double nn = sqrt(w * w + x * x + y * y + z * z); if (nn < 1e-12) { fprintf(stderr, "datum file: a zero quaternion at (%d,%d,%d,%d) d%d\n", b[0], b[1], b[2], b[3], d); exit(1); }
    DATA[i].w = w / nn; DATA[i].x = x / nn; DATA[i].y = y / nn; DATA[i].z = z / nn; seen[i] = 1; n++; }
  fclose(f); for (int i = 0; i < NOUT; i++) if (!seen[i]) { fprintf(stderr, "datum file: outside link (%d,%d,%d,%d) d%d has no value\n", OB[i][0], OB[i][1], OB[i][2], OB[i][3], OD[i]); exit(1); }
  printf("CEI-DATUM %s: %d outside links set (%d lines of other links ignored)\n", file, n, extra); }
static void cei_list_out(const quat *DATA) { for (int i = 0; i < NOUT; i++) printf("CEI-OUT %d %d %d %d %d %.15f %.15f %.15f %.15f\n", OB[i][0], OB[i][1], OB[i][2], OB[i][3], OD[i], DATA[i].w, DATA[i].x, DATA[i].y, DATA[i].z); }
static quat istaple(int l, int k, const quat *dat) { quat T = { 1, 0, 0, 0 }; for (int j = 0; j < 3; j++) { quat V = dat[ISTAP[l][k][j][0]]; if (ISTAP[l][k][j][1] < 0) V = qinv(V); T = qmul(T, V); } return T; }
static void cei_read_order(const char *file) { FILE *f = fopen(file, "r"); if (!f) { fprintf(stderr, "CEI_ORDER: cannot open %s\n", file); exit(1); }
  int x, y, z, d; NCEIORD = 0; while (fscanf(f, "%d %d %d %d", &x, &y, &z, &d) == 4) { int b[4] = { x, y, z, 0 }; int l = lkey(b, d, 0); if (l < 0) { fprintf(stderr, "CEI_ORDER: no link (%d,%d,%d) d%d\n", x, y, z, d); exit(1); }
    for (int i = 0; i < NCEIORD; i++) if (CEIORD[i] == l) { fprintf(stderr, "CEI_ORDER: a link repeated\n"); exit(1); } CEIORD[NCEIORD++] = l; }
  fclose(f);
  int nsurv = 0; for (int l = 0; l < NL; l++) if (!ELIM[l]) nsurv++; int got = 0; for (int i = 0; i < NCEIORD; i++) if (!ELIM[CEIORD[i]]) got++;
  if (got != nsurv) { fprintf(stderr, "CEI_ORDER: %d of the %d surviving links given\n", got, nsurv); exit(1); }
  printf("CEI-ORDER %s: %d links read, %d surviving links in the order\n", file, NCEIORD, got); }
/* THE MULTI-VERTEX GAUGE DOOR (campaign §32 CORRECTION, 2026-11-03 04:0x): CEI_GAUGES="x,y,z,w:qw:qx:qy:qz[;x,y,z,w:qw:qx:qy:qz ...]" gauge-transforms
   the datum at SEVERAL vertices in one run -- the periodic pair, the whole coarse class -- the record's one-vertex W2_GAUGE left untouched, so arm 5's
   pins stand.  Each group exactly as W2_GAUGE: every GENUINE outside link leaving v becomes g U, every one entering it U g^-1, a phantom entry (one that
   carries an object link's coordinates) left alone and counted.  Called from the tensors anchor, BEFORE the link tensors are built from the datum. */
static void cei_gauges(quat *DATA) { const char *env = getenv("CEI_GAUGES"); if (!env) return; char gbuf[8192]; strncpy(gbuf, env, sizeof gbuf - 1); gbuf[sizeof gbuf - 1] = 0; int ngrp = 0;
  for (char *grp = strtok(gbuf, ";"); grp; grp = strtok(NULL, ";")) { int v[4]; double gw, gx, gy, gz;
    if (sscanf(grp, "%d,%d,%d,%d:%lf:%lf:%lf:%lf", &v[0], &v[1], &v[2], &v[3], &gw, &gx, &gy, &gz) != 8) { fprintf(stderr, "CEI_GAUGES must be x,y,z,w:qw:qx:qy:qz[;...]\n"); exit(1); }
    double nn = sqrt(gw * gw + gx * gx + gy * gy + gz * gz); if (nn < 1e-12) { fprintf(stderr, "CEI_GAUGES: a zero quaternion\n"); exit(1); } quat g = { gw / nn, gx / nn, gy / nn, gz / nn }; int nl = 0, ne = 0, nph = 0;
    for (int i = 0; i < NOUT; i++) { int e[4]; memcpy(e, OB[i], sizeof e); e[OD[i] - 1]++; int leaves = !memcmp(OB[i], v, sizeof v), enters = !memcmp(e, v, sizeof v); if (!leaves && !enters) continue;
      if (lkey(OB[i], OD[i], 0) >= 0) { nph++; continue; } if (leaves) { DATA[i] = qmul(g, DATA[i]); nl++; } if (enters) { DATA[i] = qmul(DATA[i], qinv(g)); ne++; } }
    int onobj = 0; for (int l = 0; l < NL; l++) { int e[4]; memcpy(e, LB[l], sizeof e); e[LD[l] - 1]++; if (!memcmp(LB[l], v, sizeof v) || !memcmp(e, v, sizeof v)) onobj = 1; }
    ngrp++; printf("CEI-GAUGES vertex (%d,%d,%d,%d) g=(%.6f,%.6f,%.6f,%.6f): %d outside links leaving, %d entering, transformed; %d phantom entries left alone; an %s vertex\n", v[0], v[1], v[2], v[3], g.w, g.x, g.y, g.z, nl, ne, nph, onobj ? "object" : "outside"); }
  printf("CEI-GAUGES %d group(s) applied before the link tensors\n", ngrp); }
static quat staple(int l, int k, const quat *dat) { quat T = { 1, 0, 0, 0 }; for (int j = 0; j < 3; j++) { quat V = dat[STAP[l][k][j][0]]; if (STAP[l][k][j][1] < 0) V = qinv(V); T = qmul(T, V); } return T; }
static int NSLOT[MAXL], SLC[MAXL][4], SLS[MAXL][4];
static void slots(void) { for (int l = 0; l < NL; l++) NSLOT[l] = 0; for (int c = 0; c < NCYC; c++) for (int i = 0; i < NSTEP[c]; i++) { int l = STEPL[c][i]; if (NSLOT[l] >= 4) { fprintf(stderr, "link %d in more than four cycles\n", l); exit(1); } SLC[l][NSLOT[l]] = c; SLS[l][NSLOT[l]] = i; NSLOT[l]++; } }
static int win(int c, int i) { return WBASE[c] + i; }
static int wout(int c, int i) { return ISLOOP[c] ? WBASE[c] + i + 1 : WBASE[c] + (i + 1) % NSTEP[c]; }
static cplx *RM; static size_t RSTR;
static cplx *rmat(int pt, int s, int inv) { return RM + ((size_t)pt * (SMAX + 1) * 2 + (size_t)s * 2 + inv) * RSTR; }
static cplx **LT[MAXL]; static double *SW[MAXL]; static int LCAP[MAXL][4], LNBLK[MAXL];
static cplx **LTO[MAXL];   /* THE LADDER MODE (w2_strip_l.c, ported by EI): a per-link tensor override for the mini-sweeps -- NULL means the base tensor LT[l] */
static int cap_of(int c) { return ISLOOP[c] ? LMAX : WMAX; }
/* EI: a corner step's fixed right multiplier from the datum, and the table of D^s(U^sigma M) on the rule for that slot (NULL: no multiplier) */
static quat step_mult(int c, int st, const quat *dat) { quat M = { 1, 0, 0, 0 }; if (STEPPRE[c][st]) M = STEPPREQ[c][st]; for (int m = 0; m < STEPMN[c][st]; m++) { quat V = dat[STEPMO[c][st][m]]; if (STEPMS[c][st][m] < 0) V = qinv(V); M = qmul(M, V); } if (STEPPOST[c][st]) M = qmul(M, STEPPOSTQ[c][st]); return M; }
static cplx *corner_table(int l, int j, const quat *dat) { int c = SLC[l][j], st = SLS[l][j]; if (STEPMN[c][st] == 0) if (!STEPPRE[c][st]) if (!STEPPOST[c][st]) return NULL;
  quat M = step_mult(c, st, dat); int cap = LCAP[l][j]; cplx *T = malloc(sizeof(cplx) * (size_t)NPT * (cap + 1) * RSTR); if (!T) { fprintf(stderr, "out of memory at a corner table\n"); exit(3); }
  #pragma omp parallel for schedule(static)
  for (int pt = 0; pt < NPT; pt++) { quat U = STEPS[c][st] < 0 ? qinv(RU[pt]) : RU[pt]; quat W = qmul(U, M); for (int s = 0; s <= cap; s++) rep(s, W, T + ((size_t)pt * (cap + 1) + s) * RSTR); }
  return T; }
/* a link's tensor at a datum (the record's link_tensor body; EI: a corner slot reads its own table) -- the base tensors and the ladder's overrides */
static cplx **make_tensor(int l, const quat *dat, double *sw) { int m = NSLOT[l]; int nblk = LNBLK[l];
  for (int pt = 0; pt < NPT; pt++) { double w = RW[pt]; if (!FREE) { if (SELFON) { if (NSTAP[l] > 0) w *= wself(l, RU[pt]); if (NISTAP[l] > 0) w *= wself(ELIMOF[l], cei_partner_value(l, 0, RU[pt])); } else { for (int k = 0; k < NSTAP[l]; k++) { quat T = staple(l, k, dat); w *= wgt(qmul(RU[pt], T)); } for (int k = 0; k < NISTAP[l]; k++) { quat T = istaple(l, k, dat); w *= wgt(qmul(cei_partner_value(l, k, RU[pt]), T)); } } } sw[pt] = w; }
  cplx *CT[4] = { NULL, NULL, NULL, NULL }; for (int j = 0; j < m; j++) CT[j] = corner_table(l, j, dat);
  cplx **LTL = calloc(nblk, sizeof(cplx *));
  #pragma omp parallel for schedule(dynamic)
  for (int b = 0; b < nblk; b++) { int sp[4], bb = b, size = 1; for (int j = 0; j < m; j++) { sp[j] = bb % (LCAP[l][j] + 1); bb /= LCAP[l][j] + 1; size *= DIM[sp[j]] * DIM[sp[j]]; }
    cplx *B = calloc(size, sizeof(cplx)); LTL[b] = B;
    for (int pt = 0; pt < NPT; pt++) { double w = sw[pt]; const cplx *R[4]; for (int j = 0; j < m; j++) R[j] = CT[j] ? CT[j] + ((size_t)pt * (LCAP[l][j] + 1) + sp[j]) * RSTR : rmat(pt, sp[j], STEPS[SLC[l][j]][SLS[l][j]] < 0);
      if (m == 1) { int d0 = DIM[sp[0]]; for (int i = 0; i < d0 * d0; i++) B[i] += w * R[0][i]; }
      else if (m == 2) { int d0 = DIM[sp[0]], d1 = DIM[sp[1]]; for (int i = 0; i < d0 * d0; i++) { cplx f = w * R[0][i]; cplx *out = B + (size_t)i * d1 * d1; for (int k = 0; k < d1 * d1; k++) out[k] += f * R[1][k]; } }
      else if (m == 3) { int d0 = DIM[sp[0]], d1 = DIM[sp[1]], d2 = DIM[sp[2]]; for (int i = 0; i < d0 * d0; i++) { cplx f = w * R[0][i]; for (int k = 0; k < d1 * d1; k++) { cplx g = f * R[1][k]; cplx *out = B + ((size_t)i * d1 * d1 + k) * d2 * d2; for (int q = 0; q < d2 * d2; q++) out[q] += g * R[2][q]; } } }
      else { int d0 = DIM[sp[0]], d1 = DIM[sp[1]], d2 = DIM[sp[2]], d3 = DIM[sp[3]]; for (int i = 0; i < d0 * d0; i++) { cplx f = w * R[0][i]; for (int k = 0; k < d1 * d1; k++) { cplx g = f * R[1][k]; for (int q = 0; q < d2 * d2; q++) { cplx h = g * R[2][q]; cplx *out = B + (((size_t)i * d1 * d1 + k) * d2 * d2 + q) * d3 * d3; for (int r = 0; r < d3 * d3; r++) out[r] += h * R[3][r]; } } } } } }
  for (int j = 0; j < m; j++) free(CT[j]);
  return LTL; }
static void link_tensor(int l, const quat *dat) { int m = NSLOT[l]; int nblk = 1; for (int j = 0; j < m; j++) { LCAP[l][j] = cap_of(SLC[l][j]); nblk *= LCAP[l][j] + 1; } LNBLK[l] = nblk;
  SW[l] = malloc(sizeof(double) * NPT); LT[l] = make_tensor(l, dat, SW[l]); }
typedef struct { int nopen, open[128]; int ncyc, cyc[MAXCYC]; int nblk; cplx **blk; size_t *size; } state_t;
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
    int spin[MAXCYC]; for (int c = 0; c < NCYC; c++) spin[c] = ISLOOP[c] ? LSPIN[c] : -1; if (CLAMPC >= 0) spin[CLAMPC] = CLAMPS;
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
  int closed[MAXCYC], nclosed = 0; for (int i = 0; i < S->ncyc; i++) if (in_list(S->cyc[i], N.cyc, N.ncyc) < 0) closed[nclosed++] = S->cyc[i];
  N.nblk = 1; for (int i = 0; i < N.ncyc; i++) N.nblk *= WMAX + 1; N.blk = calloc(N.nblk, sizeof(cplx *)); N.size = calloc(N.nblk, sizeof(size_t));
  int nclblk = 1; for (int i = 0; i < nclosed; i++) nclblk *= WMAX + 1;
  for (int bn = 0; bn < N.nblk; bn++) {
    int spin[MAXCYC]; for (int c = 0; c < NCYC; c++) spin[c] = ISLOOP[c] ? LSPIN[c] : -1; if (CLAMPC >= 0) spin[CLAMPC] = CLAMPS;
    { int bb = bn; for (int i = 0; i < N.ncyc; i++) { spin[N.cyc[i]] = bb % (WMAX + 1); bb /= WMAX + 1; } }
    if (CLAMPC >= 0) if (in_list(CLAMPC, N.cyc, N.ncyc) >= 0) if (spin[CLAMPC] != CLAMPS) continue;   /* cei: the clamped cycle's other spins are the other slices' */
    int ndim[128]; size_t nsize = 1; for (int w = 0; w < N.nopen; w++) { ndim[w] = DIM[spin[WCYC[N.open[w]]]]; nsize *= ndim[w]; }
    cplx *NB = calloc(nsize, sizeof(cplx)); if (!NB) { fprintf(stderr, "out of memory at a state of %zu entries\n", nsize); exit(3); } N.blk[bn] = NB; N.size[bn] = nsize;
    for (int bc = 0; bc < nclblk; bc++) {
      double fw = 1; { int bb = bc; for (int i = 0; i < nclosed; i++) { int s = bb % (WMAX + 1); bb /= WMAX + 1; spin[closed[i]] = s; fw *= PFAC[closed[i]][s]; } }
      if (fw == 0) continue; if (CLAMPC >= 0) if (in_list(CLAMPC, closed, nclosed) >= 0) if (spin[CLAMPC] != CLAMPS) continue;   /* cei: the clamped cycle closes at its slice's spin alone */
      int bo = 0; { int mul = 1; for (int i = 0; i < S->ncyc; i++) { bo += spin[S->cyc[i]] * mul; mul *= WMAX + 1; } }
      int bt = 0; { int mul = 1; for (int j = 0; j < m; j++) { bt += spin[SLC[l][j]] * mul; mul *= LCAP[l][j] + 1; } }
      const cplx *OB_ = S->blk[bo]; const cplx *TB = (LTO[l] ? LTO[l] : LT[l])[bt]; if (!OB_ || !TB) continue;
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
/* ---- THE LADDER MODE (w2_strip_l.c 11:5x, the author; ported verbatim by EI except where marked): the forward sweep made ONCE per class
 * with every intermediate state stored, the final trace carried BACKWARD as a functional on the open wires, each outside link's flipped value
 * the contraction, at the cut after its last affected step, of a MINI-SWEEP against the backward functional there; the cut identity checked at
 * every cut.  EI: an outside link AFFECTS an object link whose staples hold it OR whose corner step's multiplier holds it. */
static void state_copy(const state_t *S, state_t *D) {
  D->nopen = S->nopen; memcpy(D->open, S->open, sizeof(int) * S->nopen); D->ncyc = S->ncyc; memcpy(D->cyc, S->cyc, sizeof(int) * S->ncyc); D->nblk = S->nblk;
  D->blk = calloc(S->nblk, sizeof(cplx *)); D->size = calloc(S->nblk, sizeof(size_t));
  for (int b = 0; b < S->nblk; b++) if (S->blk[b]) { D->blk[b] = malloc(sizeof(cplx) * S->size[b]); memcpy(D->blk[b], S->blk[b], sizeof(cplx) * S->size[b]); D->size[b] = S->size[b]; } }
static cplx contract_cut(const state_t *F, const state_t *R) {
  if (F->nopen != R->nopen || F->ncyc != R->ncyc) { fprintf(stderr, "ladder: the cut's sides differ (%d/%d open wires, %d/%d open cycles)\n", F->nopen, R->nopen, F->ncyc, R->ncyc); exit(1); }
  int posR[128]; for (int w = 0; w < F->nopen; w++) { posR[w] = in_list(F->open[w], R->open, R->nopen); if (posR[w] < 0) { fprintf(stderr, "ladder: wire %d open on one side of the cut only\n", F->open[w]); exit(1); } }
  for (int i = 0; i < F->ncyc; i++) if (in_list(F->cyc[i], R->cyc, R->ncyc) < 0) { fprintf(stderr, "ladder: cycle %d open on one side of the cut only\n", F->cyc[i]); exit(1); }
  cplx tot = 0;
  for (int bf = 0; bf < F->nblk; bf++) { int spin[MAXCYC]; for (int c = 0; c < NCYC; c++) spin[c] = ISLOOP[c] ? LSPIN[c] : -1;
    { int bb = bf; for (int i = 0; i < F->ncyc; i++) { spin[F->cyc[i]] = bb % (WMAX + 1); bb /= WMAX + 1; } }
    int br = 0; { int mul = 1; for (int i = 0; i < R->ncyc; i++) { br += spin[R->cyc[i]] * mul; mul *= WMAX + 1; } }
    double fw = 1; for (int i = 0; i < F->ncyc; i++) fw *= FAC[spin[F->cyc[i]]]; if (fw == 0) continue;
    const cplx *A_ = F->blk[bf], *B_ = R->blk[br]; if (!A_ || !B_) continue;
    int ndim[128]; size_t rstr[128]; { size_t mul = 1; for (int i = F->nopen - 1; i >= 0; i--) { ndim[i] = DIM[spin[WCYC[F->open[i]]]]; mul *= ndim[i]; } }
    { size_t mul = 1; for (int i = R->nopen - 1; i >= 0; i--) { rstr[i] = mul; mul *= DIM[spin[WCYC[R->open[i]]]]; } }
    size_t nsize = F->size[bf]; cplx acc = 0;
    for (size_t e = 0; e < nsize; e++) { size_t rem = e, o = 0; for (int w = F->nopen - 1; w >= 0; w--) { size_t ix = rem % ndim[w]; rem /= ndim[w]; o += ix * rstr[posR[w]]; } acc += A_[e] * B_[o]; }
    tot += fw * acc; }
  return tot; }
static void trace_state(const state_t *FN, int wAin, int wAout, int wBin, int wBout, state_t *R) {
  R->nopen = FN->nopen; memcpy(R->open, FN->open, sizeof(int) * FN->nopen); R->ncyc = 0; R->nblk = 1; R->blk = calloc(1, sizeof(cplx *)); R->size = calloc(1, sizeof(size_t));
  if (FN->nopen != 4 || FN->ncyc != 0) { fprintf(stderr, "ladder: the final state has %d open wires and %d open cycles\n", FN->nopen, FN->ncyc); exit(1); }
  int pos[4] = { in_list(wAin, R->open, 4), in_list(wAout, R->open, 4), in_list(wBin, R->open, 4), in_list(wBout, R->open, 4) };
  for (int i = 0; i < 4; i++) if (pos[i] < 0) { fprintf(stderr, "ladder: junction wire %d not open at the end\n", i); exit(1); }
  int dims[4]; size_t nsize = 1; for (int i = 0; i < 4; i++) { dims[i] = DIM[LSPIN[WCYC[R->open[i]]]]; nsize *= dims[i]; }
  R->blk[0] = calloc(nsize, sizeof(cplx)); R->size[0] = nsize;
  for (size_t e = 0; e < nsize; e++) { size_t rem = e; int ix[4]; for (int w = 3; w >= 0; w--) { ix[w] = rem % dims[w]; rem /= dims[w]; } if (ix[pos[0]] == ix[pos[1]] && ix[pos[2]] == ix[pos[3]]) R->blk[0][e] = 1; } }
static cplx **build_tensor(int l, const quat *dat) { double *sw = malloc(sizeof(double) * NPT); cplx **T = make_tensor(l, dat, sw); free(sw); return T; }
static void free_tensor(int l, cplx **T) { for (int b = 0; b < LNBLK[l]; b++) free(T[b]); free(T); }
static int ladder_mode(int wAin, int wAout, int wBin, int wBout, quat *DATA) {
  double ang = getenv("W2_LADANG") ? atof(getenv("W2_LADANG")) : PI; quat rot = { cos(ang / 2), sin(ang / 2), 0, 0 };
  static int NAFF[MAXOUT], AFF[MAXOUT][8], KMIN[MAXOUT], KMAX[MAXOUT]; int posof[MAXL]; for (int k = 0; k < NORD; k++) posof[order[k]] = k;
  for (int o = 0; o < NOUT; o++) { NAFF[o] = 0; KMIN[o] = NORD; KMAX[o] = -1; }
  for (int l = 0; l < NL; l++) {
    int cand[64], nc = 0; for (int k = 0; k < NSTAP[l]; k++) for (int j = 0; j < 3; j++) cand[nc++] = STAP[l][k][j][0];
    for (int j = 0; j < NSLOT[l]; j++) { int c = SLC[l][j], st = SLS[l][j]; for (int m = 0; m < STEPMN[c][st]; m++) cand[nc++] = STEPMO[c][st][m]; }   /* EI: the corner multipliers */
    for (int t = 0; t < nc; t++) { int o = cand[t], dup = 0; for (int i = 0; i < NAFF[o]; i++) if (AFF[o][i] == l) dup = 1; if (dup) continue;
      if (NAFF[o] >= 8) { fprintf(stderr, "ladder: an outside link in the staples of more than 8 object links\n"); return 1; } AFF[o][NAFF[o]++] = l; if (posof[l] < KMIN[o]) KMIN[o] = posof[l]; if (posof[l] > KMAX[o]) KMAX[o] = posof[l]; } }
  long spans = 0; int maxspan = 0, untouched = 0; for (int o = 0; o < NOUT; o++) { if (!NAFF[o]) { untouched++; continue; } int s = KMAX[o] - KMIN[o] + 1; spans += s; if (s > maxspan) maxspan = s; }
  printf("W2-LADDER-MODE angle=%.6f about x: %d outside links (%d in no staple), mini-sweep spans mean %.1f, max %d, of %d steps a full sweep\n", ang, NOUT, untouched, spans / (double)(NOUT - untouched), maxspan, NORD);
  static double VAL[MAXOUT][16], BASE[16];
  for (int a = 0; a <= LMAX; a++) { LSPIN[LOOPA] = a; LSPIN[LOOPB] = 0; double ts = now();
    state_t *FS = calloc(NORD + 1, sizeof(state_t)); state_t S; S.nopen = 0; S.ncyc = 0; S.nblk = 1; S.blk = calloc(1, sizeof(cplx *)); S.size = calloc(1, sizeof(size_t)); S.blk[0] = calloc(1, sizeof(cplx)); S.blk[0][0] = 1; S.size[0] = 1;
    state_copy(&S, &FS[0]); size_t stored = sizeof(cplx), peak = 1;
    for (int k = 0; k < NORD; k++) { process(&S, order[k]); state_copy(&S, &FS[k + 1]); size_t tot = 0; for (int b = 0; b < S.nblk; b++) tot += S.size[b]; stored += tot * sizeof(cplx); if (tot > peak) peak = tot;
      if (tot > CEIL) { fprintf(stderr, "W2-REFUSED: the state reached %zu entries after link %d of %d, above the ceiling %zu (W2_CEIL)\n", tot, k + 1, NORD, CEIL); return 3; } }
    state_t R; trace_state(&FS[NORD], wAin, wAout, wBin, wBout, &R);
    cplx base = contract_cut(&FS[NORD], &R); BASE[a] = creal(base); double maxdev = 0; long mini = 0;
    for (int k = NORD; k >= 1; k--) {
      cplx cut = contract_cut(&FS[k], &R); double dev = cabs(cut - base); if (dev > maxdev) maxdev = dev;
      for (int o = 0; o < NOUT; o++) if (NAFF[o] && KMAX[o] == k - 1) {
        quat save = DATA[o]; DATA[o] = qmul(rot, DATA[o]); for (int i = 0; i < NAFF[o]; i++) LTO[AFF[o][i]] = build_tensor(AFF[o][i], DATA); DATA[o] = save;
        state_t G; state_copy(&FS[KMIN[o]], &G); for (int kk = KMIN[o]; kk <= KMAX[o]; kk++) process(&G, order[kk]);
        VAL[o][a] = creal(contract_cut(&G, &R)); free_state(&G); mini += KMAX[o] - KMIN[o] + 1;
        for (int i = 0; i < NAFF[o]; i++) { free_tensor(AFF[o][i], LTO[AFF[o][i]]); LTO[AFF[o][i]] = NULL; } }
      process(&R, order[k - 1]); }
    { cplx full = contract_cut(&FS[0], &R); double dev = cabs(full - base); if (dev > maxdev) maxdev = dev; }
    printf("W2-LADDER-CLASS a=%d c=0: base %+.12e (imag %.1e); the cut identity held at every one of %d cuts to %.1e; %ld mini-sweep steps against %d for a link-by-link ladder; stored states %.0f MB, peak state %zu; %.1f s\n", a, creal(base), cimag(base), NORD + 1, maxdev, mini, NORD * NOUT, stored / 1048576.0, peak, now() - ts);
    for (int k = 0; k <= NORD; k++) free_state(&FS[k]); free(FS); free_state(&R); free_state(&S); }
  for (int o = 0; o < NOUT; o++) { if (!NAFF[o]) { printf("W2-LAD link %d (%d,%d,%d,%d dir %d): in no staple, no influence\n", o, OB[o][0], OB[o][1], OB[o][2], OB[o][3], OD[o]); continue; }
    double zr = VAL[o][0] / BASE[0], d1 = 0, d2 = 0; if (LMAX >= 1) d1 = VAL[o][1] / VAL[o][0] - BASE[1] / BASE[0]; if (LMAX >= 2) d2 = VAL[o][2] / VAL[o][0] - BASE[2] / BASE[0];
    printf("W2-LAD Z_l/Z = %.12e; dE[chi_1(A)] = %+.12e dE[chi_2(A)] = %+.12e; W2-ROT link %d (%d,%d,%d,%d dir %d) by %.6f\n", zr, d1, d2, o, OB[o][0], OB[o][1], OB[o][2], OB[o][3], OD[o], ang); }
  printf("W2-LADDER-DONE %d links\n", NOUT); return 0; }
/* EI: THE GEOMETRY DUMP (W2_GEOM=1) -- every plaquette the engine integrates, by role, and the link sets; eigeom.awk compares it member by member */
static void geom_dump(void) {
  for (int l = 0; l < NL; l++) printf("W2-GEOM LINK %d %d %d %d %d\n", LB[l][0], LB[l][1], LB[l][2], LB[l][3], LD[l]);
  for (int o = 0; o < NOUT; o++) printf("W2-GEOM OUT %d %d %d %d %d\n", OB[o][0], OB[o][1], OB[o][2], OB[o][3], OD[o]);
  for (int p = 0; p < NP; p++) printf("W2-GEOM FACE %d %d %d %d %d %d\n", PB[p][0], PB[p][1], PB[p][2], PB[p][3], PD1[p], PD2[p]);
  for (int i = 0; i < NCORN; i++) { int c = CORN0 + i; printf("W2-GEOM CORNER %d %d %d %d %d %d steps", PB[c][0], PB[c][1], PB[c][2], PB[c][3], PD1[c], PD2[c]);
    for (int st = 0; st < NSTEP[c]; st++) { int l = STEPL[c][st]; printf(" [%d,%d,%d,%d d%d %+d mult", LB[l][0], LB[l][1], LB[l][2], LB[l][3], LD[l], STEPS[c][st]);
      for (int m = 0; m < STEPMN[c][st]; m++) { int o = STEPMO[c][st][m]; printf(" %d,%d,%d,%d d%d %+d", OB[o][0], OB[o][1], OB[o][2], OB[o][3], OD[o], STEPMS[c][st][m]); } printf("]"); } printf("\n"); }
  /* a staple of link l in plane (d, k): its base is l's base, moved back along k when the staple's first link was the reversed k-link */
  for (int l = 0; l < NL; l++) for (int k = 0; k < NSTAP[l]; k++) { int o0 = STAP[l][k][0][0], o1 = STAP[l][k][1][0]; int d = LD[l], kk = OD[o0]; int base[4]; memcpy(base, LB[l], sizeof base);
    if (STAP[l][k][0][1] < 0) base[kk - 1]--; int d1 = d < kk ? d : kk, d2 = d < kk ? kk : d; (void)o1;
    printf("W2-GEOM STAPLE %d %d %d %d %d %d link %d %d %d %d %d\n", base[0], base[1], base[2], base[3], d1, d2, LB[l][0], LB[l][1], LB[l][2], LB[l][3], d); } }
int main(int argc, char **argv) {
  if (argc < 5) { fprintf(stderr, "usage: w2_strip_n beta WMAX LMAX DATUM [fwd|rev] [bent|planar] [n]   DATUM = free | ordered | random:SEED | cancel\n"); return 1; }
  BETA = atof(argv[1]); WMAX = atoi(argv[2]); LMAX = atoi(argv[3]); const char *datum = argv[4]; int rev = (argc > 5 && !strcmp(argv[5], "rev"));
  PLANAR = (argc > 6 && !strcmp(argv[6], "planar")); if (argc > 7) NN = atoi(argv[7]);
  CEIL = getenv("W2_CEIL") ? (size_t)atoll(getenv("W2_CEIL")) : (size_t)400000000;   /* the state ceiling: 4e8 entries (6.4 GB), refused above it by name */
  if (WMAX > 15 || LMAX > 15 || WMAX < 0 || LMAX < 0 || NN < 1 || NN > 4) { fprintf(stderr, "caps or n out of range\n"); return 1; }
  SMAX = WMAX > LMAX ? WMAX : LMAX; FREE = !strcmp(datum, "free");
  FACT[0] = 1; for (int i = 1; i < 40; i++) FACT[i] = FACT[i - 1] * i;
  for (int s = 0; s <= 30; s++) { A[s] = bessel(s + 1, BETA) / bessel(1, BETA); DIM[s] = s + 1; FAC[s] = (s <= WMAX) ? (s + 1) * A[s] : 0; }
  /* EI: the doors -- W2_CORNER=staple (the record's defect, reproduced) and W2_WEIGHT=sq (fix 2's positive truncation) */
  if (getenv("W2_CORNER")) { if (!strcmp(getenv("W2_CORNER"), "staple")) CORNERMODE = 0; else if (!strcmp(getenv("W2_CORNER"), "cycle")) CORNERMODE = 1; else { fprintf(stderr, "W2_CORNER must be staple or cycle\n"); return 1; } }
  if (getenv("W2_WEIGHT")) { if (!strcmp(getenv("W2_WEIGHT"), "sq")) SQW = 1; else if (strcmp(getenv("W2_WEIGHT"), "direct")) { fprintf(stderr, "W2_WEIGHT must be sq or direct\n"); return 1; } }
  if (SQW) { if (WMAX % 2) { fprintf(stderr, "W2_WEIGHT=sq REFUSED: an odd WMAX (h_J runs to s <= WMAX/2 and its square to s <= WMAX, so WMAX is even)\n"); return 1; }
    int mh = WMAX / 2; double hs[32], cu[64]; for (int s = 0; s <= mh; s++) hs[s] = (s + 1) * bessel(s + 1, BETA / 2) / bessel(1, BETA / 2);   /* h's chi_s coefficients, h at beta/2, h_0 = 1 */
    for (int u = 0; u < 64; u++) cu[u] = 0;
    for (int s = 0; s <= mh; s++) for (int t = 0; t <= mh; t++) for (int u = abs(s - t); u <= s + t; u += 2) cu[u] += hs[s] * hs[t];   /* chi_s chi_t = sum_u chi_u (Clebsch-Gordan) */
    for (int u = 0; u <= 30; u++) { FAC[u] = (u <= WMAX) ? cu[u] / cu[0] : 0; if (u <= WMAX) A[u] = FAC[u] / (u + 1); }
    printf("W2-WEIGHT sq: h_J^2 with h the Wilson weight at beta/2 = %g truncated at s <= %d; chi_u coefficients (normalised):", BETA / 2, mh); for (int u = 0; u <= WMAX; u++) printf(" %.12e", FAC[u]); printf("\n"); }
  for (int c = 0; c < MAXCYC; c++) for (int s = 0; s < 32; s++) PFAC[c][s] = FAC[s];   /* cei: the per-cycle closing weights, the Wilson ones unless a source is set */
  if (getenv("CEI_SUBST") && atoi(getenv("CEI_SUBST")) == 1) CEI = 2; else if (getenv("CEI_DROPLOOPS") && atoi(getenv("CEI_DROPLOOPS")) == 1) CEI = 1;
  if (getenv("CEI_C")) { double cw, cx, cy, cz; if (sscanf(getenv("CEI_C"), "%lf:%lf:%lf:%lf", &cw, &cx, &cy, &cz) != 4) { fprintf(stderr, "CEI_C must be w:x:y:z\n"); return 1; } double nn = sqrt(cw * cw + cx * cx + cy * cy + cz * cz); if (nn < 1e-12) { fprintf(stderr, "CEI_C: zero\n"); return 1; } CEIC.w = cw / nn; CEIC.x = cx / nn; CEIC.y = cy / nn; CEIC.z = cz / nn; }
  if (getenv("CEI_SRC")) { NSRC = sscanf(getenv("CEI_SRC"), "%d,%d", &SRC[0], &SRC[1]); if (NSRC < 1) { fprintf(stderr, "CEI_SRC must be p or p,q\n"); return 1; } }
  if (getenv("CEI_KSELF")) KSELF = atoi(getenv("CEI_KSELF"));
  if (CEI || NSRC) setvbuf(stdout, NULL, _IONBF, 0);   /* cei: unbuffered, so a run that dies leaves its last line (the plain runs stay as the record's) */
  double t0 = now();
  { quat q1 = {0.5, 0.5, 0.5, 0.5}, q2 = {1 / sqrt(2), 0, 1 / sqrt(2), 0}, q3 = {0.6, 0, 0.8, 0}; quat q12 = qmul(q1, q2); int bad = 0;
    for (int trial = 0; trial < 2; trial++) { GENINV = trial; double dmax = 0; for (int s = 1; s <= SMAX; s++) { int d = s + 1; cplx P[256], X1[256], X2[256], Y[256]; rep(s, q12, P); rep(s, q1, X1); rep(s, q2, X2);
        for (int i = 0; i < d; i++) for (int j = 0; j < d; j++) { cplx acc = 0; for (int k = 0; k < d; k++) acc += X1[i * d + k] * X2[k * d + j]; Y[i * d + j] = acc; }
        for (int i = 0; i < d * d; i++) if (cabs(Y[i] - P[i]) > dmax) dmax = cabs(Y[i] - P[i]); }
      if (dmax < 1e-12) break; if (trial == 1) { fprintf(stderr, "neither substitution composes\n"); return 1; } }
    for (int s = 0; s <= SMAX; s++) { int d = s + 1; cplx X[256]; rep(s, q3, X); cplx tr = 0; for (int i = 0; i < d; i++) tr += X[i * d + i]; if (fabs(creal(tr) - chi(s, q3)) > 1e-12 || fabs(cimag(tr)) > 1e-12) bad++; }
    printf("W2-KAT representations to spin %d/2 (GENINV=%d): homomorphism and traces [%s]\n", SMAX, GENINV, bad ? "FAILED" : "MET"); if (bad) return 1; }
  if (getenv("CEI_STRIP")) { STRIPK = atoi(getenv("CEI_STRIP")); if (STRIPK < 2 || !PLANAR || CEI < 1) { fprintf(stderr, "CEI_STRIP=K needs K >= 2, the planar object and CEI_SUBST=1 or CEI_DROPLOOPS=1\n"); return 1; } }
  if (STRIPK) cei_build_strip(); else build(); if (CEI == 2) cei_substitute(); else if (CEI == 1) cei_drop_loops(); slots();
  if (getenv("CEI_ORDER")) cei_read_order(getenv("CEI_ORDER"));
  if (getenv("CEI_SELF")) cei_read_self(getenv("CEI_SELF"));
  if (NSRC) for (int i = 0; i < NSRC; i++) if (SRC[i] < 0 || SRC[i] >= NP) { fprintf(stderr, "CEI_SRC: plaquette %d outside 0..%d\n", SRC[i], NP - 1); return 1; }
  /* the census: every object link lies in 6 plaquettes of Z^4, the face ones excepted the rest are its staples and (EI) its corner cycles */
  int n5 = 0, n4 = 0, nother = 0, ncs = 0; for (int l = 0; l < NL; l++) { int nc = 0; for (int j = 0; j < NSLOT[l]; j++) if (SLC[l][j] >= CORN0) nc++; ncs += nc; int t = NSTAP[l] + nc; if (t == 5) n5++; else if (t == 4) n4++; else nother++; }
  if (nother) if (!CEI) { fprintf(stderr, "a link with neither four nor five staples\n"); return 1; }
  int deg = 0; for (int l = 0; l < NL; l++) { int d = (NSTAP[l] + NISTAP[l]) * WMAX; if (SELFON) d = KSELF * ((NSTAP[l] > 0) + (NISTAP[l] > 0));   /* cei: the partner's inverse staples raise its degree; a self-energy weight has degree KSELF */ for (int j = 0; j < NSLOT[l]; j++) d += cap_of(SLC[l][j]); if (d > deg) deg = d; } if (deg < 12) deg = 12; make_rule(deg);
  printf("W2-OBJECT %s n=%d plaquettes=%d links=%d (shared=%d) outside=%d staples five=%d four=%d; rule degree %d, %d points; beta=%g WMAX=%d LMAX=%d datum=%s order=%s", PLANAR ? "planar" : "bent", NN, NP, NL, SHARED0, NOUT, n5, n4, deg, NPT, BETA, WMAX, LMAX, datum, rev ? "rev" : "fwd");
  if (NCORN) printf("; corners=%d as cycles (%d corner slots; the record's staple census by plaquettes through each link)", NCORN, ncs);
  if (!CORNERMODE) printf("; W2_CORNER=staple (the record's defect)");
  if (SQW) printf("; weight sq");
  printf("\n");
  if (getenv("W2_GEOM")) { geom_dump(); if (!strcmp(getenv("W2_GEOM"), "only")) return 0; }
  quat *DATA = malloc(sizeof(quat) * (NOUT + 1)); for (int i = 0; i < NOUT; i++) { quat e = { 1, 0, 0, 0 }; DATA[i] = e; }
  if (!strcmp(datum, "cancel")) { quat want[4] = { {1,0,0,0}, {-1,0,0,0}, {0,1,0,0}, {0,-1,0,0} }; if (NSTAP[SHARED0] != 4) { fprintf(stderr, "the shared link has %d staples, not 4\n", NSTAP[SHARED0]); return 1; } for (int k = 0; k < 4; k++) DATA[STAP[SHARED0][k][1][0]] = qinv(want[k]); }
  else if (!strncmp(datum, "random:", 7)) {   /* THE HAAR-RANDOM DATUM SEEDED BY GEOMETRY (05:0x): each outside link's quaternion is a function of its
      coordinates, its direction and the seed, never of the link's index -- so the same link gets the same datum in every engine, at every n and
      in both objects (the index-seeded datum of w2_strip.c parted from this one at n = 2: a different numbering, a different datum) */
    unsigned long long seed = (unsigned long long)atoll(datum + 7);
    for (int i = 0; i < NOUT; i++) { unsigned long long h = seed * 0x9E3779B97F4A7C15ULL + 0x1234567ULL; for (int j = 0; j < 4; j++) h = (h ^ (unsigned long long)(OB[i][j] + 1000003)) * 0xBF58476D1CE4E5B9ULL; h = (h ^ (unsigned long long)(OD[i] * 7919)) * 0x94D049BB133111EBULL;
      double g[4], nn = 0; for (int j = 0; j < 4; j += 2) { h ^= h >> 31; h *= 0xD6E8FEB86659FD93ULL; h ^= h >> 32; double u1 = ((h >> 11) + 1.0) / 9007199254740994.0; h ^= h >> 29; h *= 0xBF58476D1CE4E5B9ULL; h ^= h >> 32; double u2 = (h >> 11) / 9007199254740992.0; double r = sqrt(-2 * log(u1)); g[j] = r * cos(2 * PI * u2); g[j + 1] = r * sin(2 * PI * u2); }
      for (int j = 0; j < 4; j++) nn += g[j] * g[j]; nn = sqrt(nn); quat q = { g[0] / nn, g[1] / nn, g[2] / nn, g[3] / nn }; DATA[i] = q; } }
  else if (!strncmp(datum, "file:", 5)) cei_read_datum(datum + 5, DATA);
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
  /* EI: W2_DATUMC=<file>: the outside BY COORDINATES, "x y z w dir qw qx qy qz" per line; every outside link required, a line naming no outside link
     of this object (a record's phantom, say) skipped and counted -- so one datum reaches engines whose outside numberings differ */
  if (getenv("W2_DATUMC")) { FILE *df = fopen(getenv("W2_DATUMC"), "r"); if (!df) { fprintf(stderr, "W2_DATUMC: cannot open %s\n", getenv("W2_DATUMC")); return 1; }
    int seen[MAXOUT]; memset(seen, 0, sizeof seen); int bb[4], dd, nread = 0, extra = 0; double qw, qx, qy, qz;
    while (fscanf(df, "%d %d %d %d %d %lf %lf %lf %lf", &bb[0], &bb[1], &bb[2], &bb[3], &dd, &qw, &qx, &qy, &qz) == 9) { int idx = -1; for (int i = 0; i < NOUT; i++) if (OD[i] == dd && !memcmp(OB[i], bb, sizeof bb)) { idx = i; break; }
      if (idx < 0) { extra++; continue; } if (seen[idx]) { fprintf(stderr, "W2_DATUMC: the link (%d,%d,%d,%d dir %d) repeated\n", bb[0], bb[1], bb[2], bb[3], dd); return 1; }
      double nn = sqrt(qw * qw + qx * qx + qy * qy + qz * qz); if (nn < 1e-12) { fprintf(stderr, "W2_DATUMC: a zero quaternion\n"); return 1; } quat q = { qw / nn, qx / nn, qy / nn, qz / nn }; DATA[idx] = q; seen[idx] = 1; nread++; }
    fclose(df); if (nread != NOUT) { for (int i = 0; i < NOUT; i++) if (!seen[i]) { fprintf(stderr, "W2_DATUMC REFUSED: the outside link (%d,%d,%d,%d dir %d) is not in the file (%d of %d given)\n", OB[i][0], OB[i][1], OB[i][2], OB[i][3], OD[i], nread, NOUT); break; } return 1; }
    printf("W2-DATUMC %s: all %d outside links set by coordinates (the named datum %s overridden); %d lines named no outside link of this object, skipped\n", getenv("W2_DATUMC"), NOUT, datum, extra); }
  /* EI: THE GAUGE DOOR (the known answer K1): W2_GAUGE="x,y,z,w:qw:qx:qy:qz": every GENUINE outside link leaving the vertex v becomes g U, every one entering it U g^-1
     (U_{p->q} -> g_p U g_q^-1).  An outside entry that carries an object link's coordinates is the record's phantom, not a link: it is left alone and counted.  Haar on the object
     links at v absorbs the rest, so every class moment and channel is invariant at every vertex -- for the true object, and for no phantom-carrying one */
  if (getenv("W2_GAUGE")) { int v[4]; double gw, gx, gy, gz; if (sscanf(getenv("W2_GAUGE"), "%d,%d,%d,%d:%lf:%lf:%lf:%lf", &v[0], &v[1], &v[2], &v[3], &gw, &gx, &gy, &gz) != 8) { fprintf(stderr, "W2_GAUGE must be x,y,z,w:qw:qx:qy:qz\n"); return 1; }
    double nn = sqrt(gw * gw + gx * gx + gy * gy + gz * gz); if (nn < 1e-12) { fprintf(stderr, "W2_GAUGE: a zero quaternion\n"); return 1; } quat g = { gw / nn, gx / nn, gy / nn, gz / nn }; int nl = 0, ne = 0, nph = 0;
    for (int i = 0; i < NOUT; i++) { int e[4]; memcpy(e, OB[i], sizeof e); e[OD[i] - 1]++; int leaves = !memcmp(OB[i], v, sizeof v), enters = !memcmp(e, v, sizeof v); if (!leaves && !enters) continue;
      if (lkey(OB[i], OD[i], 0) >= 0) { nph++; continue; } if (leaves) { DATA[i] = qmul(g, DATA[i]); nl++; } if (enters) { DATA[i] = qmul(DATA[i], qinv(g)); ne++; } }
    int onobj = 0; for (int l = 0; l < NL; l++) { int e[4]; memcpy(e, LB[l], sizeof e); e[LD[l] - 1]++; if (!memcmp(LB[l], v, sizeof v) || !memcmp(e, v, sizeof v)) onobj = 1; }
    printf("W2-GAUGE vertex (%d,%d,%d,%d) g=(%.6f,%.6f,%.6f,%.6f): %d outside links leaving, %d entering, transformed; %d phantom entries left alone; an %s vertex\n", v[0], v[1], v[2], v[3], g.w, g.x, g.y, g.z, nl, ne, nph, onobj ? "object" : "outside"); }
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
  cei_gauges(DATA);   /* the multi-vertex gauge door (campaign 32 CORRECTION): CEI_GAUGES applied before the link tensors are built from the datum */
  for (int l = 0; l < NL; l++) if (!ELIM[l]) link_tensor(l, DATA);
  printf("W2-TENSORS built in %.1f s\n", now() - t0);
  if (rev) for (int i = 0; i < NORD / 2; i++) { int t = order[i]; order[i] = order[NORD - 1 - i]; order[NORD - 1 - i] = t; }
  if (CEI) {   /* ---- cei_face: the sweeps of the substituted object -- Z and its source-tilted companions; the slices when a cycle is clamped; the configurations branched at the first source closing ---- */
    if (LMAX != 0) { fprintf(stderr, "CEI REFUSED: the loop cycles are dropped, so LMAX must be 0\n"); return 1; }
    for (int w = 0; w < NW; w++) FIXV[w] = -1;   /* no wire clamped (the engine initialises this after the point where this driver runs) */
    if (getenv("CEI_PEAK")) PEAKLIST = atoi(getenv("CEI_PEAK")); if (getenv("CEI_PROFILE")) PROFILE = atoi(getenv("CEI_PROFILE")); if (getenv("CEI_NOBRANCH") && atoi(getenv("CEI_NOBRANCH")) == 1) BRANCH = 0;
    if (getenv("CEI_LISTOUT") && atoi(getenv("CEI_LISTOUT")) == 1) cei_list_out(DATA);   /* the outside links with the datum's values, "x y z t d w x y z" -- the datum file's own format */
    if (getenv("CEI_PIN") && atoi(getenv("CEI_PIN")) == 1) {   /* THE PINNING (campaign 31.17): per surviving link, the norm of the sum of its staples' group elements at the datum (5 at the identity datum, 0 when they cancel) and of the partner's inverse staples' -- a datum invariant to put beside the cell's gap */
      for (int l = 0; l < NL; l++) { if (ELIM[l]) continue; quat s = { 0, 0, 0, 0 }; for (int k = 0; k < NSTAP[l]; k++) { quat T = staple(l, k, DATA); s.w += T.w; s.x += T.x; s.y += T.y; s.z += T.z; }
        quat si = { 0, 0, 0, 0 }; for (int k = 0; k < NISTAP[l]; k++) { quat T = istaple(l, k, DATA); si.w += T.w; si.x += T.x; si.y += T.y; si.z += T.z; }
        printf("CEI-PIN link %d (%d,%d,%d) d%d staples %d |sum| = %.6f inverse-staples %d |sum| = %.6f\n", l, LB[l][0], LB[l][1], LB[l][2], LD[l], NSTAP[l], sqrt(s.w * s.w + s.x * s.x + s.y * s.y + s.z * s.z), NISTAP[l], sqrt(si.w * si.w + si.x * si.x + si.y * si.y + si.z * si.z)); } }
    if (getenv("CEI_CLAMP")) { if (sscanf(getenv("CEI_CLAMP"), "%d:%d:%d", &CLAMPC, &CLAMPWA, &CLAMPWB) != 3 || CLAMPC < 0 || CLAMPC >= NCYC || ISLOOP[CLAMPC] || NSTEP[CLAMPC] == 0) { fprintf(stderr, "CEI_CLAMP must be cycle:wireA:wireB with a live plaquette or corner cycle\n"); return 1; }
      if (CLAMPWA < WBASE[CLAMPC] || CLAMPWA >= WBASE[CLAMPC] + NWIRE[CLAMPC] || CLAMPWB < WBASE[CLAMPC] || CLAMPWB >= WBASE[CLAMPC] + NWIRE[CLAMPC] || CLAMPWA == CLAMPWB) { fprintf(stderr, "CEI_CLAMP: the two wires must be distinct wires of cycle %d (%d..%d)\n", CLAMPC, WBASE[CLAMPC], WBASE[CLAMPC] + NWIRE[CLAMPC] - 1); return 1; }
      int nsl = 0; for (int s = 0; s <= WMAX; s++) nsl += DIM[s] * DIM[s];
      printf("CEI-CLAMP cycle %d (steps %d) wires %d and %d: the slices (spin s, two indices < d_s) summed outside -- %d slices at WMAX %d; %s\n", CLAMPC, NSTEP[CLAMPC], CLAMPWA, CLAMPWB, nsl, WMAX,
        NWIRE[CLAMPC] == 2 ? "every wire of the cycle fixed, so it never enters the state and its closing weight is applied once per slice by the driver" : "the cycle's other wires open as usual, its closing through the state at the slice's spin"); }
    if (SELFON) { double FS1[32], dmax = 0; double i1 = bessel(1, BETA); for (int k = 1; k <= WMAX; k++) FS1[k] = (k + 1) * bessel(k + 1, BETA) / i1;
      for (int pt = 0; pt < NPT; pt++) { double a = 1; for (int k = 1; k <= WMAX; k++) a += FS1[k] * chi(k, RU[pt]); double dd = fabs(a - wgt(RU[pt])); if (dd > dmax) dmax = dd; }
      printf("CEI-SELF-KAT kappa=1 at the cap WMAX: max |self weight - the staple weight wgt| over the rule's %d points = %.1e (the same Bessel ratios); kappa=0: the weight is 1 by construction\n", NPT, dmax); }
    int ncfg = (NSRC == 0) ? 1 : (NSRC == 1 ? 2 : 4); double ZZ[4] = { 0, 0, 0, 0 }, ZI[4] = { 0, 0, 0, 0 }, tcfg[4] = { 0, 0, 0, 0 }; const char *nm[4] = { "none", "p", "q", "pq" };
    const int *ord = NCEIORD ? CEIORD : order; int nord = NCEIORD ? NCEIORD : NORD;
    if (getenv("CEI_TRANSFER")) {   /* ---- THE TRANSFER OPERATOR OF ONE CELL (campaign 31.15): the sweep to the cut after step iA (1-based over the order, eliminated
         links counted as the profile counts them), every basis vector of that cut's state space injected and carried through the links of steps iA+1..iB, the
         cut after iB read back as the translate (cycles + csh, wires + wsh); then the two leading eigenvalues by power iteration and deflation ---- */
      int iA, iB, csh, wsh; if (sscanf(getenv("CEI_TRANSFER"), "%d:%d:%d:%d", &iA, &iB, &csh, &wsh) != 4 || iA < 1 || iB <= iA || iB > nord) { fprintf(stderr, "CEI_TRANSFER must be iA:iB:cycleshift:wireshift\n"); return 1; }
      for (int c = 0; c < NCYC; c++) for (int q = 0; q <= WMAX; q++) PFAC[c][q] = FAC[q];
      state_t SA; SA.nopen = 0; SA.ncyc = 0; SA.nblk = 1; SA.blk = calloc(1, sizeof(cplx *)); SA.size = calloc(1, sizeof(size_t)); SA.blk[0] = calloc(1, sizeof(cplx)); SA.blk[0][0] = 1; SA.size[0] = 1;
      for (int i = 0; i < iA; i++) { if (ELIM[ord[i]]) continue; process(&SA, ord[i]); }
      int dim = 0; size_t boff[4096]; if (SA.nblk > 4096) { fprintf(stderr, "CEI_TRANSFER: too many blocks\n"); return 1; }
      for (int b = 0; b < SA.nblk; b++) { boff[b] = dim; dim += (int)SA.size[b]; }
      printf("CEI-TRANSFER the cut after step %d: %d open cycles (", iA, SA.ncyc); for (int i = 0; i < SA.ncyc; i++) printf("%sc%d", i ? " " : "", SA.cyc[i]); printf("), %d open wires (", SA.nopen); for (int w = 0; w < SA.nopen; w++) printf("%sw%d", w ? " " : "", SA.open[w]);
      printf("), dimension %d; the cell's links are steps %d..%d; the cut after step %d read as the translate (cycles +%d, wires +%d)\n", dim, iA + 1, iB, iB, csh, wsh);
      cplx *T = calloc((size_t)dim * dim, sizeof(cplx)); if (!T) { fprintf(stderr, "CEI_TRANSFER: out of memory for T (%d x %d)\n", dim, dim); return 3; }
      int ncol = 0, bad = 0;
      for (int b = 0; b < SA.nblk; b++) { if (!SA.blk[b]) continue;
        for (size_t e = 0; e < SA.size[b]; e++) {
          state_t U; U.nopen = SA.nopen; memcpy(U.open, SA.open, sizeof(int) * SA.nopen); U.ncyc = SA.ncyc; memcpy(U.cyc, SA.cyc, sizeof(int) * SA.ncyc); U.nblk = SA.nblk;
          U.blk = calloc(U.nblk, sizeof(cplx *)); U.size = calloc(U.nblk, sizeof(size_t)); U.blk[b] = calloc(SA.size[b], sizeof(cplx)); U.blk[b][e] = 1; U.size[b] = SA.size[b];
          for (int i = iA; i < iB; i++) { if (ELIM[ord[i]]) continue; process(&U, ord[i]); }
          if (U.ncyc != SA.ncyc || U.nopen != SA.nopen) { fprintf(stderr, "CEI_TRANSFER: the cut after step %d has %d cycles and %d wires, the cut after %d had %d and %d\n", iB, U.ncyc, U.nopen, iA, SA.ncyc, SA.nopen); return 1; }
          int pin[MAXCYC], pw[128];
          for (int i = 0; i < U.ncyc; i++) { pin[i] = in_list(U.cyc[i] - csh, SA.cyc, SA.ncyc); if (pin[i] < 0) { if (!bad) fprintf(stderr, "CEI_TRANSFER: output cycle c%d is not a translate of the cut's\n", U.cyc[i]); bad++; } }
          for (int w = 0; w < U.nopen; w++) { pw[w] = in_list(U.open[w] - wsh, SA.open, SA.nopen); if (pw[w] < 0) { if (!bad) fprintf(stderr, "CEI_TRANSFER: output wire w%d is not a translate of the cut's\n", U.open[w]); bad++; } }
          if (bad) return 1;
          for (int b2 = 0; b2 < U.nblk; b2++) { if (!U.blk[b2]) continue;
            int sp[MAXCYC]; { int bb = b2; for (int i = 0; i < U.ncyc; i++) { sp[i] = bb % (WMAX + 1); bb /= WMAX + 1; } }
            int bin = 0; { for (int i = 0; i < U.ncyc; i++) { int mul = 1; for (int k = 0; k < pin[i]; k++) mul *= WMAX + 1; bin += sp[i] * mul; } }
            int spinin[MAXCYC]; for (int c = 0; c < NCYC; c++) spinin[c] = -1; for (int i = 0; i < U.ncyc; i++) spinin[SA.cyc[pin[i]]] = sp[i];
            size_t sin_[128]; { size_t mul = 1; for (int i = SA.nopen - 1; i >= 0; i--) { sin_[i] = mul; mul *= DIM[spinin[WCYC[SA.open[i]]]]; } }
            int od[128]; { for (int w = 0; w < U.nopen; w++) { int c = U.cyc[0]; for (int i = 0; i < U.ncyc; i++) if (WCYC[U.open[w]] == U.cyc[i]) c = i; od[w] = DIM[sp[c]]; } }
            for (size_t e2 = 0; e2 < U.size[b2]; e2++) { cplx v = U.blk[b2][e2]; if (v == 0) continue; size_t rem = e2, ein = 0; for (int w = U.nopen - 1; w >= 0; w--) { size_t ix = rem % od[w]; rem /= od[w]; ein += ix * sin_[pw[w]]; }
              T[(boff[bin] + ein) * dim + (boff[b] + e)] += v; } }
          free_state(&U); ncol++; } }
      printf("  T built: %d columns of %d; |T| max %.6e\n", ncol, dim, 0.0);
      { double tmax = 0; for (size_t k = 0; k < (size_t)dim * dim; k++) if (cabs(T[k]) > tmax) tmax = cabs(T[k]); double fro = 0, asym = 0; for (int i = 0; i < dim; i++) for (int j = 0; j < dim; j++) { fro += cabs(T[(size_t)i * dim + j]) * cabs(T[(size_t)i * dim + j]); asym += cabs(T[(size_t)i * dim + j] - T[(size_t)j * dim + i]) * cabs(T[(size_t)i * dim + j] - T[(size_t)j * dim + i]); }
        printf("  |T|: max entry %.6e, Frobenius %.6e, ||T - T^t||_F / ||T||_F = %.3e (T is symmetric in the wire basis iff the reflected cell is the cell)\n", tmax, sqrt(fro), sqrt(asym / fro)); }
      /* the leading eigenpair by power iteration, the left vector from T^t, the second eigenvalue by deflation */
      cplx *v = malloc(sizeof(cplx) * dim), *w = malloc(sizeof(cplx) * dim), *u = malloc(sizeof(cplx) * dim); double lam1 = 0, lam2 = 0; int it1 = 0, it2 = 0, itu = 0;
      for (int i = 0; i < dim; i++) v[i] = 1.0 / sqrt((double)dim);
      for (it1 = 0; it1 < 20000; it1++) { for (int i = 0; i < dim; i++) { cplx s = 0; for (int j = 0; j < dim; j++) s += T[(size_t)i * dim + j] * v[j]; w[i] = s; }
        double nw = 0; for (int i = 0; i < dim; i++) nw += cabs(w[i]) * cabs(w[i]); nw = sqrt(nw); double dd = 0, dd2 = 0; for (int i = 0; i < dim; i++) { cplx nv = w[i] / nw; dd += cabs(nv - v[i]) * cabs(nv - v[i]); dd2 += cabs(nv + v[i]) * cabs(nv + v[i]); v[i] = nv; } if (dd2 < dd) dd = dd2; lam1 = nw; if (sqrt(dd) < 1e-14) break; }
      for (int i = 0; i < dim; i++) u[i] = 1.0 / sqrt((double)dim);
      for (itu = 0; itu < 20000; itu++) { for (int i = 0; i < dim; i++) { cplx s = 0; for (int j = 0; j < dim; j++) s += T[(size_t)j * dim + i] * u[j]; w[i] = s; }
        double nw = 0; for (int i = 0; i < dim; i++) nw += cabs(w[i]) * cabs(w[i]); nw = sqrt(nw); double dd = 0, dd2 = 0; for (int i = 0; i < dim; i++) { cplx nu = w[i] / nw; dd += cabs(nu - u[i]) * cabs(nu - u[i]); dd2 += cabs(nu + u[i]) * cabs(nu + u[i]); u[i] = nu; } if (dd2 < dd) dd = dd2; if (sqrt(dd) < 1e-14) break; }
      cplx uv = 0; for (int i = 0; i < dim; i++) uv += u[i] * v[i];
      cplx *x = malloc(sizeof(cplx) * dim); for (int i = 0; i < dim; i++) x[i] = (i % 2 ? 1.0 : -1.0) / sqrt((double)dim);
      for (it2 = 0; it2 < 20000; it2++) { cplx ux = 0; for (int i = 0; i < dim; i++) ux += u[i] * x[i]; for (int i = 0; i < dim; i++) x[i] -= v[i] * ux / uv;   /* project out the leading mode */
        for (int i = 0; i < dim; i++) { cplx s = 0; for (int j = 0; j < dim; j++) s += T[(size_t)i * dim + j] * x[j]; w[i] = s; }
        double nw = 0; for (int i = 0; i < dim; i++) nw += cabs(w[i]) * cabs(w[i]); nw = sqrt(nw); double dd = 0, dd2 = 0; for (int i = 0; i < dim; i++) { cplx nx = w[i] / nw; dd += cabs(nx - x[i]) * cabs(nx - x[i]); dd2 += cabs(nx + x[i]) * cabs(nx + x[i]); x[i] = nx; } if (dd2 < dd) dd = dd2; lam2 = nw; if (sqrt(dd) < 1e-13) break; }
      cplx r1 = 0, r2 = 0; for (int i = 0; i < dim; i++) { cplx s = 0, t = 0; for (int j = 0; j < dim; j++) { s += T[(size_t)i * dim + j] * v[j]; t += T[(size_t)i * dim + j] * x[j]; } r1 += conj(v[i]) * s; r2 += conj(x[i]) * t; }
      printf("CEI-TRANSFER-SPECTRUM lambda_1 = %.15e (power iteration, %d steps; Rayleigh %.15e %+.1ei) lambda_2 = %.15e (%d steps after deflation; Rayleigh %.15e %+.1ei); lambda_1/lambda_2 = %.6f, the gap ln(lambda_1/lambda_2) = %.6f per cell, %.6f per fine unit (n = %d)\n", lam1, it1, creal(r1), cimag(r1), lam2, it2, creal(r2), cimag(r2), lam1 / lam2, log(lam1 / lam2), log(lam1 / lam2) / NN, NN);
      /* THE PHYSICAL SECTOR: the leading modes by a Wielandt deflation chain, each with its weight in the sweep's own cut state (no source) and in the
         cut state with the chi_1 source on plaquette SRC[0] (closed before the cut) -- a mode no source reaches is not the two-point function's */
      { int M = 10; if (M > dim) M = dim; cplx *TD = malloc(sizeof(cplx) * (size_t)dim * dim); memcpy(TD, T, sizeof(cplx) * (size_t)dim * dim);
        cplx *VV = malloc(sizeof(cplx) * (size_t)M * dim), *UU = malloc(sizeof(cplx) * (size_t)M * dim); double LL[16]; int IT[16];
        cplx *sa = calloc(dim, sizeof(cplx)), *sp = calloc(dim, sizeof(cplx));
        for (int b = 0; b < SA.nblk; b++) if (SA.blk[b]) for (size_t e = 0; e < SA.size[b]; e++) sa[boff[b] + e] = SA.blk[b][e];
        if (NSRC >= 1) { cei_source(SRC[0]);
          state_t SP; SP.nopen = 0; SP.ncyc = 0; SP.nblk = 1; SP.blk = calloc(1, sizeof(cplx *)); SP.size = calloc(1, sizeof(size_t)); SP.blk[0] = calloc(1, sizeof(cplx)); SP.blk[0][0] = 1; SP.size[0] = 1;
          for (int i = 0; i < iA; i++) { if (ELIM[ord[i]]) continue; process(&SP, ord[i]); }
          if (SP.nblk == SA.nblk) for (int b = 0; b < SP.nblk; b++) if (SP.blk[b]) for (size_t e = 0; e < SP.size[b]; e++) sp[boff[b] + e] = SP.blk[b][e];
          free_state(&SP); for (int q = 0; q <= WMAX; q++) PFAC[SRC[0]][q] = FAC[q]; }
        for (int m = 0; m < M; m++) { cplx *vm = VV + (size_t)m * dim, *um = UU + (size_t)m * dim; for (int i = 0; i < dim; i++) { vm[i] = ((i * 7 + m * 3) % 11 - 5.0) / sqrt((double)dim); um[i] = ((i * 5 + m * 7) % 13 - 6.0) / sqrt((double)dim); } double lm = 0; int it;
          for (it = 0; it < 5000; it++) { for (int i = 0; i < dim; i++) { cplx s = 0; for (int j = 0; j < dim; j++) s += TD[(size_t)i * dim + j] * vm[j]; w[i] = s; }
            double nw = 0; for (int i = 0; i < dim; i++) nw += cabs(w[i]) * cabs(w[i]); nw = sqrt(nw); if (nw == 0) break; double dd = 0, dd2 = 0; for (int i = 0; i < dim; i++) { cplx nv = w[i] / nw; dd += cabs(nv - vm[i]) * cabs(nv - vm[i]); dd2 += cabs(nv + vm[i]) * cabs(nv + vm[i]); vm[i] = nv; } if (dd2 < dd) dd = dd2; lm = nw; if (sqrt(dd) < 1e-13) break; }
          IT[m] = it; for (int it2_ = 0; it2_ < 5000; it2_++) { for (int i = 0; i < dim; i++) { cplx s = 0; for (int j = 0; j < dim; j++) s += TD[(size_t)j * dim + i] * um[j]; w[i] = s; }
            double nw = 0; for (int i = 0; i < dim; i++) nw += cabs(w[i]) * cabs(w[i]); nw = sqrt(nw); if (nw == 0) break; double dd = 0, dd2 = 0; for (int i = 0; i < dim; i++) { cplx nu = w[i] / nw; dd += cabs(nu - um[i]) * cabs(nu - um[i]); dd2 += cabs(nu + um[i]) * cabs(nu + um[i]); um[i] = nu; } if (dd2 < dd) dd = dd2; if (sqrt(dd) < 1e-13) break; }
          cplx ray = 0, nrm = 0; for (int i = 0; i < dim; i++) { cplx s = 0; for (int j = 0; j < dim; j++) s += TD[(size_t)i * dim + j] * vm[j]; ray += conj(vm[i]) * s; nrm += conj(vm[i]) * vm[i]; } ray /= nrm; LL[m] = creal(ray);
          cplx uv_ = 0; for (int i = 0; i < dim; i++) uv_ += um[i] * vm[i];
          cplx ca = 0, cp = 0, na = 0, np_ = 0; for (int i = 0; i < dim; i++) { ca += um[i] * sa[i]; cp += um[i] * sp[i]; na += conj(sa[i]) * sa[i]; np_ += conj(sp[i]) * sp[i]; }
          printf("  MODE %2d lambda = %.12e (%+.1ei; %d steps) lambda_1/lambda = %.6f; weight in the sweep's cut state %.3e, in the source-p cut state %.3e\n", m + 1, LL[m], cimag(ray), it, LL[0] / LL[m], cabs(ca / uv_) / sqrt(cabs(na)), (NSRC >= 1) ? cabs(cp / uv_) / sqrt(cabs(np_)) : 0.0);
          for (int i = 0; i < dim; i++) for (int j = 0; j < dim; j++) TD[(size_t)i * dim + j] -= ray * vm[i] * um[j] / uv_; }
        free(TD); free(VV); free(UU); free(sa); free(sp); }
      if (dim <= 1000 && getenv("CEI_TRANSFER_OUT")) { FILE *f = fopen(getenv("CEI_TRANSFER_OUT"), "w"); if (f) { fprintf(f, "# T %d x %d (row-major; re im), the cut after step %d, the cell's links steps %d..%d, WMAX %d beta %g datum %s\n", dim, dim, iA, iA + 1, iB, WMAX, BETA, datum);
        for (int i = 0; i < dim; i++) { for (int j = 0; j < dim; j++) fprintf(f, "%.17e %.17e\n", creal(T[(size_t)i * dim + j]), cimag(T[(size_t)i * dim + j])); } fclose(f); printf("  T written to %s\n", getenv("CEI_TRANSFER_OUT")); } }
      free(T); free(v); free(w); free(u); free(x); free_state(&SA); printf("CEI-DONE transfer %.1f s\n", now() - t0); return 0; }
    int ibr = nord;   /* the branch step: the first step at which a source cycle closes (its last link in the order); every closing before it is source-free */
    if (BRANCH && ncfg > 1) for (int k = 0; k < NSRC; k++) { int last = -1; for (int i = 0; i < nord; i++) { if (ELIM[ord[i]]) continue; for (int st = 0; st < NSTEP[SRC[k]]; st++) if (STEPL[SRC[k]][st] == ord[i]) last = i; } if (last >= 0 && last < ibr) ibr = last; }
    if (BRANCH && ncfg > 1) printf("CEI-BRANCH the source cycles first close at step %d of %d: the %d configurations share the sweep to there\n", ibr + 1, nord, ncfg);
    size_t maxstate = 1; int maxopen = 0, nsteps = 0, nslices = 0; int peakopen[128], npeak = 0, peakstep = -1;
    int smax = (CLAMPC >= 0) ? WMAX : 0;
    for (int s = 0; s <= smax; s++) { int dv = (CLAMPC >= 0) ? DIM[s] : 1;
      for (int va = 0; va < dv; va++) for (int vb = 0; vb < dv; vb++) {
        if (CLAMPC >= 0) { CLAMPS = s; FIXV[CLAMPWA] = va; FIXV[CLAMPWB] = vb; }
        state_t SNAP; int snapped = 0;
        for (int cfg = 0; cfg < ncfg; cfg++) { double ts = now();
          for (int c = 0; c < NCYC; c++) for (int q = 0; q <= WMAX; q++) PFAC[c][q] = FAC[q];
          int usep = (NSRC >= 1) && (cfg == 1 || cfg == 3), useq = (NSRC == 2) && (cfg == 2 || cfg == 3);
          if (usep) cei_source(SRC[0]);
          if (useq) cei_source(SRC[1]);
          state_t S; int i0 = 0;
          if (cfg > 0 && snapped) { state_copy(&SNAP, &S); i0 = ibr; }
          else { S.nopen = 0; S.ncyc = 0; S.nblk = 1; S.blk = calloc(1, sizeof(cplx *)); S.size = calloc(1, sizeof(size_t)); S.blk[0] = calloc(1, sizeof(cplx)); S.blk[0][0] = 1; S.size[0] = 1; }
          int nst = 0;
          for (int i = i0; i < nord; i++) { if (ELIM[ord[i]]) continue;
            if (cfg == 0 && BRANCH && ncfg > 1 && i == ibr) { state_copy(&S, &SNAP); snapped = 1; }
            process(&S, ord[i]); nst++; size_t tot = 0; for (int b = 0; b < S.nblk; b++) tot += S.size[b];
            if (tot > maxstate) { maxstate = tot; if (PEAKLIST) { npeak = S.nopen; memcpy(peakopen, S.open, sizeof(int) * S.nopen); peakstep = i; } }
            if (S.ncyc > maxopen) maxopen = S.ncyc;
            if (PROFILE && cfg == 0 && nslices == 0) { int l = ord[i]; printf("CEI-STEP %d link (%d,%d,%d) d%d entries=%zu open-cycles=%d:", i + 1, LB[l][0], LB[l][1], LB[l][2], LD[l], tot, S.ncyc);
              for (int j = 0; j < S.ncyc; j++) { int c = S.cyc[j], kw = 0; for (int w = 0; w < S.nopen; w++) if (WCYC[S.open[w]] == c) kw++; printf(" c%d(%d wires:", c, kw); for (int w = 0; w < S.nopen; w++) if (WCYC[S.open[w]] == c) printf(" w%d", S.open[w]); printf(")"); } printf("\n"); }
            if (tot > CEIL) { fprintf(stderr, "CEI-REFUSED: the state reached %zu entries after link %d (%d cycles open), above the ceiling %zu (W2_CEIL)\n", tot, i + 1, S.ncyc, CEIL); return 3; } }
          if (cfg == 0) nsteps = nst;
          if (S.nopen != 0 || S.ncyc != 0 || S.nblk != 1 || !S.blk[0]) { fprintf(stderr, "CEI: the sweep ended with %d open wires and %d open cycles\n", S.nopen, S.ncyc); return 1; }
          cplx z = S.blk[0][0]; if (CLAMPC >= 0 && NWIRE[CLAMPC] == 2) z *= PFAC[CLAMPC][CLAMPS];   /* the all-fixed cycle's closing weight, once per slice */
          ZZ[cfg] += creal(z); ZI[cfg] += cimag(z); free_state(&S); tcfg[cfg] += now() - ts; }
        if (snapped) free_state(&SNAP); nslices++; } }
    if (CLAMPC >= 0) { CLAMPS = -1; FIXV[CLAMPWA] = -1; FIXV[CLAMPWB] = -1; }
    for (int cfg = 0; cfg < ncfg; cfg++) printf("CEI-Z src=%s Z = %.17e (imag %.1e; %d links swept; max state %zu; open cycles at most %d; %d slice(s); %.1f s)\n", nm[cfg], ZZ[cfg], ZI[cfg], nsteps, maxstate, maxopen, nslices, tcfg[cfg]);
    if (PEAKLIST) { printf("CEI-PEAK after link %d of the order, %d open wires:", peakstep + 1, npeak); for (int w = 0; w < npeak; w++) printf(" w%d(cycle %d)", peakopen[w], WCYC[peakopen[w]]); printf("\n"); }
    if (NSRC >= 1) printf("CEI-SRC p=%d <1/2 tr U_p> = %.15e\n", SRC[0], ZZ[1] / (2 * ZZ[0]));
    if (NSRC == 2) { double ep = ZZ[1] / (2 * ZZ[0]), eq = ZZ[2] / (2 * ZZ[0]), epq = ZZ[3] / (4 * ZZ[0]);
      printf("CEI-SRC q=%d <1/2 tr U_q> = %.15e; <1/2 tr U_p 1/2 tr U_q> = %.15e; CONNECTED = %.15e\n", SRC[1], eq, epq, epq - ep * eq); }
    printf("CEI-DONE beta=%g WMAX=%d datum=%s mode=%d %.1f s\n", BETA, WMAX, datum, CEI, now() - t0); return 0; }
  int wAin = win(LOOPA, 0), wAout = wout(LOOPA, NSTEP[LOOPA] - 1), wBin = win(LOOPB, 0), wBout = wout(LOOPB, NSTEP[LOOPB] - 1);
  int NA = -1; for (int i = 0; i < NORD; i++) if (order[i] == SHARED0) { NA = i; break; }
  for (int w = 0; w < NW; w++) FIXV[w] = -1;
  if (getenv("W2_LADDER")) return ladder_mode(wAin, wAout, wBin, wBout, DATA);   /* THE LADDER MODE (w2_strip_l.c): every outside link's flip from one stored forward sweep and one backward pass per class */
  if (getenv("W2_SLICE") && NCORN > 0) { fprintf(stderr, "W2_SLICE REFUSED with corner cycles: in this order the junction wires are born after the near region, so a slice's peak equals the unsliced peak and the slices only multiply the work\n"); return 1; }
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
