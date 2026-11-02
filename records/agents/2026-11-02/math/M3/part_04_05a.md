
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
