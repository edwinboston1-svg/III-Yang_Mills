
## 4. THE CONSEQUENCES M3c LISTED, CARRIED

4.1 LEMMA SH — THE GAUGE-WEIGHT SHELL ESTIMATE OF M3c 7.3 (d) (PROVED GIVEN Lemma M, i.e. CMP 116 §2's expansion with local
cutoff-type polymers; the slice and the residual group READ in CMP 109 pp. 252–254 via M3b's renders cmp109_252–254 and M3c
§6 (FP1)–(FP3)). Let I_α := ∫dU F(U)G_α(U)χ_k(U) be the step-(k+1) small-field integral with gauge-fixing weight α (G_α the
normalized factor Π_{y∈T^{(k+1)}}Π_{x∈B(y),x≠y}z_α^{−1}exp[−(1/α)(1 − Re tr U(y,x))], CMP 109 (0.15), (2.5)), F the R-invariant rest
(Wilson action, earlier effective action, δ-constraints), χ_k = Π_bχ(|B′(b)| < ε₁) on the physical angle (CMP 109 (2.9)). For
1/α, 1/α′ ∈ [x_k/2, 2x_k]: log I_α − log I_α′ = Σ_X Δ(X), a sum of localized terms analytic on Bałaban's domain with
|Δ(X)| ≤ 2C₁e^{−c₁ε₁²/g_k²}e^{−κd_{k+1}(X)}.
PROOF. (i) SLICE. With Bałaban's contours Γ_{y,x} (centred blocks, CMP 109 (0.3)), every configuration is uniquely U = u·s with
s(Γ_{y,x}) = 1 and u in the residual group R (u(y) = 1 at coarse sites — "exactly the group under which the underintegral expression
in (0.13) is still invariant", p. 254); dU = ds du (axial gauge: Jacobian 1); F and the constraints are R-invariant; and
G_α(u·s) = Π_x g_α(u(x)), g_α(u) := z_α^{−1}e^{−(1/α)(1 − Re tr u^{−1})}, a product of probability densities. So
I_α = ∫_S ds F(s)·E_α[χ_k(u·s)], E_α := ⊗_x g_α(u(x))du(x).
(ii) DEFECTS. χ_k(us) = Π_b[χ_b(s) + Δ_b(u,s)], Δ_b := χ_b(us) − χ_b(s) ∈ {−1, 0, 1}, so
I_α = Σ_P ∫_S ds F(s)Π_{b∉P}χ_b(s)·E_α[Π_{b∈P}Δ_b(u,s)], and the P = ∅ term does not depend on α.
(iii) THE DEFECT BOUND. The background V^{(k)} is a function of the coarse variables, R-invariant; so for b = (x, x′) and
u(x) = e^{iθ_x}, |B′_{us}(b) − B′_s(b)| ≤ 2(|θ_x| + |θ_{x′}|) for small angles. Hence Δ_b ≠ 0 forces |B′_s(b)| ≥ ε₁/2 or
max(|θ_x|, |θ_{x′}|) ≥ ε₁/8. Under g_α (1/α ≥ x_k/2, 1 − Re tr u ≥ c|θ|²): E_α[1(|θ_x| ≥ ε₁/8)] ≤ Ce^{−c₂ε₁²/g_k²}. Each site
ends at most 2d bonds, so, choosing for each defect bond either its shell event or a large-angle endpoint,
|E_α[Π_{b∈P}Δ_b]| ≤ Σ_{P₁⊂P}Π_{b∈P₁}1(|B′_s(b)| ≥ ε₁/2)·(Ce^{−c₂ε₁²/g_k²})^{|P∖P₁|/(2d)}, uniformly for 1/α ∈ [x_k/2, 2x_k].
(iv) THE SHELL EVENTS. 1(|B′_s(b)| ≥ ε₁/2) ≤ exp(−½γ₂(ε₁/2)²/g_k² + ½γ₂|B_s(b)|²) in the scaled field — CMP 116 (2.22) with
ε₁ ↦ ε₁/2, absorbed into the Gaussian as in (2.23)–(2.25).
(v) EXPANSION. Undo the slice inside each P-term with a FIXED reference weight α₀: ∫_S ds F(s)Φ_P(s) = ∫dU F(U)G_{α₀}(U)Φ_P(s(U))
(s(U) = u(U)^{−1}U is local within blocks), so the P-sum is CMP 116 (2.3)'s cutoff decomposition with the local factor
Π_{b∉P}χ_b(s(U))E_α[Π_{b∈P}Δ_b] in place of χ_{k,Y₀}χ^c_{k,P}, bounded as (iii)–(iv); Lemma M's proof (CMP 116 §2) runs verbatim
and every cluster without a defect polymer is independent of α; every cluster with one carries ≤ C₁e^{−c₁ε₁²/g_k²},
c₁ := min(γ₂/8, c₂/(2d)). ∎
CONSEQUENCE. M3c 7.3 (d) holds: |β_{k+1}(x′) − β_{k+1}(x)| ≤ (2g_k²/θ₀)[C₁e^{−c₁ε₁²/g_k²} + C(g_k² + ε₁g_k)]|x′ − x| + 3C₁e^{−c₁ε₁²/g_k²}
for real x′ with |x′ − x| ≤ θ₀x/2, in CMP 109/116's model. In CMP 119's complete model the thresholds ε_j = g_jp₀(g_j) are
coupling-dependent; the own and the reference constructions then differ also by M3b's Lemma P3 shell, ≤ C exp(−c(log g_j^{−2})^{2p₀})
per unit (smaller than every power of g) — added to the tail below.

4.2 THE FROZEN PART OF LEMMA Σ₁ — PROVED GIVEN Theorem PI-4 (at constant D, where Lemma 3 is void) and the CMP 109 inputs Bałaban's
proof cites ((I.1.18), (I.3.34), (I.4.14)–(I.4.15), (I.5.16)/(I.5.37)). The frozen model (D ≡ D_z at every step) is translation
invariant and W(B₄)-covariant (M3b §15.1, S-A); Theorem PI-4 closes its large-field steps; Lemma M its small-field steps; so CMP 119's
proof of (2.43) (pp. 279–284, read: (3.48) the bound from the induction; (3.49)–(3.56) the Ward–Takahashi reduction — gauge
invariance, an identity in the background valid at every complex parameter; (3.57) translation invariance ("hence Π^{(j)}_{μν,κλ} is
independent of z", p. 281), true for the frozen model; (3.58)–(3.61) Euclidean covariance — A is Euclidean invariant, so the
D-term is; (3.62)–(3.64) the identification β′_j = β_j at each parameter value; (3.65)–(3.67) the cancellation) applies verbatim at
constant complex D. The variation part (M3c 7.6, M3b §6.5) needs only the small-field analyticity in t of D_z + t(D − D_z) (Lemma M);
the large-field terms are not renormalized. LEMMA Σ₁ (M3b §6.5): PROVED GIVEN Bałaban's black boxes.

4.3 PROPOSITION E1-a — THE BARE COUPLING IS UNIQUE UP TO THE SHELL (PROVED GIVEN Theorem PI-4, Theorem PI-5, Lemma C′ (a)–(c) (M3c),
Lemma SH, Lemma P3 (M3b) — i.e. given Bałaban's black boxes and Lemmas M, W). Let x₀ < x′₀ both reach x_K = x′_K = X. Then
  x′₀ − x₀ ≤ δ_bare := 8 Σ_{j≥0} [C₁e^{−c₁ε₁²(X − 2F + j(c−ρ))} + Ce^{−c(log(X − 2F + j(c−ρ)))^{2p₀}}],   uniformly in K.
PROOF. D_j := x′_j − x_j (real; on the reference x_j by the device, Lemma 2 not even needed — Im Q_d = 0). The step shift splits as
[own − reference construction at x′_j] (Lemma SH and P3: ≤ t_j := 4C₁e^{−c₁ε₁²/g_j²} + 4Ce^{−c(log g_j^{−2})^{2p₀}}) + [coupling
Lipschitz at fixed history] (Lemma C′ (c): ≤ C′g_j^{2+a}|D_j|, a = 1) + [history] ((3.2) and (3.1): ≤ C(g_j² + ε₁g_j)θ₀^{−1}
Σ_{i<j}L^{−β′(j−1−i)}g_i²|D_i|). With S_j := max_{i≤j}|D_i| and Σ_{i<j}L^{−β′(j−1−i)}g_i² ≤ Cg_j² (g_i ≤ g_j):
|D_{j+1} − D_j| ≤ w_jS_j + t_j, w_j := C′g_j^{2+a} + C″(g_j² + ε₁g_j)g_j², Σ_jw_j ≤ Cγ^a (Σ_jg_j³ ≤ Cγ/(c − ρ), D4b (E4)). Upper
Gronwall: S_K ≤ e^{Cγ^a}(|D₀| + Σ_jt_j). Lower: |D_K| ≥ |D₀| − Σ_j(w_jS_j + t_j) ≥ |D₀|(1 − Cγ^ae^{Cγ^a}) − (1 + Cγ^ae^{Cγ^a})Σ_jt_j.
D_K = 0 gives |D₀| ≤ 2Σ_jt_j for γ small; x_j ≥ X − 2F + (K − j)(c − ρ) (Theorem 2's profile) sums the tails. ∎
WITH BAŁABAN'S ANALYTIC-VARIANT CUTOFF (g_k/γ_k)ε₁ (CMP 109 p. 266) the first tail vanishes (M3b 10.1); the P3 tail remains in the
complete model and is smaller than every power of g.
PROPOSITION E1-b (M3b 10.2, trajectory convergence) is PROVED GIVEN the same: its input "(PI)_H" with the factor L^{−β(j−i)} is
Theorem PI-5.

4.4 THEOREM S₁ (M3b §5) — STATUS AFTER THIS FILE. (S₁)(i)–(iv) are PROVED GIVEN Bałaban's black boxes (CMP 99's random-walk
expansions, which Lemma W also uses; CMP 102 Sect. G with (189)–(190); CMP 116 Lemmas 1–2; CMP 109 Theorem 3; CMP 119 §3 and
LFR I–II as stated) and Lemma M, on the τ-disc
  |τ|·‖h̃‖_∞ ≤ θ₀X/(4e^{Cγ^a})   AND   |τ| ≤ r_τ of (2.2),   θ₀ := min(θ_*/2, 1/4),
with two precisions to M3b's statement: (a) the effective coupling field D_k is the flowed field in small-field regions and the
LAGGED field in large-field regions (renormalization only in small-field regions — the same lag as Bałaban's own g_k(·)); (b) the
R-operation is R_D. Nothing in (S₁) uses Lemma SH (that enters only E1-a).
