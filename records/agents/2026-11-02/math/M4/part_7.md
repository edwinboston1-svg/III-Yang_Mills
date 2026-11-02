
---

## 7. RESULTS — THE CHANNEL SPLIT ON THE EXACT OBJECTS (2026-11-02 05:4x–06:0x; reader m4chan.c, records rec/chan_*.txt and
rec/kat_synthetic.txt; run_records.sh re-runs everything; double precision, two quadrature degrees, not outward rounding:
READINGS of truncated laws at fixed data, planar geometry only)

**Known answers — all MET.** KR (GENINV = 1, the record's). K-real at every cell (P(0,0) = 1 to 4·10⁻¹⁵, |Im P| ≤ 10⁻¹⁸).
K-sum: max|Φ − E − K| ≤ 2.5·10⁻¹⁴ at every cell (the identity Φ = E + K). K-syn: ρ = ρ_OO = ρ_oo^{PW} = 0.050000000, ρ_EE = 0,
τ_A = τ_B = 0.0951057 — the grid value ε·max_rule|χ_½| = 0.05 · 2cos(π/10) (the supremum 2ε = 0.10 sits at U = ±1, which the
degree-16 rule does not contain: τ is read as a grid LOWER bound, as designed). K-synE: ρ = ρ_EE = 0.05, ρ_OO = 0, τ = 0. K-synM:
ρ = 0.05, ρ_EE = 0.03, ρ_OO = 0.05. K-synA (a non-symmetric marginal): ρ_OO = 0.052178 ≠ ρ_oo^{PW} = 0.051031 (the O-channel and
the half-integer channel part where the marginal is asymmetric), both bounds MET. K-U1: ρ = ρ_OO = 0.05, ρ_EE = 0, τ = √2ε =
0.0707107 exactly (k = 1); ρ = ρ_EE = 0.05, ρ_OO = 0, τ = 0 (k = 2). K-free (SU(2) and U(1) free data): every ρ = 0, τ = 0 (after
the variance was made two-pass: the one-pass form left a 2·10⁻⁸ square-root-of-roundoff floor that tripped the bound check —
caught by this known answer, corrected, every cell re-run). K-M2: the full ρ equals M2's Road A to every printed digit at all
twenty-two cells (e.g. 0.081207503, 0.132155408, 0.009649371, 0.015210922, 0.017433784, 0.000253141, 0.031498032; U(1)
0.204193924, 0.120240908, 0.065427751). Quadrature: degrees (30, 16) against (40, 20) move ρ, ρ_EE, ρ_OO by ≤ 4·10⁻⁹ and τ by
≤ 3·10⁻⁶. K-bounds: the exact block bound and the Lemma 3.1 bound hold at every cell; τ ≤ ¼Δ cosh(½ max|F|) at every cell.

**SU(2), β = 2.2, planar geometry** (ρ all functions; ρ_EE the SO(3) / integer-spin channel; ρ_OO the O-channel; ρ_oo^{PW} the
half-integer channel; τ_A Lemma 3.2's label sensitivity; Δ_A = osc_V of the object's vortex free energy F = log p(A,B) −
log p(−A,B); "L3.1" the ratio (ρ_EE² + τ_A² + τ_B²)^{1/2}/ρ):

| cell | datum | ρ | ρ_EE | ρ_OO | ρ_oo^PW | ρ_EE/ρ | ρ_EE/ρ_OO² | τ_A | Δ_A | L3.1 |
|---|---|---|---|---|---|---|---|---|---|---|
| one step W2L2 | ordered | 0.081207503 | 0.009661687 | 0.072364560 | 0.079003091 | 0.1190 | 1.845 | 0.17816 | 1.816 | 3.10 |
| one step W2L2 | cancelling | 0.132155408 | 0.009886493 | 0.126614067 | 0.127770570 | 0.0748 | 0.617 | 0.26563 | 2.488 | 2.84 |
| one step W2L2 | Haar-random | 0.009649371 | 0.000060092 | 0.009599636 | 0.009635432 | 0.0062 | 0.652 | 0.01915 | 0.1527 | 2.81 |
| one step W3L2 | ordered | 0.109877830 | 0.023990432 | 0.087656223 | 0.106739875 | 0.2183 | 3.122 | 0.26325 | 3.183 | 3.40 |
| one step W3L2 | cancelling | 0.189480725 | 0.024246383 | 0.175209768 | 0.186798900 | 0.1280 | 0.790 | 0.38842 | 3.787 | 2.90 |
| one step W3L4 | ordered | 0.107463097 | 0.023838571 | 0.085546511 | 0.104203327 | 0.2218 | 3.257 | 0.23630 | 2.666 | 3.12 |
| one step W3L4 | cancelling | 0.189748876 | 0.024216662 | 0.175516775 | 0.186384158 | 0.1276 | 0.786 | 0.37914 | 3.759 | 2.83 |
| two steps W2L2 | ordered | 0.015210922 | 0.000029625 | 0.015192554 | 0.015101791 | 0.00195 | 0.128 | 0.030379 | 0.2468 | 2.824 |
| two steps W2L2 | cancelling | 0.017433784 | 0.000028438 | 0.017423620 | 0.017356762 | 0.00163 | 0.0937 | 0.034811 | 0.2765 | 2.824 |
| two steps W2L2 | Haar-random | 0.000253141 | 0.000000004 | 0.000253141 | 0.000253140 | 0.000017 | 0.069 | 0.000506 | 0.00402 | 2.827 |
| two steps W3L2 (rec. b, Schur) | ordered | 0.031498032 | 0.000274590 | 0.031300941 | 0.031034503 | 0.00872 | 0.280 | 0.063078 | 0.5314 | 2.832 |
| two steps W3L2 | cancelling | 0.038581180 | 0.000227944 | 0.038500207 | 0.038342605 | 0.00591 | 0.154 | 0.077062 | 0.6265 | 2.825 |
| two steps W2L4 | ordered | 0.015210959 | 0.000029625 | 0.015192592 | 0.015101782 | 0.00195 | 0.128 | 0.030375 | 0.2468 | 2.824 |
| two steps W2L4 | cancelling | 0.017433797 | 0.000028438 | 0.017423633 | 0.017356758 | 0.00163 | 0.0937 | 0.034810 | 0.2764 | 2.824 |

**U(1)** (NMAX 6, charges to 6; the named data, where the engine's object is the planar one):

| β, cell | datum | ρ | ρ_EE | ρ_OO | ρ_oo^PW | ρ_EE/ρ | ρ_EE/ρ_OO² | τ_A | Δ_A | L3.1 |
|---|---|---|---|---|---|---|---|---|---|---|
| 1.2 one step | ordered | 0.204193924 | 0.028933711 | 0.179354415 | 0.184967947 | 0.1417 | 0.899 | 0.31221 | 2.958 | 2.17 |
| 1.2 one step | cancelling | 0.353739827 | 0.032451943 | 0.339517798 | 0.330714036 | 0.0917 | 0.282 | 0.49794 | 4.054 | 1.99 |
| 0.9 one step | ordered | 0.173509119 | 0.008459945 | 0.166785740 | 0.157142628 | 0.0488 | 0.304 | 0.24747 | 1.915 | 2.02 |
| 0.9 one step | cancelling | 0.265189144 | 0.008491566 | 0.262384446 | 0.254758754 | 0.0320 | 0.123 | 0.37148 | 2.511 | 1.98 |
| 1.2 two steps | ordered | 0.120240908 | 0.000737625 | 0.119762669 | 0.112635694 | 0.00614 | 0.0514 | 0.16640 | 1.083 | 1.96 |
| 1.2 two steps | cancelling | 0.147800366 | 0.000727564 | 0.147556794 | 0.142596255 | 0.00492 | 0.0334 | 0.20602 | 1.276 | 1.97 |
| 0.9 two steps | ordered | 0.065427751 | 0.000047205 | 0.065404474 | 0.063554785 | 0.00072 | 0.0110 | 0.09136 | 0.5447 | 1.97 |
| 0.9 two steps | cancelling | 0.074510598 | 0.000044939 | 0.074501919 | 0.073685269 | 0.00060 | 0.0081 | 0.10483 | 0.6079 | 1.99 |

**Per-step factors (two steps / one step), by channel, at the same datum and cap:** SU(2) W2L2 ordered: ρ ×0.187, ρ_OO ×0.210,
ρ_EE ×0.0031; cancelling: ×0.132, ×0.138, ×0.0029; W3L2 ordered: ×0.287, ×0.357, ×0.0114; cancelling: ×0.204, ×0.220, ×0.0094.
U(1) 1.2 ordered: ×0.589, ×0.668, ×0.0255; cancelling: ×0.418, ×0.435, ×0.0224; 0.9 ordered: ×0.377, ×0.392, ×0.0056;
cancelling: ×0.281, ×0.284, ×0.0053.

**THE STAKES, GRADED (as written in §6, none edited).**
- S1 HELD: at every two-step cell ρ_EE/ρ ≤ 0.0087 (≤ 0.10 staked); at every one-step cell ≤ 0.222 (≤ 0.4 staked).
- S2 REFUTED at three cells: ρ_EE/ρ_OO² at two steps reads 0.128, 0.0937, 0.069, 0.280, 0.154 — below the band [0.1, 3] at the
 W2L2 cancelling (0.0937, twice: L2 and L4 caps) and random (0.069) cells. The even channel is slaved to the odd one in the sense
 ρ_EE = O(ρ_OO²), with a constant 0.07–0.28 at two steps — below the strong-coupling 2/3 and not the heat-kernel ρ_OO^{2/3}.
- S3 HELD: at the random datum ρ_OO and ρ_oo^{PW} agree to 0.4 % (one step) and 4·10⁻⁶ (two steps); at the ordered one-step W2L2
 cell they part by 8.4 % (0.072365 against 0.079003).
- S4 HELD: (ρ̃² + τ_A² + τ_B²)^{1/2}/ρ ∈ [2.81, 3.40] for SU(2) and [1.96, 2.17] for U(1); at two steps SU(2) sits at 2.824–2.832,
 the leading mode's 2√2 = 2.828, and U(1) at 1.96–1.99, its leading mode's 2.
- S5: the bounds HELD at every cell; "τ within a factor 3 of ¼Δ cosh(½max|F|)" HELD at two steps and at the random data (2.05–2.43)
 and REFUTED at the one-step named-data cells (4.6–13.6): there max|F| reaches 2.6–4.5, and cosh(½max|F|) with the osc-vs-sd gap
 is what the free-energy bound pays.
- S6 REFUTED: U(1)'s even share at two steps reads 0.0060–0.0061 (1.2) and 0.0006–0.0007 (0.9), below the band [0.03, 0.3] — the
 Gaussian (Hermite) picture ρ_EE = ρ² would give ≈ 0.12; the second clause (larger at one step: 0.032–0.142) HELD.
- S7 HELD: the odd channel's factor at the ordered datum is ×0.210 for SU(2) W2L2 (< 0.25) and ×0.668 for U(1) at 1.2 (> 0.4);
 the even channel's SU(2) factor reads ×0.0031–0.0114, against the predicted ≈ 0.035 — the even channel contracts an order of
 magnitude faster than the square of the odd one on these objects.

**What the readings say, at their strength.** (1) ON EVERY PINNED OBJECT AT TWO STEPS THE DIRECT COUPLING IS THE VORTEX HALF:
ρ_OO/ρ ≥ 0.9937 for SU(2) and ≥ 0.9964 for U(1); the SO(3) channel carries at most 0.87 % (SU(2)) of the planar pair's direct
coupling. (2) The exact block bound (ρ_EE² + ρ_EO² + ρ_O·²)^{1/2} meets ρ to 10⁻⁵ relative at two steps: the decomposition of
§3 loses NOTHING on these objects once the O-channel is read exactly; Lemma 3.2's free-energy handle τ costs the factor 2√2 of the
leading mode, the price of the ess sup over the orbit, and no more. (3) The even channel contracts per step ×0.003–0.011 (SU(2))
and ×0.005–0.026 (U(1)), the odd one ×0.14–0.36 and ×0.28–0.67: both groups contract in both channels at fixed data, as every
fixed-datum reading of the record has (the U(1) column's standing warning: a per-scale ratio at two rungs is not a law).
(4) RECONCILED WITH §5's PHYSICS, AND WHY THE OBJECTS CANNOT SEE THE SO(3) HALF. The pinned object fixes the whole fine outside, so
the coupling it reads passes only through the two faces; the physical carrier of the SO(3) channel at the coarse scale — the
scalar glueball exchanged through the surrounding fibre, exp(−m a_c) — is exactly what pinning severs. On the true blocked
measure the SO(3) half therefore lives in the OUTSIDE-MEDIATED term of M2's mixture inequalities (Lemma 5.1 / 7.1:
ρ_ξ(A,B) ≤ √(M_A M_B) E_ν[ρ_ω] + ρ_ξ(A; ω)ρ_ξ(B; ω)) — the covariance, over the fine outside under its true law, of the object's
SO(3)-content means. Combining Theorem 3.3 with Lemma 7.1 channel by channel: THE DIRECT COUPLING IS THE VORTEX HALF (read here:
≥ 99 % at two steps), AND THE SO(3) HALF IS THE OUTSIDE-MEDIATED COVARIANCE (no pinned object reads it). That is the precise form
of the window's remaining object (§8).
