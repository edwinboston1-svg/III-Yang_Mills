# w2_tv.awk -- THE INFLUENCE of one outside link on the coarse loop's class law (THE CROSSING CAMPAIGN §9, the influence ladder; 2026-11-01,
# the author).  Two records of w2_strip_n (the base and the one with one outside link rotated, W2_ROT), the same caps: the truncated
# class density of the loop A, W(th) = sum_{a <= L} E[chi_a(A)] chi_a(th), on the Chebyshev-U grid (the Haar class measure), and the TOTAL
# VARIATION tv = (1/2) int |W_rot - W_base| dmu; also the change of each marginal moment and of the joint (1,1) moment.  The influence of
# the link is tv (the Dobrushin quantity for the coarse variable A against this one outside link, at this angle); the row sum is the reader's.
# usage: gawk -v N=256 -f w2_tv.awk <base record> <rotated record>
function chi(a, th) { if (a == 0) return 1; return sin((a + 1) * th) / sin(th) }
function abs(x) { return x < 0 ? -x : x }
FNR == 1 { file++ }
/^W2-CLASS a=/ { a = substr($2, 3) + 0; c = substr($3, 3) + 0; v = $7 + 0; if (file == 1) { B[a, c] = v; if (a > L) L = a } else R[a, c] = v }
/^W2-ROT/ { rot = $0 }
END {
  if (!N) N = 256; if (file != 2) { print "W2-TV REFUSED: two records are needed"; exit 2 }
  if (abs(B[0, 0] - 1) > 1e-9 || abs(R[0, 0] - 1) > 1e-9) { print "W2-TV REFUSED: a (0,0) moment is not 1 -- a misread record"; exit 2 }
  PI = 3.141592653589793; tv = 0; tvB = 0
  for (i = 1; i <= N; i++) { th = i * PI / (N + 1); w = 2 / (N + 1) * sin(th) * sin(th); wb = 0; wr = 0; vb = 0; vr = 0
    for (a = 0; a <= L; a++) { wb += B[a, 0] * chi(a, th); wr += R[a, 0] * chi(a, th); vb += B[0, a] * chi(a, th); vr += R[0, a] * chi(a, th) }
    tv += w * abs(wr - wb) / 2; tvB += w * abs(vr - vb) / 2 }
  printf "W2-TV L=%d N=%d: tv(A) = %.6e tv(B) = %.6e; dE[chi_1(A)] = %+.6e dE[chi_2(A)] = %+.6e; dE[chi_1 chi_1] = %+.6e; %s\n", L, N, tv, tvB, R[1, 0] - B[1, 0], (L >= 2 ? R[2, 0] - B[2, 0] : 0), R[1, 1] - B[1, 1], rot }
