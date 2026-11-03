/* adversary.c -- REALIZABILITY OF THE FULLY ADVERSARIAL PAIR ENVIRONMENT IN THE FIBRE (the development MF, 2026-11-02).
 * e = the fine link from x = (1,1,1,1) in direction 1 (index 0).  For each staple link b of e (18 of them), the ten plaquettes through e or b other than
 * the one containing both: for the joint conditional law of (U_e, U_b) to be the pure kernel exp((beta/2) tr(U_e U_b C)), the five other staples of e
 * must be settable to sum zero and the five other staples of b likewise -- sufficient: each of the ten staples has a PRIVATE link (in that staple and in
 * no other of the ten, not e, not b) that is FREE: off every coarse path (a fine link from z in direction mu lies on a coarse path iff z_nu = 0 mod a_c
 * for every nu != mu) and not fixed by the gauge (axial gauge: every direction-4 link fixed, the worst case).  b itself must be free.
 * Prints, per a_c and per b, whether the pair is realizable, and the count of realizable b.  build: gcc -O2 -o adversary.exe adversary.c */
#include <stdio.h>
#include <string.h>
typedef struct { int x[4]; int d; } link_t;
static int AC;
static int eq(link_t a, link_t b) { return a.d == b.d && !memcmp(a.x, b.x, sizeof a.x); }
static int on_path(link_t l) { for (int nu = 0; nu < 4; nu++) { if (nu == l.d) continue; int z = ((l.x[nu] % AC) + AC) % AC; if (z != 0) return 0; } return 1; }
static int is_free(link_t l) { return !on_path(l) && l.d != 3; }
/* the four links of the plaquette at base x in plane (m, n), m < n */
static void plaq(const int *x, int m, int n, link_t *out) { link_t a = { {x[0], x[1], x[2], x[3]}, m }; out[0] = a;
  link_t b = a; b.x[m]++; b.d = n; out[1] = b; link_t c = a; c.x[n]++; c.d = m; out[2] = c; link_t dd = a; dd.d = n; out[3] = dd; }
/* the plaquettes containing link l: 6 of them; returns their four links */
static int plaqs_of(link_t l, link_t P[6][4]) { int np = 0; for (int k = 0; k < 4; k++) { if (k == l.d) continue; for (int s = 0; s < 2; s++) {
      int base[4]; memcpy(base, l.x, sizeof base); if (s) base[k]--; int m = l.d < k ? l.d : k, n = l.d < k ? k : l.d; plaq(base, m, n, P[np]); np++; } } return np; }
int main(void) {
  for (AC = 2; AC <= 4; AC++) {
    link_t e = { {1, 1, 1, 1}, 0 }; link_t Pe[6][4]; plaqs_of(e, Pe);
    int nreal = 0, nfree_b = 0;
    for (int pe = 0; pe < 6; pe++) for (int j = 0; j < 4; j++) { link_t b = Pe[pe][j]; if (eq(b, e)) continue;
      if (!is_free(b)) { printf("a_c=%d b=(%d%d%d%d;%d) NOT FREE\n", AC, b.x[0], b.x[1], b.x[2], b.x[3], b.d + 1); continue; }
      nfree_b++;
      link_t Pb[6][4]; plaqs_of(b, Pb);
      /* the ten staples: e's plaquettes except pe, b's plaquettes except the one containing e */
      link_t S[10][4]; int ns = 0; for (int q = 0; q < 6; q++) if (q != pe) { memcpy(S[ns], Pe[q], sizeof S[ns]); ns++; }
      for (int q = 0; q < 6; q++) { int hase = 0; for (int t = 0; t < 4; t++) if (eq(Pb[q][t], e)) hase = 1; if (!hase) { memcpy(S[ns], Pb[q], sizeof S[ns]); ns++; } }
      int ok = (ns == 10);
      for (int s = 0; s < ns && ok; s++) { int found = 0;
        for (int t = 0; t < 4 && !found; t++) { link_t l = S[s][t]; if (eq(l, e) || eq(l, b) || !is_free(l)) continue;
          int priv = 1; for (int s2 = 0; s2 < ns; s2++) { if (s2 == s) continue; for (int t2 = 0; t2 < 4; t2++) if (eq(S[s2][t2], l)) priv = 0; }
          if (priv) found = 1; }
        if (!found) ok = 0; }
      printf("a_c=%d b=(%d%d%d%d;dir %d) staples=%d realizable=%s\n", AC, b.x[0], b.x[1], b.x[2], b.x[3], b.d + 1, ns, ok ? "YES" : "NO");
      nreal += ok; }
    printf("SUMMARY a_c=%d free staple links of e = %d, fully adversarial pair realizable for %d of them\n", AC, nfree_b, nreal); }
  return 0; }
