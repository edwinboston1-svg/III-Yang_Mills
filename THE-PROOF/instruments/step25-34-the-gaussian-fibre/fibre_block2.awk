# fibre_block2.awk -- THE BLOCKED GAUSSIAN FIBRE AT EVERY CELL AND EVERY LEVEL: THE COMPLETE FACTORIZATION, EXACT (ΟΛΟΚΛΗΡΩΣΙΣ Addendum
# IV, part 2; the development's delegation (a), 2026-11-03).  Addendum IV factored D_n = det J * V_n at the massless K_perp = 0 cell
# by the cosecant identity.  Here the block-average variance V_n is written for EVERY cell -- transverse K_perp in {0, pi}^3, mass
# m^2 = MN/MD, block size n = 2, 4, 8 -- by two classical identities and nothing else:
#   (1) the Chebyshev product  prod_{c<n} (x - 2 cos(theta + 2 pi c/n)) = P_n(x) - 2 cos(n theta),  P_n(x) = 2 T_n(x/2)  (an integer
#       polynomial: x^2 - 2, x^4 - 4x^2 + 2, x^8 - 8x^6 + 20x^4 - 16x^2 + 2), whose logarithmic derivative is the alias sum
#       sum_c 1/(x - 2cos(theta + 2 pi c/n)) = P_n'(x)/(P_n(x) - 2 cos K)  (K = n theta), its x -> 2 limit the csc^2 sum n^2/(2 - 2cos K),
#       and its derivative at x = 2 the csc^4 sum  sum_c 1/a_c^2 = [n^4 - P_n''(2)(2 - u)]/(2 - u)^2,  P_n''(2) = n^2(n^2 - 1)/6;
#   (2) the partial fraction 1/(a (a + E)) = (1/E)(1/a - 1/(a + E)).
# THE OBJECT.  An alias c = (c0, c_perp) has longitudinal energy a = 2 - 2 cos((K + 2 pi c0)/n) and transverse energy
# e(c_perp) = sum_mu (2 - 2 cos((K_mu + 2 pi c_mu)/n)); the fine symbol is h = a + e + m^2; the form factor is
# |f_n|^2 = (2 - 2 cos K)/(n^2 a) * prod_mu |f_mu|^2 with |f_mu|^2 = 1 at (K_mu = 0, c_mu = 0), = 0 at (K_mu = 0, c_mu != 0) -- the
# INVISIBLE aliases -- and = 4/(n^2 e_mu) at K_mu = pi (every c_mu visible).  Writing E = e + m^2 and u = 2 cos K:
#   V_n = sum_{c_perp visible} F(c_perp) (2 - u)/n^2 * sum_{c0} 1/(a (a + E))
#       = (1/n^2) sum_{E} W_E * [ n^2 (P_n(2 + E) - u) - P_n'(2 + E) (2 - u) ] / (E (P_n(2 + E) - u)),   W_E = sum_{c_perp: E(c) = E} prod_mu (4/(n^2 e_mu))
# (the E = 0 class, K_perp = 0 and m = 0 only, by the csc^4 limit instead: [6 n^4 - n^2 (n^2 - 1)(2 - u)]/(2 - u)^2), a rational function
# of u whose NUMERATOR N(u) (the common denominator cleared, every weight cleared to algebraic integers by the class products) carries
# THE LAW'S ZEROS.  The fine factors of the visible aliases cancel against the denominators ONCE PER E-CLASS, so an E-class of
# multiplicity m leaves (m - 1) surviving fine factors -- zeros of D_n at u = P_n(2 + E), the VISIBLE-DEGENERATE zeros -- and the
# INVISIBLE aliases' fine factors survive whole: zeros at u = P_n(2 + E_c), i.e. cos K = T_n(1 + E_c/2) (Addendum IV's Chebyshev
# families).  So the fibre determinant's whole zero set at a cell is
#   {zeros of N(u)}  ∪  {P_n(2 + E) with multiplicity m_E - 1 : visible E-classes}  ∪  {P_n(2 + E_c) : c invisible},   EXACTLY, at every level.
# THE ARITHMETIC.  cos((pi + 2 pi c)/n) lives in Z[zeta_{2n}]; everything is computed in Z[x]/(x^n + 1) (2n a power of two) with
# polynomials in u over it, NO DIVISION: a class's weight W_E = omega_E / (E' Pi_E) with Pi_E = prod_{c in class} prod_mu e_mu(c) and
# omega_E = sum_{c in class} prod_{c' != c} prod_mu e_mu(c') (both algebraic integers), E' = MD E, Pt(E') = MD^n P((2 MD + E')/MD);
#   N(u) = sum_E omega_E * A_E(u) * prod_{E' != E} [E'' Pi_{E'} B_{E'}(u)],   A_E = n^2 (Pt - MD^n u) - MD Pt' (2 - u),   B_E = Pt - MD^n u.
# N(u) must come out RATIONAL (its zeta-components zero: Galois symmetry) and is printed primitive; its real zeros are isolated by exact
# bisection to 2^-40, a rational zero exhibited exactly by the rational-root test; the staggered zero of smallest |u| is THE LAW'S POLE,
# cosh kappa = |u|/2.  THE LEADING-NESS is decided by (i) every other real zero of N, (ii) the Schur-Cohn count of the zeros of
# N(z + 1/z) z^deg in |z| < r1 < r0 (deg N - 1 expected), (iii) a RATIONAL lower bound on the visible-degenerate and invisible zeros,
# u >= P_n(2 + E_lo) with E_lo below every such energy (e >= 2 at n = 2; e(pi-direction) >= 1/2, e(flipped zero-direction) = 2 at n = 4;
# 1/8 and 2 - sqrt2 >= 1/2 at n = 8), P_n increasing on [2, inf).
# THE STRIP CELLS (fibre_pole3's FP3-COSHPOLY lines, 13 cells, the 32 x 32 road at u = W + 1/W in {2, 1, 0, -1, -2} and the five rows):
# F(v), v = z + 1/z, degree 12, read whole: its real zeros with |v| > 2, the staggered one of smallest |v| the law's pole, the leading-ness
# by the Schur-Cohn count on F(z + 1/z) z^12 reading 11 -- Addendum II's real-zero reading at the strip cells decided whole.
# KNOWN ANSWERS (n = 2, the eight cells of Ο1): N(u) is LINEAR with the zero u = -2(3 + 2 n_pi + m^2) -- Ο1's law -- and the integer
# members of the visible-degenerate and invisible zero lists reproduce fibre_time_quad's unstaggered-integer-cosh lists cell for cell.
# Alphabet (infix-free): MET / PARTED / LEADS / LAGS / COMPLEX-RESIDUE / RATIONAL-ZERO / BRACKETED-ZERO.
# usage: gawk -M -f fibre_block2.awk [-v FP=fibre_pole.2026-11-02a.txt] [-v FTQ=fibre_time_quad.2026-11-02a.txt] [-v FP3=fibre_pole3.2026-11-02a.txt]
function gcd(a, b,   t) { if (a < 0) a = 0 - a; if (b < 0) b = 0 - b; while (b != 0) { t = a % b; a = b; b = t } return a }
function fdiv(n, d,   r) { r = n % d; if (r < 0) r += d; return (n - r) / d }
function isqrt(n,   x, y) { if (n <= 0) return 0; x = n; y = fdiv(x + 1, 2); while (y < x) { x = y; y = fdiv(x + fdiv(n, x), 2) } return x }
function sgn(x) { return (x > 0) ? 1 : (x < 0) ? -1 : 0 }
function dec(n, d, dig,   neg, ip, r, s, i, q) { neg = 0; if (n < 0) { neg = 1; n = 0 - n } ip = fdiv(n, d); r = n - ip * d; s = ""; for (i = 0; i < dig; i++) { r *= 10; q = fdiv(r, d); s = s q; r -= q * d } return (neg ? "-" : "") ip "." s }
# ---- Z[x]/(x^n + 1): arrays of ZD = n integers; x^n = -1; x = zeta_{2n} = e^{i pi/n}
function zc(a,   i) { for (i = 0; i < ZD; i++) a[i] = 0 }
function zset(a, b,   i) { for (i = 0; i < ZD; i++) a[i] = b[i] }
function zadd(a, b, c,   i) { for (i = 0; i < ZD; i++) c[i] = a[i] + b[i] }
function zmul(a, b, c,   i, j, t) { for (i = 0; i < ZD; i++) ZT[i] = 0
  for (i = 0; i < ZD; i++) if (a[i] != 0) for (j = 0; j < ZD; j++) if (b[j] != 0) { t = a[i] * b[j]; if (i + j < ZD) ZT[i + j] += t; else ZT[i + j - ZD] -= t }
  for (i = 0; i < ZD; i++) c[i] = ZT[i] }
function zint(a, v) { zc(a); a[0] = v }
function zpow(c, a,   e, s) { zc(a); e = c % (2 * ZD); if (e < 0) e += 2 * ZD; s = 1; if (e >= ZD) { e -= ZD; s = 0 - 1 } a[e] = s }
function ziszero(a,   i) { for (i = 0; i < ZD; i++) if (a[i] != 0) return 0; return 1 }
# ---- polynomials in u over Z[x]/(x^n+1): P[k, i]
function pz(P, d,   k, i) { for (k = 0; k <= d; k++) for (i = 0; i < ZD; i++) P[k, i] = 0 }
function pcopy(S, ds, D,   k, i) { pz(D, ds); for (k = 0; k <= ds; k++) for (i = 0; i < ZD; i++) D[k, i] = S[k, i] }
function pmul(A, da, B, db, C,   k, l, i) { pz(C, da + db)
  for (k = 0; k <= da; k++) for (l = 0; l <= db; l++) { for (i = 0; i < ZD; i++) { XA[i] = A[k, i]; XB[i] = B[l, i] } zmul(XA, XB, XC); for (i = 0; i < ZD; i++) C[k + l, i] += XC[i] }
  return da + db }
function padd(A, da, B, db, C,   k, i, d) { d = (da > db) ? da : db; pz(C, d); for (k = 0; k <= da; k++) for (i = 0; i < ZD; i++) C[k, i] += A[k, i]; for (k = 0; k <= db; k++) for (i = 0; i < ZD; i++) C[k, i] += B[k, i]; return d }
# ---- P_n(x) = 2 T_n(x/2), its derivative: PC[k], PDC[k]
function cheb(n,   k) { for (k = 0; k <= 8; k++) { PC[k] = 0; PDC[k] = 0 }
  if (n == 2) { PC[2] = 1; PC[0] = 0 - 2 } else if (n == 4) { PC[4] = 1; PC[2] = 0 - 4; PC[0] = 2 } else if (n == 8) { PC[8] = 1; PC[6] = 0 - 8; PC[4] = 20; PC[2] = 0 - 16; PC[0] = 2 }
  for (k = 1; k <= n; k++) PDC[k - 1] = k * PC[k] }
# Pt(E') = MD^n P((2 MD + E')/MD) and MD^{n-1} P'(...) as elements, E' an element
function ptilde(Ep, n, MD, out, outd,   k, i) { zc(out); zc(outd); zint(XP, 1); zint(XB, 2 * MD); zadd(XB, Ep, XB)
  for (k = 0; k <= n; k++) { if (PC[k] != 0) { for (i = 0; i < ZD; i++) XS[i] = XP[i] * PC[k] * (MD ^ (n - k)); zadd(out, XS, out) }
    if (k < n && PDC[k] != 0) { for (i = 0; i < ZD; i++) XS[i] = XP[i] * PDC[k] * (MD ^ (n - 1 - k)); zadd(outd, XS, outd) }
    zmul(XP, XB, XP) } }
# e(eps, c) = 2 - 2cos((pi eps + 2 pi c)/n) = 2 - zeta^{eps+2c} - zeta^{-(eps+2c)}
function energy(eps, c, out,   m, i) { zint(out, 2); m = eps + 2 * c; zpow(m, XA); zpow(0 - m, XB); zadd(XA, XB, XA); for (i = 0; i < ZD; i++) out[i] -= XA[i] }
# ---- Schur-Cohn count of the zeros of SA[0..n] inside the unit circle
function schur_count(n,   k, a0, an, delta, cnt, g) { if (n == 0) return 0; a0 = SA[0]; an = SA[n]; delta = a0 * a0 - an * an; if (delta == 0) { SC_DEG = -1; return 0 }
  for (k = 0; k < n; k++) SB[k] = a0 * SA[k] - an * SA[n - k]; g = 0; for (k = 0; k < n; k++) g = gcd(g, SB[k]); if (g == 0) { SC_DEG = -1; return 0 }
  for (k = 0; k < n; k++) SA[k] = SB[k] / g; cnt = schur_count(n - 1); if (SC_DEG < 0) return 0; return (delta > 0) ? cnt : n - cnt }
function count_in_disc(m, num, den,   k) { for (k = 0; k <= m; k++) SA[k] = SP[k] * (num ^ k) * (den ^ (m - k)); SC_DEG = 0; return schur_count(m) }
function evq(d, p, q,   k, acc) { acc = 0; for (k = d; k >= 0; k--) acc = acc * p + Q[k] * (q ^ (d - k)); return acc }
# ---- the real zeros of the integer polynomial Q[0..qd] with |u| > 2 (grid u = a/64 on [-4096, 4096], bisection to 2^-40); fills RN/RD/nr
function real_zeros(qd,   a, s0, s1, lo, hi, mid, sc, k, z) { nr = 0; if (qd <= 0) return 0
  s0 = sgn(evq(qd, 0 - 4096 * 64, 64))
  for (a = 0 - 4096 * 64 + 1; a <= 4096 * 64; a++) { s1 = sgn(evq(qd, a, 64))
    if (s1 == 0) { RN[nr] = a; RD[nr] = 64; nr++ } else if (s0 != 0 && s1 != s0) { lo = a - 1; hi = a; sc = 64
      for (k = 6; k < 40; k++) { lo *= 2; hi *= 2; sc *= 2; mid = (lo + hi) / 2; z = sgn(evq(qd, mid, sc)); if (z == 0) { lo = mid; hi = mid; break } if (z == s0) lo = mid; else hi = mid }
      RN[nr] = lo; RD[nr] = sc; nr++ } s0 = s1 } return nr }
# the law's zero among RN/RD: the u < -2 zero of smallest |u|; sets LAWN/LAWD (cosh as a fraction), LAWIDX, LAWKIND
function law_zero(qd,   k, u, best, p, q, kq, g) { best = ""; LAWIDX = -1
  for (k = 0; k < nr; k++) { u = RN[k] / RD[k]; if (u < 0 - 2 && (best == "" || 0 - u < 0 - best)) { best = u; LAWIDX = k } }
  if (LAWIDX < 0) return 0
  LAWN = 0 - RN[LAWIDX]; LAWD = 2 * RD[LAWIDX]; g = gcd(LAWN, LAWD); LAWN /= g; LAWD /= g; LAWKIND = "BRACKETED-ZERO"
  for (q = 1; q <= 4096 && LAWKIND == "BRACKETED-ZERO"; q++) { if (Q[qd] % q != 0) continue; p = fdiv(RN[LAWIDX] * q, RD[LAWIDX])
    for (kq = p - 1; kq <= p + 1; kq++) if (kq < 0 && evq(qd, kq, q) == 0) { LAWN = 0 - kq; LAWD = 2 * q; g = gcd(LAWN, LAWD); LAWN /= g; LAWD /= g; LAWKIND = "RATIONAL-ZERO" } }
  return 1 }
# the z-polynomial of Q(z + 1/z) z^qd into SP, then the Schur-Cohn count in |z| < r1 (r1 strictly below r0 = c - sqrt(c^2 - 1), c = LAWN/LAWD)
function zcount_below_law(qd,   k, i, j, db, S, s, r1n, r1d, g) { for (k = 0; k <= 2 * qd; k++) SP[k] = 0
  for (k = 0; k <= qd; k++) { for (i = 0; i <= 2 * qd; i++) BINP[i] = 0; BINP[0] = 1; db = 0; for (j = 0; j < k; j++) { for (i = db + 2; i >= 2; i--) BINP[i] += BINP[i - 2]; db += 2 }
    for (i = 0; i <= db; i++) SP[i + qd - k] += Q[k] * BINP[i] }
  S = 1000000; s = isqrt((LAWN * LAWN - LAWD * LAWD) * S * S); r1n = LAWN * S - (s + 1); r1d = LAWD * S; g = gcd(r1n, r1d); r1n /= g; r1d /= g
  return count_in_disc(2 * qd, r1n, r1d) }
# P_n evaluated at the rational 2 + En/Ed, as a decimal lower-bound string and a comparison value against u (returns 1 if P_n(2+E) > u for u = -LAWN*2/LAWD... we compare against |u_law| = 2 LAWN/LAWD)
function pn_at(n, En, Ed,   k, num, den) { num = 0; for (k = 0; k <= n; k++) num += PC[k] * ((2 * Ed + En) ^ k) * (Ed ^ (n - k)); den = Ed ^ n; PNN = num; PND = den; return dec(num, den, 3) }
# ---- one cell at one level: returns 1 if LEADING; fills the global strings for the KAT
function cell(n, e1, e2, e3, MN, MD,   t, c1, c2, c3, i, j, k, key, ncl, cls, da, dn, res, g, qd, label, lead, bad, zcount, u, invlo, vislo, Emin_n, Emin_d, Evis_n, Evis_d, has_inv, has_vis, mult, kk, degenerate_list, nz, extra, m2) {
  ZD = n; cheb(n); t = e1 + e2 + e3; label = sprintf("n=%d Kperp=(%s,%s,%s) m2=%d/%d", n, (e1 ? "pi" : "0"), (e2 ? "pi" : "0"), (e3 ? "pi" : "0"), MN, MD)
  # the visible aliases, grouped into E-classes: for each class, Pi (the product over its aliases of prod_mu e_mu) and omega (the sum of the products over the other aliases)
  ncl = 0; delete CLIDX; delete CLM
  for (c1 = 0; c1 < n; c1++) for (c2 = 0; c2 < n; c2++) for (c3 = 0; c3 < n; c3++) {
    if ((e1 == 0 && c1 != 0) || (e2 == 0 && c2 != 0) || (e3 == 0 && c3 != 0)) continue
    energy(e1, c1, EA); energy(e2, c2, EB); energy(e3, c3, EC); zadd(EA, EB, ES); zadd(ES, EC, ES); for (i = 0; i < ZD; i++) ES[i] *= MD; ES[0] += MN   # E' = MD e + MN
    zint(PE, 1); if (e1) zmul(PE, EA, PE); if (e2) zmul(PE, EB, PE); if (e3) zmul(PE, EC, PE)                                              # prod_mu e_mu over the pi directions
    key = ""; for (i = 0; i < ZD; i++) key = key ES[i] ","
    if (!(key in CLIDX)) { CLIDX[key] = ncl; cls = ncl; ncl++; for (i = 0; i < ZD; i++) { CLE[cls, i] = ES[i]; CLPI[cls, i] = PE[i]; CLOM[cls, i] = (i == 0) } CLM[cls] = 1 }
    else { cls = CLIDX[key]; CLM[cls]++
      # Pi <- Pi * pe ; omega <- omega * pe + Pi_old  (the sum over aliases of the product over the others)
      for (i = 0; i < ZD; i++) { XA[i] = CLPI[cls, i]; XB[i] = CLOM[cls, i] } zmul(XB, PE, XC); zadd(XC, XA, XC); zmul(XA, PE, XA); for (i = 0; i < ZD; i++) { CLPI[cls, i] = XA[i]; CLOM[cls, i] = XC[i] } }
  }
  # the per-class linear factors A_i, B_i and the cleared weight denominator D_i = E'_i Pi_i; the E = 0 class (K_perp = 0, m = 0) by the csc^4 limit
  for (i = 0; i < ncl; i++) { for (k = 0; k < ZD; k++) ES[k] = CLE[i, k]
    if (ziszero(ES)) { CLZERO[i] = 1; continue } else CLZERO[i] = 0
    ptilde(ES, n, MD, PT, PTD)
    for (k = 0; k < ZD; k++) { CA[i, 0, k] = n * n * PT[k] - 2 * MD * PTD[k]; CA[i, 1, k] = MD * PTD[k]; CB[i, 0, k] = PT[k]; CB[i, 1, k] = 0; XA[k] = CLPI[i, k] }
    CA[i, 1, 0] -= n * n * (MD ^ n); CB[i, 1, 0] -= (MD ^ n); zmul(XA, ES, XC); for (k = 0; k < ZD; k++) CLD[i, k] = XC[k] }
  if (ncl == 1 && CLZERO[0]) { qd = 1; Q[0] = 4 * n * n + 2; Q[1] = n * n - 1; res = 0 }   # [6 n^4 - n^2 (n^2-1)(2 - u)] / n^2 = (n^2 - 1) u + (4 n^2 + 2)
  else {
    pz(NU, ncl); dn = 0
    for (i = 0; i < ncl; i++) { pz(TM, 0); for (k = 0; k < ZD; k++) TM[0, k] = CLOM[i, k]; da = 0
      for (k = 0; k < ZD; k++) { AI[0, k] = CA[i, 0, k]; AI[1, k] = CA[i, 1, k] } da = pmul(TM, da, AI, 1, PR); pcopy(PR, da, TM)
      for (j = 0; j < ncl; j++) { if (j == i) continue; for (k = 0; k < ZD; k++) { BI[0, k] = CB[j, 0, k]; BI[1, k] = CB[j, 1, k] } da = pmul(TM, da, BI, 1, PR); pcopy(PR, da, TM)
        pz(DI, 0); for (k = 0; k < ZD; k++) DI[0, k] = CLD[j, k]; da = pmul(TM, da, DI, 0, PR); pcopy(PR, da, TM) }
      dn = padd(NU, dn, TM, da, PR); pcopy(PR, dn, NU) }
    res = 0; for (k = 0; k <= dn; k++) for (i = 1; i < ZD; i++) if (NU[k, i] != 0) res++
    g = 0; for (k = 0; k <= dn; k++) g = gcd(g, NU[k, 0]); if (g == 0) g = 1; qd = dn; while (qd > 0 && NU[qd, 0] == 0) qd--
    for (k = 0; k <= qd; k++) Q[k] = NU[k, 0] / g }
  printf "FB2-N %s classes=%d degree=%d zeta-residue=%d N(u)=", label, ncl, qd, res; for (k = 0; k <= qd; k++) printf "%d%s", Q[k], (k < qd ? "," : "\n")
  if (res != 0) { printf "FB2-CELL %s verdict=COMPLEX-RESIDUE\n", label; LAWN = 0; LAWD = 1; return 0 }
  real_zeros(qd)
  if (!law_zero(qd)) { printf "FB2-CELL %s real-zeros=%d verdict=LAGS (no staggered zero)\n", label, nr; LAWN = 0; LAWD = 1; return 0 }
  bad = 0; for (k = 0; k < nr; k++) { if (k == LAWIDX) continue; u = RN[k] / RD[k]; if (u < 0) u = 0 - u; if (u > 2 && u * LAWD < 2 * LAWN) bad++ }
  zcount = zcount_below_law(qd); extra = (SC_DEG < 0) ? -1 : zcount - (qd - 1)
  # (iii) the other zeros of D_n: visible-degenerate (classes with multiplicity > 1) at u = P_n(2 + E) and invisible at u = P_n(2 + E_c); rational lower bounds on their energies
  has_vis = 0; for (i = 0; i < ncl; i++) if (CLM[i] > 1) has_vis = 1
  has_inv = (t < 3)
  # the smallest pi-direction energy e(pi) >= 2 (n=2), 1/2 (n=4: 2 - sqrt2 = 0.586), 1/8 (n=8: 2 - 2cos(pi/8) = 0.152); the smallest flipped zero-direction energy 4, 2, 1/2 (n = 8: 2 - sqrt2)
  epi_n = (n == 2) ? 2 : 1; epi_d = (n == 2) ? 1 : (n == 4) ? 2 : 8; ez_n = (n == 2) ? 4 : (n == 4) ? 2 : 1; ez_d = (n == 8) ? 2 : 1
  vislo = ""; if (has_vis) { Evis_n = t * epi_n * ez_d * MD + MN * epi_d * ez_d; Evis_d = epi_d * ez_d * MD; g = gcd(Evis_n, Evis_d); Evis_n /= g; Evis_d /= g; vislo = pn_at(n, Evis_n, Evis_d); VLN = PNN; VLD = PND }
  invlo = ""; if (has_inv) { Emin_n = (ez_n * epi_d + t * epi_n * ez_d) * MD + MN * epi_d * ez_d; Emin_d = epi_d * ez_d * MD; g = gcd(Emin_n, Emin_d); Emin_n /= g; Emin_d /= g; invlo = pn_at(n, Emin_n, Emin_d); ILN = PNN; ILD = PND }
  lead = (bad == 0 && extra == 0 && (!has_vis || VLN * LAWD > 2 * LAWN * VLD) && (!has_inv || ILN * LAWD > 2 * LAWN * ILD))
  printf "FB2-LAW %s cosh=%d/%d (%s%s) real-zeros-of-N=%d other-zeros-faster=%d schur-count-in-|z|<r1=%d expected=%d visible-degenerate-zeros-u>=%s invisible-zeros-u>=%s verdict=%s\n", label, LAWN, LAWD, LAWKIND, (LAWKIND == "RATIONAL-ZERO" ? "" : " to 2^-40: cosh in [" dec(0 - RN[LAWIDX], 2 * RD[LAWIDX], 10) ", " dec(0 - RN[LAWIDX] + 1, 2 * RD[LAWIDX], 10) "]"), nr, bad, zcount, qd - 1, (has_vis ? vislo : "none"), (has_inv ? invlo : "none"), (lead ? "LEADS" : "LAGS")
  # the integer members of the degenerate and invisible cosh lists (n = 2 KAT): T_n(1 + E/2) with E integer -- listed at MD = 1 only
  KATLIST = ""
  if (n == 2 && MD == 1) { delete SEEN
    # visible-degenerate: every visible class with multiplicity > 1: E integer = (its E' ) -- at n = 2 all e = 2 on pi directions so E = 2t + MN
    for (i = 0; i < ncl; i++) if (CLM[i] > 1) { kk = CLE[i, 0]; u = 2 * (1 + kk / 2) * (1 + kk / 2) - 1; if (!(u in SEEN)) { SEEN[u] = 1; KATLIST = KATLIST (KATLIST == "" ? "" : ",") u } }
    # invisible: a >= 1 flipped zero-directions (e = 4 each), the pi directions e = 2 each: E = 4 a + 2 t + MN
    for (kk = 1; kk <= 3 - t; kk++) { u = 2 * (1 + (4 * kk + 2 * t + MN) / 2) * (1 + (4 * kk + 2 * t + MN) / 2) - 1; if (!(u in SEEN)) { SEEN[u] = 1; KATLIST = KATLIST (KATLIST == "" ? "" : ",") u } } }
  return lead
}
# ---- the strip cells: F(v) from an FP3-COSHPOLY line, degree 12 in v = z + 1/z = 2 cosh; the law's zero and the Schur-Cohn count
function strip_cell(label, coeffs,   nc, k, qd, g, bad, zcount, u, extra) {
  nc = split(coeffs, CF, ","); qd = nc - 1; while (qd > 0 && CF[qd + 1] + 0 == 0) qd--
  g = 0; for (k = 0; k <= qd; k++) g = gcd(g, CF[k + 1] + 0); if (g == 0) g = 1; for (k = 0; k <= qd; k++) Q[k] = (CF[k + 1] + 0) / g
  real_zeros(qd); if (!law_zero(qd)) { printf "FB2-STRIP %s degree=%d real-zeros=%d verdict=LAGS (no staggered zero)\n", label, qd, nr; return 0 }
  bad = 0; for (k = 0; k < nr; k++) { if (k == LAWIDX) continue; u = RN[k] / RD[k]; if (u < 0) u = 0 - u; if (u > 2 && u * LAWD < 2 * LAWN) bad++ }
  zcount = zcount_below_law(qd); extra = (SC_DEG < 0) ? -1 : zcount - (qd - 1)
  printf "FB2-STRIP %s degree=%d cosh=%d/%d (%s%s) real-zeros=%d other-zeros-faster=%d schur-count-in-|z|<r1=%d expected=%d verdict=%s\n", label, qd, LAWN, LAWD, LAWKIND, (LAWKIND == "RATIONAL-ZERO" ? "" : " to 2^-40: cosh in [" dec(0 - RN[LAWIDX], 2 * RD[LAWIDX], 10) ", " dec(0 - RN[LAWIDX] + 1, 2 * RD[LAWIDX], 10) "]"), nr, bad, zcount, qd - 1, (bad == 0 && extra == 0) ? "LEADS" : "LAGS"
  return (bad == 0 && extra == 0)
}
BEGIN {
  if (FP == "") FP = "STDLIB/build/holoklerosis/fibre_pole.2026-11-02a.txt"; if (FTQ == "") FTQ = "STDLIB/build/holoklerosis/fibre_time_quad.2026-11-02a.txt"; if (FP3 == "") FP3 = "STDLIB/build/holoklerosis/fibre_pole3.2026-11-02a.txt"
  print "FB2-INSTRUMENT fibre_block2.awk: V_n at every cell by the Chebyshev product and the partial fraction (the csc^4 limit at E = 0); the zero set of D_n = N(u)'s zeros, the visible-degenerate zeros and the invisible aliases' zeros; exact in Z[zeta_2n]; the strip cells' leading-ness from FP3-COSHPOLY"
  while ((getline line < FP) > 0) { sub(/\r$/, "", line); if (line ~ /^FP-LAW /) { s = line; sub(/.*cosh=3\+2npi\+m2=/, "", s); sub(/ .*$/, "", s); nlaw++; LAWREC[nlaw] = s } }
  close(FP)
  while ((getline line < FTQ) > 0) { sub(/\r$/, "", line); if (line ~ /^FTQ-CELL record=FP /) { split(line, f, " "); key = f[3] " " f[4]; s = line; sub(/.*unstaggered-integer-cosh=/, "", s); sub(/ .*$/, "", s); UNST[key] = s } }
  close(FTQ)
  kat = 0; katof = 0; k = 0
  split("1 1 1 0 1;-1 1 1 0 1;-1 -1 1 0 1;-1 -1 -1 0 1;1 1 1 1 4;1 1 1 1 1;-1 1 1 1 4;-1 -1 -1 1 1", CELLS, ";")
  for (c = 1; c <= 8; c++) { split(CELLS[c], f, " "); e1 = (f[1] == -1); e2 = (f[2] == -1); e3 = (f[3] == -1); MN = f[4] + 0; MD = f[5] + 0; k++
    cell(2, e1, e2, e3, MN, MD)
    want = LAWREC[k]; split(want, w, "/"); same = ((w[1] + 0) * LAWD == LAWN * (w[2] + 0))
    key = sprintf("Kperp=(%s,%s,%s) m2=%d/%d", (e1 ? "pi" : "0"), (e2 ? "pi" : "0"), (e3 ? "pi" : "0"), MN, MD); rec = (key in UNST) ? UNST[key] : "absent"
    n1 = split(KATLIST, L1, ","); nint = 0; delete L2; for (i = 1; i <= n1; i++) if (L1[i] == int(L1[i])) L2[++nint] = L1[i] + 0; asort(L2); sorted = ""; for (i = 1; i <= nint; i++) sorted = sorted (i > 1 ? "," : "") L2[i]
    invok = (MD == 1) ? ((rec == "none" && sorted == "") || (rec == sorted)) : (rec == "none")
    printf "FB2-KAT %s law=%d/%d record=%s %s; D's other zeros' integer cosh=%s record=%s %s\n", key, LAWN, LAWD, want, (same ? "MET" : "PARTED"), (MD == 1 ? (sorted == "" ? "none" : sorted) : "(m2 = 1/4: none integer)"), rec, (invok ? "MET" : "PARTED")
    katof++; if (same && invok) kat++
  }
  leads = 0; cells = 0
  for (n = 4; n <= 8; n *= 2) for (c = 1; c <= 8; c++) { split(CELLS[c], f, " "); e1 = (f[1] == -1); e2 = (f[2] == -1); e3 = (f[3] == -1); MN = f[4] + 0; MD = f[5] + 0; cells++; leads += cell(n, e1, e2, e3, MN, MD) }
  # the strip cells
  strips = 0; sleads = 0
  while ((getline line < FP3) > 0) { sub(/\r$/, "", line); if (line ~ /^FP3-COSHPOLY /) { split(line, f, " "); label = f[2] " " f[3] " " f[4] " " f[5]; s = line; sub(/.*coefficients\(v=z\+1\/z=-2cosh\)=/, "", s); strips++; sleads += strip_cell(label, s) } }
  close(FP3)
  printf "FB2-END kat=%d of %d cells(n=4,8)=%d leading=%d strip-cells=%d strip-leading=%d verdict=%s\n", kat, katof, cells, leads, strips, sleads, (kat == katof && katof > 0 && leads == cells && sleads == strips) ? "MET" : "PARTED"
  exit 0
}
