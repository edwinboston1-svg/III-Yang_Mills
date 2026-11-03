/* resolve.c -- THE RESOLUTION FORMULA FOR THE SPIN-1/2 HAAR WEIGHT OF A CLOSED SET WITH LINKS OF MULTIPLICITY 2 AND 4 (S1 (p), 2026-11-01
 * 12:1x EST; the author).  At a link traversed by four plaquettes the SU(2) Haar integral of four spin-1/2 matrix elements is Creutz's
 *   int dU U_{i1 j1} U_{i2 j2} U_{i3 j3} U_{i4 j4} = (1/6) [ eps_{i1 i2} eps_{i3 i4} eps_{j1 j2} eps_{j3 j4} + (13|24) + (14|23) ]
 * (Creutz 1978; checked here by the trace: (tr U)^4 integrates to 2), and a two-plaquette link's integral is (1/2) eps eps, so the four-
 * plaquette integral is (2/3) times the SUM OVER THE THREE PAIRINGS of the two-plaquette integrals of the pairs -- for any orientations
 * of the four passages, the inverses being carried by the eps-tensor as in (n).  Hence, for an all-1/2 closed set X with N4 links of
 * multiplicity four, the bare Haar weight is
 *   int prod_p chi_1/2(U_p) = (2/3)^N4  sum over the 3^N4 resolutions rho  prod over the components T of rho  (-1)^{m(T)} 2^{chi(T) - n(T)},
 * every component a closed connected branch-free surface priced by (n)'s law (m its cross-cap count, chi its Euler characteristic, n its
 * plaquettes).  In the page's units (rho = W / u^F, a sphere reading 4) the value is S(X) = (2/3)^N4 sum_rho prod_T (-1)^m 2^chi.
 * This file reads plaquette lists "(x,y,z,t)ab" (the g48 records' format, a,b the plane's directions 1..4), enumerates the resolutions,
 * builds each one's abstract surface (faces glued along the paired passages; vertices the corner classes around each lattice site),
 * reads chi and the orientability (a consistent orientation across every gluing, else non-orientable with m = 2 - chi), and prints S(X)
 * with the resolution census: how many resolutions are connected, spheres, non-orientable; the largest chi; the signed sum.
 * Known answers: a cube reads 4; the F = 18 pinches of the census read 4 (g50: profile (34/0/1/0) rho = 4/1); the double contacts 4
 * ((36/0/2/0)); the two-box waists 32 ((32/0/4/0)).  usage: resolve < file-with-plaquette-tokens */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define MAXP 400
#define MAXL 1600
static int NP = 0, PB[MAXP][4], PA[MAXP], PBb[MAXP];
static int NLK = 0, LK[MAXL][5];           /* link: base site (4) and direction */
static int LINC[MAXL][4][3], LMULT[MAXL];  /* incidences at a link: (plaquette, side 0..3, traversal +1/-1) */
static int PL[MAXP][4], PS[MAXP][4];       /* the plaquette's four links and traversal signs by side */
static int PC[MAXP][4][4];                 /* the plaquette's four corners (lattice sites) by side: corner k is the start of side k */
static int lfind(const int *b, int d, int create) { for (int i = 0; i < NLK; i++) if (LK[i][4] == d && !memcmp(LK[i], b, sizeof(int) * 4)) return i; if (!create) return -1; if (NLK >= MAXL) { fprintf(stderr, "too many links\n"); exit(1); } memcpy(LK[NLK], b, sizeof(int) * 4); LK[NLK][4] = d; LMULT[NLK] = 0; return NLK++; }
static void add_plaq(int *b, int a, int c) { int p = NP++; memcpy(PB[p], b, sizeof(int) * 4); PA[p] = a; PBb[p] = c;
  /* the boundary walk: side 0 along +a from b; side 1 along +c from b+e_a; side 2 along -a from b+e_a+e_c; side 3 along -c from b+e_c */
  int q[4]; int corners[4][4]; memcpy(corners[0], b, sizeof q); memcpy(corners[1], b, sizeof q); corners[1][a - 1]++; memcpy(corners[2], corners[1], sizeof q); corners[2][c - 1]++; memcpy(corners[3], b, sizeof q); corners[3][c - 1]++;
  for (int k = 0; k < 4; k++) memcpy(PC[p][k], corners[k], sizeof q);
  memcpy(q, b, sizeof q); PL[p][0] = lfind(q, a, 1); PS[p][0] = 1;
  memcpy(q, corners[1], sizeof q); PL[p][1] = lfind(q, c, 1); PS[p][1] = 1;
  memcpy(q, corners[3], sizeof q); PL[p][2] = lfind(q, a, 1); PS[p][2] = -1;    /* the side from b+e_a+e_c back along -a is the link based at b+e_c */
  memcpy(q, b, sizeof q); PL[p][3] = lfind(q, c, 1); PS[p][3] = -1;
  for (int k = 0; k < 4; k++) { int l = PL[p][k]; if (LMULT[l] >= 4) { fprintf(stderr, "a link with more than four plaquettes\n"); exit(1); } LINC[l][LMULT[l]][0] = p; LINC[l][LMULT[l]][1] = k; LINC[l][LMULT[l]][2] = PS[p][k]; LMULT[l]++; } }
static int par[MAXP * 4 + MAXP];
static int fnd(int x) { while (par[x] != x) x = par[x] = par[par[x]]; return x; }
static void uni(int a, int b) { a = fnd(a); b = fnd(b); if (a != b) par[a] = b; }
static int samesite(const int *a, const int *b) { return !memcmp(a, b, sizeof(int) * 4); }
int main(void) {
  char tok[256]; int n4links[MAXL], N4 = 0;
  while (scanf("%255s", tok) == 1) { int b[4], a, c; if (sscanf(tok, "(%d,%d,%d,%d)%1d%1d", &b[0], &b[1], &b[2], &b[3], &a, &c) == 6) { if (NP >= MAXP) { fprintf(stderr, "too many plaquettes\n"); return 1; } if (a < 1 || a > 4 || c < 1 || c > 4 || a >= c) { fprintf(stderr, "bad plane %s\n", tok); return 1; } add_plaq(b, a, c); } }
  if (!NP) { fprintf(stderr, "no plaquettes read\n"); return 1; }
  int bad = 0; for (int l = 0; l < NLK; l++) { if (LMULT[l] == 4) n4links[N4++] = l; else if (LMULT[l] != 2) bad++; }
  if (bad) { printf("RESOLVE REFUSED: %d links with multiplicity other than 2 or 4 (the set is not closed, or branched past four)\n", bad); return 2; }
  if (N4 > 20) { printf("RESOLVE REFUSED: %d four-links (3^%d resolutions)\n", N4, N4); return 2; }
  long nres = 1; for (int i = 0; i < N4; i++) nres *= 3;
  /* the three pairings of four incidences: {01|23}, {02|13}, {03|12} */
  static const int PAIR[3][4] = { {0, 1, 2, 3}, {0, 2, 1, 3}, {0, 3, 1, 2} };
  double sum = 0; long conn = 0, spheres = 0, nonor = 0, byn[64] = {0}; int chimax = -99, chimin = 99;
  int choice[32];
  for (long r = 0; r < nres; r++) { long rr = r; for (int i = 0; i < N4; i++) { choice[i] = rr % 3; rr /= 3; }
    /* glue: the pairs at every link; union-find on plaquettes (components) and on corners (vertices) */
    int ncorn = NP * 4; for (int i = 0; i < ncorn + NP; i++) par[i] = i;   /* corners 0..ncorn-1, plaquettes ncorn..ncorn+NP-1 */
    int E = 0; static int gl[MAXL][2][2]; int ngl = 0;   /* the gluings: (p,side) ~ (q,side') */
    for (int l = 0; l < NLK; l++) { int pairs[2][2]; if (LMULT[l] == 2) { pairs[0][0] = 0; pairs[0][1] = 1; }
      else { int ci = 0; for (int i = 0; i < N4; i++) if (n4links[i] == l) ci = i; const int *pr = PAIR[choice[ci]]; pairs[0][0] = pr[0]; pairs[0][1] = pr[1]; pairs[1][0] = pr[2]; pairs[1][1] = pr[3]; }
      for (int t = 0; t < (LMULT[l] == 4 ? 2 : 1); t++) { int p = LINC[l][pairs[t][0]][0], s = LINC[l][pairs[t][0]][1], q = LINC[l][pairs[t][1]][0], s2 = LINC[l][pairs[t][1]][1];
        uni(ncorn + p, ncorn + q); E++;
        /* the side's two corners: corner s (its start) and corner (s+1)%4 (its end), identified with q's corners at the same lattice sites */
        for (int k = 0; k < 2; k++) { int cp = (s + k) % 4; for (int k2 = 0; k2 < 2; k2++) { int cq = (s2 + k2) % 4; if (samesite(PC[p][cp], PC[q][cq])) uni(p * 4 + cp, q * 4 + cq); } }
        gl[ngl][0][0] = p; gl[ngl][0][1] = s; gl[ngl][1][0] = q; gl[ngl][1][1] = s2; ngl++; } }
    /* components and their chi: V = corner classes, E = gluings, F = plaquettes, per component */
    int ncomp = 0; static int croot[MAXP], cV[MAXP], cE[MAXP], cF[MAXP]; for (int p = 0; p < NP; p++) { int rt = fnd(ncorn + p); int idx = -1; for (int i = 0; i < ncomp; i++) if (croot[i] == rt) idx = i; if (idx < 0) { idx = ncomp++; croot[idx] = rt; cV[idx] = cE[idx] = cF[idx] = 0; } cF[idx]++; }
    for (int i = 0; i < ncorn; i++) if (fnd(i) == i) { int p = i / 4, rt = fnd(ncorn + p); for (int c = 0; c < ncomp; c++) if (croot[c] == rt) cV[c]++; }
    for (int g = 0; g < ngl; g++) { int rt = fnd(ncorn + gl[g][0][0]); for (int c = 0; c < ncomp; c++) if (croot[c] == rt) cE[c]++; }
    /* orientability per component: sigma_p in {+1,-1} with sigma_p * sign_p(side) = - sigma_q * sign_q(side') across every gluing (the
       two faces traverse a shared edge oppositely under a consistent orientation); a contradiction makes the component non-orientable,
       with m = 2 - chi cross-caps and the sign (-1)^m of (n)'s law */
    static int sig[MAXP]; for (int p = 0; p < NP; p++) sig[p] = 0;
    double w = 1; int chitot = 0;
    for (int c = 0; c < ncomp; c++) { int rt = croot[c], ok = 1;
      for (int p0 = 0; p0 < NP; p0++) { if (fnd(ncorn + p0) != rt || sig[p0]) continue; sig[p0] = 1; int stack[MAXP], sp = 0; stack[sp++] = p0;
        while (sp) { int p = stack[--sp]; for (int g = 0; g < ngl; g++) { int a = -1, b = -1; if (gl[g][0][0] == p) { a = 0; b = 1; } else if (gl[g][1][0] == p) { a = 1; b = 0; } else continue;
            int q = gl[g][b][0], sa = PS[p][gl[g][a][1]], sb = PS[q][gl[g][b][1]]; int want = -sig[p] * sa * sb; if (!sig[q]) { sig[q] = want; stack[sp++] = q; } else if (sig[q] != want) ok = 0; } } }
      int chi = cV[c] - cE[c] + cF[c]; chitot += chi; w *= pow(2.0, chi); if (!ok) { nonor++; if ((2 - chi) % 2) w = -w; } }
    sum += w; if (ncomp == 1) conn++; if (ncomp == 1 && chitot == 2) spheres++; if (chitot > chimax) chimax = chitot; if (chitot < chimin) chimin = chitot; if (ncomp < 64) byn[ncomp]++; }
  double S = sum; for (int i = 0; i < N4; i++) S *= 2.0 / 3.0;
  printf("RESOLVE F=%d links=%d (two-plaquette %d, four-plaquette %d): %ld resolutions, %ld connected (%ld spheres), chi from %d to %d; components census:", NP, NLK, NLK - N4, N4, nres, conn, spheres, chimin, chimax);
  for (int k = 1; k < 64; k++) if (byn[k]) printf(" %d:%ld", k, byn[k]); printf("\n");
  printf("RESOLVE signed sum of 2^chi over the resolutions = %.10g; S(X) = (2/3)^%d x that = %.12g  (a sphere's units: a cube reads 4)\n", sum, N4, S);
  return 0; }
