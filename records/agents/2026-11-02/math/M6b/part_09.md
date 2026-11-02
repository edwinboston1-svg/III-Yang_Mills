
## 14. DATED CORRECTION TO 13.2 AND STAKES FOR RUN b (2026-11-02; written before `bin/m6b_thresholds_b.py` exists)

13.2's arithmetic is wrong as written: at κ = ln 91/(1 − 2/3) = 13.5326, 10κ + ln(80κ) = 135.326 + 6.987 = 142.31, not 145.6, so
log₁₀ β ≥ 61.81, not 63.2. Run b certifies it. STAKES: (b1) κ_KP(L = 3) = 3 ln 91 ∈ [13.532, 13.533], κ_KP(L → ∞) = ln 91;
(b2) the e^{5κ} row at κ_KP: log₁₀ β ≈ 61.81 (L = 3), ≈ 21.4 (L → ∞: 45.11 + ln 360.9 = 51.0 → 22.1);
(b3) E2's residual after Lemma M_w at L = 3, κ = 1: 2(14/15)·15 + 10 + ln 80 = 42.38 → log₁₀ β ≈ 18.41;
(b4) the same three rows at L = 3, κ = 13.5326 (Lemma KP's floor): E2-residual + e^{5κ}: 2(14/15)·15·13.5326 + 142.31 = 379.0 + 142.3
= 521.3 → ≈ 226.4 — ABOVE T18: with Lemma KP at L = 3 the residual base still binds unless L ≥ 11 (where it vanishes);
(b5) at L = 11 (residual 0, M ≥ L³ = 1331): κ_KP = ln 91/(9/11) = 5.513, e^{5κ} row 55.13 + ln 441.1 = 61.22 → 26.6; T18 at M = 1331
(p₀ = 10, r = 2) ≈ 151.6; T17 at M = 1331 ≈ 138; so T18 binds at ≈ 10^{151.6}.
