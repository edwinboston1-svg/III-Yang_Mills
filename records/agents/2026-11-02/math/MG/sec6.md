## 6. LINK (3): THE STRONG END FOR EVERY G

Normalisation throughout: plaquette weight exp((β/d_ρ) Re χ_ρ(U_p)) on ℤ⁴ (D = 4), β = κ_ρ/g²_YM, λ = h^∨g²_YM = h^∨κ_ρ/β.

### 6.1 THEOREM S_D (Dobrushin; every compact group, every unitary representation; PROVED)

For every compact group G, every finite-dimensional unitary representation ρ and 0 ≤ β < β_D := artanh(1/18) = ½ ln(19/17) =
0.055613…, the lattice gauge theory on ℤ⁴ has a unique infinite-volume Gibbs measure; for every m₀ < ln(1/(18 tanh β)) there is K
(depending on β, m₀ only) with |⟨fg⟩ − ⟨f⟩⟨g⟩| ≤ K N(f)N(g)‖f‖‖g‖e^{−m₀d} for bounded f, g of finitely many links (d the max-norm
distance of link midpoints), the same on every torus; and the transfer matrix has a unique vacuum and no spectrum in (0, m₀) on the
gauge-invariant sector.
PROOF. The conditional law of a link x given the others is ∝ exp((β/d_ρ)Σ_{p∋x} Re χ_ρ(U_xS_p))dU_x, S_p the staple of p. A link y
enters it only through the staple of the one plaquette p it shares with x (two distinct links share at most one plaquette); there are
2(D − 1)·3 = 18 such y. Changing U_y changes the conditional law by a tilt with g(U_x) = (β/d_ρ)[Re χ_ρ(U_xS′_p) − Re χ_ρ(U_xS_p)],
and |Re χ_ρ| ≤ d_ρ gives osc g ≤ 4β. The tilt bound proved in THE GROUND's proof of Theorem 8.7 ((T_gp)(B) − p(B) ≤ tanh(osc g/4), the
supremum over B and over p) gives C(x, y) ≤ tanh β, and C(x, y) = 0 for every other y. So Σ_y C(x, y)e^{κ|x−y|} ≤ 18 tanh(β)e^κ < 1
for κ < ln(1/(18 tanh β)) (the 18 neighbours lie at midpoint distance ≤ 1). Dobrushin's uniqueness theorem; the comparison theorem as
in the proof of Theorem 8.5 on one lattice with the links as sites (Theorem 8.7's last paragraph); Lemma RP_G and Theorem 7.1 at integer
times. ∎
The threshold is uniform in G and ρ. Against SU(2)'s own: the sharp single-link disk 3π/72 = 0.1309 (THE GROUND's MAD lemma), Theorem
8.7's 0.2452, Douglas–Rajasekaran's 1/96 and Shen–Zhu–Zhu's 1/12 (both converted by THE GROUND). In 't Hooft units S_D is λ > 18.0·h^∨κ_ρ,
which degrades with the group; §6.2 is the universal one.

### 6.2 THEOREM S_BE (Bakry–Émery; every compact simple G; the strong-coupling region is λ > 32(D − 1) = 96 for EVERY G and ρ)

THE TWO G-INPUTS (PROVED). Equip G with the bi-invariant metric g_ρ(X, Y) := Re tr(ρ(X)†ρ(Y)) (X = iX^aT^a): g_ρ(X, X) = T_ρΣ_a(X^a)².
(i) RICCI. For a bi-invariant metric Ric(X, X) = −¼B(X, X), B the Killing form (Milnor 1976 — LITERATURE, standard), and −B(X, X) =
Σ_{a,b}X^aX^b tr_adj(T^aT^b) = h^∨Σ_a(X^a)². Hence Ric_G = (h^∨/(4T_ρ)) g_ρ.
(ii) HESSIAN. Geodesics of a bi-invariant metric are one-parameter subgroups, so the Hessian of f = Re tr ρ(U₁U₂U₃U₄) along
(X₁, …, X₄) is f″(0) for f(t) = Re tr ρ(U₁e^{tX₁}⋯U₄e^{tX₄}) = Σ_k Re tr(⋯X_k²⋯) + 2Σ_{i<j} Re tr(⋯X_i⋯X_j⋯); |tr(AXBYC)| ≤
‖X‖_HS‖Y‖_HS for unitary A, B, C (Cauchy–Schwarz); so |f″(0)| ≤ (Σ_k‖ρ(X_k)‖_HS)² ≤ 4Σ_k g_ρ(X_k, X_k). Each link lies in 2(D − 1)
plaquettes, so H = −(β/d_ρ)Σ_p Re χ_ρ(U_p) has Hess H ≥ −(8(D − 1)β/d_ρ) Σ_ℓ g_ρ(X_ℓ, X_ℓ).
(iii) Ric + Hess H ≥ K·g_ρ with K = h^∨/(4T_ρ) − 8(D − 1)β/d_ρ > 0  ⟺  β < h^∨κ_ρ/(32(D − 1))  ⟺  λ = h^∨g²_YM > 32(D − 1).
THE CONCLUSION, AND ITS LABEL. Bakry–Émery's criterion (1985, LITERATURE) gives a log-Sobolev inequality with constant K for the finite-volume
Wilson measure uniformly in the volume; Shen–Zhu–Zhu (arXiv:2204.12737; READ at the abstract today) derive from it the uniqueness of the
infinite-volume limit, LSI and Poincaré there, exponential decay of correlations and a strictly positive mass gap, stating it for SO(N) and
SU(N). THE TWO-SIDED CHECK (their normalisation is Nβ Re Tr per plaquette, so β_ours = N²β_SZZ): their SU(N) condition |β| < 1/(16(d − 1))
is β_ours < N²/(16(d − 1)) = h^∨κ_ρ/(32(d − 1)) with h^∨ = N, κ = 2N; their SO(N) condition |β| < (N − 2)/(32(d − 1)N) is β_ours <
N(N − 2)/(32(d − 1)) = h^∨κ_ρ/(32(d − 1)) with h^∨ = N − 2, κ = N (vector, T = 1). BOTH OF THEIR SEPARATELY STATED THRESHOLDS ARE THE ONE
CONDITION λ > 32(d − 1). Status: PROVED GIVEN Shen–Zhu–Zhu's argument, whose G-dependence (on the evidence of both stated cases) is exactly
(Ric_G, the Hessian bound) — computed here for every G; their proof body was not read (alphaXiv not connected; the abstract only).
PER GROUP (D = 4), β_BE = h^∨κ_ρ/96: SU(2) 0.08333; SU(3) 0.1875; G₂ (7) 0.29167; F₄ (26) 0.8125; E₆ (27) 1.125; E₇ (56) 1.75; E₈ (248)
2.58333; in the coupling: g²_YM > 96/h^∨.

### 6.3 Osterwalder–Seiler's small parameter as a function of G (PROVED)

Write the normalised weight f_β = w/c₀ = 1 + Σ_{r≠0} d_r a_r(β)χ_r, a_r = c_r/(d_rc₀) ∈ [0, 1] (Lemma RP_G). In the polymer
(high-temperature) expansion of the kind Osterwalder–Seiler use for compact groups — each plaquette entering through f_β − 1 — every polymer
activity is bounded by the product over its plaquettes of
  u_G(β) := sup_U |f_β(U) − 1| = Σ_{r≠0} d_r² a_r(β) = e^β/c₀^G(β) − 1,   c₀^G(β) = ∫_G e^{(β/d_ρ)Re χ_ρ} dU.
PROOF: the coefficients are nonnegative, so the supremum of |Σ d_ra_rχ_r| is attained at U = 1 (|χ_r| ≤ d_r = χ_r(1)), and f_β(1) = e^β/c₀. ∎
c₀ ≥ 1 (Jensen; ∫Re χ_ρ = 0), so u_G(β) ≤ e^β − 1 for EVERY G; and c₀ = 1 + (1 + ε_ρ)β²/(4d_ρ²) + O(β³) (E(Re χ_ρ)² = (1 + ε_ρ)/2, ε_ρ = 1 if
ρ ≅ ρ̄, else 0), so u_G(β) = β + β²/2 − (1 + ε_ρ)β²/(4d_ρ²) + O(β³). The expansion converges when u_G(β) is below a lattice constant u_*(D) fixed
by plaquette-polymer combinatorics alone. So the G-dependence of the Osterwalder–Seiler threshold — which THE GROUND records was never named —
lies entirely in c₀^G(β), the moment generating function of the Haar law of Re χ_ρ/d_ρ, and is absent at leading order. S_D and S_BE supersede
it numerically.

### 6.4 THEOREM 8.7_G (the perfect-cover decimation for every G): the form PROVED, β*_{8.7}(G) > 0 PROVED, the values OPEN

The construction is group-blind where it is combinatorial: the perfect cover L₁ (one link per plaquette, period two; THE GROUND, R7) and the
counts 12 (direct) and 90 (mediated). The S³ geometry generalises as follows. With ⟨A, B⟩ = Re tr(A†B) on E_G, (1/d_ρ)Re χ_ρ(U_aS) =
⟨ρ(U_a), ρ(S)†⟩/d_ρ, so given L₀ the cover links are independent with laws
  ν_W(dU) ∝ e^{⟨ρ(U), W⟩}dU,  W(a) = (β/d_ρ)Σ_{p∋a}ρ(S_p(a))† ∈ E_G,  ‖W‖_HS ≤ 6β/√d_ρ
(the matrix von Mises–Fisher, or matrix-Langevin, family on G; SU(2)'s vMF on S³ is the case E_G = ℍ), and the marginal of L₀ has density
Π_a Z_G(W(a)), Z_G(W) = ∫_G e^{⟨ρ(U),W⟩}dU, bi-invariant: Z_G(ρ(h)Wρ(k)) = Z_G(W). For a kept link x, θ_p(U_x) = (β/d_ρ)(ρ(A)ρ(U_x)ρ(B))† is
an HS-isometric image of ρ(U_x) — the structure the SU(2) proof uses. Taylor's theorem for log Z_G (gradient: the mean of ν_W; Hessian: its
covariance; third derivative: its third cumulant) and the two tilt facts give C_dir and C_med of (8.12) with four constants of the family on the
ball ‖W‖ ≤ 6β/√d_ρ in place of Lemma 8.6's:
 (M) M_G := sup_W sup_{‖e‖=1} E_{ν_W}|⟨ρ(U), e⟩ − E⟨ρ(U), e⟩| (SU(2): THE GROUND's sharp one-link constant, maximal at Haar only);
 (Σ) σ_G(r) := sup_{‖W‖≤r} ‖Cov_{ν_W}‖_op (SU(2): ¼ in ℝ⁴ units at every r, Lemma 8.6(i)); its Haar value is computed exactly:
     E_Haar⟨ρ(U), e⟩² = ‖e‖²/(2d_ρ) for complex ρ, ‖e‖²/d_ρ for self-dual ρ (Schur orthogonality; e ∈ E_G);
 (D) the oscillation of the quadratic remainder's dependence on the direction of W (SU(2): |D| ≤ m²/3, Lemma 8.6(ii), from Turán for I_ν);
 (T) the third-cumulant bound (SU(2): m/2, Lemma 8.6(iii)).
THEOREM 8.7_G. If α_G(β) := 12C_dir + 90C_med < 1, the Gibbs measure is unique, correlations cluster with any m₀ < log(1/α_G)/2, and the gap holds.
β*_{8.7}(G) > 0 for every G: on the ball the four constants are finite (compactness, smoothness of Z_G > 0) and α_G(β) = O(β) as β → 0.
WHAT MUST BE RECOMPUTED PER GROUP (OPEN for G ≠ SU(2)): certified enclosures of (M), (Σ), (D), (T) over the parameter space of ν_W modulo G×G
(SU(2): |W| and the angle of e — THE GROUND's 9,104 rectangles; SU(N): the N singular values and the phase of det W, with e; G₂, F₄, E₈: the
polar parameters of E_G under G×G), the location of the MAD maximum (at Haar for SU(2); UNGUESSED for every other G), and the analogue of the
Turán inequality behind |D| ≤ m²/3 (§7.5: Turán's inequality does not transfer to general G as such). The theorem's FORM and the positivity of
its threshold hold for every G now.

### 6.5 THEOREM 8.9_G (the flux-surface gas for every G): what generalises, what changes, the crossing law PROVED

(a) ADMISSIBILITY. A labelled plaquette set contributes iff at every link the tensor product of its labels (r or r̄ by orientation) contains the
trivial representation. The centre imposes n-ality conservation at every link, Σ ±ζ(r_p) = 0 in Ẑ(G). SU(2): half-integer labels form Z₂-cycles
(THE GROUND's Z₂-minimal surfaces). SU(N): Z_N-chains — for SU(3) three fundamental sheets may meet on a link (the baryonic junction; ∫χ₃³ = 1, READ
in instrument B, entering c₃ at order β²). TRIVIAL CENTRE: no homological constraint; the fusion rules alone decide — G₂'s 7 has 7^{⊗3} ∋ 1
(∫χ₇³ = 1, READ), E₈'s 248^{⊗3} ∋ 1 (the structure constants): the leading-order polymers include BRANCHED 2-complexes. The closing-tree count
N(F) ≤ 5^{F−1} of Z₂-minimal sets must be re-derived for Z_N-chains and for fusion-minimal complexes.
(b) SURFACE WEIGHTS. A branch-free closed orientable surface carrying ρ with consistent orientation weighs a_ρ^F d_ρ^{χ(S)} (every link integral
∫χ_ρ(XU)χ_ρ(U⁻¹Y)dU = χ_ρ(XY)/d_ρ; every vertex a trace) — SU(2): u^F2^χ; for self-dual ρ non-orientable surfaces also contribute, with the
Frobenius–Schur sign (Drouffe–Zuber, LITERATURE); for complex ρ (SU(N ≥ 3)) only consistently oriented surfaces at the leading representation.
Leading coefficients (§7.5, PROVED): a_ρ = β(1 + ε_ρ)/(2d_ρ²) + O(β²) — SU(3) β/18 (instrument B 5.55602·10⁻⁵ at 10⁻³), G₂ β/49
(2.04096·10⁻⁵), E₈ β/248².
(c) PROPOSITION X_G (THE CROSSING LAW FOR EVERY G; PROVED). For compact simple G and irreducible ρ with the adjoint appearing once in ρ ⊗ ρ̄,
  ∫∫χ_ρ(xyx⁻¹y⁻¹)χ_adj(x)χ_adj(y)dxdy / ∫∫χ_ρ(xyx⁻¹y⁻¹)dxdy = 1 − h^∨/(2C₂(ρ)).
PROOF. (1) ∫ρ(x)Bρ(x)⁻¹dx = (tr B/d_ρ)·1, so the denominator is (1/d_ρ)∫|χ_ρ|² = 1/d_ρ. (2) By Schur, ∫χ_adj(x)ρ(x)Bρ(x)⁻¹dx = P(B)/d_adj with P
the projector onto the adjoint component of End(V_ρ) ≅ ρ ⊗ ρ̄, P(B) = Σ_aT^a tr(T^aB)/T_ρ (multiplicity one); so the x-integral of the numerator's
integrand is (1/(d_adjT_ρ))Σ_a|tr(T^aρ(y))|² (T^a Hermitian, ρ(y) unitary). (3) Σ_a∫χ_adj(y)|tr(T^aρ(y))|²dy = tr(Φ∘P)/d_adj, where under
End(V) ≅ V ⊗ V̄ the operator Σ_aT^a ⊗ T̄^a is Φ(B) = Σ_aT^aBT^a, which acts on span{T^b} as the scalar C₂(ρ) − ½C_A (the identity
T^aT^bT^a = (C₂(ρ) − ½C_A)T^b); so it equals C₂(ρ) − ½h^∨. (4) The ratio is d_ρ(C₂ − ½h^∨)/(d_adjT_ρ) = 1 − h^∨/(2C₂), by T_ρd_adj = C₂d_ρ. ∎
CHECK: SU(2), ρ = ½: 1 − 2/(2·¾) = −1/3 — the S1 page's ∫χ_½([x,y])χ₁(x)χ₁(y) = −1/6 against ∫χ_½([x,y]) = ½ (READ, line 257). VALUES (instrument A,
exact): SU(3) −1/8; G₂ 0; F₄ 1/4; E₆ 4/13; E₇ 7/19; E₈ 1/2; Sp(2) −1/5; Spin(7) vector 1/6. G₂ IN ITS 7 HAS CROSSING RATIO ZERO: two crossing
adjoint walls on a 7-sheet cancel exactly.
READING: the S1 page's vertex table "is the sl₂ weight system" (READ, line 291); for general G it is the Lie-algebra weight system W_{g,ρ} on chord
diagrams (Bar-Natan 1995, Kontsevich — LITERATURE), whose two-chord crossing ratio is Proposition X_G. For sl₂ the weight system factors through the
intersection graph (the S1 page's (b)); for other g it does not in general (Chmutov–Duzhin–Lando — LITERATURE): the table must be recomputed per group
as a table of chord-diagram weights, not of intersection graphs.
(d) WHAT GENERALISES VERBATIM: the finite family of vertex stars (lattice geometry: simple subgraphs of K_{2,2,2,2} on the eight directions); Lemma R's
realigned operator-norm inequality (block Cauchy–Schwarz); the Kotecký–Preiss tree bound; the gap from clustering (Theorem 7.1). WHAT MUST BE
RECOMPUTED: a_r(β) over Ĝ; the admissible class and its count; the lone-wall constant (SU(2)'s 3a₁; d_adj a_adj at leading order if S7's identity
uses Schur orthogonality alone — to be re-derived); the star integrals r_v with G's intertwiners; Lemma S12_G for branched contact leaves; the
certificate per group.
STATUS: Theorem 8.9 is PROVED-FOR-SU(2)-ONLY (and conditional on S12's remainder); for every other G it is OPEN, with its statement form (polymer
convergence, uniqueness, clustering, gap for β ≤ β*_{8.9}(G), conditional on S12_G), its G-blind parts and its G-dependent inputs as above.

VERDICT ON LINK (3): a strong-coupling gap with an explicit threshold is PROVED for every compact G (S_D: β < 0.0556, G- and ρ-uniform), and
PROVED GIVEN Shen–Zhu–Zhu's argument at the G-universal 't Hooft threshold λ > 96 (S_BE, its two G-inputs computed here and checked against both
of their stated groups); Theorem 8.7 generalises in form with a positive threshold for every G and its numbers are SU(2)-only; Theorem 8.9 is
SU(2)-only, with the general gas's structure (admissibility by the centre or by fusion, surface weights, the crossing law 1 − h^∨/(2C₂(ρ)), the
weight-system vertex table) fixed here.

