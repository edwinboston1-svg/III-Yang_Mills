# lp_check.awk: Proposition LP's dual inequality over the record's even-star table, exact in integers.
# Dual feasibility of (y, lambda) = (7/12, 7/24):  d/16 + a/12 <= 7/6 + ([G] + [G6])/2, multiplied by 48:
#   3d + 4a <= 56 + 24([G] + [G6]).  slack := 56 + 24([G]+[G6]) - 3d - 4a  (an integer; must be >= 0).
# Also prints K = d - 2a + 4 and beta2 := 2*beta = n4 + 2 n6 - [G] - [G6] for the equality orbits.
{
  if ($0 ~ /^#/) next
  d = ""; deg = ""; orb = ""
  for (i = 1; i <= NF; i++) {
    split($i, kv, "=")
    if (kv[1] == "E") d = kv[2] + 0
    if (kv[1] == "deg") deg = kv[2]
    if (kv[1] == "orbit") orb = kv[2] + 0
  }
  if (d == 0) { nzero++; next }            # the empty star: not a vertex of X
  a = 0; n4 = 0; n6 = 0; sumdeg = 0
  for (k = 1; k <= length(deg); k++) {
    c = substr(deg, k, 1) + 0
    if (c > 0) a++
    if (c == 4) n4++
    if (c == 6) n6++
    if (c % 2 == 1) { bad++ }
    sumdeg += c
  }
  if (sumdeg != 2 * d) { inconsistent++ }
  if (d != a + n4 + 2 * n6) { idfail++ }
  g = (n4 + n6 >= 1) ? 1 : 0; g6 = (n6 >= 1) ? 1 : 0
  slack = 56 + 24 * (g + g6) - 3 * d - 4 * a
  rows++; members += orb
  if (slack < 0) { viol++; print "VIOLATION deg=" deg " d=" d " a=" a " slack=" slack }
  if (slack == 0) {
    eq++; eqm += orb
    printf "EQUALITY deg=%s d=%d a=%d n4=%d n6=%d K=%d beta2=%d orbit=%d\n", deg, d, a, n4, n6, d - 2*a + 4, n4 + 2*n6 - g - g6, orb
  }
  if (slack < minslack_nonzero || minslack_nonzero == "") if (slack > 0) minslack_nonzero = slack
}
END {
  printf "LP-CHECK rows=%d (empty star skipped: %d) members=%d odd-degree=%d degree-sum-mismatch=%d identity d=a+n4+2n6 fails=%d\n", rows, nzero, members, bad + 0, inconsistent + 0, idfail + 0
  printf "LP-CHECK violations=%d equality-orbits=%d equality-members=%d smallest-positive-slack=%d/48\n", viol + 0, eq + 0, eqm + 0, minslack_nonzero
}
