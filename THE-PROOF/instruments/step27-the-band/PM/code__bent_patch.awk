# bent_patch.awk -- su2mh.c -> su2mhb.c: B in the plane (rho, nu) on the -rho side (rho = mu: the planar pair, unchanged; rho != mu, nu: the
# bent pair); for the bent pair B's two corner horizontals at the T-junctions share a (mu, rho) plaquette with A's corner horizontals and are
# left unintegrated.  A seventh argument picks the geometry: planar (default) or bent.
NR == 11 { print " * usage: su2mhb D L BETA n SEED NTHERM NSEP NMEAS NOR OUTFILE [planar|bent]   build: gcc -O2 -fopenmp -o su2mhb.exe su2mhb.c -lm"; print " * su2mhb: B in the plane (rho, nu) on the -rho side; rho = mu the planar pair, rho != mu, nu the bent pair (B's corner horizontals then unintegrated). */"; next }
/^static void placement\(long s, int mu, int nu, double out/ { sub(/int mu, int nu,/, "int mu, int nu, int rho,"); print; next }
/for \(int i = 0; i < n; i\+\+\) \{ long st = shift\(shift\(s, mu, -\(i \+ 1\)\), nu, n\); lB/ { print "  for (int i = 0; i < n; i++) { long st = shift(shift(s, rho, -(i + 1)), nu, n); lB[nb] = st * D + rho; bB[nb] = 1; iB[nb] = (rho == mu || i != 0); nb++; }"; next }
/int j = n - 1 - i; long st = shift\(shift\(s, mu, -n\), nu, j\)/ { print "  for (int i = 0; i < n; i++) { int j = n - 1 - i; long st = shift(shift(s, rho, -n), nu, j); lB[nb] = st * D + nu; bB[nb] = 1; iB[nb] = (j >= 1 && j <= n - 2); nb++; }"; next }
/long st = shift\(s, mu, -n \+ i\); lB/ { print "  for (int i = 0; i < n; i++) { long st = shift(s, rho, -n + i); lB[nb] = st * D + rho; bB[nb] = 0; iB[nb] = (rho == mu || i != n - 1); nb++; }"; next }
/if \(argc < 11\)/ { print; print "  int BENT = (argc > 11 && !strcmp(argv[11], \"bent\"));"; next }
/long npl = V \* D \* \(D - 1\);/ { print "  long npl = BENT ? V * D * (D - 1) * (D - 2) : V * D * (D - 1);"; next }
/for \(long s = 0; s < V; s\+\+\) for \(int mu = 0; mu < D; mu\+\+\) for \(int nu = 0; nu < D; nu\+\+\) \{ if \(nu == mu\) continue; double o\[2\]\[3\]\[3\]; placement\(s, mu, nu, o\);/ {
  print "      for (long s = 0; s < V; s++) for (int mu = 0; mu < D; mu++) for (int nu = 0; nu < D; nu++) for (int rho = 0; rho < D; rho++) { if (nu == mu) continue; if (BENT ? (rho == mu || rho == nu) : (rho != mu)) continue; double o[2][3][3]; placement(s, mu, nu, rho, o);"; next }
/fprintf\(fo, "# su2mh D=%d/ { sub(/# su2mh D=%d/, "# su2mhb %s D=%d"); sub(/\n", D, LS/, "\n\", BENT ? \"bent\" : \"planar\", D, LS"); print; next }
{ print }
