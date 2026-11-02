
---

## 8. THE TURÁN SLAVING THEOREM: ON CONVOLUTION COUPLINGS THE SO(3) CHANNEL IS AT MOST THE SQUARE OF THE VORTEX CHANNEL

**Theorem 8.1.** Let K be a continuous, positive-definite class function on SU(2) with K ≥ 0, ∫K dU = 1, and κ_j :=
(1/d_j)∫ K χ_j dU (κ_0 = 1, 0 ≤ κ_j ≤ 1). Let (U, V) have the CONVOLUTION law K(UV⁻¹) dU dV (Haar marginals).
(a) The conditional expectation f ↦ E[f(U) | V] acts on the spin-j isotypic subspace of L²(SU(2)) as multiplication by κ_j.
Hence ρ = sup_{j ≥ ½} κ_j, the SO(3) channel ρ̃ = sup_{j ∈ {1, 2, …}} κ_j, and the vortex (half-integer) channel sup_{j ∈ ℕ+½} κ_j.
(b) THE TURÁN CLASS 𝒯: all κ_j > 0 and n ↦ κ_{n/2} log-concave. For K ∈ 𝒯, κ_{n/2} ≤ κ_½^n for every n, so ρ = κ_½ (the vortex
channel) and ρ̃ = κ_1 ≤ κ_½² = ρ²: THE SO(3) CHANNEL IS AT MOST THE SQUARE OF THE VORTEX CHANNEL.
(c) 𝒯 is closed under convolution, and contains every Wilson weight e^{½β tr U}/Z, β > 0, for which κ_j = I_{2j+1}(β)/I_1(β).
(d) The same holds for U(1) with κ_n = (1/2π)∫K cos(nθ) dθ and the Wilson (von Mises) weight κ_n = I_n(β)/I_0(β): the charge-2
channel is at most the square of the charge-1 channel. Slaving is group-blind.
(e) A centre-blind weight is maximally outside 𝒯: e^{β_a χ_1} has κ_½ = 0 < κ_1.
*Proof.* (a) K = Σ_j d_j κ_j χ_j (Peter–Weyl for class functions), and Schur orthogonality gives ∫ χ_{j′}(UV⁻¹) D^j_{rq}(U) dU =
δ_{jj′} D^j_{rq}(V)/d_j, so ∫ K(UV⁻¹) f(U) dU = κ_j f(V) for f in the spin-j span. The operator is self-adjoint (K(g⁻¹) = K(g):
χ_j(g⁻¹) = conj χ_j(g) = χ_j(g)), its norm on L²₀ is sup_{j≥½} κ_j, and centre-even (odd) functions are the integer (half-integer)
spins. (b) Log-concavity makes the ratios r_n = κ_{n/2}/κ_{(n−1)/2} nonincreasing, r_1 = κ_½, so κ_{n/2} = Π_{k≤n} r_k ≤ κ_½^n.
(c) Convolution multiplies coefficients, κ_j(K₁*K₂) = κ_j(K₁)κ_j(K₂) (centrality and Schur), and a coefficientwise product of
positive log-concave sequences is log-concave. For Wilson's weight κ_j = I_{2j+1}(β)/I_1(β) (the character expansion of THE
GROUND §8.3, its a_j), and n ↦ I_n(β) is log-concave: by the product formula THE GROUND quotes in Lemma 8.6,
I_μ I_ν = Σ_k (β/2)^{μ+ν+2k} (μ+ν+2k)!/(k!(μ+k)!(ν+k)!(μ+ν+k)!), the pairs (n+1, n+1) and (n, n+2) share μ + ν and the factor
(μ+ν+2k)!/(k!(μ+ν+k)!), and 1/((n+1+k)!)² − 1/((n+k)!(n+2+k)!) = [1/((n+k)!(n+1+k)!)]·[1/(n+1+k) − 1/(n+2+k)] > 0, so every
coefficient of I_{n+1}² − I_n I_{n+2} is positive. (d) The same argument with Fourier series and I_n/I_0. (e) χ_1 is centre-even. ∎
**Numbers** (rec/turan_check.txt; double precision, a reading of the closed form): κ_1/κ_½² = 0.66681, 0.66978, 0.67989, 0.72074,
0.72471, 0.75268, 0.82042, 0.90227 at β = 0.1, 0.4764, 1, 2.2, 2.3, 3, 5, 10 (κ_½(2.2) = 0.464479025, the record's c₁); U(1):
0.50042 … 0.90047. The strong-coupling limit 2/3 and the weak-coupling limit 1 bracket every Wilson convolution.

**The same inequality, twice.** Turán's inequality I_2² ≥ I_1 I_3 is what gives φ″ ≤ ¼ in THE GROUND's Lemma 8.6 — the vMF
covariance bound behind the strong-coupling Dobrushin constant of Theorem 8.7 — and the log-concavity of n ↦ I_n is what slaves
the SO(3) channel to the vortex channel here. ONE INEQUALITY GOVERNS THE STRONG-COUPLING CONSTANT AND THE CHANNEL HIERARCHY.

**What it buys, and where it must stop.** Convolution couplings are the direct couplings of exact two-dimensional blocking and of
the Migdal–Kadanoff decimation step; on them the SO(3) half of Theorem 3.3 is at most the square of the vortex half. The readings
of §7 show the pinned objects' DIRECT couplings at two steps from 2.2 satisfying ρ_EE ≤ ρ_OO² with ratios 0.069–0.28 — below even
the Wilson convolution's 0.72 at 2.2 — while the one-step ordered cells (1.85–3.26) do not: the objects' direct coupling enters a
Turán-like regime between the first and second step. And the theorem marks exactly where the SO(3) half escapes: the physical
glueball exchange through the fibre decays like exp(−m a_c), the vortex coupling like exp(−σa_c²) (area), so at large a_c
exp(−m a_c) ≫ exp(−2σa_c²) and NO slaving can hold for the full blocked coupling. The non-slaved SO(3) coupling is therefore the
outside-mediated covariance of §7 (4) — not a direct coupling at all — and an adjoint-rich bare or blocked action (the Bhanot–
Creutz endpoint's basin) is a departure from 𝒯 by (e).

---

## 9. THE WINDOW'S LEMMA IN ITS EXACT MINIMAL FORM; THE PER-STEP ANSWER; THE UNIFICATIONS

**Lemma W (the exit at one coarse scale a_c reached from β ∈ [2.2, 2.3], in two channels).** For the holonomy-blocked SU(2)
measure at a_c (straight paths; coarse sites with their four coarse links):
(W-V) THE VORTEX HALF — the twisted fibre forgets an elementary 't Hooft insertion at distance a_c/2: for every coarse v, every
coarse link m with midpoint free link f and every coarse site z adjacent to y, sup_s |E_{ν^f(·|v(s))}Φ_s − E_{ν(·|v(s))}Φ_s| ≤ δ_V,
where Φ_s is the coarse force at z (|Φ_s| ≤ 6β). Then (Theorem 4.1's integration: s₁ ≤ π per coarse link at z, four links at
z) the centre-direction mixed difference of a one-link flip at y is ≤ 4πδ_V, a flip of j links at y telescopes into j one-link
flips, so for the full Γ_y = Z₂⁴: T(y, z) ≤ 2 sinh(16π δ_V) (2 sinh(4πδ_V) when only one coarse link at y carries the label);
under a fibre Dobrushin condition δ_V ≤ 2·6β·19²e^{−κ_f(a_c/2−1)}/(1 − α_f).
(W-S) THE SO(3) HALF — the integer-spin channel of the coarse conditional law, which by Lemma 7.1 of M2 applied to the SO(3)
projections splits as ρ̃_ξ(A,B) ≤ √(M̃_A M̃_B) E_ν[ρ̃_ω(A,B)] + ρ_ξ(Ã; ω)ρ_ξ(B̃; ω): a DIRECT part (Turán-slaved on convolution
couplings, Theorem 8.1; read at ≤ 0.9 % of the direct coupling at two steps, §7) and the OUTSIDE-MEDIATED COVARIANCE, whose sharp
form is S_ξ(A, B) := sup over centred unit-variance SO(3)-functions f, g of |Cov_{ν₀(·|ξ)}(E_ω[f(Ã)], E_ω[g(B̃)])| — the
covariance, over the fine outside under its true law, of the pinned objects' SO(3)-content means: the scalar glueball exchanged
across one block. Require R̃(y, z) ≤ δ_S(y, z).
CONCLUSION: if Σ_z (δ_S(y,z) + T(y,z) + T(z,y)) e^{κ|y−z|} ≤ α < 1 for every y, then Hypothesis I-L² holds at a_c (Theorem
3.3), and with Hypothesis II-L² (M3's interface below a_UV, the window's own fibre above it) every limit point has a unique vacuum
and a gap ≥ min(κ, log 1/ρ′)/a_c (M2's Theorem 3.1). Both halves are NECESSARY in the sense of Theorem 3.3 (R̃ ≤ R) and Theorem
5.1 (the vortex half cannot stand in for the SO(3) half).

**The per-step answer to the orchestrator's criterion (§1b, completed).** Route 1's identities lose nothing per step (Theorem 2.1
at every scale; Proposition 2.2 non-expansive); the group difference is the per-step CONTRACTION of the vortex free energy, which
at one loop is g²(L)/g²(2L) = 1 − c(2)/β_eff, c(2) = 0.25752, for SU(2) and 1 for U(1); the SO(3) half's coupling runs with the
same g² (one Lie algebra), and U(1)/Z₂ ≅ U(1) does not run. So the step that must carry the group is a ONE-SIDED per-step bound
β_eff(k+1) ≤ β_eff(k) − c(2) + δ_k with δ_k ≥ 0: it refuses U(1) at every depth by construction (drift 0), and drives SU(2) from
2.2 to β_exit ≈ 0.45 in K steps iff Σ_k(c(2) − δ_k) ≥ 1.75 — at one loop's drift δ < 0.039 per step over eight steps; the
hierarchical comparison loses δ = 0.40 at rung 1 (2.34 against 1.94). Route 2's landing chain has the same admissible loss.
The pinned objects read the odd channel contracting ×0.14–0.36 per step for SU(2) against ×0.28–0.67 for U(1) at the same data
(§7) — the groups part in the vortex half by a factor 2–3 per step at fixed data; a reading at two rungs, never extrapolated.

**THE NEXT OBJECT, precisely.** The outside-mediated SO(3) covariance S_ξ(A, B) at two steps from 2.2 — the one quantity of
Lemma W that no pinned object reads, the scalar-glueball channel of the coarse coupling. First exact test: the two-face object with
a ring of outside links INTEGRATED rather than pinned, read in the integer-spin channel beside the pinned value (the stake: the
SO(3) share rises from ≤ 0.9 % toward the odd channel's size as the integrated ring widens; U(1)'s rises too, and only the
vortex half parts the groups). M2b's outside-mediated variance run is this quantity's consumer in the full (all-channel) form; the
channel split of §6 applied to its records gives (W-S) directly. Its partner (W-V) is a fibre statement whose first finite test is
the same object with one elementary twist inserted at the midpoint of a coarse path, read as the response of the force at the
neighbouring path (Theorem 4.1's integrand, exact on the engine).

**The cross-field unifications found.**
1. HARMONIC ANALYSIS / LANCASTER–GEBELEIN: the maximal correlation of a group-valued pair decomposes over the characters of the
 centre, the even part being the quotient group's (SO(3)) correlation; for convolution couplings it is diagonal in Peter–Weyl
 (Theorem 8.1), the information-theoretic χ²-contraction of a Markov kernel channel by channel.
2. 't HOOFT DUALITY, MADE EXACT AND CONDITIONAL: the coarse centre label is conjugate to the closed 't Hooft surface operator of
 the fibre (Theorem 2.1); F = −log ν(B_η|v) is the conditional magnetic-flux free energy; Proposition 2.2 is its renormalisation
 group — an exact averaging, lossless, whose contraction rate is the running coupling (asymptotic freedom read as vortex
 condensation's rate).
3. SUPERCRITICAL CROSSOVERS: the SU(2) Wilson crossover is the Widom line of the fundamental–adjoint endpoint (the liquid–gas
 endpoint's statistical mechanics, Ising-like or tricritical by Grady): the light direction is the centre-EVEN 0⁺⁺, exactly the
 half the centre cannot see — and the strategic lever it names: the continuum limit is universal, so a construction may choose an
 adjoint-poor (Turán-class) bare action steering away from the endpoint, provided reflection positivity (nonnegative character
 coefficients) is kept.
4. TURÁN'S INEQUALITY: one Bessel inequality gives THE GROUND's strong-coupling constant (Lemma 8.6) and the slaving of the SO(3)
 channel to the vortex channel (Theorem 8.1).

---

## 10. WHAT THIS FILE PROVES, COMPUTES, AND LEAVES (the summary, written last)

PROVED (full proofs above): Theorem 2.1 (the twist identity: a coarse centre flip of the blocked measure is the fibre
expectation of a closed 't Hooft surface, F = −log ν(B_f|v), representative-independent, for path and averaged block maps);
Proposition 2.2 (the vortex recursion e^{−F_{k+1}} = E[e^{−F_k} | coarser], exact and non-expansive); Lemma 3.1 (ρ̃ ≤ ρ ≤
(ρ̃² + τ_X² + τ_Y²)^{1/2} for any law on spaces with free finite group actions) and Lemma 3.2 (τ by the label free energy:
¼ osc F cosh(½ sup|F|) for Z₂, 2 sinh Δ in general); Theorem 3.3 (HYPOTHESIS I-L² IN TWO CHANNELS: R̃ ≤ R ≤ (R̃² + T² + T′²)^{1/2},
the SO(3) channel necessary and, with the vortex sensitivity, sufficient; the vortex part is THE GROUND's mixed difference
restricted to centre orbits); Theorem 4.1 (the vortex half from the fibre: a twisted-fibre response at distance a_c/2, explicit
under a fibre Dobrushin condition); Theorem 5.1 (no-go: centre-blind actions have τ ≡ 0 and R = R̃, and by van Enter–Shlosman a
centre-blind SU(2) action with a non-differentiable free energy defeats Hypotheses I-L² + II-L² uniformly near the transition at
every scale — the SO(3) half is independent); Theorem 5.2 (U(1): the whole group central, the twist identity for every e^{iα});
Theorem 8.1 (Turán slaving on convolution couplings, Wilson weights in the class at every β, closed under convolution).
COMPUTED (rec/chan_*.txt, rec/kat_synthetic.txt, rec/turan_check.txt; all known answers met; planar geometry only): on every
pinned object at two steps from 2.2 the direct coupling is ≥ 99.37 % vortex-channel, the SO(3) share ≤ 0.87 %, slaved below the
square (0.069–0.28); the exact block bound meets ρ to 10⁻⁵; the free-energy bound costs the leading mode's 2√2; per step the odd
channel contracts ×0.14–0.36 (SU(2)) against ×0.28–0.67 (U(1)), the even ×0.003–0.011 against ×0.005–0.026.
LEFT: Lemma W — (W-S) the outside-mediated SO(3) covariance at the exit scale (the scalar glueball across one block; the next
object, with its first exact test named) and (W-V) the twisted fibre's forgetting at distance a_c/2; and the one-sided per-step
bound with δ_k below the drift c(2) − 1.75/K that would reach the exit scale from 2.2.
