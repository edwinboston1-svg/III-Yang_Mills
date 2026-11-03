# w2_ladder.awk -- THE MOMENT INFLUENCE LADDER read whole from one ladder record (the campaign's §9 instrument, the quantity named exactly
# 07:3x): one line per rotated outside link, W2-TV (SU(2): dE[chi_1(A)], dE[chi_2(A)] kept on the line) or U1-TV (U(1): d|E[e^{i Phi_A}]| kept),
# the influence I(l) = max_a |dE[chi_a(A)]| / d_a (U(1): |d|E_1||, exact while E_base > max |dE|, both laws real by conjugation), the row sum
# over the outside links, the largest link, and the profile by DISTANCE -- the least L1 distance from either endpoint of the link to a vertex
# of the coarse loop A, the boundary of the n x n block at z = 0 (the convention of §9's one-step profile) -- SPLIT BY POSITION (08:1x, after
# the reviewer's read: at n = 4 the staples over the face's interior sit at distance >= 2 from the loop and couple through the face, not the
# bulk, so one distance class holds two populations, law 2-bis): OVER-A, both endpoints' xy-projection inside the block's closed footprint
# [0,n]^2 (the link above or below face A); OVER-B, both endpoints' yz-projection inside [0,n]^2 (beside face B); BESIDE, the rest.
# usage: gawk -v n=2|4 -f w2_ladder.awk <ladder record>
function abs(x) { return x < 0 ? -x : x }
function dist(x, y, z,   best, vx, vy, d) { best = 1e9; for (vx = 0; vx <= n; vx++) for (vy = 0; vy <= n; vy++) { if (vx > 0 && vx < n && vy > 0 && vy < n) continue; d = abs(x - vx) + abs(y - vy) + abs(z); if (d < best) best = d } return best }
function inA(x, y) { return x >= 0 && x <= n && y >= 0 && y <= n }
function inB(y, z) { return y >= 0 && y <= n && z >= 0 && z <= n }
/^W2-TV/ { match($0, /dE\[chi_1\(A\)\] = ([-+0-9.e]+) dE\[chi_2\(A\)\] = ([-+0-9.e]+)/, m); i1 = abs(m[1] + 0) / 2; i2 = abs(m[2] + 0) / 3; inf = i1 > i2 ? i1 : i2; kind = "SU(2)"; l1 += $6 + 0
  match($0, /W2-ROT link [0-9]+ \(([-0-9]+),([-0-9]+),([-0-9]+),([-0-9]+) dir ([0-9])\)/, c); take() }
/^W2-LAD / { match($0, /dE\[chi_1\(A\)\] = ([-+0-9.e]+) dE\[chi_2\(A\)\] = ([-+0-9.e]+)/, m); i1 = abs(m[1] + 0) / 2; i2 = abs(m[2] + 0) / 3; inf = i1 > i2 ? i1 : i2; kind = "SU(2)"; lad++   # the ladder mode's line (11:5x): no truncated density, so no L1 column
  match($0, /W2-ROT link [0-9]+ \(([-0-9]+),([-0-9]+),([-0-9]+),([-0-9]+) dir ([0-9])\)/, c); take() }
/^U1-TV/ { match($0, /d\|E\[e\^\{i Phi_A\}\]\| = ([-+0-9.e]+)/, m); inf = abs(m[1] + 0); kind = "U(1)"; l1 += $6 + 0
  match($0, /U1-ROT link [0-9]+ \(([-0-9]+),([-0-9]+),([-0-9]+),([-0-9]+) dir ([0-9])\)/, c); take() }
function take(   x, y, z, dir, x2, y2, z2, a, b, d, pos) { x = c[1] + 0; y = c[2] + 0; z = c[3] + 0; dir = c[5] + 0; x2 = x + (dir == 1); y2 = y + (dir == 2); z2 = z + (dir == 3)
  a = dist(x, y, z); b = dist(x2, y2, z2); d = a < b ? a : b
  pos = (inA(x, y) && inA(x2, y2)) ? "OVER-A" : ((inB(y, z) && inB(y2, z2)) ? "OVER-B" : "BESIDE")
  N++; S += inf; if (inf > MX) MX = inf; NS[d]++; SS[d] += inf; if (inf > MS[d]) MS[d] = inf; NP[pos]++; SP[pos] += inf; NQ[pos, d]++; SQ[pos, d] += inf; if (inf > MQ[pos, d]) MQ[pos, d] = inf }
END { if (!n) { print "W2-LADDER REFUSED: n (the block size) is needed"; exit 2 } if (!N) { print "W2-LADDER REFUSED: no ladder line"; exit 2 }
  if (lad) printf "W2-LADDER %s n=%d: %d outside links; moment-influence row sum %.6e, largest link %.6e (the ladder mode's record: no L1 column)\n", kind, n, N, S, MX
  else printf "W2-LADDER %s n=%d: %d outside links; moment-influence row sum %.6e, largest link %.6e; the truncated densities' L1 row sum %.6e\n", kind, n, N, S, MX, l1
  for (d = 0; d <= 12; d++) if (NS[d]) printf "W2-LADDER-DIST %d: %3d links, sum %.4e, mean %.4e, max %.4e\n", d, NS[d], SS[d], SS[d] / NS[d], MS[d]
  split("OVER-A OVER-B BESIDE", P, " "); for (k = 1; k <= 3; k++) { pos = P[k]; if (!NP[pos]) continue; printf "W2-LADDER-POS %s: %3d links, sum %.4e, mean %.4e;", pos, NP[pos], SP[pos], SP[pos] / NP[pos]; for (d = 0; d <= 12; d++) if (NQ[pos, d]) printf " d%d: %d links mean %.3e max %.3e;", d, NQ[pos, d], SQ[pos, d] / NQ[pos, d], MQ[pos, d]; printf "\n" } }
