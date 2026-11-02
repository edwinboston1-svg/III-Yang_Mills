#!/bin/bash
# job_F.sh -- M1R: iii-08's q = 1.072 rung on the tree dressing (gamma = 6, F0 = 20, the record's tail), to read whether its ladder's top
# (0.4259, "-> 0.4260 as q -> 1") is the tree's or the page's (at q = 1 the tree reads 0.4378 and the page 0.4260, job C0).
. "/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/M1R/m1r_lib.sh"
stamp "START F-tree"
bis kp_cert_m1r.awk tree 20 4100 4380 10 120 -v RECK=1 -v TKN=1072 -v TKD=1000
stamp "END F-tree"
