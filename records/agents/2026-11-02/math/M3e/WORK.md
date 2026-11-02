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

## 2. THE OBJECTS (READ, CMP 102 pp. 277–309 on image, every page of §§A–E and G; CMP 96 pp. 231–235; CMP 99 pp. 396–427, 433–434)

2.1 GEOMETRY. Ω₀ ⊃ Ω₁ ⊃ … ⊃ Ω_k, Ω_j a union of big blocks of size M₁L^jη, (L^jη)^{−1}dist(Ω_j^c, Ω_{j+1}) > RM₁ (CMP 102 (1)).
Λ_j = Ω_j^{(j)}∖Ω_{j+1}^{(j)}, 𝔅_k = ∪_j Λ_j (p. 277). A site y ∈ Λ_j carries the block Δ(y) = B^j(y) (side L^jη) and the cube
Δ̃(y) of side 2L^jη centred at y (CMP 99 p. 397). Scale ℓ(y) := L^jη. The fine lattice is T_η, η = L^{−k}.
THE DISTANCE (CMP 96 (2.46), READ p. 231): d(y,y′) = inf_Γ Σ_j (L^jη)^{−1}|Γ ∩ B^j(Λ_j)| over admissible contours (scaled length);
d(x,x′) := d(y(x),y(x′)) for fine points; triangle inequality (2.54) (READ p. 233).
LEMMA 2.1 OF CMP 96 (READ p. 234, proof pp. 232–233, checked): for 0 < α < 1, c₀(α) := Σ_{z∈ℤ}e^{−αδ₀|z|} < 4/(αδ₀),
c₁(α) := 12c₀(½α)^d, and RM with ¼αδ₀RM > 2d log c₀(½α) + 1 (2.59):
  (2.60) e^{−αδ₀d(y,y′)} ≤ e^{−αδ₀RM max{|j−j′|−1,0}};  (2.61) sup_y Σ_{y′} e^{−αδ₀d(y,y′)} ≤ c₁(α);
  (2.63) Σ_{y₁…y_{n−1}} e^{−δ₀d(y,y₁)}⋯e^{−δ₀d(y_{n−1},y′)} ≤ c₁(α)^n e^{−(1−α)δ₀d(y,y′)}.
(Lemma 2.1 holds verbatim with δ₀ replaced by any δ > 0 for which (2.59) holds with δ — the proof uses δ₀ only through (2.59).)
NORMS (CMP 99 (3.39)–(3.41), READ p. 397): |A| sup norm, |∇A| = max sup|(D_μA_ν)(x)|, |A|_{(α)} = sup_j sup_{b∈Ω_j∖Ω_{j+1}}(L^jη)^{−α}|A(b)|.
Write m(A) := max{|A|_{(−1)}, |∇A|_{(−2)}}.

2.2 THE OPERATOR CLASS BAŁABAN USES (READ: CMP 96 (2.51)–(2.55) p. 232; CMP 99 (3.42) p. 397). An operator K "decays at rate δ
with scale power p and constant C" — write K ∈ 𝒪(C; p; δ) — if
  |(Kλ)(x)| ≤ C ℓ(y)^p e^{−δd(y,y′)} |λ|   for x ∈ Δ(y) (or x = y for block-valued K), supp λ ⊂ Δ(y′) (or λ = λ(y′)1_{y′}).
Examples on the page: G′ ∈ 𝒪(B₀; 2; δ₀), ∇G′ ∈ 𝒪(B₀; 1; δ₀) (CMP 99 Theorem 3.1, (3.42)); G (Theorem 3.3); H, ∇H (CMP 99 (3.133) with the
normalization factor (L^jη)^{−1} of (3.109)–(3.110), p. 422; = CMP 102 (46), (69)): H ∈ 𝒪(B₀; −1; δ₀), ∇H ∈ 𝒪(B₀; −2; δ₀);
(QGQ*)^{−1} as a block-to-block kernel (CMP 99 (3.132)): |(QGQ*)^{−1}(y,y′)| ≤ O(1)ℓ(y)^{−2}ℓ(y′)^{−d}e^{−δ₁d(y,y′)}, i.e. in 𝒪(O(1); −2; δ₁)
for the block measure ℓ(y′)^d; 𝔇 (CMP 102 (73)): |𝔇(A′;c,b)| ≤ O(1)C₃ε₃ℓ(y)^{−d+1}e^{−½δ₀d(c₋,y)}, b ∈ B^j(y) (fine-to-block, η^d measure).
δ₀ is "a common, best possible decay rate for all these operators" (CMP 99 p. 423, READ), depending on d, L only.

2.3 THE FUNCTIONAL (READ). A(e^{iηA}U₀) = A(U₀) + ⟨A,J⟩ + ½⟨A,Δ_πA⟩ + V₀(A) (41), V₀(A) = Σ_p η^dV₀(A,∂p) STRICTLY LOCAL (30),
J = D*η^{−2}Im∂U₀, |J| < C₁B₃ε₁(L^jη)^{−3} (28). Linearizing transformation A = A′ − HD(A′) (47), D(A′) the fixed point of
X ↦ C_j(L^jηA′ − L^jηHX) on Λ_j (49)–(50), C_j the nonlinear part of the average, |C_j(L^jηA)| ≤ C₂(L^jη)²|A|² (44), contraction
for 9C₂B₀ε₃ ≤ ½ (54), |D(A′)| ≤ 4C₂|A′|²_{(−1)} (55); 𝔇 := δD/δA′ = (I + 𝔑)^{−1}L^{j(·)}η(δC/δA)(A′ − HD(A′)) (70), 𝔑 :=
L^jη⟨(δC_j/δA)(L^jη(A′ − HD(A′))), H⟩ with kernel bound 9C₂B₀ε₃ℓ(y′)^{−d}e^{−δ₀d} (69), (I + 𝔑)^{−1} kernel ≤ 2ℓ(y′)^{−d}e^{−½δ₀d} by
Lemma 2.1 (71), |L^jη δC_j/δA| ≤ L^jη ℓ^{−d}C₃2ε₃ by Prop. 5 of CMP 98 (72). Then (74)–(81):
  V(A′) = −⟨HD₃(A′),J⟩ − ⟨A′,Δ_πHD(A′)⟩ + ½⟨HD(A′),Δ_πHD(A′)⟩ + V₀(A′ − HD(A′))   (80),
D₃ = D − D^{(2)}, D^{(2)}(A′) = C^{(2)}(A′) = C_j^{(2)}(L^jηA′) on Λ_j (78). Prop. 4 (97)–(98): |(δV/δA′)(A′)|_{(−3)} ≤ C₄m(A′)² for m(A′) ≤ a₃.
THE IDENTITY USED BELOW (READ, CMP 102 (137) = CMP 99 (3.122), (3.126) with RD*H = 0 and L^jηQ_jH = I (45)):
  Δ_πH = Q*(QGQ*)^{−1}(L^{j(·)}η)^{−1} − Q*a(L^{j(·)}η)^{−1},   hence   H*Δ_πH = (L^{j(·)}η)^{−1}[(QGQ*)^{−1} − a](L^{j(·)}η)^{−1}
(H*Q* = (QH)* = (L^jη)^{−1}). Δ_π itself is NOT local: Δ_π = Δ − Δ′_π with Δ′_π built from G′ and R (CMP 99 (3.120), READ p. 419).

2.4 WHERE (189)–(190) ARE USED (READ at every site).
 (i) CMP 102 itself: (189) only to prove (190) (p. 308); (190) is the last clause of Proposition 9 (p. 309).
 (ii) CMP 109 p. 271: "The derivative δH_j/δB is an exponentially decaying function, with the decay rate δ₀ on the ξ-scale, see
     Proposition 9, (190) [15]", giving (3.9): |δH_j| ≤ B₃exp(−½δ₀dist^{(ξ)}(X,□) − ½δ₀M(L^jη)^{−1})·2L^jη|ζ_□H_k(B′)| "and the same for
     derivatives and the second order operators applied to it"; p. 273 (3.17) "following from (3.9)"; p. 274 the same decay used again;
     p. 280: (3.54) |∫(1−τ)⁴/4!⟨δ⁵E^{(j)}/δB⁵, ⊗B⟩| ≤ E₀α₃^{−5}|B|⁵e^{−κd_j(X)}, which "holds on □̃⁴ only … if at least one factor has a
     localization in (□̃⁴)^c, then the expression can be estimated by an arbitrary power of L^jη using the exponential decay properties"
     — i.e. (190) again. (CMP 109 p. 263's "From Proposition 9 [15]" uses the regularity clause (19)–(21) of Prop. 9, not (190).)
 (iii) CMP 116 (READ pp. 2–7): §1 does NOT use (190). It localizes H_k by decoupling the propagators H, G̃, H₀ in their random-walk
     expansions ((1.6)–(1.11): "In these equations we can replace the propagators by arbitrary operators having the same regularity
     properties … Only these bounds were important in the analysis of Sect. C, E [15]"), using Sect. G only for the REPRESENTATION
     (1.2)–(1.4) = CMP 102 (179)–(180), and CMP 102 (55), (57), (80), (98). BUT its Lemma 1 bound (1.24) is obtained "using (I.3.54)"
     (p. 7), and (I.3.54) uses (190) (item (ii)). So: (190) → CMP 109 (3.9), (3.17), (3.54) → CMP 116 (1.24) → Lemmas 1–2 → V_k ∈ 𝒱(E₀C₁ε₁)
     (M3c Lemma M) → Theorem BB4*, Lemma W, Lemma C/C′ (M3c §§3–7). (189) enters only through (190).
 (iv) CMP 119 p. 266 (3.7): "By the exponential decay property (190) [15] we obtain |H_{k,□}|, |∇H_{k,□}| ≤ B₃(4δ_k + exp(−δ2M₂R_k)30d²L²B₃(1+β₀)ε_k)".
 (v) LFR II (CMP 122) p. 360: "from the exponential decay in the scaled distance of this function (the inequality (190)[15])" — the factor
     exp(−½δMR_k) suppressing all powers of log g_k^{−2} and of M; needs the analytic extension ("proper analytic extensions").
 (vi) M3R's Lemma B: S_k = A(U_k(V)) in the class 𝒮 with a k-uniform strip of analyticity (M3R/REVIEW.md (B-iv)).
 WHAT THE USES CONSUME: entries 1–2 of (190) (value and first derivative of δ𝓗/δB, kernel decay, the factor ℓ(y′)^{−d}) at complex B and
 complex backgrounds U (CMP 109 p. 273 substitutes U, J for U_{k+1}, J_{k+1}; LFR II needs the analytic extension); entries 4–5 ("the second
 order operators applied to it", CMP 109 p. 271). Any positive rate suffices for every use (each use spends it on a distance ≥ M or ≥ MR_k).

## 3. THE CALCULATION BAŁABAN OMITTED, REPLACED BY A STRUCTURAL PROOF OF THE SAME INEQUALITY

Plan. Bałaban's route (p. 308) is to differentiate (85), (88), (89), (90), (93) a second time. That route needs the second derivative of
D(A′) (because 𝔇*(A′) is a factor of (88)–(90)) and the second derivative of every operator expression. The route here needs neither:
(a) a SECOND-ORDER ADJOINT IDENTITY writes Hess V without δ²D/δA′²; (b) every term is then a CHAIN of operators each of which has a
kernel bound in Bałaban's block-to-point class 𝒪 (§2.2), and one application of Lemma 2.1 (2.63) per chain gives the decay; (c) the
two strictly local pieces (V₀ and the averages C_j) get their Hessians by Cauchy's formula from Bałaban's own FIRST-derivative bounds
— exactly the device of (185)–(186) — localized by their locality. The inequality proved is (189) itself, with every constant named.

### 3.1 LEMMA C (CHAINS) — PROVED (from CMP 96 Lemma 2.1 and (2.48)/(2.57))

Setting. Operators K₁,…,K_n act between fields on fine bonds (measure η^d) and fields on 𝔅 (measure ℓ(y)^d); each obeys
  |(K_iλ)(x)| ≤ C_i ℓ(y)^{p_i} ℓ(y′)^{q_i} e^{−δ_i d(y,y′)} |λ|,   x ∈ Δ(y), supp λ ⊂ Δ(y′)                                    (C.1)
(for 𝔅-valued fields read x = y, resp. λ = λ(y′)1_{y′}). Put δ := min_i δ_i, s_i := q_i + p_{i+1} (i < n), S := Σ_{i<n}|s_i|.
LEMMA C. Let 0 < α, θ < 1 with θδRM ≥ S ln L and (2.59) holding with (1−θ)δ in place of δ₀. Then
  |(K₁K₂⋯K_nλ)(x)| ≤ (Π_i C_i) L^{(n−1)S} c₁(α)^n ℓ(y)^{p₁+Σ_{i<n}s_i} ℓ(y′)^{q_n} e^{−(1−α)(1−θ)δ d(y,y′)} |λ|.                    (C.2)
PROOF. Insert the partition Σ_{y_i}Δ(y_i) = I between consecutive factors (the blocks Δ(y), y ∈ 𝔅, partition Ω₀, resp. the sites of 𝔅
for 𝔅-valued fields) — Bałaban's (2.52). By (C.1) applied n times,
  |(K₁Δ(y₁)K₂Δ(y₂)⋯K_nλ)(x)| ≤ (ΠC_i) ℓ(y)^{p₁} Π_{i<n}ℓ(y_i)^{s_i} ℓ(y′)^{q_n} Π_{i=0}^{n−1} e^{−δ d(y_i,y_{i+1})} |λ|   (y₀ = y, y_n = y′).
SCALE CONVERSION. ℓ(y_i)/ℓ(y) = L^{j_i − j} and |j_i − j| ≤ Σ_{m≤i}|j_m − j_{m−1}|. By the geometry behind (2.60) (two points of different
surfaces Σ_j are RM apart in the scaled distance, (2.57), READ p. 233), d(y_{m−1},y_m) ≥ RM·max{|j_m − j_{m−1}| − 1, 0}. Hence, with
θδRM ≥ S ln L, Π_{i<n}L^{|s_i||j_i−j|} ≤ Π_{m=1}^{n−1}L^{S|j_m−j_{m−1}|} ≤ Π_m L^{S}e^{θδ d(y_{m−1},y_m)}, so
  ℓ(y)^{p₁}Π_{i<n}ℓ(y_i)^{s_i} ≤ L^{(n−1)S} ℓ(y)^{p₁+Σs_i} Π_m e^{θδ d(y_{m−1},y_m)}.
SUM. Σ_{y₁…y_{n−1}} Π_{i=0}^{n−1} e^{−(1−θ)δ d(y_i,y_{i+1})} ≤ c₁(α)^n e^{−(1−α)(1−θ)δ d(y,y′)} by (2.63) with (1−θ)δ for δ₀. ∎
REMARKS. (1) For a Neumann series of one scale-free operator (p = q = 0) S = 0 and θ = 0: Σ_{n≥0} of (C.2) converges when Cc₁(α) < 1.
(2) The rate loss is (1−α)(1−θ) ONCE PER CHAIN, independent of its length. Bałaban's halvings ½δ₀ (71), ¼δ₀ (189), ⅛δ₀ (190) are one
loss per stage at α = ½ (θ absorbed by RM large); §3.5 gets (190) with one loss fewer.
(3) If a factor differentiates its input (the local Hessians of 3.2) the input norm |λ| in (C.1) is replaced by the local C¹ norm
m_{y′}(λ) := max{ℓ(y′) sup|λ|, ℓ(y′)² sup|∇λ|} on Δ̃(y′); the partition is then a smooth one, Σ_{y}χ_y = 1, supp χ_y ⊂ Δ̃(y),
|∇χ_y| ≤ c_χ/ℓ(y) (Bałaban's {h_□}, CMP 99 p. 408), and the preceding factor must carry a ∇-bound (H, G, G̃, H₀ all do: (3.42),
(3.133)); m_{y₁}(χ_{y₁}f) ≤ (1 + c_χ) max{ℓ sup_{Δ̃(y₁)}|f|, ℓ² sup_{Δ̃(y₁)}|∇f|}. The proof is unchanged; the cubes Δ̃(y₁) overlap at
most 2^d-fold, a factor 2^d per link absorbed into C_i.

### 3.2 LEMMA L (LOCAL HESSIANS BY CAUCHY) — PROVED

Let Φ be analytic on 𝒰_a := {complex fields A on Ω₀ : m(A) < a} with values in fields, and suppose
 (L1) |Φ(A)(x)| ≤ K ℓ(x)^{−s} m(A)^q on 𝒰_a, for some q ≥ 1;   (L2) Φ(A)(x) depends only on A restricted to a set N(x) ∋ x.
Then for m(A) ≤ ε ≤ a/2 and every field 𝔄: (i) (DΦ(A)𝔄)(x) depends only on 𝔄|_{N(x)}; (ii) |(DΦ(A)𝔄)(x)| ≤ 2^qKε^{q−1}ℓ(x)^{−s} m(χ𝔄) for
every cutoff χ with χ = 1 on N(x).
PROOF. (DΦ(A)𝔄)(x) = (1/2πi)∮_{|τ|=r}τ^{−2}Φ(A + τ𝔄)(x)dτ (Bałaban's (185)). (i): by (L2) Φ(A + τ𝔄)(x) = Φ(A + τχ𝔄)(x). (ii): replace 𝔄 by
χ𝔄 and take r = ε/m(χ𝔄); then m(A + τχ𝔄) ≤ 2ε < a on |τ| = r and |(DΦ(A)χ𝔄)(x)| ≤ r^{−1}Kℓ^{−s}(2ε)^q. ∎
(For q = 2, Φ = δV/δA′, K = C₄, s = 3, χ ≡ 1 this IS Bałaban's (186).)

APPLICATIONS (inputs READ at CMP 102 pp. 284, 291–292, 289):
 (V₀) Φ₀ := δV₀/δA, V₀ = Σ_pη^dV₀(A,∂p) (30). Locality: N(b) = ∪_{p∋b}∂p. Bound: CMP 102 p. 291, "(∂/∂A(b))V′₀(A,∂p) satisfies a bound similar to
   (40) … with the power of |A| lower by 1", and p. 292, the derivative of the DA-term (91)–(93) "estimated by O(1)|∇A′||A′|" via (94)–(96);
   so (L1) holds with q = 2, s = 3, K = K₀ := O(1)_{p.291–292}(1 + C₁B₃ε₁ + ε₂), on m(A) < ε₂ (32). Hence
   |(V₀″(A)𝔄)(b)| ≤ 4K₀ε ℓ(b)^{−3} m(χ_b𝔄), and V₀″(A) has range one plaquette.
 (C) Φ_{C,c}(A) := δ/δA[C_j(L^jηA, c)], c a bond of Λ_j. Locality: N = B^j(c₋) ∪ B^j(c₊) (CMP 99 (3.102)). Bound: CMP 102 (72), from Prop. 5 of CMP 98:
   |Φ_{C,c}(A)(b)| ≤ C₃ℓ^{1−d}·ℓ sup_N|A| ≤ C₃ℓ^{1−d}m(A) on L^jη|A| ≤ ½c₄ — so q = 1. Hence |(DΦ_{C,c}(A)𝔄)(b)| ≤ 2C₃ℓ^{1−d}m(χ𝔄).
 (C2) the quadratic C^{(2)}_j: the same with C₃ (its gradient is the linear part of Φ_{C,c}); its Hessian is A-independent.

### 3.3 LEMMA A (THE SECOND-ORDER ADJOINT IDENTITY) — PROVED

By (78)–(80) V(A′) = W(A′, D(A′)) with, on 𝔅-valued X,
  W(A′,X) := −⟨H(X − C^{(2)}(A′)), J⟩ − ⟨A′, Δ_πHX⟩ + ½⟨HX, Δ_πHX⟩ + V₀(A′ − HX),
and D(A′) is the solution of F(A′, D(A′)) = 0, F(A′,X) := C(L^{j(·)}η(A′ − HX)) − X (49). All maps are analytic on the domain (77) (pp. 286–290).
F_X = −(I + 𝔑) with 𝔑 as in (68); (I + 𝔑) is invertible by (71). Let 𝔇 := D′(A′) (70) and, for a FIXED 𝔅-field Λ, ℒ(A′,X) := W(A′,X) + ⟨Λ, F(A′,X)⟩.
LEMMA A. Let Λ = Λ(A′) := (I + 𝔑*)^{−1} ∂_XW(A′, D(A′)). Then
  Hess V(A′) = ℒ_{A′A′} + ℒ_{A′X}𝔇 + 𝔇*ℒ_{XA′} + 𝔇*ℒ_{XX}𝔇   at (A′, D(A′)), with Λ frozen.                                    (A.1)
PROOF. F(·, D(·)) ≡ 0, so V(A″) = ℒ(A″, D(A″)) for all A″ near A′ (Λ fixed). Differentiate twice at A′: the result is (A.1) plus the term
⟨ℒ_X, D″(A′)[·,·]⟩, and ℒ_X = ∂_XW + F_X*Λ = ∂_XW − (I + 𝔑*)Λ = 0 by the choice of Λ. ∎ (The second derivative of D never enters.)
EVALUATION. Write A := A′ − HD(A′), 𝒯 := I − H𝔇 (the Jacobian of (47)), 𝒞_Λ(A) := ⟨Λ, C(L^{j(·)}ηA)⟩. Since V₀(A′ − HX) and 𝒞_Λ(A′ − HX) depend on
(A′,X) through A′ − HX, and −⟨A′,Δ_πHX⟩ + ½⟨HX,Δ_πHX⟩ = ½⟨A′ − HX, Δ_π(A′ − HX)⟩ − ½⟨A′, Δ_πA′⟩ (Δ_π symmetric):
  Hess V(A′) = 𝒯*(𝒬 + Δ_π)𝒯 − Δ_π + 𝒦_J,   𝒬 := V₀″(A) + 𝒞″_Λ(A),   𝒦_J := ∂²_{A′}⟨C^{(2)}(A′), H*J⟩ (A′-independent).                (A.2)
With the identity of §2.3 (Δ_πH = Q*[(QGQ*)^{−1} − ℓ^{−2}]ℓ^{−1}, H*Δ_πH = ℓ^{−1}[(QGQ*)^{−1} − ℓ^{−2}]ℓ^{−1}) and Π := (QGQ*)^{−1} − ℓ^{−2}:
  Hess V = 𝒬 − 𝒬H𝔇 − 𝔇*H*𝒬 + 𝔇*H*𝒬H𝔇 − Q*Πℓ^{−1}𝔇 − 𝔇*ℓ^{−1}Π*Q + 𝔇*ℓ^{−1}Πℓ^{−1}𝔇 + 𝒦_J.                                    (A.3)
CHECK (A′ = 0): 𝔇(0) = 0 (δC/δA vanishes at 0), Λ(0) = −H*J, 𝒞″_{Λ(0)}(0) = −∂²⟨C^{(2)}, H*J⟩ = −𝒦_J, V₀″(0) = 0: Hess V(0) = 0, as it must (V
starts at third order). The J-terms cancel at order zero; what survives is 𝒞″_{Λ+H*J}(A) + 𝒞″_{−H*J}(A) − 𝒞″_{−H*J}(0) = O(ε₃)+O(ε₁ε₃).
Λ's size: ∂_XW = −H*(J + Δ_πA + V₀′(A)) and H*Δ_πA = ℓ^{−1}Π*QA, so |Λ(c)| ≤ C_Λ(ε₁ + ε₃)ℓ(c)^{−4} with
  C_Λ := 2c₁(½)L⁴[B₀c₁(½)C₁B₃ + 2(B_Πc₁(½) + 1) + 4B₀c₁(½)K₀]   ((71)+(2.61) for (I+𝔑*)^{−1}; (28); (57); (3.132); Lemma L (V₀)).
Hence, by Lemma L and the locality of V₀ and C_j: |(𝒬𝔄)(b)| ≤ K_𝒬 ε₃ ℓ(b)^{−3} m(χ_b𝔄), K_𝒬 := 4K₀ + 8d·2C₃C_Λ(1 + ε₁/ε₃), range ≤ one
block; and |(𝒦_J𝔄)(b)| ≤ 8d·2C₃·B₀c₁(½)L⁴C₁B₃ ε₁ ℓ(b)^{−3} m(χ_b𝔄).

### 3.6 STAKE FOR THE FINITE-DIMENSIONAL CHECK (written before the run; COMPUTED results go below it, nothing here edited)

Toy (double precision, labelled; a check of the algebra and of the decay mechanism, not a proof): ring of N = 96 sites, blocks of
b = 4 (24 block sites), abelian real fields. K := −Δ + m² (m = 0.6), G = K^{−1}; Q the block average; H := GQᵀ(QGQᵀ)^{−1} (QH = I,
the analogue of (3.126)); C(A)(c) := κ₂[(1/b)Σ_{i∈c}A_i² − (QA)_c²] + κ₃(1/b)Σ_{i∈c}A_i³ (block-local, starts at 2nd order, the analogue
of C_j); D(A′) the fixed point of X = C(A′ − HX) (49); G_tot(A) := ⟨A,J⟩ + ½⟨A,KA⟩ + V₀(A), V₀(A) := Σ_i[g₃A_i²(A_{i+1} − A_i) + g₄A_i⁴]
(local, with a derivative, the analogue of (30)/(39)); 𝔉(A′) := G_tot(A′ − HD(A′)) ((74) with Δ_π ↦ K, a = 0); V := 𝔉 minus its Taylor
polynomial of order 2 at 0, so Hess V(A′) = Hess 𝔉(A′) − Hess 𝔉(0).
 S1 (Lemma A): Hess 𝔉 from (A.2)-type formula 𝒯ᵀ(K + V₀″(A) + 𝒞″_Λ(A))𝒯, Λ = −(I + HᵀC′ᵀ)^{−1}Hᵀ∇G_tot(A), equals the central finite
    difference of the analytic gradient 𝒯ᵀ∇G_tot(A) to relative error ≤ 1e−6 (h = 1e−5). (No D″ is computed by the formula.)
 S2 (decay, (189)): the profile P(r) = max_{dist(i,i′)=r}|Hess V(i,i′)| decays exponentially with fitted rate ≥ 0.9·min(μ_H, μ_𝔇, μ_Π),
    μ_K the fitted kernel rates of H, 𝔇, (QGQᵀ)^{−1} (one chain loss; in 1D at uniform scale the loss α can be taken to 0).
 S3 (size): Hess V(tA′) near the diagonal is linear in t for small t (ratio of P(0) at t and 2t within 10% of 2): the ε₃ of (189).
 S4 ((190)): the constrained minimizer A*(B) of G_tot on {QA + C(A) = B} (solved as A′ ∈ HB + ker Q, A* = A′ − HD(A′), Newton with
    the Lemma-A Hessian) has Jacobian dA*/dB with column profile decaying at rate ≥ 0.9·min(μ_H, μ_𝔇, μ_Π, μ_G) — the content of (190).
Kill-switch: S1 failing beyond 1e−4 would mean Lemma A's identity is mis-derived; S2 with a rate below ½·min would mean a slow tail
the chain lemma does not see.

### 3.6-R RESULTS (COMPUTED, record `rec/toy189.2026-11-02a.txt`, script `bin/toy189.py`, double precision, labelled as a check)
 S1 HELD: Lemma A's Hessian vs central differences of the analytic gradient: max|adj − fd|/max|fd| = 4.4e−11 (stake ≤ 1e−6). CONTROL:
    the same formula with the Λ-term (the multiplier of the constraint) dropped is wrong by 2.9e−2 — the term is load-bearing and right.
 Kernel tail rates (fitted): μ_G = 0.5913 (= arccosh(1 + m²/2) = 0.5913 exactly, the instrument reads the known answer), μ_H = 0.4369,
    μ_Π = 0.4364 ((QGQᵀ)^{−1}), μ_𝔇 = 0.4375.
 S2 HELD: Hess V(A′) profile 3.67e−1, 2.34e−3, …, 4.71e−10 at r = 0, 4, …, 40; fitted rate 0.4412 = 1.011 × min(μ_H, μ_𝔇, μ_Π) (stake ≥ 0.9).
 S3 HELD: max|Hess V(tA′)| = 0.0990, 0.1932 at t = 0.25, 0.5, ratio 1.951 (stake 2 ± 10%): the Hessian is first order in the field.
 S4 HELD: the constrained minimizer (3 Newton steps with the Lemma-A Hessian, constraint residual 2e−17); dA*/dB column profile 1.14, 1.67e−1,
    …, 2.51e−8; rates 0.4391 (dA*/dB) and 0.4396 (dA*/dB − H), ratios 1.006, 1.007 to the minimal kernel rate (stake ≥ 0.9).
 READING: in the toy the Hessian and the minimizer's B-derivative inherit the SLOWEST kernel rate with no loss — the chain lemma's
    one loss (1−α)(1−θ) per chain is a bookkeeping loss of the proof (α, θ → 0 at the price of the constant), not of the object.

PRECISIONS TO 3.1–3.3 (dated 2026-11-02, after writing them; nothing above edited).
(P1) Lemma C's factor L^{(n−1)S} is right for FIXED chains (the eight rows of 3.4). For a Neumann series S must not grow with n: write
  every factor in DIMENSIONALLY CONSISTENT form first — p = −Δ_out, q = Δ_in, Δ the scaling dimension of the field (A′ dim 1, B and D dim 0,
  currents and K-outputs dim 3) — which CMP 99 p. 398 (READ) licenses: "Using Lemma 2.1 in [4] we may replace the factor (L^jη)^α by
  (L^jη)^β(L^{j′}η)^γ with β + γ = α". Per factor this costs L^{|c|} and a rate loss |c|ln L/RM (from d(y,y′) ≥ RM max{|j−j′|−1,0}, the
  geometric content of (2.60)); then all internal s_i = 0, Lemma C holds with S = 0, θ = 0, and Σ_n converges geometrically when the product of
  the per-factor constants times c₁(α)^{#factors} is < 1.
(P2) The multiplicity in 𝒞″_Λ: a fine bond lies in the support of 2d block bonds c, so |(𝒞″_Λ𝔄)(b)| ≤ 4dC₃C_Λ(ε₁+ε₃)ℓ^{−3}m(χ_b𝔄); read
  K_𝒬 := 4K₀ + 4dC₃C_Λ(1 + ε₁/ε₃) in place of the constant written in 3.3 (both explicit; only the absolute constant changes).
(P3) Lemma A was verified as an identity in the toy (S1, 4e−11, with a failing control). (A.2) is derived for 𝔉(A′) = G_tot(A′ − HD(A′)),
  G_tot(A) := A(U₀) + ⟨A,J⟩ + ½⟨A,Δ_πA⟩ + V₀(A): Hess 𝔉 = 𝒯*(Δ_π + 𝒬)𝒯; and V = 𝔉 − A(U₀) − ⟨A′,J⟩ − ½⟨A′,Δ_πA′⟩ + ⟨HC^{(2)}(A′),J⟩ by
  (74)–(81) (checked line by line), whence (A.2). Λ = −(I + 𝔑*)^{−1}H*∇G_tot(A), and H*Δ_πA = ℓ^{−1}ΠQA needs no derivative of A.

### 3.4 THEOREM 189 — PROVED GIVEN the kernel inputs (K-H), (K-Π), (K-𝔇) below (each READ)

Factor bounds (x ∈ Δ(y), input supported in Δ(y′) or at y′; m_y(f) := max{ℓ(y)sup_{Δ̃(y)}|f|, ℓ(y)²sup_{Δ̃(y)}|∇f|};
c₀ := sup{d(y,y′) : Δ̃(y) ∩ Δ̃(y′) ≠ ∅} ≤ 4):
 (K-H)  |(Hg)(x)|, ℓ(y)|(∇Hg)(x)| ≤ B₀ℓ(y)^{−1}e^{−δ₀d(y,y′)}|g(y′)|   [CMP 102 (46), (69); CMP 99 (3.133) with the factor (L^jη)^{−1}, p. 422];
        hence m_y(Hg) ≤ 2B₀e^{δ₀c₀}e^{−δ₀d(y,y′)}|g(y′)|; adjoint |(H*f)(c)| ≤ B₀ℓ(c)^{−d}ℓ(y′)^{d−1}e^{−δ₀d(c,y′)}sup_{Δ(y′)}|f|.
 (K-𝔇)  |(𝔇f)(c)| ≤ C_𝔇ε₃ℓ(y′)e^{−½δ₀d(c,y′)}sup_{Δ(y′)}|f|, C_𝔇 := O(1)_{(73)}C₃   [CMP 102 (73)];
        adjoint (𝔇*g)(b) = Σ_c ℓ(c)^d𝔇(c,b)g(c): |(𝔇*g)(b)| ≤ C_𝔇ε₃ℓ(y)^{1−d}ℓ(c′)^de^{−½δ₀d(y,c′)}|g(c′)|.
 (K-Π)  |(Πg)(c)| ≤ B_Πℓ(c)^{−2}e^{−δ₀d(c,c′)}|g(c′)|, B_Π := O(1)_{(3.132)} + 1   [CMP 99 (3.132); δ₁ ≥ δ₀ by the common-rate convention, p. 423].
 (K-Q)  Q, Q* local with coefficients ≤ q₀ (CMP 99 (3.102), p. 414). (K-𝒬), (K-J) from §3.3 and Lemma L: |(𝒬𝔄)(b)| ≤ K_𝒬ε₃ℓ^{−3}m(χ_b𝔄),
        |(𝒦_J𝔄)(b)| ≤ K_Jε₁ℓ^{−3}m(χ_b𝔄), range ≤ c₀.

The eight rows of (A.3), for supp 𝔄 ⊂ Δ̃(y′), output at x ∈ Δ(y); (p,q) per factor; S = Σ|s_i| plus the input conversion; size:

 | row               | chain (left to right)                        | internal s_i          | S         | size        |
 | T1 = 𝒬            | local                                         | none                  | 0         | K_𝒬ε₃       |
 | T2 = −𝒬H𝔇         | (𝒬H)(−3,0) · 𝔇(0,1)                           | 0                     | 0         | ε₃²         |
 | T3 = −𝔇*H*𝒬       | 𝔇*(1−d,d) · (H*𝒬)(−d,d−4)                     | 0 (input d−4)         | abs(d−4)  | ε₃²         |
 | T4 = 𝔇*H*𝒬H𝔇      | 𝔇* · H*(−d,d−1) · (𝒬H)(−3,0) · 𝔇              | 0, d−4, 0             | abs(d−4)  | ε₃³         |
 | T5 = −Q*Πℓ⁻¹𝔇     | Q*(0,0) · Π(−2,0) · (ℓ⁻¹𝔇)(−1,1)              | −2, −1                | 3         | q₀B_ΠC_𝔇ε₃  |
 | T6 = −𝔇*ℓ⁻¹ΠQ     | (𝔇*ℓ⁻¹)(1−d,d−1) · Π(−2,0) · Q(0,0)           | d−3, 0 (input −1)     | abs(d−3)+1| ε₃          |
 | T7 = 𝔇*ℓ⁻¹Πℓ⁻¹𝔇   | (𝔇*ℓ⁻¹) · Π · (ℓ⁻¹𝔇)                          | d−3, −1               | abs(d−3)+1| ε₃²         |
 | T8 = 𝒦_J          | local                                         | none                  | 0         | K_Jε₁       |

Every row ends at the output scale ℓ(y)^{−3} and the input norm m(𝔄) (the input factor ℓ(y′)^1 of 𝔇, and Q, times sup|𝔄| ≤ ℓ(y′)^{−1}m(𝔄)).
Rates: the minimum over factors is ½δ₀ (𝔇). The local rows T1, T8 vanish unless d(y,y′) ≤ c₀ and are bounded with e^{¼δ₀c₀}e^{−¼δ₀d}.

THEOREM 189. Let α = ¼, θ = ⅓; let RM satisfy (2.59) with ⅓δ₀ in place of δ₀ at α = ¼, and RM ≥ 6 S_max ln L/δ₀ (S_max = max of the S column;
= 3 at d = 4); let ε₃ be as small as CMP 102 §§C–E require. For A′ satisfying (77) (complex-valued, 3.7), supp 𝔄 ⊂ Δ̃(y′), y ∈ Λ_j:
  |Δ(y)(δ²V/δA′²)(A′)𝔄| ≤ C₁₈₉ ε₃ (L^jη)^{−3} e^{−¼δ₀d(y,y′)} max{|𝔄|_{(−1)}, |∇𝔄|_{(−2)}},                                    (189)
  C₁₈₉ := 2^d e^{δ₀c₀}(K_𝒬 + K_J) + Σ_{rows 2–7} 2^{2d}(Π_iC_i) L^{(n−1)S} c₁(¼; ⅓δ₀)^n e^{2δ₀c₀}/ε₃,
the C_i the row's factor constants (B₀, 2B₀e^{δ₀c₀}, C_𝔇ε₃, B_Π, q₀, K_𝒬ε₃), n the row's length; each row is of first order or higher in ε₃,
so C₁₈₉ is an absolute constant of d, L, δ₀, B₀, B_Π, C₃, K₀, C_Λ. This is Bałaban's (189) with his rate ¼δ₀, his scale and his size.
PROOF. Lemma A ((A.3)) writes the Hessian as the eight rows. Rows 1, 8: Lemma L and locality. Rows 2–7: Lemma C with the listed (p, q),
α = ¼, θ = ⅓ ((1 − α)(1 − θ)·½δ₀ = ¼δ₀); where a factor differentiates its input (𝒬 after H) Remark (3) of 3.1 applies with (K-H)'s C¹
bound; the 2^d counts the blocks meeting Δ̃(y′). (2.63) is applied once per row at the rate ⅓δ₀ ≤ ½δ₀. ∎
WHAT REPLACES BAŁABAN'S OMITTED ROUTE: δ²D/δA′² never appears (Lemma A); no second derivative of any propagator appears (the identity
Δ_πH = Q*Πℓ^{−1} removes Δ_π from every row); only first-derivative kernel bounds are used. The "very awkward" calculation is not needed.

### 3.5 THEOREM 190 — PROVED GIVEN the inputs of 3.4 and (K-G̃), (K-H₀), (K-2) below; RATE ¼δ₀ (better than Bałaban's ⅛δ₀)

Inputs (READ): (K-G̃) G̃ = GP₀* (CMP 102 p. 300) with G = (Δ_a − Δ^{(2)})^{−1} (p. 306): value, ∇ and Hölder kernel bounds of (3.42)–(3.45)
from CMP 99 Theorem 3.3 (Δ_a = Δ + DRD* + Q*aQ, CMP 102 p. 297), perturbed by Δ^{(2)} ((3.137): no derivatives, small) and by
P₀* = I − Q*(QGQ*)^{−1}QG (a (K-Π)-type bound for (QGQ*)^{−1}); (K-H₀) H₀ = GQ*(QGQ*)^{−1}ℓ^{−1} (129), bounds (3.133) and (130) for
Δ_{U₀}H₀; (K-2) Δ′ local bounded (CMP 99 (3.10), cited CMP 102 p. 299), DPD* (3.49), the curvature term of (135) bounded by (14).
EXACT FORM. From (183)–(184) and (182): 𝔄₀ + H₀ = (I + G̃K)^{−1}(I + G̃Δ^{(2)})H₀, K := (δ²V/δA′²)(𝒜₀ + H₀B), hence
  δ𝓗/δB = (I − H𝔇)(I + G̃K)^{−1}(I + G̃Δ^{(2)})H₀,   𝔇 = 𝔇(𝒜₀ + H₀B).                                                        (190.0)
ENTRIES 1–3. Expand (I + G̃K)^{−1} = Σ_n(−G̃K)^n and K into its eight rows (3.4) — NOT into its bound — and normalize each factor consistently
(P1). Every term of the expansion is then a chain with internal s_i = 0, rates ≥ ½δ₀ − c ln L/RM, and one factor ε₃ per K. Lemma C with α = ¼,
S = 0 gives |δ𝓗_μ(B,x)/δB_ν(y′)| ≤ C₁₉₀(L^jη)^{−1}(L^{j′}η)^{−d}e^{−¼δ₀d(y,y′)} for ε₃ ≤ ε₃* := [2·(2B₀L³e^{δ₀c₀})·C′₁₈₉·c₁(¼)²]^{−1}
(C′₁₈₉ := the row constants of 3.4 divided by ε₃), with C₁₉₀ := 2B₀L(1 + B₀C_𝔇c₁(¼))(1 + B_{G̃}O(1)C₁B₃ε₁)c₁(¼)³. The x-derivative: ∇ of
f := (I + G̃K)^{−1}(I + G̃Δ^{(2)})H₀ = H₀ + G̃(Δ^{(2)}H₀ − Kf) uses ∇H₀ and ∇G̃ only; ∇(H𝔇f) = (∇H)𝔇f. The Hölder entry uses (3.43) for ∇G̃
and (3.133)'s Hölder bound for ∇H — the same chains.
ENTRIES 4–5 (NOT through G̃: CMP 99 Theorems 3.12, 3.13 exclude the Laplacian inequality for G, G₁, 𝔊, READ pp. 423, 426; CMP 109 p. 272 says
second-order bounds hold "only if we use the second representation for H_j connected with the Eq. (180)"). Differentiate (133) in B:
  (Δ + DRD*)𝔄₀ = P₀*Δ^{(2)}(𝔄₀ + H₀) − P₀*K(𝔄₀ + H₀),
and with (134)–(135): Δ_{U₀}𝔄₀ = (Δ + DRD*)𝔄₀ − Δ′𝔄₀ + DPD*𝔄₀ + (curvature)𝔄₀. Every operator on the right has a value kernel bound (no
Laplacian of G is used: Δ_aG̃ = P₀* is the identity behind (133)); 𝔄₀ decays by entry 1, K by (189). Δ_{U₀}H₀ is (130). For Δ_{U₀}(H𝔇f): the
kernel of Δ_{U₀}H follows from (137) (Δ_πH = Q*Πℓ^{−1}), (138) (Δ′_πH through G′RD* — Theorem 3.1 value bounds — and J), Δ = Δ_π + Δ′_π,
(140) (D*DH = (D*D + DD*)H − DPD*H, as RD*H = 0) and (135): each a value kernel bound, so Δ_{U₀}H ∈ 𝒪(O(1)B₀; −3, 0; δ₀). Entry 4:
D*D = Δ_{U₀} − DD* − curvature, and DD*(δ𝓗/δB) = DPD*(δ𝓗/δB) because RD*𝓗 = 0 (Landau gauge, Prop. 9) differentiates to RD*(δ𝓗/δB) = 0.
All chains as above: entries 4–5 hold with (L^jη)^{−3}(L^{j′}η)^{−d}e^{−¼δ₀d(y,y′)}.
PROP. 2 AND (181), Bałaban's last ingredients: the bound is proved for the Landau-gauge 𝓗 at U₀ = U_k(V₀); the norms are gauge invariant
(CMP 99 p. 398, READ), and (181) carries U_k(V) along G^c-orbits, so the bound holds on the orbit. ∎
SUFFICIENCY DOWNSTREAM. Every use in §2.4 spends the rate on a distance ≥ M (CMP 109 (3.9): ½δ₀M(L^jη)^{−1}; CMP 119 (3.7): δ2M₂R_k;
LFR II: ½δMR_k). Any positive rate serves, and ¼δ₀ ≥ ⅛δ₀ serves Bałaban's own bookkeeping verbatim.
CHECK. The toy (3.6-R, S4) shows the minimizer's B-derivative decaying at the minimal kernel rate (ratio 1.006): the rate loss is the proof's.

### 3.7 THE COMPLEX GENERALITY (PROVED from READ statements)
CMP 99 Theorem 3.4 (READ p. 400): G′, (Q′G′²Q′*)^{−1}, R, G extend to U′U with α₁ ≤ a₁ "as analytic functions of A … satisfy all the
inequalities of Theorems 3.1–3.3"; Prop. 4 is stated for g^c-valued A′ (CMP 102 p. 292); D, 𝒜₀, 𝓗 are fixed points of contractions on complex
domains (pp. 286, 295–296, 305–307); Lemma L is Cauchy's formula on complex fields; Lemma A is an identity between analytic functions. Hence
(189) holds for complex A′ in (77), and (190) at complex B (|B| < 2C₁ε₁ on 𝔅_k, (172)) and complex backgrounds U′U in Theorem 3.4's domain —
the generality CMP 109 p. 273 ("we replace the configurations U_{k+1}, J_{k+1} … by the configurations U, J") and LFR II p. 360 ("proper analytic
extensions") consume. The complex extension of (QGQ*)^{−1}, H, G₁, 𝔊 enters through their representations (3.126), (3.129), (3.153), hence
through (3.132) (§4, A1).

## 4. THE CMP 99 RANDOM-WALK EXPANSIONS AS CMP 116 LEMMAS 1–2 USE THEM — AUDIT (READ, CMP 99 pp. 396–427; CMP 96 pp. 231–235; CMP 116 pp. 2–7)

WHAT CMP 116 USES (READ pp. 3–6). (1.6) = CMP 99 (3.107), "A propagator is represented by the sum (3.107) [13]", for the three propagators
H, G̃, H₀ of (1.2)–(1.4); (1.7) = (3.108), the walk bound O(1)O(M₁^{−1/2})^{|ω|}M₁^{−½|ω|}exp(−δ₀d(ω,y,y′)) "for all operator norms in
formulations of theorems in [13], e.g. in Theorem 3.1"; locality: each factor depends on U on X̃_j⁵ and "its kernel vanishes in a sufficiently
thick neighborhood of ∂X_j" (p. 3); (1.11): H(s(Y₀))X analytic on |s(Δ)| ≤ e^{κ₁}, bounded by B₀e^{16κ₁}|X| "in all norms of Theorems 3.1.–3.10",
using δ₀d(ω) ≥ δ₁mM for m > 2⁴ and δ₁M ≥ κ₁ (p. 5).

| item | statement in CMP 99 | status in print | load on CMP 116 / CMP 102 / (189)–(190) |
|---|---|---|---|
| A1 | (3.132) |(QGQ*)^{−1}(y,y′)| ≤ O(1)(L^jη)^{−2}(L^{j′}η)^{−d}e^{−δ₁d}, and the random-walk expansion of (QGQ*)^{−1}, (QG₁Q*)^{−1} | ASSERTED BY ANALOGY: "We have to investigate also the operator (QGQ*)^{−1}, but the analysis is very similar to this for the operator (Q′G′²Q′*)^{−1}" (p. 421); "can be analyzed in the same way as the operator (Q′G′²Q′*)^{−1}. We will not repeat these considerations here, let us write only bounds" (p. 422) | LOAD-BEARING EVERYWHERE: (3.133) for H is DERIVED from (3.126) and (3.132) (p. 422); Theorem 3.12's "Theorem 3.10 hold for H, H₁" (random walks of H) and Theorem 3.13 for 𝔊 "assuming (3.132)" (p. 426); CMP 102 (46), (69), (73), Prop. 4, (129)–(130); all three propagators of CMP 116 (1.6) contain (QGQ*)^{−1} (H = GQ*(QGQ*)^{−1}, H₀ (129), G̃ = G − GQ*(QGQ*)^{−1}QG); the factor Π in rows T5–T7 of (189) |
| A2 | Theorems 3.7 (G′) and 3.9 ((Q′G′²Q′*)^{−1}) | PROOF BY REFERENCE: "The arguments are exactly the same as in proofs of Proposition 1.2 [3] and Proposition 2.2 [4], so we will not repeat them" (p. 410); [3] = CMP 95, [4] = CMP 96, both ON DISK. CMP 96 Prop. 2.2's argument READ (pp. 232–234): Neumann series of R with (2.51), summed by Lemma 2.1 — complete for G′ at U = 1; CMP 99 Sect. B + Corollary 3.6 (READ p. 408) carry it to regular U | verifiable on disk; checked for the G′ step |
| A3 | Theorem 3.10: G = Σ_ω R₀(X₀)⋯R_{αₙ}(Xₙ), (3.107)–(3.108) "and the corresponding inequalities for norms on the left-hand sides of (3.42)–(3.47)" | CONSTRUCTION SKETCHED, ESTIMATES ASSERTED: R of (3.105) is shown small term by term in words ("it will follow from this analysis that R satisfies the bound (3.85) with O(M^{−1})", p. 414; "terms with the difference … are small again because localizations are separated by a distance ≥ M", p. 415); the P-term needs (3.97)'s domain-difference estimate, quoted from [2] (CMP 89, not on disk) "by an argument similar to … Corollary 3.5" (p. 412) | CMP 116 (1.6)–(1.7) for G (inside G̃, H₀) |
| A4 | Theorem 3.12: Theorems 3.3, 3.10, 3.11 hold for G, G₁ "with one exception … the inequality in (3.42) involving the covariant Laplace operator. It does not hold for G, G₁"; Theorem 3.13 the same for 𝔊 | STATED LIMITATION (not a gap) | (190)'s entries 4–5 must avoid it — §3.5 does, via (133). CMP 116's (I.3.31) needs only |A|, |∇A|, ‖A‖_{1,β} (CMP 109 p. 276, READ), so the exception does not bite Lemma 1; "all norms of Theorems 3.1–3.10" in CMP 116 p. 5 must be read without the Laplacian norm for the Sect. D operators |
| A5 | Theorem 3.14 (domain change, factor exp(−δ₀d(y,y′,Ω))) | "can be proved in exactly the same way as the corresponding property in the theorem of [2]" (p. 427); [2] = CMP 89, NOT ON DISK | not used in CMP 116 §1 as read; used inside A3 ((3.97)) |
| A6 | tree-like expansions for G₁, H₁ (Δ^{(2)} contains H): "The estimates are the same as in (3.108), d(ω,y,y′) is now a length of a shortest tree" | ASSERTED (p. 427) | CMP 102 (180) uses G = (Δ_a − Δ^{(2)})^{−1}, so CMP 116's G̃ and H₀ have tree-like walks |
| A7 | (3.37)–(3.38) ⇒ (3.35)–(3.36) with O(1)(α₀ + α₁) | "We will prove in another paper" ([6] = CMP 99 75–102, NOT ON DISK); "we will not use this fact here" (pp. 396–397) | not used in CMP 99; CMP 102 Prop. 9 cites "(3.35)–(3.38) [5], or (1.7)–(1.9) [6]" |
| A8 | Theorem 3.4: analytic extension to U′U, (3.37) | PROVED in Sect. B for G′, (Q′G′²Q′*)^{−1}, R, G, "assuming that Theorems 3.1–3.3 hold" (p. 407) | the complex generality of 3.7; for (QGQ*)^{−1}, H, G₁, 𝔊 through A1 |
| A9 | the walk factors' support: CMP 116 p. 3 states the kernel "vanishes in a sufficiently thick neighborhood of ∂X_j, e.g. … width ⅓M₁" | CMP 99 states only support in X × X and dependence on U on X̃⁵ (p. 413); the collar comes from the partition of unity {h_□} (CMP 99 p. 408, defined in [4] Sect. A) | a precision CMP 116 p. 4 uses to separate the equations on the components of Y(σ) |

GENERALITY ADMITTED (READ). Backgrounds U with the local regularity (3.35) (first order on the cubes of the class of p. 396) for G′,
(Q′G′²Q′*)^{−1}, G of Sects. A–C; (3.35) + (3.36) for the Sect. D operators G (with Δ_π), G₁, H, H₁, 𝔊 (Theorems 3.12, 3.13); complex U′U with
(3.37) (and (3.38)) for analyticity (Theorem 3.4). Decay rate δ₀ "a common, best possible, decay rate for all these operators … depending on
d and L only" (p. 423); constants B₀ (d, L), B₀(β), B′₀(ε, β) (Theorem 3.1); conditions M ≥ M₁ (the factor O(M^{−1/2})^{|ω|}), RM large
((2.59)), α₀, α₁ small. CMP 116's s-dependence needs δ₁M ≥ κ₁ (p. 5), i.e. M chosen after κ₁ — Bałaban's order ((I.1.18): M ≥ M(κ)).

PRECISION FOR CMP 116 p. 5 (not a failure; found here). "This implies that the function V(H(s(Y₀)), A′), defined by (80) [15] … is an
analytic function of A′, s(Y₀), and Proposition 4 [15] holds for it". Prop. 4's proof (CMP 102 pp. 291–292, READ) bounds the derivative (88) of
⟨A′, Δ_πHD(A′)⟩ through the identity (137) Δ_πH = Q*(QGQ*)^{−1}ℓ^{−1} − Q*aℓ^{−1}. A decoupled H(s) satisfies no exact identity, and CMP 99
gives no second-order bound for the walk terms of H ((3.133) is first order; A4). THE FIX within the stated inputs: decouple V in Bałaban's own
form (87)–(89), V(A′) = −⟨HD₃,J⟩ − ⟨QA′, Πℓ^{−1}D⟩ + ½⟨ℓ^{−1}D, Πℓ^{−1}D⟩ + V₀(A′ − HD), with H and Π = (QGQ*)^{−1} − a decoupled separately;
it equals (80) at s = 1 and Prop. 4's proof then uses only first-order bounds of H(s) and the bound (3.132) of Π(s). This is the same identity
that removes Δ_π from (189)'s rows.

VERDICT OF THE AUDIT. The random-walk machinery CMP 116 rests on is PROVED IN PRINT for G′ and (Q′G′²Q′*)^{−1} (Theorems 3.7, 3.9, by the on-disk
CMP 95/96 arguments), SKETCHED for G (Theorem 3.10), and ASSERTED BY ANALOGY for (QGQ*)^{−1} — the operator inside every propagator CMP 116 decouples.
Nothing found is false; one estimate is missing in print, and it is the same one under (189)–(190).

## 5. THE NEXT OBJECT: (3.132) FROM A VARIATIONAL SANDWICH AND COMBES–THOMAS (the upper half PROVED here; the lower half NAMED)

T := QGQ* on block fields (measure ℓ(y)^d), G^{−1} = X + Q*aQ, X := Δ_π + DRD*, a = ℓ^{−2} (CMP 99 (3.122), READ p. 420).
(V) VARIATIONAL FORMULA (G > 0, Theorem 3.11): ⟨h, Th⟩ = sup_A [2Re⟨QA, h⟩_𝔅 − ⟨A, G^{−1}A⟩].
UPPER HALF — PROVED under (U+): X ≥ −θQ*aQ for some θ < 1 (true at U = 1, where X = ∂*∂ + DRD* ≥ 0; for regular U it is the quantitative form of
Theorem 3.11's positivity: on ker Q the block Poincaré inequality makes the gradient energy dominate the O(α₀) part of Δ′ and Δ′_π).
  ⟨h,Th⟩ ≤ sup_A[2Re⟨QA,h⟩ − (1−θ)⟨QA, aQA⟩] ≤ sup_φ[2Re⟨φ,h⟩ − (1−θ)⟨φ,aφ⟩] = (1−θ)^{−1}⟨h, a^{−1}h⟩,   i.e.  T ≤ (1−θ)^{−1}ℓ².
LOWER HALF — NAMED: a competitor field A_φ with linear block averages QA_φ = φ and energy ⟨A_φ, G^{−1}A_φ⟩ ≤ C₁‖ℓ^{−1}φ‖² (a local construction:
block bumps adapted to Q_j(U), corrected inside each block; at U = 1 it is CMP 95/96's interpolation). Then (V) with φ = tℓ²h gives
T ≥ C₁^{−1}ℓ². FALSIFIER: a sequence of block fields h with ⟨h,Th⟩/‖ℓh‖² → 0 uniformly in k (a near-zero mode of the averaged propagator).
DECAY — PROVED GIVEN the sandwich and G's kernel decay (Theorem 3.3/3.12): T̂ := ℓ^{−1}Tℓ^{−1} satisfies C₁^{−1} ≤ T̂ ≤ (1−θ)^{−1}; its kernel
|T̂(y,y′)| ≤ C ℓ(y)ℓ(y′)^{−1−d}e^{−δ₀d}; for w with |w(y)−w(y′)| ≤ κd(y,y′), the Schur test (with Lemma 2.1 (2.61) and the scale conversion of
(P1)) gives ‖e^{w}T̂e^{−w} − T̂‖_{ℓ²} ≤ C Σ e^{−(δ₀−κ−c ln L/RM)d}(e^{κd} − 1) ≤ (2C₁)^{−1} for κ ≤ κ* = κ*(C, C₁, δ₀); so e^{w}T̂^{−1}e^{−w} has norm ≤ 2C₁,
and testing on indicator functions (‖1_y‖ = ℓ(y)^{d/2}) with w = κd(·,y′) gives |T^{−1}(y,y′)| ≤ 2C₁ℓ(y)^{−1−d/2}ℓ(y′)^{−1−d/2}e^{−κd(y,y′)},
which is (3.132) after the scale conversion (P1), at the rate κ* − c ln L/RM > 0 in place of δ₁. ANY positive rate serves (189), (190) and
every downstream use (§2.4); Lemma C then runs with min(½δ₀, κ*) in place of ½δ₀.
The random-walk expansion of (QGQ*)^{−1} that CMP 116 decouples is then obtained from the convergent Neumann series of T̂^{−1} around the
localized inverses, as (3.95)–(3.96) do for Q′G′²Q′* — the same construction, now with a proved bound to feed it.

## 6. STATUS OF THE ULTRAVIOLET HALF AFTER THIS FILE (item by item)

| item | status | rests on |
|---|---|---|
| CMP 102 (189) | PROVED (Theorem 189, §3.4; rate ¼δ₀, scale (L^jη)^{−3}, size ε₃, constant C₁₈₉ named) | Lemmas A, C, L (PROVED); (K-H) = CMP 99 (3.133) [rests on (3.132)]; (K-𝔇) = CMP 102 (73) [proved there from (69), (71) (CMP 96 Lemma 2.1, READ, proved) and (72) (Prop. 5 of CMP 98, not read here)]; (K-Π) = (3.132) [ANALOGY, A1]; Prop. 4's V₀ bounds (CMP 102 pp. 291–292, proved there) |
| CMP 102 (190) | PROVED with rate ¼δ₀ ≥ ⅛δ₀ (Theorem 190, §3.5), entries 4–5 via (133), not via G̃ | the inputs of (189) plus CMP 99 Theorem 3.3 (G, via Theorem 3.10 — A3, sketched), (3.137), (3.49), (130), Δ′ local; complex generality §3.7 via Theorem 3.4 (PROVED in CMP 99) |
| Lemma A (second-order adjoint identity) | PROVED; verified numerically (toy S1, 4e−11, failing control) | — |
| CMP 99 random walks: G′, (Q′G′²Q′*)^{−1} | PROVED in print by reference to CMP 95/96 (on disk; CMP 96 Prop. 2.2 checked) | — |
| CMP 99 random walks: G (Theorem 3.10) | SKETCHED; the smallness of R's terms asserted in words; (3.97) quotes CMP 89 (not on disk) | A3, A5 |
| CMP 99 (QGQ*)^{−1}: (3.132) and its walks | ASSERTED BY ANALOGY (A1); §5 reduces it to one named lower bound (T ≥ C₁^{−1}ℓ², a competitor field) plus (U+), the upper bound and the decay step PROVED | A1 → §5 |
| H, H₀, G̃ (all three propagators CMP 116 decouples) | rest on A1 (each contains (QGQ*)^{−1}) and A3; G̃, H₀ tree-like walks asserted (A6) | A1, A3, A6 |
| CMP 116 Lemmas 1–2 | rest on: the walks of H, H₀, G̃ (A1, A3, A6); CMP 102 §§C, E (proved there); CMP 109 (I.3.54) via (1.24), which uses (190) (now PROVED GIVEN A1, A3); Prop. 4 for V(s) — needs the (87)–(89) form (precision §4); δ₁M ≥ κ₁ (order of constants) | A1, A3, A6 |
| M3c Lemma M, Theorem BB4*, Lemma W, Lemma C/C′, Lemma FP | PROVED GIVEN CMP 116 Lemmas 1–2 (M3c §9.1): (190) is no longer an unchecked input; BB4* needs only a positive decay rate, so it survives any rate the A1 route delivers | the CMP 116 row |
| M3R's Lemma B (finite F, strip analyticity of S_k) | the (190) input PROVED GIVEN A1, A3; its other conditions as M3R lists | A1, A3 + M3R's list |

THE ONE MISSING ESTIMATE UNDER (189)–(190) AND UNDER CMP 116 §1: CMP 99 (3.132), the decay of (QGQ*)^{−1}, written "by analogy". Its proof is
§5's sandwich: the upper half is the two-line variational bound above, the lower half one competitor field.

## 7. CROSS-FIELD UNIFICATIONS FOUND

(U1) THE SECOND-ORDER ADJOINT IS THE TOOL BAŁABAN LACKED. Lemma A is the Lagrangian/adjoint-state method of PDE-constrained optimization
(the Hessian of a reduced functional V(A′) = W(A′, D(A′)) with D defined implicitly is the Hessian of W + ⟨Λ,F⟩ on the tangent of the
constraint, Λ from one adjoint solve) — the "second-order adjoint" of optimal control and of automatic differentiation (reverse-over-forward).
It removes δ²D/δA′² — the reason Bałaban called the calculation "very awkward". The multiplier Λ is O(ε): it is the constraint's dual
variable, the analogue of the Lagrange multiplier M3R found in (B-i).
(U2) DECAY IS A BANACH-ALGEBRA PROPERTY, AND THE RATE LOSS IS BOOKKEEPING. Bałaban's halvings δ₀ → ½δ₀ → ¼δ₀ → ⅛δ₀ are one loss per stage;
in the weighted Schur algebra (Lemma C, Combes–Thomas) the rate is lost once per chain, and the toy shows the object keeps the full minimal
rate (ratios 1.011 and 1.006). This is the same mechanism as Kotecký–Preiss/Brydges trees: the decay of a composite object is the tree length.
(U3) THE AVERAGED PROPAGATOR IS SANDWICHED BY ITS OWN GAUGE FIXING. The upper bound QGQ* ≤ (1−θ)^{−1}a^{−1} follows from the Q*aQ term of the
gauge-fixed operator alone — the Schur-complement (Dirichlet-to-Neumann) principle: the block average of a Green's function is bounded by the
inverse of the penalty that defines it. Its dual lower bound is a Poincaré/interpolation inequality. This is the same two-sided structure as
the chessboard (worst case) versus measure-weighted (typical) bounds of the crossover: an exact variational sandwich, not a kernel estimate.

## 8. PRECISIONS, DATED (2026-11-02, after §§0–7; nothing above edited)

8.1 LABELS. §6's status column reads "PROVED" for (189), (190); the correct label is the one of §3.4–3.5: PROVED GIVEN (K-H), (K-Π), (K-𝔇).
The (73) row "proved there" is conditional too: CMP 102 proves (73) from (69), i.e. from H's kernel bound (3.133), which rests on (3.132).
So: (189) and (190) are PROVED GIVEN exactly one estimate Bałaban did not prove in print — CMP 99 (3.132) — plus CMP 98 Prop. 5 (behind (72),
not read here) and the sketched CMP 99 Theorem 3.10 (A3). Everything else under them is on the page and checked.
8.2 COMPLEX BACKGROUNDS IN §5. The variational formula (V) needs G self-adjoint and positive, i.e. real backgrounds. At complex U′U the bound
(3.132) follows from the real case by the Neumann-series perturbation of CMP 99 Sect. B ((3.84)–(3.86), Theorem 3.4's own argument, READ p. 407),
so §3.7's complex generality is not weakened.
8.3 THE SMALLNESS IN THEOREM 190 IN SECT. G'S VARIABLES. ε₃* is a condition on the size of K = (δ²V/δA′²)(A′) at A′ = 𝒜₀ + H₀B, i.e. on
m(𝒜₀ + H₀B) = O(B₅ε₁) by (173) and (103)-(104) — Bałaban's "for ε₁ sufficiently small" at (187) (CMP 102's ε₁, the smallness (7) of the coarse
field V, not CMP 116's ε₁). It is not a free radius.
