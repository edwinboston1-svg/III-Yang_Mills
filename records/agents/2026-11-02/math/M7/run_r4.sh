#!/bin/bash
# M7: THE EXIT FORM of RESULTS 4 (b) (COEF + HALF + WALL as the W2-CERT-CALL lines give them), the largest passing wall floor and half factor
# at the bare coefficients, and the U(1) control fed mechanically (stakes R4, U in WORK.md section 2); the patched copy throughout
M7=/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/M7
SG="/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/build/aperanton/surface-gas"
cd "$M7" || exit 1
TAB="$(cat R2TAB.txt)"; CERT=kp_cert_m7.awk
scanx(){ # $1 coef, $2 extra -v assignments (space-separated name=value) -> LOCAL page SCAN line
  local args=(); for kv in $2; do args+=(-v "$kv"); done
  AWKPATH="$M7" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v "R2TAB=$TAB" -v DRESS=page -v SCAN=1 -v BETA0=4764 -v BETA1=4764 -v AK0=1 -v AK1=80 -v F0=20 "${args[@]}" -v COEF="$1" -f $CERT 2>&1 | tr -d '\r' | grep -m1 'KP-CERT SCAN\|REFUSED'; }
onex(){ # $1 coef, $2 extra -> GRADED page alpha=1/1000 one-point line
  local args=(); for kv in $2; do args+=(-v "$kv"); done
  AWKPATH="$M7" gawk -M -v BESSEL_LIB=1 -v GRADED=1 -v "R2TAB=$TAB" -v DRESS=page -v P=4764 -v Q=10000 -v AN=1 -v AD=1000 -v GN=6 -v GD=1 -v F0=20 "${args[@]}" -v COEF="$1" -f $CERT 2>&1 | tr -d '\r' | grep -m1 'KP-CERT dress\|REFUSED'; }
bisw(){ # largest WALLN/10000 passing (LOCAL page scan), on [0, 10000]
  local lo=0 hi=10000 mid; scanx "$1" "" | grep -q 'PASS for alpha' || { echo "bare-FAILS"; return; }
  while [ $((hi - lo)) -gt 1 ]; do mid=$(( (lo + hi) / 2 )); if [ $mid -eq 0 ]; then lo=0; break; fi; if scanx "$1" "WALLN=$mid WALLD=10000" | grep -q 'PASS for alpha'; then lo=$mid; else hi=$mid; fi; done; echo "$lo"; }
bish(){ # largest HALFN/10000 passing (LOCAL page scan), on [10000, 40000]
  local lo=10000 hi=40000 mid
  while [ $((hi - lo)) -gt 1 ]; do mid=$(( (lo + hi) / 2 )); if scanx "$1" "HALFN=$mid HALFD=10000" | grep -q 'PASS for alpha'; then lo=$mid; else hi=$mid; fi; done; echo "$lo"; }
call_of(){ # the HALF and WALL of the W2-CERT-CALL line in file $1
  grep -m1 'W2-CERT-CALL' "$1" | tr -d '\r' | sed 's/.*HALFN=\([0-9]*\) HALFD=\([0-9]*\) WALLN=\([0-9]*\) WALLD=\([0-9]*\).*/HALFN=\1 HALFD=\2 WALLN=\3 WALLD=\4/'; }
declare -A MODF; MODF[w2n4_W2L2.2026-11-01a.ordered]="$SG/w2n4_W2L2_modes.2026-11-01a.ordered.txt"; MODF[w2n4_W2L2.2026-11-01a.cancel]="$SG/w2n4_W2L2_modes.2026-11-01a.cancel.txt"
MODF[w2n4_W3L2.2026-11-01b.ordered]="$M7/w2n4_W3L2_modes.m7.ordered.txt"; MODF[w2n4_W3L2.2026-11-01b.cancel]="$M7/w2n4_W3L2_modes.m7.cancel.txt"
for r in w2n4_W2L2.2026-11-01a.ordered w2n4_W2L2.2026-11-01a.cancel w2n4_W3L2.2026-11-01b.ordered w2n4_W3L2.2026-11-01b.cancel; do
  CZ=$(tr -d '\r' < "$SG/$r.txt" | gawk -M -v PREC=200 -f coef_from_record.awk)
  HW=$(call_of "${MODF[$r]}"); H=$(echo "$HW" | sed 's/ WALLN.*//'); W=$(echo "$HW" | sed 's/.*\(WALLN\)/\1/')
  echo "=== $r  [$HW] (from ${MODF[$r]##*/})"
  echo "R4 COEF+HALF+WALL LOCAL page: $(scanx "$CZ" "$HW")"
  echo "R4 COEF+HALF+WALL GRADED a=1/1000: $(onex "$CZ" "$HW")"
  echo "R4 COEF+HALF only LOCAL page: $(scanx "$CZ" "$H")"
  echo "R4 COEF+WALL only LOCAL page: $(scanx "$CZ" "$W")"
  echo "R4 COEF+WALL only GRADED a=1/1000: $(onex "$CZ" "$W")"
  echo "WMAX largest wall floor passing (x1/10000, bare COEF, LOCAL page scan): $(bisw "$CZ")"
  echo "HMAX largest half factor passing (x1/10000, bare COEF, LOCAL page scan): $(bish "$CZ")"
done
echo "=== U(1) control, beta = 1.2, two steps, fed MECHANICALLY into the SU(2) certificate (a category crossing, labelled as such):"
for d in ordered cancel; do
  F="$SG/w2_u1n4L2.2026-11-01a.${d}_b1.2.txt"
  e1=$(tr -d '\r' < "$F" | grep 'U1-CLASS a=1 c=0 ' | gawk '{print $7}'); e2=$(tr -d '\r' < "$F" | grep 'U1-CLASS a=2 c=0 ' | gawk '{print $7}')
  CU=$(gawk -M -v PREC=200 -v e1="$e1" -v e2="$e2" 'BEGIN { D = 1000000000000; n1 = int(e1 * D) + 1; n2 = int(e2 * D) + 1; s = n1 "/" D "," n2 "/" D; for (j = 3; j <= 16; j++) s = s ",0/" D; print s }')
  echo "U1 $d E[e^{iPhi}]=$e1 E[e^{2iPhi}]=$e2 (d = 1: a'_1 = E, a'_2 = E2 in the u and next slots)"
  echo "U1 $d LOCAL page: $(scanx "$CU" "")"
  echo "U1 $d GRADED a=1/1000: $(onex "$CU" "")"
  CH=$(gawk -M -v PREC=200 -v e1="$e1" -v e2="$e2" 'BEGIN { D = 1000000000000; n1 = int(e1 / 2 * D) + 1; n2 = int(e2 / 3 * D) + 1; s = n1 "/" D "," n2 "/" D; for (j = 3; j <= 16; j++) s = s ",0/" D; print s }')
  echo "U1 $d with SU(2)'s d_j division (u = E/2, next = E2/3) LOCAL page: $(scanx "$CH" "")"
done
