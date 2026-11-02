# M7b: THE CERTIFIED CAP TAIL of the Wilson weight at beta = B/10000 (gawk -M, PREC bits; every quantity bounded in the stated direction):
#   a_s = I_{s+1}(b)/I_1(b) by the series (the k-sum truncated at K with the tail bound of a geometric series of ratio q <= (b/2)^2/((K+1)(K+n+1)));
#   T_W = sum_{s > W} (s+1)^2 a_s (an UPPER bound, the s-sum to S plus the tail a_{s+1}/a_s <= b/(2(s+2)), a geometric bound);
#   w_min = w(-1) = b e^{-b}/(2 I_1(b)) (a LOWER bound); delta_W = T_W / w_min >= sup |w - w_W|/w; the Gruess bound for an object with n
#   truncated plaquettes: |E_W - E_inf| <= ((1 + delta)/(1 - delta))^n - 1 (valid when delta < 1).
function Ilo(n, x,   t, s, k) { t = (x/2)^n; for (k = 1; k <= n; k++) t /= k; s = 0; for (k = 0; k < 200; k++) { s += t; t = t * (x/2)^2 / ((k+1)*(k+n+1)) } return s }
function Ihi(n, x,   t, s, k, q) { t = (x/2)^n; for (k = 1; k <= n; k++) t /= k; s = 0; for (k = 0; k < 200; k++) { s += t; t = t * (x/2)^2 / ((k+1)*(k+n+1)) } q = (x/2)^2/(201*(201+n)); return s + t/(1-q) }
BEGIN { b = B / 10000; I1lo = Ilo(1, b); I1hi = Ihi(1, b)
  for (s = 1; s <= 60; s++) { ahi[s] = Ihi(s+1, b) / I1lo }
  wmin = b * exp(-b) / (2 * I1hi); printf "TAIL beta=%s: w_min = w(-1) >= %.10e (a lower bound); w(1) = %.10e\n", b, wmin, b * exp(b) / (2 * I1lo)
  for (W = 2; W <= 14; W++) { T = 0; for (s = W + 1; s <= 59; s++) T += (s+1)^2 * ahi[s]; T += 2 * 61^2 * ahi[60]
    d = T / wmin; printf "TAIL W=%d: T_W <= %.6e  delta_W <= %.6e", W, T, d
    if (d < 1) { for (nn = 8; nn <= 32; nn *= 4) printf "  B(n=%d) = %.6e", nn, ((1+d)/(1-d))^nn - 1; for (nn = 110; nn <= 360; nn += 250) printf "  B(n=%d) = %.6e", nn, ((1+d)/(1-d))^nn - 1 }
    else printf "  (delta >= 1: no bound)"
    printf "\n" } }
