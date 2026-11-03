# cei_haar.awk -- THE KERNEL'S NORMALISATION AT beta = 0 (gawk): known answer (K2) of the constrained exact integrator (CEI blueprint §4).
# At beta = 0 every fine link is Haar, so a coarse link's eight straight paths are independent Haar quaternions and its average B is the mean
# of eight uniform points of S^3 -- a point of the unit BALL of R^4, |B| < 1 almost surely.  The characteristic function of the uniform law on
# S^3 is phi_1(t) = 2 J_1(|t|)/|t|; the mean of eight has phi_8(t) = phi_1(t/8)^8.  For the Gaussian kernel k_eps(X) = exp(-|X - c|^2 / 2 eps)
# at the datum c = r (1, 0, 0, 0) (the identity's direction at norm r), by Parseval and the angular integral of exp(-i t x.c) over S^3,
#   E[k_eps(B - c)] = (2 pi)^-4 (2 pi eps)^2 2 pi^2 INT_0^inf t^3 (2 J_1(r t)/(r t)) phi_8(t) exp(-eps t^2/2) dt,
# and E/(2 pi eps)^2 -> rho_8(c), the density of the mean at c, as eps -> 0.  THE FACT THIS FILE RECORDS (16:5x): rho_8 vanishes at |c| = 1
# (eight unit vectors average to a unit vector only when all coincide), so the exact vacuum datum c = 1 is on the boundary of the coarse
# variable's range and the fibre there is degenerate; the fibre is read at c = r 1 with r < 1 (the typical norm under the Gibbs measure, read
# by the engine from <|B|^2> = (1/64) sum_{p,p'} <1/2 tr(U_p^+ U_p')>).  J_1 by its series to x = 20 and by Hankel's expansion beyond.
# usage: gawk -f cei_haar.awk [-v R=0.9]
function J1(x,   s, k, t, p, q, c, y, u) {
  if (x < 1e-12) return x / 2
  if (x <= 20) { s = 0; t = x / 2; for (k = 0; k < 160; k++) { s += t; t *= -(x / 2) * (x / 2) / ((k + 1) * (k + 2)); if (k > 20 && (t < 0 ? -t : t) < 1e-19) break } return s }
  u = 1 / (x * x)
  p = 1 + 0.1171875 * u - 0.144195556640625 * u * u + 0.6766038834 * u * u * u          # Hankel P_1: 1 + 15/128x^2 - 14175/98304x^4 + 127702575/188743680x^6
  q = 0.375 / x - 0.102539062 / (x * x * x) + 0.277578290 / (x * x * x * x * x)           # Hankel Q_1: 3/8x - 315/3072x^3 + 1091475/3932160x^5
  c = x - 3 * PI / 4
  return sqrt(2 / (PI * x)) * (p * cos(c) - q * sin(c))
}
function phi1(t) { return (t < 1e-12) ? 1 : 2 * J1(t) / t }
function E_of(eps, r, T, N,   h, i, t, w, f, s) {        # Simpson on [0, T]
  h = T / N; s = 0
  for (i = 0; i <= N; i++) { t = i * h; w = (i == 0 || i == N) ? 1 : ((i % 2) ? 4 : 2)
    if (eps * t * t / 2 > 700) break; f = t * t * t * phi1(r * t) * (phi1(t / 8) ^ 8) * exp(-eps * t * t / 2); s += w * f }
  s *= h / 3
  return s * 2 * PI * PI * (2 * PI * eps) ^ 2 / (2 * PI) ^ 4
}
BEGIN { PI = atan2(0, -1); if (R == "") R = 0.9
  printf "CEI-HAAR: the kernel's mass at beta = 0, one coarse link (eight independent Haar paths), datum c = r*1\n"
  printf "  J_1 controls: J_1(1) = %.12f (0.440050585744)  J_1(10) = %.12f (0.043472746169)  J_1(30) = %.9f (-0.118751063)  J_1(50) = %.9f (-0.097511828)  series/Hankel seam at 20: %.12f vs %.12f\n", J1(1), J1(10), J1(30), J1(50), J1(19.999999), J1(20.000001)
  n = split("0.4 0.2 0.1 0.05 0.025 0.0125 0.00625", EP, " ")
  for (rr = 1; rr <= 2; rr++) { r = (rr == 1) ? R + 0 : 1.0
    printf "  r = %g:  %-8s %18s %18s %14s\n", r, "eps", "E[k_eps(B-c)]", "E/(2 pi eps)^2", "T,N control"
    for (q = 1; q <= n; q++) { e = EP[q] + 0; v = E_of(e, r, 80, 80000); v2 = E_of(e, r, 120, 160000)
      printf "  %-9s %-8g %18.12e %18.12e %14.2e\n", "", e, v, v / (2 * PI * e) ^ 2, (v2 - v) / (v != 0 ? v : 1) }
  }
  print "  rho_8 at the datum is the eps -> 0 limit of E/(2 pi eps)^2: finite at r < 1, ZERO at r = 1 (the boundary of the range)"
  exit 0
}
