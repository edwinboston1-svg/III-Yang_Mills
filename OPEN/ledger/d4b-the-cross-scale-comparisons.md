# D4b — EVERY PLACE BAŁABAN COMPARES COUPLINGS OF DIFFERENT SCALES, AND WHAT THE BOUNDED TRANSIENT COSTS EACH (Edwin Boston III, 2026-10-29, 11:1x EDT by the clock)

> Status: a READING of five published papers, each line named by page and equation, and one DERIVATION (§4, this seat's; Bałaban states none; it needs a second reader). Every row marked COVERED follows from the bounded-transient hypothesis in the form `CouplingTransient.lean` states (compiled 10:30 EDT, nine theorems): for i < j, with x_k = 1/g_k² and c = 8b₀ ln L,
>
> (j − i)(c − ρ) − 2F ≤ x_i − x_j ≤ (j − i)(c + ρ) + 2F.
>
> Its input, Lemma B in the bounded-transient form, is NOT PROVED. The Yang–Mills seat has reduced it to the one-loop power-counting lemma (B1) (ledger §104–§105). So nothing below is a theorem of record. The page says what the transient must deliver and what each of Bałaban's cross-scale lines then costs. Two kinds of line need more than bounded partial sums. The sums over scales need the slope c − ρ > 0. The weighted sums need monotone cutoffs, derived in §4. Bałaban's index k grows toward coarse scales, so i < j means i is the finer scale.

## 1. The question, and the five elementary bounds

The operator's order (11:0x, 29 October): *find and name every other line where couplings of different scales are compared. A comparison of g_i to g_j with no logarithm costs a factor (1 − 2F g_j²)^(−1/2), also harmless.*

Throughout, i < j.

- **(E1) No logarithm.** x_i ≥ x_j − 2F, so g_i ≤ (1 − 2F g_j²)^(−1/2) g_j. This is Bałaban's (2.6) second inequality. His factor 1 + β₀ holds once 2Fγ² ≤ 1 − (1 + β₀)^(−2).
- **(E2) With the step count.** x_i ≤ x_j + (j − i)(c + ρ) + 2F, so g_j ≤ (1 + g_j² β′ (j − i))^(1/2) g_i with β′ = c + ρ + 2F. This is Bałaban's (2.6) first inequality, verbatim.
- **(E3) Logarithms.** First, (log x_j)^p ≤ (1 + 2F g_i²/log x_i)^p (log x_i)^p ≤ (1 + β₀)(log x_i)^p. Second, (log x_i)^p ≤ (1 + g_j² β′ (j − i))^(p/log x_j) (log x_j)^p, which is at most (1 + g_j² β′ (j − i))^β₀ (log x_j)^p once p ≤ β₀ log γ^(−2). This is Bałaban's (2.7), verbatim.
- **(E4) Sums over finer scales of a power of the coupling.** For κ > 2:
  Σ_{j≤n} g_j^κ ≤ (1 − 2F g_n²)^(−κ/2) Σ_{m≥0} (x_n + (c − ρ)m)^(−κ/2) ≤ (1 − 2F g_n²)^(−κ/2) (g_n^κ + 2g_n^(κ−2)/((κ − 2)(c − ρ))).
  This needs c − ρ > 0, not only boundedness. The first step uses x_n + am − 2F ≥ (1 − 2F g_n²)(x_n + am), with a = c − ρ and m = n − j.
- **(E5) Sums weighted by position-dependent cutoffs.** Treated in §4.

## 2. The universe (the census's predicate, universe, instant and digest)

**PREDICATE.** A line (an equation or a sentence) in which couplings at two different scales enter one inequality, identity or sum. Functions of couplings count: ε_j = g_j p₀(g_j), δ_j, δ′_j, p₀(g_j), p₁(g_j), R_j, α_{0,j}, α_{1,j} and log g_j^(−2). Every line that writes the running law itself also counts.

**UNIVERSE.** Bałaban's five four-dimensional papers that carry the running coupling, as the operator downloaded them on 29 October (SHA-256):

| Label | Paper | SHA-256 |
|---|---|---|
| [I] | CMP 109 (1987) 249–301 | `1c2d2e500fd1e6a1a7981fed259cc2354ebcf64e473fd564bfc3f2c4d7dfbe2a` |
| [II] | CMP 116 (1988) 1–22 | `ee39523a0f7b83af958513c7bd6f9c7731934b40355ef5d6b0f7a68ee6d022fc` |
| [III] | CMP 119 (1988) 243–285 | `c629e6280329cca4e038fece68e6c225b82f3f31e61c47596997db82b72ef1df` |
| [IV] | Large Field Renormalization I, CMP 122 (1989) 175–202 | `4002290ab2d69bd425a767c46f3f1403768433d753a7649cdfaf528f45a15fd2` |
| [V] | Large Field Renormalization II, CMP 122 (1989) 355–392 | `80ab1ee09fff0a5b6840a568b72c400a812858425da3200bc5c1c9e2d6941482` |

Six companion papers in hand were NOT scanned:

- Propagators and Renormalization Transformations I and II
- Averaging Operations
- Propagators in a Background Field
- The Variational Problem and Background Fields
- Ultraviolet Stability of Three-Dimensional Lattice Pure Gauge Field Theories (CMP 95–102, 1984–85)

They treat propagators, averages, background fields and the superrenormalizable three-dimensional case. None carries a running four-dimensional coupling.

**INSTANT.** 29 October 2026, 10:1x–11:0x EDT.

**COVERAGE.** Pages read on rendered images:

| Paper | Read | Pages |
|---|---|---|
| [I] | 18 of 53 | 253–266, 278, 292, 297, 298 |
| [II] | 2 of 22 | 9, 15 |
| [III] | 41 of 43 | 244–284 |
| [IV] | 26 of 28 | 176–201 |
| [V] | 38 of 38 | 355–392 |

The other pages were swept on the PDF text layer by two pattern sets, and the line of every hit was read:

- **Sweep 1** (`records/cross-scale/scan_pages.py`): coupling; sequence, monoton, decreas, increas; the threshold functions p₀(·), p₁(·), ε(·); β₀ and "(1 + β"; citations (0.2x), (0.3x); g_k ± 1 and comparison signs; sums over scales.
- **Sweep 2** (`scan_cross.py`, with `show_hits.py` for context): citations of (2.6)–(2.9) and (0.18)–(0.33); "inequalit"; "coupling"; "β-function"; n − m, k − j, j − N, N₀.

**KNOWN BLINDNESS.** The text layer destroys formulas. A line can still be missed if all four of these hold: it compares couplings only as a formula; its page was not read on image; it cites neither (2.6)–(2.9) nor (0.18)–(0.33); and it uses none of the swept words. The pages carrying that risk:

- [I] 249–252, 267–277, 279–291, 293–296 and 299–301: the one-step small-field analysis of its §§2–5, and front and back matter.
- [II] the twenty pages other than 9 and 15: the one-step cluster expansion.
- [III] 243 and 285.
- [IV] 175 and 202.

**DIGEST.** The five papers above. The three sweep scripts and the per-page reading log are in `records/cross-scale/`, with their digests in the timestamp manifest.

## 3. The lines, by kind

### A. The running law and its position-dependent form

These are definitions. The transient is a statement about their partial sums, so there is nothing to cover.

| # | Where | The line |
|---|---|---|
| A1 | [I] p. 255 (0.18)–(0.19) | 1/g₀² = 1/g₁² + β₁(g₀), "a finite difference approximation … of the differential equation (d/ds)(1/g²) = −β(g)". A_{k+1} is built from A_k at g_k. |
| A2 | [I] p. 256 (0.20) | The recursion at every k, cited by [III] p. 255 as the source of (2.6)–(2.9). |
| A3 | [I] p. 261 (1.6) | The scale-k action carries Σ_{j<k} β_{j+1}(g_j) A(U_k). The sum telescopes to 1/g₀² − 1/g_k². |
| A4 | [I] p. 292, (4.45) and the paragraph after | The sum over j of the marginal terms "has not a uniform bound" until β_j is defined as their coefficient. This is the origin of the running. |
| A5 | [I] p. 298 | "We write β_j as explicitly dependent on g_{j−1}, although it depends also on all preceding coupling constants." This is history dependence: Lemmas B and C must hold uniformly over histories. It is the page-level match to the Yang–Mills seat's §104 form f(k) = c_W − c(S_k). |
| A6 | [III] p. 253 (1.27) | The running law at step one, position-dependent: 1/g₀² = 1/g₁²(x) + β₁(g₀)φ₁(x). |
| A7 | [III] p. 259 (2.24)–(2.25) | 1/g²_{j−1}(x) = 1/g_j²(x) + β_j(g_{j−1})φ_j(x). E_k carries every scale's counterterm β_j(g_{j−1})A(φ_j, U_k). |
| A8 | [III] p. 279 | The coupling constant renormalization at step k + 1: subtract β_{k+1}(g_k)A(φ_{k+1}, U_{k+1}). g_k^(−2)(·) is replaced by g_{k+1}^(−2)(·), "defined by the equation (2.24) with j = k + 1". |
| A9 | [IV] p. 189 (1.60)–(1.62) | The position couplings g_k^(n)(·) of the preliminary integrations, set against g_j. C_k^(n+1) carries A(1/(g_k^(n+1)(·))² − 1/(g_k^(n)(·))², U^(n+1)). |
| A10 | [V] p. 359 (1.14); p. 365 (1.33) | The split A(1/(g″_k(·))², ·) = (1/g_k²)A + A(1/(g″_k(·))² − 1/g_k², ·). The reset: 1/(g_k(·))² = 1/(g″_k(·))² on Z^c and 1/g_k² on Z. |

### B. The profile as a hypothesis, and its citations

| # | Where | The line | Under the transient |
|---|---|---|---|
| B1 | [I] p. 258 (0.31) | The profile: 1/g² + β log ≤ 1/g_k² ≤ 1/g² + β′ log. | SHIFTED: 1/g² + (c − ρ)(K − k) − 2F ≤ x_k ≤ 1/g² + (c + ρ)(K − k) + 2F. Every use below absorbs the ±2F. |
| B2 | [I] Theorem 1 (p. 259), Theorem 3 (p. 264) | The only hypothesis is the window 0 < g_k ≤ γ. p. 259: "we do not assume any special asymptotic behavior … like asymptotic freedom". | No cross-scale hypothesis. |
| B3 | [III] Theorem 1 (p. 262) | Assumes "(I.0.33)". | MIS-CITATION: [I] has no (0.33); its §0 ends at (0.32). The context identifies the profile (0.31). |
| B4 | [V] Theorem 1 (p. 355) | Stated with the window only. The text cites "(0.31) [II]". | MIS-CITATION: [II] in [V]'s reference list is CMP 116, and the profile is [I]'s (0.31). |
| B5 | [III] p. 255 | "The inequalities follow from the renormalization group equations (0.20) [I], and from the properties of the β-functions." | In Bałaban's derivation the master inequalities rest on per-step positivity. Group C replaces it. |
| B6 | [III] p. 244 | The bare coupling "behaves asymptotically as (a + b log ε^(−1))^(−1/2)". So the first step's large-field factor "controls a large number of steps, but this number is a small fraction of the total number of steps". This is why the R-operation exists. | COVERED: 1/g₀² ∈ [x_K + (c − ρ)K − 2F, x_K + (c + ρ)K + 2F], the same asymptotics. |
| B7 | [III] p. 246 | A second threshold choice that would use the profile. | Not adopted by Bałaban. |

### C. The master inequalities ([III] pp. 255–256), n > m

| # | The line | Under the transient |
|---|---|---|
| C1 | (2.6) first: g_n ≤ (1 + g_n²β′(n − m))^(1/2) g_m ≤ (1 + β₀)(n − m)^(1/2) g_m | COVERED verbatim with β′ = c + ρ + 2F (E2). |
| C2 | (2.6) second: g_m ≤ (1 + β₀) g_n | **The comparison with no logarithm.** (1 − 2F g_n²)^(−1/2) ≤ 1 + β₀ once 2Fγ² ≤ 1 − (1 + β₀)^(−2) (E1). |
| C3 | (2.7) first: (log g_n^(−2))^p ≤ (1 + β₀)(log g_m^(−2))^p | COVERED (E3). |
| C4 | (2.7) second: (log g_m^(−2))^p ≤ (1 + g_n²β′(n − m))^β₀ (log g_n^(−2))^p ≤ (1 + β₀)(n − m)^β₀ (log g_n^(−2))^p | COVERED verbatim (E3). |
| C5 | (2.8) first: ε_n ≤ (1 + β₀)(n − m)^(1/2) ε_m | From C1 and C3. The constant becomes (1 + β₀)², renamed. Bałaban's single factor used exact monotonicity of log g^(−2). |
| C6 | (2.8) second: ε_m ≤ (1 + β₀)²(n − m)^β₀ ε_n | From C2 and C4. COVERED; the factor with no logarithm enters once. |
| C7 | (2.9) first: R_n ≤ L R_m | From C3, since the R_j are powers of L by definition (2.5). |
| C8 | (2.9) second: R_m ≤ (L + 1)(n − m)^β₀ R_n | From C4. |
| C9 | "Similar inequalities hold for other constants, which will be introduced later" (p. 256): δ_j = g_j A₁/A₀ p₀(g_j) ([III] p. 265), δ′_j = g_j A₁ p₁(g_j) ([IV] p. 183), α_{0,j} = g_j C₀(log g_j^(−2))^(q₀) and α_{1,j} = g_j C₁(log g_j^(−2))^(q₁) ([III] (2.28) p. 259) | Each is g times a power of log g^(−2), so the same two lines apply, at cost (1 − 2F g_n²)^(−1/2) and 1 + β₀. |

### D. The uses (each reduces to C1–C9)

| # | Where | The line | Reduces to |
|---|---|---|---|
| D1 | [III] p. 256, after (2.9) | Nested determining sets Ω₀ ⊃ … ⊃ Ω_j with dist(Ω_n, Ω^c_{n−1}) ≥ L^n ξ M₁. The field V_{j−1} satisfies \|∂V_{j−1} − 1\| < O(L²)ε_{j−1}. | C5/C6 |
| D2 | [III] p. 261 (2.34)–(2.39) | The analyticity space Ũ_j^c. On the shell X ∩ (Ω_n \ Ω_{n+1}) the radii are (1 − β(1 − 2^(−(j−n))))α_{0,n} and α_{1,n}, with β = 1/4 admissible: each shell at its own scale. | C9 |
| D3 | [III] p. 264 (2.48)–(2.49) | The logarithmic vacuum-energy terms of every scale j ≤ k are "controlled" by the small factors of the scale-k Wilson action. | C3/C4 |
| D4 | [III] p. 264 (3.1) | \|V_{k+1}(∂p′) − 1\| < 2L²ε_k | C5/C6, one step |
| D5 | [III] pp. 265–266 (3.2)–(3.8) | The step-(k+1) restrictions (ε_{k+1}, δ_k) make χ_{Λk} and χ_k equal to 1 on Ω̃_{k+1}. | C5/C6, one step |
| D6 | [III] pp. 267–268 (3.12)–(3.13), (3.17)–(3.19) | Uses of (2.8) and (2.9). | C5–C8 |
| D7 | [III] p. 270, before (3.26) | k₁ is defined by L^(−(k−k₁)) M R_j ≤ L, and "for j ≤ k₁ the cubes of the partition are contained in L-cubes". | C7/C8 |
| D8 | [III] p. 271 (3.26)–(3.27); p. 277 | The position coupling against the uniform one: "supp(g_k^(−2)(·) − g_k^(−2)) ⊂ Z_k … the large values … are suppressed by the exponential decay of H_k". | §4 |
| D9 | [III] p. 277 | "The analyticity domains become smaller after each step, but the difference is very small and exponentially decreasing in the number of steps." | C9 |
| D10 | [III] pp. 282–284 (3.68) | \|V′ − 1\| < 11d²ε_n(L^jL^(−n))² + dM(n − j + 2)ε_n(L^jL^(−n))². The factor (n − j + 2) is of the (2.8) kind. | C5/C6 |
| D11 | [IV] p. 178 (1.2)–(1.9) | The last N one-step operations, each with its own scale's restrictions: ε_j, ε_{j+1}, 2δ_j, \|A_j\| < g_j^(−1)δ_j, and the Wilson factor at g_j. "We have to compare them with other characteristic functions." | C1/C2, C5/C6 |
| D12 | [IV] p. 179 (1.10)–(1.14) | N₀ is the smallest integer with L^(−N₀+1) M R_{k−N₀+1} = M; "either there is exactly one such integer, or there are two". | C7 |
| D13 | [IV] p. 181 (1.22)–(1.23) and χ^(n) | Shells at consecutive scales, ε_h(L^{k−h}η)² and ε_{h+1}(L^{k−h−1}η)², with factors 1 − β(1 − 2^(−m)). | C5/C6, one step |
| D14 | [IV] p. 182 (1.24) | ε_{k₀}, …, ε_j on successive shells with L₀^(2(j−k₀−1)), "2 ≤ L₀ < L/2". | C5, one step |
| D15 | [IV] p. 185 (1.38) | ε_{j+1} ≤ (1 + β₀)ε_j, explicit. | C5 |
| D16 | [IV] p. 186 (1.46) | (1 + β₀)(1 + (j − i)^(1/2))ε_i, explicit. | C5 |
| D17 | [IV] p. 187 (1.52) and after (1.54) | (1.52): ε_{j+1} ≤ (1 + β₀)ε_j inside ((1 + β₀)(1 + αβ)L₀²/L² + 2αβ/(2 − β)), with "β₀ ≤ 1/2, β ≤ 1/2, L₀ < (1/2)L". After (1.54): "we have to replace the function (g_k^(n)(·))^(−2) in the Wilson term of the action by g_j^(−2), the term with the difference (g_k^(n)(·))^(−2) − g_j^(−2) is put into the interaction". | C5; §4 |
| D18 | [IV] p. 188 (1.57) | Uses of (2.8) and (2.9). | C5–C8 |
| D19 | [IV] pp. 190–191 (1.65)–(1.69) | "a descending sequence for increasing n, if β ≤ 1/4 and L₀² ≤ L/3". | C5, C9 |
| D20 | [IV] p. 192 | "δ′_j ≤ (1 + β₀)²(k − j)^β₀ δ′_k ≤ (1 + β₀)² N₀^β₀ δ′_k … N₀ = O(log g_k^(−2))". "L^(N₀−1) = R_{k−N₀+1} ≤ (L + 1)(N₀ + 1)^β₀ R_k". The powers of L₀ are "unessential logarithmic contributions to the constants α_{0,j}, α_{1,j}, ε_j". | C2·C4, C8, C9 |
| D21 | [IV] p. 193 (1.75) | \|∂V_k − 1\| < 2L₀^(2N₀) ε_k < 2L(L + 1)N₀^(−1) R_k ε_k | through D20 |
| D22 | [IV] p. 198 (1.94) | δ′_k against ε_h with h = k − N: (1 + β₀)N^(1/2)(A₁p₁(g_h))/(A₀p₀(g_h)). Also "N ≤ O(1)(log g_k^(−2))^ν ≤ O(1)(1 + β₀)(log g_h^(−2))^ν". | C1, C3 |
| D23 | [IV] p. 199 | Uses of (2.8) and (2.9). | C5–C8 |
| D24 | [IV] p. 200 (1.98) | ε_kη² is converted to ε_j(L^{k−j}η)² with the factor 2L^(−(k−j)). L₀^(−2(N₀−1)) ≤ L₀² R_k^(−α₀), with α₀ = log L₀²/log L, via R_k ≤ L R_{k−N₀+1}. | C5, C7 |
| D25 | [V] p. 361 (1.20) | "bounds are a bit more difficult and larger, because of the many scales … We have assumed here that N ≤ R_k". U⁰_{k,Z} is regular "for the sequence {Ω″_j} … with the constant O(1)B₃²B₅M⁵ε_k". | C5/C6, C7/C8 |
| D26 | [V] p. 362 (1.23) | Uses of (2.8) and (2.9). | C5–C8 |
| D27 | [V] p. 363 (1.28)–(1.29) | The factor N^((d−1)β₀), from R_{k+1} and the scale-h domains set against R_k. | C8 |
| D28 | [V] p. 364 (1.31) and the text after | The factor N^(4β₀). Also "(1/(g″_k(·))² − 1/g_k²) is bounded by O(1)(k − j) on Ω″_j \ Ω″_{j+1}". | C8; §4 |
| D29 | [V] p. 366 | "1/(g″_k(·))² − 1/g_k² = O(N) ≤ O(R_k) on the support of ζ". The factor N^(2+4β₀). The Wilson coefficient is used as positive. | §4, C8 |
| D30 | [V] p. 368 (1.47) | Three comparisons in one line: (a) 1/(g″_k(·))² ≤ 1/g_k² + O(k − j); (b) ε_j ≤ (1 + β₀)²(k − j)^β₀ ε_k; (c) Σ_j e^(−½δM(h−j))(1 + h − j)^(1+β₀). | (a) §4; (b) C6; (c) the polynomial factor from C6/C8 is beaten by the exponential, so no growth condition is needed |
| D31 | [V] pp. 380–381 (1.73)–(1.75) and after | Per large-field domain, O(1) log g_j^(−2)\|Z_j\| and factors at g_j. ε_m and δ′_m against p₀(g_j) and p₁(g_j) for j − N ≤ m ≤ j. | C3/C4, C6 |
| D32 | [V] p. 382 | R_{j−N+1} ≤ (L + 1)N^β₀ R_j | C8 |
| D33 | [V] pp. 384–385 (1.80)–(1.83) | R_n ≤ L R_j | C7 |
| D34 | [V] pp. 386–387 (1.85)–(1.89) | Applications of (2.7), (1.86) among them (the Yang–Mills seat's earlier item). | C3/C4 |
| D35 | [V] pp. 388–389 (1.92), (1.95) | Uses of (2.8) and (2.9). | C5–C8 |

### E. Sums over scales of a power of the coupling (these need c − ρ > 0)

| # | Where | The line | Under the transient |
|---|---|---|---|
| E1 | [III] p. 260 (2.31) and the paragraph after | \|R^(j)(X, (U, J))\| ≤ g_j^(κ₀) exp(−κd_j(X)); "The sum over j is controlled by g_j^(κ₀)". | (E4) |
| E2 | [III] p. 263 (2.44)–(2.46) | Σ_{j=1}^{n} g_j^(κ₀) < g_n^(κ₀−6), "for κ₀ ≥ 7 and g sufficiently small". | COVERED by (E4): Σ ≤ (1 − 2F g_n²)^(−κ₀/2)(g_n^(κ₀) + 2g_n^(κ₀−2)/((κ₀ − 2)(c − ρ))) < g_n^(κ₀−6) for γ small. The cost is the factor with no logarithm to the power κ₀, and the slope c − ρ > 0 is required. |

Coupling-free sums over scales are not comparisons: [I] (0.25)–(0.26) p. 257 and [III] (2.43), (2.45), (2.47)–(2.48) pp. 263–264 are all geometric in the scale difference.

### F. Sums weighted by position-dependent cutoffs

[III] (2.24)–(2.25) p. 259, pp. 271 and 277; [IV] p. 187; [V] pp. 364–368. Treated in §4 below.

### G. Single-scale lines that a sweep flags, named so the census closes

- [I] p. 257 (0.24)–(0.26): coupling-free.
- [I] p. 263 (1.17)–(1.19): absolute α₀ and α₁; E^(j) is "a C^∞-function of g_{j−1} ∈ [0, γ], (or analytic)".
- [I] p. 266 (2.9) and its remark: the alternative restriction g_k/γ_k ε₁.
- [I] p. 297 (5.42): "the fundamental equality defining the β-function".
- [III] p. 264 Corollary 3.
- [III] p. 282 (3.61).
- [V] p. 377 (1.68)–(1.69).
- [V] p. 390 (1.100).

## 4. The weighted sums: a derivation (this seat's; Bałaban states none; to be checked)

The difference D_k(x) := 1/g_k²(x) − 1/g_k² is, by A7,

D_k(x) = Σ_{j=1}^{k} β_j(g_{j−1})(1 − φ_j(x)),

and between resets it sits inside every line of group F. If its weights 1 − φ_j(x) could oscillate in j, the bounded partial sums of the transient would not bound D_k. The negative steps of an oscillating transient would accumulate. The inputs that rule this out are all on Bałaban's pages:

- **(a)** [III] p. 254 (2.1): Ω₁ ⊃ Λ₁ ⊃ Ω₂ ⊃ Λ₂ ⊃ … ⊃ Ω_k ⊃ Λ_k.
- **(b)** [III] p. 265 (3.2)–(3.5): Ω_{k+1} ⊂ (Z′_k^{~8})^c. That is four layers of LMR_{k+1}-cubes around Z′_k (the domain Z′_k^{~4}), one more (^{~5}), and three more in (3.5). Z_k = Λ_k^c ⊂ Z′_k. Also Λ_{k+1} ⊂ Ω_{k+1} by (3.20), p. 269.
- **(c)** [III] p. 256 (2.9) at n − m = 1: R_k ≤ (L + 1)R_{k+1}. The R_j are powers of L, so R_k ≤ L R_{k+1}. An LMR_{k+1}-cube of the scale-k lattice is therefore at least as wide as an MR_k-cube.
- **(d)** [III] p. 259: φ_j ∈ C₀^∞(Λ_j), and φ_j = 1 on Λ_j^{~−1}, which is Λ_j with one layer of the scale-j cubes removed.
- **(e)** [IV] p. 179 (1.12): after an R-operation the new sequence {Ω″_j} is admissible, that is, nested. [V] p. 365 (1.33): the reset makes the difference zero on Z.

**The geometric inequality.** dist(Λ_{k+1}, Λ_k^c) is at least eight layers of LMR_{k+1}-cubes, which is at least eight layers of MR_k-cubes. That is more than one layer. So supp φ_{k+1} ⊂ Λ_{k+1} ⊂ Λ_k^{~−1} = {φ_k = 1}. Hence φ_{k+1} ≤ φ_k everywhere, and **j ↦ φ_j(x) is non-increasing.**

**Abel summation.** Let w_j = 1 − φ_j(x), which is non-decreasing in [0, 1], with w₀ = 0. Let T_i = Σ_{j=i}^{k} β_j = x_{i−1} − x_k. Then

D_k(x) = Σ_{i=1}^{k} (w_i − w_{i−1}) T_i.

The weights are non-negative and sum to w_k ≤ 1. The transient gives T_i ∈ [(k − i + 1)(c − ρ) − 2F, (k − i + 1)(c + ρ) + 2F]. So:

- **D_k(x) ≥ −2F everywhere.**
- **D_k(x) ≤ (k − j + 1)(c + ρ) + 2F on the j-th shell**, where φ_i(x) = 1 for all i < j.

**What this gives.**

- 1/g_k²(x) ≥ 1/g_k² − 2F, so g_k(x) ≤ (1 − 2F g_k²)^(−1/2) g_k. This is the operator's factor, now at a point.
- The Wilson coefficient stays positive while 2F g_k² < 1, which is what [V] p. 366 uses.
- The large-field factor exp(−p₀²/(2g²)) becomes exp(−(1 − 2F g_k²)p₀²/(2g_k²)).
- [V] p. 364's O(1)(k − j) becomes O(1)(k − j) + 2F.
- After an R-operation the argument repeats on the new admissible sequence, by (e).

**If it fails.** Without monotone cutoffs the same summation gives only |D_k(x) − (the smooth part)| ≤ 2F · TV(j ↦ φ_j(x)), and that is not bounded in k. So the monotonicity is load-bearing.

**Falsifier.** A configuration of large-field regions in which (3.2)–(3.5) leave fewer than one scale-k layer between Λ_{k+1} and Λ_k^c, giving a point x with φ_{k+1}(x) > φ_k(x).

## 5. For Lemma C, quoted and not adjudicated

The Yang–Mills seat's page check (ledger §102 bis and §102 ter): is E^(k+1)'s analyticity on complexified configurations re-established with a k-uniform radius?

- [II] p. 15, just before (2.14): "Thus the activities in (2.13), and the whole sum E^(k+1)(X), are analytic functions of (U, J), on the space U^c_{k+1}(X, α₀, α₁). This is the analyticity statement in the inductive assumptions." The pieces are analytic on a larger space, "with constants α′₀, α′₁ much bigger than α₀, α₁, therefore we can restrict them".
- [I] p. 263: E^(j)(X, g_{j−1}, U, J) "is defined and analytic on the space U_j^c(X, α₀, α₁), with some positive, absolute constants α₀, α₁ (i.e., constants independent of X and j). … It is a C^∞-function of g_{j−1} ∈ [0, γ], (or analytic), with a positive, absolute γ."
- [I] p. 266: "Another possibility is to take g_k/γ_k ε₁ instead of ε₁, where γ_k = C log(L^kε)^(−1) with C sufficiently large. It has the advantage that the functions E^(j), β_j are analytic functions of the effective coupling constants, but it has some disadvantages in perturbative calculations also. We have formulated the implications of both possibilities in the inductive description."
- [III] p. 259 (2.28): in the complete model the radii are α_{0,j} = g_j C₀(log g_j^(−2))^(q₀) and α_{1,j} = g_j C₁(log g_j^(−2))^(q₁). [III] (2.34)–(2.39) shrinks them on each shell by 1 − β(1 − 2^(−(j−n))). [III] p. 277: "The analyticity domains become smaller after each step, but the difference is very small and exponentially decreasing in the number of steps."

**A reading for the Yang–Mills seat to check.** The question is which of these radii the field-Cauchy step of Lemma C (ii) needs.

- With [I]'s absolute α₁, the second field derivative along iCB is bounded by sup|E| ⟨|CB|²⟩/α₁². Then ½g² sup|β″| = O(g²).
- With [III]'s α₁ ∝ g (log g^(−2))^(q₁) in the same unscaled field, the same estimate gives O((log g^(−2))^(−2q₁)), not O(g²).
- That weaker bound still falls below any fixed ρ as γ → 0. It suffices if all CouplingTransient needs from Lemma C is a per-step remainder below ρ.

## 6. Verdict

- Every cross-scale comparison found in the five papers reduces to (E1)–(E5).
- Under the bounded transient, each is COVERED. The comparisons with no logarithm cost (1 − 2F g²)^(−s/2), where s is the power of g. The logarithmic ones cost 1 + β₀. Both are absorbed by taking γ small: 2Fγ² ≤ 1 − (1 + β₀)^(−2) and p ≤ β₀ log γ^(−2). The profile becomes the shifted profile, ±2F.
- Two kinds need more than bounded partial sums. The sums over scales ([III] (2.31), (2.44)–(2.46)) need the slope c − ρ > 0. The weighted sums need monotone cutoffs, derived in §4 from Bałaban's own nesting and margins.
- **No line found needs per-step positivity of the β-function.**
- Two mis-citations: [III] Theorem 1's "(I.0.33)", and [V]'s "(0.31) [II]".
- All of it is conditional on the transient, that is, on Lemma B in the bounded-transient form, which is open.
