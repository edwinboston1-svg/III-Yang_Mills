
### 4.4 LEMMA NH (THE NEAR-HAAR BOUNDS: the five constants from seven numbers of the group) — PROVED

INPUTS (every one exact or rigorously bounded per group in §4.5): n (Lemma I); for the ORBIT point o := u(1) (by bi-invariance every u(g)
has the same law), X_o = Re χ_ρ/d and t_k := E_Haar X_o^k (k = 3, 4; |t₃| used), o₃ := sup_{|f|=1} |E_Haar X_f X_o²|; for ALL directions
c₃ ≥ sup_{|e|=1} |E X_e³| (= sup over unit triples |E X_eX_fX_g|, Banach's polarization theorem for symmetric forms on a real Hilbert space)
and m₄ ≥ sup_{|e|=1} E X_e⁴ (so E X_e²X_f² ≤ m₄ and E|X_eX_fX_gX_h| ≤ m₄ by Hölder). Write φ_k(r) := Σ_{j≥k} r^j/j!.
CLAIMS, for |w| ≤ r (X_w := ⟨u, w⟩, |X_w| ≤ r, Z(w) ≥ 1 by Jensen):
(NH1) |μ(w)| ≤ μ₁(r) := r/n + ½r²c₃ + φ₃(r)√(m₄/n);   and μ̄(r) ≤ r·s̄(r).
(NH2) s̄(r) ≤ s₁(r) := 1/n + r c₃ + φ₂(r) m₄;   and for an orbit direction E_w X_o² ≤ s₀(r) := 1/n + r o₃ + φ₂(r) m₄.
(NH3) D̄(r) ≤ 2a₁(r) + μ̄(r)²,  a₁(r) := r o₃ + φ₂(r)(m₄ + 1/n²).
(NH4) T(r) ≤ T₁(r) := |t₃| + φ₁(r)√(t₄ m₄) + 3μ̄(r)s₀(r) + 2μ̄(r)³.
(NH5) T_x(r) ≤ √(s₀(r)·Q(r)),  Q(r) := t₄ + φ₁(r)√(t₄ m₄) + 4μ̄(r)(|t₃| + φ₁(r)√(t₄m₄)) + 6μ̄(r)²s₀(r).
PROOFS. (NH1) E_wX_e = E₀[X_e e^{X_w}]/Z and E₀[X_e e^{X_w}] = Σ_j E₀[X_eX_w^j]/j!: j = 0 gives 0, j = 1 gives ⟨e, w⟩/n (Lemma I), j = 2 gives
modulus ≤ ½|w|²c₃, and for j ≥ 3, |E₀X_eX_w^j| ≤ |w|^j E₀[|X_e| X_ŵ²] ≤ |w|^j (E₀X_e² E₀X_ŵ⁴)^{1/2} ≤ |w|^j √(m₄/n) (|X_ŵ| ≤ 1); divide by Z ≥ 1.
The second form: μ(w) = ∫₀¹ Σ_{tw} w dt. (NH2) Var_w X_e ≤ E_wX_e² ≤ E₀[X_e² e^{X_w}] = 1/n + E₀[X_e²X_w] + E₀[X_e² ψ(X_w)], ψ(x) := e^x − 1 − x, and
0 ≤ ψ(x) ≤ (φ₂(r)/r²)x² on |x| ≤ r (ψ(x)/x² = Σ_{j≥2} x^{j−2}/j!); the middle term is ≤ r c₃ (resp. ≤ r o₃ for e = o), the last ≤ φ₂(r)m₄.
(NH3) For orbit e: E_wX_e² − 1/n = E₀[(X_e² − 1/n)e^{X_w}]/Z = (E₀[X_e²X_w] + E₀[(X_e² − 1/n)ψ(X_w)])/Z (the constant term vanishes), of modulus
≤ r o₃ + φ₂(r)E₀[(X_e² + 1/n)X_ŵ²] ≤ a₁(r); so Σ_w(e, e) = E_wX_e² − (E_wX_e)² lies in [1/n − a₁ − μ̄², 1/n + a₁] for every orbit e. (NH4) With
m = E_wX_e, κ₃ = E_wX_e³ − 3mE_wX_e² + 2m³; |E_wX_e³| ≤ |t₃| + E₀[|X_e|³(e^{|X_w|} − 1)] ≤ |t₃| + φ₁(r)E₀[|X_e|³|X_ŵ|] ((e^s − 1)/s increasing),
and E₀|X_e|³|X_ŵ| ≤ (E₀X_e⁴)^{1/2}(E₀X_e²X_ŵ²)^{1/2} ≤ √(t₄m₄). (NH5) |κ₃(u(a), e, e)| = |E_w[Y_aY_e²]| ≤ (E_wY_a²)^{1/2}(E_wY_e⁴)^{1/2} (Y = X − m),
E_wY_a² ≤ s₀; E(X − m)⁴ = EX⁴ − 4mEX³ + 6m²EX² − 3m⁴ ≤ EX⁴ + 4|m||EX³| + 6m²EX², with E_wX_e⁴ ≤ t₄ + φ₁(r)E₀[X_e⁴|X_ŵ|] and
E₀X_e⁴|X_ŵ| ≤ E₀|X_e|³|X_ŵ| ≤ √(t₄m₄) (|X_e| ≤ 1). ∎
WHAT THE LEMMA COSTS (named, not hidden): every remainder carries φ_k(r)·m₄ — the higher Haar moments bounded through |X| ≤ 1 — so the bounds are
sharp only while e^r m₄ ≪ 1/n, i.e. r ≲ log(1/(n m₄)) ≈ log(n/3). The true one-link family stays near Haar far longer for large groups (the
eigenvalue-concentration transition of the one-link integral sits at r of order dim G); certifying that needs Haar moments of matrix
coefficients of all orders at the scale 1/√n — the next object (§4.7).

### 4.5 THE PER-GROUP INPUTS — PROVED (each a finite representation-theoretic computation)

(i) t_k. Real or quaternionic ρ: χ is real and t_k = M_k/d^k, M_k := ∫χ^k = the multiplicity of 1 in ρ^{⊗k}; M₃ = 1 exactly when ρ carries
a cubic invariant, M₄ = Σ_{λ ⊂ ρ⊗ρ} m_λ² = the number of components of ρ ⊗ ρ (multiplicity-free in every case below). Complex ρ:
t_k = 2^{−k} Σ_j C(k, j) ∫χ^j χ̄^{k−j} / d^k, with ∫χ^aχ̄^b = 0 unless the centre's character allows it.
(ii) o₃ = |∫(Re χ)²χ|/d³: for a class function f, ∫f ρ = (1/d)(∫fχ)·1 (Schur), so E₀[X_o² u] = (1/d^{3.5})∫(Re χ)²χ · 1, of norm |∫(Re χ)²χ|/d³
(‖1‖ = √d; for complex type the phase is absorbed by e^{iθ}1 ∈ E). Real type: o₃ = M₃/d³ = t₃.
(iii) m₄. With z := tr(e†ρ(U)), X_e = Re z/√d. Real/quaternionic type z is real (quaternionic: tr of an element of the real form M_{d/2}(ℍ) is
real) and E z⁴ = E|tr((e†⊗e†)(ρ⊗ρ)(U))|² = Σ_{λ ⊂ ρ⊗ρ} ‖P_λ(e†⊗e†)P_λ‖²_HS/d_λ (Schur orthogonality, multiplicity-free); complex type
E(Re z)⁴ = (1/16)(6E|z|⁴ + 2Re E z⁴ + 8Re E z³z̄) with E|z|⁴ given by the same sum. Since e†⊗e† commutes with the swap, its weights on
Sym²ρ and Λ²ρ are W_S = ½(1 + t), W_Λ = ½(1 − t), t := tr((ee†)²) ∈ [1/d, 1] ([1/d, ½] for quaternionic type, whose nonzero elements have
complex rank ≥ 2); the trivial component (real type: in Sym², Ω = Σe_i⊗e_i; quaternionic: in Λ², the symplectic form J) carries EXACTLY
⟨Ω̂, (e†⊗e†)Ω̂⟩² = (‖e‖²/d)² = 1/d² (for the quaternionic real form eJ = Jē gives tr(JᵀeJeᵀ) = ‖e‖²). Hence the bound
  E z⁴ ≤ 1/d² + Σ_{blocks B} (W_B − 1/d²·[1 ∈ B]) / d_min(B),  maximised over t (it is linear in t),
EXACT when each block minus its trivial part is irreducible (SU(N), Sp(2), SO(N)), an upper bound otherwise (G₂, F₄, E₆, E₇, E₈). E z⁴ ≠ 0
in the complex case only for SU(4) (E z⁴ = det e†, |det e| ≤ 4⁻², the singular values' AM–GM); E z³z̄ = 0 in every complex case below.
(iv) c₃ = 0 when ρ⊗ρ⊗ρ and ρ⊗ρ⊗ρ̄ contain no invariant; SU(3): E z³ = det ē (E[U_{i₁j₁}U_{i₂j₂}U_{i₃j₃}] = ε ε/6), E(Re z)³ = ¼ Re det e,
|det e| ≤ 3^{−3/2}, c₃ = 1/108 EXACT; SO(3): E z³ = det e (the same ε-integral), c₃ = 3^{−3/2}/3^{3/2} = 1/27 EXACT; otherwise
c₃ ≤ √(m₄/n) (Cauchy–Schwarz with Lemma I) — for G₂ and E₈ (antisymmetric invariant φ, E[ρ^{⊗3}] = the projector onto φ) also
c₃ ≤ s₁s₂s₃/d^{3/2} ≤ 3^{−3/2}/d^{3/2}, and the smaller is used.
