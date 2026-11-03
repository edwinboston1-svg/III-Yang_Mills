/* ---- cei_face: the loops dropped, the substitution, the partner staples, the order file ---- */
static void cei_renumber_wires(void) { NW = 0; for (int c = 0; c < NCYC; c++) { NWIRE[c] = ISLOOP[c] ? NSTEP[c] + 1 : NSTEP[c]; WBASE[c] = NW; for (int i = 0; i < NWIRE[c]; i++) WCYC[NW + i] = c; NW += NWIRE[c]; }
  if (NW > MAXW) { fprintf(stderr, "too many wires after the cei rebuild\n"); exit(1); } }
static void cei_drop_loops(void) { NSTEP[LOOPA] = 0; NSTEP[LOOPB] = 0; ISLOOP[LOOPA] = 0; ISLOOP[LOOPB] = 0; cei_renumber_wires();
  printf("CEI-DROP: the two loop cycles dropped (their holonomies are constants of the fibre, or trivial at spin 0); %d wires\n", NW); }
static void cei_replace(int c, int st, int p, int sp, int se) {   /* the step st of cycle c sits on the eliminated link e with sign tau */
  int tau = STEPS[c][st];
  if (tau == se) { STEPL[c][st] = p; STEPS[c][st] = -sp; STEPPRE[c][st] = 1; STEPPREQ[c][st] = CEIC; }
  else { STEPL[c][st] = p; STEPS[c][st] = sp; int prev = (st + NSTEP[c] - 1) % NSTEP[c];
    quat ci = qinv(CEIC); if (STEPPOST[c][prev]) STEPPOSTQ[c][prev] = qmul(STEPPOSTQ[c][prev], ci); else { STEPPOST[c][prev] = 1; STEPPOSTQ[c][prev] = ci; } } }
/* THE STRIP (campaign 31.15): K planar coarse cells in one row, built like EI's build() -- face 0 is face A, face 1 is the planar face B, face f
   lies at x in [-(f-1)n - n, -(f-1)n]; loop f runs counterclockwise from the top of its right edge (face 0's from the top of the shared edge, as
   EI's); no corners (a planar object has none); the staples as EI's; the order from CEI_ORDER (required).  At K = 2 it is EI's planar object
   cycle for cycle and wire for wire (the known answer: the two builders' readings byte-identical). */
static void cei_build_strip(void) { int n = NN, K = STRIPK; NP = K * n * n; NCYC = NP + K; LOOPA = NP; LOOPB = NP + 1; CORN0 = NP + K; NCORN = 0;
  if (NP + K > MAXCYC) { fprintf(stderr, "CEI_STRIP: %d cycles exceed MAXCYC %d\n", NP + K, MAXCYC); exit(1); }
  for (int i = 0; i < n; i++) for (int j = 0; j < n; j++) add_plaq(j + n * i, i, j, 0, 1, 2);
  for (int f = 1; f < K; f++) for (int k = 0; k < n; k++) for (int j = 0; j < n; j++) add_plaq(f * n * n + j + n * k, -(f - 1) * n - 1 - k, j, 0, 1, 2);
  if (NL != K * n * (2 * n + 1) + n) { fprintf(stderr, "strip links: %d, not %d\n", NL, K * n * (2 * n + 1) + n); exit(1); }
  for (int f = 0; f < K; f++) { int c = NP + f; NSTEP[c] = 4 * n; ISLOOP[c] = 1; int s = 0;
    if (f == 0) { for (int j = n - 1; j >= 0; j--) add_loop_step(c, s++, 0, j, 0, 2, -1); for (int i = 0; i < n; i++) add_loop_step(c, s++, i, 0, 0, 1, 1);
      for (int j = 0; j < n; j++) add_loop_step(c, s++, n, j, 0, 2, 1); for (int i = n - 1; i >= 0; i--) add_loop_step(c, s++, i, n, 0, 1, -1); }
    else { int xr = -(f - 1) * n, xl = -f * n;
      for (int i = 0; i < n; i++) add_loop_step(c, s++, xr - 1 - i, n, 0, 1, -1); for (int j = n - 1; j >= 0; j--) add_loop_step(c, s++, xl, j, 0, 2, -1);
      for (int i = 0; i < n; i++) add_loop_step(c, s++, xl + i, 0, 0, 1, 1); for (int j = 0; j < n; j++) add_loop_step(c, s++, xr, j, 0, 2, 1); } }
  NW = 0; for (int c = 0; c < NCYC; c++) { NWIRE[c] = ISLOOP[c] ? NSTEP[c] + 1 : NSTEP[c]; WBASE[c] = NW; for (int i = 0; i < NWIRE[c]; i++) WCYC[NW + i] = c; NW += NWIRE[c]; }
  if (NW > MAXW) { fprintf(stderr, "too many wires\n"); exit(1); }
  { int b0[4] = { 0, 0, 0, 0 }; SHARED0 = lkey(b0, 2, 0); }
  for (int l = 0; l < NL; l++) { int *p = LB[l], d = LD[l]; int pd[4]; memcpy(pd, p, sizeof pd); pd[d - 1]++; NSTAP[l] = 0;
    for (int k = 1; k <= 4; k++) { if (k == d) continue;
      for (int si = 0; si < 2; si++) { int s = si ? -1 : 1; int base[4]; memcpy(base, p, sizeof base); if (s < 0) base[k - 1]--;
        int d1 = d < k ? d : k, d2 = d < k ? k : d; if (is_obj_plaq(base, d1, d2)) continue;
        if (plaq_nobj(base, d1, d2) >= 2) { fprintf(stderr, "CEI_STRIP: a non-face plaquette with two object links (a corner) in a planar strip\n"); exit(1); }
        int ns = NSTAP[l]; int q[4];
        if (s > 0) { STAP[l][ns][0][0] = okey(pd, k); STAP[l][ns][0][1] = 1; } else { memcpy(q, pd, sizeof q); q[k - 1] -= 1; STAP[l][ns][0][0] = okey(q, k); STAP[l][ns][0][1] = -1; }
        memcpy(q, p, sizeof q); q[k - 1] += s; STAP[l][ns][1][0] = okey(q, d); STAP[l][ns][1][1] = -1;
        if (s > 0) { STAP[l][ns][2][0] = okey(p, k); STAP[l][ns][2][1] = -1; } else { memcpy(q, p, sizeof q); q[k - 1] -= 1; STAP[l][ns][2][0] = okey(q, k); STAP[l][ns][2][1] = 1; }
        NSTAP[l]++; } } }
  NORD = 0;   /* the order comes from CEI_ORDER */
  printf("CEI-STRIP K=%d n=%d: %d plaquettes, %d loops, %d links, %d outside links, %d wires\n", K, n, NP, K, NL, NOUT, NW); }
static void cei_substitute(void) { int n = NN;
  if (n != 2) { fprintf(stderr, "CEI_SUBST REFUSED: the substitution is written for n = 2 (one partner link per edge)\n"); exit(1); }
  if (PLANAR && !STRIPK) { fprintf(stderr, "CEI_SUBST REFUSED: the bent object, or a strip (CEI_STRIP=K)\n"); exit(1); }
  if (FREE) { fprintf(stderr, "CEI_SUBST REFUSED at the free datum (the corners are off there; the substituted object is read at a datum)\n"); exit(1); }
  int EL[64][2], ES[64][2], NE = 0, K = STRIPK ? STRIPK : 2;   /* the 3K + 1 edges: links and signs in loop order (loop 0's four; every later loop's first three, its fourth being the edge shared with the loop before) */
  for (int e = 0; e < 4; e++) { for (int k = 0; k < 2; k++) { EL[NE][k] = STEPL[LOOPA][2 * e + k]; ES[NE][k] = STEPS[LOOPA][2 * e + k]; } NE++; }
  for (int f = 1; f < K; f++) for (int e = 0; e < 3; e++) { for (int k = 0; k < 2; k++) { EL[NE][k] = STEPL[NP + f][2 * e + k]; ES[NE][k] = STEPS[NP + f][2 * e + k]; } NE++; }
  for (int l = 0; l < NL; l++) { ELIM[l] = 0; NISTAP[l] = 0; ELIMOF[l] = -1; }
  for (int f = 0; f < K; f++) { NSTEP[NP + f] = 0; ISLOOP[NP + f] = 0; }   /* the loops dropped: every edge's product is the constant c */
  for (int e = 0; e < NE; e++) { int p = EL[e][0], sp = ES[e][0], el = EL[e][1], se = ES[e][1];
    if (ELIM[el] || ELIM[p]) { fprintf(stderr, "CEI_SUBST: an edge's link already eliminated\n"); exit(1); }
    for (int c = 0; c < NCYC; c++) for (int st = 0; st < NSTEP[c]; st++) if (STEPL[c][st] == el) cei_replace(c, st, p, sp, se);
    for (int k = 0; k < NSTAP[el]; k++) { int m = NISTAP[p]; if (m >= 8) { fprintf(stderr, "CEI_SUBST: too many inverse staples\n"); exit(1); }
      memcpy(ISTAP[p][m], STAP[el][k], sizeof(int) * 3 * 2); ISIGP[p][m] = sp; ISIGE[p][m] = se; NISTAP[p]++; }
    ELIM[el] = 1; NELIM++; ELIMOF[p] = el; }   /* the eliminated link keeps its staple list (the cancel datum reads the shared link's); no tensor is ever built for it */
  int twice = 0; for (int c = 0; c < NCYC; c++) for (int i = 0; i < NSTEP[c]; i++) for (int j = i + 1; j < NSTEP[c]; j++) if (STEPL[c][i] == STEPL[c][j]) twice++;
  cei_renumber_wires();
  printf("CEI-SUBST: %d coarse edges fixed at c = (%.6f,%.6f,%.6f,%.6f) by substitution; %d links eliminated, %d survive; the loop cycles dropped; %d cycle(s) hold a link at two steps; %d wires\n", NE, CEIC.w, CEIC.x, CEIC.y, CEIC.z, NELIM, NL - NELIM, twice, NW); }
static quat cei_partner_value(int l, int k, quat U) {   /* U_e = (U_p^{-sp} c)^{se} at U_p = U */
  quat q = (ISIGP[l][k] > 0) ? qinv(U) : U; q = qmul(q, CEIC); if (ISIGE[l][k] < 0) q = qinv(q); return q; }
static void cei_source(int c) { for (int q = 0; q <= WMAX; q++) PFAC[c][q] = (q > 0 ? FAC[q - 1] : 0) + (q + 1 <= WMAX ? FAC[q + 1] : 0); }   /* the chi_1 source on cycle c: chi_1 chi_q = chi_{q-1} + chi_{q+1} */
static double wself(int l, quat V) { double s = 1; for (int k = 1; k <= KSELF; k++) s += FS[l][k] * chi(k, V); return s; }   /* the self-energy weight, normalised at spin 0 like wgt */
static void cei_read_self(const char *file) {   /* "x y z d kappa" per object link: FS[l][k] = (k + 1) I_{k+1}(kappa beta) / I_1(kappa beta), the Wilson coefficients at coupling kappa beta */
  FILE *f = fopen(file, "r"); if (!f) { fprintf(stderr, "CEI_SELF: cannot open %s\n", file); exit(1); }
  int seen[MAXL]; for (int l = 0; l < NL; l++) seen[l] = 0; int x, y, z, d; double kap; int n = 0;
  while (fscanf(f, "%d %d %d %d %lf", &x, &y, &z, &d, &kap) == 5) { int b[4] = { x, y, z, 0 }; int l = lkey(b, d, 0); if (l < 0) { fprintf(stderr, "CEI_SELF: no link (%d,%d,%d) d%d\n", x, y, z, d); exit(1); }
    if (seen[l]) { fprintf(stderr, "CEI_SELF: link (%d,%d,%d) d%d given twice\n", x, y, z, d); exit(1); } if (kap < 0) { fprintf(stderr, "CEI_SELF: a negative kappa at (%d,%d,%d) d%d\n", x, y, z, d); exit(1); }
    seen[l] = 1; KEFF[l] = kap; n++; }
  fclose(f); for (int l = 0; l < NL; l++) if (!seen[l]) { fprintf(stderr, "CEI_SELF: link %d (%d,%d,%d) d%d has no kappa\n", l, LB[l][0], LB[l][1], LB[l][2], LD[l]); exit(1); }
  if (KSELF <= 0) KSELF = WMAX + 4; if (KSELF > 31) KSELF = 31; double kmin = 1e9, kmax = 0, tailmax = 0;
  for (int l = 0; l < NL; l++) { double kb = KEFF[l] * BETA; for (int k = 0; k < 32; k++) FS[l][k] = 0; FS[l][0] = 1; if (kb > 0) { double i1 = bessel(1, kb); for (int k = 1; k <= KSELF; k++) FS[l][k] = (k + 1) * bessel(k + 1, kb) / i1;
      double tail = 0; for (int k = KSELF + 1; k <= 31; k++) tail += (k + 1) * (k + 1) * bessel(k + 1, kb) / i1; if (tail > tailmax) tailmax = tail; }
    if (KEFF[l] < kmin) kmin = KEFF[l]; if (KEFF[l] > kmax) kmax = KEFF[l]; }
  SELFON = 1; printf("CEI-SELF %s: %d links, kappa in [%.6f, %.6f], KSELF=%d, the weight's truncation tail at most %.2e (sum of |coefficient| x dimension past the cap)\n", file, n, kmin, kmax, KSELF, tailmax); }
static void cei_read_datum(const char *file, quat *DATA) {   /* the datum from a file: "x y z t d w x y z" per outside link (a unit quaternion; normalised here); every outside link must be given */
  FILE *f = fopen(file, "r"); if (!f) { fprintf(stderr, "datum file: cannot open %s\n", file); exit(1); }
  int seen[MAXOUT]; for (int i = 0; i < NOUT; i++) seen[i] = 0; int b[4], d; double w, x, y, z; int n = 0, extra = 0;
  while (fscanf(f, "%d %d %d %d %d %lf %lf %lf %lf", &b[0], &b[1], &b[2], &b[3], &d, &w, &x, &y, &z) == 9) { int i = -1; for (int k = 0; k < NOUT; k++) if (OD[k] == d && !memcmp(OB[k], b, sizeof(int) * 4)) { i = k; break; }
    if (i < 0) { extra++; continue; } if (seen[i]) { fprintf(stderr, "datum file: link (%d,%d,%d,%d) d%d given twice\n", b[0], b[1], b[2], b[3], d); exit(1); }
    double nn = sqrt(w * w + x * x + y * y + z * z); if (nn < 1e-12) { fprintf(stderr, "datum file: a zero quaternion at (%d,%d,%d,%d) d%d\n", b[0], b[1], b[2], b[3], d); exit(1); }
    DATA[i].w = w / nn; DATA[i].x = x / nn; DATA[i].y = y / nn; DATA[i].z = z / nn; seen[i] = 1; n++; }
  fclose(f); for (int i = 0; i < NOUT; i++) if (!seen[i]) { fprintf(stderr, "datum file: outside link (%d,%d,%d,%d) d%d has no value\n", OB[i][0], OB[i][1], OB[i][2], OB[i][3], OD[i]); exit(1); }
  printf("CEI-DATUM %s: %d outside links set (%d lines of other links ignored)\n", file, n, extra); }
static void cei_list_out(const quat *DATA) { for (int i = 0; i < NOUT; i++) printf("CEI-OUT %d %d %d %d %d %.15f %.15f %.15f %.15f\n", OB[i][0], OB[i][1], OB[i][2], OB[i][3], OD[i], DATA[i].w, DATA[i].x, DATA[i].y, DATA[i].z); }
static quat istaple(int l, int k, const quat *dat) { quat T = { 1, 0, 0, 0 }; for (int j = 0; j < 3; j++) { quat V = dat[ISTAP[l][k][j][0]]; if (ISTAP[l][k][j][1] < 0) V = qinv(V); T = qmul(T, V); } return T; }
static void cei_read_order(const char *file) { FILE *f = fopen(file, "r"); if (!f) { fprintf(stderr, "CEI_ORDER: cannot open %s\n", file); exit(1); }
  int x, y, z, d; NCEIORD = 0; while (fscanf(f, "%d %d %d %d", &x, &y, &z, &d) == 4) { int b[4] = { x, y, z, 0 }; int l = lkey(b, d, 0); if (l < 0) { fprintf(stderr, "CEI_ORDER: no link (%d,%d,%d) d%d\n", x, y, z, d); exit(1); }
    for (int i = 0; i < NCEIORD; i++) if (CEIORD[i] == l) { fprintf(stderr, "CEI_ORDER: a link repeated\n"); exit(1); } CEIORD[NCEIORD++] = l; }
  fclose(f);
  int nsurv = 0; for (int l = 0; l < NL; l++) if (!ELIM[l]) nsurv++; int got = 0; for (int i = 0; i < NCEIORD; i++) if (!ELIM[CEIORD[i]]) got++;
  if (got != nsurv) { fprintf(stderr, "CEI_ORDER: %d of the %d surviving links given\n", got, nsurv); exit(1); }
  printf("CEI-ORDER %s: %d links read, %d surviving links in the order\n", file, NCEIORD, got); }
/* THE MULTI-VERTEX GAUGE DOOR (campaign §32 CORRECTION, 2026-11-03 04:0x): CEI_GAUGES="x,y,z,w:qw:qx:qy:qz[;x,y,z,w:qw:qx:qy:qz ...]" gauge-transforms
   the datum at SEVERAL vertices in one run -- the periodic pair, the whole coarse class -- the record's one-vertex W2_GAUGE left untouched, so arm 5's
   pins stand.  Each group exactly as W2_GAUGE: every GENUINE outside link leaving v becomes g U, every one entering it U g^-1, a phantom entry (one that
   carries an object link's coordinates) left alone and counted.  Called from the tensors anchor, BEFORE the link tensors are built from the datum. */
static void cei_gauges(quat *DATA) { const char *env = getenv("CEI_GAUGES"); if (!env) return; char gbuf[8192]; strncpy(gbuf, env, sizeof gbuf - 1); gbuf[sizeof gbuf - 1] = 0; int ngrp = 0;
  for (char *grp = strtok(gbuf, ";"); grp; grp = strtok(NULL, ";")) { int v[4]; double gw, gx, gy, gz;
    if (sscanf(grp, "%d,%d,%d,%d:%lf:%lf:%lf:%lf", &v[0], &v[1], &v[2], &v[3], &gw, &gx, &gy, &gz) != 8) { fprintf(stderr, "CEI_GAUGES must be x,y,z,w:qw:qx:qy:qz[;...]\n"); exit(1); }
    double nn = sqrt(gw * gw + gx * gx + gy * gy + gz * gz); if (nn < 1e-12) { fprintf(stderr, "CEI_GAUGES: a zero quaternion\n"); exit(1); } quat g = { gw / nn, gx / nn, gy / nn, gz / nn }; int nl = 0, ne = 0, nph = 0;
    for (int i = 0; i < NOUT; i++) { int e[4]; memcpy(e, OB[i], sizeof e); e[OD[i] - 1]++; int leaves = !memcmp(OB[i], v, sizeof v), enters = !memcmp(e, v, sizeof v); if (!leaves && !enters) continue;
      if (lkey(OB[i], OD[i], 0) >= 0) { nph++; continue; } if (leaves) { DATA[i] = qmul(g, DATA[i]); nl++; } if (enters) { DATA[i] = qmul(DATA[i], qinv(g)); ne++; } }
    int onobj = 0; for (int l = 0; l < NL; l++) { int e[4]; memcpy(e, LB[l], sizeof e); e[LD[l] - 1]++; if (!memcmp(LB[l], v, sizeof v) || !memcmp(e, v, sizeof v)) onobj = 1; }
    ngrp++; printf("CEI-GAUGES vertex (%d,%d,%d,%d) g=(%.6f,%.6f,%.6f,%.6f): %d outside links leaving, %d entering, transformed; %d phantom entries left alone; an %s vertex\n", v[0], v[1], v[2], v[3], g.w, g.x, g.y, g.z, nl, ne, nph, onobj ? "object" : "outside"); }
  printf("CEI-GAUGES %d group(s) applied before the link tensors\n", ngrp); }
