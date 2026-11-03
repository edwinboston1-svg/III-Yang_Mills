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
#define MAXF 26
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
  if (hist[3] == 0 && hist[4] == 0 && hist[5] == 0 && hist[6] == 0) { cntBF[F]++; even_reach(0); return; }
  cntBr[F]++; int odd = hist[3] || hist[5];
  int red = reducible();
  if (red) { if (odd) cntRedOdd[F]++; else { cntRedEven[F]++; even_reach(1); } return; }
  if (odd) cntIrrOdd[F]++; else cntIrrEven[F]++;
  int rank = -1, nc = 0, dec = 0; if (!odd) { dec = decompose(&rank, &nc); if (dec == 1) cntIrrEvenDec[F]++; else cntIrrEvenSelf[F]++; } if (!odd) { chi_all(); int ccx = 0; even_reach(contact_graph(lmult, 4, &ccx) > 0 ? 3 : 2); }
  int nm = 1, ms = minspin(&nm); ptab_add(F, odd, hist, dec, rank, nc, ms, nm); if (odd && ms > 0) restinfo(ms);
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
  selftest_twobox(p0);
  time_t t0 = time(NULL);
  addp(p0); dfs(); remp(p0);
  for (int F = 1; F <= FMAX; F++) { if (!(cntBF[F] || cntBr[F])) continue;
    printf("G48-COUNT D=%d F=%d: branch-free %lld; BRANCHED %lld = reducible %lld odd + %lld even, IRREDUCIBLE %lld odd + %lld even (of the even: %lld decompose into branch-free surfaces, %lld self-touching)\n",
      D, F, cntBF[F], cntBr[F], cntRedOdd[F], cntRedEven[F], cntIrrOdd[F], cntIrrEven[F], cntIrrEvenDec[F], cntIrrEvenSelf[F]); }
  ptab_print(); restprint(); rredprint(); chiprint(); prrprint(); reachprint();
  printf("G48-END nodes %lld (%ld s)\n", nodes, (long)(time(NULL) - t0));
  return 0;
}
