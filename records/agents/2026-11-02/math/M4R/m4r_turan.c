/* m4r_turan.c -- M4R's check of M4's Theorem 8.1 (Turan slaving) and of its numbers (rec/turan_check.txt). Double precision.
 * (1) kappa_j(beta) of the SU(2) Wilson weight by DIRECT quadrature of the character integral
 *       kappa_j = [ (2/pi) int_0^pi e^{beta cos t} sin((2j+1)t) sin t dt ] / [ (2j+1) (2/pi) int_0^pi e^{beta cos t} sin^2 t dt ],
 *     a road sharing nothing with M4's Bessel series, compared with I_{2j+1}/I_1 from the integral I_n = (1/pi) int e^{b cos t} cos nt.
 * (2) the slaving ratio kappa_1/kappa_1/2^2 at M4's eight couplings; U(1)'s I2 I0/I1^2.
 * (3) log-concavity margins of n -> I_n(beta), n <= 40, on a beta grid; monotonicity of I3 I1/I2^2 in beta.
 * (4) the m-fold convolution: its ratio is (I3 I1/I2^2)^m, so the bracket [2/3, 1) holds for m = 1 only.
 * (5) Theorem 8.1(a) on a DISCRETE convolution law K(U V^{-1}) at beta = 2.2 (the reader's analyse(): second singular value,
 *     SO(3) channel, O-blocks) against kappa_1/2 = I2/I1 and kappa_1 = I3/I1.
 * build: gcc -O2 -o m4r_turan.exe m4r_turan.c -lm      (includes m4r_reader.c for its rule and its linear algebra) */
#define main reader_main
#include "m4r_reader.c"
#undef main
static double GLX[400], GLW[400]; static int GLN = 0;
static void glinit(int n) { GLN = n; gl(n, GLX, GLW); }
/* int_0^pi f(t) dt by Gauss-Legendre on [0, pi] */
static double In_int(int n, double b) { double s = 0; for (int i = 0; i < GLN; i++) { double t = 0.5 * PI * (GLX[i] + 1); s += GLW[i] * 0.5 * PI * exp(b * cos(t)) * cos(n * t); } return s / PI; }
static double kappa_direct(int twoj, double b) { double num = 0, den = 0; for (int i = 0; i < GLN; i++) { double t = 0.5 * PI * (GLX[i] + 1), w = GLW[i] * 0.5 * PI, e = exp(b * cos(t));
    num += w * e * sin((twoj + 1) * t) * sin(t); den += w * e * sin(t) * sin(t); } return num / ((twoj + 1) * den); }
int main(void) { glinit(200);
  double bs[8] = { 0.1, 0.4764, 1.0, 2.2, 2.3, 3.0, 5.0, 10.0 };
  double m4su2[8] = { 0.666805, 0.669783, 0.679893, 0.720739, 0.724706, 0.752683, 0.820421, 0.902270 }, m4u1[8] = { 0.500416, 0.509259, 0.538080, 0.637994, 0.646473, 0.701153, 0.805187, 0.900470 };
  printf("M4R-TURAN beta | kappa_1/2 direct, I2/I1 | kappa_1 direct, I3/I1 | ratio direct (M4) | U(1) I2 I0/I1^2 (M4)\n");
  double maxdev = 0;
  for (int i = 0; i < 8; i++) { double b = bs[i]; double kh = kappa_direct(1, b), k1 = kappa_direct(2, b), I0 = In_int(0, b), I1 = In_int(1, b), I2 = In_int(2, b), I3 = In_int(3, b);
    double r = k1 / (kh * kh), ru = I2 * I0 / (I1 * I1); maxdev = fmax(maxdev, fmax(fabs(r - m4su2[i]), fabs(ru - m4u1[i])));
    printf("M4R-TURAN %6.4f | %.9f %.9f | %.9f %.9f | %.6f (%.6f) | %.6f (%.6f)\n", b, kh, I2 / I1, k1, I3 / I1, r, m4su2[i], ru, m4u1[i]); }
  printf("M4R-TURAN max deviation from M4's printed six-digit ratios: %.1e\n", maxdev);
  /* (3) log-concavity margins and monotonicity */
  double minmarg = 1e9, minb = 0; int minn = -1; double prev = 0; int mono = 1; double rmin = 1e9, rmax = -1;
  /* ratios q_n = I_{n+1}/I_n by Miller's backward recurrence (I_{n-1} = I_{n+1} + (2n/b) I_n), a road sharing nothing with the
   * series or the quadrature; the margin (I_{n+1}^2 - I_n I_{n+2})/I_{n+1}^2 = 1 - q_{n+1}/q_n */
  for (int ib = 1; ib <= 3000; ib++) { double b = 0.01 * ib; int N = 400; double q[402]; /* q[n] = I_{n+1}/I_n */
    double r_next = 0; /* ratio at N: I_{N+1}/I_N ~ 0 */ q[N] = 0; for (int n = N; n >= 1; n--) { /* I_{n-1}/I_n = q_n + 2n/b  =>  q_{n-1} = 1/(q_n + 2n/b) */ q[n - 1] = 1.0 / (q[n] + 2.0 * n / b); } (void)r_next;
    for (int n = 0; n <= 40; n++) { double m = 1 - q[n + 1] / q[n]; if (m < minmarg) { minmarg = m; minb = b; minn = n; } }
    double r = q[2] / q[1]; /* I3 I1 / I2^2 = (I3/I2)/(I2/I1) */ if (ib > 1 && r < prev - 1e-13) mono = 0; prev = r; rmin = fmin(rmin, r); rmax = fmax(rmax, r);
    if (ib == 220) { double I1 = In_int(1, b), I2 = In_int(2, b), I3 = In_int(3, b); printf("M4R-MILLER beta = 2.2: I2/I1 by recurrence %.12f, by quadrature %.12f; I3/I2 %.12f vs %.12f\n", q[1], I2 / I1, q[2], I3 / I2); } }
  printf("M4R-LOGCONCAVE min over beta in [0.01, 30] and n <= 40 of (I_{n+1}^2 - I_n I_{n+2})/I_{n+1}^2 = %.4e at beta = %.2f, n = %d [%s]\n", minmarg, minb, minn, minmarg > 0 ? "POSITIVE" : "NOT POSITIVE");
  printf("M4R-MONOTONE I3 I1/I2^2 on beta in [0.01, 30]: %s, range [%.6f, %.6f]\n", mono ? "nondecreasing" : "NOT monotone", rmin, rmax);
  /* (4) convolutions */
  for (int m = 1; m <= 3; m++) { double b = 0.01, I1 = In_int(1, b), I2 = In_int(2, b), I3 = In_int(3, b); double r = pow(I3 * I1 / (I2 * I2), m);
    printf("M4R-CONV the %d-fold convolution of Wilson weights at beta = 0.01: kappa_1/kappa_1/2^2 = %.6f (the claimed bracket's floor 2/3 = 0.666667)\n", m, r); }
  /* (5) Theorem 8.1(a) on a discrete convolution law */
  { double b = 2.2, Z = 2 * In_int(1, b) / b; rule R = mkrule(14, 10, 20); int n = R.n; double *pi = malloc(sizeof(double) * (size_t)n * n);
    for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) { qt U = R.U[i], V = R.U[j]; double dot = U.w * V.w + U.x * V.x + U.y * V.y + U.z * V.z; pi[(size_t)i * n + j] = R.w[i] * R.w[j] * exp(b * dot) / Z; }
    printf("M4R-CONVLAW beta = 2.2: expected rho = kappa_1/2 = I2/I1 = %.9f, SO(3) channel = kappa_1 = I3/I1 = %.9f, kappa_3/2 = I4/I1 = %.9f\n", In_int(2, b) / In_int(1, b), In_int(3, b) / In_int(1, b), In_int(4, b) / In_int(1, b));
    analyse("Wilson-convolution beta=2.2 [14,10,20]", n, pi, R.anti); free(pi); }
  return 0; }
