/* g54_tube3d_dim.c -- THE EXACT SIZE OF THE 3+1 D TUBE: THE GAUGE-INVARIANT SPIN-NETWORK SPACE OF SU(2) ON THE 2x2x2 SPATIAL TORUS AT LINK
 * SPINS <= JMAX, BY CENTRE-FLUX SECTOR (PENTAPYLON G54, 2026-10-29 16:1x EDT, the author; the ticket pentapylon-g20's last open item,
 * "the 3+1 D 2x2x2 tube (3^24 states at spins <= 1: compiled only)", measured before it is built -- law 44: an out-of-reach verdict names its
 * experiment and its cost).
 * THE OBJECT.  Sites (x,y,z) in {0,1}^3, eight; links L_mu(x): x -> x + e_mu (mod 2), twenty-four, each site six-valent (out and in along each
 * axis).  A spin-network state is a link spin j_e in {0, 1/2, ..., JMAX} for every link and an intertwiner at every site in
 * Inv(V_{j1} (x) ... (x) V_{j6}); the dimension of the gauge-invariant space is sum over spin assignments of prod_sites dim Inv(j1..j6).
 * dim Inv of six SU(2) spins by fusion: the multiplicity of spin 0 in the tensor product, computed by fusing in sequence (the number of
 * paths through intermediate spins), exact in integers.  THE CENTRE FLUX: the Z_2^3 sector of a state is the parity of sum 2j over the links
 * crossing each of the three coordinate planes x = 1/2, y = 1/2, z = 1/2 (eight links each); the transfer matrix conserves it (Gauss's law
 * modulo the centre, the 2+1 tube's exact lumping), so the sector dimensions are what a Lanczos would face.
 * THE COUNT is a brute force over (2 JMAX + 1)^24 assignments with a vertex-parity cut (sum 2j even at every site, else dim Inv = 0): at
 * JMAX = 1, 3^24 = 2.8e11 assignments, pruned to the even ones by building link by link and refusing a site whose six spins are fixed with an
 * odd sum.  Output: G54-DIM JMAX=.. total=.. and G54-SECTOR flux=abc dim=.. ; G54-END with the node count.
 * usage: g54_tube3d_dim JMAX2 (twice the maximal spin: 1 for spins <= 1/2, 2 for spins <= 1)
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int J2MAX;
static int SRC[24], DST[24], AX[24];                 /* link e: source site, target site, axis */
static int SITELINKS[8][6], NSL[8];                   /* links at each site (six) */
static int j2[24];                                    /* twice the spin on each link */
static long long dimtab[5][5][5][5][5][5];            /* dim Inv for six spins (twice-spins 0..4), filled lazily: -1 = unknown */
static long long nodes = 0;
static long long total = 0, sector[8];

static long long dim_inv6(const int *s) {
  /* fuse: the number of ways to couple s[0..5] to total spin 0: dynamic over the intermediate twice-spin t */
  long long cur[16] = {0}, nxt[16]; cur[s[0]] = 1;
  for (int k = 1; k < 6; k++) { memset(nxt, 0, sizeof nxt);
    for (int t = 0; t < 16; t++) if (cur[t]) { int lo = abs(t - s[k]), hi = t + s[k]; for (int u = lo; u <= hi; u += 2) if (u < 16) nxt[u] += cur[t]; }
    memcpy(cur, nxt, sizeof cur); }
  return cur[0];
}
static long long dim_inv6_memo(int site) {
  int s[6]; for (int i = 0; i < 6; i++) s[i] = j2[SITELINKS[site][i]];
  long long *m = &dimtab[s[0]][s[1]][s[2]][s[3]][s[4]][s[5]]; if (*m < 0) *m = dim_inv6(s); return *m;
}
/* order the links so that each site's six links complete as early as possible: enumerate link by link; when the last link of a site is set,
   check the parity (and refuse if odd); at the end multiply the dims */
static int ORDER[24]; static int LASTSITE[24][2], NLAST[24];   /* sites completed by link ORDER[k] */
static void rec(int k, long long dimprod) {
  nodes++;
  if (k == 24) { int f = 0;
    for (int a = 0; a < 3; a++) { int par = 0; for (int e = 0; e < 24; e++) if (AX[e] == a && ((AX[e] == 0 ? SRC[e] & 1 : AX[e] == 1 ? (SRC[e] >> 1) & 1 : (SRC[e] >> 2) & 1) == 0)) par += j2[e];
      /* the links crossing the plane x_a = 1/2 are those along axis a from the site with coordinate a equal to 0 -- all four of them, plus the
         four from coordinate 1 (which wrap round through the plane at 3/2 = -1/2 as well).  On the 2-torus every link along axis a crosses
         the cut once; the parity of the sum over the eight links along axis a is the centre flux through the plane. */
      par = 0; for (int e = 0; e < 24; e++) if (AX[e] == a && (((SRC[e] >> a) & 1) == 0)) par += j2[e]; if (par & 1) f |= (1 << a); }   /* the four links crossing x_a = 1/2 (16:2x: all eight counts every winding loop twice and read every sector empty) */
    total += dimprod; sector[f] += dimprod; return; }
  int e = ORDER[k];
  for (int s = 0; s <= J2MAX; s++) { j2[e] = s; long long dp = dimprod; int ok = 1;
    for (int q = 0; q < NLAST[k]; q++) { int site = LASTSITE[k][q]; int sum = 0; for (int i = 0; i < 6; i++) sum += j2[SITELINKS[site][i]];
      if (sum & 1) { ok = 0; break; } long long d = dim_inv6_memo(site); if (d == 0) { ok = 0; break; } dp *= d; }
    if (ok) rec(k + 1, dp); }
  j2[e] = 0;
}
int main(int argc, char **argv) {
  if (argc < 2) { fprintf(stderr, "usage: g54_tube3d_dim JMAX2\n"); return 2; }
  J2MAX = atoi(argv[1]); if (J2MAX < 1 || J2MAX > 4) { fprintf(stderr, "JMAX2 in 1..4\n"); return 2; }
  memset(dimtab, -1, sizeof dimtab); memset(sector, 0, sizeof sector);
  int ne = 0; for (int site = 0; site < 8; site++) for (int a = 0; a < 3; a++) { int t = site ^ (1 << a); SRC[ne] = site; DST[ne] = t; AX[ne] = a; ne++; }
  for (int s = 0; s < 8; s++) NSL[s] = 0;
  for (int e = 0; e < 24; e++) { SITELINKS[SRC[e]][NSL[SRC[e]]++] = e; SITELINKS[DST[e]][NSL[DST[e]]++] = e; }
  for (int s = 0; s < 8; s++) if (NSL[s] != 6) { fprintf(stderr, "site %d has %d links\n", s, NSL[s]); return 3; }
  /* order: site by site, so that sites complete early */
  int used[24] = {0}, k = 0; for (int s = 0; s < 8; s++) for (int i = 0; i < 6; i++) { int e = SITELINKS[s][i]; if (!used[e]) { used[e] = 1; ORDER[k++] = e; } }
  int seen[24] = {0}; for (int kk = 0; kk < 24; kk++) { NLAST[kk] = 0; seen[ORDER[kk]] = 1;
    for (int s = 0; s < 8; s++) { int all = 1, has = 0; for (int i = 0; i < 6; i++) { if (!seen[SITELINKS[s][i]]) all = 0; if (SITELINKS[s][i] == ORDER[kk]) has = 1; } if (all && has) LASTSITE[kk][NLAST[kk]++] = s; } }
  printf("G54 the 2x2x2 spatial torus: 8 sites, 24 links, spins <= %g (twice-spins 0..%d); the gauge-invariant spin-network dimension by sector of the Z2^3 centre flux\n", J2MAX / 2.0, J2MAX);
  rec(0, 1);
  printf("G54-DIM JMAX=%g total=%lld (nodes %lld)\n", J2MAX / 2.0, total, nodes);
  for (int f = 0; f < 8; f++) printf("G54-SECTOR JMAX=%g flux=%d%d%d dim=%lld\n", J2MAX / 2.0, f & 1, (f >> 1) & 1, (f >> 2) & 1, sector[f]);
  printf("G54-END\n"); return 0;
}
