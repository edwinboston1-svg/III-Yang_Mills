# M3d — (PI-4) THE LARGE-FIELD STEPS AT A COMPLEX WILSON COEFFICIENT; (PI-5) THE MULTI-STEP HISTORY PROPAGATION

Proof agent M3d, 2026-11-02. Work directory `.../scratchpad/math/M3d/`. Appended as the work proceeds; nothing above a
line is edited after it is written except by a dated correction below it. Labels: READ (on the rendered page, today, by
this agent), PROVED (full proof here), PROVED GIVEN [named input], NAMED (stated with its falsifier, not proved).

## 0. Sources

Read in full before deriving: `math/MATH_BRIEF.md`; `math/M3c/WORK.md` (§§0–12); `math/M3b/WORK.md` (§§0–15);
`math/M3R/REVIEW.md`.

Primary texts (hashes re-taken today, equal to M3b §0's census): LFR I = CMP 122 (1989) 175–202, `Download (2).pdf`,
SHA-256 prefix 4002290ab2d69bd4; LFR II = CMP 122 (1989) 355–392, `Download (4).pdf`, 80ab1ee09fff0a5b; CMP 119 (1988)
243–285, `Download (6).pdf`, c629e6280329cca4. Rendered by `bin/render.py` (PyMuPDF, `python -E -P`, 130 dpi grey) into
`render/lfr1_*.png`, `render/lfr2_*.png`, `render/cmp119_*.png`.

READ ON IMAGE (this agent, today): LFR I pp. 175–195 (every page); LFR II pp. 355–371, 378–392 (every page in that range).
(Further pages are added to this list where they are read below.)

## 1. THE DECISIVE STRUCTURE OF THE R-OPERATION (READ)

1.1 THE DEFINITION AND ITS DENOMINATORS (LFR I pp. 176–177, READ). (0.3): (Rρ)(V) = Σ_Z ρ(Z″,V)·∫dV|_{Z′}ρ(Z,V)/∫dV|_{Z′}ρ(Z″,V);
"We will prove that the densities are positive, and the integration domains in the integrals above are nonempty, hence the
denominators are positive, and the operation R is well defined. It satisfies the basic normalization property (0.4)
∫dV(Rρ)(V) = ∫dVρ(V)." p. 177: "in (0.3), (0.5) we take the denominators equal not the integrals of the whole densities
ρ(Z″, V), but to the integrals of some parts of these densities … localized in neighborhoods of the domains Z′ … determined by
small field effective actions only."
THE ACTUAL FORM (LFR II (1.1), p. 356, READ): the result of R′ on one term is
  χ_kχ_{k,Λ}δ_{G₀}(V′_k)χ exp[−(1/g_k²)A(ζ₀, U_{k,Z}(V′_kV_Λ))] · χ_{h,1/2}∫dV′Γ_{B₀}δ_{T₀}(V′)χ′ exp A″_k / ∫dV′Γ_Λδ_{G₀}(V′)χ exp[−(1/g_k²)A(ζ₀, U_{k,Z}(V′V_Λ))].
THE NEW WILSON FACTOR AND THE DENOMINATOR CARRY ONE AND THE SAME WEIGHT; the normalization (0.4) is the algebraic identity
∫dV′[new factor]/[denominator] = 1. Λ (LFR I (1.73), p. 192, READ) = Z″_k plus one layer of M-cubes, "a rectangular
parallelepiped contained in a cube of the size 100M … the domain on which we integrate out all field variables".
U₀ = U_{k,Z}(V_Λ) (LFR I (1.79), p. 195): the minimizer of the reference Wilson action with the data outside Λ fixed
(Proposition 1, p. 194), |U₀(∂p) − 1| < 2ε_kη² + O(1)B₃B₅M⁵e^{−δ dist(p,Λ)}ε_kη² (1.80): a small-field background.

1.2 THE CANCELLATION THE WHOLE R-OPERATION RESTS ON (LFR II pp. 356–368, READ). p. 356: "The basic problem … is connected
with the Wilson terms … A part of this term from the nominator has to be combined with the term in the first exponential, to
give the Wilson term of the new action. The remaining part has to be cancelled … with the term from the denominator … because
the terms are multiplied by g_k^{−2}, so they are potentially dangerous." (1.10), p. 358: (denominator)^{−1} =
exp[+(1/g_k²)A(ζ₀,U₀) + I(U₀) − E_k(Λ)], |I(U₀)| < O(1)log M|Λ| < O(1)M⁵ (1.11), the integral "extended analytically on
G^c-valued configurations"; "we have to cancel the first term in the exponential on the right-hand side, otherwise we will not
get good bounds for this exponential." The numerator (1.14)–(1.37): the Wilson term is split; (1.37), p. 365:
 −(1/g²)A(ζ₀, U_{k,Z}(V′_kV_Λ)) − A(1/g″(·)², U″_k) + (1/g²)A(ζ₀,U₀)
   = −A(1/g_k(·)², U_k) − A((1/g″² − 1/g²)ζ, U″_{k,Z}) − A((1/g″(·)²)ζ₁, U″_{k,Z}) − ½Σ_p η⁴ζ(x(p))|(DH″_{1,k,Z}B)(p)|² + O(1).
THE FIVE KINDS OF TERM, AND HOW EACH IS CONTROLLED (READ):
 (K1) −(1/g²)A(ζ₀,U₀): CANCELLED EXACTLY numerator against denominator (both analytic in the complexified background).
 (K2) the new Wilson term −A(1/g_k(·)², U_k): becomes the new action's Wilson term.
 (K3) the coupling DISCREPANCY −A((1/g″² − 1/g²)ζ, U″_{k,Z}): "small … because 1/g″² − 1/g² = O(N) ≤ O(R_k) on the support of
      ζ, so it can be bounded by O(1)N^{2+4β₀}(100MR_k)⁴(O(1)B₃B₅M⁵ε_k + O(1)B₃δ′_k)² ≤ O(1)B₃²B₅²M⁹R_k⁷ε_k²" (p. 366): smallness
      from the O(N) coefficient.
 (K4) the large-field term −A((1/g″²)ζ₁, U″_{k,Z}): (1.46)–(1.48), p. 368: "= A((1/g″²)ζ₁, U″_{h+2}(exp ig_kB, V″)) + O(1), where the
      terms in O(1) are small, and depend analytically on the field U … The gauge field in the Wilson action on the right-hand
      side is G-valued, hence the action is positive, and it provides the necessary bounds for large plaquette variables." The
      complexification is carried by an H-function supported in Ω″~²_{h+1}∩Z″_{h+2}, whose exponential decay "suppresses strongly
      large values of 1/(g″(·))²" ((1.47): the linear term ≤ O(1)A₀C₁B₃³B₅M¹⁰p₀q₁R_k⁷L^{−N}, small).
 (K5) the quadratic form −½Σ_p η⁴ζ(x(p))|(DH″B)(p)|²: a SUM OVER PLAQUETTES OF NONNEGATIVE TERMS (real background), "bounded by
      0" (p. 361), the background-dependent remainder a small form; for G^c backgrounds "a similar bound, with a larger power
      of log g_k^{−2} only".
 O(1): terms small after division by g_k² (exponential decay of H-functions, (190) [15]; L^{−N} factors).

1.3 WHERE POSITIVITY OF THE DENSITY IS USED (LFR II pp. 379–392, READ). p. 379: "the operation T′_k(X) can be represented as the
operation for a regular G-valued configuration U, with the additional small, and possible complex valued, term in the
exponential. All the expressions in the definition (1.71), for the configuration U, are real, and the exponential density in
the integral is positive. This implies the inequalities" (1.73) |T′_k(X,(U,J))F| ≤ (T′_k(X,(U,0))1)sup e^{|σ|}|F| (UPPER) and
(1.74) |T′_k(X,(U,J))1| ≥ (T′_k(X,(U,0))1)e^{−2sup|σ|} (LOWER), whence (1.75) for the normalized operation. In the
definition (1.71) "only the quadratic form in B and the term V(X~) depend on (U, J)": the large-field Wilson term
A((1/g″²)ζ₁|_X, U″_{h+2}(exp ig_kB, V″)) is independent of the complexified field.
THE MAIN LINE USES ONLY THE UPPER BOUND: the activities (1.91) F(X′) contain the un-normalized T′_k(X_{j_h}); (1.92) "Using
(1.68), (1.73), (1.89), we obtain" — (1.73) and (1.89) T′_k(X)1 ≤ exp(−2(1 + β₀)^{−1}p₀(g_k)); the new large-field operation
(1.102) T_k(Y) = χ^c_k(Y~⁻⁶)χ_{k,Λ}δ_G(V_kV_Λ^{−1})T′_k(Y) is un-normalized. THE LOWER BOUND (1.74)–(1.75) IS USED ONLY IN "the final
remark about another possible representation of the k-th density" (1.103)–(1.104), p. 391, which "can be used alternatively".
The large-field factors (1.79)–(1.89) come from: the Wilson action on real configurations violating a small-field condition
(p. 380: χ^c_j(P_j) "yields the factor exp(−γ₀(1/2g_j²)(B₃^{−1}ε_j)²(LM₂R_j)^{−d}|P_j|) in the usual way"); "expanding the Wilson
action locally in the approximate fluctuation field, and using the positivity bound for the resulting quadratic form" (Q_j,
R_j); (1.77)–(1.78) (the quadratic form bounded below by γ₀Σ|(∂B)(p′)|² minus a small constant); "All the integrals with
respect to the group valued variables … are estimated by 1"; the A_j-Gaussians "using the positivity properties of the
quadratic forms" (reference Gaussians, D-free by the device).

1.4 FURTHER PAGES READ ON IMAGE (this agent, today): LFR II pp. 372–377 (localization of E, R, B terms; (1.59)–(1.70));
CMP 119 pp. 255, 256 (render only), 262–284 (§2's Theorems 1–2, (2.43)–(2.50); §3 the k+1-st step (3.1)–(3.47); the proof
of Theorem 2 (3.48)–(3.72)). So every page of LFR I, LFR II and CMP 119 §3 (pp. 264–284) has been read.

1.5 CMP 119 §3, THE USES OF THE WILSON COEFFICIENT (READ). (a) (3.15), p. 268: Bałaban's OWN coupling functions are carried
by the device: "+ A(1/g_k²(·) − 1/g_k², U_k(exp i[g_kCA_k − hD̃(g_kCA_k)]V^{(k)})) − A(1/g_k²(·) − 1/g_k², U_{k+1})" in the
interaction, every Gaussian, cutoff, background (V^{(k)} the minimizer of the UNWEIGHTED A, (3.10)) and gauge fixing at g_k.
(b) p. 277: "The last expression in the curly bracket in (3.27), or in (3.15), is at first localized by the decomposition of
unity {ζ_□} introduced into the sum over plaquettes in the Wilson action. We obtain a sum of terms localized in Z_k, because
supp(g_k^{−2}(·) − g_k^{−2}) ⊂ Z_k. These terms contribute to the boundary terms only … the large values of the function
g_k^{−2}(·) − g_k^{−2} are suppressed by the exponential decay of H_k." (c) (3.25), p. 270: the effective action at the new
background, A_k(1/g_k², U_{k+1}), its Wilson term at the REAL minimizer U_{k+1}. (d) (3.27), (3.29): "probabilistic
measures" — used only through the interpolation identities (3.26), (3.28) (algebraic) and the cluster expansions of Sect.
3.7 [I] (= CMP 116 §2). (e) (3.33)–(3.36): −½ log det(C*Δ^{(k)}C) by a resolvent contour — the reference Gaussian, D-free.
(f) (3.2)–(3.3), (3.16): characteristic functions at the reference thresholds ε_{k+1}, δ_k. (g) p. 264: Corollary 3's LOWER
bound χ_k exp[−(1/g_k²)A(U_k) − E_−|T_η|] ≤ ρ_k is a CONSEQUENCE, stated after (2.49), not an input of the induction.

## 2. (PI-4) — THE LARGE-FIELD STEPS AT A COMPLEX WILSON COEFFICIENT

2.0 DATED CORRECTION TO M3c §8 (PI-4)(ii) (2026-11-02, this agent; M3c's file untouched). The relative bound
|Im A| ≤ C_A Re A + η on LFR II's complexified domain is NOT the object the large-field steps need. The reading of §1 shows that
Bałaban never bounds an UNCANCELLED Wilson term at a complexified configuration through the sign of its real part: every Wilson
term with the large coefficient 1/g² is either (K1) cancelled exactly between numerator and denominator as two copies of one
analytic function, or (K4) evaluated at a G-VALUED configuration with the complexification carried by H-function corrections
bounded in modulus INCLUDING the factor 1/g″², or (K5) a sum over plaquettes of nonnegative terms at real background with a
complex-background remainder bounded in modulus. M3c's falsifier — "an additive bound on |Im A| independent of Re A, multiplied by
θ₀x_k" — IS PRESENT IN FORM at exactly one line, LFR II (1.47), p. 368: the linear term of the H″-expansion of
A((1/g″(·)²)ζ₁, U″_{h+2}(U)) is bounded by O(1)(1/g_k²)(α_{0,k} + α_{1,k})ε_kL^{−N}N^{1+β₀}·… ≤ O(1)A₀C₁B₃³B₅M¹⁰p₀(g_k)q₁(g_k)R_k⁷L^{−N}
— additive, independent of Re A — but its constant before the coefficient is η = g_k²·O(1)A₀C₁B₃³B₅M¹⁰p₀q₁R_k⁷L^{−N}, so
θ₀ηx_k = θ₀·O(1)A₀C₁B₃³B₅M¹⁰p₀q₁R_k⁷L^{−N}: small "under the usual conditions on N" (p. 368; L^{−N} ≤ (log g_k^{−2})^{−ν} with
ν ≥ 2p₀ + dr₀, p. 363). The falsifier's premise ("it would not be absorbed") fails. What the complex coefficient DOES require is
one change of construction and three lemmas.

2.1 THE ONE CHANGE OF CONSTRUCTION: R_D (PROVED NECESSARY, then adopted). Bałaban's R-operation (§1.1) carries the new Wilson
factor and the denominator at the reference 1/g_k². With the Wilson coefficient x″(·) + D(·) in the numerator (x″ := 1/g″(·)²,
Bałaban's lagged coefficient, x″ ≥ x_k := 1/g_k²), a reference denominator cancels only x_kA(ζ₀,U₀) and leaves −A(Dζ₀,U₀), with
|Re A(Dζ₀,U₀)| up to (θ₀/2)x_k·|supp ζ₀|·sup|U₀(∂p) − 1|² ≤ (θ₀/2)(102M)⁴(2 + O(1)B₃B₅M⁵)²A₀²p₀(g_k)² by (1.80) — of order
θ₀M¹⁴p₀², against the region's large-field factor exp(−2(1 + β₀)^{−1}p₀(g_k)) (1.89): NOT ABSORBED (and larger for complexified U₀).
So the R-operation must carry the complex coefficient. R_D := (0.3)/(1.100) with, on each region Λ_i, the new Wilson factor
exp[−A((x_k + D(·))ζ_i, U_{k,X_i}(V′_kV_{Λ_i}))] and the denominator ∫dV′Γ_{Λ_i}δ_{G_i}(V′)χ(Λ_i)exp[−A((x_k + D(·))ζ_i, U_{k,X_i}(V′V_{Λ_i}))].
(a) The normalization (1.102)/(0.4) ∫dV(R_Dρ)(V) = ∫dVρ(V) holds: it is the identity ∫dV′[new factor]/[denominator] = 1, valid
for any coefficient at which the denominator is nonzero (Lemma 2). (b) (K1) is exact: the numerator's (x_k + D(·))A(ζ₀,U₀) and
the denominator's are one analytic function of (D, U) (U₀ = U_{k,Z}(V_Λ), the minimizer of the UNWEIGHTED action, LFR I
Proposition 1 — the device — is the same in both). (c) The new Wilson term of (1.37) becomes −A(x_k^{new}(·) + D(·), U_k), x^{new}
Bałaban's new coefficient: the coupling field D is carried through R unchanged (no flattening of D on Λ). (d) The numerator's
coefficient splits as (x_k + D(·)) + (x″ − x_k): Bałaban's discrepancy (K3), x″ − x_k = O(N) ≥ 0, is untouched, and D joins the
part that is cancelled (K1) and carried into the new action (K2).

LEMMA 1 (MODULUS DOMINATION AT REAL CONFIGURATIONS; PROVED). Let c(p) = x″(p) + D(p) with x″(p) ≥ x_k > 0 real, |D(p)| ≤ θ₀x_k/2,
and U G-valued. Then |exp(−A(c, U))| = exp(−A(Re c, U)) ≤ exp(−(1 − θ₀/2)A(x″, U)) ≤ 1.
PROOF. A(c,U) = Σ_p c(p)(1 − Re tr U(∂p)) with 1 − Re tr U(∂p) ∈ [0, 2] for U(∂p) ∈ SU(2); Re c(p) ≥ x″(p) − θ₀x_k/2 ≥
(1 − θ₀/2)x″(p) since x″ ≥ x_k. ∎ The same for a weighted nonnegative form Σ_p(1 + d(p))w_p|X_p|², w_p ≥ 0, X real: real part
≥ (1 − θ₀/2)Σ_pw_p|X_p|², imaginary part a pure phase in the modulus.

LEMMA 2 (THE R_D DENOMINATOR; PROVED GIVEN Bałaban's (1.6), (1.7)–(1.9) and the V-bound of p. 357, with their complexified
versions "with ε_k replaced by O(α_{0,k} + α_{1,k})", p. 358). Let Λ be an R-region (LFR I (1.73): inside a cube of size 100M), n
the dimension of {B′ on Λ : B′|_{G₀} = 0}, c(·) = x_k(1 + d(·)) with |d| ≤ θ₀/2, θ₀ ≤ 1/4, sup_{supp ζ₀}|d − d_Λ| ≤ δ_*(g_k, M)
(Lemma 3; d_Λ := d(z_Λ), z_Λ a fixed point of Λ), and U ∈ U^c_k(Z, α_{0,k}, α_{1,k}). Put
J(c, U) := ∫dV′Γ_Λδ_{G₀}(V′)χ exp[−A(cζ₀, U_{k,Z}(V′V_Λ))]. Then for g_k ≤ g₂(M) (a threshold of Bałaban's type, fixed in (v))
J(c,U) ≠ 0, J is jointly analytic in (d(·), U), and
  J(c,U)^{−1} = exp[A(cζ₀, U₀) + I(U₀) − E_k(Λ) + Θ_d(Λ) + I′_d(U)],   Θ_d(Λ) := ½ log(det Q_d/det Q₀),   |I′_d(U)| ≤ 2 log 2,   (2.1)
with I, E_k(Λ) Bałaban's (1.10)–(1.11) and Q_d the matrix (on the gauge-fixed space) of the weighted background-one form
q_d(B′) := Σ_p(1 + d(p))ζ₀(p)|(DH₁B′)(p)|² (+ Bałaban's background-one remainder of (1.7)); |Θ_d(Λ)| ≤ (θ₀ + θ₀²)n, a c-number
(independent of U) within Bałaban's budget for normalization constants ("O(1)log g_j^{−2}|Z_j|", p. 380).
PROOF. (i) Expansion. V′ = exp(ig_kB′). (2.8) [I] is linear in the plaquette weight, so (1.2) holds with ζ₀ replaced by (1 + d)ζ₀:
A(cζ₀, U_{k,Z}(V′V_Λ)) = A(cζ₀,U₀) + (1/g_k)ℓ_d(B′) + ½q_{d,U}(B′) + (1/g_k²)V_d(g_kHB′), whence J·e^{A(cζ₀,U₀)}e^{E_k(Λ)} = K(d,U) :=
∫_{B′|_{G₀}=0}dB′ w(B′)exp[−½q_{d,U} − ℓ_d/g_k − V_d/g_k²], w := (σ(g_kB′)/σ₀)χ({|B′| < M₀g_k^{−1}ε_k}).
(ii) The pieces on the cutoff domain |B′| < M₀A₀p₀(g_k) (Bałaban's bounds times |1 + d| ≤ 1 + θ₀, or times δ_*):
q_{d,U} = q_d + δq_{d,U}, |δq_{d,U}(B′)| ≤ (1 + θ₀)O(1)(M⁶R_k(ε_k + α_{0,k} + α_{1,k}) + e^{−R_k})‖B′‖² by (1.7) and its complexified
version; ℓ_d = (1 + d_Λ)ℓ₀ + ℓ_{d−d_Λ}, with |ℓ₀/g_k| < 3B₃M₀A₀²p₀²e^{−R_k}(100M)⁴ by (1.4)–(1.6) (criticality of U₀ kills the
constant-weight part on Λ) and |ℓ_{d−d_Λ}(B′)/g_k| ≤ δ_*·O(1)B₀(102M)⁴(ε_k + α_{0,k} + α_{1,k})g_k^{−1}|B′| ≤ δ_*·O(1)M⁴P(g_k)|B′|,
P(g) := A₀p₀(g) + A₁p₁(g) + C₀(log g^{−2})^{q₀} + C₁(log g^{−2})^{q₁}; |V_d/g_k²| ≤ (1 + θ₀)O(g_k^{1−β})|Λ| (p. 357);
|σ(g_kB′)/σ₀ − 1| ≤ O(g_k²|B′|²). Let s(g_k, M) be the sum of these relative sizes on |B′| ≤ R, R := ½M₀A₀p₀(g_k): each entry
tends to 0 as g_k → 0 at fixed M (δ_* of Lemma 3 carries a spare factor P(g)^{−1} for this).
(iii) Positivity. By (1.8)–(1.9), Q₀ ≥ c_Λ := γ₀/(2d(100M)⁵) on the gauge-fixed space; Re Q_d ≥ (1 − θ₀/2 − O(δ_*))Q₀ ≥ ½Q₀ and
‖Q₀^{−1/2}(Im Q_d)Q₀^{−1/2}‖ ≤ θ₀/2 + O(δ_*) (Lemma 1, pointwise form).
(iv) Contour rotation (no exponential loss in n). M_d := Q_d^{−1/2}Q₀^{1/2} (principal square roots of complex symmetric matrices
with positive definite real part): M_d^TQ_dM_d = Q₀, det M_d = (det Q₀/det Q_d)^{1/2}, ‖M_d − I‖ ≤ O(θ₀). The function
F̃(B′) := (σ(g_kB′)/σ₀)exp[−½δq_{d,U} − ℓ_d/g_k − V_d/g_k²] is analytic on {|Re B′| < 2R, |Im B′| ≤ 2θ₀R} (σ and V entire in g_kB′, ℓ and
δq polynomial; |g_kB′| ≤ M₀ε_k ≪ 1 there). Split K = ∫_{|B′|<R} + ∫_{|B′|≥R} (χ ≡ 1 on the first piece). In the first, deform
ℝ^n ∩ {|B′| < R} to M_d{|B″| < R} through M_t := I + t(M_d − I), t ∈ [0,1], along which Re q_d(M_tB″) ≥ ¼q₀(B″) ((iii), θ₀ ≤ 1/4);
Cauchy's theorem in ℂ^n gives ∫_{|B′|<R}e^{−½q_d}F̃ = det M_d∫_{|B″|<R}e^{−½q₀(B″)}F̃(M_dB″)dB″ + (side), with
|side| ≤ 2·O(θ₀R)·e^{−c_ΛR²/16}(4π/c_Λ)^{n/2}. On |B″| < R, |F̃(M_dB″) − 1| ≤ 2s(1 + ‖B″‖²), so the remaining average is over a REAL
Gaussian: ∫_{|B″|<R}e^{−½q₀}F̃(M_d·) = K_G(0)(1 + r₁), |r₁| ≤ 2s(1 + n/c_Λ) + e^{−c_ΛR²/8}(…), K_G(0) := ∫e^{−½q₀}. In the tail
|integrand| ≤ e^{−½Re q_{d,U} + |ℓ_d|/g_k + |V_d|/g_k²}σ/σ₀ ≤ e·e^{−¼c_Λ‖B′‖²}, so |tail| ≤ e·e^{−c_ΛR²/8}(8π/c_Λ)^{n/2}.
(v) Assembly. K(d,U) = (det Q₀/det Q_d)^{1/2}K_G(0)(1 + r) with |r| ≤ ½ once (A) 2s(g_k, M)(1 + n/c_Λ) ≤ ¼ and
(B) c_ΛR²/16 ≥ n log(16λ_max(Q₀)/c_Λ) + 2. (A) holds for g_k ≤ g₂(M) since s → 0; (B) reads γ₀M₀²A₀²p₀(g_k)²/(128d(100M)⁵) ≥ O(n log M),
n ≤ 12(101M)⁴ — "p₀(g_k) large depending on M", exactly Bałaban's kind of condition (he needs p₀² ≫ M^dR^{d+2}, LFR II (1.82),
(1.88), and I(U₀) ≤ O(1)M⁵, (1.11)). So K ≠ 0 and log K(d,U) = log K_G(0) − Θ_d(Λ) + log(1 + r(d,U)); with Bałaban's
I(U₀) = −log K(0,U) this is (2.1), I′_d := log(1 + r(0,U)) − log(1 + r(d,U)). Analyticity: K is a finite-dimensional integral of an
integrand entire in d(·) and analytic in U, dominated uniformly on compacts by the bounds above, hence analytic; nonvanishing, so
log K is analytic. |Θ_d| ≤ ½Σ_j|log(1 + μ_j)| ≤ (θ₀ + θ₀²)n, μ_j the eigenvalues of Q₀^{−1/2}(Q_d − Q₀)Q₀^{−1/2}. ∎
REMARK (why the rotation). The crude bound |∫e^{−½q_d}f| ≤ sup|f|∫|e^{−½q_d}| loses (|det Q_d|/det Re Q_d)^{1/2} = Π_j(1 + λ_j²)^{1/4}
≈ e^{nθ₀²/4} (λ_j the eigenvalues of (Re Q_d)^{−1/2}Im Q_d(Re Q_d)^{−1/2}; sharp at constant d) and would force θ₀ ≲ n^{−1/2} ~ M^{−2}.
The rotation (iv) removes the loss: θ₀ ≤ 1/4 suffices. For REAL d (E1-a compares two real trajectories) Im Q_d = 0, no rotation.

LEMMA 3 (THE R-REGION VARIATION; PROVED). Define δ_*(g, M) := [M¹⁴R(g)⁴P(g)³]^{−1}, R(g) Bałaban's R_j (CMP 119 (2.5): the
smallest L^n with R_j ≥ (log g_j^{−2})^r, r ≥ 2 — taken from M6 §2's reading, labelled SHARED), P(g) as in Lemma 2. For the
coupling field of (S₁), D_k(z) = −τm_kh(z) + R_k(z) (M3b (5.3)): if
  |τ| ≤ r_τ := c₃·δ_*(γ, M)·X / (M·‖∇h̃‖_∞·e^{Cγ^a}),   c₃ an absolute constant,                                          (2.2)
then on every R-region Λ of every step k ≤ K, sup_{supp ζ₀}|d_k(·) − d_k(z_Λ)| ≤ δ_*(g_k, M), d_k := D_k/x_k.
PROOF. supp ζ₀ has diameter ≤ 102M in scale-k units; the gradient of h in scale-k units is ≤ ‖∇h̃‖_∞L^{k−K}; |m_k| ≤ e^{Cγ^a}
(M3b (5.4) at power a, §15.2); ∇R_k is of lower order (M3b (5.3)); x_k ≥ X. So sup|d_k − d_k(z_Λ)| ≤ 103M|τ|e^{Cγ^a}‖∇h̃‖_∞L^{k−K}/X.
Since x_k ≤ X + (K − k)(c + ρ) + 2F (Theorem 2's profile, M3 (5.1)) and δ_*(g_k, M)^{−1} = M¹⁴·polylog(x_k),
L^{k−K}δ_*(g_k, M)^{−1} ≤ C_pL^{−(K−k)}(1 + K − k)^pδ_*(γ, M)^{−1} ≤ C′_pδ_*(γ, M)^{−1}; take c₃ ≤ 1/(103C′_p). The lag of D in
large-field regions (no renormalization there) is ≤ N·sup|∂_xβ·D| ≤ Ng_k^{2+a}θ₀x_k ≪ δ_*x_k. ∎
The disc (2.2) is independent of K and of the volume; it joins M3b's |τ|‖h̃‖_∞ ≤ θ₀X/(4e^{Cγ^a}) as the τ-disc of (S₁). For
CONSTANT D (the frozen model of Lemma Σ₁; E1-a's real constant shifts) the condition is void. Why it is needed at all: with D
varying across Λ, the weighted linear terms Σ_p(D(p) − D_Λ)∇_pA(U₀)·(HB)_p — in the denominator and in the numerator's (1.20)/(1.28) —
are not killed by the criticality of U₀ (which kills only a constant weight); Bałaban's own varying coefficient has the same
terms with coefficient O(N), made small by g_k² (p. 364: "(1/(g″_k(·))²) − 1/g_k² is bounded by O(1)(k − j)"); ours are made
small by δ_*.

2.2 THEOREM PI-4 (PROVED GIVEN the inputs on which Bałaban's own induction stands — CMP 99's random-walk expansions [13]; CMP 102
Sect. G including (189)–(190) [15]; CMP 116 Lemmas 1–2; CMP 109 Theorem 3; the estimates of CMP 119 §3 and LFR I–II as stated on
the pages, including the steps Bałaban sketches ("They should be obvious", LFR II p. 368) — and on M3c's Lemmas M and W, whose
inputs are the same).
SETTING. The reference trajectory (x_j)_{j≤K} of Theorem 2; complex coupling-deviation fields D_j(·) with |D_j| ≤ θ₀x_j/2,
θ₀ ≤ min(θ_*, 1/4) (θ_* of M3c §5.3), satisfying the R-region condition of Lemma 3 (guaranteed by (2.2)); THE DEVICE: every cutoff,
characteristic function, determining set, background (minimizers of the UNWEIGHTED action), Gaussian and gauge-fixing weight at the
reference; D carried in the Wilson coefficient x_j(·) + D_j(·) of the effective action and, inside each fluctuation integral, as the
interaction difference D·[A(U(e^{iB}V)) − A(U(V))] beside Bałaban's own coupling-function difference (CMP 119 (3.15); LFR I (1.60));
the R-operation replaced by R_D (§2.1).
CONCLUSION. Bałaban's inductive description (CMP 119 (2.18)–(2.42)), Theorem 2 ((2.43)–(2.44)) and the T-bounds ((2.50); LFR II
(1.79)–(1.89)) hold for the D-deformed densities with: (a) moduli in place of values; (b) γ₀ ↦ (1 − θ₀/2)γ₀ in every large-field
factor; (c) the boundary-term constants (C₀ of LFR I (1.70), the α and O(1) of LFR II (1.68)–(1.69)) enlarged by absolute factors;
(d) every localized term analytic in the D's on the polydisc; (e) R_D preserving integrals; (f) the new effective action's Wilson
coefficient x_{k}(·) + D_{k}(·), D unchanged by R_D. In particular (PI) of M3b §8 holds: (PI-1) [M3c], (PI-2) [M3c §8, 9.2],
(PI-3) [frozen part now unconditional on the large field, §4.2], (PI-4) [this theorem].

PROOF: induction on k; the step k → k + 1 is T (CMP 119 §3) followed by R (LFR I–II). Every site where the Wilson coefficient or
the density's positivity enters, with its treatment (READ pages in §1):
 T1 (3.2), (3.3), (3.16): characteristic functions at ε_{k+1}, δ_k — D-free.
 T2 (3.15), (3.25)–(3.47): the fluctuation integral on Λ_{k+1}; the D-difference is −d(𝒲 + W_{≥3}) (M3c Lemma W), a regular
    term; Lemma M with ε = |s|E₀C₁ε₁ + |d|(C_W + E₀C₁ε₁) ≤ ε_* for |d| ≤ θ_* ((PI-1)). The "probabilistic measures" (3.27), (3.29)
    enter only through the interpolation identities (3.26), (3.28), (3.30), (3.32) — algebraic wherever the normalizations are
    nonzero, which the convergent expansion supplies — and through the cluster expansions of Sect. 3.7 [I] = CMP 116 §2, which
    Lemma M establishes for complex potentials in the cone.
 T3 p. 277: the D-difference's part localized in Z_k ("localized by the decomposition of unity {ζ_□} introduced into the sum over
    plaquettes in the Wilson action … the large values of the function g_k^{−2}(·) − g_k^{−2} are suppressed by the exponential
    decay of H_k") goes to B^{(k+1)} exactly as Bałaban's own coefficient differences, which reach O(k) on lagged regions;
    |D| ≤ θ₀x_k/2 ≤ x_k lies in that range.
 T4 (3.25): the Wilson term of A_k at the real minimizer U_{k+1}: Lemma 1. The E-, R-, B-terms: analytic in D, modulus bounds by
    the induction.
 T5 (3.23)–(3.24): T^{(k+1)} integrates D-free Gaussians and characteristic functions against exp A_k: modulus by T4.
 T6 p. 279: the vacuum subtraction at U = 1 and the coupling counterterm, with the LOCAL β-function (M3b Lemma Σ₁): §4.2.
 R1 LFR I (1.22)–(1.70): characteristic functions at the reference (D-free); the boundary-layer integrals (1.60) carry the
    D-difference beside Bałaban's coefficient difference — Lemma M with the cone radius θ_* — and go to C_k^{(n+1)} with (1.70),
    C₀ ↦ R₀C₀ (activities C₃′ε₂*(ε_*) in place of C₃′ε₂(E₀C₁ε₁); R₀ = ε₁^max/ε₁ an absolute constant, M3c §3); the counterterm
    (1.62) gains the D-flow's increment, coefficient O(g_k^{2+a}θ₀x_k).
 R2 LFR I (1.75), p. 193: 1 − χ_{k,Λ} gives its factor "estimating in the usual way the Wilson action" on real configurations:
    Lemma 1, factor exp(−(1 − θ₀/2)(1/4g_j²)(O(1)B₃M²)^{−2}ε_j²) ≤ exp(−(1 − θ₀/2)A₁²p₀²(g_j)) (cf. LFR II p. 381).
 R3 LFR II (1.1)–(1.48), the R-operation: R_D (§2.1); Lemma 2 for the denominator ((1.10)–(1.11) ↦ (2.1)); (K1) exact; (K2) the
    new Wilson term with D; (K3) unchanged; (K4) (1.46)–(1.48) at coefficient (x″ + D)ζ₁: the G-valued term by Lemma 1, the O(1)
    terms carry the coefficient linearly — (1.47) is a bound with the explicit factor 1/g″², so O(1)_D ≤ (1 + θ₀/2)O(1) (§2.0); (K5)
    Lemma 1's pointwise form plus the complex-background remainder times |1 + d|; the weighted linear terms by Lemma 3; the
    remaining O(1) of (1.37) and (1.31) (small after division by g_k², by e^{−½δMR_k} and L^{−N}) carry |1 + d| ≤ 1 + θ₀.
 R4 LFR II pp. 369–377 (localization, (1.49)–(1.70)): the re-expansions around U_k act on the E-, R-, B-terms (analytic in D,
    modulus bounds); (1.68)–(1.69) hold with Lemma 2's I′_d and Θ_d among the normalization constants and Lemma 3's terms among
    the small terms.
 R5 LFR II (1.71)–(1.89), the T′-bounds: "All the expressions in the definition (1.71), for the configuration U, are real, and the
    exponential density in the integral is positive" FAILS at complex D; but the integrand's MODULUS is the integrand of
    T′_{k,Re} — Bałaban's operation with the real coefficients Re(x″ + D) on the Wilson term and 1 + Re d on the quadratic form,
    each ≥ (1 − θ₀/2) times his (Lemma 1). Hence (1.73)_D: |T′_{k,D}(X,(U,J))F| ≤ (T′_{k,Re}(X,(U,0))1)·sup e^{|σ_D|}|F|, σ_D the
    small first-order term (Bałaban's σ times 1 + θ₀). The proof of (1.79)–(1.89) uses only LOWER bounds on these two coefficients
    (the large-field factors, pp. 380–383 including (1.77)–(1.78)) and UPPER bounds on the rest ("All the integrals with respect to
    the group valued variables … are estimated by 1"; the A_j-Gaussians, D-free, "using the positivity properties of the quadratic
    forms"); so they hold for T′_{k,Re} with γ₀ ↦ (1 − θ₀/2)γ₀, and the induction (1.80)–(1.88) closes under
    ¼(1 − θ₀/2)γ₀(14)^{−d}A₁²p₀²(g₁) ≥ O(1)2(64)^dM^dL^{d+1}R₁^{d+2} — "p₀ large, g₁ sufficiently small" (p. 385). (1.89)_D:
    T′_{k,Re}(X)1 ≤ exp(−2(1 + β₀)^{−1}(1 − θ₀/2)p₀(g_k)). THE LOWER BOUND (1.74)–(1.75) IS NOT AVAILABLE AT COMPLEX D AND IS NOT
    NEEDED: the main line uses (1.73) and (1.89) only — "(1.92) Using (1.68), (1.73), (1.89), we obtain" — the activities (1.91) and
    the new large-field operation (1.102) T_k(Y) are un-normalized; (1.74)–(1.75) serve only "another possible representation"
    (1.103)–(1.104), which "can be used alternatively".
 R6 LFR II (1.90)–(1.102), exponentiation: the activities obey (1.92)_D–(1.97)_D with (1 − θ₀/2)p₀ for p₀ (the condition
    −2(1 + β₀)^{−1}(1 − θ₀/2)p₀(g_k) + 1 + 2κ(100R_k)^d ≤ −(3/2)(1 − θ₀/2)p₀(g_k) of p. 389 holds for g_k small); R′^{(k)}(X) analytic.
 R7 Analyticity: each term is an integral of an integrand entire in the D's times D-independent characteristic functions, or a
    uniformly convergent series of such, dominated on the polydisc by the modulus bounds; the R_D denominators are analytic and
    nonvanishing (Lemma 2). Weierstrass / Morera (as in M3c Lemma M (d)). ∎
The density's LOWER bound in Corollary 3 (CMP 119 (2.50), LFR II (0.1)) is a consequence stated after the induction, not an input;
at complex D it is replaced by the upper bound on |ρ_k| — M3b (S₁)(iv).

2.3 WHAT (PI-4) COSTS, EXACTLY. One construction change (R_D); θ₀ ≤ min(θ_*, 1/4); the τ-disc (2.2); the thresholds g₂(M) of Lemma 2
((A), (B)) and the (1 − θ₀/2)-weakened forms of Bałaban's own conditions — all of the type "p₀ large, γ small depending on M",
none changes the order in which Bałaban fixes his constants (M, κ, κ₁, then ε₁, then γ). M6's threshold β_B (labelled SHARED:
log₁₀ β_B ≥ 978 on the literal chain, M6 §5) is governed by Bałaban's chain, not by these additions: (B) of Lemma 2 asks
p₀(γ)² ≳ M⁹log M, weaker than Bałaban's LFR II (1.9) row (M6 S-5: log₁₀ β ≈ 162 at p₀ = 13, M = 729).

2.3′ DATED PRECISION TO 2.3 (2026-11-02, written minutes after it; 2.3 not edited). The comparison of Lemma 2's thresholds with
M6's rows in 2.3 is too quick. Condition (A) of Lemma 2 reads s(g_k, M)·(1 + n/c_Λ) ≤ ⅛ with n/c_Λ ≤ 12(101M)⁴·2d(100M)⁵/γ₀ =
O(10²⁰)M⁹/γ₀ (a crude trace bound, Tr Q₀^{−1} ≤ n/c_Λ), and s contains O(1)M⁶R_k(ε_k + α_{0,k} + α_{1,k}); so (A) asks
g_k ≲ 10^{−20}M^{−15}·polylog(g_k)^{−1}, i.e. log₁₀β ≳ 40 + 30 log₁₀M + polylog — stronger in g than Bałaban's LFR II (1.9) row
(O(1)(M⁶R_kε_k + e^{−R_k}) ≤ γ₀/(2d(100M)^{d+1}), g ≲ 10^{−10}M^{−11}·polylog^{−1}) by a factor O(10^{10}M⁴), and far below M6's
literal-chain floor (log₁₀β_B ≥ 978, SHARED, M6 §5). Bałaban needs only a crude lower bound exp(−O(M⁴)) for the REAL denominator
(positivity); at complex d the relative comparison costs the trace factor. Condition (B) is implied by M₀ = O(1)B₅M⁶ (LFR II
p. 378) for p₀(g_k) ≥ O(1)·M^{−3/2}·(log M)^{1/2}·10^{11} — a condition of Bałaban's type. The statement "(B) is weaker than the
(1.9) row" in 2.3 is withdrawn as unproved; what stands: every added condition is of the form "γ small depending on M", in
Bałaban's order of choices.

## 3. (PI-5) — THE MULTI-STEP HISTORY PROPAGATION

3.1 THE DECAY IS ON BAŁABAN'S PAGES (READ). (a) CMP 116 (1.24), p. 7 (M3c's 150-dpi render cmp116_7.png, read today): a history term
of scale j inserted into the scale-k fluctuation integral is bounded by 8B₀C₁e^{16κ₁}α₂^{−1}g_k|B|E₀(α₁/α₃)⁵(L^jη)⁵·exp(−(κ₁ − 1)M^{−4}|Y₀∖□̃⁴|)
exp(−κd_j(X)), η = L^{−k}; p. 8 (read): "To bound the first sum, over □′ ⊂ □̃², we use the factor (L^jη)⁵ in (1.24). This yields
(6L)⁴L^jη, and the sum over j is bounded by 2(6L)⁴." So the scale-j part of the history enters the scale-k step with weight
(6L)⁴L^{−(k−j)}, and Lemma 1's bound (1.36) |V′_k(Y)| ≤ E₀ε₁C₁M^q e^{C₂κ₁}e^{−(1−2δ)κd_k(Y)} is LINEAR in the per-scale bounds
(the factor E₀ of (1.24) comes from (I.3.54) — M3c §7.4's reading). (b) CMP 119 Theorem 2 (2.43), p. 263 (read): the normalized
scale-j term, summed over a region, is ≤ E₁Σ_{n=j}^{k}(L^{j−n})^β|Γ_n ∩ Ω| for β < 1 and regular U_k; its proof (pp. 279–284, read)
is the Taylor expansion (3.69) of E^{(j)}(X, U_k, z) in the scale-n-smooth field B′ (|V′ − 1| < 3dM(1 + log L^jL^{−n})ε_n(L^jL^{−n})²,
(3.68)), the third-order remainder O(1)(L^jL^{−n})^{6−β}e^{−κd_j(X)} by Cauchy on the analyticity domain with the bound (3.48), and the
second-order term reduced by the Ward–Takahashi identities, translation invariance and Euclidean covariance to β′_j·½Σ tr F² ((3.56)–
(3.61)), β′_j = Π^{(j)}_{22,11} = β_j ((3.62)–(3.64)), cancelled by −β_jA(h_z, U_k) ((3.65)–(3.67)): "E^{(j)}(Λ_j,U_k,z) − E^{(j)}(Λ_j,1,z)
− β_jA(h_z,U_k) = O((L^jL^{−n})^{5−β})" (3.67). (c) (2.47), p. 264: boundary terms B₁2^{−(j−n)}|Γ_n|.

3.2 THEOREM PI-5 (PROVED GIVEN Theorem PI-4, Lemma M, M3b's Lemma Σ₁ (frozen part §4.2, variation part M3c §7.6), CMP 116
Lemma 1's estimate (1.23)–(1.29) and CMP 119 Theorem 2 — i.e. given Bałaban's black boxes). Let p = (D_i)_{i<K}, p′ = (D′_i)_{i<K}
be two admissible parameter sets on one reference trajectory (|D_i|, |D′_i| ≤ θ₀x_i/2, θ₀ ≤ θ_*/2, Lemma 3's condition for each and
for every point of the segment p + ζ(p′ − p), |ζ| ≤ 2). Write the history at scale k as Bałaban's multi-scale sum
E_k(p) = Σ_{m≤k}R^{(m)}(p), R^{(m)}(p) := E^{(m)}(Λ_m, ·; p) − E^{(m)}(Λ_m, 1; p) − β_m(p)A(φ_m, ·) (CMP 119 (2.25), with M3b's local
β_m(p)(z) of Lemma Σ₁), and let a_{(m)} be the least constant with |R^{(m)}(X; p′) − R^{(m)}(X; p)| ≤ a_{(m)}e^{−κd_m(X)} on the
analyticity domain (in the multi-scale sense of CMP 119 (2.26)–(2.27), with (2.43) holding for the difference with E₁ ↦ a_{(m)}E₁/E₀).
Put N_k := ½Σ_{m≤k}a_{(m)}L^{−(k−m)} (normalised so that a_{(m)} ≡ E₀ gives N_k ≤ E₀: the weight of 3.1 (a)). Then there are
β′ ∈ (0, 1) (L^{−β′} := L^{−1} + C″ε₁ — any β′ < 1 for ε₁ small) and C, independent of K, the volume, p and p′, such that
  N_k ≤ (C E₀/θ₀) Σ_{i<k} L^{−β′(k−1−i)} g_i² |D′_i − D_i|,                                                             (3.1)
and the history part of the β-function obeys
  |β_{k+1}(x_k; E_k(p′)) − β_{k+1}(x_k; E_k(p))| ≤ C(g_k² + ε₁g_k)·N_k/E₀.                                             (3.2)
PROOF. (i) THE NEW TERM IS ANALYTIC IN ITS TWO INPUTS. At step k + 1 the new normalized term R^{(k+1)} depends on the step's coupling
deviation D_k and on the history E_k. On the segment E_ζ := E_k(p) + ζ(E_k(p′) − E_k(p)) the interaction V_k[E_ζ] = V_k[E_k(p)] +
ζV′_k[ΔE_k] (linear, CMP 116 (1.33)), and by 3.1 (a) V′_k[ΔE_k] ∈ 𝒱(C₁ε₁N_k) (M3c's cone, (M.1)–(M.2), the factor M^qe^{C₂κ₁} built in).
With V_k[E_k(p)] ∈ 𝒱(E₀C₁ε₁), E₀C₁ε₁ ≤ ε_*/2 (ε₁ ≤ ε₁^max/2) and the D-term −dW ∈ 𝒱(|d|(C_W + ε_*)) (Lemma W), the cone property
puts the potential in 𝒱(ε_*) on the polydisc P := {|d| ≤ θ_*/2}×{|ζ| ≤ Z₀}, Z₀ := ε_*/(4C₁ε₁N_k). Lemma M (d): the step's
localized output is analytic on P with the bound (b) of Lemma M; its large-field part by Theorem PI-4; the counterterm β_{k+1}(d, ζ)
is analytic (M is a bounded linear functional of the localized output); THE NORMALIZED REMAINDER R^{(k+1)}(d, ζ) obeys CMP 119's
inductive bound and (2.43) UNIFORMLY ON P — by Bałaban's proof (3.48)–(3.67) at complex parameters: (3.48) is the induction; the
Ward–Takahashi identities are gauge invariance (Lemma M (c)); translation invariance and Euclidean covariance hold for the frozen
model at constant complex d and translation-covariant history (§4.2), and the variation in d(·) is M3b's Lemma Σ₁ (its rank-five
tensor vanishing by −1 ∈ W(B₄), S-A); (3.62)–(3.64) are identities of the whole-lattice expression at each parameter value.
(ii) SCHWARZ IN THE TWO INPUTS. With S := sup_P|R^{(k+1)}(X; ·)|e^{κd_{k+1}(X)} ≤ ½E₀ (CMP 116 (2.41) "O(1)C₃ε₁ ≤ ½E₀"):
|R(d′_k, 1) − R(d′_k, 0)| ≤ 4S/Z₀ (Schwarz on |ζ| < Z₀, Z₀ ≥ 2 once C₁ε₁N_k ≤ ε_*/8, which (3.1) maintains), and
|R(d′_k, 0) − R(d_k, 0)| ≤ 4S|d′_k − d_k|/θ_* (Cauchy for ∂_d on the disc of radius θ_*/4 about points |d| ≤ θ_*/4). Hence
  a_{(k+1)} ≤ 8E₀|d′_k − d_k|/θ_* + 8E₀C₁ε₁N_k/ε_*,   d_k := D_k/x_k = g_k²D_k.                                    (3.3)
The same holds for the difference's (2.43)-constant (Cauchy applies to the bound (2.43) uniformly on P).
(iii) THE OLD TERMS ARE THE SAME FUNCTIONS. For m ≤ k, R^{(m)}(p) and R^{(m)}(p′) are unchanged by step k + 1 (CMP 119 (2.25): the
history is a sum over scales of fixed functions of U, re-evaluated at the new configuration); by 3.1 (a) their contribution to the
scale-(k+1) step carries one more factor L^{−1}. So N_{k+1} = ½a_{(k+1)} + L^{−1}N_k.
(iv) THE RECURSION. N_{k+1} ≤ (L^{−1} + 4C₁ε₁E₀/ε_*)N_k + 4E₀|d′_k − d_k|/θ_* =: qN_k + b_k, q = L^{−β′} < 1, N₀ = 0; so
N_k ≤ Σ_{i<k}q^{k−1−i}b_i, which is (3.1) (θ₀ = θ_*/2, |d′_i − d_i| = g_i²|D′_i − D_i|).
(v) (3.2): M3c §7.4's argument with the history difference as the marked insertion: the first-order term ⟨V′_k[ΔE_k]⟩ has odd part
of zero mean (parity, M3c 7.3 (b2)) and even part O(g_k²)·N_k (explicit Gaussian moments of the history's second-order term — M3
§5.4 (ii)); the variance term carries ε₁g_k·N_k (Lemma M_m, moment form). ∎
THE FALSIFIER — "a marginal remnant of an earlier step that survives its renormalization" — IS NOT MET, AND WHY. The step-m
counterterm is β_m at the ACTUAL parameter value (M3b's local β, Lemma Σ₁; Lemma C′ (a)), so by (3.61)–(3.64) the second-order
coefficient of R^{(m)}(p) vanishes identically in p; there is no other marginal structure: the W(B₄)-invariant quadratic forms on
Λ²ℝ⁴ are spanned by Σ_{μ<ν}F²_{μν} (S-A, M3b §6.7: dim = 1), odd ranks vanish (−1 ∈ W(B₄)), the ε-tensor is not invariant (no θ-term),
the localized terms are gauge invariant (no dimension-2 term), and the dimension-0 term is the subtracted value at U = 1. Hence each
R^{(m)}(p) and each difference is IRRELEVANT, (3.67) uniformly in p. The remnant the falsifier asks for would require the
counterterm at a parameter other than the step's own — e.g. β_m(x_{m−1}) with the deviation D_{m−1} left in the remnant — which
leaves ∂_dβ_m·d·A(φ_m) marginal; Lemma Σ₁'s construction (the flow (6.2) absorbs exactly that term into D_m) excludes it.
CONSEQUENCE FOR THE SUMS. Σ_{j>i}(g_j² + ε₁g_j)L^{−β′(j−1−i)} ≤ C(g_i² + ε₁g_i) (g_j ≥ g_i for j > i, but x_j ≥ x_i − (j − i)(c + ρ) − 2F
keeps g_j² ≤ 2g_i² while (j − i)(c + ρ) + 2F ≤ x_i/2, and L^{−β′(j−i)} is smaller than any power of g_i beyond); so the history's
total effect on the flow of a coupling difference is Σ_i g_i²(g_i² + ε₁g_i)|D′_i − D_i|·C/θ₀ — summable (Σ_ig_i³ ≤ Cγ/(c − ρ), D4b
(E4)). The (log K)² that M3c §7.5 feared is excluded.

## 4. THE CONSEQUENCES M3c LISTED, CARRIED

4.1 LEMMA SH — THE GAUGE-WEIGHT SHELL ESTIMATE OF M3c 7.3 (d) (PROVED GIVEN Lemma M, i.e. CMP 116 §2's expansion with local
cutoff-type polymers; the slice and the residual group READ in CMP 109 pp. 252–254 via M3b's renders cmp109_252–254 and M3c
§6 (FP1)–(FP3)). Let I_α := ∫dU F(U)G_α(U)χ_k(U) be the step-(k+1) small-field integral with gauge-fixing weight α (G_α the
normalized factor Π_{y∈T^{(k+1)}}Π_{x∈B(y),x≠y}z_α^{−1}exp[−(1/α)(1 − Re tr U(y,x))], CMP 109 (0.15), (2.5)), F the R-invariant rest
(Wilson action, earlier effective action, δ-constraints), χ_k = Π_bχ(|B′(b)| < ε₁) on the physical angle (CMP 109 (2.9)). For
1/α, 1/α′ ∈ [x_k/2, 2x_k]: log I_α − log I_α′ = Σ_X Δ(X), a sum of localized terms analytic on Bałaban's domain with
|Δ(X)| ≤ 2C₁e^{−c₁ε₁²/g_k²}e^{−κd_{k+1}(X)}.
PROOF. (i) SLICE. With Bałaban's contours Γ_{y,x} (centred blocks, CMP 109 (0.3)), every configuration is uniquely U = u·s with
s(Γ_{y,x}) = 1 and u in the residual group R (u(y) = 1 at coarse sites — "exactly the group under which the underintegral expression
in (0.13) is still invariant", p. 254); dU = ds du (axial gauge: Jacobian 1); F and the constraints are R-invariant; and
G_α(u·s) = Π_x g_α(u(x)), g_α(u) := z_α^{−1}e^{−(1/α)(1 − Re tr u^{−1})}, a product of probability densities. So
I_α = ∫_S ds F(s)·E_α[χ_k(u·s)], E_α := ⊗_x g_α(u(x))du(x).
(ii) DEFECTS. χ_k(us) = Π_b[χ_b(s) + Δ_b(u,s)], Δ_b := χ_b(us) − χ_b(s) ∈ {−1, 0, 1}, so
I_α = Σ_P ∫_S ds F(s)Π_{b∉P}χ_b(s)·E_α[Π_{b∈P}Δ_b(u,s)], and the P = ∅ term does not depend on α.
(iii) THE DEFECT BOUND. The background V^{(k)} is a function of the coarse variables, R-invariant; so for b = (x, x′) and
u(x) = e^{iθ_x}, |B′_{us}(b) − B′_s(b)| ≤ 2(|θ_x| + |θ_{x′}|) for small angles. Hence Δ_b ≠ 0 forces |B′_s(b)| ≥ ε₁/2 or
max(|θ_x|, |θ_{x′}|) ≥ ε₁/8. Under g_α (1/α ≥ x_k/2, 1 − Re tr u ≥ c|θ|²): E_α[1(|θ_x| ≥ ε₁/8)] ≤ Ce^{−c₂ε₁²/g_k²}. Each site
ends at most 2d bonds, so, choosing for each defect bond either its shell event or a large-angle endpoint,
|E_α[Π_{b∈P}Δ_b]| ≤ Σ_{P₁⊂P}Π_{b∈P₁}1(|B′_s(b)| ≥ ε₁/2)·(Ce^{−c₂ε₁²/g_k²})^{|P∖P₁|/(2d)}, uniformly for 1/α ∈ [x_k/2, 2x_k].
(iv) THE SHELL EVENTS. 1(|B′_s(b)| ≥ ε₁/2) ≤ exp(−½γ₂(ε₁/2)²/g_k² + ½γ₂|B_s(b)|²) in the scaled field — CMP 116 (2.22) with
ε₁ ↦ ε₁/2, absorbed into the Gaussian as in (2.23)–(2.25).
(v) EXPANSION. Undo the slice inside each P-term with a FIXED reference weight α₀: ∫_S ds F(s)Φ_P(s) = ∫dU F(U)G_{α₀}(U)Φ_P(s(U))
(s(U) = u(U)^{−1}U is local within blocks), so the P-sum is CMP 116 (2.3)'s cutoff decomposition with the local factor
Π_{b∉P}χ_b(s(U))E_α[Π_{b∈P}Δ_b] in place of χ_{k,Y₀}χ^c_{k,P}, bounded as (iii)–(iv); Lemma M's proof (CMP 116 §2) runs verbatim
and every cluster without a defect polymer is independent of α; every cluster with one carries ≤ C₁e^{−c₁ε₁²/g_k²},
c₁ := min(γ₂/8, c₂/(2d)). ∎
CONSEQUENCE. M3c 7.3 (d) holds: |β_{k+1}(x′) − β_{k+1}(x)| ≤ (2g_k²/θ₀)[C₁e^{−c₁ε₁²/g_k²} + C(g_k² + ε₁g_k)]|x′ − x| + 3C₁e^{−c₁ε₁²/g_k²}
for real x′ with |x′ − x| ≤ θ₀x/2, in CMP 109/116's model. In CMP 119's complete model the thresholds ε_j = g_jp₀(g_j) are
coupling-dependent; the own and the reference constructions then differ also by M3b's Lemma P3 shell, ≤ C exp(−c(log g_j^{−2})^{2p₀})
per unit (smaller than every power of g) — added to the tail below.

4.2 THE FROZEN PART OF LEMMA Σ₁ — PROVED GIVEN Theorem PI-4 (at constant D, where Lemma 3 is void) and the CMP 109 inputs Bałaban's
proof cites ((I.1.18), (I.3.34), (I.4.14)–(I.4.15), (I.5.16)/(I.5.37)). The frozen model (D ≡ D_z at every step) is translation
invariant and W(B₄)-covariant (M3b §15.1, S-A); Theorem PI-4 closes its large-field steps; Lemma M its small-field steps; so CMP 119's
proof of (2.43) (pp. 279–284, read: (3.48) the bound from the induction; (3.49)–(3.56) the Ward–Takahashi reduction — gauge
invariance, an identity in the background valid at every complex parameter; (3.57) translation invariance ("hence Π^{(j)}_{μν,κλ} is
independent of z", p. 281), true for the frozen model; (3.58)–(3.61) Euclidean covariance — A is Euclidean invariant, so the
D-term is; (3.62)–(3.64) the identification β′_j = β_j at each parameter value; (3.65)–(3.67) the cancellation) applies verbatim at
constant complex D. The variation part (M3c 7.6, M3b §6.5) needs only the small-field analyticity in t of D_z + t(D − D_z) (Lemma M);
the large-field terms are not renormalized. LEMMA Σ₁ (M3b §6.5): PROVED GIVEN Bałaban's black boxes.

4.3 PROPOSITION E1-a — THE BARE COUPLING IS UNIQUE UP TO THE SHELL (PROVED GIVEN Theorem PI-4, Theorem PI-5, Lemma C′ (a)–(c) (M3c),
Lemma SH, Lemma P3 (M3b) — i.e. given Bałaban's black boxes and Lemmas M, W). Let x₀ < x′₀ both reach x_K = x′_K = X. Then
  x′₀ − x₀ ≤ δ_bare := 8 Σ_{j≥0} [C₁e^{−c₁ε₁²(X − 2F + j(c−ρ))} + Ce^{−c(log(X − 2F + j(c−ρ)))^{2p₀}}],   uniformly in K.
PROOF. D_j := x′_j − x_j (real; on the reference x_j by the device, Lemma 2 not even needed — Im Q_d = 0). The step shift splits as
[own − reference construction at x′_j] (Lemma SH and P3: ≤ t_j := 4C₁e^{−c₁ε₁²/g_j²} + 4Ce^{−c(log g_j^{−2})^{2p₀}}) + [coupling
Lipschitz at fixed history] (Lemma C′ (c): ≤ C′g_j^{2+a}|D_j|, a = 1) + [history] ((3.2) and (3.1): ≤ C(g_j² + ε₁g_j)θ₀^{−1}
Σ_{i<j}L^{−β′(j−1−i)}g_i²|D_i|). With S_j := max_{i≤j}|D_i| and Σ_{i<j}L^{−β′(j−1−i)}g_i² ≤ Cg_j² (g_i ≤ g_j):
|D_{j+1} − D_j| ≤ w_jS_j + t_j, w_j := C′g_j^{2+a} + C″(g_j² + ε₁g_j)g_j², Σ_jw_j ≤ Cγ^a (Σ_jg_j³ ≤ Cγ/(c − ρ), D4b (E4)). Upper
Gronwall: S_K ≤ e^{Cγ^a}(|D₀| + Σ_jt_j). Lower: |D_K| ≥ |D₀| − Σ_j(w_jS_j + t_j) ≥ |D₀|(1 − Cγ^ae^{Cγ^a}) − (1 + Cγ^ae^{Cγ^a})Σ_jt_j.
D_K = 0 gives |D₀| ≤ 2Σ_jt_j for γ small; x_j ≥ X − 2F + (K − j)(c − ρ) (Theorem 2's profile) sums the tails. ∎
WITH BAŁABAN'S ANALYTIC-VARIANT CUTOFF (g_k/γ_k)ε₁ (CMP 109 p. 266) the first tail vanishes (M3b 10.1); the P3 tail remains in the
complete model and is smaller than every power of g.
PROPOSITION E1-b (M3b 10.2, trajectory convergence) is PROVED GIVEN the same: its input "(PI)_H" with the factor L^{−β(j−i)} is
Theorem PI-5.

4.4 THEOREM S₁ (M3b §5) — STATUS AFTER THIS FILE. (S₁)(i)–(iv) are PROVED GIVEN Bałaban's black boxes (CMP 99's random-walk
expansions, which Lemma W also uses; CMP 102 Sect. G with (189)–(190); CMP 116 Lemmas 1–2; CMP 109 Theorem 3; CMP 119 §3 and
LFR I–II as stated) and Lemma M, on the τ-disc
  |τ|·‖h̃‖_∞ ≤ θ₀X/(4e^{Cγ^a})   AND   |τ| ≤ r_τ of (2.2),   θ₀ := min(θ_*/2, 1/4),
with two precisions to M3b's statement: (a) the effective coupling field D_k is the flowed field in small-field regions and the
LAGGED field in large-field regions (renormalization only in small-field regions — the same lag as Bałaban's own g_k(·)); (b) the
R-operation is R_D. Nothing in (S₁) uses Lemma SH (that enters only E1-a).

4.1′ PRECISIONS TO LEMMA SH (dated, 2026-11-02, after reading CMP 109 pp. 252–255, 266 on M3c's renders today; 4.1 not edited).
(a) The gauge-fixing factor of record carries its own cutoff: (0.15), p. 254, (1/z)∫du(x)exp[−(1/α)[1 − Re tr U(y,x)u^{−1}(x)]]
χ({|U(y,x)u^{−1}(x) − 1| < ε₀}) = 1, and (0.16), p. 255, keeps χ({|U(y,x) − 1| < ε₀}) in the transformation. So
g_α(u) := z_α^{−1}e^{−(1/α)(1 − Re tr u)}χ(|u − 1| < ε₀) — still a probability density; (iii)'s tail bound holds for ε₁/8 < ε₀.
(b) The slice is Bałaban's: with the averaged contour variables U(y,x) = M({U(Γ)}_{Γ∈G(y,x)}) (0.11) and the covariance
M({uU_jv}) = uM({U_j})v (0.6), the transformation u(x) := U(y,x) (u(y) = 1) maps U to the slice {U(y,x) = 1}; dU = J(s)ds du with
J independent of u (Haar invariance), J absorbed into F. (c) The background V^{(k)} = M^k(U_{k+1}) is a function of the coarse
variables, which R fixes; so the fluctuation V′ = V(V^{(k)})^{−1} moves under v ∈ R only by the end-point factors, and
|B′_{V^v}(b) − B′_V(b)| ≤ C(|θ_{b−}| + |θ_{b+}|) (Ad-invariance of the norm). (d) Step (v) produces, besides the defects of (ii), the
defects χ_b(s(U)) − χ_b(U) (the cutoff on the slice representative versus on U), of the same type under G_{α₀}; the expansion is
CMP 116 (2.3)'s with local defect polymers, each bounded by (iii)–(iv). STATUS of Lemma SH: PROVED GIVEN Lemma M's expansion
extended to local defect polymers whose activities are bounded as in (iii)–(iv) — an extension of the same kind as (2.3)'s cutoff
decomposition (P-polymers with the factor e^{−½γ₂(ε₁²/g_k²)|P|}), which Lemma M's proof covers verbatim once the factor is replaced.
(e) R_D AND THE LAG. Bałaban's R resets the lagged reference coefficient on Z to 1/g_k² and drops the discrepancy (K3) into the small
terms; R_D may do the same for D (the lag ≤ Ng_k^{2+a}θ₀x_k gives a discrepancy term ≤ Ng_k^{2+a}θ₀·O(1)M¹⁴R_k⁴p₀(g_k)² — small), so
that after R_D the coupling field on the renormalized region is the flowed one.

## 5. THE ULTRAVIOLET HALF AFTER M3b, M3c, M3d — STATUS

5.1 PROVED GIVEN BAŁABAN'S BLACK BOXES. The black boxes, named: [BB-a] CMP 99's generalized random-walk expansions of the background
propagators and of all operators determining Δ_k (CMP 116 p. 13; Theorems 3.7–3.10 [13] cited by CMP 119 p. 276); [BB-b] CMP 102
Sect. G, the minimal configuration's analyticity and the exponential decay (189)–(190) of its functional derivative, "We do not
perform these calculations here" (p. 308); [BB-c] the estimates of CMP 109 Theorem 3, CMP 116 Lemmas 1–2, CMP 119 §3 and LFR I–II
as stated (including the steps Bałaban only sketches: LFR II p. 368 "They should be obvious"; CMP 119 p. 279 "treated in exactly
the same way"; the convergence constant of [26] used at CMP 116 (2.39)). Given [BB-a]–[BB-c]:
 (1) Lemma M, Theorem BB4*, the moment form (a = 1), Lemma W, Theorem BB4*-D, Lemma FP, Lemma C (sup and moment), Lemma C′ (a)–(c)
     [M3c §§2–7];
 (2) Theorem PI-4: Bałaban's large-field steps close at a complex Wilson coefficient field, with R_D [this file §2];
 (3) Lemma Σ₁ — CMP 119 (2.43) with a coupling field: frozen part (§4.2) and variation part [M3c 7.6]; hence (PI) of M3b §8 whole;
 (4) Theorem PI-5: the multi-step history propagation with decay L^{−β′(k−i)} [§3];
 (5) Theorem S₁ (i)–(iv) of M3b §5 on the τ-disc of §4.4: the source of the action density is a complex coupling field carried
     uniformly in the cutoff, the vacuum part local, the finite part analytic and bounded uniformly in K, separated-support
     correlations decaying exponentially at every scale below the unit scale; the multiplier m_K → 1 + (b₁/b₀)g²_{YM,K} + O(g⁴);
 (6) Lemma SH (§4.1, 4.1′(d)) and with it Lemma C′ (d) [M3c 7.3 (d)];
 (7) Proposition E1-a (bare coupling unique up to a K-independent shell, §4.3) and Proposition E1-b (the renormalized trajectory
     converges, rate L^{−β′(K−i)});
 (8) Proposition D∞ [M3b §9.4]: the gap for fine vectors needs Hypothesis I plus the averaged fibre clauses, not (D).
5.2 WHAT REMAINS, EACH AT ITS TRUE STATUS.
 (R1) THE BLACK BOX [BB-b] — CMP 102 (189)–(190), OPEN in the literature (Bałaban states it without the calculation). It enters
      Lemma 1 of CMP 116 (via (1.17)'s smallness after division by g_k², "the inequality (190) [15]", LFR II p. 360), the H-function
      decay used at every site T3, R3 (K4), and Lemma B's strip analyticity. ATTEMPT AND ROUTE: M3R's lead — derive (190) from CMP 99's
      background propagator bounds (3.127)–(3.133) [BB-a], since the functional derivative of the minimizer solves a linear equation
      whose operator is the constrained background Laplacian H*ΔH that CMP 99 inverts with exponential decay.
 (R2) THEOREM 2's REMAINING INPUTS (M3R item 2c): the gauge-fixed form of Lemma B's stage identity (residual-gauge and coarse-gauge
      zero modes; Lemma FP's slice (FP3) is the tool — it already splits E = G ⊕ T exactly for the step), the infrared identification
      (B1) (the record's proof on paper, not re-done line by line), the alias constants through CMP 102's derivative bounds, and Lemma D
      (coupling-uniform convergence in the localized norm) — OPEN, named by M3R; none touched here.
 (R3) THE TWO-CUTOFF COMPARISON OF THE COMPLETE MODEL (M3b 10.3) — OPEN. Its small-field part is Theorem PI-5 at real parameters; its
      large-field part needs the R-terms' and B-terms' cross-cutoff differences: by CMP 119 (2.44) and (2.47) these carry R₁g_j^{κ₀} and
      B₁2^{−(j−n)} per unit volume, so the deep-past large-field contributions DECAY as the cutoff is removed — the next object is the
      statement that R_D is Lipschitz in its input density in the norm of (2.43)–(2.47), proved by the same Schwarz argument as §3.2 (ii)
      on the T′-bounds R5 (upper bounds only are used, so the Lipschitz constant is the T′_{k,Re}-bound times the input difference).
 (R4) (E2) orientation universality — an infrared statement (M3b 11.3); the UV half delivers the O(4)-invariance of every marginal
      term (S-A) and nothing more.
 (R5) Hypothesis II in published form for SU(2) — M3's (S) for general observables and (P_LF); (S₁) gives it for the 0⁺⁺ channel
      (action-density sources); (P_LF) — the large-field probability bound — is now within reach: Theorem PI-4's R5 bounds are
      exactly the T′-bounds (1.79)–(1.89) at complex coupling, and (P_LF) asks for the same bounds as probabilities.
 (R6) The crossover (Hypothesis I at a_c from 2.2–2.3) — not ultraviolet.

## 6. CROSS-FIELD UNIFICATIONS FOUND

(U1) BAŁABAN'S R-OPERATION IS A CHANGE OF REFERENCE MEASURE WITH A LOCAL NORMALIZATION, AND THE COMPLEX COUPLING MAKES IT A DEFORMED
CONTOUR. R preserves integrals because the new factor and its denominator are one weight; at complex coupling the weight's integral
is a complex Gaussian, whose size is controlled not by positivity but by rotating the real contour into the steepest-descent
(Lefschetz-thimble) contour M_d·ℝ^n (Lemma 2 (iv)) — the same device that makes complex Gaussian integrals and the Picard–Lefschetz
treatment of complex actions finite without a sign problem. The cost the crude modulus bound would pay, e^{nθ₀²/4}, is the
"sign-problem" factor |det Q|/det Re Q of lattice simulations at complex coupling; Lemma 2 shows Bałaban's finite-region
structure (n ≤ 12(101M)⁴) removes it entirely.
(U2) THE ONLY POSITIVITY BAŁABAN NEEDS IS POINTWISE. Every use of the density's positivity in the main line is an UPPER bound
(LFR II (1.73), (1.89)); every lower bound he takes from the action is a sum over plaquettes of nonnegative terms (Lemma 1). Such a
proof is stable under any complex deformation of the coefficients with Re ≥ (1 − θ)·(original) pointwise — the structure of
"positivity-improving" arguments in constructive QFT under complex external fields (Lee–Yang-type disc statements: the large-field
suppression is a pointwise lower bound on Re of the action, hence survives a complex field in a disc). The one exception, the
normalized operation (1.75), is exactly where a Lee–Yang zero could sit — and it is the one Bałaban's main line never uses.
(U3) THE HISTORY DECAY IS A CONTRACTION OF THE RG LINEARIZATION ON IRRELEVANT DIRECTIONS, MADE QUANTITATIVE BY CAUCHY. (3.1) is the
discrete Duhamel formula N_{k+1} = qN_k + b_k of a linear RG map whose irrelevant spectrum is ≤ L^{−1} (Bałaban's (L^jη)⁵·L^{−4} per
step) perturbed by the history-to-output Lipschitz constant ∝ ε₁; the marginal direction (F²) is removed exactly by the counterterm
at the actual parameter, which is why no (log K)² appears — the same mechanism as the stable-manifold theorem for hyperbolic fixed
points (the coupling is the centre direction, carried by the flow; the history lives in the stable manifold).

## 7. THE LEDGER (this agent's rows)

| Item | Status | Where |
|---|---|---|
| LFR I (175–202), LFR II (355–392), CMP 119 §3 (264–284) every page on image | READ | §0, §1, 1.4–1.5 |
| where the Wilson coefficient enters: K1–K5; the T′ positivity (1.73)–(1.75); CMP 119 (3.15), p. 277 | READ | §1.2, 1.3, 1.5 |
| M3c's (PI-4) falsifier (additive |Im A| bound × θ₀x_k) | present in form at LFR II (1.47), NOT MET in substance (η = O(g²·small)) | §2.0 |
| R with a reference denominator at complex D | FAILS (uncancelled θ₀M¹⁴p₀²) — replaced by R_D | §2.1 |
| Lemma 1 (modulus domination), Lemma 2 (R_D denominator, contour rotation), Lemma 3 (R-region variation, τ-disc (2.2)) | PROVED (Lemma 2 given Bałaban's (1.6)–(1.9)) | §2.1 |
| Theorem PI-4 | PROVED GIVEN [BB-a]–[BB-c], Lemmas M, W | §2.2 |
| lower bound (1.74)–(1.75) at complex D | NOT AVAILABLE, NOT NEEDED (used only in (1.103)–(1.104)) | §2.2 R5 |
| Theorem PI-5 (decay L^{−β′(k−i)}; (3.1)–(3.2)); falsifier "marginal remnant" | PROVED GIVEN PI-4, Lemma M, Σ₁, Bałaban's Thm 2; falsifier NOT MET | §3.2 |
| Lemma SH (gauge-weight shell) | PROVED GIVEN Lemma M with local defect polymers | §4.1, 4.1′ |
| frozen part of Σ₁; Lemma Σ₁ | PROVED GIVEN black boxes | §4.2 |
| Prop. E1-a; Prop. E1-b | PROVED GIVEN black boxes | §4.3 |
| Theorem S₁ (i)–(iv) | PROVED GIVEN black boxes, on the τ-disc of §4.4 | §4.4 |
| 2.3's comparison with M6 | WITHDRAWN in part (2.3′): Lemma 2 (A) is a condition γ ≲ 10^{−20}M^{−15}·polylog^{−1}, of Bałaban's type | §2.3′ |

## 8. THE PRECISE NEXT OBJECT

CMP 102 (190) from CMP 99 (3.127)–(3.133): the functional derivative of Bałaban's minimal configuration U_k(V) satisfies
δU = H_k(U)·δV with H_k(U) built from the inverse of the constrained background operator; prove |(δU/δV)(x, y)| ≤ B₃e^{−δ₀d(x,y)}
on the analyticity domain from CMP 99's random-walk bound on that inverse. It is the last unproved estimate under every row of 5.1.

## 9. DATED CORRECTIONS AND PRECISIONS (2026-11-02, after §§0–8 were written; nothing above edited)

9.1 CMP 119 §2's INDUCTIVE ASSUMPTIONS, READ (pp. 255–262 on image today: (2.13)–(2.42)). The hypothesis Theorem 1 closes on is: the
representation (2.18) ρ_k = Σχ_k(Ω_k)T_k exp A_k; the structure (2.19)–(2.22) of T_k (integrations, characteristic functions,
δ-functions, gauge fixing, the reference Gaussians of (2.21)); the effective action (2.23) −A(1/g_k², U_k) + E_k + R_k + B_k − E_k with
the coupling functions (2.24); the localized representations (2.25)–(2.27) with (i) locality, (ii) analyticity on U^c_j(X, α_{0,j}, α_{1,j}),
(iii) gauge invariance, (iv) the UPPER bound (I.1.18); Euclidean covariance (2.29), (2.32)–(2.33); |R^{(j)}| ≤ g_j^{κ₀}e^{−κd_j(X)} (2.31);
|B^{(j)}| < B₀e^{−κd_j(X)} (2.42). NO CLAUSE ASSUMES POSITIVITY OF THE DENSITY OR A LOWER BOUND ON T_k; positivity is a statement
PROVED in LFR I (0.3) for the sole purpose of the R-denominators, which Lemma 2 replaces. R5 of §2.2 therefore stands with the
inductive hypothesis as stated. ONE CLAUSE CHANGES FORM: the Euclidean covariance (2.29) holds at constant D (the frozen models
of §4.2) and is replaced for variable D by Lemma Σ₁'s variation estimate (M3b §6.5, M3c 7.6) — it is used only in the proof of
Theorem 2 (CMP 119 p. 281's translation invariance, (3.58)), where Σ₁ already supplies the replacement. (2.31) at complex D:
R′^{(k)} ≤ e^{−(1−θ₀/2)p₀(g_k)}e^{−κd_k(X)} ((1.100)_D) ≤ g_k^{κ₀}e^{−κd_k(X)} for g_k small.

9.2 LEMMA M IN THE COMPLETE MODEL (Lemma M_c) — NAMED INPUT MADE EXPLICIT, AND PROVED GIVEN [BB-c]. M3c proved Lemma M in CMP 116's
model (domain |B| < ε₁/g_k, absolute ε₁, α₀, α₁). Theorem PI-4's sites T2, R1 use it inside CMP 119's complete model, whose small-field
step has the fluctuation domain (3.43) {|A| < C₁p₁(g_k)} for terms near large-field regions, analyticity radii α_{i,k} = g_kC_i(log g_k^{−2})^{q_i}
(2.28), and polylog-dressed boundary constants ("(2.42), with the constant B₀ replaced by O(p₀³(g_k)) … the multiplication by g_k
yields small bounds", p. 278). THE CHECK (pp. 275–278, read): the polylog factors enter the BOUNDS OF TERMS, not the conditions that
define the admissible cone parameter. In M3c's classification (§1.3): RADIUS sites change — the domain ε₁/g_k ↦ C₁p₁(g_k), the cutoff
tail e^{−½γ₂ε₁²/g_k²} ↦ e^{−½γ₂C₁²p₁(g_k)²} (so t₂ ↦ exp(−(1/20)γ₂C₁²p₁(g_k)²), and p. 19's "(1/20)γ₂ε₁²/γ² ≥ 4κ" ↦ (1/20)γ₂C₁²p₁(g_k)² ≥ 4κ,
true for g_k small); FACTOR sites change — the interaction's own bound E₀C₁ε₁ ↦ E₀C₁·g_kC₁p₁(g_k) (smaller: the factor is the sup of
g_k|A| on the domain, CMP 116 (1.20)–(1.21), (1.29)); the Gaussian absorption α₅ = O(1)e^{−δ₀M/3} + O(α₀ + α₁) + O(1)α₄ + γ₂ ↦ the same
with α_{i,k} (smaller). The constants defining ε_* — α₄, α₆, M, κ, κ₁, L and the [26] constant (M3c §2) — are untouched; the D-term's
quadratic part 𝒲 has an absolute bound C_W independent of the domain (Lemma W (ii)), and W_{≥3} ∈ 𝒱(O(1)g_kp₁(g_k)³). So the
cone property, Theorem BB4*-D and the joint analyticity hold in the complete model with the SAME absolute ε_*, θ_*. The terms whose
domains meet a large-field region go to the boundary terms, whose bounds may carry the polylogs. STATUS: Lemma M_c is PROVED GIVEN
[BB-c] (it inherits Bałaban's own statement that the complete model's expansion is CMP 116's "with minor changes", p. 275, and
"with the analyticity space (I.6.34) replaced by the space (3.43)", p. 276); it is added to [BB-c] in 5.1 and in the final status.
The β-values of record are CMP 109's up to M3b's Lemma P3 shell (unchanged).

9.3 CORRECTION — THE SUPPORT OF ζ₀ IS A COMPONENT X_i OF Z (DIAMETER ≤ 100MR_k), NOT Λ. LFR II (1.100), p. 201 of LFR I: "ζ_i ∈ C₀^∞(X_i),
ζ_i changes from 0 to 1 in a neighborhood of ∂X_i^{~−2}", X_i a component of Z, inside a cube of size 100MR_k (LFR I p. 177 (i)); the
bound 100M of (1.73) is for Λ, the integration region. Consequences: (a) §2.1's "not absorbed" estimate becomes θ₀(100MR_k)⁴·O(1)B₃²B₅²M¹⁰
A₀²p₀² — only stronger; R_D stands. (b) Lemma 2: n (the dimension of the B′-space on Λ) is unchanged; the weighted pieces sum over
supp ζ₀, but every B′-dependent term carries H₁B′, which decays as B₀e^{−δ₀d(p,Λ)} away from Λ (CMP 102 (190) via (1.17), [BB-b]),
so the weighted linear term obeys |ℓ_{d−d_Λ}(B′)/g_k| ≤ O(1)P(g_k)·Σ_p|d(p) − d_Λ|e^{−δ₀d(p,Λ)}·Σ_b|B′(b)| ≤ O(1)P(g_k)·ω_Λ·√n‖B′‖,
ω_Λ := sup_p |d(p) − d_Λ|e^{−δ₀d(p,Λ)/2}·(Σ_pe^{−δ₀d(p,Λ)/2}) ≤ O(1)(M + δ₀^{−1})⁴·|∇d|_k(103M + 4δ₀^{−1}) — R_k does not enter. On the
cutoff domain this is ≤ O(1)M^{10}P(g_k)²ω_Λ/M⁴; it fits s(g_k, M) → 0 when ω_Λ ≤ δ_*(g_k, M)·M⁴. The numerator's linear terms
(1.20), (1.28) carry H″B with B supported in B₀ ⊂ Λ: the same weight. (c) Lemma 3 holds as written with "sup over supp ζ₀" replaced by
the exponentially weighted variation ω_Λ around Λ (diameter of the effective region O(M + δ₀^{−1}), no R_k). For a safe margin one may
also demand the plain sup over supp ζ₀ (diameter 102MR_k): then r_τ of (2.2) acquires a further factor R(γ)^{−1} — still independent of
K and of the volume. (d) The (K3)-type lag term of 4.1′(e) is summed over supp ζ (size (100MR_k)⁴), already included in its bound.

9.4 LEMMA 2 (v), CONDITION (B), STATED WITH THE SIDE SURFACE. The homotopy's side surface {M_tB″ : |B″| = R, t ∈ [0,1]} has area
≤ O(θ₀R)·|S^{n−1}|R^{n−1}; so (B) reads c_ΛR²/16 ≥ n log(16λ_max(Q₀)/c_Λ) + n log(CR) + 2 — the same type ("p₀(g_k) large depending on
M"), with an extra n log(M⁶p₀(g_k)).

9.5 THE FALSIFIER OF THE REMAINING ESTIMATE (CMP 102 (190)). If the decay δ₀ of CMP 99's background propagators (3.127)–(3.133) did
NOT transfer to the minimizer's functional derivative — i.e. a configuration in the small-field domain at which (δU_k/δV)(x, y)
decays slower than e^{−δ₀d(x,y)} uniformly in k (e.g. a zero mode of the constrained Hessian H*ΔH near-degenerate on the
complexified domain, or a gauge-fixing degeneracy of the Landau gauge used in Sect. G) — then the H-functions of LFR II (1.17),
(1.24), (1.46) would lose their e^{−½δMR_k} and L^{−N} factors, the terms "small even after dividing by g_k²" would not be small, and
both Bałaban's induction and Theorem PI-4 would fail at (K4).

9.6 THE LEDGER, AMENDED (rows of §7 that change).
| Item | Status | Where |
|---|---|---|
| CMP 119 §2's inductive assumptions (pp. 255–262) | READ — no positivity or lower bound assumed; (2.29) at frozen D | 9.1 |
| Lemma M_c (Lemma M in the complete model, same absolute ε_*, θ_*) | PROVED GIVEN [BB-c] | 9.2 |
| Theorem PI-4 | PROVED GIVEN [BB-a]–[BB-c] (with Lemma M_c in [BB-c]) and Lemma W | 2.2, 9.2 |
| supp ζ₀ (100MR_k, not 102M) | CORRECTED; Lemma 3 holds with the weighted variation ω_Λ; R_D's necessity only strengthened | 9.3 |
