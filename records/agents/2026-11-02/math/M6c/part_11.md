
## 11. RESULTS OF RUN c (record `rec/thresholds_run.2026-11-02c.txt`, rc = 0, 9 s; §10 unedited)

c1 HELD: my copy of M6b's run b reproduces κ_KP(3) = 13.53258, 226.36519, T18(1331) = 151.56570 (`rec/m6b_b_rerun.2026-11-02c.txt`).
c2 HELD: Theorem B's table exactly as staked (a, R) = (5, 40.5) at L = 3; (4, 16) at L = 4, 5; (3, 8) at L = 6–11; (2, 0) at L ≥ 12;
   □̃⁵ alone: zero from L = 10 (packing beats Minkowski–Steiner at a = 3, 4, 5).
c3 HELD TO THREE DIGITS, THE FOURTH REFUTED: κ_fl = 6.76629 (L = 3), 6.23276 (4), 5.09953 (12), 4.92060 (20), → 4.67457. The stake's
   6.2322 / 5.0991 / 4.6741 used my hand value ½ ln 11489 = 4.674146, which is WRONG: ln 11489 = 9.349145, half 4.674573 (COMPUTED).
c4 HELD: L = 12, M_free = 261 (= M_α; 12√2a = 37.95, 2κ = 10.20): S1 = 47.45799, S2 = 54.45579 (binds), S3 = 3.85627;
   X_small = 48.97446 decades; T17 = 123.58538, T18c = 124.89977, T18 = 134.77616, T15 = 38.30806.
c5 HELD (with c3's caveat): variant B optimum L = 6, M = 249, binding T18c = 124.45365 decades; X_small there 85.214 (staked 84.9 —
   my hand S2 slipped by 0.3 decade); L = 5 X_small-bound at 126.751 (staked 126.8).
c6 HELD: C′ = 72.58066 at L = 12 (T18_LF′ binds). c7 HELD: C = 48.97446 at L = 12 (M_chain: 62.22940). c8 HELD: D = 13.10410 at L = 12.
c9 HELD: T15_LF(2) → β = 9.0759 (0.95789 decades); T15_LF(0.3) → β = 1034.90 (3.01490).
c10 HELD: c₃(e^{−1.5}) = 2.41541, c₃(e^{−3}) = 1.17421, c₃(e^{−4.466}) = 1.03570; μ_d ∈ [107.18675, e^{45.93303}].
c11 REFUTED AS STAKED: the κ-dependence of the floor at L = 12 is 2.1566 decades (κ → 0⁺ gives M = 192, X_small = 46.818), not ≈ 4: the
   stake added κ's share in S1, but S2 binds and κ enters S2 only through M (16 ln(261/192) = 4.91 nats).
c12 HELD: d-format profile 153.341 decades (κ = 55.12, M = 891, S2 = 174.52 with the base junction 2κ = 110.2); volume-priced, base
   images exempt: 50.557; not exempt: 71.575.

## 12. DATED CORRECTION (2026-11-02, after run c; nothing above edited)

12.1 THE VALUE ½ ln 11489 in §4.2 (Theorem P), §4.3 (Lemma U: "4.674"), §9 and §10 is 4.674573, not 4.674146 (§11 c3). μ_d ≥ √11489 =
107.1868 (Lemma F′) was right; only the logarithm was mistyped. Every computed number uses the correct value.
12.2 THEOREM P AND (2.36)'s ENCLOSURE. (2.36) localises the output on the closure of Z̃ (one more layer of M-cubes), and the
proof of Theorem P fixed the closure of X. With the enlargement the closure must be shown independent of the member:
 (a) STRAIGHT FAMILY, L ≥ 4: put the edge line at x₂ = x₃ = x₄ = 2. The 8 cubes around each unit edge have indices in {1, 2}³ in
     those coordinates, X̃ ⊂ indices {0, …, 3}, and [0, 4] lies in one block when L ≥ 4; along x₁ every member contains the forced
     cube of each edge, so X̃ spans the same interval. The closure of X̃ is member-independent: κ(1 − 1/L) ≥ ln 91 holds for L ≥ 4.
 (b) DIAGONAL FAMILY, L ≥ 12: take p₀ = (1, 4, 7, 10). Coordinate i of p_m is within distance 1 of a multiple of L only for m in a
     window of three consecutive residues, and the four windows ({−2,−1,0}, {−5,−4,−3}, {−8,−7,−6}, {−11,−10,−9} mod L) are disjoint
     iff L ≥ 12. Outside its window a coordinate keeps [p_m − 2, p_m + 2] (the reach of X̃) inside one block; inside, the forced
     cubes c_{m−1} (indices p_m − 1) and c_m (indices p_m) already reach both neighbouring blocks in that coordinate through their
     touching neighbours. So the closure of X̃ is member-independent and κ(1 − 1/L) ≥ ½ ln 11489 holds for L ≥ 12.
 (c) L = 3: force both antipodal cubes around each edge (indices {1}³ and {2}³ in coordinates 2–4); the count per edge is then
     N₂(Q₃, h = 3) = 46 (`rec/q4count.txt`), and κ(1 − 1/3) ≥ ln 46.
 For 4 ≤ L ≤ 11 the diagonal family's closure of X̃ can depend on the member (windows overlap; the mixed corner blocks are reached
 only through S_m), so run c's κ_fl at those L is not established; run d replaces it by (a). The optima at L = 12 (variants C′, C,
 D) are unaffected; variant B's optimum moves.
12.3 STAKES FOR RUN d (`bin/m6c_thresholds_d.py` = run c with κ_fl(L) := ½ ln 11489/(1 − 1/L) for L ≥ 12, ln 91/(1 − 1/L) for
4 ≤ L ≤ 11, ln 46/(2/3) at L = 3; written before the run):
 d1 κ_fl = 5.7432 (L = 3), 6.0145 (4), 5.6386 (5), 5.4130 (6), 5.0995 (12, unchanged).
 d2 variant B optimum: L = 5, M = 245, binding T18c ≈ 124.33 decades, X_small there ≈ 123.86 (close behind); L = 6: M = 247, 124.377.
 d3 C′, C, D optima unchanged at L = 12: 72.58066, 48.97446, 13.10410.
