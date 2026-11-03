/* su2_remainder.c -- THE PHOTON-CARRIED DECIDER, TOOTH 2, THE HOUSE INSTRUMENT IN C (2026-11-02, the author the author, for the
   development: its LEDGER names "a C port" as the instrument the decider's T2 fit needs for the N >= 64 rows the gawk engine
   cannot reach in a night).  THE SAME OBJECT as STDLIB/build/aperanton/photon_carried/su2_remainder.awk (the house reference, ported
   line for line: the same jets over MS = 8 phase samples, the same form table, the same Fourier projection, the same Gaussian
   elimination with the same pivot rule and the same division formula, the same antiperiodic midpoint grid with the same weights)
   and of su2_remainder.py (the FOREIGN ANCHOR).  Nothing is derived here that the awk does not derive; what this file adds is REACH:
   the phase exp(i(kk.vk - kb.vb)) is factored, since bra and ket differ only in component 0 by s p, into exp(i k.(vk - vb)) times a
   constant folded into the coefficient table once per momentum p, so a point costs eight trigonometric calls and ~1,000 complex
   multiply-adds instead of ~2,400 trigonometric calls; and the n0 loop may be split over threads, each thread's partial sum taken
   in the serial order over a contiguous block and the partials added in thread order, so a record at a stated thread count is
   determinate (THREADS=1 reproduces the serial sum to the bit; another count moves the last binary digits only).
     the colour-3 photon theta(x) = eps cos(p x_0) on the links of direction `bg` of SU(2) Wilson; the charged pair w = x1 + i x2
     and its ghosts integrated at Gaussian order around it; Gamma''(0) = d^2/d eps^2 [ln det K_w - 2 ln det M_gh];
     beta_eff(p) = beta + 8 Gamma''/(V p_hat^2); the drift per L = 2 step D(p) = shift(p/2) - shift(p) -> -8 b0 ln 2 = -0.257512.
   KNOWN ANSWERS (the awk header's acceptance test, the anchor's records): pure gauge (bg = 0) Gamma'' = 0; K0 = khat^2 I at xi = 1;
     N = 8, m = 2, bg = 1: Gamma''_gl/V = -2.531357423902959e-01, ghost part -6.329260284330156e-03 (spin 1, xi 1);
     spin 0: -1.739012705359546e-01; xi = 2: -2.846037386789051e-01 -- all four to 1e-12 or the port is wrong.
   usage: su2_remainder [N=32] [M=1,2,4,8] [SPIN=1] [XI=1] [GHOSTS=1] [BG=1] [SYM=1] [THREADS=1]   (the awk's -v names, as KEY=VALUE)
   The header line reads RUN(c); decider.awk's readshifts regex ^RUN(\(awk\))? N= is widened to ^RUN(\((awk|c)\))? N= to read it. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
#include <time.h>
#ifdef _OPENMP
#include <omp.h>
#endif

#define MS 8
#define MAXKEY 512
#define MAXD 128
typedef double complex cplx;

static const double CHG = -1.0;
static double PI;
static double PHI[MS];

/* ------------------------------------------------------------ jets: order 0,1,2 in eps at each phase sample */
typedef struct { cplx v[3][MS]; } jet;
static void jet_one(jet *j) { for (int s = 0; s < MS; s++) { j->v[0][s] = 1; j->v[1][s] = 0; j->v[2][s] = 0; } }
static void jet_exp(jet *j, const double *b) {   /* exp(i CHG eps b) to order 2: (1, i C b, -b^2/2) */
  for (int s = 0; s < MS; s++) { j->v[0][s] = 1; j->v[1][s] = I * (CHG * b[s]); j->v[2][s] = -0.5 * b[s] * b[s]; }
}
static void jet_scale(jet *out, const jet *src, cplx f) { for (int o = 0; o < 3; o++) for (int s = 0; s < MS; s++) out->v[o][s] = f * src->v[o][s]; }
static void jet_conj(jet *out, const jet *src) { for (int o = 0; o < 3; o++) for (int s = 0; s < MS; s++) out->v[o][s] = conj(src->v[o][s]); }
static void jet_mul(jet *out, const jet *a, const jet *b) {   /* (a0 b0, a0 b1 + a1 b0, a0 b2 + a1 b1 + a2 b0) */
  for (int s = 0; s < MS; s++) {
    cplx a0 = a->v[0][s], a1 = a->v[1][s], a2 = a->v[2][s], b0 = b->v[0][s], b1 = b->v[1][s], b2 = b->v[2][s];
    out->v[0][s] = a0 * b0; out->v[1][s] = a0 * b1 + a1 * b0; out->v[2][s] = a0 * b2 + a1 * b1 + a2 * b0;
  }
}
static void jet_set(jet *j, const double *r0, const double *r1, const double *r2, const double *ir1) {
  for (int s = 0; s < MS; s++) { j->v[0][s] = r0[s]; j->v[1][s] = r1[s] + I * ir1[s]; j->v[2][s] = r2[s]; }
}

/* ------------------------------------------------------------ the form table: key = (i, j, vb, vk), a jet per key; then its Fourier modes */
typedef struct { int i, j, vb[4], vk[4]; cplx F[3][MS]; cplx FF[9][3]; } fkey;   /* FF[n+4][o], n = -4..4 */
typedef struct { int n; double alias; fkey k[MAXKEY]; } form;
static fkey *form_key(form *f, int i, int j, const int *vb, const int *vk) {
  for (int a = 0; a < f->n; a++) { fkey *k = &f->k[a];
    if (k->i == i && k->j == j && !memcmp(k->vb, vb, sizeof k->vb) && !memcmp(k->vk, vk, sizeof k->vk)) return k; }
  if (f->n >= MAXKEY) { printf("REFUSED: the form table is full at %d keys\n", MAXKEY); exit(2); }
  fkey *k = &f->k[f->n++]; k->i = i; k->j = j; memcpy(k->vb, vb, sizeof k->vb); memcpy(k->vk, vk, sizeof k->vk); memset(k->F, 0, sizeof k->F);
  return k;
}
static void form_add(form *f, int i, int j, const int *vb, const int *vk, const jet *jt) {
  fkey *k = form_key(f, i, j, vb, vk);
  for (int o = 0; o < 3; o++) for (int s = 0; s < MS; s++) k->F[o][s] += jt->v[o][s];
}
static void form_fourier(form *f) {   /* FF[n][o] = (1/MS) sum_s F(o,s) e^{-i n phi_s}; ALIAS = max |FF| over |n| >= 3 (modes 3, 4 must vanish: degree <= 2) */
  f->alias = 0;
  for (int a = 0; a < f->n; a++) { fkey *k = &f->k[a];
    for (int n = -4; n <= 4; n++) for (int o = 0; o < 3; o++) {
      cplx acc = 0;
      for (int s = 0; s < MS; s++) acc += k->F[o][s] * (cos(n * PHI[s]) - I * sin(n * PHI[s]));
      k->FF[n + 4][o] = acc / MS;
      if (n >= 3 || n <= -3) { double am = cabs(acc) / MS; if (am > f->alias) f->alias = am; }
    }
  }
}
static void unitv(int mu, int *v) { for (int a = 0; a < 4; a++) v[a] = (a == mu); }
static void negunitv(int mu, int *v) { for (int a = 0; a < 4; a++) v[a] = -(a == mu); }

/* ------------------------------------------------------------ the forms */
static void gluon_form(form *f, double p, int bg, double spin, double xi) {
  f->n = 0;
  double BA[MS], BB[MS], BC[MS], BD[MS], BP[MS], ABC[MS], Z0[MS], Z1[MS], Z2[MS], ZI[MS], BGF[MS];
  jet c[4], ca, cb, tmp, tmp2, tmp3, cosj, pre, t2, t3, tg, g[4][2];
  int RI[4], RV[4][4], GI[4][2], GV[4][2][4];
  const int zero4[4] = {0, 0, 0, 0};
  for (int mu = 0; mu < 4; mu++) for (int nu = mu + 1; nu < 4; nu++) {
    for (int s = 0; s < MS; s++) {
      BA[s] = (mu == bg) * cos(PHI[s]); BB[s] = (nu == bg) * cos(PHI[s] + p * (mu == 0));
      BC[s] = (mu == bg) * cos(PHI[s] + p * (nu == 0)); BD[s] = (nu == bg) * cos(PHI[s]);
      BP[s] = BA[s] + BB[s] - BC[s] - BD[s]; ABC[s] = BA[s] + BB[s] - BC[s];
    }
    /* the four transported fluctuations: w_mu(x), e^{iC ba} w_nu(x+mu), -e^{iC(ba+bb-bc)} w_mu(x+nu), -e^{iC bp} w_nu(x) */
    RI[0] = mu; memcpy(RV[0], zero4, sizeof zero4); jet_one(&c[0]);
    RI[1] = nu; unitv(mu, RV[1]);                   jet_exp(&c[1], BA);
    RI[2] = mu; unitv(nu, RV[2]);                   jet_exp(&t2, ABC); jet_scale(&c[2], &t2, -1);
    RI[3] = nu; memcpy(RV[3], zero4, sizeof zero4); jet_exp(&t3, BP);  jet_scale(&c[3], &t3, -1);
    for (int s = 0; s < MS; s++) { Z0[s] = 1; Z1[s] = 0; Z2[s] = -BP[s] * BP[s] / 8; ZI[s] = 0; }
    jet_set(&cosj, Z0, Z1, Z2, ZI);                   /* cos(theta_p/2) = 1 - (eps bp)^2/8 to order 2 */
    for (int a = 0; a < 4; a++) for (int b = 0; b < 4; b++) {
      jet_conj(&ca, &c[a]); jet_mul(&tmp, &ca, &c[b]); jet_mul(&tmp2, &cosj, &tmp);
      form_add(f, RI[a], RI[b], RV[a], RV[b], &tmp2);
    }
    for (int s = 0; s < MS; s++) { Z0[s] = 0; Z1[s] = -2 * spin * BP[s] / 2; Z2[s] = 0; ZI[s] = 0; }
    jet_set(&pre, Z0, Z1, Z2, ZI);                    /* -2 s sin(theta_p/2) = -2 s (eps bp / 2) to order 1 */
    for (int a = 0; a < 4; a++) for (int b = a + 1; b < 4; b++) {
      jet_conj(&ca, &c[a]); jet_mul(&tmp, &ca, &c[b]); jet_mul(&tmp2, &pre, &tmp); jet_scale(&tmp3, &tmp2, -0.5 * I);   /* /(2i) */
      form_add(f, RI[a], RI[b], RV[a], RV[b], &tmp3);
      jet_conj(&cb, &c[b]); jet_mul(&tmp, &cb, &c[a]); jet_mul(&tmp2, &pre, &tmp); jet_scale(&tmp3, &tmp2, 0.5 * I);    /* -(.)/(2i) */
      form_add(f, RI[b], RI[a], RV[b], RV[a], &tmp3);
    }
  }
  /* the gauge fixing (1/xi) |D.w|^2 with (D.w)(x) = sum_mu [w_mu(x) - e^{-iC th_mu(x-mu)} w_mu(x-mu)] */
  for (int mu = 0; mu < 4; mu++) {
    for (int s = 0; s < MS; s++) BGF[s] = -((mu == bg) * cos(PHI[s] - p * (mu == 0)));
    GI[mu][0] = mu; memcpy(GV[mu][0], zero4, sizeof zero4); jet_one(&g[mu][0]);
    GI[mu][1] = mu; negunitv(mu, GV[mu][1]);                 jet_exp(&tg, BGF); jet_scale(&g[mu][1], &tg, -1);
  }
  for (int gi = 0; gi < 4; gi++) for (int gj = 0; gj < 4; gj++) for (int a = 0; a < 2; a++) for (int b = 0; b < 2; b++) {
    jet_conj(&ca, &g[gi][a]); jet_mul(&tmp, &ca, &g[gj][b]); jet_scale(&tmp2, &tmp, 1.0 / xi);
    form_add(f, GI[gi][a], GI[gj][b], GV[gi][a], GV[gj][b], &tmp2);
  }
  form_fourier(f);
}
static void ghost_form(form *f, int bg) {   /* D_mu c(x) = e^{iC th_mu(x)} c(x+mu) - c(x);  M = sum |D_mu c|^2 */
  f->n = 0;
  double BMU[MS]; jet h[2], t1, ca, tmp; int HV[2][4]; const int zero4[4] = {0, 0, 0, 0};
  for (int mu = 0; mu < 4; mu++) {
    for (int s = 0; s < MS; s++) BMU[s] = (mu == bg) * cos(PHI[s]);
    unitv(mu, HV[0]); jet_exp(&h[0], BMU);
    memcpy(HV[1], zero4, sizeof zero4); jet_one(&t1); jet_scale(&h[1], &t1, -1);
    for (int a = 0; a < 2; a++) for (int b = 0; b < 2; b++) { jet_conj(&ca, &h[a]); jet_mul(&tmp, &ca, &h[b]); form_add(f, 0, 0, HV[a], HV[b], &tmp); }
  }
  form_fourier(f);
}

/* ------------------------------------------------------------ the evaluation tables: the phase folded, keys merged by (i, j, vk - vb) */
typedef struct { int i, j, dix; cplx c; } ent;
typedef struct { int n; ent e[MAXKEY]; } table;
static int ND = 0; static int DL[MAXD][4];
static int dindex(const int *d) {
  for (int a = 0; a < ND; a++) if (!memcmp(DL[a], d, 4 * sizeof(int))) return a;
  if (ND >= MAXD) { printf("REFUSED: more than %d distinct offset differences\n", MAXD); exit(2); }
  memcpy(DL[ND], d, 4 * sizeof(int)); return ND++;
}
/* mode n, order o, bra momentum k + sb p e0, ket momentum k + sk p e0:
   exp(i(kk.vk - kb.vb)) = exp(i k.(vk - vb)) exp(i p (sk vk0 - sb vb0)); the second factor is folded here */
static void build_table(table *t, const form *f, int n, int o, int sb, int sk, double p) {
  t->n = 0;
  for (int a = 0; a < f->n; a++) { const fkey *k = &f->k[a];
    cplx c = k->FF[n + 4][o];
    if (creal(c) * creal(c) + cimag(c) * cimag(c) < 1e-30) continue;   /* the awk's skip, per key */
    double ph = p * (sk * k->vk[0] - sb * k->vb[0]);
    c *= (cos(ph) + I * sin(ph));
    int d[4]; for (int b = 0; b < 4; b++) d[b] = k->vk[b] - k->vb[b];
    int ix = dindex(d), found = 0;
    for (int e = 0; e < t->n; e++) if (t->e[e].i == k->i && t->e[e].j == k->j && t->e[e].dix == ix) { t->e[e].c += c; found = 1; break; }
    if (!found) { t->e[t->n].i = k->i; t->e[t->n].j = k->j; t->e[t->n].dix = ix; t->e[t->n].c = c; t->n++; }
  }
}
static inline void eval_table(const table *t, const cplx *E, int dim, cplx *OUT) {
  for (int a = 0; a < dim * dim; a++) OUT[a] = 0;
  for (int a = 0; a < t->n; a++) { const ent *e = &t->e[a]; OUT[e->i * dim + e->j] += e->c * E[e->dix]; }
}

/* ------------------------------------------------------------ complex Gaussian elimination, the awk's csolve split into a factor and its application
   pivot: the first strictly larger |L[i,k]|^2 below the diagonal; division by L[k,k] as x conj(L[k,k]) / |L[k,k]|^2 (the awk's formula) */
typedef struct { cplx L[16]; int piv[4]; int dim; } lu_t;
static inline cplx cdiv_awk(cplx x, cplx d) { double pr = creal(d), pi = cimag(d), den = pr * pr + pi * pi, xr = creal(x), xi = cimag(x);
  return ((xr * pr + xi * pi) / den) + I * ((xi * pr - xr * pi) / den); }
static void lu_factor(lu_t *u, const cplx *A, int dim) {
  u->dim = dim; memcpy(u->L, A, dim * dim * sizeof(cplx)); cplx *L = u->L;
  for (int k = 0; k < dim; k++) {
    int piv = k; double mr = creal(L[k * dim + k]) * creal(L[k * dim + k]) + cimag(L[k * dim + k]) * cimag(L[k * dim + k]);
    for (int i = k + 1; i < dim; i++) { double tr = creal(L[i * dim + k]) * creal(L[i * dim + k]) + cimag(L[i * dim + k]) * cimag(L[i * dim + k]); if (tr > mr) { mr = tr; piv = i; } }
    u->piv[k] = piv;
    if (piv != k) for (int j = 0; j < dim; j++) { cplx t = L[k * dim + j]; L[k * dim + j] = L[piv * dim + j]; L[piv * dim + j] = t; }
    for (int i = k + 1; i < dim; i++) {
      cplx m = cdiv_awk(L[i * dim + k], L[k * dim + k]);
      for (int j = k + 1; j < dim; j++) L[i * dim + j] -= m * L[k * dim + j];
      L[i * dim + k] = m;   /* the multiplier kept where the awk left a residue it never reads */
    }
  }
}
static void lu_solve(const lu_t *u, const cplx *B, cplx *Q) {   /* Q = A^{-1} B, dim x dim, the awk's operation order on the right-hand side */
  int dim = u->dim; const cplx *L = u->L; memcpy(Q, B, dim * dim * sizeof(cplx));
  for (int k = 0; k < dim; k++) {
    int piv = u->piv[k];
    if (piv != k) for (int j = 0; j < dim; j++) { cplx t = Q[k * dim + j]; Q[k * dim + j] = Q[piv * dim + j]; Q[piv * dim + j] = t; }
    for (int i = k + 1; i < dim; i++) { cplx m = L[i * dim + k]; for (int j = 0; j < dim; j++) Q[i * dim + j] -= m * Q[k * dim + j]; }
  }
  for (int k = dim - 1; k >= 0; k--) for (int j = 0; j < dim; j++) {
    cplx b = Q[k * dim + j];
    for (int i = k + 1; i < dim; i++) b -= L[k * dim + i] * Q[i * dim + j];
    Q[k * dim + j] = cdiv_awk(b, L[k * dim + k]);
  }
}

/* ------------------------------------------------------------ the second derivative at one momentum: 2 tr(K0^-1 K2) - sum_s tr(K0^-1 K1r K0s^-1 K1) */
typedef struct { table K0, K2, K0s[2], K1[2], K1r[2]; } evalset;   /* [0] = s = -1, [1] = s = +1 */
static void build_evalset(evalset *E, const form *f, double p) {
  build_table(&E->K0, f, 0, 0, 0, 0, p); build_table(&E->K2, f, 0, 2, 0, 0, p);
  for (int a = 0; a < 2; a++) { int s = a ? 1 : -1;
    build_table(&E->K0s[a], f, 0, 0, s, s, p);     /* bra = ket = k + s p e0, mode 0, order 0 */
    build_table(&E->K1[a], f, s, 1, s, 0, p);      /* bra k + s p, ket k, mode s, order 1 */
    build_table(&E->K1r[a], f, -s, 1, 0, s, p);    /* bra k, ket k + s p, mode -s, order 1 (= K1^H) */
  }
}
static void second_derivative(const evalset *E, const cplx *Ed, int dim, double *T2R, double *T2I, double *herm, cplx *K0out) {
  cplx K0[16], K2[16], KS[16], K1[16], K1r[16], X[16], Y[16]; lu_t lu0, lus;
  eval_table(&E->K0, Ed, dim, K0); eval_table(&E->K2, Ed, dim, K2);
  if (K0out) memcpy(K0out, K0, dim * dim * sizeof(cplx));
  lu_factor(&lu0, K0, dim); lu_solve(&lu0, K2, X);
  cplx t = 0; for (int i = 0; i < dim; i++) t += X[i * dim + i];
  cplx T2 = 2 * t;
  for (int a = 0; a < 2; a++) {
    eval_table(&E->K0s[a], Ed, dim, KS); eval_table(&E->K1[a], Ed, dim, K1); eval_table(&E->K1r[a], Ed, dim, K1r);
    for (int i = 0; i < dim; i++) for (int j = 0; j < dim; j++) { double h = cabs(K1r[i * dim + j] - conj(K1[j * dim + i])); if (h > *herm) *herm = h; }
    lu_solve(&lu0, K1r, X);                            /* X = K0^-1 K1r */
    lu_factor(&lus, KS, dim); lu_solve(&lus, K1, Y);   /* Y = K0s^-1 K1 */
    t = 0; for (int i = 0; i < dim; i++) for (int j = 0; j < dim; j++) t += X[i * dim + j] * Y[j * dim + i];
    T2 -= t;
  }
  *T2R = creal(T2); *T2I = cimag(T2);
}

/* ------------------------------------------------------------ the momentum sum (the antiperiodic midpoint grid; SYM: the orthant k2 <= k3, weights 16 x 1|2) */
static double G_GL, G_GH, HERM, K0D, ALIAS, IMAG;
static void gamma2(int N, double p, int bg, double spin, double xi, int ghosts, int sym, int threads) {
  static form GF, HF; static evalset GE, HE;
  ND = 0;
  gluon_form(&GF, p, bg, spin, xi); build_evalset(&GE, &GF, p); ALIAS = GF.alias;
  if (ghosts) { ghost_form(&HF, bg); build_evalset(&HE, &HF, p); if (HF.alias > ALIAS) ALIAS = HF.alias; }
  int half = sym ? N / 2 : N;
  double *PSG = calloc(threads, sizeof(double)), *PSH = calloc(threads, sizeof(double)), *PW = calloc(threads, sizeof(double));
  double *PH = calloc(threads, sizeof(double)), *PK = calloc(threads, sizeof(double)), *PIM = calloc(threads, sizeof(double));
#ifdef _OPENMP
  omp_set_num_threads(threads);
#endif
#pragma omp parallel
  {
    int tid = 0;
#ifdef _OPENMP
    tid = omp_get_thread_num();
#endif
    double sg = 0, sh = 0, wsum = 0, herm = 0, k0d = 0, imag = 0;
    cplx em[4][5], Ed[MAXD], K0[16];
#pragma omp for schedule(static)
    for (int n0 = 0; n0 < half; n0++) {
      double k[4]; k[0] = sym ? PI * (2 * n0 + 1) / N : 2 * PI * (n0 + 0.5) / N;
      for (int n1 = 0; n1 < half; n1++) { k[1] = sym ? PI * (2 * n1 + 1) / N : 2 * PI * (n1 + 0.5) / N;
      for (int n2 = 0; n2 < half; n2++) { k[2] = sym ? PI * (2 * n2 + 1) / N : 2 * PI * (n2 + 0.5) / N;
      for (int n3 = (sym ? n2 : 0); n3 < half; n3++) { k[3] = sym ? PI * (2 * n3 + 1) / N : 2 * PI * (n3 + 0.5) / N;
        double w = sym ? (n3 > n2 ? 32 : 16) : 1; wsum += w;
        for (int mu = 0; mu < 4; mu++) { cplx e1 = cos(k[mu]) + I * sin(k[mu]), e2 = e1 * e1;
          em[mu][0] = conj(e2); em[mu][1] = conj(e1); em[mu][2] = 1; em[mu][3] = e1; em[mu][4] = e2; }
        for (int d = 0; d < ND; d++) Ed[d] = em[0][DL[d][0] + 2] * em[1][DL[d][1] + 2] * em[2][DL[d][2] + 2] * em[3][DL[d][3] + 2];
        double t2r, t2i;
        second_derivative(&GE, Ed, 4, &t2r, &t2i, &herm, K0); sg += w * t2r; if (t2i < 0) t2i = -t2i; if (t2i > imag) imag = t2i;
        if (xi == 1) { double kh = 0; for (int mu = 0; mu < 4; mu++) kh += 4 * sin(k[mu] / 2) * sin(k[mu] / 2);
          for (int i = 0; i < 4; i++) for (int j = 0; j < 4; j++) { double d = cabs(K0[i * 4 + j] - (i == j ? kh : 0)); if (d > k0d) k0d = d; } }
        if (ghosts) { second_derivative(&HE, Ed, 1, &t2r, &t2i, &herm, NULL); sh += -2 * w * t2r; }
      } } }
    }
    PSG[tid] = sg; PSH[tid] = sh; PW[tid] = wsum; PH[tid] = herm; PK[tid] = k0d; PIM[tid] = imag;
  }
  double sg = 0, sh = 0, wsum = 0; HERM = 0; K0D = 0; IMAG = 0;
  for (int t = 0; t < threads; t++) { sg += PSG[t]; sh += PSH[t]; wsum += PW[t]; if (PH[t] > HERM) HERM = PH[t]; if (PK[t] > K0D) K0D = PK[t]; if (PIM[t] > IMAG) IMAG = PIM[t]; }
  free(PSG); free(PSH); free(PW); free(PH); free(PK); free(PIM);
  double V = (double) N * N * N * N;
  if (wsum - V > 0.5 || V - wsum > 0.5) { printf("REFUSED: grid weights sum to %g, not N^4 = %g\n", wsum, V); exit(2); }
  G_GL = sg / V; G_GH = ghosts ? sh / V : 0;
}

int main(int argc, char **argv) {
  int N = 8, GHOSTS = 1, BG = 1, SYM = 1, THREADS = 1; double SPIN = 1, XI = 1; char M[256] = "1,2", MLIST[256];
  for (int a = 1; a < argc; a++) {
    if (!strncmp(argv[a], "N=", 2)) N = atoi(argv[a] + 2); else if (!strncmp(argv[a], "M=", 2)) { strncpy(M, argv[a] + 2, 255); M[255] = 0; }
    else if (!strncmp(argv[a], "SPIN=", 5)) SPIN = atof(argv[a] + 5); else if (!strncmp(argv[a], "XI=", 3)) XI = atof(argv[a] + 3);
    else if (!strncmp(argv[a], "GHOSTS=", 7)) GHOSTS = atoi(argv[a] + 7); else if (!strncmp(argv[a], "BG=", 3)) BG = atoi(argv[a] + 3);
    else if (!strncmp(argv[a], "SYM=", 4)) SYM = atoi(argv[a] + 4); else if (!strncmp(argv[a], "THREADS=", 8)) THREADS = atoi(argv[a] + 8);
    else { printf("REFUSED: unknown argument %s (N= M= SPIN= XI= GHOSTS= BG= SYM= THREADS=)\n", argv[a]); return 2; }
  }
  if (THREADS < 1) THREADS = 1;
#ifndef _OPENMP
  THREADS = 1;
#endif
  if (N < 2 || (SYM && (N % 2))) { printf("REFUSED: N = %d (even N >= 2 under SYM)\n", N); return 2; }
  PI = atan2(0, -1); for (int s = 0; s < MS; s++) PHI[s] = 2 * PI * s / MS;
  strcpy(MLIST, M);
  int ML[64], nm = 0; { char *q = strtok(MLIST, ","); while (q && nm < 64) { ML[nm++] = atoi(q); q = strtok(NULL, ","); } }
  double SHIFT[1024], SGL[1024], SGH[1024]; int HAVE[1024]; memset(HAVE, 0, sizeof HAVE);
  printf("RUN(c) N=%d m=[%s] spin=%g xi=%g ghosts=%d bg=%d sym=%d threads=%d\n", N, M, SPIN, XI, GHOSTS, BG, SYM, THREADS);
  for (int im = 0; im < nm; im++) {
    int m = ML[im]; double p = 2 * PI * m / N; time_t t0 = time(NULL);
    gamma2(N, p, BG, SPIN, XI, GHOSTS, SYM, THREADS);
    double ph2 = 4 * sin(p / 2) * sin(p / 2), tot = 8 * (G_GL + G_GH) / ph2;
    if (m >= 0 && m < 1024) { SHIFT[m] = tot; SGL[m] = 8 * G_GL / ph2; SGH[m] = 8 * G_GH / ph2; HAVE[m] = 1; }
    printf("  m=%3d p=%.6f  beta_eff - beta = % .9f  (gluon % .9f, ghost % .9f)  herm %.1e K0 %.1e alias %.1e imag %.1e  (%llds)\n",
      m, p, tot, 8 * G_GL / ph2, 8 * G_GH / ph2, HERM, K0D, ALIAS, IMAG, (long long) (time(NULL) - t0));
    printf("  Gamma''_gl/V = %.15e  ghost part = %.15e\n", G_GL, G_GH);
    fflush(stdout);
  }
  printf("  DRIFT PER STEP D(p) = shift(p/2) - shift(p)  [stake -0.257512]:\n");
  for (int im = 0; im < nm; im++) { int m = ML[im];
    if (m % 2 == 0 && m / 2 < 1024 && HAVE[m / 2] && HAVE[m])
      printf("    p = %.6f (m %d -> %d): D = % .9f   (gluon % .9f, ghost % .9f)\n", 2 * PI * m / N, m, m / 2, SHIFT[m / 2] - SHIFT[m], SGL[m / 2] - SGL[m], SGH[m / 2] - SGH[m]); }
  return 0;
}
