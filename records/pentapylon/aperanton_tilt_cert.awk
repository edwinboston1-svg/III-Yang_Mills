# aperanton_tilt_cert.awk -- THE TILT BUDGET CERTIFIED: every quantity of B_k an interval of 256-bit MPFR numbers, every lower
# endpoint under ROUNDMODE "D" and every upper under "U" (gawk -M; sin, cos, exp, log honour the mode -- verified at load, refused
# by name if not), on ΠΕΝΤΑΠΥΛΟΝ's mkflow records (MKF-COEF k n [lo, hi] for n ≤ NMAX; MKF-STEP k ... next-tail<=E kappa=κ, E an upper
# bound on Σ_{m>NMAX} (m+1)² c_m, c_m ≤ Λ e^{−κm}).  The double-precision reading is aperanton_tilt_budget.awk (§63); this is its
# certificate (the plan B5a's "every coefficient an interval" carried through the budget).
#   β_k ∈ [bl, bh]: a₁(β) = I₂(β)/I₁(β) is increasing, so bl with a₁^hi(bl) ≤ c₁^lo and bh with a₁^lo(bh) ≥ c₁^hi enclose it
#     (I_ν by the series with a geometric remainder, as mkflow's bessel_lo/hi);
#   F_k(θ_g) on the grid θ_g = π^lo g/NG, g = 0..NG, by the Chebyshev recurrence χ_{n+1} = 2 cos θ · χ_n − χ_{n−1} in intervals
#     (no division by sin θ), F = Σ (n+1) c_n χ_n ± E;
#   δ = ln F − β cos θ in intervals; osc over the grid; the true oscillation over [0, π] at most the grid's plus h·D′ with
#     D′ ≥ sup |δ′| = sup |F′/F + β sin θ|, |F′| ≤ Σ n(n+1)² c_n + 11E (|χ_n′| ≤ n(n+1); the tail's extra factor m+1 priced by κ ≥ 1),
#     F ≥ (the grid's least lower bound) − h·sup|F′|;
#   B = e^{6 osc} · 18 (4/(3π)) β + 18 (1 − e^{−2 osc}), lower under D from the lower endpoints, upper under U from the upper.
# Verdict per step: CLOSES iff B^hi < 1; OPEN iff B^lo ≥ 1; UNDECIDED otherwise; REFUSED by name when F's lower bound is not positive,
# when the tail's κ < 1, or when a step lacks its tail line.  MODE=kat: the known answer -- a pure Wilson vector at β = 3/10 (c_n =
# I_{n+1}/I_1 as intervals, its tail from the same remainder) must read osc^lo = 0 exactly and B^lo = the Wilson row alone,
# 18 (4/(3π)) · 0.3 = 2.2918, to every printed digit; its osc^hi is the certificate's RESOLUTION FLOOR h·D' (the grid's, not the
# weight's: 6.4e-3 at NG = 400, 1.3e-4 at NG = 20000), said as such -- the first draft staked osc^hi < 1e-9 and its own run corrected
# it (law 18); and the same vector with c_2 doubled must read osc^lo > 1e-3 (a bent weight is off the line).
# usage: gawk -M -v NG=2000 -f aperanton_tilt_cert.awk <mkflow record> ...   |   gawk -M -v MODE=kat -f aperanton_tilt_cert.awk
function dn() { ROUNDMODE = "D" }
function up() { ROUNDMODE = "U" }
function fmt(x) { ROUNDMODE = "N"; return sprintf("%.17g", x) }
function bessel_lo(nu, x, K,   k, t, s, i, f) { dn(); f = 1; for (i = 1; i <= nu; i++) f = f * i; t = (x / 2) ^ nu / f; s = t
  for (k = 0; k < K; k++) { t = t * (x / 2) ^ 2 / ((k + 1) * (k + 1 + nu)); s = s + t } return s }
function bessel_hi(nu, x, K,   k, t, s, i, f, rho, den) { up(); f = 1; for (i = 1; i <= nu; i++) f = f * i; t = (x / 2) ^ nu / f; s = t
  for (k = 0; k < K; k++) { t = t * (x / 2) ^ 2 / ((k + 1) * (k + 1 + nu)); s = s + t }
  rho = (x / 2) ^ 2 / ((K + 1) * (K + 1 + nu)); if (rho >= 1) { print "TILT-CERT REFUSED bessel: K too small for x=" x; exit 3 }
  dn(); den = 1 - rho; up(); return s + t * rho / den }
function a1lo(b,   n, d) { n = bessel_lo(2, b, KB); d = bessel_hi(1, b, KB); dn(); return n / d }
function a1hi(b,   n, d) { n = bessel_hi(2, b, KB); d = bessel_lo(1, b, KB); up(); return n / d }
# the interval product [alo, ahi] * [blo, bhi]: PL (down) and PH (up) set as globals
function iprod(alo, ahi, blo, bhi,   p1, p2, p3, p4) {
  dn(); p1 = alo * blo; p2 = alo * bhi; p3 = ahi * blo; p4 = ahi * bhi; PL = p1; if (p2 < PL) PL = p2; if (p3 < PL) PL = p3; if (p4 < PL) PL = p4
  up(); p1 = alo * blo; p2 = alo * bhi; p3 = ahi * blo; p4 = ahi * bhi; PH = p1; if (p2 > PH) PH = p2; if (p3 > PH) PH = p3; if (p4 > PH) PH = p4 }
function budget(src, k,   n, lo, hi, g, th, clo, chi, x0lo, x0hi, x1lo, x1hi, x2lo, x2hi, Flo, Fhi, flo, fhi, bl, bh, E, lnlo, lnhi, dlo, dhi, dmaxlo, dmaxhi, dminlo, dminhi, osclo, oschi, fpmax, fmin, Dp, h, Blo, Bhi, verdict, t, i, mid) {
  if (!((k, "E") in TAIL)) { printf "TILT-CERT src=%s k=%d REFUSED: no tail line for this step\n", src, k; return }
  E = TAIL[k, "E"]; if (TAIL[k, "kappa"] < 1) { printf "TILT-CERT src=%s k=%d REFUSED: kappa=%s < 1\n", src, k, fmt(TAIL[k, "kappa"]); return }
  # beta_k by bisection on both endpoints
  lo = C_LO[k, 1]; hi = C_HI[k, 1]
  bh = 1; while (a1lo(bh) < hi) bh = bh * 2
  bl = 0; t = bh; for (i = 0; i < 70; i++) { ROUNDMODE = "N"; mid = (bl + t) / 2; if (a1hi(mid) <= lo) bl = mid; else t = mid }
  t = 0; for (i = 0; i < 70; i++) { ROUNDMODE = "N"; mid = (t + bh) / 2; if (a1lo(mid) >= hi) bh = mid; else t = mid }
  # the grid
  dn(); h = PIHI / NG
  dmaxlo = -1e300; dmaxhi = -1e300; dminlo = 1e300; dminhi = 1e300; fmin = 1e300
  for (g = 0; g <= NG; g++) {
    dn(); th = PILO * g / NG; clo = cos(th); up(); chi = cos(th)
    x0lo = 1; x0hi = 1; dn(); x1lo = 2 * clo; up(); x1hi = 2 * chi
    dn(); Flo = 1 * C_LO[k, 0] + (x1lo >= 0 ? 2 * C_LO[k, 1] * x1lo : 2 * C_HI[k, 1] * x1lo)
    up(); Fhi = 1 * C_HI[k, 0] + (x1hi >= 0 ? 2 * C_HI[k, 1] * x1hi : 2 * C_LO[k, 1] * x1hi)
    for (n = 2; n <= NMAX[k]; n++) {
      iprod(x1lo, x1hi, 2 * clo, 2 * chi); dn(); x2lo = PL - x0hi; up(); x2hi = PH - x0lo
      dn(); Flo = Flo + (n + 1) * (x2lo >= 0 ? C_LO[k, n] * x2lo : C_HI[k, n] * x2lo)
      up(); Fhi = Fhi + (n + 1) * (x2hi >= 0 ? C_HI[k, n] * x2hi : C_LO[k, n] * x2hi)
      x0lo = x1lo; x0hi = x1hi; x1lo = x2lo; x1hi = x2hi
    }
    dn(); Flo = Flo - E; up(); Fhi = Fhi + E
    if (Flo <= 0) { printf "TILT-CERT src=%s k=%d REFUSED: F lower bound not positive at g=%d\n", src, k, g; return }
    if (Flo < fmin) fmin = Flo
    dn(); lnlo = log(Flo); up(); lnhi = log(Fhi)
    iprod(bl, bh, clo, chi); dn(); dlo = lnlo - PH; up(); dhi = lnhi - PL
    if (dlo > dmaxlo) dmaxlo = dlo; if (dhi > dmaxhi) dmaxhi = dhi; if (dhi < dminhi) dminhi = dhi; if (dlo < dminlo) dminlo = dlo
  }
  # the oscillation: grid lower bound, and the upper bound with the derivative term
  dn(); osclo = dmaxlo - dminhi; if (osclo < 0) osclo = 0
  up(); fpmax = 11 * E; for (n = 1; n <= NMAX[k]; n++) fpmax = fpmax + n * (n + 1) * (n + 1) * C_HI[k, n]
  dn(); fmin = fmin - h * fpmax
  if (fmin <= 0) { printf "TILT-CERT src=%s k=%d REFUSED: F minimum over [0,pi] not positive\n", src, k; return }
  up(); Dp = fpmax / fmin + bh; oschi = (dmaxhi - dminlo) + h * Dp
  # the budget
  dn(); Blo = exp(6 * osclo) * 18 * (4 / (3 * PIHI)) * bl + 18 * (1 - exp(0 - 2 * osclo))
  up(); t = exp(0 - 2 * oschi); dn(); t = exp(0 - 2 * oschi); up(); Bhi = exp(6 * oschi) * 18 * (4 / (3 * PILO)) * bh + 18 * (1 - t)
  verdict = (Bhi < 1) ? "CLOSES" : ((Blo >= 1) ? "OPEN" : "UNDECIDED")
  printf "TILT-CERT model=%s src=%s k=%d c1=[%s, %s] beta=[%s, %s] osc=[%s, %s] B=[%s, %s] %s\n", (src ~ /^KAT/ ? "kat" : "hierarchical"), src, k, fmt(lo), fmt(hi), fmt(bl), fmt(bh), fmt(osclo), fmt(oschi), fmt(Blo), fmt(Bhi), verdict
}
function flush_src(src,   k) { for (k = 1; k <= KMAX; k++) if ((k, 1) in C_LO) budget(src, k); delete C_LO; delete C_HI; delete NMAX; delete TAIL; KMAX = 0 }
BEGIN {
  PREC = 256; if (NG == "") NG = 2000; NG = NG + 0; KB = 80; KMAX = 0
  dn(); PILO = atan2(0, -1); up(); PIHI = atan2(0, -1)
  dn(); t1 = sin(0.7); t2 = log(1.3); t3 = exp(0.4); up(); u1 = sin(0.7); u2 = log(1.3); u3 = exp(0.4)
  if (!(u1 > t1 && u2 > t2 && u3 > t3 && PIHI > PILO)) { print "TILT-CERT REFUSED: the rounding mode is not honoured by sin/log/exp/atan2"; exit 3 }
  if (MODE == "kat") {
    # the Wilson vector at beta = 3/10 as intervals, its tail from the series remainder bound I_{m+1}(b) <= (b/2)^{m+1} e^{b^2/4}/(m+1)!
    b = 3 / 10; i1lo = bessel_lo(1, b, KB); i1hi = bessel_hi(1, b, KB)
    for (n = 0; n <= 8; n++) { nlo = bessel_lo(n + 1, b, KB); nhi = bessel_hi(n + 1, b, KB); dn(); C_LO[1, n] = nlo / i1hi; up(); C_HI[1, n] = nhi / i1lo }
    NMAX[1] = 8; up(); S = 0; fact = 1; for (i = 1; i <= 10; i++) fact = fact * i
    for (m = 9; m <= 60; m++) { S = S + (m + 1) * (m + 1) * (b / 2) ^ (m + 1) * exp(b * b / 4) / fact / i1lo; fact = fact * (m + 2) }
    TAIL[1, "E"] = S; TAIL[1, "kappa"] = 2; KMAX = 1
    budget("KAT-WILSON-0.3", 1)
    for (n = 0; n <= 8; n++) { C_LO[2, n] = C_LO[1, n]; C_HI[2, n] = C_HI[1, n] } dn(); C_LO[2, 2] = 2 * C_LO[1, 2]; up(); C_HI[2, 2] = 2 * C_HI[1, 2]
    NMAX[2] = 8; TAIL[2, "E"] = S; TAIL[2, "kappa"] = 2; KMAX = 2
    budget("KAT-BENT-c2x2", 2)
    exit 0
  }
}
FNR == 1 { if (SRC != "") flush_src(SRC); SRC = FILENAME; sub(/.*\//, "", SRC) }
/^MKF-COEF / {
  k = 0; n = -1
  for (i = 1; i <= NF; i++) { if ($i ~ /^k=/) k = substr($i, 3) + 0; if ($i ~ /^n=/) n = substr($i, 3) + 0 }
  if (n >= 0 && match($0, /\[[^]]*\]/)) { iv = substr($0, RSTART + 1, RLENGTH - 2); split(iv, ab, ","); gsub(/ /, "", ab[1]); gsub(/ /, "", ab[2])
    dn(); C_LO[k, n] = ab[1] + 0; up(); C_HI[k, n] = ab[2] + 0; if (!((k) in NMAX) || n > NMAX[k]) NMAX[k] = n; if (k > KMAX) KMAX = k }
}
/^MKF-STEP / {
  k = 0; for (i = 1; i <= NF; i++) { if ($i ~ /^k=/) k = substr($i, 3) + 0; if ($i ~ /^next-tail<=/) { up(); TAIL[k, "E"] = substr($i, 12) + 0 } if ($i ~ /^kappa=/) { dn(); TAIL[k, "kappa"] = substr($i, 7) + 0 } }
}
END { if (MODE != "kat" && SRC != "") flush_src(SRC) }
