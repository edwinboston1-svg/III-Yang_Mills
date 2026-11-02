# M6 — THE MIDDLE OF THE WINDOW: THE THRESHOLD β_B AT WHICH BAŁABAN'S RENORMALISATION GROUP CLOSES

Proof agent M6, 2026-11-02. Work directory `.../scratchpad/math/M6/`. Appended as the work proceeds; nothing above a line is
edited after it is written except by a dated correction below it. Labels at their strength: READ (on the rendered page,
image read today), COMPUTED (exact or outward-rounded arithmetic, record named), BOUNDED (a proved inequality, proof here),
ESTIMATED (a number resting on a named assumption about a constant the papers leave implicit), EXISTENTIAL (the papers state
only "sufficiently small/large"; no value can be read off), PROVED (full proof here).

Normalisation (M3 §4, M3R item 1, HOLDS): Wilson's β = 1/g_Bał² = 4/g_YM². Bałaban's threshold γ is in his normalisation,
so β_B = 1/γ² (= 4/γ_YM²). Every β below is Wilson's β, the same β as THE GROUND's 0.2452 / 0.4764 and the crossover's 2.2.

## 0. Sources (orientation)

Read in full before deriving: `math/MATH_BRIEF.md`; `math/M3b/WORK.md` (§§0–15, all); `math/M3R/REVIEW.md` (all);
`math/M3/WORK.md` §§4–5. The eleven papers: `C:\Users\Edwin Boston\Downloads\`, hashed in M3b §0 (table reproduced there).
Text layers `math/M3b/src/cmp*.txt` (pdftotext, formulas destroyed) are used ONLY to locate pages; every page cited below is
read on its rendered image (M3b's `render/*.png` or this directory's `render/*.png`, PyMuPDF via M3b's `bin/render.py`).

## 1. The plan (deep-think synthesis, before deriving)

DECISION. Trace Bałaban's order of choices from the pages: L, then the regularity radius of the minimal configuration
(CMP 102), the propagator constants (CMP 95/96/99), the localisation rates, the fluctuation cutoff ε₁ and the analyticity
radii α₀, α₁, E₀ (CMP 109/116), the large-field function p₀(g) = A₀(log g⁻²)^{p₀} (CMP 119 (2.4)), the R-operation (LFR I–II),
and last γ. For each inequality: its form, its source (page, equation), what fixes its constant (explicit / computable /
existential), and the threshold it imposes on γ when the constant is computed or estimated. Then (a) a NECESSARY condition on
γ for ANY induction of Bałaban's small-field/large-field form — a lower bound on β_B that no computation of constants can
beat, PROVED; (b) computed values of the computable constants; (c) estimates of the existential ones with the assumption
named; (d) the bottleneck and the lemma that would lower it.

WHY THIS OVER A FULL CONSTANT-BY-CONSTANT UPPER BOUND. Bałaban's constants are never tracked numerically (his own words:
"sufficiently small", chosen in an order); a rigorous upper bound on β_B would be a re-proof of the five papers with every
constant explicit. The question to settle — 3–5 or astronomically large — is decided by the FORM of the binding inequalities
and by lower bounds the method cannot evade, which the pages give.

WHAT MOVED THE PLAN (pre-mortem). A purely structural lower bound (Gaussian tail of the fluctuation against the polymer
entropy, the small-field radius at most the group's diameter) is WEAK by itself: with the small-field radius at π it allows
β ≈ 1. The verdict therefore rests on the radii the method actually needs (CMP 102's ε₀, CMP 109's ε₁, CMP 119's ε_k) and on
how the large-field regions are normalised (LFR I) — those pages must be read before any verdict.

KILL-SWITCH. If the pages show the large-field normalisation losing only e^{O(1)} per block and ε₀, ε₁ explicit O(1)
constants, β_B could be O(10²): then the verdict is "10²–10³, not 3–5", not "astronomical".

## 2. READ TODAY (rendered images; the verbatim content each constraint row rests on)

All eleven PDFs re-hashed today: the sixteen-hex SHA-256 prefixes equal M3b §0's table, file for file.

2.1 CMP 119 (Convergent renormalization expansions…), pp. 245–248, 254, 255 [READ].
- p. 245: "a partition into cubes of the size MR₀, where R₀ is the smallest power of L such that R₀ ≥ (log g₀^{−2})^r, r ≥ 2, and
  M = L^m is sufficiently large. The second is a partition into cubes of the size LM₂R₀, M₂ = L^{m₂}, and M₁ < M₂ < M. Let us recall
  that M₁ is the size of large cubes for which all the theorems of the previous papers, especially those concerning the variational
  problem, are valid. We fix M₂ not too much larger that M₁, e.g., we can take M₂ = L²M₁, and M will be chosen much larger than M₂.
  The choice will be dictated by many conditions involving this constant."
- p. 246, the large-field decomposition (1.1) 1 = Σ_{P₀} Π χ({sup_{p⊂□~}|U(∂p) − 1| < ε₀}) Π χ({sup|U(∂p) − 1| ≥ ε₀}): "in the first step we
  take ε₀ = g₀p₀(g₀), p₀(g₀) = A₀(log g₀^{−2})^{p₀}, p₀ ≥ 5r and A₀ is a sufficiently large constant. … If a plaquette p′ is contained in
  (P₀^c)^{(1)}, then Proposition 1 [12] implies that the new field V satisfies the bound |V(∂p′) − 1| < 2L²ε₀." Next step (1.4): the
  threshold ε₁L^{−2}, ε₁ = g₁p₀(g₁); cubes LMR₁ with R₁ ≥ (log g₁^{−2})^r.
- p. 247: (1.6) carries −(L⁴ − 1)|P₁¹| log z (the gauge-fixing normalisation z per site); (1.8) the fluctuation decomposition with
  δ₀ = g₀A₁p₀(g₀) = (A₁/A₀)ε₀: "We assume that the constant A₀ is much larger than A₁."
- p. 248: "By Theorem 1 [15] there exists exactly one critical point of (1.12) in the domain of integration in (1.11), for ε₀
  sufficiently small." ([15] = CMP 102 277–309.)
- p. 255: (2.4) ε_j = g_jA₀(log g_j^{−2})^{p₀} = g_jp₀(g_j); (2.5) R_j the smallest L^n with R_j ≥ (log g_j^{−2})^r; (2.6) the master
  inequalities "where β₀ > 0 can be chosen arbitrarily small, if g is sufficiently small".

2.2 CMP 102 (Variational problem…), pp. 278–279 [READ]. Theorem 1, p. 279: "There exist positive constants a₀, a₁, B₃, B₄(β₀),
M(ε₁), B₃a₁ ≤ a₀, such that for an arbitrary configuration V satisfying (7) with ε₁ ≤ a₁ there exists a minimal orbit in the space
U_k({Ω_j}, B₃ε₁) ∩ V_k(B_k, V). This orbit is a unique critical orbit in the space (6) if B₃ε₁ ≤ ε₀ and ε₀ ≤ a₀. … The constants a₀,
a₁, B₃, depend on d and L only, the constants B₄(β₀), M(ε₁) depend on the indicated parameters also. More exactly
M(ε₁) = R₁M₁(a₁/ε₁). … In the course of the proof the constants B₃, B₄ will be described explicitly." p. 278: condition (7)
|(∂V)(p′) − 1| < ε₁ "for ε₁ sufficiently small".

2.3 LFR I (CMP 122, 175–202), pp. 175–180, 185, 186, 197, 198 [READ].
- p. 175 (0.1): "|U(∂p) − 1| ≥ g₀p₀(g₀) for a plaquette p ∈ T₁, where p₀(g₀) = A₀(log g₀^{−2})^{p₀} with a positive integer p₀. The term
  in the Wilson action … gives the estimate exp[−(1/g₀²)[1 − Re tr U(∂p)]] ≤ exp(−p₀(g₀)) = g₀^{A₀(log g₀^{−2})^{p₀−1}}. … For d = 4 the
  bare coupling constant behaves asymptotically as (a + b log ε^{−1})^{−1/2} … hence the bound does not give any positive power of ε.
  It is still small for ε small, and it controls a large number of steps, but this number is a small fraction of the total number of
  steps." (The reason for the ℝ operation.)
- p. 177: components of size ≤ 100MR_k; "(ii) in the preceding N renormalization steps no new large field regions were created inside
  this component".
- p. 185, after (1.38): "The quotient [p₁(g_j)/p₀(g_j)] on the right-hand side of the last equality is a negative power of log g_j^{−2},
  hence the coefficient at δ_j can be arbitrarily small, also after multiplying it by O(1)L from (1.37), if γ is sufficiently small."
- p. 186: "We choose M large enough, so that δ(M/M₁) ≥ 2. … The remaining numerical factors … can be estimated by
  9B₃(A₁/A₀)(p₁(γ)/p₀(γ))(1 + β₀), and can be made arbitrarily small by choosing γ, or A₁/A₀ sufficiently small. Notice, that the
  conditions on M, γ, A₀, and A₁ introduced above do not depend on any scale … The numerical factor 8B₃L^{−i}δ′_j < 8B₃γA₁p₁(γ) can be
  also chosen arbitrarily small for γ sufficiently small."
- p. 197: (1.83) |V_Λ(b) − 1| < O(1)B₅M⁶ε_k; (1.84) |M^j(U₀) − 1| < O(1)B₃B₅M⁶ε_k; (1.87) |𝔸₀|, |∇^η𝔸₀|, |∂^{η*}∂^η𝔸₀| < O(1)B₃²B₅M⁶ε_k
  — the field must lie in the domain where the axial/Landau gauge representation U₀ = exp iη𝔸₀ is analytic.
- p. 198, after (1.94): "The last inequality holds under two restrictions on N. At first, we assume that N ≤ O(1)(log g_k^{−2})^ν ≤
  O(1)(1 + β₀)(log g_h^{−2})^ν with a positive integer ν satisfying (1/2)ν ≤ p₀ − p₁ − 1. The second is that N has to be sufficiently
  large, so that the constant in the second term above can be bounded by (1/2)α."

2.4 LFR II (CMP 122, 355–392), pp. 355–358, 362, 363 [READ].
- p. 355, Theorem 1: "If the sequence of the effective coupling constants is contained in an interval ]0, γ] with a sufficiently small
  positive γ, then the effective densities ρ_k have the form, and satisfy all the conditions and bounds, described in Sect. 2 [III]."
  The proof of Theorem 2 "has not been published yet, so we have Theorem 1 with the assumption."
- p. 356: the denominator ∫dV′… = exp[−(1/g_k²)A(ζ₀, U₀) + (−½d(g) log g_k^{−2} + log σ₀)|Λ^{(k)}\G₀|]∫dB′…χ({|B′| < M₀g_k^{−1}ε_k}).
- p. 357, (1.6): the boundary term "< 3B₃M₀A₀²p₀²(g_k)exp(−R_k)(100M)⁴ … it is enough to have an absolute bound, e.g., the number 1."
- p. 358, (1.7)–(1.9): ⟨H B′, Δ₁(ζ₀)H B′⟩ ≥ γ₀‖∂B′‖² − O(1)(M⁶R_kε_k + exp(−R_k))‖B′‖²; Σ|B′(b)|² ≤ d(100M)^{d+1}Σ|(∂B′)(p)|²
  (axial gauge in a cube of size 100M); hence ⟨H B′, Δ₁H B′⟩ ≥ (γ₀/(2d(100M)⁵))‖B′‖² "for g_k sufficiently small": the condition
  O(1)(M⁶R_kε_k + e^{−R_k}) ≤ γ₀/(2d(100M)^{d+1}). The same bounds are needed "with ε_k replaced by O(α_{0,k} + α_{1,k}). This is an
  unessential change; it may result only in stronger restrictions on g_k, or γ." (1.10) E_k(Λ) = (−½d(g)log g_k^{−2} + log σ₀)|Λ^{(k)}\G₀|;
  (1.11) |I(U₀)| < O(1)log M|Λ| < O(1)M⁵.
- p. 362: the second term "≤ g_k²O(1)A₀²B₃²B₅M^{d+5}R_k^{d+1}p₀²(g_k)exp(−R_k), and the number multiplying g_k² can be made arbitrarily
  small for g_k small enough."
- p. 363: "bounded by g_k²L^{−(d−1)N}N^{(d−1)β₀}O(1)A₀²B₃²B₅M^{d+5}R_k^{d−1}p₀²(g_k). The number multiplying g_k² is small if L^{−N} is small
  enough, for example if L^{−N} ≤ (log g_k^{−2})^{−v} for sufficiently large v, or N ≥ (v/log L) log log g_k^{−2}. For the smallness of the
  above bound we need v ≥ 2p₀ + dr₀."

2.5 CMP 116 (II. Cluster expansions), pp. 3–11, 13, 17, 18 [READ; pp. 7–13 on M3b's renders, read today].
- p. 3, (1.6)–(1.7): the propagators as generalized random walks Σ_ω R₀(X₀)R_{α₁}(X₁)…R_{αₙ}(Xₙ), localization domains of M₁-cubes;
  each walk bounded by O(1)O(M₁^{−1/2})^{|ω|}M₁^{−½|ω|}exp(−δ₀d(ω, y, y′)): "The first two factors in (1.7) are used to control the
  sum over ω, and they determine the constant B₀." "The number R₁ is a power of L satisfying the condition R₁M₁M^{−1} ≤ 1."
- p. 5: the decoupling parameters s(Δ) "are complex valued and satisfy the bound |s(Δ)| ≤ e^{κ₁} for Δ ⊂ Y₀\□~⁴, κ₁ is a sufficiently
  big positive number." (1.11) B₀|X| sup_ω M₁^{−½|ω|}exp(−δ₀d(ω))e^{mκ₁}: "If m is big enough, e.g. m > 2⁴, then δ₀d(ω) ≥ δ₁mM, for a
  positive constant δ₁ depending on δ₀ only, and we can bound the expression under the supremum in (1.11) by 1, for δ₁M ≥ κ₁. If
  m ≤ 2⁴, then we can have short walks … and the expression can be bounded by e^{16κ₁} only. Thus the function H(s(Y₀))X is an analytic
  function of the variables s(Y₀) on the domain |s(Y₀)| ≤ e^{κ₁}, bounded by B₀e^{16κ₁}|X|". (1.13): the fixed-point map is a contraction
  "for ε₂ satisfying 4C₂B₀e^{16κ₁}ε₂ ≤ 1".
- p. 6: (1.15) holds "if 4C₄B₀²e^{32κ₁}ε₃ ≤ 1", "and we assume that 2B₀e^{16κ₁}ε₃ ≤ ε₂"; (1.20) |B′| ≤ C₁g_k|B| < C₁ε₁ "where C₁ is an
  absolute constant, and g_k|B| < ε₁".
- p. 7: (1.21) |H_k(s(Y₀), B′)| ≤ 4B₀C₁e^{16κ₁}g_k|B| < 4B₀C₁e^{16κ₁}ε₁, "if e^{32κ₁}ε₁ is smaller than an absolute constant. … We assume
  that 4B₀C₁e^{16κ₁}ε₁ ≤ ¼α₂"; (1.22) 1/|t_□| = 8B₀C₁e^{16κ₁}α₂^{−1}g_k|B|.
- p. 8: (1.26) Σ_{X∋□′}exp(−κd_j(X)) ≤ O(1) "for κ sufficiently large"; the sum over j "bounded by 2(6L)⁴"; (1.27)
  exp(8·12³exp(−½(κ₁ − 1))) ≤ e "for κ₁ sufficiently large"; (1.28) M^{−4}|Y| ≤ 3·2³d_k(Y) ≤ exp((1/16)(κ₁ − 2)d_k(Y)); (1.29)
  |Σ(1.23)| ≤ E₀ε₁O(M^q)exp O(1)κ₁ exp(−(1/16)κ₁d_k(Y)); "Another possibility is to use the expression g_k|B| instead of ε₁."
- p. 9: (1.32) "if ¼(κ₁ − 1) ≥ (1 − δ)κ, 0 < δ < 1"; "We assume that (1/16)κ₁ ≥ (1 − 2δ)κ"; Lemma 1 (1.36):
  |V′_k(Y, U, J, B)| ≤ E₀ε₁C₁M^q exp C₂κ₁ exp(−(1 − 2δ)κd_k(Y)), "absolute constants C₁, C₂, q".
- p. 10: (1.39) |(1.38)| ≤ C₃(e^{16κ₁}|B′|)³M⁴exp(−(κ₁ − 1)M^{−4}|Y\□|); (1.40) the second-order coefficients of the Wilson part
  ≤ ½C₃3³e^{7·8κ₁}|B′|exp(−⅛(κ₁ − 1)d_k(Y) − ½(κ₁ − 1)M^{−4}|Y|) "if e^{16κ₁}|B′| ≤ ⅓a₁".
- p. 11, Lemma 2 (1.43): the quadratic form's matrix elements |Q(Y, B, b, b′)| ≤ C₃ε₁M⁴exp C₂κ₁ exp(−⅛(κ₁ − 1)d_k(Y) − ½(κ₁ − 1)M^{−4}|Y|).
  (Reading (1.40) into (1.43): C₂ ≥ 7·8 = 56.)
- p. 13, (2.7): (C^{(k)})^{1/2} expanded "if γ₁ is sufficiently large".
- p. 17: (2.23) α₅ = O(1)e^{−(1/3)δ₀M} + O(α₀ + α₁) + O(1)α₄ + γ₂, "we have assumed that α₅ is sufficiently small, e.g.
  α₅‖C^{(k)}(Z₀, 0)‖ < ½"; (2.26) |(2.14)| ≤ exp(−(κ₁ − 1)(LM)^{−4}|Z\Z′₀|)[Π_{Y∈D}2E₀ε₁C₁α₄^{−1}M^q exp C₂κ₁ exp(−(1 − 3δ)κd_k(Y))]
  · exp(−½γ₂(ε₁²/g_k²)|P|) exp O(1)α₅|Z|.
- p. 18: "Assuming 2E₀ε₁C₁α₄^{−1}α₆^{−1}M^q exp C₂κ₁ exp 5κ ≤ 1" (2.28); (2.29) Σ_DΠα₆exp(−δκd_k(Y)) ≤ 1 "for κ sufficiently large and
  α₆ sufficiently small"; (2.31) Σ_P exp(−(1/20)γ₂(ε₁²/g_k²)M^{−4}|Z₀\Y₀|)exp(−(1/10)γ₂(ε₁²/g_k²)|P|) ≤ exp{−M^{−4}|Z₀\Y₀|[(1/20)γ₂ε₁²/g_k²
  − 4M⁴exp(−(1/10)γ₂ε₁²/g_k²)]} ≤ 1 "for g_k², i.e. γ² sufficiently small, depending on M and κ"; then "Assuming
  (1/20)γ₂ε₁²/g_k² ≥ (1/20)γ₂ε₁²/γ² ≥ 4κ".

2.6 CMP 116 pp. 19, 21; CMP 109 pp. 259, 263, 264, 266; CMP 95 pp. 35, 38; LFR II pp. 387, 388 [READ]. Zoomed at 230 dpi
(`render/cmp116_10_eq140.png`, `render/cmp116_8_eq127.png`): (1.40) reads "½C₃3³e^{7·8κ₁}|B′|" and (1.27) "exp(8·12³exp(−½(κ₁ − 1))) ≤ e"
(the centred dot is CMP's product sign, as in 8·12³ and 3·2³ on the same page; read as a decimal point, 7.8, the bottleneck exponent
below falls by the factor 56/7.8 and stays astronomical — §4).
- CMP 116 p. 19: ε₂ := 2E₀ε₁C₁α₄^{−1}α₆^{−1}M^q exp C₂κ₁ ≤ 1 ("We have used the assumption ε₂ ≤ 1"); "For simplicity let us assume that
  exp(−(1/20)γ₂ε₁²/γ²) ≤ ε₂." p. 21: "At first we assume that (1 − 10δ)½L = 1, or δ = (1/10)(1 − 2L^{−1}). Next, we assume that
  O(1)C₃ε₁ ≤ ½E₀. … we take M sufficiently large, so that δ₀M ≥ κ." (2.41) |E^{(k+1)}(X)| ≤ O(1)C₃ε₁exp(−(1 − 10δ)½Lκd_{k+1}(X)).
- CMP 109 p. 259, Theorem 1 ("contained in an interval ]0, γ] with a sufficiently small positive γ") and Theorem 2 (0.31). p. 263,
  (1.18) |E^{(j)}(X, g_{j−1}, U, J)| ≤ E₀exp(−κd_j(X)) "for M ≥ M(κ), γ sufficiently small"; α₀, α₁ "positive, absolute constants".
  p. 264, Theorem 3: "There exist positive constants κ₀, M(κ), γ, ε₀, ε₁, α₀, α₁, such that, if κ ≥ κ₀, M ≥ M(κ), 0 < g_k ≤ γ for
  k = 0, 1, …, K, then the sequence of actions A_k … satisfy all the inductive assumptions … The constants ε₀, ε₁, α₀, α₁ depend on M
  and satisfy numerous restrictions, which will become clear in the proof. The constant γ depends on all other constants." p. 266,
  (2.9) χ_k = Π_b χ({|B′(b)| < ε₁}); "Another possibility is to take g_k/γ_kε₁ instead of ε₁, where γ_k = C log(L^kε)^{−1} with C
  sufficiently large"; "|H_k| < a₁, with an absolute, positive constant a₁".
- CMP 95 p. 35, Proposition 1.2: "There exists a positive constant δ₀ depending on d only, such that |(GJ)(x)|, |(∇GJ)(x)|, …
  ≤ O(1)e^{−δ₀|y−y′|}|J| (1.110) … with the constant O(1) depending on d only". p. 38: "Defining 2δ₀ = min{⅓δ′₀, M₀^{−1}}", (1.131)
  the walk sum Σ_n O(1)^{2n}M₀^{−n}(Σ_x e^{−δ₀M₀|x|})ⁿ — so δ₀ ≤ 1/(2M₀) with M₀ large enough for the walk series to converge.
- LFR II p. 387, (1.87)–(1.88): the large-field index inequality closes "for p₀ large and γ small enough" by
  −2(1 + β₀)^{−1}p₀(g_{j+1}) + O(1)3(100M)^dR_{j+1}^{d+2} ≤ 0; (1.89) T′_k(X)1 ≤ exp(−2(1 + β₀)^{−1}p₀(g_k)). p. 388, (1.93): "α is
  sufficiently small, e.g., α^{1/3} ≤ exp(−(1 + β)κ2d)", α the small-field activity factor.

## 3. THE ORDER OF CHOICES AND THE CONSTRAINT CHAIN (assembled from §2; every link READ)

CMP 109 Theorem 3 fixes the order: κ ≥ κ₀, then M ≥ M(κ), then ε₀, ε₁, α₀, α₁ (depending on M), then γ (depending on all). CMP 116
adds κ₁ (the radius e^{κ₁} of the complex decoupling parameters) and δ = (1 − 2/L)/10; CMP 119 and LFR I–II add L, M₁ < M₂ < M,
R_j ≥ (log g_j^{−2})^r (r ≥ 2), the large-field function p₀(g) = A₀(log g^{−2})^{p₀}, A₁ ≪ A₀, p₁ < p₀, N, ν. The chain that pins γ:

 (K1) κ₁ ≥ 1 + 2 ln(8·12³)                                  CMP 116 (1.27), p. 8   [explicit; COMPUTED §4]
 (K2) κ₁ ≥ 16(1 − 2δ)κ, δ = (1/10)(1 − 2/L)                  CMP 116 p. 9 and p. 21  [explicit given κ]
 (K3) C₂ ≥ 56 (the e^{7·8κ₁} of the quadratic form)          CMP 116 (1.40) → (1.43), pp. 10–11  [explicit]
 (K4) ε₁ ≤ α₄α₆ e^{−C₂κ₁} / (2E₀C₁M^q)                         CMP 116 (2.28), pp. 18–19  [form explicit; α₄, α₆, E₀, C₁, q existential]
 (K5) γ² ≤ γ₂ε₁²/(80κ)  and  γ² ≤ γ₂ε₁²/(20 log(1/ε₂))           CMP 116 (2.31) and p. 19  [explicit]
 Hence  log β_B = log γ^{−2} ≥ 2C₂κ₁ + log(80κ/γ₂) + 2 log(2E₀C₁M^q/(α₄α₆)).                                      (3.1)

## 4. STAKES (written before `bin/m6_thresholds.py` runs; nothing here edited after)

S-1  κ₁,min from (K1) = 1 + 2 ln 13824 ∈ [20.06, 20.08].
S-2  The CMP 116 chain (3.1) at C₂ = 56, κ₁ = κ₁,min, κ = 1, γ₂ = 1, 2E₀C₁M^q/(α₄α₆) = 1 (every implicit constant at the value most
     favourable to a small threshold): log₁₀ β_B ∈ [970, 985]. Readings: C₂ = 7.8 (decimal-point reading) → log₁₀ β_B ≈ 136;
     κ₁ = 2 + 16 ln 24 (the (1.28) reading at d_k(Y) = 1) → ≈ 2570; κ = 3 in (K2) (κ₁ = 44.8) → ≈ 2180.
S-3  The large-field definition alone (CMP 119 (2.4); ε(g) = gA₀(log g^{−2})^{p₀} must stay below diam SU(2) = 2 for the decomposition
     (1.1) to be non-vacuous) at A₀ = 1: p₀ = 10 → X* = log γ^{−2} ≈ 88.6, log₁₀ β ≈ 38.5; p₀ = 13 → X* ≈ 123, log₁₀ β ≈ 53.4.
S-4  The complete-model variant (fluctuation threshold δ_k = g_kA₁(log g_k^{−2})^{p₀} in place of ε₁ in (K4), p₀ = 13, A₁ = 1):
     log₁₀ β_B ≈ 1043 ± 15.
S-5  LFR II (1.9) with p₀ = 13, r = 2, M = 729 (= 3⁶), d = 4, A₀ = γ₀ = O(1) = 1: log₁₀ β ≈ 165 ± 10.
S-6  The architecture-free floor (§6): Shearer's radius for the 20-regular plaquette-adjacency graph z_c = 19¹⁹/20²⁰ ≈ 0.01887; the χ²₃
     tail t with P(χ²₃ ≥ t) = z_c, t ≈ 9.98; p_min = (t/2)^{1/2} ≈ 2.23; required small-field radius ε(β) = p_min/√β ≈ 1.29 / 1.12 / 1.00
     at β = 3 / 4 / 5 (rotation angles ≈ 80° / 68° / 60°).

## 5. RESULTS OF RUN a (record `rec/thresholds_run.2026-11-02a.txt`, rc = 0; nothing in §4 edited)

S-1 HELD: κ₁,min = 1 + 2 ln 13824 = 20.068322982087673717… (interval width < 10⁻⁴⁹).
S-2 HELD: the literal chain (3.1) gives log β_B ≥ 2252.0342006, log₁₀ β_B ≥ 978.04602639. Readings: decimal C₂ = 7.8 → 137.866 (staked
     ≈ 136); (1.28) at d = 1 → 2572.52 (staked ≈ 2570); κ = 3 in (K2) → 2181.50 (staked ≈ 2180). (1.27) relaxed and κ₁ optimised
     freely: min_κ₁[56κ₁ + 13824e^{−(κ₁−1)/2}] = 707.354 at κ₁ = 10.631 → log₁₀ β_B ≥ 614.40 — but κ₁ = 10.63 violates (K2) unless
     κ ≤ 0.712; with (K2) at κ = 1 the relaxed value is log₁₀ β_B ≥ 737.69.
S-3 NEAR, NOT AS STAKED: p₀ = 10, A₀ = 1 → the vacuity ends at X* = 88.2075588508 (staked 88.6), log₁₀ β = 38.308 (staked 38.5); p₀ = 13
     → X* = 123.925374313 (staked 123), log₁₀ β = 53.820 (staked 53.4). The hand estimates were off by 0.4 in X; the computed values
     stand. The vacuity BEGINS at X = 1.1343 (β = 3.109) for p₀ = 10: for every β in (3.109, 2.03·10³⁸) the threshold ε(g) exceeds the
     diameter 2 of SU(2). (p₀ = 12: 48.562; A₀ = 10 adds 2.6 decades at each p₀.)
S-4 REFUTED AS STAKED: the complete-model variant at p₀ = 13 gives log₁₀ β_B = 1064.264, outside 1043 ± 15; the staked number is the
     p₀ = 10 value (1043.759). Both stand as computed.
S-5 HELD: LFR II (1.9), p₀ = 13, r = 2, M = 729 → log₁₀ β = 161.93 (p₀ = 10: 145.38; M = 27: 111.09 / 127.31).
     LFR II (1.88) pinched against LFR I (1.87), r = 2: log₁₀ β = 101.87 (M = 27), 133.30 (M = 729).
S-6 HELD: z_c = 19¹⁹/20²⁰ = 0.0188676801…; t* = 9.9648058193 (staked ≈ 9.98); p_min = 2.2321296803; ε(β) = 1.28872 / 1.11606 / 0.99824 at
     β = 3 / 4 / 5 (80.24° / 67.84° / 59.88°). Free-field input checked exactly: rank(d₁)/#plaquettes = (dV − V + 1 − d)/(d(d−1)V/2) →
     2/d = ½ per colour component (0.49383 at V = 3⁴). Floors (p_min/a)²: a = √2 → 2.4912; a = 1 → 4.9824; 0.5 → 19.930; 0.3 → 55.360;
     0.1 → 498.24; 0.01 → 49824.

STAKES FOR RUN b (`bin/m6_thresholds_b.py`, written before it runs): (B1) CMP 116 (1.40) domain + (2.31): log₁₀ β ≈ 280.8; (B2) (1.21) +
(2.31): ≈ 559.7; (B3) (2.28) + LFR II (1.93) at κ = 1: ≈ 998.9; (B4) LFR II (1.88) × LFR I (1.87) at fixed R = 1: ≈ 45.0 (M = 27),
≈ 73.6 (M = 729); (B5) the (1.88) entropy alone at R = 1: ≈ 27.8 (M = 27), ≈ 39.3 (M = 729).

## 5b. RESULTS OF RUN b (record `rec/thresholds_run.2026-11-02b.txt`, rc = 0; stakes above unedited) — ALL HELD

(B1) 280.80107; (B2) 559.69905; (B3) 998.89216; (B4) 44.979 (M = 27), 54.522 (81), 64.064 (243), 73.607 (729); (B5) 27.803 (M = 27),
31.620 (81), 35.437 (243), 39.254 (729) — each a log₁₀ β, intervals of width < 10⁻⁴⁸.

## 6. THE ARCHITECTURE-FREE FLOOR (inputs COMPUTED; its status as a necessary condition ESTIMATED, the assumption named)

Every renormalisation step of Bałaban's kind splits field space by a plaquette threshold: small field |U(∂p) − 1| < ε, expanded around
U = 1 with a Gaussian of covariance proportional to g²; large field, controlled by the action's suppression alone. Write ε = pg
(g = g_B, β = 1/g²).

(i) FREE-FIELD INPUT (PROVED). Linearising U_ℓ = exp(iα_ℓ·σ), θ_p = (dα)_p and S_p = (1/g²)(1 − cos|θ_p|) = Σ_a(θ^a_p)²/(2g²) + O(θ⁴): per
colour, the lattice Maxwell field with e² = g². On the torus (V sites) equipartition gives Σ_p⟨(θ^a_p)²⟩ = g²·rank d₁ = g²(dV − (V − 1) − d)
over d(d − 1)V/2 plaquettes, all equal by symmetry, so ⟨(θ^a_p)²⟩ → (2/d)g² = g²/2 at d = 4 (run a: 0.49383 at V = 81). Check:
⟨1 − ½Tr U_p⟩ ≈ ⟨|θ|²⟩/2 = 3/(4β), the standard leading term; and |U_p − 1| = 2 sin(|θ_p|/2) ≈ |θ_p|.

(ii) THE BAD EVENT. P(|θ_p| ≥ ε) = P(χ²₃ ≥ 2p²) at the Gaussian density.

(iii) SPARSENESS. Two plaquettes sharing a link are dependent; each plaquette shares a link with Δ = 4·(2(d − 1) − 1) = 20 others. The
large-field set is a hard-core polymer gas on this 20-regular graph; its cluster expansion converges on every graph of maximal degree Δ
exactly when the activity is at most Shearer's z_c(Δ) = (Δ − 1)^{Δ−1}/Δ^Δ = 0.0188676801… (Shearer 1985; the optimal form of the Lovász
Local Lemma for bad events of dependency degree Δ). ASSUMPTION (named): the large-field activities are at least the Gaussian probability
of the bad event, and the plaquette graph's own radius lies within some per cent of the tree value (for ℤ² hard squares the ratio is
1.13; a 13 % change of z_c moves p_min by 1.3 %).

(iv) THE FLOOR. P(χ²₃ ≥ 2p²) ≤ z_c ⇔ p ≥ p_min = 2.2321296803 (run a). A small-field radius a — the largest ε at which the step's
perturbative machinery holds — then forces β ≥ (p_min/a)² = 4.9824/a². Conversely, at β = 3 / 4 / 5 the threshold must be
ε = 1.2887 / 1.1161 / 0.9982: plaquette rotations of 80.2° / 67.8° / 59.9°, where the radial eigenvalue cos φ of the single-plaquette
Hessian of 1 − cos φ is down to 0.17 / 0.38 / 0.50. The convexity edge φ = 90° (a = √2) gives the absolute floor β ≥ 2.4912.

VERDICT OF §6. Counting alone does not exclude 3–5; every construction whose small-field radius is below 1 does — and every
construction on record has a ≪ 1 (Bałaban's a₀, a₁ "depend on d and L only" and are used "for ε₀ sufficiently small"; his ε_k reappears
multiplied by 2L² = 18 at the next scale, CMP 119 p. 246).

## 7. THE TABLE

Each constraint, its source (READ on the rendered page today), its form, the threshold it imposes, its strength. "log₁₀ β forced" is the
least log₁₀ β_B at which the printed inequality can hold with every implicit constant at its value most favourable to a small threshold
(1, or the least value the page allows). COMPUTED = certified interval arithmetic, records a and b.

| # | Constraint | Source | Form on the page | log₁₀ β forced | Strength |
|---|---|---|---|---|---|
| T1 | regularity of the minimal configuration | CMP 102 Thm 1, p. 279 | ε₁ ≤ a₁, B₃ε₁ ≤ ε₀ ≤ a₀; a₀, a₁, B₃ "depend on d and L only"; M(ε₁) = R₁M₁(a₁/ε₁) | enters every ε_k row | EXISTENTIAL |
| T2 | block propagator decay | CMP 95 Prop. 1.2, p. 35; p. 38 | |(GJ)(x)| ≤ O(1)e^{−δ₀|y−y′|}|J|, δ₀ = δ₀(d); 2δ₀ = min(δ₀′/3, 1/M₀) | through M ≥ κ/δ₀ (CMP 116 p. 21), δ₁M ≥ κ₁ (p. 5), δ(M/M₁) ≥ 2 (LFR I p. 186): polynomial in M | EXISTENTIAL |
| T3 | random-walk series | CMP 116 (1.7), p. 3 | O(1)O(M₁^{−1/2})^{|ω|} per walk | M₁ large; polynomial | EXISTENTIAL |
| T4 | order of choices | CMP 109 Thm 3, p. 264 | κ ≥ κ₀, M ≥ M(κ); ε₀, ε₁, α₀, α₁ depend on M; γ on all | — | EXISTENTIAL |
| T5 | localisation sums | CMP 109 (1.18) p. 263; CMP 116 (1.26) p. 8, (2.29) p. 18 | Σ_{X∋□}e^{−κd(X)} ≤ O(1) "for κ sufficiently large" | κ₀ ≥ ln(animal growth) | EXISTENTIAL |
| T6 | decoupling radius | CMP 116 (1.27), p. 8 | exp(8·12³e^{−(κ₁−1)/2}) ≤ e | κ₁ ≥ 20.068323 | COMPUTED |
| T7 | decoupling against decay | CMP 116 p. 9, p. 21 | κ₁/16 ≥ (1 − 2δ)κ, δ = (1 − 2/L)/10 | κ₁ ≥ 14.9333κ (L = 3) | COMPUTED |
| T8 | amplified quadratic form | CMP 116 (1.40)→(1.43), pp. 10–11 | ½C₃3³e^{7·8κ₁}|B′| ⇒ C₂ ≥ 56 | — | READ at 230 dpi |
| T9 | fluctuation domain | CMP 116 (1.40), p. 10 | e^{16κ₁}|B′| ≤ a₁/3, |B′| ≤ C₁ε₁ | 280.80 (with T12) | COMPUTED |
| T10 | minimiser contraction | CMP 116 (1.13), (1.15), (1.21), pp. 5–7 | 4C₄B₀²e^{32κ₁}ε₃ ≤ 1; "e^{32κ₁}ε₁ smaller than an absolute constant" | 559.70 (with T12) | COMPUTED |
| **T11** | **polymer activity ≤ 1** | **CMP 116 (2.28), pp. 18–19** | **2E₀ε₁C₁α₄⁻¹α₆⁻¹M^q e^{C₂κ₁}e^{5κ} ≤ 1** | **978.05** literal; 737.69 with (1.27) relaxed (κ = 1); 2181.50 at κ = 3; 2572.52 with (1.28) read at d = 1; 137.87 if 7·8 meant 7.8 | **COMPUTED; prefactor EXISTENTIAL** |
| **T12** | **fluctuation tail against entropy** | **CMP 116 (2.31), pp. 18–19** | **(1/20)γ₂ε₁²/γ² ≥ 4κ; e^{−γ₂ε₁²/(20γ²)} ≤ ε₂** | **γ ≤ ε₁(γ₂/(80κ))^{1/2}** | **READ** |
| T13 | complete model (δ_k in place of ε₁ in T11) | CMP 119 (1.8), p. 247 | δ_k = g_kA₁p₀(g_k) | 1043.76 (p₀ = 10), 1064.26 (p₀ = 13) | COMPUTED |
| T14 | ℝ-operation tree bound | LFR II (1.93) p. 388; α of (1.68) p. 377 | α^{1/3} ≤ e^{−(1+β)κ2d} | 998.89 together with T11 (κ = 1) | COMPUTED |
| T15 | large-field function | CMP 119 pp. 245–246; (2.4) p. 255 | ε_k = g_kA₀(log g_k^{−2})^{p₀}, p₀ ≥ 5r, r ≥ 2, "A₀ sufficiently large" | ε ≥ 2 = diam SU(2) for 3.109 < β < 2.03·10³⁸: 38.31 (p₀ = 10), 48.56 (12), 53.82 (13); +2.6 at A₀ = 10 | COMPUTED |
| T16 | analyticity near large fields | LFR I (1.83)–(1.87), p. 197 | |𝔸₀| < O(1)B₃²B₅M⁶ε_k inside the analyticity radius | with T17 | READ |
| T17 | large-field suppression against region entropy | LFR II (1.87)–(1.89), p. 387 | 2(1 + β₀)⁻¹p₀(g) ≥ O(1)3(100M)^dR^{d+2}; T′_k1 ≤ e^{−2p₀(g)/(1+β₀)} | pinched with T16: 101.87 (M = 27), 133.30 (M = 729) at r = 2; 44.98–73.61 at fixed R = 1; the entropy alone 27.80–39.25 | COMPUTED |
| T18 | positivity in a large-field cube | LFR II (1.7)–(1.9), p. 358 | O(1)(M⁶R_kε_k + e^{−R_k}) ≤ γ₀/(2d(100M)^{d+1}) | 111.09–161.93 | COMPUTED |
| T19 | boundary term | LFR II (1.6), p. 357 | 3B₃M₀A₀²p₀²(g)e^{−R}(100M)⁴ ≤ 1 | not binding (R ≥ (log g⁻²)²) | COMPUTED in form |
| T20 | N-window of the ℝ-operation | LFR I (1.94) p. 198; LFR II (1.29) p. 363 | ((2p₀ + dr₀)/ln L)·ln log g⁻² ≤ N ≤ O(1)(log g⁻²)^ν, ½ν ≤ p₀ − p₁ − 1 | not binding | READ |
| T21 | small quotients | LFR I (1.38) p. 185, p. 186 | 9B₃(A₁/A₀)(p₁/p₀)(1 + β₀) and 8B₃γA₁p₁(γ) "arbitrarily small" | not binding beside the rows above | EXISTENTIAL constants |
| F | floor of the method class | §6 | P(χ²₃ ≥ 2p²) ≤ z_c(20) ⇒ β ≥ (2.23213/a)² | 0.40 (a = √2, β ≥ 2.49); 0.70 (a = 1); 1.74 (a = 0.3); 2.70 (a = 0.1) | inputs COMPUTED; necessity ESTIMATED |

## 8. THE BOTTLENECK, AND THE LADDER OF LEMMAS UNDER IT

THE BOTTLENECK IS T11 WITH T12 (CMP 116 (2.28) and (2.31)), fed by T6–T8. CMP 116 localises the fluctuation integral by COMPLEX
decoupling parameters |s(Δ)| ≤ e^{κ₁} (p. 5) and buys the decay e^{−κ₁} per cube by Cauchy's formula. The price is paid on every
propagator built with those parameters (B₀e^{16κ₁}: short walks touch up to 2⁴ cubes) and hence on every nonlinear estimate downstream —
e^{32κ₁} in the minimiser's fixed point (1.15), e^{7·8κ₁} on the quadratic form (1.40). The polymer activities therefore carry ε₁e^{C₂κ₁}
with C₂ ≥ 56 and must be at most 1, while the cutoff's own Gaussian tail needs γ ≤ ε₁(γ₂/(80κ))^{1/2}. With κ₁ ≥ 20.068 (T6):

  log β_B ≥ 2·56·κ₁ + ln(80κ/γ₂) + 2 ln(2E₀C₁M^q/(α₄α₆)),   i.e.   β_B ≥ 10^{978.05} × (existential prefactor).            (8.1)

Every reading of the printed inequalities keeps this astronomical: 10^{280.8} from the mildest of them (T9), 10^{737.7} with κ₁ optimised
freely against (1.27)'s entropy, 10^{1043.8} in the complete model, 10^{2181.5} at κ = 3. NO UPPER BOUND on β_B can be read from the
papers: the prefactor in (8.1), κ₀, M(κ), a₀, a₁, δ₀, E₀, C₁ and q are existential. β_B cannot be 3–5 with computed constants: evaluated
on its own printed inequalities, Bałaban's induction closes no lower than β = 10^{978}.

THE LADDER (each lemma removes one rung; the next rung is computed):
 (L1) LEMMA RD — REAL DECOUPLING. CMP 116 §§1–2 with real interpolation parameters s ∈ [0, 1] and the Brydges–Kennedy /
   Abdesselam–Rivasseau forest formula, the decay taken from the walk expansion's own e^{−δ₀d} (CMP 95 (1.110), CMP 116 (1.7)) instead of
   from Cauchy on |s| ≤ e^{κ₁}: activities ≤ poly(B₀, C₀, M, M₁)·ε₁·e^{−cδ₀M d(Y)}. It deletes 2C₂κ₁ ≥ 2248 from log β_B. The next rungs are
   then LFR II (1.93) — the tree bound α ≤ e^{−24(1+β)κ}, ESTIMATED 10^{22.7}–10^{64.9} for κ = 1–3 under the reading α ∝ ε₁ of (1.68) —
   and the large-field architecture, 10^{101.9}–10^{161.9} at r = 2 (T17, T18).
 (L2) LEMMA LF — LOCAL LARGE FIELDS. Replace the large-field bookkeeping of LFR I–II (regions inside 100MR_k-cubes, R_k ≥ (log g⁻²)^r with
   r ≥ 2, the suppression 2p₀(g)/(1 + β₀) charged against O(1)(100M)^dR^{d+2} per region) by a bound whose loss is O(log g⁻²) per link
   adjacent to a large plaquette, with p(g) = A(log g⁻²)^{1/2+η} at fixed localisation size. It deletes T15–T18 (≥ 10^{27.8} even at
   fixed R, from the (100M)^{2d} entropy alone).
 (L3) THE FLOOR. What remains is F, β ≥ 4.98/a² with a the small-field radius the machinery supports, plus the explicit
   cluster-expansion constants: ESTIMATED 10²–10⁴ for a between 0.05 and 0.3.
So a fully constant-tracked Bałaban-type renormalisation group, redesigned at both rungs, is ESTIMATED to close no lower than β ~ 10²,
and the middle of the window is at least [3–4, ~10²]: some 1.5 decades that no small-field/large-field step crosses.

## 9. THE NEXT OBJECT

(N1) LEMMA RD, FOR THE PAGE. For the constrained Gaussian dμ_{C^{(k)}} with Bałaban's background-dependent random-walk propagators
(CMP 95, 99) and the interaction V_k(Y) of CMP 116 Lemmas 1–2: a localised cluster expansion with real parameters whose activities obey
|H(Z)| ≤ (K_RD ε₁)^{n(Z)} e^{−cδ₀M d(Z)}, K_RD polynomial in B₀, C₀/δ₀, M, M₁. FALSIFIER: a step of CMP 116 §1 that needs the s-dependence
of the nonlinear fixed points D, A₀ ((1.12)–(1.17)) analytically off the real segment; the real forest formula needs only ∂_s of those
fixed points, which the implicit-function theorem bounds with the contraction constants of (1.13) and (1.15) — polynomial once the
e^{16κ₁} is gone. INSTRUMENT: the derivation on the page against CMP 116 pp. 3–21, then `bin/m6_thresholds*.py` re-run with C₂κ₁ → 0 to
certify the new bottleneck row.
(N2) THE FLOOR AT THE BLOCKED FIELD. Replace the bare-plaquette variance g²/2 of §6 by the variance of Bałaban's blocked plaquette under
the constrained Gaussian (a finite Fourier sum from CMP 109's averaging operator and CMP 95's propagator) and z_c(20) by the radius of the
block-plaquette dependency graph: the exact floor of the method class.
(N3) THE MIDDLE ITSELF. No small-field rung reaches below ~10², so the crossing [3–4, ~10²] belongs to the exact engines (their spin cap
grows like β^{1/2}) or to one computer-assisted renormalisation step with certified constants near β = 10²; the decisive first
computation is the spin cap at which the character engine's truncation error is certified at β = 100.

## 10. CROSS-FIELD IDENTIFICATIONS

(U1) THE BOTTLENECK IS CAUCHY'S PRICE. Analytic interpolation buys decay e^{−κ₁} per unit at the cost e^{O(κ₁)} on every bound that
depends on the interpolated objects; constructive field theory replaced it by real-parameter forest formulas (Brydges–Kennedy 1987;
Abdesselam–Rivasseau 1995). The 978 decades are that technical choice, measured on Bałaban's own inequalities.
(U2) THE FLOOR IS THE LOVÁSZ LOCAL LEMMA. The large-field/small-field split is an instance of the local lemma: bad events are large
plaquettes, the dependency degree is 20, and Shearer's bound — the optimal local-lemma criterion — is the convergence radius of the
large-field polymer gas. The algorithmic local lemma (Moser–Tardos resampling of bad events) is the dynamical counterpart of the
large-field renormalisation.

## 11. LEDGER (this agent's rows)

| Item | Status | Where |
|---|---|---|
| eleven PDFs re-hashed, equal to M3b §0 | COMPUTED | §2 |
| order of choices (κ₀, M(κ), ε's and α's, then γ) | READ (CMP 109 Thm 3) | §2.6, T4 |
| the CMP 116 chain T6–T12 | READ, every link | §§2.5–2.6, §3 |
| κ₁ ≥ 20.068323 | COMPUTED | §5, T6 |
| β_B ≥ 10^{978.05} × existential prefactor (literal); ≥ 10^{280.8} under every reading | COMPUTED | §§5, 5b, 8 |
| complete model ≥ 10^{1043.8} | COMPUTED | T13 |
| large-field definition vacuous for 3.109 < β < 2.03·10³⁸ (p₀ = 10, A₀ = 1) | COMPUTED | T15 |
| large-field architecture rows 10^{27.8}–10^{161.9} | COMPUTED | T17, T18 |
| floor β ≥ 4.98/a²; 3–5 needs a = 1.00–1.29 (60°–80°) | inputs COMPUTED, necessity ESTIMATED | §6 |
| an upper bound on β_B from the papers | none readable: EXISTENTIAL | §8 |
| the bottleneck | T11 with T12 (CMP 116 (2.28), (2.31)) | §8 |
| Lemma RD, Lemma LF | NAMED, each with its falsifier | §§8–9 |

## 12. DATED CORRECTION (2026-11-02, after §§0–11; nothing above edited)

12.1 THE e^{5κ} OF (2.28) WAS DROPPED FROM (3.1) AND (8.1). CMP 116 (2.28) reads 2E₀ε₁C₁α₄⁻¹α₆⁻¹M^q exp C₂κ₁ exp 5κ ≤ 1, so
ε₁ ≤ α₄α₆e^{−C₂κ₁−5κ}/(2E₀C₁M^q) and (3.1), (8.1) become  log β_B ≥ 2C₂κ₁ + 10κ + ln(80κ/γ₂) + 2 ln(2E₀C₁M^q/(α₄α₆)).  Run c
(`bin/m6_thresholds_c.py`, record `rec/thresholds_run.2026-11-02c.txt`, rc = 0): log₁₀ β_B ≥ 982.3889712 (literal, κ = 1),
2194.5250381 (κ = 3), 142.2088009 (the decimal reading of 7·8). The values printed in §§5, 7, 8 omit this positive term and remain valid
lower bounds; the literal bound of record is 10^{982.39} × existential prefactor.

12.2 THE ROUTE OF THE 56 INTO T11, READ (CMP 116 pp. 14–16, and (2.18), (2.26), (2.28), (2.31) zoomed at 230/200 dpi today:
`render/cmp116_16_eq218.png`, `render/cmp116_17_eq226.png`, `render/cmp116_18_eq228_231.png`). p. 15, (2.14): the whole potential
V_k(Y, B) = ½⟨Q(Y, B)B, B⟩ + V″_k(Y, B) (Lemma 2) enters as exp[Σ_{Y∈D} τ(Y)V_k(Y, B)] with complex τ(Y) on Cauchy circles
dτ(Y)/(τ(Y) − t(Y))²; (2.15) bounds it by exp[Σ|τ(Y)||V_k(Y, B)|] and the factor Π 2/|τ(Y)|. p. 16, (2.18): "We take a small, positive
number α₄, to be chosen later, and 1/|τ(Y)| = E₀ε₁C₁α₄⁻¹M^q exp C₂κ₁ exp(−(1 − 3δ)κd_k(Y)). We assume that ⅛(κ₁ − 1) ≥ (1 − 3δ)κ, C₃ ≤ E₀C₁,
and q ≥ 8. The quadratic form in (1.42), after multiplication by |τ(Y)|, can be bounded by (2.19)." So the circle radius is the inverse of
(1.43)'s bound on Q (C₃ε₁M⁴ exp C₂κ₁, C₃ ≤ E₀C₁, M⁴ ≤ M^q) — the e^{7·8κ₁} of (1.40) is exactly what (2.18) divides out — and Cauchy's
2/|τ(Y)| becomes the activity of (2.26) and the left side of (2.28). The 56 enters (2.28) THROUGH (2.18). Row T11 is (2.18) + (2.26) +
(2.28); the headline stands: log₁₀ β_B ≥ 982.39 (run c) × the existential prefactor. (2.18)'s own κ-condition, κ₁ ≥ 1 + 8(1 − 3δ)κ, is
weaker than (K2).
12.3 THE PREFACTOR IS NOT ONE. (2.18) assumes q ≥ 8, so (2E₀C₁M^q/(α₄α₆))² ≥ (2E₀C₁)²M^{16} (α₄, α₆ ≤ 1): the literal bound is
log₁₀ β_B ≥ 982.39 + 16 log₁₀ M + 2 log₁₀(2E₀C₁) + log₁₀(1/γ₂) — e.g. +22.9 decades at M = 27, +45.8 at M = 729.
12.4 T13'S TRANSFER, LABELLED. CMP 119 p. 265 (READ today on M3b's render): (3.3) |V_k(b)(V^{(k)}_□(b))⁻¹ − 1| < 2δ_k with
δ_k = g_k(A₁/A₀)p₀(g_k) = g_kA₁(log g_k^{−2})^{p₀}; p. 280 (READ today on M3b's render): U_k "restricted to Ω_n\Ω_{n+1} coincides with a
U_n-type configuration, but the difference is seen in bounds only". Inserting 2δ_k for ε₁ in (2.28) is the reading of that sentence:
T13's 10^{1043.8} is COMPUTED on an INFERRED transfer.
12.5 THE FLOOR IS CONSERVATIVE INSIDE THE METHOD. §6 charges one large plaquette against the plaquette-level entropy; Bałaban's large
fields are whole LM₂R_k-cubes charged against O(1)(100M)^dR^{d+2} (LFR II (1.88)), a far larger entropy, so the method's own floor lies
above 4.98/a².
12.6 T15'S ASSUMPTION. The vacuity window 3.109 < β < 2.03·10³⁸ is for A₀ = 1; the page says only "A₀ is a sufficiently large constant",
"much larger than A₁" (CMP 119 pp. 246–247). For every A₀ ≥ 1 the window's upper end is at least 2.03·10³⁸ (A₀ = 10: 7.4·10⁴⁰).
