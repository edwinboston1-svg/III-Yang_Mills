# wprim_patch.awk -- boxenum_cut6.c gains cut_reader_w.c (the Weingarten step at every cycle rank, the primitivity column), the
# r = 1 self-check of the two integrals, the primitivity census cross-tabbed with the census law, and the rank >= 2 leaves printed.
{
  if ($0 ~ /^#include "cut_reader.c"$/) { print "#include \"cut_reader_w.c\""; h1++; next }
  if ($0 ~ /^static long long ctok = 0, ctref\[5\] = \{0\},/) { print; print "static long long wg_tests = 0, wg_fails = 0, pr_tests = 0, pr_cells[2][2] = {{0,0},{0,0}}, r2_min = 0, r2_shown = 0, pr_shown = 0;"; h2++; next }
  if ($0 ~ /^  if \(ct.ok == 1\) \{ int rmin = \(r.conn == r.nres\); tr_tests\+\+;/) {
    print
    print "  if (ct.ok == 1 && ct.r == 1 && ct.wg_ok == 1) { wg_tests++; if (ct.wg_agree != 1) { wg_fails++; printf(\"WEINGARTEN-PART F=%d r=1 character-road I=%lld weingarten %lld/%lld\\n\", F, ct.I, ct.wN, ct.wD); } }"
    print "  if (ct.ok == 1 && ct.r >= 1 && r.conn == r.nres && ct.prim >= 0) { int law = fabs(r.S - pow(2.0, r.chimax)) <= 1e-9 * (1 + fabs(r.S)); pr_tests++; pr_cells[ct.prim][law]++;"
    print "    if (ct.r >= 2) { r2_min++; if (r2_shown++ < 20) { printf(\"RANK-LEAF F=%d N4=%d r=%d pieces=%d chi_cut=%d circles=%d I=%lld/%lld S_cut=%.10g S_res=%.10g chimax=%d %s words=%d minlen=%d plaquettes:\", F, r.n4, ct.r, ct.m, ct.chi, ct.nb, ct.wN, ct.wD, ct.S, r.S, r.chimax, ct.prim ? \"PRIMITIVE\" : \"NOT-PRIMITIVE\", ct.nwords, ct.minlen); for (int i = 0; i < F; i++) { long s = P[i] / NPAIR; int k = (int)(P[i] % NPAIR); int x[4]; coords(s, x); printf(\" (%d,%d,%d,%d)%d%d\", x[0], x[1], x[2], x[3], PMU[k] + 1, PNU[k] + 1); } printf(\"\\n\"); fflush(stdout); } }"
    print "    if (!ct.prim && pr_shown++ < 20) { printf(\"NOT-PRIMITIVE-LEAF F=%d N4=%d r=%d pieces=%d S_res=%.10g chimax=%d words=%d minlen=%d%s\\n\", F, r.n4, ct.r, ct.m, r.S, r.chimax, ct.nwords, ct.minlen, law ? \" (the census law holds)\" : \" (THE CENSUS LAW FAILS)\"); fflush(stdout); } }"
    h3++; next }
  if ($0 ~ /^  printf\("# minimal leaves with a six-fold link and \|S\| > 4/) {
    print
    print "  printf(\"# THE WEINGARTEN STEP against the character road at cycle rank one: %lld compared, %lld PARTED; THE PRIMITIVITY COLUMN on the minimal leaves with a contact cycle: %lld read -- PRIMITIVE and S = 2^chi_max %lld, PRIMITIVE and S != 2^chi_max %lld, NOT-PRIMITIVE and S = 2^chi_max %lld, NOT-PRIMITIVE and S != 2^chi_max %lld; minimal leaves of cycle rank >= 2 read by both roads: %lld\\n\", wg_tests, wg_fails, pr_tests, pr_cells[1][1], pr_cells[1][0], pr_cells[0][1], pr_cells[0][0], r2_min);"
    h4++; next }
  print
}
END { if (h1 != 1 || h2 != 1 || h3 != 1 || h4 != 1) { print "WPRIM PATCH FAILED: sites " h1+0 " " h2+0 " " h3+0 " " h4+0 > "/dev/stderr"; exit 3 } }
