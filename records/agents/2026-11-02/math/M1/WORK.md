# M1 — the strong end: Theorem 8.9's tail, S12, and β* (proof agent M1, 2026-11-02)

READING ORDER (sections were appended as the work went; §4 sits at the END of the file): §1 the tail (T1, T2) → §3 Lemmas
R, M, E, S and Corollary U → §3b Lemma M′ and (E3″), Corollary U′ (the sharp form) → §10 non-orientable pieces (the record's
(G2′), a second road) → §4 the numbers (END of file) → §2, §2b, §11 the relayed routes and items → §5 the winding table →
§6 the exit budget → §7 the Theorem-V road → §8 the next objects, with PROPOSITION LP (7/12 is where vertex-local counting
stops) → §9 the unification → §12 the least-area projection → §13 LEMMA E4 AND COROLLARY U″ (exponent 1/2, the headline number) → §14 the certified tolerance curve κ*(β).
HEADLINE: THEOREM 8.9 WITHOUT S12 at β ≤ 0.3650 (page) / 0.3656 (tree), F₀ = 22, certified by Corollary U″ (exponent 1/2: Lemma M′ + Lemma
E4, the lattice-boundary fact of the 027_P relay carried past its own use, §13; bisection and the full 2·10⁻⁴ grid agree) —
S12-FREE; with Corollary U′ (exponent 7/12) 0.3348 page / 0.3350 tree (§4b). Every other input is the record's, as signed
(S1 §25 (i): "every inequality under the table-mode number now carries a second seat's signature"), and two of them are
OPEN IN THE RECORD ITSELF, inherited here exactly as the record's 0.4764 carries them: (1) THE NECK LEMMA — S1 (m′): "the
lemma proper (the mixed-spin Theorem V on the cup and on a general attachment cycle, with the channel count) remains owed";
its certified factor MIXH (mix ≈ 10⁻¹¹ at these points) rides in the engine; (2) THE CONTACT-REST DRESSING — the joint
decoration bound is proved for branch-free rests and applied by the record to contact rests too (§8 (2), found here).
Theorem 8.7's 0.2452 is a path-of-links route with neither, so "unconditional" in the record's sense stays with 0.2452
until (1) and (2) land. With S12's stake kept, the
sharpened tail moves the conditional number 0.4764 → 0.5100 (page) and 0.4816 → 0.5198 (tree) (§4a).

Work directory: this folder. Engine of record copied byte-identical (md5 b5145c3821ac1b9764168336f40d6a6a) from
III `STDLIB/build/aperanton/kp_cert_table_wip.awk` (committed b3c0b51b3) to `kp_cert_rec.awk`; the table of record
(tag g, `local_tail_table.2026-10-31g.txt`) to `r2tab_g.txt`. Every run below is gawk -M on the 2^-128 grid with
outward rounding, AWKPATH = III `STDLIB/scripts` (the Bessel library). Nothing in either repository is edited.

CONTROL (reproduces the record to the digit): β = 0.4764, page dressing, α = 0.0044: LHS ∈ [0.0043826, 0.0043833],
r_hi = 0.696902, κ_U ∈ [0.131404, 0.131411] → PASS; tree dressing α = 0.0044: LHS 0.0031276, r_hi 0.686135 → PASS.
The record's crude tail 3·(4/5)σ(21) r^21/(1−r) = 0.0040286 is 91.9 % of that LHS (the record's own number).

---------------------------------------------------------------------------------------------------------------
## 1. THE TAIL, SHARPENED: two counting facts the certificate never used

The certificate (S1 §14, engine line 133) bounds the leaves of size F > F₀ by N(F) ≤ 5^{F−1} for every F and sums

  tail_rec = 3·(4/5)·σ(F₀+1)·r^{F₀+1}/(1−r),   r = 5 ũ e^{2α̃}.

**Lemma T1 (parity of closed sets).** Every finite Z₂-closed plaquette set X ⊂ ℤ⁴ (every link of even multiplicity)
has |X| even.
*Proof.* X is a Z₂ 2-cycle of the cubical complex of ℤ⁴; a finite one lies in a box B, and the cubical complex of a box is
contractible, so H₂(B; Z₂) = 0 and X = ∂C for a finite Z₂ 3-chain C (a set of unit cubes of B). Over Z₂,
X = Σ_{c∈C} ∂c, and the size of a Z₂-sum has the parity of the sum of the sizes (each cancellation removes a face from two
terms at once): |X| ≡ Σ_{c∈C} |∂c| = 6|C| ≡ 0 (mod 2). ∎
(The census agrees: N(F) and N_c(F) are nonzero only at even F, and the leaf sum already runs over F = 6, 8, …, F₀.)

**Lemma T2 (the last closing step is forced).** On Lemma P's odd-rule tree (root {p₀}; a node S that is not closed has
children S ∪ {p}, p ∈ P(l) ∖ S, l the smallest odd link of S, at most 6 − m_S(l) ≤ 5 of them; every Z₂-minimal X ∋ p₀
is a node, reached at depth |X| − 1), the number of Z₂-minimal sets of size F through p₀ satisfies

  N(F) ≤ #(nodes at depth F − 2) ≤ 5^{F−2}.

*Proof.* Let X be a leaf of size F and S its parent on any path reaching it (depth F − 2, |S| = F − 1). X = S ∪ {q} is
closed, so odd(S) = ∂q as sets of links (odd(S ∪ {q}) = odd(S) Δ ∂q = ∅). A plaquette is determined by its four links,
so a node has at most ONE closed child: the map leaf ↦ (a chosen parent) is injective. Hence N(F) ≤ #(depth F−2 nodes),
and every node has at most five children, so #(depth d nodes) ≤ 5^d. ∎
(It is stated on Lemma P's tree, not surf.c's, because the tail covers contact leaves too; it holds on surf.c's tree
verbatim.)

**Corollary T3 (the sharpened tail).** σ(F) = 1 + Σ_{j≥1} d_j²(a_j/u)^F is decreasing in F (a_j < u). With T1 and T2,
for every per-leaf activity bound of the form 4·C·σ(F)·K^F·u^F (C ≥ 1, K ≥ 1; the record's case C = K = 1),

  tail ≤ 3·(4C/25)·σ(F₀+2)·Σ_{F even ≥ F₀+2} (rK)^F = 3·(4C/25)·σ(F₀+2)·(rK)^{F₀+2}/(1 − (rK)²),   rK < 1.

Against the record's tail at the same point the factor is (1/5)·(r/(1+r))·σ(F₀+2)/σ(F₀+1) ≈ 0.082 at r = 0.697:
the tail shrinks about twelvefold. NOTHING ELSE CHANGES: the per-leaf activity in the tail is still 4u^F — S11 for
surfaces, S12 for contact leaves — so this raises the CONDITIONAL number (conditional on S12's staked half exactly as
before) and it shrinks the price of every crude bound on the open class by the same factor.

**Implementation (`kp_cert_m1.awk`, a copy of the engine with ONE added mode).** EVENTAIL=1 replaces line 133's tail by
Corollary T3's, every quantity directed (r_hi and K_hi up, r_lo and K_lo down, cdiv/fdiv, σ at F₀+2 bracketed both ways,
1 − (rK)² from the bracketed square); TKN/TKD = K (default 1) and TCN/TCD = C (default 1) multiply the TAIL ONLY — never
the enumerated leaves, never the dressing (that is what TILT does, and TILT is a different question). With EVENTAIL
unset the engine is byte-for-byte the record's in its output (checked below).

**STAKES (written before the sharpened engine has run one line):**
- (T-a) At β = 0.4764, α = 0.0044, page: the sharpened LHS ≈ 0.00069 (enumerated 0.000354 + tail ≈ 0.00033).
- (T-b) β* (page, F₀ = 20, table mode, the 2·10⁻⁴ grid) ∈ [0.505, 0.525]; tree ∈ [0.510, 0.530].
- (T-c) F₀ = 22 with N_c(22) = 46,816 (every one a forest contact graph, so |S| ≤ 4 by S6 — proved) adds
  between +0.002 and +0.008 to each.
- (T-d) The failure one grid step above β* is "the inequality's upper end is above alpha" (the tail still matters near
  r ≈ 0.75), not "no dressing root".
- (T-e) With EVENTAIL unset the modified engine reproduces the control lines above character for character.

**RESULTS (§1 stakes read, 2026-11-02 03:3x):** (T-e) HELD — with EVENTAIL unset the modified engine's output is
character-identical to the record's engine at β = 0.4764, both dressings (`ctl_rec_*.txt` = `ctl_m1_*.txt`).
(T-a) HELD — at β = 0.4764, α = 0.0044, page: LHS ∈ [0.0006848, 0.0006849] (enumerated 0.0003539, tail 0.0003309);
tree: 0.0005505. (T-b) page HELD at its lower edge: β* = 0.5050 (record `scan_even_page_F20.txt`; PASS for
α ∈ [0.0035, 0.0043] at 0.5050). (T-c) HELD: F₀ = 22 gives page β* = 0.5100 (`scan_even_page_F22.txt`, PASS α ∈
[0.0033, 0.0038]), +0.0050. Tree scans running. (T-d): read when the failure lines are inspected below.
So THEOREM 8.9 AS CONDITIONED IN THE RECORD (S12's staked half the one staked input) now reaches β = 0.5100 (page,
F₀ = 22) instead of 0.4764: the tail sharpening alone moves the conditional number by +0.034.

---------------------------------------------------------------------------------------------------------------
## 2. THE FOUR RELAYED ROUTES (coordinator's message, 2026-11-02), each read against the S1 page

**(1) 119_LOG IDEA-1, "|S| ≤ 4^m and each cut piece has ≥ 6 plaquettes, so |S| ≤ 4^{F/6}": REFUTED AS STATED.**
Its premise reads "each component is a closed lattice surface, so its area is at least 6". The components of X_cut are
surfaces WITH BOUNDARY (X cut along its contact links), not closed surfaces, and they can be single plaquettes: the
record's own Object A (S1 (p) STAKE/RESULTS, `resolve/objectA.txt`, F = 138, Z₂-minimal: 81/81 resolutions
connected) has X_cut = {f} ⊔ (the rest), f = [0,1]² a ONE-plaquette piece (its four links are the contact links).
Object C has two one-plaquette pieces f₁, f₂. So m ≤ F/6 does not follow; the bound 4^{F/6} is unproved by this
argument. (Whether m ≤ F/6 holds by another argument is open; §3 below proves a different area bound.)

**(2) 114/115/118_LOG, "unsigned resolution bound |S| ≤ 2^{N₄+χ_max} ≤ 4·2^{N₄} + a contact-density lemma
N₄ ≤ F/k": THE BOUND IS RIGHT ON MULTIPLICITIES 2 AND 4 AND IS SHARPENED AND COMPLETED BELOW (§3, Lemmas R, M, E, S).**
The resolution formula gives |S| ≤ (2/3)^{N₄}·3^{N₄}·2^{χ_max} on 2/4 multiplicities; a six-fold link resolves into 15
pairings at weight 1/3 (Lemma R), a factor 5, so the naive extension is 5^{N₆}. §3 replaces both: Lemma M gives
|S| ≤ 4·2^{b₁(G)+N₆} for EVERY multiplicity (forest links free, six-fold links cut, not resolved; sharpened in §3b to
4·2^{b₁(G)+b₁(G₆)}), and Lemma E proves the density inequality b₁(G) + N₆ ≤ (5/8)F + 5/2 (and in §3b
b₁(G) + b₁(G₆) ≤ (7/12)F + 7/3) from Z₂-minimality alone (an Euler-characteristic identity) — the k ≥ 2 the readers
asked for is not what minimality gives by local counting (N₄ ≤ (2F + 8)/3 is, k = 3/2), and it is not needed: what the
certificate needs is the exponent of Lemma M′, and 7/12 is what minimality gives it. With the spin sum (Lemma S) this is
a proof, and its unconditional β* is computed in §4.

**(3) 116_LOG, "|S| ≤ 8 on every unicyclic leaf": THE RECORD'S OWN STATEMENT, VERIFIED (§5).** S1's CORRECTION (7)
and THEOREM S12-c′ CORRECTED already state it (8 only at the (3,3) disc pair on an all-six-fold cycle). The exhaustive
winding table is re-derived in §5. It leaves cycle rank ≥ 2 with no constant bound, so it is not by itself an
unconditional route: the tail8 floor stays conditional exactly as S1's last (p) entry says. "Cycle rank 2 is a finite
table" is right in principle (two chords, each in at most six passages, so the words have total length ≤ 12), but every
rank needs its own table and no table bounds all ranks; Lemma M is the uniform statement.

**(4) 124_LOG item 287, "the pair moment, |W_½| ≤ 4^{J−p}u^F M_p": §18's MECHANISM, NOT A PROOF BEYOND §18.** Its
hypothesis (every separating curve contributes two boundary circles carrying w and w⁻¹) is the statement that every
component of the sheet's contact preimage Ĝ is a cycle or a slit — §18's own class, where S12 is proved; the item itself
says it "must be re-derived where a separating curve meets other edges of Ĝ", which is exactly the open remainder.
Where it holds it returns 4^{J−p}M_p, which exceeds 4 whenever J − p ≥ 2 or M_p > 1 (its own 8u^F example is a
composite). It is a correct reorganisation of the proved class and adds no new class.

---------------------------------------------------------------------------------------------------------------
## 3. A PROOF OF A TAIL ACTIVITY FOR EVERY Z₂-MINIMAL LEAF, WITH NO STAKE (Lemmas R, M, E, S)

Notation: X a Z₂-minimal plaquette set (every link of even multiplicity m_ℓ ∈ {2,4,6}; no proper nonempty closed
subset), F = |X|, N_k = number of links of multiplicity k, G the contact graph (links with m ≥ 4), b₁(G) its cycle rank,
c_G its components, V_G its vertices, X_cut = X cut along G, m its pieces. S(X) := W_½(X)/u^F.

**Lemma R (the resolution formula with its sign made local).** S(X) = (2/3)^{N₄}(1/3)^{N₆} Σ_ρ (−2)^{χ(T_ρ)}, the sum
over the 3^{N₄}·15^{N₆} resolutions ρ (a perfect matching of the passages at each contact link), T_ρ the closed surface
it produces.
*Proof.* At a 2n-fold link the Haar operator ∫U^{⊗2n} is the orthogonal projection onto Inv(V_½^{⊗2n}). The operator
Σ_π |ε_π⟩⟨ε_π| over the (2n−1)!! pairings is S_{2n}-invariant and supported on Inv, which is the irreducible S_{2n}-module
S_{(n,n)}; by Schur it is c_n·P_Inv with c_n = (2n−1)!!·2^n/C_n (trace: each ‖ε_π‖² = 2^n; dim Inv = C_n, the Catalan
number): c₂ = 6 (Creutz), c₃ = 24. In units of the two-plaquette link integral ½εε, P_Inv = (C_n/(2n−1)!!)·Σ_π Π_pairs:
2/3 at n = 2, 1/3 at n = 3. An inverse passage carries ε-conjugation on its external indices only (S1 (p)), so every
term is the Haar weight of the abstract closed surface T_ρ, which by S1 (n) is (−1)^{m(T)}2^{χ(T)−F}, m the cross-cap
count. A connected orientable surface has m = 0 and χ even; a non-orientable one has m = 2 − χ ≡ χ (mod 2); so
(−1)^{m}2^{χ} = (−2)^{χ} in every case, and on a disconnected T the factors multiply. ∎ (Check: the census pinch's three
resolutions, two spheres and RP², give (2/3)(4 + 4 − 2) = 4, S1 (p)'s value.)

**Lemma M (every contact leaf, every multiplicity).** For every Z₂-minimal X:  |S(X)| ≤ 4·2^{b₁(G) + N₆}.
*Proof.* (i) Choose a spanning forest F₆ of G₆ (the six-fold links) and extend it to a spanning forest T of G. Resolve
every four-fold link of G not in T (the "four-fold chords", r₄ of them) by Creutz, weight 2/3 over three pairings; leave
T and G₆ unresolved. Each resolution ρ gives an abstract complex Y_ρ whose links of multiplicity ≥ 4 are T ∪ G₆.
(ii) S11 on Y_ρ: cut Y_ρ along T ∪ G₆; every remaining link (genuine 2-links, resolved pairs) has exactly two
plaquettes, so each piece is a surface with boundary integrating to ±2^{χ(P)−|P|}Π_b χ_½(z_b) (S1 (n): magnitude
orientation-free); |χ_½| ≤ 2 gives |S(Y_ρ)| ≤ 2^{χ(Ŷ_ρ)} ≤ 4^{c(Ŷ_ρ)}, c the number of pieces.
(iii) c(Ŷ_ρ) ≤ 1 + b₁(G₆). A union Q of pieces of Y_ρ has even multiplicity at 2-links and at resolved links (whole pairs)
and its Z₂-boundary is supported on T ∪ G₆; if that boundary vanishes, Q is a closed plaquette subset of X, so Q ∈ {∅, X}
by minimality. Hence the boundary map Z₂^{pieces} → Z₁(T ∪ G₆; Z₂) has kernel {0, all} and c − 1 ≤ b₁(T ∪ G₆).
T ∪ G₆ = T ∪ (G₆ ∖ F₆) with T a forest, so b₁(T ∪ G₆) ≤ |G₆ ∖ F₆| = b₁(G₆).
(iv) |S(X)| ≤ (2/3)^{r₄}·3^{r₄}·4^{1+b₁(G₆)} = 4·2^{r₄ + 2b₁(G₆)}, and r₄ + 2b₁(G₆) = (N₄ − |T ∖ F₆|) + 2(N₆ − |F₆|)
= N₄ + 2N₆ − |T| − |F₆| ≤ (N₄ + N₆ − |T|) + N₆ = b₁(G) + N₆, since |T| = V_G − c_G. ∎
(Sharp on the census: a forest G gives 4, Lemma S6's value. It improves the relayed 4·2^{N₄} by the forest links, and
replaces the naive 5 per six-fold link by 2 per six-fold link plus its share of b₁.)

**Lemma E (the contact density of a minimal set).** For every Z₂-minimal X:
  (E1) V_X = F − N₄ − 2N₆ + 2 − b₁(X; Z₂)   (an identity; V_X = lattice vertices of X);
  (E2) N₄ + 2N₆ ≤ (2F + 8)/3;   (E3) b₁(G) + N₆ ≤ (5/8)F + 5/2.
*Proof.* (E1) As a 2-complex X has b₀ = 1 (a minimal set is link-connected: a link-disjoint split would make each part
closed) and b₂(X; Z₂) = dim{closed subsets} = 1 (only ∅ and X). So χ(X) = V_X − |L(X)| + F = 2 − b₁(X). Counting
link–plaquette incidences, 2N₂ + 4N₄ + 6N₆ = 4F, so |L(X)| = N₂ + N₄ + N₆ = 2F − N₄ − 2N₆. Substitute.
(E2) A lattice vertex has eight incident links, so a_v (links of X at v) ≤ 8 and V_X ≥ Σ_v a_v/8 = 2|L(X)|/8 =
(4F − 2N₄ − 4N₆)/8. With (E1) and b₁(X) ≥ 0: F − N + 2 ≥ F/2 − N/4 (N := N₄ + 2N₆), i.e. N ≤ (2F + 8)/3.
(E3) Q := b₁(G) + N₆ = N − V_G + c_G ≤ (F + 2 − V_X) − V_G + c_G by (E1). Each component of G has an edge, so c_G ≤ V_G/2,
and Q ≤ F + 2 − V_nonG − (3/2)V_G. With a_v ≤ 8 at every vertex and a_v ≥ (contact degree) on G:
V_nonG + (3/2)V_G ≥ Σ_v a_v/8 + Σ_{v∈G} a_v/16 ≥ |L(X)|/4 + (2N_c)/16 = (2F − N₄ − 2N₆)/4 + (N₄ + N₆)/8.
So Q ≤ F/2 + 2 + N₄/8 + 3N₆/8 ≤ F/2 + 2 + (3/16)N ≤ F/2 + 2 + (2F + 8)/16 = (5/8)F + 5/2 by (E2). ∎

**Lemma S (all spin assignments of a leaf).** Let δ₁ := Σ_{j ≥ 3/2, half-integer} (d_j/2)²(16 a_j/u) and
ε₁ := Σ_{j ≥ 1, integer} (d_j/2)²(a_j/u). For every Z₂-minimal X with |X| = F, the total weight over all admissible
spin assignments obeys
  Σ_spins |W(X)| ≤ 4u^F·[ (1+δ₁)·(2(1+δ₁))^{b₁(G)+N₆} + 4^{b₁(G)}·ε₁^F ].
*Proof.* (a) A piece of X_cut carries one spin (at a 2-link the two plaquettes' spins must agree). (b) PARITY: under the
centre U_ℓ → −U_ℓ on the contact links a piece P at spin j_P picks up (−1)^{2j_P·O_P}, O_P its odd-set; Haar invariance
kills the assignment unless Σ_{P : 2j_P odd} O_P = 0, so by minimality the half-integer pieces are all or none.
(c) ALL INTEGER: S11 at mixed spins (cut along G; a piece at spin j integrates to ±d_j^{χ(P)−|P|}Π_bχ_j(z_b); |χ_j| ≤ d_j)
gives |W| ≤ Π_P a_{j_P}^{|P|} d_{j_P}^{χ(P̂)} ≤ u^F 2^{χ(X̂)} Π_P (d_{j_P}/2)²(a_{j_P}/u)^{|P|}; summing each j_P over the
integers ≥ 1, Σ_j (d_j/2)²(a_j/u)^n ≤ ε₁^n (coefficients ≥ 1), so ≤ u^F 4^m ε₁^F with m ≤ 1 + b₁(G) (Lemma M (iii)'s rank
argument with T ∪ G₆ replaced by G). (d) ALL HALF-INTEGER, raised set A (pieces at j ≥ 3/2): run Lemma M's proof with
the four-fold chords TOUCHED by A (a passage of a piece of A) cut instead of resolved. Each raised piece is then a piece by
itself; c − 1 ≤ b₁(T ∪ G₆ ∪ touched) ≤ b₁(G₆) + #(touched chords); each touched chord costs 4/2 = 2 against Lemma M;
a piece P touches at most 4|P| links; each component at spin j contributes d_j^{χ(Ĉ)} ≤ d_j². So
|W_A| ≤ 4·2^{b₁(G)+N₆}u^F·Π_{P∈A}[2^{4|P|}(d_{j_P}/2)²(a_{j_P}/u)^{|P|}]. Summing over A and the raised spins:
4·2^{b₁(G)+N₆}u^F Π_P(1 + δ''(|P|)), δ''(n) := Σ_{j≥3/2}(d_j/2)²(16a_j/u)^n ≤ δ₁ (16a_j/u < 1). There are m ≤ 1 + b₁(G)
pieces, so Π_P(1 + δ''(|P|)) ≤ (1+δ₁)^{1+b₁(G)} ≤ (1+δ₁)^{1 + b₁(G) + N₆}. ∎

**Corollary U (the unconditional tail activity).** With Lemma E (E3), every Z₂-minimal leaf of size F carries, over
all spins and before decoration,
  Σ_spins |W(X)| ≤ 4u^F [ C₁K₁^F + C_I K_I^F ],  K₁ = (2(1+δ₁))^{5/8}, C₁ = (1+δ₁)(2(1+δ₁))^{5/2},
                                                   K_I = 2^{5/4} ε₁,       C_I = 2⁵,
covering surfaces and every contact leaf alike (for m = 1 leaves the record's 4σ(F) is smaller). Fed to Corollary T3's
tail with σ(F₀+2) kept (≥ 1, conservative), the certificate's tail becomes
  3·(4/25)·σ(F₀+2)·[ C₁(rK₁)^{F₀+2}/(1−(rK₁)²) + C_I(rK_I)^{F₀+2}/(1−(rK_I)²) ],
and the enumerated sum (F ≤ F₀, every leaf a forest-contact leaf or a surface, so m = 1 and the record's per-leaf
activities are proved: S2, S6, S11) is unchanged except that the census contact leaves get their σ(F) (the record's
engine writes 4·N_c(F) without it — an omission of order 10⁻¹⁹ relative, corrected in the M1 mode).
WHAT THIS DOES NOT TOUCH: the dressing (z₁, z_surf, z_br through the table, the neck factor) and the composite tree
(κ_T = 4) are the record's, signed as S1 §25 (i) lists; Corollary U replaces only the staked tail activity.

**STAKES for the unconditional run (written before `kp_cert_m1.awk` has a line of UNCOND mode):**
- (U-a) δ₁ at β = 0.30 is ≈ 0.12 and K₁ ≈ 1.655; at 0.35, δ₁ ≈ 0.16, K₁ ≈ 1.69.
- (U-b) The unconditional β*_u (page, F₀ = 22, table mode, the 2·10⁻⁴ grid) ∈ [0.29, 0.35]; tree within +0.01 of it.
- (U-c) The failure above β*_u is the tail (rK₁ near 0.7–0.8), never the dressing.
- (U-d) β*_u > 0.2452: Theorem 8.9 then holds unconditionally on a range strictly past Theorem 8.7's, by the record's
  accounting (S12 its one staked input) with that input replaced by Corollary U.

**RESULTS (U-stakes read, 2026-11-02 05:2x; records `ua_points.txt`, `uc_points.txt`, `scan_unc_page_F2*.txt`):**
(U-a) HELD — δ₁ = 0.11984, K₁ = 1.65526 at β = 0.30; δ₁ = 0.16304, K₁ = 1.69489 at 0.35 (page, F₀ = 22, the engine's
rounded-up constants). (U-b) HELD on its page clause — β*_u = 0.3246 (page, F₀ = 22) ∈ [0.29, 0.35]; the tree clause
UNREAD for 5/8: its scan was stopped by hand at 75 min, superseded by Corollary U′ (§3b), whose tree scan reads it.
(U-c) HELD — at the first failing point β = 0.3248 the tail is 0.0045703 of the left side's 0.0045911 (99.5 %), the
enumerated sum with its dressing 0.0000208, rK₁ = 0.7285. (U-d) HELD — 0.3246 > 0.2452, and under the record's own tail
(UNCREC: no T1, no T2) the number is 0.2916 (`scan_uncrec_page_F20.txt`), also past 0.2452.

## 5. ROUTE (3) CHECKED: the unicyclic winding table, exhaustive

STAKE (written before `winding_table.awk` ran): MU = 4 gives max 4 (CORRECTION (7)); MU = 6 gives max 8, only at (3,3); the (2,2,2) system (which would read 6) is excluded by the odd-piece parity.

RESULT (records `winding_MU4.txt`, `winding_MU6.txt`; the KAT line first): STAKE HELD in every clause. MU = 4: every admissible two-piece system bounded by 4 — (1,1) 4, (1,3) 4, (1,1,1,1) 2, (1,1,2) 0. MU = 6: the maximum is 8, at (3,3) only (J = ∫χ_½(U³)² = 2); the next are (1,1) and (1,3) at 4, then (1,1,4) and (1,2,3) at 2; (2,2,2) never appears (two odd pieces cannot be built from three even windings). So route (3)'s statement is the record's and is verified: |S| ≤ 8 on every unicyclic Z₂-minimal leaf, 4 whenever the cycle has a four-fold link (choose it as the chord), 8 only at a disc pair each winding three times round an all-six-fold cycle. It closes nothing at cycle rank ≥ 2.


## 6. THE EXIT BUDGET IN THE TABLE MODE OF RECORD (the brief's request; the far shore §10's ε(β) was the sub-gas mode's)

Definition as the far shore's: ε(β) = the largest tilt t with a certified PASS at α = 1/1000, every a_j multiplied by e^t in
directed rounding (the engine's TILT mode), F₀ = 20, page dressing, TABLE mode (LOCAL=1, R2TAB = tag g). Bisection on the
grid 10⁻³ (valid: the left side increases in every a_j). Driver `exitbudget.sh`; records `exitbudget_table_page_rec.txt`
(the record's tail) and `exitbudget_table_page_even.txt` (Corollary T3's tail). NCSIG=1 in both (moves no digit).

| β | far shore §10 (sub-gas mode) | TABLE mode, record's tail | TABLE mode, sharpened tail (T1, T2) |
|---|---|---|---|
| 0.05 | 2.32 | [2.324, 2.325) | [2.420, 2.421) |
| 0.10 | 1.62 | [1.624, 1.625) | [1.718, 1.719) |
| 0.15 | 1.21 | [1.210, 1.211) | [1.303, 1.304) |
| 0.20 | 0.91 | [0.913, 0.914) | [1.004, 1.005) |
| 0.25 | 0.68 | [0.679, 0.680) | [0.769, 0.770) |
| 0.30 | 0.49 | [0.485, 0.486) | [0.573, 0.574) |
| 0.35 | 0.33 | [0.318, 0.319) | [0.403, 0.404) |
| 0.40 | 0.19 | [0.170, 0.171) | [0.252, 0.253) |
| 0.45 | 0.06 | [0.036, 0.037) | [0.114, 0.115) |
| 0.4764 | 0.00 | NO PASS at tilt 0 | [0.045, 0.046) |
| 0.50 | — | NO PASS at tilt 0 | NO PASS at tilt 0 |

READING. (i) The far shore's table is CORRECTED by the table mode of record: equal to the grid digit to β = 0.30, smaller
from 0.35 on (0.318 against 0.33, 0.170 against 0.19, 0.036 against 0.06), and at the number of record itself the table
mode does not pass at α = 10⁻³ at all (it passes there only for α ∈ [0.0041, 0.0047]); the far shore's "0.00" was the
sub-gas mode's reading, not the table mode's. (ii) The sharpened tail raises every entry by 0.08–0.10 and makes the budget
positive at 0.4764 (0.045). (iii) In the rank-in-area form the brief stated (|S| ≤ 4^{r+1}, r ≤ F/c, absorbed where
ε(β) ≥ ln 4/c): with the record's tail the thresholds read c ≥ 2.86 (0.30), 4.36 (0.35), 8.15 (0.40), 38.5 (0.45);
with the sharpened tail 2.42, 3.44, 5.50, 12.2 and 30.8 at 0.4764. Lemma M′ + E is the stronger form of that route (its
all-½ rate is 2^{7/12} per plaquette, the equivalent of c = 24/7 ≈ 3.43 in the 4^r language; 2^{5/8}, c = 3.2, with
(E3)), and §4 runs it through the tail directly
rather than through a uniform tilt of every activity, which the exit budget charges and Corollary U does not need.

## 2b. THE COORDINATOR'S CORRECTION (S1's last (p) entry: the ceiling 4^{r+1} alone gives ≈ 0.24) — ANSWERED

The correction is right about S11's ceiling and is exactly why §3 does not use it: what earns a number above 0.2452 is a
lemma tying the multiplicity factor to the area, and Lemma E IS that lemma, proved from Z₂-minimality alone over all of
ℤ⁴ (no box, no seed, no multiplicity cap — six-fold links included), with explicit constants:

  (E2)  N₄ + 2N₆ ≤ (2F + 8)/3                 — the contact-density lemma "N₄ ≤ F/k" at k = 3/2;
  (E3)  b₁(G) + N₆ ≤ (5/8)F + 5/2             — the exponent Lemma M needs;
  (E3′) b₁(G) ≤ (7/12)F + 7/3                 — from (E3)'s middle line, b₁(G) ≤ F/2 + 2 + N₄/8 − 5N₆/8 ≤ F/2 + 2 + N₄/8,
                                                 and (E2); hence F_min(r) ≥ (12/7)r − 4 and, since m − 1 ≤ b₁(G),
                                                 F_min(m) ≥ (12/7)(m − 1) − 4 — the 146_LOG form with c = 12/7.

Which multiplicity factor the area pays for matters more than the constant: S11's ceiling 4^m with (E3′) gives the per-
plaquette rate 4^{7/12} = 2.245 (2.26 with its spin sum, where S11 cuts every contact link so a raised piece costs only
δ₁/16); Lemma M lowers the base to 2 per unit of b₁(G) + N₆, and with (E3) the rate is 2^{5/8}·(1+δ₁)^{5/8} ≈ 1.66–1.70
at β ≈ 0.30–0.35. The tail closes only where r·(rate) < 1, so the base is the lever, not the constant.
MEASURED (UNCREC mode: Corollary U's activity under the record's OWN tail, N(F) ≤ 5^{F−1} at every F, no T1, T2): page,
F₀ = 20: PASS at β = 0.2800 (α = 0.002: LHS 0.0009286), FAIL at 0.3000 — so the density lemma alone already carries
Theorem 8.9 past 0.2452 unconditionally; the scan `scan_uncrec_page_F20.txt` pins the number (§4b). With T1 and T2 the
number is §4b's β*_u.

What the record's boxes hold for F_min (the coordinator's last question): upper bounds by construction only — r = 1 at
F = 138 (Object A) and 362 (Object D, sphere sheet), r = 2 at F = 290 (Object C); and the box censuses (F ≤ 26–28, link
multiplicity capped at 4, corner seeds) found no minimal leaf with a lattice contact cycle, which is evidence and not a
lower bound over ℤ⁴. (E3′) is the only lower bound in hand, and it is linear in r with no box.

## 3b. THE SHARPER EXPONENT (found re-reading Lemma M's own proof, 2026-11-02 05:xx)

**Lemma M′.** For every Z₂-minimal X: |S(X)| ≤ 4·2^{b₁(G) + b₁(G₆)}.
*Proof.* Lemma M (iv) computes the exponent r₄ + 2b₁(G₆) = N₄ + 2N₆ − |T| − |F₆|, and b₁(G) + b₁(G₆) = (N₄ + N₆ − |T|) +
(N₆ − |F₆|) is the same number; Lemma M stated only the upper bound b₁(G) + N₆. ∎ (Lemma S (d) runs verbatim with this
exponent: each touched chord still costs 2.)

**(E3″) b₁(G) + b₁(G₆) ≤ (7/12)F + 7/3.**
*Proof.* (E3)'s chain gives b₁(G) + N₆ ≤ F/2 + 2 + N₄/8 + 3N₆/8, so b₁(G) ≤ F/2 + 2 + N₄/8 − 5N₆/8. A vertex carries at most
eight six-fold links, so V(G₆) ≥ N₆/4; each component of G₆ has two vertices at least, so c(G₆) ≤ V(G₆)/2 and
b₁(G₆) = N₆ − V(G₆) + c(G₆) ≤ N₆ − V(G₆)/2 ≤ (7/8)N₆. Adding: b₁(G) + b₁(G₆) ≤ F/2 + 2 + N₄/8 + N₆/4
= F/2 + 2 + (N₄ + 2N₆)/8 ≤ F/2 + 2 + (2F + 8)/24 = (7/12)F + 7/3 by (E2). ∎
The worst case of (E3) (every contact six-fold, N₆ = (F + 4)/3) is exactly where b₁(G₆) is far below N₆; the sharper count
removes it.

**Corollary U′.** In Corollary U replace 5/8 by 7/12 throughout: Σ_spins |W(X)| ≤ 4u^F[C₁′K₁′^F + C_I′K_I′^F] with
K₁′ = (2(1+δ₁))^{7/12}, C₁′ = (1+δ₁)(2(1+δ₁))^{7/3}, K_I′ = 2^{7/6}ε₁, C_I′ = 2^{14/3}. (Lemma S's half-integer part:
2^{b₁(G)+b₁(G₆)}(1+δ₁)^{1+b₁(G)} ≤ (1+δ₁)(2(1+δ₁))^{(7/12)F + 7/3}, both exponents bounded by (E3″) and (E3′); the integer
part 4^{b₁(G)} ≤ 4^{(7/12)F + 7/3} by (E3′).) Engine flag U712=1 (control unmoved; md5 854dc6fc… from here).
First points (page, F₀ = 22): δ₁ = 0.13633, K₁′ = 1.61428, C₁′ = 7.7165 at β = 0.32; β = 0.33 PASS at α = 0.005
(LHS 0.0030943); β = 0.34 FAIL at α = 0.003, 0.005, 0.008.

**STAKE (before the U712 scans):** β*_u (page, F₀ = 22) ∈ [0.3300, 0.3400); tree within +0.008 of it; page F₀ = 20 within
0.004 below the page F₀ = 22 value.

**RESULTS (2026-11-02 05:1x–05:2x; engine md5 854dc6fc…, records `scan_u712_page_F22.txt`, `scan_u712_page_F20.txt`,
`uc_points.txt`):** page F₀ = 22: β*_u = **0.3348** (α ∈ [0.0043, 0.0047]; refused at 0.3350, where the tail is 0.0045596
of 0.0045851, rK₁′ = 0.7315) — HELD. Page F₀ = 20: β*_u = 0.3280 (α ∈ [0.0042, 0.0058]), 0.0068 below — the clause
"within 0.004" REFUTED (the 5/8 pair reads the same gap: 0.3246 against 0.3180, 0.0066); the two extra levels of the
exact census are worth 0.007 in β, not 0.004. Tree clause: β*_u = 0.3350 (tree, F₀ = 22; α ∈ [0.0038, 0.0054]; refused at
0.3352; `scan_u712_tree_F22.txt`, 06:08) — HELD (+0.0002: the tail carries the left side, so the dressing barely moves it).

## 7. A SECOND UNIFORM ROAD MEASURED: Theorem V + the Euler identity (and why Lemma M + E is the better one)

Theorem V at spin ½ (S1 §23 (i), signed) and Lemma E (E1) give, for every Z₂-minimal X,
|S(X)| ≤ 2^{V_X − F}Π_v e_v = 2^{2 − b₁(X) − N₄ − 2N₆}Π_v e_v ≤ 4·Π_v ẽ_v,  ẽ_v := e_v·2^{−n₄(v)/2 − n₆(v)},
with e_v² = S_½(G_v)/2^{2−d_v} the even-star excess of S1 §27 and n₄(v), n₆(v) the four- and six-fold half-axes at v (each
contact link's 2^{−1} or 2^{−2} split between its two ends). Since Σ_v d_v = 4F, the per-plaquette rate is
max_G (ẽ(G)²)^{2/|E(G)|} over the 560 orbits of even stars of K_{2,2,2,2}. Read on the record's table
(`even_stars.table.2026-11-01a.txt`, exact e²): the maximum is 2^{2/3} = 1.5874, attained at the vertex pinch (two disjoint
triangles, e = 2, no contact) and at the pinch-plus-pinch star (deg 42222222, e² = 16); then 1.5157 (deg 42422222), 1.486,
1.414, and the full K_{2,2,2,2} at 1.3851. The vertex pinches are paid by b₁(X), which this simple form drops; with b₁(X)
kept the identity b₁(X) + N₄ + 2N₆ = b₁(Σ) + Σ_v(u_v(Σ) − 1) (any resolution Σ) moves the discount onto umbrella counts of a
global sheet, which need not be locally maximal — so this road gives 2^{2/3} uniformly, where Lemma M′ + (E3″) gives
2^{7/12} = 1.4983 on the all-½ part (2^{5/8} = 1.5422 with (E3)). Lemma M′ + E is the road of record here; the even-star
table is the alphabet a sharper density lemma would be written in.

## 8. THE PRECISE NEXT OBJECTS (each with the instrument that decides it)

1. **THE CONTACT-DENSITY LEMMA, SHARPER THAN 7/12.** Corollary U′'s rate is K₁′ = (2(1+δ₁))^{7/12}; the 7/12 comes only
   from a_v ≤ 8 (eight links, and so at most eight six-fold links, at a lattice vertex) inside the exact identity
   Σ_v(a_v − 4) = 2(N₄ + 2N₆) + 4b₁(X) − 8 (Lemma E's discrete Gauss–Bonnet: contacts are paid by excess half-axes exactly
   as curvature by saddles). The densest family I can describe — a planar k × k grid R of one-plaquette pieces, every link
   of R four-fold, and one further piece Y carrying two fins on every link of R (rank of the odd-sets k², so minimal if Y
   closes into one piece without new contacts; a sketch, NOT built) — has b₁(G) = k² against F ≳ 7k², ratio ≈ 1/7. A
   lemma b₁(G) + b₁(G₆) ≤ F/c + O(1) at c = 4 moves K₁′ to 2^{1/4}(1+δ₁)^{1/4} ≈ 1.22, ln K₁′ ≈ 0.20, which §6's certified
   sharpened-tail budget column admits to about β = 0.42 (a projection read off that column, which tilts every activity
   and so under-reads a tail-only factor; the lemma, once proved, is run through UNCOND mode with its own constants). The object: show that a vertex of excess a_v − 4 ≥ 1 forces excess-deficit vertices
   (a_v = 3, the cube corners) or b₁(X) within a bounded neighbourhood — Gauss–Bonnet made local.

   **PROPOSITION LP (7/12 IS EXACTLY WHERE VERTEX-LOCAL COUNTING STOPS).** Let t range over the even stars of K_{2,2,2,2}
   (a_t links, d_t plaquettes, n₄, n₆), K_t := d_t − 2a_t + 4 (so Σ_v K_v = 4(N + V_X − F) = 8 − 4b₁(X) ≤ 8 by (E1)) and
   β_t := (n₄ + 2n₆)/2 − ([n₄+n₆ ≥ 1] + [n₆ ≥ 1])/2 (so b₁(G) + b₁(G₆) ≤ Σ_v β_v, from c ≤ V/2 for G and G₆). The linear
   program  max Σ_t β_t x_t  s.t.  Σ_t (d_t/4)x_t = F,  Σ_t K_t x_t ≤ 8,  x ≥ 0  has value exactly (7/12)F + 7/3 as F → ∞
   in its rate: DUAL (y, λ) = (7/12, 7/24) is feasible iff d_t/16 + a_t/12 ≤ 7/6 + ([n₄+n₆ ≥ 1] + [n₆ ≥ 1])/2 for every t,
   which holds by cases (no contact: d = a ≤ 8; contact, no six-fold: d ≤ 2a ≤ 16; six-fold: d ≤ 24, a ≤ 8), and weak
   duality is (E3″) itself. PRIMAL points attaining the rate 7/12: the full star (a = 8, d = 24, K = 12, β = 7) with three
   octagon saddles (a = d = 8, K = −4, β = 0) — F = 12 per block, β = 7; or a four-regular all-four-fold star (d = 16,
   K = 4, β = 7/2) with one octagon saddle. So c = 12/7 is the largest constant ANY argument confined to vertex stars,
   the Euler identity and c ≤ V/2 can give. Neither primal point is a minimal set: a full star's eight neighbours all
   carry its six-fold links, so a positive-density set of full stars fills a four-dimensional region, which contains
   the six faces of a unit 3-cube — a closed proper subset, forbidden by minimality. THE MISSING CONSTRAINT IS THE CUBE:
   no 3-cube has all six faces in a minimal X ≠ ∂c. A discharging argument on 3-cubes (each cube with k ≤ 5 faces in X
   charged to its vertices) is the instrument for c > 12/7; the §8 (1) sketch suggests the truth is no larger than ≈ 7.
   [CORRECTED 2026-11-02 06:3x, see §13: "THE MISSING CONSTRAINT IS THE CUBE" is wrong as the FIRST missing constraint —
   the lattice's own boundary (E ≤ 4V − 4 per component of a finite subgraph of ℤ⁴, which c ≤ V/2 does not see) already
   moves 7/12 to 1/2 (Lemma E4, Corollary U″); the cube is the next constraint after it. The LP statement itself stands.]
   STAKE (before the table check `lp_check.awk` runs): over the record's 560 orbits the dual inequality holds at every
   orbit, with equality exactly at the spanning 2-regular stars (a = d = 8), the spanning 4-regular all-four-fold stars
   (d = 16) and the full star (d = 24), and nowhere else.
   RESULT (`lp_check.txt`, 2026-11-02 05:31; the table's md5 ac52a7d2…): STAKE HELD — 559 nonempty orbits (131,071 stars
   = 2¹⁷ − 1; degree sums and the identity d = a + n₄ + 2n₆ checked on every row), 0 violations; equality at exactly 25
   orbits (2,071 stars): the 12 spanning 2-regular orbits (1,035 stars), the 12 spanning 4-regular all-four-fold orbits
   (1,035 stars — their complements in K_{2,2,2,2}, the count equal by complementation) and the full star; every other
   orbit has slack ≥ 3/48. Two roads (the case analysis by hand, the table by machine) agree.
   THE PRICE OF THE NEXT OBJECT (a PROJECTION, labelled as one; not a theorem): if b₁(G) + b₁(G₆) ≤ F/4 + 7/3 were
   proved, Corollary U′'s factors would read K₁ = B^{1/4}, C₁ = (1+δ₁)B^{7/3}, B = 2(1+δ₁); for β ≤ 0.43 (δ₁ ≤ 0.25)
   these are below K = 1.26 and C = 11, run as tail-only factors (TKN/TKD = 63/50, TCN/TCD = 11/1, page, F₀ = 22).
   STAKE (before `scan_proj_c4_page_F22.txt` runs): β_proj ∈ [0.40, 0.44].
2. **THE DRESSING OF A CONTACT REST.** The record dresses every leaf with the same κ (the census contact leaves at F = 18–22
   in its own 0.4764 included); the joint decoration bound behind κ (S8, S9, S13, Theorem L) is proved for a branch-free
   rest. A contact rest needs it too: resolve the rest's contact links that no decoration touches (each term a closed
   surface where Theorem L applies, with the doubled stars at contact vertices as new table rows), cut the touched ones
   (Lemma S (d)'s accounting). This item conditions the record's conditional number and §4's S12-free number alike.
   The same rows are owed for a VERTEX-PINCHED branch-free rest (two umbrellas at one lattice vertex, allowed in the
   census): Theorem L's general form covers it (S1 §24, 21:53), but its table θ(k) enumerates single-cycle sheet stars
   only. FIRST KNOWN ANSWER OF THE NEW ROWS (a desk computation, M1): the two disjoint spin-½ triangles (+1,+2,+3) and
   (−1,−2,−3) at one vertex, bridged by two spin-1 walls (+1,−2), (+2,−1). Integrating each triangle's free vertex leaves
   χ_½(x)²/2 and χ_½(w)²/2 (x = U₊₂ with U₊₁ = 1, w = U₋₁⁻¹U₋₂), the two bridges convolve to χ₁(wx)/3, and with
   χ_½² = 1 + χ₁ only the χ₁χ₁χ₁ term survives: S = (1/12)·∫χ₁(x)χ₁(w)χ₁(wx) = (1/12)(1/3) = 1/36, against
   S(A)S(B) = 1/4: r_v² = 1/9, per corner 0.577 — under θ. A single bridging wall gives 0 (each triangle's integral is
   constant in its marked vertex). One instance, not a lemma; the multi-cycle table is the object.
3. **S12 ITSELF (|S| ≤ 4, or 8 with the triple-winding pair).** Lemma R makes it a statement about one tensor network:
   bond dimension 2 (C₂) at every four-fold link, 5 (C₃) at every six-fold link, vertex tensors (−2)^{umbrellas}. Lemma M is
   the bond-dimension bound; S12 is the statement that this network contracts to at most its sheet value. The local
   computation of §3's discussion (one chord, everything else fixed: ratio 1 in the arc types 0 and 2, 2 in the type-4 Klein
   and 3-cycle types, 0 in the others) says exactly where the factor 2 per chord comes from; the next object is an
   ordering of the chords in which no chord is met in a type-4 configuration, or the proof that such configurations carry a
   compensating genus.
4. **THE TAIL COUNT BELOW 5 PER PLAQUETTE.** T2's anchor at depth F − 2 generalises: N(F) ≤ A(d)·5^{F−2−d}, A(d) the exact
   number of depth-d nodes of Lemma P's odd-rule tree (no refusal there: every non-closed node has 5, 3 or 1 children), a
   C enumeration of about 5^d nodes; it moves the conditional and the unconditional number together.

## 9. THE UNIFICATION (the operator's standing question: where else do these pieces live)

- **Lemma R is Penrose's binor calculus.** Every resolution term of an SU(2) spin-½ contact leaf is (−2)^{χ(T)}: the
  Frobenius–Schur sign of a non-orientable resolution (S1 (n)) and the 2^χ of a surface are one rule, loop fugacity −2 —
  the "negative dimension" of the fundamental (SU(2) ≅ Sp(1), Sp(2n) ↔ SO(−2n)), the Temperley–Lieb algebra at δ = −2,
  q = −1. The contact link is a Temperley–Lieb bond of dimension C_n (2 at four-fold, 5 at six-fold); Lemma M's per-chord
  factor is that dimension. The O(n) loop model at n = −2 is the free-fermion / spanning-tree point (Kirchhoff; one complex
  Grassmann pair per loop): THE BIGGER CLUE is that S(X) may admit a Grassmann–Gaussian (determinantal) representation on
  the corner graph of X, in which case Hadamard's inequality is the uniform route to S12 — the first test is whether the
  three-pairing weight (2/3, 2/3, 2/3) with the binor relation satisfies the free-fermion condition at a four-valent node.
- **T2 is the polygon–walk relation of self-avoiding-walk theory** (a polygon is a walk whose last step is forced;
  Hammersley's bound on polygons by walks one step shorter), lifted from loops to surfaces: a closed set is a node of the
  closing tree whose last plaquette is forced by its odd links. T1 is the homological parity of Z₂ 2-cycles in an acyclic
  complex. Both classical in kind (W = 0); the earning is their effect on the certified number: the tail falls twelvefold.
- **Lemma E is discrete Gauss–Bonnet for a 2-complex**, Σ_v(a_v − 4) = 2(N₄ + 2N₆) + 4b₁(X) − 8: on a surface the excess is
  curvature and is paid by topology; on a minimal flux complex the same excess pays for the self-contacts. The contact
  density of a minimal flux surface is therefore a curvature budget — the same budget the gas's action ΣK² (ΤΟΝΟΣ) and
  Gauss–Bonnet deficits (ΜΕΤΑΠΛΑΣΙΣ) already carry on the surfaces.

## 10. A1 BY FROBENIUS–SCHUR: THE RECORD'S (G2′), RE-DERIVED AND CHECKED ON A SECOND ROAD (the coordinator's relays from 152_LOG and 153_LOG; it carries Lemma M (ii) and Lemma S (c), (d))

THE BEARING. Lemma M (ii) and Lemma S (c), (d) use, for every cut piece P (n plaquettes, internal links appearing twice,
boundary cycles b with holonomies z_b), |∫_P Π_p χ_j(U_p)| = d_j^{χ(P)−n} Π_b |χ_j(z_b)| — at spin ½ and at every higher
spin, orientable or not.
WHERE THE RECORD STANDS (read on the S1 page after the coordinator's second relay): §15 proved A1 as an INEQUALITY; S1 (n)
(2026-11-01 10:4x EST, the trunk seat, SIGNED by iii-73 at 10:5x) made it EXACT by the four gluing rules, the cross-cap
rule being (G2′) ∫da χ(aXaY) = (−1)^{2j} χ(XY⁻¹)/d — which is (FS3) below VERBATIM (χ(A⁻¹B) = χ(AB⁻¹) for SU(2)'s real
characters); its cut identity (1) is Corollary FS below; its check is crosscap.c (quadrature exact to degree 12 and 16,
j = ½, 1, 3/2, 2, residuals ≤ 6·10⁻¹⁶). So the relayed idea and this section's Lemma FS ADD NO STATEMENT: A1 was closed
in the record before this section was written, and Lemma M (ii) / Lemma S (c), (d) cite S1 (n). What this section adds is
a SECOND ROAD sharing no line with crosscap.c — exact integer arithmetic on the 24-cell design in place of a floating
quadrature — including iii-73's sharpening (i), the sign test at half-integer spin (RP² at j = ½, and (G2′) at j = ½ with
generic X, Y against the unsigned law), and the piece form at every spin with χ_j boundary characters (S1 (n) (1) writes
the boundary factor as χ_½; Lemma S (c) reads pieces at integer spins, where the same gluing gives χ_j).

**Lemma FS (the cross-cap step).** For every irrep D = D^j of SU(2) (d = 2j + 1), with ε the invariant bilinear form
(D(U) ε D(U)ᵀ = ε, ε real orthogonal, εᵀ = ν₂ε, ν₂ = (−1)^{2j}, so ε² = ν₂I):
  (FS1) ∫ D(U)_{ab} D(U)_{cd} dU = ε_{ac} ε_{bd} / d;
  (FS2) ∫ D(U) M D(U) dU = (1/d) ε Mᵀ ε for every matrix M; at M = D(X): = (ν₂/d) D(X)⁻¹;
  (FS3) ∫ χ_j(U A U B) dU = (ν₂/d) χ_j(A⁻¹B)  (the cross-cap glues with the INVERSE word and one sign ν₂).
*Proof.* D ⊗ D contains the trivial representation once (Clebsch–Gordan: j ⊗ j ∋ 0 once), with invariant vector
Σ ε_{ac} e_a ⊗ e_c; D ⊗ D is unitary, so its Haar average is the orthogonal projection |ε⟩⟨ε|/⟨ε|ε⟩, and ⟨ε|ε⟩ = tr εεᵀ = d:
(FS1). Contract with M_{bc}: Σ ε_{ac}M_{bc}ε_{bd} = (ε Mᵀ ε)_{ad}; invariance gives D(X)ᵀ = ε⁻¹D(X)⁻¹ε, so ε D(X)ᵀ ε =
D(X)⁻¹ε² = ν₂D(X)⁻¹: (FS2). Take the trace against D(B): (FS3). ∎
**Corollary FS (the magnitude law, every piece, every spin).** Integrate the internal links one at a time. Each step is
one of: two different traces, ∫χ(UA)χ(U^{±1}B) = χ(AB^{∓1})/d (no sign: χ_j is real, χ(g) = χ(g⁻¹)); one trace, opposite
orientations, ∫χ(UAU⁻¹B) = χ(A)χ(B)/d; one trace, same orientation, (FS3). Every step costs exactly 1/d; at the end each
empty trace is an interior vertex (factor d) and each nonempty trace a boundary cycle; with V_bdry = E_bdry on the boundary
cycles, d^{V_int − I} = d^{χ(P) − n}. Hence ∫_P = ν₂(j)^{c} d_j^{χ(P)−n} Π_b χ_j(z_b), c the number of cross-cap steps
(its parity fixed by evaluating at trivial boundary holonomy, so independent of the order). The MAGNITUDE is
orientation-free at every spin; only the sign sees the cross-caps. At a closed surface this is S1 (n)'s (−1)^{m}2^{χ−F}
at j = ½ and Mednykh's Σ_R ν₂(R)^c d_R^{χ} term by term. ∎
So Lemma M (ii) and Lemma S (c), (d) stand on Corollary FS with no orientability hypothesis; the orientability shape census
is not needed for any magnitude in this file (only the sign, a product of ν₂'s, depends on it).

STAKE (before `fs_check.awk` runs; exact integer arithmetic, the 24 Hurwitz units = the 24-cell, a spherical 5-design on
S³ = SU(2), so the average is the Haar integral for every integrand of degree ≤ 5 in U; j = ½ and j = 1 have degree
4j = 2 and 4): (A) (FS1) holds entry by entry, 16 entries at j = ½ (ε = [[0,1],[−1,0]]) and 81 at j = 1 (ε = I in the
Cartesian basis), every imaginary part 0; (B) the one-plaquette MÖBIUS CUP word, ∫χ_j(UXUY) = (ν₂/d)χ_j(X⁻¹Y), at all
576 pairs (X, Y) of Hurwitz units at both spins; (C) RP² (word UU): ∫χ_j(U²) = ν₂ — −1 at j = ½, +1 at j = 1;
(D) the control: the ORIENTABLE word UXU⁻¹Y gives χ(X)χ(Y)/d at all 576 pairs, both spins.
RESULT (`fs_check.txt`, 2026-11-02 05:39; fs_check.awk md5 9740f5cb…): STAKE HELD IN EVERY CLAUSE. (A) 16 of 16 entries at
j = ½ and 81 of 81 at j = 1, every imaginary part 0; (B) the Möbius cup 576 of 576 pairs at both spins; (C) RP²: −96 at
j = ½ (ν₂ = −1, the half-integer sign test) and 384 at j = 1 (ν₂ = +1); (D) the orientable control 576 of 576 at both spins.
The sighted negatives fire: the placement χ(XY) in place of χ(X⁻¹Y) fails at 460 pairs (j = ½) and 256 (j = 1); dropping
ν₂ (the unsigned law) fails at 432 pairs at j = ½ — so the check can see both a wrong index placement and a missing sign.
Two roads now stand under (G2′): the record's quadrature (crosscap.c, j ≤ 2) and this exact design average (j = ½, 1).

## 11. THE THREE S12 ITEMS OF 149_LOG (the coordinator's relay; the reader's desk arithmetic, verified or refuted here)

(1) THE SPARSITY COUNTEREXAMPLE (a 54-plaquette Z₂-minimal leaf in one 3-space carrying all twelve plaquettes at v).
STAKE (before `sparsity_X.awk` runs): X = ∂B for the reader's 13 cubes has F = 54, every link even, all 12 plaquettes at
v = 0, exactly six four-fold links (all at v, contact graph K₁,₆, b₁(G) = 0), V = 50, E = 102, χ = 2, and the F₂ nullity of
its link–plaquette incidence matrix is 1 (Z₂-minimal). If so it is a minimal leaf with a full 3D star and a FOREST contact
graph: Lemma M′ gives |S| ≤ 4 (as S6 does), Corollary U′ is untouched, and it refutes the wording of the sparsity lemma only.
(2)+(3) THE PER-STAR NUMBER AND THE PRICED CLOSING. The reader's r(G) := 2^{|V(G)|/2 − 1}·√S_½(G) is §7's ẽ_v exactly:
ẽ_v = e_v 2^{−n₄/2 − n₆} with e_v = √S_½ 2^{d_v/2 − 1} and d_v = a_v + n₄ + 2n₆ give ẽ_v = √S_½ 2^{a_v/2 − 1}. So (2) is
§7's bound |S(X)| ≤ 2^{χ(X)}Π_v r(G_v) ≤ 4Π_v r(G_v), and (3)'s inflation is ρ⁴ := max_G r(G)^{4/|E(G)|} over the table.
STAKE (before `rate_table.awk` runs over the record's 560 orbits, exact in e², read in floating point only to rank): the
maximum of r^{4/|E|} is 2^{2/3} = 1.5874 (the vertex pinch, two disjoint triangles, and the pinch-plus-pinch star), NOT the
reader's 1.260 (bowtie) or 1.238 (K_{2,2,2}); the bowtie reads r = √2 and K_{2,2,2} reads r = 1.899 on the table (the
reader's two values confirmed); several four-dimensional stars exceed 1.26.
RESULTS (records `sparsity_X.txt`, `rate_table.txt`, 2026-11-02 05:45–05:47):
(1) VERIFIED IN ITS CONCLUSION, CORRECTED IN ITS DETAIL. X = ∂B: F = 54 (12 face-adjacencies), every link even, all 12
plaquettes at v, F₂ nullity 1 — Z₂-MINIMAL by machine; the sparsity lemma's wording ("all twelve plaquettes of a 3-space at
v force a proper closed subset") is REFUTED. But X has SEVEN four-fold links, not the reader's six: the seventh,
(1,1,−1)–(1,1,0), is an EDGE contact between the chain cubes (1,0,−1) and (0,1,−1) — two cubes of B meeting along a link
only, which a face-adjacency check cannot see; and V = 49, E = 101 (not 50, 102), χ = 2 either way. The contact graph is
K₁,₆ ⊔ K₂, a forest: Lemma M′ (and the record's S6) give |S(X)| ≤ 4, so the reader's decisive experiment (a) is forced, and
nothing in §§3–4 moves. (The reader's Theorem-V value 60.8u^F on X gains two more singular stars at the seventh link's ends.)
(2) VERIFIED. r(G) = §7's ẽ_v identically (above); on the table the bowtie reads r = √2 (rate 2^{1/3} = 1.2599), K_{2,2,2}
r = 1.8987 (rate 1.2383) — the reader's two values, and the verdict's "~2.47 per plaquette" is 1.238 for a K_{2,2,2} star
measured against its own curvature, as the reader says. The cycle stars read r = 1 (the sheet identity).
(3) REFUTED AS STATED. The inflation the reader used is ρ⁴ = 1.260, the maximum over THREE stars. Over all 559 nonempty
orbits the maximum of r^{4/|E|} is 2^{2/3} = 1.5874 EXACTLY (decided in integers, p³ = 2^E q³), at the vertex pinch (two
disjoint triangles, two orbit forms) and at the triangle–hexagon contact star (deg 42222222, r = 2√2); no orbit exceeds
it; 135 orbits exceed 1.260 (the next: 1.5157, 1.4860, 1.4142 ×5, the full K_{2,2,2,2} 1.3851). And Theorem V as quoted is
the spin-½ activity, while the tail must price every spin assignment (the record's σ(F) covers one raised piece only).
With the exact table maximum the reader's own uniform-inflation estimate falls to u(β′) = 0.11797/1.5874, β′ ≈ 0.298, at
spin ½ alone. The proved, all-spin form of the priced closing is Corollary U′: the Theorem-V road's worst star rate is
2^{2/3} = 1.5874 (1.5157 even with the pure pinches discounted by b₁(X)), above Lemma M′ + (E3″)'s uniform spin-½ rate
2^{7/12} = 1.4983, so Lemma M′ + E dominates that road, and Lemma S prices the spins. Its certified run is §4b —
β*_u = 0.3348 (page) / 0.3350 (tree), F₀ = 22 — and with Corollary U″ (§13) 0.3650 / 0.3656: an S12-FREE threshold past
Theorem 8.7's 0.2452, its other open inputs the record's own, the neck lemma (S1 (m′)) and the contact-rest dressing
(§8 (2)) (corrected 06:1x and 06:5x from "a new unconditional threshold": see the HEADLINE).
027_P's other item, the W1 draft as the proof of a "DRESS=crude" certificate mode: no crude mode exists in the engine of
record (DRESS ∈ {page, tree}); nothing was run; 027_P itself rates it low (ε_crude > 0 only far below β ≈ 0.22), and the
tolerance curve (§14) says a crude pricing must keep its per-plaquette inflation below κ*(β) to count at all.

## 4. THE NUMBERS (every one a certified PASS of `kp_cert_m1.awk`, the record's engine plus the M1 modes, on the 2·10⁻⁴ grid)

Engine `kp_cert_m1.awk` (md5 in each record's START line: 5a679455… → 5713766b… → 2149dab8… → 854dc6fc… for the numbers of
4a and 4b; 056ab975… after the projection mode FMIN1 of §12 was added, its control re-checked character-identical to the
record's engine, `ctl_m1c_*.txt`, and the U′ point at 0.3348 digit-identical to `uc_points.txt`; 3d17b9b8… after the U12
mode of §13 was added — the engine of every U″ number, of the tolerance curve and of the bisections — its control re-checked
character-identical, `ctl_m1d_*.txt`, and the U′ point at 0.3348 identical with U12 unset) = the record's
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
| **1/2 (U″, §13)** | page | 22 | T1 + T2 | **0.3650** (refused at 0.3652) | [0.0039, 0.0050] | `scan_u12_page_F22.txt` (full grid 0.3580–0.3652), `bisect_u12_page_F22.txt` |
| **1/2 (U″)** | tree | 22 | T1 + T2 | **0.3656** (refused at 0.3658) | [0.0038, 0.0051] | `bisect_u12_tree_F22.txt` (the grid scan stopped, superseded) |
| 1/2 (U″) | page | 20 | T1 + T2 | 0.3588 (refused at 0.3590) | [0.0040, 0.0057] | `bisect_u12_page_F20.txt` |
| 1/2 (U″) | page | 20 | the record's | 0.3306 (refused at 0.3308) | | `bisect_u12rec_page_F20.txt` |
| 7/12 (U′) | page | 22 | T1 + T2 | **0.3348** | [0.0043, 0.0047] | `scan_u712_page_F22.txt` |
| 7/12 (U′) | tree | 22 | T1 + T2 | **0.3350** (refused at 0.3352) | [0.0038, 0.0054] | `scan_u712_tree_F22.txt` |
| 7/12 (U′) | page | 20 | T1 + T2 | 0.3280 | [0.0042, 0.0058] | `scan_u712_page_F20.txt` |
| 7/12 (U′) | page | 20 | the record's (5^{F−1}, every F) | 0.3012 | [0.0048, 0.0058] | `scan_u712rec_page_F20.txt` (top of range 0.2980), `_F20b.txt` |
| 5/8 (U) | page | 22 | T1 + T2 | 0.3246 | [0.0044, 0.0047] | `scan_unc_page_F22.txt` |
| 5/8 (U) | tree | 22 | T1 + T2 | not read (stopped by hand at 75 min, superseded by U′) | | `scan_unc_tree_F22.txt` |
| 5/8 (U) | page | 20 | T1 + T2 | 0.3180 | [0.0046, 0.0053] | `scan_unc_page_F20.txt` |
| 5/8 (U) | page | 20 | the record's | 0.2916 | [0.0045, 0.0062] | `scan_uncrec_page_F20.txt` |

THE STATEMENT. THEOREM 8.9 WITHOUT S12: SU(2) Wilson lattice gauge theory on ℤ⁴ at 0 < β ≤ β*_u = 0.3650 (page dressing)
/ 0.3656 (tree dressing), F₀ = 22 (Corollary U″, §13; with Corollary U′ alone 0.3348 / 0.3350), has a convergent polymer expansion uniform in the volume, a unique infinite-volume
Gibbs measure, exponential clustering of local gauge-invariant observables at the certified rate α(β) and a transfer-
matrix gap ≥ α(β) — by the record's chain (S1 §14's inequality, D1.1–D1.4, Theorem 7.1) with the tail activity replaced by
Corollary U″ (T1, T2, Lemmas R, M′, E, E4, S, and Corollary FS for non-orientable pieces at every spin: §§1, 3, 3b, 10, 13) and
every other input as the record has it and signed (S1 §25 (i)). It extends Theorem 8.7's 0.2452 by +0.0896. ONE ITEM is
the record's own and is named in §8 (2): the dressing's joint decoration bound is stated for branch-free rests and the
record applies it to every leaf; the census contact leaves inside the record's 0.4764 use it in exactly the same way.
Theorem 8.7's route (influence along paths of links) has no dressing, so in the record's own sense the one UNCONDITIONAL
number stays 0.2452 and this one is S12-FREE, with two record-owned conditions named: the neck lemma (S1 (m′), "remains
owed") and the contact-rest dressing (§8 (2)) — the record's 0.4764 carries both in exactly the same way.
WHY THE RECORD'S ROAD (i) DID NOT GIVE THIS NUMBER (the 028_P relay; S1 (p)'s "a certificate run at the tail's per-
plaquette activity inflated by 4^{1/c}"): with S11's ceiling 4^{r+1} and r ≤ (7/12)F + 7/3 the inflation is 4^{7/12} =
2.245 per plaquette on every activity, and §6's exit budget admits ln 4/c = 0.809 only below β ≈ 0.22 (record's tail) /
0.24 (sharpened) — below 0.2452 (the relay's "c ≥ 2.04 → 0.25" matches §6 at 0.25; its "c ≥ 7.30 → 0.40" is the far
shore's sub-gas ε, which the table mode corrects to c ≥ 8.15). Two changes carry 0.3348: Lemma M′ lowers the base from 4
to 2 per unit of b₁(G) + b₁(G₆), and the factor multiplies the TAIL only (the enumerated leaves and the dressing keep their
proved values), where the exit budget tilts every activity.
At the refused point β = 0.3350 the tail is 0.0045596 of the left side's 0.0045851 (99.4 %; rK₁′ = 0.7315): the number is
the tail's, and the lever is the density exponent (Proposition LP, §8 (1)).

## 12. THE PRICE OF THE LEAST-AREA QUESTION (the coordinator's F_min(r)), A PROJECTION LABELLED AS ONE

If F_min(1) ≥ F₁ were proved — no Z₂-minimal leaf of area below F₁ has a contact cycle — every leaf with F < F₁ has a
forest contact graph, hence ONE piece (m ≤ 1 + b₁(G) = 1) and the PROVED activity 4σ(F)u^F (S11 at one spin), and
Corollary U′ is needed only from F₁ on. Engine mode FMIN1 (md5 056ab975…; control re-checked: FMIN1 unset leaves both
dressings character-identical to the record's engine, `ctl_m1c_*.txt`, and the U′ point at 0.3348 digit-identical to
`uc_points.txt`): tail = the conditional even tail over every F ≥ F₀ + 2 (an upper bound on its part below F₁) + U′ summed
over even F ≥ F₁. What is in hand: the census to F = 22 (one road at 22) shows every contact leaf there a forest, so
F_min(1) ≥ 24 is the record's; (E3′) gives nothing at r = 1; the record's smallest built contact cycle is Object A, F = 138.
STAKE (before `scan_proj_fmin_*.txt` run; page, F₀ = 22): β*(F₁ = 40) ∈ [0.355, 0.375]; β*(60) ∈ [0.370, 0.390];
β*(100) ∈ [0.380, 0.410]; every refusal the U′ tail's (rK₁′ → 1 caps all three below ≈ 0.42).

(4) 155_LOG — THE SIX-FOLD CENSUS AND THE RECORD'S S12-b/c/c′. Agreed: the box six-fold census's zeros (B2/B3 seeds at their
node cap, no minimal six-fold leaf read) are vacuous on the remainder's class (laws 2, 48). But the CERTIFICATE'S
ENUMERATED PART does not rest on the box census: N_F and N_c to F = 22 are g51's (b11a70dbf, `g51_even_d4_f22`), and
g51_orient.c (read 11-02, tracked) enumerates every closed link-connected set through p₀ by completing the smallest
deficient link with ANY of its plaquettes — no multiplicity cap; its ZMIN histogram prints multiplicities to 7 — so
"largest multiplicity 4" on all 46,816 Z₂-minimal contact leaves at F = 22 (and on the 4,800 at 20, the 576 at 18) is a
FINDING, not a cap. Six-fold leaves therefore enter only the tail (F ≥ 24), where Lemma M′ prices every multiplicity
(six-fold links cut, the exponent b₁(G) + b₁(G₆)). Corollary U′ uses none of S12-b, S12-c, S12-c′; the record's scope
correction of (b1) (1 × n, 2 × 2 proved; k × l with a contact spoke not) bears on the conditional numbers of §4a only.
(5) 154_LOG IDEA S1 — VERIFIED AS A REDUCTION, AND IT IS §8 (3)'s FORMULATION REACHED BLIND (law 40: the convergence is
the finding). The locality it needs is exact: E(T_ρ) = N₂ + 2N₄ + 3N₆ is independent of ρ and V(T_ρ) = Σ_v u_v(ρ), where
u_v (the umbrella count of the resolved star at v) depends ONLY on the pairings at the contact links incident to v; so
Lemma R reads  S(X) = (2/3)^{N₄}(1/3)^{N₆}(−2)^{F−E} Σ_ρ Π_v (−2)^{u_v(ρ|_v)}  — a vertex model on the contact graph G.
The frame identity (2/3)Σ_{a=1..3}Π_a = P_Inv (three equiangular pairing lines in the 2-dimensional Inv(V_½^{⊗4}); at a
six-fold link the 15 pairings frame the 5-dimensional Inv with weight 1/3, Lemma R's c₃ = 24) makes the four-fold bond
2-dimensional and the six-fold bond 5-dimensional; a contact cycle of four-fold links is the trace of a product of 2 × 2
transfer matrices from a finite alphabet, and rank ≥ 2 is a contraction at cost 2^{treewidth}. The kill-switch as worded
("a third sheet entering at a six-link") does not break locality: a six-fold link is a 5-dimensional bond of the same
network. Lemma M′ is this network's bond-dimension bound (every independent cycle costs its bond dimension at most);
S12 is the statement that the contraction never exceeds 4 — the next object, with its instrument: the finite alphabet of
vertex tensors (the even stars of K_{2,2,2,2} with their contact links marked, at most 560 orbits) and a per-vertex
operator-norm bound across each bipartition of its contact legs; a norm ≤ 1 everywhere would make every transfer product
a contraction and give |S| ≤ 4 on every rank.

(6) 028_P (2) — THE WEINGARTEN WALL AT p ≥ 3 IS A BELIEF: VERIFIED, AND IT IS LEMMA R. Collins–Śniady's Weingarten function
for n > d is the pseudo-inverse of the pairings' Gram matrix; for SU(2) the Gram operator Σ_π |ε_π⟩⟨ε_π| is S_{2n}-invariant
on the irreducible S_{(n,n)} = Inv(V_½^{⊗2n}), so by Schur it is c_n P_Inv and the pseudo-inverse is the scalar 1/c_n on the
frame — Lemma R's weights 2/3 (n = 2, c₂ = 6) and 1/3 (n = 3, c₃ = 24, fifteen pairings). A six-fold link is read EXACTLY;
with (5)'s locality the first open six-fold cycle shape, the skew octagon with eight six-fold links, is the trace of a
product of eight 5 × 5 transfer matrices (the 5-dimensional six-fold bond), not a 15⁸ = 2.6·10⁹-term sum. Its instrument:
the vertex tensors of its eight corner stars, read off (5)'s formula; its value then decides S12-c′'s open (c) class at
its first object.
(7) 028_P (3) — S12-c′'s EXACT STATEMENT (the S1 page, (p) THEOREM S12-c′, CORRECTED IN SCOPE, 2026-11-01 18:0x EST,
verbatim): "the unicyclic six-fold class stands closed at |S| ≤ 4 on: every cycle with a four-fold link; every planar
cycle whose ring spokes are 2-links, the 1 × n rectangles and the 2 × 2 square among them unconditionally; every skew
hexagon. Open at |S| ≤ 8: the planar k × l rectangles (k, l ≥ 2, not 2 × 2) with a contact spoke, and the non-planar
cycles of length ≥ 8 with every link six-fold". READ AGAINST ITS PROOF, ONE MORE NARROWING: (b1)'s step "every link's inner
in-plane square is in X, so the whole inner ring of the region C bounds is in X" holds at straight vertices and convex
corners, where consecutive inner squares share a spoke; at a REFLEX corner of a non-rectangular planar cycle the two inner
squares meet only at the vertex, and the diagonal interior square that would join them contains NO link of C, so no
six-fold link forces it (the 3 × 3 square minus a corner: its centre square is unforced). With it absent the inner squares
form an open chain and the ring is not closed at that vertex; whether the rim still winds once then turns on the piece's
umbrella at the reflex vertex (off-plane plaquettes, tree contacts there), which (b1) does not address. So "every planar
cycle whose ring spokes are 2-links" is proved by (b1) as written for RECTANGLES (every convex lattice cycle is one; 1 × n
and 2 × 2 unconditionally, k × l when its spokes are 2-links); for a planar cycle with a reflex corner it needs either the
diagonal squares in X or a reflex-vertex umbrella argument. The safe wording for revision 32: "every rectangular cycle
whose ring spokes are 2-links (the 1 × n rectangles and the 2 × 2 square unconditionally)". None of this moves §4b, which
uses no S12 class; it bears on §4a's conditional numbers and on the record's list of proved classes.

## 13. LEMMA E4 AND COROLLARY U″ — THE EXPONENT 1/2 (the 027_P relay's lattice fact, verified, and carried past its own use)

THE RELAY (027_P, the coordinator 06:2x): r ≤ (3/4)F from (a) E ≤ 4V − 4 for a finite connected subgraph of ℤ⁴ and
(b) E_c ≤ F (every contact link has multiplicity ≥ 4 among the 4F plaquette–link incidences); then the S1 page's road (i)
with S11's 4^{r+1}: an inflation 4^{3/4} = 2√2 per plaquette on the open class.
(a) VERIFIED, with its proof: let H be a finite subgraph of ℤ⁴ with at least one edge; its lexicographically greatest vertex
has no neighbour in H in the four directions +e_i, its least none in the four −e_i, and they differ; so Σ deg ≤ 8V − 8 and
E ≤ 4V − 4, per component. Hence b₁(H) = Σ_comp (E_i − V_i + 1) ≤ Σ_comp (3/4)E_i = (3/4)E(H). (b) VERIFIED and weaker than
(E2) (E_c = N₄ + N₆ ≤ N₄ + 2N₆ ≤ (2F + 8)/3). Read as stated, road (i) at 2√2 per plaquette prices spin ½ only (S11's 4^m is
the spin-½ ceiling; the mixed half-integer assignments of an m ≥ 2 leaf are not in it), and 2√2 is far above U′'s rate.
WHAT THE FACT DOES FOR THIS FILE — it beats Proposition LP's relaxation, where the component bound was c ≤ V/2:
**Lemma E4.** For every Z₂-minimal X:  (E2′) N₄ + 2N₆ ≤ (2F + 4)/3;  (E4) b₁(G) + b₁(G₆) ≤ (3/4)(N₄ + 2N₆) ≤ F/2 + 1,
and b₁(G) ≤ (3/4)(N₄ + N₆) ≤ F/2 + 1.
*Proof.* (E2′): X's 1-skeleton (its links and their endpoints) is connected (X is link-connected) and finite, so by (a)
|L(X)| ≤ 4V_X − 4; with (E1), F − N + 2 ≥ V_X ≥ (|L| + 4)/4 = (2F − N + 4)/4, i.e. N ≤ (2F + 4)/3. (E4): (a) on G and on G₆
gives b₁(G) ≤ (3/4)(N₄ + N₆) and b₁(G₆) ≤ (3/4)N₆; add, and use (E2′): (3/4)N ≤ (3/4)(2F + 4)/3 = F/2 + 1. ∎
**Corollary U″.** Corollary U with the exponent 1/2: Σ_spins|W(X)| ≤ 4u^F[C₁K₁^F + C_I K_I^F], K₁ = (2(1+δ₁))^{1/2},
C₁ = (1+δ₁)·2(1+δ₁), K_I = 2ε₁, C_I = 4 (Lemma S (d) with Lemma M′'s exponent b₁(G) + b₁(G₆) ≤ F/2 + 1 and (1+δ₁)^{1+b₁(G)},
b₁(G) ≤ F/2 + 1; Lemma S (c) with 4^{b₁(G)} ≤ 4^{F/2+1}). Engine flag U12 (md5 3d17b9b8…; control re-checked:
`ctl_m1d_*.txt` character-identical to the record's engine, the U′ point at 0.3348 identical with U12 unset).
PROPOSITION LP CORRECTED (dated 06:3x): its statement stands as worded — 7/12 is the optimum of vertex stars + Euler +
c ≤ V/2 — but its sentence "THE MISSING CONSTRAINT IS THE CUBE" is WRONG: the lattice's own boundary (a finite subgraph of
ℤ⁴ loses eight half-edges per component) is a constraint c ≤ V/2 does not see, and it moves 7/12 to 1/2 at once. The cube
is the next constraint after it, not the first.
FIRST POINTS (page, F₀ = 22, α = 0.004): β = 0.34 PASS (LHS 0.0003863, rK₁ 0.692), 0.35 PASS (0.0009682), 0.36 PASS
(0.0024748, rK₁ 0.744), 0.37 FAIL (0.0064133); δ₁ = 0.17247, K₁ = 1.53132, C₁ = 2.749 at 0.36.
STAKES (before the U12 scans): β*_u (page, F₀ = 22) ∈ [0.3600, 0.3700); tree within +0.002 of it; page F₀ = 20 between
0.005 and 0.009 below; under the record's own tail (UNCREC) between 0.320 and 0.345. The relay's road (i) as stated (spin ½,
tail-only factor 2√2 ≤ 2829/1000 on the record's 4σ(F)u^F, T1 + T2): β ∈ [0.20, 0.26), below or at Theorem 8.7's 0.2452.

RUN NOTE (2026-11-02 06:4x): the grid scans of the four projections (§8 (1)'s c = 4, §12's F₁ = 40/60/100 on U′), of the
U″ record-tail control and of the relay's road (i) were STOPPED by hand before any result line — a 2·10⁻⁴ grid over their
wide ranges would have run 1.5–2 h each — and replaced by `bisect.sh` (the same engine call at single β, the scan's own α
search, both ends checked first; valid where PASS is monotone in β, as the tail-dominated left side is). Their stakes stand
unread. Since Corollary U″ (§13) supersedes U′, §12's projection is RE-STAKED on U″ (FMIN1 with U12; written before the
bisections run): β*(F₁ = 40) ∈ [0.375, 0.395); β*(60) ∈ [0.385, 0.405); β*(100) ∈ [0.395, 0.420); the c = 4 projection
keeps its stake [0.40, 0.44].
RESULTS (bisections, 2026-11-02 06:27; engine md5 3d17b9b8…; records `bisect_*.txt`, every probe a single-β scan line):
- U″ UNDER THE RECORD'S OWN TAIL (UNCREC, page, F₀ = 20): β* = 0.3306 (refused at 0.3308) — stake [0.320, 0.345] HELD.
  The density lemma at exponent 1/2 alone, with no T1 and no T2, carries Theorem 8.9 S12-free to 0.3306.
- THE RELAY'S ROAD (i) AS STATED (spin ½, the record's 4σ(F)u^F times (2829/1000)^F on the tail, T1 + T2, page, F₀ = 22):
  β* = 0.2130 (refused at 0.2132) — stake HELD: below Theorem 8.7's 0.2452. S11's base 4 per independent cycle at c = 4/3
  cannot pass 0.2452 even with the sharpened tail; the number above 0.2452 needs Lemma M′'s base 2 and (E2′)'s density.
- §8 (1)'s c = 4 PROJECTION (K = 1.26, C = 11, tail-only, page, F₀ = 22): β_proj = 0.4122 (refused at 0.4124) — stake
  [0.40, 0.44] HELD; valid as a projection to 0.43 (its caps). A proved b₁(G) + b₁(G₆) ≤ F/4 + O(1) is worth +0.05 over U″.
- §12'S LEAST-AREA PROJECTION ON U″ (FMIN1 with U12, page, F₀ = 22; PROJECTIONS, each valid as a theorem only if no
  Z₂-minimal leaf of area below F₁ has a contact cycle): F₁ = 40 → β* = 0.3946 (refused at 0.3948) — stake [0.375, 0.395)
  HELD at its edge; F₁ = 60 → 0.4114 (refused at 0.4116) — stake [0.385, 0.405) REFUTED, above it; F₁ = 100 → 0.4264
  (refused at 0.4266 by "r K₁ ≥ 1: the unconditional tail does not close") — stake [0.395, 0.420) REFUTED, above it. So the
  least-area question is worth +0.03 at F₁ = 40, +0.05 at 60, +0.06 at 100 over U″'s own number, and SATURATES at
  rK₁′′ = 1 (β ≈ 0.4265): past that no floor on F_min helps, and only a sharper density exponent (c > 2) or S12 itself moves
  the number toward the conditional 0.5100.

## 14. THE TOLERANCE CURVE κ*(β) (the coordinator's sharpening, from the 036_P reading)

κ*(β) := the largest per-plaquette factor K such that the certificate (page, F₀ = 22, table mode, T1 + T2, NCSIG) still
passes at β with EVERY leaf of size ≥ 24 carried at 4σ(F)(Ku)^F, the enumerated leaves (F ≤ 22, every contact leaf a forest,
proved) and the dressing at their record values. Since the open class first occurs at F = 24, inflating the whole tail is
an upper bound on what an open-class-only inflation would cost (surfaces inflated needlessly), so κ*(β) is conservative.
Then ANY proved bound "every leaf of size ≥ 24 has all-spin activity ≤ 4σ(F)(κu)^F" gives Theorem 8.9 S12-free at every
β with κ ≤ κ*(β). Driver `tolcurve.sh` (bisection on K to 10⁻³, the engine's TKN/TKD mode, md5 3d17b9b8…).
STAKE (before `tol_*.txt` run): κ*(0.25) ∈ [2.3, 2.8]; κ*(0.30) ∈ [1.9, 2.3]; κ*(0.35) ∈ [1.6, 1.95]; κ*(0.40) ∈ [1.35, 1.6];
κ*(0.45) ∈ [1.12, 1.35]; κ*(0.4764) ∈ [1.05, 1.25]; κ*(0.50) ∈ [1.0, 1.1]; the relay's κ = 2√2 crosses near β ≈ 0.21.
- U″ ITSELF (page, F₀ = 22, T1 + T2; `bisect_u12_page_F22.txt`, 06:35; the grid scan `scan_u12_page_F22.txt` beside it):
  **β*_u = 0.3650** (α ∈ [0.0039, 0.0050] at 0.3650; refused at 0.3652, "the inequality's upper end is above alpha") —
  stake [0.3600, 0.3700) HELD. +0.0302 over U′'s 0.3348, +0.1198 over Theorem 8.7's 0.2452. THEOREM 8.9 WITHOUT S12 NOW
  STANDS AT β ≤ 0.3650 (page), its other open inputs the record's own: the neck lemma (S1 (m′)) and the contact-rest
  dressing (§8 (2)), carried exactly as in the record's 0.4764 (headline corrected 06:5x, law 51 both ways).
- WHERE 1/2 STOPS (desk, 06:4x): Proposition LP's primal point (one full star, three octagon saddles: F = 12, a G-region of
  full stars with four six-fold links per vertex) reads, under (a)'s component bound in place of c ≤ V/2, b₁(G) + b₁(G₆) ≤
  (E − V + c) twice ≈ 3 + 3 = 6 per block: ratio 6/12 = 1/2 EXACTLY. So 1/2 is the rate of vertex stars + the Euler identity +
  the lattice boundary, attained asymptotically by a four-dimensional region of full stars — which contains closed unit
  3-cubes, so a minimal X cannot carry it. THE CUBE CONSTRAINT IS THE NEXT ONE, now correctly placed: below 1/2 needs it.
RESULTS (`tol_page_F22_b*.txt`, 2026-11-02 06:3x–06:41; engine md5 3d17b9b8…; each κ* a bisection on K to 10⁻³, both ends
checked; PASS at the lower end, FAIL at the upper): EVERY STAKE HELD.

| β | κ*(β) | stake |
|---|---|---|
| 0.25 | [2.3980, 2.3988) | [2.3, 2.8] HELD |
| 0.30 | [1.9784, 1.9791) | [1.9, 2.3] HELD |
| 0.35 | [1.6715, 1.6722) | [1.6, 1.95] HELD |
| 0.40 | [1.4312, 1.4320) | [1.35, 1.6] HELD |
| 0.45 | [1.2291, 1.2298) | [1.12, 1.35] HELD |
| 0.4764 | [1.1295, 1.1302) | [1.05, 1.25] HELD |
| 0.50 | [1.0401, 1.0409) | [1.0, 1.1] HELD |

READING. (i) Any proved all-spin bound "every leaf of size ≥ 24 weighs at most 4σ(F)(κu)^F" carries Theorem 8.9 S12-free
wherever κ ≤ κ*(β); a prefactor C > 1 costs a little more (U″ has C₁ ≈ 2.75 and K₁ ≈ 1.53 and passes to 0.3650, where
κ*(0.365) ≈ 1.60). (ii) The relay's κ = 2√2 = 2.828 lies above κ*(0.25) = 2.398: it crosses below 0.25 — and its
bisection (§13) put it at 0.2130, below Theorem 8.7's 0.2452. (iii) At the record's own number 0.4764 the sharpened tail
leaves 13 % per plaquette of slack (κ* = 1.13), and at 0.50 still 4 %: a proved per-plaquette rate of 1.13 on the open class
would reproduce the record's conditional headline with no S12 stake. (iv) For the next lemmas: exponent 1/4 (K₁ ≈ (2.4)^{1/4}
≈ 1.25) lands near β ≈ 0.44 by this curve (its own run, §8 (1), read 0.4122 with C = 11); S12 itself (κ = 1) gives the
conditional 0.5100.
- U″ COMPLETE (bisections, 06:4x–06:5x): tree, F₀ = 22: **β*_u = 0.3656** (α ∈ [0.0038, 0.0051]; refused at 0.3658) — stake
  "tree within +0.002" HELD (+0.0006); page, F₀ = 20: 0.3588 (refused at 0.3590) — stake "0.005 to 0.009 below" HELD (0.0062).
  The grid scans of the tree and of page F₀ = 20 were stopped by hand once the bisections closed (records marked STOPPED).
  STATE OF THE FILE'S NUMBER: THEOREM 8.9 WITHOUT S12 at β ≤ 0.3650 (page) / 0.3656 (tree), F₀ = 22; its other open inputs
  the record's own, the neck lemma (S1 (m′)) and the contact-rest dressing (§8 (2)); the next lemma (exponent below 1/2) needs the cube constraint.
