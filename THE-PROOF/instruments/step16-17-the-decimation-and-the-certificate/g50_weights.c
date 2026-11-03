/* g48_polymers.c -- THE BRANCHED POLYMERS OF Z^D ENUMERATED AND SPLIT (PENTAPYLON G48, 2026-10-29 10:2x EDT, the author; the plan
 * author's order of 10:2x, R1; staked in RESULTS 16.51 before this file existed).
 * THE OBJECT: closed link-connected plaquette sets X through the fixed plaquette p0 (every link of X in 0 or >= 2 of its plaquettes), with
 * |X| <= FMAX.  Those with every link in exactly 2 plaquettes are the branch-free surfaces (the known answers); the others are BRANCHED.
 * A branched X is REDUCIBLE if it splits into two plaquette-disjoint closed parts whose shared links (links met by both parts) form a forest,
 * IRREDUCIBLE otherwise; ODD if some link has odd multiplicity, EVEN otherwise.
 * THE ENUMERATION: every X has a unique canonical construction from p0 -- while the partial set P has a link of multiplicity one, add the
 * smallest plaquette of X containing the smallest such link; once P is closed and P != X, add the smallest plaquette of X sharing a link with
 * P (X is link-connected).  The search branches on that plaquette among the candidates in increasing order and FORBIDS each candidate for the
 * later siblings, so it follows exactly the canonical path of each X once.  Pruned by |P| + ceil(n1/4) <= FMAX (n1 = links of multiplicity
 * one; one plaquette lowers n1 by at most 4).
 * THE SPLIT TEST: all 2^(F-1) bipartitions in Gray order with the parts' multiplicity-one counts kept incrementally; for the closed ones the
 * shared links are tested for a cycle by union-find.  THE DECOMPOSITION TEST (irreducible even X): a pairing of the plaquettes at every link of
 * multiplicity 4 or 6 (3 or 15 choices), the components of the pairing graph, valid iff no component holds two pairs of one link (each
 * component then a branch-free closed surface); the least cycle rank of the shared link set over the valid pairings is recorded, or the set is
 * SELF-TOUCHING.
 * KNOWN ANSWERS: the branch-free sets 4, 60, 80, 1092 at F = 6, 10, 12, 14 (D = 4); the 66 pairs of unit cubes sharing a face at F = 11.
 * usage: g48_polymers D FMAX [LISTMAX=40]
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#define MAXD 4
#define MAXF 40
typedef unsigned long long wmask;   /* an even-subset mask over the plaquettes of one set: 64 bits since 16:4x (36-plaquette sets) */
static int D, FMAX, R, B, NPD, PAIRA[6], PAIRB[6], PIDX[MAXD][MAXD], LISTMAX = 40; static long long stride[MAXD], NS;
static unsigned char *mult, *inX; static unsigned short *forb;
static long long *defl, *dpos; static int ndef;
static long long Pl[MAXF + 4]; static int np;
static long long nodes;
static long long cntBF[MAXF + 1], cntBr[MAXF + 1], cntRedOdd[MAXF + 1], cntRedEven[MAXF + 1], cntIrrOdd[MAXF + 1], cntIrrEven[MAXF + 1], cntIrrEvenDec[MAXF + 1], cntIrrEvenSelf[MAXF + 1];
static void plinks(long long p, long long *L4) { long long s = p / NPD; int k = (int)(p % NPD), a = PAIRA[k], b = PAIRB[k]; L4[0] = s * D + a; L4[1] = (s + stride[a]) * D + b; L4[2] = (s + stride[b]) * D + a; L4[3] = s * D + b; }
static void lplaqs(long long l, long long *P6, int *n) { long long s = l / D; int a = (int)(l % D); *n = 0; for (int b = 0; b < D; b++) { if (b == a) continue; int lo = a < b ? a : b, hi = a < b ? b : a; P6[(*n)++] = s * NPD + PIDX[lo][hi]; P6[(*n)++] = (s - stride[b]) * NPD + PIDX[lo][hi]; } }
static void adddef(long long l) { dpos[l] = ndef; defl[ndef++] = l; }
static void deldef(long long l) { long long i = dpos[l]; long long last = defl[--ndef]; defl[i] = last; dpos[last] = i; }
static void addp(long long p) { long long L4[4]; plinks(p, L4); inX[p] = 1; Pl[np++] = p; for (int i = 0; i < 4; i++) { long long l = L4[i]; mult[l]++; if (mult[l] == 1) adddef(l); else if (mult[l] == 2) deldef(l); } }
static void remp(long long p) { long long L4[4]; plinks(p, L4); for (int i = 3; i >= 0; i--) { long long l = L4[i]; if (mult[l] == 2) adddef(l); else if (mult[l] == 1) deldef(l); mult[l]--; } inX[p] = 0; np--; }
static int cmpll(const void *x, const void *y) { long long a = *(const long long *)x, b = *(const long long *)y; return a < b ? -1 : a > b; }
/* ---- classification of a closed X = Pl[0..F-1] */
static int F_, NLk; static long long lk[4 * MAXF + 8]; static int plk[MAXF + 4][4]; static int lmult[4 * MAXF + 8];
static int site_of_link_a(int li) { (void)li; return 0; }
static int find_(int *u, int x) { while (u[x] != x) { u[x] = u[u[x]]; x = u[x]; } return x; }
static int forest_shared(const int *m1, const int *m2) {
  /* vertices: the two endpoints of each shared link, as site ids; union-find over a small local table */
  long long vs[8 * MAXF + 16]; int nv = 0, uf[8 * MAXF + 16];
  for (int li = 0; li < NLk; li++) { if (!(m1[li] && m2[li])) continue; long long l = lk[li]; long long s0 = l / D; int a = (int)(l % D); long long s1 = s0 + stride[a];
    int i0 = -1, i1 = -1; for (int t = 0; t < nv; t++) { if (vs[t] == s0) i0 = t; if (vs[t] == s1) i1 = t; }
    if (i0 < 0) { vs[nv] = s0; uf[nv] = nv; i0 = nv++; } if (i1 < 0) { vs[nv] = s1; uf[nv] = nv; i1 = nv++; }
    int r0 = find_(uf, i0), r1 = find_(uf, i1); if (r0 == r1) return 0; uf[r1] = r0; }
  return 1;
}
static int reducible(void) {
  int F = F_; int m1[4 * MAXF + 8], m2[4 * MAXF + 8]; int bad1 = 0, bad2 = 0;
  for (int li = 0; li < NLk; li++) { m1[li] = 0; m2[li] = 0; }
  int in1[MAXF + 4]; for (int i = 0; i < F; i++) in1[i] = 0;
  /* start: X1 = {plaquette 0}, X2 = the rest */
  for (int i = 0; i < F; i++) { int *m = (i == 0) ? m1 : m2; if (i == 0) in1[0] = 1; for (int q = 0; q < 4; q++) m[plk[i][q]]++; }
  for (int li = 0; li < NLk; li++) { if (m1[li] == 1) bad1++; if (m2[li] == 1) bad2++; }
  long long total = 1LL << (F - 1);
  for (long long g = 0; g < total; g++) {
    if (g > 0) { /* Gray step: toggle bit = index of lowest set bit of g, plaquette (bit + 1) */
      int bit = __builtin_ctzll(g); int i = bit + 1; int to1 = !in1[i]; in1[i] = to1;
      for (int q = 0; q < 4; q++) { int li = plk[i][q];
        if (to1) { if (m1[li] == 1) bad1--; m1[li]++; if (m1[li] == 1) bad1++; if (m2[li] == 1) bad2--; m2[li]--; if (m2[li] == 1) bad2++; }
        else { if (m2[li] == 1) bad2--; m2[li]++; if (m2[li] == 1) bad2++; if (m1[li] == 1) bad1--; m1[li]--; if (m1[li] == 1) bad1++; } } }
    int all1 = 1; for (int i = 0; i < F; i++) if (!in1[i]) { all1 = 0; break; }
    if (all1) continue;
    if (bad1 == 0 && bad2 == 0 && forest_shared(m1, m2)) return 1; }
  return 0;
}
/* decomposition of an even X into branch-free surfaces; returns 1 and the least cycle rank and the component count, or 0 */
static int PAIR4[3][4] = {{0, 1, 2, 3}, {0, 2, 1, 3}, {0, 3, 1, 2}};
static int PAIR6[15][6];
static void mkpair6(void) { int n = 0; int a[6] = {0, 1, 2, 3, 4, 5};
  for (int x = 1; x < 6; x++) { int rest[4], k = 0; for (int t = 1; t < 6; t++) if (t != x) rest[k++] = t;
    for (int y = 1; y < 4; y++) { int r2[2], kk = 0; for (int t = 1; t < 4; t++) if (t != y) r2[kk++] = rest[t];
      PAIR6[n][0] = a[0]; PAIR6[n][1] = x; PAIR6[n][2] = rest[0]; PAIR6[n][3] = rest[y]; PAIR6[n][4] = r2[0]; PAIR6[n][5] = r2[1]; n++; } } }
static int decompose(int *bestrank, int *ncomp) {
  int F = F_; int hl[4 * MAXF + 8], nhl = 0; int lpl[4 * MAXF + 8][6], lnp[4 * MAXF + 8];
  for (int li = 0; li < NLk; li++) lnp[li] = 0;
  for (int i = 0; i < F; i++) for (int q = 0; q < 4; q++) { int li = plk[i][q]; lpl[li][lnp[li]++] = i; }
  for (int li = 0; li < NLk; li++) { if (lnp[li] & 1) return -1; if (lnp[li] >= 4) hl[nhl++] = li; }
  int choice[4 * MAXF + 8]; for (int t = 0; t < nhl; t++) choice[t] = 0;
  int found = 0; *bestrank = 1 << 30; *ncomp = 0; long long combos = 0;
  for (;;) {
    combos++; if (combos > 2000000) break;
    int uf[MAXF + 4]; for (int i = 0; i < F; i++) uf[i] = i;
    for (int li = 0; li < NLk; li++) { if (lnp[li] == 2) { int a = find_(uf, lpl[li][0]), b = find_(uf, lpl[li][1]); if (a != b) uf[b] = a; } }
    for (int t = 0; t < nhl; t++) { int li = hl[t]; int m = lnp[li]; const int *pr = (m == 4) ? PAIR4[choice[t]] : PAIR6[choice[t]];
      for (int k = 0; k < m; k += 2) { int a = find_(uf, lpl[li][pr[k]]), b = find_(uf, lpl[li][pr[k + 1]]); if (a != b) uf[b] = a; } }
    int ok = 1;
    for (int t = 0; t < nhl && ok; t++) { int li = hl[t]; int m = lnp[li]; const int *pr = (m == 4) ? PAIR4[choice[t]] : PAIR6[choice[t]];
      for (int k = 0; k < m && ok; k += 2) for (int k2 = k + 2; k2 < m; k2 += 2) if (find_(uf, lpl[li][pr[k]]) == find_(uf, lpl[li][pr[k2]])) { ok = 0; break; } }
    if (ok) { int nc = 0; for (int i = 0; i < F; i++) if (find_(uf, i) == i) nc++;
      /* shared links: the links of multiplicity >= 4; cycle rank of their graph on sites */
      long long vs[8 * MAXF + 16]; int nv = 0, u2[8 * MAXF + 16], E = 0, C = 0;
      for (int t = 0; t < nhl; t++) { long long l = lk[hl[t]]; long long s0 = l / D; int a = (int)(l % D); long long s1 = s0 + stride[a]; int i0 = -1, i1 = -1;
        for (int z = 0; z < nv; z++) { if (vs[z] == s0) i0 = z; if (vs[z] == s1) i1 = z; } if (i0 < 0) { vs[nv] = s0; u2[nv] = nv; i0 = nv++; } if (i1 < 0) { vs[nv] = s1; u2[nv] = nv; i1 = nv++; }
        E++; int r0 = find_(u2, i0), r1 = find_(u2, i1); if (r0 != r1) u2[r1] = r0; }
      for (int z = 0; z < nv; z++) if (find_(u2, z) == z) C++;
      int rank = E - nv + C; found = 1; if (rank < *bestrank) { *bestrank = rank; *ncomp = nc; } }
    int t = 0; while (t < nhl) { int lim = (lnp[hl[t]] == 4) ? 3 : 15; choice[t]++; if (choice[t] < lim) break; choice[t] = 0; t++; } if (t == nhl) break; }
  return found;
}
/* the rest X \ Y of an odd polymer (Y the first least integer-spin set found): is it branch-free (every link in 0 or 2 of its plaquettes),
   and how many link-connected components has it; tallied by (F, |Y|, branch-free, components) */
/* the abstract surface of an even polymer under a pairing at its links of multiplicity 4 or 6: faces = its plaquettes, edges = the pairs,
   vertices = the cycles of faces around each lattice vertex (each face joins its two pairs at the vertex); returns the number of components
   and chi = V - E + F = V - F (E = 2F) */
static int chi_of(const int *choice, const int *hl, int nhl, int lpl[][6], const int *lnp, int *ncomp_out) {
  int F = F_;
  /* pair id of (link, face): for multiplicity 2 the pair is the link's; for 4/6 the pairing chosen */
  static int pairof[4 * MAXF + 8][6]; static int pid_base[4 * MAXF + 8]; int npairs = 0;
  for (int li = 0; li < NLk; li++) { pid_base[li] = npairs; int m = lnp[li];
    if (m == 2) { pairof[li][0] = pairof[li][1] = npairs++; }
    else { int t = -1; for (int z = 0; z < nhl; z++) if (hl[z] == li) t = z; const int *pr = (m == 4) ? PAIR4[choice[t]] : PAIR6[choice[t]];
      for (int k = 0; k < m; k += 2) { pairof[li][pr[k]] = npairs; pairof[li][pr[k + 1]] = npairs; npairs++; } } }
  /* faces union by pairs -> components */
  int uf[MAXF + 4]; for (int i = 0; i < F; i++) uf[i] = i;
  for (int li = 0; li < NLk; li++) { int m = lnp[li]; for (int a = 0; a < m; a++) for (int b = a + 1; b < m; b++) if (pairof[li][a] == pairof[li][b]) { int x = find_(uf, lpl[li][a]), y = find_(uf, lpl[li][b]); if (x != y) uf[y] = x; } }
  int nc = 0; for (int i = 0; i < F; i++) if (find_(uf, i) == i) nc++; *ncomp_out = nc;
  /* vertices: for each lattice vertex, the faces there, joined through the pairs of their two links at the vertex */
  long long verts[4 * MAXF + 8]; int nv = 0;
  for (int i = 0; i < F; i++) { long long p = Pl[i]; long long s = p / NPD; int k = (int)(p % NPD), a = PAIRA[k], b = PAIRB[k]; long long cs[4] = { s, s + stride[a], s + stride[b], s + stride[a] + stride[b] };
    for (int c = 0; c < 4; c++) { int f = 0; for (int z = 0; z < nv; z++) if (verts[z] == cs[c]) { f = 1; break; } if (!f) verts[nv++] = cs[c]; } }
  int V = 0;
  for (int z = 0; z < nv; z++) { long long v = verts[z]; int fc[MAXF + 4], nf = 0, e1[MAXF + 4], e2[MAXF + 4];
    for (int i = 0; i < F; i++) { long long p = Pl[i]; long long s = p / NPD; int k = (int)(p % NPD), a = PAIRA[k], b = PAIRB[k]; long long cs[4] = { s, s + stride[a], s + stride[b], s + stride[a] + stride[b] };
      int at = -1; for (int c = 0; c < 4; c++) if (cs[c] == v) at = c; if (at < 0) continue;
      int la, lb; if (at == 0) { la = 0; lb = 3; } else if (at == 1) { la = 0; lb = 1; } else if (at == 2) { la = 2; lb = 3; } else { la = 1; lb = 2; }
      int lia = plk[i][la], lib = plk[i][lb]; int ia = -1, ib = -1; for (int t = 0; t < lnp[lia]; t++) if (lpl[lia][t] == i) ia = t; for (int t = 0; t < lnp[lib]; t++) if (lpl[lib][t] == i) ib = t;
      fc[nf] = i; e1[nf] = pairof[lia][ia]; e2[nf] = pairof[lib][ib]; nf++; }
    /* faces at v joined when they share a pair id; cycles = components */
    int u[MAXF + 4]; for (int t = 0; t < nf; t++) u[t] = t;
    for (int t = 0; t < nf; t++) for (int w = t + 1; w < nf; w++) if (e1[t] == e1[w] || e1[t] == e2[w] || e2[t] == e1[w] || e2[t] == e2[w]) { int x = find_(u, t), y = find_(u, w); if (x != y) u[y] = x; }
    for (int t = 0; t < nf; t++) if (find_(u, t) == t) V++; }
  return V - F;
}
static long long CHT[MAXF + 1][4][9];   /* even self-touching: per F, components (0..3), chi + 4 (0..8): count of (polymer, pairing) */
static void chi_all(void) {
  int F = F_; int hl[4 * MAXF + 8], nhl = 0; static int lpl[4 * MAXF + 8][6]; int lnp[4 * MAXF + 8];
  for (int li = 0; li < NLk; li++) lnp[li] = 0;
  for (int i = 0; i < F; i++) for (int q = 0; q < 4; q++) { int li = plk[i][q]; lpl[li][lnp[li]++] = i; }
  for (int li = 0; li < NLk; li++) { if (lnp[li] & 1) return; if (lnp[li] >= 4) hl[nhl++] = li; }
  int choice[4 * MAXF + 8]; for (int t = 0; t < nhl; t++) choice[t] = 0; long long combos = 0;
  for (;;) { int nc; int chi = chi_of(choice, hl, nhl, lpl, lnp, &nc); if (nc < 4 && chi + 4 >= 0 && chi + 4 < 9) CHT[F][nc][chi + 4]++;
    if (++combos > 100000) break;
    int t = 0; while (t < nhl) { int lim = (lnp[hl[t]] == 4) ? 3 : 15; choice[t]++; if (choice[t] < lim) break; choice[t] = 0; t++; } if (t == nhl) break; }
}
static void chiprint(void) {
  for (int F = 1; F <= MAXF; F++) for (int nc = 0; nc < 4; nc++) for (int c = 0; c < 9; c++) if (CHT[F][nc][c])
    printf("G48-CHI F=%d even irreducible (all, both species): a pairing at the contact links gives %d component(s) with total chi = %d: %lld (polymer, pairing) cases\n", F, nc, c - 4, CHT[F][nc][c]);
}
/* ---- inlined from g48_v7_add.c ---- */
/* ---- g48 v7 additions (2026-10-29 11:5x EDT, the author; staked in RESULTS 16.58 before this file existed), included by
 * g48_polymers_v7.c before the rest tallies:
 * (iii) THE ODD-RULE REACHABILITY of every even set X through p0.  T_odd closes the smallest link of odd multiplicity (the lattice order of
 *       link ids) by any plaquette of X containing it; X is REACHED WHOLE from a root iff some path ends at X (a path ends at its first even
 *       subset).  Run from the root p0 and from every root, by a search over subsets of X with a memo (open addressing, generation stamps).
 *       Known answers (Lemma P): every branch-free set and every even irreducible set with acyclic contacts is reached from every root.
 * (iv)  THE BRANCHED RESTS BY PROFILE: the rest's reducibility keyed by the polymer's profile, with the rest's contact links (multiplicity
 *       >= 4) counted and their graph's components.
 * (v)   THE TWO-BOX WAIST BUILT: for each plaquette P != p0 sharing a cube with p0, the mod-2 sum of the boundaries of the four cubes on P,
 *       classified by the census's own tests and searched by the odd rule from every root. */
#define RH_BITS 20
static unsigned int *RH_k, *RH_s; static unsigned int RH_gen; static long long RL_overflow, RL_states;
static int RL_lpl[4 * MAXF + 8][6], RL_lnp[4 * MAXF + 8], RL_ord[4 * MAXF + 8];
static unsigned long long RL_pm[MAXF + 4][2]; static unsigned int RL_full;
static int rh_seen(unsigned int m) {
  unsigned int h = (m * 2654435761u) >> (32 - RH_BITS); unsigned int probes = 0;
  for (;;) { if (RH_s[h] != RH_gen) { RH_s[h] = RH_gen; RH_k[h] = m; return 0; } if (RH_k[h] == m) return 1;
    h = (h + 1) & ((1u << RH_BITS) - 1); if (++probes > (1u << (RH_BITS - 1))) { RL_overflow++; return 0; } }
}
static int rdfs(unsigned int m, unsigned long long q0, unsigned long long q1) {
  if (!q0 && !q1) return m == RL_full;
  if (rh_seen(m)) return 0;
  RL_states++;
  int best = -1;
  for (int t = 0; t < NLk; t++) { int li = RL_ord[t]; unsigned long long w = li < 64 ? (q0 >> li) : (q1 >> (li - 64)); if (w & 1ULL) { best = li; break; } }
  if (best < 0) return 0;
  for (int k = 0; k < RL_lnp[best]; k++) { int i = RL_lpl[best][k]; if ((m >> i) & 1u) continue;
    if (rdfs(m | (1u << i), q0 ^ RL_pm[i][0], q1 ^ RL_pm[i][1])) return 1; }
  return 0;
}
static void reach_setup(void) {
  int F = F_;
  for (int li = 0; li < NLk; li++) RL_lnp[li] = 0;
  for (int i = 0; i < F; i++) { RL_pm[i][0] = RL_pm[i][1] = 0;
    for (int q = 0; q < 4; q++) { int li = plk[i][q]; RL_lpl[li][RL_lnp[li]++] = i; if (li < 64) RL_pm[i][0] ^= 1ULL << li; else RL_pm[i][1] ^= 1ULL << (li - 64); } }
  for (int t = 0; t < NLk; t++) RL_ord[t] = t;
  for (int t = 1; t < NLk; t++) { int v = RL_ord[t], u = t - 1; while (u >= 0 && lk[RL_ord[u]] > lk[v]) { RL_ord[u + 1] = RL_ord[u]; u--; } RL_ord[u + 1] = v; }
  RL_full = (F >= 32) ? 0xffffffffu : ((1u << F) - 1u);
}
static int reach_from(int r) { RH_gen++; return rdfs(1u << r, RL_pm[r][0], RL_pm[r][1]); }
/* the graph of the links with multiplicity >= thr (mm over link indices): returns the cycle rank, and the component count in *ncomp */
static int contact_graph(const int *mm, int thr, int *ncomp) {
  long long vs[8 * MAXF + 16]; int nv = 0, uf[8 * MAXF + 16], E = 0, C = 0;
  for (int li = 0; li < NLk; li++) { if (mm[li] < thr) continue; long long l = lk[li]; long long s0 = l / D; int a = (int)(l % D); long long s1 = s0 + stride[a]; int i0 = -1, i1 = -1;
    for (int z = 0; z < nv; z++) { if (vs[z] == s0) i0 = z; if (vs[z] == s1) i1 = z; }
    if (i0 < 0) { vs[nv] = s0; uf[nv] = nv; i0 = nv++; } if (i1 < 0) { vs[nv] = s1; uf[nv] = nv; i1 = nv++; }
    E++; int r0 = find_(uf, i0), r1 = find_(uf, i1); if (r0 != r1) uf[r1] = r0; }
  for (int z = 0; z < nv; z++) if (find_(uf, z) == z) C++;
  *ncomp = C; return E - nv + C;
}
static long long RCH_n[MAXF + 1][4], RCH_p0[MAXF + 1][4], RCH_all[MAXF + 1][4], RCH_none[MAXF + 1][4], RCH_roots[MAXF + 1][4], RCH_rootsum[MAXF + 1][4];
static const char *RCH_name[4] = { "branch-free surfaces", "even REDUCIBLE sets", "even IRREDUCIBLE sets with acyclic contacts (pinches, double contacts)", "even IRREDUCIBLE sets with a contact cycle (waists)" };
static void even_reach(int sp) {
  if (F_ > 32) return;   /* the reachability masks are 32-bit; a given set past 32 plaquettes skips the odd-rule check by name (16:4x) */
  int F = F_; reach_setup();
  int nr = 0, r0 = 0;
  for (int r = 0; r < F; r++) { int ok = reach_from(r); if (r == 0) r0 = ok; nr += ok; }
  RCH_n[F][sp]++; RCH_p0[F][sp] += r0; RCH_roots[F][sp] += nr; RCH_rootsum[F][sp] += F; if (nr == F) RCH_all[F][sp]++; if (nr == 0) RCH_none[F][sp]++;
}
static void reachprint(void) {
  for (int F = 1; F <= MAXF; F++) for (int sp = 0; sp < 4; sp++) if (RCH_n[F][sp])
    printf("G48-REACH F=%d %s: %lld sets; reached whole by the odd rule from the root p0: %lld; from EVERY root: %lld; from NO root: %lld; (set, root) pairs reached %lld of %lld\n",
      F, RCH_name[sp], RCH_n[F][sp], RCH_p0[F][sp], RCH_all[F][sp], RCH_none[F][sp], RCH_roots[F][sp], RCH_rootsum[F][sp]);
  printf("G48-REACH-SEARCH subset states visited %lld, memo overflows %lld\n", RL_states, RL_overflow);
}
typedef struct { int F, ms, h2, h3, h4, h5, rr, rm4, rcc; long long n; } prr_t; static prr_t PRR[1024]; static int NPRR;
static void prof_rred_add(int F, int ms, int rr, const int *mrest) {
  int h[8] = {0}; for (int t = 0; t < NLk; t++) if (lmult[t] < 8) h[lmult[t]]++;
  int rm4 = 0; for (int li = 0; li < NLk; li++) if (mrest[li] >= 4) rm4++;
  int rcc = 0; (void)contact_graph(mrest, 4, &rcc);
  for (int i = 0; i < NPRR; i++) { prr_t *e = &PRR[i]; if (e->F == F && e->ms == ms && e->h2 == h[2] && e->h3 == h[3] && e->h4 == h[4] && e->h5 == h[5] && e->rr == rr && e->rm4 == rm4 && e->rcc == rcc) { e->n++; return; } }
  if (NPRR < 1024) { prr_t *e = &PRR[NPRR++]; e->F = F; e->ms = ms; e->h2 = h[2]; e->h3 = h[3]; e->h4 = h[4]; e->h5 = h[5]; e->rr = rr; e->rm4 = rm4; e->rcc = rcc; e->n = 1; }
}
static void prrprint(void) {
  for (int F = 1; F <= MAXF; F++) for (int i = 0; i < NPRR; i++) { prr_t *e = &PRR[i]; if (e->F != F) continue;
    printf("G48-RREST-PROFILE F=%d profile (%d/%d/%d/%d) |Y| = %d: the BRANCHED rest is %s, with %d contact link(s) in %d component(s): %lld polymers\n",
      e->F, e->h2, e->h3, e->h4, e->h5, e->ms, e->rr ? "REDUCIBLE" : "IRREDUCIBLE", e->rm4, e->rcc, e->n); }
}
static int cubefaces(long long base, int x, int y, int z, long long *out) {   /* the six faces of the unit cube at base spanning x, y, z */
  int dd[3] = {x, y, z}; int n = 0;
  for (int u = 0; u < 3; u++) for (int v = u + 1; v < 3; v++) { int w = 3 - u - v; int a = dd[u], b = dd[v], c = dd[w];
    out[n++] = base * NPD + PIDX[a][b]; out[n++] = (base + stride[c]) * NPD + PIDX[a][b]; }
  return n;
}
static void selftest_twobox(long long p0) {
  long long s0 = p0 / NPD; int k0 = (int)(p0 % NPD), x0 = PAIRA[k0], y0 = PAIRB[k0];
  int built = 0, okall = 0;
  for (int z = 0; z < D; z++) { if (z == x0 || z == y0) continue;
    for (int sg = 0; sg < 2; sg++) { long long kb = s0 - (sg ? stride[z] : 0); long long cf[6]; cubefaces(kb, x0, y0, z, cf);
      for (int f = 0; f < 6; f++) { long long P = cf[f]; if (P == p0) continue;
        long long ps = P / NPD; int kp = (int)(P % NPD), xp = PAIRA[kp], yp = PAIRB[kp];
        long long acc[32]; int na = 0;
        for (int zz = 0; zz < D; zz++) { if (zz == xp || zz == yp) continue; for (int sg2 = 0; sg2 < 2; sg2++) { long long cb = ps - (sg2 ? stride[zz] : 0); na += cubefaces(cb, xp, yp, zz, acc + na); } }
        qsort(acc, na, sizeof(long long), cmpll);
        long long X[32]; int nx = 0; for (int i = 0; i < na; ) { int j = i; while (j < na && acc[j] == acc[i]) j++; if ((j - i) & 1) X[nx++] = acc[i]; i = j; }
        int has0 = 0; for (int i = 0; i < nx; i++) if (X[i] == p0) has0 = 1;
        addp(p0); for (int i = 0; i < nx; i++) if (X[i] != p0) addp(X[i]);
        int F = np; F_ = F; NLk = 0;
        for (int i = 0; i < F; i++) { long long L4[4]; plinks(Pl[i], L4); for (int q = 0; q < 4; q++) { int fnd = -1; for (int t = 0; t < NLk; t++) if (lk[t] == L4[q]) { fnd = t; break; } if (fnd < 0) { lk[NLk] = L4[q]; fnd = NLk++; } plk[i][q] = fnd; } }
        int hist[8] = {0}; for (int t = 0; t < NLk; t++) { lmult[t] = mult[lk[t]]; if (lmult[t] < 8) hist[lmult[t]]++; }
        int closed = (ndef == 0);
        int red = reducible(); int rank = -1, nc = 0, dec = decompose(&rank, &nc);
        int hl[4 * MAXF + 8], nhl = 0; static int lpl[4 * MAXF + 8][6]; int lnp[4 * MAXF + 8];
        for (int li = 0; li < NLk; li++) lnp[li] = 0;
        for (int i = 0; i < F; i++) for (int q = 0; q < 4; q++) { int li = plk[i][q]; lpl[li][lnp[li]++] = i; }
        for (int li = 0; li < NLk; li++) if (lnp[li] >= 4) hl[nhl++] = li;
        int choice[4 * MAXF + 8]; for (int t = 0; t < nhl; t++) choice[t] = 0; int nsep = 0, npair = 0;
        for (;;) { int ncc = 0; (void)chi_of(choice, hl, nhl, lpl, lnp, &ncc); npair++; if (ncc == 2) nsep++;
          int t = 0; while (t < nhl) { int lim = (lnp[hl[t]] == 4) ? 3 : 15; choice[t]++; if (choice[t] < lim) break; choice[t] = 0; t++; } if (t == nhl) break; }
        reach_setup(); int nr = 0; for (int r = 0; r < F; r++) nr += reach_from(r);
        int ok = has0 && F == 20 && closed && hist[2] == 32 && hist[3] == 0 && hist[4] == 4 && !red && dec == 1 && rank == 1 && nsep == 3;
        built++; okall += ok;
        printf("G48-TWOBOX P=%lld: area %d, contains p0 %d, closed %d, profile (%d/%d/%d), %s, decomposes %d (least cycle rank %d), separating pairings %d of %d, reached whole from %d of %d roots: %s\n",
          P, F, has0, closed, hist[2], hist[3], hist[4], red ? "REDUCIBLE" : "IRREDUCIBLE", dec, rank, nsep, npair, nr, F, ok ? "AS STAKED" : "NOT AS STAKED");
        for (int i = np - 1; i >= 0; i--) remp(Pl[i]);
      } } }
  printf("G48-TWOBOX %d built, %d as staked in 16.58 (v)\n", built, okall);
}

/* ---- inlined from g50_weights_add6.c ---- */
/* ---- g50 weights (2026-10-29 12:1x EDT, the author; staked in RESULTS 16.60 before this file existed; the plan author's order of
 * 12:0x and 12:1x, S1 §10–§11 of III-Yang_Mills): THE EXACT HAAR INTEGRAL of every irreducible polymer, and as the known answer of every
 * branch-free surface to W_KAT, by tensor contraction.  Included by g50_weights.c (built from g48_polymers_v7.c by mk_g50.pl).
 * I(X; R) = int prod_l dU_l prod_p chi_{j_p}(U_p) with j = 1/2 on R (an even subset of X) and 1 on X \ R.  One tensor per link,
 *   T_l = int dU (x)_{p contains l} D^{j_p}(U^eps), eps = U on the links p traverses forward (its L0, L1), U^-1 backward (L2, L3),
 * its entries exact from int a^p abar^q b^r bbar^s dU = [p == q][r == s] p! r! / (p + r + 1)! on U = [[a, b], [-bbar, abar]]; spin 1/2 is U
 * itself, spin 1 acts on the quadratic forms x^2, xy, y^2 by f(v) -> f(vU) (integer polynomial entries).  One bond per plaquette corner:
 * corner q of plaquette i (between its links q-1 and q) is bond 4i + q, the row index of link q's matrix and the column index of link q-1's.
 * The network is contracted greedily (the pair sharing a bond whose product is smallest) modulo P1 = 2^61 - 1 and P2 = 2^62 - 57 and in
 * floating point; the rational is read back by Wang's reconstruction from the CRT residue (|num|, den < 2^61) and must agree with the float.
 * Every even R of X is admissible at spins <= 1 (a link with m_R = 0 and m_{X\R} = 1 would have m_X = 1, and X is closed), and the least
 * integer-spin sets are exactly the complements X \ R of the largest even R (the boundary of X \ R is the odd links of X).
 * REPORTED: rho(X) = W(X) / (u^(F - |Y|) (3 a1)^|Y|) = sum over the largest even R of 2^|R| I(X; R), by profile, with the rest's
 * components, chi (vertex cycles minus plaquettes) and orientability when the rest is branch-free; and the full sum at spins <= 1,
 * sum over every even R of (2u)^|R| (3 a1)^(F - |R|) I(X; R), by its coefficients C_k = sum_{|R| = k} 2^k I(X; R). */
#include <math.h>
#define WP1 2305843009213693951ULL
#define WP2 4611686018427387847ULL
#define WMAXB 40
static long long WCAP = 1LL << 24;   /* env W_CAPLOG: the cap as a power of two */
typedef unsigned long long wu64; typedef unsigned __int128 wu128; typedef __int128 wi128;
static wu64 wmul(wu64 a, wu64 b, wu64 p) { return (wu64)((wu128)a * b % p); }
static wu64 wadd(wu64 a, wu64 b, wu64 p) { wu64 s = a + b; return s >= p ? s - p : s; }
static wu64 wpow(wu64 a, wu64 e, wu64 p) { wu64 r = 1 % p; a %= p; while (e) { if (e & 1) r = wmul(r, a, p); a = wmul(a, a, p); e >>= 1; } return r; }
static wu64 winv(wu64 a, wu64 p) { return wpow(a, p - 2, p); }
static wu64 wfromll(long long v, wu64 p) { if (v >= 0) return (wu64)v % p; wu64 r = (wu64)(-v) % p; return r ? p - r : 0; }
static wu64 WF1[80], WF2[80], WFI1[80], WFI2[80]; static double WFD[80];
static void wfact_init(void) { WF1[0] = WF2[0] = 1; WFD[0] = 1; for (int k = 1; k < 80; k++) { WF1[k] = wmul(WF1[k - 1], (wu64)k, WP1); WF2[k] = wmul(WF2[k - 1], (wu64)k, WP2); WFD[k] = WFD[k - 1] * k; }
  for (int k = 0; k < 80; k++) { WFI1[k] = winv(WF1[k], WP1); WFI2[k] = winv(WF2[k], WP2); } }
/* matrix entries as polynomials in (a, abar, b, bbar): at most 3 terms */
typedef struct { int n; unsigned char e[3][4]; long long c[3]; } wmono_t;
static wmono_t WD[2][2][3][3];   /* [spin: 0 = 1/2, 1 = 1][0 = U, 1 = U^-1][row][col] */
static void wm1(wmono_t *m, int e0, int e1, int e2, int e3, long long c) { int t = m->n++; m->e[t][0] = (unsigned char)e0; m->e[t][1] = (unsigned char)e1; m->e[t][2] = (unsigned char)e2; m->e[t][3] = (unsigned char)e3; m->c[t] = c; }
static void wd_init(void) {
  memset(WD, 0, sizeof WD);
  /* spin 1/2, U = [[a, b], [-bbar, abar]] */
  wm1(&WD[0][0][0][0], 1, 0, 0, 0, 1); wm1(&WD[0][0][0][1], 0, 0, 1, 0, 1); wm1(&WD[0][0][1][0], 0, 0, 0, 1, -1); wm1(&WD[0][0][1][1], 0, 1, 0, 0, 1);
  /* spin 1/2, U^-1 = [[abar, -b], [bbar, a]] */
  wm1(&WD[0][1][0][0], 0, 1, 0, 0, 1); wm1(&WD[0][1][0][1], 0, 0, 1, 0, -1); wm1(&WD[0][1][1][0], 0, 0, 0, 1, 1); wm1(&WD[0][1][1][1], 1, 0, 0, 0, 1);
  /* spin 1, U: [[a^2, ab, b^2], [-2 a bbar, a abar - b bbar, 2 abar b], [bbar^2, -abar bbar, abar^2]] */
  wm1(&WD[1][0][0][0], 2, 0, 0, 0, 1); wm1(&WD[1][0][0][1], 1, 0, 1, 0, 1); wm1(&WD[1][0][0][2], 0, 0, 2, 0, 1);
  wm1(&WD[1][0][1][0], 1, 0, 0, 1, -2); wm1(&WD[1][0][1][1], 1, 1, 0, 0, 1); wm1(&WD[1][0][1][1], 0, 0, 1, 1, -1); wm1(&WD[1][0][1][2], 0, 1, 1, 0, 2);
  wm1(&WD[1][0][2][0], 0, 0, 0, 2, 1); wm1(&WD[1][0][2][1], 0, 1, 0, 1, -1); wm1(&WD[1][0][2][2], 0, 2, 0, 0, 1);
  /* spin 1, U^-1 (a -> abar, b -> -b): [[abar^2, -abar b, b^2], [2 abar bbar, a abar - b bbar, -2 a b], [bbar^2, a bbar, a^2]] */
  wm1(&WD[1][1][0][0], 0, 2, 0, 0, 1); wm1(&WD[1][1][0][1], 0, 1, 1, 0, -1); wm1(&WD[1][1][0][2], 0, 0, 2, 0, 1);
  wm1(&WD[1][1][1][0], 0, 1, 0, 1, 2); wm1(&WD[1][1][1][1], 1, 1, 0, 0, 1); wm1(&WD[1][1][1][1], 0, 0, 1, 1, -1); wm1(&WD[1][1][1][2], 1, 0, 1, 0, -2);
  wm1(&WD[1][1][2][0], 0, 0, 0, 2, 1); wm1(&WD[1][1][2][1], 1, 0, 0, 1, 1); wm1(&WD[1][1][2][2], 2, 0, 0, 0, 1);
}
typedef struct { int nb; int bond[WMAXB]; int dim[WMAXB]; long long size; wu64 *x1, *x2; double *xd; } wtens_t;
static int WSPIN[MAXF + 4];
static long long W_REFUSED, W_EVALS, W_MAXSIZE, W_LEADREF, W_SUBREF; static int W_GREEDY = 0;   /* 0: the pair whose product is smallest; 1: the pair whose product grows least over its factors */
static void wfree(wtens_t *t) { free(t->x1); free(t->x2); free(t->xd); t->x1 = t->x2 = NULL; t->xd = NULL; }
static int walloc(wtens_t *t) { t->x1 = calloc((size_t)t->size, sizeof(wu64)); t->x2 = calloc((size_t)t->size, sizeof(wu64)); t->xd = calloc((size_t)t->size, sizeof(double)); return t->x1 && t->x2 && t->xd; }
/* the link tensor of link li of X under the spins WSPIN */
/* ---- v2 (12:3x EDT): THE LINK TENSOR FACTORED THROUGH ITS INVARIANTS.  As a matrix from the tail-side corner indices to the head-side
 * ones, T_l = int dU (x)_k (D^j(U) forward, D^j(U)^{-T} backward) is the projector onto the invariants of the representation
 * (x)_k (V_j or V_j^*), of rank r_l = dim Inv -- at most a handful, against corner groups of 2^m 3^k.  Rank factorisation from the reduced
 * row echelon form, P = P[:, S] . R (S the pivot columns), exact modulo each prime (the two pivot sets must agree or the type is refused)
 * and in floating point by the normal equations on the same S.  The network then has two tensors per link, A_l (tail corners, inv_l) and
 * B_l (inv_l, head corners); the corner bonds close at the lattice vertices, leaving vertex tensors joined by the inv bonds.  The
 * factorisations are cached by the ordered list of (spin, direction) at the link. */
#define WMAXINC 8
#define WINVBASE (4 * MAXF + 8)
typedef struct { int n; unsigned char sp[WMAXINC], fw[WMAXINC]; int r, Dm; wu64 *A1, *A2, *B1, *B2; double *Ad, *Bd; } wcache_t;
static wcache_t WC[8192]; static int NWC; static long long W_CACHE_HITS, W_CACHE_BUILDS, W_ZERO_LINKS;
static int wrref(wu64 *M, int D, wu64 p, int *piv, wu64 *R) {   /* M (D x D, row-major) is destroyed; returns the rank, the pivot columns and R (r x D) */
  int r = 0;
  for (int c = 0; c < D && r < D; c++) { int pr = -1; for (int i = r; i < D; i++) if (M[(size_t)i * D + c]) { pr = i; break; } if (pr < 0) continue;
    if (pr != r) for (int j = 0; j < D; j++) { wu64 t = M[(size_t)pr * D + j]; M[(size_t)pr * D + j] = M[(size_t)r * D + j]; M[(size_t)r * D + j] = t; }
    wu64 iv = winv(M[(size_t)r * D + c], p); for (int j = 0; j < D; j++) M[(size_t)r * D + j] = wmul(M[(size_t)r * D + j], iv, p);
    for (int i = 0; i < D; i++) { if (i == r) continue; wu64 f = M[(size_t)i * D + c]; if (!f) continue; for (int j = 0; j < D; j++) { wu64 s = wmul(f, M[(size_t)r * D + j], p); wu64 v = M[(size_t)i * D + j]; M[(size_t)i * D + j] = v >= s ? v - s : v + p - s; } }
    piv[r] = c; r++; }
  for (int i = 0; i < r; i++) for (int j = 0; j < D; j++) R[(size_t)i * D + j] = M[(size_t)i * D + j];
  return r;
}
static wcache_t *wcache_get(int n, const unsigned char *sp, const unsigned char *fw) {
  for (int i = 0; i < NWC; i++) { wcache_t *c = &WC[i]; if (c->n != n) continue; int ok = 1; for (int k = 0; k < n; k++) if (c->sp[k] != sp[k] || c->fw[k] != fw[k]) { ok = 0; break; } if (ok) { W_CACHE_HITS++; return c; } }
  if (NWC >= 8192) return NULL;
  wcache_t *c = &WC[NWC++]; c->n = n; for (int k = 0; k < n; k++) { c->sp[k] = sp[k]; c->fw[k] = fw[k]; }
  int D = 1, dk[WMAXINC]; for (int k = 0; k < n; k++) { dk[k] = sp[k] ? 3 : 2; D *= dk[k]; } c->Dm = D; W_CACHE_BUILDS++;
  size_t DD = (size_t)D * D;
  wu64 *M1 = malloc(sizeof(wu64) * DD), *M2 = malloc(sizeof(wu64) * DD), *C1 = malloc(sizeof(wu64) * DD), *C2 = malloc(sizeof(wu64) * DD); double *Md = malloc(sizeof(double) * DD);
  if (!M1 || !M2 || !C1 || !C2 || !Md) { c->r = -1; return c; }
  static int pe[800][4]; static long long pc[800]; static int qe[800][4]; static long long qc[800]; int td[WMAXINC], hd[WMAXINC];
  for (int t = 0; t < D; t++) { int rr = t; for (int k = n - 1; k >= 0; k--) { td[k] = rr % dk[k]; rr /= dk[k]; }
    for (int h = 0; h < D; h++) { rr = h; for (int k = n - 1; k >= 0; k--) { hd[k] = rr % dk[k]; rr /= dk[k]; }
      int np_ = 1; pe[0][0] = pe[0][1] = pe[0][2] = pe[0][3] = 0; pc[0] = 1;
      for (int k = 0; k < n && np_ > 0; k++) { int row = fw[k] ? td[k] : hd[k], col = fw[k] ? hd[k] : td[k]; const wmono_t *f = &WD[sp[k]][fw[k] ? 0 : 1][row][col];
        int nq = 0;
        for (int a = 0; a < np_; a++) for (int tt = 0; tt < f->n; tt++) { int e0 = pe[a][0] + f->e[tt][0], e1 = pe[a][1] + f->e[tt][1], e2 = pe[a][2] + f->e[tt][2], e3 = pe[a][3] + f->e[tt][3]; long long cc = pc[a] * f->c[tt];
          int z; for (z = 0; z < nq; z++) if (qe[z][0] == e0 && qe[z][1] == e1 && qe[z][2] == e2 && qe[z][3] == e3) break;
          if (z == nq) { qe[nq][0] = e0; qe[nq][1] = e1; qe[nq][2] = e2; qe[nq][3] = e3; qc[nq] = cc; nq++; } else qc[z] += cc; }
        np_ = 0; for (int z = 0; z < nq; z++) if (qc[z]) { pe[np_][0] = qe[z][0]; pe[np_][1] = qe[z][1]; pe[np_][2] = qe[z][2]; pe[np_][3] = qe[z][3]; pc[np_] = qc[z]; np_++; } }
      wu64 s1 = 0, s2 = 0; double sd = 0;
      for (int a = 0; a < np_; a++) { if (pe[a][0] != pe[a][1] || pe[a][2] != pe[a][3]) continue; int p = pe[a][0], q = pe[a][2];
        wu64 v1 = wmul(wmul(WF1[p], WF1[q], WP1), WFI1[p + q + 1], WP1), v2 = wmul(wmul(WF2[p], WF2[q], WP2), WFI2[p + q + 1], WP2);
        s1 = wadd(s1, wmul(v1, wfromll(pc[a], WP1), WP1), WP1); s2 = wadd(s2, wmul(v2, wfromll(pc[a], WP2), WP2), WP2); sd += (double)pc[a] * WFD[p] * WFD[q] / WFD[p + q + 1]; }
      M1[(size_t)t * D + h] = s1; M2[(size_t)t * D + h] = s2; Md[(size_t)t * D + h] = sd; } }
  memcpy(C1, M1, sizeof(wu64) * DD); memcpy(C2, M2, sizeof(wu64) * DD);
  int *piv1 = malloc(sizeof(int) * D), *piv2 = malloc(sizeof(int) * D); wu64 *R1 = malloc(sizeof(wu64) * DD), *R2 = malloc(sizeof(wu64) * DD);
  int r1 = wrref(C1, D, WP1, piv1, R1), r2 = wrref(C2, D, WP2, piv2, R2);
  int agree = (r1 == r2); for (int s = 0; s < r1 && agree; s++) if (piv1[s] != piv2[s]) agree = 0;
  if (!agree) { c->r = -1; free(M1); free(M2); free(C1); free(C2); free(Md); free(piv1); free(piv2); free(R1); free(R2); return c; }
  int r = r1; c->r = r;
  if (r > 0) {
    c->A1 = malloc(sizeof(wu64) * (size_t)D * r); c->A2 = malloc(sizeof(wu64) * (size_t)D * r); c->Ad = malloc(sizeof(double) * (size_t)D * r);
    c->B1 = malloc(sizeof(wu64) * (size_t)r * D); c->B2 = malloc(sizeof(wu64) * (size_t)r * D); c->Bd = malloc(sizeof(double) * (size_t)r * D);
    for (int t = 0; t < D; t++) for (int s = 0; s < r; s++) { c->A1[(size_t)t * r + s] = M1[(size_t)t * D + piv1[s]]; c->A2[(size_t)t * r + s] = M2[(size_t)t * D + piv1[s]]; c->Ad[(size_t)t * r + s] = Md[(size_t)t * D + piv1[s]]; }
    memcpy(c->B1, R1, sizeof(wu64) * (size_t)r * D); memcpy(c->B2, R2, sizeof(wu64) * (size_t)r * D);
    /* Bd by the normal equations on the pivot columns: (Ad^T Ad) Bd = Ad^T Md */
    double G[64][65]; double *rhs = malloc(sizeof(double) * (size_t)r * D);
    for (int s = 0; s < r; s++) for (int s2 = 0; s2 < r; s2++) { double g = 0; for (int t = 0; t < D; t++) g += c->Ad[(size_t)t * r + s] * c->Ad[(size_t)t * r + s2]; G[s][s2] = g; }
    for (int s = 0; s < r; s++) for (int h = 0; h < D; h++) { double g = 0; for (int t = 0; t < D; t++) g += c->Ad[(size_t)t * r + s] * Md[(size_t)t * D + h]; rhs[(size_t)s * D + h] = g; }
    /* Gauss-Jordan with partial pivoting on G, applied to rhs */
    for (int cc = 0; cc < r; cc++) { int pr = cc; for (int i = cc + 1; i < r; i++) if (fabs(G[i][cc]) > fabs(G[pr][cc])) pr = i;
      if (pr != cc) { for (int j = 0; j < r; j++) { double t = G[pr][j]; G[pr][j] = G[cc][j]; G[cc][j] = t; } for (int h = 0; h < D; h++) { double t = rhs[(size_t)pr * D + h]; rhs[(size_t)pr * D + h] = rhs[(size_t)cc * D + h]; rhs[(size_t)cc * D + h] = t; } }
      double iv = 1.0 / G[cc][cc]; for (int j = 0; j < r; j++) G[cc][j] *= iv; for (int h = 0; h < D; h++) rhs[(size_t)cc * D + h] *= iv;
      for (int i = 0; i < r; i++) { if (i == cc) continue; double f = G[i][cc]; if (f == 0) continue; for (int j = 0; j < r; j++) G[i][j] -= f * G[cc][j]; for (int h = 0; h < D; h++) rhs[(size_t)i * D + h] -= f * rhs[(size_t)cc * D + h]; } }
    memcpy(c->Bd, rhs, sizeof(double) * (size_t)r * D); free(rhs); }
  free(M1); free(M2); free(C1); free(C2); free(Md); free(piv1); free(piv2); free(R1); free(R2);
  return c;
}
/* the two tensors of link li under WSPIN: returns 1, or 2 when the link has no invariant (the integral is zero), or 0 on refusal */
static int wbuild_link(int li, wtens_t *A, wtens_t *B) {
  int inc_i[8], inc_q[8], m = 0;
  for (int i = 0; i < F_; i++) for (int q = 0; q < 4; q++) if (plk[i][q] == li && m < 8) { inc_i[m] = i; inc_q[m] = q; m++; }
  unsigned char sp[WMAXINC], fw[WMAXINC]; for (int k = 0; k < m; k++) { sp[k] = (unsigned char)WSPIN[inc_i[k]]; fw[k] = inc_q[k] < 2; }
  wcache_t *c = wcache_get(m, sp, fw); if (!c || c->r < 0) return 0; if (c->r == 0) return 2;
  int r = c->r, D = c->Dm;
  A->nb = m + 1; B->nb = m + 1;
  for (int k = 0; k < m; k++) { int i = inc_i[k], q = inc_q[k], d = sp[k] ? 3 : 2; int rowb = 4 * i + q, colb = 4 * i + ((q + 1) & 3);
    A->bond[k] = fw[k] ? rowb : colb; A->dim[k] = d; B->bond[1 + k] = fw[k] ? colb : rowb; B->dim[1 + k] = d; }
  A->bond[m] = WINVBASE + li; A->dim[m] = r; B->bond[0] = WINVBASE + li; B->dim[0] = r;
  A->size = (long long)D * r; B->size = (long long)r * D;
  if (!walloc(A)) return 0; if (!walloc(B)) { wfree(A); return 0; }
  memcpy(A->x1, c->A1, sizeof(wu64) * (size_t)D * r); memcpy(A->x2, c->A2, sizeof(wu64) * (size_t)D * r); memcpy(A->xd, c->Ad, sizeof(double) * (size_t)D * r);
  memcpy(B->x1, c->B1, sizeof(wu64) * (size_t)r * D); memcpy(B->x2, c->B2, sizeof(wu64) * (size_t)r * D); memcpy(B->xd, c->Bd, sizeof(double) * (size_t)r * D);
  return 1;
}
/* C = the contraction of A and B over their shared bonds; C's bonds: A's free bonds then B's */
static int wcontract(const wtens_t *A, const wtens_t *B, wtens_t *C) {
  int shA[WMAXB], shB[WMAXB], ns = 0, frA[WMAXB], nfa = 0, frB[WMAXB], nfb = 0;
  for (int i = 0; i < A->nb; i++) { int j; for (j = 0; j < B->nb; j++) if (B->bond[j] == A->bond[i]) break; if (j < B->nb) { shA[ns] = i; shB[ns] = j; ns++; } else frA[nfa++] = i; }
  for (int j = 0; j < B->nb; j++) { int i; for (i = 0; i < A->nb; i++) if (A->bond[i] == B->bond[j]) break; if (i == A->nb) frB[nfb++] = j; }
  if (nfa + nfb > WMAXB) return 0;
  long long sizeFA = 1, sizeFB = 1, sizeS = 1; for (int t = 0; t < nfa; t++) sizeFA *= A->dim[frA[t]]; for (int t = 0; t < nfb; t++) sizeFB *= B->dim[frB[t]]; for (int t = 0; t < ns; t++) sizeS *= A->dim[shA[t]];
  if (sizeFA * sizeFB > WCAP) return 0;
  C->nb = nfa + nfb; for (int t = 0; t < nfa; t++) { C->bond[t] = A->bond[frA[t]]; C->dim[t] = A->dim[frA[t]]; } for (int t = 0; t < nfb; t++) { C->bond[nfa + t] = B->bond[frB[t]]; C->dim[nfa + t] = B->dim[frB[t]]; }
  C->size = sizeFA * sizeFB; if (C->size > W_MAXSIZE) W_MAXSIZE = C->size; if (!walloc(C)) return 0;
  long long stA[WMAXB], stB[WMAXB]; { long long s = 1; for (int i = A->nb - 1; i >= 0; i--) { stA[i] = s; s *= A->dim[i]; } s = 1; for (int j = B->nb - 1; j >= 0; j--) { stB[j] = s; s *= B->dim[j]; } }
  long long *oAF = malloc(sizeof(long long) * (size_t)sizeFA), *oBF = malloc(sizeof(long long) * (size_t)sizeFB), *oAS = malloc(sizeof(long long) * (size_t)sizeS), *oBS = malloc(sizeof(long long) * (size_t)sizeS);
  if (!oAF || !oBF || !oAS || !oBS) { free(oAF); free(oBF); free(oAS); free(oBS); wfree(C); return 0; }
  for (long long i = 0; i < sizeFA; i++) { long long r = i, off = 0; for (int t = nfa - 1; t >= 0; t--) { int d = A->dim[frA[t]]; off += (r % d) * stA[frA[t]]; r /= d; } oAF[i] = off; }
  for (long long j = 0; j < sizeFB; j++) { long long r = j, off = 0; for (int t = nfb - 1; t >= 0; t--) { int d = B->dim[frB[t]]; off += (r % d) * stB[frB[t]]; r /= d; } oBF[j] = off; }
  for (long long s = 0; s < sizeS; s++) { long long r = s, oa = 0, ob = 0; for (int t = ns - 1; t >= 0; t--) { int d = A->dim[shA[t]]; long long dg = r % d; oa += dg * stA[shA[t]]; ob += dg * stB[shB[t]]; r /= d; } oAS[s] = oa; oBS[s] = ob; }
  for (long long i = 0; i < sizeFA; i++) for (long long s = 0; s < sizeS; s++) { long long ia = oAF[i] + oAS[s]; wu64 a1 = A->x1[ia], a2 = A->x2[ia]; double ad = A->xd[ia]; if (!a1 && !a2 && ad == 0) continue;
    long long cb = i * sizeFB; long long bo = oBS[s];
    for (long long j = 0; j < sizeFB; j++) { long long ib = bo + oBF[j]; wu64 b1 = B->x1[ib]; wu64 b2 = B->x2[ib]; double bd = B->xd[ib]; if (!b1 && !b2 && bd == 0) continue;
      C->x1[cb + j] = wadd(C->x1[cb + j], wmul(a1, b1, WP1), WP1); C->x2[cb + j] = wadd(C->x2[cb + j], wmul(a2, b2, WP2), WP2); C->xd[cb + j] += ad * bd; } }
  free(oAF); free(oBF); free(oAS); free(oBS);
  return 1;
}
/* the Haar integral of X under WSPIN: two tensors per link, contracted greedily; returns 0 if a tensor would exceed WCAP */
static int wnet_eval(wu64 *r1, wu64 *r2, double *rd) {
  static wtens_t T[8 * MAXF + 16]; int nt = 0; W_EVALS++;
  for (int li = 0; li < NLk; li++) { int rc = wbuild_link(li, &T[nt], &T[nt + 1]);
    if (rc == 0) { for (int z = 0; z < nt; z++) wfree(&T[z]); W_REFUSED++; return 0; }
    if (rc == 2) { for (int z = 0; z < nt; z++) wfree(&T[z]); W_ZERO_LINKS++; *r1 = 0; *r2 = 0; *rd = 0; return 1; }
    nt += 2; }
  while (nt > 1) {
    int ba = -1, bb = -1; long long bsz = -1, bkey = 0;
    for (int a = 0; a < nt; a++) for (int b = a + 1; b < nt; b++) { int sh = 0; long long fsz = 1;
        for (int i = 0; i < T[a].nb; i++) { int j; for (j = 0; j < T[b].nb; j++) if (T[b].bond[j] == T[a].bond[i]) break; if (j < T[b].nb) sh++; else fsz *= T[a].dim[i]; }
        if (!sh) continue;
        for (int j = 0; j < T[b].nb; j++) { int i; for (i = 0; i < T[a].nb; i++) if (T[a].bond[i] == T[b].bond[j]) break; if (i == T[a].nb) fsz *= T[b].dim[j]; }
        { long long key = (W_GREEDY == 1) ? fsz - T[a].size - T[b].size : fsz; if (ba < 0) { bkey = key; bsz = fsz; ba = a; bb = b; } else if (key < bkey || (key == bkey && fsz < bsz)) { bkey = key; bsz = fsz; ba = a; bb = b; } } }
    if (ba < 0) { ba = 0; bb = 1; }
    wtens_t Cn; if (!wcontract(&T[ba], &T[bb], &Cn)) { for (int z = 0; z < nt; z++) wfree(&T[z]); W_REFUSED++; return 0; }
    wfree(&T[ba]); wfree(&T[bb]); T[ba] = Cn; T[bb] = T[nt - 1]; nt--; }
  *r1 = T[0].x1[0]; *r2 = T[0].x2[0]; *rd = T[0].xd[0]; wfree(&T[0]);
  return 1;
}
/* Wang's rational reconstruction of the value with residues r1 (mod P1), r2 (mod P2); checked against the float */
static int wrational(wu64 r1, wu64 r2, double rd, long long *num, long long *den) {
  wi128 M = (wi128)WP1 * (wi128)WP2;
  wu64 t = wmul((r2 + WP2 - (r1 % WP2)) % WP2, winv(WP1 % WP2, WP2), WP2);
  wi128 R = (wi128)r1 + (wi128)WP1 * (wi128)t;
  wi128 a0 = M, a1 = R, t0 = 0, t1 = 1; const wi128 BND = (wi128)1 << 61;
  while (a1 >= BND) { wi128 q = a0 / a1, tmp = a0 - q * a1; a0 = a1; a1 = tmp; tmp = t0 - q * t1; t0 = t1; t1 = tmp; }
  wi128 n = a1, d = t1; if (d < 0) { n = -n; d = -d; }
  if (d == 0 || d >= BND) return 0;
  /* n = r d modulo each prime (R d itself would overflow 128 bits) */
  { wi128 n1 = n % (wi128)WP1; if (n1 < 0) n1 += WP1; wi128 n2 = n % (wi128)WP2; if (n2 < 0) n2 += WP2;
    if ((wu64)n1 != wmul(r1, (wu64)(d % (wi128)WP1), WP1) || (wu64)n2 != wmul(r2, (wu64)(d % (wi128)WP2), WP2)) return 0; }
  double v = (double)n / (double)d; if (fabs(v - rd) > 1e-9 + 1e-7 * fabs(rd)) { printf("G50-FLOAT-DISAGREES %.17g against %lld/%lld\n", rd, (long long)n, (long long)d); return 0; }
  *num = (long long)n; *den = (long long)d; return 1;
}
static long long wgcd(long long a, long long b) { if (a < 0) a = -a; while (b) { long long t = a % b; a = b; b = t; } return a; }
/* the F2 kernel of S -> boundary(S) on the plaquettes of X: a basis of the even subsets (bit i = plaquette i) */
static int wkernel(wmask *kb) {
  unsigned long long V[MAXF + 4][2]; wmask Cm[MAXF + 4]; int pb[MAXF + 4], npv = 0, nk = 0;
  for (int i = 0; i < F_; i++) { unsigned long long v0 = 0, v1 = 0; for (int q = 0; q < 4; q++) { int li = plk[i][q]; if (li < 64) v0 ^= 1ULL << li; else v1 ^= 1ULL << (li - 64); } wmask c = 1ull << i;
    for (int r = 0; r < npv; r++) { int b = pb[r]; int bit = b < 64 ? (int)((v0 >> b) & 1) : (int)((v1 >> (b - 64)) & 1); if (bit) { v0 ^= V[r][0]; v1 ^= V[r][1]; c ^= Cm[r]; } }
    if (!v0 && !v1) { kb[nk++] = c; continue; }
    int b = v0 ? __builtin_ctzll(v0) : 64 + __builtin_ctzll(v1); V[npv][0] = v0; V[npv][1] = v1; Cm[npv] = c; pb[npv] = b; npv++; }
  return nk;
}
/* the rest R (a mask) when branch-free: components, chi = vertex cycles - plaquettes, orientable */
static int wrest_shape(wmask Rm, int *ncomp, int *chi, int *orient) {
  int F = F_; int mR[4 * MAXF + 8]; for (int li = 0; li < NLk; li++) mR[li] = 0;
  for (int i = 0; i < F; i++) if (Rm >> i & 1u) for (int q = 0; q < 4; q++) mR[plk[i][q]]++;
  for (int li = 0; li < NLk; li++) if (mR[li] != 0 && mR[li] != 2) return 0;
  int uf[MAXF + 4]; for (int i = 0; i < F; i++) uf[i] = i;
  int cu[4 * MAXF + 16]; for (int z = 0; z < 4 * F; z++) cu[z] = z;
  int ori[MAXF + 4]; for (int i = 0; i < F; i++) ori[i] = 0; int ok = 1;
  for (int li = 0; li < NLk; li++) { if (mR[li] != 2) continue; int pi[2], pq[2], k = 0;
    for (int i = 0; i < F && k < 2; i++) if (Rm >> i & 1u) for (int q = 0; q < 4; q++) if (plk[i][q] == li) { pi[k] = i; pq[k] = q; k++; }
    { int x = find_(uf, pi[0]), y = find_(uf, pi[1]); if (x != y) uf[y] = x; }
    /* the two corners of each plaquette on the link, at the link's endpoints */
    long long l = lk[li]; long long t0 = l / D; int dd = (int)(l % D); long long t1 = t0 + stride[dd];
    for (int e = 0; e < 2; e++) { long long vtx = e ? t1 : t0; int cn[2];
      for (int s = 0; s < 2; s++) { int i = pi[s], q = pq[s]; long long p = Pl[i]; long long sb = p / NPD; int kk = (int)(p % NPD), a = PAIRA[kk], b = PAIRB[kk];
        long long cv[4] = { sb, sb + stride[a], sb + stride[a] + stride[b], sb + stride[b] };
        int c1 = q, c2 = (q + 1) & 3; cn[s] = (cv[c1] == vtx) ? 4 * i + c1 : 4 * i + c2; }
      int x = find_(cu, cn[0]), y = find_(cu, cn[1]); if (x != y) cu[y] = x; } }
  int nc = 0, V = 0, nR = 0; for (int i = 0; i < F; i++) if (Rm >> i & 1u) { nR++; if (find_(uf, i) == i) nc++; for (int c = 0; c < 4; c++) if (find_(cu, 4 * i + c) == 4 * i + c) V++; }
  /* orientation: plaquette i traverses its link q forward iff q < 2; consistent iff the two plaquettes at every link traverse it oppositely */
  for (int i0 = 0; i0 < F; i0++) { if (!(Rm >> i0 & 1u) || ori[i0]) continue; ori[i0] = 1; int qu[MAXF + 4], h = 0, tl = 0; qu[tl++] = i0;
    while (h < tl) { int i = qu[h++]; for (int q = 0; q < 4; q++) { int li = plk[i][q]; for (int j = 0; j < F; j++) { if (j == i || !(Rm >> j & 1u)) continue; for (int r = 0; r < 4; r++) if (plk[j][r] == li) {
            int si = (q < 2) ? 1 : -1, sj = (r < 2) ? 1 : -1; int want = -ori[i] * si * sj; if (!ori[j]) { ori[j] = want; qu[tl++] = j; } else if (ori[j] != want) ok = 0; } } } } }
  *ncomp = nc; *chi = V - nR; *orient = ok; return 1;
}
typedef struct { int F, odd, h2, h3, h4, h5, ny, nlead, rbf, rcomp, rchi, rori, y2, y3, yv, npatch, lone, ncross, ntouch, lawok; long long num, den, rn, rd, n; char pdesc[160]; } wtab_t; static wtab_t WT[8192]; static int NWT;
static void wtab_add(int F, int odd, const int *h, int ny, int nlead, int rbf, int rcomp, int rchi, int rori, int y2, int y3, int yv, int npatch, int lone, int ncross, int ntouch, int lawok, long long rn, long long rd, long long num, long long den, const char *pdesc) {
  for (int i = 0; i < NWT; i++) { wtab_t *e = &WT[i]; if (e->F == F && e->odd == odd && e->h2 == h[2] && e->h3 == h[3] && e->h4 == h[4] && e->h5 == h[5] && e->ny == ny && e->nlead == nlead && e->rbf == rbf && e->rcomp == rcomp && e->rchi == rchi && e->rori == rori && e->y2 == y2 && e->y3 == y3 && e->yv == yv && e->npatch == npatch && e->lone == lone && e->ncross == ncross && e->ntouch == ntouch && e->lawok == lawok && !strcmp(e->pdesc, pdesc) && e->rn == rn && e->rd == rd && e->num == num && e->den == den) { e->n++; return; } }
  if (NWT < 8192) { wtab_t *e = &WT[NWT++]; e->F = F; e->odd = odd; e->h2 = h[2]; e->h3 = h[3]; e->h4 = h[4]; e->h5 = h[5]; e->ny = ny; e->nlead = nlead; e->rbf = rbf; e->rcomp = rcomp; e->rchi = rchi; e->rori = rori; e->y2 = y2; e->y3 = y3; e->yv = yv; e->npatch = npatch; e->lone = lone; e->ncross = ncross; e->ntouch = ntouch; e->lawok = lawok; strncpy(e->pdesc, pdesc, 159); e->pdesc[159] = 0; e->rn = rn; e->rd = rd; e->num = num; e->den = den; e->n = 1; }
}
typedef struct { int F; char s[400]; long long n; } wfull_t; static wfull_t WFU[4096]; static int NWFU;
static void wfull_add(int F, const char *s) { for (int i = 0; i < NWFU; i++) if (WFU[i].F == F && !strcmp(WFU[i].s, s)) { WFU[i].n++; return; } if (NWFU < 4096) { WFU[NWFU].F = F; strncpy(WFU[NWFU].s, s, 399); WFU[NWFU].s[399] = 0; WFU[NWFU].n = 1; NWFU++; } }
static long long WKAT_OK[MAXF + 1], WKAT_BAD[MAXF + 1], WKAT_N[MAXF + 1]; static int W_KATMAX = 16, W_MAX = 26;
static long long W_S1_N, W_S1_FOUR, W_S1_OVER, W_S1_OTHER; static double W_S1_MAX; static long long W_VL_N, W_VL_OK, W_VL_BAD, W_VL_TOUCH;
/* the patches of the leading Y (components through off-rest links), each as (n, off-rest link multiplicities descending, chi of the 2-complex) */
static int cmpint_desc(const void *x, const void *y) { int a = *(const int *)x, b = *(const int *)y; return a < b ? 1 : a > b ? -1 : 0; }
static void patch_desc(wmask Rm, char *out, int outsz) {
  int F = F_; int mR[4 * MAXF + 8], mY[4 * MAXF + 8]; for (int li = 0; li < NLk; li++) { mR[li] = 0; mY[li] = 0; }
  for (int i = 0; i < F; i++) for (int q = 0; q < 4; q++) { if (Rm >> i & 1u) mR[plk[i][q]]++; else mY[plk[i][q]]++; }
  int uf[MAXF + 4]; for (int i = 0; i < F; i++) uf[i] = i;
  for (int i = 0; i < F; i++) { if (Rm >> i & 1u) continue; for (int j = i + 1; j < F; j++) { if (Rm >> j & 1u) continue; int sh = 0; for (int q = 0; q < 4 && !sh; q++) for (int r = 0; r < 4; r++) if (plk[i][q] == plk[j][r] && mR[plk[i][q]] == 0) { sh = 1; break; } if (sh) { int a = find_(uf, i), b = find_(uf, j); if (a != b) uf[b] = a; } } }
  char descs[MAXF + 4][48]; int nd = 0;
  for (int root = 0; root < F; root++) { if (Rm >> root & 1u) continue; if (find_(uf, root) != root) continue;
    int n = 0; int lk_in[4 * MAXF + 8]; for (int li = 0; li < NLk; li++) lk_in[li] = 0; long long vs[4 * MAXF + 8]; int nv = 0; int mults[4 * MAXF + 8], nm = 0;
    for (int i = 0; i < F; i++) { if (Rm >> i & 1u) continue; if (find_(uf, i) != root) continue; n++;
      for (int q = 0; q < 4; q++) lk_in[plk[i][q]] = 1;
      long long p = Pl[i]; long long sb = p / NPD; int kk = (int)(p % NPD), a = PAIRA[kk], b = PAIRB[kk]; long long cs[4] = { sb, sb + stride[a], sb + stride[a] + stride[b], sb + stride[b] };
      for (int c = 0; c < 4; c++) { int f = 0; for (int z = 0; z < nv; z++) if (vs[z] == cs[c]) { f = 1; break; } if (!f) vs[nv++] = cs[c]; } }
    int E = 0; for (int li = 0; li < NLk; li++) if (lk_in[li]) { E++; if (mR[li] == 0) { int m = 0; for (int i = 0; i < F; i++) { if (Rm >> i & 1u) continue; if (find_(uf, i) != root) continue; for (int q = 0; q < 4; q++) if (plk[i][q] == li) m++; } mults[nm++] = m; } }
    qsort(mults, nm, sizeof(int), cmpint_desc); int chi = nv - E + n;
    int off = snprintf(descs[nd], 48, "(n%d", n); if (nm) { off += snprintf(descs[nd] + off, 48 - off, " off"); for (int t = 0; t < nm && off < 40; t++) off += snprintf(descs[nd] + off, 48 - off, "%s%d", t ? "," : "", mults[t]); } snprintf(descs[nd] + off, 48 - off, " chi%d)", chi); nd++; }
  /* sort the descriptors so equal multisets print equal */
  for (int i = 1; i < nd; i++) { char t[48]; strcpy(t, descs[i]); int j = i - 1; while (j >= 0 && strcmp(descs[j], t) > 0) { strcpy(descs[j + 1], descs[j]); j--; } strcpy(descs[j + 1], t); }
  int off = 0; out[0] = 0; for (int i = 0; i < nd && off < outsz - 50; i++) off += snprintf(out + off, outsz - off, "%s%s", i ? " " : "", descs[i]);
}
/* the vertex cycle of the rest at a lattice vertex v: the spokes (links of R at v) in cyclic order, by walking the plaquettes of R around v; then for two walls through v (each using two spokes) ALTERNATION = crossing */
static int vertex_law(wmask Rm, int *ncross, int *ntouch, long long irn, long long ird) {
  int F = F_; *ncross = 0; *ntouch = 0;
  int wall[MAXF + 4], nw = 0; for (int i = 0; i < F; i++) if (!(Rm >> i & 1u)) wall[nw++] = i;
  for (int a = 0; a < nw; a++) for (int b = a + 1; b < nw; b++) { int i = wall[a], j = wall[b];
    long long ci[4], cj[4]; { long long p = Pl[i]; long long sb = p / NPD; int kk = (int)(p % NPD), x = PAIRA[kk], y = PAIRB[kk]; ci[0] = sb; ci[1] = sb + stride[x]; ci[2] = sb + stride[x] + stride[y]; ci[3] = sb + stride[y]; }
    { long long p = Pl[j]; long long sb = p / NPD; int kk = (int)(p % NPD), x = PAIRA[kk], y = PAIRB[kk]; cj[0] = sb; cj[1] = sb + stride[x]; cj[2] = sb + stride[x] + stride[y]; cj[3] = sb + stride[y]; }
    for (int x = 0; x < 4; x++) for (int y = 0; y < 4; y++) { if (ci[x] != cj[y]) continue; long long v = ci[x];
      /* the two spokes of wall i at corner x: corner c sits between the plaquette links c-1 and c (plk index (c+3)&3 and c) */
      int si0 = plk[i][(x + 3) & 3], si1 = plk[i][x], sj0 = plk[j][(y + 3) & 3], sj1 = plk[j][y];
      /* the spokes of R at v and the plaquettes of R at v */
      int sp[16], nsp = 0; int rp[16], rpl[16][2], nrp = 0;
      for (int k = 0; k < F; k++) { if (!(Rm >> k & 1u)) continue; long long p = Pl[k]; long long sb = p / NPD; int kk = (int)(p % NPD), xx = PAIRA[kk], yy = PAIRB[kk]; long long cs[4] = { sb, sb + stride[xx], sb + stride[xx] + stride[yy], sb + stride[yy] };
        for (int c = 0; c < 4; c++) if (cs[c] == v && nrp < 16) { rp[nrp] = k; rpl[nrp][0] = plk[k][(c + 3) & 3]; rpl[nrp][1] = plk[k][c]; nrp++; } }
      for (int t = 0; t < nrp; t++) for (int e = 0; e < 2; e++) { int l = rpl[t][e]; int f = 0; for (int z = 0; z < nsp; z++) if (sp[z] == l) f = 1; if (!f && nsp < 16) sp[nsp++] = l; }
      /* walk the cycle: start at spoke sp[0], step through the plaquette not yet used */
      int order[16], no = 0, used[16]; for (int t = 0; t < nrp; t++) used[t] = 0; int cur = sp[0]; order[no++] = cur;
      for (int step = 0; step < nsp; step++) { int nxt = -1; for (int t = 0; t < nrp && nxt < 0; t++) { if (used[t]) continue; if (rpl[t][0] == cur) { used[t] = 1; nxt = rpl[t][1]; } else if (rpl[t][1] == cur) { used[t] = 1; nxt = rpl[t][0]; } } if (nxt < 0 || nxt == sp[0]) break; order[no++] = nxt; cur = nxt; }
      if (no != nsp) { return 3; }   /* not a single cycle: the rest is not a surface at v */
      int pos[4] = { -1, -1, -1, -1 }; int sk[4] = { si0, si1, sj0, sj1 }; for (int t = 0; t < 4; t++) for (int z = 0; z < no; z++) if (order[z] == sk[t]) pos[t] = z;
      if (pos[0] < 0 || pos[1] < 0 || pos[2] < 0 || pos[3] < 0) return 3;
      /* alternation: walking the cycle from si0 to si1 one way, exactly one of sj0, sj1 lies strictly between */
      int lo = pos[0], hi = pos[1]; if (lo > hi) { int t = lo; lo = hi; hi = t; } int inside = 0; if (pos[2] > lo && pos[2] < hi) inside++; if (pos[3] > lo && pos[3] < hi) inside++;
      if (inside == 1) (*ncross)++; else (*ntouch)++; } }
  /* the law: r = (-1/3)^crossings; touchings counted apart */
  long long pn = 1, pd = 1; for (int k = 0; k < *ncross; k++) { pn *= -1; pd *= 3; }
  int ok = (irn * pd == pn * ird); W_VL_N++; if (ok) W_VL_OK++; else W_VL_BAD++; if (*ntouch) W_VL_TOUCH++; return ok;
} static long long W_S8_N, W_S8_OVER, W_S8_LONE, W_S8_LONEOVER;
/* ---- inlined from g50_vertex_add.c ---- */
/* ---- THE VERTEX-FACTOR CENSUS (2026-10-29 13:5x EDT, the author; RESULTS 16.70, staked before this file existed; a MODE of the
 * consolidated g50_weights.c, env W_VERTEX=1): when every link of a configuration factors at rank 1, the half-tensors are grouped by the
 * lattice vertex their corner bonds sit at (A_l at the tail of l, B_l at its head), each group is contracted to a scalar f_v, the product of
 * the f_v is checked against the global contraction (a known answer inside the mode), and f_v is tallied by the vertex's TYPE: the labelled
 * graph at v whose nodes are the spokes (the links of the configuration at v, each labelled by its content (m_half, m_one)) and whose edges
 * are the plaquettes at v (each labelled by its spin), canonicalised by two rounds of neighbourhood refinement.  The raw f_v depends on the
 * rank-one split P = P[:,S] R, which is the same for every link of one content and orientation pattern, so ratios between types with the
 * same multiset of link types are convention-free (the crossing's -1/3); the raw values are printed as they are.
 * A type printing two factors is a CONFLICT line: the type string too coarse, never the locality (16.70). */
typedef struct { char type[400]; long long num, den; long long n; int conflict; } wvt_t; static wvt_t WVT[20000]; static int NWVT;
static long long W_V_CONF, W_V_PRODOK, W_V_PRODBAD, W_V_NOTRANK1, W_V_VERTS; static int W_VERTEX = 0; static int W_PRED = 0; static long long W_PRED_N = 0, W_PRED_SEEN = 0; static int W_LISTASSIGN = 0; static int W_LOCAL = 0;   /* W_PRED=1: the author's predicate (b), 16:3x */ static const char *W_LISTPROF = NULL; static int W_ZMIN = 0;   /* W_ZMIN=1: weigh only the Z2-minimal contact leaves (15:5x, the S12 known answer at 22) */
static int wvt_cmpstr(const void *a, const void *b) { return strcmp(*(char * const *)a, *(char * const *)b); }
static void wvt_add(const char *type, long long num, long long den) {
  for (int i = 0; i < NWVT; i++) if (!strcmp(WVT[i].type, type)) { if (WVT[i].num != num || WVT[i].den != den) { if (!WVT[i].conflict) { WVT[i].conflict = 1; W_V_CONF++; printf("G50-VERTEX-CONFLICT type %s: factor %lld/%lld and %lld/%lld\n", type, WVT[i].num, WVT[i].den, num, den); } } WVT[i].n++; return; }
  if (NWVT < 20000) { strncpy(WVT[NWVT].type, type, 399); WVT[NWVT].type[399] = 0; WVT[NWVT].num = num; WVT[NWVT].den = den; WVT[NWVT].n = 1; WVT[NWVT].conflict = 0; NWVT++; }
}
/* the type string of vertex v: spokes = links at v with content; edges = plaquettes at v with spin */
static void wvt_type(long long v, char *out, int outsz) {
  int F = F_; int sp[24], nsp = 0; int e_a[24], e_b[24], e_s[24], ne = 0;
  for (int i = 0; i < F; i++) { long long p = Pl[i]; long long sb = p / NPD; int kk = (int)(p % NPD), a = PAIRA[kk], b = PAIRB[kk]; long long cs[4] = { sb, sb + stride[a], sb + stride[a] + stride[b], sb + stride[b] };
    for (int c = 0; c < 4; c++) { if (cs[c] != v) continue; int la = plk[i][(c + 3) & 3], lb = plk[i][c]; int ia = -1, ib = -1;
      for (int z = 0; z < nsp; z++) { if (sp[z] == la) ia = z; if (sp[z] == lb) ib = z; }
      if (ia < 0 && nsp < 24) { sp[nsp] = la; ia = nsp++; } if (ib < 0 && nsp < 24) { sp[nsp] = lb; ib = nsp++; }
      /* the plaquette's SLOT at each spoke (its index among the plaquettes at that link, census order) fixes which entries of the link's
         half-tensor it meets: part of the type, since the rank-one gauge is written in those slots */
      int sa = 0, sb = 0; for (int i2 = 0; i2 < i; i2++) for (int q2 = 0; q2 < 4; q2++) { if (plk[i2][q2] == la) sa++; if (plk[i2][q2] == lb) sb++; }
      if (ne < 24) { e_a[ne] = ia; e_b[ne] = ib; e_s[ne] = 100 * WSPIN[i] + 10 * sa + sb; ne++; } } }
  /* the label of a spoke is its link's CACHE KEY -- the ordered list of (spin, forward/backward) of the plaquettes at it, in census order --
     because the rank-one split P = P[:,S] R is one gauge per key, and a vertex factor is a function of the type only in a fixed gauge
     (the first smoke test, 13:5x, read two factors per type with the bare content (m_half, m_one) as the label: the gauge was the difference) */
  char lab[24][120], nlab[24][120];
  for (int z = 0; z < nsp; z++) { int mh = 0, mo = 0; char key[40] = ""; int ko = 0;
    for (int i = 0; i < F; i++) for (int q = 0; q < 4; q++) if (plk[i][q] == sp[z]) { if (WSPIN[i]) mo++; else mh++; if (ko < 36) ko += snprintf(key + ko, 40 - ko, "%d%c", WSPIN[i] ? 1 : 0, q < 2 ? 'f' : 'b'); }
    snprintf(lab[z], 120, "c%d%d.%s", mh, mo, key); }
  for (int round = 0; round < 2; round++) {
    for (int z = 0; z < nsp; z++) { char *items[24]; char buf[24][130]; int ni = 0;
      for (int e = 0; e < ne; e++) { int o = -1; if (e_a[e] == z) o = e_b[e]; else if (e_b[e] == z) o = e_a[e]; if (o < 0) continue; snprintf(buf[ni], 130, "%d%s", e_s[e], lab[o]); items[ni] = buf[ni]; ni++; }
      qsort(items, ni, sizeof(char *), wvt_cmpstr);
      int off = snprintf(nlab[z], 120, "%s[", lab[z]); for (int t = 0; t < ni && off < 110; t++) off += snprintf(nlab[z] + off, 120 - off, "%s%s", t ? "," : "", items[t]); snprintf(nlab[z] + off, 120 - off, "]"); }
    for (int z = 0; z < nsp; z++) { /* compress the label to a short hash to keep strings bounded */
      unsigned long long h = 1469598103934665603ULL; for (const char *c = nlab[z]; *c; c++) { h ^= (unsigned char)*c; h *= 1099511628211ULL; } snprintf(lab[z], 120, "%c%d%d_%08llx", 'L', 0, 0, (unsigned long long)(h & 0xffffffffULL));
      /* keep the content prefix readable: recompute */
      int mh = 0, mo = 0; for (int i = 0; i < F; i++) for (int q = 0; q < 4; q++) if (plk[i][q] == sp[z]) { if (WSPIN[i]) mo++; else mh++; } snprintf(lab[z], 120, "c%d%d_%08llx", mh, mo, (unsigned long long)(h & 0xffffffffULL)); } }
  char *items[24]; for (int z = 0; z < nsp; z++) items[z] = lab[z]; qsort(items, nsp, sizeof(char *), wvt_cmpstr);
  int off = snprintf(out, outsz, "s%d:e%d:", nsp, ne); for (int z = 0; z < nsp && off < outsz - 20; z++) off += snprintf(out + off, outsz - off, "%s%s", z ? " " : "", items[z]);
}
/* the census of one configuration (WSPIN set): returns 1 if every link is rank 1 and the product check passed */
static int wvertex_census(wu64 g1, wu64 g2, double gd) {
  static wtens_t T[8 * MAXF + 16]; static long long tv[8 * MAXF + 16]; int nt = 0;
  for (int li = 0; li < NLk; li++) { int rc = wbuild_link(li, &T[nt], &T[nt + 1]); if (rc != 1) { for (int z = 0; z < nt; z++) wfree(&T[z]); return 0; }
    if (T[nt].dim[T[nt].nb - 1] != 1) { for (int z = 0; z < nt + 2; z++) wfree(&T[z]); W_V_NOTRANK1++; return 0; }
    long long l = lk[li]; long long s0 = l / D; int d = (int)(l % D); tv[nt] = s0; tv[nt + 1] = s0 + stride[d]; nt += 2; }
  /* distinct vertices */
  long long vs[8 * MAXF + 16]; int nv = 0; for (int t = 0; t < nt; t++) { int f = 0; for (int z = 0; z < nv; z++) if (vs[z] == tv[t]) { f = 1; break; } if (!f) vs[nv++] = tv[t]; }
  wu64 p1 = 1, p2 = 1; double pd = 1; int ok = 1; int consumed[8 * MAXF + 16]; for (int t = 0; t < nt; t++) consumed[t] = 0;
  for (int z = 0; z < nv && ok; z++) { long long v = vs[z]; wtens_t G[64]; int ng = 0;
    for (int t = 0; t < nt; t++) if (tv[t] == v && ng < 64) { G[ng++] = T[t]; consumed[t] = 1; }
    while (ng > 1) { int ba = -1, bb = -1; long long bsz = -1;
      for (int a = 0; a < ng; a++) for (int b = a + 1; b < ng; b++) { int sh = 0; long long fsz = 1;
          for (int i = 0; i < G[a].nb; i++) { int j; for (j = 0; j < G[b].nb; j++) if (G[b].bond[j] == G[a].bond[i]) break; if (j < G[b].nb) sh++; else fsz *= G[a].dim[i]; }
          if (!sh) continue; for (int j = 0; j < G[b].nb; j++) { int i; for (i = 0; i < G[a].nb; i++) if (G[a].bond[i] == G[b].bond[j]) break; if (i == G[a].nb) fsz *= G[b].dim[j]; }
          if (bsz < 0 || fsz < bsz) { bsz = fsz; ba = a; bb = b; } }
      if (ba < 0) { ba = 0; bb = 1; }
      wtens_t Cn; if (!wcontract(&G[ba], &G[bb], &Cn)) { ok = 0; break; }
      wfree(&G[ba]); wfree(&G[bb]); G[ba] = Cn; G[bb] = G[ng - 1]; ng--; }
    if (!ok) break;
    /* the remaining bonds are inv bonds of dimension 1: the tensor is a scalar */
    long long fsz = 1; for (int i = 0; i < G[0].nb; i++) fsz *= G[0].dim[i]; if (fsz != 1) { ok = 0; wfree(&G[0]); break; }
    wu64 f1 = G[0].x1[0], f2 = G[0].x2[0]; double fd = G[0].xd[0]; wfree(&G[0]);
    p1 = wmul(p1, f1, WP1); p2 = wmul(p2, f2, WP2); pd *= fd;
    long long num, den; char type[400]; wvt_type(v, type, sizeof type);
    if (wrational(f1, f2, fd, &num, &den)) wvt_add(type, num, den); else wvt_add(type, 0, 0);
    W_V_VERTS++; }
  if (!ok) { for (int t = 0; t < nt; t++) if (!consumed[t]) wfree(&T[t]); return 0; }   /* a refusal frees what no group took; a group's tensors were freed as it contracted */
  if (p1 == g1 && p2 == g2) W_V_PRODOK++; else { W_V_PRODBAD++; printf("G50-VERTEX-PRODUCT-BAD: the vertex product disagrees with the global contraction\n"); }
  return 1;
}
static void wvertex_print(void) {
  if (!W_VERTEX) return;
  printf("G50-VERTEX-CENSUS configurations with every link at rank 1: product = global %lld, disagreeing %lld; configurations with a higher-rank link %lld; vertices read %lld; types %d, conflicts %lld\n", W_V_PRODOK, W_V_PRODBAD, W_V_NOTRANK1, W_V_VERTS, NWVT, W_V_CONF);
  for (int i = 0; i < NWVT; i++) printf("G50-VERTEX type %s: factor %lld/%lld: %lld vertices%s\n", WVT[i].type, WVT[i].num, WVT[i].den, WVT[i].n, WVT[i].conflict ? " CONFLICT" : "");
}

static int wvalue(wmask Rm, long long *num, long long *den, wu64 *o1, wu64 *o2, double *od) {
  for (int i = 0; i < F_; i++) WSPIN[i] = (Rm >> i & 1u) ? 0 : 1;
  wu64 r1, r2; double rd; if (!wnet_eval(&r1, &r2, &rd)) return 0;
  if (W_VERTEX) wvertex_census(r1, r2, rd);
  *o1 = r1; *o2 = r2; *od = rd; return wrational(r1, r2, rd, num, den);
}
/* the branch-free surfaces: the known answer rho = 2^F I = 2^chi */
static void weigh_surface(void) {
  int F = F_; if (F > W_KATMAX) return;
  wmask all = (F >= 64) ? ~0ull : ((1ull << F) - 1ull); long long num, den; wu64 r1, r2; double rd;
  int nc, chi, ori; WKAT_N[F]++;
  if (!wrest_shape(all, &nc, &chi, &ori)) { WKAT_BAD[F]++; return; }
  if (!wvalue(all, &num, &den, &r1, &r2, &rd)) { WKAT_BAD[F]++; return; }
  /* rho = 2^F num/den against 2^chi */
  long double rho = (long double)num / (long double)den; for (int k = 0; k < F; k++) rho *= 2;
  long double want = 1; if (chi >= 0) for (int k = 0; k < chi; k++) want *= 2; else for (int k = 0; k < -chi; k++) want /= 2;
  if (fabsl(rho - want) < 1e-9L * want || fabsl(rho + want) < 1e-9L * want) WKAT_OK[F]++; else { WKAT_BAD[F]++; printf("G50-KAT-MISS F=%d surface chi %d orientable %d: rho %.12Lg, want %.12Lg\n", F, chi, ori, rho, want); }
  long long rn = num, rdn = den; for (int k = 0; k < F; k++) { if (rdn % 2 == 0) rdn /= 2; else rn *= 2; } long long g = wgcd(rn, rdn); if (g > 1) { rn /= g; rdn /= g; }
  int h[8] = {0}; h[2] = 2 * F; wtab_add(F, 2, h, 0, 1, 1, nc, chi, ori, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1, rn, rdn, "");
}
static void weigh_polymer(int odd, const int *hist) {
  int F = F_; if (F > W_MAX) return;
  wmask kb[MAXF + 4]; int nk = wkernel(kb);
  int maxR = -1; int nlead = 0; wmask leadR = 0;
  /* every even R: the full sum by |R|, and the leading (largest) R */
  wu64 C1[MAXF + 2], C2[MAXF + 2]; double CD[MAXF + 2]; int have[MAXF + 2]; for (int k = 0; k <= F; k++) { C1[k] = C2[k] = 0; CD[k] = 0; have[k] = 0; }
  /* the leading (largest) even R first: the reading must not depend on the subleading assignments, whose spin-1 networks are larger */
  int miss[MAXF + 2]; for (int k = 0; k <= F; k++) miss[k] = 0;
  for (unsigned int cmb = 0; cmb < (1u << nk); cmb++) { wmask Rm = 0; for (int t = 0; t < nk; t++) if (cmb >> t & 1u) Rm ^= kb[t];
    int sz = __builtin_popcountll(Rm); if (sz > maxR) { maxR = sz; nlead = 1; leadR = Rm; } else if (sz == maxR) nlead++; }
  int predhit = 0;
  if (W_PRED) {   /* the predicate on the leading rest S = leadR and Y = its complement: some Y-plaquette has an S-link with m_S = 2, m_Y = 2 and an off-S link with m_S = 0, m_Y >= 3 */
    if (!odd || nlead != 1) return; W_PRED_SEEN++;
    int mS[4 * MAXF + 8], mYp[4 * MAXF + 8]; for (int li = 0; li < NLk; li++) { mS[li] = 0; mYp[li] = 0; }
    for (int i = 0; i < F; i++) for (int q = 0; q < 4; q++) { if (leadR >> i & 1u) mS[plk[i][q]]++; else mYp[plk[i][q]]++; }
    for (int i = 0; i < F && !predhit; i++) { if (leadR >> i & 1u) continue; int hasA = 0, hasB = 0;
      for (int q = 0; q < 4; q++) { int li = plk[i][q]; if (mS[li] == 2 && mYp[li] == 2) hasA = 1; if (mS[li] == 0 && mYp[li] >= 3) hasB = 1; }
      if (hasA && hasB) predhit = 1; }
    if (!predhit) return; W_PRED_N++; }
  for (int pass = 0; pass < 2; pass++)
  for (unsigned int cmb = 0; cmb < (1u << nk); cmb++) { wmask Rm = 0; for (int t = 0; t < nk; t++) if (cmb >> t & 1u) Rm ^= kb[t];
    int sz = __builtin_popcountll(Rm); if ((pass == 0) != (sz == maxR)) continue;
    long long num, den; wu64 r1, r2; double rd; if (!wvalue(Rm, &num, &den, &r1, &r2, &rd)) { miss[sz] = 1; continue; }
    if (W_LISTASSIGN && pass == 0) {   /* one leading assignment: rho_assign = value * 2^|R| (the engine sums exactly these into rho) */
      long long an = num, ad = den; int s2 = sz; while (s2 > 0 && ad % 2 == 0) { ad /= 2; s2--; }
      printf("G50-ASSIGN F=%d |R|=%d |Y|=%d value=%lld/%lld (%.9e) rho_assign=", F, sz, F - sz, num, den, rd);
      if (an == 0) printf("0"); else if (s2 <= 62 && (an < 0 ? -an : an) <= (1LL << (62 - s2))) printf("%lld/%lld", an * (1LL << s2), ad); else printf("%lld*2^%d/%lld", an, s2, ad);
      printf(" (%.9e); Y:", ldexp(rd, sz));
      long long c0[MAXD]; { long long s0 = Pl[0] / NPD; for (int d = 0; d < D; d++) c0[d] = (s0 / stride[d]) % B; }
      for (int i = 0; i < F; i++) { if (Rm >> i & 1u) continue; long long s0 = Pl[i] / NPD; int k = (int)(Pl[i] % NPD); printf(" ("); for (int d = 0; d < D; d++) printf(d ? ",%lld" : "%lld", (s0 / stride[d]) % B - c0[d]); printf(")%d%d", PAIRA[k] + 1, PAIRB[k] + 1); }
      printf("\n"); }
    wu64 p1 = wpow(2, (wu64)sz, WP1), p2 = wpow(2, (wu64)sz, WP2); C1[sz] = wadd(C1[sz], wmul(r1, p1, WP1), WP1); C2[sz] = wadd(C2[sz], wmul(r2, p2, WP2), WP2); CD[sz] += ldexp(rd, sz); have[sz] = 1; }
  if (maxR < 0 || miss[maxR]) { printf("G50-REFUSED F=%d %s: a LEADING value was refused (tensor cap or reconstruction)\n", F, odd ? "ODD" : "EVEN"); W_LEADREF++; return; }
  long long rn, rdn; if (!wrational(C1[maxR], C2[maxR], CD[maxR], &rn, &rdn)) { printf("G50-REFUSED F=%d: the leading sum was not reconstructed\n", F); return; }
  int ny = F - maxR, rbf = 0, rcomp = 0, rchi = 0, rori = 0;
  if (nlead == 1) rbf = wrest_shape(leadR, &rcomp, &rchi, &rori);
  int y2 = 0, y3 = 0; if (nlead == 1) { int mY[4 * MAXF + 8]; for (int li = 0; li < NLk; li++) mY[li] = 0; for (int i = 0; i < F; i++) if (!(leadR >> i & 1u)) for (int q = 0; q < 4; q++) mY[plk[i][q]]++; for (int li = 0; li < NLk; li++) { if (mY[li] == 2) y2++; else if (mY[li] >= 3) y3++; } }
  int yv = 0; if (nlead == 1) { for (int i = 0; i < F; i++) { if (leadR >> i & 1u) continue; for (int j = i + 1; j < F; j++) { if (leadR >> j & 1u) continue; int sl = 0; for (int q = 0; q < 4 && !sl; q++) for (int r = 0; r < 4; r++) if (plk[i][q] == plk[j][r]) { sl = 1; break; } if (sl) continue;
    long long ci[4], cj[4]; { long long p = Pl[i]; long long sb = p / NPD; int kk = (int)(p % NPD), a = PAIRA[kk], b = PAIRB[kk]; ci[0] = sb; ci[1] = sb + stride[a]; ci[2] = sb + stride[a] + stride[b]; ci[3] = sb + stride[b]; } { long long p = Pl[j]; long long sb = p / NPD; int kk = (int)(p % NPD), a = PAIRA[kk], b = PAIRB[kk]; cj[0] = sb; cj[1] = sb + stride[a]; cj[2] = sb + stride[a] + stride[b]; cj[3] = sb + stride[b]; }
    int sv = 0; for (int x = 0; x < 4 && !sv; x++) for (int y = 0; y < 4; y++) if (ci[x] == cj[y]) { sv = 1; break; } if (sv) yv++; } } }
  int npatch = 0, lone = 1; long long irn = 0, ird = 1;
  if (nlead == 1 && rbf && rcomp == 1) { int mR[4 * MAXF + 8]; for (int li = 0; li < NLk; li++) mR[li] = 0; for (int i = 0; i < F; i++) if (leadR >> i & 1u) for (int q = 0; q < 4; q++) mR[plk[i][q]]++;
    int uf[MAXF + 4]; for (int i = 0; i < F; i++) uf[i] = i;
    for (int i = 0; i < F; i++) { if (leadR >> i & 1u) continue; for (int j = i + 1; j < F; j++) { if (leadR >> j & 1u) continue; int sh = 0; for (int q = 0; q < 4 && !sh; q++) for (int r = 0; r < 4; r++) if (plk[i][q] == plk[j][r] && mR[plk[i][q]] == 0) { sh = 1; break; } if (sh) { int a = find_(uf, i), b = find_(uf, j); if (a != b) uf[b] = a; } } }
    int psz[MAXF + 4]; for (int i = 0; i < F; i++) psz[i] = 0; for (int i = 0; i < F; i++) if (!(leadR >> i & 1u)) psz[find_(uf, i)]++;
    long long pw3 = 1; for (int i = 0; i < F; i++) if (psz[i]) { npatch++; if (psz[i] > 1) lone = 0; for (int k = 1; k < psz[i]; k++) pw3 *= 3; }
    /* r = (rn/rdn) * 3^(sum (n_patch - 1)) / 2^chi */
    irn = rn * pw3; ird = rdn; if (rchi >= 0) { for (int k = 0; k < rchi; k++) ird *= 2; } else { for (int k = 0; k < -rchi; k++) irn *= 2; }
    long long g = wgcd(irn, ird); if (g > 1) { irn /= g; ird /= g; } if (ird < 0) { ird = -ird; irn = -irn; }
    if (irn > ird || -irn > ird) W_S8_OVER++; W_S8_N++; if (lone) { W_S8_LONE++; if (irn > ird || -irn > ird) W_S8_LONEOVER++; } }
  int ncross = 0, ntouch = 0, lawok = 2;
  if (nlead == 1 && rbf && rcomp == 1 && lone && y2 == 0 && y3 == 0) { lawok = vertex_law(leadR, &ncross, &ntouch, irn, ird); }
  char pdesc[160] = ""; if (nlead == 1 && rbf && rcomp == 1) patch_desc(leadR, pdesc, sizeof pdesc);
  wtab_add(F, odd, hist, ny, nlead, rbf, rcomp, rchi, rori, y2, y3, yv, npatch, lone, ncross, ntouch, lawok, irn, ird, rn, rdn, pdesc);
  if (W_LOCAL && odd && nlead == 1) {   /* the local configuration at every vertex Y touches (the §24 falsifier's input) */
    int mS[4 * MAXF + 8], mYl[4 * MAXF + 8]; for (int li = 0; li < NLk; li++) { mS[li] = 0; mYl[li] = 0; }
    for (int i = 0; i < F; i++) for (int q = 0; q < 4; q++) { if (leadR >> i & 1u) mS[plk[i][q]]++; else mYl[plk[i][q]]++; }
    long long c0[MAXD]; { long long s0 = Pl[0] / NPD; for (int d = 0; d < D; d++) c0[d] = (s0 / stride[d]) % B; }
    long long vs[4 * MAXF + 8]; int nv = 0;   /* the vertices Y touches */
    for (int i = 0; i < F; i++) { if (leadR >> i & 1u) continue; long long s = Pl[i] / NPD; int k = (int)(Pl[i] % NPD), a = PAIRA[k], b = PAIRB[k];
      long long cs[4] = { s, s + stride[a], s + stride[b], s + stride[a] + stride[b] };
      for (int c = 0; c < 4; c++) { int seen = 0; for (int t = 0; t < nv; t++) if (vs[t] == cs[c]) seen = 1; if (!seen) vs[nv++] = cs[c]; } }
    for (int t = 0; t < nv; t++) for (int u = t + 1; u < nv; u++) if (vs[u] < vs[t]) { long long w = vs[t]; vs[t] = vs[u]; vs[u] = w; }
    printf("G50-LOCAL F=%d |Y|=%d rho=%lld/%lld rest(chi=%d,comp=%d,bf=%d) vertices=%d:", F, ny, rn, rdn, rchi, rcomp, rbf, nv);
    for (int t = 0; t < nv; t++) { long long v = vs[t]; printf(" ("); for (int d = 0; d < D; d++) printf(d ? ",%lld" : "%lld", (v / stride[d]) % B - c0[d]); printf(")");
      for (int side = 0; side < 2; side++) { printf(side ? "S[" : "Y[");  int first = 1;
        for (int i = 0; i < F; i++) { int inS = (leadR >> i & 1u) ? 1 : 0; if (inS != side) continue; long long s = Pl[i] / NPD; int k = (int)(Pl[i] % NPD), a = PAIRA[k], b = PAIRB[k];
          int sa = 0, sb = 0, hit = 0; if (v == s) { sa = 1; sb = 1; hit = 1; } else if (v == s + stride[a]) { sa = -1; sb = 1; hit = 1; } else if (v == s + stride[b]) { sa = 1; sb = -1; hit = 1; } else if (v == s + stride[a] + stride[b]) { sa = -1; sb = -1; hit = 1; }
          if (!hit) continue; printf("%s%c%d%c%d", first ? "" : ",", sa > 0 ? '+' : '-', a + 1, sb > 0 ? '+' : '-', b + 1); first = 0; }
        printf("]"); }
      printf("L[");  int first = 1;
      for (int d = 0; d < D; d++) for (int sg = 1; sg >= -1; sg -= 2) { long long l = (sg > 0 ? v : v - stride[d]) * D + d; int li = -1; for (int t2 = 0; t2 < NLk; t2++) if (lk[t2] == l) { li = t2; break; } if (li < 0) continue; if (!mS[li] && !mYl[li]) continue;
        printf("%s%c%d:%d/%d", first ? "" : ",", sg > 0 ? '+' : '-', d + 1, mS[li], mYl[li]); first = 0; }
      printf("]"); }
    printf("\n"); }
  if (W_PRED && predhit) { printf("G50-PRED F=%d |Y|=%d profile (%d/%d/%d/%d) rest branch-free %d components %d chi %d: leading sum rn/rdn = %lld/%lld (rho over u^|S| (3a1)^|Y|); patch form r = %lld/%lld %s; plaquettes:", F, ny, hist[2], hist[3], hist[4], hist[5], rbf, rcomp, rchi, rn, rdn, irn, ird, pdesc);
    long long c0[MAXD]; { long long s = Pl[0] / NPD; for (int d = 0; d < D; d++) c0[d] = (s / stride[d]) % B; }
    for (int i = 0; i < F; i++) { long long s = Pl[i] / NPD; int k = (int)(Pl[i] % NPD); printf(" ("); for (int d = 0; d < D; d++) printf(d ? ",%lld" : "%lld", (s / stride[d]) % B - c0[d]); printf(")%d%d%s", PAIRA[k] + 1, PAIRB[k] + 1, (leadR >> i & 1u) ? "" : "*"); }
    printf("  (* = the Y-plaquettes)\n"); }
  /* the plan author's W1 on single-wall chambers with a branch-free connected rest */
  if (odd && ny == 1 && nlead == 1 && rbf && rcomp == 1) { W_S1_N++; double v = (double)rn / rdn, w = ldexp(1.0, rchi); if (fabs(fabs(v) - w) < 1e-9 * w) { if (v > 0 && rchi == 2) W_S1_FOUR++; } else W_S1_OTHER++; if (fabs(v) > W_S1_MAX) W_S1_MAX = fabs(v); if (fabs(v) > 4 * sqrt(2.0) * (w / 4.0) + 1e-9) W_S1_OVER++; }
  /* the full sum's coefficients C_k (k = |R|) */
  char buf[400]; int off = 0; off += snprintf(buf + off, sizeof buf - off, "nk=%d", nk);
  for (int k = F; k >= 0; k--) { if (miss[k]) { off += snprintf(buf + off, sizeof buf - off, " C%d=REFUSED", k); W_SUBREF++; if (off > 360) break; continue; } if (!have[k]) continue; long long a, b; if (!wrational(C1[k], C2[k], CD[k], &a, &b)) { off += snprintf(buf + off, sizeof buf - off, " C%d=?", k); continue; } off += snprintf(buf + off, sizeof buf - off, " C%d=%lld/%lld", k, a, b); if (off > 360) break; }
  char key[440]; snprintf(key, sizeof key, "%s (%d/%d/%d/%d) |Y|=%d: %s", odd ? "ODD" : "EVEN", hist[2], hist[3], hist[4], hist[5], ny, buf); wfull_add(F, key);
}
static void wprint(void) {
  for (int F = 1; F <= MAXF; F++) if (WKAT_N[F]) printf("G50-KAT F=%d branch-free surfaces: %lld weighed, %lld read rho = +-2^chi, %lld missed\n", F, WKAT_N[F], WKAT_OK[F], WKAT_BAD[F]);
  for (int F = 1; F <= MAXF; F++) for (int i = 0; i < NWT; i++) { wtab_t *e = &WT[i]; if (e->F != F) continue;
    if (e->odd == 2) { printf("G50-SURFACE F=%d: chi %d, orientable %d, components %d: rho = W/u^F = %lld/%lld: %lld surfaces\n", F, e->rchi, e->rori, e->rcomp, e->num, e->den, e->n); continue; }
    printf("G50-WEIGHT F=%d %s profile (%d/%d/%d/%d) |Y| = %d (%d leading assignment%s): rho = W/(u^(F-|Y|)(3a1)^|Y|) = %lld/%lld", F, e->odd ? "ODD" : "EVEN", e->h2, e->h3, e->h4, e->h5, e->ny, e->nlead, e->nlead == 1 ? "" : "s", e->num, e->den);
    if (e->nlead == 1) { if (e->rbf) printf("; the rest branch-free, %d component(s), chi %d, orientable %d", e->rcomp, e->rchi, e->rori); else printf("; the rest BRANCHED"); if (e->ny) printf("; the walls hold %d link(s) of wall multiplicity 2 and %d of 3 or more; %d pair(s) of wall plaquettes share a vertex and no link", e->y2, e->y3, e->yv); if (e->rbf && e->rcomp == 1) printf("; %d patch(es)%s, r = rho/(2^chi * prod 3^(1-n)) = %lld/%lld%s", e->npatch, e->lone ? " all LONE" : "", e->rn, e->rd, (e->rn > e->rd || -e->rn > e->rd) ? " |r| > 1 REFUTES S8a" : ""); if (e->lawok != 2) printf("; VERTEX LAW: %d crossing(s), %d touching(s): r %s (-1/3)^crossings", e->ncross, e->ntouch, e->lawok ? "=" : "!="); if (e->pdesc[0]) printf("; PATCHES %s", e->pdesc); }
    printf(": %lld polymers\n", e->n); }
  for (int i = 0; i < NWFU; i++) printf("G50-FULL F=%d %s: %lld polymers\n", WFU[i].F, WFU[i].s, WFU[i].n);
  printf("G50-VERTEX-LAW all-lone link-disjoint chambers: %lld; r = (-1/3)^crossings: %lld; not: %lld; with a touching: %lld\n", W_VL_N, W_VL_OK, W_VL_BAD, W_VL_TOUCH);
  printf("G50-S8 chambers with a branch-free connected rest: %lld, of which |r| > 1: %lld; all-lone chambers: %lld, of which |r| > 1: %lld\n", W_S8_N, W_S8_OVER, W_S8_LONE, W_S8_LONEOVER);
  printf("G50-W1 single-wall chambers with a branch-free connected rest: %lld; rho = +2^chi = +4 on a sphere rest: %lld; |rho| != 2^chi(rest): %lld; largest |rho| %.6f; above 4 sqrt2 * 2^chi/4: %lld\n", W_S1_N, W_S1_FOUR, W_S1_OTHER, W_S1_MAX, W_S1_OVER);
  printf("G50-CACHE %d link types factored (%lld builds, %lld hits), %lld zero links\n", NWC, W_CACHE_BUILDS, W_CACHE_HITS, W_ZERO_LINKS);
  printf("G50-EVALS %lld network evaluations, %lld refused (%lld polymers with a LEADING value refused, %lld subleading coefficients left incomplete), largest tensor %lld entries\n", W_EVALS, W_REFUSED, W_LEADREF, W_SUBREF, W_MAXSIZE);
}

static int FY[8], nFY; static long long RT[MAXF + 1][8][2][6]; static long long RRED[MAXF + 1][8][2];
static void restinfo(int ms) {
  int F = F_; int inY[MAXF + 4]; for (int i = 0; i < F; i++) inY[i] = 0; for (int t = 0; t < nFY; t++) inY[FY[t]] = 1;
  int m[4 * MAXF + 8]; for (int li = 0; li < NLk; li++) m[li] = 0;
  for (int i = 0; i < F; i++) if (!inY[i]) for (int q = 0; q < 4; q++) m[plk[i][q]]++;
  int bf = 1; for (int li = 0; li < NLk; li++) if (m[li] != 0 && m[li] != 2) { bf = 0; break; }
  int uf[MAXF + 4]; for (int i = 0; i < F; i++) uf[i] = i;
  for (int i = 0; i < F; i++) { if (inY[i]) continue; for (int j = i + 1; j < F; j++) { if (inY[j]) continue; int sh = 0; for (int q = 0; q < 4 && !sh; q++) for (int r = 0; r < 4; r++) if (plk[i][q] == plk[j][r]) { sh = 1; break; }
      if (sh) { int a = i, b = j; while (uf[a] != a) a = uf[a]; while (uf[b] != b) b = uf[b]; if (a != b) uf[b] = a; } } }
  int nc = 0; for (int i = 0; i < F; i++) if (!inY[i] && uf[i] == i) nc++;
  if (ms >= 0 && ms < 8 && nc < 6) RT[F][ms][bf][nc]++;
  if (!bf && ms >= 0 && ms < 8) { /* a branched rest: is it itself reducible (two closed parts on a forest)? */
    int sub[MAXF + 4], ns = 0; for (int i = 0; i < F; i++) if (!inY[i]) sub[ns++] = i;
    int saveF = F_; static int savek[MAXF + 4][4]; for (int i = 0; i < F; i++) for (int q = 0; q < 4; q++) savek[i][q] = plk[i][q];
    for (int i = 0; i < ns; i++) for (int q = 0; q < 4; q++) plk[i][q] = savek[sub[i]][q];
    F_ = ns; int rr = reducible(); F_ = saveF;
    for (int i = 0; i < F; i++) for (int q = 0; q < 4; q++) plk[i][q] = savek[i][q];
    RRED[F][ms][rr]++; prof_rred_add(F, ms, rr, m); }
}
static void restprint(void) {
  for (int F = 1; F <= MAXF; F++) for (int ms = 0; ms < 8; ms++) for (int bf = 0; bf < 2; bf++) for (int nc = 0; nc < 6; nc++) if (RT[F][ms][bf][nc])
    printf("G48-REST F=%d odd irreducible with |Y| = %d: the rest X minus Y (area %d) is %s with %d component(s): %lld polymers\n", F, ms, F - ms, bf ? "BRANCH-FREE" : "BRANCHED", nc, RT[F][ms][bf][nc]);
}
static void rredprint(void) {
  for (int F = 1; F <= MAXF; F++) for (int ms = 0; ms < 8; ms++) for (int rr = 0; rr < 2; rr++) if (RRED[F][ms][rr])
    printf("G48-RREST F=%d odd irreducible with |Y| = %d and a BRANCHED rest: the rest is itself %s: %lld polymers\n", F, ms, rr ? "REDUCIBLE (two closed parts on a forest)" : "IRREDUCIBLE", RRED[F][ms][rr]);
}
/* the integer-spin plaquettes: at every link the half-integer spins must pair up, so the set Y of plaquettes carrying integer spin satisfies
   (multiplicity at the link - plaquettes of Y at the link) even, i.e. the Z2 boundary of Y equals the odd links of X; the least |Y| and the
   number of least Y fix the leading activity u_half^(F - |Y|) u_one^|Y| (the spin-1 coefficient for Y, spin 1/2 for the rest) */
static int minspin(int *nmin) {
  int F = F_; int odd[4 * MAXF + 8]; int anyodd = 0; for (int li = 0; li < NLk; li++) { odd[li] = lmult[li] & 1; anyodd |= odd[li]; }
  *nmin = 1; if (!anyodd) return 0;
  int idx[8]; int cnt[4 * MAXF + 8];
  for (int k = 1; k <= 6 && k <= F; k++) { int found = 0; for (int t = 0; t < k; t++) idx[t] = t;
    for (;;) { for (int li = 0; li < NLk; li++) cnt[li] = 0; for (int t = 0; t < k; t++) for (int q = 0; q < 4; q++) cnt[plk[idx[t]][q]] ^= 1;
      int ok = 1; for (int li = 0; li < NLk; li++) if (cnt[li] != odd[li]) { ok = 0; break; } if (ok) { if (!found) { for (int t2 = 0; t2 < k; t2++) FY[t2] = idx[t2]; nFY = k; } found++; }
      int t = k - 1; while (t >= 0 && idx[t] == F - k + t) t--; if (t < 0) break; idx[t]++; for (int u = t + 1; u < k; u++) idx[u] = idx[u - 1] + 1; }
    if (found) { *nmin = found; return k; } }
  *nmin = 0; return -1;
}
typedef struct { int F, odd, h2, h3, h4, h5, h6, dec, rank, nc, ms; long long n, nmsum; int nmmin, nmmax; } ptab_t; static ptab_t PT[4096]; static int NPT;
static void ptab_add(int F, int odd, const int *hist, int dec, int rank, int nc, int ms, int nm) {
  for (int i = 0; i < NPT; i++) { ptab_t *e = &PT[i]; if (e->F == F && e->odd == odd && e->h2 == hist[2] && e->h3 == hist[3] && e->h4 == hist[4] && e->h5 == hist[5] && e->h6 == hist[6] && e->dec == dec && e->rank == rank && e->nc == nc && e->ms == ms) {
      e->n++; e->nmsum += nm; if (nm < e->nmmin) e->nmmin = nm; if (nm > e->nmmax) e->nmmax = nm; return; } }
  if (NPT < 4096) { ptab_t *e = &PT[NPT++]; e->F = F; e->odd = odd; e->h2 = hist[2]; e->h3 = hist[3]; e->h4 = hist[4]; e->h5 = hist[5]; e->h6 = hist[6]; e->dec = dec; e->rank = rank; e->nc = nc; e->ms = ms; e->n = 1; e->nmsum = nm; e->nmmin = nm; e->nmmax = nm; }
}
static void ptab_print(void) {
  for (int F = 1; F <= MAXF; F++) for (int i = 0; i < NPT; i++) { ptab_t *e = &PT[i]; if (e->F != F) continue;
    printf("G48-PROFILE F=%d %s m2=%d m3=%d m4=%d m5=%d m6=%d", e->F, e->odd ? "ODD" : "EVEN", e->h2, e->h3, e->h4, e->h5, e->h6);
    if (!e->odd) { if (e->dec == 1) printf(" DECOMPOSES into %d surfaces, least cycle rank %d", e->nc, e->rank); else printf(" SELF-TOUCHING"); }
    else printf(" least integer-spin plaquettes %d (least sets per polymer %d..%d, mean %.3f)", e->ms, e->nmmin, e->nmmax, (double)e->nmsum / e->n);
    printf(": %lld irreducible sets\n", e->n); }
}
static long long nlistedOdd[MAXF + 1], nlistedEven[MAXF + 1];
static void record(void) {
  int F = np; F_ = F; NLk = 0;
  for (int i = 0; i < F; i++) { long long L4[4]; plinks(Pl[i], L4); for (int q = 0; q < 4; q++) { int f = -1; for (int t = 0; t < NLk; t++) if (lk[t] == L4[q]) { f = t; break; } if (f < 0) { lk[NLk] = L4[q]; f = NLk++; } plk[i][q] = f; } }
  int hist[8] = {0}; for (int t = 0; t < NLk; t++) { lmult[t] = mult[lk[t]]; if (lmult[t] < 8) hist[lmult[t]]++; }
  if (hist[3] == 0 && hist[4] == 0 && hist[5] == 0 && hist[6] == 0) { cntBF[F]++; even_reach(0); if (!W_ZMIN) weigh_surface(); return; }
  cntBr[F]++; int odd = hist[3] || hist[5];
  int red = reducible();
  if (red) { if (odd) cntRedOdd[F]++; else { cntRedEven[F]++; even_reach(1); } return; }
  if (odd) cntIrrOdd[F]++; else cntIrrEven[F]++;
  int rank = -1, nc = 0, dec = 0; if (!odd) { dec = decompose(&rank, &nc); if (dec == 1) cntIrrEvenDec[F]++; else cntIrrEvenSelf[F]++; } if (!odd) { chi_all(); int ccx = 0; even_reach(contact_graph(lmult, 4, &ccx) > 0 ? 3 : 2); }
  int nm = 1, ms = minspin(&nm); ptab_add(F, odd, hist, dec, rank, nc, ms, nm); if (odd && ms > 0) restinfo(ms); if (!W_ZMIN || (!odd && dec == 0)) weigh_polymer(odd, hist);
  { char prof[32]; snprintf(prof, sizeof prof, "%d/%d/%d", hist[2], hist[3], hist[4]); if (W_LISTPROF && !strcmp(W_LISTPROF, prof)) { nlistedOdd[F] = -1000000; nlistedEven[F] = -1000000; } }   /* W_LISTPROF="m2/m3/m4": list every polymer of that profile (14:4x, the coordination author's ask for the (13/18/0) chamber) */
  if ((odd ? nlistedOdd[F] : nlistedEven[F]) < LISTMAX) { if (odd) nlistedOdd[F]++; else nlistedEven[F]++;
    printf("G48-IRREDUCIBLE F=%d %s: links by multiplicity m2=%d m3=%d m4=%d m5=%d m6=%d", F, odd ? "ODD" : "EVEN", hist[2], hist[3], hist[4], hist[5], hist[6]);
    if (odd) printf("; least integer-spin plaquettes %d (%d least sets)", ms, nm);
    if (!odd) { if (dec == 1) printf("; DECOMPOSES into %d branch-free surfaces, least cycle rank of the shared links %d", nc, rank); else printf("; SELF-TOUCHING (no pairing gives branch-free components)"); }
    printf("; plaquettes:"); long long c0[MAXD]; { long long s = Pl[0] / NPD; for (int d = 0; d < D; d++) c0[d] = (s / stride[d]) % B; }
    for (int i = 0; i < F; i++) { long long s = Pl[i] / NPD; int k = (int)(Pl[i] % NPD); printf(" ("); for (int d = 0; d < D; d++) printf(d ? ",%lld" : "%lld", (s / stride[d]) % B - c0[d]); printf(")%d%d", PAIRA[k] + 1, PAIRB[k] + 1); }
    printf("\n"); }
}
static void dfs(void) {
  nodes++;
  if (ndef == 0) {
    record(); if (np >= FMAX) return;
    long long cand[24 * MAXF + 8]; int nc = 0;
    for (int i = 0; i < np; i++) { long long L4[4]; plinks(Pl[i], L4); for (int q = 0; q < 4; q++) { long long P6[6]; int n6; lplaqs(L4[q], P6, &n6); for (int t = 0; t < n6; t++) { long long p = P6[t]; if (!inX[p] && !forb[p]) cand[nc++] = p; } } }
    qsort(cand, nc, sizeof(long long), cmpll); int nu = 0; for (int i = 0; i < nc; i++) if (nu == 0 || cand[i] != cand[nu - 1]) cand[nu++] = cand[i];
    for (int i = 0; i < nu; i++) { addp(cand[i]); if (np + (ndef + 3) / 4 <= FMAX) dfs(); remp(cand[i]); forb[cand[i]]++; }
    for (int i = 0; i < nu; i++) forb[cand[i]]--;
    return; }
  if (np + (ndef + 3) / 4 > FMAX) return;
  long long l = defl[0]; for (int i = 1; i < ndef; i++) if (defl[i] < l) l = defl[i];
  long long P6[6]; int n6; lplaqs(l, P6, &n6); qsort(P6, n6, sizeof(long long), cmpll);
  int used[6], nused = 0;
  for (int t = 0; t < n6; t++) { long long p = P6[t]; if (inX[p] || forb[p]) continue; addp(p); dfs(); remp(p); forb[p]++; used[nused++] = t; }
  for (int k = 0; k < nused; k++) forb[P6[used[k]]]--;
}
int main(int argc, char **argv) {
  setvbuf(stdout, NULL, _IONBF, 0);
  if (argc < 3) { fprintf(stderr, "usage: g48_polymers D FMAX [LISTMAX]\n"); return 2; }
  D = atoi(argv[1]); FMAX = atoi(argv[2]); if (argc > 3) LISTMAX = atoi(argv[3]); if ((D != 3 && D != 4) || FMAX < 4 || FMAX > MAXF) return 2;
  mkpair6(); RH_k = calloc((size_t)1 << RH_BITS, sizeof(unsigned int)); RH_s = calloc((size_t)1 << RH_BITS, sizeof(unsigned int)); if (!RH_k || !RH_s) return 3;
  R = FMAX + 3; B = 2 * R + 1; NS = 1; for (int d = D - 1; d >= 0; d--) { stride[d] = NS; NS *= B; }
  NPD = D * (D - 1) / 2; int k = 0; for (int a = 0; a < D; a++) for (int b = a + 1; b < D; b++) { PAIRA[k] = a; PAIRB[k] = b; PIDX[a][b] = PIDX[b][a] = k; k++; }
  mult = calloc((size_t)NS * D, 1); inX = calloc((size_t)NS * NPD, 1); forb = calloc((size_t)NS * NPD, sizeof(unsigned short)); defl = malloc(sizeof(long long) * (4 * MAXF + 16)); dpos = malloc(sizeof(long long) * (size_t)NS * D);
  if (!mult || !inX || !forb || !dpos) { fprintf(stderr, "G48-REFUSED memory\n"); return 3; }
  long long c = 0; for (int d = 0; d < D; d++) c += (long long)R * stride[d];
  long long p0 = c * NPD + PIDX[0][1];
  printf("G48 D=%d FMAX=%d: box side %d; closed link-connected plaquette sets through p0, canonical construction with forbidding\n", D, FMAX, B);
  wfact_init(); wd_init(); if (getenv("W_MAX")) W_MAX = atoi(getenv("W_MAX")); if (getenv("W_KATMAX")) W_KATMAX = atoi(getenv("W_KATMAX")); if (getenv("W_ZMIN")) W_ZMIN = atoi(getenv("W_ZMIN")); if (getenv("W_PRED")) W_PRED = atoi(getenv("W_PRED")); if (getenv("W_LISTASSIGN")) W_LISTASSIGN = atoi(getenv("W_LISTASSIGN")); if (getenv("W_LOCAL")) W_LOCAL = atoi(getenv("W_LOCAL")); if (getenv("W_GREEDY")) W_GREEDY = atoi(getenv("W_GREEDY")); if (getenv("W_CAPLOG")) WCAP = 1LL << atoi(getenv("W_CAPLOG")); if (getenv("W_VERTEX")) W_VERTEX = atoi(getenv("W_VERTEX")); W_LISTPROF = getenv("W_LISTPROF");
  selftest_twobox(p0);
  time_t t0 = time(NULL);
  if (getenv("W_SETFILE")) {   /* a given set, 16:3x: the author's box-interior and doubly-used-link readings */
    FILE *sf = fopen(getenv("W_SETFILE"), "r"); if (!sf) { printf("G50-SET-REFUSED: cannot read %s\n", getenv("W_SETFILE")); return 4; }
    char tok[256]; int nset = 0; long long ids[MAXF + 8];
    while (fscanf(sf, "%255s", tok) == 1) { long long x[MAXD] = {0}; int a = 0, b = 0, ok = 0;
      if (D == 4) ok = (sscanf(tok, "(%lld,%lld,%lld,%lld)%1d%1d", &x[0], &x[1], &x[2], &x[3], &a, &b) == 6);
      else ok = (sscanf(tok, "(%lld,%lld,%lld)%1d%1d", &x[0], &x[1], &x[2], &a, &b) == 5);
      if (!ok || a < 1 || b < 1 || a > D || b > D || a == b) { printf("G50-SET-REFUSED: bad token %s\n", tok); return 4; }
      long long s = 0; for (int d = 0; d < D; d++) { if (x[d] < -R + 1 || x[d] > R - 1) { printf("G50-SET-REFUSED: %s outside the box\n", tok); return 4; } s += (x[d] + R) * stride[d]; }
      long long id = s * NPD + PIDX[a - 1][b - 1]; for (int i = 0; i < nset; i++) if (ids[i] == id) { printf("G50-SET-REFUSED: repeated plaquette %s\n", tok); return 4; }
      if (nset >= MAXF) { printf("G50-SET-REFUSED: more than %d plaquettes\n", MAXF); return 4; } ids[nset++] = id; }
    fclose(sf); if (!nset) { printf("G50-SET-REFUSED: empty set\n"); return 4; }
    printf("G50-SET %d plaquettes from %s\n", nset, getenv("W_SETFILE"));
    for (int i = 0; i < nset; i++) addp(ids[i]);
    { int closed = 1; for (int i = 0; i < nset; i++) { long long L4[4]; plinks(ids[i], L4); for (int q = 0; q < 4; q++) if (mult[L4[q]] & 1) closed = 0; }
      printf("G50-SET closed (every link even) %d\n", closed); }
    record();
    for (int i = nset - 1; i >= 0; i--) remp(ids[i]);
    printf("G50-SET-END (the summary below is this one set's)\n"); }
  else { addp(p0); dfs(); remp(p0); }
  for (int F = 1; F <= FMAX; F++) { if (!(cntBF[F] || cntBr[F])) continue;
    printf("G48-COUNT D=%d F=%d: branch-free %lld; BRANCHED %lld = reducible %lld odd + %lld even, IRREDUCIBLE %lld odd + %lld even (of the even: %lld decompose into branch-free surfaces, %lld self-touching)\n",
      D, F, cntBF[F], cntBr[F], cntRedOdd[F], cntRedEven[F], cntIrrOdd[F], cntIrrEven[F], cntIrrEvenDec[F], cntIrrEvenSelf[F]); }
  ptab_print(); restprint(); rredprint(); chiprint(); prrprint(); reachprint(); wprint(); wvertex_print();
  if (W_PRED) printf("G50-PRED-COUNT odd chambers with one least set seen %lld, matching the predicate %lld\n", W_PRED_SEEN, W_PRED_N);
  printf("G48-END nodes %lld (%ld s)\n", nodes, (long)(time(NULL) - t0));
  return 0;
}
