/* stars.c -- M1b (K1): census of the even stars of the octahedral graph K_{2,2,2,2} (the link graph of a vertex of Z^4).
   Half-axes h = 2*axis + (sign<0), axis 0..3; an edge = a plaquette at the vertex = a pair of non-opposite half-axes (24 of them).
   For every edge subset with all degrees even (a star of an even plaquette set) it records a, d, n4, n6, the triangle count, the
   zero-deficit kind (alpha: a=8 all deg 2; beta: a=8 all deg 4; gamma: a=8 all deg 6) and checks THEOREM I's per-vertex identity
   3e - 2K + (8 - a) = d (e = n4 + 2 n6, K = d - 2a + 4) and d - a = e on every star. Triangle-free beta stars are printed. */
#include <stdio.h>
int main(void) {
  int E1[24], E2[24], ne = 0;
  for (int a = 0; a < 8; a++) for (int b = a + 1; b < 8; b++) if (a / 2 != b / 2) { E1[ne] = a; E2[ne] = b; ne++; }
  long cnt = 0, kind[3] = {0, 0, 0}, tfk[3] = {0, 0, 0}, tf = 0, idfail = 0, gamma_tri = -1;
  long cyc[3] = {0, 0, 0}, tfcyc[3] = {0, 0, 0};   /* alpha cycle types: 3+5, 4+4, 8 */
  for (long S = 1; S < (1L << 24); S++) {
    int deg[8] = {0};
    for (int e = 0; e < 24; e++) if (S >> e & 1) { deg[E1[e]]++; deg[E2[e]]++; }
    int ok = 1; for (int v = 0; v < 8; v++) if (deg[v] & 1) { ok = 0; break; }
    if (!ok) continue;
    cnt++;
    int a = 0, d = 0, n4 = 0, n6 = 0;
    for (int v = 0; v < 8; v++) { if (deg[v]) a++; if (deg[v] == 4) n4++; if (deg[v] == 6) n6++; d += deg[v]; }
    d /= 2;
    int e_ = n4 + 2 * n6, K = d - 2 * a + 4;
    if (3 * e_ - 2 * K + (8 - a) != d) idfail++;
    if (d - a != e_) idfail++;
    int adj[8][8] = {{0}};
    for (int e = 0; e < 24; e++) if (S >> e & 1) adj[E1[e]][E2[e]] = adj[E2[e]][E1[e]] = 1;
    int tri = 0;
    for (int x = 0; x < 8; x++) for (int y = x + 1; y < 8; y++) if (adj[x][y]) for (int z = y + 1; z < 8; z++) if (adj[x][z] && adj[y][z]) tri++;
    if (!tri) tf++;
    int k = -1;
    if (a == 8) { int all2 = 1, all4 = 1, all6 = 1;
      for (int v = 0; v < 8; v++) { if (deg[v] != 2) all2 = 0; if (deg[v] != 4) all4 = 0; if (deg[v] != 6) all6 = 0; }
      if (all2) k = 0; else if (all4) k = 1; else if (all6) k = 2; }
    if (k < 0) continue;
    kind[k]++; if (!tri) tfk[k]++;
    if (k == 2) gamma_tri = tri;
    if (k == 1 && !tri) { printf("TRIANGLE-FREE beta star:"); for (int e = 0; e < 24; e++) if (S >> e & 1) printf(" %c%d%c%d", (E1[e] & 1) ? '-' : '+', E1[e] / 2 + 1, (E2[e] & 1) ? '-' : '+', E2[e] / 2 + 1); printf("\n"); }
    if (k == 0) {   /* cycle type of the 2-factor */
      int seen[8] = {0}, lens[8], nl = 0;
      for (int v = 0; v < 8; v++) if (!seen[v]) { int len = 0, cur = v;
        while (cur >= 0) { seen[cur] = 1; len++; int nx = -1; for (int w = 0; w < 8; w++) if (adj[cur][w] && !seen[w]) { nx = w; break; } cur = nx; }
        lens[nl++] = len; }
      int t = (nl == 1) ? 2 : ((nl == 2 && lens[0] == 4) ? 1 : ((nl == 2) ? 0 : -1));
      if (t >= 0) { cyc[t]++; if (!tri) tfcyc[t]++; } else printf("UNEXPECTED alpha cycle structure\n");
    }
  }
  printf("STARS even nonempty = %ld (expect 131071)\n", cnt);
  printf("IDENTITY 3e-2K+(8-a)=d and d-a=e: failures = %ld\n", idfail);
  printf("TRIANGLE-FREE even stars = %ld\n", tf);
  printf("KIND alpha (2-factors) = %ld, triangle-free %ld; cycle types 3+5: %ld (tf %ld), 4+4: %ld (tf %ld), 8: %ld (tf %ld)\n", kind[0], tfk[0], cyc[0], tfcyc[0], cyc[1], tfcyc[1], cyc[2], tfcyc[2]);
  printf("KIND beta (4-regular spanning) = %ld, triangle-free %ld\n", kind[1], tfk[1]);
  printf("KIND gamma (full star) = %ld, its triangles = %ld\n", kind[2], gamma_tri);
  return 0;
}
