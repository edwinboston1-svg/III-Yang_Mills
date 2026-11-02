/* family.c -- M1b (K2, K3): THEOREM C's family X_m = R_m u S_m in Z^4, built cell by cell and read by machine.
   R_m = A x A (A = checkerboard graph of the m x m square, plane 12 x plane 34), S_m = flat tori H_i x D_j, V_k x D'_l crossing at
   pinches, translated so that R and S share exactly one vertex (the origin). Reads: every link even; every plaquette mixed; closed
   unit 3-cubes by direct enumeration; V, L, F, chi; G (multiplicity >= 4), G6 (= 6) with b1 by union-find; components of X's
   1-skeleton; sum_v (8 - a_v); THEOREM I's identity both sides; and every unit tesseract: the components of its facet graph under its
   MISSING squares (more than one component <=> X n T contains a closed subset), with the torus pattern counted.
   usage: family.exe m   (m odd >= 3) */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
static int m, s, LO, W;
static unsigned char *P;      /* plaquette bits: type t = 0..5 for direction pairs (0,1),(0,2),(0,3),(1,2),(1,3),(2,3) */
static unsigned char *LM;     /* link multiplicity, 4 per point */
static int *UF;
static long long NPT;
static int TP[4][4];
static long long idx(int x0, int x1, int x2, int x3) { return (((long long)(x0 - LO) * W + (x1 - LO)) * W + (x2 - LO)) * W + (x3 - LO); }
static int inb(int x) { return x >= LO && x < LO + W; }
static long long collide = 0, outside = 0;
static void toggle(int *p, int i, int j) {   /* plaquette with lower corner p spanning directions i < j */
  for (int q = 0; q < 4; q++) if (!inb(p[q]) || (q == i || q == j ? !inb(p[q] + 1) : 0)) { outside++; return; }
  long long k = idx(p[0], p[1], p[2], p[3]); int t = TP[i][j];
  if (P[k] >> t & 1) collide++;
  P[k] ^= (unsigned char)(1 << t);
}
/* plane edges: (x, y, d) d = 0 along the first axis of the plane, 1 along the second */
typedef struct { int x, y, d; } Ed;
static Ed *mkA(int *n) {   /* checkerboard: boundaries of squares (x, y), x + y even, 0 <= x, y < m */
  Ed *e = malloc(sizeof(Ed) * 4 * m * m); int c = 0;
  for (int x = 0; x < m; x++) for (int y = 0; y < m; y++) if ((x + y) % 2 == 0) {
    e[c++] = (Ed){x, y, 0}; e[c++] = (Ed){x, y + 1, 0}; e[c++] = (Ed){x, y, 1}; e[c++] = (Ed){x + 1, y, 1}; }
  *n = c; return e; }
static int rect(Ed *e, int x0, int x1, int y0, int y1, int tx, int ty) {   /* boundary of [x0,x1] x [y0,y1], translated */
  int c = 0;
  for (int x = x0; x < x1; x++) { e[c++] = (Ed){x + tx, y0 + ty, 0}; e[c++] = (Ed){x + tx, y1 + ty, 0}; }
  for (int y = y0; y < y1; y++) { e[c++] = (Ed){x0 + tx, y + ty, 1}; e[c++] = (Ed){x1 + tx, y + ty, 1}; }
  return c; }
static void prod(Ed *a, int na, Ed *b, int nb) {   /* a in plane (0,1), b in plane (2,3) */
  for (int i = 0; i < na; i++) for (int j = 0; j < nb; j++) { int p[4] = {a[i].x, a[i].y, b[j].x, b[j].y}; toggle(p, a[i].d, 2 + b[j].d); } }
static int fnd(int x) { while (UF[x] != x) { UF[x] = UF[UF[x]]; x = UF[x]; } return x; }
static int link_present(long long k, int dir) { return LM[k * 4 + dir] > 0; }
int main(int argc, char **argv) {
  m = argc > 1 ? atoi(argv[1]) : 5; if (m < 3 || m % 2 == 0) { printf("REFUSED: m must be odd >= 3\n"); return 1; }
  s = argc > 2 ? atoi(argv[2]) : m - 1; if (s < 2 || s % 2) { printf("REFUSED: s must be even >= 2\n"); return 1; } LO = -(s + 4); W = (m + 2) - LO + 1; NPT = (long long)W * W * W * W;
  int t = 0; for (int i = 0; i < 4; i++) for (int j = i + 1; j < 4; j++) TP[i][j] = t++;
  P = calloc(NPT, 1); LM = calloc(NPT * 4, 1); UF = malloc(sizeof(int) * NPT);
  if (!P || !LM || !UF) { printf("REFUSED: memory\n"); return 1; }
  int nA; Ed *A = mkA(&nA);
  prod(A, nA, A, nA);   /* R_m */
  /* S_m: H_i = [-1, s+1] x [2i, 2i+1], V_k = [2k, 2k+1] x [-1, s+1], i, k < s/2, translated by (-(s+1), -(s-1)) in each plane */
  int tx = -(s + 1), ty = -(s - 1), nh = s / 2;
  Ed **H = malloc(sizeof(Ed *) * nh), **V = malloc(sizeof(Ed *) * nh); int *nH = malloc(sizeof(int) * nh), *nV = malloc(sizeof(int) * nh);
  for (int i = 0; i < nh; i++) { H[i] = malloc(sizeof(Ed) * (4 * s + 16)); nH[i] = rect(H[i], -1, s + 1, 2 * i, 2 * i + 1, tx, ty);
    V[i] = malloc(sizeof(Ed) * (4 * s + 16)); nV[i] = rect(V[i], 2 * i, 2 * i + 1, -1, s + 1, tx, ty); }
  for (int i = 0; i < nh; i++) for (int j = 0; j < nh; j++) { prod(H[i], nH[i], H[j], nH[j]); prod(V[i], nV[i], V[j], nV[j]); }
  /* M1b K7: the connected-saddle resolution W x W, W = unit squares [2i+1, 2i+2] x [2j, 2j+1] (i = -1 .. s/2-1, j = 0 .. s/2-1), translated */
  int nw = 0; Ed **Wq = malloc(sizeof(Ed *) * (s + 4) * (s + 4)); int *nWq = malloc(sizeof(int) * (s + 4) * (s + 4));
  for (int i = -1; i <= s / 2 - 1; i++) for (int j = 0; j <= s / 2 - 1; j++) { Wq[nw] = malloc(sizeof(Ed) * 4); nWq[nw] = rect(Wq[nw], 2 * i + 1, 2 * i + 2, 2 * j, 2 * j + 1, tx, ty); nw++; }
  if (getenv("NOW") == NULL) for (int a = 0; a < nw; a++) for (int b = 0; b < nw; b++) prod(Wq[a], nWq[a], Wq[b], nWq[b]);
  /* link multiplicities and plaquette census */
  long long F = 0, nonmixed = 0;
  for (long long k = 0; k < NPT; k++) if (P[k]) {
    long long r = k; int c[4]; for (int q = 3; q >= 0; q--) { c[q] = (int)(r % W) + LO; r /= W; }
    for (int i = 0; i < 4; i++) for (int j = i + 1; j < 4; j++) if (P[k] >> TP[i][j] & 1) {
      F++; if (!((i < 2) && (j >= 2))) nonmixed++;
      int c2[4]; memcpy(c2, c, sizeof c2); LM[idx(c2[0], c2[1], c2[2], c2[3]) * 4 + i]++; LM[idx(c2[0], c2[1], c2[2], c2[3]) * 4 + j]++;
      c2[j]++; LM[idx(c2[0], c2[1], c2[2], c2[3]) * 4 + i]++; c2[j]--; c2[i]++; LM[idx(c2[0], c2[1], c2[2], c2[3]) * 4 + j]++; } }
  long long L = 0, odd = 0, N4 = 0, N6 = 0, Nhi = 0;
  for (long long k = 0; k < NPT * 4; k++) if (LM[k]) { L++; if (LM[k] & 1) odd++; if (LM[k] == 4) N4++; else if (LM[k] == 6) N6++; else if (LM[k] > 6) Nhi++; }
  /* vertices, a_v, sum (8 - a_v) */
  long long Vx = 0, sum8a = 0;
  for (long long k = 0; k < NPT; k++) {
    long long r = k; int c[4]; for (int q = 3; q >= 0; q--) { c[q] = (int)(r % W) + LO; r /= W; }
    int a = 0; for (int d = 0; d < 4; d++) { if (LM[k * 4 + d]) a++; if (inb(c[d] - 1)) { int c2[4]; memcpy(c2, c, sizeof c2); c2[d]--; if (LM[idx(c2[0], c2[1], c2[2], c2[3]) * 4 + d]) a++; } }
    if (a) { Vx++; sum8a += 8 - a; } }
  long long chi = Vx - L + F;
  /* M1b K7: THE PINCH COUNT P = sum_v (components of the star L_v - 1); for Z2-minimal X, b1(X) >= P, so chi <= 2 - P */
  long long Pexc = 0, saddle8 = 0, pinchv = 0;
  for (long long k = 0; k < NPT; k++) {
    long long r = k; int c[4]; for (int q = 3; q >= 0; q--) { c[q] = (int)(r % W) + LO; r /= W; }
    int adj[8][8]; memset(adj, 0, sizeof adj); int deg[8] = {0}, dd = 0;
    for (int i = 0; i < 4; i++) for (int j = i + 1; j < 4; j++) for (int si = 0; si < 2; si++) for (int sj = 0; sj < 2; sj++) {
      int c2[4]; memcpy(c2, c, sizeof c2); c2[i] -= si; c2[j] -= sj; int okc = 1; for (int q = 0; q < 4; q++) if (!inb(c2[q])) okc = 0; if (!okc) continue;
      if (P[idx(c2[0], c2[1], c2[2], c2[3])] >> TP[i][j] & 1) { int ha = 2 * i + si, hb = 2 * j + sj; adj[ha][hb] = adj[hb][ha] = 1; deg[ha]++; deg[hb]++; dd++; } }
    if (!dd) continue;
    int seen[8] = {0}, nc = 0, isc = 0;
    for (int h0 = 0; h0 < 8; h0++) if (deg[h0] && !seen[h0]) { nc++; int st[8], sp = 0; st[sp++] = h0; seen[h0] = 1;
      while (sp) { int q = st[--sp]; for (int w = 0; w < 8; w++) if (adj[q][w] && !seen[w]) { seen[w] = 1; st[sp++] = w; } } }
    if (nc > 1) { Pexc += nc - 1; pinchv++; }
    if (nc == 1 && dd == 8) { isc = 1; for (int h0 = 0; h0 < 8; h0++) if (deg[h0] != 2) isc = 0; } saddle8 += isc; }
  printf("PINCH COUNT P=%lld (vertices with a disconnected star: %lld; connected octagon saddles: %lld) | chi=%lld, 2 - P=%lld -> %s\n",
         Pexc, pinchv, saddle8, chi, 2 - Pexc, chi <= 2 - Pexc ? "PINCH INEQUALITY HOLDS (chi <= 2 - P)" : "PINCH INEQUALITY FAILS");
  /* components: X's 1-skeleton, G, G6 */
  long long comp[3], verts[3], edges[3];
  for (int pass = 0; pass < 3; pass++) {
    int thr = pass == 0 ? 1 : (pass == 1 ? 4 : 6);
    for (long long k = 0; k < NPT; k++) UF[k] = (int)k;
    unsigned char *isv = calloc(NPT, 1); long long ne = 0;
    for (long long k = 0; k < NPT; k++) for (int d = 0; d < 4; d++) { int mu = LM[k * 4 + d]; if (mu >= thr && (pass != 2 || mu == 6)) {
      long long r = k; int c[4]; for (int q = 3; q >= 0; q--) { c[q] = (int)(r % W) + LO; r /= W; }
      c[d]++; long long k2 = idx(c[0], c[1], c[2], c[3]); isv[k] = 1; isv[k2] = 1; ne++;
      int a = fnd((int)k), b = fnd((int)k2); if (a != b) UF[a] = b; } }
    long long nv = 0, nc = 0; for (long long k = 0; k < NPT; k++) if (isv[k]) { nv++; if (fnd((int)k) == (int)k) nc++; }
    comp[pass] = nc; verts[pass] = nv; edges[pass] = ne; free(isv); }
  long long b1G = edges[1] - verts[1] + comp[1], b1G6 = edges[2] - verts[2] + comp[2], Q = b1G + b1G6;
  /* closed unit 3-cubes, direct: lower corner p, directions i < j < k, all six faces present */
  long long closed = 0;
  for (long long k = 0; k < NPT; k++) if (P[k]) {
    long long r = k; int c[4]; for (int q = 3; q >= 0; q--) { c[q] = (int)(r % W) + LO; r /= W; }
    for (int i = 0; i < 4; i++) for (int j = i + 1; j < 4; j++) for (int l = j + 1; l < 4; l++) {
      int ok = 1, dd[3] = {i, j, l};
      for (int f = 0; f < 3 && ok; f++) { int u = dd[(f + 1) % 3], v = dd[(f + 2) % 3], w = dd[f]; if (u > v) { int z = u; u = v; v = z; }
        for (int sh = 0; sh < 2 && ok; sh++) { int c2[4]; memcpy(c2, c, sizeof c2); c2[w] += sh;
          if (!inb(c2[w])) { ok = 0; break; } if (!(P[idx(c2[0], c2[1], c2[2], c2[3])] >> TP[u][v] & 1)) ok = 0; } }
      if (ok) closed++; } }
  /* every unit tesseract with an X-plaquette: facet graph (node 2*q + eps) under the MISSING squares */
  long long tess = 0, tcyc = 0, ttorus = 0;
  for (long long k = 0; k < NPT; k++) {
    long long r = k; int c[4]; for (int q = 3; q >= 0; q--) { c[q] = (int)(r % W) + LO; r /= W; }
    int okb = 1; for (int q = 0; q < 4; q++) if (!inb(c[q] + 1)) okb = 0; if (!okb) continue;
    int any = 0, pres[6][2][2], par[8];
    for (int i = 0; i < 4; i++) for (int j = i + 1; j < 4; j++) { int kk = -1, ll = -1; for (int q = 0; q < 4; q++) if (q != i && q != j) { if (kk < 0) kk = q; else ll = q; }
      for (int e1 = 0; e1 < 2; e1++) for (int e2 = 0; e2 < 2; e2++) { int c2[4]; memcpy(c2, c, sizeof c2); c2[kk] += e1; c2[ll] += e2;
        int pr = P[idx(c2[0], c2[1], c2[2], c2[3])] >> TP[i][j] & 1; pres[TP[i][j]][e1][e2] = pr; if (pr) any = 1; } }
    if (!any) continue; tess++;
    for (int q = 0; q < 8; q++) par[q] = q;
    int npres = 0, nmixed_pres = 0;
    for (int i = 0; i < 4; i++) for (int j = i + 1; j < 4; j++) { int kk = -1, ll = -1; for (int q = 0; q < 4; q++) if (q != i && q != j) { if (kk < 0) kk = q; else ll = q; }
      for (int e1 = 0; e1 < 2; e1++) for (int e2 = 0; e2 < 2; e2++) { if (pres[TP[i][j]][e1][e2]) { npres++; if (i < 2 && j >= 2) nmixed_pres++; continue; }
        int a = 2 * kk + e1, b = 2 * ll + e2; while (par[a] != a) a = par[a]; while (par[b] != b) b = par[b]; if (a != b) par[a] = b; } }
    int nc = 0; for (int q = 0; q < 8; q++) if (par[q] == q) nc++;
    if (nc > 1) { tcyc++; if (npres == 16 && nmixed_pres == 16 && nc == 2) ttorus++; } }
  printf("FAMILY m=%d s=%d box W=%d: collisions=%lld outside=%lld\n", m, s, W, collide, outside);
  printf("PLAQUETTES F=%lld nonmixed=%lld | LINKS L=%lld odd=%lld N4=%lld N6=%lld N>6=%lld | VERTICES V=%lld chi=%lld\n", F, nonmixed, L, odd, N4, N6, Nhi, Vx, chi);
  printf("SKELETON components=%lld | G: E=%lld V=%lld c=%lld b1=%lld | G6: E=%lld V=%lld c=%lld b1=%lld | Q=%lld Q/F=%.6f\n", comp[0], edges[1], verts[1], comp[1], b1G, edges[2], verts[2], comp[2], b1G6, Q, (double)Q / F);
  long long mm = m - 1, Fc = 4LL * (m * (long long)m + 1) * (m * (long long)m + 1) + 2 * mm * mm * (m + 2LL) * (m + 2LL), Qc = 3 * mm * mm * mm * mm + 1;
  printf("CLOSED FORMS F=%lld Q=%lld chi=-1 -> %s\n", Fc, Qc, (Fc == F && Qc == Q && chi == -1) ? "MET" : "PARTED");
  printf("CUBES closed unit 3-cubes = %lld\n", closed);
  /* THEOREM I x 8: 8(F/2 + 1 - Q) = 6E(G) - 8b1(G) + 6N6 - 8b1(G6) + 8(2 - chi) + sum(8 - a) - 8 */
  long long lhs = 4 * F + 8 - 8 * Q, rhs = 6 * edges[1] - 8 * b1G + 6 * N6 - 8 * b1G6 + 8 * (2 - chi) + sum8a - 8;
  printf("THEOREM I (x8): lhs=%lld rhs=%lld -> %s | Delta(G)=%lld/4 sum(8-a)=%lld\n", lhs, rhs, lhs == rhs ? "MET" : "PARTED", 3 * edges[1] - 4 * b1G, sum8a);
  printf("TESSERACTS with an X-plaquette=%lld, carrying a closed subset=%lld, of them the flat-torus pattern (16 mixed, 2 components)=%lld\n", tess, tcyc, ttorus);
  return 0;
}
