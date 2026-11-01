# cut_patch.awk -- boxenum_seed.c gains the cut-formula road (cut_reader.c), BOX_MAX6 (links of multiplicity six admitted by the odd
# rule), the two-road comparison on every 2/4-link leaf and the six-link census.  Exits 3 unless every site was found once.
{
  if ($0 ~ /^static int NO4 = 0;/) { print; print "static int MAXM = 4;   /* BOX_MAX6: the odd rule may raise a link to multiplicity six */"; h1++; next }
  if (index($0, "if (mult[L4[a]] >= (NO4 ? 2 : 4)) ok = 0;") > 0) { sub(/\(NO4 \? 2 : 4\)/, "(NO4 ? 2 : MAXM)"); print; h2++; next }
  if ($0 ~ /^  if \(getenv\("BOX_NO4"\)\) NO4 = 1;$/) { print; print "  if (getenv(\"BOX_MAX6\")) MAXM = 6;"; h3++; next }
  if ($0 ~ /^\/\* ---- the census \*\/$/) {
    print "#include \"cut_reader.c\""
    print "static long long ctok = 0, ctref[5] = {0}, six[MAXF] = {0}, sixmin[MAXF] = {0}, sixviol = 0, sixshown = 0, tr_tests = 0, tr_fails = 0, tr_shown = 0, tm_tests = 0, tm_fails = 0, tm_shown = 0; static double sixmax[MAXF] = {0};"
    print; h4++; next }
  if ($0 ~ /^  reading_t r = resolve_P\(\); if \(r.n4 < 0\) return; if \(r.nres < 0\) \{ unread\+\+; return; \}$/) {
    print "  reading_t r = resolve_P(); cut_t ct = cut_P();"
    print "  if (ct.ok == 1) { ctok++; if (ct.n6 > 0) { six[F]++; if (ct.minimal) { sixmin[F]++; double a = fabs(ct.S); if (a > sixmax[F]) sixmax[F] = a;"
    print "        if (a > 4 + 1e-9) { sixviol++; printf(\"SIX-LEAF F=%d contacts=%d six-links=%d r=%d pieces=%d chi_cut=%d circles=%d I=%lld S_cut=%.10g THE-SEXTUPLE-VIOLATION plaquettes:\", F, ct.nc, ct.n6, ct.r, ct.m, ct.chi, ct.nb, ct.I, ct.S); for (int i = 0; i < F; i++) { long s = P[i] / NPAIR; int k = (int)(P[i] % NPAIR); int x[4]; coords(s, x); printf(\" (%d,%d,%d,%d)%d%d\", x[0], x[1], x[2], x[3], PMU[k] + 1, PNU[k] + 1); } printf(\"\\n\"); fflush(stdout); }"
    print "        else if (sixshown++ < 10) { printf(\"SIX-LEAF F=%d contacts=%d six-links=%d r=%d pieces=%d chi_cut=%d circles=%d I=%lld S_cut=%.10g minimal plaquettes:\", F, ct.nc, ct.n6, ct.r, ct.m, ct.chi, ct.nb, ct.I, ct.S); for (int i = 0; i < F; i++) { long s = P[i] / NPAIR; int k = (int)(P[i] % NPAIR); int x[4]; coords(s, x); printf(\" (%d,%d,%d,%d)%d%d\", x[0], x[1], x[2], x[3], PMU[k] + 1, PNU[k] + 1); } printf(\"\\n\"); fflush(stdout); } } } }"
    print "  else { int c = -ct.ok; ctref[c < 5 ? c : 4]++; }"
    print "  if (r.n4 < 0) return; if (r.nres < 0) { unread++; return; }"
    print "  if (ct.ok == 1) { int rmin = (r.conn == r.nres); tr_tests++; if (fabs(r.S - ct.S) > 1e-9 * (1 + fabs(r.S))) { tr_fails++; if (tr_shown++ < 10) printf(\"TWO-ROAD-PART F=%d N4=%d S_res=%.10g S_cut=%.10g chi_cut=%d circles=%d I=%lld r=%d pieces=%d nonorientable=%d\\n\", F, r.n4, r.S, ct.S, ct.chi, ct.nb, ct.I, ct.r, ct.m, ct.nonor); }"
    print "    tm_tests++; if (rmin != ct.minimal) { tm_fails++; if (tm_shown++ < 10) printf(\"TWO-ROAD-MINIMALITY-PART F=%d N4=%d resolutions-connected=%d rank-criterion=%d\\n\", F, r.n4, rmin, ct.minimal); } }"
    h5++; next }
  if ($0 ~ /^  printf\("# minimal leaves whose contact links hold a LATTICE cycle/) {
    print
    print "  printf(\"# THE CUT FORMULA AS THE SECOND ROAD: %lld leaves read (refused: %lld bad multiplicity, %lld boundary degree, %lld cycle rank >= 2, %lld no chord); against the resolution formula on the 2/4-link leaves: %lld compared, %lld PARTED; minimality (resolutions connected vs the rank criterion): %lld compared, %lld PARTED\\n\", ctok, ctref[1], ctref[2], ctref[3], ctref[4], tr_tests, tr_fails, tm_tests, tm_fails);"
    print "  printf(\"# SIX-FOLD LINKS (read by the cut formula alone; admitted by the odd rule under BOX_MAX6=%d): F leaves minimal max|S|(minimal)\\n\", MAXM == 6);"
    print "  for (int f = 1; f <= FMAX; f++) if (six[f]) printf(\"%2d %10lld %10lld %.6g\\n\", f, six[f], sixmin[f], sixmax[f]);"
    print "  printf(\"# minimal leaves with a six-fold link and |S| > 4 (THE SEXTUPLE VIOLATION of S12's bound): %lld\\n\", sixviol);"
    h6++; next }
  print
}
END { if (h1 != 1 || h2 != 1 || h3 != 1 || h4 != 1 || h5 != 1 || h6 != 1) { print "CUT PATCH FAILED: sites " h1+0 " " h2+0 " " h3+0 " " h4+0 " " h5+0 " " h6+0 > "/dev/stderr"; exit 3 } }
