# MG2 — THEOREM 8.7 FOR EVERY COMPACT SIMPLE G; SHEN–ZHU–ZHU READ IN FULL; G₂'S WINDOW

Proof agent MG2, 2026-11-02 (desktop; read-only in both repositories; everything in this directory). Appended as the work proceeds;
nothing above a line is edited after it is written except by a dated correction below it. Labels: PROVED (full proof here), CERTIFIED
(evaluated in outward-rounded interval arithmetic on a proved formula), READING (an exact or double-precision computation on a finite
object, not a bound), LITERATURE (cited, read, not re-proved), STAKE (written before the run).

## 0. Sources read before deriving

MATH_BRIEF.md whole. MG/WORK.md whole (§§0–13) and its three records (lie_data_run, coeffs_run, roads_check_run, 2026-11-02a).
THE GROUND (ground_docx.txt): §8.1's one-link lemma (line 238), Propositions 8.1–8.3 statements, the perfect cover (line 327), Lemma 8.6
with proof (328–336), Theorem 8.7 with proof (337–345), the two tilt facts (341), (8.11), (8.12), Table 3 (347–388), the certification
paragraph (389), "the open part" (390), Theorem 8.9's statement (391), [R7] (428). The W2 engines' headers (w2_strip.c, w2_strip_n.c,
lines 1–120) in III STDLIB/build/aperanton/surface-gas. Shen–Zhu–Zhu's LaTeX source, arXiv e-print 2204.12737 (v1, the only version on
arXiv; sha256 c2f61d2e…a949a2 of the gzip), extracted to src_szz/x/ (alphaXiv is not connected; the source is the primary text).

## 1. The plan (deep-think synthesis, before deriving)

THE PROOF OF 8.7 IS FIVE PIECES: (a) the decimation (perfect cover; the cover links conditionally independent; counts 12 and 90);
(b) the exponential family of one cover link, ν_w ∝ e^{⟨u,w⟩}, w ∈ E; (c) Taylor of log Z at the five-plaquette background w_p to second
order, third-order remainder; (d) the linear part's influence priced by a MEAN ABSOLUTE DEVIATION, the nonlinear part's by an OSCILLATION
(tanh(o/4)); (e) Dobrushin. (a), (c), (d), (e) are group-blind. Everything group-specific is in (b): five constants of the one-link family
on balls — the mean μ, the covariance norm s, the anisotropy D (the oscillation over the group's orbit of the covariance's quadratic form),
the third cumulant T, the MAD M. SU(2)-ONLY FACTS USED (to name and replace): F1 Z radial (SO(4) transitive on S³); F2 Lemma 8.6 by
Turán's inequality for I_ν; F3 the sharp one-link MAD lemma (4/(3π), maximal at Haar); F4 the quaternion identification; F5 IMPLICIT —
every odd Haar moment of a coordinate vanishes (−1 ∈ SU(2)), which makes D = O(r²) and m = O(r): FALSE for SU(3), SO(3), G₂, F₄, E₆, E₈,
whose representations carry a cubic invariant (∫χ³ = 1), so their anisotropy is FIRST order in the background.
WHAT REPLACES THEM: E_G = span_ℝ ρ(G) with ⟨A,B⟩ = Re tr(A†B), u = ρ/√d on its unit sphere; THE HAAR COVARIANCE IS I/n ON E_G (n = dim_ℝ E_G
= d² for real or quaternionic ρ, 2d² for complex ρ) — a theorem by Schur's lemma over ℝ, the one structural fact that survives exactly;
the MAD replaced by a standard deviation under a bounded tilt of Haar (isotropy alone); μ, s, D, T bounded on balls by a NEAR-HAAR LEMMA
whose group inputs are n, m₃ = sup|E X³| and m₄ = sup E X⁴ over unit directions (exact or rigorously bounded from the invariant tensors
and the tensor-square decomposition), and |X| ≤ 1. INVERSION (what guarantees failure): carrying F5 to G₂; using a numerical maximum over
directions as a bound; bounds lossy by powers of n. KILL-SWITCH: if the universal bounds give no group a threshold above the SU(2)
value of the same bounds, the per-group numbers need group-specific exact one-link families (SU(N): Bars–Green determinants) and the
general theorem stands with its constants as functionals. ORDER: the SU(2) known answer first (an evaluator sharing no line with THE
GROUND's certificate); then the theorem for every G; then the per-group data and certified thresholds; then Shen–Zhu–Zhu read in full;
then G₂'s window (stake first; the crossover from MG's coefficient instrument; the recoupling data; the two-face object as far as it goes).

## 2. STAKES (written before any instrument of this directory runs; none edited after)

S-1 (SU(2), the known answer). With Lemma 8.6's constants (m(5β) = I₂/I₁, D₅ = m(5β)²/3, T₆ = m(6β)/2, s = 1/4, MAD 4/(3π)) my evaluator
gives α(0.241) = 0.996297 (six digits) and crosses one in (0.241, 0.2415) (THE GROUND's Table 3); with the exact constants |D(5β)| and
|φ‴(6β)| (the largest third cumulant at radius 6β) it stays below one on [0, 0.2452] and crosses above 0.2452 (root UNGUESSED to four
digits beyond that).
S-2 (isotropy). For every compact G and irreducible unitary ρ, E_Haar[u ⊗ u] = I/n on E_G. Checked numerically on SU(2), SU(3), G₂ by
quadrature (READING) beside the proof.
S-3 (the cubic invariant). m₃ = sup_{|e|=1} |E_Haar X_e³| is 0 for SU(2), SU(4), Sp(2), SO(5) (vector), E₇ (56); and nonzero for SU(3) (= 1/108),
SO(3) (vector), G₂ (7), F₄ (26), E₆ (27), E₈ (248).
S-4 (thresholds; UNGUESSED in value). The universal near-Haar bounds give a certified β*_G for every listed group; in Wilson units it
grows with n; in 't Hooft units λ*_G = h^∨κ_ρ/β*_G lies in [15, 300] for every group (UNGUESSED where); for SU(2) the universal
bounds give LESS than 0.2452 (they replace Turán and the sharp MAD); whether they beat MG's Bakry–Émery value β_BE = h^∨κ_ρ/96 is
UNGUESSED per group, predicted YES for SU(N ≤ 5), Sp(2), G₂ and NO for E₈ (the near-Haar regime of the adjoint ends at radius O(d)).
S-5 (Shen–Zhu–Zhu, before reading the body). They prove, for G = SO(N) and SU(N) only, at |β| below their stated thresholds: a
log-Sobolev inequality for the finite-volume Langevin dynamics uniform in the volume, uniqueness of the infinite-volume Gibbs measure,
exponential decay of correlations, and a mass gap in the sense of exponential clustering (not a transfer-matrix spectral statement);
their proof uses the group only through Ric_G and a Hessian bound on Wilson's action (MG's reading, to be checked line by line).
S-6 (G₂'s window). G₂'s crossover lies where its one-plaquette coefficient a₇(β) equals SU(2)'s a_½ at 2.2–2.3 (UNGUESSED β); the G₂
recoupling data needed are the 6j-symbols of 7, 14 with 7 ⊗ 7 = 1 + 7 + 14 + 27 multiplicity-free (THE 7 IS MULTIPLICITY-FREE IN 7 ⊗ 7 —
the trivalent vertex), 7 ⊗ 14 = 7 + 27 + 64, 14 ⊗ 14 = 1 + 14 + 27 + 77 + 77′; whether the two-face reading of (W-S)_{G₂} closes below one
at one step from the crossover is UNGUESSED.

## 3. RESULTS I — THE SU(2) KNOWN ANSWER (records runs/su2_eval_L86.2026-11-02b.txt, runs/su2_eval_exact.2026-11-02c.txt; rc = 0)

Instrument: code/su2_eval.py — mpmath interval arithmetic at 256 bits, outward rounding throughout; I₁, I₂ by their series with a geometric
tail enclosure; the exact constants in THE GROUND's own regular variables (z = r²/4, A = (2/r)²I₂, B = (2/r)I₁, and the Turán series
P(z) = A² − BC = Σ_k (4+2k)!/(k!(4+k)!(2+k)!(3+k)!) z^k, all positive): m = rA/(2B), φ″ = 1/4 − z(A² + 3P)/(4B²), D = −zP/B²,
D/r = −(r/4)P/B², φ‴ = r[(3/4)P/B² − (A/B)φ″] — cross-checked against the Bessel-ratio forms to 12 digits at r = 0.3, 1.0, 1.2, 1.47
(code/su2_check_regular.py). EXACT mode: D₅ = sup_{r ≤ 5β}|D(r)| and T₆ = sup_{r ≤ 6β, c ∈ [0,1]} |φ‴c³ + 3(D/r)c(1 − c²)| by cell
enclosures (600 r-cells; 256 c-cells, the cubic written c(a + b c²), linear in c² per cell). It shares no line with THE GROUND's awk.
- S-1 HELD (Lemma 8.6 constants): α(0.200, 0.220, 0.230, 0.240, 0.241, 0.2415) = 0.6698340, 0.8195540, 0.9011428, 0.9874073,
  0.9962967, 1.0007596 with 12C_dir = 0.3635404, 90C_med = 0.6327563, ω = 0.00937199, ρ(ω) = 1.014124 at 0.241 — Table 3 to every printed
  digit; on the grid of step 10⁻⁴, α < 1 is CERTIFIED at 0.2414 and not at 0.2415 (THE GROUND: "certifies it below one on [0, 0.2414]").
- S-1 HELD (exact constants): CERTIFIED α < 1 at β = 0.2452 (α ∈ 0.99972852…, D₅ = 0.0262396, T₆ = 0.0611999, ω = 0.00653725), NOT at 0.2453.
  THE GROUND: "the same row sum stays below one on [0, 0.2452]". The root lies in (0.2452, 0.2453). (A first EXACT run with naive
  cell enclosures gave T₆ = 0.0637 and failed at 0.2452 — interval dependency, not mathematics; recorded in su2_eval_exact.2026-11-02b.)
- REMARK (read off the run): at radius 6β = 1.47 the largest third cumulant of SU(2)'s vMF law sits at c = 1 (THE GROUND's |φ‴(6β)|),
  since a + b c² with a = 3D/r, b = φ‴ − 3D/r keeps |c(a + bc²)| increasing on [0,1] there.

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

### 4.4 LEMMA NH (THE NEAR-HAAR BOUNDS: the five constants from seven numbers of the group) — PROVED

INPUTS (every one exact or rigorously bounded per group in §4.5): n (Lemma I); for the ORBIT point o := u(1) (by bi-invariance every u(g)
has the same law), X_o = Re χ_ρ/d and t_k := E_Haar X_o^k (k = 3, 4; |t₃| used), o₃ := sup_{|f|=1} |E_Haar X_f X_o²|; for ALL directions
c₃ ≥ sup_{|e|=1} |E X_e³| (= sup over unit triples |E X_eX_fX_g|, Banach's polarization theorem for symmetric forms on a real Hilbert space)
and m₄ ≥ sup_{|e|=1} E X_e⁴ (so E X_e²X_f² ≤ m₄ and E|X_eX_fX_gX_h| ≤ m₄ by Hölder). Write φ_k(r) := Σ_{j≥k} r^j/j!.
CLAIMS, for |w| ≤ r (X_w := ⟨u, w⟩, |X_w| ≤ r, Z(w) ≥ 1 by Jensen):
(NH1) |μ(w)| ≤ μ₁(r) := r/n + ½r²c₃ + φ₃(r)√(m₄/n);   and μ̄(r) ≤ r·s̄(r).
(NH2) s̄(r) ≤ s₁(r) := 1/n + r c₃ + φ₂(r) m₄;   and for an orbit direction E_w X_o² ≤ s₀(r) := 1/n + r o₃ + φ₂(r) m₄.
(NH3) D̄(r) ≤ 2a₁(r) + μ̄(r)²,  a₁(r) := r o₃ + φ₂(r)(m₄ + 1/n²).
(NH4) T(r) ≤ T₁(r) := |t₃| + φ₁(r)√(t₄ m₄) + 3μ̄(r)s₀(r) + 2μ̄(r)³.
(NH5) T_x(r) ≤ √(s₀(r)·Q(r)),  Q(r) := t₄ + φ₁(r)√(t₄ m₄) + 4μ̄(r)(|t₃| + φ₁(r)√(t₄m₄)) + 6μ̄(r)²s₀(r).
PROOFS. (NH1) E_wX_e = E₀[X_e e^{X_w}]/Z and E₀[X_e e^{X_w}] = Σ_j E₀[X_eX_w^j]/j!: j = 0 gives 0, j = 1 gives ⟨e, w⟩/n (Lemma I), j = 2 gives
modulus ≤ ½|w|²c₃, and for j ≥ 3, |E₀X_eX_w^j| ≤ |w|^j E₀[|X_e| X_ŵ²] ≤ |w|^j (E₀X_e² E₀X_ŵ⁴)^{1/2} ≤ |w|^j √(m₄/n) (|X_ŵ| ≤ 1); divide by Z ≥ 1.
The second form: μ(w) = ∫₀¹ Σ_{tw} w dt. (NH2) Var_w X_e ≤ E_wX_e² ≤ E₀[X_e² e^{X_w}] = 1/n + E₀[X_e²X_w] + E₀[X_e² ψ(X_w)], ψ(x) := e^x − 1 − x, and
0 ≤ ψ(x) ≤ (φ₂(r)/r²)x² on |x| ≤ r (ψ(x)/x² = Σ_{j≥2} x^{j−2}/j!); the middle term is ≤ r c₃ (resp. ≤ r o₃ for e = o), the last ≤ φ₂(r)m₄.
(NH3) For orbit e: E_wX_e² − 1/n = E₀[(X_e² − 1/n)e^{X_w}]/Z = (E₀[X_e²X_w] + E₀[(X_e² − 1/n)ψ(X_w)])/Z (the constant term vanishes), of modulus
≤ r o₃ + φ₂(r)E₀[(X_e² + 1/n)X_ŵ²] ≤ a₁(r); so Σ_w(e, e) = E_wX_e² − (E_wX_e)² lies in [1/n − a₁ − μ̄², 1/n + a₁] for every orbit e. (NH4) With
m = E_wX_e, κ₃ = E_wX_e³ − 3mE_wX_e² + 2m³; |E_wX_e³| ≤ |t₃| + E₀[|X_e|³(e^{|X_w|} − 1)] ≤ |t₃| + φ₁(r)E₀[|X_e|³|X_ŵ|] ((e^s − 1)/s increasing),
and E₀|X_e|³|X_ŵ| ≤ (E₀X_e⁴)^{1/2}(E₀X_e²X_ŵ²)^{1/2} ≤ √(t₄m₄). (NH5) |κ₃(u(a), e, e)| = |E_w[Y_aY_e²]| ≤ (E_wY_a²)^{1/2}(E_wY_e⁴)^{1/2} (Y = X − m),
E_wY_a² ≤ s₀; E(X − m)⁴ = EX⁴ − 4mEX³ + 6m²EX² − 3m⁴ ≤ EX⁴ + 4|m||EX³| + 6m²EX², with E_wX_e⁴ ≤ t₄ + φ₁(r)E₀[X_e⁴|X_ŵ|] and
E₀X_e⁴|X_ŵ| ≤ E₀|X_e|³|X_ŵ| ≤ √(t₄m₄) (|X_e| ≤ 1). ∎
WHAT THE LEMMA COSTS (named, not hidden): every remainder carries φ_k(r)·m₄ — the higher Haar moments bounded through |X| ≤ 1 — so the bounds are
sharp only while e^r m₄ ≪ 1/n, i.e. r ≲ log(1/(n m₄)) ≈ log(n/3). The true one-link family stays near Haar far longer for large groups (the
eigenvalue-concentration transition of the one-link integral sits at r of order dim G); certifying that needs Haar moments of matrix
coefficients of all orders at the scale 1/√n — the next object (§4.7).

### 4.5 THE PER-GROUP INPUTS — PROVED (each a finite representation-theoretic computation)

(i) t_k. Real or quaternionic ρ: χ is real and t_k = M_k/d^k, M_k := ∫χ^k = the multiplicity of 1 in ρ^{⊗k}; M₃ = 1 exactly when ρ carries
a cubic invariant, M₄ = Σ_{λ ⊂ ρ⊗ρ} m_λ² = the number of components of ρ ⊗ ρ (multiplicity-free in every case below). Complex ρ:
t_k = 2^{−k} Σ_j C(k, j) ∫χ^j χ̄^{k−j} / d^k, with ∫χ^aχ̄^b = 0 unless the centre's character allows it.
(ii) o₃ = |∫(Re χ)²χ|/d³: for a class function f, ∫f ρ = (1/d)(∫fχ)·1 (Schur), so E₀[X_o² u] = (1/d^{3.5})∫(Re χ)²χ · 1, of norm |∫(Re χ)²χ|/d³
(‖1‖ = √d; for complex type the phase is absorbed by e^{iθ}1 ∈ E). Real type: o₃ = M₃/d³ = t₃.
(iii) m₄. With z := tr(e†ρ(U)), X_e = Re z/√d. Real/quaternionic type z is real (quaternionic: tr of an element of the real form M_{d/2}(ℍ) is
real) and E z⁴ = E|tr((e†⊗e†)(ρ⊗ρ)(U))|² = Σ_{λ ⊂ ρ⊗ρ} ‖P_λ(e†⊗e†)P_λ‖²_HS/d_λ (Schur orthogonality, multiplicity-free); complex type
E(Re z)⁴ = (1/16)(6E|z|⁴ + 2Re E z⁴ + 8Re E z³z̄) with E|z|⁴ given by the same sum. Since e†⊗e† commutes with the swap, its weights on
Sym²ρ and Λ²ρ are W_S = ½(1 + t), W_Λ = ½(1 − t), t := tr((ee†)²) ∈ [1/d, 1] ([1/d, ½] for quaternionic type, whose nonzero elements have
complex rank ≥ 2); the trivial component (real type: in Sym², Ω = Σe_i⊗e_i; quaternionic: in Λ², the symplectic form J) carries EXACTLY
⟨Ω̂, (e†⊗e†)Ω̂⟩² = (‖e‖²/d)² = 1/d² (for the quaternionic real form eJ = Jē gives tr(JᵀeJeᵀ) = ‖e‖²). Hence the bound
  E z⁴ ≤ 1/d² + Σ_{blocks B} (W_B − 1/d²·[1 ∈ B]) / d_min(B),  maximised over t (it is linear in t),
EXACT when each block minus its trivial part is irreducible (SU(N), Sp(2), SO(N)), an upper bound otherwise (G₂, F₄, E₆, E₇, E₈). E z⁴ ≠ 0
in the complex case only for SU(4) (E z⁴ = det e†, |det e| ≤ 4⁻², the singular values' AM–GM); E z³z̄ = 0 in every complex case below.
(iv) c₃ = 0 when ρ⊗ρ⊗ρ and ρ⊗ρ⊗ρ̄ contain no invariant; SU(3): E z³ = det ē (E[U_{i₁j₁}U_{i₂j₂}U_{i₃j₃}] = ε ε/6), E(Re z)³ = ¼ Re det e,
|det e| ≤ 3^{−3/2}, c₃ = 1/108 EXACT; SO(3): E z³ = det e (the same ε-integral), c₃ = 3^{−3/2}/3^{3/2} = 1/27 EXACT; otherwise
c₃ ≤ √(m₄/n) (Cauchy–Schwarz with Lemma I) — for G₂ and E₈ (antisymmetric invariant φ, E[ρ^{⊗3}] = the projector onto φ) also
c₃ ≤ s₁s₂s₃/d^{3/2} ≤ 3^{−3/2}/d^{3/2}, and the smaller is used.

### 4.6 STAKE S-4a (written before general_eval.py runs; refines S-4)

The universal (Lemma NH) thresholds: SU(2) about 0.17 (below 0.2452: the sharp MAD and Turan replaced), SU(3) about 0.25, Sp(2) and the
SO(N) about 0.3, G2 about 0.35, F4/E6/E7 about 0.5, E8 about 0.8 (all UNGUESSED to two digits); the binding term for small groups is the
covariance bound s1 (its phi_2(r) m4 tail), for large groups the near-Haar radius itself (r ~ log(1/(n m4))). Beats beta_BE: YES for SU(2), SU(3),
SU(4), SU(5), Sp(2), SO(3), SO(5..8), G2; NO for F4, E6, E7, E8. In lambda units the universal thresholds lie in [25, 300].

### 4.7 RESULTS II — THE CERTIFIED THRESHOLDS FOR EVERY GROUP (record runs/general_eval.2026-11-02a.txt, rc = 0; tensor-square
### decompositions checked exactly in runs/tensor_square_check.2026-11-02a.txt: all 15 pass Σd_λ and Σ d_λC₂(λ) = C₂(ρ)d(d ± 2), ALL OK)

Instrument code/general_eval.py: α_G(β) of Theorem 8.7_G with the five constants from Lemma NH and the per-group inputs of §4.5, mpmath intervals
at 200 bits, φ_k by series with a geometric tail enclosure; α_G is increasing in β (every bound increases with r), so CERTIFIED α_G(β*) < 1
gives the theorem on [0, β*]. β* is the largest 4-decimal grid point certified. β_BE = h^∨κ_ρ/96 is MG's Bakry–Émery value (Shen–Zhu–Zhu's
condition, §5 below); λ* := h^∨κ_ρ/β* the 't Hooft value (λ = h^∨g²_YM).

| group, ρ | type | n | h^∨κ_ρ | t₃ | t₄ / m₄ | β* CERTIFIED (Thm 8.7_G) | λ* | β_BE | β*/β_BE |
|---|---|---|---|---|---|---|---|---|---|
| SU(2), 2 | quat | 4 | 8 | 0 | 1/8 / 1/8 | 0.1704 (universal); 0.2452 (Lemma 8.6 exact, §3) | 46.9; 32.6 | 0.0833 | 2.05; 2.94 |
| SU(3), 3 | cplx | 18 | 18 | 1/108 | 1/108 / 1/108 | 0.3568 | 50.4 | 0.1875 | 1.90 |
| SU(4), 4 | cplx | 32 | 32 | 0 | 7/2048 / 7/2048 | 0.4741 | 67.5 | 0.3333 | 1.42 |
| SU(5), 5 | cplx | 50 | 50 | 0 | 3/2500 / 3/2500 | 0.5777 | 86.6 | 0.5208 | 1.11 |
| Sp(2), 4 | quat | 16 | 24 | 0 | 3/256 / 3/256 | 0.3519 | 68.2 | 0.25 | 1.41 |
| SO(3), 3 | real | 9 | 3 | 1/27 | 1/27 / 1/27 | 0.2427 | 12.4 | 0.03125 | 7.77 |
| SO(5), 5 | real | 25 | 15 | 0 | 3/625 / 3/625 | 0.4335 | 34.6 | 0.15625 | 2.77 |
| SO(6), 6 | real | 36 | 24 | 0 | 1/432 / 1/432 | 0.5070 | 47.3 | 0.25 | 2.03 |
| SO(7), 7 | real | 49 | 35 | 0 | 3/2401 / 3/2401 | 0.5732 | 61.1 | 0.3646 | 1.57 |
| SO(8), 8 | real | 64 | 48 | 0 | 3/4096 / 3/4096 | 0.6344 | 75.7 | 0.5 | 1.27 |
| G₂, 7 | real | 49 | 28 | 1/343 | 4/2401 / 5/2401 | 0.5171 | 54.1 | 0.2917 | 1.77 |
| F₄, 26 | real | 676 | 78 | 1/26³ | 5/26⁴ / 701/(26⁴·26) | 1.0139 | 76.9 | 0.8125 | 1.25 |
| E₆, 27 | cplx | 1458 | 108 | 1/(4·27³) | (18/16)/27⁴ / 1/52488 | 1.1706 | 92.3 | 1.125 | 1.04 |
| E₇, 56 | quat | 3136 | 168 | 0 | 4/56⁴ / 547/280283136 | 1.4563 | 115.4 | 1.75 | 0.83 |
| E₈, 248 | real | 61504 | 248 | 1/248³ | 5/248⁴ / 8213/234530004992 | 2.0503 | 121.0 | 2.583 | 0.79 |

(t₄/m₄ = 1 where the fourth-moment bound is exact — SU(N), Sp(2), SO(N): the identity direction is the maximiser and the matrix coefficients are
exactly Gaussian to fourth order, m₄ = 3/n², except SU(4) whose det adds 2/16; the exceptional groups' m₄ is an upper bound 1.25× (G₂) to 26×
(E₈) above the identity direction's value.)
STAKE CHECK (S-4, S-4a, written before the run): SU(2) universal ≈ 0.17 HELD (0.1704); SU(3) ≈ 0.25 REFUTED upward (0.3568); Sp(2)/SO(N) ≈ 0.3
REFUTED upward (0.35–0.63); G₂ ≈ 0.35 REFUTED upward (0.517); F₄/E₆/E₇ ≈ 0.5 REFUTED upward (1.01, 1.17, 1.46); E₈ ≈ 0.8 REFUTED upward (2.05).
"Beats β_BE: NO for F₄, E₆, E₇, E₈" — REFUTED for F₄ (1.25×) and E₆ (1.04×), HELD for E₇ (0.83×) and E₈ (0.79×). "λ* ∈ [25, 300]" REFUTED
by SO(3) (12.4: the vector representation of SO(3) has h^∨κ = 3, the smallest in the table). Binding terms as predicted: 90C_med carries
0.66–0.88 of the sum everywhere, through M·β²·s̄; for SU(N), SO(N), Sp(2) the covariance bound s̄ sits 1.2–1.9× above 1/n (the r c₃ term and
the φ₂(r)m₄ tail); for F₄, E₆, E₇, E₈ s̄ is 8–62× above 1/n — the φ₂(r)m₄ tail of Lemma NH, i.e. THE NEAR-HAAR RADIUS, binds them (r = 5β* =
5.1, 5.9, 7.3, 10.3 against log(1/(n m₄)) = 3.2, 3.6, 5.1, 6.1).

WHAT IS PROVED (statement at its strength). THEOREM 8.7_G (§4.2–4.3) for every compact G and faithful irreducible ρ, with the constants of
Lemma NH: for the fifteen (G, ρ) of the table, the Wilson theory on ℤ⁴ has a unique infinite-volume Gibbs measure, exponential clustering with
any m₀ < log(1/α_G)/2 and a transfer-matrix gap at every 0 < β ≤ β*(G) of the table — CERTIFIED. For SU(2) the sharp constants of THE GROUND
give 0.2452 (§3); the universal constants give 0.1704: Turán and the sharp MAD are worth a factor 1.44 there. Against Bakry–Émery (MG's β_BE,
i.e. Shen–Zhu–Zhu's condition λ > 96, §5), Theorem 8.7_G is wider for thirteen of the fifteen and narrower for E₇ and E₈; in 't Hooft units its
thresholds lie in λ* ∈ [12.4, 121] (SU(2) sharp: 32.6).
THE NEXT OBJECT FOR THIS LINK (named at its wall). The exceptional groups' thresholds are set by Lemma NH's tail φ₂(r)m₄, which bounds every Haar
moment of order ≥ 5 through |X| ≤ 1. The true one-link family stays near Haar while r is small against the eigenvalue-concentration scale of the
one-link integral (order dim G), so the sharp thresholds need Haar moments of matrix coefficients of all orders at the scale 1/√n, uniformly in
the direction — for the identity direction these are ∫χ^k = the multiplicities of the trivial representation in ρ^{⊗k} (computable by
Brauer–Klimyk from the same Lie data), for all directions the component weights of e^{⊗k} on ρ^{⊗k}. With exact m₄ (the identity direction's
t₄) alone E₈'s bound would move by the factor 26 in the tail; with M₆, M₈ the tail starts two orders later.

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

S-5 CHECK (stake written before reading the body): "SO(N), SU(N) only" HELD; "LSI uniform in the volume" HELD; "uniqueness of the
infinite-volume Gibbs measure" PARTLY REFUTED AS STATED: they prove uniqueness of the invariant measure of the infinite-volume dynamic and that
every finite-volume limit (periodic, Dirichlet or other boundary conditions) is it; DLR uniqueness needs the unwritten step that DLR measures
are invariant; "exponential decay, mass gap = clustering, not a transfer-matrix statement" HELD (rate c_N inexplicit, not uniform in N); "the
group enters only through Ric_G and a Hessian bound" HELD for Theorems 1.3 and 1.4, REFINED for Corollary 1.7 (explicit-basis bracket and
gradient constants, generalised in 5.2(d)).

## 6. G₂'S WINDOW — (W-S)_{G₂}, WHERE IT IS THE WHOLE OF HYPOTHESIS I (stake first)

### 6.0 What the SU(2) engine is, and what a G₂ engine needs (READ: w2_strip.c, w2_strip_n.c headers and build(), lines 1–120)

The two-face object: faces A, B = n × n blocks of fine plaquettes sharing a coarse edge (n = 2: one blocking step; n = 4: two); every object
link also lies in staples outside the object whose other links are THE DATUM (ordered = identity, random:SEED = Haar, cancel, free = off);
plaquette weights truncated at spin ≤ WMAX/2; the coarse loops carry representations a, c and the joint law of (A, B) is contracted by a
matrix-free sweep, each link's tensor being an EXACT product quadrature on S³ of Wigner D-matrices against the product of its staples'
weights. Integrity facts carried (MATH_BRIEF): the BENT object double-counts the n + 1 hinge plaquettes (planar objects are clean); the W3
truncation is signed (use positive truncations, check positivity). WHAT G₂ NEEDS FOR n ≥ 2: either (i) representation matrices D^λ of
G₂ for λ in the truncation (1, 7, 14, 27, 64, 77, 77′, …) and an exact quadrature on the 14-dimensional G₂ for their products — no product
rule exists — or (ii) the link integrals done representation-theoretically: ∫ D^{λ₁}⊗…⊗D^{λ_k}(U) w(U)^m dU = Σ_ν φ_ν(mβ)·(the projector onto the
invariants of λ₁⊗…⊗λ_k⊗ν), i.e. G₂'s Clebsch–Gordan intertwiners and their recoupling (6j / F-matrices) for every λ in the truncation.
THIS SESSION READS, EXACTLY: (a) G₂'s crossover from MG's coefficient instrument (two criteria, a literature check labelled); (b) the core
recoupling datum, the F-matrix of 7 ⊗ 7 ⊗ 7 → 7 over the channels {1, 7, 14, 27}, from explicit g₂ ⊂ so(7); (c) the n = 1 PLANAR two-face object
(zero blocking steps; clean) with the ORDERED datum, where every link weight is a class function and the joint law of the two loops on class
functions needs no recoupling data at all — for G₂ beside SU(2), the first exact reading of the trivial-centre core.

### 6.1 STAKES (written before g2_window.py exists)

S-6a (crossover). SU(2)'s a_½ at 2.2–2.3 is about 0.5; G₂'s a₇ reaches it near β ≈ 14 (UNGUESSED to one digit); the 't Hooft matching
λ_c(SU(2)) = 8/2.25 gives β_c(G₂) = 28·2.25/8 = 7.875; the literature's first-order bulk transition of the G₂ Wilson action sits near β ≈ 9.45
(Pepe–Wiese; recollection, LITERATURE, not a proof input). The three disagree; the readings run at all three.
S-6b (F-matrix). 7 ⊗ 7 ⊗ 7 contains 7 with multiplicity four (one per channel 1, 7, 14, 27 of the first pair); the change of bracketing is an
orthogonal 4×4 matrix F whose row/column through the trivial channel is (√1, √7, √14, √27)/7 up to signs (d_j/d_7² summing to 1); the 7-channel
entry F_{77} is UNGUESSED; MG's crossing ratio 0 for G₂ is a statement about the adjoint channel and is predicted to appear as a vanishing
combination of F-entries (UNGUESSED which).
S-6c (n = 1 reading). With the FREE datum the two plaquettes are independent (maximal class correlation 0, a control); with the ORDERED datum
the whole correlation is outside-mediated (the shared link's four outside staples): SU(2) at 2.2 reads a maximal class correlation in
(0.05, 0.5) (UNGUESSED where); G₂ at its 't Hooft-matched coupling reads SMALLER than SU(2) (UNGUESSED by how much); in both the leading
channel is the defining one (SU(2): χ_½, centre-odd — so SU(2)'s SO(3) channel, the centre-even part, reads strictly below the full value);
for G₂ there is no centre, the full value IS (W-S).

### 6.2 RESULTS (records runs/g2_window_kat.2026-11-02c.txt, runs/g2_F.2026-11-02a.txt, runs/g2_cross.2026-11-02a.txt,
### runs/g2_read_n1.2026-11-02a.txt and …b.txt; rc = 0; instruments code/g2_window.py, code/g2_read2.py; double precision, READINGS)

KNOWN ANSWERS MET FIRST. Weyl characters of A₁ and G₂ in Dynkin coordinates on a shifted torus grid (shift (0.25, 0.6) for G₂, chosen to miss
all six root walls — the half-step grid sat on the wall of the root (−1, 1) and gave NaN, recorded in …kat.2026-11-02b): Σh = 1; orthonormality
to 8.7·10⁻¹⁶ (SU(2), 15 irreps) and 4.4·10⁻¹⁶ (G₂, 23 irreps); G₂ dimensions 1, 7, 14, 27, 64, 77, 77′, 189 by the exact Weyl product (the
limit form cancelled at order t⁶ and returned 0 — replaced); 7 ⊗ 7 = 1 + 7 + 14 + 27 multiplicity-free; ∫χ₇³ = 1, ∫χ₇⁴ = 4 (= M₃, M₄ of §4.5).
TWO INSTRUMENTS SHARING NO LINE AGREE: G₂'s a₇(10, 12, 15, 20) = 0.36174213, 0.44316690, 0.54214253, 0.65244823 here, 0.3617421255,
0.4431668994, 0.5421425313, 0.6524482315 in MG's coeffs_run (Weyl integration in another coordinate system).

(a) THE CROSSOVER (READING). SU(2): a_½(2.2) = 0.46447903, a_½(2.3) = 0.47927908. Matching G₂'s defining channel: β_c(G₂) = 12.5774 (from
2.2) to 12.9968 (from 2.3). The 't Hooft match gives 7.875; the literature's bulk transition ≈ 9.45 lies between (LITERATURE, recollection,
not used). STAKE S-6a: "near 14" REFUTED at the first digit (12.6–13.0); "the three disagree" HELD.

(b) THE G₂ F-MATRIX (READING, exact rationals to 10⁻⁶): from the octonion 3-form φ, g₂ = stab(φ) ⊂ so(7) has dimension 14, Casimir 2 on the 7;
7 ⊗ 7 channels (dimension, Casimir) = (1, 0), (7, 2), (14, 4), (27, 14/3); the 7-isotypic part of 7^{⊗3} has dimension 28 (multiplicity 4).
|F_ij|² for the change of bracketing (7 ⊗ 7) ⊗ 7 → 7 ⊗ (7 ⊗ 7), channels ordered 1, 7, 14, 27:
    [ 1/49   1/7   2/7   27/49 ]
    [ 1/7    1/4   1/2    3/28 ]
    [ 2/7    1/2    0     3/14 ]
    [ 27/49  3/28  3/14  25/196 ]       (symmetric, doubly stochastic).
STAKE S-6b: the trivial row (1, 7, 14, 27)/49 HELD; F_{77}: |F_{77}|² = 1/4 (UNGUESSED, now read); the vanishing combination predicted for the
zero crossing ratio is THE SINGLE ENTRY |F_{14,14}|² = 0: two adjoint channels on a 7-sheet recouple to zero — the recoupling form of MG's
Proposition X_G value 1 − h^∨/(2C₂(7)) = 0 (identification read off two exact computations, MG's operator identity Σ_aT^aT^bT^a =
(C₂(ρ) − ½h^∨)T^b being the common mechanism; the full equivalence is not written here).

(c) THE n = 1 PLANAR TWO-FACE OBJECT, ORDERED DATUM — THE MAXIMAL CORRELATION OF THE TWO LOOPS' CLASS FUNCTIONS (G₂: the whole of (W-S) at
zero blocking steps; SU(2): full and centre-even = SO(3) channel). Exact projection on the span of the irreducible characters with C₂ ≤ Cspan,
link-law truncation C₂ ≤ CK, both varied; positivity of the truncated link kernel checked (relative minimum −2·10⁻⁹ to +3·10⁻⁶).
  SU(2), free datum: 0 (control).  G₂, free datum: 0 (control).
  SU(2): β = 1.5 → 0.033736 (SO(3): 0.024857); 2.2 → 0.032057 (SO(3): 0.029970; 0.029985 at the doubled span); 2.3 → 0.031861 (0.030179);
         3.0 → 0.030814 (0.030447).
  G₂:    β = 7.875 ('t Hooft) → 0.037697; 9.45 (bulk, lit.) → 0.035634; 12.5774 (a-matched to 2.2) → 0.033264 (identical to six digits on
         grids 96 and 128 and truncations C₂ ≤ 80 and ≤ 110); 12.9968 → 0.033045; 20 → 0.030871.
STAKE S-6c: the free controls 0 HELD; "SU(2) at 2.2 in (0.05, 0.5)" REFUTED (0.0321, below); "G₂ at the 't Hooft match reads SMALLER than SU(2)"
REFUTED (0.0377 against 0.0321); "SU(2)'s SO(3) channel strictly below the full value" HELD (0.0300 < 0.0321), and the gap closes as β grows
(0.0249/0.0337 at 1.5 → 0.0304/0.0308 at 3.0). AT MATCHED DEFINING-CHANNEL COUPLING THE TRIVIAL-CENTRE CORE OF G₂ (0.0333) SITS WITHIN 4% OF
SU(2)'s FULL VALUE AND 11% ABOVE SU(2)'s SO(3) CHANNEL. Both fall slowly with β (the four outside staples pin the shared link toward 1 and
decouple the loops), so at one fine scale the outside-mediated coupling is small and smooth across the crossover for both groups.
WHAT THIS IS AND IS NOT: zero blocking steps (the coarse loops are plaquettes), one datum (ordered); the window lemma needs n = 2, 4 and the sup
over environments. THE NEXT OBJECT (precisely): the n = 2 and n = 4 planar objects for G₂, whose interior links (shared by two object
plaquettes and carrying a class weight w⁴) make the joint law of the boundary loops a G₂ spin-network evaluation: the link integral
∫χ_λ(XU)χ_μ(U⁻¹Y)χ_ν(U)dU is a sum over the intertwiners of λ ⊗ ν → μ, and gluing four such faces needs the F-matrices of every channel in the
truncation, of which (b) is the first (7, 7, 7 → 7); the truncation at a coupling near 12.6 needs the irreducibles with C₂ ≤ about 80
(64 of them) per (c)'s tail. The SU(2) engine's quadrature on S³ has no G₂ analogue, so the G₂ engine must be the recoupling one.

## 7. SYNTHESIS — STATUS TABLE, THE NEXT OBJECTS, THE UNIFICATION

| object | statement | status | where |
|---|---|---|---|
| Thm 8.7 for SU(2) | α < 1 on [0, 0.2414] (Lemma 8.6), [0, 0.2452] (exact constants) | CERTIFIED (known answer met, second road) | §3 |
| Lemma I | Haar covariance of u = ρ/√d is I/n on E = span_ℝ ρ(G), n = d² or 2d² | PROVED, every compact G, irreducible ρ | §4.1 |
| Thm 8.7_G | uniqueness, clustering, transfer-matrix gap when α_G(β) < 1, with the five one-link constants | PROVED, every compact G | §4.2–4.3 |
| SU(2)-only facts | F1 radial Z, F2 Turán, F3 sharp MAD, F4 quaternions, F5 vanishing odd moments — each replaced | PROVED replacements | §4.3 |
| Lemma NH | μ̄, s̄, D̄, T, T_x from (n, t₃, t₄, o₃, c₃, m₄) | PROVED | §4.4 |
| per-group inputs | t₃, t₄, o₃ exact; m₄ exact for SU(N), Sp(2), SO(N), bounded for G₂, F₄, E₆, E₇, E₈; c₃ exact/bounded | PROVED (decompositions checked exactly) | §4.5 |
| β*_G | SU(2) 0.1704 (univ.), SU(3) 0.3568, SU(4) 0.4741, SU(5) 0.5777, Sp(2) 0.3519, SO(3) 0.2427, SO(5) 0.4335, SO(6) 0.5070, SO(7) 0.5732, SO(8) 0.6344, G₂ 0.5171, F₄ 1.0139, E₆ 1.1706, E₇ 1.4563, E₈ 2.0503 | CERTIFIED | §4.7 |
| SZZ read | Thms 1.3, 1.4 for every G at λ > 32(d−1); Cor. 1.7 with G-constants; DLR step unwritten in their paper | READ; G-extension PROVED from their argument | §5 |
| G₂ crossover | 12.58–13.00 (a₇-matched), 7.875 ('t Hooft) | READING | §6.2(a) |
| G₂ F-matrix | |F|² for 7⊗7⊗7 → 7 exact rationals; |F₁₄,₁₄|² = 0 | READING | §6.2(b) |
| (W-S)_{G₂}, n = 1 | 0.0333 at 12.58, 0.0377 at 7.875; SU(2) 0.0321 (SO(3) 0.0300) at 2.2 | READING (converged) | §6.2(c) |
| (W-S)_{G₂}, n = 2, 4 | needs the G₂ recoupling engine | OPEN — next object | §6.2 |

THE NEXT OBJECTS (precise). (1) For F₄, E₆, E₇, E₈ — where Theorem 8.7_G's threshold is set by Lemma NH's tail — the Haar moments of matrix
coefficients of the minimal representation at all orders at the scale 1/√n, uniformly in direction: for the identity direction ∫χ^k = the
multiplicity of 1 in ρ^{⊗k} (Brauer–Klimyk on the same Lie data), for all directions the component weights of e^{⊗k} on ρ^{⊗k}; with them the
near-Haar radius moves from log(1/(n m₄)) toward the eigenvalue-concentration scale of the one-link integral and the thresholds rise
(E₇, E₈ then plausibly past λ = 96). (2) For SU(N), Sp(N), SO(N), the exact one-link family through its Bars–Green determinant and the sharp
MAD at Haar, which for SU(2) are worth the factor 1.44 between 0.1704 and 0.2452. (3) For G₂'s window, the recoupling engine for the n = 2, 4
planar objects, its first datum (b) in hand.

THE UNIFICATION FOUND. THE STRONG END OF EVERY GROUP IS ONE ISOTROPY PLUS ONE CUBIC INVARIANT. Lemma I makes the Haar law of the matrix
coefficients isotropic to second order for every compact group — the one property of SU(2)'s three-sphere the proof really used — and the
first departure from isotropy is the cubic invariant of ρ (∫χ³ = 1: SU(3)'s ε-tensor, SO(3)'s determinant, G₂'s octonion 3-form, F₄'s and
E₆'s Jordan cubic norms, E₈'s structure constants), which turns the SU(2) anisotropy O(r²) into O(r) and enters every group's constant exactly
through t₃ = M₃/d³. The same cubic invariant is G₂'s trivalent vertex in Kuperberg's spider, the branching of MG's G₂ surface gas, and,
through the F-matrix, the zero |F₁₄,₁₄|² = 0 that is MG's crossing ratio 1 − h^∨/(2C₂(7)) = 0: one tensor controls the one-link family's
first anisotropy, the gas's branching and the recoupling. Second: the fourth moment of the coefficients, maximised over ALL directions, is EXACTLY THE
GAUSSIAN 3/n² (attained in the identity direction) precisely when ρ ⊗ ρ has the fewest components its type allows — real type
1 + two irreducibles (M₄ = 3: SO(N ≥ 3), and Sp(2) through 4 ⊗ 4 = 1 + 5 + 10), complex type Sym² + Λ² both irreducible (E|χ|⁴ = 2:
SU(3), SU(N ≥ 5)); SU(2) falls short (M₄ = 2: the three-sphere is platykurtic, m₄ = 1/8 < 3/16), SU(4) exceeds through its determinant, and
the exceptional groups exceed it (M₄ = 4, 5, 4, 5 for G₂, F₄, E₇, E₈; E|χ|⁴ = 3 for E₆): their strong-coupling constants are set by the extra
quartic invariants, the same tensors that put the small components into their tensor squares (7 ⊂ Λ²7, 26 ⊂ Sym²26, 27̄ ⊂ Sym²27,
133 ⊂ Sym²56, 248 ⊂ Λ²248) — and those small components are exactly what Lemma NH's m₄ bound pays for (§4.7: t₄/m₄ = 0.8, 0.19, 0.11, 0.21,
0.04).

## 8. PRECISIONS, DATED (2026-11-02, after sections 0-7 were written; nothing above edited)

8.1 Section 5.1 names the journal publication as "CMP 400 (2023)": UNVERIFIED here. Only the arXiv v1 LaTeX source was read; the volume
number is a recollection and carries no weight in any statement.
8.2 The tensor-square decompositions of 4.5(iii) are the standard ones, CHECKED by two necessary exact sum rules (dimension and the Casimir
trace on Sym2 and Lambda2, runs/tensor_square_check), not derived here. The m4 bound in fact uses only the SMALLEST nontrivial component
dimension in each of Sym2 and Lambda2 (and the exact trivial weight 1/d^2), a weaker fact than the full decomposition.
8.3 |F_{14,14}|^2 = 0 and MG crossing ratio 0 for the 7 of G2: an IDENTIFICATION read off two exact computations with a common mechanism
(Sum_a T^a T^b T^a = (C2 - h/2) T^b), not a proved equivalence.
8.4 Shen-Zhu-Zhu uniqueness, stated at its strength: uniqueness of the invariant measure of the infinite-volume Langevin dynamic and of
every finite-volume limit (any boundary condition); uniqueness among all DLR Gibbs measures needs the (standard, unwritten in their paper)
invariance of DLR measures under that dynamic.
