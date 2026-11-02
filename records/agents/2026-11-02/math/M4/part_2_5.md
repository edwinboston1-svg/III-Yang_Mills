
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
