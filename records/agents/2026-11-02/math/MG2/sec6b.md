
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
