# M7b — THE CROSSOVER'S CERTIFIED LANDING: THE WALL FLOORS RECONCILED, THE CAP LIMIT, THE THIRD AND FOURTH STEPS, THE STRUCTURE

Proof agent M7b, 2026-11-02 (opened 08:3x EST, `date`). Read-only in both repositories; every engine and certificate run here is a copy in
this directory (`code/`, `rec/`). Strength labels: PROVED (proof on this page) / CERTIFIED (outward-rounded arithmetic) / READING (exact
finite object in double precision at fixed data, truncated) / OPEN.

## 0. Sources read in full before deriving

MATH_BRIEF.md; M7/WORK.md (all 338 lines); M5/WORK.md (§§0–7, 7.1–7.5 in full; the rest scanned); M2b/WORK.md §§3–5 (Theorem A1,
Corollary A1′, Lemma A2, Theorem C1, Proposition C2); THE FAR SHORE §10 with RESULTS 1–6 and the correction of strength
(III-Yang_Mills `OPEN/the-far-shore.md` lines 148–251); THE CROSSING CAMPAIGN §§18–21 (`OPEN/the-crossing-campaign.md` 406–511); the
certificate `STDLIB/scripts/aperanton_kp_cert.awk` at HEAD 88e069862 (md5 7aea522c…, 214 lines, copied `code/kp_cert.HEAD.awk`) and its
Bessel library (md5 ff26d775…); the modes reader `STDLIB/build/aperanton/surface-gas/w2_modes.awk` at HEAD (21d759409); the engine
`STDLIB/build/aperanton/surface-gas/w2_strip_n.c` at HEAD (c9ac242d4) in full; M7's records (`w2l2o.modes.m7.txt`, `w2n4_W3L2_modes.m7.*`,
`probe/w4_n4_*_L1C0.2026-11-02b.txt`, `probe/capcheck_n2.2026-11-02a.txt`).

## 1. The deep-think synthesis (the decision this file executes)

**What I expected.** Part 1 a bookkeeping reconciliation (two agents reading one record two ways); part 2 a cap extrapolation; part 3 an
engine run at three steps; part 4 a restatement of M2b.

**What changed my mind (four facts, each checked at the desk before any run).**
(i) THE THREE WALL NUMBERS ARE ONE SHARE COUNTED THREE WAYS. With s = |b̂_{(1 at p, ½ at q)}|^{1/2} (the geometric-mean share of the
(½,1) mode), M7's 0.2998 = a′₁ + 16·(2s)/3, M5's 0.0383 = a′₁ + 4s/3, M5's 0.0093 = s/3 (W2L2 ordered: s = 0.028017, a′₁ = 0.00090015;
each identity checked to the printed digits). The disagreement is the MULTIPLICITY (16 pairs × 2 orientations / 4 pairs × 1 / one
bond), and the certificate's own derivation decides it — the per-plaquette expansion of a product over plaquettes (§2 Lemma 2.1).
(ii) THE GEOMETRIC MEAN IS NOT THE SHARP PRICE, AND THE RECORD NEVER PRICED THE WALL–WALL BOND. Charging each bond ONCE, at one of its
plaquettes, divided by the Wilson units of its other plaquettes (the orientation form, Lemma 2.1 (b)) is also a valid bound, and for the
(1,½) bond charged at its wall end it costs |b̂|/(2a′_½) instead of |b̂|^{1/2}: five times smaller. But the (1,1) mode (both plaquettes
spin 1), classed "modifying" by the reader, also CREATES a two-plaquette wall on bare plaquettes, with relative content b̂(2,2)/(3a′₁)² =
11.2 at W2L2 ordered — the largest wall input on the page and absent from every record's WALL.
(iii) THE STAPLES ARE THE CAP. Of the two-step object's 360 fine plaquettes, 328 are staples, and the engine evaluates every staple weight
POINTWISE at its link's quadrature nodes (SW[l][pt] = RW·Π_k wgt(U·T_k)); only the 32 face plaquettes enter the contraction as wire cycles.
The truncated staple weight w_W has relative error O(1) at anti-alignment (w_W(−1)/w(−1) = 8.6, −1.6, 1.7 at W = 2, 3, 4), which is why
flipped and cancelling data swing with the cap (M7 §2d). Evaluating staples EXACTLY costs nothing in the contraction (a higher quadrature
degree only), and leaves only the face plaquettes truncated, which sit near the identity where the relative error is ~3·10⁻⁴ at W4.
(iv) THE CERTIFICATE NEEDS NO COARSE-ENVIRONMENT SUPREMUM, BUT IT NEEDS THE BLOCKED ACTION, NOT A CONDITIONAL LAW. The KP route consumes
the Fourier data of a local decomposition of ONE function (the blocked action); the pinned objects compute conditional laws given fine
data. The bridge is the mixture (tower) identity and the certificate's monotonicity in each coefficient's modulus (§5).

**Decision.** (1) Prove the per-plaquette accounting lemma (the general "charging" form, containing the geometric mean and the orientation
as cases), derive from it which number is the certificate's input, show the MAX is not a bound, and run the certificate at the sound and
the sharp inputs, including the unpriced (1,1) bond. (2) Build the EXACT-STAPLE variant of the engine (staples exact, face plaquettes
truncated at W_f), KAT it two-sided, and read the cap series at one and two steps on it; derive the certified-tail bound and the cap it
needs. (3) Add a supplied-coefficient door to the engine and run the exact one-step map on the two-step one-plaquette action (third step)
and the two-step map (fourth), at both coarse data; the certificate's verdict in the exit form with the sharp pricing. (4) Write the
object the certificate needs and what the engines reach.

**Runner-up rejected.** Pushing the truncated-staple engine to W5 at two steps (≈ 7× W4's 36.6 M-entry state, over the 2 GB limit) — it
would buy one more point of a series whose slow convergence is the staples' artefact (iii).

**Confidence.** High on (i) and the lemma; high that exact staples shrink the cap dependence; medium on the size of the residual face-cap
effect; low on the three-step readings' bearing on the true blocked action (they inherit every pinned-datum limit).

**Kill-switches.** The exact-staple engine failing the free-datum KAT or disagreeing with the truncated engine at high W (W6 one step); the
orientation lemma's bound failing a brute-force check on a small configuration; the certificate copy failing K0 (the gate's coef pin).

## 2a. THE ENGINE COPY AND ITS KNOWN ANSWERS — stakes written before the runs (09:0x EST)

`code/w2x.c` = HEAD's `w2_strip_n.c` (md5 3e6924cc…, the copy M7 used) with two doors and one refusal, the diff three hunks
(`code/w2_strip_n.HEAD.c` beside it): W2_EXACT=1 evaluates the STAPLE weights exactly, w(V) = β e^{β V.w}/(2I₁(β)) (a₀ = 1), the rule
degree DEGX (default 50) plus the slot degrees; W2_COEF="a1,…" supplies the fine coefficients (staples carry the whole series, face
plaquettes the series truncated at WMAX); the bent object is refused by name (§18). Why exact staples are free: the engine never expands a
staple in characters — SW[l][pt] = RW·Π_k wgt(U_pt T_k) is a pointwise product at the link's quadrature nodes; only the 2n² face plaquettes
are wire cycles of the contraction. Why the rule stays exact to rounding: a staple field is e^{β⟨q, v⟩} with |v| ≤ 5, whose Taylor remainder
past degree D is at most 2(5β)^{D+1}/(D+1)! (D = 50: 11⁵¹/51! ≈ 8.6·10⁻¹⁴, against link integrals of order 10³); the rule integrates every
polynomial of degree ≤ DEGX + slots exactly.

STAKES. E-K1 (doors unset): one step W2 ordered planar n = 2, CMAX 0 → E[χ_½(A)] = 0.6210389045 (M7's base); two steps n = 4 →
0.1455672954. E-K2 (the COEF door): W2_COEF = the Bessel ratios I_{s+1}(2.2)/I₁(2.2), s = 1..W → the unset run's E to every printed digit
at W = 2 and 3 (same rule, same series). E-K3: datum free with W2_EXACT → the free KAT MET. E-K4 (rule convergence): W2_EXACT with DEGX =
40, 50, 60 agree to 10⁻¹⁰. E-K5 (two-sided physics control): the exact-staple value at face cap W_f and the HEAD value at W = W_f differ by
the staples' truncation alone, which shrinks with W: one step ordered, |difference| ≥ 0.05 at W = 2, ≤ 0.005 at W = 6.
STAKE P1 (the cap moves only through the faces): one step ordered, exact staples, W_f = 2, 3, 4, 6: E(2) visibly low (the 8 face
plaquettes 9 % off at a typical angle 0.5), E(3) within 2 % of E(6), E(4) within 0.2 %; the limit in [0.82, 0.835] (the HEAD series
0.621 → 0.770 → 0.815 → 0.826 read through its relative-error model, §3).

## 2b. RESULTS OF §2a (record `rec/kat1.2026-11-02a.txt`, 09:07–09:11 EST) — every KAT MET; THE CAP WAS THE STAPLES

- E-K1 MET: 0.6210389044928 (one step, W2, ordered) — M7's base to every digit.
- E-K2 MET: the COEF door with the Bessel ratios reproduces W2 (0.6210389044928) and W3 (0.7698012864895) to every printed digit.
- E-K3 MET: the free KAT with W2_EXACT (Z = 1, E[χ_a(A)] = d_a a_a^{n²}, every connected pair zero).
- E-K4 MET: DEGX = 40 / 50 / 60 → 0.8258854673484 / …485 / …485 (W_f = 4, ordered): the rule is converged to 10⁻¹³.
- E-K5 MET (two-sided): |EXACT − HEAD| = 0.181 at W = 2, 1.6·10⁻⁴ at W = 6 (ordered); 0.060 and 8.7·10⁻⁵ (cancelling).

THE ONE-STEP CAP SERIES, E[χ_½(A)] (READINGS: planar n = 2, β = 2.2, the named data; exact at the stated truncation in double precision)

| W (face cap; HEAD: every plaquette) | HEAD ordered | EXACT staples ordered | HEAD cancelling | EXACT staples cancelling |
|---|---|---|---|---|
| 2 | 0.6210389045 | 0.8018263075 | 0.4863121380 | 0.5458524514 |
| 3 | 0.7698012865 | 0.8236966182 | 0.5011675523 | 0.5624356511 |
| 4 | 0.8149156757 | 0.8258854673 | 0.5606407358 | 0.5638988723 |
| 5 | 0.8244244644 | 0.8259879325 | 0.5626795095 | 0.5639660151 |
| 6 | 0.8258261417 | 0.8259904963 | 0.5638804495 | 0.5639676824 |

STAKE P1 HELD AND EXCEEDED: E(2) 2.9 % low; E(3) within 0.28 % of E(6) (staked 2 %); E(4) within 0.013 % (staked 0.2 %); the limit
0.82599 in [0.82, 0.835]. The exact-staple increments fall 0.0219 → 0.0022 → 1.0·10⁻⁴ → 2.6·10⁻⁶ (ordered), 0.0166 → 0.0015 → 6.7·10⁻⁵ →
1.7·10⁻⁶ (cancelling): super-exponential, as the face plaquettes' angles are small. **The record's slow cap series (M7 §2d, M2b §7.3) is
the staples' truncation, not the faces'**: the HEAD series reaches the exact-staple limit only at W6, from below, while the exact-staple
series is converged to 10⁻⁴ at W_f = 4. ONE-STEP LIMITS (READINGS): E_∞ = 0.825990(5) ordered → a′_½ = 0.412995, 0.563968 cancelling →
a′_½ = 0.281984.

STAKES before the two-step exact-staple runs (W_f = 3, 4; L1 C0; planar n = 4; launched 09:1x): T1 ordered E ∈ [0.284, 0.296] (point
0.290), the W_f 3 → 4 change below 1 % of the value; T2 cancelling E ∈ [0.186, 0.198] (point 0.192). Consequence staked: at the cap limit
the ordered two-step a′_½ ≈ 0.145 FAILS the certificate on the one-plaquette part alone (as W4 did), the cancelling ≈ 0.096 PASSES.

## 2c. THE TWO-STEP CAP LIMIT ON EXACT STAPLES (records `rec/x_n4_*_Wf{3,4}_L1C0.2026-11-02a.txt`, 09:13–09:21 EST) — T1, T2 HELD

| datum | HEAD W2 | HEAD W3 | HEAD W4 | EXACT W_f = 3 | EXACT W_f = 4 | W_f 3 → 4 | limit (READING) | a′_½ | β_eff (I₂/I₁ inverse) |
|---|---|---|---|---|---|---|---|---|---|
| ordered | 0.1455673 | 0.2432512 | 0.2789044 | 0.2870618 | 0.2881066 | +0.36 % | 0.28816 ± 0.0001 | 0.14408 | 0.583 |
| cancelling | 0.1107070 | 0.1518892 | 0.1860347 | 0.1900583 | 0.1907264 | +0.35 % | 0.19076 ± 0.0001 | 0.09538 | 0.384 |

(The limit's error bar is the one-step object's own convergence ratio applied to the 3 → 4 increment: the W_f 4 → 5 increment was 4.7 % of the
3 → 4 one at one step; it is a reading of the series, not a certified tail — §4.) **The two-step one-plaquette coefficient at the cap limit:
a′_½ = 0.1441 (ordered), 0.0954 (cancelling).** The record's W2L2 values (0.0728 / 0.0554) were 49 % / 42 % of the limit, its W4 values
(0.1395 / 0.0930) 96.8 % / 97.5 %; M2b's arithmetic cap limits (β_eff 0.589 / 0.523) are refuted at the cancelling datum (0.384) and met
within 0.006 at the ordered one.

## 2d. THE CERTIFICATE'S OWN KNOWN ANSWERS AT HEAD 88e069862 (record `rec/certkat.2026-11-02a.txt`) — all MET

K3 (the gate's coef pin) byte for byte; K2: COEF + TILT now composes at HEAD (68/100 PASS, 69/100 FAIL — M7's defect closed by the trunk);
K4: the number in the coefficient-supplied mode, PASS for α ∈ [0.0041, 0.0047] at the Bessel ratios of 0.4764 rounded up, no α at 0.4766.

STAKES C1 (before the run): ordered a′_½ = 0.1440534 FAILS at every a′₁ (with a′₁ = 10⁻¹², LHS ≥ 5α as at M7's W4-o); cancelling a′_½ =
0.0953632 PASSES at a′₁ = 9.544584·10⁻⁴ (the W3L2 record's) in the LOCAL α-scan and in GRADED at α = 1/1000; the largest passing a′_½ at that
a′₁ (bisected) lies in [0.120, 0.132].

### 2d RESULTS (record `rec/c1.2026-11-02a.txt`): C1 HELD; the reach refined
- ordered a′_½ = 0.1440534: FAIL at a′₁ = 10⁻¹² (GRADED α = 1/1000: no dressing, u~ = u, r_hi = 0.7261, LHS = 0.0110 = 11α; LOCAL: no α in
  [0.0001, 0.0080]) and at a′₁ = 0.00364 (LHS = 0.0195). AT THE CAP LIMIT THE ORDERED TWO-STEP DATUM LIES OUTSIDE THE WINDOW ON ITS ONE-PLAQUETTE
  PART ALONE, whatever its higher coefficients.
- cancelling a′_½ = 0.0953632: PASS at a′₁ = 10⁻¹², 9.54·10⁻⁴, 0.002, 0.004 (LOCAL: every α in [0.0001, 0.0080]; GRADED α = 1/1000: LHS =
  3.9–4.7·10⁻⁵, α/LHS ≈ 21–26).
- THE REACH (LOCAL α-scan, a′₁ = 9.544584·10⁻⁴): the largest passing a′_½ is 0.1339 (bisected to [0.1338992, 0.1339031]); the stake [0.120,
  0.132] refuted upward by 1.4 %. In u the ordered limit is 7.6 % outside, the cancelling 29 % inside.

---

## 3. PART 1 — THE TWO WALL FLOORS RECONCILED, AND THE CERTIFICATE'S INPUT DECIDED BY ITS OWN DERIVATION

### 3.1 The three numbers are one share at three multiplicities (each identity checked against the record to its printed digits)

Write s := |b̂_{(1 at P, ½ at Q)}|^{1/2}, the geometric-mean share of the pair coupling's (½,1) mode (one mode, by the planar mirror
symmetry b̂(2,1) = b̂(1,2)), and a′₁ = E[χ₁(A)]/3. At every read cell:

| cell (truncated staples, planar) | a′₁ | s | M7's floor a′₁ + 16·(2s)/3 (reader's NPAIR = 16, s_one = 2s) | M5's coplanar a′₁ + 4s/3 | M5's max s/3 | W* table / page |
|---|---|---|---|---|---|---|
| W2L2 ordered | 9.0015·10⁻⁴ | 0.0280175 | 0.299754 | 0.038257 | 0.009339 | 0.0141 / 0.0084 |
| W2L2 cancelling | 5.3602·10⁻⁴ | 0.0316407 | 0.338037 | 0.042724 | 0.010547 | 0.0142 / – |
| W3L2 ordered | 3.6438·10⁻³ | 0.0458993 | 0.493236 | 0.064843 | 0.015300 | 0.0102 / – |
| W3L2 cancelling | 9.5446·10⁻⁴ | 0.0501943 | 0.536360 | 0.067880 | 0.016731 | 0.0141 / – |

(W* from M7 §3.5 and M5 §5.1; the page-dress W* read by M5 at W2L2 only.) **The ceiling is the same object in both files** — the largest
floor at which the dressing keeps a root below 3 with its s-tail closed, the same at both data except W3L2 ordered, where the leaf sum
binds first. **The floors differ only in multiplicity**: ×32 (sixteen bent positions priced at the planar mode, both orientations), ×4
(four coplanar positions, one orientation), ×1 (one bond). The question is settled by the derivation the coefficient mode rests on
(THE FAR SHORE §10 RESULTS 3 (b)–(c), RESULTS 4 (a)–(b), RESULTS 5–6).

### 3.2 The derivation: a decorated polymer, expanded plaquette by plaquette

**Setting (RESULTS 3–4).** At the exit scale the blocked weight is Π_P w′(U_P) Π_C (1 + b_C): w′ = Σ_j d_j a′_j χ_j (a′₀ = 1), b_C =
e^{δ_C} − 1 the bond of a connected set C of ≥ 2 coarse plaquettes, b_C = Σ_ρ b̂_C(ρ) φ_ρ, ρ = (k_P)_{P∈C} the representation the mode
carries at each plaquette of C (class part; the relative-orientation part carries intertwiner labels as well and is handled the same way
with its own coefficients). Expanding every w′ and every bond, a term (j, B, ρ) — a Wilson spin j_P at each plaquette, a set B of bonds
switched on, a mode ρ_C of each — has scalar Π_P (d a′)_{j_P} Π_{C∈B} b̂_C(ρ_C) and integrand Π_P [χ_{j_P}(U_P) Π_{C∈B, C∋P} χ_{k_{C,P}}(U_P)];
at each P, χ_j Π χ_k = Σ_l N_P(l) χ_l, so the term contributes Π_P N_P(l_P) × I(l) to every flux configuration l, I(l) = ∫Π_P χ_{l_P}(U_P)dU
the Wilson gas's own integral. RESULTS 4 (a) (the pricing-comparison lemma; second read RESULTS 5 (d), its proviso closed in RESULTS 6 (a)):
|I(X, l)| ≤ T(l, topology) with every coefficient outside. So a decorated polymer weighs K(X, l)·I(X, l),
K(X, l) = Σ_{(j,B,ρ) → l} Π (d a′)_{j_P} Π b̂_C(ρ_C) Π N_P, and the Wilson gas's polymer Π_P (d a′)_{l_P}·I(X, l).

**Single-touch terms.** (j, B, ρ) is single-touch if B's bonds are pairwise disjoint (each plaquette carries at most one bond
component). At a plaquette P carrying the component k of one bond, the Wilson sum at fixed flux l is Σ_j (d a′)_j N(l; j, k) =:
(d a′)_l R(l; k). Pure creation (k = l, j = 0) gives R = [1 + Σ_{j≥1}(d a′)_j N(l; j, l)]/(d a′)_l ≈ 1/(d a′)_l; a modifying integer
spin-1 component on a spin-½ plaquette (½ ⊗ 1 ∋ ½) gives R(½; 1) = 1 + (d a′)_{3/2}/(d a′)_½ ≈ 1. The RELATIVE CONTENT of a bond C with
mode ρ on (X, l) is r_C := |b̂_C(ρ)| Π_{P∈C} R(l_P; k_{C,P}) (RESULTS 3 (c)'s r_C, the modifying case now inside it). Then the single-touch
part is exactly
  K₁(X, l) = Π_{P∈X} (d a′)_{l_P} · Σ_{B ⊂ X disjoint, matching l} Π_{C∈B} r_C    (with |b̂|: an upper bound).

**Lemma 3.1 (THE CHARGING LEMMA).** For each candidate bond C choose a nonempty S(C) ⊆ C and y_{C,P} ≥ 0 (P ∈ S(C)) with
Π_{P∈S(C)} y_{C,P} ≥ r_C. Then
  Σ_{B disjoint} Π_{C∈B} r_C  ≤  Π_{P∈X} (1 + Σ_{C ∋ P: P ∈ S(C)} y_{C,P}).
*Proof.* Expand the right side as Σ_σ Π_P y_{σ(P),P} over maps σ assigning to each P either ∅ (factor 1) or a bond C with P ∈ S(C). For
a disjoint B put σ_B(P) = C if P ∈ S(C) for the (unique) C ∈ B containing P, ∅ otherwise: well defined because B's bonds are disjoint;
it contributes Π_{C∈B} Π_{P∈S(C)} y_{C,P} ≥ Π_{C∈B} r_C; and B ↦ σ_B is injective (B is the set of bonds in σ_B's image, every S(C) being
nonempty). Every other term is non-negative. ∎
Special cases: S(C) = C, y = r_C^{1/|C|} — THE SPLIT, the geometric mean in relative units (in absolute units every plaquette of C pays
|b̂_C|^{1/|C|}, the partners included); S(C) = {P(C)}, y = r_C — THE ORIENTATION: each bond charged ONCE, at one plaquette, its
coefficient divided by the Wilson units of its other plaquettes (RESULTS 4 (d)'s "a bond enters the recursion once", made exact).

**Corollary 3.2 (THE CERTIFICATE'S INPUT).** The certificate prices a polymer through per-plaquette coefficients by sums of non-negative
terms increasing in each coefficient (RESULTS 6 (a): the leaf sum, z₁, z_surf, z_br, ρ, the s-tail). Hence the single-touch exit gas
passes whenever the certificate passes at
  c_l := a′_l · sup over polymers (X, l′) and P ∈ X with l′_P = l of (1 + Σ_{C∋P: P∈S(C)} y_{C,P}),
for SOME admissible charging. Two consequences for the call. (i) The spin-1 input prices CREATED spin-1 flux wherever it occurs: branch
pieces (z_br, ρ), and equally the lone wall (z₁, "a lone wall weighs d_j a_j|r|", S1 §14) and the integer-spin pieces (z_surf); so the sound
call passes c₁ as the COEF spin-1 entry itself — the WALL door replaces a₁ in z_br and ρ only and leaves the lone wall at a′₁. (ii) The
spin-½ input c_½ carries the CREATING half-integer bonds as well as the modifying ones: RESULTS 4 (b)(ii)'s HALF = 1 + r_mod is the modifying
part alone, while the (½,½) mode is a creating bond with r_½½ = b̂(1,1)/(2a′_½)² = 0.392 / 1.046 / 0.275 / 1.213 at the four cells. M5's
"vortex half, unpriced" (his §5.1 (c), E4) is the spin-½ instance of this corollary, not a separate axis.

**Corollary 3.3 (the three printed numbers graded).**
(a) THE READER'S FLOOR (0.30–0.54) is not an instance of Lemma 3.1. Its s_one adds at the wall plaquette P the (½,1) mode that puts spin 1
at the OTHER plaquette — pure creation at P needs the component at P to equal the flux at P — a factor 2 over its own convention (M5 §5.1
(a)). Its remaining structure charges each bond at P alone with |b̂|^{1/2}; that meets the orientation's requirement (an absolute increment
≥ |b̂|/(d a′)_Q) iff (d a′)_Q ≥ |b̂|^{1/2}: TRUE for spin-½ partners at the read cells (0.146 ≥ 0.028 at W2L2 ordered), so on the (½,1)
bonds it overcharges — valid, loose — and FALSE for spin-1 partners ((d a′)₁ = 0.0027 < 0.0090 = |b̂(2,2)|^{1/2}). And the (1,1) bond is
absent: the reader classes (2,2) as modifying only, but on two bare plaquettes it CREATES a two-plaquette wall, relative content
r₁₁ = b̂(2,2)/(3a′₁)² = 11.17 / 35.9 / 2.71 / 42.7 at the four cells — the largest wall input on any record, priced by none.
(b) M5'S COPLANAR SUM (0.038–0.068) is the reader's charge over four coplanar positions in one orientation: valid on the (½,1) part,
silent on the (1,1) part and on the sixteen bent positions; neither a bound nor sharp.
(c) THE LITERAL MAX (0.0093–0.0167) IS NOT A BOUND. Counterexample at W2L2 ordered: the 2×2 wall square (the middle cross-section of a
2×2×2 cube whose boundary is the leaf — eight outer links on the leaf at multiplicity two, four inner links carrying two wall plaquettes
each; a legitimate decorated polymer). Its four (1,1) bonds give the single-touch weight (the 4-cycle's disjoint bond sets: ∅, four single
bonds, two perfect matchings) c⁴ + 4bc² + 2b² = 1.5694·10⁻⁸, c = 3a′₁ = 0.0027004, b = |b̂(2,2)| = 8.1440·10⁻⁵; the MAX prices each
plaquette at max(c, b^{1/2}) = 0.0090244 and gives b² = 6.6324·10⁻⁹ — below the true weight by ×2.37; a 2×k wall strip has F_{k+1} perfect
matchings, so the deficit grows without bound with the wall. At spin ½ the MAX returns the Wilson coefficient for every bond weaker than
the Wilson unit — every (½,½) bond at the read cells (b̂(1,1)^{1/2} = 0.091 < 2a′_½ = 0.146) — while the true weight carries (1 + r) = 1.39
per bond.
(d) **DECIDED: none of the three printed numbers is the certificate's input.** The input is c_l of Corollary 3.2 under an admissible
charging. The sharp choices at the read cells: (½,½) bonds by ORIENTATION inside the leaf (a closed leaf with every link of multiplicity two
has a 4-regular dual graph, whose Eulerian orientation charges each plaquette at most twice: c_½ = a′_½·HALF·(1 + 2r_½½)); (½,1) bonds by
ORIENTATION AT THE WALL END (relative r_½1 = |b̂(2,1)|/((3a′₁)(2a′_½)) = 2.00 / 5.62 / 0.79 / 5.79; in absolute units each adds
|b̂(2,1)|/(2a′_½) to the wall plaquette's 3a′₁ — five times below the reader's |b̂|^{1/2}); (1,1) bonds by the SPLIT (each end pays
r₁₁^{1/2} = 3.34 / 5.99 / 1.65 / 6.53) or by orientation, whichever is smaller on the configuration.

### 3.3 What the sharp input reads at the four record cells (the record's truncated-staple modes; the coplanar mode used at every position,
the sixteen bent positions UNREAD — each line a reading of the convention, not of the bent object)

A wall plaquette's charge is a sum over its four links: an ATTACHMENT link (two leaf plaquettes there at multiplicity two: two (½,1)
partners, charge 2r_½1) or an INNER link (one wall partner: charge r₁₁^{1/2}). The configurations the dressing weighs most — a branch piece
hanging from one attachment link — have one attachment and up to three inner links; the lone wall (z₁) has four attachment links; the
supremum over all local configurations (up to five partners per link in four dimensions) is far larger.

| cell | c_½ = a′_½·HALF·(1 + 2r_½½) | reach u* (§2d / M5) | wall factor 1 attach + 3 inner | lone wall (4 attach) | c₁ (1+3) / (4 att) | W* |
|---|---|---|---|---|---|---|
| W2L2 ordered | 0.0728·1.005·1.785 = 0.1306 | ≈ 0.128–0.134 | 1 + 4.0 + 10.0 = 15.0 | 1 + 16.0 = 17.0 | 0.0135 / 0.0153 | 0.0141 |
| W2L2 cancelling | 0.0554·1.005·3.092 = 0.1720 | ≈ 0.128–0.134 | 1 + 11.2 + 18.0 = 30.2 | 1 + 45.0 = 46.0 | 0.0162 / 0.0247 | 0.0142 |
| W3L2 ordered | 0.1216·1.021·1.550 = 0.1925 | 0.124 | 1 + 1.6 + 4.9 = 7.5 | 1 + 6.3 = 7.3 | 0.0274 / 0.0267 | 0.0102 |
| W3L2 cancelling | 0.0759·1.018·3.425 = 0.2647 | ≈ 0.128–0.134 | 1 + 11.6 + 19.6 = 32.2 | 1 + 46.3 = 47.3 | 0.0307 / 0.0451 | 0.0141 |

**At the record's own cells the sharp input fails both axes at three of four cells and sits at the edge of the wall axis at W2L2 ordered,
on the COPLANAR mode values alone.** The spin-½ axis fails wherever r_½½ > ≈ 0.4 (both cancelling cells, by ×1.3–2); the wall axis is
carried by the (1,1) bond everywhere. These are truncated-staple modes; §6 re-reads them on exact staples.

**THE ANSWER TO ITEM 1, AT ITS STRENGTH.** M5's and M7's floors are one object (the (½,1) share) at different multiplicities against one
ceiling W*. The certificate's derivation (Lemma 3.1 through RESULTS 4 (a)) decides the convention: a SUM over the bonds of the polymer
through the plaquette, each bond charged by an admissible charging with the partners' charges included; the MAX is refuted at ×2.37 on a
2×2 wall; the reader's floor overcharges the (½,1) bonds and omits the (1,1) bonds; the certificate's input is c₁ of Corollary 3.2 passed
as the COEF spin-1 entry (lone walls and integer-spin pieces included), together with c_½ carrying the creating (½,½) bonds. PROVED: Lemma
3.1 and Corollaries 3.2–3.3 for the single-touch terms. OPEN, named: the multi-touch terms (a plaquette carrying components of two or more
bonds) — second order in the bond coefficients at a plaquette, with Σ_j (d a′)_j N(l; j, k₁…k_m) ≤ (Π_i d_{k_i}/d_l)·w′(1) since
N(l; j, K) ≤ d_j d_K/d_l — whose charging is the next lemma; the bent positions; the relative-orientation modes.

---

## 4. PART 2 — THE CAP LIMIT, AND THE CERTIFIED BOUND ON THE SURFACES BEYOND THE CAP

### 4.1 Where a′_½ converges (READINGS; §2b–2c)

The plaquette cap of the record moved a′_½ because it truncated the STAPLES: of the two-step object's 360 fine plaquettes, 328 are staples
(24 links with five, 52 with four), evaluated pointwise at their link's quadrature nodes, and the truncated weight w_W is wrong by
O(1) near anti-alignment (w_W(−1)/w(−1) = 8.6 at W = 2, −1.6 at W = 3, 1.7 at W = 4) — so every datum with a staple near −1 (the cancelling
datum's −1 and ±iσ staples; every flipped datum of M7 §2d) swings with the cap, and the ordered datum's aligned staples converge slowly
from below (the truncated weight is broader than e^{β cos φ}, the boundary field weaker). With the staples exact and only the 2n² face
plaquettes truncated (they sit near the identity, relative error ≈ 3·10⁻⁴ at a typical angle 0.5 for W_f = 4):

| object | datum | HEAD W2 / W3 / W4 (/W5 / W6) | EXACT staples W_f = 2 / 3 / 4 / 5 / 6 | limit (READING) | a′_½ | β_eff |
|---|---|---|---|---|---|---|
| one step (n = 2) | ordered | 0.62104 / 0.76980 / 0.81492 / 0.82442 / 0.82583 | 0.80183 / 0.82370 / 0.825885 / 0.825988 / 0.825990 | 0.825990 | 0.412995 | 1.85 |
| one step | cancelling | 0.48631 / 0.50117 / 0.56064 / 0.56268 / 0.56388 | 0.54585 / 0.56244 / 0.563899 / 0.563966 / 0.563968 | 0.563968 | 0.281984 | 1.19 |
| two steps (n = 4) | ordered | 0.14557 / 0.24325 / 0.27890 | – / 0.287062 / 0.288107 | 0.28816 ± 10⁻⁴ | 0.14408 | 0.583 |
| two steps | cancelling | 0.11071 / 0.15189 / 0.18603 | – / 0.190058 / 0.190726 | 0.19076 ± 10⁻⁴ | 0.09538 | 0.384 |

The exact-staple series converges super-exponentially (one step: increments 2.2·10⁻², 2.2·10⁻³, 1.0·10⁻⁴, 2.6·10⁻⁶), and the HEAD series
reaches its limit from below only at W6 (one step). **ITEM 2's FIRST ANSWER: a′_½ converges, at the pinned data, to 0.1441 (ordered) and
0.0954 (cancelling) two steps up from β = 2.2** — the record's W2L2 values were 49 % / 42 % of the limit. The certificate (§2d): the ordered
limit FAILS on the one-plaquette part alone (LHS = 11α at a′₁ = 10⁻¹²), the cancelling PASSES with α/LHS ≈ 25 (reach u* = 0.1339 at its a′₁).
The (2,0) class — a′₁ at W_f = 4 — and the full class table at W_f = 3 are §6.

### 4.2 The certified bound on the surfaces beyond the cap (PROVED + CERTIFIED; record `rec/tail.2026-11-02a.txt`)

**Lemma 4.1 (THE GRÜSS TAIL).** Let an object's integrand be Π_p w(U_p) over n truncated plaquettes times any fixed non-negative factor
(the exact staples), and suppose sup_U |w − w_W|(U)/w(U) ≤ δ < 1. Then for every observable f with osc f ≤ 4 (χ_½, and any |f| ≤ 2),
  |E_W[f] − E_∞[f]| ≤ ((1 + δ)/(1 − δ))^n − 1 =: B(n, δ).
*Proof.* Write w_W = w(1 − g), |g| ≤ δ, and X := Π_p (1 − g(U_p)) ∈ [(1 − δ)^n, (1 + δ)^n]. With P the exact probability, E_W[f] =
P(fX)/P(X), so E_W[f] − E_∞[f] = Cov_P(f, X)/P(X). Grüss' inequality |Cov(f, X)| ≤ ¼ osc(f) osc(X) and P(X) ≥ (1 − δ)^n give the bound with
osc X ≤ (1 + δ)^n − (1 − δ)^n. ∎
**The constant, certified** (gawk -M at 256 bits, the Bessel series' tails bounded, every quantity rounded in the safe direction):
δ_W ≤ T_W/w(−1), T_W = Σ_{s>W}(s + 1)² I_{s+1}(β)/I₁(β) (the sup of |χ_{s/2}| is s + 1), w(−1) = βe^{−β}/(2I₁(β)) ≥ 0.0636768 at β = 2.2:

| W | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
|---|---|---|---|---|---|---|---|---|---|
| δ_W ≤ | 1.08 | 0.218 | 0.0375 | 5.6·10⁻³ | 7.4·10⁻⁴ | 8.8·10⁻⁵ | 9.4·10⁻⁶ | 9.2·10⁻⁷ | 8.3·10⁻⁸ |
| B(8, δ): one step, faces only | – | 34 | 0.82 | 0.094 | 0.0119 | 1.4·10⁻³ | 1.5·10⁻⁴ | 1.5·10⁻⁵ | 1.3·10⁻⁶ |
| B(32, δ): two steps, faces only | – | – | 10 | 0.43 | 0.049 | 5.6·10⁻³ | 6.0·10⁻⁴ | 5.9·10⁻⁵ | 5.3·10⁻⁶ |
| B(360, δ): two steps, every plaquette (HEAD) | – | – | – | 56 | 0.71 | 0.065 | 6.8·10⁻³ | 6.6·10⁻⁴ | 6.0·10⁻⁵ |

**What it says.** (i) The exact-staple door is worth a factor 11 in the exponent n at two steps (360 → 32): a certified tail at the 0.5 %
level needs W = 10 with truncated staples and W_f = 9 with exact ones. (ii) It is a sup-norm bound: δ_W is set at anti-alignment (φ = π),
where the face plaquettes almost never sit, so it is vacuous exactly where the readings converge fastest (W_f = 4–6: observed increments
10⁻⁴–10⁻⁶ against B ≥ 0.8). (iii) The two-step contraction at W_f = 9 is out of reach (the state grows ≈ (Σ_{s≤W}(s+1)²)⁴, 55⁴ → 385⁴), so
**no per-plaquette sup bound certifies the two-step cap tail**; the one-step object at W_f = 9–10 (state ≈ 10⁶, the rep-matrix table of
the quadrature 2–4 GB as written, to be computed on the fly) is certifiable to 1.4·10⁻³–1.5·10⁻⁴.
**The sharp object, named.** The Grüss argument along the interpolation w_s = w_W + s(w − w_W) gives |E_∞ − E_W| ≤ 2 sup_s Σ_{p∈faces} E_s|g_p|,
and E_s|g_p| ≤ δ_W(φ₀) + δ_W·μ_s(φ_p > φ₀), with δ_W(φ₀) the relative error on [0, φ₀] (2.8·10⁻⁴ at φ₀ = 0.5 for W = 4) and μ_s(φ_p > φ₀) ≤
E_s[(1 − χ_½(U_p)/2)^k]/(1 − cos φ₀)^k — moments of ONE FACE PLAQUETTE's character, which the engine computes by changing that plaquette's
coefficient vector (χ_k w = Σ_s (s+1)a_s χ_{s/2}χ_k). The remaining step is the uniformity in s (the interpolating measures), the next lemma.

---

## 5. THE COORDINATOR'S GATE (received 10:0x): U(1) THROUGH THE SAME PIPELINES — STAKES WRITTEN BEFORE THE RUNS (10:1x EST)

The gate: a valid decider refuses U(1) at every scale where U(1) is in its Coulomb phase; a pipeline that lands U(1) there is IR-truncated and
cannot decide the crossing for SU(2) either. Two places (the coordinator's precision): Wilson β = 1.2 (Coulomb by NUMERICS only — a pass there
is strong evidence of truncation, not a refutation), and the Villain action at large β_V, where Guth 1980 and Fröhlich–Spencer 1982 PROVE
the Coulomb phase for β_V ≥ β₀ with β₀ not computed — so a pipeline that lands U(1)-Villain at EVERY large β_V contradicts the theorem.

Instrument: `code/w2u1x.c` = HEAD's `w2_u1.c` with a supplied-coefficient door (U1_COEF), a Villain door (U1_VILLAIN: a_n = e^{−n²/(2β)}) and
the bent object refused. Known answers (record `rec/u1kat.2026-11-02a.txt`, ALL MET): the door unset reproduces the record's two-step ordered
β = 1.2 cell (0.3010471616240; the (−1,1) moment 5.106496271959·10⁻²) — planar equals the record's "bent" at the ordered datum, as §18 says;
the door with I_n/I_0(1.2) reproduces it to every digit; the free Villain KAT at β = 3, E[e^{iΦ}] = e^{−16/6} = 0.0694835, met.

THE PIPELINES. P1 = the pinned composition (the two-step pinned one-plaquette action fed to the exact one-step map at pinned coarse data:
three steps n = 2, four steps n = 4) — the object of §§2c–2d, 6. P2 = the typical datum (the marginal coefficients and the adjacent-pair
modes with the sharp pricing of §3) — §7. "Lands" = a₁ below the SU(2) certificate's reach u* ≈ 0.134 (the category crossing M7 §3.6
used, the U(1) leaf factor moving it ≈ 3 %), and in U(1)'s own normalisation, a₁ below I₁/I₀(1.011) = 0.450 (Wilson) or e^{−1/(2·0.64)} =
0.458 (Villain, β_c ≈ 0.64): the one-plaquette action inside U(1)'s CONFINING range.

STAKES.
G1 (P1, Wilson 1.2): from the record's two-step pinned actions (a₁, a₂) = (0.30105, 0.00858) ordered, (0.22316, 0.00330) cancelling — both
already inside U(1)'s confining range (β_eff 0.63 / 0.46) — the third step LANDS at every coarse datum (random: ≈ a₁⁴ = 0.0082 / 0.0025;
ordered: perimeter-enhanced, below 0.134), the fourth deeper still. P1 IS IR-TRUNCATED AT 1.2.
G2 (P1, Villain β_V = 2, 4, 8): the two-step pinned a₁ does NOT land (β_V = 4: 0.7263 read in the timing run), but each pinned step lowers
β_eff by a β-independent factor (the free photon has no scale; the stake: ≈ 0.6 per step), so P1 lands U(1)-Villain after ≈ log(β_V/0.64)/
log(1/0.6) steps at EVERY β_V — contradicting the theorem: P1 REFUTED OUTRIGHT as a decider. Staked numbers: two-step β_eff = β_V × [0.3, 0.5].
G3 (P2, Wilson 1.2, typical datum): from the MC readings at n = 1, 2, 4 (a₁ = 0.752, 0.452, 0.151; planar r = 0.005, 0.048, 0.36): the
adjacent-pair-priced coefficient FAILS at two steps (0.151 × (1 + 2·0.48) ≈ 0.30) and, by the Gaussian (free-photon) law a(n) = e^{−⟨Φ²⟩/2},
r(n) = cosh⟨Φ_AΦ_B⟩ − 1 with both exponents linear in n/β, LANDS at n = 16 (four steps). P2 IS IR-TRUNCATED.
G4 (P2, Villain/Gaussian limit, every β_V): the same law lands the free photon at n ≈ c·β_V for every β_V — contradicting the theorem: P2
REFUTED OUTRIGHT as a decider. The quantity a valid decider must contain: the bonds at ALL sizes and distances with the certificate's
exponential weight (E5); in the Gaussian theory the k-plaquette chains' relative contents grow like e^{(k−1)|C_AB|}, so the full-bond KP sum
diverges at every n ≥ O(β_V) — the full certificate REFUSES U(1) where the truncated pipelines land it.

---

## 6. THE TWO-STEP ACTION ON EXACT STAPLES, PRICED SHARPLY (records `rec/x_n4_{ordered,cancel}_Wf3_L2C2diag.2026-11-02a{,.modes}.txt`,
`rec/x_n4_*_Wf4_L2C0diag.2026-11-02a.txt`, `rec/sharp.2026-11-02a.txt`) — READINGS, planar, pinned data

**Positivity of every truncation used (record `rec/posit.2026-11-02a.txt`; the coordinator's point 2).** min_φ w_W(φ) at β = 2.2: W2
+0.0710, W3 **−0.1050 (SIGNED, at φ = π)**, W4 +0.0868, W5 +0.0539, W6 +0.0654, W7, W8 positive. Exact staples are positive by construction.
So the W_f = 3 class table below is a ratio of SIGNED integrals (the face plaquettes' weight negative near φ = π, where they almost never
sit); the W_f = 4 runs are positive and agree with it to 0.36 % (E[χ_½]) and 1.1 % (E[χ₁]) — the record's W3L2 cells (M7's and §3.3's) are
signed-integral readings too, and are labelled so from here on. The third-step inputs (§8) are positive (1 + 2a χ_½ + 3a₁χ₁ ≥ 0.72).

| two steps, exact staples | a′_½ (W_f 4) | a′₁ W_f 3 / W_f 4 | r_½½ | r_½1 | r₁₁ | r_mod / pair | c_½ | c₁ (K = 1 / K = 4) | certificate (LOCAL α-scan) |
|---|---|---|---|---|---|---|---|---|---|
| ordered | 0.144053 | 0.0057490 / 0.0058138 | 0.2527 | 0.5876 | 1.713 | 2.16·10⁻³ | 0.2254 | 0.0351 / 0.0328 | FAIL (no root) |
| cancelling | 0.095363 | 0.0020508 / 0.0020743 | 1.0256 | 3.361 | 17.87 | 2.16·10⁻³ | 0.3025 | 0.0418 / 0.0572 | FAIL (no root) |

(The modes at W_f = 3; the sharp inputs by `code/sharp.awk`: the (½,½) bonds oriented when r < 4, split otherwise, four leaf neighbours;
the (½,1) bonds charged at the wall end; the (1,1) bonds split; the coplanar mode used at every position, the bent ones unread.)
**Exact staples moved the relative contents down by ×2–7 against the record's W2L2** (r₁₁ 11.2 → 1.7 ordered) because the marginals rose
(a′₁ ×6.4: the spin-1 marginal had been the staples' worst casualty) — but they did not move the verdict: **with the pair bonds priced by
the derivation of §3, the two-step action FAILS at both pinned data**: the ordered datum on its one-plaquette part alone (a′_½ = 0.1441 >
u* = 0.1339), the cancelling datum on the surface dressing (r_½½ ≈ 1.03 triples c_½) and on the walls (c₁ = 0.042–0.057 against W* ≈ 0.014).
The one-plaquette PASS of the cancelling datum (§2d, α/LHS ≈ 25) does not survive its own pair modes.

---

## 7. THE TYPICAL DATUM, READ (Monte Carlo — READINGS ONLY, never a proof input; `code/hb.c`, record `rec/hb_L12_b2.2.2026-11-02a.txt`)

**Why.** The pinned objects condition on a FROZEN fine outside. By the tower property, the average of the two-face object's E[χ_a(A)χ_c(B)|ω]
over ω drawn from the Wilson measure IS the marginal moment E[χ_a(A)χ_c(B)] of the blocked measure — the fibre-averaged object the pinned
engines only bracket; for the one-plaquette moment it is the n × n Wilson loop itself, E[χ_½(A)] = 2⟨W(n, n)⟩. A heat bath (Kennedy–Pendleton)
on 12⁴ at β = 2.2, 300 configurations after 300 sweeps, every site and plane averaged; the plaquette 0.56912 ± 0.0001 against the
literature's 0.5689 (the known answer).

| n (steps) | a′_½ = ⟨W(n,n)⟩ | a′₁ | r_½½ planar / bent | r_½1 planar / bent | pinned ordered / cancelling a′_½ (exact staples) |
|---|---|---|---|---|---|
| 2 (one) | 0.135908 ± 0.00015 | 0.006724 ± 0.00006 | 0.030 / 0.133 | 0.06 / 0.33 | 0.4130 / 0.2820 |
| 4 (two) | **0.001357 ± 0.00009** | (6 ± 6)·10⁻⁵ | unresolved (|conn| ≲ 2.4·10⁻⁴ at 2σ against a product 7.4·10⁻⁶) | unresolved | **0.1441 / 0.0954** |

**THE PINNED DATA ARE EXTREME POINTS.** The fibre-typical two-step coefficient is 0.00136 — 106× below the ordered datum's and 70× below the
cancelling's; at one step 0.136 against 0.413 / 0.282. The frozen outside is the classical vacuum, a measure-zero boundary that aligns every
staple and dresses the loop with a perimeter-law factor; the fibre at β = 2.2 is thermal (plaquette 0.57), and its typical boundary carries
no such alignment. In the certificate's currency: ONE step from 2.2 the typical datum sits at the window's edge (0.136 against u* ≈
0.134), and with its pair dressing (bent r ≈ 0.13: c_½ ≈ 0.136·1.27 = 0.17) just outside; TWO steps put it 100× inside on the one-plaquette
part, and even the 2σ upper bound on its unresolved pair modes leaves c_½ ≤ 0.00136·(1 + 4·50^{1/2}) = 0.040, inside. **As readings: the
crossover from β = 2.2 lands at TWO steps at the typical datum on its one-plaquette and surface parts**; the wall part at two steps is
unresolved by this statistics (|b̂(1,2)|, |b̂(2,2)| ≲ 2·10⁻⁴ at 2σ against a′₁ ≲ 2·10⁻⁴). §5's gate decides what that reading is worth.

---

## 8. THE THIRD AND FOURTH STEPS (records `rec/s3_*`, `rec/sharp.2026-11-02a.txt`, `rec/step4.log`) — READINGS on a model

The exact one-step map (n = 2) and two-step map (n = 4) run on the two-step ONE-PLAQUETTE action (W2_COEF: a′_½, a′₁ of the exact-staple
two-step objects, entries above spin 1 zero; face cap 2 makes the finite input exact on faces and staples alike; the input is positive),
at pinned COARSE data. The model omits the two-step action's pair bonds from the input; the proxy "orddr" folds them in as the dressed
coefficients (c_½, c₁) of §6.

| input | coarse datum | three steps a‴_½ | r_½½ | c_½ (sharp) | c₁ (sharp, max K) | cert | four steps a⁗_½ | cert |
|---|---|---|---|---|---|---|---|---|
| ordered (0.1441, 0.0036) | ordered | 0.007849 | 2.16 | 0.0417 | 0.00114 | PASS | 3.2·10⁻⁵ | PASS |
|  | cancel | 0.002154 | 33.3 | 0.0519 | 0.00109 | PASS | 5.4·10⁻⁶ | PASS |
|  | random:1 / :2 | 4.32 / 4.55·10⁻⁴ (= a⁴ = 4.31·10⁻⁴) | 0.12 / 0.00 | 5.3·10⁻⁴ | ≈ 0 | PASS | ~10⁻¹⁰ | PASS |
| cancelling (0.0954, 0.00095) | ordered / cancel / random | 8.4·10⁻⁴ / 2.2·10⁻⁴ / 8.3·10⁻⁵ | 8.1 / 119 / 0.03 | ≤ 0.0104 | ≤ 5·10⁻⁵ | PASS | ≤ 2·10⁻⁵ | PASS |
| dressed proxy (0.2254, 0.0351) | ordered | 0.07833 | 0.41 | 0.1439 | 0.0173 | FAIL | — | — |
|  | cancel | 0.02829 | 5.67 | 0.2986 | 0.0289 | FAIL | — | — |
|  | random:1 | 0.002637 | 0.30 | 0.0042 | 4·10⁻⁶ | PASS | — | — |

**The third step lands the one-plaquette input at every coarse datum, the fourth by orders of magnitude** (the random coarse datum is the
area law a⁴ to 0.3 %, the ordered one perimeter-enhanced ×18) — and with the two-step bonds folded in, the frozen coarse data fail again
while the random one passes ×30. **These numbers are refuted as a decider by §5's gate**: the same composition lands U(1).

---

## 5R. THE GATE, RESULTS (records `rec/gate.2026-11-02a.txt`, `rec/gate2.2026-11-02a.txt`, `rec/gauss.2026-11-02a.txt`, `rec/g4.2026-11-02a.txt`,
`rec/hbu1_L12_b{1.2,0.9}.2026-11-02a.txt`, `rec/hbu1_L24_b1.2.2026-11-02a.txt`) — EVERY PIPELINE OF THIS FILE LANDS U(1); NONE IS A DECIDER

**G1 HELD (P1, Wilson β = 1.2, from the record's positive two-step inputs).** Three steps: ordered input → coarse ordered 0.2076, cancel
0.0976, random 0.0069; cancelling input → 0.0963, 0.0334, 0.0022. Four steps: 0.0324 / 0.0143 / 6·10⁻⁸ and 0.0065 / 0.0020 / 10⁻¹⁰. Every
cell is inside U(1)'s confining range at three steps and below 0.134 at four (one cell, ordered/ordered at three steps, 0.208, refutes the
stake's "every coarse datum at three steps" and lands at four). **P1 lands U(1) at 1.2 — strong evidence (1.2 is Coulomb by numerics) that
P1 is IR-truncated.**
**G2 HELD, AND THE MECHANISM IS SCALE-FREE (P1, Villain).** The two-step pinned map takes β_V = 2, 4, 8 to β_eff (by a₁ = e^{−1/(2β)}) 0.782,
1.564, 3.126 at the ordered datum: ratio 0.391 at all three (cancelling: 0.646, 1.13 at β_V = 2, 4). The free photon has no scale, so the
pinned composition lowers β by the same factor 0.391 every two steps at every β_V and enters U(1)'s confining range after ≈ 2 log(β_V/0.64)/
log 2.56 steps; read: β_V = 2 lands at three steps (random coarse datum 0.046) and four (ordered 0.190 → confining range); β_V = 4 (the input
carried to |n| ≤ 6, positive — the |n| ≤ 2 truncation was SIGNED, min −0.032, and its random-datum reading −0.336 is discarded) lands at
four steps (random 0.0245; ordered 0.441, β_eff 0.61 < 0.64). Since the landing occurs at EVERY β_V, it occurs above the uncomputed β₀ of
Guth and Fröhlich–Spencer: **P1 IS REFUTED OUTRIGHT AS A DECIDER** (it lands a theory proved to be in its Coulomb phase). The β_V = 8 cells
with the |n| ≤ 8 input are in flight (§5R′).
**G3 (P2, Wilson 1.2, typical datum).** MC: a(n) = ⟨cos Φ(n×n)⟩ = 0.7519, 0.4521, 0.1506 (n = 1, 2, 4; L = 12) and 0.0157 (n = 8; L = 24,
running mean): perimeter law. Planar / bent adjacent-pair relative content r = 0.005 / 0.011, 0.048 / 0.079, 0.36 / 0.48 (n = 1, 2, 4):
GROWING with the block, the Coulomb signature (the shared edge's flux covariance grows linearly with n). The sharp P2 coefficient: n = 4
c = 0.151·(1 + 2·0.48) = 0.30 FAIL; n = 8 (Gaussian r ≈ 7 at the matched coupling 0.86) c ≈ 0.18 FAIL; n = 16 LANDS (below).
**G4 HELD (P2, the free photon = the β_V → ∞ limit of the Villain action).** The exact Gaussian flux variances (`code/gauss.c`, the lattice
Green's function through the 2D/1D lattice propagators by the AGM; converged to 10⁻⁶ between M = 256 and 512; the known answer β⟨Φ²⟩ = ½
for one plaquette in four dimensions, MET to 10⁻⁶): β⟨Φ_A²⟩ = 0.500, 1.369, 3.261, 7.168, 15.115, 31.150 (n = 1…32: n − 0.85, the
perimeter law); β⟨Φ_AΦ_B⟩ = −0.069, −0.250, −0.689, −1.630, −3.582, −7.556 planar, +0.108, 0.327, 0.804, 1.781, 3.769, 7.793 bent. The
coupling matched to the Wilson-1.2 MC at n = 4 (a = 0.151) is β_V = 0.86, and there the Gaussian law gives a(8) = 0.0155 against the MC's
0.0157. **P2 lands the free photon at n* = 16, 16, 32, 64, 128, 256, 512 for β_V = 0.86, 1.2, 2, 4, 8, 16, 32 — n* ≈ 16 β_V, at every
coupling: P2 IS REFUTED OUTRIGHT AS A DECIDER.**

**WHAT A VALID DECIDER MUST CONTAIN (PROVED for the free photon; the mechanism general).** Both pipelines read LOCAL objects — a one-plaquette
coefficient, an adjacent pair — and with the holonomy block map every local coefficient decays with the block in ANY phase: the coarse
holonomy carries the fine perimeter's noise (E[cos Φ] = e^{−(n − 0.85)/(2β)} for the photon), so smallness of the one-plaquette coefficient
is generic and confinement is not in it. The Coulomb phase lives in the bonds at ALL distances: two coarse n×n plaquettes at separation R ≫ n
carry the dipole covariance C(R) ≍ n⁴/(βR⁴) (the photon's field-strength correlator), so their relative content is ≍ C(R), and the
certificate's per-plaquette sum over bonds with its exponential weight, Σ_R #(R) r(R) e^{αR} with #(R) ≍ R³ coarse plaquettes at distance R,
diverges for every α > 0 (and logarithmically even at α = 0). **The full certificate (E5, all bonds) refuses U(1)'s Coulomb phase at every
scale; the truncated pipelines land it.** The decider is the DECAY OF THE BLOCKED ACTION'S BONDS WITH DISTANCE — §9 reduces it to the fibre.

---

## 9. PART 4 — THE OBJECT THE CERTIFICATE NEEDS, AND WHAT THE EXACT ENGINES REACH

**9.1 The object.** The exit lemma (8bcfffd) consumes the blocked action A_k = −log ℓ_k at the exit scale as ONE function of the coarse
links: a decomposition ℓ_k = Π_P w′(v_P) Π_C (1 + b_C(v_C)), b_C depending on the links of C only, whose Fourier data — a′_j and every
b̂_C(ρ), C of every size and extent — are priced per plaquette by Corollary 3.2 (c_l, a supremum over POLYMER POSITIONS of the gas, not over
environments of the measure) and summed with the certificate's weight e^{α|L(C)|} (E5), uniformly in the cutoff. No coarse-environment
supremum enters: the Kotecký–Preiss expansion integrates the coarse field itself. So M2b's Theorem A1 (single-site criteria need the
coarse-environment supremum) is not the obstruction on this road; the obstruction is LOCALITY — the decay of the bonds — and §5R shows it is
exactly where the gap lives (the free photon's bonds decay like R⁻⁴ and the certificate refuses it at every scale).

**9.2 Lemma 9.1 (LOCALITY OF THE BLOCKED ACTION IS FIBRE CLUSTERING; PROVED).** Holonomy block map, Wilson weight. Let m ≠ n be coarse links,
f ∈ π_m and f′ ∈ π_n free fine links lying in no common plaquette, X, Y ∈ su(2) with ‖X‖ = ‖Y‖ = 1, and v(s, t) the coarse configuration with
v_m ↦ e^{sX}v_m, v_n ↦ e^{tY}v_n, realised at f and f′ (M5 Cor. 2.2). Then
  ∂_s ∂_t log ℓ_k(v(s, t))|_{(0,0)} = Cov_{ν(·|v)}(Φ^f_X, Φ^{f′}_Y),  Φ^f_X := d/ds Σ_{p∋f} log w(U_p(s)), |Φ| ≤ 6β,
the fibre covariance of the two local forces. Hence if the fibre satisfies Hypothesis II(b) on local observables, |Cov_ν(F, G)| ≤
K′ρ′^{dist(supp F, supp G)}‖F‖‖G‖, every mixed second derivative of the blocked action between coarse links at fine distance d is at most
36β²K′ρ′^{d−2}.
*Proof.* (i) The left multiplication at f by an element depending on other links preserves Haar measure and carries the fibre over v(0, t)
onto the fibre over v(s, t), so d/ds log ℓ_k(v(s, t)) = ν(Φ^f_X | v(s, t)) (M4 Thm 4.1's first step; M5 Cor. 2.2). (ii) Likewise the
multiplication at f′ is a Haar-preserving bijection of fibres, and for any bounded G, ν(G | v(s, t)) = ∫(G∘T_t)(W∘T_t)/∫(W∘T_t) with W the
product of plaquette weights over the fibre; differentiating, d/dt ν(G | v(s, t)) = ν(∂_t(G∘T_t)) + Cov_ν(G, Φ^{f′}_Y). (iii) With G = Φ^f_X,
a function of the links of the six plaquettes through f, none of which contains f′, ∂_t(G∘T_t) = 0. (iv) |d/ds log w(U_p(s))| ≤ β for
the Wilson weight (|d/ds ½tr(e^{sX}V)| ≤ 1), six plaquettes through f. The supports of the two forces are at distance ≥ d − 2. ∎
**What it settles.** The certificate's E5 — bonds of every size summable with exponential weights — follows at the pair level from
Hypothesis II(b) by integrating the mixed derivatives along coarse paths (the higher Möbius terms need the cumulant form of II, the same
argument with more derivatives: an n-fold mixed derivative is a joint cumulant of n local forces). So the two hypotheses of Theorem 8.5 are
not independent at the exit: **Hypothesis II at the exit scale implies the locality the certificate needs to give Hypothesis I there.**
For U(1) in the Coulomb phase with the holonomy map the fibre does NOT cluster (the integer parts of the coarse fluxes, which the coarse
angles forget, form a long-range winding sector — §5R's R⁻⁴ bonds are its trace), consistent with the gate.

**9.3 What the exact engines compute, and the bridge.** The engines compute p_ω, the law of finitely many coarse loops given the fine
outside FROZEN at ω. The bridges, with their reach:
 (B1, tower) for coarse data that are functions of ω, the fibre-averaged law is ∫ p_ω μ(dω | coarse data); every moment lies in [inf_ω, sup_ω]
of the pinned moments (M7 §1). The supremum is not attained at a typical point: at two steps the frozen ordered datum reads a′_½ = 0.1441,
the fibre-typical value is 0.00136 (§7) — the pinned extremes bracket the object by two orders of magnitude.
 (B2, force identity) every coefficient of A_k is an integral along coarse paths of FIBRE expectations of local fine forces (Lemma 9.1 (i)),
and every bond between distant coarse links a fibre covariance (Lemma 9.1). A frozen outside makes the fibre finite, so a pinned engine
can read the covariance of forces INSIDE one object and never the decay of fibre covariances with the distance between objects — which
is what the certificate needs. Every pinned object is IR-truncated by construction; §5R measures it: the composition of pinned steps
lands U(1) at 1.2 and Villain U(1) at every β_V.
 (B3, typical data) MC readings of the marginal moments are the fibre averages (no proof input); they place the crossover at two steps on
local quantities (§7) and inherit P2's IR truncation (§5R): they land the free photon at n ≈ 16β_V.
**So what the certificate needs that no engine of this tree computes is Hypothesis II at the exit scale in the averaged (L² or cumulant) form —
the clustering of the infinite fibre at O(1) coupling, THE CROSSING CAMPAIGN §21's "one open core" — and Lemma 9.1 makes it the input of the
certificate route as well as of Theorem 8.5's Hypothesis II.** The exact engines' place in that proof: the known answers (§2b), the
local Fourier data that the cumulant bounds multiply, and — with the exact-staple door — converged local data at two steps.

---

## 10. THE COORDINATOR'S FOUR POINTS AND THE TWO CORRECTIONS (10:0x–10:3x), ANSWERED

**(1) The gate** — §5, §5R: every pipeline of this file lands U(1); P1 and P2 are refuted outright as deciders by the Villain/free-photon
control (a landing at every β_V); the decider is the bonds' decay with distance, which Lemma 9.1 reduces to fibre clustering. U(1) at 1.2 is
called Coulomb BY NUMERICS throughout (a pass there is evidence, not refutation); the refutations rest on the Villain limit, where the theorem
holds for β_V ≥ β₀ (β₀ uncomputed) and the pipelines land at EVERY β_V.

**(2) W3 is signed — checked for every truncation used** (`rec/posit.2026-11-02a.txt`): at β = 2.2, W2 +0.071, W3 −0.105 (at φ = π), W4 +0.087,
W5 +0.054, W6 +0.065; at β = 3.0, **W2 −0.1712 at φ = 1.971 (SIGNED in the interior, though +0.913 at U = −1)**, W3 −0.405, W4 +0.0037, W5
−0.026, W6 +0.024. The SU(2) one-step and two-step cap series of §§2b, 4.1 use exact staples (positive) and face caps W_f = 2–6, of which
W_f = 3 (and W_f = 5 at β = 3, unused) is signed; the W_f = 3 class table of §6 is labelled a signed-integral reading, with W_f = 4 within
0.4–1.1 %. The third-step inputs are positive (≥ 0.72); the U(1) inputs truncated at |n| ≤ 2 were checked: positive at β = 1.2 and β_V = 2,
SIGNED at β_V = 4 (min −0.032) and 8 — those cells were discarded and re-run with |n| ≤ 6 / 8 (positive, min 0.0028 / pending).

**(3) The frame.** The "L" of the record's W2L2/W4L1 labels is LMAX, the loop-representation cap — not a frame. E[χ_½(A)] does not depend
on it: exact staples, W_f = 4, ordered: 0.2881066069515 at L1 and 0.2881066069513 at L2 (W_f = 3: 0.2870617630251 at both). M2b's frame
factor concerns INTEGRATING a ring of plaquettes (W2_FRAME), a different parameter; every object of this file and of §19 is frame 0. So
§19's W2L2 → W4L1 comparison is at fixed frame; what it mixed was the plaquette cap of the STAPLES (§4.1). The decisive positive reading at
L2 is in hand: W_f = 4 L2, exact staples, a′_½ = 0.144053 / 0.095363, a′₁ = 0.0058138 / 0.0020743 (ordered / cancelling). M2b's frame
factor (×0.968–0.975 per ring on E[χ_½]) points the same way as §7's typical datum: integrating the outside lowers the coefficient; the
fully integrated value is 0.00136.

**(4a) 045_R's tail 0.054 / 0.011 / 0.0019 / 0.0003 (W3–W6)** is Σ_{s>W}(s + 1)a_s (reproduced: 0.0537, 0.0110, 0.00185, 0.00021) — an
L¹(Haar) bound on ONE plaquette's truncation error (∫|χ_j| ≤ 1). It does not compose over plaquettes: a product of n weights needs the
SUP-RELATIVE error δ_W of Lemma 4.1 (T_W/w(−1): 1.08, 0.218, 0.0375 at W4–W6), and B(n, δ) = ((1+δ)/(1−δ))^n − 1 is the composed bound;
the L¹ numbers are 6–8 times smaller than T_W and enter no product.

**(4b) The sign pattern at the ordered datum** ((−1)^{(a+c−k)/2} channel signs, every f_k > 0 at the ordered datum) would give one-sided bounds
only for the PINNED object at that datum; the ordered datum is the frozen extreme, two orders above the fibre-typical value at two steps
(§7), so a one-sided bound there cannot land two steps and says nothing about the fibre average (Lemma 9.1's object). Not pursued further.

**(5) The β = 3.0 ladder (047_R / 048_R) — RE-READ** (`code/ladder3.sh`; records `rec/lad3_*`; the record's geometry and instrument, W2_ROT
by a = π at every outside link of the one-step object, ordered datum): the W2 run reproduces the record — **60 of 174 rotations RAISE the
first moment** (base 0.7592117). **With EXACT staples (W_f = 4, every weight positive) every one of the raising links read so far LOWERS it**
(link 0: W2 +0.0300 → exact −0.0272; link 3: +0.0251 → −0.0281; links 6, 8, 9, 11, 12, 14, 26, 28, 30, 31 likewise; the non-raising
links keep their sign). And the W2 weight at β = 3 is negative exactly on φ ∈ (1.7189, 2.2553), i.e. rotation angle a = 2φ ∈ (1.0943π,
1.4358π) — 047_R's "negative on θ ≈ (1.09π, 1.43π)" to the digit. **The β = 3.0 sign flips are the W2 TRUNCATION's** (signed in the
interior, and 28 % low at the a = π staple angle φ = π/2), not the theory's. (Counts completed at the end of the runs are in §11.)

**(6) TV vs moment influence.** |ΔE[χ_a]|/d_a ≤ 2·TV (the factor 2 the crossing page's lines 198/221 dropped) — noted; nothing in this file
used the moment-influence → TV step. 048_R's exact-TV idea (E[χ_a(A)] = 0 above a_max by Haar orthogonality) holds for TRUNCATED weights
only: with exact staples every character of the coarse loop is nonzero, so the exact-TV road and the exact-staple road do not combine.

---

## 11. WHAT THIS FILE ESTABLISHES, AT ITS STRENGTH (written 10:4x EST)

**PROVED (proofs on this page).** Lemma 3.1 (the charging lemma: a decorated polymer's single-touch weight is at most the Wilson weight with
per-plaquette factors 1 + Σ_{C: P∈S(C)} y_{C,P}, Π_{S(C)} y ≥ r_C — the geometric mean and the once-only orientation as cases); Corollary 3.2
(the certificate's input is c_l = a′_l·sup(1 + charges), passed as the COEF entries themselves — the spin-1 entry pricing lone walls and
integer pieces too; c_½ carries the creating (½,½) bonds); Corollary 3.3 (the reader's floor overcharges the (½,1) bonds and omits the
(1,1) bond; the literal MAX is not a bound — ×2.37 on a 2×2 wall at W2L2 ordered); Lemma 4.1 (the Grüss tail
|E_W − E_∞| ≤ ((1+δ)/(1−δ))^n − 1 for n truncated plaquettes); Lemma 9.1 (the blocked action's mixed second derivative between coarse links
is the fibre covariance of the two local forces; locality of the action follows from Hypothesis II(b)).
**CERTIFIED.** δ_W and B(n, δ) at β = 2.2 (gawk -M, 256 bits, tails bounded): a certified cap tail needs W_f = 9 (two steps, faces only:
B = 5.6·10⁻³) — beyond the engines; one step at W_f = 9–10: 1.4·10⁻³–1.5·10⁻⁴. The certificate's KATs at HEAD 88e069862 (K2 COEF + TILT
composes; K3; K4).
**READINGS.** (i) THE CAP WAS THE STAPLES: exact staples converge the one-step object by W_f = 4 to 10⁻⁴ and give the two-step limit
a′_½ = 0.1441 (ordered) / 0.0954 (cancelling); the ordered limit fails the certificate on its one-plaquette part, the cancelling passes it
(α/LHS ≈ 25) and FAILS once its pair bonds are priced (c_½ = 0.30, c₁ = 0.042–0.057). (ii) The three wall floors are one share at
×32 / ×4 / ×1; under the sharp pricing the record's cells fail at three of four and sit at the edge at W2L2 ordered. (iii) The fibre-typical
two-step coefficient (MC) is ⟨W(4,4)⟩ = 0.00136 — 106× below the frozen ordered datum; one step 0.136, at the window's edge. (iv) Three
and four exact steps on the two-step one-plaquette action land at every coarse datum. (v) THE GATE: every pipeline here lands U(1) — P1 at
Wilson 1.2 (four steps) and at Villain β_V = 2, 4 (a scale-free drift, β_eff = 0.391 β_V per two steps at β_V = 2, 4, 8), P2 at n ≈ 16β_V
for the free photon at every β_V (U(1) Wilson 1.2 MC: a(8) = 0.0153, the Gaussian law at the matched coupling 0.0155). Both are refuted
outright as deciders: the readings (iii)–(iv) carry no information about the gap. (vi) The β = 3.0 ladder's 60 sign flips are the W2
truncation's: exact staples and the positive W4 truncation lower every flipping link read (13 of 13 and 15 of 15); W2 at β = 3 is negative
on exactly the flips' angle range.

**THE CROSSOVER'S LANDING, STATED AS IT NOW STANDS.** Local data — one-plaquette coefficients, adjacent pairs, at frozen or typical data, at
any number of exact steps — cannot certify the landing: they are IR-truncated, as the U(1)-Villain control proves for the free photon. The
certificate route needs the blocked action's bonds summable at all distances with exponential weight (E5), and Lemma 9.1 makes that a
consequence of Hypothesis II at the exit scale. So **the crossover's certified landing and Theorem 8.5's Hypothesis II are one object: the
clustering of the infinite fibre (the fine field given the coarse field) at the exit scale, in a cumulant form strong enough to bound the
n-fold force cumulants with exponential decay** — group-dependent (it fails for U(1)'s Coulomb phase, whose fibre carries the winding
sector) and untouched by every finite pinned object (their fibre is finite).

**THE NEXT OBJECT, PRECISELY.** Bound Cov_{ν(·|v)}(Φ^f, Φ^{f′}) (and the joint cumulants) for the SU(2) fibre two steps up from β = 2.2,
uniformly in v and in the cutoff, by e^{−κ d(f,f′)}. The first test it must pass is the gate: the same bound must FAIL for the U(1)-Villain
fibre at large β_V. The instruments that can read it: a fibre engine with the outside INTEGRATED, not frozen — M2b's frame (W2_FRAME), grown
until the frame factor converges, read on two objects at increasing separation; its known answer is the free photon's fibre covariance,
computable exactly (`code/gauss.c` with the coarse constraint).

**CROSS-FIELD.** (1) The holonomy block map's perimeter noise (E[cos Φ] = e^{−(n−0.85)/(2β)} for the photon) is the lattice form of the
Wilson loop's perimeter divergence: local coarse coefficients are scheme-dominated, which is why Bałaban smears and why "small coefficient"
decided nothing. (2) Lemma 9.1 is Gawędzki–Kupiainen's and Bałaban's locality principle — the effective action is local iff the fluctuation
field is massive — in its exact non-perturbative form: one derivative, one fibre covariance. (3) The U(1) refusal is Polyakov's and
Guth's picture read through the block map: the coarse angles forget the integer fluxes, and the integer sector is the Villain/monopole
Coulomb gas; the decider for U(1) is Debye screening of that gas, and for SU(2) the corresponding statement is the fibre's clustering.

## 12. THE COORDINATOR'S 050_R REQUEST (10:5x) — the exact-staple door it proposes is §2a's; the missing W_f = 2 two-step cell, staked

STAKE (before the run): exact staples, two steps, W_f = 2 (positive), L2 C0: E[χ_½(A)] below the W_f = 4 value by 2–6 % (one step was
2.9 % low at W_f = 2): ordered in [0.270, 0.285], cancelling in [0.178, 0.190]; a′₁ within 10 % of W_f = 4's.

RESULT (records `rec/x_n4_{ordered,cancel}_Wf2_L2C0diag.2026-11-02a.txt`): ordered E[χ_½(A)] = 0.2762513, a′₁ = 0.0051566; cancelling
0.1825105, 0.0017833. The E stakes HELD (−4.1 % / −4.3 % below W_f = 4); the a′₁ stake REFUTED in size (−11 % / −14 %, outside 10 %).
THE EXACT-STAPLE TWO-STEP SERIES, positive caps W_f = 2 / 4 (signed W_f = 3 between): ordered 0.27625 / 0.28811 (0.28706), cancelling
0.18251 / 0.19073 (0.19006); a′₁ 0.005157 / 0.005814 and 0.001783 / 0.002074. Against the record's HEAD series (all plaquettes truncated)
0.14557 / 0.27890 and 0.11071 / 0.18603 at W2 / W4: **the record's rise with the cap was the staples' (×1.92 ordered from W2 to W4 with
truncated staples, ×1.043 with exact ones); exact staples converge where the face caps did not.** For U(1) the gate's engine already
carries the staples exactly to |n| ≤ NMAX in charge space (dropped weight 4·10⁻⁶ per plaquette at β = 1.2, NMAX 6; ≤ 10⁻⁶ in the Villain
runs), so §5R's U(1) readings are exact-staple readings in this sense. 050_R's abelian-calibration stake (a one-step moment row near 1.727)
was not read here.

## 13. AT HANDBACK (2026-11-02 10:5x EST) — the corrections of strength the review asked for, and what is still running

1. **Partial counts (§10 (5), §11 (vi)).** On disk at 10:53: the W2 β = 3.0 ladder complete (60 of 174 raise); the positive W4-truncated
   re-read 153 of 174 links, 0 raise, all 56 W2-raising links among them lower; exact staples W_f = 4: 65 of 174 at a = π and 65 at a =
   1.25π, 0 raise, all 22 W2-raising links among them lower. The two exact-staple runs continue (`code/ladder3.sh`, records
   `rec/lad3_x4_*`). The record's BENT-DEFECT geometry (W2_ALLOW_BENT) was kept deliberately, so that only the truncation varies between
   the W2, W4 and exact-staple columns: the reversal is attributable to the truncation, not to the geometry.
2. **The β_V = 8 gate cells are NOT ADMISSIBLE.** The |n| ≤ 8 input is at the edge of positivity (min 5·10⁻⁶ against a dropped a₉ of the
   same order) and its random-datum readings come back complex with |a| = 0.36 at three steps and |a| = 1.27 at four (`rec/gate2`): omitted.
   G2 rests on β_V = 2 and 4 and on the two-step drift 0.391·β_V read at β_V = 2, 4, 8 (the two-step objects themselves use the Villain
   weight carried to NMAX 8 / 10 / 14, positive).
3. **§9.2 graded at its strength.** The identity ∂_s∂_t log ℓ_k = Cov_ν(Φ^f, Φ^{f′}) is PROVED (M5's Cor. 2.2 differentiated once more).
   "E5 follows from II(b) by integrating along coarse paths" is IMPLIED, not proved: the passage from link-pair derivatives to the Fourier
   norms of plaquette bonds is named and not written; the higher Möbius terms (joint cumulants of n forces) are OPEN. And the reconciliation
   with M2b: the coarse-environment supremum does not enter the certificate's INPUTS, but it re-enters as the uniformity in v of Hypothesis
   II(b), which is what bounds them — Theorem A1's lesson moves from the inputs to the hypothesis that controls them.
4. **G4's two caveats in one sentence.** `gauss.c` is double-precision quadrature (converged to 10⁻⁶ between M = 256 and 512, the
   one-plaquette known answer ½ met), not certified arithmetic, and the free photon stands in for the Villain model at large β_V (monopole
   corrections of order e^{−cβ_V}); P2's landing margins at n* are orders of magnitude (c(n*) = 0.0056–0.036 against 0.134, and c falls
   ×100 per doubling past n*), so the verdict survives both. The u* proxy for U(1) (the SU(2) certificate's reach, the U(1) leaf factor
   moving it ≈ 3 %) is likewise a category crossing whose margins are orders of magnitude at the landing cells.
5. **Memory footprint.** The W_f = 4 (2,0)-class runs (Q3, §2c/§6) peaked at 82.4 M state entries (≈ 1.3 GB per state, two in flight inside
   process()), above the brief's 2 GB guideline for a non-decisive run; the machine had 8.5 GB free at launch. Every other run stayed below 1 GB.
6. **§7's one-step typical datum is OUTSIDE, not at the edge.** The reach at the typical a′₁ = 0.006724 is u* = 0.1254 (bisected to
   [0.125400, 0.125421]); the typical one-step coefficient 0.13591 FAILS (LHS above α at every α; record appended in this hour). One step
   from 2.2 does not land at the typical datum even on its one-plaquette part; two steps put it 100× inside (§7) — a P2 reading, refuted as a
   decider by §5R.
7. **The shared brief (re-read 10:5x)** says W2 is positive at β = 3; it is positive at U = −1 (+0.913) and SIGNED in the interior (min
   −0.1712 at φ = 1.971, exactly the flips' angle range) — §10 (2), `rec/posit.2026-11-02a.txt`.
8. **U(1) L = 24 MC complete** (`rec/hbu1_L24_b1.2.2026-11-02a.txt`, 60 configurations): a(2) = 0.45113, a(4) = 0.14875, a(8) = 0.015276 ±
   0.00008; the adjacent-pair connected moments at n = 8: planar 5.80·10⁻⁴, bent 7.34·10⁻⁴ against a² = 2.33·10⁻⁴ — relative content
   r = 2.5 (planar) / 3.1 (bent), still growing with the block (0.36 / 0.48 at n = 4); P2 at n = 8: c = 0.0153·(1 + 2·3.1) = 0.11 —
   LANDS at three steps on the read pair (the Gaussian estimate at the matched coupling had placed it at four).
9. **CORRECTION OF ITEM 8 AND OF §5R's G3 CHANNEL (10:5x, same hour).** The MC's "connected" moment is E[cos Φ_A cos Φ_B] − E[cos]², whose
   ratio to a² is cosh⟨Φ_AΦ_B⟩ − 1 (Gaussian law) — the AVERAGE of the two charge channels. The bond a coplanar or bent surface pair actually
   carries is the attractive channel e^{iΦ_A}e^{∓iΦ_B}, relative content e^{|⟨Φ_AΦ_B⟩|} − 1. Read that way the MC gives |⟨Φ_AΦ_B⟩| = 1.92
   planar / 2.10 bent at n = 8 (the Gaussian law at the matched coupling 0.86: 1.90 / 2.07), so r = 5.8 / 7.2 and **P2 at n = 8 reads c =
   0.0153·(1 + 4·7.2^{1/2}) = 0.18 — it FAILS at three steps and lands at four (n = 16)**, exactly as §5R's Gaussian line said; item 8's
   "lands at three steps" is WITHDRAWN. At n = 4 the attractive channel gives r = 1.56 and c = 0.62 (FAIL), §5R's 0.30 FAIL unchanged in verdict.
   The MC and the Gaussian law agree at n = 4 and 8 to 1–2 % on a and on |⟨Φ_AΦ_B⟩|.
