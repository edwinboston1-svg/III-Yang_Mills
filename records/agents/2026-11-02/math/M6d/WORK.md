# M6d — THE ULTRAVIOLET HALF'S CONSTANTS AFTER M6c: LEMMA LF′, THE HISTORY HALF OF LEMMA PS, TOWARD A SUFFICIENT THRESHOLD

Proof agent M6d, 2026-11-02. Work directory `.../scratchpad/math/M6d/`. Appended as the work proceeds; nothing above a line is
edited after it is written except by a dated correction below it. Labels: READ (on the rendered page image, today), PROVED (full
proof here), PROVED GIVEN [named input], COMPUTED (certified interval arithmetic, record named), FLOOR (a necessary condition on the
printed/derived inequalities, constants at their most favourable), STAKE (written before a computation), OPEN (attempted; the
obstruction named). Normalisation as M6/M6b/M6c: Wilson's β = 1/g_Bał², X := log β = log g⁻², log natural, log₁₀ written out.

## 0. Sources read in full before deriving

`math/MATH_BRIEF.md` (corrected 10:2x, integrity list read); `math/M6/WORK.md` (§§0–12, all); `math/M6b/WORK.md` (§§0–17, all);
`math/M6c/WORK.md` (§§0–18.5, all) with `bin/m6c_thresholds_d.py` (copied to `bin/`) and records `rec/thresholds_run.2026-11-02{c,d}.txt`;
`math/M3e/WORK.md` (§§0–8, all) and `handback.txt`; `math/M3g/WORK.md` (§§0–10, all) and `handback.txt`.
READ ON IMAGE TODAY (M6's and M3b's renders): CMP 119 pp. 255, 256, 258, 261, 269; LFR II pp. 358, 387. Text layers
(`M3b/src/cmp119.txt`, `cmp122a_lfr1.txt`, `cmp122b_lfr2.txt`, formulas destroyed) used ONLY to locate passages.

## 1. The plan (deep-think synthesis, before deriving)

DECISION. (a) Settle LF′'s falsifier by a CENSUS of every use of R_k in CMP 119, LFR I and LFR II (text layer to locate, image to
read), each classified as DECAY (e^{−R} beats something), COST (R enters as a factor the rest must pay), WAITING TIME (R = N, the
R-operation's N), GEOMETRY (minimal sizes, N₀). (b) State and prove LF′ in the form the architecture consumes, from CMP 102 Theorem 1 on
Bałaban's own domain sequences, M3g's Corollary D (domain change) and M3e's Theorem 190 (decay of δ𝓗/δB). (c) RE-AUDIT M6c's engine
for a structural defect found while reading LFR II p. 387: the large-field function p₀(g) is ONE free function shared by the rows
(1.88) [p₀(g) ≥ O(1)·1.5(100M)^dR^{d+2}], T16 [M⁶ g p₀(g) ≤ 1] and T18 [O(1)M⁶R_k g p₀(g) ≤ γ₀/(2(d−1)(100M)^d)]; M6c optimised it
ROW BY ROW (T18c used p₀(g) = X^{10} although (1.88) forces p₀(g) ≥ 1.5(100M)^4X^{12}); a floor over rows sharing a free function must
optimise it JOINTLY. Compute the joint floor (certified) for Bałaban's architecture and for LF′; correct the ladder. (d) Item 2: read
CMP 116 pp. 7–9 and CMP 109 §3 ((3.54)) for the origin of Lemma 1's M^{q₁}; price the history terms per site if the inputs allow.
(e) Item 3: a constant census — every constant entering the rows, with its source, its status (EXPLICIT value / EXPLICIT formula of
named constants / COMPUTABLE by a named procedure not run / UNTRACKED in print), carried into a symbolic sufficiency engine; the
sufficient threshold as a function of the untracked constants; say how far it gets.
WHY THIS OVER THE RUNNER-UP (proving LF′ as an abstract Dirichlet-hole variational theorem from scratch): in Bałaban's architecture the
holes ARE the large-field regions Ω_j^c and CMP 102 is already posed on such domains; whether the corridor can be small is decided by
what the corridor is USED for, which only the census settles.
WHAT MOVED THE PLAN (reading before deriving): LFR II p. 384 (text layer, then image) — "the domain S^K(Z) … satisfies the conditions (i),
(ii), with N = R_j": the corridor size is ALSO the R-operation's waiting time; and p. 387 (1.88), whose p₀(g) must be polynomially large
in M — the pinch with T18 that M6c's row-by-row optimisation missed.
KILL-SWITCH. If (1.88)'s p₀(g) is not the function in ε_k = g_kp₀(g_k) of (1.7) (CMP 119 (2.4)), the joint row is void.
(Checked: CMP 119 (2.4) p. 255 READ, ε_j = g_jA₀(log g_j⁻²)^{p₀} = g_jp₀(g_j); LFR I p. 175 (M6) and LFR II (1.89) p. 387 READ use the same p₀(g).
The kill-switch does not fire.)

## 2. THE CENSUS OF THE CORRIDOR SIZE R — EVERY USE IN CMP 119, LFR I, LFR II, CLASSIFIED (LF′'s falsifier)

Method. Text layers searched for every pattern of the corridor size (`MR_k`, `M₂R_k`, `exp(−R`, `R_k^…`, `N = R`, `N ≤ R`, `(log g`, `N₀`):
record `rec/rcensus_textlayer.2026-11-02a.txt` (84 hits: CMP 119 36, LFR I 20, LFR II 28; script `bin/rcensus.sh`), plus the hits the
pattern missed and the reading found (LFR II p. 380, p. 389; LFR I p. 187). Each load-bearing hit READ ON IMAGE (M6's/M3b's renders and
mine: CMP 119 pp. 255, 256, 258, 261, 269; LFR I p. 198; LFR II pp. 358, 365, 380, 387). Kinds: DECAY = e^{−cMR} (or e^{−R}) must beat a
factor; COST = R enters a factor the rest must pay (smaller R only helps); WAIT = R is the R-operation's waiting time N; BOOK = an
inequality that uses R ≥ log g⁻² to simplify; GEOM = sizes of regions, N₀.

| # | Site (READ unless marked text) | What R does | Kind | Requirement on R |
|---|---|---|---|---|
| R1 | CMP 119 (2.5) p. 255; p. 245 | R_j = least L^r ≥ (log g_j⁻²)^r, r ≥ 2 | definition | — (the object under test) |
| R2 | CMP 119 p. 249 (text) | U₁U′₁⁻¹ − 1 < O(1)B₃ε exp(−LM₂R₁), "much smaller than δ₀ if M₂R is large enough" | DECAY | LM₂R ≥ ln(O(1)B₃A₀/A₁): a constant |
| R3 | CMP 119 (3.7) p. 266 (M3e §2.4) | H_{k,□} ≤ B₃(4δ_k + e^{−δ2M₂R_k}30d²L²B₃(1+β₀)ε_k) | DECAY | 2δM₂R ≥ ln(30d²L²B₃A₀/A₁): a constant |
| R4 | CMP 119 p. 269 | H^{(k)} ≤ O(1)ε_k e^{−R_k} "hence by any positive power of g_k"; consumed by the change of variables (1.22) [III], whose output goes into B-terms bounded by (2.42) B₀e^{−κd} (p. 261) | DECAY | O(1)e^{−R} ≤ c·A₁/A₀ (the shift stays inside δ_k): a constant. "Any power of g" is a remark; no consumer needs it |
| R5 | LFR I pp. 185, 187, 197 (text; p. 198 image) | e^{−MR}22d²ε against δ′_j ∝ (p₁/p₀)ε; B₃e^{−δ2LM₂R_h}11d²ε_h < αε_h | DECAY | MR ≥ (p₀ − p₁)ln log g⁻² + c; R ≥ ln(11d²B₃/α) |
| R6 | LFR II (1.6) p. 357 (M6 T19) | 3B₃M₀A₀²p₀²(g_k)e^{−R_k}(100M)⁴ < 1 | DECAY | R ≥ ln(3B₃M₀A₀²p₀(g)²(100M)⁴): THE LARGEST DECAY REQUIREMENT |
| R7 | LFR II p. 359 (text), p. 362 (M6) | e^{−½δM₁R_k} "suppresses all powers of log g_k⁻², and all powers of M"; g_k²O(1)A₀²B₃²B₅M^{d+5}R_k^{d+1}p₀²e^{−R_k} small | DECAY (+COST R^{d+1}) | R ≥ ln(M^{d+5}R^{d+1}p₀(g)²) + c |
| R8 | LFR II (1.29) p. 363 (M6) | g_k²L^{−(d−1)N}N^{(d−1)β₀}O(1)A₀²B₃²B₅M^{d+5}R_k^{d−1}p₀²: "L^{−N} ≤ (log g_k⁻²)^{−v}, N ≥ (v/log L)loglog g_k⁻², v ≥ 2p₀ + dr₀" | WAIT (lower end) + COST | N ≥ [(d+5)ln M + (d−1)ln R + 2 ln p₀(g)]/((d−1)ln L) |
| R9 | LFR I (1.94) p. 198 | B₃(1+β₀)N^{1/2}(A₁/A₀)(p₁/p₀)ε_h + L^{−N}N^{1/2}O(1)B₃³B₅M⁶ε_h < αε_h; "N ≤ O(1)(log g_k⁻²)^ν, ½ν ≤ p₀ − p₁ − 1"; "N sufficiently large" | WAIT (both ends) | N ≥ [6 ln M + ln(2O(1)B₃³B₅/α) + ½ln N]/ln L; N^{1/2} ≤ αA₀p₀(g)/(2B₃(1+β₀)A₁p₁(g)) |
| R10 | LFR II (1.80) p. 384; p. 385 | "the domain S^K(Z) … satisfies the conditions (i), (ii), with N = R_j"; "doing at most R_j further steps"; "K = R_{j+1}" | WAIT: N := R | ties R to R8–R9's window: R ≥ N_min |
| R11 | LFR II (1.20) p. 361 (text) | O(1)(100MR_k)^dN²ε³ ≤ g³O(1)M^dR_k^{d+2}A₀³p₀³: "We have assumed here that N ≤ R_k" | COST (+ WAIT upper end N ≤ R) | none beyond N = R |
| R12 | LFR II p. 380 | "every large field domain Z_j contributes the constant O(1)log g_j⁻²·Z_j ≤ O(1)log g_j⁻²(MR_j)^d d′_j(Z_j) ≤ O(1)M^dR_j^{d+1}d′_j(Z_j)" | BOOK (log g⁻² ≤ R) | none: keep X := log g⁻², per-step cost O(1)X M^dR^d d′ |
| R13 | LFR II (1.80)–(1.81) pp. 384–385; (1.87)–(1.88) p. 387 | κ_j(Z) ≥ Σ O(1)M^dR^{d+1}d′_n(S^{n−j}Z); 2(1+β₀)⁻¹p₀(g) ≥ O(1)3(100M)^dR^{d+2} | COST (R^{d+2} = R^{d+1} times R12's R) | smaller R only helps; with R12 kept: X·R^{d+1} |
| R14 | LFR II p. 389 (text) | −2(1+β₀)⁻¹p₀(g) + 1 + 2(100R_k)^d ≤ −¼p₀(g) | COST | smaller R helps |
| R15 | LFR II (1.7) p. 358 | O(1)(M⁶R_kε_k + e^{−R_k}) ≤ γ₀/(2d(100M)^{d+1}) | COST (M⁶R_kε_k) + DECAY | R ≥ ln(2d(100M)^{d+1}/γ₀) + c |
| R16 | LFR II p. 366 (text) | (1/g″² − 1/g²)-term ≤ (100MR_k)⁴(O(1)B₃B₅M⁵ε_k + O(1)B₃ε_k)²·…, "small for g_k small enough" | COST | weaker than R15 (fewer powers of M) |
| R17 | LFR I p. 177 (M6); LFR II pp. 381, 387 | regions in cubes of 100MR_k; ten layers of LMR_{j+1}-cubes per step (operation S); touching regions share a 20MR_n-cube | GEOM | none |
| R18 | LFR I p. 179, p. 191 (text) | N₀: L^{−N₀+1}MR_{k−N₀+1} = M; "N > N₀, in fact N much greater than N₀" | GEOM | N₀ = 1 + log_L R < N = R for every R ≥ 2 |
| R19 | CMP 96 (2.59); M3e Thm 189; M3g (3.132) | RM large for the multiscale sums: ¼αδ₀RM > 2d log c₀(½α) + 1; RM ≥ 6S_max ln L/δ₀; RM > (d−2)ln L/(s*κ₁) | DECAY (scale conversion) | R ≥ O(1)/(δM): below 1 at M ≈ 250 except through the rate δ (§6) |

THEOREM C (THE CENSUS) — PROVED GIVEN the completeness of the census (text layer searched exhaustively for the patterns; every hit
classified; the load-bearing hits read on image). No step of CMP 119, LFR I or LFR II uses R_k ≥ (log g_k⁻²)^r for anything but (a) DECAY
against polylogarithmic or polynomial factors (R2–R7, R15, R19), (b) the WAITING TIME N = R (R8–R11), whose window has lower ends of order
ln ln g⁻² (R8) and ln M (R9), and (c) the BOOKKEEPING step R12, which spends R ≥ log g⁻² to write X·R^d as R^{d+1} and is removed by
keeping X. The COSTS (R11, R13–R16) only favour small R. Hence (2.5) may be replaced by
   R_j ≥ R_min(g_j, M) := max{R₆, N₈, N₉},                                                                              (2.1)
   R₆ := ln(3B₃M₀A₀²p₀(g)²(100M)⁴),  N₈ := [(d+5)ln M + (d−1)ln R + 2 ln p₀(g)]/((d−1)ln L),  N₉ := [6 ln M + ln(2O(1)B₃³B₅/α) + ½ln N]/ln L,
with N := R_j, provided (1.80)–(1.88) carry X·R^{d+1} (R12 kept) in place of R^{d+2}. THE FALSIFIER DOES NOT FIRE: the R-operation's
N-window (R8–R10) is the second, non-decay use of R, and its lower end is O(ln ln g⁻² + ln M), the order LF′ asked for; its upper end (R9)
constrains p₀ − p₁, not R.
WHAT THE CENSUS SHOWS THAT M6c §7.3 DID NOT. The decay requirement R₆ contains p₀(g)², and (1.88) (R13) forces p₀(g) ≥ 1.5(100M)^dXR^{d+1}:
p₀(g) is POLYNOMIALLY LARGE IN M, not polylogarithmic. So R_min ≈ 12 ln(100M) + 10 ln R + 2 ln X ≈ 187 at M ≈ 245 (stake §4): of order ln M
with a large coefficient. And the same (1.88) is the row M6c's engine never paired with T18 (§3).

## 2a. LEMMA LF′ — THE VARIATIONAL PROBLEM WITH HOLES, IN THE FORM THE ARCHITECTURE CONSUMES

STATEMENT. Let the large-field regions be unions of MR-cubes with R ≥ R_min (2.1), and the small-field domains Ω_j their complements minus
the corridors (CMP 119 §§1–3 with (2.5) replaced by (2.1)). Then (i) the minimizer U_k(V) of CMP 102 exists and is unique on every such
domain sequence; (ii) the influence of the excluded set on the propagators G, G′, (QGQ*)⁻¹, H, G̃, H₀ between y and y′ is at most the
operator's own bound times e^{−δ_eff(d(y,O^c) + d(y′,O^c))/2}, O the corridor's inner region; (iii) its influence on the background field
(δ𝓗/δB) decays like e^{−¼δ_eff d}; δ_eff := min(δ₀, δ₁) the common rate (§6); (iv) every e^{−R_k} of CMP 119 and LFR I–II is supplied by
(ii)–(iii) at a corridor of MR lattice units with δ_eff M ≥ 4.
PROOF. (i) CMP 102 Theorem 1 (p. 279, READ by M6) is stated for domain sequences Ω₀ ⊃ … ⊃ Ω_k of unions of M₁L^jη-blocks with
(L^jη)⁻¹dist(Ω_j^c, Ω_{j+1}) > RM₁ (CMP 102 (1)), where that R is CMP 102's own constant (a (2.59)-type condition, R19), not a function of g;
the large-field holes of CMP 119 are such complements whatever the corridor's size, so Theorem 1 applies verbatim. (ii) is M3g's
Corollary D (domain change from two walk expansions; M3g §6), with O the corridor's inner region. (iii) is M3e's Theorem 190 (rate ¼δ₀).
(iv) A corridor of MR lattice units gives e^{−¼δ_eff MR} ≤ e^{−R} when δ_eff M ≥ 4; Bałaban's e^{−R_k} (e.g. e^{−δ2M₂R_k} ≤ e^{−R_k},
CMP 119 p. 266) are of this kind. ∎ STATUS: PROVED GIVEN CMP 102 Theorem 1, M3g Corollary D, M3e Theorem 190, and Theorem C.
WHAT LF′ IS NOT. It is not the plaquette-scale version (holes = single large plaquettes; the domain then not a union of big blocks):
CMP 102's Theorem 1 does not cover that geometry. That version belongs to LF IN FULL (M6c §7.5), together with per-plaquette positivity.

## 3. THEOREM J — A FLOOR OVER ROWS SHARING A FREE FUNCTION IS JOINT; THE PINCH (1.88) × (1.7) THAT M6c's ENGINE MISSED

3.1 THE DEFECT. A floor is min over the design (L, M, R, the large-field function P(g)) of max over the rows. M6c minimised over L and M
jointly but fixed P per row: T15 and T18c used P(g) = X^{10} (CMP 119: p₀ ≥ 5r = 10, A₀ = 1), T17 used the pinch of (1.88) with T16. Since
max_rows min_design ≤ min_design max_rows, M6c's 124.30 is a TRUE necessary condition but not the strongest, and where two rows pull one
free function in opposite directions the gap is large.
3.2 THEOREM J — PROVED (elementary, on READ inequalities). Write P(g) := ε_k/g_k (= p₀(g) of CMP 119 (2.4), A₀ included; the same function
in LFR I p. 175, LFR II (1.6), (1.7), (1.88), (1.89), all READ). Floor conventions as M6/M6c: every O(1), B₃, B₅, M₀, A₀ = 1, γ₀ = 1, β₀ → 0.
 (1.88) printed (LFR II p. 387):      P(g) ≥ 1.5(100M)^dR^{d+2};
 (1.88) architecture (R12 kept):      P(g) ≥ 1.5(100M)^d X R^{d+1}    (= the printed one when R = X, weaker when R > X, the true cost when R < X);
 T18c (LFR II (1.7)–(1.9), comb-gauge Poincaré, M6c §7.4, §18.4):   M⁶R·g·P(g) ≤ 1/(2(d−1)(100M)^d).
Any admissible P satisfies both, hence g ≤ [3(d−1)(100M)^{2d}M⁶R^{d+3}]⁻¹ (printed) or [3(d−1)(100M)^{2d}M⁶XR^{d+2}]⁻¹ (architecture):
   J_pr:  X/2 ≥ ln(3(d−1)) + 2d ln(100M) + 6 ln M + (d+3)ln R,      J_ar:  X/2 ≥ ln(3(d−1)) + 2d ln(100M) + 6 ln M + ln X + (d+2)ln R.   (3.1)
J dominates T17 (the pinch with T16: T18c's condition is T16's times 2(d−1)(100M)^dR) and T18c (P ≥ X^{10} is weaker than (1.88)), and T15
(ε ≤ 2) is weaker still. ∎ The joint row is the large-field row of record; d = 4 below (3(d−1) = 9).
3.3 VARIANTS. B (Bałaban's corridor R = X², the least R allowed by (2.5) with r = 2, real-valued — rounding R up to a power of L only raises
the floor): B_pr = J_pr, B_ar = J_ar (the floor of record: the more favourable reading). LF′ (R = R_min of (2.1), solved jointly with the
least P allowed by (1.88)): R₆ = ln(3P²(100M)⁴), P = 1.5(100M)⁴XR⁵ ⇒ R − 10 ln R = ln(6.75(100M)⁸X²), the larger root (the smaller
branch R < 10 is infeasible: R − 10 ln R ≤ 1 there); N₈, N₉ checked below it.
3.4 LEMMA LP — THE LARGE-FIELD BUDGET IS QUADRATIC (exact pricing on the large-field side) — PROVED GIVEN LFR II p. 380 and the monotone use
of the budget in (1.79)–(1.95). READ (LFR II p. 380): "The function χ^c_j(P_j) … yields the factor exp(−γ₀(1/(2g_j²))(B₃⁻¹ε_j)²(LM₂R_j)^{−d}|P_j|)
… (in this factor we may take γ₀ = 1/2)": per large-field LM₂R_j-cube the suppression is exp(−(γ₀/(2B₃²))P(g)²) (the fluctuation-type
factors χ^c_j(Q_j), χ^{(j−1)c}(R_j) carry (2δ_j)², δ_j² with δ_j = (A₁/A₀)ε_j, i.e. the same form with (A₁/A₀)² ≤ 1). Bałaban's budget in
(1.79)–(1.88) is 2P(g) per region (the factor exp(−2p₀(g_{j(Z)}))), i.e. he spends (γ₀/(2B₃²))P² ≥ 2P and keeps the linear part. The
budget enters (1.79)–(1.88) only as an additive credit against the κ-increments and (1.89), (1.95) only as the smallness of the
large-field activities: every use is monotone in the budget. So (1.88) holds with (γ₀/(2B₃²))(1+β₀)⁻¹P(g)² (× (A₁/A₀)² for a region
carrying only fluctuation-type large fields) in place of 2(1+β₀)⁻¹P(g). ∎ FLOOR (γ₀ = B₃ = 1, A₁ = A₀): ½P² ≥ 1.5(100M)^dXR^{d+1}, i.e.
P ≥ (3(100M)^dXR^{d+1})^{1/2}. With T18c:
   J_LP:  X/2 ≥ ln(2(d−1)) + ½ln 3 + (3d/2)ln(100M) + 6 ln M + ½ln X + ((d+3)/2)ln R,                                                (3.2)
and in LF′ the decay requirement becomes R₆ = ln(3P²(100M)⁴) = ln(9(100M)⁸XR⁵): R − 5 ln R = ln(9(100M)⁸X).
WHY BAŁABAN DID NOT NEED IT: at his R = X^r the polylog budget p₀(g) = A₀X^{p₀} with p₀ ≥ 5r was "large" and the linearisation lost only a
polylog; once (1.88)'s cost is seen to be polynomial in M (the joint row), the square root of the budget is worth tens of decades (§5).

## 4. STAKES FOR RUN a (written before `bin/m6d_thresholds.py` exists; nothing here edited after)

Hand arithmetic at M = 245 (L = 5) unless stated; X in decades of log₁₀ β.
a1 B_pr (R = X²): X/2 = 116.06 + 14 ln X ⇒ X ≈ 399.9 ⇒ 173.7. Optimum over L within ±0.5 of 173.5 (M_free varies 233–261).
a2 B_ar: X/2 = 116.06 + 13 ln X ⇒ X ≈ 387.0 ⇒ 168.1 (optimum ±0.5).
a3 B_LP (R = X², Lemma LP): X/2 = 95.99 + 7.5 ln X ⇒ X ≈ 276.3 ⇒ 120.0 at M = 245; X_small(5) = 123.85 binds there, so the optimum moves to
   L = 6 (M = 247–249, X_small ≈ 84–85): ≈ 120.2.
a4 LF′_ar: R_min = R₆ ≈ 186.9 (N₈ ≈ 44, N₉ ≈ 23 below it); X/2 = 116.06 + 6 ln R + ln X ⇒ X ≈ 306.3 ⇒ 133.0 (optimum ≈ 133.0, the
   large-field row binding at every L ≥ 4).
a5 LF′_LP: R_min ≈ 112.1; X/2 = 95.99 + 3.5 ln R + ½ln X ⇒ X ≈ 230.5 ⇒ 100.1 at M = 245; X_small(5) binds (123.85) so the optimum is at
   L = 6: ≈ 100.2.
a6 C (LF in full) unchanged 48.97446 at L = 12; D (PS, q₁ = 0) unchanged 13.10410 — reproduced by my copy of the engine.
a7 the large-field row's composition at L = 5 (B_ar): 2·[ln 9 + 8 ln(100M) + 6 ln M] = 232.1 nats = 100.8 decades from the per-M-cube
   bookkeeping (constants and M¹⁴·10¹⁶), the rest 67.3 decades from X¹³ (the polylog powers of R = X² and X).

## 5. RESULTS OF RUN a (record `rec/thresholds_run.2026-11-02a.txt`, rc = 0, 160 s; §4 unedited)

a6 HELD: my engine reproduces M6c run d exactly (L = 5: X_small 123.8501579, T18c 124.3001177; L = 6: 83.7926442, 124.3771964; L = 12: 48.9744559,
   124.8997684; C = 48.97446, D = 13.10409 at L = 12).
a1 HELD: B_pr optimum 173.60520 decades at L = 4, M = 244 (staked 173.5 ± 0.5; the optimum is at L = 4, where X_small = 128.270 sits below the
   joint row, not at L = 5).
a2 HELD: B_ar optimum 168.03329 at L = 4, M = 244 (staked 168.1 ± 0.5).
a3 HELD: B_LP optimum 120.08364 at L = 6, M = 247 (staked ≈ 120.2 at L = 6).
a5 HELD: LF′_LP optimum 100.16981 at L = 6, M = 247 (staked ≈ 100.2 at L = 6); R_min = R₆ = 112.15 (staked 112.1); N₈ ≤ 25.0, N₉ ≤ 19.7.
a7 HELD: at L = 5 the per-M-cube bookkeeping is 100.805 decades of B_ar, the polylog 67.282.
a4 REFUTED, AND THE REFUTATION IS A DEFECT IN THE ENGINE, NOT IN THE STAKE: the run gives LF′_ar = 131.613 (L = 4) with R_min = 143.9, against
   the staked 133.0 with R_min ≈ 186.9. Cause: 3P²(100M)⁴ with P = 1.5(100M)⁴XR⁵ is 6.75(100M)^{12}X²R^{10}; §3.3 wrote (100M)⁸ and
   `R_LFp_ar` copied it, while the stake's hand arithmetic carried 12 ln(100M) = 121.28. The (LP) branch (9(100M)⁸XR⁵) is right.
D(q₁ = 1) = 15.14149 at L = 12, M = 261 (COMPUTED; NOT STAKED in §4 — the hand value 15.142 was in my notes, not on the page).

## 6. DATED CORRECTION (2026-11-02, after run a; nothing above edited) AND STAKE FOR RUN b

6.1 §3.3's LF′ corridor equation reads R − 10 ln R = ln(6.75(100M)^{12}X²) (not (100M)⁸): R₆ = ln(3P²(100M)⁴), P = 1.5(100M)⁴XR⁵. The run-a
column LFp_ar is void; every other column of run a stands.
6.2 STAKE b1 (run b = run a with `R_LFp_ar` corrected, nothing else changed): LF′_ar optimum ≈ 132.99 decades at L = 4, M = 244, R_min = R₆ ≈ 186.9
(KJ(244) = 116.000; X/2 = 116.000 + ln X + 6 ln R ⇒ X ≈ 306.2); N₈, N₉ below R₆.

## 7. RESULTS OF RUN b (`bin/m6d_thresholds_b.py`, record `rec/thresholds_run.2026-11-02b.txt`, rc = 0; §6.2 unedited)

b1 HELD: LF′_ar optimum 132.98652 decades at L = 4, M = 244; R_min = R₆ = 186.944 at L = 5 (X = 306.33), 187.76 at L = 12; N₈ ≤ 43.6, N₉ ≤ 22.1:
   the decay requirement R₆ binds at every L, as Theorem C said. Every other column equals run a's.

THE LADDER, CORRECTED (every entry a certified FLOOR; the lemma named is what the step assumes; records a, b):
| Scheme | Floor, log₁₀ β_B ≥ | At | Status of what it assumes |
|---|---|---|---|
| M6c's best floor (rows optimised one at a time) | 124.30010 | L = 5, M = 245 | a valid but WEAKER necessary condition (Theorem J) |
| Bałaban's architecture, joint row, printed (1.88) | 173.60520 | L = 4, M = 244 | Theorem J PROVED; RD, KP, M_w, Theorems B, P as M6c |
| Bałaban's architecture, joint row, architecture form (R12 kept) — THE FLOOR OF RECORD | 168.03329 | L = 4, M = 244 | same |
| + Lemma LP (quadratic large-field budget) | 120.08364 | L = 6, M = 247 | LP PROVED GIVEN LFR II p. 380 |
| + Lemma LF′ (corridor R_min, Bałaban's linear budget) | 132.98652 | L = 4, M = 244 | LF′ PROVED GIVEN CMP 102 Thm 1, M3g Cor. D, M3e Thm 190, Theorem C |
| + LF′ + LP | 100.16981 | L = 6, M = 247 | both |
| + LF in full (no large-field rows) | 48.97446 | L = 12, M = 261 | OPEN (M6c §7.5) |
| + PS, history half priced per site (q₁ = 0) | 13.10410 | L = 12, M = 261 | OPEN (§8) |
| + PS, history half as printed (q₁ = 1, §8) | 15.14149 | L = 12, M = 261 | PS quadratic half PROVED GIVEN (M6c); q₁ = 1 READ |

WHAT THE CORRECTION MEANS. (i) The architecture's large-field side is not a polylog problem: its joint row is 100.8 decades of per-M-cube
bookkeeping ((1.88)'s (100M)^d, T18's (100M)^d Poincaré, LFR I (1.83)'s M⁶, the 9) plus 67.3 decades of polylog (X¹³ from R = X² and the
normalization X) at L = 4–5. (ii) LF′ removes the polylog (−35.0 decades) but not the M-polynomial: M6c's "+ LF′ → 72.58" set the
large-field threshold to g·A·X^{1/2} and dropped T17, both forbidden inside the architecture by (1.88). (iii) Pricing the large plaquette at
its Wilson weight (LP) is worth 48.0 decades at Bałaban's corridor and 32.8 at LF′'s: the square root of a polynomial-in-M budget.
(iv) Below 48.97 everything is small-field (M^{16} → PS), and the history half's printed M¹ costs 2.04 decades.

## 8. ITEM 2 — THE HISTORY HALF OF LEMMA PS: WHERE LEMMA 1's M^{q₁} COMES FROM, ITS VALUE, AND THE OBSTRUCTION TO PRICING IT PER SITE

8.1 READ (CMP 116 p. 7 (1.24), p. 8 (1.29), M3c's renders; CMP 109 pp. 276, 280 my renders `render/cmp109_{276,280}.png`; CMP 109 p. 275 text
layer). (1.24): |(1.23)| ≤ 8B₀C₁e^{16κ₁}α₂⁻¹g_k|B|E₀(α₁/α₃)⁵(L^jη)⁵·e^{−(κ₁−1)M⁻⁴|Y₀∖□̃⁴|}e^{−κd_j(X)}. (1.29): |Σ(1.23)| ≤ E₀ε₁O(M^q)
exp O(1)κ₁ exp(−(1/16)κ₁d_k(Y)), "with absolute constants O(1), q. The constant q is a small, nonnegative integer, which can be easily calculated
from the conditions on α₁, α₂, α₃." So Lemma 1's M-dependence is entirely α₂⁻¹(α₁/α₃)⁵ (the other factors of (1.24)–(1.28) — 2(6L)⁴ for
□′ and j, e for (1.27), 3·2³ for (1.28) — carry no M). The conditions:
 (α-1) CMP 109 p. 275: "We assume that α₀, α₁ are chosen so that Mα₀, Mα₁ are still small" (the axial gauge on M-cubes);
 (α-2) CMP 109 (3.31) p. 276: |𝐀|, |∇^η𝐀|, ‖𝐀‖_{1,β} < α₂ on □₀ — the complex field (tζ̃ + t_□ζ_□)H_k replaced by 𝐀; the background's own
       H_{k+1} has the same bounds "with α₂ replaced by B₃O(1)Mα₀";
 (α-3) CMP 109 p. 280: Lemma 4 needs the complexified configuration in U^c_j(X, α₀, α₁): "if B₃α₃ < ½α₁ then this and (3.37) imply the
       conditions (i), (ii)"; "we have assumed 2B₃α₃ ≤ βL⁻²α₀"; (3.54) "|B| < α₁L^jη"; and "This differentiation yields a factor O(1)α₂⁻¹ε₁".
8.2 PROPOSITION H — q₁ = 1 IN THE PRINTED CONDITIONS — PROVED from (α-1)–(α-3). The complex part of the configuration in Lemma 4 is τB + B′
with B = Q(η𝐀), |𝐀| < α₂, |B′| < α₃; membership in U^c_j(X, α₀, α₁) bounds that complex part by α₁ (condition (iii), CMP 119 (2.39)), so
α₂ ≤ c α₁ and α₃ ≤ α₁/(2B₃); and α₃ ≤ βα₀/(2B₃L²). By (α-1), α₀ = ᾱ₀/M, α₁ = ᾱ₁/M with ᾱ₀, ᾱ₁ small and M-free. Hence
   α₂⁻¹(α₁/α₃)⁵ ≥ (M/(cᾱ₁))·(2B₃)⁵·max(1, L²ᾱ₁/(βᾱ₀))⁵:
the M-power is at least 1, and exactly 1 when the α's are chosen ∝ 1/M with M-free coefficients (the choice (α-1) forces up to constants). ∎
So after Lemma PS (the quadratic half, M-free) the τ-radius of (2.18) still carries M¹ from the history half: q = q₁ = 1, the D-variant row
q ln M → max(2 ln 5, ln M), and D = 15.14149 decades (run a/b), not 13.10410.
8.3 THE PER-SITE ROUTE AND ITS OBSTRUCTION (OPEN, named). The factor α₂⁻¹ is the inverse radius of the t_□-Cauchy formula (the field-scaling
derivative (1.22)–(1.23)): the scaled field t_□ζ_□H_k must stay in the sup-norm ball (3.31) of radius ½α₂ over all of □₀ (11⁴ M-cubes). A
per-site pricing writes ∂_{t_□}E(□₀, ·)|₀ = Σ_x (δE/δ𝐀)(x)(ζ_□H_k)(x) and needs |δE^{(j)}(X)/δ𝐀(x)| ≤ E₀e^{−κd_j(X)}c(x) with Σ_x c(x) M-free,
i.e. Cauchy in the field at ONE bond with an M-free radius. A one-bond change of size r moves the curvature of the six plaquettes through the
bond by ≈ r, and condition (i) of U^c (CMP 119 (2.34): |∂U − 1| < α₀ξ²(L^nξ)⁻²) admits only r ≲ α₀ = ᾱ₀/M; the M-cube condition (ii) ((2.38),
|A| < BCMα₀ in the M-cube's gauge) would admit r ≈ ᾱ₀. The radius ∝ 1/M is therefore forced by the PER-PLAQUETTE radius being tied to the
M-CUBE potential through "potential ≤ M × curvature" in the axial gauge. NEXT OBJECT (Lemma PS-H): analyticity of the history activities,
of CMP 102's minimizer and of CMP 99's propagators on a domain whose curvature radius is M-free while the M-cube potential is NOT small —
the gauge-covariant (curvature-coordinate) form of CMP 99 Theorem 3.4. FALSIFIER: a history polymer whose first variation at one bond grows
with M at fixed curvature. With it q₁ = 0 and D = 13.10.

## 9. ITEM 3 — TOWARD A SUFFICIENT THRESHOLD: WHERE M3e's AND M3g's CONSTANTS ENTER, AND WHAT THEY FORCE

9.1 THE MECHANISM (PROVED, from M6c §6 and M3g §3, §5). Every floor row is evaluated at M = M_free, and M_free is forced by the WALK DECAY
RATE of the propagators: (M1) δM ≥ (12/√2)a (a = κ_u + ln 4, the per-cube decay the format needs), (M2) δM/3 ≥ 1 + 2κ + 4 ln(LM), (M3)
δM ≥ κ, where δ is the decay rate of the walks of H, G̃, H₀ (CMP 116 (1.7)); M6c evaluated them at δ = ½ (CMP 95: 2δ₀ = min(δ₀′/3, M₀⁻¹)).
Those walks contain (QGQ*)⁻¹ (H = GQ*(QGQ*)⁻¹, H₀, G̃ = G − GQ*(QGQ*)⁻¹QG; M3e A1), so δ = δ_eff := min(δ₀, δ₁) with δ₁ the rate of
(3.132). M3g proved (3.132) by Combes–Thomas: δ₁ = s*κ₁ − (d−2)ln L/(2RM), κ₁ ≤ κ_T = δ₀/4, s* = min{½, (4C_TC₁′)⁻¹}, C_T = C·c₁(½)L² (C the
kernel constant of G, CMP 99 Theorem 3.3), C₁′ the constant of Theorem L′. And the compression walk expansion of (QGQ*)⁻¹ (M3g §5) needs
‖ℓRℓ⁻¹‖ ≤ C′_R(M⁻¹ + e^{−δ₀M/2}) ≤ ½ with C′_R ∝ C_T·C₁′ (the commutator [T̂, h_□] times ‖T_□⁻¹‖ ≤ 2C₁′): EITHER WAY the PROVED route needs
   M ≳ (12/√2)a · 4C_T C₁′ · 4/δ₀:                                                                                      (9.1)
the decay rate of the averaged propagator, as proved, enters M LINEARLY through the condition number C_T·C₁′ of T̂ = ℓ⁻¹QGQ*ℓ⁻¹.
9.2 THE EXPLICIT PART OF (9.1) (PROVED; the numbers COMPUTED in run c). c₁(α) := Σ_{y′}e^{−αδ₀d(y,y′)} ≤ 12c₀(½α)^d (CMP 96 Lemma 2.1, M3e §2.1),
c₀(α) = Σ_{z∈ℤ}e^{−αδ₀|z|} = coth(αδ₀/2) EXACTLY; at δ₀ ≤ ½ the bound is decreasing in δ₀, so c₁(½) as used is ≥ 12 coth(1/16)⁴. Theorem L′:
C₁′ ≥ (2 + 2d)·C_S·ε⁻²L²·16L²·c_R⁻²·L^d with ε = c_R/(4C′_SL), i.e. C₁′ ≥ 256(2 + 2d)C_SC′_S²L^{6+d}c_R⁻⁴, and Lemma R's constant is
c_R = ⅓ min{¼, κ_A²/2, κ_A²/(8‖A‖²)} ≤ 1/12. Hence, for the record's route,
   M_proved(L) ≥ (12/√2)a(L)·16·c₁(½)L²·256(2 + 2d)L^{6+d}·12⁴·(4/δ₀)·(C·C_S·C′_S²),   δ₀ ≤ ½,                              (9.2)
a LOWER bound on the M any sufficiency proof along M3g's route must take (the untracked factor C·C_S·C′_S² kept as a symbol; evaluated at 1).
9.3 WHY THIS IS THE DECISIVE CONSTANT FOR SUFFICIENCY. The floor rows at M_proved are necessary conditions of the scheme AS PROVED, hence lower
bounds on any sufficient threshold obtained from the record's proofs; the M-dependence differs by rung: the architecture's joint row ∝ 14 ln M
(+X¹³), the small-field row ∝ 16 ln M, the D-row ∝ ln M (q₁ = 1) or ln ln M (q₁ = 0).

## 10. STAKES FOR RUN c (written before `bin/m6d_profile_c.py` exists; nothing here edited after)

c1 At δ = ½ the profile reproduces run b: B_ar 168.03329 (L = 4), C 48.97446, D(q₁=1) 15.14149, D(q₁=0) 13.10410 (L = 12).
c2 M_proved (9.2) with C·C_S·C′_S² = 1: ≈ 8.4·10²³ at L = 4, ≈ 2.3·10²⁹ at L = 12 (c₁(½) = 12·16.0208⁴ ≈ 7.905·10⁵).
c3 The rows at M_proved: B_ar ≈ 790 decades (L = 4); C ≈ 481 (L = 12); D(q₁=1) ≈ 70.1 (L = 12); D(q₁=0) ≈ 14.2 (L = 12).
c4 The profile in δ (M from (M1)–(M3) with δ for ½): B_ar grows by ≈ 30·log₁₀(½/δ)·(14/16)… — staked as: B_ar(δ = 10⁻⁴) ≈ 168 + 2·14·log₁₀(5000)/1 ≈ 271
   decades (14 ln M in X/2, M ∝ 1/δ); C(10⁻⁴) ≈ 49 + 2·8·3.70 ≈ 108; D(q₁=1)(10⁻⁴) ≈ 15.1 + 2·3.70 ≈ 22.5.

## 11. THE CONSTANT CENSUS — EVERY CONSTANT A SUFFICIENT THRESHOLD NEEDS, WITH ITS STATUS AFTER M3e AND M3g

Status: EXPLICIT (a value), FORMULA (explicit in named constants), COMPUTABLE (a named finite procedure, not run), UNTRACKED (existential in
print: "depends on d, L only", "absolute constant", "sufficiently small/large").
| # | Constant | Where it enters the threshold | Source | Status |
|---|---|---|---|---|
| K1 | δ₀, walk decay rate of G′, G | M via (M1)–(M3); every e^{−δ₀·} | CMP 95 Prop. 1.2 ("depending on d only"); 2δ₀ = min{δ₀′/3, M₀⁻¹} | UNTRACKED (floor: ½) |
| K2 | δ₁, rate of (QGQ*)⁻¹ | M via δ_eff = min(δ₀, δ₁) (§9) | M3g §3: s*κ₁ − (d−2)ln L/(2RM), s* = min{½, (4C_TC₁′)⁻¹} | FORMULA of K3–K6 |
| K3 | C, kernel constant of G | C_T = C·c₁(½)L² | CMP 99 Thm 3.3/3.12 (M3g (I2)) | UNTRACKED |
| K4 | c₁(α) = Σ e^{−αδ₀d} | C_T, C₁₈₉, C₁₉₀, ε₃* | CMP 96 Lemma 2.1: ≤ 12c₀(½α)^d, c₀ = coth(αδ₀/2) | EXPLICIT given δ₀ (run c: c₁(½) = 7.905·10⁵ at δ₀ = ½) |
| K5 | C₁′, Theorem L′ | λ_min(T̂) ≥ C₁′⁻¹; s*; (3.132)'s constant 2C₁′L^{d/2−1} | M3g §2.11 | FORMULA ≥ 256(2+2d)C_SC′_S²L^{6+d}c_R⁻⁴ |
| K6 | c_R (Riesz), C_S, C′_S (smoothing) | C₁′ | M3g Lemma R, Lemma S | c_R COMPUTABLE (exact chain Grams, κ_A per L in M3g's record; ‖A‖ the one-step tent Gram), c_R ≤ 1/12 by its formula; C_S, C′_S COMPUTABLE, not computed |
| K7 | B₀, walk constant of H, G̃, H₀ | R = e(1+η)²B₀ (Lemma RD), Lemma PS's B₀²N(δ₀)², M3e's C₁₈₉ | CMP 99 Thm 3.1 ("d, L"); the (QGQ*)⁻¹ factor 2C₁′L^{d/2−1} (M3g) | (QGQ*)⁻¹ part FORMULA; G part UNTRACKED |
| K8 | C₁₈₉, C₁₉₀, ε₃* | CMP 109 (3.9), (3.17), (3.54) → CMP 116 (1.24) → Lemma 1's constant; ε₃* bounds the coarse field | M3e §3.4–3.5 | FORMULA of B₀, B_Π, C_𝔇, K_𝒬, K_J, C_Λ, c₁(¼), L |
| K9 | K₀, C₂, C₄, a₀, a₁, a₃, B₃ | CMP 102 contraction and regularity; C_Λ, K_𝒬; B₃ in α₃ (§8) and in LFR's B-terms | CMP 102 Thm 1, (44), (54), Prop. 4, pp. 291–292 | UNTRACKED |
| K10 | C′₁ (one-step), C₃ = 6C′₁ | C_𝔇 = O(1)C₃ (CMP 102 (73)); L3 (i) of M3g; Lemma 2's C₃ | CMP 98 Prop. 5, (124)–(147), closing condition 16C′₁L⁻⁴α₀ ≤ 1 | COMPUTABLE (complete induction in print, M3g §8) |
| K11 | C₁ of CMP 116 ((1.20): B′ ≤ C₁g_kB) | S1, S2 (the τ-radius), (R), (D) | CMP 116 p. 6 "absolute constant" | UNTRACKED (computable from the definition of B′) |
| K12 | ᾱ₀, ᾱ₁, ᾱ₂, ᾱ₃ (Mα_i) | Lemma 1's α₂⁻¹(α₁/α₃)⁵ = M·(…) (§8) | CMP 109 pp. 275–280 | conditions READ; values UNTRACKED |
| K13 | γ₂, α₄, α₅, α₆, γ₁, C_v | (2.31)'s Gaussian tail, the Mayer radii, (KP-v); C_v in Lemma PS | CMP 116 §2 | α₄, α₆ free; α₅ FORMULA (Lemma RD); γ₂ UNTRACKED; C_v COMPUTABLE (plaquette Taylor coefficients) |
| K14 | E₀ | the inductive normalization | CMP 109 (1.18); p. 21: O(1)C₃ε₁ ≤ ½E₀ | self-consistent (cancels at the floor) |
| K15 | γ₀, B₅, M₀, σ₀, the O(1) of (1.7), (1.87)–(1.88), (1.94); α of (1.93) | T18, (1.88), R₆, N₉, the large-field activity | LFR I–II | UNTRACKED |
| K16 | A₀, A₁, p₀, p₁, R, N | the large-field design | CMP 119, LFR I–II | free; constrained by Theorems C, J and Lemma LP |
| K17 | counts: √7, 91, 11489, 46, R(L), κ_fl, 16, 2(6L)⁴, 3·2³, N(δ₀) ≥ 5 | junctions, entropy, base images, Lemma 1's sums | M6b, M6c, CMP 116 pp. 7–8 | EXPLICIT |

HOW FAR IT GETS. After M3e and M3g, the deepest black box ((3.132), under every propagator CMP 116 decouples) and (189)–(190) are FORMULAS in a
finite list of base constants; the base layer itself — δ₀ and G's kernel constant C (CMP 95, CMP 99 Theorems 3.1/3.3), CMP 102's a₀, a₁,
B₃, C₂, C₄, K₀, CMP 116's C₁ and γ₂, the CMP 109 radii ᾱ_i, and the large-field O(1)'s of LFR I–II — is untracked in print (K1, K3, K9,
K11–K13, K15). A SUFFICIENT certified threshold is computable exactly when those are bounded above; the computable-but-not-computed ones
(c_R at d = 4, C_S, C′_S, C′₁, C_v) are finite procedures. And before any of them is tracked, the record's ROUTE already has a price (§9):
the proved rate of (QGQ*)⁻¹ forces M ≥ M_proved (9.2), and the floor rows at M_proved bound below every threshold provable along that route
(run c).

## 12. RESULTS OF RUN c (record `rec/profile_run.2026-11-02c.txt`, rc = 0; §10 unedited)

c1 HELD: at δ = ½ the profile reproduces run b exactly: B_ar 168.0333 (L = 4, M = 244), C 48.9745, D(q₁=1) 15.1415, D(q₁=0) 13.1041 (L = 12, M = 261).
c4 REFUTED AS STAKED (direction and order right, values low): B_ar(δ = 10⁻⁴) = 285.379 (staked ≈ 271), C(10⁻⁴) = 112.788 (≈ 108), D(q₁=1)(10⁻⁴) = 23.473
   (≈ 22.5). The stake took M ∝ 1/δ; (M2) δM/3 ≥ 1 + 2κ + 4 ln(LM) grows M faster (M(10⁻⁴) = 2.316·10⁶ at L = 4 against the staked 1.22·10⁶),
   and B_ar's 13 ln X feeds back. The full profile (decades): δ = 10⁻²: B_ar 223.04, C 78.67, D(q₁=1) 19.06, D(q₁=0) 13.34; δ = 10⁻⁴: 285.38,
   112.79, 23.47, 13.51; δ = 10⁻⁸: 406.09, 179.73, 32.03, 13.72; δ = 10⁻¹⁶: 641.45, 311.41, 48.71, 13.97.
c2 REFUTED AS RUN, AND THE RUN IS DEFECTIVE TWICE: the run printed c₁(½) = 50 182.946 and M_proved(4) = 2.133·10²³, (12) = 5.769·10²⁸, against
   the staked 7.905·10⁵ and 8.4·10²³, 2.3·10²⁹. (i) The code evaluated c₀(½) = coth(1/8) = 8.0416 where c₁(½) = 12c₀(¼)⁴ needs c₀(¼) = coth(1/16)
   = 16.0208 (its own label says so); (ii) (9.2) as written in §9.2 carries 16·c₁(½), but 1/δ₁ = 4C_TC₁′/κ₁ ≥ 4C_TC₁′·(4/δ₀) gives 4·c₁(½)
   with (4/δ₀) separate. The stake used both correctly; the two defects nearly cancel (net factor 3.938 in M). c3 is therefore judged on run d.

## 13. DATED CORRECTION (2026-11-02, after run c; nothing above edited) AND STAKE FOR RUN d

13.1 (9.2) reads M_proved(L) ≥ (12/√2)a(L)·4·c₁(½)L²·256(2 + 2d)L^{6+d}·12⁴·(4/δ₀)·(C·C_S·C′_S²), with c₁(½) = 12 coth(δ₀/8)^d.
13.2 STAKE d (run d = run c's proved-route block with both defects fixed; nothing else changed): M_proved(4) = 2.13271·10²³ × 3.938 = 8.40·10²³ (log₁₀ 23.924),
M_proved(12) = 2.27·10²⁹ (log₁₀ 29.356); proved-route optima: B_ar ≈ 748.0 (L = 3), C ≈ 460.9 (L = 6, if the optimum stays there), D(q₁=1) ≈ 70.07,
D(q₁=0) ≈ 14.165 (L = 12).

## 14. RESULTS OF RUN d (`bin/m6d_profile_d.py`, record `rec/profile_run.2026-11-02d.txt`, rc = 0; §13.2 unedited) — ALL HELD

c₁(½) = 12 coth(1/16)⁴ = 790 534.9365 (coth(1/16) = 16.020827910). M_proved: log₁₀ = 22.4994 (L = 3), 23.9242 (4, staked 23.924), 25.0056 (5),
25.8984 (6), 29.3564 (12, staked 29.356), 31.9428 (20). Proved-route optima (untracked C·C_S·C′_S² = 1): B_ar 748.0314 (L = 3; staked ≈ 748.0),
C 460.8942 (L = 6; staked ≈ 460.9), D(q₁=1) 70.0815 (L = 12; staked 70.07), D(q₁=0) 14.1646 (L = 12; staked 14.165).
READING. Along the record's route ((3.132) by Combes–Thomas, Theorem L′'s constant), every threshold provable is ≥ 10^{748} in Bałaban's
architecture and ≥ 10^{461} with LF in full — whatever the untracked constants are, as long as C·C_S·C′_S² ≥ 1 — while with every named lemma
(D) the route costs only ln M: 70.08 (q₁ = 1) and 14.16 (q₁ = 0) against the floor's 15.14 / 13.10. The deeper the rung, the less the rate
loss matters: D's M-dependence is logarithmic (q₁ = 1) or doubly logarithmic (q₁ = 0).

## 15. CROSS-FIELD IDENTIFICATIONS

(U1) THEOREM J IS THE MIN–MAX (WEAK DUALITY) INEQUALITY, AND THE PINCH IS A PEIERLS WINDOW. A floor over coupled constraints sharing a decision
function must be computed as one optimisation; row by row is a relaxation whose gap here is 43.7 decades (168.03 vs 124.30). The window
itself — the large-field threshold high enough that a large region is rare against its entropy and normalisation over N = R steps ((1.88)),
low enough that the background stays analytic and positive ((1.7)) — is the local-lemma window of M6's floor (U2 there), now with a
POLYNOMIAL-in-M entropy, which is why it costs 100 decades instead of 0.7.
(U2) LEMMA LP IS CHERNOFF AGAINST MARKOV. Bałaban spends a Gaussian tail e^{−P²/2} as a linear budget 2P; using the Gaussian exponent square-roots
every polynomial requirement on P (−48.0 decades at Bałaban's corridor, −32.8 at LF′'s). THE GROUND's certified KP inequality made the same
move when it priced small polymers exactly.
(U3) THE REMAINING M-POWERS ARE TREE-GAUGE CONDITION NUMBERS. The history half's α₂⁻¹ ∝ M (§8) and T18's (100M)^d Poincaré constant both come from
gauges fixed along trees on M-cubes ("potential ≤ length × curvature"); in finite-element exterior calculus tree–cotree gauging has condition
numbers growing with the domain while Hodge-orthogonal (Coulomb) gauging has the optimal ℓ² scaling. Curvature coordinates are the FEEC cure;
(1.88)'s (100M)^dR^{d+1}X is a different mechanism (region volume × waiting time × the per-site Gaussian normalisation).
(U4) THE SUFFICIENCY PRICE IS COMBES–THOMAS'S LINEAR DEPENDENCE ON THE CONDITION NUMBER. s* = (4C_TC₁′)⁻¹ makes the proved rate of (QGQ*)⁻¹ ∝ 1/κ;
Demko–Moss–Smith (1984) and Jaffard (1990) give inverses of banded / exponentially localised positive operators decay ∝ 1/√κ (Chebyshev
approximation), which would halve log₁₀ M_proved; and M3e's toy (μ_Π/μ_G = 0.74) says the object loses only O(1). The sufficiency twin of the
next object is a RATE-PRESERVING decay bound for (QGQ*)⁻¹.

## 16. LEDGER (this agent's rows)

| Item | Status | Where |
|---|---|---|
| census of the corridor size R in CMP 119, LFR I, LFR II (19 uses classified) | READ (load-bearing sites on image), text-layer census `rec/rcensus_textlayer.2026-11-02a.txt` | §2 |
| Theorem C: no step needs R ≥ (log g⁻²)^r; R_min = max(R₆, N₈, N₉); the falsifier (N-window) does not fire; R also = N, the waiting time | PROVED GIVEN the census's completeness | §2 |
| Lemma LF′ (variational problem with holes, architecture form) | PROVED GIVEN CMP 102 Thm 1, M3g Cor. D, M3e Thm 190, Theorem C | §2a |
| Theorem J: the joint large-field row (1.88) × (1.7); M6c's floor not the strongest | PROVED | §3 |
| Lemma LP: the large-field budget is quadratic, (γ₀/2B₃²)P² | PROVED GIVEN LFR II p. 380 and the monotone use of the budget | §3.4 |
| floor of record 168.03329 (L = 4, M = 244); printed form 173.60520 | COMPUTED (runs a, b) | §§5, 7 |
| ladder: + LP 120.08364; + LF′ 132.98652; + LF′ + LP 100.16981; LF in full 48.97446; PS q₁ = 0 13.10410; PS q₁ = 1 15.14149 | COMPUTED on named lemmas | §7 |
| Proposition H: Lemma 1's M^{q₁} = α₂⁻¹(α₁/α₃)⁵ with q₁ = 1 in the printed conditions | PROVED from READ conditions (CMP 109 pp. 275–280) | §8 |
| Lemma PS-H (history half per site) | OPEN: needs curvature-coordinate analyticity; falsifier named | §8.3 |
| the rate mechanism (9.1); M_proved (9.2); proved-route floors 748.03 / 460.89 / 70.08 / 14.16 | PROVED (mechanism); COMPUTED (runs c, d) | §§9, 14 |
| constant census K1–K17; sufficient threshold needs the untracked base layer | READ / classified | §11 |
| refutations printed: a4 (engine defect, §3.3's (100M)⁸), c2 (two defects: c₀(½) for c₀(¼); 16 for 4), c4 (M grows faster than 1/δ) | — | §§5, 12 |
| process note: one `python -` heredoc typed by reflex (the recorded trap); stopped by TaskStop, no process of mine left (census by command line) | — | — |

## 17. DATED CORRECTIONS AND PRECISIONS (2026-11-02, after review; nothing above edited)

17.1 LEMMA LP, THE EXTRACTION READ (LFR II p. 381, M6's render `lfr2_381.png`, READ today): "For each component the above large field factors
yield an exponential factor, which can be estimated by exp(−γ₀ min{½B₃⁻²A₀², 2A₁², A₁²}p₀²(g_j)(d′_j(Z_j^{(i)}) + 1)) ≤ exp(−½γ₀A₁²p₀²(g_j)(d′_j + 1)
− 2p₀(g_j))." So in LFR's notation p₀(g) is the bare power (log g⁻²)^{p₀} (A₀, A₁ separate), the per-component budget is
γ₀·min{½B₃⁻², 2r², r²}·P²·(d′ + 1) with P := ε/g = A₀p₀(g) and r := A₁/A₀, and Bałaban SPLITS it: half (A₁² part) kept against the step's
own cost, the linear 2p₀(g) carried into the large-field index (1.87)–(1.88). Nothing else is charged against the Gaussian factor on p. 381.
CORRECTED STATEMENT OF LP: (1.88) holds with the budget γ₀·min{½B₃⁻², r²}·P²(1+β₀)⁻¹ (at a component with d′ = 0, where the step's own
cost O(1)M^dR^{d+1}d′ of p. 380 vanishes) in place of 2(1+β₀)⁻¹p₀(g). STATUS: PROVED GIVEN LFR II pp. 380–381 (READ) and the monotone use of
the budget. FLOOR CONVENTION, explicit: γ₀ = B₃ = 1 and r = A₁/A₀ ≥ 1/√2, so the budget is ½P². CMP 119 p. 247 assumes A₀ ≫ A₁; Bałaban
himself offers the alternative (LFR I p. 186: "by choosing γ, or A₁/A₀ sufficiently small"), and R9's window is met through p₁/p₀ at r = 1.
SENSITIVITY: for r < 1/√2 the budget is r²P², P scales by 1/(√2 r), and the LP rows rise by log₁₀(1/(√2 r))·(1 + O(1/X)) decades — 1.7 at r = 0.1:
the 48-decade gain is a change of the POWER of the requirement and survives every r.
THE FACTOR TWO. §3.4 wrote the floor as ½P² ≥ 1.5(100M)^dXR^{d+1}; replacing the printed budget 2p₀ ≥ 3(100M)^dXR^{d+1} by ½P² gives
½P² ≥ 3(100M)^dXR^{d+1}, i.e. P ≥ (6(100M)^dXR^{d+1})^{1/2}: (3.2) carries ½ln 6 for ½ln 3, and LF′_LP's corridor reads R − 5 ln R = ln(18(100M)⁸X).
Runs a/b's B_LP and LF′_LP are too low by ≈ 0.3 decade; run e recomputes them (stake below). A FURTHER REFINEMENT NOT CLAIMED: both the budget
and (1.81)'s future cost scale with (d′ + 1); used per unit of (d′ + 1), (1.88)'s 100^d would become L^{d+1} — not checked against (1.87)'s merges.
17.2 PROPOSITION H's PREMISE READ ON IMAGE (CMP 109 p. 275, my render `render/cmp109_275.png`): "(3.26) M′(U) = V^v, |V(b) − 1| < O(1)Mα₀,
|v − 1| < O(1)Mα₁ … We assume that α₀, α₁ are chosen so that Mα₀, Mα₁ are still small." — the generalized axial gauge in □₀ accumulates M
plaquettes of curvature: the mechanism of §8.3 and §15 (U3), on the page.
17.3 THE A₀ NOTATION AND THEOREM J. LFR II (1.6) prints 3B₃M₀A₀²p₀²(g_k) and p. 381 confirms LFR's p₀(g) is the bare power. Theorem J is
unchanged: (1.88) bounds the bare power, p₀(g) ≥ 1.5(100M)^dR^{d+2}, T18's ε_k = g_kA₀p₀(g_k) ≥ g_kp₀(g_k) since A₀ ≥ 1 ("sufficiently large",
CMP 119 p. 246), so the joint row holds verbatim with A₀ = 1 the most favourable value; R₆ = ln(3B₃M₀A₀²p₀²(100M)⁴) is likewise smallest at
A₀ = 1. The kill-switch of §1 does not fire under either reading.
17.4 §14's sentence "whatever the untracked constants are, as long as C·C_S·C′_S² ≥ 1" asserts a lower bound on C (G's kernel constant) that is not
shown. Read instead: the proved-route numbers are at the REFERENCE POINT C·C_S·C′_S² = 1, and M_proved scales linearly in it (log₁₀ M_proved
moves by log₁₀(C·C_S·C′_S²), the rows by 14×, 8×, 1× that, for B_ar, C, D(q₁=1)).
17.5 THE GAUGE CAVEAT CARRIED (M6c §18.4). Every joint row uses T18 with the comb-gauge constant (d−1)(100M)^d. With LFR II p. 358's x₁-axial
constant (100M)³, if admissible in LFR II's construction (not settled), the joint rows lose one factor 100M·(d−1) in T18: X/2 falls by
ln(3·100M) ≈ 11.2 nats at M ≈ 245, i.e. ≈ 9.7 decades (B_ar 168.03 → ≈ 158.3).
17.6 STAKE FOR RUN e (`bin/m6d_thresholds_e.py` = run b with (3.2)'s ½ln 3 → ½ln 6 and LF′_LP's corridor ln(9(100M)⁸X) → ln(18(100M)⁸X); nothing
else changed): B_LP ≈ 120.40 (L = 6), LF′_LP ≈ 100.49 (L = 6); every other column identical to run b.

## 18. RESULTS OF RUN e (record `rec/thresholds_run.2026-11-02e.txt`, rc = 0; §17.6 unedited) — HELD — AND THE LADDER OF RECORD

e HELD: B_LP 120.40192 (L = 6, M = 247; staked ≈ 120.40), LF′_LP 100.49192 (L = 6, M = 247; staked ≈ 100.49); B_pr 173.60520, B_ar 168.03329,
LF′_ar 132.98652, D(q₁=1) 15.14149 identical to run b.
THE LADDER OF RECORD (certified floors, log₁₀ β_B ≥; runs b, e; comb-gauge T18 — §17.5 for the x₁-axial reading):
 Bałaban's architecture, joint row: 168.03329 (architecture form; printed form 173.60520) — supersedes M6c's 124.30010 (still true, weaker);
 + LP: 120.40192 · + LF′: 132.98652 · + LF′ + LP: 100.49192 · + LF in full: 48.97446 · + PS with the history half as printed (q₁ = 1): 15.14149 ·
 + PS with the history half per site (q₁ = 0, OPEN): 13.10410.
 M6c's "+ LF′ → 72.58066" is WITHDRAWN: it set the large-field threshold to g·A·X^{1/2} and dropped T17, both forbidden inside the architecture by (1.88).
 LP's worth after the factor-two correction: 47.63 decades at Bałaban's corridor, 32.49 at LF′'s (§7 (iii) read 48.0 / 32.8 before it).
THE NEXT OBJECT. FLOOR SIDE: LF IN FULL — large fields localised per plaquette, with per-plaquette normalisation and positivity, removing the
100.8 decades of per-M-cube bookkeeping ((1.88)'s region volume × waiting time × X, T18's tree-gauge Poincaré constant, LFR I (1.83)'s M⁶);
instrument: the Peierls core of M6c §7.2 plus a Coulomb/curvature-coordinate gauge in place of the axial one. SUFFICIENCY SIDE: a
RATE-PRESERVING decay bound for (QGQ*)⁻¹ — Demko–Moss–Smith/Jaffard (rate ∝ κ^{−1/2} through Chebyshev approximation on [C₁′⁻¹, (1−θ)⁻¹]) in place
of Combes–Thomas (∝ κ⁻¹), then the base constants K1, K3, K9, K11–K13, K15 tracked.
