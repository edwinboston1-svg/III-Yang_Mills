# photon_l3.awk -- THE L = 3 BLOCK-AVERAGED BACKGROUND OF THE FREE PHOTON (gawk; the functions are photon_gauss.awk's, verbatim, appended below).
# The flux of the n x n square (the boundary current of the n x n square in the (0,1) plane) against the 4D lattice Green function:
# Var_n = <J_n, G J_n> per unit beta.  Known answers: n = 1 -> 0.5 (equipartition), n = 2 -> 1.369312 (tooth 1's record b, line 8).
# The reading: n = 3 (one L = 3 step) and n = 6 (two L = 3 steps) -- the coarse plaquette's flux variance, and per fine plaquette /n^2.
# usage: gawk -f photon_l3.awk  (the file carries its own BEGIN; photon_gauss.awk's BEGIN is not included)
BEGIN {
  PI = atan2(0, -1); T = 400; NS = 8000; NMAX = 70
  printf "PHOTON-L3(awk) T=%g NS=%d\n", T, NS
  nn = split("1 2 3 6", NN, " ")
  for (i = 1; i <= nn; i++) { n = NN[i] + 0; name = "H" n
    square_current(n, 0, 0, 0, 0, 1.0, name); v = pair(name, name); c = closed(name)
    printf "  n = %d: Var(flux of the n x n square) = %.9f per unit beta;  per fine plaquette (Var/n^4) = %.9f;  rms at beta = 2.2: coarse %.6f, per fine plaquette %.6f;  closed %.1e\n", n, v, v / (n^4), sqrt(v / 2.2), sqrt(v / (n^4) / 2.2), c
    fflush()
  }
  print "KNOWN ANSWERS: n = 1 -> 0.5; n = 2 -> 1.369312 (record b line 8)"
  exit 0
}
function bessel_scaled(z,   n, start, ip1, i0, k, im1, nrm) {
  if (z < 1e-12) { for (n = 0; n <= NMAX; n++) BI[n] = (n == 0) ? 1 : 0; return }
  start = NMAX + 40 + int(3 * sqrt(z) + z / 3)
  ip1 = 0; i0 = 1e-300
  for (k = start; k >= 1; k--) { im1 = ip1 + (2 * k / z) * i0; RR[k - 1] = im1; ip1 = i0; i0 = im1
    if (i0 > 1e200) { ip1 /= 1e200; i0 /= 1e200; for (n = k - 1; n <= start; n++) RR[n] /= 1e200 } }
  nrm = RR[0]; for (n = 1; n <= start; n++) nrm += 2 * RR[n]
  for (n = 0; n <= NMAX; n++) BI[n] = RR[n] / nrm
}
# G(x): the 4D lattice Green function, cached by the sorted absolute offsets
function G4(a, b, c, d,   key, s, i, j, t, h, sum, w, n0, n1, n2, n3, f, cc, tail, cnt, TB, N1, N2, s2) {
  a = (a < 0) ? -a : a; b = (b < 0) ? -b : b; c = (c < 0) ? -c : c; d = (d < 0) ? -d : d
  key = sort4(a, b, c, d)
  if (key in GC) return GC[key]
  split(key, Q, ","); n0 = Q[1]; n1 = Q[2]; n2 = Q[3]; n3 = Q[4]
  if (n3 > NMAX) { printf "REFUSED: offset %s beyond NMAX %d\n", key, NMAX; exit 2 }
  # two Simpson panels: [0, TB] fine (the e^{-8t} boundary layer), [TB, T] coarse; both with even counts
  TB = 4; N1 = 16000; N2 = NS; sum = 0
  h = TB / N1
  for (i = 0; i <= N1; i++) { t = i * h; bessel_scaled(2 * t); f = BI[n0] * BI[n1] * BI[n2] * BI[n3]; w = (i == 0 || i == N1) ? 1 : ((i % 2) ? 4 : 2); sum += w * f }
  sum *= h / 3
  h = (T - TB) / N2; s2 = 0
  for (i = 0; i <= N2; i++) { t = TB + i * h; bessel_scaled(2 * t); f = BI[n0] * BI[n1] * BI[n2] * BI[n3]; w = (i == 0 || i == N2) ? 1 : ((i % 2) ? 4 : 2); s2 += w * f }
  sum += s2 * h / 3
  cc = (4 * n0 * n0 - 1 + 4 * n1 * n1 - 1 + 4 * n2 * n2 - 1 + 4 * n3 * n3 - 1) / 16    # prod I_n(2t) e^{-2t} ~ (4 pi t)^-2 (1 - cc/t + ...)
  tail = (1 / (16 * PI * PI)) * (1 / T - cc / (2 * T * T))
  GC[key] = sum + tail
  return GC[key]
}
function sort4(a, b, c, d,   v, i, j, tmp) { v[1] = a; v[2] = b; v[3] = c; v[4] = d
  for (i = 1; i <= 4; i++) for (j = i + 1; j <= 4; j++) if (v[j] < v[i]) { tmp = v[i]; v[i] = v[j]; v[j] = tmp }
  return v[1] "," v[2] "," v[3] "," v[4] }

# ---------------------------------------------------------------- currents: C[name, x0,x1,x2,x3, mu] = weight (a link from x in direction mu)
function step(name, x0, x1, x2, x3, mu, sgn, w,   k) {   # walk one link from x in direction sgn*mu with weight w; updates X0..X3 to the new site
  if (sgn > 0) { k = name SUBSEP x0 SUBSEP x1 SUBSEP x2 SUBSEP x3 SUBSEP mu; CUR[k] += w; CN[name] = 1
    X0 = x0 + (mu == 0); X1 = x1 + (mu == 1); X2 = x2 + (mu == 2); X3 = x3 + (mu == 3) }
  else { X0 = x0 - (mu == 0); X1 = x1 - (mu == 1); X2 = x2 - (mu == 2); X3 = x3 - (mu == 3)
    k = name SUBSEP X0 SUBSEP X1 SUBSEP X2 SUBSEP X3 SUBSEP mu; CUR[k] -= w; CN[name] = 1 }
}
function clear_current(name,   k, parts) { for (k in CUR) { split(k, parts, SUBSEP); if (parts[1] == name) delete CUR[k] } }
function square_current(n, x0, x1, x2, x3, w, name,   i) {   # the boundary of the n x n square at x in the (0,1) plane
  clear_current(name); X0 = x0; X1 = x1; X2 = x2; X3 = x3
  for (i = 0; i < n; i++) step(name, X0, X1, X2, X3, 0, +1, w)
  for (i = 0; i < n; i++) step(name, X0, X1, X2, X3, 1, +1, w)
  for (i = 0; i < n; i++) step(name, X0, X1, X2, X3, 0, -1, w)
  for (i = 0; i < n; i++) step(name, X0, X1, X2, X3, 1, -1, w)
}
# the per-direction-tree averaged coarse link from X0 to X0 + L e_mu: the average over the L^3 transverse offsets y of the staircase
# X0 -> X0+y -> X0+y+L e_mu -> X0 + L e_mu (transverse legs in a fixed order out and back) -- 28.1's map, not THE GROUND's
function avg_link(name, x0, x1, x2, x3, mu, L, w,   tr, ntr, y1, y2, y3, ww, d, k, i, YY) {
  ntr = 0; for (d = 0; d < 4; d++) if (d != mu) tr[++ntr] = d
  for (y1 = 0; y1 < L; y1++) for (y2 = 0; y2 < L; y2++) for (y3 = 0; y3 < L; y3++) {
    YY[1] = y1; YY[2] = y2; YY[3] = y3; ww = w / (L * L * L); X0 = x0; X1 = x1; X2 = x2; X3 = x3
    for (d = 1; d <= 3; d++) for (k = 0; k < YY[d]; k++) step(name, X0, X1, X2, X3, tr[d], +1, ww)
    for (i = 0; i < L; i++) step(name, X0, X1, X2, X3, mu, +1, ww)
    for (d = 1; d <= 3; d++) for (k = 0; k < YY[d]; k++) step(name, X0, X1, X2, X3, tr[d], -1, ww)
  }
}
function avg_plaquette(L, x0, x1, x2, x3, w, name) {   # A -> B (mu=0) -> C (nu=1) -> D -> A
  clear_current(name)
  avg_link(name, x0, x1, x2, x3, 0, L, w)             # A -> B
  avg_link(name, x0 + L, x1, x2, x3, 1, L, w)         # B -> C
  avg_link(name, x0, x1 + L, x2, x3, 0, L, -w)        # D -> C reversed
  avg_link(name, x0, x1, x2, x3, 1, L, -w)            # A -> D reversed
}
function closed(name,   k, parts, x0, x1, x2, x3, mu, c, mx, s) {   # the divergence must vanish at every site
  delete DIV
  for (k in CUR) { split(k, parts, SUBSEP); if (parts[1] != name) continue; c = CUR[k]; if (c == 0) continue
    x0 = parts[2]; x1 = parts[3]; x2 = parts[4]; x3 = parts[5]; mu = parts[6]
    DIV[x0 "," x1 "," x2 "," x3] -= c
    DIV[(x0 + (mu == 0)) "," (x1 + (mu == 1)) "," (x2 + (mu == 2)) "," (x3 + (mu == 3))] += c }
  mx = 0; for (s in DIV) { c = DIV[s]; if (c < 0) c = -c; if (c > mx) mx = c }
  return mx
}
function pair(n1, n2,   k1, k2, p1, p2, s, c1, c2) {   # <J1, G J2> = sum over links of the same direction of c1 c2 G(x1 - x2)
  s = 0
  for (k1 in CUR) { split(k1, p1, SUBSEP); if (p1[1] != n1) continue; c1 = CUR[k1]; if (c1 == 0) continue
    for (k2 in CUR) { split(k2, p2, SUBSEP); if (p2[1] != n2) continue; if (p2[6] != p1[6]) continue; c2 = CUR[k2]; if (c2 == 0) continue
      s += c1 * c2 * G4(p1[2] - p2[2], p1[3] - p2[3], p1[4] - p2[4], p1[5] - p2[5]) } }
  return s
}
