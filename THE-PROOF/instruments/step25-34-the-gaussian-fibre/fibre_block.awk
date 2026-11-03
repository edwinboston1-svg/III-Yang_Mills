# fibre_block.awk -- THE BLOCKED GAUSSIAN FIBRE AT EVERY LEVEL, EXACT (ΟΛΟΚΛΗΡΩΣΙΣ Addendum IV; the development's delegation (iii),
# 2026-11-03).  THE FACTORIZATION: the fibre determinant of the block average over n^4 blocks is D_n(K) = det J(K) * V_n(K), with J the
# fine symbol over the n^4 aliases k_c = (K + 2 pi c)/n (Jacobi's complementary-minor identity: the determinant of a matrix compressed
# to the orthogonal complement of a unit vector u is det M * u^H M^{-1} u, and u^H J^{-1} u is the variance of the block average), so
#   D_n = sum_c |f_n(k_c)|^2 prod_{c' != c} h(k_{c'}),   h(k) = sum_mu (2 - 2 cos k_mu) + m^2,   |f_n(k)|^2 = prod_mu (2 - 2 cos n k_mu) / (n^2 (2 - 2 cos k_mu)),
# a polynomial, and its zeros are of two kinds: THE LAW -- the zeros of the block-average variance V_n (at K_perp = 0, m = 0 the
# longitudinal aliases alone, the transverse ones having |f_n|^2 = 0: V_n ∝ (2 - 2 cos K) sum_c (2 - 2 cos k_c)^{-2}, which the
# cosecant-sum identity sum_c csc^4(theta + pi c/n) = n^4 csc^4(n theta) + (2/3)(n^2 - n^4) csc^2(n theta) turns into
# (n^2/4) csc^2(K/2) - (n^2 - 1)/6, zero at cos K = -(2n^2 + 1)/(n^2 - 1): cosh kappa_n = (2n^2 + 1)/(n^2 - 1) per n-block -- 3 at
# n = 2 (Ο1), 11/5 at n = 4, 43/21 at n = 8, 2 as n -> infinity) and THE INVISIBLE ALIASES -- the aliases the average does not see
# (|f_n|^2 = 0: a transverse momentum 2 pi c_mu / n != 0) whose fine pole h = 0 survives in D_n as a zero: cos k_0 = 1 + j (j the
# transverse energy sum (1 - cos k_mu), an integer or half-integer, plus m^2/2) and cos K = T_n(1 + j), the Chebyshev polynomial of the
# block size: at n = 2, T_2(x) = 2x^2 - 1 gives 2(1 + 2 n_pi)^2 - 1 = 8 n_pi^2 + 8 n_pi + 1 (17, 49, 97: Addendum II's first family, staked
# UNGUESSED, now derived) and at K_perp = (pi,0,0), with j = 1 + 2n', T_2(2 + 2n') = 8(1 + n')^2 - 1 (7, 31, 71: the second family).
# THIS INSTRUMENT verifies the factorization against the committed record (the full 16-alias sum at n = 2 reproduces Ο1's FP-COEFFS
# polynomial, the KAT) and the law at n = 2, 4, 8 by EXACT polynomial arithmetic in w = e^{iK/n} with coefficients in Z[zeta_n] =
# Z[x]/Phi_n(x) (x + 1, x^2 + 1, x^4 + 1), sharing no line with the cosecant identity: the longitudinal numerator
# N_n(w) = sum_c (w zeta^c)^2 prod_{c' != c} (w zeta^{c'} - 1)^4 must come out with every coefficient in Z (the zeta components zero),
# supported on powers w^{nj}, and divisible by the law's quadratic (n^2 - 1) z^2 + 2(2n^2 + 1) z + (n^2 - 1) in z = w^n.
# Alphabet (infix-free): MET / PARTED / DIVIDES / DOES-NOT-DIVIDE / REAL / COMPLEX-RESIDUE.  gawk -M; 0 - x never -x.
# usage: gawk -M -f fibre_block.awk [-v FP=fibre_pole.2026-11-02a.txt]
# ---- Z[x]/Phi_n: an element is an array of n/2 integers (1 for n = 2), index 0..deg-1; multiplication reduced by Phi_n
function zdeg(n) { return (n == 2) ? 1 : n / 2 }
function zclr(a, n,   i) { for (i = 0; i < zdeg(n); i++) a[i] = 0 }
function zmul(a, b, c, n,   i, j, d, t) {   # c = a * b in Z[x]/Phi_n;  Phi_2 = x + 1 (x = -1), Phi_4 = x^2 + 1, Phi_8 = x^4 + 1: x^d = -1
  d = zdeg(n); for (i = 0; i < d; i++) T[i] = 0
  for (i = 0; i < d; i++) for (j = 0; j < d; j++) { t = a[i] * b[j]; if (i + j < d) T[i + j] += t; else T[i + j - d] -= t }
  for (i = 0; i < d; i++) c[i] = T[i]
}
# ---- polynomials in w with Z[x]/Phi_n coefficients: P[k, i] = coefficient of w^k, component x^i; degree PD
function pclr(P, pd,   k, i) { for (k = 0; k <= pd; k++) for (i = 0; i < 8; i++) P[k, i] = 0 }
function pmul(A, da, B, db, C, n,   k, l, i, d) {   # C = A * B, degree da + db
  d = zdeg(n); pclr(C, da + db)
  for (k = 0; k <= da; k++) for (l = 0; l <= db; l++) { for (i = 0; i < d; i++) { ZA[i] = A[k, i]; ZB[i] = B[l, i] } zmul(ZA, ZB, ZC, n); for (i = 0; i < d; i++) C[k + l, i] += ZC[i] }
  return da + db
}
function pcopy(S, ds, D,   k, i) { pclr(D, ds); for (k = 0; k <= ds; k++) for (i = 0; i < 8; i++) D[k, i] = S[k, i] }
# zeta^c as an element: x^c reduced (x^d = -1)
function zpow(c, n, out,   d, e, s) { d = zdeg(n); zclr(out, n); if (n == 2) { out[0] = (c % 2 == 0) ? 1 : 0 - 1; return } e = c % (2 * d); s = 1; if (e >= d) { e -= d; s = 0 - 1 } out[e] = s }
# the longitudinal numerator N_n(w) = sum_c (w zeta^c)^2 prod_{c' != c} (w zeta^{c'} - 1)^4
function longitudinal(n,   c, cp, i, d, dl, dq, df, k) {
  d = zdeg(n); pclr(NN, 2 + 4 * (n - 1)); dn = 2 + 4 * (n - 1)
  for (c = 0; c < n; c++) {
    # term = (w zeta^c)^2 : degree 2, coefficient zeta^{2c} at w^2
    pclr(TM, 2); zpow(2 * c, n, ZZ); for (i = 0; i < d; i++) TM[2, i] = ZZ[i]; dl = 2
    for (cp = 0; cp < n; cp++) { if (cp == c) continue
      # linear factor (w zeta^{cp} - 1): degree 1
      pclr(LF, 1); zpow(cp, n, ZZ); for (i = 0; i < d; i++) LF[1, i] = ZZ[i]; LF[0, 0] = 0 - 1
      for (k = 0; k < 4; k++) { dq = pmul(TM, dl, LF, 1, PR, n); pcopy(PR, dq, TM); dl = dq } }
    for (k = 0; k <= dl; k++) for (i = 0; i < d; i++) NN[k, i] += TM[k, i]
  }
  return dn
}
function gcd(a, b,   t) { if (a < 0) a = 0 - a; if (b < 0) b = 0 - b; while (b != 0) { t = a % b; a = b; b = t } return a }
# the full 16-alias fibre determinant at n = 2, K_perp = (0,0,0), mass MN/MD: D(w) = sum_a |f|^2 prod_{a' != a} h(k_a'), in w = e^{iK/2},
# scaled by MD^15 * w^16 so every coefficient is an integer; h(k_a) * MD = MD (2 - 2 cos k_a0) + 4 MD n_pi(a) + MN, 2 - 2cos k_0 = -(w s - 1)^2/(w s),
# s = (-1)^{a0}; |f(k_a)|^2 = (1 + s cos(K/2)...) -- in w: |1 + w s|^2 / 4 per longitudinal, and the transverse factor (1 + cos pi a_mu)/2 = [a_mu = 0]
function level1_full(MN, MD, OUT,   a0, a1, a2, a3, npi, s, k, i, deg, degp, aa, tot) {
  # only aliases with a_perp = 0 have a nonzero form factor: two terms (a0 = 0, 1), each times the product over the other 15 aliases
  # h(k_a) w s MD = MD(w s - 1)^2 * (-1) + (4 MD n_pi + MN) w s  -> as a polynomial in w: -MD s^2 w^2 + (2 MD s + (4 MD n_pi + MN) s) w - MD... with s^2 = 1:
  #   H_a(w) = -MD w^2 + s (2 MD + 4 MD n_pi + MN) w - MD        (this is w s h MD, the factor w s cleared; a common w^15 and signs tracked below)
  pclr(OUT, 40); deg = 0   # cleared to the top degree: a cleared index 0 alone left the previous mass's coefficients in place (the first run read the KAT PARTED on two of three cells for that)
  for (a0 = 0; a0 < 2; a0++) { s = (a0 == 0) ? 1 : 0 - 1
    # the form factor |f|^2 * 4 = |1 + w s|^2 = (1 + w s)(1 + s/w) = (w s + 1)^2/(w s) -> as a polynomial times 1/w: (ws + 1)^2 = w^2 + 2 s w + 1 (s^2 = 1)
    pclr(TM, 2); TM[0, 0] = 1; TM[1, 0] = 2 * s; TM[2, 0] = 1; degp = 2
    for (aa = 0; aa < 16; aa++) { if (aa == a0 * 8) continue   # the alias (a0, 0, 0, 0) itself is the one divided out
      a1 = int(aa / 4) % 2; a2 = int(aa / 2) % 2; a3 = aa % 2; npi = a1 + a2 + a3; sp = (int(aa / 8) == 0) ? 1 : 0 - 1
      pclr(LF, 2); LF[0, 0] = 0 - MD; LF[1, 0] = sp * (2 * MD + 4 * MD * npi + MN); LF[2, 0] = 0 - MD
      degp = pmul(TM, degp, LF, 2, PR, 2); pcopy(PR, degp, TM) }
    for (k = 0; k <= degp; k++) OUT[k, 0] += TM[k, 0]; if (degp > deg) deg = degp }
  return deg
}
BEGIN {
  print "FB-INSTRUMENT fibre_block.awk: the factorization D_n = det J * V_n and the law cosh kappa_n = (2n^2 + 1)/(n^2 - 1) by exact polynomial arithmetic"
  # ---- THE KAT: the full 16-alias sum at n = 2 against Ο1's FP-COEFFS at Kperp = (0,0,0), m^2 = 0/1, 1/4, 1/1 (read from the record)
  if (FP == "") FP = "STDLIB/build/holoklerosis/fibre_pole.2026-11-02a.txt"
  while ((getline line < FP) > 0) { sub(/\r$/, "", line); if (line ~ /^FP-COEFFS Kperp=\(0,0,0\) /) { split(line, f, " "); m2 = f[3]; sub(/^m2=/, "", m2); s = line; sub(/.*coefficients=/, "", s); REC[m2] = s } }
  close(FP)
  kat = 0; katof = 0
  for (m2 in REC) { split(m2, mm, "/"); MN = mm[1] + 0; MD = mm[2] + 0
    deg = level1_full(MN, MD, DD)
    # the record's polynomial in z: strip the power of z and the content; ours is in w = sqrt z: keep the even powers (the odd must vanish), strip the power of w and the content
    nrec = split(REC[m2], RC, ","); low = 0; while (low < nrec - 1 && RC[low + 1] + 0 == 0) low++
    g = 0; for (k = low + 1; k <= nrec; k++) g = gcd(g, RC[k] + 0); for (k = low + 1; k <= nrec; k++) RP[k - low - 1] = (RC[k] + 0) / g; rdeg = nrec - low - 1
    odd = 0; for (k = 1; k <= deg; k += 2) if (DD[k, 0] != 0) odd++
    wlow = 0; while (wlow < deg && DD[wlow, 0] == 0) wlow += 2
    g = 0; for (k = wlow; k <= deg; k += 2) g = gcd(g, DD[k, 0]); if (g == 0) g = 1
    same = 1; nz = 0; for (k = wlow; k <= deg; k += 2) { nz++; v = DD[k, 0] / g; if (nz - 1 > rdeg || v != RP[nz - 1] * ((RP[0] * v < 0) ? 0 - 1 : 1)) same = 0 }
    if (nz - 1 != rdeg) same = 0
    # sign: the primitive parts may differ by a global sign; compare up to that
    sgn = (RP[0] * (DD[wlow, 0] / g) < 0) ? 0 - 1 : 1; same = 1; for (k = wlow; k <= deg; k += 2) { idx = (k - wlow) / 2; if (idx > rdeg || DD[k, 0] / g != sgn * RP[idx]) same = 0 } if ((deg - wlow) / 2 != rdeg) same = 0
    printf "FB-KAT n=2 Kperp=(0,0,0) m2=%s odd-powers=%d record-degree=%d ours-degree=%d primitive-parts=%s\n", m2, odd, rdeg, (deg - wlow) / 2, (same && odd == 0) ? "MET" : "PARTED"
    katof++; if (same && odd == 0) kat++
  }
  # ---- THE LAW at n = 2, 4, 8 from the longitudinal numerator in Z[zeta_n]
  laws = 0
  for (n = 2; n <= 8; n *= 2) {
    dn = longitudinal(n); d = zdeg(n)
    res = 0; for (k = 0; k <= dn; k++) for (i = 1; i < d; i++) if (NN[k, i] != 0) res++        # the zeta components must vanish
    supp = 0; for (k = 0; k <= dn; k++) if (k % n != 0 && NN[k, 0] != 0) supp++               # only powers w^{nj}
    # the polynomial in z = w^n: Z[j] = NN[n j, 0]; strip the content and the power of z
    nz = 0; for (k = 0; k <= dn; k += n) ZP[nz++] = NN[k, 0]; zlow = 0; while (zlow < nz - 1 && ZP[zlow] == 0) zlow++
    g = 0; for (j = zlow; j < nz; j++) g = gcd(g, ZP[j]); if (g == 0) g = 1; for (j = zlow; j < nz; j++) Q[j - zlow] = ZP[j] / g; qd = nz - 1 - zlow
    printf "FB-LONG n=%d degree-in-w=%d zeta-residue=%d off-support=%d polynomial-in-z(primitive, z^%d stripped)=", n, dn, res, supp, zlow
    for (j = 0; j <= qd; j++) printf "%d%s", Q[j], (j < qd ? "," : "\n")
    # divide by (n^2 - 1) z^2 + 2(2n^2 + 1) z + (n^2 - 1), primitive (gcd of the three)
    qa = n * n - 1; qb = 2 * (2 * n * n + 1); gq = gcd(qa, qb); qa /= gq; qb /= gq
    for (j = 0; j <= qd; j++) R[j] = Q[j]; ok = 1
    for (j = qd; j >= 2; j--) { if (R[j] % qa != 0) { ok = 0; break } t = R[j] / qa; R[j] = 0; R[j - 1] -= qb * t; R[j - 2] -= qa * t }
    div = (ok && R[0] == 0 && R[1] == 0)
    printf "FB-LAW n=%d cosh=(2n^2+1)/(n^2-1)=%d/%d quadratic=%d z^2 + %d z + %d %s %s\n", n, 2 * n * n + 1, n * n - 1, qa, qb, qa, div ? "DIVIDES" : "DOES-NOT-DIVIDE", (res == 0 && supp == 0) ? "REAL" : "COMPLEX-RESIDUE"
    if (div && res == 0 && supp == 0) laws++
  }
  printf "FB-END kat=%d of %d laws=%d of 3 verdict=%s\n", kat, katof, laws, (kat == katof && katof > 0 && laws == 3) ? "MET" : "PARTED"
  exit 0
}
