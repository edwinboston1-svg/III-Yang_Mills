
## 5. SHEN–ZHU–ZHU READ IN FULL (arXiv:2204.12737 v1, the only arXiv version; LaTeX source sha256 of the e-print c2f61d2e…a949a2,
## 3,591 lines, read section by section: §1 Introduction and Main Results, §2 preliminaries, §3 the SDE, §4 LSI/Poincaré and both
## applications, §5 uniqueness, Appendix A the coupling. Published CMP 400 (2023); the arXiv text is the one read.)

### 5.1 What is proved, verbatim in content (LITERATURE, READ)

SETTING. G ∈ {SO(N), SU(N)} only ("the choice of constant positive curvature Lie groups SO(N) and SU(N) in this article is a technical
simplification for demonstrating our method, and it should apply as well for other compact target spaces", §1.3); ℤ^d, periodic boxes
Λ_L, the 't Hooft-scaled action S(Q) = Nβ Re Σ_{p∈P⁺} Tr(Q_p), β ∈ ℝ (either sign); HS metric ⟨X, Y⟩ = Re Tr(XY*) on the Lie algebra.
ASSUMPTION 1: K_S := C_{Ric,N} − 8N|β|(d − 1) > 0 with C_{Ric,N} = (N + 2)/4 − 1 = (N − 2)/4 for SO(N) and (N + 2)/2 − 1 = N/2 for SU(N)
(the Ricci curvature of G in that metric, AGZ (F.6)); equivalently |β| < 1/(32(d−1)) − 1/(16N(d−1)) (SO(N)), |β| < 1/(16(d−1)) (SU(N)).
THEOREM 1.3 (uniqueness and ergodicity). Under Assumption 1: (1) the infinite-volume Langevin dynamic dQ = ∇S dt + √2 d𝔅 on G^{E⁺} (well
posed, Prop. 3.4, strong solutions by Yamada–Watanabe) has a UNIQUE invariant measure μ_YM; (2) every tight limit of the periodic
finite-volume Gibbs measures equals μ_YM and the whole sequence converges (Remark 1.4: Dirichlet or other boundary conditions give the same
limit); (3) exponential ergodicity: W₂^{ρ_{∞,a}}(νP_t, μ_YM) ≤ C(a)e^{−K̃_S t}, K̃_S = C_{Ric,N} − (4 + 4√a)N|β|(d − 1) > 0 for some a > 1
(possible exactly because K_S > 0, by letting a ↓ 1), ρ_{∞,a} the distance Σ_e a^{−|e|}ρ(Q_e, Q′_e)².
THEOREM 1.4 (log-Sobolev). Under Assumption 1, μ_YM(F² log F²) ≤ (2/K_S) Σ_e μ_YM(|∇_eF|²) for cylinder F with μ_YM(F²) = 1; hence the
Poincaré inequality with constant 1/K_S, and ‖P_tf − μ(f)‖_{L²} ≤ e^{−tK_S}‖f‖_{L²} (Remark 4.6 — a spectral gap of the LANGEVIN GENERATOR, not
of the transfer matrix).
COROLLARY 1.6 (large N). Var(W_ℓ/N) ≤ n(n − 3)/(K_S N) (SO(N)), 4n(n − 3)/(K_S N) (SU(N)) for a loop of n edges; factorization of Wilson loops.
COROLLARIES 4.4–4.5 (susceptibilities). Σ_e Cov(⟨Q_{e₀}, E⟩, ⟨Q_e, E⟩) ≤ 1/K_S (2/K_S); Σ_p̄ Cov(Re Tr Q_p, Re Tr Q_p̄) ≤ 8N(d − 1)/K_S (16N(d−1)/K_S).
COROLLARY 1.7 ("Mass gap"). For smooth cylinder f, g with disjoint supports: Cov(f, g) ≤ c₁ d_G e^{−c_N d(Λ_f, Λ_g)}(⦀f⦀_∞⦀g⦀_∞ + ‖f‖₂‖g‖₂),
⦀f⦀_∞ = Σ_e ‖∇_e f‖_∞, c₁ depending on |Λ_f|, |Λ_g|, and c_N ~ K_S/(d_G(a_{ee} + 6(d−1)a_{eē})), a_{eē} = N|β|√d_G, a_{ee} = 2(d−1)N|β|(√d_G + √2 N^{1/2}γ),
γ = 1 (SO(N)), 3√2 (SU(N)) (Remark after the proof: "not necessarily optimal"). The proof is Guionnet–Zegarlinski's commutator iteration
([v_e^i, L] bounded by neighbouring gradients, Lemma 4.8, with the bracket bound Lemma 4.7 computed in the explicit bases E_{kn}, F_{kn}, D_k)
plus the Poincaré decay of Var(P_t f).
WHAT IT DOES NOT STATE: (i) a transfer-matrix gap (their "mass gap" is exponential clustering of smooth local observables, from which a
transfer-matrix gap follows by reflection positivity — THE GROUND's Theorem 7.1 — on the gauge-invariant sector); (ii) a rate c_N uniform in N
or explicit; (iii) uniqueness among all DLR Gibbs measures — it proves uniqueness of the dynamic's invariant measure and identifies every
finite-volume limit; DLR uniqueness needs the standard (not written) step that every DLR measure of the Wilson specification is invariant for
the infinite-volume dynamic; (iv) any group other than SO(N), SU(N).

### 5.2 Where the group enters — every line located (READ), and the generalisation it permits

(a) THE BAKRY–ÉMERY INPUT (Theorem 4.2): Ric(v, v) − Hess_S(v, v) ≥ K_S|v|², with Ric from the bi-invariant metric (AGZ (F.6)) and
Hess_S bounded in Lemma 4.1 by |Hess_S(v, v)| ≤ 8(d − 1)N|β||v|²: each second derivative of Re Tr(Q_p) is Tr(Q X Q̃ X′) (two inserted Lie
algebra elements), bounded by |X||X′| by Cauchy–Schwarz in HS, 2(d−1) diagonal and 6(d−1) off-diagonal contributions. NOTHING ELSE about G.
(b) THE COUPLING (Lemma 5.1, Appendix A): Kendall–Cranston's coupling with parallel transport; the index lemma I ≤ −∫Ric(γ̇, γ̇) = −C_{Ric}ρ_e;
the drift term bounded by Re Tr(γ̇ γ̃̇ Q₁Q₂) ≤ |γ̇||γ̃̇| (HS again); Laplacian comparison off the cut locus. NOTHING ELSE about G.
(c) THE SDE (§3): the Casimir constant c_g of the matrix Brownian motion and the projection onto g; G-blind for a compact matrix group.
(d) COROLLARY 1.7 alone uses explicit SO(N)/SU(N) bases (the bracket constants γ₁² = 1/2, 9/2 and |∇_eS| ≤ 2(d−1)N^{3/2}|β|γ/γ₁).
THEOREM SZZ_G (PROVED here from their argument, which is now READ): for every compact simple G and faithful irreducible unitary ρ, with the
metric g_ρ(X, Y) = Re tr(ρ(X)ρ(Y)*) and the action (β/d_ρ)Σ_p Re χ_ρ(U_p): Ric_G = (h^∨/(4T_ρ)) g_ρ (bi-invariant metric: Ric = −¼B, MG §6.2(i)),
and Lemma 4.1's proof gives |Hess S(v, v)| ≤ 8(d − 1)(β/d_ρ)|v|²_{g_ρ} verbatim (the Cauchy–Schwarz is in the HS norm of ρ). So Assumption 1
becomes K_G := h^∨/(4T_ρ) − 8(d − 1)β/d_ρ > 0 ⟺ β < h^∨κ_ρ/(32(d − 1)) ⟺ λ = h^∨g²_YM > 32(d − 1) (= 96 at d = 4), and Theorems 1.3 and 1.4
hold verbatim for (G, ρ) (their proofs use (a)–(c) only); Corollary 1.7 holds with G-dependent constants: Lemma 4.7's bracket bound becomes
Σ_j |[v_i, v_j]f|² ≤ ‖ad_{v_i}‖²_{op}|∇f|² (finite for every G), Lemma 4.8's |∇_eS| ≤ 2(d−1)(β/d_ρ)·sup_Q‖P_g(ρ(Q_p)*)‖ ≤ 2(d−1)(β/d_ρ)√d_ρ.
CHECK against their two stated groups: SU(N) fundamental (h^∨ = N, κ = 2N): β_ours = N²β_SZZ < N²/(16(d−1)) ✓; SO(N) vector (h^∨ = N − 2, κ = N):
β_ours < N(N − 2)/(32(d−1)) ✓ = N²(1/(32(d−1)) − 1/(16N(d−1))) ✓ — both exactly their Assumption 1. MG's "PROVED GIVEN Shen–Zhu–Zhu's
argument, read at the abstract" is now DISCHARGED: the argument is read, its group content is exactly (Ric_G, the HS Hessian bound), and the
per-group table β_BE = h^∨κ_ρ/96 of §4.7 is their theorem for every G (uniqueness of the invariant measure and of the finite-volume limits,
LSI, Poincaré; exponential clustering with an inexplicit rate; the transfer-matrix gap through THE GROUND's Theorem 7.1).
COMPARISON (§4.7): Theorem 8.7_G's certified region is wider than SZZ_G's for SU(2) (2.05×; 2.94× with THE GROUND's sharp constants),
SU(3) (1.90×), SU(4) (1.42×), SU(5) (1.11×), Sp(2) (1.41×), SO(3) (7.77×), SO(5)–SO(8) (2.77×–1.27×), G₂ (1.77×), F₄ (1.25×), E₆ (1.04×), and
narrower for E₇ (0.83×) and E₈ (0.79×). In 't Hooft units SZZ_G is the G-UNIVERSAL line λ > 96; Theorem 8.7_G's line λ* depends on the group
(12.4 to 121), and the two cross between E₆ and E₇. SZZ's region DEGRADES with N in Wilson units relative to the true strong-coupling
region only through the factor 1/(32(d−1)); Theorem 8.7_G's degrades through the near-Haar radius of Lemma NH — two different walls.
