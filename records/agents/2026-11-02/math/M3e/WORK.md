# M3e — CMP 102 SECT. G (189)–(190) CARRIED OUT; THE CMP 99 RANDOM-WALK EXPANSIONS AUDITED AS CMP 116 USES THEM

Proof agent M3e, 2026-11-02. Work directory `.../scratchpad/math/M3e/`. Appended as the work proceeds; nothing above a line
is edited after it is written except by a dated correction below it. Labels: READ (on the rendered page image, today),
PROVED (full proof here), PROVED GIVEN [named input], NAMED (stated with falsifier, not proved), COMPUTED (record named).

## 0. Sources

Read first: `math/MATH_BRIEF.md`; `math/M3c/WORK.md` §§0–12; `math/M3R/REVIEW.md` (the (B-iv) paragraph and the
"runner-up" paragraph); `math/M3b/WORK.md` §0 (the census of the eleven papers, SHA-256 prefixes).

Primary texts (SHA-256 prefixes re-hashed today, agree with M3b §0):
- CMP 102 (1985) 277–309, "The variational problem and background fields in renormalization group method for lattice gauge
  theories", `C:\Users\Edwin Boston\Downloads\1104114383.pdf`, 838056b5c578f81d. (The assignment's title "Propagators for lattice
  gauge theories in a background field" belongs to CMP 99 389–434; the equations (189)–(190) are in CMP 102 277–309, p. 308.)
- CMP 99 (1985) 389–434, "Propagators for lattice gauge theories in a background field", `...\1103942769.pdf`, 39f8033b35838c7b.
- CMP 109, 116, 119, 122a/b as in M3b §0.
NUMBERING OF CITATIONS. CMP 116's reference list is "[1] CMP 109 and references therein"; CMP 109's list (text layer p. 299, to be
read on image) gives [13] = CMP 99 389–434, [14] = CMP 99 75–102 ("Spaces of regular gauge field configurations…", NOT ON DISK),
[15] = CMP 102 277–309, [16] = CMP 102 255–275, [26] = Cammarota CMP 85 (not on disk). Inside CMP 102 277–309 the list is its own:
[4] = CMP 98, [5] = CMP 99 389–434, [6] = CMP 99 75–102 (not on disk).

Rendering: `bin/render.py` (PyMuPDF, `python -E -P`), 150 dpi grey, `render/cmp102_<page>.png`, `render/cmp99_<page>.png`.
Journal page = PDF index + first page (CMP 102: 34 PDF pages for 33 journal pages, the last PDF page trailing).

## 1. WHAT (189)–(190) ASSERT (READ, CMP 102 p. 308, image `render/cmp102_308.png`)

(185) (δ²V/δA′²)(A′)𝔄 = (d/dτ)(δV/δA′)(A′ + τ𝔄)|_{τ=0} = (1/2πi)∮_{|τ|=r} dτ/τ² (δV/δA′)(A′ + τ𝔄),
      r = max{|A′|_{(−1)}, |∇A′|_{(−2)}}·(max{|𝔄|_{(−1)}, |∇𝔄|_{(−2)}})^{−1};
(186) "from Proposition 4": |(δ²V/δA′²)(A′)𝔄|_{(−3)} ≤ 4C₄ε₃ max{|𝔄|_{(−1)}, |∇𝔄|_{(−2)}};
(187) |G̃(δ²V/δA′²)(𝒜₀ + H₀B)𝔄|_{(−1)}, |∇G̃(δ²V/δA′²)(𝒜₀ + H₀B)𝔄|_{(−2)} ≤ O(1)B₀C₄B₅ε₁ max{|𝔄|_{(−1)}, |∇𝔄|_{(−2)}}
      "for ε₁ sufficiently small, hence the norm of the linear operator is small also";
(188) 𝔄₀ = (I + G̃(δ²V/δA′²)(𝒜₀ + H₀B))^{−1}(G̃Δ^{(2)}H₀ − G̃(δ²V/δA′²)(𝒜₀ + H₀B)H₀), by Neumann series;
then, verbatim: "To prove an exponential decay we have to investigate more closely the kernel ((δ²/δA′²)V)(A′). This is,
unfortunately, a very awkward and complicated problem, although quite straightforward. Already the first derivative of V is
complicated and given by many formulas, see (85), (88), (89), (90), (93). Now we have to differentiate those expressions second
time. We do not perform these calculations here, we have obtained all necessary results to do the calculations and estimates,
let us formulate a final result only. We have
(189) |Δ(y)(δ²/δA′²)V(A′)𝔄| ≤ O(1)ε₃(L^jη)^{−3} exp(−¼δ₀d(y, y′)) max{|𝔄|_{(−1)}, |∇𝔄|_{(−2)}},
      for supp 𝔄 ⊂ Δ̃(y′), A′ satisfying (77), y ∈ Λ_j.
This inequality, the formula (188) and Lemma 2.1, and finally Proposition 2 and (181), yield
(190) |δ𝓗_μ(B,x)/δB_ν(y′)|, |∇_x δ𝓗_μ(B,x)/δB_ν(y′)|, ‖ζ∇ δ𝓗(B)/δB(y′)‖_β, |D^{η*}_{U_k}D^η_{U_k} δ𝓗_μ(B,x)/δB_ν(y)|, |Δ^η_{U_k} δ𝓗_μ(B,x)/δB_ν(y′)|
      ≤ O(1)[(L^jη)^{−1}, (L^jη)^{−2}, (‖ζ‖^ξ_β + |ζ|)(L^jη)^{−2−β}, (L^jη)^{−3}, (L^jη)^{−3}]·(L^{j′}η)^{−d} exp(−⅛δ₀d(y, y′))
      for x ∈ Δ(y), or supp ζ ⊂ Δ̃(y), y ∈ Λ_j, y′ ∈ Λ_{j′}."
(The fourth entry is printed with δB_ν(y), not δB_ν(y′); a misprint, the right side carries y′ — recorded, not corrected silently.)

