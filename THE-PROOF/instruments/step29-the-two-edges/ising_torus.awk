# ising_torus.awk -- the diagonal reflection on an even torus: the positivity form read EXACTLY on the Ising measure.
#
#   The Ising measure on the N x N torus with bond weight (1 + t s s') at t = 1/2, scaled by 2 per bond to the integer weight
#   (2 + s s'); every number below is an exact integer or a ratio of two (gawk -M, MPZ).  Sites (i, j) = (x1, x2), d = i - j;
#   the diagonal reflection theta(i, j) = (j, i); the moved set d = N/2 (mod N).  Two engines:
#     road A  the row-to-row transfer matrices T_j (row j -> j+1; 2^N states; Z = Tr T_0 ... T_{N-1}; a two-point function
#             inserts two diagonal matrices) -- row-dependent so that the CUT can be applied;
#     road B  brute-force enumeration over all 2^(N^2) configurations (N = 4 only) -- shares no line with road A.
#   CUT=1   sets to one the weight of every bond incident to a moved site (the comparison measure of Addendum I, Lemma A).
#   T0=1    reads t = 0 (the dead world: every bond weight 1).
#   READINGS: G(k,k) = <s_(0,0) s_(k,k)>; the parent's form on F = s_a - s_b, a = (N/2, 1), b = (0, N/2 + 1), by TWO roads
#   (the displacement identity 2G(N/2-1,N/2-1) - 2G(1,1), and the four two-point functions summed directly); the positivity
#   Gram matrix M_xy = <s_theta(x) s_y> on the three positive-half sites (1,0), (2,0), (2,1) near the main diagonal with its
#   three leading principal minors (integer numerators; the sign is the verdict, Sylvester).
#   gawk -M -v N=6 -f ising_torus.awk   |   -v N=4 -v BRUTE=1   |   -v CUT=1   |   -v T0=1
BEGIN {
  if (N == "") N = 6; N = N + 0; S = 2 ^ N; H = N / 2
  BRUTE = (BRUTE == "" ? 0 : BRUTE + 0); T0 = (T0 == "" ? 0 : T0 + 0); CUT = (CUT == "" ? 0 : CUT + 0)
  printf "ISING-TORUS N=%d states_per_row=%d t=%s cut=%d engine=%s ;\n", N, S, (T0 ? "0" : "1/2"), CUT, (BRUTE ? "brute-force" : "transfer")
  for (r = 0; r < S; r++) for (i = 0; i < N; i++) SP[r, i] = (int(r / 2^i) % 2 == 1) ? 1 : -1
  if (BRUTE) { brute(); exit }
  # road A: T_j[r, q] = Π_i hb(i, j; r_i, r_{i+1}) * Π_i vb(i, j; r_i, q_i)   (row j's own bonds, then the bonds to row j+1)
  for (j = 0; j < N; j++) for (r = 0; r < S; r++) {
    h = 1; for (i = 0; i < N; i++) h = h * hbond(i, j, SP[r, i], SP[r, (i + 1) % N])
    for (q = 0; q < S; q++) { v = h; for (i = 0; i < N; i++) v = v * vbond(i, j, SP[r, i], SP[q, i]); TT[j, r, q] = v }
  }
  Z = corr2(-1, -1, -1, -1)
  printf "ISING-Z N=%d Z=%s ;\n", N, Z
  G11 = corr2(0, 0, 1, 1); GH = corr2(0, 0, H - 1, H - 1); G22 = corr2(0, 0, 2 % N, 2 % N)
  printf "ISING-G N=%d G(1,1)=%s/%s G(2,2)=%s/%s G(N/2-1,N/2-1)=%s/%s ;\n", N, G11, Z, G22, Z, GH, Z
  formA = 2 * GH - 2 * G11
  # the parent's F by the direct road: a = (H, 1), b = (0, H+1); theta a = (1, H), theta b = (H+1, 0)
  formB = corr2(1, H, H, 1) - corr2(1, H, 0, H + 1) - corr2(H + 1, 0, H, 1) + corr2(H + 1, 0, 0, H + 1)
  printf "ISING-RPFORM N=%d <(theta F) F> = 2 G(N/2-1,N/2-1) - 2 G(1,1) = %s/%s direct=%s/%s roads=%s sign=%s ;\n", N, formA, Z, formB, Z, (formA == formB ? "EQUAL" : "PART"), (formB < 0 ? "NEGATIVE" : (formB > 0 ? "POSITIVE" : "ZERO"))
  # the Gram matrix near the main diagonal: sites x1 = (1,0), x2 = (2,0), x3 = (2,1); theta x = (j, i)
  XI[1] = 1; XJ[1] = 0; XI[2] = 2; XJ[2] = 0; XI[3] = 2; XJ[3] = 1
  for (a = 1; a <= 3; a++) for (b = 1; b <= 3; b++) M[a, b] = corr2(XJ[a], XI[a], XI[b], XJ[b])
  m1 = M[1, 1]
  m2 = M[1, 1] * M[2, 2] - M[1, 2] * M[2, 1]
  m3 = M[1, 1] * (M[2, 2] * M[3, 3] - M[2, 3] * M[3, 2]) - M[1, 2] * (M[2, 1] * M[3, 3] - M[2, 3] * M[3, 1]) + M[1, 3] * (M[2, 1] * M[3, 2] - M[2, 2] * M[3, 1])
  printf "ISING-GRAM N=%d cut=%d sites=(1,0),(2,0),(2,1) numerators=[%s,%s,%s;%s,%s,%s;%s,%s,%s] over Z symmetric=%s ;\n", N, CUT, M[1,1], M[1,2], M[1,3], M[2,1], M[2,2], M[2,3], M[3,1], M[3,2], M[3,3], ((M[1,2]==M[2,1] && M[1,3]==M[3,1] && M[2,3]==M[3,2]) ? "YES" : "NO")
  printf "ISING-MINORS N=%d cut=%d m1=%s m2=%s m3=%s (numerators over Z, Z^2, Z^3) verdict=%s ;\n", N, CUT, m1, m2, m3, ((m1 > 0 && m2 > 0 && m3 > 0) ? "POSITIVE-DEFINITE" : ((m1 >= 0 && m2 >= 0 && m3 >= 0) ? "POSITIVE-SEMIDEFINITE-OR-DEGENERATE" : "INDEFINITE"))
  printf "ISING-END ;\n"
}
function moved(i, j) { return (((i - j) % N + N) % N == H) }
function hbond(i, j, s, sp) { if (T0) return 1; if (CUT && (moved(i, j) || moved((i + 1) % N, j))) return 1; return 2 + s * sp }
function vbond(i, j, s, sp) { if (T0) return 1; if (CUT && (moved(i, j) || moved(i, (j + 1) % N))) return 1; return 2 + s * sp }
# Tr( D_{(i1,j1)} ... ) with the product of T_0..T_{N-1} and the spin diagonals inserted before T_{j1} and T_{j2}; (-1,...) = none
function corr2(i1, j1, i2, j2,   r, q, j, s) {
  for (r = 0; r < S; r++) for (q = 0; q < S; q++) P[r, q] = (r == q ? 1 : 0)
  for (j = 0; j < N; j++) {
    if (j == j1 && i1 >= 0) for (r = 0; r < S; r++) for (q = 0; q < S; q++) P[r, q] = P[r, q] * SP[q, i1]
    if (j == j2 && i2 >= 0) for (r = 0; r < S; r++) for (q = 0; q < S; q++) P[r, q] = P[r, q] * SP[q, i2]
    matmul_P_T(j)
  }
  s = 0; for (r = 0; r < S; r++) s = s + P[r, r]
  return s
}
function matmul_P_T(j,   r, q, k, acc) {
  for (r = 0; r < S; r++) { for (q = 0; q < S; q++) { acc = 0; for (k = 0; k < S; k++) acc = acc + P[r, k] * TT[j, k, q]; Q[r, q] = acc } }
  for (r = 0; r < S; r++) for (q = 0; q < S; q++) P[r, q] = Q[r, q]
}
# road B: every configuration of the N x N torus, spins by bits of c (site (i, j) -> bit i + N j); the same readings
function brute(   c, nconf, i, j, w, z, g11, g22, fB, a, b, q) {
  nconf = 2 ^ (N * N); z = 0; g11 = 0; g22 = 0; fB = 0; for (a = 1; a <= 3; a++) for (b = 1; b <= 3; b++) MB[a, b] = 0
  XI[1] = 1; XJ[1] = 0; XI[2] = 2; XJ[2] = 0; XI[3] = 2; XJ[3] = 1
  for (c = 0; c < nconf; c++) {
    for (j = 0; j < N; j++) for (i = 0; i < N; i++) { q = int(c / 2^(i + N * j)) % 2; X[i, j] = (q == 1 ? 1 : -1) }
    w = 1
    for (j = 0; j < N; j++) for (i = 0; i < N; i++) { w = w * hbond(i, j, X[i, j], X[(i + 1) % N, j]) * vbond(i, j, X[i, j], X[i, (j + 1) % N]) }
    z = z + w; g11 = g11 + w * X[0, 0] * X[1, 1]; g22 = g22 + w * X[0, 0] * X[2 % N, 2 % N]
    fB = fB + w * (X[1, H] - X[H + 1, 0]) * (X[H, 1] - X[0, H + 1])
    for (a = 1; a <= 3; a++) for (b = 1; b <= 3; b++) MB[a, b] += w * X[XJ[a], XI[a]] * X[XI[b], XJ[b]]
  }
  printf "ISING-Z N=%d Z=%s ;\n", N, z
  printf "ISING-G N=%d G(1,1)=%s/%s G(2,2)=%s/%s ;\n", N, g11, z, g22, z
  printf "ISING-RPFORM N=%d direct=%s/%s sign=%s ;\n", N, fB, z, (fB < 0 ? "NEGATIVE" : (fB > 0 ? "POSITIVE" : "ZERO"))
  printf "ISING-GRAM N=%d cut=%d sites=(1,0),(2,0),(2,1) numerators=[%s,%s,%s;%s,%s,%s;%s,%s,%s] over Z ;\n", N, CUT, MB[1,1], MB[1,2], MB[1,3], MB[2,1], MB[2,2], MB[2,3], MB[3,1], MB[3,2], MB[3,3]
  printf "ISING-END ;\n"
}
