#!/bin/bash
. "/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/M1c/m1c_lib.sh"
E="$W/kp_cert_m1c_ref.awk"; RD=(-v EVENTAIL=1 -v NCSIG=1 -v TKN=1385133 -v TKD=1000000 -v OMEGA=1)
sc() { local B="$1" D="$2"; AWKPATH="$AWKP" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v "R2TAB=$TAB" -v DRESS="$D" -v SCAN=1 -v BETA0="$B" -v BETA1="$B" -v AK0=25 -v AK1=70 -v F0=22 -v NC22=46816 "${RD[@]}" -f "$E" 2>&1 | tr -d '\r' | grep "KP-CERT SCAN.*beta=0\.$(printf %04d $B) "; }
bis() { local D="$1" LO="$2" HI="$3" M r; r=$(sc $LO $D); echo "$r"; echo "$r" | grep -q "PASS for" || { echo "REFUSED lo"; return; }; r=$(sc $HI $D); echo "$r"; echo "$r" | grep -q "PASS for" && { echo "REFUSED hi"; return; }
  while [ $((HI - LO)) -gt 2 ]; do M=$(( (LO + HI) / 2 )); M=$(( M - M % 2 )); [ $M -le $LO ] && M=$((LO + 2)); r=$(sc $M $D); echo "$r"; if echo "$r" | grep -q "PASS for"; then LO=$M; else HI=$M; fi; done
  echo "READER-ROUTE dress=$D beta' = 0.$(printf %04d $LO) (PASS), refused at 0.$(printf %04d $HI)"; }
stamp START; md5sum "$E"
bis page 4000 4300
bis tree 4000 4300
stamp END
