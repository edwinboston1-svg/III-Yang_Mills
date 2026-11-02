# sixfold_leaf.awk -- a Z2-minimal leaf with a six-fold link (item (2)(i) of the trunk's message): the Z2 boundary of a TREE of ten unit 3-cubes
# (A, B, C in three different 3-spaces sharing only the link l = [0,1] x 0 x 0 x 0; each continued by one cube toward x1 = -1; four cubes in the
# hyperplane x1 = -1 joining the three arms).  Checks: every link even; the link multiplicities; the F2 nullity of the plaquette-link incidence
# (nullity 1 with X even <=> Z2-minimal); the vertex stars at the six-fold links' ends.  A plaquette = base point + plane (a<b), a link = base + dir.
function key(x1, x2, x3, x4) { return x1 "," x2 "," x3 "," x4 }
function addcube(b1, b2, b3, b4, d1, d2, d3,   D, i, j, k, a, bb, P, s) { D[1] = d1; D[2] = d2; D[3] = d3
  for (i = 1; i <= 3; i++) for (j = i + 1; j <= 3; j++) { a = D[i]; bb = D[j]; k = 6 - i - j   # the third direction index in D
    for (s = 0; s <= 1; s++) { split(b1 " " b2 " " b3 " " b4, P, " "); P[D[k]] += s; pk = key(P[1], P[2], P[3], P[4]) ";" (a < bb ? a bb : bb a); X[pk] = !X[pk] } } }
BEGIN { addcube(0,0,0,0, 1,2,3); addcube(0,-1,0,0, 1,2,4); addcube(0,0,-1,-1, 1,3,4)
  addcube(-1,0,0,0, 1,2,3); addcube(-1,-1,0,0, 1,2,4); addcube(-1,0,-1,-1, 1,3,4)
  addcube(-1,0,0,0, 2,3,4); addcube(-1,-1,0,0, 2,3,4); addcube(-1,-1,0,-1, 2,3,4); addcube(-1,-1,-1,-1, 2,3,4)
  F = 0; for (p in X) if (X[p]) { F++; PL[F] = p }
  # links of each plaquette
  for (i = 1; i <= F; i++) { split(PL[i], u, ";"); split(u[1], c, ","); a = substr(u[2], 1, 1) + 0; b = substr(u[2], 2, 1) + 0
    for (t = 1; t <= 4; t++) { for (q = 1; q <= 4; q++) y[q] = c[q]
      if (t == 1) e = a; else if (t == 2) { y[a]++; e = b } else if (t == 3) { y[b]++; e = a } else e = b
      lk = key(y[1], y[2], y[3], y[4]) "/" e; M[lk]++; LI[i, t] = lk } }
  odd = 0; for (l in M) { hm[M[l]]++; if (M[l] % 2) odd++ }
  printf "SIXFOLD F=%d links=%d odd-multiplicity links=%d; multiplicity histogram:", F, length(M), odd; for (m = 1; m <= 6; m++) if (m in hm) printf " m%d=%d", m, hm[m]; printf "\n"
  for (l in M) if (M[l] == 6) printf "SIXFOLD six-fold link %s\n", l
  # F2 rank of the F x links incidence (rows = plaquettes), Gaussian elimination on bit strings
  nl = 0; for (l in M) { LIDX[l] = ++nl }
  for (i = 1; i <= F; i++) { row = ""; for (k = 1; k <= nl; k++) R[i, k] = 0; for (t = 1; t <= 4; t++) R[i, LIDX[LI[i, t]]] = 1 }
  rk = 0; for (col = 1; col <= nl && rk < F; col++) { piv = 0; for (i = rk + 1; i <= F; i++) if (R[i, col]) { piv = i; break } if (!piv) continue; rk++
    if (piv != rk) for (k = 1; k <= nl; k++) { tmp = R[piv, k]; R[piv, k] = R[rk, k]; R[rk, k] = tmp }
    for (i = 1; i <= F; i++) if (i != rk && R[i, col]) for (k = 1; k <= nl; k++) R[i, k] = (R[i, k] + R[rk, k]) % 2 }
  printf "SIXFOLD F2 rank %d of %d plaquettes: nullity %d (%s)\n", rk, F, F - rk, (F - rk == 1 && odd == 0) ? "EVEN AND Z2-MINIMAL" : "NOT minimal"
  # the star at the origin: half-axis degrees
  split("1 2 3 4", Q, " "); printf "SIXFOLD star at the origin, half-axis degrees:"; for (d = 1; d <= 4; d++) for (sg = -1; sg <= 1; sg += 2) { if (sg > 0) lk = key(0,0,0,0) "/" d; else { split("0 0 0 0", z, " "); z[d] = -1; lk = key(z[1], z[2], z[3], z[4]) "/" d } printf " %s%d:%d", (sg > 0 ? "+" : "-"), d, (lk in M ? M[lk] : 0) } printf "\n" }
