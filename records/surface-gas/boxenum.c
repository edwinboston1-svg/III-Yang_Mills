/* boxenum.c -- THE FIRST INSTRUMENT OF S12's REMAINDER (S1 (p), 2026-11-01 12:3x EST; the trunk seat): every closed all-1/2 set through
 * one plaquette INSIDE A BOX of Z^4, grown by the ODD RULE (always close the smallest link of odd multiplicity with a plaquette at it that
 * keeps every link at multiplicity <= 4 -- Lemma P: the tree reaches every Z_2-minimal closed set, each once, DUP checked by hash as in
 * surf.c), every leaf (no odd link) read by THE RESOLUTION FORMULA of (p): S(X) = (2/3)^N4 sum over the resolutions of prod (-1)^m 2^chi,
 * the minimality decided by the resolutions' connectivity (every resolution connected <=> Z_2-minimal), and the two stakes of §18's
 * remainder checked on every minimal leaf: STRONG |S(X)| <= 2^{chi_max} (chi_max over the resolutions, the sheet's chi) and WEAK
 * |S(X)| <= 4.  A violation is printed with its plaquette list; the census by area and four-link count is printed at the end.  The box
 * lets the search reach areas beyond the lattice-wide census (F <= 20/22), where the staked case (a contact component of cycle rank two)
 * must first appear.  usage: boxenum Lx Ly Lz Lt FMAX [NODEMAX=2e9]   (the box [0,Lx]x[0,Ly]x[0,Lz]x[0,Lt] in sites; p0 = (0,0,0,0)12) */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <math.h>
#define D 4
#define NPAIR 6
#define MAXF 64
static int L[4], FMAX, R, W; static long NS; static long long NODEMAX = 2000000000LL;
static int PMU[NPAIR] = {0,0,0,1,1,2}, PNU[NPAIR] = {1,2,3,2,3,3};
static unsigned char *mult, *inP; static long stride[4];
static long site_of(const int *x) { long s = 0; for (int i = 0; i < D; i++) s += (long)(x[i] + R) * stride[i]; return s; }
static void coords(long s, int *x) { for (int i = 0; i < D; i++) x[i] = (int)(s / stride[i]) % W - R; }
static long link_id(long s, int mu) { return s * D + mu; }
static long plaq_id(long s, int k) { return s * NPAIR + k; }
static int pair_index(int mu, int nu) { for (int k = 0; k < NPAIR; k++) if (PMU[k] == mu && PNU[k] == nu) return k; return -1; }
static void plaq_links(long p, long *Lk) { long s = p / NPAIR; int k = (int)(p % NPAIR); int mu = PMU[k], nu = PNU[k]; Lk[0] = link_id(s, mu); Lk[1] = link_id(s + stride[mu], nu); Lk[2] = link_id(s + stride[nu], mu); Lk[3] = link_id(s, nu); }
static int link_plaqs(long l, long *Q) { long s = l / D; int mu = (int)(l % D); int n = 0; for (int nu = 0; nu < D; nu++) if (nu != mu) { int a = mu < nu ? mu : nu, b = mu < nu ? nu : mu; int k = pair_index(a, b); Q[n++] = plaq_id(s, k); Q[n++] = plaq_id(s - stride[nu], k); } return n; }
static int in_box(long p) { long s = p / NPAIR; int k = (int)(p % NPAIR); int x[4]; coords(s, x); for (int d = 0; d < D; d++) { int ext = (d == PMU[k] || d == PNU[k]) ? 1 : 0; if (x[d] < 0 || x[d] + ext > L[d]) return 0; } return 1; }
static long P[MAXF]; static int F = 0; static long oddL[1024]; static int nodd = 0;
static void add_odd(long l) { oddL[nodd++] = l; }
static void del_odd(long l) { for (int i = 0; i < nodd; i++) if (oddL[i] == l) { oddL[i] = oddL[--nodd]; return; } fprintf(stderr, "del_odd miss\n"); exit(3); }
#define HB (1u << 26)
static uint64_t *htab; static long long dups = 0, nodes = 0;
static int cmpl(const void *a, const void *b) { long x = *(const long *)a, y = *(const long *)b; return x < y ? -1 : x > y; }
static int seen(void) { long t[MAXF]; memcpy(t, P, sizeof(long) * F); qsort(t, F, sizeof(long), cmpl); uint64_t h = 1469598103934665603ULL; for (int i = 0; i < F; i++) { h ^= (uint64_t)t[i]; h *= 1099511628211ULL; } h ^= (uint64_t)F; if (!h) h = 1; uint32_t i = (uint32_t)(h >> 38) & (HB - 1); while (htab[i]) { if (htab[i] == h) return 1; i = (i + 1) & (HB - 1); } htab[i] = h; return 0; }
/* ---- the resolution formula on the current set P (the plaquettes with their four sides and corners) */
static int par[MAXF * 5];
static int fnd(int x) { while (par[x] != x) x = par[x] = par[par[x]]; return x; }
static void uni(int a, int b) { a = fnd(a); b = fnd(b); if (a != b) par[a] = b; }
typedef struct { double S; int chimax, n4; long nres, conn; } reading_t;
static reading_t resolve_P(void) {
  reading_t out = { 0, -99, 0, 0, 0 };
  static long lk[MAXF * 4]; static int lp[MAXF * 4][4][2], lm[MAXF * 4], ls[MAXF][4], lc[MAXF][4][4][4]; int nl = 0;   /* links: id, incidences (p, side), multiplicity; per plaquette: side signs, corner sites */
  for (int p = 0; p < F; p++) { long Lk[4]; plaq_links(P[p], Lk); long s = P[p] / NPAIR; int k = (int)(P[p] % NPAIR); int a = PMU[k], c = PNU[k]; int b[4]; coords(s, b);
    int corners[4][4]; memcpy(corners[0], b, sizeof b); memcpy(corners[1], b, sizeof b); corners[1][a]++; memcpy(corners[2], corners[1], sizeof b); corners[2][c]++; memcpy(corners[3], b, sizeof b); corners[3][c]++;
    for (int q = 0; q < 4; q++) memcpy(lc[p][q], corners[q], sizeof b);
    ls[p][0] = 1; ls[p][1] = 1; ls[p][2] = -1; ls[p][3] = -1;
    for (int q = 0; q < 4; q++) { int idx = -1; for (int i = 0; i < nl; i++) if (lk[i] == Lk[q]) idx = i; if (idx < 0) { idx = nl++; lk[idx] = Lk[q]; lm[idx] = 0; } lp[idx][lm[idx]][0] = p; lp[idx][lm[idx]][1] = q; lm[idx]++; } }
  int n4[MAXF * 4], N4 = 0; for (int i = 0; i < nl; i++) { if (lm[i] == 4) n4[N4++] = i; else if (lm[i] != 2) { out.n4 = -1; return out; } }
  out.n4 = N4; if (N4 > 10) { out.nres = -1; return out; }
  long nres = 1; for (int i = 0; i < N4; i++) nres *= 3; out.nres = nres;
  static const int PAIR[3][4] = { {0,1,2,3}, {0,2,1,3}, {0,3,1,2} }; int choice[16];
  double sum = 0; long conn = 0;
  for (long r = 0; r < nres; r++) { long rr = r; for (int i = 0; i < N4; i++) { choice[i] = rr % 3; rr /= 3; }
    int ncorn = F * 4; for (int i = 0; i < ncorn + F; i++) par[i] = i;
    static int gl[MAXF * 4][2][2]; int ngl = 0;
    for (int i = 0; i < nl; i++) { int pairs[2][2]; int ci = -1; if (lm[i] == 4) { for (int j = 0; j < N4; j++) if (n4[j] == i) ci = j; const int *pr = PAIR[choice[ci]]; pairs[0][0] = pr[0]; pairs[0][1] = pr[1]; pairs[1][0] = pr[2]; pairs[1][1] = pr[3]; } else { pairs[0][0] = 0; pairs[0][1] = 1; }
      for (int t = 0; t < (lm[i] == 4 ? 2 : 1); t++) { int p = lp[i][pairs[t][0]][0], s = lp[i][pairs[t][0]][1], q = lp[i][pairs[t][1]][0], s2 = lp[i][pairs[t][1]][1];
        uni(ncorn + p, ncorn + q);
        for (int k = 0; k < 2; k++) { int cp = (s + k) % 4; for (int k2 = 0; k2 < 2; k2++) { int cq = (s2 + k2) % 4; if (!memcmp(lc[p][cp], lc[q][cq], sizeof(int) * 4)) uni(p * 4 + cp, q * 4 + cq); } }
        gl[ngl][0][0] = p; gl[ngl][0][1] = s; gl[ngl][1][0] = q; gl[ngl][1][1] = s2; ngl++; } }
    int ncomp = 0; static int croot[MAXF], cV[MAXF], cE[MAXF], cF[MAXF];
    for (int p = 0; p < F; p++) { int rt = fnd(ncorn + p), idx = -1; for (int i = 0; i < ncomp; i++) if (croot[i] == rt) idx = i; if (idx < 0) { idx = ncomp++; croot[idx] = rt; cV[idx] = cE[idx] = cF[idx] = 0; } cF[idx]++; }
    for (int i = 0; i < ncorn; i++) if (fnd(i) == i) { int rt = fnd(ncorn + i / 4); for (int c = 0; c < ncomp; c++) if (croot[c] == rt) cV[c]++; }
    for (int g = 0; g < ngl; g++) { int rt = fnd(ncorn + gl[g][0][0]); for (int c = 0; c < ncomp; c++) if (croot[c] == rt) cE[c]++; }
    static int sig[MAXF]; for (int p = 0; p < F; p++) sig[p] = 0; double w = 1; int chitot = 0;
    for (int c = 0; c < ncomp; c++) { int rt = croot[c], ok = 1;
      for (int p0 = 0; p0 < F; p0++) { if (fnd(ncorn + p0) != rt || sig[p0]) continue; sig[p0] = 1; int stack[MAXF], sp = 0; stack[sp++] = p0;
        while (sp) { int p = stack[--sp]; for (int g = 0; g < ngl; g++) { int a = -1, b = -1; if (gl[g][0][0] == p) { a = 0; b = 1; } else if (gl[g][1][0] == p) { a = 1; b = 0; } else continue; int q = gl[g][b][0], sa = ls[p][gl[g][a][1]], sb = ls[q][gl[g][b][1]]; int want = -sig[p] * sa * sb; if (!sig[q]) { sig[q] = want; stack[sp++] = q; } else if (sig[q] != want) ok = 0; } } }
      int chi = cV[c] - cE[c] + cF[c]; chitot += chi; w *= pow(2.0, chi); if (!ok && ((2 - chi) % 2)) w = -w; }
    sum += w; if (ncomp == 1) { conn++; if (chitot > out.chimax) out.chimax = chitot; } }
  out.conn = conn; double S = sum; for (int i = 0; i < N4; i++) S *= 2.0 / 3.0; out.S = S; return out; }
/* ---- the census */
static long long leaves[MAXF][16], minimal[MAXF][16], unread = 0, strongv = 0, weakv = 0, shown = 0; static double maxS[MAXF][16];
static void record(void) { if (seen()) { dups++; return; }
  reading_t r = resolve_P(); if (r.n4 < 0) return; if (r.nres < 0) { unread++; return; }
  int n4 = r.n4 < 15 ? r.n4 : 15; leaves[F][n4]++; if (r.conn != r.nres) return;   /* not minimal: a disconnected resolution */
  minimal[F][n4]++; double aS = fabs(r.S); if (aS > maxS[F][n4]) maxS[F][n4] = aS;
  int strong = aS > pow(2.0, r.chimax) + 1e-9, weak = aS > 4 + 1e-9; if (strong) strongv++; if (weak) weakv++;
  if ((strong || (n4 >= 2 && shown < 40)) ) { shown++; printf("BOX-LEAF F=%d N4=%d S=%.10g chimax=%d resolutions=%ld %s%s plaquettes:", F, r.n4, r.S, r.chimax, r.nres, strong ? "STRONG-VIOLATION " : "", weak ? "WEAK-VIOLATION " : "");
    for (int i = 0; i < F; i++) { long s = P[i] / NPAIR; int k = (int)(P[i] % NPAIR); int x[4]; coords(s, x); printf(" (%d,%d,%d,%d)%d%d", x[0], x[1], x[2], x[3], PMU[k] + 1, PNU[k] + 1); } printf("\n"); fflush(stdout); } }
static void search(void) { nodes++; if (nodes > NODEMAX) return;
  if (nodd == 0) { record(); return; }
  if (F + (nodd + 3) / 4 > FMAX) return;
  long l = oddL[0]; for (int i = 1; i < nodd; i++) if (oddL[i] < l) l = oddL[i];
  long Q[16]; int nq = link_plaqs(l, Q);
  for (int qi = 0; qi < nq; qi++) { long q = Q[qi]; if (inP[q] || !in_box(q)) continue;
    long L4[4]; plaq_links(q, L4); int ok = 1; for (int a = 0; a < 4; a++) if (mult[L4[a]] >= 4) ok = 0; if (!ok) continue;
    inP[q] = 1; P[F++] = q;
    for (int a = 0; a < 4; a++) { int was = mult[L4[a]] & 1; mult[L4[a]]++; int now = mult[L4[a]] & 1; if (was && !now) del_odd(L4[a]); else if (!was && now) add_odd(L4[a]); }
    search();
    for (int a = 0; a < 4; a++) { int was = mult[L4[a]] & 1; mult[L4[a]]--; int now = mult[L4[a]] & 1; if (was && !now) del_odd(L4[a]); else if (!was && now) add_odd(L4[a]); }
    F--; inP[q] = 0; } }
int main(int argc, char **argv) {
  if (argc < 6) { fprintf(stderr, "usage: boxenum Lx Ly Lz Lt FMAX [NODEMAX]\n"); return 1; }
  for (int d = 0; d < D; d++) L[d] = atoi(argv[1 + d]); FMAX = atoi(argv[5]); if (argc > 6) NODEMAX = atoll(argv[6]); if (FMAX > MAXF - 1) FMAX = MAXF - 1;
  int lmax = 0; for (int d = 0; d < D; d++) if (L[d] > lmax) lmax = L[d]; R = lmax + 2; W = 2 * R + 1; NS = 1; for (int i = 0; i < D; i++) { stride[i] = NS; NS *= W; }
  mult = calloc(NS * D, 1); inP = calloc(NS * NPAIR, 1); htab = calloc(HB, sizeof(uint64_t)); if (!mult || !inP || !htab) { fprintf(stderr, "alloc\n"); return 2; }
  int x0[4] = {0}; long s0 = site_of(x0); long p0 = plaq_id(s0, pair_index(0, 1)); if (!in_box(p0)) { fprintf(stderr, "p0 outside the box\n"); return 1; }
  inP[p0] = 1; P[F++] = p0; { long L4[4]; plaq_links(p0, L4); for (int a = 0; a < 4; a++) { mult[L4[a]] = 1; add_odd(L4[a]); } }
  search();
  printf("# boxenum box %dx%dx%dx%d FMAX=%d: nodes %lld (cap %lld)%s, DUP %lld, leaves with more than ten four-links unread %lld\n", L[0], L[1], L[2], L[3], FMAX, nodes, NODEMAX, nodes > NODEMAX ? " CAP REACHED (the census is partial)" : "", dups, unread);
  printf("# F N4 leaves minimal max|S|(minimal)\n");
  for (int f = 1; f <= FMAX; f++) for (int k = 0; k < 16; k++) if (leaves[f][k]) printf("%2d %2d %10lld %10lld %.6g\n", f, k, leaves[f][k], minimal[f][k], maxS[f][k]);
  printf("# violations among the minimal leaves: STRONG (|S| > 2^chi_max) %lld, WEAK (|S| > 4) %lld\n", strongv, weakv);
  return 0; }
