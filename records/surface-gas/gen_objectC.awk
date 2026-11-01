# gen_objectC.awk -- Object C's plaquette list (S1 (p) STAKE of 14:1x): two squares sharing a link, seven contact links of cycle rank two.
# Plaquette token "(x,y,z,t)ab": the unit square at base corner (x,y,z,t) spanning directions a < b (1..4).
function P(x, y, z, t, a, b) { n++; tok[n] = "(" x "," y "," z "," t ")" a b }
# a square tube: the boundary of the rectangle [x0,x1] x [y0,y1] (in the (1,2)-plane at height z, time t) times one unit step in
# direction d (3 or 4) from level k to k+1 -- the rectangle's edges in direction 1 (y = y0 and y = y1) give (1,d)-plaquettes, its
# edges in direction 2 (x = x0, x1) give (2,d)-plaquettes.
function tube(x0, x1, y0, y1, z, t, d, k,   x, y) {
  for (x = x0; x < x1; x++) { if (d == 3) { P(x, y0, k, t, 1, 3); P(x, y1, k, t, 1, 3) } else { P(x, y0, z, k, 1, 4); P(x, y1, z, k, 1, 4) } }
  for (y = y0; y < y1; y++) { if (d == 3) { P(x0, y, k, t, 2, 3); P(x1, y, k, t, 2, 3) } else { P(x0, y, z, k, 2, 4); P(x1, y, z, k, 2, 4) } } }
# a box at time t: the boundary of [X0,X1] x [Y0,Y1] x [Z0,Z1], with a direction-2 tunnel [TX0,TX1] x [Y0,Y1] x [TZ0,TZ0+1]
# bored through it; holes (plaquettes removed) are given in the global array skip[token].
function box(X0, X1, Y0, Y1, Z0, Z1, TX0, TX1, TZ0, t,   x, y, z) {
  for (x = X0; x < X1; x++) for (y = Y0; y < Y1; y++) { put(x, y, Z1, t, 1, 2); put(x, y, Z0, t, 1, 2) }                       # top, bottom
  for (y = Y0; y < Y1; y++) for (z = Z0; z < Z1; z++) { put(X0, y, z, t, 2, 3); put(X1, y, z, t, 2, 3) }                       # x = X0, X1
  for (x = X0; x < X1; x++) for (z = Z0; z < Z1; z++) { if (!(x >= TX0 && x < TX1 && z == TZ0)) { put(x, Y0, z, t, 1, 3); put(x, Y1, z, t, 1, 3) } }   # y sides minus the tunnel ends
  for (y = Y0; y < Y1; y++) { put(TX0, y, TZ0, t, 2, 3); put(TX1, y, TZ0, t, 2, 3) }                                           # tunnel walls
  for (x = TX0; x < TX1; x++) for (y = Y0; y < Y1; y++) { put(x, y, TZ0 + 1, t, 1, 2); put(x, y, TZ0, t, 1, 2) } }             # tunnel ceiling, floor
function put(x, y, z, t, a, b,   s) { s = "(" x "," y "," z "," t ")" a b; if (s in skip) { skipped++; return } P(x, y, z, t, a, b) }
BEGIN {
  n = 0;
  P(0, 0, 0, 0, 1, 2); P(1, 0, 0, 0, 1, 2);                                   # f1, f2
  for (k = 0; k <= 2; k++) tube(0, 1, 0, 1, 0, 0, 3, k);                       # tube 1: C1 x [0,3]_3 (the (1,3)/(2,3) plaquettes at levels k..k+1)
  for (k = -3; k <= -1; k++) tube(1, 2, 0, 1, 0, 0, 3, k);                     # tube 2: C2 x [-3,0]_3
  for (k = -1; k <= 0; k++) tube(0, 2, 0, 1, 0, 0, 4, k);                      # the tongues: R x [-1,1]_4
  tube(0, 1, 0, 1, 3, 0, 4, 0);                                                # (C1 + 3e3) x [0,1]_4
  tube(1, 2, 0, 1, -3, 0, 4, -1);                                              # (C2 - 3e3) x [-1,0]_4
  for (k = -1; k <= 0; k++) tube(2, 3, -1, 0, 3, 0, 4, k);                    # the connecting tube d([-1,0]^2) x [-1,1]_4 at z = 3
  # box 1 at t = 1: tunnel at z in [0,1]; holes: the tunnel floor at (0,0,0,1)12 and (1,0,0,1)12 (R + e4), the top at (0,0,3,1)12, the corner (-1,-1,3,1)12
  delete skip; skip["(0,0,0,1)12"]; skip["(1,0,0,1)12"]; skip["(0,0,3,1)12"]; skip["(2,-1,3,1)12"];
  box(-1, 3, -1, 2, -3, 3, 0, 2, 0, 1); b1 = skipped; skipped = 0;
  # box 2 at t = -1: tunnel at z in [-1,0]; holes: the tunnel ceiling at (0,0,0,-1)12 and (1,0,0,-1)12 (R - e4), the bottom at (1,0,-3,-1)12, the corner (-1,-1,3,-1)12
  delete skip; skip["(0,0,0,-1)12"]; skip["(1,0,0,-1)12"]; skip["(1,0,-3,-1)12"]; skip["(2,-1,3,-1)12"];
  box(-1, 3, -1, 2, -3, 3, 0, 2, -1, -1); b2 = skipped;
  for (i = 1; i <= n; i++) printf "%s%s", tok[i], (i % 12 ? " " : "\n"); if (n % 12) printf "\n";
  printf "# count %d (holes skipped: box 1 %d, box 2 %d)\n", n, b1, b2 > "/dev/stderr" }
