# fibre_time.awk -- ΟΛΟΚΛΗΡΩΣΙΣ ADDENDUM II, S-B1: THE FIBRE'S TIME IS EVEN.  A reader on the committed records: every FP-COEFFS line of
# fibre_pole.2026-11-02a.txt (det C(z) over z, integer coefficients) and every FP3-COSHPOLY line of fibre_pole3.2026-11-02a.txt (the cosh
# polynomial F(v), v = z + 1/z, integer coefficients) -- a zero of det C in (0,1) is a positive-z fibre mode (an unstaggered one, K_0 = i kappa),
# a zero in (-1,0) a staggered one (K_0 = pi + i kappa); on F a zero at v > 2 is positive-z, at v < -2 negative-z.  Sign changes on a grid of
# 4096 points per unit, each bracketed to 2^-40 by exact bisection in gawk -M; no float.  Two-sided: a PLANTED polynomial with one zero at
# z = 1/2 and one at z = -1/3 ((2z - 1)(3z + 1) = 6z^2 - z - 1) must read positive=1 negative=1.  Verdict alphabet: EVEN (no positive zero at
# any cell) / UNSTAGGERED (a cell names a positive zero) / PLANT-LOST (the control; CAUGHT when found -- FOUND is an infix of ALL-FOUND and MISS of PLANT-MISSED, law 46).  usage: gawk -M -f fibre_time.awk FP-record FP3-record
function sgn(x) { return (x > 0) ? 1 : (x < 0) ? -1 : 0 }
function evalz(n, num, den,   k, acc) { acc = 0; for (k = n; k >= 0; k--) acc = acc * num + CF[k] * (den ^ (n - k)); return acc }   # P(num/den) * den^n
# zeros of CF[0..n] in (lo, hi) (integers lo < hi), grid G per unit: count the sign changes, bisect each 40 times, print brackets
function zeros_in(n, lo, hi, tag,   G, a, s0, s1, cnt, l, h, sc, it, mid, t, slo) {
  G = 4096; cnt = 0; s0 = sgn(evalz(n, lo * G + 1, G))
  for (a = lo * G + 2; a <= hi * G - 1; a++) { s1 = sgn(evalz(n, a, G))
    if (s1 == 0) { cnt++; printf "FT-ZERO %s z=%d/%d exact\n", tag, a, G }
    else if (s0 != 0 && s1 != s0) { l = a - 1; h = a; sc = G; slo = s0
      for (it = 0; it < 40; it++) { l *= 2; h *= 2; sc *= 2; mid = (l + h) / 2; t = sgn(evalz(n, mid, sc)); if (t == 0) { l = mid; h = mid; break } if (t == slo) l = mid; else h = mid }
      cnt++; printf "FT-ZERO %s z in [%s, %s]\n", tag, dec(l, sc, 10), dec(h, sc, 10) }
    s0 = s1 }
  return cnt }
function fdiv(n, d,   r) { r = n % d; if (r < 0) r += d; return (n - r) / d }
function dec(n, d, dig,   neg, ip, r, s, i, q) { neg = 0; if (n < 0) { neg = 1; n = 0 - n } ip = fdiv(n, d); r = n - ip * d; s = ""; for (i = 0; i < dig; i++) { r *= 10; q = fdiv(r, d); s = s q; r -= q * d } return (neg ? "-" : "") ip "." s }
function readcoeffs(s,   n, i, A) { n = split(s, A, ","); for (i = 1; i <= n; i++) CF[i - 1] = A[i] + 0; return n - 1 }
BEGIN { cells = 0; pos = 0; neg = 0; unst = 0 }
/^FP-COEFFS / {   # the z-polynomial of a corner cell: zeros in (0,1) positive modes, in (-1,0) negative modes
  cell = $2 " " $3; s = $0; sub(/.*coefficients=/, "", s); n = readcoeffs(s); cells++
  p = zeros_in(n, 0, 1, "FP " cell); q = zeros_in(n, -1, 0, "FP " cell); pos += p; neg += q; if (p > 0) unst++
  printf "FT-CELL record=FP %s degree=%d positive-zeros(0,1)=%d negative-zeros(-1,0)=%d %s\n", cell, n, p, q, (p == 0 ? "EVEN" : "UNSTAGGERED") }
/^FP3-COSHPOLY / {   # the cosh polynomial F(v): a zero at v > 2 is a positive-z mode (v = z + 1/z > 2 for z in (0,1)), at v < -2 a negative-z one
  cell = $2 " " $3 " " $4 " " $5; s = $0; sub(/.*coefficients\(v=z\+1\/z=-2cosh\)=/, "", s); n = readcoeffs(s); cells++
  p = zeros_in(n, 2, 64, "FP3 " cell); q = zeros_in(n, -64, -2, "FP3 " cell); pos += p; neg += q; if (p > 0) unst++
  printf "FT-CELL record=FP3 %s degree=%d positive-zeros(v>2)=%d negative-zeros(v<-2)=%d %s\n", cell, n, p, q, (p == 0 ? "EVEN" : "UNSTAGGERED") }
END {
  # the sighted control: (2z - 1)(3z + 1) = 6 z^2 - z - 1 has the zeros 1/2 and -1/3
  CF[0] = -1; CF[1] = -1; CF[2] = 6; pc = zeros_in(2, 0, 1, "PLANT"); nc = zeros_in(2, -1, 0, "PLANT")
  printf "FT-CONTROL planted=(2z-1)(3z+1) positive=%d negative=%d %s\n", pc, nc, (pc == 1 && nc == 1) ? "CAUGHT" : "PLANT-LOST"
  v = (unst == 0) ? "EVEN" : "UNSTAGGERED"; if (!(pc == 1 && nc == 1)) v = "PLANT-LOST"
  printf "FT-END cells=%d positive-zeros=%d negative-zeros=%d unstaggered-cells=%d verdict=%s\n", cells, pos, neg, unst, v }
