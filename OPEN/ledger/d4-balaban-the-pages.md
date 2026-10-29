> Posted by Edwin Boston III at 05:33 EDT on 29 October 2026 as written by the fourth seat from the four papers the operator downloaded (CMP 109; CMP 116; Large Field Renormalization I and II) and the zbMATH author listing. Read and checked here. §6 is the theorem of record with its author's own sentence on the hypothesis; §7 is the index that shows the hypothesis's proof never appeared.

# D4 — β_UV ON BAŁABAN'S OWN PAGES (the seat iii-3a, 2026-10-29 05:3x EDT)
Read: CMP 109 (1987) 249–301, complete (the operator's download, 54 pp., text layer plus rendered pages 252–260);
Large Field Renormalization I, CMP 122 (1989) 175–202, complete. NOT in hand: Large Field Renormalization II, CMP 122
(1989) 355–392 (doi 10.1007/BF01238433), where the four-dimensional theorem of record is stated ("as formulated in
Theorem 1", part II's abstract). Every quotation below is verbatim from the page named.

## 1. The quantifier (Theorem 1's)

CMP 109 p. 259: "The ultraviolet stability concept has two aspects. The first concerns the effective actions generated
by the renormalization group transformations, their description and the bounds they satisfy. The second concerns the
behavior of the sequence of the effective coupling constants g_k generated from the bare coupling constant g₀ by the
renormalization group equations (0.18), (0.20). In this paper we prove a theorem concerning the first aspect. To
formulate this theorem we introduce small field domains. For the k-th action such a domain is determined by the
condition |∂U_k(V) − 1| < ε₀η² on T_η, for ε₀ sufficiently small. … Now the main result can be formulated in a general
way as follows:
  **Theorem 1.** If the sequence of the effective coupling constants is contained in an interval ]0, γ] with a
  sufficiently small positive γ, then the effective actions for small fields are given by the formulas (0.22)–(0.24),
  with terms satisfying (0.29)."
p. 267 (the precise form): "**Theorem 3.** There exist positive constants κ₀, M(κ), γ, ε₀, ε₁, α₀, α₁ such, that if
κ ≥ κ₀, M ≥ M(κ), 0 < g_k ≤ γ for k = 0, 1, …, K, then the sequence of actions A_k, defined inductively by the small
field renormalization transformations (0.17)–(0.20), satisfy all the inductive assumptions described between
(1.1)–(1.22). The constants ε₀, ε₁, α₀, α₁ depend on M and satisfy numerous restrictions, which will become clear in
the proof. The constant γ depends on all other constants."
So: EXISTENTIAL in γ ("depends on all other constants", none computed), UNIVERSAL over the whole sequence g_0, …, g_K.
p. 256: "We continue the calculation of the effective actions until we reach the unit lattice, or rather until we
reach a scale which we define as the unit scale. Let us denote the corresponding index by K, hence ε = L^{−K}, and the
sequence of actions and coupling constants is defined for k = 0, 1, …, K." The recursion, p. 256:
  1/g_k² = 1/g²_{k+1} + β_{k+1}(g_k)   (0.20),
"a finite difference approximation, corresponding to two consecutive lattice spacings (on a logarithmic scale) of the
differential equation (d/ds)(1/g²) = −β(g)" (p. 257, on (0.18)); with β > 0 the coupling GROWS from the bare g₀ at
spacing ε to g_K at the unit scale, so the sequence's maximum is g_K and "0 < g_k ≤ γ for all k" binds at the unit
lattice. Theorem 2, p. 259–260 (d = 4, SU(2)): "let γ be a sufficiently small positive constant, then for a
sufficiently small positive g there exists a bare coupling constant g₀ = g₀(ε, g) such that the sequence of the
effective coupling constants g_k is contained in the interval ]0, γ], and g_K = g. Moreover, there exist constants
β, β′, 0 < β ≤ β′, such that g_k satisfy the inequality
  1/g² + β log(L^kε)⁻¹ ≤ 1/g_k² ≤ 1/g² + β′ log(L^kε)⁻¹   (0.31)."
At k = K (L^Kε = 1) this reads 1/g_K² = 1/g²; at k = 0, 1/g₀² = 1/g² + (β…β′) log ε⁻¹ — Large Field Renormalization I
p. 175: "For d = 4 the bare coupling constant behaves asymptotically as (a + b log ε⁻¹)^{−1/2}, for ε → 0, with some
positive constants a, b" — a is 1/g² at the unit scale, b the one-loop coefficient.
VERDICT ON THE INFERENCE MARKED IN §83 bis: confirmed by the page. The condition is on the whole sequence, pinned at
its coarse end by the renormalised (unit-scale) coupling g = g_K ≤ γ, the bare coupling then chosen by Theorem 2.

## 2. The map onto the road's single-lattice β

CMP 109 p. 252: "An action for gauge field models was proposed by Wilson [73], and is given by
  A^ε(U) = Σ_{p∈T_ε} ε^{d−4}[1 − Re tr U(∂p)]   (0.2),
where tr is the normalized trace, i.e. tr 1 = 1." The density is exp A_k with A_k = −(1/g_k²)A(U_k) + … (0.22),
(1.3), so at the unit scale (d = 4, the factor ε^{d−4} = 1) each plaquette weighs exp(−(1/g²)[1 − ½ Re Tr U_p]) ∝
exp((1/g²)·½ Tr U_p) for SU(2). THE GROUND's Theorem 8.7 weighs each plaquette by exp(½β Tr U_p). Hence
  β = 1/g²   (exactly, no factor),   and   β_UV = 1/γ².
The road's certified edge β = 0.2452 is g² = 4.08 in Bałaban's normalisation — far from "sufficiently small".

## 3. The small-field restrictions (CMP 109)

p. 259: the k-th small field domain is |∂U_k(V) − 1| < ε₀η² on T_η (η = L^{−k}), "for ε₀ sufficiently small"; p. 260,
(1.2): U_k(ε₀) is the set of configurations with |U(∂p) − 1| = |(∂U)(p) − 1| < ε₀η², |J| < ε₀, "with ε₀ sufficiently
small"; Theorem 3 lists ε₀, ε₁, α₀, α₁ as depending on M and "numerous restrictions, which will become clear in the
proof". Large Field Renormalization I p. 175: the large-field threshold in the first step is |U(∂p) − 1| ≥ g₀ p₀(g₀),
p₀(g₀) = A₀(log g₀⁻²)^{p₀}, the Wilson term then giving exp(−(1/g₀²)[1 − Re tr U(∂p)]) ≤ exp(−p₀(g₀)) =
g₀^{A₀(log g₀⁻²)^{p₀−1}} (0.1); "for d = 4 … the bound does not give any positive power of ε. It is still small for ε
small, and it controls a large number of steps, but this number is a small fraction of the total number of steps" —
the reason for the ℝ operation. No constant among ε₀, A₀, p₀, M, κ₀ is given a value on any page read.

## 4. Two facts for the record

(i) THEOREM 2 IS DEFERRED. p. 260: "A proof of this theorem, based on perturbative calculations, will be given in a
separate paper, where more precise asymptotic behavior will be proved. The restriction to the group SU(2) is
superficial and is done only to simplify calculations." Also p. 251: "The analysis of the Callan–Symanzik equations,
based on perturbative calculations, will be discussed in another paper." CMP 109 proves the effective-action theorem
GIVEN a small sequence; the four-dimensional statement that the sequence can be kept small (asymptotic freedom in the
construction) is referred to a paper not identified in the bibliography of either download. Which later paper, if
any, proves Theorem 2 is the next thing to establish — the CMP 116, 119 and 122 abstracts do not say so, and part II
is the only candidate in hand by title.
(ii) LARGE FIELD RENORMALIZATION I STATES NO THEOREM. Its only "Theorem 1 [16]" (p. 191) borrows a constant B₃ from
[16] = Bałaban, "Ultraviolet stability of three-dimensional lattice pure gauge field theories", CMP 102 (1985) (CMP
109's reference 16). The four-dimensional theorem "as formulated in Theorem 1" is in part II (CMP 122, 355–392),
pending.

## 5. For §8.3

β_UV = 1/γ², γ the existential constant of CMP 109's Theorem 3 (equivalently Theorem 1), the bound on EVERY effective
coupling of the sequence from the cutoff to the unit lattice, binding at the unit lattice where it is the road's β;
uncomputed on every page, "depends on all other constants". The distance of record stays [0.2452, 1/γ²], its top a
symbol. The quantifier question is closed; the identity of the paper that proves Theorem 2, and part II's Theorem 1,
remain to be read.

## 6. Large Field Renormalization II (CMP 122 (1989) 355–392; the operator's fourth download; 06:3x) — THE THEOREM OF RECORD

p. 355, verbatim: "Theorem 1. If the sequence of the effective coupling constants is contained in an interval ]0, γ] with a
sufficiently small positive γ, then the effective densities ρ_k have the form, and satisfy all the conditions and bounds,
described in Sect. 2 [III]."
"This is the main result of the whole sequence of papers of the present author on non-Abelian gauge field theories.
Theorem 2 of [I] allows us to remove the assumption on the effective coupling constants in the above theorem, because
this assumption follows from the basic inequality (0.31) [II], which is the result of Theorem 2. The proof of Theorem 2,
which is based on second order perturbative calculations, is very awkward and long in the context of the renormalization
group approach to lattice gauge field theories, and has not been published yet, so we have Theorem 1 with the
assumption. As an immediate consequence of this theorem, we get the ultraviolet stability bounds of the same type as for
superrenormalizable models in [16]:   χ_k exp[−(1/g_k²)A(U_k) − E₋|T_η|] ≤ ρ_k ≤ exp E₊|T_η|   (0.1),
with the constants E₋, E₊ independent of k, T_η, U_k." ((0.31) is CMP 109's (0.31); "[II]" as printed.)
References: [I] CMP 109; [II] CMP 116; [III] CMP 119; [IV] CMP 122 I. No paper proving Theorem 2 is named.

VERDICT: the four-dimensional ultraviolet stability theorem of record is CONDITIONAL on the sequence hypothesis
0 < g_k ≤ γ for all k (the quantifier of §1), and its author states in 1989 that the proof of the statement removing the
hypothesis (CMP 109's Theorem 2, the two-sided bound (0.31), asymptotic freedom inside the construction) "has not been
published yet". β_UV = 1/γ² is unchanged; the standing of the UV end is "stability under the sequence hypothesis" until a
later publication of Theorem 2's proof is found (searched next).

## 7. Was Theorem 2 ever published? (zbMATH author listing, 05:30 by the clock)

zbMATH API, au:Balaban, T*, py:1989-2026: 64 entries (A. T. Balaban the chemist among them). Tadeusz Balaban's: Euclidean fermion block RG (CMP 122 and LMP 17, 1989); Large field renormalization I, II (CMP 122, 1989); A low temperature expansion for classical N-vector models I-III (CMP 167, 182, 196; 1995-98); The variational problems for classical N-vector models (CMP 175, 1996); Localization expansions I (CMP 182, 1996); A simple method for correlation functions via the effective actions (Ann. Phys. 260, 1997); Renormalization and localization expansions II (CMP 198, 1998); The large field renormalization operation for classical N-vector models (CMP 198, 1998); Low temperature properties for correlation functions in classical N-vector spin models (CMP 199, 1999); the bosonic many-body series with Feldman, Knoerrer, Trubowitz (2008-2022). NO four-dimensional gauge theory paper after 1989: CMP 109's Theorem 2 was never published. The four-dimensional ultraviolet stability of record holds under the sequence hypothesis; beta_UV = 1/gamma^2 sits inside that conditional.

## §8 — Theorem 2 read by the second reader, and the proof this work owes (06:10 by the clock; iii-43 from the operator's download of CMP 109)

The operator's order of 06:0x: the unpublished Theorem 2 is not a clause to report but a theorem to prove and own (plan D6a, the chain's row Σ1b). This section is the second reading of its statement and of the objects its proof needs, beside the fourth seat's; every line carries its page in *Comm. Math. Phys.* 109 (1987).

**The recursion, verbatim.** p. 255, (0.17): the first step, A₁(V) = (T₀A)(V) = log N₀⁻¹ ∫ dU ∏_(c∈T^(1)) δ(Ū(c)V⁻¹(c)) χ₀ exp[−(1/g₀²) Σ_(y∈T^(1)) Σ_(x∈B(y), x≠y) [1 − Re tr U(y,x)] − (1/g₀²) A(U)]. Then: "The action A₁ determines a function β₁(g₀) of the bare coupling constant g₀, defined on an interval [0, γ], γ > 0. This is a function in a sequence of β-functions. In the next section we will relate them to effective actions. Now we assume the existence of the first function, and we define the new coupling constant g₁: 1/g₀² = 1/g₁² + β₁(g₀), or 1/g₁² = 1/g₀² − β₁(g₀). (0.18) The equation (0.18) written in the form (1/g₁²) − (1/g₀²) = (d(1/g²))₀ = −β₁(g₀) is a finite difference approximation, corresponding to two consecutive lattice spacings (on a logarithmic scale) of the differential equation (d/ds)(1/g²) = −β(g), or (dg/ds) = ½β(g)g³. This is the usual differential renormalization group equation, an example of a Callan–Symanzik equation." p. 255–256, (0.19)–(0.20): A_(k+1)(g_(k+1), V) = (T_k A_k)(g_(k+1), V) = log N_k⁻¹ ∫ dU ∏_(c∈T^(k+1)) δ(Ū(c)V⁻¹(c)) χ_k exp[−(1/g_k²) Σ_(y∈T^(k+1)) Σ_(x∈B(y), x≠y) [1 − Re tr U(y,x)] + A_k(g_k, U)], "and the coupling constant g_(k+1) is determined from the equation 1/g_k² = 1/g_(k+1)² + β_(k+1)(g_k). (0.20) The characteristic function χ_k restricts the integral to small fluctuation fields. We continue the calculation of the effective actions until we reach the unit lattice, or rather until we reach a scale which we define as the unit scale. Let us denote the corresponding index by K, hence ε = L^(−K), and the sequence of actions and coupling constants is defined for k = 0, 1, …, K."

**Where the β-functions live.** p. 256, (0.22)–(0.23): A_k(g_k, V) = −(1/g_k²) A^η(U_k(V)) + E_k(U_k(V)), "The function E_k depends also on the effective coupling constants g₀, …, g_(k−1). It is a sum of contributions coming from the k successive integrations … In the first step the integral (0.17) yields the action A₁ = −(1/g₀²)A^(L⁻¹) + E^(1), and then applying Eq. (0.18) we obtain the representation A₁ = −(1/g₁²)A^(L⁻¹) + [−β₁(g₀)A^(L⁻¹) + E^(1)]. The expression in the square bracket is equal to E₁ … Thus we obtain after k steps E_k(U_k) = Σ_(j=1)^k [−β_j(g_(j−1))A^η(U_k) + E^(j)(U_k)]. (0.23)" p. 258, (0.28)–(0.29): the j-th step's output E^(j) is split, by expanding E^(j)(X, exp iηH) to fifth order in H and summing the lower orders through Ward–Takahashi identities, into its marginal part and the rest: "−β_j(g_(j−1))A^η(U_k) + E^(j)(U_k) = Σ_(X∈D_j) V^(j)(X, U_k), (0.28) where the functions V^(j) satisfy the inequalities |V^(j)(X, U_k)| ≤ O(1)(L^jη)^(4+α) exp(−κd_j(X)), α > 0, (0.29)". So β_j IS DEFINED by the extraction: the coefficient of the action A^η in the j-th integration's output, the unique marginal term; the coupling g_j absorbs it by (0.20); Theorem 1 (p. 259) asserts that, under g_k ≤ γ at every k, what remains obeys (0.29) — "we do not assume any special asymptotic behavior of the coupling constants, like asymptotic freedom" — and p. 260, (1.3)–(1.4) writes the k-th action with the Gaussian normalisations explicit: A_k(U_k) = −(1/g_k²)A(U_k) + Σ_(j=0)^(k−1){−β_(j+1)(g_j)A(U_k) + [log Z^(j)(U_k) − log Z^(j)(1)] + [E^(j+1)(g_j, U_k) − E^(j+1)(g_j, 1)]}, Z^(j)(U_k) = ∫ dB δ(Q̃B) exp[−½⟨B, Δ^(j)(U_k)B⟩].

**The index direction, settled.** k = 0 is the bare lattice of spacing ε and k = K = log_L(1/ε) the unit lattice (p. 256; p. 259 line 1: "the effective action corresponding to the unit lattice, where k = K = log_L 1/ε"); (0.20) subtracts β_(k+1) from 1/g_k² at each step, and (0.31)'s log((L^kε)^(−1)) = (K − k) log L vanishes at k = K and is largest at k = 0. The inverse coupling DECREASES toward the unit lattice; asymptotic freedom is (0.31) read at k = 0, 1/g₀² = 1/g² + Θ(log 1/ε). The easy half of Σ1b is therefore: per-step bounds β log L ≤ β_(k+1)(g_k; history) ≤ β′ log L for every history with every g_j ≤ γ ⟹ Theorem 2 entire — the existence of g₀(ε, g) by truncation of the shift outside the region, continuity in g₀ and the intermediate value theorem on x_K = 1/g², monotonicity keeping every x_j ≥ 1/g² ≥ 1/γ² where the truncation is inactive, and (0.31) by summation. (0.31) is the conclusion of the summation, not the hypothesis of the lemma.

**The hard half, exactly.** Prove 0 < β log L ≤ β_(k+1)(g_k) ≤ β′ log L uniformly in k and in the histories admitted by Theorem 1, with g ∈ ]0, γ]. By (1.3) the step's marginal coefficient has two parts: (i) the A-component of log Z^(k)(U) − log Z^(k)(1), the background dependence of the fluctuation determinant of (1.4) — the one-loop coefficient in Bałaban's block scheme (p. 267, (2.11): the order-zero terms of the second step, ⟨H₁hC̃^(2)(B′), J⟩ − ½G^(2)(B′) − ½⟨H₁B′, Δ₁H₁B′⟩, "the quadratic form defines the k-th normalization factor Z^(k)(U_(k+1))"); (ii) the A-component of E^(k+1)(g_k, U) − E^(k+1)(g_k, 1), the second-order part, extracted by (0.28). For (i) the target number is known from outside: in Bałaban's normalisation 1/g² is Wilson's β exactly (his (0.2), the normalised trace), and the continuum one-loop running of SU(2), d(1/g_YM²)/d log μ = (22/3)/(8π²) with β_Wilson = 4/g_YM², gives Δβ_Wilson = 0.2575 per doubling — so for L = 2 the one-loop part must read 0.258 up to the block scheme's finite correction, which depends on L and on the averaging operator and converges as the step index grows (the plan's δ_k → δ_∞); positivity for L ≥ L₀ with L₀ named is the first lemma. For (ii) the bound is O(g_k²) uniformly in k, which is the "second order perturbative calculations" of p. 259: the cubic and quartic vertices of the fluctuation integral expanded to the order at which the A-component is explicit, the remainder bounded through Theorem 1's small-field bounds (0.25)/(0.29) for the irrelevant terms and the analyticity of the small-field action in the coupling (the Cauchy estimates), with the extraction map (0.28) shown bounded on functions obeying (0.25). Both halves are finite-dimensional per step and uniform in the step by the scaling; the length is the bookkeeping of the block scheme (the averaging operator, the gauge fixing (0.14)–(0.16), the minimal configurations (0.21) of [15]). This is the paper Bałaban announced in 1987 and never wrote; the fourth seat is extracting his objects verbatim (the normalisation defining g_(k+1), the extraction's Ward–Takahashi section, Theorem 1's analyticity domain and remainder norm, the averaging operator Q) and the Yang–Mills seat derives (i) with L₀ as the first number. Falsifier beside it, standing: for U(1) the one-loop coefficient is zero, so the lower bound β > 0 fails and Theorem 2 fails with it — the chain separates the groups at Σ1b, at the ultraviolet end, exactly where Theorem 8.7's separation is at the infrared end.
