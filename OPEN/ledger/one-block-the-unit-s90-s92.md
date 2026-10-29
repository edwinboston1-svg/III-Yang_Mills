# ΑΠΕΡΑΝΤΟΝ ledger §74 bis, §83 quater–quinquies, §90–§95 — the one-doubling unit, candidate B's refutation, Fontes's constants re-derived, Σ1b, the fixed-point log lemma, the distance in renormalisation steps

Extracted verbatim from STDLIB/data/paraggelma/project_iii_aperanton_master_plan_after_the_reboot_of_2026_10_27.md on 2026-10-29 06:55 (the desktop seat b10e8d4b). Time labels are this machine's `date +%H:%M` (EDT). The ledger is append-only: §92 quinquies' "8.2 doublings of β" stands as written and is corrected by §95 (≈ 261 renormalisation steps from β ≈ 70).

§83 quater — BAŁABAN FROM THE PAGE (iii-3a, two readings, 05:18; file D4-BALABAN-THE-PAGES.md in that seat's scratchpad). THE
MAP IS EXACT: CMP 109 p. 252, (0.2): "A^ε(U) = Σ_p ε^{d−4}[1 − Re tr U(∂p)], where tr is the normalized trace, i.e. tr 1 = 1",
density exp(−(1/g²)A + …) (0.22): a plaquette weighs exp((1/g²)·½Tr U_p) against our exp(½β Tr U_p), so β = 1/g² and
β_UV = 1/γ², γ the EXISTENTIAL constant of Theorem 3 (p. 267: "There exist positive constants κ₀, M(κ), γ, ε₀, ε₁, α₀, α₁
such, that if κ ≥ κ₀, M ≥ M(κ), 0 < g_k ≤ γ for k = 0, 1, …, K … The constant γ depends on all other constants"), K = log_L(1/ε)
the unit lattice. THE QUANTIFIER IS OVER THE WHOLE SEQUENCE (p. 259: "If the sequence of the effective coupling constants is
contained in an interval ]0, γ] with a sufficiently small positive γ, then the effective actions for small fields are given
by …"); the recursion (0.18)/(0.20) 1/g_k² = 1/g_{k+1}² + β_{k+1}(g_k) is the finite-difference β-function, the coupling growing
toward coarse scales, so the sequence's maximum is g_K at the unit scale and (0.31) pins 1/g_K² = 1/g² there — §83 bis's
coarsest-scale sentence CONFIRMED from the page, the unit lattice's β our β. TWO FACTS: Theorem 2 (pp. 259–260: for
sufficiently small g there exists g₀ = g₀(ε, g) with the sequence in ]0, γ] and g_K = g — the d = 4 statement that the sequence
CAN be kept small) is DEFERRED in CMP 109 ("A proof of this theorem, based on perturbative calculations, will be given in a
separate paper"); LFR I's "Theorem 1 [16]" cites the 3D paper (CMP 102, 1985), so the 4D theorem of record is in LFR II (CMP
122, 355–392), still to be obtained. The distance of record stays [0.2452, β_UV], β_UV = 1/γ², γ existential and uncomputed.

§74 bis — TWO MORE CLAIMANTS AT THE PAGE (iii-3a, 05:18; full text CLAIMANTS-READING-GITTON-ZENODO23001803.md on that seat).
garygitton's repository, Volume II p. 14, Theorem 4.5: "ρ = sup_{k≥0} ρ_k = 0.582 < 1", ρ_k = c_d exp(−c₁β_k), c_d = 3⁸ = 6561 — the
proof evaluates ONLY k = 0 (β₀ ≥ 12.0 from "asymptotic freedom", c₁β₀ ≥ 9.35, ρ₀ ≤ exp(8.789 − 9.35) ≈ 0.5706) and asserts every
scale ("preserved uniformly in L by the convexity of the small-field effective potential and the O'Neill Ricci curvature lower
bound … for all decimation steps k ∈ ℕ. □"); with c₁ = 1.204 the bound needs β_k > 7.3 and the running takes β_k below it toward
the infrared — the uniform contraction is asserted exactly at the crossover and, being group-blind, would give 4D U(1) a
convergent expansion at every scale: fails the U(1) test where asserted. The rest inserts the lattice number 1.552 GeV as a
curvature constant (Vol. V (2.6)) and a cluster-decay rate (Vol. II Thm 7.1); its Lean "mass gap" theorems are 11·C₂ > 0, 66 > 0
and 582 < 1000; its README classes it as a conditional reduction with the gap as premise. Zenodo 23001803: an honest
strong-coupling Kogut–Susskind Hamiltonian gap for SU(2) on open spatial boxes (Thm 2.1 conditional on orders 3–5 for g² ≥
3.6836; unconditional at g² ≥ 3.978 with Δ_L ≥ 1.52κ on recomputed order-2 inputs), its own §0.3 and Prop. 6.2 saying the
continuum path leaves its domain — a sibling of Theorem 8.7 in the Hamiltonian formulation, no crossing claimed.

§90 — ONE DOUBLING AT L = 1 FOR SU(2): THE BOUND AS FAR AS THE TOOLS CARRY IT, AND THE EXACT INEQUALITY AT WHICH IT STOPS
(05:00; the plan's next unit; ae launched 04:56, in its Lean arms). THE CHECKS FIRST. (K1) at β ≤ 0.2452 the scale-1 fibre is in
Dobrushin's regime by Theorem 8.7, so every scale-2 coupling that is a fine covariance decays at the certified rate α^r and the
scale-2 weighted sum is finite for κ < 2 ln(1/α): the one-step bound must close there. (K2) U(1) at 1.2: the fine covariances
decay as r⁻⁴ (the field's), so the scale-2 weighted sum is infinite for every κ > 0: the bound must not close there. THE OBJECT.
Block by 2 and let the scale-2 variables be the block images under a BLOCK-SPIN map (an average over the block's paths —
Bałaban's), not a decimation: under a decimation every direct neighbour keeps its first-order sup coefficient (c·m per fine
plaquette) and no doubling lowers the direct part of the row (candidate A's wall, scale-covariant), so a decimation ladder cannot
contract; under a block-spin map no fine plaquette has two scale-2 variables as sides, so EVERY scale-2 coupling is a quantity
of the fibre (the fine field given the block averages). The scale-2 conditional log-density is log Z(X | rest), Z the fine
integral constrained by the block averages, and δ^{(2)}_{XY} = osc_X of the mixed second difference of log Z — a ratio of four
block partition functions, exactly. ITS TWO PARTS. (i) NON-ADJACENT X, Y: the mixed difference is the log of the ratio of the
joint to the product density of the two block averages given the others — a partial-correlation quantity — and to second order
in the tilts, δ^{(2)}_{XY} ≤ 2β²·sup over coarse data of |Cov_fibre(a_X, a_Y)| + O(β³), a_X the X-part of the action (its
staples, normalized to [−1, 1]). (ii) ADJACENT X, Y: the blocked action carries a nearest-neighbour coarse coupling, first order
in it: δ^{(2)}_{adj} = 4β_eff(2)·(1 + r) with β_eff(2) DEFINED ON ℤ⁴ as ¼ of that mixed oscillation (and READ, on the physical
side, by loop matching c₁(β_eff) = ⟨W_{2×2}⟩: ≈ 0.001 at β = 0.5, 0.013 at 1.0, ≈ 0.6 at 2.2, ≈ 0.12 for two steps from 2.2 by
the area law — the physics of why the crossing is short in blocking steps while the mathematics is not). THE BOUND AS FAR AS IT
CARRIES: Σ_Y e^{κ|X−Y|_2} δ^{(2)}_{XY} ≤ 18e^κ·4β_eff(2)(1 + r) + 2β² Σ_{r≥2} N(r) e^{κr} sup_ω|Cov_fibre(a_X, a_Y)|(r) + O(β³) with
N(r) ≤ 18·(2r − 1)³ the coarse shell counts; the scale-2 Dobrushin criterion needs this below 1/c_MAD = 4 (crude), 3π/2 (MAD, if
the scale-2 law is a vMF tilt in its data, unproved). THE SUP OVER COARSE DATA, SPLIT. Every term above is a sup over the coarse
data ω. On the SMALL-FIELD data (every fine plaquette within angle θ* of the identity, the block's response linear in the data)
the fibre is a Gaussian perturbation and both parts are what they read: β_eff(2) by its definition, the covariances at the
fibre's rate. On the LARGE-FIELD data (some plaquette beyond θ*, the block ordered by its boundary) the block's response is of
order one: δ^{(2)}_{adj}(ω) ≈ 4β and the sup is taken THERE, whatever the typical value — Dobrushin–Shlosman's sup cannot see
that μ_2(LF) is small. THE EXACT INEQUALITY AT WHICH THE ARGUMENT STOPS: the only proved way to let the large-field data enter
with their probability instead of their sup is the polymer expansion of the small-field/large-field decomposition (Bałaban's;
Fontes's one-block constants are the explicit instance), whose convergence needs the Peierls bound N_LF·e^{−β(1 − cos θ*)} < 1
JOINTLY with the small-field expansion's convergence, θ* < θ_c, where θ_c = 0.22 rad is the one-block non-abelian Hessian's
positivity threshold by those constants (κ_eff = λ_min cos θ* − ½θ*‖S‖ > 0, λ_min = 0.6893, ‖S‖ = 6.01). With N_LF = 20 (the
plaquette entropy per site of that bound): β > ln 20/(1 − cos θ_c) = 2.996/0.0241 = 124. THE NUMBER: at the crossover's entry
β = 2.2 the Peierls factor is 20·e^{−2.2(1−cos 0.22)} = 19 — the large-field data are NOT rare at the scale of one block, by a
factor 19 — and to make them rare at 2.2 the small field would have to reach θ* > 1.6 rad (cos θ* < 1 − ln 20/2.2 < 0), a
"small field" that includes plaquettes with ⟨U_p⟩ < 0, where no one-block Hessian is positive. So THE CROSSING'S COORDINATES, in
one line: [0.2452, ≈124] in β, nine doublings of effective coupling; below 124 the large-field set is not rare enough for any
proved expansion at a one-block scale, above 0.2452 the sup criteria are empty; what is proved in between is the running itself
(one loop: 0.26 per doubling at the top, the area law faster below), and the one object that could replace the sup by a
probability — a Dobrushin–Shlosman criterion with the large-field set weighted by its measure — is §81's missing mechanism,
now with its number: it would need to carry a large-field weight of 19 at β = 2.2 on a 2⁴ block, or blocks large enough that
their own large-field probability, e^{−β·(number of forced plaquettes)·0.024}, falls below 1/20 — side ≳ (ln 20/(2.2·0.024))^{1/4}
≈ 2.7 at ONE forced plaquette per block, i.e. a side-3 block IF the ordered response needed a whole block of large plaquettes,
which it does not (one suffices to order a block's boundary response): the honest reading is that no block side helps the sup,
and the large-field data must be carried by their probability, which is the theorem nobody has. K1 re-checked: at β ≤ 0.2452
the large-field split is unnecessary (the fibre is in the sup regime), the bound closes with Theorem 8.7's constants. K2
re-checked: on the Coulomb line part (i)'s covariances are r⁻⁴ and the weighted sum is infinite — the bound refuses U(1).

§90 bis — §90 GRADED BEFORE IT IS SENT: SIX CORRECTIONS, DATED (05:18). (1) K2 WAS THE TWO-SCALE TRAP. §90 changed the
object to a BLOCK-SPIN map and kept the decimation's K2 ("the scale-2 weighted sum is infinite"): under a block average the
scale-2 effective action is LOCAL for U(1) as for SU(2) (its couplings decay exponentially — the locality of an effective action
is not clustering of the measure, §74's own sentence), so the U(1) row at scale 2 is FINITE, and candidate B refuses U(1) at
1.2 by the ADJACENT term alone: on the Coulomb line β_eff(2L) = β_eff(L), so 18e^κ·4β·c_MAD ≥ 18·4·1.2·¼ = 21.6 at every scale —
open forever, the right refusal. The infinite-sum refusal (§87 bis) is the DECIMATION form's, where the integrated massless
field transmits a far link's change as a power (the Poisson kernel): right for §87's construction, wrong for §90's object.
Both forms refuse U(1); the mechanism differs and §90 named the wrong one. (2) THE DECIMATION SENTENCE WITHDRAWN. "Every direct
neighbour keeps its first-order sup coefficient ... no doubling lowers the direct part" is REFUTED by iii-3a's reading (§91): a
bigger integrated object DILUTES the direct bond (0.944 → 0.674 at β = 0.5) and GROWS the second tier; the row grows through the
tier, not the bond. The conclusion that a decimation ladder does not contract stands as a READING at β = 0.3 and 0.5 (§91:
×1.8 and ×2.07 per kept link at the first doubling in the truncated model), not as the theorem §90 implied. (3) THE ANGLE:
"θ* > 1.6 rad" is wrong — 20e^{−2.2(1−cos θ*)} < 1 ⟺ cos θ* < 1 − ln 20/2.2 = −0.362 ⟺ θ* > 1.94 rad (111°); the reading
(plaquettes with negative trace inside the "small field") unchanged. (4) THE SHELL COUNT: N(r) ≤ 18(2r−1)³ is not a bound; the
coarse links at max-norm distance r number at most 4·((2r+1)⁴ − (2r−1)⁴) = 256r³ + 64r ≤ 320r³ for r ≥ 1. (5) THE SYMBOL r in
"4β_eff(2)(1 + r)" was undefined: r := the oscillation of the blocked action's non-Wilson part (higher characters, longer
loops) between two adjacent coarse variables, relative to its Wilson part's 4β_eff — UNREAD, r ≥ 0. (6) PROVENANCE, which §90
omitted and the ledger must carry: the one-block constants are R. Fontes's (ym_v65.tex, the file §74 read, md5 9255166a…):
λ_min = 0.6893 (line 79; Sturm-certified at line 11437 to [0.6893430874, 0.6893430948]), ‖S_block‖ = 6.01 (line 207), κ_eff =
λ_min cos θ* − ½θ*‖S‖ (lines 311–312), the Christoffel correction valid for θ* < 0.22 rad (lines 210, 353, 1270), the entropy 20
in his β₀ = ⌈ln 20/(1 − cos θ*)⌉ (line 306); his rigorous choice θ* = 0.025 gives β₀ = 9587, his "numerical illustration"
θ* = 0.20, β = 150 ("not used in any theorem", line 300) is the SAME formula at 0.20 (ln 20/(1 − cos 0.20) = 150.3), and §90's
124 is it at the validity edge 0.22. So THE NUMBER, labelled exactly: the smallest β at which a Fontes-type small-field /
large-field split's HYPOTHESES hold with his constants is 124 (the Christoffel edge) to 150 (his illustration) to 9587 (his
choice) — the scale where that split could BEGIN; its clustering step is the one §74 found broken, so this is a floor on the
method's start, not a point where anything is proved. The typical-plaquette scale (⟨1 − ½tr U_p⟩ ≈ 3/(4β)): θ_typ ≤ 0.22
needs β ≥ 3/(2·0.22²) = 31. THE CROSSING'S COORDINATES, corrected: [0.2452, β_SF] with β_SF ∈ [31, 150] by the only explicit
one-block constants in print, Bałaban's γ unknown (§83 quater), and the sup metric growing ×1.8–2.1 per doubling at 0.3–0.5
(§91).

§91 — CANDIDATE B's KILL EXPERIMENT READ AT 0.5 AND 0.3, AND n_B ANSWERED (iii-3a's evaluator, g14 reproduced to six digits;
the symmetric datum, the full 48-design, the truncated weight; records rows_0.3.out, rows_0.5.out, cube_rows.py on that seat;
05:18). β = 0.5 (a₁ = 0.123718). THE ONE-BLOCK ROW AT SCALE 2: Δ_cube(u, u′) for the vertical under b0 against the cube's 87 other
data links sums to 6.8077 unweighted (max 0.6738; by max-norm distance d = 0.5: 6 links, 2.649; d = 1: 35, 4.016; d = 1.5: 30,
0.109; d = 2: 12, 0.027; d = 2.5: 4, 0.006), weighted Σe^{κd}Δ = 7.391 / 8.374 / 10.350 at κ = 0.1 / 0.25 / 0.5. THE SINGLE-LINK
ROW AT SCALE 1 under the same weight (one integrated link, 17 other data links): 4.3623 (0.943932 twice — the two data links in
u's own plaquette — and 0.164961 for the 15 in the other five plaquettes), weighted 4.744 / 5.388 / 6.685. PER INTEGRATED
OBJECT THE SCALE-2 ROW IS 1.56× THE SCALE-1 ROW at every weight: the block DILUTES the same-plaquette bond (0.674 vs 0.944) and
its second tier (0.432 ×2 for the two links sharing TWO integrated links with u; 0.219 ×4 and 0.218 ×2) is stronger and more
populous than the link's 0.165 — the excess lives in the tier; the d ≥ 1.5 tail is 2 % of the row. β = 0.3 (a₁ = 0.074720): cube
2.5888 (max 0.258181; d = 0.5: 1.026; d = 1: 1.544; d = 1.5: 0.0148; d = 2: 0.0037; d = 2.5: 0.0008), weighted 2.807 / 3.174 /
3.907; link 1.9043 (0.397598 ×2, 0.073940 ×15), weighted 2.071 / 2.353 / 2.921; RATIO 1.359 (1.355 / 1.349 / 1.337). THE
MECHANISM READ: every entry is SECOND ORDER in a₁ at leading order — a pair of data links couples through one integrated link
by the two-plaquette even set, weight (2a₁)²·½tr(…) — so both rows are a₁² × [341 → 285] (link, 0.3 → 0.5) and a₁² × [464 → 445]
(cube): the ratio tends to ≈ 1.3–1.36 as β → 0 and rises to 1.56 at 0.5. PER INTEGRATED UNIT THE SCALE-2 ROW NEVER CONTRACTS
AT ANY STRONG COUPLING READ. n_B, ANSWERED EXACTLY: in §87's construction (the kept coarse links of the period-2 perfect
decimation of the 2-blocked lattice) the integrated set is ONE CONNECTED GRAPH — the off-line fine links contain the whole
lines {(x + ê_μ + ê_ν + kê_ρ, ρ) : k ∈ ℤ} through every doubly-odd vertex; 61 of the 64 fine degrees of freedom per 2⁴ block are
integrated and 3 coarse products kept — so the scale-2 row of a kept variable is a sum over ALL kept variables and no count of
disjoint blocks exists; the first shell of a kept coarse link holds 24 integrated-link incidences in its two halves' 12 fine
plaquettes against 6 at scale 1. In the plan seat's block picture (2⁴ cubes; a coarse link of ℤ⁴ borders 8), n_B = 8, and the
proxy row of one kept link at scale 2 is 8 × (6.808; 7.391 / 8.374 / 10.350) = 54.5 (59.1 / 67.0 / 82.8) against the scale-1 row
6 × (4.362; 4.744 / 5.388 / 6.685) = 26.2 (28.5 / 32.3 / 40.1) at 0.5, and 8 × 2.589 = 20.7 against 6 × 1.904 = 11.4 at 0.3: THE
FIRST DOUBLING MULTIPLIES THE ROW BY 2.08 / 2.07 / 2.07 / 2.07 at 0.5 and 1.81 at 0.3 — an overcount of pairs shared by two
cubes, a truncated weight, the symmetric datum where δ is a sup — and nothing in the reading points the other way; even
n_B = 4 (the cubes a kept link's own plaquettes enter) gives ×1.04 at 0.5 and ×0.91 at 0.3, no contraction. VERDICT: candidate
B's contraction claim is REFUTED at the first doubling at 0.3 and 0.5 as a reading (law 18: the prediction corrected, not the
experiment); its content moves where the plan seat put it — the RG step lives in an AVERAGED metric (the face response falls
from 1.0 to 2.2; §84), the sup metric grows, and the theorem to find is the one that makes an averaged contraction imply decay
(the crossing page §2(B)), now with two numbers on the wall: ×1.8–2.1 per doubling for the sup at 0.3–0.5, and β_SF ∈ [31, 150]
for the only explicit small-field split (§90 bis (6)). Open line (iii-3a): the cross-plaquette entry 0.164961 against iii-38's
Δ_link = 0.163334 (1 %) — which pair and which weight define Δ_link is iii-38's to say.

§91 bis — ONE CELL OF §91 MIS-STATED (05:19): at n_B = 4 the proxy reads ×1.04 at 0.5 and ×0.91 at 0.3 — the second IS a (marginal) contraction, so "no contraction" is wrong for that cell; and n_B = 4 is not the count (the row reaches the second shell through the other four cubes a coarse link borders), so the 8-cube proxy is the one of record: ×2.07 at 0.5, ×1.81 at 0.3.

§90 ter — iii-3a's THREE CHECKS ON §90 ACCEPTED (05:31). (0) "block partition functions" → FIBRE partition functions of the
whole lattice given ω; the fibre does not factorise over blocks under a block average (the straddling fine plaquettes couple
neighbouring fibres), so the one-block form (the cube rows) is the proxy whose error is the inter-block fibre coupling — exact
only where the integrated set splits into single links (the perfect cover). (1) K1 FOR THE BLOCK FORM IS THE ONE-LINK DISK: at
L = 1 the block average is the identity, δ^{(1)} is Wilson's, and the bound reads 18·4β_eff(1) < 4 ⟺ β < 1/9 (crude) or
18·4β/(3π) < 1 ⟺ β < 3π/72 = 0.131 (MAD) — not 0.2452, which is the DECIMATED variable's number (the kept links of the perfect
cover with their vMF structure), the known case of §87's form, not of §90's. (2) K2 UNDER THE SUP IS PASSED VACUOUSLY: the sup
over data pins β_eff(2) near β for EVERY group (the large-field data, where δ_adj ≈ 4β), so 18·4β_eff(2) ≈ 158 at 2.2 refuses
SU(2) as it refuses U(1); the groups part only in the measure-weighted (small-field) regime, where the U(1) half is the Gaussian
fact and the SU(2) half (β_eff runs under block averaging) is unproved — the stopping inequality again. (3) "sup δ^{(2)} = sup
over boundary data of a block quantity" is exact for decoupled fibres and a proxy for block averages, its error not small at the
crossover (Δ_cube/Δ_link = 0.036–0.041 speaks of strong coupling only). So THE COORDINATES BY FORM: the decimation form
[0.2452, ·] with no contraction available (§91); the block form [0.131, β_SF]. Famous-open: none raised.

§83 quinquies — LFR II READ: BAŁABAN'S 4D THEOREM OF RECORD IS CONDITIONAL, BY ITS AUTHOR'S WORDS (iii-3a, 05:31; CMP 122 (1989)
355–392, p. 355 verbatim): "Theorem 1. If the sequence of the effective coupling constants is contained in an interval ]0, γ]
with a sufficiently small positive γ, then the effective densities ρ_k have the form, and satisfy all the conditions and
bounds, described in Sect. 2 [III]." And: "This is the main result of the whole sequence of papers of the present author on
non-Abelian gauge field theories. Theorem 2 of [I] allows us to remove the assumption on the effective coupling constants in
the above theorem, because this assumption follows from the basic inequality (0.31) [II], which is the result of Theorem 2. The
proof of Theorem 2, which is based on second order perturbative calculations, is very awkward and long in the context of the
renormalization group approach to lattice gauge field theories, and has not been published yet, so we have Theorem 1 with the
assumption." The stability bound (0.1): χ_k exp[−(1/g_k²)A(U_k) − E₋|T_η|] ≤ ρ_k ≤ exp E₊|T_η|, E± independent of k. Bibliography
[I]–[IV] only. CONSEQUENCE FOR Σ1: the UV half of record is "stability under the sequence hypothesis 0 < g_k ≤ γ for all k";
the asymptotic-freedom statement that discharges it is unproved in print as of 1989; β_UV = 1/γ² stays a named unknown and
every citation of the 4D result as unconditional is unsupported by his pages. AND NO LATER PROOF EXISTS (iii-3a, two
searches): zbMATH's author listing for T. Bałaban 1989–2022 — the fermion block RG (1989), the two Large field renormalization
papers (1989), the classical N-vector series (1995–99), Localization expansions (1996, 1998), the bosonic many-body series with
Feldman–Knörrer–Trubowitz (2008–2022) — holds NO four-dimensional gauge theory paper after 1989; CMP 109's Theorem 2 (the (0.31)
bound) was announced in 1987, called "not published yet" in 1989, and is absent from the author's complete record. So Σ1's UV
end reads: ULTRAVIOLET STABILITY IN d = 4 UNDER THE HYPOTHESIS 0 < g_k ≤ γ AT EVERY SCALE, the hypothesis's discharge never
published; β_UV = 1/γ² sits inside that conditional. The other UV-half reference to read beside it: Magnen–Rivasseau–Sénéor,
"Construction of YM₄ with an infrared cutoff", CMP 155 (1993) 325–383, a phase-space expansion whose completeness the
literature disputes. The plan's Σ1 row ("CITED Bałaban") carries this clause from now on.

§92 — FONTES'S ONE-BLOCK CONSTANTS RE-DERIVED, TWO ROADS, AND THE CORRECTED FLOOR (05:31; the operator's order: "if they do
work ... bolster the proof that they do work and why"; instruments fontes_hessian.awk and fontes_peierls.awk in this seat's
scratchpad, outputs fontes_hessian.out / fontes_peierls.out; iii-3a's blind reading of his definitions, lines 901–963,
1210–1240, 3150–3172, 5580–5588, 6103–6124, arrived after my numbers). (1) HIS 72-PLAQUETTE HESSIAN REPRODUCED EXACTLY: base
vertices in {0,1,2}⁴, 72 plaquettes, trace 144, spectrum 0 ×1, 0.689343 ×3, 1.000000 ×1, 1.425172 ×3, 1.458619 ×2, 2.000000 ×1,
2.223571 ×3, 3.000000 ×1, 5.271914 ×3, 5.381966 ×3, 7.541381 ×2, 7.565775 ×3, 7.618034 ×3, 9.824225 ×3 — his table to every
digit. (2) AND IT IS AN ASYMMETRIC TRUNCATION: the diagonal census reads 3/4/5/6 for 4/12/12/4 edges, i.e. an edge gets 0, 1, 2
or 3 external plaquettes according to how many of its other coordinates are 1 — his enumeration starts the base vertex at 0
and so omits the 48 external plaquettes on the negative sides. The FULL set of plaquettes meeting the block (base in
{−1,0,1,2}⁴) has 120 members, EVERY one containing a block edge (24·4 + 96·1 = 192 = 32·6 incidences; his remark that the 120
include plaquettes "with no interior edges" is false), and its Hessian is ∂_facesᵀ∂_faces + 3I with spectrum 3 ×15, 7 ×6, 9 ×8,
11 ×3 EXACTLY — (H−3)(H−7)(H−9)(H−11) = 0 in integer arithmetic, tr H / H² / H³ = 192 / 1440 / 12288 fixing the multiplicities
— so λ_min = 3 and NO ZERO MODE: the frozen boundary fixes the gauge (his one zero mode, the gradient at the origin, exists
only because his set gives the origin's four edges no external plaquette). His own remark reports the 120-set's 3.0 and calls
72 "the correct count"; the 72 is the artefact, the 3 the block's gap. (3) ‖S_block‖ REPRODUCED: 24 faces, tr(SᵀS) = 288,
‖S‖² = 35.522651, ‖S‖ = 5.960088 (his [35.52, 35.53], 5.9592–5.9609). (4) THE CHRISTOFFEL EDGE: λ cos θ − θ·6.01/2 = 0 at
θ_c = 0.2237 with his λ (his 0.22) and at θ_c = 0.7383 with λ = 3; his form is proved for a UNIFORM background in one direction
(Δ_Chr = βθ₀·½(J₃ ⊗ S)); a general small field needs ‖Σ_p (Θ₀(p)·J) ⊗ S_p‖, which his text does not bound — a named gap, (a).
(5) THE ENTROPY: c_conn = 20 edge-adjacent plaquettes is right (4 edges × 5); his Peierls proof then writes "(e c_conn)^{k−1} ≤
20^k", which FAILS at k = 4 (54.4³ = 160,990 > 20⁴ = 160,000) and ever after: the tree-graph inequality he cites gives the
growth rate e·c_conn = 54.4 per plaquette (e(c−1) = 51.6 in its sharper form), not 20. (6) THE CHESSBOARD BOUND IS FALSE AS
STATED: his eq. (chess) μ(θ_p > θ*) ≤ e^{−β(1 − cos θ*)} compares the integrand's maximum on the defect set with its maximum at
the identity, a ratio of maxima, not of integrals; the exact single-plaquette marginal μ₁ = ∫_{θ*}^π e^{β cos}sin² / ∫_0^π
e^{β cos}sin² (Simpson, 40,000 panels) EXCEEDS it by 2.24× at his (9587, 0.025) (0.1120 vs 0.0500), 2.43× at (150, 0.2237), 2.23×
at (150, 0.20), 2.62× at (20, 0.7383) — the sin²θ measure and the β^{3/2} normalisation. CONSEQUENCE: HIS PEIERLS CONDITION
FAILS AT HIS OWN PARAMETERS — 20·μ₁ = 2.24 > 1 at (9587, 0.025) with his entropy, 54.4·μ₁ = 6.09 with the tree-graph entropy;
at (150, 0.2237): 1.16 and 3.15. His rigorous threshold 9587 is not self-consistent; under his own structure with the correct
μ₁ and entropy, θ* = 0.025 needs β ≈ 16,000. (7) THE CORRECTED FLOOR, CONDITIONAL: at θ_c = 0.7383 (λ = 3) the Peierls
condition 54.4·μ₁(β, θ_c) < 1 holds for β ≥ 18.96 and the KP activity z = C₀θ_c²/(λβ) < 0.1 (his own threshold, read off his
margin 26× at z = 0.004) for β ≥ 19.38 — β_SF ≈ 19.4, conditional on (a) the Christoffel form for a non-uniform small field,
(b) his KP threshold, (c) the single-plaquette marginal as the per-defect factor (the optimistic chessboard constant; the
exact one is larger). (8) WHAT THIS IS AND IS NOT. As printed his constants DO NOT WORK: one is an artefact that undersells
the block (0.6893 for 3), two oversell the Peierls side (the entropy 20 for 54.4; a chessboard bound 2.2–2.6× too strong),
and the net is that his β₀ fails its own condition. Corrected, the one-block small-field/large-field split's HYPOTHESES hold
from β ≈ 20 under (a)–(c), each a theorem still to write — the scale at which a Bałaban-type small-field analysis would have
a verified foothold, 6.3 doublings above 0.2452 — and that is all: no gap follows (the clustering inference §74 found broken is
untouched), and it is not Bałaban's γ, whose theorem is conditional on the WHOLE sequence (§83 quinquies). The coordinates by
explicit constants: [0.2452, ≈20] for the decimation form's sup end against the corrected one-block floor; [0.131, ≈20] for the
block form (§90 ter). THE CLOCK CHECK (the plan seat's rule): every label in §87–§92 is `date +%H:%M` of this machine (04:43,
04:45, 04:48, 04:55, 05:00, 05:18, 05:3x), and the Supabase instant of HEAD 7ff34274e (09:04:18Z = 05:04 EDT) agrees with them.

§92 bis — THE NON-UNIFORM CHRISTOFFEL CONSTANT, AND THE FLOOR AS AN INTERVAL (05:35; fontes_christoffel.awk, output
fontes_christoffel.out, this seat's scratchpad). Condition (a) of §92 made a number. For a small field with free directions
n̂_p the correction is (β/2)Σ_p θ_p([n̂_p]_× ⊗ S_p); its quadratic form at a unit x ∈ ℝ⁹⁶ is (β/2)Σ_p θ_p n̂_p·w_p(x) with
w_p(x) = Σ_{ℓℓ'} S_p[ℓℓ'](x_ℓ' × x_ℓ), so ‖Δ_Chr‖/β ≤ (θ*/2)·M with M := sup_{|x|=1} Σ_p |w_p(x)|. THE RIGOROUS CRUDE BOUND:
|w_p(x)| ≤ 2Σ_{ℓ<ℓ'}|S_p[ℓℓ']||x_ℓ||x_ℓ'|, and summed over the faces the pairs sharing a face give |x|ᵀA|x| ≤ λ_max(A) = 9, A the
face-sharing adjacency of the 32 edges (9-regular, checked): M ≤ 9. THE UNIFORM CASE is the lower bound M ≥ ‖S‖ = 5.9601
(his constant). THE READING: gradient ascent on the sphere, 60 random restarts × 400 steps, finds M ≥ 6.2595 — a general
small field costs at least 5 % more than the uniform one and at most 51 %. THE FLOORS (the Christoffel edge 3 cos θ = (M/2)θ;
the Peierls condition 54.4·μ₁(β, θ_c) < 1; the KP activity C₀θ_c²/(3β) < 0.1): M = 5.9601 → θ_c = 0.7420 rad, floors 18.8 /
19.6; M = 6.2595 → θ_c = 0.7204, 19.9 / 18.5; M = 9 → θ_c = 0.5636, 32.1 / 11.3. So β_SF ∈ [20, 32] by the constants of
record: 32 RIGOROUS in (a) (the crude Christoffel bound is a theorem, two lines above) and conditional on (b) his KP
threshold and (c) the chessboard constant; 20 if the sharp M is near its reading. THE COORDINATES: [0.2452, 32] with (b) and
(c) outstanding — 7.0 doublings of β; the sup metric grows ×1.8–2.1 per doubling at the bottom (§91); no gap at the top (§74).

§91 ter — iii-38 ON THE RECORD (05:37): Δ_link = 0.163334 at β = 0.5 is the same object as iii-3a's 0.164961 (the truncated weight w = 1 + 2a₁χ_½, two staples in different plaquettes moved, four at 1, F(g,g′) = −log ∫ w(U)⁴ w(Ug) w(Ug′) dU, Δ = max over g′ of the oscillation over the 48-design of F(g,g′) − F(g,1)); his g′ ran over EIGHT design elements against all 48, the 1 % the subset's deficit on the sup. THE WORST CASE OF THE QUOTIENT CRITERION MEASURED: at the cancelling datum one un-cancelling change moves E[tr U_top] by 0.648992 — 11× the symmetric near response, the stake [0.15, 0.45] exceeded — so the worst-case block form is DEAD at 2.2 in the spins-≤-1 model; the survivor is the small/large-field split with the measure's weight of the frustrated data as its first constant. g31_cube_pair.pl (exact plaquette-pair correlations on the cube with positive boundary fields, the Griffiths decider, KATs met) runs next at 2.2/1.0/0.5; run y RED by his own in-flight edit, run z launched 05:23.

§92 ter — THE SECOND STANDING FALSIFIER, AND THIS UNIT UNDER IT (the plan seat, 05:37): beside the U(1) test, THE FREE MASSLESS GAUSSIAN FIELD — two coupled free fields with boundary data differing at one site differ by a harmonic extension of order r⁻² that never vanishes, every actual (averaged) per-site total variation along the coupling is small, there is no frustration, and the correlations are algebraic; so any criterion in which paths pay a product of ACTUAL per-site influences certifies the massless field and is false (van den Berg–Maes is a theorem only because its disagreement probability is the SUPREMUM over neighbour data, of order one there — the supremum the frustrated datum killed at the crossover). Partial frustration (one plaquette with tr U_p ≤ 0) has probability near 0.1 at β = 2.2 for either group, so "frustrated rare" needs its threshold. Every candidate from here states, beside its U(1) line, what it reads for the free massless field. THIS UNIT: the one-block small-field expansion converges for the free field exactly as for SU(2) (the same Gaussian block Hessian, no Christoffel term), so β_SF certifies nothing about decay — it is where a Bałaban-type analysis has a verified foothold, and the two-scale trap (§74) is why convergence is not a gap; §90's sup criterion reads order one per site on the free field and certifies nothing. What survives the two falsifiers is the reading in which the site is a block at a scale inside Theorem 8.7's disk, where the sup criterion closes by itself: the renormalisation step.

§92 quater — §92/§92 bis CHECKED BY HAND BY iii-3a, THE CONVENTION STATED, AND (c)'s SMALL-BALL ROAD REFUTED (05:46). HOLDS,
independent of the instruments: (i) the 120 (32 × 6 = 192 incidences = 24 × 4 + 96 × 1; two block edges share a plaquette only
in a face); (ii) the 72 (for an edge (v, μ) and each ν ≠ μ one of the two (μν)-plaquettes is a face and the other external,
external on the + side iff v_ν = 1 — base in {0,1,2}⁴ keeps k externals for an edge with k ones among its other coordinates,
diagonal 3 + k, multiplicities 4 × (1,3,3,1), the origin's four edges keeping none: his single zero mode); (iii) H_full =
facesᵀfaces + 3I; (iv) THE SPECTRUM BY THE HODGE DECOMPOSITION of the tesseract (interval Laplacians 0, 2 on vertices, 2 on
edges): ker d₁ = im d₀ fifteen-dimensional; Δ₂ on 2-forms at 4, 6, 8 with multiplicities 6, 12, 6; the exact 2-forms (dim 7) at
6 ×4 and 8 ×3; the coexact 2-forms — the nonzero spectrum of facesᵀfaces — at 4 ×6, 6 ×8, 8 ×3; plus 3I: 3 ×15, 7 ×6, 9 ×8,
11 ×3, trace 192: the exact computation and the Hodge count agree to the last multiplicity; (v) (e·20)^{k−1} against 20^k
fails first at k = 4; (vi) the marginal by Laplace with s = βθ*²: μ₁/e^{−β(1−cos θ*)} = [√s e^{−s/2} + √(π/2) erfc(√(s/2))] /
(√(π/2) e^{−s/2}) = 2.24 at s = 5.99 — my 2.24 from a different road; (vii) M ≤ 9 holds for the ORDERED-PAIR convention
(w_p sums over ordered pairs with the antisymmetric S_p, so Σ_p|w_p(x)| ≤ |x|ᵀA|x| ≤ 9|x|² with A the 9-regular face-sharing
adjacency), the same convention in which ‖S‖ = 5.96 and the reading 6.26 were taken — an unordered convention would read
4.5 and move β_SF; stated here beside the 9. THE LINE NOT SIGNED, in (c): "(Z_defect-everywhere/Z)^{1/N_p}" — under
coordinate reflections a (μν)-plaquette event reflects to a (μν)-plaquette event, so the chessboard estimate's "everywhere"
is all plaquettes of ONE ORIENTATION CLASS, exponent 6/N_p, and a contour of mixed orientations pays ∏_{μν} z_{μν}^{|S_{μν}|}.
THE SMALL-BALL ROAD FOR THE CHESSBOARD CONSTANT IS REFUTED: constraining N of the 6N plaquettes while Z keeps every link
free, Z ≥ e^{6βN cos ε}v^{4N} (v the Haar ball of radius ε/4) gives per plaquette e^{−β(1−cos θ*)}·e^{6β(1−cos ε)}·v⁻⁴ ~ ε⁻¹²,
optimised at ε² = 2/β a prefactor of order 10⁹β⁶ (10⁷β^{4.5} with a maximal-tree gauge fixing) — 10¹⁴ at β = 32 — on which
the Peierls condition cannot close at any β. The chessboard constant needs a GAUSSIAN lower bound on Z (Jensen against a
Gaussian reference on gauge-fixed links, cut off on the compact group), where the prefactor becomes a low power of βθ*², as
the marginal's 2.24 suggests. (c) IS iii-3a's, in the form: (α) μ₁(β, θ*) ≤ ρ_{μν}(β, θ*) := (Z[all (μν)-plaquettes with
θ_p > θ*]/Z)^{1/N_{μν}} — the marginal a LOWER bound on the chessboard factor by the estimate itself at |S| = 1; (β) ρ_{μν} ≤
e^{−β(1−cos θ*)}·K(β, θ*) with K explicit, the pointwise weight bound above and a Gaussian-domination lower bound on Z below;
(γ) the corrected floor from 54.4·ρ_{μν} < 1. Until it lands the coordinate [0.2452, 32] carries "(c) owed, the small-ball
road refuted". B4 MEANWHILE: VmfBounds.lean drafted (22 theorems: the four coefficient sequences' closed forms and signs —
turan, lower, upper, perp — the four translations to the bounds on m given the recurrence r(I₁ − I₃) = 4I₂, the Riccati
identity's algebra, the third-cumulant bound from (P), (V), (D)); compiles the minute ae releases the slot.

§92 quinquies — (b) READ FROM HIS OWN TABLE, AND THE FLOOR CORRECTED: β_SF ≈ 70, NOT [20, 32] (05:49; law 18 on my own §92
bis). His Kotecký–Preiss condition is in his margin table (ym_v65.tex line 357): "KP condition c_d z e² < 1", c_d = 18 the
link–plaquette adjacency (line 4313, 5587: 6 plaquettes × 3 other links), z = C₀θ*²/(βλ_min) the per-link activity — at his
(9587, 0.025, 0.6893) it reads 1.342 × 10⁻⁴ against his table's 1.33 × 10⁻⁴, so this is the criterion. My §92 bis took the
threshold as z < 0.1 "read off his 26× margin" — a misreading by 13×: the threshold is z < 1/(18e²) = 0.00752, and AS A
THEOREM (the standard sufficient condition Σ_{X∋ℓ}|ζ(X)|e^{|X|} ≤ 1 with |ζ(X)| ≤ z^{|X|} and at most (e·c_d)^{n−1} connected
link sets of size n through ℓ: e·z/(1 − e²c_d z) ≤ 1) z ≤ 1/(e + e²c_d) = 0.00737, within 2 %. So the KP floor is
β > 18e²C₀θ*²/λ_min = 473θ*² at λ_min = 3 — RISING in θ* where the Peierls floor FALLS — and the corrected one-block floor
is the balance: minimise max(Peierls(θ*), 473θ*²) over θ* below the Christoffel edge 0.5636 (M = 9): Peierls 250.9 / 111.9 /
69.9 / 40.7 / 32.5 and KP 18.9 / 42.6 / 68.3 / 118.2 / 148.3 at θ* = 0.20 / 0.30 / 0.38 / 0.50 / 0.56 — THE FLOOR IS β_SF = 69.9 AT
θ* = 0.38 (instrument /tmp/kp_floor.awk, the quadrature of fontes_peierls; its text in this seat's scratchpad as
kp_floor.awk). §92 bis's "19.4" and "[20, 32]" took the KP floor at a wrong threshold and read it as non-binding; it binds.
THE CONDITIONS NOW: (a) the Christoffel bound RIGOROUS (M ≤ 9, θ* = 0.38 < 0.5636); (b) his activity bound |ζ(X)| ≤
(C₀θ*²/(βλ_min))^{|X|}·e^{−(βλ/4)δ(X)} with C₀ = 32/3 TAKEN AS STATED (lem:activity, lines 5199–5234: the cumulant expansion
with the parity cancellation of the cubic vertex — unverified here) and the KP threshold from it a theorem (above); (c) the
chessboard constant, iii-3a's, the marginal its lower bound. THE COORDINATES, corrected: [0.2452, ≈70] — 8.2 doublings of β —
with (b)'s activity bound and (c) outstanding; Fontes's own 9587 at θ* = 0.025 fails his Peierls condition by 2.24× (§92 (6)),
and at his θ* the corrected floor would be ≈ 16,000, so the whole gain is the block's true gap (3 for 0.6893, a factor 4.35 in
z) and the free choice of θ* — both his, used right.

§92 sexies — (b) READ AT ITS PROOF: THE ACTIVITY BOUND IS ASYMPTOTIC, NOT A BOUND (05:50; ym_v65.tex lines 5236–5340). His Lemma (Activity bound) is proved in O-notation: the first cumulant "O(g²) per link (parity kills the cubic, leaving quartic at O(1/β))", the second "O(θ*²/(βλ³))", the remainder R₃ "O(g⁶) per link" with an explicit factor e^{O(βθ*)} = e^{O(β^{1/2})} declared "absorbed because g⁶/g⁴ = g² decays faster", the off-diagonal propagator by a Combes–Thomas estimate (1.451/β)e^{−γd}, γ ≥ 0.81; the total "z ≤ C₀θ*²/(βλ_min) + O(1/β^{3/2})" with C₀ = 32/3 said to dominate two sampled vertex terms. No constant in any O(·) is named, and the remainder exponent at the corrected floor is βθ* = 70 × 0.38 = 27 — nothing there is small. So (b) stands as: the KP threshold from a per-link activity z is a theorem (§92 quinquies), the activity bound z = C₀θ*²/(βλ_min) is an ASYMPTOTIC STATEMENT at β → ∞ with every remainder unquantified; at β ≈ 70 it is a conjecture about the block, and the floor ≈ 70 is conditional on it in that strong sense (the remainder could move it far up). THE ANSWER TO THE OPERATOR'S QUESTION, whole: as printed the constants do not work (§92 (6): his own β₀ fails his own Peierls condition); corrected and used right, the one-block split's hypotheses are met at β ≈ 70 PROVIDED the activity bound's remainder and the chessboard constant are quantified — two theorems nobody has written, (c) in iii-3a's hands, (b) a cumulant expansion with constants, days of work; and none of it is a gap (§74). What was done that predecessors had not: the block's true spectrum, the two defects with numbers, the floor as a function of θ* with its balance point.

§92 septies — BOTH CONDITIONS BIND AT θ* = 0.38 (the plan seat, 05:52): the Peierls side of the balance is the one-plaquette marginal μ₁(β, θ*), the OPTIMISTIC reading of the chessboard factor (§92 quater: μ₁ ≤ ρ_μν), so "≈ 70" rests on (c) in BOTH floors, not only in the large-field weight; and at θ* = 0.38 rad the quadratic model's error constant C₀ = 32/3 is used at a plaquette angle fifteen times his 0.025 — (b)'s activity bound as stated must hold at that angle, which §92 sexies found asserted asymptotically and nowhere quantified. The coordinate [0.2452, ≈70] carries both: "(b) at θ* = 0.38 and (c) in both floors outstanding".

§93 — THE STATUS COLUMN CHANGES, THE FACT DOES NOT: BAŁABAN'S THEOREM 2 IS BUILD Σ1b, OURS (06:03; the operator: "The 4D
gauge paper IS THE PROOF WE'RE MAKING"). The fact of §83 quinquies stands at its strength: LFR II's Theorem 1 (CMP 122, p. 355)
is ultraviolet stability under the hypothesis 0 < g_k ≤ γ at every scale, and the hypothesis's discharge, CMP 109's Theorem 2,
was announced in 1987, called "not published yet" in 1989, and is absent from the author's record. What was wrong was the
column it sat in: not a defect of the citation chain to report, but a theorem of the chain we are writing. Σ1 SPLITS: Σ1a
Bałaban's Theorem 1, CITED (stability under the sequence hypothesis); Σ1b THEOREM 2, OURS; Σ1c γ EXPLICIT, OURS (the coupling
at which the ultraviolet half hands over to Σ2 — β_UV = 1/γ² stops being a named unknown and becomes a number this build
produces). Σ1b IN TWO HALVES. (1) THE EASY HALF — Theorem 2 ⟸ (0.31): with x_k = 1/g_k² and the per-step shift b_{k+1} in
[c₁, c₂], c₁ > 0, whenever the history stays ≥ 1/γ², truncate b outside that region (every argument replaced by its max with
1/γ²); the truncated flow is continuous in x₀ and decreases by c₁ to c₂ per step, so the intermediate value theorem on
x₀ ∈ [X + Kc₁, X + Kc₂] gives x_K = X = 1/g²; monotonicity puts every x_j ≥ X ≥ 1/γ², where the truncation is inactive, so the
true flow equals it — and 1/g₀² ≥ 1/g² + Kc₁, the bare coupling vanishing as the cutoff goes: ASYMPTOTIC FREEDOM is the
conclusion's second clause. The shift depends on the whole effective action, not on g_k alone, so the lemma is stated with
history dependence (b_{k+1} a continuous function of the sequence, bounded where every entry is ≥ 1/γ² — implied by Bałaban's
causal form); kernel draft LEAN/aperanton/Aperanton/CouplingSequence.lean, compiled when ae releases the slot (after
VmfBounds). (2) THE HARD HALF — (0.31) itself, in his scheme: (i) the one-loop coefficient per step is 2b₀ ln L + δ_k with δ_k
→ δ_∞ geometrically (the k-th step's fluctuation covariance is scale-covariant up to the bare action's irrelevant terms), so
positivity is a statement for L ≥ L₀ and L₀ IS THE FIRST NUMBER THIS BUILD MUST PRODUCE (the asymptotic value per doubling is in
the tree: Δβ = 4·2b₀ ln 2 = 0.258 in Wilson units, Fontes's δβ and §90's); (ii) the higher-order remainder ≤ C g_k² uniformly in
k, by Cauchy estimates on Theorem 1's analytic small-field action. Both need his exact objects — the normalization condition
that defines g_{k+1} from ρ_{k+1}, (0.18) and (0.20) of CMP 109, (0.31) of CMP 116 (iii-3a's two descriptions of (0.31) — "pinning
1/g_K² = 1/g²" and "the basic inequality of [II]" — reconciled from the page first), Theorem 1's analyticity domain and the norm
on the remainder, the averaging operator Q — requested from iii-3a, who holds the pages. Bałaban's own word for (0.31)'s proof
was "awkward and long": the honest cost is days to weeks. THE TWO STANDING FALSIFIERS BESIDE Σ1b: U(1) has ZERO one-loop
coefficient, so (0.31)'s c₁ > 0 fails there and Theorem 2's conclusion with it — the chain separates the groups exactly at Σ1b,
the right place; the free massless field has no coupling to run, so (0.31) is vacuous for it. THE SAME REFRAMING THROUGH THE
CHAIN — every "open piece named, not claimed" becomes a build row with a statement and a falsifier: Σ1d THE CONVERGENCE of the
gauge-invariant correlation functions as n → ∞ at fixed physical distance (OURS: compactness from Σ1a's uniform bounds plus
Σ3's uniform decay, uniqueness of the limit by the decay's uniformity; falsifier: two subsequential limits parting on a
Wilson-loop correlation); Σ5′ EUCLIDEAN INVARIANCE of the limit (OURS: the hypercubic-breaking operators are irrelevant, their
coefficients O(a²) along the scaling sequence under Σ1a's bounds; falsifier: a rotation-odd correlation surviving the limit);
Σ1c as above. CORRECTION, dated: §83 quinquies wrote of Magnen–Rivasseau–Sénéor (CMP 155, 1993) "whose completeness the
literature disputes" — there is no source for that sentence; struck. MRS is UNREAD, a candidate ultraviolet road that may not
carry a sequence hypothesis of Bałaban's kind, to be read at the page before anything about it enters.

§94 — Σ1b's HARD HALF (i) REDUCED: THE FIXED-POINT LOG LEMMA, AND THE INSTRUMENT AGAINST ITS KNOWN ANSWER (06:36).
THE INSTRUMENT (STDLIB/scripts/aperanton_oneloop_bg.awk; records oneloop_bg.2026-10-29a/b.txt; the stake in its header written
before the run). The one-loop background dependence of the SU(2) Wilson fluctuation determinant, unconstrained, on N⁴ with
antiperiodic fluctuations, background a₂ = ε cos(2πx₁/N), background-covariant Feynman gauge. THE QUADRATIC FORM DERIVED
(BCH on U_p = e^{iq₁}e^{iq̃₂}e^{−iq̃₃}e^{−iq̃₄}V_p with every fluctuation transported to the base point, V_p = e^{iΦT³}, T = σ/2):
½Re Tr U_p = cos(Φ/2) − ½ sin(Φ/2)S³ − ⅛cos(Φ/2)|S|² + ¼ sin(Φ/2) Σ_{i<j}(p_i × p_j)³ + O(3), so the quadratic part of
β(1 − ½Re Tr U_p) is β/8 [cos(Φ/2)(|S³|² + |s|²) − 2 sin(Φ/2) Σ_{i<j} Im(p̄_i p_j)] (s = S¹ + iS², the charged transported
components p_i), the linear term the background's own source, dropped at one loop. READINGS: the Feynman identity
M_vec = M_gh ⊗ 1₄ at ε = 0 to 1.8 × 10⁻¹⁵; Δ_N (= β_eff − β) = −1.2099 / −1.3636 / −1.4740 / −1.5595 / −1.6291 at N = 4 / 6 /
8 / 10 / 12; per doubling 0.2642 (4→8), 0.2655 (6→12), 0.2657 (8→10), 0.2645 (10→12) against the stake 8b₀ ln 2 = 0.2575;
the ghost part 0.0249 → 0.0239 against its share 0.0234 (one eleventh), the vector part 0.2408 → 0.2406 against 0.2341 (ten
elevenths); the neutral sector −0.250000 at EVERY N — no charge, no log, the U(1) line exactly. A three-point fit
A + B ln N + C/N² on N = 8, 10, 12 reads B = −0.3783 against −8b₀ = −0.3715 (1.8 %): the slope sits 2.7 % above the stake
at N ≤ 12 and has not yet bent toward it; N = 16 running decides whether this is a slow lattice correction (a²p² ln(ap)
terms) or a defect in the vector sector — the ghost's convergence to its one-eleventh points at the vector's spin term
if it is a defect. THE STAKE IS NOT YET MET; it is not refuted either.

THE FIXED-POINT LOG LEMMA (the structural reduction, scheme-independent). Let β_{k+1}(0) be the one-loop marginal coefficient
of the k-th block-spin step (the decrease of 1/g² over the step at zero coupling). (H1) ADDITIVITY: the extraction (0.28)
assigns zero second moment to the irrelevant remainders V^(j), and at one loop a remainder carried to a coarser scale enters
no later Gaussian (its Hessian is O(g²) against the classical one), so the K-step one-loop marginal change is exactly
Σ_{k<K} β_{k+1}(0). (H2) GEOMETRIC CONVERGENCE: the k-th step's free problem is the free Wilson action at spacing ε blocked k
times, and the Gaussian block-spin map contracts its irrelevant deviations by L^{−2} per step, so β_{k+1}(0) = β_∞ + δ_k with
|δ_k| ≤ D L^{−2k}. (H3) UNIVERSALITY: the one-loop running between the bare lattice and the unit lattice is
8b₀ ln(1/ε) + C + o(1) with the universal coefficient (8b₀ = 11/(3π²) for SU(2) in Wilson's — Bałaban's — units; C the two
ends' scheme constants). THEN β_∞ = 8b₀ ln L EXACTLY: (1/K)Σ_{k<K} β_{k+1}(0) = (1/K)(8b₀ K ln L + C + o(1)) → 8b₀ ln L, and
the Cesàro mean of a convergent sequence is its limit; and Σ_k δ_k = C. So the hard half's part (i) is NOT "compute β₀(L)":
its asymptotic value is universal and known, 0.2575 at L = 2; what remains is the TRANSIENT BOUND — inf_k β_{k+1}(0) ≥
8b₀ ln L − sup_k max(0, −δ_k) > 0, decided by the first step's δ₀(L) (the scheme constant between Wilson's lattice and the
block scale, bounded uniformly in L as L → ∞) and D L^{−2} for the rest. THE SIGN THE UNCONSTRAINED READING SUGGESTS:
−Δ_N = 8b₀ ln N + 0.70 + O(N⁻²) — the decrease of 1/g² from Wilson's cutoff to the box scale EXCEEDS the bare log by a
positive constant, i.e. Wilson's lattice coupling is weak against an infrared scheme (Λ_W small, as Hasenfratz–Hasenfratz
found for MS-bar); if the block scheme's δ₀(L) has the same sign, β₁(0) > 8b₀ ln L and positivity holds at EVERY L ≥ 2 — a
reading by analogy, not the block scheme's number, which the constrained instrument computes next (log Z = −log det M −
log det(Q̃M⁻¹Q̃†) + const for the charged field, the ghost restricted to zero block averages). THE FALSIFIERS: U(1) has
b₀ = 0, so β_∞ = 0 and c₁ > 0 fails — the chain refuses U(1) at Σ1b by the lemma itself; the free massless field has no
coupling to run. WHERE THE ONE-LOOP DETERMINANT SITS IN HIS BOOKKEEPING — inside β_{j+1} through E^(j+1), or in the
log Z^(j) brackets of (1.3) — is to be read from the page (the plan seat): the lemma concerns the total marginal change per
step, which (0.31) requires to be logarithmic, so it must reach β_{j+1}.

§94 bis — THE INSTRUMENT AT N = 16, ITS APPROACH STAKED, AND (c) CONVERTED (06:39). N = 16: Δ = −1.738271 (vector −1.445118,
ghost −0.043153, neutral −0.25). Per doubling 12→16: total 0.2630, vector 0.2396, ghost 0.0234 — THE GHOST MEETS ITS SHARE
0.0234 EXACTLY. The total and the vector approach their stakes as the standard lattice artifact (a + b ln N)/N²: with the
asymptote FIXED at the stake and the two parameters fitted on 8→10 and 10→12, the fit PREDICTED 12→16 at 0.2629 (total) and
0.2396 (vector) and the run read 0.2630 and 0.2396; the free three-point fit puts the asymptote at 0.2579 against 0.2575.
THE STAKE FOR N = 20, written before the run: 16→20 per doubling 0.2615 total (in [0.2605, 0.2625]) and 0.2384 vector (in
[0.2374, 0.2394]); the ghost 0.0234 ± 0.0005. A miss outside the bands reopens the vector sector's spin term.

(c), THE CHESSBOARD CONSTANT, iii-3a'S (its scripts c_jd.py, c_kcheck.py, c_klimit.py on that seat): (α) EXACT and free of θ*:
ρ_A(β,θ*) ≤ e^{−s}K_A(β), s = β(1 − cos θ*), K_A(β) = (e^{β|A|}Z_{Λ∖A}/Z)^{1/|A|} = exp ∫₀^β E_A(t)dt ≥ 1 — on the disseminated
event every A-plaquette has cos θ_p ≤ cos θ*, so Z_bad(A) ≤ e^{β|A| cos θ*}Z_{Λ∖A}; (β) the Gaussian-limit value K_∞ =
exp[(3/2)(J₄ − J₂)] = 3.4911 (J₄ = 1.9997076, J₂ = 4G/π met to twelve digits), degree ZERO in βθ*² — the event is realised by
the free ρσ-constant flux mode, so no s^{1/2} prefactor; (γ) the rigorous upper half PROVED (temporal gauge outside (μν):
Z_{Λ∖A}e^{−β(N−|A|)} ≤ I(β)^{3|Λ|(1−1/L)}, I(β) = 2I₁(β)e^{−β}/β), the lower half Z e^{−βN} ≥ (the Gaussian value per site)
(1 − o(1)) THE RESISTING LINE (a tree-gauge Gaussian trial has variances growing along the tree; a Lorenz-type trial needs the
SU(2) gauge-orbit entropy with explicit constants); if attained, K ≤ e^{3J₄}·1.0006 = 403 for the full class, 403⁴ for an
index-4 orbit. Fontes's K = 1 is unreachable (K_A ≥ 1, → 3.49): his proof compares with the vacuum weight and drops the
entropy. CONVERTED, with the KP balance of §92 quinquies (β > 473θ*², Peierls β > s_c/(1 − cos θ*), s_c = ln(20e·K), θ* below
the Christoffel edge 0.5636): K = 1 (his eq. chess, refuted) 61.8 at θ* = 0.362; K = 3.49 (the Gaussian limit) β_SF = 70.9 at
θ* = 0.387; K = 403 (the full class, the ceiling route) 98.1 at 0.455; K = 403⁴ (an index-4 orbit) 181.0 at the edge 0.5636.
THE ONE-BLOCK FLOOR OF RECORD: β_SF ∈ [70.9, 98.1] for the full (μν) class (iii-3a's orbit construction, even L, site-plane
reflections in-plane and link-plane reflections transverse), 181 for an index-4 orbit — each conditional on the lower half of
(γ) and on (b) at that θ*; the earlier 69.9 (the marginal μ₁ as the Peierls factor) is superseded by the chessboard form.

§95 — THE DISTANCE CORRECTED: ≈ 260 RENORMALISATION STEPS, NOT "8.2 DOUBLINGS", AND WHAT THE COUNT DECIDES ABOUT THE PROOF'S
SHAPE (06:54; the operator relayed a side agent's note: "The crossing is about 260 zoom steps, not 8"; law 18 on §92
quinquies and §92 bis, whose "[0.2452, ≈ 70] — 8.2 doublings of β" stands as written above and is corrected here). THE
CORRECTION: 8.2 = log₂(70/0.2452) counts doublings of the coupling VALUE. The proof's unit is the renormalisation step (the
lattice spacing doubles), and its count is the integral over the β-function: dβ/d ln(1/a) = 8b₀ + 32b₁/β = 0.3715 + 0.058/β
for SU(2) in Wilson's units (b₀ = 11/(24π²), b₁ = 17/(96π⁴)·… — the two-loop term 6 % at β = 2.5, negligible at 70), so
the perturbative stretch [2.5, β_UV] is (β_UV − 2.5)/0.2575 steps to within that correction: ≈ 262 from the conditional
one-block floor 70, ≈ 689 from 180, ≈ 111 from 31 — a length-scale ratio 2^262 ≈ 10^79 from 70. Below β ≈ 2.5 the
effective coupling falls into the strong-coupling disk in 2–4 steps (iii-38's matched c₁ ≈ 0.6 one step below 2.2, ≈ 0.12
two steps below). THE COUNT AND THE ARCHITECTURE: (1) A per-step CONTRACTION (candidate B, every sup-metric block criterion)
must keep ∏ρ_k bounded over the steps; in the perturbative region the coarse correlation length ξ_k ≫ 1 in coarse units, so
every Dobrushin-type coefficient is order one or larger there BY PHYSICS — §91's ×1.8–2.1 per step is the expected reading,
and a sup-metric contraction is the wrong shape for that stretch entirely. (2) An INVARIANT-preserving argument (Bałaban's
inductive bounds) is indifferent to the count: the irrelevant remainder obeys E_{k+1} ≤ L^{−α}E_k + c g_k², a stationary
balance E_k ≤ cγ²/(1 − L^{−α}) at every k; the marginal coupling is a sum, and CouplingSequence.lean's profile (0.31) holds
for any K. Errors do not compound. (3) The wall is therefore the COUPLING at which the invariant's hypotheses fail, not the
number of steps: the large-field regions must stay dilute per cell at each scale — per-plaquette Peierls with entropy
e·20 = 54.4 and chessboard factor K ≥ 1 needs β_k(1 − cos θ*) > ln(54.4K) ≈ 5.25 with θ* below the Christoffel edge 0.5636,
i.e. β_k ≳ 34 at best (the edge), 70–98 at the KP balance; physically the large fields (center vortices) become dense near
β_k ≈ 2.5, where confinement sets in, so ANY dilute-large-field method stops above that and the description must change in
[2.5, ~30]. (4) THE TWO STRETCHES MEET ONE MISSING OBJECT: in the perturbative tail (Σ2P, [~2.5, β_UV], hundreds of steps) the
large-field regions must be weighed by their probability when they are no longer exponentially rare; in the strong bridge
(Σ2N, [0.2452, ~2.5], 2–4 steps, where a per-step factor ≤ ~3 is affordable) the frustrated boundary data must be weighed by
their measure rather than their supremum (iii-38's 0.649 at the cancelling datum, 11× the symmetric response). Stated once:
a multi-scale treatment of large fields by probability, valid from dilute to dense. Every candidate from here states which
stretch it addresses, beside its U(1) line and its free-field line. The ε-test of the instrument (§94): Δ₈ identical to six
digits at ε = 0.005, 0.01, 0.02 — no odd-order bias in the Richardson step.
