# w2_u1_inf.awk -- THE MOMENT INFLUENCE of one outside link on the U(1) coarse loop (the ladder's abelian column, the quantity named exactly):
# two records of w2_u1 (the base and the one with one link's phase shifted, U1_ROT), the same caps; for every a <= L the change of the bounded
# observable e^{i a Phi_A}, the INFLUENCE I = max_a |dE[e^{i a Phi_A}]| (complex modulus), one angle, a lower bound on a Dobrushin row's sup;
# the truncated density's TV beside it only when both densities are positive on the grid, else REFUSED by name.
# usage: gawk -v N=256 -f w2_u1_inf.awk <base record> <rotated record>
function abs(x) { return x < 0 ? -x : x }
FNR == 1 { file++ }
/^U1-CLASS a=/ { a = substr($2, 3) + 0; c = substr($3, 3) + 0; re = $9 + 0; im = $10 + 0; if (c != 0) next; if (file == 1) { BR[a] = re; BI[a] = im; BR[-a] = re; BI[-a] = -im; if (abs(a) > L) L = abs(a) } else { RR[a] = re; RI[a] = im; RR[-a] = re; RI[-a] = -im } }
/^U1-ROT/ { rot = $0 }
END {
  if (!N) N = 256; if (file != 2) { print "U1-INF REFUSED: two records are needed"; exit 2 }
  if (abs(BR[0] - 1) > 1e-9 || abs(RR[0] - 1) > 1e-9) { print "U1-INF REFUSED: a (0,0) moment is not 1 -- a misread record"; exit 2 }
  inf = 0; s = ""; for (a = 1; a <= L; a++) { d = sqrt((RR[a] - BR[a]) ^ 2 + (RI[a] - BI[a]) ^ 2); if (d > inf) inf = d; s = s sprintf(" |dE%d|=%.6e", a, d) }
  PI = 3.141592653589793; tv = 0; neg = 0
  for (i = 0; i < N; i++) { x = 2 * PI * i / N; wb = 0; wr = 0; for (a = -L; a <= L; a++) { wb += BR[a] * cos(a * x) + BI[a] * sin(a * x); wr += RR[a] * cos(a * x) + RI[a] * sin(a * x) } if (wb <= 0 || wr <= 0) neg++; tv += abs(wr - wb) / 2 / N }
  printf "U1-INF L=%d: influence = %.6e (max_a |dE[e^{i a Phi_A}]|);%s; tv(A) = %s; %s\n", L, inf, s, (neg ? sprintf("REFUSED (a signed truncated density at %d of %d cells)", neg, N) : sprintf("%.6e", tv)), rot }
