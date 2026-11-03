# cei_insert.awk -- turns EI's w2e.c into cei_face.c by inserting the three fragments at named anchors and editing lines in place.
# usage: gawk -v DECL=cei_decl.c -v FUNCS=cei_funcs.c -v DRIVER=cei_driver.c -f cei_insert.awk w2e.c > cei_face.c
# (Written with the editor, not through the shell: the shell halves backslashes once, which ate an ampersand and a newline on 11-02 17:3x.)
function emit(f,   line) { while ((getline line < f) > 0) print line; close(f) }
/^static int NCORN = 0, CORN0 = 0; static int STEPMN/ { print; emit(DECL); HIT["decl"]++; next }
/^static quat staple\(int l, int k, const quat \*dat\)/ { emit(FUNCS); print; HIT["funcs"]++; next }
/^static quat step_mult\(int c, int st, const quat \*dat\) \{ quat M = \{ 1, 0, 0, 0 \};/ {
  sub(/quat M = \{ 1, 0, 0, 0 \};/, "quat M = { 1, 0, 0, 0 }; if (STEPPRE[c][st]) M = STEPPREQ[c][st];")
  sub(/return M; \}$/, "if (STEPPOST[c][st]) M = qmul(M, STEPPOSTQ[c][st]); return M; }")
  print; HIT["stepmult"]++; next }
/^static cplx \*corner_table\(int l, int j, const quat \*dat\)/ {
  sub(/if \(STEPMN\[c\]\[st\] == 0\) return NULL;/, "if (STEPMN[c][st] == 0) if (!STEPPRE[c][st]) if (!STEPPOST[c][st]) return NULL;")
  print; HIT["corner"]++; next }
index($0, "if (!FREE) for (int k = 0; k < NSTAP[l]; k++) { quat T = staple(l, k, dat); w *= wgt(qmul(RU[pt], T)); } sw[pt] = w; }") {
  # the staples: at a datum the ordered product over the link's staples and the partner's inverse staples; under CEI_SELF the exterior's
  # Gaussian self-energy on the link and, through the partner's value, on the eliminated link (campaign 31.14)
  print "  for (int pt = 0; pt < NPT; pt++) { double w = RW[pt]; if (!FREE) { if (SELFON) { if (NSTAP[l] > 0) w *= wself(l, RU[pt]); if (NISTAP[l] > 0) w *= wself(ELIMOF[l], cei_partner_value(l, 0, RU[pt])); } else { for (int k = 0; k < NSTAP[l]; k++) { quat T = staple(l, k, dat); w *= wgt(qmul(RU[pt], T)); } for (int k = 0; k < NISTAP[l]; k++) { quat T = istaple(l, k, dat); w *= wgt(qmul(cei_partner_value(l, k, RU[pt]), T)); } } } sw[pt] = w; }"
  HIT["staples"]++; next }
index($0, "spin[closed[i]] = s; fw *= FAC[s]; } }") { sub(/fw \*= FAC\[s\]; \} \}/, "fw *= PFAC[closed[i]][s]; } }"); print; HIT["pfac"]++; next }
/^  double t0 = now\(\);/ {
  print "  for (int c = 0; c < MAXCYC; c++) for (int s = 0; s < 32; s++) PFAC[c][s] = FAC[s];   /* cei: the per-cycle closing weights, the Wilson ones unless a source is set */"
  print "  if (getenv(\"CEI_SUBST\") && atoi(getenv(\"CEI_SUBST\")) == 1) CEI = 2; else if (getenv(\"CEI_DROPLOOPS\") && atoi(getenv(\"CEI_DROPLOOPS\")) == 1) CEI = 1;"
  print "  if (getenv(\"CEI_C\")) { double cw, cx, cy, cz; if (sscanf(getenv(\"CEI_C\"), \"%lf:%lf:%lf:%lf\", &cw, &cx, &cy, &cz) != 4) { fprintf(stderr, \"CEI_C must be w:x:y:z\\n\"); return 1; } double nn = sqrt(cw * cw + cx * cx + cy * cy + cz * cz); if (nn < 1e-12) { fprintf(stderr, \"CEI_C: zero\\n\"); return 1; } CEIC.w = cw / nn; CEIC.x = cx / nn; CEIC.y = cy / nn; CEIC.z = cz / nn; }"
  print "  if (getenv(\"CEI_SRC\")) { NSRC = sscanf(getenv(\"CEI_SRC\"), \"%d,%d\", &SRC[0], &SRC[1]); if (NSRC < 1) { fprintf(stderr, \"CEI_SRC must be p or p,q\\n\"); return 1; } }"
  print "  if (getenv(\"CEI_KSELF\")) KSELF = atoi(getenv(\"CEI_KSELF\"));"
  print "  if (CEI || NSRC) setvbuf(stdout, NULL, _IONBF, 0);   /* cei: unbuffered, so a run that dies leaves its last line (the plain runs stay as the record's) */"
  print; HIT["env"]++; next }
/^  build\(\); slots\(\);/ {
  print "  if (getenv(\"CEI_STRIP\")) { STRIPK = atoi(getenv(\"CEI_STRIP\")); if (STRIPK < 2 || !PLANAR || CEI < 1) { fprintf(stderr, \"CEI_STRIP=K needs K >= 2, the planar object and CEI_SUBST=1 or CEI_DROPLOOPS=1\\n\"); return 1; } }"
  print "  if (STRIPK) cei_build_strip(); else build(); if (CEI == 2) cei_substitute(); else if (CEI == 1) cei_drop_loops(); slots();"
  print "  if (getenv(\"CEI_ORDER\")) cei_read_order(getenv(\"CEI_ORDER\"));"
  print "  if (getenv(\"CEI_SELF\")) cei_read_self(getenv(\"CEI_SELF\"));"
  print "  if (NSRC) for (int i = 0; i < NSRC; i++) if (SRC[i] < 0 || SRC[i] >= NP) { fprintf(stderr, \"CEI_SRC: plaquette %d outside 0..%d\\n\", SRC[i], NP - 1); return 1; }"
  HIT["build"]++; next }
index($0, "a link with neither four nor five staples") && index($0, "if (nother)") { sub(/if \(nother\)/, "if (nother) if (!CEI)"); print; HIT["nother"]++; next }
/^  else if \(strcmp\(datum, "ordered"\) && strcmp\(datum, "free"\)\) \{ fprintf\(stderr, "unknown datum %s\\n", datum\); return 1; \}/ {
  # the datum from a file (campaign 31.14): "file:<path>" -- the exterior's values as the engine's own outside-link list, so a cubature over the
  # exterior's Gaussian marginal is a loop of datum readings
  print "  else if (!strncmp(datum, \"file:\", 5)) cei_read_datum(datum + 5, DATA);"
  print; HIT["datum"]++; next }
# THE CLAMP (campaign 31.13, lead 2): with one cycle's spin fixed at CLAMPS (and two of its wires fixed through FIXV), process() keeps only the
# state blocks and the closing terms at that spin; the slices are summed by the driver -- an exact rearrangement of the sum
/^    int spin\[MAXCYC\]; for \(int c = 0; c < NCYC; c\+\+\) spin\[c\] = ISLOOP\[c\] \? LSPIN\[c\] : -1;$/ {
  # a clamped cycle whose every wire is fixed never opens and never closes through the state: its spin is the slice's wherever a step reads
  # it, and its closing weight is applied once by the driver (the two sites: process() and gather_state(), the latter idle in cei mode)
  print $0 " if (CLAMPC >= 0) spin[CLAMPC] = CLAMPS;"; HIT["spin"]++; next }
/^    int ndim\[128\]; size_t nsize = 1; for \(int w = 0; w < N\.nopen; w\+\+\)/ {
  print "    if (CLAMPC >= 0) if (in_list(CLAMPC, N.cyc, N.ncyc) >= 0) if (spin[CLAMPC] != CLAMPS) continue;   /* cei: the clamped cycle's other spins are the other slices' */"
  print; HIT["nfilter"]++; next }
/^      if \(fw == 0\) continue;$/ {
  print "      if (fw == 0) continue; if (CLAMPC >= 0) if (in_list(CLAMPC, closed, nclosed) >= 0) if (spin[CLAMPC] != CLAMPS) continue;   /* cei: the clamped cycle closes at its slice's spin alone */"
  HIT["cfilter"]++; next }
/^  int deg = 0; for \(int l = 0; l < NL; l\+\+\) \{ int d = NSTAP\[l\] \* WMAX;/ { sub(/int d = NSTAP\[l\] \* WMAX;/, "int d = (NSTAP[l] + NISTAP[l]) * WMAX; if (SELFON) d = KSELF * ((NSTAP[l] > 0) + (NISTAP[l] > 0));   /* cei: the partner's inverse staples raise its degree; a self-energy weight has degree KSELF */"); print; HIT["degree"]++; next }
/^  for \(int l = 0; l < NL; l\+\+\) link_tensor\(l, DATA\);/ { print "  cei_gauges(DATA);   /* the multi-vertex gauge door (campaign 32 CORRECTION): CEI_GAUGES applied before the link tensors are built from the datum */"; print "  for (int l = 0; l < NL; l++) if (!ELIM[l]) link_tensor(l, DATA);"; HIT["tensors"]++; next }
/^  int wAin = win\(LOOPA, 0\), wAout = wout\(LOOPA, NSTEP\[LOOPA\] - 1\)/ { emit(DRIVER); print; HIT["driver"]++; next }
{ print }
END { n = 0; for (k in HIT) n++; printf "CEI-INSERT anchors hit: %d of 16 (decl %d funcs %d stepmult %d corner %d staples %d pfac %d env %d build %d nother %d datum %d spin %d nfilter %d cfilter %d degree %d tensors %d driver %d)\n", n, HIT["decl"], HIT["funcs"], HIT["stepmult"], HIT["corner"], HIT["staples"], HIT["pfac"], HIT["env"], HIT["build"], HIT["nother"], HIT["datum"], HIT["spin"], HIT["nfilter"], HIT["cfilter"], HIT["degree"], HIT["tensors"], HIT["driver"] > "/dev/stderr" }
