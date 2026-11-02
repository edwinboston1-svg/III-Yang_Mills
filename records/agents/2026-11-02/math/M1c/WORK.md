# M1c — the strong end: the unconditional floor, the unpriced class, the S12-free inputs (proof agent M1c, 2026-11-02)

Work directory: this folder. Read-only in both repositories. Engine of record: III HEAD `STDLIB/scripts/aperanton_kp_cert.awk`
(md5 7aea522cd18cfc1a85912bd459bb5c3c, byte-identical to `STDLIB/build/aperanton/kp_cert_table_wip.awk` since 88e069862; the
TILT/COEF order fixed and the a_1 = 0 refusal added there). M1's engine `kp_cert_m1.awk` (md5 3d17b9b8…) = the record's engine
before 88e069862 plus inert modes (EVENTAIL, NCSIG, UNCOND, U712, U12, FMIN1, UNCREC, TKN/TKD, TCN/TCD); the 88e069862 change
touches only TILT-with-COEF and the a_1 = 0 refusal, neither used by any run below, so M1's engine is the record's engine on every
path these runs take (checked by the control lines below). Table of record tag g (`r2tab_g.txt`, from M1).

Sources read in full for this file: THE GROUND §§7–8 (`cross/ground_docx.txt` paragraphs 236–393, Theorem 8.7 with its proof,
Table 3, the open part, Theorem 8.9 with its proof and its "new / classical" paragraph); the S1 page §§1–25 and (l)–(n), the (p)
entries' headings; ΠΕΝΤΑΠΥΛΟΝ 16.58, 16.58-b, 16.65, 16.65-a, 16.65-b; the certificate (all 214 lines); M1's WORK.md, M1b's WORK.md,
M1R's REVIEW.md; g48_polymers.c and its records to F = 22.

---------------------------------------------------------------------------------------------------------------
## 1. THE UNCONDITIONAL FLOOR: THEOREM 8.7 DOES NOT TOUCH THE GAS

**Answer, at full strength.** Theorem 8.7 (β ≤ 0.241 on proved constants, 0.2452 on the certified exact constants) is independent of
the flux-surface gas: no polymer, no character expansion beyond the one-link von Mises–Fisher law, no closing tree, no
Kotecký–Preiss sum and no classification of polymers occurs anywhere in its proof. M1R's sentence "0.2452 stays the unconditional
number" is right, and M1R's question about leafless integer-spin polymers (§2 below) cannot reach it.

**The line that settles it** (THE GROUND, proof of Theorem 8.7, its second and third sentences, verbatim): "Each plaquette contains
exactly one link of L₁, so the Wilson weight is the product over a in L₁ of exp⟨Ua, η(a)⟩, with η(a) = β Σp∋a Sp(a) and |η(a)| ≤ 6β.
Given the links of L₀, the links of L₁ are therefore independent, Ua distributed by νw at w = η(a), and the marginal law of the links
of L₀ has density proportional to ∏a∈L₁ Z(|η(a)|) with respect to the product of the Haar measures: a Gibbs measure with a potential
of finite range." From there on the proof is Dobrushin's uniqueness theorem for that finite-range specification on L₀: the
conditional law of one L₀-link is a tilt of a von Mises–Fisher law (Taylor along the segment, Lemma 8.6 (i)–(iii)), its total-variation
sensitivity to each of the 102 influencing L₀-links is bounded by the two tilt facts and the one-link mean-absolute-deviation 4/(3π)
(§8.1), the row sum α(β) = 12 C_dir + 90 C_med of (8.12) is < 1, and "By Dobrushin's uniqueness theorem the Gibbs measure of the links
of L₀ is unique"; clustering by "the argument of the proof of Theorem 8.5, applied on one lattice with the links of L₀ as the coarse
variables" (Hypothesis I with zero distance > 2, Hypothesis II with exact conditional independence of L₁), the gap by Theorem 7.1.
Every input is one of: Lemma 8.6 (Bessel ratios: Turán's inequality, the Riccati identity), the perfect cover (a finite check),
the tilt lemmas (8.6)–(8.7), the one-link lemma of §8.1, Dobrushin's theorem, Theorem 8.5's argument, Theorem 7.1. None of them
mentions a plaquette set, a spin assignment on a polymer, or the even/odd structure the gas is organised by. The only "expansion" is
the exact integration of the cover links, which is a change of variables of one link at a time, not a sum over polymers.

So the polymer classification (leaves, contact leaves, rests, decorations, the leafless class of §2) can be wrong, incomplete or
unpriced without moving 0.2452 by a digit. What 0.2452 does rest on beyond the displayed proof is the certified evaluation of α(β)
with the two exact constants (THE GROUND, after Table 3: "|D(5β)| for m(5β)²/3 and |φ‴(6β)| for m(6β)/2 ... each enclosed with
certified error in a run of record"). Two premises of that replacement are checked in §1a below (the proof needs |D| to be maximal at
the top of its range, and the third cumulant along every direction to be at most |φ‴| there).

[§1a to be appended with the checks: the perfect cover's 96 plaquettes; |D(r)| increasing on [0, 5·0.2452]; max over directions of
the third cumulant equal to |φ‴(r)| on [0, 6·0.2452].]

---------------------------------------------------------------------------------------------------------------
## 2. THE UNPRICED CLASS — the leafless polymers (written before the census below has run at F ≥ 16)

### 2.0 Definition, in the gas's own language

A POLYMER is a finite link-connected plaquette set X with every link of X in at least two plaquettes of X (S1 §2, Lemma S1), with
weight W(X) = ∫ Π_{p∈X} f(U_p) dU, f = Σ_{j≥½} d_j a_j χ_j (S1 §2); equivalently a pair (X, spin assignment) with W(X) the sum.
Write f = f_odd + f_even, f_even := Σ_{j∈ℕ, j≥1} d_j a_j χ_j = (f(U) + f(−U))/2 = cosh(½β tr U)/c₀ − 1, f_odd the half-integer part.

**Definition (the leafless class Ω).** X ∈ Ω iff X is a polymer that contains NO nonempty Z₂-even subset (no nonempty E ⊆ X with
every link of even multiplicity in E) — equivalently the Z₂ boundary vectors ∂p ∈ Z₂^{L(X)}, p ∈ X, are linearly independent,
i.e. H₂(X; Z₂) = 0 for X as a cubical 2-complex.

**Lemma Ω1 (what Ω carries).** (i) For X ∈ Ω every admissible spin assignment is all-integer, and W(X) = ∫ Π_{p∈X} f_even(U_p) dU.
(ii) Every X ∈ Ω has an odd link (X itself is a nonempty subset), at least two of them.
(iii) A union of two Ω members whose shared links form a forest is in Ω; so Ω is closed under the record's forest gluing.
(iv) The smallest member of Ω, if Ω ≠ ∅, is irreducible (no split into two closed parts sharing a forest).
*Proof.* (i) Expand Π_p (f_even + f_odd)(U_p) = Σ_{H⊆X} Π_{p∈H} f_odd Π_{p∉H} f_even. If some link ℓ has odd multiplicity in H,
the substitution U_ℓ ↦ −U_ℓ (Haar-invariant) multiplies the H-term by (−1)^{m_H(ℓ)} = −1 (f_odd(−V) = −f_odd(V), f_even(−V) =
f_even(V)), so the term vanishes; the surviving H are even, hence H = ∅ for X ∈ Ω. (ii) Σ_ℓ m_X(ℓ) = 4|X| is even, so the odd
links come in an even number, and X is not even. (iii) If E ⊆ X₁ ∪ X₂ is even, then E ∩ X₁ has even multiplicity at every link
off the shared forest Φ, so its Z₂ boundary is a 1-cycle supported on Φ, hence zero; E ∩ X₁ is even, so E ∩ X₁ = ∅; likewise
E ∩ X₂ = ∅. (iv) If the smallest member X splits as X₁ ⊔ X₂ closed with forest-shared links, the link-components of X₁ are
polymers with no even subset, smaller than X. ∎

So Ω is "integer-spin or mixed integer-spin (1, 2, …) polymers with no even subset"; a polymer with any half-integer plaquette has
the even subset H (its half-integer plaquettes) and is not in Ω — "mixed half/integer polymers with no even subset" do not exist.

### 2.1 Does any term of the certificate cover Ω? — NO (term by term)

The certificate's left side (engine lines 127–140) is 3·[Σ_{F≤F₀} (N(F)·4σ(F) + 4N_c(F)) ũ^F e^{2α̃F} + (4/5)σ(F₀+1)r^{F₀+1}/(1−r)],
ũ = u e^{κ_U}, α̃ = κ_T α. Every term is indexed by a LEAF:
- N(F), N_c(F) (the enumerated leaves) count Z₂-minimal sets through p₀ (§14: "LEAVES ... surfaces ... contact leaves (Z₂-minimal)").
  A leaf is EVEN. An Ω member contains no even subset, so it is not a leaf and contains none.
- σ(F) prices a leaf at one higher spin (S2): again an even set.
- The crude tail counts the leaves of Lemma P's odd-rule tree T_odd at depth F − 1 (N(F) ≤ 5^{F−1}): a leaf of T_odd is a node with
  no odd link, i.e. an even set; an Ω member is never such a node, and the odd rule run inside an Ω member stalls (at a node whose
  smallest odd link is an odd link of X itself with all of X's plaquettes there already in the node), so it is not even reached.
- The dressing (z₁ walls, z_surf / z_br pieces, the table rows of Theorem L, the root κ_U) is the sum over DECORATIONS Δ of a leaf U
  (16.65: "U is a closed set of plaquettes (the rest...)"; in the fold-in U is the leaf). A stand-alone Ω polymer is its own link-
  connected component of the gas: it shares no link with any leaf, so it is no decoration of any leaf.
- The composite tree (κ_T = 4) glues IRREDUCIBLE PIECES, each a leaf with its dressing (§4b, §14 item 3). An Ω polymer has no leaf.
So a stand-alone Ω polymer has no term. What IS covered: an Ω sub-complex inside a polymer that also has half-integer plaquettes —
there the Ω part is part of the integer decoration Δ of the half-integer rest H, counted by the dressing lemma (whose rest need only
be closed, and whose decorations include closed sub-complexes attached anywhere: 16.65's admissibility is "every link of U ∪ Δ outside
U has multiplicity ≠ 1 in Δ") and weighed, at spin 1, by Theorem L, which bounds "any set of spin-1 plaquettes Y attached to a sheet",
interior vertices included (r_v² = S(Γ_v) off the sheet; the local family includes the m = 0 rows, `local_enum.c`: "a free vertex of
degree >= 2 is rest or off-sheet ... (m = 0: ratio: r2 = S)").

**M1R's question answered: the stand-alone leafless polymers are an UNCOVERED class of Theorem 8.9's KP sum.** They must be priced.

### 2.2 STAKES for the census of Ω (written before `omega_census.exe` has run in census mode)

`omega_census.c` = g48_polymers.c's canonical construction verbatim + the prune "a partial set with dependent boundary vectors has an
even subset, and so does every set built on it"; a closed node with independent vectors is an Ω member. Control (MODE 1, prune off)
already run to F = 14: closed sets 4, 60, 66, 320, 1316 at F = 6, 10, 11, 12, 14 — g48's totals (branch-free + branched) to the unit,
and 0 disagreements between the incremental basis and a from-scratch rank at every closed node.
- (Ω-a) MODE 1 to F = 18 reproduces g48's totals 12552 (16), 12580 (17), 63216 (18).
- (Ω-b) MODE 0: no Ω member at F ≤ 20 (the second road on g48's census, which shows no odd irreducible set without a rest at
  F ≤ 20, `g48_polymers_d4_f20_v5/v7`: zero lines "least integer-spin plaquettes -1").
- (Ω-c) UNGUESSED: whether Ω has members at F = 21, 22. g48 at F = 22 (`g48_polymers_d4_f22.2026-10-29b`) prints four odd
  irreducible profiles with no rest of complement ≤ 6 — (m2, m3) = (30, 8), (9, 22), (12, 20) at F = 21 (2016, 112, 1120 sets) and
  (8, 24) at F = 22 (352) — which are either Ω members or sets whose rests have complements > 6 (my reading of (9,22), (12,20),
  (8,24): the tesseract's 2-skeleton minus three resp. two squares, which keeps closed cube boundaries — NOT Ω). Stake: at least the
  (8,24), (12,20), (9,22) families are not in Ω.

### 2.3 RESULTS of the census (records `ctl_mode1_F18.txt`, `census_mode0_F20.txt`; `omega_census.c` compiled -O2)

(Ω-a) HELD: MODE 1 (prune off) to F = 18 reads closed sets 4, 60, 66, 320, 1316, 2520, 12552, 12580, 63216 at F = 6, 10, 11, 12, 14,
15, 16, 17, 18 — g48's totals (branch-free + branched) to the unit at every size, with the odd column 66, 224, 2520, 1568, 12580,
10788 equal to g48's odd counts (reducible + irreducible); 2.6·10⁸ nodes, 32 s; the incremental basis against a from-scratch rank at
every closed node: 0 disagreements.
(Ω-b) HELD: MODE 0 (the prune on) to F = 20: NO closed node at all — Ω has no member with F ≤ 20, on a second road sharing no line
of classification with g48's (g48: odd irreducible sets with a rest of complement ≤ 6; here: rank of the boundary vectors, the
prune and the from-scratch check); 2.12·10⁹ nodes, 2.69·10⁶ pruned, 274 s. With Lemma Ω1 (iv), the smallest member of Ω has at
least 21 plaquettes: n_Ω ≥ 21. F = 21 running (`census_mode0_F21.txt`).

### 2.4 The activity of a leafless polymer — Finner's inequality (all integer spins at once)

**Lemma Ω2 (generalized Hölder, Finner 1992; W = 0, proof given).** Let (Ω_i, μ_i) be probability spaces, i ∈ I finite, and for
q ∈ Q let h_q ≥ 0 be a measurable function of the coordinates in S_q ⊆ I, with exponents p_q ∈ [1, ∞] such that
Σ_{q : i ∈ S_q} 1/p_q ≤ 1 for every i. Then ∫ Π_q h_q dμ ≤ Π_q ‖h_q‖_{L^{p_q}(Π_{i∈S_q} μ_i)}.
*Proof.* Induction on |I|. Integrate one coordinate i first: the factors not containing i come out; for those containing i, Hölder
on (Ω_i, μ_i) with exponents p_q (Σ 1/p_q ≤ 1 on a probability space: pad with the constant 1) gives ∫ Π_{q∋i} h_q dμ_i ≤
Π_{q∋i} g_q, g_q := (∫ h_q^{p_q} dμ_i)^{1/p_q}, a function of S_q ∖ {i} with ‖g_q‖_{p_q} = ‖h_q‖_{p_q} by Fubini. The new family
satisfies the hypothesis on I ∖ {i}. ∎

**Corollary Ω2.** For every X ∈ Ω: |W(X)| ≤ ‖f_even‖_6^{|X|}, where ‖g‖_p := (∫_{SU(2)} |g(U)|^p dU)^{1/p}.
*Proof.* By Lemma Ω1 (i), W(X) = ∫ Π_{q∈X} f_even(U_q) Π_ℓ dU_ℓ. Take the link variables as the coordinates (Haar probability),
h_q(U_{ℓ₁}, …, U_{ℓ₄}) := |f_even(U_{ℓ₁}U_{ℓ₂}U_{ℓ₃}⁻¹U_{ℓ₄}⁻¹)| and p_q := 6. Every link lies in m_ℓ ≤ 6 plaquettes of ℤ⁴, so
Σ_{q∋ℓ} 1/6 ≤ 1. And ‖h_q‖_{L⁶(SU(2)⁴)} = ‖f_even‖_6 because the plaquette product is Haar-distributed (left invariance in U_{ℓ₁}). ∎
(It holds for EVERY polymer's all-integer part ∫ Π f_even, Ω or not; for Ω that part is the whole weight. It discards every
cancellation, so it is crude on surfaces — at spin 1 a closed surface weighs a₁^F 3^χ against this bound's ≈ (4.73a₁)^F — and it is
used only where no leaf exists to carry an exact weight.)

**The numbers (`feven_norm.awk`, exact rationals on the grid 2⁻⁵¹², every Φ(t) = 2I₁(t)/t an enclosed series, the alternating cosh
expansion by sign; KAT: E[f_even²] against Σ_{j∈ℕ} d_j²a_j² and E[f_odd²] against Σ_{j half} d_j²a_j² from the Bessel ratios' own
series — met to 16 digits at all six points).** ‖f_even‖_6 ≤ 0.0260085 (β = 0.3650), 0.0260936 (0.3656), 0.0441373 (0.4764),
0.0450969 (0.4816), 0.0505145 (0.5100), 0.0524530 (0.5198) — i.e. ≤ 4.724–4.738·a₁, against the spin-1 leading value
3·15^{1/6}·a₁ = 4.7113·a₁ (E[χ₁⁶] = mult of the trivial in 1^{⊗6} = 15).

### 2.5 The count of leafless polymers — the first closed set and the dressing lemma as a pure count

**Lemma Ω3.** Let w > 0 and let κ_Ω := 2w + κ′ with κ′ the least root of κ′ = 8 Σ_{s≥2} 5^{s−1} w^s e^{2ws} e^{P(s)κ′/8},
P(s) = 4 min(2s, s(s−1)/2) (16.65-b's recursion with z₁ = w, z_surf(s) = z_br(s) = w^s). If ρ_Ω := 5 w e^{κ_Ω} < 1, then
  Σ_{X ∈ Ω, X ∋ p₀} w^{|X|} ≤ Σ_{n ≥ n_Ω} 5^{n−1} (w e^{κ_Ω})^n = ρ_Ω^{n_Ω} / (5(1 − ρ_Ω)).
*Proof.* Given X ∈ Ω through p₀, run the closing construction inside X from {p₀}: while the current set has a link of multiplicity
one, add the smallest plaquette of X containing the smallest such link (it exists: m_X(ℓ) ≥ 2). The construction stays in X and
stops at the first closed set S₁ ⊆ X; S₁ is link-connected (each step adds a plaquette at an existing link), closed, and has no
even subset (S₁ ⊆ X), so S₁ ∈ Ω and |S₁| ≥ n_Ω. The sets reachable this way are nodes of a tree branching at most five ways per
step (the plaquettes at a link other than the one already present), so there are at most 5^{n−1} possible S₁ of size n. The rest
Δ := X ∖ S₁ is a DECORATION of the closed set S₁ in the sense of 16.65: disjoint from S₁, and every link of S₁ ∪ Δ outside S₁ has
multiplicity m_Δ = m_X ≠ 1. X ↦ (S₁, Δ) is injective. The dressing lemma in its repaired form (16.65-b, signed by iii-73: canonical
sequential decomposition, first ownership, P(s) sites per piece, the walls paid once on the closed set U ∪ Δ′ by (W3), roots 8|U| by
(W2) — every step uses only that U is CLOSED, never that it is even: (W2) Σ_{ℓ∈U}(6 − m_U(ℓ)) = 6|L(U)| − 4|U| ≤ 8|U| since
|L(U)| ≤ 2|U| for a closed U, and (W3) counts walls of a closed set) gives Σ_{Δ} w^{|Δ|} ≤ e^{κ_Ω |S₁|} for every closed S₁. So
Σ_X w^{|X|} ≤ Σ_{n≥n_Ω} 5^{n−1} w^n e^{κ_Ω n}. ∎

**Corollary Ω4 (the term the certificate owes).** With w := ‖f_even‖_6·e^{2α̃} (a closed X has |L(X)| ≤ 2|X|), the leafless
polymers through a link contribute to the Kotecký–Preiss sum at most
  T_Ω := 3 · ρ_Ω^{n_Ω} / (5(1 − ρ_Ω)),   n_Ω = 21 (§2.3),
the 3 the link-to-plaquette factor of §14 (every polymer has at least two plaquettes at each of its links). Entered inside the
bracket evaluated at α̃ = κ_T α, the composite tree carries Ω members glued to leafed pieces along forests exactly (S3) — an
over-count, never an under-count; an Ω member glued to a half-integer piece along anything else is part of that piece's integer
decoration, which the dressing already counts.

### 2.6 STAKES for the reruns with the class included (written before `kp_cert_m1c.awk` has run one line in OMEGA mode)

`kp_cert_m1c.awk` = M1's engine (md5 3d17b9b8…, byte-identical copy) + ONE mode, OMEGA (NOM default 21): ‖f_even‖_6 recomputed inside
the engine on its 2⁻¹²⁸ grid by the same cosh expansion (upper end of E[f_even⁶], its sixth root rounded up), w = ‖f_even‖_6·e^{2α̃}
rounded up, κ_Ω by the tree recursion's upper bracket (the s-sum to S = 40 with its geometric tail, ρ' = 5we^{2w}e^{κ′}), T_Ω added to
the upper end of the left side. Inert unset.
- (Ω-d) OMEGA unset: character-identical to `kp_cert_m1.awk` at (0.4764, α = 0.0044, F₀ = 20) both dressings, and at the U″ point
  (0.3650, page, α = 0.0044, F₀ = 22, EVENTAIL UNCOND U12 NCSIG).
- (Ω-e) The engine's E[f_even⁶] upper end agrees with `feven_norm.awk`'s 512-bit enclosure to 30 digits at 0.4764.
- (Ω-f) OMEGA = 1, NOM = 21: T_Ω < 10⁻⁸ at every point, and EVERY verdict unchanged: U″ page 0.3650 PASS / 0.3652 FAIL, tree 0.3656 PASS /
  0.3658 FAIL; the record's table mode (F₀ = 20) page 0.4764 PASS / 0.4766 FAIL, tree 0.4816 PASS / 0.4818 FAIL; the conditional
  sharpened (EVENTAIL, F₀ = 22) page 0.5100 PASS / 0.5102 FAIL, tree 0.5198 PASS / 0.5200 FAIL.
- (Ω-g) THE PRICE OF n_Ω (UNGUESSED; a reading, not a theorem): at 0.5100 page, the least NOM at which the Ω term alone would refuse
  the verdict.

### 1a. The checks on Theorem 8.7's own inputs (records: `cover_check.awk`, `vmf_check.awk`; run 2026-11-02)

(i) THE PERFECT COVER (finite check): the four rules partition the 16 residues (0 residues covered other than once); every plaquette
contains exactly one cover link on the torus of side 2 (96 of 96) and of side 4 (1536 of 1536). The planted wrong rule (direction 1
when x₂ = x₃ alone) is caught: 64 of 96, 1024 of 1536.
(ii) THE TWO PREMISES OF THE EXACT CONSTANTS. With a := 3|D|/r and b := 2mφ″ (so φ‴ = a − b by differentiating (8.9)):
  d|D|/dr = 2mφ″ − 4|D|/r = b − (4/3)a, so |D| is increasing wherever 3b ≥ 4a;
  the third cumulant at angle c is k₃(c) = (2a − b)c³ − ac; if 3b ≥ 5a then k₃′(c) ≤ 5a − 3b ≤ 0 on [0, 1] (or 2a ≤ b), so
  max_c |k₃| = |k₃(1)| = b − a = |φ‴(r)|.
  Read on the grid h = 5·10⁻⁴ at 256-bit MPFR (a reading, not a certificate; the margins are what a certificate needs):
  min 3b/(4a) over (0, 5·0.2452] = 1.4156 (at the top end); min 3b/(5a) over (0, 6·0.2452] = 1.1071 (at the top end); |φ‴| = b − a
  increasing on the whole grid (least step 4.5·10⁻⁶ > 0). So sup_{|w| ≤ 5β}|D| = |D(5β)| = 0.0262086 (against m(5β)²/3 = 0.0278295)
  and the largest third cumulant at radius ≤ 6β is |φ‴(6β)| = 0.0604812 (against m(6β)/2 = 0.1692762) at β = 0.2452 — both
  replacements THE GROUND makes are of the right form. The functions are power series in r² with these margins (10.7 % the least),
  so an interval certificate on the same grid with a Lipschitz bound closes them; the record says its run of record encloses them.

Nothing here depends on the gas. §1's answer stands: Theorem 8.7 is the unconditional number, 0.2452, independent of every polymer
statement of S1.

---------------------------------------------------------------------------------------------------------------
## 3. THE S12-FREE THRESHOLD'S UNPROVED INPUTS

### 3e. S1 §25 (c), THE REALIGNED OPERATOR-NORM BOUND — read line by line: SIGNED (M1c, 2026-11-02)

The object. S(G) is the closed tensor network with one node per link l of the vertex star (the Haar projector P_l onto the
invariants of ⊗_{q∋l} V_{j_q}, as a tensor with a ket leg k_q and a bra leg b_q per plaquette q ∋ l) and two strands per edge q = (l, l′)
of G: k_q(l)–k_q(l′) (the corner δ of W_v) and b_q(l)–b_q(l′) (its copy in W_v*). This is exactly Theorem V's ‖A_v‖²_F = S(G_v)
(S1 §23), so every strand joins two DIFFERENT nodes (G simple: no self-loop).

Line 1 (the chain). Order the nodes 1..n; C_t := the contraction of P_1..P_t over the strands internal to {1..t}, a tensor whose legs
are the strands from {1..t} to {t+1..n}. C_t = (M_t ⊗ I)(C_{t−1}) with M_t := P_t reshaped from its legs on strands to {1..t−1} to
its legs on strands to {t+1..n}, the identity on the strands from {1..t−1} that pass t by. Since ‖(M ⊗ I)x‖ ≤ ‖M‖_op‖x‖ and the
contraction pairing is a fixed signed permutation of real coordinates (the metric diag(1, −1, 1) in the basis (e_x, ie_y, e_z) has
operator norm 1), ‖C_t‖_F ≤ ‖M_t‖_op ‖C_{t−1}‖_F. A node with no strand to the earlier (later) nodes has M_t a column (row), whose
operator norm is its Frobenius norm √R_t — consistent. ‖C_1‖_F = ‖P_1‖_F = √(tr P_1²) = √(tr P_1) = √R_1. The last step is
S = ⟨C_{n−1}, P_n⟩ over all of P_n's legs: |S| ≤ ‖C_{n−1}‖_F ‖P_n‖_F (Cauchy–Schwarz). Hence |S| ≤ √R_1 Π_{t=2}^{n−1}‖M_t‖_op √R_n.
CORRECT. (The Frobenius sieve is the case ‖M_t‖_op ≤ ‖M_t‖_F = √R_t: correct.)

Line 2 (the block Cauchy–Schwarz). With τ_a a basis of Inv (an independent set; the trace control tr P = R at every key is the
check that it is a basis and G⁻¹ its inverse Gram), P_t = Σ_{ab}(G⁻¹)_{ab}|τ_a⟩⟨τ_b|. Split the ket space K = K_N ⊗ K_S (legs toward
earlier / later nodes) and the bra space likewise; with T_a : K_N → K_S the unfolding of τ_a and T̄_b that of conj(τ_b), the
realigned operator is M_t = Σ_{ab}(G⁻¹)_{ab} T_a ⊗ T̄_b : K_N ⊗ K̄_N → K_S ⊗ K̄_S. G⁻¹ is Hermitian positive definite, G⁻¹ = LL*, so
M_t = Σ_c A_c ⊗ B_c with A_c := Σ_a L_{ac}T_a and B_c := Σ_b \bar L_{bc}T̄_b = conj(A_c). Writing Σ_c A_c ⊗ B_c = R·C with the row
R = [A_1 ⊗ I, A_2 ⊗ I, …] and the column C = [I ⊗ B_1; I ⊗ B_2; …]: ‖M_t‖_op² ≤ ‖RR*‖‖C*C‖ = ‖Σ_c A_cA_c*‖ ‖Σ_c B_c*B_c‖.
And Σ_c A_cA_c* = Σ_{ab}(G⁻¹)_{ab}T_aT_b* = Tr_{K_N} P_t (the partial trace of |τ_a⟩⟨τ_b| over K_N is T_aT_b*), while
Σ_c B_c*B_c = (Σ_c A_c*A_c)ᵀ = (Tr_{K_S} P_t)ᵀ (the partial trace over K_S is (T_b*T_a)ᵀ summed with (G⁻¹)_{ab}). λ_max is transpose-
invariant. So ‖M_t‖²_op ≤ λ_max(Tr_N P_t)·λ_max(Tr_S P_t), both PSD of trace R_t. CORRECT.

Line 3 (exactness). Integer τ's, the exact inverse of an integer Gram, exact rational partial traces; λ_max(A) < μ certified by an
exact LDLᵀ of μI − A with every pivot positive (Sylvester ⇒ μI − A positive definite) or by a Gershgorin row sum — both valid upper
bounds. The bound carried squared, bound2 = 4^{m−2} R_1 R_n Π_t μ_{A,t}μ_{B,t} ≥ (2^{m−2}S)² = r2². CORRECT. Any contraction order is
valid (the floating prototype only chooses one).

A KNOWN ANSWER BY HAND (the record's first KAT, re-derived here): K₄ at spin 1, every P_l = |ε⟩⟨ε|/6 (R = 1). Order 1..4. Node 2
(one edge back, two forward): Tr over the backward ket leg gives Σ_n ε_{nss′}ε_{ntt′}/6 = (δ_{st}δ_{s′t′} − δ_{st′}δ_{s′t})/6,
eigenvalues 1/3 (antisymmetric, dimension 3) and 0, so λ_max = 1/3; over the two forward legs Σ_{ss′}ε_{nss′}ε_{n′ss′}/6 = δ_{nn′}/3,
λ_max = 1/3: ‖M_2‖² ≤ 1/9; node 3 the mirror image, ‖M_3‖² ≤ 1/9; so |S(K₄)| ≤ 1·(1/3)(1/3)·1 = 1/9 against the exact 1/36 —
the record's `REALIGN KAT` line "K₄ at spin 1 bound 1/9 against the exact 1/36 and the sieve's 1", met.
VERDICT: §25 (c) is SIGNED as displayed (M1c), the second-seat signature M1R noted absent. With it 0.5100 / 0.5198 (and the record's
0.4764 / 0.4816) stand on a signed realigned bound for their k = 15..24 rows; the census (0 of 3,464 above their bounds) is the
instrument's check, not the proof.

### 3a-stake. THE NECK'S PRICE (written before `job_neck.sh` runs; a margin reading, not a bound on the gas)

`kp_cert_m1c_neck.awk` (= kp_cert_m1c.awk md5 28d14fb6…, frozen) multiplies the walls' activity z₁ by (1 + ε) (mode w), or z₁ AND every
piece activity z(s) by (1 + ε)^s (mode a: every decoration plaquette). Bisection on ε to 10⁻⁴ at three numbers of record.
STAKE: ε* (mode w) ∈ [0.001, 0.02] at each of 0.3650 (U″ page, F₀ = 22), 0.5100 (conditional page, F₀ = 22), 0.4764 (record, page,
F₀ = 20) — the left side is tail-dominated with exponent ≈ 21–24 in ũ = u e^{κ_U} and κ_U carries 2z₁ ≈ 0.04–0.06, so a 1 %
change in z₁ moves the left side by about 1 % against margins of 0.4–1 %; ε* (mode a) a little below ε* (mode w).

### 3a. THE NECK LEMMA — the record's premise is false; the one-piece case exact; the multi-decoration case's object named

THE RECORD'S STATEMENT. S1 (m)/(m′): a decoration whose attachment cycle separates the leaf admits the two sides at different half-
integer spins; the certificate multiplies z₁ and z_surf by 1 + MIXH, MIXH = 4Σ_{j≥3/2}((2j+1)a_j/(2a_½))⁵ (2.9·10⁻¹⁰ at 0.4764), on the
premise "the least disc is the five-plaquette cup" ((m′)(1), proved for ONE lone wall: its cycle ∂p′ bounds a leaf disc ≠ {p′}, so ≥ 5).

**FINDING N0 (the premise fails for every decoration other than a single lone wall).** Call a DOMAIN a component of the leaf S under
adjacency through links of S not touched by the decoration (T := L(S) ∩ L(Δ)); every domain carries one half-integer spin (orthogonality
at untouched 2-links), and at a link of T the two leaf plaquettes may sit in different domains with different spins (j ⊗ j′ ⊗ k ∋ 0).
(i) A SINGLE SURFACE PIECE makes a ONE-PLAQUETTE domain: the cup Y (the five other faces of the unit cube on a leaf plaquette q, outside
S) is an S9 disc piece of five plaquettes attached along ∂q, and {q} is a domain. (ii) FOUR LONE WALLS make one: a lone wall w ≠ q shares at
most one link with q (two plaquettes share at most one link), so four walls on the four edges of q isolate it — realised by the boundary
of the planar plus-pentacube (five unit cubes, a centre and its four planar neighbours) with its four internal faces as lone walls: their
cycles cut the sphere into the centre's top {q}, its bottom {q′} and four five-plaquette arms. So domains of size 1 occur, and the mixed
factor of a one-plaquette domain is of order a_{3/2}/u, not (a_{3/2}/u)⁵.

**LEMMA N1 (one disc piece on one separating cycle — exact).** Let S be a closed branch-free orientable sphere at spin ½ (F plaquettes),
Y a disc piece of s plaquettes (S9's class) attached along one cycle C ⊂ S, and D, D′ the two discs of S ∖ C (n + n′ = F). Over all
admissible assignments (D at j, D′ at j′, Y at an integer k; uniform within each by orthogonality),
  W(S ∪ Y; j, j′, k) = a_j^{n} a_{j′}^{n′} a_k^{s} · d_j d_{j′} d_k · N(j, j′, k),   N = dim Inv(j ⊗ j′ ⊗ k) ∈ {0, 1},
so, against the uniform value W(S)·3a₁^s = 4u^F·3a₁^s,
  W(j, j′, k)/(W(S)·3a₁^s) = (a_j/u)^n (a_{j′}/u)^{n′} (d_j d_{j′}/4) (d_k a_k^s/(3a₁^s)) N(j, j′, k).
*Proof.* Fix the links of C; integrate each disc's interior links: the piece formula (S1 (n), Corollary FS; magnitude orientation-free)
gives (d_j a_j)^n d_j^{1−n} χ_j(z) for D, (d_{j′}a_{j′})^{n′}d_{j′}^{1−n′}χ_{j′}(z) for D′, (d_k a_k)^s d_k^{1−s} χ_k(z) for Y, z the
holonomy of C (each a disc, χ = 1); the integral over C's links is the Haar integral in z, ∫χ_jχ_{j′}χ_k = N. ∎
At D = {q} (n = 1, the cup, s = 5) the mixed assignment (3/2, ½, 1) reads 2a_{3/2}/u = 9.4·10⁻³ at β = 0.4764 against MIXH's 2.9·10⁻¹⁰:
a factor 3·10⁷. (S1 (m″)'s exact cup amplitude measures the raised CUP — five plaquettes — under a wall across its mouth; Lemma N1's
one-plaquette domain is the other side of a different decoration.)

**COROLLARY N2 (the surface pieces' mixed assignments are covered by z_br in every mode of record).** By Lemma N1, a disc piece's total
over its leaf-side assignments is z_surf(s)·(1 + ν), ν ≤ Σ_{j≥3/2} 2(d_j/2)(a_j/u)(1 + (5/3)(a₂/a₁)^s) + (the far side) ≤ 0.02 at
β ≤ 0.52; the dressing prices a piece of size s at ZM[s] = max(z_surf(s)(1 + MIXH), z_br(s)) with z_br(s) = (γ(s)a₁e^{2α̃})^s and
γ(s) ≥ 3, so z_br(s)/z_surf(s) ≥ 3^s/3 ≥ 3 at s ≥ 2 (about 412 at s = 5 on the table): the mixed surface-piece terms sit under ZM[s]
with room. For annulus and higher pieces the same formula carries one factor (a_j/u)^{n_i}(d_j/2)^{χ_i} per raised domain, each ≤ 0.01:
covered alike.

**WHAT IS OPEN — the multi-decoration domains, and the object that closes them.** For lone walls (priced at z₁ ≈ 3a₁, with no room under
a max), a domain of size n ≤ 4 needs its whole boundary in T, i.e. at least four walls for n = 1 (N0 (ii)) — FOURTH ORDER in z₁ — and its
weight carries (a_j/u)^n(d_j/2)^{χ} times the vertex contractions at the domain's boundary vertices, where the vertex cycle passes from a
½-strand to a 3/2-strand through a wall's spin-1 insertion. S8's |c(D_v)| ≤ 1 is proved for one spin on the vertex cycle (|tr| of a
product of 2 × 2 unitaries ≤ 2); the MIXED VERTEX LAW — the same contraction with the strand changing spin at the spokes, the insertions
the spin-1 tensor operators V_{3/2} → V_{½} (rectangular, Σ_μ Q^μQ^{μ†} ∝ I by Schur) — is not written. THE OBJECT: |c_mixed(D_v)| ≤ C_mix
for every chord diagram at a vertex with domain spins in {½, 3/2, 5/2} (a finite table, the same engines as S8's). After it the multi-
wall small domains add at most Σ_{q∈S} 4⁴·z₁⁴·(2a_{3/2}/u)·C_mix⁴ per leaf plaquette to κ_U (about 2·10⁻⁶·C_mix⁴ at 0.4764), and the
branched pieces' mixed rows (Theorem L with mixed sheet strands) close z_br's mixed terms as Corollary N2 closes z_surf's. The measured
price (§3a-results) says how large these may be before a verdict moves.

### 3b. THE CYCLE GLUING OF CONTACT-LEAF CONSTITUENTS (κ_T = 4) — proved at M′'s activity, the vertex-contact surcharge named

**LEMMA G.** Let Y₁, Y₂ be plaquette-disjoint Z₂-minimal all-½ sets whose shared links form one simple cycle C, each link of C of
multiplicity exactly two in each Y_i; G_i, G_{6,i} their contact and six-fold graphs. Put Y = Y₁ ∪ Y₂, S(·) := W_½(·)/u^{|·|}, and
  β_× := [b₁(G(Y)) + b₁(G₆(Y))] − [b₁(G₁) + b₁(G_{6,1}) + b₁(G₂) + b₁(G_{6,2}) + 1] ≥ 0
(the cycle rank created where C, G₁, G₂ share vertices; β_× = 0 when they are pairwise vertex-disjoint). Then
  |S(Y)| ≤ 2^{1+β_×} · [4·2^{b₁(G₁)+b₁(G_{6,1})}] · [4·2^{b₁(G₂)+b₁(G_{6,2})}],
i.e. the cycle gluing costs 2 (κ_T = 2 + 2 = 4) relative to Lemma M′'s activities whenever β_× = 0.
*Proof.* (i) Y is even (C's links carry 2 + 2); G(Y) = G₁ ∪ G₂ ∪ C (C's links are four-fold in Y, every other link of Y is a link of one
Y_i with its own multiplicity); G₆(Y) = G_{6,1} ∪ G_{6,2}; β_× ≥ 0 because b₁ of a union of link-disjoint graphs is at least the sum
(each shared vertex lowers the component count by at most one). (ii) Lemma M′'s proof on Y verbatim: F₆ a spanning forest of G₆(Y),
T ⊇ F₆ a spanning forest of G(Y); the r₄ four-fold links of G(Y) ∖ T resolved by Creutz (weight 2/3, three pairings each); cut along
T ∪ G₆(Y); each piece integrates to ±2^{χ(P)−|P|}Π_b χ_½(z_b) (Corollary FS), |χ_½| ≤ 2, so |S(Y_ρ)| ≤ 2^{χ(Ŷ_ρ)} ≤ 4^{c(Ŷ_ρ)}.
(iii) The boundary map Z₂^{pieces} → Z₁(T ∪ G₆; Z₂) has kernel K_ρ := {unions of pieces of Y_ρ that are even subsets of Y}, so
c ≤ dim K_ρ + b₁(T ∪ G₆(Y)) ≤ dim K_ρ + b₁(G₆(Y)). (iv) dim K_ρ ≤ 2: for an even E ⊆ Y, E ∩ Y_i has even multiplicity off C, so its
Z₂ boundary is a cycle supported on C, hence 0 or C; if 0, E ∩ Y_i ∈ {∅, Y_i} (minimality); if C, E ∩ Y_i is one of the two complementary
sets A_i, B_i with boundary C (two such sets differ by an even subset of Y_i). So the even subsets are {∅, Y₁, Y₂, Y}, plus {A₁∪A₂,
A₁∪B₂, B₁∪A₂, B₁∪B₂} when C bounds in both. Some link e* of C lies outside the forest T and is a resolved chord; its plaquettes are
p₁, p₁′ ∈ Y₁ and p₂, p₂′ ∈ Y₂ (p_i ∈ A_i, p_i′ ∈ B_i in the bounding case: A_i has multiplicity one at e*). A union of pieces contains
whole ρ-pairs at e*: Y₁ is one only if ρ = (p₁p₁′)(p₂p₂′), A₁ ∪ A₂ only if ρ = (p₁p₂)(p₁′p₂′), A₁ ∪ B₂ only if ρ = (p₁p₂′)(p₁′p₂).
The three pairings are distinct, so K_ρ ⊆ {∅, E, Y ∖ E, Y} for one E: dim ≤ 2. (v) Hence |S(Y)| ≤ (2/3)^{r₄}3^{r₄}4^{2+b₁(G₆(Y))}
= 16·2^{r₄+2b₁(G₆(Y))} = 16·2^{b₁(G(Y))+b₁(G₆(Y))} (M′ (iv): r₄ + 2b₁(G₆) = b₁(G) + b₁(G₆) exactly), which is the claim. ∎
SPINS: Lemma S (a)–(d) run on Y the same way; parity now allows a half-integer set H ∈ K (H = Y₁ with Y₂ at integer spin, for instance),
each such assignment bounded by the product of the constituents' own spin-summed bounds (Y₂'s integer part C_I K_I^F included) times the
same 2^{1+β_×}: the cut count (iii)–(iv) does not see the spins.
KNOWN ANSWER: two branch-free spheres glued along a separating cycle (S1 §5's two-box waist, F = 16 or 20): G_i = ∅, β_× = 0, the lemma
reads 2·4·4 = 32 — S4′'s exact value 2·W(S₁)W(S₂)/u^F = 32 (§10, "equality ... for the F = 16 waist"). The bound is attained.
WHAT IS OPEN: the surcharge 2^{β_×} when the gluing cycle passes through vertices of a constituent's contact graph (or G₁ meets G₂ at a
vertex). Each such vertex adds at most one to β_×. The object: charge it to the contact links at that vertex in the tree's site count
(a constituent with N_c contact links has at most 2N_c contact vertices), or bound b₁(G(Y)) + b₁(G₆(Y)) for the composite directly by
the lattice boundary ((3/4)(N₄(Y) + 2N₆(Y)), Lemma E4's chain run on composites) — both routes stay inside U″'s per-plaquette rate.

### 3c. THE DRESSING OF RAISED AND INTEGER-SPIN RESTS — the size of the gap, and the table that closes it

What the certificate does: σ(F) prices a leaf at ONE spin j exactly (a_j^F d_j^χ), and the dressing κ_U (walls, pieces, table rows) is
the one computed for a spin-½ sheet. On a sheet at spin j the decorations differ (a wall at any integer spin k ≤ 2j; vertex stars with
spin-j strands), and nothing in the record bounds them. What is proved here: (1) THE LONE WALL ON A SPIN-j SHEET IS EXACT — S7's argument
at spin j: the cut sheet integrates to a multiple of χ_j(z)² or of χ_j(z²), and ∫χ_j²χ_k / ∫χ_j² = N(j, j, k) = 1 for 1 ≤ k ≤ 2j, so
z₁^{(j)} = Σ_{k=1}^{2j} d_k a_k·|r| with |r| = 1 for a lone wall — the same z₁ to leading order. (2) THE SIZE: a spin-j leaf of F
plaquettes enters at (a_j/u)^F(d_j/2)^χ relative to the spin-½ leaf — (a_{3/2}/u)^F ≈ 0.0047^F and (a₁/u)^F ≈ 0.079^F at 0.4764 — so
a raised dressing root κ^{(j)} up to the engine's cap 3 keeps the half-integer raised term below the spin-½ term by (e³a_{3/2}/u)^F ≤
0.096^F: for RAISED HALF-INTEGER rests only the existence of a convergent dressing is owed; for INTEGER rests (e³a₁/u ≈ 1.6) the
dressing must be good, not merely finite. (3) It does NOT close by Finner (Lemma Ω2) on the decorations against the exact rest: the
Hölder split costs d_j^{e(S,T)} per attachment, e = |T| − v_T + n_b ≥ 2 per wall (16 per wall at j = 3/2), and the dressing count then
diverges at β ≈ 0.5.
THE OBJECT: Theorem L at sheet spin j — r_v^{(j)2} := S(G_v(S_j ∪ Y))/S(G_v(S_j)) over the finite local family (the record's `local_enum`
configurations with the sheet arcs at spin j and the chords at integer spins ≤ 2j), its table θ^{(j)}(s), and the root κ^{(j)} — the same
engines; j = 1 first (where the bound must be good), then j = 3/2 (where it must only exist).

### 3d. D1.1–D1.3 WITHOUT S12 — the source bound at M′'s activity, and the relative leafless class

D1.1 prices an A-leaf X through act(X) = 4(ue^κ)^{|X|}σ(|X|), S12's activity. Without S12:
**LEMMA D1.1′.** For an A-leaf X (even off L_A, no proper relatively-closed subset) with T := L(X) ∩ L_A,
  sup_{U_T} |g_X(U_T)|_½ ≤ 4^{|T|} · 4 · 2^{b₁(G(X)) + b₁(G₆(X))} · u^{|X|}   (the all-½ part; G(X) the links off L_A of multiplicity ≥ 4),
hence |∫A g_X| ≤ ‖A‖·4^{|L_A|}·[Lemma M′'s activity of X]; with Lemma S's spin sum (relative form below) and Lemma E4 for X (whose
identity (E1) gains only O(|L_A|) terms: links of L_A may carry odd multiplicity) the U″-type activity 4u^{|X|}[C₁K₁^{|X|} + C_IK_I^{|X|}]
times 2^{O(|L_A|)}.
*Proof.* M′'s procedure with T added to the cut set: resolve the four-fold chords of G(X) off a spanning forest T_F ⊇ F₆, cut along
T_F ∪ G₆ ∪ T, leave T unintegrated; the pieces integrate to ±2^{χ(P)−|P|}Π_bχ_½(z_b), bounded pointwise by 2^{χ(P̂)} ≤ 4 each. The
pieces' boundary map into Z₁(T_F ∪ G₆ ∪ T; Z₂) has kernel the unions of pieces that are even OFF L_A — relatively even, hence relatively
closed — so by relative minimality only ∅ and X: dim ≤ 1, c ≤ 1 + b₁(T_F ∪ G₆ ∪ T) ≤ 1 + b₁(G₆(X)) + |T|, and the bound
4^{1+b₁(G₆)+|T|}·2^{r₄} = 4^{|T|}·4·2^{b₁(G)+b₁(G₆)} follows as in M′ (iv). Parity: at a link of L_A the observable absorbs the centre's
sign, so the half-integer pieces form a relatively even union, ∅ or X — Lemma S (b) holds relatively. ∎ (M1R's anticipated "K_A-level
repair": the cost 4^{|L_A|} moves K_A, never α.)
**THE RELATIVE LEAFLESS CLASS Ω_A** (A-polymers with no relatively-even subset; all-integer by the relative Lemma Ω1) is missed by D1.2's
count exactly as Ω is missed by §14's: |∫A·Πf_even| ≤ ‖A‖·‖f_even‖₆^{|X|} (Lemma Ω2: Finner's hypothesis holds at a link of L_A of
multiplicity one as well), counted by the closing from a plaquette at L_A (≤ 6|L_A| roots, links of L_A exempt) to the first relatively-
closed set and the dressing count on it (roots ≤ Σ_{ℓ∈L(U)}(6 − m_U(ℓ)) ≤ 20|U| when L_A-links of multiplicity one occur) — a convergent
series at w = ‖f_even‖₆e^{2α} ≤ 0.055 (β ≤ 0.52) whose sum enters K_A only (D1.3 needs a finite source sum, not the KP inequality: each
cluster carries at most one source polymer).
**PROPOSITION D1.3′.** At every β where the S12-free certificate passes WITH the Ω term (§2.7: 0.3650 page / 0.3656 tree), local gauge-
invariant observables cluster as |⟨A;B⟩| ≤ ‖A‖‖B‖K′_AK′_Be^{−α d(A,B)}, K′_A = 2^{O(|L_A|)}·6|L_A|·(1 + α + Σ_{Ω_A}), by D1.3's own
argument (the ordinary gas's KP inequality at α, now including Ω; the source polymers bounded by D1.1′ and Ω_A); D1.4 then gives the gap
m(β) ≥ α(β) — conditional, exactly like the S12-free KP inequality itself, on 3a (the multi-decoration neck), 3b (the vertex-contact
surcharge) and 3c (the raised and integer dressing). D1 adds no condition of its own once D1.1′ and Ω_A are in.

### 3-corrections (dated 2026-11-02, my own re-read of 3a–3d; nothing above edited)

(1) N0 (ii): the plus-pentacube's four internal faces are WALLS whose boundaries touch pairwise along the centre's four vertical edges
(each vertical edge carries two sheet plaquettes and two walls — the record's "two walls on one link" class, J7/§19, priced by the
dressing like any touching walls), not mutually lone walls. The domain structure is as stated: the four walls' cycles contain all four
edges of the centre's top face q, which is a one-plaquette domain; q at 3/2 with the arms at ½ and the walls at k ∈ {1, 2} is admissible
at q's edges (½ ⊗ 3/2 ⊗ k ∋ 0) and at the vertical edges (½ ⊗ ½ ⊗ k₁ ⊗ k₂ ∋ 0). Whether four mutually lone walls can isolate a plaquette
(walls on q's edges lying in different 3-spaces of ℤ⁴) is not needed: the count "at least four walls" holds either way, since a wall
shares at most one link with q.
(2) Lemma D1.1′'s proof: the kernel of the pieces' boundary map into Z₁(T_F ∪ G₆ ∪ T; Z₂) is the set of unions of pieces that are EVEN
EVERYWHERE (their boundary vanishes on the cut links, and they are even at the uncut ones automatically); an even subset is relatively
even, hence relatively closed, hence ∅ or X by relative minimality. So dim ≤ 1 as stated (X itself lies in the kernel only when X is even
on L_A too). The rank is at most b₁(T_F ∪ G₆ ∪ T) ≤ b₁(G₆) + |T| because the image consists of Z₂ 1-cycles of the cut graph.
(3) 3c (2), the integer rests, sharpened: the spin-1 leaf carries (9/4)(a₁/u)^F relative to the spin-½ leaf, and both are dressed in the
engine by the same e^{κ_U F}; a true spin-1 dressing κ^{(1)} moves the integer term by e^{(κ^{(1)} − κ_U)F}, so the integer leaves stay
below the spin-½ leaves of their size as long as κ^{(1)} < κ_U + ln(u/a₁) ≈ κ_U + 2.5 at 0.4764 (2.45 at 0.5100). The record's spin-½
roots are 0.05–0.18; the spin-1 table must deliver a root below about 2.5, a margin of an order of magnitude, not a sharp bound.

### 3a-results (records `neck_price.2026-11-02.txt`, engine `kp_cert_m1c_neck.awk` md5 28d14fb6…)

| number of record | ε* walls only (z₁ × (1+ε)) | ε* every decoration plaquette (z₁ × (1+ε), z(s) × (1+ε)^s) |
|---|---|---|
| 0.3650 page, U″ (S12-free), F₀ = 22 | [3.12, 3.21)·10⁻³ | [1.56, 1.65)·10⁻³ |
| 0.4764 page, the record's table mode, F₀ = 20 | [1.36, 1.46)·10⁻³ | [0.39, 0.48)·10⁻³ |
| 0.5100 page, conditional sharpened, F₀ = 22 | [0.68, 0.78)·10⁻³ | [0.09, 0.19)·10⁻³ |

Stake: ε* (walls) ∈ [0.001, 0.02] HELD at 0.3650 and 0.4764, REFUTED at 0.5100 (6.8·10⁻⁴, below the bet); "mode a below mode w" HELD.
READING, and a finding about the engine. At 0.5100 the refusal at ε = 2·10⁻⁴ is the dressing root's UPPER BRACKET jumping one step of the
engine's ×4 ladder (κ_U's upper end 0.179699 → 0.180157 while the lower end stays 0.179668), not the inequality's mathematics: any κ̄ with
R_hi(κ̄) + tail ≤ κ̄ certifies the dressing (16.65-a and 16.65-b need only that), and with the bracket bisected between the last refused
ladder point and the passing one (mode DRESSREF, `kp_cert_m1c.awk` md5 9fcc99a2…) the same perturbation reads κ̄ = 0.179800 and PASSES
(LHS ≤ 0.0033950 < α = 0.0034). So the conditional number's tolerance printed above is the ladder's resolution; the refined price follows.
STAKE for the refined run (`job_neck2.sh`, engine frozen as `kp_cert_m1c_ref.awk`, written before it runs): every step above a threshold of
record still FAILS with the refined bracket (the baseline brackets are within 10⁻⁶ of the refined ones); the refined ε* (every decoration)
at 0.5100 is at least 3·10⁻⁴.

(4) [3c, added] HIGHER INTEGER SPINS INSIDE BRANCHED PIECES: a piece plaquette with no rest link and every off-sheet link of multiplicity
≥ 3 may carry spin 2 (1 ⊗ 1 ⊗ 2 ∋ 0 there; ½ ⊗ ½ ⊗ 2 ∌ 0 forbids it on a rest link), and Theorem L / z_br price spin 1 only. Such a plaquette
needs eight others around it (S1 §21 J6′: k = 0 below nine plaquettes), so it first occurs in pieces of size ≥ 9, whose total in the
dressing is of order (5γa₁)^9 ≈ 3·10⁻⁶ per root at 0.5100; the raised insertion costs (5a₂)/(3a₁) ≈ 5·10⁻³ relative. The same object
(Theorem L with chord spins in {1, 2}) closes it; it is below every measured price.

---------------------------------------------------------------------------------------------------------------
## 4. THE UNIFICATION (where these pieces live elsewhere)

- **The gas's classification is the binary matroid of the plaquette boundaries.** Let M be the binary matroid on the plaquettes of ℤ⁴
  whose ground vectors are the Z₂ boundaries ∂p ∈ Z₂^{links}. Then: the LEAVES of the record (Z₂-minimal sets) are exactly the
  CIRCUITS of M; an even set is a cycle (a disjoint union of circuits, Lemma P (P3)); the leafless class Ω is exactly the set of CLOSED
  INDEPENDENT sets (independent in M, every link covered at least twice); the odd-rule tree T_odd is a circuit enumerator, and
  `omega_census.c` is an enumerator of closed independent sets (its prune is the matroid's independence oracle). In the frame's words
  (THE BOSTON CONJECTURE): the observer "∂ over Z₂" restricted to a support is BLIND exactly on its even subsets (its kernel), so the
  leaves are the minimal blind spots and Ω is the class on which that observer has NO blindness at all — the supports that carry no
  sheet. The census reads that a closed support with no blind spot needs at least 22 plaquettes in ℤ⁴: the lattice's systole for
  Z₂-acyclic 2-complexes without free edges (the cubical cousins of Bing's house, the dunce hat, the mod-3 Moore space).
- **Corollary Ω2 is Finner's form of Brascamp–Lieb on the cubical complex.** The exponents p_q = 6 are a FRACTIONAL COVER of the links by
  plaquettes (Σ_{q∋ℓ} 1/p_q ≤ 1), the hypergraph Hölder inequality behind Shearer's lemma and the Loomis–Whitney inequality. Its
  constant 3·15^{1/6}a₁ is the L⁶ norm of the spin-1 character, i.e. the number of SU(2)-invariants in 1^{⊗6} (the Riordan number 15,
  the same 15 as the six-fold link's invariant dimension R₆ in the realigned bound). A sharper fractional cover (p_q equal to the
  largest multiplicity on q, not 6) lowers the rate on sparse complexes: for even p, ‖χ₁‖_p^p = E[χ₁^p] = dim Inv(1^{⊗p}), so a complex
  whose links all have multiplicity ≤ 4 carries the rate 3·3^{1/4}a₁ = 3.95a₁ (Inv(1^{⊗4}) has dimension 3) in place of 4.71a₁.
- **§25 (c)'s realigned matrix is the REALIGNMENT map of quantum-information separability theory** (the Chen–Wu / Rudolph cross-norm
  criterion: for a bipartite operator, the realigned matrix's norms bound entanglement). The bound ‖M_t‖²_op ≤ λ_max(Tr_N P_t)·λ_max(Tr_S P_t)
  is the statement that a projector's realignment is controlled by the largest eigenvalues of its two reduced "density matrices"; a link
  projector whose invariant space is close to a product across the split has small realigned norm, and the dense k = 15, 16 stars are
  exactly the ones whose invariants are most entangled across every split.
- **Lemma G is the gluing law of a tensor network's bond rank, at Z₂ resolution.** A resolved chord on the gluing cycle chooses ONE of the
  three ways the two constituents' even halves can be paired, so at most one extra even union survives each resolution — the same
  "a contraction cannot create more than one new closed loop per resolved bond" that makes the Temperley–Lieb/binor calculus of M1's
  Lemma R a loop model at fugacity −2.
- **The neck is the domain-wall sector of the spin assignment.** A one-plaquette domain raised to 3/2 inside a ½ sheet, bounded by a
  piece's or four walls' attachment links, is a spin domain wall whose cost per unit area is a_{3/2}/u and whose boundary carries the
  mixed 3j insertions: the gas's analogue of a twisted-sector (orbifold) defect line, priced by its own vertex law — the mixed vertex law
  is the object.

### 2.7 RESULTS of the reruns with the leafless class included (record `rerun_omega.2026-11-02.txt`, 09:33–09:59)

Engine: `kp_cert_m1c.awk` md5 d16a81df… at the job's START; it gained three INERT modes during the job (Z1N/ZPN, their defaults, DRESSREF),
and the final engine (md5 9fcc99a2…) re-reads the 0.5100 and 0.5198 OMEGA point lines CHARACTER-IDENTICAL to the record's (checked).
(Ω-d) HELD: OMEGA unset, character-identical to M1's engine at 0.4764 (page and tree, α = 0.0044, F₀ = 20) and at the U″ point 0.3650.
(Ω-e) HELD: the engine's E[f_even⁶] at 0.4764, [0.00000000739318, 0.00000000739318], equals `feven_norm.awk`'s 512-bit enclosure
7.39318591407309933810·10⁻⁹ to its printed digits; ‖f_even‖₆ ≤ 0.0441372500 on both.
(Ω-f) HELD — the Ω term and every verdict:

| point (α) | w = ‖f_even‖₆e^{2α̃} | κ_Ω | ρ_Ω | T_Ω (n_Ω = 21) | LHS upper end with T_Ω |
|---|---|---|---|---|---|
| 0.3650 page U″ (0.0044) | 0.026940 | 0.0926 | 0.1478 | < 10⁻¹⁶ | 0.0043576 (unchanged) |
| 0.4764 page record (0.0044) | 0.045719 | 0.2465 | 0.2925 | 5.2·10⁻¹² | 0.0043833 (unchanged) |
| 0.5100 page conditional (0.0034) | 0.051907 | 0.3489 | 0.3679 | 7.2·10⁻¹⁰ | 0.0033872 (unchanged) |
| 0.5198 tree conditional (0.0039) | 0.054115 | 0.4090 | 0.4073 | 6.5·10⁻⁹ | 0.0038800 (unchanged) |

Verdicts with OMEGA = 1: U″ page 0.3650 PASS [0.0039, 0.0050] / 0.3652 FAIL; tree 0.3656 PASS [0.0038, 0.0051] / 0.3658 FAIL; the record's
table mode page 0.4764 PASS [0.0041, 0.0047] / 0.4766 FAIL; tree 0.4816 PASS [0.0041, 0.0052] / 0.4818 FAIL; conditional page 0.5100 PASS
[0.0033, 0.0038] / 0.5102 FAIL; tree 0.5198 PASS [0.0036, 0.0043] / 0.5200 FAIL — the record's and M1R's windows to the grid digit. (At
0.5102 and 0.5200 the scan's LAST α, 0.0120, is refused by the Ω dressing's own convergence edge, "no kappa-bar for the leafless dressing
below 2", far outside every passing window; the verdicts are the record's.)
(Ω-g) THE PRICE OF n_Ω (a reading): at 0.5100 page, α = 0.0034, the Ω term alone refuses the verdict if Ω had members of ≤ 11
plaquettes (NOM = 11: LHS 0.0034030 > α; NOM = 10: 0.0034303; NOM = 8: 0.0037058; NOM = 6: 0.0057409) and passes from NOM = 12 on
(0.0033930). The census's n_Ω ≥ 22 clears it by ten plaquettes.
**So: the leafless class was an uncovered class of Theorem 8.9's Kotecký–Preiss sum; priced (Finner + the first-closed-set count + the
census n_Ω ≥ 22), it adds at most 7·10⁻⁹ to the left side at every number of record, and no threshold — 0.3650/0.3656 S12-free,
0.4764/0.4816 of record, 0.5100/0.5198 conditional — moves.**

### 2.3-add (census at F = 21; record `census_mode0_F21.txt`)
MODE 0 to F = 21: NO closed node — no leafless polymer with 21 plaquettes (6.27·10⁹ nodes, 8.17·10⁶ pruned, 948 s; 0 rank disagreements).
Stake (Ω-c) HELD and sharpened: g48's 3,248 odd irreducible sets at F = 21 with no rest of complement ≤ 6 (profiles (30,8), (9,22), (12,20))
all carry even subsets. n_Ω ≥ 22 (one road at 21, two roads through 20). F = 22 (g48's (8,24) family, 352 sets) was not run: ~1 h, and the
price of n_Ω (§2.7 (Ω-g)) is already cleared by ten plaquettes.

---------------------------------------------------------------------------------------------------------------
## 5. THE TRUNK'S TWO ITEMS FROM READER 047_R (received mid-task; answered here)

### 5.1 Item (2): does Z₂-minimality forbid (i) a degree-6 half-axis, (ii) a vertex star with ρ > √2? — NO and NO, by objects
(i) `sixfold_leaf.awk`: the Z₂ boundary of a tree of ten unit 3-cubes — A, B, C in the 3-spaces (1,2,3), (1,2,4), (1,3,4) sharing only the
link ℓ = [0,1]×0×0×0, each continued one cube toward x₁ = −1, and four cubes of the hyperplane x₁ = −1 joining the three arms — is a set
of 42 plaquettes with every link even (78 two-fold links, two six-fold: ℓ and [−1,0]×0×0×0), F₂ rank 41 of 42: nullity 1, so EVEN AND
Z₂-MINIMAL (the sheet is one sphere passing three times through each six-fold link; cutting it along the three passages leaves it
connected, which is the hand proof of minimality the rank confirms). Degree-6 half-axes occur in minimal leaves; the record's six-link
census (boxes to F = 28, none minimal) is consistent, the object lying at F = 42.
(ii) The same leaf's star at the origin is K_{2,6} (half-axis degrees ±e₁: 6, the six others: 2), the table's orbit deg 66222222, |E| = 12,
ρ = ρ̂ = √5 = 2.236068 > √2. And M1's machine-verified 54-plaquette leaf (∂ of 13 cubes, nullity 1; M1 §11 (1)) carries the full
three-dimensional star K_{2,2,2} at a vertex (deg 444444, ρ = 1.898667). So the dials below κ = 1.385133 that need these exclusions
(1.360790 "no degree 6"; 2^{1/3} "the census alphabet") are not available by minimality; the full-table κ is the honest constant.
Bearing on §2: none — the even-star alphabet concerns leaves, and the leafless class has no even star at all.

### 5.2 Item (1): THE ABSORPTION ARGUMENT, read on the page — CORRECT for the all-½ part of every Z₂-minimal leaf
(1) Theorem V at spin ½ (S1 §23 (i), signed): |W_½(X)| ≤ (2u)^F Π_v √S_½(G_v) = u^F 2^{V−F} Π_v e_v with e_v² = S_½(G_v)2^{d_v−2},
using Σ_v d_v = 4F. (2) Split every vertex into the c_v components of its star (Lemma P / M1b §8): the split complex has the same
plaquettes, links and closed subsets, b₂ = 1, connected, so V + Σ_v(c_v − 1) − L + F ≤ 2. (3) Σ_ℓ m_ℓ = 4F gives L = 2F − X/2,
X = Σ_ℓ(m_ℓ − 2) = Σ_v w_v, w_v := Σ_{half-axes at v}(m − 2)/2 = |E(G_v)| − (half-axes used); so 2^{V−F} ≤ 4·2^{−Σ_v(c_v − 1 + w_v/2)}
and |W_½(X)| ≤ 4u^F Π_v ρ̂_v, ρ̂_v := e_v/2^{w_v/2 + c_v − 1}. (4) Spreading each vertex's factor over its |E(G_v)| corners (four per
plaquette), Π_v ρ̂_v ≤ κ^F, κ := max_{orbits} max(1, ρ̂)^{4/|E|}. Every step is right as displayed.
SECOND ROAD ON κ (`kappa_canon.awk`, exact e2 from `even_stars.table.2026-11-01a.txt`, c from the mask in even_stars.py's EDGES order):
κ = 1.385132835 at the full star (|E| = 24, w = 16, c = 1, ρ̂ = 7.062339); without a degree-6 half-axis 1.360790. The reader's values.
WHAT IT DOES NOT COVER: the spin sum. σ(F) prices one higher spin on the WHOLE leaf; a contact leaf's pieces (cut along its contact
links) may carry DIFFERENT half-integer spins (Lemma S (b); M1 §4a), and those mixed assignments are not in 4σ(F)(κu)^F. M1's proved
Lemma S (d) bounds them only relative to Lemma M′ (each touched chord cut, a factor 2 per chord, δ₁ ≈ 0.18 per raised piece), a rate
√(2(1+δ₁)) ≈ 1.535 per plaquette ABOVE κ — so with every spin assignment proved the S12-free number stays U″'s 0.3650 / 0.3656. The
route becomes a theorem at its certificate number once the raised pieces are priced inside Theorem V: the MIXED-SPIN STAR TABLE (each
even-star orbit with its local pieces labelled by half-integer spins, the ratio √(S_mixed/S_½) per labelling) — the same object as the
neck's mixed vertex law (§3a): both are Theorem V with sheet strands of two half-integer spins meeting at a vertex.
STAKE for the certificate reading of the route (written before `job_reader.sh` runs): tail-only K = 1385133/1000000 (≥ κ), C = 1,
EVENTAIL (T1 + T2), NCSIG, F₀ = 22, the Ω term included (OMEGA = 1); by M1's tolerance curve κ*(0.40) = 1.4312, κ*(0.45) = 1.2291 the
page threshold lies in [0.405, 0.418] (linear interpolation 0.411), the tree within +0.004 of it — well above the reader's desk transfer
0.3424 / 0.3461, which scaled u in every activity and not in the tail alone.

### 3a-results, refined (record `neck_price_ref.2026-11-02.txt`, engine `kp_cert_m1c_ref.awk` md5 9fcc99a2…, DRESSREF on)

Stake HELD: every step above a threshold of record still FAILS with the refined bracket (0.3652 page, 0.3658 tree U″; 0.4766 page, 0.4818
tree; 0.5102 page, 0.5200 tree) — the refinement certifies no new number; and the refined ε* (every decoration) at 0.5100 is 3.9·10⁻⁴ ≥ 3·10⁻⁴.

| number of record | ε* walls, ladder | ε* walls, refined | ε* every decoration, ladder | ε* every decoration, refined |
|---|---|---|---|---|
| 0.3650 page U″ | 3.1·10⁻³ | [9.37, 9.46)·10⁻³ | 1.6·10⁻³ | [4.68, 4.77)·10⁻³ |
| 0.4764 page record | 1.4·10⁻³ | [2.04, 2.14)·10⁻³ | 0.4·10⁻³ | [0.58, 0.68)·10⁻³ |
| 0.5100 page conditional | 0.7·10⁻³ | [1.95, 2.04)·10⁻³ | 0.1·10⁻³ | [0.39, 0.48)·10⁻³ |

THE ENGINE FINDING, stated once: the record's dressing root is bracketed above on a ×4 ladder from the lower iterate, so its printed upper end
(and hence LHS) can jump by a factor-4 step under a perturbation of 10⁻⁴; every κ̄ with R_hi(κ̄) + tail ≤ κ̄ is a valid certificate (16.65-a,
16.65-b), and the bisected bracket triples the measured tolerance at 0.3650 and quadruples it at 0.5100 while moving no threshold of record.
THE PRICE, read against the neck: a mixed-domain correction is affordable at the S12-free number up to 0.47 % per decoration plaquette
(0.94 % per wall), at the record's 0.4764 up to 0.06 % (0.2 % per wall), at the conditional 0.5100 up to 0.04 % (0.2 % per wall). The
first-order surface-piece case is absorbed (Corollary N2); the multi-wall small domains are fourth order (≈ 2·10⁻⁶·C_mix⁴ per leaf
plaquette in κ_U, against tolerances of 10⁻⁴–10⁻³ in z₁): the mixed vertex law with C_mix of order one closes the neck at every number.

### Corrections on my own second read (dated 2026-11-02 10:2x; nothing above edited) [heading corrected 10:4x: it first said "after the advisor's read" — no reviewer's text was received; the four items are mine]
(1) §2.3 and §2.7 say "two roads to 20". Exactly: the ENUMERATION of closed sets is ONE road — `omega_census.c` uses g48's canonical
construction line for line, and its control reproduces g48's totals because it is that enumeration (independently checked only on the
branch-free counts, by g45's Redelmeier road in S1 §5 (R2)); the CLASSIFICATION (leafless or not) is on two roads through F = 20 (g48's
least-rest search against the Z₂ rank with its from-scratch check), and F = 21 is one road for both. The detector's positive branch is
now exercised by a PLANTED POSITIVE (`omega_census_rel.c`, MODE 2: the four links of p₀ exempt from closing, as an observable's links are):
it reports {p₀} as closed and independent at F = 1 (rank 1; record `census_rel_planted_F8.txt`) — before this, "no member below 22" was
the reading of an instrument whose firing side had fired only on dependent sets.
(2) Lemma G's scope, in its statement: ONE simple gluing cycle, multiplicity exactly two on each side, all-½; the cost 2·2^{β_×}. For
constituents glued along a shared link set T with b₁(T) ≥ 2 (S4′'s theta and figure-eight cases, C = 16/3 for branch-free sheets)
nothing is proved here, and the spin extension ("SPINS" paragraph) is SKETCHED, not proved.
(3) §3c, one sentence owed: an integer rest's spins are split by decoration-attachment links exactly as a half-integer rest's are (N0),
so the object "Theorem L at sheet spin j" must take DOMAIN-SPLIT integer sheets (the integer analogue of the neck), not only uniform ones.
(4) §2.7 (Ω-g) is a reading at the point line's α = 0.0034 (the conditional number's best α), not a scan's verdict.

### 5.2-add. LEMMA G′ — the composite tree at the route's activity costs nothing new (Theorem V + Euler)

**LEMMA G′.** Let Y be a link-connected even all-½ plaquette set (a composite of Z₂-minimal constituents glued along shared links) and
b₂(Y) := dim_{Z₂} of its space of even subsets. Then |W_½(Y)| ≤ 2^{1+b₂(Y)}·(κu)^{|Y|}, κ = 1.385133. In particular two Z₂-minimal
constituents glued along one simple cycle (multiplicity two on each side) have b₂ ≤ 3 (Lemma G (iv)), so
  |W_½(Y₁ ∪ Y₂)| ≤ 16(κu)^{|Y|} = [4(κu)^{|Y₁|}]·[4(κu)^{|Y₂|}]:
the cycle gluing costs a factor 1 relative to the route's own activities — at most the record's cost 2, so κ_T = 4 holds for contact-leaf
constituents at this activity with no further lemma.
*Proof.* 047_R's steps (1), (3), (4) are statements about one even set and its vertex stars; step (2) is the only place minimality entered,
as χ(Y′) ≤ 2 for the vertex-split complex Y′. For a composite: splitting vertices keeps every link and every link adjacency of plaquettes,
so Y′ is connected and has the same even subsets, b₂(Y′) = b₂(Y); hence χ(Y′) = 1 − b₁(Y′) + b₂(Y) ≤ 1 + b₂(Y), and the chain gives
|W_½(Y)| ≤ u^{|Y|}2^{χ(Y′)}Π_v ρ̂_v ≤ 2^{1+b₂(Y)}(κu)^{|Y|} (every vertex star of Y is an even star, so ρ̂_v ≤ κ^{|E(G_v)|/4}). ∎
For a tree of k constituents with gluing sets T_i, b₂(Y) ≤ k + Σ_i b₁(T_i), so the composite costs 2^{1−k+Σb₁(T_i)} against Π 4(κu)^{F_i}:
at most 2 per independent gluing cycle — the record's κ_T = 4 accounting, now proved at the all-½ level for every constituent shape
(branch-free or contact) and every gluing set. What it does not see is again the spin sum (mixed half-integer assignments across pieces).

### 5.3 RESULTS — 047_R's route in the certificate (record `reader_route.2026-11-02.txt`)
[filled in below when the bisection ends]

RUN NOTE (10:3x): the first route bisection (alpha over [0.0010, 0.0120], beta over [0.3650, 0.4500]) was STOPPED by hand after its two
end checks (0.3650 PASS over the whole alpha range; 0.4500 FAIL; record `reader_route.2026-11-02.STOPPED.txt`), its leftover processes
killed by command line; relaunched as `job_reader2.sh` with alpha in [0.0025, 0.0070] and beta in [0.4000, 0.4300], both ends read first.

### 5.4 The trunk's items from reader 044_R (received 10:4x)
(1) S1 line 813 says of the four-contact minimal leaves "in 3×3×2×1 none to F = 28". Its own records `boxenum_3x3x2x1_F26.2026-11-01a.txt` and
`_F28` (header "# F N4 leaves minimal max|S|(minimal)", box line "boxenum box 3x3x2x1") read "26  4  7930  220  4": 220 MINIMAL leaves with
four contact links at F = 26 in 3×3×2×1, every one |S| = 4 (the reader's 7938 is 7930 in both records). The sentence is REFUTED by its record.
NOTHING HERE RESTS ON IT: the box censuses (multiplicity capped at four, the brief's integrity note) are the page's evidence for S12's census
law, never an input to a certified number; U″ uses g51's whole-ℤ⁴ census at F ≤ 22; the Ω census is this folder's own whole-ℤ⁴ enumeration
and g48's; the route uses the exact even-star table; Lemmas G, G′, N1, D1.1′ and Ω1–Ω4 use no census.
(2) The pointwise surgery identity failing inside Lemma S6's class (contact cycle rank 0) touches nothing here: S6 is proved by gauge fixing a
forest (exact W = u^F 2^{χ(X̂)}), Lemma M′ by resolution and cut, the route by Theorem V; none uses a surgery identity.
(3) Theorem 8.7's block-split reading is M87's; not duplicated. §1's answer (8.7 is independent of the gas) holds for any re-evaluation of its
Dobrushin row sum, which uses no polymer.

### 5.3 RESULTS — 047_R's route in the certificate (record `reader_route2.2026-11-02.txt`; engine `kp_cert_m1c_ref.awk` md5 9fcc99a2…)

Run: tail-only K = 1385133/10⁶ ≥ κ = 1.385132835, C = 1, EVENTAIL (T1 + T2), NCSIG, F₀ = 22 (N_c(22) = 46,816), the Ω term in (OMEGA = 1,
n_Ω = 21), DRESSREF off (the record's bracket), table of record tag g, α on the 1e-4 grid in [0.0025, 0.0070], bisection on the 2e-4 grid.
- PAGE: **β′ = 0.4108** (PASS for α ∈ [0.0039, 0.0044]), refused at 0.4110 (no α passes; "the inequality's upper end is above alpha").
- TREE: **β′ = 0.4124** (PASS for α ∈ [0.0038, 0.0046]), refused at 0.4126 (no α passes; the same refusal).
Stake (page in [0.405, 0.418], tree within +0.004) HELD — page 0.4108 at the interpolation 0.411, tree +0.0016. The reader's desk transfer (0.3424 / 0.3461) scaled u in EVERY
activity; the certificate scales only the tail F > F₀ (every enumerated leaf, F ≤ 22, has a forest contact graph and its proved activity
4σ(F)u^F), and the number is +0.068 higher.
SET BESIDE M1's S12-FREE NUMBER (0.3650 page / 0.3656 tree, Corollary U″):
| | U″ (M1) | the route (047_R + this file) |
|---|---|---|
| tail activity | 4u^F[C₁K₁^F + C_IK_I^F], K₁ = √(2(1+δ₁)) ≈ 1.535 | 4σ(F)(κu)^F, κ = 1.385 |
| page / tree | 0.3650 / 0.3656 | 0.4108 / 0.4124 |
| the spin sum of contact leaves | PROVED (Lemma S: mixed half-integer and integer assignments) | OPEN: σ(F) prices one spin on the whole leaf; the mixed assignments across a contact leaf's pieces are not in the bound |
| κ_T = 4 on contact constituents | Lemma G: one gluing cycle with β_× = 0; surcharge 2^{β_×} and gluing sets with b₁ ≥ 2 OPEN | Lemma G′: every gluing set, cost ≤ 2 per gluing cycle, at the all-½ level — PROVED |
| the neck (multi-decoration domains) | OPEN (§3a; price 0.47 % per decoration plaquette at 0.3650) | OPEN (same object) |
| raised / integer rests' dressing | OPEN (§3c) | OPEN (same object) |
| the leafless class | priced, n_Ω ≥ 22, T_Ω ≤ 10⁻¹⁶ | priced, in the run |
| D1 (clustering, gap) | D1.1′ at M′'s activity | D1.1 via G′ on the double: ‖g_X‖₂ ≤ 2^{(3+|T|)/2}(κu)^{|X|}, K_A only |
So the two numbers rest on complementary halves: U″ owns the spin sum and not the general gluing; the route owns the general gluing and
not the spin sum. THE OBJECT THAT JOINS THEM: Theorem V with the contact leaf's pieces carrying DIFFERENT half-integer spins — the
mixed-spin even-star table (each even-star orbit, its local pieces labelled by half-integer spins, √(S_mixed/S_½) per labelling) — which is
also the neck's mixed vertex law (§3a). With it the route's 0.4108 / 0.4124 becomes S12-free on the spin sum, and the remaining conditions
are the neck (the same table) and the raised/integer dressing (Theorem L at sheet spin j).

---------------------------------------------------------------------------------------------------------------
## 6. THE STATE OF THE STRONG END AFTER THIS FILE (three grades; section numbers to find each)

PROVED (on this page, with proofs):
- Theorem 8.7 (0.2452) is independent of every statement about the flux-surface gas (§1; the line: the cover links integrated exactly,
  then Dobrushin on L₀); its own finite inputs checked (§1a: the perfect cover 96/96 and 1536/1536; the exact-constant premises with
  margins 1.416 and 1.107, a grid reading).
- The leafless class Ω (closed supports with no Z₂-even subset) is UNCOVERED by every term of Theorem 8.9's certificate (§2.1);
  Lemma Ω1 (all-integer, W = ∫Πf_even, closed under forest gluing); Corollary Ω2 (Finner: |W| ≤ ‖f_even‖₆^{|X|}); Lemma Ω3 (the count:
  first closed set + the repaired dressing lemma as a pure count); Corollary Ω4 (the certificate's term T_Ω) (§§2.0–2.5).
- Lemma N1 (one disc piece on one separating cycle, all spin assignments, exact) and Corollary N2 (the surface pieces' mixed terms sit
  under z_br) (§3a); FINDING N0: the record's neck premise is false beyond one lone wall (one-plaquette domains).
- Lemma G (one simple gluing cycle of two Z₂-minimal constituents costs 2·2^{β_×} relative to Lemma M′'s activities; attained on the
  two-box waist) (§3b, scope in §3-corrections (2)).
- The lone wall on a spin-j sheet is exact, ratio N(j, j, k) = 1 (§3c (1)).
- Lemma D1.1′ (the A-leaf source bound at M′'s activity, cost 4^{|L_A|}, by relative minimality) and the relative leafless class Ω_A (§3d).
- S1 §25 (c), the realigned operator-norm bound: SIGNED line by line, its K₄ known answer re-derived by hand (§3e).
- 047_R's absorption: |W_½(X)| ≤ 4(κu)^F for every Z₂-minimal leaf, κ = 1.385132835 (recomputed from the exact table) (§5.2).
MEASURED (records in this folder):
- No leafless polymer with F ≤ 21 (`census_mode0_F20.txt`, `census_mode0_F21.txt`; control `ctl_mode1_F18.txt`; planted positive
  `census_rel_planted_F8.txt`): n_Ω ≥ 22; the price of n_Ω is 11 (§2.7 (Ω-g)).
- With the class included every number of record is unchanged: T_Ω ≤ 7·10⁻⁹; 0.3650/0.3656, 0.4764/0.4816, 0.5100/0.5198 PASS, the steps
  above FAIL (`rerun_omega.2026-11-02.txt`).
- The neck's price (§3a-results, refined): 0.47 % per decoration plaquette at 0.3650, 0.06 % at 0.4764, 0.04 % at 0.5100; the engine's
  ×4 bracket ladder found and measured (`neck_price.2026-11-02.txt`, `neck_price_ref.2026-11-02.txt`).
- Two exclusions refuted by objects: a 42-plaquette Z₂-minimal leaf with two six-fold links and a K_{2,6} star (ρ = √5); M1's 54-plaquette
  leaf with a K_{2,2,2} star (ρ = 1.899) (§5.1; `sixfold_leaf.awk`).
- 047_R's route in the certificate (tail-only K = κ, the Ω term in): 0.4108 page / 0.4124 tree (§5.3), conditional on the contact-leaf spin sum.
NAMED (the precise next objects, each with its instrument):
- THE MIXED-SPIN STAR TABLE: Theorem V / the vertex law with sheet strands of two half-integer spins meeting at a vertex — it closes the
  neck's multi-decoration domains AND the contact-leaf spin sum of 047_R's route (one object, two uses); the record's star engines.
- The vertex-contact surcharge 2^{β_×} of Lemma G and the general gluing sets T (b₁(T) ≥ 2) for contact constituents.
- Theorem L at sheet spin j (j = 1 first, domain-split sheets included): the raised and integer rests' dressing.
- The census at F = 22 (g48's (8,24) family) — not needed by any number (the price of n_Ω is cleared by ten plaquettes).
