/* cut_reader.c -- THE CUT FORMULA AS A SECOND ROAD ON EVERY LEAF (S1 (p) CORRECTION (3), 2026-11-01 14:3x EST; the author), included
 * by boxenum.c.  For the current set P: cut X along every link of multiplicity >= 4 (the contact links; 2, 4 and 6 admitted), take the
 * pieces (components of the plaquette graph on the two-links), the corner classes of the cut surface (glued along two-links only), its
 * Euler characteristic chi(X_cut) = V - E + F, its boundary circles (the free sides of the contact links, two per boundary corner class),
 * the lattice contact graph G and its cycle rank r.  For r = 0 every boundary word is trivial and I = 2^{n_b}; for r = 1 a chord is
 * chosen on the cycle, every circle's word is U^{w_b} with w_b its signed traversal count of the chord (the winding), and
 * I = the multiplicity of the trivial representation in the product of the virtual characters chi_1/2(U^{w_b}) = [|w|/2] - [|w|/2 - 1]
 * (indices twice the spin; w = 0 gives 2[0]), an exact integer by Clebsch-Gordan; r >= 2 is REFUSED BY NAME (the words need the
 * Weingarten calculus).  S_cut = sign * 2^{chi(X_cut)} * I with the sign (-1)^{cross-caps} over the non-orientable pieces ((n) A1).
 * Z_2-minimality by the rank criterion (CORRECTION (4)): the pieces' odd-sets over the contact links have rank m - 1 over Z_2.
 * On every leaf with links of multiplicity 2 and 4 only, S_cut is compared with the resolution formula's S (law 6: no shared line --
 * the resolution road glues and sums 3^N4 surfaces; this road cuts once and integrates words); on leaves with a six-fold link this
 * road reads alone. */
#define CT_CJ 64
typedef struct { double S; int chi, nb, r, ok, n6, nonor, m, minimal; long long I; int nc; } cut_t;
static void ct_chi_pow(int w, long long *v) { memset(v, 0, sizeof(long long) * CT_CJ); w = w < 0 ? -w : w; if (w == 0) { v[0] = 2; return; } if (w < CT_CJ) v[w] += 1; if (w >= 2) v[w - 2] -= 1; }
static void ct_cg_mul(const long long *a, const long long *b, long long *o) { long long t[CT_CJ]; memset(t, 0, sizeof t);
  for (int i = 0; i < CT_CJ; i++) if (a[i]) for (int j = 0; j < CT_CJ; j++) if (b[j]) { int lo = i > j ? i - j : j - i, hi = i + j; for (int k = lo; k <= hi && k < CT_CJ; k += 2) t[k] += a[i] * b[j]; }
  memcpy(o, t, sizeof t); }
static int ct_par[MAXF * 4]; static int ct_fnd(int x) { while (ct_par[x] != x) x = ct_par[x] = ct_par[ct_par[x]]; return x; }
static void ct_uni(int a, int b) { a = ct_fnd(a); b = ct_fnd(b); if (a != b) ct_par[a] = b; }
static int ct_ppar[MAXF]; static int ct_pfnd(int x) { while (ct_ppar[x] != x) x = ct_ppar[x] = ct_ppar[ct_ppar[x]]; return x; }
static cut_t cut_P(void) {
  cut_t out; memset(&out, 0, sizeof out);
  static long lk[MAXF * 4]; static int lp[MAXF * 4][6][2], lm[MAXF * 4], lc[MAXF][4][4], lmu[MAXF * 4]; int nl = 0;
  for (int p = 0; p < F; p++) { long Lk[4]; plaq_links(P[p], Lk); long s = P[p] / NPAIR; int k = (int)(P[p] % NPAIR); int a = PMU[k], c = PNU[k]; int b[4]; coords(s, b);
    memcpy(lc[p][0], b, sizeof b); memcpy(lc[p][1], b, sizeof b); lc[p][1][a]++; memcpy(lc[p][2], lc[p][1], sizeof b); lc[p][2][c]++; memcpy(lc[p][3], b, sizeof b); lc[p][3][c]++;
    for (int q = 0; q < 4; q++) { int idx = -1; for (int i = 0; i < nl; i++) if (lk[i] == Lk[q]) idx = i; if (idx < 0) { idx = nl++; lk[idx] = Lk[q]; lm[idx] = 0; lmu[idx] = (int)(Lk[q] % D); }
      if (lm[idx] >= 6) { out.ok = -1; return out; } lp[idx][lm[idx]][0] = p; lp[idx][lm[idx]][1] = q; lm[idx]++; } }
  int n2 = 0, nc = 0; static int clink[MAXF * 4];
  for (int i = 0; i < nl; i++) { if (lm[i] == 2) n2++; else if (lm[i] == 4 || lm[i] == 6) { clink[nc++] = i; if (lm[i] == 6) out.n6++; } else { out.ok = -1; return out; } }
  out.nc = nc;
  /* the corner classes of X_cut and the pieces: glued along the two-links only */
  for (int i = 0; i < F * 4; i++) ct_par[i] = i; for (int p = 0; p < F; p++) ct_ppar[p] = p;
  for (int i = 0; i < nl; i++) if (lm[i] == 2) { int p = lp[i][0][0], s = lp[i][0][1], q = lp[i][1][0], s2 = lp[i][1][1];
    for (int k = 0; k < 2; k++) { int cp = (s + k) % 4; for (int k2 = 0; k2 < 2; k2++) { int cq = (s2 + k2) % 4; if (!memcmp(lc[p][cp], lc[q][cq], sizeof(int) * 4)) ct_uni(p * 4 + cp, q * 4 + cq); } }
    { int a = ct_pfnd(p), b = ct_pfnd(q); if (a != b) ct_ppar[a] = b; } }
  int V = 0; for (int i = 0; i < F * 4; i++) if (ct_fnd(i) == i) V++;
  int E = n2; for (int j = 0; j < nc; j++) E += lm[clink[j]];
  out.chi = V - E + F;
  int m = 0; static int proot[MAXF], pidx[MAXF]; for (int p = 0; p < F; p++) { int r = ct_pfnd(p), id = -1; for (int t = 0; t < m; t++) if (proot[t] == r) id = t; if (id < 0) { id = m++; proot[id] = r; } pidx[p] = id; }
  out.m = m;
  /* minimality by the rank of the pieces' odd-sets over the contact links (mod 2) */
  { static unsigned char M[MAXF][MAXF * 4]; for (int t = 0; t < m; t++) for (int j = 0; j < nc; j++) M[t][j] = 0;
    for (int j = 0; j < nc; j++) { int i = clink[j]; for (int a = 0; a < lm[i]; a++) M[pidx[lp[i][a][0]]][j] ^= 1; }
    int rank = 0; for (int j = 0; j < nc && rank < m; j++) { int piv = -1; for (int t = rank; t < m; t++) if (M[t][j]) { piv = t; break; } if (piv < 0) continue;
      if (piv != rank) for (int c = 0; c < nc; c++) { unsigned char x = M[piv][c]; M[piv][c] = M[rank][c]; M[rank][c] = x; }
      for (int t = 0; t < m; t++) if (t != rank && M[t][j]) for (int c = 0; c < nc; c++) M[t][c] ^= M[rank][c]; rank++; }
    out.minimal = (rank == m - 1); }
  /* the boundary circles: the free sides, two at every boundary corner class */
  static int sp[MAXF * 6], ss[MAXF * 6], sA[MAXF * 6], sB[MAXF * 6]; int ns = 0;
  for (int j = 0; j < nc; j++) { int i = clink[j]; for (int a = 0; a < lm[i]; a++) { int p = lp[i][a][0], s = lp[i][a][1]; sp[ns] = p; ss[ns] = s; sA[ns] = ct_fnd(p * 4 + s); sB[ns] = ct_fnd(p * 4 + (s + 1) % 4); ns++; } }
  static int deg[MAXF * 4], adj[MAXF * 4][2]; for (int i = 0; i < F * 4; i++) deg[i] = 0;
  for (int t = 0; t < ns; t++) { int a = sA[t], b = sB[t]; if (deg[a] >= 2 || deg[b] >= 2) { out.ok = -2; return out; } adj[a][deg[a]++] = t; adj[b][deg[b]++] = t; }
  for (int t = 0; t < ns; t++) if (deg[sA[t]] != 2 || deg[sB[t]] != 2) { out.ok = -2; return out; }
  /* the lattice contact graph: its cycle rank, and the chord when r = 1 */
  static int ept[MAXF * 8][4]; static int epar[MAXF * 8]; int nep = 0; static int ends[MAXF * 4][2];
  for (int j = 0; j < nc; j++) { int i = clink[j]; int p = lp[i][0][0], s = lp[i][0][1];
    for (int k = 0; k < 2; k++) { const int *c = lc[p][(s + k) % 4]; int idx = -1; for (int t = 0; t < nep; t++) if (!memcmp(ept[t], c, sizeof(int) * 4)) idx = t; if (idx < 0) { idx = nep++; memcpy(ept[idx], c, sizeof(int) * 4); } ends[j][k] = idx; } }
  int r; { for (int t = 0; t < nep; t++) epar[t] = t; int comps = nep; for (int j = 0; j < nc; j++) { int a = ends[j][0], b = ends[j][1]; while (epar[a] != a) a = epar[a]; while (epar[b] != b) b = epar[b]; if (a != b) { epar[a] = b; comps--; } } r = nc - nep + comps; }
  out.r = r; if (r >= 2) { out.ok = -3; return out; }
  int chord = -1; if (r == 1) { for (int skip = 0; skip < nc && chord < 0; skip++) { for (int t = 0; t < nep; t++) epar[t] = t; int comps = nep; for (int j = 0; j < nc; j++) { if (j == skip) continue; int a = ends[j][0], b = ends[j][1]; while (epar[a] != a) a = epar[a]; while (epar[b] != b) b = epar[b]; if (a != b) { epar[a] = b; comps--; } } if ((nc - 1) - nep + comps == 0) chord = skip; } if (chord < 0) { out.ok = -4; return out; } }
  /* walk the circles; the winding of each about the chord */
  static int seen_s[MAXF * 6]; for (int t = 0; t < ns; t++) seen_s[t] = 0; int nb = 0; long long acc[CT_CJ], v[CT_CJ]; memset(acc, 0, sizeof acc); acc[0] = 1;
  for (int t0 = 0; t0 < ns; t0++) { if (seen_s[t0]) continue; int t = t0, from = sA[t0]; int w = 0; nb++;
    do { seen_s[t] = 1; int to = (sA[t] == from) ? sB[t] : sA[t]; int dir = (sA[t] == from) ? +1 : -1;   /* +1: walked from corner s to corner s+1 */
      if (chord >= 0) { int p = sp[t], s = ss[t]; long Lk[4]; plaq_links(P[p], Lk); if (Lk[s] == lk[clink[chord]]) { int mu = lmu[clink[chord]]; int g = (lc[p][(s + 1) % 4][mu] - lc[p][s][mu]) > 0 ? +1 : -1; w += dir * g; } }
      int nxt = (adj[to][0] == t) ? adj[to][1] : adj[to][0]; from = to; t = nxt; } while (t != t0);
    ct_chi_pow(r == 1 ? w : 0, v); ct_cg_mul(acc, v, acc); }
  out.nb = nb; out.I = acc[0];
  /* the sign: the cross-caps of the non-orientable pieces (orientations propagated across the two-links) */
  { static int ori[MAXF]; for (int p = 0; p < F; p++) ori[p] = 0; int nonor_piece[MAXF]; for (int t = 0; t < m; t++) nonor_piece[t] = 0;
    static int plinks[MAXF][4]; for (int p = 0; p < F; p++) { long Lk[4]; plaq_links(P[p], Lk); for (int q = 0; q < 4; q++) { int idx = -1; for (int i = 0; i < nl; i++) if (lk[i] == Lk[q]) idx = i; plinks[p][q] = idx; } }
    static int stack[MAXF]; for (int p0 = 0; p0 < F; p0++) { if (ori[p0]) continue; ori[p0] = 1; int sp2 = 0; stack[sp2++] = p0;
      while (sp2) { int p = stack[--sp2]; for (int q = 0; q < 4; q++) { int i = plinks[p][q]; if (lm[i] != 2) continue; int o = lp[i][0][0] == p ? 1 : 0; int qq = lp[i][o][0], s2 = lp[i][o][1]; int mu = lmu[i];
          int gp = (lc[p][(q + 1) % 4][mu] - lc[p][q][mu]) > 0 ? 1 : -1, gq = (lc[qq][(s2 + 1) % 4][mu] - lc[qq][s2][mu]) > 0 ? 1 : -1; int want = -ori[p] * gp * gq;
          if (!ori[qq]) { ori[qq] = want; stack[sp2++] = qq; } else if (ori[qq] != want) nonor_piece[pidx[p]] = 1; } } }
    int sign = 1; static int pchi[MAXF], pnb[MAXF]; for (int t = 0; t < m; t++) { pchi[t] = 0; pnb[t] = 0; }
    for (int p = 0; p < F; p++) pchi[pidx[p]]++; for (int i = 0; i < nl; i++) { if (lm[i] == 2) pchi[pidx[lp[i][0][0]]]--; else for (int a = 0; a < lm[i]; a++) pchi[pidx[lp[i][a][0]]]--; }
    for (int c = 0; c < F * 4; c++) if (ct_fnd(c) == c) pchi[pidx[c / 4]]++;
    for (int t0 = 0; t0 < ns; t0++) seen_s[t0] = 0; for (int t0 = 0; t0 < ns; t0++) { if (seen_s[t0]) continue; int t = t0, from = sA[t0]; pnb[pidx[sp[t0]]]++; do { seen_s[t] = 1; int to = (sA[t] == from) ? sB[t] : sA[t]; int nxt = (adj[to][0] == t) ? adj[to][1] : adj[to][0]; from = to; t = nxt; } while (t != t0); }
    for (int t = 0; t < m; t++) if (nonor_piece[t]) { out.nonor++; int k = 2 - (pchi[t] + pnb[t]); if (k & 1) sign = -sign; }
    out.S = sign * pow(2.0, out.chi) * (double)out.I; }
  out.ok = 1; return out; }
