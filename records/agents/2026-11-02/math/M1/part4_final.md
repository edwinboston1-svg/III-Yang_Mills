
## 4. THE NUMBERS (every one a certified PASS of `kp_cert_m1.awk`, the record's engine plus the M1 modes, on the 2·10⁻⁴ grid)

Engine `kp_cert_m1.awk` (md5 in each record's START line; final 854dc6fc414c2821f23673b0a9d2643e) = the record's
`kp_cert_table_wip.awk` with added modes, each inert when unset (control: output character-identical to the record's engine
at the record's point, both dressings, `ctl_rec_*.txt` = `ctl_m1_*.txt` = `ctl_m1b_*.txt`, re-checked at every engine
version): EVENTAIL (Corollary T3's tail), NCSIG (σ(F) on the census contact leaves), UNCOND (Corollary U's tail activity,
its constants computed from the engine's own Bessel brackets and rounded up: δ₁, ε₁, then K₁ the least grid x with
x⁸ ≥ B⁵, B = 2(1+δ₁), C₁ = (1+δ₁)B²√B, K_I = 2^{5/4}ε₁, C_I = 32), U712 (Corollary U′: x¹² ≥ B⁷, C₁ = (1+δ₁)B²B^{1/3},
K_I = 2^{7/6}ε₁, C_I = 2^{14/3}, every root the least grid point above), UNCREC (the same activity under the record's own
tail, N(F) ≤ 5^{F−1} at every F, no T1, no T2), TKN/TKD and TCN/TCD (tail-only factors, used once, for a projection).
Table of record tag g throughout (`r2tab_g.txt`); NC22 = 46,816 at F₀ = 22.

**4a. THE CONDITIONAL NUMBER (S12's staked activity bound kept, as in the record), with the sharpened tail (T1 + T2).**

| dressing | F₀ | record (old tail) | sharpened tail (T1 + T2), NCSIG | records |
|---|---|---|---|---|
| page | 20 | 0.4764 | **0.5050** (α ∈ [0.0035, 0.0043]; refused at 0.5052) | `scan_even_page_F20.txt`, `scan_even_page_F20n.txt` (final engine) |
| page | 22 | never run | **0.5100** (α ∈ [0.0033, 0.0038]; refused at 0.5102) | `scan_even_page_F22.txt`, `scan_even_page_F22n.txt` (final engine) |
| tree | 20 | 0.4816 | **0.5140** (α ∈ [0.0039, 0.0046]; refused at 0.5142) | `scan_even_tree_F20.txt` (top of range), `scan_even_tree_F20b.txt` |
| tree | 22 | never run | **0.5198** (α ∈ [0.0036, 0.0043]; refused at 0.5200) | `scan_even_tree_F22.txt` (top of range), `scan_even_tree_F22b.txt` |

Stakes (§1): (T-b) page HELD at its lower edge (0.5050 ∈ [0.505, 0.525]); tree HELD (0.5140 ∈ [0.510, 0.530]). (T-c) HELD:
F₀ = 22 adds +0.0050 (page) and +0.0058 (tree), inside [+0.002, +0.008]. (T-d) HELD: every refusal one step above β* reads
"the inequality's upper end is above alpha", never a dressing failure. NCSIG moves no digit of any β* (the page scans with
and without it agree to the grid).
The FLOOR the record wrote for "every tail leaf at 8" (0.4672 page, F₀ = 20): with the sharpened tail and F₀ = 22,
**0.5034** (page; α ∈ [0.0032, 0.0043] at 0.5034, refused at 0.5036; `scan_even8_page_F22.txt`) — conditional, exactly
as the record's floor, on no rank-≥2 leaf exceeding 8.
(F₀ = 22 rests on N_c(22) = 46,816 read on ONE road in the record, g51's F₂-rank road, b11a70dbf; F₀ = 20 on two.)

THE CONDITION, STATED EXACTLY. The record's tail activity is 4σ(F)u^F for every leaf, σ(F) the single-higher-spin factor.
For a leaf with m = 1 piece (every surface, every forest-contact leaf) that is proved (one spin per piece: S11 at spin j).
For m ≥ 2 the spin sum also contains MIXED half-integer assignments (pieces at ½ and at 3/2, …; Lemma S (b) allows them,
since only the parity of 2j is forced to be uniform), which σ(F) does not price. So the conditional numbers above are
conditional on S12 in its spin-summed form, Σ_spins|W(X)| ≤ 4σ(F)u^F on the open class — the record's staked object,
read as its tail uses it. Corollary U′ is a proof of a weaker spin-summed bound on the same class.

**4b. THE S12-FREE NUMBER (Corollary U′'s activity in place of the staked 4σ(F)u^F; everything else the record's).**

| exponent | dressing | F₀ | tail counting | β*_u | α at β*_u | record |
|---|---|---|---|---|---|---|
| 7/12 (U′) | page | 22 | T1 + T2 | **0.3348** | [0.0043, 0.0047] | `scan_u712_page_F22.txt` |
| 7/12 (U′) | tree | 22 | T1 + T2 | TREE712 | | `scan_u712_tree_F22.txt` |
| 7/12 (U′) | page | 20 | T1 + T2 | 0.3280 | [0.0042, 0.0058] | `scan_u712_page_F20.txt` |
| 7/12 (U′) | page | 20 | the record's (5^{F−1}, every F) | U712R20 | | `scan_u712rec_page_F20.txt`, `_F20b.txt` |
| 5/8 (U) | page | 22 | T1 + T2 | 0.3246 | [0.0044, 0.0047] | `scan_unc_page_F22.txt` |
| 5/8 (U) | tree | 22 | T1 + T2 | not read (stopped by hand at 75 min, superseded by U′) | | `scan_unc_tree_F22.txt` |
| 5/8 (U) | page | 20 | T1 + T2 | 0.3180 | [0.0046, 0.0053] | `scan_unc_page_F20.txt` |
| 5/8 (U) | page | 20 | the record's | 0.2916 | [0.0045, 0.0062] | `scan_uncrec_page_F20.txt` |

THE STATEMENT. THEOREM 8.9 WITHOUT S12: SU(2) Wilson lattice gauge theory on ℤ⁴ at 0 < β ≤ β*_u = 0.3348 (page dressing,
F₀ = 22; the tree value in the table) has a convergent polymer expansion uniform in the volume, a unique infinite-volume
Gibbs measure, exponential clustering of local gauge-invariant observables at the certified rate α(β) and a transfer-
matrix gap ≥ α(β) — by the record's chain (S1 §14's inequality, D1.1–D1.4, Theorem 7.1) with the tail activity replaced by
Corollary U′ (T1, T2, Lemmas R, M′, E, S, and Corollary FS for non-orientable pieces at every spin: §§1, 3, 3b, 10) and
every other input as the record has it and signed (S1 §25 (i)). It extends Theorem 8.7's 0.2452 by +0.0896. ONE ITEM is
the record's own and is named in §8 (2): the dressing's joint decoration bound is stated for branch-free rests and the
record applies it to every leaf; the census contact leaves inside the record's 0.4764 use it in exactly the same way.
At the refused point β = 0.3350 the tail is 0.0045596 of the left side's 0.0045851 (99.4 %; rK₁′ = 0.7315): the number is
the tail's, and the lever is the density exponent (Proposition LP, §8 (1)).
