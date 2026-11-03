# cei_resp.awk -- the datum files for the object's quadratic response along the exterior's eigenmodes (campaign 31.14, the dressed exterior):
# X = +-eps u_m e_1 for every mode m of cei_dtn's marg output; the index "name m sign"; the runner's second difference gives the mode's stiffness
# h_m = -[log Z(+) + log Z(-) - 2 log Z(0)] / eps^2.   usage: gawk -v EPS=0.2 -v DIR=resp -f cei_resp.awk cei_marg.R8.txt
/^MARG-LINK/ { e = $2 + 1; NE = e; X[e] = $3; Y[e] = $4; Z[e] = $5; T[e] = $6; D[e] = $7 }
/^MARG-EIG/ { m = $2 + 1; NM = m; EV[m] = $3 + 0; for (i = 1; i <= NE; i++) U[m, i] = $(3 + i) + 0 }
function quatline(e, ax,   a, c, s) { a = (ax < 0) ? -ax : ax; c = cos(a / 2); s = (a > 1e-300) ? sin(a / 2) / a : 0.5; return sprintf("%d %d %d %d %d %.15f %.15f 0 0", X[e], Y[e], Z[e], T[e], D[e], c, s * ax) }
END { if (EPS == "") EPS = 0.2; if (DIR == "") DIR = "resp"; system("mkdir -p " DIR); idx = DIR "/index.txt"; printf "" > idx
  for (m = 1; m <= NM; m++) for (sg = -1; sg <= 1; sg += 2) { name = sprintf("R_%03d_%s.file", m, sg > 0 ? "p" : "m"); f = DIR "/" name
    for (e = 1; e <= NE; e++) print quatline(e, sg * EPS * U[m, e]) > f; close(f); printf "%s %d %d\n", name, m, sg >> idx }
  close(idx); printf "CEI-RESP: %d modes, eps %g, %d datum files under %s\n", NM, EPS, 2 * NM, DIR }
