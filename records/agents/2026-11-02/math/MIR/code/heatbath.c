/* heatbath.c -- SU(2) Wilson heat bath (Kennedy-Pendleton) + overrelaxation on the periodic 12^4 lattice, links as unit quaternions
 * U(x, x+e_mu) with the Hamilton product -- the convention of w2_strip_n.c (staple(): U_l * U(x+mu,nu) U(x+nu,mu)^-1 U(x,nu)^-1).
 * PURPOSE: to choose TYPICAL outside data for the exact two-step object (MIR, 2026-11-02). A reading at a sampled datum is exact at that
 * datum; the sampling only chooses the datum. No number from this program enters a proof.
 * usage: heatbath BETA SEED NTHERM NSEP NSAMP OUTLIST PREFIX   -> PREFIX_k.txt (one "<index> w x y z" line per outside link), and on stdout
 * the plaquette average of every sample and, per sample, the 4x4 and 2x2 Wilson-loop class angles' statistics (a reading).
 * build: gcc -O2 -o heatbath.exe heatbath.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#define LS 12
#define V (LS*LS*LS*LS)
typedef struct { double w, x, y, z; } quat;
static quat U[V][4];
static unsigned long long rs;
static double rnd(void) { rs += 0x9E3779B97F4A7C15ULL; unsigned long long z = rs; z = (z ^ (z >> 30)) * 0xBF58476D1CE4E5B9ULL; z = (z ^ (z >> 27)) * 0x94D049BB133111EBULL; z ^= z >> 31; return ((z >> 11) + 0.5) * (1.0 / 9007199254740992.0); }
static quat qmul(quat a, quat b) { quat r; r.w = a.w*b.w - a.x*b.x - a.y*b.y - a.z*b.z; r.x = a.w*b.x + a.x*b.w + a.y*b.z - a.z*b.y; r.y = a.w*b.y - a.x*b.z + a.y*b.w + a.z*b.x; r.z = a.w*b.z + a.x*b.y - a.y*b.x + a.z*b.w; return r; }
static quat qinv(quat a) { quat r = { a.w, -a.x, -a.y, -a.z }; return r; }
static int site(int c[4]) { return ((((c[0] % LS + LS) % LS) * LS + (c[1] % LS + LS) % LS) * LS + (c[2] % LS + LS) % LS) * LS + (c[3] % LS + LS) % LS; }
static void coords(int s, int c[4]) { c[3] = s % LS; s /= LS; c[2] = s % LS; s /= LS; c[1] = s % LS; s /= LS; c[0] = s; }
static int up(int s, int mu) { int c[4]; coords(s, c); c[mu]++; return site(c); }
static int dn(int s, int mu) { int c[4]; coords(s, c); c[mu]--; return site(c); }
static quat stsum(int s, int mu) { quat S = {0, 0, 0, 0};
  for (int nu = 0; nu < 4; nu++) { if (nu == mu) continue; int sm = up(s, mu), sn = up(s, nu), sd = dn(s, nu), smd = dn(sm, nu);
    quat f = qmul(qmul(U[sm][nu], qinv(U[sn][mu])), qinv(U[s][nu]));
    quat b = qmul(qmul(qinv(U[smd][nu]), qinv(U[sd][mu])), U[sd][nu]);
    S.w += f.w + b.w; S.x += f.x + b.x; S.y += f.y + b.y; S.z += f.z + b.z; }
  return S; }
static quat randdir(double a0) { double r = sqrt(fmax(0, 1 - a0 * a0)), ct = 2 * rnd() - 1, st = sqrt(fmax(0, 1 - ct * ct)), ph = 2 * M_PI * rnd(); quat q = { a0, r * st * cos(ph), r * st * sin(ph), r * ct }; return q; }
static void hb(double beta, int s, int mu) { quat S = stsum(s, mu); double k = sqrt(S.w*S.w + S.x*S.x + S.y*S.y + S.z*S.z); if (k < 1e-12) { U[s][mu] = randdir(2 * rnd() - 1); return; }
  quat v = { S.w / k, S.x / k, S.y / k, S.z / k }; double al = beta * k, a0;
  for (;;) { double r1 = rnd(), r2 = rnd(), r3 = rnd(), r4 = rnd(); double c = cos(2 * M_PI * r2); double X = -(log(r1) + c * c * log(r3)) / al; if (r4 * r4 <= 1 - X / 2) { a0 = 1 - X; break; } }
  /* W = U v has density exp(al W.w) on S^3; U = W v^-1 */
  U[s][mu] = qmul(randdir(a0), qinv(v)); }
static void orx(int s, int mu) { quat S = stsum(s, mu); double k = sqrt(S.w*S.w + S.x*S.x + S.y*S.y + S.z*S.z); if (k < 1e-12) return; quat v = { S.w / k, S.x / k, S.y / k, S.z / k };
  U[s][mu] = qmul(qmul(qinv(v), qinv(U[s][mu])), qinv(v)); }
static double plaq(void) { double t = 0; for (int s = 0; s < V; s++) for (int mu = 0; mu < 4; mu++) for (int nu = mu + 1; nu < 4; nu++) { int sm = up(s, mu), sn = up(s, nu);
  t += qmul(qmul(qmul(U[s][mu], U[sm][nu]), qinv(U[sn][mu])), qinv(U[s][nu])).w; } return t / (6.0 * V); }
static double loopw(int s, int mu, int nu, int R) { quat T = {1, 0, 0, 0}; int c = s;
  for (int i = 0; i < R; i++) { T = qmul(T, U[c][mu]); c = up(c, mu); } for (int i = 0; i < R; i++) { T = qmul(T, U[c][nu]); c = up(c, nu); }
  for (int i = 0; i < R; i++) { c = dn(c, mu); T = qmul(T, qinv(U[c][mu])); } for (int i = 0; i < R; i++) { c = dn(c, nu); T = qmul(T, qinv(U[c][nu])); } return T.w; }
int main(int argc, char **argv) {
  if (argc < 8) { fprintf(stderr, "usage: heatbath BETA SEED NTHERM NSEP NSAMP OUTLIST PREFIX\n"); return 1; }
  double beta = atof(argv[1]); rs = strtoull(argv[2], 0, 10) * 0x2545F4914F6CDD1DULL + 7; int nth = atoi(argv[3]), nsep = atoi(argv[4]), ns = atoi(argv[5]);
  for (int s = 0; s < V; s++) for (int mu = 0; mu < 4; mu++) { quat q = {1, 0, 0, 0}; U[s][mu] = q; }
  int nout = 0, OI[1024], OC[1024][4], ODd[1024]; FILE *fl = fopen(argv[6], "r"); char tag[32]; if (!fl) { fprintf(stderr, "no outlist\n"); return 1; }
  while (fscanf(fl, "%31s %d %d %d %d %d %d", tag, &OI[nout], &OC[nout][0], &OC[nout][1], &OC[nout][2], &OC[nout][3], &ODd[nout]) == 7) nout++; fclose(fl);
  printf("HB beta=%g L=%d outside links read=%d\n", beta, LS, nout);
  for (int it = 0; it < nth + nsep * ns; it++) {
    for (int s = 0; s < V; s++) for (int mu = 0; mu < 4; mu++) hb(beta, s, mu);
    for (int r = 0; r < 3; r++) for (int s = 0; s < V; s++) for (int mu = 0; mu < 4; mu++) orx(s, mu);
    if (it % 20 == 0) printf("HB sweep %d plaquette %.6f\n", it, plaq());
    if (it >= nth && (it - nth) % nsep == nsep - 1) { int k = (it - nth) / nsep; char fn[512]; snprintf(fn, sizeof fn, "%s_%d.txt", argv[7], k); FILE *fo = fopen(fn, "w");
      int c[4] = { 6, 6, 6, 6 }; int base = site(c); /* the object's origin at (6,6,6,6) */
      for (int i = 0; i < nout; i++) { int cc[4]; coords(base, cc); for (int j = 0; j < 4; j++) cc[j] += OC[i][j]; quat q = U[site(cc)][ODd[i] - 1]; fprintf(fo, "%d %.17g %.17g %.17g %.17g\n", OI[i], q.w, q.x, q.y, q.z); }
      fclose(fo);
      double h1[4] = {0}, h2[4] = {0}; long n1 = 0, n2 = 0; double sw4 = 0, sw2 = 0;
      for (int s = 0; s < V; s++) for (int mu = 0; mu < 4; mu++) for (int nu = mu + 1; nu < 4; nu++) { double w4 = loopw(s, mu, nu, 4), w2 = loopw(s, mu, nu, 2); sw4 += w4; sw2 += w2; n1++;
        double cuts[4] = { cos(M_PI / 6), cos(M_PI / 4), cos(M_PI / 3), 0.5 * 0 }; for (int t = 0; t < 3; t++) { if (fabs(w4) >= cuts[t]) h1[t]++; if (fabs(w2) >= cuts[t]) h2[t]++; } }
      n2 = n1; printf("HB sample %d (sweep %d) plaquette %.6f  <W2x2>=%.5f <W4x4>=%.5f  P(|W4x4|>=cos30,45,60)= %.5f %.5f %.5f  P(|W2x2|>=...)= %.5f %.5f %.5f  -> %s\n",
        k, it, plaq(), sw2 / n2, sw4 / n1, h1[0] / n1, h1[1] / n1, h1[2] / n1, h2[0] / n2, h2[1] / n2, h2[2] / n2, fn); fflush(stdout); }
  }
  return 0; }
