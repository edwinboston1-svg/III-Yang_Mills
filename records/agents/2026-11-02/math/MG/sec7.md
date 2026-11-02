## 7. LINK (4): THE WINDOW FOR EVERY G — THE CENTRE SPLIT, THE TRIVIAL-CENTRE GROUPS, THE TWO CONTROLS, TURÁN

### 7.1 The twist identity and the vortex recursion for every central element (PROVED)

THEOREM 2.1_G. M4 §2's setting with G in place of SU(2) (holonomy paths, f a free link traversed an odd number of times by π_m and by no
other coarse path — M4R's precision (i)). For z ∈ Z(G) let S_z replace U_f by zU_f and σ_{m,z} replace v_m by zv_m. Then for every v:
ℓ(σ_{m,z}v) = ℓ(v)·ν(B_{f,z} | v), B_{f,z} := Π_{p∋f} w(z^{±1}U_p)/w(U_p) (the sign by the orientation of f in p); ν(B_{f,z}|v)ν(B_{f,z⁻¹}|σ_{m,z}v)
= 1; the representative-independence (c); and the label free energy F_{m,z}(v) = −log ν(B_{f,z}|v).
PROOF: M4's proof with z for −1. It uses exactly: Haar measure is invariant under left multiplication by z (true for every group element);
z is central, so a plaquette containing f becomes z^{±1}U_p wherever f sits in it, and v_m becomes zv_m; v_{m′} is unchanged (disjoint
paths); coarse Haar is σ_{m,z}-invariant. ∎ PROPOSITION 2.2_G (the recursion e^{−F_{k+1,z}} = E[e^{−F_{k,z}} | coarser]) holds verbatim for
each z (tower property). For trivial Z(G) there is nothing to state; for U(1) every e^{iα} qualifies (M4 Theorem 5.2).

### 7.2 The two-channel theorem for every G (PROVED; M4R's repairs carried)

LEMMA 3.1 FOR A COMPACT LABEL GROUP. M4's Lemma 3.1 holds with Γ any compact group acting freely and measurably on 𝒳 (and Δ on 𝒴), the
label L_X ∈ Γ taken relative to a Borel section of the orbit map: the proof uses only the decomposition f = E[f|X̃] + f⊥ and conditional
covariances given the orbit σ-algebra, never the finiteness of Γ. Lemma 3.2(ii) holds with label laws that are densities on Γ with respect to
its Haar measure (the χ²–Bhatia–Davis argument is measure-theoretic). ∎
THEOREM 3.3_G. Coarse sites carry v_y ∈ G⁴; Γ_y = Z(G)⁴ acts freely by multiplication, with orbits (G/Z(G))⁴. For y ≠ z and every coarse
environment ξ:  ρ̃_{yz}(ξ) ≤ ρ_{yz}(ξ) ≤ [ρ̃_{yz}(ξ)² + τ_{y|z}(ξ)² + τ_{z|y}(ξ)²]^{1/2},  τ_{y|z} ≤ 2 sinh Δ_{y|z}, where ρ̃ is the conditional maximal
correlation of the (G/Z)-projections — in Peter–Weyl terms THE CENTRE-TRIVIAL CHANNEL, the irreducibles on which Z(G) acts trivially (for SU(N):
n-ality zero) — and Δ_{y|z} = sup over v_y, v_z, v′_z and γ ∈ Z(G)⁴ of |F_γ(v_y, v_z, ξ) − F_γ(v_y, v′_z, ξ)|, F_γ the label free energy of
Theorem 2.1_G. So R̃ ≤ R ≤ (R̃² + T² + T′²)^{1/2}; the converse sentence as M4R repaired it (R̃ conditioned on the full environment, nothing about
the projected measure); (W-V) required for every z ≠ y with distance-dependent constants (M4R's repair (iii)). PROOF: Lemma 3.1 (finite Γ) and
Lemma 3.2(ii) applied to λ(dv_y, dv_z | ξ); Theorem 2.1_G link by link. ∎
THE THREE CASES. (α) Z(G) finite and nontrivial (SU(N): Z_N; Sp(N): Z₂; Spin: Z₂, Z₄ or Z₂×Z₂; E₆: Z₃; E₇: Z₂): the split of M4, with |Z(G)| − 1
vortex channels (one per nontrivial central character). (β) Z(G) TRIVIAL — G₂, F₄, E₈ (and every adjoint group G/Z(G)): Γ_y = 1, τ ≡ 0, and
R = R̃ IDENTICALLY: the coupling is entirely centre-trivial; nothing splits off. (γ) U(1) with Γ = U(1)⁴: the orbits are points, R̃ ≡ 0, and
R ≤ (T² + T′²)^{1/2}: the coupling is entirely in the vortex half.

### 7.3 LEMMA W_G — the window lemma in the form valid for every compact simple G (the implication PROVED; its two hypotheses OPEN)

For the blocked measure at one coarse scale a_c reached from the crossover:
(W-V)_z, for each z ∈ Z(G) ∖ {1}: the twisted fibre forgets the z-twist inserted at the midpoint free link of a coarse path: for every coarse
v, every coarse link m at y and every z′ ≠ y, sup_s |E_{ν^{f,z}(·|v(s))}Φ_s − E_{ν(·|v(s))}Φ_s| ≤ δ_{V,z}(y, z′), Φ_s the coarse force at z′
(M4 Theorem 4.1 in the axial gauge along coarse paths, M4R's recast; for G the geodesic length of M4's s₁ ≤ π becomes the diameter of G in the
metric with operator-norm-one generators, and the force bound |Φ_s| ≤ 6β becomes 6β·max_{‖X‖_op=1}‖ρ(X)‖_op = 6β); so T_z(y, z′) ≤ 2 sinh(c_G δ_{V,z}).
(W-S)_G: the CENTRE-TRIVIAL channel: R̃(y, z′) ≤ δ_S(y, z′), where by M2's Lemma 7.1 applied to the (G/Z)-projections R̃ splits into a direct part
and the OUTSIDE-MEDIATED COVARIANCE S^G_ξ(A, B) := sup over centred unit-variance functions f, g of the (G/Z)-projections of
|Cov_{ν₀(·|ξ)}(E_ω f(Ã), E_ω g(B̃))| — the exchange of every centre-even glueball, the scalar 0⁺⁺ first, across one block.
CONCLUSION: if Σ_{z′}(δ_S(y,z′) + Σ_{z∈Z∖1}(T_z(y,z′) + T_z(z′,y)))e^{κ|y−z′|} ≤ α < 1 for every y, Hypothesis I-L² holds at a_c (Theorem 3.3_G),
and with Hypothesis II-L² every limit point has a unique vacuum and a gap ≥ min(κ, log 1/ρ′)/a_c (Theorem 8.5′, §5.3). Both halves are
necessary in the sense of Theorem 3.3_G (R̃ ≤ R) and Theorem 5.1_G below.
THEOREM 5.1_G (THE NO-GO, every G; PROVED). If w(zU) = w(U) for all z ∈ Z(G) (a centre-blind action), then B_{f,z} ≡ 1, F ≡ 0, τ ≡ 0 and
R = R̃ exactly, at every scale. FOR G₂, F₄, E₈ EVERY ACTION IS CENTRE-BLIND (Z(G) = 1): no inequality through the centre can bound anything for
these groups, and Lemma W_G = (W-S)_G = HYPOTHESIS I-L² ITSELF.

### 7.4 The two controls (PROVED)

(i) U(1), abelian and massless in its Coulomb phase — THE LEMMA MUST FAIL, AND IT FAILS IN BOTH HALVES. With Γ = U(1)⁴ (case (γ)) the lemma is
(W-V) for every e^{iα}; M2's Theorem 4.1 (no block map satisfies Hypothesis I-L² where U(1) is massless — Fröhlich–Spencer's range rigorously, β = 1.2
by the measured phase diagram) and R ≤ (T² + T′²)^{1/2} force the vortex sums to diverge. With a FINITE label group Z_k ⊂ U(1) (M4 took k = 2),
U(1)/Z_k ≅ U(1) through U ↦ U^k, and the centre-trivial channel is the charge-k sector: the functions of U^k, whose correlations in the Coulomb
phase are those of charge-k loops — not exponentially decaying (the charge-k plaquette field sin(kθ_p) has the photon's power law). So (W-S) FAILS for
U(1) with every finite label group, and the U(1) refusal of M2's Theorem 4.1 lands on BOTH hypotheses of Lemma W_G. The control is two-sided: the
lemma's form refuses the massless abelian theory whichever centre-subgroup labels are used.
(ii) G₂, F₄, E₈ — THE LEMMA MUST NOT NEED THE CENTRE, AND IT DOES NOT: (W-V) is vacuous (no z ≠ 1), the lemma is (W-S)_G alone, and its statement
never mentions a centre. The hard half for SU(2) — (W-S), the SO(3) channel, which M4 §5 identified as the window's bottleneck (glueball exchange
e^{−ma_c} against the vortex's area e^{−σa_c²}) — is the WHOLE lemma for the trivial-centre groups.
WHAT THE CONTROLS SAY ABOUT THE MECHANISM. The centre is a confinement mechanism, not a gap mechanism: G₂ has no centre, its fundamental string
breaks (7 ⊂ 14⊗14⊗14: three gluons screen a fundamental charge), so the vortex free energy route (Tomboulis–Yaffe) has nothing to read — yet G₂
Yang–Mills has a mass gap (lattice Monte Carlo glueball spectra: Pepe–Wiese, Greensite–Langfeld–Olejník–Reinhardt–Tok, Lucini–Wellegehausen et al. —
LITERATURE, labelled, not used in any proof). So THE UNIVERSAL CARRIER OF THE GAP IS THE CENTRE-TRIVIAL CHANNEL, whose lightest state, the 0⁺⁺, is
centre-even for every G; whatever proves (W-S)_G must use a property of every non-abelian G that U(1)/Z_k ≅ U(1) lacks. The only one the chain has
named is the running: c_G = (11h^∨κ_ρ/(24π²)) ln L > 0, and the centre-trivial channel runs with the same g² as the whole theory (one Lie
algebra). M4's one-sided per-step criterion (CONDITIONAL, per M4R) reads for every G in λ units: Δ(1/λ) ≥ 0.032189 − δ̃_k per doubling — the
same drift for every G (§4.0); it refuses U(1) (drift 0) by construction.

### 7.5 Turán slaving for general G: what holds, the exact obstruction, and the universal Turán-class action (PROVED)

THEOREM 8.1_G (a) (Schur; every compact G). For a continuous positive-definite class function K ≥ 0 with ∫K = 1 and the convolution law
K(UV⁻¹)dUdV, E[f(U)|V] acts on the λ-isotypic subspace of L²(G) as multiplication by κ_λ = (1/d_λ)∫Kχ_λ (λ ∈ P⁺, the dominant weights); so
ρ = sup_{λ≠0} κ_λ, the centre-trivial channel ρ̃ = sup over λ ≠ 0 with ζ_λ = 1, and the vortex channel of each nontrivial ζ ∈ Ẑ(G) is the sup
over ζ_λ = ζ (ζ_λ the central character of V_λ). PROOF: M4's (a) verbatim (Schur orthogonality; centrality of K). For Wilson's weight
κ_λ = a_λ(β) = E_β[χ_λ/d_λ] under the one-plaquette law.
(b) THE TURÁN CLASS FOR G. 𝒯_G := {K : all κ_λ > 0 and κ_{λ+μ} ≤ κ_λκ_μ for all λ, μ ∈ P⁺} (for SU(2), where P⁺ = ½ℕ, M4's log-concavity class
implies this submultiplicativity: a concave sequence vanishing at 0 is subadditive). 𝒯_G is closed under convolution (κ multiplies; a product of
positive submultiplicative functions is submultiplicative). On 𝒯_G, κ_λ ≤ Π_iκ_{ω_i}^{n_i} for λ = Σn_iω_i, so ρ = max_iκ_{ω_i}: THE COUPLING IS
CARRIED BY THE FUNDAMENTAL WEIGHTS. If every fundamental weight is centre-nontrivial, every centre-trivial λ ≠ 0 has Σn_i ≥ 2 and ρ̃ ≤ ρ_v² — the
SU(2) slaving. Among compact simple simply connected groups, every fundamental weight is centre-nontrivial EXACTLY for SU(N) (the n-ality of ω_i is
i ≢ 0 mod N); Sp(N) (ω₂), Spin(n) (ω₂, the adjoint), E₆ (ω₂, ω₄), E₇ (ω₁, …) have centre-trivial fundamental weights, and there the slaving fails
inside 𝒯_G (example: the heat kernel below on Sp(2), C₂(ω₂) = 2 < 2C₂(ω₁) = 5/2, so ρ̃ ≥ e^{−2t} > e^{−5t/2} ≥ ρ_v²); for G₂, F₄, E₈ there is
no vortex channel and slaving has no object.
(c) THE UNIVERSAL TURÁN-CLASS ACTION (PROVED). The heat-kernel weight K_t (κ_λ = e^{−tC₂(λ)}, t > 0) lies in 𝒯_G for EVERY compact simple G:
C₂(λ + μ) − C₂(λ) − C₂(μ) = (λ, μ) ≥ 0 for dominant λ, μ (C₂(λ) = ½(λ, λ + 2δ), and dominant weights have nonnegative inner products), so
κ_{λ+μ} ≤ κ_λκ_μ. Its coefficients are positive, so it is reflection positive (Lemma RP_G's argument). So a construction may take the heat-kernel
(Villain–Menotti–Onofri) bare action for every G and stay in the Turán class at every β — a G-universal replacement for SU(2)'s Bessel inequality.
(d) WILSON'S WEIGHT IS NOT IN 𝒯_G IN GENERAL: THE STRONG-COUPLING CARTAN THEOREM (PROVED, exact at leading order). Let ρ be irreducible with
highest weight ω, ε = 1 if ρ ≅ ρ̄ and 0 otherwise. Expanding w = Σ_n (β/(2d))^n(χ + χ̄)^n/n! and using c₀ = 1 + O(β²):
  a_ω = β(1 + ε)/(2d²) + O(β²);   a_{2ω} = β²(1 + 3ε)/(8d²d_{2ω}) + O(β³)  (V_{2ω} has multiplicity one in ρ⊗ρ, multiplicity ε in ρ⊗ρ̄ and in ρ̄⊗ρ̄);
  for complex ρ:  a_{ω+ω*} = β²/(4d²d_{ω+ω*}) + O(β³)  (V_{ω+ω*} has multiplicity one in ρ⊗ρ̄, none in ρ⊗ρ or ρ̄⊗ρ̄).
Hence, as β → 0:  a_{2ω}/a_ω² → d²/(2d_{2ω}),  and for complex ρ  a_{ω+ω*}/(a_ωa_{ω*}) → d²/d_{ω+ω*} ≥ d²/(d² − 1) > 1  (ρ⊗ρ̄ ⊇ 1 ⊕ V_{ω+ω*}).
CONSEQUENCES (instrument A's exact numbers): Wilson's weight leaves 𝒯_G at strong coupling for EVERY complex ρ (SU(N ≥ 3) fundamental: N²/(N² − 1),
9/8 at N = 3; E₆'s 27: 729/650) and wherever d_{2ω} < d²/2: F₄ (169/162), E₆ (27/26), E₇ (224/209), E₈ (3844/3375); it satisfies the Cartan square
at strong coupling for SU(2) (2/3), G₂ (49/54), Sp(2) (4/5), Spin(7) vector (49/54). So NO TURÁN INEQUALITY OF THE SLAVING FORM HOLDS FOR THE
WILSON COEFFICIENTS OF A GENERAL G; the obstruction is representation-theoretic — the share of the Cartan component in the tensor square — and it is
already decided at β → 0.
CHECKED (instrument B, §3): SU(3), R₃ = a₈/(a₃a₃̄) = 1.124938 at β = 10⁻³, > 1 on (0, 2.3045), minimum 0.9034 near β ≈ 8, → 1⁻; G₂: a₂₇/a₇² ∈
[0.838, 0.9074] on (0, 20], a₁₄/a₇² ∈ (1.009, 1.750] — the G₂ adjoint channel is never below the square of the defining channel there, while the
defining representation carries the largest coefficient (S-B3).
WHAT SURVIVES FOR EVERY G: Theorem 8.1_G(a), and on the heat-kernel action the coupling carried by the fundamental weights; for Wilson's action at
strong coupling the defining representation carries the coupling (a_ρ = O(β), every other nontrivial a_λ = O(β²) unless λ ∈ {ρ, ρ̄}; and S-B3 on
[0, 20] for SU(3), G₂). Slaving with a G-dependent constant, ρ̃ ≤ C_G ρ_v² on convolution couplings, needs C_G ≥ sup_β of the ratios above — 9/8
for SU(3) by the grid supremum; a proof of a finite C_G for all β is OPEN. As M4R noted for SU(2), the 4D objects' direct couplings are not
convolution couplings, so none of this bounds R̃ on ℤ⁴; it decides only that the SU(2) inequality was not a general mechanism.

### 7.6 The verdict on the window for every G

The every-G form of the window lemma is Lemma W_G (§7.3), PROVED as an implication for every compact simple G, with ONE universal core, (W-S)_G —
the centre-trivial channel's outside-mediated covariance across one block (the 0⁺⁺ glueball) — and a supplement (W-V)_z for each nontrivial
central element, empty exactly for G₂, F₄, E₈. It fails for U(1) in both halves (two-sided control) and needs no centre for the trivial-centre
groups. Neither half is proved for any G, SU(2) included; (W-S)_G is the decisive open estimate of the whole Clay problem along this chain.

