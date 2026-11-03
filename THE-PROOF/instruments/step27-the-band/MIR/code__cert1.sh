#!/bin/bash
# cert1.sh COEF [HALFN] [WALLN] -- one GRADED page-dressing evaluation of the committed certificate (copy) at alpha = 1/1000, beta slot 0.4764
MIR=/c/Users/EDWINB~1/AppData/Local/Temp/the author/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/MIR
cd "$MIR/code"; TAB="$(cat R2TAB.txt)"
H=${2:-0}; W=${3:-0}
AWKPATH="$MIR/code" gawk -M -v BESSEL_LIB=1 -v GRADED=1 -v "R2TAB=$TAB" -v DRESS=page -v P=4764 -v Q=10000 -v AN=1 -v AD=1000 -v GN=6 -v GD=1 -v F0=20 \
  -v COEF="$1" -v HALFN="$H" -v HALFD=1000000000000 -v WALLN="$W" -v WALLD=1000000000000 -f kp_cert.awk 2>&1 | tr -d '\r' | grep -m1 'KP-CERT dress\|REFUSED'
