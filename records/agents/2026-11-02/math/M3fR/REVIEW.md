# M3fR — SECOND READING OF M3f/WORK.md (§§0–17, record rec/tree_run.2026-11-02a.txt)

Second reader M3fR, 2026-11-02. Work directory `.../scratchpad/math/M3fR/`. Read-only everywhere else. Appended as the work
proceeds; a section is not edited after it is written except by a dated correction below it. Labels: READ (on the rendered page,
today, by this reader), CHECKED (re-derived here), HOLDS / HOLDS WITH REPAIR / HOLE (with the step quoted and the counterexample or the
missing estimate).

## 0. Read before any verdict

- M3f/WORK.md §§0–17 whole (616 lines). Record `rec/tree_run.2026-11-02a.txt`: SHA-256 01f72e45f0432948daf1…, script `bin/m3f_tree.py`
  5c879ca6a64ac48c… — both equal the prefixes M3f cites.
- M3/WORK.md §§0–9 (Theorem 2, Lemmas A′–D, (B-i)–(B-v), §6, §7 (E0)–(E3)).
- M3d/WORK.md §§0–9.6 whole (PI-4, Lemmas 1–3, PI-5, SH, Σ₁ frozen part, E1-a, S₁ status, Lemma M_c).
- M3dR/REVIEW.md whole (the coordinator's pointer: 5.7, the boundary-layer cross term; 5.10, PI-5's repairs; 5.13 the a priori disc).
- (Further sources are added below where they are read.)

## 1. THE COORDINATOR'S QUESTION FIRST — DOES M3f NEED PI-4 AT LARGE COMPLEX d? (answered 2026-11-02, before the item verdicts)

M3dR 5.7: in the complete model the small-field step on Λ_{k+1} (site T2) and LFR I (1.60)'s boundary-layer integrals (site R1) carry the
D-term's cross term −2d𝒲(A, A_k) with the layer field A_k of scaled size up to C₁p₁(g_k); for Im d ≠ 0 nothing controls it; Theorem
PI-4 holds for REAL d (Bałaban's real shift) and for complex |d_j| ≤ r_j := c·ε_*/(C_W C₁ p₁(g_j)) (M3dR's sufficient repair).

Where complex d enters M3f (every site found on a whole reading):

| M3f step | complex d used | size | in M3dR's repaired regime? | verdict |
|---|---|---|---|---|
| §3.2 (ROB)(i), (iv) | the D-term in the step's potential "in 𝒱(2E₀C₁ε₁) ⊂ 𝒱(ε_*)"; "d enters Lemma 2 only through |d| ≤ θ₀" | |d| ≤ θ₀ complex | NO: (ROB)(i) omits the layer cross term — it inherits M3d 9.2's hole (Lemma M_c's cone claim at T2/R1) | (ROB) must be restricted to real d plus |Im d| ≤ r_k |
| §3.3 Lemma RL (segment 𝔞_ζ, |ζ| < 1/η) | d_ζ = d + ζδd, ζ complex | |Im d_ζ| up to θ₀ (and |d_ζ| up to 3θ₀/2, see §3 below) | NO, whenever δd ≠ 0 | as stated, uses the refuted regime; history-only segments (δd = 0, complex E, R, B data) are untouched by 5.7 (no 1/g², no layer cross term) |
| §4.2 row (E) "Cauchy in d as in PI-5 (ii)" | discs of radius θ_*/4 about |d| ≤ θ_*/4 | |d| ≤ θ_*/2 complex | NO in the complete model (E-terms produced on Λ_{k+1} beside the layer) | repair below |
| §4.2 rows (R), (B) via Lemma RL's δ_k/θ₀ terms | as Lemma RL | θ₀ | NO (R-terms come through LFR I (1.53)–(1.63), site R1) | repair below |
| §4.2 row (C) | none: CMP 109's whole-lattice small-field β (the coupling of record, M3 §11.1) | — | not affected (M3dR: whole-lattice untouched) | unaffected |
| §4.3 (iv), §5 Cor. 5.1 at real τ | real d(·) = source + tuning | real | YES (real shift) | unaffected |
| §5 Vitali in complex τ | (S₁)(iii)'s uniform bound on a complex τ-disc | M3d's disc | YES for ∇h̃ ≢ 0 (M3dR 5.7: r_τ ∝ δ_* makes |d_j|C_WC₁²p₁² ≪ 1 automatically); for ∇h̃ ≡ 0 the disc shrinks by p₁(γ)^{−2} | survives: Vitali needs only some K- and volume-independent disc |
| §6.4 (T_loc) Hadamard two-constants | complexification of the CONFIGURATION V, not of d | — | not PI-4 | unaffected |
| §6.6 two-cutoff E1 | Theorem U from j_* + Vitali | as Theorem U | relative coupling deviation at j_* is O(1)/x_{j_*} ~ 1/K ≪ r_{j_*} ~ 1/polylog K | survives with Theorem U's repair |
| §10 Lemma D (10.1–10.3, 10.5) | complex x′ on |x′ − x| < θ_G x | θ_G | in CMP 109's WHOLE-LATTICE small-field model — no external layer field | unaffected |
| §10.4 (complete model) | none beyond the whole-lattice β and P3's real shell | — | — | unaffected |
| §14.6 (b)–(c) | real couplings only (shell Lipschitz in real x′) | — | — | unaffected |

THE REPAIR FOR THEOREM U (sufficient, written here). In Theorem U complex d is only a CAUCHY DEVICE: the two densities compared are real
and their coupling deviations are real; the reference trajectory can be taken to be run a's (Corollary 5.1: the Wilson run IS Theorem 2's
reference, d^a ≡ 0), so the only real deviation is δ_j = |d^b_j|. Replace every Cauchy radius in d (θ_*/4 in row (E); θ₀ in Lemma RL's
d-row) by r_k/2. Then: row (E) reads a_{(k+1)} ≤ 16E₀δ_k/r_k + 8E₀C₁ε₁E₀H_k/ε_*; rows (R), (B) carry δ_k/r_k in place of δ_k/θ₀; the
source term of Theorem U (ii) becomes C·Σ_i q^{k−1−i}p₁(g_i)δ_i·(C_WC₁/ε_*). The loop δ → H → δ still closes: by (i), δ_j ≲
Σ_{i≥j}(g_i² + ε₁g_i)g_i²H_i, so the loop gain is ≲ Σ_j(g_j² + ε₁g_j)g_j²p₁(g_j)/(1 − q), finite and → 0 as γ → 0 (g_j³ beats any polylog;
D4b (E4) with the polylog inserted). In (iii) the R- and B-rows' δ_j p₁(g_j) is multiplied by e^{−p₀(g_j)} (directly, or through (B-SUP)),
which absorbs every polylog. TWO CONDITIONS THE REPAIR NEEDS, neither on M3f's page: (a) δ_j ≤ r_j/2 at every scale (so the discs of
radius r_j/2 about d^b_j lie in |d| ≤ r_j). Once Theorem U's bounds hold, δ_j is second order (≲ Σ_{i≥j}(g_i² + ε₁g_i)g_i²H_i with H_i ≤
q^{i−k₀}H_{k₀} + …), far inside r_j ~ 1/polylog(1/g_j); before they hold, a bootstrap is needed — e.g. continuity in s of the tuned family
ρ₀^{(s)} = exp(−x₀A + sE₀^b), s ∈ [0, 1], starting from δ ≡ 0 at s = 0 and using the uniqueness of the tuned coupling (14.6 (c)); (b) the
IVT tuning of run b at step k₀ uses real couplings in Theorem 2's a priori window (real d up to θ₀/2): covered by M3dR's real-d clause.
WITHOUT the base point at d = 0 (a reference trajectory far from both runs) the repair needs PI-4 on complex discs of radius r about a LARGE
real d₀ — Bałaban's real shift at the base point d₀ with the residual −2(d − d₀)𝒲(A, A_k) in the cone — plausible, on no page.

PER-STEP ANSWER TO THE COORDINATOR. Lemma RL as stated needs large complex d (whenever the coupling profiles differ); Theorem U as stated
needs it (rows (E), (R), (B)); neither NEEDS it in substance — every use is a Cauchy estimate about real, small deviations, and the repair
above moves all of them into M3dR's regime at the price of a polylog factor p₁(g_k) on the δ-coefficients, absorbed by Σg³p₁ < ∞ and
e^{−p₀}. Corollary 5.1 survives (real τ for Theorem U; Vitali on M3dR's surviving τ-disc). The two-cutoff E1 survives on the same terms.
Lemma D is whole-lattice and unaffected.

## 2. FURTHER SOURCES READ (after §1)

M3/WORK.md §§10–11 (the coupling of record is CMP 109's small-field β, 11.1); M3R/REVIEW.md items 2c, 2e; M3c §§2, 5–9 (Lemma M,
BB4*-D, θ_*, Lemma W, Lemma FP (FP1)–(FP4), C′, one-step (PI)_H, (PI-1)–(PI-5)); M3cR/REVIEW.md items (1)–(8) and §3; M3b §§5, 6.1–6.4,
10, 15.1–15.4; M3e handback. ON IMAGE (M3d's 130-dpi renders, M3f's own p. 254): LFR I pp. 176–177; LFR II pp. 356, 388, 390; CMP 119
pp. 254, 255, 257–264.

## 3. ITEM 1 — WHAT R PRESERVES (M3f §2, 4.5 (a)) — HOLDS

READ: LFR I (0.3): (Rρ)(V) = Σ_Z ρ(Z″,V)·∫dV|_{Z′}ρ(Z,V)/∫dV|_{Z′}ρ(Z″,V); (0.4) ∫dV(Rρ) = ∫dVρ; p. 176 "a large field expression is
replaced by the corresponding small field expression in such a way, that integrals of the densities are unchanged"; p. 177 the
denominators localized. LFR II (1.1), p. 356: the renormalized term is χ_kχ_{k,Λ}δ_{G₀}(V′_k)χ·exp[−g_k^{−2}A(ζ₀,U_{k,Z}(V′_kV_Λ))]·
[χ_{h,1/2}∫dV′Γ_{B₀}δ_{T₀}(V′)χ′exp A″_k]/[∫dV′Γ_Λδ_{G₀}(V′)χ exp[−g_k^{−2}A(ζ₀,U_{k,Z}(V′V_Λ))]] — the current variables V′_k on Λ carry the
normalized small-field Wilson weight, the old dependence is integrated out (dummy V′). CMP 119 p. 254: "The k-th density ρ_k(V_k) is a
function of the new field V_k". CHECKED: for F reading only V outside Λ the termwise identity of 2.3 holds; for F reading V on Λ the
conditional law is replaced. So (a) the integral and the termwise marginal off Λ are preserved, the density is not; (b) ρ_K/∫ρ_K is
not the law of Q^KU (the true conditional law of V_k|_Λ under a large-field term is not the normalized small-field Wilson weight);
(c) a coarse insertion F∘Q^{K−k} commutes with T, not with R, so observables must ride as sources (M3's (S), M3b's (S₁)); (d) M3's
(E0) non-degeneracy read CMP 119 (2.50) — a bound on ρ_K — as a bound on the blocked law: the withdrawal "as stated" is right; the
compactness half stands. The caution about Hypotheses I–II (stated for the true λ_j) is right and load-bearing for the crossover.
Precision (not a defect): 2.3's "termwise marginal on (Z′)^c" is for the idealized (0.3); M3f's 4.5 (a) gives the actual form (Λ ⊃ Z′,
exact by the one-weight identity).

## 4. ITEM 2 — LEMMA RL (M3f §3.3) AND (ROB) (§3.2) — HOLDS WITH REPAIR (three repairs); (ROB) a genuine input, stronger than Bałaban states

THE SCHWARZ STEP IS RIGHT: an analytic g_X on |ζ| < 1/η with |g_X| ≤ 2c_ROB b_X and g_X(0) = 0 obeys |g_X(1)| ≤ 2c_ROB b_X η (η < 1;
η = 1 by continuity), pointwise in the configuration, then sup. The domain sequences are ζ-independent by the device. CHECKED.
REPAIR 1 (normalization). The class has |d| ≤ θ₀/2, 𝒟^{(2)} has |d| ≤ θ₀, the norm's d-row is sup|δd|/θ₀. For |ζ| ≤ 1/η:
|d + ζδd| ≤ θ₀/2 + θ₀ = 3θ₀/2 ∉ 𝒟^{(2)} (counterexample: d ≡ θ₀/2, δd ≡ ηθ₀, ζ = 1/η). Normalize the d-row by θ₀/2 (or use a tripled
class); the E-, R-, B-rows are consistent as written (|ζδE| ≤ E₀e^{−κd}, total 2E₀e^{−κd}).
REPAIR 2 (complex d, §1 above). The segment makes Im d_ζ of size θ₀; (ROB)'s justification (i) ("doubled history bounds put the
potential in 𝒱(2E₀C₁ε₁) ⊂ 𝒱(ε_*)") omits the D-term and its layer cross term (M3dR 5.7), and (iv) ("d enters Lemma 2 only") omits sites
T2, R1. Normalize the d-row by r_k = cε_*/(C_WC₁p₁(g_k)) (and keep the base d within r_k, or use real d). History-only segments are
untouched.
REPAIR 3 (the weighted form used downstream). Lemma RL is proved in the SUP norm η. Theorem U 4.2 (R), (B) apply it "on the segment with
the weighted norm" H_k (old terms weighted L^{−(k−m)}). A weighted ball does not keep the segment in 𝒟^{(2)}: H_k ≤ η allows an old
difference a_{(m)} up to 2E₀ηL^{k−m}, and ζ = 1/η then moves that datum by up to 2E₀L^{k−m} ≫ 2E₀. So the weighted Lipschitz bound is not a
consequence of Lemma RL. What is needed is a per-scale statement: the output's derivative in the scale-m datum carries L^{−(k−m)} (a
polydisc Cauchy estimate, one parameter per scale, with the gain supplied by (W)). (W) is proved (3.4) for the SMALL-FIELD fluctuation
extraction (CMP 116 (1.22)–(1.24), READ by M3dR: the scale-j history enters step k with weight (6L)⁴L^{−(k−j)}). For the R_D activities
M3f asserts (4.2's proof) that "the input's terms enter the T′-integrals' exponent with the weight (W) and no factor ε₁". That is not
proved: (1.24)'s (L^jη)⁵ is a gradient-expansion gain in a SMALL scale-k fluctuation, and the R-operation integrates "all field
variables" on Λ (LFR I (1.73)), large-field configurations included. MISSING ESTIMATE: |∂R′^{(k)}(X)/∂(scale-m datum)| ≤
C e^{−p₀(g_k)}(L^{m−k})^{β″}·(datum's bound) on the R-region (CMP 119 (2.43)'s irrelevance read on the configurations R integrates).
CONSEQUENCE IF IT FAILS: the R-row reads r_{(k+1)} ≲ e^{−p₀(g_k)}·sup_{m≤k}a_{(m)}/E₀, and since old E-differences are fixed functions (their
sup does not decay — only their weighted norm does), Σ_k r_{(k)} is dominated by k near K and stays ≍ e^{−p₀(γ)}·sup_m a_{(m)}/E₀: Corollary
5.1's bound would keep a fixed small remainder instead of tending to 0.

(ROB) — GENUINE OR HIDING THE RESULT? Genuine, and it does not hide the result: Lemma RL's content (an O(1) Lipschitz constant) is exactly
(ROB)'s sup bound on a doubled complexified class plus analyticity, converted by Schwarz; the contraction Theorem U needs is NOT in it
(Remark after 3.3 says so correctly). But it is NOT "the same black box": (a) CMP 119 p. 262 (READ) — the class-to-class statement is "a
possible generalization of this theorem … This generalization does not seem to be useful, or interesting now"; M3f's §3.1 quote omits
those words. Bałaban's Theorem 1 is about the sequence generated from ρ₀ = exp[−g₀^{−2}A − E]; RT: 𝒟_k → 𝒟_{k+1} follows from his proof only
to the extent the proof uses nothing but the inductive assumptions (M3d 9.1 read them and found no positivity clause — the right check,
but not a proof that no closing condition is used at its exact value). (b) (ROB) asks more: the DOUBLED class, COMPLEX data, and
analytic dependence of every output. It is an extension of [BB-c] of the kind PI-4 is, and it inherits PI-4's hole at complex d.

## 5. ITEM 3 — THEOREM U (§4, 4.5 (b)) AND COROLLARY 5.1 (§5) — HOLD WITH REPAIRS, GIVEN THE INPUTS AND ONE NAMED MISSING ESTIMATE

(a) ROW (C) — PRECISION. δ_j is a RELATIVE deviation (d = Δx/x). Then δ_{k+1} = δ_k·x_k/x_{k+1} − δβ/x_{k+1} and x_k/x_{k+1} = 1 + β_{k+1}g²_{k+1}:
the literal two-sided |δ_{k+1} − δ_k| ≤ C′g_k³δ_k + … is FALSE (it omits ≈ c g²δ_k; relative deviations grow forward by x_k/x_K). The use
is BACKWARD, where the omitted term has the favourable sign: δ_k = δ_{k+1}x_{k+1}/x_k + δβ/x_k, so |δ_k| ≤ Σ_{j≥k}[C′g_j³δ_j +
C(g_j² + ε₁g_j)g_j²H_j] from δ_K = 0. (i) HOLDS as stated. CHECKED.
(b) THE B-ROW AND (2.47) — MISREADING, REPAIRED. READ CMP 119 p. 264: "The remaining factor exp(−d_j(X)) is used to get an additional
small factor, e.g. for j > n it can be bounded by 2^{−(j−1−n)}. Thus … |B^{(j,n)}| ≤ B₁2^{−(j−n)}|Γ_n| for j > n": B^{(j,n)} is the part of
the scale-j boundary term lying in the OLDER shell Γ_n (n < j), and the 2^{−(j−n)} is SPATIAL (its domain must reach from Ω_j out to Γ_n).
It is not a decay with age. B-terms are carried unchanged until their region is renormalized (then LFR II p. 390, READ: domains
disjoint from the remaining large-field region become R-terms ≤ e^{−p₀(g_k)}e^{−κd} (1.100); domains meeting it become NEW boundary terms
with only O(1)c₁, c₁ = α^{1/3} (1.99)). So B_k := Σb_{(m)}2^{−(k−m)}, row (B)'s "age" clause and (iii)'s Σb_{(m)}2^{−(K−m)} have no source.
REPAIR: a B-difference does not decay; it reaches outputs and integrals only through (B-SUP) (which M3f names in 4.5 (b)) and through the
eventual renormalization of its region (every region shrinks by L^{−1} per step in current units and enters a 100MR_k cube, LFR I
p. 177, then is renormalized after N quiet steps). At the unit scale the live B-terms belong to regions created in the last N + O(log)
steps (or to rare huge ones), whose differences are ≲ δ + H at those steps — still → 0 as K → ∞, by the decay of H, not by (2.47).
(c) (iv) — PRECISION. "|δA_k^σ| ≤ CN_Tη_K pointwise" fails for terms σ with deep shells: (2.43), (2.44), (2.48) bound E-, R-, B-terms by
Σ_n|Γ_n| (each shell counted in its own scale's units), which can exceed N_T. Correct form: |δA_k^σ| ≤ Cη_K·Σ_n|Γ_n|, absorbed into the
large-field suppression exactly as Bałaban absorbs O(1)Σ|Γ_j| in (2.49)→(2.50) (READ p. 264); then |log∫ρ^b − log∫ρ^a| ≤ CN_Tη_K for
η_K small. The positivity step (real data, T^σ a positive operation, R_D denominators positive) is right.
(d) THE R-ROW — THE NAMED MISSING ESTIMATE of item 2, REPAIR 3 (the weighted dependence of R_D's activities on old history inside a
renormalized region). Route (not on the page): the old terms living in a large-field region are evaluated at the background frozen at
the region's creation scale n (the determining set uses V_n on Γ_n, CMP 119 (2.2), (2.13)–(2.16)), regular at that scale, which would
give (L^{m−n})^β by (2.43); for regions alive near the unit scale n ≥ K − N − O(log), so deep differences enter with L^{−β(n−m)} → 0.
Without it the R-row keeps e^{−p₀(γ)}·sup_m a_{(m)}/E₀ and Corollary 5.1's bound does not tend to 0.
(e) THE PI-4 REPAIR (§1): rows (E), (R), (B) with Cauchy radius r_k; the loop closes by Σ(g² + ε₁g)g²p₁(g) < ∞.
(f) THE CLASS. Theorem U runs RT on densities not generated from exp[−g₀^{−2}A − E] (Corollary 5.1: exp(−x₀A + E₀^b)); Bałaban's p. 262
calls the class-to-class map a possible generalization he does not pursue. It holds to the extent his proof uses only the inductive
assumptions; E₀^b must be global and bounded (a bare action), with its dimension-four part tuned into the coupling (§17's precision) and
its constant cancelling in log Z(τ) − log Z(0).
(g) COROLLARY 5.1 / VITALI — HOLDS given the above: f_K := W^b_K − W^a_K is analytic and bounded uniformly in K on a K- and volume-
independent complex τ-disc (M3d §4.4, with M3dR 5.15: M3d's disc when ∇h̃ ≢ 0, shrunk by p₁(γ)^{−2} when ∇h̃ ≡ 0), and f_K → 0 on a real
interval, so f_K → 0 uniformly on compacta with every derivative; mixed separated-point cumulants need h̃ = Στ_ih̃_i (several variables,
or polarization) — as (S₁)(iii) is stated. §14.6 (b)'s deletion of the additive Σt_j is what makes the bound tend to 0 (CHECKED, item 5).

## 6. ITEM 4 — THE TWO-CUTOFF E1 (§6, 14.5) — LEMMA 6.2 HOLDS WITH REPAIR; 6.3 HOLDS GIVEN (Δ-i) ENLARGED; 6.6 CONDITIONAL AS LABELLED

LEMMA 6.2 — CHECKED both inequalities, and they are the right minimisers. With S_j(V) = min{A^ε(W): Q^jW = V}, S′_{m+j}(V) =
min{A^{ε′}(U): Q^{m+j}U = V} and the composition S′_{m+j}(V) = min_{Q^jW=V}S′_m(W): upper — W = U_j(V) is admissible, S′_{m+j} ≤ S′_m(U_j) =
S_j + Δ(U_j); lower — W′ = Q^mU′_{m+j}(V) satisfies Q^jW′ = V and S′_m(W′) = S′_{m+j}(V) (U′ admissible for W′, and W′ admissible in the
outer min), so S_j ≤ A^ε(W′) = S′_{m+j} − Δ(W′). Nothing else is used; no uniformity hides in the sandwich.
REPAIR. The parenthesis "Q^m maps regular configurations of T_{ε′} to regular configurations of T_ε" is FALSE: an abelian (U(1) ⊂ SU(2))
fine configuration with constant field strength α₀ per plaquette, inside the regular class, averages to coarse plaquettes of holonomy
angle ≈ L^{2m}α₀, outside it once L^{2m}α₀ > α₀ (any m ≥ 1). What the proof needs is only that W′(V) and U_j(V) are regular: true because
U′_{m+j}(V) is the minimizer (CMP 102 Theorem 1 conditions (19)–(21): fine curvature O(L^{−2(m+j)}|F_V|)). Cleaner: take global minima;
they exist by compactness and are regular for regular V (A(U) ≤ A(U_k(V)), with every plaquette term ≥ 0, forces every plaquette near 1),
so they coincide with Bałaban's unique critical orbit.
6.3 — THE SIZE. "By Lemma WI Δ has no part of dimension below six: |Δ(W)| ≤ C_ΔΣ_x(|∇F_W|² + |F_W|³)" does not follow from Lemma WI,
which controls the Taylor kernels K₂, K₃, K₄ at small momentum. A pointwise bound on regular W also needs: all orders n ≥ 5 (from
|K_n| ≤ Mⁿ in local gauges, A ~ |x||F| within the kernels' decay length), the gauge-covariant conversion of the A-polynomials of
degrees 2–4 into F-expressions, and a Schur bound for the quadratic part with its O(p⁴) kernel written as F̂ k(p) F̂, k analytic. It is the
tree-level Symanzik statement — plausible and standard in substance — and belongs INSIDE the input (Δ-i), not after "then by Lemma WI".
(Consistency check passed: at a flat W with non-trivial holonomy both sides vanish — Q^m of the flat fine connection with the same
holonomy is gauge-equivalent to W, so S′_m(W) = 0 = A^ε(W).) The scaling to L^{−2j} is right; 14.5's j^c is an overestimate for the SUM:
Σ_x|∇F_W|² needs only L² elliptic regularity of d*dA = Q*λ with Q*λ piecewise constant (‖∇²A‖₂ ≤ C‖Q*λ‖₂), so the rate is L^{−2j}
without the logarithm (the pointwise corner logarithm is square-integrable). Uniformity in m: C_Δ from (B2) for S′_m, W′'s regularity
from CMP 102's k-uniform constants — both named; no hidden uniformity.
S-T1 (§15–16) — CHECKED: hashes match; the closed form is right (d²csc² = 6csc⁴ − 4csc² applied to Σcsc²(x + πl/N) = N²csc²(Nx) gives
M3f's csc⁴ identity); G_1(π/2,0,0,0) = 19/54, G_2 = 163/486, G_∞ = 1/3 recomputed by hand and equal to the record. A scalar check, labelled.
6.4–6.6. (T_loc) and (CB) are OPEN and labelled so. The rate claim ("polynomial in 1/log ε^{−1}, any power") comes from (CB)(v)'s deep
R-terms Σ_{n≥K}(X + n(c−ρ))^{−κ₀/2} ≍ K^{1−κ₀/2} (CHECKED; needs κ₀ > 2, granted by p. 260 "κ₀ can be chosen arbitrarily large") and so is
conditional on (CB). §6.6 also inherits Theorem U's repairs (§5 (a)–(f)) and the missing estimate §5 (d). The relative coupling deviation
at j_* is O(1)/x_{j_*} ≍ 1/K (the two transients differ by O(F) absolutely), inside M3dR's regime. The complexification in (T_loc)(d) is in
the CONFIGURATION, not in d: PI-4 is not involved.

## 7. ITEM 5 — §14.6: SHELLS LIPSCHITZ; THE BARE COUPLING UNIQUE — HOLDS (with M3dR's a priori disc)

(b) CHECKED: the shell between ε_j(x′) and ε_j(x) (ε_j = g_jp₀(g_j), smooth; dε/dx = −½g³(p₀ + gp₀′)) has Gaussian mass ≤ C·polylog·
e^{−cp₀(g_j)²}·|x′ − x|/x_j per bond, times the bounded integrand — proportional to |x′ − x|, zero at equal couplings, summable. So the
additive t_j becomes w^{sh}_jδ_j inside w_j. (a) is §10.5 (CHECKED in item 6). (c) The Gronwall: with ABSOLUTE D_j = x′_j − x_j (M3d's
form), |D_{j+1} − D_j| ≤ w_jS_j, Σw_j ≤ Cγ^a, hence |D_K| ≥ |D₀|(1 − Cγ^ae^{Cγ^a}) > 0 for D₀ ≠ 0 (in relative form the running term only
helps forward). REPAIR CARRIED: the a priori disc |x′_j − x_j| ≤ θ₀x_j/2 for all j (M3dR 5.13, from Theorem 2's two-sided profile) is
needed before Lemma C′(c) applies. ADVERSARIAL CHECK, NO DEFECT: R_j is piecewise constant in g_j (CMP 119 (2.5), READ p. 255), so the
complete model's own construction jumps where (log g_j^{−2})^r crosses a power of L — not Lipschitz. It does not touch (c): the coupling
of record is CMP 109's small-field β (M3 §11.1; no R_j there), and in every comparison the device fixes R_j at the reference while the
compared quantities (partition functions) do not depend on the construction.

## 8. ITEM 6 — THE GAUGE-FIXED STAGE IDENTITY, KALLOSH–DeWITT, ALIASES, (B1), LEMMA B, LEMMA D

THEOREM 7.1 — HOLDS (exact Gaussian identity), CHECKED line by line. (1) Φ = (H_λ + L_R*L_R) + D*F_c*F_cD, the second piece constant on
fibres {Du = v}; coarea factor det(DD*)^{−1/2}; fibre Hessian positive on ker D = T ⊕ τ_f𝔯 by (h1)–(h3); det Φ = det(DD*)·det_{ker D}(·)·
det(K + F_c*F_c). (2) K = min_{Du=v}H_λ(u) because adding τ_fξ (ξ ∈ 𝔯) keeps the fibre (Dτ_f = τ_cπ vanishes on 𝔯), keeps H_λ (H_λτ_f = 0)
and can zero L_Ru (L_Rτ_f|_𝔯 invertible); S_k^G = S_k (G ≥ 0, G(U*) = 0) and the IFT on the Lagrange system of S + G give S_k″ = K.
(3) F_fτ_f is square (dim 𝔤_f = dim 𝔯 + dim 𝔤_c) and block upper-triangular on 𝔯 ⊕ 𝔨 with invertible diagonal blocks. (4) the
determinants combine; W_k^{(1)} matches the gauge-fixed constrained integral (the normalized gauge-fixing orbit integral contributes
|det L_Rτ_f|_𝔯|^{−1}). ADVERSARIAL: F_c∘D and L_R are block-local (no non-local term); at one loop no Gribov issue; a DEGENERATE background
violates (h2) — M3cR's flux background (angle 0.698, six zero modes) is such a V, and the theorem is stated only where (h1)–(h4) hold;
at V = 1, ker D ∩ ker S″(1) = τ_f𝔯 exactly (flat fields in ker D are dω with ω|_coarse constant); 14.3's torus zero modes are a correct
precision.
LEMMA 7.2 — HOLDS (CHECKED: PF* = (τ − PHτ)(Fτ)^{−1}, cyclicity; needs τ independent of t and H + F_t*F_t > 0 on the path). The off-shell
identity S″(U)(τξ, w) = −⟨S′(U), ∂_wτ(ξ)⟩ is right.
LEMMA 7.3 (with 14.2) — HOLDS GIVEN local (r1) and (r2). The ε²-coefficient is ⟨λ₂, 𝒯(1)⟩ + ⟨Δ_k(P)a, 𝒯₁[a]⟩ + O(P⁴); 𝒯(1) = 0 (no
invariant adjoint vector); 𝒯₁[a] → 0 as P → 0 by local covariance — the block-constant extension of a coarse gauge transformation
preserves the axial representative (U*(y,x) = 1 ↦ g(y)·1·g(y)^{−1}) and transforms L_R by Ad, so 14.2's covariance claim is right — and by
(r2): the massless one-loop responses are ~ P log P (M3R), continuous at 0. (r2) is a dominated-convergence sketch, not a proof.
COROLLARY 7.4 — HOLDS GIVEN the same.
§8 WITH 14.1 (ALIASES) — HOLDS. 14.1's Euler–Lagrange form is right (the slice multiplier vanishes since objective and constraint are
R-invariant); at p_l ≠ 0 the transverse amplitude is (p̂_l²)^{−1}·Q̂(p_l)*Δ_k(P)a = O(P²); Π_f transverse kills the longitudinal parts;
Π_f translation-invariant gives no cross-alias terms; finitely many l at fixed k ⇒ O(P⁴) ⇒ nothing in the fixed-k limit defining f(k).
M3R's "alias constants into (B1)'s uniform bound" are indeed not needed: f(k) = c_W − c(S_k) exactly and the k-uniform bound is (B1)+(B2).
LEMMA WI — HOLDS (W = 0): dimension-4 parts solve the continuum Ward identities (c₁trF² + c₂trF∧F; no gauge-invariant dimension 2;
dimension 3 and 5 odd, killed by −1 ∈ W(B₄)), normalization fixes c₁, reflections kill c₂, so the differences start at dimension 6 —
degrees 4, 3, 2 in momentum for K₂, K₃, K₄. CHECKED.
THEOREM B1 (with 14.4) — HOLDS GIVEN Lemma WI and the classical Π_W. CHECKED: background Feynman gauge makes Γ_S − Γ_W a difference of
gluon loops; each difference factor gains q² (|G_S − G_W| ≤ C, |V₃^S − V₃^W| = O(q³), |V₄^S − V₄^W| = O(q²)), so the Wilson P²-coefficient's
q^{−4} becomes |c₂(q)| ≤ C(1 + q^{−2}), integrable in 4D; the split at |q| = 2|P| (remainder |P|³|q|^{−3} outside, P² q^{−2} + P²|q+P|^{−2}
inside) gives o(P²); c₀ by δΠ(0) = 0, c₁ by q ↦ −q. The improvement over the record (no momentum split, no continuum integrand) is real.
LEMMA B (9.4) — HOLDS GIVEN (r1) local, (r2), (B2) [ellipticity and normalization from Addendum II §8 — not re-read by this reader;
strip analyticity: M3e PROVED GIVEN CMP 99 (3.132), which M3e's audit A1 found asserted by analogy in CMP 99, p. 422], (B0), and the
W = 0 inputs. M3R's five items: (1) closed by Theorem 7.1 + 7.2–7.4; (2) closed given Lemma WI; (3) M3e's; (4) settled (L odd, centred,
M3b 15.1 READ); (5) not needed.
LEMMA D (§10) — HOLDS GIVEN Lemma M, Lemma W with 10.2's 𝒢-analogue, and one-step (PI)_H (its β-Lipschitz line a sketch, M3cR (7)).
10.1 CHECKED against M3cR's readings: CMP 109 (2.1) carries −g_k^{−2}G(V) (the gauge weight IS the Wilson coefficient), the cutoff (2.9) is
on the physical angle, the background minimizes the unweighted action; so the own step at x′ is the reference step with (d, d), and
10.5's observation is right — the pure quadratic part is d times the whole Gaussian form on E, log-determinant −½dim E·log(1 + d),
background-independent without Lemma FP or Lemma SH (the normalizations z_α of CMP 109 (0.15) are V-independent constants). All of §10 is
in CMP 109's WHOLE-LATTICE model: unaffected by PI-4's hole (§1). Continuity in real x₀ is all (H1) needs.

## 9. THE VERDICTS

| Item | Verdict | Repair / missing estimate |
|---|---|---|
| 1. R preserves integrals and the off-Λ marginal, not the density; E1 about generating functionals; M3 (E0) withdrawn as stated | HOLDS | — (LFR I (0.3)–(0.4), LFR II (1.1) READ) |
| 2. Lemma RL | HOLDS WITH REPAIR | d-row normalized by θ₀/2 (3θ₀/2 counterexample); complex d only within r_k (PI-4 hole); proved in the SUP norm only — the weighted use in Theorem U needs a per-scale estimate |
| 2′. (ROB) | genuine, not hiding the result; NOT Bałaban's statement | p. 262's class map is "a possible generalization … not useful, or interesting now"; doubled, complexified, analytic; inherits PI-4's hole |
| 3. Theorem U | HOLDS WITH REPAIRS given its inputs + (B-SUP) | row (C) backward-only; (2.47) is spatial, not age decay — B-bookkeeping via (B-SUP) + eventual renormalization; (iv) per-shell form absorbed as in (2.49)–(2.50); PI-4 radius r_k; MISSING: R_D's dependence on old history weighted by (L^{m−n})^β inside renormalized regions |
| 3′. Corollary 5.1 (Vitali) | HOLDS given Theorem U as repaired and the missing estimate | Vitali on M3dR's surviving τ-disc; class extension to exp(−x₀A + E₀^b) |
| 4. Lemma 6.2 sandwich | HOLDS WITH REPAIR | "Q^m preserves regularity" false (constant-flux counterexample); use the minimizer's regularity or global minima |
| 4′. size L^{−2j}, uniform in m | HOLDS GIVEN (Δ-i) enlarged | the dimension-six pointwise bound is not a consequence of Lemma WI — put it in (Δ-i); 14.5's j^c unnecessary in the L² sum |
| 4″. E1 for two cutoffs, rate | CONDITIONAL as labelled | (T_loc), (CB) open; inherits item 3's repairs and missing estimate |
| 5. §14.6 shells Lipschitz, bare coupling unique | HOLDS | a priori disc (M3dR 5.13); R_j jumps checked harmless |
| 6. Theorem 7.1 | HOLDS | — |
| 6. Lemma 7.2 | HOLDS | — |
| 6. Lemma 7.3 / Cor. 7.4 | HOLDS GIVEN local (r1), (r2) | (r2) a sketch |
| 6. aliases §8 + 14.1 | HOLDS | — |
| 6. Lemma WI, Theorem B1 | HOLD (B1 given WI and Π_W, W = 0) | — |
| 6. Lemma B | HOLDS GIVEN (r1)–(r2), (B2) [strip analyticity ⇐ CMP 99 (3.132), M3e], (B0), W = 0 | — |
| 6. Lemma D | HOLDS GIVEN Lemmas M, W, (PI)_H | whole-lattice: untouched by PI-4 |

THE NEXT OBJECT (for M3f's line). The weighted history estimate for R_D: on a renormalized region Λ at step k, |∂R′^{(k)}(X)/∂(scale-m datum)|
≤ Ce^{−p₀(g_k)}(L^{m−n})^{β}·(datum's bound), n the region's creation scale — via the frozen background of the determining set and
CMP 119 (2.43). With it, Theorem U and Corollary 5.1 close as M3f states (after the repairs above); without it, Corollary 5.1 keeps a
fixed remainder of size e^{−p₀(γ)}.

## 9′. DATED LABEL CORRECTION TO §9 (2026-11-02, after §9; §9 not edited)

In the task's three labels, two conclusions as WRITTEN do not follow:
- HOLE (missing estimate): Theorem U rows (R), (B) and through them Corollary 5.1's "tends to 0". The step quoted: "the input's terms enter
  the T′-integrals' exponent with the weight (W) and no factor ε₁" (4.2's proof) — asserted; Lemma RL is sup-norm only. If false, the bound
  keeps ≍ e^{−p₀(γ)}·sup_m a_{(m)}/E₀. LIKELY A READING TASK, NOT A DOUBTFUL ESTIMATE: a renormalized region of size 100MR_k contains
  L^{4(k−m)}(100MR_k)⁴ scale-m polymers, so if old terms entered R's activities unweighted, Bałaban's own bound (1.100) on R′^{(k)} would fail;
  the weighting must be on LFR II §1's pages (the frozen background at the region's creation scale with CMP 119 (2.43)). Read it there first.
- HOLE AS STATED, HOLDS WITH REPAIR: Lemma RL and Theorem U rows (E), (R), (B) at complex |d| ~ θ₀ — M3dR 5.7's counterexample (d = iθ_*/2,
  |A_k| = ½C₁p₁) applies; the repair is §1's radius r_k with its p₁(g_k) cost and the δ_j ≤ r_j/2 bootstrap, which M3f does not write.
Every other row of §9 stands as labelled.
