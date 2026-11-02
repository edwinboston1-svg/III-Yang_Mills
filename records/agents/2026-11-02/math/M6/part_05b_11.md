
## 5b. RESULTS OF RUN b (record `rec/thresholds_run.2026-11-02b.txt`, rc = 0; stakes above unedited) — ALL HELD

(B1) 280.80107; (B2) 559.69905; (B3) 998.89216; (B4) 44.979 (M = 27), 54.522 (81), 64.064 (243), 73.607 (729); (B5) 27.803 (M = 27),
31.620 (81), 35.437 (243), 39.254 (729) — each a log₁₀ β, intervals of width < 10⁻⁴⁸.

## 6. THE ARCHITECTURE-FREE FLOOR (inputs COMPUTED; its status as a necessary condition ESTIMATED, the assumption named)

Every renormalisation step of Bałaban's kind splits field space by a plaquette threshold: small field |U(∂p) − 1| < ε, expanded around
U = 1 with a Gaussian of covariance proportional to g²; large field, controlled by the action's suppression alone. Write ε = pg
(g = g_B, β = 1/g²).

(i) FREE-FIELD INPUT (PROVED). Linearising U_ℓ = exp(iα_ℓ·σ), θ_p = (dα)_p and S_p = (1/g²)(1 − cos|θ_p|) = Σ_a(θ^a_p)²/(2g²) + O(θ⁴): per
colour, the lattice Maxwell field with e² = g². On the torus (V sites) equipartition gives Σ_p⟨(θ^a_p)²⟩ = g²·rank d₁ = g²(dV − (V − 1) − d)
over d(d − 1)V/2 plaquettes, all equal by symmetry, so ⟨(θ^a_p)²⟩ → (2/d)g² = g²/2 at d = 4 (run a: 0.49383 at V = 81). Check:
⟨1 − ½Tr U_p⟩ ≈ ⟨|θ|²⟩/2 = 3/(4β), the standard leading term; and |U_p − 1| = 2 sin(|θ_p|/2) ≈ |θ_p|.

(ii) THE BAD EVENT. P(|θ_p| ≥ ε) = P(χ²₃ ≥ 2p²) at the Gaussian density.

(iii) SPARSENESS. Two plaquettes sharing a link are dependent; each plaquette shares a link with Δ = 4·(2(d − 1) − 1) = 20 others. The
large-field set is a hard-core polymer gas on this 20-regular graph; its cluster expansion converges on every graph of maximal degree Δ
exactly when the activity is at most Shearer's z_c(Δ) = (Δ − 1)^{Δ−1}/Δ^Δ = 0.0188676801… (Shearer 1985; the optimal form of the Lovász
Local Lemma for bad events of dependency degree Δ). ASSUMPTION (named): the large-field activities are at least the Gaussian probability
of the bad event, and the plaquette graph's own radius lies within some per cent of the tree value (for ℤ² hard squares the ratio is
1.13; a 13 % change of z_c moves p_min by 1.3 %).

(iv) THE FLOOR. P(χ²₃ ≥ 2p²) ≤ z_c ⇔ p ≥ p_min = 2.2321296803 (run a). A small-field radius a — the largest ε at which the step's
perturbative machinery holds — then forces β ≥ (p_min/a)² = 4.9824/a². Conversely, at β = 3 / 4 / 5 the threshold must be
ε = 1.2887 / 1.1161 / 0.9982: plaquette rotations of 80.2° / 67.8° / 59.9°, where the radial eigenvalue cos φ of the single-plaquette
Hessian of 1 − cos φ is down to 0.17 / 0.38 / 0.50. The convexity edge φ = 90° (a = √2) gives the absolute floor β ≥ 2.4912.

VERDICT OF §6. Counting alone does not exclude 3–5; every construction whose small-field radius is below 1 does — and every
construction on record has a ≪ 1 (Bałaban's a₀, a₁ "depend on d and L only" and are used "for ε₀ sufficiently small"; his ε_k reappears
multiplied by 2L² = 18 at the next scale, CMP 119 p. 246).

## 7. THE TABLE

Each constraint, its source (READ on the rendered page today), its form, the threshold it imposes, its strength. "log₁₀ β forced" is the
least log₁₀ β_B at which the printed inequality can hold with every implicit constant at its value most favourable to a small threshold
(1, or the least value the page allows). COMPUTED = certified interval arithmetic, records a and b.

| # | Constraint | Source | Form on the page | log₁₀ β forced | Strength |
|---|---|---|---|---|---|
| T1 | regularity of the minimal configuration | CMP 102 Thm 1, p. 279 | ε₁ ≤ a₁, B₃ε₁ ≤ ε₀ ≤ a₀; a₀, a₁, B₃ "depend on d and L only"; M(ε₁) = R₁M₁(a₁/ε₁) | enters every ε_k row | EXISTENTIAL |
| T2 | block propagator decay | CMP 95 Prop. 1.2, p. 35; p. 38 | |(GJ)(x)| ≤ O(1)e^{−δ₀|y−y′|}|J|, δ₀ = δ₀(d); 2δ₀ = min(δ₀′/3, 1/M₀) | through M ≥ κ/δ₀ (CMP 116 p. 21), δ₁M ≥ κ₁ (p. 5), δ(M/M₁) ≥ 2 (LFR I p. 186): polynomial in M | EXISTENTIAL |
| T3 | random-walk series | CMP 116 (1.7), p. 3 | O(1)O(M₁^{−1/2})^{|ω|} per walk | M₁ large; polynomial | EXISTENTIAL |
| T4 | order of choices | CMP 109 Thm 3, p. 264 | κ ≥ κ₀, M ≥ M(κ); ε₀, ε₁, α₀, α₁ depend on M; γ on all | — | EXISTENTIAL |
| T5 | localisation sums | CMP 109 (1.18) p. 263; CMP 116 (1.26) p. 8, (2.29) p. 18 | Σ_{X∋□}e^{−κd(X)} ≤ O(1) "for κ sufficiently large" | κ₀ ≥ ln(animal growth) | EXISTENTIAL |
| T6 | decoupling radius | CMP 116 (1.27), p. 8 | exp(8·12³e^{−(κ₁−1)/2}) ≤ e | κ₁ ≥ 20.068323 | COMPUTED |
| T7 | decoupling against decay | CMP 116 p. 9, p. 21 | κ₁/16 ≥ (1 − 2δ)κ, δ = (1 − 2/L)/10 | κ₁ ≥ 14.9333κ (L = 3) | COMPUTED |
| T8 | amplified quadratic form | CMP 116 (1.40)→(1.43), pp. 10–11 | ½C₃3³e^{7·8κ₁}|B′| ⇒ C₂ ≥ 56 | — | READ at 230 dpi |
| T9 | fluctuation domain | CMP 116 (1.40), p. 10 | e^{16κ₁}|B′| ≤ a₁/3, |B′| ≤ C₁ε₁ | 280.80 (with T12) | COMPUTED |
| T10 | minimiser contraction | CMP 116 (1.13), (1.15), (1.21), pp. 5–7 | 4C₄B₀²e^{32κ₁}ε₃ ≤ 1; "e^{32κ₁}ε₁ smaller than an absolute constant" | 559.70 (with T12) | COMPUTED |
| **T11** | **polymer activity ≤ 1** | **CMP 116 (2.28), pp. 18–19** | **2E₀ε₁C₁α₄⁻¹α₆⁻¹M^q e^{C₂κ₁}e^{5κ} ≤ 1** | **978.05** literal; 737.69 with (1.27) relaxed (κ = 1); 2181.50 at κ = 3; 2572.52 with (1.28) read at d = 1; 137.87 if 7·8 meant 7.8 | **COMPUTED; prefactor EXISTENTIAL** |
| **T12** | **fluctuation tail against entropy** | **CMP 116 (2.31), pp. 18–19** | **(1/20)γ₂ε₁²/γ² ≥ 4κ; e^{−γ₂ε₁²/(20γ²)} ≤ ε₂** | **γ ≤ ε₁(γ₂/(80κ))^{1/2}** | **READ** |
| T13 | complete model (δ_k in place of ε₁ in T11) | CMP 119 (1.8), p. 247 | δ_k = g_kA₁p₀(g_k) | 1043.76 (p₀ = 10), 1064.26 (p₀ = 13) | COMPUTED |
| T14 | ℝ-operation tree bound | LFR II (1.93) p. 388; α of (1.68) p. 377 | α^{1/3} ≤ e^{−(1+β)κ2d} | 998.89 together with T11 (κ = 1) | COMPUTED |
| T15 | large-field function | CMP 119 pp. 245–246; (2.4) p. 255 | ε_k = g_kA₀(log g_k^{−2})^{p₀}, p₀ ≥ 5r, r ≥ 2, "A₀ sufficiently large" | ε ≥ 2 = diam SU(2) for 3.109 < β < 2.03·10³⁸: 38.31 (p₀ = 10), 48.56 (12), 53.82 (13); +2.6 at A₀ = 10 | COMPUTED |
| T16 | analyticity near large fields | LFR I (1.83)–(1.87), p. 197 | |𝔸₀| < O(1)B₃²B₅M⁶ε_k inside the analyticity radius | with T17 | READ |
| T17 | large-field suppression against region entropy | LFR II (1.87)–(1.89), p. 387 | 2(1 + β₀)⁻¹p₀(g) ≥ O(1)3(100M)^dR^{d+2}; T′_k1 ≤ e^{−2p₀(g)/(1+β₀)} | pinched with T16: 101.87 (M = 27), 133.30 (M = 729) at r = 2; 44.98–73.61 at fixed R = 1; the entropy alone 27.80–39.25 | COMPUTED |
| T18 | positivity in a large-field cube | LFR II (1.7)–(1.9), p. 358 | O(1)(M⁶R_kε_k + e^{−R_k}) ≤ γ₀/(2d(100M)^{d+1}) | 111.09–161.93 | COMPUTED |
| T19 | boundary term | LFR II (1.6), p. 357 | 3B₃M₀A₀²p₀²(g)e^{−R}(100M)⁴ ≤ 1 | not binding (R ≥ (log g⁻²)²) | COMPUTED in form |
| T20 | N-window of the ℝ-operation | LFR I (1.94) p. 198; LFR II (1.29) p. 363 | ((2p₀ + dr₀)/ln L)·ln log g⁻² ≤ N ≤ O(1)(log g⁻²)^ν, ½ν ≤ p₀ − p₁ − 1 | not binding | READ |
| T21 | small quotients | LFR I (1.38) p. 185, p. 186 | 9B₃(A₁/A₀)(p₁/p₀)(1 + β₀) and 8B₃γA₁p₁(γ) "arbitrarily small" | not binding beside the rows above | EXISTENTIAL constants |
| F | floor of the method class | §6 | P(χ²₃ ≥ 2p²) ≤ z_c(20) ⇒ β ≥ (2.23213/a)² | 0.40 (a = √2, β ≥ 2.49); 0.70 (a = 1); 1.74 (a = 0.3); 2.70 (a = 0.1) | inputs COMPUTED; necessity ESTIMATED |

## 8. THE BOTTLENECK, AND THE LADDER OF LEMMAS UNDER IT

THE BOTTLENECK IS T11 WITH T12 (CMP 116 (2.28) and (2.31)), fed by T6–T8. CMP 116 localises the fluctuation integral by COMPLEX
decoupling parameters |s(Δ)| ≤ e^{κ₁} (p. 5) and buys the decay e^{−κ₁} per cube by Cauchy's formula. The price is paid on every
propagator built with those parameters (B₀e^{16κ₁}: short walks touch up to 2⁴ cubes) and hence on every nonlinear estimate downstream —
e^{32κ₁} in the minimiser's fixed point (1.15), e^{7·8κ₁} on the quadratic form (1.40). The polymer activities therefore carry ε₁e^{C₂κ₁}
with C₂ ≥ 56 and must be at most 1, while the cutoff's own Gaussian tail needs γ ≤ ε₁(γ₂/(80κ))^{1/2}. With κ₁ ≥ 20.068 (T6):

  log β_B ≥ 2·56·κ₁ + ln(80κ/γ₂) + 2 ln(2E₀C₁M^q/(α₄α₆)),   i.e.   β_B ≥ 10^{978.05} × (existential prefactor).            (8.1)

Every reading of the printed inequalities keeps this astronomical: 10^{280.8} from the mildest of them (T9), 10^{737.7} with κ₁ optimised
freely against (1.27)'s entropy, 10^{1043.8} in the complete model, 10^{2181.5} at κ = 3. NO UPPER BOUND on β_B can be read from the
papers: the prefactor in (8.1), κ₀, M(κ), a₀, a₁, δ₀, E₀, C₁ and q are existential. β_B cannot be 3–5 with computed constants: evaluated
on its own printed inequalities, Bałaban's induction closes no lower than β = 10^{978}.

THE LADDER (each lemma removes one rung; the next rung is computed):
 (L1) LEMMA RD — REAL DECOUPLING. CMP 116 §§1–2 with real interpolation parameters s ∈ [0, 1] and the Brydges–Kennedy /
   Abdesselam–Rivasseau forest formula, the decay taken from the walk expansion's own e^{−δ₀d} (CMP 95 (1.110), CMP 116 (1.7)) instead of
   from Cauchy on |s| ≤ e^{κ₁}: activities ≤ poly(B₀, C₀, M, M₁)·ε₁·e^{−cδ₀M d(Y)}. It deletes 2C₂κ₁ ≥ 2248 from log β_B. The next rungs are
   then LFR II (1.93) — the tree bound α ≤ e^{−24(1+β)κ}, ESTIMATED 10^{22.7}–10^{64.9} for κ = 1–3 under the reading α ∝ ε₁ of (1.68) —
   and the large-field architecture, 10^{101.9}–10^{161.9} at r = 2 (T17, T18).
 (L2) LEMMA LF — LOCAL LARGE FIELDS. Replace the large-field bookkeeping of LFR I–II (regions inside 100MR_k-cubes, R_k ≥ (log g⁻²)^r with
   r ≥ 2, the suppression 2p₀(g)/(1 + β₀) charged against O(1)(100M)^dR^{d+2} per region) by a bound whose loss is O(log g⁻²) per link
   adjacent to a large plaquette, with p(g) = A(log g⁻²)^{1/2+η} at fixed localisation size. It deletes T15–T18 (≥ 10^{27.8} even at
   fixed R, from the (100M)^{2d} entropy alone).
 (L3) THE FLOOR. What remains is F, β ≥ 4.98/a² with a the small-field radius the machinery supports, plus the explicit
   cluster-expansion constants: ESTIMATED 10²–10⁴ for a between 0.05 and 0.3.
So a fully constant-tracked Bałaban-type renormalisation group, redesigned at both rungs, is ESTIMATED to close no lower than β ~ 10²,
and the middle of the window is at least [3–4, ~10²]: some 1.5 decades that no small-field/large-field step crosses.

## 9. THE NEXT OBJECT

(N1) LEMMA RD, FOR THE PAGE. For the constrained Gaussian dμ_{C^{(k)}} with Bałaban's background-dependent random-walk propagators
(CMP 95, 99) and the interaction V_k(Y) of CMP 116 Lemmas 1–2: a localised cluster expansion with real parameters whose activities obey
|H(Z)| ≤ (K_RD ε₁)^{n(Z)} e^{−cδ₀M d(Z)}, K_RD polynomial in B₀, C₀/δ₀, M, M₁. FALSIFIER: a step of CMP 116 §1 that needs the s-dependence
of the nonlinear fixed points D, A₀ ((1.12)–(1.17)) analytically off the real segment; the real forest formula needs only ∂_s of those
fixed points, which the implicit-function theorem bounds with the contraction constants of (1.13) and (1.15) — polynomial once the
e^{16κ₁} is gone. INSTRUMENT: the derivation on the page against CMP 116 pp. 3–21, then `bin/m6_thresholds*.py` re-run with C₂κ₁ → 0 to
certify the new bottleneck row.
(N2) THE FLOOR AT THE BLOCKED FIELD. Replace the bare-plaquette variance g²/2 of §6 by the variance of Bałaban's blocked plaquette under
the constrained Gaussian (a finite Fourier sum from CMP 109's averaging operator and CMP 95's propagator) and z_c(20) by the radius of the
block-plaquette dependency graph: the exact floor of the method class.
(N3) THE MIDDLE ITSELF. No small-field rung reaches below ~10², so the crossing [3–4, ~10²] belongs to the exact engines (their spin cap
grows like β^{1/2}) or to one computer-assisted renormalisation step with certified constants near β = 10²; the decisive first
computation is the spin cap at which the character engine's truncation error is certified at β = 100.

## 10. CROSS-FIELD IDENTIFICATIONS

(U1) THE BOTTLENECK IS CAUCHY'S PRICE. Analytic interpolation buys decay e^{−κ₁} per unit at the cost e^{O(κ₁)} on every bound that
depends on the interpolated objects; constructive field theory replaced it by real-parameter forest formulas (Brydges–Kennedy 1987;
Abdesselam–Rivasseau 1995). The 978 decades are that technical choice, measured on Bałaban's own inequalities.
(U2) THE FLOOR IS THE LOVÁSZ LOCAL LEMMA. The large-field/small-field split is an instance of the local lemma: bad events are large
plaquettes, the dependency degree is 20, and Shearer's bound — the optimal local-lemma criterion — is the convergence radius of the
large-field polymer gas. The algorithmic local lemma (Moser–Tardos resampling of bad events) is the dynamical counterpart of the
large-field renormalisation.

## 11. LEDGER (this agent's rows)

| Item | Status | Where |
|---|---|---|
| eleven PDFs re-hashed, equal to M3b §0 | COMPUTED | §2 |
| order of choices (κ₀, M(κ), ε's and α's, then γ) | READ (CMP 109 Thm 3) | §2.6, T4 |
| the CMP 116 chain T6–T12 | READ, every link | §§2.5–2.6, §3 |
| κ₁ ≥ 20.068323 | COMPUTED | §5, T6 |
| β_B ≥ 10^{978.05} × existential prefactor (literal); ≥ 10^{280.8} under every reading | COMPUTED | §§5, 5b, 8 |
| complete model ≥ 10^{1043.8} | COMPUTED | T13 |
| large-field definition vacuous for 3.109 < β < 2.03·10³⁸ (p₀ = 10, A₀ = 1) | COMPUTED | T15 |
| large-field architecture rows 10^{27.8}–10^{161.9} | COMPUTED | T17, T18 |
| floor β ≥ 4.98/a²; 3–5 needs a = 1.00–1.29 (60°–80°) | inputs COMPUTED, necessity ESTIMATED | §6 |
| an upper bound on β_B from the papers | none readable: EXISTENTIAL | §8 |
| the bottleneck | T11 with T12 (CMP 116 (2.28), (2.31)) | §8 |
| Lemma RD, Lemma LF | NAMED, each with its falsifier | §§8–9 |
