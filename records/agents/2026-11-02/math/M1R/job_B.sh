#!/bin/bash
# job_B.sh -- M1R: the tolerance curve kappa*(beta) read at two of M1's points (WORK.md section 14): page, F0 = 22, table g, EVENTAIL=1 NCSIG=1,
# every leaf of size >= 24 at 4 sigma(F) (K u)^F (TKN/TKD = K, the tail only). M1's brackets: kappa*(0.35) in [1.6715, 1.6722),
# kappa*(0.4764) in [1.1295, 1.1302). The lower end must PASS and the upper FAIL, on M1's engine.
. "/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/M1R/m1r_lib.sh"
LT=(-v LOCAL=1 -v "R2TAB=$TAB")
stamp START
for x in "3500 16715" "3500 16722" "4764 11295" "4764 11302"; do set -- $x; echo "-- beta=0.$1 K=$2/10000"; scan1 kp_cert_m1.awk $1 page 22 10 120 "${LT[@]}" -v EVENTAIL=1 -v NCSIG=1 -v TKN=$2 -v TKD=10000; done
stamp END
