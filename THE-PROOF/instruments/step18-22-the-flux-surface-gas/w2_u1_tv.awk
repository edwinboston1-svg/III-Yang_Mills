# w2_u1_tv.awk -- THE INFLUENCE of one outside link on the U(1) coarse loop's law (the campaign's §9, the ladder's abelian refusal).  Two
# records of w2_u1 (the base and the one with one link's phase shifted, U1_ROT), the same caps: the truncated density of the loop angle,
# W(x) = sum_{|a| <= L} M(a) e^{-i a x} with M(-a) = conj M(a), on a grid of N angles, and tv = (1/2) int |W_rot - W_base| dx/2pi.
# usage: gawk -v N=256 -f w2_u1_tv.awk <base record> <rotated record>
function abs(x) { return x < 0 ? -x : x }
FNR == 1 { file++ }
/^U1-CLASS a=/ { a = substr($2, 3) + 0; c = substr($3, 3) + 0; re = $9 + 0; im = $10 + 0; if (c != 0) next; if (file == 1) { BR[a] = re; BI[a] = im; BR[-a] = re; BI[-a] = -im; if (abs(a) > L) L = abs(a) } else { RR[a] = re; RI[a] = im; RR[-a] = re; RI[-a] = -im } }
/^U1-ROT/ { rot = $0 }
END {
  if (!N) N = 256; if (file != 2) { print "U1-TV REFUSED: two records are needed"; exit 2 }
  if (abs(BR[0] - 1) > 1e-9 || abs(RR[0] - 1) > 1e-9) { print "U1-TV REFUSED: a (0,0) moment is not 1 -- a misread record"; exit 2 }
  PI = 3.141592653589793; tv = 0
  for (i = 0; i < N; i++) { x = 2 * PI * i / N; wb = 0; wr = 0; for (a = -L; a <= L; a++) { wb += BR[a] * cos(a * x) + BI[a] * sin(a * x); wr += RR[a] * cos(a * x) + RI[a] * sin(a * x) } tv += abs(wr - wb) / 2 / N }
  printf "U1-TV L=%d N=%d: tv(A) = %.6e; d|E[e^{i Phi_A}]| = %+.6e; %s\n", L, N, tv, sqrt(RR[1] ^ 2 + RI[1] ^ 2) - sqrt(BR[1] ^ 2 + BI[1] ^ 2), rot }
