# M8 — THE MIDDLE REGION: A CONE OF EFFECTIVE ACTIONS CROSSED BY CERTIFIED BLOCKING STEPS

Proof agent M8, 2026-11-02. Work directory `.../scratchpad/math/M8/`. Appended as the work proceeds; nothing above a line is
edited after it is written except by a dated correction below it. Labels at their strength: PROVED (full proof here),
COMPUTED (exact or outward-rounded arithmetic, record named), READ (on a source, cited), ESTIMATED (rests on a named
assumption), READING (double precision, labelled, never enters a bound), STAKE (written before the run it predicts).

Normalisation: Wilson's β = 4/g² = 4/g_YM² for SU(2) (M3 §4, M6 §0); g_B² = 1/β is Bałaban's. The one-loop rate per blocking
step of factor L is c₁(L) = 8 b₀ ln L with b₀ = 11 C_A/(48π²); SU(2): b₀ = 22/(48π²) = 0.0464389…, c₁(2) = 0.257513…,
c₁(3) = 0.408146…. Two-loop: b₁ = (34/3) C_A²/(16π²)², the β-shift per step at two loops 8 b₁ ln L · (4/β) more.

## 0. Sources read before deriving

`math/MATH_BRIEF.md` (all); `math/M6/WORK.md` (§§0–12, all); `math/M3c/WORK.md` §§1–7 (Lemma M: CMP 116 §2 is a theorem
about the cone 𝒱(ε) of potentials; Lemma FP: the one-loop coupling deformation is background-independent); `math/M3b/WORK.md`
§§5–6, 15 (the block map: L odd, Bałaban's centred average, CMP 109 (0.3)–(0.4); the block-factor collision with THE GROUND's
L = 2 half-open blocks, §15.4); THE GROUND `source/ground/content4.js` §8.1 (the carrier: five links) and §8.3 (Theorem 8.5,
Hypotheses I and II).

## 1. The plan (deep-think synthesis, before deriving)

THE CRUX, STATED AS A NUMBER. One step maps C(β) into C(β′), β′ = β − c₁ ± ε. Progress needs β′ ≤ β − δ_min with δ_min > 0;
not overshooting the meeting window needs β′ ≥ β − δ_max. So the whole tolerance is ε < c₁ IN ABSOLUTE β UNITS:
0.2575 (L = 2), 0.4081 (L = 3). Tree level preserves the continuum F² coefficient exactly (classical scale invariance of
four-dimensional Yang–Mills), so the marginal parameter of the cone must be β_phys, the coefficient of the continuum F² term
of the effective action — not the bare plaquette coefficient, which tree-level blocking trades O(β) weight against the
dimension-six loops (rectangle, chair, twisted). The cone property then reads
   β_phys′ = β_phys − c₁ − c₂(L)/β_phys + R,   |R| + |transient of the irrelevant ratios| ≤ ε,
and in g² units the remainder must satisfy |R_{g²}| ≤ ε g⁴/4 — at β = 50 that is 3.2·10⁻⁴ against the one-loop
4.1·10⁻⁴. The true two-loop term is 0.3 % of the one-loop term at β = 50. So the feasibility question is whether a
RIGOROUS remainder bound can be brought within the factor (tolerance)/(truth) of the truth at the given β.

TWO METHOD CLASSES. (S) The SUP class (Bałaban; M6's family): the non-Gaussian action is bounded in sup over the small-field
domain |U_p − 1| < a, and large fields are priced by probability. (M) The MOMENT class: the remainder is bounded in Gaussian
moment norms (M3c's moment form; Bałaban's own remark CMP 116 p. 8 "use g_k|B| instead of ε₁"), the low orders extracted
exactly.

THE COMPUTATIONS, IN ORDER OF LEVERAGE.
 C1 (certified; the input to every bound) — the free (linearised, abelian per colour) blocking step on ℤ⁴ for L = 2 and L = 3
    (centred): the conditional variance of a fine plaquette's curvature given the block averages, the gap of the constrained
    fluctuation form, the decay and ℓ¹ norm of the fluctuation covariance. In Fourier space the step factorises over coarse
    momenta: each coarse momentum is a finite matrix problem on the L⁴ aliases — the "smallest block" read exactly.
 C2 — THE WINDOW THEOREM of the sup class: the large-field radius a must satisfy β a² ≥ p_min²·(blocked variance factor), and
    the cubic (BCH) part of the plaquette action at the domain edge is ≥ c₃ β a³; sup-smallness forces √β ≥ … : β_sup(δ).
 C3 — the moment-class tolerance table at β = 20, 50, 100, 10³, 10⁴, and the constant a real expansion gives.
 C4 — checks: c₁ = 8 b₀ ln L, the two-loop size, the tree-level preservation of the F² coefficient on the free blocked action.
 C5 — the cost of certifying [5, 10⁴]; all compact simple G.

KILL-SWITCHES. (K1) Cov(F | QA) larger than Cov(F) on any mode: the instrument is wrong (conditioning lowers a Gaussian
variance). (K2) the unconditioned per-colour plaquette variance at d = 4 not equal to 1/2 per unit coupling (M6 §6 (i)): the
normalisation is wrong. (K3) a zero mode of the gauge-invariant constrained form at a nonzero coarse momentum: the averaging is
not Bałaban's.

## 2. THE CONE (definition; the advisor's correction adopted: a TUBE around the renormalised trajectory, not a ball around Wilson)

2.1 WHY A TUBE. Classical (tree-level) blocking preserves the continuum F² coefficient exactly — four-dimensional Yang–Mills is
classically scale invariant — but it does NOT preserve the Wilson form: the minimiser over fine fields with fixed block averages
generates dimension-six loops with coefficients of the SAME order in β as the plaquette term (Bell–Wilson; Hasenfratz–Niedermayer's
fixed-point action). Under repeated tree-level blocking their ratios converge to the fixed-point ratios c* at the canonical rate
L⁻² per step. One loop then shifts the physical coupling by the universal c₁ = 8b₀ ln L ON the renormalised trajectory and by
c₁ + S(c′) − S(c) off it (S = the one-loop scheme offset of the irrelevant couplings, the Λ-ratio of the action family in β units).
A ball around the Wilson action (c = 0) is therefore NOT mapped into itself: the first steps carry the O(1) transient S(c*) − S(0).
The cone is a tube; the entry from Wilson's action is a separate finite computation (§2.5).

2.2 DEFINITION (the cone C_L(β; δ_r, ε_K, a, κ)). Effective actions on the fine lattice of the current scale of the form
   S(U) = β · Σ_{i=0}^{3} c_i Σ_{Γ∈𝒞_i} s(U_Γ) + E|Λ| + Σ_X K(X; U),   c₀ + 8c₁ + 16c₂ + 8c₃ = 1,                      (2.1)
 𝒞₀ the plaquettes, 𝒞₁ the 1×2 rectangles, 𝒞₂ the chairs, 𝒞₃ the twisted six-link loops (the three classes of six-link loops in
 four dimensions); s(U) = 1 − ½ tr U, or the heat-kernel weight for the plaquette class (advisor 4: its single-loop weight is
 Gaussian in the loop's Lie-algebra coordinate up to the Haar Jacobian); the normalisation makes β the continuum F² coefficient
 at tree level (the Lüscher–Weisz normalisation c₀ + 8c₁ + 16c₂ + 8c₃ = 1). Membership:
 (C-i)  |c − c*| ≤ δ_r, c = (c₁, c₂, c₃), c* = the tree-level fixed-point ratios of the block map (computed for the free part in
        C1);
 (C-ii) K(X) gauge invariant, depending on the links of X only, analytic on the small-field domain D_a(X) = {U : |U_p − 1| ≤ a for
        every plaquette p ⊂ X}, with ‖K‖_κ := sup_{x} Σ_{X∋x} e^{κ|X|} ‖K(X)‖_{D_a} ≤ ε_K, where ‖·‖_{D_a} is the moment norm of M3c §4
        (Bałaban's B-dependent bound, CMP 116 p. 8) — not the sup;
 (C-iii) on the large-field set, K(X) is dominated by the regulator exp(−p_LF(a)·#{large plaquettes of X}), p_LF(a) = β(1 − cos a)·
        κ_LF with κ_LF the blocked-variance factor of C1.
 Finitely many parameters: β, c₁, c₂, c₃ (and the plaquette-shape choice); the tail is the polymer remainder K, bounded analytically.

2.3 THE CONE PROPERTY (the statement to prove). There are δ_r, ε_K, a, κ, δ_min > 0 such that for every S ∈ C_L(β) the blocked action
T_L S lies in C_L(β′) with
   β − c₁ − ε ≤ β′ ≤ β − c₁ + ε,   ε ≤ c₁ − δ_min,                                                                    (2.2)
the band and the polymer bound reproduced (δ_r, ε_K unchanged). Then from any bare coupling the flow descends in steps of at least
δ_min and at most c₁ + ε until it enters the meeting window, with the effective action controlled at every step.

2.4 THE REDUCTION TO SIX INEQUALITIES (each with its named constant; the advisor's chain, written before any run).
 (H1) TREE-LEVEL BAND CONTRACTION. The linearised classical blocking of the ratios c at c* has spectral radius ρ_tree; canonical
      dimension counting gives ρ_tree = L⁻² for the dimension-six directions. COMPUTED for the free (quadratic) part in C1.
 (H2) THE BAND REPRODUCES. ρ_tree δ_r + K_r/β + K_rK ε_K ≤ δ_r, where K_r/β bounds the one-loop motion of the fixed point
      (c*_RT(β) − c*_tree = O(1/β)) and K_rK the feedback of the polymer remainder into the ratios.
 (H3) THE COUPLING. |β′ − (β − c₁)| ≤ S′(1 − ρ_tree)δ_r + K₂/β + K_βK ε_K + K₃/β² ≤ ε, where S′ = |∇S|, the gradient of the one-loop
      scheme offset in the ratios (per unit c, in β units); K₂ the two-loop coefficient (true value 32 b₁ ln L: 0.0403 at L = 2,
      0.0639 at L = 3); K₃ the remainder beyond two loops INCLUDING the non-perturbative part; K_βK the feedback of K into β.
      The per-step deviation is S′(1 − ρ)|c − c*|, not S′|c − c*|: the scheme offset telescopes, S(c′) − S(c) = −S′·(1 − ρ)(c − c*)
      at tree level (PROVED from c′ − c* = ρ(c − c*) and the mean value theorem).
 (H4) THE POLYMER REMAINDER. κ_irr ε_K + K_new(β) ≤ ε_K, κ_irr the contraction of irrelevant polymers (Bałaban's L⁻¹/² per step),
      K_new(β) the new remainder generated in one step.
 (H5) LARGE FIELDS. The per-plaquette large-field activity at radius a is below Shearer's z_c(20) = 0.0188677 (M6 §6) with margin:
      P(|θ_p − θ_p^bg| ≥ a) ≤ P(χ²₃ ≥ 2βa²/K_var) ≤ z_c/2, K_var = max over positions and orientations of β·Var(F_p | coarse) per
      colour (COMPUTED in C1; ≤ ½ by conditioning).
 (H6) CONVEXITY ON THE SMALL-FIELD DOMAIN. η(a) < 1, where Hess_B S ≥ (1 − η(a))·Δ₀ on D_a, Δ₀ the free constrained fluctuation
      form with gap γ₀ (COMPUTED in C1); η(a) from the plaquette Hessian, the BCH correction and the Haar Jacobian (K_BCH).
 SOLVING (H2) for δ_r and inserting into (H3):
   ε_needed(β) = S′K_r/β + K₂/β + K₃/β² + (ε_K-feedback),                                                             (2.3)
 so the LOWEST CERTIFIED β is the least β with ε_needed(β) ≤ c₁ − δ_min. Every coefficient in (2.3) is a β-INDEPENDENT lattice number
 (the step's Gaussian part scales as 1/β exactly); hence once the coefficients are bounded, certifying the whole half-line [β*, ∞) is
 ONE monotone inequality, not 24,000–39,000 step certificates (§7).

2.5 THE ENTRY. From Wilson's action (c = 0) the first steps carry S(c*) − S(0) (an O(1) number in β units) spread geometrically:
step n deviates by S′ρ^{n−1}(1 − ρ)|c*|. This is a finite computation done once (a few steps), not a per-step claim; after
n_entry ≈ log(S′|c*|/ε_r)/log(1/ρ) steps the flow is inside the tube.

## 3. STAKES FOR C1 (written before `bin/m8_c1_reading.py` runs; nothing here edited after)

S-C1.1 (K2, known answer) The unconditioned per-colour fine plaquette variance β·Var(F_μν(x)) = 1/2 exactly at d = 4, every μν.
S-C1.2 (K1) The conditional variance β·Var(F_μν(x) | coarse) < 1/2 at every position and orientation; for L = 3 centred I stake the
       maximum over positions in [0.30, 0.45] and the minimum in [0.15, 0.35]; for L = 2 half-open, max in [0.25, 0.42].
S-C1.3 (K3) The gauge-invariant constrained form has no zero mode at any coarse momentum (including k = 0 on a shifted grid); stake
       γ₀ (smallest eigenvalue of M on ker Q ∩ (residual gauge)^⊥, ℓ² normalised) in [0.05, 0.6] for L = 3 and [0.2, 1.2] for L = 2.
S-C1.4 The F² coefficient of the blocked free action in coarse units equals the fine one (tree-level scale invariance): the transverse
       coarse kernel K′(k) = |k̂|²(1 + O(k²)) with coefficient 1 to reading precision.
S-C1.5 Gauge-fixing independence: the conditional F-covariance is the same at gauge-fixing weights ξ = 0.1, 1, 10 (relative
       difference < 10⁻¹⁰).

3.1 DATED CORRECTION TO S-C1.5, BEFORE THE RUN (2026-11-02). S-C1.5 is ILL-POSED as written. Conditioning a gauge-FIXED Gaussian
(weight ξ on the longitudinal modes) on QA = a′ is not Bałaban's measure: Bałaban fixes the coarse links completely and the
integrand is invariant under the residual group R = {λ : λ|coarse sites = 0} only (CMP 109 p. 254, M3c §6 (FP1)); the measure is
on {QA = a′}/R. Writing A = a_T + p̂λ (transverse + longitudinal per alias), QA = Qa_T + k̂_c s with s = L⁻⁴Σ_m λ_m and k̂_c = e^{iLk} − 1,
so on {QA = a′}/R only the three transverse coarse equations P′_⊥(Qa_T − a′) = 0 bind a_T, while the ξ-measure puts a Gaussian weight
on s, i.e. on the coarse-longitudinal component of Qa_T. CORRECTED STAKE S-C1.5′: the ξ-conditioned F-variance DEPENDS on ξ, grows as
ξ decreases, and tends to the R-quotient value as ξ → 0 (at ξ → ∞ it is the Landau-fixed conditioning, four equations, smaller).
The R-quotient formula used everywhere below: Cov(a | a′) = (NL)⁴β⁻¹·N(N†MN)⁺N† with N an orthonormal basis of ker Q(k); M on ker Q
must have exactly L⁴ − 1 zero eigenvalues at k ≠ 0 (part of K3).

## 4. RESULTS OF C1 (records `rec/c1_reading_L2_half.2026-11-02a.txt`, `rec/c1_reading_L3_centred.2026-11-02a.txt`, rc = 0;
## READINGS in double precision on the 6⁴ midpoint grid of the coarse zone; nothing in §3 edited)

Instrument checks (both L): the gauge-covariance identity Σ_ν Q̂_μν(p) p̂_ν = e^{iLp_μ} − 1 holds to 4.4·10⁻¹⁵ on 200 random momenta
(the linearised average IS Bałaban's: covariant, Q(dλ) = d′(λ|coarse), advisor item 6); Q̂(0) = L·I (a constant field's coarse link
spans L fine links); rank Q = 4 and M restricted to ker Q has exactly L⁴ − 1 zero modes (15 for L = 2, 80 for L = 3) at every grid point —
the residual gauge group and nothing else (K3 HOLDS on the grid).

| quantity | L = 2 half-open | L = 3 centred | stake | verdict |
|---|---|---|---|---|
| unconditioned β·Var(F_μν(x)) per colour | 0.50000000 | 0.50000000 | S-C1.1: 1/2 | HELD (K2) |
| conditional β·Var(F|coarse), max over x, μν | 0.495648 | 0.498424 | S-C1.2: [0.25,0.42] / [0.30,0.45] | REFUTED: far closer to 1/2 |
| conditional, min | 0.425747 | 0.473051 | S-C1.2 (L=3): [0.15,0.35] | REFUTED |
| conditional, mean over x, μν | 0.468750 = 15/32 | 0.493827 = 40/81 | — | = ½(1 − L⁻⁴): see 4.1 |
| γ₀ (min over grid), smallest eigenvalue of M on ker Q ⊖ R | 2.084154 | 1.190708 | S-C1.3: [0.2,1.2] / [0.05,0.6] | REFUTED: larger |
| tree-level coarse kernel / coarse Wilson kernel at |k|L = 0.025 | 1 + 7.8·10⁻⁵ | 1 + 9.3·10⁻⁵ | S-C1.4: → 1 | HELD |
| ξ-conditioning → R-quotient as ξ → 0 | yes | yes | S-C1.5′ | HELD |

4.1 THE EQUIPARTITION IDENTITY (PROVED; the reading's mean is its known answer). On the constrained gauge-invariant space of one
coarse cell the Gaussian (β/2)‖dA‖² has 3(L⁴ − 1) degrees of freedom per colour (4L⁴ links − 4 constraints − (L⁴ − 1) residual gauge),
so E[(β/2)‖dA‖²] = 3(L⁴ − 1)/2 per cell and, over its 6L⁴ plaquettes,
   mean_{x,μν} β·Var(F_μν(x) | coarse) = ½(1 − L⁻⁴)  (= 15/32 at L = 2, 40/81 at L = 3),
while β·Var(F_μν(x) | coarse) ≤ ½ at every x, μν because conditioning lowers a Gaussian variance (and ½ is the unconditioned value,
equipartition on 3L⁴ degrees of freedom). The readings reproduce the mean to six digits: an absolute check of the instrument.
CONSEQUENCE FOR THE CONE: K_var := max β·Var(F|coarse) ∈ [½(1 − L⁻⁴), ½] — PROVED, no certification needed. The block constraint
removes only 1/L⁴ of the fine curvature's fluctuation: the large-field estimate (H5) must be made with the full ½ (M6's floor
4.98/a² is essentially exact for the blocked field, a factor at most (1 − L⁻⁴) lower: 4.67/a² at L = 2, 4.92/a² at L = 3).

4.2 THE FLUCTUATION GAP. γ₀ = 2.08 (L = 2), 1.19 (L = 3) on the grid, both minima near the zone face (k₄ = 5π/12 resp. 5π/18 of the
coarse half-width π/L); a refined search follows (§5). In Bałaban's language γ₀ is CMP 122 LFR II (1.8)'s γ₀ for the averaging of
CMP 109 (0.4), computed: the constrained fluctuation form is ≥ 1.19·‖B‖² (L = 3) in the ℓ² norm of the gauge-orthogonal fluctuation.

4.3 TREE LEVEL (the leading parameters of the blocked Gaussian action). The blocked free action's transverse kernel equals the coarse
Wilson kernel times 1 + τ(k): τ ≈ 0.125 (kL)² along an axis and 0.094 (kL)² along the diagonals at L = 2; 0.148 (kL)² and 0.111 (kL)² at
L = 3 (readings at |k|L ≤ 0.1). So the F² coefficient is preserved (tree-level scale invariance, S-C1.4 HELD) and the blocking generates
dimension-six terms of relative size O(1) — the tube of §2 is forced: after one step from Wilson the irrelevant part is ~0.1–0.15 (kL)²
relative, NOT zero. The isotropic and the hypercubic parts differ (axis ≠ diagonal), so both quadratic dimension-six structures are
generated.

## 5. THE SMALL-FIELD DOMAIN: CONVEXITY RADIUS AND THE FLOOR IT FORCES (H5 + H6)

5.0 WHY THIS IS THE HINGE AT β = 50. A moment-class step that uses log-concavity (Brascamp–Lieb, Helffer–Sjöstrand — dimension-free
constants) needs the integrand log-concave on a CONVEX small-field domain; the link-angle box D_b = {B ∈ V : |B_ℓ| ≤ b ∀ℓ} is convex
(V = ker Q ⊖ R, the slice). The Haar density's −log is convex (it helps); the Wilson part's Hessian on V is Δ₀ + E(B) with Δ₀ ≥ γ₀.
So b ≤ b_cvx (the convexity radius, β-INDEPENDENT) while large fields need βb² ≥ K_link·q_ℓ (q_ℓ the χ²₃ quantile at Shearer's z_c for
the link dependency degree 18: z_c(18) = 17¹⁷/18¹⁸). THE FLOOR OF THE CONVEX MOMENT CLASS: β ≥ K_link·q_ℓ / b_cvx².
REFINED GAP AND LINK VARIANCE, L = 2 (record `rec/c1b_L2_half.2026-11-02a.txt`, READING): γ₀ = 1.84956377 at the face centre
k = (0, π/2, 0, 0) (Nelder–Mead from the 5⁴ face/corner scan; the 6⁴ grid's 2.084 was not the minimum); γ₀(k) → 4 as k → 0. Slice-gauge
link variance β·Var(B_ℓ^a | coarse): max 0.13145 (the link leaving the block across its face), mean 0.09793; the unconstrained Landau
value is 0.75·Z₀ = 0.11620 (reading 0.11583 on the midpoint grid: the check holds to the grid's error).

STAKES (written before `bin/m8_h6_convexity.py` runs):
S-H6.1 The per-plaquette Hessian change e(b) := sup_{|φ_i| ≤ b} ‖Hess F_p(φ) − Hess F_p(0)‖ (F_p = 1 − ½ Re tr U_p, 12 variables) is
       e(b) = c_e·b + O(b²) with c_e ∈ [3, 6] (the cubic term's Hessian blocks are cross-product matrices of norm ≤ 2b, three per row).
S-H6.2 The crude (Gershgorin) convexity radius b_crude := sup{b : 6·e(b) ≤ γ₀/2} (η = ½): b_crude ∈ [0.04, 0.12] for L = 2.
S-H6.3 The non-convexity search on the (4,2,2,2) torus (L = 2 blocks; it contains the face momentum where γ₀ is attained): the least
       link-angle radius b_neg at which a configuration in the slice has λ_min(Hess S_W|_V) < 0 lies in [0.25, 0.9] — far above the crude
       radius (the crude bound charges every plaquette's worst alignment at once; smooth low modes cancel the antisymmetric cubic term).

STAKES FOR C3 (written before `bin/m8_c3_table.py` runs):
S-C3.1 c₁(2) ∈ [0.2575, 0.2576], c₁(3) ∈ [0.4081, 0.4082]; K₂(2) = 32 b₁ ln 2 ≈ 0.0403, K₂(3) ≈ 0.0639.
S-C3.2 z_c(18) ≈ 0.0210 with q(z_c(18)/2) ≈ 11.2; z_c(20) = 0.018868 with q(z_c(20)/2) ≈ 11.5.
S-C3.3 plaquette-domain floor with K_var = ½ at b = 1 rad: β ≥ ≈ 5.7; link-domain floor (L = 2) at b = 0.3: β ≥ ≈ 16.
S-C3.4 remainder budget at β = 50 with A1 = 2 + K₂ (S′K_r = 2 ESTIMATED): ≈ 790 (L = 3), ≈ 416 (L = 2).

RESULTS OF `bin/m8_h6_convexity.py` (record `rec/h6_convexity.2026-11-02a.txt`, rc = 0; READINGS; stakes above unedited):
S-H6.1 HELD: e(b)/b = 4.701 (b = 0.01), 4.787 (0.02), 5.069 (0.05), 5.599 (0.1), 6.885 (0.2), 8.533 (0.3) — lower bounds on the sup
       from multi-start hill climbing; c_e ≈ 4.7.
S-H6.2 REFUTED, JUST BELOW: the crude radius b_crude = sup{b : 6 e(b) ≤ γ₀/2} is ≈ 0.032 (L = 2, γ₀ = 1.8496; 6e(0.02) = 0.574,
       6e(0.05) = 1.52); at η = 1 (bare convexity) ≈ 0.063. Staked [0.04, 0.12].
S-H6.3 HELD: the torus slice has dimension 270 = 384 − 24 − 90, Q·G = 1.4·10⁻¹⁶, free λ_min = 1.849564 (= the Fourier γ₀ at the face:
       the real-space and Fourier instruments agree). Crossing radii (first link-angle radius with λ_min < 0 along a ray): soft modes
       0.9246 (×3, max plaquette angle 1.225 there), soft mode 3 0.7837 (plaquette 1.567); twelve random rays 0.656–0.781 (max plaquette
       angles 1.52–1.85 at the crossing). So b_cvx ≤ 0.6565 (random ray 7) and convexity is lost, on every ray tried, where single plaquettes
       pass ≈ 90° — the plaquette function's own radial Hessian cos|Θ| changing sign — not by the BCH cross terms the crude bound charges.
STAKE S-H6.4 (before `bin/m8_h6_adversary.py`): the adversarial hill climb at fixed sup norm b finds no non-convex configuration at
       b = 0.2 and 0.3; it exhibits one at b = 0.5 (b_cvx ∈ (0.3, 0.5]).
STAKE S-H1.1 (before `bin/m8_h1_band.py`): a fine rectangle coefficient c₁ enters the fine kernel's relative O(p²) part with
d τ_fine/d c₁ = −p² along an axis; the blocked kernel's response per (kL)² is the canonical −1/L² (−0.25 at L = 2, −0.111 at L = 3)
up to an alias contribution I stake below 30 % of it.

RESULTS OF `bin/m8_h1_band.py` (records `rec/h1_band_L2.2026-11-02a.txt`, `rec/h1_band_L3.2026-11-02a.txt`; READINGS; the trailing
fine-kernel cross-check crashed on an indexing bug AFTER the results printed — its content is the hand computation below):
S-H1.1 HELD, AND SHARPER THAN STAKED: the blocked kernel's response to a fine rectangle coefficient is the canonical one with NO alias
contribution in the limit: d τ/d c₁ per (kL)² = −0.250026 (L = 2, axis, |k|L = 0.025; → −1/4), −0.111126 (L = 3; → −1/9); along the
diagonals −0.12501 / −0.05556 (= −1/(2L²)), exactly the fine response −c₁(p_μ² + p_ν²) divided by L² mode by mode. So ρ_tree = L⁻² in the
rectangle direction at tree level (H1), the aliases contributing only at higher order in k.
THE GENERATED DIMENSION-SIX CONTENT (from a Wilson fine kernel, relative to the coarse Wilson kernel, per (kL)²): axis 0.125003 (L = 2),
0.148154 (L = 3); diagonal 0.093751, 0.111114 — the rationals (L² − 1)/(6L²) and (L² − 1)/(8L²) to five digits (1/8, 3/32; 4/27, 1/9).
With the canonical response, the free fixed point of the affine map τ′ = τ_gen + L⁻²τ is τ* = τ_gen/(1 − L⁻²) = (kL)²/6 (axis) and
(kL)²/8 (diagonal) — THE SAME FOR L = 2 AND L = 3: the free fixed-point action's dimension-six content is L-independent, as it must be if it
is the fixed point of Bałaban's averaging in the continuum blocking profile (an independent consistency check of the instrument; the
affine-map step for the generated structure is ESTIMATED from the rectangle direction's exactness).

RESULTS OF `bin/m8_c3_table.py` (record `rec/c3_table.2026-11-02a.txt`, rc = 0; COMPUTED, mpmath.iv at 40 digits, outward rounding):
S-C3.1 HELD: c₁(2) = 0.257511806833, c₁(3) = 0.408146557324; K₂(2) = 0.0403230743812, K₂(3) = 0.0639105608081 (b₀ = 0.0464388758361,
       b₁ = 0.0018179343576).
S-C3.2 HELD: z_c(18) = 0.02102454334, q(z_c(18)/2) = 11.23673551; z_c(20) = 0.01886768013, q(z_c(20)/2) = 11.47092181 (q(z_c(20)) =
       9.964805819 = M6's t*, reproduced).
S-C3.3 NEAR, NOT AS STAKED: the plaquette floor with K_var = ½ is β ≥ 5.736/b² — at b = 1 rad 5.74 (staked 5.7, HELD); the link floor at
       L = 2 is β ≥ 1.4771/b² — at b = 0.3, 16.41 (staked ≈ 16, HELD).
S-C3.4 HELD: the remainder budget at β = 50 with A1 = 2 + K₂ is 416.76 (L = 2) and 792.17 (L = 3).
The step counts (1e4 − 5)/c₁ = 38,813.754 (L = 2) and 24,488.752 (L = 3).
STAKE S-C1c (before `bin/m8_c1c_l1norm.py`): for L = 2 the per-colour ℓ¹ norm β·Σ_{y,ν}|C((x₀,μ₀),(y,ν))| of the slice-gauge fluctuation
covariance is between 0.5 and 3 for every source link, and max|C| falls by at least a factor 10 per coarse cell of distance.

RESULTS OF `bin/m8_c1c_l1norm.py` (record `rec/c1c_l1norm_L2.2026-11-02a.txt`, rc = 0; READING on the 12⁴ fine torus): the slice-gauge
fluctuation covariance per colour has β·Σ_{y,ν}|C((x₀,μ₀),(y,ν))| ≤ 2.70255 (the block-face-crossing link; mean over the 64 source links
2.11683, least 1.96881); its diagonal (the link variance) reproduces C1b's 0.13145 / 0.09910 (two instruments, one number); max|C| at coarse
distance 0, 1, 2, 3: 1.31·10⁻¹, 2.64·10⁻², 1.24·10⁻³, 1.10·10⁻⁴. S-C1c: the ℓ¹ range HELD (2.70 ∈ [0.5, 3]); "a factor 10 per coarse
cell" REFUTED for the first cell (factor 5.0), HELD after (21, 11). The fluctuation field's correlation length is ≈ 0.4 coarse cells.

## 6. C3 — THE VERDICT INEQUALITY AT β = 20, 50, 100, WITH EVERY CONSTANT LABELLED

6.1 THE CHAIN (from §2.4, solved). With the band δ_r solved from (H2) and the tube centred on the one-loop-corrected fixed point when that
correction is computed, the cone property (2.2) holds at β iff
   A1/β + K₃/β² ≤ ε := c₁ − δ_min,                                                                                         (6.1)
 A1 = S′K_r + K₂ (= K₂ alone when the one-loop fixed-point correction c*₁ is computed and used as the tube's centre), K₃ the remainder
 beyond two loops, perturbative and non-perturbative together. Equivalently β ≥ β*(K₃) := [A1 + √(A1² + 4εK₃)]/(2ε).

6.2 THE CONSTANTS AND THEIR STATUS.
| constant | value | status | source |
|---|---|---|---|
| c₁(2), c₁(3) | 0.257511806833, 0.408146557324 | COMPUTED (universal one-loop rate, READ: b₀ = 11C_A/(48π²)) | rec/c3_table |
| K₂(2), K₂(3) | 0.0403230743812, 0.0639105608081 | COMPUTED (universal two-loop, READ: b₁ = (34/3)C_A²/(16π²)²) | rec/c3_table |
| ε = c₁ − δ_min (δ_min = 0.05) | 0.207512 (L = 2), 0.358147 (L = 3) | definition | §2.3 |
| ρ_tree | L⁻² (rectangle direction: −0.250026, −0.111126 per (kL)²) | READING, limit exact | rec/h1_band_* |
| K_var | ∈ [½(1 − L⁻⁴), ½]; reading 0.495648 / 0.498424 | PROVED bounds; READING | §4.1 |
| γ₀ | 1.84956377 (L = 2), 1.00000000 (L = 3), at the face centre | READING (Nelder–Mead + face scan) | rec/c1b_* |
| K_link | 0.13145 (L = 2), 0.10987 (L = 3) | READING | rec/c1b_* |
| ℓ¹(C) | ≤ 2.70255 (L = 2) | READING | rec/c1c_* |
| b_cvx (link-angle convexity radius, L = 2) | crude ≥ 0.063 (η = 1), 0.032 (η = ½); adversarial: convex at 0.2 (λ_min ≥ 1.626), 0.3 (≥ 1.311), rays cross at ≥ 0.656 | crude: READING of a PROVABLE form (Gershgorin + e(b)); the rest READING | rec/h6_* |
| S′K_r | ≈ 2 (range 0.7–6) | ESTIMATED: Lüscher–Weisz family analogue (one-loop Λ-ratio slope × one-loop motion of the rectangle coefficient) | — |
| K₃ | the NAMED object | OPEN | §6.4 |

6.3 THE TABLE (rec/c3_table, COMPUTED from the table's inputs): the remainder budget K₃^max(β) = β²(ε − A1/β):
| β | L = 2, A1 = K₂ | L = 2, A1 = 2 + K₂ | L = 3, A1 = K₂ | L = 3, A1 = 2 + K₂ |
|---|---|---|---|---|
| 10 | 20.3 | 0.35 | 35.2 | 15.2 |
| 20 | 82.2 | 42.2 | 142.0 | 102.0 |
| 50 | 516.8 | 416.8 | 892.2 | 792.2 |
| 100 | 2071 | 1871 | 3575 | 3375 |
| 10³ | 2.07·10⁵ | 2.05·10⁵ | 3.58·10⁵ | 3.56·10⁵ |
| 10⁴ | 2.08·10⁷ | 2.07·10⁷ | 3.58·10⁷ | 3.58·10⁷ |
and the large-field/convexity floor (H5 + H6) in the link domain: β ≥ 1.4771/b² (L = 2), 1.2346/b² (L = 3) — at the adversarially-convex
b = 0.3: 16.4 / 13.7; at the crude provable b = 0.063: 372 / 311.

6.4 THE VERDICT AT β = 50, 20, 100 (SU(2)).
 * The Gaussian part of the step is in hand: K_var, γ₀, K_link, ℓ¹(C), ρ_tree — the "smallest block" read exactly in Fourier space.
 * The large-field/convexity floor does NOT bind at β = 50 provided the convexity radius b ≈ 0.3 is CERTIFIED (it is a reading: no
   configuration tried is non-convex there, the margin is 71 % of γ₀); with the crude provable radius 0.063 the floor is 372 (L = 2) and
   β = 50 FAILS on (H5)+(H6) alone. Certifying b_cvx ≥ 0.3 is a finite computation (a mode-resolved, not Gershgorin, bound on the
   Hessian change on the slice) — the first payable.
 * The coupling inequality (6.1) at β = 50 requires K₃ ≤ 417 (L = 2) / 792 (L = 3) with S′K_r = 2, or ≤ 517 / 892 with the one-loop
   fixed-point correction computed. At β = 20: ≤ 42 / 102 (≤ 82 / 142). At β = 100: ≤ 1871 / 3375 (≤ 2071 / 3575).
 * What a rigorous K₃ costs. The true three-loop size is O(0.1–1) (the MS-bar three-loop coefficient gives ~0.015 per step in β units at
   β², lattice schemes larger). A bound that replaces each loop integral by products of sup and ℓ¹ norms of the fluctuation covariance
   (the tree-graph form of every cluster expansion on record) loses the loop structure: with the computed inputs the per-vertex
   tree-graph constant is ≈ (cubic coupling β^{−1/2}) × (24 cubic terms per link: 6 plaquettes × 4 triples) × (ℓ¹(C) = 2.70) × (6
   pairings) ≈ 390/√β (ESTIMATED: the counting of a Brydges–Kennedy forest bound with these inputs), > 1 for β < 1.5·10⁵ — the crude
   expansion does not even converge at β = 50. K₃ of crude moment-class methods is therefore ESTIMATED at 10⁴–10⁹, i.e. β* ≈ 220–70,000
   (L = 2) / 170–17,000 (L = 3) from 6.1.
 VERDICT AT β = 50: NOT CERTIFIED. The cone property at β = 50 is EQUIVALENT (given the Gaussian inputs, now in hand) to the remainder bound
 K₃ ≤ 417/792 and the convexity certificate b_cvx ≥ 0.3. Neither exists; the convexity certificate is a finite computation within reach;
 K₃ ≤ ~500 requires a remainder bound that keeps the loop structure (certified lattice integrals for the low orders, the tree-graph bound
 only from four loops on) — within a factor ~10³ of the truth, against the 10⁴–10⁹ of crude methods. β = 20 needs K₃ ≤ 42–142: harder;
 β = 100 needs K₃ ≤ ~2000–3600: the same object with a factor 4 more room.

RESULTS OF `bin/m8_h6_adversary.py` (record `rec/h6_adversary.2026-11-02a.txt`, rc = 0; READING; 8 starts x 120 hill-climbing moves per b):
the most negative lambda_min of the Wilson Hessian on the slice at link-angle sup norm b is 1.6259 (b = 0.2), 1.3107 (0.3), 0.9096 (0.4),
0.1986 (0.5), against the free 1.8496. S-H6.4: convex at 0.2 and 0.3 HELD; "non-convex exhibited at 0.5" REFUTED (still convex there, margin
11 % of gamma0, the worst configurations carrying plaquettes at 1.56-1.77 rad). So on this torus b_cvx lies in (0.5, 0.656] by search,
against the crude provable 0.063: the provable bound is a factor 8-10 below the observed radius, a factor 60-100 in the floor 1.4771/b^2.

## 7. COST OF CERTIFYING THE MIDDLE REGION

7.1 THE CERTIFICATE IS ONE INEQUALITY, NOT 24,489-38,814. Every coefficient of (6.1) is beta-independent (the step's Gaussian part scales as
1/beta exactly; the perturbative coefficients are numbers; K3 is a constant by construction), and A1/beta + K3/beta^2 decreases in beta. So
once the constants are certified, (6.1) at beta* certifies EVERY step from any bare coupling down to beta* (PROVED: monotonicity). The
one-loop step counts (10^4 - 5)/c1 = 38,813.754 (L = 2) and 24,488.752 (L = 3) (COMPUTED) count the steps the flow takes, not the
certificates.
7.2 WHAT MUST BE COMPUTED ONCE (machine-time estimates from the speeds measured today: one L = 2 fluctuation problem 4 ms, one L = 3
problem 0.48 s per coarse momentum):
 (a) the Gaussian constants certified (gamma0 lower bound, K_link and l1(C) upper bounds): an interval/Weyl-Lipschitz cover of 1/384 of the
     coarse zone (the hyperoctahedral symmetry of the centred average); L = 3 about 10^4 boxes x 0.5-1 s, 2-3 h; L = 2 minutes.
 (b) the convexity certificate b_cvx >= 0.3 (section 5): a branch-and-bound over plaquette configurations with a mode-resolved global
     assembly; hours.
 (c) the one-loop sensitivities (S' and the one-loop fixed-point correction c*_1): one-loop background-field integrals with the block
     propagator, a 12 L^4-dimensional problem per coarse momentum, certified quadrature (exponential convergence: the integrand is analytic
     in a strip set by gamma0); L = 2 minutes, L = 3 3-30 h.
 (d) K3 by a loop-preserving remainder bound: certified two- and three-loop lattice integrals in the coarse-momentum/alias factorisation;
     the two-loop integral over (k1, k2) with L^4 x L^4 alias pairs is about 10^12 operations at L = 2 (days on this host) and 10^14 at
     L = 3 (weeks on a workstation, hours on a cluster).
7.3 BELOW beta*, THE CONE CERTIFIES NOTHING. If beta* > 5 the interval [5, beta*] needs certified exact engines extended upward; their spin
cap grows like (beta ln(1/tol))^(1/2) (about 42 at beta = 50, 88 at beta = 220, for tol = e^-35).

## 8. EVERY COMPACT SIMPLE G (statement)

 * The rate: for SU(N) with beta = 2N/g^2, c1 = 4N b0 ln L = (11 N^2/(12 pi^2)) ln L (SU(2): 0.3715 ln L; SU(3): 0.8359 ln L, so
   c1(3) = 0.918); in general C_A -> h^vee, the dual Coxeter number, in b0 = 11 h^vee/(48 pi^2) and b1 = (34/3)(h^vee)^2/(16 pi^2)^2, with
   beta's normalisation fixed by the trace in the fundamental.
 * The Gaussian part (C1) is G-independent per colour component (the linearisation is abelian per generator): the equipartition identity
   (1/2)(1 - L^-4), gamma0, K_link and l1(C) hold verbatim for every G; the number of components is dim G.
 * dim G enters the large-field floor through the chi^2_{dim G} quantile (11.47 for dim 3 at z_c(20)/2; about 21-24 for dim 8): the floor
   K q / b^2 roughly doubles from SU(2) to SU(3); and the vertex counts of K3 (the cubic vertex is f^{abc}-weighted; its count grows like
   dim G times h^vee).
 * The heat kernel on G (the plaquette-class choice of section 2.2) is sum_lambda d_lambda exp(-t C2(lambda)) chi_lambda with the Casimir
   spectrum C2(lambda); the Haar density in exponential coordinates, det(sin(ad X/2)/(ad X/2)), is log-concave on the injectivity ball and
   helps convexity for every G; the convexity radius scales with the structure constants and is lost where single plaquettes reach the edge
   of the radial Hessian.
 * For G with complex representations the six-link loop traces are complex: the cone carries Re tr (the action is real); the parameter
   count is unchanged.

## 9. THE TWO EXIT NUMBERS, THE NEXT OBJECT, AND WHAT UNIFIES

9.1 EXIT NUMBER ONE, THE LOWEST beta AT WHICH A CERTIFIED STEP CLOSES: NONE IS CERTIFIED TODAY. Conditional on the named objects,
beta*(K3) from (6.1) with A1 = 2 + K2 (COMPUTED from the table's inputs): K3 = 1 gives 10.3 (L = 2) / 6.2 (L = 3); 10^2: 27.4 / 19.8;
10^4: 224 / 170; 10^6: 2196 / 1675; 10^8: 21,950 / 16,700. With crude (tree-graph) remainder constants, K3 about 10^4-10^9 (ESTIMATED):
beta* about 200 to 7.10^4. M6's literal Balaban chain: 10^982.39. With a loop-preserving remainder (K3 about 10-100): beta* about 7-27.
L = 3 (centred, Balaban's block) is preferred: its tolerance eps = 0.358 is 1.73 times L = 2's.
9.2 EXIT NUMBER TWO, THE MEETING WITH THE EXACT ENGINES: the W2 strip engines give READINGS at beta <= 3-5; a certified Hypothesis I exists
at beta <= 0.4764 (Theorem 8.9, conditional on S12). Even a cone closing at beta* = 7 leaves [0.48, 7] to engines that today only read to
3-5. The two numbers are different objects; the first does not close the chain.
9.3 THE NEXT OBJECT (in order of leverage):
 (N1) THE CONVEXITY CERTIFICATE b_cvx >= 0.3 on the slice of the centred L = 3 block (and L = 2): a mode-resolved bound on the Hessian change
      in place of the Gershgorin 6 e(b) <= gamma0, which loses the factor 8-10. It moves the convex moment class's floor from 311-372 to
      14-16.
 (N2) THE LOOP-PRESERVING REMAINDER LEMMA: K3 <= about 500 at L = 3 from certified two- and three-loop lattice integrals with the block
      propagator (C1's inputs gamma0, K_link, l1(C)) and the tree-graph bound only from four loops on, where the extra 1/beta^2 pays for the
      crude constant. FALSIFIER: a three-loop contribution to the per-step coupling flow whose certified absolute value already exceeds 500.
 (N3) THE ONE-LOOP SENSITIVITIES S' and c*_1 for the centred average: removes the only ESTIMATED entry of the chain (S'K_r about 2).
9.4 WHAT UNIFIES.
 (U1) THE BLOCK-SPIN STEP IS A TWO-GRID METHOD. Balaban's average is the restriction operator; the constrained fluctuation form's gap gamma0
      is the two-level approximation/smoothing constant of multigrid theory (Brandt, Hackbusch) for the lattice Maxwell operator; the
      equipartition identity (1/2)(1 - L^-4) says the coarse correction carries exactly 1/L^4 of the fluctuation variance, the multigrid
      count of what a coarse space can remove. gamma0 = 1.0000 at the face centre for L = 3 is a two-grid constant.
 (U2) THE CONE IS AN EULER STEP WITH A CERTIFIED LOCAL ERROR. One blocking step is one Euler step of d beta/d l = -8 b0 - 32 b1/beta - ...;
      (6.1) is the condition that the step's local truncation error (A1/beta + K3/beta^2) stays below its progress (c1 - delta_min): the
      validated-numerics criterion for integrating an ODE whose vector field is known only within bounds (Lohner; Zgliczynski), with step
      size ln L.
 (U3) THE TUBE IS A STABLE MANIFOLD. The L^-2 contraction of the dimension-six ratios (read exactly in the rectangle direction) and the
      L-independent free fixed point (tau* = (kL)^2/6 on an axis, (kL)^2/8 on the diagonal) are the Hasenfratz-Niedermayer perfect action
      as the hyperbolic fixed point of the tree-level map; the cone is a neighbourhood of its stable manifold (Hirsch-Pugh-Shub).
 (U4) THE CONVEXITY EDGE IS THE PLAQUETTE'S 90 DEGREES. Convexity on the slice is lost where single plaquettes pass pi/2, the radial
      Hessian cos|Theta| changing sign: M6's "convexity edge at 90 degrees" found here as the true edge of the slice.

## 10. LEDGER (this agent's rows)

| Item | Status | Where |
|---|---|---|
| the cone as a tube around the renormalised trajectory; the reduction to (H1)-(H6) and to (6.1) | PROVED (the reduction) | sections 2, 6.1 |
| the tolerance eps = c1 - delta_min in absolute beta units; the per-step scheme deviation S'(1 - rho)|c - c*| | PROVED | section 2.4 |
| Balaban's linearised average is gauge covariant, Q(d lambda) = d'lambda | PROVED (Fourier identity); checked to 4.4e-15 | section 4 |
| K_var in [(1/2)(1 - L^-4), 1/2]; its mean exactly (1/2)(1 - L^-4) (equipartition) | PROVED; READING agrees to 6 digits | section 4.1 |
| gamma0 = 1.8496 (L = 2), 1.0000 (L = 3); K_link 0.1315 / 0.1099; l1(C) <= 2.70 (L = 2) | READING | sections 4-5 |
| tree-level F^2 coefficient preserved; rho_tree = L^-2 in the rectangle direction; free fixed point 1/6, 1/8 per (kL)^2, L-independent | READING (limits exact to 4-5 digits) | sections 4.3, 5 |
| c1, K2, z_c, chi^2 quantiles, floors, budgets, step counts | COMPUTED (mpmath.iv, 40 digits) | rec/c3_table |
| convexity radius: crude provable 0.063; convex under adversarial search to b = 0.5; rays cross at >= 0.656 | READING | section 5 |
| the verdict at beta = 50: NOT CERTIFIED; equivalent to K3 <= 417 / 792 together with b_cvx >= 0.3 | PROVED (the equivalence, given the chain) | section 6.4 |
| crude remainder methods close at beta* about 200-7.10^4 | ESTIMATED (tree-graph counting) | sections 6.4, 9.1 |
| cost: one inequality by monotonicity; the constants once (hours to weeks) | PROVED (monotonicity) / ESTIMATED (times) | section 7 |

## 11. DATED CORRECTIONS AND ONE STRUCTURAL READING (2026-11-02, after sections 0-10; nothing above edited)

11.1 THE "CRUDE PROVABLE" CONVEXITY RADIUS 0.063 IS A READING, NOT PROVED. The e(b) values of section 5 are LOWER bounds on the sup
(multi-start hill climbing; the record prints "e(b) >="); inserting a lower bound into 6 e(b) <= gamma0 bounds the crude radius from ABOVE.
What is PROVED: the cubic (second-order BCH) part of one plaquette's action, V3 = -sum over the four link triples of det[phi_a, phi_b, phi_c],
has a Hessian whose 3x3 blocks are sums of two cross-product matrices of norm <= b each, three off-diagonal blocks per block row, so
||Hess V3|| <= 6b on |phi_i| <= b; hence the cubic part alone forces 36 b <= gamma0 (eta = 1), b <= 0.051 at L = 2 (gamma0 = 1.8496 as
read). The quartic and higher remainder is not bounded here. Relabel throughout: "crude provable radius 0.063" -> "crude radius about
0.05-0.063 (cubic part PROVED at 6b; the rest READING)"; the floor "372 at the provable radius" -> "about 372-570 at the crude radius
(READING)". Sections 6.2, 6.3, 6.4, 9.3 (N1) and the ledger carry this label.
11.2 "EQUIVALENT" -> "SUFFICIENT, GIVEN THE CHAIN". Section 6.4 and the ledger say the beta = 50 cone property is EQUIVALENT to
K3 <= 417 / 792 together with b_cvx >= 0.3. The chain (H1)-(H6) is a reduction stated and proved in the direction (H1)-(H6) => cone
property; it is not shown necessary, and another cone could close otherwise. What holds: the cone property holds at beta IF (6.1) and (H6)
hold (with (H2), (H4), (H5) at their stated constants).
11.3 THE LINK-DOMAIN SHEARER RADIUS IS A NAMED ASSUMPTION. Gaussian correlations of the fluctuation field are not finite-range, so the use of
z_c(18) in section 5.0 and the floors 1.4771/b^2, 1.2346/b^2 is M6-style: ASSUMPTION (named): the large-field link events are treated as a
hard-core gas on the link graph of dependency degree 18 (links sharing a plaquette), with activities at least the Gaussian probability.
11.4 "THE GAUSSIAN PART OF THE STEP IS IN HAND" -> "READ". Of the Gaussian constants only K_var's bounds [(1/2)(1 - L^-4), 1/2] are PROVED;
gamma0, K_link, l1(C) and rho_tree are READINGS whose certification is item 7.2(a). The verdict sentence of 6.4 reads accordingly.
11.5 THE LABEL OF c1. The numbers c1(L) = 8 b0 ln L are COMPUTED (interval arithmetic) from the universal one-loop coefficient
b0 = 11 C_A/(48 pi^2), which is READ (universality of the first two beta-function coefficients on the renormalised trajectory). The block
map's own one-loop shift — including its first-step transient from Wilson's action — was NOT computed here.
11.6 TWO HEDGES. (i) "The crude expansion does not even converge at beta = 50" (6.4) is a consequence of the ESTIMATED tree-graph count
390/sqrt(beta): read "on this counting". (ii) The preference for L = 3 (tolerance 1.73 times L = 2's) is not settled: K3 grows with L (more
fine plaquettes per coarse cell, more scales per step), and the ratio of K3(3) to K3(2) is not known.
11.7 MONOTONICITY (7.1) IS CONDITIONAL. "(6.1) at beta* certifies every step down to beta*" holds provided the remainder lemma delivers a
beta-UNIFORM constant K3 (and A1) — which is how (N2) must be stated.
11.8 THE GAP MINIMISER, READ (record `rec/gamma0_mode.2026-11-02a.txt`, rc = 0): at the zone-face centre k = (pi/L, 0, 0, 0) of the CENTRED
L = 3 block the softest constrained mode has eigenvalue 1.0000000000 = 4 sin^2(pi/6) (triply degenerate), weight exactly 1/2 on the m = 0
alias and 1/2 on its mirror alias p = -pi/L (the two face-degenerate aliases), |Qv| = 4e-18, while the pure m = 0 transverse vector is NOT in
ker Q (|Qe| = 0.0247): the softest fluctuation is the standing wave of the two face aliases whose centred block averages cancel. With
gamma0(k -> 0) -> 3.0000 = 4 sin^2(pi/3) (the first nonzero alias 2 pi/L, read in section 5) this gives the structural reading
gamma0(centred L) = 4 sin^2(pi/(2L)) — the free Wilson eigenvalue at the coarse zone face, attained because the centred average is
reflection symmetric — READ at L = 3, a conjecture for odd L >= 5 (L = 5: 0.3820; L -> infinity: (pi/L)^2). For the half-open L = 2 block the
gap 1.8496 lies BELOW the face value 4 sin^2(pi/4) = 2: its minimiser has weight 0.469 on m = 0 and a longitudinal component — the
half-open average lacks the reflection that makes the standing wave exact. A second structural reason to prefer centred blocks.
11.9 PROCESS NOTE. One `python - <<` heredoc was run (the patch of bin/m8_c3_table.py). It did not hang, but the assignment forbade it; every
later script was written to a file.
