
### 3.6 DATED PRECISION TO 3.1/3.3 (2026-11-02, before any run)

(a) Lemma SD (iii) holds verbatim for any polymer functional Ψ in place of |S|: if every nonvanishing tuple satisfies
Ψ(∪c(ω_i)) ≤ N₀ + a⁻¹Σ_i ln w(ω_i), then Σ_S e^{aΨ(S)}‖F_S‖ ≤ e^{aN₀}K_Φ(1 − eB_w/R)⁻¹ (same proof). It is used below with
Ψ(S) = d_k(base ∪ S) − d_k(base) (decay in Bałaban's linear size, via the UPPER COMPANION of 3.4) and with Ψ = number of cubes.
(b) The sentence "w(ω) ≥ (1+η′)^{|c(ω)|} with 1 + η′ := e^{a/2^d}…" at the end of the proof of Lemma G is replaced by: by Lemma G (i)–(ii),
|c(ω)| ≤ 2^d + a⁻¹ln w(ω); so for any η′ with ln(1+η′) ≤ a the weight w′ := (1+η′)^{2^d}w satisfies w′(ω) ≥ (1+η′)^{|c(ω)|}, and
B_{w′} = (1+η′)^{2^d}B_w. Lemma SD's real-analyticity needs only SOME η′ > 0 with e(1+η′)^{2^d}B_w < R; it costs nothing in the bounds.

## 4. STAKES FOR RUN a (written before `bin/m6b_thresholds.py` exists; nothing here edited after)

Conventions as M6 unless stated: κ = 1, γ₂ = 1, every existential prefactor P = 2E₀C₁M^q/(α₄α₆) = 1, d = 4.

(A) THE RUN REQUESTED — M6's chain with the C₂κ₁ term removed, every other row unchanged:
 A1 T11′ = CMP 116 (2.28)+(2.31) with C₂κ₁ → 0: log β ≥ 10κ + ln(80κ) = 14.382, log₁₀ β ≥ 6.246.
 A2 the same with q ≥ 8 at M = 27 (M⁸ inside P, squared): log₁₀ β ≥ 29.15.
 A3 T13′ (complete model, δ_k in (2.28), e^{5κ} carried): p₀ = 10 → log₁₀ β ≈ 44.6; p₀ = 13 → ≈ 60.0.
 A4 T14′ (LFR II (1.93) with T11′): 2·24κ + ln 80 = 52.38 → 22.75.
 A5–A7 unchanged rows: T15 38.31 (p₀ = 10); T17 101.87 (M = 27, r = 2); T18 111.09 (M = 27, p₀ = 10, r = 2).
 STAKE: the new bottleneck of M6's table is T18, log₁₀ β_B ≥ 111.09 (as M6 computed it).
(B) THE BASE ROW (my reading of (1.24)–(1.29), §2 and §3.4), at κ = 1:
 B1 d_k(□̃⁵) ≥ 14625/16 = 914.0625 exactly.
 B2 Bałaban's printed chain with Lemma 1's constant carried: C₂κ₁ ≥ 16κ₁ + κ₁d₀/16 + (1 − 2δ)κd₀ at κ₁ = 1 + 2ln 13824, L = 3:
    ≈ 321.09 + 1146.47 + 853.13 = 2320.69; log₁₀ β_B ≥ (2·2320.69 + 14.382)/ln 10 ≈ 2021.96 (M6: 982.39).
 B3 Lemma RD in Bałaban's output format (base row 2(1 − 2δ)κd₀ + 10κ + ln 80κ): L = 3 → ≈ 747.26; L → ∞ (1 − 2δ → 4/5) → ≈ 641.39.
(C) THE PAGE'S OWN FLOOR ON κ (Lemma F, (3.1)):
 C1 c₃ = 91 (hand count: 1 + 3 + 9 + 19 + 30 + 21 + 7 + 1 by size; size 5 = 35 − 5 isolating complements); ln 91 ≈ 4.51086.
 C2 κ_min = 10 ln 91/(1 − 2/L): L = 3 → ≈ 135.33; L → ∞ → ≈ 45.11.
 C3 base row at κ_min: L = 3 → log₁₀ β ≈ 100 874 (± 0.5 %); L → ∞ → ≈ 28 850.
 C4 the e^{5κ} row alone (A1 at κ_min): L = 3 → ≈ 591.8; L → ∞ → ≈ 199.5.
 C5 Bałaban's printed chain at its own floor (B2 at κ_min, κ₁ = 16(1 − 2δ)κ): L = 3 → ≈ 229 230; L → ∞ → ≈ 65 525.
