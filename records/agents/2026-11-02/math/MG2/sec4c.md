
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
