# UV2: inspect the extremal slice mode (READING, double precision)
import sys, numpy as np
sys.path.insert(0, 'code')
from uv2_scalar import build, slice_min
d, N, levels = 2, int(sys.argv[1]), eval(sys.argv[2])
o = build(d, N, levels, 'min'); res = slice_min(o)
lam = res['lam']; lam = lam / np.abs(lam).max()
s1, lo, hi = levels[1]
print("ratio", res['ev'][:3])
grid = np.zeros((N, N))
for p, i in o['sid'].items(): grid[p] = lam[i]
# print a window around the lower-left corner region of Omega_1 and a mid-face line
mid = (lo + hi) // 2
print("line normal to the face x = lo, at y = mid (x from lo-4 to lo+3*s1):")
print(" ".join(f"{grid[x, mid]:+.3f}" for x in range(lo - 4, min(N, lo + 3 * s1))))
print("same line, y = mid+1:"); print(" ".join(f"{grid[x, mid+1]:+.3f}" for x in range(lo - 4, min(N, lo + 3 * s1))))
print("outer layer x = lo-1 along y (lo..lo+2*s1):"); print(" ".join(f"{grid[lo-1, y]:+.3f}" for y in range(lo, lo + 2 * s1)))
print("inner layer x = lo along y:"); print(" ".join(f"{grid[lo, y]:+.3f}" for y in range(lo, lo + 2 * s1)))
# block averages along the line
print("block averages of the first blocks along x at the mid row of blocks:")
yb = lo + ((mid - lo) // s1) * s1
print(" ".join(f"{grid[x:x+s1, yb:yb+s1].mean():+.3f}" for x in range(lo, lo + 4 * s1, s1)))
print("avg of outer L-block [lo-s1,lo) at that row:", f"{grid[lo-s1:lo, yb:yb+s1].mean():+.3f}")
