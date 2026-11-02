/* tessfam.c -- M1b (K4): the tesseract constraint's ceiling family. In each plane A = H u H' u V (H_i = bd([-1,s+1] x [4i,4i+2]),
   H'_i = bd([-2,s+2] x [4i+1,4i+3]), V_k = bd([2k,2k+1] x [-1,s+1]); s = 0 mod 4), P = H (the even rows). R' = A x A (+) H x H.
   Pass 1 reads chi(R'); then a pinch-torus S of sizes (s1, s2) (even, minimal F_S with s1^2 s2^2 >= chi(R') - 3) is glued at the
   corner g = (-2, 1) of both planes, S's corner star {-e1,-e2} x {-e3,-e4} against R''s {+e1,+e2} x {+e3,+e4}.
   Reads as family.c: links even, plaquettes mixed, closed unit 3-cubes, V L F chi, skeleton components, G / G6 with b1, THEOREM I,
   every unit tesseract's facet graph under its missing squares; and the next-scale tori bd([x,x+1] x [4i+1,4i+3]) x bd(unit square).
   usage: tessfam.exe s */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
static int LO, W; static long long NPT;
static unsigned char *P, *LM; static int *UF; static int TP[4][4];
static long long collide = 0, outside = 0;
static long long idx(int x0, int x1, int x2, int x3) { return (((long long)(x0 - LO) * W + (x1 - LO)) * W + (x2 - LO)) * W + (x3 - LO); }
static int inb(int x) { return x >= LO && x < LO + W; }
static void toggle(int *p, int i, int j) {
  for (int q = 0; q < 4; q++) if (!inb(p[q]) || ((q == i || q == j) && !inb(p[q] + 1))) { outside++; return; }
  long long k = idx(p[0], p[1], p[2], p[3]); int t = TP[i][j];
  if (P[k] >> t & 1) collide++;
  P[k] ^= (unsigned char)(1 << t); }
typedef struct { int x, y, d; } Ed;
static int rect(Ed *e, int x0, int x1, int y0, int y1, int tx, int ty) {
  int c = 0;
  for (int x = x0; x < x1; x++) { e[c++] = (Ed){x + tx, y0 + ty, 0}; e[c++] = (Ed){x + tx, y1 + ty, 0}; }
  for (int y = y0; y < y1; y++) { e[c++] = (Ed){x0 + tx, y + ty, 1}; e[c++] = (Ed){x1 + tx, y + ty, 1}; }
  return c; }
static void prod(Ed *a, int na, Ed *b, int nb) {
  for (int i = 0; i < na; i++) for (int j = 0; j < nb; j++) { int p[4] = {a[i].x, a[i].y, b[j].x, b[j].y}; toggle(p, a[i].d, 2 + b[j].d); } }
static int fnd(int x) { while (UF[x] != x) { UF[x] = UF[UF[x]]; x = UF[x]; } return x; }
static void decode(long long k, int *c) { long long r = k; for (int q = 3; q >= 0; q--) { c[q] = (int)(r % W) + LO; r /= W; } }
static long long F, L, odd, N4, N6, Nhi, Vx, sum8a, nonmixed, comp[3], verts[3], edges[3];
static void census(void) {
  memset(LM, 0, NPT * 4); F = 0; nonmixed = 0;
  for (long long k = 0; k < NPT; k++) if (P[k]) { int c[4]; decode(k, c);
    for (int i = 0; i < 4; i++) for (int j = i + 1; j < 4; j++) if (P[k] >> TP[i][j] & 1) {
      F++; if (!(i < 2 && j >= 2)) nonmixed++;
      int c2[4]; memcpy(c2, c, sizeof c2); LM[idx(c2[0], c2[1], c2[2], c2[3]) * 4 + i]++; LM[idx(c2[0], c2[1], c2[2], c2[3]) * 4 + j]++;
      c2[j]++; LM[idx(c2[0], c2[1], c2[2], c2[3]) * 4 + i]++; c2[j]--; c2[i]++; LM[idx(c2[0], c2[1], c2[2], c2[3]) * 4 + j]++; } }
  L = odd = N4 = N6 = Nhi = 0;
  for (long long k = 0; k < NPT * 4; k++) if (LM[k]) { L++; if (LM[k] & 1) odd++; if (LM[k] == 4) N4++; else if (LM[k] == 6) N6++; else if (LM[k] > 6) Nhi++; }
  Vx = 0; sum8a = 0;
  for (long long k = 0; k < NPT; k++) { int c[4]; decode(k, c); int a = 0;
    for (int d = 0; d < 4; d++) { if (LM[k * 4 + d]) a++; if (inb(c[d] - 1)) { int c2[4]; memcpy(c2, c, sizeof c2); c2[d]--; if (LM[idx(c2[0], c2[1], c2[2], c2[3]) * 4 + d]) a++; } }
    if (a) { Vx++; sum8a += 8 - a; } }
  for (int pass = 0; pass < 3; pass++) { int thr = pass == 0 ? 1 : (pass == 1 ? 4 : 6);
    for (long long k = 0; k < NPT; k++) UF[k] = (int)k;
    unsigned char *isv = calloc(NPT, 1); long long ne = 0;
    for (long long k = 0; k < NPT; k++) for (int d = 0; d < 4; d++) { int mu = LM[k * 4 + d]; if (mu >= thr && (pass != 2 || mu == 6)) {
      int c[4]; decode(k, c); c[d]++; long long k2 = idx(c[0], c[1], c[2], c[3]); isv[k] = 1; isv[k2] = 1; ne++;
      int a = fnd((int)k), b = fnd((int)k2); if (a != b) UF[a] = b; } }
    long long nv = 0, nc = 0; for (long long k = 0; k < NPT; k++) if (isv[k]) { nv++; if (fnd((int)k) == (int)k) nc++; }
    comp[pass] = nc; verts[pass] = nv; edges[pass] = ne; free(isv); } }
static int has(int *c, int i, int j) { for (int q = 0; q < 4; q++) if (!inb(c[q])) return 0; return P[idx(c[0], c[1], c[2], c[3])] >> TP[i][j] & 1; }
int main(int argc, char **argv) {
  int s = argc > 1 ? atoi(argv[1]) : 8; if (s < 4 || s % 4) { printf("REFUSED: s must be a positive multiple of 4\n"); return 1; }
  LO = -((5 * s) / 4 + 2) - 7; W = (s + 4) - LO + 1; NPT = (long long)W * W * W * W;
  int t = 0; for (int i = 0; i < 4; i++) for (int j = i + 1; j < 4; j++) TP[i][j] = t++;
  P = calloc(NPT, 1); LM = calloc(NPT * 4, 1); UF = malloc(sizeof(int) * NPT);
  if (!P || !LM || !UF) { printf("REFUSED: memory\n"); return 1; }
  /* the plane graph A and P = H */
  Ed *A = malloc(sizeof(Ed) * 64 * (s + 8) * (s + 8)), *Hs = malloc(sizeof(Ed) * 32 * (s + 8) * (s + 8)); int nA = 0, nHs = 0;
  for (int i = 0; 4 * i + 2 <= s - 2; i++) { int c = rect(A + nA, -1, s + 1, 4 * i, 4 * i + 2, 0, 0); memcpy(Hs + nHs, A + nA, sizeof(Ed) * c); nA += c; nHs += c; }
  for (int i = 0; 4 * i + 3 <= s - 1; i++) nA += rect(A + nA, -2, s + 2, 4 * i + 1, 4 * i + 3, 0, 0);
  for (int k = 0; 2 * k + 1 <= s - 1; k++) nA += rect(A + nA, 2 * k, 2 * k + 1, -1, s + 1, 0, 0);
  prod(A, nA, A, nA); long long c1 = collide; prod(Hs, nHs, Hs, nHs); long long c2 = collide - c1;
  census(); long long chiR = Vx - L + F, FR = F;
  printf("R' s=%d box W=%d: |A|=%d |H|=%d collisions(A x A)=%lld removals(H x H)=%lld outside=%lld | F=%lld L=%lld V=%lld chi=%lld odd=%lld N4=%lld N6=%lld\n",
         s, W, nA, nHs, c1, c2, outside, F, L, Vx, chiR, odd, N4, N6);
  /* choose S */
  int bs1 = 0, bs2 = 0; long long bF = -1;
  for (int s1 = 2; s1 <= (5 * s) / 4 + 2; s1 += 2) for (int s2 = 2; s2 <= (5 * s) / 4 + 2; s2 += 2) {
    long long pin = (long long)s1 * s1 * s2 * s2; if (pin < chiR - 3) continue;
    long long FS = 2LL * (s1 * (long long)s1 + 3 * s1) * (s2 * (long long)s2 + 3 * s2); if (bF < 0 || FS < bF) { bF = FS; bs1 = s1; bs2 = s2; } }
  if (bF < 0) { printf("REFUSED: no S within sizes <= s balances chi=%lld\n", chiR); return 1; }
  int sz[2] = {bs1, bs2}; Ed *Hp[2][64], *Vp[2][64]; int nHp[2][64], nVp[2][64];
  for (int pl = 0; pl < 2; pl++) { int q = sz[pl], tx = -q - 3, ty = 2 - q;
    for (int i = 0; i < q / 2; i++) { Hp[pl][i] = malloc(sizeof(Ed) * (4 * q + 16)); nHp[pl][i] = rect(Hp[pl][i], -1, q + 1, 2 * i, 2 * i + 1, tx, ty);
      Vp[pl][i] = malloc(sizeof(Ed) * (4 * q + 16)); nVp[pl][i] = rect(Vp[pl][i], 2 * i, 2 * i + 1, -1, q + 1, tx, ty); } }
  long long cb = collide;
  for (int i = 0; i < bs1 / 2; i++) for (int j = 0; j < bs2 / 2; j++) { prod(Hp[0][i], nHp[0][i], Hp[1][j], nHp[1][j]); prod(Vp[0][i], nVp[0][i], Vp[1][j], nVp[1][j]); }
  printf("S sizes (%d, %d): pinches=%lld F_S(closed form)=%lld collisions(S onto R')=%lld outside=%lld\n", bs1, bs2, (long long)bs1 * bs1 * bs2 * bs2, bF, collide - cb, outside);
  /* M1b K8: resolve S's pinches into connected octagon saddles, W x W with W = unit squares [2i+1,2i+2] x [2j,2j+1] per plane */
  { Ed *Wp[2][4096]; int nWp[2] = {0, 0}, nWe[2][4096];
    for (int pl = 0; pl < 2; pl++) { int q = sz[pl], tx = -q - 3, ty = 2 - q;
      for (int i = -1; i <= q / 2 - 1; i++) for (int j = 0; j <= q / 2 - 1; j++) { Wp[pl][nWp[pl]] = malloc(sizeof(Ed) * 4); nWe[pl][nWp[pl]] = rect(Wp[pl][nWp[pl]], 2 * i + 1, 2 * i + 2, 2 * j, 2 * j + 1, tx, ty); nWp[pl]++; } }
    if (getenv("NOW") == NULL) for (int a = 0; a < nWp[0]; a++) for (int b = 0; b < nWp[1]; b++) prod(Wp[0][a], nWe[0][a], Wp[1][b], nWe[1][b]); }
  census(); long long chi = Vx - L + F;
  { long long Pexc = 0, pinchv = 0, saddle8 = 0;
    for (long long k = 0; k < NPT; k++) { int c[4]; decode(k, c); int adj[8][8]; memset(adj, 0, sizeof adj); int deg[8] = {0}, dd = 0;
      for (int i = 0; i < 4; i++) for (int j = i + 1; j < 4; j++) for (int si = 0; si < 2; si++) for (int sj = 0; sj < 2; sj++) {
        int c2[4]; memcpy(c2, c, sizeof c2); c2[i] -= si; c2[j] -= sj; if (has(c2, i, j)) { int ha = 2 * i + si, hb = 2 * j + sj; adj[ha][hb] = adj[hb][ha] = 1; deg[ha]++; deg[hb]++; dd++; } }
      if (!dd) continue; int seen[8] = {0}, nc = 0, isc = 0;
      for (int h0 = 0; h0 < 8; h0++) if (deg[h0] && !seen[h0]) { nc++; int st[8], sp = 0; st[sp++] = h0; seen[h0] = 1; while (sp) { int q = st[--sp]; for (int w = 0; w < 8; w++) if (adj[q][w] && !seen[w]) { seen[w] = 1; st[sp++] = w; } } }
      if (nc > 1) { Pexc += nc - 1; pinchv++; }
      if (nc == 1 && dd == 8) { isc = 1; for (int h0 = 0; h0 < 8; h0++) if (deg[h0] != 2) isc = 0; } saddle8 += isc; }
    printf("PINCH COUNT P=%lld (vertices with a disconnected star: %lld; connected octagon saddles: %lld) | chi=%lld, 2 - P=%lld -> %s\n",
           Pexc, pinchv, saddle8, chi, 2 - Pexc, chi <= 2 - Pexc ? "PINCH INEQUALITY HOLDS (chi <= 2 - P)" : "PINCH INEQUALITY FAILS"); }
  long long b1G = edges[1] - verts[1] + comp[1], b1G6 = edges[2] - verts[2] + comp[2], Q = b1G + b1G6;
  printf("X' PLAQUETTES F=%lld (R' %lld + S %lld) nonmixed=%lld | LINKS L=%lld odd=%lld N4=%lld N6=%lld N>6=%lld | V=%lld chi=%lld\n", F, FR, F - FR, nonmixed, L, odd, N4, N6, Nhi, Vx, chi);
  printf("SKELETON components=%lld | G: E=%lld V=%lld c=%lld b1=%lld | G6: E=%lld b1=%lld | Q=%lld Q/F=%.6f (10/21=%.6f)\n", comp[0], edges[1], verts[1], comp[1], b1G, edges[2], b1G6, Q, (double)Q / F, 10.0 / 21);
  long long lhs = 4 * F + 8 - 8 * Q, rhs = 6 * edges[1] - 8 * b1G + 6 * N6 - 8 * b1G6 + 8 * (2 - chi) + sum8a - 8;
  printf("THEOREM I (x8): lhs=%lld rhs=%lld -> %s\n", lhs, rhs, lhs == rhs ? "MET" : "PARTED");
  /* closed unit 3-cubes */
  long long closed = 0;
  for (long long k = 0; k < NPT; k++) if (P[k]) { int c[4]; decode(k, c);
    for (int i = 0; i < 4; i++) for (int j = i + 1; j < 4; j++) for (int l = j + 1; l < 4; l++) { int ok = 1, dd[3] = {i, j, l};
      for (int f = 0; f < 3 && ok; f++) { int u = dd[(f + 1) % 3], v = dd[(f + 2) % 3], w = dd[f]; if (u > v) { int z = u; u = v; v = z; }
        for (int sh = 0; sh < 2 && ok; sh++) { int c2[4]; memcpy(c2, c, sizeof c2); c2[w] += sh; if (!has(c2, u, v)) ok = 0; } }
      if (ok) closed++; } }
  /* every unit tesseract */
  long long tess = 0, tcyc = 0;
  for (long long k = 0; k < NPT; k++) { int c[4]; decode(k, c); int okb = 1; for (int q = 0; q < 4; q++) if (!inb(c[q] + 1)) okb = 0; if (!okb) continue;
    int any = 0, par[8]; for (int q = 0; q < 8; q++) par[q] = q;
    for (int i = 0; i < 4; i++) for (int j = i + 1; j < 4; j++) { int kk = -1, ll = -1; for (int q = 0; q < 4; q++) if (q != i && q != j) { if (kk < 0) kk = q; else ll = q; }
      for (int e1 = 0; e1 < 2; e1++) for (int e2 = 0; e2 < 2; e2++) { int c2[4]; memcpy(c2, c, sizeof c2); c2[kk] += e1; c2[ll] += e2;
        if (has(c2, i, j)) { any = 1; continue; }
        int a = 2 * kk + e1, b = 2 * ll + e2; while (par[a] != a) a = par[a]; while (par[b] != b) b = par[b]; if (a != b) par[a] = b; } }
    if (!any) continue; tess++; int nc = 0; for (int q = 0; q < 8; q++) if (par[q] == q) nc++; if (nc > 1) tcyc++; }
  printf("CUBES closed unit 3-cubes = %lld | TESSERACTS with an X-plaquette=%lld, carrying a closed subset=%lld\n", closed, tess, tcyc);
  /* the next scale: C1 = bd([x,x+1] x [y,y+2]) in plane 12 (y odd), C2 = bd(unit square [z,z+1] x [w,w+1]) in plane 34 */
  long long nt = 0;
  for (int x = LO; x < LO + W - 2; x++) for (int y = LO; y < LO + W - 3; y++) for (int z = LO; z < LO + W - 2; z++) for (int w = LO; w < LO + W - 2; w++) {
    Ed c1e[6] = {{x, y, 0}, {x, y + 2, 0}, {x, y, 1}, {x, y + 1, 1}, {x + 1, y, 1}, {x + 1, y + 1, 1}};
    Ed c2e[4] = {{z, w, 0}, {z, w + 1, 0}, {z, w, 1}, {z + 1, w, 1}}; int ok = 1;
    for (int a = 0; a < 6 && ok; a++) for (int b = 0; b < 4 && ok; b++) { int p[4] = {c1e[a].x, c1e[a].y, c2e[b].x, c2e[b].y}; if (!has(p, c1e[a].d, 2 + c2e[b].d)) ok = 0; }
    if (ok) nt++; }
  printf("NEXT SCALE: closed 24-square tori bd(1x2) x bd(1x1) inside X' = %lld\n", nt);
  return 0;
}
