# M7 — DOES THE CROSSOVER FROM β = 2.2 LAND IN THEOREM 8.9's CERTIFIED WINDOW AFTER TWO EXACT ℤ⁴ STEPS?

Proof agent M7, 2026-11-02 (opened 06:5x EST, read from `date`). Read-only in both repositories; everything run here is a copy in this directory.
Strength labels: PROVED / CERTIFIED / MEASURED / READING / OPEN. The certificate is certified arithmetic; every input below is a READING
(fixed fine datum, truncated, planar geometry), so every verdict below is a READING unless it is about the instrument itself.

## 0. Sources read, and the instrument chosen

- THE CROSSING CAMPAIGN §§7, 10, 14 (Parts 1-2), 15, 17, 18, 19 (III `DOCS/III-THE-CROSSING-CAMPAIGN-OF-THE-YANG-MILLS-GAP.md`).
- THE FAR SHORE §10 with RESULTS 1-6 (III-Yang_Mills `OPEN/the-far-shore.md`): the coefficient-supplied mode's specification (RESULTS 4 (c):
  COEF, HALFN/HALFD, WALLN/WALLD), its three refusals (RESULTS 5 (d), 6 (a)), the tilt TILTN/TILTD (RESULTS 1), the first step read by the
  certificate (RESULTS 6 (b): FAIL at both named data, "the dressing iteration leaves [0, 3]: no root").
- scratchpad `read/digests/031_P.md` (COEF + TILT as "the coarse-scale admission test"), `153_LOG.md` (the third-rung arithmetic),
  `math/M4_BRIEF.md` (the copy to use).

**THE COPY USED.** HEAD's `STDLIB/build/aperanton/kp_cert_table_wip.awk` — the table-gate path, last changed in b3c0b51b3 — md5
`b5145c3821ac1b9764168336f40d6a6a`, 210 lines; copied here as `kp_cert_table_wip.HEAD.awk`. The working-tree
`STDLIB/scripts/aperanton_kp_cert.awk` is byte-identical to it (md5 b5145c38…); HEAD's `STDLIB/scripts/aperanton_kp_cert.awk` is a different,
older file (md5 a8c09331…, 17129 bytes) — the stale one the M4 brief names. The Bessel library `aperanton_bessel_cert.awk` copied from HEAD
(md5 ff26d775…). The table line R2TAB from `STDLIB/build/aperanton/local_tail_table.2026-10-31g.txt` (the gate's TAG 2026-10-31g).
Mode of the number 0.4764: `LOCAL=1 R2TAB=… DRESS=page` (arm 6, `cert_page.run`); mode of RESULTS 1's budget table: `GRADED=1 R2TAB=… DRESS=page`
(arm 10, `budget.run`). Both are run below and every line says which.

**A DEFECT IN THE INSTRUMENT, FOUND BY READING (law 3).** In `bessel_table()` (lines 46-57) the TILT multiplication (line 49) runs BEFORE the
COEF block (lines 52-55), and the COEF block overwrites `AL[]`/`AH[]`. So with COEF set, the tilt multiplies whatever the arrays held (zeros on
the first call) and is then discarded: COEF + TILT = COEF, while the report line still prints `tilt=N/D`. The gate's arm 10 never runs the two
together (budget.run is the table mode with a tilt; coef.run is COEF alone), so nothing saw it; 031_P read lines 47-59 as composable. The fix
used here, in this directory only: `kp_cert_m7.awk` = the HEAD copy with the tilt line moved after the COEF block (`patch_tilt.awk`; the diff
is the one line moved; md5 034f169b…). In the table mode (COEF unset) the two copies execute the same statements in the same order.
The two-sided KAT is §2.

## 1. THE COORDINATOR'S DESK LEMMA (iii-43, received mid-task), VERIFIED BEFORE USE

(1) The inversions: a_½(β) = I₂(β)/I₁(β) at 2.2 = 0.464479; the two-step W2L2 values a′_½ = E[χ_½(A)]/2 = 0.0727836 (ordered), 0.0553535
(cancelling); a_½(0.4764) = 0.117989. Checked against the records below: the a′ values are the records' own W2-COEF lines.

(2) THE TOWER LEMMA. (a) and (b) are CORRECT under their own premise, and textbook (W = 0): by the Markov property of the Wilson measure the
object's law given the fine outside ω is the pinned computation p(·|ω); for any σ(ω)-measurable coarse environment v_env,
λ(dA | v_env) = ∫ p(dA | ω) μ(dω | v_env), so every moment of A given v_env lies in [inf_ω, sup_ω] of the pinned moments, and pointwise
λ(A | v) ∈ [inf_ω p(A|ω), sup_ω p(A|ω)], whence |log λ(A|v) − log λ(A|v′)| ≤ osc_ω log p(A|ω) for each A (and the A-oscillation of the
log ratio, the tilt Δ in §14's currency, at most twice sup_A osc_ω log p(A|ω)). THREE LIMITS, said before use:
 - (i) THE PREMISE IS NARROWER THAN THE CERTIFICATE'S CONDITIONING. v_env must be a function of ω. The coarse plaquettes adjacent to A share
   A's boundary fine links, which lie INSIDE the object; they are not functions of ω. So the lemma bounds A's law given coarse data away from
   the object, not the single-site conditional given A's coarse neighbours that a Dobrushin row or a single-site criterion conditions on.
 - (ii) The bound is by extremes over ω ∈ SU(2)^{532} (two steps): a finite-dimensional supremum, which any search only lower-bounds;
   an upper bound needs a certified global argument.
 - (iii) It bounds the one-plaquette coefficient and the single-site oscillation — the part THE FAR SHORE §10 calls "not content" (re-priced
   by its own characters) — and not the pair coupling, whose mixture weights move with B, which is the part the exit condition tests.

(3) THE CONJECTURE (sup_ω E[χ_½(A)|ω] attained at the ordered datum) IS REFUTED BY THE RECORD BEFORE ANY RUN (READING): THE CROSSING CAMPAIGN
§9 ADDENDUM (page line 222, records `wscan_*`), the exact single-link rotation scan: one step, link 56 — base 0.621039, maximum 0.635430 at
360° (the CENTRE FLIP U = −1); link 60 — 0.635055 at 360°; TWO STEPS, link 78 — base 0.145567 (the W2L2 two-step ordered value, 0.1455672954
in `w2n4_W2L2.2026-11-01a.ordered.txt`), maximum 0.150147 at 360°. A centre flip of one outside link RAISES the coarse loop's expectation above
the flat datum's, at both scales. Caveat (§18): those scans ran on the defective "bent" engine; at a datum that is identity except at one
non-corner outside link the engine's corner staples still read identity, so the object computed is the corner-split geometry (the planar
object's local structure at the corners), a valid finite gauge object but neither the true bent object nor, link for link, the planar one.
A confirmation on the correctly built planar object is §8's probe. Consequence for (2): the flat datum's two-step a′_½ does NOT bound the
supremum over pinned data; that supremum is at least 0.150147/2 = 0.07507 at the W2 cap on the corner-split object.

## 2. STAKES (written before any certificate run)

K1 (the defect's signature): the HEAD copy, COEF = the gate's Bessel rationals at β = 0.25 (its own generator), GRADED=1 R2TAB DRESS=page
α = 1/1000, TILTN = 68/100 and 69/100: BOTH PASS (the tilt ignored), where budget.run's table mode reads PASS / FAIL.
K2: the patched copy, same input: 68/100 PASS, 69/100 FAIL (budget.run's cells reproduced in COEF mode).
K3: the patched copy, tilt unset, the gate's own `runcoef` call: coef.run's line reproduced byte for byte (the PASS at kappa_U 0.019543).
K4: the patched copy, COEF = Bessel ratios at 0.4764 rounded UP to 10⁻³⁰, LOCAL=1 R2TAB DRESS=page, α scanned 1..80 (10⁻⁴): PASS for α in
[0.0041, 0.0047] (cert_page.run), within one α step; at 0.4766 no passing α.

T1 (bare coefficients, spins ≥ 3/2 entered as 0 as the records carry them — the OPTIMISTIC direction, unread at L = 2 and truly positive):
W2L2 ordered (0.0727836, 0.00090015) PASS; W2L2 cancelling (0.0553535, 0.00053602) PASS; W3L2 cancelling (0.0759446, 0.00095446) PASS;
W3L2 ordered (0.1216256, 0.00364376): PASS — staked against the one-plaquette comparison (0.1216 > 0.1180): the blocked a′₁ is 2.7 times below
Wilson's a₁ at the same a_½ (≈ 0.0100 at β ≈ 0.49), the dressing κ is lighter (desk estimate e^κ ≈ 1.03 against ≈ 1.11 at the number),
so u~ = u e^κ ≈ 0.125 sits BELOW the number's u~ ≈ 0.131. If it FAILS, the one-plaquette comparison was the right reading.
T2 (premise-saturating tail: a_{3/2} = min(a₁, a_½/8), each later entry the largest the two refusals allow): the four verdicts of T1 unmoved.
E (the tilt tolerance ε, the largest per-plaquette tilt that passes, bisected on 1/100 then 1/1000, GRADED=1 at α = 1/1000 as RESULTS 1):
W2L2 ordered ε ∈ [0.50, 0.75]; W2L2 cancelling ε ∈ [0.80, 1.05]; W3L2 cancelling ε ∈ [0.45, 0.70]; W3L2 ordered ε ∈ [0, 0.20].
C (the pair couplings as content, readings only): c_sup = n·(e^{t} − 1)e^{7α} per plaquette with t = the larger of the class-grid sup|δ₂| and
Δ/4 (Δ ≤ 4‖δ₂‖∞ on the full group), n = 4 (the four COPLANAR adjacent pairs, the only ones read: a LOWER bound of the content, the sixteen
bent pairs unread and nonnegative) and n = 20 (the proxy). Staked: at W2L2 the n = 4 content lies below ε (the necessary condition met, nothing
proved, RESULTS 3 (e)); the n = 20 proxy lies above ε at the ordered datum. UNGUESSED at W3L2.
R4 (THE EXIT FORM of RESULTS 4 (b), the record's own W2-CERT-CALL lines, HALF and WALL included): FAIL at every cell, at the dressing — the wall
floor (0.2998 / 0.3380 at W2L2, NPAIR = 16) times γ(s) ≈ 4.6-6.8 puts the branch ratio above one ("the dressing iteration leaves [0, 3]" or
"rho >= 1"). W_max, the largest wall floor that passes at the bare coefficients: ≈ 0.02-0.03 (ρ < 1 needs W < 1/(5·6.79) = 0.029).
U (the control): U(1) at β = 1.2, two steps, |E[e^{iΦ_A}]| = 0.30105 (ordered) / 0.22316 (cancelling) (`w2_u1n4L2.2026-11-01a.*_b1.2.txt`):
in the certificate's currency u ≫ 0.118 — NOT LANDED at two steps. In U(1)'s own Wilson normalisation a₁ = I₁/I₀ inverts to β_eff ≈ 0.63 /
0.46, BELOW U(1)'s phase transition β_c ≈ 1.01: the fixed-datum coefficient places gapless U(1) inside its own confining phase — the one-plaquette
reading cannot see the phase, and the U(1) control fails at two steps by RATE, not by kind (staked: NOT DISCRIMINATING in kind).

## 2b. KATs RUN (record `kat.2026-11-02a.txt`, 07:19 EST) — ALL MET, the defect confirmed two-sided

- K1 MET: the HEAD copy with COEF = Bessel(0.25) and TILTN = 69/100 → PASS (the table mode's FAIL cell): THE TILT IS IGNORED IN COEF MODE.
- K2 MET: the patched copy, same input → 68/100 PASS, 69/100 FAIL; the table mode (COEF unset) on the patched copy → the same two cells as budget.run.
- K3 MET: the patched copy, tilt unset, the gate's `runcoef` → coef.run's line byte for byte (kappa_U 0.019543, LHS 0.0000033, PASS).
- K4 MET: COEF = Bessel(0.4764) rounded UP at 10⁻³⁰, LOCAL=1 R2TAB DRESS=page → "PASS for alpha in [0.0041, 0.0047]" = cert_page.run; at
  Bessel(0.4766) → "no passing alpha in [0.0001, 0.0080]" (the scan's beta label is a placeholder in COEF mode). The coefficient-supplied
  mode reproduces THE NUMBER in the table mode of record.

## 2c. THE CONJECTURE'S PROBE ON THE CORRECTLY BUILT PLANAR OBJECT — stake, written after one timing run already answered it

The engine copy `probe/w2_strip_n.c` = HEAD's (md5 3e6924cc…; the working tree carries a staged/unstaged edit of another seat, not used).
Knobs: `W2_SET=<idx>:-1:0:0:0` (the centre flip of one outside link, the §9 ADDENDUM's instrument), `W2_CMAX=0` (A's marginal only), WMAX 2,
LMAX 1. Controls: the ordered planar base must reproduce the records — one step 0.6210389045 (MET, `probe/base_n2_planar_W2L1C0.txt`), two
steps 0.1455672954 (MET, `probe/base_n4_planar_W2L1C0.txt`, the landed W2L2 value to 13 digits).
PROCEDURAL NOTE: the timing run of the first flipped datum (two steps, outside link 0 = (1,−1,0,0) dir 2 flipped to −1) printed
E[χ_½(A)] = 0.1541384898 > 0.1455672954 before this stake was written; it is reported as found, not as a prediction.
STAKE for the scan: (P1) at one step, the single-flip scan over all 176 outside links finds at least one flip above the base 0.621039
(the corner-split engine found 0.635430 at its link 56); (P2) at two steps a structured datum (every outside link of link 0's kind flipped)
lies above the single flip — UNGUESSED; (P3) no single flip at two steps moves E[χ_½(A)] above 0.236 (a′_½ = 0.118, the window's edge) at the
W2 cap. Everything here is a READING: exact at the W2 truncation, the planar geometry, a search's values lower bounds on the supremum.

## 2d. THE CAP REVERSES THE CENTRE-FLIP READING (07:5x EST; records `probe/scan1.2026-11-02a.txt`, `probe/capcheck_n2.2026-11-02a.txt`,
`probe/w3_n4_base.txt`, `probe/w3_n4_set0.txt`) — READINGS, exact at each truncation, planar geometry

- One step, W2 (spins ≤ 1): of 176 single centre flips, the largest raise E[χ_½(A)] from 0.6210389 to 0.6511213 (link 24 = (0,1,0,0) dir z),
  0.6505552 (link 71), 0.6504960 (link 14) — the §9 ADDENDUM's phenomenon reproduced on the correctly built planar object.
- THE SAME FLIPS AT SHARPER CAPS LOWER IT: W3 (spins ≤ 3/2) base 0.7698013, flips 0.5403952 / 0.5153176 / 0.5711278; W4 (spins ≤ 2) base
  0.8149157, flips 0.7196315 / 0.7452582 / 0.7413030. Two steps: link 0 at W2 0.1455673 → 0.1541385 (raise), at W3 0.2432512 → 0.1462216 (lower).
- So P1 and the record's "the CENTRE FLIP … raises the loop's expectation above the aligned datum's" (THE CROSSING CAMPAIGN line 222) are an
  ARTEFACT OF THE SPIN-1 CAP: the truncated flipped staple 1 − 2a_½χ_½ + 3a₁χ₁ misweights the flipped link. At W3 and W4 no flip tested raises
  E[χ_½(A)]. The coordinator's conjecture (3) is therefore NOT refuted by any reading at a cap above spin 1; it is untested beyond single centre
  flips (a probe, not a search). What the cap sweep does say: the ORDERED value itself climbs with the cap — one step 0.6210 → 0.7698 → 0.8149
  (W2 → W3 → W4; W6 ≈ 0.826 by RESULTS 6 (c)), two steps 0.1456 → 0.2433 (W2 → W3).

STAKE (before the run): THE TWO-STEP ORDERED a′_½ AT THE W4 CAP (planar, LMAX 1, CMAX 0; the (1,0) class alone, 36.6 M entries a vector,
about 1.2 GB with two in flight; the (2,0) class at W4 would need 2.6 GB and is not run): E[χ_½(A)] above W3's 0.2433, UNGUESSED by how much;
if E/2 exceeds about 0.13 the bare-coefficient certificate is expected to FAIL (W3L2's tilt tolerance is only 0.030 at u = 0.1216).
