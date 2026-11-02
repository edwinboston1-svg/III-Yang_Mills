# fitpoly.awk: rows "name v1 v2 ... v6" at k = 1..6 (s = 4k); prints the finite-difference table's 5th difference (must be 0 for a
# quartic) and the exact quartic in s by Newton's forward form, evaluated back on every point. gawk -M, integers and exact rationals.
function gcd(a, b,   t) { if (a < 0) a = -a; if (b < 0) b = -b; while (b) { t = a % b; a = b; b = t } return a }
{ name = $1; n = NF - 1; for (i = 1; i <= n; i++) d[0, i] = $(i + 1)
  for (j = 1; j < n; j++) for (i = 1; i <= n - j; i++) d[j, i] = d[j - 1, i + 1] - d[j - 1, i]
  printf "%s: differences at k=1: d0..d5 = %s %s %s %s %s %s\n", name, d[0,1], d[1,1], d[2,1], d[3,1], d[4,1], d[5,1]
  # p(k) = sum_j d[j,1] C(k-1, j); expand in k then substitute k = s/4: coefficients of s^p as fractions num/den
  for (p = 0; p <= 4; p++) { cn[p] = 0 } den = 24 * 256
  # C(k-1, j) * j! as a polynomial in k: product_{i=0}^{j-1} (k - 1 - i); build with integer coefficients
  for (j = 0; j <= 4; j++) { for (p = 0; p <= 4; p++) q[p] = 0; q[0] = 1
    for (i = 0; i < j; i++) { for (p = 4; p >= 1; p--) q[p] = q[p - 1] - (1 + i) * q[p]; q[0] = -(1 + i) * q[0] }
    f = 1; for (i = 2; i <= j; i++) f *= i
    for (p = 0; p <= 4; p++) cn[p] += d[j, 1] * q[p] * (24 / f) * 4 ^ (4 - p) }   # coefficient of k^p -> s^p / 4^p, common den 24*256
  printf "%s(s) = ", name; for (p = 4; p >= 0; p--) { g = gcd(cn[p], den); printf "%s(%s/%s) s^%d", (p < 4 ? " + " : ""), cn[p] / g, den / g, p } printf "\n"
  for (k = 1; k <= n; k++) { s = 4 * k; v = 0; for (p = 0; p <= 4; p++) v += cn[p] * s ^ p; printf "  s=%d fit=%s data=%s %s\n", s, v / den, d[0, k], (v == d[0, k] * den ? "MET" : "PARTED") } }
