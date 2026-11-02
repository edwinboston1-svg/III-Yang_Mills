/* twist.c -- M2b's centre-twist reader (2026-11-02): the CENTRE-TWIST DISTINGUISHABILITY of the two coarse loops' joint law at a fine datum, from
 * the engine's junction-tensor dump (W2-F lines).  The representation code (Dsub, rep) and the quadrature rule are w2_strip_n.c's / l2dob.c's.
 * p(U,V) = sum_{a,c<=L} d_a d_c sum P^{ac}_{rq,r'q'} conj D^a(U)_{rq} conj D^c(V)_{r'q'},  P = F/Z;   the centre acts by D^a(-U) = (-1)^a D^a(U).
 * Printed:  T_full(A) = (1/2) int int |p(U,V) - p(-U,V)|  (the total variation between the pair's law and its image under the centre flip of A)
 *           T_conn(A) = int int |c_odd(U,V)|, c = p - p_A p_B the connected density, c_odd its part odd in U (a odd, c >= 1)
 *           the same for B, and the leading-mode identity: for p = 1 + eps chi_1/2(U) chi_1/2(V) (Haar marginals) rho = eps, C = 16 eps/(3 pi),
 *           T = eps (8/(3 pi))^2, so rho/T = 9 pi^2/64 = 1.38791 and C/T = 3 pi/4 = 2.35619.
 * usage: twist <dump> [deg=24]        twist SYN eps   (the known answer)        build: gcc -O2 -fopenmp -o twist.exe twist.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <complex.h>
#ifdef _OPENMP
#include <omp.h>
#endif
typedef double complex cplx;
#define PI 3.141592653589793
typedef struct { double w, x, y, z; } quat;
static quat qinv(quat a) { quat r = { a.w, -a.x, -a.y, -a.z }; return r; }
static double FACT[40]; static int GENINV = 1;
static void Dsub(int s, quat q, cplx *D) {
  cplx a = q.w + I * q.x, b = q.y + I * q.z, ab = q.w - I * q.x, nbb = -q.y + I * q.z;
  cplx poly[40], np[40];
  for (int qq = 0; qq <= s; qq++) { int len = 1; poly[0] = 1;
    for (int r = 0; r < qq; r++) { for (int k = 0; k <= len; k++) np[k] = 0; for (int k = 0; k < len; k++) { np[k + 1] += poly[k] * a; np[k] += poly[k] * b; } len++; for (int k = 0; k < len; k++) poly[k] = np[k]; }
    for (int r = 0; r < s - qq; r++) { for (int k = 0; k <= len; k++) np[k] = 0; for (int k = 0; k < len; k++) { np[k + 1] += poly[k] * nbb; np[k] += poly[k] * ab; } len++; for (int k = 0; k < len; k++) poly[k] = np[k]; }
    for (int p = 0; p <= s; p++) { double sc = sqrt(FACT[p] * FACT[s - p] / (FACT[qq] * FACT[s - qq])); D[p * (s + 1) + qq] = poly[p] * sc; } } }
static void rep(int s, quat q, cplx *D) { if (s == 0) { D[0] = 1; return; } Dsub(s, GENINV ? qinv(q) : q, D); }
static void gauss_legendre(int n, double *x, double *w) { for (int i = 1; i <= n; i++) { double z = cos(PI * (i - 0.25) / (n + 0.5)), dp = 0;
    for (int it = 0; it < 200; it++) { double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2 * k - 1) * z * p1 - (k - 1) * p0) / k; p0 = p1; p1 = p2; } dp = n * (z * p1 - p0) / (z * z - 1); double z1 = z; z = z1 - p1 / dp; if (fabs(z - z1) < 1e-15) break; }
    double p0 = 1, p1 = z; for (int k = 2; k <= n; k++) { double p2 = ((2 * k - 1) * z * p1 - (k - 1) * p0) / k; p0 = p1; p1 = p2; } dp = n * (z * p1 - p0) / (z * z - 1); x[i - 1] = z; w[i - 1] = 2 / ((1 - z * z) * dp * dp); } }
static int make_rule(int deg, quat **RUo, double **RWo) { int nth = (deg + 2) / 2, ngl = (deg + 2) / 2, naz = deg + 1; double gx[400], gw[400]; gauss_legendre(ngl, gx, gw);
  int NPT = nth * ngl * naz; quat *RU = malloc(sizeof(quat) * NPT); double *RW = malloc(sizeof(double) * NPT); int n = 0;
  for (int k = 1; k <= nth; k++) { double th = k * PI / (nth + 1), wt = 2 * sin(th) * sin(th) / (nth + 1);
    for (int j = 0; j < ngl; j++) { double t = gx[j], st = sqrt(1 - t * t);
      for (int l = 0; l < naz; l++) { double ph = 2 * PI * l / naz; quat u = { cos(th), sin(th) * st * cos(ph), sin(th) * st * sin(ph), sin(th) * t }; RU[n] = u; RW[n] = wt * gw[j] / 2 / naz; n++; } } }
  *RUo = RU; *RWo = RW; return NPT; }
static int LMAX = 0; static cplx P[3][3][3][3][3][3];   /* P[a][c][r][q][r'][q'] = F/Z, a, c <= 2 */
int main(int argc, char **argv) {
  FACT[0] = 1; for (int i = 1; i < 40; i++) FACT[i] = FACT[i - 1] * i;
  if (argc < 2) { fprintf(stderr, "usage: twist <dump> [deg] | SYN eps\n"); return 1; }
  int deg = 24; double Z = 0; const char *tag = argv[1]; if (argc > 3 && !strcmp(argv[1], "SYN")) deg = atoi(argv[3]);
  if (!strcmp(argv[1], "SYN")) { double eps = argc > 2 ? atof(argv[2]) : 0.05; LMAX = 2; memset(P, 0, sizeof P); P[0][0][0][0][0][0] = 1;
    /* p = 1 + eps chi(U) chi(V): chi_1/2(U) = tr D^1(U), conj D^1 summed on the diagonal -> P^{11}_{rr, r'r'} = eps (d_a d_c = 4 cancels against chi = sum_r conj D_rr ... with weight 1/4) */
    for (int r = 0; r < 2; r++) for (int rp = 0; rp < 2; rp++) P[1][1][r][r][rp][rp] = eps / 4.0; tag = "SYN"; }
  else { FILE *f = fopen(argv[1], "r"); if (!f) { fprintf(stderr, "cannot open %s\n", argv[1]); return 1; } if (argc > 2) deg = atoi(argv[2]);
    char line[4096]; int n = 0; memset(P, 0, sizeof P);
    while (fgets(line, sizeof line, f)) {
      if (!strncmp(line, "W2-FHEAD", 8)) { char *z = strstr(line, "Z="), *g = strstr(line, "GENINV="), *l = strstr(line, "LMAX="); if (z) Z = atof(z + 2); if (g) GENINV = atoi(g + 7); if (l) LMAX = atoi(l + 5); }
      else if (!strncmp(line, "W2-F ", 5)) { int a, c, r, q, rp, qp; double re, im; if (sscanf(line, "W2-F a=%d c=%d r=%d q=%d rp=%d qp=%d %lf %lf", &a, &c, &r, &q, &rp, &qp, &re, &im) == 8 && a <= 2 && c <= 2) { P[a][c][r][q][rp][qp] = re + I * im; n++; } } }
    fclose(f); if (Z == 0 || n == 0) { fprintf(stderr, "no dump in %s\n", argv[1]); return 1; }
    for (int a = 0; a <= 2; a++) for (int c = 0; c <= 2; c++) for (int r = 0; r < 3; r++) for (int q = 0; q < 3; q++) for (int rp = 0; rp < 3; rp++) for (int qp = 0; qp < 3; qp++) P[a][c][r][q][rp][qp] /= Z;
    if (LMAX > 2) LMAX = 2;
    const char *b = strrchr(argv[1], '/'); tag = b ? b + 1 : argv[1]; }
  quat *RU; double *RW; int NPT = make_rule(deg, &RU, &RW);
  /* basis values: phi[pt][k] for k over (a, r, q), a = 0..LMAX, value d_a conj D^a(U)_{rq} */
  int nb = 0, ka[16], kr[16], kq[16]; for (int a = 0; a <= LMAX; a++) for (int r = 0; r <= a; r++) for (int q = 0; q <= a; q++) { ka[nb] = a; kr[nb] = r; kq[nb] = q; nb++; }
  cplx *phi = malloc(sizeof(cplx) * NPT * nb);
  for (int pt = 0; pt < NPT; pt++) { cplx D[3][9]; for (int a = 0; a <= LMAX; a++) rep(a, RU[pt], D[a]); for (int k = 0; k < nb; k++) phi[(size_t)pt * nb + k] = (ka[k] + 1) * conj(D[ka[k]][kr[k] * (ka[k] + 1) + kq[k]]); }
  /* the coefficient matrices: full M[k][k'] = P^{a c}_{r q, r' q'};  connected G = P^{ac} - P^{a0} P^{0c} for a, c >= 1 */
  cplx M[16][16], G[16][16]; for (int i = 0; i < nb; i++) for (int j = 0; j < nb; j++) { int a = ka[i], c = ka[j]; M[i][j] = P[a][c][kr[i]][kq[i]][kr[j]][kq[j]];
      G[i][j] = (a >= 1 && c >= 1) ? M[i][j] - P[a][0][kr[i]][kq[i]][0][0] * P[0][c][0][0][kr[j]][kq[j]] : 0; }
  double TfA = 0, TfB = 0, TcA = 0, TcB = 0, TcAll = 0, mass = 0, pmin = 1e300;
  #pragma omp parallel for reduction(+:TfA,TfB,TcA,TcB,TcAll,mass) reduction(min:pmin) schedule(static)
  for (int u = 0; u < NPT; u++) { const cplx *fu = phi + (size_t)u * nb;
    for (int v = 0; v < NPT; v++) { const cplx *fv = phi + (size_t)v * nb; double w = RW[u] * RW[v];
      cplx pf = 0, oA = 0, oB = 0, cA = 0, cB = 0, cc = 0;
      for (int i = 0; i < nb; i++) { cplx rowM = 0, rowG = 0, rowModdB = 0, rowGoddB = 0; for (int j = 0; j < nb; j++) { rowM += M[i][j] * fv[j]; rowG += G[i][j] * fv[j]; if (ka[j] & 1) { rowModdB += M[i][j] * fv[j]; rowGoddB += G[i][j] * fv[j]; } }
        pf += fu[i] * rowM; cc += fu[i] * rowG; if (ka[i] & 1) { oA += fu[i] * rowM; cA += fu[i] * rowG; } oB += fu[i] * rowModdB; cB += fu[i] * rowGoddB; }
      double pr = creal(pf); if (pr < pmin) pmin = pr; mass += w * pr;
      TfA += w * fabs(creal(oA)); TfB += w * fabs(creal(oB)); TcA += w * fabs(creal(cA)); TcB += w * fabs(creal(cB)); TcAll += w * fabs(creal(cc)); } }
  /* p(U,V) - p(-U,V) = 2 (part odd in U), so (1/2) int |p - p(-U,.)| = int |odd part| */
  printf("TWIST %s deg=%d (%d points a factor): mass %.12f, min p %.6e; T_full(A) = %.9f, T_full(B) = %.9f; T_conn(A) = %.9f, T_conn(B) = %.9f, int|c| = %.9f\n", tag, deg, NPT, mass, pmin, TfA, TfB, TcA, TcB, TcAll);
  printf("TWIST-LEADING %s: the leading-mode values rho/T = 9 pi^2/64 = %.6f, C/T = 3 pi/4 = %.6f; this law's T_conn(A)/int|c| = %.6f (1 iff the coupling is wholly centre-odd in A)\n", tag, 9 * PI * PI / 64, 3 * PI / 4, TcA / TcAll);
  if (!strcmp(tag, "SYN")) { double eps = argc > 2 ? atof(argv[2]) : 0.05;
    /* (05:5x, after the first KAT failed by a constant 2.52 %): the rule's own E|chi_1/2| = sum_pt w |2 cos theta| is what a product rule can
       return for int int |eps chi chi|; the deficit against 8/(3 pi) is the rule resolving the kink of |.|, O(1/nth^2).  The code's KAT is the
       rule's own value to roundoff; the quadrature's convergence is printed beside it. */
    double er = 0; for (int pt = 0; pt < NPT; pt++) er += RW[pt] * fabs(2 * RU[pt].w);
    printf("TWIST-KAT SYN eps=%g: the rule's own value eps (sum w |chi|)^2 = %.12f, read T_conn(A) = %.12f, T_full(A) = %.12f -> %s; the Haar value eps (8/(3 pi))^2 = %.9f (the rule's |chi| deficit %.3f %%)\n",
      eps, eps * er * er, TcA, TfA, (fabs(TcA - eps * er * er) < 1e-10 && fabs(TfA - TcA) < 1e-12) ? "MET" : "FAILED", eps * 64 / (9 * PI * PI), 100 * (1 - er / (8 / (3 * PI)))); }
  return 0; }
