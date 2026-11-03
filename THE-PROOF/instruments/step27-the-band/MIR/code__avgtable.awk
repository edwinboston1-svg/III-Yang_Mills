# avgtable.awk -- the measure-weighted joint class table: the average over the typical data of the pinned class moments E[chi_a(A) chi_c(B) | w]
# (by the tower property the average is the TRUE joint class law of the two coarse loops, up to the plaquette truncation and Monte Carlo error);
# printed in the engine's own W2-CLASS format so w2_modes.awk reads it.  usage: gawk -f avgtable.awk full_W2L2_*.txt
/^W2-CLASS a=/ { a = substr($2, 3) + 0; c = substr($3, 3) + 0; S[a, c] += $7; Q[a, c] += $7 * $7; if (a > L) L = a; if (c > L) L = c }
/^W2-DONE/ { nf++ }
END { printf "W2-OBJECT planar n=4 AVERAGE over %d typical data (beta=2.2, W2L2)\n", nf
  for (a = 0; a <= L; a++) for (c = 0; c <= L; c++) { m = S[a, c] / nf; sd = sqrt(Q[a, c] / nf - m * m); printf "W2-CLASS a=%d c=%d E[chi_a(A) chi_c(B)] = %+.12e (sem %.3e)\n", a, c, m, sd / sqrt(nf) } }
