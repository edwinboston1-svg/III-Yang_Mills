# kappa_canon.awk -- 047_R's absorption constant recomputed from the exact even-star table: for each orbit, w = sum over half-axes of (deg-2)/2
# = |E| - (half-axes used), c = components of the star (from the mask, EDGES order of even_stars.py, bit 0 the rightmost character),
# rho_hat^2 = e2 / 2^(w + 2c - 2) (exact rational e2), kappa_row = max(1, rho_hat^2)^(2/|E|); kappa = max over the 560 rows.
# Also the dials: rows without a degree-6 half-axis; and the page's own rho column for comparison.
function find(x) { while (par[x] != x) x = par[x]; return x }
BEGIN { n = 0; for (i = 0; i < 8; i++) for (j = i + 1; j < 8; j++) if (int(i / 2) != int(j / 2)) { EA[n] = i; EB[n] = j; n++ } }
/^mask=/ { m = substr($1, 6); E = substr($2, 3) + 0; dg = substr($3, 5); split(substr($6, 4), r, "/"); e2n = r[1]; e2d = (r[2] == "" ? 1 : r[2])
  if (E == 0) next
  for (v = 0; v < 8; v++) par[v] = v
  for (b = 0; b < 24; b++) if (substr(m, 24 - b, 1) == "1") { x = find(EA[b]); y = find(EB[b]); if (x != y) par[x] = y }
  nv = 0; has6 = 0; for (v = 0; v < 8; v++) { d = substr(dg, v + 1, 1) + 0; if (d > 0) nv++; if (d >= 6) has6 = 1 }
  c = 0; for (v = 0; v < 8; v++) { d = substr(dg, v + 1, 1) + 0; if (d > 0 && find(v) == v) c++ }
  w = E - nv; den = 2 ^ (w + 2 * c - 2); rh2 = (e2n / e2d) / den
  k = (rh2 > 1) ? rh2 ^ (2 / E) : 1
  if (k > kmax) { kmax = k; arg = $0; kw = w; kc = c; kE = E; krh = sqrt(rh2) }
  if (!has6 && k > k6) { k6 = k; arg6 = $0 }
  rows++ }
END { printf "KAPPA rows=%d  kappa = max_orbit max(1, rho_hat)^(4/|E|) = %.9f at |E|=%d w=%d c=%d rho_hat=%.6f\n  %s\n", rows, kmax, kE, kw, kc, krh, substr(arg, 1, 120)
  printf "KAPPA without a degree-6 half-axis: %.9f\n  %s\n", k6, substr(arg6, 1, 120) }
