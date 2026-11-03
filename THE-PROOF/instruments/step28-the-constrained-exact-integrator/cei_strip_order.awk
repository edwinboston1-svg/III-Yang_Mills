# cei_strip_order.awk -- the column sweep of a planar strip of K coarse cells at n = 2 (x y z d per line, the engine's order file): face 0's
# far edge (the vertical links at x = n), then for every column position from x = n - 1 down to the strip's left edge the column's x-links
# (y = 0..n) and then its vertical links (y = 0..n-1); eliminated links are skipped by the driver.   usage: gawk -v K=5 -v n=2 -f cei_strip_order.awk
BEGIN { if (K == "") K = 2; if (n == "") n = 2; for (j = 0; j < n; j++) print n, j, 0, 2
  for (i = n - 1; i >= -(K - 1) * n; i--) { for (j = 0; j <= n; j++) print i, j, 0, 1; for (j = 0; j < n; j++) print i, j, 0, 2 } }
