# cei_exact_bessel.awk -- THE CERTIFIED TIER'S SECOND STONE (campaign 31.15): the Wilson coefficients as CERTIFIED RATIONAL ENCLOSURES.  The
# face-fibre engine's weights are the character sums 1 + sum_k c_k chi_k(U) with c_k = (k+1) I_{k+1}(beta) / I_1(beta); here I_n(beta) at the
# rational beta = 11/5 is the series sum_j (beta/2)^{2j+n} / (j! (j+n)!) summed EXACTLY to J terms (every partial sum a rational, gawk -M), the
# tail bounded by the geometric majorant of the terms past J (the term ratio (beta/2)^2 / ((j+1)(j+n+1)) < 1/2 from j >= 1 at beta = 11/5), so
# I_n lies in [S_J, S_J + T_J] with T_J = term_J * r / (1 - r) at the ratio r of the next term -- two rationals, the width printed.  The ratios
# c_k follow by interval division (the enclosure's endpoints), and the engine's free-datum known answer <1/2 tr U_p> = c_1 / 2 = I_2 / I_1 must
# lie inside its enclosure (the engine's run reads 4.644790252704e-01 by quadrature).  The cap's tail bound  sum_{k > K} (k+1)^2 I_{k+1}/I_1
# (|chi_k| <= k + 1) is an enclosure too: it is the norm bound of the character truncation the certified tier needs.   usage: gawk -M -f cei_exact_bessel.awk [-v J=60]
function gcd(a, b,   t) { a = (a < 0) ? -a : a; b = (b < 0) ? -b : b; while (b != 0) { t = a % b; a = b; b = t } return a }
function red(i,   g) { g = gcd(RN[i], RD[i]); if (g > 1) { RN[i] /= g; RD[i] /= g } if (RD[i] < 0) { RN[i] = -RN[i]; RD[i] = -RD[i] } }
function radd(i, j, k) { RN[k] = RN[i] * RD[j] + RN[j] * RD[i]; RD[k] = RD[i] * RD[j]; red(k) }
function rmul(i, j, k) { RN[k] = RN[i] * RN[j]; RD[k] = RD[i] * RD[j]; red(k) }
function rdiv(i, j, k) { RN[k] = RN[i] * RD[j]; RD[k] = RD[i] * RN[j]; red(k) }
function rstr(i) { return RN[i] "/" RD[i] }
function rval(i) { return RN[i] / RD[i] }   # a float reading of a rational, for the printout only
function fact(n,   r, i) { r = 1; for (i = 2; i <= n; i++) r *= i; return r }
# the enclosure of I_n at beta = BN/BD: the lower end "lo_n" = S_J, the upper "hi_n" = S_J + T_J (slots named by strings in RN/RD)
function bessel_enc(n,   j, tn, td, g, rr) { RN["s"] = 0; RD["s"] = 1
  for (j = 0; j <= J; j++) { RN["t"] = BN ^ (2 * j + n); RD["t"] = BD ^ (2 * j + n) * 2 ^ (2 * j + n) * fact(j) * fact(j + n); red("t"); radd("s", "t", "s") }
  # the tail: the next term's ratio r = (beta/2)^2 / ((J+1)(J+n+1)); the terms past J are below term_J * r^m, so the tail is below term_J * r / (1 - r)
  RN["r"] = BN ^ 2; RD["r"] = BD ^ 2 * 4 * (J + 1) * (J + n + 1); red("r")
  if (RN["r"] * 2 >= RD["r"]) { print "REFUSED: the tail ratio is not below 1/2 at J = " J; exit 3 }
  RN["q"] = RN["r"]; RD["q"] = RD["r"] - RN["r"]; red("q")               # r / (1 - r)
  rmul("t", "q", "T")
  RN["lo" n] = RN["s"]; RD["lo" n] = RD["s"]; radd("s", "T", "hi" n) }
BEGIN { if (J == "") J = 60; BN = 11; BD = 5; NMAX = 14
  for (n = 0; n <= NMAX; n++) bessel_enc(n)
  printf "CEI-EXACT-BESSEL beta = %d/%d, J = %d terms exact, the tail by the geometric majorant\n", BN, BD, J
  for (n = 1; n <= 3; n++) { RN["w"] = RN["hi" n] * RD["lo" n] - RN["lo" n] * RD["hi" n]; RD["w"] = RD["hi" n] * RD["lo" n]; red("w"); printf "  I_%d in [%.20g, %.20g], width %.3e\n", n, rval("lo" n), rval("hi" n), rval("w") }
  # the Wilson coefficients c_k = (k+1) I_{k+1}/I_1 as enclosures: lower = (k+1) lo_{k+1} / hi_1, upper = (k+1) hi_{k+1} / lo_1
  for (k = 1; k <= 12; k++) { RN["a"] = (k + 1) * RN["lo" k + 1]; RD["a"] = RD["lo" k + 1]; red("a"); rdiv("a", "hi1", "clo" k); RN["b"] = (k + 1) * RN["hi" k + 1]; RD["b"] = RD["hi" k + 1]; red("b"); rdiv("b", "lo1", "chi" k) }
  printf "  c_1 in [%.18g, %.18g]  c_2 in [%.18g, %.18g]  c_3 in [%.15g, %.15g]  c_4 in [%.15g, %.15g]\n", rval("clo1"), rval("chi1"), rval("clo2"), rval("chi2"), rval("clo3"), rval("chi3"), rval("clo4"), rval("chi4")
  # the known answer: the engine's free-datum reading c_1/2 = I_2/I_1 = 4.644790252704e-01 (quadrature) must lie inside the enclosure
  lo = rval("clo1") / 2; hi = rval("chi1") / 2; e = 4.644790252704e-01
  printf "  KAT free-datum <1/2 tr U_p> = I_2/I_1 in [%.15f, %.15f]; the engine's 0.4644790252704 %s (its printed digits end 1e-13 wide)\n", lo, hi, (e >= lo - 1e-13 && e <= hi + 1e-13) ? "INSIDE" : "OUTSIDE"
  # the control: a bent beta (12/5) must put the engine's value outside
  BN = 12; for (n = 1; n <= 2; n++) bessel_enc(n); RN["a"] = 2 * RN["lo2"]; RD["a"] = RD["lo2"]; red("a"); rdiv("a", "hi1", "x"); RN["b"] = 2 * RN["hi2"]; RD["b"] = RD["hi2"]; red("b"); rdiv("b", "lo1", "y")
  printf "  CONTROL at beta = 12/5: I_2/I_1 in [%.12f, %.12f]; the engine's 0.4644790252704 %s\n", rval("x") / 2, rval("y") / 2, (e >= rval("x") / 2 - 1e-13 && e <= rval("y") / 2 + 1e-13) ? "INSIDE (BLIND)" : "OUTSIDE (SIGHTED)"
  BN = 11; for (n = 0; n <= NMAX; n++) bessel_enc(n)
  # the cap's tail: sum_{k > K} (k+1)^2 I_{k+1}/I_1 for K = 2, 3, 4, 5 as upper bounds (the series' own tail past NMAX bounded by its geometric majorant: the terms fall faster than 1/4 each at these k)
  for (K = 2; K <= 5; K++) { RN["tt"] = 0; RD["tt"] = 1; for (k = K + 1; k < NMAX; k++) { RN["a"] = (k + 1) ^ 2 * RN["hi" k + 1]; RD["a"] = RD["hi" k + 1]; red("a"); rdiv("a", "lo1", "b"); radd("tt", "b", "tt") }
    RN["a"] = (NMAX + 1) ^ 2 * RN["hi" NMAX]; RD["a"] = RD["hi" NMAX]; red("a"); rdiv("a", "lo1", "b"); RN["c"] = 4; RD["c"] = 3; rmul("b", "c", "b"); radd("tt", "b", "tt")
    printf "  the cap's tail bound at K = %d: sum_{k > K} (k+1)^2 |c_k|/(k+1)... = sum (k+1)^2 I_{k+1}/I_1 <= %.6e\n", K, rval("tt") } }
