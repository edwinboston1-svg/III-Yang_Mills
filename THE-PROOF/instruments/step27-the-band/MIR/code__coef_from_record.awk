# reads the W2-CLASS a=k c=0 lines of a w2 record and prints the 16-entry COEF list a'_j = E[chi_j(A)]/d_j, each rounded UP at 10^-12
# (MODE=zero: spins >= 3/2 entered 0, as the records carry them; MODE=sat: the premise-saturating tail, each later entry the largest the
#  certificate's two refusals allow, times (1 - 10^-9) so the grid's own rounding cannot trip the refusal)
/^W2-CLASS a=[0-9]+ c=0 / { a = substr($2, 3) + 0; v = $7; E[a] = v }
END {
  D = 1000000000000
  for (j2 = 1; j2 <= 16; j2++) { if (j2 in E) { x = E[j2] / (j2 + 1); n = int(x * D); if (n < x * D) n++; if (n < 0) n = 0; N[j2] = n } else N[j2] = -1 }
  # exact rationals n/D for the read entries; the tail
  for (j2 = 1; j2 <= 16; j2++) {
    if (N[j2] >= 0) { Q[j2] = N[j2] ""; R[j2] = D "" ; continue }
    if (MODE != "sat") { Q[j2] = "0"; R[j2] = D ""; continue }
    # sat: a_{j2} = min(a_{j2-1}, a_{j2-2}/8) * (1 - 1e-9), as a rational: keep everything over D * 8^k * 10^9-ish -> use high-precision ints
    p = Q[j2-1] / R[j2-1]; q = Q[j2-2] / R[j2-2] / 8; m = (p < q) ? p : q; m = m * (1 - 1e-9)
    Q[j2] = sprintf("%d", int(m * 1e24)); R[j2] = "1000000000000000000000000" }
  s = ""; for (j2 = 1; j2 <= 16; j2++) s = s (j2 > 1 ? "," : "") Q[j2] "/" R[j2]; print s }
