# MG — THE EVERY-GROUP AUDIT AND GENERALISATION OF THE WHOLE CHAIN (compact simple G, the Clay statement exactly)

Proof agent MG, 2026-11-02 (desktop; read-only in both repositories; everything here is in this directory). Appended as the work
proceeds; nothing above a line is edited after it is written except by a dated correction below it. Labels: READ (on the page or
the text layer, today), PROVED (full proof here), PROVED GIVEN [named input], NAMED (stated with its falsifier, not proved),
COMPUTED (exact, or double precision with known answers met — a CHECK, never a proof input unless said), LITERATURE (cited, not
re-proved, not used in a proof).

## 0. Sources read before deriving

MATH_BRIEF.md and M4_BRIEF.md in full. THE GROUND (III-Yang_Mills `source/ground/content3.js` whole: §7, Theorem 7.1, Corollary
7.2, Lemma 7.3, Theorem 7.4, Corollary 7.5; `content4.js` lines 1–170 whole: §8.1, Propositions 8.1–8.4 with proofs, §8.3 the
block maps and the projection sentence, (8.5), Hypotheses I and II, Theorem 8.5 and its proof, the MK-budget paragraph, the
perfect cover, Lemma 8.6 with proof, Theorem 8.7 with proof and Table 3, Theorem 8.8, "the open part" (Bałaban's γ, Osterwalder–
Seiler "with no coupling named", Shen–Zhu–Zhu and Douglas–Rajasekaran converted), Theorem 8.9 with its proof chain and §8.4).
M3/WORK.md §4 (normalisation) and §5 (Theorem 2 bounded-transient; Lemmas A′, B, C, D; assembly); M3b/WORK.md whole (§§0–15: the
eleven papers hashed, (BB4) read, (S₁) stated, Lemma C′, Σ₁, (PI), (D), Prop. D∞, (E1), (E2) with S-A); M3c/WORK.md whole (§§0–12:
Lemma M, BB4*, the moment form, Lemma W (the D-term), Lemma FP, Lemma C′, (PI-1)–(PI-5)); M2/WORK.md §§0–5 (Proposition 1.1,
Lemma 2.1–Theorem 2.3, Proposition 2.5, Theorem 3.1 = Theorem 8.5′, Theorem 4.1 the refusal of U(1)); M4/WORK.md whole (§§0–12:
Theorem 2.1, Proposition 2.2, Lemmas 3.1–3.2, Theorem 3.3, Theorem 4.1, Theorems 5.1–5.2, the readings, Theorem 8.1 Turán slaving,
Lemma W with (W-V) and (W-S)); M4R/REVIEW.md whole (the repairs to Theorems 3.3, 4.1, 8.1; the per-step criterion CONDITIONAL).
III DOCS/III-THE-CROSSING-CAMPAIGN-OF-THE-YANG-MILLS-GAP.md §§18–20 whole (the bent object never computed; the β ↔ β/2 slip and
the two-step readings 0.2930/0.2225; §20's reduction C ≤ δT_∂/(1 − δ) and why it does not close the window for gauge-covariant
links). III-Yang_Mills OPEN/the-standing.md §8 and the next-objects list item 5; OPEN/the-crossing-campaign.md row W8 ("a group
whose window does not close (then the theorem is not universal and says so)"); OPEN/ledger/s1-the-flux-surface-gas.md lines
257–312 (the −1/3 crossing ratio, the vertex table, "the sl₂ weight system"). Kernel heads: Unitary.lean ("every unitary
representation of every finite group").

Bałaban's GROUP HYPOTHESES, READ on the text layers M3b/src/cmp*.txt (pdftotext of the eleven hashed papers):
- CMP 109 p. 251–252: "Field configurations have values in a compact Lie group G … We assume that G is semisimple and that it is a
  Lie subgroup of a group of complex unitary matrices, for example G ⊂ U(N). (In fact a bigger part of our considerations does not
  depend on the semisimplicity assumption.)"; Wilson's action with the NORMALISED trace, A(U) = Σ_p ε^{d−4}[1 − Re tr U(∂p)].
- CMP 109 p. 259: Theorem 1 "will be proved in this paper for an arbitrary semisimple compact Lie group G ⊂ U(N), and for d = 4.
  The proof also covers the dimension d = 3 …"; Theorem 2: "Let d = 4, G = SU(2) …"; p. 260: "The restriction to the group SU(2)
  is superficial and is done only to simplify calculations."
- CMP 102 (255–275) p. 257: Theorem 1, "the three-dimensional pure Yang–Mills theory with a semi-simple compact group Lie G";
  "can be generalized to a much wider class of compact Lie groups … We have restricted ourselves to semi-simple groups because then
  the proof is particularly simple"; p. 264 the one use of semisimplicity: "by the assumption that g is semi-simple, the only element
  invariant is 0"; the Haar density in exponential coordinates "can be calculated explicitly for all classical groups … Generally
  σ(A) is an analytic, positive, even function of A in a neighbourhood of 0 ∈ g, invariant with respect to the adjoint
  representation".
- CMP 98 (averaging): "a Lie subgroup G of a unitary group U(N)"; CMP 99: "a compact Lie group G ⊂ U(N)"; CMP 102 (277–309) and
  CMP 116, 119, LFR I–II: g-valued (and g^c-valued) fields and "values in the group G" throughout, no further restriction; CMP 116
  never names a group (it works with the fluctuation field B alone).

## 1. The plan (deep-think synthesis, before deriving; the decision this file executes)

What I expected: that the UV half is SU(2)-only (Theorem 2 is stated for SU(2)), that the reduction is group-blind, and that the
window's centre split generalises with Z(G) in place of Z₂. What the reading and the lenses changed:
(i) Bałaban's whole series is stated for every semisimple compact G ⊂ U(N); only Theorem 2 (unpublished in any case) is stated for
SU(2), "superficially". The program's reproof of Theorem 2 (M3 §5) is group-blind except through three constants (c, b, F), so the
UV half generalises at EXACTLY the status it has for SU(2).
(ii) For G₂, F₄, E₈ the centre is trivial, so M4's vortex half is EMPTY and Lemma W collapses to its SO(3)-analogue: Hypothesis
I-L² itself. The centre is a confinement mechanism, not a gap mechanism (G₂ has a gap and no area law at asymptotic distances); the
gap's universal carrier is the centre-blind channel, the 0⁺⁺ glueball, which is centre-even for every G. So the every-G window
lemma has ONE universal core, (W-S)_G, and the vortex half is a G-dependent supplement that is absent exactly for the groups where
confinement (area law) is absent.
(iii) Turán slaving is NOT a general-G phenomenon. Its general form (submultiplicativity of Wilson's character coefficients along
Cartan products) fails at strong coupling for every complex representation (SU(N ≥ 3): the adjoint channel beats the product of
the fundamental channels by N²/(N² − 1)) and for the minimal representations of F₄ and E₈; SU(2)'s pseudoreal fundamental is
special. To be proved exactly at leading order and checked numerically.
(iv) Both instrumented ends of the window are G-UNIVERSAL in the 't Hooft coupling λ = h^∨ g²_YM (long roots of length² 2): the
one- and two-loop β-function (b₁/b₀² = 102/121 for every G) and the Bakry–Émery strong-coupling region λ > 32(d − 1) = 96 (Ric_G =
−¼ Killing). Shen–Zhu–Zhu's two separate thresholds (SO(N), SU(N)) are this ONE condition.
Decision: link-by-link, every statement for general G with its constants, each proof given where it is a proof, the SU(2)-specific
computations (Lemma 8.6, Theorem 8.7's numbers, Theorem 8.9's gas, Turán) replaced by their general form or by an exact
obstruction; the decisive point (4) stated in the form valid for every G with its two controls; the open estimates per G with
falsifiers. Kill-switch: if a "group-blind" proof uses an SU(2) identity (S³ geometry, quaternion linearity, Z₂, d_½ = 2), the row
is downgraded. Computations: Lie data by the Weyl dimension formula with known answers; SU(3) and G₂ Wilson character coefficients by
two roads (Weyl integration; Toeplitz–Bessel for SU(3)); stakes before each run.

## 2. STAKES (written before any instrument of this directory runs; none edited after)

Instrument A, `lie_data.py` (exact rational arithmetic: root systems from explicit simple roots, positive roots by reflection
closure, Weyl's dimension formula, C₂(λ) = (λ, λ + 2δ)/2 with long roots of length² 2, T(λ) = d_λC₂(λ)/dim G).
- KNOWN ANSWERS (the instrument is not trusted until all are met): dim G = 3, 8, 14, 52, 78, 133, 248 for A₁, A₂, G₂, F₄, E₆, E₇,
  E₈; h^∨ = C₂(θ) = 2, 3, 4, 9, 12, 18, 30; minimal representations 2, 3, 7, 26, 27, 56, 248 with T = 1/2, 1/2, 1, 3, 3, 6, 30;
  G₂: d(ω₂) = 14 (adjoint); F₄: 52 adjoint, 26 minimal; E₈: the minimal representation is the adjoint.
- S-A1 (Cartan squares): d_{2ω} = 3 (A₁), 6 (A₂), 27 (G₂), 324 (F₄), 351 (E₆), 1463 (E₇), 27000 (E₈); for A₂ the mixed product
  d_{ω₁+ω₂} = 8.
- S-A2 (the strong-coupling Cartan ratio, §6 below): d²/(2d_{2ω}) = 2/3, 3/4, 49/54, 676/648, 729/702, 3136/2926, 61504/54000;
  for A₂ the mixed ratio d²/d_{ω+ω*} = 9/8. Submultiplicativity fails at strong coupling where the ratio exceeds 1: A₂ (mixed),
  F₄, E₆ (whose 27 is complex: its mixed ratio 729/650 also > 1), E₇ (3136/2926 > 1), E₈. Holds for A₁, G₂ (Cartan square).
- S-A3 (the crossing ratio r_× = 1 − h^∨/(2C₂(ρ)), §5.4): −1/3 (A₁, ½), −1/8 (A₂, 3), 0 (G₂, 7), 1/4 (F₄, 26), 1/2 (E₈, 248).

Instrument B, `coeffs.py` (double precision; the Wilson plaquette weight e^{(β/d)Re χ_ρ}; a_λ(β) = c_λ/(d_λc₀), c_λ = ∫e^{(β/d)Re χ_ρ}
conj χ_λ). SU(3) by two roads sharing no line: Weyl integration on the maximal torus (trapezoid on [0, 2π)², the integrand periodic)
and the Toeplitz–Bessel sum c_λ = Σ_q det[I_{λ_j − j + i + q}(β/3)]. G₂ by Weyl integration on its torus (12 roots, |W| = 12).
- KNOWN ANSWERS: ∫1 = 1, ∫χχ̄ = 1 for each irreducible character read, ∫χ_3 = 0, ∫χ_3³ = 1 (SU(3)), ∫χ_7³ = 1, ∫χ_7χ_14 = 0
  (G₂); the two SU(3) roads agree to 10⁻¹² relative; at β = 10⁻³ the ratios equal their leading-order values to 10⁻².
- S-B1 (SU(3)): R₃(β) := a_8/(a_3a_3̄) → 9/8 as β → 0 and exceeds 1 on an interval (0, β₁); β₁ UNGUESSED within [1, 10]; R₃
  decreasing on (0, 20] (UNGUESSED: monotone or not), below 1 at β = 20.
- S-B2 (G₂, trivial centre): a_27/a_7² → 49/54 (< 1) and a_14/a_7² → 7/4 (> 1) as β → 0; a_14/a_7² stays above 1 on (0, 20]
  (UNGUESSED).
- S-B3 (the defining representation carries the coupling): sup over the irreducibles read of a_λ equals a_ρ at every β read, for
  SU(3) (over 3, 3̄, 6, 8, 10) and G₂ (over 7, 14, 27).

## 3. RESULTS (records `lie_data_run.2026-11-02a.txt`, `coeffs_run.2026-11-02a.txt`, `roads_check_run.2026-11-02a.txt`; rc = 0;
nothing in §2 edited)

Instrument A — every known answer MET (exact): dim G = 3, 8, 14, 52, 78, 133, 248; h^∨ = 2, 3, 4, 9, 12, 18, 30; minimal
representations 2, 3, 7, 26, 27, 56, 248 with T = 1/2, 1/2, 1, 3, 3, 6, 30; G₂'s ω₂ is the 14; F₄'s ω₁ the 52, ω₄ the 26; E₈'s
minimal representation is the adjoint (C₂ = 30 = h^∨). Also Sp(2): 4 (T = 1/2), Spin(7): vector 7 (T = 1), spinor 8 (T = 1).
- S-A1 HELD: d_{2ω} = 3, 6, 27, 324, 351, 1463, 27000; d_{ω₁+ω₂}(A₂) = 8; d_{ω+ω*}(E₆) = 650.
- S-A2 HELD: d²/(2d_{2ω}) = 2/3, 3/4, 49/54, 169/162, 27/26, 224/209, 3844/3375 (A₁, A₂, G₂, F₄, E₆, E₇, E₈); mixed ratios 9/8 (A₂),
  729/650 (E₆); Sp(2) 4/5, Spin(7) vector 49/54.
- S-A3 HELD: r_× = −1/3, −1/8, 0, 1/4, 1/2 (A₁, A₂, G₂, F₄, E₈); E₆ 4/13, E₇ 7/19, Sp(2) −1/5, Spin(7) vector 1/6.
- The normalisation constants κ_ρ = d_ρ/T_ρ and h^∨κ_ρ = h^∨ dim G/C₂(ρ): (4, 8) SU(2); (6, 18) SU(3); (7, 28) G₂; (26/3, 78) F₄;
  (9, 108) E₆; (28/3, 168) E₇; (124/15, 248) E₈. Universal: Δ(1/λ) per doubling at one loop = 11 ln 2/(24π²) = 0.032188976;
  b₁/b₀² = 102/121.

Instrument B — every known answer MET (∫1, ∫|χ|², ∫χ₃, ∫χ₃³ = 1, ∫χ₇³ = 1, ∫χ₇χ₁₄ = 0, to 10⁻¹³); quadrature n = 192 against 256
equal to 15 digits at β = 20.
- Two roads (SU(3)): the stake "agree to 10⁻¹² relative" is REFUTED AS STATED for the smallest coefficient: c₁₀ at β = 10⁻³ is
  7.7·10⁻¹³ and road 1's grid sum carries an absolute rounding floor 8·10⁻¹⁷ (relative 1.1·10⁻⁴); relative to c₀ the roads agree
  to 10⁻¹⁶ at every coupling, and every coefficient entering a ratio below (c₃, c₃̄, c₈) agrees to ≤ 3·10⁻⁹ relative at β = 10⁻³
  and ≤ 10⁻¹² for β ≥ 0.5 (roads_check).
- S-B1: R₃ = a₈/(a₃a₃̄) = 1.124937503 at β = 10⁻³ (9/8 = 1.125: HELD), above 1 on (0, β₁) with β₁ = 2.304516402 (UNGUESSED within
  [1, 10]: HELD), below 1 at β = 20 (0.948800: HELD). "Decreasing on (0, 20]" REFUTED: R₃ falls to a minimum 0.90342 near β ≈ 8
  and RISES toward 1 (0.9101 at 10, 0.9331 at 15, 0.9488 at 20), as the weak-coupling heat-kernel form 1 − (C₈ − 2C₃)k/β → 1⁻
  requires (C₈ − 2C₃ = 1/3 > 0). The supremum over the grid is the β → 0 limit 9/8.
- S-B2 HELD: a₂₇/a₇² = 0.907407403 at 10⁻³ (49/54 = 0.9074074), below 1 at every β read (minimum 0.838 near β ≈ 10–12);
  a₁₄/a₇² = 1.749916662 at 10⁻³ (7/4), above 1 at every β read (1.009179 at β = 20).
- S-B3 HELD: max(a₈, a₆, a₁₀)/a₃ ≤ 0.762 and max(a₁₄, a₂₇)/a₇ ≤ 0.659 at every β read: the defining representation carries the
  largest normalised coefficient on [0, 20] for SU(3) and G₂.

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

## 5. LINK (2): THE REDUCTION — THEOREMS 7.1, 7.4, 8.5, 8.5′ AND THE BLOCK MAPS, FOR EVERY G

### 5.1 Reflection positivity for every compact G (PROVED: the input every theorem of §7 and §8.3 takes)

LEMMA RP_G. For every compact group G, every finite-dimensional unitary representation ρ and every β ≥ 0, the plaquette weight
w(U) = exp((β/d_ρ) Re χ_ρ(U)) has nonnegative coefficients in the irreducible characters, w = Σ_{r∈Ĝ} c_r(β) χ_r with c_r ≥ 0 and
Σ_r d_r c_r = w(1) = e^β < ∞; hence w is a continuous positive-definite class function, the kernel (g, h) ↦ w(gh^{−1}) is positive
semidefinite, and the Wilson measure on every periodic lattice is reflection positive with a positive transfer matrix.
PROOF. Re χ_ρ = ½(χ_ρ + χ_ρ̄) = ½χ_{ρ⊕ρ̄}. Every power χ_{ρ⊕ρ̄}^n = χ_{(ρ⊕ρ̄)^{⊗n}} is a character of a genuine representation, so it
is a combination of irreducible characters with nonnegative integer multiplicities; e^{tX} = Σ_n t^nX^n/n! with t = β/(2d_ρ) ≥ 0 is
therefore a nonnegative combination, converging absolutely in sup norm (Σ_n t^n(2d_ρ)^n/n! = e^β). Evaluating at U = 1 (χ_r(1) = d_r)
gives Σ d_rc_r = e^β. A class function with nonnegative character coefficients is positive definite: Σ_{i,j} ξ_iξ̄_j w(g_ig_j^{−1}) =
Σ_r c_r Σ_{i,j} ξ_iξ̄_j χ_r(g_ig_j^{−1}) = Σ_r c_r ‖Σ_i ξ_i D^r(g_i)‖²_HS ≥ 0. Reflection positivity of the lattice measure with a
positive-definite plaquette weight, and positivity of its transfer matrix, is Osterwalder–Seiler's theorem (1978) for compact gauge
groups, with Lüscher's construction of the transfer matrix (LITERATURE, THE GROUND's Sources [5], [7]); the program's kernel proves the
finite-group form for every unitary representation of every finite group (Unitary.lean, READ at its head). ∎

### 5.2 Theorems 7.1, 7.4, Lemma 7.3, Corollaries 7.2, 7.5 — PROVED for every G (read: no group enters)

Theorem 7.1 is the spectral theorem on the Osterwalder–Schrader space of a reflection-positive, time-translation-invariant S;
Lemma 7.3 is a passage to the limit of inequalities between Schwinger functions flat at the diagonals; Theorem 7.4 consumes (a) Wilson
measures on periodic lattices "with bare couplings tuned along the sequence" — for G the tuning is Theorem 2_G's (§4.2) — (b) Lemma
4.2's transfer-matrix bound and (c) RP, Lemma RP_G. Corollary 7.2's Euclidean-rotation step and Corollary 7.5 use (E1), a property of
the limit, not of G. Every statement holds verbatim for every compact simple G.

### 5.3 Theorem 8.5, Theorem 8.5′ (M2 Theorem 3.1), Proposition 8.4, M2 Theorem 4.1, campaign §20 — PROVED for every G

Theorem 8.5's proof uses: the law of total covariance along a measurable coarse map; Dobrushin's comparison theorem "for arbitrary
single-site spaces" (Georgii Thm 8.20) on the blocked measure, whose single-site space V is compact; Proposition 8.4 (tilts, on any
probability space); the counting of pairs (2n + 1)⁸ on the coarse lattice. No group. Theorem 8.5′ (M2 §3) replaces the comparison by the
L² covariance theorem (M2 Theorem 2.3: projections K_y on L²(λ), a positive density on a product of compact spaces) — no group;
M2's Theorem 4.1 (the refusal) is stated by M2 "with any compact group G". Campaign §20's reduction C^λ(y, y′) ≤ δ_yT_∂/(1 − δ_y) uses the
Markov property of the Wilson specification (each block's conditional law depends on the 80 = 3⁴ − 1 neighbouring blocks) and
Dobrushin's contraction — no group. The block maps enter only through their measurability and the existence of versions of the fibre
and blocked conditional laws for every coarse configuration (THE GROUND §8.3, READ: "it holds unchanged for any measurable map from
the configurations of a rung to coarse configurations with values in V").

### 5.4 Block maps for general G: the holonomy map, the averaged map, and the projection's domain (PROVED)

(a) THE HOLONOMY MAP: one G-element per coarse link (the ordered product along a fixed fine path, the remaining links in a fixed
gauge) is a measurable bijection of each block's configurations onto V × Φ_j with V = G⁴ (four coarse links per coarse site),
defined EVERYWHERE, for every G. Its ultraviolet instability is G-blind: in the Gaussian field each colour component of the coarse
flux has variance g²(4G₃(0)n + o(n)) (THE GROUND's computation, componentwise in g), so every normalised character mean
E[χ_r(v)]/d_r ≈ exp(−½C₂(r)·g²·Var) → 0 for every r ≠ 0 along the asymptotically free sequence: the coarse variables tend to independent
Haar variables for every G, and Hypothesis II(a) carries all the content (THE GROUND's diagnosis, now for every G).
(b) THE AVERAGED MAP needs a projection to G. Let E_G := span_ℝ ρ(G) ⊂ End(V_ρ) with ⟨A, B⟩ := Re tr(A†B), and for M ∈ E_G let
  Π_G(M) := argmax_{g∈G} ⟨ρ(g), M⟩  — the nearest point of ρ(G) to M (‖M − ρ(g)‖² = ‖M‖² + d_ρ − 2⟨ρ(g), M⟩).
LEMMA P_G. (i) φ(M) := max_g ⟨ρ(g), M⟩ is convex and finite on E_G; Π_G(M) is a single point exactly where φ is differentiable, and
there ∇φ(M) = ρ(Π_G(M)). Hence the cut locus 𝒞_G := {M : the maximiser is not unique} is a Borel set of Lebesgue measure zero in E_G,
and Π_G is continuous on E_G ∖ 𝒞_G (real-analytic where the maximum is nondegenerate). (ii) Bi-equivariance: Π_G(ρ(h)Mρ(k)) =
hΠ_G(M)k off 𝒞_G; in particular Π_G(ρ(z)M) = zΠ_G(M) for z ∈ Z(G) (ρ irreducible, so ρ(z) = ζ_z·1). (iii) SU(2), ρ fundamental:
E_G = ℍ ≅ ℝ⁴, Π(M) = M/|M| and 𝒞 = {0}. (iv) SU(N), N ≥ 3, ρ fundamental: E_G = M_N(ℂ), and 𝒞 contains a real-analytic
hypersurface through M₀ = e^{iπ/N}·1 across which Π_G jumps between 1 and ω·1 (ω = e^{2πi/N}): THE AVERAGED BLOCK MAP OF SU(N≥3) IS
DISCONTINUOUS ACROSS A CODIMENSION-ONE SET, AND ITS JUMPS ARE CENTRE ELEMENTS. (v) A Borel selection of the argmax exists on all of E_G (the argmax is a nonempty compact-valued upper
hemicontinuous correspondence: Kuratowski–Ryll-Nardzewski), so the averaged coarse map M ↦ Π_G(M) is measurable for every G whatever
the law of M — which is all Theorems 8.5 and 8.5′ consume; when the law of the average is absolutely continuous on E_G (necessary:
k·dim G ≥ dim E_G for k summands; for SU(2) two independent uniform points of S³ already have a density on the ball of radius 2), the
selection on the null set 𝒞_G is immaterial.
PROOF. (i) φ is the support function of the compact set K = ρ(G), a supremum of linear functions: convex, finite, Lipschitz. Its
subdifferential at M is conv{ρ(g) : g a maximiser} (Danskin). Every point of K lies on the sphere ‖A‖² = d_ρ, so every point of K is
an extreme point of conv K (a sphere is strictly convex); hence the subdifferential is a singleton iff the maximiser set is one point,
i.e. φ is differentiable at M iff the maximiser is unique, and then ∇φ = ρ(Π_G(M)). A convex function on a finite-dimensional space is
differentiable outside a Lebesgue-null Borel set (Rademacher). Continuity off 𝒞: if M_n → M with unique maximisers g_n and g a limit
point of g_n, then g maximises at M (continuity of ⟨ρ(·), ·⟩), so g = Π(M): the bounded sequence has the single limit point Π(M).
Real-analyticity at a nondegenerate maximum: the implicit-function theorem for ∇_g⟨ρ(g), M⟩ = 0. (ii) ⟨ρ(g), ρ(h)Mρ(k)⟩ =
⟨ρ(h^{−1}gk^{−1}), M⟩ (unitarity, cyclicity), so the maximisers transform by g ↦ hgk. (iii) For SU(2), ρ(g) is a unit quaternion and
⟨ρ(g), M⟩ = 2⟨g, M⟩_{ℝ⁴} on ℍ; the maximiser of a nonzero linear functional on S³ is unique. (iv) On the torus, g = diag(e^{iθ_j}) with
Σθ_j ∈ 2πℤ, ⟨ρ(g), M₀⟩ = Σ_j cos(π/N − θ_j). For any g ∈ SU(N), ⟨ρ(g), M₀⟩ = Re(e^{iπ/N} tr g†) and conjugation-invariance reduces the
maximisation to the torus; a critical point has sin(π/N − θ_j) equal for all j, so each θ_j ∈ {s, π + 2π/N − s} (mod 2π) for one s;
with k coordinates in the second class the value is (N − 2k)cos(π/N − s), and for 1 ≤ k ≤ N − 1 this is at most N − 2 < N cos(π/N) (N ≥ 3: N − N cos(π/N) ≤ π²/(2N) < 2), so the maximum is at θ_j ≡ θ, Nθ ∈ 2πℤ, value
N cos(π/N − 2πm/N), largest exactly at m = 0 and m = 1: the two central elements 1 and ω·1, both nondegenerate (the Hessian in
direction X = iH ∈ su(N) is −cos(π/N)·tr H² < 0, tr H = 0 removing the linear term). Near M₀ the two local maximum values f₀(M), f₁(M)
are analytic with gradients ρ(1) = 1 and ρ(ω·1) = ω·1 (Danskin); 1 ≠ ω·1, so {f₀ = f₁} is a real-analytic hypersurface through M₀, on
whose two sides Π_G equals the continuation of 1 and of ω·1 respectively. (v) The correspondence M ↦ argmax is nonempty, compact-valued and upper hemicontinuous (Berge's maximum theorem), hence admits a Borel
selection (Kuratowski–Ryll-Nardzewski — LITERATURE). ∎
CONSEQUENCES. (1) Theorems 8.5, 8.5′ hold for the averaged map of every G. (2) M4's averaged-map twist identity (its clause conditional on
the cutting set S, M4R item 1′) uses only Π_G(ζM) = ζΠ_G(M) for central ζ, which (ii) gives for every G and every z ∈ Z(G). (3) The
DOMAIN ISSUE, NAMED EXACTLY: for SU(2) the averaged map is singular only at a zero average (codimension four, the GROUND's "configurations
at which its average vanishes"); for SU(N ≥ 3) it is singular on a codimension-ONE set where it jumps by a centre element — the averaged
coarse variable itself carries a centre-vortex interface wherever the fine average sits between two centre elements; for trivial-centre
G (G₂ ⊂ SO(7) in its 7, F₄ in its 26, E₈ in its 248) the cut locus is null and its jumps are between non-central maximisers. Bałaban's
small-field analysis never meets 𝒞_G (averages within distance ε of ρ(G), where the maximiser is unique and analytic: CMP 98's averaging
through g); the large-field regions, where 𝒞_G lives, are handled by his large-field expansions, whose positivity input is
1 − Re χ_ρ(U)/d_ρ ≥ 0 with equality iff U = 1 (ρ faithful) — true for every G.

VERDICT ON LINK (2): Theorems 7.1, 7.4, 8.5, 8.5′ (and §20's reduction, M2's refusal theorem, Proposition D∞) are PROVED for every compact
simple G; the only G-input is reflection positivity (Lemma RP_G) and a measurable block map (the holonomy map everywhere; the averaged
map off the null cut locus 𝒞_G of Lemma P_G).

## 6. LINK (3): THE STRONG END FOR EVERY G

Normalisation throughout: plaquette weight exp((β/d_ρ) Re χ_ρ(U_p)) on ℤ⁴ (D = 4), β = κ_ρ/g²_YM, λ = h^∨g²_YM = h^∨κ_ρ/β.

### 6.1 THEOREM S_D (Dobrushin; every compact group, every unitary representation; PROVED)

For every compact group G, every finite-dimensional unitary representation ρ and 0 ≤ β < β_D := artanh(1/18) = ½ ln(19/17) =
0.055613…, the lattice gauge theory on ℤ⁴ has a unique infinite-volume Gibbs measure; for every m₀ < ln(1/(18 tanh β)) there is K
(depending on β, m₀ only) with |⟨fg⟩ − ⟨f⟩⟨g⟩| ≤ K N(f)N(g)‖f‖‖g‖e^{−m₀d} for bounded f, g of finitely many links (d the max-norm
distance of link midpoints), the same on every torus; and the transfer matrix has a unique vacuum and no spectrum in (0, m₀) on the
gauge-invariant sector.
PROOF. The conditional law of a link x given the others is ∝ exp((β/d_ρ)Σ_{p∋x} Re χ_ρ(U_xS_p))dU_x, S_p the staple of p. A link y
enters it only through the staple of the one plaquette p it shares with x (two distinct links share at most one plaquette); there are
2(D − 1)·3 = 18 such y. Changing U_y changes the conditional law by a tilt with g(U_x) = (β/d_ρ)[Re χ_ρ(U_xS′_p) − Re χ_ρ(U_xS_p)],
and |Re χ_ρ| ≤ d_ρ gives osc g ≤ 4β. The tilt bound proved in THE GROUND's proof of Theorem 8.7 ((T_gp)(B) − p(B) ≤ tanh(osc g/4), the
supremum over B and over p) gives C(x, y) ≤ tanh β, and C(x, y) = 0 for every other y. So Σ_y C(x, y)e^{κ|x−y|} ≤ 18 tanh(β)e^κ < 1
for κ < ln(1/(18 tanh β)) (the 18 neighbours lie at midpoint distance ≤ 1). Dobrushin's uniqueness theorem; the comparison theorem as
in the proof of Theorem 8.5 on one lattice with the links as sites (Theorem 8.7's last paragraph); Lemma RP_G and Theorem 7.1 at integer
times. ∎
The threshold is uniform in G and ρ. Against SU(2)'s own: the sharp single-link disk 3π/72 = 0.1309 (THE GROUND's MAD lemma), Theorem
8.7's 0.2452, Douglas–Rajasekaran's 1/96 and Shen–Zhu–Zhu's 1/12 (both converted by THE GROUND). In 't Hooft units S_D is λ > 18.0·h^∨κ_ρ,
which degrades with the group; §6.2 is the universal one.

### 6.2 THEOREM S_BE (Bakry–Émery; every compact simple G; the strong-coupling region is λ > 32(D − 1) = 96 for EVERY G and ρ)

THE TWO G-INPUTS (PROVED). Equip G with the bi-invariant metric g_ρ(X, Y) := Re tr(ρ(X)†ρ(Y)) (X = iX^aT^a): g_ρ(X, X) = T_ρΣ_a(X^a)².
(i) RICCI. For a bi-invariant metric Ric(X, X) = −¼B(X, X), B the Killing form (Milnor 1976 — LITERATURE, standard), and −B(X, X) =
Σ_{a,b}X^aX^b tr_adj(T^aT^b) = h^∨Σ_a(X^a)². Hence Ric_G = (h^∨/(4T_ρ)) g_ρ.
(ii) HESSIAN. Geodesics of a bi-invariant metric are one-parameter subgroups, so the Hessian of f = Re tr ρ(U₁U₂U₃U₄) along
(X₁, …, X₄) is f″(0) for f(t) = Re tr ρ(U₁e^{tX₁}⋯U₄e^{tX₄}) = Σ_k Re tr(⋯X_k²⋯) + 2Σ_{i<j} Re tr(⋯X_i⋯X_j⋯); |tr(AXBYC)| ≤
‖X‖_HS‖Y‖_HS for unitary A, B, C (Cauchy–Schwarz); so |f″(0)| ≤ (Σ_k‖ρ(X_k)‖_HS)² ≤ 4Σ_k g_ρ(X_k, X_k). Each link lies in 2(D − 1)
plaquettes, so H = −(β/d_ρ)Σ_p Re χ_ρ(U_p) has Hess H ≥ −(8(D − 1)β/d_ρ) Σ_ℓ g_ρ(X_ℓ, X_ℓ).
(iii) Ric + Hess H ≥ K·g_ρ with K = h^∨/(4T_ρ) − 8(D − 1)β/d_ρ > 0  ⟺  β < h^∨κ_ρ/(32(D − 1))  ⟺  λ = h^∨g²_YM > 32(D − 1).
THE CONCLUSION, AND ITS LABEL. Bakry–Émery's criterion (1985, LITERATURE) gives a log-Sobolev inequality with constant K for the finite-volume
Wilson measure uniformly in the volume; Shen–Zhu–Zhu (arXiv:2204.12737; READ at the abstract today) derive from it the uniqueness of the
infinite-volume limit, LSI and Poincaré there, exponential decay of correlations and a strictly positive mass gap, stating it for SO(N) and
SU(N). THE TWO-SIDED CHECK (their normalisation is Nβ Re Tr per plaquette, so β_ours = N²β_SZZ): their SU(N) condition |β| < 1/(16(d − 1))
is β_ours < N²/(16(d − 1)) = h^∨κ_ρ/(32(d − 1)) with h^∨ = N, κ = 2N; their SO(N) condition |β| < (N − 2)/(32(d − 1)N) is β_ours <
N(N − 2)/(32(d − 1)) = h^∨κ_ρ/(32(d − 1)) with h^∨ = N − 2, κ = N (vector, T = 1). BOTH OF THEIR SEPARATELY STATED THRESHOLDS ARE THE ONE
CONDITION λ > 32(d − 1). Status: PROVED GIVEN Shen–Zhu–Zhu's argument, whose G-dependence (on the evidence of both stated cases) is exactly
(Ric_G, the Hessian bound) — computed here for every G; their proof body was not read (alphaXiv not connected; the abstract only).
PER GROUP (D = 4), β_BE = h^∨κ_ρ/96: SU(2) 0.08333; SU(3) 0.1875; G₂ (7) 0.29167; F₄ (26) 0.8125; E₆ (27) 1.125; E₇ (56) 1.75; E₈ (248)
2.58333; in the coupling: g²_YM > 96/h^∨.

### 6.3 Osterwalder–Seiler's small parameter as a function of G (PROVED)

Write the normalised weight f_β = w/c₀ = 1 + Σ_{r≠0} d_r a_r(β)χ_r, a_r = c_r/(d_rc₀) ∈ [0, 1] (Lemma RP_G). In the polymer
(high-temperature) expansion of the kind Osterwalder–Seiler use for compact groups — each plaquette entering through f_β − 1 — every polymer
activity is bounded by the product over its plaquettes of
  u_G(β) := sup_U |f_β(U) − 1| = Σ_{r≠0} d_r² a_r(β) = e^β/c₀^G(β) − 1,   c₀^G(β) = ∫_G e^{(β/d_ρ)Re χ_ρ} dU.
PROOF: the coefficients are nonnegative, so the supremum of |Σ d_ra_rχ_r| is attained at U = 1 (|χ_r| ≤ d_r = χ_r(1)), and f_β(1) = e^β/c₀. ∎
c₀ ≥ 1 (Jensen; ∫Re χ_ρ = 0), so u_G(β) ≤ e^β − 1 for EVERY G; and c₀ = 1 + (1 + ε_ρ)β²/(4d_ρ²) + O(β³) (E(Re χ_ρ)² = (1 + ε_ρ)/2, ε_ρ = 1 if
ρ ≅ ρ̄, else 0), so u_G(β) = β + β²/2 − (1 + ε_ρ)β²/(4d_ρ²) + O(β³). The expansion converges when u_G(β) is below a lattice constant u_*(D) fixed
by plaquette-polymer combinatorics alone. So the G-dependence of the Osterwalder–Seiler threshold — which THE GROUND records was never named —
lies entirely in c₀^G(β), the moment generating function of the Haar law of Re χ_ρ/d_ρ, and is absent at leading order. S_D and S_BE supersede
it numerically.

### 6.4 THEOREM 8.7_G (the perfect-cover decimation for every G): the form PROVED, β*_{8.7}(G) > 0 PROVED, the values OPEN

The construction is group-blind where it is combinatorial: the perfect cover L₁ (one link per plaquette, period two; THE GROUND, R7) and the
counts 12 (direct) and 90 (mediated). The S³ geometry generalises as follows. With ⟨A, B⟩ = Re tr(A†B) on E_G, (1/d_ρ)Re χ_ρ(U_aS) =
⟨ρ(U_a), ρ(S)†⟩/d_ρ, so given L₀ the cover links are independent with laws
  ν_W(dU) ∝ e^{⟨ρ(U), W⟩}dU,  W(a) = (β/d_ρ)Σ_{p∋a}ρ(S_p(a))† ∈ E_G,  ‖W‖_HS ≤ 6β/√d_ρ
(the matrix von Mises–Fisher, or matrix-Langevin, family on G; SU(2)'s vMF on S³ is the case E_G = ℍ), and the marginal of L₀ has density
Π_a Z_G(W(a)), Z_G(W) = ∫_G e^{⟨ρ(U),W⟩}dU, bi-invariant: Z_G(ρ(h)Wρ(k)) = Z_G(W). For a kept link x, θ_p(U_x) = (β/d_ρ)(ρ(A)ρ(U_x)ρ(B))† is
an HS-isometric image of ρ(U_x) — the structure the SU(2) proof uses. Taylor's theorem for log Z_G (gradient: the mean of ν_W; Hessian: its
covariance; third derivative: its third cumulant) and the two tilt facts give C_dir and C_med of (8.12) with four constants of the family on the
ball ‖W‖ ≤ 6β/√d_ρ in place of Lemma 8.6's:
 (M) M_G := sup_W sup_{‖e‖=1} E_{ν_W}|⟨ρ(U), e⟩ − E⟨ρ(U), e⟩| (SU(2): THE GROUND's sharp one-link constant, maximal at Haar only);
 (Σ) σ_G(r) := sup_{‖W‖≤r} ‖Cov_{ν_W}‖_op (SU(2): ¼ in ℝ⁴ units at every r, Lemma 8.6(i)); its Haar value is computed exactly:
     E_Haar⟨ρ(U), e⟩² = ‖e‖²/(2d_ρ) for complex ρ, ‖e‖²/d_ρ for self-dual ρ (Schur orthogonality; e ∈ E_G);
 (D) the oscillation of the quadratic remainder's dependence on the direction of W (SU(2): |D| ≤ m²/3, Lemma 8.6(ii), from Turán for I_ν);
 (T) the third-cumulant bound (SU(2): m/2, Lemma 8.6(iii)).
THEOREM 8.7_G. If α_G(β) := 12C_dir + 90C_med < 1, the Gibbs measure is unique, correlations cluster with any m₀ < log(1/α_G)/2, and the gap holds.
β*_{8.7}(G) > 0 for every G: on the ball the four constants are finite (compactness, smoothness of Z_G > 0) and α_G(β) = O(β) as β → 0.
WHAT MUST BE RECOMPUTED PER GROUP (OPEN for G ≠ SU(2)): certified enclosures of (M), (Σ), (D), (T) over the parameter space of ν_W modulo G×G
(SU(2): |W| and the angle of e — THE GROUND's 9,104 rectangles; SU(N): the N singular values and the phase of det W, with e; G₂, F₄, E₈: the
polar parameters of E_G under G×G), the location of the MAD maximum (at Haar for SU(2); UNGUESSED for every other G), and the analogue of the
Turán inequality behind |D| ≤ m²/3 (§7.5: Turán's inequality does not transfer to general G as such). The theorem's FORM and the positivity of
its threshold hold for every G now.

### 6.5 THEOREM 8.9_G (the flux-surface gas for every G): what generalises, what changes, the crossing law PROVED

(a) ADMISSIBILITY. A labelled plaquette set contributes iff at every link the tensor product of its labels (r or r̄ by orientation) contains the
trivial representation. The centre imposes n-ality conservation at every link, Σ ±ζ(r_p) = 0 in Ẑ(G). SU(2): half-integer labels form Z₂-cycles
(THE GROUND's Z₂-minimal surfaces). SU(N): Z_N-chains — for SU(3) three fundamental sheets may meet on a link (the baryonic junction; ∫χ₃³ = 1, READ
in instrument B, entering c₃ at order β²). TRIVIAL CENTRE: no homological constraint; the fusion rules alone decide — G₂'s 7 has 7^{⊗3} ∋ 1
(∫χ₇³ = 1, READ), E₈'s 248^{⊗3} ∋ 1 (the structure constants): the leading-order polymers include BRANCHED 2-complexes. The closing-tree count
N(F) ≤ 5^{F−1} of Z₂-minimal sets must be re-derived for Z_N-chains and for fusion-minimal complexes.
(b) SURFACE WEIGHTS. A branch-free closed orientable surface carrying ρ with consistent orientation weighs a_ρ^F d_ρ^{χ(S)} (every link integral
∫χ_ρ(XU)χ_ρ(U⁻¹Y)dU = χ_ρ(XY)/d_ρ; every vertex a trace) — SU(2): u^F2^χ; for self-dual ρ non-orientable surfaces also contribute, with the
Frobenius–Schur sign (Drouffe–Zuber, LITERATURE); for complex ρ (SU(N ≥ 3)) only consistently oriented surfaces at the leading representation.
Leading coefficients (§7.5, PROVED): a_ρ = β(1 + ε_ρ)/(2d_ρ²) + O(β²) — SU(3) β/18 (instrument B 5.55602·10⁻⁵ at 10⁻³), G₂ β/49
(2.04096·10⁻⁵), E₈ β/248².
(c) PROPOSITION X_G (THE CROSSING LAW FOR EVERY G; PROVED). For compact simple G and irreducible ρ with the adjoint appearing once in ρ ⊗ ρ̄,
  ∫∫χ_ρ(xyx⁻¹y⁻¹)χ_adj(x)χ_adj(y)dxdy / ∫∫χ_ρ(xyx⁻¹y⁻¹)dxdy = 1 − h^∨/(2C₂(ρ)).
PROOF. (1) ∫ρ(x)Bρ(x)⁻¹dx = (tr B/d_ρ)·1, so the denominator is (1/d_ρ)∫|χ_ρ|² = 1/d_ρ. (2) By Schur, ∫χ_adj(x)ρ(x)Bρ(x)⁻¹dx = P(B)/d_adj with P
the projector onto the adjoint component of End(V_ρ) ≅ ρ ⊗ ρ̄, P(B) = Σ_aT^a tr(T^aB)/T_ρ (multiplicity one); so the x-integral of the numerator's
integrand is (1/(d_adjT_ρ))Σ_a|tr(T^aρ(y))|² (T^a Hermitian, ρ(y) unitary). (3) Σ_a∫χ_adj(y)|tr(T^aρ(y))|²dy = tr(Φ∘P)/d_adj, where under
End(V) ≅ V ⊗ V̄ the operator Σ_aT^a ⊗ T̄^a is Φ(B) = Σ_aT^aBT^a, which acts on span{T^b} as the scalar C₂(ρ) − ½C_A (the identity
T^aT^bT^a = (C₂(ρ) − ½C_A)T^b); so it equals C₂(ρ) − ½h^∨. (4) The ratio is d_ρ(C₂ − ½h^∨)/(d_adjT_ρ) = 1 − h^∨/(2C₂), by T_ρd_adj = C₂d_ρ. ∎
CHECK: SU(2), ρ = ½: 1 − 2/(2·¾) = −1/3 — the S1 page's ∫χ_½([x,y])χ₁(x)χ₁(y) = −1/6 against ∫χ_½([x,y]) = ½ (READ, line 257). VALUES (instrument A,
exact): SU(3) −1/8; G₂ 0; F₄ 1/4; E₆ 4/13; E₇ 7/19; E₈ 1/2; Sp(2) −1/5; Spin(7) vector 1/6. G₂ IN ITS 7 HAS CROSSING RATIO ZERO: two crossing
adjoint walls on a 7-sheet cancel exactly.
READING: the S1 page's vertex table "is the sl₂ weight system" (READ, line 291); for general G it is the Lie-algebra weight system W_{g,ρ} on chord
diagrams (Bar-Natan 1995, Kontsevich — LITERATURE), whose two-chord crossing ratio is Proposition X_G. For sl₂ the weight system factors through the
intersection graph (the S1 page's (b)); for other g it does not in general (Chmutov–Duzhin–Lando — LITERATURE): the table must be recomputed per group
as a table of chord-diagram weights, not of intersection graphs.
(d) WHAT GENERALISES VERBATIM: the finite family of vertex stars (lattice geometry: simple subgraphs of K_{2,2,2,2} on the eight directions); Lemma R's
realigned operator-norm inequality (block Cauchy–Schwarz); the Kotecký–Preiss tree bound; the gap from clustering (Theorem 7.1). WHAT MUST BE
RECOMPUTED: a_r(β) over Ĝ; the admissible class and its count; the lone-wall constant (SU(2)'s 3a₁; d_adj a_adj at leading order if S7's identity
uses Schur orthogonality alone — to be re-derived); the star integrals r_v with G's intertwiners; Lemma S12_G for branched contact leaves; the
certificate per group.
STATUS: Theorem 8.9 is PROVED-FOR-SU(2)-ONLY (and conditional on S12's remainder); for every other G it is OPEN, with its statement form (polymer
convergence, uniqueness, clustering, gap for β ≤ β*_{8.9}(G), conditional on S12_G), its G-blind parts and its G-dependent inputs as above.

VERDICT ON LINK (3): a strong-coupling gap with an explicit threshold is PROVED for every compact G (S_D: β < 0.0556, G- and ρ-uniform), and
PROVED GIVEN Shen–Zhu–Zhu's argument at the G-universal 't Hooft threshold λ > 96 (S_BE, its two G-inputs computed here and checked against both
of their stated groups); Theorem 8.7 generalises in form with a positive threshold for every G and its numbers are SU(2)-only; Theorem 8.9 is
SU(2)-only, with the general gas's structure (admissibility by the centre or by fusion, surface weights, the crossing law 1 − h^∨/(2C₂(ρ)), the
weight-system vertex table) fixed here.

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

## 8. LINK (5): EUCLIDEAN INVARIANCE (E1), (E2) AND UNIQUENESS, FOR EVERY G

- Proposition E1-a (the bare coupling unique up to the cutoff's shell) and E1-b (the renormalised trajectory converges), M3b §10 / M3c §7.5:
  Gronwall arguments in the coupling with the per-step estimates of Lemma C′ and (PI)_H — G-blind, with c_G, θ₀(G): PROVED GIVEN (PI)_H^multi for
  every G, as for SU(2).
- (E1) in full (the laws of coarse observables converge as K → ∞): the two-cutoff Lipschitz property of LFR I–II's R-operation — G-blind in
  formulation; OPEN for every G.
- (E2), its marginal part: the unique W(B₄)×G-invariant marginal term Σ_{μ<ν}B(F_{μν}, F_{μν}) (§4.6 (ii)) is O(4)-invariant; no θ-term, no
  dimension-five term; O(4) breaking starts at dimension six — PROVED for every simple G.
- (E2) in full: orientation universality, an infrared statement (M3b §11.3) — OPEN for every G; the short-distance form (E2-UV) NAMED, G-blind.
- Uniqueness of the vacuum and (E4): consequences of the gap (Theorem 7.1, Corollary 7.2) — G-blind. (D) is false in finite volume (the free
  field, componentwise in g) and is not needed: Proposition D∞ (gap for fine vectors from Hypothesis I + the averaged fibre clauses) — G-blind.

## 9. THE LINK-BY-LINK TABLE

| link | statement for general compact simple G (G-constants explicit) | status |
|---|---|---|
| UV-a Bałaban's induction (CMP 109 Thms 1, 3; CMP 116; CMP 119; LFR I–II) | effective densities of Bałaban's form, UV-stability bounds, for every semisimple compact G ⊂ U(N), d = 4, couplings ≤ γ_G | PROVED-for-all-G (Bałaban's own statements, READ §0, §4.1) |
| UV-b Theorem 2 (coupling window) | c_G(L) = (11h^∨κ_ρ/(24π²)) ln L, b_G(L) = 17(h^∨κ_ρ)² ln L/(192π⁴), transient F_G; profile (5.1); asymptotic freedom | PROVED GIVEN Bałaban's black box for G (§4.2) — the status SU(2) has; Bałaban stated it for SU(2) only, unpublished |
| UV-c BB4*, Lemma M, M_m, moment form | unchanged; G-dependent E₀, C₁, …, ε_*(G) | PROVED GIVEN CMP 116 Lemmas 1–2, all G (§4.3) |
| UV-d Lemma W (D-term) | 𝒲 ∈ 𝒱(C_W(G)) | PROVED GIVEN the same, all G (§4.4) |
| UV-e Lemma FP | det ratio (1 + d)^{n_T(G)}, n_T = dim ker Q̃ − dim G·#sites | PROVED, every compact G (§4.5) |
| UV-f Lemmas C, C′ | ρ ≤ C_G(ε₁g + g²); ∂_xβ = O(g³), summable | PROVED GIVEN (BB1)–(BB5), W, FP, all G |
| UV-g (S₁) | m_K → 1 + 17λ_K/(88π²) (every G); ONE marginal term (Killing form) | PROVED GIVEN (PI-4)_G, (PI-5)_G (§4.6) |
| UV-h (PI-4), (PI-5) | relative bound |Im A| ≤ C_A(G) Re A + η on G^c; multi-step history decay | OPEN, every G incl. SU(2) |
| R-a reflection positivity | Wilson weight in any unitary ρ has nonnegative character coefficients | PROVED, every compact G (Lemma RP_G) |
| R-b Theorems 7.1, 7.4, Lemma 7.3, Cor. 7.2, 7.5 | verbatim | PROVED, every G (§5.2) |
| R-c Theorem 8.5, Proposition 8.4 | any measurable coarse map | PROVED, every G (§5.3) |
| R-d Theorem 8.5′, M2 Thm 4.1, Prop. D∞, campaign §20 | verbatim (80 = 3⁴ − 1) | PROVED, every G (§5.3) |
| R-e block maps | holonomy (V = G⁴) everywhere; averaged map via Π_G off the null cut locus 𝒞_G; SU(2): 𝒞 = {0}; SU(N ≥ 3): codim-1 jumps by centre elements; Π_G centre-equivariant | PROVED, every G (Lemma P_G) |
| S-a strong-coupling gap, explicit | β < artanh(1/18) = 0.0556, uniform in G and ρ | PROVED, every compact G (Theorem S_D) |
| S-b Bakry–Émery region | λ = h^∨g² > 32(D − 1) = 96 for every G, ρ; β_BE = h^∨κ_ρ/96 (SU(3) 0.1875, G₂ 0.2917, E₈ 2.583) | PROVED GIVEN Shen–Zhu–Zhu's argument (inputs computed; both their groups reproduced) (§6.2) |
| S-c Osterwalder–Seiler's parameter | u_G(β) = e^β/c₀^G(β) − 1 ≤ e^β − 1; = β + O(β²) | PROVED, every G (§6.3) |
| S-d Theorem 8.7 | α_G(β) = 12C_dir + 90C_med with (M_G, σ_G, D_G, T_G) of the matrix-vMF family on G; β*(G) > 0 | form and β* > 0 PROVED all G; NUMBERS PROVED-for-SU(2)-only; constants per G OPEN (§6.4) |
| S-e Theorem 8.9 | gas of G-networks: admissibility by Z(G) or by fusion; weights a_ρ^F d_ρ^χ; crossing 1 − h^∨/(2C₂(ρ)); weight-system vertex table | PROVED-for-SU(2)-only (conditional on S12); OPEN for G ≠ SU(2); crossing law PROVED all G (§6.5) |
| W-a twist identity, vortex recursion | for every z ∈ Z(G) | PROVED, every G; empty for G₂, F₄, E₈ (§7.1) |
| W-b Theorem 3.3_G | R̃ ≤ R ≤ (R̃² + T² + T′²)^{1/2}, Γ = Z(G)⁴; trivial centre: R = R̃; U(1): R̃ = 0 | PROVED, every G (§7.2) |
| W-c Theorem 4.1 ((W-V) from the fibre) | per z, axial gauge, distance-dependent | PROVED as an implication, every G; its fibre-Dobrushin hypothesis false in the window (M4R) |
| W-d Theorem 5.1_G (no-go) | centre-blind ⇒ τ ≡ 0; every action of G₂, F₄, E₈ is centre-blind | PROVED, every G (§7.3) |
| W-e Turán slaving | (a) Schur diagonalisation; (b) on 𝒯_G slaving iff every fundamental weight centre-nontrivial (SU(N)); (c) heat kernel ∈ 𝒯_G; (d) Wilson ∉ 𝒯_G at strong coupling for complex ρ and F₄, E₆, E₇, E₈ | (a), (c), (d) PROVED all G; (b) PROVED; Wilson-in-𝒯 PROVED for SU(2), U(1) only — the OBSTRUCTION exhibited exactly (§7.5) |
| W-f Lemma W_G | (W-V)_z (z ∈ Z(G)∖1) ⊕ (W-S)_G ⇒ Hypothesis I-L² ⇒ gap | implication PROVED all G; (W-S)_G and (W-V)_z OPEN for every G (§7.3) |
| E-a Props. E1-a, E1-b | c_G, θ₀(G) | PROVED GIVEN (PI)_H^multi, all G |
| E-b (E1) full | two-cutoff R-operation | OPEN, every G |
| E-c (E2) marginal part | unique G×W(B₄)-invariant marginal, O(4)-invariant | PROVED, every simple G |
| E-d (E2) full | orientation universality (infrared) | OPEN, every G |
| E-e (D) | false in finite volume; replaced by Prop. D∞ | PROVED, every G |

## 10. THE EXACT OPEN ESTIMATES FOR EVERY G, EACH WITH ITS FALSIFIER

(O1) (W-S)_G AT a_c — THE UNIVERSAL CORE. Σ_{z′} δ_S(y, z′)e^{κ|y−z′|} small enough that, with the vortex sums, the row sum is ≤ α < 1, where
δ_S bounds R̃, the conditional maximal correlation of the (G/Z)-projections; its non-direct part is S^G_ξ(A, B), the outside-mediated
centre-trivial covariance (the 0⁺⁺ across one block). SU(2): the SO(3) channel; SU(3): the triality-zero (PSU(3)) channel; G₂, F₄, E₈: the WHOLE
coarse coupling (= Hypothesis I-L²). FALSIFIERS (two-sided, already in hand): U(1) with any finite label group Z_k — its centre-trivial channel is the
massless charge-k sector, so any proof of (O1) that also applies to U(1)/Z_k ≅ U(1) is wrong; a centre-blind action at a first-order point (M4
Theorem 5.1(b), CONDITIONAL on van Enter–Shlosman for G/Z in d = 4) — (O1) must fail there uniformly; and for SU(N ≥ 5) the Wilson-axis bulk
transition (lattice Monte Carlo, LITERATURE — Campostrini; Lucini–Teper; labelled, not a proof input): a_c data on that line must fail.
(O2) (W-V)_z FOR EACH z ∈ Z(G) ∖ {1}: Σ_{z′} 2 sinh(c_G δ_{V,z}(y, z′))e^{κ|y−z′|} small. Counts: SU(N) N − 1 twists; Sp(N), Spin(2n + 1), E₇ one; E₆
two; Spin(2n) three; G₂, F₄, E₈ none. FALSIFIER: U(1), whose π-flux free energy does not contract (no running) — (W-V) must fail in the Coulomb phase.
(O3) HYPOTHESIS II-L² BELOW a_c — (PI-4)_G: the relative bound |Im A(U)| ≤ C_A(G) Re A(U) + η on LFR II's complexified large-field domain in G^c with
θ₀C_A(G) ≤ ½; FALSIFIER: an additive bound on |Im A| independent of Re A (multiplied by θ₀x_k ~ θ₀/g_k² it cannot be absorbed). (PI-5)_G: the decay
L^{−β(j−i)} of an earlier step's coupling change; FALSIFIER: a marginal remnant of step i surviving its renormalisation.
(O4) THEOREM 8.7_G's FOUR CONSTANTS (M_G, σ_G, D_G, T_G) certified per group; FALSIFIER of the SU(2) pattern ("the MAD is maximal at Haar alone"): a
W ≠ 0 whose MAD exceeds the Haar value — then the per-group threshold is set off Haar.
(O5) LEMMA S12_G AND THE G-GAS CERTIFICATE (only if Theorem 8.9's route is used per group): the contact-leaf activity bound for Z_N-junction leaves
(SU(N ≥ 3)) and for branched fusion-minimal leaves (G₂, F₄, E₈); FALSIFIER: one such leaf whose activity exceeds the Kotecký–Preiss margin.
(O6) THE ONE-SIDED PER-STEP BOUND β_eff(k+1) ≤ β_eff(k) − c_G(2) + δ_k on the true ℤ⁴ blocked action (M4 §1b, CONDITIONAL per M4R), in λ units
Δ(1/λ) ≥ 0.032189 − δ̃_k per doubling, the same for every G; FALSIFIER: U(1) (drift 0) — the bound must refuse it.
(O7) γ_G explicit (with F_G): Bałaban's threshold per group; the window in λ units is [λ_c(G), 96] at the instruments' ends.
(O8) (E1)_G: the two-cutoff Lipschitz property of the R-operation; (E2)_G: orientation universality. FALSIFIER of any claimed (E2) argument: one that
works on the lattice side alone (M3b §11.2: the irrelevance bound does not separate O(4)-breaking from O(4)-invariant terms).
W8's own falsifier ("a group whose window does not close"): no group is known for which (O1) is false; (O1) is the same object for every G.

## 11. CROSS-FIELD UNIFICATIONS FOUND

(U1) BOTH INSTRUMENTED ENDS OF THE WINDOW ARE ONE OBJECT, THE KILLING FORM. b₀ = 11C_A/(48π²) and Ric_G = −¼B are both proportional to h^∨ in the
long-root normalisation; so in λ = h^∨g² the two-loop running (b₁/b₀² = 102/121) and the Bakry–Émery strong-coupling region λ > 32(D − 1) are G- and
ρ-independent, and Shen–Zhu–Zhu's separately stated SO(N) and SU(N) thresholds are the single condition λ > 96. What is group-specific lives only in
the crossover (bulk lines, endpoints) and in non-universal lattice constants (F_G, γ_G, Theorem 8.7's four constants).
(U2) THE CROSSING LAW IS THE LIE-ALGEBRA WEIGHT SYSTEM. The S1 page's −1/3 is the sl₂ value of 1 − h^∨/(2C₂(ρ)), the two-chord ratio of Bar-Natan's
weight system W_{g,ρ} — the object that turns Chern–Simons perturbation theory into Vassiliev invariants. G₂'s 7 has ratio 0, the same
representation whose trivalent vertex (the 3-form, 7^{⊗3} ∋ 1) and skein relations Kuperberg's G₂ spider encodes; the G₂ gas branches exactly where
the G₂ spider has its vertex.
(U3) CONFINEMENT IS NOT THE GAP. The centre route (Tomboulis–Yaffe; M4's vortex half) is a confinement criterion; G₂ — no centre, broken strings,
a gapped glueball spectrum — separates the two, and the chain's every-G form puts the gap in the centre-trivial channel alone.
(U4) THE UNIVERSAL TURÁN-CLASS ACTION IS THE HEAT KERNEL, THE ACTION 2D BLOCKING PRESERVES. Submultiplicativity of κ_λ = e^{−tC₂(λ)} is the
Casimir convexity (λ, μ) ≥ 0 on the dominant cone; the heat kernel is exactly the weight that two-dimensional (Migdal) decimation maps to itself
(K_t ∗ K_s = K_{t+s}); Wilson's weight leaves the class at strong coupling by the Cartan component's share of the tensor square, d²/(2d_{2ω}) — a
representation-theoretic number, not a coupling-dependent one.

## 12. THE PRECISE NEXT OBJECT

(W-S)_G read where it is everything: the trivial-centre group G₂ (no vortex half to hide behind), at two exact blocking steps from its crossover,
on the two-face object with the fine outside INTEGRATED (not pinned), beside SU(2)'s SO(3) channel on the same object — the outside-mediated
centre-trivial covariance S^G_ξ(A, B). Its inputs now in hand: G₂'s one-plaquette law and coefficients a_λ(β) (instrument B: the 7, 14, 27 on
[0, 20], known answers met), its fusion data (7⊗7 = 1 + 7 + 14 + 27, ∫χ₇³ = 1), its crossing ratio 0 and its Bakry–Émery exit β_BE = 0.2917. STAKE
FOR THAT RUN (unguessed in size): the G₂ object's coarse coupling is entirely centre-trivial (R = R̃ by Theorem 3.3_G, exact), so its reading is the
first measurement of the universal core with no vortex share. Then: a proof route for (W-S)_G that uses the running (c_G > 0) and is refused by
U(1)/Z_k ≅ U(1) — the one property the controls leave.

## 13. PRECISIONS, DATED (2026-11-02, after §§0–12 were written; nothing above edited)

13.1 §7.5 (b)'s list "Spin(n) (ω₂, the adjoint)": the adjoint is a fundamental weight of B_n for n ≥ 3 and of D_n for n ≥ 4 (Spin(7) and up);
Spin(5) = Sp(2) is covered by the Sp(N) entry and Spin(6) = SU(4) is in the SU(N) family (all its fundamental weights centre-nontrivial).
13.2 §6.2's Bakry–Émery inequality uses the crude Hessian bound (Σ_k‖ρ(X_k)‖)² ≤ 4Σ‖ρ(X_k)‖²; any sharpening improves the threshold uniformly in G and
keeps it a function of λ alone (both sides scale with T_ρ).
13.3 §6.1 against §6.2: for SU(2) S_BE (β < 1/12) is wider than S_D (0.0556), and both are inside THE GROUND's Theorem 8.7 (0.2452); for large groups
S_BE is far wider in Wilson units (E₈: 2.583 against 0.0556).

13.4 STRENGTH OF §7.4(i)'s ATTRIBUTION, CORRECTED. What is PROVED for U(1) is that Lemma W_G FAILS: if (W-V) and (W-S) both held, Theorem 3.3_G would give Hypothesis I-L², contradicting M2's Theorem 4.1 in the massless range. Attributing the failure to (W-S) ALONE (with a finite label group Z_k) rests on the Coulomb-phase physics of the charge-k sector (power-law correlations of functions of U^k, Fröhlich–Spencer's range) — LITERATURE, not proved here: a covariance bound using R̃ alone is not in hand, and by M4R's repaired converse R̃ conditioned on the full environment is not Hypothesis I-L² of the pushed-forward U(1)/Z_k measure, so M2's Theorem 4.1 does not transfer to the quotient directly. The two-sided control stands: the lemma's form refuses U(1); "fails in both halves" is to be read with this label. Table row W-f unchanged in status (the implication is what is PROVED).

