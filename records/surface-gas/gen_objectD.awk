# gen_objectD.awk -- Object D's plaquette list (S1 (p) STAKE of 16:2x): a sphere sheet with one cycle in its contact preimage.
function P(x, y, z, t, a, b) { n++; tok[n] = "(" x "," y "," z "," t ")" a b }
function put(x, y, z, t, a, b,   s) { s = "(" x "," y "," z "," t ")" a b; if (s in skip) { skipped++; return } P(x, y, z, t, a, b) }
# a square tube: the boundary of [x0,x1] x [y0,y1] in the (1,2)-plane at (z, t) times one unit step in direction d (3 or 4) from level k
function tube(x0, x1, y0, y1, z, t, d, k,   x, y) {
  for (x = x0; x < x1; x++) { if (d == 3) { P(x, y0, k, t, 1, 3); P(x, y1, k, t, 1, 3) } else { P(x, y0, z, k, 1, 4); P(x, y1, z, k, 1, 4) } }
  for (y = y0; y < y1; y++) { if (d == 3) { P(x0, y, k, t, 2, 3); P(x1, y, k, t, 2, 3) } else { P(x0, y, z, k, 2, 4); P(x1, y, z, k, 2, 4) } } }
# a plain box at time t: the boundary of [X0,X1] x [Y0,Y1] x [Z0,Z1]; holes in skip[]
function box(X0, X1, Y0, Y1, Z0, Z1, t,   x, y, z) {
  for (x = X0; x < X1; x++) for (y = Y0; y < Y1; y++) { put(x, y, Z1, t, 1, 2); put(x, y, Z0, t, 1, 2) }
  for (y = Y0; y < Y1; y++) for (z = Z0; z < Z1; z++) { put(X0, y, z, t, 2, 3); put(X1, y, z, t, 2, 3) }
  for (x = X0; x < X1; x++) for (z = Z0; z < Z1; z++) { put(x, Y0, z, t, 1, 3); put(x, Y1, z, t, 1, 3) } }
# a brick [x0,x1] x [y0,y1] x {z} x [t0,t1] in directions (1, 2, 4) with its far time-face (at tfar) removed: five faces
function brick(x0, x1, y0, y1, z, t0, t1, tfar,   tnear) { tnear = (tfar == t1) ? t0 : t1;
  P(x0, y0, z, tnear, 1, 2);                                   # the time-face kept (at t = tnear): in the (1,2)-plane
  P(x0, y0, z, t0, 1, 4); P(x0, y1, z, t0, 1, 4);              # the (1,4)-faces at y = y0, y1
  P(x0, y0, z, t0, 2, 4); P(x1, y0, z, t0, 2, 4) }             # the (2,4)-faces at x = x0, x1
BEGIN {
  n = 0;
  P(0, 0, 0, 0, 1, 2);                                         # f
  tube(0, 1, 0, 1, 0, 0, 3, 0);                                # the sheet's continuation: C x [0,1]_3
  tube(0, 1, 0, 1, 1, 0, 4, 0);                                # (C + e3) x [0,1]_4, arriving at f + e3 + e4 (z = 1, t = 1)
  brick(0, 1, -1, 0, 0, 0, 1, 1);                              # B1 at l1: t in [0,1], far face at t = 1 removed; kept face f- at t = 0
  brick(1, 2, 0, 1, 0, -1, 0, -1);                             # B2 at l2: t in [-1,0], far face at t = -1 removed; kept face at t = 0
  brick(0, 1, 1, 2, 0, 0, 1, 1);                               # B3 at l3
  brick(-1, 0, 0, 1, 0, -1, 0, -1);                            # B4 at l4
  # the junctions at t = 1: box 3 = [-2,3]^2 x [-3,0] (top z = 0: holes at B1's rim (0,-1,0,1)12, B3's rim (0,1,0,1)12, the z-tube square (2,2,0,1)12,
  # the connecting square (2,-2,0,1)12); box 1 = [-2,3]^2 x [1,4] (bottom z = 1: holes at the 3-tube's rim (0,0,1,1)12 and the z-tube square (2,2,1,1)12)
  delete skip; skip["(0,-1,0,1)12"]; skip["(0,1,0,1)12"]; skip["(2,2,0,1)12"]; skip["(2,-2,0,1)12"]; box(-2, 3, -2, 3, -3, 0, 1); s3 = skipped; skipped = 0;
  delete skip; skip["(0,0,1,1)12"]; skip["(2,2,1,1)12"]; box(-2, 3, -2, 3, 1, 4, 1); s1 = skipped; skipped = 0;
  tube(2, 3, 2, 3, 0, 1, 3, 0);                                # the z-tube between box 3's top (z = 0) and box 1's bottom (z = 1) at t = 1
  # the junction at t = -1: box 2 = [-2,3]^2 x [-3,0] (top z = 0: holes at B2's rim (1,0,0,-1)12, B4's rim (-1,0,0,-1)12, the connecting square (2,-2,0,-1)12)
  delete skip; skip["(1,0,0,-1)12"]; skip["(-1,0,0,-1)12"]; skip["(2,-2,0,-1)12"]; box(-2, 3, -2, 3, -3, 0, -1); s2 = skipped; skipped = 0;
  for (k = -1; k <= 0; k++) tube(2, 3, -2, -1, 0, 0, 4, k);     # the connecting tube d([2,3] x [-2,-1]) x [-1,1]_4 at z = 0
  for (i = 1; i <= n; i++) printf "%s%s", tok[i], (i % 12 ? " " : "\n"); if (n % 12) printf "\n";
  printf "# count %d (holes skipped: box 3 %d, box 1 %d, box 2 %d)\n", n, s3, s1, s2 > "/dev/stderr" }
