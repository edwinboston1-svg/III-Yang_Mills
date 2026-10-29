# S1 — THE FLUX-SURFACE GAS: the mathematics the physical picture asks for, its ceiling measured, its theorem staked (Edwin Boston III, 2026-10-29, 09:0x EDT by the clock)

> Status: three lemmas PROVED below; one measurement OF RECORD (`records/surface-gas/`); the theorem it points to is STAKED, NOT PROVED. Nothing here is claimed above β = 0.2452 until the theorem of §5 is complete. This page is about the lattice theory at strong coupling and its reach; it is not the continuum gap.

## 1. The order, and what the physical picture says

At 08:5x the operator directed that when the mathematics stalls it be related to the thing it portrays, detail by detail, until a representative mathematics emerges. The thing portrayed is the gluon field. At short distance it is a stiff medium whose stiffness is 1/g². Gluon spins align with any colour field, and that paramagnetic response outweighs the orbital screening, so the medium erodes its own stiffness by a fixed amount per doubling of scale (Wilson's β falls by 0.2575 per doubling at one loop for SU(2)). When the stiffness is of order one the medium can no longer carry spread-out colour flux: flux is squeezed into closed tubes and sheets, the confined vacuum is a gas of closed flux surfaces, and the lightest glueball is the smallest closed tube.

On the lattice at strong coupling the same picture is exact. Expanding each plaquette weight in characters and integrating the links, gauge-invariant correlation is carried only by closed surfaces of plaquettes, each fundamental plaquette costing u = I₂(β)/I₁(β).

**The mismatch this exposes in our own theorem.** Theorem 8.7 bounds influence along paths of links. Each step goes through one integrated cover link, at second order in β, and branches to 102 neighbours. The physics carries correlation only along surfaces. A path-based criterion pays the entropy of paths, about a hundred per step, where only the entropy of surfaces is owed. That is why 8.7's decay rate log(1/α)/2 sits near 0.2 at β = 0.2, where the physical rate is near −4 log u ≈ 12, and why its reach stops at 0.2452. The cell-decimation search of 16.47 (iii-38) confirms the path side is nearly exhausted: with cells of at most eight links, no design cuts the worst link's second-order load by more than 13 per cent, which is at most a factor 1.074 on the threshold.

## 2. The polymer representation and three lemmas

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

## 5. The theorem staked, and what it still needs

**Theorem S (staked).** SU(2) Wilson lattice gauge theory on ℤ⁴ at 0 < β ≤ β_S has exponential clustering of local gauge-invariant observables, uniformly over the tori of even side, and its transfer matrix has a mass gap. β_S is the KP reach of the full polymer gas.

What it needs, each to be done and posted:

- **(R1) The branched and higher-spin polymers.** Every closed polymer with a link of multiplicity three or more must be bounded. Lemma S3 makes every gluing along a forest an exact product, so the remaining pieces are gluings along cycles or plaquettes, and links of odd multiplicity carrying a spin of at least 1. The route: expand each link's Haar projector in the pairing (intertwiner) basis. This writes an all-½ branched polymer as a sum over resolutions into immersed branch-free surfaces, with Gram-inverse coefficients. The immersed surfaces are counted by the same closing tree, at most five branches per plaquette. Higher spins enter by strand resolution and are suppressed by a_j/u, which is about 0.09 at β = 0.55.
- **(R2) The enumeration certified on a second road** sharing no line with surf.c. The ask to iii-38: boundaries of 3-chains of cubes, deduplicated by canonical form.
- **(R3) The KP inequality evaluated with outward rounding**, the same discipline as Table 3.
- **(R4) The gap from KP.** Truncated correlations of local gauge-invariant observables are sums over clusters joining their supports; KP with a(Y) + κ|Y| gives decay at rate κ inside the reach. The transfer-matrix gap then follows by Theorem 7.1, as in 8.7.

**Stakes, written before the numbers they bet on exist:**
- **S1.** The ℤ⁴ counts at F = 20 and 22 keep the per-plaquette growth over successive fours in [2.15, 2.45].
- **S2.** The proved-tail reach with F₀ = 22 lies in [0.565, 0.62].
- **S3.** (R1) lowers the proved-tail reach by less than ten per cent: the smallest irreducible branched pieces have F ≥ 11, and gluings along forests are free.
- **S4.** The decay rate of Theorem S at β = 0.2 exceeds 8.7's by a factor above ten. Physically the rate is near −4 log u ≈ 12 there, while 8.7 gives below 0.25.

## 6. Where this leaves the crossing

The proved strong end is 0.2452. The ordered-datum flow measured at spins ≤ 2 (a reading, its datum share of the order of the effect) runs from the crossover 2.2 through 1.888, 1.553, 1.161, 0.662 and 0.109. If Theorem S lands near 0.57, that flow still needs five steps, because 0.662 lies above 0.57. If the measured ceiling near 1.07 is proved, it needs four. Every one of those steps is still a renormalisation step at moderate coupling, and no method in print or in this tree certifies one. The surface gas moves the strong end of the bridge. It does not cross it.

**Dimensional transmutation in this proof shape.** Every step of the bridge is a statement at its own coupling g_k. The number of steps from a bare coupling g to the strong end is K(g) = (4/g² − β_S)/0.2575 + O(log(1/g)), counted in doublings. So the physical gap is the strong end's gap times 2^{−K(g)}, which is proportional to exp(−(4 ln 2/0.2575)/g²) = exp(−10.77/g²) = exp(−8π²/(b₀g²)) with b₀ = 22/3. The exponential that perturbation theory cannot see is the step count, linear in 1/g². No Taylor series in g appears in it. This holds once each step is a certificate, which is exactly the part that is open.

## 7. Not claimed

No gap is claimed above β = 0.2452. The counts beyond F = 18 are not used. The ceiling near 1.0 rests on measured growth, not on a proof. Theorem S is staked, not proved.
