# M7b: the sharp inputs of Corollary 3.2 from a modes record (w2_modes output): c_1/2 = a'_1/2 (1 + 20 r_mod)(1 + min(2r, 4 sqrt r)) [(1/2,1/2) bonds:
# orientation when r < 4, split otherwise; four leaf neighbours]; c_1 for a wall plaquette with K attachment links and 4-K inner links:
# a'_1 + K*2*|b(2,1)|/(2a'_1/2)/3 + (4-K)*|b(2,2)|^{1/2}/3 [the (1/2,1) bonds oriented at the wall end, the (1,1) bonds split]; K = 1 (a branch
# piece's root plaquette) and K = 4 (the lone wall).  All on the coplanar mode, used at every position (the bent positions unread).
function abs(x) { return x < 0 ? -x : x }
/^W2-MODE a=1 c=1 / { split($4, q, "="); b11 = q[2] + 0 } /^W2-MODE a=2 c=1 / { split($4, q, "="); b21 = q[2] + 0 } /^W2-MODE a=2 c=2 / { split($4, q, "="); b22 = q[2] + 0 }
/^W2-CONTENT/ { for (i = 1; i <= NF; i++) if ($i == "r_mod") rmod = $(i + 2) + 0 }
/^W2-COEF j2=1 / { split($3, q, "="); ah = q[2] + 0 } /^W2-COEF j2=2 / { split($3, q, "="); a1 = q[2] + 0 }
END { r = abs(b11) / (2 * ah) ^ 2; ch = 2 * r; cs = 4 * sqrt(r); ch = (ch < cs ? ch : cs); cH = ah * (1 + 20 * rmod) * (1 + ch)
  w21 = abs(b21) / (2 * ah) / 3; w22 = sqrt(abs(b22)) / 3; c1a = a1 + 2 * w21 + 3 * w22; c1b = a1 + 8 * w21
  printf "SHARP a'_1/2=%.6e a'_1=%.6e r_1/2,1/2=%.4f r_mod=%.3e: c_1/2=%.6e  wall per (1/2,1) bond %.4e per (1,1) bond %.4e: c_1(K=1)=%.6e c_1(K=4)=%.6e  COEF=%.9f,%.9f\n", ah, a1, r, rmod, cH, w21, w22, c1a, c1b, cH, (c1a > c1b ? c1a : c1b) }
