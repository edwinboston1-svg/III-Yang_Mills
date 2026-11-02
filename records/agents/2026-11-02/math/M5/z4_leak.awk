# M5 z4_leak.awk -- THE TILT LEAK, EXACT, ON THE SMALLEST GROUP WITH A Z2 CENTRE AND A NONTRIVIAL QUOTIENT: Z4 (centre {0,2}, quotient Z2).
# Convolution K(x - y) on Z4 with Fourier coefficients 1, k1, k2, k1 (k1: the centre-ODD characters, the vortex channel; k2: the even one,
# the quotient's channel); tilts a = (A, 1, 1/A, 1), b = (B, 1, 1/B, 1) (odd parts (A - 1/A)/2 (1,0,-1,0)).  The quotient channel is the
# correlation of the PARITIES x mod 2, y mod 2: a 2x2 table, so its maximal correlation is the absolute Pearson correlation, computed here in
# EXACT RATIONALS (gawk -M integers).  The full maximal correlation (all functions on Z4) is the second singular value of the normalised 4x4
# kernel, computed in double precision (a reading) by power iteration on the deflated Gram matrix.
# Known answers: untilted (A = B = 1) the parity correlation equals k2 exactly, and the full one equals max(k1, k2).
# usage: gawk -M -v K1N=1 -v K1D=10 -v K2N=1 -v K2D=100 -v A=2 -v B=2 -f z4_leak.awk
function gcd(a, b,   t) { if (a < 0) a = 0 - a; if (b < 0) b = 0 - b; while (b) { t = a % b; a = b; b = t } return a }
BEGIN { if (!K1D) { K1N = 1; K1D = 10 } if (!K2D) { K2N = 1; K2D = 100 } if (!A) A = 2; if (!B) B = 2
  # K(d) * 4 * K1D * K2D as integers: K(0) = (1 + 2k1 + k2)/4, K(1) = K(3) = (1 - k2)/4, K(2) = (1 - 2k1 + k2)/4
  D = K1D * K2D; K0 = D + 2 * K1N * K2D + K2N * K1D; K1 = D - K2N * K1D; K2 = D - 2 * K1N * K2D + K2N * K1D
  if (K2 < 0 || K1 < 0) { print "REFUSED: K is not a probability (1 - 2 k1 + k2 < 0 or k2 > 1)"; exit 2 }
  # tilts as rationals over A*B: a(0) = A, a(2) = 1/A, a(1) = a(3) = 1  -> multiply by A: (A^2, A, 1, A); same for b with B
  aa[0] = A * A; aa[1] = A; aa[2] = 1; aa[3] = A; bb[0] = B * B; bb[1] = B; bb[2] = 1; bb[3] = B
  KK[0] = K0; KK[1] = K1; KK[2] = K2; KK[3] = K1
  for (x = 0; x < 4; x++) for (y = 0; y < 4; y++) { d = (x - y + 4) % 4; P[x, y] = aa[x] * bb[y] * KK[d]; Z += P[x, y] }
  for (p = 0; p < 2; p++) for (q = 0; q < 2; q++) T[p, q] = 0
  for (x = 0; x < 4; x++) for (y = 0; y < 4; y++) T[x % 2, y % 2] += P[x, y]
  r0 = T[0,0] + T[0,1]; r1 = T[1,0] + T[1,1]; c0 = T[0,0] + T[1,0]; c1 = T[0,1] + T[1,1]
  NUM = T[0,0] * T[1,1] - T[0,1] * T[1,0]; NUM2 = NUM * NUM; DEN2 = r0 * r1 * c0 * c1   # rho~^2 = NUM^2 / DEN2 exactly
  g = gcd(NUM2, DEN2); printf "Z4-LEAK k1=%d/%d k2=%d/%d A=%d B=%d: parity (quotient) correlation^2 = %d/%d", K1N, K1D, K2N, K2D, A, B, NUM2 / g, DEN2 / g
  # compare with the Turan square k1^2 exactly: rho~ > k1^2  <=>  NUM2 * K1D^4 > DEN2 * K1N^4
  printf " ; rho~ %s k1^2 (exact comparison) ; rho~ = %.9f, k1^2 = %.9f, k2 = %.9f\n", (NUM2 * K1D ^ 4 > DEN2 * K1N ^ 4 ? ">" : "<="), sqrt(NUM2 / DEN2), (K1N / K1D) ^ 2, K2N / K2D
  # full maximal correlation: M[x,y] = P[x,y]/sqrt(pu[x] pv[y]); second singular value (doubles)
  for (x = 0; x < 4; x++) { pu[x] = 0; pv[x] = 0 } for (x = 0; x < 4; x++) for (y = 0; y < 4; y++) { pu[x] += P[x, y]; pv[y] += P[x, y] }
  for (x = 0; x < 4; x++) for (y = 0; y < 4; y++) M[x, y] = (P[x, y] / Z) / sqrt((pu[x] / Z) * (pv[y] / Z))
  for (x = 0; x < 4; x++) { su[x] = sqrt(pu[x] / Z) }   # the top singular pair is (sqrt pu, sqrt pv) with value 1: deflate it
  for (x = 0; x < 4; x++) for (y = 0; y < 4; y++) { G[x, y] = 0; for (z = 0; z < 4; z++) G[x, y] += M[x, z] * M[y, z]; G[x, y] -= su[x] * su[y] }
  for (x = 0; x < 4; x++) v[x] = (x == 1 ? 1 : 0.3 + 0.1 * x)
  for (it = 0; it < 4000; it++) { n = 0; for (x = 0; x < 4; x++) { w[x] = 0; for (y = 0; y < 4; y++) w[x] += G[x, y] * v[y]; n += w[x] * w[x] } n = sqrt(n); for (x = 0; x < 4; x++) v[x] = w[x] / n }
  lam = 0; for (x = 0; x < 4; x++) { t = 0; for (y = 0; y < 4; y++) t += G[x, y] * v[y]; lam += v[x] * t }
  printf "Z4-LEAK full maximal correlation rho = %.9f ; rho~/rho^2 = %.6f ; Turan slaving %s\n", sqrt(lam), sqrt(NUM2 / DEN2) / lam, (sqrt(NUM2 / DEN2) <= lam ? "HOLDS" : "FAILS") }
