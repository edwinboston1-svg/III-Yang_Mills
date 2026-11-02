# cover_check.awk -- THE GROUND's perfect cover (proof of Theorem 8.7): coordinates mod 2; direction 1 when x2 = x3 = x4, 2 when x4 = x1 != x3,
# 3 when x2 = x1 != x4, 4 when x3 = x1 != x2.  Checks: the four conditions partition the 16 residues; on the tori of side 2 and 4 every plaquette
# contains exactly one cover link.  A planted control (direction 1 rule replaced by x2 = x3) must fail.
function dir(x1, x2, x3, x4,   a, b, c, d, n, r) { a = x1 % 2; b = x2 % 2; c = x3 % 2; d = x4 % 2; n = 0; r = 0
  if (b == c && c == d) { n++; r = 1 } if (d == a && a != c) { n++; r = 2 } if (b == a && a != d) { n++; r = 3 } if (c == a && a != b) { n++; r = 4 }
  if (PLANT && b == c && !(c == d)) { n = 1; r = 1 }
  if (n != 1) return -n; return r }
BEGIN { bad = 0; for (x1 = 0; x1 < 2; x1++) for (x2 = 0; x2 < 2; x2++) for (x3 = 0; x3 < 2; x3++) for (x4 = 0; x4 < 2; x4++) if (dir(x1, x2, x3, x4) < 0) bad++
  printf "COVER partition: %d residues of 16 not covered exactly once\n", bad
  for (L = 2; L <= 4; L += 2) { tot = 0; ok = 0
    for (x1 = 0; x1 < L; x1++) for (x2 = 0; x2 < L; x2++) for (x3 = 0; x3 < L; x3++) for (x4 = 0; x4 < L; x4++) for (mu = 1; mu <= 4; mu++) for (nu = mu + 1; nu <= 4; nu++) {
      split(x1 " " x2 " " x3 " " x4, X, " "); cnt = 0
      # links (x, mu), (x + mu, nu), (x + nu, mu), (x, nu)
      for (t = 1; t <= 4; t++) { for (i = 1; i <= 4; i++) Y[i] = X[i]; if (t == 1) { e = mu } else if (t == 2) { Y[mu] = (Y[mu] + 1) % L; e = nu } else if (t == 3) { Y[nu] = (Y[nu] + 1) % L; e = mu } else { e = nu }
        if (dir(Y[1], Y[2], Y[3], Y[4]) == e) cnt++ }
      tot++; if (cnt == 1) ok++ }
    printf "COVER torus side %d: %d plaquettes, %d with exactly one cover link%s\n", L, tot, ok, (PLANT ? " (PLANTED wrong rule)" : "") } }
