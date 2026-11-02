# M87 — THE BLOCK SPLIT OF THEOREM 8.7: VALIDITY, PRICE, AND THE ONE UNCONDITIONAL NUMBER (2026-11-02)

Proof agent M87. Brief: `../MATH_BRIEF.md` (read in full, integrity list of 10:2x included). Read-only in both repositories.
Work directory: this one. Every step labelled PROVED / CERTIFIED / READING. Stakes are written in §2 before any instrument runs.

## 0. SOURCES READ (in full unless a range is given)

- THE GROUND §8.3 (paper text `../../cross/ground_docx.txt` lines 298–400, copied to `ground_s83.txt` here): the reduction, Proposition
  8.4, Hypotheses I/II, Theorem 8.5 with proof, line 29 (block criteria of Dobrushin–Shlosman kind), the perfect cover (line 30),
  Lemma 8.6 with proof, Theorem 8.7 with proof, (8.11), (8.12), Table 3, line 92 (certification, sharp constants 0.2452), "the open part".
- III `STDLIB/build/pentapylon/g27_blocksplit.pl`, `g27_blocksplit_base.pl` (the instruments; the base variant is the same file with the
  variant line 14 active), records `g_g27.txt` (= g27_blocksplit.2026-10-29a), `g27_blocksplit_base.2026-10-29a.txt` (all 56 lines each).
- III `STDLIB/build/pentapylon/g24_rowsum.awk` (header and formula lines) and `g24_rowsum.2026-10-29a.txt` (the record of the crossing).
- III `STDLIB/build/pentapylon/g23_decim.pl` header and `g23_decim_b{0.245,0.27,0.30,0.35}.2026-10-29b.txt`.
- Reader digest `../../read/digests/044_R.md` (the g27 entries, batch 20, and the synthesis checkpoint at R065).
- `../MG/WORK.md` §6.4 (Theorem 8.7_G form) and `../MG2/WORK.md` §§2–4.7 (Theorem 8.7_G proved for every compact G; SU(2) known answer
  on a second road; the per-group certified table). I cite MG2; I do not recompute per-group constants.

## 1. THE OBJECT

Theorem 8.7 (THE GROUND, §8.3). L₁ = the period-2 perfect cover (one link per site; every plaquette holds exactly one), L₀ its complement
(three links per site). Given L₀ the cover links are independent von Mises–Fisher; the L₀-marginal is a finite-range Gibbs measure. For
x ∈ L₀ the proof bounds the Dobrushin coefficient C(x, y) of the L₀-specification by
  C_dir = ρ(ω)(4β/3π) m(5β) + ¼(β²D₅ + ⅔β³T₆)              for each TYPE I position (y one of the two other kept links of a plaquette of x; 12),
  C_med = ρ(ω) β²/(3π) + ¼(min(β²D₅, 2β³T₆) + ⅔β³T₆)       for each TYPE II position (y a kept link of one of the five other plaquettes
                                                             of the cover link a_p of a plaquette p of x; 90),
  ω = 3β²D₅ + 2β³T₆, ρ(ω) = (3e^ω − 1)/2, α(β) = 12C_dir + 90C_med,
with PROVED constants D₅ = m(5β)²/3, T₆ = m(6β)/2 (Lemma 8.6), m = I₂/I₁, or SHARP constants D₅ = sup_{r≤5β}|D(r)| = |D(5β)|,
T₆ = sup_{r≤6β, directions}|κ₃| = |φ‴(6β)| (record g24 + g19's sup-lemmas; MG2's cell enclosures). Dobrushin's uniqueness theorem with
single-link sites needs sup_x Σ_y C(x, y) < 1; the proof certifies it by α(β) < 1: on [0, 0.2414] (proved), [0, 0.2452] (sharp).

THE BOUND MATRIX. For x, y ∈ L₀ let N_I(x, y) be the number of TYPE I positions of y relative to x and N_II(x, y) the number of TYPE II
positions; C̄ := N_I·C_dir + N_II·C_med (a link in several positions counted once for each, as the paper does). Every x has exactly
12 TYPE I and 90 TYPE II positions, so C̄𝟙 = α𝟙; both relations are symmetric, so 𝟙ᵀC̄ = α𝟙ᵀ. The proof establishes C ≤ C̄ entrywise.

THE BLOCK SPLIT (g27). Side-2 blocks {2k₁, 2k₁+1} × … × {2k₄, 2k₄+1}. Plain assignment: a link is in a block iff both ends lie in it
(inter-block links belong to none). Base assignment: each link to the block of its base point. For each kept-link class the record counts
in-block TYPE I and TYPE II positions and prints the row with them removed, using CLASS-AVERAGED in-block fractions:
  base, inter classes: fractions 5/12 and 22/90 → "0.814610 at 0.26, 0.959981 at 0.28, 1.121173 at 0.30";
  base, intra classes: 8/12, 36/90 → 0.591942, 0.698568, 0.817033;  plain: inter classes keep the full row (in-block 0).
WHAT ITS OWN AUTHORS SAID. The instrument's header (g27_blocksplit.pl lines 3–5): "A READING of the bound's bookkeeping, not a theorem:
a Dobrushin-Shlosman block criterion does not simply drop in-block neighbours (the block's own conditional law and its response to the
outside both enter); this counts what the uniform-constant row … would be if the neighbours sharing y's side-2 block were removed, to
show where it pays." The reader 044_R tagged it CONDITIONAL "on a block-Dobrushin theorem whose in-block half — contraction of each
block's own specification — these records do not compute". The paper (line 29) states in prose that no block criterion of
Dobrushin–Shlosman kind gains on the single link at any block side with first-order transmission. The question put to M87 is whether
the split is nevertheless a legitimate input, and if not, what the dropped term is and what it costs.

## 2. STAKES (written before any instrument in this directory runs; none will be edited)

S-0 (THE VERDICT, staked as a theorem to be proved in §3). The block split is NOT a legitimate input to Theorem 8.7's argument. The
in-block incidences are not interactions a block criterion may drop: every valid block criterion (Dobrushin–Shlosman, Weitz, Georgii's
block specification) bounds the block's OWN response to an outside change, which runs through the in-block links. The only proved
bound on that response is Dobrushin's comparison theorem inside the block, D_B = (I − C̄_BB)⁻¹, and with it the block row is
EXACTLY 𝟙 + (α − 1)(I − C̄_BB)⁻¹𝟙: below 1 iff α < 1. The dropped term is C̄_BB(I − C̄_BB)⁻¹C̄_BO𝟙 (the in-block Neumann propagation);
priced, it returns the threshold of Theorem 8.7 exactly, for every partition into blocks and every weight. The corrected β* is
[0.2414, 0.2415) on the proved constants and [0.2452, 0.2453) on the sharp ones — the gain is identically zero.
S-1 (geometry). My re-derivation of g27's cover (the same backtracking, the same candidate order) reproduces all 48 per-link lines of
g27_blocksplit_base.2026-10-29a.txt and of g_g27.txt exactly. With the paper's explicit cover (line 30) every kept link has exactly 12
TYPE I and 90 TYPE II positions on ℤ⁴, N_I and N_II are symmetric, and N_I(x, y) ∈ {0, 1}. The number of DISTINCT kept links among the
102 positions: UNGUESSED. The base-assignment in-block counts with the paper's cover: UNGUESSED per link (the base assignment breaks the
cover's symmetries, so they may differ from g27's).
S-2 (proved constants, exact rationals; a third road beside g24 and MG2). α(0.241) = 0.996297 (Table 3, six digits);
ROW(0.2414) ∈ [0.999866075428161, 0.999866075428162] (g24) to every printed digit; α(0.2415) = 1.000759624 (g24): certified
α < 1 at 0.2414 and α > 1 at 0.2415.
S-3 (sharp constants, pointwise at the grid points; the sup-lemmas cited from g19 / MG2, with |D| monotone proved here in §3.4).
|D(5·0.2452)| = 0.0262086277, |φ‴(6·0.2452)| = 0.0604812424, ROW(0.2452) = 0.99946317 < 1 < ROW(0.2453) = 1.00031013 (g24).
S-4 (the theorem, read on the instrument). For both assignments and both covers, the first-order block row computed directly as
(I − C̄_BB)⁻¹C̄_BO𝟙 equals 𝟙 + (α − 1)(I − C̄_BB)⁻¹𝟙 to interval width; at β = 0.26, 0.28, 0.30 every corrected row is ≥ α(β) > 1;
the corrected crossing lands in the same grid cell as α's on both constant sets; the max in-block row is < 1 at 0.30 (so the Neumann
series converges and the bound is finite).
S-5 (the lead on its own terms). The record's 0.959981 is a class average. The worst base-assignment link with g27's cover has
in-block (4, 17), off-block row 8C_dir + 73C_med: above 1 at 0.28 (predicted ≈ 1.05) and below at 0.26 (≈ 0.89), crossing predicted
near 0.274 (UNGUESSED to three digits). The class-average crossing reproduces ≈ 0.284.
S-6 (the second-decimation ceiling). Any further exact decimation L₂ ⊂ L₀ (an independent set of the L₀-marginal's interaction graph)
has density at most 1/6 per site, and removes at most α/17 from the average row; so a first-order argument keeping the per-position
constants for the surviving positions cannot certify past α(β) = 17/16. Predicted β ≈ 0.2489 (proved constants), ≈ 0.2528 (sharp);
UNGUESSED to four digits.
S-7 (what averaged composition must buy). For the base blocks at β = 0.26, the exact in-block indirect response must be below the
first-order one by a factor UNGUESSED (predicted ≥ 3) for the max form; at 0.28 the max form is impossible even with zero in-block
propagation (worst off-block row > 1), and the Dobrushin–Shlosman average form needs a factor UNGUESSED (predicted ≈ 6).

## 3. THE THEOREMS (PROVED here; the numbers they need are certified in §4)

### 3.1 Lemma U (uniform rows of the bound matrix) — PROVED, group-blind

Every kept link x has exactly 12 TYPE I and 90 TYPE II positions; N_I and N_II are symmetric; C̄ has zero diagonal. Hence
C̄𝟙 = α𝟙 and 𝟙ᵀC̄ = α𝟙ᵀ, and ρ(C̄) = α (a nonnegative matrix with constant row sums α has spectral radius α).
Proof. x lies in 2(d−1) = 6 plaquettes; each holds exactly one cover link, so its other two links are kept: 12 positions. Each cover
link a_p lies in 6 plaquettes, 5 other than p, each holding a_p and three kept links: 15 per a_p, 90 in all. TYPE I is the relation
"two kept links of one plaquette", TYPE II the relation "kept links of two different plaquettes through one cover link"; both are
symmetric, and N_II(x, y) = #{(a, p, q): a ∈ L₁, x ∈ p ∋ a, y ∈ q ∋ a, q ≠ p} is symmetric under (x, p) ↔ (y, q). No self-position:
x ∈ q ∋ a_p with q ≠ p would make x and a_p share two plaquettes, and two links share at most one. The counts use only the cover, so
they hold for every compact G. ∎  (Checked on the instrument: geom.2026-11-02a, M87-SYM: 0 asymmetric entries; max N_I = 1,
max N_II = 2; every kept link has 76 DISTINCT kept neighbours among its 102 positions — 18 links in more than one position, 8 of them
in both a TYPE I and a TYPE II position, at most 3 positions for one link.)

### 3.2 Lemma B (the block response at first order — the only proved bound) — PROVED

Let B be a finite set of kept links with max_x Σ_{y∈B} C̄(x, y) < 1 (max in-block row; verified in §4 at every β used), D_B :=
(I − C̄_BB)⁻¹ = Σ_n C̄_BB^n ≥ 0. For boundary conditions ξ, η on S∖B differing only on a finite set A and every bounded measurable f
on SU(2)^B: |γ_B(f | ξ) − γ_B(f | η)| ≤ Σ_{i, x ∈ B} δ_i(f) D_B(i, x) b_x, b_x := Σ_{y∈A} C̄(x, y).
Proof. Dobrushin's comparison theorem (Georgii, Gibbs Measures and Phase Transitions, Thm 8.20) on the finite index set B, applied
to the specification with single-site kernels γ_x(· | ·, ξ) — whose Dobrushin matrix is at most C̄_BB, with row sums < 1 — and to
the probability measure γ_B(· | η), whose single-site conditionals are γ_x(· | ·, η); for every in-block configuration these differ
from γ_x(· | ·, ξ) by at most Σ_{y∈A} C(x, y) ≤ b_x in total variation (triangle inequality along a chain of single changes from ξ
to η; each step changes one outside link and moves the kernel by at most C(x, y)). The theorem's hypothesis asks b_x to bound the
distance between the two single-site kernels — in Georgii's statement its average under the compared measure μ̃ = γ_B(· | η); the b_x
here bounds it UNIFORMLY over in-block configurations, which dominates the average, so the hypothesis holds in either form. ∎
Consequences: the x-marginal response is ≤ [D_B b]_x (take f a function of σ_x of oscillation 1); the Hamming–Wasserstein response
is ≤ 𝟙_Bᵀ D_B b (Kantorovich duality: a 1-Lipschitz f for the Hamming metric has δ_i(f) ≤ 1 for all i); the joint total
variation is ≤ 𝟙_Bᵀ D_B b (an indicator has δ_i ≤ 1 for all i). In-block links appear in NO b_x — the outside acts only through
b — but they act through D_B, and D_B − I = C̄_BB D_B is the in-block propagation. The g27 split keeps b and replaces D_B by I.

### 3.3 Theorem M87.1 (THE BLOCK SPLIT GAINS NOTHING AT FIRST ORDER) — PROVED, every compact G

Let 𝔅 be any partition of the kept links into finite blocks, each with max in-block row < 1. Put C̄ = C̄_D + C̄_O (in-block /
off-block), D := (I − C̄_D)⁻¹ (block diagonal), s := D𝟙, and M := D C̄_O, the first-order block matrix (M(x, y) for y ∉ B(x) bounds
the influence of the outside link y on the block law at x, by Lemma B). Then
 (i)   M𝟙 = 𝟙 + (α − 1) s, with s ≥ 𝟙 + C̄_D𝟙 ≥ 𝟙 entrywise;
 (ii)  if α < 1 then M𝟙 ≤ α𝟙 − (1 − α)C̄_D𝟙 ≤ α𝟙: the block rows are SMALLER than α (a faster contraction), with the same threshold;
 (iii) if α ≥ 1 then M𝟙 ≥ 𝟙 entrywise, and for every weight w with 0 < inf w ≤ sup w < ∞, sup_x (Mw)_x / w_x ≥ 1;
 (iv)  (Dobrushin–Shlosman average form) for every block B, Σ_{x∈B}(M𝟙)_x = |B| + (α − 1) Σ_{x∈B} s_x, which is < |B| iff α < 1;
 (v)   (Georgii's block specification, blocks as sites, joint total variation) the block row Σ_{B'≠B} C^𝔅(B, B') is bounded by
       Σ_{x∈B}(M𝟙)_x = |B| + (α − 1)Σ_{x∈B} s_x, which for |B| ≥ 2 is below 1 only when α < 1 − (|B| − 1)/Σ_{x∈B}s_x: strictly WORSE.
So every block criterion whose block response is bounded by the comparison theorem — the only composition proved — holds iff
α(β) < 1 (forms (ii)–(iv)) or only on a smaller set (form (v)). The threshold is Theorem 8.7's, for every partition, every weight.
Proof. C̄_O𝟙 = C̄𝟙 − C̄_D𝟙 = α𝟙 − C̄_D𝟙 = (I − C̄_D)𝟙 − (1 − α)𝟙 (Lemma U). Apply D: M𝟙 = 𝟙 − (1 − α)D𝟙, which is (i);
s = Σ_n C̄_D^n 𝟙 ≥ 𝟙 + C̄_D𝟙 since every term is nonnegative. (ii) and (iv) follow at once from (i). (iii): M ≥ 0 and M𝟙 ≥ 𝟙
give M^n𝟙 ≥ 𝟙 for all n; if Mw ≤ θw with θ < 1, then (inf w)𝟙 ≤ (inf w)M^n𝟙 ≤ M^n w ≤ θ^n w ≤ θ^n (sup w)𝟙, so θ ≥ 1 —
a contradiction. (v): C^𝔅(B, B') ≤ 𝟙_Bᵀ D_B C̄_{B,B'}𝟙 by Lemma B with an indicator, and summing over B' gives 𝟙_Bᵀ M𝟙. ∎
THE DROPPED TERM, NAMED AND PRICED. The g27 reading is the row of C̄_O alone, r := C̄_O𝟙 = (12 − n_I^in)C_dir + (90 − n_II^in)C_med.
The legitimate first-order block row is M𝟙 = D r = r + C̄_D D r. The dropped term is C̄_D D r = (D − I) r, the in-block Neumann
propagation of the outside influence; its price is exactly (α − 1)s + 𝟙 − r, which restores the threshold α = 1.
WHY THE VALID BLOCK CRITERION IS A CRITERION. For f bounded, γ_B f (B integrated out) has δ_i(γ_B f) = 0 for i ∈ B and, by Lemma B
with A = {y}, δ_y(γ_B f) ≤ δ_y(f) + Σ_{i∈B} δ_i(f) M(i, y) for y ∉ B. So Δ(f) := Σ_y δ_y(f) obeys
Δ(γ_B f) ≤ Δ(f) − Σ_{i∈B} δ_i(f)(1 − (M𝟙)_i): the block analogue of the step in Dobrushin's uniqueness proof (Georgii Thm 8.7),
which closes iff max_i (M𝟙)_i < 1. The g27 split asserts this step with M replaced by C̄_O — i.e. that the outside link y moves the
block law at i no more than it moves the single-link kernel at i with the rest of the block frozen. Nothing proves that, and Lemma B
shows the proved bound is larger by exactly the in-block propagation.

### 3.4 Theorem M87.2 (the regular-splitting equivalence; Stein–Rosenberg / Varga) — PROVED, for ANY bound matrix

For a finite nonnegative matrix C (any rows) and any partition with ρ(C_D) < 1: ρ((I − C_D)⁻¹C_O) < 1 ⟺ ρ(C) < 1. Moreover
(I − C_D)⁻¹C_O w ≤ θw for some w > 0, θ < 1 ⟺ C w′ ≤ θ′w′ for some w′ > 0, θ′ < 1.
Proof. (⇐) If ρ(C) < 1 take u > 0 and w := (I − C)⁻¹u = Σ C^n u ≥ u > 0. Then C_O w = w − u − C_D w, so (I − C_D)w − C_O w = u and
(I − C_D)⁻¹C_O w = w − (I − C_D)⁻¹u ≤ w − u; hence Mw ≤ θw with θ = max_i (1 − u_i/w_i) < 1, and ρ(M) ≤ θ (Collatz–Wielandt).
(⇒) I − C = (I − C_D)(I − M); if ρ(M) < 1 both factors have nonnegative Neumann inverses, so (I − C)⁻¹ = (I − M)⁻¹(I − C_D)⁻¹ ≥ 0
exists, I − C is a nonsingular M-matrix, and ρ(C) < 1 (Collatz–Wielandt again gives the weighted form). ∎
READING THE THEOREM ACROSS FIELDS. Dobrushin's first-order composition is a LINEAR ITERATION on the M-matrix I − C̄: the single-site
criterion is point Jacobi, a block criterion is block Jacobi (a regular splitting), a sequential sweep is Gauss–Seidel. Varga's
regular-splitting theorem and the Stein–Rosenberg theorem say exactly that every such splitting of a nonnegative iteration converges
iff ρ(C̄) < 1 — blocking accelerates, it never moves the threshold. The g27 split took the iteration matrix to be C̄_O and forgot
the (I − C̄_D)⁻¹ in front of it: the block-Jacobi iteration matrix is (I − C̄_D)⁻¹C̄_O.

### 3.5 Lemmas for the SHARP constants — PROVED here (D) / certified by cells (T, §4)

(D) |D| is increasing on [0, 2]. With D = φ″ − m/r ≤ 0, the Riccati identity (8.9) gives φ‴ = −3D/r − 2mφ″ and (m/r)′ = D/r, so
|D|′ = −D′ = 2mφ″ − 4|D|/r. Since φ″ = m/r − |D|, |D|′ ≥ 0 ⟺ m² ≥ |D|(mr + 2), and Lemma 8.6(ii) (|D| ≤ m²/3) gives it whenever
mr ≤ 1. m is increasing and positive, so mr is increasing; m(2)·2 < 1 is certified in §4. Hence sup_{r≤5β}|D(r)| = |D(5β)| for
5β ≤ 2 (β ≤ 0.4) — the g24 record's (B3), on a second road.
(T) The largest third cumulant over directions. With a := 3|D|/r ≥ 0 and b := 2mφ″ ≥ 0 (so φ‴ = a − b), the third cumulant along a
unit vector at cosine c to ŵ is g(c) = (2a − b)c³ − ac (THE GROUND, proof of Lemma 8.6(iii)); it is odd in c. If b ≥ 2a, |g| is
increasing on [0, 1]; if a ≤ b < 2a, |g(c)| = ac − (2a − b)c³ has its maximum at c = 1 iff 3b ≥ 5a, else at c₀² = a/(3(2a − b)) with
value (2/3)a c₀. So max_c |g| = b − a = |φ‴| exactly when b ≥ (5/3)a. The certified sup of max_c|g| over r ≤ 6β is taken by cells
in §4 (monotone series enclosures of A, B, P on each cell — increasing in z because their coefficients are positive), with no use of
monotonicity in r. ATTRIBUTION: the reduction to g(c) is the paper's (proof of Lemma 8.6(iii)) and Lemma D rests on Lemma 8.6(ii)
(Turán, the paper's); the sup over r and over c, and the monotonicity of |D|, are certified/proved here; nothing is taken from g19.

## 4. RESULTS BESIDE THE STAKES (records `geom.2026-11-02a.txt`, `rows.2026-11-02b.txt`; rc = 0; instruments `geom.py`, `ivr.py`,
## `rows.py` in this directory; exact rationals, every endpoint rounded outward to the grid 2^-320; no floating point in any enclosure)

S-1 HELD. The g27 backtracking cover, re-derived in Python in the same candidate order, IS THE PAPER'S COVER (line 30): both give the
residue map [0,2,1,2,3,3,1,0,0,1,3,3,2,1,2,0]; the perfect-cover property holds on the box |x| ≤ 3 (0 defects). All 48 G27-LINK lines
of g_g27.txt (plain) and all 48 of g27_blocksplit_base.2026-10-29a.txt (base) are reproduced byte for byte [MET]. Every kept link has
12 + 90 positions, N_I, N_II symmetric (0 asymmetric entries), max N_I = 1, max N_II = 2. UNGUESSED column read: 76 distinct kept
neighbours per link (18 in several positions, 8 in both types, at most 3 positions). Base block: 48 kept links, in-block counts from
(4, 17) to (10, 45); plain block: 24 intra links, each (6, 22); the 24 inter classes are singletons (in-block 0).

S-2 HELD (proved constants, a third road sharing no line with g24's awk or MG2's mpmath). α(0.241) = [0.996296731179, 0.996296731180],
12C_dir = 0.3635404, 90C_med = 0.6327563, ω = 0.0093719, ρ = 1.0141240 (Table 3, every printed digit) [MET]; Table 3 at 0.200, 0.220,
0.230, 0.240, 0.2415 [MET]; ROW(0.2414) = [0.999866075428161, 0.999866075428162], M5, D5, T6, ρ, C_dir, C_med equal to g24's printed
enclosures to 15 digits [MET]; ROW(0.2415) = [1.00075962398605, 1.00075962398606] [MET]. m by two roads (regular variables; Bessel
series) agree to 10⁻³⁰. CERTIFIED: α < 1 at 0.2414, > 1 at 0.2415; α increasing in β, so the theorem holds on [0, 0.2414].

S-3 HELD, and STRENGTHENED. Pointwise sharp constants at 0.2450 (ROW 0.997770426876, D5 0.026173090, T6 0.060470317) [MET g24 KAT].
My own certification of the sup-lemmas replaces the citation of g19: Lemma D (§3.5) with m(2)·2 = 0.866254853444 < 1 [CERTIFIED], and
the third-cumulant sup taken by 10,037 cells on [10⁻⁹, 1.8] with monotone enclosures of A, B, P — the direction maximum at c = 1 is
certified on ALL 10,037 cells (b ≥ 5a/3 everywhere on (0, 1.8]: g19's (E2DIR), on a second road, to 1.8 rather than 1.5). The cell sup
at 6·0.2452: T6 ≤ 0.0605025265 (pointwise |φ‴| = 0.0604812424, g24's value). With it α_sharp(0.2452) = [0.999469390026, 0.999469390027]
< 1, and with the pointwise T6 (a lower bound of the sup) α_sharp(0.2453) = [1.000310130059, 1.000310130060] > 1. CERTIFIED:
β* ∈ [0.2452, 0.2453) on the sharp constants, with no lemma taken from g19 (the direction reduction g(c) and Lemma 8.6(ii) are
THE GROUND's own; the sups over r and c are certified here).

S-4 HELD (THE THEOREM, read on the instrument). At every β and both constant sets the first-order block row computed DIRECTLY as
(I − C̄_BB)⁻¹C̄_BO𝟙 (directed-rounding Neumann, upper bounds by a verified super-solution) agrees with 𝟙 + (α − 1)s on every link of both
assignments. The corrected rows sit on the same side of 1 as α:
| β | set | α | plain block rows | base block rows [min, max] | base block average | joint-TV block row (base) |
|---|---|---|---|---|---|---|
| 0.2414 | proved | 0.99986608 | 0.99979782 | [0.99971599, 0.99981056] | 0.99977092 | ≥ 47.99 |
| 0.2415 | proved | 1.00075962 | 1.00114733 | [1.00107500, 1.00161223] | 1.00130021 | ≥ 48.06 |
| 0.2452 | sharp (cell T6) | 0.99946939 | 0.99919715 | [0.99887133, 0.99924832] | 0.99909035 | ≥ 47.96 |
| 0.2453 | sharp | 1.00031636 | 1.00047889 | [1.00044836, 1.00067348] | 1.00054270 | ≥ 48.03 |
| 0.26 | proved | 1.17459056 | 1.28869105 | [1.27174619, 1.43973709] | 1.34205645 | ≥ 64.42 |
| 0.28 | proved | 1.38246020 | 1.71273169 | [1.68510794, 2.21816802] | 1.90776101 | ≥ 91.57 |
| 0.30 | proved | 1.61254416 | 2.32700279 | [2.35106856, 3.68004312] | 2.90478998 | ≥ 139.43 |
The corrected crossing is [0.2414, 0.2415) (proved) and [0.2452, 0.2453) (sharp) for both assignments: THE GAIN IS ZERO. Below the
threshold the corrected rows are smaller than α (a faster contraction, Theorem M87.1(ii)); above it they are LARGER than α (in-block
amplification s ∈ [1.41, 2.13] at 0.2414–0.2415, [1.79, 3.19] at 0.28). Max in-block row 0.62 (base, 0.2414), 0.85 (0.28), 0.994 (0.30): the
Neumann bound is finite at every β used. The joint-TV block form is off by a factor ≈ |B| — strictly worse, as (v) says.

S-5 HELD, and the lead's own number corrected twice. The record's 0.959981 at 0.28 is a CLASS AVERAGE (fractions 5/12, 22/90 over 24
inter classes), reproduced [0.959980, 0.959981]. The worst base link (0,0,0,1:3 and its class mates, in-block (4, 17)) has the
off-block row 8C_dir + 73C_med = [1.050420, 1.050421] at 0.28 — ABOVE 1 — and [0.891616, 0.891617] at 0.26. Certified crossings on the
grid 10⁻⁴ (the uncorrected readings are increasing in β):
| uncorrected reading | proved constants | sharp constants |
|---|---|---|
| the record's class average 7C_dir + 68C_med | [0.2851, 0.2852) | [0.2922, 0.2923) |
| the per-link worst 8C_dir + 73C_med (base) | [0.2738, 0.2739) | [0.2800, 0.2801) |
| the plain assignment (inter links keep the full row) | = α: [0.2414, 0.2415) | [0.2452, 0.2453) |
| THE LEGITIMATE (corrected) first-order block row | [0.2414, 0.2415) | [0.2452, 0.2453) |
"Crossing near 0.284" (044_R's interpolation) is 0.2851 exactly for the average and was never "every class": per link it is 0.2738.
THE SOURCE WAS ALREADY SELF-REFUTING. The base record never computes a per-class row: its G27-ROW lines apply the tag-averaged
fractions (5/12, 22/90) to one uniform row, so "every class's row is below 1 … (worst 0.959981)" in the digest reads an average as a
worst case — while the same record's own G27-LINK lines list six inter classes at in-block (4, 17), whose row is 1.0504 at 0.28. And
the instrument's header disclaims the whole reading ("not a theorem … does not simply drop in-block neighbours").

S-6 REFUTED IN THE THIRD DIGIT (the prediction corrected, not the theorem). α = 17/16 is crossed in [0.2482, 0.2483) on the proved
constants (staked ≈ 0.2489) and [0.2525, 0.2526) on the sharp ones (staked ≈ 0.2528). The ceiling of §5.1 is therefore β ≤ 0.2483
(proved) / 0.2526 (sharp).

S-7 HELD in shape, numbers read. What the exact in-block response must beat first order by, on the base side-2 blocks:
| β, set | max form (binding link) | Dobrushin–Shlosman average form |
|---|---|---|
| 0.26 proved | factor ≥ 3.507 | factor ≥ 2.153 |
| 0.26 sharp | ≥ 2.360 | ≥ 1.750 |
| 0.28 proved | IMPOSSIBLE: 6 links have direct off-block row ≥ 1 (1.0504) | ≥ 6.317 |
| 0.28 sharp | ≥ 3955.7 (the worst direct row is 0.999862) | ≥ 4.363 |
| 0.30 proved | IMPOSSIBLE (27 links) | ≥ 62.65 |
(plain blocks: 2.308 at 0.26 and 9.807 at 0.28, proved, both forms; IMPOSSIBLE at 0.30.) The factor is the first-order indirect
in-block response divided by the slack 1 − (direct off-block row), a lower bound on the improvement an averaged composition must deliver.

## 5. WHAT IT WOULD TAKE TO GO FURTHER — CEILINGS PROVED, TARGETS MEASURED

### 5.0 Addendum to Theorem M87.1: the column (path-coupling) form — PROVED

For a partition, the path-coupling block criterion (resample a uniformly chosen block; Hamming distance) needs, for every link y,
Σ_{B∌y} κ_B(y) < 1 with κ_B(y) ≥ the Hamming–Wasserstein response of block B to a change at y; at first order κ_B(y) ≤ (𝟙ᵀ M)_y.
Since C̄ is symmetric, 𝟙ᵀM = (C̄_O s)ᵀ, and over one period cell Σ_y(𝟙ᵀM)_y = Σ_x(M𝟙)_x, so the AVERAGE column equals the average
row = 1 + (α − 1)·avg(s): if α ≥ 1 the max column is ≥ 1 and the criterion fails; if α < 1 Theorem M87.2 supplies a weight under which
it holds. So the column form has the same threshold. On the side-2 base partition one block IS the period cell (48 kept-link
classes), so the block averages of §4 are the averages of both the rows and the columns: the S-7 average-form factors are lower
bounds on the improvement ANY block criterion on that partition needs (row or column form).

### 5.1 Theorem M87.3 (the second-decimation ceiling) — PROVED for the class stated

Let L₂ ⊂ L₀ be a set of kept links that are conditionally independent given L₀′ = L₀ ∖ L₂ under the L₀-marginal ∏_a Z(|η(a)|) — i.e.
every cover link's star (its 18 kept links) holds at most one link of L₂ (a factor Z(|w + θ(x) + θ′(x′)|) with x, x′ ∈ L₂ does not
factor: its logarithm carries the cross term ⟨θ(x), θ′(x′)⟩/4 at second order). Integrate L₂ exactly. Consider any first-order
argument on L₀′ whose bound matrix C′ keeps the per-position constants C_dir, C_med on the surviving positions (y, z ∈ L₀′) and puts
nonnegative numbers on the couplings created through the integrated links. Then on every torus compatible with L₂ (and on ℤ⁴ for
periodic L₂): ρ(C′) ≥ (16/17)·α(β). Hence no such argument — weighted, blocked or not (Theorems M87.1–2) — certifies past α(β) = 17/16:
β ≤ 0.2483 on the proved constants, β ≤ 0.2526 on the sharp ones (certified crossings [0.2482, 0.2483), [0.2525, 0.2526); §4 S-6).
Proof. Each kept link lies in exactly 6 stars (its 6 plaquettes have 6 distinct cover links), each star holds ≤ 1 link of L₂, so
6|L₂| ≤ |L₁| = N (sites): |L₂| ≤ N/6 and |L₀′| = 3N − |L₂| ≥ 17N/6. Distinct links of L₂ share no star, so they occupy no position of
one another (TYPE I and TYPE II positions both lie in one star): Σ_{z∈L₀′} C̄(z, x) = Σ_{z∈L₀} C̄(z, x) = α for x ∈ L₂ (Lemma U,
column sums). So 𝟙ᵀC̄|_{L₀′}𝟙 = |L₀′|α − |L₂|α, and C′ ≥ C̄|_{L₀′} entrywise. C̄|_{L₀′} is symmetric and nonnegative, so its largest
eigenvalue is at least its Rayleigh quotient at 𝟙: ρ(C′) ≥ ρ(C̄|_{L₀′}) ≥ α(1 − |L₂|/|L₀′|) ≥ α(1 − (N/6)/(17N/6)) = (16/17)α. (On ℤ⁴
with periodic L₂, a contraction Cw ≤ θw with bounded w averages over the period lattice to a periodic one, so the folded period-cell
matrix, symmetric with the same row sums, carries the bound.) ∎
WHY THE CLASS IS THE RIGHT ONE AT LEADING ORDER. A surviving pair y, z in the star of a cover link a whose star also holds an integrated
x interacts through Ξ_x = ∫ ∏_{p∋x} Z(|w_p + θ_p(U_x)|) dU_x. At second order log Z(|w|) = |w|²/8 and |w_p + θ_p U_x|² = |w_p|² +
2⟨w_p, θ_pU_x⟩ + β²: the y–z cross term (β²/4)⟨S_y, S_z⟩ inside |w_p|²/8 does not depend on U_x, so integrating x leaves the leading
y–z coupling unchanged and removes only the incidences of x itself. THE ONLY ESCAPE, AND WHY IT IS CLOSED AT SECOND ORDER: to beat the
ceiling, integrating x would have to lower the surviving couplings among x's neighbours by more than 1/17 of the row — integrating one
link would have to WEAKEN the interaction between two of its neighbours at leading order, and the U_x-independent cross term of
|w_p|²/8 forbids exactly that; any reduction lives at third order and beyond, and the whole third-order part of the row is
17β³T₆ ≈ 0.016 at β = 0.25 on the sharp constants (0.045 on the proved ones) — even its complete removal would move the ceiling by
under 1 % in β on the sharp constants and about 2 % on the proved ones (α ∝ β² there). A
second exact decimation is therefore worth at most a factor (17/16)^{1/2} ≈ 1.031 in β at first order. "A larger cover" does not cross
the interval.

### 5.2 The direct-row cap of the side-2 base blocks — READING-level bound for the class "direct part priced by C̄"

If an averaged composition removed the ENTIRE in-block indirect response and kept the direct off-block influences at their per-position
bounds, the max-form block row would be the uncorrected per-link row r_x. Its worst value 8C_dir + 73C_med crosses 1 at [0.2738, 0.2739)
(proved) / [0.2800, 0.2801) (sharp): no side-2 base block criterion in max form, however good its in-block composition, passes those
couplings while it prices the direct part by C̄. (The exact block response need not dominate r_x — re-equilibrated in-block links can
screen — which is why this is a bound on a class of arguments, not on the measure.) The average forms have no such cap for large blocks:
the direct off-block average falls like boundary/volume, and the whole question becomes the block's own response.

### 5.3 What averaged composition must buy (the precise target) — MEASURED (§4 S-7)

On the side-2 base partition the exact in-block indirect response, summed over the block, must be smaller than its first-order
(Neumann) bound by a factor ≥ 2.153 at β = 0.26 and ≥ 6.317 at 0.28 (proved constants; 1.750 and 4.363 on the sharp ones) for ANY block
criterion on that partition to pass; the row (max) form needs ≥ 3.507 at 0.26 and is unreachable at 0.28 (six link classes have direct
off-block row 1.0504 ≥ 1). A measured hint that such factors exist: the reader 044_R's g14 records find the d = 1 shell's averaged
transmission at f₁ = 0.11–0.30 of the one-face (sup-composed) bound at β = 0.3–0.7 — a factor 3–9 between averaged and sup composition.
That is a READING on a different object; turning it into a theorem is the object of §7.

### 5.4 The one input of the unconditional number on a single road: the sharp one-link (MAD) lemma

Both constant sets use "the mean absolute deviation of ⟨U, e⟩ under every von Mises–Fisher law ν_v on S³ is at most 4/(3π)" (THE GROUND
§8.1; certified in record g18 by four pieces: direct enclosure on 2079 rectangles, κ₁-monotonicity on 5434 rectangles with largest
upper endpoint −4.79·10⁻⁸, an axis hand lemma, and κ ≥ 20 by the variance). Theorem 8.7 uses it only on the disk κ = |v| ≤ 6βm(5β)
≤ 0.4254 (β ≤ 0.2453). On that disk M87 derives the second-order law (PROVED: second-order perturbation of the semicircle law of u
under Haar, E₀u² = 1/4, E₀|u| = 4/(3π), E₀|u|³ = 8/(15π), f₀(0) = 2/π; odd orders vanish by u ↦ −u):
  MAD(κ, α) = 4/(3π) − (κ²/π)[(13/120)cos²α + (1/30)sin²α] + O(κ⁴),
and reads it on quadrature (mad_check.2026-11-02a, READING, 40 digits): the coefficients −0.10831, −0.070817, −0.033328 at κ = 0.05
against −13/120, −17/240, −1/30, the residual/κ⁴ between +0.0006 and +0.0033 up to κ = 0.4254, where MAD ≤ 0.42252 < 0.42441. A second,
fully certified road to the lemma on the disk Theorem 8.7 uses is one rigorous κ⁴ remainder bound |R| ≤ Cκ⁴ with C < 1/(30π·0.4254²)
= 0.0586 — the measured C is 0.0033, a factor 17 inside. Until it is written the lemma stands on g18's single road.

## 6. EVERY COMPACT G — PROVED (form), cited (numbers)

Theorems M87.1, M87.2 and M87.3 use the decimation's combinatorics only: the perfect cover, the counts 12 and 90, the symmetry of the
position relations and the star structure — all group-blind (MG2 §4.3(a)). For every compact G with MG2's Theorem 8.7_G constants the
bound matrix C̄_G = N_I C_dir^G + N_II C_med^G has constant rows α_G, so: the block split as posted is NOT an input for any G; every
first-order block criterion has threshold α_G(β) = 1 exactly; a second exact decimation is capped at α_G = 17/16. The corrected block
thresholds therefore ARE MG2's certified Theorem 8.7_G thresholds (run general_eval.2026-11-02a; Lemma NH's universal constants):
SU(3) β* = 0.3568 (α = 0.99992, 12C_dir = 0.2822, 90C_med = 0.7177), G₂ β* = 0.5171 (α = 0.99927, 12C_dir = 0.2406, 90C_med = 0.7586),
SU(2) 0.1704 universal / 0.2452 with THE GROUND's sharp constants (MG2 §3, and §4 here). The SU(2)-specific constants of the row are
exactly MG2's F1–F5 list: m(5β) (the vMF mean modulus, MG2's μ̄), the covariance bound 1/4 (s̄), D₅ by Turán (D̄), T₆ (T), and the MAD
4/(3π) with its tilt factor (3e^ω − 1)/2 (M); the block geometry, the counts and the in-block fractions carry over verbatim.

## 7. STATEMENT AT FULL STRENGTH, AND THE NEXT OBJECT

PROVED. (1) The g27 block split (base or plain side-2 blocks, in-block incidences removed) is not a legitimate input to Theorem 8.7: a
block criterion must bound the block's own response to the outside, which runs through the in-block links; the only proved bound,
Dobrushin's comparison inside the block, gives the block row 𝟙 + (α − 1)(I − C̄_BB)⁻¹𝟙 exactly — the dropped term is the in-block
Neumann propagation (D − I)r, and pricing it returns α = 1 as the threshold for every partition, weight, row or column form, and every
compact G (Theorems M87.1, M87.2, Lemma U, Lemma B). (2) Any second exact decimation is capped at α = 17/16 (Theorem M87.3). (3) The
sharp constants' sup-lemmas: |D| increasing on [0, 2] (Lemma D); the third cumulant's maximum over directions at c = 1 on (0, 1.8].
CERTIFIED (exact rationals, outward rounding, a third road): Theorem 8.7's row below 1 on [0, 0.2414] (proved constants) and on
[0, 0.2452] (sharp constants, with the T6 sup certified by 10,037 cells and Lemma D — nothing taken from g19; the direction reduction
and Lemma 8.6(ii) are THE GROUND's own), above 1 at 0.2415 /
0.2453. THE UNCONDITIONAL NUMBER IS β* = 0.2452 (sharp; 0.2414 on Lemma 8.6's closed-form constants), resting on Dobrushin's theorems,
Lemma 8.6, the MAD lemma (certified, g18; second order derived and read here), and the two sharp lemmas (here). The block split moves
it by exactly zero. The lead's own numbers were also mis-stated: 0.959981 is a class average; per link the uncorrected row crosses at
0.2738 (proved) / 0.2800 (sharp), the average at 0.2851 / 0.2922.

THE NEXT OBJECT (precise). An averaged-composition theorem for the block response: a bound R̃_B on the exact influence of an outside link
on the side-2 base block law (the Dobrushin–Shlosman / Weitz quantity) that composes in-block paths through the INTEGRATED intermediate's
conditional law instead of the supremum at each step — e.g. a second-order comparison in which the two-step influence y → z → x is priced
by the covariance of the transmitted variable under z's tilted vMF law (the object of THE GROUND's line 29 and of g14's one-face law),
not by C̄(x, z)C̄(z, y). It must deliver, summed over the block, a factor 2.153 below the Neumann bound to pass β = 0.26 and 6.317 to pass
0.28 (proved constants; 1.750 / 4.363 sharp). Below that, nothing in the first-order class can move 0.2452 by more than 3 % (Theorem
M87.3) or, with side-2 base blocks and C̄-priced direct influences, past 0.2739 / 0.2801 (§5.2).
