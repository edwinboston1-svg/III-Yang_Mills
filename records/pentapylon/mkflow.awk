# mkflow.awk -- THE CERTIFIED SU(2) MIGDAL-KADANOFF FLOW AT 256 BITS WITH DIRECTED ROUNDING (ΠΕΝΤΑΠΥΛΟΝ G19, 2026-10-28 23:5x EDT, the desktop
# seat; the plan's B5a: "every coefficient an interval, the tail priced").  The port of g11_mk_cert.pl's ball arithmetic (MKBall.pm, IEEE
# doubles, the radius priced per operation) to gawk -M: every quantity is an INTERVAL [lo, hi] of 256-bit MPFR numbers, every lower endpoint
# computed under ROUNDMODE "D" and every upper under "U" (exp, log, powers and divisions included -- verified at load: U > D on each), so
# no rounding is priced by hand and no radius compounds through a centre.  The recursion (b = 2, d = 4, the character basis, W = 0: Ito 1985;
# Mueller-Schiemann 1985/1987/1988 for the theorem; ours is the certificate):
#   w = sum_n (n+1) c_n chi_n, c_0 = 1;  bond-moving v = w^4 by the Clebsch-Gordan series (nonnegative terms: lo*lo down, hi*hi up);  v_n = (w^4)_n/(n+1);
#   decimation c'_n = (v_n/v_0)^4   (lo = (v_n^lo/v_0^hi)^4 down, hi = (v_n^hi/v_0^lo)^4 up).
# THE TRUNCATION at N is priced as in g11: the input tail E = sum_{m>N} (m+1)^2 c_m from the start's own bound (the heat-kernel start's exact
# Gaussian sum; the Wilson start's I_{m+1}(beta) <= (beta/2)^{m+1} e^{beta^2/4}/(m+1)!) or from the carried envelope c_m <= Lambda e^{-kappa m},
# widening every v_n by (4W^3E + 6W^2E^2 + 4WE^3 + E^4)/(n+1); the output envelope by Paley-Wiener (M(y) = (sum (m+1)^2 c_m e^{my})^4 cosh y,
# Lambda' = (2 M e^{-y}/((N+2) v_0^lo))^4, kappa' = 4y, y among candidates for the least tail), every one an upper bound computed under "U".
# STARTS: mode=wilson beta=B  (B a decimal, read as the EXACT rational p/Q and bracketed [B_lo, B_hi] under D and U; c_n = I_{n+1}(B)/I_1(B), the
#         Wilson action's character coefficients, Bessel by its series -- increasing in its argument, so lo at B_lo, hi at B_hi -- with a geometric remainder);
#         mode=hk p=P Q=Q    (c_n = q^{n(n+2)}, q = P/Q: the heat-kernel line; the reading t = -2 ln q and claim (A) T(t) - t >= t^2/4 at step 1).
# Every printed lower endpoint is converted to decimal under D and every upper under U; scalars under N.  The threshold C* is read under D.
# THE KNOWN ANSWER (mode=kat): N = 8, q = 1/2, one step; the exact c'_1 is a RATIONAL computed in GMP integers (every c_n dyadic), enclosed by
# X <= exact <= Y under D and U; the interval must CONTAIN [X, Y]; and the liar -- the same step under "N" (nearest) at zero width -- must ESCAPE.
# STAKED BEFORE THE RUN: the hk start q = 1/2, N = 100 reproduces g11's step-1 ball (its c_1 in [0.0304366298856..] contains ours); from
# beta = 2.3 the flow reaches c_1 <= 0.131 within 12 steps; from beta = 10 within 60; the interval width grows about 32-fold per step so 256 bits
# carry at least 40 steps below width 1e-6.  (Record a, before the rational start: K* = 7 at 2.2 and 2.3, 18 at 5, 37 at 10; every step's
# relative width 1.9e-73 at k = 1 growing to 2.2e-52 at k = 15.)
# usage: gawk -M -v mode=wilson -v beta=10 [-v N=100] [-v CSTAR=0.131] [-v KMAX=80] -f mkflow.awk [-v PAST=3 -v COEFALL=1: continue PAST steps beyond the threshold, printing every step's c_0..c_8]
#        gawk -M -v mode=hk -v p=1 -v Q=2 [-v N=100] ... -f mkflow.awk  |  gawk -M -v mode=kat -f mkflow.awk
function dn() { ROUNDMODE = "D" }
function up() { ROUNDMODE = "U" }
function fmtlo(x) { ROUNDMODE = "D"; return sprintf("%.24g", x) }
function fmthi(x) { ROUNDMODE = "U"; return sprintf("%.24g", x) }
function fmtn(x) { ROUNDMODE = "N"; return sprintf("%.24g", x) }
function bessel_lo(nu, x, K,   k, t, s, i, f) { dn(); f = 1; for (i = 1; i <= nu; i++) f = f * i; t = (x / 2) ^ nu / f; s = t; for (k = 0; k < K; k++) { t = t * (x / 2) ^ 2 / ((k + 1) * (k + 1 + nu)); s = s + t } return s }
function bessel_hi(nu, x, K,   k, t, s, i, f, rho, den) { up(); f = 1; for (i = 1; i <= nu; i++) f = f * i; t = (x / 2) ^ nu / f; s = t; for (k = 0; k < K; k++) { t = t * (x / 2) ^ 2 / ((k + 1) * (k + 1 + nu)); s = s + t }
  rho = (x / 2) ^ 2 / ((K + 1) * (K + 1 + nu)); if (rho >= 1) { print "MKF-REFUSED bessel: K too small for x=" x; exit 3 } dn(); den = 1 - rho; up(); return s + t * rho / den }
# the Clebsch-Gordan product of two nonnegative interval sequences, truncated at N
function cg(FL, FH, GL, GH, HL, HH, N,   m, k, n, hi, pl, ph) { for (n = 0; n <= N; n++) { HL[n] = 0; HH[n] = 0 }
  dn(); for (m = 0; m <= N; m++) for (k = 0; k <= N; k++) { pl = FL[m] * GL[k]; if (pl == 0) continue; hi = m + k; if (hi > N) hi = N; for (n = (m > k ? m - k : k - m); n <= hi; n += 2) HL[n] = HL[n] + pl }
  up(); for (m = 0; m <= N; m++) for (k = 0; k <= N; k++) { ph = FH[m] * GH[k]; if (ph == 0) continue; hi = m + k; if (hi > N) hi = N; for (n = (m > k ? m - k : k - m); n <= hi; n += 2) HH[n] = HH[n] + ph } }
# upper bounds on tails, all under U
function tailsum(N, Lambda, kappa, y,   d, r, rr, den) { dn(); d = kappa - y; if (d <= 0) return -1; up(); r = exp(0 - d); rr = r * exp(2 / (N + 2)); if (rr >= 1) return -1; dn(); den = 1 - rr; up(); return Lambda * (N + 2) ^ 2 * r ^ (N + 1) / den }
function tail_exact_hk(N, qh, y,   S, m, term, rho, den) { up(); S = 0; m = N + 1; while (1) { term = (m + 1) ^ 2 * qh ^ (m * (m + 2)) * exp(m * y); S = S + term; rho = qh ^ (2 * m + 3) * exp(y) * ((m + 2) / (m + 1)) ^ 2; if (rho >= 1) return -1
    if (term < 1e-200 * S || m > N + 400) { dn(); den = 1 - rho; up(); return S + term * rho / den } m++ } }
function tail_exact_wilson(N, B, y, I1lo,   S, m, term, rho, den, Bm, fact, i) { up(); S = 0; m = N + 1; fact = 1; for (i = 1; i <= m + 1; i++) fact = fact * i;         # Bm = (B/2)^{m+1} e^{B^2/4} / ((m+1)! I_1^lo) >= c_m
  Bm = (B / 2) ^ (m + 1) * exp(B * B / 4) / fact / I1lo
  while (1) { term = (m + 1) ^ 2 * Bm * exp(m * y); S = S + term; rho = (m + 2) * (B / 2) * exp(y) / ((m + 1) ^ 2); if (rho >= 1) return -1
    if (term < 1e-200 * S || m > N + 400) { dn(); den = 1 - rho; up(); return S + term * rho / den } m++; Bm = Bm * (B / 2) / (m + 1) } }
BEGIN { PREC = 256; if (mode == "") mode = "wilson"; N = (N == "") ? 100 : N + 0; PAST = (PAST == "") ? 0 : PAST + 0; COEFALL = (COEFALL == "") ? 0 : COEFALL + 0; past = -1; cs = (CSTAR == "") ? "0.131" : CSTAR ""; if (cs ~ /./) { split(cs, cq, "."); cp = (cq[1] cq[2]) + 0; cQ = 10 ^ length(cq[2]) } else { cp = cs + 0; cQ = 1 } dn(); CSTAR = cp / cQ; KMAX = (KMAX == "") ? 80 : KMAX + 0
  dn(); a = exp(1); b = 1 / 3; c = log(3); up(); A = exp(1); B = 1 / 3; C = log(3); if (!(A > a && B > b && C > c)) { print "MKF-REFUSED directed rounding not in force (U > D fails on exp, 1/3 or log)"; exit 3 }
  if (mode == "kat") { N = 8; p = 1; Q = 2; KMAX = 1 }
  if (mode == "hk" || mode == "kat") { p = p + 0; Q = Q + 0; dn(); qlo = p / Q; up(); qhi = p / Q; for (n = 0; n <= N; n++) { dn(); clo[n] = qlo ^ (n * (n + 2)); up(); chi[n] = qhi ^ (n * (n + 2)) }
    up(); L = log(qhi); dn(); tlo = (0 - L) * 2; dn(); L = log(qlo); up(); thi = (0 - L) * 2; up(); kappa = (0 - log(qhi)) * 3; dn(); kappa = kappa * (1 - 1e-30); Lambda = 1
    printf "MKF-START mode=%s q=%d/%d t in [%s, %s] N=%d C*=%s KMAX=%d PREC=256 (every endpoint under its own rounding mode)\n", mode, p, Q, fmtlo(tlo), fmthi(thi), N, fmtn(CSTAR), KMAX }
  else { bs = beta ""; if (bs ~ /\./) { split(bs, bq, "."); bp = (bq[1] bq[2]) + 0; bQ = 10 ^ length(bq[2]) } else { bp = bs + 0; bQ = 1 } dn(); xlo = bp / bQ; up(); xhi = bp / bQ
    KB = 120; I1lo = bessel_lo(1, xlo, KB); I1hi = bessel_hi(1, xhi, KB)
    for (n = 0; n <= N; n++) { il = bessel_lo(n + 1, xlo, KB); ih = bessel_hi(n + 1, xhi, KB); dn(); clo[n] = il / I1hi; up(); chi[n] = ih / I1lo }
    up(); L = log(chi[1]); dn(); tlo = (0 - L) * 2 / 3; dn(); L = log(clo[1]); up(); thi = (0 - L) * 2 / 3; kappa = -1; Lambda = -1
    printf "MKF-START mode=wilson beta=%s=%d/%d in [%s, %s] c_1 = I_2/I_1 in [%s, %s] (t_eff = -(2/3) ln c_1 in [%s, %s]) N=%d C*=%s KMAX=%d PREC=256\n", bs, bp, bQ, fmtlo(xlo), fmthi(xhi), fmtlo(clo[1]), fmthi(chi[1]), fmtlo(tlo), fmthi(thi), N, fmtn(CSTAR), KMAX }
  up(); wmax = 0; for (n = 0; n <= N; n++) { w = chi[n] - clo[n]; if (w > wmax) wmax = w } printf "MKF-START the widest start interval %.3e; c_0 in [%s, %s] c_1 in [%s, %s] c_2 in [%s, %s]\n", wmax, fmtlo(clo[0]), fmthi(chi[0]), fmtlo(clo[1]), fmthi(chi[1]), fmtlo(clo[2]), fmthi(chi[2]); fflush()
  certified = 0
  for (k = 1; k <= KMAX; k++) {
    if (k == 1) { E = (mode == "wilson") ? tail_exact_wilson(N, xhi, 0, I1lo) : tail_exact_hk(N, qhi, 0) } else E = tailsum(N, Lambda, kappa, 0)
    if (E < 0) { printf "MKF-REFUSED step %d: the input tail does not converge (a refusal, not a reading)\n", k; exit 2 }
    up(); Wsum = 0; for (n = 0; n <= N; n++) Wsum = Wsum + (n + 1) ^ 2 * chi[n]; W = Wsum + E
    for (n = 0; n <= N; n++) { dn(); XL[n] = (n + 1) * clo[n]; up(); XH[n] = (n + 1) * chi[n] }
    cg(XL, XH, XL, XH, W2L, W2H, N); cg(W2L, W2H, XL, XH, W3L, W3H, N); cg(W3L, W3H, XL, XH, W4L, W4H, N)
    up(); corr = 4 * W ^ 3 * E + 6 * W ^ 2 * E ^ 2 + 4 * W * E ^ 3 + E ^ 4
    for (n = 0; n <= N; n++) { up(); cu = corr / (n + 1); VH[n] = W4H[n] / (n + 1) + cu; dn(); VL[n] = W4L[n] / (n + 1) - cu; if (VL[n] < 0) VL[n] = 0 }
    if (VL[0] <= 0) { printf "MKF-REFUSED step %d: v_0's lower endpoint is not positive (a refusal, not a reading)\n", k; exit 2 }
    for (n = 0; n <= N; n++) { dn(); CNL[n] = (VL[n] / VH[0]) ^ 4; up(); CNH[n] = (VH[n] / VL[0]) ^ 4 }
    bestTail = -1; ncand = split("0.25 0.5 1 1.5 2 3", cand, " "); if (kappa > 0) { cand[++ncand] = 0.3 * kappa; cand[++ncand] = 0.5 * kappa; cand[++ncand] = 0.7 * kappa; cand[++ncand] = 0.85 * kappa }
    for (ci = 1; ci <= ncand; ci++) { y = cand[ci]; if (kappa > 0 && y >= kappa) continue
      if (k == 1) { TS = (mode == "wilson") ? tail_exact_wilson(N, xhi, y, I1lo) : tail_exact_hk(N, qhi, y) } else TS = tailsum(N, Lambda, kappa, y)
      if (TS < 0) continue; up(); S = 0; for (n = 0; n <= N; n++) S = S + (n + 1) ^ 2 * chi[n] * exp(n * y); M = (S + TS) ^ 4 * (exp(y) + exp(0 - y)) / 2
      Lc = (2 * M * exp(0 - y) / ((N + 2) * VL[0])) ^ 4; Kc = 4 * y; tail = Lc * exp(0 - Kc * (N + 1)); if (bestTail < 0 || tail < bestTail) { bestTail = tail; bestL = Lc; bestK = Kc } }
    if (bestTail < 0) { printf "MKF-REFUSED step %d: no admissible envelope (a refusal, not a reading)\n", k; exit 2 }
    Enext = tailsum(N, bestL, bestK, 0); for (n = 0; n <= N; n++) { clo[n] = CNL[n]; chi[n] = CNH[n] } Lambda = bestL; kappa = bestK
    up(); L = log(chi[1]); dn(); Tlo = (0 - L) * 2 / 3; if (clo[1] > 0) { dn(); L = log(clo[1]); up(); Thi = (0 - L) * 2 / 3 } else Thi = 1e9
    up(); width = chi[1] - clo[1]; relw = width / clo[1]; wmax = 0; for (n = 0; n <= 12; n++) { w = (chi[n] - clo[n]) / (clo[n] > 0 ? clo[n] : 1); if (w > wmax) wmax = w }
    line = sprintf("MKF-STEP k=%d c1 in [%s, %s] relwidth=%.3e (max over n<=12: %.3e) T in [%s, %s] input-tail<=%.3e next-tail<=%.3e kappa=%.6f Lambda=%.4e", k, fmtlo(clo[1]), fmthi(chi[1]), relw, wmax, fmtlo(Tlo), fmthi(Thi), E, Enext, kappa, Lambda)
    if (k == 1 && mode != "wilson") { dn(); marginA = Tlo - thi - thi * thi / 4; line = line sprintf("  (A) T(t)-t-t^2/4 >= %s [%s]", fmtlo(marginA), (marginA > 0) ? "HOLDS" : "UNDECIDED") }
    print line; fflush(); if (k <= 2 || chi[1] <= CSTAR || COEFALL) { for (n = 0; n <= 8; n++) printf "MKF-COEF k=%d n=%d c_n in [%s, %s]\n", k, n, fmtlo(clo[n]), fmthi(chi[n]) }
    if (chi[1] <= CSTAR && past < 0) { certified = 1; past = 0; printf "MKF-THRESHOLD mode=%s %s reached c1 <= %s at step K*=%d with c1^up=%s: a certified descent to the kernel's threshold  [CERTIFIED]\n", mode, (mode == "wilson" ? "beta=" bs : "q=" p "/" Q), fmtn(CSTAR), k, fmthi(chi[1]); if (PAST == 0) break } else if (past >= 0) { past++; printf "MKF-PAST step %d = K* + %d\n", k, past; if (past >= PAST) break }
    if (Enext > 1e-6) { printf "MKF-REFUSED step %d: the priced tail %.3e exceeds 1e-6 -- widen N (a refusal, not a reading)\n", k, Enext; exit 2 }
    if (relw > 0.01) { printf "MKF-REFUSED step %d: the relative width %.3e has passed 0.01 -- the wrapping wall at 256 bits (a refusal, not a reading)\n", k, relw; exit 2 } }
  if (!certified) printf "MKF-REFUSED %d steps without reaching c1 <= %s (a refusal, not a reading)\n", KMAX, fmtn(CSTAR)
  if (mode == "kat") {                                                                                    # the exact rational, in GMP integers: c_n = 2^{-n(n+2)} scaled by D = 2^80
    for (n = 0; n <= N; n++) { IC[n] = 2 ^ (80 - n * (n + 2)); IW[n] = (n + 1) * IC[n] }
    icg(IW, IW, I2, N); icg(I2, IW, I3, N); icg(I3, IW, I4, N); num = I4[1] ^ 4; den = 16 * I4[0] ^ 4; dn(); X = num / den; up(); Y = num / den
    ok = (clo[1] <= X && Y <= chi[1]); printf "MKF-KAT N=8 q=1/2 exact c'_1 = %s (the rational %s / %s, enclosed in [X, Y] of width %.3e); the interval [%s, %s] of width %.3e %s it\n", fmtn(X), substr(num "", 1, 12) "...", substr(den "", 1, 12) "...", Y - X, fmtlo(clo[1]), fmthi(chi[1]), chi[1] - clo[1], ok ? "CONTAINS" : "ESCAPES"
    # the liar: the same step with every endpoint rounded to nearest, zero width -- it must ESCAPE
    ROUNDMODE = "N"; for (n = 0; n <= N; n++) { LC[n] = (1 / 2) ^ (n * (n + 2)); LX[n] = (n + 1) * LC[n] } icg(LX, LX, L2, N); icg(L2, LX, L3, N); icg(L3, LX, L4, N); lv = (L4[1] / 2 / L4[0]) ^ 4
    liar = (lv <= X && Y <= lv); printf "MKF-KAT-LIAR the nearest-rounded step at zero width gives %s, which %s the exact value  [%s]\n", fmtn(lv), liar ? "CONTAINS" : "ESCAPES", (ok && !liar) ? "KAT-GREEN" : "KAT-RED"
    if (!(ok && !liar)) exit 1 } }
function icg(F, G, H, N,   m, k, n, hi, pr) { for (n = 0; n <= N; n++) H[n] = 0; for (m = 0; m <= N; m++) for (k = 0; k <= N; k++) { pr = F[m] * G[k]; hi = m + k; if (hi > N) hi = N; for (n = (m > k ? m - k : k - m); n <= hi; n += 2) H[n] = H[n] + pr } }
