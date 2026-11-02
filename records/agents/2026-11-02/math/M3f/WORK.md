# M3f — THE TWO-CUTOFF COMPARISON (E1 IN FULL); R_D LIPSCHITZ; LEMMA B'S ITEMS; LEMMA D

Proof agent M3f, 2026-11-02. Work directory `.../scratchpad/math/M3f/`. Appended as the work proceeds; nothing above a
line is edited after it is written except by a dated correction below it. Labels: READ (on the rendered page image, today,
by this agent), PROVED (full proof here), PROVED GIVEN [named input], OPEN (stated, with the next step), NAMED (an object
stated with its falsifier).

## 0. Sources

Read in full before deriving: `math/MATH_BRIEF.md`; `math/M3/WORK.md` (§§0–11); `math/M3R/REVIEW.md`; `math/M3b/WORK.md`
(§§0–15); `math/M3c/WORK.md` (§§0–12); `math/M3cR/REVIEW.md`; `math/M3d/WORK.md` (§§0–9); `math/M3e/WORK.md` §§0–1, 6–8
(to avoid duplicating M3e's (189)–(190) and CMP 99 audit). The record: III-Yang_Mills `OPEN/the-far-shore.md` (the Σ1b rows),
commit c9b987f (`OPEN/ledger/d4-balaban-the-pages.md` §14, the reduction to Lemmas A, B, C with quantifiers), commit 249d913
(D4b); III `DOCS/III-APERANTON-ADDENDUM-II-THE-SEQUENCE-HYPOTHESIS.md` (§§0–8, Lemma B's proof on paper, (B1), (B2));
III `LEAN/aperanton/Aperanton/CouplingTransient.lean` (all 201 lines).

READ ON IMAGE TODAY (this agent): CMP 119 pp. 254 (rendered here, `render/cmp119_254.png`), 255–264 (M3d's renders);
LFR I pp. 175–177; LFR II pp. 388–390. (CMP 119 = `Downloads/Download (6).pdf`, LFR I = `Download (2).pdf`, LFR II =
`Download (4).pdf`, hashes as in M3b §0.)

## 1. The decision (deep-think synthesis, before deriving)

Decision. (I) E1: prove what R_D's structure gives exactly (linearity at fixed coupling field, analyticity in the field),
prove the Lipschitz lemma by Schwarz on a segment of data, assemble a comparison theorem for two densities IN ONE CLASS
(Bałaban's own space 𝒟_k, CMP 119 p. 262), and locate exactly what separates two cutoffs from one class. (II) Lemma B: write
the gauge-fixed stage identity as an EXACT Gaussian identity (an adapted gauge condition makes it block-triangular), show the
alias terms cannot enter f(k) at all, prove (B1) as a convergent difference of two lattice loop integrals; Lemma D from
Lemma M.

What moved the plan (two lenses).
- First principles on R (LFR I (0.3), READ): R replaces a large-field expression by the small-field one "in such a way, that
  integrals of the densities are unchanged" (p. 176). It preserves INTEGRALS, not the density. So Bałaban's ρ_K is not the law
  of the unit-scale block variables, and "convergence of the effective actions" is a statement about generating functionals,
  not about the blocked measures (§2). This fixes the form of E1.
- Systems: Bałaban's class has a RIGID LEADING PART, the Wilson action of the bare lattice at the constrained minimizer,
  A(U_k(V)) with U_k computed on the bare lattice. Two cutoffs have two different leading parts. The loop-level comparison is
  a contraction argument inside one class; the tree-level difference is a separate object (§6).

Kill-switches. (K1) a step of R that is nonlinear in the density at fixed coupling (then Lipschitz needs more than Schwarz);
(K2) a marginal remnant in the history not removed by the step's counterterm (then the comparison carries log K); (K3) an
alias contribution to the P² coefficient at fixed k (then f(k) ≠ c_W − c(S_k)).

## 2. WHAT R PRESERVES — AND WHAT IT DOES NOT (READ; PROVED)

2.1 THE DEFINITION (LFR I pp. 176–177, READ). ρ(V) = Σ_Z ρ(Z, V) (0.2), Z the large-field region of a term, split
Z = Z′ ∪ Z″ (Z′ the components to be renormalized: inside a cube of size 100MR_k and quiet for N steps, p. 177 (i)–(ii)).
(Rρ)(V) = Σ_Z ρ(Z″, V)·∫dV|_{Z′}ρ(Z, V) / ∫dV|_{Z′}ρ(Z″, V) (0.3), with the denominators replaced by "the integrals of some parts of
these densities … localized in neighborhoods of the domains Z′ … determined by small field effective actions only" (p. 177);
the actual denominator (LFR II (1.1), p. 356, transcribed by M3d §1.1) is ∫dV′Γ_Λδ_{G₀}(V′)χ exp[−(1/g_k²)A(ζ₀, U_{k,Z}(V′V_Λ))], a
function of the data V_Λ outside Λ and of the coupling only. (0.4): ∫dV(Rρ)(V) = ∫dVρ(V). (0.5)–(0.6): the ratios exponentiated,
(Rρ)(V) = Σ_{Z″}ρ(Z″, V)exp Σ_X R(X, V). LFR II (1.91), p. 388 (READ): the activities F(X′) contain the large-field operations
T′_k(X_{j_h}) of the renormalized components — the deep large-field integrals are integrated out INTO the activities; (1.100),
p. 390 (READ): the new R-terms (domains disjoint from the remaining large-field region) obey |R′^{(k)}(X)| ≤ e^{−p₀(g_k)}e^{−κd_k(X)},
the ones meeting it become new boundary terms B′^{(k)}(X).

2.2 PROPOSITION (linearity; PROVED from 2.1). At a fixed coupling field (Bałaban's reference, or x_k + D(·) for R_D), R is a
LINEAR operator on densities: the numerator is linear in the term ρ(Z, ·) (an integral of it times the new Wilson factor), and
the denominator does not depend on ρ. So R(ρ + ρ′) = Rρ + Rρ′, and R_D depends on the input density only linearly and on D
analytically (M3d Lemma 2: the R_D denominator is analytic and nonvanishing on |d| ≤ θ₀/2). Kill-switch (K1) is not met.

2.3 PROPOSITION (what R preserves; PROVED). For a term with renormalized region Z′ put q_Z(V_{Z′^c}) := ∫dV|_{Z′}ρ(Z,V)/den(Z′,V).
For an observable F depending only on variables in a set A with A ∩ Z′ = ∅,
  ∫dV ρ(Z″,V)q_Z F = ∫dV_{Z′^c} q_Z F·[∫dV_{Z′}ρ(Z″,V)],
which equals ∫ρ(Z, V)F dV when den = ∫dV|_{Z′}ρ(Z″, ·) (the idealized (0.3)) and differs from it by the denominator's replacement
otherwise. If A ∩ Z′ ≠ ∅ the two differ in general: the conditional law of V|_{Z′} is changed from the large-field one to the
small-field one. So R preserves (i) the integral ∫ρ (0.4) and (ii) termwise the marginal on (Z′)^c (idealized form), and NOT the
law of the variables in Z′.

2.4 CONSEQUENCES (PROVED from 2.3).
(a) Bałaban's ρ_K = (RT)^Kρ₀ is not the law of the unit-scale block variables: ∫ρ_KF/∫ρ_K ≠ ⟨F(Q^KU)⟩ in general. The
    partition function is exact: ∫ρ_K = Z × (the subtracted vacuum constants).
(b) An observable is computed exactly by Bałaban's machinery only as part of the density from the bare scale on, i.e. as a
    SOURCE whose generating functional is a partition function. The source in the coupling of (S₁) (M3b §5) is of this kind:
    Z_K(τ) = ∫ρ₀e^{τO(h)} is computed exactly by the D-deformed construction, because R_D preserves integrals at every D (M3d
    §2.1 (a)). A coarse insertion F(Q^KU) commutes with every T (F∘Q^{K−k} is constant on T's fibres) and not with R unless R
    acts on ρ·(F∘Q^{K−k}).
(c) DATED CORRECTION TO M3 §7 (E0) (M3's file untouched). M3 wrote: "on the small-field set the density is bounded below by
    Bałaban's χ_k exp[−(1/g²)A(U_k) − E₋|T|] and above by exp(E₊|T|) … so every limit point is a genuine weak-coupling measure".
    Those bounds (CMP 119 (2.50)) bound ρ_K, which is not the blocked law. The existence of subsequential limits (compactness)
    stands; the non-degeneracy claim needs the insertion version (M3's object (S)) and is withdrawn as stated. The same caution
    applies wherever the crossover reads "the blocked measure" off Bałaban's effective density: Hypotheses I and II (THE
    GROUND §8.3) are about the true blocked law λ_j.
(d) THE FORM OF E1. E1 is the convergence, as K → ∞, of generating functionals: for the 0⁺⁺ channel, of W_K(τ) := log Z_K(τ) −
    log Z_K(0) − V_K(τ) (M3b (S₁)(ii)–(iii), V_K the local vacuum part); for coarse observables, of Z_K(F)/Z_K(1) with F carried
    as an insertion (M3 (S)). Comparing the R-modified effective actions is the right MEANS (it computes the integrals exactly),
    with the comparison stated for ∫ρ_K.

## 3. LEMMA RL — R_D (AND THE WHOLE STEP) IS LIPSCHITZ IN ITS INPUT DATA

3.1 THE DATA AND THE NORM. On the reference trajectory with the device (every background, cutoff, characteristic function,
δ-function, Gaussian form C*Δ^{(j)}C and gauge-fixing weight at the reference; M3b §6.1, M3d §2.2), a density of the class at
step k (CMP 119 (2.18)–(2.42); the space Bałaban names on p. 262, READ: "For a given index k we introduce the space of all
densities satisfying the conditions of the inductive assumption. The theorem states that the operation RT transforms the space
with the index k into the space with the index k + 1") is
  ρ = Σ_σ χ_k(Ω_k) T_k^σ exp A_k^σ,   A_k^σ = −A(x_k(1 + d_k(·)), U_k) + E_k + R_k + B_k − E_k,
σ = ({Ω_j}, {Λ_j}, {S_j}) the domain sequences. By the device the operations T_k^σ are fixed (they contain only reference objects:
CMP 119 (2.21) READ — characteristic functions, δ-functions, the quadratic forms of the reference Gaussians), and the data of the
density are
  𝔞 := ( d_k(·); {E^{(j)}(X)}, {R^{(j)}(X)}, {B^{(j)}(X)} ),
each localized term analytic on its space (CMP 119 (2.27)(ii), (2.31), (2.41)(ii): all three on Ũ^c_j(X, α̃₀, α̃₁), READ pp. 259–261).
The class bounds: |d| ≤ θ₀/2; |E^{(j)}(X)| ≤ E₀e^{−κd_j(X)} (I.1.18); |R^{(j)}(X)| ≤ g_j^{κ₀}e^{−κd_j(X)} (2.31); |B^{(j)}(X)| ≤ B₀e^{−κd_j(X)}
(2.42). For two data sets on the same σ's,
  ‖𝔞′ − 𝔞‖ := max{ sup|δd|/θ₀,  sup_{j,X} e^{κd_j(X)}|δE^{(j)}(X)|/E₀,  sup_{j,X} e^{κd_j(X)}|δR^{(j)}(X)|/g_j^{κ₀},  sup_{j,X} e^{κd_j(X)}|δB^{(j)}(X)|/B₀ },
sups over the analyticity domains. 𝒟_k^{(2)} := the same class with every bound doubled.

3.2 (ROB) — THE ROBUSTNESS INPUT (NAMED, at the level of [BB-c]). Bałaban's step RT (with R replaced by R_D and the D-term in the
interaction) maps 𝒟_k^{(2)} into the class at k + 1 with every output bound multiplied by an absolute factor c_ROB (independent of
k, K, the volume and the data), every output datum being an analytic function of any complex parameter on which the input data
depend analytically. WHY IT IS THE SAME BLACK BOX: (i) the small-field step is Lemma M_c (M3d §9.2) on the cone 𝒱(ε_*); doubled
history bounds put the potential in 𝒱(2E₀C₁ε₁) ⊂ 𝒱(ε_*) once ε₁ ≤ ε₁^max/8 (M3cR's stated condition already gives the factor 2);
(ii) Theorem PI-4's conclusion (c) is exactly this robustness for the boundary-term constants ("enlarged by absolute factors");
(iii) the large-field steps use the input's R- and B-terms only inside exponentials over the large-field region, dominated by the
suppression e^{−(1−θ₀/2)p₀(g_k)|Z|} (LFR II (1.89)_D), which absorbs a doubling for g_k small; (iv) d enters Lemma 2 (the R_D
denominator) only through |d| ≤ θ₀ on the doubled class, which holds with θ₀ ≤ min(θ_*/2, 1/8). FALSIFIER: an inductive estimate
whose closing condition uses the input constants at their exact values (e.g. "O(1)C₃ε₁ ≤ ½E₀" with no room) — CMP 116 (2.41) says of
that one "In fact this assumption is unessential" (M3c §1.3, READ there).

3.3 LEMMA RL (PROVED GIVEN (ROB)). Let 𝔞, 𝔞′ be data of the class at step k on the same domain sequences, η := ‖𝔞′ − 𝔞‖ ≤ 1.
Then the outputs of one step satisfy, datum by datum,
  ‖𝔞^{out}′ − 𝔞^{out}‖_{k+1} ≤ 2c_ROB·η,
and the R_D-outputs alone (the new R- and B-terms) obey the same with their own output bounds: |δR′^{(k)}(X)| ≤ 2c_ROB η e^{−p₀(g_k)}e^{−κd_k(X)}.
PROOF. Put 𝔞_ζ := 𝔞 + ζ(𝔞′ − 𝔞), ζ ∈ ℂ. For |ζ| ≤ 1/η each datum of ζ(𝔞′ − 𝔞) is within its class bound, so 𝔞_ζ ∈ 𝒟_k^{(2)}; the data are
affine in ζ. By (ROB) every output localized term h_X(ζ) is analytic on |ζ| < 1/η with |h_X(ζ)| ≤ c_ROB·b_X (b_X its class bound).
g_X(ζ) := h_X(ζ) − h_X(0) is analytic there, |g_X| ≤ 2c_ROB b_X, g_X(0) = 0; Schwarz's lemma on the disc of radius 1/η gives
|g_X(1)| ≤ 2c_ROB b_X·η. The domain sequences are the same for all ζ (the device: R_D's choice of Z′ and the new large-field regions
are functions of reference objects only). ∎
REMARK. Lemma RL is a sup-norm Lipschitz bound, NOT a contraction: the old terms of the history are carried unchanged by a step
(CMP 119 (2.25), (2.30), (2.40): sums over scales of fixed functions re-evaluated at the new configuration). The contraction lives
in how OLD terms enter NEW terms, which is PI-5's weighted statement; §4 combines the two.

3.4 THE WEIGHT (W) (PROVED GIVEN [BB-c]). Every localized term of scale m — E, R or B — enters the scale-k fluctuation integral with
CMP 116 (1.24)'s weight: its contribution to the step's potential is bounded by (its own bound)×8B₀C₁e^{16κ₁}α₂^{−1}g_k|B|(α₁/α₃)⁵(L^mη)⁵…,
i.e. it is in the cone 𝒱(C₁ε₁·(its bound)·(6L)⁴L^{−(k−m)}) after the □-sum (M3d §3.1 (a), READ there on CMP 116 pp. 7–8).
PROOF. The extraction (1.22)–(1.24) uses only that the term is analytic on the space U^c_m(X, α₀, α₁) of its scale with a bound; E-,
R- and B-terms are all analytic on Ũ^c_m(X, α̃₀, α̃₁) (CMP 119 (2.27)(ii), the sentence after (2.30), (2.41)(ii), READ pp. 259–261); the
extraction is linear in the bound. ∎

## 4. THEOREM U — UNIVERSALITY INSIDE ONE CLASS (the comparison of two densities, with constants)

4.1 SETTING. Fix the bare lattice T_ε (ε = L^{−K}), the reference trajectory (x_j)_{j≤K} of Theorem 2 with x_K = X, and k₀ < K. Two
densities ρ^a, ρ^b in the class at step k₀ on the SAME domain structure (the device), real (real data on real configurations), with
data 𝔞^a, 𝔞^b. Run both through the steps k₀ → K, run b's coupling chosen (Lemma A′'s IVT at step k₀) so that its unit-scale coupling
equals X: δ_K = 0, δ_j := |d^b_j − d^a_j|. Difference profiles at step k:
 a_{(m)}: least constant with |δR̂^{(m)}(X)| ≤ a_{(m)}e^{−κd_m(X)} for the NORMALIZED scale-m E-terms (CMP 119 (2.25), PI-5's R^{(m)}), N_k := ½Σ_{m≤k}a_{(m)}L^{−(k−m)};
 r_{(m)}: the same for the scale-m R-terms, ρ_k := Σ_{m≤k} r_{(m)};
 b_{(m)}: the same for the scale-m B-terms, B_k := Σ_{m≤k} b_{(m)}2^{−(k−m)}.
Initial values at k₀: N_{k₀}, ρ_{k₀}, B_{k₀} (the differences of the two inputs), δ_{k₀}.

4.2 THE ONE-STEP INEQUALITIES (PROVED GIVEN [BB-a]–[BB-c], Lemma M_c, PI-4, PI-5, (ROB), (W)). With H_k := N_k/E₀ + Σ_{m≤k}
r_{(m)}L^{−(k−m)} + Σ_m b_{(m)}L^{−(k−m)}/B₀ (the history difference in the weighted form of (W)):
 (E) a_{(k+1)} ≤ 8E₀δ_k/θ_* + 8E₀C₁ε₁E₀H_k/ε_*,
 (R) r_{(k+1)} ≤ 2c_ROB e^{−p₀(g_k)}(δ_k/θ₀ + C₁ε₁E₀H_k/ε_* + H_k),
 (B) b_{(k+1)} ≤ 2c_ROB B₁(δ_k/θ₀ + H_k),   and the old B-terms of age j − n carry the factor 2^{−(j−n)} (CMP 119 (2.47), READ p. 264),
 (C) |δ_{k+1} − δ_k| ≤ w_kδ_k + C(g_k² + ε₁g_k)g_k²H_k + t_k,   w_k := C′g_k^{3}, t_k the own-versus-reference shells (Lemma SH, Lemma P3).
PROOF. (E) is M3d (3.3) with the history difference in (W)'s weighted form (V′_k[Δhistory] ∈ 𝒱(C₁ε₁E₀H_k) by (W) and the cone property;
Schwarz in ζ on Z₀ = ε_*/(4C₁ε₁E₀H_k) and Cauchy in d as in PI-5 (ii)). (R), (B): Lemma RL applied on the segment with the weighted
norm — the new R- and B-terms are R_D's outputs (2.1), bounded by e^{−p₀(g_k)} (LFR II (1.100)) and B₁ (CMP 119 (2.47) at j = n);
their dependence on the input passes through (i) the small-field part of the region's action (weighted as in (E)) and (ii) the
action inside the renormalized region, where the input's terms enter the T′-integrals' exponent with the weight (W) and no factor
ε₁ — hence the term H_k without ε₁. (C) is M3d §4.3's coupling recursion (Lemma C′ (c), PI-5 (3.2), Lemma SH/P3). ∎

4.3 THEOREM U (PROVED GIVEN the inputs of 4.2). Under 4.1, for γ small (in Bałaban's order: L, κ, κ₁, M, ε₁, then γ),
 (i) the coupling deviation difference obeys max_{k₀≤j≤K}δ_j ≤ 2e^{Cγ}[C Σ_{j≥k₀}(g_j² + ε₁g_j)g_j² H_j + Σ_{j≥k₀} t_j] — the BACKWARD
     tuning: δ_K = 0 is imposed at the unit scale;
 (ii) H_k ≤ q^{k−k₀}H_{k₀} + C Σ_{k₀≤i<k} q^{k−1−i}(δ_i/θ₀ + ρ-increments), q = L^{−β′} < 1 (PI-5's contraction, with
      L^{−β′} := L^{−1} + 4C₁ε₁E₀/ε_* + 2c_ROB e^{−p₀(g_{k₀})} + ½-weights for B);
 (iii) the unit-scale data differ, per unit block, by
      η_K := Σ_m a_{(m)}L^{−β(K−m)} + ρ_K + Σ_m b_{(m)}2^{−(K−m)}
           ≤ C[(K − k₀ + 1)q^{K−k₀}H_{k₀} + ρ_{k₀} + Σ_{j≥k₀}e^{−p₀(g_j)}(q^{j−k₀}H_{k₀} + δ_j) + 2^{−(K−k₀)}B_{k₀} + Σ_{j≥k₀}t_j],
      the E-terms read through CMP 119 (2.43) (the normalized scale-m term at the unit scale carries (L^{m−K})^β per block), the R-terms
      through (2.44) (no decay — marginal — but each carries its creation factor), the B-terms through (2.47);
 (iv) for the generating functionals (§2.4 (d)): |log∫ρ^b_K − log∫ρ^a_K| ≤ C N_T η_K, N_T the number of unit blocks of the torus T.
PROOF. (i): sum (C) backward from δ_K = 0 and apply Gronwall with Σ_j w_j ≤ Cγ (D4b (E4), Σg_j³ ≤ Cγ/(c − ρ)) — the argument of
Proposition E1-a (M3d §4.3) run from the unit scale down. (ii): the recursion H_{k+1} ≤ qH_k + C(δ_k/θ₀ + increments) from (E)–(B), as in
PI-5 (iv): the old terms reappear with one more factor L^{−1} (E), stay put (R: marginal, but each increment carries e^{−p₀(g_k)} ≪ 1),
or halve with age (B). (iii): insert (i)–(ii) into the unit-scale readings (2.43), (2.44), (2.47); the double sum
Σ_i q^{K−1−i}g_i²(g_i² + ε₁g_i)Σ_{j≥i}… is ≤ C(K − k₀ + 1)q^{K−k₀}H_{k₀} because δ_j itself is generated by H_j ≤ q^{j−k₀}H_{k₀} + … (the
tuned δ is SECOND order in the deep difference — this is what removes the (log K)² of M3c §7.5 and here gives (K − k₀ + 1)q^{K−k₀}).
(iv): at real data every term of (2.18) is positive (T_k^σ integrates positive weights — CMP 119 (2.21); exp A_k^σ > 0; the R_D
denominators are positive), the two densities have the same terms σ with |δA_k^σ| ≤ CN_Tη_K pointwise, so |ρ^b_K(V) − ρ^a_K(V)| ≤
(e^{CN_Tη_K} − 1)ρ^a_K(V) for every V, and the integrals compare. ∎
STATUS AND WHAT IT COVERS. Theorem U is PROVED GIVEN [BB-a]–[BB-c], Lemma M_c, Theorems PI-4 and PI-5, (ROB) and (W). It is the
comparison for any change of the bare density INSIDE ONE CLASS: (1) two bare couplings on one lattice (E1-a, E1-b are its
coupling rows); (2) the bare Wilson density times exp E₀(U) with E₀ a gauge-invariant, W(B₄)-symmetric, analytic local term of
size O(1) on Bałaban's absolute domain (relative order g² to the Wilson action — a one-loop-order change of the bare action); (3) a
source in the coupling (S₁), as the coupling-field part of the data. It does NOT cover a change of the bare LATTICE (cutoff,
rotation) or of the TREE-LEVEL action (coefficients O(1/g²)): those change the background U_k(V) itself (§6).

4.4 THE FALSIFIER (K2) IS NOT MET. A marginal remnant in the E-history would make (E)'s output feed the coupling at order g²
without decay and give Σ_j g_j² ~ log K; PI-5's argument (the counterterm at the actual parameter, Lemma Σ₁, W(B₄)) excludes it.
The R-terms ARE marginal (Bałaban's own words, CMP 119 p. 260, READ: "After the vacuum energy renormalization we obtain a sum of
marginal terms … The sum over j is controlled by g_j^{κ₀}"), and Theorem U carries them as such: they cost ρ_{k₀} + Σe^{−p₀(g_j)}(…),
not log K, because each is created with the factor e^{−p₀(g_j)} ≤ g_j^{κ₀}.

4.5 DATED PRECISIONS TO §§2–4 (2026-11-02, written after 4.4; nothing above edited).
(a) To 2.3. With Bałaban's ACTUAL denominators (LFR II (1.1)) the new Wilson factor on Λ and the denominator are one weight (M3d
    §1.1: ∫dV′[new factor]/[denominator] = 1). So the actual R preserves, termwise, the marginal of the variables outside the
    integration region Λ EXACTLY, and replaces the conditional law of V|_Λ by the normalized new Wilson factor. The conclusions of
    2.3–2.4 stand with Z′ replaced by Λ ⊃ Z′.
(b) To 4.2 (B) and 4.3 (ii). The B-row of the recursion has an O(1) coefficient (2c_ROB B₁/B₀), not a small one: without more,
    the coupled system is not visibly contracting. What closes it is where B-terms live: CMP 119 (2.41), READ — their domains meet
    Ω_j and Z_j^~, so every B-term belongs to a term σ of (2.18) that still carries its large-field region, and that term's
    large-field operation is bounded by e^{−2(1+β₀)^{−1}(1−θ₀/2)p₀(g_n)} per component (LFR II (1.89)_D); when the region is renormalized
    its B-terms are integrated into the R_D-activities (LFR II (1.91)), which carry e^{−p₀(g)} (1.100). So a B-difference reaches a
    later E-output, R-output or the integral (iv) only multiplied by e^{−cp₀(g_n)}. Weighting the B-row of H_k by e^{−cp₀(g_n)}
    restores q < 1. This is the input (B-SUP), NAMED: "every B-term enters the data of later steps and the integrals only inside
    terms carrying its region's large-field operation, or inside R_D-activities"; FALSIFIER: a B-term that survives the
    renormalization of its region as a B-term of a small-field term. Theorem U's status is PROVED GIVEN the inputs of 4.2 AND (B-SUP).

## 5. E1 INSIDE ONE CLASS — THE GENERATING FUNCTIONAL (PROVED GIVEN Theorem U's inputs and (B-SUP))

COROLLARY 5.1 (universality of the bare action inside the class). Let ρ₀^a = exp(−x₀^aA) (Wilson) and ρ₀^b = exp(−x₀^bA + E₀^b) with E₀^b a
gauge-invariant, W(B₄)-symmetric local term analytic on Bałaban's absolute domain with |E₀^b(X)| ≤ E₀′e^{−κd₀(X)}, both tuned to unit
coupling X, and the source τh carried in both (S₁). Then for real τ on (S₁)'s disc
  |W^b_K(τ) − W^a_K(τ)| ≤ C N_T[(K + 1)q^K E₀′/E₀ + Σ_{j≥0}e^{−p₀(g_j)}q^j + Σ_{j≥0}t_j],
which tends to 0 as K → ∞ (the first term exponentially; the others because the deep g_j are small); by Vitali's theorem (W^{a,b}_K
analytic in τ and bounded uniformly in K: M3b (S₁)(iii), proved by M3d §4.4) the convergence holds uniformly on compact subsets of
the complex disc, with every τ-derivative — the connected correlations of the action density at separated points.
PROOF. Theorem U with k₀ = 0, H₀ = E₀′/E₀ (the E-row of the initial difference), ρ₀ = 0, B-row 0, and (iv) applied at τ and at 0;
V_K^b(τ) − V_K^a(τ) is a sum over scales of local c-numbers depending on the data near z at each scale (M3b (S₁)(ii)), compared term
by term with the same bound. ∎
WHAT IT SAYS. The continuum limit of the 0⁺⁺ generating functional, along any sequence on which it exists, does not change when the
bare Wilson action is changed by gauge-invariant symmetric local terms of relative order g² — universality inside Bałaban's class,
with the exponential rate (K + 1)L^{−β′K} for the irrelevant part.

## 6. TWO CUTOFFS: THE OBSTRUCTION IS THE TREE LEVEL — LOCATED, HALF PROVED, THE REST NAMED

6.1 THE EXACT REDUCTION (PROVED). For K < K′ put m := K′ − K. The K′-theory after m exact steps is a density ρ′_m on T_ε, the
K-theory's bare lattice; both unit-scale densities are K further steps of it. So the two-cutoff comparison IS the comparison of two
"bare" densities on T_ε: ρ₀^{(K)} = exp(−x₀A^ε) and ρ′_m. THE OBSTRUCTION: ρ′_m lies in the K′-construction's class, whose leading
part is −x′_m A^{ε′}(U′_m(V)) =: −x′_m S′_m(V) with U′_m the minimizer ON T_{ε′} (CMP 119 (2.23), (2.12), READ), while ρ₀^{(K)} has
leading part −x₀A^ε(V). The difference x(S′_m − A^ε) is O(x) on Bałaban's absolute domain, not O(1): it is a history term of neither
class, and the two classes have different backgrounds U_k(V), hence different characteristic functions (CMP 119 (2.17), READ: χ_k(Ω_k)
is defined through U_{k,□}(V_k)). Theorem U does not apply as it stands. The two cutoffs differ at TREE LEVEL by irrelevant terms with
coefficients O(1/g²); Bałaban's construction separates tree level (backgrounds, minimizers) from loops (localized terms), so the
tree-level difference must contract by itself.

6.2 THE TREE-LEVEL DIFFERENCE IS A DIFFERENCE OF TWO TREE-LEVEL BLOCKINGS. Write S_j(V) := A^ε(U_j(V)) (j-step minimizer on T_ε),
S′_{m+j}(V) := A^{ε′}(U′_{m+j}(V)), Δ := S′_m − A^ε (a functional on T_ε), W′(V) := Q^mU′_{m+j}(V) (the m-step average of the T_{ε′}
minimizer, a configuration on T_ε with Q^jW′ = V).
LEMMA 6.2 (THE VARIATIONAL SANDWICH; PROVED). For every real regular V for which both minimizers exist (CMP 102 Theorem 1 on each
lattice, the minimum taken over regular configurations as in CMP 119 (2.12); Q^m maps regular configurations of T_{ε′} to regular
configurations of T_ε),
  Δ(W′(V)) ≤ S′_{m+j}(V) − S_j(V) ≤ Δ(U_j(V)).
PROOF. Hard constraints compose (M3 (B-ii); CMP 95 (1.68)): {U on T_{ε′} : Q^{m+j}U = V} = ∪_{W: Q^jW = V}{U : Q^mU = W}, so
S′_{m+j}(V) = min_{W: Q^jW=V} S′_m(W). (Upper) U_j(V) is admissible: S′_{m+j}(V) ≤ S′_m(U_j(V)) = A^ε(U_j(V)) + Δ(U_j(V)) = S_j(V) + Δ(U_j(V)).
(Lower) S′_m(W′(V)) ≤ A^{ε′}(U′_{m+j}(V)) = S′_{m+j}(V) since U′_{m+j}(V) is admissible for W′, and S′_{m+j}(V) ≤ S′_m(W′(V)) since W′ is
admissible for V; so S′_m(W′) = S′_{m+j}(V), and S_j(V) ≤ A^ε(W′) = S′_m(W′) − Δ(W′) = S′_{m+j}(V) − Δ(W′). ∎
WHY IT IS THE RIGHT OBJECT. The two-cutoff tree-level difference is squeezed between the IRRELEVANT functional Δ evaluated on two
interpolants of V that are smooth at scale L^j. No inversion, no kernel estimate, no comparison of two minimizers is needed.

6.3 THE SIZE (PROVED GIVEN (Δ-i), (Δ-ii)). (Δ-i) S′_m lies in the class 𝒮 of Lemma B (§9) with m-uniform constants (Addendum II §8:
ellipticity γ₀ = 1 and Wilson's dimension-four coefficient by the curl contraction and a plane wave — proved there; strip analyticity
from CMP 102 Thm 1, Prop. 9 and (190) — M3e: PROVED GIVEN CMP 99 (3.132)); then by Lemma WI (§9.2) Δ has no part of dimension below six:
|Δ(W)| ≤ C_Δ Σ_x(|∇F_W(x)|² + |F_W(x)|³) for regular W (lattice units of T_ε). (Δ-ii) the interpolants are smooth at scale L^j:
|F_W| ≤ CL^{−2j}|F_c|, |∇F_W| ≤ CL^{−3j}|F_c| (F_c the coarse curvature; the regularity of U_j(V) in CMP 102 Theorem 1 (conditions
(19)–(21)); for W′ the same for U′ followed by the average). Summing over the L^{4j} fine sites of each coarse block,
  |S′_{m+j}(V) − S_j(V)| ≤ C_Δ L^{−2j} Σ_{coarse p}|V(∂p) − 1|²(1 + O(α)),   uniformly in m:
the tree-level contraction L^{−2j} of the irrelevant directions. M3 (B-v) stated this rate for c(S_k) without proof; here it follows
from the sandwich.

6.4 (T_loc) — THE LOCALIZED ANALYTIC FORM (OPEN; route named). The change of background needs the difference inside Bałaban's
localized analytic class: x′[S′_{m+j} − S_j] = Σ_X δS(X) with |δS(X)| ≤ C_T x′L^{−2θj}α²e^{−κd_j(X)} on Ũ^c_j(X, α̃₀, α̃₁), some θ ∈ (0, 1].
Route. (a) Möbius localization on real V: f_Y(V) := Σ_{Y′⊂Y}(−1)^{|Y∖Y′|}(S′ − S)(V_{Y′}), V_{Y′} = V on Y′ and 1 elsewhere (axial gauge);
the sandwich bounds each (S′ − S)(V_{Y′}), so |f_Y| ≤ 2^{|Y|}C_ΔL^{−2j}|Y|α²; (b) each construction separately is localized,
|f_Y| ≤ Ce^{−κd(Y)} (the random-walk decoupling of the minimizers, CMP 116 §1 and M3e); (c) the geometric mean of (a) and (b) on real
V; (d) Hadamard's two-constants theorem from the real slice to a complex polydisc: |f_Y| ≤ (Ce^{−κd(Y)})^{1−θ}(real bound)^θ. FALSIFIER: the
switched configurations V_{Y′} leaving Bałaban's regular domain at ∂Y′ (curvature of size |V − 1| there), or a localized term of the
minimizer action not determined by its values on switched configurations.

6.5 (CB) — THE CHANGE OF BACKGROUND (NAMED). At step j₀ re-express ρ′_{m+j₀} in the K-class: (i) −x′S′_{m+j₀} = −x′S_{j₀} −
x′(S′_{m+j₀} − S_{j₀}), the second piece moved into the history — admissible once C_T x′L^{−2θj₀}α² ≤ E₀/4, i.e. for j₀ ≥ j_* :=
⌈(2θ)^{−1}log_L(4C_Tα²(X + K(c + ρ) + 2F)/E₀)⌉ = (2θ)^{−1}log_L K + O(1); (ii) the K′-history as functions of U_{j₀}(V) (analytic
composition of the two minimizer maps); (iii) the two backgrounds' small-field conditions differ on a shell of relative width C_TL^{−2θj₀}:
a large-field-type term with Gaussian-tail weight (as Lemma P3's shell); (iv) terms of ρ′ whose large-field regions reach below scale m
without having been renormalized in j₀ ≥ N + O(log) steps: weight ≤ e^{−cj₀p₀(g)}; (v) the deep R-terms of the K′-theory (scales ≤ m)
become an initial R-difference ρ_{j₀} ≤ Σ_{l≥K−j₀}(X + l(c − ρ) − 2F)^{−κ₀/2} ≤ C(K(c − ρ))^{1−κ₀/2}.

6.6 ASSEMBLY — E1 FOR TWO CUTOFFS (PROVED GIVEN Theorem U's inputs, (B-SUP), (Δ-i), (Δ-ii), (T_loc), (CB)). For K < K′ and real τ on
(S₁)'s disc,
  |W_{K′}(τ) − W_K(τ)| ≤ C N_T[(K − j_*)q^{K−j_*} + (K(c − ρ))^{1−κ₀/2} + e^{−c(log K)^{2p₀}} + |m_{K′} − m_K|],
uniformly in K′ > K; the right side tends to 0 (|m_{K′} − m_K| ≤ C Σ_{j: K′−j ≥ K} g_j^{2+a} → 0, M3b §6.3 with M3c's a = 1), and by
Vitali the convergence holds for complex τ with every τ-derivative. PROOF: (CB) at k₀ = j_* gives two densities in one class with
H_{j_*} ≤ C, ρ_{j_*} as in (v), B_{j_*} ≤ C, δ tuned; Theorem U from j_* to K. ∎ THE RATE is polynomial in 1/log(1/ε), any power (κ₀ is
Bałaban's free constant, CMP 119 p. 260, READ: "κ₀ can be chosen arbitrarily large, similarly as κ, if the other parameters are fixed
properly"); it is set by the deep R-terms, which are MARGINAL and small, not by the E-history (exponential).

## 7. LEMMA B (B-i): THE GAUGE-FIXED STAGE IDENTITY (M3R item 2c (1))

7.1 SETTING (finite dimensions, one loop around Bałaban's background). U* := U_k(V), the element of the minimal critical orbit
in the axial gauge (CMP 109 (2.2)–(2.3), READ by M3cR), parametrized by the exact chart of CMP 109 p. 267; tangent space 𝔲 (dim n);
the coarse tangent space 𝔳 (dim m); D := dQ_k(U*), surjective. Gauge groups 𝒢_f (fine), 𝒢_c (coarse); π: 𝒢_f → 𝒢_c the values at
the coarse sites, Q_k(u·U) = π(u)·Q_k(U) (covariance, CMP 109 (0.6)); R := ker π; orbit maps τ_f: 𝔤_f → 𝔲, τ_c: 𝔤_c → 𝔳,
Dτ_f = τ_cπ. S = A (Wilson), 𝒢_f-invariant; S_k(V) := min{S(U): Q_k(U) = V, U regular}; λ := S_k′(V) (S′(U*) = λ∘D);
H_λ := S″(U*) − ⟨λ, Q_k″(U*)⟩, the Hessian of L := S − λ∘Q_k at its critical point U*.
 (h1) L is R-invariant and U* is critical for L, so H_λτ_f(ξ) = 0 for every ξ ∈ 𝔯 (the Hessian of an invariant function at a
      critical point kills the orbit; M3c (FP2)).
 (h2) H_λ|_{ker D} ≥ 0 with kernel exactly τ_f(𝔯): the background is a NON-DEGENERATE constrained minimum modulo R (CMP 109 (2.2):
      "This critical configuration, which is a minimum"; M3cR §3.3 found non-degeneracy to be the real hypothesis).
 (h3) L_R: 𝔲 → 𝔤^{N_R} the linearized contour variables (CMP 109 (2.5)); L_Rτ_f|_𝔯 invertible (M3c (FP3); −identity site by site
      at the axial background, M3cR).
 (h4) a coarse gauge condition F_c: 𝔳 → 𝔤_c, covariant under global rotations and W(B₄), with F_cτ_c invertible (on the torus on
      the complement of the global constant modes, which are fixed once and contribute a constant).
Bałaban's one-loop constrained integral (the δ-constrained, R-gauge-fixed step at one loop; CMP 109 (0.17)–(0.19), (1.4)):
  W_k^{(1)}(V) := ½ log det(DD*) + ½ log det_{ker D}(H_λ + L_R*L_R) − log|det L_Rτ_f|_𝔯| + const.
(The coarea factor of δ(Q_k(U) − V), the fiber Gaussian, and the orbit integral of Bałaban's normalized gauge-fixing factor, which is
1 exactly (CMP 109 (0.15)) and |det L_Rτ_f|_𝔯|^{−1}·const in the Laplace approximation; with ker D = T ⊕ τ_f𝔯, T := ker D ∩ ker L_R, this
is ½log det(DD*) + ½log det_TH_λ + const, the Jacobians of the splitting cancelling.)
For a symmetric H on 𝔲 and a gauge condition F with Fτ_f invertible and H + F*F > 0 put Γ_f^{H,F} := ½log det(H + F*F) −
log|det Fτ_f|; and Γ_c^{F_c}(V) := ½log det(S_k″(V) + F_c*F_c) − log|det F_cτ_c|. THE ADAPTED GAUGE: F_f := (L_R, F_c∘D).

THEOREM 7.1 (THE STAGE IDENTITY, GAUGE-FIXED, EXACT AT ONE LOOP; PROVED). Under (h1)–(h4), at every V where they hold,
  W_k^{(1)}(V) = Γ_f^{H_λ,F_f}(U*(V)) − Γ_c^{F_c}(V) + const   (const independent of V),
and neither side has a zero mode: Φ := H_λ + F_f*F_f > 0 on 𝔲 and S_k″ + F_c*F_c > 0 on 𝔳.
PROOF. (1) Fubini for the Gaussian. Φ = (H_λ + L_R*L_R) + D*F_c*F_cD, and the second piece is constant on the fibres {Du = v}. The
fibre Hessian (H_λ + L_R*L_R)|_{ker D} is positive definite: on ker D = T ⊕ τ_f𝔯, (H_λ + L_R*L_R)(t + τξ) = H_λ(t) + |L_Rτξ|² (cross
terms vanish by (h1) and L_Rt = 0), positive by (h2)–(h3). Shifting each fibre to its minimizer,
  ∫_𝔲 e^{−½Φ}du = det(DD*)^{−1/2}∫_𝔳 dv e^{−½(K(v) + |F_cv|²)}·(2π)^{(n−m)/2}det_{ker D}(H_λ + L_R*L_R)^{−1/2},
K(v) := min_{Du=v}(H_λ + L_R*L_R)(u). Hence det Φ = det(DD*)·det_{ker D}(H_λ + L_R*L_R)·det(K + F_c*F_c), and Φ > 0 as soon as
K + F_c*F_c > 0.
(2) K = S_k″(V). Let G be Bałaban's axial gauge function (G ≥ 0, G(U*) = 0, G″(U*) = L_R*L_R in his normalization). The value function
S_k^G(V) := min{(S + G)(U): Q_k(U) = V} equals S_k (S ≥ S_k on the constraint set and G ≥ 0, with equality at the axial representative
U*). At a constrained critical point with positive definite fibre Hessian, the Hessian of the value function is the fibre minimum of
the Lagrangian Hessian (implicit function theorem for the Lagrange system ∇(S + G) = λ∘dQ_k, Q_k = V, differentiated twice); the
multiplier is the same λ because G′(U*) = 0 (U* minimizes G). So S_k″ = (S_k^G)″ = K. With (h4), K + F_c*F_c > 0 (near V = 1 by
continuity from V = 1, where S_k″(1) ≥ 0 has kernel τ_c𝔤_c exactly by (B2)'s ellipticity).
(3) The Faddeev–Popov determinants. In a splitting 𝔤_f = 𝔯 ⊕ 𝔨 (π|_𝔨 an isomorphism onto 𝔤_c), F_fτ_f is block upper-triangular,
[[L_Rτ_f|_𝔯, L_Rτ_f|_𝔨], [0, F_cτ_cπ|_𝔨]] (F_cDτ_f = F_cτ_cπ vanishes on 𝔯), so |det F_fτ_f| = |det L_Rτ_f|_𝔯|·|det F_cτ_c|·|det π|_𝔨|,
the last a constant.
(4) Subtract (3) from ½log of (1): Γ_f^{H_λ,F_f} = [½log det(DD*) + ½log det_{ker D}(H_λ + L_R*L_R) − log|det L_Rτ_f|_𝔯|] + [½log det(S_k″
+ F_c*F_c) − log|det F_cτ_c|] + const = W_k^{(1)} + Γ_c^{F_c} + const. ∎
REMARKS. (i) This is exactly the repair M3R asked for: the residual-gauge zero modes of H_λ are lifted by L_R inside ker D; the coarse
gauge zero modes of S_k″(1) by F_c; the fine directions that move V (block-constant extensions of coarse transformations, outside
ker D) by F_c∘D; and the coarea factor det(DD*) cancels as in M3 (B-i). (ii) It holds at every V where (h1)–(h4) hold, not only to
order ε²: it is the Faddeev–Popov form of "one-loop effective actions compose".

7.2 TO BACKGROUND FEYNMAN GAUGE AND TO S″: EVERY CHANGE IS LINEAR IN THE EQUATIONS OF MOTION.
LEMMA 7.2 (Kallosh–DeWitt in finite dimensions; PROVED). For a smooth family F_t with F_tτ invertible and H + F_t*F_t > 0,
  d/dt Γ^{H,F_t} = −Tr[(F_tτ)^{−1}Ḟ_t(H + F_t*F_t)^{−1}Hτ].
In particular Γ^{H,F} does not depend on F when Hτ = 0.
PROOF. P := (H + F*F)^{−1}. d/dt ½log det(H + F*F) = Tr[PF*Ḟ]. From (H + F*F)τ = Hτ + F*(Fτ): τ = PHτ + PF*(Fτ), so
PF* = (τ − PHτ)(Fτ)^{−1}, and Tr[PF*Ḟ] = Tr[ḞPF*] = Tr[Ḟτ(Fτ)^{−1}] − Tr[ḞPHτ(Fτ)^{−1}]. And d/dt log|det Fτ| = Tr[(Fτ)^{−1}Ḟτ] =
Tr[Ḟτ(Fτ)^{−1}]. Subtract; cyclicity. ∎
Off shell, Hτ is linear in the equations of motion: for H = S″(U), differentiating S(e^{sξ}·U) = S(U) twice gives S″(U)(τξ, w) =
−⟨S′(U), ∂_wτ(ξ)⟩; for H = H_λ, the same for L, whose invariance is exact under R and holds under 𝒢_f up to the coarse action on λ,
so H_λτ_f is linear in λ.
THE THREE REPLACEMENTS. (A) F_f → the fine background Feynman gauge F_f^{BG}(U*) (lattice background-covariant divergence): by Lemma 7.2
along a path of gauge conditions, a change linear in λ. (B) H_λ → S″(U*): ½log det(S″ + F*F) − ½log det(H_λ + F*F) = ½Tr[(H_λ + F*F)^{−1}
⟨λ, Q_k″⟩] + O(|λ|²); the Faddeev–Popov term contains no H. (C) F_c → the coarse background Feynman gauge F_c^{BG}(V): Lemma 7.2 with
H = S_k″(V), whose S_k″τ_c is linear in S_k′(V) = λ. So every correction is C(V) = ⟨λ(V), 𝒯(V)⟩ + O(|λ|²) with λ(V) = S_k′(V) and 𝒯(V) a
coarse vector analytic in V near 1.
LEMMA 7.3 (EOM-LINEAR CORRECTIONS ARE o(P²); PROVED GIVEN (r1)–(r2)). Let V_ε = exp(iεa), a a transverse coarse plane wave of momentum
P, |a| = 1. Then the ε² coefficient of C(V_ε) is o(P²) as P → 0, at fixed k.
 (r1) Global covariance: 𝒯(g·V) = Ad*_g𝒯(V) under global rotations g and W(B₄) (all the gauge conditions used are globally covariant).
 (r2) Continuity: the one-loop response 𝒯₁[a] := ∂_ε𝒯(V_ε)|_{ε=0}, paired with a plane wave of momentum P, is continuous in P at P = 0
      (each response is a lattice loop integral with at most one massless propagator per vertex factor of degree ≥ 1; in four
      dimensions the integrand is dominated by C(1 + |q|^{−2}) uniformly for small P, so dominated convergence applies).
PROOF. λ(V_ε) = εS_k″(1)a + O(ε²) = εΔ_k(P)a + O(ε²), and Δ_k(P)a = O(P²) for transverse a ((B2): Δ_k(P) = (P²δ − PP)(1 + O(P²))).
The ε² coefficient of C is ⟨λ₂, 𝒯(1)⟩ + ⟨Δ_k(P)a, 𝒯₁[a]⟩ + O(P⁴). (i) 𝒯(1) is a globally invariant adjoint-valued coarse vector (r1); the
adjoint representation of SU(2) has no invariant vector; so 𝒯(1) = 0. (ii) At P = 0, a is constant, hence pure gauge at first order,
a = d_cω with ω(X) = a·X; V_ε = g_ε·1 + O(ε²), g_ε = e^{iεω}; 𝒯(g_ε·1) = Ad*_{g_ε}𝒯(1) = 0; so 𝒯₁[a]|_{P=0} = 0, and by (r2) 𝒯₁[a_P] → 0 as
P → 0. The second term is P²·o(1). ∎
COROLLARY 7.4 (THE STAGE IDENTITY IN BACKGROUND FEYNMAN GAUGE, AT ORDER P²; PROVED GIVEN (r1)–(r2), (B2)). With Γ_f^{BG} the background
Feynman-gauge one-loop action of the fine Wilson action at U*(V) and Γ_c^{BG} that of S_k at V,
  Π_{W_k}(P) = Π_f^{BG}(P; U*) − Π_{S_k}(P) + o(P²),
Π the ε² coefficients at V_ε. M3's kill-switch K2 (the stage identity failing at one loop for the composition) is not met.

## 8. THE ALIAS ITEM (M3R item 2c (5)): IT DOES NOT ENTER f(k)

8.1 The fine polarization at U*(V_ε): U*(V_ε) = exp(iεH_ka + O(ε²)), H_k the linearized minimizer at the trivial background (CMP 95's
operator); Γ_f^{BG}′(1) = 0 (a globally invariant adjoint-valued vector, zero), so the ε² coefficient of Γ_f^{BG}(U*(V_ε)) is
½⟨H_ka, Π_fH_ka⟩ = ½Σ_l Ĥ_k(P,l)a·Π_f(p_l)Ĥ_k(P,l)a, p_l := (P + 2πl)L^{−k} (fine momenta, l ∈ (ℤ/L^kℤ)⁴): H_k commutes with the
coarse translations, so it maps a coarse plane wave to a fine field supported on the aliases of P.
8.2 LEMMA (THE ALIASED CURL IS O(P²); PROVED GIVEN CMP 95's representation of H_k and (B2)). For l ≠ 0 and transverse a, Ĥ_k(P,l)a = O(P²)
at fixed k.
PROOF. In a fine gauge with invertible form 𝔇 (the linearized Wilson form plus a gauge fixing; the curl does not depend on the gauge),
H_ka = 𝔇^{−1}Q*λ_a with λ_a := (Q𝔇^{−1}Q*)^{−1}a = Δ_ka, the blocked quadratic form applied to a — the Lagrange multiplier of the linear
problem. For transverse a, Δ_k(P)a = O(P²) ((B2)). In Fourier, Ĥ_k(P,l)a = 𝔇̂(p_l)^{−1}Q̂(p_l)*·Δ_k(P)a; for l ≠ 0, p_l stays away from 0 as
P → 0, so 𝔇̂(p_l)^{−1} and Q̂(p_l) are bounded and Ĥ_k(P,l)a = O(P²). (For l = 0, 𝔇̂(p_0)^{−1} ~ L^{2k}/P² compensates and Ĥ_k(P,0)a =
a + O(P²): the smooth interpolant.) ∎ (This is M3's "aliased curl O(εP²)" with its proof.)
8.3 CONSEQUENCE (PROVED). The alias terms contribute Σ_{l≠0}O(P²)·Π_f(p_l)·O(P²) = O(P⁴) at fixed k (finitely many l; Π_f(p_l) finite,
p_l ≠ 0), hence NOTHING to β(Q^k), which is the second moment of an exponentially decaying kernel (CMP 109 (1.20)–(1.22)) — the P → 0
limit at FIXED k. With 7.4 and the l = 0 term [8b₀ ln(L^k/|P|) + c_W]P² + o(P²) (the fine one-loop polarization at fine momentum PL^{−k},
four-dimensional scaling), β(Q^k) = 8b₀k ln L + c_W − c(S_k): f(k) = c_W − c(S_k) EXACTLY, c(S) := lim_{P→0}[Π_S^T(P)/P² − 8b₀ln(1/|P|)]
(existence: §9). M3R asked for the alias constants "carried into (B1)'s uniform bound": they are not needed, because f(k) is a limit
at fixed k in which the alias terms vanish for each k; the k-uniform bound on f is (B1) + (B2) alone. M3's kill-switch K3 is not met.

## 9. (B1) — THE INFRARED IDENTIFICATION, LINE BY LINE

9.1 THE CLASS 𝒮(γ₀, κ, M) (M3 §5.3; Addendum II §7): gauge-invariant lattice actions S on ℤ⁴ with S ≥ 0 = S(1); Taylor kernels in
exponential coordinates at 1, K_n^S(p₁, …, p_n), analytic in the strip |Im p| < κ with |K_n^S| ≤ M^n; transverse ellipticity
Δ_S(p) ≥ γ₀p̂² on transverse modes; invariance under translations and W(B₄); normalization Δ_S(p) = (p²δ − pp)(1 + O(p²)).
9.2 LEMMA WI (THE LEADING PARTS OF THE VERTICES ARE WILSON'S; PROVED — the lattice Ward identities, W = 0 in substance). For S ∈ 𝒮:
K₂^S − K₂^W = O(|p|⁴), K₃^S − K₃^W = O(|p|³), K₄^S − K₄^W = O(|p|²) at small momenta, the constants depending on (κ, M).
PROOF. Gauge invariance gives Ward identities expressing the contraction of K_{n+1} with one momentum through K_n. Expand each K_n at small
momenta into homogeneous parts (analyticity in the strip gives Taylor expansions with remainders bounded by the class constants). The
lowest parts K₂^{(2)}, K₃^{(1)}, K₄^{(0)} (dimension four) obey the continuum Ward identities, whose solutions are the quadratic, cubic and
quartic parts of c₁trF² + c₂trF∧F. Normalization fixes c₁ to Wilson's; the reflections kill c₂; a dimension-four invariant with vanishing
quadratic part is zero, so no homogeneous solution can be added to the cubic or quartic parts. The odd (dimension-five) parts vanish by
the inversion x ↦ −x ∈ W(B₄). So the lowest parts of K₃, K₄ are Wilson's, and the next parts are two degrees higher. ∎
9.3 THEOREM B1 (PROVED GIVEN Lemma WI and Wilson's one-loop polarization, W = 0). For S ∈ 𝒮(γ₀, κ, M), c(S) exists and
|c(S) − c_W| ≤ C(γ₀, κ, M) := sup over the class of ∫_{[−π,π]⁴}C(1 + |q|^{−2})d⁴q/(2π)⁴.
PROOF. (1) Background Feynman gauge: Γ_S^{BG}(V) = ½Tr log M_S(V) − Tr log(F_Vτ_V), M_S(V) := S″(V) + F_V*F_V; the gauge-fixing term
and the ghost operator are built from the background alone and the Haar density in exponential coordinates is universal, so
Γ_S − Γ_W = ½Tr log M_S − ½Tr log M_W. (2) The ε² coefficient at V_ε: δΠ(P) = ∫d⁴q/(2π)⁴ δ𝒩(q, P), δ𝒩 := 𝒩_S − 𝒩_W,
𝒩_X(q, P) = tr[G_X(q)V₄^X(q; P)] − ½tr[G_X(q)V₃^X(q, q+P)G_X(q+P)V₃^X(q+P, q)], G_X := M_X(1)^{−1} (Feynman propagator), V₃, V₄ the first
and second background derivatives of M_X (built from K₃^X, K₄^X and the S-independent gauge-fixing vertices). (3) THE DIFFERENCE FACTORS:
G_S − G_W = G_S(K₂^W − K₂^S)G_W with K₂^W − K₂^S = O(|q|⁴) and G_S, G_W ≤ (min(γ₀, 1)q̂²)^{−1}, so |G_S − G_W| ≤ C, |∂(G_S − G_W)| ≤ C|q|^{−1},
|∂²(G_S − G_W)| ≤ C|q|^{−2}; V₃^S − V₃^W = O((|q| + |P|)³), V₄^S − V₄^W = O((|q| + |P|)²). Telescoping, every term of δ𝒩 carries at least
one difference factor. (4) THE P² COEFFICIENT IS AN ABSOLUTELY CONVERGENT INTEGRAL. For fixed q ≠ 0, δ𝒩(q, ·) is smooth near P = 0; let
c₂(q) be its P² coefficient. Power counting with (3) (Wilson factors G ~ q^{−2}, V₃ ~ q, V₄ ~ 1; a difference factor two degrees higher):
|c₂(q)| ≤ C(1 + |q|^{−2}), integrable in four dimensions. δΠ(0) = 0 (gauge invariance: no mass term) and ∂δΠ(0) = 0 (W(B₄)). (5) THE
REMAINDER IS o(P²). Split at |q| = 2|P|. For |q| ≥ 2|P| the third-order Taylor remainder of δ𝒩(q, ·) is ≤ C|P|³|q|^{−3}, and
∫_{2|P|≤|q|≤π}|P|³|q|^{−3}d⁴q = O(|P|³). For |q| < 2|P|, |δ𝒩(q, P)| ≤ C(1 + |P|²|q + P|^{−2}) (at most one singular propagator, multiplied by
a difference factor and vertex factors of size |P|) and |c₂(q)|P² ≤ CP²(1 + |q|^{−2}); both integrate over |q| < 2|P| to O(|P|⁴). So
δΠ(P) = [∫c₂(q)d⁴q/(2π)⁴]P² + o(P²) (transverse projection understood). (6) Π_W^T(P) = [8b₀ln(1/|P|) + c_W]P² + o(P²) (the classical
one-loop lattice computation). Hence Π_S^T = Π_W^T + δΠ^T has the stated form, c(S) = c_W + ∫c₂^T, and |c(S) − c_W| ≤ C(γ₀, κ, M). ∎
WHAT CHANGED FROM THE RECORD'S PROOF. Addendum II §7 split the loop momentum at k₀ and identified the infrared half with the CONTINUUM
integrand. Here S is compared with WILSON'S LATTICE integrand directly: the difference integrand has its infrared singularity removed
by the difference factor, so no continuum integrand, no momentum split and no k₀ are needed; c_W enters as one known number.
9.4 LEMMA B, ASSEMBLED (PROVED GIVEN (r1)–(r2), (B2)'s strip analyticity, and the classical inputs W = 0). f(k) = c_W − c(S_k) (§8.3);
S_k ∈ 𝒮(1, κ, M) for every k ((B2): ellipticity γ₀ = 1 and normalization proved in Addendum II §8; symmetry by CMP 109's centred averaging,
L odd, M3b §15.1 READ; strip analyticity k-uniformly from CMP 102 Thm 1, Prop. 9 and (190) — M3e: PROVED GIVEN CMP 99 (3.132)); so
|f(k)| ≤ F := C(1, κ, M) for every k. M3R's five conditional items: (1) gauge-fixed (B-i) — PROVED (Theorem 7.1, Corollary 7.4); (2) (B1) —
PROVED (Theorem B1); (3) CMP 102 (190) — M3e's object, unchanged here; (4) the block factor — settled by M3b §15.1 (L odd, centred, READ);
(5) the alias constants — NOT NEEDED (§8.3).

## 10. LEMMA D — CONTINUITY ALONG TRAJECTORIES (M3R item 2e)

10.1 THE OWN STEP AT x′ IS THE REFERENCE STEP WITH TWO DEVIATIONS, EXACTLY (PROVED from CMP 109 pp. 265–268 as READ by M3c and M3cR).
At step k + 1 with current coupling x′ near the reference x, CMP 109's integrand carries the coupling in exactly two places: the Wilson
action −x′A(U_k(V′V^{(k)})) and the gauge-fixing term −x′G(B′) ((2.1); M3cR (5): "the gauge-fixing weight IS the Wilson coefficient
1/g_k²"). The cutoff χ_k = Πχ(|B′(b)| < ε₁) is on the physical angle (CMP 109 (2.9)) and the background minimizes the unweighted action:
both coupling-independent (M3c §9.3, M3cR (8)). So, with d := (x′ − x)/x, the own step at x′ is the reference step at x with the extra
interaction −d·W − d·𝒢, W = 𝒲 + W_{≥3} the Wilson part (M3c §5.1) and 𝒢 := (1/g_k²)G(B′) = ½G^{(2)}(CB) + 𝒢_{≥3}, EXACTLY.
10.2 LEMMA (𝒢 IS IN THE CONE; PROVED). G^{(2)}(B′) = Σ_yΣ_{x∈B(y),x≠y}|B̃′(y,x)|² (CMP 109 (2.5)) is block-local with O(1) coefficients:
G^{(2)} = Σ_y ½⟨𝒢(Y_y)B, B⟩, |𝒢(Y_y)(b, b′)| ≤ C_G, zero unless b, b′ lie in the closure of one block; so ½G^{(2)}∘C ∈ 𝒱(C_G) (M3c (M.1) with
d_k(Y_y) = 0, |Y_y| ≤ (L + 1)⁴). The cubic remainder 𝒢_{≥3} is one of Bałaban's P^{(k)} terms (CMP 109 (2.12) lists G₃), in 𝒱(E₀C₁ε₁). ∎
10.3 LEMMA D (PROVED GIVEN Lemma M, Lemma W, the one-step (PI)_H — all M3c). (a) For a fixed history E in the class, x′ ↦ β_{k+1}(x′; E)
and x′ ↦ E^{(k+1)}(X; x′, E) are ANALYTIC on |x′ − x| < θ_Gx, θ_G := ε_*/(2(C_W + C_G + 2ε_*)), with Lemma M's bounds uniformly.
(b) For fixed x′, E ↦ (β_{k+1}, E^{(k+1)}) is Lipschitz in ‖E‖ = sup_X e^{κd(X)}sup|E_X| (M3c 7.4), uniformly in x′ on the disc.
(c) Hence (x′, E) ↦ (β_{k+1}, E_{k+1}) is jointly continuous into ℝ × 𝔈, and by induction on k, x₀ ↦ (x_k, E_k) is continuous on D_k and
x₀ ↦ b_{k+1}(x₀) = β_{k+1}(x_k(x₀); E_k(x₀)) is continuous on D_{k+1}: hypothesis (H1) of Lemma A′.
PROOF. (a) By 10.1 the own step at x′ is the reference step with the potential V_k − d(W + 𝒢) ∈ 𝒱(E₀C₁ε₁ + |d|(C_W + C_G + 2E₀C₁ε₁)) ⊂ 𝒱(ε_*)
for |d| < θ_G (cone property; Lemma W; 10.2); Lemma M (d) with p = d gives analyticity on the disc with uniform bounds; β_{k+1} = M[·] is a
bounded linear functional of the localized output (M3 §5.5 (c), M3c §3 (a)). (b) M3c 7.4. (c) Cauchy on the disc: |∂_{x′}E^{(k+1)}(X)| ≤
2M_X/(θ_Gx) uniformly in X — Lipschitz in x′ in the weighted norm; with (b), joint continuity; composition. ∎
10.4 IN THE COMPLETE MODEL. The coupling of record is CMP 109's small-field β (M3 §11.1, M3b §2): 10.3 is Lemma D for the sequence of
record. The complete model's thresholds ε_j = g_jp₀(g_j) enter only through Lemma P3's shell, continuous in g_j by dominated convergence
(the moving cutoff boundary is a null set, M3 §5.5 (a)) and smaller than every power of g. M3R's condition ("coupling-uniform convergence
in the localized norm") is exactly Lemma M's uniform bounds on the disc of 10.3 (a).
10.5 WHAT 10.1 ALSO GIVES (PROVED). Carrying the gauge-fixing deviation removes the shell from Lemma C′ (d): the own construction at x′ IS
the reference construction with deviations (d, d), whose pure quadratic part d·(𝒲 + ½G^{(2)}) is d times the WHOLE Gaussian form on
E = ker Q̃ (CMP 109 (2.11)); its log-determinant −½dim E·log(1 + d) is background-independent trivially, so M[·] of it vanishes without Lemma
FP and without Lemma SH; the cutoff correction is M3c 7.3 (b1)'s Gaussian tail. Hence |β_{k+1}(x′) − β_{k+1}(x)| ≤ (2g_k²/θ_G)[C₁e^{−c₁ε₁²/g_k²}
+ C(g_k² + ε₁g_k)]|x′ − x| for real x′ in the disc, with no additive shell term. Lemma SH stays needed only where the gauge-fixing weight is
frozen at the reference by design (Theorem PI-4's device for complex D). In E1-a (M3d §4.3) the shells t_j then come from Lemma P3 alone.

## 11. STATUS OF THE ITEMS ASSIGNED

| Item | Status | Where |
|---|---|---|
| R preserves integrals and (termwise) the marginal outside Λ, NOT the density; ρ_K is not the blocked law | PROVED from LFR I (0.3)–(0.6), LFR II (1.1) (READ) | §2, 4.5 (a) |
| M3 §7 (E0)'s non-degeneracy argument | WITHDRAWN as stated (it read (2.50) as a bound on the blocked law) | §2.4 (c) |
| the form of E1: generating functionals (sources), not effective densities | PROVED (consequence of 2.3) | §2.4 (d) |
| R_D linear in the density at fixed coupling field; analytic in the field | PROVED | §2.2 |
| Lemma RL (R_D and the whole step Lipschitz in the input data, constant 2c_ROB) | PROVED GIVEN (ROB) | §3.3 |
| the weight (W) for E-, R-, B-terms | PROVED GIVEN [BB-c] | §3.4 |
| Theorem U (comparison inside one class; tuning backward from δ_K = 0; rate (K − k₀ + 1)q^{K−k₀} for the E-history, R-terms marginal and e^{−p₀}-small) | PROVED GIVEN [BB-a]–[BB-c], Lemma M_c, PI-4, PI-5, (ROB), (W), (B-SUP) | §4, 4.5 (b) |
| Corollary 5.1: universality of the bare action inside the class, for the 0⁺⁺ generating functional, with τ-derivatives (Vitali) | PROVED GIVEN the same | §5 |
| the two-cutoff obstruction: the rigid tree-level leading part | LOCATED (PROVED that Theorem U does not apply as it stands) | §6.1 |
| Lemma 6.2, the variational sandwich for the tree-level two-cutoff difference | PROVED | §6.2 |
| the tree-level contraction L^{−2j}, uniformly in m | PROVED GIVEN (Δ-i), (Δ-ii) (CMP 102-type regularity; (190)) | §6.3 |
| (T_loc) localized analytic tree-level bound; (CB) change of background | OPEN (route and falsifier named) | §6.4–6.5 |
| E1 for two cutoffs, rate polynomial in 1/log ε^{−1} (any power) | PROVED GIVEN Theorem U's inputs, (B-SUP), (Δ-i), (Δ-ii), (T_loc), (CB) | §6.6 |
| Lemma B (B-i) gauge-fixed: exact Gaussian identity in the adapted gauge F_f = (L_R, F_c∘D) | PROVED | §7.1 |
| Kallosh–DeWitt in finite dimensions; the three replacements o(P²) | PROVED (Lemma 7.2); PROVED GIVEN (r1)–(r2) (Lemma 7.3) | §7.2 |
| alias terms: O(P⁴) at fixed k; f(k) = c_W − c(S_k) exactly; alias constants not needed | PROVED (given CMP 95's H_k and (B2)) | §8 |
| Lemma WI (leading vertices are Wilson's) | PROVED (Ward identities, W = 0) | §9.2 |
| Theorem B1 (|c(S) − c_W| ≤ C(γ₀, κ, M), a convergent difference integral) | PROVED GIVEN Lemma WI and Wilson's one-loop polarization (W = 0) | §9.3 |
| Lemma B | PROVED GIVEN (r1)–(r2), (B2)'s strip analyticity [(190), M3e] and W = 0 inputs | §9.4 |
| Lemma D (analytic in the current coupling, Lipschitz in the history, continuous along trajectories) | PROVED GIVEN Lemma M, Lemma W, one-step (PI)_H | §10.3–10.4 |
| Lemma C′ (d) without a shell, when the gauge-fixing deviation is carried | PROVED | §10.5 |

## 12. THE PRECISE NEXT OBJECT

(T_loc): the localized analytic tree-level two-cutoff bound — x′[S′_{m+j} − S_j] = Σ_X δS(X) with |δS(X)| ≤ C_Tx′L^{−2θj}α²e^{−κd_j(X)} on
Bałaban's complex domain, uniformly in m. Its first instance is quadratic: the k-step blocked Wilson form from T_{ε′} against the one from
T_ε, Δ′_{m+j} − Δ_j = 𝔅_j(Δ′_m) − 𝔅_j(Δ_W) with 𝔅_j(M) := (Q_jM^{−1}Q_j*)^{−1}, which equals 𝔅_j(Δ′_m)Q_j(Δ_W^{−1} − Δ′_m^{−1})Q_j*𝔅_j(Δ_W): the
middle factor is a BOUNDED local kernel on T_ε (the two propagators agree to O(1) at small momentum by Lemma WI), and Q_j(local)Q_j* carries
L^{−2j} by four-dimensional scaling — with CMP 95's exponential decay of 𝔅_j, this is (T_loc) at the quadratic level. The nonlinear level by
the sandwich (6.2), Möbius localization and Hadamard's two-constants theorem (6.4). It is the last object between Theorem U and E1 for two
cutoffs; with (CB) it gives the convergence of the 0⁺⁺ generating functional on the torus.

## 13. CROSS-FIELD UNIFICATIONS FOUND

(U1) THE TREE-LEVEL CONTRACTION IS THE CLASSICALLY PERFECT ACTION. The limit S_∞ = lim S_k of Bałaban's minimizer actions is the fixed point of
the CLASSICAL renormalization group of his averaging — the "classically perfect action" of Hasenfratz–Niedermayer (1994), which they define by
exactly this saddle-point recursion S_{k+1}(V) = min_{Q(U)=V}S_k(U) — and Lemma 6.2's sandwich is a one-line proof that the recursion
contracts the irrelevant directions at the rate L^{−2j}: the two-cutoff tree-level difference is squeezed between an irrelevant functional
evaluated on two smooth interpolants. Two cutoffs differ at tree level exactly by how far each is from the perfect action.
(U2) R IS A CONDITIONAL RESAMPLING THAT PRESERVES THE PARTITION FUNCTION — IMPORTANCE SAMPLING'S NORMALIZATION. Bałaban's R replaces the
conditional law of the variables in a large-field region by the normalized small-field law and keeps the outside marginal: the structure of a
Gibbs-sampler move whose target is not the original measure, or of an importance-sampling change of measure with its normalizing constant
carried exactly. It is exact for integrals (free energies, generating functionals) and not for observables, which is why every observable
must ride in as a source — the same lesson as Osborn's local renormalization group (M3b U1): couplings are sources.
(U3) THE STAGE IDENTITY IS THE BATALIN–VILKOVISKY / FADDEEV–POPOV FACTORIZATION OF A FIBRED GAUGE THEORY. Theorem 7.1 is the Gaussian case of
the factorization of a gauge-fixed path integral over a principal bundle along a fibration (the fine gauge group fibred over the coarse one
with fibre R): the adapted gauge F_f = (L_R, F_c∘D) is block-triangular in the extension 1 → R → 𝒢_f → 𝒢_c → 1, so the Faddeev–Popov
determinant factorizes exactly as the group does. Lemma 7.2 is the finite-dimensional Kallosh–DeWitt theorem (off-shell gauge dependence
proportional to the equations of motion) — the same structure M3c (U2) met in Lemma FP, now used to move between gauges at order P².
(U4) (B1) IS RENORMALIZATION-SCHEME CONVERSION AT ONE LOOP. c(S) − c_W = 8b₀ln(Λ_S/Λ_W) is the one-loop Λ-parameter ratio between two lattice
schemes (Hasenfratz–Hasenfratz; Dashen–Gross); Theorem B1 says it is an absolutely convergent lattice integral because the two schemes share
their infrared — the Λ-ratio is a purely ultraviolet quantity, bounded by the class constants. M3 (U4) read the transient as a Λ-ratio; here
the bound on it is the infrared universality of the one-loop integrand.

## 14. DATED CORRECTIONS AND PRECISIONS (2026-11-02, after §§0–13, from an adversarial pass; nothing above edited)

14.1 TO §8.2 (the alias lemma's proof). "In a fine gauge with invertible form 𝔇 … the curl does not depend on the gauge" is wrong as
written: a Feynman-gauge-fixed constrained minimization has a different minimizer (the gauge term enters the optimization, and only
R-transformations preserve QA = a). THE CORRECT PROOF uses Bałaban's problem itself: A* minimizes ⟨A, d*dA⟩ on {QA = a} in the R-axial
slice; the slice multiplier vanishes (objective and constraint are R-invariant, and ⟨Q*λ, dω⟩ = ⟨λ, d_c(ω|_coarse)⟩ = 0 for ω ∈ Lie R), so
the Euler–Lagrange equation is d*dA* = Q*λ, λ = Δ_ka (the multiplier is the gradient of the value function ⟨a, Δ_ka⟩). At an alias
p_l ≠ 0, d*d is invertible on transverse modes, so the transverse part of Â*(p_l) is (p̂_l²)^{−1}·(transverse part of Q̂(p_l)*λ̂(P)) =
O(|Δ_k(P)a|) = O(P²). The conclusion of §8.2–8.3 stands.

14.2 TO LEMMA 7.3. (r1) must be LOCAL covariance: 𝒯(g·V) = g·𝒯(V) for coarse gauge transformations g (acting on the coarse vector by the
adjoint action), which holds because every object entering 𝒯 — the minimizer U*(V) (covariant up to the fine extension that keeps the
axial representative), H_λ, Q_k″, and the gauge conditions (background-covariant F^{BG}; the adapted F_f with the axial L_R transported by
that extension) — is gauge covariant. Global covariance alone would allow 𝒯₁[const a] = c·a and a P² contribution; the pure-gauge step (ii)
of the proof uses the local form, as M3R's original sentence did ("a constant coarse field is pure gauge at first order").

14.3 TO §7.1 (h4) ON THE TORUS. Constant coarse (and fine) fields are zero modes of d that are not gauge directions; D maps the fine
zero-momentum sector onto the coarse one. Either restrict 𝔲, 𝔳 to the complements of the zero-momentum sectors (Theorem 7.1 holds there
verbatim, and the polarization at P ≠ 0 is unaffected), or work in infinite volume, where Bałaban's M (I.1.22) is defined.

14.4 TO THEOREM B1 STEP (5). The small-q bound should read |δ𝒩(q, P)| ≤ C(1 + |P|²|q|^{−2} + |P|²|q + P|^{−2}) for |q| < 2|P| (a vertex
difference beside two singular propagators gives P²|q|^{−2} near q = 0); its integral over |q| < 2|P| is still O(|P|⁴). The c₀ and c₁
Taylor terms over |q| ≥ 2|P| are handled by δΠ(0) = 0 (c₀ bounded, the complement contributes O(P⁴)) and by the q ↦ −q symmetry (c₁).

14.5 TO §6.3 (Δ-ii). For box-type contour averages the alias amplitudes of the minimizer decay like Π_ν(1 + |l_ν|)^{−1}/|l|² (from 14.1:
Â*(p_l) = (p̂_l²)^{−1}Q̂(p_l)*λ̂), so the fine-scale gradient of the curvature carries at most a logarithm, |∇F_W| ≤ Cj·L^{−3j}|F_c|; the
tree-level rate is then L^{−2j}j^c. Nothing downstream changes (j_* moves by O(log log K)).

14.6 TO THEOREM U (i), COROLLARY 5.1 AND M3d's PROPOSITION E1-a: THE SHELLS ARE LIPSCHITZ, AND THE BARE COUPLING IS UNIQUE.
(a) The gauge-weight shell is absent when the gauge-fixing deviation is carried (§10.5). (b) Lemma P3's shell between the complete model's
thresholds at two couplings x′, x is the set of configurations between ε_j(x′) and ε_j(x) (ε_j = g_jp₀(g_j), a smooth function of the
coupling); its Gaussian mass is ≤ C|ε_j(x′) − ε_j(x)|·(the density at the threshold) ≤ w^{sh}_j|x′ − x|, w^{sh}_j := Cg_j³p₀′(g_j)·
e^{−cp₀(g_j)²}/x_j — PROPORTIONAL to the coupling difference, not additive (two equal couplings give no shell). So the additive t_j of M3d
§4.3 and of Theorem U (C) is replaced by w^{sh}_jδ_j, absorbed into w_j (Σ_jw^{sh}_j ≤ Ce^{−c(log γ^{−2})^{2p₀}}), and the Σt_j terms of
Theorem U (iii), Corollary 5.1 and §6.6 are DELETED. Without this, Corollary 5.1's bound would keep a fixed small number and would not
tend to 0; with it, it does.
(c) PROPOSITION E1-a SHARPENED (PROVED GIVEN M3d's inputs for E1-a with (a)–(b) in place of Lemma SH and the additive P3 tail): with every
step Lipschitz in the coupling (Lemma C′ (c), §10.5, (b)) and in the history (Theorem PI-5), Gronwall gives |D_K| ≥ |D₀|(1 − Cγ^ae^{Cγ^a})
for two bare couplings of one cutoff; D_K = 0 forces D₀ = 0. THE BARE COUPLING g₀(ε, g) OF THEOREM 2 IS UNIQUE, and x₀ ↦ x_K is strictly
increasing — not only "unique up to the shell" (M3d §4.3 had δ_bare > 0 from the additive tails).

14.7 THE STATUS ROWS THAT MOVE.
| Item | Status | Where |
|---|---|---|
| §8.2's proof | CORRECTED (Euler–Lagrange d*dA* = Q*λ); conclusion unchanged | 14.1 |
| Lemma 7.3 | PROVED GIVEN LOCAL covariance (r1) and (r2) | 14.2 |
| Theorem 7.1 on the torus | PROVED on the complements of the zero-momentum sectors | 14.3 |
| shells in Theorem U, Corollary 5.1, §6.6 | Lipschitz, absorbed into w_j; the additive Σt_j deleted | 14.6 (b) |
| Proposition E1-a | SHARPENED: the bare coupling is unique (PROVED GIVEN M3d's inputs, with 14.6 (a)–(b)) | 14.6 (c) |

## 15. STAKE (written before `bin/m3f_tree.py` exists; not edited after the run)

S-T1 (the tree-level two-cutoff contraction of §6.3 at the Gaussian level, in its scalar analogue — a CHECK, not an input of any proof).
Free scalar field on ℤ⁴ (action ½Σ|∇φ|², symbol p̂² = Σ_μ4sin²(p_μ/2)), centred box averages of side L^k, L = 3, the coarse field
rescaled by L^k (dimension one in d = 4). The blocked covariance in coarse units is G_k(P) = L^{−2k}Σ_{l∈(ℤ/L^k)⁴}Q̂_k(p_l)²/p̂²(p_l),
p_l = (P + 2πl)/L^k, Q̂_k = Π_μ sin(L^kp_μ/2)/(L^k sin(p_μ/2)); its limit G_∞(P) = Σ_{n∈ℤ⁴}Π_μφ(P_μ + 2πn_μ)²/|P + 2πn|², φ(q) = sin(q/2)/(q/2);
the blocked kernels K_k := 1/G_k, K_∞ := 1/G_∞. Box averages compose, so K_{m+k} is the k-step blocking of the m-step blocked action — the
two-cutoff difference K_{m+k} − K_k is controlled by R_k := (K_k − K_∞)/K_∞. Computed by the heat-kernel factorization G = ∫₀^∞ds
Π_μ(1D alias sums) (each 1D sum exact; the s-integral by the trapezoid rule in u = log s, double-exponentially convergent).
STAKE: at P ∈ {(π/2,0,0,0), (π/4,π/4,0,0), (1, 0.6, 0.3, 0.1)} and k = 1, …, 6: the ratios R_k/R_{k+1} lie in [8, 10] for k ≥ 2 (approaching
L² = 9: the L^{−2k} rate of §6.3), |R_k|·L^{2k} stays bounded uniformly in k (value UNGUESSED); the sign of R_k UNGUESSED. KNOWN ANSWERS the
instrument must meet first: Σ_lQ̂_k(p_l)² = 1 (Parseval on a block) to 1e-12, and G_k → G_∞.

## 16. RESULTS OF S-T1 (record `rec/tree_run.2026-11-02a.txt`, rc = 0, SHA-256 prefix 01f72e45f0432948; script `bin/m3f_tree.py`,
5c879ca6a64ac48c; double precision — COMPUTED, a check). One mistaken edit to §15 after the run, recorded here: in its sentence "Box
averages compose, so K_{m+k} is the k-step blocking of the m-step blocked action: the two-cutoff difference …" the colon was replaced by a
dash; no word changed.

KNOWN ANSWERS MET. Parseval Σ_lQ̂_k(p_l)² − 1: worst 1.4e-13 (k ≤ 6). The raw truncated Σ_nφ(q + 2πn)² − 1 at N = 4000 is 5.0e-5 (as
expected; the integrand carries the analytic tail). AN EXACT CLOSED FORM MET TO 12 DIGITS: on an axis, P = (q, 0, 0, 0), the factorization
leaves one direction and the sums are csc⁴-sums; from Σ_{l<N}csc²(x + πl/N) = N²csc²(Nx), differentiated twice,
Σ_{l<N}csc⁴(x + πl/N) = N⁴csc⁴(Nx) − (2/3)N²(N² − 1)csc²(Nx), so (PROVED)
  G_k(q,0,0,0) = ¼[csc²(q/2) − (2/3)(1 − L^{−2k})],   G_∞(q,0,0,0) = ¼[csc²(q/2) − 2/3],   G_k − G_∞ = L^{−2k}/6 EXACTLY.
At q = π/2: G_∞ = 1/3 (read 0.333333333333), G₁ = 19/54 (read 0.351851851852), G₂ = 163/486 (read 0.335390946502).

THE STAKE HELD, EVERY ENTRY.
| P | R₁ | R₂ | R₃ | R₄ | R₅ | R₆ | R_k·L^{2k} at k = 6 | R_{k−1}/R_k, k = 2…6 |
|---|---|---|---|---|---|---|---|---|
| (π/2,0,0,0) | −5.263e−2 | −6.135e−3 | −6.854e−4 | −7.620e−5 | −8.467e−6 | −9.408e−7 | −0.5000 | 8.58, 8.95, 8.995, 8.9994, 8.9999 |
| (π/4,π/4,0,0) | −1.900e−2 | −2.164e−3 | −2.411e−4 | −2.680e−5 | −2.978e−6 | −3.309e−7 | −0.1758 | 8.78, 8.97, 8.997, 8.9996, 9.0000 |
| (1,0.6,0.3,0.1) | −2.332e−2 | −2.669e−3 | −2.976e−4 | −3.308e−5 | −3.675e−6 | −4.084e−7 | −0.2170 | 8.74, 8.97, 8.996, 8.9996, 8.9999 |
The ratios approach L² = 9 from below and lie in [8, 10] from k = 2 on; |R_k|L^{2k} converges (to −½ exactly on the axis, by the closed form,
since R_k = −(L^{−2k}/6)/G_k and G_∞ = 1/3). UNGUESSED, now read: the sign is NEGATIVE — the finite-k blocked kernel lies below its limit.
WHAT IT SAYS. At the Gaussian level the two-cutoff difference of blocked actions contracts at exactly the tree-level rate L^{−2k} of §6.3,
uniformly in the finer cutoff (K_{m+k} − K_k = (R_{m+k} − R_k)K_∞(1 + O(L^{−2k}))); on an axis the difference of the blocked PROPAGATORS is a
pure CONTACT TERM, the constant L^{−2k}/6 in momentum space — the cutoff dependence of the tree-level blocked theory is ultralocal there,
exactly. This is the scalar analogue; the gauge-field instance (Bałaban's contour averages, the transverse sector) is §12's first object.

## 17. FINAL LEDGER ROWS ADDED (2026-11-02; §11 and 14.7 stand)

| Item | Status | Where |
|---|---|---|
| S-T1: Gaussian tree-level two-cutoff contraction, scalar analogue, ratios → L² = 9 | COMPUTED (check), stake HELD | §15–16 |
| G_k(q,0,0,0) = ¼[csc²(q/2) − (2/3)(1 − L^{−2k})]: the axial two-cutoff difference is the contact term L^{−2k}/6 | PROVED (csc⁴ identity), met by the run to 12 digits | §16 |
| Corollary 5.1 precision: an O(1) bare term's dimension-four part is a coupling difference, tuned (δ_{k₀} by the backward condition δ_K = 0); only its irrelevant remainder is the E-row H_{k₀} | PRECISION | §5, §4.3 (i) |

THE ORDER OF WHAT IS LEFT FOR E1 IN FULL: (T_loc) at the quadratic level for Bałaban's contour averages (CMP 95's 𝔅_j, §12) → (T_loc)
nonlinear (sandwich + Möbius + two-constants, §6.4) → (CB) (§6.5) → the named inputs (ROB), (W), (B-SUP) read line by line against LFR II
(1.71)–(1.102) and CMP 119 §3 — after which §6.6 gives the convergence of the 0⁺⁺ generating functional on the torus with every τ-derivative.
