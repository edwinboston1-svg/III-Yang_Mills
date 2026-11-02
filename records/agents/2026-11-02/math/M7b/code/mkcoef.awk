# build a 16-entry COEF list from up to 16 decimals (spin j2 = 1..16), each rounded UP at 10^-12 (zeros stay zero)
BEGIN { n = split(V, x, ","); out = ""; for (j = 1; j <= 16; j++) { v = (j <= n) ? x[j] + 0 : 0; m = (v > 0) ? int(v * 1e12) + 1 : 0; out = out (j > 1 ? "," : "") m "/1000000000000" } print out }
