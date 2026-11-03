/* ordcost.c -- THE SWEEP ORDER'S STATE SIZE, exactly as w2e.c's process() allocates it, and THE SEARCH FOR THE BEST ORDER (the development EI,
 * 2026-11-02 16:2x EST; the coordinator's item 1: an order of the corrected bent object keeping n open cycles with the corners in).
 * The object is w2e.c's build(): face A (xy at z = 0), face B (yz at x = 0, bent), the two loops (basepoint (0, n, 0)), and every non-face
 * plaquette with two or more object links a CORNER cycle (the n + 1 corners at (0, j, 0) in the xz-plane).  A cycle's wire i joins its steps
 * i - 1 and i (cyclically for a plaquette or a corner; a loop's wire 0 and wire 4n are the junction wires, each on one step).  For a
 * processed set P of links, a wire is OPEN iff exactly one of its steps is in P (a junction wire iff its step is); an open plaquette or
 * corner with w open wires holds sum_{s <= WMAX} d_s^w entries per state (every spin's block is allocated), a loop at spin a holds d_a^w;
 * the state size is the product -- the engine's "max state" at that step.
 * usage: ordcost n WMAX a c record|corner|file:<order>|dpfull|dpnear [print]
 *   record / corner: w2e.c's two built-in orders (the corner order only with the corners in); file: one "x y z d" per line;
 *   dpfull: the exhaustive minimum over every order of the peak (n <= 2: 2^{links} processed sets), then the least SUM of state sizes
 *           among the peak-optimal orders; dpnear: the same over the near region's links x(j), s(j), z(j), r(j) = (1,j,0)d2,
 *           t(j) = (0,j,1)d2, face A's other links before them (the record's column order) and face B's other links after (the record's slabs).
 *   ORD_NOCORNER=1 builds the object without corner cycles (the record's staple loop).
 * build: gcc -O2 -o ordcost.exe ordcost.c */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define MAXL 128
#define MAXC 64
#define MAXST 32
static int NN, WMAX, ASP, CSP, CORNERS = 1;
static int NL = 0, LB[MAXL][4], LD[MAXL];
static int NC = 0, NS[MAXC], SL[MAXC][MAXST], KIND[MAXC];   /* KIND 0 plaquette/corner (spin summed), 1 loop A, 2 loop B */
static int lkey(const int *b, int d, int create) { for (int i = 0; i < NL; i++) if (LD[i] == d && !memcmp(LB[i], b, sizeof(int) * 4)) return i; if (!create) return -1; memcpy(LB[NL], b, sizeof(int) * 4); LD[NL] = d; return NL++; }
static int lk(int x, int y, int z, int d) { int b[4] = { x, y, z, 0 }; int l = lkey(b, d, 0); if (l < 0) { fprintf(stderr, "no link (%d,%d,%d) d%d\n", x, y, z, d); exit(1); } return l; }
static int NP; static int PB[MAXC][4], PD1[MAXC], PD2[MAXC];
static void add_plaq(int x, int y, int z, int d1, int d2) { int c = NC++; int b[4] = { x, y, z, 0 }, q[4]; memcpy(PB[c], b, sizeof b); PD1[c] = d1; PD2[c] = d2; KIND[c] = 0; NS[c] = 4;
  SL[c][0] = lkey(b, d1, 1); memcpy(q, b, sizeof q); q[d1 - 1]++; SL[c][1] = lkey(q, d2, 1); memcpy(q, b, sizeof q); q[d2 - 1]++; SL[c][2] = lkey(q, d1, 1); SL[c][3] = lkey(b, d2, 1); }
static int is_face(const int *b, int d1, int d2) { for (int c = 0; c < NP; c++) if (PD1[c] == d1 && PD2[c] == d2 && !memcmp(PB[c], b, sizeof(int) * 4)) return 1; return 0; }
static void build(void) { int n = NN;
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) add_plaq(i, j, 0, 1, 2);
  for (int k = 0; k < n; k++) for (int j = 0; j < n; j++) add_plaq(0, j, k, 2, 3);
  NP = NC;
  { int c = NC++; KIND[c] = 1; int s = 0;   /* loop A from (0, n, 0): down the shared edge, +x along y = 0, up at x = n, -x along y = n */
    for (int j = n - 1; j >= 0; j--) SL[c][s++] = lk(0, j, 0, 2); for (int i = 0; i < n; i++) SL[c][s++] = lk(i, 0, 0, 1);
    for (int j = 0; j < n; j++) SL[c][s++] = lk(n, j, 0, 2); for (int i = n - 1; i >= 0; i--) SL[c][s++] = lk(i, n, 0, 1); NS[c] = s; }
  { int c = NC++; KIND[c] = 2; int s = 0;   /* loop B from (0, n, 0): up at y = n, -y along z = n, down at y = 0, up the shared edge */
    for (int k = 0; k < n; k++) SL[c][s++] = lk(0, n, k, 3); for (int j = n - 1; j >= 0; j--) SL[c][s++] = lk(0, j, n, 2);
    for (int k = n - 1; k >= 0; k--) SL[c][s++] = lk(0, 0, k, 3); for (int j = 0; j < n; j++) SL[c][s++] = lk(0, j, 0, 2); NS[c] = s; }
  if (!CORNERS) return;
  for (int l = 0; l < NL; l++) { int d = LD[l];   /* every non-face plaquette through an object link with two or more object links: a corner, once */
    for (int k = 1; k <= 4; k++) { if (k == d) continue; for (int si = 0; si < 2; si++) { int base[4]; memcpy(base, LB[l], sizeof base); if (si) base[k - 1]--;
        int d1 = d < k ? d : k, d2 = d < k ? k : d; if (is_face(base, d1, d2)) continue;
        int E[4][4], ED[4]; memcpy(E[0], base, sizeof E[0]); ED[0] = d1; memcpy(E[1], base, sizeof E[1]); E[1][d1 - 1]++; ED[1] = d2; memcpy(E[2], base, sizeof E[2]); E[2][d2 - 1]++; ED[2] = d1; memcpy(E[3], base, sizeof E[3]); ED[3] = d2;
        int ob[4], no = 0; for (int e = 0; e < 4; e++) { ob[e] = lkey(E[e], ED[e], 0); if (ob[e] >= 0) no++; } if (no < 2) continue;
        int dup = 0; for (int c = NP + 2; c < NC; c++) if (PD1[c] == d1 && PD2[c] == d2 && !memcmp(PB[c], base, sizeof base)) dup = 1; if (dup) continue;
        int c = NC++; KIND[c] = 0; memcpy(PB[c], base, sizeof base); PD1[c] = d1; PD2[c] = d2; NS[c] = 0; for (int e = 0; e < 4; e++) if (ob[e] >= 0) SL[c][NS[c]++] = ob[e]; } } } }
static double SUMD[64];   /* SUMD[w] = sum_{s <= WMAX} (s + 1)^w */
static double cost(const unsigned char *P, int *nopen) { double tot = 1; int no = 0;
  for (int c = 0; c < NC; c++) { int m = NS[c], w = 0, np = 0; for (int i = 0; i < m; i++) np += P[SL[c][i]];
    if (KIND[c] == 0) { if (np == 0 || np == m) continue; for (int i = 0; i < m; i++) if (P[SL[c][i]] != P[SL[c][(i + m - 1) % m]]) w++; tot *= SUMD[w]; no++; }
    else { w = P[SL[c][0]] + P[SL[c][m - 1]]; for (int i = 1; i < m; i++) if (P[SL[c][i]] != P[SL[c][i - 1]]) w++; tot *= pow(KIND[c] == 1 ? ASP + 1 : CSP + 1, w); } }
  if (nopen) *nopen = no; return tot; }
static int ORD[MAXL], NORD = 0;
static void push(int x, int y, int z, int d) { int b_[4] = { x, y, z, 0 }; int l = lkey(b_, d, 0); if (l < 0) return;   /* ordsub: an eliminated link is skipped */ for (int i = 0; i < NORD; i++) if (ORD[i] == l) { fprintf(stderr, "order repeats (%d,%d,%d) d%d\n", x, y, z, d); exit(1); } ORD[NORD++] = l; }
static void record_order(void) { int n = NN; NORD = 0;
  for (int j = 0; j < n; j++) push(n, j, 0, 2);
  for (int i = n - 1; i >= 0; i--) { for (int j = 0; j <= n; j++) push(i, j, 0, 1); if (i > 0) for (int j = 0; j < n; j++) push(i, j, 0, 2); }
  for (int j = 0; j < n; j++) push(0, j, 0, 2);
  for (int k = 0; k < n; k++) { for (int j = 0; j <= n; j++) push(0, j, k, 3); for (int j = n - 1; j >= 0; j--) push(0, j, k + 1, 2); } }
static void corner_order(void) { int n = NN; NORD = 0;
  for (int j = 0; j < n; j++) push(n, j, 0, 2);
  for (int i = n - 1; i >= 1; i--) { for (int j = 0; j <= n; j++) push(i, j, 0, 1); for (int j = 0; j < n; j++) push(i, j, 0, 2); }
  for (int j = 0; j <= n; j++) { push(0, j, 0, 1); push(0, j, 0, 3); if (j < n) push(0, j, 0, 2); }
  for (int k = 0; k < n; k++) { if (k > 0) for (int j = 0; j <= n; j++) push(0, j, k, 3); for (int j = n - 1; j >= 0; j--) push(0, j, k + 1, 2); } }
static void eval(int print, double *peak_out, double *sum_out) { unsigned char P[MAXL]; memset(P, 0, sizeof P); double peak = 1, sum = 0; int pk = -1, pno = 0;
  if (NORD != NL) { fprintf(stderr, "the order holds %d of %d links\n", NORD, NL); exit(1); }
  for (int k = 0; k < NORD; k++) { P[ORD[k]] = 1; int no; double s = cost(P, &no); sum += s; if (s > peak) { peak = s; pk = k; pno = no; }
    if (print) printf("ORD-STEP %d (%d,%d,%d) d%d: state %.0f, open cycles %d\n", k + 1, LB[ORD[k]][0], LB[ORD[k]][1], LB[ORD[k]][2], LD[ORD[k]], s, no); }
  printf("ORD-EVAL n=%d WMAX=%d a=%d c=%d corners=%d: peak %.0f after step %d (%d plaquette/corner cycles open), sum %.6e over %d steps\n", NN, WMAX, ASP, CSP, CORNERS, peak, pk + 1, pno, sum, NORD);
  if (peak_out) *peak_out = peak; if (sum_out) *sum_out = sum; }
/* the DP over the processed subsets of a free set F (the other links fixed: PRE processed before, the rest after) */
static void dp(const int *F, int nf, const unsigned char *PRE, int print) {
  size_t NM = (size_t)1 << nf; double *C = malloc(sizeof(double) * NM), *BP = malloc(sizeof(double) * NM), *BS = malloc(sizeof(double) * NM); signed char *CH = malloc(NM);
  if (!C || !BP || !BS || !CH) { fprintf(stderr, "out of memory for 2^%d sets\n", nf); exit(3); }
  unsigned char P[MAXL];
  for (size_t m = 0; m < NM; m++) { memcpy(P, PRE, MAXL); for (int b = 0; b < nf; b++) if (m >> b & 1) P[F[b]] = 1; C[m] = cost(P, NULL); }
  BP[0] = C[0]; for (size_t m = 1; m < NM; m++) { double best = INFINITY; for (int b = 0; b < nf; b++) if (m >> b & 1) { double v = BP[m ^ ((size_t)1 << b)]; if (v < best) best = v; } BP[m] = best > C[m] ? best : C[m]; }
  double PSTAR = BP[NM - 1];
  BS[0] = C[0] <= PSTAR ? C[0] : INFINITY; CH[0] = -1;
  for (size_t m = 1; m < NM; m++) { BS[m] = INFINITY; CH[m] = -1; if (C[m] > PSTAR) continue;
    for (int b = 0; b < nf; b++) if (m >> b & 1) { double v = BS[m ^ ((size_t)1 << b)]; if (v + C[m] < BS[m]) { BS[m] = v + C[m]; CH[m] = b; } } }
  int seq[MAXL], ns = 0; size_t m = NM - 1; while (m) { int b = CH[m]; if (b < 0) { fprintf(stderr, "dp: no path\n"); exit(1); } seq[ns++] = F[b]; m ^= (size_t)1 << b; }
  printf("ORD-DP over %d links (2^%d sets): the least peak over every order of them %.0f; among the peak-optimal orders the least sum %.6e; the order:", nf, nf, PSTAR, BS[NM - 1]);
  for (int i = ns - 1; i >= 0; i--) printf(" (%d,%d,%d)d%d", LB[seq[i]][0], LB[seq[i]][1], LB[seq[i]][2], LD[seq[i]]); printf("\n");
  /* splice: the fixed prefix in its given order, the DP's sequence, the fixed suffix in its given order */
  int newo[MAXL], nn = 0; for (int k = 0; k < NORD; k++) if (PRE[ORD[k]]) newo[nn++] = ORD[k]; for (int i = ns - 1; i >= 0; i--) newo[nn++] = seq[i];
  for (int k = 0; k < NORD; k++) { int inF = 0; for (int b = 0; b < nf; b++) if (F[b] == ORD[k]) inF = 1; if (!PRE[ORD[k]] && !inF) newo[nn++] = ORD[k]; }
  memcpy(ORD, newo, sizeof(int) * nn); NORD = nn;
  printf("ORD-SPLICED"); for (int k = 0; k < NORD; k++) printf(" %d,%d,%d,%d", LB[ORD[k]][0], LB[ORD[k]][1], LB[ORD[k]][2], LD[ORD[k]]); printf("\n");
  eval(print, NULL, NULL); free(C); free(BP); free(BS); free(CH); }
/* ---- THE REACHABILITY SEARCH (16:4x): is there ANY order whose every prefix leaves at most K plaquette-or-corner cycles open?  A depth-first
   search over processed sets with a visited hash; a set is entered only if its open count is <= K; the answer is whether the full set is
   reached.  Unweighted: an open cycle holds >= sum_s d_s^2 entries (at least two open wires), so "unreachable at K" means every order's
   peak state is >= (sum_s d_s^2)^(K+1) times its loop factor. */
typedef struct { unsigned long long lo, hi; } m128;
static m128 CM[MAXC]; static int NCM = 0;
static int MERGE = 0, PARTNER[MAXL];   /* ORD_MERGE=1: each corner's two object links processed as ONE step (a merged tensor), so no corner is ever open */
static int nopen128(m128 P) { int no = 0; for (int c = 0; c < NCM; c++) { unsigned long long a = P.lo & CM[c].lo, b = P.hi & CM[c].hi; if ((a | b) && (a != CM[c].lo || b != CM[c].hi)) no++; } return no; }
static m128 *HT; static size_t HCAP, HN;
static size_t hidx(m128 k) { unsigned long long h = k.lo * 0x9E3779B97F4A7C15ULL ^ (k.hi + 0x632BE59BD9B4E019ULL) * 0xBF58476D1CE4E5B9ULL; h ^= h >> 31; return (size_t)h & (HCAP - 1); }
static int hins(m128 k) { size_t i = hidx(k); while (HT[i].lo != ~0ULL || HT[i].hi != ~0ULL) { if (HT[i].lo == k.lo && HT[i].hi == k.hi) return 0; i = (i + 1) & (HCAP - 1); } HT[i] = k; HN++; if (HN * 2 > HCAP) { fprintf(stderr, "reach: the hash is full (%zu states)\n", HN); exit(3); } return 1; }
static int reach(int K, size_t cap) { NCM = 0; for (int c = 0; c < NC; c++) { if (KIND[c]) continue; m128 m = { 0, 0 }; for (int i = 0; i < NS[c]; i++) { int l = SL[c][i]; if (l < 64) m.lo |= 1ULL << l; else m.hi |= 1ULL << (l - 64); } CM[NCM++] = m; }
  HCAP = cap; HT = malloc(sizeof(m128) * HCAP); if (!HT) { fprintf(stderr, "reach: no memory for the hash\n"); exit(3); } for (size_t i = 0; i < HCAP; i++) HT[i].lo = HT[i].hi = ~0ULL; HN = 0;
  m128 FULL = { 0, 0 }; for (int l = 0; l < NL; l++) { if (l < 64) FULL.lo |= 1ULL << l; else FULL.hi |= 1ULL << (l - 64); }
  m128 *ST = malloc(sizeof(m128) * HCAP); size_t sp = 0; m128 z = { 0, 0 }; ST[sp++] = z; hins(z); int found = 0;
  while (sp) { m128 P = ST[--sp]; if (P.lo == FULL.lo && P.hi == FULL.hi) { found = 1; break; }
    for (int l = 0; l < NL; l++) { m128 Q = P; if (l < 64) { if (Q.lo >> l & 1) continue; Q.lo |= 1ULL << l; } else { if (Q.hi >> (l - 64) & 1) continue; Q.hi |= 1ULL << (l - 64); }
      if (MERGE && PARTNER[l] >= 0) { int q = PARTNER[l]; if (q < 64) Q.lo |= 1ULL << q; else Q.hi |= 1ULL << (q - 64); }   /* a corner's two links in one step */
      if (nopen128(Q) > K) continue; if (hins(Q)) ST[sp++] = Q; } }
  printf("ORD-REACH n=%d corners=%d merge=%d K=%d: %s", NN, CORNERS, MERGE, K, found ? "REACHED" : "UNREACHABLE");
  printf(" ORD-REACH-DETAIL n=%d corners=%d K=%d: %s (%zu processed sets visited, every one with at most %d open plaquette-or-corner cycles)\n", NN, CORNERS, K, found ? "REACHED -- an order with at most K open exists" : "UNREACHABLE -- every order opens at least K+1 at some step", HN, K);
  free(HT); free(ST); return found; }
/* ---- ordsub: THE SUBSTITUTED OBJECT (the author, 2026-11-02 17:2x EST; the campaign's §31.10 substitution road, priced on EI's cost model).
   With ORD_SUBST=1 every coarse edge of the two loops (a straight path of n fine links; seven distinct edges, the shared one once) has its LAST
   link in loop A's step order eliminated: every cycle holding that link holds instead the edge's other links (inverted, reversed -- the signs do
   not enter the state size), the eliminated link leaves the link set, and the order modes skip it.  The cost model is unchanged: a wire is open
   iff exactly one of its steps is processed, which already handles a cycle holding one link at two steps. ---- */
static int NELIM = 0;
static void subst_edge(const int *E, int n) {
  int elim = E[n - 1];
  for (int c = 0; c < NC; c++) { int NSL[MAXST], ns = 0;
    for (int i = 0; i < NS[c]; i++) {
      if (SL[c][i] == elim) { for (int k = n - 2; k >= 0; k--) { if (ns >= MAXST) { fprintf(stderr, "ordsub: a cycle outgrew MAXST\n"); exit(1); } NSL[ns++] = E[k]; } }
      else NSL[ns++] = SL[c][i]; }
    if (ns == 0) { fprintf(stderr, "ordsub: a cycle emptied\n"); exit(1); }
    memcpy(SL[c], NSL, sizeof(int) * ns); NS[c] = ns; }
  int map[MAXL]; int nl = 0;
  for (int l = 0; l < NL; l++) { if (l == elim) { map[l] = -1; continue; } map[l] = nl; memcpy(LB[nl], LB[l], sizeof(int) * 4); LD[nl] = LD[l]; nl++; }
  NL = nl;
  for (int c = 0; c < NC; c++) for (int i = 0; i < NS[c]; i++) { if (map[SL[c][i]] < 0) { fprintf(stderr, "ordsub: an eliminated link survived\n"); exit(1); } SL[c][i] = map[SL[c][i]]; }
  NELIM++; }
static void substitute_exact(void) { int n = NN; int cA = NP, cB = NP + 1; int A0[MAXST], B0[MAXST], nA = NS[cA], nB = NS[cB];
  memcpy(A0, SL[cA], sizeof(int) * nA); memcpy(B0, SL[cB], sizeof(int) * nB);
  int EB[7][MAXST][4], ED[7][MAXST];
  for (int e = 0; e < 4; e++) for (int k = 0; k < n; k++) { memcpy(EB[e][k], LB[A0[e * n + k]], sizeof(int) * 4); ED[e][k] = LD[A0[e * n + k]]; }
  for (int e = 0; e < 3; e++) for (int k = 0; k < n; k++) { memcpy(EB[4 + e][k], LB[B0[e * n + k]], sizeof(int) * 4); ED[4 + e][k] = LD[B0[e * n + k]]; }
  for (int e = 0; e < 7; e++) { int E[MAXST]; for (int k = 0; k < n; k++) { E[k] = lkey(EB[e][k], ED[e][k], 0); if (E[k] < 0) { fprintf(stderr, "ordsub: an edge link is missing\n"); exit(1); } } subst_edge(E, n); } }
int main(int argc, char **argv) {
  if (argc < 6) { fprintf(stderr, "usage: ordcost n WMAX a c record|corner|file:<f>|dpfull|dpnear [print]\n"); return 1; }
  NN = atoi(argv[1]); WMAX = atoi(argv[2]); ASP = atoi(argv[3]); CSP = atoi(argv[4]); const char *mode = argv[5]; int print = argc > 6 && !strcmp(argv[6], "print");
  if (getenv("ORD_NOCORNER")) CORNERS = 0;
  for (int w = 0; w < 64; w++) { SUMD[w] = 0; for (int s = 0; s <= WMAX; s++) SUMD[w] += pow(s + 1, w); }
  build(); int ncorn = NC - NP - 2;
  if (getenv("ORD_SUBST")) { substitute_exact(); printf("ORD-SUBST: %d coarse edges substituted, %d links eliminated, %d links remain; loop A %d steps, loop B %d steps\n", NELIM, NELIM, NL, NS[NP], NS[NP + 1]); }
  printf("ORD-OBJECT n=%d links=%d plaquettes=%d corners=%d loops 2 (loop A %d steps, loop B %d steps)\n", NN, NL, NP, ncorn, NS[NP], NS[NP + 1]);
  for (int l = 0; l < NL; l++) PARTNER[l] = -1;
  if (getenv("ORD_MERGE")) { MERGE = 1; for (int c = NP + 2; c < NC; c++) { if (NS[c] != 2) { fprintf(stderr, "a corner with %d object links\n", NS[c]); return 1; } PARTNER[SL[c][0]] = SL[c][1]; PARTNER[SL[c][1]] = SL[c][0]; } }
  if (!strncmp(mode, "reach:", 6)) { size_t cap = (size_t)1 << (getenv("ORD_HBITS") ? atoi(getenv("ORD_HBITS")) : 24); reach(atoi(mode + 6), cap); return 0; }
  if (!strcmp(mode, "record")) { record_order(); eval(print, NULL, NULL); return 0; }
  if (!strcmp(mode, "corner")) { corner_order(); eval(print, NULL, NULL); return 0; }
  if (!strncmp(mode, "file:", 5)) { FILE *f = fopen(mode + 5, "r"); if (!f) { fprintf(stderr, "cannot open %s\n", mode + 5); return 1; } int x, y, z, d; NORD = 0; while (fscanf(f, "%d %d %d %d", &x, &y, &z, &d) == 4) push(x, y, z, d); fclose(f); eval(print, NULL, NULL); return 0; }
  if (!strcmp(mode, "dpfull")) { if (NL > 26) { fprintf(stderr, "dpfull REFUSED: %d links (2^%d sets)\n", NL, NL); return 1; } int F[MAXL]; for (int l = 0; l < NL; l++) F[l] = l; unsigned char PRE[MAXL]; memset(PRE, 0, sizeof PRE); record_order(); dp(F, NL, PRE, print); return 0; }
  if (!strcmp(mode, "dpnear")) { int n = NN, F[MAXL], nf = 0; unsigned char PRE[MAXL]; memset(PRE, 0, sizeof PRE);
    for (int j = 0; j <= n; j++) { F[nf++] = lk(0, j, 0, 1); F[nf++] = lk(0, j, 0, 3); } for (int j = 0; j < n; j++) { F[nf++] = lk(0, j, 0, 2); F[nf++] = lk(1, j, 0, 2); F[nf++] = lk(0, j, 1, 2); }
    if (nf > 26) { fprintf(stderr, "dpnear REFUSED: %d free links\n", nf); return 1; }
    for (int l = 0; l < NL; l++) { int inF = 0; for (int b = 0; b < nf; b++) if (F[b] == l) inF = 1; if (!inF && LB[l][2] == 0 && LD[l] != 3) PRE[l] = 1; }   /* face A's other links (z = 0, not a z-link) first */
    record_order(); dp(F, nf, PRE, print); return 0; }
  fprintf(stderr, "unknown mode %s\n", mode); return 1; }
