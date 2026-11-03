# w2_modes.awk -- THE PAIR COUPLING'S MODES IN WILSON UNITS, from w2_strip's class moments (THE CROSSING CAMPAIGN W2; the far shore
# section 10 RESULTS 3 (c), (g); 2026-11-01, the author).  Reads the `W2-CLASS a= c= E[chi_a(A) chi_c(B)] = v` lines of one record (one
# beta, one datum, a, c <= L), builds the truncated joint class density W_L(th_A, th_B) = sum_{a,c <= L} E[chi_a chi_c] chi_a chi_c on an
# N x N Chebyshev-U grid (nodes j pi/(N+1), weights (2/(N+1)) sin^2: the Haar class measure, exact for characters to degree 2N), the marginals
# W_A, W_B, the ratio R = W/(W_A W_B) = e^{delta_2} on the grid, and the modes of R - 1 and of delta_2 = log R by the same quadrature.
# REFUSES by name when the truncated density is not positive on the grid (the log is then not readable at this L).
# THE UNITS: a mode (a, c) that CREATES flux at a plaquette the exit expansion left bare is charged against the one-plaquette coefficient it
# stands in for, E[chi_a(A)] = d_a a'_a (the marginal's own mode); a mode that MODIFIES a spin-1/2 plaquette (a in {0, 2}, c in {0, 2}: the
# integer-spin-1 modes, the only ones with 1/2 (x) rho containing 1/2) is charged once.  Reported: r_mod (the modifying share), r_create (every
# mode over its creating unit), c_rel = 20 r e^{7 alpha} at alpha = 1/1000 (twenty adjacent pairs through a coarse plaquette, seven coarse links
# in the pair), and c_sup's ingredient sup|delta_2| on the grid beside them (a lower bound of the Fourier content, never the proof's quantity).
# usage: gawk -v N=256 -v L2=8 -f w2_modes.awk <record>     (L2 = the mode cap of the output, at most 2N)
function chi(a, th) { if (a == 0) return 1; return sin((a + 1) * th) / sin(th) }
function abs(x) { return x < 0 ? -x : x }
/^W2-CLASS a=/ { a = substr($2, 3) + 0; c = substr($3, 3) + 0; v = $7 + 0; M[a, c] = v; if (a > L) L = a; if (c > L) L = c; nread++ }
/^W2-OBJECT/ { hdr = $0 }
END {
  if (!N) N = 256; if (!L2) L2 = 2 * L; if (!nread) { print "W2-MODES REFUSED: no W2-CLASS lines"; exit 2 }
  # THE DEAD-TABLE CONTROL (2026-11-01 04:1x: the first run read the record's eighth field, the literal "(imag", so every moment was zero and
  # every one of 65536 cells was refused as non-positive -- a unanimous refusal is the shape of a dead instrument (law 2), not of a truncation):
  # the normalised (0,0) moment must read exactly 1 before any grid is built
  if (abs(M[0, 0] - 1) > 1e-9) { printf "W2-MODES REFUSED: the (0,0) moment reads %s, not 1 -- a misread record, not a density\n", M[0, 0]; exit 2 }
  for ((a = 0); a <= L; a++) for (c = 0; c <= L; c++) if (!((a, c) in M)) { print "W2-MODES REFUSED: the table lacks (" a ", " c ")"; exit 2 }
  PI = 3.141592653589793; neg = 0; supd = 0; supr = 0
  for (i = 1; i <= N; i++) { th[i] = i * PI / (N + 1); w[i] = 2 / (N + 1) * sin(th[i]) * sin(th[i]); for (a = 0; a <= L2; a++) X[i, a] = chi(a, th[i]) }
  for (i = 1; i <= N; i++) { WA[i] = 0; WB[i] = 0; for (a = 0; a <= L; a++) { WA[i] += M[a, 0] * X[i, a]; WB[i] += M[0, a] * X[i, a] } }
  for (i = 1; i <= N; i++) for (j = 1; j <= N; j++) { s = 0; for (a = 0; a <= L; a++) for (c = 0; c <= L; c++) s += M[a, c] * X[i, a] * X[j, c]
    if (s <= 0 || WA[i] <= 0 || WB[j] <= 0) { neg++; continue }
    R[i, j] = s / (WA[i] * WB[j]); D[i, j] = log(R[i, j]); if (abs(D[i, j]) > supd) supd = abs(D[i, j]); if (abs(R[i, j] - 1) > supr) supr = abs(R[i, j] - 1) }
  if (neg) { printf "W2-MODES REFUSED: the truncated density is not positive at %d of %d grid cells (L=%d): the log is not readable at this L\n", neg, N * N, L; exit 2 }
  printf "W2-MODES L=%d N=%d: sup|delta_2| = %.6e, sup|e^delta_2 - 1| = %.6e on the grid; %s\n", L, N, supd, supr, hdr
  rmod = 0; rcreate = 0; shalf = 0; sone = 0; shigh = 0; if (!NPAIR) NPAIR = 16
  for (a = 0; a <= L2; a++) for (c = 0; c <= L2; c++) { b = 0; d = 0; for (i = 1; i <= N; i++) for (j = 1; j <= N; j++) { f = w[i] * w[j] * X[i, a] * X[j, c]; b += f * (R[i, j] - 1); d += f * D[i, j] }
    unit = 1; if (a > 0) unit *= (a <= L ? M[a, 0] : 0); if (c > 0) unit *= (c <= L ? M[0, c] : 0)
    kind = (a == 0 && c == 0) ? "constant" : ((a == 0 || a == 2) && (c == 0 || c == 2)) ? "modifying" : "creating"
    if (a + c > 0) { if (kind == "modifying") rmod += abs(b); if (unit > 0) rcreate += abs(b) / unit; else if (abs(b) > 1e-12) nounit++
      # the creating shares (RESULTS 4 (b)(iii)): a mode creates flux on the plaquettes where its spin is nonzero and not a modifying spin-1;
      # with n such plaquettes the share per created plaquette is |bhat|^{1/n}, assigned by the spin created
      ncr = 0; if (a > 0 && a != 2) ncr++; if (c > 0 && c != 2) ncr++; if (a == 2 && (c > 0 && c != 2)) ncr++; if (c == 2 && (a > 0 && a != 2)) ncr++
      if (ncr > 0) { sh = exp(log(abs(b) + 1e-300) / ncr); if (a == 1 || c == 1) shalf += sh; if ((a == 2 && c > 0 && c != 2) || (c == 2 && a > 0 && a != 2)) sone += sh; if (a >= 3 || c >= 3) shigh += sh } }
    printf "W2-MODE a=%d c=%d bhat(e^delta-1)=%+.9e delta-mode=%+.9e unit=%.6e ratio=%s kind=%s\n", a, c, b, d, unit, (unit > 0 ? sprintf("%+.6e", b / unit) : "NO-UNIT"), kind }
  alpha = 0.001; crel = 20 * rcreate * exp(7 * alpha); cmod = 20 * rmod * exp(7 * alpha)
  printf "W2-CONTENT L=%d: r_mod = %.6e (c_rel,mod = 20 r e^{7 alpha} = %.6e); r_create = %.6e (c_rel,create = %.6e)%s; sup|delta_2| = %.6e\n", L, rmod, cmod, rcreate, crel, (nounit ? sprintf("; %d modes past L with no unit read", nounit) : ""), supd
  # THE CERTIFICATE'S INPUTS (RESULTS 4 (b)-(c)): a'_j = E[chi_j]/d_j over 10^12; the half factor 1 + NPAIR r_mod; the wall floor a'_1 + NPAIR s_one / 3
  coef = ""; for (j2 = 1; j2 <= 16; j2++) { ap = (j2 <= L) ? M[j2, 0] / (j2 + 1) : 0; an = int(ap * 1e12 + 0.5); printf "W2-COEF j2=%d aprime=%.12e rational=%d/1000000000000\n", j2, ap, an; coef = coef (j2 > 1 ? "," : "") an "/1000000000000" }
  hf = 1 + NPAIR * rmod; hn = int(hf * 1e12 + 0.5); wall = (L >= 2 ? M[2, 0] / 3 : 0) + NPAIR * sone / 3; wn = int(wall * 1e12 + 0.5)
  printf "W2-SHARES NPAIR=%d: s_half = %.6e s_one = %.6e s_high = %.6e per pair; half factor 1 + NPAIR r_mod = %.9f; wall floor a'_1 + NPAIR s_one/3 = %.9e\n", NPAIR, shalf, sone, shigh, hf, wall
  printf "W2-CERT-CALL COEF=%s HALFN=%d HALFD=1000000000000 WALLN=%d WALLD=1000000000000\n", coef, hn, wn }
