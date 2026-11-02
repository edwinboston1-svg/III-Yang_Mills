# M2b — THE SUPREMUM OVER COARSE ENVIRONMENTS (A), THE CONVERGENCE IN THE BOX (B), THE OUTSIDE AND THE CENTRE (C)

Proof agent M2b, 2026-11-02 (desktop; read-only in both repositories; everything here is in this directory: code/, rec/).
Read in full before any derivation: MATH_BRIEF.md; cross/ANSWER.md; read/REPORTS.md (all 975 lines); math/M2/WORK.md with
l2dob.c and rec/; THE GROUND §§7–8 (cross/ground_docx.txt 201–393: Theorems 7.1, 7.4, Propositions 8.1–8.4, Hypotheses I–II,
Theorem 8.5 and its proof, Lemma 8.6, Theorem 8.7, Theorem 8.9); THE CROSSING CAMPAIGN §§12–17 (the sliced sweep, the planar
lemma, the (8.5) instrument, §15 and its correction, §16, §17); the engine STDLIB/build/aperanton/surface-gas/w2_strip_n.c
(sha256 dd81dfe0…, copied to code/w2_strip_n.orig.c, byte-identical).

The work is appended in the order it was done. Stakes are written before the runs they grade and are not edited after.

---

## 0. A desk check before any code: the cancelling datum's junction tensor is sparse, by a symmetry, and the record agrees

**Lemma 0.1 (the U(1) selection rule).** Let the fine outside datum ω of the two-face object be fixed by conjugation by every
g_θ = cos θ + x sin θ (the unit quaternions commuting with the x-unit) — true of the ordered datum (all outside links 1) and of
the engine's cancelling datum (the shared link's four staple links set to 1, −1, x, −x, the rest 1). Then in the engine's basis
F^{ac}[r, q, r′, q′] = E[D^a(A)_{rq} D^c(B)_{r′q′}] vanishes unless (r − q) + (r′ − q′) = 0.

*Proof.* In Dsub, g_θ has a = e^{iθ}, b = 0, so D^s(g_θ) is diagonal with entry e^{iθ(2p − s)} at (p, p) (with GENINV the
exponent changes sign; the conclusion is unchanged). The global conjugation U ↦ g U g⁻¹ of every link fixes ω, preserves the
Haar measure and every plaquette weight (class functions), and maps the two loops based at the common basepoint to gAg⁻¹, gBg⁻¹;
so F[r, q, r′, q′] = e^{2iθ[(r − q) + (r′ − q′)]} F[r, q, r′, q′] for every θ. ∎

**Read on the record** (dob_n4_W3L2_cancel.txt, the full two-step W3L2 dump, 196 entries): at every class pair the entries of
nonzero weight are at roundoff, at most 4.8 × 10⁻¹⁶ of the largest entry of their block; the weight-zero entries number 19 of 81
at (a, c) = (2, 2), 10 of 36 at (1, 2) and (2, 1), 6 of 16 at (1, 1), 3 of 9 at (0, 2) and (2, 0), 2 of 4 at (0, 1), (1, 0).
So at the two named data only the weight-zero slices of the sliced sweep need running (19 of 81 at the dominant class), an exact
saving, and at the ordered datum the full SU(2) invariance (Schur: F^{ac}/Z = Σ_k (f_k/d_k) P_k, the record's K4 at 2.6 × 10⁻¹⁴)
reduces the dominant class to its 9 diagonal slices, which overdetermine the three channel coefficients and so check themselves.

---

## 1. THE INSTRUMENT FOR (B): FOUR EXACT REARRANGEMENTS OF THE SWEEP, EACH TESTED AGAINST THE ENGINE OF RECORD

code/w2m.c is the engine w2_strip_n.c (sha256 dd81dfe0…) with five additions, each behind an environment variable; with none set
its output is the engine's byte for byte (test U1, rec/t1 and rec/t3: unsliced and sliced, planar and bent, every line equal
below the timings). The additions:

- **W2_DRY** counts every state, the peak memory (both states of a contraction step and the snapshot alive together) and the
  multiply-adds, allocating nothing. Calibration: at W3L2, two steps, it reproduces the record's peak 21,870,000 entries at
  (a, c) = (2, 2) exactly (rec/stage/dry_W3L2.txt).
- **W2_CLAMP** clamps the spins of chosen plaquette cycles in an outer loop and sums the terms (exact: a cycle's spin sum split into
  its terms). One defect found and repaired: the first draft swept face A's snapshot with the filter on at its initial value and
  lost the other terms (relative error 0.28 at cycle 0); the filter is now off in face A's part. Test t2: every clamp set
  (0; 4; 0,5; 1,4) reproduces the unclamped sliced sweep to ≤ 3.8 × 10⁻¹⁶ relative, planar and bent.
- **W2_WEIGHT0** runs only the slices of zero U(1) weight (Lemma 0.1). Test t2: exact to 1.3 × 10⁻¹⁷ at the cancelling datum on
  both objects; THE SIGHTED CONTROL FIRES: at the Haar-random datum, where no conjugation fixes the datum, the filter is wrong
  by 2.1 × 10⁻² (relative). It saves the factor 3.8 at W4L2 (4.56 × 10¹³ → 1.19 × 10¹³ multiply-adds).
- **W2_LEAN** takes the blocks of each new state in groups sharing the spins of the persisting cycles and frees the old state's
  blocks group by group (the peak falls from |S| + |N| toward max(|S|, |N|)); **W2_NOSNAP** sweeps every slice from the first link
  with the four junction wires clamped at birth (no face-A snapshot). Test t3: each alone and both together give F identical to
  the standard sliced sweep (difference exactly 0); with the weight filter and two clamps on top, 1.9 × 10⁻¹⁶.

**The staging (exact counts, rec/stage).** W4L2 at two steps: the peak is at the four shared links (trace: four plaquettes open,
A's column 0 closing as B's column 0 opens), 55⁴ · 27 = 2.47 × 10⁸ entries, 3.95 GB a state, 9.2 GB with both states and the
snapshot. This width is intrinsic: the 2n × n rectangle's least cut across the junction meets n = 4 plaquettes, each carrying
Σ_{s≤4} d_s² = 55, and the cycles open at the peak close in mid-sweep, so an outer loop over their spins would repeat the dominant
face-B work. W4L2 does not fit 2 GB. W4L1 (loop representations to spin ½): 6.8 × 10¹¹ multiply-adds with the weight filter,
peak 2.93 GB standard, to be measured under LEAN + NOSNAP.

**The loop cap at two steps is converged to under 1 % (read from the record's own dumps; the a, c ≤ 1 entries of an L2 dump ARE the
L1 dump, the moments not depending on which others are computed; rec/L1L2/compare.txt):**

| two-step cell | ρ at L2 | ρ at L1 | L1/L2 |
|---|---|---|---|
| W2, ordered | 0.015210922 | 0.015308357 | 1.0064 |
| W2, cancelling | 0.017433784 | 0.017496636 | 1.0036 |
| W3, cancelling | 0.038581180 | 0.038919082 | 1.0088 |

(At one step the L1 truncation is signed and refused by the reader, as a law far from Haar must be.) So W4L1 reads the plaquette-cap
question at about 1 % precision, and it is in reach where W4L2 is not.

## 2. THE STAKES FOR W4L1 (written 2026-11-02 before the runs; not edited after)

The plaquette weight at β = 2.2: (s + 1)a_s = 1, 0.928958, 0.466478, 0.161632, 0.042771, 0.009151 at s = 0..5; the step from
spin 3/2 to spin 2 is the factor 0.2646 (against 0.3465 from spin 1 to 3/2). Measured: the two-step ρ grows W2 → W3 by ×2.07
(ordered, L2) and ×2.224 (cancelling, L1).

- **SW1 (the direction).** ρ at W4L1, two steps, rises above its W3L1 value at both data (the cap still adds coupling).
- **SW2 (the size).** The factor f₄₃ = ρ(W4L1)/ρ(W3L1) lies in [1.10, 1.45] at both data; centre 1.27 (the W2 → W3 excess, 1.1–1.2,
  scaled by the spin-2/spin-3/2 weight ratio 0.26 per plaquette with about four plaquettes' worth of multiplicity). Smaller than
  f₃₂ at both data (convergence).
- **SW3 (the sum against one, the question of the record).** 20ρ at W4L1 cancelling: 0.778 × f₄₃; it crosses one iff f₄₃ > 1.285.
  UNGUESSED; the central arithmetic places it at 0.99, so the cancelling datum is undecided at W4 by my own estimate. At the ordered
  datum the sum crosses one iff f₄₃ > 1.575 (with L1's W3 value 0.635): staked NOT to cross.
- **SW4 (the geometric tail, arithmetic, no claim).** If f_{W+1,W} − 1 decreases geometrically, its ratio q = (f₄₃ − 1)/(f₃₂ − 1)
  extrapolates ρ(∞) = ρ(W4)·Π_{k≥1}(1 + (f₄₃ − 1)qᵏ); written beside the number and labelled a reading.
- **SW5 (the loop cap check carried).** The W3L1 two-step ordered value lies 0.6–0.9 % above M2's W3L2 0.031498032.

---

## 3. (A) THE SUPREMUM OVER COARSE ENVIRONMENTS: NO TYPICAL-ENVIRONMENT FORM EXISTS — THEOREM A1, PROVED

The assignment asked for the form of M2's Theorem 3.1 in which the coarse-environment supremum is replaced by an average (Hölder along
P_tF, hypercontractivity of the fibre dynamics, bad environments priced at z(B)^{1/2p}), or a proof that none exists. **None exists.**
The converged missing step of the reading — "typical boundary data bounded on the exact objects, frustrated data priced by their
chessboard probability" — is satisfied, with both prices as small as one likes, by a measure with long-range order. The chessboard
estimate is the instrument that PROVES order: small chessboard weight of frustrated environments is the signature of the ordered phase.

**Setting.** Λ finite, compact spin spaces V_y, λ a probability on Π V_y with continuous positive density with respect to a product
measure (M2 §2). For y ≠ z and ξ = v_{{y,z}^c}: ρ_{yz}(ξ) the maximal correlation of (v_y, v_z) under λ(· | ξ) (M2's), C_ξ(y|z)
Dobrushin's influence at ξ (M2 Prop. 2.5). A TYPICAL-ENVIRONMENT HYPOTHESIS is any of:
 (TE-p) Σ_z ‖ρ_{yz}‖_{L^p(λ)} e^{κ|y−z|} ≤ α < 1 for every y, some p < ∞;
 (TE-χ) there are events B_{yz} ∈ σ(ξ) with ρ_{yz} ≤ r off B_{yz} and chessboard weight z(B_{yz}) ≤ z, and Σ_z (r + φ(z))e^{κ|y−z|} ≤ α < 1,
   for some φ with φ(0+) = 0 (φ(z) = z^{1/2p} is the assignment's);
 and the same two with C_ξ in place of ρ.

**Theorem A1 (the low-temperature Ising model satisfies every typical-environment hypothesis and has long-range order).** Let d ≥ 2,
L even, λ_L the Ising measure on the torus T_L = (ℤ/Lℤ)^d, λ_L(σ) ∝ exp(β Σ_{⟨x,y⟩} σ_xσ_y), and m = 2d − 1. Then for every L:
 (i) ρ_{yz} ≡ 0 unless y ∼ z; for y ∼ z, on the event that the 2m outer neighbours of the pair carry one sign,
   ρ_{yz} = sinh 2β / (cosh 2mβ + cosh 2β) ≤ 2e^{−4(d−1)β};
 (ii) the complementary event B_{yz} has λ_L(B_{yz}) ≤ (4d − 1)·2e^{−β/2^{d−2}}, and chessboard weight z(B_{yz}) ≤ 2^{3^d} e^{−2β/c_d}
   with c_d depending on d alone;
 (iii) (Peierls) there is β₀(d) such that for β ≥ β₀, inf_{L, x} λ_L(σ_0σ_x) ≥ ½.
Consequently, for every p < ∞, every κ and every φ with φ(0+) = 0: (TE-p) and (TE-χ) hold uniformly in L for all β large
(‖ρ_{yz}‖_p ≤ 2e^{−4(d−1)β} + ((4d−1)·2e^{−β/2^{d−2}})^{1/p} and r + φ(z) → 0), while Cov_{λ_L}(σ_0, σ_x) = λ_L(σ_0σ_x) ≥ ½ for every x
and L: no exponential decay uniform in the volume, and no lattice gap uniform in the cross-section (Theorem 7.1). The TV form is the
same: for two-valued variables C_ξ(y|z) is the change of P(σ_y = + | ·) under the flip of σ_z, which on the monochromatic environment
is ≤ 2e^{−2(m−1)β}·(1 + o(1)), so the C-versions of (TE-p), (TE-χ) hold as well.

*Proof.* (i) Markov property: σ_y, σ_z are conditionally independent given everything else unless y ∼ z. For y ∼ z let
h_y = Σ_{w∼y, w≠z} σ_w, h_z likewise; the conditional law of (σ_y, σ_z) is p(a, b) ∝ exp β(a h_y + b h_z + ab). For two-valued
variables every function is affine, so the maximal correlation is the absolute Pearson correlation,
 ρ = |p₊₊p₋₋ − p₊₋p₋₊| / (p_{y+}p_{y−}p_{z+}p_{z−})^{1/2}.
On the monochromatic environment h_y = h_z = ±m; by the symmetry σ ↦ −σ take +m: the four weights are e^{β(2m+1)}, e^{−β}, e^{−β},
e^{β(1−2m)}, the numerator is (e^{2β} − e^{−2β})/Z² and the denominator (e^{β(2m+1)} + e^{−β})(e^{−β} + e^{β(1−2m)})/Z²
= (2 cosh 2mβ + 2 cosh 2β)/Z². Hence ρ = sinh 2β/(cosh 2mβ + cosh 2β) ≤ e^{2β}/(½e^{2mβ}) = 2e^{−2(m−1)β} = 2e^{−4(d−1)β}.
(ii) Let S_{yz} be the 4d − 1 "star" bonds: yz and the bonds from y and from z to their outer neighbours. If all star bonds are
satisfied, the 2m outer neighbours equal σ_y = σ_z, so B_{yz} ⊂ ∪_{b∈S_{yz}} {b unsatisfied}. For one bond b the chessboard estimate
(Fröhlich–Israel–Lieb–Simon 1978; Biskup 2009, Thm 5.8; the nearest-neighbour Ising weight is reflection positive for reflections
through planes of sites) with the unit block gives λ_L(b unsatisfied) ≤ λ_L(D)^{1/L^d}, D the disseminated event (L^d block positions).
The reflected images of b are the bonds parallel to b whose transverse coordinates are all even (a reflection in a transverse plane sends the
block's face to the opposite face, so each image sits on the even sublattice of the transverse coordinates; correction of 2026-11-02 to a first
draft that took all parallel bonds), so every σ ∈ D has at least L^d/2^{d−1} unsatisfied bonds, Σ_{bonds}σσ′ ≤ dL^d − 2L^d/2^{d−1}, while
Z_L ≥ e^{βdL^d} (the all-plus configuration) and |D| ≤ 2^{L^d}; so λ_L(D) ≤ 2^{L^d} e^{−βL^d/2^{d−2}} and λ_L(b unsatisfied) ≤ 2e^{−β/2^{d−2}}.
The union over S_{yz} gives the first claim. (The chessboard estimate needs the torus side in the block's congruence class: L even for
the unit block, L a multiple of 6 for the side-3 block below; the statement is uniform over those L, which suffices for "no decay uniform in
the volume".) For z(B_{yz}), take a block Q of side 3 containing
the star; on the event that every reflected copy of B_{yz} occurs, every copy of Q contains an unsatisfied bond, so the configuration
has at least (L/3)^d/c_d unsatisfied bonds (c_d bounds the multiplicity with which one bond lies in the overlapping copies); the
same count as for D gives λ_L(∩ copies) ≤ 2^{L^d} e^{−2β(L/3)^d/c_d}, and its (L/3)^d-th root is ≤ 2^{3^d} e^{−2β/c_d}.
(iii) is the classical Peierls estimate (Peierls 1936; Griffiths 1964; Dobrushin 1965), on tori via the chessboard estimate
(Fröhlich–Israel–Lieb–Simon 1978, §5). The consequences: ‖ρ_{yz}‖_p^p ≤ (2e^{−4(d−1)β})^p + λ_L(B_{yz}) by (i)–(ii), and
Σ_z ‖ρ_{yz}‖_p e^{κ|y−z|} = 2d e^κ ‖ρ‖_p → 0; with r = 2e^{−4(d−1)β} and z = 2^{3^d} e^{−2β/c_d}, r + φ(z) → 0. By symmetry
λ_L(σ_0) = 0, so Cov(σ_0, σ_x) = λ_L(σ_0σ_x) ≥ ½. ∎

The supremum form is sound on the same model, as it must be: at the frustrated environment (h_y, h_z) = (1, −1) in d = 2 three of the
four pair states tie and ρ → ½, so M2's R(y, z) ≥ ½ and the row sum is ≥ 2 > 1; Theorem 2.3 refuses.

**Corollary A1′ (no function of the coefficient field decides decay).** In infinite volume, μ⁺ and ½(μ⁺ + μ⁻) are Gibbs measures of
one specification, and the WHOLE FIELD {ρ_{yz}(σ_{{y,z}^c})}_{y,z} has the same joint law under both: ρ_{yz}(−ξ) = ρ_{yz}(ξ) (a
maximal correlation is invariant under a bijection of each variable's values), and μ⁻ is the image of μ⁺ under σ ↦ −σ. At large β,
μ⁺ has exponentially decaying truncated correlations (the low-temperature expansion, classical) and the mixture has
lim_x Cov(σ_0, σ_x) = m*² > 0. So no condition on λ that depends on λ only through the joint law of its single-pair conditional
coefficients — however the bad set is priced, at whatever κ, α, p — implies decay of correlations. ∎

**Where each averaged argument breaks, exactly (so that the failure is a mechanism and not only an example).**
(a) Dobrushin's comparison bounds the distance between λ(dv_y | τ) and λ(dv_y | τ′) by telescoping τ = τ₀, τ₁, …, τ_k = τ′, one
site at a time. When τ and τ′ are typical in OPPOSITE phases every intermediate τ_i is a frustrated environment; the supremum in (8.5)
is taken over exactly the environments that the telescoping visits.
(b) In M2's Theorem 2.3 the supremum enters only in ‖ρ(ξ)ℓ_y(G)_ξ‖_{L²(dξ)} ≤ ‖ρ‖_∞ ℓ_y(G). Hölder gives ≤ ‖ρ‖_{2p}‖ℓ_y(G)_·‖_{2q},
and the argument then needs ‖ℓ_y(G)_·‖_{2q} ≤ C ℓ_y(G) along G = P_tF. For the slow mode F = sign of the magnetisation, ℓ_y(F)_ξ ≠ 0
only at environments on the threshold (interfaces), a set of probability π → 0, and ‖h‖_{2q}/‖h‖₂ ≥ π^{1/2q − 1/2} → ∞ for every
profile supported there; P_tF stays near F because the gap is exponentially small in L (Thomas 1989). The reverse inequality that
hypercontractivity would supply is false.
(c) That is not an accident of the example: for finite-range discrete spin systems a log-Sobolev (hypercontractivity) constant uniform
in the volume is EQUIVALENT to the Dobrushin–Shlosman strong mixing condition, uniform in the boundary condition (Stroock–Zegarlinski
1992). M2's named failure mode is exact: the supremum is not carried along by a technique; the hypercontractive constant IS the
supremum, written as a functional inequality.

**What survives:**
1. The FINE-data supremum is removable inside the mixture, at the price of a moment of a density ratio (Lemma A2, §4, interpolating
   M2's Lemmas 5.1 and 7.1). Fine data are integrated out in the definition of the blocked measure; the coarse environment is
   conditioned on. Averaging is legitimate for what is integrated and illegitimate for what is conditioned on.
2. The COARSE-environment supremum is necessary for every single-site criterion (Theorem A1, Corollary A1′). A measure-weighted
   criterion can be sound only if it contains an input that FAILS for coexisting phases, and such inputs are global: the slice maximal
   correlation (e^{−m_lat ℓ} = ρ_π(X₀, X_ℓ) exactly, M2 Prop. 1.1 read as a maximal correlation), and, for the centre-odd channel
   that carries the two-step coupling, the distinguishability of a centre vortex (Theorem C1, §5). Both refuse the Ising counterexample
   as a sound criterion must: in the mixture the slice magnetisations stay correlated (ρ_π ≥ |corr(m₀, m_ℓ)| → 1), and the Ising
   analogue of the vortex, the domain wall, is expensive in the ordered phase.
3. So the program's missing step changes its form: not "typical coarse environments, frustrated ones priced by chessboard" (refuted),
   but the COARSE supremum of the FINE-INTEGRATED coefficient (sound; the record never read it — it read fixed fine data), or a global
   measure-weighted quantity of the kind in 2.

---

## 4. LEMMA A2: THE FINE-DATA SUPREMUM, INTERPOLATED (proved)

**Lemma A2.** In M2's §5.2 notation (ω the fine outside of the two-face object, ν₀(dω | ξ) its law given the coarse environment, ξ ⊂ σ(ω),
p_ω the object's joint law of (A, B), p(· | ξ) = ∫ p_ω dν₀ the marginal law of A given ξ), for s, q ∈ [1, ∞] with 1/s + 1/q = 1,

 ρ_ξ(A, B) ≤ ‖ρ_·(A, B)‖_{L^s(ν₀(·|ξ))} · (Θ_A^{(q)}(ξ) Θ_B^{(q)}(ξ))^{1/2} + ρ_ξ(A; ω) ρ_ξ(B; ω),
 Θ_A^{(q)}(ξ) := sup_U ‖p_·(U)/p(U | ξ)‖_{L^q(ν₀(·|ξ))}, likewise Θ_B.

Θ^{(1)} = 1 and Θ^{(∞)} = M_A (M2's density ratio), Θ^{(q)} is increasing in q; s = ∞ is M2's Lemma 5.1, s = 1 his Lemma 7.1.

*Proof.* For f(A), g(B) of unit variance under λ(· | ξ), the law of total covariance gives Cov(f, g | ξ) = ∫ν₀ Cov_ω(f, g) + Cov_{ν₀}(m_f, m_g),
m_f(ω) = E_ω f; the second term is at most ρ_ξ(A; ω)ρ_ξ(B; ω) as in M2. For the first, |Cov_ω(f, g)| ≤ ρ_ω (V_f V_g)^{1/2},
V_f(ω) = Var_ω f, so by Hölder and Cauchy–Schwarz |∫ν₀ Cov_ω| ≤ ‖ρ_·‖_s ‖(V_f V_g)^{1/2}‖_q ≤ ‖ρ_·‖_s ‖V_f‖_q^{1/2} ‖V_g‖_q^{1/2}.
With c the mean of f under p(· | ξ) and h = (f − c)² (so ∫ h p(U|ξ) dU = 1), V_f(ω) ≤ ∫ h p_ω dU = ∫ h(U) R_ω(U) p(U|ξ) dU with
R_ω = p_ω/p(·|ξ), and Minkowski's integral inequality gives ‖V_f‖_{L^q(ν₀)} ≤ ∫ h(U) ‖R_·(U)‖_{L^q(ν₀)} p(U|ξ) dU ≤ Θ_A^{(q)}. ∎

What it buys: a frustrated fine datum (ρ_ω near one) enters with its conditional probability to the power 1/s instead of at full weight,
at the price of the q-th moment, over the fine outside, of the density ratio at the worst coarse value. Both are FINE quantities inside
one conditional law; neither is a supremum over coarse environments, which Theorem A1 shows cannot be removed.

---

## 5. (C) THE CENTRE-ODD CHANNEL: THE TWIST IDENTITY, THE VORTEX BOUND, AND THE LEADING-MODE IDENTITY (proved; the object-level twist computed)

**Lemma C0 (the object-level twist, exact).** Let ℓ be an object link lying on loop A and on exactly one object plaquette p, and not on loop B.
The change of variables U_ℓ ↦ −U_ℓ preserves Haar measure; it replaces p's weight w(U_p) by w(−U_p), multiplies each of ℓ's staples by −1,
and maps A ↦ −A, B ↦ B. Since D^a(−U) = (−1)^a D^a(U), the twisted object (p twisted, ℓ's staples negated) has junction tensor
F_tw^{ac} = (−1)^a F^{ac} entry by entry, and in particular the same Z. ∎
*Computed (code/t4_twist.sh, W2_TWIST=0:0, link 0 = (0,0,0,0) dir 1, plaquette 0):* max |F_tw − (−1)^a F| / max|F| = 1.0 × 10⁻¹⁴ (planar and
bent, cancelling), 8.8 × 10⁻¹⁷ and 1.6 × 10⁻¹⁶ (Haar-random), 8.3 × 10⁻¹⁵ at two steps; THE SIGHTED CONTROL (plaquette 0 twisted, link 1's
staples negated — link 1 lies on two face plaquettes, so the path is inconsistent) fails by 0.07–0.83, as it must.

**Theorem C1 (the vortex bound on centre-odd observables).** Let μ be the Wilson measure on a finite lattice, L_V the links crossing a dual
3-chain V, τ_V the flip U_ℓ ↦ −U_ℓ on L_V, and τ_V*μ its image (the measure with the removable vortex sheet ∂V inserted: the plaquettes of ∂V
carry w(−U)). For every bounded X with X∘τ_V = −X (centre-odd under the flip: e.g. X = f(A)g(B), f odd, ∂V linking A an odd number of times
and B an even number), |E_μ X| ≤ ‖X‖_∞ ‖μ − τ_V*μ‖_TV. The same holds for every marginal: if X depends on coarse variables only,
|E_μ X| ≤ ‖X‖_∞ ‖λ − τ_V*λ‖_TV, λ the blocked measure and τ_V acting on the coarse loops by the sign flips of the loops ∂V links.
*Proof.* E_{τ*μ} X = E_μ (X∘τ) = −E_μ X, so 2|E_μ X| = |E_μ X − E_{τ*μ} X| ≤ 2‖X‖_∞ ‖μ − τ*μ‖_TV. The marginal form is the same identity
for the pushforward, and total variation contracts under marginals. ∎
Corollary: for f odd in A, g even under the flip on B, |Cov_λ(f(A), g(B))| ≤ 2‖f‖‖g‖ ‖λ − τ_V*λ‖_TV. This is a MEASURE-WEIGHTED bound with no
supremum over environments; it escapes Theorem A1 because ‖λ − τ*λ‖_TV is a global quantity (it compares the measure with its image under a
centre flip of the coarse loops), and its Ising analogue — the domain-wall image — is far from the measure in the ordered phase, so the bound is
correctly useless there. On the pinned fine scale it is useless too (a thin sheet costs e^{−β tr U_p} per plaquette, ‖μ − τ*μ‖ ≈ 1); its
content is at the coarse scale, where the coarse loops cannot see where a thick vortex runs.

**Proposition C2 (the leading-mode identity: the coupling IS a centre-twist distinguishability).** For the law p(U, V) = 1 + ε χ_½(U) χ_½(V)
on SU(2) × SU(2) with Haar marginals, let T_A = ‖p − p∘τ_A‖_TV, τ_A: (U, V) ↦ (−U, V). Then T_A = ε (8/(3π))², so
 ρ = (9π²/64) T_A = 1.38791 T_A and C = (3π/4) T_A = 2.35619 T_A.
*Proof.* p∘τ_A = 1 − εχ_½(U)χ_½(V), so T_A = ½∫∫|2εχ_½χ_½| = ε (E_Haar|χ_½|)², E_Haar|χ_½| = (2/π)∫_{−1}^{1}|2w|√(1 − w²) dw = 8/(3π);
ρ = ε and C = 16ε/(3π) are M2's (§2.5, §6). ∎
So at the leading mode, Hypothesis I's coefficient between two coarse loops — in either currency — is a fixed multiple of the distinguishability
of their joint law from its image under the centre flip of one loop. M2 read at two steps from 2.2 that the coupling is the (½, ½) mode alone
(ρ/C at 3π/16 at every two-step cell) and M4 reads it at least 99.37 % vortex channel. The numbers ρ/T on the dumps follow in §7.

---

## 6. (W-S) THE OUTSIDE-MEDIATED SO(3) EXCHANGE ON AN INTEGRATED RING: THE INSTRUMENT AND THE STAKES (written before the framed runs)

The orchestrator's message of 2026-11-02 assigned (W-S) here: S_ξ(A, B) = sup |Cov_ν(E_ω f(Ã), E_ω g(B̃))| over integer-spin f, g, the scalar
exchanged across one block, which no pinned object reads. Its exact separation from the direct part needs E_ν[m_f m_g] = (1/Z)∫dω W_out Z^f Z^g/Z_obj,
a replica ratio no tensor contraction evaluates; the exact test is therefore M4's: integrate a ring of the outside and read the TOTAL coupling
by channel, the pinned object at the same datum beside it.

**The instrument (code/w2f.c, W2_FRAME = rt,rb,rl,rr, planar).** The core rectangle [−n, n) × [0, n) plus rt rows above, rb below, rl columns left,
rr right of in-plane plaquettes, their links INTEGRATED with the Wilson weights (their outer staples pinned at the datum); loops unchanged; the
engine's column sweep extended. Known answers before any reading: (F0) W2_FRAME = 0,0,0,0 reproduces the engine byte for byte, unsliced and
sliced (rec/t5) — the extended order is the engine's link for link; (G) gauge covariance at a frame vertex and at a core vertex (W2_GAUGE: every
outside link at v transformed; the object links absorb it), with the half-transform as the sighted control, in flight at this writing. THE CHANNEL
READING: the dump restricted to even a, c IS the law of the SO(3) images (Ã, B̃) (a function on SU(2) invariant under U ↦ −U has only even-spin
components), so l2dob on the filtered dump reads R̃ = ρ(Ã, B̃) exactly (the reader zero-fills absent blocks). Staging: one step, rt = rb = 1,
W3L2: 0.36 GB, 2.3 × 10¹¹ multiply-adds; two steps, rt = 1, W2L2: 0.27 GB, 2.8 × 10¹¹ (rt = rb = 1 at two steps is 3.6 GB: out).

**THE STAKES (UNGUESSED where marked; each side's meaning written first).**
- SR1 (the full coupling). Integrating the ring changes ρ at the same datum and cap by less than a factor 2; direction UNGUESSED. A fall says the
  ring's mixture cancels part of the pinned coupling (the cancellation §15 CORRECTED said a proof must find); a rise says the ring adds coupling.
- SR2 (the SO(3) share, the reading (W-S) asks for). R̃/ρ is larger with the ring integrated than pinned, at both data, both cells: the scalar
  exchange through the ring appears in the integer-spin channel. Size UNGUESSED. If R̃ framed ≤ R̃ pinned at every cell, the ring-mediated scalar
  exchange is not visible at this reach and M4's (W-S) is small on these objects.
- SR3 (the known answers carried). The framed ordered dump meets Schur's identity to roundoff (the frame's outer staples at the identity keep the
  datum SU(2)-invariant); the framed cancelling dump has its nonzero-weight entries at roundoff (Lemma 0.1).

**The gauge known answer (G), read before the stakes below:** with a Haar-random datum (seed 3), n = 2, W2L2, every F entry is unchanged under
a gauge transformation of the outside links at a non-basepoint vertex — core vertex (1,0,0,0) unframed 2.3 × 10⁻¹⁵, framed 6.8 × 10⁻¹⁵; frame
vertices (1,3,0,0) and (−1,−1,0,0) 2.6 × 10⁻¹⁵ and 4.2 × 10⁻¹⁵ — and THE HALF-TRANSFORM (sighted) moves them by 0.19 to 7.0. At the basepoint
(0,2,0,0) the entries move (both loops are conjugated, 0.12 unframed, 0.07 framed) while the class moment E[χ₁(A)χ₁(B)] is unchanged to every
printed digit (1.509785948804 × 10⁻⁵ unframed, −7.673404619292 × 10⁻⁶ framed), as the theorem says.

**THE BLOCKED COEFFICIENT — the orchestrator's landing question — STAKES written before any W4 or framed number is read.** The blocked
one-plaquette coefficient of the coarse loop is a′_½ = E[χ_½(A)]/2 (the marginal law p_A = Σ d_a a′_a χ_a), β_eff the Wilson coupling with
I₂(β)/I₁(β) = a′_½. The record's two-step values at the PINNED data: W2L2 β_eff 0.293 (ordered) / 0.2225 (cancelling) — the numbers the
landing reframing quotes — and, on the same object at the sharper cap, W3L1/W3L2 E[χ_½(A)] = 0.24325 (ordered, rec/w4) / 0.15189 (cancelling,
the record) → β_eff 0.491 / 0.305. So the blocked coupling is NOT converged in the plaquette cap, and the cap moves it UP: at the ordered datum
from inside Theorem 8.9's 0.4764 (W2) to outside it (W3).
- SB1. At W4L1, two steps, pinned: β_eff rises again above its W3 value at both data (ordered above 0.491, cancelling above 0.305). Size UNGUESSED;
  were E[χ_½] to grow by ρ's staked factor 1.1–1.45, the ordered β_eff would read 0.54–0.70.
- SB2. Integrating the ring LOWERS E[χ_½(A)] at the ordered datum (the integrated frame fluctuates where the pinned frame was aligned): the
  framed β_eff lies below the pinned one at the same cap; at the cancelling datum the direction is UNGUESSED.
- SB3 (what decides the landing, said before the numbers). A two-step landing in Theorem 8.9's region needs β_eff ≤ 0.4764 at the cap limit AND
  at the worst coarse environment; a pinned ordered reading above 0.4764 at a sharper cap does not refute the landing (the pinned datum is
  not the integrated measure), but it removes the W2L2 reading as evidence for it.

---

## 7. RESULTS (every value copied from its record; readings on exact finite objects in double precision, two roads where marked — not certificates)

**7.1 THE PLAQUETTE CAP AT TWO STEPS, PLANAR, β = 2.2 (rec/w4; the stakes of §2 graded).** W4L1 cancelling: ρ = 0.046755229 (Road A; Road B
0.046752393), σ_H 0.045643, C = 0.083500, ρ/C = 0.560, the joint density positive (min 0.510); run of record 1589 s, peak 1.28 GB, 8.88 × 10¹¹
multiply-adds. W3L1 ordered: ρ = 0.032262225, C = 0.060263.

| two steps, planar | W2 | W3 | W4 | f₃₂ | f₄₃ |
|---|---|---|---|---|---|
| cancelling, L1 | 0.017496636 | 0.038919082 | **0.046755229** | 2.224 | **1.2013** |
| ordered, L1 | 0.015308357 | 0.032262225 | **0.039579359** | 2.108 | **1.2268** |

W4L1 ordered (appended 07:0x after its run, 1881 s): ρ = 0.039579359 on both roads, C = 0.076495, ρ/C = 0.517, T_conn(A) = 0.056045 (degree 32),
ρ/T = 0.706. SW1 and SW2 HELD at the ordered datum too (f₄₃ = 1.2268); SW3's ordered half HELD (20ρ = 0.792, staked not to cross). The tail
(q = 0.2048, ×1.0590) puts the cap limit of 20ρ at 0.838 (L1), about 0.818 with the ordered datum's L1 → L2 correction (−2.4 %).
**ALL OF 7.1 IS PLANAR GEOMETRY: "20ρ" is twenty coplanar pairs. The true row is S₂₀ = 4ρ_planar + 16ρ_bent; the true bent pair is read below
at one step to W4 and at two steps at W2L2 only, so its correction at W4 is arithmetic from the W2L2 ratio, not a measurement at W4.**

- SW1 HELD (cancelling): ρ rises W3 → W4. SW2 HELD: f₄₃ = 1.2013 ∈ [1.10, 1.45], below f₃₂; below my centre 1.27.
- **SW3 DECIDED BELOW ONE at the cancelling datum: 20ρ(W4L1) = 0.935** (the central arithmetic had placed it at 0.99).
- SW4 (arithmetic, a reading): q = (f₄₃ − 1)/(f₃₂ − 1) = 0.1645, the geometric tail Π_{k≥1}(1 + 0.2013 qᵏ) = 1.0397, so the cap limit of 20ρ reads
  0.972 at L1, about 0.963 with the measured L1 → L2 correction (−0.9 % at the W3 cancelling cell). The U(1) control below makes the same step
  pattern (×1.15–1.23, then ×1.01–1.02) a measured shape, not an assumption.
- SW5 REFUTED: the loop cap moves the W3 ordered cell by 2.4 % (L1 0.032262225 against M2's L2 0.031498032), not 0.6–0.9 %; the cancelling
  cell's 0.9 % stands. The ordered datum's coupling carries more spin-1 loop content.

**7.2 THE ABELIAN CONTROL: U(1)'s CHARGE-CAP LADDER AT TWO STEPS (rec/u1, planar, n = 4, LMAX = NMAX; NMAX 6 = M2's records).**

| U(1), two steps | N1 | N2 | N3 | N4 | N6 | steps N2→3, N3→4, N4→6 | 20ρ |
|---|---|---|---|---|---|---|---|
| β = 1.2 ordered | 0.028176 | 0.098063 | 0.117467 | 0.120029 | 0.120241 | ×1.198, ×1.022, ×1.002 | 2.40 |
| β = 1.2 cancelling | 0.030597 | 0.116699 | 0.144060 | 0.147490 | 0.147800 | ×1.234, ×1.024, ×1.002 | 2.96 |
| β = 0.9 ordered | 0.015521 | 0.056303 | 0.064726 | 0.065396 | 0.065428 | ×1.150, ×1.010, ×1.000 | 1.31 |
| β = 0.9 cancelling | 0.016112 | 0.063218 | 0.073646 | 0.074472 | 0.074511 | ×1.165, ×1.011, ×1.001 | 1.49 |

(LMAX = NMAX is forced — a loop charge above NMAX has no flux to carry it — so the N1 → N2 step mixes the loop cap with the plaquette cap;
the N2 → N3 → N4 steps leaned on below do not, the loop cap being converged from N4 by M2's reading.) The dropped plaquette weight sets the
step: U(1) at N2 drops 2I₃/I₀ = 0.052 (β = 1.2) and its next step is ×1.20–1.23; SU(2) at W3 drops
5a₄ = 0.043 and its next step is ×1.20 — the same law. U(1) at N3 drops 0.0074 and moves ×1.01–1.02 more; SU(2) at W4 drops 6a₅ = 0.0092. So
the SU(2) two-step coupling at W4 is converged to about 2 % by the abelian column's own measured pattern, and U(1)'s converged sums lie at 1.31–2.96,
above one at both couplings, where SU(2)'s lies at 0.935 (cancelling, W4L1).

**7.3 THE BLOCKED COEFFICIENT — the landing question — at the PINNED data (planar, two steps; a′_½ = E[χ_½(A)]/2, I₂(β_eff)/I₁(β_eff) = a′_½,
solved by bisection on the Bessel series).**

| two steps, pinned | W2L2 | W3 | W4L1 | E-steps W2→3, W3→4 |
|---|---|---|---|---|
| ordered: E[χ_½(A)], β_eff | 0.14557, **0.2922** | 0.24325 (L1), **0.4914** | 0.27890, **0.5652** | ×1.671, ×1.147 |
| cancelling: E[χ_½(A)], β_eff | 0.11071, **0.2219** | 0.15189 (L2), **0.3050** | 0.18603, **0.3742** | ×1.372, ×1.225 |

SB1 HELD at both data (cancelling 0.3742 > 0.305; ordered 0.5652 > 0.491, inside the staked 0.54–0.70). **The blocked coefficient converges in
the plaquette cap more slowly than the coupling ρ at the cancelling datum**: there the E-step excess ratio is q = 0.60 (against ρ's 0.16) and the
geometric tail multiplies E[χ_½] by 1.391 — β_eff → 0.523; at the ordered datum q = 0.218, tail ×1.041, β_eff → 0.589. Both cap limits are
readings by arithmetic, not claims; both lie above Theorem 8.9's 0.4764. At the ordered datum the W3 value 0.4914 already lies above Theorem 8.9's
0.4764. **So the W2L2 numbers that the landing reframing quotes (0.293 / 0.2225) are cap artefacts; at the pinned data the cap moves the blocked
coupling OUT of the certified region at both data.** Why the loop expectation and not the coupling: E[χ_½(A)] of a 4 × 4 loop is a product-like
response of sixteen plaquettes to an aligned boundary, and every staple's truncated weight w_W(U) = Σ_{s≤W}(s+1)a_sχ_s(U) under-aligns its link
by the dropped tail; the coupling between two loops is a difference of such responses, in which the common under-alignment cancels to first order.
What this does NOT decide (SB3): the pinned datum is the most aligned outside there is, more extreme than any coarse environment (a coarse
environment fixes coarse loops, not the fine outside links); the integrated-ring reading of §6 is the first step toward the integrated measure.

**7.4 THE CENTRE-ODD CHANNEL ON THE DUMPS (rec/twist; T Richardson-extrapolated from rule degrees 32 and 40, the |·| kink converging as 1/nth²;
the reader's known answer: the rule's own value to 10⁻¹², rec/run_twist.log).**

| cell | ρ | C | T_conn(A) | odd share of ∫|c| | ρ/T | C/T |
|---|---|---|---|---|---|---|
| one step W2L2 ordered | 0.081208 | 0.16638 | 0.109436 | 0.9980 | 0.742 | 1.520 |
| one step W2L2 cancelling | 0.132155 | 0.24928 | 0.163789 | 0.9944 | 0.807 | 1.522 |
| two steps W2L2 ordered | 0.015211 | 0.026283 | 0.022974 | 0.9999 | 0.662 | 1.144 |
| two steps W2L2 cancelling | 0.017434 | 0.029896 | 0.026083 | 0.9999 | 0.668 | 1.146 |
| two steps W3L2 cancelling | 0.038581 | 0.066500 | 0.060063 | 0.9998 | 0.642 | 1.107 |
| two steps W3L1 ordered | 0.032262 | 0.060263 | 0.046496 | 1.0000 | 0.694 | 1.296 |

THE TWO-STEP COUPLING IS WHOLLY CENTRE-ODD (≥ 99.98 % of the connected density's L¹ mass, beside M4's ≥ 99.37 % by another road), and
ρ/T = 0.64–0.69 is NOT the factorised law's 1.388 that Proposition C2 used. Proposition C2′ below says what it is.

**Proposition C2′ (the shape of a pure centre-odd coupling; corrects C2, which held for one shape only).** Let c(U, V) be the connected density of
a law on SU(2) × SU(2) with Haar marginals whose coupling is pure (½, ½). Writing U, V as unit quaternions u, v ∈ S³ ⊂ ℝ⁴ (the spin-½ matrix
elements span the linear functions of u), c(U, V) = uᵀKv for a real 4 × 4 matrix K with singular values σ₁ ≥ … ≥ σ₄ ≥ 0. Then
 (i) ρ = σ₁/4; (ii) C = σ₁ · 4/(3π), so ρ/C = 3π/16 for EVERY such coupling; (iii) T_A = ‖p − p∘τ_A‖_TV = E|uᵀKv| satisfies
 σ₁ (4/3π)² ≤ T_A ≤ σ₁ (4/3π), with equality on the left iff K has rank one and on the right iff K is σ₁ times an orthogonal matrix; hence
 3π/16 = 0.58905 ≤ ρ/T_A ≤ 9π²/64 = 1.38791.
*Proof.* Haar measure on S³ has E[u uᵀ] = I/4 and is invariant under O(4), and E|a·u| = |a| E|u₁| with E|u₁| = (2/π)∫_{−1}^{1}|w|√(1 − w²)dw
= 4/(3π). (i) The maximal correlation is the norm on L²₀ of (Tf)(u) = ∫c(u, v)f(v)dv. T kills every f orthogonal to the linear functions,
and for f(v) = a·v, Tf(u) = uᵀK E[vvᵀ]a = uᵀKa/4, with ‖f‖₂ = |a|/2 and ‖Tf‖₂ = |Ka|/8; so ‖T‖ = sup |Ka|/(4|a|) = σ₁/4.
(ii) The marginal of A is Haar, so p(u | v) = 1 + c(u, v) and ½∫|c(u, v) − c(u, v′)|du = ½|K(v − v′)| E|u₁|, maximal at v = −v′ = the top right
singular vector, giving σ₁E|u₁|. (iii) T_A = ½∫∫|c − c∘τ_A| = ∫∫|uᵀKv| since c is odd in u; by the O(4) invariance
K may be taken diagonal, and E_u|Σσ_iu_iv_i| = E|u₁|(Σσ_i²v_i²)^{1/2}, whose v-average lies between σ₁E|v₁| and σ₁E|v| = σ₁, with the stated
cases of equality. ∎
So the measured ρ/T = 0.64–0.69 places the two-step coupling near the ISOTROPIC end: c ≈ ε⟨u, Ov⟩, a function of the relative holonomy
χ_½(U g V⁻¹) across the shared edge, not of the separate loops. At the ordered datum (SU(2)-invariant, so K = diag(k₀, k₁, k₁, k₁) in the
basis real, i, j, k) M2's Road A prints the singular values directly: 1.521 × 10⁻² three times and 8.0 × 10⁻³ once at two steps W2L2, so
k₀/k₁ = 0.53, which gives ρ/T = (1/4)/(4/3π · E√(1 − 0.719 v₀²)) = 0.653 by (iii), against the reading 0.662. (Road A's singular values are
Gram-weighted — the marginals are not Haar, E[χ_½(A)] = 0.146 there — so k₀/k₁ = 0.53 is read up to that correction, and the 0.653-against-0.662
agreement is the strength of the identification.) THE TWO-STEP COUPLING IS THE
TRIPLET (VECTOR) CHANNEL OF THE RELATIVE HOLONOMY, with a singlet admixture of about one half: the flux carried across the shared edge.

**7.5 THE TRUE BENT PAIR (code/w2f.c built as w2c.exe, W2_CORNER; rec/t6.log; the first t6 run, against a stale binary that could not be
relinked while a framed run held it, is kept as rec/t6.VOID_wrong_binary.log and read for nothing).** Known answers: (C0) unset, the engine
byte for byte; at the free datum the corners are off, byte-identical. (C1) THE DISCRIMINATING CHECK — gauge covariance at the corner vertex
(0, 1, 1, 0), Haar-random datum, n = 2, W2L2: THE ENGINE FAILS (3.3 × 10⁻¹: its double-counted staple reads B's link from the datum), THE
CORNER ENGINE PASSES (4.2 × 10⁻¹⁶); the half-transform moves both (4.3, 10.8). (C2) the zipper order against the engine's order, both with
corners: 5.6 × 10⁻¹⁶, 1.2 × 10⁻¹⁷, 6.1 × 10⁻¹⁷ at the random, cancelling and ordered data. (C3) AT THE NAMED DATA THE TRUE BENT PAIR PARTS
FROM THE PLANAR: the one-step W2L2 class moment E[χ½(A)χ½(B)] reads 0.402991 planar (= the engine's "bent") against 0.414602 true bent
(+2.9 %, ordered) and 0.307594 against 0.319828 (+4.0 %, cancelling). Staging: one step to W4L2 (0.26 GB), two steps at W2L2 (0.82 GB, 5.2 × 10¹¹);
two steps at W3 is out (6.7 GB at L1).

**7.6 THE PRODUCTION PATH LICENSED ON THE NEW GEOMETRIES (rec/t7.log; the review's blocking items, run before any framed or bent number below
is quoted).** The sliced LEAN + NOSNAP + WEIGHT0 path against the unsliced sweep, and Lemma 0.1 checked with full slices (no weight filter: the
nonzero-weight entries must be at roundoff): frame (1,1,0,0) n = 2 W2L2 cancelling 1.3 × 10⁻¹⁷, full = unsliced exactly, Lemma 0.1 1.3 × 10⁻¹⁷;
ordered 2.6 × 10⁻¹⁷, exactly, 2.6 × 10⁻¹⁷; frame (1,0,0,0) n = 4 W2L1 cancelling (two steps) 2.5 × 10⁻¹⁸, exactly, 2.1 × 10⁻¹⁸. The corner
cells and the reversed-order weight checks follow in 7.8.

**7.7 THE INTEGRATED RING, READ BY CHANNEL — (W-S) and the blocked coefficient (rec/frame; the stakes of §6 graded).**

| two steps, W2L2, ordered | ρ | C | SO(3) R̃ | SO(3) share | E[χ_½(A)] | β_eff | ρ/T |
|---|---|---|---|---|---|---|---|
| pinned (M2's record) | 0.015210922 | 0.026283 | 2.9625 × 10⁻⁵ | 0.195 % | 0.14557 | 0.2922 | 0.662 |
| one ring row above INTEGRATED | **0.014262657** | 0.024623 | **2.5010 × 10⁻⁵** | **0.175 %** | **0.14095** | **0.2828** | 0.662 |
| cancelling, pinned (M2's record) | 0.017433784 | 0.029896 | 2.8438 × 10⁻⁵ | 0.163 % | 0.11071 | 0.2219 | 0.668 |
| cancelling, one ring row INTEGRATED | **0.016328764** | 0.027988 | **2.3995 × 10⁻⁵** | **0.147 %** | **0.10720** | **0.2148** | |

At the cancelling datum the same pattern to the digit of its percentages: ρ −6.3 %, the SO(3) channel −15.6 %, E[χ_½] −3.2 %. SR2 is refuted at
both data.

(both roads equal; the joint density positive; odd share of ∫|c| 0.99994; 1513 s, 0.27 GB.) SR1 HELD (the change is −6.2 %, under a factor 2):
the integrated ring LOWERS the coupling — part of the pinned coupling is cancelled in the ring's mixture, the direction §15 CORRECTED said a proof
must find. **SR2 REFUTED at this cell: the SO(3) channel FALLS with the ring integrated (−15.6 %) and its share falls (0.195 % → 0.175 %); the
ring-mediated scalar exchange (W-S) is not visible at this reach — the ring's integration removes integer-spin coupling faster than it adds any.**
SB2 HELD: the blocked coupling falls (β_eff 0.2922 → 0.2828, −3.2 %). The pinned shares at the other cells: two steps 0.16 % (W2L2 cancelling),
0.59 % (W3L2 cancelling), one step 7–22 % (all inside M4's ≤ 0.87 % at two steps). Remaining framed cells (two steps cancelling, one step with a
row above and below at W2L2 and W3L2) are appended below as they land.

**STAKES FOR THE TRUE BENT ROW (written before the bent runs below).** SBent1: at every cell read (one step W2L2, W3L2, W4L2; two steps W2L2;
ordered and cancelling) the true bent ρ exceeds the planar ρ at the same cap and datum — the corner plaquettes add a direct A–B coupling with
positive character coefficients. SBent2: the excess is under 25 % at one step and under 15 % at two steps (the corners touch one coarse corner
of each loop; their share of the loops' boundary falls with n). SBent3: the true row S₂₀ = 4ρ_planar + 16ρ_bent at two steps W2L2 stays below
one at both data (planar 20ρ = 0.304 / 0.349).

**7.8 THE TRUE BENT ROW (rec/bent, rec/bent2; the production path licensed on the corner objects in t7: n = 2 cancelling 1.2 × 10⁻¹⁷, ordered
2.6 × 10⁻¹⁷, n = 4 W2L1 cancelling 2.3 × 10⁻¹⁸, full slices = unsliced exactly, Lemma 0.1 at ≤ 2.5 × 10⁻¹⁷; the planar cells reproduce M2's
records to every printed digit). The stakes above graded.**

| cell (β = 2.2) | ordered: true bent / planar / ratio | cancelling: true bent / planar / ratio |
|---|---|---|
| one step W2L2 | 0.101385 / 0.081208 / **1.2485** | 0.150762 / 0.132155 / **1.1408** |
| one step W3L2 | 0.133182 / 0.109878 / **1.2121** | 0.207627 / 0.189481 / **1.0958** |
| one step W4L2 | 0.145159 / 0.121272 / **1.1970** | 0.215639 / 0.196225 / **1.0989** |
| two steps W2L2 | (in flight) | **0.019806** / 0.017434 / **1.1361** |

SBent1 HELD at every cell read (the corners always add coupling); SBent2 HELD (one step ≤ 24.85 %, two steps 13.6 %); the two-step true bent
coupling is centre-odd and near-isotropic as the planar one (ρ/T = 0.660, SO(3) share 0.19 %), E[χ_½(A)] moves by +0.3 % only. THE TRUE ROW AT
TWO STEPS W2L2, cancelling: S₂₀ = 4 × 0.017434 + 16 × 0.019806 = **0.387** against the planar 20ρ = 0.349 — SBent3 HELD there.
**ARITHMETIC, NOT A READING (the W4 bent pair is out of reach at two steps):** the bent/planar ratio falls slowly with the cap at one step
(cancelling 1.141 → 1.096 → 1.099). Carried onto the W4L1 planar cancelling value with r ∈ [1.10, 1.14], the true row reads
0.935 × (4 + 16r)/20 = 1.01–1.04, and with the cap tail (×1.040) 1.05–1.08: **at the pinned cancelling datum the TRUE two-step row probably lies
ABOVE ONE**, by a few per cent. At the ordered datum (planar 0.792, tail 0.838) a ratio near the one-step 1.20 gives 0.95–1.0 — undecided by
arithmetic. This revises the planar statement of 7.1: the sub-one two-step readings in the L² currency are planar-geometry readings; with the
corners the pinned row sits at one within the errors of this arithmetic. As every pinned reading, it is the integrand at one datum (the
integrated ring lowers the coupling 6 %, 7.7), not Hypothesis I's row.

---

## 8. WHAT IS PROVED, WHAT IS READ, AND THE NEXT OBJECT

**Proved here (full proofs above).** Theorem A1 and Corollary A1′ (§3): every typical-environment form of Hypothesis I — L^p norms of the
conditional maximal correlations (or TV influences) for any p < ∞, or smallness off a bad set priced by its chessboard weight, or ANY condition
depending only on the joint law of the single-pair coefficient field — is satisfied, with both prices as small as one likes, by the
low-temperature Ising model, which has long-range order; so no such condition implies decay. The record's converged missing step is refuted as
formulated. The mechanism (§3 (a)–(c)): the telescoping visits interface environments; a slow mode's fluctuation profile lives on a set of
vanishing probability; uniform hypercontractivity IS strong mixing uniform in the boundary condition (Stroock–Zegarlinski). Lemma A2 (§4): the
FINE-data supremum is removable inside the mixture, interpolating M2's Lemmas 5.1 and 7.1. Lemma 0.1: the U(1) selection rule at the named data.
Lemma C0 and Theorem C1 (§5): the object-level twist identity F_tw = (−1)^a F, and |E X| ≤ ‖X‖ ‖λ − τ_V*λ‖_TV for every centre-odd coarse
observable — a measure-weighted bound with no environment supremum, global, and refusing the Ising mixture as a sound bound must.
Proposition C2′ (§7.4): for a pure centre-odd coupling with Haar marginals, ρ = σ₁(K)/4, ρ/C = 3π/16 universally, and ρ/T_A ∈ [3π/16, 9π²/64]
with the ends characterised (rank one; orthogonal).

**Read (exact finite objects, double precision, two roads where marked; planar geometry unless "true bent").** The two-step planar coupling at
W4L1: ρ = 0.046755 (cancelling) / 0.039579 (ordered), 20ρ = 0.935 / 0.792, cap steps ×1.20 / ×1.23 after ×2.22 / ×2.11, the geometric tail
×1.040 / ×1.059 — the same step law U(1)'s converged charge ladder obeys (×1.15–1.23, then ×1.01–1.02); U(1)'s converged two-step sums 1.31–2.96.
The coupling is ≥ 99.98 % centre-odd and near-isotropic (ρ/T = 0.64–0.71): the vector channel of the relative holonomy across the shared edge.
The blocked one-plaquette coupling at the pinned data is NOT converged in the cap and the cap raises it: β_eff 0.292 → 0.491 → 0.565 (ordered),
0.222 → 0.305 → 0.374 (cancelling) at W2, W3, W4; the W2L2 evidence for a two-step landing in Theorem 8.9's region is a cap artefact.

**The next object, and its instrument.** By Theorem A1 the coarse-environment supremum stays; what the readings have never taken is the
supremum, over COARSE environments, of the coefficient with the FINE outside INTEGRATED. The instrument is the coarse-conditioned object: the
integrated-ring engine (w2f.c, W2_FRAME) with the neighbouring coarse loops IMPOSED by Fourier delta insertions Σ_a d_a χ_a(C g⁻¹) (truncated
at the loop cap) instead of pinned fine data — the frame plaquettes carry the neighbouring coarse plaquettes' interiors, so their boundary loops
are cycles the engine already knows how to read. Its first test: the two-step blocked a′_½ and the adjacent coupling at the most aligned coarse
environment, against Theorem 8.9's 0.4764, beside U(1) at 1.2. And M4's (W-V) (M5's), the twisted fibre's forgetting of a 't Hooft insertion at
a_c/2, is what Theorem C1 needs to turn the coarse twist distinguishability into a number.

**Cross-field.** (1) Theorem A1 is the lattice form of a fact Markov-chain theory already knows: conductance is governed by bottlenecks, and a
bottleneck sits on configurations of vanishing probability (Cheeger); a criterion blind to rare configurations cannot see a bottleneck. The
chessboard estimate's dual role makes it exact here: the inequality that PROVES order cannot PRICE disorder. (2) Proposition C2′ is canonical
correlation analysis on S³: the shape of a centre-odd coupling is the singular-value profile of a 4 × 4 bilinear form, with the Ising-like
(trace × trace, rank one) and the rotor-like (u·v, orthogonal) couplings at the two ends. The two-step reading sits at the rotor end: at the scale
4a from β = 2.2 the blocked SU(2) theory couples adjacent coarse plaquette holonomies as the O(4) σ-model couples neighbouring spins, ε u·v with
ε = 4ρ, and 20ρ < 1 is that model's Dobrushin condition in the L² currency. (3) Theorem C1 is the Tomboulis–Yaffe vortex inequality read at the
coarse scale and in total variation: confinement as the indistinguishability of a configuration from its centre-twisted image.
