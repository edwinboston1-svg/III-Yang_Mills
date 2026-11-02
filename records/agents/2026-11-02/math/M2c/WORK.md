# M2c — HYPOTHESIS I ITSELF AT TWO STEPS: THE WHOLE FIRST RING INTEGRATED, THE COARSE ENVIRONMENT IMPOSED, ITS SUPREMUM

Proof agent M2c, 2026-11-02 (opened 09:1x EST). Read-only in both repositories; every engine and record is a copy in this directory
(`code/`, `rec/`). Strength labels: PROVED (proof on this page) / CERTIFIED (outward-rounded or exact arithmetic) / READING (exact finite
object in double precision at stated truncations) / OPEN. Stakes are written before the runs they grade and are not edited after.

## 0. Sources, the staging finding, the design

**Read in full before deriving:** MATH_BRIEF.md; M2b/WORK.md (all 681 lines: Theorem A1, Corollary A1′, Lemma A2, Lemma C0, Theorem C1,
Propositions C2, C2′, C2″, W-S1, W-S2, W-S3, §7 readings, §8); M2/WORK.md (all 507 lines: Proposition 1.1, Lemma 2.1, Proposition 2.2,
Theorem 2.3 — THE L² COVARIANCE THEOREM, Proposition 2.5, Theorem 3.1 — THEOREM 8.5-L², Theorem 4.1, Lemmas 5.1, 7.1, 7.2); THE GROUND §§7.2–8.3
(cross/ground_docx.txt: Theorem 7.1, Lemma 7.3, Theorem 7.4, Propositions 8.1–8.4, Hypotheses I–II, Theorem 8.5 with its proof, Lemma 8.6);
THE CROSSING CAMPAIGN §14 (the (8.5) instrument on the two-face object, its standing: "an integrand, never a decider"); M7b/WORK.md §§0–2b
(THE STAPLES ARE THE CAP: with staples exact the one-step face cap converges to 0.3 % at W_f = 3, 0.013 % at W_f = 4); the engine M2b
code/w2f.c (sha256 f7c5696f…, = w2_strip_n.c + M2b's frame, corner, lean, nosnap, weight0, clamp, twist doors), copied to
code/w2f.orig.c; the reader M2b code/l2dob.c (sha256 8c477abc…), copied to code/l2dob.orig.c; M7b's exact-staple door (code/w2x.c, its
three hunks against HEAD).

**The object (Hypothesis I in M2's L² currency, Theorem 3.1).** R(y, z) = ess sup over the coarse environment ξ of the maximal correlation
ρ_ξ(v_y, v_z) under the blocked measure's conditional law given ξ, the fine field INTEGRATED; Hypothesis I-L²: Σ_z R(y, z) e^{κ|y−z|} ≤ α < 1.
The record's variables are the coarse plaquette LOOPS (two adjacent 4×4 loops A, B at two steps, n = 4), read on the two-face object with
the fine outside PINNED at a datum ω — an integrand (campaign §14). M2b's next object: the pair with its WHOLE first ring integrated and the
coarse environment imposed, read in every channel, taken to its supremum over coarse environments.

**THE STAGING FINDING (09:2x, rec: below; code/w2s.c = w2f.orig.c with MAXL 128 → 256 and the two arrays sized by it).** M2b's refusal
of the four-sided ring at n = 4 ("too many links") was the LINK TABLE (MAXL = 128; the 10 × 6 region has 136 links), not memory. Dry-staged
under M2b's own lean sliced weight-0 path (W2_DRY=1 W2_SLICE=full W2_LEAN=1 W2_NOSNAP=1 W2_WEIGHT0=1), two steps, planar, W2L1:

| frame (rt,rb,rl,rr) at n = 4 | plaquettes / links | max state (entries) | peak memory | multiply-adds |
|---|---|---|---|---|
| (1,1,1,1) the whole in-plane first ring, corners included | 60 / 136 | 6.02 × 10⁷ | 1.070 GB | 3.65 × 10¹¹ |
| (1,1,0,0) above and below | 48 / 110 | 6.02 × 10⁷ | 1.070 GB | 3.00 × 10¹¹ |
| (0,0,1,1) the two side columns | 40 / 94 | 3.07 × 10⁵ | 0.006 GB | 1.35 × 10⁹ |

At M2b's measured 5.6 × 10⁸ multiply-adds per second the whole ring is about 11 minutes a datum. The SO(3) channel needs L2 (even a = c = 2);
staged separately below.

**THE DESIGN (after the advisor's review, 09:3x).**
(D1) The ring at W2L1 with the record's TRUNCATED staples, both named data: byte-comparable to M2b's per-plaquette law, so its stake is M2b's
arithmetic. (D2) M7b's exact-staple door added (W2_EXACT, W2_DEGX; reuse, not duplication), then the ring at W2L1 exact, the core at
W2/W3/W4 L1 exact, and the one-step ring (n = 2) at W2/W3/W4 exact, so that the face-cap factor is read with and without the ring.
(D3) THE COARSE ENVIRONMENT, imposed exactly and contracted post hoc: each in-plane neighbouring coarse loop N's IN-OBJECT path h_N (for the
top neighbour of A: the ring rung at x = 0, A's top edge, the ring rung at x = 4 — six integrated links) becomes a CHAIN cycle whose two end
wires are junction wires (clamped per slice, closed only in the final tensor), so one run yields F^{ace} = E[D^a(A) ⊗ D^c(B) ⊗ D^e(h_N)] for
e ≤ L_N, and EVERY coarse value C of N follows by contraction. The rest of N's loop (its exterior part R, outside the integrated region) is
modelled as an independent central element with profile t_e = E[χ_e(R)]/d_e, so that p(A, B | H_N = C) ∝ Σ_e d_e t_e Σ_{pq} D^e(C)_{qp}
F^{ace}_{pq}[h_N⁻¹] — a HYBRID, labelled as one: N's interior is pinned and R is independent of the object; the profile is read at a rigid
end (t_e = 1: N's exterior pinned) and at softer ends, so the sensitivity is visible. (D4) THE SUPREMUM over one neighbour's coarse value: at
the ordered datum global conjugation fixes the datum, so ρ(C) depends on the class angle of C alone (Lemma E1 below); the supremum over the
angle is taken on an explicit grid with a PROVED Lipschitz bound on the rest (Lemma E2 below). A joint supremum over all neighbours is not
claimed unless reached. (D5) Three steps: the count is given; M7b's supplied-coefficient road is the instrument there.

## 1. THE STAKES FOR THE WHOLE-RING RUNS (written 09:3x before any run; not edited after)

Base values (M2b's records, two steps, planar, pinned, W2L1, truncated staples): ρ = 0.015308357 (ordered), 0.017496636 (cancelling);
E[χ_½(A)] = 0.14557 (W2L2 ordered; the L1 run prints its own), 0.11071 (cancelling).
M2b's per-plaquette law (§7.7): an integrated in-plane plaquette sharing an edge with the object multiplies the full coupling by 0.9919 (top
row) / 0.99187 (side column) at n = 4, two steps; the loop expectation of the loop it touches by 0.9683 per side of four; corners ≤ 0.5 %.
M2b's arithmetic for the whole first ring of the two-step pair (24 edge-adjacent plaquettes): ×0.8236 (ordered), ×0.8220 (cancelling).

- **SR1 (the ring factor on ρ).** ρ_ring / ρ_pin ∈ [0.80, 0.85] at both data (centre 0.823). KILL: outside [0.75, 0.90] — the per-plaquette
  law does not compose to the whole ring at two steps, and M2b's arithmetic (0.86–0.89 / 0.73–0.77 for the true row) is withdrawn.
- **SR2 (the loops' alignment).** E[χ_½(A)]_ring / E_pin ∈ [0.89, 0.93] (each loop touched by 12 edge-adjacent ring plaquettes, 0.9683³ =
  0.908), the same for B.
- **SR3 (the factorization).** κ := ρ/(m_A m_B), m = E[χ_½]/2, unmoved by the ring: κ_ring/κ_pin ∈ [0.99, 1.01] at both data (M2b read
  0.03–0.1 % on partial rings).
- **SR4 (the planar row).** 20ρ_ring at W2L1: 0.252 (ordered) / 0.288 (cancelling) at the centre; the true-row arithmetic at the cap limit is
  then M2b's ×0.82.

## 2. THE COORDINATOR'S GATE (10:0x): THE U(1) CONTROL, STAKED BEFORE ANY NUMBER

**The gate.** The ring-integrated row at its environment supremum decides only if the SAME construction refuses U(1) — row ≥ 1 — at two,
three and four steps, at Wilson β = 1.2 (gapless by numerics, the transition near 1.011: EVIDENCE) and inside a regime PROVED gapless for the
action a theorem covers (REFUTATION if the construction passes there). Truncations must be positive (checked 10:0x, rec below: at β = 2.2 W2
min +0.0710, W3 SIGNED −0.1050, W4 +0.0868; W2 is SIGNED at β = 2.5 (−0.0204); U(1) at 1.2 needs a charge cap N ≥ 2 (N1 −0.0256)). R1 uses W2
at 2.2: positive.

**The proved control: the free lattice photon.** Non-compact U(1), S = (β/2) Σ_p F_p², F = dA, is a Gaussian field whose gauge-invariant
correlations are given exactly by the lattice Green's function (Feynman gauge: ⟨A_μ(x) A_ν(y)⟩ = δ_μν G(x − y)/β, G = (−Δ)⁻¹ on ℤ⁴, gauge-
invariant moments independent of the gauge fixing): massless at EVERY β, a theorem with no β₀. It is also the spin-wave part of the Villain
model, exactly (Poisson resummation: Villain U(1) = this Gaussian × a Coulomb gas of integer monopole loops), the regime of Fröhlich–Spencer
(1982) at large β_V. Every quantity below is computed EXACTLY for it (linear algebra and a one-dimensional Bessel integral), at n = 2, 4, 8,
16 (one to four steps), with the coarse variables in TWO forms: the non-compact flux Φ_A = Σ_{p∈A} F_p (a real variable) and the compact
holonomy e^{iΦ_A} (the construction's variable: a wrapped Gaussian).

**THE DESK DERIVATION (before the code).** For an n × n coarse loop the flux is the circulation of A around ∂A, so in the true measure
Var Φ_A = (1/β) Σ_{ℓ,ℓ'∈∂A} s_ℓ s_ℓ' δ_{dir} G(x_ℓ − x_ℓ') = (1/β)(4n g + O(1)), g = G(0) + 2 Σ_{k≥1} G(k e₁) (the line sum converges in 4D): the
PERIMETER LAW, a UV self-energy growing linearly in n. Two edge-adjacent loops share n links with opposite orientation, so Cov(Φ_A, Φ_B) =
−(1/β)(n g + O(1)) and the non-compact correlation r → −1/4. For the compact holonomies, the joint law is a bivariate WRAPPED normal; its
maximal correlation is that of the Fourier modes, ρ_wr ≈ e^{−σ²(1 − |r|)} once σ² = Var Φ_A ≳ 1 (the k = l = 1 entry e^{−σ²}(e^{|c|} − 1) of
the cross-covariance, every other entry smaller). So in the compact variable the photon's adjacent coupling DECAYS EXPONENTIALLY IN THE
BLOCK SIZE, at every β, at the rate (3/4)(4g/β) per fine unit — and this is a property of the TRUE measure, not of a pinned datum.

**STAKES (written before photon.c exists; not edited after).**
- **SP1 (the KATs).** G(0) = 0.1549334 (the 4D lattice Green's function, = P(0)/8 with P(0) = 1.2394671), G(e₁) = G(0) − 1/8 = 0.0299334.
  The wrapped reader returns |r| at small σ and e^{−σ²(1−|r|)}(1 + o(1)) at large σ. The pinned Gaussian object at n = 2 has the record's
  geometry (core, staples pinned) and its non-compact correlation is datum-independent (a Gaussian's conditional covariance does not see the
  conditioning values).
- **SP2 (non-compact, true measure).** |r_planar| ∈ [0.20, 0.27] at every n ≥ 2, → 1/4; the edge-adjacent row 4|r_pl| + 16|r_bent| ≥ 1 at
  every n (UNGUESSED size of r_bent; staked in [0.15, 0.30]). In the flux variable the construction REFUSES the photon at every step.
- **SP3 (compact, true measure, the decider's variable).** At β_V = 0.749 (the Villain coupling matched to Wilson 1.2 by I₁/I₀ = e^{−1/(2β_V)}):
  the edge-adjacent row is ≥ 1 at n = 2 and 4 and FALLS BELOW ONE by n = 8 (three steps), and is below 0.01 at n = 16. In the proved regime
  (β_V = 10): ≥ 1 at n ≤ 16 (σ² stays O(1)), and below one at large enough n (n ≳ β_V/g-scale; the crossing n printed). KILL of the
  derivation: if the compact true-measure row stays ≥ 1 at n = 8 and 16 at β_V = 0.749, the wrapping mechanism is not what drives the
  record's U(1) flow, and §2's diagnosis is withdrawn.
- **SP4 (the pinned object against the true measure).** The pinned planar object (exterior pinned at 0, staples as link masses) gives a
  SMALLER σ² than the true measure (pinning suppresses fluctuations: masses 4–5 per link) and the same r → −1/4; so the pinned compact row lies
  ABOVE the true compact row at each n, and integrating the in-plane ring moves it by a boundary factor that converges at the first ring (the
  in-plane field is massive with the out-of-plane exterior pinned). Consequence staked: no width of in-plane ring makes the pinned object
  approach the true measure; only integrating the out-of-plane exterior does.
- **SP5 (the conclusion this file will state if SP3 holds).** An adjacent-pair row in compact holonomy variables cannot refuse a gapless
  abelian theory at enough steps: the refusal of the photon lives in the row's TAIL and in the non-compact content of the coarse field, which
  the holonomy's maximal correlation discards once the perimeter self-energy wraps it. The construction then needs (i) coarse variables that
  do not wrap (averaged block fields in Bałaban's sense, not path holonomies), (ii) the exterior integrated in all four directions, and (iii)
  the full row (all distances) — because for a gapless Gaussian the conditional-correlation row is exactly marginal (Lemma P below), so any
  finite-range truncation passes it.

### 2.1 RESULTS OF THE PHOTON CONTROL (code/photon.c; rec/photon/{kat,true,pinned,tail}.txt; 10:1x–10:2x)

Exact computations in double precision on an exactly solvable model (the Bessel integral to 3 × 10⁻¹⁰; the wrapped reader on a 256- or
512-point grid): READINGS of that model. The model's masslessness is a theorem.

KATs, all MET: G(0) = 0.1549333900 (known 0.1549334); G(0) − G(e₁) = 0.1249999997 (1/8); (−ΔG)(e₁) = 2.8 × 10⁻¹⁰; G(20e₁) = 6.349 × 10⁻⁵
against the continuum 1/(4π²r²) = 6.333 × 10⁻⁵; the wrapped reader returns 0.300000 at σ² = 0.01, r = 0.3 (= |r|), and 1.158015 × 10⁻³ at
σ² = 9, r = 0.25, which is the top singular value of the 2 × 2 Fourier block {k, l = ±1}, e^{−9}(e^{±2.25} − 1), to the printed digits;
β Var Φ_A = 1/2 exactly at n = 1 (4D equipartition: three physical modes per site shared by six plaquettes).

**THE TRUE MEASURE (the exterior integrated in all four directions, infinite volume).** σ² = Var Φ_A = (β Var)/β_V. Rows are the edge-adjacent
rows 4ρ_planar + 16ρ_bent (the record's twenty pairs).

| n (steps) | β·Var Φ_A | r_planar, r_bent (flux) | flux row | compact row β_V = 0.749 (≈ Wilson 1.2) | β_V = 2 | β_V = 5 | β_V = 10 | β_V = 20 |
|---|---|---|---|---|---|---|---|---|
| 1 (0) | 0.500 | −0.1377, −0.2156 | 4.000 | 3.978 | 4.000 | 4.000 | 4.000 | 4.000 |
| 2 (1) | 1.369 | −0.1826, −0.2388 | 4.551 | 3.113 | 4.521 | 4.551 | 4.551 | 4.551 |
| 4 (2) | 3.261 | −0.2111, −0.2464 | 4.787 | **0.647** | 3.619 | 4.765 | 4.787 | 4.787 |
| 8 (3) | 7.168 | −0.2275, −0.2485 | 4.886 | **0.0144** | 1.130 | 4.034 | 4.843 | 4.886 |
| 16 (4) | 15.115 | −0.2370, −0.2493 | 4.937 | **5.0 × 10⁻⁶** | **0.0659** | 1.660 | 3.944 | 4.878 |

β·Var Φ_A grows linearly, slope 0.993 per fine unit between n = 8 and 16: THE PERIMETER LAW, in the true measure of a massless theory.

**THE PINNED GAUSSIAN OBJECT (every plaquette touching an integrated link kept, its other links pinned at 0; the record's geometry at w = 0).**
At β_V = 0.749, compact ρ_planar (the non-compact r in brackets):

| n | pinned w = 0 | ring w = 1 | ring w = 2 | pinned bent | TRUE planar |
|---|---|---|---|---|---|
| 2 | 0.1668 (−0.2125) | 0.1589 (−0.2070) | 0.1587 | 0.1964 (−0.2485) | 0.1238 (−0.1826) |
| 4 | 0.0608 (−0.2365) | 0.0557 (−0.2311) | 0.0555 | 0.0670 (−0.2547) | 0.0274 (−0.2111) |
| 8 | 4.57 × 10⁻³ (−0.2465) | 3.86 × 10⁻³ | 3.84 × 10⁻³ | 4.92 × 10⁻³ | 6.1 × 10⁻⁴ (−0.2275) |
| 16 | 1.93 × 10⁻⁵ (−0.2511) | 1.39 × 10⁻⁵ | 1.37 × 10⁻⁵ | 2.07 × 10⁻⁵ | 2.1 × 10⁻⁷ (−0.2370) |

The in-plane ring multiplies the compact coupling by 0.915 (n = 4) and converges at the first ring (w = 2 adds ×0.998): with the out-of-plane
exterior pinned the in-plane field is massive. The pinned compact coupling exceeds the true one by ×2.2 (n = 4), ×7.5 (n = 8), ×92 (n = 16):
PINNING SUPPRESSES THE FLUCTUATION THAT WRAPS THE HOLONOMY. The pinned compact row at β_V = 0.749, n = 4 is 4(0.0608) + 16(0.0670) = 1.31
against the true 0.647. The record's compact U(1) pinned rows at Wilson 1.2, n = 4, are 2.40 / 2.96 (M2): the record's refusal of U(1) at two
steps belongs to the pinned datum.

**THE TAIL (true measure, n = 4, parallel coarse loops displaced R in z):** r = 1.44 × 10⁻², 1.54 × 10⁻³, 3.45 × 10⁻⁴, 1.14 × 10⁻⁴ at R = 4,
8, 12, 16, with R⁴ r → 7.5 (n = 8: R⁴ r → 54, ∝ n³). The photon's pairwise couplings decay as R⁻⁴ and the coarse shell at distance k holds
~k³ coarse plaquettes, so the pairwise row Σ_k k³ · k⁻⁴ diverges LOGARITHMICALLY with the volume in both variables (the compact one carrying the
factor ρ_wr/r = 0.113 at n = 4, β_V = 0.749). The photon is refused by the TAIL and only by it.

**THE STAKES GRADED.** SP1 MET (all KATs). SP2: the row half HELD (flux row ≥ 1 at every n: 4.00 → 4.94 → 5). The band [0.20, 0.27] for
|r_planar| HELD at n ≥ 4 and is REFUTED at n = 2 (0.1826). **SP3 REFUTED, IN THE STRONG DIRECTION: the compact true-measure row at the matched
coupling is already below one at n = 4 (0.647), two steps, not first at n = 8** (0.0144 there, 5 × 10⁻⁶ at n = 16). In the proved regime it
is ≥ 1 through n = 16 at β_V = 5, 10, 20 and falls below one once σ² ≳ 3.7 (β_V = 2: 1.130 at n = 8, 0.0659 at n = 16), i.e. at n ≈ 4β_V.
The KILL did not fire (the compact row fell). SP4 HELD (pinned above true at every n; the ring converges at w = 1; w → ∞ in-plane does not
approach the true measure). SP5's conclusion follows, §2.3.

### 2.2 THE LEMMAS (proved here)

**Lemma W (the wrapped contact term).** Let (X, Y) be bivariate normal with variances σ_X², σ_Y² and correlation r, and let ρ_wr be the
maximal correlation of (X mod 2π, Y mod 2π). Then (i) ρ_wr ≤ |r|; (ii) ρ_wr → 0 as min(σ_X, σ_Y) → ∞ at fixed |r| < 1.
*Proof.* (i) Every function of X mod 2π is a function of X, so the supremum defining ρ_wr runs over a subset of the one defining the maximal
correlation of (X, Y), which for a bivariate normal is |r| (Gebelein–Lancaster: the Hermite polynomials diagonalise the conditional expectation
with eigenvalues r^k). (ii) In the Fourier basis the cross-covariance of e^{ikX} and e^{ilY} is K_{kl} = e^{−(k²σ_X² + l²σ_Y²)/2}(e^{−klc} − 1),
c = rσ_Xσ_Y; each wrapped marginal has density 1 + O(e^{−σ²/2}) uniformly, so its Gram matrix in the Fourier basis is I + O(e^{−σ²/2}) and
ρ_wr ≤ (1 + O(e^{−σ²/2}))‖K‖. Since |K_{kl}| ≤ e^{−(k²σ_X² + l²σ_Y² − 2|kl||c|)/2} ≤ e^{−(1 − |r|)(k²σ_X² + l²σ_Y²)/2} (2|kl|σ_Xσ_Y ≤
k²σ_X² + l²σ_Y²), the Hilbert–Schmidt norm of K is at most (Σ_{k,l≠0} e^{−(1−|r|)(k²σ_X² + l²σ_Y²)/2})^{1/2}, which tends to 0. ∎

**Corollary W′ (edge-adjacent loop couplings are a contact term).** In any Gaussian model of the lattice connection whose link covariance is
summable along a line, edge-adjacent n × n loops have Var Φ_A = 4ng/β + O(1) and Cov(Φ_A, Φ_B) = −ng/β + O(1), g the line sum (the shared
edge's self-energy), so r → −1/4 whatever the mass: the flux row → 5 refuses every theory, and by Lemma W (ii) the compact row → 0 passes
every theory, as n → ∞. The edge-adjacent coupling of loop variables sharing fine links does not see the infrared. (The perimeter terms are
the double sums Σ_{ℓ,ℓ′} s_ℓ s_ℓ′ G_{ℓℓ′}; pairs of links on one side contribute ng + O(1) per side, pairs on different sides O(1) by the
summability; the shared edge enters Cov with the opposite orientation.)

**Lemma P (the sum rule: a gapless Gaussian's conditional row is marginal).** Let X be a centred Gaussian vector indexed by Λ with positive
semi-definite precision H, and let v ≥ 0 satisfy Hv = 0 with v constant and positive on a set S ⊂ Λ on which H_yy = h, and v = 0 off S. Then
for every y ∈ S, Σ_{z ∈ S, z ≠ y} |H_yz|/√(H_yy H_zz) ≥ 1, with equality iff H_yz ≤ 0 for every z ∈ S, z ≠ y.
*Proof.* (Hv)_y = 0 gives h v_y = −Σ_{z ∈ S, z ≠ y} H_yz v_z ≤ Σ |H_yz| v_z with v constant on S. For a Gaussian the conditional correlation of
X_y, X_z given the rest is −H_yz/√(H_yy H_zz), and it is also their conditional maximal correlation (Gebelein–Lancaster). ∎
For the free field R = A/(2d), row exactly 1 (M2 §4), is the equality case. A gapless theory written in good Gaussian coordinates sits AT the
margin, carried by the WHOLE row; a finite-range truncation of a quasi-local precision drops its tail and lands below one: it passes.

**Lemma M (the Markov separator of the planar object; the shape of M2b's factorization).** In the planar object (core and any in-plane frame,
all its links integrated, every other plaquette pinned), let S be the vertical links on the line x = 0. The links with x > 0 (horizontals based
at x ≥ 0, verticals at x ≥ 1) and those with x < 0 are conditionally independent given S, also after conditioning on any event measurable with
respect to one side together with S, in particular on every in-plane neighbour chain (topA, botA, rightA ⊂ {x ≥ 0} ∪ S; topB, botB, leftB ⊂
{x ≤ 0} ∪ S). Hence ρ(A, B | ξ) ≤ ρ(A, S | ξ) ρ(S, B | ξ) for every in-plane coarse environment ξ.
*Proof.* The density is a product of plaquette weights and one-link staple factors; an in-plane plaquette of the column [x, x + 1] involves only
links with abscissa in [x, x + 1], so for x ≥ 0 it is a function of the right side and S and for x + 1 ≤ 0 of the left side and S. A density
Φ₊(U₊, U_S)Φ₋(U₋, U_S) makes U₊ and U₋ conditionally independent given U_S, and a nonnegative factor depending on (U₊, U_S) or (U₋, U_S) keeps
the form. For a Markov chain F — U_S — G: Cov(f, g) = Cov(E[f | U_S], E[g | U_S]) ≤ ρ(F, U_S) ρ(U_S, G) ‖f‖₂ ‖g‖₂ for centred f, g. ∎
M2b's reading ρ = κ m_A m_B (κ unmoved by the ring) is this product with each factor proportional to its loop's alignment (R1, §3).

### 2.3 THE GATE'S VERDICT

**The construction fails the control, so it is not a decider.** The edge-adjacent row of coarse-loop HOLONOMIES — pinned, ring-integrated, or
with the whole exterior integrated — PASSES the photon, a theory gapless by theorem at every coupling. In the true measure it passes at
n ≈ 4β_V for every β_V (in the Villain model's proved Coulomb regime β_V ≥ 5 from step 5–6 on, where σ² crosses ~3.7), and at the coupling
matched to Wilson 1.2 at TWO steps already (0.647). The record's refusal of U(1) at two steps (2.40 / 2.96) belongs to the pinned datum: the
same Gaussian object pinned reads 1.31, integrated 0.65. The ring's reduction of the SU(2) coupling (×0.823, R1) is the photon's mechanism
(×0.915 per first ring at n = 4): more fluctuation, more wrapping, independent of the group.

**What the object needs to carry U(1)'s photon (each item forced by a lemma above):**
1. **Coarse variables that share no fine links** (Corollary W′: a shared edge makes the adjacent coupling a UV contact term, |r| → 1/4 in every
   Gaussian theory, massive or not). THE GROUND's block map (one SU(2) per coarse link, each fine link in exactly one coarse variable) has this
   property; the record's plaquette loops do not. In 4D the coarse plaquette holonomies are not coordinates at all: the Bianchi identity of each
   coarse cube fixes one face from the other five, so the conditional law of one coarse loop given all the others is degenerate, and a
   loop-variable row is a proxy for (8.5), never (8.5).
2. **Variables that do not wrap** (Lemma W: a holonomy along n fine links carries the path's perimeter self-energy, linear in n, β Var = 0.99 per
   fine unit for the photon, and its maximal correlations die as e^{−(1−|r|)σ²}). Averaged block fields (Bałaban's averaging, whose fluctuation
   is the infrared field's) or a complete axial gauge inside the blocks.
3. **The exterior integrated in all four directions** (pinning suppresses exactly the fluctuation that decides: ×2.2 to ×92 above; no width of
   in-plane ring approaches the true measure).
4. **The full row** (Lemma P: in good coordinates a gapless theory's conditional row is ≥ 1 by a sum rule carried by the whole row, and the
   photon's pairwise tail R⁻⁴ over shells of k³ diverges logarithmically; every finite-range truncation passes it). For SU(2) the decider is
   therefore the DEFICIT 1 − Σ_{y′} R(y, y′) e^{κ|y−y′|}, a quantity the size of the gap that must be certified with the tail controlled to that
   precision; an adjacent reading cannot decide it in either direction.

**On the currency (the coordinator's 10:2x message).** Every row in this file is M2's L² row, the conditional maximal correlation ρ, the
currency of Hypothesis I-L², sufficient for the gap with the averaged fibre clause by M2's Theorem 3.1. No moment influence enters. Its relation
to THE GROUND's TV row is M2's Proposition 2.5, ρ(y, z)² ≤ C(y|z) C(z|y): an L² row is never above the symmetrised TV row, so an L² row below one
is not a TV row below one, and an L² row above one is a TV row above one. The two-step "sup sum ≥ 1.33" is not cited (withdrawn by the
campaign's §18).

### 2.4 THE COMPACT U(1) AT WILSON 1.2, THREE STEPS, PINNED — STAKES (10:5x, before the run; not edited after)

code/w2u8.c = the record's w2_u1.c (M2b copy) with the tables enlarged (MAXL 512, MAXCYC 160, MAXSTEP 40), n <= 8, and the frontier join
parallelised (each thread its own charge vector; every entry of the new frontier written by one old entry, so the arithmetic is the serial
engine's). KAT MET (rec/u1/kat_n4_N3L3_ord*): n = 4, NMAX 3, LMAX 3, ordered: rho = 0.117466885 by both roads, the record's N3 value 0.117467.
Staged: n = 8 planar, NMAX 3 (positive at 1.2: min +0.209; dropped weight I_4/I_0 = 4.2e-3), LMAX 2; frontier 9 plaquettes, 7^9 amplitudes,
0.65 GB; about 30 minutes a datum at 8 threads.

- **SU1 (the mechanism of §2.1 at the compact theory's own pinned datum).** rho(n = 8)/rho(n = 4) < 0.3 at both data (wrapping), so the
  record's convention 20 rho falls below one at three steps: the pinned construction PASSES compact U(1) at Wilson 1.2. ALTERNATIVE, said first:
  rho(8)/rho(4) > 0.5 (the record's one-to-two-step factor x0.59 continuing) puts 20 rho above one at three steps — the pinned construction
  refuses U(1) at three steps, and §2.1's Gaussian mechanism is not the compact theory's at the pinned datum (it remains the true measure's).
- **SU2.** At NMAX 3 the n = 4 values reproduce the record (MET above); the n = 8 cap error is that of n = 4 (N3 -> N4 x1.022, M2b §7.2),
  printed beside the value, no correction applied.

**CORRECTION OF LABEL (11:0x, after the advisor's review; nothing in §2.1's numbers changes).** The table headed "THE TRUE MEASURE" in §2.1 is
the MARGINAL law of the pair — the exterior integrated with NO coarse environment imposed. Hypothesis I's R(y, z) is the CONDITIONAL maximal
correlation given the coarse environment; for a Gaussian that is the partial correlation (Schur complement), value-independent, and it is the
object of Lemma P. The conditional Gaussian row is not computed here. The gate's verdict on the SAME construction as the SU(2) rows (pinned,
in-plane ring integrated) is read from the PINNED table: compact row at β_V = 0.749 is 4(0.0608) + 16(0.0670) = 1.31 at n = 4 (two steps;
with the first ring, 4(0.0557) + 16 × (≈0.061) ≈ 1.2): REFUSES; 4(0.00457) + 16(0.00492) = 0.097 at n = 8 (three steps): PASSES;
4(1.93 × 10⁻⁵) + 16(2.07 × 10⁻⁵) = 4 × 10⁻⁴ at n = 16 (four steps): PASSES. The marginal passes already at two steps. §2.3's verdict stands at
three and four steps; at two steps the construction parts SU(2) from the photon only through DISORDER (the matched-alignment comparison, §3.2).

**Lemma V (the averaged flux of the free photon has the plaquette's variance at every block size).** For the non-compact lattice photon on
ℤ⁴ and the block B = [0, n)⁴, let Φ̄_{μν} = n⁻² Σ_{p} F_p over the n⁴ (μ, ν)-plaquettes based in B (equivalently, the average over the n²
transverse translates of the n × n loop's flux). Then β Var Φ̄_{μν} = 1/2 for every n and every plane (μ, ν).
*Proof.* In Feynman gauge ⟨A_μ(k)A_ν(−k)⟩ = δ_μν/(β k̂²), k̂_ρ = 2 sin(k_ρ/2), so ⟨|F_μν(k)|²⟩ = (k̂_μ² + k̂_ν²)/(β k̂²) (gauge-invariant, so the
gauge does not matter). With χ̂_B(k) = Σ_{x∈B} e^{ik·x}, Var Φ̄_μν = n⁻⁴ ∫ d⁴k/(2π)⁴ |χ̂_B(k)|² (k̂_μ² + k̂_ν²)/(β k̂²). |χ̂_B|² = Π_ρ
sin²(nk_ρ/2)/sin²(k_ρ/2) is invariant under permutations of the four coordinates, so Var Φ̄_μν is the same for the six planes and equals one
sixth of their sum; Σ_{μ<ν}(k̂_μ² + k̂_ν²) = 3k̂², so the sum is n⁻⁴(3/β)∫|χ̂_B|² = n⁻⁴(3/β)|B| = 3/β by Parseval. Hence Var Φ̄_μν = 1/(2β). ∎
(Read by photon.c to nine digits at n = 1, 2, 4, 8 — a free known answer.) So in averaged variables the photon does not run: β_eff = β at every
scale, exactly; in path-holonomy variables β_eff = 1/(2Var Φ_A) → 0 like 1/(perimeter) (§2.1, β Var = 3.26 at n = 4), which is why path
holonomies make every theory, the free photon included, look strongly coupled after enough steps.

**But averaging alone does not make an adjacent row a decider (rec/photon/avg.txt).** With the averaged variables the photon's marginal edge-
adjacent rows are 4.000, 2.127, 1.178, 0.798 at n = 1, 2, 4, 8 (planar |r| → 0.150, scale-invariant; bent |r| = 0.216, 0.096, 0.036, 0.012: the
two orientations averaged over one block decouple, the reflection x₀ ↦ −x₀ about the block centre flipping F₀₁ and fixing F₁₂). Non-
wrapping variables that share no link still PASS the photon with an adjacent-only row. **Item 4 of §2.3 is the binding constraint**, and its
correct form is: in good Gaussian coordinates a gapless theory's conditional row is ≥ 1 by the sum rule (Lemma P); a truncation that DROPS A
NONZERO PRECISION ENTRY lands below one (the free field's nearest-neighbour row, exactly 1 at finite range, is the equality case: there is no
entry to drop). §2.3's phrase "every finite-range truncation passes it" is withdrawn in favour of this sentence.

## 3. THE WHOLE FIRST RING, READ (R1: rec/r1/; truncated staples, byte-comparable to M2b)

**3.1 The ordered cell (09:34–10:15, 2457 s, peak 1.070 GB = the dry stage to the byte, 3.65 × 10¹¹ multiply-adds; both roads equal; the joint
density positive, min 0.5752).**

| two steps, planar, W2L1, ordered | ρ | E[χ_½(A)] | κ = ρ/(m_A m_B) | 20ρ |
|---|---|---|---|---|
| pinned (rec/kat/k1, = M2b's record 0.015308357 to every digit) | 0.015308357 | 0.1455672954 | 2.889765 | 0.3062 |
| whole first ring integrated (60 plaquettes, 136 links) | **0.012599302** | **0.1321767049** | **2.884675** | **0.2520** |
| ratio | **0.823033** | **0.908011** | **0.998239** | |

**SR1 HELD AT ITS CENTRE (0.8230 against the staked centre 0.823, band [0.80, 0.85]); SR2 HELD AT ITS CENTRE (0.9080 against 0.908); SR3 HELD
(κ moved by 0.18 %, band ±1 %).** M2b's per-plaquette law, read on partial rings, composes to the WHOLE first ring at two steps to four digits,
and the factorization ρ = κ m_A m_B is unmoved by the whole ring — Lemma M's product, each factor proportional to its loop's alignment. The
cancelling cell follows below.

**3.2 What the ring reading means after §2 (said once).** The ring lowers the coupling by lowering the loops' alignment (ρ/ρ_pin = (E/E_pin)²
to 0.2 %), at fixed transmission κ. The photon does the same (×0.915 per first ring at n = 4, §2.1). THE MATCHED-ALIGNMENT COMPARISON
(rec/photon/matched_n6.txt): the SU(2) pinned two-step alignment m_A = E[χ_½]/2 = 0.073 is reached by the pinned photon at β_V = 0.749 where
E[cos Φ_A] = e^{−σ²/2} = 0.073, σ² ≈ 5.2, between n = 4 and n = 8; the rows there are printed in §3.3 beside SU(2)'s, so that the reader can see
whether the adjacent row distinguishes the groups at equal disorder.

## 4. THE COARSE ENVIRONMENT IMPOSED: LEMMAS E1, E2, THE KNOWN ANSWERS, THE SINGLE-NEIGHBOUR READING

**Lemma E1 (the environment family at the ordered datum is one angle).** Let the pinned outside be the ordered datum (every outside link 1), and
let g be the holonomy of any open path in the integrated region (a neighbour chain), A, B the loops based at the common basepoint. Then the joint
law of (A, B, g) is invariant under (A, B, g) ↦ (hAh⁻¹, hBh⁻¹, hgh⁻¹) for every h ∈ SU(2); and for every profile (t_e), the hybrid conditional
law of (A, B) at coarse value C is carried to the one at hCh⁻¹ by (A, B) ↦ (hAh⁻¹, hBh⁻¹). Hence ρ(C) depends only on the class of C:
C(φ) = (cos φ, sin φ n̂), φ ∈ [0, π], any fixed axis n̂. At the cancelling datum the datum is fixed only by g_t = cos t + x sin t (M2b Lemma 0.1),
and ρ depends on (φ, the angle of n̂ to the x-axis): a one-axis scan there is a LOWER bound on the supremum.
*Proof.* The global transformation U_ℓ ↦ hU_ℓh⁻¹ of every object link preserves the Haar measure; it conjugates every plaquette holonomy (class-
function weights unchanged) and every staple product, which at the ordered datum is 1 = h1h⁻¹, so the density is invariant; a path holonomy goes to
hXh⁻¹. So E[f(A, B, g)] = E[f(hAh⁻¹, hBh⁻¹, hgh⁻¹)]. The hybrid conditional moments are N^{ac}(C) = Σ_e d_e t_e E[D^a(A) ⊗ D^c(B) χ_e(gC)];
since χ_e(hgh⁻¹ · hCh⁻¹) = χ_e(gC), the law of (A, B) weighted by χ_e(g hCh⁻¹) is the image under conjugation by h of the law weighted by χ_e(gC).
A maximal correlation is invariant under a bijection of each variable separately. At the cancelling datum the same argument runs for h = g_t only. ∎

**KAT C1 (the chain dump is gauge covariant; rec/kat/c1_*.txt; n = 2, frame (1,1,1,1), chain rightA, W2L1 LN1, Haar-random datum seed 3).** A
gauge transformation Ω of the outside links at the chain's END vertex (3, 2) and at its START vertex (3, 0): the e = 0 slice (the pair's law)
unchanged to 1.6 × 10⁻¹⁶ and 1.3 × 10⁻¹⁶, while every e ≥ 1 entry moves (to 0.16): the open path transforms. The conditioned law on the
end-transformed dump at C = 1 equals the original's at C = Ω⁻¹ (pH 0.817114602 against 0.817114586; ρ 0.005738887 against 0.005738886;
E[χ_½(A)] 0.044796943 against 0.044796934 — the difference is the six printed digits of Ω), and on the start-transformed dump at C = 1 the
original's at C = Ω (pH 1.301295520 / 1.301295453, ρ 0.006871977 both). THE SIGHTED CONTROL (the half-transform, links leaving the vertex
only): the e = 0 slice moves by 1.8 × 10⁻³ and the conditioned law matches neither (pH 0.8836, ρ 0.006082). MET. KAT C0 (rec/kat/c0_*): the
chain engine's e = 0 entries equal the plain engine's F to the bit (25 entries, difference exactly 0); Lemma 0.1′ at the ordered datum: every
nonzero-weight entry at ≤ 8.1 × 10⁻¹⁷ of its block. KAT E1 (the reader): ∫ p(A, B | C) p_H(C) dC = p(A, B) to 1.8 × 10⁻¹⁵ on a 225-point rule
in C; the conjugation check ρ(gCg⁻¹) = ρ(C) on four random g to 0.

**Lemma E2 (the supremum over the coarse value with a proved bound on the rest).** For φ ∈ [0, π] let P^{ac}(φ) be the hybrid conditional
moments at C(φ), p_φ = Σ_{a,c} √(d_a d_c) Σ_{ij} P^{ac}_{ij}(φ) e_{a,i}(U) e_{c,j}(V) the conditional density relative to Haar ⊗ Haar in the Haar-
orthonormal basis e_{a,rq} = √d_a conj D^a_{rq}, and p_{A,φ}, p_{B,φ} its marginals. Put s = sup_φ Σ_{(a,c)≠(0,0)} d_a d_c √(d_a d_c) ‖P^{ac}(φ)‖_F,
s_A the terms with c = 0, s_B with a = 0, and s′, s′_A, s′_B the same with ∂_φ P^{ac}. If s_A < 1 and s_B < 1, then ρ(φ) is Lipschitz with
L = s′/√((1 − s_A)(1 − s_B)) + ½ (1 + s)/√((1 − s_A)(1 − s_B)) · (s′_A/(1 − s_A) + s′_B/(1 − s_B)), and sup_φ ρ ≤ max_k ρ(φ_k) + L Δφ/2 on a grid of
spacing Δφ; and p_φ > 0 everywhere if s < 1.
*Proof.* (a) Σ_{rq} |e_{a,rq}(U)|² = d_a Σ_{rq} |D^a_{rq}(U)|² = d_a² (unitarity), so by Cauchy–Schwarz |Σ_{ij} P_{ij} e_{a,i}(U)e_{c,j}(V)| ≤
d_a d_c ‖P‖_F, and summing the coefficients √(d_a d_c): |p − 1| ≤ s, |p_A − 1| ≤ s_A, |p_B − 1| ≤ s_B, and the same for ∂_φ with primes.
(b) ρ(φ) is the second singular value of the operator on L²(Haar) with kernel k_φ = p_φ/√(p_{A,φ} ⊗ p_{B,φ}) (the first is 1, with singular
functions √p_A, √p_B). By Weyl's inequality |σ₂(T) − σ₂(T′)| ≤ ‖T − T′‖_op ≤ ‖k − k′‖_{L²} ≤ sup |k − k′|. (c) ∂_φ k = ∂p/√(p_A p_B) −
½ p (∂p_A/p_A + ∂p_B/p_B)/√(p_A p_B), bounded by L via p ≤ 1 + s, p_A ≥ 1 − s_A, p_B ≥ 1 − s_B. (d) The mean value theorem on each grid
interval. The uniform bounds on ‖P‖_F and ‖∂_φ P‖_F follow from P = N/N^{00}: C(φ) = exp(φn̂) acts in the spin-e/2 representation as
exp(φ ρ_e(n̂)) with ρ_e(n̂) anti-Hermitian of norm e, so every entry of ∂_φ D^e(C(φ)) has modulus ≤ e; and N^{00} ≥ its minimum on a grid of
spacing δ minus (δ/2) sup|∂_φ N^{00}|. ∎ (l2env.c prints every constant; its first draft carried √(1 + s) in the second term, corrected to
(1 + s) at 10:3x before any certificate was read.)

**4.1 THE SINGLE-NEIGHBOUR READING (rec/env/env1_*; chain rightA = the right neighbour of A, frame (0,0,0,1), n = 4, W2L1, LN2, truncated
staples, ordered datum; 841 s, 0.028 GB).** The no-conditioning control (profile t_e = δ_{e0}): ρ = 0.014812923 = the pinned 0.015308357 ×
0.9676, the side column's per-plaquette law (M2b: ×0.9679 for a column of four) — and Lemma E2's certificate is trivially MET there (s = 0.724,
no φ-dependence). With a profile modelling the neighbour's exterior as rigid links (t_e = (I_{e+1}(13.2)/I₁(13.2))^m, m = 5 and 2): the
truncated conditioning kernel Σ_{e≤2} d_e t_e χ_e is SIGNED (min −0.117 and −0.991 on the class circle) — NOT A LAW, REFUSED BY NAME; the
readings it would give (ρ from 0.0069 at φ = π to 0.0183–0.0198 at φ ≈ 0–0.9) are printed in the record and claim nothing. And Lemma E2's crude
constants exceed one there (s_A = 3.25, 9.02): the certificate REFUSES. Positive profiles follow in §4.2.

**4.2 POSITIVE PROFILES AND THE CERTIFIED SUPREMUM OVER ONE NEIGHBOUR'S COARSE VALUE (rec/env/env1_trunc_heatkernel_scans.txt,
env1_trunc_*_tau2_fine.txt; READINGS at each grid point, two-road-checked reader; the supremum step under Lemma E2).** Heat-kernel profiles
t_e = exp(−τ e(e + 2)/4): the truncated kernel Σ_{e≤2} d_e t_e χ_e is SIGNED at τ = 0.5, 0.8 (refused by name) and POSITIVE at τ = 1.2, 2.0.

| right neighbour of A conditioned, frame (0,0,0,1), W2L1, LN2, truncated staples | ordered: ρ, E[χ_½(A)], κ | cancelling: ρ, E[χ_½(A)], κ |
|---|---|---|
| no conditioning (t_e = δ_{e0}) | 0.014812923, 0.14093, 2.8882 | 0.016933790, 0.10718, 5.7083 |
| τ = 2.0, C = 1 (φ = 0, the grid maximum) | **0.016354179**, 0.15533, 2.8932 | **0.018683567**, 0.11812, 5.7150 |
| τ = 2.0, φ = π/2 | 0.015195523, 0.14034, 2.9753 | 0.017348697, 0.10673, 5.8729 |
| τ = 2.0, C = −1 (φ = π, the grid minimum) | 0.012356697, 0.11786, 2.8808 | 0.014138474, 0.08966, 5.6978 |
| τ = 1.2: grid max (φ = 0) / min (φ = π) | 0.017449606 / 0.009442127 | 0.019924928 / 0.010812628 |

**What the table says.** (i) The supremum over the neighbour's coarse value sits at the ALIGNED value C = 1 at every positive profile and both
data; the infimum at C = −1. (ii) The neighbour acts on the coupling ONLY THROUGH A'S ALIGNMENT: across φ the transmission κ = ρ/(m_A m_B)
moves by at most 3 % (2.881–2.975 ordered, 5.698–5.873 cancelling) while ρ moves by ×1.32 (τ = 2) and ×1.85 (τ = 1.2) — the factorization of
Lemma M, with the coarse environment entering the factor ρ(A, S) through E[χ_½(A)]. (iii) THE CERTIFICATE AT τ = 2 (Lemma E2: s_A = 0.770,
s_B = 0.572 < 1 at the ordered datum, 0.585 / 0.435 cancelling; L_ρ ≤ 24.60 and 7.81; 20,001 grid points, Δφ = 1.571 × 10⁻⁴):
**sup_φ ρ ≤ 0.016354179 + 0.001932 = 0.018286 (ordered) and ≤ 0.018683567 + 0.000613 = 0.019297 (cancelling)**, a proved bound on the supremum
over the whole one-parameter family given the grid's point values — the family being the whole environment of this neighbour at the ordered
datum by Lemma E1, and one axis of a two-parameter family at the cancelling datum (a lower bound on the supremum there). Its standing, said
exactly: the grid's point values are READINGS (double precision, the reader's quadrature of 1/p_A); the bound needs p_φ > 0 for every φ, which
the crude constant does not certify (s = 1.76, 1.42 > 1) and the grid census supports (min marginals 0.69, 0.77; the joint density not
censused at every φ); and the object is the HYBRID (one neighbour, its interior pinned, its exterior a central profile), W2 faces, truncated
staples. The joint supremum over all neighbours of A and B is not reached; by (ii) and Lemma M it is bounded, on this object class, by
κ_max × sup_ξ m_A(ξ) × sup_ξ m_B(ξ), the alignments' suprema taken one side at a time — the design lever M2b named, now a lemma plus a reading.

**4.3 THE GATE APPLIED TO THESE ROWS (said in one paragraph).** Every SU(2) number in §§3–4 is an adjacent-pair row of coarse-loop holonomies.
§2 shows that this construction, applied to the photon, refuses at two steps and passes at three and four (pinned), passes at two steps in the
marginal measure, and at matched alignment reads the photon's row within 7 % of SU(2)'s (§3.2: 0.368 against 0.344). It therefore measures the
loops' disorder, not the group, and no number in §§3–4 decides Hypothesis I in either direction. They are kept because the factorization they
exhibit (κ local and environment-blind, the environment acting through alignments) is a structural fact about the coupling that a correct
construction (§5) will meet again.

### 2.5 THE COMPACT U(1) AT WILSON 1.2, THREE STEPS, PINNED — RESULTS (rec/u1/u1_n8_N3L2_ordered.txt, .l2.txt; 10:47–11:07, 0.75 GB)

n = 8 planar, NMAX 3, LMAX 2, ordered: Z finite, the joint density positive (min p_A 0.840, no negative grid point), **rho = 0.021200892 by
both roads** (sigma_H 0.021070, C_grid 0.027163, rho/C = 0.781), E[cos Phi_A] = 0.08015. Against n = 4 at the same caps (rho = 0.117467, the
record's): **rho(8)/rho(4) = 0.1805. SU1 HELD: the record's convention 20 rho = 0.424 < 1 — the pinned construction PASSES compact U(1) at
Wilson 1.2 at three steps**, after refusing it at two (20 rho = 2.35 at NMAX 3). The record's one-to-two-step factor x0.59 did not continue;
the two-to-three-step factor x0.18 is SU(2)'s own one-to-two-step factor (0.0153/0.0812 = x0.19). AT MATCHED ALIGNMENT ON THE COMPACT THEORY:
U(1) three steps E[cos Phi_A] = 0.0801, rho = 0.0212, kappa = rho/m^2 = 3.30; SU(2) two steps (W2L1, the same truncated-staple convention)
m_A = 0.0728, rho = 0.0153, kappa = 2.89. The construction cannot tell a theory gapless at 1.2 (by numerics; the photon, §2.1, by theorem)
from SU(2) at equal disorder. The cancelling cell is in flight; its value is appended when it lands.

**CORRECTION (11:1x) to §2.3 item 1.** "The Bianchi identity of each coarse cube fixes one face from the other five" is exact for U(1) (the six
fluxes of a cube sum to zero, so the conditional law of one coarse loop given all others is a point mass) and FALSE as stated for SU(2), where the
identity holds up to conjugation by coarse transports that the loops do not fix. The non-abelian loop-variable row is constrained, not
degenerate; the abelian one (the U(1) control) is degenerate. The conclusion of item 1 (use coarse link variables) stands on Corollary W′.

## 5. WHAT IS PROVED, WHAT IS READ, THE NEXT OBJECT, THE UNIFICATION

**Proved on this page.** Lemma M (§2.2: the planar object is a Markov chain A — S — B through the vertical links on x = 0, under every
in-plane coarse environment; ρ(A, B | ξ) ≤ ρ(A, S | ξ)ρ(S, B | ξ) — the shape of M2b's factorization). Lemma W and Corollary W′ (§2.2: the
maximal correlation of wrapped Gaussians is at most |r| and dies as e^{−(1−|r|)σ²}; for edge-adjacent loops sharing fine links |r| → 1/4 in
every Gaussian theory, massive or not — the adjacent coupling of loop variables is a contact term of the shared links). Lemma P (§2.2, form
corrected in §3: a gapless Gaussian specification's conditional row is ≥ 1 by a sum rule; a truncation dropping a nonzero precision entry lands
below one). Lemma V (§3: β Var Φ̄ = 1/2 exactly at every block size — in averaged variables the photon does not run). Lemma E1 (§4: at the ordered
datum the coarse value of one neighbour enters through its class angle alone; at the cancelling datum through two parameters). Lemma E2 (§4:
the Lipschitz bound that turns a grid over the coarse value into a proved supremum).

**Read (exact finite objects, double precision, two roads; truncations named).** THE FOUR-SIDED RING AT n = 4 BUILT — the refusal was the
link table (MAXL 128 against 136 links), not memory: 1.070 GB, 41 minutes a datum. The whole first ring multiplies the two-step coupling by
0.8230 (ordered, W2L1, truncated staples), the loops' alignment by 0.9080 and the transmission κ by 0.9982: M2b's per-plaquette law composes to
the whole ring to four digits (SR1–SR3 held at their staked centres); 20ρ = 0.252. One neighbour's coarse value imposed (chain engine, KATs C0,
C1, E1 met): the supremum sits at the aligned value C = 1, ρ × 1.104 (ordered) / × 1.103 (cancelling) at the certifiable profile, κ fixed to 3 %;
Lemma E2 bounds the supremum over the whole family by 0.018286 / 0.019297 given the grid's point values and the joint density's positivity.
THE GATE (§2): the same construction applied to the free photon (gapless by theorem) refuses at two steps (pinned 1.31) and passes at three
(0.097) and four (4 × 10⁻⁴); the marginal (exterior integrated) passes at two (0.647); applied to compact U(1) at Wilson 1.2 (gapless by
numerics) it refuses at two steps (2.35) and passes at three (0.424); at equal loop alignment it reads U(1) and SU(2) within the same range
(κ 3.30 against 2.89; photon row 0.368 against SU(2) 0.344).

**So Hypothesis I is not reached by this construction at any step, and no row of it decides.** The coarse-loop holonomy row is below one at two
steps for SU(2) (0.25–0.31 at W2; 0.73–0.89 by M2b's cap arithmetic with the ring), but it passes a gapless theory at three steps, so its
"below one" carries no information about a gap.

**What would certify each truncation, at its strength.** Cap: the faces at W2 (positive at 2.2), staples exact in R2 (M7b: the exact-staple
face cap converges to 0.013 % at W_f = 4 at one step). Spin: L1 (M2b: < 1 % at two steps). Frame: the first in-plane ring is integrated and
converged (second ring ≤ 0.3 %); the out-of-plane exterior is pinned, and §2 shows pinning moves the coupling ×2.2 to ×92 at n = 4 to 16 for
the photon — this truncation is not small and no ring width removes it. Planarity: the bent pair with a ring is not run (M2b's bent factor
1.14–1.16 by arithmetic). Variables: loop holonomies, which §2 shows cannot decide. Three steps: out of the exact engine's reach (the column cut
at n = 8 holds 14⁸ = 1.5 × 10⁹ entries a slice, 94 GB a state at L1); M7b's supplied-coefficient road is the instrument there.

**THE NEXT OBJECT (forced by Lemmas W, V, P).** THE GROUND's own block map, read as it is written: coarse LINK variables, each fine link in one
coarse variable, AVERAGED over the block (Bałaban's averaging, so that the perimeter self-energy is averaged away — Lemma V: the photon's
coupling is then scale-invariant, β_eff = β exactly), the exterior INTEGRATED, the CONDITIONAL row (partial correlations given every other
coarse variable, well posed for coarse links; for coarse loops it is degenerate in the abelian case, where a coarse cube's six fluxes sum to zero, and constrained by the Bianchi identity up to conjugation by coarse transports in the non-abelian case), and the DEFICIT
δ = 1 − Σ_{y′} R(y, y′) e^{κ|y−y′|} certified with its tail. By Lemma P the photon sits at δ ≤ 0 there (in coordinates where the constant connection is a zero mode of the coarse precision — Feynman gauge, or an axial gauge on the torus — the block map carrying constants to constants, so the Schur complement keeps the zero mode); a gapped theory must show δ > 0
uniformly in the cutoff. The first computation: the photon's coarse-link conditional row in Feynman gauge, exactly (it must read 1); then
SU(2)'s in the same coordinates at the fixed scale a_c, where the record's fixed-datum flows (2.2 → 1.888 → …, and U(1) driven to 0.63) are
contaminated by the path holonomies' self-energy and must be re-read in averaged variables.

**The unification.** (1) Lemma P is the M-matrix margin: for a Gaussian specification Dobrushin's condition in the L² currency is STRICT
DIAGONAL DOMINANCE of the precision (Jacobi iteration converges), a massless field is a SINGULAR M-matrix (the graph Laplacian, Jacobi radius
exactly 1), and the mass is the dominance margin (row = 2d/(2d + m²) for the massive free field). Hypothesis I is diagonal dominance of the
effective coarse precision; the gap is its margin. (2) Lemma W is the Debye–Waller factor of directional statistics (the wrapped normal's
Fourier coefficients e^{−k²σ²/2}), and on loops it is Guth's perimeter law: in a Coulomb phase ⟨W⟩ = e^{−σ²/2} with σ² ∝ perimeter, so the
correlations of coarse holonomies die by a Debye–Waller factor — a disorder of the UV, not a mass. (3) Lemma M is a Markov blanket with
Witsenhausen's data-processing inequality for maximal correlation; the factorization ρ = κ m_A m_B is that inequality nearly saturated.
(4) Lemma V is the lattice form of the scale invariance of four-dimensional Maxwell theory (F has dimension two).

### 3.3 THE WHOLE FIRST RING, THE CANCELLING CELL (R1; 10:16–11:11, 3339 s under contention, peak 1.070 GB; both roads equal; the joint density positive, min 0.6842)

| two steps, planar, W2L1, cancelling | rho | E[chi_1/2(A)] | kappa | 20 rho |
|---|---|---|---|---|
| pinned (rec/kat/k1_n4_W2L1_cancel_pin_trunc, = M2b's record 0.017496636) | 0.017496636 | 0.1107069964 | 5.7104 | 0.3499 |
| whole first ring integrated | **0.014385508** | **0.1002839424** | **5.7217** | **0.2877** |
| ratio | **0.82218** | **0.90585** | **1.00198** | |

**SR1 HELD at the centre (M2b's arithmetic x0.8220; read x0.8222), SR2 HELD (0.906 in [0.89, 0.93]), SR3 HELD (+0.20 %), SR4 HELD (20 rho = 0.288
against the staked 0.288 cancelling, 0.252 against 0.252 ordered).** The per-plaquette law composes to the whole first ring at both data to
four digits, and the transmission kappa is unmoved by the ring at both data. R2 (the same with exact staples, the coordinator's request) is in flight.

## 5.1 THE NEXT OBJECT'S FIRST COMPUTATION: THE CONDITIONAL ROW IN BLOCK-AVERAGED COORDINATES IS A DECIDER IN THE GAUSSIAN SECTOR (code/blockfree.c; rec/next/)

In Feynman gauge the photon's components are independent massless fields, and THE GROUND's coarse link averaged over the block (the mean of the
n^3 parallel line integrals) is the block sum of a free field. Its CONDITIONAL row (partial correlations given every other coarse variable, the
conditional maximal correlations of a Gaussian, Hypothesis I-L²'s own quantity) is computed exactly on a coarse torus of side 16 (Fourier
inversion of the blocked covariance; the sum truncated at sup-distance 5, the missing mass printed). KATs MET: n = 1 massless row 1.0000000000
(H = -Delta, positive entries 1.6e-14); n = 1, M^2 = 0.25: 0.9696969697 = 8/8.25.

| block n | massless | coarse mass a_c m = 1.9 | 3.5–3.9 | 5.8–7.1 | 8.4–11.5 | 16.8 |
|---|---|---|---|---|---|---|
| 2 | **1.408** (adjacent 1.171) | 1.016 | 0.562 | 0.207 | 0.059 | |
| 4 | **1.833** (adjacent 1.461) | | 0.825 | 0.339 | 0.109 | 0.030 |

(a_c m = n · 2 asinh(M/2) for the lattice mass M; the n = 4 columns are M^2 = 1, 4, 16, 64.) **In averaged coordinates the conditional row REFUSES
the massless field at every block size — above one, not at one: block averaging creates positive precision entries (0.20 of the row at n = 2,
0.42 at n = 4), counted in absolute value, so the massless row is 1 + 2 x (positive part) by the zero mode (Lemma P) — and ACCEPTS a massive
field once its mass in coarse units exceeds about 2 (n = 2) to 3.3 (n = 4).** So the construction of §5 passes the gate in the Gaussian sector:
it refuses the photon at every scale and fires for a gapped field at a coarse correlation length below about 0.3 coarse units. The threshold
grows slowly with the block factor (the massless row 1.41 -> 1.83 from n = 2 to 4), which is the price of Dobrushin's single-site form in
averaged coordinates. CALIBRATION, NOT EVIDENCE: were the two-step SU(2) coarse theory Gaussian with a mass of 7 coarse units (the literature
glueball mass at beta = 2.2, a m ~ 1.7, times a_c = 4a, quoted, not derived here), its row would read about 0.34. The SU(2) computation is the
named object: the coarse-link conditional row in averaged coordinates at the fixed scale a_c, with the exterior integrated.

### 3.4 THE MATCHED-ALIGNMENT COMPARISON, AT THE PHYSICAL TRUNCATION (rec/r2/ring0000_n4_W2L1_exact_ordered*, rec/photon/matched_*.txt; 11:2x)

EXACT STAPLES (R2's first cell, the pinned core, W2 faces, L1): **rho = 0.040244199** (both roads; joint density positive, min 0.2694),
E[chi_1/2(A)] = 0.2762513, so m_A = 0.13813 and kappa = rho/m_A^2 = 2.109; 20 rho = 0.805 — against the truncated-staple 0.015308 (x2.63):
the staple truncation, not the faces, had held the two-step coupling down (M7b's finding, at two steps), and exact staples at W2 faces read
about M2b's truncated W4 value (0.0396). With M2b's bent factor (x1.156, read at W2L2 truncated; arithmetic) the pinned twenty-pair row is
4(0.0402) + 16(0.0465) = 0.905.

THE PHOTON AT THE SAME ALIGNMENT (pinned Gaussian object, the true bent pair with its corner plaquettes, beta_V = 0.749): e^{-sigma^2/2} = 0.1381
at sigma^2 = 3.96, between n = 4 (sigma^2 3.415: rho_pl 0.0608, rho_bent 0.0670, row 1.315, kappa = 0.0608/0.1813^2 = 1.85) and n = 5 (sigma^2 4.34:
0.03286, 0.03575, row 0.703, kappa 2.52); interpolated in log, **row ~0.91, kappa ~2.2**, against SU(2)'s **0.905 and 2.11**. At equal loop
alignment the gapless photon and SU(2) give the same transmission and the same adjacent row to a few per cent. THIS is the gate's verdict in
one line: the record's construction reads the coarse loops' disorder through a group-independent transmission, kappa ~ 2.

**§5.1 CONTINUED — UNIFORMITY IN THE CUTOFF (11:3x, the advisor's blocking point; rec/next/blockfree_uniform.txt).** Hypothesis I needs constants
uniform along Theorem 8.5's sequence, where the block factor n = a_c/a_j grows at fixed physical a_c. The table above varied n and the mass together.
At FIXED coarse mass:

| a_c m | n = 2 | n = 4 | n = 8 | n = 16 |
|---|---|---|---|---|
| 0 (massless) | 1.408 | 1.833 | 2.076 | |
| 2.77 | | 1.124 | | |
| 3.85 | 0.491 | 0.825 | 1.047 | 1.136 |
| 5 | | | 0.804 | |
| 7 | (0.339 at 7.05, n = 4) | | 0.534 | 0.627 |

(sup-distance 5 at n <= 8, 4 at n = 16; the shells beyond fall by ~x8 per unit of distance, so the truncation moves the row in the fourth digit.)
**The block-averaged row GROWS with n at fixed coarse mass and CONVERGES** (increments 0.334, 0.222, 0.089 at a_c m = 3.85; 0.195, 0.093 at 7):
the n = 4 statement "accepts once a_c m exceeds 3.3" is WITHDRAWN (the n = 4 crossing lies between 2.77 and 3.85), and in the cutoff limit the
row is about 1.2 at a_c m = 3.85 and about 0.7 at a_c m = 7, so the LIMITING THRESHOLD lies between 3.85 and 7 (near 5 by interpolation); the
massless row grows 1.41, 1.83, 2.08 and refuses uniformly. So block-averaged coordinates ARE uniform in the cutoff (the row has a limit), the
decider survives the limit in the Gaussian sector, and its price is a coarse correlation length below about 0.2 coarse units — larger blocks
than the naive n = 2 reading suggested. EXACT readings on a solvable model (the coarse torus of side 16, sup-distance 4–5).

**§2.5 CONTINUED (11:4x).** The cancelling cell at three steps: rho = 0.022137431 (both roads; min p_A 0.881), 20 rho = 0.443 < 1, against n = 4's
0.144060 (ratio 0.154). The pinned construction PASSES compact U(1) at Wilson 1.2 at three steps at both data. (Loop cap L2 at n = 8 against L3
at n = 4 — the n = 8 moments are small enough that L3 moves them below the printed precision of the ratio; not run.)

**§4.2 CONTINUED — EXACT STAPLES (rec/env/env1_exact_ordered_tau2.txt).** The right neighbour of A on frame (0,0,0,1) with exact staples, ordered:
no conditioning rho = 0.038410144 (kappa 2.104); at the positive profile tau = 2 the grid maximum again sits at C = 1, rho = 0.041398359 (x1.078,
E[chi_1/2(A)] 0.2837 against 0.2644, kappa 2.113 against 2.104), the minimum at C = -1 (0.033205, kappa 2.090). The crude constants exceed one
(s_A = 1.65): Lemma E2 REFUSES at the exact-staple object; the supremum over the coarse value is a grid READING (4001 points) there, the
certified bound standing only on the truncated-staple object (§4.2). The structure is the same: the environment moves rho through A's alignment,
kappa fixed to 1 %.

**Runs in flight at the report (11:4x):** R2 the whole ring with exact staples (ordered from 11:13, then the cancelling pinned core and ring);
env1 exact cancelling. Their values are not in the report; M2b's ring factor x0.82 (held to four digits by R1 at both data) puts the exact-staple
whole-ring ordered rho near 0.033 by arithmetic.
