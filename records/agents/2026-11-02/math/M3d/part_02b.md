
2.2 THEOREM PI-4 (PROVED GIVEN the inputs on which Bałaban's own induction stands — CMP 99's random-walk expansions [13]; CMP 102
Sect. G including (189)–(190) [15]; CMP 116 Lemmas 1–2; CMP 109 Theorem 3; the estimates of CMP 119 §3 and LFR I–II as stated on
the pages, including the steps Bałaban sketches ("They should be obvious", LFR II p. 368) — and on M3c's Lemmas M and W, whose
inputs are the same).
SETTING. The reference trajectory (x_j)_{j≤K} of Theorem 2; complex coupling-deviation fields D_j(·) with |D_j| ≤ θ₀x_j/2,
θ₀ ≤ min(θ_*, 1/4) (θ_* of M3c §5.3), satisfying the R-region condition of Lemma 3 (guaranteed by (2.2)); THE DEVICE: every cutoff,
characteristic function, determining set, background (minimizers of the UNWEIGHTED action), Gaussian and gauge-fixing weight at the
reference; D carried in the Wilson coefficient x_j(·) + D_j(·) of the effective action and, inside each fluctuation integral, as the
interaction difference D·[A(U(e^{iB}V)) − A(U(V))] beside Bałaban's own coupling-function difference (CMP 119 (3.15); LFR I (1.60));
the R-operation replaced by R_D (§2.1).
CONCLUSION. Bałaban's inductive description (CMP 119 (2.18)–(2.42)), Theorem 2 ((2.43)–(2.44)) and the T-bounds ((2.50); LFR II
(1.79)–(1.89)) hold for the D-deformed densities with: (a) moduli in place of values; (b) γ₀ ↦ (1 − θ₀/2)γ₀ in every large-field
factor; (c) the boundary-term constants (C₀ of LFR I (1.70), the α and O(1) of LFR II (1.68)–(1.69)) enlarged by absolute factors;
(d) every localized term analytic in the D's on the polydisc; (e) R_D preserving integrals; (f) the new effective action's Wilson
coefficient x_{k}(·) + D_{k}(·), D unchanged by R_D. In particular (PI) of M3b §8 holds: (PI-1) [M3c], (PI-2) [M3c §8, 9.2],
(PI-3) [frozen part now unconditional on the large field, §4.2], (PI-4) [this theorem].

PROOF: induction on k; the step k → k + 1 is T (CMP 119 §3) followed by R (LFR I–II). Every site where the Wilson coefficient or
the density's positivity enters, with its treatment (READ pages in §1):
 T1 (3.2), (3.3), (3.16): characteristic functions at ε_{k+1}, δ_k — D-free.
 T2 (3.15), (3.25)–(3.47): the fluctuation integral on Λ_{k+1}; the D-difference is −d(𝒲 + W_{≥3}) (M3c Lemma W), a regular
    term; Lemma M with ε = |s|E₀C₁ε₁ + |d|(C_W + E₀C₁ε₁) ≤ ε_* for |d| ≤ θ_* ((PI-1)). The "probabilistic measures" (3.27), (3.29)
    enter only through the interpolation identities (3.26), (3.28), (3.30), (3.32) — algebraic wherever the normalizations are
    nonzero, which the convergent expansion supplies — and through the cluster expansions of Sect. 3.7 [I] = CMP 116 §2, which
    Lemma M establishes for complex potentials in the cone.
 T3 p. 277: the D-difference's part localized in Z_k ("localized by the decomposition of unity {ζ_□} introduced into the sum over
    plaquettes in the Wilson action … the large values of the function g_k^{−2}(·) − g_k^{−2} are suppressed by the exponential
    decay of H_k") goes to B^{(k+1)} exactly as Bałaban's own coefficient differences, which reach O(k) on lagged regions;
    |D| ≤ θ₀x_k/2 ≤ x_k lies in that range.
 T4 (3.25): the Wilson term of A_k at the real minimizer U_{k+1}: Lemma 1. The E-, R-, B-terms: analytic in D, modulus bounds by
    the induction.
 T5 (3.23)–(3.24): T^{(k+1)} integrates D-free Gaussians and characteristic functions against exp A_k: modulus by T4.
 T6 p. 279: the vacuum subtraction at U = 1 and the coupling counterterm, with the LOCAL β-function (M3b Lemma Σ₁): §4.2.
 R1 LFR I (1.22)–(1.70): characteristic functions at the reference (D-free); the boundary-layer integrals (1.60) carry the
    D-difference beside Bałaban's coefficient difference — Lemma M with the cone radius θ_* — and go to C_k^{(n+1)} with (1.70),
    C₀ ↦ R₀C₀ (activities C₃′ε₂*(ε_*) in place of C₃′ε₂(E₀C₁ε₁); R₀ = ε₁^max/ε₁ an absolute constant, M3c §3); the counterterm
    (1.62) gains the D-flow's increment, coefficient O(g_k^{2+a}θ₀x_k).
 R2 LFR I (1.75), p. 193: 1 − χ_{k,Λ} gives its factor "estimating in the usual way the Wilson action" on real configurations:
    Lemma 1, factor exp(−(1 − θ₀/2)(1/4g_j²)(O(1)B₃M²)^{−2}ε_j²) ≤ exp(−(1 − θ₀/2)A₁²p₀²(g_j)) (cf. LFR II p. 381).
 R3 LFR II (1.1)–(1.48), the R-operation: R_D (§2.1); Lemma 2 for the denominator ((1.10)–(1.11) ↦ (2.1)); (K1) exact; (K2) the
    new Wilson term with D; (K3) unchanged; (K4) (1.46)–(1.48) at coefficient (x″ + D)ζ₁: the G-valued term by Lemma 1, the O(1)
    terms carry the coefficient linearly — (1.47) is a bound with the explicit factor 1/g″², so O(1)_D ≤ (1 + θ₀/2)O(1) (§2.0); (K5)
    Lemma 1's pointwise form plus the complex-background remainder times |1 + d|; the weighted linear terms by Lemma 3; the
    remaining O(1) of (1.37) and (1.31) (small after division by g_k², by e^{−½δMR_k} and L^{−N}) carry |1 + d| ≤ 1 + θ₀.
 R4 LFR II pp. 369–377 (localization, (1.49)–(1.70)): the re-expansions around U_k act on the E-, R-, B-terms (analytic in D,
    modulus bounds); (1.68)–(1.69) hold with Lemma 2's I′_d and Θ_d among the normalization constants and Lemma 3's terms among
    the small terms.
 R5 LFR II (1.71)–(1.89), the T′-bounds: "All the expressions in the definition (1.71), for the configuration U, are real, and the
    exponential density in the integral is positive" FAILS at complex D; but the integrand's MODULUS is the integrand of
    T′_{k,Re} — Bałaban's operation with the real coefficients Re(x″ + D) on the Wilson term and 1 + Re d on the quadratic form,
    each ≥ (1 − θ₀/2) times his (Lemma 1). Hence (1.73)_D: |T′_{k,D}(X,(U,J))F| ≤ (T′_{k,Re}(X,(U,0))1)·sup e^{|σ_D|}|F|, σ_D the
    small first-order term (Bałaban's σ times 1 + θ₀). The proof of (1.79)–(1.89) uses only LOWER bounds on these two coefficients
    (the large-field factors, pp. 380–383 including (1.77)–(1.78)) and UPPER bounds on the rest ("All the integrals with respect to
    the group valued variables … are estimated by 1"; the A_j-Gaussians, D-free, "using the positivity properties of the quadratic
    forms"); so they hold for T′_{k,Re} with γ₀ ↦ (1 − θ₀/2)γ₀, and the induction (1.80)–(1.88) closes under
    ¼(1 − θ₀/2)γ₀(14)^{−d}A₁²p₀²(g₁) ≥ O(1)2(64)^dM^dL^{d+1}R₁^{d+2} — "p₀ large, g₁ sufficiently small" (p. 385). (1.89)_D:
    T′_{k,Re}(X)1 ≤ exp(−2(1 + β₀)^{−1}(1 − θ₀/2)p₀(g_k)). THE LOWER BOUND (1.74)–(1.75) IS NOT AVAILABLE AT COMPLEX D AND IS NOT
    NEEDED: the main line uses (1.73) and (1.89) only — "(1.92) Using (1.68), (1.73), (1.89), we obtain" — the activities (1.91) and
    the new large-field operation (1.102) T_k(Y) are un-normalized; (1.74)–(1.75) serve only "another possible representation"
    (1.103)–(1.104), which "can be used alternatively".
 R6 LFR II (1.90)–(1.102), exponentiation: the activities obey (1.92)_D–(1.97)_D with (1 − θ₀/2)p₀ for p₀ (the condition
    −2(1 + β₀)^{−1}(1 − θ₀/2)p₀(g_k) + 1 + 2κ(100R_k)^d ≤ −(3/2)(1 − θ₀/2)p₀(g_k) of p. 389 holds for g_k small); R′^{(k)}(X) analytic.
 R7 Analyticity: each term is an integral of an integrand entire in the D's times D-independent characteristic functions, or a
    uniformly convergent series of such, dominated on the polydisc by the modulus bounds; the R_D denominators are analytic and
    nonvanishing (Lemma 2). Weierstrass / Morera (as in M3c Lemma M (d)). ∎
The density's LOWER bound in Corollary 3 (CMP 119 (2.50), LFR II (0.1)) is a consequence stated after the induction, not an input;
at complex D it is replaced by the upper bound on |ρ_k| — M3b (S₁)(iv).

2.3 WHAT (PI-4) COSTS, EXACTLY. One construction change (R_D); θ₀ ≤ min(θ_*, 1/4); the τ-disc (2.2); the thresholds g₂(M) of Lemma 2
((A), (B)) and the (1 − θ₀/2)-weakened forms of Bałaban's own conditions — all of the type "p₀ large, γ small depending on M",
none changes the order in which Bałaban fixes his constants (M, κ, κ₁, then ε₁, then γ). M6's threshold β_B (labelled SHARED:
log₁₀ β_B ≥ 978 on the literal chain, M6 §5) is governed by Bałaban's chain, not by these additions: (B) of Lemma 2 asks
p₀(γ)² ≳ M⁹log M, weaker than Bałaban's LFR II (1.9) row (M6 S-5: log₁₀ β ≈ 162 at p₀ = 13, M = 729).
