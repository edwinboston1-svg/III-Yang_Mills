
## 9. PRECISIONS, DATED (2026-11-02, after §§0–8 were written; nothing above edited)

9.1 THE INPUTS UNDER EVERY "PROVED" ABOVE. Lemma M takes V_k ∈ 𝒱(E₀C₁ε₁) from CMP 116's Lemmas 1–2, i.e. from Bałaban's §1, which
stands on the random-walk expansions of [13] (CMP 99) and the minimal configuration's derivative bounds of [15] Sect. G (CMP 102;
(189)–(190) are stated there with "We do not perform these calculations here", p. 308, the estimate M3R named runner-up), and on CMP
109 Theorem 3's inductive assumptions. So: Lemma M, Theorem BB4*, Lemma M_m are PROVED GIVEN CMP 116's Lemmas 1–2 (Bałaban's black
box, the same one M3 called (BB1)–(BB3)); Lemma W uses exactly the same inputs (it localizes 𝒲 by the operations §1 applies to
(1/g_k²)V(H₁B′)); Lemma FP uses only CMP 109 §0 and pp. 266–268 (READ) and CMP 102 Theorem 1. Nothing beyond Bałaban's own
inputs enters (BB4) any more.

9.2 CORRECTION TO §8 (PI-2): THE PURE 𝒲-CLUSTERS. In the two-family Bałaban expansion the cutoff is decomposed only off Y₀ ((2.3)), so a
cluster made of 𝒲-polymers alone still carries χ_{k,Y₀} and is not the cutoff-free Gaussian. The exact removal is done as in 7.3 (b1):
write φ(1; d) = φ(0; d) + [φ(1; d) − φ(0; d)]; expand φ(0; d) = log∫dμ_{C^{(k)}}χ_ke^{−d𝒲} with the cutoff decomposed on ALL bonds
(χ_k = Σ_P(−1)^{|P|}χ^c_{k,P}; legitimate because −d𝒲 is entire in B): its P = ∅ part is log∫dμ_{C^{(k)}}e^{−d𝒲} = −½n_T log(1 + d)
EXACTLY (Lemma FP), a c-number for every background, sent to the vacuum part V_K of (S₁)(ii); its P ≠ ∅ clusters carry
e^{−½γ₂(ε₁²/g_k²)|P|}. The bracket is Σ_X[E(X; 1, d) − E(X; 0, d)] from the two-family expansion, every term with a V-polymer, ∝ ε₁
(Lemma M). The localized representation of the output is the sum of the two families of localized terms. (PI-2) then holds as stated.

9.3 CORRECTION OF A BELIEF IN M3b §6.2 (d) ("β_{k+1}(x′) (own cutoff) and β^{(x)}_{k+1}(x′) (reference cutoff) differ by the shell between
the two cutoffs"). The cutoff of record is χ_k = Π_{b∈T^{(k)}∖{b₀(c)}}χ({|B′(b)| < ε₁}) on the PHYSICAL ANGLE B′ (CMP 109 (2.9), READ),
and B′ = B − hD̃(B) changes B′ only on the bonds b₀(c) (hB vanishes off {b₀(c)}, p. 267) — so the cutoff is coupling-independent and
is a function of B(b), b ∉ {b₀(c)}, alone (EVEN in B, which is what 7.3 (b2) uses). The two constructions at x′ differ ONLY in the
gauge-fixing weight (1/g_{x′}² versus 1/g_x² on G(B′)), which the exact transformation does not see ((0.15)–(0.16)); the shell is the
cutoff's non-invariance under R, a tail in the gauge-fixing directions of size e^{−c x ε₁²}, as 7.3 (d) states. (Bałaban's analytic
variant, cutoff (g_k/γ_k)ε₁, p. 266, is coupling-dependent; there M3b's sentence is the right one.)

9.4 A CHECK OF LEMMA FP AGAINST THE ONE-LOOP β (consistency, PROVED). Lemma FP says the reference construction at x + D reproduces, at
order g⁰, the reference β: β^{(x)}(x + D) − a(k + 1) = O(g²). The physical statement it must agree with: the k-step lattice β-function
at coupling x′ has the expansion a(k + 1) + b_{k+1}/x′ + O(x′^{−2}) with a coupling-INDEPENDENT one-loop coefficient a(k + 1) (M3 §5.3,
Lemma B). At x′ = x + D: a(k + 1) + b_{k+1}g_k²(1 + d)^{−1} + O(g⁴), whose d-dependence is −b_{k+1}g_k²d + O(g²d²) — O(g²), as 7.3 (b)
states, and ∂_xβ = −b g⁴ (M3b §6.2's sharp order). A background dependence of the one-loop d-term would contradict the coupling
independence of a(k + 1); FP is the exact form of that independence inside Bałaban's gauge-fixed, constrained integral.

## 10. CROSS-FIELD UNIFICATIONS FOUND

(U1) BAŁABAN'S §2 IS A BRYDGES–KENNEDY / BATTLE–FEDERBUSH THEOREM ABOUT A CONE. The Cauchy-in-τ device of (2.14) is the device of the
complex-interpolation cluster expansions (Brydges, Battle–Federbush; the "[26]" of p. 21): smallness of an activity = 1/(Cauchy radius),
radius = 1/(bound of the potential). Read that way, the theorem is about the cone 𝒱(ε) of potentials, not about one potential, and every
deformation of the theory that stays in the cone — a complex multiple (BB4*), a complex history ((PI)_H), a complex coupling deviation
(the D-term), a position-dependent coupling ((PI-1)) — is ONE application. This is the lattice-RG analogue of Kotecký–Preiss's statement
that the polymer expansion is analytic in any parameter on which the activities depend analytically within the KP domain.
(U2) LEMMA FP IS THE BRST/FADDEEV–POPOV GAUGE-PARAMETER INDEPENDENCE, MADE A DETERMINANT IDENTITY WITH NO GHOSTS. Changing the Wilson weight
alone equals changing the gauge-fixing weight (rescale), and (0.15)–(0.16) make the transformation independent of the latter; at one loop
this is the block-diagonality of c𝒲 + ½‖L·‖² on G ⊕ T, which needs only criticality and invariance (the Hessian of an invariant function
at a critical point kills the orbit — the Morse–Bott lemma used in the Duistermaat–Heckman / equivariant-localization arguments) and an
axial slice. The same block structure is why the off-shell effective action is gauge-dependent and the on-shell one is not (the
Kallosh–DeWitt theorem): Bałaban's construction is always ON-SHELL in the constrained sense, which is why his β-function is gauge
independent at the reference.
(U3) THE THREE ROLES OF ε₁, AND WHY ONLY ONE IS A CHOICE. RADIUS (where the fluctuation lives), FACTOR (how big the interaction is there),
and — in the moment form — g_k‖B‖ (how big it TYPICALLY is). The sup form ties the factor to the radius, which is why ρ ≤ C(ε₁² + g²)
does not vanish; the moment form unties them, ρ ≤ C(ε₁g + g²). This is the same separation as between a worst case and an average case
that the crossover's measure-weighted bound needs (MATH_BRIEF's converged missing step): here, inside Bałaban's own proof, the
average-case form is obtained by moving the Cauchy radius inside the integral — a pointwise-in-the-field contour, the device of the
quadratic-form moments (Glimm–Jaffe's "local" estimates).

## 11. THE LEDGER (this agent's rows)

| Item | Status | Where |
|---|---|---|
| CMP 116 pp. 1–22, every page, on image | READ | §0, §1 |
| where the interaction enters §2: (2.1), (2.14)–(2.15), (2.18)–(2.20) — only its modulus, at complex couplings τ(Y) | READ | §1.2 |
| every ε₁ classified RADIUS/FACTOR; one MIXED site (p. 19 "for simplicity"), cosmetic | READ | §1.3 |
| M3b's falsifier for BB4* | NOT MET in substance | §1.3 |
| Lemma M: §2 is a theorem about the cone 𝒱(ε); analytic in parameters | PROVED GIVEN CMP 116 Lemmas 1–2 | §2, §9.1 |
| Theorem BB4*: complex s on |s| < R₀ = ε₁^max/ε₁ (≥ 1 + δ, any size by Bałaban's order); (3.1) ∝ |s|ε₁; (3.2) ∝ ε₁²; s = 0 end | PROVED GIVEN the same | §3 |
| M3R's (a) M–∫ds interchange, (b) bound (iii), (d) s = 0 end | PROVED | §3 |
| moment form: Lemma M_m, ρ ≤ C(ε₁g_k + g_k²) + tails (a = 1) | PROVED GIVEN the B-dependent bounds READ at (1.20), (1.24), (1.40) | §4 |
| the D-term: 𝒲 is O(1), not O(ε₁); Lemma W (𝒲 ∈ 𝒱(C_W)) | PROVED GIVEN the inputs of CMP 116 §1 | §5 |
| Theorem BB4*-D: joint analyticity on |s| ≤ R₀/2, |d| ≤ θ_*; θ₀ := θ_* fixed | PROVED GIVEN Lemma W | §5.3 |
| Lemma FP: det ratio = (1 + d)^{n_T}, background-independent; M of the one-loop d-term = 0 | PROVED (CMP 109 §0, pp. 266–268 READ) | §6 |
| Lemma C (sup) | PROVED GIVEN (BB1)–(BB3), (BB5) | §7.1 |
| Lemma C (moment, a = 1) | PROVED GIVEN the same | §7.2 |
| Lemma C′ (a) analytic, (b) sup|β(x+D) − a| = O(g(ε₁ + g)), (c) ∂_xβ = O(g³), summable | PROVED GIVEN Lemma W, FP, (BB1)–(BB3), (BB5) | §7.3 |
| Lemma C′ (d) own vs reference construction | PROVED GIVEN the gauge-weight shell estimate (named) | §7.3, §9.3 |
| one-step (PI)_H | PROVED | §7.4 |
| Prop. E1-a | PROVED GIVEN (PI)_H^multi (named, falsifier) | §7.5 |
| frozen part of Σ₁; variation part of Σ₁ | PROVED GIVEN (PI-4); PROVED | §7.6 |
| (PI): (PI-1), (PI-2), (PI-3) | PROVED / PROVED GIVEN (PI-4) | §8, §9.2 |
| (PI-4) large field at complex Wilson coefficient; (PI-5) multi-step propagation | NAMED, each with its exact need and falsifier | §8 |
| M3b §6.2 (d)'s "two cutoffs" | CORRECTED: one cutoff, two gauge-fixing weights | §9.3 |

## 12. THE PRECISE NEXT OBJECT

(PI-4) at its first instance: CMP 119 §3's complete step and LFR I–II read line by line for every use of the Wilson coefficient on
large-field and complexified configurations, deciding for each whether the bound survives x ↦ x + D with |D| ≤ θ₀x, the test being the
relative bound |Im A(U)| ≤ C_A Re A(U) + η on LFR II's complexified large-field domain (falsifier: an additive bound on |Im A| independent of
Re A, multiplied there by θ₀x_k ~ θ₀/g_k²). Then (PI-5): CMP 119 (2.43)–(2.45) applied to the derivative in an earlier step's coupling
(the falsifier: a marginal remnant of an earlier step surviving its renormalization).
