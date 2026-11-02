# M4 — THE WINDOW: THE CENTRE SPLITS THE COARSE COUPLING INTO A VORTEX HALF AND AN SO(3) HALF

Proof agent M4, 2026-11-02 (desktop; read-only in both repositories; everything here is in this directory). Appended as the
work proceeds; nothing above a line is edited after it is written except by a dated correction.

## 0. Sources read in full before deriving

MATH_BRIEF.md; M4_BRIEF.md; cross/ANSWER.md; M2/WORK.md (all 507 lines: Theorem 2.3, Theorem 3.1 = Theorem 8.5-L², Theorem 4.1,
Lemmas 5.1, 7.1, 7.2); M2R/REVIEW.md; THE GROUND (cross/ground_docx.txt lines 196–430: Theorem 7.1, Lemma 7.3, Theorem 7.4,
Propositions 8.1–8.4, Hypotheses I and II, Theorem 8.5 and its proof, the remarks after it, Theorems 8.7 and 8.9, the open
part); III-Yang_Mills OPEN/ledger/d2-the-centre-route.md (all 161 lines: Tomboulis 0707.2179, Ito–Seiler, the matching
obstruction "a bracket on Z is not a bracket on the measure"); OPEN/ledger/typical-boundary.md; OPEN/the-far-shore.md §§4–9;
OPEN/the-crossing-campaign.md §§14–17 (C_ω on the two-face object, §15 CORRECTED, §16, §17); M2's reader l2dob.c (the dump
format W2-FHEAD / W2-F, the engine's representation convention Dsub/rep, the product rule). Literature checked this session:
van Enter–Shlosman, CMP 255 (2005) 21–32 (cond-mat/0306362): first-order transitions for sufficiently nonlinear lattice gauge
models with compact continuous gauge groups in d ≥ 3, free energy not differentiable at some temperature (read through ar5iv:
the action ((1 + L(U_p))/2)^p with L the normalised real trace); Heller, hep-lat/9508009 (SU(3) fundamental–adjoint plane: the
0⁺⁺ glueball mass decreases toward the endpoint of the bulk first-order line while the other glueball masses are unchanged,
with implications for scaling along the Wilson axis); Grady, hep-lat/0404015 (SU(2): the endpoint argued tricritical, the
transition continuing as a second-order bulk line toward the Wilson axis — a claim, read at the abstract). The literature
search tool (alphaXiv) was not connected; the web search was used.

## 1. The deep-think synthesis (before any derivation; the decision this file executes)

**What I expected to do.** Route 1 of the brief: bound the coarse coupling by the decay of the Z₂ vortex free energy and so
obtain Hypothesis I (the gap) from the centre, which is group-dependent by construction.

**What changed my mind (first principles + the physics of the two channels).** L² of a coarse holonomy splits under the centre
Z₂ (v ↦ −v) into the centre-ODD functions (half-integer spins) and the centre-EVEN ones (integer spins = functions of the SO(3)
projection). A coarse centre flip is implemented EXACTLY by flipping one fine link (Haar invariance), so the odd channel is
governed by an exact free-energy object — the fibre expectation of a closed 't Hooft surface (§2). The even channel is not
touched by the centre at all: a centre-blind action (any adjoint/SO(3) action) has identically vanishing odd sensitivity at
every scale while its SO(3) channel can be critical; and in nature the light direction of the SU(2) crossover is the scalar
0⁺⁺ — centre-EVEN — channel made light by the nearby endpoint of the fundamental–adjoint bulk line (Heller; Bhanot–Creutz;
Grady). At the coarse scale the odd channel decays like the string area exp(−σ a_c²) and the even like glueball exchange
exp(−m a_c), so for large a_c the even channel DOMINATES. Hence: the centre buys exactly the odd half of Hypothesis I, and the
gap's bottleneck at the crossover is the other half.

**Decision.** Prove the strongest true statement linking the vortex free energy to Hypothesis I-L² — a two-channel theorem —
with its exact identities, its sharpness (no-go for the even channel), its fibre form (the odd half is a Hypothesis-II
statement about a twisted fibre), and its U(1) form; measure on the record's exact two-face objects how the coupling divides
between the channels (stakes first); name the window's core lemma in its exact minimal form. Runner-up rejected: the cone
(route 2) — its perturbation budget is M1's exit-budget run, and its landing condition is the crossover itself; chessboard
pricing (route 3) — coarse compound events cost as much to price as the coarse marginal itself (§8 says why), so it has no
consumer until M2b's hypercontractivity lands. Not duplicated: M2b (hypercontractivity, W4, outside-mediated variance), M1
(S12), M3 (Bałaban), d2 (Tomboulis's matching, already convicted).

**Kill-switches.** (K1) the coarse flip NOT implementable as a fine change of variables for THE GROUND's block map (it is: the
coarse paths' links are free variables, and distinct coarse paths share no fine link — checked in §2); (K2) a known answer of
the channel reader failing (then no reading is quoted); (K3) the exact objects showing the EVEN channel comparable to the odd
one at two steps — that would not kill anything, it would confirm the bottleneck at the objects' reach.

**Confidence.** High on §§2–5 (proofs on the page). Medium on the physics claim that the even channel binds at the crossover
(lattice Monte Carlo, labelled). The computation (§6–7) is a reading on truncated objects at fixed data, labelled as such.

## 1b. THE ORCHESTRATOR'S CRITERION APPLIED TO ROUTES 1 AND 2 (iii-43's message of 2026-11-02; answered before the derivation)

The criterion (iii-43): hierarchical U(1) confines at every coupling (Ito 1985), so any chain whose steps hold uniformly in
depth confines U(1) wherever its hierarchical flow reaches the disk; the group difference must live in a step whose loss
ACCUMULATES with the number of blocking steps — SU(2) from 2.2 needs 8 certified steps, U(1) at 1.2 tens of thousands — and
a ×16-per-step loss (the sandwich) kills both, a zero loss confines both. Name the step and its per-step loss.

**Route 1 (the centre). Its own steps lose NOTHING — so by the criterion they cannot carry the group difference, and they do
not claim to.** Two exact facts (proved in §2):
(i) the twist identity: at every scale k the blocked density's ratio under a coarse centre flip is the fibre expectation of a
closed 't Hooft surface, ℓ_k(σv)/ℓ_k(v) = ν_k(B_η | v) =: e^{−F_k(v)};
(ii) THE VORTEX RECURSION, exact: for composable holonomy block maps (the straight path of 2^{k+1} fine links is the
concatenation of two of 2^k), e^{−F_{k+1}(v′)} = E_{λ_k}[ e^{−F_k(v)} | c(v) = v′ ] — the coarser vortex ratio is the
conditional AVERAGE of the finer one (tower property of the fibre expectation, the coarse flip being the flip of either
constituent link). Hence sup|F_{k+1}| ≤ sup|F_k|: non-expansive, per-step sup-loss ZERO, per-step sup-gain ZERO.
Both hold verbatim for U(1) (flip by −1 ∈ U(1), or by any e^{iα}). So the centre is lossless bookkeeping: it moves the odd
half of the coupling into an exactly-recursing free-energy object; it does not make it small. **What must make it small is
the per-step CONTRACTION of the vortex free energy under that averaging, and that is where the group lives.** At the Gaussian
(one-loop) level the minimal-action twisted configuration's free energy is classically scale-invariant in four dimensions and
proportional to 1/g², so per doubling F_{k+1}/F_k = g²(L)/g²(2L) = 1 − c(2)/β_eff(k) for SU(2), with
c(2) = 8b₀ ln 2 = (11/(3π²)) ln 2 = 0.25752 in Wilson β units (M3's S-1 enclosure), and = 1 (or ≥ 1, the photon being
infrared free) for U(1): the Z₂ ⊂ U(1) π-flux costs the same at every scale. The centre therefore sees asymptotic freedom AS
the decay rate of the vortex free energy, and nothing else.
**The step whose loss accumulates, and its admissible per-step loss.** A ONE-SIDED per-step bound on the vortex free energy
(equivalently on the effective coupling): β_eff(k+1) ≤ β_eff(k) − c(2) + δ_k, every δ_k ≥ 0. For SU(2) this drives the flow
to the strong-coupling exit iff Σ_k (c(2) − δ_k) ≥ 2.2 − β_exit, i.e. δ < 0.2575 − (2.2 − β_exit)/K per step over K steps
(β_exit ≈ 0.45 and K = 8 give δ < 0.039 per step at one loop's drift; K = 7: δ < 0.008); for U(1) the same one-sided form
has drift 0 and with δ_k ≥ 0 NEVER drives the flow to strong coupling, at any depth — so a one-sided step with nonnegative
per-step error refuses U(1) by construction, at every number of steps. The record's hierarchical comparison fails this at
rung 1: from 2.2 the MK flow RISES to 2.34 where one loop falls to 1.94 (far shore §4.2, RESULTS 16.5), a per-step loss
δ ≈ 0.40 + 0.26 = 0.66 against the drift 0.2575. That is the precise sense in which "the hierarchical model is the right
zeroth layer only inside the disk".
**Route 2 (the cone).** The cone is a single-scale lossless implication (KP at the cone's corner ⇒ Hypothesis I for every
action in the cone; the perturbation budget is M1's exit-budget table: 2.32 … 0.06, 0.00 at β = 0.05 … 0.45, 0.4764 in the
sub-gas run). Its landing chain has per-step loss = the non-hierarchical remainder of the true blocking within the cone, and
the criterion applies with the same drift: admissible only while that remainder stays below c(2) in coupling units; at rung 1
from 2.2 it is measured of the step's own size and opposite sign, so a cone chain cannot start at 2.2 — it can only finish
the descent once the flow is inside the disk, where the budget is O(1) (≈ 1.5 at β ≈ 0.13, entered at rung 8).
**M3R's point carried.** Nothing below takes an RP or chessboard step on the blocked measure. The twist identity holds for any
block map whose coarse variables are (averages of) parallel transports: for the path holonomy (UV-UNSTABLE, M3 Prop 6.2) the
twist representative is a thin closed vortex around one fine link at the path's midpoint, a distance a_c/2 from the other
coarse paths; for a UV-stable AVERAGED map every averaged path must be cut, so the representative is a slice whose boundary
encloses the whole tube of paths — a thick vortex at the block boundary. The odd channel's locality (Theorem D below) is
therefore a distance a_c/2 for the path map and O(1) fine spacings for the averaged map: UV stability and odd-channel
locality pull in opposite directions, named here.

**§1b CORRECTED (same hour).** The rung-1 loss of the hierarchical comparison is read in the one-sided form itself:
β_MK(1) = 2.34 = 2.2 − c(2) + δ gives δ = 0.40 (= MK's 2.34 minus one loop's 1.94), not "0.40 + 0.26 = 0.66" as written
above; the conclusion stands (δ = 0.40 > c(2) = 0.2575: the hierarchical step is non-contracting at rung 1). And the
one-loop drift is the weak-coupling drift; the ℤ⁴ readings at a fixed datum (2.2 → 1.888 → 1.553 → 1.161 → 0.662) show the
drift growing to 0.31–0.55 per step as the coupling grows, so the admissible δ_k is the true drift's margin, which the
one-loop value underestimates where two-loop and non-perturbative running add with the same sign — a reading, not a bound.

---

## 2. THE TWIST IDENTITY: A COARSE CENTRE FLIP IS A CLOSED 't HOOFT SURFACE IN THE FIBRE (exact, every scale)

**Setting** (THE GROUND §8.3 with its example block map). Λ a periodic fine lattice of ℤ^d; a plaquette weight w, a positive
continuous class function on SU(2) (Wilson's w(U) = exp(½β tr U) the case of record); a set T of fine links fixed to 1 (the
fixed gauge of the block map's remaining links); μ(dU) = Z⁻¹ Π_p w(U_p) Π_{ℓ∉T} dU_ℓ (Haar). Coarse variables: for each
coarse link m, v_m = U(π_m), the ordered product of the fine links along a fixed fine path π_m; distinct coarse paths share no
fine link (the straight corner-to-corner paths of THE GROUND's blocks: paths in different directions from one corner meet only
at the corner site); each path carries at least one free link (otherwise v_m ≡ 1 and the block map is not a bijection onto
V × Φ). λ = law of v, with continuous positive density ℓ(v) w.r.t. the product Haar measure on coarse variables; ν(·|v) the
fibre measure (the conditional law of the fine configuration given v). For a free link f, B_f(U) := Π_{p∋f} w(−U_p)/w(U_p),
the product over the 2(d−1) plaquettes containing f; for Wilson's weight B_f = exp(−β Σ_{p∋f} tr U_p).

**Theorem 2.1 (the twist identity).** Let m be a coarse link, f ∈ π_m a free link, σ_m the coarse flip v_m ↦ −v_m. Then for
every coarse configuration v:
(a) ℓ(σ_m v) = ℓ(v) · ν(B_f | v);
(b) ν(B_f | v) · ν(B_f | σ_m v) = 1;
(c) ν(B_f | v) = ν(B_{f′} | v) for every free f′ ∈ π_m; more generally, for a closed twist η (a set of plaquettes whose
indicator is δζ for a Z₂ 1-cochain ζ on free links) with B_η := Π_{p∈η} w(−U_p)/w(U_p), ν(B_η|v) depends on η only through
the parities of ζ along the coarse paths: adding δζ′ with ζ′ supported on free links off every coarse path changes nothing;
(d) the conditional law of v_m given every other coarse variable has density ratio ℓ(σ_m v)/ℓ(v) between v_m and −v_m, so its
centre asymmetry is t_m(v) := (ℓ(v) − ℓ(σ_m v))/(ℓ(v) + ℓ(σ_m v)) = tanh(F_m(v)/2), with the CONDITIONAL VORTEX FREE ENERGY
F_m(v) := −log ν(B_f | v) = A(σ_m v) − A(v) (A = −log ℓ the effective action), and F_m(σ_m v) = −F_m(v).

*Proof.* (a) Let S flip the one free link f: (SU)_f = −U_f. Haar measure is invariant under multiplication by the central −1,
so S preserves Π dU. A plaquette contains f at most once and −1 is central, so (SU)_p = −U_p if p ∋ f and = U_p otherwise;
v_m(SU) = −v_m(U) (a central factor in the product) and v_{m′}(SU) = v_{m′}(U) for m′ ≠ m (disjoint paths). For bounded
measurable G of the coarse variables, substituting U = SU′:
 ∫ G(σ_m v(U)) Π_p w(U_p) dU = ∫ G(σ_m v(SU′)) Π_p w((SU′)_p) dU′ = ∫ G(v(U′)) B_f(U′) Π_p w(U′_p) dU′,
so E_λ[G∘σ_m] = E_μ[G(v)B_f] = E_λ[G · ν(B_f|·)]. The left side is ∫ G(σ_m v)ℓ(v)dv = ∫ G(v)ℓ(σ_m v)dv (coarse Haar is
σ_m-invariant). G being arbitrary, ℓ(σ_m v) = ℓ(v)ν(B_f|v) almost everywhere, and everywhere by continuity of both sides.
(b) Apply (a) at v and at σ_m v. (c) Both sides of the first claim equal ℓ(σ_m v)/ℓ(v). For the second, the substitution
U = S_{ζ′}U′ (flip every link of supp ζ′) preserves Haar measure and every coarse variable and carries Π_p w(η_p(δζ′)_p U_p)
to Π_p w(η_p U′_p); the same computation gives E_μ[G B_{η+δζ′}] = E_μ[G B_η] for all G. (d) Immediate from (a). ∎

*Averaged block maps (M3's UV-stable variables).* If v_m = Proj(Σ_i c_i U(π_i)) over a family of paths (Proj the polar
projection to SU(2), odd under M ↦ −M), and S is a set of free links meeting every π_i an odd number of times and every path
of every other coarse variable an even number of times, the same proof gives (a)–(d) with B_{δ1_S}: the representative is
the boundary δ1_S of a slice cutting the whole tube of paths — a thick closed vortex enclosing the tube.

**Proposition 2.2 (the vortex recursion; exact, lossless).** For composable holonomy maps (each scale-(k+1) coarse path the
concatenation of two scale-k paths, c_{k+1} = c ∘ c_k), let F_k be the vortex free energy of a scale-k coarse link m_k and
F_{k+1} that of the scale-(k+1) link m_{k+1} whose path contains π_{m_k}, both with the same free link f. Then
 e^{−F_{k+1}(v′)} = E_{λ_k}[ e^{−F_k(v)} | c(v) = v′ ],
so inf F_k ≤ inf F_{k+1} ≤ sup F_{k+1} ≤ sup F_k and sup|F_{k+1}| ≤ sup|F_k|.
*Proof.* ν_{k+1}(B_f|v′) = E_μ[B_f | c_{k+1}(U) = v′] = E[ E_μ[B_f | c_k(U)] | c_{k+1}(U) = v′ ] (tower property;
σ(c_{k+1}) ⊂ σ(c_k)), and the conditional law of c_k(U) given c_{k+1}(U) = v′ is λ_k(· | c(v) = v′). An average of numbers in
[e^{−sup F}, e^{−inf F}] lies there. ∎
The same holds verbatim for U(1) (flip by −1, or by any e^{iα}). The recursion is the centre's whole contribution to a chain:
it is exact, non-expansive, and carries no smallness by itself (§1b).

---

## 3. THE TWO-CHANNEL THEOREM: THE COARSE COUPLING = (SO(3) CHANNEL) ⊕ (VORTEX SENSITIVITY), WITH NOTHING LOST

**Lemma 3.1 (the two-channel lemma).** Let X, Y take values in compact metric spaces 𝒳, 𝒴 on which finite groups Γ, Δ act
freely and measurably; let the joint law π have a continuous strictly positive density with respect to a product of invariant
reference measures. Write X̃, Ỹ for the orbits, L_X ∈ Γ for the position of X in its orbit relative to a measurable section
(the LABEL; nothing below depends on the section), ρ for the maximal correlation of (X, Y), ρ̃ for that of (X̃, Ỹ), and
 τ_X := ess sup_{x̃} ρ(L_X, Y | X̃ = x̃),  τ_Y := ess sup_{ỹ} ρ(L_Y, X | Ỹ = ỹ)
(the maximal correlation between the label and the other variable, under the conditional law given the orbit). Then
 ρ̃ ≤ ρ ≤ ( ρ̃² + τ_X² + τ_Y² )^{1/2}.

*Proof.* The left inequality: functions of X̃ are functions of X. For the right, take centred f ∈ L²(π_X), g ∈ L²(π_Y) of unit
norm and split f = f̃ + f⊥, f̃ = E[f | X̃] (under π_X, which is π's X-marginal), so E[f⊥ | X̃] = 0 and ‖f̃‖² + ‖f⊥‖² = 1; likewise
g = g̃ + g⊥. Then Cov(f, g) = Cov(f̃, g̃) + Cov(f̃, g⊥) + Cov(f⊥, g).
(1) |Cov(f̃, g̃)| ≤ ρ̃ ‖f̃‖ ‖g̃‖, f̃ and g̃ being centred functions of X̃ and Ỹ.
(2) E[f⊥ | X̃] = 0 gives Cov(f⊥, g) = E[f⊥ g] = E_{X̃}[ Cov(f⊥(X), g(Y) | X̃) ]. Given X̃ = x̃, f⊥(X) is a function of L_X, so
|Cov(f⊥, g | x̃)| ≤ ρ(L_X, Y | x̃) sd(f⊥ | x̃) sd(g | x̃) ≤ τ_X sd(f⊥|x̃) sd(g|x̃); by Cauchy–Schwarz,
|Cov(f⊥, g)| ≤ τ_X (E Var(f⊥|X̃))^{1/2}(E Var(g|X̃))^{1/2} ≤ τ_X ‖f⊥‖ ‖g‖, since E Var(f⊥|X̃) = E f⊥² and E Var(g|X̃) ≤ Var g.
(3) In the same way, conditioning on Ỹ: |Cov(f̃, g⊥)| ≤ τ_Y ‖f̃‖ ‖g⊥‖.
With a = ‖f̃‖, b = ‖f⊥‖, c = ‖g̃‖, e = ‖g⊥‖: |Cov(f, g)| ≤ a(ρ̃c + τ_Y e) + bτ_X ≤ a(ρ̃² + τ_Y²)^{1/2} + bτ_X
≤ (ρ̃² + τ_Y² + τ_X²)^{1/2}, by Cauchy–Schwarz twice (c² + e² = 1, a² + b² = 1). Take the supremum over f and g. ∎

**Lemma 3.2 (the label sensitivity in free energies).** In Lemma 3.1, write p for the density and, for γ ∈ Γ, F_γ(x, y) :=
log p(x, y) − log p(γx, y) (the label free energy).
(i) Γ = Z₂ = {1, σ}: with t(x, y) = tanh(F_σ(x, y)/2) = (p(x,y) − p(σx,y))/(p(x,y) + p(σx,y)) and t₀(x̃) the same for the
X-marginal, ρ(L_X, Y | x̃) = sd(t(x, Y) | X̃ = x̃)/(1 − t₀(x̃)²)^{1/2}, hence
 τ_X ≤ ess sup_x ½ osc_y t(x, y) / (1 − t₀²)^{1/2} ≤ ¼ · ess sup_x osc_y F_σ(x, y) · cosh(½ ess sup |F_σ|).
(ii) general Γ: τ_X ≤ 2 sinh(Δ_X), Δ_X := ess sup_x max_{γ∈Γ} osc_y F_γ(x, y).
*Proof.* (i) Given x̃, L_X is binary with P(L_X = 1 | Y = y, x̃) = (1 + t(x,y))/2 and P(L_X = 1 | x̃) = (1 + t₀)/2; a centred
function of a binary variable is a multiple of 1_{L=1} − P(L=1), and Cov(1_{L=1}, g(Y) | x̃) = Cov(P(L=1|Y, x̃), g(Y) | x̃), so
the maximal correlation is sd(P(L=1|Y,x̃))/(P(L=1)P(L=σ))^{1/2} = (½ sd t)/(½ (1−t₀²)^{1/2}). Then sd ≤ ½ osc,
osc t ≤ ½ osc F (tanh′ ≤ 1), and |t₀| ≤ sup_y |t(x,y)| because t₀ is a mixture of the t(x, y) (P(L=1|x̃) is the average of
P(L=1|y, x̃) over the conditional law of Y), so (1 − t₀²)^{−1/2} ≤ cosh(½ sup|F|). (ii) Given x̃, the label law at Y = y is
q_y(γ) ∝ e^{−F_γ(x,y)} and at x̃ alone q = ∫ q_y (a mixture). For centred h(L) and any g(Y): |E[h|Y=y] − E h| =
|Σ_γ (q_y(γ) − q(γ))h(γ)| ≤ χ(q_y‖q) sd_q(h), so ρ(L, Y | x̃) ≤ sup_y χ(q_y‖q); χ² is convex in its second argument, so
χ²(q_y‖q) ≤ sup_{y′} χ²(q_y‖q_{y′}); the energies of q_y and q_{y′} differ by at most Δ, so r = q_y/q_{y′} ∈ [e^{−2Δ}, e^{2Δ}]
with q_{y′}-mean 1, and by the Bhatia–Davis inequality χ² = Var_{q_{y′}}(r) ≤ (e^{2Δ} − 1)(1 − e^{−2Δ}) = (2 sinh Δ)². ∎
(On the leading mode p = 1 + εχ_½(U)χ_½(V) with Haar marginals: ρ = ε, ρ̃ = 0, and t = εχ_½(U)χ_½(V), so
ρ(L_U, V | Ũ) = ε|χ_½(U)| and τ_U = τ_V = 2ε: Lemma 3.1 reads ρ ≤ 2√2 ε against the true ε — loose by the factor
sup|χ_½|/rms χ_½ = 2 in each label, the price of the ess sup over the orbit.)

**Theorem 3.3 (Hypothesis I-L² in two channels).** For the blocked measure of §2 with coarse sites y carrying the d coarse links
at y (Γ_y = Z₂^d, flips of any subset of them, acting freely on SU(2)^d with orbits SO(3)^d), every pair y ≠ z and every
coarse environment ξ:
 ρ̃_{yz}(ξ) ≤ ρ_{yz}(ξ) ≤ [ ρ̃_{yz}(ξ)² + τ_{y|z}(ξ)² + τ_{z|y}(ξ)² ]^{1/2},
where ρ̃ is the conditional maximal correlation of the SO(3)^d projections of v_y and v_z (the INTEGER-SPIN channel) and
 τ_{y|z}(ξ) ≤ 2 sinh Δ_{y|z}(ξ),  Δ_{y|z}(ξ) = sup over v_y, v_z, v′_z and γ ∈ Γ_y of |F_γ(v_y, v_z, ξ) − F_γ(v_y, v′_z, ξ)|,
F_γ = −log ν(B_{η_γ} | ·) the conditional vortex free energy of the flip γ (Theorem 2.1; η_γ the union of the elementary twists
of the flipped links). Consequently, with R̃ and T the ess-sups over ξ,
 R̃(y,z) ≤ R(y,z) ≤ [R̃(y,z)² + T(y,z)² + T(z,y)²]^{1/2} ≤ R̃(y,z) + T(y,z) + T(z,y),
and HYPOTHESIS I-L² (M2 §3) holds as soon as Σ_z (R̃(y,z) + T(y,z) + T(z,y)) e^{κ|y−z|} ≤ α < 1 for every y; conversely,
Hypothesis I-L² for v implies it for the SO(3) projections (R̃ ≤ R).
*Proof.* Lemma 3.1 applied to the conditional law of (v_y, v_z) given ξ, with Lemma 3.2(ii); F_γ = log ℓ(v) − log ℓ(γv) is the
label free energy of that conditional law (the conditional density is ℓ up to a ξ-dependent constant), and Theorem 2.1(a)
identifies it with −log ν(B_{η_γ}|v) (for a product of flips apply (a) link by link). ∎

So THE SO(3) CHANNEL IS NECESSARY, AND WITH THE VORTEX SENSITIVITY IT IS SUFFICIENT. The centre-direction mixed difference
Δ_{y|z} is the mixed second difference of the effective action restricted to centre orbits, |[A(γv_y, v_z) − A(v_y, v_z)] −
[A(γv_y, v′_z) − A(v_y, v′_z)]| ≤ Δ_{yz}(A), THE GROUND's full mixed difference (§8.3, after Theorem 8.5) restricted to the
2^d-point orbits: the centre's half of the influence functional, and only that half.

---

## 4. THE ODD HALF IS A FIBRE STATEMENT: THE VORTEX SENSITIVITY IS A TWISTED-FIBRE RESPONSE AT DISTANCE a_c/2

**Theorem 4.1.** Holonomy path map, Wilson's weight, d = 4; f the midpoint free link of π_m (m a coarse link at y); z ≠ y a
coarse site each of whose coarse paths is at fine distance ≥ r from every link of the six plaquettes through f (r = a_c/2 − 1
for THE GROUND's straight paths: every other coarse path stays a_c/2 away from the midpoint in the maximum norm). Suppose the
fibre measures ν(·|v), as Gibbs measures on the fibre coordinates, satisfy Dobrushin's condition uniformly in v with
Σ_j C_fib(i, j) e^{κ_f |i−j|} ≤ α_f < 1. Then for every flip γ of one coarse link at y,
 Δ_{y|z} ≤ 48πβ · 19² · e^{−κ_f r}/(1 − α_f),  so  τ_{y|z} ≤ 2 sinh( 48πβ · 361 · e^{−κ_f r}/(1 − α_f) )
(for flips of several links at y, add the single-link bounds).
*Proof.* A change of v_z changes at most four coarse links; chain the four changes. For one coarse link m′ at z, join v_{m′} to
v′_{m′} by a geodesic v_{m′}(s) = e^{sX}v_{m′}, s ∈ [0, s₁], X ∈ su(2) of operator norm one, s₁ ≤ π, realised on the fine field
by U_{f′} ↦ e^{sX′}U_{f′} at one free link f′ ∈ π_{m′} (X′ the conjugate of X that moves the path product as prescribed).
This map carries the fibre over v(0) onto the fibre over v(s), so d/ds log ℓ(v(s)) = E_{ν(·|v(s))}[Φ_s], with Φ_s =
Σ_{p∋f′} d/ds (½β tr U_p(s)), |Φ_s| ≤ 6 · ½β · 2 = 6β; the same with the twisted weights gives d/ds log ℓ(σ_m v(s)) =
E_{ν^f(·|v(s))}[Φ_s], ν^f := B_f ν/ν(B_f) the TWISTED fibre measure (f′ lies in no twisted plaquette). So by Theorem 2.1(a),
 |F_m(v′) − F_m(v)| ≤ ∫₀^{s₁} |E_{ν^f(·|v(s))}Φ_s − E_{ν(·|v(s))}Φ_s| ds.
The twisted specification differs from the untwisted one only at the 19 links of the six plaquettes through f, each by at most
one in total variation; Dobrushin's comparison theorem (Georgii, Thm 8.20; THE GROUND's Dobrushin.lean) gives
|E_{ν^f}Φ − E_νΦ| ≤ Σ_{j ∈ L(f′)} Σ_{i ∈ L(f)} δ_j(Φ) D(j, i) ≤ 2·6β · 19² · e^{−κ_f r}/(1 − α_f), with D = Σ C_fib^n,
D(j, i) ≤ e^{−κ_f|j−i|}/(1 − α_f) (the weighted row sums, by induction as in THE GROUND's proof of Theorem 8.5). Multiply by
s₁ ≤ π and by the four links, and use Lemma 3.2(ii). ∎

**What it says.** The odd half of Hypothesis I at the coarse scale holds as soon as the FIBRE — the fine field with the coarse
holonomies held fixed — forgets a local 't Hooft insertion at distance a_c/2. That is a clustering property of the fibre, the
kind of statement Hypothesis II makes (M3's domain below a_UV; the window's own fibre at β ≈ 2.2 above it). The huge local
cost of the twist (B_f ranges over e^{±12β}) never enters: only its influence at a distance does, which is why the TV form of
the comparison theorem (b_i ≤ 1 whatever the twist's size) is the right tool. THE CENTRE TRANSFERS THE ODD HALF OF THE COARSE
PROBLEM TO THE FIBRE, and leaves the SO(3) channel as the only genuinely coarse-scale content of Hypothesis I. (For an averaged,
UV-stable block map the twist encloses the tube and r is O(1): §1b.)

---

## 5. THE NO-GO: NOTHING IN THE CENTRE BOUNDS THE SO(3) CHANNEL; AND THE U(1) FORM

**Theorem 5.1 (centre-blind actions).** Let w(−U) = w(U) (any function of the SO(3) projection; e.g. exp(β_a χ_1)). Then for
every holonomy (or averaged) block map, every scale and every coarse link, B_f ≡ 1, F ≡ 0, τ ≡ 0, and R = R̃ exactly. Hence:
(a) no inequality bounding R, Hypothesis I-L², or the gap by a function of the vortex sensitivities (or vortex free energies)
alone can hold: on centre-blind theories those vanish identically while R̃ is whatever the SO(3) theory makes it. At the level
of laws this is immediate (the centre-blind lift of ANY law of (X̃, Ỹ) with maximal correlation r has τ = 0, ρ = r).
(b) A rigorous gauge-theory instance where the SO(3) channel fails at every scale: van Enter–Shlosman (CMP 255 (2005) 21–32)
prove that sufficiently nonlinear lattice gauge models ((1 + L(U_p))/2)^p, L the normalised real trace, with compact continuous
gauge group, have in d ≥ 3 a temperature at which the free energy is not differentiable. Take the group SO(3) in its defining
representation (a compact continuous group; that their hypotheses cover it is to be checked at the page, the stated class
being "compact continuous gauge groups") and lift to SU(2) by w(U) = exp(J((1 + tr R(U)/3)/2)^p), R the SO(3) image: centre-
blind, with Z_SU(2)(J) = Z_SO(3)(J) (normalised Haar pushes forward to normalised Haar). At the non-differentiability point J_t,
Hypotheses I-L² and II-L² cannot hold with constants uniform on any neighbourhood of J_t, for any block map: if they did,
M2's Theorem 3.1 would give |Cov(E_p, E_q)| ≤ Kρ₁^{d(p,q)} uniformly in the lattice and in J there, hence a uniformly bounded
specific heat (1/|Λ|)Var(H_Λ) ≤ C, hence (finite-volume free energies convex with second derivatives ≤ C on the neighbourhood;
Arzelà–Ascoli on their derivatives) a C^{1,1} limiting free energy — contradicting non-differentiability at J_t. For the trivial
block map (a_c = a) the fibre is empty, II-L² is vacuous, and it is Hypothesis I-L² itself, i.e. R = R̃, that fails. τ ≡ 0
throughout.
*Proof of the first sentence.* B_f = Π_{p∋f} w(−U_p)/w(U_p) = 1, so ν(B_f|·) = 1 and F = 0 by Theorem 2.1; every label free
energy vanishes, the label is independent of everything given the orbit, τ = 0, and Lemma 3.1 gives ρ̃ ≤ ρ ≤ ρ̃. ∎

**Theorem 5.2 (U(1): the whole group is the centre).** For G = U(1) the twist identity holds for every e^{iα}:
ℓ(e^{iα}·_m v)/ℓ(v) = ν(B_{f,α} | v), B_{f,α} = Π_{p∋f} w(e^{±iα}U_p)/w(U_p) (sign by orientation), and Proposition 2.2
holds for every α. With Z₂ = {±1} ⊂ U(1), Lemma 3.1 applies with orbit map U ↦ U² (U(1)/Z₂ ≅ U(1)). By M2's Theorem 4.1 no
block map of U(1) satisfies Hypothesis I-L² wherever U(1) is massless (Fröhlich–Spencer's range rigorously; β = 1.2 by the
measured phase diagram), so there R̃ + T + T′ fails the weighted bound at every scale. *Proof.* As Theorem 2.1, with e^{iα}
central and Haar-preserving. ∎
At the Gaussian level the reason is visible in the recursion: the minimal-action π-flux through a block of side L costs a
shape factor times 1/e², scale-invariant in four dimensions, and pure compact U(1) has no perturbative running, so the vortex
free energy does not contract under blocking (§1b); SU(2)'s contracts by g²(L)/g²(2L) = 1 − c(2)/β_eff per doubling.

**The physics of the SO(3) channel at the crossover (labelled: lattice Monte Carlo, not proof).** In the fundamental–adjoint
plane the bulk first-order line ends near the Wilson axis (Bhanot–Creutz 1981); approaching its endpoint the 0⁺⁺ glueball mass
falls while the other glueball masses are unchanged (Heller, hep-lat/9508009, for SU(3); for SU(2) Grady, hep-lat/0404015,
argues a tricritical endpoint continuing as a second-order bulk line toward the Wilson axis). The 0⁺⁺ is centre-EVEN. So the
crossover is the Widom line of that endpoint: the direction in which the correlation length is largest there is exactly the
channel the centre cannot see. And at the coarse scale the odd channel decays like the string area exp(−σa_c²) while the even
decays like glueball exchange exp(−m a_c): beyond a_c ~ m/σ the even channel dominates the coupling. The SO(3) channel is the
window's bottleneck; the vortex half is, by Theorem 4.1, a fibre property.

**The orchestrator's correction carried (iii-43, 2026-11-02).** The record's S₂₀ = 1.11 / 1.33 and M2's 20ρ values are built
from the W2 engine's "bent" dumps, which never computed the bent object (M2 §6.0, M2R item 7): at the ordered and cancelling
data bent ≡ planar exactly, so those are PLANAR-GEOMETRY numbers summed as if all twenty adjacent pairs were coplanar; the
sixteen true bent pairs (a direct coupling through the n+1 corner plaquettes) are UNREAD. Nothing below uses them as a bent row;
every reading below is a planar-geometry reading and is labelled so; the bent dumps at the RANDOM datum (a third object) are
not used at all.

---

## 6. THE CHANNEL SPLIT READ ON THE EXACT OBJECTS — DESIGN, KNOWN ANSWERS, STAKES (written before the reader exists)

**What is read, and what it is not.** On the record's two-face objects (the W2 engine's junction-tensor dumps, III
STDLIB/build/aperanton/surface-gas/dob_*.txt; M2's l2dob.c conventions copied verbatim: Dsub/rep, GENINV by the homomorphism
test, the product rule, Peter–Weyl p = Σ d_a d_c P^{ac} conj D^a conj D^c), the joint law p_ω(A, B) of the two coarse loop
holonomies at a fixed fine datum ω is split by the centre: Γ = Z₂ acting by A ↦ −A (flipping a fine link of A's boundary not
shared with B — Theorem 2.1 on the object). PLANAR GEOMETRY ONLY (§5's correction): the planar dumps, and the bent dumps at the
ordered and cancelling data, which equal the planar object exactly (M2 §6.0, M2R item 7); the bent dumps at the random datum
(a third object) are not read. Every number is a READING of a truncated law at one datum: not Hypothesis I's row, not a bound.

**The quantities (Road A in a REAL orthonormal Peter–Weyl basis e_I, the spin-a/2 blocks orthonormalised from Re/Im of
√d_a D^a; parity par(I) = a mod 2; G = P_real − m ⊗ n the coupling, m, n the marginal coefficients).** With p_A^{ev}(U) =
(p_A(U) + p_A(−U))/2, s = (1/p_A(U) + 1/p_A(−U))/2, k_I = (e_I/p_A(U) − (−1)^{par I} e_I/p_A(−U))/2:
 Φ_A = ∫ e_I e_J/p_A (centre-symmetrised quadrature), E_A = ∫ e_I e_J/p_A^{ev} on integer-spin indices, K_A = ∫ k_I k_J/s;
 ρ = ‖Φ_A^{1/2} G Φ_B^{1/2}‖ (all functions), ρ̃ = ρ_EE = ‖E_A^{1/2} G E_B^{1/2}‖ (functions of the SO(3) projections),
 ρ_OO = ‖K_A^{1/2} G K_B^{1/2}‖, ρ_{O·} = ‖K_A^{1/2} G Φ_B^{1/2}‖, ρ_{·O}, ρ_EO, ρ_OE (the O-channel of Lemma 3.1: f⊥ with
 E[f⊥ | Ã] = 0, i.e. f⊥ = h/p_A, h odd), and ρ_oo^{PW} = ‖N_A^{−1/2} G_oo N_B^{−1/2}‖, N = (Φ^{ev}_{oo})^{−1} − m_o m_oᵀ (the
 half-integer Peter–Weyl channel: odd functions). Derivations: the minimal variance for prescribed Haar moments α is αᵀΦ^{−1}α
 over all functions, αᵀE^{−1}α over centre-even ones, αᵀK^{−1}α over the O-channel (h = Σλ_I k_I/s), αᵀNα over odd ones; and
 L²₀ = E ⊕ O orthogonally makes Φ = E + K an exact identity (orbit-pair by orbit-pair on a centre-symmetric rule: with a = 1/p(U),
 b = 1/p(−U), 2ab/(a+b) + (a−b)²/(2(a+b)) = (a+b)/2) — a known answer of the reader.
 Lemma 3.2(i) on the object: t(U, V) = (p(U,V) − p(−U,V))/(p(U,V) + p(−U,V)), the conditional law of V given Ã = Ũ ∝ p(U,·) +
 p(−U,·), τ_A = max_U sd(t(U, ·))/(1 − t₀(U)²)^{1/2}; F = log p(U,V) − log p(−U,V), Δ_A = max_U osc_V F, the bound
 ¼Δ_A cosh(½ max|F|) ≥ τ_A; likewise τ_B. The Lemma 3.1 bound (ρ̃² + τ_A² + τ_B²)^{1/2} ≥ ρ, and the exact block bound
 (ρ_EE² + ρ_EO² + ρ_{O·}²)^{1/2} ≥ ρ.
 U(1): the same with e_I ∈ {1, √2 cos nφ, √2 sin nφ}, par = n mod 2, Z₂ = {φ ↦ φ + π}.

**Known answers (the reader is not trusted until all are MET).** KR (GENINV by the homomorphism; the record's GENINV = 1);
K-real (P_real(0,0) = 1, imaginary parts of P_real ≤ 10⁻¹²); K-sum (Φ = E + K to 10⁻¹²); K-syn (p = 1 + εχ_½(U)χ_½(V), ε = 0.05:
ρ = ρ_OO = ρ_oo^{PW} = ε, ρ_EE = 0, τ_A = τ_B = 2ε); K-synE (p = 1 + εχ_1(U)χ_1(V): ρ = ρ_EE = ε, ρ_OO = 0, τ = 0); K-synM
(ε₁χ_½χ_½ + ε₂χ_1χ_1, ε₁ = 0.05, ε₂ = 0.03: ρ = 0.05, ρ_EE = 0.03, ρ_OO = 0.05); K-U1 (p = 1 + 2ε cos φ cos ψ: ρ = ρ_OO = ε,
ρ_EE = 0, τ_A = √2 ε; p = 1 + 2ε cos 2φ cos 2ψ: ρ = ρ_EE = ε, ρ_OO = 0); K-free (the free datum's dump: every ρ = 0, τ = 0);
K-M2 (the full ρ equals M2's Road A on the planar cells to 10⁻⁶: 0.081207503, 0.009649371, 0.015210922, 0.000253141, …);
K-bounds (the two bounds above hold at every cell).

**THE STAKES (2026-11-02, before the reader exists; none edited after).**
- S1 (the SO(3) share at two steps). SU(2), β = 2.2, every planar two-step cell: ρ_EE/ρ ≤ 0.10 — the integer-spin channel
 carries under a tenth of the object's coupling at two steps (M2's ρ/C → 3π/16 says the (½,½) mode carries it). UNGUESSED
 within [0, 0.10]. At one step: ρ_EE/ρ ≤ 0.4, UNGUESSED within.
- S2 (slaving). At two steps ρ_EE/ρ_OO² ∈ [0.1, 3] (strong-coupling slaving: a Wilson-like action makes the spin-1 coefficient
 ≈ (2/3)(spin-½)²; heat-kernel slaving makes ρ_EE ≈ ρ_OO^{8/3}, i.e. ratio ≈ ρ_OO^{2/3} ≈ 0.06–0.1). UNGUESSED within.
- S3 (O-channel against odd channel). ρ_OO within 5 % of ρ_oo^{PW} at the random datum; parting by more than 5 % at the
 ordered one-step cell (E[χ_½(A)] = 0.62 there).
- S4 (the price of the ess sup). (ρ̃² + τ_A² + τ_B²)^{1/2}/ρ ∈ [1.5, 4] at every cell (the leading mode's 2√2 = 2.83 the
 centre). UNGUESSED within.
- S5 (theorems as known answers). The exact block bound and the Lemma 3.1 bound hold at every cell; τ_A ≤ ¼Δ_A cosh(½ max|F|),
 within a factor 3 of it.
- S6 (U(1)'s even share). U(1), two steps, β = 1.2 and 0.9, the named data: ρ_EE/ρ ∈ [0.03, 0.3] (a Gaussian pair's even
 channel is r² against r); larger at one step than at two.
- S7 (per-step factors by channel). The ODD channel's two-step/one-step factor at the ordered datum: SU(2) W2L2 < 0.25, U(1)
 1.2 > 0.4 (M2's full-ρ factors ×0.187, ×0.589 are odd-dominated). The EVEN channel's SU(2) factor UNGUESSED; predicted near
 the square of the odd one (≈ 0.035) if slaved. A factor read at two rungs is not a law (§14 of the campaign; U(1) contracts
 too in a phase that never meets the hypothesis), and none is extrapolated.

---

## 7. RESULTS — THE CHANNEL SPLIT ON THE EXACT OBJECTS (2026-11-02 05:4x–06:0x; reader m4chan.c, records rec/chan_*.txt and
rec/kat_synthetic.txt; run_records.sh re-runs everything; double precision, two quadrature degrees, not outward rounding:
READINGS of truncated laws at fixed data, planar geometry only)

**Known answers — all MET.** KR (GENINV = 1, the record's). K-real at every cell (P(0,0) = 1 to 4·10⁻¹⁵, |Im P| ≤ 10⁻¹⁸).
K-sum: max|Φ − E − K| ≤ 2.5·10⁻¹⁴ at every cell (the identity Φ = E + K). K-syn: ρ = ρ_OO = ρ_oo^{PW} = 0.050000000, ρ_EE = 0,
τ_A = τ_B = 0.0951057 — the grid value ε·max_rule|χ_½| = 0.05 · 2cos(π/10) (the supremum 2ε = 0.10 sits at U = ±1, which the
degree-16 rule does not contain: τ is read as a grid LOWER bound, as designed). K-synE: ρ = ρ_EE = 0.05, ρ_OO = 0, τ = 0. K-synM:
ρ = 0.05, ρ_EE = 0.03, ρ_OO = 0.05. K-synA (a non-symmetric marginal): ρ_OO = 0.052178 ≠ ρ_oo^{PW} = 0.051031 (the O-channel and
the half-integer channel part where the marginal is asymmetric), both bounds MET. K-U1: ρ = ρ_OO = 0.05, ρ_EE = 0, τ = √2ε =
0.0707107 exactly (k = 1); ρ = ρ_EE = 0.05, ρ_OO = 0, τ = 0 (k = 2). K-free (SU(2) and U(1) free data): every ρ = 0, τ = 0 (after
the variance was made two-pass: the one-pass form left a 2·10⁻⁸ square-root-of-roundoff floor that tripped the bound check —
caught by this known answer, corrected, every cell re-run). K-M2: the full ρ equals M2's Road A to every printed digit at all
twenty-two cells (e.g. 0.081207503, 0.132155408, 0.009649371, 0.015210922, 0.017433784, 0.000253141, 0.031498032; U(1)
0.204193924, 0.120240908, 0.065427751). Quadrature: degrees (30, 16) against (40, 20) move ρ, ρ_EE, ρ_OO by ≤ 4·10⁻⁹ and τ by
≤ 3·10⁻⁶. K-bounds: the exact block bound and the Lemma 3.1 bound hold at every cell; τ ≤ ¼Δ cosh(½ max|F|) at every cell.

**SU(2), β = 2.2, planar geometry** (ρ all functions; ρ_EE the SO(3) / integer-spin channel; ρ_OO the O-channel; ρ_oo^{PW} the
half-integer channel; τ_A Lemma 3.2's label sensitivity; Δ_A = osc_V of the object's vortex free energy F = log p(A,B) −
log p(−A,B); "L3.1" the ratio (ρ_EE² + τ_A² + τ_B²)^{1/2}/ρ):

| cell | datum | ρ | ρ_EE | ρ_OO | ρ_oo^PW | ρ_EE/ρ | ρ_EE/ρ_OO² | τ_A | Δ_A | L3.1 |
|---|---|---|---|---|---|---|---|---|---|---|
| one step W2L2 | ordered | 0.081207503 | 0.009661687 | 0.072364560 | 0.079003091 | 0.1190 | 1.845 | 0.17816 | 1.816 | 3.10 |
| one step W2L2 | cancelling | 0.132155408 | 0.009886493 | 0.126614067 | 0.127770570 | 0.0748 | 0.617 | 0.26563 | 2.488 | 2.84 |
| one step W2L2 | Haar-random | 0.009649371 | 0.000060092 | 0.009599636 | 0.009635432 | 0.0062 | 0.652 | 0.01915 | 0.1527 | 2.81 |
| one step W3L2 | ordered | 0.109877830 | 0.023990432 | 0.087656223 | 0.106739875 | 0.2183 | 3.122 | 0.26325 | 3.183 | 3.40 |
| one step W3L2 | cancelling | 0.189480725 | 0.024246383 | 0.175209768 | 0.186798900 | 0.1280 | 0.790 | 0.38842 | 3.787 | 2.90 |
| one step W3L4 | ordered | 0.107463097 | 0.023838571 | 0.085546511 | 0.104203327 | 0.2218 | 3.257 | 0.23630 | 2.666 | 3.12 |
| one step W3L4 | cancelling | 0.189748876 | 0.024216662 | 0.175516775 | 0.186384158 | 0.1276 | 0.786 | 0.37914 | 3.759 | 2.83 |
| two steps W2L2 | ordered | 0.015210922 | 0.000029625 | 0.015192554 | 0.015101791 | 0.00195 | 0.128 | 0.030379 | 0.2468 | 2.824 |
| two steps W2L2 | cancelling | 0.017433784 | 0.000028438 | 0.017423620 | 0.017356762 | 0.00163 | 0.0937 | 0.034811 | 0.2765 | 2.824 |
| two steps W2L2 | Haar-random | 0.000253141 | 0.000000004 | 0.000253141 | 0.000253140 | 0.000017 | 0.069 | 0.000506 | 0.00402 | 2.827 |
| two steps W3L2 (rec. b, Schur) | ordered | 0.031498032 | 0.000274590 | 0.031300941 | 0.031034503 | 0.00872 | 0.280 | 0.063078 | 0.5314 | 2.832 |
| two steps W3L2 | cancelling | 0.038581180 | 0.000227944 | 0.038500207 | 0.038342605 | 0.00591 | 0.154 | 0.077062 | 0.6265 | 2.825 |
| two steps W2L4 | ordered | 0.015210959 | 0.000029625 | 0.015192592 | 0.015101782 | 0.00195 | 0.128 | 0.030375 | 0.2468 | 2.824 |
| two steps W2L4 | cancelling | 0.017433797 | 0.000028438 | 0.017423633 | 0.017356758 | 0.00163 | 0.0937 | 0.034810 | 0.2764 | 2.824 |

**U(1)** (NMAX 6, charges to 6; the named data, where the engine's object is the planar one):

| β, cell | datum | ρ | ρ_EE | ρ_OO | ρ_oo^PW | ρ_EE/ρ | ρ_EE/ρ_OO² | τ_A | Δ_A | L3.1 |
|---|---|---|---|---|---|---|---|---|---|---|
| 1.2 one step | ordered | 0.204193924 | 0.028933711 | 0.179354415 | 0.184967947 | 0.1417 | 0.899 | 0.31221 | 2.958 | 2.17 |
| 1.2 one step | cancelling | 0.353739827 | 0.032451943 | 0.339517798 | 0.330714036 | 0.0917 | 0.282 | 0.49794 | 4.054 | 1.99 |
| 0.9 one step | ordered | 0.173509119 | 0.008459945 | 0.166785740 | 0.157142628 | 0.0488 | 0.304 | 0.24747 | 1.915 | 2.02 |
| 0.9 one step | cancelling | 0.265189144 | 0.008491566 | 0.262384446 | 0.254758754 | 0.0320 | 0.123 | 0.37148 | 2.511 | 1.98 |
| 1.2 two steps | ordered | 0.120240908 | 0.000737625 | 0.119762669 | 0.112635694 | 0.00614 | 0.0514 | 0.16640 | 1.083 | 1.96 |
| 1.2 two steps | cancelling | 0.147800366 | 0.000727564 | 0.147556794 | 0.142596255 | 0.00492 | 0.0334 | 0.20602 | 1.276 | 1.97 |
| 0.9 two steps | ordered | 0.065427751 | 0.000047205 | 0.065404474 | 0.063554785 | 0.00072 | 0.0110 | 0.09136 | 0.5447 | 1.97 |
| 0.9 two steps | cancelling | 0.074510598 | 0.000044939 | 0.074501919 | 0.073685269 | 0.00060 | 0.0081 | 0.10483 | 0.6079 | 1.99 |

**Per-step factors (two steps / one step), by channel, at the same datum and cap:** SU(2) W2L2 ordered: ρ ×0.187, ρ_OO ×0.210,
ρ_EE ×0.0031; cancelling: ×0.132, ×0.138, ×0.0029; W3L2 ordered: ×0.287, ×0.357, ×0.0114; cancelling: ×0.204, ×0.220, ×0.0094.
U(1) 1.2 ordered: ×0.589, ×0.668, ×0.0255; cancelling: ×0.418, ×0.435, ×0.0224; 0.9 ordered: ×0.377, ×0.392, ×0.0056;
cancelling: ×0.281, ×0.284, ×0.0053.

**THE STAKES, GRADED (as written in §6, none edited).**
- S1 HELD: at every two-step cell ρ_EE/ρ ≤ 0.0087 (≤ 0.10 staked); at every one-step cell ≤ 0.222 (≤ 0.4 staked).
- S2 REFUTED at three cells: ρ_EE/ρ_OO² at two steps reads 0.128, 0.0937, 0.069, 0.280, 0.154 — below the band [0.1, 3] at the
 W2L2 cancelling (0.0937, twice: L2 and L4 caps) and random (0.069) cells. The even channel is slaved to the odd one in the sense
 ρ_EE = O(ρ_OO²), with a constant 0.07–0.28 at two steps — below the strong-coupling 2/3 and not the heat-kernel ρ_OO^{2/3}.
- S3 HELD: at the random datum ρ_OO and ρ_oo^{PW} agree to 0.4 % (one step) and 4·10⁻⁶ (two steps); at the ordered one-step W2L2
 cell they part by 8.4 % (0.072365 against 0.079003).
- S4 HELD: (ρ̃² + τ_A² + τ_B²)^{1/2}/ρ ∈ [2.81, 3.40] for SU(2) and [1.96, 2.17] for U(1); at two steps SU(2) sits at 2.824–2.832,
 the leading mode's 2√2 = 2.828, and U(1) at 1.96–1.99, its leading mode's 2.
- S5: the bounds HELD at every cell; "τ within a factor 3 of ¼Δ cosh(½max|F|)" HELD at two steps and at the random data (2.05–2.43)
 and REFUTED at the one-step named-data cells (4.6–13.6): there max|F| reaches 2.6–4.5, and cosh(½max|F|) with the osc-vs-sd gap
 is what the free-energy bound pays.
- S6 REFUTED: U(1)'s even share at two steps reads 0.0060–0.0061 (1.2) and 0.0006–0.0007 (0.9), below the band [0.03, 0.3] — the
 Gaussian (Hermite) picture ρ_EE = ρ² would give ≈ 0.12; the second clause (larger at one step: 0.032–0.142) HELD.
- S7 HELD: the odd channel's factor at the ordered datum is ×0.210 for SU(2) W2L2 (< 0.25) and ×0.668 for U(1) at 1.2 (> 0.4);
 the even channel's SU(2) factor reads ×0.0031–0.0114, against the predicted ≈ 0.035 — the even channel contracts an order of
 magnitude faster than the square of the odd one on these objects.

**What the readings say, at their strength.** (1) ON EVERY PINNED OBJECT AT TWO STEPS THE DIRECT COUPLING IS THE VORTEX HALF:
ρ_OO/ρ ≥ 0.9937 for SU(2) and ≥ 0.9964 for U(1); the SO(3) channel carries at most 0.87 % (SU(2)) of the planar pair's direct
coupling. (2) The exact block bound (ρ_EE² + ρ_EO² + ρ_O·²)^{1/2} meets ρ to 10⁻⁵ relative at two steps: the decomposition of
§3 loses NOTHING on these objects once the O-channel is read exactly; Lemma 3.2's free-energy handle τ costs the factor 2√2 of the
leading mode, the price of the ess sup over the orbit, and no more. (3) The even channel contracts per step ×0.003–0.011 (SU(2))
and ×0.005–0.026 (U(1)), the odd one ×0.14–0.36 and ×0.28–0.67: both groups contract in both channels at fixed data, as every
fixed-datum reading of the record has (the U(1) column's standing warning: a per-scale ratio at two rungs is not a law).
(4) RECONCILED WITH §5's PHYSICS, AND WHY THE OBJECTS CANNOT SEE THE SO(3) HALF. The pinned object fixes the whole fine outside, so
the coupling it reads passes only through the two faces; the physical carrier of the SO(3) channel at the coarse scale — the
scalar glueball exchanged through the surrounding fibre, exp(−m a_c) — is exactly what pinning severs. On the true blocked
measure the SO(3) half therefore lives in the OUTSIDE-MEDIATED term of M2's mixture inequalities (Lemma 5.1 / 7.1:
ρ_ξ(A,B) ≤ √(M_A M_B) E_ν[ρ_ω] + ρ_ξ(A; ω)ρ_ξ(B; ω)) — the covariance, over the fine outside under its true law, of the object's
SO(3)-content means. Combining Theorem 3.3 with Lemma 7.1 channel by channel: THE DIRECT COUPLING IS THE VORTEX HALF (read here:
≥ 99 % at two steps), AND THE SO(3) HALF IS THE OUTSIDE-MEDIATED COVARIANCE (no pinned object reads it). That is the precise form
of the window's remaining object (§8).

---

## 8. THE TURÁN SLAVING THEOREM: ON CONVOLUTION COUPLINGS THE SO(3) CHANNEL IS AT MOST THE SQUARE OF THE VORTEX CHANNEL

**Theorem 8.1.** Let K be a continuous, positive-definite class function on SU(2) with K ≥ 0, ∫K dU = 1, and κ_j :=
(1/d_j)∫ K χ_j dU (κ_0 = 1, 0 ≤ κ_j ≤ 1). Let (U, V) have the CONVOLUTION law K(UV⁻¹) dU dV (Haar marginals).
(a) The conditional expectation f ↦ E[f(U) | V] acts on the spin-j isotypic subspace of L²(SU(2)) as multiplication by κ_j.
Hence ρ = sup_{j ≥ ½} κ_j, the SO(3) channel ρ̃ = sup_{j ∈ {1, 2, …}} κ_j, and the vortex (half-integer) channel sup_{j ∈ ℕ+½} κ_j.
(b) THE TURÁN CLASS 𝒯: all κ_j > 0 and n ↦ κ_{n/2} log-concave. For K ∈ 𝒯, κ_{n/2} ≤ κ_½^n for every n, so ρ = κ_½ (the vortex
channel) and ρ̃ = κ_1 ≤ κ_½² = ρ²: THE SO(3) CHANNEL IS AT MOST THE SQUARE OF THE VORTEX CHANNEL.
(c) 𝒯 is closed under convolution, and contains every Wilson weight e^{½β tr U}/Z, β > 0, for which κ_j = I_{2j+1}(β)/I_1(β).
(d) The same holds for U(1) with κ_n = (1/2π)∫K cos(nθ) dθ and the Wilson (von Mises) weight κ_n = I_n(β)/I_0(β): the charge-2
channel is at most the square of the charge-1 channel. Slaving is group-blind.
(e) A centre-blind weight is maximally outside 𝒯: e^{β_a χ_1} has κ_½ = 0 < κ_1.
*Proof.* (a) K = Σ_j d_j κ_j χ_j (Peter–Weyl for class functions), and Schur orthogonality gives ∫ χ_{j′}(UV⁻¹) D^j_{rq}(U) dU =
δ_{jj′} D^j_{rq}(V)/d_j, so ∫ K(UV⁻¹) f(U) dU = κ_j f(V) for f in the spin-j span. The operator is self-adjoint (K(g⁻¹) = K(g):
χ_j(g⁻¹) = conj χ_j(g) = χ_j(g)), its norm on L²₀ is sup_{j≥½} κ_j, and centre-even (odd) functions are the integer (half-integer)
spins. (b) Log-concavity makes the ratios r_n = κ_{n/2}/κ_{(n−1)/2} nonincreasing, r_1 = κ_½, so κ_{n/2} = Π_{k≤n} r_k ≤ κ_½^n.
(c) Convolution multiplies coefficients, κ_j(K₁*K₂) = κ_j(K₁)κ_j(K₂) (centrality and Schur), and a coefficientwise product of
positive log-concave sequences is log-concave. For Wilson's weight κ_j = I_{2j+1}(β)/I_1(β) (the character expansion of THE
GROUND §8.3, its a_j), and n ↦ I_n(β) is log-concave: by the product formula THE GROUND quotes in Lemma 8.6,
I_μ I_ν = Σ_k (β/2)^{μ+ν+2k} (μ+ν+2k)!/(k!(μ+k)!(ν+k)!(μ+ν+k)!), the pairs (n+1, n+1) and (n, n+2) share μ + ν and the factor
(μ+ν+2k)!/(k!(μ+ν+k)!), and 1/((n+1+k)!)² − 1/((n+k)!(n+2+k)!) = [1/((n+k)!(n+1+k)!)]·[1/(n+1+k) − 1/(n+2+k)] > 0, so every
coefficient of I_{n+1}² − I_n I_{n+2} is positive. (d) The same argument with Fourier series and I_n/I_0. (e) χ_1 is centre-even. ∎
**Numbers** (rec/turan_check.txt; double precision, a reading of the closed form): κ_1/κ_½² = 0.66681, 0.66978, 0.67989, 0.72074,
0.72471, 0.75268, 0.82042, 0.90227 at β = 0.1, 0.4764, 1, 2.2, 2.3, 3, 5, 10 (κ_½(2.2) = 0.464479025, the record's c₁); U(1):
0.50042 … 0.90047. The strong-coupling limit 2/3 and the weak-coupling limit 1 bracket every Wilson convolution.

**The same inequality, twice.** Turán's inequality I_2² ≥ I_1 I_3 is what gives φ″ ≤ ¼ in THE GROUND's Lemma 8.6 — the vMF
covariance bound behind the strong-coupling Dobrushin constant of Theorem 8.7 — and the log-concavity of n ↦ I_n is what slaves
the SO(3) channel to the vortex channel here. ONE INEQUALITY GOVERNS THE STRONG-COUPLING CONSTANT AND THE CHANNEL HIERARCHY.

**What it buys, and where it must stop.** Convolution couplings are the direct couplings of exact two-dimensional blocking and of
the Migdal–Kadanoff decimation step; on them the SO(3) half of Theorem 3.3 is at most the square of the vortex half. The readings
of §7 show the pinned objects' DIRECT couplings at two steps from 2.2 satisfying ρ_EE ≤ ρ_OO² with ratios 0.069–0.28 — below even
the Wilson convolution's 0.72 at 2.2 — while the one-step ordered cells (1.85–3.26) do not: the objects' direct coupling enters a
Turán-like regime between the first and second step. And the theorem marks exactly where the SO(3) half escapes: the physical
glueball exchange through the fibre decays like exp(−m a_c), the vortex coupling like exp(−σa_c²) (area), so at large a_c
exp(−m a_c) ≫ exp(−2σa_c²) and NO slaving can hold for the full blocked coupling. The non-slaved SO(3) coupling is therefore the
outside-mediated covariance of §7 (4) — not a direct coupling at all — and an adjoint-rich bare or blocked action (the Bhanot–
Creutz endpoint's basin) is a departure from 𝒯 by (e).

---

## 9. THE WINDOW'S LEMMA IN ITS EXACT MINIMAL FORM; THE PER-STEP ANSWER; THE UNIFICATIONS

**Lemma W (the exit at one coarse scale a_c reached from β ∈ [2.2, 2.3], in two channels).** For the holonomy-blocked SU(2)
measure at a_c (straight paths; coarse sites with their four coarse links):
(W-V) THE VORTEX HALF — the twisted fibre forgets an elementary 't Hooft insertion at distance a_c/2: for every coarse v, every
coarse link m with midpoint free link f and every coarse site z adjacent to y, sup_s |E_{ν^f(·|v(s))}Φ_s − E_{ν(·|v(s))}Φ_s| ≤ δ_V,
where Φ_s is the coarse force at z (|Φ_s| ≤ 6β). Then (Theorem 4.1's integration: s₁ ≤ π per coarse link at z, four links at
z) the centre-direction mixed difference of a one-link flip at y is ≤ 4πδ_V, a flip of j links at y telescopes into j one-link
flips, so for the full Γ_y = Z₂⁴: T(y, z) ≤ 2 sinh(16π δ_V) (2 sinh(4πδ_V) when only one coarse link at y carries the label);
under a fibre Dobrushin condition δ_V ≤ 2·6β·19²e^{−κ_f(a_c/2−1)}/(1 − α_f).
(W-S) THE SO(3) HALF — the integer-spin channel of the coarse conditional law, which by Lemma 7.1 of M2 applied to the SO(3)
projections splits as ρ̃_ξ(A,B) ≤ √(M̃_A M̃_B) E_ν[ρ̃_ω(A,B)] + ρ_ξ(Ã; ω)ρ_ξ(B̃; ω): a DIRECT part (Turán-slaved on convolution
couplings, Theorem 8.1; read at ≤ 0.9 % of the direct coupling at two steps, §7) and the OUTSIDE-MEDIATED COVARIANCE, whose sharp
form is S_ξ(A, B) := sup over centred unit-variance SO(3)-functions f, g of |Cov_{ν₀(·|ξ)}(E_ω[f(Ã)], E_ω[g(B̃)])| — the
covariance, over the fine outside under its true law, of the pinned objects' SO(3)-content means: the scalar glueball exchanged
across one block. Require R̃(y, z) ≤ δ_S(y, z).
CONCLUSION: if Σ_z (δ_S(y,z) + T(y,z) + T(z,y)) e^{κ|y−z|} ≤ α < 1 for every y, then Hypothesis I-L² holds at a_c (Theorem
3.3), and with Hypothesis II-L² (M3's interface below a_UV, the window's own fibre above it) every limit point has a unique vacuum
and a gap ≥ min(κ, log 1/ρ′)/a_c (M2's Theorem 3.1). Both halves are NECESSARY in the sense of Theorem 3.3 (R̃ ≤ R) and Theorem
5.1 (the vortex half cannot stand in for the SO(3) half).

**The per-step answer to the orchestrator's criterion (§1b, completed).** Route 1's identities lose nothing per step (Theorem 2.1
at every scale; Proposition 2.2 non-expansive); the group difference is the per-step CONTRACTION of the vortex free energy, which
at one loop is g²(L)/g²(2L) = 1 − c(2)/β_eff, c(2) = 0.25752, for SU(2) and 1 for U(1); the SO(3) half's coupling runs with the
same g² (one Lie algebra), and U(1)/Z₂ ≅ U(1) does not run. So the step that must carry the group is a ONE-SIDED per-step bound
β_eff(k+1) ≤ β_eff(k) − c(2) + δ_k with δ_k ≥ 0: it refuses U(1) at every depth by construction (drift 0), and drives SU(2) from
2.2 to β_exit ≈ 0.45 in K steps iff Σ_k(c(2) − δ_k) ≥ 1.75 — at one loop's drift δ < 0.039 per step over eight steps; the
hierarchical comparison loses δ = 0.40 at rung 1 (2.34 against 1.94). Route 2's landing chain has the same admissible loss.
The pinned objects read the odd channel contracting ×0.14–0.36 per step for SU(2) against ×0.28–0.67 for U(1) at the same data
(§7) — the groups part in the vortex half by a factor 2–3 per step at fixed data; a reading at two rungs, never extrapolated.

**THE NEXT OBJECT, precisely.** The outside-mediated SO(3) covariance S_ξ(A, B) at two steps from 2.2 — the one quantity of
Lemma W that no pinned object reads, the scalar-glueball channel of the coarse coupling. First exact test: the two-face object with
a ring of outside links INTEGRATED rather than pinned, read in the integer-spin channel beside the pinned value (the stake: the
SO(3) share rises from ≤ 0.9 % toward the odd channel's size as the integrated ring widens; U(1)'s rises too, and only the
vortex half parts the groups). M2b's outside-mediated variance run is this quantity's consumer in the full (all-channel) form; the
channel split of §6 applied to its records gives (W-S) directly. Its partner (W-V) is a fibre statement whose first finite test is
the same object with one elementary twist inserted at the midpoint of a coarse path, read as the response of the force at the
neighbouring path (Theorem 4.1's integrand, exact on the engine).

**The cross-field unifications found.**
1. HARMONIC ANALYSIS / LANCASTER–GEBELEIN: the maximal correlation of a group-valued pair decomposes over the characters of the
 centre, the even part being the quotient group's (SO(3)) correlation; for convolution couplings it is diagonal in Peter–Weyl
 (Theorem 8.1), the information-theoretic χ²-contraction of a Markov kernel channel by channel.
2. 't HOOFT DUALITY, MADE EXACT AND CONDITIONAL: the coarse centre label is conjugate to the closed 't Hooft surface operator of
 the fibre (Theorem 2.1); F = −log ν(B_η|v) is the conditional magnetic-flux free energy; Proposition 2.2 is its renormalisation
 group — an exact averaging, lossless, whose contraction rate is the running coupling (asymptotic freedom read as vortex
 condensation's rate).
3. SUPERCRITICAL CROSSOVERS: the SU(2) Wilson crossover is the Widom line of the fundamental–adjoint endpoint (the liquid–gas
 endpoint's statistical mechanics, Ising-like or tricritical by Grady): the light direction is the centre-EVEN 0⁺⁺, exactly the
 half the centre cannot see — and the strategic lever it names: the continuum limit is universal, so a construction may choose an
 adjoint-poor (Turán-class) bare action steering away from the endpoint, provided reflection positivity (nonnegative character
 coefficients) is kept.
4. TURÁN'S INEQUALITY: one Bessel inequality gives THE GROUND's strong-coupling constant (Lemma 8.6) and the slaving of the SO(3)
 channel to the vortex channel (Theorem 8.1).

---

## 10. WHAT THIS FILE PROVES, COMPUTES, AND LEAVES (the summary, written last)

PROVED (full proofs above): Theorem 2.1 (the twist identity: a coarse centre flip of the blocked measure is the fibre
expectation of a closed 't Hooft surface, F = −log ν(B_f|v), representative-independent, for path and averaged block maps);
Proposition 2.2 (the vortex recursion e^{−F_{k+1}} = E[e^{−F_k} | coarser], exact and non-expansive); Lemma 3.1 (ρ̃ ≤ ρ ≤
(ρ̃² + τ_X² + τ_Y²)^{1/2} for any law on spaces with free finite group actions) and Lemma 3.2 (τ by the label free energy:
¼ osc F cosh(½ sup|F|) for Z₂, 2 sinh Δ in general); Theorem 3.3 (HYPOTHESIS I-L² IN TWO CHANNELS: R̃ ≤ R ≤ (R̃² + T² + T′²)^{1/2},
the SO(3) channel necessary and, with the vortex sensitivity, sufficient; the vortex part is THE GROUND's mixed difference
restricted to centre orbits); Theorem 4.1 (the vortex half from the fibre: a twisted-fibre response at distance a_c/2, explicit
under a fibre Dobrushin condition); Theorem 5.1 (no-go: centre-blind actions have τ ≡ 0 and R = R̃, and by van Enter–Shlosman a
centre-blind SU(2) action with a non-differentiable free energy defeats Hypotheses I-L² + II-L² uniformly near the transition at
every scale — the SO(3) half is independent); Theorem 5.2 (U(1): the whole group central, the twist identity for every e^{iα});
Theorem 8.1 (Turán slaving on convolution couplings, Wilson weights in the class at every β, closed under convolution).
COMPUTED (rec/chan_*.txt, rec/kat_synthetic.txt, rec/turan_check.txt; all known answers met; planar geometry only): on every
pinned object at two steps from 2.2 the direct coupling is ≥ 99.37 % vortex-channel, the SO(3) share ≤ 0.87 %, slaved below the
square (0.069–0.28); the exact block bound meets ρ to 10⁻⁵; the free-energy bound costs the leading mode's 2√2; per step the odd
channel contracts ×0.14–0.36 (SU(2)) against ×0.28–0.67 (U(1)), the even ×0.003–0.011 against ×0.005–0.026.
LEFT: Lemma W — (W-S) the outside-mediated SO(3) covariance at the exit scale (the scalar glueball across one block; the next
object, with its first exact test named) and (W-V) the twisted fibre's forgetting at distance a_c/2; and the one-sided per-step
bound with δ_k below the drift c(2) − 1.75/K that would reach the exit scale from 2.2.

---

## 11. ADDENDA (2026-11-02, after review; nothing above edited)

**§3 ADDENDUM — Corollary 3.1′ (the exact-block form; the TIGHT form of the decomposition).** In Lemma 3.1's notation let
L²₀(π_X) = E_X ⊕ O_X with E_X the centred functions of X̃ and O_X = {f⊥ : E[f⊥ | X̃] = 0} (orthogonal in L²(π_X)), likewise for Y,
and T the conditional-expectation operator L²₀(π_X) → L²₀(π_Y). With ρ_EE = ‖T restricted E_X → E_Y‖ (= ρ̃), ρ_EO = ‖E_X → O_Y‖,
ρ_{O·} = ‖O_X → L²₀(π_Y)‖:
 ρ ≤ ( ρ_EE² + ρ_EO² + ρ_{O·}² )^{1/2},  and  ρ_{O·} ≤ τ_X,  ρ_EO ≤ τ_Y.
*Proof.* The three-term split of Lemma 3.1 with the block norms kept as norms: |Cov(f̃, g̃)| ≤ ρ_EE‖f̃‖‖g̃‖, |Cov(f̃, g⊥)| ≤
ρ_EO‖f̃‖‖g⊥‖, |Cov(f⊥, g)| ≤ ρ_{O·}‖f⊥‖‖g‖ by definition of the norms; then the same two Cauchy–Schwarz steps. The second line is
steps (2) and (3) of Lemma 3.1's proof. ∎ On the record's objects (§7) the right side meets ρ to 10⁻⁵ relative at two steps:
the decomposition loses nothing once the O-channel is read exactly. Lemma 3.2's τ is the FREE-ENERGY HANDLE on ρ_{O·} — it turns
the O-channel into the oscillation of the conditional vortex free energy — at the price of the ess sup over the orbit, measured at
exactly the leading mode's 2√2 (SU(2)) and 2 (U(1)) at two steps. In the reader: ρ_{O·} is ‖K_A^{1/2} G Φ_B^{1/2}‖, with K the
O-channel Gram of §6 and Φ = E + K.

**§7 ADDENDUM — LOOPS, NOT LINKS.** The objects' channel shares are read on the two coarse LOOP holonomies (A ↦ −A, the coarse
plaquettes of the two faces). Theorem 3.3's R̃ and T are stated on coarse LINK variables at coarse sites, as THE GROUND's (8.5)
is. The link → loop direction is proved (a loop holonomy is a function of the links; maximal correlation, like total variation,
contracts under functions and under mixtures of conditionings: campaign §14 RESULTS Part 1, §17 item 2); the loop → link direction
— (8.5)'s link coefficient controlled by the loop one after a maximal-tree gauge fixing — is the record's open loop–link lemma
(M2 §5.2 flagged the same relation). So "the SO(3) share is ≤ 0.87 % at two steps" is a reading of the LOOP pair's direct
coupling on the planar pinned object, not a reading of Theorem 3.3's R̃.

**§9 ADDENDUM — WHAT THE FINITE SHADOWS CERTIFY (the brief's question for Q₈, 2T, 2O, 2I).** Each of Q₈, 2T, 2O, 2I contains −1,
which is central, and Haar measure on a finite group is invariant under multiplication by it; so Theorem 2.1 (the twist identity,
with Haar integrals replaced by finite sums), Proposition 2.2, Lemma 3.1–3.2, Corollary 3.1′ and Theorem 3.3 hold VERBATIM for
the finite-group Wilson theories, with the SO(3) channel replaced by the polyhedral quotient G/{±1} (the Klein four-group V₄ for
Q₈, and T ≅ A₄, O ≅ S₄, I ≅ A₅ for the binary polyhedral groups). On finite cross-sections the kernel's transfer-matrix theorems
(MassGap.lean, Separation.lean: a gap on every finite cross-section at every β for every finite group) can therefore read BOTH
channels exactly, in exact arithmetic: the vortex half as the 't Hooft-surface ratio of the twisted to the untwisted transfer
matrix, the polyhedral half as the gap of the transfer matrix on G/{±1}-class functions — with no uniformity in the cross-section,
as the record already says of every shadow. And the design residue places where a shadow can stand in for SU(2) at all: the
shadow's fundamental character coefficient agrees with SU(2)'s through order β^{t−2} and parts at β^{t−1} (t the design strength,
Proposition 8.3 of THE GROUND), so any channel reading on a shadow (Theorem 8.1 is stated for SU(2) class functions and is not
claimed for the shadows) is SU(2)'s only to that order; a finite object certifies the two-channel split of a SHADOW at one
cross-section, never the infinite-volume window.

## 12. LEMMA W AGAINST M2b's THEOREM A1 AND ITS SURVIVORS (iii-43's message; M2b WORK.md §3 read, its §5 not yet on disk)

M2b proved (Theorem A1, Corollary A1′) that every TYPICAL-environment criterion — L^p norms of the pair coefficients, or bad
environments priced by chessboard weight — is satisfied by the low-temperature Ising model, which has long-range order; what
survives is (1) removing the FINE-data supremum (fine data are integrated), (2) a GLOBAL input that fails for coexisting phases —
the slice maximal correlation, or for the centre-odd channel the distinguishability of a centre vortex — and (3) the COARSE
supremum of the FINE-INTEGRATED coefficient, which the record never read. Lemma W stands in that frame as follows.
(a) Theorem 3.3 is a decomposition OF object (3): R(y, z) is the coarse ess-sup of the conditional maximal correlation with the
fine field integrated, and R̃ ≤ R ≤ (R̃² + T² + T′²)^{1/2} splits it into the coarse sup of the fine-integrated SO(3) coefficient
(R̃) and the coarse sup of the vortex sensitivity (T). It keeps the coarse supremum, so Theorem A1 does not touch it; on the Ising
analogue (the whole spin is the label) it reads ρ ≤ τ, and the frustrated environment's τ ≥ ½ refuses, as M2b's sup form does.
(b) The two halves of Lemma W ARE M2b's two global inputs. The vortex half: Theorem 2.1 makes "the distinguishability of a centre
vortex" an exact fine-integrated quantity, the coarse flip's density ratio e^{−F} = ν(B_η | v) (a closed 't Hooft surface in the
fibre); T is the coarse sup of its oscillation, and Theorem 4.1 turns it into the twisted fibre's forgetting at distance a_c/2 —
which fails where vortices are expensive and long-range coupled (deconfined phases; U(1)'s Coulomb phase, where the π-flux free
energy does not contract), as a sound input must. The SO(3) half: its non-direct part is the outside-mediated integer-spin
covariance, the scalar glueball across one block — the even channel's slice correlation e^{−m ℓ} = ρ_π(X₀, X_ℓ), the 0⁺⁺ sector
of the transfer matrix. So M2b's "slice maximal correlation" is the global input of the SO(3) half and its "vortex
distinguishability" that of the vortex half; route 1 and M2b's Theorem C1 are one direction, and the split is by the centre.
(c) The record's objects read neither half of object (3): they pin the fine outside. What they read (§7) is the pinned integrand —
≥ 99 % vortex-channel at two steps, the SO(3) part Turán-slaved below the square — which says where the fine-integrated
coefficient's SO(3) content must come from (the outside), not how large it is.
