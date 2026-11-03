# wrong_patch.awk -- the SIGHTED CONTROL's door: SU2MH_WRONG=1 integrates B's two corner horizontals in the bent pair as well, although each
# shares a (mu, rho) plaquette with A's corner horizontal -- an invalid multihit set; the MH-vs-plain test must convict it.
/^static int D, LS, NN;/ { print; print "static int WRONG = 0;"; next }
/iB\[nb\] = \(rho == mu \|\| i != 0\)/ { sub(/\(rho == mu \|\| i != 0\)/, "(WRONG || rho == mu || i != 0)") }
/iB\[nb\] = \(rho == mu \|\| i != n - 1\)/ { sub(/\(rho == mu \|\| i != n - 1\)/, "(WRONG || rho == mu || i != n - 1)") }
/int BENT = \(argc > 11/ { print; print "  WRONG = getenv(\"SU2MH_WRONG\") != NULL; if (WRONG) printf(\"SU2MH-WRONG: the bent pair's corner horizontals of B integrated too (an INVALID multihit set; the sighted control)\n\");"; next }
{ print }
