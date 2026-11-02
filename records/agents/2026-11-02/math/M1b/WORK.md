# M1b — the strong end below exponent 1/2: the cube discharging, what it gives, and what replaces it (proof agent M1b, 2026-11-02)

Work directory: this folder. Engine `kp_cert_m1.awk` copied byte-identical from M1 (md5 3d17b9b8cd661c6fcbdd313acbcfe8f6), table
`r2tab_g.txt` (tag g). Notation as M1's WORK.md §3: X a Z₂-minimal plaquette set, F = |X|, a_v = links of X at v, d_v = plaquettes
of X at v, n₄(v), n₆(v) the four- and six-fold links at v, e_v := n₄ + 2n₆ = d_v − a_v (the contact excess), N := N₄ + 2N₆ = Σ_v e_v/2,
K_v := d_v − 2a_v + 4 (M1's curvature, Σ_v K_v = 4χ(X)), G the contact graph (links of multiplicity ≥ 4), G₆ the six-fold links,
Q := b₁(G) + b₁(G₆) (Lemma M′'s exponent). The task: Q ≤ c′F + C with c′ < 1/2 from the cube constraint.

---------------------------------------------------------------------------------------------------------------
## 0. THE 07:4x RELAY (iii-08's charge function), VERIFIED FIRST

(i) κ(v) := ℓ_X(v) − d_X(v)/2 − 2 = a_v − d_v/2 − 2 = −K_v/2 EXACTLY: iii-08's charge is M1's Gauss–Bonnet curvature halved and negated
(Lemma E (E1); Proposition LP's K). Σ_v κ = −Σ_v K_v/2 = −2χ(X) = 2b₁(X) − 4 for Z₂-minimal X (b₀ = b₂ = 1): VERIFIED. The equivalent
form Σ_v(ℓ − 4) = 2E₄ + 4E₆ + 4b₁ − 8 is M1's §8 (1) identity Σ_v(a_v − 4) = 2(N₄ + 2N₆) + 4b₁(X) − 8: VERIFIED (the same line).
κ = ℓ/2 − a₄/2 − a₆ − 2 follows from d = a + n₄ + 2n₆ (each link contributes m/2 to d at each end): VERIFIED.
(ii) The value table is right (4-cycle 0; 3-cycle −½; 5-, 6-cycle +½, +1; two disjoint 4-cycles +2), and it REFUTES the relay's own
sentence "every positive charge sits at a vertex whose L_v is not a single cycle": a single k-cycle star carries κ = k/2 − 2, so the
5-, 6-, 7- and 8-cycles (cone and saddle vertices with no contact) carry +½, +1, +3/2, +2. Corrected wording: positive charge sits
at stars with a ≥ 5 + n₄ + 2n₆, i.e. at saddles (single long cycles or several cycles), never at a contact-free 3- or 4-cycle.
(iii) iii-08's hoped lemma (the cube constraint forces the average degree at CONTACT vertices to be ≤ 6.5, "slope ≈ 1/2.4") is
REFUTED AS A CONSEQUENCE OF THE CUBE CONSTRAINT by §2's block below: every vertex of the four-fold bulk A × B has eight links, all
four-fold (contact degree 8, X-degree 8), and the block carries no closed 3-cube — no vertex of it is even the corner of one.
Whatever bounds the contact degree, it is not the cube.

---------------------------------------------------------------------------------------------------------------
## 1. THE EXACT SLACK OF THE EXPONENT 1/2 (an identity, from (E1) and degree counting alone)

**Theorem I (the slack identity).** For every finite plaquette set X ⊂ ℤ⁴ with every link of even multiplicity,
  F/2 + 1 − Q  =  Δ(G) + Δ(G₆) + (2 − χ(X)) + (1/8)[Σ_{v∈X}(8 − a_v) − 8],
where for a finite subgraph H of ℤ⁴, Δ(H) := (3/4)E(H) − b₁(H) = (1/8)Σ_{v∈H}(8 − deg_H v) − c(H). For Z₂-minimal X, 2 − χ(X) = b₁(X).
*Proof.* Per vertex, with e = d − a and K = d − 2a + 4: (3/8)e − K/4 + (8 − a)/8 = (3/8)(d − a) − (d − 2a + 4)/4 + 1 − a/8 = d/8,
identically in (a, d). Sum over v: (3/4)N − χ(X) + (1/8)Σ(8 − a_v) = F/2 (Σ d_v = 4F, Σ K_v = 4χ, Σ e_v = 2N). And
(3/4)N = (3/4)E(G) + (3/4)N₆ (E(G) = N₄ + N₆) = b₁(G) + b₁(G₆) + Δ(G) + Δ(G₆). Substitute; Δ(H)'s second form is
E − V + c = b₁ rearranged with Σ deg_H = 2E. ∎
**Each bracket is ≥ 0 for minimal X:** Δ(H) ≥ 0 per component by the lattice boundary (a finite connected subgraph of ℤ⁴ loses eight
half-edges at its lexicographic extremes: Σ(8 − deg) ≥ 8); 2 − χ = b₁(X) ≥ 0; Σ(8 − a_v) ≥ 8 the same fact on X's 1-skeleton.
So Lemma E4 (Q ≤ F/2 + 1) is Theorem I with the four brackets dropped, and NOTHING ELSE IS LOST: the dual of Proposition LP with the
lattice boundary has ZERO slack on every one of the 131,071 even stars (the per-vertex line above is an identity, not an inequality).
**Corollary I (the extremal configurations, exactly).** Q/F → 1/2 along a family iff the four brackets are o(F): all but o(F) of the
vertices have a_v = 8, are bulk vertices of G (all eight links contact) or not in G, are bulk vertices of G₆ or not in G₆, and
b₁(X) = o(F). The zero-deficit stars are exactly three kinds:
  α  a = 8, no contact: a 2-factor of the octahedral graph K_{2,2,2,2} (d = 8, K = −4, κ = +2);
  β  a = 8, all eight links four-fold: a 4-regular spanning star (d = 16, K = +4, κ = −2);
  γ  all eight links six-fold: the full star (d = 24, K = 12, κ = −6);
(a vertex with both four- and six-fold links is in G₆ with G₆-degree < 8; one with a two-fold and a contact link is in G with
G-degree < 8). A β-vertex's neighbours share four-fold links, so they are β or deficient (never γ, never α); likewise for α and γ:
zero-deficit vertices form PURE regions, and Σ_v K_v = 8 − 4b₁ ≤ 8 forces |α| ≥ |β| + 3|γ| − O(1) up to deficits.
c′ < 1/2 is therefore EQUIVALENT to a lemma forcing the deficits (missing links, partial contact, b₁(X)) to be linear in F.

---------------------------------------------------------------------------------------------------------------
## 2. THE CUBE CONSTRAINT GIVES EXACTLY 1/2 — THE OBSTRUCTION

**Lemma C0 (what the cube constraint sees).** A unit 3-cube c with all six faces in X has, at each of its eight corners v, its three
faces at v in X: a TRIANGLE (h₁, h₂, h₃) of pairwise non-opposite half-axes in the star of v. A triangle-free star is the corner of no
closed 3-cube, so on a set X all of whose stars are triangle-free the cube constraint is satisfied VACUOUSLY. ∎
**Lemma C1 (the mixed squares).** Split the axes {1,2} | {3,4} and call a plaquette MIXED if it spans one direction from each side.
X_∞ := all mixed plaquettes = E(ℤ²₁₂) × E(ℤ²₃₄) (the 2-cells of the product of the two plane grids). (a) Every star of every subset of
X_∞ is a subgraph of K_{4,4} (parts {±e₁, ±e₂}, {±e₃, ±e₄}), hence bipartite and triangle-free: NO SUBSET OF X_∞ HAS A CLOSED UNIT
3-CUBE (equivalently: any three of the four axes contain a same-side pair, so every 3-cube has a non-mixed face). (b) X_∞ has every
link four-fold and every star equal to K_{4,4} — the β kind of Corollary I. (c) By Mantel's theorem a triangle-free graph on 8 vertices
with 16 edges is K_{4,4}, and K_{4,4} ⊂ K_{2,2,2,2} forces each part to be closed under ±: the triangle-free β stars are EXACTLY the
three axis splits. ∎
**Theorem C (no cube discharging below 1/2).** Let A be the checkerboard graph of an m × m square of ℤ² (the boundaries of the squares
with x + y even; every vertex has degree 2·#black squares at it ∈ {2, 4}, so A is Eulerian), m odd, s := m − 1. Let
R_m := A × A (products of edges, in the two planes), and S_m := ⋃_{i,j} H_i × D_j ∪ ⋃_{k,l} V_k × D′_l, where in each plane the
H-rectangles [−1, s+1] × [2i, 2i+1] and V-rectangles [2k, 2k+1] × [−1, s+1] (i, k = 0 … s/2 − 1) are edge-disjoint and cross at the s²
points of [0, s−1]² (and D, D′ are the same rectangles in the 3,4-plane): flat tori meeting pairwise in pinch points, each pinch a star
of two disjoint 4-cycles (kind α). Glue R_m (in the positive orthant, its corner star {e₁,e₂} × {e₃,e₄}) to a translate of S_m at one
vertex (a torus corner with star {−e₁,−e₂} × {−e₃,−e₄}). Then X_m := R_m ∪ S_m is a finite set of MIXED plaquettes, every link even,
1-skeleton connected, and
  χ(X_m) = χ(A)² − s⁴ − 1 = −1,   F(X_m) = 4(m²+1)² + 2(m−1)²(m+2)²,   Q(X_m) = b₁(G) = 3(m−1)⁴ + 1   (G₆ = ∅),
so Q/F → 1/2. X_m satisfies every input of a cube discharging — the vertex stars and multiplicities, V − L + F ≤ 2, the lattice
boundary for X, G and G₆, and the cube constraint (vacuously, Lemma C1 (a)) — so NO argument from these inputs proves c′ < 1/2.
[DATED NOTE 08:3x, §8: S_m is all pinches, so an argument that ALSO uses the pinch count (Lemma P, b₁(X) ≥ Σ(c(L_v) − 1)) is not
excluded by X_m; §8 replaces S_m by the pinch-free saddle phase H⊗H + V⊗V + W⊗W and re-reads the family (K7): Theorem C holds with
Lemma P among the inputs. The statement above is left as first written.]
*Proof (desk; the machine check is §3).* χ(A) = −(m−1)² (E(A) = 2(m²+1), V(A) = (m+1)², connected). R_m: χ = χ(A)², links e × w carry
deg_A(w) ∈ {2, 4} plaquettes (even), contact exactly where deg_A = 4, i.e. at the (m−1)² interior points; G = E(A) × V⁴ ∪ V⁴ × E(A):
E(G) = 4(m²+1)(m−1)², V(G) = 2(m+1)²(m−1)² − (m−1)⁴, connected, so b₁(G) = 3(m−1)⁴ + 1. S_m: Σ|H_i| = s² + 3s per family, F(S) =
2(s²+3s)², every link two-fold (no contact), χ(S) = Σχ(tori) − #pinches = −s⁴. Gluing at one vertex: χ(R) + χ(S) − 1. ∎
*Why this is the obstruction and not an artefact.* The block R_m is Corollary I's β kind with G four-dimensional bulk; the balancing
α saddles are S_m's pinches; both are triangle-free. Cubes kill only γ-bulk (a full star is the corner of 32 cubes, all of whose far
faces would sit at γ neighbours). The four-fold sector is exactly the sector that binds the certificate (Lemma S (d) with b₁(G₆) = 0
gives (2(1+δ₁))^{b₁(G)}), so the cube constraint, however discharged, buys NOTHING for β*.
What kills R_m in a Z₂-minimal set: every unit tesseract T = s₁ × s₂ (s₁, s₂ unit squares of the two planes) inside it carries the
closed flat torus ∂s₁ × ∂s₂ (16 mixed squares) — a closed proper subset. S_m is killed only globally (each torus H_i × D_j is closed).

---------------------------------------------------------------------------------------------------------------
## 3. STAKES FOR THE MACHINE CHECKS (written before any of the programs below has run)

(K1) STAR CENSUS (`stars.c`, all 2¹⁷ − 1 = 131,071 nonempty even stars of K_{2,2,2,2}): α (2-factors) 1,035 stars, β (4-regular,
all-four-fold) 1,035, γ 1 (M1's lp_check counts); triangle-free β stars EXACTLY 3 (the axis splits, Lemma C1 (c)); triangle-free α
stars exist and include the two-4-cycle stars; γ has 32 triangles. The per-vertex identity of Theorem I holds on every star.
(K2) THE FAMILY (`family.c`, m = 5, 9, 17, 33): every link even; every plaquette mixed; no closed unit 3-cube found by direct
enumeration; χ = −1; F and Q equal the closed forms of Theorem C (m = 5: F = 4272, Q = 769; m = 9: F = 42384, Q = 12289; m = 17:
F = 521232, Q = 196609; m = 33: F = 7261200, Q = 3145729; Q/F = 0.180, 0.290, 0.377, 0.433); the 1-skeleton connected; Theorem I's
identity holds to the integer (both sides computed independently: F/2 + 1 − Q against Δ(G) + Δ(G₆) + (2 − χ) + (1/8)[Σ(8−a) − 8]).
(K3) THE REPLACEMENT LEMMA'S FIRST TEST (`tess.c`): every unit tesseract of R_m's interior carries a closed torus; in the facet
language of §4, its missing squares form exactly two components ({1,2}-facets, {3,4}-facets).

**RESULTS (K1–K3), 2026-11-02 07:39–07:43; records `stars.txt` (stars.c md5 a963958e…), `family_m{5,9,17,33}.txt` (family.c md5
f980ec0a…): EVERY STAKE HELD.**
(K1) 131,071 even stars; Theorem I's per-vertex identity 0 failures; α 1,035 (3+5: 192, all with a triangle — the hand count
32 triangles × 6 Hamilton cycles of K₅ − e; 4+4: 99; 8-cycles: 744; triangle-free 843), β 1,035 of which EXACTLY 3 triangle-free (the
three axis splits, printed), γ 1 with 32 triangles; 9,248 triangle-free even stars in all.
(K2) m = 5, 9, 17, 33: collisions 0, every link even, every plaquette mixed, closed unit 3-cubes 0 (direct enumeration), χ = −1,
1-skeleton one component, G₆ = ∅, and F, Q equal to the closed forms MET at every m: Q/F = 0.180009, 0.289944, 0.377201, 0.433224
(F = 7,261,200 and Q = 3,145,729 at m = 33). Theorem I (×8) met to the integer at every m (m = 33: 3,878,976 both sides).
(K3) every tesseract carrying a closed subset carries exactly the flat-torus pattern (16 mixed squares, missing squares in two facet
components): 289 = 17², 4,225 = 65², 66,049 = 257², 1,050,625 = 1025² — one per pair of unit squares of A with boundary in A (the black
squares and the interior white ones), all in R_m; none in S_m. THEOREM C STANDS ON THE MACHINE: the cube constraint gives c′ = 1/2.

---------------------------------------------------------------------------------------------------------------
## 4. THE REPLACEMENT LEMMA: THE UNIT TESSERACT — AND ITS OWN CEILING

**Lemma T0 (the tesseract constraint in the facet graph).** A unit 4-cube T has 24 squares and 8 cubic facets; each square lies in
exactly two facets of T, and two facets share a square iff they are not opposite, so (facets, squares) is the octahedral graph
K_{2,2,2,2} again. The Z₂ 2-cycles of T's 2-skeleton are the boundaries of facet sets C, i.e. the edge CUTS δ(C) of that graph. Hence:
for Z₂-minimal X ⊄ T, X ∩ T contains no closed subset ⟺ the squares of T MISSING from X connect all 8 facets (≥ 7 of them, a
spanning connected subgraph). The cube constraint is the special case C = one facet (no isolated facet). ∎
Within X_∞ (Lemma C1) the mixed squares of T are the edges between the {1,2}-facets and the {3,4}-facets (a K_{4,4}), whose only
nonzero cut is the whole K_{4,4}: so for X ⊂ X_∞ the tesseract constraint says exactly "no unit tesseract has all 16 mixed squares",
i.e. no flat unit torus ∂s₁ × ∂s₂. It kills R_m (§3 (K3)).
**THE CEILING (desk, written before tessfam.c exists).** Closed subsets of X_∞ are Z₁(ℤ²) ⊗ Z₁(ℤ²) (a mixed 2-chain is a matrix over
edges × edges whose columns are cycles of plane 12 and rows cycles of plane 34). Remove from the four-fold block the closed set P × P,
P = the horizontal edges on the even rows (each unit square has an edge in P, and each removed square sits in exactly four unit tori,
so the density r of removed squares per vertex is r ≥ 1/4, attained here). Every link loses 0 or 2 squares; per vertex F = 4 − r,
two-fold links 2r, b₁(G) ≈ 3 − 2r, χ ≈ 1 − r, balanced by (1 − r) pinch saddles of F-weight 2: Q/F → (3 − 2r)/(6 − 3r) = 10/21 at r = 1/4.
So the tesseract constraint, however discharged, CANNOT PROVE c′ < 10/21 ≈ 0.47619 — the whole value of the replacement lemma is at
most 1/2 − 10/21 = 1/42 in the exponent.
**The finite family (tessfam.c).** In each plane A := H ∪ H′ ∪ V (H_i = ∂([−1, s+1] × [4i, 4i+2]), H′_i = ∂([−2, s+2] × [4i+1, 4i+3]),
V_k = ∂([2k, 2k+1] × [−1, s+1]), s ≡ 0 mod 4; pairwise edge-disjoint, crossings of degree 4 at the s² points of [0, s−1]²), P := H (the
even rows); R′_s := A × A ⊕ H × H (closed: a sum of two closed sets); glued at the corner (−2, 1)² to a pinch-torus S of sizes (s₁, s₂)
chosen to make χ ≤ 2 at least F.
STAKES (K4), before the first run: for s = 8, 16, 32: collisions only the |H|² removals; every link even; every plaquette mixed; closed
unit 3-cubes 0; EVERY unit tesseract free of closed subsets (missing squares connect the facets: 0 failures); χ ≤ 2; 1-skeleton
connected; G₆ = ∅; Theorem I met; Q/F rising toward 10/21 from below, with s = 32 in [0.40, 0.46]; and the next scale kills it: the
24-square tori ∂([x, x+1] × [4i+1, 4i+3]) × ∂(unit square of A) (inside a 1 × 2 × 1 × 1 box, two tesseracts) are present, in number
of order s⁴.

**RESULTS (K4), 2026-11-02 07:52–07:58; records `tessfam_s{4,8,12,16,20,24,32}.txt` (the s ≤ 24 runs md5 of the widened-search
build; s = 32 md5 b17587b8…, the same program with the box sized to the S it chose), `fitpoly.txt`.** First runs (s = 8, 16) capped
S's sizes at s and overshot χ (−769, −14,337): not "least F" as staked, so the search was widened (2s, then 5s/4 + 2 for memory) before
any ratio was read as a result.
- HELD at every s = 4 … 32: collisions only the |H|² removals; every link even; every plaquette mixed; closed unit 3-cubes 0; unit
  tesseracts carrying a closed subset **0** (of 4,283 … 2,802,819 tesseracts touched); χ ≤ 2 (s = 32: exactly −1, S = (28, 32) with
  896² = 802,816 pinches = χ(R′)); one skeleton component; G₆ = ∅; Theorem I (×8) met to the integer; the next scale's 24-square tori
  present at order s⁴ (91, 1,653, 8,911, 29,161, 72,771, 153,181, 493,521).
- THE EXACT QUARTICS (Newton's form on five sizes, the sixth met; fifth differences 0): F(R′) = (15/4)s⁴ + 30s³ + 60s²,
  χ(R′) = (3/4)s⁴ + (1/2)s³, b₁(G) = (5/2)s⁴ + 2s³ + (1/4)s² + 1, V = s⁴ + 15s³ + 54s², L = 4s⁴ + (89/2)s³ + 114s² — leading coefficients
  EXACTLY the desk ceiling's 4 − r, 1 − r, 3 − 2r at r = 1/4. With S's F/pinch → 2: **Q/F → (5/2)/(15/4 + 3/2) = 10/21.**
- REFUTED: "s = 32 in [0.40, 0.46]". Read: Q/F = 0.143, 0.232, 0.280, 0.313, 0.343, 0.361, **0.388275** at s = 4 … 32. The s³
  coefficient of F(R′) is eight times its s⁴ coefficient (the H′ and V ends, the crossings off the square), so the approach to 10/21
  is like 1 − O(8/s); the stake priced the corrections at half their size. The limit is carried by the quartics, not by any one run.
**THEOREM T (the tesseract constraint's ceiling).** The family X′_s is a finite even set of mixed plaquettes with connected 1-skeleton,
χ ≤ 2, no closed subset in ANY unit 4-cube (hence no closed 3-cube), and Q/F → 10/21. So no argument from the vertex stars, the
Euler identity, the lattice boundary and the unit-tesseract constraint proves c′ < 10/21. What kills X′_s: the 24-square torus
∂([x, x+1] × [4i+1, 4i+3]) × ∂(unit square) inside a 1 × 2 × 1 × 1 box — two adjacent tesseracts.
[DATED NOTE 08:3x, §8: the S of this family is all pinches; with Lemma P among the inputs it is replaced by the pinch-free saddle
phase and re-read (K8): Theorem T holds with Lemma P. The statement above is left as first written.]

---------------------------------------------------------------------------------------------------------------
## 5. THE CERTIFICATE AT THE EXPONENT THE CUBES GIVE, AND THE PRICE OF THE CEILINGS

The cube constraint gives c′ = 1/2 (Theorem C), so the certified S12-free number is Corollary U″'s, which M1R is re-running in full;
it is NOT re-scanned here. Read here only (i) the control of this folder's engine at U″'s two decisive points, and (ii) projections
through a new mode of a copy of the engine, `kp_cert_m1b.awk` = `kp_cert_m1.awk` + UPQ (exponent c′ = UPN/UPD, constant C₀ = UC0:
K₁ = B^{c′}, C₁ = (1+δ₁)B^{C₀}, K_I = 4^{c′}ε₁, C_I = 4^{C₀}, every root the least grid point above; inert when unset; (1, 2, 1) is U12).
STAKES (before the runs):
(P-a) `kp_cert_m1b.awk` with UPQ unset is character-identical to `kp_cert_m1.awk` in U12 mode at β = 0.3650 and 0.3652, α = 0.0045
(page, F₀ = 22, T1 + T2, NCSIG); with UPQ = (1, 2, 1) in place of U12 the verdicts and the printed K₁, C₁, K_I, rK₁ are identical.
(P-b) At c′ = 1/2: PASS at 0.3650 (LHS below α = 0.0045), FAIL at 0.3652 by "the inequality's upper end is above alpha" — U″'s number.
(P-c) THE TESSERACT CEILING PRICED: at c′ = 10/21, C₀ = 1 (page, F₀ = 22) the projected β* ∈ [0.368, 0.374] — the most ANY lemma proved
from the unit-tesseract constraint could buy (Theorem T), since such a lemma has c′ ≥ 10/21.
(P-d) iii-08's hoped slope 1/2.4 = 5/12 (refuted as a consequence of the cube constraint, §0 (iii)), priced as a projection at C₀ = 1:
β* ∈ [0.375, 0.390].

---------------------------------------------------------------------------------------------------------------
## 6. THE FLOOR OF EVERY LOCAL ARGUMENT: THE FLAT CONTACT CONFIGURATION X₃ (found 08:0x writing §5; desk first)

**Lemma F (mixed closed sets are a tensor product).** A finite set M of mixed plaquettes, read as a 0/1 matrix over (edges of the
12-plane) × (edges of the 34-plane), is closed iff every row is a cycle of the 34-plane and every column a cycle of the 12-plane, i.e.
M ∈ Z₁(ℤ²) ⊗ Z₁(ℤ²); and since H₁ = H₂ = 0 for finite chains of the plane, M = (∂ ⊗ ∂)(N) for a unique finite N ∈ C₂ ⊗ C₂. ∎
**Theorem X₃.** Let X₃ := all mixed plaquettes except those spanned by (e₂, e₄) (the "vertical × vertical" ones). Then
(a) every link is even: links along e₁, e₃ are four-fold, along e₂, e₄ two-fold; every star is K_{4,4} minus {±e₂} × {±e₄}: a = 8,
d = 12, e = 4, K = 0, κ = 0 — FLAT at every vertex, no saddles needed, and triangle-free;
(b) X₃ CONTAINS NO FINITE NONEMPTY CLOSED SUBSET: if M ⊂ X₃ is closed, M = (∂⊗∂)(N) and M vanishes on vertical × vertical, i.e.
(∂_V ⊗ ∂_V)(N) = 0, where ∂_V is the vertical part of ∂; ∂_V is injective on finite 2-chains (row by row it is the boundary map of
finite 1-chains of ℤ, injective), a tensor product of injective maps is injective, so N = 0 and M = 0. ∎
(c) its contact graph is the stack of (e₁, e₃)-planes: b₁(G) = 1 per vertex, F = 3 per vertex, G₆ = ∅: **Q/F = 1/3.**
So X₃ satisfies, at EVERY bounded scale, every local form of minimality (no closed subset in any box), with the Euler identity
(K ≡ 0), the stars, and the lattice facts: NO ARGUMENT FROM LOCAL INFORMATION — cubes, tesseracts, boxes of any fixed size —
CAN PROVE c′ < 1/3. (On the torus T⁴_n, X₃ is a finite closed set with χ = 0, no closed subset of diameter < n, and
Q/F = (n⁴ + n²)/(3n⁴) → 1/3: the finite family for any fixed scale.)
**What X₃ is not:** a finite Z₂-minimal set. In the form A ⊗ A − V ⊗ V (A = H ⊔ V even), H = A − V is even, so any finite truncation
has a cycle x ⊂ H and x ⊗ y ⊂ X for every cycle y of A: the product-difference form is never a finite circuit. Whether SOME circuit of
Z₁ ⊗ Z₁ carries a flat contact region of positive density (Q/F bounded below by a positive constant, up to 1/3) is the global question.
STAKES (K5), before x3check.c runs: the exact GF(2) rank of the boundary map on the box [0, s]⁴, s = 4, 5, 6: the sighted control
X_∞ has deficiency (closed subsets) EXACTLY s⁴ = 256, 625, 1296; X₃ has deficiency 0 at every s; X₃'s star d = 12, a = 8, link
multiplicities (4, 2, 4, 2), K = 0.
(P-e) THE ABSOLUTE FLOOR OF THE LOCAL ROUTE PRICED: c′ = 1/3, C₀ = 1, page F₀ = 22: projected β* ∈ [0.395, 0.415].

**RESULTS (K5, P-a … P-e), 2026-11-02 08:02–08:10; records `control.txt` (+ `ctl_{a,b,c}_365{0,2}.txt`), `x3check.txt` (x3check.c md5
1636e791…), `bisect_upq_{10_21,5_12,1_3}_page_F22.txt` (kp_cert_m1b.awk md5 46dbc165…): EVERY STAKE HELD.**
(K5) control X_∞: deficiency 256, 625, 1296 = s⁴ exactly (MET); X₃: squares 1200, 2700, 5292 at s = 4, 5, 6, rank = squares,
deficiency 0; star d = 12, a = 8, multiplicities (4, 2, 4, 2), K = 0. Theorem X₃ (b) stands on an exact rank, with its sighted control.
(P-a) `kp_cert_m1b.awk` with UPQ unset: character-identical to `kp_cert_m1.awk` (U12) at both points; UPQ = (1, 2, 1): character-
identical to U12 (K₁ 1.53446387, C₁ 2.772022, K_I 0.27425485 at 0.3650). The projection mode is controlled.
(P-b) THE CERTIFIED S12-FREE NUMBER AT THE EXPONENT THE CUBES GIVE (c′ = 1/2, Corollary U″; page, F₀ = 22, T1 + T2, NCSIG):
  β = 0.3650, α = 0.0045: LHS ∈ [0.0000455, 0.0044583] ≤ α = 0.0044999 → PASS; margin 4.16·10⁻⁵ (0.92 % of α); tail 0.0044127 of
  it (99.0 %), rK₁ = 0.760449, r = 0.495580, δ₁ = 0.17729; M1's scan: PASS for α ∈ [0.0039, 0.0050].
  β = 0.3652, α = 0.0045: LHS_hi = 0.0045444 > α → FAIL ("the inequality's upper end is above alpha"); M1's scan: no α passes.
(P-c) THE TESSERACT CEILING PRICED (c′ = 10/21, C₀ = 1): **β* = 0.3706** (PASS α ∈ [0.0036, 0.0052]), refused at 0.3708 — the
  most any lemma from the unit-tesseract constraint can buy is +0.0056 (a projection: no such lemma is proved).
(P-d) iii-08's 5/12 (C₀ = 1): β* = 0.3854, refused at 0.3856 (a projection of a hypothesis the cube cannot supply, §0 (iii)).
(P-e) THE FLOOR OF THE LOCAL ROUTE (c′ = 1/3, C₀ = 1): **β* = 0.4068** (PASS α ∈ [0.0039, 0.0046]), refused at 0.4070.

---------------------------------------------------------------------------------------------------------------
## 7. WHAT THE TASK RETURNS

1. **c′ from the cube constraint = 1/2, exactly (Theorem C, §2; machine §3).** The obstruction: the cube constraint sees only
   triangles in vertex stars (Lemma C0); the four-fold extremal of Lemma E4 is realized by the triangle-free K_{4,4} stars (the only
   triangle-free β stars, Lemma C1 (c)), i.e. by MIXED plaquettes, and no set of mixed plaquettes has a closed 3-cube. The family
   X_m = (A × A) ∪ (pinched tori), χ = −1, F = 4(m²+1)² + 2(m−1)²(m+2)², Q = 3(m−1)⁴ + 1, attains 1/2 asymptotically. Cubes kill
   only the six-fold bulk (γ), which does not bind the certificate.
2. **The extremal configurations, exactly (Theorem I, §1):** F/2 + 1 − Q = Δ(G) + Δ(G₆) + b₁(X) + (1/8)[Σ(8 − a_v) − 8], every
   bracket ≥ 0; equality up to o(F) iff the vertices are α (2-factor), β (4-regular all-four-fold) or γ (full) in bulk with
   b₁(X) = o(F). Any c′ < 1/2 is equivalent to forcing those deficits to be linear in F.
3. **The next constraint and what it is worth (§4):** the unit tesseract — X ∩ T has no closed subset ⟺ T's missing squares connect
   its 8 facets in the octahedral facet graph. It kills the K_{4,4} bulk (the flat unit torus) but NOT below 10/21 (Theorem T,
   exact quartics, Q/F → 10/21); its price is at most β* 0.3650 → 0.3706.
4. **The floor of every local argument (§6, Theorem X₃): 1/3.** X₃ (mixed squares minus vertical × vertical) is flat, has no finite
   closed subset (∂_V ⊗ ∂_V injective), and Q/F = 1/3; no constraint of bounded size proves c′ < 1/3, and the local route is capped
   at β* 0.4068 (projection, C₀ = 1).
5. **The certified S12-free β* at the exponent proved here is U″'s: 0.3650 (page) PASS, 0.3652 FAIL, margin 4.2·10⁻⁵ at α = 0.0045
   (P-b); tree 0.3656 by M1's record.** M1R holds the full re-run; nothing here moves it.
6. **THE NEXT OBJECT (global, not local):** the circuits of Z₁(ℤ²) ⊗ Z₁(ℤ²) — the Z₂-minimal sets of the mixed sector — and the
   supremum of their contact density. A finite minimal set cannot be a product-difference A ⊗ A − V ⊗ V (§6), so X₃ itself is not
   one; whether a circuit carries a flat contact region of positive density decides whether a positive contact density (up to
   X₃'s 1/3) is attained by minimal sets at all. Instrument: the exact GF(2) rank (x3check.c's engine: a set is Z₂-minimal iff its
   boundary map has deficiency exactly 1) on cappings of X₃-regions, and the rank decomposition M = Σ x_k ⊗ y_k on the theory side
   (contacts are rows Σ_{k: e ∈ x_k} y_k with a degree-4 vertex). Below 1/3 needs a lemma that uses global minimality — that a minimal
   X has no closed proper subset of UNBOUNDED size — in an essential way.

---------------------------------------------------------------------------------------------------------------
## 8. THE PINCH COUNT (the advisor's review, 08:1x) — A REAL GAP IN §2 AND §4, AND ITS REPAIR

**Lemma P (the pinch count; iii-08's "the double point's +2 is paid by b₁", made a lemma).** For Z₂-minimal X,
b₁(X) ≥ Σ_v (c(L_v) − 1), c(L_v) the number of components of the star. *Proof.* Unpinch every vertex into one copy per star
component: plaquettes and links are unchanged, so the closed subsets are unchanged (b₂ = 1), and the result is connected (a
component would be a closed proper subset); χ rises by Σ(c − 1), and χ(unpinched) = 2 − b₁(unpinched) ≤ 2. ∎
So Theorem I has a stronger bracket, b₁(X) ≥ P, and Corollary I's α kind must have CONNECTED stars (single 8-cycles, 744 of them,
all triangle-free) for zero slack. §2's S_m and §4's S are made of pinches (~s⁴ of them): an argument using cubes AND Lemma P is NOT
excluded by X_m or X′_s (a minimal set with their pinches would pay b₁ ≈ F/6 and drop to ≈ 1/3). Theorems C and T AS FIRST STATED
exclude only arguments that do not use Lemma P. X₃ is immune (connected stars, K ≡ 0, no saddles).
**THE CONNECTED-SADDLE PHASE (K6, `saddle8.txt`, `saddle8_check.txt`; the search ran before any stake was written — an existence
search, its witness checked on a second road):** among period-2 mixed configurations, 144,930 have every link two-fold with all eight
links at every vertex, and 5,760 of them have EVERY star a single 8-cycle. Witness, on the 4-torus T⁴_n (n = 4, 6), square by square:
every half-axis two-fold, every star one 8-cycle, F = 2n⁴, χ = −n⁴ — a closed surface of octagon saddles with no pinch. Its form:
M_S = H ⊗ H + V ⊗ V + W ⊗ W (H, V the horizontal and vertical lines, W the unit squares at odd–even corners): the pinched planes plus
a lattice of unit tori, each of which cancels one square of each crossing sheet and adds the two bridging squares, turning every
pinch into ONE 8-cycle.
STAKES (K7), before `family2.c` (= family.c with S replaced by H⊗H + V⊗V + W⊗W, W truncated to the crossing square) runs:
(i) control NOW=1 (W⊗W omitted, i.e. X_m): P ≥ s⁴ and the pinch inequality χ ≤ 2 − P FAILS; (ii) with W⊗W: every link even,
every plaquette mixed, closed 3-cubes 0, P = O(s³) (boundary only), connected octagon saddles ≈ s⁴, and for some even s ≤ m + 3 the
pinch inequality HOLDS, with Q/F within 0.03 of X_m's at m = 17 (0.377) — the repaired family attains 1/2 asymptotically against
cubes + Lemma P.

**RESULTS (K7), 2026-11-02 08:23; records `family2_now_m*_s*.txt` (control) and `family2_m*_s*.txt` (family2.c): EVERY STAKE HELD.**
(i) control (X_m, pinched): P = s⁴ + 1 (4,097 at (9, 8); 65,537 at (17, 16)) and the pinch inequality FAILS at every size — the gap is
real. (ii) resolved S = H⊗H + V⊗V + W⊗W: P = 1 at every size (the glue vertex alone), connected octagon saddles exactly s⁴ (4,096;
10,000; 65,536; 104,976; 160,000), χ ≤ 2 − P HOLDS already at s = m − 1 (χ = −545 at (9, 8), −4,225 at (17, 16)), every link even,
every plaquette mixed, closed 3-cubes 0, Theorem I met, Q unchanged (12,289; 196,609), Q/F = 0.286697 (9, 8) and 0.374351 (17, 16)
against X_m's 0.289944 and 0.377201. The resolution costs O(s³) in F and in χ; Q/F → 1/2 as before.
**THEOREM C, REPAIRED: the cube constraint gives c′ = 1/2 even with Lemma P (the pinch count) among the inputs** — the family
R_m ∪ (H⊗H + V⊗V + W⊗W) satisfies the stars, χ ≤ 2 − P, the lattice boundary and the cube constraint, with no pinch but the glue.
STAKES (K8), before `tessfam2.c` (= tessfam.c with S resolved by W⊗W and the pinch count read) runs at s = 16, 24: control NOW=1 P ≈ s₁²s₂²
and the inequality FAILS; resolved: P = O(s³), the pinch inequality HOLDS, unit tesseracts carrying a closed subset 0 (an 8-cycle star
contains no 4-cycle, so no corner of a saddle-bulk tesseract carries its four orthant squares and the flat torus cannot close), cubes
0, Q/F within 0.01 of K4's 0.313131 and 0.361031.

**RESULTS (K8), 2026-11-02 08:2x; records `tessfam2_now_s{16,24}.txt`, `tessfam2_s{16,24}.txt` (tessfam2.c): EVERY STAKE HELD.**
Control: P = 57,601 and 262,145, the pinch inequality FAILS. Resolved: P = 1 (the glue), connected octagon saddles 57,600 and 262,144
(= s₁²s₂²), χ = −10,361 and −18,945 ≤ 1 = 2 − P (HOLDS), unit tesseracts carrying a closed subset 0 (of 260,975 and 1,019,155), closed
3-cubes 0, Theorem I met, Q/F = 0.311026 and 0.359211 against K4's 0.313131 and 0.361031. R′ itself has no pinch at all.
**THEOREM T, REPAIRED: the unit-tesseract constraint cannot prove c′ < 10/21 even with Lemma P among the inputs.**

---------------------------------------------------------------------------------------------------------------
## 9. SCOPE (each line would read differently had the result gone the other way)

- The families of Theorems C and T are VERTEX-connected (R and S share one vertex); a Z₂-minimal set is link-connected. An argument
  that uses link-connectivity beyond b₀ = 1 and Lemma P is not excluded by them as built; gluing along one link (a single extra
  four-fold contact) is the obvious repair and was not run.
- Theorem X₃'s finite witness is the 4-torus: it excludes bounded-range (local) arguments, i.e. any rule that reads a ball of fixed
  radius, on the torus and in the bulk of ℤ⁴; a capping of X₃ inside ℤ⁴ that keeps every bounded ball acyclic is owed, so "no argument
  below 1/3" is proved for local arguments, not for every argument about finite subsets of ℤ⁴.
- iii-08's "≤ 6.5": read as the X-degree ℓ_X averaged over contact vertices (the relay's own wording); the K_{4,4} bulk has 8 there
  (G-degree 8), X₃ has X-degree 8 and G-degree 4 at every vertex. Both are cube-free; X₃ is also free of every local closed subset.
- The projections of §5 assume the hypothesised bound in the form b₁(G) + b₁(G₆) ≤ c′F + 1 AND b₁(G) ≤ c′F + 1 (C₀ = 1); none of them
  is a certified number of any proved lemma.

## 10. THE ANSWER, CORRECTED BY §8 (supersedes §7 where they differ)

1. c′ from the cube constraint = 1/2 exactly, against cubes + stars + Euler + lattice boundary + the pinch count (Theorem C repaired,
   K2 + K7): the binding four-fold sector is realized by triangle-free K_{4,4} stars, balanced by a pinch-free octagon-saddle phase
   M_S = H⊗H + V⊗V + W⊗W; Q/F → 1/2.
2. Theorem I: the slack of 1/2 is exactly Δ(G) + Δ(G₆) + b₁(X) + (1/8)[Σ(8 − a_v) − 8] with b₁(X) ≥ P (Lemma P).
3. The next constraint, the unit tesseract (missing squares connect the facet octahedron), is worth at most 1/42 in the exponent:
   10/21 is attained against it (Theorem T, exact quartics, repaired), β* 0.3650 → at most 0.3706 (projection).
4. Every local constraint stops at 1/3 (Theorem X₃: flat, connected stars, no finite closed subset, Q/F = 1/3): the local route is
   capped at β* 0.4068 (projection).
5. Certified S12-free β* at the proved exponent: 0.3650 page PASS (margin 4.16·10⁻⁵ at α = 0.0045), 0.3652 FAIL — U″'s number,
   controlled here at its two points; M1R holds the full re-run.
6. Next object (global): the Z₂-minimal sets of the mixed sector are the circuits of Z₁(ℤ²) ⊗ Z₁(ℤ²). Does a circuit carry a flat
   contact region of positive density? If yes, c′ ≥ that density for EVERY argument; if no, the proof of "no" is the lemma below 1/3.
   Instruments: the exact GF(2) rank (minimal ⟺ deficiency exactly 1) on cappings of X₃-regions; the rank decomposition Σ x_k ⊗ y_k.
