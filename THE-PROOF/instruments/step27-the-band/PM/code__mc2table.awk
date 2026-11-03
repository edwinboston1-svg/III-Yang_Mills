# mc2table.awk -- su2mh records (one or more files) -> the joint class table in w2_strip's W2-CLASS format, for w2_modes.awk.
# The MH channels (fields 12..20: MH[a][c], a-major), averaged over all configurations of all files; with -v SYM=1 the table is A<->B
# symmetrised, T[a][c] = (M[a][c] + M[c][a])/2 (Lemma D3: the true table is symmetric, so this halves the noise and changes no expectation);
# with -v B=<bin> -v DROP=<k> the k-th bin of B consecutive configurations (counted over the concatenated files) is left out -- the jackknife
# table.  usage: gawk [-v SYM=1] [-v B= -v DROP=] -f mc2table.awk rec1.txt rec2.txt ...
/^#/ { next }
NF >= 20 { nc++; if (B > 0 && DROP > 0 && int((nc - 1) / B) + 1 == DROP) next; nu++; for (a = 0; a <= 2; a++) for (c = 0; c <= 2; c++) S[a, c] += $(12 + 3 * a + c) }
END { for (a = 0; a <= 2; a++) for (c = 0; c <= 2; c++) M[a, c] = S[a, c] / nu
  printf "W2-OBJECT MONTE CARLO TABLE (su2mh MH; geometry and n as in the records; %d of %d configurations%s%s)\n", nu, nc, (SYM ? "; A<->B symmetrised" : ""), (DROP > 0 ? sprintf("; jackknife bin %d of size %d left out", DROP, B) : "")
  for (a = 0; a <= 2; a++) for (c = 0; c <= 2; c++) { v = SYM ? (M[a, c] + M[c, a]) / 2 : M[a, c]; if (a == 0 && c == 0) v = 1
    printf "W2-CLASS a=%d c=%d E[chi_a(A) chi_c(B)] = %+.15e (imag 0)\n", a, c, v } }
