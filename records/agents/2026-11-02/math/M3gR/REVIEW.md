# M3gR — SECOND READING OF M3g (CMP 99 (3.132): the decay and random-walk expansion of (QGQ*)⁻¹)

Second reader M3gR, 2026-11-02. Work directory `.../scratchpad/math/M3gR/` (bin/, rec/, render/). Appended as the work
proceeds; nothing above a line is edited after it is written except by a dated correction below it. Read-only elsewhere.

Read today, whole: `math/MATH_BRIEF.md`; `math/M3g/WORK.md` §§0–10, `M3g/bin/*`, `M3g/rec/*`, `M3g/handback.txt`;
`math/M3e/WORK.md` §§0–8. Bałaban on IMAGE today: CMP 99 pp. 392, 393, 396, 397, 404, 410–416, 418–422 (M3e's renders,
150 dpi); CMP 96 pp. 224–227 (rendered here, `render/cmp96_224..230.png`, 130 dpi, from
`C:\Users\Edwin Boston\Downloads\1103941783.pdf`).

## 0. READINGS ON IMAGE THAT BEAR ON THE VERDICTS (today)

P1 (CMP 96 p. 224, (2.2)–(2.4), image). "If Ω ⊂ T_η, then we denote by Ω also the set of bonds ∪_{x∈Ω} st(x) = {bonds b ⊂ T_η: at
least one end-point of b belongs to Ω}. Let us define Λ_j = Ω_j^{(j)}∖Ω_{j+1}^{(j)}, j = 1,…,k−1, Λ_k = Ω_k^{(k)}, Λ₀ = Ω₁^c (2.3)
FOR THE SETS OF SITES AND THE SETS OF BONDS". So for bonds the DIFFERENCE is taken between BOND SETS: Λ_j (bonds) = {j-bonds
touching Ω_j^{(j)}} ∖ {j-bonds touching Ω_{j+1}^{(j)}}, and Λ₀ (bonds) = Ω₁^c (bonds) = bonds with NO end-point in Ω₁.
P2 (CMP 96 p. 224, (2.6)–(2.7)). A = B₀ on Λ₀, Q_jA = B_j on Λ_j; "The functional and the conditions are invariant with respect to
gauge transformations λ: A → A − ∂λ such that λ = 0 on Λ₀, Q′_jλ = 0 on Λ_j."
P3 (CMP 96 p. 227, (2.30), image). "Because Q′λ′ = 0, hence QA^{λ′} = QA − ∂₁Q′λ′ = QA". CMP 99 p. 420 (image): "(3.115) and the
condition Q′λ = 0 … imply that QA is gauge invariant with respect to gauge transformations satisfying this condition", used in the
Faddeev–Popov step (3.121) and in the proof of RD*GQ* = 0 (3.124) ⟹ HB = GQ*(QGQ*)⁻¹B (3.126).
P4 (CMP 99 p. 418, (3.115)). Q_jDλ = D̄^jQ′_jλ: on a j-bond c, (Q_jDλ)(c) = (L^jη)⁻¹[R_c(Q′_jλ)(c₊) − (Q′_jλ)(c₋)].
P5 (CMP 99 p. 396, image). The regularity cubes: "for each cube □ of this class there exists a unique index j … such that
□ ⊂ B^j(Λ_j) ∪ B^{j+1}(Λ_{j+1}), □ ∩ B^j(Λ_j) ≠ ∅, … its size in the lattice T_η is O(1)ML^jη. Here O(1) will mean a number ≥ 10."
(3.35): in the gauge of □, |A| < O(1)Mα₀(L^jη)⁻¹, |∇^ηA| < O(1)Mα₀(L^jη)⁻², j the index of □ (the FINER of the two scales).
P6 (CMP 99 p. 397, (3.42), image). Theorem 3.1 bounds G′, ∇_UG′, G′∇*_U, Δ_UG′ — so the column sums of DG′ ARE available (G′∇* in the
class), and the Schur steps of M3g's L7 have both sides.
P7 (CMP 99 p. 416, image). Theorem 3.11 (G positive definite) is proved from G = G₀(I − R)⁻¹ with ‖R‖ small, and positivity of the
localized G_□(1) "proved in [4]" — i.e. from CMP 96's U = 1 operator in the multiscale geometry.
P8 (CMP 99 pp. 411–412, image). (3.95)–(3.96) is the expansion of (Q′G′²Q′*)⁻¹ (Theorem 3.9); (3.97) — the domain-change estimate
quoted from [2] = CMP 89 — sits INSIDE the proof of Theorem 3.9 (difference G′²_{□₀} − G′²_□), and again in Theorem 3.10 (p. 415,
"G′_{□₀} − G′_□ and C_{□₀} − C_□ are small by the same reason").

## 1. STAKES (written before any run; results go in §2, nothing here edited)

The convention question (§0 P1–P4) is decisive for item 4 and conditions items 1–3: three readings of the block bonds of (3.16).
 (A) M3g's: j-bonds with at least one end-point in Λ_j (includes INWARD bonds Λ_j → Ω_{j+1} and OUTWARD bonds Λ_j → Ω_j^c);
 (B) both end-points in Λ_j;
 (C) (2.3)'s bond-set difference: j-bonds touching Ω_j^{(j)} and not touching Ω_{j+1}^{(j)} (OUTWARD bonds in, INWARD bonds out);
 at scale 0, Λ₀'s bonds = bonds with no end-point in Ω₁.
Derivation (written before the run). For ν ∈ N(Q′) and an INWARD j-bond c = (y, y′), y ∈ Λ_j, y′ ∈ Ω_{j+1}^{(j)}: (Q′_jν)(y) = 0 but
(Q′_jν)(y′) is constrained only through Q′_{j+1}ν(z) = L^{−d}Σ_{y′∈B(z)}(Q′_jν)(y′) = 0, so (Q_jDν)(c) = (L^jη)⁻¹(Q′_jν)(y′) ≠ 0 in
general: under (A) QA is NOT gauge invariant under N(Q′), contradicting P2–P3. For an OUTWARD j-bond (y, y″), B^j(y″) consists of
(j−1)-points of Λ_{j−1}, so (Q′_jν)(y″) = L^{−d}Σ(Q′_{j−1}ν) = 0: (C) is gauge invariant. And, for G⁻¹ > 0 and invertible,
RD*GQ* = 0 ⟺ ⟨QDν, (I − aQGQ*)f⟩ = 0 ∀ν ∈ N(Q′), f (from G⁻¹Dν = DΔν + Q*aQDν at U = 1).
 S-R1 (consistent Dirichlet toy, d = 2, U = 1, abelian; L = 2 two and three scales, L = 4 two scales):
   (A): gauge defect γ := max_{ν∈N(Q′)}‖QDν‖/‖ν‖ > 1e−3 and ‖RD*GQ*‖ > 1e−3;  (C): γ ≤ 1e−10 and ‖RD*GQ*‖ ≤ 1e−10;
   (B): G⁻¹ singular (min eig ≤ 1e−10). G⁻¹ > 0 under (A) and (C).
 S-R2: λ_min(T̂) under (C) positive and volume-independent (two ring thicknesses agree to 5%); direction against (A) UNGUESSED
   in size, stake (C) ≥ (A) (the crossing j-bond — the tent's peak — is a FREE coefficient of the outward (j+1)-functional under (C)).
 S-R3: the Riesz constant of Q under (C) ≥ under (A).
 S-R4 (adversarial geometry): Ω₁ a single minimal big block (L = 2, 3×3 blocks of side 2), an L-shaped Ω₁, and a 4-scale nest:
   λ_min(T̂) > 0, within a factor 3 of the square-ring value at the same L, no decay with the number of scales.
 S-R5: λ_max(T̂) = 1 to 1e−9 under every reading with G⁻¹ > 0 (the slice pure-gauge block fields QDλ, RΔλ = 0, are
   eigenvectors of aT with eigenvalue 1, derived before the run: G⁻¹Dλ = Q*aQDλ).
 S-R6 (slice pure-gauge mode with smooth block averages): its Rayleigh quotient in G⁻¹ against ‖ℓ⁻¹A‖² is ≥ a/2 (no near-zero
   mode of G⁻¹ from pure gauge), under (A) and (C).
Kill-switch: under (C) a nonzero gauge defect would mean my reading of (2.3) is wrong.

## 2. RESULTS OF THE STAKES (COMPUTED; script `bin/conv_toy.py`, records `rec/conv_toy.*.2026-11-02a.txt`; double precision, a CHECK)

The toy (written here, not M3g's): scalars on sites of Ω₀ = [0,N)², zero outside; fields on EVERY bond touching Ω₀; D⁰ on all those
bonds, D¹ on every plaquette meeting one, D¹D⁰ = 0 asserted exactly, Lap = D⁰ᵀD⁰ (Dirichlet); R the orthogonal projection onto
Lap·N(Q′), checked against Bałaban's formula (2.17) to ≤ 5e−12 in every run; G⁻¹ = D¹ᵀD¹ + D⁰RD⁰ᵀ + aQᵀQ (U = 1, d = 2, a = 1).
(M3g's toy2d_v2.py is NOT consistent in this sense: its R is built from the Dirichlet Laplacian `Lap` (diagonal 4) while its D⁰
lives on internal bonds only, so D⁰ᵀD⁰ ≠ Lap and RD*(A − Dλ) ≠ RD*A − Δλ; its fields drop the boundary bonds but its D¹ keeps the
boundary plaquettes, so D¹D⁰ ≠ 0 at ∂Ω₀.)

L = 2, two scales (1|2), N = 24 (Ω₁ = 4×4 blocks) and N = 32 (Ω₁ = 8×8 blocks):
| reading | G⁻¹ min eig | gauge defect max_ν‖QDν‖/‖ν‖ (‖QD⁰‖) | ‖RD*GQ*‖_max | λ_min(T̂) | λ_max(T̂) | Riesz c_R | λ_min(T̂) vector on coarse side |
| (A) N=24 | 0.137 | 1.307 (2.811) | 0.107 | 0.004781 | 1.000000000 | 0.0605 | 85% |
| (A) N=32 | 0.126 | 1.307 (2.810) | 0.107 | 0.004820 | 1.000000000 | 0.0610 | 85% |
| (B) N=24 | −6.9e−14 | 1.7e−16 | — | — | — | — | — |
| (C) N=24 | 0.125 | 1.7e−16 (2.808) | 8.0e−12 | 0.034536 | 1.000000000 | 0.4464 | 97% |
| (C) N=32 | 0.124 | 2.5e−16 (2.807) | 5.3e−11 | 0.031954 | 1.000000000 | 0.4524 | 99% |
S-R1 HELD in every clause: (A) breaks gauge invariance at O(1) and breaks Bałaban's identity RD*GQ* = 0 (3.124); (B) is gauge
invariant and SINGULAR (M3g's refutation of (B) reproduced on a consistent toy); (C) is gauge invariant to 2e−16, satisfies (3.124)
to 5e−11, and G⁻¹ > 0. KILL-SWITCH NOT TRIPPED. S-R2 HELD with margin: λ_min(T̂) under (C) is 6.6–7.2× (A)'s, volume-stable (8%);
S-R3 HELD: c_R(C) = 0.45 vs c_R(A) = 0.061. S-R5 HELD (λ_max(T̂) = 1 to 1e−9 under (A) and (C)).
S-R6 SPLIT: the SMOOTH slice pure-gauge mode reads 0.97–1.02·a (held), but the MINIMUM over all slice pure-gauge modes reads
0.168–0.169·a under (C) (stake ≥ a/2 REFUTED for (C); 0.50–0.55·a under (A)), volume-stable, and it is (to 1%) the softest
direction of G⁻¹ against ℓ⁻²: λ_min(ℓG⁻¹ℓ) = 0.167–0.168 (C). Not a near-zero mode; the softest one, and it is pure gauge.

## 3. THE CONVENTION — WHAT IS PROVED HERE (PROVED, on P1–P4)

PROPOSITION C. (i) Under (A) there are ν ∈ N(Q′) with QDν ≠ 0 whenever some INWARD j-bond (y, y′), y ∈ Λ_j, y′ ∈ Ω_{j+1}^{(j)},
exists (always, for Ω_{j+1} ≠ ∅). (ii) Under (C), QDν = 0 for every ν ∈ N(Q′) (at U = 1; at regular U the same by (3.115)).
(iii) At U = 1 with G⁻¹ > 0: RD*GQ* = 0 ⟺ ⟨QDν, (I − aQGQ*)f⟩_𝔅 = 0 for all ν ∈ N(Q′), f. Hence (C) satisfies (3.124), and (A)
violates it unless every QDν lies in ker(I − aQGQ*) (it does not: ‖RD*GQ*‖ = 0.107, §2).
(iv) Under (C), G⁻¹(1) = D*D + DRD* + Q*aQ is positive definite for every admissible {Ω_j}.
PROOF. (i) Pick z ∈ Λ_{j+1} with B(z) ∋ y′ (the (j+1)-block of y′) and a second j-point y‴ ∈ B(z); let ν be supported in
B^j(y′) ∪ B^j(y‴) with averages +1 on B^j(y′), −1 on B^j(y‴), and zero average on every other block of every scale: then Q′_jν = 0 on
Λ_j (the supports lie in Ω_{j+1}), Q′_{j+1}ν(z) = L^{−d}(1 − 1) = 0, all coarser averages vanish, so ν ∈ N(Q′); and by (3.115)
(Q_jDν)(y, y′) = (L^jη)⁻¹[(Q′_jν)(y′) − (Q′_jν)(y)] = (L^jη)⁻¹ ≠ 0. (ii) A (C)-bond at scale j has end-points in Λ_j (where
Q′_jν = 0 by definition) or OUTWARD, at a j-point y″ ∉ Ω_j^{(j)}; Ω_j is a union of j-blocks, so B^j(y″) ∩ Ω_j = ∅, and
dist(Ω_{j−1}^c, Ω_j) > RM gives B^j(y″) ⊂ Ω_{j−1}: the L^d (j−1)-points of B^j(y″) lie in Λ_{j−1}, so (Q′_jν)(y″) =
L^{−d}Σ(Q′_{j−1}ν) = 0 (for j − 1 = 0: Q′₀ν = ν = 0 on Λ₀). (iii) For ν ∈ N(Q′), RΔν = Δν (R projects onto ΔN(Q′)), so
G⁻¹Dν = D*DDν + DRΔν + Q*aQDν = DΔν + Q*aQDν, i.e. GDΔν = Dν − GQ*aQDν; then for every f,
⟨Δν, D*GQ*f⟩ = ⟨GDΔν, Q*f⟩ = ⟨QDν, f⟩ − a⟨QDν, QGQ*f⟩, and R projects onto ΔN(Q′). (iv) If ⟨A,G⁻¹A⟩ = 0 then DA = 0,
RD*A = 0, QA = 0; A = 0 off the bonds of Ω₀ and DA = 0 give A = Dλ, λ = 0 off Ω₀. QA = 0 on Λ₀'s (C)-bonds (all bonds touching Ω₀
and not Ω₁, the boundary bonds included) gives λ = 0 on Λ₀. Inductively, Q′_jλ is constant on each connected component of Λ_j
(bonds with both ends in Λ_j), and every component is joined by an OUTWARD bond of scale j or j+1 to a region where the averages
already vanish (a component of Λ_j enclosed by a hole of Ω_{j+1} is joined through the outward (j+1)-bonds of Ω_{j+1} that point into
the hole: (Q′_{j+1}λ)(z′) = L^{−d}Σ_{B(z′)}Q′_jλ = that constant). So Q′λ = 0, λ ∈ N(Q′), RΔλ = Δλ = 0, λ = 0. ∎
CONSEQUENCE. (C) is CMP 96 (2.3) read verbatim ("for the sets of sites and the sets of bonds": the difference of BOND sets), it is the
only one of (A), (B), (C) consistent with P2, P3 and Theorem 3.11, and it also makes (2.6)–(2.7) of CMP 96 consistent at scale 0
(Λ₀'s bonds have both ends off Ω₁, so λ = 0 on Λ₀ leaves A on them unchanged — under the "at least one end" reading the fine bonds
crossing into Ω₁ would move by λ(inside) ≠ 0). M3g's reading (A) — "the j-lattice bonds with AT LEAST ONE endpoint in Λ_j" — applies
the st-convention to the set Λ_j instead of to Ω_j and Ω_{j+1}; it includes exactly the inward bonds that (2.3) removes. For (A),
Theorem L′ is a statement about an operator QGQ* that is NOT the one in H = GQ*(QGQ*)⁻¹ ((3.126) fails with (3.124)).

## 4. LEMMA R UNDER (C) (PROVED at U = 1; the regular-U IMS step written out) — REPAIRS M3g §2.11

Fix the interface of Ω_{j+1} inside Ω_j. Under (C): scale-j block bonds there have both ends in Λ_j (the inward j-bonds are gone);
scale-(j+1) block bonds are INTERIOR or OUTWARD ((z, z′), z ∈ Λ_{j+1}, z′ ∉ Ω_{j+1}). In M3g's j-level coordinates (Q_{j+1} = Q^{(1)}Q_j,
L1), an outward (j+1)-functional along μ has the one-step tent weights w(s)/L, s = 0..2L−2, on the j-bonds of its slab: on the outer
block's j-bonds (s on the z′ side, weights 1/L..(L−1)/L) CONSTRAINED (they are (C)-bonds of Λ_j), on the CROSSING j-bond (weight 1 —
the tent's peak) FREE (an inward j-bond, not a block bond under (C)), on the inner block's j-bonds (weights (L−1)/L..1/L) FREE. The
free-part Gram along a (j+1)-chain: interior diagonal a = (2L²+1)/(3L), off-diagonal b = (L²−1)/(6L), truncated diagonal
a′_C = 1 + (L−1)(2L−1)/(6L), truncated off-diagonal b (the crossing j-bond lies in no other slab of the chain).
COMPUTED (exact rationals, `bin/chain_kappa_C.py`, `rec/chain_kappa_C.2026-11-02a.txt`): a′_C − b = (L+1)(L+2)/(6L) > 0 and
a − 2b = (L²+2)/(3L) > 0, so the chain Gram is diagonally dominant; min λ_min/a over all chain lengths ≥ 1: L = 2: 0.6667;
L = 3: 0.5263; L = 4: 0.4545; … L = 8: 0.3488 (both ends truncated; chains of 1–2 elements included). Against (A)'s 0.1046 (L = 2)
… 0.2483 (L = 8) (M3g's record). The two-chain singularity at L = 2 that forced "M ≥ 3" under (A) does not exist under (C): the
condition M ≥ 3 is NOT needed. M3g's steps (i), (ii), (iv) are unchanged (the X/Y two-case argument, with κ_C² := 0.6667a at L = 2).
At the (j−1, j) interface the OUTWARD j-bonds play the role the outward (j+1)-bonds play here (one level down); same constants.

THE IMS STEP (M3g wrote one line; written here). K(U) := Q(U)Q(U)* on ℓ²(𝔅). (a) GLOBAL U = 1 BOUND. Take {χ_α} on the block bonds,
Σ_αχ_α² = 1, each χ_α supported in a set P_α meeting at most one interface, |χ_α(c) − χ_α(c′)| ≤ C_χ d(c,c′)/(RM) (the scaled distance
(2.46); interfaces of different scale pairs are ≥ RM apart), overlap ≤ n_χ. The double-commutator identity
  K = Σ_α χ_αKχ_α + ½Σ_α[χ_α,[χ_α,K]],   ([χ,[χ,K]])(c,c′) = (χ(c) − χ(c′))²K(c,c′),
with K of finite range c_K (slabs overlap only if d(c,c′) ≤ c_K) gives ‖K − Σχ_αKχ_α‖ ≤ ½n_χC_χ²c_K²(RM)⁻²‖K‖_Schur. For g supported
in P_α the single-scale bound (Gram = M of L2, ≥ 1/3) or the two-scale bound above applies — a principal submatrix of a chain Gram
has λ_min ≥ the chain's (interlacing), so truncation of the chain by supp χ_α costs nothing. Hence
  c_R(1) ≥ min{⅓, c_2} − ½n_χC_χ²c_K²‖K‖(RM)⁻²,   c_2 := ⅓·min{¼, κ_C²/2, κ_C²/(8‖A‖²)}.
(b) REGULAR U. Gauge covariance K(U^u) = R(u)K(U)R(u)⁻¹, R(u) unitary on ℓ²(𝔅) (CMP 99 (3.32), p. 396). Re-partition at scale M:
{χ′_β}, Σχ′_β² = 1, |χ′_β(c) − χ′_β(c′)| ≤ C_χ d(c,c′)/M, each supp χ′_β together with all slabs of its block bonds inside one
regularity cube □_β (P5: the index-j cubes straddle the interface Λ_j | Λ_{j+1} and have side ≥ 10ML^jη ≥ 4L^{j+1}η + ML^jη for
M ≥ 4L). In the gauge u_β of □_β, U^{u_β} = e^{iηA}, |A| < O(1)Mα₀(L^jη)⁻¹ — i.e. α₁ = O(1)LMα₀ at scale j+1 — so (3.80)–(3.81) at base
U = 1 give |Q(U^{u_β})(c,b) − Q(1)(c,b)| ≤ C_QLMα₀ coefficient-wise for c ∈ supp χ′_β (Q_j(·)(c,·) depends on U in the slab only,
(3.78)), hence ‖K(U^{u_β}) − K(1)‖ ≤ C′_ELMα₀ on ℓ²(supp χ′_β) (Schur, finite overlap). Then
  ⟨h,K(U)h⟩ ≥ Σ_β⟨R(u_β)⁻¹χ′_βh, K(U^{u_β})R(u_β)⁻¹χ′_βh⟩ − E_IMS M⁻²‖h‖² ≥ (c_R(1) − C′_ELMα₀ − E_IMS M⁻²)‖h‖²,
R(u_β) commuting with the scalar χ′_β. This is M3g's (v) with every step on the page. LEMMA R HOLDS (with the convention repaired).

## 5. THE REST OF THEOREM L′ CHECKED LINE BY LINE (with the convention repaired)

5.1 THE VARIATIONAL IDENTITY (READ, CMP 99 p. 420 (3.122)–(3.123)): min{½⟨A,G⁻¹A⟩ : QA = B} over ALL configurations A, attained at
A = GQ*(QGQ*)⁻¹B, value ½⟨B,(QGQ*)⁻¹B⟩. Valid for G⁻¹ positive definite (Theorem 3.11/3.12; under (C) its U = 1 base is Prop. C(iv))
and Q onto (Lemma R). HOLDS. Inversion is operator monotone on positive operators, so T⁻¹ ≤ C₁′ℓ⁻² ⟺ T̂ ≥ C₁′⁻¹. HOLDS.
5.2 L7 (G⁻¹ ≤ local forms). Δ = D*D + Δ′ with Δ′ the curvature form (3.10) (READ p. 392), |Δ′| ≤ O(1)(Mα₀ + α₁)(L^jη)⁻² (3.69) (READ
p. 404) ✓; ⟨A,DRD*A⟩ = ‖RD*A‖² ≤ ‖D*A‖² ✓; the three J-terms of (3.120) (READ p. 419) with λ = G′RD*A and |J| ≤ c_JMα₀ℓ⁻³ — this needs
(3.36), which M3g lists ✓. The Schur steps for ‖ℓ⁻²G′‖ and ‖ℓ⁻¹DG′‖ need BOTH row and column sums: Theorem 3.1 (3.42) (READ p. 397)
bounds G′, ∇_UG′ AND G′∇*_U, and G′ is symmetric, so both sides are there (P6). HOLDS.
5.3 THE WEIGHTED INVERSE ‖ℓ⁻¹(QSQ*)⁻¹B‖ ≤ 4Lc_R⁻¹‖ℓ⁻¹B‖. ℓ jumps by L at an interface, so ℓ⁻¹(QSQ*)ℓ is NOT a small perturbation of
QSQ*; M3g's device is right: ℓ̃(c) := min_{c′} ℓ(c′)e^{κd(c,c′)}, κ = lnL/(RM), satisfies ℓ/L ≤ ℓ̃ ≤ ℓ (the nearest region of scale
≤ j−1 is ≥ RM away in the scaled distance (2.57)), and QSQ* has finite range r, so ‖ℓ̃⁻¹QSQ*ℓ̃ − QSQ*‖ ≤ ‖QSQ*‖(e^{κr} − 1); with
Re⟨QSQ*h,h⟩ ≥ ½c_R‖h‖² this gives ‖(ℓ̃⁻¹QSQ*ℓ̃)⁻¹‖ ≤ 4/c_R for RM large, and the two factors ℓ⁻¹ℓ̃, ℓ̃⁻¹ℓ cost L. HOLDS.
5.4 LEMMA S — the two constants, in explicit (crude) form (U = 1; regular U adds O(Mα₀) relative). S averages each component over
the cube K_r(x) of half-side r = r(x) ≥ 0 (r = 0: S = I), r varying by ≤ 1 per lattice step. (a) Row sums 1; column sums
≤ #{x : b ∈ K_{r(x)}(x)}·max(2r(x)+1)⁻ᵈ ≤ 4ᵈ (r(x) ∈ [r/2, 2r] on the cube), so ‖S‖ ≤ 2ᵈ (M3g's L^{d/2} is another valid bound).
(b) Two adjacent cubes differ by two faces of relative volume (2r+1)⁻¹ each (plus ≤ 2d/(2r+3) when r changes), so the kernel of
f ↦ ∇_νSf has row and column sums ≤ 2^{d+2}/((2r+1)η) ≤ 2^{d+2}/(εℓ_min): ‖∇^USQ*h‖² ≤ d·4^{d+2}ε⁻²L²q₂‖ℓ⁻¹h‖²_𝔅, q₂ := ‖Q*‖² ≤ 2
(single scale ≤ 1 by L2's Gram ≤ 1; one overlapping family at an interface). So C_S ≤ d·4^{d+2}q₂. (c) At U = 1, Q*h on μ-bonds is
continuous piecewise linear in μ (tents) with slope ≤ 2|h|_loc/ℓ, and piecewise constant transversally with jumps on transverse
block faces (and jumps ≤ |h|/n at slab ends); a cube average reproduces a linear function exactly, so |(I−S)Q*h| ≤ 2ε|h|_loc off a
layer of half-width rη ≤ εℓ_min around the jump surfaces, of relative volume ≤ 4(d−1)εL (the L: on the coarse side of an interface
the fine jump surfaces are L times denser), and ≤ 2|Q*h|_loc on it: C′_S ≤ (16(d−1) + 4ε)q₂. HOLDS — the constants are computable
and k-independent; their size only fixes ε ≤ c_R/(4C′_SL) and C₁′ ∝ ε⁻²c_R⁻².
5.5 G₁. M3g's order (3.132) for G ⟹ (3.133) ⟹ (3.137) ⟹ L7 for G₁ ⟹ L′ for G₁ is right and non-circular. One step M3g did not write:
(3.137) (READ p. 423) is a SUP-type local bound, |(Δ^{(2)}A)(b)| ≤ O(1)Mα₀ℓ⁻²·sup_{nearby blocks}|A|; the L² form bound L7 needs
follows by Schur because Δ^{(2)} is SYMMETRIC (defined by the quadratic form (3.134)), so its column sums equal its row sums. HOLDS.

## 6. MORE RESULTS (COMPUTED, same toy; records `rec/conv_toy.main/adv.2026-11-02a.txt`)

| geometry (L = 2 unless said) | reading | λ_min(T̂) | Riesz c_R | ‖RD*GQ*‖ | gauge defect | slice-pure-gauge min / smooth | λ_min(ℓG⁻¹ℓ) |
| three scales 1|2|4, N = 32 (M3g's) | (A) | 0.001905 | 0.0377 | 0.154 | 1.307 | 0.400 / 1.074 | 0.397 |
| three scales 1|2|4, N = 32 | (C) | 0.019222 | 0.3018 | 1.7e−10 | 8e−17 | 0.153 / 0.893 | 0.152 |
| three scales, N = 40 thicker (M3g's) | (A) | 0.001914 | 0.0377 | 0.154 | 1.307 | 0.399 / 1.064 | 0.397 |
| three scales, N = 40 thicker | (C) | 0.019229 | 0.3039 | 1.3e−10 | 5e−16 | 0.161 / 0.902 | 0.159 |
| minimal big block (Ω₁ = 3×3 blocks), N = 22 | (A) | 0.004529 | 0.0585 | 0.107 | 1.307 | 0.607 / 1.006 | 0.606 |
| minimal big block, N = 22 | (C) | 0.036342 | 0.4413 | 3.8e−12 | 4e−17 | 0.160 / 0.992 | 0.159 |
| L-shaped Ω₁ (three 6×6 big blocks), N = 28 | (A) | 0.004625 | 0.0585 | 0.111 | 1.307 | 0.529 / 1.011 | 0.527 |
| L-shaped Ω₁, N = 28 | (C) | 0.033634 | 0.4413 | 1.2e−11 | 2e−16 | 0.164 / 0.983 | 0.163 |
READINGS. (1) The consistent toy under (A) reproduces M3g's S2′ numbers TO EVERY PRINTED DIGIT (0.001905, 0.001914, G⁻¹ min eig
2.546e−02, Riesz 0.0377): M3g's toy inconsistency noted in §2 (D⁰ᵀD⁰ ≠ Lap at ∂Ω₀) is IMMATERIAL for those readings (the extremal
modes are interior) — dated correction to the implication of §2's parenthesis: M3g's numbers are faithful readings OF OPERATOR (A).
(2) Under (C), the three-scale λ_min(T̂) is 0.0192, i.e. 87% of the single-scale value at the coarsest block size (M3g's single
n = 4: 0.0221), and the two-scale 0.032–0.035 against single n = 2: 0.036. THE INTERFACES COST 5–13%, NOT A FACTOR 10: M3g's
"THE INTERFACES ARE WHERE THE CONSTANT LIVES … λ_min(T̂) drops by ≈ 10 and stays" (§2.10–2.11) is an artifact of reading (A), whose
inward scale-j functionals take the crossing j-bond (the coarse tent's peak) away from the outward coarse functional. (3) Extreme
geometries (a single minimal big block; a concave corner) do not degrade either reading: S-R4 HELD. (4) Volume independence holds
under both readings (N = 32 vs 40: 0.4% under (C)). (5) The softest direction of G⁻¹ against ℓ⁻² under (C) is, to ≤ 1.3%, a
SLICE PURE-GAUGE mode in every geometry (0.15–0.17·a, volume-stable): on that subspace ⟨Dλ,G⁻¹Dλ⟩ = a‖ℓ⁻¹D̄Q′λ‖²_𝔅 (Prop. C(ii)),
so the "slice Poincaré" M3g names as the next object reduces there to a SCALAR inequality ‖ℓ⁻¹Dλ‖² ≤ c⁻¹a‖ℓ⁻¹D̄Q′λ‖² for the
minimal-‖Δλ‖ extension λ of its block averages (λ ⊥ ΔN(Q′) in the Δ-inner product); the toy reads c ≈ 0.15–0.17.
DATED PRECISION to 5.4(c) (written after it): the factor L in "relative volume ≤ 4(d−1)εL" is not needed (on the coarse side of an
interface the smoothing radius is εℓ_j while the coarse jump surfaces are ℓ_{j+1} apart, which only shrinks the layer); the bound
as written is valid, its stated reason is not.

## 7. THE NUMBER OF SCALES (COMPUTED; `rec/conv_toy.adv.2026-11-02a.txt`, `rec/riesz_pairs.2026-11-02a.txt`, `bin/riesz_pairs.py`)

Four scales 1|2|4|8, N = 48 (collars of 2 blocks): (A) λ_min(T̂) = 0.000735, c_R = 0.0211, ‖RD*GQ*‖ = 0.282, defect 1.307;
(C) λ_min(T̂) = 0.016779, c_R = 0.2381, ‖RD*GQ*‖ = 5.3e−10, defect 1.1e−16; λ_max(T̂) = 1.000000000 both.
λ_min(T̂) against the single-scale value at the coarsest block size (M3g's single n = 2, 4, 8: 0.0362, 0.0221, 0.0190):
  (A): 2 scales 0.0048 (×0.13), 3 scales 0.0019 (×0.086), 4 scales 0.00074 (×0.039) — FALLS with every added scale;
  (C): 2 scales 0.032 (×0.88), 3 scales 0.0192 (×0.87), 4 scales 0.0168 (×0.88) — FLAT.
The Riesz constant under (C) also reads lower with more scales (0.452, 0.302, 0.238), so the question "compounding or block size?"
was put to single interfaces under (C): one interface 1|2: 0.4524, 2|4: 0.3088, 4|8: 0.2627; single scale n = 2, 4, 8: 0.509, 0.386,
0.369. The multiscale c_R is the WORST SINGLE INTERFACE (the one at the largest block size), within 10% (thin collars), and the
per-interface constant converges as the block size grows (steps −0.144, −0.046): no compounding in k under (C) — what Lemma R's IMS
says. Under (A) the compounding visible in λ_min(T̂) is a property of operator (A) in thin-collar toys; I did not chase it further,
since (A) is not Bałaban's operator.

## 8. A BACKGROUND AT AND BEYOND THE EDGE OF REGULARITY (COMPUTED; `bin/riesz_U.py`, `rec/riesz_U.2026-11-02a.txt`)

Model (a CHECK of the size of the curvature effect on Lemma R, not a theorem): the charged adjoint components of SU(2) in a
background exp(iθσ₃/2) of CONSTANT FLUX B per plaquette (Landau gauge) — a charge-1 field — with Q_j(U) the MAIN TERM of CMP 98 (124)
composed (tent average, each bond value transported to c₋ inside the slab); reading (C). Controls: a FLAT background (a random gauge
transform of U = 1) reproduces c_R(1) to every printed digit in all three geometries (gauge covariance (3.32)); B = 0 reproduces
conv_toy's c_R(1).
| geometry | flux per coarsest block: 0 | 0.05 | 0.1 | 0.2 | 0.5 | 1 | 2 | π |
| two scales 1|2 | 0.45241 | 0.45240 | 0.45239 | 0.45232 | 0.45186 | 0.45024 | 0.44389 | 0.43206 |
| three scales 1|2|4 | 0.30178 | 0.30177 | 0.30176 | 0.30169 | 0.30126 | 0.29974 | 0.29385 | 0.28326 |
| two scales 2|8 (L = 4) | 0.22047 | 0.22046 | 0.22044 | 0.22038 | 0.21994 | 0.21840 | 0.21257 | 0.20264 |
The loss is QUADRATIC in the flux (two scales: 0.0022 at Φ = 1, 0.0204 at Φ = π, ratio 9.3 ≈ π²) — no first-order term — and is
8% at flux π per coarsest block, far outside (3.35)'s O(Mα₀) per block. The IMS bound c_R(U) ≥ c_R(1) − C′LMα₀ − EM⁻² of §4 is
conservative (linear where the object is quadratic). S-R7 (added after the fact, labelled so): Lemma R does not degrade at the edge
of regularity.
L = 4 (1|4, N = 40; `rec/conv_toy.L4.2026-11-02a.txt`): (A) λ_min(T̂) = 0.00614, c_R = 0.111, ‖RD*GQ*‖ = 0.527, defect 1.383;
(C) λ_min(T̂) = 0.01836 (×0.83 the single-scale n = 4 value 0.0221), c_R = 0.290, ‖RD*GQ*‖ = 2.2e−10, defect 8e−17; slice-pure-gauge
minimum 0.0577·a = λ_min(ℓG⁻¹ℓ) 0.0564 (C) — the softest direction of G⁻¹ is again pure gauge, and smaller at L = 4 than at L = 2.
M3g's L = 4 geometry 2|8 has NO scale-0 ring; in a Dirichlet toy whose fields include the boundary bonds that geometry carries the
global-constant gauge mode unpinned (no block functional reads a boundary bond) and G⁻¹ reads 4.95e−10 under (A) — a geometry
outside Bałaban's (his outermost region is always Λ₀ at scale 0, which reads every bond touching Ω₀); M3g's internal-bond toy hides
the mode because Dλ = 0 for constant λ on internal bonds. Its 0.0029 is not used in the verdict; 1|4 is the L = 4 reading.
Confirmation (the last run): 2|8 under (C) reads G⁻¹ min eig 1.3e−15 — EXACTLY singular, as the explanation above predicts (under
(C) gauge invariance makes the unpinned global constant an exact zero mode; under (A) the inward-bond defect lifts it to 5e−10).

## 9. M3g's UNIFICATION NUMBER (U1) UNDER THE TWO READINGS (COMPUTED; `bin/cbs.py`, `rec/cbs.2026-11-02a.txt`)
The cosine of the largest principal angle between the spans of adjacent scales' functionals (M3g's definition, same code path):
 (A): 1|2: 0.92621, 2|4: 0.94730, 2|8: 0.89246 — M3g's 0.926, 0.947, 0.893 reproduced exactly;
 (C): 1|2: 0.41421356 (= √2 − 1 to 9 digits), 2|4: 0.50764, 2|8: 0.64679.
The analogy (Bałaban's averaging is a multilevel splitting; Lemma R is a strengthened-Cauchy–Schwarz bound) STANDS as a structural
identification; its measured constant does not: under Bałaban's convention γ ≈ 0.41–0.65, the scales are well separated, and
"γ ≈ 0.93, the interfaces are where the constant lives" is a property of reading (A).

## 10. ITEMS 2 AND 3 CHECKED

10.1 (3.132) ASSEMBLED (M3g §3). (I2): from G ∈ 𝒪(B₀; 2; δ₀) (Theorem 3.3 via Theorem 3.12's value bound — the Laplacian exception
does not bite), (T1_{y′})(y) = ℓ(y′)^dT(y,y′) and Q*1_{y′} a sup-1 field on the slab give |T(y,y′)| ≤ CB₀ℓ(y)²ℓ(y′)^{−d}e^{−δ₀d}, hence
|T̂(y,y′)| ≤ CB₀ℓ(y)ℓ(y′)^{−1−d}e^{−δ₀d}; Schur on ℓ²(𝔅, ℓ^d) with weights e^{±κ₁d} needs both sums, and both close by (2.60)–(2.61)
for κ₁ + lnL/(RM) < δ₀/2. ✓. (a) e^{iθw} unitary, F entire (finite dimension), Cauchy on radius ½ ✓. (b) Lax–Milgram ✓. (c) testing
on 1_y is exact for block operators; ℓ(y)^{−1−d/2}ℓ(y′)^{−1−d/2} = ℓ(y)^{−2}ℓ(y′)^{−d}(ℓ(y)/ℓ(y′))^{1−d/2} and |j − j′| ≤ 1 + d(y,y′)/(RM)
give δ₁ = s*κ₁ − (d/2 − 1)lnL/(RM) ✓. The order of constants is consistent: C₁′ and C_T do not depend on M or R beyond "large", so
δ₁ > 0 for R large and δ₁M ≥ κ₁ (CMP 116's need, M3e §4) for M large. HOLDS given Theorem L′ (repaired) and Theorem 3.3/3.12.
10.2 COMPLEXIFIED (M3g §4). The perturbation T̂(U′U) − T̂(U) = O(α₁) in the conjugated norm from (3.80)–(3.81) and (3.84)–(3.86) ✓.
Precision: "F₂*" must be read as Bałaban's F*_{2,j}, the analytic continuation of U ↦ Q(U)* — he notes on p. 406 (image) that "for
complex configurations A the operator F*_{2,j}(A) is not the adjoint of F_{2,j}(A)"; it obeys (3.81). HOLDS given Theorem 3.4.
10.3 THE WALK EXPANSION BY COMPRESSIONS (M3g §5). The identity: TC₀ = Σ_□(h_□T + [T,h_□])T_□⁻¹h_□ and, since supp h_□ ⊂ □̃ and
T_□⁻¹h_□v ∈ ℓ²(□̃), h_□TT_□⁻¹h_□ = h_□P_□TP_□T_□⁻¹h_□ = h_□² + h_□(P_□TP_□ − T_□)T_□⁻¹h_□; Σh_□² = I gives TC₀ = I − R with M3g's R ✓
(verified line by line). Compression keeps coercivity ✓; [T̂,h_□] = O(M⁻¹) ✓; the sum over □ closes by bounded overlap on the input
side and exponential decay on the output side ✓; a right inverse in finite dimension is the inverse ✓. HOLDS. It is a genuine
replacement of Bałaban's (3.95)–(3.97) pattern for (QGQ*)⁻¹: no second domain sequence enters.
10.4 THEOREM 3.10 (M3g §6). (R1)–(R4) are exactly the four sums of (3.105) (READ p. 414) ✓; (R2)'s separation ≥ M is Bałaban's own
(p. 414) ✓. CMP 89's estimate (3.97) is used INSIDE the proof of Theorem 3.9 (p. 412: G′²_{□₀} − G′²_□) and again inside 3.10 (p. 415:
G′_{□₀} − G′_□, C_{□₀} − C_□). Corollary D's order — Theorem 3.7 (expansion (3.90), no domain change) ⟹ (3.97) ⟹ Theorem 3.9 ⟹ P's walks
⟹ (R3) and the p. 415 differences ⟹ Theorem 3.10 — is non-circular. PRECISION (M3g's 10.3 says half of it): Corollary D needs (i) the two
expansions built on ONE partition 𝒟 on O (𝒟 depends on {Ω_j} only locally, so this is a choice, not a restriction), (ii) every building
block (G′_{□′} on its localized domain sequence {Ω_n(□′)}, K(h), C_□) to depend on {Ω_j} and U only near its cube (true by construction,
CMP 96 Sect. A), and (iii) O replaced by O shrunk by the localization collars (X̃⁵): the bound is (bound for K)·e^{−¼δ₀(d(y,O′^c) + d(y′,O′^c))}
with Σ_ω controlled by the remaining e^{−¼δ₀d(ω)}O(M^{−1/2})^{|ω|}. HOLDS WITH THIS PRECISION, at the rigour of Bałaban's own (3.90)–(3.99).
10.5 TREES (M3g §7). Δ^{(2)} carries H*J with H = GQ*(QGQ*)⁻¹ ((3.126), the G version, not G₁) — (3.136) READ p. 422 ✓; G's and
(QGQ*)⁻¹'s expansions are chains (§5 concatenates chains), so the trees are caterpillars and the branch sum is bounded by (3.137)'s
|H*J| ≤ O(1)Mα₀ℓ⁻³. HOLDS.

## 11. VERDICTS

1. THEOREM L′ (QGQ* ≥ C₁′⁻¹ℓ², uniform in k, {Ω_j}, real regular U, compact G ⊂ U(N)) — HOLDS WITH REPAIR.
   Checked and holding as written: the variational identity (p. 420), the competitor A_B = SQ*(QSQ*)⁻¹B, L7 (both Schur sides are in
   (3.42): G′ and G′∇*_U), the slowly-varying-weight inverse, the G₁ order (with Δ^{(2)}'s symmetry turning (3.137) into an L² bound).
   REPAIR (a), DECISIVE: the block bonds of (3.16) are CMP 96 (2.3) read for BOND sets — reading (C): outward crossing bonds in, inward
   crossing bonds out — not M3g's reading (A). Proposition C (§3, proved): under (A) QDν ≠ 0 for an explicit ν ∈ N(Q′) at every inward
   bond, so the Faddeev–Popov step (3.121), RD*GQ* = 0 (3.124) and H = GQ*(QGQ*)⁻¹ (3.126) fail — (A)'s QGQ* is not the operator inside
   H; under (C) gauge invariance holds, (3.124) holds, and G⁻¹(1) > 0. Toy: defect 1.307 vs 1e−16; ‖RD*GQ*‖ 0.107–0.53 vs ≤ 5e−10.
   REPAIR (b): Lemma R's bookkeeping under (C) — the crossing j-bond, the coarse tent's peak, is a FREE coefficient of the outward
   (j+1)-functional; the truncated-chain Gram is diagonally dominant, λ_min/a = 2/3 (L = 2) … 0.349 (L = 8) exact, and M ≥ 3 is not
   needed (against (A)'s 0.105 … 0.248 and its L = 2 singularity).
   REPAIR (c): the IMS step written (§4): c_R(1) at scale RM from single-interface bounds; regular U at scale M inside the index-j
   regularity cubes (which straddle the interface, P5), gauge covariance (3.32), (3.80)–(3.81) at base U = 1 with α₁ = O(LMα₀):
   c_R(U) ≥ c_R(1) − C′LMα₀ − EM⁻². Lemma S HOLDS (constants in explicit crude form, §5.4 and its dated precision in §6).
2. (3.132) ASSEMBLED, rate δ₁ = s*κ₁ − (d−2)lnL/(2RM), constant 2C₁′L^{d/2−1} — HOLDS given Theorem L′ (repaired) and Theorem
   3.3/3.12. COMPLEXIFIED — HOLDS given Theorem 3.4, with Q* read as Bałaban's F*_{2,j}-continuation (p. 406), not the adjoint.
3. WALKS OF (QGQ*)⁻¹ BY COMPRESSIONS — HOLDS (TC₀ = I − R verified). THEOREM 3.10 — HOLDS WITH PRECISION (Corollary D's three hypotheses,
   §10.4; the CMP 89 estimate sits inside Theorems 3.9 and 3.10, and the order 3.7 → (3.97) → 3.9 → P → 3.10 is non-circular). CMP 89 NOT
   NEEDED — agreed. TREES ARE CATERPILLARS — HOLDS.
4. COMPUTED FACTS. "Block bonds inside one scale region" (B) refuted — HOLDS (reproduced on a consistent toy: G⁻¹ min eig −7e−14). The
   replacement (A) — REFUTED as Bałaban's convention (item 1(a)). λ_min(T̂) = 0.0019 (L = 2) / 0.0029 (L = 4), volume independent — correct
   readings OF OPERATOR (A) (0.001905, 0.001914 reproduced to every digit; the L = 4 geometry 2|8 has no scale-0 ring and in a Dirichlet toy
   with boundary bonds carries an unpinned global gauge mode — exactly singular under (C)), but of the wrong operator. Under (C):
   0.032 (two scales), 0.0192 (three; N = 32/40 agree to 4e−4), 0.0168 (four), 0.0184 (L = 4, 1|4) — 83–88% of the single-scale value
   at the coarsest block size: THE INTERFACES COST ≤ 17%, NOT A FACTOR 10, and (A)'s λ_min(T̂) falls with every added scale where (C)'s
   is flat. M3g's "the constant lives at the interfaces" and its CBS readings γ ≈ 0.93 (U1) are artifacts of (A); under (C) γ = 0.414
   (= √2 − 1), 0.508, 0.647.
ADVERSARIAL. Slice pure gauge with smooth block averages: Rayleigh ≈ 0.9–1.07·a (no near-zero mode). Minimum over ALL slice pure-gauge
modes under (C): 0.15–0.17·a (L = 2), 0.058·a (L = 4), volume-stable — the softest direction of G⁻¹ against ℓ⁻² to ≤ 2.5%, so the
next object (M3g's slice Poincaré) reduces on its extremal subspace to a SCALAR inequality for the Δ²-minimal extension of block
averages. Extreme geometry (single minimal big block; concave corner): no degradation. Background at and beyond the edge of regularity
(constant flux up to π per coarsest block): c_R loses ≤ 8%, quadratically.
HOLES: none that falsifies M3g's theorems once the convention is repaired; the hole is the convention itself and every computed claim
built on it (the interface factor, γ, the M ≥ 3 condition).

## 12. TWO SENTENCES THE VERDICTS DEPEND ON (dated, after §11)
(C) IS FORCED, NOT INTERPRETED: Bałaban asserts QA gauge invariant under N(Q′) (CMP 99 p. 420; CMP 96 p. 227) — that excludes the
inward bonds (Prop. C(i)); Theorem 3.11 asserts G > 0 — that needs the outward bonds ((B) is singular); (C) is the unique one of the
three readings under which his own identities hold, and it is also what CMP 96 (2.3) says verbatim.
NOTHING DOWNSTREAM COLLAPSES: under (C), Theorem L′, (3.132), the compression walks, Theorem 3.10 (at the rigour of (3.90)–(3.99)) and
the caterpillars all stand, with BETTER constants; withdrawn are only M3g's computed interface claims (the factor-10 drop, γ ≈ 0.93)
and the condition M ≥ 3. M3e's (189)–(190), which consume (3.132) only as a kernel bound, are unaffected.
