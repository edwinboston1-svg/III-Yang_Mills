#!/bin/bash
. "/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/M1c/m1c_lib.sh"
stamp START; md5sum "$W/kp_cert_m1c.awk" "$M1/kp_cert_m1.awk" "$W/r2tab_g.txt" "$AWKP/aperanton_bessel_cert.awk"
U2=(-v EVENTAIL=1 -v UNCOND=1 -v U12=1 -v NCSIG=1); CO=(-v EVENTAIL=1 -v NCSIG=1)
echo "== (Omega-d) CONTROLS, OMEGA unset"
for D in page tree; do a=$(point "$M1/kp_cert_m1.awk" 4764 44 $D 20); b=$(point "$W/kp_cert_m1c.awk" 4764 44 $D 20); echo "M1   $a"; echo "M1C  $b"; [ "$a" = "$b" ] && echo "CTL $D 0.4764: CHARACTER-IDENTICAL" || echo "CTL $D 0.4764: DIFFERS"; done
a=$(point "$M1/kp_cert_m1.awk" 3650 44 page 22 "${U2[@]}"); b=$(point "$W/kp_cert_m1c.awk" 3650 44 page 22 "${U2[@]}"); [ "$a" = "$b" ] && echo "CTL page 0.3650 U'': CHARACTER-IDENTICAL" || echo "CTL page 0.3650 U'': DIFFERS"
echo "== (Omega-e)/(Omega-f) POINT LINES with OMEGA=1 NOM=21"
point "$W/kp_cert_m1c.awk" 4764 44 page 20 -v OMEGA=1 | grep -E "dress|OMEGA"
point "$W/kp_cert_m1c.awk" 3650 44 page 22 "${U2[@]}" -v OMEGA=1 | grep -E "dress|OMEGA"
point "$W/kp_cert_m1c.awk" 5100 34 page 22 "${CO[@]}" -v OMEGA=1 | grep -E "dress|OMEGA"
point "$W/kp_cert_m1c.awk" 5198 39 tree 22 "${CO[@]}" -v OMEGA=1 | grep -E "dress|OMEGA"
echo "== (Omega-f) THE VERDICTS with the class included (OMEGA=1, NOM=21)"
for x in "page 3650" "page 3652" "tree 3656" "tree 3658"; do set -- $x; scan1 "$W/kp_cert_m1c.awk" $2 $1 22 "${U2[@]}" -v OMEGA=1; done
for x in "page 4764" "page 4766" "tree 4816" "tree 4818"; do set -- $x; scan1 "$W/kp_cert_m1c.awk" $2 $1 20 -v OMEGA=1; done
for x in "page 5100" "page 5102" "tree 5198" "tree 5200"; do set -- $x; scan1 "$W/kp_cert_m1c.awk" $2 $1 22 "${CO[@]}" -v OMEGA=1; done
echo "== (Omega-g) THE PRICE OF n_Omega at 0.5100 page, alpha = 0.0034 (the point line's T_hi and verdict at each NOM)"
for n in 6 8 10 11 12 13 14 16 18 21; do echo "NOM=$n $(point "$W/kp_cert_m1c.awk" 5100 34 page 22 "${CO[@]}" -v OMEGA=1 -v NOM=$n | grep -E "dress|OMEGA" | sed 's/.*LHS in/LHS in/' | tr '\n' ' ')"; done
stamp END
