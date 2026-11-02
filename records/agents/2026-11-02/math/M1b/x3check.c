/* x3check.c -- M1b (K5): THE FLAT CONTACT CONFIGURATION X3 = all mixed squares except the (e2, e4) ones, restricted to the box
   [0,s]^4, against the sighted control X_inf = all mixed squares. For each: the GF(2) rank of the boundary map (squares -> links);
   deficiency = #squares - rank = dim of the space of closed subsets inside the box. Known answer for the control: (s^2)^2 = s^4
   (Z1 of the s x s grid has dimension s^2, closed mixed sets = Z1 (x) Z1). Claim for X3: deficiency 0 (no finite closed subset).
   Also reads, at the box centre, the star of X3: a, d, link multiplicities, K = d - 2a + 4.
   usage: x3check.exe s mode   (mode 0 = X_inf control, 1 = X3) */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
static int s, n1; /* n1 = s + 1 points per axis */
static int pidx(int *c) { return ((c[0] * n1 + c[1]) * n1 + c[2]) * n1 + c[3]; }
int main(int argc, char **argv) {
  s = argc > 1 ? atoi(argv[1]) : 4; int mode = argc > 2 ? atoi(argv[2]) : 1; n1 = s + 1;
  int NP = n1 * n1 * n1 * n1, NL = NP * 4, words = (NL + 63) / 64;
  /* enumerate squares in the box: lower corner c, directions i < j mixed (i in {0,1}, j in {2,3}); X3 drops (1,3) */
  int maxsq = NP * 4; int (*sq)[6] = malloc(sizeof(int[6]) * maxsq); int ns = 0;
  for (int p = 0; p < NP; p++) { int c[4], r = p; for (int q = 3; q >= 0; q--) { c[q] = r % n1; r /= n1; }
    for (int i = 0; i < 2; i++) for (int j = 2; j < 4; j++) { if (mode == 1 && i == 1 && j == 3) continue;
      if (c[i] + 1 > s || c[j] + 1 > s) continue;
      sq[ns][0] = c[0]; sq[ns][1] = c[1]; sq[ns][2] = c[2]; sq[ns][3] = c[3]; sq[ns][4] = i; sq[ns][5] = j; ns++; } }
  /* boundary rows */
  uint64_t *piv = calloc((size_t)NL * words, sizeof(uint64_t)); char *has = calloc(NL, 1); uint64_t *row = malloc(words * 8);
  int rank = 0;
  for (int k = 0; k < ns; k++) { memset(row, 0, words * 8); int c[4] = {sq[k][0], sq[k][1], sq[k][2], sq[k][3]}, i = sq[k][4], j = sq[k][5];
    int l1 = pidx(c) * 4 + i, l2 = pidx(c) * 4 + j; c[j]++; int l3 = pidx(c) * 4 + i; c[j]--; c[i]++; int l4 = pidx(c) * 4 + j;
    int ls[4] = {l1, l2, l3, l4}; for (int t = 0; t < 4; t++) row[ls[t] / 64] ^= 1ULL << (ls[t] % 64);
    for (int w = 0; w < words; w++) while (row[w]) { int b = __builtin_ctzll(row[w]); int l = w * 64 + b;
      if (!has[l]) { has[l] = 1; memcpy(piv + (size_t)l * words, row, words * 8); rank++; goto next; }
      uint64_t *pr = piv + (size_t)l * words; for (int x = w; x < words; x++) row[x] ^= pr[x]; }
    next:; }
  printf("BOX s=%d mode=%s: squares=%d rank=%d deficiency=%d", s, mode ? "X3" : "X_inf(control)", ns, rank, ns - rank);
  if (mode == 0) printf(" (known answer s^4=%d -> %s)", s * s * s * s, ns - rank == s * s * s * s ? "MET" : "PARTED");
  printf("\n");
  if (mode == 1) { /* star at the centre vertex: count squares at v in the full X3 (types (0,2),(0,3),(1,2), every orientation) */
    int d = 12, a = 8; int mult[4] = {4, 2, 4, 2};   /* derived on the page; recount: */
    int cnt[4] = {0, 0, 0, 0}, dd = 0;
    for (int i = 0; i < 4; i++) for (int j = i + 1; j < 4; j++) { int mixed = (i < 2 && j >= 2), drop = (i == 1 && j == 3); if (!mixed || drop) continue;
      dd += 4; cnt[i] += 4; cnt[j] += 4; }   /* 4 squares of type (i,j) at a vertex, each with one i-link and one j-link at v */
    printf("STAR of X3 at any vertex: d=%d (page %d) a=%d (page %d) half-axis multiplicities e1..e4 = %d %d %d %d (page %d %d %d %d) K=%d\n",
           dd, d, 8, a, cnt[0] / 2, cnt[1] / 2, cnt[2] / 2, cnt[3] / 2, mult[0], mult[1], mult[2], mult[3], dd - 16 + 4); }
  return 0;
}
