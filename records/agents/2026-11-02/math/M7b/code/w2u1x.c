/* w2_u1.c -- THE TWO-FACE OBJECT FOR U(1): THE ABELIAN COLUMN OF W2 (THE CROSSING CAMPAIGN, standard 2: the abelian control at every
 * instrument; 2026-11-01, the trunk seat).  The same object as w2_strip_n.c (face A the n x n block in the xy-plane, face B in the yz-plane
 * or, planar, at x in [-n, 0]; the shared coarse edge; every object link in its staples outside the object, the datum on the staples' other
 * links) under the U(1) Wilson action e^{beta cos theta_p} = I_0(beta) sum_n (I_n/I_0) e^{i n theta_p}: every plaquette carries an integer charge,
 * the Haar integral over a link forces the incident charges to balance, and the staples' charges at a link, summed under the balance with the
 * datum's phases, make the LINK WEIGHT W_l(m) = sum_{n_1 + ... + n_k = m} prod I_{n_i}/I_0 e^{i n_i phi_i} -- an exact finite sum, no quadrature.
 * The coarse loops' moments E[e^{i a Phi_A} e^{i c Phi_B}] (the U(1) characters, the joint law's Fourier coefficients) are read by inserting the
 * charges a, c on the loops' links; the sum over the 2n^2 plaquette charges runs column by column (two or four plaquettes open at a cut), the
 * charges truncated at |n| <= NMAX with the dropped weight I_{NMAX+1}/I_0 printed.  The free object's law: E[e^{i a Phi_A}] = (I_a/I_0)^{n^2},
 * W(A, B) = W(A) W(B), Z = 1 (K1 for U(1)).  The content's post-processor is w2_modes.awk's U(1) twin, w2_u1_modes.awk (the grid on the two
 * angles, the ratio to the marginals, the modes of e^{delta} - 1).
 * usage: w2_u1 beta NMAX LMAX DATUM [bent|planar] [n]     DATUM = free | ordered | random:SEED | cancel
 * build: gcc -O2 -o w2_u1.exe w2_u1.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
typedef double complex cplx;
#define PI 3.141592653589793
#define MAXL 128
#define MAXOUT 2000
#define MAXCYC 40
#define MAXSTEP 16
#define MAXN 24
static double BETA; static int NMAX, LMAX, FREE = 0, PLANAR = 0, NN = 2;
static double IR[2 * MAXN + 2];                      /* I_|n|(beta)/I_0(beta), |n| <= NMAX + 1 */
static double bessel(int n, double x) { double s = 0, t = pow(x / 2, n), f = 1; for (int i = 1; i <= n; i++) f *= i; t /= f; for (int k = 0; k < 400; k++) { s += t; t *= (x / 2) * (x / 2) / ((k + 1.0) * (k + n + 1.0)); if (t < 1e-300) break; } return s; }
static double ir(int n) { if (n < 0) n = -n; return (n <= NMAX) ? IR[n] : 0; }
/* ---- the object (w2_strip_n.c's geometry, charges in place of representations) */
static int NL = 0; static int LB[MAXL][4], LD[MAXL];
static int NOUT = 0; static int OB[MAXOUT][4], OD[MAXOUT];
static int lkey(const int *b, int d, int create) { for (int i = 0; i < NL; i++) if (LD[i] == d && !memcmp(LB[i], b, sizeof(int) * 4)) return i; if (!create) return -1; if (NL >= MAXL) { fprintf(stderr, "too many links\n"); exit(1); } memcpy(LB[NL], b, sizeof(int) * 4); LD[NL] = d; return NL++; }
static int okey(const int *b, int d) { for (int i = 0; i < NOUT; i++) if (OD[i] == d && !memcmp(OB[i], b, sizeof(int) * 4)) return i; if (NOUT >= MAXOUT) { fprintf(stderr, "too many outside links\n"); exit(1); } memcpy(OB[NOUT], b, sizeof(int) * 4); OD[NOUT] = d; return NOUT++; }
static int NCYC, NP, LOOPA, LOOPB;
static int NSTEP[MAXCYC], STEPL[MAXCYC][MAXSTEP], STEPS[MAXCYC][MAXSTEP], ISLOOP[MAXCYC];
static int PB[MAXCYC][4], PD1[MAXCYC], PD2[MAXCYC];
static int NSTAP[MAXL]; static int STAP[MAXL][6][3][2];
static int SHARED0 = -1;
static int is_obj_plaq(const int *b, int d1, int d2) { for (int p = 0; p < NP; p++) if (PD1[p] == d1 && PD2[p] == d2 && !memcmp(PB[p], b, sizeof(int) * 4)) return 1; return 0; }
static void add_plaq(int p, int x, int y, int z, int d1, int d2) { int b[4] = { x, y, z, 0 }; memcpy(PB[p], b, sizeof b); PD1[p] = d1; PD2[p] = d2;
  int q[4]; NSTEP[p] = 4; ISLOOP[p] = 0;
  STEPL[p][0] = lkey(b, d1, 1); STEPS[p][0] = 1;
  memcpy(q, b, sizeof q); q[d1 - 1]++; STEPL[p][1] = lkey(q, d2, 1); STEPS[p][1] = 1;
  memcpy(q, b, sizeof q); q[d2 - 1]++; STEPL[p][2] = lkey(q, d1, 1); STEPS[p][2] = -1;
  STEPL[p][3] = lkey(b, d2, 1); STEPS[p][3] = -1; }
static void add_loop_step(int c, int i, int x, int y, int z, int d, int sgn) { int b[4] = { x, y, z, 0 }; int l = lkey(b, d, 0); if (l < 0) { fprintf(stderr, "loop link missing\n"); exit(1); } STEPL[c][i] = l; STEPS[c][i] = sgn; }
static void build(void) { int n = NN; NP = 2 * n * n; NCYC = NP + 2; LOOPA = NP; LOOPB = NP + 1;
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) add_plaq(j + n * i, i, j, 0, 1, 2);
  for (int k = 0; k < n; k++) for (int j = 0; j < n; j++) { if (PLANAR) add_plaq(n * n + j + n * k, -1 - k, j, 0, 1, 2); else add_plaq(n * n + j + n * k, 0, j, k, 2, 3); }
  NSTEP[LOOPA] = 4 * n; ISLOOP[LOOPA] = 1; NSTEP[LOOPB] = 4 * n; ISLOOP[LOOPB] = 1; { int s = 0;
    for (int i = 0; i < n; i++) add_loop_step(LOOPA, s++, i, 0, 0, 1, 1); for (int j = 0; j < n; j++) add_loop_step(LOOPA, s++, n, j, 0, 2, 1);
    for (int i = n - 1; i >= 0; i--) add_loop_step(LOOPA, s++, i, n, 0, 1, -1); for (int j = n - 1; j >= 0; j--) add_loop_step(LOOPA, s++, 0, j, 0, 2, -1); }
  { int s = 0; if (PLANAR) { for (int j = 0; j < n; j++) add_loop_step(LOOPB, s++, 0, j, 0, 2, 1); for (int i = 0; i < n; i++) add_loop_step(LOOPB, s++, -1 - i, n, 0, 1, -1);
      for (int j = n - 1; j >= 0; j--) add_loop_step(LOOPB, s++, -n, j, 0, 2, -1); for (int i = 0; i < n; i++) add_loop_step(LOOPB, s++, -n + i, 0, 0, 1, 1); }
    else { for (int j = 0; j < n; j++) add_loop_step(LOOPB, s++, 0, j, 0, 2, 1); for (int k = 0; k < n; k++) add_loop_step(LOOPB, s++, 0, n, k, 3, 1);
      for (int j = n - 1; j >= 0; j--) add_loop_step(LOOPB, s++, 0, j, n, 2, -1); for (int k = n - 1; k >= 0; k--) add_loop_step(LOOPB, s++, 0, 0, k, 3, -1); } }
  { int b0[4] = { 0, 0, 0, 0 }; SHARED0 = lkey(b0, 2, 0); }
  for (int l = 0; l < NL; l++) { int *p = LB[l], d = LD[l]; int pd[4]; memcpy(pd, p, sizeof pd); pd[d - 1]++; NSTAP[l] = 0;
    for (int k = 1; k <= 4; k++) { if (k == d) continue;
      for (int si = 0; si < 2; si++) { int s = si ? -1 : 1; int base[4]; memcpy(base, p, sizeof base); if (s < 0) base[k - 1]--;
        int d1 = d < k ? d : k, d2 = d < k ? k : d; if (is_obj_plaq(base, d1, d2)) continue;
        int ns = NSTAP[l]; int q[4];
        if (s > 0) { STAP[l][ns][0][0] = okey(pd, k); STAP[l][ns][0][1] = 1; } else { memcpy(q, pd, sizeof q); q[k - 1] -= 1; STAP[l][ns][0][0] = okey(q, k); STAP[l][ns][0][1] = -1; }
        memcpy(q, p, sizeof q); q[k - 1] += s; STAP[l][ns][1][0] = okey(q, d); STAP[l][ns][1][1] = -1;
        if (s > 0) { STAP[l][ns][2][0] = okey(p, k); STAP[l][ns][2][1] = -1; } else { memcpy(q, p, sizeof q); q[k - 1] -= 1; STAP[l][ns][2][0] = okey(q, k); STAP[l][ns][2][1] = 1; }
        NSTAP[l]++; } } } }
/* ---- slots: (cycle, sign) per link */
static int NSLOT[MAXL], SLC[MAXL][4], SLSG[MAXL][4];
static void slots(void) { for (int l = 0; l < NL; l++) NSLOT[l] = 0; for (int c = 0; c < NCYC; c++) for (int i = 0; i < NSTEP[c]; i++) { int l = STEPL[c][i]; SLC[l][NSLOT[l]] = c; SLSG[l][NSLOT[l]] = STEPS[c][i]; NSLOT[l]++; } }
/* ---- the link weights W_l(m) for |m| <= MM: the staples' charges convolved under the balance, with the datum's phases */
#define MM 64
static cplx LW[MAXL][2 * MM + 1];
static void link_weights(const double *phase) { for (int l = 0; l < NL; l++) { cplx cur[2 * MM + 1], nxt[2 * MM + 1]; for (int m = -MM; m <= MM; m++) cur[m + MM] = (m == 0) ? 1 : 0;
    if (!FREE) for (int k = 0; k < NSTAP[l]; k++) { double ph = 0; for (int j = 0; j < 3; j++) ph += STAP[l][k][j][1] * phase[STAP[l][k][j][0]];
      for (int m = -MM; m <= MM; m++) nxt[m + MM] = 0;
      for (int m = -MM; m <= MM; m++) { if (cur[m + MM] == 0) continue; for (int q = -NMAX; q <= NMAX; q++) { int t = m + q; if (t < -MM || t > MM) continue; nxt[t + MM] += cur[m + MM] * ir(q) * cexp(I * q * ph); } }
      memcpy(cur, nxt, sizeof cur); }
    memcpy(LW[l], cur, sizeof cur); } }
/* ---- the sum over the plaquette charges, plaquette by plaquette in build order with the open plaquettes' charges as the state */
static int ORDER[MAXCYC];
/* THE FRONTIER DYNAMIC PROGRAMME (05:5x: the first sweep was a depth-first product over every plaquette's charge, (2 NMAX + 1)^{2n^2} leaves --
   17^8 at n = 2, never finishing; this one carries a dense amplitude over the charges of the OPEN plaquettes only, a plaquette being open from
   the step that fixes its charge to the step that closes its last link, four or five open at a time under the build order): at step t the
   plaquette ORDER[t] joins the frontier with its charge as a new index, the links closing at t (every plaquette slot of theirs now fixed)
   multiply in their weight at the balance m, and every frontier plaquette whose links are all closed is summed out of the frontier */
static cplx sweep(int a, int c) {
  int R = 2 * NMAX + 1; int chg[MAXCYC]; for (int p = 0; p < NCYC; p++) chg[p] = 0; chg[LOOPA] = a; chg[LOOPB] = c;
  static int closed_at[MAXL]; for (int l = 0; l < NL; l++) { int last = -1; for (int j = 0; j < NSLOT[l]; j++) { int cyc = SLC[l][j]; if (ISLOOP[cyc]) continue; for (int t = 0; t < NP; t++) if (ORDER[t] == cyc && t > last) last = t; } closed_at[l] = last; }
  static int done_at[MAXCYC]; for (int p = 0; p < NP; p++) { int last = -1; for (int i = 0; i < 4; i++) { int l = STEPL[p][i]; if (closed_at[l] > last) last = closed_at[l]; } done_at[p] = last; }
  cplx pre = 1; for (int l = 0; l < NL; l++) if (closed_at[l] < 0) { int m = 0; for (int j = 0; j < NSLOT[l]; j++) m -= SLSG[l][j] * chg[SLC[l][j]]; pre *= (m >= -MM && m <= MM) ? LW[l][m + MM] : 0; }
  int fr[MAXCYC], nf = 0; size_t size = 1; cplx *st = malloc(sizeof(cplx)); st[0] = pre;
  for (int t = 0; t < NP; t++) { int p = ORDER[t];
    /* join: the new state over (old frontier, p) */
    size_t nsize = size * R; cplx *ns = calloc(nsize, sizeof(cplx)); if (!ns) { fprintf(stderr, "out of memory at a frontier of %zu\n", nsize); exit(3); }
    int nl = 0; static int cl[MAXL]; for (int l = 0; l < NL; l++) if (closed_at[l] == t) cl[nl++] = l;
    for (size_t e = 0; e < size; e++) { if (st[e] == 0) continue; size_t rem = e; for (int i = nf - 1; i >= 0; i--) { chg[fr[i]] = (int)(rem % R) - NMAX; rem /= R; }
      for (int q = -NMAX; q <= NMAX; q++) { chg[p] = q; cplx w = st[e] * ir(q);
        for (int i = 0; i < nl && w != 0; i++) { int l = cl[i]; int m = 0; for (int j = 0; j < NSLOT[l]; j++) m -= SLSG[l][j] * chg[SLC[l][j]]; w *= (m >= -MM && m <= MM) ? LW[l][m + MM] : 0; }
        if (w != 0) ns[e * R + (q + NMAX)] += w; } }
    free(st); st = ns; size = nsize; fr[nf++] = p;
    /* leave: every frontier plaquette whose last link closed at this step is summed out, one at a time */
    for (int i = 0; i < nf; ) { if (done_at[fr[i]] > t) { i++; continue; }
      size_t inner = 1; for (int k = i + 1; k < nf; k++) inner *= R; size_t outer = size / (inner * R);
      cplx *rs = calloc(outer * inner, sizeof(cplx));
      for (size_t o = 0; o < outer; o++) for (int q = 0; q < R; q++) for (size_t in = 0; in < inner; in++) rs[o * inner + in] += st[(o * R + q) * inner + in];
      free(st); st = rs; size = outer * inner; for (int k = i; k + 1 < nf; k++) fr[k] = fr[k + 1]; nf--; } }
  if (nf != 0 || size != 1) { fprintf(stderr, "the frontier did not close\n"); exit(1); }
  cplx total = st[0]; free(st); return total; }
int main(int argc, char **argv) {
  if (argc < 5) { fprintf(stderr, "usage: w2_u1 beta NMAX LMAX DATUM [bent|planar] [n]   DATUM = free | ordered | random:SEED | cancel\n"); return 1; }
  BETA = atof(argv[1]); NMAX = atoi(argv[2]); LMAX = atoi(argv[3]); const char *datum = argv[4]; PLANAR = (argc > 5 && !strcmp(argv[5], "planar")); if (argc > 6) NN = atoi(argv[6]);
  if (NMAX < 1 || NMAX > MAXN - 1 || LMAX < 0 || LMAX > NMAX || NN < 1 || NN > 4) { fprintf(stderr, "caps out of range\n"); return 1; }
  FREE = !strcmp(datum, "free");
  double I0 = bessel(0, BETA); for (int n = 0; n <= NMAX + 1; n++) IR[n] = bessel(n, BETA) / I0;
  /* M7b (2026-11-02): THE SUPPLIED-COEFFICIENT DOOR.  U1_COEF="a1,a2,..." replaces I_n/I_0 by the supplied Fourier coefficients (a_0 = 1,
     a_{-n} = a_n); entries past the list are 0, so NMAX at or above the list length makes the finite series exact on every plaquette.
     U1_VILLAIN=1 uses the Villain weight's coefficients a_n = e^{-n^2/(2 beta)}.  The bent object is refused (THE CROSSING CAMPAIGN §18). */
  if (!PLANAR && !getenv("U1_ALLOW_BENT")) { fprintf(stderr, "M7b REFUSED: the bent object is the section-18 defect; run planar\n"); return 1; }
  if (getenv("U1_VILLAIN")) { for (int n = 0; n <= NMAX + 1; n++) IR[n] = exp(-(double)n * n / (2 * BETA)); printf("U1-VILLAIN a_n = exp(-n^2/(2 beta)), beta=%g\n", BETA); }
  if (getenv("U1_COEF")) { char buf[2048]; strncpy(buf, getenv("U1_COEF"), sizeof buf - 1); buf[sizeof buf - 1] = 0; for (int n = 1; n <= NMAX + 1; n++) IR[n] = 0;
    int k = 0; for (char *t = strtok(buf, ","); t; t = strtok(NULL, ",")) { k++; if (k <= NMAX + 1) IR[k] = atof(t); }
    printf("U1-COEFM supplied:"); for (int n = 1; n <= k && n <= NMAX + 1; n++) printf(" a_%d=%.12e", n, IR[n]); printf(" (NMAX=%d)\n", NMAX); }
  build(); slots();
  /* the plaquette order (06:1x: the index order swept face A from the shared edge outward and kept its near column open through the whole
     face -- eight plaquettes in the frontier at n = 4, 13^8 amplitudes, the allocation refused): face A from the far column to the shared edge,
     then face B from the shared edge outward; the frontier holds one column and the plaquette being added, five at most */
  { int t = 0; for (int i = NN - 1; i >= 0; i--) for (int j = 0; j < NN; j++) ORDER[t++] = j + NN * i; for (int k = 0; k < NN; k++) for (int j = 0; j < NN; j++) ORDER[t++] = NN * NN + j + NN * k; }
  int n5 = 0, n4 = 0; for (int l = 0; l < NL; l++) { if (NSTAP[l] == 5) n5++; else if (NSTAP[l] == 4) n4++; else { fprintf(stderr, "a link with neither four nor five staples\n"); return 1; } }
  printf("U1-OBJECT %s n=%d plaquettes=%d links=%d (shared=%d) outside=%d staples five=%d four=%d; beta=%g NMAX=%d (dropped weight I_%d/I_0 = %.2e) LMAX=%d datum=%s\n", PLANAR ? "planar" : "bent", NN, NP, NL, SHARED0, NOUT, n5, n4, BETA, NMAX, NMAX + 1, IR[NMAX + 1], LMAX, datum);
  double *phase = calloc(NOUT + 1, sizeof(double));
  if (!strcmp(datum, "cancel")) { double want[4] = { 0, PI, PI / 2, -PI / 2 }; if (NSTAP[SHARED0] != 4) { fprintf(stderr, "the shared link has %d staples, not 4\n", NSTAP[SHARED0]); return 1; } for (int k = 0; k < 4; k++) phase[STAP[SHARED0][k][1][0]] = -want[k]; }
  else if (!strncmp(datum, "random:", 7)) { unsigned long long seed = (unsigned long long)atoll(datum + 7);
    for (int i = 0; i < NOUT; i++) { unsigned long long h = seed * 0x9E3779B97F4A7C15ULL + 0x1234567ULL; for (int j = 0; j < 4; j++) h = (h ^ (unsigned long long)(OB[i][j] + 1000003)) * 0xBF58476D1CE4E5B9ULL; h = (h ^ (unsigned long long)(OD[i] * 7919)) * 0x94D049BB133111EBULL; h ^= h >> 31; h *= 0xD6E8FEB86659FD93ULL; h ^= h >> 32; phase[i] = 2 * PI * ((h >> 11) / 9007199254740992.0); } }
  else if (strcmp(datum, "ordered") && strcmp(datum, "free")) { fprintf(stderr, "unknown datum %s\n", datum); return 1; }
  /* THE INFLUENCE LADDER for U(1) (the campaign's §9): U1_ROT="<outside link index>:<angle>" adds the angle to that one link's phase;
     U1_LIST=1 prints every outside link's coordinates and direction once */
  if (getenv("U1_LIST")) for (int i = 0; i < NOUT; i++) printf("U1-OUT %d %d %d %d %d %d\n", i, OB[i][0], OB[i][1], OB[i][2], OB[i][3], OD[i]);
  if (getenv("U1_ROT")) { int rl = -1; double ra = 0; if (sscanf(getenv("U1_ROT"), "%d:%lf", &rl, &ra) != 2 || rl < 0 || rl >= NOUT) { fprintf(stderr, "U1_ROT must be <index 0..%d>:<angle>\n", NOUT - 1); return 1; }
    phase[rl] += ra; printf("U1-ROT link %d (%d,%d,%d,%d dir %d) by %.6f\n", rl, OB[rl][0], OB[rl][1], OB[rl][2], OB[rl][3], OD[rl], ra); }
  link_weights(phase);
  static cplx CLS[33][17]; cplx Z = sweep(0, 0); if (cabs(Z) == 0) { fprintf(stderr, "Z = 0\n"); return 1; }
  printf("U1-Z beta=%g datum=%s n=%d Z = %.12e (imag %.1e)\n", BETA, datum, NN, creal(Z), cimag(Z));
  /* the charges a in [-LMAX, LMAX] on loop A and c in [0, LMAX] on loop B: the other half of the table is the conjugate, M(-a, -c) = conj M(a, c) */
  int CMX = getenv("U1_CMAX0") ? 0 : LMAX; for (int a = (getenv("U1_CMAX0") ? 0 : -LMAX); a <= LMAX; a++) for (int c = 0; c <= CMX; c++) { cplx m = sweep(a, c) / Z; CLS[a + 16][c] = m;
    printf("U1-CLASS a=%d c=%d E[e^{ia Phi_A} e^{ic Phi_B}] = %+.12e %+.12e i\n", a, c, creal(m), cimag(m)); }
  int badfree = 0; for (int a = (getenv("U1_CMAX0") ? 0 : -LMAX); a <= LMAX; a++) for (int c = 0; c <= (getenv("U1_CMAX0") ? 0 : LMAX); c++) { cplx conn = CLS[a + 16][c] - CLS[a + 16][0] * CLS[16][c];
    printf("U1-CONN a=%d c=%d <e^{ia Phi_A} e^{ic Phi_B}>_c = %+.12e %+.12e i (marginals %+.9e %+.9e i, %+.9e %+.9e i)\n", a, c, creal(conn), cimag(conn), creal(CLS[a + 16][0]), cimag(CLS[a + 16][0]), creal(CLS[16][c]), cimag(CLS[16][c]));
    if (FREE) { double want = pow(IR[abs(a)], NN * NN); if (cabs(CLS[a + 16][0] - want) > 1e-9 * (1 + fabs(want)) || cabs(conn) > 1e-9) badfree++; } }
  if (FREE) printf("U1-KAT FREE n=%d: Z = 1 [%s]; E[e^{ia Phi_A}] = (I_a/I_0)^(n^2) and every connected pair zero [%s]\n", NN, fabs(creal(Z) - 1) < 1e-9 ? "MET" : "FAILED", badfree ? "FAILED" : "MET");
  printf("U1-DONE\n"); return 0; }
