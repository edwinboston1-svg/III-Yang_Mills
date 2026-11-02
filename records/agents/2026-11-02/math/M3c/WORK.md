# M3c — LEMMA BB4*: THE COMPLEX-s DISC OF (BB4), WITH THE D-TERM; ITS CONSEQUENCES; WHAT (PI) NEEDS

Proof agent M3c, 2026-11-02. Work directory `.../scratchpad/math/M3c/`. Appended as the work proceeds; nothing above a
line is edited after it is written except by a dated correction below it. Labels: READ (on the rendered page, today),
PROVED (full proof here), PROVED GIVEN [named input], NAMED (stated with its falsifier, not proved), COMPUTED.

NOTATION WARNING. CMP 116 writes s(Δ), σ(Δ) for its DECOUPLING parameters (always with a cube as argument) and t(Y), τ(Y)
for its Mayer interpolation and Cauchy variables. The interpolation parameter of M3's identity (5.C) (M3b's "s") is written
here s with no argument. Bałaban also reuses names: C₃ in (1.43) is not C₃ of p. 20; ε₂ of p. 5 is not ε₂ of p. 19. Where
a clash matters the page is named.

## 0. Sources

Read in full before deriving: `math/MATH_BRIEF.md`; `math/M3b/WORK.md` §§0–15; `math/M3R/REVIEW.md`; `math/M3/WORK.md` §5
(Lemmas A′–D, the identity (5.C), the bounds (BB1)–(BB5)).

PRIMARY TEXT, READ ON IMAGE TODAY, EVERY PAGE: CMP 116 (1988) 1–22, `C:\Users\Edwin Boston\Downloads\Download (3).pdf`,
SHA-256 prefix ee39523a0f7b83af (= M3b §0's census). Rendered at 150 dpi grey by `bin/render.py` (PyMuPDF, run as
`python -E -P`), `render/cmp116_1.png` … `render/cmp116_22.png`. Also CMP 109 (1987) 249–301, `Download (1).pdf`,
SHA-256 prefix 1c2d2e500fd1e6a1, pp. 265–268 rendered (`render/cmp109_265..268.png`); pp. 266–267 READ (the fluctuation
integral (2.4)–(2.11): the gauge-fixing term (2.5), the action's expansion (2.6)–(2.8), the integral (2.10), the vanishing
of the linear term and the quadratic form (2.11)).

## 1. CMP 116 LINE BY LINE — WHERE THE INTERACTION ENTERS AND WHERE ε₁ ENTERS (READ, pp. 1–22)

### 1.1 The architecture (READ)

§1 (pp. 2–11) BUILDS the localized potential: the fluctuation-field action (I.2.13) = P^{(k)}(g_k, U_{k+1}, B) + {E_k(U_k(exp iB′V^{(k)}))
− E_k(U_k(V^{(k)}))} is a sum of Part I's expressions E(□₀, ·) evaluated at nonlocal arguments (H_k(B′), propagators H, H₀, G̃);
each is localized by inserting decoupling parameters s(Δ) into the propagators' random-walk expansions ((1.6)–(1.10); [13]
(3.107)–(3.108)), the solutions D, A₀, H_k of (1.2)–(1.4) being analytic in s(Y₀) on |s(Δ)| ≤ e^{κ₁} ((1.11)–(1.18)); the localized
term is extracted by Cauchy formulas in t_□ and σ(Δ) ((1.22)–(1.23), (1.38)). Results: Lemma 1 (p. 9, the history part V′_k) and
Lemma 2 (p. 11): Σ_{Y∈D_k}V_k(Y, U_{k+1}, B) with V_k(Y, U, J, B) analytic on U^c_{k+1}(Y, (1+β)α₀, (1+β)α₁, α₀) × {B : |B| < ε₁g_k^{−1}
on Y} (1.34), localized (1.35), V_k(Y,B) = ½⟨Q(Y,B)B, B⟩ + V″_k(Y,B) (1.42), |Q(Y,B,b,b′)| ≤ C₃ε₁M⁴exp C₂κ₁ exp(−⅛(κ₁ − 1)d_k(Y) −
½(κ₁ − 1)M^{−4}|Y|) (1.43), |V″_k| ≤ E₀ε₁C₁M^q exp C₂κ₁ exp(−(1 − 2δ)κd_k(Y)) (1.36), gauge invariant.
THE INTERACTION COUPLING DOES NOT ENTER §1: every operation there (decoupling, the fixed-point constructions, the Cauchy
extractions) acts on one term of the action at a time and is linear in that term; multiplying the action by a scalar s
multiplies every V_k(Y, ·) by s.

§2 (pp. 11–22) EXPANDS ∫dμ_{C^{(k)}}(B)χ_k exp[Σ_Y V_k(Y, B)]: Mayer expansion (2.1); cutoff decomposition (2.3); conditioning
(2.5)–(2.6); decoupling of C^{(k)}(Z₀), (C^{(k)})^{1/2}, Δ_k (2.7)–(2.8); polymer gas (2.9)–(2.11); exponentiation (2.12)–(2.13);
the bound of a term (2.14)–(2.26); the resummations (2.27)–(2.37); Lemma 3 (2.38); the effective action's bound (2.39)–(2.41).

### 1.2 Where the potential enters §2 (READ)

| Site | What the page does with the potential |
|---|---|
| (2.1), p. 12 | e^{Σ_Y V_Y} = Σ_D Π_{Y∈D}∫₀¹dt(Y) V_Y e^{t(Y)V_Y}: an algebraic identity, valid for any complex V_Y |
| (2.2)–(2.13), pp. 12–14 | the potentials enter only through F(Z₀, B); conditioning, decoupling, polymer gas, exponentiation do not see them |
| (2.14), p. 15 | Π_{Y∈D}V_Y e^{t(Y)V_Y} = Π_{Y∈D}(1/2πi)∮dτ(Y)/(τ(Y) − t(Y))² · exp[Σ_{Y∈D}τ(Y)V_k(Y, B)]: THE POTENTIAL IS RUN AT COMPLEX COUPLINGS τ(Y) |
| (2.15), p. 15 | |exp[Σ τ(Y)V_k(Y,B)]| ≤ exp[Σ |τ(Y)||V_k(Y,B)|], with the factor Π_{Y∈D}2/|τ(Y)| from the Cauchy kernel: ONLY THE MODULUS |V_k| IS USED |
| (2.18), p. 16 | the radius: 1/|τ(Y)| = E₀ε₁C₁α₄^{−1}M^q exp C₂κ₁ exp(−(1 − 3δ)κd_k(Y)) — the reciprocal of the potential's bound (1.36) |
| (2.19)–(2.20), p. 16 | |τ(Y)|·|½⟨Q(Y,B)B,B⟩| and |τ(Y)||V″_k| bounded by α₄-sized forms; Σ_{Y∈D}|τ(Y)||V_k(Y,B)| ≤ ½O(1)α₄Σ_{b⊂Y₀}|B(b)|² + O(1)α₄M^{−4}|Y₀|; assumptions ⅛(κ₁ − 1) ≥ (1 − 3δ)κ, C₃ ≤ E₀C₁, q ≥ 8 |
| (2.23)–(2.25), p. 17 | the α₄-form is absorbed into the Gaussian (α₅ = O(1)e^{−δ₀M/3} + O(α₀ + α₁) + O(1)α₄ + γ₂, α₅‖C^{(k)}(Z₀,0)‖ < ½) |
| p. 15 | analyticity in (U, J): "the potentials V_k(Y, B) … can be extended to functions of (U, J), analytic on U^c_{k+1}(Y, (1+β)α₀, (1+β)α₁, α₀)" |
| pp. 21–22 | gauge invariance of (2.14) from that of V_k (Lemma 2) |

So no step of §2 uses the reality, the sign, or a real-axis bound of the potential: it is run at complex couplings τ(Y) on
circles of radius α₄/(E₀ε₁C₁M^q e^{C₂κ₁}) · e^{(1−3δ)κd_k(Y)}, which is ≫ 1 because ε₁ is small.

### 1.3 Every occurrence of ε₁ in CMP 116, classified (READ) — the discharge of M3b's falsifier

RADIUS = ε₁ as the radius of the fluctuation domain |B| < ε₁/g_k (or a condition keeping a construction inside its domain);
FACTOR = ε₁ as the factor of a bound on the potential (or a condition on that factor); MIXED = anything else.

| Page / eq. | Text (verbatim in substance) | Role |
|---|---|---|
| p. 6 (1.20) | |B′| ≤ O(1)g_k|B| + 4C₂(O(1)g_k|B|)² ≤ C₁g_k|B| < C₁ε₁, "where … g_k|B| < ε₁" | RADIUS (B′ in the fixed-point domain |B′| < ε₃) |
| p. 6–7 (1.21) | |H_k(s(Y₀), B′)| ≤ 4B₀C₁e^{16κ₁}g_k|B| < 4B₀C₁e^{16κ₁}ε₁, "if e^{32κ₁}ε₁ is smaller than an absolute constant" | RADIUS |
| p. 7 | "We assume that 4B₀C₁e^{16κ₁}ε₁ ≤ ¼α₂" (so tζ̃_□H_k satisfies (I.3.31) with ½α₂) | RADIUS |
| p. 7 (1.22) | 1/|t_□| = 8B₀C₁e^{16κ₁}α₂^{−1}g_k|B| < 8B₀C₁e^{16κ₁}α₂^{−1}ε₁ | the extraction radius in t_□ (internal to building V_k, not the interaction coupling); its reciprocal is the FACTOR of (1.24), B-dependent |
| p. 7 (1.24) | |(1.23)| ≤ 8B₀C₁e^{16κ₁}α₂^{−1}g_k|B|E₀(α₁/α₃)⁵(L^jη)⁵exp(−(κ₁−1)M^{−4}|Y₀∖□̃⁴|)exp(−κd_j(X)) | FACTOR, moment form (g_k|B|) |
| p. 8 (1.29) | |Σ(1.23)| ≤ E₀ε₁O(M^q)exp O(1)κ₁ exp(−(1/16)κ₁d_k(Y)); "Another possibility is to use the expression g_k|B| instead of ε₁. It gives a better bound, but the above is simpler." | FACTOR |
| p. 8–9 (1.30) | E₀24B₀²C₁B₃e^{16κ₁}α₂^{−1}ε₁exp(…) | FACTOR |
| p. 9 (1.34) | domain {B : |B| < ε₁g_k^{−1} on Y} | RADIUS |
| p. 9 (1.36) | |V′_k(Y,U,J,B)| ≤ E₀ε₁C₁M^q exp C₂κ₁ exp(−(1 − 2δ)κd_k(Y)) | FACTOR |
| p. 10 (1.39) | |(1.38)| ≤ C₃(e^{16κ₁}|B′|)³M⁴exp(−(κ₁−1)M^{−4}|Y∖□|) on {e^{16κ₁}|B′| ≤ a₁} | FACTOR (|B′|, moment form) / RADIUS (domain) |
| p. 10 (1.40) | ≤ ½C₃3³e^{7·8κ₁}|B′|exp(−⅛(κ₁−1)d_k(Y) − ½(κ₁−1)M^{−4}|Y|), "if e^{16κ₁}|B′| ≤ ⅓a₁" | FACTOR (|B′|) / RADIUS |
| p. 10–11 | "Taking B′ as in (1.19) we obtain the above bound with |B′| replaced by C₁ε₁" | FACTOR (the sup-form replacement) |
| p. 11 (1.43) | |Q(Y,B,b,b′)| ≤ C₃ε₁M⁴exp C₂κ₁ exp(…); V″_k satisfies (1.36) | FACTOR |
| p. 12 (2.3) | χ^c_{k,P} = Π_{b∈P}χ({|B(b)| ≥ ε₁/g_k}) | RADIUS |
| p. 16 (2.18) | 1/|τ(Y)| = E₀ε₁C₁α₄^{−1}M^q exp C₂κ₁ exp(−(1 − 3δ)κd_k(Y)) | FACTOR (definition of the radius from the bound) |
| p. 16 (2.22) | χ_{k,Y₀}χ^c_{k,P} ≤ exp(−½γ₂(ε₁²/g_k²)|P| + ½γ₂‖PB‖²) | RADIUS |
| p. 17 (2.26) | [Π_{Y∈D}2E₀ε₁C₁α₄^{−1}M^q exp C₂κ₁ exp(−(1 − 3δ)κd_k(Y))] exp(−½γ₂(ε₁²/g_k²)|P|) | FACTOR in [ ], RADIUS in the P-exponential |
| p. 18 (2.28) | "Assuming 2E₀ε₁C₁α₄^{−1}α₆^{−1}M^q exp C₂κ₁ exp 5κ ≤ 1" | FACTOR |
| p. 18 (2.31) | the P-sum ≤ 1 "for g_k², i.e. γ² sufficiently small, depending on M and κ" | RADIUS |
| p. 18–19 | "Assuming (1/20)γ₂ε₁²/g_k² ≥ (1/20)γ₂ε₁²/γ² ≥ 4κ" | RADIUS |
| p. 19 (2.33) | ε₂ := 2E₀ε₁C₁α₄^{−1}α₆^{−1}M^q exp C₂κ₁; [Π_i ε₂ e^{−(1−4δ)κd_k(Y_i)}] e^{−(1/10)γ₂(ε₁²/g_k²)M^{−4}|Z₀∖Y₀|} ≤ max{ε₂, exp(−(1/20)γ₂ε₁²/γ²)} e^{−(1−4δ)κd_k(Z₀)}; "We have used the assumption ε₂ ≤ 1" | FACTOR (ε₂), RADIUS (the exponential) |
| p. 19 | "For simplicity let us assume that exp(−(1/20)γ₂ε₁²/γ²) ≤ ε₂" | MIXED — the one site: a factor used as a LOWER bound for a radius tail |
| p. 19 (2.34)–(2.35) | the (Z₀∖Y₀)-sum; Π_i ε₂ exp(−(1 − 5δ)κd_k(Z_i)) | RADIUS / FACTOR |
| p. 20 | "assuming that (L+2)⁴O(1)ε₂ ≤ ½"; "Assuming that 2(L+2)⁴O(1)ε₂ exp 5κ ≤ 1"; C₃ := 2(L+2)⁴O(1)2E₀C₁α₄^{−1}α₆^{−1}M^q exp C₂κ₁ | FACTOR |
| p. 20 (2.38) | Lemma 3: |H(Z)| ≤ C₃ε₁ exp(−(1 − 8δ)½Lκd_{k+1}(Z)) | FACTOR |
| p. 21 (2.39)–(2.40) | "To the above sum we can repeat all the considerations and bounds of the paper [26], for κ sufficiently large, and ε₁ sufficiently small" | FACTOR (smallness of the activity C₃ε₁e^{5κ}; the [26] constant is not stated — carried below by name, c_{[26]}) |
| p. 21 (2.41) | |E^{(k+1)}(X)| ≤ O(1)C₃ε₁ exp(−(1 − 10δ)½Lκd_{k+1}(X)); "we assume that O(1)C₃ε₁ ≤ ½E₀. In fact this assumption is unessential" | FACTOR |

VERDICT ON M3b's FALSIFIER ("a step where ε₁ is neither the cutoff radius nor a factor of an interaction bound"): NOT MET IN
SUBSTANCE. Exactly one MIXED site exists, p. 19's "for simplicity" assumption e^{−γ₂ε₁²/(20γ²)} ≤ ε₂. It is not load-bearing:
the line before it states the bound as max{ε₂, e^{−γ₂ε₁²/(20γ²)}}, and every later use of ε₂ ((2.35), p. 20, (2.38)–(2.41)) is
a smallness condition that the max satisfies as soon as both entries satisfy it. Below it is replaced by
ε₂* := max{ε₂, t₂}, t₂ := exp(−(1/20)γ₂ε₁²/γ²). (It matters only as s → 0, where ε₂ ∝ |s| falls below t₂: the assumption is
false there and the max is right.)
The extraction radius (1.22) — "a smallness of the bound used to choose a Cauchy radius", M3b's own example of the falsifier
— is internal to §1's construction of V_k (the variable t_□ is the extraction parameter of a Part I term, not the coupling of
the interaction); the interaction coupling multiplies the constructed V_k afterwards. It is RADIUS for the purposes here.

## 2. LEMMA M — CMP 116 §2 IS A THEOREM ABOUT A CONE OF POTENTIALS (PROVED, from the reading of §1)

DEFINITION (the class 𝒱(ε)). Let ε ≥ 0. A potential U = (U(Y, ·))_{Y∈D_k} is in 𝒱(ε) if
 (M-i) each U(Y, U, J, B) is defined and analytic on U^c_{k+1}(Y, (1+β)α₀, (1+β)α₁, α₀) × {B : |B| < ε₁g_k^{−1} on Y}, depends on
   U, J, B in the interior of Y only, satisfies (1.35), and is gauge invariant under the transformations of Lemma 2 (p. 11);
 (M-ii) U(Y,B) = ½⟨Q_U(Y,B)B, B⟩ + U″(Y,B) with
   |Q_U(Y,B,b,b′)| ≤ ε M⁴ e^{C₂κ₁} exp(−⅛(κ₁ − 1)d_k(Y) − ½(κ₁ − 1)M^{−4}|Y|),                              (M.1)
   |U″(Y,B)| ≤ ε M^q e^{C₂κ₁} exp(−(1 − 2δ)κd_k(Y)).                                                          (M.2)
BAŁABAN'S POTENTIAL IS IN THE CLASS: V_k ∈ 𝒱(E₀C₁ε₁) by Lemma 2 ((1.43) with the p. 16 assumption C₃ ≤ E₀C₁; (1.36) for V″_k).
Bałaban's assumption "C₃ ≤ E₀C₁" (p. 16) is exactly the statement that ONE parameter bounds both parts.
THE CONE PROPERTY (PROVED). U ∈ 𝒱(ε), U′ ∈ 𝒱(ε′), a, b ∈ ℂ ⇒ aU + bU′ ∈ 𝒱(|a|ε + |b|ε′): take Q_{aU+bU′} := aQ_U + bQ_{U′},
(aU + bU′)″ := aU″ + bU′″; (M.1)–(M.2) by the triangle inequality; (M-i) is linear.

CONSTANTS (all Bałaban's, named where they enter). c₂′ := 2α₄^{−1}α₆^{−1}M^q e^{C₂κ₁}; C₃′ := 2(L+2)⁴O(1)_{p.20}; t₂ := exp(−(1/20)γ₂ε₁²/γ²);
ε₂(ε) := εc₂′, ε₂*(ε) := max{ε₂(ε), t₂}; c_{[26]} the convergence constant of [26] used at (2.39) (not stated on the page; carried
by name, as Bałaban carries it);
  ε_* := min{ 1/(c₂′e^{5κ}),  1/(2(L+2)⁴O(1)_{p.20}c₂′e^{5κ}),  c_{[26]}/(C₃′c₂′e^{5κ}) }.
(The first is (2.28); the second p. 20's two conditions together with ε₂ ≤ 1 of (2.33); the third (2.39). The Cauchy-radius
condition R_U ≥ 2 below, i.e. εα₄^{−1}M^q e^{C₂κ₁} ≤ ½, is implied by the first since α₆e^{−5κ} ≤ 1.) γ is taken so small that
t₂ also satisfies the second and third conditions (in place of εc₂′) — the order ε₁ before γ, Bałaban's.

LEMMA M. For every U ∈ 𝒱(ε) with ε ≤ ε_*:
 (a) CMP 116's expansion (2.1)–(2.13) of ∫dμ_{C^{(k)}}(B)χ_k exp[Σ_Y U(Y, B)] holds, with activities
     |H(Z)| ≤ C₃′ ε₂*(ε) exp(−(1 − 8δ)½Lκd_{k+1}(Z))   [(2.38) with C₃ε₁ ↦ C₃′ε₂*(ε)];
 (b) (2.12)–(2.13) converge and |E(X)| ≤ O(1)_{(2.41)}C₃′ ε₂*(ε) exp(−(1 − 10δ)½Lκd_{k+1}(X))   [(2.41)];
 (c) every E(X) is analytic in (U, J) on U^c_{k+1}(X, α₀, α₁) and gauge invariant (p. 15, pp. 21–22);
 (d) if U = U_p depends on parameters p in an open P ⊂ ℂ^m, each U_p(Y, B) jointly analytic in (p, B, U, J), with U_p ∈ 𝒱(ε(p)),
     sup_P ε(p) ≤ ε_*, then H(Z; p) and E(X; p) are analytic in p on P, with the bounds (a)–(b) at ε = ε(p).
CHECK OF CONSISTENCY: at U = V_k, ε = E₀C₁ε₁: ε₂(ε) = 2E₀ε₁C₁α₄^{−1}α₆^{−1}M^q e^{C₂κ₁} is Bałaban's ε₂ (p. 19), and
C₃′ε₂(ε) = 2(L+2)⁴O(1)·2E₀C₁α₄^{−1}α₆^{−1}M^q e^{C₂κ₁}·ε₁ is Bałaban's C₃ε₁ (p. 20). So (a)–(b) reproduce Lemma 3 and (2.41).

PROOF. Bałaban's §2, with E₀C₁ε₁ replaced by ε at every FACTOR site of §1.3 and nothing changed at the RADIUS sites; the sites
where the potential enters are those of §1.2. In order:
 (i) (2.1) is an identity for any complex potentials. The steps (2.2)–(2.13) do not involve the potential.
 (ii) THE CAUCHY REPRESENTATION, (2.14). For fixed (σ, X, B) the function τ ↦ exp[Σ_{Y∈D}τ(Y)U(Y, B)] is entire, and
   Π_{Y∈D}U(Y,B)e^{t(Y)U(Y,B)} = Π_{Y∈D}∂_{t(Y)}exp[Σ t(Y′)U(Y′,B)]. Take for τ(Y) the circle CENTRED AT t(Y) ∈ [0,1] of radius
   r(Y) := R_U(Y) − 1, where (THE RADIUS, (2.18) with E₀ε₁C₁ ↦ ε)
     R_U(Y) := α₄ ε^{−1} M^{−q} e^{−C₂κ₁} exp((1 − 3δ)κd_k(Y)).
   The Cauchy kernel gives exactly (1/2π)∮|dτ(Y)|/|τ(Y) − t(Y)|² = 1/r(Y) ≤ 2/R_U(Y) whenever R_U(Y) ≥ 2, and |τ(Y)| ≤ R_U(Y) on the
   circle. (Bałaban's factor Π 2/|τ(Y)| in (2.15); the condition R_U ≥ 2, implicit on the page, is implied by ε ≤ ε_*.) Fubini
   puts the τ-integrals inside the (σ, X, B)-integrals; the bound below makes everything absolutely convergent.
 (iii) THE MODULUS BOUND, (2.15): |exp[Σ τ(Y)U(Y,B)]| ≤ exp[Σ_{Y∈D}R_U(Y)|U(Y,B)|]; every other factor of (2.15) (σ-Cauchy factors,
   determinants, the complex Gaussian replaced by its real part) is the page's, potential-independent.
 (iv) (2.19)–(2.20) HOLD VERBATIM. By (M.1): R_U(Y)|Q_U(Y,B,b,b′)| ≤ α₄M^{4−q} exp([(1 − 3δ)κ − ⅛(κ₁ − 1)]d_k(Y)) exp(−½(κ₁ − 1)M^{−4}|Y|)
   ≤ α₄M^{−4}exp(−½(κ₁ − 1)M^{−4}|Y|), by q ≥ 8 and ⅛(κ₁ − 1) ≥ (1 − 3δ)κ (p. 16's assumptions); the split of ½(κ₁ − 1)M^{−4}|Y| into
   the two factors of (2.19), exp(−¼(κ₁ − 1)M^{−4}|Y| − (1/16)(κ₁ − 1)M^{−1}|b₋ − b′₋|), is the page's geometric step for b, b′ ⊂ Y,
   independent of the potential. By (M.2): R_U(Y)|U″(Y,B)| ≤ α₄exp(−δκd_k(Y)). Summing over Y ∈ D exactly as on p. 16:
     Σ_{Y∈D}R_U(Y)|U(Y,B)| ≤ ½O(1)α₄ Σ_{b⊂Y₀}|B(b)|² + O(1)α₄M^{−4}|Y₀|.                                              (2.20)_U
   ε HAS CANCELLED: the radius is the reciprocal of the bound. (2.21)–(2.25) are then the page's, potential-independent.
 (v) (2.26)_U: |(2.14)_U| ≤ exp(−(κ₁ − 1)(LM)^{−4}|Z∖Z₀′|)·[Π_{Y∈D}2εα₄^{−1}M^q e^{C₂κ₁}exp(−(1 − 3δ)κd_k(Y))]·exp(−½γ₂(ε₁²/g_k²)|P|)·exp O(1)α₅|Z|.
 (vi) (2.28)_U: under 2εα₄^{−1}α₆^{−1}M^q e^{C₂κ₁}e^{5κ} ≤ 1 (first entry of ε_*), the product over Y ∈ D is ≤ Π_{Y∈D}α₆e^{−δκd_k(Y)} ·
   ε₂(ε) exp(−(1 − 4δ)κd_k(Y₀)) per connected Y₀, by (2.27). (2.29)–(2.32) are potential-independent ((2.31) RADIUS).
 (vii) (2.33)_U: per component Z₀ of the cutoff set, the factor is ε₂(ε) if Y₀ ≠ ∅ and t₂ if Y₀ = ∅ (using ε₂(ε) ≤ 1); THE "FOR
   SIMPLICITY" ASSUMPTION OF p. 19 IS NOT MADE: ε₂*(ε) = max{ε₂(ε), t₂} is carried. (2.34)–(2.37) with ε₂ ↦ ε₂*(ε); p. 20's two
   conditions hold by the second entry of ε_* and the choice of γ.
 (viii) Lemma 3: |H(Z)| ≤ C₃′ε₂*(ε)exp(−(1 − 8δ)½Lκd_{k+1}(Z)). (2.39)–(2.41): the [26] estimate applies under C₃′ε₂*(ε)e^{5κ} ≤ c_{[26]}
   (third entry of ε_*, and γ), giving (b). (2.41)'s "O(1)C₃ε₁ ≤ ½E₀" is a condition on the OUTPUT used only to continue the
   induction, not by the expansion; it is imposed when the output is fed back (§8).
 (c) p. 15's argument uses only (M-i) for the potentials and the room α′₀, α′₁ ≫ α₀, α₁ of the quadratic forms and covariances;
   pp. 21–22 use only gauge invariance of the potentials and of the operators.
 (d) Each term of (2.1)·(2.3) after conditioning is an integral, over compact parameter sets (t ∈ [0,1]^D, σ on its circles) and
   over (X, B) against the Gaussian weights, of an integrand analytic in p for each fixed value of the integration variables;
   by (ii)–(v) it is dominated, uniformly for p in compact subsets of P, by the integrable bound (2.26)_U at ε = sup ε(p). So each
   term is analytic in p (dominated convergence for the complex derivative / Morera); the resummed activity H(Z; p) is a series
   of such terms converging uniformly by (vi)–(viii); E(X; p) is the uniformly convergent series (2.13). Weierstrass. ∎

WHAT LEMMA M SAYS IN WORDS. Bałaban's §2 never asks what the potential is: it asks for (M-i)–(M-ii) with a small ε, runs the
potential at complex couplings out to the radius ε^{−1}α₄M^{−q}e^{−C₂κ₁}, and returns activities proportional to ε. Every complex
deformation of the interaction that stays in the cone with a small parameter — a complex multiple, a complex history, a complex
coupling deviation — is handled by the theorem that is already on the page.

## 3. LEMMA BB4* (PROVED) — THE COMPLEX-s DISC, AND THE BOUNDS LEMMA C CONSUMES

Let ε₁^max := ε_*/(E₀C₁): the largest ε₁ for which CMP 116's own factor conditions hold at s = 1 (Lemma M at U = V_k). Bałaban's
proof requires ε₁ ≤ ε₁^max. Put R₀ := ε₁^max/ε₁ ≥ 1. (Bałaban's order fixes ε₁ before γ, as small as wanted; ε₁ = ε₁^max/(1 + δ)
gives R₀ = 1 + δ, M3R's disc; ε₁ = ε₁^max/4 gives R₀ = 4. The constant in R₀ is Bałaban's room, not a new quantity.)

THEOREM BB4*. For every complex s with |s| < R₀ the interaction sV_k is in 𝒱(|s|E₀C₁ε₁) ⊂ 𝒱(ε_*); hence CMP 116's expansion of
∫dμ_{C^{(k)}}χ_k e^{sΣV_k(Y,B)} converges with the activities and effective-action bounds of Lemma M at ε = |s|E₀C₁ε₁, uniformly
in s, at complex backgrounds; E^{(k+1)}(X; s) is analytic in s on |s| < R₀ and
   |E^{(k+1)}(X; s)| ≤ M_X := O(1)C₃′ max{ε_*c₂′, t₂} exp(−(1 − 10δ)½Lκd_{k+1}(X)).
Moreover, for |s| < R₀,
   |E^{(k+1)}(X; s) − E^{(k+1)}(X; 0)| ≤ 2M_X |s|/R₀ = 2M_X (E₀C₁/ε_*) |s| ε₁,                                     (3.1)
and if R₀ ≥ 4, for |s| ≤ 1,
   |∂_s²E^{(k+1)}(X; s)| ≤ 12 M_X/R₀² = 12 M_X (E₀C₁/ε_*)² ε₁².                                                   (3.2)
At s = 0 the potential is 0 ∈ 𝒱(0): the expansion is the pure large-field expansion, ε₂*(0) = t₂, and each activity carries the
per-bond factor exp(−½γ₂ε₁²/g_k²) of (2.22) — the localization of log⟨χ_k⟩_G (M3R's item (d)).
PROOF. Cone property; Lemma M (a)–(d) with p = s, P = {|s| < R₀}. (3.1): h(s) := E(X;s) − E(X;0) is analytic on |s| < R₀,
h(0) = 0, |h| ≤ 2M_X; Schwarz's lemma. (3.2): Cauchy's formula for h″ on the circle |s′ − s| = R₀/2 (inside |s′| ≤ 3R₀/4 since
|s| ≤ 1 ≤ R₀/4), on which |h| ≤ 2M_X(3/4) by (3.1): |h″(s)| ≤ 2·(3/2)M_X/(R₀/2)² = 12M_X/R₀². ∎
THE 1/ε_* IS BAŁABAN'S ROOM: (3.1)–(3.2) are bounds by ε₁/ε₁^max and its square, times the activity scale M_X.

CONSEQUENCES FOR M3R's FOUR ITEMS (PROVED). (a) M[⟨I; I⟩_s] exists and M commutes with ∫₀¹ds: φ(s) = Σ_X E(X; s) with the
localized bounds uniform in s on the closed unit disc; M is, term by term, a bounded linear functional (two background
derivatives by Cauchy on Bałaban's absolute polydisc of (c), then the second moment, summable by the exponential decay), so
Fubini applies. (b) sup_{s∈[0,1]}|M[⟨I; I⟩_s]| ≤ C ε₁², C = 12·(E₀C₁/ε_*)²·(the M-norm of the profile M_X) — M3's bound (iii),
uniformly at complex backgrounds. (c) the moment form: §4. (d) the s = 0 end: as stated above.

## 4. THE MOMENT FORM (PROVED GIVEN the B-dependent bounds READ at (1.20), (1.24), (1.40)) — ρ_{k+1} ≤ C g_k

4.1 WHERE BAŁABAN'S BOUNDS ARE B-DEPENDENT (READ). Before the sup-replacements on p. 8 and p. 11 the bounds carry the local
size of the fluctuation, not ε₁:
 – the history part: the extraction radius 1/|t_□| = 8B₀C₁e^{16κ₁}α₂^{−1}g_k|B| (1.22) makes (1.24) carry the factor g_k|B|;
   (1.29) then writes ε₁ for it, with p. 8's remark "Another possibility is to use the expression g_k|B| instead of ε₁. It
   gives a better bound, but the above is simpler";
 – the Wilson part: the quadratic-form coefficients (1.40) carry |B′| ("≤ ½C₃3³e^{7·8κ₁}|B′|exp(…)") before p. 11's
   "Taking B′ as in (1.19) we obtain the above bound with |B′| replaced by C₁ε₁", and (1.20) gives |B′| ≤ C₁g_k|B|.
Here |B| is the admissible norm of B on the term's localization domain: the localized term depends on B restricted to it (p. 4:
"all propagators and the function B are restricted to Y₀"). Write ‖B‖_Y for it.

DEFINITION. U ∈ 𝒱_m(ε; ε_m) if U ∈ 𝒱(ε) and moreover (M.1)–(M.2) hold with ε replaced by a function ε_U(Y, B) satisfying
ε_U(Y,B) ≤ ε on the domain and ε_U(Y,B) ≤ ε_m g_k‖B‖_Y. By 4.1, V_k ∈ 𝒱_m(E₀C₁ε₁; ε_m) with ε_m an absolute constant (from
(1.24), (1.40), (1.20)). The cone property holds with ε_U added.

4.2 LEMMA M_m (PROVED). Let U ∈ 𝒱_m(ε; ε_m), ε ≤ ε_*, and let U_s := sU, |s| < R := ε_*/ε. Then for |s| < R
   |E(X; U_s) − E(X; 0)| ≤ C₅ |s| ε_m g_k exp(−(1 − 11δ)½Lκd_{k+1}(X)),                                           (4.1)
with C₅ := O(1)C₃′C_mom c₂′ (C_mom below); and if R ≥ 4, for |s| ≤ 1,
   |∂_s²E(X; U_s)| ≤ 6C₅ ε_m g_k/R · exp(−(1 − 11δ)½Lκd_{k+1}(X)).                                                    (4.2)
PROOF. (i) POINTWISE RADII. In Lemma M (ii) take, for each fixed (σ, X, B), the τ(Y)-circle centred at t(Y) with
1 + r(Y,B) := R_U(Y,B) := α₄ ε_{U_s}(Y,B)^{−1}M^{−q}e^{−C₂κ₁}exp((1 − 3δ)κd_k(Y)), where ε_{U_s}(Y,B) = |s|ε_U(Y,B). The Cauchy formula is
applied pointwise in B, legitimately, since τ ↦ exp[Σ τ(Y)U_s(Y,B)] is entire for fixed B; if ε_{U_s}(Y,B) = 0 then U_s(Y,B) = 0 by
(M.1)–(M.2), the integrand does not depend on τ(Y), and the Mayer derivative ∂_{t(Y)} kills the term. R_U(Y,B) ≥ R_U(Y) ≥ 2 because
ε_{U_s}(Y,B) ≤ |s|ε ≤ ε_*. Then (2.15)–(2.20) hold pointwise in B verbatim (Lemma M (iii)–(iv); ε has cancelled), and the activity
factor Π_{Y∈D}2/R_U(Y,B) = Π_{Y∈D}2|s|ε_U(Y,B)α₄^{−1}M^q e^{C₂κ₁}e^{−(1−3δ)κd_k(Y)} stands inside the B-integral of (2.23).
(ii) ONE MOMENT FACTOR. For a term with D ≠ ∅ fix Y₁ ∈ D; bound ε_U(Y,B) ≤ ε for Y ≠ Y₁ and ε_U(Y₁,B) ≤ ε_m g_k‖B‖_{Y₁}.
(iii) ABSORPTION. ‖B‖_{Y₁} ≤ Σ_{b⊂Y₁⁺}|B(b)| (Y₁⁺ the support of the admissible norm, |Y₁⁺| ≤ C|Y₁|), and x ≤ (ea)^{−1/2}e^{ax²/2}
for x ≥ 0, a > 0 (maximise x e^{−ax²/2} at x = a^{−1/2}); with a = α₅: ‖B‖_{Y₁} ≤ |Y₁⁺|(eα₅)^{−1/2}exp(½α₅‖Z₀B‖²). The B-integral of
(2.23) then runs with α₅ ↦ 2α₅, requiring 2α₅‖C^{(k)}(Z₀,0)‖ < ½: Bałaban's condition with his own free small constants α₄, γ₂
halved (α₅ = O(1)e^{−δ₀M/3} + O(α₀ + α₁) + O(1)α₄ + γ₂). |Y₁⁺| ≤ C(3·2³d_k(Y₁) + C)M⁴ by (2.30), absorbed by e^{−δκd_k(Y₁)} at the cost
C_mom := C M⁴(eα₅)^{−1/2}sup_{d≥0}(24d + C)e^{−δκd}; this spends one δ of the exponent, whence 11δ for 10δ (δ is re-fixed by
(1 − 11δ)½L = 1 in place of p. 21's (1 − 10δ)½L = 1).
(iv) RESUMMATION. In (2.28) keep the bracket of Y₁ (not bounded by 1) and bound the others by 1: the component of Y₀ containing Y₁
carries 2|s|ε_m g_k C_mom α₄^{−1}α₆^{−1}M^q e^{C₂κ₁} = |s|ε_m g_k C_mom c₂′ in place of ε₂. All other steps as in Lemma M. Every term of
H(Z; U_s) − H(Z; 0) has D ≠ ∅, so |H(Z; U_s) − H(Z; 0)| ≤ C₃′C_mom c₂′|s|ε_m g_k exp(−(1 − 9δ)½Lκd_{k+1}(Z)).
(v) The cluster expansion (2.13) telescoped: E(X; U_s) − E(X; 0) = Σ_n(1/n!)Σρ^T[Π H(Z_i; U_s) − Π H(Z_i; 0)], each difference of products
having exactly one factor H(Z_i; U_s) − H(Z_i; 0) and the others bounded by Lemma M (a); the [26] estimate with one marked polymer
gives (4.1). (4.2): Cauchy for h″ on |s′ − s| = R/2 with (4.1): |h″| ≤ 2·C₅(3R/4)ε_m g_k/(R/2)² = 6C₅ε_m g_k/R. ∎

4.3 LEMMA C IN MOMENT FORM (PROVED GIVEN (BB1)–(BB3), (BB5) of M3 §5.4; (BB4) is now Lemma M). With U = V_k, ε = E₀C₁ε₁,
R = R₀ = ε₁^max/ε₁:
   ρ_{k+1}(g_k) ≤ |M[log⟨χ_k⟩_G]| + |M[⟨I⟩₀]| + ∫₀¹(1 − s)|M[φ″(s)]|ds ≤ C₁e^{−c₁ε₁²/g_k²} + C₂g_k² + C₃ε₁g_k,         (4.3)
the first term by Theorem BB4* at s = 0, the second by M3's (ii) (parity of μ_G and χ_k and explicit Gaussian moments; without the
parity argument (4.1) at s → 0 gives C g_k, also enough), the third by (4.2): M[φ″(s)] ≤ ‖M‖·6C₅ε_m(E₀C₁/ε_*)ε₁g_k. So
ρ_{k+1} ≤ C g_k + C₁e^{−c₁ε₁²/g_k²}: THE MOMENT FORM AT POWER a = 1, the one M3b §7.4 asked for, now with its coefficient ε₁g_k (it
vanishes as g → 0 at fixed ε₁). M3R's (c) is discharged. The order g_k² for the variance needs two marked insertions — the second
Mayer derivative represented with the kernel 2/(τ − t)³ and two pointwise radii — the same proof with two moment factors; it is
not needed: §6.3's summation and the rate g₀ ~ (8b₀ ln ε^{−1})^{−1/2} need only a > 0 (M3b §7.4, SUFFICIENCY).

## 5. THE D-TERM (PROVED GIVEN [13]'s random-walk expansion of Δ^{(k)}, the black box Bałaban cites on CMP 116 p. 13)

5.1 WHAT THE D-TERM IS (READ, CMP 109 (2.5), (2.8), (2.10)–(2.12)). The step's integrand is
exp[−(1/g_k²)G(B′) − (1/g_k²)A(U_{k+1}) − (1/g_k²)⟨H₁B′, J⟩ − (1/(2g_k²))⟨H₁B′, Δ₁H₁B′⟩ − (1/g_k²)V(H₁B′) + E_k(…)] (2.10), with the
GAUGE FIXING G(B′) = ½G^{(2)}(B′) + G₃(B′), G^{(2)}(B′) = Σ_{y∈T^{(k+1)}}Σ_{x∈B(y),x≠y}|B̃′(y,x)|² (2.5) carrying its OWN factor 1/g_k²,
and the Wilson action's expansion A(U_k(V′V^{(k)})) = A(U_{k+1}) + ⟨H₁B′, J⟩ + ½⟨H₁B′, Δ₁H₁B′⟩ + V(H₁B′) (2.8). After B′ = B − hD̃(B),
the elimination of B′(b₀(c)) (B′ = CB) and the scaling B = g_kB′, the linear term vanishes ("⟨δA′, J⟩ = 0 for all δA′ satisfying
the condition Q̃Q_kδA′ = 0, and H₁B′ satisfies it", p. 267) and the order-zero terms ⟨H₁hC̃^{(2)}(B′), J⟩ − ½G^{(2)}(B′) − ½⟨H₁B′, Δ₁H₁B′⟩
form −½⟨B′, Δ^{(k)}B′⟩ (2.11); C^{(k)} = (C*Δ^{(k)}C)^{−1} (p. 268).
THE DEVICE (LFR I p. 187, READ by M3b): the Wilson coefficient x_k + D, the gauge-fixing weight and every cutoff at the reference.
The exact transformation does not depend on the gauge-fixing weight: CMP 109 (0.15) (READ) states, for y ∈ T^{(1)}, x ∈ B(y), x ≠ y,
(1/z)∫du(x)exp[−(1/α)[1 − Re tr U(y,x)u^{−1}(x)]]χ(…) = (1/z)∫du(x)exp[−(1/α)[1 − Re tr u(x)]]χ(…) = 1 for every α, and (0.16) is the
Faddeev–Popov insertion "By the gauge invariance with respect to such transformations the integrand does not depend on u and the
integral over u is equal to 1". So the D-term is −D[A(U_k(V′V^{(k)})) − A(U_{k+1})] = −d·W, with
   d := D g_k² = D/x_k,   W := (1/g_k²)[⟨H₁B′, J⟩ + ½⟨H₁B′, Δ₁H₁B′⟩ + V(H₁B′)] = 𝒲(B) + W_{≥3}(B),
   𝒲(B) := ½⟨H₁CB, Δ₁H₁CB⟩ − ⟨H₁hC̃^{(2)}(CB), J⟩ — THE WILSON PART OF THE GAUSSIAN FORM: ½⟨B, C*Δ^{(k)}CB⟩ = 𝒲(B) + ½G^{(2)}(CB);
   W_{≥3} := (1/g_k²)[⟨H₁hD̃₃(g_kCB), J⟩·(−1) − ⟨H₁g_kCB, Δ₁H₁hD̃(g_kCB)⟩ + ½⟨H₁hD̃(g_kCB), Δ₁H₁hD̃(g_kCB)⟩ + V(H₁(g_kCB − hD̃(g_kCB)))],
the Wilson-derived terms of P^{(k)} in (2.12) (READ: (2.12) lists them, beside the d-independent Tr log, log σ and G₃ terms).
THE POINT: W_{≥3} is O(ε₁) (a subset of Bałaban's own P^{(k)} terms), but 𝒲 is a quadratic form with O(1) coefficients. A complex
coupling deviation perturbs the GAUSSIAN at relative size d, not at size ε₁.

5.2 LEMMA W (PROVED GIVEN [13], as cited on CMP 116 p. 13: "This construction was discussed in [13] for all operators determining
Δ_k"). (i) W_{≥3} ∈ 𝒱(E₀C₁ε₁) (in Bałaban's normalisation where the constants of all P^{(k)} terms satisfy C₃ ≤ E₀C₁; p. 11: "it
can be done in the same way for all terms in P^{(k)} … and we obtain the same decompositions and bounds"), and W_{≥3} ∈ 𝒱_m(E₀C₁ε₁; ε_m)
by 4.1. (ii) 𝒲 = Σ_{Y∈D_k}½⟨𝒲(Y)B, B⟩ with 𝒲(Y) analytic in (U, J) on Bałaban's domain (p. 15: the quadratic forms "are analytic
functions on the space of configurations (U, J) satisfying the conditions I.(i)-(iii) … with constants α′₀, α′₁ much bigger than
α₀, α₁"), localized, gauge covariant, and
   |𝒲(Y)(b, b′)| ≤ C_W M⁴e^{C₂κ₁}exp(−⅛(κ₁ − 1)d_k(Y) − ½(κ₁ − 1)M^{−4}|Y|),
C_W an absolute constant (dependent on B₀, ‖Δ₁‖, α₀, and on κ₁ only through e^{O(κ₁)}, absorbed by taking C₂ ≥ 56, as (1.40)'s
e^{7·8κ₁} already requires). So 𝒲 ∈ 𝒱(C_W) (with 𝒲″ = 0).
PROOF OF (ii). 𝒲's operator is C*Δ^{(k)}C minus the operator of ½G^{(2)}∘C, which is block-local ((2.5): a sum over blocks of the
squares of the linearized contour variables); Δ^{(k)} is assembled from H₁, Δ₁, h, C̃^{(2)}, J and the gauge-fixing form, and [13]
gives the generalized random-walk expansion of these operators — the same expansions CMP 116 (2.7)–(2.8) decouples. Decouple with
s(Δ) exactly as (1.37)–(1.38) do for (1/g_k²)V(H₁B′): the plaquette sum is localized by ζ_□, (1.10) gives for each □ the sum over
Y ⊃ □ of Π_{Δ⊂Y∖□}∫ds(Δ)(1/2πi)∮dσ(Δ)/(σ(Δ) − s(Δ))²·(the quadratic form with H₁(σ(Y))), and on |σ(Δ)| = e^{κ₁} the operators are
bounded by B₀e^{16κ₁} (the bound (1.11)) so the term is bounded by C(B₀e^{16κ₁})²‖Δ₁‖M⁴exp(−(κ₁ − 1)M^{−4}|Y∖□|) — the quadratic analogue
of (1.39), in which a quadratic form needs no Taylor step — and summing over □ ⊂ Y (the factor M^{−4}|Y| ≤ exp M^{−4}|Y|, p. 11) and
converting by (2.30) as p. 10 does for (1.40) gives the stated bound. The J-term carries |J| < α₀. Gauge covariance is preserved by the
decoupling as for Lemma 2 (p. 11; the random-walk expansions are covariant, [13] (3.28)–(3.34)). ∎

5.3 THEOREM BB4*-D (PROVED GIVEN Lemma W). Put θ_* := ε_*/(2(C_W + ε_*)). For complex s, d with |s| ≤ R₀/2 and |d| ≤ θ_*,
   U_{s,d} := sV_k − dW ∈ 𝒱(|s|E₀C₁ε₁ + |d|(C_W + E₀C₁ε₁)) ⊂ 𝒱(ε_*),
so CMP 116's expansion of ∫dμ_{C^{(k)}}χ_k exp[Σ_Y U_{s,d}(Y, B)] converges with the activities of Lemma M; E^{(k+1)}(X; s, d) is jointly
analytic on the polydisc, at complex backgrounds, with |E^{(k+1)}(X; s, d)| ≤ O(1)C₃′max{ε_*c₂′, t₂}exp(−(1 − 10δ)½Lκd_{k+1}(X)).
PROOF. Cone property with V_k ∈ 𝒱(E₀C₁ε₁) and W = 𝒲 + W_{≥3} ∈ 𝒱(C_W + E₀C₁ε₁); |s|E₀C₁ε₁ ≤ ε_*/2 since |s| ≤ ε₁^max/(2ε₁);
|d|(C_W + E₀C₁ε₁) ≤ θ_*(C_W + ε_*) = ε_*/2 since ε₁ ≤ ε₁^max. Lemma M with p = (s, d). ∎
THE CONSTANT θ₀ OF (S₁) IS FIXED HERE: θ₀ := θ_*, an absolute constant (it depends on M, κ, κ₁, α₄, α₆, L and the [26] constant, not
on ε₁ or γ), chosen after Bałaban's constants and before γ. TWO-FAMILY VERSION: when the s-derivative must carry an interaction
factor (§7.2), Mayer-expand e^{Σ_Y sU₁(Y) − Σ_Y d𝒲(Y)} over the disjoint union D_k ⊔ D_k of the two polymer families, each polymer with its
own τ-circle; Lemma M's proof applies verbatim (the index set of the Mayer expansion is any finite family of localized potentials),
the entropy of the choice of family a factor 2^{|D|} absorbed by α₆ (shrink α₆ by ½).

## 6. LEMMA FP — THE ONE-LOOP COUPLING DEFORMATION IS BACKGROUND-INDEPENDENT, EXACTLY (PROVED from CMP 109, READ)

WHY IT IS LOAD-BEARING. At fixed d the d𝒲-polymers contribute, at order g⁰, −½log det(1 + dC^{(k)}𝒲_op) — an O(d) one-loop term. If its
background dependence survived M, then sup_{|d|≤θ₀}|β^{(x)}(x + D) − a| would be O(θ₀), the Lipschitz constant ∂_xβ = O(g²), and Σ_j g_j²
diverges (log K): (S₁) would fail. M3b §15.3 took the needed statement as an INPUT ("the α-independence of Bałaban's gauge-fixed Gaussian at
fixed background"). It is a theorem.

STATEMENT. For every real background U_{k+1} in Bałaban's small-field domain (J = J_{k+1}(U_{k+1})), and then by analytic continuation for
every complex background in the domain, and every complex d with |d| ≤ θ₀,
   det(C*(Δ^{(k)} + d𝒲_op)C) / det(C*Δ^{(k)}C) = (1 + d)^{n_T},                                                         (6.1)
n_T := dim ker Q̃ − dim 𝔤·#(T^{(k)}∖T^{(k+1)}), a number independent of the background. Hence log∫dμ_{C^{(k)}}(B)e^{−d𝒲(B)} = −½n_T log(1 + d)
is background-independent and M[log∫dμ_{C^{(k)}}e^{−d𝒲}] = 0 for every |d| ≤ θ₀.

PROOF. Work on E := ker Q̃ (the image of C; the δ-function δ(Q̃B) eliminates B′(b₀(c)), p. 268). Write q_c(B) := c𝒲(B) + ½G^{(2)}(B) on
E; q₁ = ½⟨·, Δ^{(k)}·⟩|_E by (2.11), and q₁ + d𝒲 = q_{1+d}.
(FP1) THE RESIDUAL GROUP AND ITS ORBIT. R := {scale-k gauge transformations u with u(y) = 1 for y ∈ T^{(k+1)}} — exactly the group under
which "the underintegral expression in (0.13) is still invariant" and which the gauge fixing removes (CMP 109 p. 254, READ). It preserves
the constraint (the δ-functions δ(Ū(c)V^{−1}(c)) see u only at coarse sites, p. 254) and acts on the configurations V′V^{(k)} near V^{(k)},
hence on E near 0 through the exact parametrization B ↦ exp(i(g_kCB − hD̃(g_kCB)))V^{(k)} of the constraint surface (CMP 109 p. 267:
"there exists exactly one solution … analytic"). Let G := T₀(R·0) ⊂ E, the tangent space of the orbit through B = 0.
(FP2) 𝒲 ANNIHILATES G. F(B) := (1/g_k²)A(U_k(exp(iB′(B))V^{(k)})) is R-invariant: for a scale-k gauge transformation u, the fine
configurations with k-step averages W^u are the ũ-transforms of those with averages W, for any fine extension ũ of u (covariance of the
averages, CMP 109 (0.6)), A is gauge invariant, and the minimal configuration is the unique critical orbit (CMP 102 Theorem 1, p. 279, read
by M3), so A(U_k(W^u)) = A(U_k(W)). B = 0 is a critical point of F (the vanishing of the linear term, p. 267). By (2.8) and B′ = g_kCB −
hC̃^{(2)}(g_kCB) + O(B³), Hess F(0) = 2𝒲 exactly (the J-term's second order and ½⟨H₁·,Δ₁H₁·⟩; V starts at third order). For an invariant
function at a critical point the Hessian kills the orbit's tangent: differentiate F(exp(tξ)·c(r)) = F(c(r)) in t at 0, then in r at 0:
Hess F(0)(ξ_0, c′(0)) + dF(0)(∂_rξ_{c(r)}) = 0, and dF(0) = 0. So 𝒲(ξ, X) = 0 for ξ ∈ G, X ∈ E.
(FP3) THE SLICE. Let L : E → ⊕_{y∈T^{(k+1)}}⊕_{x∈B(y),x≠y}𝔤, LB := (B̃′(y,x)) the linearized contour variables, so ½G^{(2)}(B) = ½‖LB‖² (2.5).
Under R the contour variables transform as U(y,x) ↦ U(y,x)u^{−1}(x) (CMP 109 (0.15), READ, with u(y) = 1). So for ω ∈ Lie R the orbit
tangent has B̃′(y,x) = −Ad_{V^{(k)}(y,x)}ω(x) (up to the fixed factor i of the exponential coordinates): L∘(orbit map) is block-diagonal over
the sites x ∈ T^{(k)}∖T^{(k+1)} — each in exactly one block B(y), the blocks partitioning T^{(k)} (centred cubes, CMP 109 (0.3), M3b §15.1) —
with invertible blocks. Hence L|_G : G → ⊕𝔤 is a bijection, dim G = dim 𝔤·#(T^{(k)}∖T^{(k+1)}), and with T := ker L ⊂ E: G ∩ T = 0 and
dim G + dim T = dim E (L|_E is onto because L|_G is). So E = G ⊕ T, dim T = n_T.
(FP4) BLOCK-DIAGONALITY. For g, g′ ∈ G and t, t′ ∈ T: q_c(g + t, g′ + t′) = ½⟨Lg, Lg′⟩ + c𝒲(t, t′), the cross terms vanishing because
𝒲(g, ·) = 0 (FP2, 𝒲 symmetric) and ⟨Lg, Lt′⟩ = 0 (Lt′ = 0). In a basis adapted to G ⊕ T, q_c = diag(½L*L|_G, c𝒲|_T), and the change of
basis from a fixed basis of E contributes the same factor to q_{1+d} and q₁. So det q_{1+d}/det q₁ = (1 + d)^{n_T}. Translating back through
the fixed linear map C gives (6.1). For complex backgrounds both sides of (6.1) are analytic in the background on Bałaban's (connected)
domain and agree on its real points, a totally real submanifold of full dimension; so they agree everywhere. The Gaussian integral is
det(1 + dC^{(k)}𝒲_op)^{−1/2} (Re(C^{(k)−1} + d𝒲_op) > 0 for |d| ≤ θ₀ small, the branch fixed by continuity from d = 0). ∎
REMARKS. (1) The identity is the one-loop shadow of (0.15)–(0.16): a change of the Wilson weight alone is a change of the gauge-fixing weight
after rescaling, and the transformation does not see the gauge-fixing weight. (2) It needs the background to be the constrained critical point —
Bałaban's construction supplies that for every background (p. 267) — and the gauge fixing to vanish on a complement of the orbit (the axial
structure of (0.14)–(0.15)). (3) The Haar density σ, the Jacobian Tr log(I − h(δ/δB)D̃) and G₃ do not contain the Wilson coefficient; they are
d-independent and do not enter (6.1).

## 7. THE CONSEQUENCES M3b LISTED, EACH WITH ITS EXACT GIVEN

### 7.1 LEMMA C (sup form) — PROVED GIVEN (BB1)–(BB3), (BB5)
ρ_{k+1}(g_k) ≤ C₁e^{−c₁ε₁²/g_k²} + C₂g_k²(1 + α₁^{−2}) + C₃ε₁²: M3 §5.4 (i)–(iii), with (iii) now (3.2) of Theorem BB4* (uniform in s on
the closed unit disc, at complex backgrounds), (i) Theorem BB4* at s = 0, and the M–∫ds interchange §3 (a). (BB4) is no longer an
input: every use M3R listed ((a) interchange, (b) bound (iii), (c) moment form, (d) the s = 0 end) is discharged by Lemma M.
(BB1)–(BB3) are Bałaban's inductive black box (CMP 95, 99, 102, 109 (1.17)–(1.18)) on which CMP 116 itself stands; (BB5) is the
definition of M (I.1.20)–(I.1.22).

### 7.2 LEMMA C IN MOMENT FORM — PROVED GIVEN the same (§4.3): ρ_{k+1} ≤ C₁e^{−c₁ε₁²/g_k²} + C₂g_k² + C₃ε₁g_k.
Consequences (M3R item 2d; M3b §7.4 SUFFICIENCY): ρ_k → 0 along the trajectory uniformly in k, so Theorem 2's bare coupling obeys
g₀ ~ (8b₀ ln ε^{−1})^{−1/2} exactly (not only up to ρ/ln L), and every per-step coupling-Lipschitz product of (S₁) is bounded uniformly in K
(§7.3 (c)).

### 7.3 LEMMA C′ — the β-function at a complex coupling deviation
Setting (M3b §6.2): step k + 1 at reference coupling x = x_k, the reference cutoff, Gaussian and gauge fixing, the D-term in the
interaction, d = D/x, |d| ≤ θ₀ = θ_* (§5.3); β^{(x)}_{k+1}(x + D) := M[log Z^{(k)} + log∫dμ_{C^{(k)}}χ_k e^{U_{1,d}}], U_{1,d} := V_k − dW.
(a) d ↦ β^{(x)}_{k+1}(x + D) IS ANALYTIC on |d| < θ₀. PROVED GIVEN Lemma W: Theorem BB4*-D (Lemma M (d) with p = d) and M is a bounded
   linear functional of the localized output.
(b) sup_{|d|≤θ₀}|β^{(x)}_{k+1}(x + D) − a(k + 1)| ≤ C₁e^{−c₁ε₁²/g_k²} + C(g_k² + ε₁g_k).   PROVED GIVEN Lemma W, (BB1)–(BB3), (BB5).
   PROOF. Split W = 𝒲 + W_{≥3} and put U₁ := V_k − dW_{≥3} ∈ 𝒱_m(E₀C₁ε₁(1 + θ₀); ε_m(1 + θ₀)) (cone property; 4.1, Lemma W (i)), and
   φ(s; d) := log∫dμ_{C^{(k)}}χ_k exp[sU₁ − d𝒲], expanded over the two polymer families (§5.3). With a(k + 1) = M[log Z^{(k)}] = β_{k+1}(0):
     β^{(x)}_{k+1}(x + D) − a(k + 1) = M[φ(0; d)] + M[∂_sφ(0; d)] + ∫₀¹(1 − s)M[∂_s²φ(s; d)]ds.
   (b1) THE PURE COUPLING DEFORMATION. Interpolate the cutoff: χ^{(λ)} := Π_b(1 − λχ^c_b), λ ∈ [0, 1]; expand χ^{(λ)} = Σ_P(−λ)^{|P|}χ^c_{k,P}
     over all bond sets (legitimate here: −d𝒲 is entire in B, so no small-field restriction is needed — (M-i) is not used). Lemma M's proof
     with these P-polymers (each carrying λ^{|P|}e^{−½γ₂(ε₁²/g_k²)|P|} by (2.22), |λ| ≤ 1) shows that ∂_λ log∫dμ_{C^{(k)}}χ^{(λ)}e^{−d𝒲} is a sum of
     localized clusters each containing a large-field bond: |M[φ(0; d)] − M[log∫dμ_{C^{(k)}}e^{−d𝒲}]| ≤ C₁e^{−c₁ε₁²/g_k²}. And
     M[log∫dμ_{C^{(k)}}e^{−d𝒲}] = M[−½n_T log(1 + d)] = 0 by LEMMA FP (6.1). So |M[φ(0; d)]| ≤ C₁e^{−c₁ε₁²/g_k²}.
   (b2) THE FIRST ORDER. ∂_sφ(0; d) = ⟨U₁⟩_{0,d}, the mean under χ_ke^{−d𝒲}dμ_{C^{(k)}}; all three factors are even in B (χ_k(B) = Πχ(|B′(b)| < ε₁),
     B′ linear in B to first order — and the odd part of U₁ is odd in B; μ_{C^{(k)}} centred, CMP 109 p. 267; 𝒲 quadratic), so the odd part
     of U₁ has mean zero, and the even part is O(g_k²) by explicit Gaussian moments under the complex covariance C_d := (C^{(k)−1} + d𝒲_op)^{−1},
     localized by its Neumann series Σ_n(−d)^nC^{(k)}(𝒲_opC^{(k)})^n (convergent for θ₀‖𝒲_opC^{(k)}‖ < 1, each term a product of localized operators);
     cutoff corrections as in (b1). (Without the parity argument, (4.1) at s → 0 gives |∂_sE(X; 0, d)| ≤ C₅ε_mg_k: the bound C g_k, also enough.)
   (b3) THE VARIANCE. Lemma M_m (4.2) for the two-family potential, uniformly in |d| ≤ θ₀: |∂_s²E(X; s, d)| ≤ 6C₅ε_m(E₀C₁/ε_*)ε₁g_k·(profile).
   Apply M (bounded, §3 (a)). ∎
(c) THE COUPLING-LIPSCHITZ CONSTANT. For |D| ≤ θ₀x/2: |β^{(x)}_{k+1}(x + D) − β^{(x)}_{k+1}(x)| ≤ (2g_k²/θ₀)[C₁e^{−c₁ε₁²/g_k²} + C(g_k² + ε₁g_k)]|D|.
   PROVED GIVEN (a)–(b): Cauchy's estimate on the d-disc of radius θ₀ for f(d) := β^{(x)}(x + D) − a(k + 1): |f(d) − f(0)| ≤ 2|d|sup|f|/θ₀, and
   |d| = |D|g_k². So ∂_xβ = O(g_k³(ε₁ + g_k)) + O(g_k²e^{−c₁ε₁²/g_k²}) — Σ_j g_j³ ≤ Cγ/(c − ρ) (D4b (E4) at κ = 3): SUMMABLE. (S₁)'s multiplier
   Π_j(1 − ∂_xβ_{j+1}(x_j)) is bounded uniformly in K with e^{Cγ}, as M3b §15.2 states for a = 1.
(d) OWN CUTOFF VERSUS REFERENCE CUTOFF, REAL x′. The cutoff (2.9) is χ_k = Πχ({|B′(b)| < ε₁}) ON THE PHYSICAL ANGLE B′ (READ, CMP 109 p. 266):
   coupling-independent. So β_{k+1}(x′) (own Gaussian, own gauge weight 1/g_{x′}²) and β^{(x)}_{k+1}(x′) (reference Gaussian, reference gauge
   weight, D = x′ − x in the interaction) are the same small-field integral with the same cutoff EXCEPT for the gauge-fixing weight. The
   transformation does not see the gauge-fixing weight ((0.15)–(0.16)); the cutoff χ_k is not R-invariant, so the difference is carried by
   configurations whose R-orbit, within the support of the gauge-fixing weight (|u − 1| ≲ g_k polylog), meets the cutoff boundary
   |B′| = ε₁ — a Gaussian tail. STATUS: PROVED GIVEN this shell estimate (|log Z(α) − log Z(α′)| localized and ≤ C₁e^{−c₁ε₁²/g_k²} per unit,
   for gauge-fixing weights α, α′ ∈ [½x, 2x]); its proof is the large-field complement of Lemma M, with the orbit average of (0.16) in place
   of the conditioning. With it: |β_{k+1}(x′) − β_{k+1}(x)| ≤ (2g_k²/θ₀)[C₁e^{−c₁ε₁²/g_k²} + C(g_k² + ε₁g_k)]|x′ − x| + 3C₁e^{−c₁ε₁²/g_k²}.

### 7.4 ONE-STEP (PI)_H — the step is analytic and Lipschitz in its history (PROVED, Lemma M)
The history enters CMP 116 only through Lemma 1's V′_k, and LINEARLY: Σ_Y V′_k(Y, U_{k+1}, B) = E_k(U_k(exp iB′V^{(k)})) − E_k(U_k(V^{(k)})) (1.33),
with Lemma 1's bound linear in the bound E₀ of the history (the factor E₀ of (1.24), from (I.3.54)). For two histories E, E′ obeying the
inductive assumptions on the same domain and E_ζ := E + ζ(E′ − E) (complex ζ — analytic on the same domain, by linearity), V′_k[E_ζ] =
V′_k[E] + ζV′_k[E′ − E] with V′_k[E′ − E] ∈ 𝒱(C₁ε₁‖E′ − E‖), ‖·‖ the constant in place of E₀ in (I.1.18). With ε₁ ≤ ε₁^max/2 the potential
V_k[E_ζ] lies in 𝒱(ε_*) for |ζ| ≤ Z₀ := ε_*/(2C₁ε₁‖E′ − E‖) ≥ R₀/4 when ‖E′ − E‖ ≤ 2E₀. Lemma M (d) and Schwarz:
   |E^{(k+1)}(X; E′) − E^{(k+1)}(X; E)| ≤ 2M_X/Z₀ = 4M_X C₁ε₁‖E′ − E‖/ε_*,
and, by (b2)–(b3)'s argument with the history difference as the marked insertion, |β_{k+1}(x; E′) − β_{k+1}(x; E)| ≤ C(g_k² + ε₁g_k)‖E′ − E‖/E₀.
(The history's contribution to β enters at order g² through its second-order term — M3 §5.4 (ii) — and the variance carries ε₁g_k.)

### 7.5 PROPOSITION E1-a (bare coupling unique up to the shell) — PROVED GIVEN 7.3 (c)–(d), 7.4 AND (PI)_H^multi
M3b §10.1's Gronwall argument needs, besides the per-step estimates now proved (7.3 (c)–(d), 7.4), the PROPAGATION of history differences across
scales:
 (PI)_H^multi (NAMED). For two trajectories with couplings x_i, x′_i (i < j) and histories E_j, E′_j:
   ‖E′_j − E_j‖_j ≤ C Σ_{i<j} L^{−β(j−i)} g_i² |x′_i − x_i|/θ₀.
 WHY IT IS NEEDED. Without the factor L^{−β(j−i)} the Gronwall sum is Σ_j g_j²Σ_{i<j}g_i² ~ (log K)²: divergent. With it, Σ_{j>i}L^{−β(j−i)}(g_j² + ε₁g_j)
 ≤ C(g_i² + ε₁g_i) and the sum is Σ_i g_i³|D_i|-type, convergent.
 PROOF SHAPE. A coupling change at step i changes that step's output by an analytic function of d_i (Lemma M (d)), whose marginal part is
 renormalized into the coupling at step i (the D-flow (6.2)); the remainder is a sum of localized IRRELEVANT terms of scale i. Seen at scale
 j > i, a fluctuation of unit size at scale j is smooth at scale i, varying over L^{j−i} scale-i units, and an irrelevant term's second
 derivative in that direction carries the factor (L^{i−j})^β — the content of CMP 119's (2.43)–(2.45) applied to the derivative in d_i, with
 Bałaban's representation of the history as a sum over scales of localized terms whose domains scale by (1.31).
 FALSIFIER: a component of the step-i output, surviving the step-i renormalization, whose second derivative in the scale-j fluctuation direction
 is not O(L^{−β(j−i)}) — a marginal or relevant remnant.

### 7.6 THE FROZEN PART OF LEMMA Σ₁ — PROVED GIVEN (PI)₀'s LARGE-FIELD HALF
The frozen model (coupling deviation constant, D_i ≡ D_i(z) at every step i ≤ j) is translation invariant. (PI)₀ for it: the small-field steps
are Lemma M at each step with p = d_i constant (Theorem BB4*-D); the output bounds hold (7.8 below, FP removes the pure-𝒲 clusters); the
renormalization is the constant D-flow; the symmetries (translations, the W(B₄) of the centred averaging — M3b §15.1, S-A) hold. Then CMP 119's
proof of (2.43) (pp. 279–283) applies verbatim at the constant complex coupling, PROVIDED the complete model's large-field part closes at a
constant complex Wilson coefficient — (PI-4) of §8, the large-field half of (PI)₀. The variation part of Σ₁ (M3b §6.5 (2)) is now PROVED:
the interpolated potential V_k − (d_z + t(d − d_z))W lies in 𝒱(ε_*) for t in a complex neighbourhood of [0, 1] of size ≥ θ₀/(4‖d − d_z‖_X)
(cone property, ‖d_t‖ ≤ θ₀), so Lemma M (d) gives the analyticity in t that M3b's Cauchy step uses.

## 8. (PI) — WHAT IT NEEDS, EXACTLY

(PI) (M3b §8): Bałaban's induction run on the reference trajectory with the complex coupling-deviation field D_k(·) carried in the interaction
(Wilson coefficient x_k + D_k(·); every cutoff, background, propagator and the gauge fixing at the reference), |D_k| ≤ θ₀x_k/2, D_k ∈ C² at the
step's scale, closes with D-independent constants, every localized term analytic in D_k. Its five pieces and their status:

(PI-1) THE SMALL-FIELD STEP — PROVED GIVEN Lemma W's input ([13]). A variable field d_k(·) = D_k(·)/x_k multiplies each plaquette's Wilson term;
   the decoupling of Lemma W with d(p) inside gives W_d = Σ_Y W_d(Y), W_d(Y) ∈ 𝒱(sup_{p∈Y}|d(p)|·(C_W + E₀C₁ε₁)) ⊂ 𝒱(θ₀(C_W + ε_*)/2). Lemma M
   applies: convergence, analyticity in d(·) (as a parameter in a polydisc of sup-norm radius θ₀), complex backgrounds, the bounds of (a)–(b).

(PI-2) THE OUTPUT BOUNDS FOR THE NEXT STEP — PROVED (constant d) / PROVED GIVEN Σ₁'s gradient bound (variable d). The new localized terms must obey
   (I.1.18) with ½E₀. The clusters containing a V_k- or W_{≥3}-polymer carry ε₂(ε) ∝ ε₁ (Lemma M (a)) — Bałaban's own condition. The PURE 𝒲-clusters
   (one-loop, size O(θ₀C_W), not small in ε₁) are, for constant d, removed exactly: their sum over X is the c-number −½n_T log(1 + d) for every
   background (LEMMA FP), so Σ_X[E⁰_X(d; U) − E⁰_X(d; 1)] ≡ 0 and the localized representation may drop them, the constant going to the vacuum part V_K
   of (S₁)(ii). For variable d the frozen/variation split leaves their background dependence O(θ₀‖∇d‖) per cluster (Σ₁'s variation estimate),
   ≤ ½E₀ since ω₁ = |τ|‖∇h̃‖_∞L^{j−K} ≪ 1. No condition on θ₀ beyond θ₀ ≤ θ_* arises.

(PI-3) THE RENORMALIZATION (LEMMA Σ₁) — variation part PROVED (7.6), parity PROVED (M3b S-A), frozen part PROVED GIVEN (PI-4).

(PI-4) THE LARGE-FIELD STEPS AT A COMPLEX WILSON COEFFICIENT (CMP 119 §3; LFR I–II) — NAMED, the remaining estimate of (PI)'s first kind.
   What it needs, exactly: (i) on real large-field configurations the Wilson weight enters through its modulus e^{−Re(x + D)A(U)}, with A(U) ≥ 0 and
   Re(x + D) ≥ (1 − θ₀)x, so every large-field suppression exp(−c x_k p(g_k)) of the reference holds with c(1 − θ₀) — a loss absorbed by the
   suppression's margin over the entropy (it beats every power of g); (ii) on LFR II's complexified configurations (the extension to G^c, "a small
   perturbation of a positive Wilson action"), Re((x + D)A) ≥ (1 − θ₀)x Re A − θ₀x|Im A|, which needs the RELATIVE bound
     |Im A(U)| ≤ C_A Re A(U) + η,  with θ₀C_A ≤ ½ and θ₀ηx_k ≤ ½ × (the large-field exponent),
   on the complexified large-field domain; (iii) no step uses monotonicity or convexity in the coupling, a minimisation of the D-weighted action,
   or a cutoff at the coupling x_k + D_k (all at the reference by the device).
   FALSIFIER: a large-field estimate of CMP 119 §3 or LFR I–II that bounds |Im A| ADDITIVELY by a constant independent of Re A on the complexified
   domain (multiplied by θ₀x_k ~ θ₀/g_k² it would not be absorbed), or that uses Re of the coefficient as a lower bound for a FLUCTUATION's
   Gaussian width (the reference Gaussian is D-free by the device, so such a use would be an error of the device's implementation).

(PI-5) THE MULTI-STEP HISTORY PROPAGATION (PI)_H^multi (§7.5) — NAMED, the remaining estimate of (PI)'s second kind. It is needed not only for
   Proposition E1-a: in (S₁) the history at step j carries the irrelevant D-dependent remnants of all earlier steps, and their effect on β_{j+1} is
   O((g_j² + ε₁g_j)‖E^D_j − E^0_j‖) (7.4); without the decay L^{−β(j−i)} it accumulates as Σ_j g_j²·θ₀ ~ θ₀ log K. With it, M3b's Proposition 6.4
   closes as written.

STATUS OF THEOREM S₁ AFTER THIS FILE: (S₁)(i)–(iv) PROVED GIVEN (PI-4), (PI-5), Lemma W's input [13] (Bałaban's own black box), and the shell estimate
of 7.3 (d) where E1-a is used. (BB4), the moment form, Lemma C′ (a)–(c) and Lemma FP — the pieces M3b listed as given — are proved.

## 9. PRECISIONS, DATED (2026-11-02, after §§0–8 were written; nothing above edited)

9.1 THE INPUTS UNDER EVERY "PROVED" ABOVE. Lemma M takes V_k ∈ 𝒱(E₀C₁ε₁) from CMP 116's Lemmas 1–2, i.e. from Bałaban's §1, which
stands on the random-walk expansions of [13] (CMP 99) and the minimal configuration's derivative bounds of [15] Sect. G (CMP 102;
(189)–(190) are stated there with "We do not perform these calculations here", p. 308, the estimate M3R named runner-up), and on CMP
109 Theorem 3's inductive assumptions. So: Lemma M, Theorem BB4*, Lemma M_m are PROVED GIVEN CMP 116's Lemmas 1–2 (Bałaban's black
box, the same one M3 called (BB1)–(BB3)); Lemma W uses exactly the same inputs (it localizes 𝒲 by the operations §1 applies to
(1/g_k²)V(H₁B′)); Lemma FP uses only CMP 109 §0 and pp. 266–268 (READ) and CMP 102 Theorem 1. Nothing beyond Bałaban's own
inputs enters (BB4) any more.

9.2 CORRECTION TO §8 (PI-2): THE PURE 𝒲-CLUSTERS. In the two-family Bałaban expansion the cutoff is decomposed only off Y₀ ((2.3)), so a
cluster made of 𝒲-polymers alone still carries χ_{k,Y₀} and is not the cutoff-free Gaussian. The exact removal is done as in 7.3 (b1):
write φ(1; d) = φ(0; d) + [φ(1; d) − φ(0; d)]; expand φ(0; d) = log∫dμ_{C^{(k)}}χ_ke^{−d𝒲} with the cutoff decomposed on ALL bonds
(χ_k = Σ_P(−1)^{|P|}χ^c_{k,P}; legitimate because −d𝒲 is entire in B): its P = ∅ part is log∫dμ_{C^{(k)}}e^{−d𝒲} = −½n_T log(1 + d)
EXACTLY (Lemma FP), a c-number for every background, sent to the vacuum part V_K of (S₁)(ii); its P ≠ ∅ clusters carry
e^{−½γ₂(ε₁²/g_k²)|P|}. The bracket is Σ_X[E(X; 1, d) − E(X; 0, d)] from the two-family expansion, every term with a V-polymer, ∝ ε₁
(Lemma M). The localized representation of the output is the sum of the two families of localized terms. (PI-2) then holds as stated.

9.3 CORRECTION OF A BELIEF IN M3b §6.2 (d) ("β_{k+1}(x′) (own cutoff) and β^{(x)}_{k+1}(x′) (reference cutoff) differ by the shell between
the two cutoffs"). The cutoff of record is χ_k = Π_{b∈T^{(k)}∖{b₀(c)}}χ({|B′(b)| < ε₁}) on the PHYSICAL ANGLE B′ (CMP 109 (2.9), READ),
and B′ = B − hD̃(B) changes B′ only on the bonds b₀(c) (hB vanishes off {b₀(c)}, p. 267) — so the cutoff is coupling-independent and
is a function of B(b), b ∉ {b₀(c)}, alone (EVEN in B, which is what 7.3 (b2) uses). The two constructions at x′ differ ONLY in the
gauge-fixing weight (1/g_{x′}² versus 1/g_x² on G(B′)), which the exact transformation does not see ((0.15)–(0.16)); the shell is the
cutoff's non-invariance under R, a tail in the gauge-fixing directions of size e^{−c x ε₁²}, as 7.3 (d) states. (Bałaban's analytic
variant, cutoff (g_k/γ_k)ε₁, p. 266, is coupling-dependent; there M3b's sentence is the right one.)

9.4 A CHECK OF LEMMA FP AGAINST THE ONE-LOOP β (consistency, PROVED). Lemma FP says the reference construction at x + D reproduces, at
order g⁰, the reference β: β^{(x)}(x + D) − a(k + 1) = O(g²). The physical statement it must agree with: the k-step lattice β-function
at coupling x′ has the expansion a(k + 1) + b_{k+1}/x′ + O(x′^{−2}) with a coupling-INDEPENDENT one-loop coefficient a(k + 1) (M3 §5.3,
Lemma B). At x′ = x + D: a(k + 1) + b_{k+1}g_k²(1 + d)^{−1} + O(g⁴), whose d-dependence is −b_{k+1}g_k²d + O(g²d²) — O(g²), as 7.3 (b)
states, and ∂_xβ = −b g⁴ (M3b §6.2's sharp order). A background dependence of the one-loop d-term would contradict the coupling
independence of a(k + 1); FP is the exact form of that independence inside Bałaban's gauge-fixed, constrained integral.

## 10. CROSS-FIELD UNIFICATIONS FOUND

(U1) BAŁABAN'S §2 IS A BRYDGES–KENNEDY / BATTLE–FEDERBUSH THEOREM ABOUT A CONE. The Cauchy-in-τ device of (2.14) is the device of the
complex-interpolation cluster expansions (Brydges, Battle–Federbush; the "[26]" of p. 21): smallness of an activity = 1/(Cauchy radius),
radius = 1/(bound of the potential). Read that way, the theorem is about the cone 𝒱(ε) of potentials, not about one potential, and every
deformation of the theory that stays in the cone — a complex multiple (BB4*), a complex history ((PI)_H), a complex coupling deviation
(the D-term), a position-dependent coupling ((PI-1)) — is ONE application. This is the lattice-RG analogue of Kotecký–Preiss's statement
that the polymer expansion is analytic in any parameter on which the activities depend analytically within the KP domain.
(U2) LEMMA FP IS THE BRST/FADDEEV–POPOV GAUGE-PARAMETER INDEPENDENCE, MADE A DETERMINANT IDENTITY WITH NO GHOSTS. Changing the Wilson weight
alone equals changing the gauge-fixing weight (rescale), and (0.15)–(0.16) make the transformation independent of the latter; at one loop
this is the block-diagonality of c𝒲 + ½‖L·‖² on G ⊕ T, which needs only criticality and invariance (the Hessian of an invariant function
at a critical point kills the orbit — the Morse–Bott lemma used in the Duistermaat–Heckman / equivariant-localization arguments) and an
axial slice. The same block structure is why the off-shell effective action is gauge-dependent and the on-shell one is not (the
Kallosh–DeWitt theorem): Bałaban's construction is always ON-SHELL in the constrained sense, which is why his β-function is gauge
independent at the reference.
(U3) THE THREE ROLES OF ε₁, AND WHY ONLY ONE IS A CHOICE. RADIUS (where the fluctuation lives), FACTOR (how big the interaction is there),
and — in the moment form — g_k‖B‖ (how big it TYPICALLY is). The sup form ties the factor to the radius, which is why ρ ≤ C(ε₁² + g²)
does not vanish; the moment form unties them, ρ ≤ C(ε₁g + g²). This is the same separation as between a worst case and an average case
that the crossover's measure-weighted bound needs (MATH_BRIEF's converged missing step): here, inside Bałaban's own proof, the
average-case form is obtained by moving the Cauchy radius inside the integral — a pointwise-in-the-field contour, the device of the
quadratic-form moments (Glimm–Jaffe's "local" estimates).

## 11. THE LEDGER (this agent's rows)

| Item | Status | Where |
|---|---|---|
| CMP 116 pp. 1–22, every page, on image | READ | §0, §1 |
| where the interaction enters §2: (2.1), (2.14)–(2.15), (2.18)–(2.20) — only its modulus, at complex couplings τ(Y) | READ | §1.2 |
| every ε₁ classified RADIUS/FACTOR; one MIXED site (p. 19 "for simplicity"), cosmetic | READ | §1.3 |
| M3b's falsifier for BB4* | NOT MET in substance | §1.3 |
| Lemma M: §2 is a theorem about the cone 𝒱(ε); analytic in parameters | PROVED GIVEN CMP 116 Lemmas 1–2 | §2, §9.1 |
| Theorem BB4*: complex s on |s| < R₀ = ε₁^max/ε₁ (≥ 1 + δ, any size by Bałaban's order); (3.1) ∝ |s|ε₁; (3.2) ∝ ε₁²; s = 0 end | PROVED GIVEN the same | §3 |
| M3R's (a) M–∫ds interchange, (b) bound (iii), (d) s = 0 end | PROVED | §3 |
| moment form: Lemma M_m, ρ ≤ C(ε₁g_k + g_k²) + tails (a = 1) | PROVED GIVEN the B-dependent bounds READ at (1.20), (1.24), (1.40) | §4 |
| the D-term: 𝒲 is O(1), not O(ε₁); Lemma W (𝒲 ∈ 𝒱(C_W)) | PROVED GIVEN the inputs of CMP 116 §1 | §5 |
| Theorem BB4*-D: joint analyticity on |s| ≤ R₀/2, |d| ≤ θ_*; θ₀ := θ_* fixed | PROVED GIVEN Lemma W | §5.3 |
| Lemma FP: det ratio = (1 + d)^{n_T}, background-independent; M of the one-loop d-term = 0 | PROVED (CMP 109 §0, pp. 266–268 READ) | §6 |
| Lemma C (sup) | PROVED GIVEN (BB1)–(BB3), (BB5) | §7.1 |
| Lemma C (moment, a = 1) | PROVED GIVEN the same | §7.2 |
| Lemma C′ (a) analytic, (b) sup|β(x+D) − a| = O(g(ε₁ + g)), (c) ∂_xβ = O(g³), summable | PROVED GIVEN Lemma W, FP, (BB1)–(BB3), (BB5) | §7.3 |
| Lemma C′ (d) own vs reference construction | PROVED GIVEN the gauge-weight shell estimate (named) | §7.3, §9.3 |
| one-step (PI)_H | PROVED | §7.4 |
| Prop. E1-a | PROVED GIVEN (PI)_H^multi (named, falsifier) | §7.5 |
| frozen part of Σ₁; variation part of Σ₁ | PROVED GIVEN (PI-4); PROVED | §7.6 |
| (PI): (PI-1), (PI-2), (PI-3) | PROVED / PROVED GIVEN (PI-4) | §8, §9.2 |
| (PI-4) large field at complex Wilson coefficient; (PI-5) multi-step propagation | NAMED, each with its exact need and falsifier | §8 |
| M3b §6.2 (d)'s "two cutoffs" | CORRECTED: one cutoff, two gauge-fixing weights | §9.3 |

## 12. THE PRECISE NEXT OBJECT

(PI-4) at its first instance: CMP 119 §3's complete step and LFR I–II read line by line for every use of the Wilson coefficient on
large-field and complexified configurations, deciding for each whether the bound survives x ↦ x + D with |D| ≤ θ₀x, the test being the
relative bound |Im A(U)| ≤ C_A Re A(U) + η on LFR II's complexified large-field domain (falsifier: an additive bound on |Im A| independent of
Re A, multiplied there by θ₀x_k ~ θ₀/g_k²). Then (PI-5): CMP 119 (2.43)–(2.45) applied to the derivative in an earlier step's coupling
(the falsifier: a marginal remnant of an earlier step surviving its renormalization).
