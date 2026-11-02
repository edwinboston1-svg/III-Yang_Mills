#!/bin/bash
# M7 KATs K1-K4 for the certificate copies (stakes in WORK.md section 2)
M7=/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/M7
cd "$M7" || exit 1
TAB="$(cat R2TAB.txt)"
COEFR=$(gawk -M -v PREC=256 -v B=0.25 -f bessel_coef.awk)
echo "K1/K2 COEF(0.25) = ${COEFR:0:80}..."
for C in kp_cert_table_wip.HEAD.awk kp_cert_m7.awk; do for T in 68 69; do
  printf "K12 %s tilt=%s/100: " "$C" "$T"
  AWKPATH="$M7" gawk -M -v BESSEL_LIB=1 -v GRADED=1 -v "R2TAB=$TAB" -v DRESS=page -v P=2500 -v Q=10000 -v AN=1 -v AD=1000 -v GN=6 -v GD=1 -v F0=20 -v TILTN=$T -v TILTD=100 -v COEF="$COEFR" -f "$C" 2>&1 | tr -d '\r' | grep 'KP-CERT dress' | sed 's/.*alpha=[0-9.]* -> //'
done; done
echo "K2 table mode (no COEF), patched copy, the gate's runbud cells:"
for T in 68 69; do printf "K2t tilt=%s/100: " $T; AWKPATH="$M7" gawk -M -v BESSEL_LIB=1 -v GRADED=1 -v "R2TAB=$TAB" -v DRESS=page -v P=2500 -v Q=10000 -v AN=1 -v AD=1000 -v GN=6 -v GD=1 -v F0=20 -v TILTN=$T -v TILTD=100 -f kp_cert_m7.awk 2>&1 | tr -d '\r' | grep 'KP-CERT dress' | sed 's/.*alpha=[0-9.]* -> //'; done
echo "K3 runcoef (gamma 6 page, P=2500, AN=1/1000), patched copy, tilt unset:"
AWKPATH="$M7" gawk -M -v BESSEL_LIB=1 -v DRESS=page -v P=2500 -v Q=10000 -v AN=1 -v AD=1000 -v GN=6 -v GD=1 -v F0=20 -v COEF="$COEFR" -f kp_cert_m7.awk 2>&1 | tr -d '\r' | tail -1 > k3.out
cat k3.out
grep -qF 'KP-CERT dress=page coef=supplied beta=supplied alpha=1/1000 gamma=6/1 F0=20: kappa_U in [0.019543, 0.019543] root in [0.019543, 0.019543] u in [0.06233787, 0.06233787] u~ in [0.06356816, 0.06356816] r_hi=0.320393 LHS in [0.0000033, 0.0000033] alpha=0.0009999 -> PASS mix=0.000000000000' k3.out && echo "K3 MET (coef.run's line byte for byte)" || echo "K3 NOT MET"
echo "K4 COEF = Bessel ratios rounded UP, LOCAL=1 table mode, page dressing, alpha scan 1..80:"
for BB in 0.4764 0.4766; do CU=$(gawk -M -v PREC=256 -v B=$BB -v UP=1 -f bessel_coef.awk)
  printf "K4 beta=%s: " $BB; AWKPATH="$M7" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v "R2TAB=$TAB" -v DRESS=page -v SCAN=1 -v BETA0=4764 -v BETA1=4764 -v AK0=1 -v AK1=80 -v F0=20 -v COEF="$CU" -f kp_cert_m7.awk 2>&1 | tr -d '\r' | grep 'KP-CERT SCAN' | head -1
done
