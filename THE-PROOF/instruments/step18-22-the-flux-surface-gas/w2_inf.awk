# w2_inf.awk -- THE MOMENT INFLUENCE of one outside link on the coarse loop (the campaign's §9 ladder, the quantity named exactly after the
# advisor's read of 07:1x): two records of w2_strip_n (the base and the one with one outside link rotated, W2_ROT), the same caps; for every
# a <= L the change of the bounded observable chi_a(A)/d_a, and the INFLUENCE I = max_a |dE[chi_a(A)]|/d_a -- a Lipschitz-type influence on a
# finite set of bounded observables at ONE angle, hence a lower bound on the sup over the link's values that a Dobrushin row would take; the
# truncated class density's total variation is printed beside it ONLY when both truncated densities are positive on the grid, else REFUSED by
# name (a TV of a signed density is not a TV; the one-step objects at the ordered and cancelling data are signed at L <= 2).
# usage: gawk -v N=256 -f w2_inf.awk <base record> <rotated record>
function chi(a, th) { if (a == 0) return 1; return sin((a + 1) * th) / sin(th) }
function abs(x) { return x < 0 ? -x : x }
FNR == 1 { file++ }
/^W2-CLASS a=/ { a = substr($2, 3) + 0; c = substr($3, 3) + 0; v = $7 + 0; if (file == 1) { B[a, c] = v; if (a > L) L = a } else R[a, c] = v }
/^W2-ROT/ { rot = $0 }
END {
  if (!N) N = 256; if (file != 2) { print "W2-INF REFUSED: two records are needed"; exit 2 }
  if (abs(B[0, 0] - 1) > 1e-9 || abs(R[0, 0] - 1) > 1e-9) { print "W2-INF REFUSED: a (0,0) moment is not 1 -- a misread record"; exit 2 }
  inf = 0; s = ""; for (a = 1; a <= L; a++) { d = abs(R[a, 0] - B[a, 0]) / (a + 1); if (d > inf) inf = d; s = s sprintf(" dE%d=%+.6e", a, R[a, 0] - B[a, 0]) }
  PI = 3.141592653589793; tv = 0; neg = 0
  for (i = 1; i <= N; i++) { th = i * PI / (N + 1); w = 2 / (N + 1) * sin(th) * sin(th); wb = 0; wr = 0; for (a = 0; a <= L; a++) { wb += B[a, 0] * chi(a, th); wr += R[a, 0] * chi(a, th) } if (wb <= 0 || wr <= 0) neg++; tv += w * abs(wr - wb) / 2 }
  printf "W2-INF L=%d: influence = %.6e (max_a |dE[chi_a(A)]|/d_a);%s; tv(A) = %s; dE[chi_1 chi_1] = %+.6e; %s\n", L, inf, s, (neg ? sprintf("REFUSED (a signed truncated density at %d of %d cells)", neg, N) : sprintf("%.6e", tv)), R[1, 1] - B[1, 1], rot }
