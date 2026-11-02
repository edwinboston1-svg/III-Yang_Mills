# M5 flip_tv.awk -- THE ONE-LINK FLIP COEFFICIENT TV(vMF(beta e), vMF(-beta e)) = L_1(beta)/I_1(beta), CERTIFIED (exact rationals, outward).
# L_1(x) = (2/pi) S_L(x), S_L = sum_{k>=0} x^{2k+2} / ((2k+1)!! (2k+3)!!);   I_1(x) = S_I(x) = sum_{k>=0} (x/2)^{2k+1} / (k! (k+1)!).
# beta = P/Q rational.  Partial sums to K terms are exact rationals (big integers); each tail is bounded by twice its first omitted term once
# the term ratio is <= 1/2 (both series' ratios fall like x^2/(4k^2)), checked at run time.  pi in [PILO, PIHI] (35 digits, outward).
# Output: the enclosure of L_1/I_1 to 12 digits (lo floored, hi ceiled) and of 18 L_1/I_1; MODE=root bisects 18 L_1/I_1 = 1 on [LO, HI] in units 1e-6.
# usage: gawk -M -v P=11 -v Q=5 -f flip_tv.awk    |    gawk -M -v MODE=root -f flip_tv.awk    |    gawk -M -v MODE=small -f flip_tv.awk
function gcd(a, b,   t) { if (a < 0) a = 0 - a; if (b < 0) b = 0 - b; while (b) { t = a % b; a = b; b = t } return a }
# exact partial sums as N/D with the first omitted term T; returns via globals SLN SLD TLN TLD SIN SID TIN TID
function sums(p, q, K,   k, num, den, a, b, g, tn, td) {
  # S_L: term_k = (p/q)^{2k+2} / ((2k+1)!!(2k+3)!!)
  SLN = 0; SLD = 1; tn = p * p; td = q * q * 3            # k = 0: x^2 / (1 * 3)
  for (k = 0; k < K; k++) { SLN = SLN * td + tn * SLD; SLD = SLD * td; g = gcd(SLN, SLD); SLN /= g; SLD /= g
    tn = tn * p * p; td = td * q * q * (2 * k + 3) * (2 * k + 5); g = gcd(tn, td); tn /= g; td /= g }
  TLN = tn; TLD = td
  # S_I: term_k = (p/(2q))^{2k+1} / (k!(k+1)!)
  SIN = 0; SID = 1; tn = p; td = 2 * q                     # k = 0: x/2
  for (k = 0; k < K; k++) { SIN = SIN * td + tn * SID; SID = SID * td; g = gcd(SIN, SID); SIN /= g; SID /= g
    tn = tn * p * p; td = td * 4 * q * q * (k + 1) * (k + 2); g = gcd(tn, td); tn /= g; td /= g }
  TIN = tn; TID = td }
# the ratio L1/I1 as a rational interval [RLO_N/RLO_D, RHI_N/RHI_D]: lo uses S_L's partial sum, S_I's partial sum + 2 tail, pi_hi
function ratio(p, q,   K) { K = 60; sums(p, q, K)
  # tail checks: the next-term ratios must be <= 1/2 (checked on the omitted terms' successors by the closed forms)
  if (2 * p * p * 1 > q * q * (2 * K + 3) * (2 * K + 5)) { print "REFUSED: S_L tail ratio above 1/2 at K"; exit 2 }
  if (2 * p * p > 4 * q * q * (K + 1) * (K + 2)) { print "REFUSED: S_I tail ratio above 1/2 at K"; exit 2 }
  # lo = 2 S_L^- / (pi^+ (S_I^- + 2 T_I))  ;  hi = 2 (S_L^- + 2 T_L) / (pi^- S_I^-)
  LN1 = SLN; LD1 = SLD; HN1 = SLN * TLD + 2 * TLN * SLD; HD1 = SLD * TLD
  IHN = SIN * TID + 2 * TIN * SID; IHD = SID * TID
  RLO_N = 2 * LN1 * IHD * PID; RLO_D = LD1 * IHN * PIHI
  RHI_N = 2 * HN1 * SID * PID; RHI_D = HD1 * SIN * PILO }
function dlo(n, d, dig,   ip, r, s, i, qq) { ip = int(n / d); r = n - ip * d; s = ip "."; for (i = 0; i < dig; i++) { r *= 10; qq = int(r / d); s = s qq; r -= qq * d } return s }
function dhi(n, d, dig,   sc, x) { sc = 10 ^ dig; x = int((n * sc + d - 1) / d); return int(x / sc) "." sprintf("%0" dig "d", x % sc) }
BEGIN { PILO = 314159265358979323846264338327950288; PIHI = PILO + 1; PID = 10 ^ 35
  if (MODE == "root") { lo = 130000; hi = 132000      # units 1e-6: 18 L1/I1 - 1 changes sign in [0.130, 0.132]
    while (hi - lo > 1) { mid = int((lo + hi) / 2); ratio(mid, 1000000)
      if (18 * RHI_N < RHI_D) lo = mid; else if (18 * RLO_N > RLO_D) hi = mid; else { print "ROOT UNDECIDED at " mid; exit 1 } }
    printf "FLIP-ROOT: 18 L1/I1 = 1 at beta in [%s, %s] (below: 18 L1/I1 < 1 certified at %s; above: > 1 at %s)\n", lo / 1e6, hi / 1e6, lo / 1e6, hi / 1e6; exit 0 }
  if (MODE == "small") { for (e = 3; e <= 6; e++) { ratio(1, 10 ^ e)   # beta = 10^-e: (L1/I1) / (4 beta/(3 pi)) = (3 pi /(4 beta)) L1/I1
      printf "FLIP-SMALL beta=1e-%d: (L1/I1)/(4beta/(3pi)) in [%s, %s]\n", e, dlo(RLO_N * 3 * PILO * 10 ^ e, RLO_D * 4 * PID, 12), dhi(RHI_N * 3 * PIHI * 10 ^ e, RHI_D * 4 * PID, 12) } exit 0 }
  if (!P) { P = 11; Q = 5 } ratio(P, Q)
  printf "FLIP-TV beta=%d/%d: L1/I1 in [%s, %s]; 18 L1/I1 in [%s, %s]\n", P, Q, dlo(RLO_N, RLO_D, 12), dhi(RHI_N, RHI_D, 12), dlo(18 * RLO_N, RLO_D, 10), dhi(18 * RHI_N, RHI_D, 10) }
