
## 6. HYPOTHESIS II

Notation of THE GROUND §8.3: blocks B_y of side a_c, a block map (v_y, φ_y), the blocked measure λ_j (law of v), the fibre
ν_j(·|v), F(v) = ν_j(f|v), δ_y(F) the oscillation of F under changes of v_y alone, S(f) the blocks f reads, N(f) = |S(f)|.

### 6.1 What Theorem 8.5's proof consumes (proved, by reading the proof)

PROPOSITION 6.1. Theorem 8.5 holds verbatim with Hypothesis II(a) replaced by its λ_j-average,
  (II.a-avg)  |λ_j(Cov_{ν_j}(f, g | ·))| ≤ K′N(f)‖f‖‖g‖ρ′^d   for all bounded f, g, at every rung j ≥ j₀,
and Hypothesis II(b) kept.
PROOF. In the proof of Theorem 8.5 (THE GROUND §8.3) Hypothesis II(a) enters once, in the bound of the second term of the
covariance split, μ_j(fg) − μ_j(f)μ_j(g) = [λ_j(FG) − λ_j(F)λ_j(G)] + λ_j(ν_j(fg|·) − FG), and that term IS λ_j(Cov_{ν_j}(f, g|·)).
Hypothesis II(b) enters in the first term through δ_i(F) and δ_y(G) inside Dobrushin's comparison theorem, which takes a
supremum over conditionings. Nothing else uses Hypothesis II. ∎
CONSEQUENCE. "For every coarse configuration" is consumed only by II(b), and only because Dobrushin's comparison theorem
takes suprema. An L² or entropy form of the comparison (proof agent M2's piece) sets the form of II(b) it needs; §6.7 states the
forms derived here so the two halves can meet.

### 6.2 The block map must be ultraviolet-stable (NEW HERE; proved at the Gaussian level; computed)

THE PAPER'S EXAMPLE MAP — one SU(2) element per coarse link, the holonomy of the block along a fixed path (§8.3) — has coarse
variables whose law tends to Haar measure along the asymptotically free sequence, so it makes Hypothesis I trivial and puts the
whole problem into Hypothesis II.

PROPOSITION 6.2. Four-dimensional lattice gauge field, Gaussian (abelian, or one colour component of SU(2)'s one-loop
fluctuation), covariance g²(−Δ)⁻¹δ_{μν} (Feynman gauge; every quantity below is gauge invariant), coarse scale a_c = nε.
(i) PATH. The flux Φ_path through an n×n square (the coarse plaquette's angle for the path map) has
  Var(Φ_path) = g²[4G₃(0)·n + o(n)],   4G₃(0) = 4Σ_{m∈ℤ}G₄(me₁) = 1.0109240394 (Watson's integral),
and the explicit lower bound Var(Φ_path) ≥ g²(4G₄(0)n − 4C) for all n, G₄(0) = 0.1549333902.
(ii) AVERAGED. If each coarse link is the average over the n³ parallel fine paths of its block (the simplest Bałaban-type
average), the coarse plaquette angle has Var(Φ_avg) → g²v_∞ with v_∞ finite (read: 0.1865).
(iii) ALONG THE SEQUENCE g_YM² = 4/(x_c + 8b₀ ln n): g²Var(Φ_path) → ∞, so E[e^{iqΦ_path}] = e^{−q²Var/2} → 0 for every q ≠ 0 —
the path holonomy equidistributes (for SU(2) at one loop every colour component's variance diverges and every character's mean
tends to zero); while g²Var(Φ_avg) → 0 like 1/ln n — the averaged variable is a weak-coupling variable.
(iv) The averaged variable over a one-parameter transverse family has variance ~ ln n (the borderline case).
PROOF. (i) Var(Φ_path)/g² = Σ_{ℓ,ℓ′ ∈ ∂S} σ_ℓσ_ℓ′δ_{μ_ℓμ_ℓ′}G₄(x_ℓ − x_ℓ′) (σ the orientation). Perpendicular sides do not couple
(δ_{μμ′}); each side with itself gives S_n := Σ_{i,j<n} G₄((i − j)e₁) = nG₄(0) + 2Σ_{m=1}^{n−1}(n − m)G₄(me₁); opposite sides give
−T_n, T_n := Σ_{i,j<n}G₄((i − j)e₁ + ne₂). So Var/g² = 4(S_n − T_n). G₄ > 0 gives S_n ≥ nG₄(0); and T_n ≤ nΣ_m G₄(me₁ + ne₂) =
nG₃(ne₂) ≤ C (Fourier: summing G₄ along a line gives the 3D Green function, which decays like 1/(4π|x|)), so Var/g² ≥
4nG₄(0) − 4C. By dominated convergence (G₄(me₁) ~ 1/(4π²m²) is summable), S_n/n = Σ_{|m|<n}(1 − |m|/n)G₄(me₁) →
Σ_m G₄(me₁) = G₃(0), and T_n/n → 0: Var/(g²n) → 4G₃(0). (ii) In Fourier variables Var(Φ_avg)/g² = ∫d⁴k/(2π)⁴ Σ_μ|ĥ_μ(k)|²/k̂²
with ĥ₁(k) = n⁻³Π_ν D_n(k_ν)·(1 − e^{ik₂n}), D_n(q) = Σ_{s<n}e^{iqs}; substituting k = q/n, n⁻³D_n(q_ν/n)·… converges to
n·Π_ν φ(q_ν)·(1 − e^{iq₂}), φ(q) = (e^{iq} − 1)/(iq), k̂² → |q|²/n², d⁴k = d⁴q/n⁴, so the integrand converges to
|Π_νφ(q_ν)|²|1 − e^{iq₂}|²/|q|², dominated by C Π_ν min(1, 4/q_ν²)·|q|^{−2}·min(4, q₂²), integrable on ℝ⁴: the limit
v_∞ = 2∫d⁴q/(2π)⁴ |Π_νφ(q_ν)|²|1 − e^{iq₂}|²/|q|² is finite. (The linearised coarse variable lies in H⁻¹(ℝ⁴), the dual of the
free field's Cameron–Martin space; a line does not — its transverse Fourier transform does not decay, ∫d³k_⊥/k² diverges
linearly.) (iii) Gaussian characteristic functions; for SU(2), E[χ_j(exp(iΦ·σ/2))] = E[sin((2j+1)|Φ|/2)/sin(|Φ|/2)] → 0 as
the per-component variance → ∞, for every j ≥ ½. (iv) The same Fourier count with two undamped transverse directions:
∫d²k_⊥/k² ~ ln n. ∎
THE RECORD (§3, run of record `blockmap_run.2026-11-02c.txt`): Var_path/(g²n) = 0.5000, 0.6847, 0.8154, 0.8960, 0.9447, 0.9734,
0.9900, 0.9994 at n = 1, 2, 4, …, 128, fit 1.010921 n − 0.2024 ln n − 0.498 against 4G₃(0) = 1.0109240; Var_avg/g² = 0.5000,
0.2881, 0.2162, 0.1945, 0.1885, 0.1870, 0.18662, 0.18652; Var_1dir/g² rising 0.437 per doubling; n = 1 meets 2/d = 0.5 exactly.
CONSEQUENCE FOR THEOREM 8.5. With the path map the coarse variables carry, in the limit, no information about any smooth
observable: the correlation of Φ_path with a smeared field ⟨h, A⟩ is bounded while Var(Φ_path) → ∞, so their correlation
coefficient → 0 and the fibre law of every smooth observable tends to its unconditional law. Hypothesis I then holds trivially
(Haar coarse variables) and Hypothesis II(a) at scale a_c IS the clustering of the full measure at scale a_c — the gap itself.
The reduction is content-free for that map. With an averaged (ultraviolet-stable) map the coarse variables carry the field at
coupling g_c and the fibre carries the fluctuations below a_c: THE BLOCK MAP OF THEOREM 8.5 MUST BE ULTRAVIOLET-STABLE —
Bałaban's averaging (CMP 109 (0.3)–(0.4), centred, contours over the block) is the natural one, and its linearisation is the
H⁻¹ case of (ii). (Theorem 8.5 itself is correct for any block map; this is a statement about which maps make its
hypotheses mean what they are meant to mean.)

### 6.3 Where the scales are, and the tower (proved)

REMARK 6.3 (the scale of Hypothesis I). Hypothesis I is a Dobrushin condition on the coarse variables: Σ_{y′} sup‖λ(·|v) −
λ(·|v′)‖_TV e^{κ|y−y′|} ≤ α < 1. With ultraviolet-stable coarse variables at an effective coupling where Bałaban's estimates
hold (β_eff ≥ β_UV = 1/γ² ≫ 1) the conditional law of a coarse link is concentrated at width g_eff around its staple-determined
value, a change of a neighbour moves it by O(1), the TV is near one and the row sum near 18: Hypothesis I FAILS there. It can
hold only past the crossover (β_eff in the strong-coupling disk, THE GROUND §8.1). So the a_c of Theorem 8.5 sits at the window's
exit, and Hypothesis II at a_c covers every scale below it — the ultraviolet half (cutoff → a_UV) AND the window
(a_UV → a_c: the ≈ 260-step perturbative tail and the 2–4 crossover steps, the far shore §1). THE GROUND's sentence
"Hypothesis II is the ultraviolet half of the chain at the scales below a_c" is therefore true only with the window included.

THEOREM 6.3 (the tower; the two halves of Hypothesis II separate). Let the block maps be nested: coarse variables w at a_UV, v
at a_c, with v = Π(w) a function of w (Bałaban's iterated average has this property). Let κ(dw|v) be the window fibre (the law
of w given v), ν_UV(·|w) the ultraviolet fibre, F_UV(w) = ν_UV(f|w). Then ν_c(·|v) = ∫ν_UV(·|w)κ(dw|v), and for bounded f, g
  Cov_{ν_c}(f, g | v) = ∫ Cov_{ν_UV}(f, g | w) κ(dw|v) + Cov_κ(F_UV, G_UV | v),
  λ_c(|Cov_{ν_c}(f, g | ·)|) ≤ λ_UV(|Cov_{ν_UV}(f, g | ·)|) + λ_c(|Cov_κ(F_UV, G_UV | ·)|).
Hence (II.a-avg) at a_c holds with ρ′ = max(ρ_UV^{a_c/a_UV}, ρ_W) if (II.a-avg) holds for the ultraviolet fibre with rate ρ_UV
per a_UV-block and the window fibre satisfies λ_c(|Cov_κ(F, G|·)|) ≤ K_W N‖f‖‖g‖ρ_W^{d} (d in a_c-blocks) for the fibre means
F = F_UV, G = G_UV — functions of w that are quasi-local by the ultraviolet II(b).
PROOF. The tower property of conditional expectation (v is w-measurable) gives the first identity; the second is the law of
total covariance applied under ν_c(·|v) with the intermediate σ-field σ(w); the third takes absolute values and integrates
against λ_c, using λ_c ∘ κ = λ_UV. The rates: a distance d in a_c-blocks is d·a_c/a_UV in a_UV-blocks. ∎
SO: Hypothesis II at a_c = [the ultraviolet fibre's clustering, §6.4–6.5, this agent's piece] ⊕ [the window fibre's clustering
for quasi-local functions, the crossover's piece, the fibre-level partner of Hypothesis I]. The same composition carries
II(b) through the window by Theorem 8.5's own comparison argument run inside κ (TowerChain.lean's shape).

### 6.4 The Gaussian core holds for EVERY coarse configuration (proved; the decay inputs classical)

THEOREM 6.4. Let μ_G be a centred Gaussian on ℝ^N with covariance C, and Q : ℝ^N → ℝ^m linear and surjective. For EVERY v the
fibre ν_G(·|v) is N(Hv, Γ) with H = CQᵀ(QCQᵀ)⁻¹ and Γ = C − CQᵀ(QCQᵀ)⁻¹QC — the covariance does not depend on v. Hence:
 (a) bounded f(φ_A), g(φ_B): |Cov_{ν_G}(f, g | v)| ≤ r(A, B)‖f‖‖g‖ for every v, where r(A, B) is the largest canonical correlation
   of N(0, Γ) between the coordinates in A and in B (Gebelein's inequality; for Gaussian vectors the maximal correlation equals
   the largest canonical correlation, Kolmogorov–Rozanov) — independent of v;
 (b) F(v) = E f(Hv + ζ), ζ ~ N(0, Γ); for v, v′ differing at y, |F(v) − F(v′)| ≤ ‖f‖·TV(N((Hv)_A, Γ_AA), N((Hv′)_A, Γ_AA)) ≤
   ½‖f‖·‖(H(v − v′))_A‖_{CM(A)}, the Cameron–Martin norm of the shift for the marginal on A (the energy of its minimal extension in
   ker Q);
 (c) BLOCK-MARKOV REDUCTION. If Q is block-diagonal (each Q_y reads only block y — block averages, Bałaban's averages) and the
   precision C⁻¹ is nearest-neighbour, then ζ = φ − Hv decomposes as (ζ_y)_y with ζ_y ∈ ker Q_y independent coordinates and a
   quadratic form coupling only adjacent blocks: ζ is a Gaussian Markov field on the block lattice. For block sets A, B and
   disjoint separating shells S₁, …, S_L between them, the maximal correlation is submultiplicative along the Markov chain
   (E[f(X)g(Z)] − EfEg = E[(E[f|Y] − Ef)(E[g|Y] − Eg)] ≤ r(X, Y)r(Y, Z)‖f − Ef‖₂‖g − Eg‖₂), so
   r(A, B) ≤ r₁^{⌊L/2⌋}, r₁ := sup of the maximal correlation between two shells separated by one shell of blocks.
PROOF. Gaussian conditioning (Schur complement) gives N(Hv, Γ) with Γ independent of v; (a) is Gebelein with the
Kolmogorov–Rozanov identification and Var(f|v) ≤ ‖f‖²; (b) is the total-variation bound for two Gaussians with one covariance,
TV = 2Φ(δ/2) − 1 ≤ δ/√(2π), δ the Mahalanobis distance of the shift, restricted to the marginal on A, whose Mahalanobis norm
is the minimal-extension energy; (c): ker Q = ⊕_y ker Q_y because Q is block-diagonal, and the nearest-neighbour form couples
only coordinates of adjacent blocks; the chain inequality is Cauchy–Schwarz with the definition of maximal correlation as the
norm of the conditional-expectation operator on mean-zero functions. ∎
THE INPUTS FOR DECAY, uniform in the cutoff (classical, W = 0): the exponential decay at the block scale of the constrained
propagator Γ and of the minimal-configuration map H with its derivative (Bałaban CMP 95 (1.29)–(1.37), (1.60)–(1.67); the
background versions CMP 99 (3.127)–(3.133)) gives (b) with ‖(H(v − v′))_A‖_{CM(A)} ≤ C e^{−m·dist(y,A)}|v_y − v′_y| and (a) for
linear observables (Cov = ⟨a, Γb⟩); for bounded observables (c) reduces (a) to ONE uniform number, r₁ < 1 (THE GAUSSIAN LAYER
LEMMA, NAMED: the block-constrained free field's shells separated by one block are not perfectly correlated, uniformly in the
cutoff; in the flat-slab case it is a transfer-matrix bound per transverse momentum that the alias-sum symbol of CMP 95
(1.61)–(1.66) makes computable).
WHAT THE THEOREM SAYS. At the Gaussian level "for every coarse configuration" costs nothing: the fibre's fluctuations do not
see v, and v enters only through the mean Hv, whose dependence on a distant v_y decays with H. Every obstruction to the sup form
of Hypothesis II is therefore NON-GAUSSIAN: it is the background dependence of the fluctuation operator — exactly what CMP 99
controls only for small background curvature (|∂U − 1| < ε₀).

### 6.5 The ultraviolet fibre from Bałaban's structure, conditional on ONE named object (proved given (S))

THE OBJECT (S) — BAŁABAN'S THEOREM 1 WITH LOCAL INSERTIONS. For bounded gauge-invariant observables f₁, …, f_m of the fine field,
f_i reading the a_UV-blocks A_i, and complex s with |s_i|‖f_i‖ ≤ s₀, the effective density with insertions
ρ(w; s) := ∫dU δ(Q_K(U) − w) e^{−S_W(U)} Π_i e^{s_i f_i(U)} has
  log ρ(w; s) − log ρ(w; 0) = Σ_X E(X; w, s),
X connected sets of a_UV-blocks meeting ∪A_i, E(X; ·, ·) analytic in s, independent of s_i unless X ∩ A_i ≠ ∅, depending on w
only near X, with |E(X; w, s)| ≤ C₀(1 + |X ∩ Z(w)|)e^{−κd_w(X)}, where Z(w) is the large-field set of w and d_w the tree length of
X with the blocks of Z(w) given length zero; constants uniform in K and in the trajectory. Beside it, Bałaban's own large-field
suppression in Peierls form, (P_LF): λ_UV(Z(w) ⊇ Z) ≤ e^{−p|Z|} for every set Z of blocks, p ≥ p₀(g) − O(1) (from the large-field
factors and the bounds (0.1) of LFR II).

THEOREM 6.5. Assume (S) and (P_LF), with κ and p large compared with the entropy constant of connected sets (Bałaban's κ ≥ κ₀,
and p₀(g) → ∞ as γ → 0). Then for bounded f, g reading A, B (d = d(A, B) in a_UV-blocks):
 (a) for every w: |Cov_{ν_UV}(f, g | w)| ≤ C N(f)‖f‖‖g‖ Σ_{X ⊇ A∪B-connecting}(1 + |X ∩ Z(w)|)e^{−κd_w(X)}; on the small-field set
   (Z(w) = ∅) this is ≤ C′N(f)‖f‖‖g‖e^{−κ′d}, κ′ = κ − κ_ent — the SUP FORM OF II(a) ON THE SMALL-FIELD SET;
 (b) averaged: λ_UV(|Cov_{ν_UV}(f, g | ·)|) ≤ C″N(f)‖f‖‖g‖e^{−κ″d}, κ″ > 0 — (II.a-avg) FOR THE ULTRAVIOLET FIBRE;
 (c) the fibre mean F(w) = ν_UV(f|w): δ_y F(w) ≤ C N(f)‖f‖e^{−κ′d_w(y, A)}·(polynomial in the large-field sizes met), and
   ‖δ_y F‖_{L^q(λ_UV)} ≤ C_q N(f)‖f‖e^{−κ_q d(y, A)} for every q < ∞ — II(b) in the sup form on the small-field set and in every L^q.
PROOF. ρ(w; s)/ρ(w; 0) = ν_UV(e^{Σ s_i f_i} | w), so Cov_{ν_UV}(f, g|w) = ∂_{s₁}∂_{s₂} log ρ(w; s)|_{s=0} and F(w) =
∂_{s₁} log ρ(w; s)|_{s=0}. By (S) only the X meeting both A and B (resp. meeting A and containing y, for (c)) contribute;
Cauchy's inequality on the polydisc |s_i| ≤ s₀/‖f_i‖ bounds each derivative by C₀(1 + |X ∩ Z(w)|)e^{−κd_w(X)}‖f‖‖g‖/s₀², and the
number of connected X containing a given block with d(X) = n is ≤ e^{κ_ent n}: this is (a) and (c) pointwise. For (b) and the
L^q form of (c): the minimal tree joining A to B has length ≥ d; under (P_LF) the probability that m of its n blocks lie in Z(w)
is ≤ C(n, m)e^{−pm}, so E_λ[(1 + |Z|)^r e^{−κ′d_w}] ≤ Σ_{n≥d} e^{κ_ent n}Σ_m C(n,m)e^{−pm}e^{−κ′(n − m)}(1 + m)^r ≤
C Σ_{n≥d}(e^{κ_ent}(e^{−κ′} + e^{−p}))^n·n^r, geometric once e^{κ_ent}(e^{−κ′} + e^{−p}) < 1. ∎
WHAT IS PROVED AND WHAT IS NOT. The derivation of II from Bałaban's small-field/large-field structure is complete GIVEN (S); (S)
itself is not in Bałaban's papers (his J is a background variable, paired with the averaging's second-order term in the
fluctuation form, CMP 99 (3.127)–(3.128) and CMP 109 (1.5) as the record reads them — not an external source), and is the
extension the four-dimensional zeroth draft (THE GROUND §6) attempts. The sup form over ALL w does not follow: a large-field set
connecting A to B carries no decay, and nothing bounds the fibre's correlations across it (§6.8).

### 6.6 Hypothesis II can be exchanged for a density statement (NEW HERE; proved)

PROPOSITION 6.6. Let the block map be ultraviolet-stable and let Hypothesis I hold at a_c with constants uniform in the rung j.
(i) For coarse observables f(v), g(v) (functions of the coarse variables), |λ_j(fg) − λ_j(f)λ_j(g)| ≤ K N(f)N(g)‖f‖‖g‖e^{−κd}/(1 − α)
   with no fibre clause at all (in Theorem 8.5's proof F = f and Cov_ν(f, g|v) = 0).
(ii) Every limit point S of the construction has, on the closed span H_c of the vectors [f] − S(f)Ω created by coarse observables
   of every block lattice shifted by u ∈ ∪_j a_jℤ⁴ (positive time, at least one block above the reflection plane), a unique
   vacuum and no spectrum in (0, κ/a_c).
(iii) If H_c is dense in Ω^⊥ (THE DENSITY STATEMENT (D)), the full Hamiltonian of the limit has no spectrum in (0, κ/a_c) and the
   vacuum is unique. Hypothesis II is then not needed.
PROOF. (i) Theorem 8.5's proof with F = f, G = g. (ii) Each shifted block lattice (u ∈ a_jℤ⁴) has a blocked measure equal in law to
a translate of λ_j (the rung-j lattice is invariant under a_jℤ⁴), so Hypothesis I and (i) hold for it with the same constants. A
coarse observable's time translates by t ∈ a_cℕ are coarse observables of the same block lattice, so (i) gives
S_j(θf̄·τ_t f) − |S_j(f)|² ≤ C_f e^{−κt/a_c} for t ∈ a_cℕ, uniformly in j, and in the limit. For ψ_f := [f] − S(f)Ω, the spectral
measure μ_ψ of H satisfies ∫e^{−tλ}dμ_ψ(λ) ≤ C_f e^{−κt/a_c} along t → ∞ in a_cℕ, hence μ_ψ([0, κ/a_c − δ]) ≤ C_f e^{−δt} → 0 for every
δ > 0: E([0, κ/a_c))ψ_f = 0. By linearity E([0, κ/a_c)) vanishes on span{ψ_f} and by continuity on its closure H_c. (iii) If
H_c = Ω^⊥, E([0, κ/a_c)) = 0 on Ω^⊥: no spectrum in (0, κ/a_c), and E({0}) is the projection on Ω. ∎ No covariance between
observables of different shifts is ever needed, and the time set a_cℕ suffices because only an unbounded set of times is.
WHAT (D) IS. A statement about each limit theory, not an estimate uniform in the cutoff: that functions of the fields smeared at
the fixed scale a_c, at a dense set of positions, generate the physical Hilbert space. In the free field it holds iff the smearing
symbol is non-zero almost everywhere on the spectral support (Wiener's Tauberian condition; the block-average symbol vanishes
only on the hyperplanes k_μ ∈ (2π/a_c)ℤ \ {0}, a null set on every mass shell). For the interacting limit it is OPEN; it is the
time-slice/Reeh–Schlieder kind of statement, part of what (E) must deliver. So the chain has two bridges from coarse to fine
observables: Hypothesis II (uniform fibre clustering) or (D) (density in the limit). Either suffices for the gap.

### 6.7 The forms handed to the measure-weighted crossing (proof agent M2) — so the two halves meet

 FORM α (THE GROUND's, sup in both clauses): NOT derivable from Bałaban's structure (§6.8).
 FORM β (what is derived here from (S) + (P_LF)): II(a) averaged, (II.a-avg); II(a) and II(b) in sup form ON THE SMALL-FIELD
   SET; II(b) pointwise in the large-field-shortened distance d_w. Theorem 8.5 as written consumes (II.a-avg) ✓ and sup-II(b)
   ✗ — the comparison theorem must be told about the large-field set.
 FORM γ (its averages): ‖δ_y F‖_{L^q(λ)} ≤ C_q N(f)‖f‖e^{−κ_q d(y, S(f))} for every q < ∞, and (II.a-avg). This is what an L² or
   entropy comparison theorem for the blocked measure can consume: the influence of v_y on a fibre mean measured in L^q(λ).
 FORM δ (none at all): coarse observables need only Hypothesis I; the gap then needs (D).
THE MEETING POINT, stated for M2: if the measure-weighted Theorem 8.5 bounds |Cov_λ(F, G)| by Σ_{i,y} I_i(F)D(i, y)I_y(G) with
I_y(F) an L^q(λ)-influence and D exponentially decaying, then FORM γ is the ultraviolet half's deliverable, conditional on (S); if
it consumes only coarse observables, FORM δ, conditional on (D).

### 6.8 Why the sup form exceeds the ultraviolet half (the obstruction, located)

Bałaban's variational theorem asserts the background only for regular averages: CMP 102 [15] Theorem 1 (p. 279, read on disk):
"for an arbitrary configuration V satisfying (7) with ε ≤ α₀ there exists a minimal orbit … This orbit is a unique critical
orbit", (7) the small-field regularity condition; CMP 99's background propagators need |∂U − 1| < ε₀. A coarse configuration
with large curvature has neither. The extreme datum exists: v_μ = iσ_μ (μ = 1, 2, 3), v₄ = 1 gives every spatial coarse plaquette
the holonomy (iσ_μ)(iσ_ν)(iσ_μ)⁻¹(iσ_ν)⁻¹ = (−iσ_ρ)(−iσ_ρ) = −1 (μ, ν, ρ distinct): the maximally frustrated datum, a
crystal of centre vortices. For it the curvature π per coarse plaquette is spread over L^{2m} plaquettes of scale K_c − m, below
ε₀ only for m ≥ m₀ = ⌈log_L(π/ε₀)/2⌉: the last m₀ steps (a number fixed by ε₀, independent of the cutoff) see an O(1) background
curvature, where no published estimate controls the fluctuation operator's spectrum, let alone its block-scale decay; and by
Theorem 6.4 the Gaussian part of the fibre is blind to v, so whatever fails there is the background dependence of the
fluctuation operator. The averaged forms need only that such data are RARE (P_LF), which Bałaban's large-field analysis supplies.
