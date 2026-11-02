# M2RR — second reading of revision 33's insertion into §8.3 (Theorem 8.5′ and what it rests on), 2026-11-02

This is the second reader of M2R's conversion. I read only, outside this directory. I read, in this order:
- the live §8.3, `III-Yang_Mills/source/ground/content4.js` lines 66–106. It is byte-identical to `M2R/rev33_base/content4.js` (checked with `cmp`), and I also read Proposition 8.1 (line 17) and Theorem 7.4 with its proof (`content3.js` line 60);
- the diff `rev33_base` → `rev33_test`. It is a single hunk `101a102,214`: 113 inserted lines, every push call read, with the JS block taken from `M2R/rev33_l2.py`;
- `M2R/PAPER_DRAFT.md` parts 1–6;
- `M2/WORK.md` §§0–3, with Theorem 3.1;
- `M2R/REVIEW.md`, all of it;
- `rev33_test/test.docx`, rendered to text (`rendered_insert.txt`) to read the inserted section as a reader will see it.

Line numbers below are those of `M2R/rev33_test/content4.js`. The same strings sit verbatim in the `BLOCK` of `M2R/rev33_l2.py`, which inserts it unchanged, so each repair applies there too.

Verdict alphabet: **HOLDS** / **HOLDS WITH A REPAIR** (exact replacement given) / **FAILS** (counterexample given).

---

## 1. Verdicts

| JS lines | item | verdict |
|---|---|---|
| 103 | opening paragraph | HOLDS |
| 104–111 | Proposition 8.1′ (the gap is an L² norm), proof, (8.8a), the remark after it | HOLDS (classical, credited) |
| 112–120 | (S); translation covariance; L²(λⱼ), Hᵧ, Kᵧ, Qᵧ; ℓᵧ; ρ_ξ; Rⱼ (8.8b) | **HOLDS WITH A REPAIR** (R1: the bound ℓᵧ(F) ≤ δᵧ(F)/2 is false for complex F; R2: \|Cov\| and the degenerate convention) |
| 121–123 | Hypothesis I′ | HOLDS |
| 124–128 | Hypothesis II′ | HOLDS |
| 129 | versions; what is averaged | HOLDS |
| 130 | II ⇒ II′; I ⇒ I′ | **HOLDS WITH A REPAIR** (R1b; the conclusion is unchanged) |
| 131–137 | Lemma 8.5A | HOLDS (classical: Halmos, Friedrichs, Deutsch) |
| 138–146 | Lemma 8.5B | HOLDS |
| 147–155 | Proposition 8.5C | **HOLDS WITH A REPAIR** (R3: the generator is called L, which is the construction's integer L) |
| 156–167 | Theorem 8.5D and its footnote | HOLDS (R3 in its proof; O2 and O3 recommended) |
| 168–177 | Proposition 8.5E | **HOLDS WITH A REPAIR** (R4: translation covariance needs covariant versions) |
| 178–188 | Theorem 8.5′ and its proof | HOLDS |
| 189 | the remark after it | **HOLDS WITH A REPAIR** (R6: reflection *and translation* invariance) |
| 190–201 | **Proposition 8.4′**, (8.8e), and its proof | **HOLDS**: proved in §2 below; no counterexample in about 9·10⁵ instances (§3) |
| 202 | the remark after it | HOLDS |
| 203–212 | Corollary 8.5F (i), (ii), and its proof | (i) HOLDS; (ii) **HOLDS WITH A REPAIR** (R5: the "consequently" needs uniformity in the lattice). Its use of 8.4′ is correct (§4). |
| 213 | the remark after it | HOLDS |
| 214 | what the widening costs | HOLDS (its "the value of *L*" becomes unambiguous after R3) |
| placement | the block sits before the paragraph that reads Hypothesis I on the effective action | recommended move (P), not required |

**No inserted mathematics fails.**
- Proposition 8.4′ and Corollary 8.5F are correct.
- One printed inequality is false: ℓᵧ ≤ δᵧ/2 for complex F. The proof of Theorem 8.5′ never uses it.
- There is one proof gap, in 8.5E's translation-covariance step.
- There is one notation collision, the generator L.
- There are two precision gaps (8.5F(ii); line 189).

Every repair is a line-level text edit. All of them were applied to copies and built:
- `M2RR/rev33_req/` applies the required repairs and gives `req.docx` (144,351 bytes, 92 footnotes).
- `M2RR/rev33_all/` applies the required and the recommended repairs plus the placement and gives `all.docx` (144,992 bytes, 92 footnotes).

Both copies pass M2R's markup rules (`markcheck_region.py`: 52 template literals, 0 defects). `apply_repairs.py` refuses any old string that does not occur exactly once.

The repairs were also checked against the real edit target, the `BLOCK` of `M2R/rev33_l2.py`, read only (`check_block.py`, record `check_block.txt`):
- each of the 25 old strings occurs exactly once in BLOCK and once in `rev33_test/content4.js`;
- BLOCK appears verbatim in `content4.js`.

Editing BLOCK and re-running `rev33_l2.py` on a fresh base therefore gives the same text.

---

## 2. Proposition 8.4′ proved, in the paper's renamed form

**Statement (line 191, (8.8e)).** Let π be a law of (X, W) and δ a bounded function. Put π′ = e^δ π / π(e^δ) and:
- o_X = sup_w osc_x δ;
- o_W = sup_x osc_w δ;
- Δ = sup_{w,w′} osc_x (δ(·, w) − δ(·, w′)).

Then

ρ(π′) ≤ e^{(o_X+o_W)/2} ρ(π) + 1 − e^{−2Δ}.

Here ρ is the maximal correlation, taken as 0 when X or W is a.s. constant.

**Proof.** Let P_X and P_W be the conditional expectations on L²(π), and P₀ the projection onto the constants. Put M_X = L²₀(X) and M_W = L²₀(W). Then P_X = P₀ + P_{M_X} and ρ(π) = ‖P_{M_X} P_{M_W}‖.

*Fact 1.* For F nonconstant, put N(F) = π Var(F|X) + π Var(F|W) = ⟨F, (2I − P_X − P_W)F⟩.
- With G = F − πF we have N(F) = ⟨G, (2 − P_{M_X} − P_{M_W})G⟩.
- Read Halmos' decomposition of the pair M_X, M_W inside L²₀. P_{M_X} + P_{M_W} is 2 on M_X ∩ M_W, 1 on the two mixed summands, 0 on M_X^⊥ ∩ M_W^⊥, and 1 ± C on the generic part.
- If ρ < 1, then M_X ∩ M_W = 0. M_X + M_W ≠ 0 unless both variables are a.s. constant. The supremum of the spectrum is 1 + ‖C‖ when the generic part is present and 1 otherwise; in both cases it is 1 + ρ, since ρ = ‖C‖ or ρ = 0 respectively.
- If ρ = 1, either M_X ∩ M_W ≠ 0 or ‖C‖ = 1.
- Hence inf N/Var = 1 − ρ. This matches line 198 step for step, including the degenerate cases, which the text handles in the words "since X or W is not almost surely constant".

*Fact 2.* Let π″ = hπ with a ≤ h ≤ b.
- π″ Var_{π″}(F|X) = inf_{c(X)} π″|F − c|² ≥ a π Var_π(F|X), and the same holds for W.
- Var_{π″}F = inf_c π″|F − c|² ≤ b Var_π F.
- The Rayleigh quotients therefore compare with factor a/b, and Fact 1 gives 1 − ρ(π″) ≥ (a/b)(1 − ρ(π)). This is Holley–Stroock's argument, credited in the footnote.

*Fact 3.* Let π₁ = (u ⊗ s)π / Z.
- The marginals of π₁ have densities uβ/Z and sζ/Z, where β = π(s(W)|X) and ζ = π(u(X)|W). So f ↦ f√(uβ/Z) and g ↦ g√(sζ/Z) are unitary maps onto L²(π^X) and L²(π^W).
- π₁(f g) = π(a₁f̃ · a₂g̃) with a₁ = √(u/β) and a₂ = √(s/ζ). So T₁ ≅ a₁ T a₂, and the second singular number is invariant.
- For any law, the operator T is id on the constants ⊕ T₀ with ‖T₀‖ = ρ ≤ 1. Its second approximation number is exactly ρ. The upper bound comes from E = 1 ⊗ 1. The lower bound: for any rank-one E, some unit v = α·1 + βg (g mean zero) has Ev = 0, and ‖Tv‖² = |α|² + |β|²‖T₀g‖² ≥ ‖T₀g‖². This step is valid without compactness.
- Hence ρ(π₁) = s₂(a₁Ta₂) ≤ ‖a₁T₀a₂‖ ≤ ‖a₁‖_∞ ‖a₂‖_∞ ρ(π) ≤ (sup u sup s / (inf u inf s))^{1/2} ρ(π), using β ≥ inf s and ζ ≥ inf u.

*Assembly.* Write δ = δ(·, w₀) + [δ(x₀, ·) − δ(x₀, w₀)] + δ₁₂.
- The identity is exact, and |δ₁₂| ≤ Δ.
- With u = e^{δ(·,w₀)} and s = e^{δ(x₀,·)−δ(x₀,w₀)}: sup u / inf u ≤ e^{o_X} and sup s / inf s ≤ e^{o_W}. Also π′ ∝ e^{δ₁₂} π₁, a density between two constants of ratio at most e^{2Δ}.
- So 1 − ρ(π′) ≥ e^{−2Δ}(1 − ρ(π₁)) ≥ e^{−2Δ}(1 − e^{(o_X+o_W)/2} ρ(π)). That is,

ρ(π′) ≤ e^{−2Δ} e^{(o_X+o_W)/2} ρ(π) + 1 − e^{−2Δ} ≤ (8.8e). ∎

The text's proof (lines 195–201) is this proof; I found no gap in it. The intermediate form, with e^{−2Δ} multiplying the first term, is slightly sharper and costs nothing.

Notes on the text, none of which changes the verdict:
- Line 199 writes (F − c(X))². For complex F this should be |F − c(X)|² (O4), or F can be declared real; the operators are real, so the infimum is the same.
- Line 191's tilt e^δπ/π(e^δ) is Proposition 8.4's T_δπ.
- The paper writes a₁ and a₂ for the multipliers. In §8.3, a₀, a_c and aⱼ are lattice spacings, so a rename would help a reader (optional).

---

## 3. Numerical tests: double precision; readings, not certificates

Script: `M2RR/tilt_test.py`, my own numpy code, sharing no line with M2R's `tilt2.c`, `tiltcheck.c` or `l2check.c`. Records: `tilt_seed1.txt`, `tilt_seed2.txt`, `tilt_seed3.txt`.
- Laws: 2–6 states per variable, in five families: flat, heavy-tailed, zero cells, near-diagonal (ρ ≈ 1) and near-product (ρ ≈ 0).
- Tilts: product-only (Δ = 0), mixed-only, pure interaction, and combined, at scales from 0.01 to 3 and beyond.
- o_X, o_W and Δ were read on the product of the marginal supports. This is the stronger test, because those quantities are no larger than the paper's sups over all points.

| test (3 seeds) | number | worst reading | meaning |
|---|---|---|---|
| 8.4′, lhs − rhs | 600,000 | 1.4·10⁻¹⁶ (rounding at ρ = 0); 0 above 10⁻¹² | HELD |
| 8.4′, increment ratio (ρ(π′) − ρ(π)) / (rhs − ρ(π)) | 600,000 | 0.9993 | HELD, nearly tight. Equality at δ = 0 makes plain lhs/rhs uninformative, so the increments are compared instead. |
| 8.4′, first order at δ = 0: slope of ρ against (o_X+o_W)ρ/2 + 2Δ | 60,000 directions | 0.997 | HELD |
| 8.4′, adversarial ascent on (π, δ) maximising the increment ratio | 180 restarts × 1,500 steps | 0.991; the largest lhs − rhs seen was −7.8·10⁻⁵ | HELD |
| Fact 1 (inf N/Var = 1 − ρ, by eigenproblem) | 150,000 | 2.6·10⁻¹⁵ | identity MET |
| Fact 2 | 150,000 | excess 3.8·10⁻¹⁶ | HELD |
| Fact 3 | 150,000 | ratio 0.99990 | HELD; the exponent ½ is sharp (max log(ρ₁/ρ₀)/(o_X+o_W) = 0.4995) |
| Cor 8.5F (i): R / (1 − e^{−Δ(A)}) on 3–4-site systems | 4,500 systems | 0.99990 | HELD, nearly tight (binary sites: equality in 8.5E) |
| Cor 8.5F (ii): Rⱼ against e^{(oᵧ+oᵧ′)/2} R_{j₁} + 1 − e^{−2Δ} | 4,500 systems | ratio 0.905 | HELD |
| (8.8c) with **complex** F, G | 10,496 pairs | 0.808 (variance bound: 0.860) | HELD |
| 8.5E: R² / (C(y,y′) C(y′,y)) | 4,500 systems | 1.000000 | HELD; equality at binary sites |
| 8.1′: norm, χ² identity, norm / δ(Pᵏ) | 800 kernels (seeds 2–3) | absolute error 1.8·10⁻¹⁵; norm/δ ≤ 0.99996 | MET. Seed 1's 2·10⁻⁷ came from the tester on a near-rank-one family, then fixed. |
| ℓᵧ(F) ≤ δᵧ(F)/2 for complex F | 1 exact case | **0.5774** | **FAILS** (R1) |

---

## 4. Corollary 8.5F's use of Proposition 8.4′: correct

(ii), line 211.
- λⱼ ∝ e^{δⱼ} λ_{j₁}, and the two measures are equivalent. So for λⱼ-a.e. ξ (equivalently λ_{j₁}-a.e. ξ) the pair law of (vᵧ, vᵧ′) given ξ is the tilt of λ_{j₁}'s pair law by δⱼ(·, ·, ξ).
- That two-variable function has o_X ≤ oᵧ(δⱼ), o_W ≤ oᵧ′(δⱼ) and Δ ≤ Δᵧᵧ′(δⱼ). These are Proposition 8.4's sups over configurations, which dominate every section.
- (8.8e) at each such ξ, with ρ_ξ^{(j₁)} ≤ R_{j₁} off a common null set, and then the essential supremum, gives the display.
- Summing with weights uses e^{(oᵧ+oᵧ′)/2} ≤ e^{oⱼ} and Σ R_{j₁} e^{κ|·|} ≤ α₁. Both are correct.
- The inputs match those of (8.7), since 1 − e^{−2Δ} ≤ 2(1 − e^{−Δ}), so line 213's claim holds.

(i), line 210. Proposition 8.4's first inequality is applied to the two single-site laws, whose quotient is the exponential of the action difference; Δᵧᵧ′ = Δᵧ′ᵧ; then 8.5E. This is correct for any bounded version of Aⱼ.

The gap is in (ii)'s "consequently" (line 208). Hypothesis I′ quantifies over every lattice of the construction. "Tend to zero" on each lattice gives a threshold rung that depends on the lattice, so the conclusion needs the convergence uniformly in the lattice (R5).

---

## 5. Repairs

### Required

Each repair below gives the exact replacement in `rev33_test/content4.js` and in `rev33_l2.py`'s BLOCK. Each old string occurs once.

**R1 — line 116.** The setting says "for bounded *F* it is at most δᵧ(*F*)/2 … a variance being at most a quarter of the squared oscillation". That is false for complex F, and the insertion is explicitly complex (⟨F, G⟩ = λⱼ(F̄G), "it equals ℓᵧ(F̄)"; Theorem 7.4 uses θf̄).

Counterexample: vᵧ uniform on three points with F = 1, ω, ω² (cube roots of unity). Then Var = 1 and osc = √3, so ℓ/δ = 1/√3 = 0.577 > 1/2. Jung's theorem makes 1/√3 the sharp constant. The elementary bound below suffices.
- old: `and for bounded *F* it is at most δ_{y}(*F*)/2, with δ_{y}(*F*) the oscillation of *F* under changes of *v*_{y} alone, a variance being at most a quarter of the squared oscillation.`
- new: `and for bounded *F* it is at most δ_{y}(*F*)/2 when *F* is real and at most δ_{y}(*F*)/√2 in general, with δ_{y}(*F*) the oscillation of *F* under changes of *v*_{y} alone, a real variance being at most a quarter of the squared oscillation and the variance of a complex function the sum of the variances of its real and imaginary parts, each of oscillation at most δ_{y}(*F*).`

**R1b — line 130.** The implication keeps the same constants, because ℓ ≤ δ is all it needs.
- old: `and ℓ_{y}(*F*) ≤ δ_{y}(*F*)/2. Hypothesis I implies`
- new: `and ℓ_{y}(*F*) ≤ δ_{y}(*F*)/√2 ≤ δ_{y}(*F*). Hypothesis I implies`

**R2 — lines 117–118.** "sup{Cov …}" is meaningless for complex f, g, although the text says the complex and real suprema agree. Separately, "entries lie in [0, 1]" needs a value when a coordinate is a.s. constant. Proposition 8.4′'s proof already assumes that value is 0.
- line 117, old `mr('(y, y′) = sup { '), sub('Cov', sub('π', 'ξ'))`, new `mr('(y, y′) = sup { |'), sub('Cov', sub('π', 'ξ'))`
- line 117, old `sub('v', 'y′'), mr(')) : '), sub('Var', sub('π', 'ξ'))`, new `sub('v', 'y′'), mr('))| : '), sub('Var', sub('π', 'ξ'))`
- line 118, old `for its maximal correlation, the supremum over real or over complex functions being the same;`, new `for its maximal correlation, zero when *v*_{y} or *v*_{y′} is almost surely constant under π_{ξ}, the supremum over real or over complex functions being the same;`

**R3 — lines 148, 152, 154, 155, 164: the generator L.** In §8.3, *L* is "the fixed integer of its construction" (line 67; Theorem 7.4). Line 214 uses it in that sense ("or the value of *L*"), sixty lines after the insertion called the heat-bath generator *L*.

Rename the generator to ℒ at all thirteen occurrences (list: `M2RR/Locc.txt`). The L of L² is untouched.

| line | old | new |
|---|---|---|
| 148 | `` `Let L = Σ_{y∈Y} (K_{y} − I)`` | `` `Let ℒ = Σ_{y∈Y} (K_{y} − I)`` |
| 148 | `and P_{t} = e^{tL} the semigroup` | `and P_{t} = e^{tℒ} the semigroup` |
| 152 | `*I* + *hL* = (1 − \|*Y*\|*h*)*I*` | `*I* + *h*ℒ = (1 − \|*Y*\|*h*)*I*` |
| 154 | `mr('((I + hL)G) ≤ (1 − \|Y\|h)')` | `mr('((I + hℒ)G) ≤ (1 − \|Y\|h)')` |
| 155 | `ℓ((*I* + *tL*/*n*)^{n}*F*)` | `ℓ((*I* + *t*ℒ/*n*)^{n}*F*)` |
| 155 | `(*I* + *tL*/*n*)^{n} → *e*^{tL} in operator norm, *L* being bounded` | `(*I* + *t*ℒ/*n*)^{n} → *e*^{tℒ} in operator norm, ℒ being bounded` |
| 164 | `⟨*F*, −*LG*⟩` | `⟨*F*, −ℒ*G*⟩` |
| 164 | `The kernel of *L* is` | `The kernel of ℒ is` |
| 164 | `since *LF* = 0 gives` | `since ℒ*F* = 0 gives` |
| 164 | `⟨*F*, −*LF*⟩ = 0` | `⟨*F*, −ℒ*F*⟩ = 0` |
| 164 | `self-adjoint operator *L* ≤ 0` | `self-adjoint operator ℒ ≤ 0` |

(The `\|` above escapes the table; the source has a plain `|`.)

**R4 — line 177, Proposition 8.5E.** The proof says that translation invariance of λⱼ makes C^λⱼ(y, y′) depend on y′ − y alone. But C^λⱼ is a supremum over every configuration, so it depends on the versions. Line 214 and the statement both say (8.5) uses everywhere-defined versions. Invariance of λⱼ does not make arbitrary versions covariant, and with non-covariant versions the column sums are not controlled by the row sums.

The claim is true, by translating the version at one point. Hypothesis I for the given versions gives the row bound for the translated ones, row by row, and (8.8d) holds for any versions, since Rⱼ does not depend on them.
- old: `For a translation-covariant block map the blocked measure is invariant under the translations of *Y*, so *C*^{λ}_{j}(*y*, *y*′) depends on *y*′ − *y* alone and the weighted column sums of *C*^{λ}_{j} equal its weighted row sums; then`
- new: `For a translation-covariant block map the blocked measure is invariant under the translations of *Y*, so the translates of the given versions at one coarse point *y*₀ are versions at every coarse point; read with them, *C*^{λ}_{j}(*y*, *y*′) is the given matrix's entry at (*y*₀, *y*₀ + *y*′ − *y*), its weighted row and column sums all equal the weighted row sum of the given matrix at *y*₀, at most α under Hypothesis I, and (8.8d) holds for these versions as for any, *R*_{j} not depending on them; then`

**R5 — lines 208 and 211, Corollary 8.5F (ii).**
- line 208, old `tend to zero, Hypothesis I′ at the rung j₁ with the constant α₁`, new `tend to zero as j → ∞, uniformly in the lattice, Hypothesis I′ at the rung j₁ with the constant α₁`
- line 211, old `which is below any α ∈ (α₁, 1) once the two tails are small.`, new `which is below any α ∈ (α₁, 1) once the two quantities are small, at a rung that the uniformity makes independent of the lattice.`

**R6 — line 189.** The step μⱼ(θf̄)μⱼ(τₜf) = |μⱼ(f)|² uses invariance under θ *and* under τₜ, as the proof (line 188) says. The point of the sentence is "not positivity".
- old: `uses the reflection invariance of μ_{j} alone.`
- new: `uses the invariance of μ_{j} under θ and τ_{t} alone, not its positivity.`

### Recommended (not required for correctness)

**P — placement.** `rev33_l2.py` anchors the block at the end of Theorem 8.5's proof. `PAPER_DRAFT.md`'s own placement note puts it after the paragraph that reads Hypothesis I on the effective action. As converted, that TV paragraph (line 215) comes after its L² twin, Corollary 8.5F (i), and it reintroduces "λⱼ(dv) = e^{−A}dv … the effective action" after (S) has already defined it.

Fix: in `rev33_l2.py` line 15 set `` ANCHOR = "the number that a certificate of the second link must deliver at the coarse scale.`, { before: 120 }));" ``. The string occurs once in the base, checked. `rev33_all/` is built with this placement.

**O1 — line 120, credit.** The maximal correlation is Hirschfeld's (1935) before Gebelein and Rényi.
- old: `[[fn:The maximal correlation is H. Gebelein's,`
- new: `[[fn:The maximal correlation is H. O. Hirschfeld's, "A connection between correlation and contingency", *Proc. Cambridge Philos. Soc.* 31 (1935), 520–524, H. Gebelein's,`

**O2 — line 167, priority sentence of Theorem 8.5D's footnote.** "(8.8c) … is this paper's" rests on what M2R searched: Kassabov, Peyre, and the Liu–Wong–Kong and Amit abstracts. The nearest line not searched is the Helffer–Sjöstrand one, where covariance is dominated, through a maximum principle, by the inverse (fundamental solution) of a comparison operator. That is the same structure as (8.8c), in the gradient currency.

I verified that the citations exist and read Sjöstrand's abstract, which states the maximum-principle domination. I did not read the papers in full.
- old: `under the weighted row sums, is this paper's; it does not follow from the quadratic form, which by polarisation loses the decay, and it is the form Theorem 8.5′ uses.]]`
- new: `under the weighted row sums, is this paper's in the currency of conditional maximal correlations; it does not follow from the quadratic form, which by polarisation loses the decay, and it is the form Theorem 8.5′ uses. Its counterpart in the gradient currency, for measures *e*^{−Φ}*dx*, where the covariance is represented through the inverse of the Witten Laplacian on one-forms and a maximum principle bounds it by the fundamental solution of a comparison operator, is B. Helffer and J. Sjöstrand's, "On the correlation for Kac-like models in the convex case", *J. Statist. Phys.* 74 (1994), 349–409, and J. Sjöstrand's, "Ferromagnetic integrals, correlations and maximum principles", *Ann. Inst. Fourier* 44 (1994), 601–628.]]`

**O3 — line 167, the (S) step.** An F in ∩Hᵧ ⊂ L²(λⱼ) need not be ∏m-integrable, so "integrating out" needs a bounded function of F.
- old: `and integrating out the coordinates one at a time with Fubini's theorem on the product measure shows that it is ∏*m*-almost everywhere constant.`
- new: `and integrating out the coordinates one at a time with Fubini's theorem on the product measure, applied to the arctangents of its real and imaginary parts, which are bounded and have the same property, shows that it is ∏*m*-almost everywhere constant.`

**O4 — line 199, complex F.**
- old `π″((*F* − *c*(*X*))²) ≥ *a* inf_{c} π((*F* − *c*(*X*))²)`, new `π″(|*F* − *c*(*X*)|²) ≥ *a* inf_{c} π(|*F* − *c*(*X*)|²)`
- old `inf_{c} π″((*F* − *c*)²) ≤ *b* Var_{π}(*F*)`, new `inf_{c} π″(|*F* − *c*|²) ≤ *b* Var_{π}(*F*)`

Further optional notes, with no text supplied:
- ρ is overloaded: spectral radius ρ(Rⱼ), maximal correlations ρ_ξ and ρ(π), and ρ = max(e^{−κ}, ρ′), with two of these in one paragraph at line 185.
- D means both (I − Rⱼ)⁻¹ and the dyadic set of Theorem 7.4 (line 185 against line 188). This is inherited from Theorem 8.5's proof.
- χ²(·‖·) is used without a definition at line 105.
- Theorem 8.5D's variance inequality already follows from (8.8c) at G = F̄, since λ_max(D) = (1 − ρ(Rⱼ))⁻¹. The separate proof is correct and redundant.

---

## 6. Line-by-line notes on the items that hold

- **8.1′ (104–111).** ψ₀ is continuous and positive, hence bounded below; U is unitary with UPU⁻¹ = T/λ₀. "λ₀ > λ₁" with multiplicity encodes that λ₀ is simple (Jentzsch). P on L²₀ is T/λ₀ on ψ₀^⊥, so its norm is (λ₁/λ₀)ᵏ. The eigenfunctions ψ/ψ₀ of nonzero eigenvalues are continuous, so the oscillation argument gives ≤ δ(Pᵏ). The density pₖ = tₖ/(λ₀ᵏψ₀ψ₀) gives ∬pₖ² = Tr T^{2k}/λ₀^{2k} and ∬pₖ = 1. All correct, and m_lat = −log(λ₁/λ₀) matches Theorem 7.4's proof. The credits (Saloff-Coste; Levin–Peres–Wilmer ch. 12; Seneta; Dobrushin 1956) are right.
- **(S), Hᵧ, Kᵧ, ℓᵧ, ρ_ξ, Rⱼ (112–120).** Correct apart from R1 and R2. The countable-supremum measurability argument works because C(V) is dense in L² of a finite Borel measure and the normalised covariance is continuous where the variances are positive.
- **II′ ⇒ / I ⇒ I′ (130).** The non-covariant clause, with ½(α + ᾱ) and α + ᾱ < 2, is correct, since Rⱼ ≤ ½(C + Cᵀ) for any versions.
- **8.5A (131–137).** Halmos blocks; ‖(C², CS)‖ = ‖C‖; on the generic part (I − Q)PF = (S·Sx, −C·Sx) and (I − Q)F = (S(Sx − Cy), −C(Sx − Cy)); the trivial summands carry coefficient 0; Minkowski in ℓ² over the summands. All correct.
- **8.5B (138–146).** It needs only H_y ∩ H_y′ ⊇ {functions of ξ}, which is true without (S). The complex-versus-real supremum agree because the operator is real.
- **8.5C (147–155).** h ≤ 1/|Y| ≤ 1; the symmetric Rⱼ gives (Rⱼℓ)_z; the Metzler order is preserved; the norm limits hold. Correct.
- **8.5D (156–167).** E(F, G) = Σ⟨Q_yF, Q_yG⟩; ker ℒ = ∩Hᵧ; P_tG → λⱼ(G); λⱼ(FG) = ⟨F̄, G⟩. The integral converges because it equals ⟨F̄, G⟩ − ⟨F̄, P_TG⟩. ∫e^{−t(I−R)} = (I − R)⁻¹ ≥ 0. The variance step uses ‖e^{−t(I−R)}‖ = e^{−t(1−ρ(R))} for symmetric non-negative R. The weighted row sums give Rⁿe^{κ|·|} ≤ R̃ⁿ. All correct, and complex-ready (tested).
- **8.5E (168–177).** δ(M) ≤ C_ξ(y|y′) C_ξ(y′|y) by submultiplicativity. ‖M‖ on L²₀ ≤ δ(M) by the bounded-function and spectral-projection argument, which needs no compactness and improves on the draft. The binary equality is correct. The only defect is R4.
- **8.5′ (178–188).** Total covariance; II′(a); Theorem 8.5D with (S); II′(b) at f and at g; e(i, k) ≥ d; #{e ≤ n} ≤ N(f)N(g)(2n+1)⁸. K is exactly as stated, without the factor 3. The time-direction block bookkeeping, d ≥ ⌊t/a_c⌋, and Theorem 7.4 with rⱼ = 0 are correct. The statement agrees with Theorem 8.5's word for word, except for Hypotheses I′ and II′ and (S).
- **Line 214.** (S) is used only where it says. None of the listed proofs uses locality, bijectivity or the value of L.
- **Out of scope, base text.** Theorem 8.5's own proof writes G′ = G + 2‖g‖ ∈ [‖g‖, 3‖g‖], which presumes G real. For complex observables it needs the real/imaginary split. Theorem 8.5′'s proof needs no split.

---

## 7. Conversion damage: none found

I compared `PAPER_DRAFT.md` parts 2–6 with the JS, and the JS with the rendered `test.docx`. Every difference from the draft is a deliberate rename:
- (8.5′) → (8.8b) and (8.7′) → (8.8e), with the displays numbered (8.8a)–(8.8e) and (S);
- Y = v_y′ → X′, (X, Y) → (X, W), u ⊗ w → u ⊗ s, α* → ᾱ, and the indices (i, y) → (i, k);
- "coarse map" → "block map";
- Part 1 dropped, because revision 32 carries the widened setting (live line 68);
- "three conditions" → "two", since the reflection-positivity parity is in revision 32's setting.

Every display renders as drafted (`rendered_insert.txt`): subscripts and superscripts intact, nested sub/sup correct (Var_{λⱼ}, (I − Rⱼ)⁻¹, R_{j₁}), and no quantifier moved or dropped. The draft-level statements are the ones above, at the same strength, with the same credits.

---

## 8. Can revision 33 ship as converted?

Not quite. The repairs come first, and they are text-only.
- One false printed inequality: ℓ ≤ δ/2 for complex F (R1 and R1b).
- One proof gap: 8.5E's covariance step (R4).
- One notation collision: L (R3).
- Three precision gaps: R2, R5, R6.

With R1–R6 applied, which is `M2RR/rev33_req/content4.js` (builds, 0 markup defects), the insertion holds as mathematics. Proposition 8.4′ is proved, with numerics, and Corollary 8.5F uses it correctly. P and O1–O4 are recommended; `M2RR/rev33_all/` has everything.

---

## 9. Files in M2RR/

All under `C:\Users\EDWINB~1\AppData\Local\Temp\claude\C--Users-Edwin-Boston-OneDrive-Desktop-III\59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb\scratchpad\math\M2RR\`.
- `tilt_test.py`, `tilt_seed1.txt`, `tilt_seed2.txt`, `tilt_seed3.txt`: the numerical tests and their records.
- `docx_text.py`, `rendered_insert.txt`, `rendered_req.txt`, `rendered_all.txt`: renders of the built documents.
- `find_L.py`, `Locc.txt`: the census of the generator L.
- `apply_repairs.py`, `check_block.py` / `check_block.txt`, `markcheck_region.py`, `rev33_req/`, `rev33_all/`: the repairs applied, checked against `rev33_l2.py`'s BLOCK, and built.

Sources for O2 (citations verified to exist; only Sjöstrand's abstract read):
- [Sjöstrand 1994, numdam](https://www.numdam.org/item/AIF_1994__44_2_601_0)
- [Helffer–Sjöstrand 1994, MaRDI](https://portal.mardi4nfdi.de/wiki/Publication:1292121)
- [Helffer 1998, MaRDI](https://portal.mardi4nfdi.de/wiki/Publication:1266276)
