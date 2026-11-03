/* flux_table.c -- THE FLUX TABLE OF A STRIP CELL'S DATUM (the author, 2026-11-03 00:4x EST; staked first in the author's
   STAKE.md, carried into the campaign page with the reading).  The structural lemma's first measurement, the reading the author (the author,
   §31.17) asked for: WHAT OF THE DATUM the cell's transfer gap depends on.  Shares no line with cei_face.c.

   THE OBJECT.  The K = 3 strip of planar W2 cells: twelve plaquettes at corners x = -4..1, y = 0..1 in the (1,2) plane, 32 object links
   (18 in direction 1 at y = 0..2, 14 in direction 2 at x = -4..2), 248 outside links -- the datum, read from the engine's own listing
   (CEI_LISTOUT=1: "CEI-OUT x y z t d w x y z", one unit quaternion per outside link, under the author's invocation).  Each datum plaquette
   holds exactly one object link, so the outside action is linear in every link: Sum_l <U_l, V_l>, and the gauge-invariant content of the
   datum is the 32 magnitudes |V_l| with the holonomies of the preferred values V_l/|V_l| around the twelve object plaquettes.

   THE FIBRE (CEI_SUBST=1): the coarse edges are fixed at the identity -- per cell the bottom pair (a,0)d1.(a+1,0)d1, the top pair
   (a,2)d1.(a+1,2)d1 and the right column (a+2,0)d2.(a+2,1)d2, and the strip's left column (-4,0)d2.(-4,1)d2 -- so ten links are the
   inverses of their partners and 22 survive (the survivor of each pair the one the author's pinning scan names for the cell x = -4, -3:
   (-4,0)d1, (-3,2)d1, (-2,1)d2; the other cells by translation; the left column's survivor (-4,1)d2 by the same rule).  A survivor's
   EFFECTIVE field is its own staple sum plus the conjugate of its partner's (the partner's term <U^-1, V_p> = <U, conj V_p>), whose norm
   is the author's pinning number (2n at the identity datum for a paired link, n for a free one).

   THE READINGS, per datum: the effective pins; the preferred fibre configuration and its twelve plaquette traces f_p; the Wilson energy
   of the strip at fixed datum minimised over the 22 survivors from the preferred start and from 64 random starts (a census of minima);
   the plaquette traces at the best minimum; the Hessian there (66 x 66 by central differences in the left Lie algebra, Jacobi) whole and
   on the cell's seven survivors (21 x 21).  No staple convention is written by hand: every staple sum is read off the Wilson action by
   evaluating the plaquette traces at the four basis quaternions.  Quaternions Hamilton's; the link from s to s + mu; the plaquette
   U1 U2 U3^-1 U4^-1 with U1 = (s,mu), U2 = (s+mu,nu), U3 = (s+nu,mu), U4 = (s,nu); the trace 2w.

   USAGE: flux_table <listing> <name>        -> FLUX-* lines (grep-able; one FLUX-SUMMARY line per datum).
   REFUSALS: a datum plaquette whose outside link is not in the listing (DATUM-MISSING), a listing of the wrong length (DATUM-COUNT). */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

typedef struct { double w, x, y, z; } Q;
static Q qmul(Q a, Q b) { Q r; r.w = a.w*b.w - a.x*b.x - a.y*b.y - a.z*b.z; r.x = a.w*b.x + a.x*b.w + a.y*b.z - a.z*b.y;
  r.y = a.w*b.y - a.x*b.z + a.y*b.w + a.z*b.x; r.z = a.w*b.z + a.x*b.y - a.y*b.x + a.z*b.w; return r; }
static Q qconj(Q a) { Q r = { a.w, -a.x, -a.y, -a.z }; return r; }
static double qnorm(Q a) { return sqrt(a.w*a.w + a.x*a.x + a.y*a.y + a.z*a.z); }
static Q qscale(Q a, double s) { Q r = { a.w*s, a.x*s, a.y*s, a.z*s }; return r; }
static Q qadd(Q a, Q b) { Q r = { a.w+b.w, a.x+b.x, a.y+b.y, a.z+b.z }; return r; }
static const Q QONE = { 1, 0, 0, 0 };

#define OFF 8
#define DIM 16
static Q DAT[DIM][DIM][DIM][DIM][4]; static char DATP[DIM][DIM][DIM][DIM][4];
static int NDAT = 0;

/* the object links */
#define NL 32
static int LS[NL][4], LD[NL]; static Q OBJ[NL];
static int lidx(const int *s, int d) { for (int l = 0; l < NL; l++) if (LD[l] == d && !memcmp(LS[l], s, 4 * sizeof(int))) return l; return -1; }
/* the plaquettes touching the object: corner, (mu < nu), kind 1 = object plaquette (all four links object), 0 = datum plaquette */
#define NPMAX 256
static int PS[NPMAX][4], PM[NPMAX], PN[NPMAX], PK[NPMAX], NP = 0;
static int pidx(const int *s, int m, int n) { for (int p = 0; p < NP; p++) if (PM[p] == m && PN[p] == n && !memcmp(PS[p], s, 4 * sizeof(int))) return p; return -1; }
/* the fibre: partner[l] = the index of the link tied to l (-1 if free); SURV[l] = 1 if l is a survivor */
static int PARTNER[NL], SURV[NL], SURVL[NL], NSURV = 0;
/* the cell's seven survivors, in the author's order */
static const int CELLS[7][3] = { {-2,1,2}, {-3,1,1}, {-3,2,1}, {-3,0,2}, {-3,1,2}, {-4,0,1}, {-4,1,1} };
static int CELLI[7];
static double PSMIN = 0, PSMEAN = 0;   /* the author's pin-sum over the cell, for the summary */
static int instrip(const int *c) { return c[2] == 0 && c[3] == 0 && c[0] >= -4 && c[0] <= 1 && c[1] >= 0 && c[1] <= 1; }

static int missing = 0; static int MISS[4]; static int MISSD;
static Q linkval(const int *s, int d) { int l = lidx(s, d); if (l >= 0) return OBJ[l];
  int a = s[0]+OFF, b = s[1]+OFF, c = s[2]+OFF, e = s[3]+OFF;
  if (a < 0 || a >= DIM || b < 0 || b >= DIM || c < 0 || c >= DIM || e < 0 || e >= DIM || !DATP[a][b][c][e][d-1]) { missing++; memcpy(MISS, s, sizeof MISS); MISSD = d; return QONE; }
  return DAT[a][b][c][e][d-1]; }
/* the plaquette holonomy at corner s in the plane (m, n): U1 U2 U3^-1 U4^-1 */
static Q plaq(const int *s, int m, int n) { int s2[4], s3[4]; memcpy(s2, s, sizeof s2); s2[m-1]++; memcpy(s3, s, sizeof s3); s3[n-1]++;
  Q u1 = linkval(s, m), u2 = linkval(s2, n), u3 = linkval(s3, m), u4 = linkval(s, n); return qmul(qmul(u1, u2), qmul(qconj(u3), qconj(u4))); }
static double ptrace(int p) { return plaq(PS[p], PM[p], PN[p]).w; }

/* the energy of the configuration: minus the sum of the plaquette traces over every plaquette touching the object */
static double energy(void) { double e = 0; for (int p = 0; p < NP; p++) e -= ptrace(p); return e; }
/* the fibre: set the eliminated links to the inverses of their partners */
static void tie(void) { for (int l = 0; l < NL; l++) if (!SURV[l] && PARTNER[l] >= 0) OBJ[l] = qconj(OBJ[PARTNER[l]]); }

/* the linear coefficient of the plaquette sum over a set of plaquettes in the value of link l (its partner tied): the four basis evaluations */
static int LP[NL][16], NLP[NL];   /* the plaquettes containing l or its partner */
static int LPO[NL][16], NLPO[NL]; /* the plaquettes containing l itself */
static Q local_field(int l, int datum_only) { Q f = { 0, 0, 0, 0 }; Q basis[4] = { {1,0,0,0}, {0,1,0,0}, {0,0,1,0}, {0,0,0,1} }; double c[4];
  Q save = OBJ[l], savep = QONE; int pr = PARTNER[l]; if (pr >= 0) savep = OBJ[pr];
  for (int b = 0; b < 4; b++) { OBJ[l] = basis[b]; if (pr >= 0 && !datum_only) OBJ[pr] = qconj(basis[b]); double s = 0;
    if (datum_only) { for (int k = 0; k < NLPO[l]; k++) { int p = LPO[l][k]; if (PK[p]) continue; s += ptrace(p); } } else { for (int k = 0; k < NLP[l]; k++) s += ptrace(LP[l][k]); } c[b] = s; }
  OBJ[l] = save; if (pr >= 0) OBJ[pr] = savep; f.w = c[0]; f.x = c[1]; f.y = c[2]; f.z = c[3]; return f; }

/* a deterministic generator (a 64-bit LCG) and a uniform unit quaternion by rejection from the 4-cube */
static unsigned long long RNG = 88172645463325252ULL;
static double urand(void) { RNG = RNG * 6364136223846793005ULL + 1442695040888963407ULL; return ((RNG >> 11) * (1.0 / 9007199254740992.0)); }
static Q qrand(void) { for (;;) { Q q = { 2*urand()-1, 2*urand()-1, 2*urand()-1, 2*urand()-1 }; double n = qnorm(q); if (n <= 1 && n > 1e-6) return qscale(q, 1/n); } }

/* relax the survivors by local maximisation (zero-temperature heat bath on the fibre); returns the energy and the sweep count */
static double relax(int *sweeps) { double last = energy(); int sw;
  for (sw = 0; sw < 2000; sw++) { double mx = 0;
    for (int i = 0; i < NSURV; i++) { int l = SURVL[i]; Q f = local_field(l, 0); double n = qnorm(f); if (n < 1e-14) continue; Q u = qscale(f, 1/n);
      double d = qnorm(qadd(u, qscale(OBJ[l], -1))); if (d > mx) mx = d; OBJ[l] = u; if (PARTNER[l] >= 0) OBJ[PARTNER[l]] = qconj(u); }
    double e = energy(); if (mx < 1e-13 || fabs(e - last) < 1e-15) { last = e; break; } last = e; }
  *sweeps = sw; return last; }

/* Jacobi eigenvalues of a symmetric n x n matrix (n <= 96), ascending */
static void jacobi(double *A, int n, double *ev) { double *a = A;
  for (int it = 0; it < 100; it++) { double off = 0; for (int i = 0; i < n; i++) for (int j = i+1; j < n; j++) off += a[i*n+j]*a[i*n+j]; if (off < 1e-26) break;
    for (int p = 0; p < n; p++) for (int q = p+1; q < n; q++) { double apq = a[p*n+q]; if (fabs(apq) < 1e-300) continue;
      double th = (a[q*n+q] - a[p*n+p]) / (2*apq); double t = (th >= 0 ? 1 : -1) / (fabs(th) + sqrt(th*th + 1)); double c = 1/sqrt(t*t+1), s = t*c;
      for (int k = 0; k < n; k++) { double akp = a[k*n+p], akq = a[k*n+q]; a[k*n+p] = c*akp - s*akq; a[k*n+q] = s*akp + c*akq; }
      for (int k = 0; k < n; k++) { double apk = a[p*n+k], aqk = a[q*n+k]; a[p*n+k] = c*apk - s*aqk; a[q*n+k] = s*apk + c*aqk; } } }
  for (int i = 0; i < n; i++) ev[i] = a[i*n+i];
  for (int i = 0; i < n; i++) for (int j = i+1; j < n; j++) if (ev[j] < ev[i]) { double t = ev[i]; ev[i] = ev[j]; ev[j] = t; } }

/* the Hessian of the energy over the survivors' left Lie algebra at the current configuration, by central differences */
static void perturb(int l, int a, double eps) { Q q = { cos(eps), 0, 0, 0 }; if (a == 0) q.x = sin(eps); if (a == 1) q.y = sin(eps); if (a == 2) q.z = sin(eps);
  OBJ[l] = qmul(q, OBJ[l]); if (PARTNER[l] >= 0) OBJ[PARTNER[l]] = qconj(OBJ[l]); }
static void hessian(double *H, int n) { const double eps = 1e-3; Q save[NL]; memcpy(save, OBJ, sizeof save);
  for (int i = 0; i < n; i++) for (int j = i; j < n; j++) { int li = SURVL[i/3], ai = i%3, lj = SURVL[j/3], aj = j%3; double e[4]; int k = 0;
    for (int si = -1; si <= 1; si += 2) for (int sj = -1; sj <= 1; sj += 2) { memcpy(OBJ, save, sizeof save); perturb(li, ai, si*eps); perturb(lj, aj, sj*eps); e[k++] = energy(); }
    double h = (e[3] - e[2] - e[1] + e[0]) / (4*eps*eps); H[i*n+j] = H[j*n+i] = h; }
  memcpy(OBJ, save, sizeof save); }

int main(int argc, char **argv) {
  if (argc < 3) { fprintf(stderr, "usage: flux_table <listing> <name>\n"); return 2; }
  const char *name = argv[2];
  /* the datum */
  FILE *f = fopen(argv[1], "r"); if (!f) { printf("FLUX REFUSED DATUM-FILE %s\n", argv[1]); return 2; }
  char line[512]; while (fgets(line, sizeof line, f)) { int s[4], d; double w, x, y, z; const char *p = line; if (!strncmp(p, "CEI-OUT ", 8)) p += 8;
    if (sscanf(p, "%d %d %d %d %d %lf %lf %lf %lf", &s[0], &s[1], &s[2], &s[3], &d, &w, &x, &y, &z) != 9) continue;
    int a = s[0]+OFF, b = s[1]+OFF, c = s[2]+OFF, e = s[3]+OFF; if (a < 0 || a >= DIM || b < 0 || b >= DIM || c < 0 || c >= DIM || e < 0 || e >= DIM || d < 1 || d > 4) { printf("FLUX REFUSED DATUM-RANGE %d %d %d %d d%d\n", s[0], s[1], s[2], s[3], d); return 2; }
    Q q = { w, x, y, z }; double nn = qnorm(q); if (fabs(nn - 1) > 1e-9) { printf("FLUX REFUSED DATUM-NORM %d %d %d %d d%d |q| = %.12f\n", s[0], s[1], s[2], s[3], d, nn); return 2; }
    DAT[a][b][c][e][d-1] = q; DATP[a][b][c][e][d-1] = 1; NDAT++; }
  fclose(f);
  if (NDAT != 248) { printf("FLUX REFUSED DATUM-COUNT %d (248 expected)\n", NDAT); return 2; }
  /* the object links, in the strip order (x descending as strip_K3.ord lists them) */
  int nl = 0; for (int x = 2; x >= -4; x--) { if (x <= 1) for (int y = 0; y <= 2; y++) { LS[nl][0] = x; LS[nl][1] = y; LS[nl][2] = 0; LS[nl][3] = 0; LD[nl] = 1; nl++; }
    for (int y = 0; y <= 1; y++) { LS[nl][0] = x; LS[nl][1] = y; LS[nl][2] = 0; LS[nl][3] = 0; LD[nl] = 2; nl++; } }
  if (nl != NL) { printf("FLUX REFUSED LINK-COUNT %d\n", nl); return 2; }
  for (int l = 0; l < NL; l++) OBJ[l] = QONE;
  /* the plaquettes touching the object */
  for (int l = 0; l < NL; l++) for (int nu = 1; nu <= 4; nu++) { if (nu == LD[l]) continue; int mu = LD[l];
    for (int side = 0; side < 2; side++) { int c[4]; memcpy(c, LS[l], sizeof c); if (side) c[nu-1]--; int m = mu < nu ? mu : nu, n = mu < nu ? nu : mu;
      if (pidx(c, m, n) >= 0) continue; if (NP >= NPMAX) { printf("FLUX REFUSED PLAQUETTE-STORE\n"); return 2; }
      memcpy(PS[NP], c, sizeof c); PM[NP] = m; PN[NP] = n; PK[NP] = (m == 1 && n == 2 && instrip(c)) ? 1 : 0; NP++; } }
  int nobj = 0, ndat = 0; for (int p = 0; p < NP; p++) { if (PK[p]) nobj++; else ndat++; }
  /* every datum plaquette's three outside links present (missing counted by the first energy evaluation) */
  missing = 0; energy(); if (missing) { printf("FLUX REFUSED DATUM-MISSING %d %d %d %d d%d (%d absent link reads)\n", MISS[0], MISS[1], MISS[2], MISS[3], MISSD, missing); return 2; }
  /* the plaquettes per link (containing l or its partner), after the fibre is set */
  for (int l = 0; l < NL; l++) { PARTNER[l] = -1; SURV[l] = 1; }
  for (int a = -4; a <= 0; a += 2) { int s1[4] = { a, 0, 0, 0 }, s2[4] = { a+1, 0, 0, 0 }; int v = lidx(s1, 1), e = lidx(s2, 1); PARTNER[v] = e; PARTNER[e] = v; SURV[e] = 0;   /* bottom: the left survives */
    int t1[4] = { a+1, 2, 0, 0 }, t2[4] = { a, 2, 0, 0 }; v = lidx(t1, 1); e = lidx(t2, 1); PARTNER[v] = e; PARTNER[e] = v; SURV[e] = 0;                      /* top: the right survives */
    int r1[4] = { a+2, 1, 0, 0 }, r2[4] = { a+2, 0, 0, 0 }; v = lidx(r1, 2); e = lidx(r2, 2); PARTNER[v] = e; PARTNER[e] = v; SURV[e] = 0; }                  /* right column: y = 1 survives */
  { int c1[4] = { -4, 1, 0, 0 }, c2[4] = { -4, 0, 0, 0 }; int v = lidx(c1, 2), e = lidx(c2, 2); PARTNER[v] = e; PARTNER[e] = v; SURV[e] = 0; }               /* the strip's left column */
  NSURV = 0; for (int l = 0; l < NL; l++) if (SURV[l]) SURVL[NSURV++] = l;
  for (int l = 0; l < NL; l++) { NLP[l] = 0; NLPO[l] = 0; for (int p = 0; p < NP; p++) { int in = 0; int c[4]; memcpy(c, PS[p], sizeof c);
      int e1[4], e2[4], e3[4]; memcpy(e1, c, sizeof c); e1[PM[p]-1]++; memcpy(e2, c, sizeof c); e2[PN[p]-1]++;
      /* the four links: (c,m) (c+m,n) (c+n,m) (c,n) */
      int li[4] = { lidx(c, PM[p]), lidx(e1, PN[p]), lidx(e2, PM[p]), lidx(c, PN[p]) };
      int own = 0; for (int k = 0; k < 4; k++) { if (li[k] == l) own = 1; if (li[k] == l || (PARTNER[l] >= 0 && li[k] == PARTNER[l])) in = 1; }
      if (in) LP[l][NLP[l]++] = p; if (own) LPO[l][NLPO[l]++] = p; (void)e3; } }
  for (int k = 0; k < 7; k++) { int s[4] = { CELLS[k][0], CELLS[k][1], 0, 0 }; CELLI[k] = lidx(s, CELLS[k][2]); if (CELLI[k] < 0 || !SURV[CELLI[k]]) { printf("FLUX REFUSED CELL-LINK %d %d d%d\n", CELLS[k][0], CELLS[k][1], CELLS[k][2]); return 2; } }
  printf("FLUX datum=%s outside=%d object-plaquettes=%d datum-plaquettes=%d links=%d survivors=%d\n", name, NDAT, nobj, ndat, NL, NSURV);
  /* the bare staple sums and the effective fields */
  Q V[NL], SE[NL]; for (int l = 0; l < NL; l++) OBJ[l] = QONE;
  for (int l = 0; l < NL; l++) V[l] = local_field(l, 1);   /* the bare sum: the plaquettes holding l itself, the partner untouched */
  for (int l = 0; l < NL; l++) SE[l] = (PARTNER[l] >= 0) ? qadd(V[l], qconj(V[PARTNER[l]])) : V[l];
  /* THE ANCHOR (law 3): the author's pinning number for a paired survivor is |own sum| + |partner's sum| -- its CEI-PIN prints the two
     norms apart and the scan adds them -- printed here as FLUX-PIN so the scan is matched cell for cell; this instrument's pin is
     |own + conj(partner)|, the norm of the ONE field acting on the survivor (the partner's term <U^-1, V_p> = <U, conj V_p>), which the
     sum of norms bounds above and equals only where the two preferred values coincide (the identity datum: 8 and 10 both ways) */
  printf("FLUX-PIN datum=%s", name); for (int k = 0; k < 7; k++) { int l = CELLI[k]; double ps = qnorm(V[l]) + (PARTNER[l] >= 0 ? qnorm(V[PARTNER[l]]) : 0); printf(" (%d,%d)d%d=%.3f", LS[l][0], LS[l][1], LD[l], ps); }
  { double smin = 1e9, smean = 0; for (int k = 0; k < 7; k++) { int l = CELLI[k]; double ps = qnorm(V[l]) + (PARTNER[l] >= 0 ? qnorm(V[PARTNER[l]]) : 0); smean += ps / 7; if (ps < smin) smin = ps; } printf(" | the author's pin-sum: cell min %.4f mean %.4f\n", smin, smean); PSMIN = smin; PSMEAN = smean; }
  printf("FLUX-PIN-EFF datum=%s", name); for (int k = 0; k < 7; k++) { int l = CELLI[k]; printf(" (%d,%d)d%d=%.6f", LS[l][0], LS[l][1], LD[l], qnorm(SE[l])); }
  double pmin = 1e9, pmean = 0; for (int k = 0; k < 7; k++) { double n = qnorm(SE[CELLI[k]]); pmean += n / 7; if (n < pmin) pmin = n; } printf(" | the one field's norm: cell min-pin %.4f mean-pin %.4f\n", pmin, pmean);
  printf("FLUX-BARE datum=%s", name); for (int l = 0; l < NL; l++) printf(" (%d,%d)d%d=%.4f", LS[l][0], LS[l][1], LD[l], qnorm(V[l])); printf("\n");
  /* the preferred fibre configuration and its plaquette traces */
  for (int i = 0; i < NSURV; i++) { int l = SURVL[i]; OBJ[l] = qscale(SE[l], 1 / qnorm(SE[l])); } tie();
  double epref = energy(); double fcell = 0, fcellmin = 2, fstrip = 0, fstripmin = 2; int ncell = 0;
  printf("FLUX-FACE-PREF datum=%s", name);
  for (int p = 0; p < NP; p++) if (PK[p]) { double t = ptrace(p); printf(" (%d,%d)=%.4f", PS[p][0], PS[p][1], t); fstrip += t / nobj; if (t < fstripmin) fstripmin = t;
    if (PS[p][0] <= -3) { fcell += t / 4; ncell++; if (t < fcellmin) fcellmin = t; } }
  printf(" | cell mean-f %.4f min-f %.4f strip mean-f %.4f min-f %.4f E-pref %.6f\n", fcell, fcellmin, fstrip, fstripmin, epref);
  if (ncell != 4) { printf("FLUX REFUSED CELL-FACES %d\n", ncell); return 2; }
  /* the landscape: from the preferred start, then 64 random starts */
  int sw; double e0 = relax(&sw); Q best[NL]; memcpy(best, OBJ, sizeof best); double ebest = e0; int sw0 = sw;
  double mins[80]; int nmin = 0; mins[nmin++] = e0; int nconv = 1;
  for (int r = 0; r < 64; r++) { for (int i = 0; i < NSURV; i++) OBJ[SURVL[i]] = qrand(); tie(); double e = relax(&sw); if (sw < 2000) nconv++;
    int found = 0; for (int k = 0; k < nmin; k++) if (fabs(mins[k] - e) < 1e-7) found = 1; if (!found && nmin < 80) mins[nmin++] = e;
    if (e < ebest - 1e-12) { ebest = e; memcpy(best, OBJ, sizeof best); } }
  for (int i = 0; i < nmin; i++) for (int j = i+1; j < nmin; j++) if (mins[j] < mins[i]) { double t = mins[i]; mins[i] = mins[j]; mins[j] = t; }
  double de2 = (nmin > 1) ? mins[1] - mins[0] : -1;
  printf("FLUX-LANDSCAPE datum=%s E-min %.9f (from the preferred start %.9f in %d sweeps) distinct-minima %d second-excess %.6f converged %d/65 E-pref-excess %.6f\n", name, ebest, e0, sw0, nmin, de2, nconv, epref - ebest);
  /* the plaquette traces at the best minimum */
  memcpy(OBJ, best, sizeof best); double gcell = 0, gcellmin = 2, gstrip = 0, gstripmin = 2;
  printf("FLUX-FACE-MIN datum=%s", name);
  for (int p = 0; p < NP; p++) if (PK[p]) { double t = ptrace(p); printf(" (%d,%d)=%.4f", PS[p][0], PS[p][1], t); gstrip += t / nobj; if (t < gstripmin) gstripmin = t;
    if (PS[p][0] <= -3) { gcell += t / 4; if (t < gcellmin) gcellmin = t; } }
  printf(" | cell mean-f %.4f min-f %.4f strip mean-f %.4f min-f %.4f\n", gcell, gcellmin, gstrip, gstripmin);
  /* the Hessian at the best minimum: whole and the cell's block */
  int n = 3 * NSURV; static double H[96*96], Hc[21*21], ev[96], evc[21]; hessian(H, n);
  for (int i = 0; i < 7; i++) for (int j = 0; j < 7; j++) { int si = -1, sj = -1; for (int k = 0; k < NSURV; k++) { if (SURVL[k] == CELLI[i]) si = k; if (SURVL[k] == CELLI[j]) sj = k; }
    for (int a = 0; a < 3; a++) for (int b = 0; b < 3; b++) Hc[(3*i+a)*21 + 3*j+b] = H[(3*si+a)*n + 3*sj+b]; }
  static double Hw[96*96]; memcpy(Hw, H, sizeof(double)*n*n); jacobi(Hw, n, ev); jacobi(Hc, 21, evc);
  double ld = 0, ldc = 0; int neg = 0, negc = 0; for (int i = 0; i < n; i++) { if (ev[i] > 0) ld += log(ev[i]); else neg++; } for (int i = 0; i < 21; i++) { if (evc[i] > 0) ldc += log(evc[i]); else negc++; }
  printf("FLUX-HESSIAN datum=%s whole n=%d min %.6f second %.6f max %.6f logdet %.6f negative %d | cell n=21 min %.6f second %.6f max %.6f logdet %.6f negative %d\n", name, n, ev[0], ev[1], ev[n-1], ld, neg, evc[0], evc[1], evc[20], ldc, negc);
  printf("FLUX-SUMMARY datum=%s fcell-pref %.6f fcellmin-pref %.6f fstrip-pref %.6f fcell-min %.6f fcellmin-min %.6f fstrip-min %.6f pin-min %.6f pin-mean %.6f E-min %.9f minima %d dE2 %.6f h-min %.6f h-cell-min %.6f h-logdet %.6f h-cell-logdet %.6f E-pref-excess %.6f pinsum-min %.6f pinsum-mean %.6f\n",
    name, fcell, fcellmin, fstrip, gcell, gcellmin, gstrip, pmin, pmean, ebest, nmin, de2, ev[0], evc[0], ld, ldc, epref - ebest, PSMIN, PSMEAN);
  return 0;
}
