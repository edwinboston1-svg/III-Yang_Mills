#!/bin/bash
# job_C2.sh STEP -- M1R: the page-dressing half of the decomposition (job_C.sh is not edited while its runs read it).
. "/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/M1R/m1r_lib.sh"
LT=(-v LOCAL=1 -v "R2TAB=$TAB"); QK=(-v TKN=14142136 -v TKD=10000000)
stamp "START $1"
case "$1" in
  C2p) bis kp_cert_m1r.awk page 20 3500 4100 10 120 -v EVENTAIL=1 -v NCSIG=1 "${QK[@]}" ;;           # gamma = 6, F0 = 20, + T1, T2
  C3p) bis kp_cert_m1r.awk page 22 3500 4100 10 120 -v EVENTAIL=1 -v NCSIG=1 "${QK[@]}" ;;           # + F0 = 22
  C1q) bis kp_cert_m1r.awk page 20 3500 3700 10 120 -v RECK=1 -v TKN=1414 -v TKD=1000 ;;             # iii-08's q = 1.414 exactly, page
  C1t) bis kp_cert_m1r.awk tree 20 3500 3800 10 120 -v RECK=1 -v TKN=1414 -v TKD=1000 ;;             # the same, tree
esac
stamp "END $1"
