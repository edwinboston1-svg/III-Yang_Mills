/* w2_u1_dob.c -- THE (8.5) READER FOR THE ABELIAN CONTROL: THE GROUND's interdependence coefficient between the two coarse loops of the U(1)
 * two-face object at a fine datum, from the engine's joint moments (w2_u1.c's U1-CLASS lines; THE CROSSING CAMPAIGN §14, 2026-11-01, the trunk seat).
 * The record holds E[e^{i a Phi_A} e^{i c Phi_B}] for a in [-L, L], c in [0, L] (the other half the conjugate); the joint law of the two phases truncated
 * at charge L is p(phi, psi) = sum_{|a|,|c| <= L} c_{ac} e^{-i(a phi + c psi)} against d phi d psi / (2 pi)^2, and (8.5) for y = A, y' = B at the datum is
 * C = sup_{psi, psi'} || p(.|psi) - p(.|psi') ||_TV, TV = half the L1 norm, beside Delta = sup osc_phi [log p(phi|psi) - log p(phi|psi')] and the tilt bound
 * 1 - e^{-Delta}.  The suprema are grid suprema with a local refinement, hence LOWER bounds; the truncated density's sign is censused first and a TV or
 * a Delta is REFUSED BY NAME where the joint density or the conditioning marginal is not positive.  Controls: K2' the Fourier round trip on the grid,
 * K5 two phi-grids agreeing on C; K1 is the free datum's record (C = 0).
 * usage: w2_u1_dob <record> [N=1024] [N2=4096] [M=720]      build: gcc -O2 -fopenmp -o w2_u1_dob.exe w2_u1_dob.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
typedef double complex cplx;
#define PI 3.141592653589793
#define MAXL 16
static int L = -1; static cplx CF[2 * MAXL + 1][2 * MAXL + 1]; static int HAS[2 * MAXL + 1][2 * MAXL + 1]; static char DATUM[64] = "?"; static double BETA = 0; static int NMAXR = 0, NN = 0;
static inline cplx *cf(int a, int c) { return &CF[a + MAXL][c + MAXL]; }
static void read_record(const char *path) { FILE *f = fopen(path, "r"); if (!f) { fprintf(stderr, "cannot open %s\n", path); exit(1); } char line[4096];
  while (fgets(line, sizeof line, f)) {
    if (!strncmp(line, "U1-OBJECT", 9)) { char *p; if ((p = strstr(line, "LMAX="))) L = atoi(p + 5); if ((p = strstr(line, "beta="))) BETA = atof(p + 5); if ((p = strstr(line, "NMAX="))) NMAXR = atoi(p + 5); if ((p = strstr(line, " n="))) NN = atoi(p + 3); if ((p = strstr(line, "datum="))) { sscanf(p + 6, "%63s", DATUM); } }
    else if (!strncmp(line, "U1-CLASS ", 9)) { int a, c; double re, im; if (sscanf(line, "U1-CLASS a=%d c=%d E[e^{ia Phi_A} e^{ic Phi_B}] = %le %le i", &a, &c, &re, &im) != 4) { fprintf(stderr, "bad class line\n"); exit(1); }
      if (abs(a) > MAXL || abs(c) > MAXL) { fprintf(stderr, "charge out of range\n"); exit(1); } *cf(a, c) = re + I * im; HAS[a + MAXL][c + MAXL] = 1; *cf(-a, -c) = re - I * im; HAS[-a + MAXL][-c + MAXL] = 1; } }
  fclose(f); if (L < 0) { fprintf(stderr, "no U1-OBJECT line\n"); exit(1); }
  for (int a = -L; a <= L; a++) for (int c = -L; c <= L; c++) if (!HAS[a + MAXL][c + MAXL]) { fprintf(stderr, "U1DOB-REFUSED: the moment (%d,%d) is missing from the record\n", a, c); exit(2); } }
static double pjoint(double phi, double psi) { cplx s = 0; for (int a = -L; a <= L; a++) for (int c = -L; c <= L; c++) s += *cf(a, c) * cexp(-I * (a * phi + c * psi)); return creal(s); }
static double pB(double psi) { cplx s = 0; for (int c = -L; c <= L; c++) s += *cf(0, c) * cexp(-I * (c * psi)); return creal(s); }
static double pA(double phi) { cplx s = 0; for (int a = -L; a <= L; a++) s += *cf(a, 0) * cexp(-I * (a * phi)); return creal(s); }
/* the conditional row at psi on the phi grid of N points, by a Fourier synthesis in phi: g_a(psi) = sum_c c_{ac} e^{-ic psi}, p(phi, psi) = sum_a g_a e^{-ia phi} */
static void cond_row(double psi, int N, double *row, double *qb) { cplx g[2 * MAXL + 1]; for (int a = -L; a <= L; a++) { cplx s = 0; for (int c = -L; c <= L; c++) s += *cf(a, c) * cexp(-I * (c * psi)); g[a + MAXL] = s; }
  double q = creal(g[MAXL]); *qb = q; for (int j = 0; j < N; j++) { double phi = 2 * PI * j / N; cplx s = 0; for (int a = -L; a <= L; a++) s += g[a + MAXL] * cexp(-I * (a * phi)); row[j] = creal(s) / (q > 0 ? q : 1); } }
static double tv_of(double psi, double psip, int N, double *ra, double *rb) { double qa, qb; cond_row(psi, N, ra, &qa); cond_row(psip, N, rb, &qb); if (qa <= 0 || qb <= 0) return -1; double t = 0; for (int j = 0; j < N; j++) t += fabs(ra[j] - rb[j]); return 0.5 * t / N; }
static double delta_of(double psi, double psip, int N, double *ra, double *rb) { double qa, qb; cond_row(psi, N, ra, &qa); cond_row(psip, N, rb, &qb); if (qa <= 0 || qb <= 0) return -1; double lmax = -1e300, lmin = 1e300; for (int j = 0; j < N; j++) { if (ra[j] <= 0 || rb[j] <= 0) return -1; double Lg = log(ra[j]) - log(rb[j]); if (Lg > lmax) lmax = Lg; if (Lg < lmin) lmin = Lg; } return lmax - lmin; }
typedef double (*pairfn)(double, double, int, double *, double *);
static double climb(pairfn f, double *psi, double *psip, int N, double *ra, double *rb, int *steps) { double cur = f(*psi, *psip, N, ra, rb); double eps = 0.05; *steps = 0;
  for (int it = 0; it < 400 && eps > 1e-9; it++) { int moved = 0; double cand[4][2] = { { *psi + eps, *psip }, { *psi - eps, *psip }, { *psi, *psip + eps }, { *psi, *psip - eps } };
    for (int k = 0; k < 4 && !moved; k++) { double t = f(cand[k][0], cand[k][1], N, ra, rb); if (t > cur + 1e-14) { cur = t; *psi = cand[k][0]; *psip = cand[k][1]; moved = 1; (*steps)++; } }
    if (!moved) eps *= 0.5; } return cur; }
int main(int argc, char **argv) {
  if (argc < 2) { fprintf(stderr, "usage: w2_u1_dob <record> [N=1024] [N2=4096] [M=720]\n"); return 1; }
  int N = argc > 2 ? atoi(argv[2]) : 1024, N2 = argc > 3 ? atoi(argv[3]) : 4096, M = argc > 4 ? atoi(argv[4]) : 720;
  read_record(argv[1]);
  printf("U1DOB-RECORD %s: beta=%g n=%d NMAX=%d LMAX=%d (charges to %d) datum=%s; c_00 = %.15f\n", argv[1], BETA, NN, NMAXR, L, L, DATUM, creal(*cf(0, 0)));
  /* K2': the Fourier round trip on the M x M grid (the trapezoid rule is exact for trigonometric polynomials of degree < M) */
  { double worst = 0; int G = 2 * L + 8; for (int a = -L; a <= L; a++) for (int c = -L; c <= L; c++) { cplx acc = 0; for (int j = 0; j < G; j++) for (int k = 0; k < G; k++) { double phi = 2 * PI * j / G, psi = 2 * PI * k / G; acc += pjoint(phi, psi) * cexp(I * (a * phi + c * psi)); } acc /= (double)G * G; double e = cabs(acc - *cf(a, c)); if (e > worst) worst = e; }
    printf("U1DOB-KAT K2' Fourier round trip c -> p -> c on a %d x %d grid: worst absolute difference %.1e [%s]\n", G, G, worst, worst < 1e-12 ? "MET" : "FAILED"); }
  /* the positivity census on the M x M grid */
  double minp = 1e300, maxp = -1e300, minpb = 1e300, minpa = 1e300; long long nneg = 0;
  for (int k = 0; k < M; k++) { double psi = 2 * PI * k / M; double q = pB(psi); if (q < minpb) minpb = q; double qa = pA(psi); if (qa < minpa) minpa = qa; for (int j = 0; j < M; j++) { double p = pjoint(2 * PI * j / M, psi); if (p < minp) minp = p; if (p > maxp) maxp = p; if (p < 0) nneg++; } }
  int signed_joint = (minp < -1e-12 * (maxp > 0 ? maxp : 1)), signed_margB = (minpb <= 0);
  printf("U1DOB-CENSUS joint density on %d x %d points: min %.6e max %.6e, negative at %lld (%.3f %%); marginal p_B min %.6e, p_A min %.6e -> joint %s, p_B %s\n", M, M, minp, maxp, nneg, 100.0 * nneg / ((double)M * M), minpb, minpa, signed_joint ? "SIGNED" : "POSITIVE", signed_margB ? "NOT POSITIVE" : "POSITIVE");
  /* the grid sup over (psi, psi') */
  double *ra = malloc(sizeof(double) * N2), *rb = malloc(sizeof(double) * N2); double bestTV = -1, bpsi = 0, bpsip = 0, bestD = -1, dpsi = 0, dpsip = 0; long long nref = 0, npairs = 0;
  double *rows = malloc(sizeof(double) * (size_t)M * N), *qB = malloc(sizeof(double) * M); for (int k = 0; k < M; k++) cond_row(2 * PI * k / M, N, rows + (size_t)k * N, &qB[k]);
  for (int k = 0; k < M; k++) { if (qB[k] <= 0) continue; for (int kp = k + 1; kp < M; kp++) { if (qB[kp] <= 0) continue; npairs++; const double *x = rows + (size_t)k * N, *y = rows + (size_t)kp * N; double t = 0, lmax = -1e300, lmin = 1e300; int ok = 1;
      for (int j = 0; j < N; j++) { t += fabs(x[j] - y[j]); if (x[j] > 0 && y[j] > 0) { double Lg = log(x[j]) - log(y[j]); if (Lg > lmax) lmax = Lg; if (Lg < lmin) lmin = Lg; } else ok = 0; }
      t = 0.5 * t / N; if (t > bestTV) { bestTV = t; bpsi = 2 * PI * k / M; bpsip = 2 * PI * kp / M; } if (ok) { if (lmax - lmin > bestD) { bestD = lmax - lmin; dpsi = 2 * PI * k / M; dpsip = 2 * PI * kp / M; } } else nref++; } }
  printf("U1DOB-GRID psi grid %d points, %lld pairs read, %lld refused for Delta: grid sup TV %.9f at psi=%.4f psi'=%.4f; grid sup Delta %s\n", M, npairs, nref, bestTV, bpsi, bpsip, bestD >= 0 ? "" : "REFUSED everywhere"); if (bestD >= 0) printf("U1DOB-GRID-DELTA %.9f at psi=%.4f psi'=%.4f\n", bestD, dpsi, dpsip);
  int st; double p1 = bpsi, p2 = bpsip; double C1 = climb(tv_of, &p1, &p2, N, ra, rb, &st); printf("U1DOB-C phi grid %d: C = %.9f after %d accepted moves (grid %.9f, movement %+.2e) at psi=%.4f psi'=%.4f (psi' - psi = %.4f)\n", N, C1, st, bestTV, C1 - bestTV, p1, p2, fmod(p2 - p1 + 4 * PI, 2 * PI));
  double q1 = bpsi, q2 = bpsip; double C2 = climb(tv_of, &q1, &q2, N2, ra, rb, &st); printf("U1DOB-C phi grid %d: C = %.9f after %d accepted moves (grid %.9f, movement %+.2e) at psi=%.4f psi'=%.4f\n", N2, C2, st, bestTV, C2 - bestTV, q1, q2);
  double Dref = -1; if (bestD >= 0) { double d1 = dpsi, d2 = dpsip; Dref = climb(delta_of, &d1, &d2, N, ra, rb, &st); printf("U1DOB-DELTA phi grid %d: Delta = %.9f after %d accepted moves (grid %.9f, movement %+.2e) at psi=%.4f psi'=%.4f; the tilt bound 1 - e^-Delta = %.9f\n", N, Dref, st, bestD, Dref - bestD, d1, d2, 1 - exp(-Dref)); }
  double C = C2 > C1 ? C2 : C1; double rel = fabs(C2 - C1) / (C > 1e-6 ? C : 1e-6);
  printf("U1DOB-KAT K5 the two phi grids (%d, %d) on C: %.9f against %.9f, relative difference %.2e [%s]\n", N, N2, C1, C2, rel, rel < 1e-3 ? "MET" : "FAILED");
  if (signed_joint || signed_margB) printf("U1DOB-REFUSED C: the truncated joint density is %s and the conditioning marginal is %s on the grid -- the numbers above are an L1 distance between SIGNED truncated laws, not a total variation; no C is read from this record at this cap\n", signed_joint ? "SIGNED" : "positive", signed_margB ? "NOT POSITIVE" : "positive");
  else { printf("U1DOB-RESULT C(A,B) at the datum = %.9f (a grid-refined LOWER bound on the group's supremum; charges to %d); S20 (twenty adjacent coarse plaquettes, kappa -> 0) = %.6f %s\n", C, L, 20 * C, 20 * C > 1 ? "> 1 (survives the grid)" : "< 1 (the grid cannot certify it)");
    if (Dref >= 0) printf("U1DOB-RATIO C / (1 - e^-Delta) = %.6f (Delta = %.9f, bound %.9f)\n", C / (1 - exp(-Dref)), Dref, 1 - exp(-Dref)); }
  printf("U1DOB-DONE\n"); return 0; }
