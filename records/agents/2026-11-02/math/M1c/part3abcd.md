
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
