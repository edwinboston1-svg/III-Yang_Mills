# w2_orbits.awk -- THE OUTSIDE LINKS' SYMMETRY ORBITS, VERIFIED ON A LANDED LADDER (2026-11-01 11:4x; the author).  The bent two-face
# object (face A in the xy-plane, face B in the yz-plane, the shared edge x = z = 0, y in [0, n], the object in t = 0) is carried into
# itself by three involutions of the lattice: Y the reflection y -> n - y; X the exchange x <-> z (faces A and B exchanged); T the
# reflection t -> -t.  At a datum carried into itself by an involution (the ordered datum by all three), the Haar measure, the plaquette
# weights and the loop's character being invariant, the influence of a link and of its image are EQUAL, so a ladder needs one reading per
# orbit, times the orbit's size.  This reader takes a landed ladder (W2-TV lines with the W2-ROT coordinates), tests each involution on the
# record -- every link's |dE1| against its image's to the digit -- keeps the involutions the record supports, forms the orbits under the
# group they generate, prints them (representative, size, members) and the row sum by orbits against the row sum by links.
# A link is (x, y, z, t, dir) with its base site and direction; a dir-d link reflected along d maps base b -> -b - 1 (or n - b - 1 for Y).
# usage: gawk -v n=2|4 -f w2_orbits.awk <ladder record>
function abs(x) { return x < 0 ? -x : x }
function key(x, y, z, t, d) { return x "," y "," z "," t "," d }
function Y(k,   a) { split(k, a, ","); if (a[5] == 2) a[2] = n - a[2] - 1; else a[2] = n - a[2]; return key(a[1], a[2], a[3], a[4], a[5]) }
function X(k,   a, tmp) { split(k, a, ","); tmp = a[1]; a[1] = a[3]; a[3] = tmp; if (a[5] == 1) a[5] = 3; else if (a[5] == 3) a[5] = 1; return key(a[1], a[2], a[3], a[4], a[5]) }
function T(k,   a) { split(k, a, ","); if (a[5] == 4) a[4] = -a[4] - 1; else a[4] = -a[4]; return key(a[1], a[2], a[3], a[4], a[5]) }
function find(k) { while (par[k] != k) k = par[k]; return k }
function unite(a, b,   ra, rb) { ra = find(a); rb = find(b); if (ra != rb) par[ra] = rb }
/^W2-TV/ { match($0, /dE\[chi_1\(A\)\] = ([-+0-9.e]+)/, m); match($0, /W2-ROT link ([0-9]+) \(([-0-9]+),([-0-9]+),([-0-9]+),([-0-9]+) dir ([0-9])\)/, c)
  k = key(c[2], c[3], c[4], c[5], c[6]); inf[k] = abs(m[1] + 0); idx[k] = c[1]; keys[++N] = k }
END {
  if (!N) { print "W2-ORBITS REFUSED: no W2-TV lines"; exit 2 }
  gen["Y"] = 1; gen["X"] = 1; gen["T"] = 1
  for (g in gen) { bad = 0; miss = 0; for (i = 1; i <= N; i++) { k = keys[i]; j = (g == "Y") ? Y(k) : (g == "X") ? X(k) : T(k); if (!(j in inf)) { miss++; continue } if (abs(inf[k] - inf[j]) > 1e-12 * (1 + inf[k])) bad++ }
    printf "W2-ORBITS involution %s: %d links, images missing %d, influences parted %d -> %s\n", g, N, miss, bad, (miss || bad) ? "NOT a symmetry of this record" : "a symmetry (every link reads its image's influence to 1e-12)"
    if (miss || bad) delete gen[g] }
  for (i = 1; i <= N; i++) par[keys[i]] = keys[i]
  for (i = 1; i <= N; i++) { k = keys[i]; for (g in gen) { j = (g == "Y") ? Y(k) : (g == "X") ? X(k) : T(k); unite(k, j) } }
  for (i = 1; i <= N; i++) { r = find(keys[i]); size[r]++; mem[r] = mem[r] " " idx[keys[i]]; if (!(r in rep) || idx[keys[i]] + 0 < rep[r] + 0) rep[r] = idx[keys[i]] }
  no = 0; rowl = 0; rowo = 0; for (i = 1; i <= N; i++) rowl += inf[keys[i]] / 2
  for (r in size) { no++; rowo += size[r] * inf[r] / 2 }
  printf "W2-ORBITS n=%d: %d links in %d orbits under the symmetries kept (%s); row sum by links %.9e, by orbits %.9e (|dE1|/2 each)\n", n, N, no, (("Y" in gen) ? "Y" : "") (("X" in gen) ? "X" : "") (("T" in gen) ? "T" : ""), rowl, rowo
  for (r in size) printf "W2-ORBIT rep=%s size=%d influence=%.6e members:%s\n", rep[r], size[r], inf[r] / 2, mem[r] }
