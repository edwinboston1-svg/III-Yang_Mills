/* g51_orient.c -- THE ORIENTABILITY CENSUS OF EVERY BRANCH-FREE CLOSED SURFACE OF Z^4 THROUGH A PLAQUETTE (PENTAPYLON G51, 2026-10-29
 * 13:2x EDT, the author; the author's development item B6 of 13:2x: S4-prime's piece formula is proved for orientable pieces only, so
 * every rest must be read for orientability before C(T) is used on it).
 * THE ENUMERATION is g48's (each closed link-connected plaquette set through p0 once, by the canonical construction with forbidding, pruned by
 * |P| + ceil(n1/4) <= FMAX); a closed set with a link of multiplicity other than 2 is BRANCHED and is counted and dropped at once (no
 * reducibility test), so the walk costs the enumeration alone.  A branch-free set is a closed surface: its Euler characteristic chi = V - E + F
 * (V its vertices, E its links) and its ORIENTABILITY (a plaquette traverses its link q forward iff q < 2; an orientation epsilon = +-1 per
 * plaquette is consistent iff at every link the two plaquettes traverse it oppositely after their signs; BFS over the link adjacency, a
 * contradiction = non-orientable) are tallied per (F, chi, orientable).
 * KNOWN ANSWERS: branch-free counts 4, 60, 80, 1092, 2728, 23508, 80480 at F = 6..20 (g45, g48); at F = 16 the 8 Clifford tori read chi 0,
 * every other surface to F = 18 chi 2, all orientable (the G50-SURFACE lines of g50_weights2_d4_f18.2026-10-29a.txt).
 * usage: g51_orient D FMAX */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#define MAXD 4
#define MAXF 30
static int D, FMAX, R, B, NPD, PAIRA[6], PAIRB[6], PIDX[MAXD][MAXD]; static long long stride[MAXD], NS;
static unsigned char *mult, *inX; static unsigned short *forb;
static long long *defl, *dpos; static int ndef;
static long long Pl[MAXF + 4]; static int np;
static long long nodes, cntBF[MAXF + 1], cntBr[MAXF + 1], TAB[MAXF + 1][12][2];   /* chi + 6 in 0..11 */
static void plinks(long long p, long long *L4) { long long s = p / NPD; int k = (int)(p % NPD), a = PAIRA[k], b = PAIRB[k]; L4[0] = s * D + a; L4[1] = (s + stride[a]) * D + b; L4[2] = (s + stride[b]) * D + a; L4[3] = s * D + b; }
static void lplaqs(long long l, long long *P6, int *n) { long long s = l / D; int a = (int)(l % D); *n = 0; for (int b = 0; b < D; b++) { if (b == a) continue; int lo = a < b ? a : b, hi = a < b ? b : a; P6[(*n)++] = s * NPD + PIDX[lo][hi]; P6[(*n)++] = (s - stride[b]) * NPD + PIDX[lo][hi]; } }
static void adddef(long long l) { dpos[l] = ndef; defl[ndef++] = l; }
static void deldef(long long l) { long long i = dpos[l]; long long last = defl[--ndef]; defl[i] = last; dpos[last] = i; }
static void addp(long long p) { long long L4[4]; plinks(p, L4); inX[p] = 1; Pl[np++] = p; for (int i = 0; i < 4; i++) { long long l = L4[i]; mult[l]++; if (mult[l] == 1) adddef(l); else if (mult[l] == 2) deldef(l); } }
static void remp(long long p) { long long L4[4]; plinks(p, L4); for (int i = 3; i >= 0; i--) { long long l = L4[i]; if (mult[l] == 2) adddef(l); else if (mult[l] == 1) deldef(l); mult[l]--; } inX[p] = 0; np--; }
static int cmpll(const void *x, const void *y) { long long a = *(const long long *)x, b = *(const long long *)y; return a < b ? -1 : a > b; }
/* THE EVEN-SET CENSUS (14:1x EDT, the author's ask (a)): a branched set that is EVEN (every link multiplicity even) is classified by the
 * dimension of its F2 cycle space -- the kernel of the boundary map on its own plaquettes: dimension 1 means Z2-MINIMAL (no proper nonempty
 * even subset: an acyclic-contact set, a pinch at one contact link, a double contact at two), dimension >= 2 means a composite (a waist, a
 * reducible even set).  Tallied per F with the contact count (links of multiplicity >= 4) and the largest multiplicity. */
static long long cntEvenBr[MAXF + 1], cntZmin[MAXF + 1], cntNonmin[MAXF + 1], ZC[MAXF + 1][8][8], ZR[MAXF + 1][8];   /* [F][contacts][max multiplicity] and [F][cycle rank of the contact graph] of the Z2-minimal */
static void record(void) {
  int F = np; long long lk[4 * MAXF + 8]; int NLk = 0; int plk[MAXF + 4][4]; int branched = 0;
  for (int i = 0; i < F; i++) { long long L4[4]; plinks(Pl[i], L4); for (int q = 0; q < 4; q++) { if (mult[L4[q]] != 2) branched = 1; int f = -1; for (int t = 0; t < NLk; t++) if (lk[t] == L4[q]) { f = t; break; } if (f < 0) { lk[NLk] = L4[q]; f = NLk++; } plk[i][q] = f; } }
  if (branched) { cntBr[F]++;
    int even = 1, contacts = 0, mmax = 0; for (int t = 0; t < NLk; t++) { int m = mult[lk[t]]; if (m & 1) { even = 0; break; } if (m >= 4) contacts++; if (m > mmax) mmax = m; }
    if (!even) return; cntEvenBr[F]++;
    /* the F2 kernel of the boundary map on the plaquettes: row reduce the plaquette vectors (bit li of link index li) */
    unsigned long long V[MAXF + 4][2]; int pb[MAXF + 4]; int npv = 0, nk = 0;
    for (int i = 0; i < F; i++) { unsigned long long v0 = 0, v1 = 0; for (int q = 0; q < 4; q++) { int li = plk[i][q]; if (li < 64) v0 ^= 1ULL << li; else v1 ^= 1ULL << (li - 64); }
      for (int r = 0; r < npv; r++) { int b = pb[r]; int bit = b < 64 ? (int)((v0 >> b) & 1) : (int)((v1 >> (b - 64)) & 1); if (bit) { v0 ^= V[r][0]; v1 ^= V[r][1]; } }
      if (!v0 && !v1) { nk++; continue; }
      int b = v0 ? __builtin_ctzll(v0) : 64 + __builtin_ctzll(v1); V[npv][0] = v0; V[npv][1] = v1; pb[npv] = b; npv++; }
    if (nk == 1) { cntZmin[F]++; if (contacts < 8 && mmax < 8) ZC[F][contacts][mmax]++;
      /* the contact graph: the links of multiplicity >= 4 on the lattice vertices; its cycle rank E - V + C (the author's S12 known answer:
         forest = 0, one cycle = 1, more) */
      long long vs[2 * MAXF + 8]; int nv = 0, uf[2 * MAXF + 8], E = 0, C = 0;
      for (int t = 0; t < NLk; t++) { if (mult[lk[t]] < 4) continue; long long l = lk[t]; long long s0 = l / D; int a = (int)(l % D); long long s1 = s0 + stride[a]; int i0 = -1, i1 = -1;
        for (int z = 0; z < nv; z++) { if (vs[z] == s0) i0 = z; if (vs[z] == s1) i1 = z; }
        if (i0 < 0) { vs[nv] = s0; uf[nv] = nv; i0 = nv++; } if (i1 < 0) { vs[nv] = s1; uf[nv] = nv; i1 = nv++; }
        E++; int r0 = i0, r1 = i1; while (uf[r0] != r0) r0 = uf[r0]; while (uf[r1] != r1) r1 = uf[r1]; if (r0 != r1) uf[r1] = r0; }
      for (int z = 0; z < nv; z++) if (uf[z] == z) C++;
      int rank = E - nv + C; if (rank < 8) ZR[F][rank]++; }
    else cntNonmin[F]++;
    return; }
  cntBF[F]++;
  /* vertices */
  long long vs[4 * MAXF + 8]; int nv = 0;
  for (int i = 0; i < F; i++) { long long p = Pl[i]; long long s = p / NPD; int k = (int)(p % NPD), a = PAIRA[k], b = PAIRB[k]; long long cs[4] = { s, s + stride[a], s + stride[b], s + stride[a] + stride[b] };
    for (int c = 0; c < 4; c++) { int f = 0; for (int z = 0; z < nv; z++) if (vs[z] == cs[c]) { f = 1; break; } if (!f) vs[nv++] = cs[c]; } }
  int chi = nv - NLk + F;
  /* orientability: other[li][0..1] = the two plaquettes at link li and their traversal direction */
  int lp[4 * MAXF + 8][2], ld[4 * MAXF + 8][2], ln[4 * MAXF + 8]; for (int t = 0; t < NLk; t++) ln[t] = 0;
  for (int i = 0; i < F; i++) for (int q = 0; q < 4; q++) { int li = plk[i][q]; lp[li][ln[li]] = i; ld[li][ln[li]] = (q < 2) ? 1 : -1; ln[li]++; }
  int ori[MAXF + 4]; for (int i = 0; i < F; i++) ori[i] = 0; int ok = 1; int qu[MAXF + 4], h = 0, tl = 0; ori[0] = 1; qu[tl++] = 0;
  while (h < tl && ok) { int i = qu[h++]; for (int q = 0; q < 4; q++) { int li = plk[i][q]; int j = (lp[li][0] == i) ? lp[li][1] : lp[li][0]; int di = (lp[li][0] == i) ? ld[li][0] : ld[li][1]; int dj = (lp[li][0] == i) ? ld[li][1] : ld[li][0];
      int want = -ori[i] * di * dj; if (!ori[j]) { ori[j] = want; qu[tl++] = j; } else if (ori[j] != want) { ok = 0; break; } } }
  if (chi + 6 >= 0 && chi + 6 < 12) TAB[F][chi + 6][ok]++;
  if (!ok) { printf("G51-NONORIENTABLE F=%d chi=%d plaquettes:", F, chi); long long c0[MAXD]; { long long s = Pl[0] / NPD; for (int d = 0; d < D; d++) c0[d] = (s / stride[d]) % B; }
    for (int i = 0; i < F; i++) { long long s = Pl[i] / NPD; int k = (int)(Pl[i] % NPD); printf(" ("); for (int d = 0; d < D; d++) printf(d ? ",%lld" : "%lld", (s / stride[d]) % B - c0[d]); printf(")%d%d", PAIRA[k] + 1, PAIRB[k] + 1); } printf("\n"); }
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
  if (argc < 3) { fprintf(stderr, "usage: g51_orient D FMAX\n"); return 2; }
  D = atoi(argv[1]); FMAX = atoi(argv[2]); if ((D != 3 && D != 4) || FMAX < 4 || FMAX > MAXF) return 2;
  R = FMAX + 3; B = 2 * R + 1; NS = 1; for (int d = D - 1; d >= 0; d--) { stride[d] = NS; NS *= B; }
  NPD = D * (D - 1) / 2; int k = 0; for (int a = 0; a < D; a++) for (int b = a + 1; b < D; b++) { PAIRA[k] = a; PAIRB[k] = b; PIDX[a][b] = PIDX[b][a] = k; k++; }
  mult = calloc((size_t)NS * D, 1); inX = calloc((size_t)NS * NPD, 1); forb = calloc((size_t)NS * NPD, sizeof(unsigned short)); defl = malloc(sizeof(long long) * (4 * MAXF + 16)); dpos = malloc(sizeof(long long) * (size_t)NS * D);
  if (!mult || !inX || !forb || !dpos) { fprintf(stderr, "G51-REFUSED memory\n"); return 3; }
  long long c = 0; for (int d = 0; d < D; d++) c += (long long)R * stride[d];
  long long p0 = c * NPD + PIDX[0][1];
  printf("G51 D=%d FMAX=%d: box side %d; the orientability census of the branch-free closed surfaces through p0 (branched sets counted and dropped)\n", D, FMAX, B);
  time_t t0 = time(NULL); addp(p0); dfs(); remp(p0);
  for (int F = 1; F <= FMAX; F++) { if (!(cntBF[F] || cntBr[F])) continue;
    printf("G51-COUNT D=%d F=%d: branch-free %lld, branched (dropped) %lld\n", D, F, cntBF[F], cntBr[F]);
    for (int c2 = 0; c2 < 12; c2++) for (int o = 1; o >= 0; o--) if (TAB[F][c2][o]) printf("G51-SURFACE D=%d F=%d: chi %d, %s: %lld\n", D, F, c2 - 6, o ? "ORIENTABLE" : "NON-ORIENTABLE", TAB[F][c2][o]);
    if (cntEvenBr[F]) { printf("G51-EVEN D=%d F=%d: even branched %lld = Z2-MINIMAL (acyclic contacts) %lld + composite (cycle space of dimension >= 2) %lld\n", D, F, cntEvenBr[F], cntZmin[F], cntNonmin[F]);
      for (int c = 0; c < 8; c++) for (int m = 0; m < 8; m++) if (ZC[F][c][m]) printf("G51-ZMIN D=%d F=%d: %d contact link(s), largest multiplicity %d: %lld\n", D, F, c, m, ZC[F][c][m]);
      for (int r = 0; r < 8; r++) if (ZR[F][r]) printf("G51-ZMIN-CONTACT-GRAPH D=%d F=%d: cycle rank %d (%s): %lld\n", D, F, r, r == 0 ? "a forest" : r == 1 ? "one cycle" : "more than one cycle", ZR[F][r]); } }
  printf("G51-END nodes %lld (%ld s)\n", nodes, (long)(time(NULL) - t0));
  return 0;
}
