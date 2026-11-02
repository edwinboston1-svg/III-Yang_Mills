
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
