# w2_u1_modes.awk -- THE PAIR COUPLING'S MODES FOR U(1), from w2_u1's moments (THE CROSSING CAMPAIGN W2, the abelian column; 2026-11-01,
# the author).  Reads the `U1-CLASS a=<a> c=<c> E[...] = <re> <im> i` lines (a in [-L, L], c in [0, L]; the rest by conjugation), builds the
# joint density of the two loop angles on an N x N grid, W(x, y) = sum_{a,c} M(a,c) e^{-i(a x + c y)} (E[e^{i a Phi}] = int W e^{i a Phi}), the
# marginals, the ratio R = W / (W_A W_B) = e^{delta_2}, and the modes of R - 1 and of delta_2 by the grid's own Fourier sum (exact for the
# truncated density, the grid being a multiple of the modes' period).  THE DEAD-TABLE CONTROL: the (0,0) moment must read 1.  REFUSES by name
# when the truncated density is not positive on the grid.  The modes are reported with the creating unit |E[e^{i a Phi_A}]| |E[e^{i c Phi_B}]| as
# the SU(2) twin does; for U(1) every nonzero mode is a creating one (there is no spin to modify), so r_create alone is the content's reading.
# usage: gawk -v N=256 -v L2=4 -f w2_u1_modes.awk <record>
function abs(x) { return x < 0 ? -x : x }
/^U1-CLASS a=/ { a = substr($2, 3) + 0; c = substr($3, 3) + 0; re = $9 + 0; im = $10 + 0; MR[a, c] = re; MI[a, c] = im; MR[-a, -c] = re; MI[-a, -c] = -im; if (abs(a) > L) L = abs(a); if (c > L) L = c; nread++ }
/^U1-OBJECT/ { hdr = $0 }
END {
  if (!N) N = 256; if (!L2) L2 = L; if (!nread) { print "U1-MODES REFUSED: no U1-CLASS lines"; exit 2 }
  if (abs(MR[0, 0] - 1) > 1e-9 || abs(MI[0, 0]) > 1e-9) { printf "U1-MODES REFUSED: the (0,0) moment reads %s %s i, not 1 -- a misread record\n", MR[0, 0], MI[0, 0]; exit 2 }
  PI = 3.141592653589793; neg = 0; supd = 0; supr = 0
  for (i = 0; i < N; i++) { x = 2 * PI * i / N; WA[i] = 0; WB[i] = 0
    for (a = -L; a <= L; a++) { WA[i] += MR[a, 0] * cos(a * x) + MI[a, 0] * sin(a * x); WB[i] += MR[0, a] * cos(a * x) + MI[0, a] * sin(a * x) } }
  for (i = 0; i < N; i++) for (j = 0; j < N; j++) { x = 2 * PI * i / N; y = 2 * PI * j / N; s = 0
    for (a = -L; a <= L; a++) for (c = -L; c <= L; c++) { ph = a * x + c * y; s += MR[a, c] * cos(ph) + MI[a, c] * sin(ph) }
    if (s <= 0 || WA[i] <= 0 || WB[j] <= 0) { neg++; continue }
    R[i, j] = s / (WA[i] * WB[j]); D[i, j] = log(R[i, j]); if (abs(D[i, j]) > supd) supd = abs(D[i, j]); if (abs(R[i, j] - 1) > supr) supr = abs(R[i, j] - 1) }
  if (neg) { printf "U1-MODES REFUSED: the truncated density is not positive at %d of %d grid cells (L=%d)\n", neg, N * N, L; exit 2 }
  printf "U1-MODES L=%d N=%d: sup|delta_2| = %.6e, sup|e^delta_2 - 1| = %.6e on the grid; %s\n", L, N, supd, supr, hdr
  rcreate = 0
  for (a = -L2; a <= L2; a++) for (c = -L2; c <= L2; c++) { br = 0; bi = 0; dr = 0; di = 0
    for (i = 0; i < N; i++) for (j = 0; j < N; j++) { ph = a * 2 * PI * i / N + c * 2 * PI * j / N; cs = cos(ph); sn = sin(ph); br += (R[i, j] - 1) * cs; bi += (R[i, j] - 1) * sn; dr += D[i, j] * cs; di += D[i, j] * sn }
    br /= N * N; bi /= N * N; dr /= N * N; di /= N * N; mb = sqrt(br * br + bi * bi)
    ua = sqrt(MR[a, 0] ^ 2 + MI[a, 0] ^ 2); uc = sqrt(MR[0, c] ^ 2 + MI[0, c] ^ 2); unit = (a == 0 ? 1 : ua) * (c == 0 ? 1 : uc)
    if (a != 0 || c != 0) { if (unit > 0) rcreate += mb / unit; else if (mb > 1e-12) nounit++ }
    printf "U1-MODE a=%d c=%d |bhat(e^delta-1)|=%.9e (%+.6e %+.6e i) delta-mode=(%+.6e %+.6e i) unit=%.6e ratio=%s\n", a, c, mb, br, bi, dr, di, unit, (unit > 0 ? sprintf("%.6e", mb / unit) : "NO-UNIT") }
  printf "U1-CONTENT L=%d: r_create = %.6e%s; sup|delta_2| = %.6e; |E[e^{i Phi_A}]| = %.6e\n", L, rcreate, (nounit ? sprintf("; %d modes with no unit", nounit) : ""), supd, sqrt(MR[1, 0] ^ 2 + MI[1, 0] ^ 2) }
