
### 3.3 RESULTS — the Gaussian fibre (records rec/kat.2026-11-02a.txt, rec/d4_box4*.txt, rec/batch1.2026-11-02a.txt, rec/photon.2026-11-02a.txt; engines gfib.c, photon.c; double precision, READINGS on two roads unless marked PROVED)

**Known answers, all MET before any reading.** K1 (d = 1, dec, L = 4): C_fib(a, a) = 0.75, 1.00, 0.75 = a(L − a)/L, C_fib(1, 3) = 0.25, every
cross-block entry ≤ 5·10⁻¹⁷ — the independent bridges. K2: |Σ_z q(z) C_fib(z, y)| ≤ 8·10⁻¹⁸ against entries of 0.06–0.31 (d = 2, 3, 4).
K3: Σ_D 𝒦₀(D) = 1.000000000000006 / …005 / …008 / …008 / …006 for box2 (d = 2), box4 (d = 4), box1 (d = 4), dec (d = 3), heat (d = 4). K4:
roads A and B agree to 6–9 digits in every cell where both read (e.g. d = 4 box4 L = 16: 1.323724 / 1.323723772; d = 4 dec L = 16:
0.159063 / 0.159064541). K5: every reading is above the proved Combes–Thomas rate η_L of Theorem G (1.7627 ≥ 0.6931 at L = 2;
1.3237 ≥ 0.0190 at L = 16). Photon: at L = 1 (coarse data = every plaquette) the fibre covariance is ≤ 4·10⁻¹⁸.

**THE TABLE (κ = decay rate per coarse unit of the fibre covariance, the slowest sector read; ρ′ = e^{−κ}).**

| map | d | L = 2 | L = 4 | L = 8 | L = 16 | L = 32 | law |
|---|---|---|---|---|---|---|---|
| block average (box_d), every d | 2, 3, 4 | 1.762747 | 1.425417 | 1.344024 | 1.323724 | 1.318649 | **cosh κ = 2 + 3/(L² − 1) EXACTLY (Thm 3.1), κ_∞ = log(2 + √3) = 1.316958** |
| decimation | 4 | 1.320925 | 0.651223 | 0.319785 | 0.159065 | — | κL → G₄(0)^{−1/2} = 2.5405 (2.642, 2.605, 2.558, 2.545) |
| decimation | 3 | 1.717661 | 1.123082 | 0.746110 | 0.511811 | — | κ√L → G₃(0)^{−1/2} = 1.9891 (2.429, 2.246, 2.110, 2.047) |
| decimation | 2 | 2.292432 | 1.946393 | 1.640001 | 1.438773 | 1.297028 | κ² log L → 2π (3.64, 5.25, 5.59, 5.74, 5.83) |
| line (box1), transverse decay | 4 | 1.717661 | 1.123082 | 0.746110 | 0.511811 | — | = decimation in d = 3 (Lemma 3.2) |
| plane (box2), transverse decay | 4 | 2.292432 | 1.946393 | 1.640001 | 1.438773 | — | = decimation in d = 2 (Lemma 3.2) |
| codim-1 (box3), in-box decay | 4 | 1.991794 | 1.817650 | 1.796311 | 1.792294 | — | uniform; transverse decay below 10⁻¹¹ by D = 4 (decimation in d = 1: bridges) |
| heat kernel, t = L²/8 | 4 | 1.034680 | 0.779965 | 0.730565 | 0.718897 | — | uniform, → 0.716 |
| **photon, holonomy map (flat-square fluxes)** | 4 | **1.717662** | **1.123083** | **0.746109** | **0.511829** | — | **= decimation in d = 3 to 6 digits: κ ∝ L^{−1/2}, NOT UNIFORM** |
| **photon, averaged fluxes (Bałaban-type)** | 4 | **3.541** | **5.280** | **≈ 5.98** | **≈ 6.2–6.4 (C₀(1) = 10⁻⁶ C₀(0))** | — | **saturates the alias bound L·arccosh(2 − cos 2π/L) = 3.525, 5.268, 5.983, 6.204 → 2π** |

(The K_⊥ scan on the grid {0, π/2, π}³ for box4 at L = 2, 4, 8 put the slowest sector at K_⊥ = 0 on the line Re K = π; the decay
alternates in sign, (−1)^D e^{−κD}. The local (untransverse-summed) correlator on a 16⁴ coarse torus decays at the same rate with the
D^{−3/2} prefactor of a three-dimensional transverse integral: log-ratios 1.84, 2.19, 2.00, 2.00 at D = 4–7 against 1.7627 + 1.5/D.)

**Theorem 3.1 (THE EXACT RATE OF THE BLOCK-AVERAGED GAUSSIAN FIBRE; PROVED, the residue's non-vanishing READ).** For the massless
lattice field on ℤ^d, any d ≥ 1, with block averages over cubes of side L ≥ 2, the zero-transverse-momentum sector of the fibre
covariance (and of the fibre-mean kernel 𝒦) decays along each axis as (−1)^D e^{−κ_L D}, with

  cosh κ_L = 2 + 3/(L² − 1):   κ₂ = arccosh 3 = log(3 + 2√2) (ρ′ = 3 − 2√2 = 0.1716),   κ_∞ = arccosh 2 = log(2 + √3) (ρ′ = 2 − √3 = 0.2679).

*Proof.* (1) At K_⊥ = 0 the box kernel's transverse factor (1/L)Σ_z e^{ip_μ z} vanishes at p_μ = 2πn_μ/L for n_μ ≠ 0, so only the
aliases with n_⊥ = 0 enter S and U, and for them λ(p) = 2(1 − cos p₁): the problem is the d = 1 chain. (2) In d = 1,
|q̂(p_n)|² = sin²(K/2)/(L² sin²(p_n/2)) and λ(p_n) = 4 sin²(p_n/2), so S(K) = (sin²(K/2)/4L²) Σ_{n=0}^{L−1} sin^{−4}((K + 2πn)/2L).
From Σ_{n=0}^{L−1} sin^{−2}(x + πn/L) = L² sin^{−2}(Lx) and (sin^{−2})″ = 6 sin^{−4} − 4 sin^{−2}, differentiating twice gives
Σ_n sin^{−4}(x + πn/L) = L⁴/sin⁴(Lx) − (2/3)L²(L² − 1)/sin²(Lx), hence

  S(K) = [2L² + 1 + (L² − 1) cos K] / (12 sin²(K/2)).

(3) The regularised denominator of T_ab and of 𝒦 is Den = |w₀|² + λ₀S′ = λ₀ S = 4 sin²(K/2L) S(K), whose only zeros in the strip
|Im K| < L·arccosh(2 − cos(2π/L)) (below every alias pole) are those of the bracket: cos K = −(2L² + 1)/(L² − 1), i.e.
K = π ± iκ_L. (4) The residue there does not vanish: road A's real-space slopes equal κ_L to 6–9 digits at L = 2, 4, 8, 16, 32 (READ). ∎
**Cross-field identity (the unification this theorem carries).** The fibre mean of the massless field given its block averages is the
lattice HISTOPOLATING SPLINE, and κ_∞ is the decay of Schoenberg's cardinal cubic spline: cubic interpolation's coefficients obey
c_{k−1} + 4c_k + c_{k+1} = 6y_k, whose Euler–Frobenius polynomial z² + 4z + 1 has the root z = −(2 − √3) — the sign is the alternation,
|z| is ρ′_∞. The lattice formula cos K = −(2L² + 1)/(L² − 1) is the discrete-spline Euler–Frobenius root. Bałaban's and
Gawędzki–Kupiainen's "fluctuation field massive at the block scale" is, for the block average, exactly the exponential localisation of
cardinal spline interpolation.

**Lemma 3.2 (DIMENSIONAL REDUCTION; PROVED).** For the sub-box map box_k (average over {0..L−1}^k in directions 1..k), the sector of zero
coarse momentum along the k box directions is EXACTLY the fibre of the massless field on ℤ^{d−k} under decimation with the same L.
*Proof.* At K_μ = 0 in a box direction the factor (1/L)Σ_z e^{ip_μ z} kills every alias with n_μ ≠ 0 and equals 1 at n_μ = 0, where
p_μ = 0; so S and U are sums over the (d − k)-dimensional aliases of 1/λ_{d−k}, the decimation sums in d − k dimensions. ∎
Consequences, all met by the table: a sub-box of codimension c = d − k behaves, transverse to itself, as decimation in c dimensions —
c = 1: bridges, no constrained-sector decay at all (the rate is the alias bound); c = 2: κ² log L → 2π; c ≥ 3: κ ≈ G_c(0)^{−1/2} L^{1−c/2}
(Poisson: S(K)/L^c = G(0) + L^{2−c}(1/K² + O(1)), zero at K² = −L^{2−c}/G(0)). **So a coarse map gives a fibre uniformly massive at the
block scale iff it averages over a set of codimension ≤ 1.** THE HOLONOMY MAP IS THE LINE: the coarse link variable is the line sum of
A_μ along μ, a decimation in the other three directions at zero momentum along μ — hence the photon's holonomy-map rates equal the
three-dimensional decimation rates digit for digit, κ ≈ 1.99/√L → 0: the perimeter self-energy of the sharp Wilson line, in the
fibre's language. The averaged (codimension-0) map leaves only the trivial alias modes.

**The stakes, graded (as written in §3.2, none edited).**
- S1 HELD: κ(2) = 1.7627 ∈ [1.0, 3.5]; κ(16)/κ(2) = 0.751 ∈ [0.7, 1.3]; κ ≥ η_L everywhere.
- S2 HELD: κ(16)/κ(2) = 0.120 ∈ [0.08, 0.2] (the law 1/L, κL → 2.54).
- S3 HELD: the line, transverse decay, κ(16)/κ(2) = 0.511811/1.717661 = 0.298 ∈ [0.25, 0.5] (in-line decay 0.516/1.705 = 0.303).
- S4 HELD: the plane, slowest direction, κ(16)/κ(2) = 1.438773/2.148842 = 0.670 ∈ [0.45, 0.9] (transverse alone 0.628). K4 BORDERLINE in this one cell family: at L = 2 the in-plane decay reads 2.1488 on road A against 2.1690 on road B (0.9 %, an off-line zero pair that road B, scanning Re K ∈ {0, π}, does not see); road A, the correlator itself, is taken; at L ≥ 4 the roads agree to 0.2 % and better.
- S5 HELD: codimension 1, in-box decay κ(16)/κ(2) = 1.792294/1.991794 = 0.900 ∈ [0.7, 1.3]; the transverse decay is below 10⁻¹¹ by D = 4 at every L (the bridges of Lemma 3.2).
- S6 REFUTED AS STAKED, by 0.005: κ(16)/κ(2) = 0.718897/1.034680 = 0.695 < 0.7. The heat-kernel rate does converge (0.716; uniform), but
  falls by 30 % from L = 2 to the limit; the band's low end was set too high.
- S7 HELD: decimation 0.628 ∈ [0.4, 0.85]; block average 0.751 ∈ [0.7, 1.3].
- S8 HELD: decimation 0.298 ∈ [0.25, 0.5]; box1 transverse (codim 2) 0.628 ∈ [0.45, 0.9]; box2 in-plane (codim 1) 0.900 ∈ [0.7, 1.3].
- S9 HELD and SHARPENED into Lemma 3.2 (an exact reduction, not a scaling guess).
- The photon runs had no numerical band written in §3.2; their stake is §1 (iii), written before any run: "the sharp holonomy map … loses
  uniformity like L^{−1/2}; Bałaban's averaging keeps it" — HELD on both halves (holonomy κ(L)/κ(L/2) = 0.654, 0.664, 0.686 → 0.707;
  averaged: the rate rises to the alias bound, better than uniform).

**What this answers in item 2.** (1) "Is II′ small where the sup form is 13.24?" In the only currency in which II′ is a number — its
rate — the linearised fibre at one and two steps (L = 2, 4) has ρ′ = 0.180 / 0.325 (holonomy map), 0.029 / 0.005 (averaged map),
0.172 / 0.240 (scalar block average): a positive rate, and β-INDEPENDENT (Gaussian scaling), so the same for U(1) at 1.2 and SU(2) at 2.2
linearised. The 13.24 measures single-site criteria, which fail (§3.4); the collective rate exists. (2) Block size: the holonomy map
loses uniformity (κ ∝ L^{−1/2}: the ultraviolet blocks of size a_c/a_j → ∞ make its fibre carry the long modes, which is M2R's structural
fact made exact); averaging and heat-kernel smearing keep it. At the crossover's own L = 2 and 4 every map gives an O(1) rate. (3) Coarse
map: uniform iff the averaged set has codimension ≤ 1 (Lemma 3.2). (4) Gauge fixing inside blocks: irrelevant for gauge-invariant
observables (Prop. 2.8), which are all the chain needs.

### 3.4 RESULTS — the single-pair coefficients of the SU(2) fibre at 2.2 in L² (records rec/adversary.2026-11-02a.txt; ahalf.awk)

**Proposition 3.3 (the L² single-pair row of the fibre at β; PROVED, number CERTIFIED).** With M5's link e (off every coarse path) and
an axial gauge fixing every direction-4 link (the worst case), for each of the 14 free staple links b of e the fully adversarial pair
environment — e's five other staples summing to zero AND b's five other staples summing to zero — is realisable inside the fibre (each
of the ten staples has a private free off-path link: adversary.c checks all 14 at a_c = 2, 3, 4, "realizable for 14 of them"). There
the joint conditional law of (U_e, U_b) is ∝ exp((β/2) tr(U_e U_b C)), a convolution kernel whose maximal correlation is its top
non-trivial Peter–Weyl coefficient a_½(β) = I₂(β)/I₁(β). The maximal correlation is continuous in the environment and the fibre
density positive, so the ess-sup R_fib(e, b) ≥ a_½(β), and the fibre's L² row at e is at least 14 a_½(β) (18 a_½(β) when no staple
link is fixed). Certified (positive-term series, directed rounding at 256 bits, geometric tail): **a_½(11/5) ∈ [0.464479025270421,
0.464479025270421]; 14 a_½ = 6.502706353786; 18 a_½ = 8.360622454868** (known answers met: a_½(10⁻³) = 0.00024999999 ≈ β/4;
a_½(0.4764) = 0.117989464, the record's). The single-pair L² criterion holds only below β ≈ 0.22–0.29 (14 or 18 a_½ = 1), against
the TV form's 0.13103 (M5).
**Its meaning.** The L² currency halves the sup form (6.50 against 13.24) and does not rescue it; by A1 no averaged single-pair
criterion could decide II′ anyway. The single-pair coefficients of the fibre are not small at 2.2 in any currency; the fibre's
COLLECTIVE rate (§3.3) is.
