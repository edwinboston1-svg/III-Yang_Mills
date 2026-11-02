# M3b — (S₁) BAŁABAN'S THEOREM 1 WITH A SOURCE IN THE COUPLING; (D); (E1)/(E2)

Proof agent M3b, 2026-11-02. Work directory `.../scratchpad/math/M3b/`. Appended as the work proceeds; nothing above a
line is edited after it is written except by a dated correction below it. Labels used at their strength: READ (on the
page, rendered image), PROVED (full proof here), PROVED GIVEN [named input], NAMED (an object stated with its falsifier,
not proved), COMPUTED (certified or exact arithmetic, record named).

## 0. Sources (orientation)

Read in full: `math/MATH_BRIEF.md`; `math/M3/WORK.md` §§0–11 (§11 supersedes §8) and its records; `cross/ANSWER.md`;
`read/REPORTS.md` (the M3 and M2 reports in full, the rest swept for the ultraviolet half); III-Yang_Mills
`OPEN/ledger/d4-balaban-the-pages.md` (§§1–15), `d4b-the-cross-scale-comparisons.md` (§§1–7), `beta-uv-the-reading.md`.

THE PRIMARY TEXTS ARE ALL ON DISK — eleven of Bałaban's papers in `C:\Users\Edwin Boston\Downloads\` (M3 §0 and §11.4
believed only CMP 102 (277–309) was present, and that CMP 116 was "not on this machine"; both are present). SHA-256
prefixes (the first five agree with the record's D4b census, which hashed the same downloads):

| Paper | File | SHA-256 (16 hex) |
|---|---|---|
| CMP 95 (1984) 17–40, Propagators … I | 1103941451.pdf | 6f637e4c85941a4d |
| CMP 96 (1984) 223–250, Propagators … II | 1103941783.pdf | 6cc4f26316af0dc7 |
| CMP 98 (1985) 17–51, Averaging operations | Download (5).pdf | 03409ad81885593d |
| CMP 99 (1985) 389–434, Propagators in a background field | 1103942769.pdf | 39f8033b35838c7b |
| CMP 102 (1985) 255–275, UV stability, d = 3 | Download (7).pdf | b10a444f8122d5e1 |
| CMP 102 (1985) 277–309, Variational problem | 1104114383.pdf | 838056b5c578f81d |
| CMP 109 (1987) 249–301 [I] | Download (1).pdf | 1c2d2e500fd1e6a1 |
| CMP 116 (1988) 1–22 [II] | Download (3).pdf | ee39523a0f7b83af |
| CMP 119 (1988) 243–285 [III] | Download (6).pdf | c629e6280329cca4 |
| CMP 122 (1989) 175–202, LFR I [IV] | Download (2).pdf | 4002290ab2d69bd4 |
| CMP 122 (1989) 355–392, LFR II [V] | Download (4).pdf | 80ab1ee09fff0a5b |

Text layers: `src/cmp*.txt` (pdftotext; formulas destroyed). Rendered pages (PyMuPDF from the user site-packages, run as
`python -E -P bin/render.py <pdf> <out> <first page> <pages…>`, so neither the environment nor the data directory enters
sys.path; 110 dpi grey): `render/*.png`. READ ON IMAGE today: CMP 119 pp. 253, 255, 259, 262, 263, 264, 265, 279, 280,
281, 282, 283, 284, 285; CMP 116 pp. 8, 9, 10, 12, 13; LFR I pp. 187, 188, 189; LFR II pp. 365, 366.

## 1. The plan (deep-think synthesis, before deriving)

Decision. (i) Settle M3 §11.1's falsifier on the pages it names AND on the proof of CMP 119's own Theorem 2, which turned
out to be the published localized coupling renormalisation; (ii) read (BB4) at its page; (iii) state (S₁) exactly, build
it on the reference trajectory with the source carried as a coupling-field deviation in the interaction (Bałaban's own
device, LFR I p. 187), renormalised by a LOCAL β-function, and isolate the one estimate the papers lack — CMP 119 (2.43)
with a coupling field — with its proof shape from the papers' own structure and a falsifier; (iv) decide (D) exactly and
prove the weaker statement the gap actually consumes; (v) (E1)/(E2): prove what follows (trajectory convergence,
uniqueness of the bare coupling, the dimension-four classification), name the obstructions.

The lens that moved the plan (pre-mortem). A uniform-in-cutoff source requires the per-step Lipschitz constant of β in the
coupling to be SUMMABLE over the K ≈ log_L(1/ε) steps. Cauchy's estimate turns Lemma C's bound ρ into that constant,
ρ/(θ₀x_k): with the sup-norm form ρ ≤ C(ε₁² + g²) it is O(ε₁²g_k²), and Σ_k g_k² ≍ log K diverges; only the moment-norm
form ρ ≤ C′g² gives O(g_k⁴), summable. So the moment form, which M3 listed as a "standard refinement", is LOAD-BEARING
for (S₁) and must be sourced (it is: CMP 116 p. 8, §3 below). Kill-switch: if the moment form had no published basis,
(S₁) would be uniform only up to a factor K^C.

## 2. M3 §11.1'S FALSIFIER — NOT MET (READ, on the image of every page named)

The falsifier (M3 §11.1): "a line of CMP 119 or LFR I–II that defines the coupling of step k+1 from the complete model's
OWN marginal coefficient (with its own radii) rather than from (I.0.20)".

- CMP 119 p. 253, verbatim: "The final step is renormalization of the effective action. We renormalize it in the region
  Λ₁ subtracting the values at U₁ = 1, and the counterterm β₁(g₀)A(φ₁, U₁), where β₁(g₀) was defined in [I] by the
  formulas (1.41)–(1.43), φ₁ ∈ C₀^∞(Λ₁), φ₁ = 1 on Λ₁^{~−1}. … Let us write the first renormalization group equation
  1/g₀² = 1/g₁²(x) + β₁(g₀)φ₁(x). (1.27) The difference in comparison with Eq. (I.0.20) is that here we have functions on
  the lattice T instead of the constants there, but on Λ₁^{~−1} we have the same equation, which defines the same
  coupling constant g₁."
- CMP 119 p. 259, (2.24): 1/g²_{j−1}(x) = 1/g_j²(x) + β_j(g_{j−1})φ_j(x); "Here the coupling constants g_{j−1} are defined
  as in (I.0.20)". (2.25): E_k(U_k) = Σ_j [E^{(j)}(Λ_j, g_{j−1}, U_k) − E^{(j)}(Λ_j, g_{j−1}, 1) − β_j(g_{j−1})A(φ_j, U_k)].
- CMP 119 p. 279: "The coupling constant renormalization is performed by subtracting β_{k+1}(g_k)A(φ_{k+1}, U_{k+1}) from
  E^{(k+1)} − E^{(k+1)}(1), and by replacing the function g_k^{−2}(·) in the action A(g_k^{−2}(·), U_{k+1}) by
  g_{k+1}^{−2}(·) defined by the equation (2.24) with j = k + 1."
- CMP 119 pp. 279–283, "The Proof of Theorem 2 … an approach to renormalization, which is alternative to the one
  described in Sects. 3–5 [I]": the second-order term of the localized expansion is reduced by the Ward–Takahashi
  identities and Euclidean covariance to (3.57) = β′_j ½Σ_{μ<ν} tr F²_{μν}(z), β′_j = Π^{(j)}_{22,11} (3.61), "The last
  identity can be considered as a possible definition of the β-function. Now we prove that it coincides with the
  definition (I.1.22)", with Π^{(j)} computed from "E^{(j)}(U_j, z) defined on the whole lattice L^{−j}Z^d. This function is
  translation invariant" (p. 281); (3.62)–(3.64) give β′_j = β_j, "This is the required equality."

VERDICT: NOT MET. The complete model never defines a coupling from a marginal coefficient of its own; its one alternative
definition (3.61) is proved equal to (I.1.22) on the same page. M3's §11.1 stands, with three precisions:

(P1) A THIRD MIS-CITATION. CMP 119 p. 253 cites β₁ as "defined in [I] by the formulas (1.41)–(1.43)". CMP 109 has no
(1.41)–(1.43) of its own (its §1 ends at (1.22) on p. 264; the text layer's only "(1.43)" is "(1.43)–(1.54) [14]", a
citation of CMP 99 (75–102)). The definition is (I.1.20)–(I.1.22), which CMP 119 itself cites at p. 282. Beside D4b's two
((I.0.33) in CMP 119 Theorem 1; "(0.31) [II]" in LFR II).

(P2) CMP 119'S OWN THEOREM 2 IS THE PUBLISHED LOCALIZED COUPLING RENORMALISATION (READ, p. 263): "Under the assumptions of
Theorem 1 there exists a constant E₁ independent of j, k, Ω, {Ω_j}, {Λ_j}, T … such that
  |Σ_{z∈Λ_j⁰∩Ω} [E^{(j)}(Λ_j, U_k, z) − E^{(j)}(Λ_j, 1, z)] − β_j(g_{j−1})A(φ, U_k)| ≤ E₁ Σ_{n=j}^{k} (L^{j−n})^β |Γ_n ∩ Ω|, (2.43)
for β < 1, and sufficiently regular configurations U_k". Its proof (pp. 279–283) uses the translation invariance of the
whole-lattice E^{(j)} at exactly one place — "hence Π^{(j)}_{μν,κλ} is independent of z" (p. 281). That sentence is what a
position-dependent coupling breaks; §6 below extends (2.43) past it.

(P3) WHICH FUNCTION THE β OF RECORD IS (a precision of M3 §11.1's "the β-functions of record are CMP 109's").
CMP 119's whole-lattice small-field step carries the complete model's cutoffs: the small-field conditions
|U_{k+1}(∂p) − 1| < ε_{k+1}(L^{−1}η)² (3.2) with ε_j = g_jA₀(log g_j^{−2})^{p₀} = g_jp₀(g_j) (2.4), and the fluctuation
condition |V_k(b)V^{(k)}(b)^{−1} − 1| < 2δ_k (3.3), δ_k = g_kA₁/A₀ p₀(g_k) (p. 265) — in the rescaled field B (gB the
fluctuation's angle) a threshold 2(A₁/A₀)p₀(g_k), a power of log g_k^{−2}; CMP 109/116's is ε₁g_k^{−1} (CMP 116 (1.34)).
"The configuration U_k … coincides with a U_n-type configuration, but the difference is seen in bounds only" (p. 280).

LEMMA P3 (the two β's agree to all orders in g). Let β_j^{III}, β_j^{I} be (I.1.22) applied to the whole-lattice
small-field expressions of CMP 119 and of CMP 109 at the same coupling sequence. Then
  |β_j^{III} − β_j^{I}| ≤ C exp(−c(log g_{j−1}^{−2})^{2p₀}) / (g_{j−1}C₁(log g_{j−1}^{−2})^{q₁})²,
smaller than every power of g_{j−1}.
PROOF. The two one-step integrands agree on the smaller fluctuation domain |B| < 2(A₁/A₀)p₀(g); they differ by the
integral over the shell 2(A₁/A₀)p₀(g) ≤ |B(b)| < ε₁/g at some bond, whose Gaussian mass under the constrained measure
(covariance bounded uniformly, CMP 95 (1.67)) is ≤ C|Y| exp(−c p₀(g)²) per localization domain Y, with the interaction
bounded on the shell by CMP 116 (1.36) and the polynomial bounds (1.39)–(1.40). The histories differ by the same kind of
term at each earlier step, entering the step's fluctuation form at relative order g² (M3 §5.3 (B0)) and summed with the
exponential localization; so the localized whole-lattice expressions differ, on the complete model's analyticity domain
U_j^c(X, α_{0,j}, α_{1,j}) of radii α_{i,j} = g_jC_i(log g_j^{−2})^{q_i} (2.28), by ≤ C exp(−c p₀(g)²)e^{−κd_j(X)}. β is a
second background derivative at the trivial background followed by a second moment (I.1.20)–(I.1.22): Cauchy at radius
α_{1,j} costs α_{1,j}^{−2}, and the localization makes the moment sum converge. Since p₀ > 1, exp(−c(log g^{−2})^{2p₀})
beats every power of g, the factor α₁^{−2} = O(g^{−2}polylog) included. ∎
CONSEQUENCE. Lemma C (M3 §5.4), proved in CMP 109's model with absolute radii, holds for the sequence of record with an
additive error smaller than every power of g. The divergence M3 found for CMP 119's radii (C E₀g²/α₁⁴) never enters:
CMP 119's radii touch only the shell difference, whose own smallness absorbs them.

## 3. (BB4) — READ AT ITS PAGE (M3 §11.4 listed it as inferred, CMP 116 "not on this machine")

CMP 116 p. 12, the expansion of the fluctuation integral, verbatim in structure:
  ∫dμ_{C^{(k)}}(B)χ_k exp[Σ_{Y∈D_k} V_k(Y, B)] = Σ_{D⊂D_k} Π_{Y∈D} ∫₀¹dt(Y) ∫dμ_{C^{(k)}}(B)χ_k exp[Σ_{Y∈D} t(Y)V_k(Y, B)] Π_{Y∈D} V_k(Y, B), (2.1)
followed by the decomposition of the cutoff χ_k = Σ_P (−1)^{|P|}χ_{k,Y₀}χ^c_{k,P} (2.3) and the conditioning (2.5)–(2.6).
The interaction enters ONLY through its terms V_k(Y, B), each multiplied by an interpolation parameter t(Y) ∈ [0, 1],
and is bounded ONLY through CMP 116 Lemma 1 (p. 9): V′_k(Y, U, J, B) "defined and analytic on the space
U^c_{k+1}(Y, (1+β)α₀, (1+β)α₁, α₀) × {B : |B| < ε₁g_k^{−1} on Y}" (1.34), with "|V′_k(Y, U, J, B)| ≤ E₀ε₁C₁M^q exp C₂κ₁
exp(−(1 − 2δ)κd_k(Y))" (1.36) (absolute constants), and, for the Wilson part P^{(k)} where the factor 1/g_k² forbids an
absolute bound, the bounded polynomial (1.39)–(1.40) (p. 10).
VERDICT: M3's (BB4) — the cluster expansion of ⟨·⟩_s uniform in s ∈ [0, 1] — is READ: a uniform s is the case
t(Y)·s ∈ [0, 1] of (2.1), and V ↦ sV preserves (1.36) and (1.39)–(1.40) with the same constants.
THE MOMENT FORM IS ON THE SAME PAGE SPREAD. CMP 116 p. 8, after (1.29): "Another possibility is to use the expression
g_k|B| instead of ε₁. It gives a better bound, but the above is simpler." This is Bałaban's own statement that each
interaction factor can carry g_k|B| (integrable against the Gaussian) in place of the sup constant ε₁ — the basis of
Lemma C's moment form ρ ≤ C′g² (M3 §5.4 (iii)). Status: the moment form is PROVED GIVEN this sentence (Bałaban states the
possibility and does not write the bounds out); §1 explains why (S₁) needs it and Theorem 2 does not.

## 4. Dated corrections to M3's file (2026-11-02, recorded here; M3's file untouched)

(a) M3 §0, §11.4: "only CMP 102 [15] on disk", "CMP 116 is not on this machine" — FALSE; all eleven papers are on disk
(§0). (b) M3 §11.4 first bullet ((BB4) inferred) — superseded by §3: READ. (c) M3 §11.1 "the β-functions of record are
CMP 109's" — precise form: (I.1.22) applied to CMP 119's whole-lattice small-field expression, equal to CMP 109's up to
the shell term of Lemma P3. (d) The record's D4b B3/B4 mis-citations gain a third, (P1).

## 5. (S₁) STATED EXACTLY

NOTATION. Bałaban's J is his curvature variable (U^c(X, α₀, α₁), CMP 99 (3.127)); the source amplitude is called τ here.
Bare lattice T_ε ⊂ T (the unit-scale torus of the papers), ε = L^{−K}; h̃ ∈ C^∞(T) real, h(p) := h̃(x(p)), x(p) the
initial point of ∂p in unit-scale coordinates; O(h) := Σ_p h(p)(1 − Re tr U_p) (tr normalised, M3 §4: x = 1/g_B² is Wilson's
β; O(h) ≈ (1/8)∫h̃ Σ_{μ<ν}F^a_{μν}F^a_{μν} in the geometric normalisation, the leading-order RG-invariant density). The
generating functional is Bałaban's partition function at the bare coupling FIELD x₀(p) = x₀ − τh(p):
  Z_K(τ) := ∫Π dU exp(−Σ_p (x₀ − τh(p))(1 − Re tr U_p)) = Z_K(0)·⟨e^{τO(h)}⟩.                                  (5.1)
THE LINEAR IDENTITY (PROVED). Every renormalisation transformation T_j (CMP 109 (0.17)–(0.19): an integral of the density
against δ-constraints on block averages, with gauge fixing) is linear and positivity preserving in the density;
ρ₀(·; τ) = ρ₀(·; 0)e^{τO(h)}. Hence, for the exact transformations (no cutoffs),
  ρ_k(V; τ) = ρ_k(V; 0)·E_{μ_K}[e^{τO(h)} | V_k = V],                                                         (5.2)
the conditional cumulant generating function of the action density given the scale-k block variables — M3's object (S) at
f = O(h). Every ρ_k(V; ·) is entire in τ at finite K (an integral over a compact group of an entire integrand).

THE STATEMENT (S₁). d = 4, SU(2), block factor L odd (CMP 109's centred averaging, (0.3)–(0.4)), the reference
trajectory (x_j)_{j≤K} of Theorem 2 (M3 §5.1) with unit-scale coupling X = x_K. There are θ₀ > 0 and C (independent of K,
T_ε and h̃) such that for complex τ with |τ|·‖h̃‖_∞ ≤ θ₀X/(4e^{Cγ²}):
 (i) THE COUPLING FIELD. The densities ρ_k(·; τ) have Bałaban's form (CMP 119 (2.18)–(2.25); LFR II Theorem 1) with the
   Wilson coefficient the complex field x_k + D_k(·), and
     D_k(z) = −τ·m_k·h(z) + R_k(z),   m_k := Π_{j<k}(1 − ∂_xβ_{j+1}(x_j)),   |R_k(z)| ≤ C|τ|g_k²(‖∂²h̃‖_∞ + |τ|g_k²‖∇h̃‖²_∞),   (5.3)
   with ∂_xβ_{j+1} the coupling derivative of the step's β (Lemma C′), and the multiplier obeys
     |m_k − 1| ≤ e^{Cγ²} − 1,   m_K = (β(x_K)/β(x₀))(1 + O(γ⁴)) → 1 + (4b₁/b₀)g_K² + O(g_K⁴) as K → ∞            (5.4)
   (§6.4: the source multiplies the trace anomaly);
 (ii) THE VACUUM PART IS LOCAL. log Z_K(τ) − log Z_K(0) = V_K(τ) + W_K(τ), V_K(τ) = Σ_{j=1}^{K} Σ_{z∈T^{(j)}} v_j(z; D_{j−1}) a sum
   over scales of c-numbers each depending on D_{j−1} only within O(1) scale-j blocks of z (the subtracted values at U = 1 of
   CMP 119 p. 279, now τ- and position-dependent), W_K(τ) the remainder;
 (iii) THE FINITE PART. W_K is analytic in τ on the disc, |W_K(τ)| ≤ C|τ|‖h̃‖_∞(1 + |supp h̃|) uniformly in K; for
   h̃ = Σ_i τ_i h̃_i the mixed derivatives at τ = 0 with separated supports are bounded uniformly in K and decay exponentially in
   the separation at every scale below the unit scale;
 (iv) THE UV STABILITY BOUNDS hold for |ρ_k(·; τ)| with Re(x_k + D_k) ≥ (1 − θ₀/2)x_k in place of x_k (LFR II (0.1)).
∂_{τ₁}∂_{τ₂}log Z_K at τ = 0 with dist(supp h̃₁, supp h̃₂) > 0 is the connected two-point function of the action density at
separated points — the 0⁺⁺ channel — and (ii) says the contact terms are exactly the local part V_K.

## 6. WHAT IS PROVED

### 6.1 The construction and the one device (PROVED: it is a choice)

Everything is built on the reference trajectory (τ = 0): the cutoffs χ_k and thresholds ε_j, δ_j (CMP 119 (2.4), (3.2),
(3.3)), the large-field decompositions, the backgrounds U_k(V) (minimisers of the REFERENCE Wilson action, CMP 102 Thm 1),
the propagators (CMP 95, 96, 99) and the gauge fixing. The source enters only as the coupling-field deviation D_k(·) of the
Wilson coefficient, PUT INTO THE INTERACTION exactly as LFR I does for its own coupling fields (READ, p. 187: "we have to
replace the function (g_k^{(n)}(·))^{−2} in the Wilson term of the action by g_j^{−2}, the term with the difference
(g_k^{(n)}(·))^{−2} − g_j^{−2} is put into the interaction"; its interaction (1.60) carries A(1/(g_k^{(n)}(·))² − 1/g_j², ·)).
CONSEQUENCE: no cutoff depends on τ, so every term of every expansion is an entire function of τ times a τ-independent
characteristic function; the only analytic structure needed is that the expansions converge uniformly on the τ-disc.

### 6.2 LEMMA C′ — the β-function is Lipschitz in the coupling with constant O(g⁴) (PROVED GIVEN (PI)₀ + the moment form)

For the step k + 1 at reference coupling x = x_k and a CONSTANT complex D, |D| ≤ θ₀x, let β^{(x)}_{k+1}(x + D) be (I.1.20)–
(I.1.22) applied to the whole-lattice step with Wilson coefficient x + D, the reference cutoff and Gaussian, D·[A(U(e^{igCB}V))
− A(U(V))] in the interaction. (PI)₀ is the constant-D case of (PI) (§7): CMP 116's expansion converges on |D| ≤ θ₀x with the
moment-form bound.
LEMMA C′. (a) D ↦ β^{(x)}_{k+1}(x + D) is analytic on |D| < θ₀x. (b) sup_{|D|≤θ₀x}|β^{(x)}_{k+1}(x + D) − a(k + 1)| ≤ 2C′g_k² +
C₁e^{−c₁ε₁²/g_k²}. (c) For |D| ≤ θ₀x/2: |β^{(x)}_{k+1}(x + D) − β^{(x)}_{k+1}(x)| ≤ (8C′g_k⁴ + 4C₁g_k²e^{−c₁ε₁²/g_k²})|D|/θ₀.
(d) For real x′ in the window with |x′ − x| ≤ θ₀x/2: |β_{k+1}(x′) − β_{k+1}(x)| ≤ (8C′g_k⁴/θ₀)|x′ − x| + 3C₁e^{−c₁ε₁²/g_k²}.
PROOF. (a) The integrand of every term of CMP 116 (2.1) is entire in D (D enters linearly in the exponent) and the cutoff is
D-independent; the series converges uniformly on the disc by (PI)₀ (the modulus bounds are all (2.1) consumes, §3); a uniform
limit of analytic functions is analytic, and (I.1.22) is a bounded linear functional of the localized expression (M3 §5.5
(c)). (b) M3's identity (5.C) holds verbatim at complex D (φ(t) = log⟨χe^{tI}⟩ is defined because the expansion converges, so
⟨χe^{tI}⟩ ≠ 0), with I now containing the D-term. The cutoff term is D-independent (Gaussian tails). In ⟨I⟩₀ the D-term's
linear part in B vanishes for constant D — the background is a constrained critical point of A and the fluctuation lies in
ker Q̃ (CMP 109 p. 267: "the third, linear term in (2.10) vanishes") — and its quadratic part (D/x)·½⟨B, Δ_W(V)B⟩ has a
V-INDEPENDENT Gaussian expectation: by the Faddeev–Popov identity the V-dependence of the constrained Gaussian integral does not
depend on the gauge-fixing weight, so rescaling the Wilson part by (1 + D/x) is, up to a V-independent constant, rescaling the
whole quadratic form, whose log-determinant changes by the V-independent ½n log(1 + D/x). So the one-loop value at coupling
x + D is a(k + 1) for every D on the disc, the remaining terms of ⟨I⟩₀ being O(|g_D|²) explicit moments; the variance term
∫(1 − s)M[⟨I; I⟩_s]ds ≤ C′|g_D|² in the moment form (CMP 116 p. 8, §3). |g_D|² = 1/|x + D| ≤ g_k²/(1 − θ₀) ≤ 2g_k² for θ₀ ≤ ½.
(c) Cauchy's estimate for f(D) := β^{(x)}(x + D) − a on the disc of radius θ₀x, at |D| ≤ θ₀x/2: |f(D) − f(0)| ≤ 2|D|·sup|f|/(θ₀x),
and 1/x = g_k². (d) β_{k+1}(x′) (own cutoff) and β^{(x)}_{k+1}(x′) (reference cutoff) differ by the shell between the two cutoffs,
≤ C₁e^{−c₁ε₁²/g_k²} each way; combine with (c). ∎
WHY THE MOMENT FORM IS LOAD-BEARING HERE AND NOT IN THEOREM 2. Theorem 2 needs only ρ < c. A source carried over K steps needs
Σ_k sup|∂_xβ_{k+1}| < ∞: with the sup-norm form (ρ ≤ C(ε₁² + g²)), (c) gives O(ε₁²g_k²) and Σ_k g_k² ≍ (1/c)log K diverges; with the
moment form it gives O(g_k⁴), and Σ_k g_k⁴ converges (§6.3). The order is sharp: β = c + b/x + O(x⁻²) (M3 §4, b = 32b₁ ln L)
has ∂_xβ = −bg⁴.

### 6.3 THE SUMMATION (PROVED, from Theorem 2's profile)

On the trajectory of Theorem 2, x_j ≥ x_K + (K − j)(c − ρ) − 2F (M3 (5.1)), so by D4b's (E4) at κ = 4 (c − ρ > 0 is used):
  Σ_{j≤K} g_j⁴ ≤ (1 − 2Fg_K²)^{−2}(g_K⁴ + g_K²/(c − ρ)) ≤ 2γ²/(c − ρ) for γ small.                                (6.1)
Hence Π_j(1 + 8C′g_j⁴/θ₀) ≤ exp(16C′γ²/(θ₀(c − ρ))) =: e^{Cγ²}: every per-step coupling-Lipschitz product along the trajectory is
bounded uniformly in K. (With the sup-norm form the same product is ≤ K^{Cε₁²/c}: polynomial in log ε^{−1}.)

### 6.4 THE LOCAL FLOW AND THE TRACE ANOMALY (PROVED GIVEN Lemma Σ₁ of §6.5 and Lemma C′)

The renormalisation of step j + 1 absorbs the marginal part of the D-dependent output into the coupling field (CMP 119
p. 279's operation, with a field): by Lemma Σ₁,
  D_{j+1}(z) = D_j(z) − [β^{(x_j)}_{j+1}(x_j + D_j(z)) − β^{(x_j)}_{j+1}(x_j)] − r_{j+1}(z),   D_0 = −τh.                (6.2)
PROPOSITION 6.4. If |τ|‖h̃‖_∞ ≤ θ₀X/(4e^{Cγ²}) then |D_j(z)| ≤ θ₀x_j/2 for all j ≤ K (the self-consistency of Lemma C′'s disc)
and (5.3)–(5.4) hold.
PROOF. Write the bracket as ∂_xβ_{j+1}(x_j)·D_j + q_j with |q_j| ≤ (Cg_j⁴/(θ₀x_j))|D_j|² (second-order Cauchy on the same disc).
Induction on j: |D_{j+1}| ≤ |D_j|(1 + 8C′g_j⁴/θ₀) + |r_{j+1}|, so |D_j| ≤ e^{Cγ²}(|τ|‖h̃‖_∞ + Σ_i|r_i|); since x_j ≥ x_K − 2F the disc
condition binds at j = K, |D_K| ≤ θ₀X/2 under the stated bound (r is of lower order by (6.4)). Linearising, D_k = −τh·m_k + (the
q's and r's propagated by the same products), which is (5.3), and |m_k − 1| ≤ e^{Cγ²} − 1 by (6.1).
THE TWO-LOOP IDENTIFICATION. For an autonomous step map x ↦ x − β(x), m_K = Π(1 − β′(x_j)); log m_K = −Σβ′(x_j) + O(Σβ′²) and
log(β(x_K)/β(x₀)) = −Σ∫_{x_{j+1}}^{x_j}(β′/β)dx = −Σβ′(x_j) + O(Σ(|β″|β + β′²)); with β = c + b/x, β′ = −b/x², β″ = 2b/x³ both
remainders are O(Σg⁶) = O(γ⁴). As x₀ → ∞ (K → ∞ at fixed X), β(x_K)/β(x₀) → (c + b/X)/c = 1 + b/(cX) = 1 + (32b₁/(8b₀))g_K² =
1 + (4b₁/b₀)g_{B,K}² = 1 + (b₁/b₀)g_{YM,K}² (M3 §4's dictionary g_YM² = 4g_B²). This is the ratio (β(g)/g³)_K/(β(g)/g³)_0 of the
trace-anomaly coefficients, θ^μ_μ = (β(g)/(2g³))F²_geom: τ(F²_geom)_bare = τ(2g₀³/β(g₀))θ = τ[(β/g³)_K/(β/g³)_0](F²_geom)_K.
THE SOURCE OF THE ACTION DENSITY COUPLES TO THE RENORMALISATION-GROUP-INVARIANT TRACE ANOMALY, and the construction computes its
normalisation: m_K is the lattice, step-by-step form of the trace-anomaly ratio; the history dependence of β ("it depends also
on all preceding coupling constants", CMP 109 p. 298) changes ∂_xβ_{j+1} by the history-Lipschitz term of §9.1, also O(g⁴). ∎

### 6.5 LEMMA Σ₁ — CMP 119 (2.43) WITH A COUPLING FIELD (THE ESTIMATE THE PAPERS DO NOT CONTAIN; PROVED GIVEN (PI))

STATEMENT. Under (PI) at step j, with |D_{j−1}| ≤ θ₀x_{j−1}/2 and D_{j−1} of class C² in scale-j coordinates with ‖∇D‖ ≤ ω₁,
‖∂²D‖ ≤ ω₂ (scale-j units), for every Ω, φ as in CMP 119 Theorem 2 and sufficiently regular U_k:
  |Σ_{z∈Λ_j⁰∩Ω}{[E^{(j)}(Λ_j, U_k, z) − E^{(j)}(Λ_j, 1, z)] − β_j(z)A(h_zφ, U_k)}| ≤ (1 + Cω₁)E₁Σ_{n=j}^{k}(L^{j−n})^β|Γ_n ∩ Ω|,   (6.3)
with the LOCAL β-FUNCTION
  β_j(z) := β^{(x_{j−1})}_j(x_{j−1} + D_{j−1}(z)) + r_j(z),   |r_j(z)| ≤ Cg_{j−1}²(ω₂ + ω₁²g_{j−1}²/θ₀).                      (6.4)
PROOF. Fix z. Split D = D_z + (D − D_z), D_z := D(z), and interpolate D_t := D_z + t(D − D_z), t ∈ [0, 1]. (1) THE FROZEN PART,
t = 0: the coupling is the constant x_{j−1} + D_z; the whole-lattice expression is translation invariant, and Bałaban's proof
of (2.43) (CMP 119 (3.48)–(3.67), READ pp. 279–283: the Ward–Takahashi reduction (3.49)–(3.56), the Euclidean covariance
(3.58)–(3.60), (3.61) and the identification (3.62)–(3.64), the decomposition (3.65)–(3.67)) applies verbatim at that constant
complex coupling — it uses only the analyticity and bounds of the localized expressions, which (PI)₀ supplies, and the
symmetries, which a constant coupling preserves. It yields (6.3) with β^{(x)}_j(x + D_z). (2) THE VARIATION, t ∈ (0, 1]: by (PI)
the localized terms E^{(j)}(X, U, z; D_t) are analytic in t on a complex neighbourhood of [0, 1] of size ≥ θ₀x/(4|D − D_z|_X),
|D − D_z|_X := sup_X|D − D_z| ≤ ω₁d_j(X); Cauchy gives |∂_tE^{(j)}(X, ·; D_t)| ≤ C|D − D_z|_X g²E₀e^{−κd_j(X)}/θ₀, so the variation
contributes localized terms bounded by Cω₁d_j(X)g²e^{−κd_j(X)}/θ₀, summable over X ∋ z (the factor (1 + Cω₁)). Their MARGINAL
part is Bałaban's second-order expansion around z, the rank-four coefficient tensor of (3.57), evaluated on the variation.
Expand D − D_z = (x − z)·∇D + O(ω₂|x − z|²): the linear term contributes Σ ΔΠ_{μν}(x, y, z)(x − z)_κ(y − z)_λ(u − z)_σ∂_σD — a
RANK-FIVE tensor built from the frozen model, invariant under the hypercubic group W(B₄) of the centred averaging (CMP 119
(3.58)–(3.60)); −1 ∈ W(B₄) acts on rank-five tensors by −1, so it VANISHES. The first non-vanishing contributions are linear in
∂²D and quadratic in ∇D (second-order Cauchy, 1/θ₀x = g²/θ₀): (6.4). The non-marginal parts are irrelevant terms of Bałaban's
type and enter E₁. ∎
WHAT THE EXTENSION CHANGES IN THE PUBLISHED PROOF: exactly one sentence — "This function is translation invariant, hence
Π^{(j)}_{μν,κλ} is independent of z" (CMP 119 p. 281) — is replaced by the frozen-coupling expansion plus the parity argument.
In scale-j units ω₁ = |τ|‖∇h̃‖_∞L^{j−K}, ω₂ = |τ|‖∂²h̃‖_∞L^{2(j−K)}: Σ_j r_j converges geometrically, dominated by the last steps,
which is the R_k of (5.3).
FALSIFIER of Lemma Σ₁: a marginal coefficient LINEAR in ∇D, i.e. a nonzero W(B₄)-invariant rank-five tensor in the frozen model.
Impossible with −1 in the symmetry group; possible only if the averaging is not centred (CMP 109 (0.3)–(0.4) centre it for odd
L; for even L the inversion about a block centre must be checked before (6.4) is used).

### 6.6 STAKES (written before the instrument `bin/m3b_checks.py` runs)

S-A (the group facts Lemma Σ₁ and §10 use; exact, by averaging characters over all 384 signed permutations of ℝ⁴):
dim of W(B₄)-invariants on Sym²(Λ²ℝ⁴) = 1 (only Σ_{μ<ν}F²_{μν}); on (ℝ⁴)^{⊗5} = 0; on (ℝ⁴)^{⊗1} = 0; on (ℝ⁴)^{⊗3} = 0;
on Sym²(ℝ⁴) = 1; on Λ⁴ℝ⁴ (the ε-tensor, F∧F's coefficient) = 0.
S-B (the two-loop multiplier, certified intervals, 50 digits): for the universal step map x ↦ x − c − b/x (c = 8b₀ ln L,
b = 32b₁ ln L, L = 3), run backward from X so that x_K = X, the product m_K = Π_{j<K}(1 + b/x_j²) and the ratio
β(x_K)/β(x₀) = (c + b/X)/(c + b/x₀) agree to relative 10⁻³ at X = 4 for K = 10, 100, 1000, and both tend to
1 + b/(cX) = 1 + (4b₁/b₀)/X = 1.0391468… at X = 4 as K grows (UNGUESSED: the sign and size of the K = 10 deviation).

### 6.7 RESULTS (record `checks_run.2026-11-02a.txt`, rc = 0; nothing in §6.6 edited)

S-A HELD, every entry, exactly (Fractions over all 384 elements): Inv Sym²(Λ²ℝ⁴) = 1; Inv ℝ⁴ = Inv (ℝ⁴)^{⊗3} = Inv (ℝ⁴)^{⊗5} = 0;
Inv Sym²(ℝ⁴) = 1; Inv Λ⁴ℝ⁴ = 0. (Hand proof beside it: a sign flip of e_μ kills every off-diagonal entry Q(e_{μν}, e_{ρσ}) of an
invariant form on Λ², permutations equalise the diagonal; −1 ∈ W(B₄) kills every odd rank; the ε-tensor is odd under one flip.)
S-B, certified (mpmath.iv, 50 digits; c(3) = 0.40814655732352530412…, b(3) = 0.063910560808054764470…, 4b₁/b₀ = 0.15658728381088564677…):

| X | K | x₀ | m_K = Π(1 + b/x_j²) | β(x_K)/β(x₀) | relative difference |
|---|---|---|---|---|---|
| 4 | 10 | 8.18670 | 1.018161219390623 | 1.019644065531676 | −1.454·10⁻³ |
| 4 | 100 | 45.1818 | 1.033583634492741 | 1.035557873169792 | −1.906·10⁻³ |
| 4 | 1000 | 412.859 | 1.036756532223417 | 1.038752847542483 | −1.922·10⁻³ |
| 8 | 10 | 12.1445 | 1.006316609621505 | 1.006594679442392 | −2.762·10⁻⁴ |
| 8 | 100 | 49.0929 | 1.015846799253237 | 1.016331709601247 | −4.771·10⁻⁴ |
| 8 | 1000 | 416.759 | 1.018690917671480 | 1.019190473649123 | −4.901·10⁻⁴ |

(interval widths ≤ 6·10⁻⁴⁸.) THE STAKED 10⁻³ AGREEMENT IS REFUTED AT X = 4 (−1.45…−1.92·10⁻³) and holds at X = 8. The
deviation scales as X⁻² = g_K⁴ (ratio 3.92 between X = 4 and X = 8 at K = 1000): it is §6.4's O(γ⁴) remainder, measured — its
leading part Σ_j|β″(x_j)|β(x_j) ≈ ∫2bc x⁻³dx/c = bg_K⁴ (= 4.0·10⁻³ at X = 4, half of it in the log) has the observed size. The
β-ratio tends to the staked limit 1 + (4b₁/b₀)g_K² (1.038753 at x₀ = 413 against 1.039147; the gap is b/(cx₀) = 3.8·10⁻⁴), and the
product sits below it by O(g_K⁴). The identification m_K = 1 + (b₁/b₀)g_{YM,K}² + O(g⁴) HOLDS.

## 7. (BB4) — WHAT CMP 116 STATES, WHAT FOLLOWS, AND THE EXACT LEMMA (answer to the second reader M3R, items 2d and closing)

M3R (REVIEW.md, 2d): (BB4) enters (a) the M–∫ds interchange, (b) bound (iii) uniformly in s with complex backgrounds, (c) the
moment form, (d) the s = 0 end; "the robust form to check: the cluster expansion is analytic in a COMPLEX s on |s| ≤ 1 + δ".

7.1 ON THE PAGE (READ today, rendered). (α) CMP 116's expansion (2.1), p. 12, consumes the interaction only through the terms
t(Y)V_k(Y, B), t(Y) ∈ [0, 1], and the products Π_{Y∈D}V_k(Y, B); then the cutoff decomposition (2.3) and the conditioning (2.5)–(2.6)
— neither involves V. (β) The interaction's hypotheses are Lemma 1, p. 9: analyticity on U^c_{k+1}(Y, (1+β)α₀, (1+β)α₁, α₀) ×
{|B| < ε₁g_k^{−1} on Y} (1.34), localization (1.35), the MODULUS bound (1.36); for the Wilson part, the bounded polynomial
(1.39)–(1.40), p. 10, after the zeroth- and first-order terms in B′ "vanish". (γ) p. 15 (the record's reading, D4b §5): "the
activities in (2.13), and the whole sum E^{(k+1)}(X), are analytic functions of (U, J), on the space U^c_{k+1}(X, α₀, α₁)" — the
expansion is run at COMPLEX backgrounds, where V′_k is complex-valued for real B; so no step of it can use Re V ≤ 0, e^V ≤ 1 or any
positivity of V: it uses |V|. (δ) p. 8: "Another possibility is to use the expression g_k|B| instead of ε₁. It gives a better
bound, but the above is simpler."

7.2 PROVED FROM 7.1. (a)–(b) at s ∈ [0, 1] and (d): CMP 116's theorem applies to the interaction sV for every s ∈ [0, 1] — sV obeys
(1.34)–(1.36) and (1.39)–(1.40) with the same constants, the vanishing of the Wilson part's zeroth and first orders is preserved by
scaling, and by (γ) nothing else about V is used — and to V = 0, which is the s = 0 end: log⟨χ_k⟩_G and its localization are CMP
116's construction with the interaction switched off ((2.3)–(2.7) handle the correlated Gaussian and the non-product cutoff
whatever V is). So φ(s) = log⟨χ_k e^{sI}⟩ has CMP 116's localized representation with s-uniform bounds on [0, 1], analytic in
complex backgrounds; M3R's item (d) is covered by the same theorem at V = 0.

7.3 THE EXACT LEMMA (NAMED; the only inference left in (BB4)). LEMMA BB4*: there is η₀ > 0, depending only on the constants of
CMP 116's (1.36), (1.39)–(1.40) and on κ, κ₁, M, such that for every COMPLEX s with |s|ε₁ ≤ η₀ the conclusion of CMP 116 holds for
the interaction sV with s-independent constants.
PROOF SHAPE. For complex s the interaction sV satisfies (1.34)–(1.35) as it stands and (1.36), (1.39)–(1.40) with the BOUND's
factor ε₁ replaced by |s|ε₁, the domain {|B| < ε₁g_k^{−1}} unchanged. Each use of the interaction in the expansion is linear in its
bound (activities are products of interaction factors; Cauchy coefficients in B are sup/radius^n with the radius the domain's);
the exponentials |e^{t sV}| ≤ e^{|s||V|} and the Gaussian domination of |s|ε₁|B′|² need only |s|ε₁ ≤ η₀ ≤ ¼.
FALSIFIER: a step of CMP 116 in which ε₁ enters other than (i) as the cutoff radius ε₁g_k^{−1} or (ii) as the factor of an
interaction bound — e.g. a smallness of the bound used to choose a Cauchy radius, or ε₁ ≤ 1 used where |s|ε₁ ≤ η₀ is not.
(The case |s| ≤ 1 + δ that M3R names is BB4* at η₀ = (1 + δ)ε₁, i.e. "ε₁ smaller by the factor 1 + δ", which is inside Bałaban's
own order of choices.)

7.4 WHAT BB4* GIVES (PROVED GIVEN BB4*). Put f_X(s) := E_X(s) − E_X(0), the localized terms of φ(s) − φ(0); every polymer of the
difference carries at least one interaction factor.
 (sup form) |f_X(s)| ≤ C|s|ε₁e^{−κ′d(X)} for |s|ε₁ ≤ η₀; on |s| = R := η₀/ε₁ this is Cη₀e^{−κ′d}; Cauchy at |s| ≤ 1 ≤ R/2 gives
   |∂_s²E_X(s)| ≤ (8C/η₀)ε₁²e^{−κ′d(X)}: sup_{s∈[0,1]}|M[⟨I; I⟩_s]| ≤ C″ε₁² — M3's bound (iii), with M's two background
   derivatives by Cauchy on the absolute polydisc (7.1 (γ)) and the M–∫ds interchange by dominated convergence of the absolutely
   convergent localized sums: M3R's (a) and (b).
 (moment form, 7.1 (δ)) With g_k|B| in place of ε₁, each interaction factor carries g_k against a Gaussian moment, so
   |f_X(s)| ≤ C|s|g_k e^{−κ′d} on |s| ≤ 1 + δ, and Cauchy gives |∂_s²E_X(s)| ≤ C(1 + δ)g_kδ^{−2}e^{−κ′d}: ρ_{k+1} ≤ Cg_k + C₁e^{−c₁ε₁²/g_k²}.
   The order g_k² needs the expansion with two marked insertions of I (each carrying g); g_k¹ is what Cauchy gives.
 SUFFICIENCY. For Theorem 2 the sup form suffices (ρ < c with ε₁ shrunk first). For the rate g₀ ~ (8b₀ ln ε⁻¹)^{−1/2} that M3R notes
   is not given by the sup form, and for (S₁)'s uniformity (§6.2–6.3), ANY ρ_k ≤ Cg_k^a with a > 0 suffices: ∂_xβ = O(g^{2+a}) and
   Σ_j g_j^{2+a} ≤ (1 − 2Fg_K²)^{−(2+a)/2}(g_K^{2+a} + 2g_K^a/(a(c − ρ))) by D4b (E4) at κ = 2 + a > 2. So the moment form at the
   power a = 1 — the Cauchy consequence of Bałaban's own p. 8 sentence — carries everything §6 uses. CORRECTION, dated, to §6.2–6.3:
   "the moment form ρ ≤ C′g²" there may be read with C′g in its place; the constants change, the summability does not
   (Σ g_j³ ≤ Cg_K/(c − ρ)).

## 8. (PI) — THE ONE ESTIMATE (S₁) NEEDS BEYOND THE PAPERS, STATED WITH ITS FALSIFIER (NAMED)

(PI) THE PARAMETRIZED INDUCTION. Bałaban's induction — CMP 109 Theorem 3 (small field), CMP 116 (cluster expansion), CMP 119 §3
(the complete step), LFR I–II (the R-operation) — run on the reference trajectory with a complex coupling-deviation field D_k(·)
carried in the interaction (§6.1), |D_k| ≤ θ₀x_k/2 and D_k of class C² at the step's scale, closes with constants independent of
D_k, every localized term analytic in D_k on that polydisc, and the large-field estimates holding with Re(x_k + D_k) ≥ (1 − θ₀/2)x_k
in the Wilson weight. (PI)₀ := the case of constant D_k (used by Lemma C′); (PI)_H := the same with the history E_k varied on a
complex segment E + ζ(E′ − E) inside CMP 116 p. 15's room (α′₀, α′₁ "much bigger than α₀, α₁") — used in §9.
WHY IT IS THE SAME INDUCTION (READ): the expansion consumes the interaction only through t(Y)V(Y) and modulus bounds, at complex
backgrounds (§7.1); LFR I (1.60) already carries real coupling-field deviations in the interaction of a small-field fluctuation
integral and treats them "as in Sect. 3 [III]" (p. 189); LFR II uses the Wilson coefficient only through positivity (p. 366: "the
Wilson coefficient is used as positive" is the record's summary; the page's own concern is extending the configuration to G^c and
recovering "a small perturbation of a positive Wilson action").
WHAT IS NEW IN IT: (a) the deviation is persistent (all K steps) and macroscopic (supp h̃ at the unit scale), so its output in
SMALL-field regions must be renormalised rather than sent to the boundary terms B_k (LFR I p. 189 sends C_k^{(n+1)} to B_k) —
this is Lemma Σ₁ (§6.5, PROVED GIVEN (PI)); (b) the deviation is complex.
FALSIFIER of (PI): a step of the induction that uses (i) the reality of the Wilson coefficient beyond Re > 0 (a monotonicity or
convexity in the coupling; a minimisation of the τ-WEIGHTED action — the construction minimises only the reference action);
(ii) the exact constancy of the coupling inside a small-field region other than at CMP 119 p. 281 (which Lemma Σ₁ replaces);
(iii) a coupling-dependent cutoff evaluated at the field x_k + D_k rather than at the reference x_k.

THEOREM S₁ (STATUS). (S₁)(i)–(iv) of §5 hold, PROVED GIVEN (PI) and the moment form at any power a > 0 (§7.4, Bałaban's p. 8):
(i) is Proposition 6.4 with Lemmas C′ and Σ₁; (ii) is the vacuum subtraction "values at U = 1" of CMP 119 p. 279 performed with the
field (a c-number at each step, localized by the expansion, depending on D_{j−1} near z); (iii) is the analyticity of every term in
τ (§6.1) with the uniform convergence of (PI) — W_K is the sum of the localized non-vacuum terms meeting supp h̃, each O(|τ|) by the
D-linear interaction and Cauchy — and the separation decay is the localization e^{−κd_j(X)} of the terms meeting both supports;
(iv) is the large-field part of (PI). The connected correlations of the action density at separated points are then the τ-derivatives
of W_K, and M3's Theorem 6.5 turns (S₁) into Hypothesis II's ultraviolet half (Forms β, γ) for the 0⁺⁺ channel, given (P_LF).

## 9. (D): STATED EXACTLY, DECIDED, AND REPLACED BY WHAT THE GAP CONSUMES

SETTING (M3R's repair of Prop. 6.6(ii) adopted). Block map: Bałaban's centred averaging over blocks of odd side, reflection
covariant: θ maps coarse observables supported at least one block above the time-zero plane to coarse observables of the same
lattice, and time shifts are reduced to u₀ = 0 by [f] = e^{−u₀H}[τ_{−u₀}f]. H_c⁰ := closed span{[F] : F a bounded coarse observable
supported at positive times, any shift} (contains Ω), H_c := H_c⁰ ⊖ CΩ (M3's space).
(D), EXACTLY: H_c = Ω^⊥, i.e. H_c⁰ = H, in the physical Hilbert space reconstructed from all observables admitted to the limit.

9.1 H_c⁰ REDUCES H (PROVED). Time translates of positive-time coarse observables are positive-time coarse observables, so H_c⁰ is
invariant under the self-adjoint contraction e^{−aH} for a in the shift set; a closed subspace invariant under a bounded self-adjoint
operator reduces it, so P_c⁰ commutes with e^{−aH}, hence with its functional calculus, hence with every spectral projection of H.

9.2 (D) IS FALSE IN FINITE VOLUME, EVEN FOR THE FREE FIELD (PROVED). Free massive field (or the free abelian gauge field, Bałaban's
linearisation) on a spatial torus of side ℓ = Na_c, block averages over a_c-cubes. The one-particle vector of a linear block
observable ⟨χ_{C+u}, φ⟩ is e^{−ωu⁰ + ip·u}χ̂_C(iω(p), p), and χ̂_C(iω, p) ∝ Π_{i=1}^{3}(e^{ip_ia_c} − 1)/(ip_i). The momentum
p* = (2π/a_c, 0, 0) is a torus momentum (p₁ = 2πN/ℓ) at which the factor vanishes, so the one-particle state |p*⟩ (energy
(m² + 4π²/a_c²)^{1/2} > 0) is orthogonal to every linear block vector; polynomials in block averages create Fock vectors over the
closed span of those one-particle vectors, so |p*⟩ ⊥ H_c⁰. Bałaban's construction is on the torus T; (D) can therefore only be an
infinite-volume statement, where the free field satisfies it by Wiener's condition (M3 §6.6: the zero set of the symbol is null on
every mass shell).

9.3 DECISION: (S₁) + THE SMALL-FIELD BOUNDS DO NOT GIVE (D). They are statements about conditional laws of fine observables given
coarse ones; such statements bound the distance of particular vectors to H_c⁰ and cannot show that the reducing subspace (H_c⁰)^⊥ is
{0} — 9.2 exhibits a non-empty (H_c⁰)^⊥ under exactly such bounds (the free field satisfies every fibre bound). In infinite volume,
(D) is a statement about the joint spectral measure of (H, P) on the hyperplanes p_i ∈ (2π/a_c)ℤ∖{0} — it would follow, at the
linearised level, from its absolute continuity in p, which Euclidean invariance (E2) supplies on every mass shell. (D) is OPEN and
tied to (E2).

9.4 PROPOSITION D∞ — WHAT THE GAP CONSUMES INSTEAD (PROVED). Let f be a bounded fine observable supported at times ≥ δ > 0,
s ≥ 0, F̂_s := E[τ_sf | v] (v all coarse variables) and F_s := E[τ_sf | v₊] (v₊ those of blocks at positive time). Then
  dist(e^{−sH}[f], H_c⁰)² ≤ ‖[τ_sf] − [F_s]‖² ≤ |λ(Cov_ν(Θτ_sf̄, τ_sf | ·))| + E_λVar_λ(F̂_s | v₊).                        (9.1)
PROOF. g := τ_sf − F_s; ‖[g]‖² = S(Θḡ·g) (OS inner product). Condition on v: S(Θḡg) = λ(Cov_ν(Θḡ, g | v)) + λ(E[Θḡ|v]E[g|v]). By
reflection covariance and Θ-invariance of μ, E[Θḡ | v] = Θ(E[ḡ | v]), so the second term is ≤ ‖E[g|v]‖²_{L²(λ)}, and E[g|v] =
F̂_s − E[F̂_s | v₊] (tower, σ(v₊) ⊂ σ(v)), whose squared norm is E_λVar_λ(F̂_s | v₊). In the first term F_s and ΘF̄_s are
v-measurable and drop out of the conditional covariance. [τ_sf] = e^{−sH}[f] for s in the shift set. ∎
COROLLARY D∞. Assume Hypothesis I at a_c (Dobrushin, sup over boundary data — inherited by the conditional measure λ(·|v₊)), the
averaged fibre clustering (II.a-avg) |λ(Cov_ν(f, g|·))| ≤ K′N‖f‖‖g‖ρ′^{d/a_c}, and Form γ, ‖δ_yF̂‖_{L²(λ)} ≤ C N‖f‖e^{−κ₂d(y, S(f))}
(M3 §6.7). By the L² Dobrushin inequality for λ(·|v₊) (M2 Thm 2.3), E Var(F̂_s|v₊) ≤ C Σ_{y∉v₊}‖δ_yF̂_s‖² ≤ C′N³‖f‖²e^{−2κ₂(s+δ)}, and
the first term of (9.1) is ≤ K′N‖f‖²ρ′^{2(s+δ)/a_c}. So ‖e^{−sH}(1 − P_c⁰)[f]‖ ≤ Ce^{−m′s}, m′ := min(κ₂, log(1/ρ′)/a_c), for s → ∞
in the shift set, whence the spectral measure of (1 − P_c⁰)[f] vanishes on [0, m′); and P_c⁰[f] − S(f)Ω ∈ H_c carries no spectrum in
(0, κ/a_c) (Prop. 6.6(ii) with M3R's repair). Hence ψ_f = [f] − S(f)Ω has NO SPECTRUM IN (0, min(κ/a_c, m′)), for every fine f.
WHAT THIS SETTLES. The gap of the full theory does not need (D): it needs Hypothesis I plus the AVERAGED fibre clauses — exactly
the forms the ultraviolet half delivers (M3 Thm 6.5 from (S) + (P_LF); for the action density from (S₁)), with the window fibre's
averaged clustering (M3 Thm 6.3) the crossover's part. H = H_c⁰ ⊕ (H_c⁰)^⊥, both reducing H; the coarse part has the gap κ/a_c, the
fine-generated part the fibre's rate m′. (Consistent with M2's Theorem 8.5-L², which reaches the same gap by the covariance route.)

## 10. (E1): WHAT FOLLOWS, AND THE OBSTRUCTION

10.1 PROPOSITION E1-a (THE BARE COUPLING IS UNIQUE UP TO THE CUTOFF'S SHELL; PROVED GIVEN (PI)₀, (PI)_H). Let x₀ < x₀′ both reach
x_K = x′_K = X. Then x₀′ − x₀ ≤ δ_bare := C e^{−c₁ε₁²(X − 2F)}/(1 − e^{−c₁ε₁²(c − ρ)}), independent of K.
PROOF. D_j := x′_j − x_j. By Lemma C′(d) and (PI)_H (Cauchy in the history: |β(x; E) − β(x; E′)| ≤ Cg²‖E − E′‖_j/E₀, each past step's
output Lipschitz in its coupling with constant E₀g_i²/θ₀ and propagated with the factor L^{−β(j−i)} of (2.43)),
|D_{j+1} − D_j| ≤ C′g_j⁴ sup_{i≤j}|D_i| + 3C₁e^{−c₁ε₁²/g_j²}. Gronwall with (6.1): D_K ≥ D₀e^{−C″γ²} − C‴Σ_j e^{−c₁ε₁²x_j}, and
x_j ≥ X + (K − j)(c − ρ) − 2F sums the tails geometrically. D_K = 0 forces D₀ ≤ δ_bare. ∎ With Bałaban's analytic-variant cutoff
(g_k/γ_k)ε₁ (CMP 109 p. 266) the tails vanish and the bare coupling g₀(ε, g) of Theorem 2 is unique and increasing in g.

10.2 PROPOSITION E1-b (THE RENORMALISED TRAJECTORY CONVERGES; PROVED GIVEN (PI)_H). For y_i^{(K)} := x^{(K)}_{K−i} (the coupling i
steps below the unit scale, cutoff K, unit coupling X), |y_i^{(K)} − y_i^{(K′)}| ≤ Ce^{C″γ²}L^{−β(K−i)} for K < K′: the trajectories
at fixed distance from the unit scale form a Cauchy sequence. PROOF: the two histories at distance l from the unit scale differ by the
steps beyond distance K, whose influence there is O(L^{−β(K−l)}) by (2.43)–(2.45), and by the coupling differences, propagated by
the Gronwall estimate of 10.1. ∎

10.3 THE OBSTRUCTION TO (E1), EXACTLY. Convergence of the laws of coarse observables needs the unit-scale DENSITIES ρ_K (all their
large-field configurations {Ω_j, Λ_j}) to converge as K → ∞: a two-cutoff comparison of the complete model — that the R-operation
of LFR I–II is Lipschitz in its input density in a norm in which the deep-past differences are O(L^{−βm}). Not stated in the papers;
its small-field part is (PI)_H. And the infinite-volume limit of the torus theory at the unit scale is not an ultraviolet question:
the unit-scale theory is a weak-coupling lattice theory at coupling γ, and its infinite-volume limit is the crossover's (Theorem 8.5).

## 11. (E2): WHAT FOLLOWS, AND THE OBSTRUCTION

11.1 THE MARGINAL SYMMETRY RESTORATION (PROVED; COMPUTED S-A). W(B₄)-invariant quadratic forms on Λ²ℝ⁴: exactly one, Σ_{μ<ν}F²_{μν},
which is O(4)-invariant; invariants of odd rank: none, so with the reflection symmetry of the centred averaging no dimension-five
term exists; the ε-tensor is not W(B₄)-invariant (no θ-term; and no pseudoscalar coefficient can be built from a scalar coupling
field, ε^{μνρσ}∂_μh∂_νh… vanishing by antisymmetry), so the marginal part of every effective action — CMP 119 (3.61), and Lemma Σ₁'s
local β-function — is O(4)-invariant, and O(4) breaking starts at dimension six.
11.2 WHY THIS DOES NOT GIVE (E2). Bałaban's irrelevance bound (2.43) carries (L^{j−n})^β per block and does not separate O(4)-breaking
from O(4)-invariant irrelevant terms; summed over j ≤ n it is dominated by the steps just below the observation scale, which are the
observation lattice's own artefacts — a property of the blocking (axis-aligned cubes), not of the theory. No estimate on the lattice
side can turn them into rotation covariance.
11.3 THE OBSTRUCTION, EXACTLY: ORIENTATION UNIVERSALITY. For R ∈ SO(4), the limit theory built from the R-rotated bare lattice equals
the R-image of the limit theory, on the algebra generated by rotation-covariant observables (the O(h)'s). Through the renormalisation
group at a_UV this is an identity between the two unit-scale theories S_∞ and S_∞^R — two weak-coupling lattice theories whose
infrared behaviour is the crossover's — so (E2) is an infrared statement, not reachable by the ultraviolet half. The short-distance
form (E2-UV): the O(4)-breaking part of the action-density two-point function at separation r is o(1) as r/a_UV → 0, uniformly in the
cutoff — NAMED; its proof shape is (S₁) at scales below r plus a bound on the coarse theory's response to two nearly coincident
sources.

## 12. THE LEDGER (this agent's rows; READ = on the rendered page today)

| Item | Status | Where |
|---|---|---|
| all eleven Bałaban papers on disk, hashed | READ | §0 |
| M3 §11.1's falsifier | NOT MET (CMP 119 pp. 253, 259, 279; (3.61)–(3.64) pp. 282–283) | §2 |
| CMP 119 Theorem 2 (2.43) = the published localized coupling renormalisation | READ | §2 (P2) |
| third mis-citation: CMP 119 p. 253 "(1.41)–(1.43)" | READ | §2 (P1) |
| β of record vs CMP 109's β: equal to all orders in g | PROVED (Lemma P3) | §2 (P3) |
| (BB4) uniform in s ∈ [0,1], complex backgrounds, s = 0 end | READ + PROVED (CMP 116 (2.1), Lemma 1, p. 15) | §7.1–7.2 |
| Lemma BB4* (complex s-disc, |s|ε₁ ≤ η₀) | NAMED, proof shape + falsifier | §7.3 |
| sup_s|M⟨I;I⟩_s| ≤ Cε₁²; ρ ≤ Cg + tails (moment form, Cauchy) | PROVED GIVEN BB4* (resp. CMP 116 p. 8's form) | §7.4 |
| (S₁) stated exactly; linear identity (5.2) | STATED; PROVED | §5 |
| Lemma C′ (∂_xβ = O(g^{2+a})) | PROVED GIVEN (PI)₀ + moment form | §6.2, §7.4 |
| summation, multiplier bounded uniformly in K | PROVED | §6.3 |
| local flow; source multiplies the trace anomaly, m_K → 1 + (b₁/b₀)g²_{YM,K} | PROVED GIVEN Σ₁, C′; COMPUTED (S-B) | §6.4, §6.7 |
| Lemma Σ₁ (CMP 119 (2.43) with a coupling field; local β; parity) | PROVED GIVEN (PI) | §6.5 |
| (PI) | NAMED, falsifier | §8 |
| Theorem S₁ (i)–(iv) | PROVED GIVEN (PI) + moment form | §8 |
| W(B₄) invariant dimensions | COMPUTED exactly (S-A) | §6.7, §11.1 |
| (D) false in finite volume (free field) | PROVED | §9.2 |
| (D) from (S₁) + small-field bounds | NOT GIVEN (decided) | §9.3 |
| Prop. D∞: gap for fine vectors from Hyp. I + averaged II, no (D) | PROVED | §9.4 |
| bare coupling unique up to δ_bare; trajectory converges | PROVED GIVEN (PI)₀, (PI)_H | §10.1–10.2 |
| (E1) full; (E2) | OBSTRUCTIONS NAMED (two-cutoff R-operation; orientation universality) | §10.3, §11.3 |

## 13. THE PRECISE NEXT OBJECT

(PI) at its first and decisive instance, Lemma BB4* WITH A D-TERM: CMP 116's expansion for the interaction sV + D·[A(U(e^{igCB}V))
− A(U(V))], complex s with |s|ε₁ ≤ η₀ and complex constant D with |D| ≤ θ₀x, in Bałaban's g_k|B| (moment) norms — checked line by line
against CMP 116 §§1–2 (pp. 3–17, on disk) for the falsifier of §7.3 (every ε₁ a cutoff radius or a bound factor) and the falsifier
(i) of §8. It gives at once Lemma C′, the moment-form Lemma C (hence g₀ ~ (8b₀ ln ε⁻¹)^{−1/2}), Proposition E1-a, and the frozen part
of Lemma Σ₁; the variable-D part then needs only the parity argument already proved.

## 14. CROSS-FIELD UNIFICATIONS FOUND

(U1) (S₁) IS THE LATTICE FORM OF OSBORN'S LOCAL RENORMALISATION GROUP. Position-dependent couplings as sources for the composite
operators they multiply (Jack–Osborn; Osborn, Nucl. Phys. B 363 (1991) 486): here the source of tr F² is a coupling field, its flow is
the local Callan–Symanzik equation (6.2), the c-number part V_K(τ) is the local counterterm functional of the generating functional,
and the multiplier m_K = Π(1 − ∂_xβ) is the step-by-step trace-anomaly ratio (β/g³)_K/(β/g³)_0 — computed (S-B) to agree with
1 + (b₁/b₀)g² up to O(g⁴). The renormalisation-group invariance of θ^μ_μ = (β/2g³)F² is what makes the source bounded across K steps.
(U2) THE COUPLING LIPSCHITZ CONSTANT IS A CAUCHY ESTIMATE IN A SOURCE. Lemma C′ turns a sup bound ρ on a disc of relative radius θ₀
into ∂_xβ ≤ 2ρg²/θ₀ — the same mechanism that turns a moment generating function's analyticity into cumulant bounds (Lee–Yang /
Marcinkiewicz-type), and it shows why only a VANISHING ρ (any power of g) makes asymptotic freedom carry a source across all scales.
(U3) (D) IS A WIENER TAUBERIAN CONDITION ON A MOMENTUM SPECTRUM, AND IT FAILS EXACTLY ON A LATTICE OF MOMENTA. The block symbol's
zeros p_i ∈ (2π/a_c)ℤ∖{0} are null in infinite volume and are torus momenta in finite volume (9.2): the same phenomenon as the
alias zeros of a sampling kernel (Shannon–Nyquist: a box-car sampler annihilates exactly its harmonics). Whether an interacting
spectral measure charges those hyperplanes is decided by Lorentz invariance — so (D) and (E2) are one question.

## 15. DATED CORRECTIONS AND READINGS AFTER §§0–14 (2026-11-02; nothing above edited)

15.1 THE BLOCK GEOMETRY, READ (CMP 109 pp. 252–254, rendered; until now cited from M3 and the record). p. 252: "B^k(y) = Δ(y) ∩
T^{(n−k)}_{L^{−k}δ} (0.3) [Δ(y) is a continuous space cube with a center at y and with the size δ]"; contours G(y, x) for
"x − y = Σ δn_μe_μ (… n_μ an integer such that |n_μ| ≤ (L − 1)/2)", "generated by all such permutations"; and "[the definition of
[12]] is not symmetric with respect to lattice Euclidean transformations. Preserving this symmetry is very important for the method;
therefore it is necessary to modify the definition." p. 253: the average (0.4) over x ∈ B(c₋) and both contour families, with the
group average M obeying M({U_j^{−1}}) = M({U_j})^{−1} (0.5), covariance (0.6), permutation invariance (0.7); p. 254: the variant
(0.12), "both definitions are equally good for our purposes". So L ODD (the block is the centred cube |n_μ| ≤ (L − 1)/2), the averaging
CENTRED, and the inversion about a coarse site (n ↦ −n maps B(y) and the contour families to themselves) a symmetry: −1 ∈ W(B₄) acts
on the frozen model of Lemma Σ₁, as §6.5 and §11.1 require. The clause is READ.

15.2 THE EXPONENT UNDER THE MOMENT FORM AT POWER a. With ρ_k ≤ Cg_k^a (§7.4; a = 1 from Cauchy on |s| ≤ 1 + δ) Lemma C′(c) reads
∂_xβ = O(g^{2+a}), (6.1) becomes Σ_j g_j^{2+a} ≤ Cγ^a/(a(c − ρ)), and every e^{Cγ²} of §§5–6 and §10 is e^{Cγ^a}: in (S₁)'s hypothesis
|τ|‖h̃‖_∞ ≤ θ₀X/(4e^{Cγ^a}), in (5.4) |m_k − 1| ≤ e^{Cγ^a} − 1, in Proposition 6.4 and in δ_bare. The two-loop identification
m_K = (β(x_K)/β(x₀))(1 + O(γ⁴)) of §6.4 is a property of the explicit map β = c + b/x and is unaffected; the history-dependent
remainder of β adds O(γ^a) to |m_K − 1|. The ledger row "Theorem S₁ … moment form" means "the moment form at any power a > 0".

15.3 LEMMA C′(b)'S GAUGE-FIXING STEP, STATED AS ITS INPUT. The rescaling B ↦ (1 + D/x)^{−1/2}B returns the Wilson part of the
quadratic form to its reference size and multiplies the gauge-fixing weight by (1 + D/x) (α ↦ α(1 + D/x)); the V-dependence of the
gauge-fixed constrained Gaussian integral is independent of α (Faddeev–Popov: the Faddeev–Popov determinant does not depend on α);
the Jacobian (1 + D/x)^{−n/2} is V-independent. INPUT: the α-independence of Bałaban's gauge-fixed Gaussian at fixed background,
up to the cutoff's (non-gauge-invariant) shell, which is O(e^{−c₁ε₁²/g²}) and enters the tails already carried.

15.4 THE BLOCK-FACTOR COLLISION (what moved, for the crossover). The ultraviolet half's block map — Bałaban's centred average, L odd
(15.1) — is the map that Lemma Σ₁'s parity, §11.1's classification and M3R's repair of Prop. 6.6(ii) (reflection plane through a
layer of block centres) all need. THE GROUND's Theorem 8.5 chain uses L = 2 half-open blocks, the convention M3R's counterexample
breaks. The interface needs ONE block map at a_c: either the crossover adopts the centred odd-side map, or the reflection plane and
the reflection covariance are re-established for L = 2 by another construction.
