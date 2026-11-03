# z2gauge_crt.awk -- the Chinese remainder reconstruction of z2gauge_dual's residues, and the gauge readings.
#   gawk -M -f z2gauge_crt.awk rec1 rec2 ... (one record per modulus, the same tori and pairs; the modulus read from each DUAL-ISING line)
#   Every quantity Q (Z and N_k per sector and t1) is reconstructed by Garner's algorithm as the least non-negative residue modulo the
#   product of the moduli (every quantity is a positive integer below 2^290; the product must exceed that -- checked and printed).
#   Then: Zsum = Σ_τ Z_τ, Nk = Σ_τ N_k,τ, the gauge correlators <U_p U_q>_k = N_k / (4 Zsum) exactly, and the positivity form
#   on the pairs (0: θp_a·p_a, 1: θp_a·p_b, 2: θp_b·p_a, 3: θp_b·p_b): <(θF)F> = (N0 − N1 − N2 + N3)/(4 Zsum), its sign the verdict.
BEGIN { PREC = 2048; nm = 0 }
/^DUAL-ISING/ { nm++; for (i = 1; i <= NF; i++) if ($i ~ /^prime=/) { sub(/prime=/, "", $i); M[nm] = $i + 0 }; next }
/^SECTOR/ {
  # a field reads key=value where the key itself may hold "=" inside parentheses (Z(t1=0)=...): split at the LAST "="
  for (i = 1; i <= NF; i++) if ($i ~ /=/) { n = split($i, kv, "="); val = kv[n] + 0; key = substr($i, 1, length($i) - length(kv[n]) - 1)
    if (key == "t2") t2 = val; else if (key == "t3") t3 = val; else R[nm, t2, t3, key] = val }
  NS[nm]++
  next
}
END {
  if (nm < 1) { print "no records"; exit 1 }
  # A RECORD IS FOUR SECTORS OR IT IS NOT A RECORD (law 10): a run still computing has written its first sector and the sum
  # over twists would silently take the missing three as zero -- a clean-looking total from an incomplete world. Refuse by name.
  for (i = 1; i <= nm; i++) if (NS[i] != 4) { printf "CRT-REFUSED record %d (prime %s) holds %d of 4 twist sectors -- still computing or truncated\n", i, M[i], NS[i] + 0; exit 2 }
  prod = 1; for (i = 1; i <= nm; i++) prod *= M[i]
  printf "CRT moduli=%d product_bits=%.1f\n", nm, log(prod)/log(2)
  # the keys present in the first record
  for (k in R) { split(k, p, SUBSEP); if (p[1] == 1) KEYS[p[2] SUBSEP p[3] SUBSEP p[4]] = 1 }
  for (kk in KEYS) {
    split(kk, p, SUBSEP); t2 = p[1]; t3 = p[2]; key = p[3]
    # Garner: x ≡ R[i] (mod M[i]) built incrementally
    x = R[1, t2, t3, key]; mod = M[1]
    for (i = 2; i <= nm; i++) {
      r = R[i, t2, t3, key]; m = M[i]
      # solve x + mod*t ≡ r (mod m): t = (r - x) * inv(mod) mod m
      inv = modinv(mod % m, m); t = ((r - x % m) % m + m) % m * inv % m
      x = x + mod * t; mod = mod * m
    }
    X[t2, t3, key] = x
  }
  Zsum = 0; for (t2 = 0; t2 < 2; t2++) for (t3 = 0; t3 < 2; t3++) { Zsum += X[t2, t3, "Z(t1=0)"] + X[t2, t3, "Z(t1=1)"] }
  printf "GAUGE-Z Zsum=%s (the surface sum times 2^{NL+1}, every sector)\n", Zsum
  for (k = 0; k < 4; k++) {
    n = 0; for (t2 = 0; t2 < 2; t2++) for (t3 = 0; t3 < 2; t3++) { n += X[t2, t3, "N" k "(t1=0)"] + X[t2, t3, "N" k "(t1=1)"] }
    NK[k] = n
    printf "GAUGE-CORR k=%d <U_p U_q> = %s / (4 * %s) = %.12f\n", k, n, Zsum, n / (4 * Zsum)
  }
  form = NK[0] - NK[1] - NK[2] + NK[3]
  printf "GAUGE-RPFORM <(theta F) F> = (N0 - N1 - N2 + N3)/(4 Zsum) = %s / %s = %.12f sign=%s\n", form, 4 * Zsum, form / (4 * Zsum), (form < 0 ? "NEGATIVE" : (form > 0 ? "POSITIVE" : "ZERO"))
  printf "GAUGE-END\n"
}
function modinv(a, m,   g, x, y, q, t, r, nr, x0, x1) {
  # extended Euclid, a and m coprime
  r = m; nr = a % m; x0 = 0; x1 = 1
  while (nr != 0) { q = int(r / nr); t = r - q * nr; r = nr; nr = t; t = x0 - q * x1; x0 = x1; x1 = t }
  if (r != 1) { print "modinv: not coprime" > "/dev/stderr"; exit 1 }
  return (x0 % m + m) % m
}
