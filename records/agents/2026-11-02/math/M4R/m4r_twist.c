/* m4r_twist.c -- M4R's exact test of M4's Theorem 2.1 (the twist identity), Proposition 2.2 (the vortex recursion) and the
 * identification inside Theorem 3.3, on a lattice gauge theory small enough to integrate EXACTLY (finite sums, no sampling):
 * the binary dihedral... no: the quaternion group Q8 = {+-1, +-i, +-j, +-k} (centre {+-1}, Q8/{+-1} = V4, the "SO(3)" of this
 * shadow), Wilson weight w(U) = exp(beta Re tr U) = exp(2 beta Re q), on the 2D periodic lattice 4 x 2 (16 links, 8 plaquettes,
 * every link in two plaquettes), maximal tree gauge (7 links fixed to 1), 9 free links: 8^9 = 134,217,728 configurations summed.
 * Coarse variables (holonomies of disjoint paths of free links):
 *   v_a = U(0,1;1) U(1,1;1)  (path (0,1)->(2,1)),  v_b = U(2,1;1) U(3,1;1)  (path (2,1)->(0,1)),  v_c = U(3,0;1);
 *   fibre: the four links (x,1;2).  Scale k (finer): (U(0,1;1), U(1,1;1), v_b, v_c), with v_a = their product.
 * Checks (relative deviations printed; a dead instrument would print the same zeros, so each identity is paired with a sighted
 * control that must NOT hold):
 *  T1 (2.1a)  lambda(sigma_a v) = lambda(v) nu(B_f|v) for f = (0,1;1) and for f' = (1,1;1)        [control: f'' on path b]
 *  T2 (2.1c)  nu(B_g|v) = 1 for the fibre link g = (0,1;2); nu(B_{d(f+g)}|v) = nu(B_f|v)           [control: nu(B_f|v) != 1]
 *  T3 (2.1b)  nu(B_f|v) nu(B_f|sigma_a v) = 1
 *  T4 (2.2)   exp(-F_{k+1}(v')) = E_{lambda_k}[exp(-F_k(v)) | c(v) = v']
 *  T5 (3.3)   for every environment v_c: the label free energy of the conditional law of (v_a, v_b) equals -log nu(B_f|v);
 *             Lemma 3.1 with Q8 -> V4 orbits: rho <= sqrt(rhot^2 + tau_a^2 + tau_b^2); tau <= 2 sinh Delta (Lemma 3.2(ii)).
 * build: gcc -O2 -o m4r_twist.exe m4r_twist.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
typedef struct { int w, x, y, z; } qi;
static qi EL[8] = { {1,0,0,0}, {-1,0,0,0}, {0,1,0,0}, {0,-1,0,0}, {0,0,1,0}, {0,0,-1,0}, {0,0,0,1}, {0,0,0,-1} };
static int MUL[8][8], INV[8], NEG[8], RE[8];
static int idx(qi q) { for (int i = 0; i < 8; i++) if (EL[i].w == q.w && EL[i].x == q.x && EL[i].y == q.y && EL[i].z == q.z) return i; return -1; }
static void tables(void) { for (int a = 0; a < 8; a++) { qi p = EL[a]; for (int b = 0; b < 8; b++) { qi q = EL[b], r;
      r.w = p.w*q.w - p.x*q.x - p.y*q.y - p.z*q.z; r.x = p.w*q.x + p.x*q.w + p.y*q.z - p.z*q.y; r.y = p.w*q.y - p.x*q.z + p.y*q.w + p.z*q.x; r.z = p.w*q.z + p.x*q.y - p.y*q.x + p.z*q.w;
      MUL[a][b] = idx(r); if (MUL[a][b] < 0) { fprintf(stderr, "not closed\n"); exit(1); } }
    qi c = { p.w, -p.x, -p.y, -p.z }; INV[a] = idx(c); qi n = { -p.w, -p.x, -p.y, -p.z }; NEG[a] = idx(n); RE[a] = p.w; } }
/* the 16 links: L(x,y,mu) -> slot; free slots get a configuration digit, fixed ones are 0 (= +1) */
#define LX 4
#define LY 2
static int slot(int x, int y, int mu) { x = ((x % LX) + LX) % LX; y = ((y % LY) + LY) % LY; return (x * LY + y) * 2 + (mu - 1); }
int main(int argc, char **argv) { tables(); double beta = argc > 1 ? atof(argv[1]) : 0.7;
  /* tree: (x,0;2) x=0..3 and (0,0;1),(1,0;1),(2,0;1) */
  int fixedv[16]; for (int s = 0; s < 16; s++) fixedv[s] = 0; int isfree[16] = {0};
  int freeL[9][3] = { {3,0,1}, {0,1,1}, {1,1,1}, {2,1,1}, {3,1,1}, {0,1,2}, {1,1,2}, {2,1,2}, {3,1,2} }; int fs[9]; for (int i = 0; i < 9; i++) { fs[i] = slot(freeL[i][0], freeL[i][1], freeL[i][2]); isfree[fs[i]] = 1; }
  /* plaquettes */
  int P1[8], P2[8], P3[8], P4[8]; int np = 0; for (int x = 0; x < LX; x++) for (int y = 0; y < LY; y++) { P1[np] = slot(x, y, 1); P2[np] = slot(x + 1, y, 2); P3[np] = slot(x, y + 1, 1); P4[np] = slot(x, y, 2); np++; }
  int pidx[LX][LY]; { int k = 0; for (int x = 0; x < LX; x++) for (int y = 0; y < LY; y++) pidx[x][y] = k++; }
  /* twist plaquette sets (as indicator over the 8 plaquettes) */
  int Tf[8] = {0}, Tf2[8] = {0}, Tg[8] = {0}, Th[8] = {0}, Tfg[8] = {0}, Tfh[8] = {0};
  Tf[pidx[0][1]] = 1; Tf[pidx[0][0]] = 1;            /* f = (0,1;1): plaquettes (0,1) and (0,0) */
  Tf2[pidx[1][1]] = 1; Tf2[pidx[1][0]] = 1;          /* f' = (1,1;1) */
  Tg[pidx[0][1]] = 1; Tg[pidx[3][1]] = 1;            /* g = (0,1;2): plaquettes (0,1) and (3,1) */
  Th[pidx[2][1]] = 1; Th[pidx[2][0]] = 1;            /* h = (2,1;1) on path b */
  for (int p = 0; p < 8; p++) { Tfg[p] = Tf[p] ^ Tg[p]; Tfh[p] = Tf[p] ^ Th[p]; }
  double ew[3]; for (int r = -1; r <= 1; r++) ew[r + 1] = exp(2 * beta * r); /* w(U) = exp(2 beta Re q), Re in {-1,0,1} */
  /* accumulators: coarse (va, vb, vc) -> 512 bins; scale k (u1, u2, vb, vc) -> 4096 bins */
  static double lam[512], Bf[512], Bf2[512], Bg[512], Bfg[512], Bh[512], Bfh[512], lamk[4096], Bfk[4096];
  int cfg[9] = {0}; long long total = 1; for (int i = 0; i < 9; i++) total *= 8;
  int U[16];
  for (long long t = 0; t < total; t++) {
    for (int s = 0; s < 16; s++) U[s] = 0; for (int i = 0; i < 9; i++) U[fs[i]] = cfg[i];
    int Up[8]; double W = 1; for (int p = 0; p < 8; p++) { Up[p] = MUL[MUL[MUL[U[P1[p]]][U[P2[p]]]][INV[U[P3[p]]]]][INV[U[P4[p]]]]; W *= ew[RE[Up[p]] + 1]; }
    double bf = 1, bf2 = 1, bg = 1, bfg = 1, bh = 1, bfh = 1;
    for (int p = 0; p < 8; p++) { double r = ew[RE[NEG[Up[p]]] + 1] / ew[RE[Up[p]] + 1]; if (Tf[p]) bf *= r; if (Tf2[p]) bf2 *= r; if (Tg[p]) bg *= r; if (Tfg[p]) bfg *= r; if (Th[p]) bh *= r; if (Tfh[p]) bfh *= r; }
    int u1 = U[slot(0,1,1)], u2 = U[slot(1,1,1)], va = MUL[u1][u2], vb = MUL[U[slot(2,1,1)]][U[slot(3,1,1)]], vc = U[slot(3,0,1)];
    int b = (va * 8 + vb) * 8 + vc, bk = ((u1 * 8 + u2) * 8 + vb) * 8 + vc;
    lam[b] += W; Bf[b] += W * bf; Bf2[b] += W * bf2; Bg[b] += W * bg; Bfg[b] += W * bfg; Bh[b] += W * bh; Bfh[b] += W * bfh; lamk[bk] += W; Bfk[bk] += W * bf;
    for (int i = 0; i < 9; i++) { if (++cfg[i] < 8) break; cfg[i] = 0; } }
  double Z = 0; for (int b = 0; b < 512; b++) Z += lam[b]; for (int b = 0; b < 512; b++) { lam[b] /= Z; Bf[b] /= Z; Bf2[b] /= Z; Bg[b] /= Z; Bfg[b] /= Z; Bh[b] /= Z; Bfh[b] /= Z; } for (int b = 0; b < 4096; b++) { lamk[b] /= Z; Bfk[b] /= Z; }
  printf("M4R-TWIST Q8 Wilson beta = %.3f on the 4x2 torus, 8^9 = %lld configurations summed exactly; Z (unnormalised) = %.12e\n", beta, total, Z);
  double minlam = 1e300; for (int b = 0; b < 512; b++) if (lam[b] < minlam) minlam = lam[b];
  printf("M4R-TWIST the coarse law lambda on Q8^3: min mass %.4e (positive: %s)\n", minlam, minlam > 0 ? "yes" : "NO");
  /* nu(B|v) = B[v]/lam[v] */
  double t1 = 0, t1b = 0, t1c = 0, t2a = 0, t2b = 0, t2c = 0, t3 = 0, ctrl_ab = 0, ctrl_h = 0, tfh = 0;
  for (int va = 0; va < 8; va++) for (int vb = 0; vb < 8; vb++) for (int vc = 0; vc < 8; vc++) { int b = (va * 8 + vb) * 8 + vc, bs = (NEG[va] * 8 + vb) * 8 + vc, bsb = (va * 8 + NEG[vb]) * 8 + vc, bsab = (NEG[va] * 8 + NEG[vb]) * 8 + vc;
        double nf = Bf[b] / lam[b], nf2 = Bf2[b] / lam[b], ng = Bg[b] / lam[b], nfg = Bfg[b] / lam[b], nh = Bh[b] / lam[b], nfh = Bfh[b] / lam[b];
        t1 = fmax(t1, fabs(lam[bs] - lam[b] * nf) / lam[bs]); t1b = fmax(t1b, fabs(lam[bs] - lam[b] * nf2) / lam[bs]);
        t1c = fmax(t1c, fabs(lam[bsb] - lam[b] * nh) / lam[bsb]);
        ctrl_h = fmax(ctrl_h, fabs(lam[bs] - lam[b] * nh) / lam[bs]);          /* control: the path-b twist does NOT flip v_a */
        t2a = fmax(t2a, fabs(ng - 1)); t2b = fmax(t2b, fabs(nfg - nf) / nf); t2c = fmax(t2c, fabs(nf - 1));
        t3 = fmax(t3, fabs(nf * (Bf[bs] / lam[bs]) - 1));
        tfh = fmax(tfh, fabs(lam[bsab] - lam[b] * nfh) / lam[bsab]); ctrl_ab = fmax(ctrl_ab, fabs(lam[bs] - lam[b] * nfh) / lam[bs]); }
  printf("M4R-T1 (2.1a) max_v |lambda(sigma_a v) - lambda(v) nu(B_f|v)|/lambda(sigma_a v): f = %.2e, f' = %.2e; path b: %.2e | CONTROL (twist on path b read as a flip of v_a): %.3f\n", t1, t1b, t1c, ctrl_h);
  printf("M4R-T2 (2.1c) max_v |nu(B_g|v) - 1| (g a fibre link) = %.2e; max_v |nu(B_{f+dg}|v) - nu(B_f|v)|/nu(B_f|v) = %.2e | CONTROL max_v |nu(B_f|v) - 1| = %.3f\n", t2a, t2b, t2c);
  printf("M4R-T3 (2.1b) max_v |nu(B_f|v) nu(B_f|sigma_a v) - 1| = %.2e;  two coarse flips at once (B_{f+h} flips a and b): %.2e | CONTROL (read as a flip of a alone): %.3f\n", t3, tfh, ctrl_ab);
  /* T4: vortex recursion. scale k: F_k(u1,u2,vb,vc) = -log nu_k(B_f | ...), the flip of u1; scale k+1: the flip of va = u1 u2 */
  double t4 = 0, ctrl4 = 0;
  for (int va = 0; va < 8; va++) for (int vb = 0; vb < 8; vb++) for (int vc = 0; vc < 8; vc++) { int b = (va * 8 + vb) * 8 + vc; double num = 0, den = 0, numU = 0;
        for (int u1 = 0; u1 < 8; u1++) for (int u2 = 0; u2 < 8; u2++) if (MUL[u1][u2] == va) { int bk = ((u1 * 8 + u2) * 8 + vb) * 8 + vc; double nk = Bfk[bk] / lamk[bk]; num += lamk[bk] * nk; den += lamk[bk]; numU += nk / 8.0; }
        double lhs = Bf[b] / lam[b], rhs = num / den; t4 = fmax(t4, fabs(lhs - rhs) / lhs); ctrl4 = fmax(ctrl4, fabs(lhs - numU) / lhs); /* control: the UNWEIGHTED average */ }
  printf("M4R-T4 (2.2) max_v' |exp(-F_{k+1}(v')) - E_lambda_k[exp(-F_k) | c(v) = v']| / exp(-F_{k+1}) = %.2e | CONTROL (unweighted average over the fibre of c): %.3f\n", t4, ctrl4);
  /* T5: Theorem 3.3 on the conditional law of (va, vb) given vc; Q8 orbits under {+-1}: pairs {i, NEG[i]} */
  int orb[8]; int no = 0; int seen[8] = {0}; for (int i = 0; i < 8; i++) if (!seen[i]) { seen[i] = seen[NEG[i]] = 1; orb[i] = orb[NEG[i]] = no++; }
  double worstL31 = 0, worstF = 0, worst32 = 0, minprice = 1e9;
  for (int vc = 0; vc < 8; vc++) { double P[64]; for (int a = 0; a < 8; a++) for (int b = 0; b < 8; b++) P[a * 8 + b] = lam[(a * 8 + b) * 8 + vc];
    /* maximal correlations by power iteration on the small normalised matrix (8x8): use eigenvalues of M^T M via Jacobi */
    double pa[8] = {0}, pb[8] = {0}; for (int a = 0; a < 8; a++) for (int b = 0; b < 8; b++) { pa[a] += P[a * 8 + b]; pb[b] += P[a * 8 + b]; }
    double H[64]; for (int i = 0; i < 8; i++) for (int j = 0; j < 8; j++) { double s = 0; for (int r = 0; r < 8; r++) s += (P[r * 8 + i] / sqrt(pa[r] * pb[i])) * (P[r * 8 + j] / sqrt(pa[r] * pb[j])); H[i * 8 + j] = s; }
    /* Jacobi */
    double ev[8]; { int n = 8; double *A = H; for (int sw = 0; sw < 100; sw++) { double off = 0; for (int p = 0; p < n; p++) for (int q = p + 1; q < n; q++) off += A[p * n + q] * A[p * n + q]; if (off < 1e-30) break;
        for (int p = 0; p < n; p++) for (int q = p + 1; q < n; q++) { double apq = A[p * n + q]; if (fabs(apq) < 1e-300) continue; double th = (A[q * n + q] - A[p * n + p]) / (2 * apq), tt = (th >= 0 ? 1 : -1) / (fabs(th) + sqrt(th * th + 1)), c = 1 / sqrt(tt * tt + 1), s = tt * c;
            for (int k = 0; k < n; k++) { double x = A[k * n + p], y = A[k * n + q]; A[k * n + p] = c * x - s * y; A[k * n + q] = s * x + c * y; }
            for (int k = 0; k < n; k++) { double x = A[p * n + k], y = A[q * n + k]; A[p * n + k] = c * x - s * y; A[q * n + k] = s * x + c * y; } } } for (int i = 0; i < n; i++) ev[i] = A[i * n + i]; }
    for (int i = 0; i < 8; i++) for (int j = i + 1; j < 8; j++) if (ev[j] > ev[i]) { double tt = ev[i]; ev[i] = ev[j]; ev[j] = tt; }
    double rho = sqrt(fmax(ev[1], 0));
    /* orbit law (4 x 4) */
    double Q[16] = {0}; for (int a = 0; a < 8; a++) for (int b = 0; b < 8; b++) Q[orb[a] * 4 + orb[b]] += P[a * 8 + b];
    double qa[4] = {0}, qb[4] = {0}; for (int i = 0; i < 4; i++) for (int j = 0; j < 4; j++) { qa[i] += Q[i * 4 + j]; qb[j] += Q[i * 4 + j]; }
    double H2[16]; for (int i = 0; i < 4; i++) for (int j = 0; j < 4; j++) { double s = 0; for (int r = 0; r < 4; r++) s += (Q[r * 4 + i] / sqrt(qa[r] * qb[i])) * (Q[r * 4 + j] / sqrt(qa[r] * qb[j])); H2[i * 4 + j] = s; }
    double ev2[4]; { int n = 4; double *A = H2; for (int sw = 0; sw < 100; sw++) { double off = 0; for (int p = 0; p < n; p++) for (int q = p + 1; q < n; q++) off += A[p * n + q] * A[p * n + q]; if (off < 1e-30) break;
        for (int p = 0; p < n; p++) for (int q = p + 1; q < n; q++) { double apq = A[p * n + q]; if (fabs(apq) < 1e-300) continue; double th = (A[q * n + q] - A[p * n + p]) / (2 * apq), tt = (th >= 0 ? 1 : -1) / (fabs(th) + sqrt(th * th + 1)), c = 1 / sqrt(tt * tt + 1), s = tt * c;
            for (int k = 0; k < n; k++) { double x = A[k * n + p], y = A[k * n + q]; A[k * n + p] = c * x - s * y; A[k * n + q] = s * x + c * y; }
            for (int k = 0; k < n; k++) { double x = A[p * n + k], y = A[q * n + k]; A[p * n + k] = c * x - s * y; A[q * n + k] = s * x + c * y; } } } for (int i = 0; i < n; i++) ev2[i] = A[i * n + i]; }
    for (int i = 0; i < 4; i++) for (int j = i + 1; j < 4; j++) if (ev2[j] > ev2[i]) { double tt = ev2[i]; ev2[i] = ev2[j]; ev2[j] = tt; }
    double rhot = sqrt(fmax(ev2[1], 0));
    /* tau_a: for each orbit of va, binary label vs vb: Lemma 3.2(i)'s exact formula; and Delta from the FIBRE expectation nu(B_f|v) */
    double taua = 0, taub = 0, Da = 0, Db = 0;
    for (int a = 0; a < 8; a++) { if (a > NEG[a]) continue; double S0 = 0, S1 = 0, S2 = 0, ma = pa[a], mm = pa[NEG[a]], t0 = (ma - mm) / (ma + mm), tv[8], ov[8], Fmx = -1e300, Fmn = 1e300;
      for (int b = 0; b < 8; b++) { double pp = P[a * 8 + b], pm = P[NEG[a] * 8 + b]; tv[b] = (pp - pm) / (pp + pm); ov[b] = pp + pm; S0 += ov[b]; S1 += ov[b] * tv[b];
        double Flab = log(pp / pm), Ffib = -log(Bf[(a * 8 + b) * 8 + vc] / lam[(a * 8 + b) * 8 + vc]); worstF = fmax(worstF, fabs(Flab - Ffib)); if (Ffib > Fmx) Fmx = Ffib; if (Ffib < Fmn) Fmn = Ffib; }
      double mean = S1 / S0; for (int b = 0; b < 8; b++) S2 += ov[b] * (tv[b] - mean) * (tv[b] - mean); double r = sqrt(S2 / S0) / sqrt(1 - t0 * t0); if (r > taua) taua = r; if (Fmx - Fmn > Da) Da = Fmx - Fmn; }
    for (int b = 0; b < 8; b++) { if (b > NEG[b]) continue; double S0 = 0, S1 = 0, S2 = 0, ma = pb[b], mm = pb[NEG[b]], t0 = (ma - mm) / (ma + mm), tv[8], ov[8], Fmx = -1e300, Fmn = 1e300;
      for (int a = 0; a < 8; a++) { double pp = P[a * 8 + b], pm = P[a * 8 + NEG[b]]; tv[a] = (pp - pm) / (pp + pm); ov[a] = pp + pm; S0 += ov[a]; S1 += ov[a] * tv[a];
        double Ffib = -log(Bh[(a * 8 + b) * 8 + vc] / lam[(a * 8 + b) * 8 + vc]); if (Ffib > Fmx) Fmx = Ffib; if (Ffib < Fmn) Fmn = Ffib; }
      double mean = S1 / S0; for (int a = 0; a < 8; a++) S2 += ov[a] * (tv[a] - mean) * (tv[a] - mean); double r = sqrt(S2 / S0) / sqrt(1 - t0 * t0); if (r > taub) taub = r; if (Fmx - Fmn > Db) Db = Fmx - Fmn; }
    double L31 = sqrt(rhot * rhot + taua * taua + taub * taub); worstL31 = fmax(worstL31, rho / L31); worst32 = fmax(worst32, fmax(taua / (2 * sinh(Da)), taub / (2 * sinh(Db)))); if (rho > 1e-9) minprice = fmin(minprice, L31 / rho);
    printf("M4R-T5 v_c = %d: rho = %.6f, V4-orbit channel rhot = %.6f, tau_a = %.6f, tau_b = %.6f -> Lemma 3.1 bound %.6f; Delta_a (from nu(B_f|v)) = %.4f, Delta_b = %.4f -> 2 sinh: %.4f %.4f\n", vc, rho, rhot, taua, taub, L31, Da, Db, 2 * sinh(Da), 2 * sinh(Db)); }
  printf("M4R-T5 summary: max over environments of |label free energy - (-log nu(B_f|v))| = %.2e; worst rho/(Lemma 3.1 bound) = %.6f; worst tau/(2 sinh Delta) = %.6f; min price %.4f\n", worstF, worstL31, worst32, minprice);
  return 0; }
