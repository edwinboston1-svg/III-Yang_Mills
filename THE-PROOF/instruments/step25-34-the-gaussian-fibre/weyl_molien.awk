# weyl_molien.awk -- ΟΛΟΚΛΗΡΩΣΙΣ Ο3, THE WEYL GROUPS' MOLIEN SERIES: W(B4), W(D4), W(F4) built from their simple reflections as 4 x 4
# matrices with entries in Z/2 (every matrix carried as 2w, an integer matrix; the product (2a)(2b)/2 integral since 2ab is), the group
# closed by breadth-first multiplication, and the Molien series M(t) = (1/|W|) sum_w 1/det(1 - t w) as an EXACT power series to degree
# DMAX: for each w the coefficients of det(1 - t w) = 1 - e1 t + e2 t^2 - e3 t^3 + e4 t^4 are the principal-minor sums of w (those of 2w
# over 2^k, integers since w's characteristic polynomial is a product of cyclotomics), the reciprocal series by the integer recurrence,
# the sum over the group divisible by |W| (refused otherwise).  KNOWN ANSWERS (Chevalley, W = 0): |W| = 384, 192, 1152; the degrees
# B4: 2,4,6,8; D4: 2,4,4,6; F4: 2,6,8,12, so M(t) = prod 1/(1 - t^{d_i}) coefficient for coefficient.  THE READING: the first degree at
# which [t^n] M_W exceeds [t^n] 1/(1 - t^2) (the O(4) invariants) -- the first anisotropic degree.  A control: F4 with its fourth
# generator dropped, refused by its order.  Page DOCS/III-HOLOKLEROSIS-THE-COMPLETION-PREREGISTRATION.md (e6c1349a9), Ο3.
# usage: gawk -M [-v DMAX=24] -f weyl_molien.awk
function key(m,   i, s) { s = ""; for (i = 0; i < 16; i++) s = s m[i] ","; return s }
function unkey(s, m,   i, parts) { split(s, parts, ","); for (i = 0; i < 16; i++) m[i] = parts[i + 1] + 0 }
function mmul(a, b, c,   i, j, k, s) { for (i = 0; i < 4; i++) for (j = 0; j < 4; j++) { s = 0; for (k = 0; k < 4; k++) s += a[i * 4 + k] * b[k * 4 + j]; if (s % 2 != 0) { print "WY-REFUSED: a product left Z/2"; exit 2 } c[i * 4 + j] = s / 2 } }
function ident(m,   i, j) { for (i = 0; i < 4; i++) for (j = 0; j < 4; j++) m[i * 4 + j] = (i == j) ? 2 : 0 }
function swapgen(m, p, q,   i, j) { ident(m); m[p * 4 + p] = 0; m[q * 4 + q] = 0; m[p * 4 + q] = 2; m[q * 4 + p] = 2 }
function signgen(m, p) { ident(m); m[p * 4 + p] = -2 }
function d4gen(m) { ident(m); m[2 * 4 + 2] = 0; m[3 * 4 + 3] = 0; m[2 * 4 + 3] = -2; m[3 * 4 + 2] = -2 }     # x3 -> -x4, x4 -> -x3
function f4gen(m,   i, j, s) { s[0] = 1; s[1] = -1; s[2] = -1; s[3] = -1; for (i = 0; i < 4; i++) for (j = 0; j < 4; j++) m[i * 4 + j] = ((i == j) ? 2 : 0) - s[i] * s[j] }   # 2 (I - 2 a a^T), a = (1,-1,-1,-1)/2 (entries +-1/2 doubled)
function closure(ng,   head, tail, i, g, s, t, w, c) { delete ELT; delete QK; head = 0; tail = 0; ident(w); s = key(w); ELT[s] = 1; QK[tail++] = s
  while (head < tail) { s = QK[head++]; unkey(s, w); for (g = 0; g < ng; g++) { for (i = 0; i < 16; i++) t[i] = GEN[g, i]; mmul(w, t, c); s2 = key(c); if (!(s2 in ELT)) { ELT[s2] = 1; QK[tail++] = s2
      if (tail > 1152) { print "WY-REFUSED: the closure passed 1152 elements, the order of W(F4), the largest rank-4 Weyl group -- the generators do not generate a finite reflection group (a bent generator has infinite order: the 11-02 run f hung here for two hours, uncapped)"; exit 2 } } } }
  return tail }
# principal minors of the integer matrix 2w (M[0..15]) -> e1..e4 of w (divided by 2, 4, 8, 16)
function det2(m, a, b) { return m[a * 4 + a] * m[b * 4 + b] - m[a * 4 + b] * m[b * 4 + a] }
function det3(m, a, b, c,   r) { r = m[a*4+a] * (m[b*4+b] * m[c*4+c] - m[b*4+c] * m[c*4+b]) - m[a*4+b] * (m[b*4+a] * m[c*4+c] - m[b*4+c] * m[c*4+a]) + m[a*4+c] * (m[b*4+a] * m[c*4+b] - m[b*4+b] * m[c*4+a]); return r }
function det4(m,   r, j, mnr, i, k, cols, c) { r = 0; for (j = 0; j < 4; j++) { c = 0; for (k = 0; k < 4; k++) if (k != j) cols[c++] = k
    # the minor deleting row 0 and column j: rows 1..3, columns cols[0..2]
    mnr = m[1*4+cols[0]] * (m[2*4+cols[1]] * m[3*4+cols[2]] - m[2*4+cols[2]] * m[3*4+cols[1]]) - m[1*4+cols[1]] * (m[2*4+cols[0]] * m[3*4+cols[2]] - m[2*4+cols[2]] * m[3*4+cols[0]]) + m[1*4+cols[2]] * (m[2*4+cols[0]] * m[3*4+cols[1]] - m[2*4+cols[1]] * m[3*4+cols[0]])
    r += ((j % 2) ? -1 : 1) * m[j] * mnr } return r }
function charcoef(m, e,   s) { s = m[0] + m[5] + m[10] + m[15]; if (s % 2) { print "WY-REFUSED: a non-integer trace"; exit 2 } e[1] = s / 2
  s = det2(m,0,1) + det2(m,0,2) + det2(m,0,3) + det2(m,1,2) + det2(m,1,3) + det2(m,2,3); if (s % 4) { print "WY-REFUSED: a non-integer e2"; exit 2 } e[2] = s / 4
  s = det3(m,0,1,2) + det3(m,0,1,3) + det3(m,0,2,3) + det3(m,1,2,3); if (s % 8) { print "WY-REFUSED: a non-integer e3"; exit 2 } e[3] = s / 8
  s = det4(m); if (s % 16) { print "WY-REFUSED: a non-integer determinant"; exit 2 } e[4] = s / 16 }
# the Molien series of the closed group ELT (size N) to DMAX, into MOL[0..DMAX]; refuses a non-integer coefficient
function molien(N, MOL,   s, w, e, c, b, n, k, acc) {
  for (n = 0; n <= DMAX; n++) acc[n] = 0
  for (s in ELT) { unkey(s, w); charcoef(w, e); c[1] = 0 - e[1]; c[2] = e[2]; c[3] = 0 - e[3]; c[4] = e[4]
    b[0] = 1; for (n = 1; n <= DMAX; n++) { b[n] = 0; for (k = 1; k <= 4 && k <= n; k++) b[n] -= c[k] * b[n - k] }
    for (n = 0; n <= DMAX; n++) acc[n] += b[n] }
  for (n = 0; n <= DMAX; n++) { if (acc[n] % N != 0) { print "WY-REFUSED: the Molien sum is not divisible by |W| at degree " n; exit 2 } MOL[n] = acc[n] / N } }
function product_series(degs, PS,   n, i, k, parts, m, d) { m = split(degs, parts, ","); for (n = 0; n <= DMAX; n++) PS[n] = (n == 0) ? 1 : 0
  for (i = 1; i <= m; i++) { d = parts[i] + 0; for (n = d; n <= DMAX; n++) PS[n] += PS[n - d] } }
function report(name, ng, expected, degs,   N, n, met, first, MOL, PS, line) {
  N = closure(ng)
  printf "WY-ORDER group=%s generators=%d order=%d expected=%d %s\n", name, ng, N, expected, (N == expected) ? "MET" : "WRONG-ORDER"
  if (N != expected) return
  molien(N, MOL); product_series(degs, PS); met = 1; line = ""
  for (n = 0; n <= DMAX; n++) { if (MOL[n] != PS[n]) met = 0; line = line MOL[n] (n < DMAX ? "," : "") }
  printf "WY-SERIES group=%s degrees=%s coefficients=%s product-met=%s\n", name, degs, line, (met ? "MET" : "MISS")
  first = 0; for (n = 1; n <= DMAX && !first; n++) if (MOL[n] > ((n % 2 == 0) ? 1 : 0)) first = n
  printf "WY-FIRST group=%s first-anisotropic-degree=%d (the first n with [t^n] M_W above the O(4) count)\n", name, first }
BEGIN { if (!DMAX) DMAX = 24
  # B4: the three adjacent swaps and the sign change of x4
  for (i = 0; i < 16; i++) GEN[0, i] = 0
  swapgen(t, 0, 1); for (i = 0; i < 16; i++) GEN[0, i] = t[i]
  swapgen(t, 1, 2); for (i = 0; i < 16; i++) GEN[1, i] = t[i]
  swapgen(t, 2, 3); for (i = 0; i < 16; i++) GEN[2, i] = t[i]
  signgen(t, 3);    for (i = 0; i < 16; i++) GEN[3, i] = t[i]
  report("B4", 4, 384, "2,4,6,8")
  # D4: the three swaps and the reflection in e3 + e4
  d4gen(t); for (i = 0; i < 16; i++) GEN[3, i] = t[i]
  report("D4", 4, 192, "2,4,4,6")
  # F4: s_{e2-e3}, s_{e3-e4}, s_{e4}, s_{(e1-e2-e3-e4)/2}
  swapgen(t, 1, 2); for (i = 0; i < 16; i++) GEN[0, i] = t[i]
  swapgen(t, 2, 3); for (i = 0; i < 16; i++) GEN[1, i] = t[i]
  signgen(t, 3);    for (i = 0; i < 16; i++) GEN[2, i] = t[i]
  f4gen(t);         for (i = 0; i < 16; i++) GEN[3, i] = t[i]
  report("F4", 4, 1152, "2,6,8,12")
  # the control: F4 without its fourth generator -- whatever order the closure reads, it is not 1152 and is refused by name
  report("F4-minus-a4", 3, 1152, "2,6,8,12")
  print "WY-END"
}
