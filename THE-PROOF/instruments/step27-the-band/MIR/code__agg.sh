#!/bin/bash
# agg.sh -- per-datum readings of the full W2L2 records and the measure-weighted aggregates (law of total covariance), with envalign
MIR=/c/Users/EDWINB~1/AppData/Local/Temp/the author/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/MIR
cd "$MIR/rec"
for f in full_W2L2_*.txt; do grep -q W2-DONE "$f" || continue; b=${f#full_W2L2_}; d="$b"
  env=$(gawk -f "$MIR/code/envalign.awk" outlist_planar_n4.txt "$d" | tail -1)
  gawk -v F="$b" -v ENV="$env" '/W2-CLASS a=1 c=0/{eA=$7} /W2-CLASS a=0 c=1/{eB=$7} /W2-CLASS a=1 c=1/{eAB=$7} /W2-CLASS a=2 c=0/{e1A=$7} /W2-CLASS a=0 c=2/{e1B=$7}
    END{split(ENV,E," "); split(E[2],cm,"="); split(E[5],ca,"="); split(E[6],cb,"="); printf "ROW %s eA %.6e eB %.6e eAB %.6e e1A %.6e e1B %.6e cmean %s cA %s cB %s\n", F, eA, eB, eAB, e1A, e1B, cm[2], ca[2], cb[2]}' "$f"; done > agg_rows.txt
gawk '{n++; eA[n]=$3; eB[n]=$5; eAB[n]=$7; cm[n]=$13; sA+=$3; sB+=$5; sAB+=$7; sAA+=$3*$3; sBB+=$5*$5; sAxB+=$3*$5; scm+=$13; sAcm+=$3*$13; scm2+=$13*$13; if ($13>0.5) nal++; if ($3/2>0.118 || $5/2>0.118) nbig++; mx = ($3>mx? $3: mx); mn=($3<mn?$3:mn)}
  END{mA=sA/n; mB=sB/n; vA=sAA/n-mA*mA; vB=sBB/n-mB*mB; cAB=sAxB/n-mA*mB; mconn=0; for(i=1;i<=n;i++) mconn+=eAB[i]-eA[i]*eB[i]; mconn/=n
    beta=(sAcm/n - mA*scm/n)/(scm2/n-(scm/n)^2)
    printf "AGG n=%d data\n", n
    printf "AGG  mean_w E[chi(A)|w] = %.5f  mean_w E[chi(B)|w] = %.5f   (true marginal estimates; a_1/2 = half)\n", mA, mB
    printf "AGG  Var_w E[chi(A)|w] = %.5f  Var_w E[chi(B)|w] = %.5f  (of Var chi = 1 - (E chi)^2 ~ 1: the share any outside datum moves one coarse loop)\n", vA, vB
    printf "AGG  sd_w a1/2(A) = %.5f  range of E[chi(A)|w] = [%.5f, %.5f]\n", sqrt(vA)/2, mn, mx
    printf "AGG  E_w Cov(chiA,chiB|w) = %.6e   Cov_w(E[chiA|w],E[chiB|w]) = %.6e   UNCONDITIONAL Cov(chiA,chiB) = %.6e\n", mconn, cAB, mconn + cAB
    printf "AGG  regression slope of E[chi(A)|w] on c_mean = %.5f ; data with c_mean > 0.5: %d ; data with |a1/2| > 0.118: %d\n", beta, nal+0, nbig+0 }' agg_rows.txt
