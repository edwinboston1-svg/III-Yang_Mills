# l1bound.awk -- the pair's L1-Haar activity bound from floor.sh's outputs: kappa(pair) = int |R - 1| dm <= sup |R - 1|
#   <= sum over computed modes (a, c) != (0, 0) of d_a d_c (|bhat_ac| + 2 s_ac),  d = a + 1 (|chi_a| <= d_a on SU(2)),
# s the jackknife error of each mode; printed beside the face sum (no 2s).  usage: gawk -f l1bound.awk floor_full.txt floor_jk.txt
function abs(x) { return x < 0 ? -x : x }
FILENAME ~ /floor_full/ && /^W2-MODE / { a = substr($2, 3) + 0; c = substr($3, 3) + 0; split($4, t, "="); B0[a, c] = t[2] + 0; if (a > L) L = a }
FILENAME ~ /floor_full/ && /^W2-MODES L=/ { HEAD = $0 }
FILENAME ~ /floor_jk/ && /W2-MODE / { k = substr($1, 3) + 0; if (k > NB) NB = k; a = substr($3, 3) + 0; c = substr($4, 3) + 0; split($5, t, "="); J[k, a, c] = t[2] + 0 }
END { face = 0; up = 0
  for (a = 0; a <= L; a++) for (c = 0; c <= L; c++) { if (a + c == 0) continue; s = 0; q = 0; for (k = 1; k <= NB; k++) { s += J[k, a, c]; q += J[k, a, c] ^ 2 }
    m = s / NB; v = (NB - 1) / NB * (q - NB * m * m); if (v < 0) v = 0; se = sqrt(v)
    face += (a + 1) * (c + 1) * abs(B0[a, c]); up += (a + 1) * (c + 1) * (abs(B0[a, c]) + 2 * se) }
  split(HEAD, h, ";"); printf "L1BOUND %s\n", h[1]
  printf "L1BOUND the pair's L1-Haar activity: int|R-1| dm <= sup|R-1| <= sum d_a d_c |bhat| = %.4e (face), %.4e (every mode at |bhat| + 2s; modes a, c <= %d, %d jackknife bins)\n", face, up, L, NB }
