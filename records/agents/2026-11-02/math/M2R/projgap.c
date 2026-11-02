/* projgap.c -- the draft's "Consequences" after Lemma 7.2 read as a statement about ANY orthogonal projections: for P_1..P_N with pairwise
 * Friedrichs cosines c_ij = ||P_i P_j - P_{M_i cap M_j}||, is the least eigenvalue of sum_i (I - P_i) on (cap_i M_i)^perp at least
 * 1 - rho(C)?  Random subspaces of R^n with planted common parts (so pairwise intersections are nontrivial and differ from the total one).
 * usage: projgap SEED   build: gcc -O2 -o projgap.exe projgap.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
static unsigned long long S = 0x2545F4914F6CDD1DULL;
static double urand(void) { S ^= S << 13; S ^= S >> 7; S ^= S << 17; return (S >> 11) * (1.0 / 9007199254740992.0); }
static double grand(void) { double u = urand() + 1e-300, v = urand(); return sqrt(-2 * log(u)) * cos(2 * M_PI * v); }
#define NM 24
static void jacobi(int n, double *a, double *ev, double *V) {
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) V[i * n + j] = (i == j);
  for (int sweep = 0; sweep < 300; sweep++) { double off = 0, tot = 0; for (int p = 0; p < n; p++) for (int q = 0; q < n; q++) { tot += a[p * n + q] * a[p * n + q]; if (q > p) off += a[p * n + q] * a[p * n + q]; } if (off <= 1e-30 * tot || off < 1e-300) break;
    for (int p = 0; p < n; p++) for (int q = p + 1; q < n; q++) { if (fabs(a[p * n + q]) < 1e-300) continue;
      double th = (a[q * n + q] - a[p * n + p]) / (2 * a[p * n + q]); double t = (th >= 0 ? 1 : -1) / (fabs(th) + sqrt(th * th + 1)); double c = 1 / sqrt(t * t + 1), s = t * c;
      for (int k = 0; k < n; k++) { double akp = a[k * n + p], akq = a[k * n + q]; a[k * n + p] = c * akp - s * akq; a[k * n + q] = s * akp + c * akq; }
      for (int k = 0; k < n; k++) { double apk = a[p * n + k], aqk = a[q * n + k]; a[p * n + k] = c * apk - s * aqk; a[q * n + k] = s * apk + c * aqk; }
      for (int k = 0; k < n; k++) { double vkp = V[k * n + p], vkq = V[k * n + q]; V[k * n + p] = c * vkp - s * vkq; V[k * n + q] = s * vkp + c * vkq; } } }
  for (int i = 0; i < n; i++) ev[i] = a[i * n + i];
  for (int i = 0; i < n; i++) for (int j = i + 1; j < n; j++) if (ev[j] > ev[i]) { double t = ev[i]; ev[i] = ev[j]; ev[j] = t; for (int k = 0; k < n; k++) { t = V[k * n + i]; V[k * n + i] = V[k * n + j]; V[k * n + j] = t; } } }
static void projector(int n, int d, const double *B, double *P) { /* B: n x d columns, stride d */ double O[NM * NM]; int r = 0;
  for (int k = 0; k < d; k++) { double v[NM]; for (int i = 0; i < n; i++) v[i] = B[i * d + k];
    for (int it = 0; it < 2; it++) for (int j = 0; j < r; j++) { double dp = 0; for (int i = 0; i < n; i++) dp += v[i] * O[i * NM + j]; for (int i = 0; i < n; i++) v[i] -= dp * O[i * NM + j]; }
    double nv = 0; for (int i = 0; i < n; i++) nv += v[i] * v[i]; nv = sqrt(nv); if (nv < 1e-9) continue; for (int i = 0; i < n; i++) O[i * NM + r] = v[i] / nv; r++; }
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) { double t = 0; for (int k = 0; k < r; k++) t += O[i * NM + k] * O[j * NM + k]; P[i * n + j] = t; } }
/* projector onto the eigenvalue-m eigenspace of a sum of m projections (the intersection of their ranges) */
static void interproj(int n, int m, double **Ps, double *Pint) { double A[NM * NM], ev[NM], V[NM * NM]; for (int i = 0; i < n * n; i++) { A[i] = 0; for (int k = 0; k < m; k++) A[i] += Ps[k][i]; }
  jacobi(n, A, ev, V); for (int i = 0; i < n * n; i++) Pint[i] = 0; for (int c = 0; c < n; c++) if (ev[c] > m - 1e-7) for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) Pint[i * n + j] += V[i * n + c] * V[j * n + c]; }
static double opnorm(int n, const double *X) { double XX[NM * NM], ev[NM], V[NM * NM]; for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) { double t = 0; for (int k = 0; k < n; k++) t += X[k * n + i] * X[k * n + j]; XX[i * n + j] = t; } jacobi(n, XX, ev, V); return sqrt(ev[0] > 0 ? ev[0] : 0); }
int main(int argc, char **argv) { if (argc > 1) S ^= (unsigned long long)atoll(argv[1]) * 0x9E3779B97F4A7C15ULL;
  double worst = 0, worstrho = 0; int tried = 0, nontriv = 0; double best_record[4] = {0};
  for (int t = 0; t < 4000; t++) { int n = 4 + t % 9, N = 2 + t % 4; double *Ps[8]; double Bs[8][NM * NM]; int ds[8];
    int dcom = (t / 7) % 3; if (dcom > n - 2) dcom = 0; double common[NM * NM]; for (int i = 0; i < n * NM; i++) common[i] = grand();
    for (int k = 0; k < N; k++) { int d = 1 + (int)(urand() * (n - 1)); if (d > n - 1) d = n - 1; int share = (k % 2 == 0) ? dcom : 0; if (share > d) share = d; ds[k] = d;
      for (int i = 0; i < n; i++) for (int c = 0; c < d; c++) Bs[k][i * d + c] = (c < share) ? common[i * NM + c] : grand(); Ps[k] = malloc(sizeof(double) * n * n); projector(n, d, Bs[k], Ps[k]); }
    double C[64] = {0}; for (int i = 0; i < N; i++) for (int j = i + 1; j < N; j++) { double *pp[2] = { Ps[i], Ps[j] }; double Pij[NM * NM]; interproj(n, 2, pp, Pij);
      double X[NM * NM]; for (int a = 0; a < n; a++) for (int b = 0; b < n; b++) { double s = 0; for (int k = 0; k < n; k++) s += Ps[i][a * n + k] * Ps[j][k * n + b]; X[a * n + b] = s - Pij[a * n + b]; }
      C[i * N + j] = C[j * N + i] = opnorm(n, X); }
    double Cc[64], evc[8], Vc[64]; memcpy(Cc, C, sizeof Cc); jacobi(N, Cc, evc, Vc); double rhoC = evc[0];
    double Pall[NM * NM]; interproj(n, N, Ps, Pall);
    /* sum (I - P_i) restricted to (cap)^perp: eigenvalues of A = sum(I - P_i) + N * Pall (pushes the kernel up), least one */
    double A[NM * NM], ev[NM], V[NM * NM]; for (int a = 0; a < n * n; a++) { A[a] = 0; for (int k = 0; k < N; k++) A[a] += ((a / n) == (a % n)) - Ps[k][a]; A[a] += N * Pall[a]; }
    jacobi(n, A, ev, V); double gap = ev[n - 1];
    tried++; if (rhoC < 1 - 1e-6) { nontriv++; double r = (1 - rhoC) / gap; if (r > worst) { worst = r; worstrho = rhoC; best_record[0] = n; best_record[1] = N; best_record[2] = gap; best_record[3] = dcom; } }
    for (int k = 0; k < N; k++) free(Ps[k]); }
  printf("PROJGAP %d families (%d with rho(C) < 1): worst (1 - rho(C)) / gap = %.12f at rho(C) = %.6f (n=%g N=%g gap=%.6f planted common dim %g) %s\n",
    tried, nontriv, worst, worstrho, best_record[0], best_record[1], best_record[2], best_record[3], worst <= 1 + 1e-9 ? "[HELD]" : "[COUNTEREXAMPLE: the general-projection reading FAILS]");
  return 0; }
