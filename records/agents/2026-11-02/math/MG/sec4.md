## 4. THE DICTIONARY, AND LINK (1): THE ULTRAVIOLET HALF FOR EVERY G

### 4.0 Normalisation for general G (PROVED)

Let G be compact simple, ρ a faithful irreducible unitary representation of dimension d_ρ, generators T^a Hermitian with
tr_ρ(T^aT^b) = T_ρ δ^{ab} in the normalisation where long roots have length² 2 (equivalently T(fundamental of SU(N)) = ½; then
C_A = C₂(adjoint) = h^∨, the dual Coxeter number, and T_ρ = d_ρC₂(ρ)/dim G). The Wilson action is S = β Σ_p (1 − Re χ_ρ(U_p)/d_ρ).
With U_p = exp(i a²g F^a_{μν}T^a + O(a³)), 1 − Re χ_ρ/d_ρ = (a⁴g²T_ρ/(2d_ρ)) Σ_a (F^a_{μν})² + O(a⁶), and Σ_{μ<ν} against
(1/4)∫F^aF^a = (1/2)∫Σ_{μ<ν}(F^a)² gives

  β = κ_ρ/g²_YM,  κ_ρ := d_ρ/T_ρ  (SU(N) fundamental: 2N; G₂'s 7: 7; F₄'s 26: 26/3; E₈'s 248: 124/15; §3).

Bałaban's action (CMP 109 (0.2), normalised trace on G ⊂ U(N)) is this action for ρ = the defining representation, so his
x = 1/g_B² is β and g²_YM = κ_ρ g_B² (for SU(2), κ = 4: M3 §4's g_B² = g²_YM/4).
The running of pure Yang–Mills: μ dg/dμ = −b₀g³ − b₁g⁵, b₀ = 11h^∨/(48π²), b₁ = 17(h^∨)²/(384π⁴) (Gross–Wilczek, Politzer;
Caswell, Jones — LITERATURE). Hence d(1/g²)/d ln μ = 2b₀ + 2b₁g², and with x = κ_ρ/g²:

  dx/d ln μ = 2κ_ρb₀ + 2κ_ρ²b₁/x,   c_G(L) := 2κ_ρb₀ ln L = (11 h^∨κ_ρ/(24π²)) ln L,   b_G(L) := 2κ_ρ²b₁ ln L.

(SU(2): c = 8b₀ ln L, b = 32b₁ ln L — M3's constants exactly.) In the 't Hooft coupling λ := h^∨g²_YM,

  dλ/d ln μ = −(11/(24π²)) λ² − (17/(192π⁴)) λ³     (EVERY compact simple G; b₁/b₀² = 102/121).

Per doubling, the one-loop step of 1/λ is 11 ln 2/(24π²) = 0.032188976 for every G (§3); in Wilson units c_G(2) = 0.032188976·h^∨κ_ρ:
0.25751 (SU(2), the record's 0.2575), 0.57940 (SU(3)), 0.90129 (G₂), 2.51074 (F₄), 3.47641 (E₆), 5.40775 (E₇), 7.98287 (E₈).

### 4.1 Which of Bałaban's papers treat which groups (READ, §0)

| paper | group | where the group enters |
|---|---|---|
| CMP 95, 96 (1984), propagators I, II | G-blind (the linearised g-valued quadratic action) | dim g copies of the abelian operator |
| CMP 98 (1985), averaging | "a Lie subgroup G of a unitary group U(N)" | the averaging defined through g near 1 |
| CMP 99 (1985), propagators in a background | "a compact Lie group G ⊂ U(N)"; g^c, G^c | ad-bounds of the background operators |
| CMP 102 (255–275), UV stability d = 3 | "semi-simple compact group Lie G" ("can be generalized to a much wider class") | Ad-invariant Haar density σ; one use of semisimplicity (no invariant vector in g) |
| CMP 102 (277–309), variational problem | g^c-valued configurations | the minimal configuration, analytic on G^c (Prop. 9) |
| CMP 109 (1987) [I] | Theorem 1: "an arbitrary semisimple compact Lie group G ⊂ U(N), and for d = 4"; Theorem 2: "G = SU(2)", "superficial … only to simplify calculations" | Theorem 2's one-loop number |
| CMP 116 (1988) [II] | no group named (the fluctuation field B) | constants through [I] |
| CMP 119 (1988) [III], LFR I–II (1989) | "values in the group G" (CMP 109's G) | G^c in LFR II's large fields |

So NO paper of the series is SU(N)-only or U(1)-only; every theorem is stated for every semisimple compact G ⊂ U(N), except CMP
109's Theorem 2, which is stated for SU(2) and was never published for any group. A compact simple G has a faithful unitary
representation (Peter–Weyl), so every G of the Clay statement is covered, with the Wilson action in that representation.
WHERE G ENTERS BAŁABAN'S CONSTANTS: dim g (Gaussian entropy per bond, the constrained determinants, n_T below); the operator norms of
ad on g (‖ad_X‖ ≤ 2‖X‖_op), which bound the background-field operators of CMP 99 and the BCH remainders; the Haar density σ in
exponential coordinates (analytic on ‖A‖_op < π for G ⊂ U(N)); the complexification G^c (LFR II). Each is finite for each G; so E₀,
C₁, C₂, α₀, α₁, M, κ, the cluster constants and the threshold γ are G-DEPENDENT numbers: γ_G. The only SU(2)-specific sentences of
the series in the text layers are Theorem 2's statement and CMP 102's illustrative formula for σ on SU(2).

### 4.2 Theorem 2_G (the coupling window, bounded-transient form) — PROVED GIVEN Bałaban's black box for G, the same input as for SU(2)

STATEMENT. Every compact simple G ⊂ U(N), d = 4, Bałaban's transformations with odd block factor L; c_G := c_G(L) > 0. There is
F_G ≥ 0, and for every ρ ∈ (0, c_G) there is γ₀(ρ, G) > 0, such that for γ ≤ γ₀ (and ≤ γ_G), every target X ≥ 1/γ² + 2F_G and every
K there is a bare x₀ with x_j ≥ 1/γ² (0 ≤ j ≤ K), x_K = X, and X + (K − j)(c_G − ρ) − 2F_G ≤ x_j ≤ X + (K − j)(c_G + ρ) + 2F_G.
At j = 0, 1/g₀² lies in [X + K(c_G − ρ) − 2F_G, X + K(c_G + ρ) + 2F_G]: asymptotic freedom inside the construction for every G.
PROOF (M3 §5 read line by line for SU(2)-specific steps; none beyond three constants).
- Lemma A′ (the trajectory IVT): real analysis on closed sets of bare values; no group. Verbatim.
- Lemma B: β_k(0) = c_G + f(k) − f(k − 1), f(k) = c_W − c(S_k). (B0) history-freeness and (B-i) the stage identity (Laplace on the
  constraint manifold, the coarea factor cancelling) are G-blind; (B-ii) the composition of hard δ-constraints is G-blind; (B-iii) the
  infrared half of the transverse one-loop vacuum polarisation is fixed by the lattice Ward identities and the symmetry clause to the
  continuum integrand, whose logarithm's coefficient is 2κ_ρb₀ in Wilson units (background Feynman gauge: gluon and ghost loops ∝
  C_A f^{acd}f^{bcd} = C_A δ^{ab}; the representation enters the lattice vertices only through the finite ultraviolet part c(S));
  (B-iv) the class 𝒮 is componentwise in g, the curl contraction ‖dQA‖² ≤ ‖dA‖² is componentwise, the symmetry clause comes from the
  centred averaging (G-blind), the analyticity is CMP 102's on G^c. So F_G := |c_W| + sup_k |c(S_k)| < ∞, a G- and ρ-dependent number
  (the quartic lattice vertex carries tr_ρ(X⁴), not a function of C_A alone).
- Lemma C (the remainder, by the exact interpolation (5.C)): its inputs (BB1)–(BB5) are Bałaban's for G (§4.1); the moment form (M3c
  §4) and BB4* (M3c §3) are G-blind (§4.3): ρ_{k+1} ≤ C_G(ε₁g_k + g_k²) + C₁e^{−c₁ε₁²/g_k²}.
- Lemma D (continuity): G-blind.
THE GROUP SEPARATES HERE FOR EVERY G: c_G > 0 iff h^∨ > 0, i.e. iff G is non-abelian; for U(1), b₀ = 0 and no window exists once
ρ > 0 (M3 §5.6's falsifier, now read as the abelian case of one formula).

### 4.3 BB4*, Lemma M, Lemma M_m (M3c §§2–4) — G-blind; PROVED GIVEN CMP 116 Lemmas 1–2 for G

Lemma M is a theorem about the cone 𝒱(ε) of localised analytic potentials; its proof (M3c §2) uses (2.1) (an identity), the Cauchy
representation (2.14), the modulus bound (2.15), Bałaban's radii and factors (every ε₁ classified, M3c §1.3) — no group structure;
CMP 116 never names a group. With G the constants change (E₀(G), C₁(G), …, ε_*(G), R₀ = ε₁^max/ε₁) and the statements do not:
Theorem BB4*, (3.1)–(3.2) and the moment form ρ ≤ C(ε₁g + g²) hold for every G with G-dependent C.

### 4.4 Lemma W (the D-term, M3c §5) — G-blind; PROVED GIVEN the same

𝒲 = ½⟨H₁CB, Δ₁H₁CB⟩ − ⟨H₁hC̃^{(2)}(CB), J⟩ is the Wilson part of Bałaban's Gaussian form; its localisation uses [13]'s random-walk
expansions of operators acting on g-valued fields; C_W(G) depends on B₀(G), ‖Δ₁‖ (Δ₁ = (d*d)⊗1_g + O(ad)) and κ₁. Theorem BB4*-D and
θ₀ := θ_*(G) follow for every G.

### 4.5 Lemma FP for every compact G (PROVED)

STATEMENT. For every compact Lie group G ⊂ U(N), every background in Bałaban's small-field domain and every complex |d| ≤ θ₀:
det(C*(Δ^{(k)} + d𝒲_op)C)/det(C*Δ^{(k)}C) = (1 + d)^{n_T(G)}, n_T(G) = dim ker Q̃ − (dim G)·#(T^{(k)}∖T^{(k+1)}).
PROOF: M3c §6's (FP1)–(FP4), read for SU(2)-specific steps. (FP1) the residual group R (scale-k gauge transformations trivial at the
coarse sites) has Lie algebra ⊕_{x∈T^{(k)}∖T^{(k+1)}} g. (FP2) the Hessian of an R-invariant function at a critical point kills the
orbit tangent: G-blind. (FP3) L∘(orbit map) is block-diagonal over the non-coarse sites with blocks ω(x) ↦ −Ad_{V^{(k)}(y,x)}ω(x), an
invertible linear map of g for EVERY Lie group (Ad acts by automorphisms); so the orbit tangent has dimension dim g·#(sites) and
E = (orbit tangent) ⊕ ker L. (FP4) block-diagonality, and the continuation to complex backgrounds: G-blind. ∎ The background
independence — the only thing (S₁) consumes — holds for every G; the exponent scales with dim G.

### 4.6 (S₁)_G (M3b §5; M3c §8) — PROVED GIVEN (PI-4)_G, (PI-5)_G and Lemma W's input, as for SU(2)

(i) THE COUPLING FIELD: D_k(z) = −τm_kh(z) + R_k(z), with the multiplier m_K = Π(1 − ∂_xβ_{j+1}) obeying
  m_K → (β(x_K)/β(x₀))(1 + O(γ⁴)) → 1 + (b₁/b₀)g²_{YM,K} = 1 + 17h^∨g²_{YM,K}/(88π²) = 1 + 17λ_K/(88π²)   (every G).
(SU(2): (b₁/b₀)g²_YM = 0.15659/X at X = 4/g²_YM — M3b's 4b₁/b₀ = 0.1565873, exactly.) The source of the action density couples to the
trace anomaly θ^μ_μ = (β(g)/(2g³))F^aF^a for every G.
(ii) THE MARGINAL CLASSIFICATION FOR EVERY SIMPLE G (PROVED). The marginal part of an effective action is a W(B₄)×G-invariant quadratic
form on Λ²ℝ⁴ ⊗ g, an element of (Sym²Λ²ℝ⁴)^{W(B₄)} ⊗ (Sym²g)^G ⊕ (Λ²Λ²ℝ⁴)^{W(B₄)} ⊗ (Λ²g)^G. For compact simple G the complexification
g_ℂ is simple, so g is absolutely irreducible under Ad; by Schur its commutant is ℝ, so every G-invariant bilinear form on g is a
multiple of ONE nondegenerate symmetric form (the Killing form): (Sym²g)^G = ℝ, (Λ²g)^G = 0. With M3b's S-A (dim (Sym²Λ²ℝ⁴)^{W(B₄)} = 1;
the ε-tensor not W(B₄)-invariant; no odd-rank invariants) there is EXACTLY ONE marginal term, Σ_{μ<ν}B(F_{μν}, F_{μν}), O(4)-invariant;
no θ-term and no dimension-five term. (Semisimple G with k simple factors: k couplings, each O(4)-invariant.) Lemma Σ₁'s parity
argument (−1 ∈ W(B₄)) is G-blind.
(iii)–(iv) as M3b, with constants θ₀(G), C(G). (PI-4)_G — the large-field steps at a complex Wilson coefficient — needs the relative
bound |Im A(U)| ≤ C_A(G) Re A(U) + η on LFR II's complexified large-field domain in G^c: a G-dependent constant, OPEN for every G,
SU(2) included (M3c §12's next object). (PI-5)_G: OPEN for every G.
Hypothesis II's ultraviolet half (M3 Theorem 6.5 from (S) + (P_LF)) and Proposition D∞ (M3b §9.4) are G-blind (conditional
expectations, the L² Dobrushin inequality, the reflection covariance of the centred averaging).

VERDICT ON LINK (1): the ultraviolet half generalises to every compact simple G AT EXACTLY THE STATUS IT HAS FOR SU(2) — Bałaban's
published theorems for every semisimple compact G ⊂ U(N); the program's reproof of Theorem 2 given his black box; BB4*, W, FP, C, C′
proved given the same inputs; (S₁) given (PI-4), (PI-5) — with G-dependent constants c_G, b_G, F_G, γ_G, θ₀(G), n_T(G). Nothing in it is
SU(2)-specific except the NUMBER c_SU(2)(2) = 0.2575, which is c_G at h^∨κ_ρ = 8.

