# seed_patch.awk -- boxenum.c gains (1) a SEED: the environment variable BOX_SEED, plaquette tokens "(x,y,z,t)ab" in the record format,
# planted in place of the corner plaquette (the odd rule then closes what the seed leaves odd); (2) BOX_NO4=1: every link outside the
# seed's four-links is held at multiplicity <= 2 (a plaquette that would make a third passage at any link is refused), so no contact
# can form beyond the seed's; (3) every minimal leaf with a cycle on the sheet (b1max >= 1) is printed.  Lines are matched by their
# exact text at HEAD's boxenum.c (the lattice-column version); the patch exits 3 unless every site was found once.
{
  if ($0 ~ /^    long L4\[4\]; plaq_links\(q, L4\); int ok = 1; for \(int a = 0; a < 4; a\+\+\) if \(mult\[L4\[a\]\] >= 4\) ok = 0; if \(!ok\) continue;$/) {
    print "    long L4[4]; plaq_links(q, L4); int ok = 1; for (int a = 0; a < 4; a++) if (mult[L4[a]] >= (NO4 ? 2 : 4)) ok = 0; if (!ok) continue;"; hit1++; next }
  if ($0 ~ /^static long P\[MAXF\]; static int F = 0; static long oddL\[1024\]; static int nodd = 0;$/) {
    print; print "static int NO4 = 0;   /* BOX_NO4: every link beyond the seed's four-links held at multiplicity <= 2 */"; hit2++; next }
  if ($0 ~ /^  inP\[p0\] = 1; P\[F\+\+\] = p0; \{ long L4\[4\]; plaq_links\(p0, L4\); for \(int a = 0; a < 4; a\+\+\) \{ mult\[L4\[a\]\] = 1; add_odd\(L4\[a\]\); \} \}$/) {
    print "  if (getenv(\"BOX_NO4\")) NO4 = 1;"
    print "  if (getenv(\"BOX_SEED\")) {   /* THE SEED: plaquette tokens (x,y,z,t)ab, the record format, in place of the corner plaquette */"
    print "    char *sd = strdup(getenv(\"BOX_SEED\")); int ns = 0; for (char *tok = strtok(sd, \" \\t\\n\"); tok; tok = strtok(NULL, \" \\t\\n\")) { int b[4], a, c;"
    print "      if (sscanf(tok, \"(%d,%d,%d,%d)%1d%1d\", &b[0], &b[1], &b[2], &b[3], &a, &c) != 6 || a < 1 || a > 4 || c < 1 || c > 4 || a >= c) { fprintf(stderr, \"bad seed token %s\\n\", tok); return 1; }"
    print "      long s = site_of(b); long q = plaq_id(s, pair_index(a - 1, c - 1)); if (!in_box(q)) { fprintf(stderr, \"seed plaquette %s outside the box\\n\", tok); return 1; } if (inP[q]) { fprintf(stderr, \"seed plaquette %s twice\\n\", tok); return 1; }"
    print "      inP[q] = 1; P[F++] = q; long L4[4]; plaq_links(q, L4); for (int k = 0; k < 4; k++) { int was = mult[L4[k]] & 1; mult[L4[k]]++; int now = mult[L4[k]] & 1; if (was && !now) del_odd(L4[k]); else if (!was && now) add_odd(L4[k]); } ns++; }"
    print "    int n4s = 0, over = 0; for (long l = 0; l < NS * D; l++) { if (mult[l] == 4) n4s++; else if (mult[l] > 4 || mult[l] == 3) over++; }"
    print "    printf(\"# SEED: %d plaquettes planted, %d odd links, %d four-links, %d links at three or above four%s; BOX_NO4=%d\\n\", ns, nodd, n4s, over, over ? \" (REFUSED)\" : \"\", NO4); if (over) return 4; if (ns == 0) { fprintf(stderr, \"empty seed\\n\"); return 1; } }"
    print "  else { inP[p0] = 1; P[F++] = p0; { long L4[4]; plaq_links(p0, L4); for (int a = 0; a < 4; a++) { mult[L4[a]] = 1; add_odd(L4[a]); } } }"
    hit3++; next }
  if ($0 ~ /^  if \(strong \|\| r.b1max >= 2 \|\| r.b1lat >= 1 \|\|/) { sub(/r.b1max >= 2 \|\| r.b1lat >= 1 \|\|/, "r.b1max >= 1 || r.b1lat >= 1 ||"); print; hit4++; next }
  print
}
END { if (hit1 != 1 || hit2 != 1 || hit3 != 1 || hit4 != 1) { print "SEED PATCH FAILED: sites " hit1+0 " " hit2+0 " " hit3+0 " " hit4+0 > "/dev/stderr"; exit 3 } }
