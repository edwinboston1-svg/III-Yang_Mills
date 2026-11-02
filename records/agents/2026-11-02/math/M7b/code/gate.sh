#!/bin/bash
# M7b gate runs: G1 (Wilson 1.2, P1 third/fourth steps) and G2 (Villain beta_V = 2, 4, 8: two-step pinned, then third/fourth steps)
cd "$(dirname "$0")"; R=../rec/gate.2026-11-02a.txt; : > $R
step() { tag=$1; co=$2; nmax=$3; for N in 2 4; do for DAT in ordered cancel random:1; do
  v=$(U1_COEF=$co ./w2u1x.exe 1 $nmax 2 $DAT planar $N | tr -d '\r' | grep -E "U1-CLASS a=1 c=0|U1-CLASS a=2 c=0" | sed 's/.*= //; s/ +.*//' | tr '\n' ' ')
  echo "$tag n=$N $DAT: a1 a2 = $v" >> $R; done; done; }
echo "### G1 Wilson beta = 1.2, P1 from the record's two-step pinned actions" >> $R
step "W1.2-ordin" "0.3010471616240,0.008580452309662" 4
step "W1.2-canin" "0.2231571957333,0.003298529697265" 4
echo "### G2 Villain: the two-step pinned objects" >> $R
for BV in 2:8 4:10 8:14; do b=${BV%%:*}; nm=${BV##*:}; for DAT in ordered cancel; do
  out=../rec/u1v_b${b}_${DAT}_n4.txt; U1_VILLAIN=1 ./w2u1x.exe $b $nm 2 $DAT planar 4 | tr -d '\r' > $out
  a1=$(grep "U1-CLASS a=1 c=0" $out | sed 's/.*= //; s/ +.*//'); a2=$(grep "U1-CLASS a=2 c=0" $out | sed 's/.*= //; s/ +.*//')
  echo "V$b two-step $DAT: a1 = $a1 a2 = $a2" >> $R
  step "V$b-${DAT}in" "$a1,$a2" 4
done; done
echo "GATE DONE $(date)" >> $R
