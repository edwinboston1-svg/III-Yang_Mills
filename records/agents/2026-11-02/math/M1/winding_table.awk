# winding_table.awk -- route (3)'s unicyclic bound re-derived exhaustively (M1, 2026-11-02; WORK.md section 5).
# A unicyclic contact graph with chord x of multiplicity MU: by the record's CORRECTION (7) every piece is odd on the cycle,
# m <= 2, every rim word is U^w.  For m = 2 with k charged rims (w != 0) the cut formula gives |S| <= 2^(4-k) |J|,
# J = int prod_i chi_1/2(U^{w_i}) dU, subject to: sum_i |w_i| <= MU and even (total traversals MU, a rim's |w| <= its
# traversals, same parity); each of the two pieces holds >= 1 charged rim and an ODD sum of |w| (the piece is odd on the
# cycle; uncharged rims carry w = 0, even).  chi_1/2(U^w) = chi_{w/2} - chi_{w/2-1} (Chebyshev), exact integer arithmetic
# on virtual characters in units j2 = 2j; J = the multiplicity of the trivial representation.  For m = 1: |S| <= 4 (S11).
# Output: every admissible (partition into two pieces) with its bound; the maximum.  Usage: gawk -v MU=6 -f winding_table.awk
function cg_mul(A, B, C,   a, b, c) { delete C; for (a in A) for (b in B) { if (A[a] == 0 || B[b] == 0) continue
    for (c = (a > b ? a - b : b - a); c <= a + b; c += 2) C[c] += A[a] * B[b] } }
function chiw(w, R) { delete R; R[w] = 1; if (w >= 2) R[w - 2] = -1 }   # chi_1/2(U^w), w >= 1, in j2 units
function J_of(ws, n,   i, T, U, V, k) { delete T; T[0] = 1
  for (i = 1; i <= n; i++) { chiw(ws[i], U); cg_mul(T, U, V); delete T; for (k in V) T[k] = V[k] }
  return (0 in T) ? T[0] : 0 }
function rec(pos, rem, minw,   w) { if (pos > 1) { NW = pos - 1; try_split() }
  for (w = minw; w <= rem; w++) { WS[pos] = w; rec(pos + 1, rem - w, w) } }
# every way to give the NW charged windings to two pieces, each piece nonempty with odd sum
function try_split(   mask, i, s1, s2, n1, n2, tot, J, b, key) {
  tot = 0; for (i = 1; i <= NW; i++) tot += WS[i]; if (tot % 2) return
  for (i = 1; i <= NW; i++) LW[i] = WS[i]
  J = J_of(LW, NW); b = 2 ^ (4 - NW) * (J < 0 ? -J : J)
  for (mask = 1; mask < 2 ^ NW - 1; mask++) { s1 = 0; s2 = 0; n1 = 0; n2 = 0
    for (i = 1; i <= NW; i++) if (int(mask / 2 ^ (i - 1)) % 2) { s1 += WS[i]; n1++ } else { s2 += WS[i]; n2++ }
    if (s1 % 2 == 1 && s2 % 2 == 1) { key = ""; for (i = 1; i <= NW; i++) key = key (i > 1 ? "," : "") WS[i]
      if (!(key in SEEN)) { SEEN[key] = 1; printf "windings (%s) k=%d J=%d bound 2^(4-k)|J| = %s\n", key, NW, J, b; if (b > BEST) { BEST = b; BK = key } }
      return } } }
BEGIN { if (!MU) MU = 6; BEST = 0
  # KNOWN ANSWERS first (refused to run without them): int chi^2 = 1, int chi_1/2(U)chi_1/2(U^3) = -1, int chi_1/2(U^3)^2 = 2
  K1[1] = 1; K1[2] = 1; if (J_of(K1, 2) != 1) { print "KAT FAIL 1"; exit 3 }
  K2[1] = 1; K2[2] = 3; if (J_of(K2, 2) != -1) { print "KAT FAIL 2"; exit 3 }
  K3[1] = 3; K3[2] = 3; if (J_of(K3, 2) != 2) { print "KAT FAIL 3"; exit 3 }
  K4[1] = 1; K4[2] = 1; K4[3] = 1; K4[4] = 1; if (J_of(K4, 4) != 2) { print "KAT FAIL 4 (int chi^4 = 2, Catalan)"; exit 3 }
  print "WINDING KAT HELD: int chi^2 = 1, chi(U)chi(U^3) = -1, chi(U^3)^2 = 2, chi^4 = 2"
  rec(1, MU, 1)
  printf "MU=%d: the largest bound over admissible m = 2 winding systems is %s at (%s); m = 1 gives 4\n", MU, BEST, BK }
