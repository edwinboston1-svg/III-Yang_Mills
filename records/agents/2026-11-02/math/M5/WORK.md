# M5 — (W-V), THE VORTEX HALF OF LEMMA W: ITS EXACT FORM, THE FATE OF THE FIBRE ROUTE, SLAVING UNDER TILTS, THE PER-STEP BUDGET

Proof agent M5, 2026-11-02 (desktop; read-only in both repositories; everything here is in this directory). Appended as the work
proceeds; nothing above a line is edited after it is written except by a dated correction below it.

## 0. Sources read in full before deriving

MATH_BRIEF.md; M4_BRIEF.md; M4/WORK.md (all 636 lines: Theorem 2.1, Proposition 2.2, Lemmas 3.1–3.2, Theorem 3.3, Theorem 4.1,
Theorems 5.1–5.2, §§6–7 the channel readings, Theorem 8.1 Turán slaving, Lemma W §9, the addenda §§11–12); M2b/WORK.md (all 181 lines
on disk at 06:15: §0 Lemma 0.1, §1 the instrument, §2 the W4 stakes, §3 Theorem A1, Corollary A1′, what survives — §§4–5, Lemma A2 and
Theorem C1, were NOT on disk; re-checked before the final message); M2/WORK.md (all 506 lines: Proposition 1.1, Lemma 2.1, Theorem 2.3,
Proposition 2.5, Theorem 3.1 = Theorem 8.5-L², Theorem 4.1, Lemmas 5.1, 7.1, 7.2); M2R/REVIEW.md (all 340 lines, including Lemma R and
the structural fact about holonomy block maps); THE CROSSING CAMPAIGN §§17–18 (III DOCS/III-THE-CROSSING-CAMPAIGN-OF-THE-YANG-MILLS-GAP.md:
the bent object never computed — planar objects only as geometry); THE GROUND §8.3 (III-Yang_Mills source/ground/content4.js lines
66–140, copied to ground_83.txt and ground_83b.txt here: the block map, (8.5), Proposition 8.4, Hypotheses I and II, Theorem 8.5, the
effective-action reading C ≤ 1 − e^{−Δ}, the hierarchical descent of revision 31, the block-criterion paragraph, the perfect cover,
Lemma 8.6, Theorem 8.7); the Lean files' theorem lists (III LEAN/aperanton: BondMoving, CrossoverCriterion, TwistEater*); M2b's
twist reader header (code/twist.c, code/t4_twist.sh) to avoid duplicating its engine.

## 1. The deep-think synthesis (before any derivation; the decision this file executes)

**What I expected.** Theorem 4.1 reduces (W-V) to a fibre Dobrushin condition; the job looked like finding a block or constrained
form of that condition that holds at β = 2.2 with blocks of side 2–4.

**What changed my mind (three facts, each checked at the desk before anything was computed).**
(i) THE FLIP IDENTITY. The change of variables of M4's Theorem 2.1 gives more than the density ratio: the twisted fibre over v IS the
untwisted fibre over σ_m v, pushed forward by the flip of one link. So the twisted fibre's response at a probe is the fibre mean's
sensitivity to the CENTRE ELEMENT of a neighbouring holonomy — and by representative independence it is the same for every position of
the twist on π_m. The "distance a_c/2" of Theorem 4.1 belongs to the proof (the Dobrushin comparison bound depends on where the twist is
put), not to the quantity (which does not). (W-V) is a topological (linking) response, not a clustering tail.
(ii) THE SCALE. Blocks of side 2–4 at β = 2.2 put the twist and the probe one or two fine spacings apart; Theorem 4.1's prefactor is
48πβ·19² ≈ 1.2·10⁵ at β = 2.2, and any fibre Dobrushin decay rate is capped by the single-link coefficient, which a free fibre link
with cancelling staples makes at least TV(vMF(βe), vMF(−βe)) = L₁(β)/I₁(β) (modified Struve over Bessel; ≈ 0.735 at 2.2 by hand).
So Theorem 4.1's hypothesis fails at 2.2 by a factor ≥ 18 × 0.735 ≈ 13, and would need a_c ≳ 10² fine spacings even if it held.
ROUTE REFUTED, LEMMA NOT: (W-V) itself is untouched by this; its smallness at the exit scale is the coarse theory's strong coupling.
(iii) THE TILT. Every pair-conditional law on ℤ⁴ is a convolution TILTED by the link's other plaquettes. Averaging the even–even
bilinear form over the four centre sign flips leaves a_e b_e K_e + a_o b_o K_o: the odd parts of the tilts feed the vortex channel into
the SO(3) channel LINEARLY. Turán slaving (quadratic) holds on untilted convolutions (MK, 2D blocking) and fails on ℤ⁴'s conditional laws
wherever the tilts' odd parts are O(1) — which at β′ ≈ 0.45 with |staple sum| ≤ 5 they are. This also predicts where the record's
one-step readings violate slaving (the ordered datum, E[χ_½(A)] = 0.62).

**Decision.** (1) State (W-V) first in THE GROUND's TV currency (Proposition 8.4's mixed difference restricted to the 2⁴-point centre
orbits), then in M4's L² currency, parametrised by the coarse fundamental coefficient ε rather than by a fixed a_c, with the flip
identity, the exact (equality) form of Theorem 4.1's integral, representative independence, and the electric-flux form
t_m = tanh(F_m/2); count neighbours and state the number (W-V) needs. (2) Refute Theorem 4.1's hypothesis at β = 2.2 by a certified
LOWER bound on an actual fibre coefficient (known answer first: (4/(3π))β as β → 0), check realizability inside the fibre at a_c = 2,
compute the a_c the route would need under the most favourable κ_f, and state the block obstruction (THE GROUND §8.3's own paragraph +
D ≥ I at a_c ≤ 2b). Replacement: (W-V′) on the coarse conditional law (uniform electric-flux bound and the two-scale recursion of the
mixed difference). (3) Prove the tilted-Turán decomposition and its leak bound; test it against M4's existing records (no new engine
runs); answer the two layers of "convolution class" (ℤ⁴ action: leaves after one step; MK: stays by construction, and whether 𝒯 is
closed under bond moving's pointwise powers — tested on the Poisson-kernel edge family and on the MK flow from 2.2, stakes first).
(4) Admissible δ at both exits (0.2452 unconditional, 0.4764 under S12); best provable per-step bound (non-expansion); the measured MK
loss; the obstructions (bracket on Z ≠ bracket on the measure; RP-uniform comparisons die on centre-blind actions).

**Runner-up rejected.** A block-Dobrushin certificate for the fibre at sides 2–4 by computation: THE GROUND §8.3 already proves no
first-order block criterion gains on the single link, and (i) shows the target quantity is not a decay in the twist–probe distance.

**Confidence.** High on (i), on the single-link lower bound, on the sign-flip averaging identity. Medium on the constants of the leak
bound and on its agreement with the records. Low–medium on the 𝒯-closure question (undecided at the desk).

**Kill-switches.** The known answer (4/(3π))β not met by the Struve/Bessel formula; the realizability count failing at a_c = 2; the
leak bound falling BELOW the recorded ρ_EE at a cell where it should dominate; M2b's twist KAT (t4.txt) not meeting F_tw = (−1)^a F.

## 1b. THE ORCHESTRATOR'S REFRAMING (iii-43, received mid-work): THE TWO-STEP LANDING — answered in §5, its runs staked here first

iii-43: the exact pinned-datum objects invert the one-plaquette coefficient to β_eff 1.85 / 1.19 / 0.076 after one step and 0.2930 /
0.2225 after two (W2L2, ordered / cancelling) — if that survives fine integration and the coarse supremum, the crossover from 2.2 is a
TWO-STEP LANDING and the budget is the exit lemma's (8bcfffd: Theorem 8.9's certificate passing at the blocked action's own
coefficients). Asked: the per-step criterion under the exact step's drift; what the two-step blocked action must satisfy (which couplings
beyond the one-plaquette coefficient, in which norms) for the coefficient-supplied mode to apply; whether (W-V) gives its vortex half.

Read before staking (the far shore §10 RESULTS 3–4, the engine STDLIB/build/aperanton/kp_cert_table_wip.awk, the reader
surface-gas/w2_modes.awk and its records w2n4_W2L2_modes.2026-11-01a.{ordered,cancel}.txt): RESULTS 4 makes the exit test ONE
certificate call with (i) COEF = the blocked a′_j, (ii) HALF = 1 + r_mod (the integer spin-1 MODIFYING modes), (iii) WALL = the floor of
the wall coefficient from the CREATING modes, (iv) the rest through A4's spin factor. The reader prints, at two steps, a′_½ = 0.0728 /
0.0554, a′_1 = 9.0·10⁻⁴ / 5.4·10⁻⁴, HALF = 1.00495 / 1.00503, WALL = 0.2998 / 0.3380, and also s_half = 0.1496 / 0.1793 per pair — the
half-integer creating shares, chiefly the (½,½) mode b̂ = 8.32·10⁻³ / 1.28·10⁻² (ratio to the Wilson pair unit 0.392 / 1.046) — WHICH
THE CERT-CALL DOES NOT CONSUME. No run of the two W2-CERT-CALL lines exists on disk (grep of table_gate/, surface-gas/, runs/).
The engine's FAIL alphabet: "the dressing iteration leaves [0, 3]: no root"; "rho >= 1 at the upper bracket: the s-sum's tail is not
closed"; "no kappa-bar with R_hi(kappa-bar) <= kappa-bar below 2"; "r >= 1: the tail over F > F0 does not close"; "the inequality's upper
end is above alpha". The branch terms use max(a_1, WALL) in z_br(s) = 3(γ a_1 e^{2α̃})^s (γ = 6 in the page dress; graded γ(s) with LOCAL),
and rho = 5·γ·W·e^{2α̃+κ} must be < 1.

**STAKES (2026-11-02, before any run; none edited after).** Records under rec/; the engine run read-only from III's tree, outputs here.
- K0 (known answer, the gate's coef pin): COEF = the Bessel ratios at β = 0.25 over 10³⁰, page dress, γ = 6, F0 = 20, α = 1/1000 reproduces
  "KP-CERT dress=page coef=supplied beta=supplied alpha=1/1000 gamma=6/1 F0=20: kappa_U in [0.019543, 0.019543] root in [0.019543,
  0.019543] u in [0.06233787, 0.06233787] u~ in [0.06356816, 0.06356816] r_hi=0.320393" and PASS. Nothing below is read until it is met.
- K1 (the record mode under COEF): COEF = the Bessel ratios at β = 0.4764 over 10³⁰ with LOCAL=1 and the record's R2TAB, page dress, at
  α = 44/10000 PASSes, with u, κ_U and LHS equal to the table mode's own point run at P/Q = 4764/10000 to every printed digit.
- S1 (the record's own two-step exit call, as printed, page dress γ = 6, α = 1/1000): FAIL at both data, the WHY being one of the
  dressing's two ("no root" or "rho >= 1"): 5γW = 9.0 / 10.1 > 1.
- S2 (the same without WALL): PASS at both data at α = 1/1000 (u = 0.0731 / 0.0556, inside the page reach u(0.4260) ≈ 0.106).
- S3 (the WALL scan, page dress and LOCAL+R2TAB, u as in S2): the largest passing floor W* lies in [0.02, 0.05]; the record's 0.30 / 0.34
  exceed it by a factor 6–15.
- S4 (the vortex pair dressing, TWO LABELLED HYPOTHESES, neither a theorem): H0 none (= S2); H1 every spin-½ plaquette's coefficient
  multiplied by (1 + 2r), r the planar (½,½) ratio 0.392 / 1.046 (the per-adjacent-pair dressing of a branch-free surface at leading order,
  AM–GM over its four neighbours): u = 0.1305 / 0.1720 FAIL at both data in both dresses; the largest passing r* (page dress, no WALL) in
  [0.2, 0.3] ordered, [0.4, 0.55] cancelling.
- S5 (the (W-V) number at two steps, already on disk, M4 §7 Δ_A, loops, planar, pinned): the TV form of the label split charges ¼Δ_A per
  pair; over the twenty adjacent pairs (planar proxy for the sixteen bent) 20·¼Δ_A = 1.23 / 1.38 at W2L2 and 2.66 / 3.13 at W3L2 — above
  one at both caps (arithmetic placed now; the reading is M4's).

---

## 2. (W-V) IN ITS EXACT MINIMAL FORM (THE GROUND §8.3's notation; proofs on the page)

**Setting.** THE GROUND §8.3 with M4 §2: rung j, coarse scale a_c, blocks B_y, the holonomy block map (straight corner-to-corner fine
paths π_m, the remaining links in a fixed gauge T), Wilson's w(U) = exp(½β tr U) (any positive continuous class function below unless a
constant is quoted), λ_j the blocked measure with density ℓ_j against the product Haar measure on coarse links, A_j = −log ℓ_j its effective
action, ν_j(·|v) the fibre measure. For a coarse link m, a free link f ∈ π_m, the flip S_f (U_f ↦ −U_f) and the coarse flip σ_m
(v_m ↦ −v_m): B_f := Π_{p∋f} w(−U_p)/w(U_p); the twisted fibre ν^f(·|v) := B_f ν(·|v)/ν(B_f|v); the conditional vortex free energy
F_m(v) := −log ν(B_f|v) = A(σ_m v) − A(v) (M4 Theorem 2.1 (a), (d)).

**Lemma 2.1 (THE FLIP IDENTITY).** For every bounded measurable G of the fine field and every coarse v,
  ν^f(G | v) = ν(G∘S_f | σ_m v);  in particular ν^f(G | v) = ν(G | σ_m v) whenever G does not depend on U_f.
*Proof.* S_f preserves the product Haar measure (−1 is central), maps the fibre over v onto the fibre over σ_m v (M4 Thm 2.1: v_m ↦ −v_m,
the other coarse variables fixed, distinct paths share no fine link), and Π_p w((S_fU)_p) = B_f(U)Π_p w(U_p) (a plaquette holds f at most
once). For bounded H of the coarse variables, substituting U = S_fU′: E_μ[H(v)G] = E_μ[H(σ_m v)(G∘S_f)B_f], i.e.
∫H(v)ℓ(v)ν(G|v)dv = ∫H(σ_m v)ℓ(v)ν((G∘S_f)B_f|v)dv = ∫H(v)ℓ(σ_m v)ν((G∘S_f)B_f|σ_m v)dv (coarse Haar is σ_m-invariant). H being arbitrary,
ℓ(v)ν(G|v) = ℓ(σ_m v)ν((G∘S_f)B_f|σ_m v); G ≡ 1 gives ℓ(v) = ℓ(σ_m v)ν(B_f|σ_m v); dividing, ν(G|v) = ν^f(G∘S_f|σ_m v). Replace v by σ_m v
and G by G∘S_f (S_f² = id). ∎

**Corollary 2.2 (THE VORTEX MIXED DIFFERENCE, AS AN EQUALITY).** Let m′ ≠ m, v(s) the coarse configuration with v_{m′} ↦ e^{sX}v_{m′}
(‖X‖_op = 1, everything else fixed), realised at a free link f′ ∈ π_{m′} by U_{f′} ↦ L⁻¹e^{sX}L U_{f′} (L the product of π_{m′} before f′),
and Φ_s := (d/ds′)|_{s′=s} Σ_{p∋f′} log w(U_p(s′)), |Φ_s| ≤ 6β for Wilson's weight. Then
  F_m(v(s₁)) − F_m(v(0)) = ∫₀^{s₁} [ ν(Φ_s | v(s)) − ν(Φ_s | σ_m v(s)) ] ds .
*Proof.* For any coarse path u(s) generated by the rotation at f′, d/ds log ℓ(u(s)) = ν(Φ_s | u(s)) (the rotation is a left
multiplication of U_{f′} by an element depending on other links, so it preserves Haar measure and carries the fibre over u(0) onto the
fibre over u(s) — M4 Theorem 4.1's first step). Apply it to u = v(s) and to u = σ_m v(s) (σ_m and the rotation of v_{m′} commute), and use
F_m = log ℓ(v) − log ℓ(σ_m v). ∎
When f lies in none of the six plaquettes through f′, Lemma 2.1 turns the integrand into ν(Φ_s|v) − ν^f(Φ_s|v): M4's Theorem 4.1 integrand,
here as an EQUALITY. The equality needs no twist at all.

**Corollary 2.3 (THE RESPONSE IS TOPOLOGICAL).** For free f₁, f₂ ∈ π_m and G depending on neither, ν^{f₁}(G|v) = ν^{f₂}(G|v) =
ν(G|σ_m v). So the twisted fibre's response at a probe does not depend on where on π_m the twist sits: it is the same with the twist at the
midpoint (a_c/2 from the probe) and with the twist one link from the probe's support. A bound decaying in the twist–probe distance — Theorem
4.1's e^{−κ_f(a_c/2 − 1)} — is a property of the comparison theorem's upper bound (which depends on the representative), never of the
quantity (which does not). **(W-V) is not a clustering statement. It is the sensitivity of the fibre, on local observables near the other
coarse paths, to the CENTRE ELEMENT of a neighbouring holonomy — the linking class of a closed 't Hooft surface with π_m.** "The twisted
fibre forgets the insertion at distance a_c/2" is replaced by "the fibres over v and over σ_m v agree near the other paths".

**Theorem 2.4 (THE CENTRE SPLIT OF (8.5) IN THE GROUND'S CURRENCY).** Take the coarse links as the Dobrushin sites (the natural refinement
of THE GROUND's blocks; Theorem 8.5's proof is unchanged). For links m ≠ n put
  C̃^λ_j(m, n) := sup ‖λ_j(dṽ_m | v) − λ_j(dṽ_m | v′)‖_TV  (ṽ_m ∈ SO(3) the projection of v_m, the centre label integrated),
  Θ_{mn}(A_j) := sup |F_m(v) − F_m(v′)| = sup |[A_j(σ_m v) − A_j(v)] − [A_j(σ_m v′) − A_j(v′)]|,
both suprema over coarse configurations v, v′ differing only at n. Then
  C̃^λ_j(m, n) ≤ C^λ_j(m, n) ≤ C̃^λ_j(m, n) + ¼ Θ_{mn}(A_j),  and  Θ_{mn}(A_j) ≤ Δ_{mn}(A_j)  (THE GROUND's mixed difference).
For THE GROUND's block sites (four links at y, label L_y ∈ Z₂⁴): C^λ_j(y, y′) ≤ C̃^λ_j(y, y′) + 1 − e^{−Δ^Z_{yy′}}, with Δ^Z_{yy′} THE
GROUND's Δ_{yy′}(A_j) restricted to the 16-point centre orbits of v_y (so Δ^Z ≤ Δ).
*Proof.* Write the conditional law of v_m as the law of (ṽ_m, L_m) through a measurable section. The chain rule for total variation,
‖P − Q‖ ≤ ‖P_ṽ − Q_ṽ‖ + ∫‖P(·|ṽ) − Q(·|ṽ)‖dP_ṽ, bounds C by C̃ plus the supremum over orbits of the label laws' distance. Given the orbit,
the label is Bernoulli with P(L_m = +) = 1/(1 + e^{−F_m}) (the density ratio of v_m and −v_m is ℓ(σ_m v)/ℓ(v) = e^{−F_m(v)}); the logistic
function has slope at most ¼; so the label distance is at most ¼|F_m(v) − F_m(v′)|. The left inequality: total variation contracts under
the projection. Θ ≤ Δ: Θ is the oscillation in v_m of A(·, v′) − A(·, v) restricted to the two points v_m, −v_m. Block sites: the label law
on Z₂⁴ given the orbit has energies A(γx̂, ·); under v ↦ v′ it is tilted by a function of oscillation ≤ Δ^Z, and Proposition 8.4's first
inequality applies. ∎
The split costs, at the leading mode p = 1 + εχ_½(U)χ_½(V) (Haar marginals): the full TV coefficient is (16/(3π))ε (M2 §2.5), the label
term 4ε (¼ of the oscillation 16ε) — a factor 3π/4 = 2.36, the TV analogue of M4's 2√2 in L², the price of the supremum over the orbit
(M2b's twist.c header prints the same C/T = 3π/4 for its distinguishability T).

**Proposition 2.5 (THE VORTEX FREE ENERGY IS TWICE THE ODD PART OF THE EFFECTIVE ACTION).** With A = A^{e,m} + A^{o,m} the parts even and
odd under σ_m: F_m = −2A^{o,m} and Θ_{mn} = 2 sup_{v ~_n v′}|A^{o,m}(v) − A^{o,m}(v′)|. For any decomposition log ℓ = Σ_P log w′(v_P) + Σ_C δ_C
(one-plaquette part plus bonds C, connected sets of ≥ 2 coarse plaquettes), only the plaquettes and bonds containing BOTH m and n enter, and
only through their σ_m-odd parts: Θ_{mn} ≤ 2Σ_{P∋m,n} osc_{v_n}(log w′)^{o}(v_P) + 2Σ_{C∋m,n} osc_{v_n} δ_C^{o,m}; a Peter–Weyl mode of a bond has
σ_m-parity (−1)^{Σ_{P∈C, P∋m} 2j_P}. (Immediate from F_m = A(σ_m v) − A(v).) Example: a Wilson coarse action at β′ gives F_m = β′Σ_{P∋m} tr v_P,
so Θ_{mn} ≤ 4β′ for the eighteen links n sharing a plaquette with m and Θ_{mn} = 0 otherwise (two links share at most one plaquette).

**(W-V), THE STATEMENT.** At a rung j and coarse scale a_c, in THE GROUND's currency (link sites):
  (W-V)_TV   Σ_n ¼ Θ_{mn}(A_j) e^{κ|m−n|} ≤ α_V  for every coarse link m,
and in M4's L² currency (Theorem 3.3 there): Σ_z [T(y,z) + T(z,y)] e^{κ|y−z|} ≤ α_V, T(y,z) the coarse ess-sup of the maximal correlation of
the centre label at y with v_z given the orbit (exactly sd(tanh(F/2))/(1 − t₀²)^{1/2} for one flip). With the SO(3) half
Σ_n C̃^λ(m,n)e^{κ|m−n|} ≤ α − α_V (or its L² form R̃), Hypothesis I holds (Theorem 2.4), uniformly in the cutoff when the constants are.
**What it demands at a Wilson-like exit.** Eighteen plaquette-neighbours (the range of the one-plaquette part; bonds add more, weighted
e^{κ|m−n|}); with α_V = ½, ¼Θ_{mn} ≤ 1/36 per neighbour, i.e. Θ_{mn} ≤ 0.11; for a Wilson coarse action Θ = 4β′, so β′ ≤ 0.028. The
single-site vortex half is a deep-strong-coupling statement. The exit at β′ ≈ 0.25–0.48 that the record uses is the KP certificate's,
and there (W-V) must be read in the certificate's currency (§5).

---

## 3. THEOREM 4.1'S ROUTE AT β = 2.2 WITH BLOCKS OF SIDE 2–4: REFUTED, WITH THE EXACT OBSTRUCTION AND THE REPLACEMENT

**The record already holds the one-link theorem** (the aperanton gate's verdict line, "STAGE IV'S AND STAGE III'S FIRST NUMBERS: the SU(2)
one-link Dobrushin coefficient: the flip exactly L_1(beta)/I_1(beta), the one-link criterion failing above beta* = 0.13103"). The flip is
TV(vMF(βe), vMF(−βe)) = L₁(β)/I₁(β): with t = ⟨u, e⟩ distributed as (2/π)√(1 − t²)dt under the uniform law on S³ and Z = 2I₁(β)/β,
TV = (4/π)∫₀¹ sinh(βt)√(1 − t²)dt / Z, and ∫₀¹ sinh(βt)√(1 − t²)dt = (π/(2β))L₁(β) (the Struve integral). What the fibre route needs in
addition is that the flip is REALISED INSIDE THE FIBRE. It is.

**Theorem 3.1 (the fibre's one-link coefficient at β).** Let a_c ≥ 2 (fine units), the coarse paths the straight segments of THE GROUND's
map, and the gauge fixing T of axial type (fixed links in one direction ≠ 1; for direction 4 below). Let e be the fine link from
x = (1, 1, 1, 1) in direction 1. Then:
(a) e and all eighteen links of its six staples lie on no coarse path: a fine link from z in direction μ lies on a coarse path iff z_ν ≡ 0
(mod a_c) for every ν ≠ μ, and each of the nineteen links has a coordinate equal to 1 among its ν ≠ μ (checked one by one: (x, ν), (x+ê₁, ν),
(x+ê_ν, 1), (x−ê_ν, ν), (x+ê₁−ê_ν, ν), (x−ê_ν, 1), ν = 2, 3, 4).
(b) The fibre's conditional law of U_e given every other free link is the Wilson single-link law vMF(βW), W = Σ_{p∋e} S_p (no holonomy
constraint involves U_e), and the six staples S_p are independent and each ranges over all of SU(2) as the fibre configuration varies:
each staple has a free link private to it (two plaquettes through e share only e), off every path (by (a)), not fixed by T (the four
staples in the planes (1,2), (1,3) have no direction-4 link; the two in (1,4) keep their far direction-1 link).
(c) Hence for every free staple link b of e — at least fourteen of the eighteen under any axial T, all eighteen when T fixes none of
them — the fibre's interdependence coefficient satisfies C_fib(e, b) ≥ L₁(β)/I₁(β): set the five other staples to five unit quaternions
summing to zero (the vertices of a regular 4-simplex inscribed in S³; realisable by (b)) and turn b so that its staple goes from S to −S.
The row sum at e is at least 14 L₁(β)/I₁(β) (at least 18 L₁(β)/I₁(β) when no staple link is fixed).

**Computation (flip_tv.awk, record rec/flip_tv.txt; exact rationals, partial sums to 60 terms with tails ≤ twice the first omitted term,
π ∈ [π₋, π₋ + 10⁻³⁵], digits floored/ceiled).** Known answers MET first: (i) small β, (L₁/I₁)/(4β/(3π)) = 0.999999941666… at β = 10⁻³,
→ 1 (THE GROUND §8.1's first-order coefficient 4β/(3π)); (ii) the root of 18 L₁/I₁ = 1 lies in [0.13103, 0.131031] (the gate's 0.13103).
At β = 11/5: **L₁/I₁ ∈ [0.735601941590, 0.735601941591]; 18 L₁/I₁ ∈ [13.2408349486, 13.2408349487]; 14 L₁/I₁ ≥ 10.2984.** (At β = 1/4:
0.1057; at 0.4764: 0.1996, 18× = 3.592.)

**Corollary 3.2 (Theorem 4.1's hypothesis fails at β = 2.2, at every a_c, by a factor the fine coupling fixes).** The fibre Dobrushin
condition Σ_j C_fib(i, j)e^{κ_f|i−j|} ≤ α_f < 1 fails at e already at κ_f = 0: the row sum is ≥ 10.29 (≥ 13.24). Nothing about a_c enters:
the obstruction is the single link at β = 2.2, inherited unchanged by the fibre because the fibre's off-path conditionals are Wilson's.
REFUTED: the route "(W-V) from a fibre Dobrushin condition at β = 2.2 with blocks of side 2–4". Not refuted: (W-V) itself.

**Block and constrained forms.** (i) Blocks with first-order transmission: THE GROUND §8.3's own paragraph — no Dobrushin–Shlosman block
criterion gains on the single link at any side, a link deep in a block branching to its eighteen neighbours exactly as in the full lattice.
(ii) Even granting any block condition, the comparison theorem's bound |ν^f(Φ) − ν(Φ)| ≤ Σ δ_B(Φ)D(B, B′)b_{B′} has D ≥ I and, at a_c ≤ 4, the
twist's block and the probe's block at block distance ≤ 1: no decay factor is available, and the prefactor is O(β) = O(2.2) against the
needed ≲ 10⁻² (per neighbour, §2's 0.11/π for the integrand). (iii) Constrained forms (the holonomy constraints themselves): they bind
only links ON the paths; Theorem 3.1 lives off them. (iv) And Corollary 2.3 removes the premise of every such route: the quantity does not
decay in the twist–probe distance at all.

**THE EXACT OBSTRUCTION.** At β = 2.2 and a_c = 2–4 the fibre over v is the β = 2.2 Wilson field with a few holonomies fixed; its local
conditionals off the paths are Wilson's, with flip coefficient 0.7356 per neighbour; and what (W-V) asks of it (Corollary 2.2) is the
response of the coarse force near π_{m′} to the centre element of v_m — at coarse distance one, i.e. the COARSE COUPLING's odd part itself
(Proposition 2.5), not a fine-scale tail. A fibre condition can bound it only by first bounding the coarse coupling.

**THE REPLACEMENT LEMMA (W-V′), at the currency where the exit is decided.** (W-V) is the statement that the σ-odd part of the blocked
action is small in the norm the exit test consumes:
 (W-V′)_site  (deep strong coupling, single-site exit): Σ_n ¼Θ_{mn}(A_j)e^{κ|m−n|} ≤ α_V, Θ_{mn} = 2·osc of the σ_m-odd part of the plaquette
   and bond terms containing m and n (Proposition 2.5) — read directly on the blocked action, no fibre clause;
 (W-V′)_KP  (the record's exit, Theorem 8.9 at the blocked coefficients): the half-integer modes of the blocked action's bonds — chiefly the
   (½,½) mode of adjacent coarse plaquette pairs — priced in the certificate (they are the vortex half there; §5 finds them unpriced by the
   record's exit call and dominant on its objects).
 THE TWO-SCALE FORM (Corollary 2.2 between scales; exact): with λ_k(·|v′) the law of the scale-k coarse field given the scale-(k+1) one and
   Φ^k the scale-k coarse force, Θ^{(k+1)}_{m′n′} = sup|∫[λ_k(Φ^k_s|v′(s)) − λ_k(Φ^k_s|σ_{m′}v′(s))]ds|. So the vortex half one step up is the
   between-scale fibre's response to a coarse centre flip; where the scale-k gas is in the certificate's cone this between-scale fibre is a
   convergent polymer system and the response is a sum of KP activities — the attack, and the reason (W-V) is reached by the certificate,
   not by a fine-scale fibre: (W-V)_site one step beyond a passing exit is the strong-coupling contraction ε → O(ε⁴) of the odd coefficient
   (the 2a_c plaquette tiled by four a_c plaquettes). Owed for that last sentence: the conditioned polymer expansion written with its
   activities; not proved here.

---

## 4. TURÁN SLAVING UNDER TILTS: THE BLOCKED ACTION LEAVES THE CONVOLUTION CLASS AT ONCE, AND THE LEAK IS LINEAR IN THE VORTEX CHANNEL

M4's Theorem 8.1 holds for CONVOLUTION couplings K(UV⁻¹)dUdV (Haar marginals). On ℤ⁴ no pair-conditional law of two coarse links is one:
each link lies in five other plaquettes, whose staples tilt its law. The question "does the blocked action stay in the convolution class"
has two layers. (i) The conditional laws Hypothesis I is stated on: never convolutions, for any action with a nonconstant one-plaquette part
(the tilt a(v_a) = Π_{P∋a, P≠P₀} w′(v_a S_P) is constant only where the five staples cancel); with bonds, not even tilted convolutions. (ii) The
one-plaquette weight's own coefficient sequence (the MK decimation's coupling IS a convolution): there 𝒯 matters, and it is closed under
convolution (M4); whether bond moving's pointwise power preserves 𝒯 is not decided here (Wilson weights trivially; OPEN in general).
Layer (i) is what Hypothesis I needs, and on it the theorem below is the answer.

**Theorem 4.1 (THE TILT LEAK).** Let K be a continuous positive-definite class function on SU(2), K ≥ 0, ∫K = 1, K = Σ_j d_jκ_jχ_j, with
K_e, K_o its integer- and half-integer-spin parts, K′_e := K_e − P₀ (P₀ the constants), κ̃ := sup_{j ∈ ℕ, j ≥ 1}κ_j, κ_odd := sup_{j ∈ ℕ+½}κ_j.
Let a, b be continuous and positive with even/odd parts (under U ↦ −U) a_e, a_o, b_e, b_o, and π(dU, dV) = Z⁻¹a(U)b(V)K(UV⁻¹)dUdV.
(a) THE FOUR-FLIP IDENTITY. The joint law of the SO(3) projections has density Z⁻¹[a_e(U)b_e(V)K_e(UV⁻¹) + a_o(U)b_o(V)K_o(UV⁻¹)].
(b) For even f, g centred under the marginals of π,
  Cov_π(f, g) = Z⁻¹[ ⟨fa_e⟩⟨gb_e⟩ + ⟨fa_e, K′_e(gb_e)⟩ + ⟨fa_o, K_o(gb_o)⟩ ]   (⟨·⟩, ⟨·,·⟩ in L²(Haar), K acting by convolution),
  with ⟨fa_e⟩ = −⟨b_e⟩⁻¹[⟨fa_e, K′_e b_e⟩ + ⟨fa_o, K_o b_o⟩] and ⟨gb_e⟩ = −⟨a_e⟩⁻¹[⟨K′_e a_e, gb_e⟩ + ⟨K_o a_o, gb_o⟩].
(c) With A_e = ‖a_e‖_∞, A_o = ‖a_o‖_∞, A′_e = ‖a_e − ⟨a_e⟩‖_∞ (and B's likewise) and m = inf a · inf b:
  ρ̃(π) ≤ (A_eB_e κ̃ + A_oB_o κ_odd)/m + (A_eB′_e κ̃ + A_oB_o κ_odd)(A′_eB_e κ̃ + A_oB_o κ_odd)/(m⟨a_e⟩⟨b_e⟩).
  The term A_oB_oκ_odd/m — THE LEAK — is LINEAR in the vortex channel κ_odd (= κ_½ in 𝒯), while Turán's term is κ̃ ≤ κ_½².
*Proof.* (a) Average π over the four sign flips (U, V) ↦ (εU, ε′V): with a(εU) = a_e + εa_o, b(ε′V) = b_e + ε′b_o, K(εε′g) = K_e + εε′K_o, exactly
the monomials ε⁰ε′⁰ (a_eb_eK_e) and ε²ε′² (a_ob_oK_o) survive the average. (b) E_π[fg] = Z⁻¹⟨fa, 𝒦(gb)⟩ with 𝒦 the convolution by K; for even f,
g the parity of each product selects a_e(gb_e)K_e and a_o(gb_o)K_o (K_e annihilates odd functions, K_o even ones); split K_e = P₀ + K′_e. The
two centring conditions E_π f = Z⁻¹⟨fa, 𝒦b⟩ = 0 and E_π g = 0 are the stated formulas for ⟨fa_e⟩, ⟨gb_e⟩. (c) ‖K′_e‖ = κ̃ and ‖K_o‖ = κ_odd on
L²(Haar) (Schur: spin-j components are multiplied by κ_j); K′_e b_e = K′_e(b_e − ⟨b_e⟩). Normalise Var_π f = Var_π g = 1: since π_U = Z⁻¹a(K*b) ≥
Z⁻¹ inf a inf b (K ≥ 0, ∫K = 1), ‖f‖₂² ≤ Z/m, and likewise ‖g‖₂² ≤ Z/m. Cauchy–Schwarz term by term, then the supremum over f, g. ∎

**The leak is real (a sighted exact example; z4_leak.awk, record rec/z4_leak.txt, exact rationals).** On Z₄ (centre {0, 2}, quotient Z₂) with
convolution coefficients (1, k₁, k₂, k₁) — k₁ the centre-odd (vortex) characters, k₂ the quotient's — and tilts a = (A, 1, 1/A, 1), b likewise,
the quotient channel is the Pearson correlation of the parities, computed exactly. Known answers MET: untilted, ρ̃ = k₂ and ρ = k₁ exactly.
Tilted (all exact comparisons with k₁²):
| k₁ | k₂ | A = B | ρ̃ (quotient) | ρ (all functions) | ρ̃/ρ² | Turán slaving |
|---|---|---|---|---|---|---|
| 0.1 | 0.01 | 1 | 0.010000 | 0.100000 | 1.000 | holds (edge) |
| 0.1 | 0.01 | 2 | 0.026763 | 0.088988 | 3.38 | FAILS |
| 0.1 | 0.01 | 3 | 0.036743 | 0.075188 | 6.50 | FAILS |
| 0.1 | 0 | 2 | 0.017094 | 0.088889 | 2.16 | FAILS (the leak alone) |
| 0.03 | 0.0009 | 2 | 0.006153 | 0.026669 | 8.65 | FAILS |
The ratio grows as k₁ falls at fixed tilt — linear against quadratic — exactly the mechanism of (c). The record's one-step ordered cells
(ρ_EE/ρ_OO² = 1.85–3.26, M4 §7, marginal E[χ_½(A)] = 0.62: a strong tilt) sit in the same band; its two-step cells (0.07–0.28, E[χ_½(A)] =
0.146: a weak tilt) sit below one. M4's reading "the objects' direct coupling enters a Turán-like regime between the first and second step"
is this theorem: the tilt shrinks.

**SU(2) at first order (labelled: an expansion, not a bound).** With a = exp(½cχ_½(U)), b = exp(½cχ_½(V)) (a Wilson tilt of strength c along a
staple sum) and f = g = χ_1: Cov(χ_1(U), χ_1(V)) = κ_1 + ¼c²(κ_½ + κ_{3/2}) + O(c²κ̃, c⁴), since a_o = ½cχ_½ + O(c³), χ_1χ_½ = χ_½ + χ_{3/2},
and ⟨χ_½ + χ_{3/2}, K_o(χ_½ + χ_{3/2})⟩ = κ_½ + κ_{3/2}. For a Wilson-class K at strong coupling κ_1 ≈ (2/3)κ_½², so slaving (ρ̃ ≤ κ_½²) needs
¼c²κ_½ ≲ ⅓κ_½², i.e. c² ≲ (4/3)κ_½.

**THE ℤ⁴ CONSEQUENCE (first order, labelled).** For a Wilson-like coarse action at β′ the tilt of a link from its five other plaquettes has
c = β′|W|, |W| ≤ 5 the staple sum, and κ_½ ≈ β′/4: sup-form slaving of the pair-conditional laws needs β′|W|² ≲ 1/3, i.e. β′ ≲ 1/75 ≈ 0.013 at
the worst environment (|W| = 5) and β′ ≲ 1/15 ≈ 0.07 at a typical one (|W|² ≈ 5). At the two-step landing couplings (β′ ≈ 0.22–0.29) the
rigorous bound (c) is vacuous (A_oB_o/m = sinh²(5β′)e^{10β′} ≈ 74 at 0.29). **So Turán slaving does not control the SO(3) channel R̃ by the
vortex channel on ℤ⁴ in the window, and does not help (W-S)'s supremum; it holds on untilted convolutions (MK, exact 2D blocking) and returns
on ℤ⁴ only in deep strong coupling (β′ ≲ 0.01), where every criterion closes anyway.** By how much the action leaves the class: by the
odd tilt size A_oB_o/m of its conditional laws — O(25β′²) at small β′ in the sup, O(1) and above at the landing couplings.

---

## 5. THE PER-STEP BUDGET REFRAMED BY THE EXACT STEP: THE TWO-STEP LANDING READ IN THE CERTIFICATE'S OWN CURRENCY

### 5.1 RESULTS — the stakes of §1b graded (records rec/K0.txt, K1.txt, S1.txt, S2.txt, S3.txt, S4.txt; engine read-only from III)

- **K0 MET.** The gate's coefficient-mode pin reproduced byte for byte ("… kappa_U in [0.019543, 0.019543] … u in [0.06233787, 0.06233787]
  u~ in [0.06356816, 0.06356816] r_hi=0.320393 LHS in [0.0000033, 0.0000033] … -> PASS").
- **K1 MET.** COEF (the Bessel ratios at 0.4764 over 10³⁰) with LOCAL=1 and the record's R2TAB reproduces the table mode's own point run to
  every printed digit: κ_U ∈ [0.131404, 0.131411], u = 0.11798946, ũ ∈ [0.13455855, 0.13455957], r_hi = 0.696902, LHS ∈ [0.0043826,
  0.0043833] ≤ α = 0.0044 → PASS. So the coefficient-supplied mode composes with the S24-table grading, and the reach to compare against
  is the table mode's (u* ≈ 0.118 at Wilson's own a_j), not only the page dress's.
- **S1 HELD.** THE RECORD'S OWN TWO-STEP EXIT CALL, AS PRINTED, FAILS at both data and in both dresses: "the dressing iteration leaves
  [0, 3]: no root" (WALL = 0.2998 / 0.3380).
- **S2 HELD.** The same call without WALL PASSes at both data in both dresses (α = 1/1000; LHS 7.9·10⁻⁶ ordered, 1.5·10⁻⁶ cancelling).
- **S3 REFUTED IN SIZE (the threshold is smaller than staked).** The largest passing wall floor is W* ∈ [0.00835, 0.00842] (page, γ = 6)
  and W* ∈ [0.01406, 0.01414] (S24-table), the same at both data (the branch series binds, not u); staked [0.02, 0.05]. The record's floors
  exceed W* by ×36 / ×40 (page) and ×21 / ×24 (table). The floor uses NPAIR = 16 (the bent pairs, priced at the planar object's modes,
  §18): with the FOUR COPLANAR pairs alone — the geometry the object actually read — a′_1 + 4s_one/3 = 0.0756 / 0.0849, still ×5.4 / ×6.0
  above the table mode's W*. **So the two-step landing fails in the record's own exit accounting at the pinned W2L2 objects, on the
  spin-1 creating modes alone, by a factor 5–40 that no choice of bent-pair values removes.**
- **S4 (the vortex pair dressing, LABELLED HYPOTHESIS H1, never a theorem).** H1 at the planar r FAILS at both data in both dresses (stake
  HELD): u = 0.13056 (ordered), 0.17200 (cancelling), "the inequality's upper end is above alpha". The largest passing r (α = 1/1000, WALL
  off, HALF as recorded): **r* = 0.3747 (ordered; page and table alike) against r = 0.3925; r* = 0.6528 (cancelling, page) against r =
  1.0459.** The r* band staked ([0.2, 0.3], [0.4, 0.55]) is REFUTED upward: with a′_1 ten times below Wilson's the certificate reaches
  u ≈ 0.128 at both data. So under H1 the COPLANAR vortex pair alone breaks the landing, narrowly at the ordered datum (×1.05) and by ×1.6 at
  the cancelling one; every closed polymer's adjacent pairs are mostly BENT (a cube's twelve all are), and the bent (½,½) mode is unread (§18),
  so the planar r is a proxy for the number that decides the vortex axis.
- **S5 (arithmetic on M4's readings, HELD).** 20·¼Δ_A = 1.23 / 1.38 (W2L2), 2.66 / 3.13 (W3L2): the single-site TV vortex half is above one
  at two steps on the pinned planar loops, at both caps.

  **Two integrity notes on the reader (w2_modes.awk), found while staking, both bearing on the call.** (a) Its s_one adds, per pair, the
  shares of BOTH the (½,1) and the (1,½) modes, but at a given plaquette p only the mode that puts spin 1 AT p creates a wall there: the
  floor it prints, a′_1 + 16 s_one/3 = 0.2998 / 0.3380, is twice its own convention's count, which is a′_1 + 16·|b̂_{½1}|^{1/2}/3 = 0.150 /
  0.169 (still ×11–12 above the table mode's W*). The sound count over the four coplanar pairs alone is a′_1 + 4|b̂_{½1}|^{1/2}/3 = 0.0383 /
  0.0427: ×2.7 / ×3.0 above W* (table), ×4.6 / ×5.1 (page) — a FAIL that no value of the sixteen unread bent pairs can lift (their shares
  only add). (b) RESULTS 4 (iii) reads "MAX over bonds through p"; the reader SUMS. The maximum, |b̂_{½1}|^{1/2}/3 = 0.0093 / 0.0105, would
  pass the table mode (W* = 0.0141) and fail the page dress (0.0084). The maximum undercounts: in the expansion each bond through p is an
  ALTERNATIVE way to create the wall at p, so the per-plaquette activity is a′_1 plus the SUM of the shares (the geometric-mean split of a
  pair's coefficient between its two plaquettes is the bound RESULTS 4 (d) itself calls conservative). The sum is the sound accounting; the
  gap between sum and max is exactly the open multiplicity question of the pricing-comparison lemma (second read owed by the record).
  And (c): the reader computes s_half = 0.1496 / 0.1793 per pair — the HALF-INTEGER creating shares, the (½,½) mode chiefly — and the call
  consumes it nowhere (HALF carries r_mod, WALL carries s_one). That is the vortex half, unpriced.

### 5.2 What the per-step criterion becomes when the drift is the exact step's

M4's δ < 0.039 per step was the margin of a ONE-SIDED COMPARISON with a flow drifting at one loop's 0.2575 per step over eight steps. With
the exact step there is no comparison flow and no δ_k: the exact two-step object IS the step, and the criterion becomes a TWO-STEP
CERTIFICATE — the fine-integrated two-step blocked action must pass Theorem 8.9's certificate at its own coefficients (the exit lemma,
8bcfffd). The "loss" is then the gap between the measure-weighted blocked action (fine outside integrated, coarse environment sup, M2b's
Theorem A1) and the pinned readings, and the admissible gap is the certificate's room at those readings, which §5.1 measures on three axes:
 (i) the one-plaquette axis: at W2L2 the room is u*/u = 1.61 / 2.12 (table mode, at the record's small a′_1); in coupling units 0.4764 −
   0.292 = 0.18 and 0.4764 − 0.222 = 0.25. **M2b §7.3 has read this axis at sharper caps: β_eff 0.292 → 0.491 → 0.565 (ordered) and 0.222 →
   0.305 → 0.374 (cancelling) at W2 → W3 → W4, cap limits by arithmetic 0.589 / 0.523 — so the one-plaquette room is NEGATIVE at the cap
   limit, by 0.05–0.11 in β: the W2L2 landing numbers are cap artefacts (M2b's words).**
 (ii) the wall axis (spin-1 creating modes): room W*/floor = 1/2.7–1/40 (§5.1): negative at every count.
 (iii) the vortex axis (half-integer pair modes, unpriced by the record): under H1 the room is r*/r (§5.1 S4).
So the per-step criterion with the exact drift reads: the fine-integrated two-step action must satisfy, at once, u ≤ u*(a′_1, WALL, r) ≈
0.118, WALL ≤ W* ≈ 0.014, r ≤ r* — and the pinned readings already violate the second (at every count) and, at the cap limit, the first.

### 5.3 What must be shown about the two-step blocked action for the coefficient-supplied mode to apply (couplings and norms)

All inputs are Peter–Weyl coefficients of the FINE-INTEGRATED two-step blocked action A₂ = −log ℓ₂ — exact scalars, the currency the
pricing-comparison lemma consumes (RESULTS 4 (a)); none is a supremum over fine data; each must hold uniformly in the cutoff and the volume:
 (E1) the one-plaquette weight's a′_j for every spin j, non-increasing, with the tail premise a′_{j+1} ≤ a′_j/8 (the engine refuses by name
   otherwise): read at W2L2 only to spin 1, and not converged in the plaquette cap (M2b);
 (E2) HALF = 1 + Σ_{C∋p} Σ_{integer spin-1 modifying modes} |b̂_C(ρ)| — negligible at the pinned cells (1.005);
 (E3) WALL = a′_1 + Σ_{C∋p} |b̂_C(ρ)|^{1/|C|} over the modes creating spin 1 at p (the sound per-plaquette SUM, one mode per pair) — needs
   ≤ W* ≈ 0.014 (table) / 0.008 (page); read 0.038–0.043 on the four coplanar pairs alone, the sixteen bent pairs unread;
 (E4) THE VORTEX INPUT, absent from the mode: the half-integer pair modes — the (½,½) mode of adjacent coarse plaquette pairs (coplanar AND
   bent) and the (½,1) modes' spin-½ ends — as a two-plaquette coefficient change of spin-½ surfaces (by the record's own (b1): inside a
   branch-free spin-½ surface a pair mode changes coefficients, never representations, so the pair's weight (d a′_½)² becomes (d a′_½)²(1 + r),
   r = b̂_{½½}/(d a′_½)²) — the coefficient-supplied mode needs an input for this matching-polynomial dressing; at the pinned cells r = 0.392
   / 1.046 (coplanar), bent unread;
 (E5) bonds of three or more plaquettes, the relative-orientation (non-class-function) modes, and their summability Σ_{C∋p}(Σ_ρ|b̂_C(ρ)|)
   e^{α|L(C)|} < ∞ at the certificate's α: unread;
and (E0) the fine integration and the coarse supremum themselves (M2b's next instrument: the coarse-conditioned object with the neighbouring
coarse loops imposed by Fourier insertions instead of pinned fine data).

### 5.4 Does (W-V) give the vortex half at two steps? — what it gives, and what the objects read

It gives the vortex half's EXACT FORM and LOCATION: by Proposition 2.5 the vortex free energy is twice the σ-odd part of the blocked action,
so the vortex half of the two-step exit condition is exactly the half-integer content of (E1)–(E4) — the odd one-plaquette coefficients
(a′_½, a′_{3/2}, …) and the half-integer bond modes (E4). By Lemma 2.1 and Corollary 2.3 it is the coarse coupling's odd part, so no fibre
clause supplies it at a_c = 4 (§3): it must be READ on the fine-integrated blocked action. It does NOT give smallness, and on the record's
objects the vortex half is not small in any of the three currencies:
 · single-site TV (Theorem 2.4's label term, M4 §7's Δ_A, loops, planar proxy for the bent pairs): 20·¼Δ_A = 1.23 / 1.38 (W2L2) and 2.66 /
   3.13 (W3L2) — above one (S5's arithmetic, HELD);
 · single-site L² (M4's τ_A): 20τ_A = 0.61 / 0.70 (W2L2), 1.26 / 1.54 (W3L2) — above one at the sharper cap;
 · the certificate under H1: FAIL at the planar r at both data (§5.1 S4).
One exact relation it supplies to M2b: Theorem C1's number, the coarse twist distinguishability, is ‖λ − σ_m*λ‖_TV = ½E_λ|1 − e^{−F_m}| =
½E_λ|1 − ν(B_f|·)| (σ_m*λ has density ℓ(σ_m v) = ℓ(v)e^{−F_m(v)}) — the vortex free energy averaged over the blocked measure. M2b writes that
(W-V) "is what Theorem C1 needs to turn the coarse twist distinguishability into a number"; the flip identity makes that number the λ-mean of
|1 − e^{−F_m}| directly, with no fibre clustering in it and none available (Corollary 2.3, Theorem 3.1).

### 5.5 The per-step budget at couplings 0.45–2.2: the best bound that is proved, and the obstruction, flow by flow

 · THE VORTEX RECURSION ITSELF. Exact, lossless as an identity; proved: sup|F_{k+1}| ≤ sup|F_k| (M4 Prop. 2.2). In M4's one-sided coupling form
   that is δ = c(2): loss 0.2575 per step, no descent. The mixed difference Θ — what (W-V) needs — has no proved monotonicity at all: by
   Corollary 2.2 between scales, Θ^{(k+1)} is the between-scale fibre's response to a coarse centre flip, i.e. the scale-k coarse coupling's
   odd part. **Best proved per-step bound: non-expansion of sup|F|; loss = the whole drift.**
 · A FINITE-GROUP FLOW. Every identity here holds verbatim for Q₈, 2T, 2O, 2I (−1 central; M4 §11); their MK flows are exactly certifiable;
   but a ℤ⁴ step of the shadow is as uncertifiable as SU(2)'s, and the shadow tracks SU(2) only to its design order. It supplies exact
   transfer-matrix readings on finite cross-sections, not a step comparison. Loss: unbounded (no inequality).
 · A CONE OF ACTIONS. Invariance of a cone under one blocking step needs a convergent expansion of the blocking map at the cone's corner;
   the certificate's reach is u ≤ 0.118 (β ≤ 0.4764 at Wilson's a_j), while the window's actions have u up to a_½(2.2) = 0.464. Loss on
   0.45–2.2: undefined (no expansion converges there; the record's §17 item 4).
 · THE OBSTRUCTION, common to all three: inside the window every certifiable flow is either lossless and non-contracting (the identities),
   or contracting and uncomparable with ℤ⁴'s step (MK, shadows: no correlation inequality relates them; the bond-moving sandwich brackets the
   free energy only — "a bracket on Z is not a bracket on the measure"), or comparable only inside the KP disk (cones). The U(1) test does NOT
   forbid a small-loss group-blind comparison — it only demands a loss above U(1)'s hierarchical descent (7.3·10⁻⁵ of β per step at 1.39,
   ~3·10⁻¹³ at 2.83), compatible with 0.039 — so the obstruction is absence, not impossibility: no comparison inequality is known. The exact
   objects are the only step with a drift, they end at two steps (55⁸ states at three, campaign §8), and §5.1 shows their two-step output
   fails the certificate in its own accounting.

---

## 6. WHAT THIS FILE PROVES, COMPUTES, REFUTES, AND LEAVES (written last)

**PROVED (proofs above).** Lemma 2.1, THE FLIP IDENTITY: the twisted fibre over v is the untwisted fibre over σ_m v, pushed by one link's flip.
Corollary 2.2: the vortex mixed difference is EXACTLY ∫[ν(Φ_s|v(s)) − ν(Φ_s|σ_m v(s))]ds — M4's Theorem 4.1 integrand as an equality, with no
twist in it. Corollary 2.3: the response is representative-independent — topological — so (W-V) is not a decay in the twist–probe distance.
Theorem 2.4: THE CENTRE SPLIT OF (8.5) in THE GROUND's currency, C̃ ≤ C ≤ C̃ + ¼Θ (link sites), C ≤ C̃ + 1 − e^{−Δ^Z} (block sites), Θ ≤ Δ.
Proposition 2.5: F_m = −2·(σ_m-odd part of the effective action); only terms containing both links, through their odd parts. Theorem 3.1: the
fibre's one-link coefficient at a free off-path link is ≥ L₁(β)/I₁(β) for each of ≥ 14 neighbours (18 with no staple link gauge-fixed), at
every a_c ≥ 2 — certified 0.735601941590 at β = 2.2, row ≥ 10.30 (≥ 13.24); known answers 4β/(3π) and the root 0.13103 met. Theorem 4.1, THE
TILT LEAK: under single-site tilts the SO(3) channel of a convolution coupling acquires the term A_oB_oκ_odd/m, LINEAR in the vortex channel;
exact four-flip identity a_eb_eK_e + a_ob_oK_o; the Z₄ example exhibits the failure of Turán slaving exactly (ρ̃/ρ² = 2.2–8.7).

**REFUTED.** (1) The route "(W-V) from a fibre Dobrushin condition at β = 2.2 with blocks of side 2–4": the fibre's own one-link row is
≥ 10.3 at every a_c, and the quantity it was to bound does not decay with the twist's distance. (2) Turán slaving as a control of R̃ on ℤ⁴'s
conditional laws in the window: the tilts' odd parts feed the vortex channel in linearly (first order: sup-form slaving needs β′ ≲ 0.013).
(3) The two-step landing in the certificate's own currency at the record's W2L2 objects: the record's exit call FAILS (no root) at both data
and dresses; the sound wall count on the four coplanar pairs alone exceeds the certified threshold W* = 0.0141 (table) by ×2.7–3.0; the
vortex pair under H1 fails at both data; and (M2b) the one-plaquette inversion itself leaves the window at the sharper caps (0.565 / 0.374
at W4, cap limits 0.589 / 0.523). (4) Stakes refuted in size: S3 (W* below the staked band), S4's r* band (above it).

**THE EXACT REMAINING ESTIMATE, WITH ITS FALSIFIER.** (W-V) at the exit is the smallness of the σ-odd part of the FINE-INTEGRATED blocked
action in the currency of the exit used. For the certificate exit two steps from 2.2 it is (E4): the half-integer pair modes — the (½,½) mode
of adjacent coarse plaquettes, coplanar and BENT — priced as the matching-polynomial dressing of spin-½ surfaces, together with (E1) and
(E3): **the fine-integrated two-step action must have u ≤ u*(a′_1, WALL, r) (≈ 0.118–0.128), WALL ≤ W* ≈ 0.014, and pair ratio r ≤ r*
(0.37 at the ordered datum's u, 0.65 at the cancelling's).** Falsifier: the coarse-conditioned (fine-integrated) two-step object reading
WALL > 0.0141 or the bent (½,½) ratio above r* at any coarse environment — then two steps cannot land and a third, beyond every exact
object (55⁸), is required.

**THE NEXT OBJECT.** The bent pair, computed: the engine with the corner plaquettes as internal cycles (§18's instrument: okey consulting
lkey), read at two steps for the (½,½) and (½,1) modes on the COARSE-CONDITIONED object (M2b's next instrument: neighbouring coarse loops
imposed by Fourier insertions, fine outside integrated), with the certificate's coefficient mode extended by one input — the pair
coefficient r of spin-½ surfaces (the matching-polynomial dressing of E4) — so that the exit test reads all of E1–E4 in one call.

**CROSS-FIELD.** (1) THE FIELD MIXES THE CHANNELS: Theorem 4.1 is the gauge form of a Z₂ fact of statistical mechanics — in a symmetry-breaking
field h the even (energy) correlator acquires h² times the odd (spin) correlator; here the staple sum W is literally an external field on the
centre label (h = β′|W|), and Turán slaving is the zero-field statement. (2) THE FLIP IDENTITY IS 't HOOFT'S DUALITY ON THE FIBRE: a closed
't Hooft surface around a link of π_m equals a change of v_m's centre class — the Euclidean form of 't Hooft's labelling of twist sectors by
the centre class of the boundary holonomies (Tomboulis–Yaffe's electric/magnetic flux free energies are its box versions). (3) M2b's Theorem C1
reads, through it, as ‖λ − σ_m*λ‖_TV = ½E_λ|1 − e^{−F_m}|: confinement's indistinguishability of a configuration from its centre-twisted image
IS the blocked-measure average of the conditional vortex free energy, and (W-V)'s Θ is its oscillation form.

---

## 7. DATED ADDITIONS (2026-11-02 07:4x, after the advisor's read, iii-43's scope note and M4R's review; nothing above edited)

**7.1 Precisions to §§2–4 (the advisor's items).**
(a) Theorem 3.1(c), the count: under an axial gauge in direction 4 the four staples of e in the planes (1,2), (1,3) contain no direction-4
link — 4 × 3 = 12 free links; each of the two staples in the plane (1,4) has two direction-4 side links (fixed or not) and one free
direction-1 far link — at least 2 more; ≥ 14 of 18. For each such b the five other staples are set to cancel through THEIR private free
links (distinct from b: two plaquettes through e share only e), so the cancelling configuration and the turn of b's staple are realised at
once. Under M4R's repair of Theorem 4.1 (the complete axial gauge ALONG the coarse paths), every staple link of e is off the paths and free:
row ≥ 18 L₁/I₁ = 13.2408 — M4R's own number (its rec/misc.txt: ≥ 0.9998 at 0.131, ≥ 3.59 at 0.4764, ≥ 13.24 at 2.2), reached on a road
sharing no line with this one (its flip U_j ↦ −U_j negating the sixth staple; here the Struve–Bessel closed form certified in rationals).
(b) Sign convention: F_m = −log ν(B_f|v) = A(σ_m v) − A(v) (M4's); ℓ(σ_m v)/ℓ(v) = e^{−F_m}; P(L_m = +)/P(L_m = −) = e^{F_m}, so
P(L_m = +) = 1/(1 + e^{−F_m}). The two files agree.
(c) Theorem 4.1(c): ⟨a_e⟩, ⟨b_e⟩ in the denominator are the HAAR MEANS of the even parts, not their infima.
(d) The Z₄ table's comparison with the record's one-step cells (ρ̃/ρ² = 2.2–8.7 against 1.85–3.26) is QUALITATIVE: the Z₄ tilt A = 2 is not
the pinned object's marginal; the overlap of the bands illustrates the mechanism and fits nothing.
(e) §6 REFUTED (3) carries its convention: the "×2.7–3.0 above W*" is the sound per-plaquette SUM, one mode per pair at p (each bond through p
is an alternative way to create the wall there); under RESULTS 4 (iii)'s literal MAX the coplanar floor 0.0093 / 0.0105 lies below the table
mode's W* = 0.0141 and above the page dress's 0.0084. "No bent value can lift it" holds under the sum because the sixteen bent pairs' shares
only ADD to it.
(f) M4R's other repairs, adopted here: (W-V) is stated for EVERY coarse site/link with distance weights (§2's Σ_n e^{κ|m−n|} already does;
the blocked measure is not Markov in the coarse variables); M4's Theorem 2.1 averaged-map clause is CONDITIONAL on a cutting set S (§2 uses
the path map only); Theorem 8.1's bracket is [2/3, 1) for one Wilson weight, [(2/3)^m, 1) for m-fold convolutions (§4 uses only the class);
the per-step criterion is not a theorem (§5.5 says the same: no one-sided per-step bound on the ℤ⁴ step is proved; 0.039 is its K = 8
value).

**7.2 THE SCOPE: FOR WHICH G EACH RESULT HOLDS (iii-43's note: the Clay statement is for every compact simple G; G₂, F₄, E₈ are centre-free).**
| result | holds for | centre-free G (G₂, F₄, E₈) |
|---|---|---|
| Lemma 2.1, Cor 2.2, Cor 2.3 (flip identity, exact vortex mixed difference, topological response) | every compact G and every z ∈ Z(G): S_f: U_f ↦ zU_f, B_f^{(z)} = Π_{p∋f} w(z^{±1}U_p)/w(U_p), σ_z: v_m ↦ zv_m (Haar is invariant under central multiplication) | vacuous (z = 1 only) |
| Theorem 2.4 (the centre split of (8.5)) | Z(G) ≠ 1: C̃ ≤ C ≤ C̃ + label term — ¼Θ for |Z| = 2 (SU(2), Sp(n), Spin(2n+1), E₇), 1 − e^{−Δ^Z} on the |Z(G)|-point orbit in general (SU(N): Z_N; E₆: Z₃; Spin(4n+2): Z₄; Spin(4n): Z₂ × Z₂) | C = C̃: the whole of (8.5) is the centre-even channel |
| Proposition 2.5 (F = −2·odd part) | Z(G) ≠ 1 with "odd" read as the nontrivial Z(G)-characters (N-ality k ≠ 0 for SU(N)) | vacuous |
| Theorem 3.1 (the fibre's one-link coefficient; Theorem 4.1's route refuted) | the identification — the fibre's off-path conditionals ARE the bare single-link laws, with independent freely-varying staples — holds for every compact G, so the fibre's one-link row at such a link equals the bare theory's and exceeds one wherever the bare single-link criterion fails; the constant L₁/I₁ (certified 13.24 at 2.2, root 0.13103) is SU(2)'s | HOLDS, and it is centre-blind: it refutes every SUP-FORM FIBRE CLUSTERING ROUTE at the window's fine coupling, for the centre-even channel (W-S) as much as for (W-V) |
| Theorem 4.1 (the tilt leak) | Z(G) ≠ 1 (the four-flip average becomes the average over Z(G) × Z(G): only components with conjugate central characters survive) | no labels, no leak, no slaving: R = R̃ to be bounded directly |
| §5 (the two-step exit in the certificate's currency) | SU(2) (the certificate is SU(2)'s); its CHANNEL-BLIND parts — E1–E5 as Fourier data of the fine-integrated blocked action, the wall threshold, the pair modes — carry to any G once the certificate is written for G | channel-blind exit: the same list without the parity labels |
**Can any step be recast through R̃ alone?** Yes, three: (1) Theorem 3.1 is a statement about the fibre, not about the centre — it bounds
what any fibre-clustering argument can deliver to R̃ at β = 2.2 (nothing in sup form), for every G. (2) The force identity of Corollary 2.2
without σ: d/ds A(v(s)) = −ν(Φ_s|v(s)) holds for every G and turns ANY mixed difference of the effective action — the centre-even one
included — into a fibre mean's response to a coarse rotation; for centre-free G this is the whole of Hypothesis I's influence functional.
(3) The certificate exit (exit lemma, 8bcfffd) is channel-blind; E1–E5 read without parity labels is the exit test for every G. What cannot
be recast: Lemma 2.1, Theorem 2.4, Proposition 2.5, the confinement corollary below — they are the centre's, and for G₂, F₄, E₈ they say
nothing, as they must (the lightest glueball, 0⁺⁺, is centre-even for every G).

**7.3 THE CONFINEMENT SIDE FOR SU(N) — an exact corollary (proved).** For a coarse observable X of N-ality k under σ_z on a coarse link m
(X∘σ_z = e^{2πik/N}X, z = e^{2πi/N}): E_{σ_z*λ}X = E_λ[X∘σ_z] = e^{2πik/N}E_λX, and σ_z*λ has density ℓ(σ_z⁻¹v) = ℓ(v)e^{−F_{m,z⁻¹}(v)}
(Lemma 2.1's computation with z⁻¹ in place of −1), so
  |1 − e^{2πik/N}| · |E_λ X| = |E_λ X − E_{σ_z*λ} X| ≤ 2‖X‖_∞ ‖λ − σ_z*λ‖_TV = ‖X‖_∞ E_λ|1 − e^{−F_{m,z⁻¹}}| .
So every coarse correlation of nonzero N-ality — a fundamental coarse Wilson loop through m, a Polyakov-type line — is bounded by the
λ-AVERAGE of |1 − ν(B_f^{(z)}|·)|, with no supremum over environments: confinement at the coarse scale follows from the vortex free energy
being small ON AVERAGE (Tomboulis–Yaffe's mechanism read on the blocked measure; M2b's Theorem C1 with its number made explicit by the flip
identity). For SU(2), k = 1: |E_λ X| ≤ ½‖X‖E_λ|1 − e^{−F_m}|. Holds for every G with Z(G) ≠ 1 (N-ality replaced by the central character);
vacuous for G₂, F₄, E₈, where no centre-odd observable exists — consistent with their string breaking.
