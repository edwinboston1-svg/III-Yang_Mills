/* g49_oddtree.c -- THE ODD-RULE TREE'S OWN CENSUS AND ITS RIGOROUS TAIL (PENTAPYLON G49, 2026-10-29 11:5x EDT, the author; staked
 * in RESULTS 16.59 before this file existed).
 * THE TREE (Lemma P of 16.58): from the plaquette p0, a node is a plaquette set; its ODD links (odd multiplicity) are listed; a node with no
 * odd link is a LEAF (an even set); otherwise the rule picks one odd link l and the children are the 6 - m(l) plaquettes outside the set
 * containing l.  Rule 0 picks the smallest odd link (link order = base site lexicographic, then direction); rule 1 picks the odd link
 * minimising the sum of x^(2-2j) over its candidates (j = the OTHER odd links a candidate contains), ties to the smaller link.  Every
 * Z2-minimal even set through p0 is a leaf under either rule (16.58 (P1): along any path inside such a set, the picked odd link always has a
 * plaquette of the set outside the node, and the first even subset reached is the set itself).
 * THE TAIL BOUND: a step flips four link parities, so the odd-link count k moves by 2 - 2j >= -4, and g47's bound holds verbatim:
 *     sum_{F > F0} L(F) u^F <= sum_k H_n0(k) u^(n0+1) (5u)^max(F0 - n0, ceil(k/4)) / (1 - 5u),
 * L(F) the leaves of area F counted with multiplicity (a node has at most 5 children: an odd multiplicity is at least 1).
 * KNOWN ANSWERS (rule 0): the distinct leaves at F = 6, 10, 12, 14 are 4, 60, 180, 1092 (16.58's per-set search over the census, the
 * even sets reached from p0); the alive counts at n = 10..13 are at least g47's branch-free 6966524, 33179564, 158022311, 752620763.
 * usage: g49_oddtree D NMAX F0 [u ...]   (env G49_RULE = 0 or 1, G49_X = x, G49_DEDUP = the largest area whose leaves are deduplicated)
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>
#define MAXD 4
#define MAXN 40
#define HBITS 22
static int D, NMAX, F0, R, B, NPD, PAIRA[6], PAIRB[6], PIDX[MAXD][MAXD], RULE = 0, DEDUP = 14; static long long stride[MAXD], NS;
static unsigned char *lcnt, *inP; static long long *oddl, *opos; static int nodd;
static long long Pl[MAXN + 4]; static int np;
static long long T[MAXN + 1], C[MAXN + 1], A[MAXN + 1], H[MAXN + 1][4 * MAXN + 8], LBR[MAXN + 2], LDIST[MAXN + 2], LDISTBR[MAXN + 2];
static unsigned long long *HT; static long long HTN, HTFULL;
static double XSEL = 0.8909, MAXCHOSEN = 0; static long long nodes; static time_t t0;
static long long pid(long long s, int a, int b) { return s * NPD + PIDX[a][b]; }
static void plinks(long long p, long long *L4) { long long s = p / NPD; int k = (int)(p % NPD), a = PAIRA[k], b = PAIRB[k]; L4[0] = s * D + a; L4[1] = (s + stride[a]) * D + b; L4[2] = (s + stride[b]) * D + a; L4[3] = s * D + b; }
static void addodd(long long l) { opos[l] = nodd; oddl[nodd++] = l; }
static void delodd(long long l) { long long i = opos[l]; long long last = oddl[--nodd]; oddl[i] = last; opos[last] = i; }
static int nhigh_decl;   /* forward: the count of links of multiplicity >= 3 lives below with MAXC */
static void addp(long long p);
static void remp(long long p);
static int candidates(long long l, long long *cand) {
  long long s = l / D; int a = (int)(l % D), nc = 0;
  for (int b = 0; b < D; b++) { if (b == a) continue; int lo = a < b ? a : b, hi = a < b ? b : a;
    for (int sg = 0; sg < 2; sg++) { long long base = sg ? s - stride[b] : s; long long p = pid(base, lo, hi); if (!inP[p]) cand[nc++] = p; } }
  return nc;
}
static int MAXC = -1, nhigh = 0;   /* G49_MAXC: prune nodes with more than MAXC links of multiplicity >= 3 (16.69) */
static double csum(long long l) {
  /* the minimising rule sums x^(2-2j) over the VALID candidates only -- those whose addition keeps the node inside T_c -- so that at MAXC = 0
     it is g47's rule to the node (16.69-c: the first form summed over every candidate and parted from g47 at depth 8) */
  long long cand[6]; int nc = candidates(l, cand); double S = 0;
  for (int i = 0; i < nc; i++) { long long L4[4]; plinks(cand[i], L4); int j = 0, newhigh = 0; for (int t = 0; t < 4; t++) { if (L4[t] == l) continue; if (lcnt[L4[t]] & 1) j++; if (lcnt[L4[t]] == 2) newhigh++; }
    if (lcnt[l] == 2) newhigh++;
    if (MAXC >= 0 && nhigh + newhigh > MAXC) continue;
    S += pow(XSEL, 2 - 2 * j); }
  return S;
}
static int cmpll(const void *x, const void *y) { long long a = *(const long long *)x, b = *(const long long *)y; return a < b ? -1 : a > b; }
static void leaf_record(int n) {
  int F = n + 1; int br = 0;
  for (int i = 0; i < np && !br; i++) { long long L4[4]; plinks(Pl[i], L4); for (int t = 0; t < 4; t++) if (lcnt[L4[t]] >= 4) { br = 1; break; } }
  if (br) LBR[F]++;
  if (F > DEDUP) return;
  long long q[MAXN + 4]; for (int i = 0; i < np; i++) q[i] = Pl[i]; qsort(q, np, sizeof(long long), cmpll);
  unsigned long long h = 1469598103934665603ULL ^ (unsigned long long)F; for (int i = 0; i < np; i++) { h ^= (unsigned long long)q[i]; h *= 1099511628211ULL; h ^= h >> 29; }
  if (h == 0) h = 1;
  unsigned long long mask = (1ULL << HBITS) - 1, pos = (h * 0x9E3779B97F4A7C15ULL) >> (64 - HBITS);
  for (long long probes = 0; ; probes++) { if (probes > (long long)mask) { HTFULL++; return; }
    if (HT[pos] == 0) { HT[pos] = h; HTN++; LDIST[F]++; if (br) LDISTBR[F]++; return; }
    if (HT[pos] == h) return;
    pos = (pos + 1) & mask; }
}

   /* G49_MAXC: prune nodes with more than MAXC links of multiplicity >= 3 (16.69: valid for every Z2-minimal set with <= MAXC contact links); -1 = no pruning */
static void dfs(int n) {
  nodes++; T[n]++;
  if (nodd == 0) { C[n]++; leaf_record(n); return; }
  if (MAXC >= 0 && nhigh > MAXC) { T[n]--; nodes--; return; }   /* pruned: not a node of T_c */
  long long l = -1;
  if (RULE == 0) { l = oddl[0]; for (int i = 1; i < nodd; i++) if (oddl[i] < l) l = oddl[i]; }
  else if (RULE == 2) { /* the fewest children: the odd link of highest multiplicity (6 - m candidates), ties to the smallest link; valid by Lemma P for any odd link */
    int bm = -1; for (int oi = 0; oi < nodd; oi++) { long long l2 = oddl[oi]; int m = lcnt[l2]; if (m > bm || (m == bm && l2 < l)) { bm = m; l = l2; } } }
  else { double bestS = 1e30; for (int oi = 0; oi < nodd; oi++) { long long l2 = oddl[oi]; double S = csum(l2); if (S < bestS - 1e-12 || (S < bestS + 1e-12 && (l < 0 || l2 < l))) { bestS = S; l = l2; } } if (bestS > MAXCHOSEN) MAXCHOSEN = bestS; }
  long long cand[6]; int nc = candidates(l, cand);
  A[n]++; if (nodd < 4 * MAXN + 8) H[n][nodd]++;
  if (n >= NMAX) return;
  for (int i = 0; i < nc; i++) { addp(cand[i]); dfs(n + 1); remp(cand[i]); }
}
int main(int argc, char **argv) {
  setvbuf(stdout, NULL, _IONBF, 0);
  if (argc < 4) { fprintf(stderr, "usage: g49_oddtree D NMAX F0 [u ...]\n"); return 2; }
  D = atoi(argv[1]); NMAX = atoi(argv[2]); F0 = atoi(argv[3]);
  if (getenv("G49_RULE")) RULE = atoi(getenv("G49_RULE")); if (getenv("G49_X")) XSEL = atof(getenv("G49_X")); if (getenv("G49_DEDUP")) DEDUP = atoi(getenv("G49_DEDUP")); if (getenv("G49_MAXC")) MAXC = atoi(getenv("G49_MAXC"));
  if ((D != 3 && D != 4) || NMAX < 1 || NMAX > MAXN || (RULE != 0 && RULE != 1 && RULE != 2)) return 2;
  R = NMAX + 3; B = 2 * R + 1; NS = 1; for (int d = D - 1; d >= 0; d--) { stride[d] = NS; NS *= B; }
  NPD = D * (D - 1) / 2; int k = 0; for (int a = 0; a < D; a++) for (int b = a + 1; b < D; b++) { PAIRA[k] = a; PAIRB[k] = b; PIDX[a][b] = PIDX[b][a] = k; k++; }
  lcnt = calloc((size_t)NS * D, 1); inP = calloc((size_t)NS * NPD, 1); oddl = malloc(sizeof(long long) * (4 * MAXN + 16)); opos = malloc(sizeof(long long) * (size_t)NS * D);
  HT = calloc((size_t)1 << HBITS, sizeof(unsigned long long));
  if (!lcnt || !inP || !opos || !oddl || !HT) { fprintf(stderr, "G49-REFUSED memory\n"); return 3; }
  long long c = 0; for (int d = 0; d < D; d++) c += (long long)R * stride[d];
  long long p0 = pid(c, 0, 1);
  printf("G49 D=%d NMAX=%d F0=%d RULE=%d%s MAXC=%d: box side %d (radius %d), the odd-rule tree from p0 (children: every plaquette outside the node at the picked odd link)\n", D, NMAX, F0, RULE, RULE == 0 ? " (the smallest odd link)" : RULE == 2 ? " (the fewest children: the odd link of highest multiplicity)" : " (the minimising rule)", MAXC, B, R);
  if (RULE) printf("G49 x=%.6f\n", XSEL);
  t0 = time(NULL); addp(p0); dfs(0); remp(p0);
  for (int n = 0; n <= NMAX; n++) {
    printf("G49-DEPTH n=%d (area %d): nodes %lld, leaves (even sets, with multiplicity) %lld, alive %lld", n, n + 1, T[n], C[n], A[n]);
    if (n > 0 && T[n - 1]) printf(", nodes ratio %.4f, alive ratio %.4f", (double)T[n] / T[n - 1], A[n - 1] ? (double)A[n] / A[n - 1] : 0.0);
    printf("\n"); }
  for (int F = 1; F <= NMAX + 1; F++) if (C[F - 1]) printf("G49-LEAVES F=%d: %lld with multiplicity, of which branched (a link of multiplicity >= 4) %lld; distinct %s%lld, of which branched %lld\n", F, C[F - 1], LBR[F], F <= DEDUP ? "" : "(not deduplicated above G49_DEDUP) ", LDIST[F], LDISTBR[F]);
  if (HTFULL) printf("G49-REFUSED the leaf table filled %lld times: the distinct counts are lower bounds\n", HTFULL);
  printf("G49-HIST n=%d alive nodes by odd-link count k:", NMAX); for (int kk = 0; kk < 4 * MAXN + 8; kk++) if (H[NMAX][kk]) printf(" k=%d:%lld", kk, H[NMAX][kk]); printf("\n");
  for (int ai = 4; ai < argc; ai++) { double u = atof(argv[ai]); if (5 * u >= 1) { printf("G49-TAIL u=%.6f: 5u >= 1, no bound\n", u); continue; }
    double crude = pow(5.0, F0) * pow(u, F0 + 1) / (1 - 5 * u);
    printf("G49-TAIL u=%.6f F0=%d: the n0 = 0 form 5^F0 u^(F0+1)/(1-5u) = %.6e\n", u, F0, crude);
    for (int n0 = 1; n0 <= NMAX && n0 < F0; n0++) { double S = 0; for (int kk = 0; kk < 4 * MAXN + 8; kk++) if (H[n0][kk]) { int m = F0 - n0; int mk = (kk + 3) / 4; if (mk > m) m = mk; S += (double)H[n0][kk] * pow(u, n0 + 1) * pow(5 * u, m) / (1 - 5 * u); }
      printf("G49-TAIL u=%.6f F0=%d n0=%d: bound %.6e (ratio to the n0 = 0 form %.6f)\n", u, F0, n0, S, S / crude); } }
  if (RULE) printf("G49-MINRULE x=%.4f: the largest chosen sum over every node reached: %.6f\n", XSEL, MAXCHOSEN);
  printf("G49-END nodes %lld (%ld s)\n", nodes, (long)(time(NULL) - t0));
  return 0;
}
/* the add/remove with the high-multiplicity count (moved below MAXC so the pruning sees it) */
static void addp(long long p) { long long L4[4]; plinks(p, L4); inP[p] = 1; Pl[np++] = p; for (int i = 0; i < 4; i++) { long long l = L4[i]; lcnt[l]++; if (lcnt[l] == 3) nhigh++; if (lcnt[l] & 1) addodd(l); else delodd(l); } }
static void remp(long long p) { long long L4[4]; plinks(p, L4); inP[p] = 0; np--; for (int i = 3; i >= 0; i--) { long long l = L4[i]; if (lcnt[l] & 1) delodd(l); else addodd(l); if (lcnt[l] == 3) nhigh--; lcnt[l]--; } }
