# envalign.awk -- the coarse alignment of a datum around the planar n = 4 two-step object: the holonomies of the eight displaced copies of the
# loops A (x in [0,4], y in [0,4]) and B (x in [-4,0], y in [0,4]) at z = +-1 or w = +-1 (every link of them is an outside link of the object).
# usage: gawk -f envalign.awk OUTLIST DATUM   -> "ENV c_mean c_min c_max cA_mean cB_mean" with c = 1/2 tr of each displaced loop
function qm(a1,b1,c1,d1,a2,b2,c2,d2) { RW = a1*a2 - b1*b2 - c1*c2 - d1*d2; RX = a1*b2 + b1*a2 + c1*d2 - d1*c2; RY = a1*c2 - b1*d2 + c1*a2 + d1*b2; RZ = a1*d2 + b1*c2 - c1*b2 + d1*a2 }
function mulk(key, inv,   q) { if (!(key in QW)) { printf "MISSING %s\n", key; bad = 1; return }
  if (inv) qm(TW, TX, TY, TZ, QW[key], -QX[key], -QY[key], -QZ[key]); else qm(TW, TX, TY, TZ, QW[key], QX[key], QY[key], QZ[key]); TW = RW; TX = RX; TY = RY; TZ = RZ }
function loopw(x0, x1, z, w,   i) { TW = 1; TX = 0; TY = 0; TZ = 0
  for (i = x0; i < x1; i++) mulk(i SUBSEP 0 SUBSEP z SUBSEP w SUBSEP 1, 0)
  for (i = 0; i < 4; i++) mulk(x1 SUBSEP i SUBSEP z SUBSEP w SUBSEP 2, 0)
  for (i = x1 - 1; i >= x0; i--) mulk(i SUBSEP 4 SUBSEP z SUBSEP w SUBSEP 1, 1)
  for (i = 3; i >= 0; i--) mulk(x0 SUBSEP i SUBSEP z SUBSEP w SUBSEP 2, 1)
  return TW }
FNR == NR { IDX[$2] = $3 SUBSEP $4 SUBSEP $5 SUBSEP $6 SUBSEP $7; next }
{ k = IDX[$1]; QW[k] = $2; QX[k] = $3; QY[k] = $4; QZ[k] = $5 }
END { n = 0; sa = 0; sb = 0; mn = 2; mx = -2
  split("1 0|-1 0|0 1|0 -1", D, "|")
  for (t = 1; t <= 4; t++) { split(D[t], zw, " "); ca = loopw(0, 4, zw[1], zw[2]); cb = loopw(-4, 0, zw[1], zw[2]); sa += ca; sb += cb
    for (u = 1; u <= 2; u++) { c = (u == 1 ? ca : cb); if (c < mn) mn = c; if (c > mx) mx = c } }
  printf "ENV c_mean=%.6f c_min=%.6f c_max=%.6f cA_mean=%.6f cB_mean=%.6f%s\n", (sa + sb) / 8, mn, mx, sa / 4, sb / 4, (bad ? " BAD" : "") }
