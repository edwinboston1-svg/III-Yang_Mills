# M3 — THE ULTRAVIOLET HALF: BAŁABAN'S THEOREM 2, HYPOTHESIS II, AND THE INTERFACE (E)

Proof agent M3, 2026-11-02 (times from the session; the record's own commits are cited by hash). Work directory
`.../scratchpad/math/M3/`. Appended as the work proceeds; nothing above a line is edited after it is written except
where a dated correction says so.

## 0. Sources read in full before deriving (orientation)

- `scratchpad/math/MATH_BRIEF.md` (the shared brief); `scratchpad/cross/ANSWER.md`; `scratchpad/read/REPORTS.md` (all 305 lines).
- III-Yang_Mills `OPEN/ledger/d4-balaban-the-pages.md` (§§1–15), `OPEN/ledger/d4-the-fourth-seat-ledger.md` (§§1–9),
  `OPEN/ledger/beta-uv-the-reading.md` (§§1–5), `OPEN/ledger/d4b-the-cross-scale-comparisons.md` (§§1–7),
  `OPEN/the-far-shore.md` (all 252 lines), `OPEN/the-standing.md` (the UV rows).
- III `DOCS/III-APERANTON-ADDENDUM-II-THE-SEQUENCE-HYPOTHESIS.md` (§§0–8: Lemmas A, B, C as the record holds them).
- III `LEAN/aperanton/Aperanton/CouplingSequence.lean` (Lemma A, sign form), `CouplingTransient.lean` (Lemma A,
  bounded-transient form, 9 theorems), `UVInterface.lean`.
- THE GROUND (paper text, `scratchpad/cross/ground_docx.txt`): §4.3, §7.3 (Lemma 7.3, Theorem 7.4), §8.1, §8.3
  (Proposition 8.4, Hypotheses I and II, Theorem 8.5 and its whole proof, the remarks after it).
- On disk of Bałaban's papers: only CMP 102 (1985) 277–309 [15] (`Downloads/1104114383.pdf`); every other page quoted
  below is quoted from the record's verbatim readings (d4, d4b), with the record's page numbers.

## 1. The plan (deep-think synthesis, before any derivation)

Decision. Deliver (1) Theorem 2 as a complete proof modulo exactly one black box — Bałaban's inductive bounds, the
same black box his Theorem 1 already is — with the instantiation gap I found in Lemma A repaired, Lemma C derived
by an interpolation that does not complexify the coupling, and the continuity it needs proved; (2) Hypothesis II
in the exact form Theorem 8.5's proof consumes (which is weaker than its statement), with the tower decomposition
that splits it into a UV piece (mine) and a window piece (the crossover's), the UV piece derived from Bałaban's
structure in averaged form conditional on one named object (Bałaban's Theorem 1 WITH SOURCES), its Gaussian core
proved for every coarse configuration, and a correction to the block map; (3) the interface (E) needs and supply.

Findings during orientation that changed the plan (each is derived in full below):
- F1. Theorem 8.5's proof uses Hypothesis II(a) only through its λ_j-average (the second term of the covariance
  split), and uses II(b) in sup form only because Dobrushin's comparison theorem does. So the averaged form of II(a)
  suffices as the paper stands; II(b)'s form is set by the comparison theorem M2 uses.
- F2. CouplingTransient.lean's hypothesis `hr` quantifies over EVERY window history s. Bałaban's full model (CMP 119
  Theorem 1 assumes the profile "(I.0.33)" = (0.31); its master inequalities (2.6)–(2.9) are derived from the recursion
  along the trajectory) controls β only along TRUE trajectories that have obeyed the profile so far. The truncated
  flow of the Lean proof visits clamped histories that are not trajectories (and violate the scale sums E4 when the
  clamp is active). So the Lean lemma's hypothesis is not supplied by the model of record. Repair: a trajectory form
  of Lemma A (the IVT on the closed set of bare values whose true trajectory stays in the window), which evaluates β
  only along true trajectories and propagates the profile inductively. Proved below (Lemma A′).
- F3. The example block map of THE GROUND §8.3 (one SU(2) element per coarse link = the holonomy along a fixed path)
  is ultraviolet-degenerate: the holonomy along a path of fixed physical length has a linearly divergent self-energy,
  so along the asymptotically free sequence (g² ~ 1/ln(1/a), path length a_c/a) its law tends to Haar measure; then
  Hypothesis I is trivial and Hypothesis II carries the whole problem. The block map must be ultraviolet-stable
  (Bałaban's averaged variables). Proved at the Gaussian level below; computed.
- F4. Hypothesis I (a Dobrushin condition on the coarse variables) can hold only past the crossover; Bałaban's
  estimates hold only where the coupling is small. So "Hypothesis II at a_c" contains the window's fibres too. The
  UV half's deliverable is Hypothesis II at the scale a_UV where Bałaban's coupling is ≤ γ; Hypothesis II at a_c is
  that plus the window fibre's clustering, composed by the law of total covariance (Tower.lean's shape). Proved below.

Kill-switches (stop and re-plan if seen): (K1) a page of Bałaban (via the record's verbatim quotes) showing β_{k+1}
defined or bounded only for histories obeying a condition that the trajectory form cannot propagate; (K2) the
stage identity failing at one loop for the composition of the steps (the transient then not a Λ-ratio); (K3) the
Gaussian computation showing the averaged coarse variable's variance also divergent (then F3's fix fails).

## 2. STAKES, written before any instrument runs

S-1 (the running coefficients in Bałaban's normalisation, certified enclosure). With x = 1/g_B² = β_Wilson (his tr 1 = 1):
per step of block factor L the one-loop decrement is c(L) = 8b₀ ln L = (11/(3π²)) ln L and the two-loop coefficient is
32b₁ = 17/(3π⁴) per unit log, so b_{k+1} = c(L) + (17/(3π⁴)) ln L · g_k² + O(g⁴) in a self-similar scheme. STAKE:
c(2) ∈ [0.25752, 0.25753], c(3) ∈ [0.40815, 0.40816], 17/(3π⁴) ∈ [0.058174, 0.058175], 4b₁/b₀ = 0.156588… (the log-log
coefficient of the two-loop profile).

S-2 (THE BLOCK-MAP TEST, decisive for F3). Four-dimensional lattice gauge field, abelian (or the abelianised one-loop
fluctuation of SU(2), one colour component), Feynman gauge, covariance g²(−Δ)⁻¹δ_{μν}. Coarse scale = n fine spacings.
(a) PATH variable: the flux through an n×n square = the holonomy angle of its boundary (the paper's example map's coarse
plaquette). STAKE: Var_path/g² = α n + O(log n) with α = 4(G(0) + 2Σ_{m≥1}G(m e₁)) − (o(1)) > 0, i.e. LINEAR GROWTH;
numerically Var_path/(g² n) → a constant in [0.4, 0.9] (UNGUESSED within that band; the proved lower bound is 4G(0) − O(1/n)
= 0.6197 − O(1/n)).
(b) AVERAGED variable (Bałaban-type: each coarse link the average over the n³ parallel fine paths of its block): STAKE:
Var_avg/g² converges to a finite limit as n → ∞ (the linearised coarse variable is in H⁻¹), value UNGUESSED, expected O(1).
(c) Along the asymptotically free sequence g_YM² = 4/(x_c + c(2) log₂ n) (x_c = 1/g_c² fixed), Var_path → ∞ (so the path
holonomy's law tends to Haar) while Var_avg → 0 like 1/log n (the averaged coarse variable is a weak-coupling variable).
Kill-switch K3: Var_avg growing without bound.

## 3. RESULTS of the stakes (records in this directory; nothing in §2 edited)

Instrument `m3_blockmap.py` (heat-kernel reduction: every 4D lattice integral ∫d⁴k|ĥ|²/k̂² becomes the exact 1D integral
∫₀^∞ dt Π_ν(1D factor), each 1D factor a finite sum of e^{−2t}I_m(2t)); runs `blockmap_run.2026-11-02a.txt` (NaN: scipy's
`ive` returns NaN for arguments ≳ 10¹⁰ — an instrument wall, not a reading), `…b.txt` (same wall at the second cap),
`…c.txt` (the run of record: t ≤ e¹⁸, where `ive` is finite; the integrands decay like t⁻³ there, tail ≤ n⁴/(32π²e³⁶),
printed per row, ≤ 2·10⁻¹⁰); `m3_slope.py` → `slope_run.2026-11-02a.txt`.

S-1 HELD (mpmath interval arithmetic, 40 digits): 8b₀ = 11/(3π²) = 0.3715110066885718…; c(2) = 0.2575118068331705…;
c(3) = 0.4081465573235253…; 32b₁ = 17/(3π⁴) = 0.0581738994432112…; 4b₁/b₀ = 0.1565872838108856….

S-2, the record (abelian/one-colour Gaussian field, covariance g²(−Δ)⁻¹δ_{μν}, coarse scale n fine spacings):

| n | Var_path/g² | Var_path/(g²n) | Var_1dir/g² | Var_avg/g² |
|---|---|---|---|---|
| 1 | 0.500000 | 0.500000 | 0.500000 | 0.500000 |
| 2 | 1.369312 | 0.684656 | 0.816690 | 0.288104 |
| 4 | 3.261484 | 0.815371 | 1.194517 | 0.216234 |
| 8 | 7.167860 | 0.895982 | 1.602191 | 0.194457 |
| 16 | 15.115398 | 0.944712 | 2.026115 | 0.188531 |
| 32 | 31.149865 | 0.973433 | 2.458599 | 0.187003 |
| 64 | 63.359009 | 0.989985 | 2.895449 | 0.186616 |
| 128 | 127.917696 | 0.999357 | 3.334502 | 0.186520 |

- KNOWN ANSWER MET: at n = 1 all three variables are the single plaquette and read 0.500000 = 2/d exactly (equipartition:
  Σ_p⟨F_p²⟩ = g²(d−1)|Λ| over d(d−1)|Λ|/2 plaquettes). G(0) read 0.154933390135 + the t⁻² tail 1/(16π²e¹⁸) = 9.6·10⁻¹¹
  = 0.154933390231, the known value.
- S-2(a) LINEAR GROWTH HELD; THE STAKED NUMERIC BAND [0.4, 0.9] REFUTED. The slope is 4Σ_{m∈ℤ}G₄(me₁) = 4G₃(0) (summing the
  4D lattice Green function along a line gives the 3D one at the origin, Watson's integral): G₃(0) read 0.252731009859
  (Watson 0.252731009858…), α = 1.0109240394; least squares on n = 16…128 gives α = 1.010921, β = 0.2024 (log coefficient),
  γ = −0.498, residual ≤ 2·10⁻⁵. My stake wrote the right formula and an unevaluated wrong band; the formula stands.
- The one-direction average (n parallel paths along one transverse direction) grows like ln n: +0.437 per doubling,
  ≈ 0.63 ln n — the dimension count's middle case (two undamped transverse directions: a logarithm).
- S-2(b) HELD: the block-averaged variable's variance converges, v_∞ = 0.18652 − (≤ 10⁻⁴) ≈ 0.1865.
- S-2(c) HELD: along g_YM² = 4/(x_c + c(2) log₂ n), at x_c = 4: g²Var_path = 88.2 at n = 128 (Gaussian ⟨cos θ/2⟩ ≈
  4·10⁻¹⁵ — Haar), while g²Var_avg = 0.1286, falling like 1/ln n. Kill-switch K3 not fired.

## 4. THE NORMALISATION, RESOLVED (proved)

Bałaban, CMP 109 p. 252 (0.2): A^ε(U) = Σ_p ε^{d−4}[1 − Re tr U(∂p)], tr the NORMALISED trace (tr 1 = 1), density exp(−(1/g²)A)
(d4 §2). For SU(2), tr = ½Tr, so a plaquette weighs exp(−(1/g_B²)(1 − ½Re Tr U_p)) ∝ exp((1/(2g_B²)) Re Tr U_p); THE GROUND's
Theorem 8.7 weighs it by exp(½β Tr U_p). Hence

  β = 1/g_B²   (Bałaban's coupling, no factor).

The continuum normalisation: with U_p = exp(i a² F^a_{12} σ^a/2 + O(a³)), ½Tr U_p = cos(a²|F|/2), so 1 − ½Tr U_p = a⁴|F|²/8 + O(a⁶),
and βΣ_p(1 − ½Tr U_p) → (β/8)∫Σ_{μ<ν}F^aF^a = (β/16)∫Σ_{μ,ν}F^aF^a, which is (1/(4g_YM²))∫F^aF^a iff

  β = 4/g_YM²,   i.e.   g_B² = g_YM²/4.

THE "INCONSISTENCY" IS A COLLISION OF TWO SYMBOLS, NOT OF TWO NUMBERS. beta-uv-the-reading.md (written 04:46, before Bałaban's
page was read: its own §4 says Theorem 1's text was unread) writes β_UV = 4/g₀² with g₀ (i) in the CONTINUUM normalisation and
(ii) naming the THRESHOLD; d4-balaban-the-pages.md §2 writes β_UV = 1/γ² with γ Bałaban's own threshold. Both say
β_UV = 1/γ_B² = 4/γ_YM², γ_YM = 2γ_B. The second collision: in Bałaban g₀ is the BARE coupling, not the threshold. Fixed
notation from here: γ (Bałaban's threshold, his normalisation), g_k (his effective couplings), x_k := 1/g_k² = β_k (Wilson units).

THE RUNNING IN THESE UNITS. μ dg_YM/dμ = −b₀g³ − b₁g⁵ with b₀ = 11N/(48π²) = 11/(24π²), b₁ = 34N²/(3(16π²)²) = 17/(96π⁴) for
N = 2, so d(1/g_YM²)/d ln μ = 2b₀ + 2b₁g_YM², and with x = 4/g_YM²:

  dx/d ln μ = 8b₀ + 32b₁/x = 11/(3π²) + (17/(3π⁴))·g_B².

A block step of factor L lowers x (k grows toward coarse scales) by c(L) + (17/(3π⁴)) ln L · g_k² + O(g⁴) in a self-similar
scheme, c(L) := 8b₀ ln L; certified values in §3 (c(2) = 0.2575118068…, c(3) = 0.4081465573…). Both coefficients are
scheme-independent for a step map x ↦ x − B₀ − B₁/x − …: under x′ = x + κ₀ + κ₁/x + O(x⁻²) one has
x′_{k+1} = x′_k − B₀ − B₁/x′_k + O(x′⁻²) (substitute and expand: the κ₀ and κ₁ terms cancel between the two sides at this
order), so B₀ = c(L) and B₁ = 32b₁ ln L are universal, and every scheme dependence sits in the transient f of §5.3. Two-loop
consequence: the profile carries a log-log term (4b₁/b₀) ln(x_j/x_K) = 0.15659 ln(x_j/x_K), which is o(K − j), so (0.31) with
β < 8b₀ < β′ is consistent with two loops; in the bounded-transient form the two-loop term is part of ρ (Lemma C).

## 5. BAŁABAN'S THEOREM 2 IN FOUR DIMENSIONS

### 5.0 Conventions (CMP 109 pp. 255–259, as d4 §1 and §8 read them)

k = 0 is the bare lattice of spacing ε = L^{−K}, k = K the unit lattice. Step k → k+1 integrates the scale-k fluctuation at fixed
scale-(k+1) averages and sets 1/g_{k+1}² = 1/g_k² − β_{k+1}(g_k) (0.20), β_{k+1} the second moment of the vacuum polarisation of
the step's output ((1.20)–(1.22), (5.42) "the fundamental equality defining the β-function"); "it depends also on all preceding
coupling constants" (p. 298). Write b_{k+1} := β_{k+1}, so x_{k+1} = x_k − b_{k+1}. The window: x_j ≥ X_min := 1/γ² for every
j. LFR II's Theorem 1 (CMP 122 p. 355) assumes the window; its inductive description (CMP 119 Sect. 2) uses the master
inequalities (2.6)–(2.9), which "follow from the renormalization group equations (0.20) [I], and from the properties of the
β-functions" (CMP 119 p. 255, the reading log): they are facts about TRAJECTORIES that have obeyed the per-step bounds; CMP
119's own Theorem 1 cites "(I.0.33)", i.e. the profile (D4b B3).

### 5.1 The statement proved — THEOREM 2, bounded-transient form

THEOREM 2. d = 4, G = SU(2), Bałaban's renormalisation transformations with block factor L ≥ 2 (his own L, chosen first). Put
c := 8b₀ ln L. There is F ≥ 0 (Lemma B), and for every ρ ∈ (0, c) there is γ₀(ρ) > 0 (Lemma C), such that for every
γ ≤ γ₀(ρ) (and ≤ Bałaban's γ for this L), every target X = 1/g² ≥ 1/γ² + 2F and every K ≥ 1 there is a bare x₀ whose
trajectory satisfies x_j ≥ 1/γ² for 0 ≤ j ≤ K (every effective coupling in ]0, γ]), x_K = X, and

  X + (K − j)(c − ρ) − 2F ≤ x_j ≤ X + (K − j)(c + ρ) + 2F        (0 ≤ j ≤ K),                       (5.1)

with x_i ≥ x_j + (j − i)(c − ρ) − 2F for i ≤ j ≤ K. This is (0.31) with β = (c − ρ)/ln L, β′ = (c + ρ)/ln L and the target
shifted by ±2F; every cross-scale use of (0.31) in Bałaban's five four-dimensional papers is covered at the costs D4b computes
((1 − 2Fg²)^{−1/2}, 1 + β₀, and c − ρ > 0 for the sums over scales). At j = 0: 1/g₀² ∈ [X + K(c − ρ) − 2F, X + K(c + ρ) + 2F],
so g₀ → 0 like (8b₀ ln ε⁻¹)^{−1/2}: asymptotic freedom inside the construction. LFR II's Theorem 1 holds on this trajectory.

STATUS: PROVED from Lemmas A′, B, C, D below; the black box is exactly Bałaban's inductive bounds (CMP 109 Theorem 3 p. 264,
CMP 116, CMP 119 Sect. 2, LFR I–II), the input his Theorem 1 already is. Each lemma's own status line, and §8, say what it
rests on.

### 5.2 LEMMA A′ — the trajectory form of the sequence lemma (NEW HERE; proved)

WHY A NEW FORM. CouplingTransient.lean's window_of_bounded_transient assumes the bound hr: for every k and EVERY history s with
all entries ≥ X_min, a(k) − ρ ≤ b k s ≤ a(k) + ρ; and its truncated flow evaluates b at clamped histories (max(s_j, X_min))_j
that are not trajectories. The model of record controls β only along trajectories that have obeyed the profile so far
(§5.0): on a clamped history with the clamp active for m steps, Bałaban's scale sum CMP 119 (2.46), Σ_{j≤n} g_j^{κ₀} <
g_n^{κ₀−6}, fails (the clamp contributes m·γ^{κ₀}), so the induction that defines and bounds β is not available there. The Lean
lemma is correct; its hypothesis is not what the model of record supplies. Lemma A′ is.

SETTING. For each bare value x₀ the trajectory is defined recursively: x_0 = x₀; D_0 := ℝ; D_{k+1} := {x₀ ∈ D_k : x_k(x₀) ≥
X_min} (the history 0..k in the window); on D_{k+1} the shift b_{k+1}(x₀) is defined and x_{k+1} := x_k − b_{k+1}. Hypotheses:
(H1) b_{k+1} is continuous on D_{k+1}; (H2) a(i) = c + f(i) − f(i − 1) for i ≥ 1, with |f(i)| ≤ F for all i ≥ 0;
(H3) |b_{k+1}(x₀) − a(k + 1)| ≤ ρ for every x₀ ∈ D_{k+1}, with 0 ≤ ρ ≤ c.

LEMMA A′. Under (H1)–(H3), for every K ≥ 1 and every X ≥ X_min + 2F there is x₀ ∈ D_{K+1} with x_K(x₀) = X; for it (5.1)
holds, x_j ≥ X_min for all j ≤ K, and x_i ≥ x_j + (j − i)(c − ρ) − 2F for i ≤ j ≤ K.

PROOF. (P) For x₀ ∈ D_m and 0 ≤ i < j ≤ m: x_i − x_j = Σ_{l=i+1}^{j} b_l ∈ [Σ a(l) − (j−i)ρ, Σ a(l) + (j−i)ρ], and the
telescoped sum Σ_{l=i+1}^{j} a(l) = (j − i)c + f(j) − f(i) lies in [(j−i)c − 2F, (j−i)c + 2F]; so
(j−i)(c−ρ) − 2F ≤ x_i − x_j ≤ (j−i)(c+ρ) + 2F.
(Closedness.) D_0 = ℝ is closed and x_0 is continuous on it. If D_m is closed and x_m is continuous on D_m, then
D_{m+1} = D_m ∩ x_m^{−1}([X_min, ∞)) is closed in D_m, hence in ℝ, and x_{m+1} = x_m − b_{m+1} is continuous on D_{m+1} by
(H1). By induction every D_m is closed and every x_m is continuous on D_m.
(A half-line.) Let M := X_min + K(c + ρ) + 2F. If x₀ ≥ M then x₀ ∈ D_1 = [X_min, ∞); and if x₀ ∈ D_j with j ≤ K, then (P)
with i = 0 gives x_j ≥ x₀ − j(c + ρ) − 2F ≥ X_min, so x₀ ∈ D_{j+1}. Hence [M, ∞) ⊂ D_{K+1}.
(The upper end.) x̂ := X + K(c + ρ) + 2F ≥ M lies in D_{K+1}, and x_K(x̂) ≥ x̂ − K(c + ρ) − 2F = X by (P).
(The lower end.) x* := inf{y : [y, ∞) ⊂ D_{K+1}} is finite (D_{K+1} ⊂ D_1) and x* ∈ D_{K+1} (closed). Claim: some j ≤ K has
x_j(x*) = X_min. If x* = X_min take j = 0. Otherwise there are y_n ↑ x* with y_n ∉ D_{K+1} (else an interval below x* lies in
D_{K+1} and, by closedness, [x* − δ, ∞) ⊂ D_{K+1}, contradicting the infimum). For each n let j_n ≤ K be the least j with
y_n ∉ D_{j+1}; then y_n ∈ D_{j_n} and x_{j_n}(y_n) < X_min (j_n ≥ 1, since y_n > X_min for n large). Pass to a subsequence with
j_n ≡ j. D_j is closed, contains x*, and x_j is continuous on it, so x_j(x*) = lim x_j(y_n) ≤ X_min; and x_j(x*) ≥ X_min
because x* ∈ D_{K+1}. So x_j(x*) = X_min, and (P) at x* (every step up to K is defined) with i = j gives
x_K(x*) ≤ X_min − (K − j)(c − ρ) + 2F ≤ X_min + 2F ≤ X, using ρ ≤ c.
(IVT.) x_K is continuous on [x*, x̂] ⊂ D_{K+1} with x_K(x*) ≤ X ≤ x_K(x̂): some x₀ in between has x_K(x₀) = X. (5.1) and the
cross-scale inequality are (P) at this x₀ with j = K, and with general i < j. ∎

REMARKS. (1) No b is ever evaluated off a true trajectory, and (H3) is used only on D_{k+1}. (2) In the model of record (H3) is
proved BY INDUCTION ON k: Lemma C at step k+1 needs Bałaban's inductive description at step k, which needs the master
inequalities for the history 0..k at D4b's costs — and those follow from (P) on D_{k+1} ⊂ D_l (l ≤ k), i.e. from (H3) at the
steps ≤ k. The profile is propagated along the trajectory, as CMP 119 p. 255's own sentence requires. (3) The window needs
only ρ ≤ c; the profile's lower slope c − ρ > 0 is what the scale sums (D4b E4) need, and Lemma C grants ρ < c for γ small.
(4) Formalisation: the proof uses closed sets, an infimum, continuity on a closed set and the IVT, of the same kind as
CouplingTransient.lean's; it is OWED to the kernel (not attempted here: the brief forbids repository edits). (5) The sign form
(CouplingSequence.lean's theorem_two) is the case F = 0 of Lemma A′ read in trajectory form.

### 5.3 LEMMA B — the transient is bounded (the record's proof on paper, re-derived; one identity added; the analyticity clause verified at the source)

STATEMENT. β_k(0) := lim_{g_{k−1}→0} b_k exists, is history-free, and equals a(k) = c + f(k) − f(k − 1) with f(0) = 0,
f(k) = c_W − c(S_k), and |f(k)| ≤ F < ∞ for all k; here S_k is the tree-level k-step blocked action (Bałaban's A(U_k(V)), the
fine Wilson action at the minimal configuration), and for a gauge-invariant lattice action S, c(S) := lim_{P→0}[Π_S(P)/P² −
8b₀ ln(1/|P|)], Π_S the transverse one-loop vacuum polarisation of S in its own lattice units; c_W := c(Wilson).

(B0) HISTORY-FREENESS. In the rescaled fluctuation (B = g_{k−1}B′) the Gaussian part of step k is (1/g_{k−1}²)·S_{k−1}″ at
order one, and the history terms E_{k−1} enter the fluctuation's quadratic form at relative order g² (CMP 109 p. 256; d4 §14,
check (1)); so at g → 0 the step is the constrained Gaussian of S_{k−1} alone and β_k(0) depends on k only.

(B-i) THE STAGE IDENTITY AT ONE LOOP (proved; the sign checked). Locally after gauge fixing, U ∈ ℝⁿ, Q : ℝⁿ → ℝᵐ smooth with
surjective differential, S smooth with a non-degenerate constrained minimum U*(V) on {Q = V}. Then
  ∫ dU δ(Q(U) − V) e^{−S(U)/g²} = e^{−S_k(V)/g²} (2πg²)^{(n−m)/2} [det S_k″(V) / det H_λ]^{1/2} (1 + O(g²)),
with S_k(V) = S(U*(V)), λ = S_k′(V), H_λ = S″(U*) − Σ_a λ_a Q_a″(U*). Proof: Laplace's method on the constraint manifold gives
(2πg²)^{(n−m)/2} e^{−S_k/g²} det(dQdQᵀ)^{−1/2} det_{ker dQ}(H_λ)^{−1/2} (the δ-function's coarea factor, and the Hessian of S on
the manifold at a constrained critical point is H_λ on ker dQ). The bordered determinant gives
det[[H, dQᵀ], [dQ, 0]] = det H · det(−dQH⁻¹dQᵀ) = (−1)^m det(dQdQᵀ) det_{ker dQ}(H); differentiating the stationarity equations
(S′ = λ·dQ, Q = V) gives S_k″ = (dQ H_λ⁻¹ dQᵀ)⁻¹. Hence det_{ker} H_λ = det H_λ / (det(dQdQᵀ) det S_k″), and the coarea factor
CANCELS: det(dQdQᵀ)^{−1/2} det_{ker}(H_λ)^{−1/2} = (det S_k″/det H_λ)^{1/2}. ∎ So the one-loop effective action of the k-step
transformation is W_k⁽¹⁾(V) = ½ log det H_λ(U*(V)) − ½ log det S_k″(V) + const (Addendum II §2's identity, re-derived).

(B-ii) COMPOSITION. Hard δ-constraints compose, ∫dU′δ(Q(U′) − V)∫dU δ(Q_{k−1}(U) − U′)e^{−S} = ∫dU δ(Q_k(U) − V)e^{−S} with
Q_k = Q ∘ Q_{k−1} (Bałaban's k-step average, CMP 95 (1.68)); so at one loop Σ_{i≤k} β_i(0) = β(Q_k), the second moment of
W_k⁽¹⁾, and β_k(0) = β(Q_k) − β(Q_{k−1}).

(B-iii) THE IDENTIFICATION β(Q_k) = c·k + c_W − c(S_k) (the step the record states; the two terms it leaves implicit, proved
here). Put V = exp(iεa), a a transverse coarse plane wave of momentum P, and read the ε²P² coefficient as P → 0.
 – The Lagrange term. ½ log det H_λ − ½ log det S″(U*) = −½ Tr(S″(U*)⁻¹⟨λ, Q″(U*)⟩) + O(λ²). λ = S_k′(V) = O(εP²), and the
   factor it multiplies is a gauge-covariant one-loop response which, by locality, is analytic in P and, by gauge covariance,
   vanishes at P = 0; with the hypercubic and reflection symmetry of CMP 109's centred averaging the transverse ε² term is
   O(ε²P⁴). No P² contribution. (O(λ²) = O(ε²P⁴).)
 – The aliases. U*(V) = H_k(εa) + O(ε²), and the fine one-loop functional is translation-invariant on the fine lattice, so its
   ε² term is Σ_l Π_fine(P + 2πl)·|Ĥ_k(P, l)a|²_⊥ over the aliases l. For l = 0, Ĥ_k(P, 0) = 1 + O(P²) (the centred average has
   symbol 1 + O(P²), and the minimal configuration of a smooth coarse field equals its smooth interpolant to that order), giving
   Π_fine(P)(1 + O(P²)) = [8b₀ ln(L^k/|P|) + c_W]P² + O(P⁴ ln P) (P in coarse units, L^k the fine-to-coarse ratio). For l ≠ 0:
   write U* = U_smooth + ψ with U_smooth the smooth interpolant; the Euler–Lagrange equation d*dA = Q*λ makes ψ solve
   d*dψ = r with r = Q*λ − d*dU_smooth = O(εP²), varying at the block scale, so the aliased curl of U* is O(εP²) and its
   contribution is O(ε²P⁴). No P² contribution.
 – Hence the ε²P² coefficient of W_k⁽¹⁾ is [8b₀ ln(L^k/|P|) + c_W] − [8b₀ ln(1/|P|) + c(S_k)] + o(1), and β(Q_k) =
   8b₀ k ln L + c_W − c(S_k): f(k) = c_W − c(S_k), f(0) = 0. ∎

(B-iv) BOUNDEDNESS (the record's (B1)+(B2), Addendum II §§3, 7, 8, accepted at its strength). (B1): c is bounded on the class
𝒮(γ₀, κ, M) — gauge-invariant lattice actions with minimum at the trivial configuration, kernels analytic in a strip of width
κ with bound M, transverse ellipticity Δ ≥ γ₀p̂², invariance under lattice translations, rotations and reflections (THE
SYMMETRY CLAUSE, load-bearing: without it a one-loop term iε_{μνρσ}n_σP_ρ puts a 1/P into β(P)), and Wilson's dimension-four
coefficient; proof: background Feynman gauge (ghost, gauge-fixing vertices and Haar density independent of S, so c(S) − c_W is
a difference of gluon loops), the loop momentum split at k₀, the ultraviolet half bounded by the class constants, the infrared
half fixed to the continuum Yang–Mills integrand by the lattice Ward identities and the symmetry (8b₀ ln(1/p)), remainders
gaining two powers of momentum. (B2): every S_k ∈ 𝒮 with k-independent constants — ellipticity γ₀ = 1 and coefficient a = 1
from the curl contraction ‖dQA‖² ≤ ‖dA‖² in d = 4 (the factor L^{4−d}) and a plane-wave trial; the symmetry from CMP 109's
centred averaging (L odd, contours generated by coordinate permutations, (0.3)–(0.4)); the analyticity READ AT THE SOURCE TODAY:
CMP 102 [15] (on disk, `Downloads/1104114383.pdf`, extracted to `cmp102/cmp102_277.txt`) Theorem 1, p. 279: "The constants
α₀, α₁, B₃ depend on d and L only" (k-uniform), the minimal orbit "a unique critical orbit" for configurations obeying the
regularity condition (7); and §G, Proposition 9, p. 309: "The minimal configuration U_k(V) … has an extension to an analytic
function of G^c-valued small configurations V … It satisfies the conditions (19)–(21) … and its functional derivative (182)
satisfies the inequalities (190)." So F := |c_W| + sup_k |c(S_k)| < ∞.
STATUS: PROVED ON PAPER (the record, 2026-10-29; (B-i)–(B-iii) re-derived here with the Lagrange-term and alias
contributions shown to be O(P⁴); (B-iv)'s analyticity clause confirmed on CMP 102's page). Not kernel-checked; (B1)'s infrared
identification is the step a second reader should take line by line.

(B-v) SHARPENING (not needed for Theorem 2; shape stated). S_k → S_∞, the blocked action of the continuum limit of the centred
averaging, and the hypercubic-and-reflection symmetry removes the odd lattice artefacts, so c(S_k) = c(S_∞) + O(L^{−2k}) and
a(k) = c + O(L^{−2k}): only finitely many first steps can carry a negative transient — the record's negative L = 4 first step
(−0.450 at N = 12, an axial-contour scheme) is of this kind — and f converges.

### 5.4 LEMMA C — the remainder (DERIVED HERE by an exact interpolation; no complex coupling)

SETTING (CMP 109 §2, as the record reads it). Step k + 1 at g := g_k along a trajectory in D_{k+1}. Rescaled fluctuation B
with constrained Gaussian ½⟨B, Δ⁽ᵏ⁾(V)B⟩, δ(Q̃B), background V (the scale-(k+1) field, near 1 for the polarisation), small-field
cutoff χ_k(B) = Π_b χ(|gB(b)| < ε₁) (CMP 109 (2.9)), interaction I = I_W + I_H: I_W the cubic and higher terms of
−(1/g²)A(U_k(V e^{igB})) (the n-th order carrying g^{n−2}), I_H the history E_k(·) minus its value at B = 0, expanded in gB.
The step's output polarisation is that of Ψ_g(V) = log Z^G(V) + log⟨χ_k e^{I}⟩_{G,V} (Z^G the constrained Gaussian, ⟨·⟩_{G,V}
its normalised expectation). With M[·] the infinite-volume second moment of the second background derivative at V = 1
((1.20)–(1.22)), β_{k+1}(g) = M[Ψ_g] and β_{k+1}(0) = M[log Z^G].

THE IDENTITY. For t ∈ [0, 1] let φ(t) = log⟨χ_k e^{tI}⟩_{G,V} and ⟨·⟩_t the normalised measure ∝ χ_k e^{tI} dμ_G. Then φ′(t) =
⟨I⟩_t, φ″(t) = ⟨I; I⟩_t (variance), and Taylor's formula with integral remainder gives, since M is linear,

  β_{k+1}(g) − β_{k+1}(0) = M[log⟨χ_k⟩_G] + M[⟨I⟩_0] + ∫₀¹ (1 − s) M[⟨I; I⟩_s] ds.              (5.C)

(Valid because I is bounded on the cutoff region, so t ↦ φ(t) is C^∞; M commutes with the s-integral by dominated convergence
under the uniform bounds below.) Unlike Cauchy in a complex coupling — which fails because the small-field region scales as
1/g (Addendum II §4) — (5.C) moves only a real parameter in front of the interaction, with the cutoff region frozen.

THE BOUNDS, each input named (the black box B):
 (BB1) the constrained background propagator (Δ⁽ᵏ⁾(V)|_{ker Q̃})⁻¹ analytic in V on an absolute neighbourhood of 1, exponentially
   decaying at the block scale, k-uniformly (CMP 95 (1.64)–(1.67); CMP 99 (3.127)–(3.133));
 (BB2) the Wilson vertices local, |V_n(B)| ≤ C^n Σ_x |B(x)|^n (from CMP 102 Proposition 9's analyticity of U_k(Ve^{igB}));
 (BB3) the history analytic on the complex domain of ABSOLUTE radii α₀, α₁ with |E⁽ʲ⁾(X)| ≤ E₀e^{−κd_j(X)} (CMP 109 p. 263
   (1.17)–(1.18), re-established at every step with the same radii, CMP 116 p. 15);
 (BB4) the cluster expansion of ⟨·⟩_s uniform in s ∈ [0, 1]: CMP 116 gives it at s = 1, and its proof uses only bounds on |I|
   on the domain, which sI satisfies a fortiori;
 (BB5) the infinite-volume limit in (1.22), uniform (the localized representation (1.7)).
Then: (i) |M[log⟨χ_k⟩_G]| ≤ C₁e^{−c₁ε₁²/g²} (Gaussian tails, localized by (BB1), background derivatives by Cauchy on an absolute
radius); (ii) in ⟨I⟩_0 the odd terms vanish — μ_G and χ_k are even in B, and μ_G is centred because the background is the exact
critical point of the leading action (CMP 109 p. 267: "the third, linear term in (2.10) vanishes") — and the even terms are
explicit Gaussian moments: g²⟨V₄⟩_0, the history's second-order term g²⟨(HB)·∇²E_k·(HB)⟩_0/2 ≤ C g²E₀/α₁², and O(g⁴):
|M[⟨I⟩_0]| ≤ C₂ g²(1 + α₁^{−2}); (iii) |M[⟨I; I⟩_s]| ≤ C₃ ε₁² uniformly in s ∈ [0, 1] from the sup bounds alone (|I| ≤ Cε₁|B|²
on the cutoff region, |I_H| ≤ CE₀ε₁/α₁ there), and ≤ C₃′ g²(1 + α₁^{−2}) if the cluster bounds of (BB4) are taken in Gaussian
moment norms (the standard refinement: each interaction factor carries an explicit g against an integrable weight
e^{2ε₁|B|²}). Hence, in CMP 109's small-field model,

  ρ_{k+1}(g) := |β_{k+1}(g) − β_{k+1}(0)| ≤ C(ε₁² + g²) + C₁e^{−c₁ε₁²/g²}   [sup-norm form],
  ρ_{k+1}(g) ≤ C′g² + C₁e^{−c₁ε₁²/g²}                                     [moment-norm form],

uniformly in k and in the histories admitted by Theorem 3. Either form gives ρ < c: in the first take ε₁ with Cε₁² < c/3
(a further smallness condition on Bałaban's ε₁, chosen before γ in his own order) and then γ with Cγ² + C₁e^{−c₁ε₁²/γ²} < c/3.
The two-loop coefficient is part of ρ: ρ ≥ (17/(3π⁴)) ln L · g² + O(g⁴) asymptotically, so the moment-norm form is sharp in
order.

THE COMPLETE MODEL — A SHARPENED PAYABLE, AND A WITHDRAWAL. In CMP 119's complete description the radii are
α_{1,j} = g_jC₁(log g_j^{−2})^{q₁} (2.28). M takes a SECOND BACKGROUND DERIVATIVE, which on a background polydisc of that radius
costs another factor α₁^{−2}: the crude estimate of the history's contribution becomes C E₀ g²/α₁⁴ ~ C E₀/(g²(log g^{−2})^{4q₁}),
which DIVERGES as g → 0. So (5.C) closes only with background analyticity on an ABSOLUTE polydisc around the trivial
background. The record's |β_SF(g) − β_SF(0)| ≤ C′(log g^{−2})^{−2q₁} (Addendum II §4(ii)) applies one Cauchy factor (the
fluctuation direction) and not the one M takes; it is WITHDRAWN as a bound on β, dated 2026-11-02 (the record had itself listed
"the second background derivative" as still to write out). The payable, sharpened: (R) in the complete model, the small-field
effective action that defines β is analytic in the background on an absolute polydisc — true of CMP 109/116's small-field
model by (BB3); for the complete model it is the statement that its small-field part is CMP 109's up to terms
O(e^{−c p₀(g)}) (whose crude Cauchy factors 1/(g² polylog) they then absorb). That is one reading of CMP 119 Sect. 2–3 against
CMP 109 Sect. 1, with one proof shape available if the reading fails: the induction of CMP 109's Theorem 3 run inside the
complete model on the small-field terms, with the complete model's cutoffs (which are smaller regions).
STATUS: PROVED in CMP 109's small-field model given (BB1)–(BB5); REDUCED in the complete model to (R).

### 5.5 LEMMA D — continuity along trajectories (proved, given the uniformity of Bałaban's cluster bounds in the couplings)

STATEMENT. x₀ ↦ b_{k+1}(x₀) is continuous on D_{k+1}.
PROOF. The step map T_k : (x, E) ↦ (β_{k+1}(x, E), E_{k+1}(x, E)) on W × 𝔈 (𝔈 the localized analytic functionals obeying the
inductive bounds, normed by ‖E‖ = sup_X e^{κd(X)} sup_{domain}|E_X|) is continuous: (a) each polymer activity of the cluster
expansion is a finite-dimensional integral whose integrand depends continuously on (g, E) — the Wilson vertices are polynomial
in g, E enters analytically, and the cutoff χ(|gB| < ε₁) moves with g, but ∫χ(|gB| < ε₁)F(B)dμ is continuous in g by
dominated convergence because the moving boundary {|gB(b)| = ε₁} is μ-null; (b) the sum over polymers converges uniformly on
compact parameter sets, by the k- and coupling-uniform bounds (absolute constants, CMP 109 p. 263; CMP 116); (c) the extraction
(1.20)–(1.22) is a bounded linear functional on (𝔈, ‖·‖) (Cauchy on an absolute radius, uniform localization). Then
x₀ ↦ (x_k, E_k) is continuous on D_k by induction (composition), and b_{k+1} = β_{k+1}(x_k, E_k) is continuous on D_{k+1}. In the
complete model the domain moves with g: continuity is taken on the fixed sub-polydisc common to a compact interval of g. ∎

### 5.6 ASSEMBLY (proof of Theorem 2)

Order of choices (Bałaban's own: L first, γ last): L ≥ 2; then Lemma B gives F; then (in the sup-norm form) ε₁ small enough,
then γ₀ with ρ(γ₀) < c (Lemma C) and γ₀ ≤ Bałaban's γ. On D_{k+1}, (H2) is Lemma B; (H1) is Lemma D; (H3) is Lemma C applied
along the trajectory, by induction on k as in Lemma A′'s Remark (2) (the master inequalities at step k from (P) at the steps
≤ k). Lemma A′ gives Theorem 2. ∎
WHAT IT DELIVERS: on the trajectory, LFR II's Theorem 1 holds: the effective densities have Bałaban's form and the ultraviolet
stability bounds χ_k exp[−(1/g_k²)A(U_k) − E₋|T_η|] ≤ ρ_k ≤ exp E₊|T_η| (CMP 122 p. 355 (0.1)) with E± independent of k, T_η, U_k.
THE GROUP SEPARATES HERE: for U(1), c = 0 and Lemma A′ gives no window once ρ > 0 — the chain separates the groups at the
ultraviolet end, as Theorem 8.7 does at the infrared end.

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

## 7. THE CONSTRUCTION INTERFACE (E): WHAT IT NEEDS, WHAT IS AVAILABLE

(E0) LIMITS ALONG SUBSEQUENCES. For COARSE observables (functions of the ultraviolet-stable block variables at a_UV, every
shift u ∈ ∪_j a_jℤ⁴): AVAILABLE, proved here from Theorem 2 + LFR II's Theorem 1. The blocked measures λ_UV^{(j)} are
probability measures on the compact space SU(2)^{coarse links}; for every finite set of coarse links the marginals have weak
limit points (compactness), and a diagonal subsequence over the countably many local coarse observables and shifts gives
infinite-volume limit points (Tychonoff). They are non-degenerate: on the small-field set the density is bounded below by
Bałaban's χ_k exp[−(1/g²)A(U_k) − E₋|T|] and above by exp(E₊|T|) (CMP 122 p. 355 (0.1)) — locally, through the localized
expansion and the large-field Peierls bound — so every limit point is a genuine weak-coupling measure at coupling g_UV (neither
Haar nor a point mass). Theorem 7.4 asks for no more than this: it works along subsequences, for every limit point.
For FINE observables (smeared observables reading below a_UV: smeared loops of the smoothed field, the action density): needs
(S), §6.5.

(E1) UNIQUENESS (convergence without subsequences). OPEN; the object: the Cauchy property of Bałaban's effective action at the
unit scale in the cutoff — for two cutoffs K < K′ on the tuned trajectories with the same unit-scale coupling g,
‖E_K^{unit} − E_{K′}^{unit}‖ ≤ C L^{−αK} in the localized norm. Its mechanism is on Bałaban's page — the j-th step's contribution
seen at the unit scale carries the irrelevance factor (L^jη)^{4+α} (CMP 109 (0.29)) — but he proves bounds, not this Lipschitz
(two-trajectory) version of Theorem 3. Not needed for the gap of every limit point; needed for "the" theory.

(E2) EUCLIDEAN INVARIANCE. OPEN; needs (E1), the vanishing at the physical scale of the O(4)-breaking irrelevant terms
(dimension six and above with the hypercubic symmetry; coefficients O((a/a_UV)²) up to logarithms, again (0.29)'s factor), and a
comparison of differently oriented lattices — universality of the renormalised trajectory, for which nothing is available in
four dimensions (nor in three, where the ultraviolet stability is unconditional, CMP 102 255–275 Theorem 1). The gap theorem
(Theorems 7.4, 8.5) does not need (E2); the Clay statement's axioms do (Corollary 7.5).

(E3) REFLECTION POSITIVITY: free on the lattice, and preserved by coarse observables of a reflection-covariant block map (CMP
109's centred averaging is reflection-covariant; observables at least one block off the plane). (E4) CLUSTERING: from the gap.

THE ACTION-DENSITY CHANNEL IS BAŁABAN'S OWN STRUCTURE (an identity, proved; its theorem OPEN). For h smooth at the physical scale,
  exp(J Σ_p h(p)(1 − ½Re Tr U_p)) · exp(−x₀ Σ_p (1 − ½Re Tr U_p)) = exp(−Σ_p (x₀ − J h(p))(1 − ½Re Tr U_p)):
the generating functional of the plaquette-energy density (the observable without the factor 1/g₀², which is the
renormalisation-group invariant one at leading order — the trace anomaly's F²) is Bałaban's partition function at the
POSITION-DEPENDENT bare inverse coupling x₀(·) = x₀ − Jh(·). His construction already carries position-dependent couplings
1/g_k²(x) (CMP 119 (2.24): 1/g_{j−1}²(x) = 1/g_j²(x) + β_j(g_{j−1})φ_j(x); LFR II (1.14), (1.33)) and their complex extension
("a small perturbation of a positive Wilson action", LFR II p. 366, the reading log); and an ADDITIVE perturbation of x is
preserved by the running (each position's x falls by the same c per step up to the transient and an O(g²) relative correction),
so the source stays O(J) while x_k ≥ 1/γ²: the relative perturbation at the unit scale is |J|·sup|h|·γ², bounded. This is the
cheapest instance (S₁) of (S).
AVAILABLE ELSEWHERE, graded: Magnen–Rivasseau–Sénéor (1993): finite volume, a regularisation of their own, smoothed Wilson loops
"through a compactness argument … the limit is not necessarily unique" (d4 §10, verbatim); the Alpöge–Sussman zeroth draft:
four-dimensional limits along subsequences under declared inputs, tentative by its authors (THE GROUND §6); OpenAI 2026-10-26:
an unrefereed existence claim (the far shore §6). None verified here.

## 8. THE LEDGER — PROVED VERSUS LEFT (sources with pages; "the record" = III-Yang_Mills OPEN/ledger/d4-*.md and III
DOCS/III-APERANTON-ADDENDUM-II, read in full; every Bałaban page cited through the record's verbatim readings except CMP 102
277–309, read on disk)

| Item | Status | Where | Rests on |
|---|---|---|---|
| β = 1/g_B² = 4/g_YM²; the two "β_UV" agree | PROVED | §4 | CMP 109 p. 252 (0.2) |
| one-, two-loop coefficients in Bałaban's units; c(2), c(3) | CERTIFIED (interval, 40 digits) | §3 S-1 | — |
| universality of B₀ = c(L), B₁ = 32b₁ ln L for step maps | PROVED | §4 | — |
| THEOREM 2 (bounded-transient form, (5.1)) | PROVED modulo black box B | §5.1–5.6 | Lemmas A′, B, C, D |
| CouplingTransient.lean's hr is not supplied by the model of record | PROVED (finding) | §5.2 | CMP 119 p. 255, (2.46) |
| Lemma A′ (trajectory IVT, profile propagated) | PROVED, NEW | §5.2 | — (kernel OWED) |
| stage identity at one loop, coarea factor cancels | PROVED (re-derived) | §5.3 (B-i) | — |
| β(Q_k) = ck + c_W − c(S_k): Lagrange term and aliases O(P⁴) | PROVED, the two terms added | §5.3 (B-iii) | CMP 109 (0.3)–(0.4) symmetry |
| transient bounded, |f| ≤ F | PROVED ON PAPER (the record) | Addendum II §§3, 7, 8 | CMP 102 Thm 1 p. 279, Prop. 9 p. 309 (verified on disk); kernel and second reader OWED |
| per-step positivity for k ≥ k₁, f convergent | DERIVED (shape) | §5.3 (B-v) | rate L^{−2k} of S_k → S_∞ |
| Lemma C, CMP 109's small-field model: ρ ≤ C(ε₁² + g²) + tails, sharp form C′g² | PROVED given BB1–BB5 | §5.4, (5.C) | CMP 95, 99, 102, 109 p. 263, 116 p. 15 |
| Lemma C, complete model | REDUCED to (R) | §5.4 | CMP 119 Sect. 2–3 against CMP 109 Sect. 1 |
| the record's (log g⁻²)^{−2q₁} bound on β | WITHDRAWN as insufficient (omits the background derivative) | §5.4 | — |
| Lemma D (continuity along trajectories) | PROVED given coupling-uniform cluster bounds | §5.5 | CMP 109 p. 263; CMP 116 |
| Prop. 6.1: Theorem 8.5 consumes II(a) only averaged | PROVED | §6.1 | THE GROUND §8.3 |
| Prop. 6.2: the path map is UV-degenerate; the H⁻¹ criterion | PROVED (Gaussian level), COMPUTED | §6.2, §3 S-2 | — |
| Remark 6.3: Hypothesis I lives past the crossover; II at a_c contains the window | PROVED (argument) | §6.3 | — |
| Thm 6.3: the tower splits II into UV ⊕ window | PROVED | §6.3 | — |
| Thm 6.4: the Gaussian core for every v | PROVED; decay inputs classical; the layer lemma NAMED | §6.4 | CMP 95, 99 |
| Thm 6.5: II_UV in Forms β, γ | PROVED given (S), (P_LF) | §6.5 | (S) OPEN |
| Prop. 6.6: II exchanged for density (D) | PROVED | §6.6 | (D) OPEN |
| (E0) coarse observables, subsequential, non-degenerate | PROVED | §7 | Thm 2 + LFR II Thm 1 |
| (E1) uniqueness; (E2) Euclidean invariance | OPEN, objects named | §7 | — |
| action density = position-dependent coupling (S₁) | IDENTITY PROVED; the theorem OPEN | §7 | CMP 119 (2.24), LFR II p. 366 |

LEFT, exactly: (R) [one reading, closes Lemma C in the complete model]; the kernel on Lemma A′ and Lemma B, and a second
reader on (B1)'s infrared identification; (S) — first (S₁) — [the ultraviolet fibre and (E) for fine observables]; or (D)
[then Hypothesis II is not needed]; the Gaussian layer lemma r₁ < 1 [only for sup-II(a) at the Gaussian level]; (E1), (E2).
The crossover itself (Hypothesis I at a_c; the window fibre) is not the ultraviolet half's and is not counted here.

## 9. THE PRECISE NEXT OBJECT

(S₁): BAŁABAN'S THEOREM 1 AT A SMOOTH COMPLEX POSITION-DEPENDENT BARE COUPLING. For h ∈ C_c^∞(ℝ⁴) at the physical scale and
complex |J| ≤ J₀, the Wilson measure with per-plaquette inverse coupling x₀ − Jh(p), on the trajectory of Theorem 2, has
effective densities of Bałaban's form at every scale with the position-dependent coupling x_k(·) = x_k − Jh_k(·) + O(J g²), and
a localized effective action at a_UV analytic in J on the disc, with bounds uniform in the cutoff.
Why this one: it is (S) for the action-density (0⁺⁺) channel — the gap's own channel; it lives inside machinery Bałaban already
built (position-dependent couplings, their complex extension, the monotone cutoffs D4b §4 derived); and it delivers at once
Hypothesis II's ultraviolet half in Forms β and γ for that channel (Theorem 6.5), (E0) and — with the Cauchy property of (E1) —
the convergence of the action-density correlations, and the action-density input of (D). The immediate step under it, and the
one that closes Theorem 2 in the complete model: the reading (R) — whether CMP 119's small-field effective action keeps CMP 109's
absolute background radius.

## 10. CROSS-FIELD UNIFICATIONS FOUND

(U1) THE GAUSSIAN CORE OF HYPOTHESIS II IS KRIGING. The fibre covariance of a Gaussian field given linear coarse data does not
depend on the data (Theorem 6.4) — geostatistics' theorem that the kriging variance depends only on the data locations
(Matheron); and its exponential decay at the block scale is the SCREENING EFFECT of spatial statistics (Stein, Ann. Statist. 30
(2002)): conditioning on block data screens the influence of distant data. So "for every coarse configuration" is free at the
Gaussian level for the reason kriging variances are data-free, and the whole difficulty of the sup form is non-Gaussian.
(U2) THE BLOCK-MAP CRITERION IS SOBOLEV CAPACITY. A linear coarse variable is ultraviolet-stable iff its test function lies in
H⁻¹(ℝ⁴), the dual of the free field's Cameron–Martin space; a line (codimension 3) has zero capacity, so the path holonomy's
variance grows like 4G₃(0)·n — Watson's lattice integral, the perimeter divergence of Wilson loops (Polyakov; Dotsenko–Vergeles)
— a one-parameter family of lines (codimension 2) is the logarithmic borderline, a block family is stable (§3 measured all three).
This is why lattice QCD measures smeared or gradient-flowed observables (Lüscher), and it decides which block maps give
Theorem 8.5 content.
(U3) LEMMA A′ IS A DISCRETE WAŻEWSKI / SHOOTING ARGUMENT. Tuning the bare coupling so that x_K = X is a boundary-value problem
for a discrete flow, the exit set is D_kᶜ, and the infimum of the half-line in D_{K+1} is the exit point whose image is forced
below the target by the propagated a-priori bound (P) — the continuation method of nonlinear analysis, with Bałaban's
inductive bounds as the a-priori estimate along the trajectory.
(U4) THE TRANSIENT IS A Λ-PARAMETER RATIO. f(k) = c_W − c(S_k) is 8b₀ ln(Λ_{S_k}/Λ_W) — the Hasenfratz–Hasenfratz/Dashen–Gross
quantity for the k-step block scheme; Lemma B is the statement that these ratios stay bounded along the block-spin flow, and the
universality of B₀ and B₁ is the conjugacy x′ = x + κ₀ + κ₁/x + ….
(U5) THE SOURCE FOR F² IS A COUPLING. The action-density generating functional is a position-dependent coupling — the trace
anomaly read backwards — so the ultraviolet half with sources in the 0⁺⁺ channel is Bałaban's large-field machinery (built to
renormalise position-dependent couplings in large-field regions) turned to observables.

## 11. CORRECTIONS, DATED (2026-11-02, after §§1–10 were written; nothing above edited)

### 11.1 The payable (R) of §5.4 DISSOLVES: the β-functions of record are CMP 109's (creative-solve: the constraint that was belief)

The belief: that the β-function of the sequence of record must be controlled inside CMP 119's complete description, with its
g-proportional radii. The record's own reading log says otherwise:
 – CMP 119 p. 253 (1.27): "the first renormalization group equation 1/g₀² = 1/g₁²(x) + β₁(g₀)φ₁(x). The difference in
   comparison with Eq. (I.0.20) is that here we have functions on the lattice T instead of the constants there, but on
   Λ₁^(~−1) we have the same equation, which defines the same coupling constant g₁."
 – CMP 119 p. 259 (2.24): "the coupling constants g_{j−1} are defined as in (I.0.20)".
 – CMP 119 p. 279: the coupling renormalisation subtracts "β_{k+1}(g_k)A(φ_{k+1}, U_{k+1})" — the function of (I.0.20).
So the coupling sequence of record and its β-functions are CMP 109's small-field objects, and Theorem 2 — a statement about that
sequence — lives entirely in CMP 109's small-field model, where the analyticity radii are absolute (p. 263 (1.17)–(1.18)) and
Theorem 3 assumes only the window ("we do not assume any special asymptotic behavior", p. 259). §5.4's proof of Lemma C in CMP
109's model IS Lemma C for the sequence of record. The complete model's departures from the small-field computation are carried
as its own remainders — R^{(j)} with |R^{(j)}(X)| ≤ g_j^{κ₀}e^{−κd_j(X)} (CMP 119 (2.31)), summed over scales by (2.44)–(2.46),
Σ_{j≤n}g_j^{κ₀} < g_n^{κ₀−6} — which is exactly where the complete model needs the PROFILE, and Theorem 2's (5.1) supplies it along
the trajectory.
CONSEQUENCES. (a) Lemma C: PROVED (given BB1–BB5) for the sequence of record; (R) is withdrawn as a payable. (b) Theorem 2's black
box narrows to the SMALL-FIELD papers — CMP 95, 99, 102 (the operators and minimal configurations), 109 (Theorem 3 and its
inductive assumptions), 116 (the cluster expansion); LFR I–II and CMP 119 enter only downstream, in Theorem 1, which consumes the
window and, through (2.46), the profile. (c) The divergence found in §5.4 stands as a statement about CMP 119's radii: the record's
(log g^{−2})^{−2q₁} bound remains withdrawn as a bound on β, and it was never needed.
FALSIFIER (named, so the reading can be checked by the next reader of CMP 119): a line of CMP 119 or LFR I–II that defines the
coupling of step k+1 from the complete model's OWN marginal coefficient (with its own radii) rather than from (I.0.20).

### 11.2 F2 and §5.2 sharpened (what exactly Lemma A′ repairs)

Since the β-functions are CMP 109's, the right quantifier to compare with is CMP 109's Theorem 3 (p. 264): it controls the actions
"defined inductively by the small field renormalization transformations (0.17)–(0.20)" under the window — i.e. ALONG TRAJECTORIES,
with no profile. CouplingTransient.lean's hr asks for the bound at clamped histories that are not trajectories. In CMP 109's model
those values CAN be supplied — run the construction with prescribed couplings, parametrised by (x_k, E_k), since its inductive step
reads only the current coupling and the history's bounds — but Bałaban states nothing off the recursion; and in the complete model
(whose induction uses the master inequalities (2.6)–(2.9), derived along the trajectory) the clamped histories fall outside the
induction (the scale sum (2.46) fails when a clamp is active). Lemma A′ needs b only on true trajectories: its hypothesis is
Theorem 3's own quantifier, and its propagated profile is what the complete model's (2.46) then consumes. The Lean lemma stays
correct and becomes applicable after the (x, E) extension is written; Lemma A′ needs no extension.

### 11.3 The ledger rows superseded by 11.1–11.2

| Item | Status (superseding §8) | Where |
|---|---|---|
| THEOREM 2 (bounded-transient form) | PROVED modulo the SMALL-FIELD black box (CMP 95, 99, 102, 109 Thm 3, 116) | §5, §11.1 |
| Lemma C for the sequence of record | PROVED given BB1–BB5 (ρ ≤ C(ε₁² + g²) + C₁e^{−c₁ε₁²/g²}; sharp form C′g²) | §5.4, §11.1 |
| (R), the complete-model background radius | WITHDRAWN as a payable (not needed: β is CMP 109's) | §11.1 |
| the Lean hypothesis hr | supplied only after an (x, E) extension Bałaban does not state; Lemma A′ needs none | §11.2 |
| LEFT for Theorem 2 | the kernel on Lemma A′ and Lemma B; a second reader on (B1)'s infrared identification; the falsifier of §11.1 checked on CMP 119 | — |

§9's next object is unchanged: (S₁). The "immediate step under it" named there is now the falsifier check of §11.1 (a reading),
no longer a needed estimate.

### 11.4 Labels carried from an error-propagation pass (what each headline leans on that was not read at its page today)

 – (BB4), the s-uniform cluster expansion, is INFERRED from the structure of CMP 116's proof as the record reads it (its bounds
   use |I| on the analyticity domain; CMP 116 p. 15 re-establishes the domain with the same α₀, α₁); CMP 116 is not on this
   machine. The first page-check for Lemma C is CMP 116 Lemma 1, (1.34)–(1.36).
 – The sup-norm form of Lemma C needs ε₁ shrinkable before γ; Bałaban's ε₁ "depend[s] on M and satisf[ies] numerous
   restrictions" (CMP 109 Theorem 3). If one restriction bounds ε₁ below, the moment-norm form (ρ ≤ C′g²) is the one to use.
 – (P_LF) in §6.5 is a Peierls form of Bałaban's large-field suppression (the factors exp(−p₀(g)·|·|) of CMP 119 p. 244 and LFR I
   p. 175, and the bounds (0.1)), stated here as an input, not quoted as his theorem.
 – Proposition 6.2 is a theorem at the Gaussian level; for interacting SU(2) the equidistribution of the path holonomy is the
   perimeter divergence, established perturbatively, not proved here.
 – Lemma B's (B1) infrared identification is the record's proof on paper; (B-i)–(B-iii) were re-derived here, (B-iv)'s
   analyticity clause read on CMP 102's page, (B1) itself not re-done line by line.
 – §5.3 (B-iii)'s two added terms (the Lagrange term and the aliases, each O(ε²P⁴)) are ORDER-COUNTING without constants
   (r = O(εP²) varying at the block scale ⇒ an aliased curl O(εP²)): DERIVED, not proved, until the constants are carried through
   CMP 102's derivative bounds (190). §8's row "PROVED, the two terms added" is superseded by this word.
 – §8's row "THEOREM 2 … PROVED modulo black box B" is superseded by §11.3: modulo the SMALL-FIELD black box, with (BB4) inferred
   and (B1) the record's proof on paper.
