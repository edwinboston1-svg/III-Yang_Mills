#!/bin/bash
# M5 wall_scan.sh -- stake S3: the largest wall floor W* (units 1e-12) at which the two-step call (COEF, HALF of the record) still PASSes.
# Bisection on WALLN in [0, 3e11]; a floor below the Wilson a'_1 is inert (the engine takes the max), so the lower end passes by S2.
W="$(cd "$(dirname "$0")" && pwd)"
for d in ordered cancel; do for m in page local; do
  lo=0; hi=300000000000
  while [ $((hi - lo)) -gt 100000000 ]; do mid=$(( (lo + hi) / 2 ))
    if bash "$W/cert_runs.sh" CALL $d $m 1 1000 WALLN=$mid | grep -q -- '-> PASS'; then lo=$mid; else hi=$mid; fi; done
  last=$(bash "$W/cert_runs.sh" CALL $d $m 1 1000 WALLN=$lo | sed 's/.*-> //'); fail=$(bash "$W/cert_runs.sh" CALL $d $m 1 1000 WALLN=$hi | sed 's/.*-> //')
  echo "S3 $d $m: W* in [$lo, $hi]e-12 ; at lo: $last ; at hi: $fail"
done; done
