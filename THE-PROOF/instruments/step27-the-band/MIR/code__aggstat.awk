# aggstat.awk -- the measure-weighted aggregates over agg_rows.txt (fields: 4 eA, 6 eB, 8 eAB, 10 e1A, 12 e1B, 14 c_mean, 16 cA, 18 cB)
{ n++; eA[n] = $4; eB[n] = $6; eAB[n] = $8; cm[n] = $14; sA += $4; sB += $6; sAA += $4*$4; sBB += $6*$6; sAxB += $4*$6
  scm += $14; sAcm += $4*$14; scm2 += $14*$14; if ($14 > 0.5) nal++; if ($4/2 > 0.118 || $6/2 > 0.118) nbig++
  if (n == 1 || $4 > mx) mx = $4; if (n == 1 || $4 < mn) mn = $4; if ($4 < 0) nneg++; if ($6 < 0) nneg++; sabs += ($4 < 0 ? -$4 : $4) + ($6 < 0 ? -$6 : $6) }
END { mA = sA/n; mB = sB/n; vA = sAA/n - mA*mA; vB = sBB/n - mB*mB; cAB = sAxB/n - mA*mB; mconn = 0; for (i = 1; i <= n; i++) mconn += eAB[i] - eA[i]*eB[i]; mconn /= n
  den = scm2/n - (scm/n)^2; bet = (den > 0 ? (sAcm/n - mA*scm/n)/den : 0)
  printf "AGG n=%d data (W2L2, beta=2.2, typical heat-bath outsides)\n", n
  printf "AGG mean_w E[chi(A)|w] = %.5f +- %.5f  mean_w E[chi(B)|w] = %.5f +- %.5f  (the true marginal, MC; a'_1/2 = half)\n", mA, sqrt(vA/n), mB, sqrt(vB/n)
  printf "AGG Var_w E[chi(A)|w] = %.5f  Var_w E[chi(B)|w] = %.5f  (of Var chi_1/2 ~ 1)\n", vA, vB
  printf "AGG sd_w a'_1/2(A) = %.5f ; range E[chi(A)|w] = [%.5f, %.5f] ; mean |a'_1/2| over A and B = %.5f ; negative entries %d of %d\n", sqrt(vA)/2, mn, mx, sabs/(4*n), nneg+0, 2*n
  printf "AGG E_w Cov(chiA,chiB|w) = %.6e  Cov_w(E[chiA|w],E[chiB|w]) = %.6e  UNCONDITIONAL Cov(chiA,chiB) = %.6e\n", mconn, cAB, mconn + cAB
  printf "AGG slope of E[chi(A)|w] on c_mean = %.5f ; data with c_mean > 0.5: %d ; data with a'_1/2 > 0.118: %d\n", bet, nal+0, nbig+0 }
