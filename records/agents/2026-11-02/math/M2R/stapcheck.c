/* stapcheck.c -- the second reader's replica of w2_strip_n.c's object and staple construction (lines 61-107 of the engine, copied
 * verbatim in logic: lkey, okey, is_obj_plaq, add_plaq, the face loops of build(), the staple loop), with one added census: for every
 * staple of every object link, is any of its three "outside" links (registered through okey) in fact an OBJECT link (present in the
 * lkey table)?  Prints each such staple with its plaquette, and the per-geometry totals.  Usage: stapcheck n bent|planar */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAXL 128
#define MAXOUT 2000
#define MAXCYC 40
static int NN = 2, PLANAR = 0, NL = 0, NOUT = 0, NP;
static int LB[MAXL][4], LD[MAXL], OB[MAXOUT][4], OD[MAXOUT];
static int PB[MAXCYC][4], PD1[MAXCYC], PD2[MAXCYC];
static int NSTAP[MAXL]; static int STAP[MAXL][6][3][2]; static int SPB[MAXL][6][4], SPD1[MAXL][6], SPD2[MAXL][6];
static int lkey(const int *b, int d, int create) { for (int i = 0; i < NL; i++) if (LD[i] == d && !memcmp(LB[i], b, sizeof(int) * 4)) return i; if (!create) return -1; memcpy(LB[NL], b, sizeof(int) * 4); LD[NL] = d; return NL++; }
static int okey(const int *b, int d) { for (int i = 0; i < NOUT; i++) if (OD[i] == d && !memcmp(OB[i], b, sizeof(int) * 4)) return i; memcpy(OB[NOUT], b, sizeof(int) * 4); OD[NOUT] = d; return NOUT++; }
static int is_obj_plaq(const int *b, int d1, int d2) { for (int p = 0; p < NP; p++) if (PD1[p] == d1 && PD2[p] == d2 && !memcmp(PB[p], b, sizeof(int) * 4)) return 1; return 0; }
static void add_plaq(int p, int x, int y, int z, int d1, int d2) { int b[4] = { x, y, z, 0 }; memcpy(PB[p], b, sizeof b); PD1[p] = d1; PD2[p] = d2; int q[4];
  lkey(b, d1, 1); memcpy(q, b, sizeof q); q[d1 - 1]++; lkey(q, d2, 1); memcpy(q, b, sizeof q); q[d2 - 1]++; lkey(q, d1, 1); lkey(b, d2, 1); }
int main(int argc, char **argv) {
  if (argc > 1) NN = atoi(argv[1]); PLANAR = (argc > 2 && !strcmp(argv[2], "planar")); int n = NN; NP = 2 * n * n;
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) add_plaq(j + n * i, i, j, 0, 1, 2);
  for (int k = 0; k < n; k++) for (int j = 0; j < n; j++) { if (PLANAR) add_plaq(n * n + j + n * k, -1 - k, j, 0, 1, 2); else add_plaq(n * n + j + n * k, 0, j, k, 2, 3); }
  printf("geometry %s n=%d: object plaquettes %d, object links %d (engine's check value %d)\n", PLANAR ? "planar" : "bent", n, NP, NL, 2 * n * (n + 1) * 2 - n);
  int nbad = 0; int plaqseen[400][6]; int nps = 0;
  for (int l = 0; l < NL; l++) { int *p = LB[l], d = LD[l]; int pd[4]; memcpy(pd, p, sizeof pd); pd[d - 1]++; NSTAP[l] = 0;
    for (int k = 1; k <= 4; k++) { if (k == d) continue;
      for (int si = 0; si < 2; si++) { int s = si ? -1 : 1; int base[4]; memcpy(base, p, sizeof base); if (s < 0) base[k - 1]--;
        int d1 = d < k ? d : k, d2 = d < k ? k : d; if (is_obj_plaq(base, d1, d2)) continue;
        int ns = NSTAP[l]; int q[4]; int links[3][4], ldir[3];
        if (s > 0) { STAP[l][ns][0][0] = okey(pd, k); memcpy(links[0], pd, sizeof q); ldir[0] = k; } else { memcpy(q, pd, sizeof q); q[k - 1] -= 1; STAP[l][ns][0][0] = okey(q, k); memcpy(links[0], q, sizeof q); ldir[0] = k; }
        memcpy(q, p, sizeof q); q[k - 1] += s; STAP[l][ns][1][0] = okey(q, d); memcpy(links[1], q, sizeof q); ldir[1] = d;
        if (s > 0) { STAP[l][ns][2][0] = okey(p, k); memcpy(links[2], p, sizeof q); ldir[2] = k; } else { memcpy(q, p, sizeof q); q[k - 1] -= 1; STAP[l][ns][2][0] = okey(q, k); memcpy(links[2], q, sizeof q); ldir[2] = k; }
        for (int t = 0; t < 3; t++) { int lo = lkey(links[t], ldir[t], 0);
          if (lo >= 0) { nbad++; printf("  OBJECT LINK READ AS OUTSIDE: staple of object link %d (%d,%d,%d,%d dir %d) in plaquette base (%d,%d,%d,%d) plane (%d,%d): its link (%d,%d,%d,%d dir %d) is object link %d, outside index %d\n",
              l, p[0], p[1], p[2], p[3], d, base[0], base[1], base[2], base[3], d1, d2, links[t][0], links[t][1], links[t][2], links[t][3], ldir[t], lo, STAP[l][ns][t][0]);
            int f = -1; for (int u = 0; u < nps; u++) if (!memcmp(plaqseen[u], base, sizeof(int) * 4) && plaqseen[u][4] == d1 && plaqseen[u][5] == d2) f = u;
            if (f < 0) { memcpy(plaqseen[nps], base, sizeof(int) * 4); plaqseen[nps][4] = d1; plaqseen[nps][5] = d2; nps++; } } }
        NSTAP[l]++; } } }
  int n5 = 0, n4 = 0, nother = 0; for (int l = 0; l < NL; l++) { if (NSTAP[l] == 5) n5++; else if (NSTAP[l] == 4) n4++; else nother++; }
  printf("TOTAL %s n=%d: %d staples hold an object link read from the datum, over %d distinct non-object plaquettes; staples five=%d four=%d other=%d; outside links %d\n",
    PLANAR ? "planar" : "bent", n, nbad, nps, n5, n4, nother, NOUT);
  for (int u = 0; u < nps; u++) printf("  plaquette base (%d,%d,%d,%d) plane (%d,%d)\n", plaqseen[u][0], plaqseen[u][1], plaqseen[u][2], plaqseen[u][3], plaqseen[u][4], plaqseen[u][5]);
  return 0; }
