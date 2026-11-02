# M3g — THE DEEPEST BLACK BOX OF THE ULTRAVIOLET HALF: CMP 99 (3.132), THE DECAY AND RANDOM-WALK EXPANSION OF (QGQ*)⁻¹

Proof agent M3g, 2026-11-02. Work directory `.../scratchpad/math/M3g/`. Appended as the work proceeds; nothing above a line is
edited after it is written except by a dated correction below it. Labels: READ (on the rendered page image, today), PROVED (full
proof here), PROVED GIVEN [named source], OPEN (stated with the attempt and falsifier), COMPUTED (record named), STAKE (written
before a computation).

## 0. Sources and assignment

Assignment (M3g): (1) the lower bound QGQ* ≥ C₁⁻¹ℓ² by a competitor field, explicit constants, uniform in k and on the
complexified domain, in Bałaban's notation; (2) (3.132) assembled: positivity + boundedness ⟹ Combes–Thomas decay ⟹ the
random-walk expansion with its convergence; (3) Theorem 3.10 for G completed, the tree-shaped walks proved, and whether CMP 98
Prop. 5 and CMP 89 are needed.

Read first (today): `math/MATH_BRIEF.md`; `math/M3e/WORK.md` whole (§§0–8); then `math/M3/WORK.md`, `math/M3c/WORK.md`,
`math/M3cR/REVIEW.md`, `math/M3d/WORK.md` for the (3.132)-relevant parts. Primary texts: the eleven Bałaban papers of M3b §0
(SHA-256 prefixes there), CMP 99 = `C:\Users\Edwin Boston\Downloads\1103942769.pdf` (39f8033b35838c7b), CMP 95 = `1103941451.pdf`,
CMP 96 = `1103941783.pdf`, CMP 98 = `Download (5).pdf`. Page images: M3e's `render/cmp99_*.png` (150 dpi) and mine in `render/`.

## 1. WHAT IS READ (CMP 99 on image and text layer today; CMP 98 text layer pp. 34–42)

R1 (p. 393, image). (3.14) (L^jη)^{-1}Q_j(U,ηA) = Q_j(U)A + (L^jη)^{-1}C_j(U,L^jηA); (3.15) Q_j(U) = Q(Ū^{j−1})⋯Q(Ū)Q(U), one-step
operators of CMP 98 (124); Λ_j = Ω_j^{(j)}∖Ω_{j+1}^{(j)}, Ω_j∖Ω_{j+1} = B^j(Λ_j), so the blocks B^j(y), y ∈ Λ_j, j = 0..k, PARTITION Ω₀;
(3.16) ⟨A,Q*aQA⟩ = Σ_j a Σ_{b∈Λ_j}(L^jη)^{d−2}|(Q_j(U)A)(b)|²; (3.18)–(3.19) (Q′_jλ)(y) = Σ_{x∈B^j(y)}L^{−jd}R(U(Γ^{(j)}_{y,x}))λ(x).
R2 (CMP 98 (124)–(125), text p. 36): the one-step linear average is a MAIN TERM (Q_{V₀}A)_c = Σ_{x∈B(c₋)}L^{−(d+1)}(R_{0,c₋}A)([x,x′])
(line integral over the L parallel bonds from x to x′ = x + Le_μ, transported to c₋) plus terms carrying g(−z)−1, g^{−1}(z)−1, e^{iz}−1,
"equal to 1 for z = 0", bounded by O(L²α₀); (139)–(147): |Q_{V₀}A| ≤ Q|A|, |Q″(V₀)A| ≤ C′₁L²α₀Q″|A|, by induction
(Q_k(U₀)A)_c = Σ_b L^{−kd}Q_k(U₀;c,b)A_b with |Q_k(U₀;c,b)| ≤ 1 + 2C₁α₀ (147) — COEFFICIENT-WISE bounds.
R3 (p. 406, image). (3.80)–(3.81): Q_j(U′U) = Q_j(U) + F_{2,j}(A), |F_{2,j}(A)A′| ≤ O(1)α₁Q″_j|A′| on Λ_j — dominated by a POSITIVE average
Q″_j (CMP 98 (141), coefficients L^{−jd}·1 on B^j(c₋)∪B^j(c₊)), hence coefficient-wise |F_{2,j}(A)(c,b)| ≤ O(1)α₁; the same for Q*_j.
R4 (pp. 394–396, text). R = I − G′Q′*(Q′G′²Q′*)^{−1}Q′G′ (3.25), an ORTHOGONAL PROJECTION in L²(Ω̃₀,g); Δ_a = Δ + DRD* + Q*aQ (3.26),
G₀ = Δ_a^{−1} with Dirichlet conditions on Ω₀^c (3.27); regularity (3.35)–(3.36) on cubes of side O(1)M blocks; (3.37) complex domain.
R5 (p. 404, text). (3.69): |(Δ′(U′U)A′)(b)| ≤ O(1)(Mα₀ + α₁)(L^jη)^{−2}|A′| over the plaquettes at b — Δ′ is a BOUNDED LOCAL operator.
R6 (p. 419, image). (3.117) exact: ⟨A−Dλ,Δ(A−Dλ)⟩ = ⟨A,ΔA⟩ − ⟨i[λ(b₋),A(b)] − i[A(b),R_bλ(b₊)] − i[λ(b₋),(Dλ)(b)], J⟩, J = D*η^{−2}Im∂U;
(3.119) ⟨A,Δ_πA⟩ = ⟨A−DG′RD*A, Δ(A−DG′RD*A)⟩; (3.120) ⟨A,Δ_πA⟩ = ⟨A,ΔA⟩ − ⟨A,Δ′_πA⟩, the three J-terms with λ = G′RD*A.
R7 (p. 420, text; M3e READ on image). (3.122) G^{−1} = Δ_π + DRD* + Q*aQ; Lagrange: min{½⟨A,G^{−1}A⟩ : QA = B} attained at
A = GQ*(QGQ*)^{−1}B; (3.126) HB = GQ*(QGQ*)^{−1}B.
R8 (p. 422, image). (3.131) the kernel bound of Δ′_π (D* applied to A₁, small factor O(1)Mα₀); (3.132) |(QGQ*)^{−1}(y,y′)| ≤
O(1)(L^jη)^{−2}(L^{j′}η)^{−d}e^{−δ₁d(y,y′)} and the same with G₁ — preceded by "can be analyzed in the same way as the operator
(Q′G′²Q′*)^{−1}. We will not repeat these considerations here"; (3.133) H from (3.126) and (3.132); (3.136)–(3.137): |⟨δA,Δ^{(2)}A⟩| ≤
O(1)C₃Mα₀Σ_jΣ_b(L^jη)^{d−2}(Q″_j|δA|)(c)|A|_c, using |(H*J)(b)| ≤ O(1)Mα₀(L^jη)^{−3} FROM (3.133).
R9 (pp. 413–416, 427, text). Theorem 3.10 = expansion (3.105)–(3.108); the P-term (3.97) quotes CMP 89 (not on disk); Theorem 3.11
(positivity) by G = G₀(I−R)^{−1}, ‖R‖ = O(M^{−1}); p. 427 tree-like walks for G₁, H₁ ("main line and at some vertices additional lines
spring off … d(ω,y,y′) is now a length of a shortest tree").

CONVENTIONS USED BELOW (fixed once). Fine fields A: g-valued on bonds of Ω₀ (zero outside), ⟨A,A′⟩ = Σ_b η^d tr A(b)*A′(b). Block
fields B on 𝔅 = ∪_jΛ_j: on the block bonds c of T^{(j)}_{L^jη} counted in (3.16) (READ as: both ends in Λ_j), ⟨B,B′⟩_𝔅 =
Σ_j Σ_{c∈Λ_j}(L^jη)^d tr B(c)*B′(c); ℓ := L^jη on Λ_j (on fine bonds of Ω_j∖Ω_{j+1}; ℓ := η on Ω̃₀∖Ω₀). (QA)(c) = Σ_b L^{−jd}Q_j(c,b)A(b)
(3.102), so Q*B(b) = Σ_c Q_j(c,b)^†B(c) (because ℓ^dL^{−jd} = η^d), and (3.16) reads ⟨A,Q*aQA⟩ = ⟨QA, aℓ^{−2}QA⟩_𝔅 (a = 1 as in Thm 3.1;
if (3.16)'s a carries the index of (3.24), a_j ∈ [a_min,a_max] and only a_max enters below). T := QGQ*, T̂ := ℓ^{−1}Tℓ^{−1} on 𝔅.
"X ≥ cℓ^{−2}" means ⟨B,XB⟩ ≥ c‖ℓ^{−1}B‖², etc.

## 2. THEOREM L — THE LOWER BOUND QGQ* ≥ C₁^{−1}ℓ² BY ONE COMPETITOR FIELD

### 2.0 Why not the minimal-norm preimage (a refutation, recorded)
The obvious competitor A = Q*(QQ*)^{−1}B FAILS: at U = 1 the functional of a μ-block-bond is a tent in μ and the INDICATOR of the
block cross-section in the transverse directions (Lemma L1), so Q*h jumps by |h(c) − h(c′)| across every transverse block face; the
plaquette derivative (DA)_{μν} = −∇_νA_μ there carries energy L^{j(d−1)}η^{d−2}|Δh|² per face against ℓ^{d−2}|h|² = L^{j(d−2)}η^{d−2}|h|²
— a ratio L^j, not uniform in the scale. The competitor must be SMOOTH TRANSVERSALLY: tent in μ (as Q's own), a tent profile vanishing at
the transverse faces, then an exact correction by (QE)^{−1}.

### 2.1 LEMMA L1 (Q at U = 1 is the tent average) — PROVED from R1, R2
For c = (c₋, c₋+L^jηe_μ) ∈ Λ_j: (Q_j(1)A)(c) = L^{−jd}Σ_{x∈B^j(c₋)} L^{−j}Σ_{s=0}^{L^j−1}A_μ(x+sηe_μ). Equivalently Q_j(1)(c,b) = φ(s) :=
w(s)/n, n := L^j, w(s) := min(s+1, 2n−1−s), for the μ-bonds b of the slab S(c) = B^j(c₋)∪B^j(c₊) at μ-position s ∈ [0, 2n−1) (relative to
the first layer of B^j(c₋)), any transverse position; zero for ν-bonds (ν ≠ μ) and outside S(c).
PROOF. At V₀ = 1 the contour variables are 1, so R_{0,c₋} = id and every non-main term of (124) carries a factor vanishing at z = 0 (R2):
Q(1) = the one-step line average. Composition: if (Q_m(1)A)(c) is the line average of length L^m from the points of B^m(c₋), then
(Q(1)Q_m(1)A)(c′) = L^{−d}Σ_{y∈B(c′₋)}L^{−1}Σ_{r<L}(Q_m(1)A)(y+rL^mηe_μ) = avg_{x∈B^{m+1}(c′₋)}L^{−(m+1)}Σ_{s<L^{m+1}}A_μ(x+sηe_μ), since the
lines from x₀+rL^mηe_μ (x₀ ∈ B^m(y)) concatenate (r = 0..L−1) to the line of length L^{m+1} from x₀. Induction on m with (3.15). Counting
the lines through a bond at position s gives w(s). CHECK of the normalization: for A = Dλ the line sum telescopes and Q_j(1)Dλ =
D_jQ′_j(1)λ (block derivative (L^jη)^{−1}(·) of block averages) — Bałaban's (3.115) at U = 1. ∎

### 2.2 THE COMPETITOR E(U) AND LEMMA L2 (Q(1)E(1) EXACTLY) — PROVED
Transverse profile: b_n(t) := min(t+1, n−t)/m_n on t ∈ {0,…,n−1}, m_n := n^{−1}Σ_t min(t+1,n−t) (= (n+2)/4, n even; (n+1)²/(4n), n odd),
so n^{−1}Σ_t b_n(t) = 1, 0 < b_n ≤ 2, |b_n(t+1)−b_n(t)| ≤ 1/m_n ≤ 4/n, and b_n(0) = b_n(n−1) = 1/m_n ≤ 4/n (the jump to 0 outside).
β(z) := Π_{i=1}^{d−1}b_n(z_i) on the cross-section z ∈ {0..n−1}^{d−1}: Σ_zβ = n^{d−1}, β ≤ 2^{d−1}.
ψ_c(b) := φ(s)β(z) for the μ-bonds b ∈ S(c) (position s, z), 0 otherwise. For a background U define
  (E(U)g)(b) := Σ_c ψ_c(b) R(U(Γ_{b₋←c₋}))g(c),   Γ_{x←y} the coordinate-ordered lattice path from y to x (axes 1,…,d) inside S(c).   (E)
(E(1)g = Σ_cψ_cg(c).) Covariance: R(U^u(Γ_{x←y})) = R(u(x))R(U(Γ_{x←y}))R(u(y))^{−1}, so E(U^u)R(u) = R(u)E(U) with (R(u)g)(c) =
R(u(c₋))g(c), (R(u)A)(b) = R(u(b₋))A(b) — the same covariance as Q (p. 396: "the equalities (3.32) hold again").
LEMMA L2. Q(1)E(1) = M, block-diagonal over scales j, directions μ and μ-chains (maximal sequences c_m = (y+mL^jηe_μ, y+(m+1)L^jηe_μ) in
Λ_j), tridiagonal Toeplitz on each chain:
  M(c_m,c_m) = (2n²+1)/(3n²),  M(c_m,c_{m±1}) = (n²−1)/(6n²),   σ(M) ⊂ [(n²+2)/(3n²), 1] ⊂ [1/3, 1].                              (L2)
PROOF. (Q(1)ψ_c)(c′) = L^{−jd}Σ_{b∈S(c′)}φ_{c′}(s)ψ_c(b): zero unless c′ is a μ-bond whose slab meets S(c) in μ-bonds with the same
cross-section, i.e. c′ = c_{m′} on c's chain, |m′−m| ≤ 1 (other directions: Q(1) of a ν-bond reads ν-components only; other chains:
disjoint cross-sections). Then (Q(1)ψ_{c_m})(c_{m′}) = L^{−jd}(Σ_zβ)Σ_sφ_{m′}(s)φ_m(s) = n^{−1}Σ_sφ_{m′}φ_m. Σ_sφ_m² = n^{−2}[2Σ_{t=1}^{n−1}t² + n²]
= (2n²+1)/(3n); Σ_sφ_mφ_{m+1} = n^{−2}Σ_{t=1}^{n−1}t(n−t) = (n²−1)/(6n). Symbol (2n²+1)/(3n²) + ((n²−1)/(3n²))cos θ; a finite chain is a
principal section, whose spectrum lies in the symbol's range (Rayleigh quotient). n = 1 (j = 0): M = I. ∎

### 2.3 LEMMA L3 (LOCAL GAUGE COMPARISON, COEFFICIENT-WISE) — PROVED GIVEN R3 (CMP 99 (3.81), on CMP 98 (124), (139)–(143), Prop. 6)
Fix c ∈ Λ_j and the set N(c) of block bonds c′ with S(c′)∩S(c) ≠ ∅ (|N(c)| ≤ 4d). There is a cube □ of the class of (3.35) containing
∪_{c′∈N(c)}S(c′) and u on □ with U^u = e^{iηA}, |A| ≤ C_rMα₀ℓ^{−1}, |∇A| ≤ C_rMα₀ℓ^{−2} (3.35), C_r = O(1). Then for c′ ∈ N(c), b ∈ S(c′):
 (i) |Q_j(U^u)(c′,b) − Q_j(1)(c′,b)| ≤ C_QMα₀  [(3.80)–(3.81) at U = 1, U′ = e^{iηA}, α₁ = C_rMα₀; Q_j(·)(c′,·) depends only on the
     configuration in S(c′) (the averages (3.78) are composed inside the j-block pair), so A may be extended outside □ arbitrarily];
 (ii) |R(U^u(Γ)) − 1| ≤ C_ΓMα₀ for every lattice path Γ ⊂ □ of length ≤ 4dn fine steps (|ηA| ≤ C_rMα₀/n per bond; |Π_{≤4dn}e^{iηA} − 1| ≤
     e^{4dC_rMα₀} − 1; |R(V)−1| ≤ 2|V−1|), C_Γ := 16dC_r for Mα₀ ≤ 1/(8dC_r);
 (iii) for the two coordinate-ordered paths ending at x and at x+ηe_ν (same start), |R(U^u(Γ_{x+ηe_ν←y})) − R(U^u(x+ηe_ν←x))R(U^u(Γ_{x←y}))|
     ≤ C′_ΓMα₀η/ℓ: the two paths differ by a strip of width η and length ≤ dnη; the line sums of ηA along its two long sides differ by
     ≤ dnη·η|∇A| ≤ dC_rMα₀η/ℓ, and the second-order terms of the product formula are O((C_rMα₀)²η/ℓ).
CONSEQUENCE: with Φ := Q(U^u)E(U^u) − Q(1)E(1), coefficient-wise |Φ(c′,c)| ≤ (4C_Q + 2^{d+1}C_Γ + O(Mα₀))Mα₀ =: C′_ΦMα₀ (each entry is
L^{−jd}Σ_b over ≤ 2n^d bonds of products of coefficients ≤ 1, ≤ 2^{d−1}, with one factor O(Mα₀)).

### 2.4 LEMMA L4 (CHAINS CARRY NO HOLONOMY) — PROVED
Back in the original gauge, (Q(U)E(U))(c′,c) = R(u(c′₋))^{−1}[M(c′,c) + Φ(c′,c)]R(u(c₋)) = M(c′,c)R(U(Γ_{c′₋←c₋})) + Φ̃(c′,c), Γ the
straight block-to-block line, |Φ̃(c′,c)| ≤ (C′_Φ + C_Γ)Mα₀ =: C_ΦMα₀ (by (ii): R(u(c′₋))^{−1}R(u(c₋)) = R(U(Γ_{c′₋←c₋}))R(U^u(Γ))^{−1}).
M^U(c′,c) := M(c′,c)R(U(Γ_{c′₋←c₋})) lives on chains (1-dimensional) with nearest-neighbour unitary links, the reverse link the inverse:
the gauge 𝒱 = diag(V_m), V_{m+1} := R(U(Γ_{c_{m+1}←c_m}))V_m, gives 𝒱^{−1}M^U𝒱 = M ⊗ 1_g exactly. Hence σ(M^U) = σ(M) ⊂ [1/3, 1]. ∎

### 2.5 LEMMA L5 (QE IS INVERTIBLE, UNIFORMLY) — PROVED GIVEN L3
‖Φ̃‖_{ℓ²(𝔅)} ≤ 4dC_ΦMα₀ (Schur: QE preserves the scale, so the kernel is w.r.t. the counting measure on one Λ_j; row and column sums ≤
|N(c)|·max|Φ̃|). If 4dC_ΦMα₀ ≤ 1/12: Re⟨g,Q(U)E(U)g⟩_𝔅 ≥ (1/3 − 1/12)‖g‖²_𝔅, so QE is invertible (Lax–Milgram) with
‖(QE)^{−1}‖ ≤ 4, and (QE)^{−1} commutes with ℓ (block-diagonal in j). The statement holds verbatim for complex U′U in (3.37) with Mα₀
replaced by Mα₀ + α₁ ((3.81) for Q, the analytic transports for E). In particular Q(U) is ONTO 𝔅 and Q(U)* is injective.

### 2.6 LEMMA L6 (ENERGY OF THE COMPETITOR) — PROVED GIVEN L3 (iii)
∇^U: the covariant forward difference (∇^U_νA)(b) = η^{−1}[R(U(b₋, b₋+ηe_ν))A(b+ηe_ν) − A(b)], all ν, all bonds. For every block field g,
  ‖∇^U E(U)g‖² ≤ C_∇‖ℓ^{−1}g‖²_𝔅,  ‖ℓ^{−1}E(U)g‖² ≤ C₀‖ℓ^{−1}g‖²_𝔅,   C_∇ := 2^{2d+8}d,  C₀ := 2^{2d}  (Mα₀ ≤ ε₆(d)).              (L6)
PROOF (computed in the local gauge of each c, the norms being gauge invariant). |∇_ν(φβ)| ≤ η^{−1}(n^{−1}·2^{d−1} + 1·(4/n)2^{d−2}) ≤ 2^{d+1}/ℓ,
including the jumps to 0 at ∂S(c) (φ(0) = φ(2n−2) = 1/n, b_n(0) = b_n(n−1) ≤ 4/n); the transports add ≤ |φβ|C′_ΓMα₀/ℓ (L3 (iii)), so
|∇^Uψ_c| ≤ 2^{d+2}/ℓ. At a bond, ≤ 4 terms of Σ_c meet (the two slabs of a chain, at b and b+ηe_ν): |∇^UEg(b)|² ≤ 4Σ_c|∇^Uψ_c(b)|²|g(c)|².
Sum: ≤ 4·2^{2d+4}ℓ^{−2}Σ_c|g(c)|²η^d·2d·2n^d = 2^{2d+8}d Σ_cℓ^{d−2}|g(c)|² (η^dn^d = ℓ^d). Similarly ‖ℓ^{−1}Eg‖² ≤ 2·2^{2d−2}·2Σ_cℓ^{d−2}|g(c)|². ∎
Since ‖DA‖² ≤ 2‖∇^UA‖² ((DA)(p_{μν}) = D_μA_ν − D_νA_μ, p. 391) and ‖D*A‖² ≤ d‖∇^UA‖² (‖D*_μA_μ‖ = ‖D_μA_μ‖ by reindexing, transports
unitary): ‖DEg‖² ≤ 2C_∇‖ℓ^{−1}g‖², ‖D*Eg‖² ≤ dC_∇‖ℓ^{−1}g‖².

### 2.7 LEMMA L7 (G^{−1} BOUNDED ABOVE BY LOCAL FORMS) — PROVED GIVEN Theorem 3.1 (G′) and (3.35)–(3.36)
For real U and every field A on Ω₀:
  ⟨A,G^{−1}A⟩ ≤ ‖DA‖² + (1 + c_πMα₀)‖D*A‖² + (c_Δ + c_π)Mα₀‖ℓ^{−1}A‖² + ‖a^{1/2}ℓ^{−1}QA‖²_𝔅.                                       (L7)
PROOF. G^{−1} = Δ_π + DRD* + Q*aQ (R7). (a) Δ = D*D + Δ′ with |⟨A,Δ′A⟩| ≤ c_ΔMα₀‖ℓ^{−1}A‖² by R5 (bounded local operator, overlap ≤ 4d(d−1)).
(b) ⟨A,DRD*A⟩ = ‖RD*A‖² ≤ ‖D*A‖² (R an orthogonal projection, R4). (c) LEMMA U2: |⟨A,Δ′_πA⟩| ≤ c_πMα₀(‖D*A‖² + ‖ℓ^{−1}A‖²). By (3.120)
with λ := G′RD*A: |⟨A,Δ′_πA⟩| ≤ Σ_bη^d|J(b)|(2|λ(b₋)| + 2|λ(b₊)|)|A(b)| + Σ_bη^d|J(b)||λ(b₋)||(Dλ)(b)| (|[X,Y]| ≤ 2|X||Y|, R_b unitary).
|J| ≤ c_JMα₀ℓ^{−3} (J = D*η^{−2}Im∂U; in the gauge of (3.35)–(3.36) η^{−2}Im U(∂p) is the curl of A up to O(Mα₀)²ℓ^{−2}, and
|D*DA| ≤ O(1)Mα₀ℓ^{−3} by (3.36)). THEOREM 3.1 (G′ ∈ 𝒪(B₀;2;δ₀), ∇G′ ∈ 𝒪(B₀;1;δ₀), (3.42)) with Schur's test, Lemma 2.1 (2.61) of
CMP 96 and the scale conversion of p. 398 gives ‖ℓ^{−2}G′f‖ ≤ K′‖f‖, ‖ℓ^{−1}DG′f‖ ≤ K′‖f‖, K′ := B₀c₁(½)L²; and ‖RD*A‖ ≤ ‖D*A‖. Hence
|⟨A,Δ′_πA⟩| ≤ c_JMα₀[8dK′‖D*A‖‖ℓ^{−1}A‖ + K′²‖D*A‖²] ≤ c_πMα₀(‖D*A‖² + ‖ℓ^{−1}A‖²), c_π := c_J(4dK′ + K′²). [On Ω̃₀∖Ω₀, ℓ = η and
Theorem 3.1 at index 0 is used there.] ∎  (Do NOT apply (3.131) to a block-cut field: D* of a cut field carries η^{−1} boundary terms;
(3.120) avoids the cut.)

### 2.8 THEOREM L — PROVED GIVEN Theorem 3.1 (G′), CMP 99 (3.69), (3.80)–(3.81), (3.120), (3.35)–(3.36)
Let U be real, satisfy (3.35)–(3.36), Mα₀ ≤ ε_L(d,L) := min{1/(48dC_Φ), ε₆, 1/(8dC_r), 1/(c_Δ+c_π)}. For every k, every admissible
{Ω_j} (CMP 96 (2.1)–(2.2)) and every block field B on 𝔅:
  ⟨B,(QGQ*)^{−1}B⟩_𝔅 ≤ C₁‖ℓ^{−1}B‖²_𝔅,  equivalently  QGQ* ≥ C₁^{−1}ℓ²,                                                             (L)
  C₁ := a + 16[(2 + 2d)C_∇ + 2C₀] ≤ a + 2^{2d+14}d²   (d = 4: C₁ ≤ 1 + 2^{26} ≈ 6.7·10⁷; crude, explicit, k- and {Ω_j}-independent).
PROOF. G > 0 (Theorem 3.11/3.12) and Q onto (L5) give T = QGQ* > 0, and the Lagrange computation R7 gives ⟨B,T^{−1}B⟩ =
min{⟨A,G^{−1}A⟩ : QA = B}. Competitor A_B := E(U)(Q(U)E(U))^{−1}B: QA_B = B exactly. With g := (QE)^{−1}B, ‖ℓ^{−1}g‖ ≤ 4‖ℓ^{−1}B‖ (L5),
(L7) and (L6): ⟨A_B,G^{−1}A_B⟩ ≤ [2C_∇ + 2dC_∇ + 2C₀]·16‖ℓ^{−1}B‖² + a‖ℓ^{−1}B‖² (the Q*aQ term equals a‖ℓ^{−1}B‖² by the constraint).
T^{−1} ≤ C₁ℓ^{−2} ⟹ T ≥ C₁^{−1}ℓ² (operator monotonicity of inversion on positive operators). ∎
THE FALSIFIER IS EXCLUDED: λ_min(ℓ^{−1}QGQ*ℓ^{−1}) ≥ C₁^{−1} for all k, all {Ω_j}, all real regular U — no near-zero mode, uniform in k.
GROUP: nothing used is specific to SU(2): U(N)-valued transports, R(V) = Ad V unitary on g with the HS norm, G ⊂ U(N) compact semisimple
— the theorem holds for every such G (Bałaban's generality, p. 389).

### 2.9 STAKES FOR THE CHECKS (written before any run; results go below, nothing here edited)
S1 (exact, rationals, `bin/gram_exact.py`): for n = 1..32 the tent Gram entries equal (2n²+1)/(3n), (n²−1)/(6n) EXACTLY, the competitor
   matrix Q(1)E(1) built from the definitions (tents, the transverse profile b_n, d = 2, 3, 4) equals M of (L2) entry by entry, and the
   smallest eigenvalue of M on chains of length K = 1..12 is ≥ (n²+2)/(3n²) ≥ 1/3.
S2 (double precision, labelled a CHECK not a proof, `bin/toy2d.py`): 2D abelian Bałaban operators at U = 1 built from the definitions —
   the tent Q of L1, Q′ the block average, G′ = (Δ₀ + Q′*aQ′)^{−1}, R = I − G′Q′*(Q′G′²Q′*)^{−1}Q′G′, G^{−1} = d*d + dRd* + Q*aQ
   (Δ_π = d*d at U = 1), a = 1, Dirichlet outside the box. STAKES: (a) R is an orthogonal projection to 1e−10; (b) λ_max(T̂) ≤ 1 = a^{−1}
   (the upper half is exact at U = 1); (c) λ_min(T̂) ≥ C₁^{−1} (d = 2: C₁ = 786945) — and, the meaningful stake, λ_min(T̂) lies in
   [0.01, 1] and does NOT fall with the scale: single scale n = 1, 2, 4, 8 (6×6 blocks) with λ_min(n=8)/λ_min(n=4) ≥ 0.5; three scales
   (blocks 1, 2, 4 nested, N = 32) with λ_min ≥ 0.5·min of the single-scale values; (d) the competitor energy ratio
   ⟨A_B,G^{−1}A_B⟩/‖ℓ^{−1}B‖² at the worst B (top eigenvector of T̂^{−1}) is ≤ C₁ and ≥ 1/λ_min(T̂) (it must be, the minimum being the
   minimizer's); (e) Q(1)E(1) in the toy equals M and QA_B = B to 1e−12.
Kill-switch: λ_min(T̂) falling by ≥ 2× from n = 4 to n = 8 would be the uniform near-zero mode the falsifier names.

### 2.10 RESULTS (COMPUTED; records `rec/gram_exact.2026-11-02a.txt`, `rec/toy2d.2026-11-02a.txt`, `rec/toy2d_dbg.2026-11-02a.txt`,
`rec/toy2d_v2.2026-11-02a.txt`; scripts in `bin/`)
S1 HELD (exact rationals): the Gram entries equal (2n²+1)/(3n), (n²−1)/(6n) for n = 1..32; Q(1)E(1) = M entry by entry (d = 2, 3, 4;
   n = 1, 2, 3, 4, 5, 8; chains K = 1..12); min[λ_min(M) − (n²+2)/(3n²)] = 0.0 (equality at n = 1, M = I).
S2 (first toy, `toy2d.py`, block bonds with BOTH ends in Λ_j): (a) R a projection to 1.8e−15 HELD; (e) |QE − M| ≤ 2.2e−16, |QA_B − B| ≤
   1.4e−16 HELD; single scale n = 1, 2, 4, 8: λ_max(T̂) = 1.000000 HELD (b); λ_min(T̂) = 0.1174, 0.0362, 0.0221, 0.0190, ratio n=8/n=4 = 0.859
   HELD (c, single scale); (d) worst-B competitor/minimal energy 8.52/8.52, 28.3/27.6, 49.4/45.2, 62.8/52.6 HELD (≤ C₁, ≥ 1/λ_min) — the
   competitor is within 20% of the minimizer, while C₁ = 786945 (d = 2): the theorem's constant is crude by ~10⁴, the object is not.
   THREE SCALES: λ_max(T̂) = 1.0126 > 1 — impossible by the exact variational argument — so the run was checked (`toy2d_dbg.py`):
   G^{−1} has eigenvalue −6.5e−15, |G^{−1}G − I| = 0.49: G^{−1} IS SINGULAR in that geometry. Cause (proved by counting): with block bonds
   confined to one scale region, every λ whose block averages are constant on each region (c₀, c₁, c₂) has Q(Dλ) = D_jQ′λ = 0, and the
   condition RΔλ = 0 imposes only dim range R = dim N(Q′) equations on the (dim N(Q′) + #regions)-dimensional family: ≥ #regions − 1 = 2
   gauge zero modes A = Dλ with DA = 0, RD*A = 0, QA = 0. So reading (B) of "b ∈ Λ_j" is NOT Bałaban's operator.
THE CONVENTION, READ (CMP 96 p. 224, text layer): "we will apply the same notations to sets of bonds … Ω also the set of bonds
   ∪_{x∈Ω}st(x) = {bonds b ⊂ T: at least one end-point of b belongs to Ω}". So the block bonds of (3.16) at scale j are the j-lattice bonds
   with AT LEAST ONE endpoint in Λ_j — including the interface-crossing ones (inward into Ω_{j+1}, outward into Ω_{j−1}∖Ω_j).
S2′ (`toy2d_v2.py`, the correct convention): G^{−1} positive definite in every geometry (min eig 0.025 multiscale; 4.9e−3…0.13 single),
   |G^{−1}G − I| ≤ 1.6e−14; λ_max(T̂) = 1.000000 everywhere (b HELD). λ_min(T̂): single scale as before; THREE SCALES (L = 2) 0.001905
   (N = 32) and 0.001914 (N = 40, thicker rings) — the SAME: a local interface effect, volume-independent; TWO SCALES with L = 4 (blocks
   2/8): 0.002913. STAKE (c) "multiscale λ_min ≥ ½ single-scale" REFUTED: the interfaces lower λ_min by a fixed factor ≈ 1/10 (L = 2) —
   uniform in volume, not a decay. Riesz constant of Q (λ_min of W^{1/2}QQ^TW^{1/2}): 0.39–0.53 single scale, 0.038 (L = 2), 0.072 (L = 4)
   multiscale; cosine of the angle between the spans of adjacent scales' functionals: 0.926 (1|2), 0.947 (2|4), 0.893 (2|8) — < 1,
   identical at N = 32 and 40 (local). THE INTERFACES ARE WHERE THE CONSTANT LIVES.

### 2.11 CORRECTION TO §§2.2–2.8 (dated 2026-11-02, after S2′; nothing above edited)
What stands: L1, L3, L4, L6, L7 as stated; L2 and L5 for every scale region WITHOUT its interfaces (single scale, and all block bonds
whose slabs meet no functional of another scale). What fails: the claim in L2/L5 that Q(1)E(1) is block-diagonal across scales — with the
correct convention a j-bond crossing into Ω_{j+1} has its slab one j-block inside Ω_{j+1}, an outward (j+1)-bond has its slab one
(j+1)-block inside Ω_j∖Ω_{j+1}, and the cross-scale entries of Q(1)E(1) are O(1) (outward coarse tents seen by L^d fine functionals). The
repair (below) replaces the tent⊗profile competitor by a SMOOTHED GRAM competitor and puts the interface into one Riesz lemma.

LEMMA R (RIESZ BOUND FOR Q, ALL SCALES, ALL INTERFACES) — PROVED at U = 1; PROVED GIVEN L3 (i) at regular U.
  ⟨h,QQ*h⟩_𝔅 ≥ c_R‖h‖²_𝔅,  c_R = c_R(L,d) > 0, uniform in k, {Ω_j}, U.
PROOF AT U = 1. (i) Decoupling: a μ-functional reads μ-components only (L1), so QQ* is block-diagonal in μ. (ii) Composition: by L1,
Q_{j+1}(1) = Q^{(1)}Q_j(1): every (j+1)-functional is Σ_e a_{c′,e}g_e, a positive combination (one-step tent weights min(s+1,2L−1−s)/L
times L^{−d}) of the j-LEVEL line averages g_e over the j-bonds e of its slab. The family 𝒢_j = {g_e : e a j-bond in direction μ} (all of
them, constrained or not) is Riesz with constant 1/3 relative to ℓ_j^d (L2 applied to the whole j-lattice chains). (iii) Constrained vs
free: the scale-j functionals near the interface are a subfamily {g_e : e ∈ S₁} (j-bonds touching Λ_j). A (j+1)-bond c′ touching Λ_{j+1}
is INTERIOR (its slab has no j-bond touching Λ_j: then all its coefficients sit on free e) or OUTWARD (slab B^{j+1}(z)∪B^{j+1}(z′), z′ ∉
Ω_{j+1}: the coefficients on the outer block and on the crossing j-bonds are constrained; on the inner block's j-bonds at positions
s = 0..L−2 (weights (s+1)/L) they are free). Each (j+1)-chain in direction μ exits Ω_{j+1} through a flat face of its own cross-section,
so the free parts along a chain form a tridiagonal Gram: interior diagonal a = (2L²+1)/(3L), off b = (L²−1)/(6L), the last (truncated)
diagonal a′ = (L−1)(2L−1)/(6L), off b; positive definite for every L ≥ 2 (Gershgorin: a − 2b = (L²+2)/(3L), a′ − b = (L−1)(L−2)/(6L) > 0
for L ≥ 3; L = 2: the tail [[3/2, 1/4],[1/4, 1/4]] has λ_min ≥ 0.20 and the chain λ_min ≥ 0.19). Call its relative lower bound κ_A². (iv)
With 𝒜h := (coefficients of Q*h in 𝒢_j) = (h_j + X) on S₁ ⊕ Y on S₁^c, X ⊕ Y := A^Th_{j+1}: ‖Y‖² ≥ κ_A²‖h_{j+1}‖², ‖X ⊕ Y‖ ≤ ‖A‖‖h_{j+1}‖,
so ‖𝒜h‖² ≥ min{¼, κ_A²/2, κ_A²/(8‖A‖²)}(‖h_j‖² + ‖h_{j+1}‖²) (two cases ‖h_j‖ ≷ 2‖X‖), and ‖Q*h‖² ≥ ⅓‖𝒜h‖². (v) Interfaces of
different scale pairs are ≥ RM blocks apart; combine the local bounds by an IMS partition of unity on the block lattice, error O(M^{−2}).
REGULAR U: the IMS pieces in the local gauges of L3, coefficients O(Mα₀)-close to U = 1 (L3 (i)), Schur: c_R(U) ≥ c_R(1) − O(Mα₀) − O(M^{−2}).
(S2′ reads c_R = 0.038 at L = 2, 0.072 at L = 4 in d = 2: positive and local, as the lemma says.)

LEMMA S (SMOOTHING) — PROVED (routine bookkeeping, constants of d, L). S := covariant cube average at x over the cube of half-side
r(x) = ⌊εℓ_min(x)/η⌋ (ℓ_min(x): the smallest ℓ within distance 2ℓ(x), ≥ ℓ(x)/L by the RM-separation of non-adjacent scales; r = 0 means
S = I), transports along coordinate-ordered paths. (a) ‖S‖ ≤ L^{d/2}; (b) ‖∇^USf‖ ≤ (2/(εℓ_min) + O(Mα₀)/ℓ)‖f‖_loc, so ‖∇^USQ*h‖² ≤
C_S ε^{−2}L²‖ℓ^{−1}h‖²_𝔅 (r varies by ≤ 1 per lattice step if ℓ_min is replaced by its κ-Lipschitz minorant, κ = 1/(4ε)); (c) Q*h is
piecewise linear on scale ℓ with jumps only on block faces and interface surfaces, so |(I−S)Q*h| ≤ ε|h|_loc off a layer of relative
volume ≤ 3dεL around those surfaces and ≤ 2|Q*h|_loc on it: ‖(I−S)Q*h‖² ≤ C′_S εL‖h‖²_𝔅.

THEOREM L′ (THE LOWER BOUND, CORRECTED) — PROVED GIVEN Theorem 3.1 (G′), (3.69), (3.80)–(3.81), (3.120), (3.35)–(3.36).
Competitor A_B := SQ*(QSQ*)^{−1}B. Re⟨QSQ*h,h⟩ = ‖Q*h‖² − Re⟨(I−S)Q*h,Q*h⟩ ≥ c_R(1 − (C′_SεL/c_R)^{1/2})‖h‖² ≥ ½c_R‖h‖² for
ε ≤ c_R/(4C′_SL); with a κ-slowly-varying weight ℓ̃ ≍ ℓ (κ = lnL/(RM)) the same holds for ℓ̃^{−1}QSQ*ℓ̃ up to O(κ), so
‖ℓ^{−1}(QSQ*)^{−1}B‖ ≤ 4L c_R^{−1}‖ℓ^{−1}B‖. Then by L7 and Lemma S (b):
  ⟨B,(QGQ*)^{−1}B⟩_𝔅 ≤ C₁′‖ℓ^{−1}B‖²_𝔅,   C₁′ := a + (2 + 2d)(1 + O(Mα₀))C_Sε^{−2}L²·16L²c_R^{−2}·L^d,
uniform in k, {Ω_j} and real regular U: QGQ* ≥ C₁′^{−1}ℓ². THE FALSIFIER (a near-zero mode uniform in k) IS EXCLUDED, now with the
interfaces included. The constant lives at the interfaces (c_R), exactly where S2′ shows λ_min(T̂) drops by ≈ 10 and stays.

PRECISION TO LEMMA R (iii) (COMPUTED, `rec/chain_kappa.2026-11-02a.txt`, exact entries): the truncated-chain Gram, λ_min/a over chain
lengths 3..61: L = 2: 0.1333 (one end truncated), 0.1046 (both ends); L = 3: 0.2030/0.1579; L = 4: 0.2424/0.1906; … L = 8: 0.3064/0.2483.
So for L = 2 the chain λ_min is 0.157 with both ends truncated (not 0.19 as written above). A chain of exactly TWO outward bonds (a
(j+1)-block of Λ_{j+1} with both μ-neighbours outside Ω_{j+1}) has [[a′,b],[b,a′]], singular at L = 2 (the two free parts are the same
j-bond): EXCLUDED by the geometry — Ω_{j+1} is a union of big blocks of side M (j+1)-blocks, so every (j+1)-chain has ≥ M elements. The
lemma uses M ≥ 3.

## 3. (3.132) ASSEMBLED — PROVED GIVEN Theorem L′ and Theorem 3.3/3.12 (G's kernel decay)
(I1) Theorem L′: Re⟨g,T̂g⟩ ≥ C₁′^{−1}‖g‖² (T̂ = ℓ^{−1}QGQ*ℓ^{−1} on ℓ²(𝔅)). (I2) For w = κ₁d(·,y₀), κ₁ ≤ κ_T: ‖e^{w}T̂e^{−w}‖ ≤ C_T — from (3.42)
for G (Theorem 3.3/3.12): |T̂(y,y′)| ≤ Cℓ(y)ℓ(y′)^{−1−d}e^{−δ₀d(y,y′)} (Q local, bounded coefficients), Schur's test with Lemma 2.1 (2.61) and
the scale conversion, C_T := C c₁(½)L², κ_T := δ₀/4.
(a) INTERPOLATION. F(z) := e^{zw}T̂e^{−zw} is analytic and bounded by C_T on |Re z| ≤ 1 (e^{iθw} is unitary); Cauchy on discs of radius ½
gives ‖F′(z)‖ ≤ 2C_T for |Re z| ≤ ½, so ‖F(s) − T̂‖ ≤ 2C_Ts (0 ≤ s ≤ ½). No pointwise kernel bound of G is converted: only block operators.
(b) COMBES–THOMAS. s* := min{½, (4C_TC₁′)^{−1}}: Re⟨g,F(s*)g⟩ ≥ (2C₁′)^{−1}‖g‖², so F(s*) is invertible (Lax–Milgram), F(s*)^{−1} =
e^{s*w}T̂^{−1}e^{−s*w}, ‖F(s*)^{−1}‖ ≤ 2C₁′.
(c) BLOCK INDICATORS (lossless: block fields have no sub-ℓ structure). With y₀ = y′, κ := s*κ₁, ‖1_y‖_𝔅 = ℓ(y)^{d/2}:
|⟨1_y,T̂^{−1}1_{y′}⟩_𝔅| ≤ 2C₁′ℓ(y)^{d/2}ℓ(y′)^{d/2}e^{−κd(y,y′)}; for the kernel w.r.t. block measure |T̂^{−1}(y,y′)| ≤ 2C₁′ℓ(y)^{−d/2}ℓ(y′)^{−d/2}e^{−κd};
T^{−1} = ℓ^{−1}T̂^{−1}ℓ^{−1} and ℓ(y)^{−1−d/2}ℓ(y′)^{−1−d/2} ≤ L^{d/2−1}ℓ(y)^{−2}ℓ(y′)^{−d}e^{(d/2−1)(lnL)d(y,y′)/RM} ((2.60)):
  |(QGQ*)^{−1}(y,y′)| ≤ 2C₁′L^{d/2−1}(L^jη)^{−2}(L^{j′}η)^{−d}e^{−δ₁d(y,y′)},  δ₁ := s*κ₁ − (d−2)lnL/(2RM) > 0 for RM > (d−2)lnL/(s*κ₁).  (3.132)
Bałaban's (3.132) with a named constant and a named rate. ∎
G₁ (THE ORDER, R8): (3.132) for G ⟹ (3.133) for H (p. 422) ⟹ |(H*J)(b)| ≤ O(1)Mα₀ℓ^{−3} ⟹ (3.137) ⟹ L7 for G₁ with an extra
O(C₃Mα₀)‖ℓ^{−1}A‖² (the terms DRG′D*Δ^{(2)} etc. of (3.135) bounded by the G′ weighted bounds of L7) ⟹ Theorem L′ for G₁ ⟹ (3.132) for
G₁ with (I2) from Theorem 3.12. The reverse order is circular.

## 4. THE COMPLEXIFIED DOMAIN — PROVED GIVEN Theorem 3.4 (CMP 99 Sect. B, proved in print given Theorems 3.1–3.3)
For U′U in (3.37): T̂(U′U) − T̂(U) = ℓ^{−1}[F₂GQ* + QGF₂* + F₂GF₂* + Q(U′U)(G(U′U) − G(U))Q(U′U)*]ℓ^{−1}, F₂ = F_{2,j} of (3.80)–(3.81)
(coefficient-wise O(α₁)), G(U′U) − G(U) = G(U)V(A)G(U′U) ((3.84)–(3.86); V(A)G(U) small with decay (3.85)): each term is O(α₁) in the
e^{w}-conjugated weighted norm, ‖F^{U′U}(s) − F^{U}(s)‖ ≤ C_Bα₁. So Re⟨g,T̂(U′U)g⟩ ≥ (C₁′^{−1} − C_Bα₁)‖g‖² ≥ (2C₁′)^{−1}‖g‖² for
α₁ ≤ (2C_BC₁′)^{−1}, and §3 (a)–(c) run verbatim (Lax–Milgram and Cauchy use no self-adjointness): (3.132) holds on the complexified
domain, uniformly in k, with 2C₁′ → 4C₁′. The variational formula is used ONLY at real U, inside Theorem L′.

## 5. THE RANDOM-WALK EXPANSION OF (QGQ*)^{−1} BY COMPRESSIONS (NO DOMAIN-CHANGE ESTIMATE) — PROVED GIVEN §3 and G's walks
Partition of unity {h_□} on block bonds, Σh_□² = 1, supp h_□ ⊂ □ (cubes of side ~M in the scaled distance), |h_□(c) − h_□(c′)| ≤
C_hd(c,c′)/M; □̃ ⊃ □ with margin M; P_□ := restriction to the block bonds of □̃. G^{loc}_□ := the sum of the terms of G's expansion
(Theorem 3.10/3.12) localized in □̃⁺ (margin M around □̃); T_□ := P_□QG^{loc}_□Q*P_□ on ℓ²(□̃).
 (i) T_□ depends on U only in (□̃⁺)⁵ (the localization of Theorem 3.10).
 (ii) ‖ℓ^{−1}(P_□TP_□ − T_□)ℓ^{−1}‖ ≤ Ce^{−δ₀M/2} (the omitted walks reach distance ≥ M; (3.108)).
 (iii) Compression keeps the lower bound: Re T̂_□ ≥ C₁′^{−1} − Ce^{−δ₀M/2} ≥ (2C₁′)^{−1} on ℓ²(□̃); §3 on □̃ bounds T_□^{−1} as in (3.132).
 (iv) IDENTITY: for v ∈ ℓ²(□̃), h_□Tv = h_□P_□TP_□v (supp h_□ ⊂ □̃); with C₀ := Σ_□h_□T_□^{−1}h_□:
      TC₀ = I − R,   R := −Σ_□[T,h_□]T_□^{−1}h_□ − Σ_□h_□(P_□TP_□ − T_□)T_□^{−1}h_□.
 (v) SMALLNESS: [T̂,h_□](c,c′) = T̂(c,c′)(h_□(c′) − h_□(c)), so ‖[T̂,h_□]‖ ≤ C_TC_hM^{−1}Σ_{c′}d(c,c′)e^{−δ₀d/2} = O(M^{−1}); bounded overlap of
      the □̃ gives ‖ℓRℓ^{−1}‖ ≤ C′_R(M^{−1} + e^{−δ₀M/2}) ≤ ½ for M ≥ M_R, and the same in e^{w}-conjugated norms.
 (vi) T^{−1} = C₀Σ_{n≥0}R^n; inserting G's walks into each [T,h_□] = [QGQ*,h_□] gives products of localized factors (h_□T_□^{−1}h_□,
      [QG_ωQ*,h_□]T_□^{−1}h_□) with consecutive localizations intersecting, O(M^{−1}) per R-factor, decay e^{−κd(ω,y,y′)}: the walk expansion of
      (3.98)–(3.99) type for (QGQ*)^{−1} and (QG₁Q*)^{−1} — the one CMP 116 (1.6)–(1.7) decouples — with O(M^{−1}) per step.
WHY NO CMP 89: Bałaban's pattern (3.95)–(3.97) uses inverses built for localized domain sequences {Ω_n(□)}, whose comparison with the
global operator is a domain-change estimate ((3.97), quoted from CMP 89). A compression P_□TP_□ needs no second domain: its difference
from T acts only through the commutator and the walk truncation (ii).

## 6. THEOREM 3.10 FOR G (THE SKETCH COMPLETED) — PROVED GIVEN Corollary 3.6, Theorems 3.7, 3.9, (3.49), (3.100)–(3.104)
Bałaban's construction (3.87), (3.105)–(3.106): G₀ := Σh_□G_□h_□ (G_□ for {Ω_n(□)}, bounded by Corollary 3.6 = CMP 96 at U = 1 plus Sect. B),
Δ_aG₀ = I − R; the four kinds of terms of R and their smallness in the weighted sup norm (Lemma 2.1 and M3e's chain lemma C):
 (R1) K(h_□)G_□h_□: (3.100)–(3.104), ∂h = O(1)/(ML^jη) ⟹ O(M^{−1}) ((3.89));
 (R2) (1 − ζ_□)DPD*h_□G_□h_□: supp(1 − ζ_□), supp h_□ are ≥ M apart and DPD* decays by (3.49) ⟹ O(e^{−δ₀M/2});
 (R3) ζ_□(DPD* − DP_□D*)h_□G_□h_□: the domain change for P — Corollary D below ⟹ O(e^{−δ₀M/4});
 (R4) ζ_□P₁(∂h)G_□h_□: (3.101) ⟹ O(M^{−1}).
So ‖R‖ = O(M^{−1}) in the norms of (3.42)–(3.47) (the Laplacian norm excepted for the Sect. D G, M3e's A4), G = G₀Σ_nR^n converges, and
substituting the walks of P (from G′, (Q′G′²Q′*)^{−1}) gives (3.107)–(3.108); Theorem 3.11 then follows as Bałaban writes (p. 416).
COROLLARY D (DOMAIN CHANGE FROM TWO WALK EXPANSIONS — REPLACES CMP 89). Let {Ω_j}, {Ω′_j} agree on a region O, and K, K′ be operators of
one type (G′, (Q′G′²Q′*)^{−1}, P, G) with walk expansions whose terms depend only on the local data of their localization domains
(Theorems 3.7, 3.9, 3.10). The terms with all localizations in O coincide and cancel in K − K′; every remaining term has a localization
meeting O^c, so by (3.94)/(3.99)/(3.108) and Lemma 2.1, |(K − K′)(x,x′)| ≤ (the bound for K)·e^{−δ₀(d(y,O^c) + d(y′,O^c))/2} — Theorem 3.14's
factor (3.154) with the rate halved. In the order G′ → (Q′G′²Q′*)^{−1} → P (Theorems 3.7, 3.9, in print by CMP 95 Prop. 1.2 and CMP 96
Props. 2.2–2.3, on disk) it gives (3.97) and (R3) with no circularity, then G and Theorem 3.14 itself.

## 7. THE TREE-SHAPED WALKS (G₁, H₁) — PROVED GIVEN the walks of G (§6) and of (QGQ*)^{−1} (§5)
G₁ = Σ_nG₀((Δ′_π + Δ^{(2)}_π)G₀)^n (3.138); a Δ^{(2)} vertex is the local bilinear form (3.136) with coefficient field H*J, H = GQ*(QGQ*)^{−1}.
(F1) BRANCHES ARE LINEAR: H is built from G and (QGQ*)^{−1}, NOT from G₁, and their walks are linear chains (§5, §6); a branch never
     branches: the trees are caterpillars, a main line with linear side lines — Bałaban's p. 427 description, now a consequence.
(F2) THE BRANCH SUM IS THE VERTEX FACTOR: Σ over a branch's walks (O(M^{−1})^{|ω_b|}e^{−κd(ω_b)}, Lemma 2.1 per step) is ≤ O(1)Mα₀ℓ^{−3}, the
     bound on |(H*J)(b)|, i.e. exactly the factor of (3.137); the tree sum is the linear sum with vertex weights O(C₃Mα₀) — convergent for Mα₀ small.
(F3) LOCALIZATION AND DECAY: a tree term depends on U in the union of its main-line and branch domains (collars ⁵); the product of edge
     decays is ≤ e^{−κ·(sum of edge lengths)} ≤ e^{−κd_tree(ω,y,y′)}, d_tree := length of a shortest tree meeting y, y′ and every X_i (main path plus
     branch paths is such a tree). The same for H₁ = G₁Q*(QG₁Q*)^{−1}.

## 8. CMP 98 PROP. 5 AND CMP 89
CMP 98 Prop. 5 (functional derivatives of Q_k, C_k bounded uniformly in k, (156)–(157)): NEEDED — behind CMP 102 (72), behind (3.81) used in
L3 (i), and behind Lemma R at regular U. IN PRINT, ON DISK (CMP 98 pp. 39–42): read today on the TEXT LAYER — the induction (143)
|Q_j(U₀)A| ≤ Q_j|A| + 2C′₁α₀(·)Q′_j|A| via (139)–(142), closed by (145) under "16C′₁L^{−4}α₀ ≤ 1", then (147) |Q_k(U₀;c,b)| ≤ 1 + 2C₁α₀, and for
C_k the induction (149)–(155) closed with C₃ = 6C′₁: a complete induction with its closing conditions stated. Not re-read on image here;
the formulas the text layer garbles are (143), (149), (153)–(154).
CMP 89: NOT NEEDED. Its only uses in CMP 99 are the domain-change estimate (3.97) inside Theorem 3.10 and Theorem 3.14; Corollary D proves
both from the walk expansions, and §5 constructs the walks of (QGQ*)^{−1} with no domain change at all.

## 9. STATUS, THE NEXT OBJECT, THE UNIFICATION

| item | status | rests on |
|---|---|---|
| L1 (Q at U = 1 is the tent average; composition) | PROVED | CMP 98 (124)–(125), CMP 99 (3.15) |
| L2 (Q(1)E(1) = M ≥ 1/3 within a scale) | PROVED; S1 exact | — |
| L3 (local-gauge comparison, coefficient-wise) | PROVED GIVEN (3.81) | CMP 98 (139)–(147), Prop. 6 |
| L4 (chains carry no holonomy) | PROVED | — |
| L6 (competitor energy, C_∇ = 2^{2d+8}d) | PROVED GIVEN L3 (iii) | — |
| L7 (G^{−1} ≤ local forms; Lemma U2 for Δ′_π from (3.120)) | PROVED GIVEN Theorem 3.1 (G′) | (3.69), (3.35)–(3.36) |
| Reading (B) of (3.16) (block bonds inside one region) | REFUTED: G^{−1} singular, #regions − 1 gauge zero modes (S2, counting proof) | CMP 96 p. 224 convention: "at least one end-point" |
| Lemma R (Riesz bound of Q across all scales and interfaces) | PROVED at U = 1 (truncated-chain Grams, exact; M ≥ 3); at regular U PROVED GIVEN L3 (i), IMS step with constants not written | CMP 96 big-block geometry |
| Lemma S (smoothing) | PROVED UP TO BOOKKEEPING (C_S, C′_S not computed) | — |
| THEOREM L′: QGQ* ≥ C₁′^{−1}ℓ², uniform in k, {Ω_j}, regular U, every compact G ⊂ U(N) | PROVED GIVEN Theorem 3.1, (3.69), (3.80)–(3.81), (3.120), G > 0; the falsifier (uniform near-zero mode) excluded; S2′: λ_min(T̂) = 0.0019 (L = 2), 0.0029 (L = 4), volume-independent | the rows above |
| (3.132) for G, G₁, with named constant 2C₁′L^{d/2−1} and rate δ₁ | PROVED GIVEN Theorem L′ and Theorem 3.3/3.12 (I2); G₁ in Bałaban's order | §3 |
| (3.132) on the complexified domain | PROVED GIVEN Theorem 3.4 | §4 |
| walk expansion of (QGQ*)^{−1}, (QG₁Q*)^{−1} (CMP 116 (1.6)–(1.7)) | PROVED GIVEN §3 and G's walks; O(M^{−1}) per step; no domain change | §5 |
| Theorem 3.10 (G's walks) | PROVED GIVEN Corollary 3.6, Theorems 3.7, 3.9, (3.49), (3.100)–(3.104) and Corollary D | §6 |
| Corollary D (domain change from two walk expansions; Theorem 3.14) | PROVED GIVEN the walk expansions | replaces CMP 89 |
| tree-shaped walks (G₁, H₁) | PROVED GIVEN the walks of G and (QGQ*)^{−1}: caterpillars, branch sum = vertex factor (3.137) | §7 |
| CMP 98 Prop. 5 | NEEDED; IN PRINT on disk; induction structure read on the text layer, not on image | §8 |
| CMP 89 | NOT NEEDED | §5, Corollary D |

M3e's chain after this file: (189), (190) PROVED GIVEN (K-H) = (3.133) ⟸ (3.132) [now PROVED GIVEN Theorem L′ + Theorem 3.3/3.12],
(K-Π) = (3.132) [same], (K-𝔇) = CMP 102 (73) [⟸ (3.133) and CMP 98 Prop. 5]; Theorem 3.10 PROVED GIVEN the in-print U = 1 inputs. The
black box that was "asserted by analogy" is now a theorem whose inputs are all in print and on disk: CMP 96 at U = 1 (Props. 2.2–2.3 and
the kernel bounds of G(1)), CMP 99 Sect. B (perturbation, proved there), CMP 98 Prop. 5.

THE NEXT OBJECT. THE POSITIVITY WITH MASS OF Δ_a AT U = 1 IN THE MULTISCALE GEOMETRY WITH THE CORRECT BOND CONVENTION:
  ⟨A,(d*d + dRd* + Q*aQ)A⟩ ≥ c_P‖ℓ^{−1}A‖²  (equivalently G(1) ≤ c_P^{−1}ℓ²),
the "slice Poincaré". With it, G's decay follows in weighted L² by the same Combes–Thomas step (G^{−1}'s only nonlocal part, DPD*, decays
by (3.49)), (I2) follows, and (3.132), its walks and Theorem 3.10's role in them stand on one Poincaré inequality plus the in-print scalar
layer (G′, (Q′G′²Q′*)^{−1}, both of which the scalar block Poincaré and the same competitor/Combes–Thomas scheme already give). The toy
computes it: S2′ reads λ_min(G^{−1}) = 0.025 (multiscale), 4.9·10^{−3}…0.13 (single scale, decreasing like n^{−2}, i.e. ∝ ℓ^{−2} as the
inequality says). Attack: the Hodge decomposition of A = Dλ + A^⊥ with λ ∈ N(Q′) fixed by RD*A, the full-gradient Poincaré on ker Q
(Lemma R's slabs) and the control of PD*A on the slice by the j-level decomposition of Lemma R. Falsifier: a field with
‖ℓ^{−1}A‖² ≫ ⟨A,Δ_a(1)A⟩ uniformly in k (a pure-gauge mode A = Dλ in the slice with smooth block averages is the candidate to test).

THE UNIFICATION FOUND. (U1) THE INTERFACE CONSTANT IS A STRENGTHENED CAUCHY–SCHWARZ CONSTANT. Bałaban's multiscale averaging is a
MULTILEVEL SPLITTING: Q_{j+1} = Q^{(1)}Q_j, so the (j+1)-functionals live in the span of the j-level ones, and the uniform invertibility of
QGQ* across scales is exactly the CBS condition γ = cos∠(span F_j, span F_{j+1}) < 1 of hierarchical-basis multigrid (Bank–Dupont;
Eijkhout–Vassilevski; Axelsson): Lemma R IS a CBS bound, and S2′ measures γ = 0.926, 0.947 (L = 2), 0.893 (L = 4). The point where
Bałaban wrote "by analogy" is the point where multigrid theory has its one non-trivial constant. (U2) T^{−1} = min_{QA=B}⟨A,G^{−1}A⟩ is the
Schur complement / energy-minimizing coarse space of domain decomposition (BDDC/FETI-DP): Theorem L′ is that field's "stable extension"
lemma, and the refuted minimal-norm preimage is the known failure of the L²-projection extension in H¹. (U3) Combes–Thomas on BLOCK
operators is lossless for the same reason coarse-grid operators inherit decay in multigrid: block fields carry no sub-scale structure.

## 10. PRECISIONS, DATED (2026-11-02, after §§0–9; nothing above edited)
10.1 NORMALIZATION IN LEMMA R (ii)/(iv). As FUNCTIONALS, (Q_{j+1}A)(c′) = Σ_e L^{−d}φ^{(1)}(e)(Q_jA)(e) (φ^{(1)} the one-step tent, O(1)). In the
Q*-REPRESENTATION used in (iv), Q*_{j+1} = Q_j*Q^{(1)*} with the adjoint taken for the block measures ℓ_{j+1}^d and ℓ_j^d = L^{−d}ℓ_{j+1}^d, so
Q*_{j+1}h = Σ_e g*_e Σ_{c′}φ^{(1)}(e)h(c′), g*_e := Q_j*e_e: the coefficients are φ^{(1)}(e) WITHOUT the L^{−d}. Norm check: ‖Q*_{j+1}e_{c′}‖² is of order
ℓ_{j+1}^d (≈ (2/3)ℓ_{j+1}^d exactly, by L2's diagonal), consistent only without the L^{−d}. So ‖A‖ in (iv) is O(1) (the one-step tent Gram), and
c_R, C₁′ carry no stray L^{±d}. The truncated-chain Gram and κ_A are ratios and are unchanged.
10.2 ONE CONVENTION FOR FIELDS AND BLOCK BONDS. The field space (bonds of Ω₀, Dirichlet on the rest) and 𝔅 must use the same
convention at ∂Ω₀: a block bond whose slab leaves Ω₀ (at scale 0, a fine bond from Ω₀ to Ω₀^c) has Q ≡ 0 on the field space and must
be excluded from 𝔅 — otherwise Q is not onto and QGQ* has a kernel for a bookkeeping reason. The toy `toy2d_v2.py` uses internal bonds
and excludes those block bonds, consistently; Lemma R and Theorem L′ are stated for that convention.
10.3 COROLLARY D needs both walk expansions built with the SAME partition {h_□} and the same localized propagators on O (Bałaban's remark
that the expansions may be constructed for an arbitrary partition, p. 411); then the walks confined to O are literally the same terms.
10.4 ON THE ADVICE RECEIVED. The minimal-norm preimage Q*(QQ*)^{−1}B, suggested to me as the competitor, fails (§2.0, transverse indicator
profile, energy ratio L^j); what survived of that suggestion is the Riesz bound for QQ*, which became the load-bearing Lemma R once the
correct bond convention surfaced.
