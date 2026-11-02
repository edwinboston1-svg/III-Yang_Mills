#!/bin/bash
# job_D.sh -- M1R: which table entries the numbers lean on. The table of record tag g carries k = 15..24 on the record's realigned bound
# (S1 section 25 (c): census-checked, 0 discords in 3,464 rows, but absent from section 25 (i)'s list of second-seat signatures). Here k = 15..24
# are replaced by the Frobenius sieve's per-corner maxima (section 24 (b), SIGNED in section 25 (i)), each rounded up at the fourth decimal
# (r2tab_sieve15.txt; k = 9..14 the tag-g exact maxima). If the S12-free number survives, it does not lean on the realigned bound.
. "/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/M1R/m1r_lib.sh"
TS=$(cat "$W/r2tab_sieve15.txt"); LS=(-v LOCAL=1 -v "R2TAB=$TS")
stamp START
echo "== U'' (S12-free), sieve table at k >= 15"
for x in "page 3650" "page 3652" "tree 3656" "tree 3658"; do set -- $x; scan1 kp_cert_m1.awk $2 $1 22 10 120 "${LS[@]}" -v EVENTAIL=1 -v UNCOND=1 -v U12=1 -v NCSIG=1; done
echo "== conditional (T1 + T2), sieve table at k >= 15"
for x in "page 5100" "tree 5198"; do set -- $x; scan1 kp_cert_m1.awk $2 $1 22 10 120 "${LS[@]}" -v EVENTAIL=1 -v NCSIG=1; done
echo "== conditional, sieve table, the largest passing beta (page), by bisection"
bis kp_cert_m1.awk page 22 4400 5100 10 120 "${LS[@]}" -v EVENTAIL=1 -v NCSIG=1
stamp END
