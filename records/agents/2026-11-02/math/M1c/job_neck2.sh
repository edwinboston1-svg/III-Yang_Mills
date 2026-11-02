#!/bin/bash
# job_neck.sh -- THE NECK'S PRICE: the largest multiplier (1 + eps) on the walls' activity z1 (Z1N/Z1D), and on every decoration activity per
# plaquette (z1 and each piece's z(s) by (1+eps)^s: Z1 and ZP together), at which each certified verdict still PASSES (a margin, not a bound).
# Engine: kp_cert_m1c_ref.awk, a frozen copy of kp_cert_m1c.awk (OMEGA off). Single-beta scans with alpha in [AK0, AK1] (1e-4 units).
. "/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/M1c/m1c_lib.sh"
E="$W/kp_cert_m1c_ref.awk"
sc() { local B="$1" D="$2" F="$3" K0="$4" K1="$5"; shift 5
  AWKPATH="$AWKP" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v "R2TAB=$TAB" -v DRESS="$D" -v SCAN=1 -v BETA0="$B" -v BETA1="$B" -v AK0="$K0" -v AK1="$K1" -v F0="$F" -v NC22=46816 "$@" -f "$E" 2>&1 | tr -d '\r' | grep "KP-CERT SCAN.*beta=0\.$(printf %04d $B) "; }
# bisect on eps in units of 1e-5 over [0, HI]: MODE w (walls only) or a (all decorations)
bise() { local B="$1" D="$2" F="$3" K0="$4" K1="$5" MODE="$6"; shift 6; local lo=0 hi=20000 m r
  while [ $((hi - lo)) -gt 10 ]; do m=$(( (lo + hi) / 2 ))
    if [ "$MODE" = w ]; then r=$(sc "$B" "$D" "$F" "$K0" "$K1" "$@" -v Z1N=$((100000 + m)) -v Z1D=100000)
    else r=$(sc "$B" "$D" "$F" "$K0" "$K1" "$@" -v Z1N=$((100000 + m)) -v Z1D=100000 -v ZPN=$((100000 + m)) -v ZPD=100000); fi
    if echo "$r" | grep -q "PASS for"; then lo=$m; else hi=$m; fi; done
  echo "NECK-PRICE beta=0.$B dress=$D F0=$F mode=$MODE: PASS at eps = $lo e-5, refused at eps = $hi e-5"; }
stamp START; md5sum "$E"
U2=(-v EVENTAIL=1 -v UNCOND=1 -v U12=1 -v NCSIG=1); CO=(-v EVENTAIL=1 -v NCSIG=1)
echo "== controls: eps = 0 must PASS (the record's verdicts)"
sc 3650 page 22 30 60 "${U2[@]}" -v DRESSREF=1; sc 5100 page 22 25 50 "${CO[@]}"; sc 4764 page 20 30 55
echo "== refined bracket: the step above each threshold of record"; for x in "3652 page 22 U" "3658 tree 22 U" "4766 page 20 R" "4818 tree 20 R" "5102 page 22 C" "5200 tree 22 C"; do set -- $x; if [ $4 = U ]; then sc $1 $2 $3 10 120 "${U2[@]}" -v DRESSREF=1; elif [ $4 = C ]; then sc $1 $2 $3 10 120 "${CO[@]}" -v DRESSREF=1; else sc $1 $2 $3 10 120 -v DRESSREF=1; fi; done
bise 3650 page 22 30 60 w "${U2[@]}" -v DRESSREF=1
bise 3650 page 22 30 60 a "${U2[@]}" -v DRESSREF=1
bise 5100 page 22 25 50 w "${CO[@]}" -v DRESSREF=1
bise 5100 page 22 25 50 a "${CO[@]}" -v DRESSREF=1
bise 4764 page 20 30 55 w -v DRESSREF=1
bise 4764 page 20 30 55 a -v DRESSREF=1
stamp END
