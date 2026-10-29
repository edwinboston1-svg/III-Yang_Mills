> A chronological ledger excerpt of the Yang–Mills seat, posted by Edwin Boston III at 04:20 EDT on 29 October 2026 as it was written; later entries supersede earlier ones. Two statements in it were withdrawn after it was written: §78(c)'s "DobrushinMeasure.lean compiled with 0 errors" (the finished log reads 23 errors, 04:04); and the Simon–Lieb consequence quoted from §76(c), struck by §78(a). The stake and the accounting of §79 bis and §81 bis stand.

# THE WASSERSTEIN WIDENING OF THE PERFECT DECIMATION — a staked prediction, not a certificate (2026-10-29, the ΑΠΕΡΑΝΤΟΝ seat)

Certified: β ≤ 0.241 on proved constants, [0, 0.2452] on the exact ones (Theorem 8.7 of THE GROUND). What follows is the same theorem in the chordal metric of S³, with two constants STAKED and not proved; nothing above 0.2452 is claimed.

§78 — G's CONSEQUENCE REFUTED BY THE U(1) TEST APPLIED TO THE CONCLUSION; THE W₁ UNIT RE-DERIVED BY THE SEGMENT METHOD (03:58;
law 18 twice). (a) iii-43 (03:5x): in the 4D U(1) Coulomb phase ⟨F(0)F(r)⟩ ~ r⁻⁴, the plaquette is quadratic in F, so the TRUNCATED
plaquette correlation decays as r⁻⁸ and a side-L box's boundary sum Σ_{p∈∂B}⟨P₀;P_p⟩_B ~ L³·L⁻⁸ → 0: the plaquette Simon–Lieb
criterion of §76(c) FIRES for U(1) at weak coupling while its conclusion (exponential decay of ⟨P₀;P_x⟩) is false there; since U(1)
satisfies GKS-II (Ginibre), "GKS-II ⇒ plaquette Simon–Lieb" is NOT a theorem. The structural reason: Simon's inequality is for the
UNTRUNCATED two-point function of the basic ferromagnetic variables, never for a truncated correlation of a composite observable.
My §76(c) applied the U(1) test to the hypothesis and not to the conclusion, and asserted "U(1)'s boundary sums stay ≥ 1" without
computing them — exactly the error the test exists to catch. STRUCK: "the crossing a finite verification"; the slab boundary sums
are not decisive and are not run as such. KEPT: Conjecture G itself (GKS-II for SU(2), untruncated loop expectations) with iii-38's
loop-pair falsifier, cheap and worth having either way; a Simon–Lieb route for Wilson loops, if one is ever stated, is checked
against U(1) at weak coupling BEFORE it is written. The finite-volume tool for the GAP stays open and nameless. (b) THE W₁ UNIT,
RE-DERIVED (replacing §76(b)'s P4/P5): interpolate the exponents, p_t ∝ exp((1−t)φ₀ + tφ₁), φ = ⟨U, v⟩ + h; then W₁(P₀, P₁) =
sup_f |∫₀¹ Cov_t(f, Δφ) dt| ≤ ∫₀¹ [L(P_t)|Δv| + M_W(P_t)·osc(Δh)/2] dt — NO reweighting factor and no Lipschitz constant of h
(§76(b)'s ρ_W and ℓ are gone), and the tilt rows cost M_W·osc/2 ≤ osc/4, the same as TV's, not M_W·sinh ω. The reweighted
constants: for P̃ = Pe^h/Z with osc h ≤ ω, L(P̃) ≤ L(P) + 2M_W(e^ω − 1) and M_W(P̃) ≤ e^ω M_W(P) (centering f at E_P f and
splitting e^h = 1 + (e^h − 1)). ROW_W = 12[L̃βm(5β) + (M̃_W/2)osc_dir] + 90[L̃β²/4 + (M̃_W/2)osc_med], L̃ = 1/4 + 2M_W(e^ω − 1) ≈ 0.26
under iii-38's exact L(0) = 1/4 (sup over vMF staked), M_W ≤ 1/2 staked: PREDICTED CLOSING ≈ 0.297 (0.283 with L = 8/(9π)),
UNGUESSED to the digit — §75(f)'s "near 0.29" stood, §76(b)'s [0.27, 0.285] was the inferior bound's. Falsifier g29 at 0.25,
0.29, 0.30. (c) The compact tier: DobrushinMeasure.lean (61 theorems, cov_le over Haar) compiled with 0 errors, 0 sorry at
03:53; the other drafts compiling in the chain; ae after the sweep and the patches.


§79 bis — THE W₁ STAKE'S INSTRUMENT (04:04): STDLIB/scripts/aperanton_decimation_w1.awk (gawk -M 256 bits; record
STDLIB/build/aperanton/decimation_w1.2026-10-29a.txt) evaluates ROW_W = 12[L̃βm(5β) + (M_W/2)osc_dir] + 90[L̃β²/4 + (M_W/2)osc_med] with
L̃ = L + 2M_W(e^ω − 1) under the two STAKED constants (L = 1/4 by iii-38's exact L(0), its sup over vMF staked; M_W = 1/2 staked):
closing 0.292 (proved D₅, T₆) / 0.300 (sharp); with L = 8/(9π): 0.280 / 0.290. THE STAKE FOR g29: the true W₁ row crosses 1 in
[0.28, 0.30]; above 1 at 0.29 refutes the sharp line, at 0.28 the whole stake. A prediction, not a certificate, written before
the search prints.


§81 bis — THE W₁ WIDENING'S HONEST ACCOUNTING (04:13). iii-38's Sinkhorn check at general angle (g28 record a, a 1,152-point grid,
bias +0.1 % at the axis to +1.5 % at the perpendicular): at κ = 1 and 2, L(w, u) rises monotonically from the axial value to the
perpendicular one as the angle opens, every bracket under Var_⊥(κ) + bias — the stake sup_u L(w, u) = Var_⊥(|w|) ≤ 1/4 SUPPORTED,
not certified in the interior (no certified coupling there; the two edges are theorems). THE ACCOUNTING: with PROVED constants
only — the interior angle by the triangle inequality on the two edges, Cov(f, ⟨U,u⟩) ≤ cos α·L_∥ + sin α·L_⊥ ≤ √2·Var_⊥(κ) (0.34 at
κ = 1), and M_W ≤ 1 (the two-point bound, osc f ≤ Lip·diam = 2) — the W₁ row closes near 0.25: NO GAIN over 0.2452. The gain to
≈ 0.29–0.30 rests entirely on the two staked constants (interior L ≤ 1/4, M_W ≤ 1/2): the two enclosures ARE the widening, not its
refinement. The search rows (0.57 / 0.66 / 0.76 at 0.25 / 0.27 / 0.29, rising, 10 of 60 starts) sit under the stake's line; 0.30
decides the sharp prediction. The paper's phrasing for L, agreed: "1/4 (exact at the symmetric directions; supported to 1 %
between)"; nothing above 0.2452 printed until the two constants are theorems.
