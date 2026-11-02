# M3R — SECOND READING OF M3/WORK.md (§§0–11; §11 supersedes §8)

Second reader, 2026-11-02. Read in full: MATH_BRIEF.md; M3/WORK.md (761 lines); the records
blockmap_run.2026-11-02c.txt, slope_run.2026-11-02a.txt and the instruments m3_blockmap.py, m3_slope.py;
LEAN/aperanton/Aperanton/CouplingTransient.lean and CouplingSequence.lean (its `seq`, `val`, `trunc`);
THE GROUND §8.3 (ground_docx.txt lines 298–326: the block map, (8.5), Proposition 8.4, Hypotheses I and II,
Theorem 8.5 and its whole proof); M3/cmp102/cmp102_277.txt (CMP 102 277–309) at Theorem 1 (p. 279) and
§G/Proposition 9 (pp. 307–309); the record's verbatim of Bałaban's (0.2) and (0.17)–(0.20)
(III-Yang_Mills OPEN/ledger/d4-balaban-the-pages.md lines 48–49, 118).

Appended as the checking proceeds. Verdict words: HOLDS / FAILS at <step> / CONDITIONAL on <what>.
Checks of my own are in this directory (scripts `r_*.py`, records `r_*.txt`).

## ITEM 1 — §4: THE NORMALISATION AND THE RUNNING COEFFICIENTS — HOLDS

β = 1/g_B². Bałaban's (0.2), as the record quotes it verbatim (d4-balaban-the-pages.md l. 48–49): A^ε(U) = Σ_p ε^{d−4}[1 − Re tr U(∂p)]
"where tr is the normalized trace, i.e. tr 1 = 1", density exp(−(1/g²)A). For SU(2), tr = ½Tr and Tr U_p is real, so a plaquette
weighs exp(−(1/g_B²)(1 − ½Tr U_p)) ∝ exp((1/(2g_B²))Tr U_p); THE GROUND weighs it by exp(½β Tr U_p). Hence β = 1/g_B². HOLDS.
(The factor would be 2 if (0.2) were written with the unnormalised trace as ½‖U(∂p) − 1‖²; the verbatim quote rules that out.)

β = 4/g_YM². U_p = exp(iθ n̂·σ) with θ = a²|F|/2 + O(a³): ½Tr U_p = cos θ, 1 − cos θ = a⁴|F|²/8 + O(a⁵); β Σ_p → (β/8)∫Σ_{μ<ν}F^aF^a =
(β/16)∫Σ_{μ,ν}F^aF^a, equal to (1/(4g²))∫F^aF^a iff β = 4/g². HOLDS (the draft's "O(a⁶)" remainder is O(a⁵) before the total
derivatives are integrated away; immaterial). So g_B² = g_YM²/4, γ_YM = 2γ_B, and the two "β_UV" agree.

The two-loop coefficients, recomputed exactly (r_constants.py → r_constants.txt; rational multiples of π⁻², π⁻⁴, then iv enclosures):
 – b₀ = 11N/(48π²) = (11/24)/π², b₁ = 34N²/(3(16π²)²) = (17/96)/π⁴ at N = 2;
 – d(1/g²)/d ln μ = −2g⁻³(−b₀g³ − b₁g⁵) = 2b₀ + 2b₁g²; with x = 4/g_YM²: dx/d ln μ = 8b₀ + 8b₁g_YM² = 8b₀ + 32b₁g_B², and
   8b₀ = 11/(3π²), 32b₁ = 17/(3π⁴) (in g_YM units the two-loop coefficient is 8b₁ = 17/(12π⁴); the draft's 17/(3π⁴) multiplies g_B²,
   as it says);
 – per step of factor L (Δln μ = −ln L, and the 1/x term changes by O(x⁻²) across one step): b_{k+1} = (11/(3π²))ln L +
   (17/(3π⁴))ln L·g_k² + O(g⁴), g_k² = g_B,k². HOLDS.
 – enclosures: 8b₀ ∈ [0.37151100668857182862, 0.37151100668857182863]; c(2) = 0.2575118068331705468…; c(3) = 0.4081465573235253041…;
   32b₁ = 0.0581738994432112327…; 4b₁/b₀ = 17/(11π²) = 0.1565872838108856467…. All of S-1 met.
 – the log-log coefficient: dx/dt = A + B/x integrates to x = At + (B/A)ln x + C, B/A = 4b₁/b₀. HOLDS.
 – universality: under x′ = x + κ₀ + κ₁/x + O(x⁻²) the step x ↦ x − B₀ − B₁/x + O(x⁻²) keeps B₀, B₁ (checked: κ₁/x_{k+1} = κ₁/x_k +
   O(x⁻²), 1/x = 1/x′ + O(x⁻²)). HOLDS for AUTONOMOUS step maps with k-independent κ's — which Bałaban's scheme is only as k → ∞
   (B-v); at finite k the two-loop coefficient can carry its own telescoping transient, which Theorem 2 absorbs into ρ. A scope
   precision, not an error.

## ITEM 2 — §5: BAŁABAN'S THEOREM 2, BOUNDED-TRANSIENT FORM

### 2a. Lemma A′ (§5.2) — HOLDS, line by line

(P): x_i − x_j = Σ_{l=i+1}^j b_l with each b_l evaluated at x₀ ∈ D_m ⊂ D_l; Σ a(l) = (j − i)c + f(j) − f(i), |f(j) − f(i)| ≤ 2F. Correct.
Closedness: D_{m+1} = D_m ∩ x_m⁻¹[X_min, ∞) is relatively closed in the closed D_m, x_{m+1} = x_m − b_{m+1} continuous on D_{m+1} by (H1).
Correct. Half-line: x₀ ≥ M = X_min + K(c + ρ) + 2F and x₀ ∈ D_j give x_j ≥ x₀ − j(c + ρ) − 2F ≥ X_min (uses c + ρ ≥ 0). Correct.
Upper end x̂ = X + K(c + ρ) + 2F ≥ M: x_K(x̂) ≥ X. Correct. Lower end: {y : [y, ∞) ⊂ D_{K+1}} is upward closed, nonempty, bounded below
by X_min (D_{K+1} ⊂ D_1), so x* is finite and in D_{K+1} by closedness; if x* > X_min, points y_n ↑ x* outside D_{K+1} exist (else a
left neighbourhood lies in D_{K+1} and closedness extends the half-line); the least exit step j_n ≥ 1, a constant subsequence, and
continuity of x_j on the closed D_j ∋ x* give x_j(x*) = X_min; (P) from j to K with ρ ≤ c gives x_K(x*) ≤ X_min + 2F ≤ X. Correct.
IVT on [x*, x̂] (x* ≤ M ≤ x̂, so [x*, x̂] ⊂ D_{K+1}). Correct. The conclusion and the cross-scale inequality are (P). HOLDS.
No b is evaluated off a true trajectory; (H3) is used only on D_{k+1}. Remark (2)'s induction is consistent with §11.1 (CMP 109's
Theorem 3 needs only the window, which D_{k+1} carries).

### 2c. Lemma B (§5.3) — CONDITIONAL (five named items)

(B0) history-freeness: accepted at the record's strength (E_{k−1} is O(1) against the O(1/g²) Gaussian part, so it enters the
fluctuation form at relative order g²). Not re-derived here.

(B-i) the stage identity — HOLDS as a finite-dimensional lemma (H_λ non-degenerate on ℝⁿ). Checked step by step: the coarea factor
det(dQdQᵀ)^{−1/2}; the intrinsic Hessian at a constrained critical point is H_λ on ker dQ; in an orthonormal basis adapted to
ker D ⊕ ran Dᵀ (D = dQ), det[[H, Dᵀ],[D, 0]] = det H·(−1)^m det(DH⁻¹Dᵀ) = (−1)^m det(DDᵀ)·det_{ker D}H (Schur on the H₁₁ block);
S_k′ = λ (since dQ·dU*/dV = 1), and differentiating S′ = λ·dQ, Q = V gives H_λ dU* = dQᵀdλ, hence S_k″ = (dQH_λ⁻¹dQᵀ)⁻¹. The
coarea factor cancels. Correct.
GAP — THE GAUGE ZERO MODES (not addressed by "locally after gauge fixing"). L := S − λ·Q is invariant under the residual group R
(fine gauge transformations equal to 1 at the coarse sites, which leave Bałaban's covariant averages fixed) and stationary at U*, so
H_λ = L″(U*) annihilates every R-direction, and these lie in ker dQ: det_{ker dQ}H_λ = 0 before R is fixed. After fixing R (Bałaban's
own factor exp[−(1/g²)ΣΣ(1 − Re tr U(y,x))] in (0.17)/(0.19), whose orbit average is U-independent by Haar invariance, or an exact
axial gauge), H_λ is non-degenerate on ker dQ, but at V = 1 both H_λ (= the gauge-fixed S″(1)) and S_k″(1) annihilate the coarse
gauge directions (block-constant extensions of coarse transformations leave S, the axial factor and the minimum invariant). So
½log det H_λ and ½log det S_k″ are separately singular at V = 1, and the objects "Π_fine" and "Π_{S_k}" of (B-iii) exist only after a
coarse background gauge fixing with Faddeev–Popov factors on both lattices. The identity those gauge-fixed objects obey — and that
the ghosts' one-loop parts combine into [8b₀ ln(L^k/|P|) + c_W] − [8b₀ ln(1/|P|) + c(S_k)] with the SAME c as (B1)'s background-
Feynman-gauge definition — is not written. Standard background-field technology, very likely true; but it is the step that turns
(B-i) into a statement about Yang–Mills.

(B-ii) composition — HOLDS for the exact integrals (δ-constraints compose; the residual gauge factor only multiplies by a constant).

(B-iii) the Lagrange term — conclusion survives, the stated reason does not. The expansion ½log det H_λ − ½log det S″(U*) =
−½Tr(S″(U*)⁻¹⟨λ, Q″⟩) + O(λ²) and λ = S_k′(V) = O(εP²) are right. "By locality, analytic in P" is FALSE here: S″(U*)⁻¹ is the
unconstrained MASSLESS fine propagator, and the response functions it builds carry logarithms at P = 0 (∫d⁴q q/(q²(q+p)²) ~ p ln p).
What does hold: the zeroth-order factor T(1) = Tr(S″(1)⁻¹Q″(1)) is an adjoint-valued constant invariant under global colour
rotations, hence 0 (so λ's O(ε²) part drops); the first-order factor vanishes at P = 0 by gauge covariance (a constant coarse field is
pure gauge at first order) and is continuous there (the 4D massless integrals are IR-convergent at this order). So the Lagrange term is
o(1)·O(ε²P²) and the O(λ²) term O(ε²P⁴ ln P): NO P² CONTRIBUTION — but o(ε²P²), not the stated O(ε²P⁴), is what the argument proves.
(B-iii) the aliases — order counting, as §11.4 itself says ("DERIVED, not proved"). Add: Π_fine at aliased momenta is O(k ln L), so
the alias term is O(ε²P⁴·k ln L) — still no P², with a k-dependent constant that must be carried into (B1)'s uniform bound.

(B-iv) THE ANALYTICITY CLAUSE AGAINST CMP 102 — the quotes are on the page; the decay half is announced there without proof.
Verified in cmp102_277.txt: Theorem 1 (p. 279): "The constants α₀, α₁, B₃ … depend on d and L only", "This orbit is a unique critical
orbit in the space (6)"; Proposition 9 (p. 309) verbatim as quoted, ending "and its functional derivative (182) satisfies the
inequalities (190)". But the class 𝒮(γ₀, κ, M) needs "kernels analytic in a strip of width κ" — exponential DECAY of S_k = A(U_k(V))'s
vertex kernels, i.e. of U_k's functional derivative — and that is exactly (189)–(190), of which CMP 102 p. 308 says: "To prove an
exponential decay we have to investigate more closely the kernel … This is, unfortunately, a very awkward and complicated problem,
although quite straightforward. … We do not perform these calculations here, we have obtained all necessary results to do the
calculations and estimates, let us formulate a final result only." So (B2)'s strip-analyticity rests on an estimate Bałaban states
and does not prove in CMP 102 (analyticity in V is the "simple consequence of the proof of Theorem 1"; the decay is not). The draft's
"READ AT THE SOURCE" is accurate about the statement and silent about this. Next: locate a proof of (190) (CMP 99's background
propagator bounds (3.127)–(3.133) are the natural source) or prove it from them.

THE BLOCK FACTOR: AN INCONSISTENCY INSIDE THE DRAFT'S OWN TEXT (not a verified fact about Bałaban — CMP 109 is not on disk). (B2)'s
symmetry clause — load-bearing by the draft's own words ("without it a one-loop term iε_{μνρσ}n_σP_ρ puts a 1/P into β(P)") — is taken
from "CMP 109's centred averaging (L odd, contours generated by coordinate permutations, (0.3)–(0.4))". Yet Theorem 2 is stated for
"block factor L ≥ 2", S-1 certifies c(2), THE GROUND's Theorem 8.5 is "with L = 2" (rungs a_j = 2^{−j}a₀), and the record itself
(d4-balaban-the-pages.md l. 182) computes "Bałaban's (0.12) averaging with axial contours to the block corners, L = 2". Either the
symmetry needs centred blocks — then Theorem 2 as proved holds for odd L only, and the interface to Theorems 7.4/8.5 needs the
construction on L-odd rungs (I see nothing in 7.4/8.5 that needs L = 2 essentially, but they are stated with it) — or Bałaban's
averaging exists at L = 2, and then the hypercubic-and-reflection symmetry (B2) leans on must be shown for THAT averaging (corner
contours are not obviously reflection-symmetric). To be settled by reading CMP 109 (0.3)–(0.4) and (0.12).

(B1), the infrared identification, is the record's proof on paper; neither the draft nor this reading re-did it line by line.
LEMMA B VERDICT: CONDITIONAL on (1) the gauge-fixed form of (B-i), (2) (B1), (3) CMP 102's (190) (announced, not proved, there),
(4) the block factor settled (odd L, or the symmetry shown for the L = 2 averaging), (5) the alias constants carried through CMP 102's
derivative bounds.

### 2b. The Lean claim (F2, §5.2, §11.2) — TRUE AS A READING; THE NECESSITY CLAIM DRAWN FROM IT FAILS

Read: CouplingTransient.lean l. 85–91, `window_of_bounded_transient (b : ℕ → (ℕ → ℝ) → ℝ) (hb : ∀ k, Continuous (b k)) …
(hr : ∀ k s, (∀ j, Xmin ≤ s j) → a k − ρ ≤ b k s ∧ b k s ≤ a k + ρ)`, with `seq`, `val`, `trunc` from CouplingSequence.lean l. 41–100.
The quantifier in hr is over EVERY s : ℕ → ℝ with entries ≥ Xmin, and hb is continuity on the whole product space. The proof
uses hr through `trunc_split` (l. 39: hr at `fun j => max (s j) Xmin`) on the truncated flow's states for every x₀ of the IVT interval
[X + S − Kρ, X + S + Kρ] (`hw`, `hlo`, `hhi`, `hcont`, l. 98–110). Where that flow dips below Xmin the clamped state is not a
trajectory (its entry j+1 is max(x_j − b, Xmin), not entry j minus the shift), and every state carries the filler x₀ beyond the
current step. So the draft's claim — hr asks for β on non-trajectory histories — HOLDS.

But §11.2's consequence — "The Lean lemma … becomes applicable after the (x, E) extension is written; Lemma A′ needs no extension"
— the necessity claim fails (the reading of hr holds; F2 is literally correct): no extension of Bałaban's construction is needed.
RE-ENCODE THE SHIFT BY THE BARE VALUE. Entry 0 of every Lean state is x₀
(`seq_frozen`, `val_zero`). On the closed set D_{k+1} (closed by Lemma A′'s own induction) the trajectory shift x₀ ↦ b_{k+1}(x₀) is
continuous with values in [a(k+1) − ρ, a(k+1) + ρ]; Tietze (Mathlib's `ContinuousMap.exists_restrict_eq_forall_mem_of_closed`, with
t = Icc, OrdConnected) extends it to a continuous g_k : ℝ → ℝ with the same bounds. Put b̃ (k+1) s := g_k(s 0), b̃ 0 s := a 0. Then
hb and hr hold for b̃ at EVERY s by construction, `window_of_bounded_transient` applies verbatim, and at the x₀ it returns an
induction gives val b̃ x₀ k = x_k(x₀) and x₀ ∈ D_{k+1} for all k ≤ K (on D_{k+1}, b̃ (k+1)(seq …) = g_k(x₀) = b_{k+1}(x₀); the profile's
lower bound puts val (k+1) ≥ Xmin, i.e. x₀ ∈ D_{k+2}). That is Lemma A′'s conclusion. So Lemma A′ is a correct new paper proof of a
statement the kernel-checked theorem already yields after a ten-line Tietze bridge; its kernel status is not "OWED" in the strong
sense §5.2 Remark (4) says.
The bridge is written out as Lean 4 in `M3RBridge.lean` (this directory: `traj`, `D`, `D_succ`, `closed_and_cont`, `extend`,
`recode`, `trajectory_window`). NOT KERNEL-CHECKED: `lake env lean` on it had to import all of Mathlib (CouplingTransient imports
`Mathlib`), the lean process stood at 6.2 GB private bytes after five minutes, past this reading's 2 GB budget, and I stopped it and
its parents (PIDs 23764, 47808, 21472, 24080, 47004 — all mine, command lines naming M3RBridge.lean). The mathematics of the bridge is
the paragraph above; the file is the next thing to run on a seat with the memory. (The paper argument is complete; the Lean file is
written and unchecked.) Read-only kept: `git -C III status --porcelain -- LEAN/aperanton` printed nothing after the stop (no tracked
file changed; the bridge file lives only in this scratch directory). The empty compile log was deleted so it cannot read as a run.

### 2d. Lemma C (§5.4, with §11.1) — CONDITIONAL on (BB1)–(BB5); (BB4) is an inference, not a theorem of Bałaban

(5.C) as an identity — HOLDS: φ(t) = log⟨χ_k e^{tI}⟩_{G,V} is C^∞ on [0, 1] in finite volume (I bounded on the cutoff region),
φ′ = ⟨I⟩_t, φ″ = ⟨I; I⟩_t, and φ(1) = φ(0) + φ′(0) + ∫₀¹(1 − s)φ″(s)ds; with Ψ_g = log Z^G + φ(1) and M linear,
β(g) − β(0) = M[log⟨χ_k⟩_G] + M[⟨I⟩_0] + ∫₀¹(1 − s)M[⟨I; I⟩_s]ds. Correct, GIVEN that each M[·] exists and M passes the s-integral.
The real-parameter interpolation does avoid the complex-coupling defect (the cutoff region is frozen). The term bounds:
(i) Gaussian tails, ≤ C₁e^{−c₁ε₁²/g²} per localized unit — fine given localization; (ii) the odd terms vanish (μ_G centred: CMP 109
p. 267, χ_k even), the even ones g²⟨V₄⟩, the history's g²⟨(HB)∇²E(HB)⟩/2 ≤ Cg²E₀/α₁² — fine; (iii) |I| ≤ Cε₁|B|² on the cutoff region
(Σ_{n≥3}g^{n−2}C^n|B|^n ≤ C′ε₁|B|² once Cε₁ < ½), |I_H| ≤ CE₀ε₁/α₁ — so ⟨I;I⟩_s ≤ C(1 + E₀²/α₁²)ε₁² PER LOCALIZED UNIT.

WHERE (BB4) ENTERS — four places, the last not listed by the draft:
 (a) in (5.C) itself: ⟨I; I⟩_s = Σ_{x,y}⟨I_x; I_y⟩_s is extensive; M[⟨I;I⟩_s] exists (as the infinite-volume second moment (1.22)) only
     if the truncated correlations under ⟨·⟩_s decay, uniformly in s, and "M commutes with the s-integral by dominated convergence under
     the uniform bounds below" needs exactly those s-uniform localized bounds;
 (b) bound (iii), C₃ε₁² uniformly in s ∈ [0, 1] — the sup bound on |I| gives the size per unit, the cluster expansion gives the
     localization; M's second background derivative then by Cauchy on the absolute background polydisc (BB1–BB3), which needs the
     expansion at COMPLEX backgrounds;
 (c) the moment-norm form C₃′g², which is "the standard refinement" — asserted, not derived;
 (d) the s = 0 end, used by (i) and (ii): log⟨χ_k⟩_G and the cutoff correction ⟨χ_k I⟩_G/⟨χ_k⟩_G − ⟨I⟩_G are extensive under a
     CORRELATED Gaussian with a non-product cutoff; their localization is the s = 0 case of the same expansion — not CMP 116's s = 1 case.
STATUS: INFERENCE. The draft says so itself in §11.4 ("INFERRED from the structure of CMP 116's proof as the record reads it …; CMP 116 is
not on this machine. The first page-check for Lemma C is CMP 116 Lemma 1, (1.34)–(1.36)") — while §5.4's status line and §11.3's row
read "PROVED given BB1–BB5", which is accurate only with that label carried. "Its proof uses only bounds on |I| on the domain, which sI
satisfies a fortiori" is exactly what must be read off CMP 116: if any step uses more than sup|I| (a renormalised quadratic part, a
large-field/small-field split defined through the action, a positivity of Re I), the a-fortiori fails. The robust form to check: the
cluster expansion is analytic in a COMPLEX s on |s| ≤ 1 + δ (room exists, I = O(ε₁)); then φ″ is bounded by Cauchy and the
s-uniformity is automatic.
THE BOUND ρ ≤ C(ε₁² + g²) + C₁e^{−c₁ε₁²/g²} follows from (i)–(iii) given BB1–BB5. Its use needs ε₁ shrinkable before γ (the draft's own
§11.4 caveat; CMP 109's "numerous restrictions" on ε₁ not read). With ε₁ fixed the ε₁² term does not vanish as g → 0, so the sup form
does not give §5.1's "g₀ → 0 like (8b₀ ln ε⁻¹)^{−1/2}" — it gives x₀/ln ε⁻¹ ∈ [8b₀ − ρ/ln L, 8b₀ + ρ/ln L] + o(1); the exact rate needs
ρ_k → 0 along the trajectory uniformly in k (the moment-norm form, or Lemma B's limit taken uniformly in k).
§11.1 (the payable (R) dissolved: the β-functions of record are CMP 109's small-field objects) rests on three CMP 119 sentences quoted
from the record's reading log; CMP 119 is not on disk here, so I could not read the falsifier's page. The withdrawal of the record's
(log g⁻²)^{−2q₁} bound is right on its own terms (the second background derivative M takes is a second Cauchy factor on a g-sized
polydisc, α₁⁻² ~ 1/(g²polylog), which §5.4 shows diverges).

### 2e. Lemma D (§5.5) — CONDITIONAL on coupling-uniform convergence in the localized norm

The moving cutoff boundary {|gB(b)| = ε₁} is μ-null, so each finite-dimensional polymer activity is continuous in g by dominated
convergence — correct. The step (b) "uniform convergence on compact parameter sets" must hold in the weighted sup norm
‖E‖ = sup_X e^{κd(X)} sup|E_X| (x₀ ↦ E_k is 𝔈-valued), i.e. the k- and coupling-uniform bounds of CMP 109 p. 263 and CMP 116 with
absolute constants — as the draft states. The induction (x_k, E_k) continuous on D_k is right. Verdict as the draft's own.

### 2f. Theorem 2 (§5.1, §5.6, §11.3) — CONDITIONAL

The assembly is logically correct: A′ (proved; and a corollary of the Lean theorem via 2b) + B (H2) + C (H3) + D (H1). It is
conditional on: the small-field black box (CMP 95, 99, 102, 109 Thm 3, 116); (BB4) as an inference (2d); the gauge-fixed stage identity,
(B1), CMP 102's (190), the alias constants (2c); the block factor settled (2c); ε₁ shrinkable or the unproved moment-norm form (2d); §11.1's reading of
CMP 119. One check I made of its downstream use: the profile with ±2F supplies CMP 119's scale sum (2.46) Σ_{j≤n}g_j^{κ₀} < g_n^{κ₀−6}:
with g_j² ≤ (x_n − 2F + (n − j)(c − ρ))⁻¹, Σ ≤ 2^{κ₀/2}[g_n^{κ₀} + g_n^{κ₀−2}/((c − ρ)(κ₀/2 − 1))] < g_n^{κ₀−6} once γ⁴ ≪ c − ρ and
x_n ≥ 4F. Holds.

## ITEM 3 — §6: HYPOTHESIS II, AND THE READING OF THEOREM 8.5

### Theorem 8.5 as the paper states it (ground_docx.txt l. 311–318) — the draft reads it correctly
In the proof, Hypothesis II(a) enters once: "The second term is the λj-mean of the covariance of f and g under the fibre measure, at
most K′N(f)‖f‖‖g‖ρ′d by Hypothesis II(a)." Hypothesis II(b) enters through b_y = 1 − e^{−osc} ≤ δ_y(G′)/inf G′ ≤ K′N(g)ρ′^{r′} and
through δ_i(F) in Dobrushin's comparison theorem, both suprema over conditionings. The gap paragraph uses only the covariance
inequality on θf̄ and τ_t f (fine observables allowed; supports only). Nothing else uses Hypothesis II.

### Proposition 6.1 — HOLDS
The second term of the split is exactly λ_j(Cov_{ν_j}(f, g|·)), so |λ_j(Cov)| ≤ K′N(f)‖f‖‖g‖ρ′^d (the absolute value of the average —
weaker even than the average of the absolute value) is all Theorem 8.5 consumes from II(a); II(b) is consumed in sup form because
the comparison theorem takes suprema. F1 is right.

### Proposition 6.2 — HOLDS at the Gaussian level (the record's numbers met independently; one printed column wrong)
(i) Var/g² = 4(S_n − T_n): perpendicular sides decouple (δ_{μμ′}); each side with itself gives S_n; opposite sides −T_n (counted twice).
S_n ≥ nG₄(0) (G₄ > 0); T_n = Σ_{|m|<n}(n − |m|)G₄(me₁ + ne₂) ≤ nΣ_mG₄(me₁ + ne₂) = nG₃(ne₂) ≤ C (Σ_m G₄(me₁ + x⊥) = G₃(x⊥) by the
k₁ = 0 slice of the Fourier integral; nG₃(ne₂) → 1/(4π)); S_n/n → G₃(0) by dominated convergence (G₄(me₁) ~ 1/(4π²m²)). Correct.
G₃(0) is Watson's integral: G₃(0) = W/6, W = (√6/(32π³))Γ(1/24)Γ(5/24)Γ(7/24)Γ(11/24) = 1.5163860591519780182 (the 3D walk's return
sum), so 4G₃(0) = 2W/3 = 1.0109240394346520121 — my integral and the closed form agree to 20 digits (r_green.txt). Record: 1.0109240394;
fit 1.010921. MET. Added: the ln n coefficient is −2/π² = −0.202642 (from Σ_{|m|<n}|m|G₄(me₁) ≈ (ln n)/(2π²)); the fit's 0.2024 meets it.
(ii) The scaling k = q/n, D_n(q/n) ≈ nφ(q), k̂² ≈ |q|²/n², d⁴k = d⁴q/n⁴ gives the stated v_∞ = 2∫d⁴q/(2π)⁴|Πφ|²|1 − e^{iq₂}|²/|q|²,
integrable (bounded at 0, Π min(1, 4/q_ν²)·|q|⁻² at ∞). Computed directly by the heat-kernel/erf representation (r_vinf.py):
v_∞ = 0.186487268178; the record's n = 64, 96, 128 rows fitted by v_∞ + a/n + b/n² extrapolate to 0.18648721 (a ≈ 0: convergence
O(n⁻²)). The draft's "≈ 0.1865" HOLDS.
(iii) HOLDS (E[e^{iqΦ}] = e^{−q²Var/2}; for SU(2) E[χ_j] = E[sin((2j+1)|Φ|/2)/sin(|Φ|/2)] → 0). (iv) The coefficient is (2/π)ln n =
0.6366 ln n; the record's increments approach (2/π)ln 2 = 0.4413 per doubling (0.4391 at 64 → 128); "≈ 0.63 ln n" right.
THE WRONG COLUMN: the record's AF-sequence column is labelled ⟨cos(θ_path/2)⟩ ~ exp(−3/8 g²Var), and §3 reports "Gaussian
⟨cos θ/2⟩ ≈ 4·10⁻¹⁵ — Haar". For Φ ~ N(0, vI₃), E[½Tr e^{iΦ·σ/2}] = E[cos(|Φ|/2)] = (1 − v/4)e^{−v/8} (differentiate
E[sin(s|Φ|)/|Φ|] = s e^{−vs²/2} in s); exp(−3v/8) is the product of three one-component means, a different quantity. At v = 88.18 the
true value is −3.44·10⁻⁴ (quadrature agrees, r_vinf.txt), not 4.36·10⁻¹⁵; at x_c = 16, n = 128 it is −0.170, not 2.1·10⁻⁵ — far from
Haar there. The limit statement stands; the printed numbers do not.
The consequence paragraph: in the Gaussian model distinct coarse LINK angles decouple (cross-covariances O(g²) against variances
g²G₃(0)n), so the coarse link variables tend to product Haar — Hypothesis I trivial, as the draft says. (Adjacent coarse PLAQUETTE
fluxes keep correlation ±1/4 through the shared side; it is the link variables that become independent.)

### Remark 6.3 — HOLDS as an argument that Hypothesis I fails at weak coupling; "only past the crossover" is stronger than shown
A pair v, v′ differing at y′ with the other five staples at y summing to zero leaves one staple controlling a conditional law of width
~g_eff; rotating v_{y′} moves its mode by O(1), TV → 1 as β_eff → ∞. Even with five aligned staples the change 6 → 4 of the staple sum
leaves the mode and changes only the width: TV(N(0, I₃), N(0, 1.5I₃)) ≈ 0.18, β-independent, so the row sum exceeds 1 already. Two
precisions: 18 is the neighbour count for LINK variables (a block carries four coarse links; for block variables it is larger), and
what is shown is failure where β_eff ≫ 1, not that Hypothesis I holds only in the strong-coupling disk.
Theorem 6.3 (the tower; not in the assignment): HOLDS (law of total covariance, λ_c∘κ = λ_UV); the UV input it needs is
λ_UV(|Cov_{ν_UV}|) — the average of the absolute value, stronger than (II.a-avg) as defined — which Theorem 6.5(b) supplies.

### Theorem 6.4 — HOLDS, with three corrections
Gaussian conditioning (Schur) — Γ v-independent; for ζ ∈ ker Q the linear term ⟨ζ, C⁻¹Hv⟩ = ⟨Qζ, (QCQᵀ)⁻¹v⟩ = 0, so ζ has law
∝ exp(−½⟨ζ, C⁻¹ζ⟩) on ker Q — correct. (a) Gebelein + Kolmogorov–Rozanov — correct. Corrections: (b) |F(v) − F(v′)| ≤ osc(f)·TV ≤
2‖f‖·TV, so the bound is (2/√(2π))‖f‖δ ≈ 0.80‖f‖δ, not ½‖f‖δ; (c) with L separating shells the chain A–S₁–S₃–…–B gives
r(A, B) ≤ r₁^{⌊(L−1)/2⌋}, not r₁^{⌊L/2⌋}; (c)'s parenthesis "Bałaban's averages" is doubtful (flag, not a page citation: CMP 109's
(0.3)–(0.4) are not on disk; this is from the structure of his contour averaging): a coarse link of Bałaban's joins two coarse sites,
and an average of contour transports between them reads fine links on both sides of the block boundary, so Q_b would read two blocks
and Q would not be block-diagonal in THE GROUND's partition. If so, (c) applies to the block-local average of Prop. 6.2(ii), and for
Bałaban's map the Markov structure lives on a range-2 block graph with its own r₁. The Gaussian layer lemma r₁ < 1 is open, as the
draft says.

### Theorem 6.5 — HOLDS as an implication from (S) and (P_LF)
Cumulants as s-derivatives of log ρ(w; s); only X meeting A and B survive ∂_{s₁}∂_{s₂}; Cauchy on the polydisc (sup/(r₁r₂)); entropy
e^{κ_ent n}; the average by Tonelli and P(|X ∩ Z| ≥ m) ≤ C(n, m)e^{−pm}, geometric under e^{κ_ent}(e^{−κ′} + e^{−p}) < 1. Correct. The
pointwise bound in (a) is +∞ at a w whose large-field set connects A to B — why only the averaged and small-field forms follow, as the
draft says (§6.8). (S) and (P_LF) are unproved inputs, named as such.

### Proposition 6.6 — (i) HOLDS; (ii) CONDITIONAL on a hypothesis it does not state (reflection covariance); (iii) HOLDS given (ii), (D)
(i) Theorem 8.5's first-term argument with F = f, G = g: b_y = 0 off S(g) and ≤ 1 on it, δ_i(f) ≤ 2‖f‖·1_{S(f)}, D(i, y) ≤
e^{−κ|i−y|}/(1 − α), λ_j(G′) ≤ 3‖g‖ (real g; complex g by parts): |Cov_{λ_j}(f, g)| ≤ 6N(f)N(g)‖f‖‖g‖e^{−κd}/(1 − α). HOLDS with K = 6.
(ii) The step "(i) gives S_j(θf̄·τ_t f) − |S_j(f)|² ≤ C_f e^{−κt/a_c}" needs θf̄ to be a coarse observable OF THE SAME BLOCK LATTICE; (i)
says nothing about a coarse observable paired with a fine one (that is what II(b) is for). Under THE GROUND's convention (half-open
blocks, links assigned by midpoint, reflection plane x₀ = 0 on a block boundary) this fails for the ultraviolet-stable average the
proposition assumes: block [na_c, (n+1)a_c)'s spatial paths sit at x₀ ∈ {na_c, …, (n+1)a_c − a}; their reflections sit at
{−na_c, …, −(n+1)a_c + a}, one fine spacing off block [−(n+1)a_c, −na_c)'s set {−(n+1)a_c, …, −na_c − a} — the reflected average reads
links of two blocks and is not a function of the coarse variables. (THE GROUND's own corner-path holonomy map IS reflection covariant —
spatial coarse links at x₀ = na_c reflect to those at −na_c, time-like ones to inverses — but it is the ultraviolet-unstable map of
Prop. 6.2.) For a time shift u₀ ∉ (a_c/2)ℤ the reflected block lattice is another shift altogether. REPAIR: (1) add the hypothesis
that θ maps coarse observables supported one block above the plane to coarse observables of the same lattice — true for centred,
reflection-symmetric averages over blocks of odd side with the plane through a layer of block centres (the draft's own (E3) setting,
and the draft's own "L odd" for the centred averaging again); (2) reduce every time shift to u₀ = 0 by [f] = e^{−u₀H}[τ_{−u₀}f] (u₀ ∈ [0, a_c)), which commutes with
E([0, κ/a_c)). With these, the spectral step (μ_ψ([0, κ/a_c − δ]) ≤ C_f e^{−δt} → 0, λ = 0 included) is right.
(iii) H_c = Ω^⊥ gives E([0, κ/a_c)) = the projection on CΩ: unique vacuum, no spectrum in (0, κ/a_c). HOLDS given (ii) and (D). So
"for coarse observables Theorem 8.5 needs only Hypothesis I; with (D) the gap follows without Hypothesis II" is right once (1)–(2)
are added.

Remark 6.3's aligned-staple number, computed (r_tv.py → r_tv.txt): the Gaussian limit TV(N(0, I₃), N(0, 1.5I₃)) = 0.185637 (densities
cross at r² = 9 ln 1.5; difference of two χ²₃ CDFs), and the exact von Mises–Fisher TV on S³ between concentrations 6β and 4β is
0.1802, 0.1847, 0.1855, 0.1856 at β_eff = 2, 10, 100, 1000 — ×18 ≈ 3.3 > 1.

## ITEM 4 — THE RECORDS COMPUTE WHAT THE TEXT SAYS — HOLDS, with one wrong column

m3_blockmap.py: the heat-kernel reduction 1/k̂² = ∫₀^∞e^{−tk̂²}dt with ∫dk/(2π)e^{ikm}e^{−2t(1−cos k)} = e^{−2t}I_m(2t) = scipy's
ive(m, 2t) is exact. I re-derived ĥ_μ for the three test functions — PATH: ĥ₁ = D_n(k₁)(1 − e^{ik₂n}) (factors F·H·J·J);
AVERAGED: ĥ₁ = n⁻³Π_νD_n(k_ν)(1 − e^{ik₂n}) (F·G·F·F/n⁶); ONE-DIRECTION: ĥ₁ = n⁻¹D_n(k₁)D_n(k₃)(1 − e^{ik₂n}) (F·H·F·J/n²) — each
times 2 for μ = 1, 2. The code's integrands are exactly these. n = 1 gives 4(G₄(0) − G₄(e₁)) = 4/8 = ½ (−ΔG = δ), the known answer.
Independent evaluation (r_green.py: mpmath, 30 digits, not scipy; each variance expanded into a finite signed sum of G₄ values; the
tail integrated term by term from the asymptotic series of e^{−z}I_ν(z)): G₄(0) = 0.15493339023106021408; G₄(0) − G₄(e₁) = 0.125;
n = 2: 1.36931153514838 / 0.816690275777772 / 0.28810407272383; n = 3: 2.30519305672091 / 1.03288180447286 / 0.236676397072448 —
every printed digit of the record's rows (path / one-direction / averaged) met. The tails the record prints (≤ n⁴/(32π²T²)) are the
correct bounds for integrands ~ n⁴/(16π²t³) at t ≫ n².
slope_run: G₃(0) = ∫(e^{−2t}I₀(2t))³dt + the (4πt)^{−3/2} tail = 0.252731009859, which is W/6 to 12 digits; the fit coefficients are
as stated; the log coefficient 0.2024 is −(−2/π²) to 2·10⁻⁴.
THE ONE WRONG COLUMN: "⟨cos(θ_path/2)⟩ ~ exp(−3/8 g²Var)" (and §3's "≈ 4·10⁻¹⁵") is not the Gaussian mean of ½Tr e^{iΦ·σ/2}, which is
(1 − v/4)e^{−v/8} = −3.44·10⁻⁴ at v = 88.18 (see item 3).
Standard of computation: S-1 is interval arithmetic (certified). S-2 is double-precision quadrature with error estimates, not outward
rounding; Prop. 6.2 is proved analytically and does not lean on those numbers, so this is a labelling point (the brief's
"certified (outward-rounded)" standard is met by S-1 only), and my 30-digit evaluation agrees with S-2 to every printed digit.

## WHAT IS PROVED AT FULL STRENGTH (by this reading)

 – §4 entire: β = 1/g_B² = 4/g_YM²; per step b_{k+1} = (11/(3π²))ln L + (17/(3π⁴))ln L·g_B,k² + O(g⁴); c(2), c(3), 32b₁, 4b₁/b₀ enclosed.
 – Lemma A′ (and, on paper, its conclusion follows from the kernel-checked `window_of_bounded_transient` by the Tietze re-encoding of
   2b; the Lean bridge M3RBridge.lean is written, not checked).
 – Lemma B's (B-i) as a finite-dimensional identity; (B-ii) for the exact integrals.
 – (5.C) as an identity.
 – Prop. 6.1; Prop. 6.2 at the Gaussian level (slope 2W/3 = 1.0109240394346520, log coefficient −2/π², v_∞ = 0.186487268178);
   Theorem 6.3 (tower); Theorem 6.4 (with constants corrected); Theorem 6.5 as an implication; Prop. 6.6(i) with K = 6.

## WHAT FAILS (as written)

 – §11.2's necessity claim: "the Lean lemma becomes applicable after the (x, E) extension" — no extension is needed (2b); F2's reading
   of hr is right.
 – Lemma B (B-iii): the Lagrange-term reason "by locality, analytic in P" (the propagator is massless and unconstrained); the conclusion
   survives at o(ε²P²).
 – Prop. 6.6(ii) without reflection covariance of the block map: the ultraviolet-stable half-open average is a counterexample
   geometry under THE GROUND's block convention.
 – §3 / record: the ⟨cos θ/2⟩ column.
 – Inside the draft's own text: Theorem 2 stated for L ≥ 2, (B2)'s symmetry taken from "centred averaging (L odd)", THE GROUND's
   chain at L = 2, the record's L = 2 corner-contour computation — the block factor is unsettled (CMP 109 (0.3)–(0.4), (0.12) to read).

## WHAT IS CONDITIONAL, EXACTLY

 – Lemma B: the gauge-fixed (B-i) (residual-gauge zero modes of H_λ; coarse-gauge zero modes of S_k″(1) and H_λ(1)); (B1); CMP 102's
   (189)–(190), stated by Bałaban "without performing the calculations"; the alias constants; the block factor (odd L, or the
   symmetry shown for the L = 2 averaging).
 – Lemma C: (BB1)–(BB5), with (BB4) an inference entering (5.C)'s M–∫ds interchange, bound (iii), the moment form, and the s = 0 ends of
   (i)–(ii); ε₁ shrinkable before γ, or the unproved moment-norm form.
 – Lemma D: coupling-uniform convergence in the localized norm.
 – Theorem 2: all of the above, plus §11.1's reading of CMP 119 (not on disk).
 – Thm 6.5: (S), (P_LF). Prop. 6.6(iii): (ii)'s added hypothesis and (D).

## THE SINGLE MOST IMPORTANT MISSING ESTIMATE

(BB4) as an estimate: a localized cluster expansion of the step's fluctuation measure χ_k e^{sI}dμ_{G,V}, uniform in s ∈ [0, 1] (best:
analytic in complex s on |s| ≤ 1 + δ) and in complex backgrounds V on an absolute polydisc around 1, giving
sup_s |M[⟨I; I⟩_s]| ≤ C(ε₁² + g²) (and the same at s = 0 for log⟨χ_k⟩_G). It is the only input of ρ < c — hence of the window, hence of
Theorem 2 — that is not a stated theorem of Bałaban; the place to read it off is CMP 116 Lemma 1, (1.34)–(1.36), checking that the proof
uses the interaction only through sup|I| on the domain.
RUNNER-UP, to be looked for first because of what it is: CMP 102's (189)–(190), the exponential decay of the minimal configuration's
functional derivative — the one estimate in the chain Bałaban himself says he did not carry out ("We do not perform these calculations
here … let us formulate a final result only", p. 308). Lemma B's finite F (S_k in the class 𝒮 with a k-uniform strip of analyticity)
rests on it; a proof is to be sought in CMP 99's background propagator bounds (3.127)–(3.133) or written from them.

