
## 6. LEMMA RD — THE STATEMENT

INPUTS (exactly those of CMP 116 itself, the black box M3c §9.1 names): CMP 109 Theorem 3's inductive assumptions at scale k; [13]
(CMP 99): the generalized random walk expansions of H, G̃, H₀, of the operators of Δ_k and of C^{(k)}(Z₀), each walk bounded by (1.7)
in every norm of Theorems 3.1–3.10; [15] (CMP 102) Sect. C, E, G: D and A₀ as functionals of the operators with the contraction
estimates (1.13)–(1.16) ("we can replace the propagators by arbitrary operators having the same regularity properties and satisfying
the same bounds", p. 3); CMP 109 (I.3.17), (I.3.54): the bounds of the history terms; [16]: the walk expansion of Z^{(k)}.
REAL PARAMETERS: s(Δ) ∈ [0, 1] in (1.9)–(1.10) and in (2.8); no decoupling parameter is ever complexified.
FREE CONSTANTS: a > 0 (decay per M-cube, §1), a_L > 0 (decay per LM-cube, §2), η ∈ (0, 1].
DERIVED CONSTANTS: L₀ := M − 2r′ − 2, L₀^{(L)} := LM − 2r′ − 2, λ := 2r′ + r_loc (Lemma G); R := e(1+η)²B₀ (the operator ball of
Lemma SD with B_w ≤ (1+η)B₀ and the real-analyticity margin); R₁ := e^{2^d a}R (the same for the history terms, whose read region □₀
has walks starting near its outside, Lemma G (ii); refinable to e^{2a}R by the d_k-count of §3.4's companion).
CONDITIONS (all of Bałaban's kind; γ enters none of them):
 (G)  δ₀L₀ ≥ 2^{d+1}a and 2^{d+1}aλ ≤ L₀ ln(1+η); δ₀L₀^{(L)} ≥ 2^{d+1}a_L and 2^{d+1}a_Lλ ≤ L₀^{(L)} ln(1+η); δ₀M ≥ 3(2^d a_L + 2);
 (R)  4C₂R₁ε₂ ≤ 1, 4C₄R₁²ε₃ ≤ 1, 2R₁ε₃ ≤ ε₂, C₁ε₁ ≤ ε₃   [(1.13)–(1.16), (1.20) with B₀e^{16κ₁} → R₁];
 (D)  16R₁C₁ε₁ ≤ α₂ and 3(R/B₀)C₁ε₁ ≤ a₁   [(1.21) and (1.40)'s domain with e^{16κ₁} → R₁/B₀, R/B₀];
 (A)  a ≥ (1 − 2δ)κ + a_v and a_L ≥ 4Lκ + a_v, a_v := ln(4·2d·e)   [the rates Bałaban's format and the volume sums of (2.19), (2.37)
      consume; they replace ⅛(κ₁ − 1) ≥ (1 − 3δ)κ, ¼(κ₁ − 1) ≥ (1 − δ)κ, (1/16)κ₁ ≥ (1 − 2δ)κ, ½(κ₁ − 1) ≥ 2Lκ].

LEMMA RD. Under the inputs and conditions above:
 (i) LEMMA 1_RD. (1.33) holds with V′_k(Y, U, J, B) analytic on (1.34), localized (1.35), gauge invariant, and
      |V′_k(Y, U, J, B)| ≤ E₀ε₁ C₁^{RD} M^q · e^{(1−2δ)κ d_k(□̃⁵)} · e^{−(1−2δ)κ d_k(Y)},
   C₁^{RD} := 8(R₁/B₀)C₁α₂⁻¹·(α₁/α₃)⁵·2(6L)⁴·O(1)_{(1.26)}·(1 − (1+η)⁻¹)⁻¹·S_□ /M^q·E₀⁰ … written out: the page's 8B₀C₁e^{16κ₁}α₂⁻¹E₀(α₁/α₃)⁵
   with B₀e^{16κ₁} → R₁, (1.26)'s O(1), (1.24)'s 2(6L)⁴ for □′ and j, (1.27)'s e replaced by Lemma SD's (1 − eB_w/R₁)⁻¹ ≤ 1 + 1/η, and
   (1.28)'s count of □₀ ⊂ Y replaced by S_□ := sup_Y n(Y)e^{−a_v d_k(Y)/2} ≤ 16·sup_t(1 + t)e^{−a_v t/2} (Lemma MS: n ≤ 16 + 16d_k).
 (ii) LEMMA 2_RD. (1.41)–(1.42) hold with Q(Y, B, b, b′) = 0 unless Y = N ∪ F, N a family of at most 2^d cubes with a common point
   ("near cluster", d_k(N) = 0), and
      |Q(Y, B, b, b′)| ≤ C_Q ε₁M⁴ e^{−a|F|} ≤ C_Q ε₁M⁴ e^{−(1−2δ)κ d_k(Y) − a_v|F|},   C_Q := ½C₃3³(R/B₀)³C₁,
   the page's ½C₃3³e^{7·8κ₁}C₁ with e^{16κ₁} → R/B₀ = e(1+η)²; V″_k obeys (i) with the base factor absent for the P^{(k)}-terms.
 (iii) LEMMA 3_RD. CMP 116's expansion (2.1)–(2.13) holds with (2.8) at real s, and with ε₂^{RD} := 2E₀ε₁C₁α₄^{RD,−1}α₆⁻¹M^qK_V,
   K_V := max{C₁^{RD}e^{(1−2δ)κd_k(□̃⁵)}, C_Q′}/C₁ in place of exp C₂κ₁, α₄^{RD} := 2^{−(2^d+d)}α₄ (the near-cluster count of (2.19)),
   α₅^{RD} := e(1+η)²O(1)e^{2^d a_L − ⅓δ₀M} + O(α₀ + α₁) + O(1)α₄ + γ₂:
      |H(Z)| ≤ C₃^{RD}ε₁ exp(−(1 − 8δ)½Lκ d_{k+1}(Z)),   C₃^{RD} := 2(L+2)⁴O(1)_{p.20}·ε₂^{RD}/ε₁,
      |E^{(k+1)}(X)| ≤ O(1)C₃^{RD}ε₁ exp(−(1 − 10δ)½Lκ d_{k+1}(X)),
   under (2.28)^{RD}: ε₂^{RD}α₆⁻¹… e^{5κ} ≤ 1 (the page's (2.28) with exp C₂κ₁ → K_V), (2.31) unchanged, p. 20's conditions unchanged.
 (iv) ANALYTICITY. Every V′_k(Y), V_k(Y), H(Z), E^{(k+1)}(X) is analytic in (U, J, B) on the page's domains and gauge invariant; for
   any parameter p entering the interaction analytically (M3c's s̄, d, a complex history), H(Z; p) and E(X; p) are analytic in p.
 (v) κ₁ DOES NOT OCCUR. Void: (K1) κ₁ ≥ 1 + 2ln(8·12³); (K2) κ₁ ≥ 16(1 − 2δ)κ; (1.11)'s B₀e^{16κ₁}; (1.13)–(1.16)'s e^{16κ₁}, e^{32κ₁};
   (1.21)'s "e^{32κ₁}ε₁ smaller than an absolute constant"; (1.40)'s e^{7·8κ₁}; (2.16)'s e^{−⅓δ₀M}e^{16κ₁} < 1; (2.26)'s
   e^{−(κ₁−1)(LM)⁻⁴|Z∖Z₀′|}; p. 20's ½(κ₁ − 1) ≥ 2Lκ.
 (vi) THE FORMAT FACTOR IS NOT REMOVABLE IN BAŁABAN'S FORMAT (§8): any bound of the form (1.36) for the terms of (i) has
   E₀ε₁C₁M^qK ≥ |V′_k(□̃⁵-term)|·e^{(1−2δ)κd_k(□̃⁵)}, and d_k(□̃⁵) ≥ 914.0625.

## 7. PROOF OF LEMMA RD, AGAINST CMP 116 pp. 3–21

### 7.1 The decoupling identity is already real (pp. 4, 14)
(1.9) and (2.8) are the fundamental theorem of calculus in s(Δ) ∈ [0, 1]; (1.10) groups by the component Y₀ ⊃ □̃⁴ using p. 4's
locality. Lemma SD (i) evaluates every iterated integral exactly: the term of (1.10) at Y₀ is Σ_{T⊂Y₀∖□̃⁴}(−1)^{|Y₀∖□̃⁴∖T|}F(1_T). No
step of pp. 4–21 uses more about the decoupled term than its value; the Cauchy formulas in σ(Δ) ((1.23), (1.38), (2.14)) only BOUND it.

### 7.2 The operators at real s (p. 5, (1.11))
For s ∈ [0, 1]^{Y₀∖□̃⁴} every walk weight is a product of numbers in [0, 1], so ‖H(s)X‖ ≤ B₀|X|, and the same for G̃(s), H₀(s), in all
norms of Theorems 3.1–3.10 [13] — "the first two factors in (1.7) … determine the constant B₀". Bałaban's e^{16κ₁} came from short walks
touching up to 2⁴ cubes at |s| = e^{κ₁}; at real s it is 1.

### 7.3 The fixed points (pp. 5–6, (1.12)–(1.18)) — M6's falsifier answered
By (1.5) (p. 3) D(H, A′), A₀(H, G̃, H₀B′) are functionals of the operators, and the contraction proof of (1.13)–(1.16) uses only operator
norms. Repeat it for COMPLEX operators of norm ≤ R₁ (in place of B₀e^{16κ₁}): by (R) the map X ↦ C(A′ − HX) sends {|X| < 4C₂ε₂²} into
itself and contracts, so D is holomorphic in (H, A′) on {‖H‖ < R₁} × {|A′| < ε₂} with |D| ≤ 4C₂|A′|² (1.14); (1.15)–(1.16) hold with
B₀e^{16κ₁} → R₁, so A₀ is holomorphic in (H, G̃, H₀, B′) with |A₀| ≤ 4C₄R₁³|B′|² ≤ R₁ε₃ ≤ ½ε₂, and (1.17)–(1.18) give H_k holomorphic
with |H_k| ≤ 4R₁|B′|. With (1.19)–(1.20), |H_k| ≤ 4R₁C₁g_k|B| (1.21)_RD, and by (D) the field (tζ̃_□ + t_□ζ_□)H_k obeys (I.3.31) for
|t_□| ≤ r_□, 1/r_□ := 8R₁C₁α₂⁻¹g_k|B| ((1.22)_RD). THE FALSIFIER: the fixed points ARE used off the real segment — on the operator
ball of radius R₁ = e^{1+2^d a}(1+η)²B₀ (R = e(1+η)²B₀ for the P^{(k)}-terms), i.e. on a fixed complex neighbourhood whose size does not
depend on κ₁, which no longer exists. What is NOT used is analyticity in s on |s| ≤ e^{κ₁}. M6's falsifier, in the form "a step needs
the fixed points analytic in s off the real segment", is met only at the radius of the polarization constant e(1+η)² and the
near-boundary weight e^{2^d a} — the costs (R), (D) — and NOT at the radius e^{κ₁} that produced 2C₂κ₁.

### 7.4 The history terms, (1.23)–(1.32) and Lemma 1
Fix □₀ = □̃⁵ (CMP 109 p. 273, READ: "We take the function U_j constructed for the cube □₀ = □̃⁵"), □′, j, X ⊂ □̃² and the term
Φ(h) := ∂_{t_□}E(□₀, (tζ̃_□ + t_□ζ_□)H_k(h, B′))|_{t_□=0} — the page's t_□-Cauchy (1.23) RETAINED: it is a Cauchy formula in a scalar
multiplying a field, radius r_□ from 7.3, and gives ‖Φ‖ ≤ K_Φ := r_□⁻¹·E₀(α₁/α₃)⁵(L^jη)⁵e^{−κd_j(X)} by (I.3.54) on the operator ball
{‖h‖ < R₁}. Apply Lemma SD with c(ω) := the decoupling cubes OUTSIDE □₀ met by X̃₀⁵ ∪ ⋯ ∪ X̃ₙ⁵ (the cubes of the shell □₀∖□̃⁴ are
decoupled on the page too, but they do not change Y = Y₀ ∪ □₀: grouping (1.10) by Y sums them out, Lemma SD (ii)), the weight
w′(ω) := e^{2^d a·1[ω ⊂ near zone]}w(ω) of Lemma G (iv) with N₀ = 0, Ψ := the number of cubes. Lemma C makes every nonvanishing tuple
linked to □₀; Lemma G (ii)–(iv) gives |∪c(ω_i)| ≤ a⁻¹Σ ln w′(ω_i); B_{w′} ≤ e^{2^d a}(1+η)B₀ < R₁/e. Hence
   Σ_{Y ⊃ □₀} e^{a·n(Y∖□₀)} |Σ_{(1.23) with Y₀∪□₀ = Y} …| ≤ K_Φ (1 − eB_{w′}/R₁)⁻¹ ≤ (1 + 1/η) K_Φ.                       (7.1)
This replaces (1.24) [e^{−(κ₁−1)M⁻⁴|Y₀∖□̃⁴|} → e^{−a·n(Y∖□₀)}] AND (1.27) [the sum over the ≤ 8·12³ subsets is free: Lemma SD (ii)].
The sum over X ⊂ □̃², □′ ⊂ □̃² and j is the page's: (1.26) and 2(6L)⁴ (READ p. 8). CONVERSION TO THE FORMAT (1.25)_RD: Y = □₀ ∪ U with
U face-connected to □₀ (p. 4's components), so d_k(Y) ≤ d_k(□₀) + |U| (§3.4, companion); with a ≥ (1 − 2δ)κ + a_v,
   e^{−a·n(Y∖□₀)} ≤ e^{(1−2δ)κd_k(□₀)} e^{−(1−2δ)κd_k(Y)} e^{−a_v n(Y∖□₀)}.                                              (7.2)
The sum over □₀ ⊂ Y (the page's (1.28)) is at most n(Y) ≤ 16(1 + d_k(Y)) choices (Lemma MS); half of a_v absorbs it into S_□.
This is (i). THE TERMS (I.3.7), (1.30)–(1.32): base X₀ (the smallest D_k-domain containing X); the same argument with □₀ → X₀ gives
(1.30)_RD with e^{−(κ₁−1)M⁻⁴|Y∖X₀|} → e^{−a·n(Y∖X₀)} and E₀24B₀²C₁B₃e^{16κ₁}α₂⁻¹ε₁ → E₀24(R₁/B₀)B₀²C₁B₃α₂⁻¹ε₁; there the base IS
paid by the history, d_j(X) ≥ (L^jη)⁻¹d_k(X₀) (1.31), so (1.32) holds verbatim with ¼(κ₁ − 1) ≥ (1 − δ)κ replaced by a ≥ (1 − δ)κ + a_v.
The sum over X ∋ □′ is the page's, "(1.26) for δκ sufficiently large" — the κ floor of §3.5. THE TERMS (I.3.21): "expanded and
analyzed in almost the same way as the last term in (I.3.34)" (p. 9) — the same proof.

### 7.5 The Wilson part, (1.37)–(1.43) and Lemma 2
For the plaquette-localized V_□(H₁B′) the decoupling cubes are those disjoint from the interior of □ (p. 10), and the term at a
plaquette p is read at a point. Lemma SD with Φ(h) := V_□(h, H₁(h)B′) on {‖h‖ < R}: every nonvanishing tuple is linked to p (Lemma
C); by Lemma G (i)–(ii) its cubes are a near cluster N around p (one ball of radius < M/2: at most 2^d cubes with a common point) plus a
set F with |F| ≤ a⁻¹Σ ln w(ω_i); so with N₀ = 0 and Ψ := |F|, the majorant of (1.39) is C₃(e(1+η)²|B′|)³M⁴ (the page's
C₃(e^{16κ₁}|B′|)³M⁴ with the operator ball R in place of B₀e^{16κ₁}), on the domain e(1+η)²|B′| ≤ a₁. The second-order coefficients are
extracted by Cauchy IN THE FIELD B′ (retained — the page's "expand (1.38) with respect to B′ up to the second order"), on the circle
of radius 2|B′| around tB′: |∫₀¹dt(1 − t)∂²(…)| ≤ ½C₃3³(e(1+η)²)³|B′|e^{−a|F|} on 3e(1+η)²|B′| ≤ a₁ — (1.40)_RD. With
d_k(N ∪ F) ≤ |F| (§3.4 companion) and a ≥ (1 − 2δ)κ + a_v this is (ii); |B′| ≤ C₁ε₁ (1.20) gives C_Q; the sum over □ ⊂ Y (p. 11's
M⁻⁴|Y| ≤ e^{M⁻⁴|Y|}) is absorbed as in 7.4. NO BASE FACTOR: the read region is a point, and the near cluster has d_k = 0. The remaining
P^{(k)}-terms (p. 11: "it can be done in the same way for all terms in P^{(k)}") and the D-term 𝒲 of M3c's Lemma W (a quadratic form
in H₁ — Lemma SD's series is then finite, of degree 2) are the same.

### 7.6 §2 with real decoupling, (2.7)–(2.41)
(2.1)–(2.6) do not involve decoupling parameters and are the page's. (2.7)–(2.8): the operators C^{(k)}(Z₀, s), (C^{(k)})^{1/2}(s),
Δ_k(s) at real s; G(Z₀, X, ·) of (2.6) is a holomorphic function of the operators on the ball where Re(C^{(k)}(Z₀, ·)⁻¹) stays positive.
Write each operator as O(s) = O(0) + δO(s), δO(s) the sum of the walks touching decoupling LM-cubes (s-weight ≠ 1), and apply Lemma SD
to δO ↦ G(O(0) + δO) around δO = 0 — the σ(Z) = 0 operators the page itself compares with ((2.15): "we replace the operators by the
corresponding operators with σ(Z) = 0"). Every walk in δO has a small localization domain X with dist(X, Z₀) > ⅔M (p. 13), so by (1.7)
and Lemma G at scale LM (a_L, L₀^{(L)}), Σ‖h_ω‖w_L(ω)e^{2^d a_L} ≤ (1+η)B₀e^{2^d a_L − ⅓δ₀M} — the page's O(1)e^{−⅓δ₀M} (2.16) with
e^{16κ₁} → e(1+η)²e^{2^d a_L}, small by (G). Hence (2.15)–(2.25) hold with the complex σ-operators replaced by O(0) + δO, ‖δO‖ in the
Lemma SD ball: (2.16)_RD |R₁(b, b′)| ≤ (e(1+η)²O(1)e^{2^d a_L − ⅓δ₀M} + O(α₀ + α₁))e^{−½δ₀|b₋ − b′₋|}, (2.17)_RD likewise, α₅^{RD} as
stated. The factor e^{−(κ₁−1)(LM)⁻⁴|Z∖Z₀′|} of (2.15)/(2.26) becomes e^{−a_L·n_{LM}(Z∖Z₀′)} by Lemma SD (iii); p. 20's "½(κ₁ − 1) ≥ 2Lκ"
and "exp(−½(κ₁ − 1)) beside (LM)⁴α₅" are met by a_L ≥ 4Lκ + a_v and (G). (2.18)–(2.20): the τ-Cauchy is RETAINED (a Cauchy formula in
the scalar multiplying a localized potential, radius = α₄/(its bound), cost linear: M3c §1.2), with 1/|τ(Y)| := E₀ε₁C₁α₄^{RD,−1}M^qK_V
·e^{−(1−3δ)κd_k(Y)}; (2.19) by (ii): R(Y)|Q| ≤ α₄^{RD}M⁻⁴(C_Q/(E₀C₁K_V))e^{−δκd_k(Y) − a_v|F|}, and the sum over Y ∋ b₋ runs over at most
2^{2^d−1}·2^d near clusters times Σ_F e^{−a_v|F|}(2de)^{|F|} ≤ 2 — absorbed by α₄^{RD} = 2^{−(2^d+d)}α₄. (2.21)–(2.41) are the page's
with exp C₂κ₁ → K_V: (2.26)_RD, (2.27) (a geometric fact), (2.28)_RD, (2.29)–(2.35), (2.36) (geometric), (2.37)–(2.41). ∎

### 7.7 What the proof does and does not use
USED COMPLEX: the operator balls of radius R, R₁ (Lemma SD's polarization); the scalar Cauchy formulas in t_□ (field scaling), in
B′ (Taylor coefficients) and in τ(Y) (Mayer coupling) — each with radius equal to the inverse of a bound and linear cost. NOT USED: any
complex decoupling parameter. STATUS: Lemma RD (i)–(v) PROVED GIVEN CMP 116's own inputs (the same status as M3c's Lemma M); (vi)
PROVED in §8.
