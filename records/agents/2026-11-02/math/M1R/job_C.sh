#!/bin/bash
# job_C.sh STEP -- M1R: the coordinator's decomposition of iii-08's road (gamma = 6, F0 = 20, the record's tail, every tail leaf at (q u)^F, q = sqrt 2)
# into M1's U'' number, one change at a time, on the M1R variant (kp_cert_m1r.awk: M1's engine + RECK, the record's tail with the tail-only K).
# q = TKN/TKD = 14142136/10000000 >= sqrt 2. Tree dressing unless the step says page. Alpha on the 1e-4 grid in [0.0010, 0.0120].
. "/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/M1R/m1r_lib.sh"
LT=(-v LOCAL=1 -v "R2TAB=$TAB"); QK=(-v TKN=14142136 -v TKD=10000000)
stamp "START $1"
case "$1" in
  C0) # gamma = 6, F0 = 20, the record's tail, q = 1: the record's own gamma = 6 numbers (S1 section 20 records b/c: page 0.4260, tree 0.4378)
      for x in "page 4260" "page 4262" "tree 4378" "tree 4380"; do set -- $x; scan1 kp_cert_rec_from_III.awk $2 $1 20 10 120; done ;;
  C1)  bis kp_cert_m1r.awk tree 20 3400 3800 10 120 -v RECK=1 "${QK[@]}" ;;                          # iii-08's road (expect 0.3585)
  C1p) bis kp_cert_m1r.awk page 20 3400 3800 10 120 -v RECK=1 "${QK[@]}" ;;                          # the same, page dressing
  C2)  bis kp_cert_m1r.awk tree 20 3500 4100 10 120 -v EVENTAIL=1 -v NCSIG=1 "${QK[@]}" ;;           # + T1, T2
  C3)  bis kp_cert_m1r.awk tree 22 3500 4100 10 120 -v EVENTAIL=1 -v NCSIG=1 "${QK[@]}" ;;           # + F0 = 22
  C4)  bis kp_cert_m1r.awk tree 22 3500 4200 10 120 "${LT[@]}" -v EVENTAIL=1 -v NCSIG=1 "${QK[@]}" ;; # + the table of record's dressing
  C4p) bis kp_cert_m1r.awk page 22 3500 4200 10 120 "${LT[@]}" -v EVENTAIL=1 -v NCSIG=1 "${QK[@]}" ;; # the same, page
esac
stamp "END $1"
