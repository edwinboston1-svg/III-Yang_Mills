# fibre_time_quad.awk -- ΟΛΟΚΛΗΡΩΣΙΣ ADDENDUM II, the reading S-B1's refutation forced: the fibre's UNSTAGGERED poles (positive z) and
# its STAGGERED poles (negative z) read EXACTLY as integer cosh values -- for every FP-COEFFS line (det C over z) the quadratics
# z^2 - 2c z + 1 (a positive-z pole at cosh kappa = c) and z^2 + 2c z + 1 (a negative-z pole) are divided out synthetically for c = 2..400;
# for every FP3-COSHPOLY line (F over v = z + 1/z) the linear factors (v - 2c) and (v + 2c) likewise.  Exact in gawk -M; a pole whose cosh
# is NOT an integer <= 400 is not reported here (the zero itself is in fibre_time's brackets).  usage: gawk -M -f fibre_time_quad.awk FP FP3
function readcoeffs(s,   n, i, A) { n = split(s, A, ","); for (i = 1; i <= n; i++) CF[i - 1] = A[i] + 0; return n - 1 }
# does z^2 + b z + 1 divide CF[0..n]?  synthetic division, exact
function divq(n, b,   k, t) { for (k = 0; k <= n; k++) Q[k] = CF[k]; for (k = n; k >= 2; k--) { t = Q[k]; Q[k] = 0; Q[k - 1] -= b * t; Q[k - 2] -= t } return (Q[0] == 0 && Q[1] == 0) }
# does (v - r) divide CF[0..n]?  Horner at r
function divl(n, r,   k, acc) { acc = 0; for (k = n; k >= 0; k--) acc = acc * r + CF[k]; return (acc == 0) }
/^FP-COEFFS / { cell = $2 " " $3; s = $0; sub(/.*coefficients=/, "", s); n = readcoeffs(s); pl = ""; nl = ""
  for (c = 2; c <= 400; c++) { if (divq(n, 0 - 2 * c)) pl = pl (pl == "" ? "" : ",") c; if (divq(n, 2 * c)) nl = nl (nl == "" ? "" : ",") c }
  printf "FTQ-CELL record=FP %s unstaggered-integer-cosh=%s staggered-integer-cosh=%s\n", cell, (pl == "" ? "none" : pl), (nl == "" ? "none" : nl) }
/^FP3-COSHPOLY / { cell = $2 " " $3 " " $4 " " $5; s = $0; sub(/.*coefficients\(v=z\+1\/z=-2cosh\)=/, "", s); n = readcoeffs(s); pl = ""; nl = ""
  for (c = 2; c <= 400; c++) { if (divl(n, 2 * c)) pl = pl (pl == "" ? "" : ",") c; if (divl(n, 0 - 2 * c)) nl = nl (nl == "" ? "" : ",") c }
  printf "FTQ-CELL record=FP3 %s unstaggered-integer-cosh=%s staggered-integer-cosh=%s\n", cell, (pl == "" ? "none" : pl), (nl == "" ? "none" : nl) }
