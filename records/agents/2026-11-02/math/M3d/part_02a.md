
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
