# M6c — THE ULTRAVIOLET HALF'S CONSTANTS: LEMMA KP, LEMMA M_w, LEMMA LF, THE FORMAT, AND EXACT PRICING

Proof agent M6c, 2026-11-02. Work directory `.../scratchpad/math/M6c/`. Appended as the work proceeds; nothing above a line is
edited after it is written except by a dated correction below it. Labels: READ (on the rendered page, image read today), PROVED
(full proof here), PROVED GIVEN [named input], COMPUTED (exact or certified interval arithmetic, record named), FLOOR (a necessary
condition on the printed/derived inequalities, constants at their most favourable), OPEN (attempted; the obstruction named).
Normalisation as M6/M6b: Wilson's β = 1/g_Bał², β_B = 1/γ². "log" is natural; log₁₀ is written out.

## 0. Sources read in full before deriving

`math/MATH_BRIEF.md`; `math/M6/WORK.md` (§§0–12, all); `math/M6b/WORK.md` (§§0–17, all), `M6b/bin/m6b_thresholds{,_b}.py`, records
`M6b/rec/thresholds_run.2026-11-02{a,b}.txt` (copied to `bin/`). READ ON IMAGE TODAY: CMP 116 (1988) pp. 12–21 (M3c's renders
`M3c/render/cmp116_{12..21}.png`): the whole of §2 — (2.1) the Mayer expansion in t(Y), (2.3) the large-fluctuation bonds P, Z₀,
(2.5)–(2.8) conditioning and the s-decoupling on LM-cubes, (2.11)–(2.13) the polymer expansion, (2.14)–(2.15) the Cauchy bounds,
(2.18)–(2.41) the resummation with its ten δ-shares; CMP 109 p. 257 (M6b's render: □̃ⁿ is the cube of side (1+2n)M centred at the
centre of □; d_j(X) is the length of a shortest tree in the CONTINUOUS space, contained in X, meeting every cube of X, divided by M;
(0.25)–(0.26)) and p. 273 (□₀ = □̃⁵ "as in the condition (iv) in the definition of spaces U^c_j"; the fundamental case X ⊂ □̃²).

## 1. The plan (deep-think synthesis, before deriving)

DECISION. (a) Classify the ten δ-shares of CMP 116 §1–§2 by what each pays for — ENTROPY (a sum over polymers containing a point:
needs a rate above the polymer growth constant), VOLUME (a factor e^{c·n} absorbed by smallness of constants, polynomial cost),
CONNECTION (the +5 of (2.27)), RESCALING ((2.36)). Prove Lemma KP as the statement that, organised as one tree-graph expansion
in which every piece pays its own entropy from its own activity, only ONE entropy payment per scale survives, and prove the
matching FLOOR (the closure map forces κ(1 − 1/L) ≥ ln μ, μ the true growth constant of d-polymers, ≥ 91). (b) Prove Lemma M_w by
answering its falsifier (the volume terms at scale k that meet a base), and compute its residual EXACTLY for every L. (c) Price the
parameter M consistently (it was set to its most favourable value in the large-field rows while Lemma RD and CMP 116 force it
large; it returns as M^{2q}, q ≥ 8). (d) Lemma LF: prove what can be proved (its quantitative core), name the obstruction. (e) Item
3: decide by an exact count whether carrying the walks' VOLUME decay in the format lowers the entropy constant below 91.
WHY THIS OVER THE RUNNER-UP (a full re-proof of §2 line by line with new constants): the threshold is set by which exponentials
the FORMAT forces; the classification decides that, and each proved replacement is then a row of the engine.
WHAT MOVED THE PLAN (pre-mortem, after reading pp. 12–21): (i) Lemma F's 91 is a LOWER bound on the growth constant of
d-polymers, measured on straight lines only; diagonal trees are shorter (a 4D staircase advances four cubes per two units of tree
length), so the true constant may be far larger — for floors 91 stays valid, for sufficiency it does not, and the d-format's
entropy may be worse than recorded. (ii) (2.36) closes Z̃ (one more layer of M-cubes), and every position of □ in its L-block
occurs, so M6b's residual 15 at L = 3 must be recomputed. (iii) M6b's runs set every prefactor to 1, including M^{2q}, while
Lemma RD's (G) needs δ₀L₀ ≥ 32a: M is hundreds of δ₀⁻¹, a hidden term of tens of decades.
KILL-SWITCH: if the one-payment reorganisation needs, at some step of §2, two sums over independently varying polymers whose
second activities exist only after the first is summed (M6b's falsifier for KP), Lemma KP is stated only for the steps it covers.

## 2. THE TEN δ-SHARES OF CMP 116, CLASSIFIED BY WHAT THEY PAY FOR (READ pp. 7–21; δ = (1 − 2/L)/10, p. 21)

Kinds: ENTROPY = a sum over polymers containing a point (needs a rate above the growth constant of the polymers summed);
VOLUME = a factor e^{c·n} (n a number of cubes) absorbed by spending decay; CONNECTION = a per-piece cost from non-additivity of
d_k under unions; RESCALING = (2.36). Order of the page's resummation (p. 17, READ): "For a fixed Y₀ we sum over all D … Next,
we sum over Y₀, P determining a fixed Z₀. Further, for a fixed Z′₀, we sum over all possible Z₀ … Finally we sum over all
Z′₀ ⊂ Z" — four nested sums, then the polymer expansion (2.12)–(2.13), each re-extracting a δ-share from the union's decay.

| # | Site (READ) | What the share does | Kind | Under Lemma KP (§3) |
|---|---|---|---|---|
| 1 | p. 9, (1.26) at δκ | Σ_{X∋□′} over input history polymers X | ENTROPY (input) | the ONE payment a_E (pass-through species) |
| 2 | Lemma 1's second δ, (1.32), (1/16)κ₁ ≥ (1−2δ)κ | conversion of the decoupling decay into the κ-format; (1.28)'s count of □₀ ⊂ Y | VOLUME | walk-supplied rate; polynomial count (M6b S_□) |
| 3 | (2.18)–(2.20) | Σ_{Y∈D}α₄e^{−δκd_k(Y)} ≤ O(1)α₄M⁻⁴|Y₀| | VOLUME over D's members | per-member factor e^{α₄}: exp(Σ_{Y∈D}x_Y) = Π_{Y∈D}e^{x_Y}; no share |
| 4 | (2.28)–(2.29) | Σ_D Π α₆e^{−δκd_k(Y)} ≤ 1 | ENTROPY (pieces Y) | per-piece criterion (T), paid from each piece's own weight |
| 5 | (2.34)–(2.35) | Σ over Y₀ ⊂ Z₀ given Z₀ | VOLUME | void: (D, P) summed freely determine Z₀ |
| 6 | (2.36) + (1.28) at δκ | Σ over components Z_i with fixed Z′_i | ENTROPY (re-summed) | void: Z₀ is determined by (D, P); (2.36) kept as RESCALING |
| 7 | (2.37) + (2.29) at δ½Lκ | Σ over families {Z′_i}, ∪Z′_i = Z′₀ | ENTROPY (re-summed) | void (same reason) |
| 8 | (2.38) via (2.30) | exp O(1)α₅|Z| | VOLUME | per-piece factor under (LM)⁴α₅ ≤ c₅ (Bałaban's own assumption, p. 20) |
| 9 | (2.39) | the polymer expansion of the H(Z)-gas ([26]) | ENTROPY | the SAME criterion (T): Σ_{Z∋□}|H(Z)|e^{a(Z)} is computed through the decorations |
| 10 | (2.40)–(2.41) | exp (LM)⁻⁴|X| | VOLUME | polynomial n_{k+1}(X) ≤ 16(1 + d_{k+1}(X)) (Lemma MS), a vanishing share |
| — | (2.27) | Σ(d_k(Y) + 5) ≥ d_k(Y₀) + 5: e^{5κ} per piece in (2.28) | CONNECTION | √7 per junction (§3.3), at the union's rate κ_u = 2κ/L |
| — | (2.31)–(2.33) | (1/20)γ₂ε₁²/γ² ≥ 4κ | CONNECTION (cubes added by P) | t ≥ 2κ_u per cube, and the P-bond entropy t ≥ 2 ln(4M⁴) |

Of the ten shares, exactly ONE pays for something the RG step cannot get elsewhere: share #1 / #9 on the pass-through species
(the variations of input history polymers, which carry only the input decay κ). Shares #4, #6, #7, #9 sum the same pieces
again; #2, #3, #5, #8, #10 are volume absorptions. That is Lemma KP, proved in §3; the matching floor is §4.

## 3. LEMMA KP — ONE ENTROPY PAYMENT PER SCALE (PROVED; applied to CMP 116 PROVED GIVEN its inputs, as Lemma RD)

### 3.1 Lemma T (the attachment form of the Kotecký–Preiss bound) — PROVED

SETTING. 𝒫 a countable set of PIECES; each π ∈ 𝒫 has a support S(π), a finite face-connected set of cubes, and a weight
w(π) ∈ ℂ. S̄(π) := the cubes touching S(π) (sharing at least a point), n̄(π) := n(S̄(π)) ≤ 3⁴n(S(π)). Pieces are INCOMPATIBLE,
π ≁ π′, iff S(π′) ∩ S̄(π) ≠ ∅ (symmetric: some cube of π′ touches some cube of π).
LEMMA T. If for some c > 0 and every cube □
   (T)   Σ_{π: S(π)∋□} |w(π)| e^{c n̄(π)} ≤ c,
then, with a(π) := c·n̄(π):
 (i)  Σ_{π′≁π} |w(π′)| e^{a(π′)} ≤ a(π) for every π  (the Kotecký–Preiss hypothesis);
 (ii) [Kotecký–Preiss 1986, W = 0] the polymer gas of pieces has an absolutely convergent cluster expansion, and
      Σ_{clusters C ≁ π} |Φ^T(C)| ≤ a(π);
 (iii) for every π₀, the sum over finite families Γ of distinct pieces such that Γ ∪ {π₀} is connected in ≁ obeys
      F(π₀) := Σ_Γ Π_{π∈Γ}|w(π)| ≤ e^{a(π₀)} − 1.
PROOF. (i) π′ ≁ π gives a cube □ ∈ S̄(π) ∩ S(π′); so Σ_{π′≁π} ≤ Σ_{□∈S̄(π)} Σ_{π′: S(π′)∋□} |w(π′)|e^{cn̄(π′)} ≤ n̄(π)·c = a(π).
(iii) On a finite sub-collection of pieces, by induction on its size. Every connected family attached to π₀ is obtained (at least
once) by choosing a set {π₁, …, π_m} of distinct pieces incompatible with π₀ and, for each, a family attached to π_i in the
collection with π₀ removed (breadth-first decomposition from π₀; over-counting only enlarges the bound). Hence
1 + F(π₀) ≤ Π_{π≁π₀}(1 + |w(π)|(1 + F(π))) ≤ exp Σ_{π≁π₀}|w(π)|(1 + F(π)) ≤ exp Σ_{π≁π₀}|w(π)|e^{a(π)} ≤ e^{a(π₀)}, using the
induction hypothesis 1 + F(π) ≤ e^{a(π)} for the smaller collection and (i); the infinite case by monotone limits. ∎
COROLLARY T′ (decay passes to the union). If w(π) = ŵ(π)e^{−ρ(π)} with ρ ≥ 0, and ρ̂ is a function on supports with
ρ̂(∪_{π∈Γ}S(π)) ≤ Σ_{π∈Γ}(ρ(π) + j) for connected Γ (j a junction cost), then (iii) applied to ŵ e^{j} (assuming (T) for it)
gives Σ_{Γ∋π₀ connected} Π|w(π)| e^{ρ̂(∪S)} ≤ e^{a(π₀)} − 1. (Multiply each factor by e^{ρ(π)+j}.) ∎

### 3.2 Theorem KP (CMP 116 §§1–2 reorganised) — PROVED GIVEN CMP 116's inputs (the inputs of Lemma RD, M6b §6)

THE PIECES. Bałaban bounds every term of (2.14) by (2.26): a product over Y ∈ D of 2/|τ(Y)| (each Y a piece), over P of
e^{−½γ₂ε₁²|P|/g_k²} (each bond a piece), over the decoupled LM-cubes Z∖Z′₀ of their decay (Lemma RD: e^{−a_L} each), times
exp O(1)α₅|Z|. H(Z) is the sum of these terms over the decorations (D, P, Z₀, decoupled set) of support Z, so
|H(Z)| ≤ Σ_{decorations of Z} Π(per-piece factors)·exp O(1)α₅|Z|. Species: (W) walk pieces (V′_k, Q of Lemma RD (i)–(ii),
supports outside a base, per-cube walk decay a ≤ δ₀L₀/2^{d+2}); (H) pass-through pieces (the variation of an input history
polymer X: weight ≤ E₀(ε₁/α₂)·poly·e^{−κd_k(X)} × walk factors on the excursion; CMP 109 (3.17)); (B) based pieces (fundamental
case X ⊂ □̃², support ⊃ □₀ = □̃⁵); (P) large-fluctuation bonds; (L) decoupled LM-cubes.
THEOREM KP. Fix η > 0. Suppose
 (KP-H)  κ − a_E ≥ (2/L)(κ + η), where a_E is such that C_E := sup_□ Σ_{X∋□} e^{−a_E d_k(X) + c n̄(X)} < ∞;
 (KP-W)  every walk piece, decoupled LM-cube and P-bond carries d-rate κ_u := (2/L)(κ + η) on its own support, and its shape and
         attachment entropy is paid by its own walk decay / Gaussian tail (conditions (G) of Lemma RD, and t ≥ 2 ln(4M⁴));
 (KP-c)  criterion (T) holds for the combined species with c := ε₂^{1/2} (ε₂ the page's (2.28) quantity, κ₁-free);
 (KP-v)  (LM)⁴α₅ ≤ c₅ (p. 20).
Then the activities H(Z) and E^{(k+1)}(X) obey (2.38), (2.41) with exp(−(1 − 10δ)½Lκd_{k+1}) replaced by exp(−κd_{k+1}), the
ten δ-shares are not used, and the conditions on κ reduce to (KP-H):
   κ ≥ κ_KP := (a_E + 2η/L)/(1 − 2/L),  a_E > ln μ_d,                                                              (3.1)
μ_d := lim sup_t #{X ∋ □′ : d_k(X) ≤ t}^{1/t}, the growth constant of d-polymers.
PROOF. (a) Sum over decorations. By Corollary T′ applied to the per-piece factors (each piece's weight multiplied by
e^{κ_u d_k(S(π)) + √7κ_u}), with ρ̂ = κ_u d_k and the junction cost √7 (§3.3), |H(Z)|e^{κ_u d_k(Z)} is bounded by a sum over
connected families of pieces with union Z, and Σ_{Z∋□}|H(Z)|e^{κ_u d_k(Z) + c n̄(Z)} ≤ Σ_{connected families ∋ □} Π(…) ≤ e^{a} − 1
by Lemma T (iii); the volume factor exp O(1)α₅|Z| ≤ Π_π exp(O(1)α₅(LM)⁴n_{k+1}(S(π))) is a per-piece factor ≤ e^{c₅n(π)}, absorbed
into (T) (n ≤ 16(1 + d), Lemma MS, costs a vanishing share). This replaces shares #3–#8: no union is re-summed, because (D, P,
decoupled set) summed freely determine Z₀, Z′₀ and Z (p. 12: Z₀ is "the smallest localization domain containing Y₀ and P").
(b) Pass-through pieces. Their per-cube sum in (T) is ≤ E₀(ε₁/α₂)·poly·Σ_{X∋□} e^{−κd_k(X)}e^{(κ_u + η′)d_k(X)}e^{c n̄(X)}, finite
by (KP-H) since κ − κ_u ≥ a_E. (c) Based pieces: the X-sum is inside □̃² (n_j(□̃²) = 5⁴L^{4(k−j)} cubes at scale j, the L^{4(k−j)}
beaten by CMP 109 (3.17)'s e^{−½δ₀ML^{k−j}}), so it uses κ > ln μ_d, implied by (KP-H). (d) The polymer expansion (2.12)–(2.13)
of the H-gas: its KP hypothesis Σ_{Z∋□}|H(Z)|e^{a(Z)} ≤ a(□) is the bound of (a) (share #9 is the same payment as #4).
(e) Rescaling: a cluster X at scale k with closure X′ (the smallest D_{k+1}-domain ⊃ X̃) has d_k(X) ≥ (L/2)d_{k+1}(X′) ((2.36),
READ p. 19), so the cluster's weight e^{−κ_u d_k(X)} ≤ e^{−(κ+η)d_{k+1}(X′)}; pinning a cluster to X′ costs L⁴n_{k+1}(X′) cubes, the
n_{k+1} absorbed by e^{−ηd_{k+1}} (Lemma MS). Hence |E^{(k+1)}(X′)| ≤ L⁴·C·ε₂·e^{−κd_{k+1}(X′)}. ∎
WHAT THE THEOREM DOES NOT REMOVE. (2.36)'s factor ½ (the RESCALING gain stays L/2, not L) and the per-piece CONNECTION cost; both
stay, at rate κ_u, not κ. M6b's falsifier for KP ("two entropy sums in sequence at the same scale with the second's activities
defined only after the first is summed") is met by (a)–(d): the polymer expansion's activities H(Z) ARE defined only after the
decorations are summed, but its KP hypothesis is evaluated through the same decorations, so no second rate is spent.

### 3.3 The junction constant is √7, not 5 — PROVED
If Y, Y′ are face-connected localization domains with Y ∪ Y′ face-connected, they contain cubes Q ⊂ Y, Q′ ⊂ Y′ that coincide
or share a 3-face. Trees T ⊂ Y, T′ ⊂ Y′ meeting all their cubes meet Q, Q′ at points p, q; Q ∪ Q′ is a convex box of
diameter ≤ √(2² + 1 + 1 + 1) = √7, so the segment [p, q] ⊂ Y ∪ Y′ and d(Y ∪ Y′) ≤ d(Y) + d(Y′) + √7. For a connected family,
induct along a spanning tree of its adjacency graph: d(∪Y) ≤ Σ d(Y) + √7(|D| − 1). (The page's (2.27) uses 5.) ∎

## 4. THE FLOOR OF THE d-FORMAT AND THE TRUE SIZE OF ITS ENTROPY (PROVED; counts COMPUTED, record `rec/q4count.txt`)

### 4.1 Lemma F′ — the diagonal staircase: μ_d ≥ √11489 = 107.19… > 91 — PROVED
COUNT (COMPUTED, `bin/q4count.py`, exhaustive over 2¹⁶ subsets): the number of connected induced subgraphs of the 4-cube graph
Q₄ containing two antipodal vertices is N₂(Q₄, h = 4) = 11489 (by size: 24, 180, 726, 1764, 2696, 2708, 1928, 993, 364, 91, 14, 1
for sizes 5…16); containing one vertex: 20769; check: Q₃ gives 91 (Lemma F's c₃) and Q₂ gives 7 (M6b's c₂).
LEMMA F′. Units of M-cubes. Let p_m := p₀ + m(1,1,1,1), m = 0, …, t. The 16 cubes containing the lattice point p_m form a copy
Q₄(p_m) of Q₄ (two cubes adjacent iff they share a 3-face iff their indices differ in one coordinate). Q₄(p_m) ∩ Q₄(p_{m+1}) is the
single cube c_m with lower corner p_m, and Q₄(p_m) ∩ Q₄(p_{m′}) = ∅ for |m − m′| ≥ 2. For 0 < m < t let S_m ⊂ Q₄(p_m) be connected and
contain c_{m−1} and c_m (antipodal in Q₄(p_m)); X := ∪S_m. Then X is face-connected, the segment [p₀, p_t] ⊂ X (its open pieces lie
in the cubes c_m), it meets every cube of X (each contains some p_m), so d(X) ≤ 2t; and X determines every S_m = X ∩ Q₄(p_m).
Hence #{X ∋ □′ : d(X) ≤ 2t} ≥ 11489^{t−1} and μ_d ≥ 11489^{1/2} = 107.1867… ∎
(Lemma F's straight family gives 91 per unit length; the diagonal family pays 2 units of tree length per lattice point and gets
11489 > 91² = 8281 choices there. Turning paths give more; not needed.)

### 4.2 Theorem P — the pass-through floor — PROVED
STATEMENT. Suppose an RG step uses the input bound |E^{(k)}(X)| ≤ E₀e^{−κd_k(X)} uniformly in the shape of X, and must bound the
pass-through contributions (≥ θ·|E^{(k)}(X)| each, θ > 0 independent of X; CMP 109 (3.17)) localised on the closure, by the same
format at scale k + 1: Σ_{X: X′(X) = X′} θ E₀e^{−κd_k(X)} ≤ E₀′e^{−κd_{k+1}(X′)} with E₀′ independent of X′. Then
   κ(1 − 1/L) ≥ ln 91 (every L ≥ 3)   and   κ(1 − 1/L) ≥ ½ ln 11489 = 4.674146… (every L ≥ 4).                       (4.1)
PROOF. (Straight family.) Put Lemma F's edge line at x₂ = x₃ = x₄ = 1 (in M-units of scale k), so that the 8 cubes around each
unit edge lie in one L-block (block boundaries at multiples of L; 0 < 1 < L), and every unit edge lies in one block along x₁. All
91^t members X then have the same closure X′ (the blocks along the line), d_k(X) ≤ t, and d_{k+1}(X′) ≥ t/L − 2 (a tree touching
the first and last blocks is at least their distance long). The inequality forces 91^t θ e^{−κt} ≤ (E₀′/E₀)e^{−κ(t/L − 2)} for all
t, i.e. ln 91 ≤ κ(1 − 1/L). (Diagonal family.) Take p₀ = (1, 2, 3, 4) and L ≥ 4: the coordinates of p_m reach multiples of L at
distinct m, so at most one coordinate of p_m is ≡ 0 mod L. If none is, Q₄(p_m) lies in one block; if one is, Q₄(p_m) lies in two
blocks, both hit by the forced cubes c_{m−1}, c_m. So all 11489^{t−1} members have the same closure, d_k ≤ 2t,
d_{k+1}(X′) ≥ 2t/L − 4, and 11489^{t−1}θe^{−2κt} ≤ (E₀′/E₀)e^{−κ(2t/L − 4)} for all t gives ½ ln 11489 ≤ κ(1 − 1/L). ∎
(The closure here is of X; closing X̃ instead, as (2.36) does, adds at most one layer and changes neither count nor bound.)
CONSEQUENCE. In the d-format the pass-through species alone forces κ ≥ 4.674146/(1 − 1/L): 6.766 at L = 3 (straight family),
5.099 at L = 12, → 4.674 as L → ∞ — against M6b's Lemma-KP TARGET ln 91/(1 − 2/L) (13.53 at L = 3), which used the lower bound 91
as if it were μ_d and (2.36)'s L/2 as if it were the true gain. Sufficiency needs an UPPER bound on μ_d:

### 4.3 Lemma U — the d-format's entropy, bracketed — PROVED
107.18 ≤ μ_d ≤ (7⁷/6⁶)^{16} = 17.6513…^{16}, i.e. 4.674 ≤ ln μ_d ≤ 45.93.
PROOF. Lower: Lemma F′. Upper: if d(X) ≤ t then n(X) ≤ 16 + 16t (Lemma MS), and X is a face-connected set of cubes containing
□′; in a graph of maximal degree Δ (here 2d = 8) the connected vertex sets of size n containing a given vertex number at most
[(Δ−1)^{Δ−1}/(Δ−2)^{Δ−2}]^n (they inject into subtrees of the Δ-regular tree containing its root; classical); so
#{X: d ≤ t} ≤ Σ_{n ≤ 16+16t}(7⁷/6⁶)^n. ∎
THE GAP IS THE POINT. A certified d-format step needs a_E above ln μ_d, i.e. somewhere in [4.67, 45.93]; only 45.93 is
provable today. This is where exact pricing enters (§8).

## 5. LEMMA M_w — BASE-ADAPTED WEIGHTS, AND THEOREM B: THE RESIDUAL IS ZERO EXACTLY WHEN L ≥ 12

### 5.1 Lemma M_w — PROVED GIVEN CMP 116's inputs (with Theorem KP's organisation)
STATEMENT. In Theorem KP give each based piece π (support ⊃ □₀ = □̃⁵) the d-rate κ_u on S(π)∖□₀ only, and count □₀'s cubes in
its attachment volume n̄(π). Then (i) criterion (T) holds for based pieces at the cost of the polynomial factor 11⁴ (the bases
containing a given cube) and e^{c·13⁴} ≤ 2 (c = ε₂^{1/2}, once ε₂ ≤ (ln 2/13⁴)² = 5.9·10⁻¹⁰); (ii) every volume term of §2 that
meets a base is absorbed: (2.20) is void (per-member factor, §2 row 3); (2.25)–(2.26)/(2.38) give exp(O(1)α₅·11⁴M⁴) =
exp(O(1)α₅(LM)⁴(11/L)⁴), inside (KP-v) when L ≥ 11 and at the cost 4 ln(11/L) in ln α₄⁻¹, ln γ₂⁻¹ otherwise; (2.31)'s P-bonds in
a base region carry their own Gaussian; (2.34) is void; (iii) the OUTPUT charges a based piece only the linear size of its
IMAGE: d_{k+1}(X′) ≤ Σ_{based π}(R̄(L) + 2) + (2/L)(Σ excursion lengths + junctions), where R̄(L) is the largest d_{k+1} of the
closure of □̃⁶ over the positions of □ (the 2 joins the image's common point, sufficiency direction only); and an output polymer
equal to that closure must carry E₀e^{−κR(L)}, R(L) a lower bound on that linear size (floor direction).
PROOF. (i) and (ii) are the computations stated: a based piece's per-cube sum in (T) is ≤ 11⁴ × (its excursion shape sum, paid
by walk decay) × e^{c n̄}; the volume exponent O(1)α₅|Z| ≤ c₅(LM)⁻⁴|Z| ≤ c₅(n_{k+1}(Z) + (11/L)⁴) per base. (iii) The closure of
X̃ contains the closure B′ of □̃⁶ and the closures of the excursions and of the other pieces; a tree for X′ is: a shortest tree of
B′ (length ≤ R̄(L)), a segment of length ≤ 2 from the point where the scaled excursion tree meets B′ to that tree (every block of
B′ has diameter 2), and the scaled trees of the rest, which have length ≤ (2/L) × (their d_k + junctions) by (2.36). ∎
(M6b's falsifier, §13.1 there — "a step of §2 at scale k in which d_k(Z) must dominate a quantity proportional to the VOLUME of a
base and which cannot be deferred to scale k + 1" — does not occur: the only volume terms of §2 are (2.20), (2.25)/(2.38), (2.31),
(2.34), and each is answered in (ii) by smallness of α₄, α₅, γ₂ or by Theorem KP, never by d_k.)

### 5.2 Theorem B — the image of the base, exactly — PROVED
(2.36) closes Z̃ (READ p. 19: "Z′_i the smallest localization domain from D_{k+1} containing Z̃_i"); for a based piece Z̃ ⊇ □̃⁶,
the cube of side 13 M-cubes centred at the centre of a scale-k cube □ (CMP 109 p. 257). Along one axis, with □ at index i, □̃⁶
occupies the scale-k cells [i − 6, i + 6] and meets ⌊(i + 6)/L⌋ − ⌊(i − 6)/L⌋ + 1 blocks of scale k + 1; since every i occurs,
the worst count per axis is a(L) := 12/L + 1 if L | 12, ⌈12/L⌉ + 1 otherwise, and it occurs in all four axes at once.
THEOREM B. (a) a(L) ≤ 2 iff L ≥ 12; then the closure of □̃⁶ is at most 2⁴ blocks with a common point, so R̄(L) = R(L) = 0: THE
BASE COSTS NOTHING IN THE OUTPUT FORMAT. (Without the enlargement, for □̃⁵ itself: iff L ≥ 10.) (b) For L < 12 the closure is an
a(L)⁴ box and R(L) ≥ max{(a⁴ − 16)/16, P(a)}, where P(a) := max_{s≥2} m⁴(s − 1)/2, m = ⌊(a − 1)/s⌋ + 1: R(3) ≥ 40.5 (a = 5),
R(4) = R(5) ≥ 16 (a = 4), R(6..11) ≥ 8 (a = 3).
PROOF. (a) ⌊(i+6)/L⌋ − ⌊(i−6)/L⌋ ≤ ⌈12/L⌉, with equality for some i, and = 12/L for every i when L | 12; ≤ 1 iff 12/L ≤ 1. Two
blocks per axis form a 2×2×2×2 cluster whose blocks share the central point, and a one-point tree meets them all. (b) The MS
bound is Lemma MS (M6b §3.4). PACKING: if a tree meets N ≥ 2 closed cubes pairwise at distance ≥ s, pick a tree point p_i in
cube i; the balls B(p_i, s/2) are disjoint, and the tree, being connected and containing the other p_j (outside B(p_i, s/2)),
contains a path from p_i to ∂B(p_i, s/2) inside each ball: length ≥ Ns/2. In an a⁴ box the cubes with indices in
{0, s, 2s, …}⁴ ∩ [0, a − 1]⁴ (m⁴ of them) are pairwise at distance ≥ s − 1. ∎
CORRECTION TO M6b run b (b3)–(b4). M6b's residual 15 at L = 3 took the best-aligned position and no enlargement; the worst
position occurs and (2.36) encloses Z̃: the residual at L = 3 is ≥ 40.5, and it vanishes only at L ≥ 12 (M6b: L ≥ 11).

## 6. THE PARAMETER M, PRICED CONSISTENTLY (the hidden term)

M6 and M6b set every prefactor P = 2E₀C₁M^q/(α₄α₆) to 1 and evaluated the large-field rows at M = 27 … 1331, while Lemma RD and
CMP 116 force M large. FLOOR lower bounds on M (constants most favourable), each read on the page or proved:
 (M1) WALK DECAY PER CUBE. A walk piece needs decay a per decoupled M-cube with a ≥ κ_u + ln 4 (the d-rate the output needs,
      plus the shape entropy of the walk pieces: the directed chains of n cubes are 4ⁿ distinct supports). A walk of lattice
      length ℓ has decay e^{−δ₀ℓ} (CMP 116 (1.7)) and can meet 12 new M-cubes per √2·M of length (a segment along (1,1,0,0)
      through lattice points of the M-grid: the 16 cubes at each point, 4 shared with the next — COMPUTED by hand, §4 method);
      so δ₀M ≥ (12/√2)a = 8.485a. With δ₀ ≤ ½ (CMP 95 p. 38: 2δ₀ = min(δ₀′/3, M₀⁻¹), M₀ ≥ 1): M ≥ 16.97a.
 (M2) THE ERROR OF THE σ = 0 OPERATORS. (2.16)_RD (M6b §7.6) with M6b §16's correction carried to §2 (a near cluster of ≤ 2⁴
      decoupled LM-cubes enters once, at the cost e^{2κ} in the output's d_{k+1}): α₅ ≥ e·e^{2κ − δ₀M/3}, and (KP-v) with c₅ = 1:
      δ₀M/3 ≥ 1 + 2κ + 4 ln(LM), i.e. M/6 ≥ 1 + 2κ + 4 ln(LM).
 (M3) p. 21: δ₀M ≥ κ, i.e. M ≥ 2κ.
 (M4) Bałaban's chain M = L^m with M₁ < M₂ < M powers of L (CMP 109 p. 257, CMP 119 p. 245): M ≥ L³. Not forced by the
      reorganised step; evaluated separately as the CHAIN variant.
 PREFACTOR. (2.18) assumes q ≥ 8 (READ p. 16); so ln(1/ε₁) ⊇ 8 ln M and log β ⊇ 16 ln M.

## 7. LEMMA LF (M6) — THE CORE PROVED, THE OBSTRUCTION NAMED (OPEN)

7.1 STATEMENT (M6's, refined). Large fields localised at the PLAQUETTE scale: p is large iff |U_p − 1| ≥ ε(g) = g·A·(log g⁻²)^{1/2};
the large plaquettes form a polymer gas (adjacency through shared links), the small-field RG of §§3–6 runs on the complement with
the large plaquettes as holes, and the large-field rows T15–T18 are replaced by the per-plaquette condition below.
7.2 THE PER-PLAQUETTE PEIERLS CONDITION — PROVED. (a) For U ∈ SU(2) with eigenvalues e^{±iθ}: |U − 1| = 2|sin(θ/2)| and
1 − ½Re tr U = 1 − cos θ = 2 sin²(θ/2) = ½|U − 1|², EXACTLY. So a large plaquette carries e^{−(1/g²)(1 − ½Re tr U_p)} ≤
e^{−ε²/(2g²)} = (g²)^{A²/2}. (b) The normalisation against the small-field Gaussian is (−½d(g) log g⁻² + log σ₀) per site
(LFR II (1.10), d(g) = 3), and a plaquette has 4 sites: ≤ (g²)^{−6}σ₀^{−4} per large plaquette. (c) Two plaquettes are adjacent iff
they share a link: each of the 4 links lies in 2(d − 1) = 6 plaquettes, so the adjacency graph has maximal degree Δ = 20, and the
connected plaquette sets of size n containing a given plaquette number ≤ (19¹⁹/18¹⁸)ⁿ = 50.30ⁿ. (d) Hence the large-field gas
satisfies the Kotecký–Preiss criterion (a(γ) = |γ|) when (g²)^{A²/2 − 6}σ₀^{−4}·50.30·e ≤ 1, i.e.
   A² ≥ 12 + 2(ln(50.30 e) + 4 ln σ₀⁻¹)/log g⁻²  (the boundary constant C_bd of 7.3 to be added).                    (7.1)
(e) Consequence for T15. ε(g)² = A² log β/β: the threshold stays below the diameter 2 of SU(2) for β ≳ 9 and below a
small-field radius 0.3 for β ≳ 10³ (run c) — against T15's 10^{38.31} (p₀ = 10) in Bałaban's large-field function.
7.3 THE OBSTRUCTION (OPEN). CMP 102 Theorem 1 (READ by M6) constructs the minimizer on domains where |(∂V)(p′) − 1| < ε₁ ≤ a₁ for
EVERY plaquette; a large plaquette inside or next to such a domain breaks hypothesis (7). Bałaban separates large fields from the
small-field analysis by corridors of R_k ≥ (log g⁻²)^r M-cubes, r ≥ 2 (CMP 119 (2.5)), so that they are seen only through
e^{−R_k} (LFR II (1.6), M6's T19). THE NEXT OBJECT, LEMMA LF′ (the variational problem with holes): the minimizer on a domain with
excluded plaquettes exists, is unique, and the excluded set's influence on the background field and the propagators decays like
e^{−δ₀·dist}. With it, T19 needs only R ≥ ln(3B₃M₀A₀²p(g)²(100M)⁴) = O(ln ln g⁻² + ln M). FALSIFIER: a step of LFR I–II that uses
R_k ≥ (log g⁻²)^r for something other than beating e^{−R_k} — the ℝ-operation's N-window (M6 T20, N ≤ O((log g⁻²)^ν)) is the
first candidate to check.
7.4 THE POINCARÉ CONSTANT OF LFR II (1.8) — PROVED. In a cube of side ℓ with the complete axial (comb) gauge — B_d ≡ 0,
B_{d−1} = 0 on {x_d = 0}, …, B_1 = 0 on {x_2 = ⋯ = x_d = 0} — the linearised field obeys Σ_b|B(b)|² ≤ (d − 1)ℓ^d Σ_p|(∂B)(p)|²
(the page: d ℓ^{d+1}). PROOF. Integrating F_{νμ} = ∂_νB_μ − ∂_μB_ν along the comb, B_μ(x) is a sum of at most (d − μ)ℓ plaquette
variables F_{νμ}, ν > μ: F_{νμ}(x₁, …, x_{ν−1}, y_ν, 0, …, 0) for y_ν < x_ν, ν = μ+1, …, d. Cauchy–Schwarz gives
|B_μ(x)|² ≤ (d − μ)ℓ Σ_{its terms}|F|². A term F_{νμ}(…, y_ν, 0, …, 0) occurs in B_μ(x) only for x agreeing with it in the
coordinates < ν: at most ℓ^{d−ν+1} ≤ ℓ^{d−1} points x. So Σ_x|B_μ(x)|² ≤ (d − μ)ℓ·ℓ^{d−1}Σ_{ν>μ}Σ|F_{νμ}|², and summing over μ,
each plaquette counted once, Σ_b|B(b)|² ≤ (d − 1)ℓ^dΣ_p|F(p)|². ∎ So T18's (1.9) holds with γ₀/(2(d−1)ℓ^d) in place of
γ₀/(2dℓ^{d+1}), ℓ = 100M: one factor 100M·d/(d−1) gained (row T18c of run c).
7.5 WHAT REMAINS OF THE LARGE-FIELD ROWS EVEN WITH LF′. T17 and T18 carry M⁶ (LFR I (1.83): |V_Λ(b) − 1| < O(1)B₅M⁶ε_k) and
(100M)^d (the Poincaré constant in the 100M-cube): polynomial in M, from per-M-cube bookkeeping. With LF′ (p₀ → ½, R = O(ln ln))
and these factors kept, T18 becomes row T18_LF′ of run c. LF IN FULL (M6's statement: T15–T18 deleted) also needs the
large-field positivity per plaquette, without M⁶(100M)^d: OPEN, the same next object as §8.4 on the large-field side.

## 8. EXACT PRICING (ITEM 3) — THE ENTROPY CONSTANT FALLS BELOW 91; WHERE THE DECADES ACTUALLY ARE

8.1 THE QUESTION. Does pricing the UV polymer activities exactly (leading terms exact, remainder certified) lower the effective
entropy constant below c₃ = 91, and by how much? FIRST CORRECTION: 91 is not the d-format's entropy: μ_d ≥ 107.19 (Lemma F′), and
only μ_d ≤ e^{45.93} is provable (Lemma U). The d-format's bound E₀e^{−κd(X)} is uniform in shape and charges a fat polymer of n
cubes only e^{−κn/16}: that is the source of the fattening entropy (91 per unit length on lines, √11489 on diagonals).
8.2 THEOREM EP (the volume-priced format) — PROVED. The walk expansion prices each walk piece by its VOLUME: Lemma RD (via
Lemma G and Lemma SD (iii)) bounds the walk pieces by e^{−a n(S∖base)}, a ≤ δ₀L₀/2^{d+2}, before M6b converts them to the d-format.
In the two-component format |K(X)| ≤ E e^{−κ_d d(X) − a_v n(X)}:
 (a) Σ_{X∋□}e^{−a_v n(X)} ≤ Σ_n (17.6513 e^{−a_v})ⁿ < ∞ for EVERY κ_d ≥ 0 once a_v > ln(7⁷/6⁶) = 2.8708 (the bound of Lemma U on
     connected cube sets): the certified entropy constant drops from e^{45.93} (d-format) to 17.65, and it is paid by a_v — the
     walk decay, i.e. by M — not by κ;
 (b) the fattening generating function of Lemma F's straight family is, per unit length, x·c₃(x) with
     c₃(x) = 1 + 3x + 9x² + 19x³ + 30x⁴ + 21x⁵ + 7x⁶ + x⁷, x = e^{−a_v} (the counts of `rec/q4count.txt`, Q₃ by size): c₃(e^{−3}) =
     1.174, c₃(e^{−1.5}) = 2.416, against c₃(1) = 91; for the diagonal family Σ_k N₂(h=4)_k x^{k−1} = 24x⁴ + 180x⁵ + … (four new cubes
     at least per lattice point).
PROOF. (a) is Lemma U's tree bound. (b) Each member is a choice of a connected S_i ∋ v₀ per unit edge, of weight x^{|S_i|}. ∎
8.3 WHAT IT BUYS. After Theorem KP and Theorem B (L ≥ 12) κ enters the threshold only through κ_u = 2κ/L (S1) and (M2): run c
measures the floor's κ-dependence at L = 12 (stake below: ≤ 5 decades). So the volume pricing moves the FLOOR little; it moves the
CERTIFIABLE side: a d-format step must take a_E above the provable 45.93, i.e. κ ≥ 55.1 at L = 12, M ≥ ~890 by (M2), plus the base
junction 2κ of Lemma M_w (iii); the volume-priced step pays a_v ≥ ln(2·17.65) by M and keeps κ small — PROVIDED the base images
are exempt from the output's volume count (an image of ≤ 16 blocks would otherwise cost 16a_v,out per based piece, which gives
the gain back). Run c prints both profiles (existential constants at 1; NOT a sufficiency proof).
8.4 LEMMA PS — EXACT PRICING OF THE QUADRATIC FORM PER BOND PAIR (PROVED GIVEN the pointwise walk bound of H₁, CMP 95 (1.110) /
CMP 116 (1.7), and the plaquette-local form of V_□, CMP 116 (1.37)–(1.39)). CMP 116 (1.43) bounds Q(Y, B, b, b′) by C₃ε₁M⁴ (Cauchy
in B′ on the whole M-cube sum V_□), and (2.18)–(2.19) must then normalise each bond pair by M⁻⁴ more: q ≥ 8 (READ p. 16:
|τ||Q| ≤ α₄C₃M⁴/(E₀C₁M^q) ≤ α₄M⁻⁴ iff q ≥ 8). Priced per plaquette:
   Q(b, b′) = Σ_p Σ_{x,y∈p} ∂²v_p/∂A(x)∂A(y) · H₁(x, b) H₁(y, b′),  |∂²v_p| ≤ C_vε₁,  |H₁(x, b)| ≤ B₀e^{−δ₀|x−b|},
so |Q(b, b′)| ≤ C_vε₁B₀² Σ_p e^{−δ₀(|p−b| + |p−b′|)} ≤ C_vε₁B₀²N(δ₀)e^{−δ₀|b−b′|/2}, N(δ₀) := sup_b Σ_p e^{−δ₀|p−b|/2}, and
Σ_{b′}|Q(b, b′)| ≤ C_vε₁B₀²N(δ₀)²: M-INDEPENDENT (triangle inequality |p−b| + |p−b′| ≥ |b−b′|, half of the decay kept for the sum).
The τ-radius of (2.18) for the quadratic part becomes α₄/(C_vε₁B₀²N(δ₀)²): the M⁸ is replaced by B₀²N(δ₀)², N ≥ 5 (the 6
plaquettes through b at distance ≤ ½). The history part of V_k keeps Lemma 1's O(M^{q₁}) ((1.29): "(α₁/α₃)⁵ inside O(M^q)" as
p. 8 places it): pricing it per site needs CMP 109 §3's constants — OPEN; the floor below sets q₁ = 0 (labelled).
8.5 THE ANSWER TO ITEM 3. Yes: priced by volume, the fattening constant is 1.17 (a_v = 3), not 91, and the certified entropy
constant is 17.65, not e^{45.93}; but in the reorganised scheme at L ≥ 12 the entropy is not where the exponent lives. The exponent
lives in PREFACTORS POLYNOMIAL IN M; exact pricing pays there: Lemma PS removes M^{16} from the small-field row.

## 9. THE ROWS OF RUN c (definitions; X = log β, constants most favourable — FLOORS)

For L = 3 … 40: κ = κ_fl(L) := ½ ln 11489/(1 − 1/L) for L ≥ 4, ln 91/(1 − 1/L) at L = 3 (Theorem P); κ_u = 2κ/L; R = R(L)
(Theorem B); a = κ_u + ln 4; M = M_free := ⌈max(16.97a + 2, 2κ, M_α)⌉, M_α the least integer with M/6 ≥ 1 + 2κ + 4 ln(LM) (§6);
M_chain := the least power of L ≥ max(M_free, L³).
 S1 = √7κ_u + q ln M + ln 2  [(2.28): Cauchy 2/|τ|, junction √7 at κ_u]
 S2 = 4 ln L + q ln M + κR    [the closure row: pinning L⁴, the base residual; Bałaban's O(1)C₃ε₁ ≤ ½E₀ with E₀ cancelling]
 S3 = ln max(2 ln(4M⁴), 2κ_u) [(2.31): P-bond entropy, 4M⁴ bonds per M-cube; cube cost]
 X_small = 2 max(S1, S2) + S3, q = 8.
 T15 (CMP 119 (2.4), p₀ = 10, A₀ = 1): −X/2 + 10 ln X − ln 2 = 0;  T17(M) (M6): −X/2 + 12 ln X + ln 1.5 + 4 ln(100M) + 6 ln M = 0;
 T18(M) (LFR II (1.9)): −X/2 + 12 ln X + ln 8 + 6 ln M + 5 ln(100M) = 0;  T18c(M) (§7.4): ln 8 + 5 ln(100M) → ln 6 + 4 ln(100M);
 T18_LF′(M): −X/2 + ½ ln X + ln(A R) + ln 6 + 6 ln M + 4 ln(100M) = 0 with A² = 12 + 9.836/X (7.1, σ₀ = 1), R = ln(3·A²X·(100M)⁴);
 T15_LF(r₀): A²X/e^X = r₀² (r₀ = 2, 0.3).
VARIANTS. B (PROVED / PROVED GIVEN: RD, KP, M_w, Theorems B and P, √7, T18c, consistent M): max(X_small, T15, T17, T18c).
C′ (+ LF′, OPEN): max(X_small, T15_LF(2), T18_LF′). C (+ LF in full, OPEN): max(X_small, T15_LF(2)). D (+ PS, q₁ = 0 OPEN): C
with q ln M → 2 ln 5 in S1, S2. Each at M_free and at M_chain; the optimum over L printed.

## 10. STAKES FOR RUN c (written before `bin/m6c_thresholds.py` exists; nothing here edited after)

c1 (my copy of M6b's engine): κ_KP(3) = 13.53258, e^{5κ} row 61.80571, E2 + e^{5κ} 226.36519, T18(1331) 151.56570, T17(1331) 138.95814.
c2 Theorem B: a(L), R(L) = (5, 40.5) at L = 3; (4, 16) at 4, 5; (3, 8) at 6–11; (2, 0) at L ≥ 12; for □̃⁵: zero iff L ≥ 10.
c3 κ_fl: 6.7663 (L = 3), 6.2322 (4), 5.0991 (12), 4.9202 (20), → 4.6741.
c4 L = 12, M_free = 261: X_small = 48.97 decades (S2 = 54.456 binds over S1 = 47.457; S3 = 3.856); T17 = 123.6, T18c = 124.9,
   T18 = 134.8, T15 = 38.31.
c5 Variant B optimum: L = 6 (M = 249), binding T18c ≈ 124.46 decades (± 0.1); X_small there ≈ 84.9; L = 5 is X_small-bound ≈ 126.8.
c6 Variant C′ optimum ≈ 72.6 decades at L = 12 (T18_LF′ binds; X_small 49.0).
c7 Variant C optimum: 48.97 decades at L = 12 (M_free); M_chain = 1728 there: 62.2.
c8 Variant D: 13.1 decades at L = 12 (S2 = 4 ln 12 + 2 ln 5 = 13.16; S3 = 3.86).
c9 LF core: T15_LF(2): β ≈ 9 (0.96 decades); T15_LF(0.3): β ≈ 1035 (3.02 decades).
c10 c₃(e^{−1.5}) = 2.4155, c₃(e^{−3}) = 1.1742; μ_d ∈ [107.187, e^{45.93}].
c11 κ-dependence of the floor at L = 12 (C, κ → 0 with M re-solved): ≈ 4 decades.
c12 Entropy-constant profiles at L = 12 (existential constants at 1; S1/S2 with the base junction 2κ in the d-format): d-format
   with a_E = 45.93: ≈ 150 decades (κ = 55.1, the junction 2κ = 110 dominating S2); volume-priced with a_v = 3.56, a_v,out = 1.51,
   base images exempt: ≈ 50.6 decades; not exempt (+16a_v,out in S2): ≈ 71.6.

## 11. RESULTS OF RUN c (record `rec/thresholds_run.2026-11-02c.txt`, rc = 0, 9 s; §10 unedited)

c1 HELD: my copy of M6b's run b reproduces κ_KP(3) = 13.53258, 226.36519, T18(1331) = 151.56570 (`rec/m6b_b_rerun.2026-11-02c.txt`).
c2 HELD: Theorem B's table exactly as staked (a, R) = (5, 40.5) at L = 3; (4, 16) at L = 4, 5; (3, 8) at L = 6–11; (2, 0) at L ≥ 12;
   □̃⁵ alone: zero from L = 10 (packing beats Minkowski–Steiner at a = 3, 4, 5).
c3 HELD TO THREE DIGITS, THE FOURTH REFUTED: κ_fl = 6.76629 (L = 3), 6.23276 (4), 5.09953 (12), 4.92060 (20), → 4.67457. The stake's
   6.2322 / 5.0991 / 4.6741 used my hand value ½ ln 11489 = 4.674146, which is WRONG: ln 11489 = 9.349145, half 4.674573 (COMPUTED).
c4 HELD: L = 12, M_free = 261 (= M_α; 12√2a = 37.95, 2κ = 10.20): S1 = 47.45799, S2 = 54.45579 (binds), S3 = 3.85627;
   X_small = 48.97446 decades; T17 = 123.58538, T18c = 124.89977, T18 = 134.77616, T15 = 38.30806.
c5 HELD (with c3's caveat): variant B optimum L = 6, M = 249, binding T18c = 124.45365 decades; X_small there 85.214 (staked 84.9 —
   my hand S2 slipped by 0.3 decade); L = 5 X_small-bound at 126.751 (staked 126.8).
c6 HELD: C′ = 72.58066 at L = 12 (T18_LF′ binds). c7 HELD: C = 48.97446 at L = 12 (M_chain: 62.22940). c8 HELD: D = 13.10410 at L = 12.
c9 HELD: T15_LF(2) → β = 9.0759 (0.95789 decades); T15_LF(0.3) → β = 1034.90 (3.01490).
c10 HELD: c₃(e^{−1.5}) = 2.41541, c₃(e^{−3}) = 1.17421, c₃(e^{−4.466}) = 1.03570; μ_d ∈ [107.18675, e^{45.93303}].
c11 REFUTED AS STAKED: the κ-dependence of the floor at L = 12 is 2.1566 decades (κ → 0⁺ gives M = 192, X_small = 46.818), not ≈ 4: the
   stake added κ's share in S1, but S2 binds and κ enters S2 only through M (16 ln(261/192) = 4.91 nats).
c12 HELD: d-format profile 153.341 decades (κ = 55.12, M = 891, S2 = 174.52 with the base junction 2κ = 110.2); volume-priced, base
   images exempt: 50.557; not exempt: 71.575.

## 12. DATED CORRECTION (2026-11-02, after run c; nothing above edited)

12.1 THE VALUE ½ ln 11489 in §4.2 (Theorem P), §4.3 (Lemma U: "4.674"), §9 and §10 is 4.674573, not 4.674146 (§11 c3). μ_d ≥ √11489 =
107.1868 (Lemma F′) was right; only the logarithm was mistyped. Every computed number uses the correct value.
12.2 THEOREM P AND (2.36)'s ENCLOSURE. (2.36) localises the output on the closure of Z̃ (one more layer of M-cubes), and the
proof of Theorem P fixed the closure of X. With the enlargement the closure must be shown independent of the member:
 (a) STRAIGHT FAMILY, L ≥ 4: put the edge line at x₂ = x₃ = x₄ = 2. The 8 cubes around each unit edge have indices in {1, 2}³ in
     those coordinates, X̃ ⊂ indices {0, …, 3}, and [0, 4] lies in one block when L ≥ 4; along x₁ every member contains the forced
     cube of each edge, so X̃ spans the same interval. The closure of X̃ is member-independent: κ(1 − 1/L) ≥ ln 91 holds for L ≥ 4.
 (b) DIAGONAL FAMILY, L ≥ 12: take p₀ = (1, 4, 7, 10). Coordinate i of p_m is within distance 1 of a multiple of L only for m in a
     window of three consecutive residues, and the four windows ({−2,−1,0}, {−5,−4,−3}, {−8,−7,−6}, {−11,−10,−9} mod L) are disjoint
     iff L ≥ 12. Outside its window a coordinate keeps [p_m − 2, p_m + 2] (the reach of X̃) inside one block; inside, the forced
     cubes c_{m−1} (indices p_m − 1) and c_m (indices p_m) already reach both neighbouring blocks in that coordinate through their
     touching neighbours. So the closure of X̃ is member-independent and κ(1 − 1/L) ≥ ½ ln 11489 holds for L ≥ 12.
 (c) L = 3: force both antipodal cubes around each edge (indices {1}³ and {2}³ in coordinates 2–4); the count per edge is then
     N₂(Q₃, h = 3) = 46 (`rec/q4count.txt`), and κ(1 − 1/3) ≥ ln 46.
 For 4 ≤ L ≤ 11 the diagonal family's closure of X̃ can depend on the member (windows overlap; the mixed corner blocks are reached
 only through S_m), so run c's κ_fl at those L is not established; run d replaces it by (a). The optima at L = 12 (variants C′, C,
 D) are unaffected; variant B's optimum moves.
12.3 STAKES FOR RUN d (`bin/m6c_thresholds_d.py` = run c with κ_fl(L) := ½ ln 11489/(1 − 1/L) for L ≥ 12, ln 91/(1 − 1/L) for
4 ≤ L ≤ 11, ln 46/(2/3) at L = 3; written before the run):
 d1 κ_fl = 5.7432 (L = 3), 6.0145 (4), 5.6386 (5), 5.4130 (6), 5.0995 (12, unchanged).
 d2 variant B optimum: L = 5, M = 245, binding T18c ≈ 124.33 decades, X_small there ≈ 123.86 (close behind); L = 6: M = 247, 124.377.
 d3 C′, C, D optima unchanged at L = 12: 72.58066, 48.97446, 13.10410.

## 13. RESULTS OF RUN d (record `rec/thresholds_run.2026-11-02d.txt`, rc = 0; §12.3 unedited)

d1 HELD: κ_fl = 5.74296 (L = 3), 6.01448 (4), 5.63857 (5), 5.41303 (6), 5.09953 (12).
d2 HELD: variant B optimum at L = 5, M = 245: binding T18c = 124.30010 decades (staked ≈ 124.33), X_small = 123.85 just behind
   (staked 123.86); L = 6: M = 247, 124.377 (as staked).
d3 HELD: C′ = 72.58066, C = 48.97446, D = 13.10410, all at L = 12, M = 261. (M_chain: B 127.49 at L = 7, C 62.23, D 13.22.)
Run c's sweep at L ≥ 12 is unchanged by the correction (same κ_fl there); its rows at 4 ≤ L ≤ 11 are superseded by run d's.

## 14. THE DOMINANT FORMAT CHOICES — WHAT SETS THE EXPONENT, IN DECADES OF log₁₀ β (all FLOORS, records named)

| Design choice (where it is made) | What it costs | Lemma that removes it | Status | Floor after |
|---|---|---|---|---|
| complex decoupling radius e^{κ₁} (CMP 116 §1) | 2C₂κ₁ ≥ 2248 nats | Lemma RD (M6b) | PROVED GIVEN | 747.26 (Bałaban format, κ = 1), 28 850 (page's κ) |
| ten δ-shares, each paying ln c (p. 9, pp. 17–21) | κ ≥ 10 ln 91/(1 − 2/L) ≥ 45.11 | Lemma KP + Theorem P | PROVED GIVEN / PROVED | κ_fl = 5.10 at L = 12 |
| base □̃⁵ charged by its linear size 914 (CMP 109 p. 273 + (1.36)) | 2(1 − 2δ)κ·914 nats | Lemma M_w | PROVED GIVEN | residual κR(L) |
| block factor L against the base's enclosure □̃⁶ ((2.36)) | κR(L), R(3) ≥ 40.5, R(6..11) ≥ 8 | Theorem B: L ≥ 12 | PROVED | X_small 245 (L = 3) → 49 (L = 12) |
| M forced to ≈ 250 by δ₀ ≤ ½ (CMP 95) and (2.16)'s e^{−δ₀M/3}(LM)⁴ ≤ 1 | enters every row polynomially | — | READ / PROVED (§6) | — |
| large-field corridors R_k ≥ (log g⁻²)², threshold p₀ ≥ 10 (CMP 119 (2.4)–(2.5)) | 59.0 decades of T18c (its 12 ln X) | Lemma LF′ (holes) | OPEN (core 7.2 PROVED) | 124.30 → 72.58 |
| large-field positivity per M-cube: M⁶ (LFR I (1.83)), (100M)⁴ (Poincaré, (1.8)) | 28.8 + 35.2 decades of T18c; 64.3 of T18_LF′ | LF in full (per-plaquette positivity) | OPEN | 72.58 → 48.97 |
| (100M)^{d+1} in LFR II (1.8) | one factor 100M·4/3 | comb-gauge Poincaré (§7.4) | PROVED | T18 → T18c (−9.9 decades) |
| per-M-cube sup norms on the quadratic form: M^{2q}, q ≥ 8 ((1.43), (2.18)) | 38.7 decades of the 48.97 | Lemma PS (per bond pair) | PROVED GIVEN (quadratic part); history q₁ OPEN | 48.97 → 13.10 |
| junction 5 in (2.27) | e^{5κ} per piece | √7, at κ_u = 2κ/L | PROVED | S1 below S2 |
| pinning L⁴ (p. 20's (L+2)⁴), forced by L ≥ 12 | 8.6 decades of the 13.10 | a smaller base (b layers ⇒ L ≥ 2b + 2) | OPEN (CMP 109's condition (iv)) | — |
| P-bond entropy, 4M⁴ bonds per M-cube ((2.31)) | 1.7 decades | — | — | — |

THE ANSWER TO "WHICH CHOICES SET THE REMAINING EXPONENT". After Lemmas RD, KP, M_w and Theorem B, NO exponential in κ survives
(the κ-dependence of the small-field floor at L = 12 is 2.16 decades, run c c11). What remains is (i) the large-field
architecture — polylog powers from R_k ≥ (log g⁻²)² and p₀ ≥ 10, and polynomials in M from per-M-cube positivity — and (ii) the
small-field prefactor M^{2q}. Both are POLYNOMIAL IN M, and M ≈ 250 is forced by the walk decay rate δ₀ ≤ ½ against the per-cube
decay the format needs and by (2.16)'s (LM)⁴. The output format that moves the exponent by orders of magnitude is the one that
prices everything PER BOND / PER PLAQUETTE instead of per M-cube: proved for the quadratic form (Lemma PS: −35.9 decades), open for
the history terms and the large-field positivity. The other candidate formats the assignment named: (a) smaller relocalization
bases — worth ≈ 4 decades at the end (L⁴ pinning) once everything else is done, and decisive before (Theorem B); (b) the exact
leading-order effective action with only the remainder bounded — this IS Lemma PS's mechanism (the leading quadratic term priced
exactly per bond pair); (c) one- and two-loop terms carried exactly — they enter E^{(k)} as O(1) normalisations already extracted by
Bałaban (log Z^{(k)}, p. 21, with κ replaced by δ₀M), so they move no row of this table.

## 15. THE BEST CERTIFIED THRESHOLD, THE GAP, AND THE NEXT OBJECT

15.1 BEST CERTIFIED FLOOR (every lemma used PROVED or PROVED GIVEN CMP 116's inputs; certified interval arithmetic, run d):
   log₁₀ β_B ≥ 124.30010   (L = 5, M = 245; binding row T18c = LFR II (1.9) with the comb-gauge Poincaré constant; the small-field
   row X_small = 123.85 just behind).
This is the floor of the REORGANISED scheme (Lemmas RD, KP, M_w; Theorems B, P; √7; M priced consistently; Bałaban's large-field
architecture unchanged). It replaces M6b's 747.26 (Bałaban's format with RD, κ = 1, M unpriced) and 28 850.44 (the same at the page's
κ). It is a NECESSARY condition: the scheme, with constants at their most favourable values, cannot close below it. No sufficient
threshold exists in the record: the constants of CMP 95/99/102/109 (B₀, M₀, δ₀, E₀, C₁, α₀…α₆, γ₂, a₀, a₁, B₃, B₅) are untracked.
CONDITIONAL LADDER (each step a named lemma): + LF′ → 72.58066; + LF in full → 48.97446; + PS with q₁ = 0 → 13.10410 (L = 12, M = 261).
15.2 WHAT THE GAP TO β ≈ 5 IS MADE OF (log₁₀ 5 = 0.70). At the proved optimum the two row families meet near 124 decades:
 large-field: 59.0 (polylog: R_k ≥ (log g⁻²)², p₀ ≥ 10) + 28.8 (M⁶) + 35.2 ((100M)⁴ Poincaré) + 1.6;
 small-field at L = 5: 78.3 (base residual κR, R = 16) + 38.2 (M^{16}) + 5.6 (L⁴) + 1.7 (P-bonds); at L = 12 the base residual is 0 and
 the small-field row is 49.0 = 38.7 (M^{16}) + 8.6 (L⁴) + 1.7.
After every named lemma, 13.10 decades remain: 8.6 (pinning L⁴, forced by the base side 13 through Theorem B), 2.8 (N(δ₀)², the per-bond
decay sum at δ₀ = ½), 1.7 (P-bond entropy) — and below everything, M6's method-class floor F, β ≥ 4.98/a² (a the small-field radius;
10² – 10³ for a = 0.07 – 0.22), plus the true values of the existential constants. A small-field/large-field induction of Bałaban's
kind therefore does not reach β ≈ 5 in any format examined here; the interval [5, 10²⁻³] belongs to the exact engines or to certified
computer-assisted steps (M8's step at β = 50 is the test of that).
15.3 THE NEXT OBJECT. LEMMA LF′ — THE VARIATIONAL PROBLEM WITH HOLES: on a domain with excluded (large-field) plaquettes, the minimizer of
CMP 102 exists and is unique, and the excluded set's influence on the background field and on the propagators H, G̃, H₀ decays like
e^{−δ₀·dist}. With it T19 needs only R = O(ln ln g⁻² + ln M) (§7.3), the polylog part of the large-field rows (59 decades) disappears, and
the floor drops to 72.58. FALSIFIER: a step of LFR I–II that uses R_k ≥ (log g⁻²)^r for anything but beating e^{−R_k} (first to check:
the ℝ-operation's N-window, M6 T20). INSTRUMENT: CMP 102 §§C–G re-read with a Dirichlet-type excluded set; then `bin/m6c_thresholds_d.py`
with T18 → T18_LF′. Right behind it on the critical path: per-plaquette positivity in large-field regions (−23.6 decades) and the history
half of Lemma PS (Lemma 1's O(M^{q₁}), CMP 109 §3 priced per site).

## 16. CROSS-FIELD IDENTIFICATIONS

(U1) THE δ-CASCADE IS A SEQUENTIAL UNION BOUND; LEMMA KP IS ITS SHEARER/KOTECKÝ–PREISS REPLACEMENT. Bałaban re-extracts a share of the decay
at every nesting level (D ⊂ Y₀ ⊂ Z₀ ⊂ Z′₀ ⊂ Z, then the cluster expansion), as a union bound pays once per event family; the attachment form of
the Kotecký–Preiss criterion (a(π) = c·n̄(π)) shows the entropy of a decorated cluster FACTORISES over its pieces, so each piece pays once —
the local-lemma principle M6 identified for the large fields (Shearer's radius), now on the small-field side, and the same machinery as THE
GROUND's certified Kotecký–Preiss inequality. Measured effect: κ from ≥ 45.11 to 5.10.
(U2) THE LINEAR SIZE IS A STEINER-TREE FUNCTIONAL, AND ITS ENTROPY IS SET BY DIAGONALS. Bałaban's "shortest tree graphs formed by edges of
cubes" (CMP 109 p. 257) are not shortest: the 4D staircase is met by a diagonal of length 2 per four cubes; that is why μ_d ≥ √11489 > 91,
and why Lemma MS's 16 cubes per unit length (Cauchy's projection formula in the (1,1,1,1) direction) is the right shape of the upper bound.
The d-polymer entropy is the growth constant of Steiner-thickened lattice animals — a geometric-measure object, not a lattice one.
(U3) THEOREM B IS THE STENCIL-GROWTH CONDITION OF MULTIGRID. A relocalised term of locality radius r (here the enclosure □̃⁶, r = 6) maps
under one block step of factor L to support (2r + 1)/L; it costs nothing exactly when that fits in one 2^d-cluster, L ≥ 2r — the condition
under which Galerkin coarse-grid stencils and refinable (wavelet) supports stop growing. An RG whose block factor is below the locality of
its own background-field construction pays the mismatch at every scale, forever.
(U4) EXACT PRICING IN THE UV IS ABOUT PREFACTORS, NOT ENTROPY. In THE GROUND the decades were in the polymer entropy and exact small-polymer
activities moved the KP threshold (the crossing and patch laws). In the UV, after Lemma KP the entropy costs ≈ 2 decades; the decades are
in the ratio between the true size of the leading activity (the quadratic form per bond pair, ε₁B₀²N(δ₀)²) and the bound the format
records (the M-cube sup, ε₁M⁸) — Lemma PS is the UV's crossing law. One rule covers both regimes: price the leading term on the scale
where it lives.

## 17. LEDGER (this agent's rows)

| Item | Status | Where |
|---|---|---|
| the ten δ-shares classified (ENTROPY / VOLUME / CONNECTION / RESCALING) | READ (CMP 116 pp. 7–21) | §2 |
| Lemma T (attachment Kotecký–Preiss; connected-family bound) | PROVED (KP 1986 cited, W = 0) | §3.1 |
| Theorem KP: one entropy payment per scale, κ ≥ (a_E + 2η/L)/(1 − 2/L), a_E > ln μ_d | PROVED GIVEN CMP 116's inputs | §3.2 |
| junction √7 (not 5) | PROVED | §3.3 |
| Lemma F′: μ_d ≥ √11489 = 107.19 (> 91); N₂(Q₄, antipodal) = 11489, N₁(Q₄) = 20769 | PROVED; COMPUTED | §4.1, rec/q4count.txt |
| Theorem P: κ(1 − 1/L) ≥ ln 91 (L ≥ 4), ≥ ½ ln 11489 (L ≥ 12), ≥ ln 46 (L = 3), with (2.36)'s enclosure | PROVED (§4.2 + §12.2) | §4.2, §12 |
| Lemma U: ln μ_d ∈ [4.6746, 45.933] | PROVED | §4.3 |
| Lemma M_w (base-adapted weights; M6b's falsifier answered) | PROVED GIVEN CMP 116's inputs | §5.1 |
| Theorem B: base residual 0 iff L ≥ 12 (□̃⁶), R(3) ≥ 40.5; corrects M6b's 15 | PROVED; COMPUTED | §5.2, runs c, d |
| M priced consistently (M1)–(M4); M ≈ 245–261 at the optima | READ / PROVED | §6 |
| Lemma LF: per-plaquette Peierls condition A² ≥ 12 + 9.84/log β (core) | PROVED | §7.2 |
| Lemma LF: the variational problem with holes (LF′) and per-plaquette positivity | OPEN (obstruction and falsifier named) | §7.3, §7.5 |
| comb-gauge Poincaré: Σ|B|² ≤ (d − 1)ℓ^dΣ|∂B|² | PROVED | §7.4 |
| Theorem EP: volume-priced format; fattening constant 91 → 1.174 (a_v = 3); certified entropy e^{45.93} → 17.65 | PROVED | §8.2 |
| Lemma PS: Σ_{b′}|Q(b, b′)| ≤ C_vε₁B₀²N(δ₀)² (M-independent) | PROVED GIVEN pointwise walk bounds; history part OPEN | §8.4 |
| best certified FLOOR log₁₀ β_B ≥ 124.30010 (L = 5, M = 245) | COMPUTED (run d) | §13, §15 |
| conditional ladder 72.58066 / 48.97446 / 13.10410 | COMPUTED on named lemmas | §13 |
| refutations printed: c3 fourth digit (½ ln 11489 mistyped), c11 (2.16, not ≈ 4), c5's 84.9 (85.21) | — | §11 |

## 18. DATED PRECISIONS — SENSITIVITY OF THE FLOOR 124.30 (2026-11-02, after §§13–17; nothing above edited)

18.1 THE GAUGE OF LFR II (1.8). §7.4's constant (d − 1)ℓ^d is proved for the COMPLETE axial (comb) gauge. LFR II p. 358 says "axial gauge
in a cube of size 100M" (M6's reading); if that gauge carries boundary data or is incomplete, §7.4 does not apply as stated and the page's
dℓ^{d+1} stands: then variant B's optimum is set by T18 itself, 134.121 decades at L = 5 (run d, column T18). The floor of record is
therefore 124.300 with the comb-gauge constant and 134.121 with the page's — both certified in run d; reading LFR II p. 358's gauge on the
image decides which.
18.2 THE BOUND (M2) ON M. Its factor e^{1+2κ} is the reorganised scheme's own (Lemma SD's polarisation constant e; the near cluster's
d_{k+1}-cost 2 at the output rate κ). Dropping it (keeping only (LM)⁴e^{−δ₀M/3} ≤ 1) gives M ≈ 186 at L = 12 instead of 261: X_small falls
by ≈ 2.4 decades and T18c by ≈ 2.9. The floor is robust to these modelling choices at the level of ±3 decades; the decades of §14 are not
moved by them.
18.3 c₅. (KP-v) with c₅ = 1 is Bałaban's own assumption (p. 20, "for example by 1"); a volume decay a_v ≈ 1.4–3.6 would allow c₅ up to that
size, moving M by 6 ln c₅ ≲ 8 and the floor by ≤ 0.3 decade.
18.4 18.1 DECIDED ON THE IMAGE (LFR II p. 358, M6's render `M6/render/lfr2_358.png`, READ today): "Consider the quadratic form ‖∂B′‖² on
the fields B′ defined on Λ, and equal to 0 on bonds of the graph G₀. Using the fact that Λ is a rectangular parallelepiped contained in a
cube of the size 100M, and that G₀ determines the axial gauge in Λ, we obtain the inequality (1.8)." G₀ fixes the COMPLETE axial gauge,
so §7.4 applies and the floor of record is 124.30010 (run d). The page continues: "The inequality is also much more general, holding for
general domains Λ, and graphs G₀ fixing a gauge in Λ, but with different constants. For example, if in this domain Λ we fix an axial gauge
in the direction of x₁-axis, i.e., we put B′(⟨x − e₁, x⟩) = 0 for x ∈ Λ, then the inequality (1.8) holds with the constant (100M)³." With
that gauge the T18 row has K = ln 2 + 6 ln M + 3 ln(100M) (≈ 113.7 decades at M = 247, hand arithmetic), below T17, and variant B's floor
becomes T17-bound: max(X_small, T17) is least at L = 6, 123.06208 decades (run d's certified columns: X_small 83.793, T17 123.062).
Whether the x₁-axial gauge is admissible in LFR II's construction is not settled here; the difference is 1.24 decades.
18.5 CORRECTION TO 18.4 (same day): the figure printed there as 123.06208 should read 123.062; run d prints three decimals of T17 at L = 6 and the extra digits were not computed. The minimum over L of max(X_small, T17) is at L = 6 (L = 5: 123.850; L = 7: 123.139; run d).
