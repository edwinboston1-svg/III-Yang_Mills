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

## 3. RESULTS (records `main.2026-11-02a.txt`, `r4.2026-11-02a.txt`, `w2n4_W3L2_modes.m7.{ordered,cancel}.txt`; 07:2x–07:4x EST)

### 3.1 The coefficients, each from its record (planar geometry at the named data, §18; rounded UP at 10⁻¹²)

| cell | record | E[χ_½(A)] | a′_½ | E[χ₁(A)] | a′₁ | β_eff (a_½ = I₂/I₁) |
|---|---|---|---|---|---|---|
| W2L2 ordered | `w2n4_W2L2.2026-11-01a.ordered.txt` | 0.1455672954 | 0.0727836 | 0.0027004379 | 0.00090015 | 0.2922 |
| W2L2 cancelling | `w2n4_W2L2.2026-11-01a.cancel.txt` | 0.1107069964 | 0.0553535 | 0.0016080515 | 0.00053602 | 0.2219 |
| W3L2 ordered | `w2n4_W3L2.2026-11-01b.ordered.txt` (full slice) | 0.2432512322 | 0.1216256 | 0.0109312910 | 0.00364376 | 0.4914 |
| W3L2 cancelling | `w2n4_W3L2.2026-11-01b.cancel.txt` (full slice) | 0.1518891609 | 0.0759446 | 0.0028633753 | 0.00095446 | 0.3050 |

Spins ≥ 3/2: not carried (L = 2), entered 0 (optimistic) and, as a check, at the premise-saturating tail. Window edges: a_½(0.4764) = 0.117989
(Theorem 8.9, conditional on S12's remainder), a_½(0.2452) = 0.061147 (Theorem 8.7, unconditional). §19's β_eff 0.2930 / 0.2225 used the
three-digit E; the full-precision E gives 0.2922 / 0.2219.
The pair couplings (dob readings, the full group, grid-refined lower bounds): C = 0.026260892 / 0.029883394 (W2L2 planar ordered / cancelling,
`dob/dob_n4_W2L2_planar_*.dob.txt`), 0.055627171 / 0.066463830 (W3L2, `dob/w2n4_W3L2.2026-11-01b.ordered.txt.schur.dob.txt`,
`dob/dob_n4_W3L2_cancel.dob.txt`); Δ = 0.252643 / 0.284409 / 0.554219 / 0.640060 (same records); sup|δ₂| on the class grid 0.050034 / 0.070080
(`w2n4_W2L2_modes.2026-11-01a.*`), 0.116164 / 0.159545 (W3L2, this directory's run of the read-only `w2_modes.awk` on record 01b — its control:
the same reader on the W2L2 ordered record reproduces the landed modes record BYTE FOR BYTE). The exit form's inputs (W2-CERT-CALL):
HALF 1.004953 / 1.005027 / 1.021465 / 1.017814, WALL 0.299754 / 0.338037 / 0.493236 / 0.536360 (NPAIR = 16, the modes reader's convention).

### 3.2 THE CERTIFICATE AT THE BARE COEFFICIENTS (T1, T2) — every stake HELD

| cell | LOCAL table mode, page dressing: PASS for α in | GRADED, α = 1/1000: u~, r_hi, LHS | sat tail (LOCAL page) |
|---|---|---|---|
| W2L2 ordered | [0.0001, 0.0080] (tree the same) | 0.073191, 0.3689, 7.7·10⁻⁶ (α/LHS = 130) | [0.0001, 0.0080] |
| W2L2 cancelling | [0.0001, 0.0080] | 0.055536, 0.2799, 1.4·10⁻⁶ (≈ 700) | [0.0001, 0.0080] |
| W3L2 ordered | [0.0006, 0.0080] (tree the same) | 0.124671, 0.6284, 5.634·10⁻⁴ (1.77) | [0.0007, 0.0080] |
| W3L2 cancelling | [0.0001, 0.0080] | 0.076396, 0.3850, 1.0·10⁻⁵ (≈ 100) | [0.0001, 0.0080] |

THE W3L2 ORDERED CELL PASSES THOUGH a′_½ = 0.1216 > 0.1180 = a_½(0.4764): its a′₁ is 2.7× below Wilson's at the same a_½, the dressing
κ_U = 0.0247 (against ≈ 0.10 at the number), u~ = 0.1247 below the number's. The one-plaquette comparison of §19 is not the certificate's test;
the coefficient-supplied run is, and it passes. (T1 stake HELD; T2 HELD: the premise-saturating tail moves no verdict and the margins little.)

### 3.3 THE TILT TOLERANCE ε — the certificate's tolerance to a uniform multi-plaquette tilt (E)

| cell | ε, GRADED α = 1/1000 (RESULTS 1's form) | ε, GRADED α = 4/1000 | ε, LOCAL α-scanned | ε, sat tail | stake |
|---|---|---|---|---|---|
| W2L2 ordered | 0.559 | 0.602 | 0.604 | 0.557 | [0.50, 0.75] HELD |
| W2L2 cancelling | 0.835 | 0.878 | 0.880 | 0.834 | [0.80, 1.05] HELD |
| W3L2 ordered | 0.030 | 0.072 | 0.069 | 0.024 | [0, 0.20] HELD |
| W3L2 cancelling | 0.517 | 0.560 | 0.561 | 0.514 | [0.45, 0.70] HELD |

(Each the PASS end of a 1/1000 bracket; the refusal one step above is the sighted control, read at every cell by the bisection. Compare RESULTS 1's
Wilson budget at the same β_eff: ε(0.30) = 0.49, ε(0.20) = 0.91 — the blocked weights tolerate about as much as Wilson's at equal a_½.)

### 3.4 THE PAIR COUPLINGS AS A TILT (C) — readings only (RESULTS 3 (e): c_sup > ε refutes the route, c_sup ≤ ε proves nothing)

Per adjacent pair, t = Δ/4: a lower bound on ‖δ_pair‖∞ for EVERY split of the single-plaquette parts (Δ is the mixed second difference,
invariant under the split, at most 4‖δ‖∞); it dominates the class-grid sup|δ₂| at all four cells. Per pair (e^t − 1)e^{7α}, α = 1/1000.

| cell | ε (GRADED / LOCAL) | c, 4 coplanar pairs (read; a LOWER bound) | log(1 + c₄) | c, 20 pairs (proxy) | log(1 + c₂₀) | verdict |
|---|---|---|---|---|---|---|
| W2L2 ordered | 0.559 / 0.604 | 0.263 | 0.233 | 1.313 | 0.839 | read pairs below ε; proxy ABOVE |
| W2L2 cancelling | 0.835 / 0.880 | 0.297 | 0.260 | 1.484 | 0.910 | read pairs below ε; proxy ABOVE |
| W3L2 ordered | 0.030 / 0.069 | 0.599 | 0.469 | 2.993 | 1.385 | REFUTED BY THE FOUR READ PAIRS |
| W3L2 cancelling | 0.517 / 0.561 | 0.699 | 0.530 | 3.495 | 1.503 | REFUTED BY THE READ PAIRS (c-form); log-form 0.530 against 0.517 / 0.561 |

Stake C: HELD at W2L2 (read pairs below, proxy above); at W3L2 (unguessed) the read pairs alone exceed the tolerance.

### 3.5 THE EXIT FORM OF RESULTS 4 (b) (R4): FAIL AT EVERY CELL, AND ONLY THROUGH THE WALL FLOOR

| cell | COEF + HALF + WALL | COEF + HALF | COEF + WALL | W_max (largest passing wall floor, bare COEF) | recorded WALL / W_max | HALF_max | recorded HALF |
|---|---|---|---|---|---|---|---|
| W2L2 ordered | FAIL: the dressing iteration leaves [0, 3] | PASS [0.0001, 0.0080] | FAIL (same) | 0.0141 | 21× | 1.8404 | 1.00495 |
| W2L2 cancelling | FAIL (same) | PASS [0.0001, 0.0080] | FAIL | 0.0142 | 24× | 2.4260 | 1.00503 |
| W3L2 ordered | FAIL (same) | PASS [0.0009, 0.0080] | FAIL | 0.0102 | 48× | 1.0753 | 1.02146 |
| W3L2 cancelling | FAIL (same) | PASS [0.0001, 0.0080] | FAIL | 0.0141 | 38× | 1.7631 | 1.01781 |

The modifying share (HALF) is far inside its tolerance everywhere; the creating share, priced as the modes reader prices it (a′₁ + 16·s_one/3, the
geometric mean of each creating mode over its created plaquettes, summed over sixteen pairs), is 21–48 times the largest wall floor the dressing
survives. Under the narrowest accounting (one pair, one mode per plaquette: a′₁ + |b̂₁₂|^{1/2}/3 = 0.0009 + 0.0093 = 0.0102 at W2L2 ordered) it
would sit AT W_max; any sum over two or more pairs exceeds it. RESULTS 4 (d) names the geometric-mean pricing a bound, not the sharp pricing of a
multi-plaquette bond (a bond enters the recursion once, not once per plaquette): THE SHARP PRICING OF A CREATING BOND IS THE OPEN INPUT.

### 3.6 THE CONTROL: U(1) AT β = 1.2 (U) — FAILS AT TWO STEPS, NOT DISCRIMINATING IN KIND

Records `w2_u1n4L2.2026-11-01a.{ordered,cancel}_b1.2.txt` (two steps, charges to 6, loop charges to 2; planar geometry at the named data by §18),
one step `w2_u1_modes.2026-11-01a.*_b1.2.txt`; pair couplings `dob/dob_u1_u1_n4_b1.2_N6_L6_*.dob.txt` (C = 0.166572 / 0.196222, Δ = 1.217670 /
1.341404); this directory's `u1_mech.2026-11-02a.txt`.
- In U(1)'s own normalisation (d = 1, a′₁ = E[e^{iΦ_A}]): two-step a′₁ = 0.301047 (ordered) / 0.223157 (cancelling). Fed to the certificate as the
  u-slot (a category crossing — the gas's alphabet is SU(2)'s; a U(1) gas's leaf sum carries 2 where SU(2)'s carries 4, which moves the threshold in
  u by about 2^{1/21}, 3 %): FAIL at both data, "r >= 1: the tail over F > F0 does not close" (u~ = 0.324 / 0.228). THE CONTROL FAILS TO LAND
  AT TWO STEPS, AS REQUIRED. Under SU(2)'s d-division (u = E/2, wrong for U(1)) the cancelling cell PASSES ([0.0002, 0.0080]) — said so it is not
  mistaken for the control.
- BUT THE FAILURE IS A RATE, NOT A KIND. Inverting a₁ = I₁/I₀: 1.2 → 1.428 (one step, ordered; runs UP, §4.2's reading) → 0.632 (two steps);
  cancelling 1.2 → 0.967 → 0.458. Both two-step values lie BELOW U(1)'s transition β_c ≈ 1.011 (a₁ = 0.4503): the pinned two-step coefficient puts
  gapless U(1) at 1.2 inside U(1)'s confining phase. The gapped side, β = 0.9: 0.1849 → β_eff 0.376 (ordered), 0.1153 → 0.232 (cancelling). The
  one-plaquette coefficient of a pinned finite object falls with the block in either phase (a perimeter law suffices), and at the cancelling
  datum U(1)'s per-step factor (0.223/0.435 = 0.51) would carry it below 0.118 at the third step. So THE ONE-PLAQUETTE TEST IS NOT DISCRIMINATING:
  it parts SU(2) from U(1) at two steps by the size of the fall (SU(2) ×0.23–0.32 per step at its caps, U(1) ×0.51–0.52), not by mechanism.
- What parts them more is the multi-plaquette part, as the theory requires: U(1)'s Δ = 1.22 / 1.34 against SU(2)'s 0.25 / 0.28 (W2L2) and
  0.55 / 0.64 (W3L2); U(1)'s per-pair content (Δ/4 form) 0.358 / 0.402, so c₄ = 1.43 / 1.61 with no positive tolerance to set it against.

### 3.7 THE THIRD STEP (task 3) — the condition is met in its spirit, and the answer is arithmetic, not a reading

Every bare-coefficient run PASSES (four cells); every failure is in the multi-plaquette part — the tilt form at W3L2 and in the 20-pair proxy at
W2L2, and the exit form's wall floor everywhere. So the two-step fails only through the multi-plaquette part. What a third step does, by the
strong-coupling flow form and the record's own two-scale ratios (ARITHMETIC ON READINGS, NO CLAIM — THE CROSSING CAMPAIGN §14's U(1) column is
the standing proof that a ratio read at two rungs is not a law):
- The one-plaquette part: at strong coupling the 2×2 block's coefficient flows as u → u⁴(1 + O(u²)) — from the two-step a′_½ = 0.073 / 0.122 this
  is 2.8·10⁻⁵ / 2.2·10⁻⁴. The record's own fall from one step to two is far slower than u⁴ (0.3105 → 0.0728 at W2, where u⁴ gives 0.0093; the
  first step is not at strong coupling), so take the observed per-step factor instead: ×0.235 (W2) / ×0.316 (W3), giving u₃ ≈ 0.017 / 0.038,
  Wilson-equivalent β ≈ 0.07 / 0.15, where RESULTS 1's budget is ε ≈ 2.0 / 1.2.
- The multi-plaquette part: the record's line ("were the W3L2 contraction ×0.221 to continue, the adjacent sum would read 0.25 at three steps",
  §14, 153_LOG) is on S₂₀ = 20 copies of the planar C, which §18 withdrew; on the read pairs alone it is 4·0.0556·0.221 = 0.049 at three steps.
  In the certificate's currency, with Δ's own two-scale factor (one step → two: ×0.127 / ×0.108 at W2L2, ×0.161 / ×0.164 at W3L2): W3L2 ordered
  Δ₃ ≈ 0.089, per pair 0.0227, c₄ ≈ 0.091, c₂₀ ≈ 0.45 (log form 0.37) — BELOW ε ≈ 1.2 by a factor 2.6 even for the twenty-pair proxy. So by
  the arithmetic THE TILT FORM PASSES AT THE THIRD STEP at every cell.
- The exit form's wall floor: the record's ×0.10 / ×0.075 per step (one step 2.91 / 4.53 at §7's cap → two steps 0.300 / 0.338 at W2L2) gives
  0.03–0.05 at three steps, still above the dressing's ceiling (W < 1/(5·γ_max) ≈ 0.029, u-independent: W_max = 0.010–0.014 read here); a
  fourth step (0.003–0.005) clears it. Under the modes reader's pricing the exit form needs FOUR steps by the arithmetic.
- The same arithmetic on U(1) at 1.2 (the control): Δ two-scale factor ×0.317 / ×0.314, Δ₃ ≈ 0.39 / 0.42, c₄ ≈ 0.40 / 0.44, u₃ ≈ 0.157 / 0.114
  — the ordered datum still fails on u, the cancelling passes on u with a thin tolerance (ε of order 0.05 at u ≈ 0.114, by §3.3's W3L2 ordered
  analogue) that c₄ ≈ 0.44 exceeds: U(1) FAILS THE TILT FORM AT THE THIRD STEP where SU(2) passes it — the arithmetic separates the groups
  through the multi-plaquette part at three steps, and the two-rung ratios it rests on are exactly what is not known to continue.

### 3.8 THE W4 READING OF THE ORDERED TWO-STEP COEFFICIENT — in flight (§2d's stake); entered when it lands

## 4. WHAT THIS SETTLES, AT ITS STRENGTH, AND WHAT A PROOF ADDITIONALLY NEEDS

SETTLED (about the instrument, CERTIFIED arithmetic, two-sided KAT): the coefficient-supplied certificate reproduces THE NUMBER (0.4764, α window
[0.0041, 0.0047]) in the table mode of record; HEAD's copy IGNORES A TILT IN COEF MODE (K1) — the "COEF + TILT admission test" of 031_P did not
exist as code until the one-line reorder here (K2, K3).
READINGS (fixed fine data, the planar geometry, plaquette spins ≤ 1 or ≤ 3/2, loop representations ≤ 1, coefficients at spins ≥ 3/2 unread):
(a) the bare two-step coefficients pass the certificate at all four cells — margins α/LHS = 130 / 700 / 1.8 / 100 at α = 1/1000, tilt tolerance
0.56 / 0.84 / 0.03 / 0.52; (b) the multi-plaquette part fails it — the exit form's wall floor at every cell (21–48× over), the tilt form at
the sharper cap from the four read pairs alone; (c) the U(1) control fails at two steps, by rate not kind; (d) the plaquette cap is the
largest unknown: from spins ≤ 1 to ≤ 3/2 the ordered a′_½ rose 0.0728 → 0.1216 and the tolerance fell 0.56 → 0.03.
SO: DOES THE CROSSOVER FROM 2.2 LAND AFTER TWO STEPS? IN THE ONE-PLAQUETTE PART, YES AT BOTH DATA AND BOTH CAPS, WITH THE ORDERED DATUM'S MARGIN
NEARLY GONE AT THE SHARPER CAP; WITH THE MULTI-PLAQUETTE PART INCLUDED, NO — at either cap and either datum under the record's pricing of the
creating modes, and at the sharper cap under the tilt pricing from the read pairs alone. By arithmetic, the tilt form would pass at a third step
and the exit form at a fourth; no object reads either.

A PROOF ADDITIONALLY NEEDS (each named with its owner where one exists):
1. THE FINE FIELD INTEGRATED: the blocked action's coefficients, not a pinned marginal. The tower lemma (§1) moves the one-plaquette part and the
   single-site oscillation to extremes over pinned data for environments that are functions of ω; it does not reach the pair coupling, and its
   premise excludes the coarse neighbours a single-site criterion conditions on (§1 (i)).
2. THE COARSE SUPREMUM: the certificate's inputs as suprema over coarse configurations (M2b's Theorem A1, `math/M2b/WORK.md` §3). §2d's probe
   says the supremum is not reached at a single centre flip once the cap is above spin 1, and nothing more.
3. THE TRUNCATION TAIL in both directions: the plaquette cap (the dominant mover: ×1.67 on the ordered E[χ_½] from W2 to W3 at two steps, and
   at one step 0.621 → 0.770 → 0.815 → ≈ 0.826 at W2/W3/W4/W6); the loop cap (the coefficients at spins ≥ 3/2, entered 0; the saturating tail
   moved no verdict); the mode cap of the pair coupling.
4. THE SHARP PRICING OF A CREATING BOND (RESULTS 4 (d)): the exit form fails only through the wall floor, priced by the geometric mean summed
   over sixteen pairs; a bond enters the recursion once. Until that lemma exists the wall-floor FAIL is a FAIL of a conservative accounting.
5. THE SIXTEEN BENT PAIRS (§18): read nowhere; every content above is the four coplanar pairs (a lower bound) or the twenty-copy proxy.
6. THE THIRD SCALE: the two-rung ratios behind §3.7 continue in no theorem; THE CROSSING CAMPAIGN §14's U(1) column contracts too.

(3.8 continued, 07:58 EST.) THE W4 ORDERED READING LANDED (`probe/w4_n4_ordered_L1C0.2026-11-02b.txt`, 353.7 s, 36.6 M entries at the peak):
E[χ_½(A)] = 0.2789044077 at plaquette spins ≤ 2, planar, two steps, ordered — a′_½ = 0.1394522, β_eff = I₂/I₁-inverse ≈ 0.564. The cap
series at two steps: W2 0.1455673 → W3 0.2432512 → W4 0.2789044 (×1.671, ×1.147); at one step 0.6210 → 0.7698 → 0.8149 (×1.240, ×1.059),
then ×1.013 to W6. The §2d stake ("above 0.2433") HELD.
STAKES before the two runs that follow: (W4-o) the bare certificate at a′_½ = 0.1394522 FAILS EVEN WITH a′₁ = 0 and every higher entry 0 — desk:
with no dressing u~ = u, r = 5u~e^{8α} ≥ 0.697, the F > F0 tail 2.4·r²¹/(1 − r) ≈ 4.0·10⁻³ and the F = 6 term 3.5·10⁻⁴ give LHS ≥ 4.4·10⁻³ at α → 0,
growing as e^{8αF} — no α in [0.0001, 0.0080] can close. (W4-c) the W4 cancelling run (launched 07:58, before this line): E[χ_½(A)] above W3's
0.1518892, a′_½ below 0.10, and the bare certificate PASSES there at a′₁ = 0 and at W3's a′₁ = 0.00095446.
(W4-o) RESULT (`w4o_cert.2026-11-02a.txt`): STAKE HELD — a′_½ = 0.1394522 (rounded up), a′₁ = 10⁻¹² (no dressing: κ_U = 0, u~ = u), every higher
entry 0: GRADED α = 1/1000 → r_hi = 0.7029, LHS = 0.0052875 = 5.3 α, FAIL; LOCAL page, α scanned 0.0001..0.0080 → "no passing alpha … the
inequality's upper end is above alpha". With W3's a′₁ = 0.00364376: u~ = 0.14294, LHS = 0.0092138, FAIL; with a′₁ = 0.007: LHS = 0.0186744, FAIL.
AT PLAQUETTE SPINS ≤ 2 THE ORDERED DATUM'S TWO-STEP COEFFICIENT LIES OUTSIDE THE CERTIFIED WINDOW IN THE ONE-PLAQUETTE PART ALONE, whatever its
higher coefficients. The ordered cell's verdict runs with the cap: W2 PASS (α/LHS = 130), W3 PASS (1.8; tolerance 0.03), W4 FAIL — and the cap
series is still rising (×1.147 from W3 to W4 at two steps; ×1.013 from W4 to W6 at one step), so every sharper cap moves it further out.
INSTRUMENT NOTE: a′₁ = 0 exactly is not refused by name — the run dies "fatal: division by zero attempted" in c2 = Σ d_j (a_j/a₁)²; a fourth
refusal (a zero spin-1 entry) is owed beside the three of RESULTS 6 (a).

## 5. CORRECTIONS OF STRENGTH TO THE SECTIONS ABOVE (08:0x EST; nothing above edited)

1. §1 (3) "REFUTED BY THE RECORD BEFORE ANY RUN" is withdrawn: §2d shows the record's line 222 (and every raising flip found at W2) is an artefact
   of the spin-1 cap — the same flips LOWER E[χ_½(A)] at W3 and W4. The conjecture is untested at caps above spin 1 beyond single centre flips.
2. §1 (2)'s consequence, sharpened: the tower lemma bounds the fine-integrated one-plaquette coefficient by the SUPREMUM over pinned data, and at
   the W4 cap the ordered datum ALONE gives a′_½ = 0.1395, outside the window with no dressing (W4-o). So EVEN IF the conjecture is true (the
   ordered datum is the supremum), the tower-lemma road cannot land at two steps at that cap: the conjecture's truth value no longer decides the
   two-step landing; it would decide only a later step's.
3. §4's "IN THE ONE-PLAQUETTE PART, YES AT BOTH DATA AND BOTH CAPS" holds for the W2 and W3 caps only. At W4 the ORDERED datum fails the bare
   certificate (W4-o); the cancelling cell at W4 is §3.8's last line. With the multi-plaquette part under the record's pricing, no cell lands at
   any cap.
4. §3.7's condition ("fails only through the multi-plaquette part") holds at W2 and W3, NOT for the ordered cell at W4. The W4 arithmetic: the
   ordered per-step factor at W4 is 0.2789/0.8149 = 0.342, so u₃ ≈ 0.048 (Wilson-equivalent β ≈ 0.19, RESULTS 1's ε ≈ 0.95): a third step lands
   the ordered datum on the bare coefficient by the arithmetic — still arithmetic, no object reads it.
5. §3.4's W3L2 cancelling cell: above the tolerance in the c ≤ ε form the lemma states (0.699 against 0.517 / 0.561); BORDERLINE in the sharp form
   log(1 + c) ≤ ε (0.530 against 0.517 / 0.561). The W3L2 ordered cell is above in both forms.

(3.8, last line, 08:0x EST.) THE W4 CANCELLING READING (`probe/w4_n4_cancel_L1C0.2026-11-02b.txt`, 367.7 s): E[χ_½(A)] = 0.1860347140, a′_½ =
0.0930174 (rounded up), β_eff ≈ 0.374; cap series W2 0.1107070 → W3 0.1518892 → W4 0.1860347 (×1.372, ×1.225). Certificate (`w4c_cert.2026-11-02a.txt`):
a′₁ = 10⁻¹² → LOCAL page PASS for α in [0.0001, 0.0080], GRADED α = 1/1000 LHS = 3.32·10⁻⁵ (α/LHS ≈ 30); a′₁ = W3's 0.00095446 → PASS, LHS =
3.44·10⁻⁵. STAKE (W4-c) HELD. At plaquette spins ≤ 2 THE CANCELLING DATUM LANDS IN THE ONE-PLAQUETTE PART AND THE ORDERED DOES NOT.

## 6. THE ANSWER, AS IT STANDS AT 08:0x EST (supersedes §4's sentence; §5 item 3 completed)

The crossover from β = 2.2 after two exact ℤ⁴ steps, at fixed fine data, planar geometry, truncated — READINGS:
- ONE-PLAQUETTE PART: lands at the cancelling datum at every cap read (W2, W3, W4: α/LHS ≈ 700, 100, 30); at the ordered datum lands at W2 and W3
  (130, 1.8) and FAILS at W4 (LHS = 5.3α with no dressing) — the ordered datum, the one the record calls nearest the typical outside at 2.2, is
  OUT of the certified window once plaquette spins reach 2, and the cap series is still rising there.
- WITH THE MULTI-PLAQUETTE PART: no cell lands — the exit form (RESULTS 4 (b)) fails at every W2/W3 cell through the wall floor alone (21–48× its
  ceiling); the tilt form fails at W3L2 from the four read coplanar pairs (cancelling borderline in the sharp log form) and in the twenty-pair proxy
  everywhere.
- THE CONTROL (U(1), 1.2) fails at two steps, as it must, by rate not kind.
(an empty probe/w4_n4_ordered_L1C0.2026-11-02a.txt is the first W4 launch, killed with its launcher's shell before it wrote; the run of record is 02b.)
