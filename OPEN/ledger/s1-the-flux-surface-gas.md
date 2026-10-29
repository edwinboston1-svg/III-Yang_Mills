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
