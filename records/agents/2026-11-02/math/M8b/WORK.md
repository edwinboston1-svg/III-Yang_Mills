# M8b — THE TUBE ROUTE: THE CENTRE, THE LARGE FIELDS, THE CONVEXITY RADIUS UNDER THREE PLAQUETTE WEIGHTS

Proof agent M8b, 2026-11-02. Work directory `.../scratchpad/math/M8b/`. Appended as the work proceeds; nothing above a line is edited
after it is written except by a dated correction below it. Labels: PROVED (full proof here), PROVED GIVEN [named input], CONDITIONAL,
OPEN (with the attempt and the falsifier), COMPUTED (exact or outward-rounded arithmetic, record named), READING (double precision,
never enters a bound), READ (on a source, cited), STAKE (written before the run it predicts).

Normalisation as M8: Wilson's β = 4/g² for SU(2); links U_ℓ = exp(iB_ℓ·σ), ½tr U = cos|B|; plaquette angle θ_p ∈ [0, π] with
½tr U_p = cos θ_p. One-loop rate per step c₁(L) = 8b₀ ln L, b₀ = 11C_A/(48π²); two-loop K₂(L) = 32b₁ ln L, b₁ = (34/3)C_A²/(16π²)².

## 0. Sources read before deriving

`math/MATH_BRIEF.md` (all); `math/M8/WORK.md` (§§0–11, all; its `bin/` scripts `m8_blockspin.py`, `m8_c1_reading.py`,
`m8_c1b_gap_link.py`, `m8_h6_convexity.py`, `m8_h6_adversary.py`, `m8_c1c_l1norm.py` read; its records `rec/*` read);
`math/M6b/WORK.md` (§§0–17, all: Lemma RD, Theorem F, the ladder 10^{747.26}/10^{641.40} in Bałaban's format);
`math/M6/WORK.md` §6 (the architecture-free floor, Shearer z_c(20)) and §12; `math/M3f/WORK.md` §2 (R preserves integrals, not the
blocked law; Proposition 2.3, Consequences 2.4) and §6 (Lemma 6.2, the variational sandwich; 6.3 the L^{−2j} tree-level contraction);
III `STDLIB/scripts/aperanton_kp_cert.awk` (lines 1–120, the flux-surface gas engine fixed in 88e069862; its commit message read).
The trunk seat's three messages (2026-11-02): (1) the heat-kernel radial Hessian β + 1/θ² − 1/sin²θ and its zero θ_c(β), with the
counterweight that the composition (BCH) term grows with ∇s; (2) cite M3f Lemma 6.2 for the tree-level contraction; state the
polymer remainder for the density Bałaban's construction carries; (3) run Wilson, heat kernel and Manton side by side, report where
convexity is lost and which term binds, then the floor A1/c₁ against L.

## 1. The plan (deep-think synthesis, before deriving)

DECISION. (i) The convexity comparison first, launched in the background: M8's (4,2,2,2) torus slice (L = 2 half-open blocks), M8's
seed and hill climb, the plaquette weight a parameter — Wilson 1 − cos θ (reproduction, the instrument's kill-switch), Manton θ²/2
(the β → ∞ heat kernel and the labelled proxy for the classically perfect action's large-field shape), the SU(2) heat kernel
−β⁻¹ log[K_t(θ)/K_t(0)], t = 1/(2β), windings n ∈ {−2..2}, at β = 2.5, 5, 10, 20, with and without the per-link Haar density
−2β⁻¹ log(sin r/r). At every crossing the Hessian's quadratic form on the negative eigenvector is split exactly into
RADIAL Σ g″(θ_p)(x̂_p·J_pv)², TRANSVERSE Σ (g′(θ_p)/θ_p)|P⊥J_pv|², COMPOSITION Σ g′(θ_p) x̂_p·D²X_p[v,v] (X_p = θ_p x̂_p the Lie-algebra
plaquette, J_p = ∂X_p/∂B): the decision "radial or BCH" is then a number, not a narrative.
(ii) (A) while it runs: centre the tube on the renormalised trajectory (RT), whose existence needs only the tree-level contraction
(M3f Lemma 6.2) and a Lipschitz bound on the one-loop map (graph transform) — not the numerical one-loop fixed point. Separate the
β-independent entry transient (one computation covering every bare coupling) from the steady state; prove that the S′K_r/β term of
M8's (2.3) is an artefact of centring the band on the tree-level fixed point; give A1/ε(L) both ways.
(iii) (B): what is provable today — the isolated-plaquette barrier at quadratic order (κ = 2 relative to βt²/2), Gaussian tails
INSIDE a convex domain with the exact conditional variance (Caffarelli's contraction theorem), reflection positivity of the true
blocked law under centred odd-L averages (chessboard pricing at every scale, κ = 1 for the collective event) — and the floor
β_LF(a) priced by a Kotecký–Preiss computation done here in outward-rounded arithmetic; the open lemma (the mass outside the convex
domain at fixed small coarse data) named with its falsifier.
(iv) N2 started on loop sums of M8's real-space block covariance against the ℓ¹ products of the tree-graph count.
WHY THIS ORDER. The convexity run costs machine time and no thinking once launched; (A) is a reduction the run does not touch; (B)'s
floor needs the run's radius.
KILL-SWITCH. The Wilson reproduction must land on M8's λ_min = 1.625851 / 1.310668 / 0.909592 / 0.198619 (b = 0.2 … 0.5) before any
Manton or heat-kernel number is written; a miss larger than the hill-climb scatter stops the run for repair.

## 2. STAKES FOR THE CONVEXITY RUN (written before `bin/m8b_weights.py` runs; nothing here edited after)

S-HK.0 (KAT of the weight) The principal-branch heat-kernel radial second derivative per unit β, 1 + (1/β)(1/θ² − 1/sin²θ), vanishes at
       θ_c = 2.03 (β = 1), 2.40 (β = 2), 2.47 (β = 2.5), 2.69 (β = 5) — the trunk seat's numbers to two decimals; the winding terms
       move θ_c by less than 0.01 for β ≥ 2.5.
S-HK.1 (reproduction, kill-switch) Wilson, M8's seed 7 and loop: λ_min = 1.625851, 1.310668, 0.909592, 0.198619 at b = 0.2, 0.3, 0.4, 0.5,
       to 10⁻⁵.
S-HK.2 (Manton, rays) On the same rays the Manton weight crosses at link radius in [0.8, 1.3] (Wilson's rays: 0.656–0.92 in M8), the
       largest plaquette angle at the crossing in [2.0, 3.1]; the radial term stays positive there (g″ = 1) and the COMPOSITION term is
       the negative one.
S-HK.3 (Manton, adversarial) λ_min(b = 0.5) ∈ [0.6, 1.3]; the first b at which a non-convex configuration is exhibited lies in [0.6, 1.0].
S-HK.4 (heat kernel) b_cvx(HK, β) rises with β toward Manton's; on the same rays the heat kernel at β = 2.5 crosses at least 20 % beyond
       Wilson's radius.
S-HK.5 (Wilson's binding term) At Wilson's crossings the RADIAL term Σ cos θ_p (x̂_p·J_pv)² is the one that has fallen below zero and
       the composition term is smaller in magnitude (M8's diagnosis, made a number).
S-HK.6 (Haar) The per-link Haar density raises the small-field λ_min by 2/(3β)·(1 at most) and moves every crossing outward.

## 3. RESULTS OF S-HK.0 (record `rec/kat_thetac.2026-11-02a.txt`, rc = 0; READING; §2 unedited) AND A PROCESS NOTE

θ_c (principal branch) = 2.02876 (β = 1), 2.39629 (2), 2.48191 (2.5), 2.68473 (5), 2.82191 (10), 2.91675 (20), 2.99985 (50); with the
windings n ∈ {−2..2}: 2.07970, 2.40051, 2.48350, 2.68476, then equal to five digits. S-HK.0: HELD at β = 1, 2 (2.03, 2.40); at β = 2.5 and
5 the staked second decimals (2.47, 2.69) are each off by one unit (2.48, 2.68) — the trunk seat's desk rounding, REFUTED at the
second decimal, immaterial; the winding clause HELD (shift 0.0016 at β = 2.5, 0.05 at β = 1). The heat kernel's radial convexity edge
in plaquette angle is 142°–168° for β ∈ [2.5, 20] against Wilson's 90° at every β.
PROCESS NOTE (§4's heredoc trap, its twelfth firing, this seat): a no-op `python - <<'EOF'` typed ahead of two `sed` edits hung the
shell; stopped by TaskStop after the 300 s timeout, the process census showed no stray python, the `sed` edits never ran and were
redone with the editor. No result depends on the stopped command.

## 4. STAKES FOR THE QUADRATIC FIXED-POINT KERNEL (written before `bin/m8b_fp_kernel.py` runs; nothing here edited after)

S-A.1 The four loop classes' k² weights (transverse, k → 0) are n = (1, 8, 16, 8) per site — the Lüscher–Weisz normalisation
      c₀ + 8c₁ + 16c₂ + 8c₃ = 1 that M8 §2.2 used.
S-A.2 The successive iterate differences ‖K_{j+1} − K_j‖ of the free block map from Wilson's kernel contract by a ratio tending to L⁻²
      (0.25 at L = 2, 0.111 at L = 3): M3f's tree-level rate L^{−2j} (Lemma 6.2/6.3) read at quadratic order.
S-A.3 The perfect kernel's transverse eigenvalue obeys K_*/k² − 1 = +k²/12 + O(k⁴), the SAME along an axis and a diagonal (no O(a²)
      hypercubic violation at tree level) and the same for L = 2 and L = 3 — inferred from M8's readings (Wilson −k²/12 axis, −k²/24
      diagonal; the free fixed point +k²/6, +k²/8 relative to Wilson).
S-A.4 The four-class least-squares fit leaves a tail of relative size τ_sup ∈ [0.01, 0.10] and absolute moment ⟨|δS|⟩ ∈ [0.001, 0.05]
      per site and colour (β = 1); Wilson's own distance from the perfect kernel (the entry transient) is τ_sup ∈ [0.2, 0.5],
      ⟨|δS|⟩ ∈ [0.05, 0.2].

## 5. (A) THE CENTRE — THE FOUR-CLASS TUBE FAILS BY A β-INDEPENDENT TERM; THE TUBE AROUND THE RENORMALISED TRAJECTORY CLOSES WITH A1 = K₂

5.0 WHAT BAŁABAN'S CONSTRUCTION ALREADY CARRIES. Its density at scale k is ρ_k = Σ_σ χ_k T_k^σ exp A_k^σ with leading part
−x_k A(U_k(V)), U_k(V) the minimiser (CMP 119 (2.12), (2.23); M3f 3.1, 6.1): the leading part is the FULL classical blocked action
S_k^cl(V) := A(U_k(V)), not a truncation, and M3f (U1) identifies its limit with the classically perfect action S* of
Hasenfratz–Niedermayer (S_{k+1}^cl(V) = min_{Q(U)=V} S_k^cl(U)). M8's four-class family (its (2.1)) departed from this structure.
Two cautions carried from M3f §2: (a) ρ_k computes partition functions and source-generating functionals EXACTLY and is NOT the law
of the block variables (R preserves integrals, not densities, M3f 2.3–2.4); so the tube below is a set of such densities, and an
observable — in particular every quantity Hypotheses I/II of THE GROUND's Theorem 8.5 need about the true blocked law λ_j — rides as
a source from the bare scale; (b) the polymer remainder K below is the localized part Bałaban's construction actually carries
(E-, R-, B-terms of M3f 3.1), not a cluster expansion of the blocked law.

5.1 PROPOSITION A1 (THE FOUR-CLASS TUBE'S DEFECT; PROVED, given that every flow converges to the renormalised trajectory, 5.3).
Let 𝒯₄(β) be M8's tube (§2.2 there): S = βΣ_{i=0}^{3} c_iΣ_{Γ∈𝒞_i} s(U_Γ) + E|Λ| + Σ_X K(X), |c − c*| ≤ δ_r, ‖K‖ ≤ ε_K (moment norm at
fluctuation scale, fields of size β^{−1/2}). Decompose the perfect action S* = S*₄ + S*_tail, S*₄ its projection on the four classes.
If the flow maps 𝒯₄(β) into 𝒯₄(β′) for all β ≥ β*, then ε_K ≥ ‖βS*_tail‖ − O(1/β), and ‖βS*_tail‖ is β-INDEPENDENT; the reduction's
per-step coupling bound then carries S′_tail(1 − ρ)‖S*_tail‖_rel, a β-independent term, in place of M8's "(ε_K-feedback)".
PROOF. Every action in 𝒯₄ flows to the renormalised trajectory S_RT(β) = βS* + K_RT(β), K_RT = O(1) (5.3: the irrelevant deviations
contract at L^{−2} per step at tree level, M3f Lemma 6.2/6.3, and the loop part converges by 5.3's graph transform), so an invariant
𝒯₄ contains S_RT(β) for every β ≥ β* + c₁. In 𝒯₄'s coordinates S_RT(β) has c = c*₄ + O(1/β) and K ⊇ βS*_tail + (the loop part outside
the classes). In the moment norm at fluctuation scale, ‖βS*_tail‖ = β·O(‖S*_tail‖_rel/β) = O(‖S*_tail‖_rel), independent of β (the
action is quadratic in fields of size β^{−1/2} at leading order). The coupling bound of M8's (H3) charges the band width in every
irrelevant direction with the one-loop sensitivity, here S′_tail·(1 − ρ)·‖S*_tail‖_rel per step. ∎
WHAT IT MEANS. The four-class tube must be WIDE in the tail directions (it must contain both its centre and the trajectory), and the
reduction bounds the coupling error by the width. Whether 𝒯₄ "still suffices" is then the numerical question
S′_tail(1 − ρ)‖S*_tail‖_rel < c₁ − δ_min − K₂/β − K₃/β²; the tail's size is computed at quadratic order in §6, S′_tail is a one-loop
lattice integral (M3f Theorem B1's integrand) not computed here. The repair below makes the question moot.

5.2 DEFINITION (THE REPAIRED TUBE). For a step index k ≥ k_e (after the entry, 5.5) and coupling β, 𝒯_k(β; δ) is the set of densities
of Bałaban's class whose leading part is −βS_k^cl (the classical blocked action from the bare scale, carried exactly as Bałaban carries
it) and whose localized remainder satisfies ‖K − K_RT(β)‖ ≤ δ, K_RT(β) the loop part of the renormalised trajectory at coupling β
(5.3), the norm M3f's data norm of 3.1 (sups of e^{κd_j(X)}|·| over the analyticity domains, scaled by the class bounds), the large
fields under Bałaban's regulator; β is normalised so that K has no component along the marginal direction (the coefficient of the
continuum F² term of the leading part is β).

5.3 LEMMA RT (THE RENORMALISED TRAJECTORY EXISTS AND ATTRACTS; PROVED GIVEN (T), (L)).
(T) TREE LEVEL (M3f Lemma 6.2 and 6.3, PROVED GIVEN (Δ-i), (Δ-ii) — CMP 102-type regularity): |S_{k+j}^cl(V) − S*(V)| ≤
    C_Δ L^{−2j} Σ_{coarse p}|V(∂p) − 1|² (1 + O(α)), uniformly; the tree-level deviation from the perfect action contracts at L^{−2}
    per step (M3f states the two-cutoff form; S* is its m → ∞ limit, which exists because the right side is uniform in m).
(L) LOOP LEVEL: the step acts on the data 𝔞 = (d; E, R, B) Lipschitz-ly (M3f Lemma RL, PROVED GIVEN (ROB)), and an OLD term of scale m
    enters the scale-k potential with weight L^{−(k−m)} (M3f 3.4, (W), PROVED GIVEN [BB-c]); together, the map on the remainder's
    deviation contracts at λ := c_W L^{−1} + C_L/β < 1 for β large (c_W the weight's constant), and the coupling map is Lipschitz,
    |β′(K₁) − β′(K₂)| ≤ S′‖K₁ − K₂‖, with S′ the one-loop sensitivity (M3f Theorem B1's integrand: the one-loop Λ-ratio functional
    c(S) = 8b₀ ln Λ_S + const is a convergent lattice integral, so its derivative S′ is finite).
STATEMENT. The skew product F(β, K) = (β − c₁ + φ(β, K), G(β, K)) — β′ = β − c₁ + φ, φ = O(1/β) — has a unique invariant graph
K = K_RT(β) on β ≥ β*, the limit of the graph transform pulled back from β + nc₁ (the ultraviolet: the trajectory emanating from the
Gaussian fixed point); every orbit with ‖K₀ − K_RT(β₀)‖ ≤ δ₀ satisfies ‖K_n − K_RT(β_n)‖ ≤ λⁿδ₀; and on the trajectory
   β′ = β − c₁ − K₂/β + R_RT(β),     K₂ = 32 b₁ ln L  (SU(2), β = 4/g²),                                                        (5.1)
K₂ the UNIVERSAL two-loop coefficient: the trajectory's coupling (the F²-coefficient of the leading part) is a coupling scheme analytically
related to MS-bar at one loop, β_RT = β_MS(1/a) + O(1), and two schemes with g₂² = g₁² + O(g₁⁴) have step maps that agree to O(1/β).
PROOF. The fibre map K ↦ G(β, K) is a λ-contraction uniformly in β ≥ β* by (L); the base map is a translation by −c₁ up to O(1/β); for a
skew product with uniformly contracting fibres over a base map with bounded distortion the fibre-contraction theorem (Hirsch–Pugh–Shub)
gives the unique attracting invariant graph, Lipschitz in β with constant ≤ sup|∂_βG|/(1 − λ) = O(1/β²) (the one-loop source is
β-independent; its β-dependence enters at two loops). Attraction: ‖K′ − K_RT(β′)‖ = ‖G(β, K) − G(β, K_RT(β))‖ ≤ λ‖K − K_RT(β)‖. (5.1):
the step map restricted to the graph is a one-dimensional map β ↦ β′ which is the exact RG of the theory in the RT scheme; its
expansion's first two coefficients are scheme-independent (if β₂ = β₁ + a + O(1/β₁) then β₂′ − β₂ = β₁′ − β₁ + O(1/β₁²)). The remainder
R_RT is the remainder lemma's object (N2). ∎
STATUS: PROVED GIVEN (T) [M3f, given CMP 102 regularity] and (L) [M3f Lemma RL + (W), given (ROB), [BB-c]]; the universality of K₂ is the
perturbative statement (formal); |R_RT| ≤ K₃/β² is OPEN (§10, N2).

5.4 THEOREM A2 (THE REPAIRED REDUCTION; PROVED GIVEN Lemma RT's inputs and the remainder bound). For k ≥ k_e and S ∈ 𝒯_k(β; δ), the
blocked density lies in 𝒯_{k+1}(β′; λδ) and
   |β′ − (β − c₁)| ≤ K₂/β + K₃/β² + S′(1 − λ)δ + S′ C_Δ L^{−2k} ‖S_W − S*‖_rel.                                             (5.2)
The band δ is FREE: nothing forces δ ≥ K_r/β, because the band is centred on the trajectory itself, which is exactly invariant. Choose δ
with S′(1 − λ)δ ≤ η (a budget fixed once). Then the per-step requirement is
   K₂/β + K₃/β² + η ≤ c₁ − δ_min − S′C_ΔL^{−2k}‖S_W − S*‖_rel,                                                              (5.3)
whose last term is a TRANSIENT, gone after the entry. M8's A1 = S′K_r + K₂ becomes A1 = K₂: the S′K_r/β term of M8's (2.3) was the price
of centring the band on the tree-level fixed point c*_tree, which sits at distance K_r/β from the trajectory.
PROOF. Write S = (leading part −βS_k^cl) + K, K = K_RT(β) + δK. The step maps the leading part to −β_tree S_{k+1}^cl plus the one-loop
coupling renormalisation; the coupling equation is (5.1) on the trajectory, plus the Lipschitz increment S′·(the change of the
irrelevant data over the step) for the deviation: the deviation's irrelevant data move from δK to G(β, K) − G(β, K_RT) (norm ≤ λ‖δK‖), so
the increment is at most S′(1 − λ)‖δK‖ in the telescoped form of M8 (H3) (PROVED there from the mean value theorem); the tree-level
deviation S_k^cl − S* enters the coupling through the same one-loop functional, |Φ₁[S_k^cl − S*]| ≤ S′‖S_k^cl − S*‖_rel ≤
S′C_ΔL^{−2k}‖S_W − S*‖_rel by (T). The band: ‖δK′‖ ≤ λ‖δK‖ ≤ λδ. ∎

5.5 THE ENTRY (PROVED GIVEN (T), (L)). From Wilson's action at any bare β₀: (i) the tree-level deviation S_k^cl − S* contracts at L^{−2}
per step by (T); its total effect on the coupling is Σ_k Φ₁[S_k^cl − S*] = c(S*) − c(S_W) = 8b₀ ln(Λ_*/Λ_W), the one-loop Λ-parameter
ratio between the perfect action and Wilson's (M3f (U4), Theorem B1: a convergent lattice integral) — a β-INDEPENDENT reparametrisation of
the starting coupling, not an error; (ii) the loop remainder's distance from the trajectory starts at ‖K_W − K_RT(β₀)‖ ≤ ‖K_RT‖ ≤
(one-loop source)/(1 − λ) — a bound, so K_RT is never needed numerically — and contracts at λ. So the flow enters 𝒯_k(β_k; δ) after
k_e = max{log(‖K_RT‖/δ)/log(1/λ), log(S′C_Δ‖S_W − S*‖_rel/η′)/(2 ln L)} steps, a number INDEPENDENT of β₀: one entry computation covers
every bare coupling.

5.6 THE TABLE THE TRUNK SEAT ASKED FOR (A1/ε against L; COMPUTED in §7 with outward rounding). RT-centred: A1/ε = K₂(L)/(c₁(L) − δ_min);
as L → ∞ both c₁ and K₂ grow like ln L and K₂/c₁ = 4b₁/b₀ = 0.15657 (SU(2)) — the two-loop/one-loop ratio, L-independent. Tree-centred
(M8): (S′K_r + K₂)/(c₁ − δ_min), S′K_r ESTIMATED ≈ 2 (M8's range 0.7–6; a one-loop lattice computation not done here, and not needed
once the band is centred on the trajectory).

## 6. STAKES FOR THE CERTIFIED TABLES (written before `bin/m8b_certified.py` runs; nothing here edited after)

S-C.1 RT-centred A1/ε = K₂/(c₁ − 0.05): 0.194 (L = 2), 0.178 (L = 3), tending to 4b₁/b₀ = 0.1566 as L → ∞; tree-centred (2 + K₂)/ε:
      9.83 (L = 2), 5.76 (L = 3). β*(K₃ = 100) with A1 = K₂: 22.1 (L = 2), 16.8 (L = 3).
S-C.2 z_c(20) = 0.0188677; z_perc = 1/(19e) = 0.019366; z_KP ≈ 0.0065.
S-C.3 C(β) → 8.06 per site as β → ∞ (desk: U₁ + 4.5 ln β → 3 ln √(2/π) = −0.677, L₀ + 4.5 ln β → −4.5 ln 6 − 0.677 = −8.74).
S-C.4 the chessboard floor at a = π/2: β_LF ≈ 23.4 (z_perc), 25.9 (z_KP); at a = 2.0: ≈ 16.5 / 18.3.

## 7. RESULTS — THE QUADRATIC PERFECT KERNEL AND THE FOUR-CLASS TAIL (records `rec/fp_kernel_L2.2026-11-02a.txt` (L = 2 half-open,
## depth 3 on the 8⁴ grid + Richardson, depth 5 on 24 line momenta, 819 s) and `rec/fp_kernel_L3.2026-11-02a.txt` (L = 3 centred, depth 2
## on the 6⁴ grid + Richardson, depth 3 on the lines, 1075 s), rc = 0; READINGS; §4 unedited)

S-A.1 HELD: k² weights (1.000000, 7.999998, 15.999999, 7.999999) for (plaquette, rectangle, chair, parallelogram) — Lüscher–Weisz.
S-A.2 HELD: successive iterate differences on the lines contract by 0.643, 0.343, 0.274, 0.261 (L = 2 → 0.25) and 0.302, 0.132 (L = 3 →
      0.111): M3f's tree-level rate L^{−2} read at quadratic order; the Richardson extrapolation (ρ = L⁻²) at depth 3 (L = 2) / 2 (L = 3)
      agrees with depth 5 / 3 to 2.8·10⁻³ / 3.2·10⁻³ relative.
S-A.3 HELD ON THE AXIS, REFUTED ON THE DIAGONALS, HELD FOR L-INDEPENDENCE: K_*/k² − 1 = 0.0834 k² on the axis (+k²/12 ✓); on the face
      diagonal the transverse eigenvalues split, two at k²/12 and the in-plane one at 0.1251 k² (= k²/8); on the body diagonal 0.1042 k²
      (= 5k²/48): the perfect kernel is NOT isotropic at O(k⁴). The L = 2 half-open and L = 3 centred perfect kernels agree on every line
      momentum to six digits at small k and to 2·10⁻⁵ relative at k = 3 (within the extrapolation error).

7.1 LEMMA Q (QUADRATIC UNIVERSALITY OF THE PERFECT KERNEL; PROVED). (a) The gauge-invariant free blocked kernel depends on Bałaban's average
only through its STRAIGHT part E_B(p)S_μ(p) (block sum × line sum): the contour terms (the parallel transports from the block centre) enter
Q̂_μν(p) as (1 − e^{iLp_μ})G_ν(p) = −k̂_{c,μ}G_ν(p) with k̂_c = e^{iLk} − 1 the same for all aliases, a coarse gradient annihilated by the
curvature map W. (b) Straight parts compose: Σ_{n′∈B₂}Σ_{j′<L₂}Σ_{n∈B₁}Σ_{j<L₁}A_μ(y + L₁n′ + n + (L₁j′ + j)e_μ) = the L₁L₂ straight part
(the boxes {L₁n′ + n} and lines {L₁j′ + j} are exactly the L₁L₂ box and line, half-open or centred alike), and translating the block base
point multiplies E_B by a phase that cancels in Q̂GQ̂†. (c) Hence on gauge-invariant quadratic kernels T_{L₂}∘T_{L₁} = T_{L₁L₂}, the half-open
and centred maps coincide at each L, and K*_L = lim_n T_{L^n}K₀ is the SAME for every L — the continuum box-average perfect kernel — given
the convergence of T_M K₀ as M → ∞ (dominated convergence of the alias sums; the readings above). PROOF: (a)–(b) as written; (c) the
blocked transverse propagator is W†[W(Q G Q†)W†]⁺W, and W Q depends only on the straight part. ∎
WHAT IT EXPLAINS. M8's L-independent free fixed point (+(kL)²/6 relative to the coarse Wilson kernel on an axis, its §5) and its "second
structural reason to prefer centred blocks" coexist: at quadratic order the block shape is invisible; the centred choice matters for the
NONLINEAR theory (reflection equivariance, §9 Lemma RP-B) and for the gap γ₀ of the constrained fluctuation (M8 §11.8), not for the
perfect kernel.

S-A.4 REFUTED, FAR LARGER THAN STAKED. The four-class least-squares fit (Σ c_i n_i = 1) of the perfect kernel:
| quantity | L = 2 (8⁴ grid) | L = 3 (6⁴ grid) | staked |
|---|---|---|---|
| (c_plaq, c_rect, c_chair, c_twist) | (6.1608, −0.5278, −0.0391, −0.0391) | (6.1315, −0.5297, −0.0372, −0.0372) | — |
| τ_sup (relative, worst momentum) | 0.4529 | 0.4168 | [0.01, 0.10] |
| ⟨|δS|⟩ per site and colour (β = 1) | 0.2317 | 0.2268 | [0.001, 0.05] |
| Wilson's distance from K* (entry): τ_sup, ⟨|δS|⟩ | 0.9034, 1.0474 | 0.8941, 1.0467 | [0.2, 0.5], [0.05, 0.2] |
| tree-level Symanzik's distance: τ_sup, ⟨|δS|⟩ | 0.8414, 0.9038 | 0.8283, 0.9029 | — |
(The chair and parallelogram coefficients come out equal: at quadratic order their kernels enter the fit degenerately, and the
minimum-norm solution splits them; the fit's quality is unaffected.) The perfect kernel exceeds Wilson's at every momentum (signed ⟨δS⟩ =
absolute ⟨|δS|⟩ for Wilson): the classically perfect action is STIFFER than Wilson's in every Fourier mode, consistent with the linear
Cauchy–Schwarz bound S_cl ≥ S_W,coarse of §9.4.

7.2 VERDICT ON (A), NUMERICAL. The four-class truncation misses the perfect kernel by 42–45 % at its worst momentum and by ⟨|δS|⟩ ≈ 0.23 per
site and colour (≈ 0.69 per site with three colours) in the moment norm — 22 % of Wilson's own distance from the perfect action. By
Proposition A1 the four-class tube therefore carries a β-INDEPENDENT per-step coupling error S′_tail(1 − ρ)·(this tail); with the one-loop
Λ-ratio sensitivity of lattice actions of order 8b₀·O(1–3) = 0.37–1.1 per unit relative deviation (SU(2); the spread of known Λ-ratios
between Wilson-type actions, ESTIMATED), the four-class error is ESTIMATED at 0.06–0.2 per step against ε = 0.2075 (L = 2): the four-class
tube does not suffice; the repaired tube (§5, centred on Bałaban's own leading part S_k^cl, the full minimiser action) is required, and with
it A1 = K₂ (Theorem A2).

## 8. RESULTS — CONVEXITY ON THE SLICE UNDER THREE (FOUR) PLAQUETTE WEIGHTS (records `rec/weights_{W,M,H2.5,H5,H10,H20,H2.5h,H5h,W2.5h,W5h}.
## 2026-11-02a.txt`, all rc = 0; L = 2 half-open blocks on M8's (4,2,2,2) torus, slice dimension 270; READINGS; §2 unedited)

8.1 THE KILL-SWITCH. S-HK.1 HELD EXACTLY: the Wilson reproduction (M8's seed 7 and loop) returns λ_min = 1.625851, 1.310668, 0.909592, 0.198619
at b = 0.2 … 0.5, M8's numbers to all six printed digits (the instrument is M8's, the Hessian assembly rewritten).

8.2 THE TABLE (λ_min of the action's Hessian on the slice at link-angle sup norm b, the most negative found by the adversarial hill climb,
8 starts × 120 moves; the ray crossings over M8's 4 soft modes + 12 random rays; per unit β).
| weight | b = 0.3 | b = 0.5 | b = 0.55 | b = 0.6 | b = 0.7 | adversarial b_cvx | ray crossings (min / mean / max) |
|---|---|---|---|---|---|---|---|
| Wilson 1 − cos θ | 1.3107 | 0.1986 | −0.5124 | −2.0298 | (−2.78 at 0.65) | (0.50, 0.55) | 0.632 / 0.773 / 0.925 |
| Manton θ²/2 | 1.3855 | 0.5078 | — | −1.0368 | −7.425 | (0.5, 0.6) | 0.653 / 0.803 / 0.961 |
| heat kernel β = 2.5 | 1.2037 | 0.5211 | — | −0.8573 | −5.381 | (0.5, 0.6) | 0.665 / 0.805 / 0.963 |
| heat kernel β = 5 | 1.2908 | 0.5032 | — | −0.8597 | −6.677 | (0.5, 0.6) | 0.666 / 0.805 / 0.962 |
| heat kernel β = 10 | 1.3382 | 0.4883 | — | −0.9475 | −7.393 | (0.5, 0.6) | 0.624 / 0.802 / 0.961 |
| heat kernel β = 20 | 1.3618 | 0.4980 | — | −0.9919 | −7.136 | (0.5, 0.6) | 0.623 / 0.801 / 0.961 |
| heat kernel 2.5 + Haar | 1.4715 | 0.7907 | — | −0.5808 | −5.094 | (0.5, 0.6) | 0.654 / 0.835 / 0.986 |
| heat kernel 5 + Haar | 1.4247 | 0.6041 | — | −0.7222 | −6.534 | (0.5, 0.6) | 0.679 / 0.820 / 0.973 |
| Wilson 2.5 + Haar | 1.6134 | 0.5607 | — | −1.2480 | −3.287 | (0.5, 0.6) | 0.653 / 0.798 / 0.971 |
| Wilson 5 + Haar | 1.4795 | 0.4240 | — | −1.3894 | −3.431 | (0.5, 0.6) | 0.649 / 0.788 / 0.948 |
(Beyond b ≈ 0.8 the Manton numbers reach −300 … −900: plaquettes at θ ≈ 3.10–3.13, the cut locus of θ², where the composition term's
coefficient θ diverges against sin θ; the heat kernel smooths the kink and reads −20 … −240 there, growing with β toward Manton. These are
deep large fields, outside any small-field domain.)

8.3 THE BINDING TERM, MADE A NUMBER (the exact split of v·Hess·v on the negative eigenvector v, RADIAL Σg″(θ)(x̂·Jv)² + TRANSVERSE
Σ(g′/θ)|P⊥Jv|² + COMPOSITION Σg′(θ)x̂·D²X[v,v], reproducing v·Hv to 10⁻⁵ at every point).
(i) AT EVERY ADVERSARIAL LOSS OF CONVEXITY, FOR EVERY WEIGHT, THE NEGATIVE TERM IS COMPOSITION; the total RADIAL term is POSITIVE: Wilson
    b = 0.55: R +1.090, T +3.034, C −4.636; Manton b = 0.6: R +1.334, T +12.918, C −15.288 (one plaquette at θ = 2.196 carries T +9.41,
    C −13.07); heat kernel 2.5, b = 0.6: R +1.302, T +9.252, C −11.411. The radial term turns negative only deeper: Wilson at b = 0.65
    (R −0.117), the heat kernel at b ≥ 0.8.
(ii) ON EVERY WILSON RAY CROSSING THE TOTAL RADIAL TERM IS POSITIVE (+0.29 … +1.39) and COMPOSITION binds (−3.2 … −4.9); single plaquettes
    beyond 90° do contribute negative radial terms (−0.39 at 1.92 rad), but they are not the binding term. S-HK.5 (M8's diagnosis, "the
    plaquette function's own radial Hessian cos θ changing sign — not the BCH cross terms", staked here) is REFUTED by the exact split: the
    coincidence of the loss with plaquettes near 90° is the composition term's growth with g′(θ)·θ-scale curvature, not cos θ.
(iii) ALONG THE SOFT MODES (the standing waves at the zone face where γ₀ is attained) every weight crosses with RADIAL = 0 EXACTLY and
    TRANSVERSE = −COMPOSITION (Wilson 0.9246: T +4.8604, C −4.8604; Manton 0.8945: T +5.5377, C −5.5376; heat kernel 2.5: 0.8965; Wilson +
    Haar 0.9479): the negative eigenvector changes no plaquette's angle to first order — it is tangent to a GAUGE ORBIT through B. This is
    the GRIBOV HORIZON of the linear slice: the slice V = ker Q ⊖ (gauge directions at B = 0) ceases to be transversal to the gauge orbits;
    along an exact orbit d²S/dt² = Hess[γ′, γ′] + ∇S·γ″ = 0, so Hess[γ′, γ′] = −∇S·γ″ = TRANSVERSE + COMPOSITION, which reaches zero where
    γ′ ∈ V. The mechanism is the weight-independent geometry of the gauge fixing, not the plaquette weight.
(iv) THE WEIGHT CHANGES THE RADIUS BY LITTLE: every weight is convex at b = 0.5 and non-convex at b = 0.6 (Wilson already at 0.55); the
    rays cross at 0.62–0.99 for all. The Haar density (convex, 2/(3β) at the origin) and the heat kernel's concave log(θ/sinθ)/β shift
    λ_min by O(1/β) and the radius by < 0.02.
S-HK.2: the Manton rays cross at 0.653–0.961 (staked [0.8, 1.3]) — REFUTED below; plaquette angle at the crossing 1.19–1.98 (staked
[2.0, 3.1]) REFUTED; "radial positive, composition negative" HELD. S-HK.3: Manton λ_min(0.5) = 0.508 (staked [0.6, 1.3]) REFUTED just below;
first non-convex b in (0.5, 0.6] (staked [0.6, 1.0]) HELD at its lower end. S-HK.4: the heat kernel at β = 2.5 crosses at most a few per
cent beyond Wilson on the same rays (staked ≥ 20 %) — REFUTED. S-HK.6: the Haar density raises the small-field λ_min (1.85 → 1.87 at
β = 2.5 on the free slice is the hk scaling; Wilson + Haar 1.98 at β = 5, 2.13 … (2/(3β)) and moves the crossings outward by ≤ 0.03 —
HELD.

8.4 THE ANSWER TO THE TRUNK SEAT'S QUESTION. The link-angle convexity radius of the slice is NOT an artefact of the cosine: Wilson, the
SU(2) heat kernel at β = 2.5–20 (with or without the Haar density) and Manton — the β → ∞ heat kernel, the shape the classically perfect
action takes at large coarse angles — all lose convexity between b = 0.5 and 0.6 on this torus, by the COMPOSITION (BCH) term at single
large plaquettes (θ ≈ 1.5–2.2 rad), and along smooth soft modes at b ≈ 0.89–0.95 by the slice's GRIBOV HORIZON. The radial plaquette
Hessian — the only term the weight's shape controls (cos θ for Wilson, 1 for Manton, 1 + (1/θ² − 1/sin²θ)/β for the heat kernel) — is
never the binding term at the first loss. The trunk seat's counterweight was the operative effect: ∇s grows like θ for Manton and the heat
kernel against sin θ for Wilson, and the composition term ∝ ∇s eats the radial gain. So the large-field floor of the link-domain estimate
(M8's 1.4771/b²) is set by b ≈ 0.5: β ≥ 5.9 (L = 2) on M8's Gaussian heuristic — the same for every weight; M8's 16.4 was its choice
b = 0.3, not a property of the cosine.

## 9. (B) LARGE FIELDS — WHAT IS PROVED, THE PRICE, AND THE OPEN LEMMA

9.1 WHY (H5) IS CIRCULAR. M8's (H5) bounds P(|θ_p − θ_p^bg| ≥ a) by the χ²₃ tail of the Gaussian fluctuation measure. The Gaussian is the
measure's approximation inside the convexity domain only; the probability of LEAVING the domain is what (H5) must bound, and outside it the
measure is neither Gaussian nor log-concave. Four facts replace it, then one lemma stays open.

9.2 LEMMA QB (THE ISOLATED-PLAQUETTE BARRIER AT QUADRATIC ORDER, κ = 2; PROVED). For the free constrained fluctuation of one blocking step
(per colour, the Gaussian e^{−(β/2)‖dA‖²} on {QA = a′}/R), min{(β/2)‖dA‖² : QA = 0, F^a_p(A) = t} = t²/(2 Var(F^a_p | coarse)) ≥ βt², since
β·Var(F^a_p | coarse) ≤ ½ (M8 §4.1, PROVED: conditioning lowers a Gaussian variance below the unconditioned equipartition value ½). A single
plaquette at angle t costs at least βt² — twice the single-plaquette value βt²/2 (Bianchi forces the returning flux through other
plaquettes). PROOF: the minimum of a positive quadratic form ½xᵀCx⁻¹... on the hyperplane ⟨u, x⟩ = t is t²/(2uᵀCu), C the covariance. ∎
(It is a barrier for ISOLATED large plaquettes. A coherent region costs less per plaquette: the constant field in one plane has every
μν-plaquette at angle a and all others zero, action β(1 − cos a) per plaquette, κ = 1 — the value the chessboard bound of 9.6 attains.)

9.3 LEMMA CF (GAUSSIAN TAILS INSIDE A CONVEX DOMAIN, WITH THE EXACT VARIANCE; PROVED GIVEN (H6)). Let μ_D be the fluctuation measure restricted
to a convex set D of the slice on which Hess(S − log J − log Δ_FP) ≥ (1 − η)β Δ₀ (J the Haar density, Δ_FP the slice's Faddeev–Popov factor).
Then for every unit-coefficient linear observable f = ⟨u, B⟩ (in particular the linearised curvature F^a_p),
   μ_D(f − E f ≥ t) ≤ exp(−(1 − η)βt²/(2K_u)),  K_u := β·⟨u, Δ₀⁻¹u⟩ (≤ ½ for f = F^a_p).
PROOF. Write dμ_D = e^{−W}dγ with γ the Gaussian of covariance ((1 − η)βΔ₀)⁻¹ and W convex (the remainder of a (1 − η)βΔ₀-convex potential
plus the indicator of a convex set). Caffarelli's contraction theorem (Comm. Math. Phys. 214 (2000) 547) makes the Brenier map γ → μ_D
1-Lipschitz in the γ-metric; f∘T is then Lipschitz with constant |((1 − η)βΔ₀)^{−1/2}u| on Gaussian space and the Gaussian concentration
inequality gives the bound. ∎ This is (H5)'s χ²₃ bound made a theorem INSIDE the domain, with M8's PROVED K_var ≤ ½ and the loss (1 − η) only;
it says nothing about the mass outside D.

9.4 LEMMA CS (THE MINIMISER ACTION DOMINATES THE COARSE WILSON ACTION; PROVED AT LINEAR ORDER). For the linearised (abelian per colour) theory,
S_cl(a′) := min{½‖dA‖² : QA = a′} ≥ ½‖d′a′‖² (coarse Wilson). PROOF: by Lemma Q (7.1) only the straight part of Q acts on curvature; the
coarse curvature of a′ = Q A is (1/L²)Σ over the L² transverse offsets of the flux through the L × L arrays, a sum of L⁴ fine fluxes with
weight L⁻² each; by Cauchy–Schwarz |F′_P|² ≤ Σ_{p in P's cell}|F_p|², and the cells partition the fine plaquettes. ∎ The run of §7 reads
the same at every momentum (K* ≥ K_W). The nonlinear version (a non-abelian Stokes inequality for Bałaban's averaged links) is NAMED.

9.5 LEMMA RP-B (CENTRED ODD-L AVERAGING PRESERVES LINK-REFLECTION POSITIVITY; PROVED). Let λ_k be the true blocked law: the push-forward of
Wilson's measure on a periodic torus under k centred odd-L Bałaban averages (coarse extent even). Then λ_k is reflection positive for every
coarse link-reflection (planes bisecting coarse links).
PROOF. A coarse link plane between y_μ = 0 and y_μ = L sits at the fine half-integer L/2 (L odd): a fine link plane. The centred blocks
B(y) = y + {−(L−1)/2, …, (L−1)/2}⁴ never straddle it. A coarse link on the + side, (y, y + Le_ν) with both ends at y_μ ≥ L, is a function of
fine links in B(y) ∪ B(y + Le_ν): the parallel lines from x ∈ B(y) to x + Le_ν keep x_μ ≥ (L+1)/2 for ν ≠ μ and run in x_μ ≥ (L+1)/2 for
ν = μ, and the contours Γ_{y→x} lie in B(y). So F′∘Q ∈ 𝒜₊ for F′ ∈ 𝒜′₊. The average (logarithms of path-ordered transports averaged over
the block and over the orderings of the contour directions, exponentiated) is equivariant under the reflection, which maps B(y) to B(θy),
contours to contours, and reverses links perpendicular to the plane (the log of the reversed transport is the negative): Q∘θ = θ′∘Q off
the measure-zero cut locus. Hence ⟨Θ′(F′)F′⟩_{λ_k} = ⟨Θ(F′∘Q)(F′∘Q)⟩_Wilson ≥ 0 by Osterwalder–Seiler. Induction on k. ∎
LIMITS OF THE LEMMA. (a) The half-open L = 2 blocks with corner-based contours (THE GROUND's crossover blocks, M8's L = 2) are NOT reflection
equivariant (the reflection maps the block {0,1} to {1,2} or the corner contours to centre-ward ones), so the lemma does not cover them. (b)
SITE reflections (planes through coarse sites) cut the centred blocks; the argument gives no site-RP for λ_k. Chessboard estimates for
single-PLAQUETTE events need site reflections in the plaquette's own two directions (link reflections cut a plaquette in its own plane), so at
coarse scales the chessboard pricing of plaquette events is OPEN; link-RP gives it for events whose reflected images tile through
link planes only. At the fine scale Wilson's measure is both site- and link-RP (Osterwalder–Seiler), and 9.6 applies.

9.6 LEMMA CB-0 (THE FINE-SCALE LARGE-FIELD ACTIVITY, CHESSBOARD-PRICED; PROVED, CONSTANTS COMPUTED). For Wilson's SU(2) measure on a periodic
torus (the infinite-volume limit taken after), every set P of plaquettes and every a ∈ (0, π]:
   P(θ_p ≥ a for all p ∈ P) ≤ z₀(a, β)^{|P|},   ln z₀(a, β) ≤ −(√(β(1 − cos a)) − √C(β))²  when β(1 − cos a) > C(β),
with C(β) = U₁(β) − L₀(β) ≤ 8.046 for β ∈ [4, 60] (COMPUTED, `rec/floor.2026-11-02a.txt`), → 4.5 ln 6 = 8.063 as β → ∞.
PROOF. (i) Chessboard (Fröhlich–Israel–Lieb–Simon): site reflections in the plaquette's directions μ, ν and link reflections in the other two
are positive for Wilson's measure and generate every μν-plaquette from p, so P(∩_{p∈P}E_p) ≤ Π_p z(E_p), z(E)^{N_s} = P(all μν-plaquettes
have θ ≥ a) (the event is invariant under orientation reversal). (ii) Exponential Chebyshev: 1_{univ} ≤ exp(εβΣ_{μν}[(1 − cos θ_p) − s]),
s = 1 − cos a, so P(univ) ≤ e^{−εβsN_s}Z_ε/Z₀ with Z_ε the partition function with the μν-plaquettes at coupling (1 − ε)β. (iii) f(ε) = ln Z_ε
is convex and increasing, so f(ε) − f(0) ≤ εf′(ε) ≤ ε(f(1) − f(ε))/(1 − ε) ≤ ε(ln Z₁ − ln Z₀)/(1 − ε), Z₁ with the μν-plaquettes removed.
(iv) UPPER: in axial gauge along ρ ∉ {μ, ν} (U_ρ = 1 off the last layer, a forest), integrate U_i(x + ρ) given U_i(x) against the (i, ρ)
plaquette alone, the other factors ≤ 1: Z₁ ≤ c(β)^{3N_s(1 − 1/N_ρ)}, c(t) = ∫e^{−t(1 − cos θ)}dHaar = 2e^{−t}I₁(t)/t. (v) LOWER: Gibbs'
variational principle with the product trial ν_t ∝ e^{t cos θ}dHaar on every non-axial link: E_ν[U] = r(t)I (r = I₂/I₁: ν_t is a class
function), so E_ν[1 − cos θ_p] = 1 − r^n EXACTLY for a plaquette with n non-axial links (n = 2 for the three (i, ρ)-orientations, n = 4 for
the three others), and KL(ν_t | Haar) = −t(1 − r) − ln c(t): ln Z₀/N_s ≥ L₀(β) := max_t[3 ln c(t) + 3t(1 − r) − 3β(2 − r² − r⁴)] (the
last-layer terms vanish as N_ρ → ∞). (vi) Optimise ε: (1 − ε*) = √(C/(βs)) gives −(√(βs) − √C)². (vii) The cell bounds of
`bin/m8b_floor.py`: U₁ decreases in β; for fixed t the trial value decreases in β; so on [b_i, b_{i+1}] C(β) ≤ U₁(b_i) − L₀,t(b_{i+1}). ∎

9.7 THE PRICE AND THE FLOOR (COMPUTED, `rec/certified.2026-11-02b.txt`, `rec/floor.2026-11-02a.txt`, `rec/floor.2026-11-02b.txt`; outward
rounding). The program's certified KP engine (`aperanton_kp_cert.awk`, fixed today in 88e069862) is the flux-surface gas's — its activities
are Bessel ratios of surfaces — and does not price a hard-core plaquette gas; the three prices here are computed in the same discipline
(intervals, outward rounding): Shearer's z_c(20) = 0.0188677 (single events, the 20-regular plaquette graph); z_perc = 1/(19e) = 0.0193621
(the animal bound μ ≤ e(Δ − 1) for connected plaquette sets: below it the large-field cluster of a plaquette has an exponentially
distributed size); the Kotecký–Preiss price z_KP ≥ 0.0064884 (hard-core connected polymers of activity z^{|X|}, incompatibility
neighbourhood ≤ 21|X|, a(X) = α|X|, α = 0.466).
THE FLOOR β_LF(a) (the least β from which ln z₀ ≤ ln z* on every cell to 60):
| a (rad) | 1.0 | 1.08 | 1.2 | 1.25 | 1.4 | π/2 | 2.0 | 2.4 | π |
|---|---|---|---|---|---|---|---|---|---|
| z_perc / Shearer | 50.75 | 44.00 | 36.50 | 34.00 | 28.00 | 23.25 | 16.50 | 13.50 | 11.75 |
| z_KP | 56.25 | 49.00 | 40.50 | 37.75 | 31.25 | 26.00 | 18.25 | 15.00 | 13.00 |
(Manton barrier a²/2 — the tree-level barrier of a COARSE collective event, used only if the coarse chessboard of 9.5 (b) and the nonlinear
Lemma CS were available: 19.0 at π/2, 11.75 at 2.0, 8.0 at 2.4, 4.75 at π for z_perc.) S-C.4 HELD (23.25 / 26.00 at π/2; 16.50 / 18.25 at 2.0).
FORM OF THE FLOOR: β_LF(a) = (√C + √ln(1/z*))²/(1 − cos a) ≈ (2.837 + 1.985)²/(1 − cos a) = 23.25/(1 − cos a) (z_perc).

9.8 THE MATCHING PROBLEM (the obstruction this section exposes). The convexity domain is a box of SLICE LINK angles (b ≈ 0.5 by §8); the
priced events are gauge-invariant PLAQUETTE angles. A small-field condition θ_p < a for all p bounds the slice links only through the slice's
linear reconstruction (link ≤ c_AF·a, c_AF the ℓ¹ norm of the curvature-to-slice-link map, NOT computed here), and §8 (iii) puts the
slice's Gribov horizon at plaquette angle 1.08–1.26 along smooth modes. With a matched to that edge (a ≈ 1.2), the PROVED fine-scale floor is
β ≳ 36.5 (z_perc) / 40.5 (z_KP). The Gaussian heuristics (NOT bounds) read 5.736/a² = 4.0 (plaquette domain, a = 1.2) and 1.4771/b² = 5.9
(link domain, b = 0.5). The factor between them: κ = 1 instead of 2 (intrinsic to collective events, 9.2) and the free-energy gap C ≈ 8.05
per site (the slack of the axial upper bound and the product-trial lower bound; its true size, ln Z₁ − ln Z₀ per site, is O(1)).
9.9 OPEN, NAMED. (LF-1) The coarse-scale chessboard: site-RP of λ_k, or a substitute product bound for plaquette events of the blocked law.
FALSIFIER: a two-plaquette event of λ₁ whose probability exceeds the product of its single-event chessboard bounds. (LF-2) The conditional
large-field bound at fixed small coarse data — what Bałaban's density ρ_k needs, since ρ_k is not λ_k (M3f 2.4): the activity of a
large-field region at fixed coarse field, bounded by e^{−βκ s(a)|X| + C|X|}. FALSIFIER: a coarse configuration in the small-field set for which
the fine large-field mass is not exponentially small in β|X|. (LF-3) A sharp free-energy gap: C(β) → its true value by a correlated Gaussian
trial (lower) and a Brascamp–Lieb comparison (upper); at C = 1 the floor at a = π/2 would read (1 + 1.985)² = 8.9.

## 10. STAKES FOR THE LOOP SUMS (written before `bin/m8b_loopsums.py` runs; nothing here edited after)

S-N2.1 L = 2 half-open, 12⁴ torus: C_max = 0.1314 (M8's link variance), S₁ ≤ 2.703 (M8's ℓ¹), S₂ ∈ [0.025, 0.05], S₃ ∈ [0.0025, 0.006]; the
       sunset gain C_max²S₁/S₃ ∈ [8, 20] and the bubble gain C_maxS₁/S₂ ∈ [7, 15].

## 10 (RESULTS). N2 STARTED — THE LOOP SUMS OF THE BLOCK COVARIANCE (record `rec/loopsums_L2.2026-11-02a.txt`, rc = 0, 146 s; READING)

L = 2 half-open, 12⁴ fine torus, per colour at β = 1: C_max = 0.13145 (M8's link variance, reproduced), S₁ = 2.70255 (M8's ℓ¹, reproduced),
S₂ = Σ|C|² = 0.027824, S₃ = Σ|C|³ = 0.0024421 (block-face-crossing source; the least source 1.969 / 0.01483 / 0.000876). Tree-graph substitutes
C_maxS₁ = 0.35526 and C_max²S₁ = 0.046701: a LOOP-PRESERVING bound gains 12.8 per two-line loop (bubble) and 19.1 per three-line loop (sunset).
S-N2.1: C_max, S₁, S₂ HELD; S₃ = 0.00244 against the staked [0.0025, 0.006] REFUTED in the third digit; the gains 12.8 and 19.1 HELD (staked
[7, 15], [8, 20]).

10.1 WHAT N2 IS, AND WHY "CERTIFIED LOW ORDERS + CRUDE TAIL" DOES NOT CLOSE IT (PROVED as a statement about the method). Write the remainder
of the coupling flow as R_RT(β) = Σ_{n≥3} r_n β^{1−n} + R_np(β) (the n-loop terms and the non-perturbative remainder). A bound of the form
|r_n| ≤ C_tg^{n}·n!^{θ} (tree-graph constants, M8's C_tg ≈ 390 per vertex in units of β^{−1/2}) makes Σ_{n ≥ n₀}|r_n|β^{1−n} finite only for
β > C_tg² ≈ 1.5·10⁵ WHATEVER n₀ is: computing orders 2, 3, …, n₀ − 1 exactly moves the first term of the tail, not its radius. So the remainder
lemma needs a per-vertex constant of order one, or a non-perturbative argument. Two routes, both started here:
(a) LOOP-PRESERVING SUMS: every loop line kept as a lattice sum of products of covariances; the gains 12.8–19.1 per loop above are the first
    two such sums; a full per-vertex constant needs the vertex counts with the block propagator (24 cubic terms per link, M8 §6.4) contracted
    against S₂, S₃ instead of S₁: (24)·√(S₂)-type constants ≈ 4–24 in place of 390 (ESTIMATED; the contraction rules not written).
(b) CONVEXITY: inside the convex domain the fluctuation measure is log-concave with Hess ≥ (1 − η)βΔ₀; the Brascamp–Lieb and Caffarelli
    inequalities (Lemma CF) bound every centred moment of a smooth functional by Gaussian ones with constants independent of the order and of
    the volume. The non-Gaussian corrections to the blocked kernel's F²-coefficient are covariances of the cubic and quartic vertices; with
    the Helffer–Sjöstrand representation Cov(F, G) = ⟨∇F, (Hess V + L)⁻¹∇G⟩ the two-loop term is the Gaussian one plus a remainder bounded
    by sup|∇³V|·(moments), i.e. K₃ = O(vertex constants × S₂, S₃) — non-perturbative, no factorial. This is where N1 and N2 meet: the remainder
    lemma lives on the convex domain, and its radius (§8: b ≈ 0.5) fixes how small the large-field mass must be.
THE KNOWN ANSWER N2 MUST REPRODUCE FIRST: the two-loop per-step coefficient on the trajectory is K₂ = 32b₁ln L (0.040323 at L = 2), universal
(Lemma RT); any instrument computing the two-loop shift with the block propagator must land on it (kill-switch), before its three-loop number
or its remainder bound means anything.

## 11. EVERY COMPACT SIMPLE G (C_A → h^∨)

(i) THE STEP: with β = 2N/g² for SU(N) (Wilson's trace in the fundamental), c₁ = 4N b₀ ln L, K₂ = 8N² b₁ ln L, b₀ = 11h^∨/(48π²),
    b₁ = (34/3)(h^∨)²/(16π²)²; for a general G replace 2N by the trace normalisation of the representation in the action, h^∨ the dual Coxeter
    number. The RT-centred floor A1/ε = K₂/(c₁ − δ_min) → K₂/c₁ = 2N b₁/b₀ = 2N·(34·48/(3·11·256π²))·h^∨: 0.15659 for SU(2), 0.35232 for SU(3)
    (COMPUTED, `rec/certified.2026-11-02b.txt`); c₁ itself grows like N h^∨ (SU(3), L = 2: 0.5794; L = 3: 0.9183), so the tolerance is
    LARGER for larger groups and β*(K₃ = 100) = 13.9 (L = 2) / 10.9 (L = 3) for SU(3) against 22.1 / 16.8 for SU(2) — in each group's own β.
(ii) THE TREE LEVEL (Lemma Q, Lemma RT's (T)): colour-blind at quadratic order (abelian per generator); the perfect kernel, its four-class tail
    (0.23 per site and generator) and the contraction L⁻² hold verbatim for every G, times dim G.
(iii) THE CONVEXITY: the composition term is f^{abc}-weighted — its size scales with the structure constants (|ad X| ≤ √(2h^∨)|X| in the
    normalisation tr(T^aT^b) = ½δ^{ab}, up to the convention), and the Gribov horizon of the slice depends on G only through ad; the plaquette
    weight's radial Hessian is G-independent in the angle variable. The radius b_cvx is expected to shrink like 1/√h^∨ (NOT computed).
(iv) THE LARGE FIELDS: Lemma RP-B holds for every compact G (the averaging and Osterwalder–Seiler are group-blind); Lemma CB-0's constants
    scale with dim G: c(t) ~ t^{−dim G/2}, so the gap C_∞ = 3·(dim G/2)·ln 6 per site (4.5 ln 6 = 8.06 for SU(2), 12 ln 6 = 21.5 for SU(3),
    the factor 3 the non-axial links per site, the 6 the trial's optimal concentration t = 6β, i.e. the plaquettes per link in d = 4); the
    barrier of the collective event is β·min s on the event (1 − (1/N)Re tr U_p ≥ the group's own angle function). The floor grows with
    dim G like (√C + √ln(1/z*))²/s(a).

## 12. VERDICT — THE LOWEST β THE TUBE CERTIFIES, AND ITS DISTANCE FROM THE EXACT ENGINES

12.1 CERTIFIED END TO END TODAY: NONE. Three pieces carry no proof yet: the remainder bound K₃ (N2), the convexity certificate (N1), the
coarse-scale large-field bound (LF-1, LF-2).
12.2 WHAT IS PROVED, PIECE BY PIECE.
 * The centre: the four-class tube fails by a β-independent term (Prop. A1; numerically the tail is 0.23 per site and colour, 22 % of
   Wilson's distance from the perfect action — §7); the tube around the renormalised trajectory closes with A1 = K₂ (Theorem A2, PROVED GIVEN
   M3f's (T) [CMP 102 regularity] and (L) [(ROB), [BB-c]]): A1/ε = 0.194 (L = 2), 0.178 (L = 3), → 0.157 — the S′K_r/β floor (9.8 / 5.8) was
   the tree-level centring's artefact.
 * The perfect kernel is the same for every L and block shape (Lemma Q, PROVED): the tube's centre is one object.
 * Large fields: Gaussian tails inside the convex domain with the exact conditional variance (Lemma CF, PROVED GIVEN (H6)); link-RP of the
   true blocked law under centred odd-L averages (Lemma RP-B, PROVED); the fine-scale large-field activity priced by chessboard
   (Lemma CB-0, PROVED): β_LF = 23.25/(1 − cos a) (z_perc) — 23.3 at π/2, 36.5 at the Gribov-matched a = 1.2.
12.3 WHAT THE TUBE WOULD CERTIFY, GIVEN THE NAMED ITEMS (β*(K₃) from (5.3) with A1 = K₂, η = 0):
| item at its value | L = 2 | L = 3 |
|---|---|---|
| K₃ = 1 / 10 / 100 / 1000 (remainder lemma) | 2.29 / 7.04 / 22.05 / 69.5 | 1.76 / 5.37 / 16.80 / 52.9 |
| large fields, Gaussian heuristic, link domain at the searched b_cvx | 1.4771/0.5² = 5.9 | 1.2346/0.5² = 4.9 (soft-mode edge b ≈ 0.47–0.59) |
| large fields, PROVED fine-scale chessboard, a matched to the Gribov edge (≈ 1.2) | 36.5 (z_perc) / 40.5 (z_KP) | same (fine scale) |
| convexity (H6) | READING only (b ∈ (0.50, 0.55) Wilson … (0.6, 0.7) DHZ) | READING only |
So: on the PROVED large-field constants the tube stops at β ≈ 36–40; on the Gaussian large-field heuristic the remainder binds, β* ≈ 7 (K₃ = 10)
to 22 (K₃ = 100) at L = 2, 5.4 to 16.8 at L = 3.
12.4 THE DISTANCE FROM THE EXACT ENGINES. The W2 strip engines read at β ≤ 3–5; a certified Hypothesis I exists at β ≤ 0.4764 (Theorem 8.9,
conditional on S12). The tube, at its best conditional value (L = 3, K₃ = 10, heuristic large fields), reaches β ≈ 5.4: the two ranges would
touch only if K₃ ≲ 5 and the large-field floor came down to its heuristic value — a factor 7 below the proved one. On today's proved large-field
constants the gap is [3–5, 36], a factor 7–12 in β. The two levers, in order: (1) the large-field constant C (the free-energy gap 8.05 per site,
whose true size is O(1); at C = 1 the matched floor would be (1 + 1.985)²/(1 − cos 1.2) = 14.0, and at a = π/2 8.9); (2) K₃ by the convexity
route (§10.1 (b)).

## 6 (RESULTS). THE CERTIFIED TABLES (records `rec/certified.2026-11-02a.txt` (parts 1-2, then timed out at β = 1000 in part 3) and
## `rec/certified.2026-11-02b.txt` (parts 1-3 to β = 100; its floor table again too slow, redone by `bin/m8b_floor.py`); §6's stakes unedited)

S-C.1 HELD: K₂/ε = 0.19432 (L = 2), 0.17845 (3), 0.17342 (4), 0.17088 (5), 0.16822 (7), 0.16680 (9), 0.16590 (11), 0.16325 (27), 0.16153 (81),
      → 2Nb₁/b₀ = 0.1565873; (2 + K₂)/ε = 9.8323, 5.7628, 4.4743, 3.8210, 3.1403, 2.7768, 2.5445, 1.8662, 1.4253; β*(K₃ = 100) = 22.05 (L = 2),
      16.80 (L = 3). SU(3): K₂/c₁ = 0.3523214, K₂/ε = 0.3856 (L = 2), 0.3726 (3); β*(K₃ = 100) = 13.94 / 10.92.
S-C.2 HELD: z_c(20) = 0.01886768013; z_perc = 1/(19e) = 0.01936207585 (staked 0.019366: a desk slip in the fifth digit); z_KP ≥ 0.006488429773
      (x = 0.01034, α = 0.4660).
S-C.3 HELD: C(β) ≤ 7.5636 (β = 5), 7.8269 (10), 7.9082 (15), 7.9478 (20), 7.9868 (30), 8.0175 (50), 8.0403 (100); U₁ + 4.5 ln β = −0.9306 …
      −0.6887 → 1.5 ln(2/π) = −0.6773.

## 13. STAKE FOR THE GRIBOV CHECK (written before `bin/m8b_gribov.py` runs; the advisor's item 3)

S-G.1 At the L = 2 soft-mode crossings (Wilson b = 0.9246, Manton 0.8945) the negative eigenvector's overlap with the gauge-orbit tangent space
      at B exceeds 0.9 (READ as the Gribov horizon); random slice vectors overlap at about √(rank/384) ≈ 0.5; at B = 0 the overlap of slice
      vectors is 0 to rounding. If the overlap is below 0.5 the identification is withdrawn and the direction is called a rotation direction.

## 13 (RESULT) AND A SECOND STAKE. THE GRIBOV IDENTIFICATION IS WITHDRAWN; THE CHROMOMAGNETIC ONE IS STAKED

RESULT OF S-G.1 (record `rec/gribov_wilson.2026-11-02a.txt`, rc = 0; READING): at the Wilson soft-mode crossings (b = 0.9246, three
degenerate modes; b = 0.7012 for mode 3) the negative eigenvector overlaps the gauge-orbit tangent space at B by 0.3206 (0.3362), against
0.24–0.25 for random slice vectors (gauge span rank 95–96; at B = 0 slice vectors overlap the full-gauge span by 0.04, the coarse-site
directions, which leave the slice). S-G.1 REFUTED: the negative direction is NOT a gauge tangent. §8.3 (iii)'s "Gribov horizon" is WITHDRAWN
(dated correction: read "a direction that rotates every plaquette's Lie-algebra value without changing its angle, to first order").
S-G.2 (written before `bin/m8b_nielsen.py` runs): the soft-mode backgrounds are ABELIAN (the link-vector matrix has rank one: the free
slice form is colour-diagonal, so M8's soft modes carry one colour each) and the negative eigenvector is CHARGED (neutral fraction < 10⁻⁶):
the loss along soft modes is the Nielsen–Olesen chromomagnetic instability of charged modes in an abelian background, the composition term
being the spin coupling ad(F) in log-holonomy coordinates; the crossing field scales with the block gap γ₀ (L = 2: 0.92 at γ₀ = 1.85;
L = 3: 0.47–0.59 at γ₀ = 1).

RESULT OF S-G.2 (record `rec/nielsen_wilson.2026-11-02a.txt`, rc = 0; READING) — HELD. At the three degenerate soft-mode crossings
(b = 0.9246, max plaquette angle 1.2250) the background's link-vector matrix has singular values (1, 0, 0) to six digits — ABELIAN — and the
two lowest eigenvectors (a degenerate pair at λ = 0, then 0.0773) have neutral fraction Σ(v·n)²/|v|² = 2·10⁻²⁰ … 1.7·10⁻¹⁷ — CHARGED, the
pair being the two charged polarisations W^±. Soft mode 3 (background of rank two, singular values (1, 0.285, 0)): neutral fraction 1.2·10⁻³.
THE IDENTIFICATION (READ): the loss of convexity along smooth modes is the NIELSEN–OLESEN (Savvidy) chromomagnetic instability — charged
vector fluctuations in an abelian background F have the spectrum (2n + 1)|F| ± 2|F| + k², the spin-aligned n = 0 level at −|F| — infrared-
regulated by the block gap γ₀ on the slice: the crossing field grows with γ₀ (plaquette angle 1.23 at γ₀ = 1.85, L = 2; 0.47–0.59 at γ₀ = 1,
L = 3, Manton and Wilson rays of §15). The COMPOSITION term of the log-holonomy split is the vector boson's spin coupling ad(F) (the g = 2
magnetic moment) written in those coordinates — the same coupling whose paramagnetic −4 against the diamagnetic +1/3 makes b₀ =
(11/3)C_A/(16π²) positive (Nielsen 1981, Hughes 1981). The term that makes Yang–Mills asymptotically free is the term that bounds the
convexity radius of its gauge-fixed action.

## 14. DATED CORRECTIONS (2026-11-02, after an adversarial review; nothing above edited)

14.1 TO §9.6–9.8 AND §12.3–12.4 (STATUS OF THE LARGE-FIELD FLOOR). Lemma CB-0 is PROVED for WILSON'S measure, i.e. for the large fields of the
FIRST blocking step, whose bare β₀ is as large as one likes. Every later step works with the blocked law λ_k, for which the plaquette
chessboard is OPEN (9.5 (b), LF-1). So the floors 23.25/(1 − cos a), 36.5 at a = 1.2, and §12's "on the proved large-field constants the
tube stops at β ≈ 36–40" are CONDITIONAL on the NAMED assumption (LF-1′) that the coarse-scale chessboard holds with the fine-scale constants
(C_k ≤ C₀ ≈ 8.05, s_k(a) ≥ 1 − cos a). The numbers stand; the status word is CONDITIONAL.
14.2 TO §12.3 (THE L = 3 COLUMN). The Gribov-matched a ≈ 1.2 (now: the chromomagnetic edge, §13) is an L = 2 number. At L = 3 the soft modes lose
convexity at link radius 0.47–0.59 (Manton), 0.56–0.90 (Wilson), with plaquette angle EQUAL to the link radius (§15), so the matched plaquette
angle there is a ≈ 0.5: the plaquette-domain floor is > 60 in the conditional chessboard form and 5.736/0.25 ≈ 23 on the Gaussian heuristic.
THE TRADE-OFF, stated: the tolerance c₁ = 8b₀ ln L grows like ln L while the soft-mode convexity radius tracks γ₀(L) = 4 sin²(π/(2L))
(centred blocks; M8 §11.8) ∝ L⁻², so the large-field floor in the plaquette domain grows like L⁴/(ln-dependence): the L = 3 preference of M8
§9.1 (from ε alone) is REVERSED once the convexity radius is priced; at L = 3 the Haar density at finite β (2/(3β) = 0.27 at β = 2.5, 27 % of
γ₀) moves the soft-mode edge back out to 0.61–1.01 (§15), so the reversal is weakest at the smallest β.
14.3 TO §8.3 (iii) AND §8.4. "Gribov horizon" is WITHDRAWN (S-G.1 refuted, §13); read "the Nielsen–Olesen chromomagnetic edge" (S-G.2 held).
The L = 3 soft-mode losses have RADIAL ≠ 0 (+0.52 … +0.88) and are not exact rotation directions; the exact RADIAL = 0 signature is L = 2's.
14.4 TO §5.3 (LEMMA RT's (L)). M3f's Lemma RL is a sup-norm LIPSCHITZ bound, not a contraction (M3f's own remark after 3.3: old history terms are
carried unchanged; the contraction lives in how old terms enter new ones, the weight (W) L^{−(k−m)}), and M3f marks the deep R-terms MARGINAL
(polynomial decay). So the fibre contraction λ < 1 of Lemma RT holds in the SCALE-WEIGHTED data norm (weights L^{−(k−m)} on terms of scale m) for
the E- and B-history, with the R-terms' polynomial rate carried separately: Lemma RT is PROVED GIVEN a weighted-norm contraction (the mechanism
of M3f's Theorem U), not "given Lemma RL". Theorem A2's coupling bound needs only the band bounded and survives; the entry time k_e inherits the
slower (polynomial) rate of the R-terms.
14.5 TO §9.3 (LEMMA CF). K_u := ⟨u, Δ₀⁻¹u⟩ = β·Var_Gauss(f) (≤ ½ for f = F^a_p), not β⟨u, Δ₀⁻¹u⟩. Caffarelli's theorem is stated for e^{−W}dγ with W
convex and finite; the restriction to a convex set is obtained by approximating its indicator by convex potentials W_n ↑ (∞ off D) and passing
to the limit in the concentration inequality (the Lipschitz constant of the Brenier maps is uniform in n).
14.6 TO §8.3 (THE SPLIT). RADIAL / TRANSVERSE / COMPOSITION are defined relative to the log-holonomy coordinates X_p = log U_p of each loop; "which
term binds" is a statement in those coordinates (the coordinates of the trunk seat's question).
14.7 TO THE DHZ WEIGHT (§15). Where the published eight-parameter fit drives a loss (the six-link RADIAL term along the soft mode, from c₄′ = −0.0035),
it is a property of the PARAMETRISATION outside its fitted range — the paper's own text (src_dhz/dhz.txt l. 113–117): "The fit is not designed
to work for configurations which are much smoother or coarser than the ones we present to be minimized" (Wilson β = 1.5–2.5 samples) — not of the
fixed-point action.
14.8 TO §9.5 (LEMMA RP-B). The averaging used is M8's transcription of CMP 109 (0.3)–(0.4) (`m8_blockspin.py`, linearised; the nonlinear average
of logarithms as described there), not CMP 109 read today: PROVED GIVEN the average as transcribed.
14.9 TO §3's PROCESS NOTE. The heredoc trap fired TWICE in this seat: the no-op `python - <<'EOF'` ahead of two `sed` edits (stopped after 300 s),
and later a `python -E -P - <<'PYEOF'` (stopped after the 300 s timeout; census: no stray process; nothing depended on it). Both recorded.
14.10 TO §2 S-HK.6's RESULT LINE (§8.3). The garbled clause "Wilson + Haar 1.98 at β = 5, 2.13 … (2/(3β))" reads: the free slice λ_min with the
Haar density is 1.9829 (Wilson, β = 5: 1.8496 + 2/15 = 1.9829 exactly) and 1.8696 for the heat kernel at β = 2.5 (1.8496·(1 − 1/7.5) + 2/7.5).

## 16. WHAT UNIFIES

(U1) THE CONVEXITY EDGE IS THE CHROMOMAGNETIC (NIELSEN–OLESEN) INSTABILITY, AND IT IS THE SAME TERM AS ASYMPTOTIC FREEDOM. Along smooth modes the
     gauge-fixed lattice action stops being convex where an abelian background's charged fluctuations reach the Nielsen–Olesen tachyon, the
     infrared cut-off being the block gap γ₀ (§13, READ: abelian background to six digits, charged eigenvector to 10⁻¹⁷); the binding
     "composition" term is the vector boson's g = 2 spin coupling ad(F) in log-holonomy coordinates — the paramagnetic −4 of the Nielsen–Hughes
     decomposition of b₀ = (11/3)C_A/(16π²). So the one coupling that drives the coupling down the tube (c₁ > 0) is the one that bounds the tube's
     small-field domain, and both scale with h^∨. The plaquette weight's own radial Hessian (Wilson's cos θ) is never the binding term at the
     first loss; the "90°" of M6/M8 was the composition term's growth.
(U2) THE TUBE IS THE PERFECT ACTION'S STABLE MANIFOLD AT ONE LOOP, AND ITS CENTRE IS BLOCK-BLIND. Lemma Q: the gauge-invariant free block map sees
     Bałaban's average only through box sums, which compose (E_{L₁L₂}(p) = E_{L₁}(p)E_{L₂}(L₁p)); so T_{L₂}∘T_{L₁} = T_{L₁L₂} at quadratic order
     and the perfect kernel is one object for every L and both block shapes — the classical analogue of a scheme-independent fixed point.
     Theorem A2 is then the graph-transform statement (Hirsch–Pugh–Shub) of a contracting skew product over the translation β ↦ β − c₁: centring
     the band on the invariant graph rather than on the tree-level point removes the O(1/β) S′K_r term exactly as a normal-form change of
     coordinates removes a resonant term — M8's A1 = S′K_r + K₂ was a coordinate artefact; A1 = K₂ is universal.
(U3) REFLECTION POSITIVITY IS A FUNCTORIAL PROPERTY OF THE CENTRED BLOCK MAP, AND THE CHESSBOARD IS THE PRICE LIST OF FRUSTRATION. Lemma RP-B
     (link-RP survives every centred odd-L averaging) is the push-forward statement Θ′∘Q = Q∘Θ; at the fine scale the chessboard turns it into
     a product bound for large-field events (Lemma CB-0) — exactly the mechanism the converged missing step at the crossover names ("frustrated
     data priced by their chessboard probability"). Two numbers decide whether it reaches coarse scales: site-RP of the blocked law (LF-1) and the
     free-energy gap C (8.05 per site today, O(1) in truth). THE GROUND's half-open L = 2 blocks are not reflection equivariant; centred blocks
     are — a third reason to move the crossover's carrier to centred blocks (beside M8's γ₀ and §14.2's trade-off).
(U4) THE REMAINDER LEMMA IS A CONVEXITY STATEMENT, NOT A SERIES. A tree-graph constant C_tg fixes the radius of every tail at β > C_tg² whatever
     orders are computed (§10.1): the remainder must be bounded on the convex domain by Brascamp–Lieb / Helffer–Sjöstrand, whose constants are
     loop sums of the block covariance (S₂ = 0.0278, S₃ = 0.00244 per colour, 13–19× below the tree substitutes). N1 (the convex domain's radius)
     and N2 (the remainder) are one object: the Witten Laplacian of the fluctuation measure on the slice, whose lowest eigenvalue is the convexity
     margin and whose inverse is the covariance the remainder is written in.

## 17. LEDGER (this agent's rows)

| Item | Status | Where |
|---|---|---|
| the four-class tube carries a β-independent coupling error S′_tail(1 − ρ)·tail; the tail of the perfect kernel outside the four classes is τ_sup 0.42–0.45, ⟨|δS|⟩ 0.23 per site and colour | PROVED (Prop. A1); READING (the tail) | §5.1, §7 |
| Theorem A2: the tube around the renormalised trajectory closes with A1 = K₂; the S′K_r/β term was the tree-level centring's artefact | PROVED GIVEN M3f (T) [CMP 102 regularity], a scale-weighted contraction (M3f Theorem U's mechanism), and |R_RT| ≤ K₃/β² | §5.3–5.5, §14.4 |
| A1/ε = K₂/(c₁ − 0.05): 0.19432 (L = 2), 0.17845 (3) … → 0.15659 (SU(2)), 0.35232 (SU(3)); tree-centred (2 + K₂)/ε 9.83 / 5.76 | COMPUTED (intervals) | §6 results |
| Lemma Q: the free perfect kernel is the same for every L and block shape (box sums compose; contours drop out) | PROVED (given the M → ∞ convergence of T_M K₀, READ) | §7.1 |
| the perfect kernel: K*/k² − 1 = k²/12 (axis), k²/12, k²/8 (face diagonal), 5k²/48 (body diagonal); K* > K_W at every momentum | READING | §7 |
| Lemma QB (isolated-plaquette barrier βt², κ = 2) | PROVED | §9.2 |
| Lemma CF (Gaussian tails inside the convex domain with K_u = β·Var ≤ ½) | PROVED GIVEN (H6) | §9.3, §14.5 |
| Lemma CS (minimiser action ≥ coarse Wilson, linear order) | PROVED (linear); nonlinear NAMED | §9.4 |
| Lemma RP-B (centred odd-L averaging preserves link-RP of the blocked law; half-open corner blocks not equivariant; site-RP not obtained) | PROVED GIVEN the average as transcribed | §9.5, §14.8 |
| Lemma CB-0 (fine-scale chessboard activity, ln z₀ ≤ −(√(β(1 − cos a)) − √C)², C ≤ 8.046 on [4, 60]) | PROVED; constants COMPUTED | §9.6 |
| prices z_c(20) = 0.0188677, z_perc = 0.0193621, z_KP ≥ 0.0064884 | COMPUTED | §6, §9.7 |
| large-field floor 23.25/(1 − cos a) (z_perc): 23.25 (π/2), 36.5 (a = 1.2), 16.5 (2.0) | COMPUTED for the first step; CONDITIONAL (LF-1′) for every later step | §9.7, §14.1 |
| convexity radius on the L = 2 slice: Wilson (0.50, 0.55), heat kernel β = 2.5–20 and Manton (0.5, 0.6), DHZ (0.6, 0.7) partial; the binding term COMPOSITION at every first loss | READING | §8, §15 |
| M8's "radial cos θ binds" diagnosis | REFUTED by the exact split | §8.3 (ii) |
| soft-mode losses: abelian background, charged eigenvector — the Nielsen–Olesen edge; "Gribov" | READ (chromomagnetic); Gribov WITHDRAWN | §13 |
| L = 3 soft-mode edge 0.47–0.59 (Manton), plaquette angle = link radius; the L-trade-off reverses M8's L = 3 preference | READING; the trade-off stated | §14.2, §15 |
| loop sums S₂ = 0.027824, S₃ = 0.0024421 (L = 2), gains 12.8 / 19.1 over tree substitutes | READING | §10 |
| "certified low orders + crude tail" cannot close N2 (the tail's radius is C_tg²) | PROVED (as a statement about the method) | §10.1 |
| K₃ (the remainder lemma), the convexity certificate (N1), LF-1, LF-2 | OPEN (named, falsifiers given) | §9.9, §10.1, §12 |

## 15. RESULTS — THE FOURTH WEIGHT (DHZ) AND BAŁABAN'S BLOCK (L = 3 CENTRED) (READINGS)

15.1 THE DHZ EIGHT-PARAMETER FIXED-POINT ACTION (DeGrand–Hasenfratz–Zhu, hep-lat/9604018, READ on the extracted text `src_dhz/dhz.txt`
(PDF sha256 prefix ae4817cf238a6e08), Eq. 4: S(V) = ½Σ_C[c₁(2 − Tr V_C) + c₂(2 − Tr V_C)² + c₃(·)³ + c₄(·)⁴], C the plaquette and the
perimeter-six loop (x, y, z, −x, −y, −z); Table 1: plaquette .3333 .00402 .00674 .0152, six-link .08333 .0156 .0149 −.0035; "We chose the c1
coefficients so that the approximate FP action is O(a²) improved" — c₁ + 8c₁′ = 1, the Lüscher–Weisz normalisation, checked). Per unit β,
g_C(w) = c₁w + 2c₂w² + 4c₃w³ + 8c₄w⁴, w = 1 − cos θ_C; 192 plaquettes and 512 six-link loops (16 shapes per site) on M8's torus; code
`bin/m8b_dhz.py` (generated by `bin/make_dhz.py` from the weights script), records `rec/dhz_rays.2026-11-02a.txt`, `rec/dhz_adv_{0.4,0.5,
0.6,0.7}.2026-11-02a.txt` (one process per b, seed 7 each).
KAT (the trunk seat's desk numbers): the plaquette weight's radial second derivative vanishes at θ = 2.37550 (136.11°, cos = −0.72062) —
HELD (desk: c ≈ −0.7205, 136°); at 90° it is 1.6370 per unit β (the desk's 3.27 omitted Eq. 4's ½; zeros unaffected). The SIX-LINK weight is
radially convex only to 98.21° (cos = −0.14286): its negative c₄′ turns it over just past Wilson's 90°.
FREE SLICE: λ_min = 1.837052 (Wilson 1.849564; the six-link loops' O(k⁴) differs).
RAYS: the three soft modes cross at 0.82688 (max plaquette angle 1.0825) with PLAQ RADIAL +0.8796 and SIX RADIAL −0.8796, transverse and
composition ≈ 0: a NEUTRAL radial loss caused by the six-link loops passing their 98° edge — the parametrisation's negative c₄′ outside its
fitted range (§14.7), not the fixed-point action. Soft mode 3: 0.71916. The twelve random rays cross at 0.773–1.009 (Wilson 0.632–0.880,
Manton 0.667–0.961 on the same rays), the plaquettes' COMPOSITION term binding (−2.8 … −13.2) with the six-link composition beside it.
ADVERSARIAL (8 starts × 120 moves per b): λ_min = 1.5026 (b = 0.4, 7 of 8 starts at the hand-off), 1.1385 (0.5, 7 of 8), 0.4815 (0.6, all 8:
convex on every configuration tried; at the best, PLAQ R +0.441 T +2.199 C −2.709, SIX R +0.490 T +3.302 C −3.241), −6.1998 (0.7, 7 of 8:
NON-CONVEX EXHIBITED). b_cvx(DHZ) ∈ (0.6, 0.7) — the largest of the four weights (Wilson (0.50, 0.55), heat kernel and Manton (0.5, 0.6)): the
published fixed-point action puts only c₁ = 1/3 of its weight on the plaquette, so the composition term at a single large plaquette carries a
third of Wilson's coefficient, and the six-link loops spread the rest. The binding term at the loss is again COMPOSITION (plaquette and
six-link alike); the radial term is positive. On M8's link-domain Gaussian heuristic (NOT a bound) the floor 1.4771/b² reads 4.1 (b = 0.6)
to 3.0 (b = 0.7) at L = 2 — inside the exact engines' reading range 3–5. This is the one place where a published fixed-point shape helps, and
it helps through the weight's DISTRIBUTION over loops, not through its radial convexity (the DHZ plaquette's 136° edge never binds).

15.2 L = 3 CENTRED BLOCKS, THE (6,3,3,3) TORUS (`bin/m8b_weights3.py`, generated by `bin/make_weights3.py`: Bałaban's centred average in real
space, coarse sites at multiples of 3; slice dimension 1440, |QG| = 2.5·10⁻¹⁶, the free slice λ_min = 1.000000 six-fold — M8's γ₀ = 1 at the
face; records `rec/weights3_{W,M,H2.5h}.2026-11-02a.txt`).
| weight | soft-mode crossings (max plaquette angle) | random rays | adversarial |
|---|---|---|---|
| Wilson | 0.5706 (0.571), 0.5603 (0.560), 0.8963, 0.7127 | 0.673–0.849 | b = 0.4: 0.4455 (8 starts); b = 0.5: 0.1869 … (4 of 8 starts) |
| Manton | 0.5512, 0.4709, 0.5116, 0.5881 (= link radius) | 0.671–0.870 | running at hand-off |
| heat kernel 2.5 + Haar | 0.7951, 0.9866, 0.6110, 1.0076 | 0.726–0.925 | — |
The binding term at every L = 3 crossing is COMPOSITION, with RADIAL > 0 (+0.29 … +1.10). The L = 3 soft-mode backgrounds are COLOUR-MIXED
(`rec/nielsen3_wilson.2026-11-02a.txt`: link-vector singular values (1, 0.716, 0.464), (1, 0.562, 0.214), (1, 0.236, 0.040), (1, 0.291, 0.094); negative eigenvector neutral
fraction 0.52–0.58): the six-fold degenerate free eigenspace mixes colours, so these rays test non-abelian backgrounds, not the abelian
Nielsen–Olesen setting of L = 2; single-colour L = 3 soft modes were not run. At β = 2.5 the Haar density (+2/(3β) = 0.267, 27 % of γ₀)
moves the L = 3 soft-mode edge from 0.47–0.59 out to 0.61–1.01.
15.3 READING OF 15.2 FOR THE VERDICT. Along smooth modes Bałaban's block has the smaller convex domain (soft-mode edge 0.47–0.57 for the pure
weights against 0.89–0.92 at L = 2), as §14.2 states; at single large plaquettes the adversarial λ_min at b = 0.5 are comparable in absolute
value (0.19 at L = 3, 0.20 at L = 2) against free gaps 1.00 and 1.85, so the composition term's grip is the same and the margin is γ₀'s.

## 18. CLOSING NOTES (2026-11-02, at hand-off; nothing above edited)

18.1 ORDER. §15 (the DHZ and L = 3 results) was appended after §16–17 because those runs finished last. The ledger row "DHZ (0.6, 0.7)
partial" (§17) reads: b = 0.6 convex on all 8 starts (λ_min 0.4815), b = 0.7 non-convex exhibited (−6.1998, 7 of 8 starts); b_cvx(DHZ) ∈ (0.6, 0.7).
18.2 THE TRUNK SEAT'S QUESTION "CAN THE TUBE REACH β ≈ 3", ANSWERED PIECE BY PIECE. (i) The coupling inequality with A1 = K₂ needs K₃ ≲ 1 for
β* ≈ 2.3 (L = 2) or K₃ ≲ 2 for β* ≈ 2.5 (L = 3): the remainder lemma at that size is OPEN, and §10.1 says how it must be proved (convexity, not
series). (ii) Large fields + convexity on M8's link-domain Gaussian heuristic (NOT a bound): 5.9 (Wilson, heat kernel, Manton: b ≈ 0.5) and
3.0–4.1 with the published fixed-point action (DHZ: b ∈ (0.6, 0.7)) at L = 2 — inside the engines' 3–5. (iii) On the PROVED fine-scale
chessboard constants, carried to coarse scales by the named assumption LF-1′: 36.5 at the chromomagnetic edge — the free-energy gap C ≈ 8 per
site is the lever (§9.9 LF-3). So β ≈ 3 is reachable only on the heuristic large-field constants, with the perfect action's loop distribution
(DHZ-like) as centre, and with K₃ ≲ 1–2 — three items, each named.
18.3 RECORDS STILL RUNNING AT HAND-OFF: `rec/weights3_W` (L = 3 Wilson, b = 0.5, 4+ of 8 starts, λ_min ≥ 0.187 so far), `rec/weights3_M`
(L = 3 Manton adversarial), `rec/dhz_adv_{0.4,0.5,0.7}` (8th start). They change no bracket stated above unless an L = 3 start at b = 0.5 goes
negative (then b_cvx(L = 3, Wilson) < 0.5).
18.4 DHZ COMPLETE (all four records rc = 0, 8 starts each): λ_min = 1.5026 (0.4), 1.1385 (0.5), 0.4815 (0.6, convex), −6.1998 (0.7). At the b = 0.7
best: max plaquette angle 2.6745 (153°, past the DHZ plaquette's 136° radial edge), PLAQ R −0.979 T +43.965 C −50.823, SIX R +1.331 T +3.521
C −3.216 — the COMPOSITION term binds (−50.8 against the radial −0.98, which turned negative only on that one deep plaquette).
18.5 LEMMA Q AT FINITE DEPTH (record `rec/lemmaQ.2026-11-02a.txt`, rc = 0; READING): on 40 random momenta, T₂∘T₂ (half-open) = T₄ (half-open) to
2.8·10⁻¹⁴ relative, T₃ (centred) = T₃ (half-open) to 6.8·10⁻¹⁵, against the control T₄ vs T₃ = 0.16 (not vacuous). So (a) and (b)–(c)'s
composition identity hold exactly (the algebraic proof of §7.1, now also read to rounding); what remains READ is only the M → ∞ convergence that
makes the L = 2 and L = 3 limits the same object (agreeing to 2·10⁻⁵ in §7).
18.6 WORDING. §13 and §16 (U1): the composition term "is" the spin coupling ad(F) AT LEADING ORDER in the field (the BCH second-order term is the
commutator); the split itself is exact and the abelian/charged structure at the L = 2 crossings is read — the identification is READ, the
equality leading-order.
18.7 TWO CERTIFIED-ROW CORRECTIONS. (a) §6 (results): z_perc's stake 0.019366 against the computed 0.0193621 was an arithmetic error in my stake
(1/(19e) = 0.019362…), not a desk rounding. (b) §12.3, L = 3 Gaussian link floor: with the L = 3 soft-mode edge 0.47–0.59 it is 1.2346/0.59² to
1.2346/0.47² = 3.5–5.6, not the single 4.9.
18.8 STATUS OF §9.7–9.8's FLOOR NUMBERS. Every floor value in §9.7's table and §9.8 is PROVED for the first blocking step (Wilson's measure)
only, and CONDITIONAL on LF-1′ (§14.1) at every later step.
18.9 THE DHZ NUMBER. The 3.0–4.1 of §15.1 is M8's named link-domain Gaussian heuristic applied to a READING of a published fit outside its fitted
range; the finding is the mechanism (the fixed-point action's weight distributed over loops shrinks the plaquette's composition term), the
number a heuristic reading of it.
18.10 AFTER HAND-OFF (record `rec/weights3_W.2026-11-02a.txt`, complete, rc = 0): L = 3 centred, Wilson, adversarial 8 starts per b: λ_min = 0.4455
(b = 0.4), 0.1647 (b = 0.5; at the best R +0.379 T +1.574 C −1.789 — composition again the negative term). Convex on every configuration tried
at b = 0.5; with the soft-mode ray crossings at 0.5603 / 0.5706, b_cvx(L = 3, Wilson) ∈ (0.50, 0.56] by search. No bracket stated in the hand-off
changes.
18.11 AFTER HAND-OFF (record `rec/weights3_M.2026-11-02a.txt`, complete, rc = 0; every launched process has now exited): L = 3 centred, Manton,
adversarial 8 starts per b: λ_min = 0.4933 (b = 0.4), 0.2048 (b = 0.5; at the best R +0.406 T +1.837 C −2.038). The hill climb at fixed sup norm
finds no non-convex configuration at b = 0.5, while the soft-mode RAYS cross at 0.4709–0.5881: along those colour-mixed smooth modes convexity
is lost at b = 0.471 < 0.5 — the adversarial climb (random starts, 120 moves) does not find the soft-mode direction, a limit of the search, so
b_cvx(L = 3, Manton) ≤ 0.471 by the rays. No bracket stated in the hand-off changes (the hand-off already quoted the L = 3 soft-mode edge
0.47–0.59 as the binding L = 3 number).
