#include <stdio.h>
static int cls(int o, int c, int a) { return o * 4 + c * 2 + a; }
static int okpat(int r) { for (int z = 0; z < 2; z++) for (int t = 0; t < 2; t++) { int d = (r >> cls(0, t, (z + 1) & 1) & 1) + (r >> cls(0, t, z) & 1) + (r >> cls(1, z, (t + 1) & 1) & 1) + (r >> cls(1, z, t) & 1); if (d != 2) return 0; } return 1; }
int main(void) { int np = 0; for (int r = 0; r < 256; r++) if (okpat(r)) { np++; printf("pattern %3d:", r); for (int k = 0; k < 8; k++) printf(" %d", r >> k & 1); printf("\n"); } printf("np=%d\n", np); return 0; }
