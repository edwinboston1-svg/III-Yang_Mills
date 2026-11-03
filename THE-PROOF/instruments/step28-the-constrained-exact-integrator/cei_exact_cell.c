/* cei_exact_cell.c -- THE CERTIFIED TIER'S FIFTH STONE: THE STRIP CELL'S TRANSFER MATRIX WITH CERTIFIED ENTRIES (the author
   db5968f8, 2026-11-03 05:3x EST; the author's assignment after the k-block split: "cei_exact_cell.c (Stone 5) with the floating spectrum
   as its known answer (lambda_1 = 3.6097197687738e18, the singlet at lambda_1/1552.958844 at W2); this development re-derives on a road it did
   not write").  Shares no line with cei_face.c; the geometry is this author's own (flux_table.c's conventions), the integrals Stone 1's law,
   the representations Stone 3's monomial basis, the weights Stone 2's enclosures, the single-link scalars anchored on Stone 4's record.

   THE OBJECT (campaign 31.15, 32): the K = 3 strip of planar n = 2 cells in the (1,2) plane -- twelve plaquettes at bases x = -4..1,
   y = 0..1, 32 object links, each in six plaquettes of Z^4 of which one or two are object plaquettes and the rest DATUM plaquettes
   (staples: the three outside links' product T, the identity at the ordered datum); the substitution (CEI_SUBST=1) fixes the ten coarse
   edges at the identity -- each edge two consecutive loop steps [p, e], the second link eliminated, U_e^{se} = U_p^{-sp}: every cycle step
   on e becomes a step on p (tau = se: (p, -sp); else (p, +sp)) and e's staples become p's inverse staples, read at U_e = (U_p^{-sp})^{se}.
   The sweep follows the order file (strip_K3.ord, the author's), the eliminated links skipped; a link's TENSOR over its slots (its steps in
   the object cycles) is the Haar integral of its staple weights times the D-matrices of its steps; the state is a function of the open
   wires' indices and the open cycles' spins; a cycle closing multiplies by its Wilson coefficient c_s = (s+1) I_{s+1}(beta)/I_1(beta)
   (the plaquette weight 1 + sum_s c_s chi_s, the chi_s realised by the wire trace around the cycle).  THE TRANSFER OPERATOR: every basis
   vector of the cut after step 19 carried through steps 20..29 and read in the translated basis (cycles +4, wires +16).

   THE ARITHMETIC: every number a midpoint-radius complex interval (every operation inflates its radius by its rounding); the Wilson
   coefficients Stone 2's enclosures (18 digits printed, the width 1e-165, so two ulps here); the Haar moments by the monomial law as
   doubles with their rounding; the D-matrix entries polynomials in (w, x, y, z) with Gaussian-integer coefficients (exact in double);
   the staple weight at the identity datum P(w) = 1 + sum_k c_k U_k(w), a polynomial in w alone; its powers interval polynomials.
   So each tensor entry is  int P(w)^n prod_j D^{s_j}(U^{sigma_j})_{a_j b_j} dmu,  the product expanded in monomials and integrated term
   by term.  Polynomials are SPARSE (a term list over the monomial index), the products accumulated in a dense scratch.

   KNOWN ANSWERS: (K1) Stone 1's moments 1/4, 1/8, 1/24, 5/64, 1/192; (K2) the trace of Stone 3's D^s equals U_s(w) on the sphere (the
   polynomial identity holds modulo w^2 + x^2 + y^2 + z^2 = 1, so it is read at twenty random unit quaternions), s <= 4; (K3) the
   homomorphism at two rational unit quaternions and the inverse table, s <= 3; (K4) Stone 4's nine single-link scalars S(n; spins) at the
   cap 4 (a negative spin in its record is an ABSENT slot), to the doubles' precision; (K5) the geometry: 32 links, 12 plaquettes, 248
   outside links, the staple census, 22 survivors, the cut after step 19 of dimension 196; (K6) THE SPECTRUM: the float dump's trace
   3.825586047617150e18 and lambda_1 = 3.6097197687738e18 inside this matrix's enclosures (the trace basis-free), the certified gaps read by
   certspec on the interval entries.
   USAGE: cei_exact_cell [W] [out-file]   (W = 2; the interval matrix written as "# T n x n (row-major; re im rad)") */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
#include <io.h>
#include <fcntl.h>
typedef double complex C;
static const double EPS = 2.220446049250313e-16;
/* ---------- intervals: midpoint-radius complex ---------- */
typedef struct { C m; double r; } IV;
static double up(double x) { return x * (1 + 4 * EPS) + 1e-300; }
static IV iv(C m, double r) { IV v; v.m = m; v.r = r; return v; }
static IV iadd(IV a, IV b) { IV v; v.m = a.m + b.m; v.r = up(a.r + b.r + EPS * cabs(v.m)); return v; }
static IV imul(IV a, IV b) { IV v; v.m = a.m * b.m; v.r = up(cabs(a.m) * b.r + cabs(b.m) * a.r + a.r * b.r + 2 * EPS * cabs(v.m)); return v; }
/* ---------- the monomials in (w, x, y, z) to degree DEG, indexed ---------- */
#define DEG 26
static int NMON = 0; static int *MA, *MB, *MC, *MD; static int ****MIDX;
static void mon_init(void) { int cap = 0; for (int a = 0; a <= DEG; a++) for (int b = 0; a + b <= DEG; b++) for (int c = 0; a + b + c <= DEG; c++) for (int d = 0; a + b + c + d <= DEG; d++) cap++;
  MA = malloc(sizeof(int) * cap); MB = malloc(sizeof(int) * cap); MC = malloc(sizeof(int) * cap); MD = malloc(sizeof(int) * cap);
  MIDX = malloc(sizeof(int ***) * (DEG + 1)); for (int a = 0; a <= DEG; a++) { MIDX[a] = malloc(sizeof(int **) * (DEG + 1)); for (int b = 0; b <= DEG; b++) { MIDX[a][b] = malloc(sizeof(int *) * (DEG + 1)); for (int c = 0; c <= DEG; c++) MIDX[a][b][c] = malloc(sizeof(int) * (DEG + 1)); } }
  NMON = 0; for (int a = 0; a <= DEG; a++) for (int b = 0; a + b <= DEG; b++) for (int c = 0; a + b + c <= DEG; c++) for (int d = 0; a + b + c + d <= DEG; d++) { MA[NMON] = a; MB[NMON] = b; MC[NMON] = c; MD[NMON] = d; MIDX[a][b][c][d] = NMON; NMON++; } }
/* ---------- sparse polynomials: a term list; the products accumulate in a dense scratch ---------- */
typedef struct { int n, cap; int *ix; IV *c; int deg; } POLY;
static IV *ACC; static int *MARK, *TOUCH, NTOUCH;
static POLY pnew(void) { POLY p; p.n = 0; p.cap = 16; p.ix = malloc(sizeof(int) * p.cap); p.c = malloc(sizeof(IV) * p.cap); p.deg = 0; return p; }
static void pfree(POLY p) { free(p.ix); free(p.c); }
static void pterm(POLY *p, int ix, IV v) { if (p->n == p->cap) { p->cap *= 2; p->ix = realloc(p->ix, sizeof(int) * p->cap); p->c = realloc(p->c, sizeof(IV) * p->cap); } p->ix[p->n] = ix; p->c[p->n] = v; p->n++; int d = MA[ix] + MB[ix] + MC[ix] + MD[ix]; if (d > p->deg) p->deg = d; }
static void acc_begin(void) { NTOUCH = 0; }
static void acc_add(int k, IV v) { if (!MARK[k]) { MARK[k] = 1; TOUCH[NTOUCH++] = k; ACC[k] = v; } else ACC[k] = iadd(ACC[k], v); }
static POLY acc_end(void) { POLY p = pnew(); for (int t = 0; t < NTOUCH; t++) { int k = TOUCH[t]; MARK[k] = 0; if (ACC[k].m == 0 && ACC[k].r == 0) continue; pterm(&p, k, ACC[k]); } return p; }
static POLY pconst(C v) { POLY p = pnew(); if (v != 0) pterm(&p, MIDX[0][0][0][0], iv(v, 0)); return p; }
static POLY plin(C cw, C cx, C cy, C cz) { POLY p = pnew(); if (cw != 0) pterm(&p, MIDX[1][0][0][0], iv(cw, 0)); if (cx != 0) pterm(&p, MIDX[0][1][0][0], iv(cx, 0)); if (cy != 0) pterm(&p, MIDX[0][0][1][0], iv(cy, 0)); if (cz != 0) pterm(&p, MIDX[0][0][0][1], iv(cz, 0)); return p; }
static POLY pcopy(const POLY a) { POLY p = pnew(); for (int i = 0; i < a.n; i++) pterm(&p, a.ix[i], a.c[i]); return p; }
static POLY pmul(const POLY a, const POLY b) { if (a.deg + b.deg > DEG) { fprintf(stderr, "polynomial degree %d past DEG %d\n", a.deg + b.deg, DEG); exit(2); } acc_begin();
  for (int i = 0; i < a.n; i++) for (int j = 0; j < b.n; j++) { int ia = a.ix[i], ib = b.ix[j]; int k = MIDX[MA[ia] + MA[ib]][MB[ia] + MB[ib]][MC[ia] + MC[ib]][MD[ia] + MD[ib]]; acc_add(k, imul(a.c[i], b.c[j])); }
  return acc_end(); }
static POLY padd(const POLY a, const POLY b) { acc_begin(); for (int i = 0; i < a.n; i++) acc_add(a.ix[i], a.c[i]); for (int j = 0; j < b.n; j++) acc_add(b.ix[j], b.c[j]); return acc_end(); }
static POLY pscale(const POLY a, C s) { POLY p = pnew(); for (int i = 0; i < a.n; i++) pterm(&p, a.ix[i], imul(a.c[i], iv(s, 0))); return p; }
static POLY pscalei(const POLY a, IV s) { POLY p = pnew(); for (int i = 0; i < a.n; i++) pterm(&p, a.ix[i], imul(a.c[i], s)); return p; }
static POLY pconjc(const POLY a) { POLY p = pnew(); for (int i = 0; i < a.n; i++) pterm(&p, a.ix[i], iv(conj(a.c[i].m), a.c[i].r)); return p; }
static POLY ppow(const POLY a, int n) { POLY r = pconst(1); for (int i = 0; i < n; i++) { POLY t = pmul(r, a); pfree(r); r = t; } return r; }
/* ---------- Stone 1: the monomial law on S^3 ---------- */
static double FACT[64];
static double moment(int a, int b, int c, int d, double *rad) {   /* int w^a x^b y^c z^d dmu; rad its rounding */
  if ((a | b | c | d) & 1) { *rad = 0; return 0; } int k[4] = { a / 2, b / 2, c / 2, d / 2 }, K = k[0] + k[1] + k[2] + k[3];
  double num = 1, den = FACT[K + 1]; for (int i = 0; i < 4; i++) { num *= FACT[2 * k[i]]; den *= pow(4.0, k[i]) * FACT[k[i]]; }
  double v = num / den; *rad = up(v * 16 * EPS); return v; }
static IV pint(const POLY p) { IV s = iv(0, 0); for (int i = 0; i < p.n; i++) { int k = p.ix[i]; double rd; double mo = moment(MA[k], MB[k], MC[k], MD[k], &rd); if (mo == 0) continue; s = iadd(s, imul(p.c[i], iv(mo, rd))); } return s; }
static C peval(const POLY p, double w, double x, double y, double z) { C s = 0; for (int i = 0; i < p.n; i++) { int k = p.ix[i]; s += p.c[i].m * pow(w, MA[k]) * pow(x, MB[k]) * pow(y, MC[k]) * pow(z, MD[k]); } return s; }
/* ---------- Stone 3: D^s in the monomial basis, as polynomials ---------- */
/* U = (w, x, y, z) as [[alpha, beta], [-conj beta, conj alpha]], alpha = w + i z, beta = x + i y; Sym^s on u^a v^{s-a}: D^s(U)_{ab} = the
   coefficient of u^b v^{s-b} in (alpha u + beta v)^a (-conj(beta) u + conj(alpha) v)^{s-a}.  For U^-1 = conj U: alpha -> conj alpha, beta -> -beta. */
static void dmat(int s, int inverse, POLY *D) {   /* D[a * (s+1) + b] */
  POLY al = inverse ? plin(1, 0, 0, -I) : plin(1, 0, 0, I); POLY be = inverse ? plin(0, -1, -I, 0) : plin(0, 1, I, 0);
  POLY alc = pconjc(al), bec = pconjc(be); POLY mbec = pscale(bec, -1); int n = s + 1;
  POLY *alp = malloc(sizeof(POLY) * n), *bep = malloc(sizeof(POLY) * n), *mbp = malloc(sizeof(POLY) * n), *acp = malloc(sizeof(POLY) * n);
  for (int i = 0; i <= s; i++) { alp[i] = ppow(al, i); bep[i] = ppow(be, i); mbp[i] = ppow(mbec, i); acp[i] = ppow(alc, i); }
  for (int a = 0; a <= s; a++) for (int b = 0; b <= s; b++) { POLY acc = pconst(0);
    for (int i = 0; i <= a; i++) { int j = b - i; if (j < 0 || j > s - a) continue;
      double cb = FACT[a] / (FACT[i] * FACT[a - i]) * FACT[s - a] / (FACT[j] * FACT[s - a - j]);
      POLY t1 = pmul(alp[i], bep[a - i]); POLY t2 = pmul(mbp[j], acp[s - a - j]); POLY t3 = pmul(t1, t2); POLY t4 = pscale(t3, cb); POLY t5 = padd(acc, t4);
      pfree(t1); pfree(t2); pfree(t3); pfree(t4); pfree(acc); acc = t5; }
    D[a * n + b] = acc; }
  for (int i = 0; i <= s; i++) { pfree(alp[i]); pfree(bep[i]); pfree(mbp[i]); pfree(acp[i]); } free(alp); free(bep); free(mbp); free(acp);
  pfree(al); pfree(be); pfree(alc); pfree(bec); pfree(mbec); }
/* ---------- Stone 2: the Wilson coefficients at beta = 11/5 (the enclosures' printed digits, two ulps) ---------- */
static IV CK[8]; static int WCAP = 2;
static void wilson_init(int cap) { double c[8] = { 1, 0.928958050540840574, 0.466478043979525581, 0.161632304792497, 0.0427711121211912, 0, 0, 0 };
  for (int k = 0; k < 8; k++) CK[k] = iv(c[k], k <= cap ? 2 * EPS * c[k] + (k >= 3 ? 1e-15 : 0) : 0); WCAP = cap; }
/* the Chebyshev polynomials U_k(w) and the staple weight P(w) = 1 + sum_{k<=cap} c_k U_k(w) */
static POLY cheb(int k) { if (k == 0) return pconst(1); POLY u0 = pconst(1), u1 = plin(2, 0, 0, 0); if (k == 1) { pfree(u0); return u1; }
  for (int j = 2; j <= k; j++) { POLY tw = plin(2, 0, 0, 0); POLY t = pmul(tw, u1); POLY m = pscale(u0, -1); POLY u2 = padd(t, m); pfree(tw); pfree(t); pfree(m); pfree(u0); u0 = u1; u1 = u2; }
  pfree(u0); return u1; }
static POLY staple_weight(int cap) { POLY p = pconst(1); for (int k = 1; k <= cap; k++) { POLY u = cheb(k); POLY t = pscalei(u, CK[k]); POLY s = padd(p, t); pfree(p); pfree(u); pfree(t); p = s; } return p; }
/* ---------- the geometry: the K = 3 strip of n = 2 planar cells ---------- */
#define NL 32
#define NPQ 12
static int LX[NL], LY[NL], LDd[NL];
static int lk(int x, int y, int d) { for (int l = 0; l < NL; l++) if (LX[l] == x && LY[l] == y && LDd[l] == d) return l; return -1; }
static int PX[NPQ], PY[NPQ];
static int STL[NPQ][4], STS[NPQ][4];
static int NSTAP[NL], NISTAP[NL], ELIM[NL], PART[NL];
static int NSLOT[NL], SLC[NL][6], SLS[NL][6];
static int ORD[NL], NORD = 0;
static int is_obj_plaq(int x, int y, int d1, int d2) { if (d1 != 1 || d2 != 2) return 0; return x >= -4 && x <= 1 && y >= 0 && y <= 1; }
static void geometry(void) {
  int n = 0; for (int x = -4; x <= 1; x++) for (int y = 0; y <= 2; y++) { LX[n] = x; LY[n] = y; LDd[n] = 1; n++; }
  for (int x = -4; x <= 2; x++) for (int y = 0; y <= 1; y++) { LX[n] = x; LY[n] = y; LDd[n] = 2; n++; }
  if (n != NL) { fprintf(stderr, "links %d\n", n); exit(2); }
  for (int x = 0; x <= 1; x++) for (int y = 0; y <= 1; y++) { int p = y + 2 * x; PX[p] = x; PY[p] = y; }
  for (int f = 1; f <= 2; f++) for (int k = 0; k <= 1; k++) for (int y = 0; y <= 1; y++) { int p = 4 * f + y + 2 * k; PX[p] = -2 * (f - 1) - 1 - k; PY[p] = y; }
  for (int p = 0; p < NPQ; p++) { int x = PX[p], y = PY[p];
    STL[p][0] = lk(x, y, 1); STS[p][0] = 1; STL[p][1] = lk(x + 1, y, 2); STS[p][1] = 1; STL[p][2] = lk(x, y + 1, 1); STS[p][2] = -1; STL[p][3] = lk(x, y, 2); STS[p][3] = -1;
    for (int i = 0; i < 4; i++) if (STL[p][i] < 0) { fprintf(stderr, "plaquette %d step %d has no link\n", p, i); exit(2); } }
  for (int l = 0; l < NL; l++) { NSTAP[l] = 0; int d = LDd[l]; for (int k = 1; k <= 4; k++) { if (k == d) continue; for (int s = -1; s <= 1; s += 2) {
      int bx = LX[l], by = LY[l], bz = 0, bw = 0; if (s < 0) { if (k == 1) bx--; else if (k == 2) by--; else if (k == 3) bz--; else bw--; }
      int d1 = d < k ? d : k, d2 = d < k ? k : d; if (bz == 0 && bw == 0 && is_obj_plaq(bx, by, d1, d2)) continue; NSTAP[l]++; } } }
  int EP[10], ESP[10], EE[10], ESE[10], ne = 0;
  { int st[8][3] = { {0,1,2}, {0,0,2}, {0,0,1}, {1,0,1}, {2,0,2}, {2,1,2}, {1,2,1}, {0,2,1} }; int sg[8] = { -1, -1, 1, 1, 1, 1, -1, -1 };
    for (int e = 0; e < 4; e++) { EP[ne] = lk(st[2*e][0], st[2*e][1], st[2*e][2]); ESP[ne] = sg[2*e]; EE[ne] = lk(st[2*e+1][0], st[2*e+1][1], st[2*e+1][2]); ESE[ne] = sg[2*e+1]; ne++; } }
  for (int f = 1; f <= 2; f++) { int xr = -2 * (f - 1), xl = -2 * f;
    int st[6][3] = { {xr-1,2,1}, {xr-2,2,1}, {xl,1,2}, {xl,0,2}, {xl,0,1}, {xl+1,0,1} }; int sg[6] = { -1, -1, -1, -1, 1, 1 };
    for (int e = 0; e < 3; e++) { EP[ne] = lk(st[2*e][0], st[2*e][1], st[2*e][2]); ESP[ne] = sg[2*e]; EE[ne] = lk(st[2*e+1][0], st[2*e+1][1], st[2*e+1][2]); ESE[ne] = sg[2*e+1]; ne++; } }
  for (int l = 0; l < NL; l++) { ELIM[l] = 0; PART[l] = -1; NISTAP[l] = 0; }
  for (int e = 0; e < ne; e++) { int p = EP[e], sp = ESP[e], el = EE[e], se = ESE[e]; if (p < 0 || el < 0) { fprintf(stderr, "edge %d missing\n", e); exit(2); }
    if (ELIM[el] || ELIM[p]) { fprintf(stderr, "edge %d: a link already eliminated\n", e); exit(2); }
    for (int c = 0; c < NPQ; c++) for (int st = 0; st < 4; st++) if (STL[c][st] == el) { int tau = STS[c][st]; STL[c][st] = p; STS[c][st] = (tau == se) ? -sp : sp; }
    NISTAP[p] += NSTAP[el]; ELIM[el] = 1; PART[p] = el; PART[el] = p; }
  for (int l = 0; l < NL; l++) NSLOT[l] = 0;
  for (int c = 0; c < NPQ; c++) for (int st = 0; st < 4; st++) { int l = STL[c][st]; if (NSLOT[l] >= 6) { fprintf(stderr, "link %d in more than six slots\n", l); exit(2); } SLC[l][NSLOT[l]] = c; SLS[l][NSLOT[l]] = st; NSLOT[l]++; }
  FILE *f = fopen("strip_K3.ord", "r"); if (!f) { fprintf(stderr, "strip_K3.ord missing\n"); exit(2); } int x, y, z, d; NORD = 0;
  while (fscanf(f, "%d %d %d %d", &x, &y, &z, &d) == 4) { int l = lk(x, y, d); if (l < 0 || z != 0) { fprintf(stderr, "order: no link (%d,%d,%d) d%d\n", x, y, z, d); exit(2); } ORD[NORD++] = l; }
  fclose(f); if (NORD != NL) { fprintf(stderr, "order holds %d links\n", NORD); exit(2); } }
/* ---------- the wires: cycle c's wire i is the INPUT wire of step i; step i runs from wire i to wire (i+1) mod 4; wire index = 4c + i ---------- */
static int win(int c, int i) { return 4 * c + i; }
static int wout(int c, int i) { return 4 * c + (i + 1) % 4; }
static int wcyc(int w) { return w / 4; }
/* ---------- the link tensors ---------- */
static int DIMS[8];
typedef struct { int m; int sp[6]; int size; IV *t; } BLK;
static BLK *LT[NL]; static int LNB[NL];
static POLY *DM[2][5];
static void link_tensor(int l, int cap) { int m = NSLOT[l]; int nb = 1; for (int j = 0; j < m; j++) nb *= cap + 1; LNB[l] = nb; LT[l] = malloc(sizeof(BLK) * nb);
  int n = NSTAP[l] + NISTAP[l]; POLY P = staple_weight(cap); POLY Pn = ppow(P, n); pfree(P);
  for (int b = 0; b < nb; b++) { BLK *B = &LT[l][b]; B->m = m; int bb = b, size = 1; for (int j = 0; j < m; j++) { B->sp[j] = bb % (cap + 1); bb /= cap + 1; size *= DIMS[B->sp[j]] * DIMS[B->sp[j]]; } B->size = size; B->t = malloc(sizeof(IV) * size);
    for (int e = 0; e < size; e++) { int rem = e, ab[6][2]; for (int j = m - 1; j >= 0; j--) { int d = DIMS[B->sp[j]]; int ix = rem % (d * d); rem /= d * d; ab[j][0] = ix / d; ab[j][1] = ix % d; }
      POLY prod = pcopy(Pn);
      for (int j = 0; j < m; j++) { int s = B->sp[j], inv = STS[SLC[l][j]][SLS[l][j]] < 0; POLY *Dj = DM[inv][s]; POLY t = pmul(prod, Dj[ab[j][0] * (s + 1) + ab[j][1]]); pfree(prod); prod = t; }
      B->t[e] = pint(prod); pfree(prod); } }
  pfree(Pn); }
/* ---------- the state and the sweep ---------- */
typedef struct { int nopen, open[64]; int ncyc, cyc[NPQ]; int nblk; IV **blk; int *size; } STATE;
static int in_list(int x, const int *L, int n) { for (int i = 0; i < n; i++) if (L[i] == x) return i; return -1; }
static void state_free(STATE *S) { for (int b = 0; b < S->nblk; b++) free(S->blk[b]); free(S->blk); free(S->size); }
static void state_unit(STATE *S) { S->nopen = 0; S->ncyc = 0; S->nblk = 1; S->blk = calloc(1, sizeof(IV *)); S->size = calloc(1, sizeof(int)); S->blk[0] = malloc(sizeof(IV)); S->blk[0][0] = iv(1, 0); S->size[0] = 1; }
static int CAP = 2;
static void process(STATE *S, int l) {
  int m = NSLOT[l]; int sw[12], nsw = 0; for (int j = 0; j < m; j++) { sw[nsw++] = win(SLC[l][j], SLS[l][j]); sw[nsw++] = wout(SLC[l][j], SLS[l][j]); }
  int con[12], ncon = 0, newer[12], nnew = 0; for (int i = 0; i < nsw; i++) { if (in_list(sw[i], S->open, S->nopen) >= 0) con[ncon++] = sw[i]; else newer[nnew++] = sw[i]; }
  STATE N; N.nopen = 0; for (int i = 0; i < S->nopen; i++) if (in_list(S->open[i], con, ncon) < 0) N.open[N.nopen++] = S->open[i]; for (int i = 0; i < nnew; i++) N.open[N.nopen++] = newer[i];
  N.ncyc = 0; for (int i = 0; i < S->ncyc; i++) { int c = S->cyc[i], has = 0; for (int w = 0; w < N.nopen; w++) if (wcyc(N.open[w]) == c) has = 1; if (has) N.cyc[N.ncyc++] = c; }
  for (int w = 0; w < N.nopen; w++) { int c = wcyc(N.open[w]); if (in_list(c, N.cyc, N.ncyc) < 0) N.cyc[N.ncyc++] = c; }
  int closed[NPQ], nclosed = 0; for (int i = 0; i < S->ncyc; i++) if (in_list(S->cyc[i], N.cyc, N.ncyc) < 0) closed[nclosed++] = S->cyc[i];
  N.nblk = 1; for (int i = 0; i < N.ncyc; i++) N.nblk *= CAP + 1; N.blk = calloc(N.nblk, sizeof(IV *)); N.size = calloc(N.nblk, sizeof(int));
  int nclblk = 1; for (int i = 0; i < nclosed; i++) nclblk *= CAP + 1;
  for (int bn = 0; bn < N.nblk; bn++) { int spin[NPQ]; for (int c = 0; c < NPQ; c++) spin[c] = -1;
    { int bb = bn; for (int i = 0; i < N.ncyc; i++) { spin[N.cyc[i]] = bb % (CAP + 1); bb /= CAP + 1; } }
    int ndim[64], nsize = 1; for (int w = 0; w < N.nopen; w++) { ndim[w] = DIMS[spin[wcyc(N.open[w])]]; nsize *= ndim[w]; }
    IV *NB = malloc(sizeof(IV) * nsize); for (int e = 0; e < nsize; e++) NB[e] = iv(0, 0); N.blk[bn] = NB; N.size[bn] = nsize;
    for (int bc = 0; bc < nclblk; bc++) { IV fw = iv(1, 0); { int bb = bc; for (int i = 0; i < nclosed; i++) { int s = bb % (CAP + 1); bb /= CAP + 1; spin[closed[i]] = s; fw = imul(fw, CK[s]); } }
      int bo = 0; { int mul = 1; for (int i = 0; i < S->ncyc; i++) { bo += spin[S->cyc[i]] * mul; mul *= CAP + 1; } }
      int bt = 0; { int mul = 1; for (int j = 0; j < m; j++) { bt += spin[SLC[l][j]] * mul; mul *= CAP + 1; } }
      const IV *OB = S->blk[bo]; const BLK *TB = &LT[l][bt]; if (!OB) continue;
      int ostr[64], tstr[12]; { int mul = 1; for (int i = S->nopen - 1; i >= 0; i--) { ostr[i] = mul; mul *= DIMS[spin[wcyc(S->open[i])]]; } }
      { int mul = 1; for (int i = nsw - 1; i >= 0; i--) { tstr[i] = mul; mul *= DIMS[spin[wcyc(sw[i])]]; } }
      int nos[64], nts[64]; for (int w = 0; w < N.nopen; w++) { int io = in_list(N.open[w], S->open, S->nopen), it = in_list(N.open[w], sw, nsw); nos[w] = io >= 0 ? ostr[io] : 0; nts[w] = it >= 0 ? tstr[it] : 0; }
      int cdim[12], cos_[12], cts[12]; for (int i = 0; i < ncon; i++) { int io = in_list(con[i], S->open, S->nopen), it = in_list(con[i], sw, nsw); cdim[i] = DIMS[spin[wcyc(con[i])]]; cos_[i] = ostr[io]; cts[i] = tstr[it]; }
      int ncomb = 1; for (int i = 0; i < ncon; i++) ncomb *= cdim[i];
      for (int e = 0; e < nsize; e++) { int rem = e, oo = 0, to = 0; for (int w = N.nopen - 1; w >= 0; w--) { int ix = rem % ndim[w]; rem /= ndim[w]; oo += ix * nos[w]; to += ix * nts[w]; }
        IV acc = iv(0, 0); int ci[12] = { 0 };
        for (int q = 0; q < ncomb; q++) { int o2 = oo, t2 = to; for (int i = 0; i < ncon; i++) { o2 += ci[i] * cos_[i]; t2 += ci[i] * cts[i]; } acc = iadd(acc, imul(OB[o2], TB->t[t2]));
          for (int i = ncon - 1; i >= 0; i--) { if (++ci[i] < cdim[i]) break; ci[i] = 0; } }
        NB[e] = iadd(NB[e], imul(fw, acc)); } } }
  state_free(S); *S = N; }
/* ---------- the known answers ---------- */
static unsigned long long RNG = 0x9E3779B97F4A7C15ULL; static double urand(void) { RNG = RNG * 6364136223846793005ULL + 1442695040888963407ULL; return (RNG >> 11) * (1.0 / 9007199254740992.0); }
static void qrand(double *q) { for (;;) { double n = 0; for (int i = 0; i < 4; i++) { q[i] = 2 * urand() - 1; n += q[i] * q[i]; } if (n <= 1 && n > 1e-6) { n = sqrt(n); for (int i = 0; i < 4; i++) q[i] /= n; return; } } }
static double chebval(int k, double w) { double u0 = 1, u1 = 2 * w; if (k == 0) return 1; for (int j = 2; j <= k; j++) { double u2 = 2 * w * u1 - u0; u0 = u1; u1 = u2; } return u1; }
static int kat(void) { int bad = 0;
  double rd; printf("KAT moments: w^2 = %.12g (1/4)  w^4 = %.12g (1/8)  w^2x^2 = %.12g (1/24)  w^6 = %.12g (5/64)  w^2x^2y^2 = %.12g (1/192)  w^3 = %.3g (0)\n", moment(2,0,0,0,&rd), moment(4,0,0,0,&rd), moment(2,2,0,0,&rd), moment(6,0,0,0,&rd), moment(2,2,2,0,&rd), moment(3,0,0,0,&rd));
  if (fabs(moment(2,0,0,0,&rd) - 0.25) > 1e-15 || fabs(moment(4,0,0,0,&rd) - 0.125) > 1e-15 || fabs(moment(2,2,0,0,&rd) - 1.0/24) > 1e-15 || fabs(moment(6,0,0,0,&rd) - 5.0/64) > 1e-15 || fabs(moment(2,2,2,0,&rd) - 1.0/192) > 1e-15) bad++;
  /* K2: the trace of D^s is U_s(w) on the sphere, read at twenty random unit quaternions */
  { double dmax = 0; for (int t = 0; t < 20; t++) { double q[4]; qrand(q); for (int s = 0; s <= 4; s++) { C tr = 0; for (int a = 0; a <= s; a++) tr += peval(DM[0][s][a * (s + 1) + a], q[0], q[1], q[2], q[3]); double d = cabs(tr - chebval(s, q[0])); if (d > dmax) dmax = d; } }
    printf("KAT trace of D^s against U_s(w) at twenty random unit quaternions, s <= 4: max |difference| %.1e\n", dmax); if (dmax > 1e-12) bad++; }
  /* K3: the homomorphism at (3/5, 4/5, 0, 0) and (0, 0, 12/13, 5/13), and the inverse table */
  { double q1[4] = { 0.6, 0.8, 0, 0 }, q2[4] = { 0, 0, 12.0 / 13, 5.0 / 13 };
    double q12[4] = { q1[0]*q2[0] - q1[1]*q2[1] - q1[2]*q2[2] - q1[3]*q2[3], q1[0]*q2[1] + q1[1]*q2[0] + q1[2]*q2[3] - q1[3]*q2[2], q1[0]*q2[2] - q1[1]*q2[3] + q1[2]*q2[0] + q1[3]*q2[1], q1[0]*q2[3] + q1[1]*q2[2] - q1[2]*q2[1] + q1[3]*q2[0] };
    double dmax = 0; for (int s = 1; s <= 3; s++) { int n = s + 1; for (int a = 0; a < n; a++) for (int b = 0; b < n; b++) { C lhs = peval(DM[0][s][a * n + b], q12[0], q12[1], q12[2], q12[3]); C rhs = 0; for (int k = 0; k < n; k++) rhs += peval(DM[0][s][a * n + k], q1[0], q1[1], q1[2], q1[3]) * peval(DM[0][s][k * n + b], q2[0], q2[1], q2[2], q2[3]); double d = cabs(lhs - rhs); if (d > dmax) dmax = d; } }
    printf("KAT homomorphism D(q1 q2) = D(q1) D(q2) at two rational unit quaternions, s <= 3: max |difference| %.1e\n", dmax); if (dmax > 1e-12) bad++;
    dmax = 0; for (int s = 1; s <= 3; s++) { int n = s + 1; for (int a = 0; a < n; a++) for (int b = 0; b < n; b++) { C rhs = 0; for (int k = 0; k < n; k++) rhs += peval(DM[1][s][a * n + k], q1[0], q1[1], q1[2], q1[3]) * peval(DM[0][s][k * n + b], q1[0], q1[1], q1[2], q1[3]); double d = cabs(rhs - (a == b)); if (d > dmax) dmax = d; } }
    printf("KAT the inverse table D(q^-1) D(q) = 1, s <= 3: max |difference| %.1e\n", dmax); if (dmax > 1e-12) bad++; }
  /* K4: Stone 4's nine scalars at the cap 4 -- S(n; spins) = int P4(w)^n prod_j chi_{s_j}(w) dmu, a negative spin an ABSENT slot (the record's convention) */
  { wilson_init(4); POLY P = staple_weight(4); struct { int n; int sp[3]; double want; } T[9] = { {5, {1,-1,-1}, 135.557206063843297184}, {5, {2,-1,-1}, 159.808650887839610813}, {5, {1,1,-1}, 238.174333032471341181}, {5, {2,2,-1}, 362.271715243738609922}, {5, {1,2,1}, 522.080366131578220736}, {4, {2,2,2}, 196.772542321403481745}, {4, {1,1,1}, 104.314789592415531060}, {5, {0,0,0}, 78.365682144631730368}, {3, {2,1,1}, 30.168640390590971627} };
    double dmax = 0; for (int t = 0; t < 9; t++) { POLY Pn = ppow(P, T[t].n); POLY prod = pcopy(Pn); for (int j = 0; j < 3; j++) { if (T[t].sp[j] < 0) continue; POLY u = cheb(T[t].sp[j]); POLY q = pmul(prod, u); pfree(prod); pfree(u); prod = q; }
      IV v = pint(prod); pfree(prod); pfree(Pn); double d = fabs(creal(v.m) - T[t].want) / T[t].want; if (d > dmax) dmax = d; printf("KAT Stone 4 S(%d; %d,%d,%d) = %.18g +- %.1e against the record's %.18g: rel %.1e\n", T[t].n, T[t].sp[0], T[t].sp[1], T[t].sp[2], creal(v.m), v.r, T[t].want, d); }
    printf("KAT Stone 4: nine scalars, max relative difference %.1e (the coefficients carried at 18 digits)\n", dmax); if (dmax > 1e-12) bad++; pfree(P); wilson_init(CAP); }
  printf("KAT %s\n", bad ? "FAILED" : "MET"); return bad; }
/* ---------- main ---------- */
int main(int argc, char **argv) { _setmode(_fileno(stdout), _O_BINARY);
  CAP = argc > 1 ? atoi(argv[1]) : 2; const char *out = argc > 2 ? argv[2] : NULL; if (CAP < 1 || CAP > 4) { fprintf(stderr, "W = 1..4\n"); return 2; }
  FACT[0] = 1; for (int i = 1; i < 64; i++) FACT[i] = FACT[i - 1] * i; for (int s = 0; s < 8; s++) DIMS[s] = s + 1;
  mon_init(); ACC = malloc(sizeof(IV) * NMON); MARK = calloc(NMON, sizeof(int)); TOUCH = malloc(sizeof(int) * NMON);
  printf("CEI-EXACT-CELL W=%d: %d monomials to degree %d\n", CAP, NMON, DEG);
  for (int inv = 0; inv < 2; inv++) for (int s = 0; s <= 4; s++) { DM[inv][s] = malloc(sizeof(POLY) * (s + 1) * (s + 1)); dmat(s, inv, DM[inv][s]); }
  wilson_init(CAP);
  if (kat()) return 1;
  geometry();
  int n5 = 0, n4 = 0, no = 0, nsurv = 0, nout = 0; for (int l = 0; l < NL; l++) { if (!ELIM[l]) nsurv++; int t = NSTAP[l]; if (t == 5) n5++; else if (t == 4) n4++; else no++; }
  { static int seen[64][64][8][8][4]; memset(seen, 0, sizeof seen); for (int l = 0; l < NL; l++) { int d = LDd[l]; for (int k = 1; k <= 4; k++) { if (k == d) continue; for (int s = -1; s <= 1; s += 2) {
        int b[4] = { LX[l], LY[l], 0, 0 }; if (s < 0) b[k - 1]--; int d1 = d < k ? d : k, d2 = d < k ? k : d; if (b[2] == 0 && b[3] == 0 && is_obj_plaq(b[0], b[1], d1, d2)) continue;
        int E[4][5]; memcpy(E[0], b, sizeof(int) * 4); E[0][4] = d1; memcpy(E[1], b, sizeof(int) * 4); E[1][d1 - 1]++; E[1][4] = d2; memcpy(E[2], b, sizeof(int) * 4); E[2][d2 - 1]++; E[2][4] = d1; memcpy(E[3], b, sizeof(int) * 4); E[3][4] = d2;
        for (int i = 0; i < 4; i++) { int ox = E[i][0], oy = E[i][1], oz = E[i][2], ow = E[i][3], od = E[i][4]; if (oz == 0 && ow == 0 && lk(ox, oy, od) >= 0) continue; if (!seen[ox + 32][oy + 32][oz + 4][ow + 4][od - 1]) { seen[ox + 32][oy + 32][oz + 4][ow + 4][od - 1] = 1; nout++; } } } } } }
  int maxslot = 0; for (int l = 0; l < NL; l++) if (!ELIM[l] && NSLOT[l] > maxslot) maxslot = NSLOT[l];
  printf("CEI-EXACT-CELL geometry: %d links, %d plaquettes, %d outside links, staples five=%d four=%d other=%d, %d survivors, %d eliminated, slots per survivor at most %d\n", NL, NPQ, nout, n5, n4, no, nsurv, NL - nsurv, maxslot);
  if (nout != 248 || nsurv != 22) { printf("CEI-EXACT-CELL REFUSED geometry (expected 248 outside links and 22 survivors)\n"); return 1; }
  for (int l = 0; l < NL; l++) if (!ELIM[l]) link_tensor(l, CAP);
  printf("CEI-EXACT-CELL tensors built\n");
  STATE SA; state_unit(&SA); for (int i = 0; i < 19; i++) { if (ELIM[ORD[i]]) continue; process(&SA, ORD[i]); }
  int dim = 0, boff[4096]; for (int b = 0; b < SA.nblk; b++) { boff[b] = dim; dim += SA.size[b]; }
  printf("CEI-EXACT-CELL the cut after step 19: %d open cycles (", SA.ncyc); for (int i = 0; i < SA.ncyc; i++) printf("%sc%d", i ? " " : "", SA.cyc[i]); printf("), %d open wires (", SA.nopen); for (int w = 0; w < SA.nopen; w++) printf("%sw%d", w ? " " : "", SA.open[w]); printf("), dimension %d\n", dim);
  if (dim != 196 && CAP == 2) { printf("CEI-EXACT-CELL REFUSED: the cut's dimension is %d, not 196\n", dim); return 1; }
  IV *T = malloc(sizeof(IV) * (size_t)dim * dim); for (size_t k = 0; k < (size_t)dim * dim; k++) T[k] = iv(0, 0);
  int csh = 4, wsh = 16, bad = 0;
  for (int b = 0; b < SA.nblk; b++) for (int e = 0; e < SA.size[b]; e++) {
    STATE U; U.nopen = SA.nopen; memcpy(U.open, SA.open, sizeof(int) * SA.nopen); U.ncyc = SA.ncyc; memcpy(U.cyc, SA.cyc, sizeof(int) * SA.ncyc); U.nblk = SA.nblk;
    U.blk = calloc(U.nblk, sizeof(IV *)); U.size = calloc(U.nblk, sizeof(int)); for (int b2 = 0; b2 < U.nblk; b2++) { U.size[b2] = SA.size[b2]; U.blk[b2] = malloc(sizeof(IV) * SA.size[b2]); for (int q = 0; q < SA.size[b2]; q++) U.blk[b2][q] = iv(0, 0); } U.blk[b][e] = iv(1, 0);
    for (int i = 19; i < 29; i++) { if (ELIM[ORD[i]]) continue; process(&U, ORD[i]); }
    if (U.ncyc != SA.ncyc || U.nopen != SA.nopen) { printf("CEI-EXACT-CELL REFUSED: the cut after step 29 has %d cycles and %d wires\n", U.ncyc, U.nopen); return 1; }
    int pin[NPQ], pw[64]; for (int i = 0; i < U.ncyc; i++) { pin[i] = in_list(U.cyc[i] - csh, SA.cyc, SA.ncyc); if (pin[i] < 0) bad++; } for (int w = 0; w < U.nopen; w++) { pw[w] = in_list(U.open[w] - wsh, SA.open, SA.nopen); if (pw[w] < 0) bad++; }
    if (bad) { printf("CEI-EXACT-CELL REFUSED: the cut after step 29 is not the translate of the cut after 19\n"); return 1; }
    for (int b2 = 0; b2 < U.nblk; b2++) { int sp[NPQ]; { int bb = b2; for (int i = 0; i < U.ncyc; i++) { sp[i] = bb % (CAP + 1); bb /= CAP + 1; } }
      int bin = 0; for (int i = 0; i < U.ncyc; i++) { int mul = 1; for (int k = 0; k < pin[i]; k++) mul *= CAP + 1; bin += sp[i] * mul; }
      int spinin[NPQ]; for (int c = 0; c < NPQ; c++) spinin[c] = -1; for (int i = 0; i < U.ncyc; i++) spinin[SA.cyc[pin[i]]] = sp[i];
      int sin_[64]; { int mul = 1; for (int i = SA.nopen - 1; i >= 0; i--) { sin_[i] = mul; mul *= DIMS[spinin[wcyc(SA.open[i])]]; } }
      int od[64]; for (int w = 0; w < U.nopen; w++) { int ci = 0; for (int i = 0; i < U.ncyc; i++) if (wcyc(U.open[w]) == U.cyc[i]) ci = i; od[w] = DIMS[sp[ci]]; }
      for (int e2 = 0; e2 < U.size[b2]; e2++) { IV v = U.blk[b2][e2]; if (v.m == 0 && v.r == 0) continue; int rem = e2, ein = 0; for (int w = U.nopen - 1; w >= 0; w--) { int ix = rem % od[w]; rem /= od[w]; ein += ix * sin_[pw[w]]; }
        size_t k = (size_t)(boff[bin] + ein) * dim + (boff[b] + e); T[k] = iadd(T[k], v); } }
    state_free(&U); }
  IV tr = iv(0, 0); double fro = 0, rmax = 0, rrel = 0; for (int i = 0; i < dim; i++) { tr = iadd(tr, T[(size_t)i * dim + i]); for (int j = 0; j < dim; j++) { IV v = T[(size_t)i * dim + j]; fro += cabs(v.m) * cabs(v.m); if (v.r > rmax) rmax = v.r; if (cabs(v.m) > 0 && v.r / cabs(v.m) > rrel) rrel = v.r / cabs(v.m); } }
  printf("CEI-EXACT-CELL T %d x %d: trace %.15e %+.3ei +- %.3e, Frobenius %.12e, max entry radius %.3e, max relative radius %.3e\n", dim, dim, creal(tr.m), cimag(tr.m), tr.r, sqrt(fro), rmax, rrel);
  if (out) { FILE *f = fopen(out, "wb"); if (f) { fprintf(f, "# T %d x %d (row-major; re im rad), the cut after step 19, the cell's links steps 20..29, WMAX %d beta 11/5 datum ordered -- cei_exact_cell.c, certified entries\n", dim, dim, CAP);
    for (size_t k = 0; k < (size_t)dim * dim; k++) fprintf(f, "%.17e %.17e %.3e\n", creal(T[k].m), cimag(T[k].m), T[k].r); fclose(f); printf("CEI-EXACT-CELL written to %s\n", out); } }
  printf("CEI-EXACT-CELL END\n"); return 0; }
