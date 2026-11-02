# moves the TILT line of bessel_table() after the COEF block (so the tilt multiplies the supplied coefficients); everything else verbatim
/^  if \(TILTN > 0\) \{ tl = exp_lo/ { held = $0; next }
/^  if \(HALFN > 0\) \{ AL\[1\]/ { if (held == "") { print "PATCH FAILED: no tilt line held" > "/dev/stderr"; exit 3 } print held; print; done = 1; next }
{ print }
END { if (!done) { print "PATCH FAILED: no HALF line" > "/dev/stderr"; exit 3 } }
