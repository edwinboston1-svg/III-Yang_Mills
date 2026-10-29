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
p. 264 (the precise form; CORRECTED 2026-10-29 06:3x, first written as p. 267): "**Theorem 3.** There exist positive constants κ₀, M(κ), γ, ε₀, ε₁, α₀, α₁ such, that if
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

## 8. CORRECTIONS AND TWO RESOLUTIONS (2026-10-29, 06:3x by the clock)

- CORRECTION: Theorem 3 of CMP 109 is on p. 264, the page after (1.20)-(1.22), not p. 267. Read from the rendered page
  (PDF page 16, headed 264) and the text layer's page marker. §1 above is corrected in place.
- "(0.31) [II]" in LFR II p. 355 is a citation slip for CMP 109 ([I]). Basis, by text extraction only (pages not
  rendered): CMP 116's text carries no section-0 equation numbers, and its introduction refers to CMP 109 as "I".
- β_{j+1}(g_j) depends on the whole history. CMP 109 p. 298: "We write β_j as explicitly dependent on g_{j-1},
  although it depends also on all preceding coupling constants. The dependence on g_{j-1} is important and it
  determines main properties of the renormalization group equations."

## 9. THEOREM 2, OURS: what the pages define, assume and prove (2026-10-29, 06:41 by the clock)

- DEFINED: β_{j+1}(g_j) = Σ_x Π_{j+1,μν}(g_j, x) x_μ x_ν (μ ≠ ν), where Π^{ab}_{j+1,μν}(g_j,x,x′) is the second
  B-derivative at B = 0 of E^(j+1)(g_j, U_{j+1}(exp iB)) in the infinite-volume limit ((1.20)-(1.22) p. 264; again
  (5.1) p. 292 and (5.42) p. 297, "the fundamental equality defining the β-function"). The one-loop log Z^(j) part is
  inside (bold E of (1.6) p. 261). The recursion is (2.15) p. 268.
- THE EXTRACTION: Ward-Takahashi reduce the cubic and quartic marginal parts to E^(2) ((4.31) p. 289); global
  invariance makes E^(2) colour-diagonal ((4.32)-(4.33)); Π = β(δΔ − ∂̄∂) + Π′, Π′ third order ((5.37)-(5.38));
  Π′ irrelevant ((5.44)); cancellation against the absorbed terms (4.38)-(4.44) pp. 291-292.
- ASSUMED, not proved as a lemma: "It is a smooth function defined on the interval [0, γ], (or analytic), uniformly
  bounded on this interval together with all derivatives. We will investigate other properties in a separate paper."
  (p. 264). E^(j) is "a C^∞-function of g_{j-1} ∈ [0, γ], (or analytic)" (p. 263). No passage of CMP 109 §2-§5 or of
  CMP 116 differentiates in g_k (reading of §4-§5 and pp. 264-268; grep of both text layers).
- PROVED, uniformly in j: |β_j| ≤ C, from (5.10) and (5.42) with absolute E₀, δ₁. No positivity, no g-derivative.
- NOT COMPUTED anywhere in the four papers: β_{j+1}(0), the one-loop value, as a number or as a formula in L.
- THE TARGET it must bracket, my derivation, not his page: in his normalization (tr 1 = 1, β_Wilson = 1/g²) the
  one-loop centre is 8b₀ = 11/(3π²) ≈ 0.3715 per unit log for SU(2).
- THEREFORE ours: (i) inf_j β_{j+1}(0) ≥ c > 0; (ii) |β_{j+1}(g) − β_{j+1}(0)| ≤ C g uniformly in j and in the
  history; (iii) the easy half, the intermediate-value step on g₀ (CMP 109 p. 259's statement).
- NEEDED to go further: [10] CMP 95 17-40 (Δ_j at (1.66)), [12] CMP 98 17-51 ((106)), [13] CMP 99 389-434 (Sect. D,
  (3.127)-(3.128)), [III] CMP 119 243-285 (LFR II's "Sect. 2 [III]"). The orchestrator is asking the operator.
