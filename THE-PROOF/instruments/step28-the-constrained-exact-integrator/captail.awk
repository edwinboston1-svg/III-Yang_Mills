# captail.awk -- the per-factor relative sup-norm tail of a Wilson-type weight e^{x * (1/2)tr U} = sum_k (k+1) (I_{k+1}(x)/I_1(x)) * (2 I_1/x) chi_k
# truncated at spin k <= K: tail_x(K) = sum_{k>K} (k+1)^2 I_{k+1}(x) / sum_{k>=0} (k+1)^2 I_{k+1}(x)   (|chi_k| <= k+1, the sup at the identity)
# and the compounded bound of the cell operator's relative truncation error, sum_i tail_{x_i}(K) over the cell's factors.
# Modified Bessel I_n(x) by its power series (x <= 30, 120 terms; the terms fall as (x/2)^{2m}/(m!(m+n)!)).
function In(n, x,   m, t, s, k) { t = 1; for (k = 1; k <= n; k++) t *= (x/2)/k; s = t; for (m = 1; m <= 120; m++) { t *= (x/2)*(x/2)/(m*(m+n)); s += t; if (t < 1e-30*s) break } return s }
function tail(x, K,   k, tot, tl, v) { tot = 0; tl = 0; for (k = 0; k <= 60; k++) { v = (k+1)*(k+1)*In(k+1, x); tot += v; if (k > K) tl += v; if (v < 1e-40*tot && k > K+5) break } return tl/tot }
BEGIN {
  printf("x (the factor's coupling beta*|S| or beta) \\ K:");
  split("2 3 4 5 6 8 10 12 14", Ks, " "); for (i = 1; i <= 9; i++) printf("  K=%-2d", Ks[i]); printf("\n");
  split("2.2 4.4 6.6 8.8 11 22", xs, " ");
  for (j = 1; j <= 6; j++) { x = xs[j]; printf("x = %5.1f  ", x); for (i = 1; i <= 9; i++) printf(" %.1e", tail(x, Ks[i])); printf("\n") }
  # the strip cell at the aligned exterior (beta = 2.2): 2 face plaquettes at x = 2.2 (the cut's), the cell's plaquettes and the seven
  # surviving links' staple weights at x = 2.2*|S| with |S| = 5 (private links, five identity staples), 4 (shared), the paired survivors at
  # up to 2.2*(5+5) -- the census is read off the engine; here the generic counts: 4 plaquettes (x=2.2), 7 links at x=11, 3 paired at x=22.
  printf("\nthe compounded relative tail of the aligned cell, sum over factors (4 plaquettes at 2.2, 7 links at 11, 3 paired survivors at 22):\n");
  for (i = 1; i <= 9; i++) { K = Ks[i]; s = 4*tail(2.2,K) + 7*tail(11,K) + 3*tail(22,K); printf("  K=%-2d  sum = %.3f   against the non-singlet gap's |lambda2|/lambda1 = 1/51.75 = %.4f\n", K, s, 1/51.751769) }
  printf("\nthe same at a Haar exterior, every staple sum of norm about 1.5 (x = 3.3) on 10 links, 4 plaquettes at 2.2:\n");
  for (i = 1; i <= 9; i++) { K = Ks[i]; s = 4*tail(2.2,K) + 10*tail(3.3,K); printf("  K=%-2d  sum = %.3f   against |lambda2|/lambda1 at the slowest Haar datum = 1/6.90 = %.4f\n", K, s, 1/6.90) }
  printf("\nKAT: I_1(2.2)=%.6f (table 1.914089), I_2(2.2)/I_1(2.2)=%.9f (the engine's 0.464479025), tail_2.2(4)*tot/I_1 = %.4f (RESULTS 5: 0.0688)\n", In(1,2.2), In(2,2.2)/In(1,2.2), tail(2.2,4)*5.3)
}
