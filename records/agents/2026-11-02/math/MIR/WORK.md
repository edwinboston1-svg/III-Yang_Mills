# MIR — THE IR END AS THE MIRROR OF BAŁABAN'S UV: THE LARGE-FIELD POLYMER EXPANSION AT THE COARSE SCALE

Proof agent MIR, 2026-11-02 (desktop; read-only in both repositories; everything here is in this directory: code/, rec/).
The work is appended in the order it was done. Stakes are written before the runs they grade and are not edited after.

## 0. What was read before any derivation

- MATH_BRIEF.md (the shared brief), cross/ANSWER.md.
- THE CROSSING CAMPAIGN §§7, 8, 20, 21, 22 (III, DOCS/III-THE-CROSSING-CAMPAIGN-OF-THE-YANG-MILLS-GAP.md, lines 87–125, 433–597).
- M2b WORK.md §§3–5 (Theorem A1, Corollary A1′, Lemma A2, Theorem C1, Proposition C2) and its HANDBACK.
- THE GROUND §8.3 (cross/ground_docx.txt lines 298–327: the setting, (8.5), Proposition 8.4, Hypotheses I–II, Theorem 8.5 and
  its proof) and the L² reduction of revision 33 (III-Yang_Mills source/ground/content4.js lines 110–214: (S), ℓ_y, (8.8b),
  Hypotheses I′, II′, Lemmas 8.5A–B, Proposition 8.5C, Theorem 8.5D, Proposition 8.5E, Theorem 8.5′).
- THE FAR SHORE §10 and RESULTS 1–6 (III-Yang_Mills OPEN/the-far-shore.md lines 150–251): the exit lemma, the budget, the
  pricing-comparison lemma, the exit condition as a certificate run at the blocked coefficients, the coefficient mode's refusals.
- The engine records: STDLIB/build/aperanton/surface-gas/dob_n4_W2L2_{ordered,cancel,random1}.txt, dob_n4_W2L4_ordered.txt,
  dob_n2_W2L2_free.txt, w2_strip.2026-11-01a.ordered.txt; M7's main.2026-11-02a.txt (the certificate at the two-step coefficients).

Integrity notes carried (brief): the "bent" n = 4 records are the planar geometry (campaign §18); readings at fixed fine data are
readings, not bounds; no Monte Carlo number enters a proof.

## 1. THE COORDINATOR'S DECIDING NUMBERS — STAKES (written 2026-11-02 ~09:55 EST, before any scan; not edited after)

Order received mid-task (the trunk seat): at two steps and at three, (a) the aligned region's activity per coarse plaquette as a function
of an alignment threshold θ, from the exact engines; (b) its probability per coarse plaquette under the coarse measure (chessboard, or an
exact/certified finite computation); (c) the (a)·(b)-weighted comparison against the KP entropy through the certificate in COEF mode.

**Instrument.** My copy of w2_strip_n.c (sha256 dd81dfe0…, byte-identical to III's), built `gcc -O2 -fopenmp`, PLANAR n = 4 (the two-step
object; the "bent" n = 4 records are the planar geometry, campaign §18). KAT MET before any stake: W2L2 CMAX=1 ordered reproduces
E[χ_½(A)] = 0.1455672953962, E[χ_½χ_½] = 0.02898038672337, E[χ_1(A)] = 0.002700437887790 to every printed digit
(rec/kat_n4_W2L2C1_planar_ordered.txt, 31 s). Free memory 2.4 GB at launch (other sessions): only runs under ~0.5 GB are made.

**The alignment family (a datum, not a measure).** TILT(α, s): every one of the 536 outside links set to the quaternion (cos α, sin α n̂_i),
n̂_i a unit axis drawn from a fixed hash of (i, s): a rotation of class angle α (½ tr = cos α) about a random axis. α = 0 is the ordered datum.
The environment's would-be coarse plaquette (a product of 16 such links) has E[½χ_½] = (cos α)^16 exactly (independent conjugation-invariant
factors), so the coarse alignment of the datum is c_env(α) = (cos α)^16 ≈ cos θ: α = 0.1 ↔ θ ≈ 23°, 0.2 ↔ 43°, 0.3 ↔ 61°, 0.4 ↔ 74°.
This map is a PROXY (a datum's coarse plaquettes have a spread of angles); every reading below is at a fixed datum.

**(a) stakes — a′_½(α) := E[χ_½(A)]/2 at the two-step object, W3L2 cap (CMAX=0), α ∈ {0, .05, .1, .15, .2, .3, .4, .6, .8, π/2}, s = 1:**
- S-a1 (KAT): α = 0 reproduces 0.12162561609 (the W3L2 ordered record).
- S-a2: a′_½(α) is non-increasing in α over the scan.
- S-a3: a′_½ ≤ 0.061 (half the ordered value) by α = 0.2; ≤ 0.02 by α = 0.4; |a′_½| < 0.005 at α = π/2.
- S-a4: a′_1 := E[χ_1(A)]/3 ≤ a′_½/8 at every α (the certificate's tail premise).
- S-a5 (W2L2 CMAX=1, the pair): the wall-to-plaquette ratio ρ_w(α) := ⟨χ_½χ_½⟩_c / (E[χ_½(A)]E[χ_½(B)]) INCREASES with α (the
  straight-holonomy perimeter noise makes the shared edge dominate as the outside disorders): 0.37 at α = 0 (record), above 1 by α = 0.6.
  Where it crosses 1: UNGUESSED.

**(b) stakes — probability per coarse plaquette of alignment within θ:**
- Haar (exact): μ₁(θ) = (2/π)(θ − sin θ cos θ) one-sided (near +1), μ₂(θ) = 2μ₁(θ) for the centre orbit {θ_P ≤ θ} ∪ {θ_P ≥ π − θ}.
- Pinned (reading): P(θ_A ≤ θ | datum) = ∫₀^θ p_A(t)(2/π)sin²t dt, p_A = Σ_{a≤L} E[χ_a(A)]χ_a (refused where not positive).
  S-b1: at the ordered datum (W3L2), P(θ_A ≤ 30°) ∈ [0.035, 0.060] against Haar's 0.0288 one-sided (enhancement 1.2–2.1).
  S-b2: at the Haar-random datum it is within 2 % of Haar.
- S-b3: the chessboard price z_A(θ) = lim_N λ_N(every coarse plaquette of one class aligned)^{1/N} is a constrained-ensemble free energy:
  REFUSED by every finite object in hand (no number will be printed for it).

**(c) stakes — the weighted test.** a_eff(θ; k) := a′_½(α(θ)) + k·a′_½(0)·p(θ), with p = μ₂ (the disordered-limit price, an underestimate
of z_A whenever alignments cluster) and k the number of coarse plaquettes whose alignment can lift P's coupling (k = 1 the optimistic count,
k = 20 the coarse environment of a plaquette). Fed to the certificate (committed copy, COEF mode, page dressing, GRADED, α = 1/1000) as the
spin-½ entry, the spin-1 entry scaled by the same factor:
- S-c1: k = 1 — some θ gives a_eff < 0.118 and the one-plaquette certificate PASSES.
- S-c2: k = 20 — no θ passes.
- S-c3: with the wall floor weighted the same way (W2L2 pair data), every (θ, k ≥ 1) FAILS through the wall.
**Three steps — ARITHMETIC, not an object:** the two-step coarse action at each datum read as Wilson(β_eff), β_eff from a′_½ by
a_½(β) = I₂/I₁; the third step is the n = 2 one-step object at β_eff at the same datum family. S-3: ordered three-step a′_½ ∈ [0.017, 0.048]
(§22's arithmetic range), and with it a_eff passes the one-plaquette certificate for every k ≤ 20 at some θ.

**STAKE S-T (written 10:4x EST, before the typical-datum runs; not edited after).** The TILT scan's first reading (below, §10) showed
a′_½ flat in the COARSE alignment of the datum. Typical data are therefore read directly: three SU(2) Wilson configurations at β = 2.2
on the periodic 12⁴ lattice (code/heatbath.c: Kennedy–Pendleton heat bath + 3 overrelaxations per sweep, links in the engine's own
convention; 300 thermalisation sweeps, samples 100 sweeps apart), their links cut out as the 536-link outside of the two-step object.
The sample only CHOOSES the datum; the reading at it is the engine's exact contraction. No number here enters a proof.
- S-T0 (KAT): the plaquette average reads 0.569 ± 0.003 (the literature value at β = 2.2 is about 0.569).
- S-T1: at the three sampled data, the W2L2 two-step a′_½ lies in [0.045, 0.070] (between TILT(0.6)'s 0.059/0.028 and the ordered 0.0728),
  i.e. the TYPICAL datum's coupling is at least 60 % of the ordered datum's, NOT the Haar datum's 0.0008.
- S-T2: the 4×4 loop has ⟨½ tr⟩ ∈ [0.002, 0.03] and P(|½tr W₄ₓ₄| ≥ cos 30°) ≤ 0.05 (aligned coarse plaquettes rare in the measure).

**RESULTS S-T (10:45 EST; records rec/heatbath_b2.2_s11.txt, rec/typ_W2L2C1_hb{0,1,2}.txt; stakes above unedited).**
- S-T0 MET: plaquette 0.5683 / 0.5685 / 0.5699 (12⁴, β = 2.2).
- S-T2 MET IN ITS FIRST HALF, AND SHARPER IN ITS SECOND: ⟨½ tr W₄ₓ₄⟩ = −0.00045 / 0.00094 / 0.00065 (each ± ≈ 0.003 sampling), and
  P(|½ tr W₄ₓ₄| ≥ cos θ) = 0.0570 / 0.0568 / 0.0575 at 30°, 0.1820 / 0.1818 / 0.1836 at 45°, 0.3894 / 0.3909 / 0.3947 at 60°, against the
  HAAR values μ₂ = 0.0577, 0.1817, 0.3910 (rec/haar_mu.txt). READING (Monte Carlo, enters no proof): **two steps up from β = 2.2 the
  straight-path coarse plaquette is Haar-distributed in its class angle to the sampling accuracy (about ±0.001).** Aligned coarse plaquettes
  are neither suppressed nor enhanced: their probability per plaquette is the Haar measure of the alignment set.
- S-T1 REFUTED: at the three typical data the W2L2 two-step coefficients are a′_½(A) = +0.0187 / −0.0335 / −0.0104 and
  a′_½(B) = +0.0139 / +0.0183 / −0.0015 — of BOTH SIGNS and at most 46 % of the ordered datum's 0.0728, not at least 60 %. The connected
  pair moment ⟨χ_½χ_½⟩_c = −1.8×10⁻³ / −1.4×10⁻⁴ / +6.4×10⁻³ (ordered 7.8×10⁻³; Haar-random 5.7×10⁻⁵).
- THE CORRECTION THE REFUTATION FORCES (desk, before any further run): the conditional law of the object's links given ALL other links depends
  only on the 536 outside links (Markov), so the engine at a sampled datum is the TRUE conditional expectation E_μ[χ(A) | outside] (up to the
  plaquette truncation), and its average over sampled data is the true marginal. The TILT family is a NO-FLUX family (independent small
  rotations: perimeter law, no area law, staples coherent toward the identity) and stays near the ordered value; a typical datum carries
  the coarse disorder (flux) of the true field into the object through its boundary staples. **What sets the two-step coupling is the
  coarse holonomy structure of the datum, not its fine roughness.** So "aligned" must be read as small coarse flux around the object, and
  (a) as a function of θ must be read on sampled data binned by the environment's coarse alignment — which is the measure-weighted (a)·(b)
  the coordinator asked for, as a reading.

KAT S-a1 MET (10:10 EST): W3L2 CMAX=0 at TILT(0,1) reads E[χ_½(A)] = 0.2432512322177, E[χ_1(A)] = 0.01093129100974 — the W3L2 ordered
record to every printed digit (rec/tilt_W3L2C0_a0.000.txt, 416 s; the spin-1 loop class alone took 366 s, so the scan reads a′_½ at
W3L1 and a′_1 only where needed).

---

## 2. THE SETTING: THE BLOCKED MEASURE, ITS SYMMETRIES, ITS RISK

**Lemma 2.1 (the straight-path blocked measure; PROVED).** Let μ be the Wilson measure at β > 0 on a periodic lattice Λ of side divisible
by L = 2^k, and for a coarse link ℓ = (x, x + L e_μ), x ∈ LΛ, let v_ℓ = U(x, x+e_μ)U(x+e_μ, x+2e_μ)···U(x+(L−1)e_μ, x+Le_μ) (the
holonomy along the straight fine segment). Let λ be the law of v = (v_ℓ). Then:
 (i) λ(dv) = ρ(v) Π_ℓ m(dv_ℓ), m = Haar, with ρ continuous and bounded above and below by positive constants;
 (ii) λ is invariant under the coarse translations and under coarse gauge transformations v_ℓ ↦ g(x) v_ℓ g(x + Le_μ)⁻¹, g: LΛ → SU(2);
 (iii) (reflection positivity) for θ the reflection in a coarse hyperplane x₀ = nL and Θ the induced map on coarse links, E_λ[(ΘG)‾ G] ≥ 0
 for every bounded G depending only on coarse links with both endpoints in {x₀ ≥ nL}.
*Proof.* (i) The straight segments of distinct coarse links are disjoint sets of fine links. Under fine Haar measure a product of
independent Haar elements is Haar, so the pushforward of fine Haar is Π m(dv_ℓ) and ρ(v) = E_Haar[e^{−S}/Z | v] (S the Wilson action).
Disintegrate by solving the first factor of each segment, U₁ = v_ℓ(U₂···U_L)⁻¹: ρ(v) is the Haar integral over the remaining fine links of a
continuous function of (v, U), continuous in v by dominated convergence, and |S − const| ≤ βN_p gives the bounds. (ii) A coarse gauge
transformation extends to a fine one (g = 1 off LΛ), which preserves μ and multiplies each straight-path product at its two ends only.
(iii) A coarse link with both endpoints in the closed half-space {x₀ ≥ nL} has its straight segment in the closed half-space. θ maps straight
segments to straight segments, so with (θU)_{x,y} = U_{θx,θy}, (ΘG)∘b = (G∘b)∘θ for the block map b. G∘b depends on fine links in the closed
half-space, and the Wilson measure is reflection positive for reflections in planes of sites (Osterwalder–Seiler 1978): E_μ[θ(F)‾F] ≥ 0 for
such F. Take F = G∘b. ∎
Remark. THE GROUND's half-open block partition assigns the links in a reflection plane to the upper blocks only, so the partition is not
reflection-covariant; the straight-path coarse VARIABLES are, which is all (iii) needs. Theorem 8.5′ never uses reflection positivity of λ
(its own remark); (iii) is used here only for chessboard estimates (§8).

**Remark 2.2 (THE EQUIDISTRIBUTION TRAP).** At fixed physical a_c = L a_j with a_j → 0, each straight-path coarse link is a product of
L → ∞ fine links whose UV fluctuations equidistribute it (the perimeter self-energy of a straight Wilson line); λ_j → Π m. Then any IR
hypothesis on λ_j holds trivially in the limit and ALL content sits in the fibre (Hypothesis II) — the campaign's §20.3 diagnosis, confirmed
here from the IR side. The IR expansion has content only (a) for coarse variables with a nontrivial continuum limit (averaged/smeared
variables, which straddle blocks — the theorems below never use block-locality), or (b) at a fixed lattice spacing, which is how the ONE FLOW
uses it: the exact steps run from the flow's effective lattice at β ≈ 2.2, where 4×4 and 8×8 straight loops are not equidistributed
(⟨W(4×4)⟩ at β = 2.2 is of order 10⁻², area law plus perimeter). The same self-energy is why the straight-holonomy blocked action carries
LARGE WALLS relative to its one-plaquette coefficient (§10.2's ρ_w): it suppresses each coarse plaquette's character while the shared coarse
edge's fluctuation is common to both neighbours — the walls are partly the block map's artefact, not the dynamics'.

**Lemma 2.3 (the canonical potential; PROVED).** In finite volume, log ρ = Σ_{X ⊆ Y} Φ_X with Φ_X := Σ_{W⊆X} (−1)^{|X∖W|} E_m[log ρ | v_W]
(E_m the expectation under Π m, Y the coarse links). Each Φ_X is gauge invariant, ∫ Φ_X dm(v_ℓ) = 0 for every ℓ ∈ X, and Φ_X ≡ 0 for X ≠ ∅
whenever the links of X form a forest.
*Proof.* Möbius inversion on the finite Boolean lattice gives log ρ = Σ_X Φ_X. Centring: integrating over v_ℓ (ℓ ∈ X) pairs each W ∌ ℓ with
W ∪ {ℓ}, whose conditional expectations then agree, with opposite signs. Gauge invariance: E_m[log ρ | v_W](g·v_W) = ∫ log ρ(g·v_W, v′) dm(v′)
= ∫ log ρ(g·v_W, g·v′) dm(v′) (Haar is invariant under the gauge action on the other links) = E_m[log ρ | v_W](v_W) (ρ gauge invariant). A
gauge-invariant function of the links of a forest is constant (gauge the forest to the identity); every W ⊆ X is then a forest, so each
E_m[log ρ|v_W] = E_m log ρ and Φ_X = E_m log ρ · Σ_{W⊆X}(−1)^{|X∖W|} = 0. ∎
THE RISK (named): renormalisation maps can produce measures with no summable potential (van Enter–Fernández–Sokal 1993). The finite-volume Φ
always exists; its decay in diam X uniformly in the volume and the cutoff is what the IR hypothesis assumes. Hypothesis II implies the decay of
the mixed differences of log ρ (a mixed second difference of log Z_fibre is a fibre covariance), so the risk is the one II excludes. Every Φ_X
lives on link sets containing a cycle: the potential is a function of coarse loops.

---

## 3. THE IR LARGE-FIELD EXPANSION, PRECISELY

**The expansion (Mayer around the Haar product).** Write ρ = Z⁻¹ Π_{X∈𝔛} e^{Φ_X}, 𝔛 the supports (X ≠ ∅, Φ_X ≢ 0), replaced WLOG by
link-connected hulls (overlaps only grow, so every condition below only strengthens). With f_X := e^{Φ_X} − 1,
   ρ = Z⁻¹ Σ_{𝒮 ⊆ 𝔛} Π_{X∈𝒮} f_X = Z⁻¹ Σ_{𝒫} Π_{P∈𝒫} K_P,   K_P := Σ_{𝒮 overlap-connected, ∪𝒮 = P} Π_{X∈𝒮} f_X,
the second sum over families 𝒫 of pairwise disjoint link-connected sets (each 𝒮 splits uniquely into overlap-connected components, which are
disjoint). K_P is a gauge-invariant function of v_P only. Two activities:
   z(P) := ∫ K_P dm^P (signed: the Haar integral keeps every cancellation),   κ(P) := Σ_{𝒮 overlap-connected, ∪𝒮=P} ∫ |Π_{X∈𝒮} f_X| dm^P.
**THE IR HYPOTHESIS (IR-KP).** For constants a, κ > 0 and b₀ ≤ 1/8:
 (KP-a) sup_y Σ_{P∋y} |z(P)| e^{a|P|} ≤ a;     (KP-b) sup_y Σ_{P∋y} κ(P) e^{(2a+κ+2)|P|} ≤ b₀.
**The large field, and how it is priced.** κ(P) is a HAAR integral over the polymer's own links: configurations where a Mayer factor is large
(coarse plaquettes of P near the centre orbit 𝒜_θ := {U : |½ tr U| ≥ cos θ}, where every character attains its modulus) enter weighted by
their Haar measure μ₂(θ) = (2/π)(θ − sin θ cos θ) per plaquette (μ₂(30°) = 0.0577, μ₂(45°) = 0.1817, μ₂(60°) = 0.3910). This is the IR mirror of Bałaban's UV pricing: there the rare field is the large
field, weighed by the action; here the rare field is the ALIGNED field, weighed by the reference measure. As a bounding device,
   κ-contribution of 𝒮 ≤ sup_{A_P^c} |Π f| + sup_{A_P} |Π f| · m(A_P),   m(A_P) ≤ |Π(P)| μ₂(θ),   A_P = {some plaquette of P in 𝒜_θ}.
Two constraints, both binding: (1) κ discards the cancellation inside Haar integrals, so (KP-b) has the CRUDE (Osterwalder–Seiler) radius —
the far shore's RESULTS 3 (a) applies verbatim; (2) a sharp aligned indicator has slowly decaying Peter–Weyl modes, so the split pays only for
activities CONCENTRATED on aligned configurations (environment-driven multi-body terms), never for a smooth one-plaquette weight, whose
character coefficients already price alignment exactly. The split is a bound, never the proof's quantity.
**Form B (exact pricing), the program's own instrument.** The flux-surface gas of THE GROUND's Theorem 8.9 run at the TRUE blocked measure's
coefficients and bond modes: the far shore's exit condition (RESULTS 4) with ENVIRONMENT-RESOLVED (measure-weighted) coefficients, the bonds
of ALL sizes (KP needs every polymer, and the two-step object reads only pairs), the large field entering each bond's Peter–Weyl coefficient as a Haar
integral over the bond's own links. Form B is conditional on the pricing-comparison lemma (RESULTS 4–6, signed with provisos) and on the
signed analogue of Theorem IR-1's cut-measure step (§4), the next object.

---

## 4. THEOREM IR-1: THE IR EXPANSION CLUSTERS, WITH A CONSTANT LINEAR IN THE PAIRS OF SUPPORT POINTS (PROVED)

Notation: Y finite (coarse links of a periodic coarse lattice), |y − y′| the coarse ℓ^∞ distance of base sites; a link-connected P ∋ y, y′ has
|P| ≥ |y − y′| + 1. λ = Z⁻¹ e^{H} Π m, H = Σ_{X∈𝔛} Φ_X, as in §3. For W ⊆ Y, the CUT MEASURE λ^W := Z_W⁻¹ e^{H_W} Π m, H_W := Σ_{X∩W=∅} Φ_X:
the Gibbs measure with every interaction touching W removed (v_W independent Haar under it). It is a POSITIVE probability measure — the
structural fact the proof turns on.

**Theorem IR-1.** Under (KP-a) and (KP-b), for bounded F, G depending on v_{S_F}, v_{S_G} with S_F ∩ S_G = ∅,
   |Cov_λ(F, G)| ≤ 2‖F‖‖G‖ ( exp(4b₀ Σ_{x∈S_F} Σ_{y∈S_G} e^{−κ|x−y|}) − 1 ),
uniformly in the volume.

*Proof.* (1) REPLICAS. Cov_λ(F,G) = ½ E_{λ⊗λ}[(F − F′)(G − G′)], F′ = F(v′). Expanding Π_X(1 + f_X(v))(1 + f_X(v′)),
   2Z² Cov = Σ_{(𝒮,𝒮′)} I(𝒮,𝒮′),   I := ∫ (F−F′)(G−G′) Π_{X∈𝒮} f_X(v) Π_{X∈𝒮′} f_X(v′) dm dm′,
over pairs of sub-collections of 𝔛. DOUBLED CLUSTERS: the overlap-connected components of 𝒮 ⊔ 𝒮′ (supports from either replica adjacent iff
they share a link); W(K) := the union of a cluster's supports; distinct clusters have disjoint W's.
(2) THE SWAP KILLS EVERY NON-CONNECTING PAIR. Let R := S_F ∪ ⋃{W(K) : W(K) ∩ S_F ≠ ∅}. Call the pair non-connecting if R ∩ S_G = ∅. Swap the
replica labels of the supports of every cluster inside R. Each support lies inside R or is disjoint from it (a cluster not meeting S_F is
disjoint from the clusters meeting S_F and from S_F), so the swapped pair has the same clusters, the same R, and the map is an involution;
under the measure-preserving change of variables σ_R (exchange v and v′ on R), its weight is the original's, F − F′ changes sign (S_F ⊆ R) and
G − G′ does not (S_G ∩ R = ∅). So I(swapped) = −I(pair), fixed points have I = 0, and Σ_{non-connecting} I = 0.
(3) MÖBIUS OVER THE CONNECTING CLUSTERS. Call a cluster connecting if W(K) meets both S_F and S_G; a pair is non-connecting iff it has no
connecting cluster. For a family 𝒦 of pairwise disjoint connecting clusters, W := ⋃W(K), put A(𝒦) := Σ_{pairs whose clusters include 𝒦} I.
A pair whose clusters include 𝒦 is exactly 𝒦's supports together with an ARBITRARY pair of collections of supports avoiding W (nothing else
overlaps W, so the K's stay components). Summing that arbitrary pair under the integral resums its Mayer factors:
   A(𝒦) = ∫ w_𝒦(v_W, v′_W) [ ∫ (F−F′)(G−G′) e^{H_W(v) + H_W(v′)} dm(v_{Y∖W}) dm(v′_{Y∖W}) ] dm(v_W) dm(v′_W),
w_𝒦 the product of 𝒦's Mayer factors. The bracket is a POSITIVE weight (the cut measure, unnormalised) against |(F−F′)(G−G′)| ≤ 4‖F‖‖G‖,
so |A(𝒦)| ≤ 4‖F‖‖G‖ Z_W² ∫|w_𝒦|, Z_W = ∫ e^{H_W} dm. Möbius inversion over the families 𝒦 (finite volume, finite sums) and (2):
   2Z² Cov = Σ_{𝒦₀ ≠ ∅} Σ_{𝒦 ⊇ 𝒦₀} (−1)^{|𝒦∖𝒦₀|} A(𝒦) = Σ_{𝒦 ≠ ∅} (−1)^{|𝒦|+1} A(𝒦).
(4) THE NORMALISATION. Z and Z_W are the polymer partition functions Σ_𝒫 Π z(P) over all families and over families avoiding W; by (KP-a)
and the Kotecký–Preiss theorem (Kotecký–Preiss 1986, Theorem 1, with a(P) = a|P|), |log Z − log Z_W| ≤ a|W|, so Z_W²/Z² ≤ e^{2a|W|}. Hence
   |Cov| ≤ 2‖F‖‖G‖ Σ_{𝒦≠∅} Π_{K∈𝒦} c(K) ≤ 2‖F‖‖G‖ ( exp(Σ_{K connecting} c(K)) − 1 ),   c(K) := e^{2a|W(K)|} ∫|w_K|.
(5) THE CHAINS. A cluster K's replica-1 supports split into disjoint polymers, likewise replica 2, and ∫|w_K| ≤ Π κ(polymers) (κ sums over
the support collections forming each polymer); K is connected through cross-replica overlaps. A connecting cluster contains a chain of
polymers R₁ ∋ x ∈ S_F, …, R_n ∋ y ∈ S_G, consecutive ones overlapping, with Σ|R_i| ≥ |x − y| + 1; the rest of K hangs off the chain in
trees. Summing (the standard Kotecký–Preiss tree bound): a tree of polymers rooted at a site carries total weight ≤ Σ_{R∋z} 2κ(R)e^{(2a+1)|R|}
≤ 2b₀ ≤ ¼ (replica label: factor 2), so the hanging trees cost at most e^{|R_i|/2} per chain polymer; the next overlap site costs |R_i| ≤ e^{|R_i|};
inserting e^{κ(Σ|R_i| − |x−y|)} ≥ 1, each chain step is bounded by Σ_{R∋z} 2κ(R) e^{(2a+κ+2)|R|} ≤ 2b₀, so
   Σ_{K ∋ x,y} c(K) ≤ e^{−κ|x−y|} Σ_{n≥1} (2b₀)^n ≤ 4b₀ e^{−κ|x−y|}.
Summing over x ∈ S_F, y ∈ S_G gives the theorem. ∎

What is NEW in this proof against the textbook (KP 1986; Friedli–Velenik 2017, ch. 5): the dressing of each observable by the polymers that
meet its support — which the extended-gas proof prices at (1 + b₀)^{|S_F|+|S_G|}, exponential in the support's VOLUME — is resummed exactly
into the cut measure, which is POSITIVE because the expansion is the Mayer expansion of a Gibbs potential. The constant is linear in the pairs
of support points, which is what makes quasi-local observables (the fibre means) tractable in Theorem IR-2. W = 0 for KP and the replica swap;
the positivity step is the earning.

**Lemma IR-D (the expansion forces DISORDER; PROVED).** Under (KP-a) and (KP-b), for every finite S ⊂ Y,
   ‖λ_S − m^{⊗S}‖_TV ≤ e^{a|S|} ( (1 + b₀)^{|S|} − 1 ),
λ_S the marginal of v_S. In particular, for y ≠ y′ and bounded f, g: |E_λ[f(v_y)g(v_{y′})] − m(f)m(g)| ≤ 2‖f‖‖g‖ e^{2a}(2b₀ + b₀²).
*Proof.* Integrating the polymer representation, the polymers not meeting S factorise: λ(F) = Σ_𝒴 [∫ F Π_{P∈𝒴} K_P dm] r(𝒴), r(𝒴) :=
Z(Y∖(S ∪ ⋃𝒴))/Z, 𝒴 over families of disjoint polymers each meeting S. The same identity at F = 1 gives 1 = Σ_𝒴 [∫Π_𝒴 K] r(𝒴). Subtracting
m(F) times it, the term 𝒴 = ∅ cancels: λ(F) − m(F) = Σ_{𝒴≠∅} [∫FΠK − m(F)∫ΠK] r(𝒴). Each bracket is ≤ 2‖F‖ Π κ(P) (|K_P| ≤ Σ_𝒮 |Π f_X|
pointwise), r(𝒴) ≤ e^{a(|S| + Σ|P|)} by (KP-a), and the families inject into choices of at most one polymer through each y ∈ S (assign each
polymer to its smallest point of S; disjoint polymers get distinct points), so Σ_{𝒴≠∅} Π κ(P)e^{a|P|} ≤ Π_{y∈S}(1 + Σ_{P∋y}κ(P)e^{a|P|}) − 1
≤ (1 + b₀)^{|S|} − 1. Taking the supremum over |F| ≤ 1 (twice the TV norm) gives the claim. ∎

---

## 5. WHY THE IR EXPANSION IS OUTSIDE THEOREM A1's CLASS, AND IT FAILS FOR ISING (PROVED)

**Proposition 5.1 (the discriminant: conditional against unconditional).** Theorem A1's typical-environment hypotheses (TE-p), (TE-χ) are
conditions on the joint law of the CONDITIONAL single-pair coefficients ρ_{yz}(ξ), C_ξ(y|z) (given the environment ξ). IR-KP implies, by Lemma
IR-D, that every UNCONDITIONAL local marginal lies within e^{a|S|}((1+b₀)^{|S|} − 1) of the FIXED product reference in total variation. Frozen
states have small conditional and large unconditional correlations; disordered states have both small. IR-KP sees the difference; A1's class
cannot.
**Proposition 5.2 (Ising, d ≥ 2; the falsifier passes).** Let λ_L be the nearest-neighbour Ising measure on the even torus, m uniform on ±1.
 (i) For every polymer representation of λ_L relative to m satisfying (KP-a), (KP-b) with constants independent of L, Theorem IR-1 gives
 Cov(σ₀, σ_x) → 0 exponentially in |x|; at β ≥ β₀(d) the torus has Cov(σ₀, σ_x) ≥ ½ for all x, L (Peierls; FILS 1978). So no such
 representation exists at low temperature, whatever its form.
 (ii) Sighted, at the first site: Lemma IR-D bounds ⟨σ₀σ₁⟩ ≤ 2e^{2a}(2b₀ + b₀²) ≤ 0.69 for b₀, a ≤ 1/8; the chessboard bound of
 Theorem A1 (ii) gives λ_L(bond unsatisfied) ≤ 2e^{−β/2^{d−2}}, so ⟨σ₀σ₁⟩ ≥ 1 − 4e^{−β/2^{d−2}} > 0.69 once β > 2.6·2^{d−2}. The failure is LOCAL: the IR
 expansion is refused at the first bond, not only at long range. The canonical potential relative to m is Φ_{xy} = βσ_xσ_y (no single-site
 terms: E_m[βσσ′|σ] = 0), and κ({xy}) = ∫|e^{βσσ′} − 1| dm = sinh β: not small, at any temperature where order sets in.
 (iii) For every (p, κ, α) of (TE-p), there are β₋ small and β₊ large with (TE-p) true at both (Theorem A1 at β₊; at β₋, ρ_{yz} ≤ 2β
 everywhere), while IR-KP holds at β₋ (κ({xy}) = sinh β₋ small) and fails at β₊ by (i). So IR-KP is not a function of TE data. ∎
Corollary A1′ is respected: μ⁺ and ½(μ⁺ + μ⁻) are BOTH refused by IR-KP relative to m (their nearest-neighbour correlations are near 1),
so IR-KP does not distinguish them — it refuses the frozen phase as a whole, which is what a disordered-phase expansion must do.

---

## 6. THEOREM IR-2: THE REDUCTION OF THE GAP TO THE IR EXPANSION (PROVED)

**Theorem IR-2.** Let a construction be as in Theorem 7.4 with L = 2, blocked at the coarse scale a_c by straight-path coarse links (or any
coarse map whose blocked law has a continuous positive density; block-locality is never used). Suppose, at every rung j ≥ j₀ and on every
lattice of the construction:
 (IR) the blocked measure λ_j satisfies (KP-a) and (KP-b) of §3 with constants a, κ > 0, b₀ ≤ 1/8 independent of j and the lattice;
 (II) Hypothesis II of THE GROUND (fibre clustering, sup form) with constants ρ′ < 1, K′.
Then for every ρ₁ ∈ (max(e^{−κ}, ρ′), 1) there is K, depending only on (a, κ, b₀, ρ′, K′, ρ₁, N(f), N(g), ‖f‖, ‖g‖), with
|S_j(fg) − S_j(f)S_j(g)| ≤ K ρ₁^d (d the coarse distance of the supports), and every limit point has a unique vacuum and a Hamiltonian with
no spectrum in (0, m), m = (1/a_c) min(κ, log 1/ρ′) — the number (8.8). HYPOTHESIS I IS NOT USED.

*Proof.* Fix j, a lattice, f, g, and write ρ_* = max(e^{−κ}, ρ′). The law of total covariance (Theorem 8.5's split) gives
Cov_μ(f,g) = Cov_λ(F, G) + λ(Cov_ν(f,g | ·)), F = ν(f|·), G = ν(g|·); the second term is ≤ K′N(f)‖f‖‖g‖ρ′^d by II(a).
QUASI-LOCAL DECOMPOSITION. Let B_n(f) be the coarse variables within coarse distance n of S(f) (B_0(f) those of S(f)), and F_n := F with every
coarse variable outside B_n(f) replaced by the identity: a function of v_{B_n(f)}. Changing one variable y at a time, II(b) gives
‖F − F_n‖_∞ ≤ Σ_{y∉B_n(f)} δ_y(F) ≤ K′N(f)‖f‖ Σ_{r>n} N_c(r)ρ′^r =: ε_n(f) ≤ C_f (n+1)³ ρ′^n, N_c(r) ≤ C(2r+1)³ the number of coarse
variables at distance r. With D_0 = F_0, D_n = F_n − F_{n−1} (n ≥ 1): F = Σ_n D_n (a finite sum in finite volume), D_n a function of
v_{B_n(f)}, ‖D_n‖_∞ ≤ C_f′(n+1)³ρ′^n for every n ≥ 0. Likewise G = Σ_m E_m with the same bounds.
THE PAIRS. If n + m ≥ d, |Cov_λ(D_n, E_m)| ≤ 2‖D_n‖‖E_m‖. If n + m < d, B_n(f) and B_m(g) are disjoint and at distance ≥ d − n − m;
Theorem IR-1 gives |Cov_λ(D_n,E_m)| ≤ 2‖D_n‖‖E_m‖(e^X − 1), X ≤ 4b₀|B_n(f)||B_m(g)| e^{−κ(d−n−m)}, and since the covariance is also
≤ 2‖D_n‖‖E_m‖, it is ≤ 2‖D_n‖‖E_m‖ min(1, e^X − 1) ≤ 2(e − 1)‖D_n‖‖E_m‖X. With |B_n(f)| ≤ C N(f)(2n+1)⁴,
   |Cov_λ(F,G)| ≤ Σ_{n+m<d} C″ poly(n, m) ρ′^{n+m} e^{−κ(d−n−m)} + Σ_{n+m≥d} C″ poly(n,m) ρ′^{n+m} ≤ C‴ poly(d) ρ_*^d,
using ρ′^{s}e^{−κ(d−s)} ≤ ρ_*^d for s < d and Σ_{s≥d} poly(s)ρ′^s ≤ poly(d)ρ′^d/(1−ρ′)^c. A polynomial times ρ_*^d is ≤ K₁ρ₁^d for every
ρ₁ ∈ (ρ_*, 1). Adding the fibre term gives the covariance inequality; the gap follows exactly as in Theorem 8.5's last paragraph (θf̄ and
τ_tf at coarse distance ≥ t/a_c − 1; Theorem 7.4 with r_j = 0). ∎

**What IR-2 changes in the chain.** At the IR end, (F3) and Hypothesis I are replaced by (IR) — a KP condition on the blocked measure's own
Mayer activities — which Theorem A1 does not forbid (§5) and which takes no supremum over coarse environments. The supremum Hypothesis II takes
(over coarse configurations, of FIBRE quantities) is kept: the fibre is integrated, and Lemma A2's averaging applies to it.

---

## 7. U(1) AT β = 1.2: WHY THE HYPOTHESES MUST FAIL, AND WHERE (PROVED + READINGS)

**7.1 The theorem-level falsifier (PROVED, conditional on its classical input).** If the 4D U(1) Wilson theory at β has a massless photon
(power-law ⟨F(0)F(x)⟩: Guth 1980; Fröhlich–Spencer 1982 for β ≥ β₀, β₀ UNCOMPUTED), then at every blocking depth k, (IR) ∧ (II) fails uniformly
in the volume, by Theorem IR-2. At β = 1.2 the Coulomb phase is known by NUMERICS only (the brief's integrity fact (d)): the falsifier is a
theorem for β ≥ β₀ and a reading at 1.2. A decider must refuse both.

**7.2 Lemma (straight-path equidistribution; PROVED).** For the Wilson measure of any compact group G at fixed β, let v be the product of the
L links of a straight segment. Then for every nontrivial irreducible ρ, ‖E[ρ(v)]‖ ≤ (1 − c(β))^{⌊L/2⌋}, c(β) > 0, uniformly in the rest of
the configuration; the same holds jointly for finitely many disjoint segments, so every finite-dimensional marginal of the straight-path
blocked measure converges to the Haar product as L → ∞.
*Proof.* Links of one segment at positions of equal parity share no plaquette, so the odd-position links are conditionally independent given
all other links, each with conditional density ∝ exp(β Σ Re tr(U·staples)) ≥ e^{−4dβ}/c′ relative to Haar. Write the conditional law of U_i
as c δ_Haar + (1 − c)ν_i (c = c(β) > 0); then M_i := E[ρ(U_i) | rest] = (1 − c)E_{ν_i}[ρ], ‖M_i‖ ≤ 1 − c, and
E[ρ(U₁⋯U_L) | even links] = M₁ρ(U₂)M₃ρ(U₄)⋯ has norm ≤ (1 − c)^{⌊L/2⌋}; integrate. Joint marginals: the same on the product of segments. ∎
**Consequences.**
 (i) LARGE k (any group): λ_k's bounded marginals → Haar products; any IR test reading bounded marginals passes for EVERY group, U(1)
 included, and the physics (photon or glueball) lives in the fibre. For U(1) the failing hypothesis at large k is therefore (II), by 7.1 —
 the campaign's §20.3 diagnosis, now a theorem about tests: **at large k the straight-path IR end cannot part the groups.**
 (ii) SMALL k (the ONE FLOW's use: a fixed number of exact steps from the crossover lattice): the IR activities carry the dynamics. U(1)'s
 coupling does not run (b₀ = 0), and the record reads two-step a′ = 0.301 (ordered) / 0.223 (cancelling) at β = 1.2 against SU(2)'s
 0.073 / 0.055 at the same cap at 2.2; both U(1) values exceed SU(2)'s certificate threshold 0.118 — U(1) fails (IR) where the IR end is read.
 (iii) THE GROUP-DEPENDENT INPUT, named: the drop of the IR activities per exact step from the crossover (asymptotic freedom), and, for KP
 over ALL polymer sizes, an AREA rate for large coarse bonds (activity ≲ e^{−σ_c k} for a bond of k plaquettes, σ_c the coarse string
 tension) — confinement read on the blocked action. The two-step object reads pairs only; the range of the blocked action at two steps is
 THE OPEN OBJECT (three-face and ring objects; M2b's four-sided-ring contraction).

---

## 8. REFLECTION POSITIVITY: WHAT THE CHESSBOARD ESTIMATE PRICES, WHAT IT CANNOT, AND THE CORRECT COMPOSITION

**Lemma 8.1 (chessboard for the blocked measure; classical in technique, W = 0).** Let λ be the straight-path blocked measure on the
periodic coarse torus of even side N_c (Lemma 2.1 (iii)). For nonnegative bounded gauge-invariant g measurable with respect to the links of the
closed unit coarse cell C₀, and τ ranging over the group generated by the reflections in the coarse planes, put z(g) := lim_{N_c→∞}
(E_λ[Π_{τ} g∘τ])^{1/N_c⁴}. Then for any finite family of cells τ₁C₀, …, τ_nC₀ and functions g₁, …, g_n,
   E_λ[ Π_i g_i∘τ_i ] ≤ Π_i z(g_i).
(Fröhlich–Israel–Lieb–Simon 1978 §4; Biskup 2009 Theorem 5.8; RP for site-reflections admits functions of the closed half-space, links in the
plane included, which is what a closed cell needs. The limit exists by subadditivity.)

**What it gives.** For the aligned event A_θ(P) := {|½ tr v_P| ≥ cos θ} at a coarse plaquette P of a fixed orientation class:
λ(every P ∈ X aligned) ≤ z(1_{A_θ})^{|X|}: a PEIERLS BOUND in the true measure, with z the free energy cost per coarse plaquette of
constraining every plaquette of the class to be aligned: −log z = f(constrained) − f(free).

**The correct composition (§22 item 6 repaired at the level where it is true).** Chessboard bounds the λ-expectation of a PRODUCT of local
nonnegative functions — a joint law. It never bounds a product of conditional probabilities (§22's (ii), correct), and it never bounds the
activities of §3, which are integrals against the REFERENCE measure Π m, not against λ. So chessboard enters an IR expansion only in a
conditioning (Pirogov–Sinai) form: aligned regions as contours with Peierls bounds in λ, the disordered complement expanded conditionally.
That form — the DISORDERED-PHASE PIROGOV–SINAI THEORY at the coarse scale (one stable phase, the disordered one; the aligned configurations
the unstable phase's contours) — is the full version of the object of this page, and is not built here (§11, the next object).

**Two facts that fix what the price can be (PROVED + READING).**
 (i) z(g) ≥ E_λ[g] (n = 1). With the READING of §10.4 (Monte Carlo, 32 configurations): λ(A_θ(P)) = μ₂(θ) to ±0.0005 at θ = 30°, 45°,
 60° two steps up from β = 2.2. So **no chessboard price at two steps can be below the Haar measure of the alignment set**: the
 Peierls constant of an aligned coarse plaquette is at least 0.058 at 30°, 0.18 at 45°, 0.39 at 60°.
 (ii) If λ's coarse plaquettes were Haar-independent, z = μ₂ exactly; z > μ₂ measures the clustering of aligned plaquettes. z is a
 thermodynamic quantity (a constrained free energy): REFUSED by every finite object in hand; the exact engines read conditional laws given
 fixed fine data, not constrained free energies.

---

## 9. THE LITERATURE, CREDITED (read 2026-11-02 through the searches recorded below; what each has, and what it lacks for this object)

- **Mayer/Kotecký–Preiss polymer expansions** (Kotecký–Preiss, CMP 103 (1986) 491; Friedli–Velenik 2017, ch. 5): Theorems IR-1, IR-2 use
  them; the pair-linear constant via the positive cut measure is this page's bookkeeping, not a new expansion.
- **Strong-coupling expansions of lattice gauge theory** (Osterwalder–Seiler, Ann. Phys. 110 (1978) 440; Seiler, LNP 159 (1982)): the
  OS regime is what (KP-b)'s crude L¹ norm reaches; Form B is THE GROUND's Theorem 8.9 machinery.
- **RG-transformed measures as random systems — the closest classical framework.** Bricmont–Kupiainen–Lefevere, "Renormalization group
  pathologies and the definition of Gibbs states", CMP 194 (1998) 359–388: the renormalized Hamiltonian exists only ALMOST EVERYWHERE with
  respect to the renormalized measure, is built by an RG method for random systems, and its pathologies are Griffiths singularities.
  Bertini–Cirillo–Olivieri, "Graded cluster expansion for lattice systems", CMP 258 (2005) 405–443: a mixing condition on a lattice subset
  whose complement is sparse gives a convergent multi-scale cluster expansion — one theory for the weak Gibbs property of RG measures and for
  disordered systems in the Griffiths phase. THIS IS THE IR LARGE-FIELD EXPANSION'S MATHEMATICAL HOME: the "large field" at the IR end is a
  Griffiths singularity of the blocked measure (coarse configurations at which the fibre's response is long-range), and Hypothesis II's
  averaged form is weak Gibbsianity. What they lack here: gauge invariance, the exact (character) pricing, and any statement at a coupling
  where the fine theory is not already in a convergent regime.
- **Griffiths singularities / rare bad regions:** Fröhlich–Imbrie, CMP 96 (1984) 145–180 (high-temperature expansion beating Griffiths
  singularities); Bassalygo–Dobrushin, Theory Probab. Appl. 31 (1986) 572–589 (uniqueness for a Gibbs field with random potential, an
  elementary approach); von Dreifus–Klein–Perez, CMP 170 (1995) 21–39. QUENCHED: the bad set is independent of the spins. At the IR end the
  bad set is the field itself (ANNEALED), which is why BKL's and BCO's RG versions, not these, are the template.
- **RG pathologies:** van Enter–Fernández–Sokal, J. Stat. Phys. 72 (1993) 879–1167 — the risk named in Lemma 2.3.
- **Finite-size criteria:** Olivieri 1988; Olivieri–Picco 1990; Martinelli–Olivieri 1994; Martinelli–Olivieri–Schonmann 1994 — sup over
  boundary conditions (strong mixing), the block analogue of what A1 shows necessary for single-pair criteria.
- **Disordered-phase Pirogov–Sinai:** Kotecký–Shlosman, CMP 83 (1982) 493–515 (large-entropy first-order transitions); Laanait–Messager–
  Miracle-Solé–Ruiz–Shlosman, CMP 140 (1991) 81–91; algorithmic: Helmuth–Perkins–Regts, PTRF 176 (2020) 851–895, Borgs–Chayes–Helmuth–
  Perkins–Tetali (STOC 2020). A disordered reference with ordered regions as polymers: the structure §8 names.
- **Chessboard / reflection positivity:** Fröhlich–Israel–Lieb–Simon, CMP 62 (1978) 1–34 and J. Stat. Phys. 22 (1980) 297–347; Biskup,
  "Reflection positivity and phase transitions in lattice spin models" (2009). In gauge theory, Borgs–Seiler, CMP 91 (1983) 329–380: the
  finite-temperature/spin-model analogy and INFRARED BOUNDS (from reflection positivity) giving a lower bound on the critical coupling — a
  weak-coupling regime without confinement at nonzero temperature in ≥ 3 space dimensions — and upper bounds on the coupling above which
  there is confinement; its abstract names no chessboard estimate.
- **Massless U(1):** Guth, Phys. Rev. D 21 (1980) 2291; Fröhlich–Spencer, CMP 83 (1982) 411–454 (β ≥ β₀, uncomputed).
- **The two-sided TCS mirror:** worst-case-pinning criteria (spectral independence under all pinnings: Anari–Liu–Oveis Gharan 2020) carry
  A1's supremum; zero-freeness/polymer methods (Barvinok; Helmuth–Perkins–Regts) do not — the IR expansion is on the second side.

Searches made (WebSearch, 2026-11-02): Borgs–Seiler (CMP abstract via Microsoft Research page); Bassalygo–Dobrushin (mathnet listing,
TVP 31 (1986) 651–670, English 572–589); Olivieri finite-size condition (found Bertini–Cirillo–Olivieri, arXiv 1110.6028, CMP 258 (2005));
Bricmont–Kupiainen–Lefevere (CMP 194 (1998) 359–388, abstract via mp_arc 97-244 listing). alphaXiv was not connected in this session.

**THE CONVENTION CONTROL — STAKE (written 11:1x EST before its runs; the advisor's blocking item).** Every KAT so far used inversion-closed
data (identity; {±1, ±i}), blind to a flipped link convention. code/objmc.c sets the 536 outside links from a datum file (others identity;
exact, since every plaquette through an object link lies in object ∪ outside) and heat-baths ONLY the 76 object links at the FULL Wilson
weight. S-C1: at the ordered datum, ⟨½ tr A⟩ ∈ [0.13, 0.16] (engine: 0.0728 W2L2, 0.1394 W4L1; full weight above W4). S-C2: at hbdatum_0,
⟨½ tr A⟩ within 2σ of [0.019, 0.026] (engine: 0.0187 W2L2, 0.0231 W4L1) and ⟨½ tr B⟩ near the engine's 0.0139 (W2L2) scaled the same way.
A sign or factor-of-several mismatch convicts the convention and withdraws every typical-datum reading.

**RESULTS, THE CONVENTION CONTROL (11:2x EST; rec/objmc_ordered.txt, rec/objmc_hb0.txt).** S-C1 MET: ordered datum, full weight,
⟨½ tr A⟩ = 0.14519 ± 0.00074 (engine W4L1 0.1394, W2L2 0.0728). S-C2 MET: hbdatum_0, full weight, ⟨½ tr A⟩ = 0.02313 ± 0.00033 against
the engine's W4L1 0.02306 (0.2σ) and W2L2 0.0187; ⟨½ tr B⟩ = 0.01269 ± 0.00041 against W2L2 0.0139. **The link convention is right; every
typical-datum reading stands.** objmc is a second road sharing no line with the engine (Monte Carlo of the object's 76 links against the exact
contraction). It also calibrates the truncations: at the typical datum W4 is exact to 0.3 % and W2 is 19 % low; at the ordered datum W4 is
4 % low and W2 50 % low. Typical-datum magnitudes are therefore robust; W2 digits carry a 20 % (typical) to 50 % (ordered) truncation.

**Two facts of Theorem IR-1's proof made explicit (11:5x, after a second read).** (a) Overlap between supports of the two replicas is
replica-symmetric (a shared link is a shared link whatever the labels), so the swap of step (2) preserves the cluster decomposition and R.
(b) Same-replica polymers inside one cluster are distinct overlap-components of one collection, hence disjoint; that is what makes ∫|w_K|
factorise into Π κ in step (5). The weight (2a + κ + 2) absorbs the chain's loose constants (the replica label, the overlap-site choice, the
hanging trees); it is not claimed sharp.

**CORRECTION (11:5x) of the S-T2 grading written at 10:45:** S-T2 staked ⟨½ tr W₄ₓ₄⟩ ∈ [0.002, 0.03] and P(30°) ≤ 0.05; the readings are
0.00097 ± 0.0003 (32 configurations) and 0.0577. **S-T2 is REFUTED in both halves** (the note above called its first half met — wrong):
the coarse plaquette is more disordered in its mean than staked, and exactly Haar, not sub-Haar, in its alignment probability.

---

## 10. THE READINGS (every value copied from its record; readings on exact finite objects at fixed data, or Monte Carlo where marked — no
## reading enters a proof)

**10.1 The TILT family (no-flux alignment), β = 2.2, two-step planar object** (rec/tilt_W2L2C1_a*.txt positive truncation;
rec/tilt_W3L1C0_a*.txt SIGNED truncation — the W3 weight is signed (brief, 10:2x), so the W3L1 column is a signed-weight ratio):

| α | coarse env (cos α)¹⁶ | a′_½(A) W2L2 | a′_½(B) W2L2 | ⟨χ_½χ_½⟩_c W2L2 | ρ_w | a′_½(A) W3L1 (signed) |
|---|---|---|---|---|---|---|
| 0 | 1 | 0.072784 | 0.072784 | 7.79e-3 | 0.368 | 0.121626 |
| 0.1 | 0.85 | 0.072888 | 0.072735 | 7.82e-3 | 0.369 | 0.120709 |
| 0.2 | 0.53 | 0.073112 | 0.072259 | 7.84e-3 | 0.371 | 0.117642 |
| 0.3 | 0.48 | 0.073213 | 0.070129 | 7.63e-3 | 0.372 | 0.111441 |
| 0.4 | 0.27 | 0.072831 | 0.063796 | 6.99e-3 | 0.376 | 0.100660 |
| 0.6 | 0.046 | 0.059424 | 0.028496 | 3.73e-3 | 0.551 | 0.062746 |
| 0.8 | 0.003 | 0.010609 | −0.009663 | 1.98e-3 | ill-def. | 0.014692 |
| π/2 | 0 | 0.000023 | 0.000004 | −3.3e-8 | ill-def. | 0.000052 |

Stakes: S-a1 MET (KAT). S-a2 REFUTED for face A at W2L2 (rises 0.6 % to α = 0.3), MET at W3L1. S-a3 REFUTED in its first two clauses
(a′ stays at 97 % / 83 % of the ordered value at α = 0.2 / 0.4, where the datum's displaced coarse loops already read ½ tr from −0.84 to +0.36,
rec/datum_a0.400.txt through code/envalign.awk), MET in its third (α = π/2). S-a4 MET in magnitude. S-a5 MET in direction (ρ_w rises),
REFUTED in size (0.55 at α = 0.6, not above 1). **Reading: under a no-flux datum the two-step coupling is set by the coherence of the
staples (all near the identity), not by the datum's coarse alignment — TILT is not an alignment family for the coarse measure.**

**10.2 Typical data and the convention control** (§1's RESULTS S-T and the control): at three β = 2.2 heat-bath outsides,
a′_½(A) = +0.0187 / −0.0335 / −0.0104, a′_½(B) = +0.0139 / +0.0183 / −0.0015 (W2L2); W4L1 at hb0 0.02306; full-weight Monte Carlo of the
object's 76 links at hb0 0.02313 ± 0.00033 (second road, no shared line: the convention is right). The coupling at a typical datum is set
by the coherent coarse flux the datum carries into the object.

**10.3 The coarse plaquette's alignment law (Monte Carlo, 32 configurations of 12⁴ at β = 2.2, 4 chains, rec/heatbath_b2.2_s2*.txt):**
plaquette 0.56936; ⟨½ tr W₄ₓ₄⟩ = 0.00097 ± 0.0003; P(|½ tr W₄ₓ₄| ≥ cos θ) = 0.05769 / 0.18125 / 0.39069 at 30° / 45° / 60° against Haar's
0.05767 / 0.18169 / 0.39100. **(b) ANSWERED AS A READING: the probability per coarse plaquette of alignment within θ is the Haar measure
μ₂(θ) = (2/π)(θ − sin θ cos θ) to ±0.0005.** By chessboard (§8 (i)) no Peierls price can be lower. A certified finite computation of it:
none in hand (it is the class law of a 4×4 Wilson loop in infinite volume).

**10.4 The batch: 35 typical data (W2L2, full table; rec/full_W2L2_*.txt, rec/agg_rows.txt; aggregates by code/aggstat.awk; the
pinned wall floors by w2_modes.awk, rec/walls.txt):**
- a′_½ over data: sd 0.0188; range [−0.034, +0.034]; mean |a′_½| = 0.0180; 34 of 70 entries NEGATIVE (the certificate refuses negatives by
  name; the pricing lemmas take moduli, so |a′| is the safe input). 0 of 35 data have a′_½ > 0.118. 0 of 35 have environment c_mean > 0.5.
- Var over data of E[χ_½(A) | outside] = 0.0014 (B: 0.0024) against Var χ_½ ≈ 1. By the tower property and Markov, **every coarse
  environment moves a coarse loop's expectation by an RMS of at most ≈ 0.05 (a′ by ≈ 0.025)** — a one-sided measure-weighted reading
  of the large field's whole effect on one coarse plaquette (W2; ×1.2 for full weight by 10.2's calibration).
- Unconditional Cov(χ_½(A), χ_½(B)) = 1.1e-4 (mean conditional) + 3.5e-4 (covariance of the conditional means) = 4.7e-4 (Monte Carlo, noisy).
- PINNED WALL FLOORS a′_1 + 16 s_one/3 at all 35 data: mean 0.094, min 0.0215, max 0.184 — every one above the certificate's
  wall ceiling.

**10.5 THE CERTIFICATE (committed copy, sha b17b8d37…, KAT: the ordered W2L2 COEF reproduces M7's κ_U 0.005580 and u~ 0.07319093;
code/cert1.sh, GRADED, page dressing, α = 1/1000):**
- one-plaquette part at every typical datum: PASS (LHS ≈ 0 at hb0's a′ = 0.0187).
- THE WALL CEILING (bisected): [0.01606, 0.01625] at hb0's coefficients, [0.01599, 0.01614] at the ordered W2L2 coefficients,
  [0.01609, 0.01617] at the measure-weighted ones — **the ceiling is ≈ 0.0161, independent of the one-plaquette coefficient**: it is a
  property of the dressing recursion (no root above it).
- THE MEASURE-WEIGHTED PAIR LAW (code/avgtable.awk: the average of the 35 pinned tables = the true joint class law of the coarse pair, up to
  truncation and Monte Carlo error; rec/avg_table.txt): E[χ_½] = −0.0034 ± 0.0063 / +0.0074 ± 0.0082, E[χ_1(A)] = −1.44e-4 ± 0.4e-4,
  E[χ_1χ_½]-type moments consistent with zero (−5.3e-6 ± 1.1e-5); sup|δ₂| = 0.0019 against the pinned 0.008–0.05; wall floor 0.0175 against
  the ceiling 0.0161 → FAIL at face value, but the floor is NOISE-DOMINATED (|b̂|^{1/2} of modes consistent with zero; the 2σ band of the
  (2,1) mode puts the floor anywhere in ≈ [0.005, 0.029]): **UNDECIDED at this sample size.**
Stakes (c): S-c1 MET (trivially: 0.073 already passes); S-c2 REFUTED (at small θ the Haar price vanishes, e.g. θ = 10°: 0.073 + 20·0.073·0.0022
= 0.076 passes); S-c3 MET (with the wall, every pinned datum FAILS). Three steps: NOT RUN — the question moved (§11).

---

## 11. WHAT IS PROVED, WHAT IS READ, THE NEXT OBJECT, AND THE UNIFICATION

**PROVED (on this page):** Lemma 2.1 (straight-path blocked measure: density, gauge and translation invariance, reflection positivity);
Lemma 2.3 (canonical gauge-invariant potential, zero on forests); Theorem IR-1 (the IR expansion clusters, pair-linear constant); Lemma IR-D
(it forces disorder of every local marginal); Propositions 5.1–5.2 (outside A1's class; fails for low-temperature Ising, refused at the first
bond); Theorem IR-2 (IR expansion + Hypothesis II ⟹ the gap (8.8), Hypothesis I unused); Lemma 7.2 (straight-path equidistribution, rate
(1 − c(β))^{⌊L/2⌋}) and its consequence (at large k no straight-path IR test parts the groups; U(1)'s failure moves into II); Lemma 8.1's use
and the correct chessboard composition.
**CONDITIONAL:** Form B (exact pricing) on the pricing-comparison lemma and on a signed analogue of IR-1; 7.1 on the Coulomb phase (β ≥ β₀).

**THE COORDINATOR'S PREMISE, MEASURED.** "Rare aligned regions with activity ≈ 0.14" — the rarity is right (aligned coarse plaquettes come
with exactly the Haar frequency; 0 of 35 typical environments are aligned), but 0.14 is the activity at the FLAT FINE DATUM, a measure-zero
configuration whose coupling comes from every staple pointing at the identity, not a coarse-aligned region's. At typical data the one-plaquette
part is deep inside the window (|a′| ≤ 0.034, mean 0.018); the large field moves a coarse loop by RMS ≤ 0.05. **The obstruction at two steps
is the WALL, and it is typical, not rare:** pinned wall floors 0.022–0.184 (mean 0.094, 35 of 35 above) against the ceiling 0.0161; the measure-weighted
pair law's floor 0.0175 is undecided by Monte Carlo noise. The pinned wall is mostly a PINNING ARTEFACT — fixing the fine outside correlates
the two coarse loops through the shared boundary layer; integrating the outside removes it (sup|δ₂| 0.0019 against 0.008–0.05): Lemma A2's
"averaging is legitimate for what is integrated", now measured on the object.

**THE NEXT OBJECT (precise).** The two-step coarse pair law with the outside INTEGRATED, exactly: the connected spin-1 creating moments
E[χ_1(A)χ_½(B)]_c, E[χ_½(A)χ_1(B)]_c of two adjacent 4×4 straight loops at β = 2.2, computed with the first fine ring integrated (no fine
pinning; M2b's four-sided-ring contraction) to absolute error ≤ 10⁻⁶ — the size at which the wall floor 16·(|b̂₂₁|^{1/2} + |b̂₁₂|^{1/2})/3 is
decided against 0.0161. With it: the certificate at the measure-weighted coefficients decides the two-step exit. Beside it, the design choice
the data force (the coordinator's call): at two straight-path steps the one-body marginal is ALREADY Haar (Remark 2.2 bites at k = 2), so the
IR content of straight-path variables is entirely pair and higher connected terms and their range; an averaged/smeared coarse link would keep
a non-Haar one-body marginal and move the content back into the one-plaquette coefficient.

**THE UNIFICATION.** (1) The IR large field is the GRIFFITHS SINGULARITY of the renormalisation map — Bricmont–Kupiainen–Lefevere's
renormalised Hamiltonian defined almost everywhere, Bertini–Cirillo–Olivieri's graded expansion with sparse bad sets — with the environment
being the coarse field itself (annealed); Hypothesis II's averaged form is weak Gibbsianity. (2) The A1 escape is conditional-versus-
unconditional correlation: frozen states have small conditional and large unconditional couplings; a fixed-reference expansion sees the
second. In computer science the same split separates worst-case-pinning criteria (spectral independence) from zero-free/polymer methods.
(3) Two steps from 2.2 the coarse plaquette's law is the strong-coupling fixed point (Haar) to 10⁻³ — the IR mirror of Bałaban's UV fact that
the typical field is near the free vacuum; what remains non-trivial at the coarse scale is the pair structure, exactly as in the UV the
non-Gaussian content is in the interaction, not the propagator.

**CORRECTIONS OF STRENGTH (12:0x EST; nothing above edited):** (1) §1's stake prints μ₁(θ) = (2/π)(θ − sin θ cos θ); the correct one-sided
Haar measure is μ₁(θ) = (θ − sin θ cos θ)/π (the number quoted there, 0.0288 at 30°, is right), and μ₂ = 2μ₁ = (2/π)(θ − sin θ cos θ)
(rec/haar_mu.txt). (2) S-b1 graded: P(θ_A ≤ 30° | ordered, W3L2 signed) = 0.0288 + 0.24325·0.05305 + 0.010931·0.06891 = 0.0425 — MET
(enhancement 1.47 over Haar one-sided); S-b2 MET (random datum within 1 % of Haar). (3) The W3L1 TILT column is a signed-weight ratio
(the brief's 10:2x integrity fact (a)); the conclusions rest on the W2 (positive) column and on the W4/full-weight control.
Records: rec/ (tilt_*, typ_*, full_W2L2_*, objmc_*, heatbath_*, avg_table.txt, agg_rows.txt, walls.txt, haar_mu.txt); code/ (w2_strip_n.c
byte-identical to III's, tilt_datum.awk, heatbath.c, objmc.c, envalign.awk, avgtable.awk, aggstat.awk, agg.sh, cert1.sh, kp_cert.awk = III HEAD's
aperanton_kp_cert.awk byte-identical).

**STRENGTH NOTES ON §10–§11 (12:1x EST, a second read; nothing above edited).**
(1) "The obstruction at two steps is the WALL, typical not rare" holds for the PINNED instruments (35 of 35 floors above 0.0161). For the
TRUE coarse measure it is UNDECIDED: the averaged floor 0.0175 comes from a (2,1) mode −5.3e-6 ± 1.1e-5 (consistent with zero) through
|b̂|^{1/2}, and carries the W2 truncation. The pinned-against-averaged gap (floor 0.094 against ≤ 0.0175; sup|δ₂| 0.008–0.05 against 0.0019)
is the measured size of the pinning artefact.
(2) The regression slope 0.032 of E[χ(A)|ω] on c_mean has standard error ≈ 0.04 at n = 35: NO DETECTABLE dependence of the coupling on
the environment's coarse alignment.
(3) Pair-level W2 truncation is UNMEASURED (objmc's covariance −0.00089 at hb0 has a statistical error near 6e-4; no factor is inferred).
The one-plaquette calibration stands: W4 exact to 0.3 %, W2 19 % low at typical data. The wall floors inherit an unquantified W2 error.
(4) The tower-property bound uses W2 conditional expectations; full weight multiplies the RMS by ≈ 1.24 (0.0231/0.0187): RMS ≤ 0.05·1.24
≈ 0.06 in χ units, a′ by ≤ 0.03.
