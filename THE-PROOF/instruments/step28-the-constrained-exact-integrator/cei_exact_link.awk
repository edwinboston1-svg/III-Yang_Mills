# cei_exact_link.awk -- THE CERTIFIED TIER'S FOURTH STONE (campaign 31.15): a link's STAPLE-WEIGHTED CHARACTER INTEGRAL, exact, by two roads
# sharing no line.  At the identity datum every staple of a link weighs  1 + sum_k c_k U_k(w)  (the Wilson weight in characters to the cap K,
# c_k the certified Wilson coefficients, w = 1/2 tr U), so a link with n staples and slot spins s_1..s_m contributes the scalar
#    S(n; s_1..s_m) = int (1 + sum_k c_k U_k(w))^n prod_j U_{s_j}(w) dmu(U)   (the trace over each slot's pair of wires; chi_s(U^{-1}) = chi_s(U)),
# a polynomial in w integrated by the monomial law  int w^{2m} dmu = (2m)! / (4^m m! (m+1)!)  -- ROAD A, exact rationals (gawk -M), the c_k as
# rationals with denominator 10^40 cut from cei_exact_bessel's enclosures.  ROAD B: the class measure (2/pi) sin^2(theta) dtheta on [0, pi] with
# w = cos(theta), the integrand smooth and periodic, the trapezoidal rule converging geometrically -- 400 points at 60 digits (MPFR, -M), the
# same c_k as decimals; no formula of road A used.  KNOWN ANSWERS: n = 0 gives the orthogonality S(0; s, t) = delta_st; at n = 1 the spin-1 slot
# reads S(1; 1) / (2 S(1; 0)) = c_1/2 by orthogonality (the coefficient's placement checked), and that value must meet the engine's free-datum
# quadrature <1/2 tr U_p> = 4.644790252704e-01 (a different instrument, 13 digits); the two roads must agree far below 1e-40 on every scalar; a
# bent coefficient (c_2 doubled on road B alone) must part them.   usage: gawk -M -f cei_exact_link.awk
function gcd(a, b,   t) { a = (a < 0) ? -a : a; b = (b < 0) ? -b : b; while (b != 0) { t = a % b; a = b; b = t } return a }
function fact(n,   r, i) { r = 1; for (i = 2; i <= n; i++) r *= i; return r }
function red(i,   g) { g = gcd(RN[i], RD[i]); if (g > 1) { RN[i] /= g; RD[i] /= g } if (RD[i] < 0) { RN[i] = -RN[i]; RD[i] = -RD[i] } }
function radd(i, j, k) { RN[k] = RN[i] * RD[j] + RN[j] * RD[i]; RD[k] = RD[i] * RD[j]; red(k) }
function rmul(i, j, k) { RN[k] = RN[i] * RN[j]; RD[k] = RD[i] * RD[j]; red(k) }
# polynomials in w with rational coefficients: PN[name, k], PD[name, k]
function pclear(n,   k) { for (k in PN) if (index(k, n SUBSEP) == 1) { delete PN[k]; delete PD[k] } DEG[n] = -1 }
function pset(n, k, num, den,   g) { g = gcd(num, den); if (g > 1) { num /= g; den /= g } if (den < 0) { num = -num; den = -den } PN[n, k] = num; PD[n, k] = den; if (k > DEG[n]) DEG[n] = k }
function pget(n, k) { return ((n, k) in PN) ? PN[n, k] : 0 }
function pgetd(n, k) { return ((n, k) in PD) ? PD[n, k] : 1 }
function pmul(a, b, dst,   i, j, num, den, g) { pclear("tmpm"); for (i = 0; i <= DEG[a]; i++) for (j = 0; j <= DEG[b]; j++) { if (pget(a, i) == 0 || pget(b, j) == 0) continue
    num = pget(a, i) * pget(b, j); den = pgetd(a, i) * pgetd(b, j); RN["x"] = pget("tmpm", i + j); RD["x"] = pgetd("tmpm", i + j); RN["y"] = num; RD["y"] = den; radd("x", "y", "z"); pset("tmpm", i + j, RN["z"], RD["z"]) }
  pclear(dst); for (i = 0; i <= DEG["tmpm"]; i++) if (pget("tmpm", i) != 0) pset(dst, i, pget("tmpm", i), pgetd("tmpm", i)) }
function pcopy(a, dst,   i) { pclear(dst); for (i = 0; i <= DEG[a]; i++) if (pget(a, i) != 0) pset(dst, i, pget(a, i), pgetd(a, i)) }
function chebU(s, dst,   k) { pclear(dst); for (k = 0; k <= s; k++) if (CH[s, k] != 0) pset(dst, k, CH[s, k], 1) }
function haar_w(k,   m) { if (k % 2) return 0; m = k / 2; RN["h"] = fact(2 * m); RD["h"] = 4 ^ m * fact(m) * fact(m + 1); red("h"); return 1 }
function integrate(a,   k, ok) { RN["I"] = 0; RD["I"] = 1; for (k = 0; k <= DEG[a]; k++) { if (pget(a, k) == 0) continue; if (!haar_w(k)) continue; RN["c"] = pget(a, k); RD["c"] = pgetd(a, k); rmul("c", "h", "t"); radd("I", "t", "I") } return RN["I"] / RD["I"] }
function roadA(n, s1, s2, s3,   j) { pclear("acc"); pset("acc", 0, 1, 1); for (j = 1; j <= n; j++) { pmul("acc", "wt", "acc2"); pcopy("acc2", "acc") }
  if (s1 >= 0) { chebU(s1, "u"); pmul("acc", "u", "acc2"); pcopy("acc2", "acc") } if (s2 >= 0) { chebU(s2, "u"); pmul("acc", "u", "acc2"); pcopy("acc2", "acc") } if (s3 >= 0) { chebU(s3, "u"); pmul("acc", "u", "acc2"); pcopy("acc2", "acc") }
  return integrate("acc") }
function chebval(s, w,   u0, u1, u2, k) { if (s == 0) return 1; u0 = 1; u1 = 2 * w; for (k = 2; k <= s; k++) { u2 = 2 * w * u1 - u0; u0 = u1; u1 = u2 } return u1 }
function roadB(n, s1, s2, s3, bend,   i, th, w, f, sum, k, wt) { sum = 0
  for (i = 0; i < NPB; i++) { th = PI * (i + 0.5) / NPB; w = cos(th); wt = 1; for (k = 1; k <= KCAP; k++) wt += CD[k] * (k == 2 && bend ? 2 : 1) * chebval(k, w); f = wt ^ n
    if (s1 >= 0) f *= chebval(s1, w); if (s2 >= 0) f *= chebval(s2, w); if (s3 >= 0) f *= chebval(s3, w); sum += f * sin(th) * sin(th) }
  return sum * 2 / NPB }   # (2/pi) int f sin^2 dtheta by the midpoint rule, PI/NPB per panel
BEGIN { PREC = 220; KCAP = 4; NPB = 400; PI = atan2(0, -1)
  # the certified Wilson coefficients (cei_exact_bessel, 2026-11-02): rationals with denominator 10^40 cut from the enclosures (the cut's error 1e-40)
  C[1] = "9289580505408405741186563629533851806580"; C[2] = "4664780439795255810532046434768629689052"; C[3] = "1616323047924970083614532486574318583393"; C[4] = "0427711121211912185620845196894660797906"
  DEN40 = 10 ^ 40; for (k = 1; k <= KCAP; k++) { CN[k] = C[k] + 0; CD[k] = CN[k] / DEN40 }
  CH[0, 0] = 1; CH[1, 1] = 2; for (s = 1; s < 8; s++) for (k = 0; k <= s + 1; k++) CH[s + 1, k] = 2 * ((k >= 1) ? CH[s, k - 1] : 0) - ((s >= 1) ? CH[s - 1, k] : 0)
  pclear("wt"); pset("wt", 0, 1, 1); for (k = 1; k <= KCAP; k++) { chebU(k, "u"); for (i = 0; i <= k; i++) if (pget("u", i) != 0) { RN["a"] = pget("wt", i); RD["a"] = pgetd("wt", i); RN["b"] = CN[k] * pget("u", i); RD["b"] = DEN40; radd("a", "b", "c"); pset("wt", i, RN["c"], RD["c"]) } }
  printf "CEI-EXACT-LINK the staple-weighted character integrals, cap K = %d, the Wilson coefficients to 40 digits; road A exact rationals, road B the class measure at %d points, %d bits\n", KCAP, NPB, PREC
  printf "  KAT orthogonality (n = 0): S(0; s, t) = delta_st at s, t <= 4: "; ok = 0; for (s = 0; s <= 4; s++) for (t = 0; t <= 4; t++) { v = roadA(0, s, t, -1); if ((s == t && v == 1) || (s != t && v == 0)) ok++ } printf "%d of 25 met\n", ok
  a = roadA(1, 1, -1, -1); b = roadA(1, 0, -1, -1); r = a / (2 * b); e = 4.644790252704e-01; d = r - e; if (d < 0) d = -d
  printf "  KAT one staple, one spin-1 slot: S(1;1)/(2 S(1;0)) = %.40f = c_1/2 by orthogonality; the engine's quadrature 4.644790252704e-01 %s at its 13 digits (|diff| = %.1e)\n", r, (d < 5e-14) ? "MET" : "PARTED", d
  printf "  the two roads on the cell's scalars (n staples, slot spins), |A - B|:\n"; worst = 0
  split("5 1 -1 -1;5 2 -1 -1;5 1 1 -1;5 2 2 -1;5 1 2 1;4 2 2 2;4 1 1 1;5 0 0 0;3 2 1 1", CASES, ";")
  for (i = 1; i <= 9; i++) { split(CASES[i], c, " "); va = roadA(c[1], c[2], c[3], c[4]); vb = roadB(c[1], c[2], c[3], c[4], 0); d = va - vb; if (d < 0) d = -d; if (d > worst) worst = d; printf "    n=%d spins (%d,%d,%d): A = %.45f  B = %.45f  |A-B| = %.1e\n", c[1], c[2], c[3], c[4], va, vb, d }
  printf "  the two roads agree to %.1e on nine scalars\n", worst
  va = roadA(5, 1, 2, 1); vb = roadB(5, 1, 2, 1, 1); d = va - vb; if (d < 0) d = -d; printf "  CONTROL c_2 doubled on road B alone at n=5 (1,2,1): |A-B| = %.3e (%s)\n", d, (d > 1e-20) ? "SIGHTED" : "BLIND" }
