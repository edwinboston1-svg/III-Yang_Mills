/* gfib.c -- THE GAUSSIAN FIBRE (the development MF, 2026-11-02).  Massless lattice field on Z^d, Chat(p) = 1/lambda(p),
 * lambda(p) = sum_mu 2(1 - cos p_mu); a block map of side L with kernel q (Phi(X) = sum_z q(z) phi(L X + z)); the fibre (phi given Phi)
 * by the alias (Bloch) decomposition p_n(K) = (K + 2 pi n)/L, n in {-L/2+1..L/2}^d.  Double precision READINGS, two roads.
 *   maps: dec | box1..box4 (average over the k-dim sub-box {0..L-1}^k x {0}^(d-k), spanning directions 0..k-1) | heat:c (q = e^{t Delta}, t = c L^2)
 * usage:
 *   gfib d L map A M1 a0 dir   road A: transverse-summed fibre covariance C0(D) along direction dir (0-based) at offset a = (a0,..,a0),
 *                              the K_perp = 0 sector by M1 points in K_dir; prints C0(D), D = 0..M1/4, the successive log ratios, and the
 *                              kernel K0(D) = sum_{Y_perp} Kern(a, D e_dir + Y_perp) (fibre mean of phi_a on Phi) and its ratios
 *   gfib d L map B dir NG      road B: the smallest kappa > 0 with Den(K_dir = i kappa, K_perp) = 0, below the first transverse-alias pole;
 *                              K_perp = 0 and the minimum over an NG^(d-1) grid of K_perp in [0, pi]
 *   gfib d L map F M a0 b0 dir full real space C_fib(a, L D e_dir + b) on an M^d torus, D = 0..M/2  (all K; small sizes)
 *   gfib d L map K2 M          known answer K2: max over sampled (y) of |sum_z q(z) C_fib(z, y)| on an M^d torus, with the scale
 * build: gcc -O2 -fopenmp -o gfib.exe gfib.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
#ifdef _OPENMP
#include <omp.h>
#endif
typedef double complex cplx;
#define PI 3.14159265358979323846
static double RE0 = 0; static int DIM, L, MAPK = -1, HEAT = 0; static double HC = 0.125, HT = 0;   /* MAPK: 0 = dec, k = box_k; HEAT: heat kernel */
static double lam_r(const double *p) { double s = 0; for (int m = 0; m < DIM; m++) s += 2 * (1 - cos(p[m])); return s; }
static cplx lam_c(const cplx *p) { cplx s = 0; for (int m = 0; m < DIM; m++) s += 2 * (1 - ccos(p[m])); return s; }
/* qhat(p) = sum_z q(z) e^{i p z}, real p */
static cplx qhat(const double *p) {
  if (HEAT) return exp(-HT * lam_r(p));
  cplx w = 1; for (int m = 0; m < MAPK; m++) { cplx s = 0; for (int z = 0; z < L; z++) s += cexp(I * p[m] * z); w *= s / L; }
  return w; }
/* Pq(p) = qhat(p) qhat(-p), continued analytically (complex p) */
static cplx FL(cplx x) { cplx sx = csin(x / 2); if (cabs(sx) < 1e-14) return 1; cplx r = csin(L * x / 2) / (L * sx); return r * r; }
static cplx Pq(const cplx *p) { if (HEAT) return cexp(-2 * HT * lam_c(p)); cplx w = 1; for (int m = 0; m < MAPK; m++) w *= FL(p[m]); return w; }
static long NAL; static int *ALI;   /* the aliases */
static void make_aliases(void) { NAL = 1; for (int m = 0; m < DIM; m++) NAL *= L; ALI = malloc(sizeof(int) * NAL * DIM);
  for (long i = 0; i < NAL; i++) { long r = i; for (int m = 0; m < DIM; m++) { int c = (int)(r % L); r /= L; ALI[i * DIM + m] = c - L / 2 + 1; } } }
static long zero_index(void) { for (long i = 0; i < NAL; i++) { int z = 1; for (int m = 0; m < DIM; m++) if (ALI[i * DIM + m] != 0) z = 0; if (z) return i; } return -1; }
/* T_ab(K) and the kernel symbol U_a/S at real K (a, b offsets in fine units) */
static void symbol(const double *K, const int *a, const int *b, cplx *Tab, cplx *Kern) {
  long i0 = zero_index(); double p0[8]; for (int m = 0; m < DIM; m++) p0[m] = K[m] / L;
  double lam0 = lam_r(p0); cplx w0 = qhat(p0);
  cplx Sp = 0, Ua = 0, Ub = 0, Rab = 0;
  for (long i = 0; i < NAL; i++) { if (i == i0) continue; double p[8]; for (int m = 0; m < DIM; m++) p[m] = (K[m] + 2 * PI * ALI[i * DIM + m]) / L;
    double c = 1 / lam_r(p); cplx w = qhat(p); double pa = 0, pb = 0; for (int m = 0; m < DIM; m++) { pa += p[m] * a[m]; pb += p[m] * b[m]; }
    Sp += creal(w * conj(w)) * c; Ua += cexp(I * pa) * conj(w) * c; Ub += cexp(I * pb) * conj(w) * c; Rab += cexp(I * (pa - pb)) * c; }
  double pa0 = 0, pb0 = 0; for (int m = 0; m < DIM; m++) { pa0 += p0[m] * a[m]; pb0 += p0[m] * b[m]; }
  cplx den = creal(w0 * conj(w0)) + lam0 * Sp;
  *Tab = Rab + (cexp(I * (pa0 - pb0)) * Sp - cexp(I * pa0) * conj(w0) * conj(Ub) - Ua * cexp(-I * pb0) * w0 - lam0 * Ua * conj(Ub)) / den;
  *Kern = (cexp(I * pa0) * conj(w0) + lam0 * Ua) / den; }
/* Den(K) continued: K complex */
static cplx Den(const cplx *K) { long i0 = zero_index(); cplx p0[8]; for (int m = 0; m < DIM; m++) p0[m] = K[m] / L;
  cplx lam0 = lam_c(p0); cplx S = 0;
  for (long i = 0; i < NAL; i++) { if (i == i0) continue; cplx p[8]; for (int m = 0; m < DIM; m++) p[m] = (K[m] + 2 * PI * ALI[i * DIM + m]) / L; S += Pq(p) / lam_c(p); }
  return Pq(p0) + lam0 * S; }
int main(int argc, char **argv) {
  if (argc < 5) { fprintf(stderr, "usage: see header\n"); return 1; }
  DIM = atoi(argv[1]); L = atoi(argv[2]); const char *map = argv[3]; const char *mode = argv[4];
  if (!strcmp(map, "dec")) MAPK = 0; else if (!strncmp(map, "box", 3)) MAPK = atoi(map + 3); else if (!strncmp(map, "heat:", 5)) { HEAT = 1; HC = atof(map + 5); HT = HC * L * L; MAPK = 0; }
  else { fprintf(stderr, "map?\n"); return 1; }
  if (MAPK > DIM) { fprintf(stderr, "box dimension above d\n"); return 1; }
  make_aliases();
  printf("GFIB d=%d L=%d map=%s%s mode=%s aliases=%ld\n", DIM, L, map, HEAT ? "" : "", mode, NAL); fflush(stdout);
  if (!strcmp(mode, "A")) { int M1 = atoi(argv[5]); int a0 = atoi(argv[6]); int dir = atoi(argv[7]);
    int a[8]; for (int m = 0; m < DIM; m++) a[m] = a0;
    int Dmax = M1 / 4; double *C0 = calloc(Dmax + 1, sizeof(double)), *K0 = calloc(Dmax + 1, sizeof(double));
    cplx *Tk = malloc(sizeof(cplx) * M1), *Kk = malloc(sizeof(cplx) * M1);
    #pragma omp parallel for schedule(dynamic)
    for (int j = 0; j < M1; j++) { double K[8] = {0}; K[dir] = -PI + 2 * PI * (j + 0.5) / M1; symbol(K, a, a, &Tk[j], &Kk[j]); }
    for (int D = 0; D <= Dmax; D++) { cplx s = 0, t = 0; for (int j = 0; j < M1; j++) { double Kd = -PI + 2 * PI * (j + 0.5) / M1; s += cexp(-I * Kd * D) * Tk[j]; t += cexp(-I * Kd * D) * Kk[j]; }
      C0[D] = creal(s) / (M1 * pow(L, DIM)); K0[D] = creal(t) / M1; }
    /* the half-shifted grid computes the infinite-M1 Fourier coefficients up to aliasing e^{-kappa (M1 - D)} */
    for (int D = 0; D <= Dmax; D++) printf("A d=%d L=%d %s dir=%d a0=%d D=%d C0=% .15e K0=% .15e rateC=%s rateK=%s\n", DIM, L, map, dir, a0, D, C0[D], K0[D],
      "", ""), fflush(stdout);
    for (int D = 1; D <= Dmax; D++) { double rc = (C0[D] != 0 && C0[D - 1] != 0) ? log(fabs(C0[D - 1] / C0[D])) : 0, rk = (K0[D] != 0 && K0[D - 1] != 0) ? log(fabs(K0[D - 1] / K0[D])) : 0;
      printf("A-RATE d=%d L=%d %s dir=%d D=%d logratio_C=%.6f logratio_K=%.6f sign_C=%d\n", DIM, L, map, dir, D, rc, rk, C0[D] > 0 ? 1 : -1); }
    { /* K3: the sum rule sum_{D in Z} K0(D) = 1 (constant coarse field -> constant fibre mean), negative D included */
      double ssum = 0; for (int D = -Dmax; D <= Dmax; D++) { cplx t = 0; for (int j = 0; j < M1; j++) { double Kd = -PI + 2 * PI * (j + 0.5) / M1; t += cexp(-I * Kd * D) * Kk[j]; } ssum += creal(t) / M1; }
      printf("K3 d=%d L=%d %s dir=%d sum_D K0(D) = %.15f (known answer 1)\n", DIM, L, map, dir, ssum); }
    return 0; }
  if (!strcmp(mode, "B")) { int dir = atoi(argv[5]); int NG = atoi(argv[6]); if (argc > 7 && atoi(argv[7]) == 1) RE0 = PI;
    /* the first transverse-alias pole on the imaginary axis at K_perp = 0: kappa_pole = L arccosh(1 + (1 - cos(2 pi/L))) (n_perp = one unit) */
    double kpole = (DIM > 1) ? L * acosh(1 + (1 - cos(2 * PI / L))) : 1e9;
    double best = 1e9; double kperp_best[8] = {0};
    int nper = DIM - 1; long ngrid = 1; for (int m = 0; m < nper; m++) ngrid *= NG;
    double *res = malloc(sizeof(double) * ngrid);
    #pragma omp parallel for schedule(dynamic)
    for (long g = 0; g < ngrid; g++) { double kp[8]; long r = g; for (int m = 0; m < nper; m++) { int c = (int)(r % NG); r /= NG; kp[m] = (NG > 1) ? PI * c / (NG - 1) : 0; }
      cplx K[8]; int q = 0; for (int m = 0; m < DIM; m++) { if (m == dir) K[m] = 0; else K[m] = kp[q++]; }
      double kmaxs = 12.0, h = 0.01; double prev = 0; int found = 0; double kz = 1e9;
      K[dir] = RE0; prev = creal(Den(K));
      for (double kap = h; kap < kmaxs; kap += h) { K[dir] = RE0 + I * kap; cplx v = Den(K); double cv = creal(v);
        if ((cv > 0) != (prev > 0)) { /* bisect, then test zero vs pole by the size of |Den| near the crossing */
          double lo = kap - h, hi = kap; K[dir] = RE0 + I * lo; double vl = creal(Den(K)); for (int it = 0; it < 55; it++) { double md = 0.5 * (lo + hi); K[dir] = RE0 + I * md; double vm = creal(Den(K)); if ((vm > 0) == (vl > 0)) { lo = md; vl = vm; } else hi = md; }
          K[dir] = RE0 + I * (0.5 * (lo + hi)); double atz = cabs(Den(K)); K[dir] = RE0 + I * (kap - h); double scale = fabs(creal(Den(K))); K[dir] = RE0 + I * kap; scale = fmax(scale, fabs(creal(Den(K))));
          if (atz < 1e-6 * fmax(scale, 1e-300) || atz < 1e-9) { kz = 0.5 * (lo + hi); found = 1; break; }
          /* a pole: continue past it */ }
        prev = cv; }
      res[g] = found ? kz : 1e9; }
    for (long g = 0; g < ngrid; g++) { if (res[g] < best) { best = res[g]; long r = g; for (int m = 0; m < nper; m++) { int c = (int)(r % NG); r /= NG; kperp_best[m] = (NG > 1) ? PI * c / (NG - 1) : 0; } } }
    printf("B line=%s d=%d L=%d %s dir=%d kappa(Kperp=0)=%.9f kappa_min=%.9f at Kperp=(", RE0 > 0 ? "ReK=pi" : "ReK=0", DIM, L, map, dir, res[0], best);
    for (int m = 0; m < nper; m++) printf("%s%.4f", m ? "," : "", kperp_best[m]); printf(") first_transverse_pole=%.6f\n", kpole);
    return 0; }
  if (!strcmp(mode, "F") || !strcmp(mode, "K2")) { int M = atoi(argv[5]);
    long NK = 1; for (int m = 0; m < DIM; m++) NK *= M;
    if (!strcmp(mode, "F")) { int a0 = atoi(argv[6]), b0 = atoi(argv[7]), dir = atoi(argv[8]); int a[8], b[8]; for (int m = 0; m < DIM; m++) { a[m] = a0; b[m] = b0; }
      int Dmax = M / 2; cplx *Tk = malloc(sizeof(cplx) * NK); double (*Kv)[8] = malloc(sizeof(double[8]) * NK);
      #pragma omp parallel for schedule(dynamic)
      for (long g = 0; g < NK; g++) { long r = g; double K[8]; for (int m = 0; m < DIM; m++) { int c = (int)(r % M); r /= M; K[m] = 2 * PI * c / M; if (K[m] >= PI - 1e-12) K[m] -= 2 * PI; Kv[g][m] = K[m]; }
        cplx kern; symbol(K, a, b, &Tk[g], &kern); }
      double Ntot = pow((double)M * L, DIM);
      for (int D = 0; D <= Dmax; D++) { cplx s = 0; for (long g = 0; g < NK; g++) s += cexp(-I * Kv[g][dir] * D) * Tk[g];
        printf("F d=%d L=%d %s M=%d a0=%d b0=%d dir=%d D=%d C=% .15e\n", DIM, L, map, M, a0, b0, dir, D, creal(s) / Ntot); }
      return 0; }
    /* K2: sum_z q(z) C_fib(z, y) at sampled y */
    double worst = 0, scale = 0; int ys[6][8]; int ny = 0;
    for (int t = 0; t < 6; t++) { for (int m = 0; m < DIM; m++) ys[t][m] = (t * 3 + m * 2 + 1) % L; ny++; }
    for (int t = 0; t < ny; t++) for (int D = 0; D <= 2; D++) {
      cplx tot = 0; double sc = 0;
      /* sum over z with weights q(z): for box/dec explicit; for heat skip (no finite support) */
      if (HEAT) break;
      int nz = 1; for (int m = 0; m < MAPK; m++) nz *= L;
      for (int zi = 0; zi < nz; zi++) { int z[8] = {0}; int r = zi; for (int m = 0; m < MAPK; m++) { z[m] = r % L; r /= L; }
        double qz = pow(1.0 / L, MAPK);
        cplx s = 0; for (long g = 0; g < NK; g++) { long rr = g; double K[8]; for (int m = 0; m < DIM; m++) { int c = (int)(rr % M); rr /= M; K[m] = 2 * PI * c / M; if (K[m] >= PI - 1e-12) K[m] -= 2 * PI; }
          cplx Tab, kern; symbol(K, z, ys[t], &Tab, &kern); s += cexp(-I * K[0] * D) * Tab; }
        s /= pow((double)M * L, DIM); tot += qz * s; sc = fmax(sc, cabs(s)); }
      if (cabs(tot) > worst) worst = cabs(tot); if (sc > scale) scale = sc; }
    printf("K2 d=%d L=%d %s M=%d max|sum_z q C_fib|=%.3e scale=%.3e\n", DIM, L, map, M, worst, scale);
    return 0; }
  fprintf(stderr, "mode?\n"); return 1; }
