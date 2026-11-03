# tilt_datum.awk -- TILT(alpha, s): one line "<index> <w> <x> <y> <z>" per outside link, the quaternion (cos alpha, sin alpha * n_i),
# n_i a unit axis from a deterministic 32-bit LCG seeded by (index, s) (exact in doubles: every product < 2^53). usage:
# gawk -v N=536 -v ALPHA=0.2 -v S=1 -f tilt_datum.awk > datum.txt
function lcg() { X = (1664525 * X + 1013904223) % 4294967296; return (X + 0.5) / 4294967296 }
BEGIN { PI = 3.141592653589793
  for (i = 0; i < N; i++) { X = (i * 2654435761 + S * 97531 + 12345) % 4294967296; for (k = 0; k < 5; k++) lcg()
    do { u1 = lcg(); u2 = lcg(); u3 = lcg(); u4 = lcg()
      g1 = sqrt(-2 * log(u1)) * cos(2 * PI * u2); g2 = sqrt(-2 * log(u1)) * sin(2 * PI * u2); g3 = sqrt(-2 * log(u3)) * cos(2 * PI * u4)
      nn = sqrt(g1 * g1 + g2 * g2 + g3 * g3) } while (nn < 1e-9)
    printf "%d %.17g %.17g %.17g %.17g\n", i, cos(ALPHA), sin(ALPHA) * g1 / nn, sin(ALPHA) * g2 / nn, sin(ALPHA) * g3 / nn } }
