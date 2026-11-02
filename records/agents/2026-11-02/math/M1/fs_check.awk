# fs_check.awk: Lemma FS (the Frobenius-Schur cross-cap step) checked EXACTLY on the 24 Hurwitz units.
# The 24 unit Hurwitz quaternions are the vertices of the 24-cell, a spherical 5-design on S^3 = SU(2): their average is
# the Haar integral of every polynomial of degree <= 5 in the quaternion coordinates.  D^j entries have degree 2j, so every
# integrand below (degree 4j in U) is exact at j = 1/2 (degree 2) and j = 1 (degree 4).  All arithmetic is in integers:
# coordinates doubled (Q = 2q), spin-1/2 matrices doubled (2U, Gaussian-integer entries), spin-1 matrices quadrupled (4R).
# Checks: (A) int D_ab D_cd = eps_ac eps_bd / d; (B) MOBIUS CUP int chi(UXUY) = (nu2/d) chi(X^-1 Y), all 576 pairs;
# (C) RP2 int chi(U^2) = nu2; (D) the ORIENTABLE control int chi(U X U^-1 Y) = chi(X) chi(Y) / d.
# Sighted negative controls (must FAIL somewhere): (B-wrongplace) chi(XY) in place of chi(X^-1 Y); (B-nosign) +1 for nu2.
function setU(n, Ur, Ui,   W, X, Y, Z) {          # 2U for unit n: U = [[w+iz, y+ix], [-y+ix, w-iz]]
  W = QW[n]; X = QX[n]; Y = QY[n]; Z = QZ[n]
  Ur[1,1] = W;  Ui[1,1] = Z
  Ur[1,2] = Y;  Ui[1,2] = X
  Ur[2,1] = -Y; Ui[2,1] = X
  Ur[2,2] = W;  Ui[2,2] = -Z
}
function cmul(Ar, Ai, Br, Bi, Cr, Ci,   i, j, k) { # C = A B, 2x2 complex
  for (i = 1; i <= 2; i++) for (j = 1; j <= 2; j++) {
    Cr[i,j] = 0; Ci[i,j] = 0
    for (k = 1; k <= 2; k++) {
      Cr[i,j] += Ar[i,k] * Br[k,j] - Ai[i,k] * Bi[k,j]
      Ci[i,j] += Ar[i,k] * Bi[k,j] + Ai[i,k] * Br[k,j]
    }
  }
}
function cdag(Ar, Ai, Cr, Ci,   i, j) { for (i = 1; i <= 2; i++) for (j = 1; j <= 2; j++) { Cr[i,j] = Ar[j,i]; Ci[i,j] = -Ai[j,i] } }
function setR(n, R,   W, X, Y, Z) {               # 4R for unit n (R the SO(3) image; 4R = Q-quadratic, integer)
  W = QW[n]; X = QX[n]; Y = QY[n]; Z = QZ[n]
  R[1,1] = W*W + X*X - Y*Y - Z*Z; R[1,2] = 2*(X*Y - W*Z);         R[1,3] = 2*(X*Z + W*Y)
  R[2,1] = 2*(X*Y + W*Z);         R[2,2] = W*W - X*X + Y*Y - Z*Z; R[2,3] = 2*(Y*Z - W*X)
  R[3,1] = 2*(X*Z - W*Y);         R[3,2] = 2*(Y*Z + W*X);         R[3,3] = W*W - X*X - Y*Y + Z*Z
}
function rmul(A, B, C,   i, j, k) { for (i = 1; i <= 3; i++) for (j = 1; j <= 3; j++) { C[i,j] = 0; for (k = 1; k <= 3; k++) C[i,j] += A[i,k] * B[k,j] } }
function rtr(A) { return A[1,1] + A[2,2] + A[3,3] }
function rtrT(A, B,   i, j, s) { s = 0; for (i = 1; i <= 3; i++) for (j = 1; j <= 3; j++) s += A[i,j] * B[i,j]; return s }   # tr(A^T B)
BEGIN {
  # the 24 units, doubled
  N = 0
  for (p = 1; p <= 4; p++) for (s = -1; s <= 1; s += 2) { N++; QW[N] = 0; QX[N] = 0; QY[N] = 0; QZ[N] = 0
    if (p == 1) QW[N] = 2 * s; if (p == 2) QX[N] = 2 * s; if (p == 3) QY[N] = 2 * s; if (p == 4) QZ[N] = 2 * s }
  for (a = -1; a <= 1; a += 2) for (b = -1; b <= 1; b += 2) for (c = -1; c <= 1; c += 2) for (d = -1; d <= 1; d += 2) {
    N++; QW[N] = a; QX[N] = b; QY[N] = c; QZ[N] = d }
  for (n = 1; n <= N; n++) if (QW[n]^2 + QX[n]^2 + QY[n]^2 + QZ[n]^2 != 4) { print "BAD UNIT " n; exit 1 }
  printf "FS-CHECK units=%d (doubled norm 4 each)\n", N

  # ---------------- spin 1/2: d = 2, nu2 = -1, eps = [[0,1],[-1,0]] ----------------
  E[1,1] = 0; E[1,2] = 1; E[2,1] = -1; E[2,2] = 0
  for (n = 1; n <= N; n++) { setU(n, tr_, ti_); for (i = 1; i <= 2; i++) for (j = 1; j <= 2; j++) { UR[n,i,j] = tr_[i,j]; UI[n,i,j] = ti_[i,j] } }
  # (A) sum_U (2U)_ab (2U)_cd = 24 * 4 * eps_ac eps_bd / 2 = 48 eps_ac eps_bd
  okA = 0; badA = 0
  for (a = 1; a <= 2; a++) for (b = 1; b <= 2; b++) for (c = 1; c <= 2; c++) for (d = 1; d <= 2; d++) {
    sr = 0; si = 0
    for (n = 1; n <= N; n++) { sr += UR[n,a,b]*UR[n,c,d] - UI[n,a,b]*UI[n,c,d]; si += UR[n,a,b]*UI[n,c,d] + UI[n,a,b]*UR[n,c,d] }
    if (sr == 48 * E[a,c] * E[b,d] && si == 0) okA++; else { badA++; printf "A-half FAIL abcd=%d%d%d%d sum=%d+%di\n", a, b, c, d, sr, si } }
  printf "FS-CHECK j=1/2 (A) int D_ab D_cd = eps_ac eps_bd/d: %d of 16 entries hold, %d fail\n", okA, badA
  # (C) RP2: sum_U tr((2U)^2) = 4 * 24 * nu2 = -96
  sc = 0; sci = 0
  for (n = 1; n <= N; n++) for (i = 1; i <= 2; i++) for (k = 1; k <= 2; k++) { sc += UR[n,i,k]*UR[n,k,i] - UI[n,i,k]*UI[n,k,i]; sci += UR[n,i,k]*UI[n,k,i] + UI[n,i,k]*UR[n,k,i] }
  printf "FS-CHECK j=1/2 (C) RP2 sum tr((2U)^2) = %d%+di (staked -96 = 4*24*nu2) -> %s\n", sc, sci, (sc == -96 && sci == 0) ? "HOLDS" : "FAILS"
  # (B) Mobius cup and (D) orientable control, all 576 pairs
  okB = 0; badB = 0; wrongPlaceFail = 0; noSignFail = 0; okD = 0; badD = 0
  for (x = 1; x <= N; x++) for (y = 1; y <= N; y++) {
    for (i = 1; i <= 2; i++) for (j = 1; j <= 2; j++) { Xr[i,j] = UR[x,i,j]; Xi[i,j] = UI[x,i,j]; Yr[i,j] = UR[y,i,j]; Yi[i,j] = UI[y,i,j] }
    lr = 0; li = 0; orr = 0; oi = 0
    for (n = 1; n <= N; n++) {
      for (i = 1; i <= 2; i++) for (j = 1; j <= 2; j++) { Ar[i,j] = UR[n,i,j]; Ai[i,j] = UI[n,i,j] }
      cmul(Ar, Ai, Xr, Xi, M1r, M1i); cmul(M1r, M1i, Ar, Ai, M2r, M2i); cmul(M2r, M2i, Yr, Yi, M3r, M3i)
      lr += M3r[1,1] + M3r[2,2]; li += M3i[1,1] + M3i[2,2]
      cdag(Ar, Ai, Adr, Adi); cmul(M1r, M1i, Adr, Adi, M4r, M4i); cmul(M4r, M4i, Yr, Yi, M5r, M5i)
      orr += M5r[1,1] + M5r[2,2]; oi += M5i[1,1] + M5i[2,2]
    }
    cdag(Xr, Xi, Xdr, Xdi); cmul(Xdr, Xdi, Yr, Yi, P1r, P1i); t1r = P1r[1,1] + P1r[2,2]; t1i = P1i[1,1] + P1i[2,2]   # tr((2X)^+ (2Y))
    cmul(Xr, Xi, Yr, Yi, P2r, P2i); t2r = P2r[1,1] + P2r[2,2]; t2i = P2i[1,1] + P2i[2,2]                                 # tr((2X)(2Y))
    if (lr == -48 * t1r && li == -48 * t1i) okB++; else badB++
    if (!(lr == -48 * t2r && li == -48 * t2i)) wrongPlaceFail++
    if (!(lr == 48 * t1r && li == 48 * t1i)) noSignFail++
    trX = Xr[1,1] + Xr[2,2]; trY = Yr[1,1] + Yr[2,2]                                                                      # real for SU(2)
    if (orr == 48 * trX * trY && oi == 0) okD++; else badD++
  }
  printf "FS-CHECK j=1/2 (B) MOBIUS CUP sum tr(2U 2X 2U 2Y) = -48 tr((2X)^+ 2Y): %d of 576 pairs hold, %d fail\n", okB, badB
  printf "FS-CHECK j=1/2 (B-controls) chi(XY) placement fails at %d pairs; nu2 -> +1 fails at %d pairs (both must be > 0)\n", wrongPlaceFail, noSignFail
  printf "FS-CHECK j=1/2 (D) ORIENTABLE sum tr(2U 2X (2U)^+ 2Y) = 48 tr(2X) tr(2Y): %d of 576 hold, %d fail\n", okD, badD

  # ---------------- spin 1: d = 3, nu2 = +1, eps = I (Cartesian basis) ----------------
  for (n = 1; n <= N; n++) { setR(n, t3_); for (i = 1; i <= 3; i++) for (j = 1; j <= 3; j++) RR[n,i,j] = t3_[i,j] }
  for (n = 1; n <= N; n++) { for (i = 1; i <= 3; i++) for (j = 1; j <= 3; j++) { s = 0; for (k = 1; k <= 3; k++) s += RR[n,i,k]*RR[n,j,k]; if (s != 16 * (i == j)) { print "R NOT ORTHOGONAL at unit " n; exit 1 } } }
  okA = 0; badA = 0
  for (a = 1; a <= 3; a++) for (b = 1; b <= 3; b++) for (c = 1; c <= 3; c++) for (d = 1; d <= 3; d++) {
    s = 0; for (n = 1; n <= N; n++) s += RR[n,a,b] * RR[n,c,d]
    if (s == 128 * (a == c) * (b == d)) okA++; else { badA++; printf "A-one FAIL abcd=%d%d%d%d sum=%d\n", a, b, c, d, s } }
  printf "FS-CHECK j=1 (A) int D_ab D_cd = delta_ac delta_bd/3: %d of 81 entries hold, %d fail\n", okA, badA
  sc = 0; for (n = 1; n <= N; n++) for (i = 1; i <= 3; i++) for (k = 1; k <= 3; k++) sc += RR[n,i,k] * RR[n,k,i]
  printf "FS-CHECK j=1 (C) RP2 sum tr((4R)^2) = %d (staked 384 = 16*24*nu2) -> %s\n", sc, (sc == 384) ? "HOLDS" : "FAILS"
  okB = 0; badB = 0; wrongPlaceFail = 0; okD = 0; badD = 0
  for (x = 1; x <= N; x++) for (y = 1; y <= N; y++) {
    for (i = 1; i <= 3; i++) for (j = 1; j <= 3; j++) { XX[i,j] = RR[x,i,j]; YY[i,j] = RR[y,i,j] }
    l = 0; o = 0
    for (n = 1; n <= N; n++) {
      for (i = 1; i <= 3; i++) for (j = 1; j <= 3; j++) { AA[i,j] = RR[n,i,j]; AT[i,j] = RR[n,j,i] }
      rmul(AA, XX, M1); rmul(M1, AA, M2); rmul(M2, YY, M3); l += rtr(M3)
      rmul(M1, AT, M4); rmul(M4, YY, M5); o += rtr(M5)
    }
    rmul(XX, YY, P2)
    if (l == 128 * rtrT(XX, YY)) okB++; else badB++
    if (l != 128 * rtr(P2)) wrongPlaceFail++
    if (o == 128 * rtr(XX) * rtr(YY)) okD++; else badD++
  }
  printf "FS-CHECK j=1 (B) MOBIUS CUP sum tr(4R 4X 4R 4Y) = 128 tr((4X)^T 4Y): %d of 576 pairs hold, %d fail\n", okB, badB
  printf "FS-CHECK j=1 (B-control) chi(XY) placement fails at %d pairs (must be > 0)\n", wrongPlaceFail
  printf "FS-CHECK j=1 (D) ORIENTABLE sum tr(4R 4X (4R)^T 4Y) = 128 tr(4X) tr(4Y): %d of 576 hold, %d fail\n", okD, badD
}
