/* boxenum.c -- THE FIRST INSTRUMENT OF S12's REMAINDER (S1 (p), 2026-11-01 12:3x EST; the author): every closed all-1/2 set through
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
static int NO4 = 0;   /* BOX_NO4: every link beyond the seed's four-links held at multiplicity <= 2 */
static int MAXM = 4;   /* BOX_MAX6: the odd rule may raise a link to multiplicity six */
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
typedef struct { double S; int chimax, n4; long nres, conn; long sheet; int b1max; int b1lat; long sidfail, sidtests, sid0fail, sid0tests, aggfail, aggtests; } reading_t;
static double WR[59049]; static long sidprinted = 0;   /* the weight of every resolution of the current leaf (3^10 at most) */
static reading_t resolve_P(void) {
  reading_t out = { 0, -99, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0 };
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
    sum += w; WR[r] = w; if (ncomp == 1) { conn++; if (chitot > out.chimax) { out.chimax = chitot; out.sheet = r; } } }
  out.conn = conn; double S = sum; for (int i = 0; i < N4; i++) S *= 2.0 / 3.0; out.S = S;
  /* THE SURGERY IDENTITY, tested at every four-link and every assignment of the other links: with the sheet's pairing at the link as
     the reference (the pairing the max-chi resolution uses there), the two cross-resolutions' weights must sum to half the reference's --
     W' + W'' = W_s / 2 -- for the census law S(X) = 2^chi(sheet) to follow by the recursion; the failures are counted per leaf */
  out.sidfail = 0; out.sidtests = 0; if (N4 > 0 && out.sheet >= 0) { long rr = out.sheet; int sheetc[16]; for (int i = 0; i < N4; i++) { sheetc[i] = rr % 3; rr /= 3; }
    long pw[16]; pw[0] = 1; for (int i = 1; i < N4; i++) pw[i] = pw[i - 1] * 3;
    for (int i = 0; i < N4; i++) { double agg = 0; for (long r = 0; r < nres; r++) { if ((r / pw[i]) % 3 != sheetc[i]) continue; long b2 = r - sheetc[i] * pw[i]; double s2 = 0; for (int c = 0; c < 3; c++) if (c != sheetc[i]) s2 += WR[b2 + c * pw[i]]; agg += s2 - WR[r] / 2; }
      out.aggtests++; if (fabs(agg) > 1e-9 * (1 + fabs(WR[out.sheet]))) out.aggfail++; }   /* THE AGGREGATE IDENTITY per link: S(X') + S(X'') = S(X_sheet)/2 summed over the others' assignments -- what the recursion S(X) = S(X_sheet) needs */
    for (int i = 0; i < N4; i++) for (long r = 0; r < nres; r++) { if ((r / pw[i]) % 3 != sheetc[i]) continue;   /* r has the sheet's pairing at link i */
        long base = r - sheetc[i] * pw[i]; double ws = WR[r], wc = 0; for (int c = 0; c < 3; c++) if (c != sheetc[i]) wc += WR[base + c * pw[i]]; int stage0 = (base == out.sheet - sheetc[i] * pw[i]); if (stage0) out.sid0tests++;
        out.sidtests++; if (fabs(wc - ws / 2) > 1e-9 * (1 + fabs(ws))) { out.sidfail++; if (stage0) out.sid0fail++; if (getenv("SID_DEBUG") && sidprinted++ < 12) { double w1 = -1e300, w2 = -1e300; int k = 0; for (int c = 0; c < 3; c++) if (c != sheetc[i]) { if (k++ == 0) w1 = WR[base + c * pw[i]]; else w2 = WR[base + c * pw[i]]; } printf("SID-FAIL F=%d N4=%d link %d: the others at %ld: W_sheet=%.6g W_cross=%.6g,%.6g (sum %.6g, half the sheet %.6g)\n", F, N4, i, r, ws, w1, w2, w1 + w2, ws / 2); } } } }
  /* THE CONTACT GRAPH ON THE SHEET (the resolution of largest chi): its edges the two glued passages of every four-link (each a
     preimage edge of the contact link on the sheet), its vertices the corner classes of the sheet; the cycle rank of each component
     E - V + 1; the largest over the components is the staked case's measure (S12's remainder begins at cycle rank two) */
  out.b1max = 0; if (N4 > 0 && out.sheet >= 0) { long rr = out.sheet; for (int i = 0; i < N4; i++) { choice[i] = rr % 3; rr /= 3; }
    int ncorn = F * 4; for (int i = 0; i < ncorn; i++) par[i] = i;
    /* corner classes of the sheet: all gluings (two-links and four-links) */
    static int ev[MAXF * 8][2]; int ne = 0;
    for (int i = 0; i < nl; i++) { int pairs[2][2]; int ci = -1; if (lm[i] == 4) { for (int j = 0; j < N4; j++) if (n4[j] == i) ci = j; const int *pr = PAIR[choice[ci]]; pairs[0][0] = pr[0]; pairs[0][1] = pr[1]; pairs[1][0] = pr[2]; pairs[1][1] = pr[3]; } else { pairs[0][0] = 0; pairs[0][1] = 1; }
      for (int t = 0; t < (lm[i] == 4 ? 2 : 1); t++) { int p = lp[i][pairs[t][0]][0], s = lp[i][pairs[t][0]][1], q = lp[i][pairs[t][1]][0], s2 = lp[i][pairs[t][1]][1];
        for (int k = 0; k < 2; k++) { int cp = (s + k) % 4; for (int k2 = 0; k2 < 2; k2++) { int cq = (s2 + k2) % 4; if (!memcmp(lc[p][cp], lc[q][cq], sizeof(int) * 4)) uni(p * 4 + cp, q * 4 + cq); } }
        if (lm[i] == 4) { ev[ne][0] = p * 4 + s; ev[ne][1] = p * 4 + (s + 1) % 4; ne++; } } }   /* the preimage edge: the side's two corners on the sheet */
    /* the contact graph's components over the sheet's vertices (corner classes): union-find on a second array keyed by class roots */
    static int cpar[MAXF * 4]; for (int i = 0; i < ncorn; i++) cpar[i] = i;
    int vtx[MAXF * 8][2]; for (int e = 0; e < ne; e++) { vtx[e][0] = fnd(ev[e][0]); vtx[e][1] = fnd(ev[e][1]); int a = vtx[e][0], b = vtx[e][1]; while (cpar[a] != a) a = cpar[a]; while (cpar[b] != b) b = cpar[b]; if (a != b) cpar[a] = b; }
    static int rootE[MAXF * 8], rootV[MAXF * 8], roots[MAXF * 8]; int nr = 0;
    for (int e = 0; e < ne; e++) { int a = vtx[e][0]; while (cpar[a] != a) a = cpar[a]; int idx = -1; for (int i = 0; i < nr; i++) if (roots[i] == a) idx = i; if (idx < 0) { idx = nr++; roots[idx] = a; rootE[idx] = 0; rootV[idx] = 0; } rootE[idx]++; }
    /* the vertices of each component: the distinct class roots among its edges' ends */
    static int seenv[MAXF * 8]; int nsv = 0; for (int e = 0; e < ne; e++) for (int k = 0; k < 2; k++) { int v = vtx[e][k]; int dup = 0; for (int i = 0; i < nsv; i++) if (seenv[i] == v) dup = 1; if (dup) continue; seenv[nsv++] = v; int a = v; while (cpar[a] != a) a = cpar[a]; for (int i = 0; i < nr; i++) if (roots[i] == a) rootV[i]++; }
    for (int i = 0; i < nr; i++) { int b1 = rootE[i] - rootV[i] + 1; if (b1 > out.b1max) out.b1max = b1; } }
  /* THE CONTACT LINKS IN THE LATTICE: the cycle rank of the graph whose edges are the four-links and whose vertices are their
     endpoints in Z^4 -- Lemma S6's hypothesis (the links of multiplicity >= 4 form a forest) is b1lat = 0; a lattice cycle needs
     N4 >= 4 on the bipartite lattice, so b1lat >= 1 is the first object outside S6 (S12's remainder) */
  out.b1lat = 0; if (N4 > 0) { static int ept[2 * MAXF * 4][4]; static int epar[2 * MAXF * 4]; int nep = 0; int ends[MAXF * 4][2];
    for (int j = 0; j < N4; j++) { int i = n4[j]; int p = lp[i][0][0], s = lp[i][0][1];
      for (int k = 0; k < 2; k++) { const int *c = lc[p][(s + k) % 4][0]; int idx = -1; for (int t = 0; t < nep; t++) if (!memcmp(ept[t], c, sizeof(int) * 4)) idx = t;
        if (idx < 0) { idx = nep++; memcpy(ept[idx], c, sizeof(int) * 4); epar[idx] = idx; } ends[j][k] = idx; } }
    int comps = nep; for (int j = 0; j < N4; j++) { int a = ends[j][0], b = ends[j][1]; while (epar[a] != a) a = epar[a]; while (epar[b] != b) b = epar[b]; if (a != b) { epar[a] = b; comps--; } }
    out.b1lat = N4 - nep + comps; }
  return out; }
#include "cut_reader_w.c"
static long long ctok = 0, ctref[5] = {0}, six[MAXF] = {0}, sixmin[MAXF] = {0}, sixviol = 0, sixshown = 0, tr_tests = 0, tr_fails = 0, tr_shown = 0, tm_tests = 0, tm_fails = 0, tm_shown = 0; static double sixmax[MAXF] = {0};
static long long wg_tests = 0, wg_fails = 0, pr_tests = 0, pr_cells[2][2] = {{0,0},{0,0}}, r2_min = 0, r2_shown = 0, pr_shown = 0;
/* ---- the census */
static long long leaves[MAXF][16], minimal[MAXF][16], byb1[MAXF][8], bylat[MAXF][8], latcyc = 0, unread = 0, strongv = 0, weakv = 0, shown = 0, staked = 0, sidtests = 0, sidfails = 0, sidleaves = 0, sidshown = 0, sid0tests = 0, sid0fails = 0, aggtests = 0, aggfails = 0; static double maxS[MAXF][16], maxSb1[MAXF][8], maxSlat[MAXF][8];
static void record(void) { if (seen()) { dups++; return; }
  reading_t r = resolve_P(); cut_t ct = cut_P();
  if (ct.ok == 1) { ctok++; if (ct.n6 > 0) { six[F]++; if (ct.minimal) { sixmin[F]++; double a = fabs(ct.S); if (a > sixmax[F]) sixmax[F] = a;
        if (a > 4 + 1e-9) { sixviol++; printf("SIX-LEAF F=%d contacts=%d six-links=%d r=%d pieces=%d chi_cut=%d circles=%d I=%lld S_cut=%.10g THE-SEXTUPLE-VIOLATION plaquettes:", F, ct.nc, ct.n6, ct.r, ct.m, ct.chi, ct.nb, ct.I, ct.S); for (int i = 0; i < F; i++) { long s = P[i] / NPAIR; int k = (int)(P[i] % NPAIR); int x[4]; coords(s, x); printf(" (%d,%d,%d,%d)%d%d", x[0], x[1], x[2], x[3], PMU[k] + 1, PNU[k] + 1); } printf("\n"); fflush(stdout); }
        else if (sixshown++ < 10) { printf("SIX-LEAF F=%d contacts=%d six-links=%d r=%d pieces=%d chi_cut=%d circles=%d I=%lld S_cut=%.10g minimal plaquettes:", F, ct.nc, ct.n6, ct.r, ct.m, ct.chi, ct.nb, ct.I, ct.S); for (int i = 0; i < F; i++) { long s = P[i] / NPAIR; int k = (int)(P[i] % NPAIR); int x[4]; coords(s, x); printf(" (%d,%d,%d,%d)%d%d", x[0], x[1], x[2], x[3], PMU[k] + 1, PNU[k] + 1); } printf("\n"); fflush(stdout); } } } }
  else { int c = -ct.ok; ctref[c < 5 ? c : 4]++; }
  if (r.n4 < 0) return; if (r.nres < 0) { unread++; return; }
  if (ct.ok == 1) { int rmin = (r.conn == r.nres); tr_tests++; if (fabs(r.S - ct.S) > 1e-9 * (1 + fabs(r.S))) { tr_fails++; if (tr_shown++ < 10) printf("TWO-ROAD-PART F=%d N4=%d S_res=%.10g S_cut=%.10g chi_cut=%d circles=%d I=%lld r=%d pieces=%d nonorientable=%d\n", F, r.n4, r.S, ct.S, ct.chi, ct.nb, ct.I, ct.r, ct.m, ct.nonor); }
  if (ct.ok == 1 && ct.r == 1 && ct.wg_ok == 1) { wg_tests++; if (ct.wg_agree != 1) { wg_fails++; printf("WEINGARTEN-PART F=%d r=1 character-road I=%lld weingarten %lld/%lld\n", F, ct.I, ct.wN, ct.wD); } }
  if (ct.ok == 1 && ct.r >= 1 && r.conn == r.nres && ct.prim >= 0) { int law = fabs(r.S - pow(2.0, r.chimax)) <= 1e-9 * (1 + fabs(r.S)); pr_tests++; pr_cells[ct.prim][law]++;
    if (ct.r >= 2) { r2_min++; if (r2_shown++ < 20) { printf("RANK-LEAF F=%d N4=%d r=%d pieces=%d chi_cut=%d circles=%d I=%lld/%lld S_cut=%.10g S_res=%.10g chimax=%d %s words=%d minlen=%d plaquettes:", F, r.n4, ct.r, ct.m, ct.chi, ct.nb, ct.wN, ct.wD, ct.S, r.S, r.chimax, ct.prim ? "PRIMITIVE" : "NOT-PRIMITIVE", ct.nwords, ct.minlen); for (int i = 0; i < F; i++) { long s = P[i] / NPAIR; int k = (int)(P[i] % NPAIR); int x[4]; coords(s, x); printf(" (%d,%d,%d,%d)%d%d", x[0], x[1], x[2], x[3], PMU[k] + 1, PNU[k] + 1); } printf("\n"); fflush(stdout); } }
    if (!ct.prim && pr_shown++ < 20) { printf("NOT-PRIMITIVE-LEAF F=%d N4=%d r=%d pieces=%d S_res=%.10g chimax=%d words=%d minlen=%d%s\n", F, r.n4, ct.r, ct.m, r.S, r.chimax, ct.nwords, ct.minlen, law ? " (the census law holds)" : " (THE CENSUS LAW FAILS)"); fflush(stdout); } }
    tm_tests++; if (rmin != ct.minimal) { tm_fails++; if (tm_shown++ < 10) printf("TWO-ROAD-MINIMALITY-PART F=%d N4=%d resolutions-connected=%d rank-criterion=%d\n", F, r.n4, rmin, ct.minimal); } }
  int n4 = r.n4 < 15 ? r.n4 : 15; leaves[F][n4]++; if (r.conn != r.nres) return;   /* not minimal: a disconnected resolution */
  minimal[F][n4]++; double aS = fabs(r.S); if (aS > maxS[F][n4]) maxS[F][n4] = aS; int b1 = r.b1max < 7 ? r.b1max : 7; byb1[F][b1]++; if (aS > maxSb1[F][b1]) maxSb1[F][b1] = aS; int bl = r.b1lat < 7 ? r.b1lat : 7; bylat[F][bl]++; if (aS > maxSlat[F][bl]) maxSlat[F][bl] = aS; if (r.b1lat >= 1) latcyc++;
  int strong = aS > pow(2.0, r.chimax) + 1e-9, weak = aS > 4 + 1e-9; if (strong) strongv++; if (weak) weakv++; if (r.b1max >= 2) staked++;
  sidtests += r.sidtests; sidfails += r.sidfail; if (r.sidfail) sidleaves++; sid0tests += r.sid0tests; sid0fails += r.sid0fail; aggtests += r.aggtests; aggfails += r.aggfail;
  if (strong || r.b1max >= 1 || r.b1lat >= 1 || (r.sidfail && sidshown++ < 10) || (n4 >= 2 && shown < 20)) { shown++; printf("BOX-LEAF F=%d N4=%d S=%.10g chimax=%d resolutions=%ld b1max=%d b1lat=%d surgery-identity %ld/%ld fail %s%s%s%splaquettes:", F, r.n4, r.S, r.chimax, r.nres, r.b1max, r.b1lat, r.sidfail, r.sidtests, strong ? "STRONG-VIOLATION " : "", weak ? "WEAK-VIOLATION " : "", r.b1max >= 2 ? "THE-STAKED-KIND " : "", r.b1lat >= 1 ? "THE-LATTICE-CYCLE " : "");
    for (int i = 0; i < F; i++) { long s = P[i] / NPAIR; int k = (int)(P[i] % NPAIR); int x[4]; coords(s, x); printf(" (%d,%d,%d,%d)%d%d", x[0], x[1], x[2], x[3], PMU[k] + 1, PNU[k] + 1); } printf("\n"); fflush(stdout); } }
static void search(void) { nodes++; if (nodes > NODEMAX) return;
  if (nodd == 0) { record(); return; }
  if (F + (nodd + 3) / 4 > FMAX) return;
  long l = oddL[0]; for (int i = 1; i < nodd; i++) if (oddL[i] < l) l = oddL[i];
  long Q[16]; int nq = link_plaqs(l, Q);
  for (int qi = 0; qi < nq; qi++) { long q = Q[qi]; if (inP[q] || !in_box(q)) continue;
    long L4[4]; plaq_links(q, L4); int ok = 1; for (int a = 0; a < 4; a++) if (mult[L4[a]] >= (NO4 ? 2 : MAXM)) ok = 0; if (!ok) continue;
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
  if (getenv("BOX_NO4")) NO4 = 1;
  if (getenv("BOX_MAX6")) MAXM = 6;
  if (getenv("BOX_SEED")) {   /* THE SEED: plaquette tokens (x,y,z,t)ab, the record format, in place of the corner plaquette */
    char *sd = strdup(getenv("BOX_SEED")); int ns = 0; for (char *tok = strtok(sd, " \t\n"); tok; tok = strtok(NULL, " \t\n")) { int b[4], a, c;
      if (sscanf(tok, "(%d,%d,%d,%d)%1d%1d", &b[0], &b[1], &b[2], &b[3], &a, &c) != 6 || a < 1 || a > 4 || c < 1 || c > 4 || a >= c) { fprintf(stderr, "bad seed token %s\n", tok); return 1; }
      long s = site_of(b); long q = plaq_id(s, pair_index(a - 1, c - 1)); if (!in_box(q)) { fprintf(stderr, "seed plaquette %s outside the box\n", tok); return 1; } if (inP[q]) { fprintf(stderr, "seed plaquette %s twice\n", tok); return 1; }
      inP[q] = 1; P[F++] = q; long L4[4]; plaq_links(q, L4); for (int k = 0; k < 4; k++) { int was = mult[L4[k]] & 1; mult[L4[k]]++; int now = mult[L4[k]] & 1; if (was && !now) del_odd(L4[k]); else if (!was && now) add_odd(L4[k]); } ns++; }
    int n4s = 0, over = 0, n6s = 0; for (long l = 0; l < NS * D; l++) { if (mult[l] == 4) n4s++; else if (mult[l] == 6 && MAXM == 6) n6s++; else if (mult[l] == 3 || mult[l] == 5 || mult[l] > 4) over++; }
    printf("# SEED: %d plaquettes planted, %d odd links, %d four-links, %d links at three or above four%s; BOX_NO4=%d\n", ns, nodd, n4s, over, over ? " (REFUSED)" : "", NO4); if (over) return 4; if (ns == 0) { fprintf(stderr, "empty seed\n"); return 1; } }
  else { inP[p0] = 1; P[F++] = p0; { long L4[4]; plaq_links(p0, L4); for (int a = 0; a < 4; a++) { mult[L4[a]] = 1; add_odd(L4[a]); } } }
  search();
  printf("# boxenum box %dx%dx%dx%d FMAX=%d: nodes %lld (cap %lld)%s, DUP %lld, leaves with more than ten four-links unread %lld\n", L[0], L[1], L[2], L[3], FMAX, nodes, NODEMAX, nodes > NODEMAX ? " CAP REACHED (the census is partial)" : "", dups, unread);
  printf("# F N4 leaves minimal max|S|(minimal)\n");
  for (int f = 1; f <= FMAX; f++) for (int k = 0; k < 16; k++) if (leaves[f][k]) printf("%2d %2d %10lld %10lld %.6g\n", f, k, leaves[f][k], minimal[f][k], maxS[f][k]);
  printf("# F b1max minimal max|S| -- the minimal leaves by the largest cycle rank of a contact component on the sheet (the staked kind at b1max >= 2)\n");
  for (int f = 1; f <= FMAX; f++) for (int k = 0; k < 8; k++) if (byb1[f][k]) printf("%2d %2d %10lld %.6g\n", f, k, byb1[f][k], maxSb1[f][k]);
  printf("# F b1lat minimal max|S| -- the minimal leaves by the cycle rank of the contact links IN THE LATTICE (Lemma S6's hypothesis is b1lat = 0; b1lat >= 1 is outside S6, S12's remainder)\n");
  for (int f = 1; f <= FMAX; f++) for (int k = 0; k < 8; k++) if (bylat[f][k]) printf("%2d %2d %10lld %.6g\n", f, k, bylat[f][k], maxSlat[f][k]);
  printf("# minimal leaves whose contact links hold a LATTICE cycle (outside Lemma S6): %lld\n", latcyc);
  printf("# THE CUT FORMULA AS THE SECOND ROAD: %lld leaves read (refused: %lld bad multiplicity, %lld boundary degree, %lld cycle rank >= 2, %lld no chord); against the resolution formula on the 2/4-link leaves: %lld compared, %lld PARTED; minimality (resolutions connected vs the rank criterion): %lld compared, %lld PARTED\n", ctok, ctref[1], ctref[2], ctref[3], ctref[4], tr_tests, tr_fails, tm_tests, tm_fails);
  printf("# SIX-FOLD LINKS (read by the cut formula alone; admitted by the odd rule under BOX_MAX6=%d): F leaves minimal max|S|(minimal)\n", MAXM == 6);
  for (int f = 1; f <= FMAX; f++) if (six[f]) printf("%2d %10lld %10lld %.6g\n", f, six[f], sixmin[f], sixmax[f]);
  printf("# minimal leaves with a six-fold link and |S| > 4 (THE SEXTUPLE VIOLATION of S12's bound): %lld\n", sixviol);
  printf("# THE WEINGARTEN STEP against the character road at cycle rank one: %lld compared, %lld PARTED; THE PRIMITIVITY COLUMN on the minimal leaves with a contact cycle: %lld read -- PRIMITIVE and S = 2^chi_max %lld, PRIMITIVE and S != 2^chi_max %lld, NOT-PRIMITIVE and S = 2^chi_max %lld, NOT-PRIMITIVE and S != 2^chi_max %lld; minimal leaves of cycle rank >= 2 read by both roads: %lld\n", wg_tests, wg_fails, pr_tests, pr_cells[1][1], pr_cells[1][0], pr_cells[0][1], pr_cells[0][0], r2_min);
  printf("# violations among the minimal leaves: STRONG (|S| > 2^chi_max) %lld, WEAK (|S| > 4) %lld; minimal leaves of the staked kind (b1max >= 2) %lld\n", strongv, weakv, staked);
  printf("# the surgery identity (W' + W'' = W_sheet / 2 at every four-link and every assignment of the others): %lld tests on the minimal leaves, %lld failures, on %lld leaves\n", sidtests, sidfails, sidleaves);
  printf("# the surgery identity AT THE SHEET STAGE (every other four-link in its sheet pairing): %lld tests on the minimal leaves, %lld failures\n", sid0tests, sid0fails);
  printf("# THE AGGREGATE IDENTITY per contact link (the two cross weights summed over the others' assignments = half the sheet-paired sum, i.e. S(X) = S(X_sheet)): %lld links tested on the minimal leaves, %lld failures\n", aggtests, aggfails);
  return 0; }
