# S1 — THE FLUX-SURFACE GAS: the mathematics the physical picture asks for, its ceiling measured, its theorem staked (Edwin Boston III, 2026-10-29, 09:0x EDT by the clock)

> Status: three lemmas PROVED below; one measurement OF RECORD (`records/surface-gas/`); the theorem it points to is STAKED, NOT PROVED. Nothing here is claimed above β = 0.2452 until the theorem of §5 is complete. This page is about the lattice theory at strong coupling and its reach; it is not the continuum gap.

## 1. The order, and what the physical picture says

At 08:5x the operator directed that when the mathematics stalls it be related to the thing it portrays, detail by detail, until a representative mathematics emerges. The thing portrayed is the gluon field. At short distance it is a stiff medium whose stiffness is 1/g². Gluon spins align with any colour field, and that paramagnetic response outweighs the orbital screening, so the medium erodes its own stiffness by a fixed amount per doubling of scale (Wilson's β falls by 0.2575 per doubling at one loop for SU(2)). When the stiffness is of order one the medium can no longer carry spread-out colour flux: flux is squeezed into closed tubes and sheets, the confined vacuum is a gas of closed flux surfaces, and the lightest glueball is the smallest closed tube.

On the lattice at strong coupling the same picture is exact. Expanding each plaquette weight in characters and integrating the links, gauge-invariant correlation is carried only by closed surfaces of plaquettes, each fundamental plaquette costing u = I₂(β)/I₁(β).

**The mismatch this exposes in our own theorem.** Theorem 8.7 bounds influence along paths of links. Each step goes through one integrated cover link, at second order in β, and branches to 102 neighbours. The physics carries correlation only along surfaces. A path-based criterion pays the entropy of paths, about a hundred per step, where only the entropy of surfaces is owed. That is why 8.7's decay rate log(1/α)/2 sits near 0.2 at β = 0.2, where the physical rate is near −4 log u ≈ 12, and why its reach stops at 0.2452. The cell-decimation search of 16.47 (iii-38) confirms the path side is nearly exhausted: with cells of at most eight links, no design cuts the worst link's second-order load by more than 13 per cent, which is at most a factor 1.074 on the threshold.

## 2. The polymer representation and three lemmas

**What is classical here (W = 0).** The polymer representation, Lemma S1 and the surface weight of Lemma S2 are the classical strong-coupling expansion: K. Osterwalder and E. Seiler, "Gauge field theories on a lattice", Ann. Phys. 110 (1978) 440–471; the d_r^{χ} weight of a closed surface is in J.-M. Drouffe and J.-B. Zuber, "Strong coupling and mean field methods in lattice gauge theories", Phys. Rep. 102 (1983) 1–119. Lemmas S3 and S4 are a standard gauge-invariance argument made explicit and quantitative. What this page earns is the rest: the exact enumeration met on two roads, the closing-tree bound N(F) ≤ 5^{F−1}, the explicit Kotecký–Preiss reach, and the composite-tree bound of §4b. A search on 29 October found no explicit rigorous convergence radius for the four-dimensional SU(2) strong-coupling expansion in print; the classical theorems state "sufficiently small β".

Write f(U) = e^{(β/2) tr U}/c₀(β) − 1, with c₀ = 2I₁(β)/β. Then f = Σ_{j ≥ ½} d_j a_j χ_j with d_j = 2j + 1 and a_j = I_{2j+1}(β)/I₁(β), and a_{1/2} = u. On a finite torus,

Z/c₀^{|P|} = Σ_{X ⊂ P} Π_{Y} W(Y),  W(Y) = ∫ Π_{p∈Y} f(U_p) Π_{ℓ∈L(Y)} dU_ℓ,

where Y runs over the link-connected components of X and L(Y) is the set of links of Y. The integral factorises over link-connected components because each link variable appears only in the plaquettes of one component. So the theory is a polymer gas whose polymers are link-connected plaquette sets, with link-disjointness as compatibility.

**Lemma S1 (closedness).** W(Y) = 0 unless every link of Y lies in at least two plaquettes of Y.
*Proof.* If a link ℓ lies in exactly one plaquette p of Y, integrate U_ℓ first. By left invariance of Haar measure, ∫ f(U_ℓ R) dU_ℓ = ∫ f(U) dU = 0, because ∫ e^{(β/2) tr U} dU = c₀. ∎

**Lemma S2 (the weight of a branch-free surface).** Suppose Y is closed and link-connected and every link of Y lies in exactly two plaquettes of Y. Then W(Y) = Σ_{j ≥ ½} a_j^{F} d_j^{χ′(Y)}, where F = |Y|, χ′ = V′ − F, and V′ is the number of vertex cycles of Y. A vertex cycle is a cycle of plaquettes of Y around a vertex, consecutive ones sharing a link of Y at that vertex; V′ = V at every vertex where Y is locally a disc. In particular W(Y) > 0, and χ′ ≤ 2.
*Proof.* Expand each f(U_p) in characters. At a link shared by exactly two plaquettes, orthogonality gives ∫ χ_j(U A) χ_k(U⁻¹ B) dU = δ_{jk} χ_j(AB)/d_j; SU(2) characters are real, so orientations do not matter. By link-connectedness every plaquette therefore carries the same spin j. Integrating all 2F links contributes d_j^{−2F} and fuses the plaquette loops into one loop per vertex cycle, each a trace of the identity, d_j. The total is (d_j a_j)^F d_j^{−2F} d_j^{V′} = a_j^F d_j^{V′−F}. Separating pinch vertices into their cycles gives a connected closed 2-manifold of Euler characteristic V′ − 2F + F, which is at most 2. ∎
Check: the elementary cube gives W = Σ_j a_j⁶ d_j², 4u⁶ at leading order. With four cubes per site this reproduces the known strong-coupling plaquette series u + 4u⁵ + ⋯.

**Lemma S3 (factorisation across a forest).** Let Y = Y₁ ⊔ ⋯ ⊔ Y_k with each Y_i closed. If for every i the set T_i = L(Y_i) ∩ ⋃_{m≠i} L(Y_m) contains no cycle, then W(Y) = Π_i W(Y_i).
*Proof.* Integrate first the links of each Y_i outside the shared set. This leaves g_i(U_{T_i}). The integrand Π_{p∈Y_i} f(U_p) is invariant under every gauge transformation Ω on the vertices of Y_i, and Haar measure on the integrated links is invariant under Ω's action, so g_i(Ω·U_{T_i}) = g_i(U_{T_i}). Because T_i is a forest, some Ω sends every link of T_i to the identity: root each tree and propagate along its edges. So g_i is the constant g_i(1) = W(Y_i), and W(Y) = ∫ dU_S Π_i g_i = Π_i W(Y_i). ∎
Consequence: closed surfaces that touch along a forest of links, in particular along one link, do not interact at all. Interaction requires a shared plaquette or a shared cycle of links.

## 3. The measurement: how fast closed surfaces multiply

Instrument `records/surface-gas/surf.c` (sha256 fffa1b27…). It counts the connected branch-free closed surfaces through one fixed plaquette of ℤ^d. It grows the surface by always closing the smallest open link with one of the 2(d − 1) − 1 other plaquettes at that link, and refuses a plaquette already used or one that would give a link three plaquettes. Two facts make the count exact and a bound available:

- A connected branch-free surface has no proper closed sub-surface, so each surface is reached by exactly one choice sequence (DUP = 0 is checked by hash on every run).
- The tree branches at most five times per plaquette in ℤ⁴, so N(F) ≤ 5^{F−1} for every F. **This is a proved bound.**

Records `surf_d3_F20.2026-10-29a.txt` (422d6570…) and `surf_d4_F18.2026-10-29a.txt` (e41f3087…):

| F | ℤ³ (control) | ℤ⁴ | Σ 2^{χ′} in ℤ⁴ |
|---|---|---|---|
| 6 | 2 | 4 | 16 |
| 10 | 10 | 60 | 240 |
| 12 | 0 | 80 | 320 |
| 14 | 70 | 1,092 | 4,368 |
| 16 | 16 | 2,728 | 10,888 (8 Clifford tori, χ′ = 0) |
| 18 | 498 | 23,508 | 94,032 |
| 20 | 320 | running | running |

The ℤ³ control meets its hand counts: 2 cubes, 10 domino boxes, and 70 tricubes (14 straight and 56 bent). The ℤ⁴ growth per plaquette over successive steps of four is 1.97, 2.07 and 2.15. It is still creeping, so it is not an asymptotic constant (law 31). It is nevertheless far below both the crude count of connected plaquette sets (about 54 per plaquette) and the hundred-odd neighbours per step of a path.

## 4. The Kotecký–Preiss reach of the branch-free part

KP holds for this gas with a(Y) = α|L(Y)| if, for every link ℓ, S(α) = Σ_{Y∋ℓ} |W(Y)| e^{α|L(Y)|} ≤ α. By the lattice symmetry, the sum through a link is three times the sum through a plaquette. For branch-free Y, |L(Y)| = 2F. With the exact counts to F₀ = 18, Lemma S2 (spins summed, χ′ ≤ 2), and the tail F > F₀ bounded by μ^{F−1} surfaces of weight at most 4u^F, `records/surface-gas/kp_reach2.py` (639ca1e6…, record 710d1d9c…) returns:

| Tail growth μ used | KP holds for the branch-free part to β | u |
|---|---|---|
| 5 (proved, §3) | 0.5652 | 0.1394 |
| 4 | 0.7024 | 0.1721 |
| 3 | 0.9237 | 0.2231 |
| 2.5 (near the measured growth) | 1.0741 | 0.2565 |

The first row rests on proved ingredients only: the exact counts, Lemma S2 and the 5^{F−1} bound. It is the reach of the branch-free part, and it is 2.3 times Theorem 8.7's 0.2452. The last row is the ceiling the measurement suggests, about 4.4 times. Neither row is yet a theorem.

**4b. Composite polymers, included (09:3x).** Every closed polymer splits, by repeated use of Lemma S3, into irreducible closed pieces with W(Y) equal to the product of their weights. Pick a spanning tree of the pieces, each child attached at a link of its parent. The sum over all polymers through a link is then at most T, the least solution of T = s_irr(α + T), where s_irr is the same sum over irreducible pieces only: a multiset of subtrees at each link is bounded by e^{T}. So KP holds if s_irr(2α) ≤ α. With s_irr replaced by its branch-free part, `records/surface-gas/kp_reach3.py` returns 0.5465 with the proved tail (u = 0.1350), 0.6777 at μ = 4, 0.8815 at μ = 3 and 1.0035 at μ = 2.5. At the proved-tail edge the sum is dominated by the crude tail beyond F₀, not by the enumerated surfaces: the cube term is 48u⁶ ≈ 3 × 10⁻⁴ while the tail is about 10⁻². Longer enumeration and a sharper tail bound therefore move the reach directly.

## 5. The theorem staked, and what it still needs

**Theorem S (staked).** SU(2) Wilson lattice gauge theory on ℤ⁴ at 0 < β ≤ β_S has exponential clustering of local gauge-invariant observables, uniformly over the tori of even side, and its transfer matrix has a mass gap. β_S is the KP reach of the full polymer gas.

What it needs, each to be done and posted:

- **(R1) The branched and higher-spin polymers.** Every closed polymer with a link of multiplicity three or more must be bounded. Lemma S3 makes every gluing along a forest an exact product, so the remaining pieces are gluings along cycles or plaquettes, and links of odd multiplicity carrying a spin of at least 1. The route: expand each link's Haar projector in the pairing (intertwiner) basis. This writes an all-½ branched polymer as a sum over resolutions into immersed branch-free surfaces, with Gram-inverse coefficients. The immersed surfaces are counted by the same closing tree, at most five branches per plaquette. Higher spins enter by strand resolution and are suppressed by a_j/u, which is about 0.09 at β = 0.55.
  **Lemma S4 (the cut formula; proved).** Let S be a branch-free closed surface and T a set of its links, held fixed. Integrate the other links: g_S(U_T) = ∫ Π_{p∈S} f(U_p) Π_{ℓ∉T} dU_ℓ. Cut S along T. Each piece carries its own spin, and each boundary loop b of a piece, a closed loop of T-links, contributes χ_{j}(z_b), z_b its holonomy. So the all-½ term of g_S is W(S)·2^{|T| − v_T}·Π_b χ_½(z_b)/2^{n_b}·2^{n_b}, with v_T the vertex cycles of S at vertices of T and n_b the number of boundary loops. Hence |g_S| ≤ W(S)·2^{e(S,T)}·(1 + spin terms), with e(S,T) = |T| − v_T + n_b. Here e = 0 when T is a forest, which is Lemma S3 again, and e = 2 when T is one cycle. So if Y = S₁ ⊔ ⋯ ⊔ S_k with branch-free S_i, then |W(Y)| ≤ Π_i W(S_i)·2^{e_i}·(1 + spin terms), because ∫ dU_T Π_i g_i ≤ Π_i sup|g_i|.
  **Two exact computations that calibrate it.** Two 1×1×2 boxes in different three-dimensional subspaces sharing only their waist cycle: each box is two cups glued on the waist, and a cup with boundary holonomy z integrates to (2u)⁵ 2⁻⁴ χ_½(z). So W = (4u^{10})²·E[χ_½(z)⁴] = 2·W(box)², with E[(tr z)⁴] = 2, the Catalan number. Two unit cubes sharing a face q: the links of q carry three plaquettes, so q must carry spin 1. The leading term is 3a₁ (2u)^{10} 2⁻⁸ ∫ χ_½² χ₁ = 12 a₁ u^{10} = (3/4)(a₁/u²)·W(cube)², about one half of W(cube)² at β ≈ 0.5. So the smallest irreducible branched pieces weigh on the order of the product of their constituents. Their counts through a link are in the hundreds, against the cube term 48u⁶ of the branch-free sum: their contribution is below 10⁻⁷ at β = 0.55, beside a crude tail near 10⁻².
  **What closes (R1).** Lemma S5, to be proved and posted: every irreducible polymer with a link of multiplicity three or more has a strand resolution into branch-free surfaces glued along cycles (cost at most 4 per surface per independent cycle, by S4) or along shared plaquettes carrying spin at least 1 (cost by the spin factor, a_j ≤ c_j u^{2j}). The constituents are counted by the same closing tree. Each gluing needs a new closed constituent of at least six plaquettes, ten for a cycle without a shared face, so gluings are suppressed geometrically.
- **(R2) The enumeration certified on a second road** sharing no line with surf.c. **MET at 09:4x (iii-38, g45_surfaces.c, source 9f5ff265, binary e8ba9ee5).** Every finite Z₂ 2-cycle bounds a 3-chain, and a minimal filling of a connected branch-free 2-cycle is face-connected: two face-disjoint parts would have plaquette-disjoint boundaries, a link shared by them would carry four boundary plaquettes, which is a branch, and a closed part would contradict minimality. So Redelmeier's enumeration of face-connected cube sets, boundaries taken mod 2, kept when branch-free, link-connected and through p₀, deduplicated by plaquette set, returns 4, 60, 80, 1,092, 2,728 (8 with χ′ = 0) and 23,508 at F = 6..18, equal to surf.c's count at every size. Completeness by stability in the box volume: F = 18 reads 19,140, 22,740, 23,412, 23,508, 23,508 at volumes 4..8. The ℤ³ control 2, 10, 70, 16, 498, 320 is met too. Records g45_surf_d4_v3..v8.2026-10-29a.txt (v7 afaf552b, v8 1408deba).
- **(R3) The KP inequality evaluated with outward rounding**, the same discipline as Table 3.
- **(R4) The gap from KP.** Truncated correlations of local gauge-invariant observables are sums over clusters joining their supports; KP with a(Y) + κ|Y| gives decay at rate κ inside the reach. The transfer-matrix gap then follows by Theorem 7.1, as in 8.7.

**Stakes, written before the numbers they bet on exist:**
- **S1.** The ℤ⁴ counts at F = 20 and 22 keep the per-plaquette growth over successive fours in [2.15, 2.45].
- **S2.** The proved-tail reach with F₀ = 22 lies in [0.565, 0.62].
- **S3.** (R1) lowers the proved-tail reach by less than ten per cent: the smallest irreducible branched pieces have F ≥ 11, and gluings along forests are free.
- **S4.** The decay rate of Theorem S at β = 0.2 exceeds 8.7's by a factor above ten. Physically the rate is near −4 log u ≈ 12 there, while 8.7 gives below 0.25.
- **Clarification of S2, and S2′ (written 10:2x, before the F = 20 and 22 counts exist).** S2 bets on the quantity it was written against, the branch-free reach of §4's first row. The composite-included reach of §4b is a different quantity and gets its own stake. **S2′:** with F₀ = 22 and the proved tail, the composite-included reach lies in [0.546, 0.60].

**R1 at its true difficulty (10:2x).** Every crude bound on the irreducible branched pieces tried here fails asymptotically. Counting closed plaquette sets as lattice animals gives about 54^F, and with any weight per plaquette near u the sum diverges at every β above about 0.4. Counting them by the closing tree with restarts makes the restart locations grow with the size, which is superexponential. An untyped potential on the closing tree cannot certify a growth below 4.76 (iii-38's 16.49). This is the classical reason rigorous strong-coupling radii are small. The bound R1 needs is structural: it must charge only gluings along cycles, which the cut formula prices at a constant, and it must count the constituents of a gluing without paying for the location of a long shared cycle. That argument does not yet exist here. The realistic next increment on the tail is iii-38's alive-node bound (16.49), which moves the proved-tail reach toward 0.6, not to 0.88.

## 6. Where this leaves the crossing

The proved strong end is 0.2452. The ordered-datum flow measured at spins ≤ 2 (a reading, its datum share of the order of the effect) runs from the crossover 2.2 through 1.888, 1.553, 1.161, 0.662 and 0.109. If Theorem S lands near 0.57, that flow still needs five steps, because 0.662 lies above 0.57. If the measured ceiling near 1.07 is proved, it needs four. Every one of those steps is still a renormalisation step at moderate coupling, and no method in print or in this tree certifies one. The surface gas moves the strong end of the bridge. It does not cross it.

**Dimensional transmutation in this proof shape.** Every step of the bridge is a statement at its own coupling g_k. The number of steps from a bare coupling g to the strong end is K(g) = (4/g² − β_S)/0.2575 + O(log(1/g)), counted in doublings. So the physical gap is the strong end's gap times 2^{−K(g)}, which is proportional to exp(−(4 ln 2/0.2575)/g²) = exp(−10.77/g²) = exp(−8π²/(b₀g²)) with b₀ = 22/3. The exponential that perturbation theory cannot see is the step count, linear in 1/g². No Taylor series in g appears in it. This holds once each step is a certificate, which is exactly the part that is open.

## 7. Not claimed

No gap is claimed above β = 0.2452. The counts beyond F = 18 are not used. The ceiling near 1.0 rests on measured growth, not on a proof. Theorem S is staked, not proved.

## 8. The stakes read (10:3x EDT by the clock; the F = 22 run ended at 10:04 and was read after the S2′ commit f8429c0)

The count to F = 22 (`records/surface-gas/surf_d4_F22.2026-10-29a.txt`, 4,679 s, DUP = 0): **80,480 surfaces at F = 20, 320 of them tori, and 551,408 at F = 22, 352 of them tori.** The node counter in that record wrapped, because `long` is 32 bits on this platform; the surface counts are far below the wrap and unaffected.

| Stake | Bet | Read | Verdict |
|---|---|---|---|
| S1 | growth per plaquette over fours at F = 20 and 22 in [2.15, 2.45] | (80,480/2,728)^{1/4} = 2.331 and (551,408/23,508)^{1/4} = 2.201 | HELD |
| S2 | branch-free reach with the proved tail, F₀ = 22, in [0.565, 0.62] | 0.5942 (u = 0.1464) | HELD |
| S2′ | composite-included reach with the proved tail, F₀ = 22, in [0.546, 0.60] | 0.5776 (u = 0.1424) | HELD |

The two parity chains of the growth are converging from opposite sides: 1.968, 2.065, 2.154, 2.201 on F ≡ 2 mod 4 and 2.416, 2.331 on F ≡ 0 mod 4. That points to an asymptotic growth near 2.25 to 2.3. This is a reading, not a bound. At the measured growth the composite-included ceiling is 1.04. Record `records/surface-gas/kp_reach_F22.2026-10-29a.txt`. S3 and S4 wait on R1 and R4. Nothing above β = 0.2452 is claimed: the convergence condition is verified for the branch-free part and its forest composites only, and the irreducible branched pieces are not yet bounded.

## 9. Correction of this page's hour labels (written 10:13:58 EDT, read from the clock)

The hour labels written into §§1–8 were estimates, not readings of the clock, and they run ahead of it by up to half an hour. The commits carry the true times: the page and stakes S1–S4 at 09:06:53 (fc5efff); §4b and the met second road at 09:28:20 (30f8de4); the named sources, the clarification of S2 and the stake S2′ at 10:04:53 (f8429c0); §8, the stakes read, at 10:06:37 (a87fe2e). The F = 22 run ended at 10:04:34 by its own clock line, nineteen seconds before S2′ was committed. S2′ was written and committed before that run's output was read, but the record cannot show that it was written before the numbers existed, so **S2′ counts as a bet placed before reading, not as a preregistration**. S1 and S2 were committed about an hour before the F = 20 and 22 counts existed and stand as preregistered. The stakes themselves are not edited.

## 10. R1 split into its two halves, and the weight lemma S4′ (11:5x EDT, read from `date`; iii-43 with iii-38's census)

**The census (iii-38, g48_polymers v2–v5; records as reported by that seat: F18 v2 `ad7b1819`, F19 v5, F20 v5 `602be458`).** Irreducible branched sets through p₀:

| F | Odd irreducible | Even irreducible |
|---|---|---|
| 11 | 66 | — |
| 12 | 0 (the 240 sets are reducible) | — |
| 13 | none | — |
| 14 | 224 | — |
| 15 | 2,520 | — |
| 16 | 1,568 | 64 waists |
| 17 | 3,876 | — |
| 18 | 10,788 | 576 pinches |
| 19 | 88,426, all odd (no even set exists at odd F) | — |
| 20 | 106,460 | 7,140: 2,340 waists, 3,840 pinches, 960 double contacts |

Two of iii-38's stakes were refuted on its own record, and both are named so:
- Its stake (b), that branched rests first appear at F = 21, was refuted at F = 19.
- Its stake (c), that even irreducibles are only waists and pinches, was refuted at F = 20 by the 960 double contacts.

Every odd irreducible to F = 18 is a branch-free surface plus integer-spin wall patches. From F = 19 on, some rests are branched.

**Size, measured.** In the KP sum through a link at β near 0.55, R1's enumerated terms add up to about 2 × 10⁻⁸, under 10⁻⁴ of the cube term 48u⁶ ≈ 3 × 10⁻⁴. The sum is carried by the cubes and by the crude tail. Area for area, though, R1 is not small. At F = 19 the chambers weigh about 11a₁ ≈ 0.14 of the F = 18 surfaces at β = 0.55, using the calibrated weight 12a₁u^{18} per single-wall sphere. So R1 matters exactly where the proof must bound it, in the tail.

**The split.** The counting half is iii-38's 16.58 and Lemma P:
- single-wall sites number at most 2|R| − (3/2)E;
- wall patches through links off R are independent;
- a patch whose off-R links have multiplicity 2 comes from a forced closing path, so there are at most 5^{n−1} of them;
- Z₂-minimal even sets are leaves of T_odd, so pinches, double contacts and acyclic contacts fall within the 5^{F−1} leaves;
- waists count like composites, with a cycle in place of a forest.

The weight half is this section. Feasibility decides which kind of weight bound is needed:
- With S4's supremum factor (4 per cycle) and the L¹ norm of the wall (‖f_even‖₁ ≈ 2.48a₁), a single wall costs about 9.9a₁. With the crude multi-wall count, the decorations raise the effective growth enough to pull the proved reach down to about 0.25–0.3, no better than Theorem 8.7.
- The bound that keeps the reach is an L² one. It needs this lemma.

**Lemma S4′ (the L² cut identity; proved).** Setup:
- S is a branch-free closed surface with every plaquette at spin ½.
- T is a set of S's links, with T's vertices taken at S's vertex cycles.
- g(U_T) = ∫ Π_{p∈S} χ_½(U_p) Π_{ℓ∉T} dU_ℓ.

Then

  ∫ g² dU_T = C(T) · (∫ g dU_T)²,  with  C(T) = Π_{components K of T} [4^{b₁(K)−1} + (4/3)^{b₁(K)−1}],

where b₁ is the cycle rank. Per component, C is 1 on a tree, 2 on a cycle, 16/3 at b₁ = 2, about 17.8 at b₁ = 3, and about 4^{b₁−1} beyond.

*Proof.*
1. Cut S along T into pieces. A piece P of n(P) plaquettes integrates to d^{χ(P)−n(P)} Π_{b∈∂P} χ_½(z_b). Here each boundary curve b is a closed walk in T, and z_b is its holonomy. Every T-link is traversed exactly twice by the curves, once from each of its two plaquettes. So g = K Π_b χ_½(z_b), with K = Π_P d^{χ(P)−n(P)}.
2. N₁ := ∫ Π_b χ_½(z_b) dU_T = 2^{χ(T)}, where χ(T) = v_T − |T|. Each link integral pairs its two traversals with a factor ½, and the index loops are the vertex cycles. Equivalently, χ(S) = χ(T) + Σ_P χ(P) together with S2.
3. N₂ := ∫ Π_b χ_½(z_b)² = Σ_{A⊆curves} ∫ Π_{b∈A} χ₁(z_b), since χ_½² = 1 + χ₁. A term vanishes unless every T-link is traversed by A an even number of times.
4. The corner argument. Around a vertex cycle of S, the T-links and the corners (curve passages) alternate, and the two corners beside a T-link are its two traversals. So an even A contains either all the corners at a vertex or none of them. Hence A is a union of the curve sets of whole components of T.
5. For such an A the spin-1 contraction gives Π_{K⊆A} 3^{χ(K)}, positive because ρ₁ is real orthogonal. So N₂ = Π_K (1 + 3^{χ(K)}).
6. Therefore C = N₂/N₁² = Π_K 4^{−χ(K)}(1 + 3^{χ(K)}), with χ(K) = 1 − b₁(K). ∎

**The four tests, worked by hand before the proof was written down.** Each has a closed form independent of the formula:

| T | Holonomy form | Closed form | Formula |
|---|---|---|---|
| One separating cycle (the box's waist) | g ∝ χ_½(z)² | ∫χ_½⁴ / (∫χ_½²)² = 2/1 = 2; this is the 2·W(box)² calibration of §5 | 2 |
| One non-separating cycle on the 16-plaquette Clifford torus ∂[0,1]²×∂[0,1]² | the cut torus is a cylinder whose two boundary circles both run along T, so g ∝ χ_½(z)² | 2 | 2 |
| Two disjoint cycles | g ∝ χ_½(z₁)² χ_½(z₂)² | 4 | 2 · 2 = 4 |
| Two cycles sharing an edge (two adjacent faces of a cube) | g ∝ χ_½(A) χ_½(B) χ_½(AB) | N₁ = ½, N₂ = 1 + ⅓ (from ∫χ₁(B)χ₁(AB)dB = χ₁(A)/3), so C = 16/3 | 16/3 |

The torus's figure-eight T (a meridian and a longitude at one vertex) also reads 16/3: the single curve is a commutator, with ∫χ_j([x, y]) = 1/d_j. So the per-cycle factor is not 2^{b₁/2}: the theta and figure-eight cases exceed it, which is why the lemma is stated per component.

**What S4′ buys.**
- **Walls.** For a wall cluster Y of integer spins glued to S along T, Cauchy–Schwarz gives |W(S ∪ Y)| ≤ ‖g‖₂‖h_Y‖₂ = √C(T) · W(S) · ‖h_Y‖₂, where h_Y is Y's integral with its links off S done.
  - For one plaquette, ‖h_Y‖₂ = φ := ‖f_even‖₂ = (Σ_{j∈ℕ} d_j² a_j²)^{1/2}. To six digits φ = 3a₁: φ = 0.019802, 0.024997, 0.030770 at β = 0.40, 0.45, 0.50.
  - So one wall costs at most √2·φ·W(S). The exact value at the two cubes sharing a face is 3a₁·W(box), within √2 of the bound.
  - A cluster on a connected T with b₁ = b costs at most √(2·4^{b−1}) ≤ 2^b, so at most 2 per wall.
- **Waists.** For two branch-free surfaces glued along T, |W| ≤ √(C_{S₁}(T) C_{S₂}(T)) · W(S₁)W(S₂). This holds with equality, 2·W(box)W(cube) = 32u^{16}, for the F = 16 waist, because both g's are proportional to χ_½(z)². This replaces §5's "at most 4 per surface per independent cycle" with √C per gluing.

**What is still owed before any number.**
- **(B)** ‖h_Y‖₂ ≤ φ^{|Y|} for multi-plaquette patches. Jensen gives ‖h_Y‖₂² ≤ ∫ Π_{p∈Y} |f_even(U_p)|². That equals φ^{2|Y|} when the patch's plaquettes can be ordered so that each has a link no later plaquette uses (its holonomy is then independent Haar). Otherwise each plaquette without such a link pays sup|f_even| ≈ 9a₁ in place of φ.
- **(D)** Weights for the pinches and double contacts that Lemma P counts: a factor per multiplicity-4 link, from the ½^{⊗4} invariant projector (dimension 2).
- **(E)** One tree with two edge types: forests exact (S3), cycles priced by S4′. The higher-spin pieces enter as (1 + O(a_{3/2}/u)) factors.
- **(F)** `kp_reach3` re-run with u → u·e^{ε(β)}, where ε comes from the proved wall weights times iii-38's proved counts.

**A projection, not a result.** With a uniform factor 2 per wall, 2|S| single-wall sites, and 4·5^{n−1} patches of n ≥ 2 per site, ε(0.475) ≈ 0.18. The composite reach of §8 (u = 0.1424) then moves to about β ≈ 0.47. Nothing above 0.2452 is claimed: (B), (D), (E) and (F) are owed, and the projection is not even a reading.

## 11. Two exact lemmas by gauge fixing: the lone wall and the acyclic contact (12:01 EDT, read from `date`)

Gauge fixing is exact on any forest of links: set every forest link to 1 by gauge transformations at its vertices, and the Haar measure on the remaining links is unchanged. Applied where Cauchy–Schwarz loses, it gives two exact values.

**Lemma S6 (acyclic contacts; proved).** Let X be an all-½ closed set whose links of multiplicity at least 4 form a forest F; this covers the pinches and the acyclic double contacts of Lemma P. Then

  W(X) = u^{|X|} · 2^{χ(X̂)},

where X̂ is X cut open along F, with every resulting boundary curve capped by a disc.

*Proof.* Gauge-fix F to 1. Every other link has multiplicity 2, so the rest is a branch-free surface with boundary, X cut along F. Its integral is (2u)^{|X|} d^{χ−|X|} Π_b χ_½(z_b). Every boundary curve runs along F only, so z_b = 1 and χ_½(z_b) = 2. Hence W = u^{|X|} 2^{χ + n_b} = u^{|X|} 2^{χ(X̂)}. ∎

So an irreducible pinch weighs at most 4u^F when X̂ is connected, the same as a sphere: a contact along a forest costs nothing beyond the surface's own d^χ.

**Lemma S7 (the lone wall; proved).** Let S be a branch-free surface at spin ½, and w a plaquette not in S whose four links lie in S, its boundary meeting no other wall. Then, exactly,

  |W(S ∪ w)| = 3a₁ · W(S),

and only spin 1 on w contributes.

*Proof.*
1. Gauge-fix three links of ∂w. What remains of ∂w is one link, the chord, carrying the wall's holonomy z.
2. Cut S along ∂w. Since ∂w is a cycle (no turning points), its two sides give either two boundary curves, each going round once, or one curve going round twice in the same direction (a one-sided curve).
3. In the first case S's integral is ∝ χ_½(z)², and ∫χ_½²χ_j / ∫χ_½² = δ_{j1}.
4. In the second it is ∝ χ_½(z²) = χ₁(z) − 1, and the ratio is −δ_{j1}.
5. With the weight 3a₁χ₁ on w, |W(S ∪ w)| = 3a₁ W(S). ∎

This is the calibration of §5 (two cubes sharing a face, 12a₁u^{10} = 3a₁ · W(box)), now general. The Cauchy–Schwarz bound of §10 is needed only where walls touch.

**Patches and clusters.**
- A disc-shaped patch of n spin-1 plaquettes spanning one cycle of S integrates over its inner links to 3^{1−n}(3a₁)^n χ₁(z) = 3a₁^n χ₁(z). So it weighs exactly 3a₁^n · W(S) when it meets no other wall: a factor a₁ below a lone wall for each extra plaquette.
- Walls whose boundaries touch form a component K of T. They are priced by §10, at most √c(b₁(K)) per component.

**Projection (not a result).** Feed these exact weights into the site counts: 2|S| lone-wall sites, at most 4·5^{n−1} patches per site, and touching clusters at √c. Then ε(β) ≈ 6a₁ + 120a₁² + (clusters, about 0.016), and the composite reach of §8 moves to about β ≈ 0.52.

**Stakes for iii-38's weight table, written before it exists.**
- **(W1)** Every single-wall chamber with a branch-free rest S reads W/(u^{F−1}·3a₁) = ±2^{χ(S)} exactly, at leading order. That is +4 for a sphere rest, with the sign − only when the wall's boundary is one-sided in S.
- **(W2)** Every pinch reads W/u^F = 2^{χ(X̂)}, with X̂ connected, so 4, 2 or 1.
- **(W3)** No chamber or patch reads above √c(b₁) times its lone-wall value.

A reading outside (W1)–(W3) refutes the corresponding lemma or its proof. As before, nothing above β = 0.2452 is claimed.

## 12. The weight table read; walls interfere through the rest's homology; Lemma S8 staked (12:54 EDT, read from `date`)

**iii-38's exact weights (g50_weights, a tensor-network Haar integrator checked modulo two primes and in floating point; records as that seat reports them: F ≤ 16, F = 18 `5a933d43`, the vertex split `0b1f44d5`).** In the normalisation ρ = W/(u^{F−|Y|}(3a₁)^{|Y|}):

| Stake | Verdict | The reading |
|---|---|---|
| W1 | HELD | all 5,074 single-wall chambers to F = 18 read ±2^{χ(S)}: 5,006 read +4 on sphere rests, 68 read +1 on Clifford-torus rests (a lone wall on a non-separating cycle, the "two curves" case). |
| W2 | HELD at 4 | all 576 pinches at F = 18 read W/u^{18} = 4: a sphere crossing itself along one link, χ(X̂) = 2. |
| W3 | not refuted | nothing reads above √c(b₁) times its lone-wall value. |
| the patch law | HELD, n = 1..4 | a disc patch of n plaquettes reads 4·3^{1−n}, that is 3·a₁^n·W(S), as §11 proved. The tripod (three plaquettes on one off-rest link) reads 8/9, twice the 3-disc. |
| the F = 16 waist | equality | W/u^{16} = 32 = 2·W(box)·W(cube)/u^{16}, as §10 stated. |

**The new fact, exact.** Two lone walls on one rest, sharing no link, do not multiply:
- on a sphere rest, ratio 4 = the product (the walls are independent);
- on a torus rest, on parallel non-separating cycles, ratio +1 = the product;
- on a torus rest, on crossing non-separating cycles, ratio **−1/3**: the cut-open rest is a disc with holonomy [z₁, z₂], and ∫χ_½([x,y])χ₁(x)χ₁(y) = −1/6 against ∫χ_½([x,y]) = 1/2;
- two 2-plaquette discs on a sphere rest: 4/9 with no vertex contact, 4/81 with exactly two (16.63, the vertex split held exactly).

So walls that share no link still couple through the rest's holonomies: adjoint flux patches on a surface with non-trivial topology interfere, and the interference is destructive. iii-38's sentence that patches interact only through shared-link factors is withdrawn on its page; the count bounds of 16.58 stand.

**Lemma S8 (the interference number; STAKED, not proved).** Let S be a branch-free closed surface at spin ½ and w₁, …, w_k lone walls on S (integer-spin plaquettes off S with boundaries in S), with T = ⋃∂w_i. Then

  W(S ∪ {w_i}) = u^{|S|}(3a₁)^k · 2^{χ(S)} · r(S; T),  r(S; T) = ∫_T Π_b χ_½(z_b) Π_i χ₁(z_{∂w_i}) / ∫_T Π_b χ_½(z_b),

a spin-network evaluation on T embedded in S, at leading order in the spins. Stakes, written before the F = 20 table is read:
- **(S8a)** |r| ≤ 1 for every S and every T; r = 1 when the ∂w_i are pairwise disjoint and null-homologous in S.
- **(S8b)** r is multiplicative over the components of T ∪ (the homology classes the walls span): walls in different components of T on a sphere rest multiply exactly.
- **(S8c)** UNGUESSED: whether the crossing cost is a per-crossing law (−1/3 per crossing of non-separating cycles, 1/9 per two boundary crossings on a sphere), or depends on the whole configuration.

(S8a) is what the KP fold-in needs. It replaces the √C of §10 for lone walls by 1, and leaves §10's √C only for touching clusters. A chamber reading |ρ| above 2^{χ(S)} refutes (S8a).

**Why this is the physics, read back.** The strong-coupling picture is flux on closed surfaces. A wall is a unit of adjoint flux stitched across such a surface. On a sphere every stitch is independent; on a torus two stitches on crossing cycles feel the non-commutativity of the two holonomies and cancel by a third. That is a non-abelian effect with no counterpart in the counting: it lowers R1's weight exactly where a sup-norm bound would raise it.

## 13. The vertex law proved on three roads; the bridge theorem; the piece bound; two stakes corrected (13:44 EDT, read from `date`)

**Corrections first (law 18: the prediction is corrected, never the measurement).**
- §12's stake (S8c) in the form "r = (−1/3)^{crossings}" is REFUTED at a triple point: three walls pairwise interlaced at one vertex read 5/9, not (−1/3)³ (the Yang–Mills seat's T6, `aperanton_s8_check.awk`; iii-38's Pauli trace; this seat's table below). The law is the product of a VERTEX TABLE, below; the per-crossing power is its two-wall case.
- The plan's A3 stake "3^{χ}·Π_ℓ R_{m_ℓ}·a₁^n for branched pieces" is REFUTED by the tripod: R₃ = dim Inv(1^{⊗3}) = 1 gives 3a₁³, the exact weight is 6a₁³ (iii-38, 80 chambers, `g50_weights6`). The factor at a multiplicity-3 link is 2; what is proved for branched pieces is the bound of Lemma S10 below.

**The orientability census (iii-38, B6).** Every branch-free closed surface through a plaquette of ℤ⁴ with F ≤ 20 is orientable (27,472 at F ≤ 18; 80,480 at F = 20; records `5a933d43`, `cde192a9`). F = 22 is running. The tail (F > 22) assumes nothing: Lemma S11.

**Lemma S8 (THE VERTEX LAW; proved on three roads).** Let S be an orientable branch-free closed surface at spin ½ and w₁, …, w_k lone walls whose boundary cycles C_i ⊂ S are pairwise link-disjoint. Then

  W(S ∪ {w_i}) = (3a₁)^k · W(S) · Π_{v} c(D_v),

the product over the vertices of S at which two or more of the C_i meet, where D_v is the chord diagram of the walls through v (the T-links at v in the order of S's vertex cycle, a wall's two spokes one chord) and, for a diagram of m chords,

  c(D) = ½ · 3^{−m} · Σ_{μ ∈ {1,2,3}^m} tr( Π_{p=1}^{2m} σ_{μ(chord at spoke p)} ),

the trace of the Pauli product around the vertex cycle with each chord's adjoint index summed (the Yang–Mills seat's form, ledger §112 bis). Three facts follow at once: (a) |c(D)| ≤ 1 for EVERY diagram, since each Pauli product is unitary and |tr| ≤ 2 on ℂ² — this is (S8a), proved for all m, not read off a table; (b) c depends only on the diagram's intersection graph, and on a forest c = (−1/3)^{edges} — the per-crossing law of §12 is exactly the forest case; (c) at complete crossing c = ½[3^{1−m} − (−1)^m]. The map D ↦ c(D) is the sl₂ weight system in the defining representation, normalised to 1 on one chord (classical, W = 0: Bar-Natan 1995; Chmutov–Lando); the earning is its identification as the wall interference of the flux-surface gas and the complete lattice table. With m ≤ 4 walls at a vertex (a vertex of ℤ⁴ has eight links), the table up to rotation and reflection is:

| m | pattern (cyclic order of the walls' spokes) | crossings | c(v) |
|---|---|---|---|
| 1 | aa | 0 | 1 |
| 2 | aabb (touching) | 0 | 1 |
| 2 | abab (crossing) | 1 | −1/3 |
| 3 | aabbcc, aabccb (nested) | 0 | 1 |
| 3 | aabcbc | 1 | −1/3 |
| 3 | abacbc | 2 | 1/9 |
| 3 | abcabc (triple point) | 3 | 5/9 |
| 4 | aabbccdd, aabbcddc, aabcddcb | 0 | 1 |
| 4 | aabbcdcd, aabcbddc, aabcdcdb, aabcddbc | 1 | −1/3 |
| 4 | aabcbdcd, aabcdbdc, ababcdcd | 2 | 1/9 |
| 4 | aabcdbcd | 3 | 5/9 |
| 4 | abacbdcd, abacdbdc | 3 | −1/27 |
| 4 | abacdbcd | 4 | −5/27 |
| 4 | abcadcbd | 4 | 11/27 |
| 4 | abcadbcd | 5 | 7/27 |
| 4 | abcdabcd | 6 | −13/27 |

Every entry has |c(v)| ≤ 1, so |r| ≤ 1 (S8a), r is multiplicative over vertices (S8b), and at vertices carrying at most two walls r = (−1/3)^{crossings} (S8c, the two-wall case; iii-38's reading 5,614/5,614 at F ≤ 18, and the four-wall tori at F = 20 reading −1/27, 1/81, 1 for 3, 4, 0 crossings).

*Proof.* (i) Locality. After the links of S not in T = ⋃C_i are integrated, the integrand over the T-links is Π_{pieces} Π_b χ_½(z_b) · Π_i χ₁(z_{C_i}) (§10, step 1, orientable pieces). Every T-link carries exactly three strands: the two boundary traversals, in opposite directions since S is orientable, and the wall's spin-1 strand, so its Haar integral is the projector onto Inv(½ ⊗ ½* ⊗ 1), which is one-dimensional; without walls it is the projector onto Inv(½ ⊗ ½*), also one-dimensional. A rank-one projector |ι⟩⟨ι| puts ι at one end of the link and ι* at the other, so the integral over all of T is a product over vertices of contractions of the ι's at that vertex along the corner pairings, numerator and denominator alike; the ratio is Π_v c(v) with c(v) the ratio of the two contractions, and c(v) = 1 at every vertex where only one wall passes (the contraction is ⟨ι|ι⟩ = 1 on both sides). (ii) The local values. Schur–Weyl at degree two gives, for a T-link a with its two face strands and the wall's strand, ∫ a_{αα′}(a⁻¹)_{β′β}D¹(a)_{μν} da = (1/6)(σ_μ)_{αβ}(σ_ν)_{β′α′}, against ½δ_{αβ}δ_{α′β′} without the wall: the face strands are joined across the link exactly as in S4′ step 2, with a Pauli matrix in each joint, and the wall's adjoint index between two consecutive links of the same wall is shared by two insertions at ONE vertex, so the sum factorises over vertices (the Yang–Mills seat's proof, §112 bis; iii-38's page 16.68 the same trace). The normalisations are the no-wall loop's 2 and (1/6)/(1/2) = 1/3 per link, two link ends per wall per vertex, which gives the ½·3^{−m} in front of the trace sum. Hence one wall Σ tr(σ_μσ_μ) = 6, normalised to 1; touching Σ tr(σ_μσ_μσ_νσ_ν) = 18 against 18, c = 1; crossing Σ tr(σ_μσ_νσ_μσ_ν) = −6, c = −1/3; the triple point Σ tr(σ_μσ_νσ_ρσ_μσ_νσ_ρ) = 30 against 54, c = 5/9. The twenty-five patterns with m ≤ 4 up to rotation and reflection are the contractions tabulated above (`records/surface-gas/s8_local.py`: the link projector built by exact quadrature and factorised, every pattern contracted; `s8_local_table.2026-10-29a.txt`); the Yang–Mills seat's `aperanton_s8_pauli.awk` and `aperanton_s8_exact.awk` read all 105 diagrams with m = 4 up to rotation by the Pauli sum and by exact quaternion moments, equal on every one. (iii) The second road: the global integrals ∫χ_½(z₁)χ_½(z₂)χ_½(z₂z₁)χ₁(z₁)χ₁(z₂) = 1/2 = the denominator (touching, c = 1) and ∫χ_½([z₁,z₂])χ₁(z₁)χ₁(z₂) = −1/6 against 1/2 (the torus crossing, c = −1/3), by orthogonality at the desk and by exact quadrature (`s8_kat.py`); the Yang–Mills seat's engine reads the same seven configurations, the triple point among them. ∎

**Theorem S8′ (THE BRIDGE; iii-38's, page 16.68, proved at every spin assignment).** If a closed set X is the union of two link-disjoint closed sets X₁, X₂ and a single plaquette w whose links are split between them, then W(X) = 0: integrating X₁'s other links leaves an amplitude of w's arc in X₁ that is invariant under the gauge group acting on that arc alone, hence constant, likewise for X₂, and the remaining ∫χ_j(U_w) over a free link vanishes for every j ≥ ½. Hence two-component rests joined by one lone wall (912 chambers at F = 19, read as exactly zero) drop out of the fold-in. A patch of several plaquettes bridging two surfaces is not a bridge (16/81 at F = 20).

**Lemma S9 (THE PATCH LAW for surface pieces; proved).** Let Y be a connected set of n plaquettes off S, every off-S link of Y of multiplicity exactly 2 in Y, every link of Y in S of multiplicity 1 in Y, Y orientable, attached to the orientable rest S along its k boundary curves ∂Y = b₁ ⊔ … ⊔ b_k ⊂ S, the curves pairwise link-disjoint. Then

  W(S ∪ Y) = 3^{χ(Y)} a₁^n · W(S) · Π_v c(v),

with c(v) the vertex table of S8 applied to the boundary curves as if each were a wall. *Proof.* Each plaquette of Y carries spin 1 exactly (its S-links carry ½ ⊗ ½ ⊗ j ∋ 0 ⇒ j = 1, and Y's off-S links carry j ⊗ j′ ∋ 0 ⇒ j = j′). Integrating Y's off-S links gives 3^{χ(Y)−n}·(3a₁)^n·Π_b χ₁(z_b) (the piece formula of §10 at spin 1, verified at the desk for the disc, the annulus and the one-holed torus), so each boundary curve carries one spin-1 loop, which is a wall's strand, and S8 applies. ∎ A disc (χ = 1, k = 1) weighs 3·a₁^n·W(S): iii-38's reading 4·3^{1−n} at n = 1, 2, 3, 4 (discs with 1, 2, 3 and 5 internal links, the 2×2 square among them) is this law.

**Lemma S10 (THE PIECE BOUND for every piece; proved).** Let Y be any connected set of n plaquettes off S whose off-S links all have multiplicity ≥ 2 in Y (so that Y ∪ S is closed at integer spins on Y), attached along the graph T = L(Y) ∩ L(S). Then

  |W(S ∪ Y)| ≤ √C(T) · (3a₁)^n · W(S),

with C(T) the L² constant of S4′. *Proof.* Cauchy–Schwarz in the T-variables: |∫ g_S h_Y| ≤ ‖g_S‖₂‖h_Y‖₂, ‖g_S‖₂ = √C(T)·W(S) by S4′. For h_Y = ∫_{off-S} Π_{p∈Y} 3a₁χ₁(U_p): by Jensen ‖h_Y‖₂² ≤ (3a₁)^{2n} Z₁(Y), Z₁(Y) := ∫ Π_{p∈Y} χ₁(U_p)² over ALL links of Y. Every link of T lies in exactly one plaquette p of Y, and ∫ dU χ₁(AU)² = ∫(1 + χ₁ + χ₂)(AU) dU = 1 removes p; the plaquettes removed expose the next layer, and a plaquette none of whose links is free has all its links shared with removed plaquettes, hence free; so Z₁(Y) = 1 for every piece. ∎ For the tripod (T three 3-paths from x to y, b₁ = 2, C = 16/3) the bound is 2.31·27a₁³ = 62a₁³ against the exact 6a₁³, which is why S10 is used only where S9 does not apply.

**Lemma S11 (THE CAPPED BOUND for every all-½ closed set; proved).** For any closed set X all of whose plaquettes carry spin ½ (so every link multiplicity is even), |W_½(X)| ≤ u^{|X|}·2^{χ(X̂)}, where X̂ is X cut along every link of multiplicity ≥ 4 with every boundary curve capped by a disc: cut X there; the pieces are surfaces with boundary (possibly non-orientable) whose integrals are products of d^{χ(P)−n(P)} and characters of boundary words, each of modulus ≤ 2 = χ_½(1); so the integral is at most its value with every cut-link holonomy set to 1, which is u^{|X|}2^{χ(X̂)}. In particular |W_½(X)| ≤ 4^{c(X̂)}u^{|X|} with c(X̂) the number of pieces, and |W_½(S)| ≤ 4u^{|S|} for every closed surface S, orientable or not. ∎ For S6's acyclic contacts this is the equality.

**What this section proves and what it does not.** S8–S11 are theorems. They price: lone walls on orientable rests exactly; surface pieces on orientable rests exactly; every other piece by S10; every all-½ closed set by S11. Not yet priced sharply: branched pieces (S10's √C(T)(3a₁)^n in place of their exact 3^{χ}Π c(m) a₁^n with c(3) = 2); pieces whose boundaries share a link of S (½ ⊗ ½ ⊗ 1 ⊗ 1, rank two; read 1 at F = 16); non-orientable rests (none to F = 20). The fold-in of §14 uses only the proved bounds and says which.

## 14. The fold-in: the inequality, every input's status, the conditional number (14:08 EDT, read from `date`)

**Corrections to §13 from the second reader (the Yang–Mills seat, 13:5x; law 18).** The chord table has 1 + 2 + 5 + 17 = 25 patterns, not 26. A chord is one passage of a curve through v, so a boundary curve of a surface piece that passes a vertex twice contributes two chords. S8′'s "split between them" means both parts nonempty. S10 as stated is REFUSED: its peeling step stalls on a closed core (a tube with a cube on it); it is replaced by **S10′ (the Yang–Mills seat's, ledger §115)**: ‖h_Y‖₂² = (3a₁)^{2n}·Z₁(D) exactly, D the double of Y glued along T; cutting D along its branched links and capping, |Z₁(D)| ≤ 3^{χ(D̂)−2n}, so |W(S ∪ Y)| ≤ √C(T)·3^{χ(D̂)/2}·a₁^n·W(S) for every piece at spin 1 on Y, with every S-link of Y in exactly one plaquette of Y. It equals S9 on surface pieces up to √C(T) and reads 27a₁³ on the tripod. S11's χ(P) takes pinch vertices as their vertex cycles. S8, S8′, S9 and S11 are SIGNED by the second reader; S10′ is the Yang–Mills seat's and is read here.

**The census of record (iii-38, B6 to F = 22).** Every branch-free closed surface through p₀ with F ≤ 22 is orientable (F = 22: 551,408, of which 551,056 spheres and 352 tori; `g51_orient_d4_f22`, 220a8b56). So S4′ and S8 apply to every rest the census produces to area 22; the tail is where a non-orientable rest could first appear (F ≥ 24).

**Definitions.** β the Wilson coupling, weight e^{(β/2) tr U_p}; c₀ = 2I₁(β)/β; a_j = I_{2j+1}(β)/I₁(β) for j = ½, 1, 3/2, …; u = a_½ = I₂/I₁; d_j = 2j + 1. A polymer is a closed link-connected plaquette set X with an admissible spin assignment; |L(X)| its link count; two polymers are incompatible when they share a link. Kotecký–Preiss: the expansion converges, and truncated correlations decay at rate α, if for every link ℓ

  S(α) := Σ_{X ∋ ℓ} |W(X)| e^{α|L(X)|} ≤ α.

**The inequality as stated for the two roads (iii-38's independent implementation; the Yang–Mills seat's certificate).** Sums through a LINK are three times sums through a plaquette (each plaquette has four links, each link six plaquettes; the census counts sets through p₀). Write a₁′ = a₁e^{2α}, κ_T = 4.

1. LEAVES through p₀ of size F, their activity, and the tail.
   - Surfaces: N(F) = 4, 60, 80, 1092, 2728, 23508, 80480, 551408 at F = 6, 10, 12, 14, 16, 18, 20, 22 (two roads; PROVED), activity u^F·2^{χ}·σ(F) with σ(F) = 1 + Σ_{j≥1} d_j²(a_j/u)^F the single higher spin (S2; PROVED); 2^χ ≤ 4.
   - Contact leaves (Z₂-minimal, with multiplicity-4 links): 576 at F = 18, 3,840 + 960 at F = 20 (iii-38); activity ≤ 4u^F — **S12, STAKED**: every one read 4 to F = 20 (S6 gives the forest-contact case exactly); the general case is Lemma S12 below.
   - Tail F > F₀: N(F) ≤ 5^{F−1} for every Z₂-minimal set (the closing tree and Lemma P; PROVED/iii-38 to be read), activity ≤ 4u^F (S11 for surfaces; S12 for contact leaves).
   - Every leaf plaquette's links are paid at e^{2α} (a leaf has 2|X| links).
2. DRESSING: every decoration of a leaf X (walls, patches, pieces on pieces, at integer spins) is a set of minimal pieces, and the sum over decorations is ≤ e^{κ|X|} with κ the least root of

  κ = 2 z₁ e^{κ} + 8 Σ_{s≥2} 5^{s−1} max(z_surf(s), z_br(s)) e^{κ s}

   (iii-38's dressing lemma 16.65-a; the roots 8|X| and 5^{s−1} per root from 16.58; to be read here), where
   - z₁ = e^{2α} Σ_{j≥1} d_j a_j: a lone wall weighs d_j a_j·|r| with |r| ≤ 1 (S7 + S8 at spin 1, the same unitarity at every j; PROVED on orientable rests);
   - z_surf(s) = e^{2αs} Σ_{j≥1} d_j a_j^s: a surface piece weighs d_j^{χ(Y)} a_j^s |Π c| ≤ d_j a_j^s (S9; PROVED on orientable rests);
   - z_br(s) = 3 (γ a₁′)^s with **γ STAKED (S13)**: every branched piece of s plaquettes weighs at most 3(γa₁)^s·W(S). The readings to F = 20: the tripod 6a₁³ (γ = 1.82), the four-plaquette patch on the same spine 21a₁⁴ (γ = 2.14), the six-plaquette (13/18/0) 8a₁⁶ (γ = 1.41); the stake is γ = 2.5. The PROVED alternative is S10′: z_br(s) ≤ 2^{b₁(T)}·3^{#pieces(D̂)}·a₁^s ≤ (6a₁′)^s, i.e. γ = 6.
3. THE TREE: forest gluings exact (S3), cycle gluings at cost 2 with ≤ 2|X| sites (S4′, orientable); per link the load is α + T + 2T, so the composite sum converges if the leaf-and-dressing sum evaluated at 4α is ≤ α (κ_T = 4). Pinches and double contacts weigh like surfaces (S6) and sit among the leaves; the bridge configurations weigh zero (S8′).

So the test at a trial (β, α) is: with ũ := u e^{κ} and α̃ := 4α,

  3·[ Σ_{F ≤ F₀} ( N(F) 2^χ σ(F) + 4 N_c(F) ) ũ^F e^{2α̃F} + (4/5)·r^{F₀+1}/(1−r)·σ(F₀+1) ] ≤ α,  r := 5 ũ e^{2α̃},

with κ the dressing root at α̃, and F₀ = 20 (the last size at which every leaf is enumerated).

**The conditional number (`records/surface-gas/kp_reach5.py`, 14:0x).**

| γ (S13) | F₀ | μ | β* | u | α | κ |
|---|---|---|---|---|---|---|
| 2.5 (stake) | 20 | 5 | 0.4929 | 0.1220 | 0.0046 | 0.101 |
| 3.0 | 20 | 5 | 0.4875 | 0.1207 | 0.0044 | 0.112 |
| 6.0 (S10′, proved) | 20 | 5 | 0.4266 | 0.1058 | 0.0020 | 0.228 |
| 2.5 | 22 (surfaces only at 22) | 5 | 0.5032 | — | — | — |
| 2.5 | 20 | 4.33 (measured, not proved) | 0.5415 | — | — | — |

Reading the table: the proved tail (μ = 5) and the proved branched-piece activity (γ = 6) give **β* = 0.4266**; S13 at the staked γ = 2.5 gives 0.49; the contact-leaf census at F = 22 would give 0.50; a proved tail of 4.33 would give 0.54. Nothing in this table is a theorem: S12 and S13 are staked, the dressing lemma and the counts are iii-38's to be read here, the tail's non-orientable rests are A1's, and the certificate with outward rounding (C2) has not run.

**What S12 and S13 are, exactly.**
- **S12 (contact leaves).** A Z₂-minimal all-½ set X has one sheet: the image of each sheet of a resolution is closed, so a second sheet would be a proper closed subset. Every contact cycle whose two preimages together separate the sheet makes X a cycle composite (both sides closed), so in a minimal X the preimage cycles are non-separating and need genus, which costs 2^{χ}. The claim: |W_½(X)| ≤ 4u^{|X|} for every Z₂-minimal X; proof route: gauge-fix a spanning forest of the contact graph (exact, S6), the chord integrals by S4′'s even-subset expansion, the genus accounting. Known answers: pinches 4, double contacts 4 (every one to F = 20); the separating-curve self-contact (8u^F) and the torus-meridian self-contact (2u^F) are composites, not minimal.
- **S13 (the junction bound).** For a branched piece Y on S, W(S ∪ Y)/W(S) is a sum over the branched links' invariant bases of products of local factors (the same locality as S8), with the junction vertices (the ends of branched links) carrying factors outside the chord table. The claim: |W(S ∪ Y)| ≤ 3(γa₁)^{|Y|}W(S) with γ ≤ 2.5. Known answers: 2, 7 and the (13/18/0) reading above; iii-38's vertex-factor census (659 types to F ≤ 12, 0 conflicts) is the table in the making; iii-bd offers the junction nets by Kauffman–Lins recoupling.

**Not claimed.** Nothing above β = 0.2452.

## 15. The counting lemmas read; A1 proved; S12 half proved, the other half named (14:18 EDT, read from `date`)

**B2–B4 read (iii-38's page, 16.58-b, 16.65, 16.65-a; this seat).** Lemma P (P1)–(P3) is proved as written: a path of the odd-rule tree inside a Z₂-minimal X cannot stop short (the node is not even, its smallest odd link has a plaquette of X ∖ S), the only even subset of X through p₀ is X, a node has 6 − m_S(l) ≤ 5 children. (W1)–(W3) and (W5) are proved as written. The dressing lemma 16.65/16.65-a is proved AS A COUNT: Σ over decorations of Π z^{|piece|} ≤ e^{κ*|U|} when g(κ*) ≤ κ*. Its use in §14 as a bound on Σ_Δ |W(U ∪ Δ)|/|W(U)| needs, for every decoration Δ as a whole, |W(U ∪ Δ)| ≤ |W(U)|·Π_{pieces} z(piece) — a JOINT bound, not a product of sequential ratios (a third wall at a triple point raises the two-wall weight by 5a₁, more than its lone 3a₁; the set's weight (3a₁)³·5/9 is what is bounded). The joint bound is S8 for lone walls, S8 + S9 for lone walls and surface pieces with pairwise link-disjoint boundaries, and S13 for everything else: branched pieces, pieces on pieces, and pieces whose boundaries share a link of U (rank two at that link). So the dressing lemma's soundness in the fold-in is exactly S13's content, and §14's conditional number is conditional on S13 for that reason too.

**A1 proved: the two lemmas on a non-orientable rest.** Let S be a non-orientable branch-free closed surface. Some links of S are traversed in the SAME direction by their two plaquettes' boundary curves under any choice of local orientations; at such a link the two strands are both D^½(U). The pseudo-reality of the fundamental, conj(D(U)) = εD(U)ε⁻¹, turns a same-direction strand into an opposite-direction one with an ε at each of its two ends, so every same-direction link's projector is the orientable one of S8 with ε's inserted at the two ends of one strand. (i) THE VERTEX LAW: every index loop around a vertex cycle is contractible, so it crosses an even number of orientation-reversing links and the ε's pair off; the loop is still a trace of a product of 2×2 unitaries (σ's and ε's, with ε σ^T ε⁻¹ = −σ), so |tr| ≤ 2 and |c(v)| ≤ 1 for every pattern; S8's conclusion |r| ≤ 1 holds on non-orientable rests (the signs of the entries may change; the bound does not). S7's one-sided case is the one-wall instance. (ii) S4′ AS AN INEQUALITY: N₁ = ±2^{χ(T)} (each loop contributes ±2, the sign global), and N₂ = Σ_{A even} (signed spin-1 contractions), each term of modulus 3^{χ(K)} on the components it covers, so N₂ ≤ Π_K(1 + 3^{χ(K)}) and C(T) ≤ Π_K[4^{b₁(K)−1} + (4/3)^{b₁(K)−1}]; S10′ and the cycle-gluing cost 2 use C(T) only as an upper bound. ∎ So the tail beyond F = 22, where a non-orientable rest could first appear, needs nothing further from orientability.

**Lemma S12 (contact leaves), the proved half.** Let X be a Z₂-minimal all-½ closed set (every link of multiplicity 2 or 4; the multiplicity-6 case is a remark below). (a) ONE SHEET: pair the four plaquettes at every multiplicity-4 link into two pairs, glue along links by the pairings and separate the corner cycles at every vertex; the result is a closed surface Σ with a face-injective cubical map onto X, and the image of every component of Σ is closed (two plaquettes per passage at every link), so X minimal ⇒ Σ connected, for every choice of pairings. (b) THE CUT FORMULA: let Ĝ ⊂ Σ be the preimage of the contact graph G_c (the multiplicity-4 links); cut Σ along Ĝ into pieces P_j, j = 1..J, with boundary curves whose holonomies are words in the contact links; then W_½(X) = u^{|X|}·2^{χ(Σ) − χ(Ĝ)}·I, I = ∫_{G_c} Π_b χ_½(w_b), by the piece formula (orientable or not, as in A1) and χ(Σ ∖ Ĝ) = χ(Σ) − χ(Ĝ). (c) THE CONNECTED CASE, J = 1: gauge-fix a spanning forest of G_c to 1; the remaining chord links number b₁(G_c); the single piece P has #∂P boundary curves and χ(P) = χ(Σ) − χ(Ĝ); |I| ≤ 2^{#∂P}, and for a connected orientable surface with boundary χ(P) = 2 − 2g(P) − #∂P (for a non-orientable one χ(P) = 2 − (cross-caps) − #∂P, which only lowers the bound), so |W| ≤ u^{|X|}·2^{χ(P) + #∂P} = u^{|X|}·2^{2 − 2g(P)} ≤ 4u^{|X|}. ∎ This is every pinch and every double contact (J = 1 since a forest of slits never disconnects), read 4 on all 5,376 to F = 20, and every minimal set whose contact graph has cycles but whose cut surface stays connected (the genus-2 pair, 2·2^{χ} = u^F/2).

**S12, the other half, named (STAKED).** If cutting Σ along Ĝ disconnects it (J ≥ 2), Ĝ contains a separating cycle C whose lattice image is a nonzero cycle γ_C of G_c (if the image vanished, one side would be a proper closed subset), and the two pieces on the sides of C carry boundary words w and w⁻¹ along C. The capped bound then reads |W| ≤ u^F·4^J, but the exact chord integral pairs those two curves, ∫χ_½(w)χ_½(w⁻¹) = 1 against the capped 4, and on the one example computed (a sphere with an equator whose links are also scattered links of the same sphere) the exact weight is 4u^F against the capped 16u^F. The claim |W_½(X)| ≤ 4u^{|X|} for every Z₂-minimal X is STAKED; the proof owed is the chord integral with the inverse pairs along every separating cycle. Multiplicity-6 links (three passages, Inv(½^{⊗6}) of dimension five) are absent to F = 20; the same cut formula applies with six traversals per such link and is covered by the same stake. Known answers: every contact leaf to F = 20 reads exactly 4u^F.

**What this leaves on the trunk.** S13 (the joint junction bound; iii-bd's recoupling nets, iii-38's vertex-factor census over F ≤ 20 as its known answer), S12's second half, the even-set census at F = 22 (iii-38), C2 (the certificate; the Yang–Mills seat), D3 (the vertex law in Lean; emitted, compiling after ah), then D1 and the paper. Nothing above β = 0.2452 is claimed.

## 16. D1 — the gap from the expansion: observables as sources, the cluster bound, Theorem 7.1 (14:21 EDT, read from `date`)

**What is classical here (W = 0).** The polymer representation of the Wilson-action partition function and the cluster expansion for expectations with local observables are Osterwalder–Seiler (Ann. Phys. 110 (1978) §§3–4); the tree bound for clusters is Kotecký–Preiss (1986). What is III's is the pricing of every source polymer by §§10–15 and the explicit constants.

**Setting.** Λ a finite torus of ℤ⁴ (the infinite-volume limit is taken at the end, as in Theorem 8.7's proof), the Wilson measure dμ = Z⁻¹Π_p e^{(β/2)tr U_p}Π_ℓ dU_ℓ, f(U) = e^{(β/2)tr U}/c₀ − 1 = Σ_{j ≥ ½} d_j a_j χ_j(U). An OBSERVABLE A is a bounded gauge-invariant function of the links in a finite set L_A = L(supp A); ‖A‖ its sup norm. Expanding Π_p(1 + f(U_p)) and integrating, every plaquette set X with a link of multiplicity one off L_A integrates to zero (S1), so

  Z·⟨A⟩ = Σ_{X ⊆ plaquettes} ∫ A Π_{p∈X} f(U_p) = Σ_{X} ∫ A·g_X,  g_X(U_{L_A}) := ∫_{ℓ ∉ L_A} Π_{p∈X} f(U_p),

over sets X every link of which off L_A has multiplicity 0 or ≥ 2 (closed relative to A). Such an X splits uniquely into its link-connected components; the components not meeting L_A are ordinary closed polymers with the weights of §2, and the integral factorises over components (link-disjoint sets have disjoint variables). Call a component meeting L_A an A-POLYMER. So Z⟨A⟩ = Σ over compatible families of ordinary polymers and A-polymers, with the A-polymers' joint weight ∫A Π g — a polymer gas with one distinguished species.

**Lemma D1.1 (the source bound).** For an A-polymer X with T := L(X) ∩ L_A,

  |∫ A g_X| ≤ ‖A‖·‖g_X‖₂ = ‖A‖·W(X ∪_T X′)^{1/2},

where X ∪_T X′ is X and a copy glued along T (each T-link's multiplicity doubled, the copies' other links distinct), a closed set, and W its weight at the full f. *Proof.* Cauchy–Schwarz on the probability space of the T-links; |g_X|² = g_X·g_{X′} integrated over everything is the weight of the double. ∎ The double is a closed polymer configuration of 2|X| plaquettes and is priced by §§10–15: its all-½ part by S2/S6/S11, its decorations by the dressing lemma, and every T-link of it is a link where X and X′ meet, so by the cut formula with the capped curves (S11's argument, |χ_j| ≤ d_j) W(X ∪_T X′) ≤ 2^{2|T|}·[act(X)]², with act(X) := 4·(u e^{κ})^{|X|}·σ(|X|) the activity a closed polymer of X's size carries in §14 (the sum over spins, the decoration factor, the capped 2^{χ} ≤ 4). Hence

  |∫ A g_X| ≤ ‖A‖·2^{|L_A|}·act(X).

**Lemma D1.2 (the source count).** The A-polymers of n plaquettes are at most 6|L_A|·5^{n−1} in number: every one contains a plaquette at a link of L_A (≤ 6 per link), and the closing tree of §3 from that plaquette, with the links of L_A exempt from closing (they may stay at multiplicity one), reaches it in n − 1 forced steps of at most 5 choices each — the argument of (W5), the multiplicity-1 links off L_A being the ones closed. ∎

**Proposition D1.3 (clustering).** Let β ≤ β* and α = α(β) be a value at which the Kotecký–Preiss condition of §14 holds for the ordinary polymers. Then for observables A, B with supports at link-distance d(A, B),

  |⟨A; B⟩_Λ| ≤ ‖A‖‖B‖·K_A K_B·e^{−α·d(A,B)},  K_A := 2^{|L_A|}·6|L_A|·(1 + α),

uniformly in Λ. *Proof.* The gas has three species: ordinary polymers, A-polymers, B-polymers, incompatible when they share a link. Give the A-polymers the same a(X) = α|L(X)|. By D1.1–D1.2, Σ_{A-polymers X} |W_A(X)|e^{α|L(X)|} ≤ ‖A‖·2^{|L_A|}·6|L_A|·Σ_{n} 5^{n−1}act(n)e^{2αn} ≤ ‖A‖·K_A·α (the last sum is the ordinary KP sum through a link, ≤ α by §14; the source polymers need only a finite sum, not the KP inequality, since each cluster of the expansion below contains at most one of them). Then log(Z_{AB}/Z) − log(Z_A/Z) − log(Z_B/Z), with Z_A := Z⟨A⟩, is the sum over clusters containing an A-polymer and a B-polymer (Osterwalder–Seiler (4.9)–(4.12)), which is ⟨A;B⟩ up to the normalisation; a cluster containing polymers through L_A and L_B is link-connected from L_A to L_B, so Σ_{X∈C}|L(X)| ≥ d(A,B), and the Kotecký–Preiss tree bound Σ_{C ∋ X₀}|φ(C)|Π_{X∈C}|W(X)|e^{Σ_X a(X)} ≤ e^{a(X₀)} − 1 applied at the A-polymer gives |⟨A;B⟩| ≤ e^{−α d}·Σ_{X_A}|W_A(X_A)|e^{a(X_A)}·sup_{X_A}(…)·(the B-factor) ≤ ‖A‖‖B‖K_AK_B e^{−α d}. ∎

**Corollary D1.4 (the gap).** For β ≤ β*, the infinite-volume limit of the Wilson measure exists along the tori (the cluster sums converge uniformly and are volume-independent for fixed supports), is reflection-positive and translation-invariant, and every pair of local gauge-invariant observables separated by t in the time direction clusters as e^{−αt}·K_AK_B. Theorem 7.1 (gap ⟺ exponential clustering, with the reconstruction at integer times) then gives a transfer matrix with a unique vacuum and a spectral gap m(β) ≥ α(β) > 0: THE LATTICE GAP AT STRONG COUPLING FOR β ≤ β*, on the dense set of local observables and hence on the whole physical Hilbert space (a vector whose spectral measure lies in [0, e^{−m}] is a closed condition). The number α(β) at β* is small (≈ 0.005 at β* ≈ 0.49); for β well below β* it is larger, and the theorem asserts m(β) ≥ α(β) at every β ≤ β*, not a uniform gap.

**Status.** D1.1–D1.4 are proved on the page given §14's KP inequality; D1.1's pricing of the double uses the same lemmas and stakes as §14 (S12, S13), so D1 inherits exactly their conditionality and adds none. Nothing above β = 0.2452 is claimed.

## 17. Lemma S13 — THE JUNCTION LAW (the coordination seat iii-bd's, 14:2x EDT, carried here by name; 14:23 EDT by `date`)

**Setting.** S an orientable branch-free rest at spin ½; a SINGLE-SPINE piece Y = m plaquettes (m ≥ 2) sharing one off-rest link ℓ = (u, v), each attached to S along its other three links; every plaquette of Y at spin 1 (forced by its rest links, §13). A σ-link (a rest link of Y: ½ ⊗ ½ ⊗ 1) integrates to the rank-one projector (σ^μ)_{ab}(σ^{μ′})^*_{b′a′}/6 with an independent adjoint index at each of its ends; the wall's holonomy contracts a link's end index with the next link's start index, so every vertex of a wall carries its own index and the wall's two spokes at that vertex carry the same σ — the Fierz form of the chord law (S8), and the reason vertex factors multiply. The spine integrates to P^{(m)}, the projector onto Inv(1^{⊗m}) (δ-pairings and ε's; dimension 1, 3, 6, 15 at m = 3, 4, 5, 6).

**Lemma S13 (single spine; iii-bd, proved).** With T_u(μ⃗) := tr(σ^{μ_{π(1)}}⋯σ^{μ_{π(m)}})/2 the vertex-cycle trace at u in the cyclic order π of the m walls' spokes at u, and T_v the same at v in v's order,

  W(S ∪ Y) = (3a₁)^m · J_m · W(S),   J_m = 3^{−m} Σ_{μ⃗ ∈ {1,2,3}^m} T_u(μ⃗) T_v(μ⃗),

the far vertices of the walls contributing 3 each against their σ-links at 1/3, and P^{(m)} acting as the identity between the invariant tensors T_u, T_v. Known answers, met exactly: m = 3, the tripod: T = iε at both ends, Σ T_uT_v = 6, J₃ = 2/9 — the measured 6a₁³ (§13); m = 4, the four-plaquette patch on one spine: T = δ₁₂δ₃₄ − δ₁₃δ₂₄ + δ₁₄δ₂₃, |T|² = 21, J₄ = 7/27 — the measured 21a₁⁴ (§14). J depends on the RELATIVE spoke orders at the two ends (at m = 4 with v's order a transposition of u's, ⟨T_u,T_v⟩ = −3 and J = −1/27); the finite table per m is the Gram matrix of the permuted trace tensors.

**The bound (iii-bd, proved).** |T_m|² = Σ_{μ⃗}|tr(σ^{μ⃗})/2|² = tr(C^m)/4 with C = Σ_μ σ^μ ⊗ σ̄^μ on End(ℂ²), eigenvalues 3 (once) and −1 (thrice): |T_m|² = (3^m + 3(−1)^m)/4 = 0, 3, 6, 21, 60, 183 at m = 1..6. Cauchy–Schwarz on the inner product gives, for every pair of spoke orders,

  |J_m| ≤ (3^m + 3(−1)^m)/(4·3^m) = (1 + 3(−1/3)^m)/4 = 1/3, 2/9, 7/27, 20/81, 61/243 at m = 2..6, → 1/4.

A spine never amplifies. Per plaquette of a single-spine piece the rate is 3a₁·J_m^{1/m} ≤ 1.73, 1.82, 2.14, 2.33, 2.38 × a₁ at m = 2..6, and m ≤ 6 on ℤ⁴ (a link lies in six plaquettes): every single-spine piece sits below §14's staked γ = 2.5. ∎

**The general branched piece (iii-bd's lemma to carry; STAKED here).** A piece with several off-rest links of multiplicity ≥ 2 is the same tensor network — one projector P^{(m_ℓ)} per off-rest link, one trace tensor per vertex — and its weight ratio is bounded by the product of the per-vertex Cauchy–Schwarz factors. What the fold-in needs from it is the maximum over all shapes of the per-plaquette rate (|W|/(W(S)(3a₁)^n))^{1/n}; iii-bd is asked for it by shape (k = 1..4 spines per plaquette, multiplicities 2..6). Until it is stated, §14's γ = 2.5 remains a stake for multi-spine pieces, proved for single spines. The six-plaquette (13/18/0) reading 8a₁⁶ is the first multi-spine known answer (its plaquette list requested from iii-38).

**Credit.** The Haar integral by projectors is Weingarten-type (W = 0). III's: the law J_m = 3^{−m}⟨T_u,T_v⟩, the closed form of its maximum, the bound, and the executable form (ΑΓΚΥΛΗ II's chord and junction verbs, exact Gaussian-integer traces, gated).

**Consequence for §14.** The dressing lemma's joint bound (§15) is now proved for every decoration whose pieces are lone walls, surface pieces and single-spine pieces with pairwise link-disjoint rest contacts, and staked for the rest. Nothing above β = 0.2452 is claimed.

## 18. Lemma S12 proved on the generic contact structures: a minimal set weighs at most its sheet value (14:37 EDT, read from `date`)

**Theorem S12.** Let X be a Z₂-minimal all-½ closed set in ℤ⁴ with every link of multiplicity 2 or 4, Σ its sheet (§15(a)), Ĝ ⊂ Σ the preimage of the contact graph G_c. Suppose every component of Ĝ has cycle rank at most one. Then

  |W_½(X)| ≤ u^{|X|}·2^{χ(Σ)} ≤ 4u^{|X|}.

Every Z₂-minimal set of the census to F = 20 is of this kind (the pinches and double contacts: Ĝ a forest). The hypothesis fails only for a sheet touching itself along a graph with two independent cycles on the sheet; that case is STAKED below with its mechanism.

*Proof.* **(1) The three kinds of component.** A component of Ĝ is a tree (a SLIT), a simple cycle, or a cycle with trees attached (its boundary walk is the cycle's with trivial detours), so the cut surface Σ ∖ Ĝ has pieces P₁, …, P_J whose boundary curves are: one closed walk around each slit, with holonomy word freely equal to 1 (every edge traversed once each way); and, for each cycle δ_i of Ĝ, two curves, one on each side, with words w_i and w_i⁻¹ (the sides traverse δ_i oppositely; Σ orientable — the non-orientable case carries ε's as in A1 and the bounds below are unchanged). Each δ_i is a boundary component of exactly two pieces (or of one piece twice, which the same counting covers). Let Γ be the graph with the pieces as vertices and the δ_i as edges: connected, J vertices, #δ edges, b₁(Γ) = #δ − J + 1.

**(2) The cut formula and the genus identity.** By §15(b), W_½(X) = u^{|X|}·2^{Σ_P χ(P)}·I with I = ∫_{G_c} Π_{curves} χ_½(word). The slit curves contribute 2 each: I = 2^{#slits}·I_δ, I_δ := ∫ Π_i χ_½(w_i)². Euler: Σ_P χ(P) = Σ_P (2 − 2g_P − #∂P) = 2J − 2Σg_P − 2#δ − #slits, and χ(Σ) = Σ_Pχ(P) + #slits (cutting along a tree lowers χ by one, along a cycle by nothing), so g(Σ) = Σ_P g_P + b₁(Γ) and

  W_½(X) = u^{|X|}·2^{χ(Σ)}·I_δ.

It remains to show |I_δ| ≤ 4^{b₁(Γ)}·4^{−b₁(Γ)}… precisely: |I_δ| ≤ 1 when Γ is a tree, and in general |I_δ| ≤ 4^{s} with s the number of "stuck components" defined in (4), and s ≤ b₁(Γ) — which gives |W| ≤ u^{|X|}2^{χ(Σ)}·4^{b₁(Γ)}; the sharper count in (5) removes the 4^{b₁(Γ)}.

**(3) Free integration.** Call a contact link ℓ FREE for δ_i if one preimage of ℓ lies on δ_i, traversed once, and the other lies on a slit. Then the variable z_ℓ occurs in the integrand only in χ_½(w_i)χ_½(w_i⁻¹) (the slit word contains z_ℓz_ℓ⁻¹, which cancels), once in w_i; writing w_i = p z_ℓ s and substituting z_ℓ ↦ p⁻¹z_ℓs⁻¹ (Haar invariance, p and s fixed during the z_ℓ-integration) gives ∫dz_ℓ χ_½(w_i)² = ∫χ_½(z)² = 1, and w_i leaves the integrand. Repeat: whenever some remaining δ_i has a link free with respect to the REMAINING curves (its other preimage on a slit or on a curve already integrated out — the substitution does not touch the other curves' words), integrate it. Let R be the set of δ's that remain when no further step is possible: every link of every δ ∈ R has both preimages on curves of R.

**(4) The stuck set is small.** For δ ∈ R, φ(δ) ∈ Z₂^{links} denotes the set of links traversed an odd number of times by δ. Partition R by the relation "share a link"; the classes K are the components of the lattice graph G_R := φ(R). Within a class every link is covered exactly twice by the curves of K, so Σ_{δ∈K} φ(δ) = 0 in Z₂^{links}. For a set Q of pieces, ∂φ(Q) = Σ_{δ ∈ ∂_Γ Q} φ(δ) (slits cancel), and Z₂-minimality says ∂φ(Q) ≠ 0 for every nonempty proper Q, i.e. no nonzero vector of the cut space B(Γ) ⊂ Z₂^{E(Γ)} lies in ker φ. The indicator vectors 1_K of the classes are linearly independent vectors of ker φ, so their span meets B(Γ) in 0 and has dimension at most codim B(Γ) = b₁(Γ): the number s of classes is at most b₁(Γ). In particular, if Γ is a tree, R = ∅.

**(5) A stuck class is worth at most four, and the genus pays for it.** For a class K, expand χ_½(w)² = 1 + χ₁(w): I_K := ∫Π_{δ∈K}χ_½(w_δ)² = Σ_{A⊆K} ∫Π_{δ∈A}χ₁(w_δ). A link whose two preimages lie on δ ∈ A and δ′ ∉ A occurs once in the integrand, and ∫dz χ₁(pzs) = 0; since the curves of K are connected through shared links, only A = ∅ and A = K survive. In ∫Π_{δ∈K}χ₁(w_δ) every link occurs exactly twice, at spin 1, so each link integral is a merge with factor 1/3 (∫D¹(z)⊗D¹(z⁻¹) = (1/3)δδ, and the same-direction case (1/3)δδ for the real representation) and the result is 3^{L−E_K}, E_K the links of K and L the number of index loops of the transition system on the 4-regular graph whose vertices are K's links and whose edges are the curve segments between consecutive links. The bipartite incidence graph (loops ∪ links, an edge for each passage) is connected with 2E_K edges and L + E_K vertices, so L ≤ E_K + 1 and |I_K| ≤ 1 + 3 = 4. Hence |I_δ| ≤ 4^{s} ≤ 4^{b₁(Γ)} and, with (2), |W_½(X)| ≤ u^{|X|}·2^{χ(Σ)}·4^{b₁(Γ)}.
The sharper count: 2^{χ(Σ)} = 2^{2 − 2Σg_P − 2b₁(Γ)}, so |W_½(X)| ≤ u^{|X|}·2^{2 − 2Σ_P g_P} ≤ 4u^{|X|} — the genus of Σ created by the cycles of Γ pays exactly for the stuck classes, and the bound u^{|X|}2^{χ(Σ)} itself holds whenever s = 0, in particular whenever Γ is a tree. ∎

**Known answers.** Every pinch and double contact (Ĝ a forest: Γ one vertex, s = 0) reads u^F·2^{χ(Σ)} = 4u^F — all 5,376 to F = 20. The sphere with an equator whose links are scattered links of the same sphere (Γ a path, Ĝ a cycle plus slits): 4u^F, as computed in §14. The two self-contacts that read 2u^F and 8u^F (§14) are composites, with Γ's cut {δ} giving ∂φ = 0, and so are outside the theorem, as they must be.

**The staked remainder.** A component of Ĝ with two independent cycles has boundary walks (faces) whose words are not inverse pairs, so (3)'s substitution merges characters with a factor ½ instead of killing them, and the stuck integral at a link whose four passages lie in four different faces is the two-term Weingarten sum (Gram inverse (1/12)[[4,−2],[−2,4]]) rather than a spin-1 merge. STAKED: |W_½(X)| ≤ u^{|X|}2^{χ(Σ)} there too, the genus argument of (5) carrying over with the circuit count of the Weingarten terms; none occurs to F = 20. The multiplicity-6 links (three sheets of Σ through one link; none to F = 20) are covered by the same stake with the three-pairing structure.

**Consequence for the fold-in.** The tail's leaf activity 4u^F is PROVED for every Z₂-minimal leaf whose self-contact graph on the sheet has components of cycle rank at most one, which is every leaf in the census and the generic self-contact; the fold-in's conditionality on S12 is now exactly the staked remainder above. Nothing above β = 0.2452 is claimed.

## 19. Two roads and a certificate on §14's inequality; the spin range fixed by name; S13 at F = 20; corrections (14:37 EDT, read from `date`)

**The certificate (the Yang–Mills seat, `aperanton_kp_cert.awk`, ledger §117; 14:3x).** §14's inequality verbatim, every quantity an interval of exact integers on the grid 2^{−128}, the Bessel ratios as rational enclosures, exp with closed tails, the spin sums to J = 7 and the s-sum to S = 40 with closed tails, the dressing root bracketed on both sides (5·10⁻⁴ wide at 0.426), refusals by name. On the α-grid 2·10⁻⁴: **β* = 0.4260 at γ = 6 (every input proved)**, **β* = 0.4918 at γ = 5/2 (S13 staked for multi-spine pieces)**; β = 0.2452 passes at every γ with the left side 3·10⁻⁶ against α = 0.002 — Theorem 8.7's region deep inside. The float of §14 read 0.4266 and 0.4929; the difference is the bisection reporting its last passing midpoint rather than a grid point (at exactly 0.4266 and α = 0.0020 this seat's own components read 0.0020206 > 0.0020: FAIL, as the certificate says). The certificate's grid numbers are the numbers of record from here on.

**The second road (iii-38, `g52_reach.c` mode P, record 10dcc5e3).** Every count read from the census records, a_j by the series, α on the 2·10⁻⁴ grid, β by bisection: 0.4895 (γ = 5/2), 0.4250 (γ = 6), 0.4995 (F₀ = 22), 0.5359 and 0.5449 (μ = 4.33) — each 0.0016–0.006 BELOW the certificate, the same direction every time, κ five per cent larger. The cause, located by iii-38: its z₁ and z_surf sum over all j ≥ 1 including the half-integers (4a_{3/2} is 8 % of 3a₁ at β = 0.49). **The definition is fixed here by name (law 18 on §14's wording "j ≥ 1").** A piece plaquette sits on links of the rest with content j_S ⊗ j_S ⊗ j_w ∋ 0, which forces j_w ∈ {0, 1, …, 2j_S}: an INTEGER. So z₁ = e^{2α}Σ_{j ∈ ℕ, j ≥ 1} d_ja_j and z_surf(s) = e^{2αs}Σ_{j ∈ ℕ, j ≥ 1} d_ja_j^s (j = 1 alone on a spin-½ rest; the higher integers are kept as an upper bound covering higher-spin rests), while σ(F) = 1 + Σ_{j ≥ 1, half-integers included} d_j²(a_j/u)^F, since a closed surface at any single spin is admissible. With that definition the second road is asked to re-read; agreement to the grid digit with the certificate is the criterion.

**S13 at F = 20 (iii-38's patch column, `g50_weights6`; iii-bd's law).** The only branched pieces to F = 20 are single-spine pieces: the tripod (3 plaquettes on one off-rest link, 3,192 chambers, W/(3a₁³W(S)) = 2) and the FOUR-SPINE (4 plaquettes on one off-rest link, 200 chambers, W/(3a₁⁴W(S)) = 7). Correction to §14 and §17 by name: the (20/12/1) class is a four-spine, not a tripod with a fourth plaquette on a wing; iii-bd's J₄ = 7/27 is its exact value, met. S13's known answer to F = 20: γ_census = max_s (W/(3a₁^sW(S)))^{1/s} = 7^{1/4} = 1.627 (the tripod 2^{1/3} = 1.260); every other piece is a disc at ratio exactly 1. The rank-two link class (two walls or pieces sharing a link of the rest) reads |W|/(W(rest)·Π lone values) = 1 on every single-assignment chamber (896 at F = 16; 3,648 at 19; 37,120 at 20) and below 1 as a sum on the two-assignment classes (8/9; 232/243). The vertex law held on all 96,264 all-lone link-disjoint chambers at F = 20, the 4,800 touchings read 1, and no triple point occurs below F = 22.

**S13's status, stated at its strength (iii-bd, 14:3x).** PROVED: single-spine pieces, and any set of spines sharing no vertex (the factors multiply), at rate ≤ 3J_m^{1/m} ≤ 2.38a₁ (m ≤ 6). NOT PROVED: shapes where a vertex carries spokes of walls from different spines, or a wall has two or more spines (k = 2, 3, 4 spine links on one plaquette) — a tensor network's value is not bounded by the product of its tensors' norms, so the product-of-Cauchy–Schwarz form is a lemma to carry, not a theorem; each such shape is READ exactly by iii-bd's evaluator (ΑΓΚΥΛΗ II) when its plaquette list is given, and none occurs in the census to F = 20. So γ ≤ 2.38 is proved on every piece the census contains, and §14's γ = 5/2 remains a stake only for the multi-spine shapes that first appear beyond F = 20.

**The number's status now.** β* = 0.4260 rests on inputs every one of which is proved on the page and read by a second seat, EXCEPT: Lemma P and the counts (read here, §15; the second seat's reading pending), S12's staked remainder (a sheet touching itself along a two-cycle graph; §18), and the A1/S10′/D1 items in the second seat's queue. β* = 0.4918 adds the multi-spine stake of S13. Neither is a theorem of record until the certificate's gate arm is GREEN with its KAT and teeth and the paper revision is stamped. Nothing above β = 0.2452 is claimed.

## 20. S10″ refuted and §14's γ = 6 withdrawn as a proved rate: every threshold above 0.2452 is conditional on the junction theorem; the second reader's verdicts, the dressing repair, N_c(22), records b and c (16:3x EDT, read from `date`)

**THE CORRECTION (law 18 on §14 and on this section's own first draft, which had entered the Yang–Mills seat's S10″ as proved).** §14 priced every branched piece by S10′, |W(S ∪ Y)| ≤ √C(T)·3^{χ(D̂)/2}·a₁^n·W(S), and read it as (6a₁)^n "from 2^{b₁(T)}·3^{#pieces(D̂)}"; S10″ (14:4x) read the same lemma as 3√3·a₁ per plaquette for every decoration. Neither follows from S10′.
- *The double's second copy.* D̂ carries TWO copies of every plaquette of Y. A plaquette all of whose links are cut in D̂ — each rest link of it used twice in Y, each off-rest link of multiplicity ≥ 3 — is isolated in BOTH copies, two capped spheres with χ = 2 each, so it costs 3^{1/2}·3^{1/2} = 3 per plaquette of Y, and #pieces(D̂) ≤ n is false: #pieces(D̂) ≤ n + k with k the number of such fully branched plaquettes, and k → n on a three-dimensional foam over a region of S (every interior link of multiplicity 4; the smallest piece with a fully branched plaquette is the centre of a 3×3 lid over its 24 walls, 33 plaquettes, beyond the census). S10′ reads (9a₁)^n on the foam; no bound through S10′ is below 9.
- *The cut constant.* √C(T) ≤ 2^{b₁(T)}, and b₁(T) ≤ n is unproved: b₁(T) = n + b₁(Y) − b₂(Y) for the 2-complex Y in general; what is proved is b₁(T) ≤ |T| ≤ 3n.
So the per-plaquette rate S10′ PROVES for an arbitrary piece is 9·2³ = 72, and the readings at honest rates (`kp_reach5.py`, page dressing, μ = 5, F₀ = 20) are: γ = 9 → β* = 0.3607; 12 → 0.3144; 19.6 → 0.2477; 72 → 0.1301 — the last below Theorem 8.7's 0.2452. **Consequently every threshold on this page and in the certificate's records above β = 0.2452 — the "γ = 6, proved" column included — is CONDITIONAL on a junction theorem in general form, exactly as the γ = 5/2 column is.** The numbers stand as conditional readings; only the label moves. The seats were told at 16:2x.

**What is proved about decorations, at its strength.** Lone walls: the vertex law S8, rate exactly 3a₁ per wall times c(D), |c(D)| ≤ 1 (orientable rests; |c| ≤ 1 everywhere by A1), landed in III as ΑΓΚΥΛΗ II (28a77b3b9, canon T-774, run agkyle_gate.2026-10-29a). Surface pieces: S9, 3^{χ(Y)}a₁^n·r, |r| ≤ 1. Single-spine pieces and sets of spines sharing no vertex: S13, rate ≤ 3J_m^{1/m} ≤ 2.38a₁ (m ≤ 6; T-774). Nothing else. Every piece in the census to F = 20 is of these kinds (§19).

**THE JUNCTION THEOREM — the object of the trunk from here.** Sought: for every piece Y on an all-½ rest S, |W(S ∪ Y)| ≤ 3(γa₁)^{|Y|}·W(S) with an explicit γ, through the σ-link calculus and not through a Cauchy–Schwarz at T — every multiplicity-1 rest link of Y integrates to a rank-one projector (½ ⊗ ½ ⊗ 1 ∋ 0 once), every vertex of S touched by Y carries the trace tensor T_v = tr(Π σ)/2 of its spokes in the vertex-cycle order, |T_v| ≤ 1, every off-rest link of multiplicity m the projector P^{(m)} onto Inv(1^{⊗m}); the value is the contraction N(Y) := W(S ∪ Y)/((3a₁)^{|Y|}W(S)) of that network. Every value read so far has |N| ≤ 1: lone walls c(D), discs 3^{1−n}, the tripod 2/9, the four-spine 7/27, the (13/18/0) piece 8/729 — so γ = 3 is the natural STAKE, and the per-term bound |T_v| ≤ 1 that proves the vertex law is the kind of argument wanted; a tensor network's value is not bounded by its tensors' norms in general (iii-bd), so the theorem is a theorem, not a remark. Its first test is a piece no census reaches: the foam, where the sup bound of the characters alone gives 3^{|Y|}; and the first multi-spine, shared-vertex known answer asked of iii-38 and iii-bd is the 2×2×2 box interior (twelve plaquettes, six four-spines meeting at the centre vertex, every plaquette on two spines), beside the (13/18/0) chambers.

**S12 as the second reader left it (the Yang–Mills seat, 15:0x–16:2x; iii-38 16:2x).** On orientable sheets the proof of §18 is SIGNED step by step, with the headline restated as the chain it proves: |W_½(X)| ≤ u^{|X|}·2^{χ(Σ)}·4^{s} = u^{|X|}·2^{2 − 2Σ_P g_P − 2b₁(Γ) + 2s} ≤ u^{|X|}·2^{2 − 2Σg_P} ≤ 4u^{|X|}; the sheet-value form u^{|X|}2^{χ(Σ)} holds exactly when s = 0, which is every census leaf. The non-orientable clause of §18 was an ASSERTION with a mechanism against it (a one-sided cycle gives one curve traversing it twice, never free); it is now a LEMMA of the Yang–Mills seat (its ledger §119 quinquies): the piece formula is orientation-free in magnitude, |W(P)| = u^{|P|}2^{χ(P)}Π_c|χ_½(w_c)| — step (i), MEASURED on 196,224 cubical Möbius bands in [0,2]⁴ (`band_cert.2026-10-29a`: 8^n∫Π tr(U_p) = −4^n·tr(w) at every boundary assignment, the pseudo-real sign −1 of A1, 0 partings) — a one-sided cycle's single curve bounded by |χ_½| ≤ 2, which is exactly the −1 it contributes to Σχ(P); the two-sided cycles then run §18's (3)–(5) verbatim with s ≤ b₁(Γ₂). iii-38 has read and signed it (the pointwise 2 commutes with the integral because the remaining integrand is a product of squares); this seat reads it next and presses its step (iii). S12's remainder is therefore (a) stuck classes of cycle rank ≥ 2 and (b) multiplicity-6 links, both absent to F = 22; iii-38's free-component theorem (any rank: a component of Ĝ with no two edges over one lattice link and every link's other preimage free contributes exactly 2^{χ(H)}) narrows (a) to the stuck classes, and its channel theorem (∫dz z^{⊗4} = Π₀ + Π₁ at a contact link; Z(X) = W_½/u^F = Σ_{j∈{0,1}^L}Π_ℓ d_{j_ℓ}^{−1}N(j), the vertex model with G⁻¹ = [[1/3, −1/6], [−1/6, 1/3]]) is the form in which S12 says that the spin-1 exchanges at a minimal sheet's crossings never add up beyond the sheet value.

**The dressing lemma repaired (the Yang–Mills seat's reading of 16.58, 16.58-b, 16.65, 16.65-a; its ledger §119).** Lemma P, (W1)–(W5) and the counts HOLD; (W4)'s premise holds at every even rest multiplicity (the centre acts by (−1)^{m+Σ2j_i}). The lemma's STATEMENT holds, its PROOF had a hole: the induction uses 2|Q| wall sites for a piece base, where a wall rooted on a piece is counted once, up to Σ_{m_Q ≥ 2}(6 − m_Q) ≤ 8|Q| (the 2×2 disc holds sixteen). Repaired: canonical decomposition (Q_j the closing output from the smallest plaquette adjacent to U_{j−1}), first owners (a wall owns no link), sites P(s) = 4·min(2s, s(s−1)/2), the walls paid once on the closed set U ∪ Δ′ by (W3), the forest bound by induction. The repaired constant: κ_U = 2z₁ + κ′, κ′ the least root of κ′ = 8Σ_{s≥2}5^{s−1}max(z_surf(s), z_br(s))e^{2z₁s}e^{P(s)κ′/8}, and κ_U ≤ κ* − 2z₁(e^{κ*} − 1) < κ*, so §14's recursion remains a valid weaker form. iii-38 lands the repair as 16.65-b and meets the digits.

**Records b and c — conditional readings, both dressings, 2·10⁻⁴ grid, met by iii-38's g52 to the grid digit.** F₀ = 20: page 0.4260 (γ = 6) and 0.4918 (γ = 5/2); tree 0.4378 and 0.4952. F₀ = 22 with N_c(22) = 46,816 (iii-38, b11a70dbf: 39,776 one-contact and 7,040 two-contact Z₂-minimal leaves, every lattice contact graph a forest, no multiplicity-6 link below 24; their activity 4u²² pending g50's exact weights): page 0.4288 and 0.5020 (0.4290 refused by name, ρ ≥ 1), tree 0.4422 and 0.5058. The Bessel ratios are met by ΑΛΟΓΟΝ's grid 9009/9009 (two engines, no shared line). Every one of the eight is conditional on S13 in general form (this section) and on S12 (a), (b); the run of record for the gate arms (131, 134) is run ai after ah's END.

**Other signatures entered.** A1 SIGNED with the caveat that S8's vertex TABLE is for orientable rests (only |c| ≤ 1 is general; §13's table is cited as orientable from here on). D1.1 SIGNED up to its constant: a cut curve of length two is possible at a pinch, so K_A := 2^{4|L_A|}·6|L_A|·(1 + α) replaces §16's 2^{|L_A|}; it moves K_A, never α. D1.2–D1.4 SIGNED as conditional on §14. S13 single spine SIGNED (J₃ = 2/9, J₄ = 7/27 by hand; the record carries 4|T_m|² = 12, 24, 84, 240, 732 at m = 2..6). The spin ranges CONFIRMED by the certificate (z₁, z_surf over integer j; σ(F) over every j ≥ 1 with the half-step tail), the numbers unmoved.

**Status.** Nothing above β = 0.2452 is claimed by any seat. The trunk's Part F is not met: the junction theorem is the work.

## 21. THE JUNCTION THEOREM — the exact spoke calculus of a decorated sheet, the spoke rule, the vertex-degree Cauchy–Schwarz, the graded rates, and the number they give for the singly-attached sub-gas (18:17 EDT, read from `date`; written after the reboot of 16:46)

**Setting.** S a closed branch-free orientable surface at spin ½ (the rest); Y a piece — a set of plaquettes off S, link-connected through its off-S links, every off-S link of multiplicity ≥ 2 in Y — at spin 1 on every plaquette. T := L(Y) ∩ L(S) the rest links, m_T(ℓ) ≥ 1 the number of Y-plaquettes on ℓ ∈ T. N(Y) := W(S ∪ Y)/((3a₁)^{|Y|}W(S)).

**J1 (the σ-link identity).** For U ∈ SU(2), with D¹(U)_{AB} := ½ tr(σ^A U σ^B U⁻¹) the real adjoint matrix,

  U_{ab}(U⁻¹)_{cd} = ½ δ_{ad}δ_{bc} + ½ Σ_{A,B} D¹(U)_{AB} σ^A_{ad} σ^B_{cb}.

(Contract with X_{bc}: the left is (UXU⁻¹)_{ad}; the right is (tr X/2)δ_{ad} + Σ_A (Σ_B D¹_{AB} tr(σ^BX)/2) σ^A_{ad}, which is the decomposition of X into its trace and Pauli parts carried by the adjoint action.) S orientable ⇒ its plaquettes can be oriented so that every link of S is traversed once forward and once backward by its two S-plaquettes, so every S-link carries exactly the pair U ⊗ U⁻¹ of J1. Integrating a link with no Y-plaquette gives the singlet ½δ_{ad}δ_{bc}; the index contractions of S's plaquette traces then close into one index loop per VERTEX of S (the loop runs around the vertex cycle), so W(S) = (2u)^{|S|}·2^{−E_S}·2^{V_S} = u^{|S|}2^{χ(S)} — S2 re-derived. Integrating a link carrying one Y-plaquette with D¹(U)_{CD} (its first index at the link's tail, its second at the head, whichever way the plaquette traverses it) gives (1/6)σ^C_{ad}σ^D_{cb}: relative to the bare ½δδ, a factor 1/3, with σ^C inserted on the vertex cycle at the tail and σ^D on the vertex cycle at the head.

**J2 (the exact calculus; m_T ≡ 1).** With τ_v := tr(Π σ^{A})/2 the trace of the Pauli matrices inserted on v's vertex cycle in the cycle's order (τ_v = 1 at a vertex no rest link of Y touches), and H_Y(C⃗, D⃗) := ∫_{off-S links} Π_{q∈Y} tr(Π_{ℓ∈q} M_ℓ) with M_ℓ = the 3×3 matrix unit E_{C_ℓD_ℓ} (or its transpose, by the traversal) at ℓ ∈ T and M_ℓ = D¹(U_ℓ)^{±1} off S,

  N(Y) = 3^{−|T|} Σ_{(C_ℓ, D_ℓ)_{ℓ∈T}} Π_{v∈V(S)} τ_v · H_Y(C⃗, D⃗).

Known answers, all exact: a lone wall (four rest links, H = Π δ around the square, every vertex a corner σ^Xσ^X = 1) gives 3^{−4}·3^4 = 1 — S7; a disc of n plaquettes attached along its boundary gives 3^{1−n} — S9; a single spine of m walls gives 3^{−m}⟨T_u, T_v⟩ = J_m with T_u(A⃗) = tr(Π σ^{A_i})/2 in u's spoke order — S13 (the two far vertices of each wall are corners, the m spoke indices meet P^{(m)} at the spine, the identity between invariant tensors). The three laws of §§13, 17 are three special cases of one formula.

**J3 (the spoke rule).** τ_v ≠ 0 iff the Pauli word at v is ∝ 1 iff the F₂²-sum of the indices at v vanishes (X, Y, Z ↦ the nonzero vectors of F₂²); |τ_v| ∈ {0, 1}. A corner — two consecutive rest links of one plaquette at v — carries one index twice and contributes 0 to the sum. Hence: **a vertex of S touched by exactly one spoke of Y kills the piece**, N(Y) = 0 (Gauss's law of the sheet at a vertex); and the number of index words at a vertex with c_v corners and r_v free spokes is 3^{c_v}·E(r_v), E(r) := (3^r + 3(−1)^r)/4 = 1, 0, 3, 6, 21, 60, 183, 546, 1641 at r = 0..8.

**J4 (the vertex-degree Cauchy–Schwarz).** With r_v the number of free spokes at v (rest links of Y at v not paired by a corner of their own plaquette), e(r) := E(r)/3^{r/2} (e = 1, 0, 1, 1.1547, 2.3333, 3.8490, 6.7778, 11.675, 20.259 at r = 0..8), and D_Y the double of Y glued along T:

  |N(Y)| ≤ Π_{v} √e(r_v) · √W(D_Y) / (3a₁)^{|Y|}.

*Proof.* Cauchy–Schwarz on the index sum of J2 with 3^{−|T|} = 3^{−|T|/2}·3^{−|T|/2}: ‖3^{−|T|/2}Π_vτ_v‖₂² = 3^{−|T|}Π_v 3^{c_v}E(r_v) = Π_v E(r_v)3^{−r_v/2} because the index slots at different vertices are disjoint variables and Σ_v(2c_v + r_v) = 2|T|; ‖3^{−|T|/2}H_Y‖₂² = W(D_Y)/(3a₁)^{2|Y|} by Peter–Weyl (h_Y(U_T) = (3a₁)^{|Y|}Σ H_Y Π_ℓ D¹(U_ℓ)_{C_ℓD_ℓ}, the matrix elements orthogonal with norm² 1/3). ∎ It is EXACT on lone walls (1), on discs (3^{1−n}: the boundary vertices have r = 2 or a corner, e = 1; D is a sphere of 2n plaquettes, 3^{2−2n}), and on the tripod (e(3) at u and w, √(3^{−3}R₃): 2/9); on the four-spine it reads e(4)·3^{−2}√3 = 0.449 against the exact 7/27. It carries NO C(T): only vertices of S with three or more free spokes cost anything, and S10′'s cut constant is gone. Non-orientable S: J1 holds with ε-conjugated Paulis at the orientation-reversing links (A1), the traces change by signs only, J3 and J4 are unchanged.

**J5 (the double).** Cutting D_Y along its links of multiplicity ≥ 3 and capping, W(D_Y)/(3a₁)^{2|Y|} ≤ 3^{Σ_P(χ(P)+n_b(P)−n(P))} ≤ 3^{2#pieces − 2|Y|} ≤ 3^{2k}, k := the number of plaquettes of Y with no rest link and every off-S link of multiplicity ≥ 3 (each is isolated in both copies; every other piece has ≥ 2 plaquettes), so √W(D_Y)/(3a₁)^{|Y|} ≤ 3^{k}. The rank form — the interiors 3^{χ(P)−n(P)} and the boundary characters contracted through the branch links' projectors, |tr(⊗P_ℓ·Π)| ≤ Π rank — gives √(Π_P 3^{χ(P)−n(P)}·Π_{ℓ} R_{m_ℓ}) instead, R_m = dim Inv(1^{⊗m}) = 1, 1, 3, 6, 15 at m = 2..6; on a spine 3^{−m/2}√R_m, on a foam of multiplicity-4 links 3^{#links/2} ≈ 3^{|Y|/2}·… — both are the sup bound's 3 per plaquette on the three-dimensional foam, where nothing better is proved.

**J6 (the universal rates, m_T ≡ 1).** e(r)^{1/(2r)} increases in r (1, 1.0243, 1.1117, 1.1443, 1.1729, 1.1918, 1.2068 at r = 2..8) and r_v ≤ 8 on ℤ⁴, so Π_v√e(r_v) ≤ e(8)^{|T|/8}; k ≤ |Y| − |T|/3 (a plaquette of a piece has at most three rest links); the product is at most max_{t∈[0,3]}(e(8)^{t/8}·3^{1−t/3})^{|Y|} = 3.0903^{|Y|} at t = 3. **For every piece with singly-used rest links, |N(Y)| ≤ 3.0903^{|Y|}, i.e. γ_sup = 3·e(8)^{3/8} = 9.271** — the foam's 9 plus the degree factor, for every size. Graded by size: r_v ≤ min(8, |Y|) and k = 0 below nine plaquettes (a fully branched plaquette needs eight witnesses, two per link, no two sharing more than one link), so with D = min(8, s)

  γ(s) ≤ 3·e(D)^{3/D}: γ(1) = 3 (S7), γ(2) = √3 (every 2-piece is a disc, S9), γ(3) = 3.4641, γ(4) = 5.6577, γ(5) = 6.7349, γ(6) = 7.8103, γ(7) = 8.6101, γ(s ≥ 8) = 9.2709,

each an algebraic number (3·(E(D)/3^{D/2})^{3/D}); the census reads 1.82 at s = 3 and 2.14 at s = 4 — the degree accounting (every vertex at the maximal spoke count) is what is loose.

**J7 (multiply-used rest links — the two channels).** At a rest link carrying m Y-plaquettes, Inv(½⊗½⊗1^{⊗m}) = Inv(1^{⊗m}) ⊕ Hom(1, 1^{⊗m}), and the link integral is the sum of a LIFT channel — the singlet of the sheet's pair, weight 1 relative to the bare link, the m plaquettes merged by P^{(m)}, no insertion on S: the link lifted off the sheet — and R_{m+1} SPOKE channels of weight 1/3 each, σ^A at the tail and σ^B at the head, the m plaquettes' indices fused into (A, B) through an equivariant co-isometry F^{(i)}: 1^{⊗m} → V₁ (for m = 2 the one channel F = ε/√2: ∫D¹_{AB}D¹_{CD}D¹_{C′D′} = ε_{ACC′}ε_{BDD′}/6). So a multiply-used rest link is EITHER absent from the sheet's vertex cycles OR one composite spoke. The Y-functions of the channels are the isotypic components of h_Y in U_ℓ (spins 0 and 1; the spin-2 part of 1⊗1 never couples to the sheet), orthogonal, so Σ_c‖h_c‖² ≤ W(D_Y)/(3a₁)^{2|Y|}, and the Cauchy–Schwarz over the channel sum gives

  |N(Y)| ≤ √( Σ_{c ∈ {lift, spoke}^{T₂}} Π_v e(r_v^{(c)}) ) · √W(D_Y) / (3a₁)^{|Y|},

r_v^{(c)} counting a composite spoke once at each end in its spoke channel and not at all in its lift channel. Since e(r−1)/e(r) ≤ 0.866 (r = 3) and ≈ 1/√3 beyond, a doubly-used link costs at most √(1 + 0.75) = 1.32 against the singly-used bound, typically 1.155. The cube on one link (six faces of a unit cube sharing one link with S): the lift channel is the cube's own 3^{2−6}, the spoke channel dies by J3 (one spoke at each end) — N = 1/81 exactly, as the composite rule says. The two-lone-walls-on-one-link reading (1/3 from the lift, ∓2/9 from the spoke: 5/9 or 1/9) is iii-ac's known-answer test of this section.

**J8 (what the rates give, and what the number needs).** The size-graded fold-in (`records/surface-gas/kp_reach6.py`, z_br(s) = (γ(s)a₁e^{2α})^s with no prefactor, the page dressing, μ = 5): **the sub-gas of pieces with singly-used rest links reads β* = 0.4709 at F₀ = 20 and 0.4759 at F₀ = 22**, every input proved (S2–S4′, S6–S9, S11, S12 on the census, S13, J1–J6, Lemma P and the counts), against 0.3589 at the uniform γ = 9.271 — the graded table is worth 0.11 of β. The number is governed by the rate on pieces of five or more plaquettes: γ(s ≥ 5) = 15 reads 0.3747, 25 reads 0.3247, 35 reads 0.2490 (below Theorem 8.7's 0.2452). The full gas needs the multiply-used pieces: J7's per-link 1.32 is affordable, the double's cut at the doubly-used links (3 per plaquette isolated in both copies, J5) and the degree factor at vertices of eight spokes are not — the crude universal rate for a plaquette with three doubly-used rest links at eight-spoke vertices and one off-S link of multiplicity six is 3·13.7 ≈ 41, and at 41 the KP sum diverges at β = 0.45 (the tail needs 5·γ·a₁e^{κ} < 1, γ < 21 there). **So the proved number for the FULL gas is not yet a number**: the junction theorem's constants for dense pieces are the object, in this order — (i) iii-ac's exact box reading and the two-walls-on-one-link reading as the two known answers of J2/J7; (ii) the v2 bound computed exhaustively over every census piece to F = 20 (a mechanical read of r_v, m_T, the ranks), which turns γ(s ≤ 20) into exact maxima; (iii) a tail bound below 21 for s > 20 — the degree factor is the loose term (the four-spine's 0.449 against 7/27, the box's 12.7 against a value that will be far below one) and the vertex tensors' signs are where the missing cancellation lives: iii-bd's inner-product form across a spine link is the model of the sharper cut. The conjecture the readings suggest, |N(Y)| ≤ 1 for every piece (γ = 3, β* ≈ 0.49), is stated as a conjecture and nothing more.

**Status.** Nothing above β = 0.2452 is claimed. The Part F criterion is not met: the sub-gas number 0.4709 is proved for the sub-gas; the full gas waits on J8's three items.

**§21, added 18:5x EDT (law 18 on J7's worked example; two known answers read).** (a) TWO LONE WALLS ON ONE LINK OF S read 1 in the census (iii-ac: profile (21/6/1/0) at F = 16, 896 polymers, r = 1; the L-tromino's two internal walls; the hand road through χ₁ = χ_½² − 1 gives T₁ = 2^{4−|S|}, T₂ = T₃ = 2^{3−|S|}, ρ = 4 on every sphere — the adjoint exchange between the two walls is exactly zero after the sheet's own integration). J7's bookkeeping was RIGHT and my arithmetic was wrong: redoing the spoke channel with the walls' indices placed correctly — w₁'s index at ℓ's v-end is its link-2 index C₂, at the w-end its link-1 index C₁, the corner δ's — the channel sums Σ_{A,C₂,C₂′} ε_{AC₂C₂′}·iε_{AC₂′C₂} = −6i at v and ±6i at w, and the spoke term is (1/6)·3^{−6}·81·36 = +2/3, not ∓2/9: N = 1/3 (lift) + 2/3 (spoke) = 1, the product of the two lone values, as the census and the hand road say. The known-answer test of the two-channel calculus PASSES after the correction of its author.

(b) J9 (THE PAIRING EXPANSION — a third road to J₄). Since tr(σ^{a₁}⋯σ^{a_{2k}})/2 = Σ_{pairings} (−1)^{crossings} Π δ (the sl₂ weight system, T-774), every vertex tensor is a signed sum of pairings of its free spokes, and with the corners pulled out

  N(Y) = 3^{−|T|}·3^{#corners}·Σ_{π = (π_v)_v} (−1)^{cr(π)} I(π),  I(π) = ∫_{off-S} Σ_{pair indices} Π_{q∈Y} (M_q)_{·,·},

M_q the product of q's off-S matrices between its two rest-link slots, each pair of slots identified by its δ. On the four-spine: nine pairings at (u, w); the three with the same pairing at both ends give ∫(tr DᵀD)² = 9 each, the six with different pairings give Σ_{AA′}(DᵀD)²_{AA′} = 3 each with signs (+,+,+ ; −,−,−,−,+,+), so Σ = 27 − 6 = 21 and N = 3^{−12}·3^{8}·21 = 21/81 = 7/27 — iii-bd's reading, by hand, sharing no line with the engine or with S13's inner product. The pairing form is the exact evaluator's form; as a bound it gives Π_v (r_v − 1)!!·3^{|Y_∘|}, weaker than J4 wherever r_v ≥ 4.

(c) THE BOX. iii-ac's engine reads the 36-plaquette set (the 2×2×2 surface and its twelve interior plaquettes) at ρ/4 = 10657165/3^{19} = 0.0092 summed over its thirty-five spin assignments with twelve plaquettes at spin 1; the per-assignment column (the surface at ½, the interior at 1) is the number J2 computes, and it is at most that. J4's bound for it is 12.7 (six face centres at r = 4, twelve corners at the edge midpoints, the double's rank bound 1); the loose term is the DOUBLE: gauge-fixing the copy's spokes, W(D_box)/(3a₁)^{24} = 3^{−12}·∫_{SU(2)^6} Π_{(i,j) ∈ edges of the octahedron} χ₁(U_iU_j) — the spin-1 octahedron integral the Yang–Mills seat is computing (F₁(1)) — whose sup bound 3^{12} is what the rank form used; at F₁(1) = 3^{4} the bound would read 0.157. So the double's exact value, not the degree factor alone, is where J4 loses on dense pieces, and the double is COMPUTABLE: the junction bound with the exact double is the sharper instrument for every census piece.

(d) THE FLOATS CORRECTED (the Yang–Mills seat's brackets from the closed forms on the 2^{−128} grid, 18:5x). Three of J6's printed floats were typing slips against their own closed forms: γ(4) = 3·(7/3)^{3/4} = 5.663746 (printed 5.6577), γ(7) = 3·(546/3^{7/2})^{3/7} = 8.600465 (printed 8.6101), γ(s ≥ 8) = 3·(1641/81)^{3/8} = 9.270541 (printed 9.2709; the script's default carried 9.2673). γ(2) = 1.732051, γ(3) = 3.464102, γ(5) = 6.734884, γ(6) = 7.810250 stand. The closed forms are the statement; the certificate carries them as roots of exact rationals and never types a float. Record b of `kp_reach6.py` re-reads the sub-gas at the corrected table: see the record beside this page (the number moves in the fourth place, if at all).

## 22. The double is where the smallness lives: the box calibrated, the operator form, and the one universal lemma the full gas needs (18:50 EDT, read from `date`)

**J4 with the exact double on the 2×2×2 box interior.** Gauge-fixing the copy's spokes, W(D_box)/(3a₁)^{24} = 3^{−12}·F with F := ∫_{SU(2)^6} Π_{(i,j) ∈ E(octahedron)} χ₁(U_iU_j) dU — the spin-1 octahedron integral. F = 16981/202500 = 0.083857 is the Yang–Mills seat.s identity-hold reading of the spin-1 walls on the octahedron (F₁(1), the 120-point 11-design 2I, 18:4x), taken here as that integral pending its own confirmation of the identification; `records/surface-gas/octa_f1.py` computes the same integral exactly by a road sharing no line — each U_i integrated by the projector onto Inv(1^{⊗4}) in the pairing basis, Gram 6I + 3J, inverse (5I − J)/30, the twelve edge pairs contracted as one integer tensor sum — and its value is appended when it ends. So W(D_box)/(3a₁)^{24} = 1.578·10^{−7}, and J4 reads

  |N(box)| ≤ (7/3)^{3} · √(1.578·10^{−7}) = 12.70 · 3.97·10^{−4} = 0.0050,

where the rank form had given 12.7: the degree factor of the six face centres (12.7) is more than paid by the double, and the bound sits below iii-ac's thirty-five-assignment sum ρ/4 = 0.0092 (the per-assignment column, the exact N(box), is awaited from two engines). **The lesson is general:** on a dense piece the junction bound is sharp enough once the double is exact; what is loose in J5 is the cap and the rank form, not J4.

**J10 (the operator form).** Cut the Y-network along any set K of off-S links into two halves, each half carrying the vertex tensors of the sheet's vertices it touches. The cut links' projectors have operator norm one, so

  |N(Y)| ≤ ‖Ω₁‖·‖Ω₂‖,  ‖Ω_i‖² = N(Y_i ∪_K Y_i*) ,

the Frobenius norm over the cut legs of a half being the value of the DOUBLED HALF — the half's plaquettes with their copy glued along K — which is itself a decoration of S. The spine cut at its link gives iii-bd's |J_m| ≤ ‖T_u‖‖T_w‖/3^m = E(m)/3^m (S13); a disc cut across gives 3^{1−n}. J4 is the case K = ∅ with one half the sheet; J10 moves the cut into the piece, where the halves' doubles are smaller objects.

**The one universal lemma the full gas needs.** Every term of §21's accounting is now exact or sharp except one: a universal bound on the weight of a closed spin-1 complex,

  ρ(D) := ( ∫ Π_{q∈D} χ₁(U_q) dU )^{1/|D|},

since W(D_Y)/(3a₁)^{2|Y|} = ρ(D_Y)^{2|Y|} enters J4 and J7 as √. What is known: a closed surface has ρ = 3^{(χ−n)/n} → 1/3; the spine's double 3^{−m}R_m, ρ → 1 from below; the box.s double ρ = (1.578·10^{−7})^{1/24} = 0.521; the two-block foam's rank form 3^{−10}; the sup bound ρ ≤ 3 everywhere; and the rank form Π_P 3^{χ(P)−n(P)}·Π_ℓ R_{m_ℓ} exceeds one only where high-multiplicity links outnumber the pieces' Euler deficits — the full plaquette set of a region of ℤ⁴ (every link in six plaquettes) reads 15^{2/3} = 6.1 per plaquette on the rank form and 3 on the cap. **If ρ(D) ≤ 1 for every closed D, the junction bound's rate is the degree factor alone, 3·e(8)^{3/8} = 9.27 for every piece at every multiplicity (the channel factor 1.32 per doubly-used link included: ≤ 3·1.457³·1.32³ = 21 at eight-spoke vertices, 15 at three) and the full gas has a proved number ≈ 0.36 at the uniform rate and more when graded; if ρ can exceed one on dense complexes, the dense tail is where the lattice gap's expansion needs a different organisation.** The lemma is stated as the object; the experiments that bear on it: the full plaquette set of the 2⁴ and 3⁴ blocks (24 and 216 plaquettes) integrated exactly by the same projector method; the doubles of every census piece (iii-ac's exact-double column); the 3D foams. Nothing above β = 0.2452 is claimed.

**§22, added 18:57 EDT — two roads on the box's double, the convention derived, and the 4-cube's full plaquette set weighed exactly.** (a) THE CONVENTION. In the double of the box interior each interior plaquette q (vertices f₁, m, f₂, c; spokes U_a from the centre c to the face centre a) and its copy q* share the two rest links; merging them gives (1/3)·χ₁(U_{f₂}^{−1}U_{f₁}·(U*_{f₂}^{−1}U*_{f₁})^{−1}) = (1/3)·χ₁(V_{f₂}^{−1}V_{f₁}) with V_a := U_aU*_a^{−1}, Haar-distributed; so W(D_box)/(3a₁)^{24} = 3^{−12}·∫Π_{(a,b)∈E(octahedron)} χ₁(V_aV_b^{−1}) — the INVERSE on the second spoke, which the Yang–Mills seat's F₁(1) carries (its walls traversed as closed squares). On the octahedron, which has triangles, this is not the integral without the inverse. (b) THE SECOND ROAD AGREES TO THE RATIONAL: records/surface-gas/octa_f1b.py (the projector onto Inv(1^{⊗4}) in the pairing basis, Gram 6I + 3J, inverse (5I − J)/30, the twelve edges contracted vertex by vertex as one integer sum, ORIENT=inv) reads F = 61131600/30^6 = 16981/202500 = 0.0838568 — the Yang–Mills seat's value under the 120-point design, two engines sharing no line; and without the inverse (ORIENT=same) 20891760/30^6 = 87049/3037500 = 0.0286581, a different number, as the seat said. So W(D_box)/(3a₁)^{24} = 1.5779·10^{−7}, ρ(D_box) = 0.5207, and J4 with the exact double reads 0.00505 for the box. (c) THE 4-CUBE'S FULL PLAQUETTE SET, EXACTLY (records/surface-gas/tesseract_rho.py): 24 plaquettes, 32 links, every link in exactly three plaquettes, so every link integral is the rank-one projector ε_{X₁X₂X₃}ε_{Y₁Y₂Y₃}/6 (the three plaquettes in one order on both), and THE INTEGRAL FACTORISES OVER THE SIXTEEN VERTICES: ∫Π_{24}χ₁ = 6^{−32}·Π_v t_v, t_v the tetrahedral ε-network of the four links at v contracted along the six plaquette corners there — t_v = +6 at all sixteen vertices (every pair of links at a vertex of the 4-cube spans one plaquette: the net is K₄, Σε_{abc}ε_{ade}ε_{bdf}ε_{cef} = 6), so ∫Π_{24}χ₁(U_q) = 6^{−16} = 3.54·10^{−13} and ρ = 6^{−2/3} = 0.3029 — the densest 4D complex the rank form priced at 6.1 per plaquette (15^{2/3}) and the cap at 3 weighs LESS per plaquette than a closed surface's 1/3 at this size. The same theorem holds for every closed complex of multiplicity three throughout: the weight is 6^{−L}·Π_v t_v with t_v a closed ε-network at v. (d) THE VERTEX-AMPLITUDE FORM, in general: with an orthonormal basis of intertwiners u_ℓ^{(i)} at each link, ∫Π_qχ₁(U_q) = Σ_{labelings} Π_v A_v, A_v the contraction at v of the chosen intertwiners' legs along the plaquette corners at v, and |A_v| ≤ 1 by the Frobenius inequality (every corner joins two different links) — which is the rank bound; the smallness is in the amplitudes: the tetrahedral A_v = 1/6, a surface vertex of d plaquettes A_v = 3^{1−d/2}, and the box's double sums 3^{12} labelings to 1.6·10^{−7}. THE UNIVERSAL LEMMA is therefore a bound on vertex amplitudes summed over labelings — ρ(D) ≤ 1 is now evidenced on every dense complex read (the box's double 0.52, the 4-cube 0.30, the 3D two-block 3^{−10/36}) and refuted on none. Nothing above β = 0.2452 is claimed.

## 23. THE VERTEX-NORM THEOREM — the weight of a closed spin-1 complex is at most the product over its vertices of the square roots of their star integrals; the universal double bound becomes a finite computation (19:05 EDT, read from `date`)

**Theorem V.** Let D be a finite closed set of plaquettes of ℤ⁴ (every link in at least two), all at spin 1, and I(D) := ∫Π_{q∈D}χ₁(U_q) dU. For a vertex v of D let G_v be the graph whose vertices are the links of D at v and whose edges are the plaquettes of D at v (each plaquette at v joins its two links at v; two links span at most one plaquette, so G_v is simple, a subgraph of the cocktail-party graph K_{2,2,2,2} on the eight directions, with every vertex of degree ≥ 2), and let

  S(G_v) := ∫_{SU(2)^{V(G_v)}} Π_{(i,j) ∈ E(G_v)} χ₁(U_i^{−1}U_j) dU

be its STAR INTEGRAL. Then |I(D)| ≤ Π_{v} √S(G_v).

*Proof.* Expand each link integral in an orthonormal basis of its invariants: ∫D¹(U_ℓ)^{⊗m_ℓ} = Σ_λ |u_ℓ^λ⟩⟨u_ℓ^λ|, the ket's m_ℓ legs the plaquettes' row indices at ℓ's tail, the bra's their column indices at its head. The plaquette traces contract indices only at vertices (a corner joins two links' legs for one plaquette), so I(D) = Σ_{labelings λ} Π_v A_v(λ), A_v(λ) := ⟨W_v | ⊗_{ℓ∋v} u_ℓ^{λ_ℓ}⟩, W_v the product of the corner δ's at v. This is a closed tensor network whose tensors are the A_v and whose indices (the labels) are each shared by exactly two tensors (a link's two ends), with no self-loop; contracting it pairwise is a sequence of matrix products, each bounded in Frobenius norm by the product of the factors' Frobenius norms, so |I(D)| ≤ Π_v ‖A_v‖_F. And ‖A_v‖_F² = Σ_λ |A_v(λ)|² = ⟨W_v| ⊗_ℓ (Σ_λ|u_ℓ^λ⟩⟨u_ℓ^λ|) |W_v⟩ = ∫Π_{ℓ∋v}dU_ℓ ⟨W_v| ⊗_ℓ D¹(U_ℓ)^{⊗m_ℓ} |W_v⟩ = ∫Π_{q∋v} Σ_{ab} D¹(U_ℓ_q)_{ab} D¹(U_{ℓ′_q})_{ab} = ∫Π_{q∋v} χ₁(U_{ℓ_q}^{−1}U_{ℓ′_q}) = S(G_v), each corner δ turning into one spin-1 character of the two links' relative rotation. (The sign of I(D) is not claimed in general; every value read so far is positive.) ∎

**Known answers.** A closed surface: every vertex of d plaquettes has G_v = C_d and S(C_d) = 3^{2−d} (integrate round the cycle, 1/3 per link, χ₁(1) = 3 at the close), so Π_v√S = 3^{Σ(1−d_v/2)} = 3^{V−E} = 3^{χ−F}: THE BOUND IS EXACT on every closed surface. The 4-cube's full plaquette set: G_v = K₄ at all sixteen vertices, S(K₄) = 1/36, Π√S = 6^{−16}: EXACT again (§22 (c)). The box's double: at its two centres G = K_{2,2,2} with S = 16981/202500 (§22), at the twelve edge midpoints and the six face centres the local graphs are small cycles and their unions — the product over all twenty vertices is an upper bound on the exact 1.578·10^{−7} and is read beside it when the local graphs are tabulated. The vertex graphs are finite in number: a subgraph of K_{2,2,2,2} with minimum degree two — so **the universal double constant is a FINITE COMPUTATION**: with s(G) := S(G)^{1/|E(G)|} the per-plaquette-corner rate and s_max its maximum over the admissible vertex graphs, Σ_v|E(G_v)| = 4|D| gives

  I(D) ≤ s_max^{2|D|},  i.e. ρ(D) ≤ s_max².

**The values in hand.** s(C₃) = 3^{−1/3} = 0.693, s(C₄) = 3^{−1/2} = 0.577, s(C_d) ↓ 1/3; s(K₄) = 36^{−1/6} = 0.550; s(K_{2,2,2}) = (16981/202500)^{1/12} = 0.813. The dense graphs are the large ones; **S(K_{2,2,2,2}) (eight directions, twenty-four plaquettes at one vertex — the vertex star of the full plaquette set of ℤ⁴) is the value that decides s_max**, with K_{2,2,2,1} and the near-complete subgraphs beside it; the projector contraction that read the octahedron in four seconds needs 9^{12} intermediates on K_{2,2,2,2} and is asked of the engines in the label basis (S(G) = Σ_{λ}C(λ)², C the spin-network evaluation of G with the intertwiners λ at its vertices).

**What it closes if s_max ≤ 1.** The double in J4 and J7 obeys √W(D_Y)/(3a₁)^{|Y|} = √I(D_Y) ≤ s_max^{|Y|}, so the junction bound's rate for EVERY piece, singly or multiply attached, is 3·(degree factor)·(channel factor)·s_max with the three factors bounded in J6 and J7: at most 3·e(8)^{3/8}·1.155³·s_max = 14.3·s_max at eight-spoke vertices and 3·e(3)·1.32³·s_max = 8.0·s_max at three-spoke ones — below the KP tail's divergence line (21 at β = 0.45) for any s_max ≤ 1, and the full gas then has a proved number by the graded fold-in. If s(K_{2,2,2,2}) is near 0.81 the universal rate is ≈ 9.4 on the densest attachment and the graded number stays near the sub-gas's. Nothing above β = 0.2452 is claimed; s_max is the one number owed.
