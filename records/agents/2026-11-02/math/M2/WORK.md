# M2 — THE CROSSOVER ON ℤ⁴, IN L²: THE REDUCTION WITH AVERAGED HYPOTHESES, THE REFUSAL OF U(1), AND THE CURRENCY READ ON THE EXACT OBJECTS

Proof agent M2, 2026-11-02 (desktop, read-only in both repositories; everything here is in this directory).
Sources read in full before any derivation: THE GROUND §§7–8 (cross/ground_docx.txt lines 201–393: Theorem 7.1, Lemma 7.3,
Theorem 7.4, Propositions 8.1, 8.2, 8.4, Hypotheses I and II, Theorem 8.5 and its proof, the discussion after it); THE CROSSING
CAMPAIGN §§14–17 (the interdependence coefficient C_ω on the two-face object, its decomposition, §15 CORRECTED, §16, §17);
THE FAR SHORE §4.2–§4.4 (walls measured, roads refuted, objects named) and §7 (the synthesis); OPEN/ledger/typical-boundary.md;
the engine w2_strip_n.c (object, staples, order), the dump format (W2-F lines), the readers' records (dob/*.dob.txt), w2_u1.c's options.

## 0. What this file proves, in one paragraph

The gap is an L² quantity (§1, exact). THE GROUND's reduction (Theorem 8.5) consumes a total-variation hypothesis with a supremum
over boundary data and a fibre clause demanded at every coarse configuration. §2 proves an L² Dobrushin theory — a two-site lemma
in which Dobrushin's oscillation is replaced by the L² local fluctuation and his total-variation influence by the conditional maximal
correlation — whose covariance bound has exactly the shape of Föllmer's. §3 uses it to prove THEOREM 8.5-L²: the gap of every limit
point from (I-L²) a weighted row-sum bound on conditional maximal correlations of the blocked measure and (II-L²) fibre clustering
AVERAGED over the blocked measure. (I-L²) is implied by Hypothesis I wherever Hypothesis I's matrix has bounded column sums
(the currency inequality ρ² ≤ C(A|B)C(B|A), §2.5); (II-L²) is implied by Hypothesis II and is the form a small-field expansion
delivers (typical backgrounds, large fields by their probability). §4 proves that every hypothesis of this kind REFUSES U(1)
wherever U(1) is massless, and computes the free field's matrix exactly (ρ(R) = 1: marginal). §5 says where the supremum remains
(the coarse environment in I-L²) and where an average replaces it (the fine fields; the fibre clause), and what the chessboard
must price. §6 is the certificate design, its stakes (written before every run) and its runs on the exact objects, SU(2) at 2.2
beside U(1) at 1.2 and 0.9, planar geometry only. §7 removes the fine-data supremum from the coarse coefficient (Lemma 7.1), proves the
two-site lemma for any two projections (Lemma 7.2) and answers item (4). §8 is what is left, and the cross-field identifications.

---

## 1. THE EXACT IDENTITY: THE GAP IS THE L²(π) NORM OF THE DOOB CHAIN (W = 0), AND ITS MEASURE-WEIGHTED UPPER BOUND

**Setting** (Proposition 8.1's). T a transfer operator on a compact space X with a continuous, strictly positive, SYMMETRIC kernel
T(x,y) = T(y,x) (reflection positivity makes the time-zero transfer matrix of the Wilson action such an operator on the gauge-invariant
sector, Lüscher [7]); λ₀ its largest eigenvalue, ψ₀ > 0 the normalised eigenfunction, π(dx) = ψ₀(x)² dx; the Doob chain
P(x,dy) = T(x,y)ψ₀(y)dy/(λ₀ψ₀(x)).

**Proposition 1.1 (the identity).** (i) P is self-adjoint on L²(π), and Uf = ψ₀f is a unitary L²(π) → L²(dx) with UPU⁻¹ = T/λ₀.
(ii) Hence spec(P) = spec(T)/λ₀, and with L²₀(π) = {f : π(f) = 0}, ‖Pᵏ‖_{L²₀(π)} = (λ₁/λ₀)ᵏ for every k ≥ 1, λ₁ the largest modulus
of the spectrum of T on ψ₀^⊥ (for positive T, the second eigenvalue): m_lat = −log(λ₁/λ₀) = −log ‖P‖_{L²₀(π)} EXACTLY.
(iii) (The measure-weighted bound.) For every k ≥ 1, with p_k(x,·) the density of Pᵏ(x,·) with respect to π,

 (λ₁/λ₀)^{2k} ≤ Σ_{i≥1} (λ_i/λ₀)^{2k} = ∫ χ²(Pᵏ(x,·) ‖ π) π(dx) = Z_{2k}/λ₀^{2k} − 1,

where Z_{2k} = Tr T^{2k} is the partition function of the periodic lattice of time extent 2k on the given cross-section.
(iv) Proposition 8.1's coefficient is a WORST CASE over starting pairs and dominates the L² norm: ‖Pᵏ‖_{L²₀(π)} ≤ δ(Pᵏ).

*Proof.* (i) ⟨g, Pf⟩_π = λ₀⁻¹∫∫ g(x)ψ₀(x)T(x,y)ψ₀(y)f(y)dxdy is symmetric in (f,g) because T is; and
(T/λ₀)(ψ₀f)(x) = λ₀⁻¹∫T(x,y)ψ₀(y)f(y)dy = ψ₀(x)(Pf)(x). (ii) U maps the constant 1 to ψ₀ and L²₀(π) onto ψ₀^⊥, so P restricted to
L²₀(π) is unitarily equivalent to T/λ₀ restricted to ψ₀^⊥, a compact self-adjoint operator whose norm is its spectral radius λ₁/λ₀;
powers commute with the equivalence. (iii) Pᵏ(x,dy) = Tᵏ(x,y)ψ₀(y)dy/(λ₀ᵏψ₀(x)), so p_k(x,y) = Tᵏ(x,y)/(λ₀ᵏψ₀(x)ψ₀(y)). Then
∫∫p_k² dπdπ = λ₀^{−2k}∫∫Tᵏ(x,y)²dxdy = λ₀^{−2k}Tr T^{2k} (symmetry; Tᵏ has a continuous kernel on the compact X², so it is
Hilbert–Schmidt and Tr T^{2k} = ‖Tᵏ‖²_HS = Σ_i λ_i^{2k}, with multiplicity), ∫∫p_k dπdπ = λ₀^{−k}⟨ψ₀,Tᵏψ₀⟩ = 1, so
∫∫(p_k − 1)²dπdπ = λ₀^{−2k}Tr T^{2k} − 1 = Σ_{i≥1}(λ_i/λ₀)^{2k}, and the inner integral is χ²(Pᵏ(x,·)‖π). The first inequality keeps one
term of a sum of non-negative terms. (iv) |λ|ᵏ ≤ δ(Pᵏ) for every eigenvalue λ ≠ 1 of P (Proposition 8.1's proof), and the norm of the
self-adjoint Pᵏ on L²₀(π) is the largest such |λ|ᵏ. ∎

**What (iii) says.** The gap is controlled by an AVERAGE over the vacuum law π of the time-zero field — the χ²-distance of the
k-step law from equilibrium, weighted by how often each starting configuration occurs — and that average is a RATIO OF PARTITION
FUNCTIONS. Proposition 8.1 replaces it by the worst pair of starting configurations, which is the loss the record measured (the
aligned outside data). The identity also says what a free-energy road to the gap would have to deliver: −log(Z_{2k}λ₀^{−2k} − 1),
the logarithm of the finite-time correction to the free energy, i.e. the free energy to a precision of order e^{−2k m}·(number of
low states). A bond-moving sandwich, which brackets the free-energy density at O(1) per plaquette, cannot reach that precision;
what a free-energy bound CAN price at O(1) is the probability of a disseminated event (chessboard, §5). That is the place where
the sandwich of arm 78 can enter a correlation bound, and §5 states the lemma.

---

## 2. THE L² DOBRUSHIN THEORY: MAXIMAL CORRELATION IN PLACE OF TOTAL VARIATION, L² FLUCTUATION IN PLACE OF OSCILLATION

**Setting.** Λ a finite set of sites, each with a compact space V_y; λ a probability on Ω = Π_y V_y with a continuous, strictly
positive density with respect to a product of probability measures (the blocked measures of THE GROUND §8.3 are of this kind on a
finite lattice). For y ∈ Λ: K_y F = E_λ[F | v_{y^c}] (integrate v_y against its conditional law; an orthogonal projection on L²(λ)),
Q_y = I − K_y, and the L² LOCAL FLUCTUATION

 ℓ_y(F) := ‖Q_yF‖_{L²(λ)} = ( E_λ[ Var_λ(F | v_{y^c}) ] )^{1/2},

a seminorm, zero unless F depends on v_y, at most osc_y(F)/2 (a variance is at most a quarter of the squared oscillation). For
y ≠ z and an environment ξ ∈ Π_{w∉{y,z}} V_w, let ρ_{yz}(ξ) be the MAXIMAL CORRELATION of (v_y, v_z) under λ(· | ξ):
ρ = sup{Cov(f(v_y), g(v_z) | ξ) : Var(f|ξ) = Var(g|ξ) = 1}; and

 R(y,z) := ess sup_ξ ρ_{yz}(ξ)  (symmetric, in [0,1]),  R(y,y) := 0.

R is the L² currency of Dobrushin's interdependence matrix C(y,z) = sup ‖λ(dv_y|v) − λ(dv_y|v′)‖_TV.

**Lemma 2.1 (the two-site lemma).** For y ≠ z and every F ∈ L²(λ): ℓ_y(K_yF) = 0 and

 ℓ_z(K_y F) ≤ ℓ_z(F) + R(y,z) ℓ_y(F).

This is Dobrushin's osc_z(K_yF) ≤ osc_z(F) + C(y,z)osc_y(F) with coefficient ONE on the diagonal, in L².

*Proof.* ℓ_y(K_yF) = ‖Q_yK_yF‖ = 0 since K_y is a projection. Every operator involved acts fibrewise over ξ = v_{{y,z}^c}: K_y
integrates v_y given (v_z, ξ), K_z integrates v_z given (v_y, ξ). Fix ξ and write X = v_y, Y = v_z, π = λ(dX, dY | ξ), ρ = ρ_{yz}(ξ);
where ρ = 1 the fibre bound with coefficient 1 holds trivially (Q_zK_yF = Q_zF − Q_zQ_yF and Q_z is a contraction, so
ℓ_z(K_yF)_ξ ≤ ℓ_z(F)_ξ + ℓ_y(F)_ξ), so let ρ < 1. Subtracting the mean, let F ∈ L²₀(π). Let T : L²₀(π_X) → L²₀(π_Y), Tf = E[f(X)|Y], with adjoint
T*g = E[g(Y)|X]; ‖T‖ = ρ, so A := T*T is a positive operator on L²₀(π_X) with spectrum in [0, ρ²]. Since ρ < 1 the subspaces L²₀(π_X)
and L²₀(π_Y) of L²(π) meet only in 0 and their sum S is closed; write F = f(X) + g(Y) + h with h ⊥ S (unique). Then E[h|X] = E[h|Y] = 0.
 Now K_yF = E[F|Y] = Tf + g =: u (a function of Y), and Q_zK_yF = u(Y) − E[u|X] = u − T*u, so, T*u being the orthogonal projection of
u(Y) onto L²(X),
 ℓ_z(K_yF)²_ξ = ‖u‖² − ‖T*u‖² = ⟨u, (I − TT*)u⟩ = ‖(I − TT*)^{1/2}u‖²,
 ℓ_z(K_yF) ≤ ‖(I − TT*)^{1/2}Tf‖ + ‖(I − TT*)^{1/2}g‖.
Second term: ‖(I − TT*)^{1/2}g‖² = ‖g‖² − ‖T*g‖² = ‖g − T*g‖², while Q_zF = F − E[F|X] = (g − T*g) + h with h orthogonal to both
summands, so it is ≤ ℓ_z(F)²_ξ. First term: ‖(I − TT*)^{1/2}Tf‖² = ⟨Tf, Tf⟩ − ⟨Tf, TT*Tf⟩ = ⟨f, (A − A²) f⟩. And Q_yF = F − E[F|Y] =
(f − Tf) + h, h orthogonal to f and to Tf, so ℓ_y(F)²_ξ ≥ ‖f − Tf‖² = ‖f‖² − ‖Tf‖² = ⟨f, (I − A) f⟩. For s ∈ [0, ρ²],
s − s² − ρ²(1 − s) = (s − ρ²)(1 − s) ≤ 0, so A − A² ≤ ρ²(I − A) by the spectral theorem, and the first term is ≤ ρ ℓ_y(F)_ξ. Hence
ℓ_z(K_yF)_ξ ≤ ℓ_z(F)_ξ + ρ_{yz}(ξ) ℓ_y(F)_ξ ≤ ℓ_z(F)_ξ + R(y,z) ℓ_y(F)_ξ for almost every ξ; and since ℓ_w(G)² = ∫ ℓ_w(G)²_ξ λ(dξ) for
every w, Minkowski's inequality in L²(λ(dξ)) gives the claim. ∎

**Proposition 2.2 (the fluctuation vector decays under the dynamics).** Let L = Σ_y (K_y − I), the generator of the heat-bath
dynamics (each site resampled from its conditional law at rate one), P_t = e^{tL}, self-adjoint on L²(λ). Then for every F and t ≥ 0,
componentwise,
 ℓ(P_tF) ≤ e^{−t(I − R)} ℓ(F),  ℓ(F) := (ℓ_y(F))_{y∈Λ}.

*Proof.* For 0 < h ≤ min(1, 1/|Λ|), I + hL = (1 − |Λ|h)I + hΣ_yK_y with 1 − |Λ|h ≥ 0, so by subadditivity of ℓ_z, Lemma 2.1 and
ℓ_z(K_zG) = 0: ℓ_z((I + hL)G) ≤ (1 − |Λ|h)ℓ_z(G) + h(|Λ| − 1)ℓ_z(G) + hΣ_{y≠z}R(y,z)ℓ_y(G) = ((1 − h)I + hR)ℓ(G))_z. The matrix
B_h = (1 − h)I + hR has non-negative entries, so it preserves the componentwise order, and induction gives
ℓ((I + tL/n)ⁿF) ≤ B_{t/n}ⁿ ℓ(F). As n → ∞, (I + tL/n)ⁿ → e^{tL} in operator norm (L is bounded on L²(λ), Λ being finite), ℓ is
continuous on L², and B_{t/n}ⁿ = (I − (t/n)(I − R))ⁿ → e^{−t(I−R)}. ∎

**Theorem 2.3 (the L² covariance theorem).** Suppose the spectral radius of R is < 1. Then for all F, G ∈ L²(λ),

 |Cov_λ(F, G)| ≤ Σ_{x,y∈Λ} ℓ_x(F) D(x,y) ℓ_y(G),  D = (I − R)⁻¹ = Σ_{n≥0} Rⁿ  (entrywise non-negative),

and the approximate tensorization of variance holds: Var_λ(F) ≤ (1 − ρ(R))⁻¹ Σ_y E_λ[Var_λ(F | v_{y^c})]. If moreover
Σ_z R(y,z) e^{κ|y−z|} ≤ α < 1 for every y, for a metric |·| on Λ, then D(x,y) ≤ e^{−κ|x−y|}/(1 − α).

*Proof.* The Dirichlet form is E(F,G) := −⟨LF, G⟩ = Σ_y ⟨Q_yF, G⟩ = Σ_y ⟨Q_yF, Q_yG⟩, so |E(F,G)| ≤ Σ_y ℓ_y(F)ℓ_y(G). The kernel of L
is ∩_y Ran K_y, the functions a.e. independent of every coordinate, i.e. the constants (positive density, Fubini); so P_tF → λ(F) in
L² as t → ∞, and d/dt⟨P_tF, G⟩ = −E(P_tF, G) gives Cov_λ(F,G) = ∫₀^∞ E(P_tF, G) dt. By Proposition 2.2,
|E(P_tF,G)| ≤ Σ_y (e^{−t(I−R)}ℓ(F))_y ℓ_y(G), and ∫₀^∞ e^{−t(I−R)}dt = (I − R)⁻¹ = Σ_n Rⁿ (entrywise non-negative, convergent since
ρ(R) < 1). For the tensorization: d/dt‖P_tF − λF‖² = 2⟨P_tF − λF, LP_tF⟩ = −2E(P_tF, P_tF) = −2‖ℓ(P_tF)‖²₂, and
‖ℓ(P_tF)‖₂ ≤ ‖e^{−t(I−R)}ℓ(F)‖₂ ≤ e^{−t(1−ρ(R))}‖ℓ(F)‖₂ (componentwise domination by a non-negative vector; R symmetric and
non-negative, so ‖e^{−t(I−R)}‖_{ℓ²→ℓ²} = e^{−t(1−ρ(R))}); integrating over [0, ∞), Var(F) = ∫₀^∞ 2‖ℓ(P_tF)‖²₂ dt ≤ (1 − ρ(R))⁻¹‖ℓ(F)‖²₂,
which is the statement since ‖ℓ(F)‖²₂ = Σ_y E[Var(F|v_{y^c})]. For the decay: put R̃(x,y) = R(x,y)e^{κ|x−y|}, whose row sums are at most α; by
|x − y| ≤ |x − w| + |w − y| and induction, Rⁿ(x,y)e^{κ|x−y|} ≤ R̃ⁿ(x,y) ≤ αⁿ (row sums of R̃ⁿ at most αⁿ), so
D(x,y)e^{κ|x−y|} ≤ Σ_n αⁿ = 1/(1 − α); and ρ(R) ≤ max row sum ≤ α < 1. ∎

**Remark 2.4 (sharpness).** For two sites R = [[0,ρ],[ρ,0]] and the tensorization constant 1/(1 − ρ) is the exact one (the two-block
Gibbs sampler's gap). For a Gaussian measure the conditional maximal correlations are the absolute partial correlations, and the exact
tensorization constant is 1/(1 − λ_max(B)) with B the partial-correlation matrix; Theorem 2.3 gives 1/(1 − ρ(|B|)) ≥ it, equal when the
partial correlations are non-negative (§4).

**Proposition 2.5 (the currency inequality: I ⇒ I-L²).** For every environment ξ and y ≠ z,
ρ_{yz}(ξ)² ≤ C_ξ(y|z) C_ξ(z|y), where C_ξ(y|z) = sup_{a,b} ‖λ(dv_y | v_z = a, ξ) − λ(dv_y | v_z = b, ξ)‖_TV (½‖·‖₁) is Dobrushin's
coefficient of the influence of v_z on v_y at ξ. Hence R(y,z) ≤ √(C(y,z)C(z,y)) ≤ ½(C(y,z) + C(z,y)), and
Σ_z R(y,z)e^{κ|y−z|} ≤ ½(row sum + column sum of C̃), C̃ = C e^{κ|·|}. Under Hypothesis I with column sums bounded like its row
sums (in particular for the translation-invariant measures of a construction on tori: C(y,z) = c(z − y), so every row sum and every
column sum of C̃ equals Σ_w c(w)e^{κ|w|}), Hypothesis I-L² of §3 holds with the same κ and α.

*Proof.* At fixed ξ, ρ² is the norm on L²₀ of the self-adjoint Markov operator K = E[E[·|v_y]|v_z] on functions of v_z (go to v_y, come
back), whose Dobrushin coefficient is at most C_ξ(y|z)C_ξ(z|y) (Dobrushin's coefficient is submultiplicative under composition of
kernels). Under the standing regularity (continuous positive densities on compact spaces) K has a bounded kernel density with respect
to the marginal of v_z, hence is Hilbert–Schmidt and compact; so its spectrum on L²₀ consists of eigenvalues with continuous, hence
bounded, eigenfunctions, each satisfying |λ| ≤ δ(K) by the oscillation argument of Proposition 8.1's proof, and the norm of the
self-adjoint K on L²₀ is the largest such |λ|. Take the ess-sup over ξ. ∎

So the L² hypothesis is never stronger than the symmetrised TV hypothesis, and it is strictly weaker on every law whose coupling is
spread over the group: for the leading mode p = 1 + εχ_½(U)χ_½(V) on SU(2) × SU(2) (Haar marginals) ρ = ε while
C = (ε/2)·4·E_Haar|χ_½| = (16/(3π))ε = 1.698ε; for U(1), p = 1 + 2ε cos φ cos ψ gives ρ = ε and C = (4/π)ε = 1.273ε (§6, known answers).

**Label.** The TV form of Theorem 2.3 is Föllmer's covariance estimate (1982) and Künsch's, Dobrushin's comparison its parent. The
maximal-correlation form above — Lemma 2.1 through the operator inequality A − A² ≤ ρ²(I − A), the Metzler comparison, and the
integrated covariance — is derived here; the literature search tool was not connected in this session, so whether this exact form is
in print (the approximate-tensorization line: Marton; Caputo–Menz–Tetali; the Gaussian case is the Gauss–Seidel/partial-correlation
theory) is UNCHECKED, and no priority is claimed for it.

---

## 3. THEOREM 8.5-L²: THE GAP OF EVERY LIMIT POINT FROM AVERAGED HYPOTHESES

Setting exactly THE GROUND §8.3's: a construction as in Theorem 7.4 with L = 2, the coarse scale a_c, blocks B_y, a block map
(coarse variables v_y in a fixed compact V, fibre coordinates φ_y), λ_j the blocked measure, ν_j(·|v) the fibre measure, S(f), N(f),
‖f‖, the distance |y − y′| = max_ν|y_ν − y′_ν| on the coarse lattice. The blocked measures are assumed to have continuous positive
densities with respect to the product of a fixed reference measure on V (true for Wilson measures and holonomy block maps). Write
ℓ^{(j)}_x for the L² local fluctuation of §2 under λ_j and R_j for its conditional maximal-correlation matrix.

**Hypothesis I-L² (the blocked bound, in L²).** There are κ > 0, α < 1 and a rung j₀ such that at every rung j ≥ j₀, on every lattice of
the construction, Σ_{y′} R_j(y, y′) e^{κ|y−y′|} ≤ α for every coarse point y.

**Hypothesis II-L² (the fibre clustering, averaged).** There are ρ′ < 1, K′ and a rung j₀ such that at every rung j ≥ j₀, on every
lattice, for all bounded observables f and g, d = dist(S(f), S(g)):
 (a) |E_{λ_j}[ ν_j(fg | v) − ν_j(f | v) ν_j(g | v) ]| ≤ K′ N(f) ‖f‖ ‖g‖ ρ′^d;
 (b) the fibre mean F(v) = ν_j(f | v) satisfies ℓ^{(j)}_x(F) ≤ K′ N(f) ‖f‖ ρ′^{r} for every coarse point x, r = dist(x, S(f)).

**Theorem 3.1 (the reduction in L²).** Under Hypotheses I-L² and II-L², put ρ = max(e^{−κ}, ρ′). For every ρ₁ ∈ (ρ, 1) there is K,
depending only on ρ, ρ₁, α, K′, N(f), N(g), ‖f‖, ‖g‖, such that at every rung j ≥ j₀ on every lattice of the construction
|S_j(fg) − S_j(f)S_j(g)| ≤ K ρ₁^d; and every limit point of the construction's Schwinger functions, on the sector generated by the
observables bounded uniformly in j, has a unique vacuum and a Hamiltonian with no spectrum in (0, m), m = (1/a_c) min(κ, log(1/ρ′)).

*Proof.* Fix j ≥ j₀, a lattice, f and g; F(v) = ν_j(f|v), G(v) = ν_j(g|v). The law of total covariance (W = 0; the record's
Tower.lean) gives
 μ_j(fg) − μ_j(f)μ_j(g) = Cov_{λ_j}(F, G) + E_{λ_j}[ν_j(fg|v) − F(v)G(v)].
The second term is at most K′N(f)‖f‖‖g‖ρ′^d by II-L²(a). For the first, Hypothesis I-L² gives ρ(R_j) ≤ α < 1 and Theorem 2.3 applies:
 |Cov_{λ_j}(F,G)| ≤ Σ_{x,y} ℓ_x(F) D(x,y) ℓ_y(G) ≤ (K′²N(f)N(g)‖f‖‖g‖/(1 − α)) Σ_{x,y} ρ^{e(x,y)},
e(x,y) = r_x + |x − y| + r′_y with r_x = dist(x, S(f)), r′_y = dist(y, S(g)), by II-L²(b) and D(x,y) ≤ e^{−κ|x−y|}/(1 − α). By the
triangle inequality e(x,y) ≥ d, and the pairs with e(x,y) ≤ n number at most N(f)N(g)(2n+1)⁸; so the sum is at most
N(f)N(g)Σ_{n≥d}(2n+1)⁸ρⁿ ≤ K₁ρ₁^d with K₁ = K₁(ρ, ρ₁, N(f), N(g)). This is the covariance inequality with
K = K′²N(f)N(g)‖f‖‖g‖K₁/(1 − α) + K′N(f)‖f‖‖g‖. For the gap: an observable f bounded uniformly in j with links in [0, w]; S(θf̄) and
S(τ_t f) are at coarse distance ≥ ⌊t/a_c⌋ ≥ t/a_c − 1, so S_j(θf̄·τ_tf) − |S_j(f)|² ≤ (K/ρ₁)e^{−m₁t}, m₁ = log(1/ρ₁)/a_c, with a
constant independent of j and of the lattice: the hypothesis of Theorem 7.4 with r_j = 0 on D. Theorem 7.4 leaves no spectrum in
(0, m₁) for every ρ₁ ∈ (ρ, 1), hence none in (0, m). ∎

**What changed against Theorem 8.5, exactly.**
1. The tilt by G′ and Dobrushin's comparison theorem are replaced by Theorem 2.3: no supremum over CONFIGURATIONS enters the
 covariance step; the only supremum left is the ess-sup over the coarse environment inside R_j (the definition of a conditional
 coefficient), in the L² currency.
2. The fibre clause is AVERAGED over the blocked measure: (a) is the mean of the fibre covariance, (b) is an L²(λ_j) local fluctuation
 of the fibre mean, not its oscillation at the worst coarse configuration. THE GROUND says of Hypothesis II: "It is demanded for every
 coarse configuration, the adversarial ones included ... this is where it exceeds the small-field expansions, which control the
 fluctuation field in typical backgrounds and the large fields by their probability". II-L² is demanded on average: the adversarial
 configurations enter weighted by their probability, which is exactly what those expansions deliver.
3. It is a STRENGTHENING: Hypothesis II ⇒ II-L² (|mean| ≤ sup; ℓ_x(F) ≤ δ_x(F)/2), and Hypothesis I ⇒ I-L² where Hypothesis I's
 matrix has column sums bounded like its row sums (Proposition 2.5), which holds for the translation-invariant measures of the
 construction. So every certificate of Theorem 8.5's hypotheses certifies Theorem 3.1's, and Table 3 (Theorem 8.7, β ≤ 0.2452) is a
 known answer for Hypothesis I-L² at the fine scale (§6, K-T3).
4. The rate (8.8) is unchanged.

---

## 4. THE REFUSAL OF U(1): EVERY HYPOTHESIS OF THIS KIND FAILS WHERE THE THEORY IS MASSLESS (a necessary refusal, by theorem)

**Theorem 4.1 (the refusal).** Let a lattice gauge theory with any compact group G be blocked at a scale a_c with continuous coarse
variables, and suppose that on a sequence of tori of growing side the blocked measures λ satisfy Σ_{y′}R(y,y′)e^{κ|y−y′|} ≤ α < 1 for
some κ > 0. Then for all bounded functions F of the coarse variables in a set X and G of those in Y,
|Cov_λ(F,G)| ≤ |X||Y| ‖F‖_∞ ‖G‖_∞ e^{−κ dist(X,Y)}/(1 − α), uniformly in the volume. Consequently, if the theory has two local
observables that are functions of the coarse plaquette holonomies (for instance the field strength of one coarse plaquette, sin θ_p
for U(1)) whose connected correlation decays slower than every exponential, then for every block map whose coarse variables
determine the coarse plaquette holonomies (THE GROUND's holonomy maps do) and every κ > 0, α < 1, the hypothesis fails: the weighted
row sums of R are ≥ 1 somewhere, at some volume.

*Proof.* Theorem 2.3 with ℓ_x(F) ≤ osc_x(F)/2 ≤ ‖F‖_∞ (zero off X) and D(x,y) ≤ e^{−κ|x−y|}/(1 − α). ∎

**For U(1).** Four-dimensional U(1) lattice gauge theory has a massless (Coulomb) phase at weak coupling. The input Theorem 4.1
needs — correlations slower than every exponential — is Fröhlich–Spencer's (1982): power-law photon correlations for the Villain action
at large β. (Guth (1980) proved the perimeter law for the Wilson action at large β, which is evidence of the phase but not by itself
that hypothesis.) At β = 1.2 (above the transition near 1.011) the Wilson theory is in that phase by the measured phase diagram. So by
Theorem 4.1 no block map of U(1) at such β satisfies Hypothesis I-L², at any κ > 0 — the refusal is a THEOREM of the criterion, not a
reading of an instrument, wherever the masslessness is (Fröhlich–Spencer's range, rigorously; 1.2, by the measured phase diagram).

**The sighted computation (the free field, exactly).** For the massless lattice Gaussian φ on ℤ^d (precision J = 2dI − A, A the
adjacency), the conditional law of φ_x given the rest is N(Σ_{y∼x}φ_y/(2d), 1/(2d)); for a Gaussian, the conditional maximal
correlation of (φ_x, φ_y) given the rest is the absolute partial correlation |J_xy|/√(J_xx J_yy) (the maximal correlation of a
bivariate Gaussian is |its correlation| — Lancaster/Gebelein), so R = A/(2d) and every row sum is EXACTLY 1: ρ(R) = 1, the criterion
is marginal and refuses (it needs α < 1). For the massive field J = (2d + m²)I − A, R = A/(2d + m²), the weighted row sum is
2d e^κ/(2d + m²) < 1 for κ < log(1 + m²/(2d)), and Theorem 2.3 returns exponential decay at a rate ≥ log(1 + m²/(2d)) per site. The
criterion parts massive from massless at the margin, as a correct criterion must. (This is the free field at scale one; the blocked
Gaussian is NOT computed here and no number is claimed for it.)

**What this does and does not say about SU(2).** Theorem 4.1 is a necessary property of the criterion: it cannot hold for U(1) at
weak coupling at any scale. It is a property of EVERY sufficient condition for exponential decay — THE GROUND's Hypothesis I
satisfies it verbatim — so it discharges the NEGATIVE half of the group-dependence (U(1) is refused) and not the POSITIVE half
(which property of SU(2) makes the bound hold at a scale reached from 2.2). The positive half is NOT derived here. It is not a
mechanism for SU(2). The group enters Theorem 3.1 through two quantities only: the VALUES of
R_j at the coarse scale (the running coupling: SU(2)'s blocked coupling flows to strong coupling, U(1)'s Coulomb coupling does not —
the photon is infrared free) and, through II-L², the probability weight of frustrated fine data (§5). §6 reads the first at a fixed
datum on the exact objects, where — as the record already found in total variation — a fixed datum does not part the groups.

---

## 5. WHERE THE SUPREMUM REMAINS, WHERE AN AVERAGE REPLACES IT, AND WHAT THE CHESSBOARD MUST PRICE

**5.1 The ledger of suprema.** (a) In Theorem 3.1 the covariance step takes no supremum over configurations. (b) R_j(y,z) is an
ess-sup over the COARSE environment ξ = v_{{y,z}^c}; inside each conditional law λ_j(dv_y, dv_z | ξ) the fine field is INTEGRATED with
its true conditional weight given the coarse configuration. So the record's convicted quantity — C_ω at the aligned fine outside,
adjacent sum ≥ 1.33 two steps up from 2.2 — is a supremum over FINE data, the pointwise route's (§15 CORRECTED: an upper-bound route
for Hypothesis I, not Hypothesis I), and it is not the supremum Theorem 3.1 contains. (c) The fibre clause is averaged (II-L²).
(d) Proposition 2.5: none of this is weaker than THE GROUND's hypotheses; it is implied by them.

**5.2 The two parts of a coarse coupling (Lemma 5.1, the L² mixture inequality; W = 0 in its parts).** Let ω be the fine outside of
the two-face object (every fine link not in the two faces), ν₀(dω | ξ) its law given the coarse environment, p_ω the object's joint law
of the coarse loops (A, B) at the datum ω, and suppose ξ is a function of ω (ξ ⊂ σ(ω)), so that λ(dA, dB | ξ) = ∫ ν₀(dω|ξ) p_ω(dA, dB).
(THE GROUND's block map satisfies this when the object is the two BLOCKS: every other coarse variable is a function of its own block's
links, all in ω. The record's two-FACE objects with LOOP variables do not: the coarse loops sharing a coarse link with A depend on A's
boundary links, which are object links, so for them the lemma applies only to the environment's ω-measurable part — that gap is the
loop–link relation listed in §8.) Then

 ρ_ξ(A, B) ≤ ess sup_ω ρ_ω(A, B) + ρ_ξ(A; ω) · ρ_ξ(B; ω),

where ρ_ξ(A; ω) is the maximal correlation between A and the fine outside under the law given ξ.
*Proof.* For f(A), g(B) of unit variance under λ(·|ξ), the law of total covariance gives
Cov(f, g | ξ) = ∫ν₀ Cov_ω(f, g) + Cov_{ν₀}(m_f, m_g), m_f(ω) = E_ω[f(A)]. The first term is at most
sup ρ_ω ∫√(Var_ω f · Var_ω g) dν₀ ≤ sup ρ_ω (∫Var_ω f dν₀)^{1/2}(∫Var_ω g dν₀)^{1/2} ≤ sup ρ_ω; the second at most
(Var m_f · Var m_g)^{1/2} ≤ ρ_ξ(A;ω)ρ_ξ(B;ω), since Var(E[f(A)|ω]) ≤ ρ_ξ(A;ω)² Var f. ∎
The first part is the DIRECT coupling, which the two-face object reads at each fine datum. The second is the OUTSIDE-MEDIATED coupling:
the fluctuation, over the fine outside weighted by its true law, of the object's pointwise means — at two steps from 2.2 the record's
E_ω[χ_½(A)] runs from 0.146 (ordered) to −0.0007 (random), so this part is not negligible a priori, and no two-face object reads it,
because the object pins ω. It is the record's §15 "Σ_{ℓ∈N(B)} β_{Aℓ}" term in its L² form, and it is the MEASURE-WEIGHTED object of
the crossing: a variance over fine data, weighted by the law of the data.

**5.3 The chessboard lemma for the averaged clause.** Let B be an event measurable with respect to the fine field in a fixed block
neighbourhood of a coarse point x, h ≥ 0 a function of the configuration with h ≤ ε² on B^c and h ≤ H everywhere. Then
E_μ[h] ≤ ε² + H μ(B) ≤ ε² + H z(B), z(B) = lim_Λ μ_Λ(∩_{reflections r} rB)^{1/|Λ/blocks|}, the chessboard estimate for
reflection-positive measures (Fröhlich–Israel–Lieb–Simon 1978; the Wilson action is reflection positive in planes through sites and
between sites, Osterwalder–Seiler [5]; Borgs–Seiler 1983 in gauge theories). With h = Var_{λ}(F | v_{x^c}) this prices Hypothesis
II-L²(b): ℓ_x(F)² ≤ ε_x² + ‖F‖²_∞ z(B_x), the good data bounded on exact objects, the frustrated data by their chessboard weight —
the converged program of the record, placed where Theorem 3.1 PERMITS an average. And z(B)^{|Λ/blocks|} = Z_Λ(B disseminated)/Z_Λ
is a free-energy DENSITY difference, an O(1) quantity per block: the size a bond-moving sandwich (arm 78, BondMoving.lean) brackets.
That — not Proposition 1.1(iii), which needs the free energy to exponential precision — is how the sandwich enters a correlation
bound. (The lemma is a two-line split; its content is the chessboard estimate, classical, and the event B, which is the next object.)

---

## 6. THE CERTIFICATE DESIGN, THE STAKES, AND THE RUNS (the exact two-face objects, PLANAR ONLY for the geometry)

**6.0 The bent object, read from the code (w2_strip_n.c build(), the staple loop).** `is_obj_plaq` excludes only the 2n² face
plaquettes, so each of the n+1 CORNER plaquettes (the xz-plane plaquettes at base (0,j,0), j = 0..n, which contain face A's x-link
(0,j,0)→(1,j,0) and face B's z-link (0,j,0)→(0,j,1)) is entered TWICE as a staple: once for A's link with B's link read from the
datum (okey registers the object link as an "outside" link), once for B's link with A's link read from the datum. At the ordered and
the cancelling data those staples are indistinguishable from identity-valued outside staples, which is exactly why the record's D6
found planar = bent to the digit there. CONSEQUENCE, stated plainly: every "bent" number in the record at a named datum is a
PLANAR-GEOMETRY number; the true bent pair carries a direct A–B coupling through the n+1 corner plaquettes that the engine never
computed; so the record's S₂₀ = 20·C (sixteen bent pairs) is not the bent row, and neither is any sum built here from planar values.
Here only planar objects are read as geometry; bent dumps are read only as "the planar geometry at the named data", with the caveat.

**6.1 What is computed at each (object, datum, cap), from the junction-tensor dump F^{ac}_{rq,r′q′} = Z·E_ω[D^a(A)_{rq}D^c(B)_{r′q′}]:**
(i) the marginal moments m^a = F^{a0}/Z, n^c = F^{0c}/Z and the CROSS-COVARIANCE G^{ac} = F^{ac}/Z − m^a ⊗ n^c (linear in the
measure: it averages through fibres without slack); (ii) its Haar-orthonormal norm σ_H = ‖(√(d_a d_c) G^{ac})‖ (the leading
singular value in the basis √d_a D^a_{rq}); (iii) the EXACT maximal correlation ρ_ω of the truncated joint density
p(U,V) = Σ_{a,c≤L} d_a d_c Σ G-and-moment coefficients conj D^a conj D^c, by two roads: ROAD A (Gram) ρ = ‖Φ^{1/2} G Ψ^{1/2}‖ with
Φ_{ii′} = ∫ conj φ_i φ_{i′}/p_A, Ψ_{jj′} = ∫ ψ_j conj ψ_{j′}/p_B over the basis φ_i = d_a conj D^a_{rq} (a ≥ 1) on the product rule
(the derivation: Tg = (1/p_A)∫c(·,V)g(V)dV, the minimal-norm g with prescribed moments a = Ψγ, ρ² = λ_max(Ψ^{1/2}G†ΦGΨ^{1/2}));
ROAD B (grid) the top singular value of √(w_u w_v) c(U_u, V_v)/√(p_A(U_u)p_B(V_v)) on the product rule, c = p − p_A p_B evaluated
pointwise; (iv) the total variation C_ω on the same grid (for the known answers and the ratio; the record's C is quoted beside);
(v) the positivity census of p, p_A, p_B on the rule, refusing by name where the truncated density is signed. For U(1) the same with
φ_a = e^{−iaφ}, |a| ≤ L, on a uniform grid.

**6.2 Known answers before any reading (or the reader is not trusted).** K-free: the free datum dump → ρ = σ_H = C = 0 to roundoff.
K-syn2: synthetic SU(2) law p = 1 + εχ_½(U)χ_½(V), its moments computed by the rule → ρ = σ_H = ε, C = (16/(3π))ε = 1.6977ε.
K-synU: synthetic U(1) law p = 1 + 2ε cos φ cos ψ → ρ = ε, C = (4/π)ε = 1.2732ε. K-rec: the reader's C on dob_n2_W2L2_planar_ordered
against the record's 0.166337624 (degree-30 rule) to three digits. K-roads: Roads A and B agree to four digits at every cell.
K-rules: the degree-30 and degree-40 rules agree on ρ to four digits.

**6.3 THE STAKES (written 2026-11-02 before the reader exists; none edited after).**
- S1 (the currency ratio, SU(2) at 2.2, the six planar W2L2 cells n = 2, 4 × ordered, cancelling, random): ρ_ω/C_ω in [0.45, 0.75]
 at every cell; the leading-mode value 3π/16 = 0.589 is the centre. UNGUESSED within the band.
- S2 (U(1)): ρ_ω/C_ω in [0.60, 0.95] at every cell read (leading-mode value π/4 = 0.785).
- S3 (scale, fixed datum, both groups): ρ_ω falls from one step to two at every datum read, for SU(2) and for U(1); the ratio
 UNGUESSED, expected near C's (SU(2) ordered W2L2 ×0.16; U(1) 1.2 ordered ×0.45).
- S4 (the groups at a datum): the L² currency does NOT part the groups qualitatively at a fixed datum (both contract; U(1)'s
 values larger). The criterion's group-dependence is Theorem 4.1 plus integrated quantities; a datum reading is no decider.
- S5 (σ_H against ρ_ω): within 1 % at the random datum (marginals near Haar); parting by more than 10 % at the ordered one-step cell
 (E[χ_½(A)] = 0.62 there).
- S6 (arithmetic placed in advance, no claim): with the S1 centre, 20ρ_ω at two steps would read about 0.31 at W2L2 ordered planar
 against the TV's 0.525, and — were the sharper cap's ratio the same — about 0.66 / 0.78 at W3L2 ordered / cancelling against the
 TV's 1.11 / 1.33. A planar, pinned, truncated, one-datum direct part is not Hypothesis I-L²'s row (§5.2), whatever it reads.

**6.4 THE RUNS (2026-11-02 03:43–04:10 EST; reader l2dob.c in this directory, gcc -O2 -fopenmp; every record under rec/, one file per
cell; double precision with two roads, not outward rounding — readings, not certificates).**

Known answers (all MET unless marked):
- KR: the representation homomorphism holds at GENINV = 1, fails at 0; the record's GENINV = 1. MET.
- K-syn2: ρ = 0.050000000 by Road A and by Road B, σ_H = 0.05 (ε = 0.05). MET. TV: 0.085247535 by the ascent on the degree-30 rule
 against 16ε/(3π) = 0.084882636 (+0.43 %, the kink of |χ_½| under a finite rule; the degree-12 grid alone read 0.0771, refused as
 the reading and replaced by the ascent, which finds V = ±1).
- K-synU: ρ = 0.050000000 both roads; C = 0.063661573 against 4ε/π = 0.063661977. MET. K-synU2 (non-uniform marginals): Roads A and B
 agree to nine digits (0.131106631). MET.
- K-free: the free datum's dump reads ρ = σ_H = C = 0 to 10⁻¹⁶ (SU(2)) and to 10⁻¹⁵ (U(1)). MET.
- K-rec: C on dob_n2_W2L2_planar_ordered = 0.166380 (degree 30) against the record's 0.166338 (degree 30) / 0.166237 (degree 60);
 on dob_n4_W2L2_planar_ordered 0.026282676, the record's value to every printed digit; U(1) cells to five or more digits. MET.
- K-roads: Road A against Road B at every cell, worst relative difference 3·10⁻⁶ (n = 2, W3L2, ordered). MET.
- K-schur: the Schur reconstruction from channels reproduces the full-dump ρ to nine digits at n4 W2L2 ordered (0.015210922) and
 n2 W3L2 ordered (0.109877830). MET. The planar = bent identity at the named data, §6.0's mechanism: every digit at n = 2 and n = 4. MET.

**SU(2), β = 2.2 (planar geometry; at the named data the bent dumps ARE the planar geometry, §6.0).** ρ = maximal correlation of the
truncated joint law of the two coarse loops at the datum; C = THE GROUND's (8.5) at the datum (this reader, degree 30; the record's in
brackets where it differs); 20ρ the record's twenty-pair convention applied to planar values.

| cell | datum | ρ | C | ρ/C | σ_H | 20ρ (20C) |
|---|---|---|---|---|---|---|
| one step W2L2 | ordered | 0.081207503 | 0.166380 | 0.488 | 0.084441 | 1.624 (3.33) |
| one step W2L2 | cancelling | 0.132155408 | 0.249285 | 0.530 | 0.131847 | 2.643 (4.99) |
| one step W2L2 planar | Haar-random | 0.009649371 | 0.016347 | 0.590 | 0.009678 | 0.193 |
| one step W3L2 | ordered | 0.109877830 | 0.252354 [0.252212] | 0.435 | 0.120274 | 2.198 (5.04) |
| one step W3L2 | cancelling | 0.189480725 | 0.351407 [0.350377] | 0.539 | 0.198975 | 3.790 (7.01) |
| one step W3L4 | ordered / cancelling | 0.107463097 / 0.189748876 | 0.237921 / 0.347427 | 0.452 / 0.546 | — | loop cap: −2.2 % / +0.1 % |
| two steps W2L2 | ordered | 0.015210922 | 0.026283 | 0.579 | 0.015107 | **0.304** (0.526) |
| two steps W2L2 | cancelling | 0.017433784 | 0.029896 [0.029883] | 0.583 | 0.017362 | **0.349** (0.598) |
| two steps W2L2 planar | Haar-random | 0.000253141 | 0.000430 | 0.589 | 0.000253 | 0.005 |
| two steps W3L2 (record b, Schur) | ordered | 0.031498032 | 0.055675 [0.055627] | 0.566 | 0.031120 | **0.630** (1.113) |
| two steps W3L2 | cancelling | 0.038581180 | 0.066500 [0.066464] | 0.580 | 0.038391 | **0.772** (1.329) |

(The bent Haar-random cells, a different geometry from the bent object's true one and from the planar one, read 0.005210 / 0.005743 at
one step, W2L2 / W3L2, and 0.000178 / 0.000164 at two steps.)

**U(1) (record dumps, bent = planar at the named data by §6.0's mechanism; charges to 6, NMAX 6; C this reader [record]).**

| β, cell | datum | ρ | C | ρ/C | 20ρ (20C) |
|---|---|---|---|---|---|
| 1.2, one step (L4 / L6) | ordered | 0.204193486 / 0.204193924 | 0.370349 [0.370352] | 0.551 | 4.08 (7.41) |
| 1.2, one step | cancelling | 0.353739827 | 0.512793 [0.512796] | 0.690 | 7.07 (10.26) |
| 1.2, two steps | ordered | 0.120240908 | 0.166570 [0.166572] | 0.722 | **2.40** (3.33) |
| 1.2, two steps | cancelling | 0.147800366 | 0.196221 [0.196222] | 0.753 | **2.96** (3.92) |
| 0.9, one step | ordered / cancelling | 0.173509119 / 0.265189144 | 0.270410 / 0.357745 | 0.642 / 0.741 | 3.47 / 5.30 |
| 0.9, two steps | ordered / cancelling | 0.065427751 / 0.074510598 | 0.085994 / 0.095985 | 0.761 / 0.776 | **1.31 / 1.49** (1.72 / 1.92) |

The planar U(1) engine run (w2_u1 planar, n = 2, β = 1.2, ordered) was stopped by hand after 786 CPU-seconds with no output (its
planar sweep order is not the bent one's); no planar U(1) random cell exists.

**6.5 THE STAKES, GRADED (as written in §6.3, none edited).**
- S1 HELD at all six planar W2L2 cells: 0.488, 0.530, 0.590, 0.579, 0.583, 0.589, all in [0.45, 0.75]. Outside the six: one step W3L2
 ordered 0.435 below the band. At two steps every SU(2) cell sits at 0.566–0.590, at the leading-mode value 3π/16 = 0.589: at two
 steps the coupling is the (½,½) mode alone.
- S2 REFUTED at one cell: U(1) β = 1.2 one step ordered reads 0.551 < 0.60; the other seven cells read 0.642–0.776, in band.
- S3 HELD at every datum and both groups. Per-scale factors of ρ: SU(2) W2L2 ×0.187 (ordered), ×0.132 (cancelling), ×0.026
 (random, planar); W3L2 ×0.287 (ordered), ×0.204 (cancelling). U(1) 1.2 ×0.589 / ×0.418; 0.9 ×0.377 / ×0.281.
- S4 HELD as staked (both groups contract at every datum; U(1) larger at every cell). Beside it, read and not staked: in the L²
 currency the two-step direct part sits BELOW one for SU(2) at both caps and both named data (0.30 / 0.35 at W2L2, 0.63 / 0.77 at
 W3L2) where the TV currency put the sharper cap above one (1.11 / 1.33); U(1) sits ABOVE one at both couplings (2.40 / 2.96 at 1.2,
 1.31 / 1.49 at 0.9). U(1) at 0.9 is the GAPPED phase, so this reading does not track the gap; it reads the coupling at this scale.
- S5 first clause HELD (random: 0.3 % at one step, 0 at two); second clause REFUTED: σ_H parts from ρ by 4.0 % at the ordered one-step
 W2L2 cell, not by more than 10 % (9.5 % at W3L2).
- S6 (arithmetic, no claim): 20ρ = 0.304 against the placed 0.31; 0.630 / 0.772 against the placed 0.66 / 0.78.

**6.6 What the readings say, at their strength.** (1) THE CURRENCY: on these objects the L² coefficient is 0.44–0.59 of the TV
coefficient at every SU(2) cell and 0.55–0.78 at every U(1) cell, as the leading-mode constants 3π/16 and π/4 predict (the SU(2) ratios
computed with this reader's C inherit its measured +0.4 % kink bias, K-syn2; against the record's degree-60 C they move at that level); Proposition 2.5
guarantees only ρ ≤ C on a symmetric pair. (2) THE CAP: the plaquette cap is the mover — W2 → W3 multiplies the two-step ρ by 2.07
(ordered) and 2.21 (cancelling), the one-step ρ by 1.35 and 1.43; the loop cap moves the one-step ρ by 2.2 % at most. The two-step
readings are therefore NOT converged in the plaquette truncation, and "0.63 / 0.77 < 1" is a reading at W3, not a limit: a further
factor above 1.3 at W4 would put the sharper sum above one. W4L2 at two steps is the record's 4 GB, hours-long run, not taken here.
(3) WHAT IS NOT READ: the bent pair (sixteen of the twenty adjacent pairs; the engine never computed its corner plaquettes), the
outside-mediated part of Lemma 5.1, the fibre average over fine data, the coarse-environment supremum, the pairs sharing only a vertex,
the loop–link relation. So nothing here is Hypothesis I-L²'s row; the readings say only that the pointwise route's L² form is not
convicted at the objects' reach, where its TV form was.

---

## 7. THE MEASURE-WEIGHTED MIXTURE INEQUALITY, THE GENERAL TWO-PROJECTION LEMMA, AND THE ANSWER TO ITEM (4)

**Lemma 7.1 (the averaged mixture inequality; it replaces Lemma 5.1's supremum over fine data).** In §5.2's notation and under its
hypothesis ξ ⊂ σ(ω), let p(·) be the
law of A given ξ and M_A = ess sup_{ω,U} p_ω(U)/p(U) (likewise M_B). Then

 ρ_ξ(A, B) ≤ √(M_A M_B) · E_{ν₀(·|ξ)}[ρ_ω(A, B)] + ρ_ξ(A; ω) ρ_ξ(B; ω).

*Proof.* As in Lemma 5.1, with Var_ω(f) ≤ E_ω[(f − E f)²] = ∫(f − Ef)² p_ω ≤ M_A Var(f) in place of Var_ω(f) ≤ 1 after normalising,
so |∫ν₀ Cov_ω(f,g)| ≤ ∫ν₀ ρ_ω √(Var_ω f Var_ω g) ≤ √(M_A M_B) E_{ν₀}[ρ_ω] √(Var f Var g). ∎
The direct part now enters as an AVERAGE over the fine data under their true conditional law, priced by the chessboard on its bad set
(§5.3); the supremum left over fine data is the density ratio M, which needs no smallness. What is read of it: at two steps from 2.2
the object's JOINT densities relative to Haar lie in [0.35, 2.31] at every datum the record censused (the extremes at the ordered datum,
W3L2, record b), so the object's marginal p_ω(A) lies within that range too; M also involves the TRUE marginal p of A given ξ, which no
object reads, and is therefore not bounded here — only its object part is, at about 2.3. The record's convicted quantity — the
supremum over fine data of the direct part — has left Lemma 7.1's bound; what remains at the object level is the loop–link relation
and the coarse-environment supremum.

**Lemma 7.2 (the two-site lemma for any two projections).** Let P, Q be orthogonal projections on a Hilbert space, N = Ran P ∩ Ran Q,
c = ‖PQ − P_N‖ (the cosine of the Friedrichs angle). Then for every F: ‖(I − Q)PF‖ ≤ ‖(I − Q)F‖ + c ‖(I − P)F‖.
*Proof.* By Halmos' two-subspace theorem the space is the orthogonal sum of Ran P ∩ Ran Q, Ran P ∩ Ker Q, Ker P ∩ Ran Q,
Ker P ∩ Ker Q and a generic part unitarily equivalent to K ⊗ ℂ² on which P = diag(1, 0) and Q = [[cos²Θ, cosΘ sinΘ],[cosΘ sinΘ, sin²Θ]]
for a positive angle operator 0 < Θ < π/2 with cos Θ ≤ c. On the four trivial summands the inequality holds with coefficient 0
((I − Q)PF is 0, F, 0, 0 and ‖(I − Q)F‖ is ≥ it). On the generic part, with F = (x, y): PF = (x, 0), (I − Q)PF = (sinΘ x)·(sinΘ, −cosΘ),
of norm ‖sinΘ x‖ ≤ ‖sinΘ x − cosΘ y‖ + ‖cosΘ y‖ ≤ ‖(I − Q)F‖ + c‖(I − P)F‖ (the vector (sinΘ, −cosΘ) spans Ran(I − Q) there and
‖(I − P)F‖ = ‖y‖). The summands are orthogonal and preserved, so Minkowski in ℓ² over them gives the claim. ∎
Consequences. Theorem 2.3 holds for ANY family of conditional expectations K_y onto sub-σ-algebras with ∩_y Ran K_y = constants, with
R(y,z) = ‖K_yK_z − K_{y∧z}‖ (the cosine of the Friedrichs angle between L²(G_y) and L²(G_z)) — block heat baths, overlapping blocks,
any coarse variables. And it locates the supremum exactly: R is an OPERATOR NORM, and for σ-algebras with a common environment it is the
ess-sup over that environment because a test function may concentrate on any environment set of positive measure. The supremum enters
the covariance bound only in the Minkowski step ‖ρ(ξ)ℓ_y(F)_ξ‖_{L²(dξ)} ≤ ‖ρ‖_∞ ℓ_y(F). It is the TOOL's (§8, the next object).

**Item (4) — the free-energy sandwich and correlations.** BondMoving.lean (III LEAN/aperanton/Aperanton/BondMoving.lean) proves, for
ANY non-negative base weight w on a finite Ω and actions A, B: Z(A + B)² ≤ Z(2A)Z(2B) (Cauchy–Schwarz) and Z(A + B) ≥ Z(2A)exp E_{2A}[B − A]
(Jensen). A constraint imposed as w·1_B is admissible as stated; evaluating Z(2A) by the hierarchical recursion needs the constraint to be
a per-plaquette class function (w·1[tr U_p ≤ 0] is one). What the sandwich controls, by Proposition 1.1(iii), cannot be the gap through
Z_{2k} (exponential precision is needed); what it CAN control is the chessboard weight z(B) = (Z_Λ(B disseminated)/Z_Λ)^{1/N}, an O(1)
free-energy density difference, the upper bound from Z(B)'s Cauchy–Schwarz and the lower bound on Z_Λ from Jensen — and that weight
prices the bad set in Lemma 7.1 and in Hypothesis II-L²(b) (§5.3). The design constraint, read off the record: one frustrated plaquette
has P(tr U_p ≤ 0) ≈ 0.1 at 2.2 (the far shore §7), and z(B) ≥ μ(B), so a single-plaquette event can never be rare enough; the bad event
must be COMPOUND — a block of the near outside of the object whose plaquettes are jointly ordered (or jointly frustrated) past a
threshold — so that z(B) is exponentially small in the number of constrained plaquettes, at the price of a weaker good-set bound.

---

## 8. WHAT IS LEFT, IN THE UNITS OF THE CROSSING

Proved here (full proofs above): Proposition 1.1 (the gap is the L²(π) norm; the measure-weighted bound by Z_{2k}/λ₀^{2k} − 1);
Lemma 2.1 / 7.2 (the L² two-site lemma, any two projections); Proposition 2.2, Theorem 2.3 (the L² covariance theorem and the
tensorization of variance from the conditional maximal correlations; weighted row sums give exponential decay); Proposition 2.5
(ρ² ≤ C(A|B)C(B|A): I ⇒ I-L²); Theorem 3.1 (THEOREM 8.5-L²: the gap of every limit point from I-L² and the AVERAGED fibre clause
II-L², a strengthening of Theorem 8.5); Theorem 4.1 (every such hypothesis refuses U(1) wherever it is massless; the free field's
matrix is exactly marginal, ρ(R) = 1); Lemmas 5.1, 7.1 (the mixture inequalities; the second removes the fine-data supremum).

Left, each as the object to derive next:
1. **Hypothesis I-L² at one exit scale, uniformly in the cutoff — the crossing itself, and the L² form does not shorten the distance in
 blocking steps.** On the exact objects the pointwise direct part reads below one at two steps from 2.2 in the L² currency (0.63 /
 0.77 at W3L2), not converged in the plaquette cap; what the theorem needs beyond it is the bent pair (an engine that integrates the n+1
 corner plaquettes as cycles), the fibre average E_{ν₀}[ρ_ω] (Lemma 7.1), the outside-mediated product ρ(A;ω)ρ(B;ω) (a variance of the
 object's means over fine data under their true law — measure-weighted by construction), the vertex-sharing pairs, the loop–link
 relation (the converse direction, iii-73's maximal-tree gauge fixing), the W4 cap, and certified arithmetic (interval Gram matrices
 with a bound on the quadrature error of 1/p_A).
2. **The coarse-environment supremum (the constraint broken by §7, the program).** By Lemma 7.2 it enters only through Minkowski. The
 program: replace it by Hölder, ‖ρ(ξ)ℓ_y(G)_ξ‖ ≤ ‖ρ‖_{L^{2p}(dξ)} ‖ℓ_y(G)_ξ‖_{L^{2q}(dξ)}, along the trajectory G = P_tF only, and control
 the L^{2q} norm of the fibrewise fluctuation profile by hypercontractivity of the coarse dynamics; then a bad environment set of
 chessboard weight z costs z^{1/(2p)}, which an exponentially small compound event pays. Its failure mode, named first: hypercontractivity
 is a log-Sobolev statement whose own local-to-global theorems (Zegarlinski's) take a supremum over boundary data, so the supremum may only
 have moved; and slow (trapping) bad regions are exactly where a log-Sobolev constant fails.
3. **The positive half of the group-dependence.** Theorem 4.1 refuses U(1); what property of SU(2) makes R_j small at the exit scale is
 not derived. The readings point at the running coupling (SU(2)'s per-scale factor 0.13–0.29 against U(1)'s 0.42–0.59 at 1.2) and at
 the centre (at two steps SU(2)'s coupling is the single (½,½) mode, ρ/C at 3π/16: the centre-odd channel carries it); the theorem
 that bounds the centre-odd coarse coupling by a vortex free energy (Tomboulis–Yaffe's inequality at the coarse scale) is the object.
4. **Hypothesis II-L² from the ultraviolet half**: the averaged fibre clause is the form a small-field expansion delivers; stating
 Bałaban's output in that form at the exit scale is the interface's next line.

**Cross-field (named, with what it buys).** Theorem 2.3 is the multi-site form of the convergence rate of the two-block Gibbs sampler /
data augmentation in Markov-chain Monte Carlo, whose L² rate is the maximal correlation between the blocks (Liu–Wong–Kong 1994; Amit's
Gaussian multi-block theory, where the matrix of partial correlations plays R's role exactly) — to verify against those sources, the
literature tool having been down. The same object is the χ²-contraction coefficient of information theory (η_χ² = ρ², strong data
processing), which is why the L² currency tensorises where total variation does not. And Lemma 7.2 is von Neumann–Halperin's alternating
projections with Friedrichs angles: the crossover's coefficient is the angle between the subspaces of functions that forget one coarse
variable.
