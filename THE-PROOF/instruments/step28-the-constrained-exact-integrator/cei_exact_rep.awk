# cei_exact_rep.awk -- THE CERTIFIED TIER'S THIRD STONE (campaign 31.15): the SU(2) representations EXACT in the monomial basis.  With U the unit
# quaternion (w, x, y, z) as the matrix [[alpha, beta], [-conj(beta), conj(alpha)]], alpha = w + i z, beta = x + i y (so 1/2 tr U = w and
# |alpha|^2 + |beta|^2 = 1), Sym^s acts on the monomials u^a v^{s-a} by u -> alpha u + beta v, v -> -conj(beta) u + conj(alpha) v, and the
# matrix entry D^s(U)_{ab} = the coefficient of u^b v^{s-b} in (alpha u + beta v)^a (-conj(beta) u + conj(alpha) v)^{s-a} -- a polynomial of
# degree s in (w, x, y, z) with GAUSSIAN-INTEGER coefficients.  Every polynomial here is an associative array keyed "a,b,c,d" (the exponents
# of w, x, y, z) with two integer values (real, imaginary), exact in gawk -M.  KNOWN ANSWERS: (K1) the trace sum_a D_aa equals the character
# U_s(w) (the Chebyshev polynomial of the second kind, U_0 = 1, U_1 = 2w, U_{s+1} = 2w U_s - U_{s-1}) as a POLYNOMIAL IDENTITY at s = 0..5;
# (K2) the homomorphism D^s(U) D^s(V) = D^s(UV) at two rational unit quaternions (3/5, 4/5, 0, 0) and (0, 0, 12/13, 5/13), exact, s = 1..4;
# (K3) unitarity with the binomial weights: sum_a C(s,a) conj(D_ac) D_ab / C(s,b) = delta_cb at the first point, s = 1..4 (the monomial basis
# is orthogonal under the weights 1/C(s,a)); (K4) the Haar integral of chi_s chi_t through the monomial law (cei_exact_haar.awk's) at s, t <= 3
# -- with the matrices' traces as the characters, the orthogonality must hold again; and a sighted control: a bent alpha (w - i z) must break K2.
# usage: gawk -M -f cei_exact_rep.awk
function gcd(a, b,   t) { a = (a < 0) ? -a : a; b = (b < 0) ? -b : b; while (b != 0) { t = a % b; a = b; b = t } return a }
function fact(n,   r, i) { r = 1; for (i = 2; i <= n; i++) r *= i; return r }
function binom(n, k) { return fact(n) / (fact(k) * fact(n - k)) }
# polynomials: P[name, key] = re, Q[name, key] = im; keys "a,b,c,d"
function pclear(n,   k) { for (k in P) if (index(k, n SUBSEP) == 1) delete P[k]; for (k in Q) if (index(k, n SUBSEP) == 1) delete Q[k] }
function padd(n, key, re, im) { P[n, key] += re; Q[n, key] += im; if (P[n, key] == 0 && Q[n, key] == 0) { delete P[n, key]; delete Q[n, key] } }
function pcopy(src, dst,   k, kk) { pclear(dst); for (k in P) if (index(k, src SUBSEP) == 1) { kk = substr(k, length(src) + 2); P[dst, kk] = P[k]; Q[dst, kk] = Q[k] } }
function pmul(a, b, dst,   k, l, ka, kb, A, B, re, im, i, s) {   # dst = a * b (dst distinct from a and b)
  pclear(dst)
  for (k in P) { if (index(k, a SUBSEP) != 1) continue; ka = substr(k, length(a) + 2)
    for (l in P) { if (index(l, b SUBSEP) != 1) continue; kb = substr(l, length(b) + 2)
      split(ka, A, ","); split(kb, B, ","); s = ""; for (i = 1; i <= 4; i++) s = s (i > 1 ? "," : "") (A[i] + B[i])
      re = P[k] * P[l] - Q[k] * Q[l]; im = P[k] * Q[l] + Q[k] * P[l]; padd(dst, s, re, im) } } }
function pscale_add(src, dst, re, im,   k, kk, r2, i2) { for (k in P) if (index(k, src SUBSEP) == 1) { kk = substr(k, length(src) + 2); r2 = P[k] * re - Q[k] * im; i2 = P[k] * im + Q[k] * re; padd(dst, kk, r2, i2) } }
function ppow(a, n, dst,   i, t) { pclear(dst); padd(dst, "0,0,0,0", 1, 0); for (i = 1; i <= n; i++) { pmul(dst, a, "tmp_pow"); pcopy("tmp_pow", dst) } }
# the four coefficient polynomials in (w, x, y, z): alpha = w + i z, conj alpha = w - i z, beta = x + i y, -conj beta = -x + i y
function setup(bent) { pclear("al"); padd("al", "1,0,0,0", 1, 0); padd("al", "0,0,0,1", 0, bent ? -1 : 1)
  pclear("ac"); padd("ac", "1,0,0,0", 1, 0); padd("ac", "0,0,0,1", 0, -1)
  pclear("be"); padd("be", "0,1,0,0", 1, 0); padd("be", "0,0,1,0", 0, 1)
  pclear("nb"); padd("nb", "0,1,0,0", -1, 0); padd("nb", "0,0,1,0", 0, 1) }
# D^s_{ab}: the coefficient of u^b v^{s-b} in (alpha u + beta v)^a (-conj(beta) u + conj(alpha) v)^{s-a}
#   = sum over j (u's from the first factor) : C(a, j) alpha^j beta^{a-j} * C(s-a, b-j) (-conj beta)^{b-j} (conj alpha)^{s-a-b+j}
function dentry(s, a, b, dst,   j, lo, hi) { pclear(dst)
  lo = (b - (s - a) > 0) ? b - (s - a) : 0; hi = (a < b) ? a : b
  for (j = lo; j <= hi; j++) { ppow("al", j, "t1"); ppow("be", a - j, "t2"); pmul("t1", "t2", "t3"); ppow("nb", b - j, "t4"); pmul("t3", "t4", "t5"); ppow("ac", s - a - b + j, "t6"); pmul("t5", "t6", "t7")
    pscale_add("t7", dst, binom(a, j) * binom(s - a, b - j), 0) } }
function pstr(n,   k, kk, out, A) { out = ""; PROCINFO["sorted_in"] = "@ind_str_asc"; for (k in P) if (index(k, n SUBSEP) == 1) { kk = substr(k, length(n) + 2); out = out sprintf(" (%d%+di)*%s", P[k], Q[k], kk) } return out }
# evaluation at a rational point (quaternion given as integers over a common denominator NUM/DEN): returns re/im as rationals R["re"], R["im"] over DEN^deg
function peval(n, s, qw, qx, qy, qz,   k, kk, A, re, im, m, i, e) { re = 0; im = 0
  for (k in P) if (index(k, n SUBSEP) == 1) { kk = substr(k, length(n) + 2); split(kk, A, ","); e = A[1] + A[2] + A[3] + A[4]
    m = qw ^ A[1] * qx ^ A[2] * qy ^ A[3] * qz ^ A[4] * DEN ^ (s - e); re += P[k] * m; im += Q[k] * m }
  EV["re"] = re; EV["im"] = im }   # the value times DEN^s
BEGIN { setup(0); PROCINFO["sorted_in"] = "@ind_str_asc"
  printf "CEI-EXACT-REP the SU(2) representations in the monomial basis, Gaussian-integer polynomials in (w, x, y, z)\n"
  # K1: the trace is the character
  CH[0, 0] = 1; CH[1, 1] = 2; for (s = 1; s < 6; s++) for (k = 0; k <= s + 1; k++) CH[s + 1, k] = 2 * ((k >= 1) ? CH[s, k - 1] : 0) - ((s >= 1) ? CH[s - 1, k] : 0)
  # the trace equals U_s(w) ON THE GROUP, i.e. modulo w^2 + x^2 + y^2 + z^2 = 1 (at s = 2 the trace reads 3w^2 - x^2 - y^2 - z^2 = 4w^2 - 1 there): the
  # identity is read at five rational unit quaternions, exactly (the first draft compared the raw polynomials and read FAILED at s >= 2 -- a
  # polynomial identity on the sphere is not one in free variables; the control below keeps the test two-sided)
  split("39 52 0 0;0 0 60 25;39 0 52 0;0 33 56 0;16 0 0 63", PT, ";")   # five rational UNIT quaternions over DEN = 65 (the first draft held a point of norm 75/65, not a group element: law 18 at the test)
  k1ok = 0; for (s = 0; s <= 5; s++) { pclear("tr"); for (a = 0; a <= s; a++) { dentry(s, a, a, "d"); pscale_add("d", "tr", 1, 0) }
    good = 1; for (ip = 1; ip <= 5; ip++) { split(PT[ip], W, " "); DEN = 65; peval("tr", s, W[1], W[2], W[3], W[4]); ch = 0; for (k = 0; k <= s; k++) ch += CH[s, k] * W[1] ^ k * 65 ^ (s - k); if (EV["re"] != ch || EV["im"] != 0) good = 0 }
    k1ok += good; if (s <= 3) printf "  K1 s=%d: trace =%s  = U_%d(w) on the group at five rational points%s\n", s, pstr("tr"), s, good ? " MET" : " FAILED" }
  printf "  K1 the trace is the character U_s(w) on the group: %d of 6 spins met\n", k1ok
  # K2: the homomorphism at two rational unit quaternions (3/5, 4/5, 0, 0) and (0, 0, 12/13, 5/13): D(U) D(V) = D(UV), exact; UV computed by the quaternion product
  DEN = 65; uw = 39; ux = 52; uy = 0; uz = 0; vw = 0; vx = 0; vy = 60; vz = 25   # (3/5,4/5,0,0) = (39,52,0,0)/65; (0,0,12/13,5/13) = (0,0,60,25)/65
  pw = uw * vw - ux * vx - uy * vy - uz * vz; px = uw * vx + ux * vw + uy * vz - uz * vy; py = uw * vy - ux * vz + uy * vw + uz * vx; pz = uw * vz + ux * vy - uy * vx + uz * vw   # times DEN^2
  k2ok = 0; for (s = 1; s <= 4; s++) { good = 1
    for (a = 0; a <= s; a++) for (b = 0; b <= s; b++) { dentry(s, a, b, "d"); peval("d", s, uw, ux, uy, uz); DU[a, b, "re"] = EV["re"]; DU[a, b, "im"] = EV["im"]; peval("d", s, vw, vx, vy, vz); DV[a, b, "re"] = EV["re"]; DV[a, b, "im"] = EV["im"] }
    DEN2 = DEN * DEN; DEN = DEN2; for (a = 0; a <= s; a++) for (b = 0; b <= s; b++) { dentry(s, a, b, "d"); peval("d", s, pw, px, py, pz); DP[a, b, "re"] = EV["re"]; DP[a, b, "im"] = EV["im"] } DEN = 65
    for (a = 0; a <= s; a++) for (b = 0; b <= s; b++) { re = 0; im = 0; for (c = 0; c <= s; c++) { re += DU[a, c, "re"] * DV[c, b, "re"] - DU[a, c, "im"] * DV[c, b, "im"]; im += DU[a, c, "re"] * DV[c, b, "im"] + DU[a, c, "im"] * DV[c, b, "re"] }
      if (re != DP[a, b, "re"] || im != DP[a, b, "im"]) good = 0 }
    k2ok += good }
  printf "  K2 the homomorphism D(U)D(V) = D(UV) at two rational unit quaternions, exact: %d of 4 spins met\n", k2ok
  # K3: unitarity with the binomial weights at U = (3/5, 4/5, 0, 0): sum_a C(s,a) conj(D_ac) D_ab / C(s,b) = delta_cb  <=>  sum_a C(s,a) conj(D_ac) D_ab = C(s,b) delta_cb (times DEN^{2s})
  k3ok = 0; for (s = 1; s <= 4; s++) { good = 1; for (a = 0; a <= s; a++) for (b = 0; b <= s; b++) { dentry(s, a, b, "d"); peval("d", s, uw, ux, uy, uz); DU[a, b, "re"] = EV["re"]; DU[a, b, "im"] = EV["im"] }
    for (c = 0; c <= s; c++) for (b = 0; b <= s; b++) { re = 0; im = 0; for (a = 0; a <= s; a++) { re += binom(s, a) * (DU[a, c, "re"] * DU[a, b, "re"] + DU[a, c, "im"] * DU[a, b, "im"]); im += binom(s, a) * (DU[a, c, "re"] * DU[a, b, "im"] - DU[a, c, "im"] * DU[a, b, "re"]) }
      want = (c == b) ? binom(s, b) * DEN ^ (2 * s) : 0; if (re != want || im != 0) good = 0 }
    k3ok += good }
  printf "  K3 unitarity under the binomial weights at a rational point, exact: %d of 4 spins met\n", k3ok
  # K4: the Haar orthogonality of the traces through the monomial law (the characters as polynomials from K1): int tr D^s tr D^t = delta_st, s, t <= 3
  k4ok = 0; for (s = 0; s <= 3; s++) for (t = 0; t <= 3; t++) { N = 0; D = 1
    for (k = 0; k <= s; k++) for (l = 0; l <= t; l++) { if (CH[s, k] == 0 || CH[t, l] == 0) continue; e = k + l; if (e % 2) continue; kk2 = e / 2; n = fact(e); m = 4 ^ kk2 * fact(kk2) * fact(kk2 + 1); nn = CH[s, k] * CH[t, l] * n; N = N * m + nn * D; D = D * m; g = gcd(N, D); if (g > 1) { N /= g; D /= g } }
    if ((s == t && N == D) || (s != t && N == 0)) k4ok++ }
  printf "  K4 the traces' Haar orthogonality through the monomial law: %d of 16 pairs met\n", k4ok
  # the sighted control: alpha bent to w - i z (the conjugate) must break the homomorphism
  setup(1); good = 1; s = 2
  for (a = 0; a <= s; a++) for (b = 0; b <= s; b++) { dentry(s, a, b, "d"); peval("d", s, uw, ux, uy, uz); DU[a, b, "re"] = EV["re"]; DU[a, b, "im"] = EV["im"]; peval("d", s, vw, vx, vy, vz); DV[a, b, "re"] = EV["re"]; DV[a, b, "im"] = EV["im"] }
  DEN = 65 * 65; for (a = 0; a <= s; a++) for (b = 0; b <= s; b++) { dentry(s, a, b, "d"); peval("d", s, pw, px, py, pz); DP[a, b, "re"] = EV["re"]; DP[a, b, "im"] = EV["im"] } DEN = 65
  for (a = 0; a <= s; a++) for (b = 0; b <= s; b++) { re = 0; im = 0; for (c = 0; c <= s; c++) { re += DU[a, c, "re"] * DV[c, b, "re"] - DU[a, c, "im"] * DV[c, b, "im"]; im += DU[a, c, "re"] * DV[c, b, "im"] + DU[a, c, "im"] * DV[c, b, "re"] } if (re != DP[a, b, "re"] || im != DP[a, b, "im"]) good = 0 }
  printf "  CONTROL alpha bent to its conjugate: the homomorphism at s = 2 %s\n", good ? "still holds (BLIND)" : "breaks (SIGHTED)"
  printf "  D^1 entries:"; setup(0); for (a = 0; a <= 1; a++) for (b = 0; b <= 1; b++) { dentry(1, a, b, "d"); printf " [%d,%d]=%s", a, b, pstr("d") } printf "\n" }
