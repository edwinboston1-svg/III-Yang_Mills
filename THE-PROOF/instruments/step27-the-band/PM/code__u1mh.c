/* u1mh.c -- THE JOINT CHARGE LAW OF TWO ADJACENT n x n WILSON LOOPS UNDER THE COMPACT U(1) WILSON MEASURE, read by Monte Carlo on the periodic
 * L^D lattice with EXACT single-link integration (multihit) of the loop links that share no plaquette with another integrated one -- the
 * U(1) arm of su2mh.c (PM, 2026-11-02), the same geometry, the same integrated set.  Action beta sum_p (1 - cos theta_p); a link's local
 * weight exp(beta k cos(theta + psi)), k e^{i psi} = sum of its staples' e^{i phi}; heat bath by Best-Fisher (von Mises), overrelaxation
 * theta -> -2 psi - theta; E[e^{i q theta} | rest] = (I_|q|(beta k)/I_0(beta k)) e^{-i q psi}.  Channels E[e^{i(m Phi_A + n Phi_B)}],
 * m in 0..2, n in -2..2 (A = P_A S^-1 carries charge m, B = S P_B charge n, the shared links charge n - m).
 * usage: u1mh D L BETA n SEED NTHERM NSEP NMEAS NOR OUTFILE     build: gcc -O2 -fopenmp -o u1mh.exe u1mh.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
#include <stdint.h>
#include <omp.h>
typedef double complex cplx;
#define PI 3.141592653589793
static int D, LS, NN; static long V; static double BETA;
static double *TH; static long *UPT, *DNT; static int *PAR;
static uint64_t *RS;
static double rnd(int t) { uint64_t z = (RS[8 * t] += 0x9E3779B97F4A7C15ULL); z = (z ^ (z >> 30)) * 0xBF58476D1CE4E5B9ULL; z = (z ^ (z >> 27)) * 0x94D049BB133111EBULL; z ^= z >> 31; return ((z >> 11) + 0.5) * (1.0 / 9007199254740992.0); }
static long site_of(const int *c) { long s = 0; for (int i = 0; i < D; i++) s = s * LS + ((c[i] % LS) + LS) % LS; return s; }
static void coords(long s, int *c) { for (int i = D - 1; i >= 0; i--) { c[i] = s % LS; s /= LS; } }
static long shift(long s, int mu, int k) { int c[4]; coords(s, c); c[mu] += k; return site_of(c); }
/* the staple sum of link (s, mu): sum over plaquettes of e^{i(theta_p - theta_l)}, so that theta_p = theta_l + phi */
static cplx stsum(long s, int mu) { cplx S = 0;
  for (int nu = 0; nu < D; nu++) { if (nu == mu) continue; long sm = UPT[s * D + mu], sn = UPT[s * D + nu], sd = DNT[s * D + nu], smd = DNT[sm * D + nu];
    S += cexp(I * (TH[sm * D + nu] - TH[sn * D + mu] - TH[s * D + nu]));
    S += cexp(I * (-TH[smd * D + nu] - TH[sd * D + mu] + TH[sd * D + nu])); }
  return S; }
static double vonmises(int t, double kap) { if (kap < 1e-8) return PI * (2 * rnd(t) - 1);
  double tau = 1 + sqrt(1 + 4 * kap * kap), rho = (tau - sqrt(2 * tau)) / (2 * kap), r = (1 + rho * rho) / (2 * rho);
  for (;;) { double u1 = rnd(t), u2 = rnd(t), u3 = rnd(t); double z = cos(PI * u1), f = (1 + r * z) / (r + z), c = kap * (r - f);
    if (c * (2 - c) - u2 > 0 || log(c / u2) + 1 - c >= 0) { double th = acos(fmax(-1, fmin(1, f))); return (u3 > 0.5) ? th : -th; } } }
static void hb(int t, long s, int mu) { cplx S = stsum(s, mu); double k = cabs(S), psi = carg(S); double x = vonmises(t, BETA * k); TH[s * D + mu] = x - psi; }
static void orx(long s, int mu) { cplx S = stsum(s, mu); if (cabs(S) < 1e-12) return; double psi = carg(S); TH[s * D + mu] = -2 * psi - TH[s * D + mu]; }
static void sweep(int nor) {
  for (int mu = 0; mu < D; mu++) for (int p = 0; p < 2; p++) {
    #pragma omp parallel for schedule(static)
    for (long s = 0; s < V; s++) if (PAR[s] == p) hb(omp_get_thread_num(), s, mu); }
  for (int r = 0; r < nor; r++) for (int mu = 0; mu < D; mu++) for (int p = 0; p < 2; p++) {
    #pragma omp parallel for schedule(static)
    for (long s = 0; s < V; s++) if (PAR[s] == p) orx(s, mu); } }
static double plaq(void) { double t = 0;
  #pragma omp parallel for reduction(+:t) schedule(static)
  for (long s = 0; s < V; s++) for (int mu = 0; mu < D; mu++) for (int nu = mu + 1; nu < D; nu++) { long sm = UPT[s * D + mu], sn = UPT[s * D + nu];
    t += cos(TH[s * D + mu] + TH[sm * D + nu] - TH[sn * D + mu] - TH[s * D + nu]); }
  return t / (V * D * (D - 1) / 2.0); }
static void bratio0(double x, double *c) { double In[6]; for (int m = 0; m <= 5; m++) { double t = 1, s = 0; for (int i = 1; i <= m; i++) t *= (x / 2) / i; for (int k = 0; k < 400; k++) { s += t; t *= (x / 2) * (x / 2) / ((k + 1.0) * (k + m + 1.0)); if (t < 1e-18 * s) break; } In[m] = s; }
  for (int m = 0; m <= 5; m++) c[m] = In[m] / In[0]; }
static double (*CB)[6]; static double *PSI;
static void prep_links(void) {
  #pragma omp parallel for schedule(static)
  for (long s = 0; s < V; s++) for (int mu = 0; mu < D; mu++) { long l = s * D + mu; cplx S = stsum(s, mu); double k = cabs(S); PSI[l] = (k > 1e-12) ? carg(S) : 0; bratio0(BETA * k, CB[l]); } }
/* e^{i q theta_l} or its conditional mean */
static cplx lnk(long l, int q, int mh) { if (q == 0) return 1; if (!mh) return cexp(I * q * TH[l]); int aq = abs(q); return CB[l][aq] * cexp(-I * q * PSI[l]); }
static void placement(long s, int mu, int nu, cplx out[2][3][5]) {
  int n = NN; long lA[64], lB[64], lS[16]; int bA[64], bB[64], iA[64], iB[64], iS[16]; int na = 0, nb = 0;
  for (int i = 0; i < n; i++) { lA[na] = shift(s, mu, i) * D + mu; bA[na] = 0; iA[na] = 1; na++; }
  for (int i = 0; i < n; i++) { long st = shift(shift(s, mu, n), nu, i); lA[na] = st * D + nu; bA[na] = 0; iA[na] = (i >= 1 && i <= n - 2); na++; }
  for (int i = 0; i < n; i++) { long st = shift(shift(s, mu, n - 1 - i), nu, n); lA[na] = st * D + mu; bA[na] = 1; iA[na] = 1; na++; }
  for (int i = 0; i < n; i++) { long st = shift(shift(s, mu, -(i + 1)), nu, n); lB[nb] = st * D + mu; bB[nb] = 1; iB[nb] = 1; nb++; }
  for (int i = 0; i < n; i++) { int j = n - 1 - i; long st = shift(shift(s, mu, -n), nu, j); lB[nb] = st * D + nu; bB[nb] = 1; iB[nb] = (j >= 1 && j <= n - 2); nb++; }
  for (int i = 0; i < n; i++) { long st = shift(s, mu, -n + i); lB[nb] = st * D + mu; bB[nb] = 0; iB[nb] = 1; nb++; }
  for (int i = 0; i < n; i++) { lS[i] = shift(s, nu, i) * D + nu; iS[i] = (i >= 1 && i <= n - 2); }
  for (int mh = 0; mh < 2; mh++) for (int m = 0; m <= 2; m++) for (int q = -2; q <= 2; q++) {
    cplx t = 1;
    for (int k = 0; k < na; k++) t *= lnk(lA[k], bA[k] ? -m : m, mh && iA[k]);
    for (int k = 0; k < nb; k++) t *= lnk(lB[k], bB[k] ? -q : q, mh && iB[k]);
    for (int k = 0; k < n; k++) t *= lnk(lS[k], q - m, mh && iS[k]);
    out[mh][m][q + 2] = t; } }
int main(int argc, char **argv) {
  if (argc < 11) { fprintf(stderr, "usage: u1mh D L BETA n SEED NTHERM NSEP NMEAS NOR OUTFILE\n"); return 1; }
  D = atoi(argv[1]); LS = atoi(argv[2]); BETA = atof(argv[3]); NN = atoi(argv[4]); uint64_t seed = strtoull(argv[5], 0, 10); int nth = atoi(argv[6]), nsep = atoi(argv[7]), nmeas = atoi(argv[8]), nor = atoi(argv[9]);
  if (D < 2 || D > 4 || LS % 2 || NN < 2 || 2 * NN + 1 > LS) { fprintf(stderr, "need D in 2..4, L even, n >= 2, 2n + 1 <= L\n"); return 1; }
  V = 1; for (int i = 0; i < D; i++) V *= LS;
  TH = malloc(sizeof(double) * V * D); UPT = malloc(sizeof(long) * V * D); DNT = malloc(sizeof(long) * V * D); PAR = malloc(sizeof(int) * V); CB = malloc(sizeof(*CB) * V * D); PSI = malloc(sizeof(double) * V * D);
  for (long s = 0; s < V; s++) { int c[4], sum = 0; coords(s, c); for (int i = 0; i < D; i++) sum += c[i]; PAR[s] = sum % 2; for (int mu = 0; mu < D; mu++) { UPT[s * D + mu] = shift(s, mu, 1); DNT[s * D + mu] = shift(s, mu, -1); TH[s * D + mu] = 0; } }
  int nthr = omp_get_max_threads(); RS = calloc(8 * nthr, sizeof(uint64_t)); for (int t = 0; t < nthr; t++) RS[8 * t] = seed * 0x2545F4914F6CDD1DULL + 7919ULL * (t + 1);
  { double c[6]; bratio0(BETA, c); printf("U1MH beta=%g: I_1/I_0 = %.10f (the 2D plaquette), I_2/I_0 = %.10f\n", BETA, c[1], c[2]);
    /* KAT: the von Mises sampler's first two moments at kappa = 3 against I_1/I_0, I_2/I_0 */
    double s1 = 0, s2 = 0; int nk = 2000000; for (int i = 0; i < nk; i++) { double x = vonmises(0, 3.0); s1 += cos(x); s2 += cos(2 * x); } bratio0(3.0, c);
    printf("U1MH-KAT von Mises kappa=3: E cos = %.5f (exact %.5f), E cos 2 = %.5f (exact %.5f), %d draws [%s]\n", s1 / nk, c[1], s2 / nk, c[2], nk, (fabs(s1 / nk - c[1]) < 0.002 && fabs(s2 / nk - c[2]) < 0.002) ? "MET" : "FAILED"); }
  FILE *fo = fopen(argv[10], "w"); if (!fo) { fprintf(stderr, "cannot open %s\n", argv[10]); return 1; }
  fprintf(fo, "# u1mh D=%d L=%d beta=%g n=%d seed=%llu ntherm=%d nsep=%d nmeas=%d nor=%d threads=%d\n", D, LS, BETA, NN, (unsigned long long)seed, nth, nsep, nmeas, nor, nthr);
  fprintf(fo, "# per configuration: k plaq, then Re PLAIN[m][q] for m in 0..2, q in -2..2 (m-major), then Re MH[m][q]; then Im MH[m][q]; averages over V*D*(D-1) placements\n");
  double t0 = omp_get_wtime();
  for (int it = 0; it < nth; it++) { sweep(nor); if (it % 50 == 0) { printf("U1MH therm %d plaq %.6f (%.0f s)\n", it, plaq(), omp_get_wtime() - t0); fflush(stdout); } }
  long npl = V * D * (D - 1);
  for (int mm = 0; mm < nmeas; mm++) {
    for (int it = 0; it < nsep; it++) sweep(nor);
    double pl = plaq(); prep_links();
    double accR[2][3][5] = {{{0}}}, accI[2][3][5] = {{{0}}};
    #pragma omp parallel
    { double lR[2][3][5] = {{{0}}}, lI[2][3][5] = {{{0}}};
      #pragma omp for schedule(dynamic, 64)
      for (long s = 0; s < V; s++) for (int mu = 0; mu < D; mu++) for (int nu = 0; nu < D; nu++) { if (nu == mu) continue; cplx o[2][3][5]; placement(s, mu, nu, o);
        for (int h = 0; h < 2; h++) for (int a = 0; a < 3; a++) for (int q = 0; q < 5; q++) { lR[h][a][q] += creal(o[h][a][q]); lI[h][a][q] += cimag(o[h][a][q]); } }
      #pragma omp critical
      for (int h = 0; h < 2; h++) for (int a = 0; a < 3; a++) for (int q = 0; q < 5; q++) { accR[h][a][q] += lR[h][a][q]; accI[h][a][q] += lI[h][a][q]; } }
    fprintf(fo, "%d %.10f", mm, pl); for (int h = 0; h < 2; h++) for (int a = 0; a < 3; a++) for (int q = 0; q < 5; q++) fprintf(fo, " %.10e", accR[h][a][q] / npl);
    for (int a = 0; a < 3; a++) for (int q = 0; q < 5; q++) fprintf(fo, " %.10e", accI[1][a][q] / npl); fprintf(fo, "\n"); fflush(fo);
    if (mm % 10 == 0) { printf("U1MH meas %d plaq %.6f MH: e^{iPhiA} %.4e e^{2iPhiA} %.4e (2,+1) %.4e (2,-1) %.4e (%.0f s)\n", mm, pl, accR[1][1][2] / npl, accR[1][2][2] / npl, accR[1][2][3] / npl, accR[1][2][1] / npl, omp_get_wtime() - t0); fflush(stdout); } }
  fclose(fo); printf("U1MH-DONE %.1f s\n", omp_get_wtime() - t0); return 0; }
