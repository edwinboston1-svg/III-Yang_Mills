
4.1′ PRECISIONS TO LEMMA SH (dated, 2026-11-02, after reading CMP 109 pp. 252–255, 266 on M3c's renders today; 4.1 not edited).
(a) The gauge-fixing factor of record carries its own cutoff: (0.15), p. 254, (1/z)∫du(x)exp[−(1/α)[1 − Re tr U(y,x)u^{−1}(x)]]
χ({|U(y,x)u^{−1}(x) − 1| < ε₀}) = 1, and (0.16), p. 255, keeps χ({|U(y,x) − 1| < ε₀}) in the transformation. So
g_α(u) := z_α^{−1}e^{−(1/α)(1 − Re tr u)}χ(|u − 1| < ε₀) — still a probability density; (iii)'s tail bound holds for ε₁/8 < ε₀.
(b) The slice is Bałaban's: with the averaged contour variables U(y,x) = M({U(Γ)}_{Γ∈G(y,x)}) (0.11) and the covariance
M({uU_jv}) = uM({U_j})v (0.6), the transformation u(x) := U(y,x) (u(y) = 1) maps U to the slice {U(y,x) = 1}; dU = J(s)ds du with
J independent of u (Haar invariance), J absorbed into F. (c) The background V^{(k)} = M^k(U_{k+1}) is a function of the coarse
variables, which R fixes; so the fluctuation V′ = V(V^{(k)})^{−1} moves under v ∈ R only by the end-point factors, and
|B′_{V^v}(b) − B′_V(b)| ≤ C(|θ_{b−}| + |θ_{b+}|) (Ad-invariance of the norm). (d) Step (v) produces, besides the defects of (ii), the
defects χ_b(s(U)) − χ_b(U) (the cutoff on the slice representative versus on U), of the same type under G_{α₀}; the expansion is
CMP 116 (2.3)'s with local defect polymers, each bounded by (iii)–(iv). STATUS of Lemma SH: PROVED GIVEN Lemma M's expansion
extended to local defect polymers whose activities are bounded as in (iii)–(iv) — an extension of the same kind as (2.3)'s cutoff
decomposition (P-polymers with the factor e^{−½γ₂(ε₁²/g_k²)|P|}), which Lemma M's proof covers verbatim once the factor is replaced.
(e) R_D AND THE LAG. Bałaban's R resets the lagged reference coefficient on Z to 1/g_k² and drops the discrepancy (K3) into the small
terms; R_D may do the same for D (the lag ≤ Ng_k^{2+a}θ₀x_k gives a discrepancy term ≤ Ng_k^{2+a}θ₀·O(1)M¹⁴R_k⁴p₀(g_k)² — small), so
that after R_D the coupling field on the renormalized region is the flowed one.

## 5. THE ULTRAVIOLET HALF AFTER M3b, M3c, M3d — STATUS

5.1 PROVED GIVEN BAŁABAN'S BLACK BOXES. The black boxes, named: [BB-a] CMP 99's generalized random-walk expansions of the background
propagators and of all operators determining Δ_k (CMP 116 p. 13; Theorems 3.7–3.10 [13] cited by CMP 119 p. 276); [BB-b] CMP 102
Sect. G, the minimal configuration's analyticity and the exponential decay (189)–(190) of its functional derivative, "We do not
perform these calculations here" (p. 308); [BB-c] the estimates of CMP 109 Theorem 3, CMP 116 Lemmas 1–2, CMP 119 §3 and LFR I–II
as stated (including the steps Bałaban only sketches: LFR II p. 368 "They should be obvious"; CMP 119 p. 279 "treated in exactly
the same way"; the convergence constant of [26] used at CMP 116 (2.39)). Given [BB-a]–[BB-c]:
 (1) Lemma M, Theorem BB4*, the moment form (a = 1), Lemma W, Theorem BB4*-D, Lemma FP, Lemma C (sup and moment), Lemma C′ (a)–(c)
     [M3c §§2–7];
 (2) Theorem PI-4: Bałaban's large-field steps close at a complex Wilson coefficient field, with R_D [this file §2];
 (3) Lemma Σ₁ — CMP 119 (2.43) with a coupling field: frozen part (§4.2) and variation part [M3c 7.6]; hence (PI) of M3b §8 whole;
 (4) Theorem PI-5: the multi-step history propagation with decay L^{−β′(k−i)} [§3];
 (5) Theorem S₁ (i)–(iv) of M3b §5 on the τ-disc of §4.4: the source of the action density is a complex coupling field carried
     uniformly in the cutoff, the vacuum part local, the finite part analytic and bounded uniformly in K, separated-support
     correlations decaying exponentially at every scale below the unit scale; the multiplier m_K → 1 + (b₁/b₀)g²_{YM,K} + O(g⁴);
 (6) Lemma SH (§4.1, 4.1′(d)) and with it Lemma C′ (d) [M3c 7.3 (d)];
 (7) Proposition E1-a (bare coupling unique up to a K-independent shell, §4.3) and Proposition E1-b (the renormalized trajectory
     converges, rate L^{−β′(K−i)});
 (8) Proposition D∞ [M3b §9.4]: the gap for fine vectors needs Hypothesis I plus the averaged fibre clauses, not (D).
5.2 WHAT REMAINS, EACH AT ITS TRUE STATUS.
 (R1) THE BLACK BOX [BB-b] — CMP 102 (189)–(190), OPEN in the literature (Bałaban states it without the calculation). It enters
      Lemma 1 of CMP 116 (via (1.17)'s smallness after division by g_k², "the inequality (190) [15]", LFR II p. 360), the H-function
      decay used at every site T3, R3 (K4), and Lemma B's strip analyticity. ATTEMPT AND ROUTE: M3R's lead — derive (190) from CMP 99's
      background propagator bounds (3.127)–(3.133) [BB-a], since the functional derivative of the minimizer solves a linear equation
      whose operator is the constrained background Laplacian H*ΔH that CMP 99 inverts with exponential decay.
 (R2) THEOREM 2's REMAINING INPUTS (M3R item 2c): the gauge-fixed form of Lemma B's stage identity (residual-gauge and coarse-gauge
      zero modes; Lemma FP's slice (FP3) is the tool — it already splits E = G ⊕ T exactly for the step), the infrared identification
      (B1) (the record's proof on paper, not re-done line by line), the alias constants through CMP 102's derivative bounds, and Lemma D
      (coupling-uniform convergence in the localized norm) — OPEN, named by M3R; none touched here.
 (R3) THE TWO-CUTOFF COMPARISON OF THE COMPLETE MODEL (M3b 10.3) — OPEN. Its small-field part is Theorem PI-5 at real parameters; its
      large-field part needs the R-terms' and B-terms' cross-cutoff differences: by CMP 119 (2.44) and (2.47) these carry R₁g_j^{κ₀} and
      B₁2^{−(j−n)} per unit volume, so the deep-past large-field contributions DECAY as the cutoff is removed — the next object is the
      statement that R_D is Lipschitz in its input density in the norm of (2.43)–(2.47), proved by the same Schwarz argument as §3.2 (ii)
      on the T′-bounds R5 (upper bounds only are used, so the Lipschitz constant is the T′_{k,Re}-bound times the input difference).
 (R4) (E2) orientation universality — an infrared statement (M3b 11.3); the UV half delivers the O(4)-invariance of every marginal
      term (S-A) and nothing more.
 (R5) Hypothesis II in published form for SU(2) — M3's (S) for general observables and (P_LF); (S₁) gives it for the 0⁺⁺ channel
      (action-density sources); (P_LF) — the large-field probability bound — is now within reach: Theorem PI-4's R5 bounds are
      exactly the T′-bounds (1.79)–(1.89) at complex coupling, and (P_LF) asks for the same bounds as probabilities.
 (R6) The crossover (Hypothesis I at a_c from 2.2–2.3) — not ultraviolet.

## 6. CROSS-FIELD UNIFICATIONS FOUND

(U1) BAŁABAN'S R-OPERATION IS A CHANGE OF REFERENCE MEASURE WITH A LOCAL NORMALIZATION, AND THE COMPLEX COUPLING MAKES IT A DEFORMED
CONTOUR. R preserves integrals because the new factor and its denominator are one weight; at complex coupling the weight's integral
is a complex Gaussian, whose size is controlled not by positivity but by rotating the real contour into the steepest-descent
(Lefschetz-thimble) contour M_d·ℝ^n (Lemma 2 (iv)) — the same device that makes complex Gaussian integrals and the Picard–Lefschetz
treatment of complex actions finite without a sign problem. The cost the crude modulus bound would pay, e^{nθ₀²/4}, is the
"sign-problem" factor |det Q|/det Re Q of lattice simulations at complex coupling; Lemma 2 shows Bałaban's finite-region
structure (n ≤ 12(101M)⁴) removes it entirely.
(U2) THE ONLY POSITIVITY BAŁABAN NEEDS IS POINTWISE. Every use of the density's positivity in the main line is an UPPER bound
(LFR II (1.73), (1.89)); every lower bound he takes from the action is a sum over plaquettes of nonnegative terms (Lemma 1). Such a
proof is stable under any complex deformation of the coefficients with Re ≥ (1 − θ)·(original) pointwise — the structure of
"positivity-improving" arguments in constructive QFT under complex external fields (Lee–Yang-type disc statements: the large-field
suppression is a pointwise lower bound on Re of the action, hence survives a complex field in a disc). The one exception, the
normalized operation (1.75), is exactly where a Lee–Yang zero could sit — and it is the one Bałaban's main line never uses.
(U3) THE HISTORY DECAY IS A CONTRACTION OF THE RG LINEARIZATION ON IRRELEVANT DIRECTIONS, MADE QUANTITATIVE BY CAUCHY. (3.1) is the
discrete Duhamel formula N_{k+1} = qN_k + b_k of a linear RG map whose irrelevant spectrum is ≤ L^{−1} (Bałaban's (L^jη)⁵·L^{−4} per
step) perturbed by the history-to-output Lipschitz constant ∝ ε₁; the marginal direction (F²) is removed exactly by the counterterm
at the actual parameter, which is why no (log K)² appears — the same mechanism as the stable-manifold theorem for hyperbolic fixed
points (the coupling is the centre direction, carried by the flow; the history lives in the stable manifold).

## 7. THE LEDGER (this agent's rows)

| Item | Status | Where |
|---|---|---|
| LFR I (175–202), LFR II (355–392), CMP 119 §3 (264–284) every page on image | READ | §0, §1, 1.4–1.5 |
| where the Wilson coefficient enters: K1–K5; the T′ positivity (1.73)–(1.75); CMP 119 (3.15), p. 277 | READ | §1.2, 1.3, 1.5 |
| M3c's (PI-4) falsifier (additive |Im A| bound × θ₀x_k) | present in form at LFR II (1.47), NOT MET in substance (η = O(g²·small)) | §2.0 |
| R with a reference denominator at complex D | FAILS (uncancelled θ₀M¹⁴p₀²) — replaced by R_D | §2.1 |
| Lemma 1 (modulus domination), Lemma 2 (R_D denominator, contour rotation), Lemma 3 (R-region variation, τ-disc (2.2)) | PROVED (Lemma 2 given Bałaban's (1.6)–(1.9)) | §2.1 |
| Theorem PI-4 | PROVED GIVEN [BB-a]–[BB-c], Lemmas M, W | §2.2 |
| lower bound (1.74)–(1.75) at complex D | NOT AVAILABLE, NOT NEEDED (used only in (1.103)–(1.104)) | §2.2 R5 |
| Theorem PI-5 (decay L^{−β′(k−i)}; (3.1)–(3.2)); falsifier "marginal remnant" | PROVED GIVEN PI-4, Lemma M, Σ₁, Bałaban's Thm 2; falsifier NOT MET | §3.2 |
| Lemma SH (gauge-weight shell) | PROVED GIVEN Lemma M with local defect polymers | §4.1, 4.1′ |
| frozen part of Σ₁; Lemma Σ₁ | PROVED GIVEN black boxes | §4.2 |
| Prop. E1-a; Prop. E1-b | PROVED GIVEN black boxes | §4.3 |
| Theorem S₁ (i)–(iv) | PROVED GIVEN black boxes, on the τ-disc of §4.4 | §4.4 |
| 2.3's comparison with M6 | WITHDRAWN in part (2.3′): Lemma 2 (A) is a condition γ ≲ 10^{−20}M^{−15}·polylog^{−1}, of Bałaban's type | §2.3′ |

## 8. THE PRECISE NEXT OBJECT

CMP 102 (190) from CMP 99 (3.127)–(3.133): the functional derivative of Bałaban's minimal configuration U_k(V) satisfies
δU = H_k(U)·δV with H_k(U) built from the inverse of the constrained background operator; prove |(δU/δV)(x, y)| ≤ B₃e^{−δ₀d(x,y)}
on the analyticity domain from CMP 99's random-walk bound on that inverse. It is the last unproved estimate under every row of 5.1.
