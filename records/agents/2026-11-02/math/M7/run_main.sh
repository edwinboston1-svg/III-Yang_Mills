#!/bin/bash
# M7 main certificate runs (stakes T1, T2, E in WORK.md section 2); the patched copy kp_cert_m7.awk throughout
M7=/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/M7
SG="/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/build/aperanton/surface-gas"
cd "$M7" || exit 1
TAB="$(cat R2TAB.txt)"; CERT=kp_cert_m7.awk
scan(){ # $1 dress, $2 coef, $3 tilt numerator (/1000) -> the SCAN line (LOCAL table mode, alpha 1..80 e-4)
  AWKPATH="$M7" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v "R2TAB=$TAB" -v DRESS="$1" -v SCAN=1 -v BETA0=4764 -v BETA1=4764 -v AK0=1 -v AK1=80 -v F0=20 -v TILTN="$3" -v TILTD=1000 -v COEF="$2" -f $CERT 2>&1 | tr -d '\r' | grep -m1 'KP-CERT SCAN\|REFUSED'; }
one(){ # $1 mode (GRADED|LOCAL), $2 coef, $3 tilt (/1000), $4 AN (/1000) -> the one-point line
  AWKPATH="$M7" gawk -M -v BESSEL_LIB=1 -v $1=1 -v "R2TAB=$TAB" -v DRESS=page -v P=4764 -v Q=10000 -v AN="$4" -v AD=1000 -v GN=6 -v GD=1 -v F0=20 -v TILTN="$3" -v TILTD=1000 -v COEF="$2" -f $CERT 2>&1 | tr -d '\r' | grep -m1 'KP-CERT dress\|REFUSED'; }
bis_one(){ # bisect the tilt (units 1/1000) on [0, 3000] for one-point mode $1 at AN=$3/1000; prints the PASS end
  local lo=0 hi=3000 mid; one $1 "$2" 0 $3 | grep -q -- '-> PASS' || { echo "tilt0-FAILS"; return; }
  one $1 "$2" $hi $3 | grep -q -- '-> PASS' && { echo ">=3000"; return; }
  while [ $((hi - lo)) -gt 1 ]; do mid=$(( (lo + hi) / 2 )); if one $1 "$2" $mid $3 | grep -q -- '-> PASS'; then lo=$mid; else hi=$mid; fi; done; echo "$lo"; }
bis_scan(){ # bisect the tilt for the LOCAL page SCAN (pass = some alpha in 1..80e-4 passes)
  local lo=0 hi=3000 mid; scan page "$2" 0 | grep -q 'PASS for alpha' || { echo "tilt0-FAILS"; return; }
  while [ $((hi - lo)) -gt 1 ]; do mid=$(( (lo + hi) / 2 )); if scan page "$2" $mid | grep -q 'PASS for alpha'; then lo=$mid; else hi=$mid; fi; done; echo "$lo"; }
for r in w2n4_W2L2.2026-11-01a.ordered w2n4_W2L2.2026-11-01a.cancel w2n4_W3L2.2026-11-01b.ordered w2n4_W3L2.2026-11-01b.cancel; do
  CZ=$(tr -d '\r' < "$SG/$r.txt" | gawk -M -v PREC=200 -f coef_from_record.awk)
  CS=$(tr -d '\r' < "$SG/$r.txt" | gawk -M -v PREC=200 -v MODE=sat -f coef_from_record.awk)
  echo "=== $r  COEF(zero tail) = ${CZ:0:60}..."
  echo "T1 LOCAL page : $(scan page "$CZ" 0)"
  echo "T1 LOCAL tree : $(scan tree "$CZ" 0)"
  echo "T1 GRADED a=1/1000: $(one GRADED "$CZ" 0 1)"
  echo "T1 LOCAL  a=4/1000: $(one LOCAL "$CZ" 0 4)"
  echo "T2 sat tail LOCAL page: $(scan page "$CS" 0)"
  echo "T2 sat tail GRADED a=1/1000: $(one GRADED "$CS" 0 1)"
  echo "E GRADED page a=1/1000 eps (x1/1000, PASS end) zero tail: $(bis_one GRADED "$CZ" 1)"
  echo "E GRADED page a=4/1000 eps (x1/1000, PASS end) zero tail: $(bis_one GRADED "$CZ" 4)"
  echo "E LOCAL page alpha-scanned eps (x1/1000, PASS end) zero tail: $(bis_scan x "$CZ")"
  echo "E GRADED page a=1/1000 eps (x1/1000) sat tail: $(bis_one GRADED "$CS" 1)"
done
