# M3dR — SECOND READING OF M3d/WORK.md ((PI-4) the large-field steps at a complex Wilson coefficient; (PI-5) the history propagation; the consequences)

Second reader M3dR, 2026-11-02. Work directory `.../scratchpad/math/M3dR/`. Read-only everywhere else. Appended as the work
proceeds; a section written before a check is not edited after it; results go below. Labels: READ (on the rendered page, today,
by this reader), CHECKED (re-derived here), HOLE / REPAIR (with the step quoted).

## 0. What was read before any verdict

- M3d/WORK.md §§0–9.6, whole (572 lines).
- M3cR/REVIEW.md whole (the second reading of M3c, on which M3d stands: Lemma M HOLDS (global (d)); BB4* HOLDS with the margin
  ε₁ ≤ ε₁^max/8; moment form HOLDS WITH REPAIR; Lemma W CONDITIONAL on [13]; Lemma FP HOLDS; variation part of Σ₁ HOLDS WITH REPAIR
  (local Lemma M (d)); C′(d) CONDITIONAL on the shell).
- M3b/WORK.md §§5, 6.1–6.5, 8, 10, 15 (the statement (S₁), Lemma C′, Lemma Σ₁, (PI), E1-a/b).
- M3c/WORK.md §§2, 3, 5, 7, 8, 9 (Lemma M, BB4*, Lemma W, BB4*-D with θ_*, Lemma C′, one-step (PI)_H, (PI-4)/(PI-5) as NAMED).
- Primary texts: the PDFs of record in `C:\Users\Edwin Boston\Downloads\` (M3b §0's census): LFR I = `Download (2).pdf`, LFR II =
  `Download (4).pdf`, CMP 119 = `Download (6).pdf`, CMP 116 = `Download (3).pdf`, CMP 109 = `Download (1).pdf`; page images: M3d's
  130-dpi renders `M3d/render/lfr1_*.png`, `lfr2_*.png`, `cmp119_*.png`; M3c's `cmp116_*.png`; text layer `M3b/src/*.txt` (OCR, prose
  only; formulas read on image).

## 1. THE PLAN (before reading Bałaban's pages for the verdicts)

The items and the adversarial test for each:
 (A) R_D and Lemma 2 (the complex denominator): is the normalization still an identity; does the contour rotation hold (definition
     of M_d, the norm in which M_d − I is small, the side surface, the tail); are (A), (B) conditions of Bałaban's order.
 (B) The claim that every 1/g² site of the large-field steps is (K1) exact cancellation, (K4) G-valued with small complexified
     corrections, or (K5) a sum of nonnegative per-plaquette terms: census of LFR I, LFR II §1 and CMP 119 §3 on image.
 (C) R5: the T′-bounds at complex D through T′_{k,Re}. Test: does Bałaban's proof of (1.79)–(1.89) use an UPPER bound on the
     coefficients or a NORMALIZED Gaussian whose normalization moves when the coefficient is lowered to (1 − θ₀/2)× (an entropy
     factor (1 − θ₀/2)^{−n/2} per fluctuation variable, extensive in the region)? Is that factor absorbed by the suppression?
 (D) The claim that LFR II's lower bound (1.74)–(1.75) enters only (1.103)–(1.104).
 (E) Lemma 3 / the τ-disc: is r_τ independent of K and volume (the L^{k−K}δ_*(g_k)^{−1} sum; the R_k factor of 9.3 (c)).
 (F) PI-5: the recursion N_{k+1} ≤ qN_k + b_k — is a_{(k+1)} really bounded by the Schwarz argument with the stated constants; is the
     contraction factor L^{−1} per step justified by CMP 116 (1.24)'s (L^jη)⁵ weight; does the norm N_k (a weighted sum of a_{(m)}) control
     what the next step consumes; any marginal remnant (the falsifier).
 (G) The consequences: Σ₁ whole, SH, E1-a, E1-b, S₁(i)–(iv).

## 2. STAKE FOR A TOY CHECK OF LEMMA 2 (iv) (written before `bin/lemma2_toy.py` exists; not edited after the run)

COMPUTED-only (double precision, a structural toy, not a proof). Q₀ a random SPD n×n matrix (n = 60, condition number ~1e4) written as
Q₀ = Σ_p w_p w_pᵀ (rank-one plaquette pieces); Q_d := Σ_p (1 + d(p)) w_p w_pᵀ, K := Q₀^{−1/2}(Q_d − Q₀)Q₀^{−1/2}; θ₀ = 1/4, |d(p)| ≤ θ₀/2.
Two choices of the rotation: M3d's M^B := Q_d^{−1/2}Q₀^{1/2} (principal roots); the alternative M^A := Q₀^{−1/2}(I + K)^{−1/2}Q₀^{1/2}.
The path condition of Lemma 2 (iv) is λ_min(Re S_t) ≥ ¼ for S_t := (I + tẼ)ᵀ(I + K)(I + tẼ), Ẽ := Q₀^{1/2}(M − I)Q₀^{−1/2}, t ∈ [0, 1].
 S-1: both M satisfy MᵀQ_dM = Q₀ to relative 1e-9.
 S-2 (d(p) i.i.d. in the disc, NOT nearly constant): for M^A, ‖Ẽ‖ ≤ 0.08 and min_t λ_min(Re S_t) ≥ 0.6. For M^B: UNGUESSED; I expect ‖Ẽ‖ may be
      large (non-normality of Q₀^{1/2}Q_d^{−1/2} against an ill-conditioned Q₀) and the path condition may fail.
 S-3 (d(p) = d_Λ + δ(p), |δ| ≤ 1e-3, d_Λ = 0.1i): both M give ‖Ẽ‖ ≤ 0.08 and min_t λ_min(Re S_t) ≥ 0.6.
Kill condition for the reading: if M^A fails S-2, Lemma 2 (iv) needs more than ‖K‖ ≤ θ₀/2 + O(δ_*).

## 3. RESULTS OF THE TOY CHECK (records `lemma2_toy_run.2026-11-02a.txt` seed 1, `...b.txt` seed 2, rc = 0; §2 not edited)

cond(Q₀) = 1.0e4, n = 60, 240 rank-one pieces.
| case | ‖K‖ | M^B (M3d): ‖Ẽ‖ rel. / ‖M − I‖ plain / min_t λ_min(Re S_t) | M^A (alt): same |
|---|---|---|---|
| S-2 iid disc (seed 1 / 2) | 0.081 / 0.080 | 0.059 / 0.059 / 0.941 ; 0.057 / 0.057 / 0.945 | 0.041 / 1.10 / 0.941 ; 0.040 / 1.10 / 0.945 |
| S-2′ ±iθ₀/2 random signs | 0.105 / 0.109 | 0.076 / 0.076 / 1.000 ; 0.082 / 0.082 / 1.000 | 0.052 / 1.49 / 1.000 ; 0.054 / 1.65 / 1.000 |
| S-3 nearly constant | 0.100 / 0.100 | 0.050 / 0.050 / 0.9995 | 0.050 / 0.054 / 0.9995 |
S-1 HELD (MᵀQ_dM = Q₀ to 3e-14). S-2 HELD for M^A. MY EXPECTATION FOR M^B WAS WRONG: M3d's rotation is small in BOTH norms (an identity:
Ẽ = Q₀^{1/2}Q_d^{−1/2} − I = (M^B − I)ᵀ, so ‖Ẽ‖ = ‖M^B − I‖), while my alternative is small only relatively (plain norm 1.1–1.6, which would
force a larger analyticity domain for F̃). M3d's choice is the right one. S-3 HELD. Kill condition not met.
For a PROOF of ‖M^B − I‖ ≤ O(θ₀) the resolvent formula Ẽ = −(2/π)∫₀^∞(I + K + s²Q₀^{−1})^{−1}K(I + s²Q₀^{−1})^{−1}Q₀^{−1/2}ds gives only
‖Ẽ‖ ≤ (‖K‖/(1 − ‖K‖))(1 + O(log cond Q₀)) in general (cond Q₀ ~ 10^{10}M⁵ here) — but under Lemma 2's own hypothesis (d within δ_* of
d_Λ on supp ζ₀) one has K = d_Λ I + K′, ‖K′‖ ≤ O(δ_* + e^{−R_k}/c_Λ), hence M^B = (1 + d_Λ)^{−1/2}I + O((δ_* + e^{−R_k}/c_Λ)log(λ_max/c_Λ)):
small in both norms. That is the line Lemma 2 (iv) should carry.

## 4. PAGES READ ON IMAGE BY THIS READER (M3d's 130-dpi renders; M3c's for CMP 116)

LFR II pp. 356–392 every page (the R-operation's Wilson terms (1.1)–(1.48), localization (1.49)–(1.70), the T′-operation and its bounds
(1.71)–(1.89), exponentiation (1.90)–(1.102), the alternative representation (1.103)–(1.104), p. 392). LFR I pp. 176, 177, 187–189,
192–195, 199–201 (the R definition (0.3)–(0.6); the preparatory integrals (1.53)–(1.63) with the coupling difference in the interaction;
(1.70)–(1.80); Proposition 1; (1.99)–(1.102)). CMP 119 pp. 255, 259–261, 265–268, 270–284 ((2.4)–(2.42); (3.2)–(3.3), (3.15)–(3.16),
(3.23)–(3.29), (3.30)–(3.47), the proof of Theorem 2 (3.48)–(3.72)). CMP 116 pp. 7–8 ((1.21)–(1.29)). Text layer `M3b/src/*.txt` grepped
for every use of positivity / lower bound / normalization / probabilistic measure in LFR I, LFR II, CMP 119.

## 5. VERDICTS, ITEM BY ITEM

### 5.1 R_D AND ITS NECESSITY (M3d §2.1) — HOLDS
READ: LFR I (1.100) and LFR II (1.1), (1.10), (1.32), (1.37): the new Wilson factor and its denominator carry one weight; the normalization
(1.102) is the identity ∫dV′[factor]/[denominator] = 1 for any weight with nonzero denominator. U₀ = U_{k,Z}(V_Λ) minimizes the UNWEIGHTED
A (LFR I Proposition 1, p. 194), so (K1) cancels exactly once numerator and denominator carry the same D on supp ζ₀ (the numerator's
x″ + D″ splits as (x_k + D) + (x″ − x_k) + (D″ − D), the last two of coefficient O(N) resp. ≤ Ng^{2+a}θ₀x_k, small, LFR II p. 366).
Necessity: with a reference denominator the leftover −A(Dζ₀,U₀) is of size θ₀(100MR_k)⁴M^{10}A₀²p₀² against exp(−2(1+β₀)^{−1}p₀) —
p₀² against p₀, not absorbed, AS LONG AS |d| IS NOT POLYLOG-SMALL. PRECISION: on M3d's own (S₁) disc with ∇h̃ ≢ 0, |τ| ≤ r_τ ∝ δ_*(γ,M)
forces |d_k| ≤ c₃δ_*(γ,M)‖h̃‖X/(M‖∇h̃‖x_k), and the leftover is then ≲ M^{−1}(‖h̃‖/‖∇h̃‖)/P(γ) ≪ 1: there the reference R would do.
R_D is necessary only for |d| ≳ 1/polylog (e.g. ∇h̃ ≡ 0).

### 5.2 LEMMA 1 — HOLDS (Re c(p) ≥ (1 − θ₀/2)x″(p) uses x″ ≥ x_k: asymptotic freedom, 1/g″² − 1/g² = O(k − j) ≥ 0, LFR II p. 364).

### 5.3 LEMMA 2 (the R_D denominator) — HOLDS WITH A PRECISION
(1.2) READ; (1.4)–(1.6) (criticality kills the constant-weight linear term up to e^{−R_k}); (1.7)–(1.9) (Q₀ ≥ γ₀/(2d(100M)⁵));
(1.10)–(1.11) (Bałaban's own complexified denominator, |I(U₀)| < O(1)log M|Λ|). The contour rotation is legitimate (holomorphic n-form
on the swept (n+1)-chain; side surface and tail as written, 9.4 adds the area factor). PRECISION: "‖M_d − I‖ ≤ O(θ₀)" is asserted, not
proved; the general resolvent bound carries a factor log cond(Q₀) ~ log(10^{10}M⁵); under the lemma's own hypothesis (variation ≤ δ_*)
K = d_Λ I + O(δ_* + e^{−R_k}/c_Λ) and M_d = (1+d_Λ)^{−1/2}I + O((δ_* + e^{−R_k}/c_Λ)·log(λ_max/c_Λ)), small in both norms. §3: the toy
confirms M3d's M_d = Q_d^{−1/2}Q₀^{1/2} is small in BOTH norms even without near-constancy (‖M − I‖ ≈ 0.75‖K‖; my alternative was not).
(A), (B) are "γ small depending on M" (2.3′, 9.4). |Θ_d| ≤ (θ₀+θ₀²)n, |I′_d| ≤ 2 log 2: CHECKED. Θ_d, I′_d belong to the component terms of
(1.69) (O(1)Σ|Γ⁰_j∩Y|), beaten by p₀²: CHECKED (LFR II pp. 377, 380).

### 5.4 THE THREE-CASE CENSUS OF 1/g² SITES (brief item (i)) — HOLDS, with a fourth case and K3 made explicit
Every 1/g² site of the R-operation READ is: (K1) exact cancellation (1.10)/(1.32); (K4) G-valued Wilson action (1.46)–(1.48), its
complexified corrections bounded INCLUDING the 1/g″² ((1.47): ≤ O(1)A₀C₁B₃³B₅M^{10}p₀q₁R_k⁷L^{−N}); (K5) the per-plaquette nonnegative
form (1.21), "bounded by 0" (p. 361) and bounded below in (1.77) — both survive weights (1+d(p))ζ(p) with Re ≥ 1 − θ₀/2 at real B and
real background (complexified background: the first-order term in A′, J goes to σ, p. 379); FOURTH: small terms that already include the
1/g² in their modulus bound ((1.17), (1.24), (1.31), (1.47); p. 360 "small even after dividing by g_k²") — complex in Bałaban too, they
carry |1 + d| ≤ 1 + θ₀; (K3) has coefficient O(N), not 1/g² (p. 366). The T′ large-field factors (pp. 380–383) are Wilson-action or
quadratic-form LOWER bounds on real configurations with positive per-plaquette weights: Lemma 1.

### 5.5 UPPER BOUNDS ONLY; (1.74)–(1.75) ONLY IN (1.103)–(1.104) (brief item (ii)) — HOLDS
READ: (1.92) "Using (1.68), (1.73), (1.89), we obtain"; (1.98)–(1.102) un-normalized (T_k(Y) = χ^c_kχ_{k,Λ}δ_G T′_k(Y)); p. 391 "the final
remark about another possible representation"; p. 392 "The representation (1.104) can be used alternatively". CMP 119 §2's inductive
hypotheses (pp. 255–262) assume no positivity; Corollary 3's lower bound is a consequence. The ONE lower bound at complex D the main line
needs — on |J|, the R_D denominator — is supplied by Lemma 2, not by positivity (it should be said so). The probabilistic measures
(3.27), (3.29) of CMP 119 are handled by the exponentiated cluster expansion (pp. 277–278, (3.44)–(3.47)), not by positivity: CHECKED.

### 5.6 R5, THE T′-BOUNDS AT COMPLEX D — HOLDS WITH REPAIR
(1.73)_D via T′_{k,Re} is right; the large-field factors (1.79)–(1.89) transfer with (1 − θ₀/2); the κ-induction (1.80)–(1.88) closes.
REPAIR: "the A_j-Gaussians, D-free by the device" is incomplete. By the device the D-term's quadratic part −d𝒲 in the T-integration
variables (CMP 119 (2.21)/(3.23): the layer fields kept in T^{(k+1)}; LFR I (1.25)) sits in their exponent. It is harmless only if kept
WITH the Gaussian: Re(C^{(k)−1} + d𝒲) ≥ (1 − |d|)C^{(k)−1} (0 ≤ 𝒲 ≤ C^{(k)−1}, M3cR §(6)) costs e^{O(θ₀)} per variable, absorbed in
Bałaban's exp O(1)|Z_j∩Ω_j| (p. 383). Put into the boundary terms it violates (2.42)/(1.69): its sup on |A_k| < C₁p₁(g_k) is
|d|C_WC₁²p₁² per bond. M3d's (c) "boundary-term constants enlarged by absolute factors" is false for this piece unless it is so placed.

### 5.7 THE COMPLETE MODEL'S SMALL-FIELD STEP (T2, R1) AND LEMMA M_c (9.2) — HOLE AS STATED; closed by a hypothesis
QUOTED: T2 "Lemma M with ε = |s|E₀C₁ε₁ + |d|(C_W + E₀C₁ε₁) ≤ ε_* for |d| ≤ θ_*"; 9.2 "the cone property, Theorem BB4*-D and the joint
analyticity hold in the complete model with the SAME absolute ε_*, θ_*".
THE MISSING TERM (READ CMP 119 (3.23), (3.25), (3.28)–(3.29); LFR I (1.60)): the complete model splits the fluctuation into A on Λ_{k+1}
(cluster-expanded) and A_k on the boundary layer Ω_{k+1}∩Λ^c_{k+1} (kept in T^{(k+1)}; small-field there: scaled |A_k| up to
δ_k/g_k = A₁p₀(g_k), resp. C₁p₁(g_k), (3.3), (3.43)). By the device the D-term is −d·W(A + A_k); its quadratic part has the CROSS term
−2d𝒲(A, A_k): linear in the integrated field, coefficient |d|C_W|A_k| up to |d|C_WC₁p₁(g_k). Bałaban's own cross term −⟨A, C*Δ^{(k)}CA_k⟩
(O(1)·p₁; it stays in the measure (3.29)) is disposed of through the Gaussian — completion of the square with the Schur term moved into
T^{(k+1)} ((3.23), (3.25)), integration by parts in (3.28) — a REAL shift. For complex d the part i·Im(d)·2⟨A, 𝒲A_k⟩ needs a complex
shift, which the sharp characteristic functions χ^{(k)} do not allow; as a polymer potential its activity in Lemma M's Cauchy/absorption
mechanism is ~|Im d|C_WC₁p₁(g_k) (sup on the domain |Im d|C_WC₁²p₁²), not ≤ ε_*. COUNTEREXAMPLE TO THE CONE CLAIM: constant
d = iθ_*/2 and |A_k| = ½C₁p₁(g_k) on the interface bonds: the cross potential's (M.2) constant is ≍ θ_*C_WC₁²p₁(g_k)² → ∞ as g_k → 0.
M3d supplies no estimate for it. The same structure is in LFR I (1.60) (B_j cluster-expanded, A_j external): site R1.
REPAIR (sufficient): |d_j| ≤ c·ε_*/(C_W C₁ p₁(g_j)) at every step of the complete model, with the pure-layer piece −d𝒲(A_k, A_k) kept in T
(5.6) [or |d_j| ≤ c/(C_WC₁²p₁(g_j)²) keeping everything in B]; for REAL d Bałaban's real shift covers it. Then the cross term is in the
cone and T2, R1 close. ON (S₁)'s DISC WITH ∇h̃ ≢ 0 THIS IS AUTOMATIC: |d_j| ≤ c₃δ_*(γ,M)X‖h̃‖/(M‖∇h̃‖x_j), δ_* ≤ P(γ)^{−3} and
p₁(g_j)²X/x_j ≤ p₁(γ)², so |d_j|C_WC₁²p₁(g_j)² ≤ c₃C_WC₁²‖h̃‖/(M^{15}‖∇h̃‖R(γ)⁴P(γ)) ≪ 1. For ∇h̃ ≡ 0 (Lemma 3 void) shrink the disc to
|τ|‖h̃‖ ≤ cX/(C_WC₁²p₁(γ)²e^{Cγ^a}) — still independent of K and the volume. Theorem PI-4 for complex |D| up to θ₀x/2 is NOT proved.
Not affected: everything whole-lattice (Lemma C′, Σ₁, PI-5, the β-flow) — no external layer field there.

### 5.8 LEMMA 3 AND THE τ-DISC (brief item (iii)) — HOLDS WITH REPAIR
L^{k−K}δ_*(g_k)^{−1} ≤ C_pL^{−(K−k)}(1+K−k)^pδ_*(γ)^{−1}: CHECKED (polylog(x_k)/polylog(X) ≤ C(1+K−k)^p for x_k ≤ X + (K−k)(c+ρ) + 2F);
binding scale k = K; r_τ depends on γ, M, X, h̃ only — independent of K and the volume. 9.3's R(γ)^{−1} (supp ζ₀ = X_i, diameter 100MR_k;
READ LFR I p. 201 "ζ_i ∈ C₀^∞(X_i)") keeps that. REPAIR: "∇R_k is of lower order" is asserted; it needs a bound from M3b (5.3)'s
construction (it involves ‖∂³h̃‖_∞) — routine, not on the page. The lag on R-regions ≤ N ≤ R_k steps: CHECKED (p. 366; LFR I p. 177).

### 5.9 THEOREM PI-4 OVERALL — HOLDS WITH REPAIR for the uses; as stated (complex |D| ≤ θ₀x/2) it carries the hole of 5.7
T3 holds, but not because "|D| lies in Bałaban's range O(k)" (his coefficient differences are O(k − j), small at the boundary of Z_k and
large only deep inside, while D ~ θ₀x_k reaches the boundary): the part in Z_k is suppressed by e^{−δ₀dist(Λ_{k+1}, Z_k)} ≤ e^{−δ₀MR_k},
which beats θ₀x_k·p₁/g_k because R_k ≥ (log g^{−2})^r, r ≥ 2; the interface part is 5.7. "Analytic on the polydisc" should read "on the
admissible set" (Lemma 3's variation condition is convex, not a polydisc).

### 5.10 THEOREM PI-5 — (3.1) HOLDS WITH REPAIR; (3.2) HOLDS AT SKETCH LEVEL ONLY
(1.24) READ: |(1.23)| ≤ 8B₀C₁e^{16κ₁}α₂^{−1}g_k|B|E₀(α₁/α₃)⁵(L^jη)⁵…, linear in E₀; p. 8 "(6L)⁴L^jη … the sum over j is bounded by
2(6L)⁴": the scale-j history enters step k with weight L^{−(k−j)}, so N_k is the right input norm, and N_{k+1} = ½a_{(k+1)} + L^{−1}N_k is a
definition plus "old terms are fixed functions" (CMP 119 (2.25), READ). REPAIR 1 (constants): "S ≤ ½E₀ (CMP 116 (2.41))" is false on P,
where the potential reaches ~ε_*: Lemma M (b) gives S ≤ O(1)C₃′max{c₂′ε_*, t₂} = R₀ × (Bałaban's ½E₀ scale). Then 2S/Z₀ ≤
8·O(1)C₃′c₂′C₁ε₁N_k (+ t₂ terms): q = L^{−1} + C″ε₁, C″ = 8·O(1)C₃′c₂′C₁ absolute — the stated form survives, at the price of a new upper
bound on ε₁ in Bałaban's order; the constant of (3.1) changes (still independent of K and the volume). The Cauchy factor in d is
8S|d′ − d|/θ_*, not 4S. REPAIR 2 (falsifier): "there is no other marginal structure" is false — Bałaban's R-terms are marginal and NOT
coupling-renormalized ((2.30)–(2.31), READ p. 260: "terms with bounds O(1)(L^jη)⁴g_j^{κ₀} … The sum over j is controlled by g_j^{κ₀}"):
their D-differences are summable by g_j^{κ₀} with κ₀ arbitrary, (2.31) holds at complex D via (1.100)_D (M3d 9.1), and they do not enter
the whole-lattice β. REPAIR 3: p, p′ must be flow-consistent (D_{i+1} from D_i by (6.2) with the actual β); for arbitrary sequences the
mismatch is a marginal remnant. (3.2) — the history part of β of order g_k² + ε₁g_k — is ESSENTIAL (without it the history accumulates
ε₁ log K) and is given in three lines; M3cR rated its source (M3c 7.4's β-history line) "HOLDS as a sketch". It needs the moment-form
computation written: parity of the first-order term at the base point, the covariance with V_k carrying ε₁g_k, the even part O(g_k²N_k)
from the g_k|B| form of (1.24).

### 5.11 LEMMA Σ₁ WHOLE (§4.2) — HOLDS, given M3cR's LOCAL Lemma M (d)
CMP 119 pp. 279–284 READ: (3.48) the inductive bound; WT identities (gauge invariance — a scalar coefficient field keeps it); (3.57)
"E^{(j)}(U_j, z) defined on the whole lattice … translation invariant"; (3.58)–(3.64); (3.65)–(3.67). No positivity, no reality. The
frozen part needs only the WHOLE-LATTICE small-field model at constant complex D, not Theorem PI-4 — so 5.7 does not touch it. The
variation part needs the local form of Lemma M (d) (M3cR §(7)); M3d cites M3c 7.6 without it.

### 5.12 LEMMA SH — HOLDS GIVEN the defect-polymer form of Lemma M (as 4.1′(d) labels it). 5.1 (6) lists it among results "proved given
Bałaban's black boxes": it needs one routine extension more (defect activities ≤ a shell indicator or 2(Ce^{−c₂ε₁²/g²})^{1/(2d)} per bond,
factorizing over site-disjoint components), which is not a black box. Slice, residual group, defect bound (iii): CHECKED.

### 5.13 PROPOSITION E1-a — HOLDS WITH REPAIR. Missing: the a priori disc |x′_j − x_j| ≤ θ₀x_j/2 for all j, without which Lemma C′(c), SH and
PI-5 do not apply; it follows from Theorem 2's two-sided profile for both trajectories (|x′_j − x_j| ≤ 2(K − j)ρ + 4F ≤ θ₀x_j/2 once
ρ ≤ θ₀(c − ρ)/8 and 4F ≤ θ₀X/4). Real D: 5.7 does not arise (real shift; the β-flow is whole-lattice anyway).

### 5.14 PROPOSITION E1-b — HOLDS WITH REPAIR: PI-5 with a nonzero initial history difference (N_{k₀} ≤ E₀, decaying as q^{k−k₀}) and the a
priori disc of 5.13; the rate L^{−β′(K−i)} at fixed distance i from the unit scale CHECKED.

### 5.15 THEOREM S₁ — (i)–(iii) HOLD on M3d's disc when ∇h̃ ≢ 0 (with 5.6, 5.8, 5.10's repairs; 5.7 automatic there); for ∇h̃ ≡ 0 the disc
must be shrunk (5.7). (iv) HOLDS FOR THE UPPER BOUND ONLY at complex τ; the lower half of LFR II (0.1) is a real-τ statement, and (iv)
must say so.

### 5.7′ PRECISION TO 5.7 (written after 5.7; 5.7 not edited)
"A complex shift is impossible against the sharp χ" is stronger than what is shown. One need not move χ: for real A and complex w,
dμ_C(A)e^{−⟨A,w⟩} = e^{½⟨w,Cw⟩}·e^{−½⟨A+Cw, C^{−1}(A+Cw)⟩}dA/Z exactly, a complex-mean Gaussian with χ(A) untouched. That route would need
(a) the factors e^{½⟨w,Cw⟩} and e^{½⟨Im m, C^{−1}Im m⟩} (m = −Cw) — quadratic forms in the external A_k with coefficients O(|d|²), O(|Im d|²) —
routed into T's layer Gaussian (5.6's positivity), and (b) a cluster expansion for a Gaussian with complex mean, the mean decoupled
together with C(s), the oscillating phase e^{−i⟨A, C^{−1}Im m⟩} controlled at |Im m| ~ |Im d|C_WC₁p₁. None of it is on M3d's page;
Bałaban's own route for −⟨A, C*Δ^{(k)}CA_k⟩ is the real one. And M3d's ONLY source of analyticity in D is Lemma M (d) (uniform convergence on
the complex domain), which needs exactly the cone membership that fails here; computing at real D and continuing is not available,
since the real shift's cutoff positions χ(|A − m(D)| < …) are not analytic in D. So the verdict stands as: MISSING ESTIMATE (HOLE as stated),
closed by the hypothesis of 5.7. Sites: CMP 119 (3.23), (3.25), (3.29) with the domain (3.43) and the layer of p. 269; LFR I (1.60).

## 6. THE VERDICTS ON THE THREE LABELS

| Item | Verdict | Repair / missing estimate |
|---|---|---|
| R_D (construction) | HOLDS | necessary only for |d| ≳ 1/polylog |
| Lemma 1 | HOLDS | — |
| Lemma 2 | HOLDS WITH REPAIR | prove ‖M_d − (1+d_Λ)^{−1/2}I‖ small from near-constancy (resolvent formula; log cond factor) |
| three-case census (i) | HOLDS WITH REPAIR | add the fourth case (small terms bounded with their 1/g²) and K3's O(N) coefficient |
| upper bounds only; (1.74)–(1.75) only in (1.103)–(1.104) (ii) | HOLDS | state that the R_D denominator's lower bound is Lemma 2's |
| R5 (T′-bounds) | HOLDS WITH REPAIR | D-quadratic in T's layer/A_j variables kept with the Gaussian (e^{O(θ₀)}/variable) |
| Lemma M_c (9.2); T2, R1 in the complete model | HOLE as stated | the D cross term −2d𝒲(A, A_k) with the boundary-layer field; closed by |d_j| ≤ cε_*/(C_WC₁p₁(g_j)) or real d |
| Lemma 3, τ-disc (iii) | HOLDS WITH REPAIR | bound ∇R_k; R(γ)^{−1} of 9.3; radius independent of K and volume |
| Theorem PI-4 as stated (complex |D| ≤ θ₀x/2) | HOLE | 5.7; under 5.7's hypothesis HOLDS WITH the 5.3/5.6/5.9 repairs |
| Theorem PI-5 (3.1) (iv) | HOLDS WITH REPAIR | S ≤ O(1)C₃′max{c₂′ε_*, t₂}, q = L^{−1} + C″ε₁; R-terms in the falsifier; flow-consistent p, p′ |
| Theorem PI-5 (3.2) | HOLDS WITH REPAIR | the moment-form computation must be written (load-bearing: else ε₁ log K) |
| Lemma Σ₁ | HOLDS WITH REPAIR | local Lemma M (d) (M3cR); needs only the whole-lattice model, not PI-4 |
| Lemma SH | HOLDS WITH REPAIR | the defect-polymer extension of Lemma M, written (not a black box) |
| E1-a | HOLDS WITH REPAIR | a priori disc from Theorem 2's two-sided profile |
| E1-b | HOLDS WITH REPAIR | PI-5 with initial history difference; a priori disc |
| S₁ (i)–(iii) | HOLDS WITH REPAIR | on M3d's disc with ∇h̃ ≢ 0 (5.7 automatic there: r_τ ∝ δ_* ≤ P(γ)^{−3}); for ∇h̃ ≡ 0 shrink by p₁(γ)^{−2} |
| S₁ (iv) | HOLDS WITH REPAIR | upper bound only at complex τ |
