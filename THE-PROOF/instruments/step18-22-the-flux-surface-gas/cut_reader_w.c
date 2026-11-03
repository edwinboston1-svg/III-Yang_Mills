/* cut_reader_w.c -- THE CUT FORMULA AS A SECOND ROAD ON EVERY LEAF, WITH THE WEINGARTEN STEP AND THE PRIMITIVITY COLUMN (S1 (p),
 * 2026-11-01 15:2x EST; the author), included by boxenum.c.  As cut_reader.c (the pieces by the two-links, the cut surface's
 * corner classes and chi, the boundary circles walked, the lattice contact graph and its cycle rank r), and then:
 *   THE WORDS: a spanning forest of the contact graph is gauge-fixed to 1 (its links contribute no letter) and the r chords are the
 *   letters; every boundary circle's word is read in the walk, each chord side a letter +-(c+1) by its traversal direction against
 *   the link's lattice direction.
 *   THE WEINGARTEN STEP: every chord appears p times as U and p times as U^-1 (the exponent sum of a boundary word in any chord is
 *   zero, each preimage edge lying on two sides), so the SU(2) integral equals the U(2) integral (the integrand is invariant under
 *   the centre), and for p <= 2 the Weingarten function of U(2) on S_p is exact: Wg(e) = 1/2 at p = 1; Wg(e) = 1/3, Wg((12)) = -1/6
 *   at p = 2 (d = 2); p >= 3 is refused by name (the Gram matrix of S_3 is singular at d = 2).  I = sum over (sigma_c, tau_c) of
 *   prod_c Wg_c(sigma_c tau_c^-1) * 2^{loops}, the loops counted by union-find over the matrix-index slots of every word; an exact
 *   rational N/D.  At r = 1 it is compared with the character road (law 6 inside the reader).
 *   THE PRIMITIVITY COLUMN (the author's instrument, 15:3x): the set of distinct non-trivial cyclic words (up to rotation and inversion)
 *   is reduced by Whitehead's algorithm -- every type-II Whitehead automorphism (A, a) that lowers the total cyclic length is applied
 *   until none does -- and the set is PRIMITIVE iff it ends as distinct single letters (a subset of a free basis), by Whitehead's theorem
 *   for finite sets of cyclic words.
 */
#define CT_CJ 64
#define CT_MAXW 64
#define CT_MAXL 256
typedef struct { double S; int chi, nb, r, ok, n6, nonor, m, minimal; long long I; int nc; long long wN, wD; int wg_ok, wg_agree, prim, nwords, minlen; } cut_t;
static void ct_chi_pow(int w, long long *v) { memset(v, 0, sizeof(long long) * CT_CJ); w = w < 0 ? -w : w; if (w == 0) { v[0] = 2; return; } if (w < CT_CJ) v[w] += 1; if (w >= 2) v[w - 2] -= 1; }
static void ct_cg_mul(const long long *a, const long long *b, long long *o) { long long t[CT_CJ]; memset(t, 0, sizeof t);
  for (int i = 0; i < CT_CJ; i++) if (a[i]) for (int j = 0; j < CT_CJ; j++) if (b[j]) { int lo = i > j ? i - j : j - i, hi = i + j; for (int k = lo; k <= hi && k < CT_CJ; k += 2) t[k] += a[i] * b[j]; }
  memcpy(o, t, sizeof t); }
static int ct_par[MAXF * 4]; static int ct_fnd(int x) { while (ct_par[x] != x) x = ct_par[x] = ct_par[ct_par[x]]; return x; }
static void ct_uni(int a, int b) { a = ct_fnd(a); b = ct_fnd(b); if (a != b) ct_par[a] = b; }
static int ct_ppar[MAXF]; static int ct_pfnd(int x) { while (ct_ppar[x] != x) x = ct_ppar[x] = ct_ppar[ct_ppar[x]]; return x; }
static long long ct_gcd(long long a, long long b) { if (a < 0) a = -a; if (b < 0) b = -b; while (b) { long long t = a % b; a = b; b = t; } return a; }
/* ---- the words of the current leaf */
static int WW[CT_MAXW][CT_MAXL], WL[CT_MAXW], NW = 0;
/* ---- the Weingarten step: slots, union-find, the sum over the pairings */
static int sl_par[CT_MAXW * CT_MAXL]; static int sl_fnd(int x) { while (sl_par[x] != x) x = sl_par[x] = sl_par[sl_par[x]]; return x; }
static int ct_weingarten(int r, long long *nout, long long *dout) {
  /* THE BALANCE: chi_1/2(z) = chi_1/2(z^-1), so any circle's word may be inverted without changing the integral; the U(2) step needs
     every chord to appear as often as U as as U^-1 over all words, which the pieces' independent orientations do not guarantee --
     search the sign patterns of the charged words (those with a nonzero exponent vector) for one that balances every chord, and
     invert those words; no pattern (a single word running a chord twice the same way: a non-orientable piece) is refused by name. */
  static int ex[CT_MAXW][32]; static int charged[CT_MAXW]; int nch = 0;
  for (int b = 0; b < NW; b++) { for (int c = 0; c < r; c++) ex[b][c] = 0; for (int k = 0; k < WL[b]; k++) { int let = WW[b][k]; if (let > 0) ex[b][let - 1]++; else ex[b][-let - 1]--; }
    int nz = 0; for (int c = 0; c < r; c++) if (ex[b][c]) nz = 1; if (nz) { if (nch >= 20) return -6; charged[nch++] = b; } }
  int found = -1; for (int pat = 0; pat < (1 << nch); pat++) { int ok = 1; for (int c = 0; c < r && ok; c++) { int s = 0; for (int i = 0; i < nch; i++) s += ((pat >> i) & 1 ? -1 : 1) * ex[charged[i]][c]; if (s != 0) ok = 0; } if (ok) { found = pat; break; } }
  if (found < 0) return -6;
  for (int i = 0; i < nch; i++) if ((found >> i) & 1) { int b = charged[i], L = WL[b]; for (int k = 0; k < L / 2; k++) { int t = WW[b][k]; WW[b][k] = WW[b][L - 1 - k]; WW[b][L - 1 - k] = t; } for (int k = 0; k < L; k++) WW[b][k] = -WW[b][k]; }
  int off[CT_MAXW + 1], ns = 0; for (int b = 0; b < NW; b++) { off[b] = ns; ns += WL[b]; } off[NW] = ns;
  static int pu[32][2][2], pb[32][2][2], npu[32], npb[32];   /* per chord: the U occurrences (row slot, column slot) and the U^-1 ones */
  for (int c = 0; c < r; c++) { npu[c] = npb[c] = 0; }
  for (int b = 0; b < NW; b++) for (int k = 0; k < WL[b]; k++) { int let = WW[b][k]; int c = (let > 0 ? let : -let) - 1; int row = off[b] + k, col = off[b] + (k + 1) % WL[b];
    if (let > 0) { if (npu[c] >= 2) return -5; pu[c][npu[c]][0] = row; pu[c][npu[c]][1] = col; npu[c]++; } else { if (npb[c] >= 2) return -5; pb[c][npb[c]][0] = row; pb[c][npb[c]][1] = col; npb[c]++; } }
  for (int c = 0; c < r; c++) if (npu[c] != npb[c]) return -6;
  int empties = 0; for (int b = 0; b < NW; b++) if (WL[b] == 0) empties++;
  long long den = 1; int ncomb = 1; static int cidx[32]; int nc2 = 0; for (int c = 0; c < r; c++) { if (npu[c] == 1) den *= 2; else if (npu[c] == 2) { den *= 6; cidx[nc2++] = c; ncomb *= 4; } }
  long long num = 0;
  for (int combo = 0; combo < ncomb; combo++) { for (int s = 0; s < ns; s++) sl_par[s] = s; long long coef = 1; int cc = combo;
    for (int c = 0; c < r; c++) { if (npu[c] == 0) continue; int sg = 0, tg = 0; if (npu[c] == 2) { sg = cc & 1; tg = (cc >> 1) & 1; cc >>= 2; coef *= (sg == tg) ? 2 : -1; }
      for (int k = 0; k < npu[c]; k++) { int ks = (npu[c] == 2 && sg) ? 1 - k : k, kt = (npu[c] == 2 && tg) ? 1 - k : k;
        int x = sl_fnd(pu[c][k][0]), y = sl_fnd(pb[c][ks][1]); if (x != y) sl_par[x] = y;
        x = sl_fnd(pu[c][k][1]); y = sl_fnd(pb[c][kt][0]); if (x != y) sl_par[x] = y; } }
    int comp = 0; for (int s = 0; s < ns; s++) if (sl_fnd(s) == s) comp++;
    long long t = coef; for (int i = 0; i < comp + empties; i++) t *= 2; num += t; }
  long long g = ct_gcd(num, den); if (g == 0) g = 1; *nout = num / g; *dout = den / g; return 1; }
/* ---- the primitivity column: Whitehead's algorithm on the set of distinct non-trivial cyclic words */
static void ct_cycreduce(int *w, int *L) { int n = *L, changed = 1; while (changed && n > 0) { changed = 0;
    int m = 0; for (int i = 0; i < n; i++) { if (m > 0 && w[m - 1] == -w[i]) { m--; changed = 1; } else w[m++] = w[i]; } n = m;
    while (n >= 2 && w[0] == -w[n - 1]) { for (int i = 0; i + 1 < n - 1; i++) w[i] = w[i + 1]; n -= 2; changed = 1; } }
  *L = n; }
static int ct_let_idx(int let, int r) { return let > 0 ? let - 1 : r + (-let) - 1; }
static int ct_whitehead_apply(int r, int a, unsigned A, int (*src)[CT_MAXL], const int *srcL, int nw, int (*dst)[CT_MAXL], int *dstL) {   /* returns the total cyclic length */
  int total = 0;
  for (int b = 0; b < nw; b++) { int m = 0; for (int k = 0; k < srcL[b]; k++) { int x = src[b][k]; int xa = x > 0 ? x : -x; int img[4], ni = 0;
      if (xa == (a > 0 ? a : -a)) { img[ni++] = x; }
      else { int inA = (A >> ct_let_idx(x, r)) & 1, invA = (A >> ct_let_idx(-x, r)) & 1;   /* for the letter x as written: phi(x) by the rule, phi(x^-1) = phi(x)^-1 */
        int y = x > 0 ? x : -x; int yinA = (A >> ct_let_idx(y, r)) & 1, yinvA = (A >> ct_let_idx(-y, r)) & 1; int seq[3], ns = 0;
        if (yinA && !yinvA) { seq[ns++] = y; seq[ns++] = a; } else if (!yinA && yinvA) { seq[ns++] = -a; seq[ns++] = y; } else if (yinA && yinvA) { seq[ns++] = -a; seq[ns++] = y; seq[ns++] = a; } else { seq[ns++] = y; }
        if (x > 0) { for (int i = 0; i < ns; i++) img[ni++] = seq[i]; } else { for (int i = ns - 1; i >= 0; i--) img[ni++] = -seq[i]; }
        (void)inA; (void)invA; }
      for (int i = 0; i < ni; i++) { if (m >= CT_MAXL) return -1; dst[b][m++] = img[i]; } }
    dstL[b] = m; ct_cycreduce(dst[b], &dstL[b]); total += dstL[b]; }
  return total; }
static int ct_primitive(int r, int *minlen_out, int *nwords_out) {
  static int w1[CT_MAXW][CT_MAXL], w2[CT_MAXW][CT_MAXL]; static int l1[CT_MAXW], l2[CT_MAXW]; int nw = 0;
  /* the distinct non-trivial cyclic words up to rotation and inversion: canonical form = the smallest rotation of the word or its inverse */
  for (int b = 0; b < NW; b++) { int L = WL[b]; if (L == 0) continue; static int tmp[CT_MAXL], best[CT_MAXL]; int bestset = 0;
    for (int inv = 0; inv < 2; inv++) for (int rot = 0; rot < L; rot++) { for (int k = 0; k < L; k++) { int src = inv ? -WW[b][(rot + L - 1 - k) % L] : WW[b][(rot + k) % L]; tmp[k] = src; }
        int cmp = 0; if (!bestset) cmp = -1; else for (int k = 0; k < L; k++) { if (tmp[k] != best[k]) { cmp = tmp[k] < best[k] ? -1 : 1; break; } } if (cmp < 0) { memcpy(best, tmp, sizeof(int) * L); bestset = 1; } }
    int dup = 0; for (int t = 0; t < nw; t++) if (l1[t] == L && !memcmp(w1[t], best, sizeof(int) * L)) dup = 1; if (dup) continue;
    if (nw >= CT_MAXW) return -1; memcpy(w1[nw], best, sizeof(int) * L); l1[nw] = L; nw++; }
  *nwords_out = nw; if (nw == 0) { *minlen_out = 0; return 1; }
  int total = 0; for (int t = 0; t < nw; t++) total += l1[t];
  int improved = 1, rounds = 0; while (improved && rounds++ < 200) { improved = 0;
    for (int ai = 0; ai < 2 * r && !improved; ai++) { int a = ai < r ? ai + 1 : -(ai - r + 1); unsigned nl = 2 * r;
      for (unsigned A = 0; A < (1u << nl) && !improved; A++) { if (!((A >> ct_let_idx(a, r)) & 1)) continue; if ((A >> ct_let_idx(-a, r)) & 1) continue;
        int tot2 = ct_whitehead_apply(r, a, A, w1, l1, nw, w2, l2); if (tot2 < 0) continue;
        if (tot2 < total) { for (int t = 0; t < nw; t++) { memcpy(w1[t], w2[t], sizeof(int) * l2[t]); l1[t] = l2[t]; } total = tot2; improved = 1; } } } }
  *minlen_out = total;
  /* primitive iff every word is a single letter and the letters are distinct up to inversion (and none vanished) */
  for (int t = 0; t < nw; t++) if (l1[t] != 1) return 0;
  for (int t = 0; t < nw; t++) for (int u = t + 1; u < nw; u++) { int x = w1[t][0] > 0 ? w1[t][0] : -w1[t][0], y = w1[u][0] > 0 ? w1[u][0] : -w1[u][0]; if (x == y) return 0; }
  return 1; }
#include "ct_freefactor.c"
static cut_t cut_P(void) {
  cut_t out; memset(&out, 0, sizeof out); out.prim = -1;
  static long lk[MAXF * 4]; static int lp[MAXF * 4][6][2], lm[MAXF * 4], lc[MAXF][4][4], lmu[MAXF * 4]; int nl = 0;
  for (int p = 0; p < F; p++) { long Lk[4]; plaq_links(P[p], Lk); long s = P[p] / NPAIR; int k = (int)(P[p] % NPAIR); int a = PMU[k], c = PNU[k]; int b[4]; coords(s, b);
    memcpy(lc[p][0], b, sizeof b); memcpy(lc[p][1], b, sizeof b); lc[p][1][a]++; memcpy(lc[p][2], lc[p][1], sizeof b); lc[p][2][c]++; memcpy(lc[p][3], b, sizeof b); lc[p][3][c]++;
    for (int q = 0; q < 4; q++) { int idx = -1; for (int i = 0; i < nl; i++) if (lk[i] == Lk[q]) idx = i; if (idx < 0) { idx = nl++; lk[idx] = Lk[q]; lm[idx] = 0; lmu[idx] = (int)(Lk[q] % D); }
      if (lm[idx] >= 6) { out.ok = -1; return out; } lp[idx][lm[idx]][0] = p; lp[idx][lm[idx]][1] = q; lm[idx]++; } }
  int n2 = 0, nc = 0; static int clink[MAXF * 4];
  for (int i = 0; i < nl; i++) { if (lm[i] == 2) n2++; else if (lm[i] == 4 || lm[i] == 6) { clink[nc++] = i; if (lm[i] == 6) out.n6++; } else { out.ok = -1; return out; } }
  out.nc = nc;
  for (int i = 0; i < F * 4; i++) ct_par[i] = i; for (int p = 0; p < F; p++) ct_ppar[p] = p;
  for (int i = 0; i < nl; i++) if (lm[i] == 2) { int p = lp[i][0][0], s = lp[i][0][1], q = lp[i][1][0], s2 = lp[i][1][1];
    for (int k = 0; k < 2; k++) { int cp = (s + k) % 4; for (int k2 = 0; k2 < 2; k2++) { int cq = (s2 + k2) % 4; if (!memcmp(lc[p][cp], lc[q][cq], sizeof(int) * 4)) ct_uni(p * 4 + cp, q * 4 + cq); } }
    { int a = ct_pfnd(p), b = ct_pfnd(q); if (a != b) ct_ppar[a] = b; } }
  int V = 0; for (int i = 0; i < F * 4; i++) if (ct_fnd(i) == i) V++;
  int E = n2; for (int j = 0; j < nc; j++) E += lm[clink[j]];
  out.chi = V - E + F;
  int m = 0; static int proot[MAXF], pidx[MAXF]; for (int p = 0; p < F; p++) { int rt = ct_pfnd(p), id = -1; for (int t = 0; t < m; t++) if (proot[t] == rt) id = t; if (id < 0) { id = m++; proot[id] = rt; } pidx[p] = id; }
  out.m = m;
  { static unsigned char M[MAXF][MAXF * 4]; for (int t = 0; t < m; t++) for (int j = 0; j < nc; j++) M[t][j] = 0;
    for (int j = 0; j < nc; j++) { int i = clink[j]; for (int a = 0; a < lm[i]; a++) M[pidx[lp[i][a][0]]][j] ^= 1; }
    int rank = 0; for (int j = 0; j < nc && rank < m; j++) { int piv = -1; for (int t = rank; t < m; t++) if (M[t][j]) { piv = t; break; } if (piv < 0) continue;
      if (piv != rank) for (int c = 0; c < nc; c++) { unsigned char x = M[piv][c]; M[piv][c] = M[rank][c]; M[rank][c] = x; }
      for (int t = 0; t < m; t++) if (t != rank && M[t][j]) for (int c = 0; c < nc; c++) M[t][c] ^= M[rank][c]; rank++; }
    out.minimal = (rank == m - 1); }
  static int sp[MAXF * 6], ss[MAXF * 6], sA[MAXF * 6], sB[MAXF * 6], sj[MAXF * 6]; int ns = 0;
  for (int j = 0; j < nc; j++) { int i = clink[j]; for (int a = 0; a < lm[i]; a++) { int p = lp[i][a][0], s = lp[i][a][1]; sp[ns] = p; ss[ns] = s; sj[ns] = j; sA[ns] = ct_fnd(p * 4 + s); sB[ns] = ct_fnd(p * 4 + (s + 1) % 4); ns++; } }
  static int deg[MAXF * 4], adj[MAXF * 4][2]; for (int i = 0; i < F * 4; i++) deg[i] = 0;
  for (int t = 0; t < ns; t++) { int a = sA[t], b = sB[t]; if (deg[a] >= 2 || deg[b] >= 2) { out.ok = -2; return out; } adj[a][deg[a]++] = t; adj[b][deg[b]++] = t; }
  for (int t = 0; t < ns; t++) if (deg[sA[t]] != 2 || deg[sB[t]] != 2) { out.ok = -2; return out; }
  /* the lattice contact graph: its spanning forest (in the order of the links), the chords, the cycle rank */
  static int ept[MAXF * 8][4]; static int epar[MAXF * 8]; int nep = 0; static int ends[MAXF * 4][2];
  for (int j = 0; j < nc; j++) { int i = clink[j]; int p = lp[i][0][0], s = lp[i][0][1];
    for (int k = 0; k < 2; k++) { const int *c = lc[p][(s + k) % 4]; int idx = -1; for (int t = 0; t < nep; t++) if (!memcmp(ept[t], c, sizeof(int) * 4)) idx = t; if (idx < 0) { idx = nep++; memcpy(ept[idx], c, sizeof(int) * 4); } ends[j][k] = idx; } }
  static int chordid[MAXF * 4]; int r = 0; { for (int t = 0; t < nep; t++) epar[t] = t; for (int j = 0; j < nc; j++) { int a = ends[j][0], b = ends[j][1]; while (epar[a] != a) a = epar[a]; while (epar[b] != b) b = epar[b]; if (a != b) { epar[a] = b; chordid[j] = -1; } else chordid[j] = r++; } }
  out.r = r; if (r > 31) { out.ok = -3; return out; }
  /* walk the circles: the words (the chord letters by traversal direction), and the winding about the first chord for the character road at r = 1 */
  static int seen_s[MAXF * 6]; for (int t = 0; t < ns; t++) seen_s[t] = 0; int nb = 0; long long acc[CT_CJ], v[CT_CJ]; memset(acc, 0, sizeof acc); acc[0] = 1; NW = 0;
  for (int t0 = 0; t0 < ns; t0++) { if (seen_s[t0]) continue; int t = t0, from = sA[t0]; int w = 0; nb++; int L = 0; if (NW >= CT_MAXW) { out.ok = -7; return out; }
    do { seen_s[t] = 1; int to = (sA[t] == from) ? sB[t] : sA[t]; int dir = (sA[t] == from) ? +1 : -1; int j = sj[t];
      if (chordid[j] >= 0) { int p = sp[t], s = ss[t]; int mu = lmu[clink[j]]; int g = (lc[p][(s + 1) % 4][mu] - lc[p][s][mu]) > 0 ? +1 : -1; int sign = dir * g; if (L < CT_MAXL) WW[NW][L++] = sign * (chordid[j] + 1); else { out.ok = -7; return out; } if (chordid[j] == 0) w += sign; }
      int nxt = (adj[to][0] == t) ? adj[to][1] : adj[to][0]; from = to; t = nxt; } while (t != t0);
    WL[NW] = L; ct_cycreduce(WW[NW], &WL[NW]); NW++;
    ct_chi_pow(r == 1 ? w : 0, v); ct_cg_mul(acc, v, acc); }
  out.nb = nb; out.I = acc[0];
  /* the Weingarten step, at every rank; at r = 1 compared with the character road */
  out.wg_ok = (r >= 1) ? ct_weingarten(r, &out.wN, &out.wD) : 0; out.wg_agree = -1;
  if (r == 1 && out.wg_ok == 1) out.wg_agree = (out.wD != 0 && out.wN == out.I * out.wD) ? 1 : 0;
  if (r >= 1) { int rk = 0, ed = 0; int ff = ct_freefactor(r, &rk, &ed); out.prim = ff; out.minlen = ed; out.nwords = rk; }   /* the free-factor column: prim = 1 iff <words> is a free factor; nwords = its rank, minlen = the core edges */
  /* the sign: the cross-caps of the non-orientable pieces */
  int sign = 1; { static int ori[MAXF]; for (int p = 0; p < F; p++) ori[p] = 0; static int nonor_piece[MAXF]; for (int t = 0; t < m; t++) nonor_piece[t] = 0;
    static int plinks[MAXF][4]; for (int p = 0; p < F; p++) { long Lk[4]; plaq_links(P[p], Lk); for (int q = 0; q < 4; q++) { int idx = -1; for (int i = 0; i < nl; i++) if (lk[i] == Lk[q]) idx = i; plinks[p][q] = idx; } }
    static int stack[MAXF]; for (int p0 = 0; p0 < F; p0++) { if (ori[p0]) continue; ori[p0] = 1; int sp2 = 0; stack[sp2++] = p0;
      while (sp2) { int p = stack[--sp2]; for (int q = 0; q < 4; q++) { int i = plinks[p][q]; if (lm[i] != 2) continue; int o = lp[i][0][0] == p ? 1 : 0; int qq = lp[i][o][0], s2 = lp[i][o][1]; int mu = lmu[i];
          int gp = (lc[p][(q + 1) % 4][mu] - lc[p][q][mu]) > 0 ? 1 : -1, gq = (lc[qq][(s2 + 1) % 4][mu] - lc[qq][s2][mu]) > 0 ? 1 : -1; int want = -ori[p] * gp * gq;
          if (!ori[qq]) { ori[qq] = want; stack[sp2++] = qq; } else if (ori[qq] != want) nonor_piece[pidx[p]] = 1; } } }
    static int pchi[MAXF], pnb[MAXF]; for (int t = 0; t < m; t++) { pchi[t] = 0; pnb[t] = 0; }
    for (int p = 0; p < F; p++) pchi[pidx[p]]++; for (int i = 0; i < nl; i++) { if (lm[i] == 2) pchi[pidx[lp[i][0][0]]]--; else for (int a = 0; a < lm[i]; a++) pchi[pidx[lp[i][a][0]]]--; }
    for (int c = 0; c < F * 4; c++) if (ct_fnd(c) == c) pchi[pidx[c / 4]]++;
    for (int t0 = 0; t0 < ns; t0++) seen_s[t0] = 0; for (int t0 = 0; t0 < ns; t0++) { if (seen_s[t0]) continue; int t = t0, from = sA[t0]; pnb[pidx[sp[t0]]]++; do { seen_s[t] = 1; int to = (sA[t] == from) ? sB[t] : sA[t]; int nxt = (adj[to][0] == t) ? adj[to][1] : adj[to][0]; from = to; t = nxt; } while (t != t0); }
    for (int t = 0; t < m; t++) if (nonor_piece[t]) { out.nonor++; int k = 2 - (pchi[t] + pnb[t]); if (k & 1) sign = -sign; } }
  if (r <= 1) out.S = sign * pow(2.0, out.chi) * (double)out.I;
  else if (out.wg_ok == 1) out.S = sign * pow(2.0, out.chi) * (double)out.wN / (double)out.wD;
  else { out.ok = (out.wg_ok == -5) ? -5 : -6; return out; }
  out.ok = 1; return out; }
