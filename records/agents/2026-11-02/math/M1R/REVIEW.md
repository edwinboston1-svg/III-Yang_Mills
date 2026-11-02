# M1R — the second reading of M1 (Theorem 8.9's tail, S12, β*), with the certificate re-run (2026-11-02)

**Read in full:** `math/M1/WORK.md` (748 lines) and the records it cites (bisection, scan, control, tolerance, LP, FS records); the S1 page
(III-Yang_Mills `OPEN/ledger/s1-the-flux-surface-gas.md`) §§2–5, 10–11, 14–25, 27, (m)–(n) and every (p) entry from THE NUMBER
RE-QUALIFIED to THE FLOOR IS CONDITIONAL TOO; ΠΕΝΤΑΠΥΛΟΝ 16.58 (Lemma P, W′) and 16.65 (the dressing lemma) for the leaf
decomposition. **Run:** M1's engine copied byte-identical, the record's engine, and a variant of my own (two inert modes added), on the
table of record re-extracted by me. Every number below was read from a record in this directory. Nothing outside this directory was
written.

## 0. Verdicts

| item | verdict |
|---|---|
| T1 (Z₂-closed sets have even size) | **HOLDS** |
| T2 (N(F) ≤ 5^{F−2}) | **HOLDS**; S1 §3's 5^{F−1} is surf.c's tree (branch-free surfaces), the certificate's is Lemma P's odd-rule tree; the forced last step sharpens both by 5 |
| Lemma R (six-fold resolution weight 1/3) | **HOLDS** |
| Lemma M′ (\|S\| ≤ 4·2^{b₁(G)+b₁(G₆)}, every minimal leaf, every multiplicity) | **HOLDS** (at spin ½, multiplicities 2, 4, 6) |
| Lemma E (discrete Gauss–Bonnet) | **HOLDS** ((E1) an identity; (E2), (E3), (E3″) re-derived) |
| Lemma S (prices every spin assignment) | **HOLDS** |
| Lemma E4 (b₁(G) + b₁(G₆) ≤ F/2 + 1 from E ≤ 4V − 4) | **HOLDS** |
| Proposition LP (vertex-local counting stops at 7/12; lattice boundary at 1/2) | **HOLDS** for 7/12 (dual certificate re-derived by hand); the 1/2 is a correct observation (E4's chain is tight on the same LP block), not a separate theorem |
| Corollary U″ | **HOLDS** (constants re-derived; the engine's δ₁, ε₁, K₁, C₁ and its tail term met in floating point at β = 0.3656) |
| M1's correction to S12-c′ (b1) | **HOLDS** (counterexample to the step: the 3 × 3 square minus a corner) |
| Re-run, S12-free (U″, F₀ = 22) | **PASS 0.3650 / FAIL 0.3652 (page); PASS 0.3656 / FAIL 0.3658 (tree)** — M1's numbers to the grid digit |
| Re-run, conditional (T1 + T2, S12 kept, F₀ = 22) | **PASS 0.5100 / FAIL 0.5102 (page); PASS 0.5198 / FAIL 0.5200 (tree)** — to the grid digit |
| κ*(β) at two points | **0.35: 1.6715 PASS / 1.6722 FAIL; 0.4764: 1.1295 PASS / 1.1302 FAIL** — M1's brackets |
| S12-free run carries no S12 stake | **CONFIRMED** (code and run); it leans on the one-road F = 22 census (0.3588 at F₀ = 20, re-run) |

## 1. The ten items, line by line

**T1 — HOLDS.** A finite Z₂-closed X is a Z₂ 2-cycle of the cubical complex of a box B ⊃ X; B is contractible, H₂(B; Z₂) = 0, so
X = ∂C for a set C of unit cubes, and |X| ≡ Σ_{c∈C}|∂c| = 6|C| ≡ 0 (mod 2) because the size of a Z₂-sum has the parity of the sum of
sizes. Second road: the census N(F), N_c(F) vanish at every odd F through 22 (and S1 §10's census: "no even set exists at odd F"
at F = 19). Scope: T1 is about even sets; D1's A-leaves (odd on L_A) have no parity, and nothing in M1 uses T1 for them.

**T2 — HOLDS.** On Lemma P's odd-rule tree (ΠΕΝΤΑΠΥΛΟΝ 16.58 (i), read: a node with an odd link has 6 − m_S(l) ≤ 5 children; (P1) every
Z₂-minimal X ∋ p₀ is reached at depth |X| − 1 by every path inside X), let X = S ∪ {q} be a leaf with parent S. odd(S ∪ {q}) =
odd(S) Δ ∂q = ∅ forces odd(S) = ∂q, and four links (indeed two adjacent ones) fix a plaquette, so a node has at most one even child.
Counting nodes as choice sequences (a set reached by several paths is harmless: choose one), X ↦ its parent is injective, so
N(F) ≤ #(depth F − 2) ≤ 5^{F−2}. S1 §3's 5^{F−1} counts depth F − 1 on the same tree and is correct and weaker. With T1 the tail
ratio to the record's is (1/5)(r/(1+r))σ(F₀+2)/σ(F₀+1) = 0.082 at r = 0.697 — the twelvefold cut, confirmed.

**Lemma R — HOLDS.** At a 2n-fold link ∫U^{⊗2n} = P_Inv; Σ_π|ε_π⟩⟨ε_π| commutes with S_{2n} (the ε-signs cancel in the projector) and
is supported on Inv(V_½^{⊗2n}) ≅ Specht(n, n), irreducible, so it is c_n·P_Inv, c_n = (2n−1)!!·2^n/C_n: c₂ = 6, c₃ = 24. In units of
the two-plaquette link integral ½εε the weight is C_n/(2n−1)!!: **2/3 at four-fold, 1/3 at six-fold.** Trace check: 15 rank-one pair
projectors × 1/3 = 5 = C₃; 3 × 2/3 = 2 = C₂. The sign (−1)^m 2^χ = (−2)^χ (m = 0 with χ even, or m = 2 − χ). The pinch: (2/3)(4 + 4 − 2) = 4 = S6.

**Lemma M′ — HOLDS** (at spin ½; multiplicities 2, 4, 6 — six is the lattice maximum). (i) T ∩ G₆ = F₆, since a six-fold link outside
F₆ closes a cycle in F₆ ⊂ T; so T ∖ F₆ is four-fold and r₄ = N₄ − |T ∖ F₆|. (ii) After resolving the r₄ chords (Creutz, three
pairings at 2/3: each pair an independent link variable), every link off T ∪ G₆ has exactly two plaquettes, each piece integrates to
±2^{χ(P)−|P|}Π_bχ_½(z_b) (Corollary FS; magnitude orientation-free), and the cut-link average of Π_b|χ_½| ≤ 2^{#b} gives 2^{χ(Ŷ_ρ)} ≤ 4^c.
(iii) The boundary map Z₂^{pieces} → Z₁(T ∪ G₆; Z₂) has kernel {∅, X} by minimality, so c ≤ 1 + b₁(T ∪ G₆) ≤ 1 + |G₆ ∖ F₆| =
1 + b₁(G₆). (iv) r₄ + 2b₁(G₆) = N₄ + 2N₆ − |T| − |F₆| = b₁(G) + b₁(G₆) **exactly** (M′ is M's own computation). Sharp on forests (4 = S6).

**Lemma E — HOLDS.** (E1) V_X = F − N₄ − 2N₆ + 2 − b₁(X; Z₂): b₀ = 1 (a minimal set is link-connected), b₂(Z₂) = dim{even subsets}
= 1, |L(X)| = 2F − N₄ − 2N₆ from 2N₂ + 4N₄ + 6N₆ = 4F; equivalently Σ_v(a_v − 4) = 2(N₄ + 2N₆) + 4b₁(X) − 8 (re-derived). (E2) from
a_v ≤ 8; (E3) from c_G ≤ V_G/2 and the vertex split (3/2 ≥ 3a_v/16 ⇔ a_v ≤ 8); (E3″) from V(G₆) ≥ N₆/4, b₁(G₆) ≤ (7/8)N₆. All re-derived.

**Lemma S — HOLDS; it prices every spin assignment.** (a) One spin per piece of X cut along G (orthogonality at 2-links). (b) Haar
invariance under U_ℓ ↦ −U_ℓ on any link set forces the half-integer plaquettes to form an even set, hence ∅ or X: mixed
integer/half-integer assignments vanish; all-half-integer assignments with DIFFERENT half-integers on different pieces survive (m ≥ 2) —
which σ(F) does not price (M1's §4a sharpening of the record's condition is right). (c) All integer: c ≤ 1 + b₁(G),
Σ_j(d_j/2)²(a_j/u)^n ≤ ε₁^n (coefficients ≥ 1), d_j^{χ} ≤ 2^{χ}(d_j/2)² for χ ≤ 2, d_j ≥ 2. (d) All half-integer, raised set A: chords
touched by A are cut (cost 4/2 = 2 each against M′; a piece touches ≤ 4|P| links), untouched chords resolved (all four passages at ½),
each raised piece isolated, δ''(n) ≤ δ₁ because 16a_j/u < 1 (0.044 at β = 0.365, 0.09 at 0.52); m ≤ 1 + b₁(G) pieces. No case missed.

**Lemma E4 — HOLDS.** A finite subgraph of ℤ⁴ with an edge: its lexicographically greatest vertex misses the four +e_i, the least the
four −e_i, so E ≤ 4V − 4 per component and b₁ ≤ (3/4)E. On X's connected 1-skeleton with (E1): F − N + 2 ≥ (2F − N + 4)/4, N ≤
(2F + 4)/3; then b₁(G) + b₁(G₆) ≤ (3/4)(N₄ + 2N₆) ≤ F/2 + 1 and b₁(G) ≤ (3/4)(N₄ + N₆) ≤ F/2 + 1.

**Proposition LP — HOLDS (7/12).** Σ_vK_v = 8 − 4b₁(X) and b₁(G) + b₁(G₆) ≤ Σ_vβ_v re-derived. Dual (y, λ) = (7/12, 7/24) is
feasible iff d/16 + a/12 ≤ 7/6 + ([n₄+n₆ ≥ 1] + [n₆ ≥ 1])/2, i.e. 3d + 4a ≤ 56 + 24([·] + [·]); by cases with a ≤ 8: no contact
d = a (7a ≤ 56), contact d ≤ 2a (10a ≤ 80), six-fold d ≤ 3a ≤ 24 (104 ≤ 104) — equality exactly at spanning 2-regular, spanning
4-regular all-four-fold, and the full star; M1's table run (559 orbits, 0 violations, 25 equality orbits, 2,071 stars) agrees. The LP
value is exactly (7/12)F + 7/3 (the full-star/octagon block: x_full ≤ F/12 + 1/3). **The 1/2:** on the same block E4's chain is tight
(per full star N = 8, |L| = 16 = 4V_X, b₁(G) = b₁(G₆) → 3 each, F = 12), so 1/2 is where vertex stars + Euler + the lattice boundary
stop — an observation, correctly dated by M1 ("the cube is the next constraint, not the first"); neither block is a minimal set.

**Corollary U″ — HOLDS.** Lemma S(d) with M′'s exponent, both exponents ≤ F/2 + 1 by E4: half-integer part
≤ 4u^F(1+δ₁)(2(1+δ₁))^{F/2+1}; integer part ≤ 4u^F·4·(2ε₁)^F. My floating check at β = 0.3656: δ₁ = 64·I₄/I₂ + 144·I₆/I₂ = 0.17743 +
0.00044 = 0.17787, ε₁ = 2.25·I₃/I₂ + 6.25·I₅/I₂ = 0.13734, K₁ = √2.35574 = 1.53484, C₁ = 2.77476; the engine prints 0.17787191,
0.13735367, 1.53484325, 2.774764 (rounded up). Its tail at α = 0.0044 (r_hi = 0.494942, rK₁ = 0.75966):
0.48·C₁(rK₁)^{24}/(1 − (rK₁)²) = 0.0042933 by hand against 0.0042959 printed (σ(24) and outward rounding).

**M1's correction to S12-c′ — HOLDS.** (b1)'s "every link's inner in-plane square is in X, so the whole inner ring is in X" fails at a
reflex corner: region [0,3]² ∖ [2,3]², reflex vertex (2,2); the inner squares of its two C-links, [2,3]×[1,2] and [1,2]×[2,3], meet only
at the vertex, and [1,2]², which would join them, carries no link of C, so no six-fold link forces it. A simple rectilinear polygon has
#convex − #reflex = 4, so "no reflex corner" is exactly "rectangle". M1's wording for revision 32 ("every rectangular cycle whose ring
spokes are 2-links; 1 × n and 2 × 2 unconditionally") is the correct scope. No number moves: U″ uses no S12 class.

## 2. The re-run

Engines and inputs (md5 in `rerun_A1.2026-11-02.txt`): `kp_cert_m1.awk` 3d17b9b8… (byte-identical to M1's final engine);
`kp_cert_rec_from_III.awk` b5145c38… (copied from III `STDLIB/build/aperanton/kp_cert_table_wip.awk`; identical to
`STDLIB/scripts/aperanton_kp_cert.awk` and to M1's `kp_cert_rec.awk`); `diff` record → M1: additive modes only (NCSIG, EVENTAIL,
UNCOND, U712, U12, FMIN1, UNCREC, TKN/TCN), each inert unset. My variant `kp_cert_m1r.awk` = M1's + RECK (the record's tail with a
tail-only K) + VSCAN (a report line per α). The table: R2TAB re-extracted from `local_tail_table.2026-10-31g.txt` (9f2a46a1…),
cmp-identical to M1's `r2tab_g.txt`. gawk 5.4.0 -M, grid 2⁻¹²⁸, AWKPATH = III `STDLIB/scripts` (read only), NC22 = 46,816.

**Controls (C0).** At β = 0.4764, α = 0.0044, F₀ = 20, the record's engine, M1's engine with its modes unset, and my variant with its
modes unset print CHARACTER-IDENTICAL lines in both dressings (page LHS ∈ [0.0043826, 0.0043833], tree [0.0031276, 0.0031281]) — the
record's control.

**The four thresholds and the step above each** (α on the 1e-4 grid in [0.0010, 0.0120]; slack = max_α(α − LHS_hi), from `rerun_A2_margins`):

| number | point | verdict, α window | best α | LHS_hi | slack (relative) |
|---|---|---|---|---|---|
| S12-free, page | 0.3650 | PASS [0.0039, 0.0050] | 0.0044 | 0.0043576 | +4.23e-5 (0.96 %) |
| | 0.3652 | FAIL | 0.0043 | 0.0043412 | −4.13e-5 (0.96 %) |
| S12-free, tree | 0.3656 | PASS [0.0038, 0.0051] | 0.0045 | 0.0044409 | +5.90e-5 (1.31 %) |
| | 0.3658 | FAIL | 0.0044 | 0.0044239 | −2.40e-5 (0.55 %) |
| conditional, page | 0.5100 | PASS [0.0033, 0.0038] | 0.0034 | 0.0033872 | +1.27e-5 (0.37 %) |
| | 0.5102 | FAIL | 0.0034 | 0.0034479 | −4.80e-5 (1.41 %) |
| conditional, tree | 0.5198 | PASS [0.0036, 0.0043] | 0.0039 | 0.0038800 | +1.99e-5 (0.51 %) |
| | 0.5200 | FAIL | 0.0039 | 0.0039396 | −3.97e-5 (1.02 %) |

At the S12-free points the left side is 99 % tail (0.3656 tree, α = 0.0044: enumerated 0.0000452, tail 0.0042959; rK₁ = 0.760), so
the number is Corollary U″'s. Every refusal reads "the inequality's upper end is above alpha" (no dressing failure). NCSIG unset moves
no digit (0.5100/0.5102 re-read). F₀ = 20 (`rerun_E_F20`): U″ page 0.3588 PASS [0.0040, 0.0057] / 0.3590 FAIL; conditional page
0.5050 PASS [0.0035, 0.0043] / 0.5052 FAIL, tree 0.5140 PASS [0.0039, 0.0046] / 0.5142 FAIL — M1's numbers.

**κ*(β)** (`rerun_B_kappa`, page, F₀ = 22): β = 0.35, K = 1.6715 PASS [0.0040, 0.0047], 1.6722 FAIL; β = 0.4764, K = 1.1295 PASS
[0.0034, 0.0044], 1.1302 FAIL — M1's brackets [1.6715, 1.6722) and [1.1295, 1.1302) confirmed.

**The S12-free run carries no S12 stake.** In U12 mode (inside EVENTAIL) the tail is (4/25)σ(F₀+2)[C₁(rK₁)^{F₀+2}/(1 − (rK₁)²) +
C_I(rK_I)^{F₀+2}/(1 − (rK_I)²)] alone; the conditional tail enters only under FMIN1, unset. The enumerated part is S2 (surfaces) and
S6 + σ (contact leaves, NCSIG): proved GIVEN the census's finding that every contact leaf through F = 22 has a forest contact graph
(one road at F = 22). **And it does not lean on the table's unsigned rows** (`rerun_D_sieve`): with k = 15..24 replaced by the signed
Frobenius sieve's per-corner maxima (S1 §24 (b), rounded up), 0.3650 page and 0.3656 tree still PASS and 0.3652/0.3658 still FAIL.
The conditional number does lean on them: with the sieve at k ≥ 15, 0.5100 and 0.5198 FAIL (no dressing root), and the page
bisection reads at least 0.4454 (its only passing α there is the scan's floor 0.0010, so α below it is untested).

## 3. iii-08's road, and T1/T2 isolated (the coordinator's request)

Tree dressing unless marked; q = 1.4142136 (q = 1.414 exactly reads the same on the grid, `rerun_C_C1q`, `_C1t`); records `rerun_C_*`.

| step | change from the line above | tree β* | Δ | page β* | Δ |
|---|---|---|---|---|---|
| C0 | γ = 6, F₀ = 20, record tail, q = 1 (records b/c) | 0.4378 | | 0.4260 | |
| C1 | iii-08's road: q = √2 on every tail leaf | **0.3586** | | 0.3574 | |
| C2 | + T1, T2 (EVENTAIL, K = √2) | 0.3862 | **+0.0276** | 0.3836 | **+0.0262** |
| C3 | + F₀ = 22 | 0.3912 | +0.0050 | 0.3882 | +0.0046 |
| C4 | + the table of record's dressing (tag g) for γ = 6 | 0.4054 | +0.0142 | 0.4038 | +0.0156 |
| U″ | q^F → Corollary U″'s activity | **0.3656** | **−0.0398** | **0.3650** | **−0.0388** |

iii-08's √2 point reproduces on the TREE dressing (here 0.3586 PASS, 0.3588 FAIL; its 0.3585 is off the 2e-4 grid and inside that
bracket), and so does its q = 1.072 rung (`rerun_F_q1072`, tree: β* = 0.4260, refused at 0.4262, against its 0.4259). So the ladder is
the tree's; the stated limit is not: "→ 0.4260 as q → 1" is a flat extrapolation from the q = 1.072 rung, while the tree's own q = 1
reading is 0.4378 (C0, records b/c re-read), where the dressing root dies one step above ("rho ≥ 1"); 0.4260 is the PAGE road's
q = 1 number. **T1/T2 alone is worth +0.026 to +0.028 at fixed everything else.** The
coordinator's reading of the 0.3585 → 0.3650 gap is not the decomposition: T1/T2 + F₀ = 22 give +0.033, the table dressing +0.014, and
U″'s real constants cost −0.040 against q = 2^{1/2}, C = 1, because "q = 2^e under M′" omits Lemma S's spin sum — K₁ = √(2(1+δ₁)) =
1.535, not √2, with δ₁ ≈ 0.178 at β ≈ 0.365 coming from the 16^{|P|} pricing of one-plaquette raised pieces — and the prefactor
C₁ = 2(1+δ₁)² ≈ 2.77. M1's "stops near 0.4265" (rK₁ → 1 under U″, table dressing) and iii-08's 0.4260 (the γ = 6 page dressing's root
dying, C0) are different mechanisms; the agreement is a coincidence. iii-08's Euler bound (S11's base 4) is subsumed by E4 with M′'s base 2.

## 4. Every input that is NOT proved, beyond the neck lemma and the contact-rest dressing M1 names

1. **The tree's cycle-gluing cost on contact-leaf constituents.** κ_T = 4 rests on S3 (exact, any constituents) and S4′, which is proved
   for branch-free closed surfaces only (A1/(n) extend it to non-orientable ones, not to contact leaves). A tail contact leaf can cancel
   (Object A reads 1/2 against 4), so a gluing bound relative to the constituent's weight is the wrong form; it must be relative to its
   activity bound. Same class as M1's (2), unnamed. A road: M′'s rank argument on the Z₂-closed union (kernel of dimension b₂ = number
   of constituents) prices a composite directly, the gluing cycles entering b₁ of the contact graph.
2. **D1 without S12.** D1.1 prices an A-leaf's double by the record's act(X), which is the S12 activity (D1's own status line: it
   "inherits exactly [§14's] conditionality"). U″ is for closed Z₂-minimal sets; A-leaves are odd on L_A and their doubles carry
   multiplicities up to 12 at the doubled L_A-links (beyond Lemma R's n ≤ 3). The convergence and uniqueness clauses of the S12-free
   statement do not need D1; the clustering and gap clauses do. Probably a K_A-level repair (a Lemma M′-type sup bound on g_X with
   T = L(X) ∩ L_A cut costs 4^{|L_A|}), but unwritten.
3. **The dressing on raised and integer-spin rests.** Theorem L's table and the S8/S9 joint bounds are written for a spin-½ sheet; the
   record dresses σ(F)'s raised terms with the spin-½ κ and so does M1 for U″'s raised pieces (the (1+δ₁) factors, which carry 8.5 % of
   K₁ per plaquette) and integer leaves (C_I). Numerically invisible (a raised piece's true weight carries (a_{3/2}/u)^{|P|}), unwritten.
4. **The neck factor is not applied to z_br** in the engine (MIXF multiplies z₁ and z_surf; ZM = max(z_surf·MIXF, z_br)): a branched
   piece whose attachment separates the leaf is in the neck lemma's scope. 2·10⁻¹¹ against margins ≥ 0.37 %; no number moves. (The
   record's (m‴) ADDENDUM and (n) reduce the per-side factor to S4′'s cut identity, orientable or not; what remains owed is the general
   bookkeeping — several separating decorations, branched pieces, contact rests.)
5. **The census at F = 22** (N_c(22) = 46,816 and its forest/multiplicity-4 finding) on one road (g51). At F₀ = 20, which M1 states
   rests on two roads, the S12-free number is 0.3588 (page), re-run here.
6. **A question to the record, outside M1:** polymers with NO even subset — pure integer spin on a support with H₂(supp; Z₂) = 0 and
   every link of multiplicity ≥ 2 (a cubical Bing's house or dunce hat at spin 1) — have no leaf, so they lie outside §14's
   leaf-and-dressing sum as written (16.65 decorates a closed rest U; W′ assumes a rest R). I found no term for them. None occurs in
   g48's census to F = 20 (every set there has a rest), and they are harmless if counted (the closing tree reaches a minimal one in
   n − 1 steps, ≤ 5^{n−1}; the capped spin-1 activity ≤ (9a₁)^n; 5·9a₁ ≈ 0.25 at β = 0.365, 0.48 at 0.51), but they must be entered.
7. **Record-level, for the conditional numbers only:** k = 15..24 of tag g rest on S1 §25 (c)'s realigned bound, census-checked (0 of
   3,464) but absent from §25 (i)'s list of second-seat signatures. I read its chain (‖AB‖_F ≤ ‖A‖_F‖B‖_op; the block Cauchy–Schwarz
   through a block row and column, G⁻¹ = LLᵀ giving the two partial traces; Sylvester/Gershgorin certificates) and it is correct as
   displayed. The conditional 0.5100 needs it (0.4454 without it); the S12-free number does not.

Signed in the record and not re-derived here: Theorem L and the exact table through k = 14, the dressing root (16.65-b), S3, S4′, S11,
Lemma P, D1.2–D1.4, the census counts to F = 20, MIXH's form.

## 5. What may enter the paper, and at what strength

- **Theorems, now:** T1, T2 (the sharpened tail); Lemmas R, M′, E, E4, S and Corollary U″ — a proved all-spin activity bound for every
  Z₂-minimal leaf at every multiplicity (W = 0 on the ingredients: Creutz/Schur–Weyl, the Euler characteristic, the lattice-boundary
  count; the earning is the composition and its effect on the number). Proposition LP's 7/12 (the 1/2 as an observation). The S12-c′
  scope narrowing — already the wording of THE GROUND's Theorem 8.9 statement ("a rectangular cycle whose interior links at its
  straight vertices have multiplicity two"). If M1's Lemma R enters, it needs another name: the paper's proof already calls the
  realigned operator-norm bound "Lemma R, §25".
- **The S12-free threshold, certified and re-run:** Theorem 8.9's KP inequality holds with NO S12 input at β ≤ 0.3650 (page) / 0.3656
  (tree), F₀ = 22 (0.3588 page at F₀ = 20, the census M1 states is two-road) — conditional on the neck lemma, on the record's per-leaf multipliers
  (the dressing AND the tree's cycle gluing) extended to contact leaves and raised rests, and, for the clustering and gap clauses, on
  D1.1 restated without S12. It is S12-FREE, not unconditional: the one unconditional number stays Theorem 8.7's 0.2452.
- **The conditional thresholds:** 0.5100 (page) / 0.5198 (tree) at F₀ = 22 (0.5050 / 0.5140 at F₀ = 20) as conditional readings, under
  S12 in its SPIN-SUMMED form on the open class (M1's sharpening of the record's condition), the same items, the one-road F = 22 census,
  and the realigned bound of §25 (c).

**Relative to THE GROUND's Theorem 8.9 as it stands** (`source/ground/content4.js`, read 11-02; statement, proof paragraph, "what is new"):

1. Its condition clause names "the activity bound 4u^F" on the open class and calls it "the one input of this theorem not yet proved".
   Both halves need changing whatever M1's numbers do: the tail uses S12 in its SPIN-SUMMED form (Σ_spins|W| ≤ 4σ(F)u^F; σ(F) does not
   price the mixed half-integer assignments Lemma S (b) admits on m ≥ 2 leaves), and the same 0.4764 also carries the neck lemma
   ((m′): "remains owed"), the dressing on contact rests (M1 §8 (2)) and the tree's cycle gluing on contact constituents (§4 item 1).
   The proof paragraph's "every pricing lemma read by a second seat" does not cover §25 (c)'s realigned bound, on which 0.4764 leans.
2. With T1/T2 the proof's "N(F) ≤ 5^{F−1}" becomes "N(F) ≤ 5^{F−2}, F even", and the conditional β* may read 0.5100 (page) / 0.5198
   (tree) at F₀ = 22, the F = 22 census named as one road (0.5050 / 0.5140 at F₀ = 20).
3. Its closing sentence ("Without that condition the same conclusions hold for 0 < β ≤ 0.241 … to 0.2452 …; no coupling above 0.2452
   rests on proved lemmas alone") stays true and gains, beside it, the S12-free clause: without S12's remainder the polymer expansion
   converges and the Gibbs measure is unique for β ≤ 0.3650 (page) / 0.3656 (tree), conditional on the neck lemma and on the per-leaf
   multipliers on contact leaves and raised rests; the clustering and gap clauses there need D1.1 restated without S12 (§4 item 2),
   which the statement's K_A clause rests on.

## 6. Files (this directory)

`kp_cert_m1.awk`, `kp_cert_rec_from_III.awk`, `kp_cert_m1r.awk` (variant: RECK, VSCAN), `m1r_lib.sh` (drivers), `job_A1.sh` …
`job_F.sh`; tables `local_tail_table.2026-10-31g.txt`, `r2tab_g_mine.txt`, `r2tab_g_M1.txt`, `r2tab_sieve15.txt`; records
`rerun_A1.2026-11-02.txt` (controls, the eight verdicts, the U″ point lines), `rerun_A2_margins.2026-11-02.txt`,
`rerun_B_kappa.2026-11-02.txt`, `rerun_C_{C0,C1,C1p,C1q,C1t,C2,C2p,C3,C3p,C4,C4p}.2026-11-02.txt`, `rerun_D_sieve.2026-11-02.txt`,
`rerun_E_F20.2026-11-02.txt`, `rerun_F_q1072.2026-11-02.txt`.
