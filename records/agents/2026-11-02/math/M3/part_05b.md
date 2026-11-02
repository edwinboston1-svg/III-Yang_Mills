
### 5.3 LEMMA B — the transient is bounded (the record's proof on paper, re-derived; one identity added; the analyticity clause verified at the source)

STATEMENT. β_k(0) := lim_{g_{k−1}→0} b_k exists, is history-free, and equals a(k) = c + f(k) − f(k − 1) with f(0) = 0,
f(k) = c_W − c(S_k), and |f(k)| ≤ F < ∞ for all k; here S_k is the tree-level k-step blocked action (Bałaban's A(U_k(V)), the
fine Wilson action at the minimal configuration), and for a gauge-invariant lattice action S, c(S) := lim_{P→0}[Π_S(P)/P² −
8b₀ ln(1/|P|)], Π_S the transverse one-loop vacuum polarisation of S in its own lattice units; c_W := c(Wilson).

(B0) HISTORY-FREENESS. In the rescaled fluctuation (B = g_{k−1}B′) the Gaussian part of step k is (1/g_{k−1}²)·S_{k−1}″ at
order one, and the history terms E_{k−1} enter the fluctuation's quadratic form at relative order g² (CMP 109 p. 256; d4 §14,
check (1)); so at g → 0 the step is the constrained Gaussian of S_{k−1} alone and β_k(0) depends on k only.

(B-i) THE STAGE IDENTITY AT ONE LOOP (proved; the sign checked). Locally after gauge fixing, U ∈ ℝⁿ, Q : ℝⁿ → ℝᵐ smooth with
surjective differential, S smooth with a non-degenerate constrained minimum U*(V) on {Q = V}. Then
  ∫ dU δ(Q(U) − V) e^{−S(U)/g²} = e^{−S_k(V)/g²} (2πg²)^{(n−m)/2} [det S_k″(V) / det H_λ]^{1/2} (1 + O(g²)),
with S_k(V) = S(U*(V)), λ = S_k′(V), H_λ = S″(U*) − Σ_a λ_a Q_a″(U*). Proof: Laplace's method on the constraint manifold gives
(2πg²)^{(n−m)/2} e^{−S_k/g²} det(dQdQᵀ)^{−1/2} det_{ker dQ}(H_λ)^{−1/2} (the δ-function's coarea factor, and the Hessian of S on
the manifold at a constrained critical point is H_λ on ker dQ). The bordered determinant gives
det[[H, dQᵀ], [dQ, 0]] = det H · det(−dQH⁻¹dQᵀ) = (−1)^m det(dQdQᵀ) det_{ker dQ}(H); differentiating the stationarity equations
(S′ = λ·dQ, Q = V) gives S_k″ = (dQ H_λ⁻¹ dQᵀ)⁻¹. Hence det_{ker} H_λ = det H_λ / (det(dQdQᵀ) det S_k″), and the coarea factor
CANCELS: det(dQdQᵀ)^{−1/2} det_{ker}(H_λ)^{−1/2} = (det S_k″/det H_λ)^{1/2}. ∎ So the one-loop effective action of the k-step
transformation is W_k⁽¹⁾(V) = ½ log det H_λ(U*(V)) − ½ log det S_k″(V) + const (Addendum II §2's identity, re-derived).

(B-ii) COMPOSITION. Hard δ-constraints compose, ∫dU′δ(Q(U′) − V)∫dU δ(Q_{k−1}(U) − U′)e^{−S} = ∫dU δ(Q_k(U) − V)e^{−S} with
Q_k = Q ∘ Q_{k−1} (Bałaban's k-step average, CMP 95 (1.68)); so at one loop Σ_{i≤k} β_i(0) = β(Q_k), the second moment of
W_k⁽¹⁾, and β_k(0) = β(Q_k) − β(Q_{k−1}).

(B-iii) THE IDENTIFICATION β(Q_k) = c·k + c_W − c(S_k) (the step the record states; the two terms it leaves implicit, proved
here). Put V = exp(iεa), a a transverse coarse plane wave of momentum P, and read the ε²P² coefficient as P → 0.
 – The Lagrange term. ½ log det H_λ − ½ log det S″(U*) = −½ Tr(S″(U*)⁻¹⟨λ, Q″(U*)⟩) + O(λ²). λ = S_k′(V) = O(εP²), and the
   factor it multiplies is a gauge-covariant one-loop response which, by locality, is analytic in P and, by gauge covariance,
   vanishes at P = 0; with the hypercubic and reflection symmetry of CMP 109's centred averaging the transverse ε² term is
   O(ε²P⁴). No P² contribution. (O(λ²) = O(ε²P⁴).)
 – The aliases. U*(V) = H_k(εa) + O(ε²), and the fine one-loop functional is translation-invariant on the fine lattice, so its
   ε² term is Σ_l Π_fine(P + 2πl)·|Ĥ_k(P, l)a|²_⊥ over the aliases l. For l = 0, Ĥ_k(P, 0) = 1 + O(P²) (the centred average has
   symbol 1 + O(P²), and the minimal configuration of a smooth coarse field equals its smooth interpolant to that order), giving
   Π_fine(P)(1 + O(P²)) = [8b₀ ln(L^k/|P|) + c_W]P² + O(P⁴ ln P) (P in coarse units, L^k the fine-to-coarse ratio). For l ≠ 0:
   write U* = U_smooth + ψ with U_smooth the smooth interpolant; the Euler–Lagrange equation d*dA = Q*λ makes ψ solve
   d*dψ = r with r = Q*λ − d*dU_smooth = O(εP²), varying at the block scale, so the aliased curl of U* is O(εP²) and its
   contribution is O(ε²P⁴). No P² contribution.
 – Hence the ε²P² coefficient of W_k⁽¹⁾ is [8b₀ ln(L^k/|P|) + c_W] − [8b₀ ln(1/|P|) + c(S_k)] + o(1), and β(Q_k) =
   8b₀ k ln L + c_W − c(S_k): f(k) = c_W − c(S_k), f(0) = 0. ∎

(B-iv) BOUNDEDNESS (the record's (B1)+(B2), Addendum II §§3, 7, 8, accepted at its strength). (B1): c is bounded on the class
𝒮(γ₀, κ, M) — gauge-invariant lattice actions with minimum at the trivial configuration, kernels analytic in a strip of width
κ with bound M, transverse ellipticity Δ ≥ γ₀p̂², invariance under lattice translations, rotations and reflections (THE
SYMMETRY CLAUSE, load-bearing: without it a one-loop term iε_{μνρσ}n_σP_ρ puts a 1/P into β(P)), and Wilson's dimension-four
coefficient; proof: background Feynman gauge (ghost, gauge-fixing vertices and Haar density independent of S, so c(S) − c_W is
a difference of gluon loops), the loop momentum split at k₀, the ultraviolet half bounded by the class constants, the infrared
half fixed to the continuum Yang–Mills integrand by the lattice Ward identities and the symmetry (8b₀ ln(1/p)), remainders
gaining two powers of momentum. (B2): every S_k ∈ 𝒮 with k-independent constants — ellipticity γ₀ = 1 and coefficient a = 1
from the curl contraction ‖dQA‖² ≤ ‖dA‖² in d = 4 (the factor L^{4−d}) and a plane-wave trial; the symmetry from CMP 109's
centred averaging (L odd, contours generated by coordinate permutations, (0.3)–(0.4)); the analyticity READ AT THE SOURCE TODAY:
CMP 102 [15] (on disk, `Downloads/1104114383.pdf`, extracted to `cmp102/cmp102_277.txt`) Theorem 1, p. 279: "The constants
α₀, α₁, B₃ depend on d and L only" (k-uniform), the minimal orbit "a unique critical orbit" for configurations obeying the
regularity condition (7); and §G, Proposition 9, p. 309: "The minimal configuration U_k(V) … has an extension to an analytic
function of G^c-valued small configurations V … It satisfies the conditions (19)–(21) … and its functional derivative (182)
satisfies the inequalities (190)." So F := |c_W| + sup_k |c(S_k)| < ∞.
STATUS: PROVED ON PAPER (the record, 2026-10-29; (B-i)–(B-iii) re-derived here with the Lagrange-term and alias
contributions shown to be O(P⁴); (B-iv)'s analyticity clause confirmed on CMP 102's page). Not kernel-checked; (B1)'s infrared
identification is the step a second reader should take line by line.

(B-v) SHARPENING (not needed for Theorem 2; shape stated). S_k → S_∞, the blocked action of the continuum limit of the centred
averaging, and the hypercubic-and-reflection symmetry removes the odd lattice artefacts, so c(S_k) = c(S_∞) + O(L^{−2k}) and
a(k) = c + O(L^{−2k}): only finitely many first steps can carry a negative transient — the record's negative L = 4 first step
(−0.450 at N = 12, an axial-contour scheme) is of this kind — and f converges.

### 5.4 LEMMA C — the remainder (DERIVED HERE by an exact interpolation; no complex coupling)

SETTING (CMP 109 §2, as the record reads it). Step k + 1 at g := g_k along a trajectory in D_{k+1}. Rescaled fluctuation B
with constrained Gaussian ½⟨B, Δ⁽ᵏ⁾(V)B⟩, δ(Q̃B), background V (the scale-(k+1) field, near 1 for the polarisation), small-field
cutoff χ_k(B) = Π_b χ(|gB(b)| < ε₁) (CMP 109 (2.9)), interaction I = I_W + I_H: I_W the cubic and higher terms of
−(1/g²)A(U_k(V e^{igB})) (the n-th order carrying g^{n−2}), I_H the history E_k(·) minus its value at B = 0, expanded in gB.
The step's output polarisation is that of Ψ_g(V) = log Z^G(V) + log⟨χ_k e^{I}⟩_{G,V} (Z^G the constrained Gaussian, ⟨·⟩_{G,V}
its normalised expectation). With M[·] the infinite-volume second moment of the second background derivative at V = 1
((1.20)–(1.22)), β_{k+1}(g) = M[Ψ_g] and β_{k+1}(0) = M[log Z^G].

THE IDENTITY. For t ∈ [0, 1] let φ(t) = log⟨χ_k e^{tI}⟩_{G,V} and ⟨·⟩_t the normalised measure ∝ χ_k e^{tI} dμ_G. Then φ′(t) =
⟨I⟩_t, φ″(t) = ⟨I; I⟩_t (variance), and Taylor's formula with integral remainder gives, since M is linear,

  β_{k+1}(g) − β_{k+1}(0) = M[log⟨χ_k⟩_G] + M[⟨I⟩_0] + ∫₀¹ (1 − s) M[⟨I; I⟩_s] ds.              (5.C)

(Valid because I is bounded on the cutoff region, so t ↦ φ(t) is C^∞; M commutes with the s-integral by dominated convergence
under the uniform bounds below.) Unlike Cauchy in a complex coupling — which fails because the small-field region scales as
1/g (Addendum II §4) — (5.C) moves only a real parameter in front of the interaction, with the cutoff region frozen.

THE BOUNDS, each input named (the black box B):
 (BB1) the constrained background propagator (Δ⁽ᵏ⁾(V)|_{ker Q̃})⁻¹ analytic in V on an absolute neighbourhood of 1, exponentially
   decaying at the block scale, k-uniformly (CMP 95 (1.64)–(1.67); CMP 99 (3.127)–(3.133));
 (BB2) the Wilson vertices local, |V_n(B)| ≤ C^n Σ_x |B(x)|^n (from CMP 102 Proposition 9's analyticity of U_k(Ve^{igB}));
 (BB3) the history analytic on the complex domain of ABSOLUTE radii α₀, α₁ with |E⁽ʲ⁾(X)| ≤ E₀e^{−κd_j(X)} (CMP 109 p. 263
   (1.17)–(1.18), re-established at every step with the same radii, CMP 116 p. 15);
 (BB4) the cluster expansion of ⟨·⟩_s uniform in s ∈ [0, 1]: CMP 116 gives it at s = 1, and its proof uses only bounds on |I|
   on the domain, which sI satisfies a fortiori;
 (BB5) the infinite-volume limit in (1.22), uniform (the localized representation (1.7)).
Then: (i) |M[log⟨χ_k⟩_G]| ≤ C₁e^{−c₁ε₁²/g²} (Gaussian tails, localized by (BB1), background derivatives by Cauchy on an absolute
radius); (ii) in ⟨I⟩_0 the odd terms vanish — μ_G and χ_k are even in B, and μ_G is centred because the background is the exact
critical point of the leading action (CMP 109 p. 267: "the third, linear term in (2.10) vanishes") — and the even terms are
explicit Gaussian moments: g²⟨V₄⟩_0, the history's second-order term g²⟨(HB)·∇²E_k·(HB)⟩_0/2 ≤ C g²E₀/α₁², and O(g⁴):
|M[⟨I⟩_0]| ≤ C₂ g²(1 + α₁^{−2}); (iii) |M[⟨I; I⟩_s]| ≤ C₃ ε₁² uniformly in s ∈ [0, 1] from the sup bounds alone (|I| ≤ Cε₁|B|²
on the cutoff region, |I_H| ≤ CE₀ε₁/α₁ there), and ≤ C₃′ g²(1 + α₁^{−2}) if the cluster bounds of (BB4) are taken in Gaussian
moment norms (the standard refinement: each interaction factor carries an explicit g against an integrable weight
e^{2ε₁|B|²}). Hence, in CMP 109's small-field model,

  ρ_{k+1}(g) := |β_{k+1}(g) − β_{k+1}(0)| ≤ C(ε₁² + g²) + C₁e^{−c₁ε₁²/g²}   [sup-norm form],
  ρ_{k+1}(g) ≤ C′g² + C₁e^{−c₁ε₁²/g²}                                     [moment-norm form],

uniformly in k and in the histories admitted by Theorem 3. Either form gives ρ < c: in the first take ε₁ with Cε₁² < c/3
(a further smallness condition on Bałaban's ε₁, chosen before γ in his own order) and then γ with Cγ² + C₁e^{−c₁ε₁²/γ²} < c/3.
The two-loop coefficient is part of ρ: ρ ≥ (17/(3π⁴)) ln L · g² + O(g⁴) asymptotically, so the moment-norm form is sharp in
order.

THE COMPLETE MODEL — A SHARPENED PAYABLE, AND A WITHDRAWAL. In CMP 119's complete description the radii are
α_{1,j} = g_jC₁(log g_j^{−2})^{q₁} (2.28). M takes a SECOND BACKGROUND DERIVATIVE, which on a background polydisc of that radius
costs another factor α₁^{−2}: the crude estimate of the history's contribution becomes C E₀ g²/α₁⁴ ~ C E₀/(g²(log g^{−2})^{4q₁}),
which DIVERGES as g → 0. So (5.C) closes only with background analyticity on an ABSOLUTE polydisc around the trivial
background. The record's |β_SF(g) − β_SF(0)| ≤ C′(log g^{−2})^{−2q₁} (Addendum II §4(ii)) applies one Cauchy factor (the
fluctuation direction) and not the one M takes; it is WITHDRAWN as a bound on β, dated 2026-11-02 (the record had itself listed
"the second background derivative" as still to write out). The payable, sharpened: (R) in the complete model, the small-field
effective action that defines β is analytic in the background on an absolute polydisc — true of CMP 109/116's small-field
model by (BB3); for the complete model it is the statement that its small-field part is CMP 109's up to terms
O(e^{−c p₀(g)}) (whose crude Cauchy factors 1/(g² polylog) they then absorb). That is one reading of CMP 119 Sect. 2–3 against
CMP 109 Sect. 1, with one proof shape available if the reading fails: the induction of CMP 109's Theorem 3 run inside the
complete model on the small-field terms, with the complete model's cutoffs (which are smaller regions).
STATUS: PROVED in CMP 109's small-field model given (BB1)–(BB5); REDUCED in the complete model to (R).

### 5.5 LEMMA D — continuity along trajectories (proved, given the uniformity of Bałaban's cluster bounds in the couplings)

STATEMENT. x₀ ↦ b_{k+1}(x₀) is continuous on D_{k+1}.
PROOF. The step map T_k : (x, E) ↦ (β_{k+1}(x, E), E_{k+1}(x, E)) on W × 𝔈 (𝔈 the localized analytic functionals obeying the
inductive bounds, normed by ‖E‖ = sup_X e^{κd(X)} sup_{domain}|E_X|) is continuous: (a) each polymer activity of the cluster
expansion is a finite-dimensional integral whose integrand depends continuously on (g, E) — the Wilson vertices are polynomial
in g, E enters analytically, and the cutoff χ(|gB| < ε₁) moves with g, but ∫χ(|gB| < ε₁)F(B)dμ is continuous in g by
dominated convergence because the moving boundary {|gB(b)| = ε₁} is μ-null; (b) the sum over polymers converges uniformly on
compact parameter sets, by the k- and coupling-uniform bounds (absolute constants, CMP 109 p. 263; CMP 116); (c) the extraction
(1.20)–(1.22) is a bounded linear functional on (𝔈, ‖·‖) (Cauchy on an absolute radius, uniform localization). Then
x₀ ↦ (x_k, E_k) is continuous on D_k by induction (composition), and b_{k+1} = β_{k+1}(x_k, E_k) is continuous on D_{k+1}. In the
complete model the domain moves with g: continuity is taken on the fixed sub-polydisc common to a compact interval of g. ∎

### 5.6 ASSEMBLY (proof of Theorem 2)

Order of choices (Bałaban's own: L first, γ last): L ≥ 2; then Lemma B gives F; then (in the sup-norm form) ε₁ small enough,
then γ₀ with ρ(γ₀) < c (Lemma C) and γ₀ ≤ Bałaban's γ. On D_{k+1}, (H2) is Lemma B; (H1) is Lemma D; (H3) is Lemma C applied
along the trajectory, by induction on k as in Lemma A′'s Remark (2) (the master inequalities at step k from (P) at the steps
≤ k). Lemma A′ gives Theorem 2. ∎
WHAT IT DELIVERS: on the trajectory, LFR II's Theorem 1 holds: the effective densities have Bałaban's form and the ultraviolet
stability bounds χ_k exp[−(1/g_k²)A(U_k) − E₋|T_η|] ≤ ρ_k ≤ exp E₊|T_η| (CMP 122 p. 355 (0.1)) with E± independent of k, T_η, U_k.
THE GROUP SEPARATES HERE: for U(1), c = 0 and Lemma A′ gives no window once ρ > 0 — the chain separates the groups at the
ultraviolet end, as Theorem 8.7 does at the infrared end.
