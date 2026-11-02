# M6b — LEMMA RD: CMP 116 §§1–2 WITH REAL DECOUPLING; THE BB4* INTERFACE; THE THRESHOLD WITHOUT C₂κ₁

Proof agent M6b, 2026-11-02. Work directory `.../scratchpad/math/M6b/`. Appended as the work proceeds; nothing above a line is
edited after it is written except by a dated correction below it. Labels: READ (on the rendered page, image read today), PROVED
(full proof here), PROVED GIVEN [named input], COMPUTED (certified interval arithmetic, record named), NAMED (stated with its
falsifier, not proved). Normalisation as M6: Wilson's β = 1/g_Bał², β_B = 1/γ².

NOTATION. CMP 116 writes s(Δ), σ(Δ) for its DECOUPLING parameters (argument: a cube Δ); t(Y), τ(Y) for its Mayer parameters and
their Cauchy variables; t_□ for the field-scaling extraction parameter of (1.22)–(1.23). M3c's interaction multiplier (no argument)
is written s̄ here, M3c's coupling deviation d. Bałaban reuses C₂ (p. 5: the quadratic constant of the map C in (1.3); p. 9:
the exponent constant of Lemma 1) and C₃ ((1.39) vs p. 20); the page is named where it matters. d = 4 is the dimension; d_k(·)
is Bałaban's linear size (CMP 109 p. 257).

## 0. Sources

Read in full before deriving: `math/MATH_BRIEF.md`; `math/M6/WORK.md` (§§0–12, all; the scripts `bin/m6_thresholds{,_b,_c}.py`,
copied here to `bin/`); `math/M3c/WORK.md` (§§0–12, all); `math/M3b/WORK.md` §0 (the eleven PDFs and their hashes).

READ ON IMAGE TODAY: CMP 116 (1988) 1–22 = `Downloads\Download (3).pdf`, pp. 2–21 at 150 dpi (M3c's `render/cmp116_*.png`), p. 8
lines (1.26)–(1.29) zoomed at 230 dpi (`render/cmp116_8_mid.png`, mine); CMP 109 (1987) 249–301 = `Downloads\Download (1).pdf`,
pp. 257, 274, 275, 276 at 150 dpi (`render/cmp109_*.png`, mine, `bin/render150.py`, PyMuPDF run as `python -E -P`).

## 1. The plan (deep-think synthesis, before deriving)

DECISION. Classify every occurrence of κ₁ in CMP 116 by what the complex radius e^{κ₁} is used FOR, and give each class its own
real replacement: (a) the DECAY per decoupled cube (Cauchy's e^{−κ₁}) — replaced by the walk geometry; (b) the ANALYTICITY DOMAIN of
nonlinear functionals of decoupled operators (B₀e^{16κ₁}, e^{32κ₁}, e^{7·8κ₁}) — replaced by the SUPPORT DECOMPOSITION: the
decoupling integrals ∫₀¹ds ∂_s are evaluated exactly (inclusion–exclusion), the functionals of (1.5) are expanded multilinearly in
the walk operators on an operator ball of radius e(1+η)B₀, and each multilinear term lands in exactly one polymer, its support;
(c) POSITIVITY of complexified Gaussians in §2 — replaced by the same expansion around the s = 0 operators, the perturbation being
the long walks only; (d) COUPLING-TYPE Cauchy formulas (t_□, τ(Y)), whose radius is the inverse of a bound and whose cost is linear
— retained. Then settle what BB4* needs, then re-run the thresholds.
WHY THIS OVER THE RUNNER-UP (Faà di Bruno with real derivatives): real derivatives of nonlinear functionals of walk sums produce
Bell-number combinatorics that only the volume growth of distances can beat, with no clean constant; the support decomposition
needs no derivative at all and its constants are Bałaban's own with B₀e^{16κ₁} → e(1+η)B₀.
WHAT MOVED THE PLAN (pre-mortem, after reading pp. 7–9 and CMP 109 p. 275 on image). The history terms of (I.3.34) are RELOCALIZED to
□₀ = □̃⁵, a cube of 11⁴ M-cubes, and (1.25) carries the factor e^{+⅛κ₁d_k(□₀)} into the "exp O(1)κ₁" of (1.29). The output format
of Lemma 1, decay e^{−(1−2δ)κd_k(Y)} uniform in Y, therefore charges the BASE □₀ in any version, real or complex. The kill-switch
"a step needs the large complex radius" did not fire; a different obstruction did: M6's premise that the activities become
"polynomial × ε₁" is false in Bałaban's FORMAT. The plan now includes that theorem, its number, and the format that removes it.
KILL-SWITCH (kept): a site where a Cauchy-extracted object's DEFINITION, not its bound, needs the radius e^{κ₁}. None found (§2).

## 2. THE SITES OF κ₁ IN CMP 116, CLASSIFIED (READ, pp. 2–21)

| Page / eq. | What the page does | Class | Real replacement (§5) |
|---|---|---|---|
| p. 3 (1.6)–(1.7) | walk expansion Σ_ω R₀(X₀)R_{α₁}(X₁)…; per walk O(1)O(M₁^{−1/2})^{|ω|}M₁^{−½|ω|}e^{−δ₀d(ω,y,y′)}; first two factors fix B₀, last two "to produce exponential bounds" | — | the last two factors ARE the decay used |
| p. 3 | s-weight of a walk: Π over the cubes Δ ∈ σ₀ meeting X̃₀⁵∪…∪X̃ₙ⁵ of s(Δ) — MULTILINEAR | — | used as is |
| p. 3 (1.5) | "the solutions D, A₀ can be considered as functionals of these operators, having all the properties proved in [15]" | — | the operator-functional view |
| p. 4 (1.9)–(1.10) | the decoupling formula: fundamental theorem of calculus in REAL s(Δ) ∈ [0,1]; locality of D, A₀ per component | real already | exact evaluation by inclusion–exclusion |
| p. 5 (1.11) | |s(Δ)| ≤ e^{κ₁}; ‖H(s)X‖ ≤ B₀e^{16κ₁}|X| ("short walks … e^{16κ₁} only"; δ₁M ≥ κ₁ for m > 2⁴) | (b) | ‖H(s)‖ ≤ B₀ for real s; operator ball e(1+η)B₀ |
| p. 5–6 (1.13)–(1.18) | fixed points: 4C₂B₀e^{16κ₁}ε₂ ≤ 1; 4C₄B₀²e^{32κ₁}ε₃ ≤ 1; 2B₀e^{16κ₁}ε₃ ≤ ε₂; |H_k| ≤ 4B₀e^{16κ₁}|B′| | (b) | the same with B₀e^{16κ₁} → R := e(1+η)B₀ |
| p. 7 (1.21)–(1.22) | e^{32κ₁}ε₁ small; 4B₀C₁e^{16κ₁}ε₁ ≤ ¼α₂; 1/|t_□| = 8B₀C₁e^{16κ₁}α₂⁻¹g_k|B| | (b); t_□ is (d) | 1/|t_□| = 8R̂C₁α₂⁻¹g_k|B|, R̂ the weighted radius (§5.3) |
| p. 7 (1.23)–(1.24) | σ(Δ)-Cauchy on |σ| = e^{κ₁}: factor e^{−(κ₁−1)} per decoupled M-cube | (a) | walk decay e^{−a} per M-cube, a ≤ δ₀L₀/2^{d+2} |
| p. 7 (1.25) | "adding and subtracting ⅛κ₁d_k(□₀)": exp(−⅛(κ₁−1)d_k(Y) + ⅛κ₁d_k(□₀) − ½(κ₁−1)M⁻⁴|Y₀∖□̃⁴|), Y = Y₀ ∪ □₀ | (a) + FORMAT | §6: the base cost survives |
| p. 8 (1.26) | Σ_{X∋□′}e^{−κd_j(X)} ≤ O(1) "for κ sufficiently large" | entropy | §6.3: the κ floor |
| p. 8 (1.27) | sum over subsets of the ≤ 8·12³ cubes of □₀∖□̃⁴ by e^{−½(κ₁−1)} each | (a) | no entropy at all: one multilinear term, one polymer |
| p. 8 (1.28) | M⁻⁴|Y| ≤ 3·2³d_k(Y) ≤ exp((1/16)(κ₁−2)d_k(Y)) (sum over □₀) | (a) | count ≤ n(Y) ≤ 11⁴ + n(Y∖□₀) |
| p. 8 (1.29) | E₀ε₁O(M^q)exp O(1)κ₁ exp(−(1/16)κ₁d_k(Y)) | output | Lemma 1_RD |
| p. 8–9 (1.30)–(1.32) | (I.3.7) terms: E₀24B₀²C₁B₃e^{16κ₁}α₂⁻¹ε₁e^{−½δ₀M(L^jη)⁻¹−½δ₀dist}·e^{−(κ₁−1)M⁻⁴|Y∖X₀|}e^{−κd_j(X)}; ¼(κ₁−1) ≥ (1−δ)κ; (1/16)κ₁ ≥ (1−2δ)κ; (1.26) "for δκ sufficiently large" | (a),(b) | §5.4 |
| p. 10 (1.38)–(1.40) | Wilson part: σ-Cauchy; (e^{16κ₁}|B′|)³M⁴; second-order coefficients ½C₃3³e^{7·8κ₁}|B′|; domain e^{16κ₁}|B′| ≤ ⅓a₁ | (a),(b) | §5.5 |
| p. 11 (1.43) | |Q| ≤ C₃ε₁M⁴expC₂κ₁exp(−⅛(κ₁−1)d_k(Y) − ½(κ₁−1)M⁻⁴|Y|) | output | Lemma 2_RD |
| p. 13–14 (2.7)–(2.8) | §2 decoupling on LM-cubes outside Z₀′, real FTC; (C^{(k)})^{1/2} by the resolvent integral, "if γ₁ is sufficiently large" | real already | §5.6 |
| p. 15 (2.14)–(2.15) | σ(Δ)-Cauchy on LM-cubes: e^{−(κ₁−1)(LM)⁻⁴|Z∖Z₀′|}; complex covariance, Re parts and the determinant quotient | (a),(c) | §5.6 |
| p. 16 (2.16) | "M is much bigger than κ₁, especially e^{−⅓δ₀M}e^{16κ₁} < 1" | (c) | perturbation e(1+η)O(1)e^{−⅓δ₀M} |
| p. 16 (2.18)–(2.20) | τ(Y)-Cauchy with 1/|τ(Y)| = (bound of V_k); ⅛(κ₁−1) ≥ (1−3δ)κ; the Y-sum "small for κ₁ large" | (d) + inherited | radius from Lemma 2_RD's bound |
| p. 17–20 (2.26), (2.35), (2.37) | the factor e^{−(κ₁−1)(LM)⁻⁴|Z∖Z₀′|}; "½(κ₁−1) ≥ 2Lκ"; exp(−½(κ₁−1)) beside (LM)⁴α₅ | (a) | walk decay per LM-cube |
| p. 18–20 (2.28), (2.33), p. 20 | e^{C₂κ₁} inside ε₂ and C₃ | inherited | K_RD |
| p. 21 | log Z^{(k)}(U_{k+1}): "satisfies (I.1.18) with κ replaced by δ₀M … M sufficiently large, so that δ₀M ≥ κ" | — | BAŁABAN'S OWN REAL MECHANISM (the precedent) |

VERDICT OF §2. No site uses the radius e^{κ₁} to DEFINE an object: every Cauchy formula in s is a device to BOUND a derivative whose
value is fixed by the real formula (1.9)/(2.8). The one place Bałaban localizes without it (p. 21, the normalisation) takes its decay
from the walks, δ₀M ≥ κ — the mechanism of Lemma RD, used by Bałaban in the same paper.

## 3. FIVE LEMMAS THE PROOF RUNS ON (each PROVED here)

### 3.1 LEMMA SD — THE SUPPORT DECOMPOSITION (PROVED)

SETTING. S a finite set of decoupling cubes; Ω a countable set of walks; for ω ∈ Ω a set c(ω) of decoupling cubes it touches and a
monomial m_ω(s) := Π_{Δ∈c(ω)} s(Δ) (CMP 116 p. 3: each walk is multiplied by s(Δ₁)⋯s(Δ_m), each touched cube ONCE); h_ω ∈ 𝔅, a
complex Banach space (for CMP 116: the product of the operator spaces of H, G̃, H₀ under the maximum of all the norms of
Theorems 3.1–3.10 [13], in which (1.7) holds term by term); H(s) := Σ_ω m_ω(s)h_ω. Φ: {h ∈ 𝔅 : ‖h‖ < R} → 𝔉 holomorphic, 𝔉 a
complex Banach space (for CMP 116: bounded analytic functions of (U, J, B) on Bałaban's domain, sup norm), ‖Φ‖ ≤ K_Φ. Write L_n for
the symmetric n-linear form with Φ(h) = Σ_n L_n[h, …, h] near 0. Let w: Ω → [1, ∞) and put B_w := Σ_ω ‖h_ω‖w(ω).

LEMMA SD. Assume eB_w < R and w(ω) ≥ (1+η)^{|c(ω)|} for some η > 0. Put F(s) := Φ(H(s)) and, for the cubes of S,
F_S := ∫_{[0,1]^S} Π_{Δ∈S} ds(Δ) ∂^S F(s)|_{s = 0 off S}. Then
 (i) F is real-analytic on a neighbourhood of [0,1]^S, and F_S = Σ_{T⊆S} (−1)^{|S∖T|} F(1_T) (1_T: s = 1 on T, 0 elsewhere);
 (ii) F_S = Σ_{n≥0} Σ_{(ω₁,…,ω_n): c(ω₁)∪⋯∪c(ω_n) = S} L_n[h_{ω₁}, …, h_{ω_n}], absolutely convergent: EVERY MULTILINEAR TERM LANDS IN
   EXACTLY ONE POLYMER, ITS SUPPORT;
 (iii) if a ≥ 0, N₀ ≥ 0 and every tuple with L_n[h_{ω₁}, …] ≠ 0 satisfies |∪_i c(ω_i)| ≤ N₀ + a⁻¹Σ_i ln w(ω_i), then
   Σ_S e^{a|S|} ‖F_S‖ ≤ e^{aN₀} K_Φ (1 − eB_w/R)⁻¹,  the sum over ALL finite S.
PROOF. Polarization: ‖L_n[h₁, …, h_n]‖ ≤ (nⁿ/n!) K_Φ R⁻ⁿ Π‖h_i‖ ≤ eⁿ K_Φ R⁻ⁿ Π‖h_i‖ (the n-homogeneous term is bounded by K_Φ(‖h‖/R)ⁿ by
Cauchy's estimate on the disc z ↦ Φ(zh), and the polarization formula costs nⁿ/n!). For s in the polydisc |s(Δ)| ≤ 1 + η,
|m_ω(s)| ≤ (1+η)^{|c(ω)|} ≤ w(ω), so Σ_n Σ_{ω₁…ω_n} Π|m_{ω_i}(s)|‖L_n[h_{ω₁}, …]‖ ≤ K_Φ Σ_n (eB_w/R)ⁿ < ∞: the multilinear series of
Φ(H(s)) converges absolutely and uniformly there, so F is holomorphic on that polydisc, in particular real-analytic near [0,1]^S.
(i) is the iterated fundamental theorem of calculus, ∫₀¹ds(Δ)∂_{s(Δ)}G = G|_{s(Δ)=1} − G|_{s(Δ)=0}, one cube at a time.
(ii) For a tuple put U := ∪c(ω_i). At s = 1_T, Π_i m_{ω_i}(1_T) = 1 if U ⊆ T and 0 otherwise — whatever the multiplicity with which a cube
is touched, because 1ᵏ = 1 and 0ᵏ = 0 for k ≥ 1. With s = 0 off S a tuple with U ⊄ S vanishes for every T ⊆ S; for U ⊆ S,
Σ_{T⊆S}(−1)^{|S∖T|}1_{U⊆T} = Σ_{U⊆T⊆S}(−1)^{|S∖T|} = (1 − 1)^{|S∖U|} = 1_{U=S}. Absolute convergence lets the finite alternating sum
pass inside the series.
(iii) Σ_S e^{a|S|}‖F_S‖ ≤ Σ_n Σ_{tuples, L_n ≠ 0} e^{a|∪c(ω_i)|}‖L_n[…]‖ ≤ e^{aN₀} Σ_n eⁿK_ΦR⁻ⁿ Π_i(Σ_{ω_i}‖h_{ω_i}‖w(ω_i)) by (ii), the
hypothesis and polarization. ∎
REMARK. No s-derivative is ever bounded. The sum over polymers costs NOTHING: Bałaban's (1.27) spends e^{−½(κ₁−1)} on each of up to
8·12³ cubes to sum over subsets, because a Cauchy bound bounds every subset by the same supremum; here a multilinear term is counted
once, in the one polymer it belongs to.

### 3.2 LEMMA C — LOCALITY OF THE MULTILINEAR COEFFICIENTS (PROVED GIVEN Bałaban's p. 4 locality statement)

Let Φ be one of CMP 116's functionals — D(H, A′) of (1.3), A₀(H, G̃, H₀B′) of (1.4), H_k of (1.2)/(1.17), or E(□₀, ·) evaluated at
them — and x the region where the output is read (□₀ for E(□₀, ·); a point for H_k(x)). Two walks are LINKED if their kernel supports
lie within distance r_loc, the range of the local functions C, V₀ of (1.3)–(1.4) and of B ↦ B′ (I.3.2).
LEMMA C. L_n[h_{ω₁}, …, h_{ω_n}] = 0 unless {ω₁, …, ω_n} ∪ {x} is linked-connected.
PROOF. Suppose the walks split into G₁ (those linked-connected to x) and G₂ ≠ ∅ with dist(supp G₂, supp G₁ ∪ x) > r_loc. Put
h = Σ_{i∈G₁}z_ih_{ω_i} + Σ_{i∈G₂}z_ih_{ω_i}, |z| small, and let R₁ be the r_loc-neighbourhood of supp G₁ ∪ x. For y ∈ R₁ the G₂-kernels
vanish at y, so the fixed-point equations (1.3)–(1.4) restricted to R₁ form a closed system in the G₁-operators and the local
functions; it is a contraction on the restricted ball, so by uniqueness the solution restricted to R₁ is the solution of the
G₁-system, independent of (z_i)_{i∈G₂}. This is Bałaban's p. 4 argument ("the solution D(H(s), A′) restricted to the interior of a
component depends on A′, H(s), hence s, restricted to this component"), which uses only that kernels vanish off a region. The output
read in x ⊂ R₁ is then independent of z_i for i ∈ G₂, and ∂_{z₁}⋯∂_{z_n}Φ(h)|_{z=0} = n!L_n[h_{ω₁}, …] = 0 (distinct walks; repeated
walks by the same argument on the coefficient of Π z_i^{k_i}). ∎

### 3.3 LEMMA G — WALK GEOMETRY: THE DECAY PER CUBE COMES FROM THE WALKS (PROVED)

r′: the radius of an enlarged localization domain X̃⁵ of a walk (r′ ≤ c₅M₁, the domains being "unions of connected families
containing several cubes from π_k(1)", p. 3); d(ω): the length of a shortest tree graph intersecting all localization domains of ω
(p. 5); L₀ := M − 2r′ − 2; λ := 2r′ + r_loc. Lengths in lattice units; M-cubes closed.
LEMMA G. (i) If K ⊂ N_{r′}(T) for a tree T of length ℓ, K meets at most 2^d·max(1, ⌈2ℓ/L₀⌉) M-cubes.
(ii) If moreover K contains a point x with dist(x, ∪ decoupling cubes) > L₀/2 + r′, K meets at most 2^{d+1}ℓ/L₀ decoupling cubes; in
general at most 2^{d+1}ℓ/L₀ + 2^d·1[dist(x, decoupling cubes) ≤ L₀/2 + r′].
(iii) For a linked-connected family {ω₁, …, ω_n} ∪ {x}: K := ∪supp ω_i ∪ {x} ⊂ N_{r′}(T) with length(T) ≤ Σ_i (d(ω_i) + λ).
(iv) Consequently, with w(ω) := exp(a2^{d+1}(d(ω) + λ)/L₀), every nonvanishing tuple satisfies |∪c(ω_i)| ≤ N₀ + a⁻¹Σ_i ln w(ω_i) with
N₀ = 2^d·1[x within L₀/2 + r′ of a decoupling cube]; and if δ₀L₀ ≥ 2^{d+1}a and 2^{d+1}aλ ≤ L₀ln(1+η), then by (1.7)
   B_w = Σ_ω‖h_ω‖w(ω) ≤ B₀·sup_ω[M₁^{−½|ω|}e^{−δ₀d(ω)}w(ω)] ≤ (1 + η)B₀.
PROOF. (i) The Euler tour of T has length 2ℓ; cut it into ⌈2ℓ/L₀⌉ arcs of length ≤ L₀ (one point if ℓ = 0). Each arc lies in the ball of
radius L₀/2 about its midpoint, so K lies in ⌈2ℓ/L₀⌉ balls of radius L₀/2 + r′ < M/2. A ball of diameter < M has every coordinate
projection an interval of length < M, which meets at most two closed M-intervals (it contains at most one lattice point jM); so it
meets at most 2^d closed M-cubes. (ii) The arc through x lies in a ball meeting no decoupling cube; the other ⌈2ℓ/L₀⌉ − 1 ≤ 2ℓ/L₀ balls
meet at most 2^d each. (iii) Each walk's kernel support lies in N_{r′}(T_i), T_i a shortest tree of ω_i; linked walks have trees within
2r′ + r_loc of each other; join them (and x) by segments of that length. (iv) is (ii)+(iii) with a·2^{d+1}Σ_i(d(ω_i) + λ)/L₀ = Σ_i ln w(ω_i);
for the walk sum, (1.7) bounds ‖h_ω‖ by [O(1)O(M₁^{−1/2})^{|ω|}]·M₁^{−½|ω|}e^{−δ₀d(ω)}, the bracket summing to B₀ ("the first two
factors … determine the constant B₀", p. 3), and M₁^{−½|ω|}e^{−δ₀d(ω)}w(ω) ≤ e^{a2^{d+1}λ/L₀}e^{−(δ₀ − a2^{d+1}/L₀)d(ω)} ≤ 1 + η. Finally
w(ω) ≥ (1+η′)^{|c(ω)|} with 1 + η′ := e^{a/2^d}... by (i)–(ii) (|c(ω)| ≤ 2^d + 2^{d+1}(d(ω)+λ)/L₀), as Lemma SD requires. ∎
REMARK (Bałaban's own form). p. 5: "If m is big enough, e.g. m > 2⁴, then δ₀d(ω) ≥ δ₁mM … for δ₁M ≥ κ₁" — the same geometry; Lemma G
spends it on decay instead of on surviving the radius e^{κ₁}. The conditions δ₀L₀ ≥ 2^{d+1}a and 2^{d+1}aλ ≤ L₀ln(1+η) are of Bałaban's
own kind ("M ≥ M(κ)", δ₁M ≥ κ₁, δ₀M ≥ κ, e^{−⅓δ₀M}e^{16κ₁} < 1): polynomial in a, M₁, 1/δ₀, with no γ in them.

### 3.4 LEMMA MS — THE MINKOWSKI–STEINER BOUND ON THE LINEAR SIZE (PROVED)

LEMMA MS. For every localization domain Y ∈ D_k made of n(Y) M-cubes, d_k(Y) ≥ (n(Y) − 2^d)/(2^{d−1}√d); at d = 4,
d_k(Y) ≥ (n(Y) − 16)/16. In particular d_k(□̃⁵) ≥ (11⁴ − 16)/16 = 14625/16 = 914.0625, d_k(□̃⁴) ≥ 409.0625, d_k(□̃²) ≥ 38.0625.
PROOF. Rescale so that M-cubes are unit cubes (CMP 109 p. 257: d_j(X) is the length of a shortest tree graph contained in X and
intersecting all the cubes of X, divided by M; the tree may be taken polygonal, "formed by edges of cubes"). Let T be such a tree of
length ℓ and K := [−1, 1]^d. Every closed unit cube Q meeting T at p satisfies Q ⊂ p + K ⊂ T ⊕ K, and distinct cubes have disjoint
interiors, so n(Y) ≤ vol(T ⊕ K). Build T one segment at a time, each new segment [p, q] attached at a point p already present: the
volume added is at most vol(([p,q] ⊕ K) ∖ (p ⊕ K)) = |q − p|·vol_{d−1}(proj_{u⊥}K), u = (q − p)/|q − p| (Steiner's formula for a
segment), and by Cauchy's projection formula vol_{d−1}(proj_{u⊥}[−1,1]^d) = 2^{d−1}Σ_i|u_i| ≤ 2^{d−1}√d. Hence
n(Y) ≤ 2^d + 2^{d−1}√d·ℓ. ∎
(Bałaban's own (2.30), READ p. 18, states (3·2³)⁻¹M⁻⁴|Y| ≤ d_k(Y), i.e. d_k(□̃⁵) ≥ 610.04; Lemma MS is sharper and holds for every n —
(2.30)'s lower half is false for n ≤ 16, where d_k can vanish.)
UPPER COMPANION (PROVED). If Y = N ∪ F with N a family of cubes sharing a common point P and Y face-connected, then d_k(Y) ≤ |F|:
start from the tree {P} ⊂ Y; add the cubes of F in an order in which each is face-adjacent to a cube already present; the tree meets
that neighbour at a point, and a segment of length ≤ 1 inside the neighbour reaches the common (d−1)-face. In particular a family met
by one short chain from one point (Lemma G (i) with one ball: all its cubes share a point) has d_k = 0, and adding a face-connected
family to a domain raises d_k by at most the number of cubes added.

### 3.5 LEMMA F — THE FLOOR OF THE LOCALIZATION SUMS (PROVED)

LEMMA F. Let c_{d−1} be the number of connected induced subgraphs of the (d−1)-cube graph Q_{d−1} containing a fixed vertex. For every
cube □′ ∈ π_j and integer t ≥ 1, N(t) := #{X ∈ D_j : □′ ⊂ X, d_j(X) ≤ t} ≥ (c_{d−1})^t. Hence Σ_{X∈D_j, X⊃□′}e^{−s·d_j(X)} = ∞ for every
s < ln c_{d−1}, and every use of (1.26) at rate s needs s ≥ ln c_{d−1}.
PROOF. Units of M; the edge-line ℓ_t := {(x, 0, …, 0) : 0 ≤ x ≤ t}. For i ∈ {0, …, t−1} and v ∈ {−1, 0}^{d−1} let Q(i, v) be the closed
cube [i, i+1] × Π_m[v_m, v_m + 1]; each Q(i, v) contains the segment [i, i+1] × {0}^{d−1}. Fix v₀ = 0 and choose for each i a set
S_i ⊂ {−1,0}^{d−1} containing v₀, connected in Q_{d−1} (Hamming adjacency). Put X := ∪_i ∪_{v∈S_i} Q(i, v). Q(i,v), Q(i,v′) share a
(d−1)-face iff v, v′ are adjacent in Q_{d−1}, and Q(i, v₀), Q(i+1, v₀) share one; so X is face-connected, X ∈ D_j (CMP 109 p. 257), and
X ⊃ □′ := Q(0, v₀). The tree ℓ_t lies in ∪_iQ(i, v₀) ⊂ X and meets every cube of X, so d_j(X) ≤ t. Distinct (S_0, …, S_{t−1}) give
distinct X, so N(t) ≥ c_{d−1}^t, and Σ_X e^{−s d_j(X)} ≥ N(t)e^{−st} ≥ (c_{d−1}e^{−s})^t → ∞ for s < ln c_{d−1}. ∎
CONSEQUENCE FOR THE PAGE. p. 9 sums the (I.3.7) terms over X ∋ □′ "using the second exponential in (1.32)", e^{−δκd_j(X)}, "and the
inequality (1.26) for δκ sufficiently large"; p. 21 fixes δ = (1/10)(1 − 2L⁻¹). So the printed proof needs δκ ≥ ln c₃:
   κ ≥ 10 ln c₃/(1 − 2/L)                                                                                              (3.1)
is the least κ the page allows. M6 evaluated its chain at κ = 1 (M6 T5 labelled κ₀ EXISTENTIAL); (3.1) makes the floor COMPUTED.
c₃ is computed in run a (§8).

### 3.6 DATED PRECISION TO 3.1/3.3 (2026-11-02, before any run)

(a) Lemma SD (iii) holds verbatim for any polymer functional Ψ in place of |S|: if every nonvanishing tuple satisfies
Ψ(∪c(ω_i)) ≤ N₀ + a⁻¹Σ_i ln w(ω_i), then Σ_S e^{aΨ(S)}‖F_S‖ ≤ e^{aN₀}K_Φ(1 − eB_w/R)⁻¹ (same proof). It is used below with
Ψ(S) = d_k(base ∪ S) − d_k(base) (decay in Bałaban's linear size, via the UPPER COMPANION of 3.4) and with Ψ = number of cubes.
(b) The sentence "w(ω) ≥ (1+η′)^{|c(ω)|} with 1 + η′ := e^{a/2^d}…" at the end of the proof of Lemma G is replaced by: by Lemma G (i)–(ii),
|c(ω)| ≤ 2^d + a⁻¹ln w(ω); so for any η′ with ln(1+η′) ≤ a the weight w′ := (1+η′)^{2^d}w satisfies w′(ω) ≥ (1+η′)^{|c(ω)|}, and
B_{w′} = (1+η′)^{2^d}B_w. Lemma SD's real-analyticity needs only SOME η′ > 0 with e(1+η′)^{2^d}B_w < R; it costs nothing in the bounds.

## 4. STAKES FOR RUN a (written before `bin/m6b_thresholds.py` exists; nothing here edited after)

Conventions as M6 unless stated: κ = 1, γ₂ = 1, every existential prefactor P = 2E₀C₁M^q/(α₄α₆) = 1, d = 4.

(A) THE RUN REQUESTED — M6's chain with the C₂κ₁ term removed, every other row unchanged:
 A1 T11′ = CMP 116 (2.28)+(2.31) with C₂κ₁ → 0: log β ≥ 10κ + ln(80κ) = 14.382, log₁₀ β ≥ 6.246.
 A2 the same with q ≥ 8 at M = 27 (M⁸ inside P, squared): log₁₀ β ≥ 29.15.
 A3 T13′ (complete model, δ_k in (2.28), e^{5κ} carried): p₀ = 10 → log₁₀ β ≈ 44.6; p₀ = 13 → ≈ 60.0.
 A4 T14′ (LFR II (1.93) with T11′): 2·24κ + ln 80 = 52.38 → 22.75.
 A5–A7 unchanged rows: T15 38.31 (p₀ = 10); T17 101.87 (M = 27, r = 2); T18 111.09 (M = 27, p₀ = 10, r = 2).
 STAKE: the new bottleneck of M6's table is T18, log₁₀ β_B ≥ 111.09 (as M6 computed it).
(B) THE BASE ROW (my reading of (1.24)–(1.29), §2 and §3.4), at κ = 1:
 B1 d_k(□̃⁵) ≥ 14625/16 = 914.0625 exactly.
 B2 Bałaban's printed chain with Lemma 1's constant carried: C₂κ₁ ≥ 16κ₁ + κ₁d₀/16 + (1 − 2δ)κd₀ at κ₁ = 1 + 2ln 13824, L = 3:
    ≈ 321.09 + 1146.47 + 853.13 = 2320.69; log₁₀ β_B ≥ (2·2320.69 + 14.382)/ln 10 ≈ 2021.96 (M6: 982.39).
 B3 Lemma RD in Bałaban's output format (base row 2(1 − 2δ)κd₀ + 10κ + ln 80κ): L = 3 → ≈ 747.26; L → ∞ (1 − 2δ → 4/5) → ≈ 641.39.
(C) THE PAGE'S OWN FLOOR ON κ (Lemma F, (3.1)):
 C1 c₃ = 91 (hand count: 1 + 3 + 9 + 19 + 30 + 21 + 7 + 1 by size; size 5 = 35 − 5 isolating complements); ln 91 ≈ 4.51086.
 C2 κ_min = 10 ln 91/(1 − 2/L): L = 3 → ≈ 135.33; L → ∞ → ≈ 45.11.
 C3 base row at κ_min: L = 3 → log₁₀ β ≈ 100 874 (± 0.5 %); L → ∞ → ≈ 28 850.
 C4 the e^{5κ} row alone (A1 at κ_min): L = 3 → ≈ 591.8; L → ∞ → ≈ 199.5.
 C5 Bałaban's printed chain at its own floor (B2 at κ_min, κ₁ = 16(1 − 2δ)κ): L = 3 → ≈ 229 230; L → ∞ → ≈ 65 525.

## 5. RESULTS OF RUN a (record `rec/thresholds_run.2026-11-02a.txt`, rc = 0; §4 unedited) — EVERY STAKE HELD

Both PDFs re-hashed: sha256[:16] equal to M3b §0 (CMP 116 ee39523a0f7b83af, CMP 109 1c2d2e500fd1e6a1).
(A) THE REQUESTED RUN (C₂κ₁ → 0, M6's conventions). A1 T11′ 6.24603; A2 (M⁸ at M = 27) 29.14786; A3 T13′ 44.56765 (p₀ = 10), 59.99074
(p₀ = 13) [M6's form without e^{5κ}: 39.08438, 54.58060]; A4 T14′ 22.74923; A5 T15 38.30806 (p₀ = 10), 53.82011 (13); A6 T17 101.86526
(M = 27), 112.43687 (81), 122.90735 (243), 133.29548 (729); A7 T18 111.08510 (p₀ = 10, M = 27) … 161.93269 (p₀ = 13, M = 729). HELD:
the bottleneck of M6's table with C₂κ₁ deleted is T18 = LFR II (1.9), log₁₀ β_B ≥ 111.08510, then T17 = 101.86526, then the CMP 116
rows at ≤ 44.57 (complete model) and ≤ 29.15 (T11′ with M⁸).
(B) THE BASE ROW at κ = 1. B1 d_k(□̃⁵) ≥ 14625/16 = 914.0625 (Bałaban's (2.30): ≥ 610.04). B2 Lemma 1 needs C₂κ₁ ≥ 2320.69951 against
Lemma 2's 56κ₁ = 1123.82609: Bałaban's printed chain closes no lower than log₁₀ β_B ≥ 2021.98002 at L = 3 (1916.12074 at L → ∞) — M6's
982.39 omitted Lemma 1's base. HELD (staked ≈ 2021.96; the 0.02 is my hand rounding). B3 LEMMA RD IN BAŁABAN'S OUTPUT FORMAT:
log₁₀ β_B ≥ 747.26099 (L = 3), 641.40171 (L → ∞). HELD.
(C) THE PAGE'S FLOOR ON κ. C1 c₃ = 91, by size 1, 3, 9, 19, 30, 21, 7, 1 (as hand-counted); c₂ = 7. ln 91 = 4.5108595065. C2 κ_min =
135.32579 (L = 3), 75.18099 (5), 63.15203 (7), 57.99677 (9), 45.10860 (L → ∞). C3 the base row at κ_min: log₁₀ β_B ≥ 100 870.18
(L = 3) … 28 850.44 (L → ∞). C4 the e^{5κ} row alone at κ_min: 591.747 (L = 3), 330.286 (5), 277.969 (7), 255.543 (9), 199.461 (∞). C5
Bałaban's printed chain at its own floor: 229 233.43 (L = 3) … 65 525.66 (L → ∞). HELD (C3 staked 100 874 ± 0.5 %).

READING. (A) is the number the request asked for, and it is the right number for M6's table: with C₂κ₁ removed and nothing else
touched, the large-field architecture is the bottleneck at 10^{111.09}. (B) and (C) say the table itself is incomplete in two places
that do not involve complex parameters at all: Lemma 1's relocalization base (B) and the page's own κ floor (C). Lemma RD deletes 2C₂κ₁;
in Bałaban's output format the base row then binds at 10^{747.26} (κ = 1) — and at the κ the page allows, at 10^{28 850} or more.

## 6. LEMMA RD — THE STATEMENT

INPUTS (exactly those of CMP 116 itself, the black box M3c §9.1 names): CMP 109 Theorem 3's inductive assumptions at scale k; [13]
(CMP 99): the generalized random walk expansions of H, G̃, H₀, of the operators of Δ_k and of C^{(k)}(Z₀), each walk bounded by (1.7)
in every norm of Theorems 3.1–3.10; [15] (CMP 102) Sect. C, E, G: D and A₀ as functionals of the operators with the contraction
estimates (1.13)–(1.16) ("we can replace the propagators by arbitrary operators having the same regularity properties and satisfying
the same bounds", p. 3); CMP 109 (I.3.17), (I.3.54): the bounds of the history terms; [16]: the walk expansion of Z^{(k)}.
REAL PARAMETERS: s(Δ) ∈ [0, 1] in (1.9)–(1.10) and in (2.8); no decoupling parameter is ever complexified.
FREE CONSTANTS: a > 0 (decay per M-cube, §1), a_L > 0 (decay per LM-cube, §2), η ∈ (0, 1].
DERIVED CONSTANTS: L₀ := M − 2r′ − 2, L₀^{(L)} := LM − 2r′ − 2, λ := 2r′ + r_loc (Lemma G); R := e(1+η)²B₀ (the operator ball of
Lemma SD with B_w ≤ (1+η)B₀ and the real-analyticity margin); R₁ := e^{2^d a}R (the same for the history terms, whose read region □₀
has walks starting near its outside, Lemma G (ii); refinable to e^{2a}R by the d_k-count of §3.4's companion).
CONDITIONS (all of Bałaban's kind; γ enters none of them):
 (G)  δ₀L₀ ≥ 2^{d+1}a and 2^{d+1}aλ ≤ L₀ ln(1+η); δ₀L₀^{(L)} ≥ 2^{d+1}a_L and 2^{d+1}a_Lλ ≤ L₀^{(L)} ln(1+η); δ₀M ≥ 3(2^d a_L + 2);
 (R)  4C₂R₁ε₂ ≤ 1, 4C₄R₁²ε₃ ≤ 1, 2R₁ε₃ ≤ ε₂, C₁ε₁ ≤ ε₃   [(1.13)–(1.16), (1.20) with B₀e^{16κ₁} → R₁];
 (D)  16R₁C₁ε₁ ≤ α₂ and 3(R/B₀)C₁ε₁ ≤ a₁   [(1.21) and (1.40)'s domain with e^{16κ₁} → R₁/B₀, R/B₀];
 (A)  a ≥ (1 − 2δ)κ + a_v and a_L ≥ 4Lκ + a_v, a_v := ln(4·2d·e)   [the rates Bałaban's format and the volume sums of (2.19), (2.37)
      consume; they replace ⅛(κ₁ − 1) ≥ (1 − 3δ)κ, ¼(κ₁ − 1) ≥ (1 − δ)κ, (1/16)κ₁ ≥ (1 − 2δ)κ, ½(κ₁ − 1) ≥ 2Lκ].

LEMMA RD. Under the inputs and conditions above:
 (i) LEMMA 1_RD. (1.33) holds with V′_k(Y, U, J, B) analytic on (1.34), localized (1.35), gauge invariant, and
      |V′_k(Y, U, J, B)| ≤ E₀ε₁ C₁^{RD} M^q · e^{(1−2δ)κ d_k(□̃⁵)} · e^{−(1−2δ)κ d_k(Y)},
   C₁^{RD} := 8(R₁/B₀)C₁α₂⁻¹·(α₁/α₃)⁵·2(6L)⁴·O(1)_{(1.26)}·(1 − (1+η)⁻¹)⁻¹·S_□ /M^q·E₀⁰ … written out: the page's 8B₀C₁e^{16κ₁}α₂⁻¹E₀(α₁/α₃)⁵
   with B₀e^{16κ₁} → R₁, (1.26)'s O(1), (1.24)'s 2(6L)⁴ for □′ and j, (1.27)'s e replaced by Lemma SD's (1 − eB_w/R₁)⁻¹ ≤ 1 + 1/η, and
   (1.28)'s count of □₀ ⊂ Y replaced by S_□ := sup_Y n(Y)e^{−a_v d_k(Y)/2} ≤ 16·sup_t(1 + t)e^{−a_v t/2} (Lemma MS: n ≤ 16 + 16d_k).
 (ii) LEMMA 2_RD. (1.41)–(1.42) hold with Q(Y, B, b, b′) = 0 unless Y = N ∪ F, N a family of at most 2^d cubes with a common point
   ("near cluster", d_k(N) = 0), and
      |Q(Y, B, b, b′)| ≤ C_Q ε₁M⁴ e^{−a|F|} ≤ C_Q ε₁M⁴ e^{−(1−2δ)κ d_k(Y) − a_v|F|},   C_Q := ½C₃3³(R/B₀)³C₁,
   the page's ½C₃3³e^{7·8κ₁}C₁ with e^{16κ₁} → R/B₀ = e(1+η)²; V″_k obeys (i) with the base factor absent for the P^{(k)}-terms.
 (iii) LEMMA 3_RD. CMP 116's expansion (2.1)–(2.13) holds with (2.8) at real s, and with ε₂^{RD} := 2E₀ε₁C₁α₄^{RD,−1}α₆⁻¹M^qK_V,
   K_V := max{C₁^{RD}e^{(1−2δ)κd_k(□̃⁵)}, C_Q′}/C₁ in place of exp C₂κ₁, α₄^{RD} := 2^{−(2^d+d)}α₄ (the near-cluster count of (2.19)),
   α₅^{RD} := e(1+η)²O(1)e^{2^d a_L − ⅓δ₀M} + O(α₀ + α₁) + O(1)α₄ + γ₂:
      |H(Z)| ≤ C₃^{RD}ε₁ exp(−(1 − 8δ)½Lκ d_{k+1}(Z)),   C₃^{RD} := 2(L+2)⁴O(1)_{p.20}·ε₂^{RD}/ε₁,
      |E^{(k+1)}(X)| ≤ O(1)C₃^{RD}ε₁ exp(−(1 − 10δ)½Lκ d_{k+1}(X)),
   under (2.28)^{RD}: ε₂^{RD}α₆⁻¹… e^{5κ} ≤ 1 (the page's (2.28) with exp C₂κ₁ → K_V), (2.31) unchanged, p. 20's conditions unchanged.
 (iv) ANALYTICITY. Every V′_k(Y), V_k(Y), H(Z), E^{(k+1)}(X) is analytic in (U, J, B) on the page's domains and gauge invariant; for
   any parameter p entering the interaction analytically (M3c's s̄, d, a complex history), H(Z; p) and E(X; p) are analytic in p.
 (v) κ₁ DOES NOT OCCUR. Void: (K1) κ₁ ≥ 1 + 2ln(8·12³); (K2) κ₁ ≥ 16(1 − 2δ)κ; (1.11)'s B₀e^{16κ₁}; (1.13)–(1.16)'s e^{16κ₁}, e^{32κ₁};
   (1.21)'s "e^{32κ₁}ε₁ smaller than an absolute constant"; (1.40)'s e^{7·8κ₁}; (2.16)'s e^{−⅓δ₀M}e^{16κ₁} < 1; (2.26)'s
   e^{−(κ₁−1)(LM)⁻⁴|Z∖Z₀′|}; p. 20's ½(κ₁ − 1) ≥ 2Lκ.
 (vi) THE FORMAT FACTOR IS NOT REMOVABLE IN BAŁABAN'S FORMAT (§8): any bound of the form (1.36) for the terms of (i) has
   E₀ε₁C₁M^qK ≥ |V′_k(□̃⁵-term)|·e^{(1−2δ)κd_k(□̃⁵)}, and d_k(□̃⁵) ≥ 914.0625.

## 7. PROOF OF LEMMA RD, AGAINST CMP 116 pp. 3–21

### 7.1 The decoupling identity is already real (pp. 4, 14)
(1.9) and (2.8) are the fundamental theorem of calculus in s(Δ) ∈ [0, 1]; (1.10) groups by the component Y₀ ⊃ □̃⁴ using p. 4's
locality. Lemma SD (i) evaluates every iterated integral exactly: the term of (1.10) at Y₀ is Σ_{T⊂Y₀∖□̃⁴}(−1)^{|Y₀∖□̃⁴∖T|}F(1_T). No
step of pp. 4–21 uses more about the decoupled term than its value; the Cauchy formulas in σ(Δ) ((1.23), (1.38), (2.14)) only BOUND it.

### 7.2 The operators at real s (p. 5, (1.11))
For s ∈ [0, 1]^{Y₀∖□̃⁴} every walk weight is a product of numbers in [0, 1], so ‖H(s)X‖ ≤ B₀|X|, and the same for G̃(s), H₀(s), in all
norms of Theorems 3.1–3.10 [13] — "the first two factors in (1.7) … determine the constant B₀". Bałaban's e^{16κ₁} came from short walks
touching up to 2⁴ cubes at |s| = e^{κ₁}; at real s it is 1.

### 7.3 The fixed points (pp. 5–6, (1.12)–(1.18)) — M6's falsifier answered
By (1.5) (p. 3) D(H, A′), A₀(H, G̃, H₀B′) are functionals of the operators, and the contraction proof of (1.13)–(1.16) uses only operator
norms. Repeat it for COMPLEX operators of norm ≤ R₁ (in place of B₀e^{16κ₁}): by (R) the map X ↦ C(A′ − HX) sends {|X| < 4C₂ε₂²} into
itself and contracts, so D is holomorphic in (H, A′) on {‖H‖ < R₁} × {|A′| < ε₂} with |D| ≤ 4C₂|A′|² (1.14); (1.15)–(1.16) hold with
B₀e^{16κ₁} → R₁, so A₀ is holomorphic in (H, G̃, H₀, B′) with |A₀| ≤ 4C₄R₁³|B′|² ≤ R₁ε₃ ≤ ½ε₂, and (1.17)–(1.18) give H_k holomorphic
with |H_k| ≤ 4R₁|B′|. With (1.19)–(1.20), |H_k| ≤ 4R₁C₁g_k|B| (1.21)_RD, and by (D) the field (tζ̃_□ + t_□ζ_□)H_k obeys (I.3.31) for
|t_□| ≤ r_□, 1/r_□ := 8R₁C₁α₂⁻¹g_k|B| ((1.22)_RD). THE FALSIFIER: the fixed points ARE used off the real segment — on the operator
ball of radius R₁ = e^{1+2^d a}(1+η)²B₀ (R = e(1+η)²B₀ for the P^{(k)}-terms), i.e. on a fixed complex neighbourhood whose size does not
depend on κ₁, which no longer exists. What is NOT used is analyticity in s on |s| ≤ e^{κ₁}. M6's falsifier, in the form "a step needs
the fixed points analytic in s off the real segment", is met only at the radius of the polarization constant e(1+η)² and the
near-boundary weight e^{2^d a} — the costs (R), (D) — and NOT at the radius e^{κ₁} that produced 2C₂κ₁.

### 7.4 The history terms, (1.23)–(1.32) and Lemma 1
Fix □₀ = □̃⁵ (CMP 109 p. 273, READ: "We take the function U_j constructed for the cube □₀ = □̃⁵"), □′, j, X ⊂ □̃² and the term
Φ(h) := ∂_{t_□}E(□₀, (tζ̃_□ + t_□ζ_□)H_k(h, B′))|_{t_□=0} — the page's t_□-Cauchy (1.23) RETAINED: it is a Cauchy formula in a scalar
multiplying a field, radius r_□ from 7.3, and gives ‖Φ‖ ≤ K_Φ := r_□⁻¹·E₀(α₁/α₃)⁵(L^jη)⁵e^{−κd_j(X)} by (I.3.54) on the operator ball
{‖h‖ < R₁}. Apply Lemma SD with c(ω) := the decoupling cubes OUTSIDE □₀ met by X̃₀⁵ ∪ ⋯ ∪ X̃ₙ⁵ (the cubes of the shell □₀∖□̃⁴ are
decoupled on the page too, but they do not change Y = Y₀ ∪ □₀: grouping (1.10) by Y sums them out, Lemma SD (ii)), the weight
w′(ω) := e^{2^d a·1[ω ⊂ near zone]}w(ω) of Lemma G (iv) with N₀ = 0, Ψ := the number of cubes. Lemma C makes every nonvanishing tuple
linked to □₀; Lemma G (ii)–(iv) gives |∪c(ω_i)| ≤ a⁻¹Σ ln w′(ω_i); B_{w′} ≤ e^{2^d a}(1+η)B₀ < R₁/e. Hence
   Σ_{Y ⊃ □₀} e^{a·n(Y∖□₀)} |Σ_{(1.23) with Y₀∪□₀ = Y} …| ≤ K_Φ (1 − eB_{w′}/R₁)⁻¹ ≤ (1 + 1/η) K_Φ.                       (7.1)
This replaces (1.24) [e^{−(κ₁−1)M⁻⁴|Y₀∖□̃⁴|} → e^{−a·n(Y∖□₀)}] AND (1.27) [the sum over the ≤ 8·12³ subsets is free: Lemma SD (ii)].
The sum over X ⊂ □̃², □′ ⊂ □̃² and j is the page's: (1.26) and 2(6L)⁴ (READ p. 8). CONVERSION TO THE FORMAT (1.25)_RD: Y = □₀ ∪ U with
U face-connected to □₀ (p. 4's components), so d_k(Y) ≤ d_k(□₀) + |U| (§3.4, companion); with a ≥ (1 − 2δ)κ + a_v,
   e^{−a·n(Y∖□₀)} ≤ e^{(1−2δ)κd_k(□₀)} e^{−(1−2δ)κd_k(Y)} e^{−a_v n(Y∖□₀)}.                                              (7.2)
The sum over □₀ ⊂ Y (the page's (1.28)) is at most n(Y) ≤ 16(1 + d_k(Y)) choices (Lemma MS); half of a_v absorbs it into S_□.
This is (i). THE TERMS (I.3.7), (1.30)–(1.32): base X₀ (the smallest D_k-domain containing X); the same argument with □₀ → X₀ gives
(1.30)_RD with e^{−(κ₁−1)M⁻⁴|Y∖X₀|} → e^{−a·n(Y∖X₀)} and E₀24B₀²C₁B₃e^{16κ₁}α₂⁻¹ε₁ → E₀24(R₁/B₀)B₀²C₁B₃α₂⁻¹ε₁; there the base IS
paid by the history, d_j(X) ≥ (L^jη)⁻¹d_k(X₀) (1.31), so (1.32) holds verbatim with ¼(κ₁ − 1) ≥ (1 − δ)κ replaced by a ≥ (1 − δ)κ + a_v.
The sum over X ∋ □′ is the page's, "(1.26) for δκ sufficiently large" — the κ floor of §3.5. THE TERMS (I.3.21): "expanded and
analyzed in almost the same way as the last term in (I.3.34)" (p. 9) — the same proof.

### 7.5 The Wilson part, (1.37)–(1.43) and Lemma 2
For the plaquette-localized V_□(H₁B′) the decoupling cubes are those disjoint from the interior of □ (p. 10), and the term at a
plaquette p is read at a point. Lemma SD with Φ(h) := V_□(h, H₁(h)B′) on {‖h‖ < R}: every nonvanishing tuple is linked to p (Lemma
C); by Lemma G (i)–(ii) its cubes are a near cluster N around p (one ball of radius < M/2: at most 2^d cubes with a common point) plus a
set F with |F| ≤ a⁻¹Σ ln w(ω_i); so with N₀ = 0 and Ψ := |F|, the majorant of (1.39) is C₃(e(1+η)²|B′|)³M⁴ (the page's
C₃(e^{16κ₁}|B′|)³M⁴ with the operator ball R in place of B₀e^{16κ₁}), on the domain e(1+η)²|B′| ≤ a₁. The second-order coefficients are
extracted by Cauchy IN THE FIELD B′ (retained — the page's "expand (1.38) with respect to B′ up to the second order"), on the circle
of radius 2|B′| around tB′: |∫₀¹dt(1 − t)∂²(…)| ≤ ½C₃3³(e(1+η)²)³|B′|e^{−a|F|} on 3e(1+η)²|B′| ≤ a₁ — (1.40)_RD. With
d_k(N ∪ F) ≤ |F| (§3.4 companion) and a ≥ (1 − 2δ)κ + a_v this is (ii); |B′| ≤ C₁ε₁ (1.20) gives C_Q; the sum over □ ⊂ Y (p. 11's
M⁻⁴|Y| ≤ e^{M⁻⁴|Y|}) is absorbed as in 7.4. NO BASE FACTOR: the read region is a point, and the near cluster has d_k = 0. The remaining
P^{(k)}-terms (p. 11: "it can be done in the same way for all terms in P^{(k)}") and the D-term 𝒲 of M3c's Lemma W (a quadratic form
in H₁ — Lemma SD's series is then finite, of degree 2) are the same.

### 7.6 §2 with real decoupling, (2.7)–(2.41)
(2.1)–(2.6) do not involve decoupling parameters and are the page's. (2.7)–(2.8): the operators C^{(k)}(Z₀, s), (C^{(k)})^{1/2}(s),
Δ_k(s) at real s; G(Z₀, X, ·) of (2.6) is a holomorphic function of the operators on the ball where Re(C^{(k)}(Z₀, ·)⁻¹) stays positive.
Write each operator as O(s) = O(0) + δO(s), δO(s) the sum of the walks touching decoupling LM-cubes (s-weight ≠ 1), and apply Lemma SD
to δO ↦ G(O(0) + δO) around δO = 0 — the σ(Z) = 0 operators the page itself compares with ((2.15): "we replace the operators by the
corresponding operators with σ(Z) = 0"). Every walk in δO has a small localization domain X with dist(X, Z₀) > ⅔M (p. 13), so by (1.7)
and Lemma G at scale LM (a_L, L₀^{(L)}), Σ‖h_ω‖w_L(ω)e^{2^d a_L} ≤ (1+η)B₀e^{2^d a_L − ⅓δ₀M} — the page's O(1)e^{−⅓δ₀M} (2.16) with
e^{16κ₁} → e(1+η)²e^{2^d a_L}, small by (G). Hence (2.15)–(2.25) hold with the complex σ-operators replaced by O(0) + δO, ‖δO‖ in the
Lemma SD ball: (2.16)_RD |R₁(b, b′)| ≤ (e(1+η)²O(1)e^{2^d a_L − ⅓δ₀M} + O(α₀ + α₁))e^{−½δ₀|b₋ − b′₋|}, (2.17)_RD likewise, α₅^{RD} as
stated. The factor e^{−(κ₁−1)(LM)⁻⁴|Z∖Z₀′|} of (2.15)/(2.26) becomes e^{−a_L·n_{LM}(Z∖Z₀′)} by Lemma SD (iii); p. 20's "½(κ₁ − 1) ≥ 2Lκ"
and "exp(−½(κ₁ − 1)) beside (LM)⁴α₅" are met by a_L ≥ 4Lκ + a_v and (G). (2.18)–(2.20): the τ-Cauchy is RETAINED (a Cauchy formula in
the scalar multiplying a localized potential, radius = α₄/(its bound), cost linear: M3c §1.2), with 1/|τ(Y)| := E₀ε₁C₁α₄^{RD,−1}M^qK_V
·e^{−(1−3δ)κd_k(Y)}; (2.19) by (ii): R(Y)|Q| ≤ α₄^{RD}M⁻⁴(C_Q/(E₀C₁K_V))e^{−δκd_k(Y) − a_v|F|}, and the sum over Y ∋ b₋ runs over at most
2^{2^d−1}·2^d near clusters times Σ_F e^{−a_v|F|}(2de)^{|F|} ≤ 2 — absorbed by α₄^{RD} = 2^{−(2^d+d)}α₄. (2.21)–(2.41) are the page's
with exp C₂κ₁ → K_V: (2.26)_RD, (2.27) (a geometric fact), (2.28)_RD, (2.29)–(2.35), (2.36) (geometric), (2.37)–(2.41). ∎

### 7.7 What the proof does and does not use
USED COMPLEX: the operator balls of radius R, R₁ (Lemma SD's polarization); the scalar Cauchy formulas in t_□ (field scaling), in
B′ (Taylor coefficients) and in τ(Y) (Mayer coupling) — each with radius equal to the inverse of a bound and linear cost. NOT USED: any
complex decoupling parameter. STATUS: Lemma RD (i)–(v) PROVED GIVEN CMP 116's own inputs (the same status as M3c's Lemma M); (vi)
PROVED in §8.

## 8. THE FORMAT FACTOR — WHY "POLYNOMIAL × ε₁" FAILS IN BAŁABAN'S FORMAT, AND WHAT IT COSTS (PROVED)

THEOREM F. (a) In Bałaban's printed derivation of Lemma 1, the terms of (1.23) with localization domain Y = Y₀ ∪ □₀ carry the factor
e^{+⅛κ₁d_k(□₀)} ((1.25), READ p. 7: "Adding and subtracting ⅛κ₁d_k(□₀) under the first exponential above"), with □₀ = □̃⁵ (READ, CMP 109
p. 273); converting (1.29) into (1.36) for every Y ⊃ □₀ requires
   C₂κ₁ ≥ 16κ₁ + (1/16)κ₁d_k(□̃⁵) + (1 − 2δ)κd_k(□̃⁵)   (the 16κ₁ is (1.24)'s e^{16κ₁}).                                    (8.1)
(b) For ANY localization of these terms — Bałaban's or Lemma RD's — a bound of the form (1.36), E₀ε₁C₁M^qK e^{−(1−2δ)κd_k(Y)} for all Y,
evaluated at Y = □₀ against the term's own bound there (no decoupled cube: (1.24) resp. (7.1) at n(Y∖□₀) = 0) forces
   K ≥ e^{(1−2δ)κ d_k(□̃⁵)} × (the page's polynomial constants, with (α₁/α₃)⁵ inside O(M^q) as p. 8 places it).            (8.2)
(c) d_k(□̃⁵) ≥ 914.0625 (Lemma MS).
PROOF. (a) From (1.25), (1.27), (1.28): (1.29) holds with exp O(1)κ₁ ⊇ exp(16κ₁ + ⅛κ₁d_k(□₀)) and decay e^{−(1/16)κ₁d_k(Y)}; for (1.36)
at Y with d_k(Y) = d ≥ d_k(□₀) =: d₀ one needs C₂κ₁ − (1−2δ)κd ≥ 16κ₁ + ⅛κ₁d₀ − (1/16)κ₁d, i.e. C₂κ₁ ≥ 16κ₁ + ⅛κ₁d₀ − ((1/16)κ₁ −
(1−2δ)κ)d, whose largest right side over d ≥ d₀ is at d = d₀ ((1/16)κ₁ ≥ (1−2δ)κ by p. 9): this is (8.1). (b) is (a)'s last step with
any constant in place of exp C₂κ₁. (c) is Lemma MS. ∎
THE MEANING. The relocalized history terms are born compact: their domain contains □̃⁵, 11⁴ M-cubes, whose linear size is ≥ 914.
Bałaban's format charges every polymer e^{−(1−2δ)κ·(linear size)}, which a compact object of size ε₁ cannot pay; the constant pays it.
This has nothing to do with complex decoupling: Bałaban pays it as ⅛κ₁d_k(□₀) ⊂ C₂κ₁ (so C₂ ≥ 16 + 914.0625/16 + (1−2δ)κ·914.0625/κ₁ ≥
115.64 at κ = 1, κ₁ = 20.068 — not 56, M6's (1.40) reading), Lemma RD pays it as (1−2δ)κ·914.0625. COMPUTED (run a, B2, B3).

## 9. THE BB4* INTERFACE — SETTLED: REAL DECOUPLING SUPPLIES EVERYTHING THE DOWNSTREAM NEEDS

THE TENSION, RESOLVED. "BB4* uses complex analyticity in s" refers to M3c's interaction multiplier s̄ (and the coupling deviation d),
not to CMP 116's decoupling parameters s(Δ). The two never meet: M3c §1.1 (READ there, and here on pp. 2–11): "THE INTERACTION COUPLING
DOES NOT ENTER §1: every operation there … acts on one term of the action at a time and is linear in that term". Lemma SD is linear in
the term too (F ↦ F_S is linear), so s̄V_k and −d𝒲 are localized by Lemma RD exactly as V_k and 𝒲 are, and the coupling parameters
stay complex.
WHAT EACH DOWNSTREAM PIECE NEEDS, AND WHO SUPPLIES IT:
| Piece (M3c) | Needs in the coupling variables | Needs from §1–§2 | Supplied by |
|---|---|---|---|
| Lemma M (§2) | potentials analytic in a parameter p ↦ activities analytic in p (part (d)) | (M-i) analyticity in (U, J, B), localization, gauge invariance; (M-ii) cone bounds | Lemma RD (iv) and (i)–(iii): the cone 𝒱(ε) with e^{C₂κ₁} → K_V, the volume factor e^{−½(κ₁−1)M⁻⁴|Y|} → the near-cluster structure with e^{−a_v|F|}; §2 is Lemma RD (iii) |
| Theorem BB4* | complex s̄, |s̄| < R₀; Schwarz (3.1), Cauchy (3.2) in s̄ | Lemma M | unchanged proof; R₀ := ε₁^max/ε₁ with ε₁^max recomputed from K_V |
| Lemma W | 𝒲 ∈ 𝒱(C_W) | decoupling of the quadratic form ½⟨H₁B′, Δ₁H₁B′⟩ | Lemma SD on a degree-2 functional: a FINITE series, C_W^{RD} = O(1)(R/B₀)²B₀²‖Δ₁‖ — κ₁-free (M3c needed C₂ ≥ 56 to absorb C_W's e^{O(κ₁)}) |
| Theorem BB4*-D | joint analyticity in (s̄, d) on |s̄| ≤ R₀/2, |d| ≤ θ_* | Lemma M, Lemma W | θ_* = ε_*/(2(C_W^{RD} + ε_*)), LARGER |
| Lemma M_m (moment form) | Cauchy in s̄ with pointwise radii | the B-dependent bounds (1.20), (1.24)'s g_k|B|, (1.40)'s |B′| | retained verbatim: (1.24)'s g_k|B| comes from the t_□-radius (7.3, a field-scaling Cauchy), (1.40)'s |B′| from the Cauchy formula in B′ (7.5) |
| Lemma C′ (a)–(c) | Cauchy in d on |d| ≤ θ₀ | BB4*-D, FP | unchanged |
| Lemma FP | none (a determinant identity) | CMP 109 §0, pp. 266–268 | unchanged |
DECISION, EXACTLY. Option (a): Lemma RD PRESERVES what BB4* needs. No real-variable replacement of BB4*'s Cauchy estimates is needed,
because those are Cauchy estimates in COUPLING parameters, which enter the interaction linearly, with radius = the inverse of a bound
and a linear cost; they never produced an e^{κ₁}-type factor. Every e^{C₂κ₁} in M3c's constants (c₂′, ε_*, ε₁^max, R₀, θ_*, C₅) came from
§1's bounds and is replaced by K_V. The status of BB4*, Lemma W, Lemma M_m, Lemma C′ is unchanged: PROVED GIVEN CMP 116's inputs.

## 10. THE LADDER, CERTIFIED WHERE COMPUTED

Three independent exponentials sit in CMP 116's bookkeeping, and only the first involves complex parameters:
 E1 = 2C₂κ₁ (Cauchy's price, M6) — DELETED by Lemma RD (PROVED GIVEN CMP 116's inputs).
 E2 = 2(1 − 2δ)κ·d_k(□̃⁵) ≥ 1706.25κ (L = 3) — the d_k-format charged on the relocalization base. Present in Bałaban's own chain (where it
   is ⅛κ₁d_k(□̃⁵) inside C₂κ₁) and in Lemma RD's. Removed only by changing the format (Lemma M_w below).
 E3 = the size of κ itself: the page needs δκ ≥ ln 91 (Lemma F), κ ≥ 10 ln 91/(1 − 2/L) ≥ 45.11; every e^{cκ} scales with it.
CERTIFIED (run a): M6's table with E1 deleted — bottleneck T18, 10^{111.09}. Lemma RD as proved, in Bałaban's format, at M6's κ = 1 —
bottleneck E2, 10^{747.26} (L = 3), 10^{641.40} (L → ∞). At the page's κ floor — 10^{100 870} (L = 3), ≥ 10^{28 850} for every L. Bałaban's
printed chain with E2 carried — 10^{2021.98} (κ = 1, L = 3; M6 had 10^{982.39}), 10^{65 525} at its own floor (L → ∞).

THE NEXT OBJECTS, IN ORDER:
(N1) LEMMA M_w — §2 AS A THEOREM WITH BASE-ADAPTED WEIGHTS. M3c's Lemma M with the uniform weight e^{(1−2δ)κd_k(Y)} replaced by a weight
   W(Y) that charges a relocalization base what its IMAGE costs at scale k + 1: W(Y) := exp((1−2δ)κ·min_{decompositions}[Σ_extras +
   Σ_bases (L/2)d_{k+1}(b/L)]). Axioms §2 uses: (W1) quasi-additivity over connected unions (the role of (2.27)); (W2) Σ_{Y∋□}W(Y)^{−δ} ≤
   O(1) (the role of (2.29)); (W3) 2·log W_k(Z) ≥ L·log W_{k+1}(Z′)·(1−2δ)⁻¹… (the role of (2.36)). FALSIFIER: (W3) for a single base,
   2·(L/2)d_{k+1}(□̃⁵/L) ≥ L d_{k+1}(□̃⁵/L) holds with equality — but the page's (2.36) with d_k itself FAILS for d̂-sized bases unless
   L ≥ 11 (then □̃⁵/L lies in a 2^d-block and d_{k+1} = 0). Expected residual at L = 3: e^{(1−2δ)κ·d_{k+1}(□̃⁵/3)} per base,
   d_{k+1}(□̃⁵/3) ≥ (4⁴ − 16)/16 = 15 (Lemma MS: a cube of side 11/3 meets ≥ 4⁴ cubes) — 28κ in log β instead of 1706κ.
(N2) LEMMA KP — ONE ENTROPY PAYMENT PER STEP. Replace the δ-shares of the polymer entropy (p. 9's (1.26) at δκ; (2.19); (2.29); (2.35);
   (2.37); (2.39)–(2.40)) by a single Kotecký–Preiss criterion per scale for the combined activities, so that κ need only exceed the
   entropy rate once: κ_min → ln 91/(1 − 2/L)·(share) instead of 10 ln 91/(1 − 2/L). FALSIFIER: a step that needs two entropy sums in
   sequence at the same scale with the second's activities defined only after the first is summed.
(N3) Then the large-field architecture binds: T18 (LFR II (1.9)) at 10^{111.09} (M = 27, L = 3), T17 at 10^{101.87} — M6's Lemma LF.

## 11. CROSS-FIELD IDENTIFICATIONS

(U1) THE DECOUPLING EXPANSION IS A MÖBIUS INVERSION. ∫_{[0,1]^S}∂^S F = Σ_{T⊆S}(−1)^{|S∖T|}F(1_T) is Möbius inversion on the Boolean lattice of
cube sets; for a functional that is an absolutely convergent series of products of walk monomials, the inverted term is exactly the sum
of the products whose union of supports is S. This is the "connected part" of Mayer/Ursell theory and the reason Brydges–Kennedy and
Abdesselam–Rivasseau forest formulas need no Cauchy radius: localization is bookkeeping of supports, and decay is a property of the
supports, paid by the walks. Bałaban already does this for log Z^{(k)} (p. 21: "κ replaced by δ₀M").
(U2) THE κ FLOOR IS A LATTICE-ANIMAL GROWTH CONSTANT, THE SAME OBJECT AS THE GROUND'S KOTECKÝ–PREISS RADIUS. δκ ≥ ln c₃ = ln 91 is the
entropy of d_k-polymers (connected unions of M-cubes) measured on the edge-line family; it plays for Bałaban's induction the role the
certified polymer count N_c(F) plays in THE GROUND's flux-surface gas (Theorem 8.9's KP certificate, aperanton_kp_cert.awk). The
ultraviolet half has never had its entropy constants computed; c₃ = 91 is the first, and it already moves the threshold by orders of
magnitude. A computed-constant UV renormalization group needs the GROUND's discipline: count the polymers, certify the KP sum.
(U3) THE BASE COST IS A UNIT ERROR. Linear size measures a polymer by the tree needed to touch it; a relocalized remainder is a compact
cube of 11⁴ M-cubes by birth, and the tree-length unit charges it like 914 separate excursions. The same mismatch appears whenever a
polymer norm built for SPARSE objects (paths of propagators) is applied to objects born COMPACT (large-field regions, coordinate
patches); the cure in both places is to measure compact objects in the coarser scale's units — LFR's R_k-cubes are Bałaban's own
instance of that cure, applied to large fields but not to relocalized remainders.

## 12. LEDGER (this agent's rows)

| Item | Status | Where |
|---|---|---|
| CMP 116 pp. 2–21, CMP 109 pp. 257, 273–276 on image | READ | §0, §2 |
| every κ₁-site of CMP 116 classified (decay / analyticity domain / positivity / coupling-type) | READ | §2 |
| Lemma SD (support decomposition = exact Möbius inversion; one term, one polymer) | PROVED | §3.1, §3.6 |
| Lemma C (locality of multilinear coefficients) | PROVED GIVEN p. 4 | §3.2 |
| Lemma G (decay per cube from the walks) | PROVED | §3.3 |
| Lemma MS: d_k(Y) ≥ (n(Y) − 16)/16; d_k(□̃⁵) ≥ 914.0625 | PROVED | §3.4 |
| Lemma F: #{X ∋ □′ : d ≤ t} ≥ 91^t; the page needs κ ≥ 10 ln 91/(1 − 2/L) | PROVED; c₃ COMPUTED | §3.5, §5 |
| LEMMA RD (i)–(v): CMP 116 §§1–2 with real decoupling; κ₁ eliminated; constants traced | PROVED GIVEN CMP 116's inputs | §§6–7 |
| M6's falsifier (fixed points off the real segment) | met only at the operator-ball radius e(1+η)², e^{2^d a}; NOT at e^{κ₁} | §7.3 |
| Theorem F: the format factor e^{(1−2δ)κd_k(□̃⁵)} survives any decoupling; Bałaban's C₂ ≥ 115.64, not 56 | PROVED | §8 |
| BB4* interface | SETTLED: preserved; no replacement needed | §9 |
| M6's table with C₂κ₁ removed: bottleneck T18, log₁₀ β_B ≥ 111.08510 | COMPUTED | §5 (A) |
| Lemma RD in Bałaban's format: bottleneck E2, log₁₀ β_B ≥ 747.26099 (κ = 1, L = 3) | COMPUTED | §5 (B) |
| the page's κ floor: log₁₀ β_B ≥ 28 850.44 (inf over L) after Lemma RD; Bałaban's chain ≥ 2021.98 (κ = 1), ≥ 65 525.66 (floor) | COMPUTED | §5 (B), (C) |
| Lemma M_w (base-adapted weights), Lemma KP (one entropy payment) | NAMED, each with its falsifier | §10 |

## 13. DATED PRECISIONS TO §10 (2026-11-02, after §§0–12; nothing above edited)

13.1 (N1)'S FALSIFIER, RESTATED. With W charging a base b what its image costs at scale k + 1, (W1) and the geometric steps (2.27),
(2.32) hold by construction (W is a minimum over decompositions, hence subadditive), and (W3) holds with equality on a single base.
The steps that can fail are the VOLUME absorptions at scale k: (2.34) needs e^{−(1/20)γ₂ε₁²/γ²}·M⁻⁴|Z₀| ≤ δ·log W(Z₀), and for Z₀ = a base
M⁻⁴|Z₀| = 11⁴ while log W(Z₀) = (1−2δ)κ(L/2)d_{k+1}(□̃⁵/L) — so (2.34) costs only a logarithm in γ (γ ≤ ε₁(γ₂/(20 ln(11⁴/(δ log W))))^{1/2}),
not an exponential. FALSIFIER of Lemma M_w: a step of §2 at scale k in which d_k(Z) must dominate a quantity proportional to the VOLUME
of a base and which cannot be deferred to scale k + 1 (where (2.40)–(2.41) absorb (LM)⁻⁴|X| by e^{−½δLκd_{k+1}(X)}).
13.2 (N2)'S FLOOR, RESTATED. Lemma F bounds the growth rate of #{X ∋ □′ : d(X) ≤ t} below by ln 91 for ANY scheme summing d_k-polymers;
a single Kotecký–Preiss payment per scale can use at most the whole rescaling budget (1 − 2/L)κ (the factor ½L of (2.36) against the
losses), so every d_k-polymer scheme needs κ ≥ ln 91/(1 − 2/L): 13.53 at L = 3, 4.51 as L → ∞ — against the page's 135.33 and 45.11.
That is Lemma KP's target. With it the e^{5κ} row of (2.28) is 10κ + ln 80κ = 145.6 → log₁₀ β ≥ 63.2 at L = 3 (κ = 13.53), below T18.
13.3 WHAT THE NUMBERS SAY TOGETHER. In M6's convention (κ = 1): Lemma RD → 10^{747.26} (E2 binds); + Lemma M_w → 10^{111.09} (T18 binds;
E2's residual 28κ at L = 3 is below it). At the page's κ: Lemma RD → ≥ 10^{28 850}; + Lemma M_w → the e^{5κ} row, 10^{591.75} (L = 3) /
10^{199.46} (L → ∞); + Lemma KP → ≈ 10^{63} for the e^{5κ} row at L = 3, and the large-field rows T17/T18 (10^{101.9}–10^{111.1}) bind.
The middle of the window is then the large-field architecture's — M6's Lemma LF — exactly as M6's ladder said, but reached only after
two further lemmas M6's table did not see.

## 14. DATED CORRECTION TO 13.2 AND STAKES FOR RUN b (2026-11-02; written before `bin/m6b_thresholds_b.py` exists)

13.2's arithmetic is wrong as written: at κ = ln 91/(1 − 2/3) = 13.5326, 10κ + ln(80κ) = 135.326 + 6.987 = 142.31, not 145.6, so
log₁₀ β ≥ 61.81, not 63.2. Run b certifies it. STAKES: (b1) κ_KP(L = 3) = 3 ln 91 ∈ [13.532, 13.533], κ_KP(L → ∞) = ln 91;
(b2) the e^{5κ} row at κ_KP: log₁₀ β ≈ 61.81 (L = 3), ≈ 21.4 (L → ∞: 45.11 + ln 360.9 = 51.0 → 22.1);
(b3) E2's residual after Lemma M_w at L = 3, κ = 1: 2(14/15)·15 + 10 + ln 80 = 42.38 → log₁₀ β ≈ 18.41;
(b4) the same three rows at L = 3, κ = 13.5326 (Lemma KP's floor): E2-residual + e^{5κ}: 2(14/15)·15·13.5326 + 142.31 = 379.0 + 142.3
= 521.3 → ≈ 226.4 — ABOVE T18: with Lemma KP at L = 3 the residual base still binds unless L ≥ 11 (where it vanishes);
(b5) at L = 11 (residual 0, M ≥ L³ = 1331): κ_KP = ln 91/(9/11) = 5.513, e^{5κ} row 55.13 + ln 441.1 = 61.22 → 26.6; T18 at M = 1331
(p₀ = 10, r = 2) ≈ 151.6; T17 at M = 1331 ≈ 138; so T18 binds at ≈ 10^{151.6}.

## 15. RESULTS OF RUN b (record `rec/thresholds_run.2026-11-02b.txt`, rc = 0; §14 unedited)

(b1) HELD: κ_KP = 13.53258 (L = 3), 5.51327 (L = 11), 4.51086 (L → ∞). (b2) HELD at L = 3: 61.80571; at L → ∞ the computed 22.14776 equals
the stake's parenthetical (22.1) and REFUTES its leading number "≈ 21.4", a slip in the stake. (b3) HELD: 18.40628. (b4) HELD: 226.36519.
(b5) HELD: e^{5κ} row 26.58834 at L = 11; T18 at M = 1331: 151.56570; T17 at M = 1331: 138.95814.
READING (the rows of Lemma M_w and Lemma KP are rows of NAMED lemmas, not proved ones): with all three lemmas, L = 3 is still bound by
E2's residual, 10^{226.37} (the base □̃⁵/3 at scale k + 1 has linear size ≥ 15 and κ ≥ 13.53); at L = 11 the residual vanishes and the
large-field row T18 binds, 10^{151.57}; intermediate L (5, 7) trade the two (ESTIMATED 10^{127}–10^{138}, not certified here). The order
of the ladder is fixed: Lemma RD (PROVED GIVEN), then Lemma M_w and Lemma KP (NAMED), then Lemma LF (M6's).

## 16. DATED CORRECTION TO §6 (A), (R), (D) AND §7.3–7.4: THE NEAR-BOUNDARY WEIGHT ENTERS ONCE, LINEARLY (2026-11-02)

THE SLIP. §6 put the near-boundary weight e^{2^d a} into the OPERATOR ball (R₁ := e^{2^d a}R), with a ≥ (1 − 2δ)κ + a_v, a_v = ln(8de) =
4.466. Then (R)'s quadratic condition 4C₄R₁²ε₃ ≤ 1 would cost e^{2·2^d a} in ε₃ — at κ = 1 already e^{173}. Both parts are wrong in
the costly direction and are corrected here; nothing proved above is weakened, and no number of §§5, 15 involves R₁.
(1) THE RATES SPLIT. The history terms of Lemma 1 enter V″ only, and §2 uses them only through |τ(Y)||V″(Y)| ≤ α₄e^{−δκd_k(Y)} ((2.18)–
(2.20)): they need a₁ := (1 − 2δ)κ + ε (ε > 0 arbitrary; the count n(Y) ≤ 16(1 + d_k(Y)) of bases in Y costs the polynomial
16·sup_t(1 + t)e^{−εt} ≤ 16/(eε)). The volume rate a_v is needed only by Q (Lemma 2, for the Y-sum of (2.19)): a₂ := (1 − 2δ)κ + a_v.
The read region of Lemma 2 is a point, so a₂ never meets a near-boundary weight (§7.5: the near cluster has d_k = 0, N₀ = 0).
(2) TWO LEVELS OF LEMMA SD FOR THE HISTORY TERMS. E(□₀, ·) is holomorphic in the field A on the sup-norm ball (I.3.31) of radius α₂;
expand it multilinearly IN THE FIELD first (polarization e per factor), then each field factor, read at its point x ∈ □₀, by Lemma SD
in the operators. A factor read at a point x of □₀ within L₀/2 + r′ of the outside of □₀ meets, besides the far cubes paid by its walks'
lengths (Lemma G), one near cluster N_x; N_x contains the cube of □₀ holding x, so the common point P_x of N_x lies in □₀, and a segment
inside that cube joins the tree of □₀ to P_x: d_k(□₀ ∪ N_x) ≤ d_k(□₀) + 2 (§3.4 companion, √4 = 2). With Ψ := d_k(□₀ ∪ ·) − d_k(□₀)
(§3.6 (a)) each boundary factor carries e^{2a₁}, each walk only w(ω). Hence the operator ball is R = e(1+η)²B₀ for EVERY functional,
(R) reads 4C₂Rε₂ ≤ 1, 4C₄R²ε₃ ≤ 1, 2Rε₃ ≤ ε₂ — Bałaban's (1.13)–(1.16) with B₀e^{16κ₁} → e(1+η)²B₀ and nothing else — and the near
boundary enters ONLY the field-domain condition, linearly:
   (D)_corr   16 e^{1+2a₁} R C₁ ε₁ ≤ α₂,   3(R/B₀)C₁ε₁ ≤ a₁(of (1.40)).
In Lemma RD (i), C₁^{RD} carries e^{2a₁}·e (from the field polarization) in place of R₁/B₀'s e^{2^d a}. Lemma RD (i)–(vi) otherwise as
stated. THE ROW (D)_corr with (2.31): log β ≥ 2(2a₁ + 1 + ln 16 + ln(RC₁/α₂)) + ln(80κ/γ₂): at κ = 1, L = 3 (a₁ → 14/15),
2(1.867 + 3.773) + 4.382 = 15.66 → 6.80 decades; at Lemma KP's floor κ = 13.533 (L = 3), 2(25.26 + 3.773) + 6.987 = 65.05 → 28.25 decades
(hand arithmetic, P-type constants at 1) — below every other row.
(3) M6's FALSIFIER, RESTATED WITH THE CORRECTION. The fixed points D, A₀, H_k are used holomorphically on the operator ball of radius
e(1+η)²B₀ — off the real segment by the polarization constant e(1+η)² only, a radius independent of every κ.

## 17. DATED POINTER (2026-11-02): §6 (R)/(D), §7.3 and the §12 row "met only at the operator-ball radius e(1+η)², e^{2^d a}" are SUPERSEDED BY §16: the operator ball is R = e(1+η)²B₀ for every functional (no R₁); the near-boundary weight is e^{2a₁}, once per boundary field factor, in (D)_corr only. Theorem F (§8) is forced on the PRINTED/DERIVED chain (the term's own bound at Y = □₀, (α₁/α₃)⁵ inside O(M^q) as p. 8 places it), not proved as a lower bound on the term's true size; a quantitative α–M link could move it into M (worsening T17/T18). Lemma F is a lower bound on a growth rate (a necessary condition on the printed step), not a value of Bałaban's O(1).
