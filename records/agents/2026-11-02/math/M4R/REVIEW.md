# M4R — THE SECOND READING OF M4/WORK.md ("the window"), 2026-11-02

Second reader, desktop seat; read-only outside this directory. Every computation of this reading is in this directory with its
record (`rec/`). All arithmetic is double precision: these are CHECKS of identities and of readings, not certificates.

**Read in full before any verdict:** math/MATH_BRIEF.md; math/M4_BRIEF.md; M4/WORK.md (all 637 lines, §§0–12); its reader
M4/m4chan.c (all 229 lines), M4/turan_check.c, M4/run_records.sh and every record M4/rec/chan_*.txt, kat_synthetic.txt,
turan_check.txt; THE GROUND §8.3 (III-Yang_Mills source/ground/content4.js lines 66–106: the block map, (8.5), Proposition 8.4,
Hypotheses I and II, Theorem 8.5 and its proof, the MK budget sentence) and Lemma 8.6 (cross/ground_docx.txt 328–337); M2/WORK.md
§§2–5 (Lemma 2.1–Theorem 2.3, Proposition 2.5, Theorem 3.1, Theorem 4.1, Lemmas 5.1/7.1); M2R/REVIEW.md (all 340 lines); M2b/WORK.md
(all 181 lines on disk: §§0–3, Theorem A1 and Corollary A1′ — its §4 (Lemma A2) and §5 (Theorem C1) were NOT on disk at this
reading, so nothing in M4 §12 that leans on Theorem C1 is checked here); van Enter–Shlosman, arXiv:cond-mat/0306362v1 (the copy
M4 downloaded, M4/dl_ves/ves.pdf, read in full; the CMP 255 (2005) version was not available to me).

**Programs and records (this directory):**
- `m4r_reader.c` → `rec/recheck_*.txt`: an independent reader of the record's dumps (see item 8 for what is and is not independent).
- `m4r_lemmas.c` → `rec/lemmas.txt`: Lemma 3.1, Corollary 3.1′, Lemma 3.2 (i),(ii) on 18,000 random finite laws (groups Z₂, Z₃,
  Z₂×Z₂), and the hidden-label instance against Theorem 3.3's converse sentence.
- `m4r_twist.c` → `rec/twist_q8_b0.7.txt`: Theorem 2.1 (a)(b)(c), Proposition 2.2 and Theorem 3.3's identification on a Q₈ lattice
  gauge theory summed EXACTLY (8⁹ = 134,217,728 configurations), each identity beside a sighted control that must fail.
- `m4r_turan.c` → `rec/turan.txt`: Theorem 8.1 and its numbers by roads sharing nothing with M4's series.
- `m4r_misc.c` → `rec/misc.txt`: the per-step arithmetic, the MK budget, and a lower bound on the fibre's Dobrushin row.

Verdict alphabet: HOLDS / HOLDS WITH A REPAIR / CONDITIONAL on <exactly what> / FAILS at <step>.

## Summary of verdicts

| item | verdict | the decisive line |
|---|---|---|
| 1 Thm 2.1 twist identity (path map) | HOLDS (two precisions) | Haar invariance under the central −1 at one free link; Q₈ exact to 1.4·10⁻¹⁶, control 6.9 |
| 1′ Thm 2.1 averaged maps | CONDITIONAL on the cutting set S existing | shown for disjoint path families only |
| 2 Prop 2.2 vortex recursion | HOLDS | tower property; Q₈ exact to 3·10⁻¹²; sup-norm only, no control of the mixed difference |
| 3 Lemma 3.1, Cor 3.1′, Lemma 3.2 | HOLD | 18,000 random laws, worst ratio 0.999997; (ii) loose by ≥ 8× |
| 3′ Thm 3.3 | HOLDS WITH A REPAIR (the converse sentence) | hidden label: R̃ = 0 given the SU(2) environment, 0.36 given the projected one |
| 4 Thm 4.1 | HOLDS WITH A REPAIR (gauge; distance; Lemma W for all z) — its hypothesis is false where the window lives | fibre row ≥ 13.2 at β = 2.2; the bound → 0 as a → 0 at fixed a_c |
| 5 Thm 5.1 | first sentence and (a) HOLD; (b) CONDITIONAL on van Enter–Shlosman Thm 2 for SO(3), d = 4 | written proof there covers U(1), d = 3 only |
| 6 Thm 8.1 Turán slaving | HOLDS WITH A REPAIR (the bracket sentence) | discrete Wilson convolution at 2.2: ρ = κ_½, ρ̃ = κ₁ exactly; the m-fold bracket is [(2/3)^m, 1) |
| 7 per-step criterion | arithmetic HOLDS; as a criterion CONDITIONAL on an unproved one-sided bound; the threshold is not intrinsic | MK from 2.2 meets M4's own cumulative form at K = 7 |
| 8 readings | four cells reproduced to every printed digit by an independent road | the suspected τ-grid defect checked and does not bite |

---

## 1. Theorem 2.1 — the twist identity — HOLDS for the path map; the averaged-map clause is CONDITIONAL

**Line by line.** (a) S flips one free link f: Haar measure is invariant under multiplication by the central −1; a plaquette
contains f at most once, so (SU)_p = −U_p for p ∋ f and U_p otherwise; v_m(SU) = −v_m(U) and v_{m′}(SU) = v_{m′}(U); the
substitution U = SU′ gives E_λ[G∘σ_m] = E_μ[G(v)B_f] = E_λ[G ν(B_f|·)], and coarse Haar invariance under σ_m gives ℓ(σ_m v) =
ℓ(v)ν(B_f|v) a.e. Correct. "Everywhere by continuity": for the path map the bijection (U₁,…,U_n) ↦ (v = U₁⋯U_n, U₂,…,U_n) carries
Haar to Haar ⊗ Haar, so ℓ and the canonical ν(B_f|v) are continuous in v — correct. (b) apply (a) at v and σ_m v. (c) both sides
equal ℓ(σ_m v)/ℓ(v); the δζ′ invariance follows from the substitution U = S_{ζ′}U′ (it preserves Haar and every coarse variable);
more generally E_μ[G B_{δζ}] = E_λ[G∘σ_{par ζ}], so ν(B_{δζ}|v) depends on ζ only through its parities along the coarse paths.
(d) immediate. All correct.

**Two precisions (no change of substance).** (i) The proof uses that f is traversed an ODD number of times by π_m and an even
number (here zero) by every other coarse path; true for THE GROUND's straight corner-to-corner paths (each lies in its own block
B_y — the link midpoints y + (k + ½)μ, k < a_c, are in the half-open cube — and the four paths at y share only the corner), and it
should be written into the hypothesis. (ii) In Theorem 3.3 "η_γ the union of the elementary twists" should read their Z₂-sum
(symmetric difference); union and sum agree when the twisted links share no plaquette, as midpoint links of distinct coarse paths
do. M4's setting fixes a set T of links to 1; with T = ∅ the identity holds verbatim for THE GROUND's ungauged Wilson measure (the
path bijection needs no gauge fixing).

**Averaged maps.** The clause "if S is a set of free links meeting every π_i an odd number of times and every path of every other
coarse variable an even number of times, the same proof gives (a)–(d)" is correct AS A CONDITIONAL. Its existence is not shown.
It exists when the path families of distinct coarse variables are disjoint (a transverse slice of the tube). For smearings whose
families overlap (Bałaban's averaging into neighbouring blocks, APE-type staples) a slice through m's tube is crossed oddly by
neighbouring families as well, and the natural S then flips several coarse variables at once. §1b's "the representative is a
slice whose boundary encloses the whole tube" therefore holds only where S exists. CONDITIONAL on S.

**Exact test** (`rec/twist_q8_b0.7.txt`; Q₈ = {±1, ±i, ±j, ±k}, Wilson weight exp(2β Re q) at β = 0.7, 4×2 torus, tree gauge,
coarse holonomies v_a, v_b of two disjoint two-link paths and v_c of one link, fibre the four (x,1;2) links): (a) for both free
links of path a, max relative deviation 1.4·10⁻¹⁶ and 3.9·10⁻¹⁶ (the path-b twist read as a flip of v_a: deviation 6.9, the
control fires); (c) ν(B_g|v) = 1 for a fibre link g to 6·10⁻¹⁵ and ν(B_{f+δg}|v) = ν(B_f|v) to 6·10⁻¹⁵ (control |ν(B_f|v) − 1| =
2.26); (b) to 2.2·10⁻¹⁶; a two-link twist flips v_a and v_b together to 2.2·10⁻¹⁶ (read as a flip of v_a alone: 2.26).

**Classical / own.** The technique is classical: 't Hooft's twisted boundary conditions (1978–79) and the Z₂ change of variables on
a co-closed set of plaquettes (Mack–Petkova 1979–80; Yaffe 1980; Tomboulis–Yaffe 1985, whose vortex free energy is the
unconditioned ratio Z_twisted/Z). M4's own is the CONDITIONAL form for a block map: the coarse density ratio under a coarse
centre flip equals the fibre expectation of a closed 't Hooft surface, representative-independent. Ready for the paper with
precision (i) written into the hypothesis.

## 2. Proposition 2.2 — the vortex recursion — HOLDS

ν_{k+1}(B_f|v′) = E[E_μ[B_f | c_k(U)] | c_{k+1}(U) = v′] because σ(c_{k+1}) ⊂ σ(c_k); the inner expectation is e^{−F_k}; an average
lies in [e^{−sup F_k}, e^{−inf F_k}] (over the fibre of c). Correct, and verbatim for U(1). Exact test: 3.2·10⁻¹² relative at every
v′ on the Q₈ lattice (scale k = the two links of path a separately; control: the unweighted fibre average misses by 6.9).

**What it does not say.** The non-expansiveness is in sup norm. Theorem 3.3 consumes the OSCILLATION of F in a neighbouring coarse
variable (the mixed difference Δ_{y|z}), and the recursion gives no control of it: changing v′_z changes the conditional law over
the fibre of c, so osc_z F_{k+1} is bounded only by the full range sup F_k − inf F_k on that fibre, not by osc_z F_k. M4 says "it
carries no smallness by itself", which is right; the sentence "per-step sup-loss ZERO" should say that the zero is a sup-norm zero
and that the quantity Hypothesis I needs is not propagated by it. The tower property is classical; the reading of it as an exact
RG for the conditional vortex free energy is M4's. Ready for the paper.

## 3. Lemma 3.1, Corollary 3.1′, Lemma 3.2 — HOLD; Theorem 3.3 — HOLDS WITH A REPAIR

**Lemma 3.1, line by line.** The split f = f̃ + f⊥, f̃ = E[f|X̃]; (1) |Cov(f̃,g̃)| ≤ ρ̃‖f̃‖‖g̃‖; (2) E[f⊥|X̃] = 0 gives Cov(f⊥,g) =
E[Cov(f⊥,g|X̃)], f⊥ is a function of L_X given X̃, so |Cov(f⊥,g|x̃)| ≤ τ_X sd sd, and Cauchy–Schwarz with E Var(f⊥|X̃) = ‖f⊥‖²,
E Var(g|X̃) ≤ 1; (3) symmetric; the two Cauchy–Schwarz steps. All correct (τ_Y may even be taken with X̃ in place of X, since f̃ is a
function of X̃ — a free sharpening). **Corollary 3.1′**: the same split with block norms; ρ_O· ≤ τ_X and ρ_EO ≤ τ_Y are steps (2),(3).
Correct. **Lemma 3.2(i)**: given x̃ the label is binary with P(L = 1|y) = (1 + t)/2, the maximal correlation of a binary variable is
sd(P(L=1|Y))/(P(1−P))^{1/2} = sd(t)/(1 − t₀²)^{1/2}, t₀ is the mixture of the t(x,·), tanh′ ≤ 1. Correct. **(ii)**: χ-bound on the
label law, convexity of χ² in its second argument, r = q_y/q_{y′} ∈ [e^{−2Δ}, e^{2Δ}], Bhatia–Davis. Correct.

**Random-instance test** (`rec/lemmas.txt`; 6,000 laws per group, 1–4 orbits per side, four strength regimes, exact SVD):

| statement | Z₂ | Z₃ | Z₂×Z₂ |
|---|---|---|---|
| ρ / (ρ̃² + τ_X² + τ_Y²)^{1/2} (≤ 1) | 0.999997 | 0.953 | 0.860 |
| ρ / (ρ_EE² + ρ_EO² + ρ_O·²)^{1/2} (≤ 1) | 1 + 6·10⁻¹² | 1.000000 | 1.000000 |
| ρ_O·/τ_X, ρ_EO/τ_Y (≤ 1) | 1 + 3·10⁻¹⁰, 0.99998 | 1.000000, 0.99999 | 1.000000, 0.99999 |
| Lemma 3.2(i) identity, abs. error | 5·10⁻⁹ | — | — |
| τ_X / (¼ osc F cosh(½ max|F|)) (≤ 1) | 0.99956 | — | — |
| τ_X / (2 sinh Δ_X) (≤ 1) | 0.125 | 0.102 | 0.084 |

No counterexample in 18,000 laws (the excesses are rounding). Lemma 3.1 and (i) are nearly sharp; **(ii) is loose by at least a
factor 8 on every instance** (at small Δ, (i) gives ≈ Δ/4 where (ii) gives ≈ 2Δ). Theorem 3.3 uses (ii) for Γ_y = Z₂⁴, so its
sufficient condition overpays by that factor; a quantitative remark, not a defect.

**Theorem 3.3.** The first display and "R̃ ≤ R ≤ (R̃² + T² + T′²)^{1/2} ≤ R̃ + T + T′" hold: Lemma 3.1 applied to λ(dv_y, dv_z | ξ)
(density ∝ ℓ, Haar reference, Γ_y = Z₂⁴ free on SU(2)⁴), Lemma 3.2(ii), and F_γ = log ℓ(v) − log ℓ(γv) = −log ν(B_{η_γ}|v) by
Theorem 2.1(a) link by link (telescoping). The identification Δ_{y|z} ≤ Δ_{yz}(A), THE GROUND's mixed difference restricted to the
pairs (v_y, γv_y), is correct. On the Q₈ lattice the label free energy of the conditional law equals −log ν(B_f|v) to 2·10⁻¹⁶ at
every environment and the inequality holds (worst ratio 1.000000: at the six non-central v_c the label decouples, τ = 0, ρ = ρ̃).

**The repair — the converse sentence.** "Conversely, Hypothesis I-L² for v implies it for the SO(3) projections (R̃ ≤ R)" is true
for R̃ AS DEFINED IN THE THEOREM — the SO(3)-channel correlation conditioned on the full SU(2) environment ξ. It is false if read as
Hypothesis I-L² for the projected blocked measure (the law of ṽ, conditioned on the projected environment ξ̃): conditioning on
less is a mixture over the hidden labels of ξ, and a mixture can create correlation. Instance (`rec/lemmas.txt`, last line):
three sites, each X = {2 orbits} × Z₂; the label of w uniform; given it, the orbits of y and z are independent with
P(o = 0) = 0.8 or 0.2; every other label uniform. Given the full v_w, (v_y, v_z) are independent: ρ = 0, R̃(y,z) = 0. Given only
the orbit of w, ρ(ṽ_y, ṽ_z) = 0.36 exactly. Repair: "conversely, R̃ ≤ R, so the weighted row sums of the SO(3)-channel correlations
conditioned on the SU(2) environment are bounded by those of R" — and nothing about the projected measure.

Classical: Cauchy–Schwarz, Bhatia–Davis (2000), convexity of χ². M4's own: the decomposition of (8.5)'s L² form (M2) into the
SO(3) channel and the vortex sensitivity, with the vortex half identified as THE GROUND's mixed difference on centre orbits.
Lemma 3.1, Corollary 3.1′, Lemma 3.2 ready as stated; Theorem 3.3 ready with the converse sentence repaired.

## 4. Theorem 4.1 — HOLDS WITH A REPAIR; its hypothesis is false where the window lives

**The force identity is right.** For a coarse link m′ at z, the map U_{f′} ↦ e^{sX′}U_{f′} is a Haar-preserving bijection of the
fine field carrying the fibre over v to the fibre over v(s) = (e^{sX}v_{m′}, rest), so d/ds log ℓ(v(s)) = E_{ν(·|v(s))}[Φ_s]; since
ℓ(σ_m v) = ℓ(v)ν(B_f|v) and the fibre measure over σ_m v is the push-forward under S of the twisted measure ν^f over v, and Φ_s∘S =
Φ_s when f′ lies in no plaquette through f, d/ds log ℓ(σ_m v(s)) = E_{ν^f(·|v(s))}[Φ_s]; hence |F_m(v′) − F_m(v)| ≤ ∫₀^{s₁}|E_{ν^f}Φ_s −
E_νΦ_s| ds with |Φ_s| ≤ 6β. The Dobrushin comparison (Georgii Thm 8.20: |ν^f(Φ) − ν(Φ)| ≤ Σ δ_j(Φ)D(j,i)b_i, b_i ≤ 1 on the sites
where the specifications differ, D ≤ e^{−κ_f|·|}/(1 − α_f)) and the arithmetic 4 links × π × 12β × 19² give 48πβ·19²; multi-link
flips at y telescope. All correct up to the following.

**Repairs.** (i) X′ = P⁻¹XP with P the product of the links of π_{m′} before f′. In a general gauge P depends on fibre coordinates,
so Φ_s depends on them and δ_j(Φ) ≠ 0 for those j — the sum over j ∈ L(f′) (19 sites) misses up to a_c sites. Repair: state the
theorem in the complete axial gauge along each coarse path (every link of π_m gauge-fixed to 1 except its midpoint link, which IS
v_m; a forest, so a legitimate gauge, and THE GROUND's "remaining links in a fixed gauge" admits it): then P = 1, X′ = X, the fibre
specification is local, and the constant stands. Otherwise the constant becomes 19·(19 + n_{f′}), n_{f′} ≤ a_c. (ii) The exponent
should carry the distance between L(f) and L(f′), not between L(f) and the paths at z (r − 1 in place of r). (iii) **Lemma W (W-V)
is required "for every coarse site z adjacent to y", but its conclusion sums T(y,z) over every z.** The blocked measure is not
Markov in the coarse variables, so R(y,z) and T(y,z) are nonzero at every distance. Repair: require (W-V) for every z ≠ y with a
distance-dependent δ_V(y,z) and put Σ_z (δ_S(y,z) + 2 sinh 16πδ_V(y,z) + 2 sinh 16πδ_V(z,y)) e^{κ|y−z|} ≤ α in the conclusion
(under the fibre Dobrushin condition Theorem 4.1 itself supplies the decay in |y − z|).

**The hypothesis.** Two facts change what the theorem buys. First (provable, and the one to lead with): with κ_f in fine-lattice
units and r = a_c/(2a) − 1, the bound e^{−κ_f r} tends to zero as a → 0 at fixed physical a_c, so a fibre Dobrushin condition
uniform in the cutoff would force the vortex sensitivity of the PATH map to vanish in the continuum limit — which is M2R's
structural fact (item 4 there: bare path holonomies of fixed physical length become asymptotically Haar-independent; UV
instability), not a smallness of the window. Second, with single-link sites the hypothesis is false at every fine coupling the
window uses: the conditional law of a link is vMF on S³ with parameter β Σ_p S_p; take five staples summing to zero and the sixth
equal to e; flipping the neighbour link U_j ↦ −U_j negates the sixth staple exactly (−1 is central), so the parameter moves from βe
to −βe and C(i,j) ≥ TV(vMF(βe), vMF(−βe)) for each of the 18 neighbours — an exact bound, not an approximation. `rec/misc.txt`: the row
sum is ≥ 0.9998 at β = 0.131, ≥ 3.59 at 0.4764, ≥ 13.24 at 2.2 (the record's linear upper bound 18·4β/(3π) reads 1.0008, 3.64,
16.81 — the single-link disk 3π/72 is sharp to three digits). THE GROUND's own remark that no block criterion of Dobrushin–Shlosman
kind gains on the single link (first-order transmission) closes the blocked-sites escape on the record's present tools. So the
explicit constants are vacuous in the window; the theorem's content is the exact force identity, which reduces the vortex half to
the twisted-fibre response of (W-V) — and that is the form that should enter the paper, as a lemma, with (W-V) as the stated
hypothesis. Classical: Dobrushin's comparison theorem (Dobrushin 1970; Georgii 2011, Thm 8.20) and the Feynman–Hellmann
derivative; M4's own: the reduction of the odd half of Hypothesis I to a twisted-fibre response.

## 5. Theorem 5.1 — the no-go — first sentence and (a) HOLD; (b) CONDITIONAL; Theorem 5.2 HOLDS

**First sentence.** w(−U) = w(U) gives B_f ≡ 1, F ≡ 0, the label independent of everything given the orbits, τ ≡ 0, and Lemma 3.1
gives ρ = ρ̃ exactly. Correct (the Q₈ test shows the same collapse at its non-central environments). **(a)** At the level of laws it
is immediate, as M4 says (lift any law of the orbits with uniform independent labels); its gauge-theory instance is (b).

**(b), what it imports.** From van Enter–Shlosman exactly one thing: a coupling J_t at which the free energy of the SO(3) model
with plaquette weight exp(J((1 + tr R(U_p)/3)/2)^p), p large, d = 4, is not differentiable. In the copy I read (arXiv v1, 2003;
not the CMP 2005 version), Theorem 2 states first-order transitions for "lattice gauge models with plaquette action ((1 + L(U_P))/2)^p
… in dimension 3 and more and p high enough", the variables being "elements of a unitary representation of a compact continuous gauge
group, e.g. U(1), SU(n), or sums thereof"; the WRITTEN proof treats only "the simplest case of a U(1)-invariant interaction in 3
dimensions" with a square-well toy potential, the general case asserted. As printed, L(U_P) = Tr(U_P + U_P*) is unnormalised (for
SO(3) it ranges over [−2, 6], so (1 + L)/2 is not in [0, 1]); the normalised reading M4 uses, L = tr R/3, is the one their proof
uses — a deep narrow well at the identity — and the action stays reflection positive (a polynomial in χ₁ with positive
coefficients has nonnegative character coefficients), which the chessboard estimates need. SO(3) in d = 4 is inside the class
they state, outside the case they prove in writing. The rest of (b) is correct: Z_SU(2) = Z_SO(3) (Haar pushes forward to Haar);
uniform I-L² and II-L² on a neighbourhood would give, through M2's Theorem 3.1, |Cov(E_p,E_q)| ≤ Kρ₁^{d(p,q)} uniformly, hence a
bounded specific heat, convex finite-volume free energies with f″ ≤ C, Arzelà–Ascoli on f′, and a C^{1,1} limit — contradicting
non-differentiability at J_t. CONDITIONAL on van Enter–Shlosman's Theorem 2 holding for G = SO(3), d = 4 (and on M2's Theorem 3.1,
graded HOLDS as a conditional theorem by M2R).

**Theorem 5.2** (U(1)): the twist identity for every e^{iα} is Theorem 2.1's proof with e^{iα} central; correct. Its last clause
uses M2's Theorem 4.1 for U(1) and inherits M2R's grade there: CONDITIONAL on extracting a non-exponential coarse correlation from
Fröhlich–Spencer for the given action in the torus-limit state (rigorous in their range), numerical at β = 1.2; M2R also notes the
Guth / Fröhlich–Spencer attributions are reversed in action type. The Gaussian-level remarks (π-flux scale-invariant in 4D, no
running for U(1)) are heuristics, labelled so.

## 6. Theorem 8.1 — Turán slaving — HOLDS WITH A REPAIR of one sentence

**Line by line.** (a) For a class function K, ∫K(g)D^j(g)dg commutes with D^j, so by Schur it is κ_j·I, and E[f(U)|V] = ∫K(g)f(gV)dg
= κ_j f(V) on the spin-j isotypic span; centre-even = integer spin. Correct. (b) log-concavity ⇒ ratios nonincreasing ⇒
κ_{n/2} ≤ κ_½ⁿ. Correct. (c) convolution multiplies coefficients; products of positive log-concave sequences are log-concave; for
Wilson's weight e^{β cos θ}, c_j = I_{2j} − I_{2j+2} = (2d_j/β)I_{d_j}, so κ_j = I_{2j+1}/I₁ (checked by hand); log-concavity of n ↦ I_n by
the product formula (Watson §5.41): the k-th coefficient of I²_{n+1} − I_nI_{n+2} is [(2n+2+2k)!/(k!(2n+2+k)!)]·[1/((n+k)!(n+1+k)!)]·
[1/(n+1+k) − 1/(n+2+k)] > 0. Correct; at n = 1 this is exactly the coefficient (4+2k)!/(k!(4+k)!(2+k)!(3+k)!) THE GROUND prints in
Lemma 8.6, which does use I₂² ≥ I₁I₃ for φ″ ≤ ¼ — "the same inequality, twice" is accurate. (d), (e) correct.

**Numbers** (`rec/turan.txt`): κ_½ and κ₁ by DIRECT quadrature of the character integrals equal I₂/I₁ and I₃/I₁ (from the integral
I_n = (1/π)∫e^{β cos t}cos nt) to nine digits at all eight couplings; κ_½(2.2) = 0.464479025; all eight ratios κ₁/κ_½² and the U(1)
ratios agree with M4's six-digit values (max deviation 4.9·10⁻⁷, rounding). Log-concavity margins by Miller's backward recurrence
(a third road): positive for every n ≤ 40 and β ∈ [0.01, 30] (minimum 0.019). And Theorem 8.1(a) on a DISCRETE law: the Wilson
convolution K(UV⁻¹) at β = 2.2 on a 2,800-point centre-symmetric rule reads ρ = 0.464479025 = κ_½ (four-fold), SO(3) channel
0.155492681 = κ₁, ρ_OO = κ_½, ρ_EO = 0 — exactly the theorem.

**The repair.** "The strong-coupling limit 2/3 and the weak-coupling limit 1 bracket every Wilson convolution" holds for a SINGLE
Wilson weight (I₃I₁/I₂² is nondecreasing in β, range [0.66667, 0.96674] on [0.01, 30]); for an m-fold convolution the ratio is the
m-th power, so the bracket is [(2/3)^m, 1): the two-fold convolution at β = 0.01 reads 0.444. Also unproved here: "convolution
couplings are the direct couplings of exact two-dimensional blocking and of the Migdal–Kadanoff decimation step" — an aside; the
4D objects' direct couplings are not convolution couplings (non-Haar marginals; their one-step ordered cells violate the slaving,
1.85–3.26), so the theorem says nothing about them, which M4 states. Classical: Peter–Weyl/Schur (convolution operators diagonal on
isotypic components) and the Turán inequality for I_ν (Thiruvenkatachar–Nanjundiah 1951); M4's own: the centre-channel reading
(vortex = half-integer, SO(3) = integer) and the slaving statement for the Turán class. Ready with the bracket sentence repaired.

## 7. The per-step criterion (§1b, §9) — arithmetic HOLDS; as a criterion CONDITIONAL; the threshold is not intrinsic

**Arithmetic** (`rec/misc.txt`): c(2) = 8b₀ ln 2 with b₀ = 11/(24π²) is 0.257512 (M4 writes 0.25752, a last-digit slip); the
admissible uniform loss c(2) − 1.75/K is 0.038762 at K = 8 (M4: < 0.039) and 0.007512 at K = 7 (M4: < 0.008); the rung-1
discrepancy 2.34 − (2.2 − c(2)) = 0.3975 (M4's corrected 0.40; the first-written 0.66 was wrong and is corrected in the file).

**What the criterion is.** (i) It is a sufficient condition under a hypothesis nothing proves: a one-sided per-step bound
β_eff(k+1) ≤ β_eff(k) − c(2) + δ_k for the TRUE ℤ⁴ blocked action. If δ_k is read off any flow, Σ_k (c(2) − δ_k) telescopes to
β(0) − β(K): the whole content is the one-sided bound. "Equivalently on the effective coupling" (vortex free energy ⟺ β_eff) is a
one-loop / Wilson-form identification, and Proposition 2.2 supplies no one-sided bound (sup-norm non-expansive only). (ii) The number
0.039 is not intrinsic: it is c(2) − 1.75/K at K = 8, and K is free — 0.0825 at K = 10, 0.170 at K = 20, 0.240 at K = 100, tending to
c(2) = 0.2575 (one loop needs 6.8 steps at zero loss). K = 8 is borrowed from the certified MK descent's entry into the single-link
Dobrushin disk (B₈ ∈ [0.033549, 0.033598] from 2.2, i.e. β_MK(8) ≈ 0.0044), a different exit from β_exit = 0.45. (iii) "The record's
hierarchical comparison fails this at rung 1" refutes only the UNIFORM version: by M4's own cumulative form the MK flow from 2.2
passes at K = 7, since B₇ ≤ 2.0791 (THE GROUND) and B_k ≥ (24/π)β_k give β_MK(7) ≤ 0.272, so Σ_{k<7}(c(2) − δ_k) ≥ 1.928 ≥ 1.75
(from 2.3 the bound reads β_MK(7) ≤ 0.647, β_MK(8) ≤ 0.0369: the pass there is at K = 8). And
MK steps are not one-sided bounds on the ℤ⁴ flow (the bond-moving sandwich bounds the free energy, MATH_BRIEF), so δ = 0.40 is a
discrepancy against one loop, not the loss of a valid bound. (iv) "Refuses U(1) by construction" is put in by the one-loop drift: the
same form refuses massive U(1) at β = 0.9 too. (v) The ℤ⁴ drift readings 0.31–0.55 per step are holonomy-path-map readings at one
datum; by M2R's item 4 their fall includes the Wilson-line self-energy of the path map, so they are not readings of running. Verdict:
the arithmetic HOLDS; the criterion is CONDITIONAL on the unproved one-sided per-step bound, with admissible loss c(2) − 1.75/K for
whatever K the exit takes; it is not a theorem and should not enter the paper as one.

## 8. The readings (§7) — four cells reproduced independently, to every printed digit

**What is independent.** `m4r_reader.c` uses none of the engine's Dsub, M2's l2dob.c or M4's real Peter–Weyl basis. At the ORDERED
datum (every outside link 1) the law of (A, B) is invariant under simultaneous conjugation, so its moment tensor is Σ_k (f_k/d_k)P_k
in ANY basis, and p(A,B) = Σ_{a,c,k}(d_a d_c/d_k) f^{ac}_k tr[P_k(D^a(A) ⊗ D^c(B))] is fixed by the dump's PRINTED SCALARS alone
(W2-CLASS moments, W2-CHANNEL coefficients), Φ_k being basis-free. My D¹ is the 2×2 quaternion matrix, D² the rotation q·q*, P_k by
group averaging on my own rule (idempotent, hermitian, trace d_k to 10⁻¹²); maximal correlations are singular values of the
DISCRETE law π_ij = w_iw_j p(U_i,V_j) on a centre-symmetric product rule (θ Chebyshev-2, z Gauss–Legendre, even azimuth — nodes
unlike M4's), by subspace iteration; the marginal pair is checked to be the top singular pair (to 2·10⁻¹⁶), the row sums against
p_A to 10⁻¹⁴; the SO(3) channel on the quotient by U ↦ −U; the O-blocks in a per-pair (e_p, o_p) basis. What is NOT independent is
the mathematics of the maximal correlation itself (the discrete second singular value reduces to the same ‖Φ_A^{1/2}GΦ_B^{1/2}‖ in the
limit) and, for U(1), the moment convention (a sign flip would be the bijection φ ↦ −φ, invisible to every quantity read).

| cell | quantity | M4 (rec/chan_*) | M4R (rec/recheck_*) |
|---|---|---|---|
| SU(2) 2.2 one step W2L2 ordered | ρ, ρ_EE, ρ_OO | 0.081207503, 0.009661687, 0.072364560 | 0.081207503, 0.009661687, 0.072364560 |
| | ρ_EO, ρ_O·, ρ_oo^PW | 0.025160395, 0.076611386, 0.079003091 | 0.025160395, 0.076611386, 0.079003091 |
| | τ_A = τ_B | 0.178155218 | 0.178155223 (sup at θ = π/2) |
| SU(2) 2.2 two steps W2L2 ordered | ρ, ρ_EE, ρ_OO, ρ_oo^PW | 0.015210922, 0.000029625, 0.015192554, 0.015101791 | 0.015210922, 0.000029625, 0.015192554, 0.015101791 |
| | τ_A = τ_B; exact block bound/ρ | 0.030379025; 1.0000003 | 0.030379025 (sup at θ = π/2); 1.0000003 |
| U(1) 1.2 one step ordered | ρ, ρ_EE, ρ_OO, ρ_O·, τ | 0.204193924, 0.028933711, 0.179354415, 0.191105651, 0.312206287 | identical to nine digits |
| U(1) 1.2 two steps ordered | ρ, ρ_EE, ρ_OO, ρ_O·, τ | 0.120240908, 0.000737625, 0.119762669, 0.120001033, 0.166399215 | identical to nine digits |

So the per-step factors at the ordered datum (SU(2) ρ_OO ×0.210, ρ_EE ×0.0031; U(1) ×0.668, ×0.0255) are reproduced, and the
known answers M4 lists are met on my road too. **Boundary of the recheck:** the SU(2) cancelling and Haar-random cells were NOT
rechecked — the convention-free route needs the SU(2)-invariant (ordered) datum, and those laws are only U(1)-invariant or not
invariant at all, so reading them would need the engine's D-matrix convention, which this road avoids; of the ordered SU(2) cells
only the W2L2 pair (one step, two steps) was run, and of the U(1) cells the two at β = 1.2, ordered.

**A suspected defect, checked and withdrawn.** M4's τ rule (degree 16, θ = kπ/10) does not contain U = ±1, and on it the leading
mode εχ_½χ_½ reads 2.69, not 2√2; I suspected the S4 remark ("the price of the ess sup, measured at exactly the leading mode's
2√2") read a grid lower bound. It does not: for these objects r(θ) = ρ(L, other | orbit) peaks at θ = π/2, which M4's rule contains
(k = 5), while r(0) is only 0.0151 (one step) and 0.0160 (two steps) — at U = ±1 the non-Haar marginal nearly fixes the label. The
two-step τ/ρ = 1.997 per label (one step: 2.19) has a simple explanation: to leading order in the coupling, with near-Haar
marginals, a spin-½ ⊗ spin-½ coupling Σ C_{μν}(2U_μ)(2V_ν) has ρ = ‖C‖ and τ = sup_{U∈S³}|Cᵀ(2U)| = 2‖C‖, attained along C's top
singular direction — spatial here (θ = π/2; W2-CHANNEL f₀/E = −0.14 against the product form's 0.25, so the coupling is far from
χ_½χ_½), temporal (θ = 0, off M4's rule) for χ_½χ_½. The reader's own singular values confirm it at two steps: ρ = 0.015210922
three-fold (the spatial directions), the next 0.008008346 (the temporal one); r(π/2) = 0.030379 = 1.997 × 0.015211 and r(0) =
0.015990 = 1.997 × 0.008008. Correction to the remark: "2√2, the leading-order value for every spin-½ bilinear coupling", not "the
leading mode's" (which on M4's own rule reads 2.69).

**Two labels to keep.** M4's readings are of LMAX-truncated laws at one datum, planar geometry (M2R's caveat: neither upper nor lower
bounds of the object's ρ). And §7(4)'s "the SO(3) half IS the outside-mediated covariance" is a conjecture with a physical reason
(glueball exchange through the fibre), not a reading: no pinned object reads it, as M4 says one line later.

## What is classical, and what is M4's own

Classical, with sources: 't Hooft's twist (1978–79); the co-closed Z₂ change of variables (Mack–Petkova 1979–80; Yaffe 1980;
Tomboulis–Yaffe 1985); the tower property; Cauchy–Schwarz, Bhatia–Davis (2000), convexity of χ²; Dobrushin's comparison theorem
(Dobrushin 1970; Georgii Thm 8.20); the Feynman–Hellmann derivative; Peter–Weyl and Schur orthogonality; Turán's inequality for the
modified Bessel functions (Thiruvenkatachar–Nanjundiah 1951; Watson's product formula) — the same inequality as THE GROUND's Lemma
8.6; van Enter–Shlosman's first-order transitions (imported, item 5); b₀ (Gross–Wilczek, Politzer 1973) inside c(2); and, through M2's
Theorem 3.1 which M4 consumes in Theorems 3.3 and 5.1(b), Seneta's bound of the subdominant eigenvalue by Dobrushin's coefficient
(M2 Prop. 2.5) and Kassabov's subspace-arrangement theorem (2011, the tensorization half of M2's Theorem 2.3; the bilinear decay form is
M2's, per M2R).

M4's own: the conditional twist identity for a block map; the exact vortex recursion for blocked densities; the two-channel
decomposition of Hypothesis I-L² (Lemma 3.1, Corollary 3.1′, Theorem 3.3) with the vortex half identified as THE GROUND's mixed
difference restricted to centre orbits; the force-identity reduction of the odd half to a twisted-fibre response; the centre-blind
no-go assembled from van Enter–Shlosman and M2's Theorem 3.1; the centre-channel reading of Turán slaving; the channel reader and
its readings (reproduced here).

## Ready for the paper

As stated: Theorem 2.1 for the path map (with the odd-traversal hypothesis written), Proposition 2.2, Lemma 3.1, Corollary 3.1′,
Lemma 3.2. With one-sentence repairs: Theorem 3.3 (the converse), Theorem 8.1 (the m-fold bracket). After repair and recast:
Theorem 4.1 as the force-identity lemma in the axial gauge along coarse paths, with (W-V) for every z as its hypothesis; its explicit
fibre-Dobrushin constants are vacuous in the window. Conditional: Theorem 5.1(b), on van Enter–Shlosman's Theorem 2 for SO(3), d = 4;
Theorem 2.1's averaged-map clause, on the cutting set. Not a theorem: the per-step criterion.
