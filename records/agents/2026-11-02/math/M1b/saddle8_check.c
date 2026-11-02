/* saddle8_check.c -- second road for saddle8.c's witness: M(e,f) = G(o_e, a_e; o_f, a_f), G rows/cols (h0,h1,v0,v1):
   h0: 1100, h1: 1010, v0: 0101, v1: 0011 (o = orientation, a = parity of the along-coordinate of the edge's lower end).
   Built square by square on the torus T^4_n (n = 4, 6), coordinates explicit; reads every link multiplicity and every vertex star's
   size and number of components directly from the squares (no class bookkeeping). */
#include <stdio.h>
#include <string.h>
static int n; static int G[4][4] = {{1,1,0,0},{1,0,1,0},{0,1,0,1},{0,0,1,1}};
static unsigned char sqr[6][8][8][8][8]; /* [type 0..3 mixed: (0,2),(0,3),(1,2),(1,3)] lower corner */
int main(void) { for (n = 4; n <= 6; n += 2) { memset(sqr, 0, sizeof sqr);
  int TI[4] = {0, 0, 1, 1}, TJ[4] = {2, 3, 2, 3}; long F = 0;
  for (int t = 0; t < 4; t++) for (int x0 = 0; x0 < n; x0++) for (int x1 = 0; x1 < n; x1++) for (int x2 = 0; x2 < n; x2++) for (int x3 = 0; x3 < n; x3++) {
    int c[4] = {x0, x1, x2, x3}, i = TI[t], j = TJ[t];
    int oe = i, ae = c[i] & 1, of = j - 2, af = c[j] & 1;   /* e along direction i (0 = h, 1 = v), lower-end along-coordinate c[i] */
    if (G[oe * 2 + ae][of * 2 + af]) { sqr[t][x0][x1][x2][x3] = 1; F++; } }
  long badlink = 0, badstar = 0, verts = 0; int multh[16] = {0};
  for (int x0 = 0; x0 < n; x0++) for (int x1 = 0; x1 < n; x1++) for (int x2 = 0; x2 < n; x2++) for (int x3 = 0; x3 < n; x3++) {
    int v[4] = {x0, x1, x2, x3}; int adj[8][8]; memset(adj, 0, sizeof adj); int deg[8] = {0};
    /* squares at v: type t (i,j), signs si, sj: lower corner v - [si<0] e_i - [sj<0] e_j; half-axis index 2*dir + (sign<0) */
    for (int t = 0; t < 4; t++) for (int si = 0; si < 2; si++) for (int sj = 0; sj < 2; sj++) { int i = TI[t], j = TJ[t], c[4]; memcpy(c, v, sizeof c);
      if (si) c[i] = (c[i] + n - 1) % n; if (sj) c[j] = (c[j] + n - 1) % n;
      if (sqr[t][c[0]][c[1]][c[2]][c[3]]) { int a = 2 * i + si, b = 2 * j + sj; adj[a][b] = adj[b][a] = 1; deg[a]++; deg[b]++; } }
    verts++; int d = 0; for (int h = 0; h < 8; h++) { if (deg[h] != 2) badlink++; d += deg[h]; } d /= 2;
    int seen[8] = {0}, st[8], sp = 0, cnt = 0; st[sp++] = 0; seen[0] = 1; while (sp) { int q = st[--sp]; cnt++; for (int w = 0; w < 8; w++) if (adj[q][w] && !seen[w]) { seen[w] = 1; st[sp++] = w; } }
    if (cnt != 8 || d != 8) badstar++; if (d < 16) multh[d]++; }
  printf("TORUS n=%d: F=%ld (2n^4=%ld) vertices=%ld half-axes not two-fold=%ld stars not ONE 8-cycle=%ld chi=V-L+F=%ld (-n^4=%ld)\n",
         n, F, 2L * n * n * n * n, verts, badlink, badstar, verts - 4L * n * n * n * n + F, -1L * n * n * n * n); }
  return 0; }
