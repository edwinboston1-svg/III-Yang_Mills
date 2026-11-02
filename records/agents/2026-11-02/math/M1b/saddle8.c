/* saddle8.c -- M1b (K6): a period-2 MIXED plaquette configuration with EVERY vertex a connected octagon saddle (a = 8, every link
   two-fold, star = ONE 8-cycle of K_{4,4})? Square e x f present iff g(class e, class f) = 1, class = (o, c, a): orientation h/v,
   perpendicular-coordinate parity, along-coordinate parity of the lower end. Rows (fixed e-class) and columns must be period-2
   2-factor patterns (degree 2 at every vertex parity); DFS over the 8 rows with column-prefix pruning; then the 16 vertex stars. */
#include <stdio.h>
static int cls(int o, int c, int a) { return o * 4 + c * 2 + a; }
static int okpat(int r) { for (int z = 0; z < 2; z++) for (int t = 0; t < 2; t++) { int d = (r >> cls(0, t, (z + 1) & 1) & 1) + (r >> cls(0, t, z) & 1) + (r >> cls(1, z, (t + 1) & 1) & 1) + (r >> cls(1, z, t) & 1); if (d != 2) return 0; } return 1; }
static int pat[256], np = 0, pref[9][256], ch[8], wit[8], havewit = 0; static long consistent = 0, good = 0, starfail[17];
static int star_components(int v) { int x = v & 1, y = v >> 1 & 1, z = v >> 2 & 1, t = v >> 3 & 1;
  int U[4] = {cls(0, y, x), cls(0, y, (x + 1) & 1), cls(1, x, y), cls(1, x, (y + 1) & 1)};
  int Wc[4] = {cls(0, t, z), cls(0, t, (z + 1) & 1), cls(1, z, t), cls(1, z, (t + 1) & 1)};
  int adj[8][8] = {{0}}; for (int a = 0; a < 4; a++) for (int b = 0; b < 4; b++) if (ch[U[a]] >> Wc[b] & 1) adj[a][4 + b] = adj[4 + b][a] = 1;
  int seen[8] = {0}, nc = 0; for (int s0 = 0; s0 < 8; s0++) if (!seen[s0]) { nc++; int st[8], sp = 0; st[sp++] = s0; seen[s0] = 1;
    while (sp) { int q = st[--sp]; for (int w = 0; w < 8; w++) if (adj[q][w] && !seen[w]) { seen[w] = 1; st[sp++] = w; } } }
  return nc; }
static void dfs(int i) {
  if (i == 8) { consistent++; int conn = 0; for (int v = 0; v < 16; v++) if (star_components(v) == 1) conn++; starfail[conn]++;
    if (conn == 16) { good++; if (!havewit) { havewit = 1; for (int q = 0; q < 8; q++) wit[q] = ch[q]; } } return; }
  for (int p = 0; p < np; p++) { ch[i] = pat[p]; int ok = 1;
    for (int k = 0; k < 8 && ok; k++) { int col = 0; for (int q = 0; q <= i; q++) col |= (ch[q] >> k & 1) << q; if (!pref[i + 1][col]) ok = 0; }
    if (ok) dfs(i + 1); } }
int main(void) {
  for (int r = 0; r < 256; r++) if (okpat(r)) { pat[np++] = r; for (int L = 1; L <= 8; L++) pref[L][r & ((1 << L) - 1)] = 1; }
  dfs(0);
  printf("ROW PATTERNS %d | CONSISTENT matrices %ld | ALL 16 STARS ONE 8-CYCLE: %ld\n", np, consistent, good);
  printf("histogram of #connected stars (of 16) over consistent matrices:"); for (int c = 0; c <= 16; c++) if (starfail[c]) printf(" %d:%ld", c, starfail[c]); printf("\n");
  if (havewit) { printf("WITNESS g (rows e-class h00 h01 h10 h11 v00 v01 v10 v11; columns f-class same order):\n");
    for (int i = 0; i < 8; i++) { printf("  %c%d%d:", i < 4 ? 'h' : 'v', i >> 1 & 1, i & 1); for (int k = 0; k < 8; k++) printf(" %d", wit[i] >> k & 1); printf("\n"); } }
  return 0; }
