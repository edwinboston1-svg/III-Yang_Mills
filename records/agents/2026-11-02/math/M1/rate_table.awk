# rate_table.awk: the reader's per-star number r(G) = 2^{a/2-1} sqrt(S_1/2) = e 2^{-n4/2-n6} and its per-plaquette rate
# r^{4/E}, over the record's 560 even-star orbits. r^2 = e2 2^{-n4-2n6} is an exact rational p/q; the rate is ranked in
# floating point, and the comparison with 2^{2/3} is decided EXACTLY: r^{4/E} >= 2^{2/3} <=> (p/q)^3 >= 2^E <=> p^3 >= 2^E q^3.
{
  if ($0 ~ /^#/) next
  E = 0; deg = ""; e2 = ""
  for (i = 1; i <= NF; i++) { split($i, kv, "="); if (kv[1] == "E") E = kv[2] + 0; if (kv[1] == "deg") deg = kv[2]; if (kv[1] == "e2") e2 = kv[2]; if (kv[1] == "orbit") orb = kv[2] + 0 }
  if (E == 0) next
  a = 0; n4 = 0; n6 = 0
  for (k = 1; k <= length(deg); k++) { c = substr(deg, k, 1) + 0; if (c > 0) a++; if (c == 4) n4++; if (c == 6) n6++ }
  if (index(e2, "/")) { split(e2, fr, "/"); p = fr[1] + 0; q = fr[2] + 0 } else { p = e2 + 0; q = 1 }
  q = q * 2^(n4 + 2 * n6)                         # r^2 = p/q
  lhs = p^3; rhs = 2^E * q^3
  cmp = (lhs > rhs) ? "ABOVE" : ((lhs == rhs) ? "EQUAL" : "below")
  rate = exp((2.0 / E) * log(p / q))
  nrow++; if (cmp == "ABOVE") nab++; if (cmp == "EQUAL") neq++
  printf "%.6f %s r=%.6f deg=%s E=%d a=%d n4=%d n6=%d orbit=%d\n", rate, cmp, sqrt(p / q), deg, E, a, n4, n6, orb > "rate_table.sorted.tmp"
}
END {
  close("rate_table.sorted.tmp")
  printf "RATE-TABLE rows=%d; r^{4/E} vs 2^{2/3} decided exactly: ABOVE %d, EQUAL %d\n", nrow, nab + 0, neq + 0
}
