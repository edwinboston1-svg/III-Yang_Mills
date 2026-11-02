#!/bin/bash
# M7b gate, part 2: the Villain two-step pinned objects with Fourier modes to |n| <= LM (c = 0 only), positivity of the truncated input checked,
# then the third (n = 2) and fourth (n = 4) steps on the positive input
cd "$(dirname "$0")"; R=../rec/gate2.2026-11-02a.txt; : > $R
posit() { gawk -v C="$1" 'BEGIN { n = split(C, a, ","); mn = 1e9; for (k = 0; k <= 20000; k++) { t = 3.141592653589793 * k / 20000; w = 1; for (i = 1; i <= n; i++) w += 2 * a[i] * cos(i * t); if (w < mn) { mn = w; tm = t } } printf "%.6f at theta %.4f", mn, tm }'; }
for BV in 4:10:6 8:14:8; do b=$(echo $BV | cut -d: -f1); nm=$(echo $BV | cut -d: -f2); lm=$(echo $BV | cut -d: -f3)
  for DAT in ordered cancel; do out=../rec/u1v_b${b}_${DAT}_n4_L${lm}.txt; U1_CMAX0=1 U1_VILLAIN=1 ./w2u1y.exe $b $nm $lm $DAT planar 4 | tr -d '\r' > $out
    co=""; for q in $(seq 1 $lm); do v=$(grep "U1-CLASS a=$q c=0 " $out | sed 's/.*= //; s/ [+-][0-9.e+-]* i$//; s/ +.*//'); co="$co${co:+,}$v"; done
    echo "V$b two-step $DAT (|n| <= $lm): a = $co; min of the truncated weight $(posit "$co")" >> $R
    for N in 2 4; do for D2 in ordered cancel random:1; do v=$(U1_CMAX0=1 U1_COEF=$co ./w2u1y.exe 1 $nm 2 $D2 planar $N | tr -d '\r' | grep -E "U1-CLASS a=1 c=0" | sed 's/.*= //'); echo "V$b-${DAT}in n=$N $D2: a1 = $v" >> $R; done; done
  done; done
echo "GATE2 DONE $(date)" >> $R
