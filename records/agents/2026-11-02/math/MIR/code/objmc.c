/* objmc.c -- THE CONVENTION CONTROL (advisor item 1, 2026-11-02): the 536 outside links of the planar n = 4 two-step object set from a datum
 * file (others identity -- irrelevant: every plaquette through an object link lies in object U outside), and ONLY the 76 object links
 * heat-bathed at beta with the FULL Wilson weight. <1/2 tr A>, <1/2 tr B> over the sweeps estimate E[chi_1/2(A)]/2 = a'_1/2 at that datum,
 * which the exact engine computes at a truncated weight. A convention flip (links fed inverted) would not reproduce the engine.
 * usage: objmc BETA SEED NSWEEP OUTLIST DATUM      build: gcc -O2 -o objmc.exe objmc.c -lm */
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
    quat f = qmul(qmul(U[sm][nu], qinv(U[sn][mu])), qinv(U[s][nu])); quat b = qmul(qmul(qinv(U[smd][nu]), qinv(U[sd][mu])), U[sd][nu]);
    S.w += f.w + b.w; S.x += f.x + b.x; S.y += f.y + b.y; S.z += f.z + b.z; } return S; }
static quat randdir(double a0) { double r = sqrt(fmax(0, 1 - a0 * a0)), ct = 2 * rnd() - 1, st = sqrt(fmax(0, 1 - ct * ct)), ph = 2 * M_PI * rnd(); quat q = { a0, r * st * cos(ph), r * st * sin(ph), r * ct }; return q; }
static void hb(double beta, int s, int mu) { quat S = stsum(s, mu); double k = sqrt(S.w*S.w + S.x*S.x + S.y*S.y + S.z*S.z); if (k < 1e-12) { U[s][mu] = randdir(2 * rnd() - 1); return; }
  quat v = { S.w / k, S.x / k, S.y / k, S.z / k }; double al = beta * k, a0;
  for (;;) { double r1 = rnd(), r2 = rnd(), r3 = rnd(), r4 = rnd(); double c = cos(2 * M_PI * r2); double X = -(log(r1) + c * c * log(r3)) / al; if (r4 * r4 <= 1 - X / 2) { a0 = 1 - X; break; } }
  U[s][mu] = qmul(randdir(a0), qinv(v)); }
static int O[4] = { 6, 6, 6, 6 };
static int at(int x, int y) { int c[4] = { O[0] + x, O[1] + y, O[2], O[3] }; return site(c); }
static double loopA(int x0, int x1) { quat T = {1, 0, 0, 0}; for (int i = x0; i < x1; i++) T = qmul(T, U[at(i, 0)][0]); for (int j = 0; j < 4; j++) T = qmul(T, U[at(x1, j)][1]);
  for (int i = x1 - 1; i >= x0; i--) T = qmul(T, qinv(U[at(i, 4)][0])); for (int j = 3; j >= 0; j--) T = qmul(T, qinv(U[at(x0, j)][1])); return T.w; }
int main(int argc, char **argv) {
  if (argc < 6) { fprintf(stderr, "usage: objmc BETA SEED NSWEEP OUTLIST DATUM\n"); return 1; }
  double beta = atof(argv[1]); rs = strtoull(argv[2], 0, 10) * 0x2545F4914F6CDD1DULL + 3; long ns = atol(argv[3]);
  for (int s = 0; s < V; s++) for (int mu = 0; mu < 4; mu++) { quat q = {1, 0, 0, 0}; U[s][mu] = q; }
  static int OC[1024][4], OD[1024], OI[1024]; int nout = 0; char tag[32]; FILE *fl = fopen(argv[4], "r"); if (!fl) return 1;
  while (fscanf(fl, "%31s %d %d %d %d %d %d", tag, &OI[nout], &OC[nout][0], &OC[nout][1], &OC[nout][2], &OC[nout][3], &OD[nout]) == 7) nout++; fclose(fl);
  static int pos[1024]; for (int i = 0; i < nout; i++) pos[OI[i]] = i;
  FILE *fd = fopen(argv[5], "r"); if (!fd) return 1; int idx, nread = 0; double w, x, y, z;
  while (fscanf(fd, "%d %lf %lf %lf %lf", &idx, &w, &x, &y, &z) == 5) { int i = pos[idx]; int c[4]; for (int j = 0; j < 4; j++) c[j] = O[j] + OC[i][j]; quat q = { w, x, y, z }; U[site(c)][OD[i] - 1] = q; nread++; } fclose(fd);
  /* the 76 object links: x-links at (i, j), i = -4..3, j = 0..4; y-links at (i, j), i = -4..4, j = 0..3 */
  int OS[128], OM[128], no = 0; for (int i = -4; i <= 3; i++) for (int j = 0; j <= 4; j++) { OS[no] = at(i, j); OM[no++] = 0; }
  for (int i = -4; i <= 4; i++) for (int j = 0; j <= 3; j++) { OS[no] = at(i, j); OM[no++] = 1; }
  printf("OBJMC beta=%g datum=%s outside read=%d object links=%d sweeps=%ld\n", beta, argv[5], nread, no, ns);
  double sa = 0, sb = 0, saa = 0, sbb = 0, sab = 0; long nm = 0; int nb = 20; double ba[20] = {0}, bb[20] = {0}; long per = ns / nb;
  for (long it = 0; it < ns + 2000; it++) { for (int k = 0; k < no; k++) hb(beta, OS[k], OM[k]);
    if (it >= 2000) { double a = loopA(0, 4), b = loopA(-4, 0); sa += a; sb += b; saa += a * a; sbb += b * b; sab += a * b; long m = (it - 2000) / per; if (m < nb) { ba[m] += a; bb[m] += b; } nm++; } }
  double ma = sa / nm, mb = sb / nm; double va = 0, vb = 0; for (int m = 0; m < nb; m++) { double da = ba[m] / per - ma, db = bb[m] / per - mb; va += da * da; vb += db * db; }
  printf("OBJMC <1/2 tr A> = %.5f +- %.5f   <1/2 tr B> = %.5f +- %.5f   cov(A,B)/4-ish <a b>-<a><b> = %.6f\n", ma, sqrt(va / (nb * (nb - 1))), mb, sqrt(vb / (nb * (nb - 1))), sab / nm - ma * mb);
  return 0; }
