# cei_specdiff.awk -- two cei_spectrum listings compared modulus by modulus in their own (descending) order: the greatest
# |l_k|_A - |l_k|_B over |l_1|_A, and the verdict in an infix-free alphabet -- HELD (below 1e-9), MOVED (above 1e-6),
# UNDECIDED between (campaign §32's control, 2026-11-03).  usage: gawk -f cei_specdiff.awk -v A=<name> -v B=<name> a.txt b.txt
FNR == 1 { f++ }
/^ +l_[0-9]+ +\|l\| = / { k = $1; sub(/^l_/, "", k); k += 0; v = $4 + 0; if (f == 1) { a[k] = v; na = (k > na ? k : na) } else { b[k] = v; nb = (k > nb ? k : nb) } }
END { if (na < 1 || nb < 1 || na != nb) { printf "CEI-SPECDIFF REFUSED: %d and %d moduli read\n", na, nb; exit 2 }
      d = 0; for (k = 1; k <= na; k++) { e = a[k] - b[k]; if (e < 0) e = -e; if (e > d) d = e } d /= a[1]
      verdict = (d < 1e-9) ? "HELD" : (d > 1e-6) ? "MOVED" : "UNDECIDED"
      printf "CEI-SPECDIFF %s vs %s: n = %d, max ||l_k|_A - |l_k|_B| / |l_1|_A = %.3e; |l_1| %.12e / %.12e; |l_2| %.12e / %.12e; |l_1|/|l_2| %.6f / %.6f; verdict %s\n", A, B, na, d, a[1], b[1], a[2], b[2], a[1] / a[2], b[1] / b[2], verdict }
