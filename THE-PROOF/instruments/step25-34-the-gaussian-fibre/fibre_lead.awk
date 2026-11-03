# fibre_lead.awk -- IS THE LAW'S POLE THE SLOWEST?  THE COFACTOR'S ROOTS COUNTED ON A DISC, EXACTLY (ΟΛΟΚΛΗΡΩΣΙΣ Addendum II, the
# object the development's validation protocol asked for, 2026-11-02 23:5x).  Addendum II read the fibre determinant's REAL zeros and
# called the staggered pole leading; the complex zeros were never read, so the claim stood on the real line only (law 32: "and nothing
# else" is the stronger claim).  Here it is decided whole: at each cell D(z) = z^low (qa z^2 + qb z + qa) Q(z) with the law's quadratic
# divided out exactly (Gauss: a primitive divisor of an integer polynomial has an integer quotient), and Q's roots are COUNTED in the
# disc |z| < r1, r1 a rational strictly below the law's pole modulus r0 = c - sqrt(c^2 - 1) (c = cosh kappa = N/D; r1 from an exact integer
# square root, r1 < r0 checked by the definition of the floor root), by the Schur-Cohn count: for p of formal degree n with constant a0
# and top an, Tp(z) = a0 p(z) - an p*(z) has formal degree n - 1 and delta = a0^2 - an^2; the roots of p inside the unit circle number
# inside(Tp) if delta > 0 and n - inside(Tp) if delta < 0 (Marden, Geometry of Polynomials, 43.1; delta = 0 is DEGENERATE and refused by
# name), applied to Q(r1 z) with integer coefficients, the content removed at every step (a positive scale moves no root).  Q is
# palindromic (checked), so its roots pair as (z, 1/z) and at most deg(Q)/2 lie in the open unit disc: THE COUNT IN |z| < r1 EQUALS
# deg(Q)/2 IFF NO ROOT OF Q LIES IN r1 <= |z| <= 1/r1, and then the law's pole z0 = -r0 is the root of D of largest modulus inside the
# unit circle -- LEADING.  A count below deg(Q)/2 is NOT-LEADING-AT-r1 (a root of Q has modulus >= r1; whether it exceeds r0 needs r1
# nearer r0).  Two-sided controls: a planted palindromic quartic with roots 1/2, 2, 1/3, 3 (none below r1) must read NOT-LEADING and one
# with roots 1/10, 10, 1/20, 20 must read LEADING.  The verdict alphabet (infix-free): LEADS / TRAILS-AT-R1 / DEGENERATE /
# CAUGHT / PLANT-LOST.  Everything integer, gawk -M; 0 - x never -x.  usage: gawk -M -f fibre_lead.awk fibre_pole.2026-11-02a.txt
function gcd(a, b,   t) { if (a < 0) a = 0 - a; if (b < 0) b = 0 - b; while (b != 0) { t = a % b; a = b; b = t } return a }
function isqrt(n,   x, y) { if (n <= 0) return 0; x = n; y = fdiv(x + 1, 2); while (y < x) { x = y; y = fdiv(x + fdiv(n, x), 2) } return x }
function fdiv(n, d,   r) { r = n % d; if (r < 0) r += d; return (n - r) / d }
# the Schur-Cohn count of the roots of A[0..n] (integers, formal degree n) inside the unit circle; sets SC_DEG to -1 on a degenerate step
function schur_count(n,   k, a0, an, delta, cnt, g, i, nz) {
  if (n == 0) return 0
  a0 = A[0]; an = A[n]; delta = a0 * a0 - an * an
  if (delta == 0) { SC_DEG = -1; return 0 }
  for (k = 0; k < n; k++) B[k] = a0 * A[k] - an * A[n - k]
  g = 0; for (k = 0; k < n; k++) g = gcd(g, B[k]); if (g == 0) { SC_DEG = -1; return 0 }
  for (k = 0; k < n; k++) A[k] = B[k] / g
  cnt = schur_count(n - 1)
  if (SC_DEG < 0) return 0
  return (delta > 0) ? cnt : n - cnt
}
# count the roots of P[0..m] inside |z| < num/den: scale P(z) -> P((num/den) z), clear the denominator, count
function count_in_disc(m, num, den,   k, s, t) {
  for (k = 0; k <= m; k++) { A[k] = P[k] * (num ^ k) * (den ^ (m - k)) }
  SC_DEG = 0; return schur_count(m)
}
function plant(name, coeffs, want, num, den,   cnt, v, n, k, CC) {   # coeffs "c0,c1,...,cn" of formal degree n; want = the roots expected below r1
  n = split(coeffs, CC, ",") - 1; for (k = 0; k <= n; k++) P[k] = CC[k + 1] + 0; cnt = count_in_disc(n, num, den)
  v = (SC_DEG < 0) ? "DEGENERATE" : (cnt == want ? "CAUGHT" : "PLANT-LOST")
  printf "FL-CONTROL planted=%s formal-degree=%d roots-below-r1=%d expected=%d %s\n", name, n, cnt, want, v
  return (v == "CAUGHT")
}
BEGIN { SCALE = 1000000; cells = 0; leading = 0; bad = 0; ctl = 1 }
/^FP-COEFFS / { cell = $2 " " $3; s = $0; sub(/.*coefficients=/, "", s); nd = split(s, CF, ","); DEG[cell] = nd - 1; for (k = 0; k < nd; k++) D[cell, k] = CF[k + 1] + 0; next }
/^FP-LAW / {
  if (cell == "") next
  s = $0; qa = s; sub(/.*quadratic=/, "", qa); split(qa, Qf, " "); qa = Qf[1] + 0; qb = Qf[4] + 0   # "qa z^2 + qb z + qa"
  cn = s; sub(/.*cosh=3\+2npi\+m2=/, "", cn); sub(/ .*$/, "", cn); split(cn, CN, "/"); N = CN[1] + 0; Dn = CN[2] + 0   # c = N/Dn
  deg = DEG[cell]; low = 0; while (low < deg && D[cell, low] == 0) low++
  m = deg - low; for (k = 0; k <= m; k++) P[k] = D[cell, k + low]
  # divide by qa z^2 + qb z + qa, exactly
  ok = 1; for (k = m; k >= 2; k--) { if (P[k] % qa != 0) { ok = 0; break } t = P[k] / qa; QQ[k - 2] = t; P[k] = 0; P[k - 1] -= qb * t; P[k - 2] -= qa * t }
  if (!ok || P[0] != 0 || P[1] != 0) { printf "FL-CELL %s law-c=%d/%d verdict=DEGENERATE (the law's quadratic does not divide: the cell is not the law's)\n", cell, N, Dn; cells++; bad++; next }
  # the quotient Q[k-2] = t at each step of the division
  mq = m - 2; for (k = 0; k <= mq; k++) P[k] = QQ[k]
  g = 0; for (k = 0; k <= mq; k++) g = gcd(g, P[k]); if (g > 1) for (k = 0; k <= mq; k++) P[k] = P[k] / g
  pal = 1; for (k = 0; k <= mq; k++) if (P[k] != P[mq - k]) pal = 0
  printf "FL-COFACTOR %s law-c=%d/%d degQ=%d palindromic=%s coefficients=", cell, N, Dn, mq, (pal ? "yes" : "no")
  for (k = 0; k <= mq; k++) printf "%d%s", P[k], (k < mq ? "," : "\n")
  # r0 = (N - sqrt(N^2 - Dn^2)) / Dn; r1 = (N S - (s + 1)) / (Dn S) with s = isqrt((N^2 - Dn^2) S^2) < sqrt(...) S <= s + 1, so r1 < r0
  s = isqrt((N * N - Dn * Dn) * SCALE * SCALE); if ((s + 1) * (s + 1) <= (N * N - Dn * Dn) * SCALE * SCALE) { print "FL-REFUSED: the floor root is not a floor"; exit 2 }
  num = N * SCALE - (s + 1); den = Dn * SCALE; gg = gcd(num, den); num /= gg; den /= gg
  cnt = count_in_disc(mq, num, den)
  if (SC_DEG < 0) v = "DEGENERATE"; else v = (pal && cnt == mq / 2) ? "LEADS" : "TRAILS-AT-R1"
  printf "FL-CELL %s law-c=%d/%d r1=%d/%d (below r0 = c - sqrt(c^2-1)) degQ=%d roots-of-Q-below-r1=%d of %d verdict=%s\n", cell, N, Dn, num, den, mq, cnt, mq / 2, v
  cells++; if (v == "LEADS") leading++; else bad++
  cell = ""; next
}
END {
  # the controls at the massless corner's r1 (c = 3): r1 = (3 S - (isqrt(8 S^2) + 1)) / S
  s = isqrt(8 * SCALE * SCALE); num = 3 * SCALE - (s + 1); den = SCALE
  ctl = plant("(2z-1)(z-2)(3z-1)(z-3)", "6,-35,62,-35,6", 0, num, den) && ctl            # none below r1: a leading-ness claim must read NOT-LEADING here
  ctl = plant("(10z-1)(z-10)(20z-1)(z-20)", "200,-6030,40901,-6030,200", 2, num, den) && ctl   # both inside roots below r1
  ctl = plant("4z^2+1 (roots +-i/2, above r1)", "1,0,4", 0, num, den) && ctl                       # a vanishing coefficient in the transform: the formal-degree branch
  ctl = plant("100z^2+1 (roots +-i/10, below r1)", "1,0,100", 2, num, den) && ctl
  printf "FL-END cells=%d leads=%d trails-or-degenerate=%d controls=%s verdict=%s\n", cells, leading, bad, (ctl ? "CAUGHT" : "PLANT-LOST"), (!ctl ? "PLANT-LOST" : (bad == 0 && cells > 0 ? "LEADS" : "TRAILS-AT-R1"))
}
