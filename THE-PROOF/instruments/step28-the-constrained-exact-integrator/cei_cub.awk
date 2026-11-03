# cei_cub.awk -- THE CUBATURE OF THE GAUSSIAN EXTERIOR (campaign 31.14): the engine's reading averaged over the exterior's Gaussian marginal
# on its outside links, the average a degree-3 Gaussian cubature (Stroud: the 2n points +-sqrt(n) along an orthonormal basis of the field's
# n = 3 x NE dimensions, weight 1/(2n) each, exact for every polynomial of degree <= 3 in the field).  Input: cei_dtn's marg output (MARG-LINK:
# the outside links in the engine's listing order; MARG-EIG: the covariance's eigenvalues sigma_m^2 and eigenvectors u_m).  Two rules sharing
# no point: RULE=A along the eigenbasis (a point moves ONE mode, every link along u_m, one colour), RULE=B along the canonical basis through the
# symmetric square root (a point moves one LINK's share of every mode, one colour); their difference is the rule's own error indicator, since both
# are exact to degree 3 and differ at degree 4.  Output: one datum file per point under DIR/ ("x y z t d w x y z", the field's quaternion
# exp(i a.sigma/2) per link) and an index DIR/index.txt "name weight" for the runner.   usage: gawk -v RULE=A -v DIR=cub_A -f cei_cub.awk cei_marg.R8.txt
/^MARG-LINK/ { e = $2 + 1; NE = e; X[e] = $3; Y[e] = $4; Z[e] = $5; T[e] = $6; D[e] = $7 }
/^MARG-EIG/ { m = $2 + 1; NM = m; EV[m] = $3 + 0; for (i = 1; i <= NE; i++) U[m, i] = $(3 + i) + 0 }
function quatline(e, ax, ay, az,   a, c, s, f) { a = sqrt(ax * ax + ay * ay + az * az); c = cos(a / 2); s = (a > 1e-300) ? sin(a / 2) / a : 0.5
  return sprintf("%d %d %d %d %d %.15f %.15f %.15f %.15f", X[e], Y[e], Z[e], T[e], D[e], c, s * ax, s * ay, s * az) }
END {
  if (RULE == "") RULE = "A"; if (DIR == "") DIR = "cub_" RULE
  npos = 0; for (m = 1; m <= NM; m++) if (EV[m] > 1e-12 * EV[1]) npos++
  n = 3 * npos; w = 1 / (2 * n); r = sqrt(n)
  # RULE C, THE DRESSED EXTERIOR (campaign 31.14/31.16): the object's own quadratic response h_m along each mode (RESP = cei_resp's record,
  # "MODE m h = <h>") folded into the marginal -- the effective variance 1/(1/sigma_m^2 + h_m) -- and every point carrying the residual factor
  # exp(+1/2 h_m |X_m|^2) that divides the quadratic part of Z back out; the runner multiplies the point's Z by it, so the integrand it averages
  # is the residual r(X) = Z(X) e^{XHX/2} / Z(0), of order one where the response is quadratic
  if (RULE == "C") { if (RESP == "") { print "RULE C needs -v RESP=<response record>"; exit 3 }
    while ((getline line < RESP) > 0) if (line ~ /^MODE /) { split(line, ff, " "); H[ff[2] + 0] = ff[5] + 0 }
    close(RESP); for (m = 1; m <= npos; m++) { if (!((m) in H)) { print "RULE C: mode " m " has no response"; exit 3 } EVE[m] = 1 / (1 / EV[m] + H[m]) } }
  # the symmetric square root for rule B: L = sum_m sigma_m u_m u_m^T
  if (RULE == "B") for (i = 1; i <= NE; i++) for (j = 1; j <= NE; j++) { s = 0; for (m = 1; m <= npos; m++) s += sqrt(EV[m]) * U[m, i] * U[m, j]; SQ[i, j] = s }
  system("mkdir -p " DIR); idx = DIR "/index.txt"; printf "" > idx; np = 0
  for (k = 1; k <= (RULE == "B" ? NE : npos); k++) for (col = 1; col <= 3; col++) for (sg = -1; sg <= 1; sg += 2) {
    name = sprintf("%s_%03d_%d_%s.file", RULE, k, col, sg > 0 ? "p" : "m"); f = DIR "/" name; np++
    for (e = 1; e <= NE; e++) { amp = (RULE == "A") ? sg * r * sqrt(EV[k]) * U[k, e] : ((RULE == "C") ? sg * r * sqrt(EVE[k]) * U[k, e] : sg * r * SQ[e, k])
      ax = (col == 1) ? amp : 0; ay = (col == 2) ? amp : 0; az = (col == 3) ? amp : 0; M2 += w * amp * amp; print quatline(e, ax, ay, az) > f }
    close(f); if (RULE == "C") printf "%s %.17g %.17g\n", name, w, exp(0.5 * H[k] * n * EVE[k]) >> idx; else printf "%s %.17g\n", name, w >> idx }
  close(idx)
  # the rule's own known answers: sum of weights 1; the second moment along every direction reproduces the covariance's trace: sum_pts w |a|^2 = 3 tr Cov
  tr = 0; for (m = 1; m <= npos; m++) tr += EV[m]
  printf "CEI-CUB rule %s: %d modes above 1e-12 of the largest, n = %d field dimensions, %d points of weight %.6e (sum %.6f); KAT second moment: the rule's sum w |a|^2 = %.6f against 3 tr Cov = %.6f\n", RULE, npos, n, np, w, np * w, M2, 3 * tr }
