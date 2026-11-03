# holoklerosis_cert.awk -- ΟΛΟΚΛΗΡΩΣΙΣ Ο6, ONE CERTIFICATE DOOR: INERTIA and DOMINANCE decided EXACTLY on rationals, a library a stranger
# runs with gawk -M and nothing else (no III, no Perl, no numpy, no float).  Page DOCS/III-HOLOKLEROSIS-THE-COMPLETION-PREREGISTRATION.md
# (e6c1349a9), Ο6.  The two verbs the crossing's certificates need: a Dobrushin row "C v <= (1 - eta) v" (the decider's output, §28.3 of
# the crossing page) and a signature (the convexity and the Weil ladder: Ο12).
#   INERTIA    a symmetric matrix of rationals -> (n+, n-, n0) by the exact LDL^T with 1 x 1 pivots on a nonzero diagonal and 2 x 2 pivots
#              [[0, a], [a, 0]] where every remaining diagonal is zero (Sylvester's law: the signature is a congruence invariant, and every
#              step is a rational congruence); a non-symmetric input is REFUSED by name.
#   DOMINANCE  C (n x n, entries >= 0), v (n, entries > 0), eta (0 < eta < 1): every row's  sum_j C_ij v_j <= (1 - eta) v_i  decided by
#              cross-multiplication; the first violating row named.  Consequence (Collatz-Wielandt, quoted): rho(C) <= 1 - eta.
# Rationals are "n/d" strings with d > 0, reduced; integers are read as "n/1".  gawk traps honoured: 0 - x never -x; arrays named past
# the builtins; the library's load KAT runs in BEGIN of the including program by cert_kat() and REFUSES TO SERVE on a miss (exit 3), as
# dokimasia.sh does.
# usage as a program:  gawk -M -v VERB=INERTIA   -f holoklerosis_cert.awk matrix.txt         (n rows of n rationals)
#                      gawk -M -v VERB=DOMINANCE -f holoklerosis_cert.awk cert.txt           (n rows of C; a line "v a b c ..."; a line "eta p/q")
# usage as a library:  @include "holoklerosis_cert.awk"; cert_kat(); then cert_inertia(n) on CA[i,j] (strings) -> sets CERT_P, CERT_M, CERT_Z
function cgcd(a, b,   t) { if (a < 0) a = 0 - a; if (b < 0) b = 0 - b; while (b != 0) { t = a % b; a = b; b = t } return a }
function cmk(n, d,   g) { if (d == 0) { CERT_ERR = "division by zero"; return "0/0" } if (d < 0) { n = 0 - n; d = 0 - d } g = cgcd(n, d); if (g == 0) g = 1; return (n / g) "/" (d / g) }
function cq(s,   i) { if (s ~ /^-?[0-9]+$/) return s "/1"; i = index(s, "/"); if (i == 0) { CERT_ERR = "not a rational: " s; return "0/1" } return cmk(substr(s, 1, i - 1) + 0, substr(s, i + 1) + 0) }
function cn(r) { return substr(r, 1, index(r, "/") - 1) + 0 }
function cd(r) { return substr(r, index(r, "/") + 1) + 0 }
function cadd(a, b) { return cmk(cn(a) * cd(b) + cn(b) * cd(a), cd(a) * cd(b)) }
function csub(a, b) { return cmk(cn(a) * cd(b) - cn(b) * cd(a), cd(a) * cd(b)) }
function cmul(a, b) { return cmk(cn(a) * cn(b), cd(a) * cd(b)) }
function cdiv(a, b) { return cmk(cn(a) * cd(b), cd(a) * cn(b)) }
function csgn(a) { return (cn(a) > 0) ? 1 : (cn(a) < 0) ? -1 : 0 }
function cle(a, b) { return (cn(a) * cd(b) <= cn(b) * cd(a)) }     # a <= b
function clt(a, b) { return (cn(a) * cd(b) < cn(b) * cd(a)) }      # a < b
# ---- INERTIA on CA[0..n-1, 0..n-1] (destroyed); symmetric pivoting; sets CERT_P, CERT_M, CERT_Z; returns 0 on success, 1 on a refusal
function cert_inertia(n,   i, j, k, p, r, c, t, a, b, d, det2, inv, l1, l2, s, A, B, C, x, y) {
  CERT_P = 0; CERT_M = 0; CERT_Z = 0; CERT_ERR = ""
  for (i = 0; i < n; i++) for (j = 0; j < i; j++) if (CA[i, j] != CA[j, i]) { CERT_ERR = "not symmetric at (" i "," j ")"; return 1 }
  k = 0
  while (k < n) {
    # a nonzero diagonal among k..n-1?
    p = -1; for (i = k; i < n; i++) if (csgn(CA[i, i]) != 0) { p = i; break }
    if (p >= 0) {
      if (p != k) { for (j = 0; j < n; j++) { t = CA[k, j]; CA[k, j] = CA[p, j]; CA[p, j] = t } for (i = 0; i < n; i++) { t = CA[i, k]; CA[i, k] = CA[i, p]; CA[i, p] = t } }
      d = CA[k, k]; if (csgn(d) > 0) CERT_P++; else CERT_M++
      for (i = k + 1; i < n; i++) { if (csgn(CA[i, k]) == 0) continue; l1 = cdiv(CA[i, k], d)
        for (j = k + 1; j < n; j++) CA[i, j] = csub(CA[i, j], cmul(l1, CA[k, j])) }
      for (i = k + 1; i < n; i++) { CA[i, k] = "0/1"; CA[k, i] = "0/1" }
      k++; continue }
    # every remaining diagonal is zero: a nonzero off-diagonal gives a 2 x 2 pivot [[0, a], [a, 0]] of signature (1, 1)
    r = -1; c = -1
    for (i = k; i < n && r < 0; i++) for (j = i + 1; j < n; j++) if (csgn(CA[i, j]) != 0) { r = i; c = j; break }
    if (r < 0) { CERT_Z += n - k; return 0 }   # the rest is the zero matrix
    # move rows/cols r -> k, c -> k+1
    if (r != k) { for (j = 0; j < n; j++) { t = CA[k, j]; CA[k, j] = CA[r, j]; CA[r, j] = t } for (i = 0; i < n; i++) { t = CA[i, k]; CA[i, k] = CA[i, r]; CA[i, r] = t } if (c == k) c = r }
    if (c != k + 1) { for (j = 0; j < n; j++) { t = CA[k + 1, j]; CA[k + 1, j] = CA[c, j]; CA[c, j] = t } for (i = 0; i < n; i++) { t = CA[i, k + 1]; CA[i, k + 1] = CA[i, c]; CA[i, c] = t } }
    a = CA[k, k + 1]   # the pivot block [[0, a], [a, 0]]; its inverse [[0, 1/a], [1/a, 0]]; the Schur complement S = A - B P^{-1} B^T
    inv = cdiv("1/1", a)
    for (i = k + 2; i < n; i++) { x = CA[i, k]; y = CA[i, k + 1]     # B's row i = (x, y); (B P^-1)_i = (y/a, x/a)
      for (j = k + 2; j < n; j++) CA[i, j] = csub(CA[i, j], cadd(cmul(cmul(y, inv), CA[k, j]), cmul(cmul(x, inv), CA[k + 1, j]))) }
    for (i = k + 2; i < n; i++) { CA[i, k] = "0/1"; CA[k, i] = "0/1"; CA[i, k + 1] = "0/1"; CA[k + 1, i] = "0/1" }
    CERT_P++; CERT_M++; k += 2
  }
  return 0
}
# ---- DOMINANCE on CC[0..n-1,0..n-1], CV[0..n-1], CETA; sets CERT_ROW (-1 if certified) and CERT_LHS, CERT_RHS of the violating row
function cert_dominance(n,   i, j, s, rhs, one) {
  CERT_ERR = ""; CERT_ROW = -1; one = csub("1/1", CETA)
  if (!(clt("0/1", CETA) && clt(CETA, "1/1"))) { CERT_ERR = "eta outside (0, 1)"; return 1 }
  for (i = 0; i < n; i++) { if (!clt("0/1", CV[i])) { CERT_ERR = "v not positive at " i; return 1 }
    for (j = 0; j < n; j++) if (csgn(CC[i, j]) < 0) { CERT_ERR = "C negative at (" i "," j ")"; return 1 } }
  for (i = 0; i < n; i++) { s = "0/1"; for (j = 0; j < n; j++) s = cadd(s, cmul(CC[i, j], CV[j])); rhs = cmul(one, CV[i])
    if (!cle(s, rhs)) { CERT_ROW = i; CERT_LHS = s; CERT_RHS = rhs; return 0 } }
  return 0
}
# ---- the load KAT: known signatures and a known dominance pair, two-sided; a miss refuses the library (exit 3)
function cert_kat_set(n, s,   i, j, k, parts) { k = split(s, parts, " "); for (i = 0; i < n; i++) for (j = 0; j < n; j++) CA[i, j] = cq(parts[i * n + j + 1]) }
function cert_kat(   bad) {
  bad = 0
  cert_kat_set(3, "1 0 0 0 1 0 0 0 1"); cert_inertia(3); if (!(CERT_P == 3 && CERT_M == 0 && CERT_Z == 0)) bad++
  cert_kat_set(2, "0 1 1 0"); cert_inertia(2); if (!(CERT_P == 1 && CERT_M == 1 && CERT_Z == 0)) bad++
  cert_kat_set(3, "1 0 0 0 -1 0 0 0 0"); cert_inertia(3); if (!(CERT_P == 1 && CERT_M == 1 && CERT_Z == 1)) bad++
  cert_kat_set(3, "2 1 0 1 2 1 0 1 -3"); cert_inertia(3); if (!(CERT_P == 2 && CERT_M == 1 && CERT_Z == 0)) bad++
  cert_kat_set(3, "0 0 1 0 0 0 1 0 0"); cert_inertia(3); if (!(CERT_P == 1 && CERT_M == 1 && CERT_Z == 1)) bad++
  cert_kat_set(2, "1/2 1/3 1/3 2/9"); cert_inertia(2); if (!(CERT_P == 1 && CERT_M == 0 && CERT_Z == 1)) bad++      # det 1/9 - 1/9 = 0
  cert_kat_set(2, "1 2 3 4"); if (cert_inertia(2) != 1) bad++                                                    # not symmetric: refused
  CC[0, 0] = "1/2"; CC[0, 1] = "1/4"; CC[1, 0] = "1/4"; CC[1, 1] = "1/2"; CV[0] = "1/1"; CV[1] = "1/1"
  CETA = "1/4"; cert_dominance(2); if (CERT_ROW != -1) bad++
  CETA = "1/2"; cert_dominance(2); if (CERT_ROW != 0) bad++
  CC[0, 1] = "-1/4"; CETA = "1/4"; if (cert_dominance(2) != 1) bad++
  if (bad) { printf "CERT-LIB-REFUSED: the load KAT misses %d of 10 -- the door will not serve\n", bad; exit 3 }
  return 0
}
function cert_sig() { return "(" CERT_P "," CERT_M "," CERT_Z ")" }
BEGIN { if (VERB != "") { cert_kat(); CERT_N = 0; CERT_MODE = VERB } }
VERB != "" && $0 ~ /^[ \t]*$/ { next }
VERB == "INERTIA" { if (CERT_N == 0) CERT_W = NF; if (NF != CERT_W) { print "CERT-REFUSED: a ragged row at line " NR; exit 2 } for (i = 1; i <= NF; i++) CA[CERT_N, i - 1] = cq($i); CERT_N++ }
VERB == "DOMINANCE" && $1 == "v" { for (i = 2; i <= NF; i++) CV[i - 2] = cq($i); CERT_NV = NF - 1; next }
VERB == "DOMINANCE" && $1 == "eta" { CETA = cq($2); next }
VERB == "DOMINANCE" { for (i = 1; i <= NF; i++) CC[CERT_N, i - 1] = cq($i); CERT_N++ }
END {
  if (VERB == "INERTIA") { if (CERT_N != CERT_W) { print "CERT-REFUSED: not square (" CERT_N " rows, " CERT_W " columns)"; exit 2 }
    if (cert_inertia(CERT_N) != 0) { print "CERT-REFUSED: " CERT_ERR; exit 2 }
    printf "CERT-INERTIA n=%d plus=%d minus=%d zero=%d signature=%s\n", CERT_N, CERT_P, CERT_M, CERT_Z, cert_sig() }
  else if (VERB == "DOMINANCE") { if (CERT_NV != CERT_N) { print "CERT-REFUSED: v has " CERT_NV " entries against " CERT_N " rows"; exit 2 }
    if (cert_dominance(CERT_N) != 0) { print "CERT-REFUSED: " CERT_ERR; exit 2 }
    if (CERT_ROW < 0) printf "CERT-DOMINANCE n=%d eta=%s verdict=CERTIFIED-ROW consequence=rho(C)<=1-eta\n", CERT_N, CETA
    else printf "CERT-DOMINANCE n=%d eta=%s verdict=ROW-VIOLATED row=%d lhs=%s rhs=%s\n", CERT_N, CETA, CERT_ROW, CERT_LHS, CERT_RHS }
}
