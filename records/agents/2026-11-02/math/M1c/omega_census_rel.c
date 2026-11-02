/* omega_census.c -- the LEAFLESS class: closed link-connected plaquette sets of Z^4 through p0 with NO nonempty Z2-even subset
 * (equivalently: the Z2 boundary vectors of their plaquettes are linearly independent).  M1c, 2026-11-02.
 * Enumeration: g48_polymers.c's canonical construction verbatim (close the smallest multiplicity-one link by the smallest plaquette
 * of X containing it; once closed, add the smallest plaquette of X sharing a link; candidates in increasing order, each forbidden for
 * the later siblings), PLUS the prune: a partial set whose boundary vectors are dependent contains an even subset, so does every
 * set built on it, and its subtree holds no leafless set.  A closed node with independent vectors IS a leafless set.
 * MODE 0: the prune on (the census).  MODE 1: the prune off (the control: every closed set, g48's totals by F).
 * CHECK: every closed node's rank recomputed from scratch by Gaussian elimination over its own link list (two roads, one process).
 * usage: omega_census FMAX MODE [LISTMAX]
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <time.h>
#define D 4
#define MAXF 30
static int FMAX, MODE, R, B, NPD, PAIRA[6], PAIRB[6], PIDX[D][D], LISTMAX = 20; static long long stride[D], NS;
static unsigned char *mult, *inX; static unsigned short *forb; static long long *defl, *dpos; static int ndef;
static long long Pl[MAXF + 4]; static int np; static long long nodes, pruned;
static long long cntClosed[MAXF + 1], cntOmega[MAXF + 1], cntOdd[MAXF + 1];
/* the incremental Z2 basis: link -> bit index (assigned on first appearance, LIFO), vectors 2 x 64 bits */
static signed char *lbit; static unsigned char *exm; static int bitstack[128], nbitfree; static int bitref[128];
typedef struct { uint64_t w[2]; } vec_t;
static vec_t BV[MAXF + 4]; static int BP[MAXF + 4]; static int owner[128]; static int nb;
static long long hist[MAXF + 1][8][8][8]; /* not used beyond small reporting */
static void plinks(long long p, long long *L4) { long long s = p / NPD; int k = (int)(p % NPD), a = PAIRA[k], b = PAIRB[k]; L4[0] = s * D + a; L4[1] = (s + stride[a]) * D + b; L4[2] = (s + stride[b]) * D + a; L4[3] = s * D + b; }
static void lplaqs(long long l, long long *P6, int *n) { long long s = l / D; int a = (int)(l % D); *n = 0; for (int b = 0; b < D; b++) { if (b == a) continue; int lo = a < b ? a : b, hi = a < b ? b : a; P6[(*n)++] = s * NPD + PIDX[lo][hi]; P6[(*n)++] = (s - stride[b]) * NPD + PIDX[lo][hi]; } }
static void adddef(long long l) { dpos[l] = ndef; defl[ndef++] = l; }
static void deldef(long long l) { long long i = dpos[l]; long long last = defl[--ndef]; defl[i] = last; dpos[last] = i; }
static int lowbit(const vec_t *v) { if (v->w[0]) return __builtin_ctzll(v->w[0]); if (v->w[1]) return 64 + __builtin_ctzll(v->w[1]); return -1; }
/* add plaquette p: multiplicities, deficient links, bit indices; returns 1 if its vector is independent of the basis (and inserts it), 0 if dependent (inserted nothing; caller must undo with remp_dep) */
static int addp(long long p) { long long L4[4]; plinks(p, L4); inX[p] = 1; Pl[np++] = p;
  vec_t v; v.w[0] = v.w[1] = 0;
  for (int i = 0; i < 4; i++) { long long l = L4[i]; mult[l]++; if (mult[l] == 1) { if (!exm[l]) adddef(l); int b = bitstack[--nbitfree]; lbit[l] = (signed char)b; bitref[b] = 1; } else { if (mult[l] == 2 && !exm[l]) deldef(l); bitref[(int)lbit[l]]++; }
    int b = lbit[l]; v.w[b >> 6] ^= (1ULL << (b & 63)); }
  for (;;) { int b = lowbit(&v); if (b < 0) return 0; if (owner[b] < 0) { BV[nb] = v; BP[nb] = b; owner[b] = nb; nb++; return 1; } v.w[0] ^= BV[owner[b]].w[0]; v.w[1] ^= BV[owner[b]].w[1]; } }
static void remp(long long p, int indep) { long long L4[4]; plinks(p, L4);
  if (indep) { nb--; owner[BP[nb]] = -1; }
  for (int i = 3; i >= 0; i--) { long long l = L4[i]; int b = lbit[l]; bitref[b]--; if (mult[l] == 2 && !exm[l]) adddef(l); else if (mult[l] == 1) { if (!exm[l]) deldef(l); bitstack[nbitfree++] = b; lbit[l] = -1; } mult[l]--; }
  inX[p] = 0; np--; }
static int cmpll(const void *x, const void *y) { long long a = *(const long long *)x, b = *(const long long *)y; return a < b ? -1 : a > b; }
/* the second road: rank of the boundary vectors of Pl[0..np-1] from scratch, over a fresh link list */
static int rank_scratch(void) { long long lk[4 * MAXF + 8]; int nl = 0; uint64_t M[MAXF + 4][2]; int rows = np;
  for (int i = 0; i < np; i++) { long long L4[4]; plinks(Pl[i], L4); M[i][0] = M[i][1] = 0; for (int q = 0; q < 4; q++) { int f = -1; for (int t = 0; t < nl; t++) if (lk[t] == L4[q]) { f = t; break; } if (f < 0) { lk[nl] = L4[q]; f = nl++; } M[i][f >> 6] ^= (1ULL << (f & 63)); } }
  int r = 0; for (int col = 0; col < nl && r < rows; col++) { int piv = -1; for (int i = r; i < rows; i++) if ((M[i][col >> 6] >> (col & 63)) & 1ULL) { piv = i; break; } if (piv < 0) continue;
    uint64_t t0 = M[piv][0], t1 = M[piv][1]; M[piv][0] = M[r][0]; M[piv][1] = M[r][1]; M[r][0] = t0; M[r][1] = t1;
    for (int i = 0; i < rows; i++) if (i != r && ((M[i][col >> 6] >> (col & 63)) & 1ULL)) { M[i][0] ^= M[r][0]; M[i][1] ^= M[r][1]; } r++; }
  return r; }
static long long nlisted; static long long rankfail;
static void record(void) { int F = np; cntClosed[F]++;
  /* multiplicity profile */
  int h[8] = {0}; long long lk[4 * MAXF + 8]; int nl = 0;
  for (int i = 0; i < np; i++) { long long L4[4]; plinks(Pl[i], L4); for (int q = 0; q < 4; q++) { int f = -1; for (int t = 0; t < nl; t++) if (lk[t] == L4[q]) { f = t; break; } if (f < 0) { lk[nl] = L4[q]; nl++; } } }
  for (int t = 0; t < nl; t++) { int m = mult[lk[t]]; if (m < 8) h[m]++; }
  int odd = h[1] || h[3] || h[5] || h[7]; if (odd) cntOdd[F]++;
  int rk = rank_scratch(); int indep = (rk == np);
  if (MODE == 0 && !indep) rankfail++;   /* the prune on: every closed node must be independent */
  if (indep) { cntOmega[F]++;
    if (nlisted < LISTMAX) { nlisted++; printf("OMEGA F=%d links=%d m2=%d m3=%d m4=%d m5=%d m6=%d rank=%d plaquettes:", F, nl, h[2], h[3], h[4], h[5], h[6], rk);
      long long c0[D]; { long long s = Pl[0] / NPD; for (int d = 0; d < D; d++) c0[d] = (s / stride[d]) % B; }
      for (int i = 0; i < np; i++) { long long s = Pl[i] / NPD; int k = (int)(Pl[i] % NPD); printf(" ("); for (int d = 0; d < D; d++) printf(d ? ",%lld" : "%lld", (s / stride[d]) % B - c0[d]); printf(")%d%d", PAIRA[k] + 1, PAIRB[k] + 1); }
      printf("\n"); } } }
static void dfs(void) {
  nodes++;
  if (ndef == 0) {
    record(); if (np >= FMAX) return;
    long long cand[24 * MAXF + 8]; int nc = 0;
    for (int i = 0; i < np; i++) { long long L4[4]; plinks(Pl[i], L4); for (int q = 0; q < 4; q++) { long long P6[6]; int n6; lplaqs(L4[q], P6, &n6); for (int t = 0; t < n6; t++) { long long p = P6[t]; if (!inX[p] && !forb[p]) cand[nc++] = p; } } }
    qsort(cand, nc, sizeof(long long), cmpll); int nu = 0; for (int i = 0; i < nc; i++) if (nu == 0 || cand[i] != cand[nu - 1]) cand[nu++] = cand[i];
    for (int i = 0; i < nu; i++) { int ind = addp(cand[i]); if ((ind || MODE == 1) && np + (ndef + 3) / 4 <= FMAX) dfs(); else if (!ind) pruned++; remp(cand[i], ind); forb[cand[i]]++; }
    for (int i = 0; i < nu; i++) forb[cand[i]]--;
    return; }
  if (np + (ndef + 3) / 4 > FMAX) return;
  long long l = defl[0]; for (int i = 1; i < ndef; i++) if (defl[i] < l) l = defl[i];
  long long P6[6]; int n6; lplaqs(l, P6, &n6); qsort(P6, n6, sizeof(long long), cmpll);
  int used[6], nused = 0;
  for (int t = 0; t < n6; t++) { long long p = P6[t]; if (inX[p] || forb[p]) continue; int ind = addp(p); if (ind || MODE == 1) dfs(); else pruned++; remp(p, ind); forb[p]++; used[nused++] = t; }
  for (int k = 0; k < nused; k++) forb[P6[used[k]]]--;
}
int main(int argc, char **argv) {
  setvbuf(stdout, NULL, _IONBF, 0);
  if (argc < 3) { fprintf(stderr, "usage: omega_census FMAX MODE [LISTMAX]\n"); return 2; }
  FMAX = atoi(argv[1]); MODE = atoi(argv[2]); if (argc > 3) LISTMAX = atoi(argv[3]); if (FMAX < 4 || FMAX > MAXF || (MODE < 0 || MODE > 2)) return 2;
  R = FMAX + 3; B = 2 * R + 1; NS = 1; for (int d = D - 1; d >= 0; d--) { stride[d] = NS; NS *= B; }
  NPD = D * (D - 1) / 2; int k = 0; for (int a = 0; a < D; a++) for (int b = a + 1; b < D; b++) { PAIRA[k] = a; PAIRB[k] = b; PIDX[a][b] = PIDX[b][a] = k; k++; }
  mult = calloc((size_t)NS * D, 1); inX = calloc((size_t)NS * NPD, 1); forb = calloc((size_t)NS * NPD, sizeof(unsigned short)); defl = malloc(sizeof(long long) * (4 * MAXF + 16)); dpos = malloc(sizeof(long long) * (size_t)NS * D);
  lbit = malloc((size_t)NS * D); exm = calloc((size_t)NS * D, 1); if (!mult || !inX || !forb || !dpos || !lbit) { fprintf(stderr, "OMEGA-REFUSED memory\n"); return 3; }
  memset(lbit, -1, (size_t)NS * D); nbitfree = 0; for (int b = 127; b >= 0; b--) bitstack[nbitfree++] = b; for (int b = 0; b < 128; b++) owner[b] = -1; nb = 0;
  long long c = 0; for (int d = 0; d < D; d++) c += (long long)R * stride[d];
  long long p0 = c * NPD + PIDX[0][1];
  printf("OMEGA-CENSUS FMAX=%d MODE=%d (%s): box side %d\n", FMAX, MODE, MODE ? "control: every closed set" : "census: closed sets with independent boundary vectors", B);
  time_t t0 = time(NULL);
  if (MODE == 2) { long long E4[4]; plinks(p0, E4); for (int i = 0; i < 4; i++) exm[E4[i]] = 1; MODE = 0; printf("OMEGA-REL: the four links of p0 exempt from closing (a planted positive: {p0} is relatively closed and independent)\n"); }
  int ind = addp(p0); dfs(); remp(p0, ind);
  for (int F = 1; F <= FMAX; F++) if (cntClosed[F] || cntOmega[F]) printf("OMEGA-COUNT F=%d: closed %lld (odd %lld), leafless %lld\n", F, cntClosed[F], cntOdd[F], cntOmega[F]);
  printf("OMEGA-CHECK rank recomputed from scratch at every closed node: %lld disagreements with the incremental basis\n", rankfail);
  printf("OMEGA-END nodes %lld pruned %lld (%ld s)\n", nodes, pruned, (long)(time(NULL) - t0));
  return 0;
}
