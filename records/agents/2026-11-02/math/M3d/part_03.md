
2.3′ DATED PRECISION TO 2.3 (2026-11-02, written minutes after it; 2.3 not edited). The comparison of Lemma 2's thresholds with
M6's rows in 2.3 is too quick. Condition (A) of Lemma 2 reads s(g_k, M)·(1 + n/c_Λ) ≤ ⅛ with n/c_Λ ≤ 12(101M)⁴·2d(100M)⁵/γ₀ =
O(10²⁰)M⁹/γ₀ (a crude trace bound, Tr Q₀^{−1} ≤ n/c_Λ), and s contains O(1)M⁶R_k(ε_k + α_{0,k} + α_{1,k}); so (A) asks
g_k ≲ 10^{−20}M^{−15}·polylog(g_k)^{−1}, i.e. log₁₀β ≳ 40 + 30 log₁₀M + polylog — stronger in g than Bałaban's LFR II (1.9) row
(O(1)(M⁶R_kε_k + e^{−R_k}) ≤ γ₀/(2d(100M)^{d+1}), g ≲ 10^{−10}M^{−11}·polylog^{−1}) by a factor O(10^{10}M⁴), and far below M6's
literal-chain floor (log₁₀β_B ≥ 978, SHARED, M6 §5). Bałaban needs only a crude lower bound exp(−O(M⁴)) for the REAL denominator
(positivity); at complex d the relative comparison costs the trace factor. Condition (B) is implied by M₀ = O(1)B₅M⁶ (LFR II
p. 378) for p₀(g_k) ≥ O(1)·M^{−3/2}·(log M)^{1/2}·10^{11} — a condition of Bałaban's type. The statement "(B) is weaker than the
(1.9) row" in 2.3 is withdrawn as unproved; what stands: every added condition is of the form "γ small depending on M", in
Bałaban's order of choices.

## 3. (PI-5) — THE MULTI-STEP HISTORY PROPAGATION

3.1 THE DECAY IS ON BAŁABAN'S PAGES (READ). (a) CMP 116 (1.24), p. 7 (M3c's 150-dpi render cmp116_7.png, read today): a history term
of scale j inserted into the scale-k fluctuation integral is bounded by 8B₀C₁e^{16κ₁}α₂^{−1}g_k|B|E₀(α₁/α₃)⁵(L^jη)⁵·exp(−(κ₁ − 1)M^{−4}|Y₀∖□̃⁴|)
exp(−κd_j(X)), η = L^{−k}; p. 8 (read): "To bound the first sum, over □′ ⊂ □̃², we use the factor (L^jη)⁵ in (1.24). This yields
(6L)⁴L^jη, and the sum over j is bounded by 2(6L)⁴." So the scale-j part of the history enters the scale-k step with weight
(6L)⁴L^{−(k−j)}, and Lemma 1's bound (1.36) |V′_k(Y)| ≤ E₀ε₁C₁M^q e^{C₂κ₁}e^{−(1−2δ)κd_k(Y)} is LINEAR in the per-scale bounds
(the factor E₀ of (1.24) comes from (I.3.54) — M3c §7.4's reading). (b) CMP 119 Theorem 2 (2.43), p. 263 (read): the normalized
scale-j term, summed over a region, is ≤ E₁Σ_{n=j}^{k}(L^{j−n})^β|Γ_n ∩ Ω| for β < 1 and regular U_k; its proof (pp. 279–284, read)
is the Taylor expansion (3.69) of E^{(j)}(X, U_k, z) in the scale-n-smooth field B′ (|V′ − 1| < 3dM(1 + log L^jL^{−n})ε_n(L^jL^{−n})²,
(3.68)), the third-order remainder O(1)(L^jL^{−n})^{6−β}e^{−κd_j(X)} by Cauchy on the analyticity domain with the bound (3.48), and the
second-order term reduced by the Ward–Takahashi identities, translation invariance and Euclidean covariance to β′_j·½Σ tr F² ((3.56)–
(3.61)), β′_j = Π^{(j)}_{22,11} = β_j ((3.62)–(3.64)), cancelled by −β_jA(h_z, U_k) ((3.65)–(3.67)): "E^{(j)}(Λ_j,U_k,z) − E^{(j)}(Λ_j,1,z)
− β_jA(h_z,U_k) = O((L^jL^{−n})^{5−β})" (3.67). (c) (2.47), p. 264: boundary terms B₁2^{−(j−n)}|Γ_n|.

3.2 THEOREM PI-5 (PROVED GIVEN Theorem PI-4, Lemma M, M3b's Lemma Σ₁ (frozen part §4.2, variation part M3c §7.6), CMP 116
Lemma 1's estimate (1.23)–(1.29) and CMP 119 Theorem 2 — i.e. given Bałaban's black boxes). Let p = (D_i)_{i<K}, p′ = (D′_i)_{i<K}
be two admissible parameter sets on one reference trajectory (|D_i|, |D′_i| ≤ θ₀x_i/2, θ₀ ≤ θ_*/2, Lemma 3's condition for each and
for every point of the segment p + ζ(p′ − p), |ζ| ≤ 2). Write the history at scale k as Bałaban's multi-scale sum
E_k(p) = Σ_{m≤k}R^{(m)}(p), R^{(m)}(p) := E^{(m)}(Λ_m, ·; p) − E^{(m)}(Λ_m, 1; p) − β_m(p)A(φ_m, ·) (CMP 119 (2.25), with M3b's local
β_m(p)(z) of Lemma Σ₁), and let a_{(m)} be the least constant with |R^{(m)}(X; p′) − R^{(m)}(X; p)| ≤ a_{(m)}e^{−κd_m(X)} on the
analyticity domain (in the multi-scale sense of CMP 119 (2.26)–(2.27), with (2.43) holding for the difference with E₁ ↦ a_{(m)}E₁/E₀).
Put N_k := ½Σ_{m≤k}a_{(m)}L^{−(k−m)} (normalised so that a_{(m)} ≡ E₀ gives N_k ≤ E₀: the weight of 3.1 (a)). Then there are
β′ ∈ (0, 1) (L^{−β′} := L^{−1} + C″ε₁ — any β′ < 1 for ε₁ small) and C, independent of K, the volume, p and p′, such that
  N_k ≤ (C E₀/θ₀) Σ_{i<k} L^{−β′(k−1−i)} g_i² |D′_i − D_i|,                                                             (3.1)
and the history part of the β-function obeys
  |β_{k+1}(x_k; E_k(p′)) − β_{k+1}(x_k; E_k(p))| ≤ C(g_k² + ε₁g_k)·N_k/E₀.                                             (3.2)
PROOF. (i) THE NEW TERM IS ANALYTIC IN ITS TWO INPUTS. At step k + 1 the new normalized term R^{(k+1)} depends on the step's coupling
deviation D_k and on the history E_k. On the segment E_ζ := E_k(p) + ζ(E_k(p′) − E_k(p)) the interaction V_k[E_ζ] = V_k[E_k(p)] +
ζV′_k[ΔE_k] (linear, CMP 116 (1.33)), and by 3.1 (a) V′_k[ΔE_k] ∈ 𝒱(C₁ε₁N_k) (M3c's cone, (M.1)–(M.2), the factor M^qe^{C₂κ₁} built in).
With V_k[E_k(p)] ∈ 𝒱(E₀C₁ε₁), E₀C₁ε₁ ≤ ε_*/2 (ε₁ ≤ ε₁^max/2) and the D-term −dW ∈ 𝒱(|d|(C_W + ε_*)) (Lemma W), the cone property
puts the potential in 𝒱(ε_*) on the polydisc P := {|d| ≤ θ_*/2}×{|ζ| ≤ Z₀}, Z₀ := ε_*/(4C₁ε₁N_k). Lemma M (d): the step's
localized output is analytic on P with the bound (b) of Lemma M; its large-field part by Theorem PI-4; the counterterm β_{k+1}(d, ζ)
is analytic (M is a bounded linear functional of the localized output); THE NORMALIZED REMAINDER R^{(k+1)}(d, ζ) obeys CMP 119's
inductive bound and (2.43) UNIFORMLY ON P — by Bałaban's proof (3.48)–(3.67) at complex parameters: (3.48) is the induction; the
Ward–Takahashi identities are gauge invariance (Lemma M (c)); translation invariance and Euclidean covariance hold for the frozen
model at constant complex d and translation-covariant history (§4.2), and the variation in d(·) is M3b's Lemma Σ₁ (its rank-five
tensor vanishing by −1 ∈ W(B₄), S-A); (3.62)–(3.64) are identities of the whole-lattice expression at each parameter value.
(ii) SCHWARZ IN THE TWO INPUTS. With S := sup_P|R^{(k+1)}(X; ·)|e^{κd_{k+1}(X)} ≤ ½E₀ (CMP 116 (2.41) "O(1)C₃ε₁ ≤ ½E₀"):
|R(d′_k, 1) − R(d′_k, 0)| ≤ 4S/Z₀ (Schwarz on |ζ| < Z₀, Z₀ ≥ 2 once C₁ε₁N_k ≤ ε_*/8, which (3.1) maintains), and
|R(d′_k, 0) − R(d_k, 0)| ≤ 4S|d′_k − d_k|/θ_* (Cauchy for ∂_d on the disc of radius θ_*/4 about points |d| ≤ θ_*/4). Hence
  a_{(k+1)} ≤ 8E₀|d′_k − d_k|/θ_* + 8E₀C₁ε₁N_k/ε_*,   d_k := D_k/x_k = g_k²D_k.                                    (3.3)
The same holds for the difference's (2.43)-constant (Cauchy applies to the bound (2.43) uniformly on P).
(iii) THE OLD TERMS ARE THE SAME FUNCTIONS. For m ≤ k, R^{(m)}(p) and R^{(m)}(p′) are unchanged by step k + 1 (CMP 119 (2.25): the
history is a sum over scales of fixed functions of U, re-evaluated at the new configuration); by 3.1 (a) their contribution to the
scale-(k+1) step carries one more factor L^{−1}. So N_{k+1} = ½a_{(k+1)} + L^{−1}N_k.
(iv) THE RECURSION. N_{k+1} ≤ (L^{−1} + 4C₁ε₁E₀/ε_*)N_k + 4E₀|d′_k − d_k|/θ_* =: qN_k + b_k, q = L^{−β′} < 1, N₀ = 0; so
N_k ≤ Σ_{i<k}q^{k−1−i}b_i, which is (3.1) (θ₀ = θ_*/2, |d′_i − d_i| = g_i²|D′_i − D_i|).
(v) (3.2): M3c §7.4's argument with the history difference as the marked insertion: the first-order term ⟨V′_k[ΔE_k]⟩ has odd part
of zero mean (parity, M3c 7.3 (b2)) and even part O(g_k²)·N_k (explicit Gaussian moments of the history's second-order term — M3
§5.4 (ii)); the variance term carries ε₁g_k·N_k (Lemma M_m, moment form). ∎
THE FALSIFIER — "a marginal remnant of an earlier step that survives its renormalization" — IS NOT MET, AND WHY. The step-m
counterterm is β_m at the ACTUAL parameter value (M3b's local β, Lemma Σ₁; Lemma C′ (a)), so by (3.61)–(3.64) the second-order
coefficient of R^{(m)}(p) vanishes identically in p; there is no other marginal structure: the W(B₄)-invariant quadratic forms on
Λ²ℝ⁴ are spanned by Σ_{μ<ν}F²_{μν} (S-A, M3b §6.7: dim = 1), odd ranks vanish (−1 ∈ W(B₄)), the ε-tensor is not invariant (no θ-term),
the localized terms are gauge invariant (no dimension-2 term), and the dimension-0 term is the subtracted value at U = 1. Hence each
R^{(m)}(p) and each difference is IRRELEVANT, (3.67) uniformly in p. The remnant the falsifier asks for would require the
counterterm at a parameter other than the step's own — e.g. β_m(x_{m−1}) with the deviation D_{m−1} left in the remnant — which
leaves ∂_dβ_m·d·A(φ_m) marginal; Lemma Σ₁'s construction (the flow (6.2) absorbs exactly that term into D_m) excludes it.
CONSEQUENCE FOR THE SUMS. Σ_{j>i}(g_j² + ε₁g_j)L^{−β′(j−1−i)} ≤ C(g_i² + ε₁g_i) (g_j ≥ g_i for j > i, but x_j ≥ x_i − (j − i)(c + ρ) − 2F
keeps g_j² ≤ 2g_i² while (j − i)(c + ρ) + 2F ≤ x_i/2, and L^{−β′(j−i)} is smaller than any power of g_i beyond); so the history's
total effect on the flow of a coupling difference is Σ_i g_i²(g_i² + ε₁g_i)|D′_i − D_i|·C/θ₀ — summable (Σ_ig_i³ ≤ Cγ/(c − ρ), D4b
(E4)). The (log K)² that M3c §7.5 feared is excluded.
