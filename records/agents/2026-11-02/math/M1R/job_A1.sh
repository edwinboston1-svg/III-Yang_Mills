#!/bin/bash
# job_A1.sh -- M1R's re-run of record: the controls, then M1's four thresholds and the step above each, on M1's engine copied byte-identical
# (kp_cert_m1.awk, md5 3d17b9b8...), the table of record tag g, alpha searched on the 1e-4 grid in [0.0010, 0.0120] exactly as M1's bisect.sh.
. "/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/M1R/m1r_lib.sh"
LT=(-v LOCAL=1 -v "R2TAB=$TAB")
stamp START
cd "$W" && md5sum kp_cert_m1.awk kp_cert_rec_from_III.awk kp_cert_m1r.awk r2tab_g_mine.txt local_tail_table.2026-10-31g.txt "$AWKP/aperanton_bessel_cert.awk"
echo "== C0 CONTROLS at beta = 0.4764, alpha = 0.0044, F0 = 20 (the record's point): record engine / M1 engine, modes unset / M1R variant, modes unset"
for D in page tree; do
  a=$(point kp_cert_rec_from_III.awk 4764 44 $D 20 "${LT[@]}" | grep "KP-CERT dress"); b=$(point kp_cert_m1.awk 4764 44 $D 20 "${LT[@]}" | grep "KP-CERT dress"); c=$(point kp_cert_m1r.awk 4764 44 $D 20 "${LT[@]}" | grep "KP-CERT dress")
  echo "REC  $a"; echo "M1   $b"; echo "M1R  $c"
  [ "$a" = "$b" ] && echo "C0 $D: M1 engine (modes unset) CHARACTER-IDENTICAL to the record engine" || echo "C0 $D: M1 engine DIFFERS from the record engine"
  [ "$a" = "$c" ] && echo "C0 $D: M1R variant (modes unset) CHARACTER-IDENTICAL to the record engine" || echo "C0 $D: M1R variant DIFFERS from the record engine"
done
echo "== R1 THE S12-FREE NUMBER (Corollary U''): EVENTAIL=1 UNCOND=1 U12=1 NCSIG=1, F0 = 22"
for x in "page 3650" "page 3652" "tree 3656" "tree 3658"; do set -- $x; scan1 kp_cert_m1.awk $2 $1 22 10 120 "${LT[@]}" -v EVENTAIL=1 -v UNCOND=1 -v U12=1 -v NCSIG=1; done
echo "== R1' the U'' points' report lines at alpha = 0.0044 (inside both PASS windows)"
point kp_cert_m1.awk 3650 44 page 22 "${LT[@]}" -v EVENTAIL=1 -v UNCOND=1 -v U12=1 -v NCSIG=1 | grep -E "KP-CERT dress|M1-TAIL|M1-UNCOND"
point kp_cert_m1.awk 3656 44 tree 22 "${LT[@]}" -v EVENTAIL=1 -v UNCOND=1 -v U12=1 -v NCSIG=1 | grep -E "KP-CERT dress|M1-TAIL|M1-UNCOND"
echo "== R3 THE CONDITIONAL NUMBER (S12's staked 4 sigma(F) u^F kept, T1 + T2): EVENTAIL=1 NCSIG=1, F0 = 22"
for x in "page 5100" "page 5102" "tree 5198" "tree 5200"; do set -- $x; scan1 kp_cert_m1.awk $2 $1 22 10 120 "${LT[@]}" -v EVENTAIL=1 -v NCSIG=1; done
echo "== R3' the same with NCSIG unset (M1: it moves no digit)"
for x in "page 5100" "page 5102"; do set -- $x; scan1 kp_cert_m1.awk $2 $1 22 10 120 "${LT[@]}" -v EVENTAIL=1; done
stamp END
