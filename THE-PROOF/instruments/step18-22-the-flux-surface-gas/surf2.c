/* surf2.c -- THE CLOSING TREE'S BRANCHING, MEASURED LEVEL BY LEVEL (S1 §3's instrument surf.c re-aimed at the tail factor mu, 2026-11-01
 * 11:0x EST; the author).  The tree: grow the surface P in Z^d from the plaquette p0 by always closing the SMALLEST open link (multiplicity
 * one) with one of the 2(d-1)-1 other plaquettes at that link, refusing a plaquette already in P or one that would give a link three
 * plaquettes (surf.c, verbatim).  surf.c counts the closed leaves; this file counts the NODES: per depth k (the number of plaquettes beyond
 * p0), the number of nodes n_k, the histogram of the admissible-candidate count c in 0..5 at the nodes of that depth, the mean c (the level's
 * branching), the histogram of the GRANDCHILDREN count g = sum over a node's children of their c (so max_k g bounds mu^2 on the levels read),
 * and the refusals by kind -- whether the refused candidate is COPLANAR with the plaquette already at the link (the straight continuation)
 * or a FOLD (the four perpendicular ones) -- all to depth DMAX with NO size pruning (surf.c prunes by F + nopen/4 > FMAX; the tail factor is
 * the unpruned tree's growth).  The closed leaves met on the way are counted per size as surf.c's known answer (4, 60, 80, 1092 at
 * F = 6, 10, 12, 14).  Usage: surf2 d DMAX */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <math.h>
static int D, DMAX, R, W; static long NS; static int NPAIR; static int PMU[16], PNU[16];
static unsigned char *mult, *inP; static long stride[8];
static long site_of(const int *x) { long s = 0; for (int i = 0; i < D; i++) s += (long)(x[i] + R) * stride[i]; return s; }
static void coords(long s, int *x) { for (int i = 0; i < D; i++) { x[i] = (int)(s / stride[i]) % W - R; } }
static long link_id(long s, int mu) { return s * D + mu; }
static long plaq_id(long s, int k) { return s * NPAIR + k; }
static int pair_index(int mu, int nu) { for (int k = 0; k < NPAIR; k++) if (PMU[k] == mu && PNU[k] == nu) return k; return -1; }
static void plaq_links(long p, long *L) { long s = p / NPAIR; int k = (int)(p % NPAIR); int mu = PMU[k], nu = PNU[k];
  L[0] = link_id(s, mu); L[1] = link_id(s + stride[mu], nu); L[2] = link_id(s + stride[nu], mu); L[3] = link_id(s, nu); }
static int link_plaqs(long l, long *Q) { long s = l / D; int mu = (int)(l % D); int n = 0;
  for (int nu = 0; nu < D; nu++) if (nu != mu) { int a = mu < nu ? mu : nu, b = mu < nu ? nu : mu; int k = pair_index(a, b); Q[n++] = plaq_id(s, k); Q[n++] = plaq_id(s - stride[nu], k); }
  return n; }
static long P[128]; static int F = 0; static long openL[512]; static int nopen = 0;
static void add_open(long l) { openL[nopen++] = l; }
static void del_open(long l) { for (int i = 0; i < nopen; i++) if (openL[i] == l) { openL[i] = openL[--nopen]; return; } fprintf(stderr, "del_open miss\n"); exit(3); }
/* the per-depth counters are long long: MinGW's long is 32 bits, and the admitted-fold count at depth 13 (3.1e9) overflowed it in record a; record b changed the type and not the %ld formats, which print 32 bits of a 64-bit value on MinGW, so record c carries %lld */
static long long nodes[64], chist[64][8], ghist[64][64], refco[64], reffo[64], admco[64], admfo[64], leaves[64]; static long long gmax[64];
/* the admissible candidates at the current node: fills cand[], returns their number; the refusals are counted per depth */
static int admissible(int depth, long *cand) {
  long l = openL[0]; for (int i = 1; i < nopen; i++) if (openL[i] < l) l = openL[i];
  long Q[16]; int nq = link_plaqs(l, Q); int pk = -1; for (int qi = 0; qi < nq; qi++) if (inP[Q[qi]]) pk = (int)(Q[qi] % NPAIR);
  int nc = 0;
  for (int qi = 0; qi < nq; qi++) { long q = Q[qi]; if (inP[q]) continue; int cop = ((int)(q % NPAIR) == pk);
    long L4[4]; plaq_links(q, L4); int ok = 1; for (int a = 0; a < 4; a++) if (mult[L4[a]] >= 2) { ok = 0; break; }
    if (!ok) { if (cop) refco[depth]++; else reffo[depth]++; continue; }
    if (cop) admco[depth]++; else admfo[depth]++; cand[nc++] = q; }
  return nc; }
/* returns this node's admissible count c; descends when depth < DMAX */
static int search(int depth) {
  nodes[depth]++;
  if (nopen == 0) { leaves[F]++; chist[depth][0]++; return 0; }
  long cand[8]; int c = admissible(depth, cand); chist[depth][c]++;
  if (depth >= DMAX) return c;
  long g = 0;
  for (int i = 0; i < c; i++) { long q = cand[i]; long L4[4]; plaq_links(q, L4);
    { long s = q / NPAIR; int x[8]; coords(s, x); int in = 1; for (int d = 0; d < D; d++) if (x[d] <= -R + 1 || x[d] >= R - 1) in = 0; if (!in) { fprintf(stderr, "BOX: radius too small\n"); exit(4); } }
    inP[q] = 1; P[F++] = q;
    for (int a = 0; a < 4; a++) { if (mult[L4[a]] == 0) add_open(L4[a]); else del_open(L4[a]); mult[L4[a]]++; }
    g += search(depth + 1);
    for (int a = 0; a < 4; a++) { mult[L4[a]]--; if (mult[L4[a]] == 0) del_open(L4[a]); else add_open(L4[a]); }
    F--; inP[q] = 0; }
  if (g < 64) ghist[depth][g]++; if (g > gmax[depth]) gmax[depth] = g;
  return c; }
int main(int argc, char **argv) {
  if (argc < 3) { fprintf(stderr, "usage: surf2 d DMAX\n"); return 1; }
  D = atoi(argv[1]); DMAX = atoi(argv[2]); if (D < 3 || D > 6 || DMAX < 1 || DMAX > 40) { fprintf(stderr, "d 3..6, DMAX 1..40\n"); return 1; }
  R = DMAX + 3; W = 2 * R + 1; NS = 1; for (int i = 0; i < D; i++) { stride[i] = NS; NS *= W; }
  NPAIR = 0; for (int a = 0; a < D; a++) for (int b = a + 1; b < D; b++) { PMU[NPAIR] = a; PNU[NPAIR] = b; NPAIR++; }
  mult = calloc(NS * D, 1); inP = calloc(NS * NPAIR, 1); if (!mult || !inP) { fprintf(stderr, "alloc\n"); return 2; }
  int x0[8] = {0}; long s0 = site_of(x0); long p0 = plaq_id(s0, pair_index(0, 1));
  inP[p0] = 1; P[F++] = p0; { long L4[4]; plaq_links(p0, L4); for (int a = 0; a < 4; a++) { mult[L4[a]] = 1; add_open(L4[a]); } }
  search(0);
  printf("# surf2 d=%d DMAX=%d R=%d: the closing tree's branching per depth (no size pruning)\n", D, DMAX, R);
  printf("# depth  nodes  n_k/n_{k-1}  mean c | c histogram 0..5 | grandchildren max, histogram (g:count, the five largest g) | refused coplanar / fold, admitted coplanar / fold\n");
  for (int k = 0; k <= DMAX; k++) { if (!nodes[k]) continue; double sc = 0; for (int c = 0; c <= 5; c++) sc += (double)c * chist[k][c];
    printf("%2d %12ld %8.4f %7.4f |", k, nodes[k], k ? (double)nodes[k] / nodes[k - 1] : 0.0, sc / nodes[k]);
    for (int c = 0; c <= 5; c++) printf(" %lld", chist[k][c]);
    printf(" | gmax %lld:", gmax[k]); int shown = 0; for (int g = 63; g >= 0 && shown < 5; g--) if (ghist[k][g]) { printf(" %d:%lld", g, ghist[k][g]); shown++; }
    printf(" | %lld / %lld, %lld / %lld\n", refco[k], reffo[k], admco[k], admfo[k]); }
  printf("# closed leaves met by size F (surf.c's known answer 4, 60, 80, 1092 at F = 6, 10, 12, 14 where the depth reaches them):");
  for (int f = 0; f < 64; f++) if (leaves[f]) printf(" F=%d:%lld", f, leaves[f]); printf("\n");
  return 0; }
