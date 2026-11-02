#!/bin/bash
# job_E.sh -- M1R: M1's F0 = 20 numbers (the census at F = 22 on one road; F0 = 20 rests on the two-road census): U'' page 0.3588 (refused 0.3590);
# the conditional page 0.5050 (refused 0.5052) and tree 0.5140 (refused 0.5142). M1's engine, the table of record tag g.
. "/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/M1R/m1r_lib.sh"
LT=(-v LOCAL=1 -v "R2TAB=$TAB")
stamp START
for x in "page 3588" "page 3590"; do set -- $x; scan1 kp_cert_m1.awk $2 $1 20 10 120 "${LT[@]}" -v EVENTAIL=1 -v UNCOND=1 -v U12=1 -v NCSIG=1; done
for x in "page 5050" "page 5052" "tree 5140" "tree 5142"; do set -- $x; scan1 kp_cert_m1.awk $2 $1 20 10 120 "${LT[@]}" -v EVENTAIL=1 -v NCSIG=1; done
stamp END
