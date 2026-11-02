#!/bin/bash
# job_A2.sh -- M1R: the MARGINS at M1's eight points. The M1R variant (kp_cert_m1r.awk = M1's engine + RECK + VSCAN, both inert unset;
# job_A1's C0 checks the variant against the record) prints every alpha's report line; the reading is max over alpha of (alpha - LHS_hi):
# positive at a PASS (the slack), negative at a FAIL (the least excess, i.e. how far the best alpha misses).
. "/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/M1R/m1r_lib.sh"
LT=(-v LOCAL=1 -v "R2TAB=$TAB")
marg() { awk '/^KP-CERT dress/ { a = $0; sub(/.* alpha=/, "", a); sub(/ .*/, "", a); l = $0; sub(/.*LHS in \[/, "", l); sub(/\].*/, "", l); split(l, LH, ", "); s = a - LH[2];
    if (!n || s > best) { best = s; ba = a; bl = LH[2]; bline = $0 } n++ }
  /^KP-CERT SCAN/ { scanl = $0 }
  END { printf "MARGIN best alpha=%s LHS_hi=%s slack=alpha-LHS_hi=%.7f (relative %.4f) over %d alphas\n  best line: %s\n  %s\n", ba, bl, best, best / ba, n, bline, scanl }'; }
stamp START
cd "$W" && md5sum kp_cert_m1r.awk
echo "== U'' (S12-free), F0 = 22"
for x in "page 3650" "page 3652" "tree 3656" "tree 3658"; do set -- $x; echo "-- $1 beta=0.$2"; vscan kp_cert_m1r.awk $2 $1 22 10 120 "${LT[@]}" -v EVENTAIL=1 -v UNCOND=1 -v U12=1 -v NCSIG=1 | marg; done
echo "== conditional (T1 + T2, S12's stake kept), F0 = 22"
for x in "page 5100" "page 5102" "tree 5198" "tree 5200"; do set -- $x; echo "-- $1 beta=0.$2"; vscan kp_cert_m1r.awk $2 $1 22 10 120 "${LT[@]}" -v EVENTAIL=1 -v NCSIG=1 | marg; done
stamp END
