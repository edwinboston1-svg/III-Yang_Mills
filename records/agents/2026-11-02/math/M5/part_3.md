
---

## 3. THEOREM 4.1'S ROUTE AT β = 2.2 WITH BLOCKS OF SIDE 2–4: REFUTED, WITH THE EXACT OBSTRUCTION AND THE REPLACEMENT

**The record already holds the one-link theorem** (the aperanton gate's verdict line, "STAGE IV'S AND STAGE III'S FIRST NUMBERS: the SU(2)
one-link Dobrushin coefficient: the flip exactly L_1(beta)/I_1(beta), the one-link criterion failing above beta* = 0.13103"). The flip is
TV(vMF(βe), vMF(−βe)) = L₁(β)/I₁(β): with t = ⟨u, e⟩ distributed as (2/π)√(1 − t²)dt under the uniform law on S³ and Z = 2I₁(β)/β,
TV = (4/π)∫₀¹ sinh(βt)√(1 − t²)dt / Z, and ∫₀¹ sinh(βt)√(1 − t²)dt = (π/(2β))L₁(β) (the Struve integral). What the fibre route needs in
addition is that the flip is REALISED INSIDE THE FIBRE. It is.

**Theorem 3.1 (the fibre's one-link coefficient at β).** Let a_c ≥ 2 (fine units), the coarse paths the straight segments of THE GROUND's
map, and the gauge fixing T of axial type (fixed links in one direction ≠ 1; for direction 4 below). Let e be the fine link from
x = (1, 1, 1, 1) in direction 1. Then:
(a) e and all eighteen links of its six staples lie on no coarse path: a fine link from z in direction μ lies on a coarse path iff z_ν ≡ 0
(mod a_c) for every ν ≠ μ, and each of the nineteen links has a coordinate equal to 1 among its ν ≠ μ (checked one by one: (x, ν), (x+ê₁, ν),
(x+ê_ν, 1), (x−ê_ν, ν), (x+ê₁−ê_ν, ν), (x−ê_ν, 1), ν = 2, 3, 4).
(b) The fibre's conditional law of U_e given every other free link is the Wilson single-link law vMF(βW), W = Σ_{p∋e} S_p (no holonomy
constraint involves U_e), and the six staples S_p are independent and each ranges over all of SU(2) as the fibre configuration varies:
each staple has a free link private to it (two plaquettes through e share only e), off every path (by (a)), not fixed by T (the four
staples in the planes (1,2), (1,3) have no direction-4 link; the two in (1,4) keep their far direction-1 link).
(c) Hence for every free staple link b of e — at least fourteen of the eighteen under any axial T, all eighteen when T fixes none of
them — the fibre's interdependence coefficient satisfies C_fib(e, b) ≥ L₁(β)/I₁(β): set the five other staples to five unit quaternions
summing to zero (the vertices of a regular 4-simplex inscribed in S³; realisable by (b)) and turn b so that its staple goes from S to −S.
The row sum at e is at least 14 L₁(β)/I₁(β) (at least 18 L₁(β)/I₁(β) when no staple link is fixed).

**Computation (flip_tv.awk, record rec/flip_tv.txt; exact rationals, partial sums to 60 terms with tails ≤ twice the first omitted term,
π ∈ [π₋, π₋ + 10⁻³⁵], digits floored/ceiled).** Known answers MET first: (i) small β, (L₁/I₁)/(4β/(3π)) = 0.999999941666… at β = 10⁻³,
→ 1 (THE GROUND §8.1's first-order coefficient 4β/(3π)); (ii) the root of 18 L₁/I₁ = 1 lies in [0.13103, 0.131031] (the gate's 0.13103).
At β = 11/5: **L₁/I₁ ∈ [0.735601941590, 0.735601941591]; 18 L₁/I₁ ∈ [13.2408349486, 13.2408349487]; 14 L₁/I₁ ≥ 10.2984.** (At β = 1/4:
0.1057; at 0.4764: 0.1996, 18× = 3.592.)

**Corollary 3.2 (Theorem 4.1's hypothesis fails at β = 2.2, at every a_c, by a factor the fine coupling fixes).** The fibre Dobrushin
condition Σ_j C_fib(i, j)e^{κ_f|i−j|} ≤ α_f < 1 fails at e already at κ_f = 0: the row sum is ≥ 10.29 (≥ 13.24). Nothing about a_c enters:
the obstruction is the single link at β = 2.2, inherited unchanged by the fibre because the fibre's off-path conditionals are Wilson's.
REFUTED: the route "(W-V) from a fibre Dobrushin condition at β = 2.2 with blocks of side 2–4". Not refuted: (W-V) itself.

**Block and constrained forms.** (i) Blocks with first-order transmission: THE GROUND §8.3's own paragraph — no Dobrushin–Shlosman block
criterion gains on the single link at any side, a link deep in a block branching to its eighteen neighbours exactly as in the full lattice.
(ii) Even granting any block condition, the comparison theorem's bound |ν^f(Φ) − ν(Φ)| ≤ Σ δ_B(Φ)D(B, B′)b_{B′} has D ≥ I and, at a_c ≤ 4, the
twist's block and the probe's block at block distance ≤ 1: no decay factor is available, and the prefactor is O(β) = O(2.2) against the
needed ≲ 10⁻² (per neighbour, §2's 0.11/π for the integrand). (iii) Constrained forms (the holonomy constraints themselves): they bind
only links ON the paths; Theorem 3.1 lives off them. (iv) And Corollary 2.3 removes the premise of every such route: the quantity does not
decay in the twist–probe distance at all.

**THE EXACT OBSTRUCTION.** At β = 2.2 and a_c = 2–4 the fibre over v is the β = 2.2 Wilson field with a few holonomies fixed; its local
conditionals off the paths are Wilson's, with flip coefficient 0.7356 per neighbour; and what (W-V) asks of it (Corollary 2.2) is the
response of the coarse force near π_{m′} to the centre element of v_m — at coarse distance one, i.e. the COARSE COUPLING's odd part itself
(Proposition 2.5), not a fine-scale tail. A fibre condition can bound it only by first bounding the coarse coupling.

**THE REPLACEMENT LEMMA (W-V′), at the currency where the exit is decided.** (W-V) is the statement that the σ-odd part of the blocked
action is small in the norm the exit test consumes:
 (W-V′)_site  (deep strong coupling, single-site exit): Σ_n ¼Θ_{mn}(A_j)e^{κ|m−n|} ≤ α_V, Θ_{mn} = 2·osc of the σ_m-odd part of the plaquette
   and bond terms containing m and n (Proposition 2.5) — read directly on the blocked action, no fibre clause;
 (W-V′)_KP  (the record's exit, Theorem 8.9 at the blocked coefficients): the half-integer modes of the blocked action's bonds — chiefly the
   (½,½) mode of adjacent coarse plaquette pairs — priced in the certificate (they are the vortex half there; §5 finds them unpriced by the
   record's exit call and dominant on its objects).
 THE TWO-SCALE FORM (Corollary 2.2 between scales; exact): with λ_k(·|v′) the law of the scale-k coarse field given the scale-(k+1) one and
   Φ^k the scale-k coarse force, Θ^{(k+1)}_{m′n′} = sup|∫[λ_k(Φ^k_s|v′(s)) − λ_k(Φ^k_s|σ_{m′}v′(s))]ds|. So the vortex half one step up is the
   between-scale fibre's response to a coarse centre flip; where the scale-k gas is in the certificate's cone this between-scale fibre is a
   convergent polymer system and the response is a sum of KP activities — the attack, and the reason (W-V) is reached by the certificate,
   not by a fine-scale fibre: (W-V)_site one step beyond a passing exit is the strong-coupling contraction ε → O(ε⁴) of the odd coefficient
   (the 2a_c plaquette tiled by four a_c plaquettes). Owed for that last sentence: the conditioned polymer expansion written with its
   activities; not proved here.
