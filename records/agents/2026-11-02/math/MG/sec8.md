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

