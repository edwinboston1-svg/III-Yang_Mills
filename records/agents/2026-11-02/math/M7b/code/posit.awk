# min over phi in [0, pi] of the truncated SU(2) Wilson weight w_W(phi) = sum_{s<=W} (s+1) a_s sin((s+1)phi)/sin(phi), a_s = I_{s+1}(b)/I_1(b),
# on a 20001-point grid (plus phi = pi exactly), against the exact w(phi) = b e^{b cos phi}/(2 I_1(b))
function I(n,x,  k,t,s){t=(x/2)^n; for(k=1;k<=n;k++) t/=k; s=t; for(k=0;k<400;k++){t*=(x/2)*(x/2)/((k+1)*(k+n+1)); s+=t} return s}
BEGIN { split(BS, bl, ","); for (bi in bl) { b = bl[bi] + 0; I1 = I(1, b); for (s = 0; s <= 12; s++) a[s] = I(s+1, b) / I1
  for (W = 2; W <= 8; W++) { mn = 1e9; amin = 0; for (k = 0; k <= 20000; k++) { ph = 3.141592653589793 * k / 20000; w = 0
      for (s = 0; s <= W; s++) w += (s+1) * a[s] * ((k == 0) ? (s+1) : ((k == 20000) ? (s+1) * ((s % 2) ? -1 : 1) : sin((s+1)*ph)/sin(ph)))
      if (w < mn) { mn = w; amin = ph } }
    printf "POSIT beta=%s W=%d: min_phi w_W = %+.6f at phi = %.4f (exact w there %.6f; w(pi) exact %.6f) %s\n", b, W, mn, amin, b*exp(b*cos(amin))/(2*I1), b*exp(-b)/(2*I1), (mn > 0 ? "POSITIVE" : "SIGNED") } } }
