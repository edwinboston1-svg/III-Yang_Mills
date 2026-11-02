
## 8. THE FORMAT FACTOR — WHY "POLYNOMIAL × ε₁" FAILS IN BAŁABAN'S FORMAT, AND WHAT IT COSTS (PROVED)

THEOREM F. (a) In Bałaban's printed derivation of Lemma 1, the terms of (1.23) with localization domain Y = Y₀ ∪ □₀ carry the factor
e^{+⅛κ₁d_k(□₀)} ((1.25), READ p. 7: "Adding and subtracting ⅛κ₁d_k(□₀) under the first exponential above"), with □₀ = □̃⁵ (READ, CMP 109
p. 273); converting (1.29) into (1.36) for every Y ⊃ □₀ requires
   C₂κ₁ ≥ 16κ₁ + (1/16)κ₁d_k(□̃⁵) + (1 − 2δ)κd_k(□̃⁵)   (the 16κ₁ is (1.24)'s e^{16κ₁}).                                    (8.1)
(b) For ANY localization of these terms — Bałaban's or Lemma RD's — a bound of the form (1.36), E₀ε₁C₁M^qK e^{−(1−2δ)κd_k(Y)} for all Y,
evaluated at Y = □₀ against the term's own bound there (no decoupled cube: (1.24) resp. (7.1) at n(Y∖□₀) = 0) forces
   K ≥ e^{(1−2δ)κ d_k(□̃⁵)} × (the page's polynomial constants, with (α₁/α₃)⁵ inside O(M^q) as p. 8 places it).            (8.2)
(c) d_k(□̃⁵) ≥ 914.0625 (Lemma MS).
PROOF. (a) From (1.25), (1.27), (1.28): (1.29) holds with exp O(1)κ₁ ⊇ exp(16κ₁ + ⅛κ₁d_k(□₀)) and decay e^{−(1/16)κ₁d_k(Y)}; for (1.36)
at Y with d_k(Y) = d ≥ d_k(□₀) =: d₀ one needs C₂κ₁ − (1−2δ)κd ≥ 16κ₁ + ⅛κ₁d₀ − (1/16)κ₁d, i.e. C₂κ₁ ≥ 16κ₁ + ⅛κ₁d₀ − ((1/16)κ₁ −
(1−2δ)κ)d, whose largest right side over d ≥ d₀ is at d = d₀ ((1/16)κ₁ ≥ (1−2δ)κ by p. 9): this is (8.1). (b) is (a)'s last step with
any constant in place of exp C₂κ₁. (c) is Lemma MS. ∎
THE MEANING. The relocalized history terms are born compact: their domain contains □̃⁵, 11⁴ M-cubes, whose linear size is ≥ 914.
Bałaban's format charges every polymer e^{−(1−2δ)κ·(linear size)}, which a compact object of size ε₁ cannot pay; the constant pays it.
This has nothing to do with complex decoupling: Bałaban pays it as ⅛κ₁d_k(□₀) ⊂ C₂κ₁ (so C₂ ≥ 16 + 914.0625/16 + (1−2δ)κ·914.0625/κ₁ ≥
115.64 at κ = 1, κ₁ = 20.068 — not 56, M6's (1.40) reading), Lemma RD pays it as (1−2δ)κ·914.0625. COMPUTED (run a, B2, B3).

## 9. THE BB4* INTERFACE — SETTLED: REAL DECOUPLING SUPPLIES EVERYTHING THE DOWNSTREAM NEEDS

THE TENSION, RESOLVED. "BB4* uses complex analyticity in s" refers to M3c's interaction multiplier s̄ (and the coupling deviation d),
not to CMP 116's decoupling parameters s(Δ). The two never meet: M3c §1.1 (READ there, and here on pp. 2–11): "THE INTERACTION COUPLING
DOES NOT ENTER §1: every operation there … acts on one term of the action at a time and is linear in that term". Lemma SD is linear in
the term too (F ↦ F_S is linear), so s̄V_k and −d𝒲 are localized by Lemma RD exactly as V_k and 𝒲 are, and the coupling parameters
stay complex.
WHAT EACH DOWNSTREAM PIECE NEEDS, AND WHO SUPPLIES IT:
| Piece (M3c) | Needs in the coupling variables | Needs from §1–§2 | Supplied by |
|---|---|---|---|
| Lemma M (§2) | potentials analytic in a parameter p ↦ activities analytic in p (part (d)) | (M-i) analyticity in (U, J, B), localization, gauge invariance; (M-ii) cone bounds | Lemma RD (iv) and (i)–(iii): the cone 𝒱(ε) with e^{C₂κ₁} → K_V, the volume factor e^{−½(κ₁−1)M⁻⁴|Y|} → the near-cluster structure with e^{−a_v|F|}; §2 is Lemma RD (iii) |
| Theorem BB4* | complex s̄, |s̄| < R₀; Schwarz (3.1), Cauchy (3.2) in s̄ | Lemma M | unchanged proof; R₀ := ε₁^max/ε₁ with ε₁^max recomputed from K_V |
| Lemma W | 𝒲 ∈ 𝒱(C_W) | decoupling of the quadratic form ½⟨H₁B′, Δ₁H₁B′⟩ | Lemma SD on a degree-2 functional: a FINITE series, C_W^{RD} = O(1)(R/B₀)²B₀²‖Δ₁‖ — κ₁-free (M3c needed C₂ ≥ 56 to absorb C_W's e^{O(κ₁)}) |
| Theorem BB4*-D | joint analyticity in (s̄, d) on |s̄| ≤ R₀/2, |d| ≤ θ_* | Lemma M, Lemma W | θ_* = ε_*/(2(C_W^{RD} + ε_*)), LARGER |
| Lemma M_m (moment form) | Cauchy in s̄ with pointwise radii | the B-dependent bounds (1.20), (1.24)'s g_k|B|, (1.40)'s |B′| | retained verbatim: (1.24)'s g_k|B| comes from the t_□-radius (7.3, a field-scaling Cauchy), (1.40)'s |B′| from the Cauchy formula in B′ (7.5) |
| Lemma C′ (a)–(c) | Cauchy in d on |d| ≤ θ₀ | BB4*-D, FP | unchanged |
| Lemma FP | none (a determinant identity) | CMP 109 §0, pp. 266–268 | unchanged |
DECISION, EXACTLY. Option (a): Lemma RD PRESERVES what BB4* needs. No real-variable replacement of BB4*'s Cauchy estimates is needed,
because those are Cauchy estimates in COUPLING parameters, which enter the interaction linearly, with radius = the inverse of a bound
and a linear cost; they never produced an e^{κ₁}-type factor. Every e^{C₂κ₁} in M3c's constants (c₂′, ε_*, ε₁^max, R₀, θ_*, C₅) came from
§1's bounds and is replaced by K_V. The status of BB4*, Lemma W, Lemma M_m, Lemma C′ is unchanged: PROVED GIVEN CMP 116's inputs.

## 10. THE LADDER, CERTIFIED WHERE COMPUTED

Three independent exponentials sit in CMP 116's bookkeeping, and only the first involves complex parameters:
 E1 = 2C₂κ₁ (Cauchy's price, M6) — DELETED by Lemma RD (PROVED GIVEN CMP 116's inputs).
 E2 = 2(1 − 2δ)κ·d_k(□̃⁵) ≥ 1706.25κ (L = 3) — the d_k-format charged on the relocalization base. Present in Bałaban's own chain (where it
   is ⅛κ₁d_k(□̃⁵) inside C₂κ₁) and in Lemma RD's. Removed only by changing the format (Lemma M_w below).
 E3 = the size of κ itself: the page needs δκ ≥ ln 91 (Lemma F), κ ≥ 10 ln 91/(1 − 2/L) ≥ 45.11; every e^{cκ} scales with it.
CERTIFIED (run a): M6's table with E1 deleted — bottleneck T18, 10^{111.09}. Lemma RD as proved, in Bałaban's format, at M6's κ = 1 —
bottleneck E2, 10^{747.26} (L = 3), 10^{641.40} (L → ∞). At the page's κ floor — 10^{100 870} (L = 3), ≥ 10^{28 850} for every L. Bałaban's
printed chain with E2 carried — 10^{2021.98} (κ = 1, L = 3; M6 had 10^{982.39}), 10^{65 525} at its own floor (L → ∞).

THE NEXT OBJECTS, IN ORDER:
(N1) LEMMA M_w — §2 AS A THEOREM WITH BASE-ADAPTED WEIGHTS. M3c's Lemma M with the uniform weight e^{(1−2δ)κd_k(Y)} replaced by a weight
   W(Y) that charges a relocalization base what its IMAGE costs at scale k + 1: W(Y) := exp((1−2δ)κ·min_{decompositions}[Σ_extras +
   Σ_bases (L/2)d_{k+1}(b/L)]). Axioms §2 uses: (W1) quasi-additivity over connected unions (the role of (2.27)); (W2) Σ_{Y∋□}W(Y)^{−δ} ≤
   O(1) (the role of (2.29)); (W3) 2·log W_k(Z) ≥ L·log W_{k+1}(Z′)·(1−2δ)⁻¹… (the role of (2.36)). FALSIFIER: (W3) for a single base,
   2·(L/2)d_{k+1}(□̃⁵/L) ≥ L d_{k+1}(□̃⁵/L) holds with equality — but the page's (2.36) with d_k itself FAILS for d̂-sized bases unless
   L ≥ 11 (then □̃⁵/L lies in a 2^d-block and d_{k+1} = 0). Expected residual at L = 3: e^{(1−2δ)κ·d_{k+1}(□̃⁵/3)} per base,
   d_{k+1}(□̃⁵/3) ≥ (4⁴ − 16)/16 = 15 (Lemma MS: a cube of side 11/3 meets ≥ 4⁴ cubes) — 28κ in log β instead of 1706κ.
(N2) LEMMA KP — ONE ENTROPY PAYMENT PER STEP. Replace the δ-shares of the polymer entropy (p. 9's (1.26) at δκ; (2.19); (2.29); (2.35);
   (2.37); (2.39)–(2.40)) by a single Kotecký–Preiss criterion per scale for the combined activities, so that κ need only exceed the
   entropy rate once: κ_min → ln 91/(1 − 2/L)·(share) instead of 10 ln 91/(1 − 2/L). FALSIFIER: a step that needs two entropy sums in
   sequence at the same scale with the second's activities defined only after the first is summed.
(N3) Then the large-field architecture binds: T18 (LFR II (1.9)) at 10^{111.09} (M = 27, L = 3), T17 at 10^{101.87} — M6's Lemma LF.

## 11. CROSS-FIELD IDENTIFICATIONS

(U1) THE DECOUPLING EXPANSION IS A MÖBIUS INVERSION. ∫_{[0,1]^S}∂^S F = Σ_{T⊆S}(−1)^{|S∖T|}F(1_T) is Möbius inversion on the Boolean lattice of
cube sets; for a functional that is an absolutely convergent series of products of walk monomials, the inverted term is exactly the sum
of the products whose union of supports is S. This is the "connected part" of Mayer/Ursell theory and the reason Brydges–Kennedy and
Abdesselam–Rivasseau forest formulas need no Cauchy radius: localization is bookkeeping of supports, and decay is a property of the
supports, paid by the walks. Bałaban already does this for log Z^{(k)} (p. 21: "κ replaced by δ₀M").
(U2) THE κ FLOOR IS A LATTICE-ANIMAL GROWTH CONSTANT, THE SAME OBJECT AS THE GROUND'S KOTECKÝ–PREISS RADIUS. δκ ≥ ln c₃ = ln 91 is the
entropy of d_k-polymers (connected unions of M-cubes) measured on the edge-line family; it plays for Bałaban's induction the role the
certified polymer count N_c(F) plays in THE GROUND's flux-surface gas (Theorem 8.9's KP certificate, aperanton_kp_cert.awk). The
ultraviolet half has never had its entropy constants computed; c₃ = 91 is the first, and it already moves the threshold by orders of
magnitude. A computed-constant UV renormalization group needs the GROUND's discipline: count the polymers, certify the KP sum.
(U3) THE BASE COST IS A UNIT ERROR. Linear size measures a polymer by the tree needed to touch it; a relocalized remainder is a compact
cube of 11⁴ M-cubes by birth, and the tree-length unit charges it like 914 separate excursions. The same mismatch appears whenever a
polymer norm built for SPARSE objects (paths of propagators) is applied to objects born COMPACT (large-field regions, coordinate
patches); the cure in both places is to measure compact objects in the coarser scale's units — LFR's R_k-cubes are Bałaban's own
instance of that cure, applied to large fields but not to relocalized remainders.

## 12. LEDGER (this agent's rows)

| Item | Status | Where |
|---|---|---|
| CMP 116 pp. 2–21, CMP 109 pp. 257, 273–276 on image | READ | §0, §2 |
| every κ₁-site of CMP 116 classified (decay / analyticity domain / positivity / coupling-type) | READ | §2 |
| Lemma SD (support decomposition = exact Möbius inversion; one term, one polymer) | PROVED | §3.1, §3.6 |
| Lemma C (locality of multilinear coefficients) | PROVED GIVEN p. 4 | §3.2 |
| Lemma G (decay per cube from the walks) | PROVED | §3.3 |
| Lemma MS: d_k(Y) ≥ (n(Y) − 16)/16; d_k(□̃⁵) ≥ 914.0625 | PROVED | §3.4 |
| Lemma F: #{X ∋ □′ : d ≤ t} ≥ 91^t; the page needs κ ≥ 10 ln 91/(1 − 2/L) | PROVED; c₃ COMPUTED | §3.5, §5 |
| LEMMA RD (i)–(v): CMP 116 §§1–2 with real decoupling; κ₁ eliminated; constants traced | PROVED GIVEN CMP 116's inputs | §§6–7 |
| M6's falsifier (fixed points off the real segment) | met only at the operator-ball radius e(1+η)², e^{2^d a}; NOT at e^{κ₁} | §7.3 |
| Theorem F: the format factor e^{(1−2δ)κd_k(□̃⁵)} survives any decoupling; Bałaban's C₂ ≥ 115.64, not 56 | PROVED | §8 |
| BB4* interface | SETTLED: preserved; no replacement needed | §9 |
| M6's table with C₂κ₁ removed: bottleneck T18, log₁₀ β_B ≥ 111.08510 | COMPUTED | §5 (A) |
| Lemma RD in Bałaban's format: bottleneck E2, log₁₀ β_B ≥ 747.26099 (κ = 1, L = 3) | COMPUTED | §5 (B) |
| the page's κ floor: log₁₀ β_B ≥ 28 850.44 (inf over L) after Lemma RD; Bałaban's chain ≥ 2021.98 (κ = 1), ≥ 65 525.66 (floor) | COMPUTED | §5 (B), (C) |
| Lemma M_w (base-adapted weights), Lemma KP (one entropy payment) | NAMED, each with its falsifier | §10 |
