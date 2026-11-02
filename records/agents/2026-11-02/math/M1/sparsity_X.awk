# sparsity_X.awk: the 149_LOG counterexample X = boundary of 13 unit cubes in one 3-space, checked by machine.
# A plaquette is (lower corner x,y,z ; normal n), spanned by the two directions other than n. A link is (lower corner ; dir).
function key3(x, y, z) { return x "," y "," z }
function addface(x, y, z, n) { F[key3(x,y,z) ";" n] = (F[key3(x,y,z) ";" n] + 1) % 2 }
BEGIN {
  nb = split("0,0,0 0,-1,-1 -1,0,-1 -1,-1,0 1,0,0 1,0,-1 1,-1,-1 0,1,0 0,1,-1 -1,1,-1 0,0,1 0,-1,1 -1,-1,1", C, " ")
  for (i = 1; i <= nb; i++) { split(C[i], c, ","); x = c[1]; y = c[2]; z = c[3]; inB[key3(x,y,z)] = 1
    addface(x, y, z, 1); addface(x + 1, y, z, 1); addface(x, y, z, 2); addface(x, y + 1, z, 2); addface(x, y, z, 3); addface(x, y, z + 1, 3) }
  if (length(inB) != 13) { print "DUPLICATE CUBE"; exit 1 }
  # face adjacencies inside B
  adj = 0; for (k in inB) { split(k, c, ","); if (key3(c[1]+1,c[2],c[3]) in inB) adj++; if (key3(c[1],c[2]+1,c[3]) in inB) adj++; if (key3(c[1],c[2],c[3]+1) in inB) adj++ }
  nX = 0
  for (f in F) if (F[f] == 1) { nX++; P[nX] = f }
  printf "SPARSITY-X cubes=%d face-adjacencies=%d F=|X|=%d (6*13 - 2*adj = %d)\n", nb, adj, nX, 78 - 2 * adj
  # links and vertices of X; plaquettes at v = 0
  atv = 0
  for (i = 1; i <= nX; i++) {
    split(P[i], pn, ";"); split(pn[1], c, ","); n = pn[2] + 0; x = c[1]; y = c[2]; z = c[3]
    # the two spanning directions
    if (n == 1) { a = 2; b = 3 } else if (n == 2) { a = 1; b = 3 } else { a = 1; b = 2 }
    d[1] = 0; d[2] = 0; d[3] = 0; e[1] = 0; e[2] = 0; e[3] = 0; d[a] = 1; e[b] = 1
    # corners
    cx[1] = x; cy[1] = y; cz[1] = z
    cx[2] = x + d[1]; cy[2] = y + d[2]; cz[2] = z + d[3]
    cx[3] = x + e[1]; cy[3] = y + e[2]; cz[3] = z + e[3]
    cx[4] = x + d[1] + e[1]; cy[4] = y + d[2] + e[2]; cz[4] = z + d[3] + e[3]
    for (k = 1; k <= 4; k++) { VX[key3(cx[k], cy[k], cz[k])] = 1; if (cx[k] == 0 && cy[k] == 0 && cz[k] == 0) atv++ }
    # links: (corner1, dir a), (corner1, dir b), (corner2, dir b), (corner3, dir a)
    L1 = key3(cx[1],cy[1],cz[1]) ";" a; L2 = key3(cx[1],cy[1],cz[1]) ";" b; L3 = key3(cx[2],cy[2],cz[2]) ";" b; L4 = key3(cx[3],cy[3],cz[3]) ";" a
    M[L1]++; M[L2]++; M[L3]++; M[L4]++
    PL[i,1] = L1; PL[i,2] = L2; PL[i,3] = L3; PL[i,4] = L4
  }
  nL = 0; odd = 0; four = 0; six = 0; fourlist = ""
  for (l in M) { nL++; LI[l] = nL; if (M[l] % 2) odd++; if (M[l] == 4) { four++; fourlist = fourlist " [" l "]" }; if (M[l] == 6) six++ }
  nV = length(VX)
  printf "SPARSITY-X V=%d E(links)=%d chi=%d odd-links=%d four-fold=%d six-fold=%d plaquettes-at-v=%d\n", nV, nL, nV - nL + nX, odd, four, six, atv
  printf "SPARSITY-X four-fold links:%s\n", fourlist
  # F2 nullity of the link x plaquette incidence matrix: rank of the 54 boundary vectors
  for (i = 1; i <= nX; i++) { for (j = 1; j <= nL; j++) Mx[i,j] = 0; for (k = 1; k <= 4; k++) Mx[i, LI[PL[i,k]]] = (Mx[i, LI[PL[i,k]]] + 1) % 2 }
  rank = 0; row = 1
  for (j = 1; j <= nL && row <= nX; j++) {
    piv = 0; for (i = row; i <= nX; i++) if (Mx[i,j]) { piv = i; break }
    if (!piv) continue
    if (piv != row) for (t = 1; t <= nL; t++) { tmp = Mx[row,t]; Mx[row,t] = Mx[piv,t]; Mx[piv,t] = tmp }
    for (i = 1; i <= nX; i++) if (i != row && Mx[i,j]) for (t = 1; t <= nL; t++) Mx[i,t] = (Mx[i,t] + Mx[row,t]) % 2
    rank++; row++
  }
  printf "SPARSITY-X F2 rank of the boundary vectors=%d nullity=%d (Z2-minimal iff nullity 1)\n", rank, nX - rank
  # contact graph: the four-fold links' endpoints
  printf "SPARSITY-X contact graph: %d links; a star K_1,%d at v iff every four-fold link has v as an endpoint\n", four, four
}
