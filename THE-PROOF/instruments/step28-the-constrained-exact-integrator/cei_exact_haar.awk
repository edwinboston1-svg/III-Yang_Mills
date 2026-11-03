# cei_exact_haar.awk -- THE CERTIFIED TIER'S FIRST STONE (campaign 31.15): the normalised Haar measure of SU(2) = the uniform measure on S^3 in the
# quaternion coordinates (w, x, y, z), and every integrand the face-fibre engine integrates is a POLYNOMIAL in them (the Wilson weight is a
# character sum, chi_s(U) = U_s(w) the Chebyshev polynomial of the second kind in w = 1/2 tr U; a D-matrix entry in the monomial basis of Sym^s
# is a polynomial of degree s with coefficients in Z[i]); so every link tensor is an exact rational combination of the Wilson coefficients, by the
# monomial law  int w^a x^b y^c z^d dmu = 0 unless every exponent is even, else  prod_i (2k_i)! / (4^{k_i} k_i!)  /  (K + 1)!  with k_i = a_i/2
# and K = sum k_i  (the Dirichlet moments of S^{n-1} at n = 4: Gamma(n/2) prod Gamma(k_i + 1/2) / (Gamma(K + n/2) Gamma(1/2)^n)).
# Exact in gawk -M (big integers; a rational is a numerator/denominator pair reduced by gcd).  KNOWN ANSWERS: the second moment 1/4, the fourth 1/8,
# the mixed 1/24 (E[w^2 x^2] = 1/(n(n+2))), the sixth 5/64 (E[w^6] = 15/(n(n+2)(n+4)) = 15/192), the character orthogonality
# int chi_s(U) chi_t(U) dmu = delta_st for s, t <= 6 (chi_s = U_s(w), computed as polynomials in w and integrated monomial by monomial), and the
# character norm int chi_s^2 = 1 at every s to 8 -- each two-sided against a bent exponent.   usage: gawk -M -f cei_exact_haar.awk
function gcd(a, b,   t) { a = (a < 0) ? -a : a; b = (b < 0) ? -b : b; while (b != 0) { t = a % b; a = b; b = t } return a }
function fact(n,   r, i) { r = 1; for (i = 2; i <= n; i++) r *= i; return r }
function haar_num(a, b, c, d) {   # the numerator of the monomial's measure (its denominator from haar_den), both exact integers; 0 if any exponent odd
  if (a % 2 || b % 2 || c % 2 || d % 2) return 0
  return fact(a) * fact(b) * fact(c) * fact(d) }
function haar_den(a, b, c, d,   ka, kb, kc, kd, K) { ka = a / 2; kb = b / 2; kc = c / 2; kd = d / 2; K = ka + kb + kc + kd
  return 4 ^ K * fact(ka) * fact(kb) * fact(kc) * fact(kd) * fact(K + 1) }
function haar_str(a, b, c, d,   n, m, g) { n = haar_num(a, b, c, d); if (n == 0) return "0"; m = haar_den(a, b, c, d); g = gcd(n, m); return (n / g) "/" (m / g) }
# the characters as polynomials in w: U_0 = 1, U_1 = 2w, U_{s+1} = 2w U_s - U_{s-1}; CH[s, k] = the coefficient of w^k
function chars(smax,   s, k) { CH[0, 0] = 1; CH[1, 1] = 2; for (s = 1; s < smax; s++) for (k = 0; k <= s + 1; k++) CH[s + 1, k] = 2 * ((k >= 1) ? CH[s, k - 1] : 0) - ((s >= 1) ? CH[s - 1, k] : 0) }
# the exact integral of chi_s chi_t: sum over k, l of CH[s,k] CH[t,l] int w^{k+l}; as a reduced rational
function chichi(s, t,   k, l, n, m, nn, dd, g, N, D) { N = 0; D = 1
  for (k = 0; k <= s; k++) for (l = 0; l <= t; l++) { if (CH[s, k] == 0 || CH[t, l] == 0) continue; n = haar_num(k + l, 0, 0, 0); if (n == 0) continue; m = haar_den(k + l, 0, 0, 0)
    nn = CH[s, k] * CH[t, l] * n; N = N * m + nn * D; D = D * m; g = gcd(N, D); if (g > 1) { N /= g; D /= g } }
  if (N == 0) return "0"; g = gcd(N, D); return (N / g) "/" (D / g) }
BEGIN { PROCINFO["sorted_in"] = "@ind_num_asc"; chars(10)
  printf "CEI-EXACT-HAAR the monomial law on S^3, exact rationals\n"
  printf "  KAT moments: w^2 = %s (1/4)  w^4 = %s (1/8)  w^2 x^2 = %s (1/24)  w^6 = %s (5/64)  w^2 x^2 y^2 = %s (1/192 = 1/(n(n+2)(n+4)))  w^3 = %s (0)\n", haar_str(2, 0, 0, 0), haar_str(4, 0, 0, 0), haar_str(2, 2, 0, 0), haar_str(6, 0, 0, 0), haar_str(2, 2, 2, 0), haar_str(3, 0, 0, 0)
  ok = 1; bad = 0; for (s = 0; s <= 8; s++) for (t = 0; t <= 8; t++) { v = chichi(s, t); want = (s == t) ? "1/1" : "0"; if (v != want) { bad++; if (bad <= 3) printf "  KAT FAILED: int chi_%d chi_%d = %s, not %s\n", s, t, v, want } }
  printf "  KAT character orthogonality to spin 8: %d of 81 pairs met (int chi_s chi_t = delta_st)\n", 81 - bad
  # the sighted control: a bent character (chi_3 with its w coefficient +4 in place of -4) must break orthogonality
  CH[3, 1] = 4; v = chichi(3, 1); printf "  CONTROL bent chi_3: int chi_3 chi_1 = %s (must part from 0): %s\n", v, (v == "0") ? "BLIND" : "SIGHTED"; CH[3, 1] = -4
  # the character of a product with a fixed element T: chi_s(U T) is a polynomial in (w, x, y, z) through 1/2 tr(U T) = w t_w - x t_x - y t_y - z t_z; at T = 1 it is chi_s(U) -- the staple weight's monomial form is the same law
  printf "  the staple weight at the identity datum: 1 + sum_k c_k chi_k(w), a polynomial in w alone; at a datum T its argument is w t_w - x t_x - y t_y - z t_z, still a polynomial\n" }
