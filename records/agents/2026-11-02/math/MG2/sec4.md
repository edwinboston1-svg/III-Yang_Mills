
## 4. THEOREM 8.7 FOR EVERY COMPACT G — THE PROOF, STEP BY STEP, WITH EVERY SU(2)-ONLY FACT NAMED AND REPLACED

### 4.0 Setting (PROVED; MG §6.4's dictionary made exact)

G compact, ρ a faithful irreducible unitary representation of dimension d, plaquette weight exp((β/d) Re χ_ρ(U_p)) on ℤ⁴ (β = κ_ρ/g²_YM).
E := span_ℝ ρ(G) ⊂ End(ℂ^d), ⟨A, B⟩ := Re tr(A†B), n := dim_ℝ E; u(U) := ρ(U)/√d, a unit vector of E (‖ρ(U)‖² = tr 1 = d).
E is a real *-algebra: ρ(g)ρ(h) = ρ(gh) and ρ(g)† = ρ(g⁻¹); so M ↦ ρ(a)Mρ(b) and M ↦ M† are linear isometries of E, and u(U⁻¹) = u(U)†.
(β/d) Re χ_ρ(U_a S) = β⟨u(U_a), u(S⁻¹)⟩ (since Re tr(ρ(S)ρ(U_a)) = ⟨ρ(S)†, ρ(U_a)⟩). For unit e ∈ E put X_e(U) := ⟨u(U), e⟩; |X_e| ≤ 1.
n = d² for ρ of real or quaternionic type, n = 2d² for complex type: by Burnside span_ℂ ρ(G) = End(ℂ^d); the real algebra span_ℝ ρ(G) is a
real form of it (M_d(ℝ) or M_{d/2}(ℍ), real dimension d²) exactly when ρ ≅ ρ̄, and is M_d(ℂ) itself (real dimension 2d²) when ρ ≇ ρ̄ (a real
form would make ρ equivalent to its conjugate).

### 4.1 LEMMA I (ISOTROPY OF HAAR ON E; every compact G, every irreducible ρ) — PROVED

E_Haar[X_e] = 0 and E_Haar[X_eX_f] = ⟨e, f⟩/n for all e, f ∈ E.
PROOF. ∫ρ(U)dU = 0 (ρ nontrivial irreducible), so E X_e = 0. C(e, f) := E[X_eX_f] is a symmetric bilinear form on E invariant under the action
(a, b)·M = ρ(a)Mρ(b)⁻¹ of G × G (Haar measure is bi-invariant). E is an irreducible real representation of G × G: for complex type, E = End(V)
realified, and V ⊠ V* is a complex irreducible representation of G × G not isomorphic to its conjugate V̄ ⊠ V̄* (the first factors differ),
so its realification is irreducible over ℝ with commutant ℂ; for real or quaternionic type E is a real form of V ⊠ V* (of real type as a
G × G representation: real ⊠ real or quaternionic ⊠ quaternionic), absolutely irreducible, commutant ℝ. An invariant symmetric form is ⟨·, K·⟩
with K self-adjoint in the commutant; in the complex case K = a + bJ (J = multiplication by i) and self-adjointness forces b = 0
(⟨M, iN⟩ = −⟨iM, N⟩). So C = c⟨·,·⟩, and c·n = Σ_i E X_{e_i}² = E|u|² = 1. ∎
THE SU(2)-ONLY FACT IT REPLACES — F1 (Z radial, SO(4) transitive on S³). For general G, Z(w) := ∫e^{⟨u,w⟩} is only G × G-invariant and depends on
the orbit of w (SU(N): the singular values and the phase of det; G₂ on M₇(ℝ): a 21-parameter orbit space); its SECOND-ORDER structure at Haar
is still exactly isotropic, and that is what the proof uses at the base point.

### 4.2 THEOREM 8.7_G — statement (PROVED below)

For the one-link exponential family ν_w(dU) = e^{⟨u(U), w⟩}dU/Z(w), w ∈ E, with mean μ(w) = E_w u, covariance Σ_w and third cumulant
κ₃^w(h₁, h₂, h₃) = E_w Π_i (X_{h_i} − E_w X_{h_i}), define the five constants of a radius r:
  μ̄(r) := sup_{|w|≤r} |μ(w)|,   s̄(r) := sup_{|w|≤r} ‖Σ_w‖_op,
  D̄(r) := sup_{|w|≤r} osc_{g∈G} ⟨u(g), Σ_w u(g)⟩   (the anisotropy along the group's orbit),
  T(r) := sup_{|w|≤r, g∈G} |κ₃^w(u(g), u(g), u(g))|,   T_x(r) := sup_{|w|≤r; a, g∈G} |κ₃^w(u(a), u(g), u(g))|.
Put ω := 3β²D̄(5β) + 2β³T(6β), ω′ := 12βμ̄(5β) + ω, M := e^{ω′/2}/√n, and
  C_dir := M β μ̄(5β) + ¼(β²D̄(5β) + ⅔β³T(6β)),
  C_med := M β² s̄(5β) + ¼(min(β²D̄(5β), 2β³T_x(5β)) + ⅔β³T(6β)),      α_G(β) := 12 C_dir + 90 C_med.
THEOREM 8.7_G. If α_G(β) < 1, the Wilson theory of (G, ρ) on ℤ⁴ at β has a unique infinite-volume Gibbs measure; for every m₀ < log(1/α_G(β))/2
there is K = K(β, m₀) with |⟨fg⟩ − ⟨f⟩⟨g⟩| ≤ K N(f)N(g)‖f‖‖g‖e^{−m₀d} for bounded f, g of finitely many links (every torus of even side and infinite
volume), and the transfer matrix has a unique vacuum and no spectrum in (0, m₀). (THE GROUND's Theorem 8.7 for (G, ρ); for SU(2) the proof below
with Lemma 8.6 and the sharp one-link MAD in place of the five bounds is THE GROUND's (8.12), re-derived in §3.)

### 4.3 PROOF (THE GROUND's proof read line by line; each step's group content stated)

(a) THE DECIMATION (group-blind). The perfect cover L₁ (one link per plaquette, period two), its complement L₀; the counts 12 (links sharing a
plaquette with x ∈ L₀) and 90 (links in the five other plaquettes of each of the six cover links a_p of x). Given L₀ the cover links are independent
with laws ν_{η(a)}, η(a) = β Σ_{p∋a} u(S_p(a)⁻¹), |η(a)| ≤ 6β; the marginal of L₀ has density Π_a Z(η(a)) (a finite-range Gibbs measure).
(b) THE ISOMETRY (F4 replaced). For x ∈ L₀ and p ∋ x, S_p(a_p) = A U_x^{ε} B with A, B products of the two other L₀-links of p, so
θ_p(U_x) := β u(S_p(a_p)⁻¹) = β L_p u(U_x), L_p the linear isometry M ↦ ρ(B)⁻¹Mρ(A)⁻¹ (ε = −1) or M ↦ ρ(B)⁻¹M†ρ(A)⁻¹ (ε = +1); and
θ_p/β = u(g_p(U_x)), g_p(U_x) := B⁻¹U_x^{−ε}A⁻¹, which runs over ALL of G as U_x does. w_p := η(a_p) − θ_p, |w_p| ≤ 5β. The conditional law of
U_x given L₀ ∖ {x} has density ∝ Π_{p∋x} Z(w_p + θ_p(U_x)) (six distinct cover links).
(c) TAYLOR (group-blind; the constants named). F := log Z has gradient μ, Hessian Σ and third derivative κ₃ (an exponential family). Along the segment
w_p + tθ_p, inside the ball of radius 6β: F(w_p + θ_p) = F(w_p) + ⟨μ(w_p), θ_p⟩ + ½⟨θ_p, Σ_{w_p}θ_p⟩ + R_p with
|R_p| ≤ (1/6) sup_t |κ₃^{w_p+tθ_p}(θ_p, θ_p, θ_p)| ≤ (β³/6) T(6β), because θ_p = βu(g) is β times an ORBIT direction.
(d) THE LINEAR PART: Σ_p ⟨μ(w_p), θ_p⟩ = ⟨u(U_x), v⟩, v := β Σ_p L_p^T μ(w_p), |v| ≤ 6βμ̄(5β).
(e) THE QUADRATIC PART (F5 replaced): ½⟨θ_p, Σ_{w_p}θ_p⟩ = ½β²⟨u(g), Σ_{w_p}u(g)⟩, g = g_p(U_x); its oscillation in U_x is ≤ ½β²D̄(5β).
[SU(2): ⟨θ, Σθ⟩ = (m/r)|θ|² + D⟨θ, ŵ⟩², |θ| = β, oscillation ½β²|D|, and D = O(r²) because every odd moment of a coordinate vanishes at Haar
(−1 ∈ SU(2)). For general G the isotropic part of Σ_w is still constant on the orbit (|u(g)| = 1; Lemma I gives D̄(0) = 0), but the first-order
anisotropy κ₃⁰(w, u(g), u(g)) is NONZERO whenever ρ carries a cubic invariant — SU(3), SO(3), G₂, F₄, E₆, E₈ — so there D̄(r) = O(r), not O(r²).]
So the conditional law of U_x is the tilt of ν_v by h := Σ_p (½⟨θ_p, Σ_{w_p}θ_p⟩ + R_p), with osc h ≤ ω = 6(½β²D̄(5β) + (β³/3)T(6β)).
(f) THE TWO FACTS. (i) A tilt by a function of oscillation o moves total variation by ≤ tanh(o/4) ≤ o/4 (THE GROUND's computation; group-blind).
(ii) (F3 replaced.) For π_t := the tilt of ν_{v_t} by h, v_t = v + t(v′ − v): d/dt π_t(f) = Cov_{π_t}(f, ⟨u, v′ − v⟩), and for 0 ≤ f ≤ 1,
|Cov(f, Y)| = |E[(f − ½)(Y − EY)]| ≤ ½E|Y − EY|; so ‖π₁ − π₀‖_TV ≤ ½ sup_t MAD_{π_t}(X_ê)·|v′ − v|, ê = (v′ − v)/|v′ − v|.
THE REPLACEMENT OF THE SHARP ONE-LINK LEMMA: π_t has density q w.r.t. Haar proportional to e^{⟨u, v_t⟩ + h}, a function of oscillation
≤ 2|v_t| + ω ≤ ω′; so q ∈ [c, ce^{ω′}] with c ≤ 1 (∫q = 1), and MAD_{π_t}(X_ê) ≤ (E_{π_t} X_ê²)^{1/2} ≤ (e^{ω′} E_Haar X_ê²)^{1/2} = e^{ω′/2}/√n = M
by Lemma I. [SU(2): the sharp lemma gives (4/(3π))ρ(ω): 0.4244 against 1/√4 = 0.5 at ω = ω′ = 0.]
(g) THE INFLUENCES. Direct (12 links): L_p changes, v moves by ≤ 2βμ̄(5β) (‖L_p − L_p′‖ ≤ 2), h_p moves by a function of oscillation
≤ β²D̄(5β) + ⅔β³T(6β) (two quadratic parts each of oscillation ≤ ½β²D̄; two remainders each of modulus ≤ β³T/6); by (f), C(x, y) ≤ C_dir.
Mediated (90 links): w_p moves by w′ − w = β(u(a) − u(b)) (two orbit points), |w′ − w| ≤ 2β; v moves by β|L_p^T(μ(w′) − μ(w))| ≤ 2β²s̄(5β)
(the Jacobian of μ is Σ; the ball is convex); the quadratic part moves by ½⟨θ_p, (Σ_{w′} − Σ_w)θ_p⟩, of oscillation ≤ min(β²D̄(5β), 2β³T_x(5β)),
the second because ⟨u(g), (Σ_{w′} − Σ_w)u(g)⟩ = ∫₀¹ κ₃^{w_t}(w′ − w, u(g), u(g)) dt has modulus ≤ 2βT_x(5β), so oscillation ≤ 4βT_x, times ½β²;
the remainder moves by ≤ ⅔β³T(6β). So C(x, y) ≤ C_med. A link in several positions is counted once for each (total variation is subadditive along
a chain of single changes); no other link of L₀ affects the law of U_x; the column sums obey the same count.
(h) CONCLUSION (group-blind): Dobrushin's uniqueness theorem on L₀; the cover links conditionally independent with a fixed law; the clustering
bound by the argument of Theorem 8.5 on one lattice with the links of L₀ as the coarse variables, κ < log(1/α)/2 (coefficients vanish beyond
distance two); reflection positivity with a positive transfer matrix for every compact G (MG's Lemma RP_G) and Theorem 7.1 at integer times. ∎
SU(2)-ONLY FACTS, ALL FIVE, AND WHERE EACH WENT: F1 → Lemma I + the orbit constants; F2 (Lemma 8.6 via Turán) → the five constants of the one-link
family, bounded per group in §4.4–4.6; F3 (the sharp MAD, maximal at Haar) → (f)(ii); F4 (quaternions) → u = ρ/√d in E with Re tr; F5 (odd Haar
moments vanish) → the cubic-invariant terms carried exactly through D̄, T, T_x. The perfect cover, the counts 12 and 90, the tilt fact, Dobrushin,
the clustering argument and RP are group-blind and verbatim.
