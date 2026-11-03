# noise35.awk -- the noise structure of MIR's 35 pinned W2L2 tables (rec/full_W2L2_*.txt): per datum the joint (2,1), (1,2) moments, the
# conditional connected part M[2,1] - M[2,0]M[0,1], the product M[2,0]M[0,1], and the A<->B symmetric average; the spread over data and the
# mean with its standard error.  usage: gawk -f noise35.awk full_W2L2_*.txt
FNR == 1 { nf++ }
/^W2-CLASS a=/ { a = substr($2, 3) + 0; c = substr($3, 3) + 0; M[nf, a, c] = $7 + 0 }
END {
  for (i = 1; i <= nf; i++) {
    j21 = M[i,2,1]; j12 = M[i,1,2]; p21 = M[i,2,0] * M[i,0,1]; p12 = M[i,1,0] * M[i,0,2]
    c21 = j21 - p21; c12 = j12 - p12; sy = (j21 + j12) / 2; syc = (c21 + c12) / 2
    X[1] += j21; X2[1] += j21*j21; X[2] += j12; X2[2] += j12*j12; X[3] += c21; X2[3] += c21*c21; X[4] += p21; X2[4] += p21*p21
    X[5] += sy; X2[5] += sy*sy; X[6] += syc; X2[6] += syc*syc; X[7] += M[i,2,0]; X2[7] += M[i,2,0]^2; X[8] += M[i,0,1]; X2[8] += M[i,0,1]^2
    X[9] += (M[i,2,0] + M[i,0,2]) / 2; X2[9] += ((M[i,2,0] + M[i,0,2]) / 2)^2
    X[10] += (M[i,1,0] + M[i,0,1]) / 2; X2[10] += ((M[i,1,0] + M[i,0,1]) / 2)^2
    X[11] += M[i,1,1]; X2[11] += M[i,1,1]^2 }
  split("M21 M12 conn21|w M20*M01 sym(M21,M12) sym(conn|w) M20 M01 sym(M20,M02) sym(M10,M01) M11", nm, " ")
  printf "NOISE35 n=%d data (MIR's pinned W2L2 tables, beta=2.2)\n", nf
  for (k = 1; k <= 11; k++) { m = X[k] / nf; v = X2[k] / nf - m*m; if (v < 0) v = 0; sd = sqrt(v * nf / (nf - 1))
    printf "NOISE35 %-14s mean %+.4e  sd over data %.4e  sem %.4e\n", nm[k], m, sd, sd / sqrt(nf) }
  # the averaged table's connected (2,1) and (1,2): mean M21 - mean M20 * mean M01
  m21 = X[1]/nf; m12 = X[2]/nf; m20 = X[7]/nf; m01 = X[8]/nf
  for (i = 1; i <= nf; i++) { m02 += M[i,0,2]/nf; m10 += M[i,1,0]/nf }
  printf "NOISE35 averaged-table connected: b21 ~ %+.4e  b12 ~ %+.4e  (mean M21 - mean M20 mean M01, etc.)\n", m21 - m20*m01, m12 - m10*m02 }
