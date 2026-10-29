/-
  APERANTON -- THE BOUNDLESS, stage Β3b+Β3c (ADDENDUM I, THE ROAD): THE X-TRANSFER SLAB AS A FACTOR SYSTEM,
  DOBRUSHIN'S BOUND ON IT, AND THE MASS GAP UNIFORM IN THE CROSS-SECTION AT STRONG COUPLING.

  The slab of T + 1 cross-sections (links Lk, spins in a finite group G) with the in-plane weight w′ on the square
  plaquettes `sq` and the x-link kernel k: its Gibbs weight is the product of plaquette factors w′(hol_p(c_x)) and
  link factors k(c_x ℓ, c_{x+1} ℓ) (`slabFactors`, `weight_slab`), and it is the slab of XTransfer.lean -- the
  path sums with √D at the ends are the Gibbs sums (`pathSum_eq_gibbsSum`, the √D telescoping).  Dobrushin's
  interdependence matrix of the factor system (Factors.lean) has range one along the level x (`slab_rangeOne`); for
  an observable F of one cross-section placed at levels a and a + R the covariance is at most K_F α^R, K_F free of
  T and a (`slab_cov_le`); the one-point function converges (`slab_one_tendsto`, mirroring `slab_tendsto`); so in
  the infinite slab every two-point function decays to its Perron mass at rate α (`slab_decay`), and by Decay.lean
  EVERY NON-PERRON EIGENVALUE OF THE TRANSFER MATRIX IS AT MOST α λ₀ (`transfer_gap_uniform`): the mass gap on
  the cross-section is at least −log α.  α is any bound on the row sums of the slab's interdependence matrix
  uniform in the slab's length; the road's desk note derives its form from the weights' ratios and the
  plaquette-degree alone (uniform in the cross-section), the Lean of that form owed to the next landing.
  Osterwalder–Seiler's strong-coupling statement by Dobrushin's road; W = 0 for the statement, the finite proof is
  the build.  No sorry, no axiom, no native_decide.
-/
import Mathlib
import Aperanton.XTransfer
import Aperanton.GaugeAction
import Aperanton.Nonabelian
import Aperanton.Dobrushin
import Aperanton.Factors
import Aperanton.Decay

open Matrix Filter Topology Finset

namespace Aperanton

section Curry

/-- configurations of the slab as functions of (level, link) and as level-indexed cross-sections -/
def curryEquiv (X Y Z : Type*) : (X × Y → Z) ≃ (X → Y → Z) where
  toFun ω := fun x y => ω (x, y)
  invFun c := fun p => c p.1 p.2
  left_inv _ := rfl
  right_inv _ := rfl

end Curry

section GibbsForm

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- the Gibbs weight of a path: the product of the D's and the K's -/
def gibbsW (D : n → ℝ) (K : Matrix n n ℝ) (T : ℕ) (c : Fin (T + 1) → n) : ℝ :=
  (∏ x, D (c x)) * ∏ x : Fin T, K (c x.castSucc) (c x.succ)

theorem gibbsW_pos (D : n → ℝ) (hD : ∀ c, 0 < D c) (K : Matrix n n ℝ) (hK : ∀ c c', 0 < K c c') (T : ℕ)
    (c : Fin (T + 1) → n) : 0 < gibbsW D K T c :=
  mul_pos (prod_pos fun _ _ => hD _) (prod_pos fun _ _ => hK _ _)

/-- THE √D TELESCOPING: the path sum with √D at both ends and the transfer matrix between is the Gibbs sum -/
theorem pathSum_eq_gibbsSum (D : n → ℝ) (hD : ∀ c, 0 < D c) (K : Matrix n n ℝ) (Gw : ℕ → n → ℝ) (T : ℕ) :
    pathSum (transfer D K) Gw (fun c => Real.sqrt (D c)) (fun c => Real.sqrt (D c)) 0 T =
      ∑ c : Fin (T + 1) → n, gibbsW D K T c * ∏ x : Fin (T + 1), Gw (0 + x) (c x) := by
  simp only [pathSum, gibbsW]
  refine sum_congr rfl fun c _ => ?_
  have hsq : ∀ x, Real.sqrt (D (c x)) * Real.sqrt (D (c x)) = D (c x) := fun x => Real.mul_self_sqrt (hD _).le
  have htr : ∏ x : Fin T, transfer D K (c x.castSucc) (c x.succ) =
      (∏ x : Fin T, Real.sqrt (D (c x.castSucc))) * (∏ x : Fin T, K (c x.castSucc) (c x.succ)) *
        ∏ x : Fin T, Real.sqrt (D (c x.succ)) := by
    simp only [transfer_apply, prod_mul_distrib]
  have h1 : Real.sqrt (D (c 0)) * ∏ x : Fin T, Real.sqrt (D (c x.succ)) =
      ∏ x : Fin (T + 1), Real.sqrt (D (c x)) := (Fin.prod_univ_succ (fun x : Fin (T + 1) => Real.sqrt (D (c x)))).symm
  have h2 : (∏ x : Fin T, Real.sqrt (D (c x.castSucc))) * Real.sqrt (D (c (Fin.last T))) =
      ∏ x : Fin (T + 1), Real.sqrt (D (c x)) := (Fin.prod_univ_castSucc (fun x : Fin (T + 1) => Real.sqrt (D (c x)))).symm
  have h3 : (∏ x : Fin (T + 1), Real.sqrt (D (c x))) * ∏ x : Fin (T + 1), Real.sqrt (D (c x)) =
      ∏ x : Fin (T + 1), D (c x) := by
    rw [← prod_mul_distrib]
    exact prod_congr rfl fun x _ => hsq x
  rw [htr]
  calc Real.sqrt (D (c 0)) * (∏ x : Fin (T + 1), Gw (0 + ↑x) (c x)) *
        ((∏ x : Fin T, Real.sqrt (D (c x.castSucc))) * (∏ x : Fin T, K (c x.castSucc) (c x.succ)) *
          ∏ x : Fin T, Real.sqrt (D (c x.succ))) * Real.sqrt (D (c (Fin.last T)))
      = (Real.sqrt (D (c 0)) * ∏ x : Fin T, Real.sqrt (D (c x.succ))) *
        ((∏ x : Fin T, Real.sqrt (D (c x.castSucc))) * Real.sqrt (D (c (Fin.last T)))) *
        (∏ x : Fin T, K (c x.castSucc) (c x.succ)) * ∏ x : Fin (T + 1), Gw (0 + ↑x) (c x) := by ring
    _ = (∏ x : Fin (T + 1), D (c x)) * (∏ x : Fin T, K (c x.castSucc) (c x.succ)) *
        ∏ x : Fin (T + 1), Gw (0 + ↑x) (c x) := by rw [h1, h2, h3]

/-- the product of a two-point insertion over the levels -/
theorem prod_insL (F : n → ℝ) (a R T : ℕ) (ha : a + R ≤ T) (c : Fin (T + 1) → n) :
    ∏ x : Fin (T + 1), ins F a R (0 + ↑x) (c x) = F (c ⟨a, by omega⟩) * F (c ⟨a + R, by omega⟩) := by
  simp only [ins, zero_add, prod_mul_distrib]
  congr 1
  · rw [prod_eq_single ⟨a, by omega⟩]
    · simp
    · intro x _ hx
      rw [if_neg]
      intro h
      exact hx (Fin.ext h)
    · intro h; exact absurd (mem_univ _) h
  · rw [prod_eq_single ⟨a + R, by omega⟩]
    · simp
    · intro x _ hx
      rw [if_neg]
      intro h
      exact hx (Fin.ext h)
    · intro h; exact absurd (mem_univ _) h

/-- a single insertion at a -/
def ins1 (F : n → ℝ) (a : ℕ) : ℕ → n → ℝ := fun x c => if x = a then F c else 1

theorem prod_ins1 (F : n → ℝ) (a T : ℕ) (ha : a ≤ T) (c : Fin (T + 1) → n) :
    ∏ x : Fin (T + 1), ins1 F a (0 + ↑x) (c x) = F (c ⟨a, by omega⟩) := by
  simp only [ins1, zero_add]
  rw [prod_eq_single ⟨a, by omega⟩]
  · simp
  · intro x _ hx
    rw [if_neg]
    intro h
    exact hx (Fin.ext h)
  · intro h; exact absurd (mem_univ _) h

end GibbsForm

section SlabFactors

variable {V Lk : Type*} [DecidableEq V] [Fintype Lk] [DecidableEq Lk]
  {G : Type*} [Group G] [Fintype G] [DecidableEq G]

/-- the index of the slab's factors: a plaquette at a level, or a link between two levels -/
abbrev SlabIdx (ι : Type*) (Lk : Type*) (T : ℕ) := (Fin (T + 1) × ι) ⊕ (Fin T × Lk)

/-- a square plaquette's four links -/
def squareLinks {Λ : Lat V Lk} (p : Square Λ) : Finset Lk := {p.ℓ₁, p.ℓ₂, p.ℓ₃, p.ℓ₄}

theorem hol_update_of_not_mem {Λ : Lat V Lk} (p : Square Λ) (c : Lk → G) (ℓ : Lk) (g : G)
    (h : ℓ ∉ squareLinks p) : hol p (Function.update c ℓ g) = hol p c := by
  simp only [squareLinks, mem_insert, mem_singleton, not_or] at h
  obtain ⟨h1, h2, h3, h4⟩ := h
  simp only [hol, Function.update_of_ne (Ne.symm h1), Function.update_of_ne (Ne.symm h2),
    Function.update_of_ne (Ne.symm h3), Function.update_of_ne (Ne.symm h4)]

/-- the level of a site -/
def level {T : ℕ} (s : Fin (T + 1) × Lk) : ℕ := s.1.val

/-- THE SLAB AS A FACTOR SYSTEM: plaquette factors w′(hol_p(c_x)) with bounds [wlo, whi], link factors
k(c_x ℓ, c_{x+1} ℓ) with bounds [klo, khi] -/
def slabFactors {Λ : Lat V Lk} {ι : Type*} [Fintype ι] [DecidableEq ι] (sq : ι → Square Λ) (w' : G → ℝ)
    (wlo whi : ℝ) (hwlo : 0 < wlo) (hw'lo : ∀ g, wlo ≤ w' g) (hw'hi : ∀ g, w' g ≤ whi)
    (k : Matrix G G ℝ) (klo khi : ℝ) (hklo : 0 < klo) (hk_lo : ∀ a b, klo ≤ k a b) (hk_hi : ∀ a b, k a b ≤ khi)
    (T : ℕ) : FactorSystem (Fin (T + 1) × Lk) G (SlabIdx ι Lk T) where
  sites
    | Sum.inl (x, i) => (squareLinks (sq i)).image fun ℓ => (x, ℓ)
    | Sum.inr (x, ℓ) => {(x.castSucc, ℓ), (x.succ, ℓ)}
  w
    | Sum.inl (x, i) => fun ω => w' (hol (sq i) (fun ℓ => ω (x, ℓ)))
    | Sum.inr (x, ℓ) => fun ω => k (ω (x.castSucc, ℓ)) (ω (x.succ, ℓ))
  lo
    | Sum.inl _ => wlo
    | Sum.inr _ => klo
  hi
    | Sum.inl _ => whi
    | Sum.inr _ => khi
  lo_pos := by rintro (_ | _) <;> assumption
  w_lo := by rintro (⟨x, i⟩ | ⟨x, ℓ⟩) ω <;> first | exact hw'lo _ | exact hk_lo _ _
  w_hi := by rintro (⟨x, i⟩ | ⟨x, ℓ⟩) ω <;> first | exact hw'hi _ | exact hk_hi _ _
  w_local := by
    rintro (⟨x, i⟩ | ⟨x, ℓ⟩) ω s g hs
    · simp only [mem_image, not_exists, not_and] at hs
      show w' (hol (sq i) (fun ℓ' => Function.update ω s g (x, ℓ'))) = w' (hol (sq i) (fun ℓ' => ω (x, ℓ')))
      congr 1
      by_cases hx : s.1 = x
      · have hupd : (fun ℓ' => Function.update ω s g (x, ℓ')) =
            Function.update (fun ℓ' => ω (x, ℓ')) s.2 g := by
          funext ℓ'
          by_cases hℓ : ℓ' = s.2
          · subst hℓ
            have hs' : (x, s.2) = s := Prod.ext hx.symm rfl
            rw [hs', Function.update_self, Function.update_self]
          · have hne : (x, ℓ') ≠ s := fun h => hℓ (by rw [← h])
            rw [Function.update_of_ne hne, Function.update_of_ne hℓ]
        rw [hupd]
        apply hol_update_of_not_mem
        intro hmem
        exact hs s.2 hmem (Prod.ext hx.symm rfl)
      · have hupd : (fun ℓ' => Function.update ω s g (x, ℓ')) = fun ℓ' => ω (x, ℓ') := by
          funext ℓ'
          exact Function.update_of_ne (fun h => hx (by rw [← h])) _ _
        rw [hupd]
    · simp only [mem_insert, mem_singleton, not_or] at hs
      show k (Function.update ω s g (x.castSucc, ℓ)) (Function.update ω s g (x.succ, ℓ)) =
        k (ω (x.castSucc, ℓ)) (ω (x.succ, ℓ))
      rw [Function.update_of_ne (Ne.symm hs.1), Function.update_of_ne (Ne.symm hs.2)]

variable {Λ : Lat V Lk} {ι : Type*} [Fintype ι] [DecidableEq ι] (sq : ι → Square Λ) (w' : G → ℝ)
  (wlo whi : ℝ) (hwlo : 0 < wlo) (hw'lo : ∀ g, wlo ≤ w' g) (hw'hi : ∀ g, w' g ≤ whi)
  (k : Matrix G G ℝ) (klo khi : ℝ) (hklo : 0 < klo) (hk_lo : ∀ a b, klo ≤ k a b) (hk_hi : ∀ a b, k a b ≤ khi)
  (T : ℕ)

/-- the weight of the slab's factor system is the Gibbs weight of the curried path -/
theorem weight_slab (ω : Fin (T + 1) × Lk → G) :
    weight (slabFactors sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi T) ω =
      gibbsW (plaqWeight sq w') (tensorKernel k) T (curryEquiv _ _ _ ω) := by
  simp only [weight, gibbsW, plaqWeight, tensorKernel, curryEquiv, Equiv.coe_fn_mk]
  rw [Fintype.prod_sum_type, Fintype.prod_prod_type, Fintype.prod_prod_type]
  rfl

/-- two sites read by one factor are within one level -/
theorem level_le_of_mem_sites (i : SlabIdx ι Lk T) (s t : Fin (T + 1) × Lk)
    (hs : s ∈ (slabFactors sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi T).sites i)
    (ht : t ∈ (slabFactors sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi T).sites i) :
    level t ≤ level s + 1 := by
  rcases i with ⟨x, i⟩ | ⟨x, ℓ⟩
  · simp only [slabFactors, mem_image] at hs ht
    obtain ⟨ℓs, -, rfl⟩ := hs
    obtain ⟨ℓt, -, rfl⟩ := ht
    simp [level]
  · simp only [slabFactors, mem_insert, mem_singleton] at hs ht
    rcases hs with rfl | rfl <;> rcases ht with rfl | rfl <;> simp only [level, Fin.coe_castSucc, Fin.val_succ] <;> omega

/-- THE SLAB HAS RANGE ONE along the level -/
theorem slab_rangeOne :
    RangeOne (interdepMat (slabFactors sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi T)) level := by
  intro s t hst
  apply interdepMat_eq_zero_of_disjoint
  intro i hs ht
  have := level_le_of_mem_sites sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi T i s t hs ht
  omega

end SlabFactors

section SlabLimits

variable {n : Type*} [Fintype n] [DecidableEq n] [Nonempty n]

/-- the chain with one insertion at a: M^a diag(F) M^b -/
theorem chain_ins1 (M : Matrix n n ℝ) (F : n → ℝ) (a b : ℕ) :
    chain M (ins1 F a) 0 (a + b) = M ^ a * diagonal F * M ^ b := by
  have hfirst : chain M (ins1 F a) 0 a = M ^ a * diagonal F := by
    have := chain_last M F a 0
    simp only [zero_add] at this
    exact this
  cases b with
  | zero => rw [add_zero, pow_zero, mul_one]; exact hfirst
  | succ b =>
    rw [show a + (b + 1) = a + 1 + b by ring, chain_split, hfirst]
    have hlast : chain M (ins1 F a) (0 + a + 1) b = M ^ b := by
      rw [chain_congr M (ins1 F a) (fun _ => fun _ => (1 : ℝ)) b (0 + a + 1)]
      · exact chain_one M b _
      · intro x hx _
        funext c
        simp only [ins1]
        rw [if_neg (by omega)]
    rw [hlast, pow_succ']
    simp only [mul_assoc]

/-- the slab's one-point sum: F inserted at level p in the slab of length p + q -/
noncomputable def slabOne (D : n → ℝ) (K : Matrix n n ℝ) (F : n → ℝ) (p q : ℕ) : ℝ :=
  pathSum (transfer D K) (ins1 F p) (fun c => Real.sqrt (D c)) (fun c => Real.sqrt (D c)) 0 (p + q)

/-- the slab's partition function of length L -/
noncomputable def slabZ' (D : n → ℝ) (K : Matrix n n ℝ) (L : ℕ) : ℝ :=
  pathSum (transfer D K) (fun _ => fun _ => (1 : ℝ)) (fun c => Real.sqrt (D c)) (fun c => Real.sqrt (D c)) 0 L

/-- THE ONE-POINT FUNCTION OF THE INFINITE SLAB converges to Σ_c F(c) Ω(c)², Ω the unit Perron vector, along any
pair of insertion distances both tending to infinity -/
theorem slab_one_tendsto (D : n → ℝ) (hD : ∀ c, 0 < D c) (K : Matrix n n ℝ) (hK : K.PosSemidef)
    (hKpos : ∀ c c', 0 < K c c') (F : n → ℝ) (Ω : n → ℝ)
    (hΩ : transfer D K *ᵥ Ω = lamMax (transfer D K) (transfer_posSemidef D K hK).1 • Ω) (hn : Ω ⬝ᵥ Ω = 1)
    (p q : ℕ → ℕ) (hp : Tendsto p atTop atTop) (hq : Tendsto q atTop atTop) :
    Tendsto (fun a : ℕ => slabOne D K F (p a) (q a) / slabZ' D K (p a + q a)) atTop
      (𝓝 (Ω ⬝ᵥ (diagonal F *ᵥ Ω))) := by
  set M := transfer D K with hMdef
  have hM : M.IsHermitian := (transfer_posSemidef D K hK).1
  have hpos : ∀ i j, 0 < M i j := transfer_pos D hD K hKpos
  obtain ⟨Ω₀, hnorm₀, hΩeig₀, hne₀, hlim⟩ := perron_limit M hM hpos
  set l := lamMax M hM with hl
  have hlpos : 0 < l := (perron_exists M hM hpos).choose_spec.2.2
  set d : n → ℝ := fun c => Real.sqrt (D c) with hd
  have hl1 : ∀ m : ℕ, l ^ m ≠ 0 := fun m => pow_ne_zero _ hlpos.ne'
  -- the numerator and the partition function as sandwiches
  have hnum : ∀ a : ℕ, slabOne D K F (p a) (q a) = (M ^ (p a) *ᵥ d) ⬝ᵥ (diagonal F *ᵥ (M ^ (q a) *ᵥ d)) := by
    intro a
    simp only [slabOne]
    rw [pathSum_eq_chain, chain_ins1, ← mulVec_mulVec, ← mulVec_mulVec, dotProduct_mulVec,
      ← mulVec_transpose, transpose_pow_eq M hM]
  have hZ : ∀ a : ℕ, slabZ' D K (p a + q a) = (M ^ (p a) *ᵥ d) ⬝ᵥ (M ^ (q a) *ᵥ d) := by
    intro a
    simp only [slabZ']
    rw [pathSum_eq_chain, chain_one, pow_add, ← mulVec_mulVec, dotProduct_mulVec, ← mulVec_transpose,
      transpose_pow_eq M hM]
  -- the normalised sandwiches
  have hqnum : ∀ a : ℕ, (M ^ (p a) *ᵥ d) ⬝ᵥ (diagonal F *ᵥ (M ^ (q a) *ᵥ d)) / (l ^ (p a) * l ^ (q a)) =
      ∑ i, ((M ^ (p a) *ᵥ d) i / l ^ (p a)) * F i * ((M ^ (q a) *ᵥ d) i / l ^ (q a)) := by
    intro a
    simp only [dotProduct, mulVec_diagonal, sum_div]
    refine sum_congr rfl fun i _ => ?_
    field_simp
  have hqZ : ∀ a : ℕ, (M ^ (p a) *ᵥ d) ⬝ᵥ (M ^ (q a) *ᵥ d) / (l ^ (p a) * l ^ (q a)) =
      ∑ i, ((M ^ (p a) *ᵥ d) i / l ^ (p a)) * ((M ^ (q a) *ᵥ d) i / l ^ (q a)) := by
    intro a
    simp only [dotProduct, sum_div]
    refine sum_congr rfl fun i _ => ?_
    field_simp
  have h1 : ∀ i, Tendsto (fun a : ℕ => (M ^ (p a) *ᵥ d) i / l ^ (p a)) atTop (𝓝 ((Ω₀ ⬝ᵥ d) * Ω₀ i)) :=
    fun i => (hlim d i).comp hp
  have h1' : ∀ i, Tendsto (fun a : ℕ => (M ^ (q a) *ᵥ d) i / l ^ (q a)) atTop (𝓝 ((Ω₀ ⬝ᵥ d) * Ω₀ i)) :=
    fun i => (hlim d i).comp hq
  have hnumlim : Tendsto (fun a : ℕ => (M ^ (p a) *ᵥ d) ⬝ᵥ (diagonal F *ᵥ (M ^ (q a) *ᵥ d)) /
      (l ^ (p a) * l ^ (q a))) atTop (𝓝 ((Ω₀ ⬝ᵥ d) * (Ω₀ ⬝ᵥ d) * (Ω₀ ⬝ᵥ (diagonal F *ᵥ Ω₀)))) := by
    have h2 : Tendsto (fun a : ℕ => ∑ i, ((M ^ (p a) *ᵥ d) i / l ^ (p a)) * F i *
        ((M ^ (q a) *ᵥ d) i / l ^ (q a))) atTop (𝓝 (∑ i, ((Ω₀ ⬝ᵥ d) * Ω₀ i) * F i * ((Ω₀ ⬝ᵥ d) * Ω₀ i))) := by
      apply tendsto_finsetSum
      intro i _
      exact ((h1 i).mul tendsto_const_nhds).mul (h1' i)
    have h3 : (∑ i, ((Ω₀ ⬝ᵥ d) * Ω₀ i) * F i * ((Ω₀ ⬝ᵥ d) * Ω₀ i)) =
        (Ω₀ ⬝ᵥ d) * (Ω₀ ⬝ᵥ d) * (Ω₀ ⬝ᵥ (diagonal F *ᵥ Ω₀)) := by
      have hdiag : Ω₀ ⬝ᵥ (diagonal F *ᵥ Ω₀) = ∑ i, Ω₀ i * (F i * Ω₀ i) := by
        simp only [dotProduct, mulVec_diagonal]
      rw [hdiag, mul_sum]
      refine sum_congr rfl fun i _ => ?_
      ring
    rw [h3] at h2
    exact h2.congr' (Filter.Eventually.of_forall fun a => (hqnum a).symm)
  have hZlim : Tendsto (fun a : ℕ => (M ^ (p a) *ᵥ d) ⬝ᵥ (M ^ (q a) *ᵥ d) / (l ^ (p a) * l ^ (q a))) atTop
      (𝓝 ((Ω₀ ⬝ᵥ d) * (Ω₀ ⬝ᵥ d))) := by
    have h2 : Tendsto (fun a : ℕ => ∑ i, ((M ^ (p a) *ᵥ d) i / l ^ (p a)) * ((M ^ (q a) *ᵥ d) i / l ^ (q a)))
        atTop (𝓝 (∑ i, ((Ω₀ ⬝ᵥ d) * Ω₀ i) * ((Ω₀ ⬝ᵥ d) * Ω₀ i))) := by
      apply tendsto_finsetSum
      intro i _
      exact (h1 i).mul (h1' i)
    have h3 : (∑ i, ((Ω₀ ⬝ᵥ d) * Ω₀ i) * ((Ω₀ ⬝ᵥ d) * Ω₀ i)) = (Ω₀ ⬝ᵥ d) * (Ω₀ ⬝ᵥ d) := by
      have hn₀' : ∑ i, Ω₀ i * Ω₀ i = 1 := hnorm₀
      calc (∑ i, ((Ω₀ ⬝ᵥ d) * Ω₀ i) * ((Ω₀ ⬝ᵥ d) * Ω₀ i))
          = (Ω₀ ⬝ᵥ d) * (Ω₀ ⬝ᵥ d) * ∑ i, Ω₀ i * Ω₀ i := by
            rw [mul_sum]; refine sum_congr rfl fun i _ => ?_; ring
        _ = (Ω₀ ⬝ᵥ d) * (Ω₀ ⬝ᵥ d) := by rw [hn₀', mul_one]
    rw [h3] at h2
    exact h2.congr' (Filter.Eventually.of_forall fun a => (hqZ a).symm)
  have hΩd : (Ω₀ ⬝ᵥ d) ≠ 0 := by
    obtain ⟨pv, hppos, hpv, -⟩ := perron_exists M hM hpos
    obtain ⟨c, hc⟩ := perron_simple M hM hpos pv hppos hpv Ω₀ hΩeig₀
    have hc0 : c ≠ 0 := by
      intro h0
      have := hne₀ (Classical.arbitrary n)
      rw [hc, h0, zero_smul] at this
      exact this rfl
    rw [hc, smul_dotProduct, smul_eq_mul]
    apply mul_ne_zero hc0
    apply ne_of_gt
    apply sum_pos
    · intro i _
      exact mul_pos (hppos i) (Real.sqrt_pos.mpr (hD i))
    · exact univ_nonempty
  have hden : (Ω₀ ⬝ᵥ d) * (Ω₀ ⬝ᵥ d) ≠ 0 := mul_ne_zero hΩd hΩd
  have hratio : ∀ a : ℕ, slabOne D K F (p a) (q a) / slabZ' D K (p a + q a) =
      ((M ^ (p a) *ᵥ d) ⬝ᵥ (diagonal F *ᵥ (M ^ (q a) *ᵥ d)) / (l ^ (p a) * l ^ (q a))) /
      ((M ^ (p a) *ᵥ d) ⬝ᵥ (M ^ (q a) *ᵥ d) / (l ^ (p a) * l ^ (q a))) := by
    intro a
    rw [hnum, hZ, div_div_div_cancel_right₀ (mul_ne_zero (hl1 _) (hl1 _))]
  have hmain := hnumlim.div hZlim hden
  have hmain' := hmain.congr' (Filter.Eventually.of_forall fun a => (hratio a).symm)
  have hval : (Ω₀ ⬝ᵥ d) * (Ω₀ ⬝ᵥ d) * (Ω₀ ⬝ᵥ (diagonal F *ᵥ Ω₀)) / ((Ω₀ ⬝ᵥ d) * (Ω₀ ⬝ᵥ d)) =
      Ω₀ ⬝ᵥ (diagonal F *ᵥ Ω₀) := by
    exact mul_div_cancel_left₀ _ hden
  rw [hval] at hmain'
  -- the given unit Perron vector is ± Ω₀, and the one-point value is even in Ω
  rcases perron_unit_sign M hM hpos Ω₀ Ω hΩeig₀ hΩ hnorm₀ hn with h | h
  · rw [h]; exact hmain'
  · rw [h]
    have : (-Ω₀) ⬝ᵥ (diagonal F *ᵥ -Ω₀) = Ω₀ ⬝ᵥ (diagonal F *ᵥ Ω₀) := by
      rw [mulVec_neg, neg_dotProduct, dotProduct_neg, neg_neg]
    rw [this]
    exact hmain'

end SlabLimits

section SlabObservables

variable {V Lk : Type*} [DecidableEq V] [Fintype Lk] [DecidableEq Lk]
  {G : Type*} [Group G] [Fintype G] [DecidableEq G] {T : ℕ}

/-- an observable of one cross-section placed at level a -/
def levelObs (F : (Lk → G) → ℝ) (a : Fin (T + 1)) (ω : Fin (T + 1) × Lk → G) : ℝ := F (fun ℓ => ω (a, ℓ))

theorem levelObs_update_of_ne (F : (Lk → G) → ℝ) (a : Fin (T + 1)) (ω : Fin (T + 1) × Lk → G)
    (s : Fin (T + 1) × Lk) (g : G) (hs : s.1 ≠ a) : levelObs F a (Function.update ω s g) = levelObs F a ω := by
  unfold levelObs
  congr 1
  funext ℓ
  exact Function.update_of_ne (fun h => hs (by rw [← h])) _ _

/-- the oscillation bound of a level observable: 2B at its level, 0 elsewhere -/
theorem oscBound_levelObs (F : (Lk → G) → ℝ) (B : ℝ) (hF : ∀ c, |F c| ≤ B) (a : Fin (T + 1)) :
    OscBound (levelObs F a) (fun s => if s.1 = a then 2 * B else 0) := by
  intro s ω g g'
  beta_reduce
  by_cases hs : s.1 = a
  · rw [if_pos hs]
    calc |levelObs F a (Function.update ω s g) - levelObs F a (Function.update ω s g')|
        ≤ |levelObs F a (Function.update ω s g)| + |levelObs F a (Function.update ω s g')| := abs_sub _ _
      _ ≤ B + B := add_le_add (hF _) (hF _)
      _ = 2 * B := by ring
  · rw [if_neg hs, levelObs_update_of_ne F a ω s g hs, levelObs_update_of_ne F a ω s g' hs, sub_self, abs_zero]

end SlabObservables

section SlabGap

variable {V Lk : Type*} [DecidableEq V] [Fintype Lk] [DecidableEq Lk]
  {G : Type*} [Group G] [Fintype G] [DecidableEq G]
  {Λ : Lat V Lk} {ι : Type*} [Fintype ι] [DecidableEq ι] (sq : ι → Square Λ) (w' : G → ℝ)
  (wlo whi : ℝ) (hwlo : 0 < wlo) (hw'lo : ∀ g, wlo ≤ w' g) (hw'hi : ∀ g, w' g ≤ whi)
  (k : Matrix G G ℝ) (hk : k.PosSemidef) (klo khi : ℝ) (hklo : 0 < klo) (hk_lo : ∀ a b, klo ≤ k a b)
  (hk_hi : ∀ a b, k a b ≤ khi)

/-- the slab's Gibbs expectation of a level pair is the path-sum ratio of XTransfer.lean -/
theorem gibbs_slab_pair (T a R : ℕ) (haR : a + R ≤ T) (F : (Lk → G) → ℝ) :
    gibbs (weight (slabFactors sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi T))
        (fun ω => levelObs F ⟨a, by omega⟩ ω * levelObs F ⟨a + R, by omega⟩ ω) =
      pathSum (transfer (plaqWeight sq w') (tensorKernel k)) (ins F a R)
          (fun c => Real.sqrt (plaqWeight sq w' c)) (fun c => Real.sqrt (plaqWeight sq w' c)) 0 T /
        slabZ' (plaqWeight sq w') (tensorKernel k) T := by
  have hD : ∀ c, 0 < plaqWeight sq w' c :=
    fun c => plaqWeight_pos sq w' (fun g => lt_of_lt_of_le hwlo (hw'lo g)) c
  simp only [gibbs, slabZ']
  rw [pathSum_eq_gibbsSum _ hD, pathSum_eq_gibbsSum _ hD]
  congr 1
  · rw [← Equiv.sum_comp (curryEquiv (Fin (T + 1)) Lk G).symm]
    refine sum_congr rfl fun c _ => ?_
    rw [weight_slab, Equiv.apply_symm_apply, prod_insL F a R T haR]
    simp only [curryEquiv, Equiv.coe_fn_symm_mk, levelObs]
    try rfl
  · rw [← Equiv.sum_comp (curryEquiv (Fin (T + 1)) Lk G).symm]
    refine sum_congr rfl fun c _ => ?_
    rw [weight_slab, Equiv.apply_symm_apply]
    simp

theorem gibbs_slab_one (T a : ℕ) (ha : a ≤ T) (F : (Lk → G) → ℝ) :
    gibbs (weight (slabFactors sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi T))
        (levelObs F ⟨a, by omega⟩) =
      pathSum (transfer (plaqWeight sq w') (tensorKernel k)) (ins1 F a)
          (fun c => Real.sqrt (plaqWeight sq w' c)) (fun c => Real.sqrt (plaqWeight sq w' c)) 0 T /
        slabZ' (plaqWeight sq w') (tensorKernel k) T := by
  have hD : ∀ c, 0 < plaqWeight sq w' c :=
    fun c => plaqWeight_pos sq w' (fun g => lt_of_lt_of_le hwlo (hw'lo g)) c
  simp only [gibbs, slabZ']
  rw [pathSum_eq_gibbsSum _ hD, pathSum_eq_gibbsSum _ hD]
  congr 1
  · rw [← Equiv.sum_comp (curryEquiv (Fin (T + 1)) Lk G).symm]
    refine sum_congr rfl fun c _ => ?_
    rw [weight_slab, Equiv.apply_symm_apply, prod_ins1 F a T ha]
    simp only [curryEquiv, Equiv.coe_fn_symm_mk, levelObs]
    try rfl
  · rw [← Equiv.sum_comp (curryEquiv (Fin (T + 1)) Lk G).symm]
    refine sum_congr rfl fun c _ => ?_
    rw [weight_slab, Equiv.apply_symm_apply]
    simp

/-- THE COVARIANCE OF TWO LEVEL OBSERVABLES R LEVELS APART, uniform in the slab's length and the levels: with the
row sums of the slab's interdependence matrix at most α < 1 -/
theorem slab_cov_le (T : ℕ) (α : ℝ) (hα0 : 0 ≤ α) (hα1 : α < 1)
    (C : (Fin (T + 1) × Lk) → (Fin (T + 1) × Lk) → ℝ) (hC0 : ∀ s t, 0 ≤ C s t)
    (hCW : Interdep (weight (slabFactors sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi T)) C)
    (hrow : ∀ s, ∑ t, C s t ≤ α) (hR1 : RangeOne C level)
    (F : (Lk → G) → ℝ) (B : ℝ) (hF : ∀ c, |F c| ≤ B) (a R : ℕ) (haR : a + R ≤ T) :
    |gibbs (weight (slabFactors sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi T))
        (fun ω => levelObs F ⟨a, by omega⟩ ω * levelObs F ⟨a + R, by omega⟩ ω) -
      gibbs (weight (slabFactors sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi T))
        (levelObs F ⟨a, by omega⟩) *
      gibbs (weight (slabFactors sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi T))
        (levelObs F ⟨a + R, by omega⟩)| ≤
      (2 * B + 1) * ((Fintype.card Lk : ℝ) * ((Fintype.card Lk : ℝ) * (2 * B)) * α ^ R / (1 - α)) := by
  set Fs := slabFactors sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi T with hFs
  have hW : ∀ ω, 0 < weight Fs ω := weight_pos Fs
  have hB : 0 ≤ B := le_trans (abs_nonneg _) (hF (fun _ => 1))
  set f : (Fin (T + 1) × Lk → G) → ℝ := levelObs F ⟨a, by omega⟩ with hf
  set g₀ : (Fin (T + 1) × Lk → G) → ℝ := levelObs F ⟨a + R, by omega⟩ with hg₀
  set g : (Fin (T + 1) × Lk → G) → ℝ := fun ω => g₀ ω + (B + 1) with hg
  have hgpos : ∀ ω, 0 < g ω := by
    intro ω
    have := (abs_le.mp (hF (fun ℓ => ω (⟨a + R, by omega⟩, ℓ)))).1
    simp only [hg, hg₀, levelObs]
    linarith
  -- the covariance with the shifted observable is the covariance with the original
  have hcov : gibbs (weight Fs) (fun ω => f ω * g ω) - gibbs (weight Fs) f * gibbs (weight Fs) g =
      gibbs (weight Fs) (fun ω => f ω * g₀ ω) - gibbs (weight Fs) f * gibbs (weight Fs) g₀ := by
    have hZ := sum_W_pos (weight Fs) hW
    have hA : ∑ ω, weight Fs ω * g ω = ∑ ω, weight Fs ω * g₀ ω + (B + 1) * ∑ ω, weight Fs ω := by
      simp only [hg, mul_add, sum_add_distrib, ← sum_mul]
      ring
    have hB' : ∑ ω, weight Fs ω * (f ω * g ω)
        = ∑ ω, weight Fs ω * (f ω * g₀ ω) + (B + 1) * ∑ ω, weight Fs ω * f ω := by
      have hpt : ∀ ω, weight Fs ω * (f ω * g ω)
          = weight Fs ω * (f ω * g₀ ω) + (weight Fs ω * f ω) * (B + 1) := fun ω => by
        simp only [hg]
        ring
      simp only [hpt, sum_add_distrib, ← sum_mul]
      ring
    simp only [gibbs]
    rw [hA, hB']
    field_simp
    ring
  -- the oscillation bound and the reading sets
  have hosc := oscBound_levelObs F B hF (⟨a, by omega⟩ : Fin (T + 1))
  have hd : ∀ t : Fin (T + 1) × Lk, a < level t →
      (fun s : Fin (T + 1) × Lk => if s.1 = (⟨a, by omega⟩ : Fin (T + 1)) then 2 * B else 0) t = 0 := by
    intro t ht
    simp only [level] at ht
    beta_reduce
    rw [if_neg]
    intro h
    rw [h] at ht
    simp at ht
  have hfree : ∀ s : Fin (T + 1) × Lk, ¬ (s.1 = (⟨a + R, by omega⟩ : Fin (T + 1))) → ∀ ω x,
      g (Function.update ω s x) = g ω := by
    intro s hs ω x
    simp only [hg, hg₀]
    rw [levelObs_update_of_ne F _ ω s x hs]
  have hreads : ∀ t : Fin (T + 1) × Lk, level t < a + R → ¬ (t.1 = (⟨a + R, by omega⟩ : Fin (T + 1))) := by
    intro t ht h
    simp only [level] at ht
    rw [h] at ht
    simp at ht
  have hmain := cov_le (weight Fs) hW C hC0 hCW α hα0 hα1
    hrow level hR1 f _ hosc a R hd
    g hgpos (fun s => s.1 = (⟨a + R, by omega⟩ : Fin (T + 1))) hfree hreads
  rw [hcov] at hmain
  -- the constants: gibbs g ≤ 2B + 1, the reading sites number |Lk|, the oscillation mass |Lk| · 2B
  have hgle : gibbs (weight Fs) g ≤ 2 * B + 1 := by
    apply gibbs_le_of_le _ hW
    intro ω
    have := (abs_le.mp (hF (fun ℓ => ω (⟨a + R, by omega⟩, ℓ)))).2
    simp only [hg, hg₀, levelObs]
    linarith
  have hreadsum : (∑ t : Fin (T + 1) × Lk, if t.1 = (⟨a + R, by omega⟩ : Fin (T + 1)) then (1 : ℝ) else 0) =
      Fintype.card Lk := by
    rw [Fintype.sum_prod_type, Finset.sum_comm]
    simp only [Finset.sum_ite_eq', Finset.mem_univ, ite_true, Finset.sum_const, Finset.card_univ,
      nsmul_eq_mul, mul_one]
  have hdsum : (∑ t : Fin (T + 1) × Lk, if t.1 = (⟨a, by omega⟩ : Fin (T + 1)) then 2 * B else 0) =
      (Fintype.card Lk : ℝ) * (2 * B) := by
    rw [Fintype.sum_prod_type, Finset.sum_comm]
    simp only [Finset.sum_ite_eq', Finset.mem_univ, ite_true, Finset.sum_const, Finset.card_univ,
      nsmul_eq_mul]
  rw [hreadsum, hdsum] at hmain
  calc |gibbs (weight Fs) (fun ω => f ω * g₀ ω) - gibbs (weight Fs) f * gibbs (weight Fs) g₀|
      ≤ gibbs (weight Fs) g * ((Fintype.card Lk : ℝ) * ((Fintype.card Lk : ℝ) * (2 * B)) * α ^ R / (1 - α)) :=
        hmain
    _ ≤ (2 * B + 1) * ((Fintype.card Lk : ℝ) * ((Fintype.card Lk : ℝ) * (2 * B)) * α ^ R / (1 - α)) := by
        apply mul_le_mul_of_nonneg_right hgle
        have h1α : 0 < 1 - α := by linarith
        positivity

/-- THE DECAY OF EVERY TWO-POINT FUNCTION IN THE INFINITE SLAB: with the slab's row sums at most α < 1 at every
length, every vector's two-point function on the transfer matrix decays to its Perron mass at rate α -/
theorem slab_decay (α : ℝ) (hα0 : 0 ≤ α) (hα1 : α < 1)
    (C : (T : ℕ) → (Fin (T + 1) × Lk) → (Fin (T + 1) × Lk) → ℝ) (hC0 : ∀ T s t, 0 ≤ C T s t)
    (hCW : ∀ T, Interdep (weight (slabFactors sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi T)) (C T))
    (hrow : ∀ T s, ∑ t, C T s t ≤ α) (hR1 : ∀ T, RangeOne (C T) level)
    (Ω : (Lk → G) → ℝ)
    (hΩ : transfer (plaqWeight sq w') (tensorKernel k) *ᵥ Ω =
      lamMax (transfer (plaqWeight sq w') (tensorKernel k))
        (transfer_posSemidef (plaqWeight sq w') _ (tensorKernel_posSemidef k hk)).1 • Ω)
    (hn : Ω ⬝ᵥ Ω = 1) (hne : ∀ c, Ω c ≠ 0) (f : (Lk → G) → ℝ) :
    ∃ Kc : ℝ, ∀ R : ℕ,
      |f ⬝ᵥ ((transfer (plaqWeight sq w') (tensorKernel k) ^ R) *ᵥ f) /
          lamMax (transfer (plaqWeight sq w') (tensorKernel k))
            (transfer_posSemidef (plaqWeight sq w') _ (tensorKernel_posSemidef k hk)).1 ^ R - (Ω ⬝ᵥ f) ^ 2| ≤
        Kc * α ^ R := by
  set D := plaqWeight sq w' with hDdef
  set K : Matrix (Lk → G) (Lk → G) ℝ := tensorKernel k with hKdef
  set M := transfer D K with hMdef
  have hD : ∀ c, 0 < D c := fun c => plaqWeight_pos sq w' (fun g => lt_of_lt_of_le hwlo (hw'lo g)) c
  have hK : K.PosSemidef := tensorKernel_posSemidef k hk
  have hKpos : ∀ c c', 0 < K c c' := tensorKernel_pos k fun a b => lt_of_lt_of_le hklo (hk_lo a b)
  set l := lamMax M (transfer_posSemidef D K hK).1 with hl
  have hlpos : 0 < l := (perron_exists M (transfer_posSemidef D K hK).1 (transfer_pos D hD K hKpos)).choose_spec.2.2
  -- the observable whose Perron image is f
  set F : (Lk → G) → ℝ := fun c => f c / Ω c with hFdef
  have hFΩ : diagonal F *ᵥ Ω = f := by
    funext c
    rw [mulVec_diagonal]
    simp only [hFdef]
    field_simp [hne c]
  set B : ℝ := ∑ c, |F c| with hBdef
  have hF : ∀ c, |F c| ≤ B := fun c => single_le_sum (fun c _ => abs_nonneg (F c)) (mem_univ c)
  refine ⟨(2 * B + 1) * ((Fintype.card Lk : ℝ) * ((Fintype.card Lk : ℝ) * (2 * B)) / (1 - α)), fun R => ?_⟩
  -- the finite-slab covariance at length 2(a+1)+R, levels a+1 and a+1+R, for every a
  have hfin : ∀ a : ℕ,
      |slabNum D K F (a + 1) R / slabZ D K (a + 1) R -
        slabOne D K F (a + 1) (a + 1 + R) / slabZ' D K (a + 1 + (a + 1 + R)) *
        (slabOne D K F (a + 1 + R) (a + 1) / slabZ' D K (a + 1 + R + (a + 1)))| ≤
      (2 * B + 1) * ((Fintype.card Lk : ℝ) * ((Fintype.card Lk : ℝ) * (2 * B)) / (1 - α)) * α ^ R := by
    intro a
    have hT : a + 1 + R ≤ 2 * (a + 1) + R := by omega
    have hc := slab_cov_le sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi (2 * (a + 1) + R) α hα0 hα1
      (C _) (hC0 _) (hCW _) (hrow _) (hR1 _) F B hF (a + 1) R hT
    rw [gibbs_slab_pair sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi _ _ _ hT,
      gibbs_slab_one sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi _ _ (by omega),
      gibbs_slab_one sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi _ _ (by omega)] at hc
    have e1 : 2 * (a + 1) + R = a + 1 + (a + 1 + R) := by ring
    have e2 : a + 1 + R + (a + 1) = a + 1 + (a + 1 + R) := by ring
    simp only [slabZ'] at hc
    rw [e1, ← hDdef, ← hKdef] at hc
    simp only [slabNum, slabZ, slabOne, slabZ']
    rw [e1, e2]
    exact hc.trans_eq (by ring)
  -- the limits of the three slab functions
  have hlim2 := slab_tendsto' D hD K hK hKpos F Ω hΩ hn R
  have hlim1 := slab_one_tendsto D hD K hK hKpos F Ω hΩ hn (fun a => a + 1) (fun a => a + 1 + R)
    (tendsto_add_atTop_nat 1) (tendsto_add_atTop_nat (1 + R) |>.congr fun a => by ring)
  have hlim1' := slab_one_tendsto D hD K hK hKpos F Ω hΩ hn (fun a => a + 1 + R) (fun a => a + 1)
    (tendsto_add_atTop_nat (1 + R) |>.congr fun a => by ring) (tendsto_add_atTop_nat 1)
  have hlimcov : Tendsto (fun a : ℕ => |slabNum D K F (a + 1) R / slabZ D K (a + 1) R -
      slabOne D K F (a + 1) (a + 1 + R) / slabZ' D K (a + 1 + (a + 1 + R)) *
      (slabOne D K F (a + 1 + R) (a + 1) / slabZ' D K (a + 1 + R + (a + 1)))|) atTop
      (𝓝 |(diagonal F *ᵥ Ω) ⬝ᵥ (M ^ R *ᵥ (diagonal F *ᵥ Ω)) / l ^ R -
        (Ω ⬝ᵥ (diagonal F *ᵥ Ω)) * (Ω ⬝ᵥ (diagonal F *ᵥ Ω))|) :=
    (hlim2.sub (hlim1.mul hlim1')).abs
  have hle := le_of_tendsto' hlimcov hfin
  rw [hFΩ] at hle
  have hsq : (Ω ⬝ᵥ f) * (Ω ⬝ᵥ f) = (Ω ⬝ᵥ f) ^ 2 := by ring
  rw [hsq] at hle
  exact hle

/-- THE MASS GAP UNIFORM IN THE CROSS-SECTION AT STRONG COUPLING: every eigenvalue of the transfer matrix other
than the Perron root is at most α λ₀ -/
theorem transfer_gap_uniform (α : ℝ) (hα0 : 0 ≤ α) (hα1 : α < 1)
    (C : (T : ℕ) → (Fin (T + 1) × Lk) → (Fin (T + 1) × Lk) → ℝ) (hC0 : ∀ T s t, 0 ≤ C T s t)
    (hCW : ∀ T, Interdep (weight (slabFactors sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi T)) (C T))
    (hrow : ∀ T s, ∑ t, C T s t ≤ α) (hR1 : ∀ T, RangeOne (C T) level)
    (j : Lk → G)
    (hj : (transfer_posSemidef (plaqWeight sq w') _ (tensorKernel_posSemidef k hk)).1.eigenvalues j ≠
      lamMax (transfer (plaqWeight sq w') (tensorKernel k))
        (transfer_posSemidef (plaqWeight sq w') _ (tensorKernel_posSemidef k hk)).1) :
    (transfer_posSemidef (plaqWeight sq w') _ (tensorKernel_posSemidef k hk)).1.eigenvalues j ≤
      α * lamMax (transfer (plaqWeight sq w') (tensorKernel k))
        (transfer_posSemidef (plaqWeight sq w') _ (tensorKernel_posSemidef k hk)).1 := by
  set D := plaqWeight sq w' with hDdef
  set K : Matrix (Lk → G) (Lk → G) ℝ := tensorKernel k with hKdef
  have hD : ∀ c, 0 < D c := fun c => plaqWeight_pos sq w' (fun g => lt_of_lt_of_le hwlo (hw'lo g)) c
  have hK : K.PosSemidef := tensorKernel_posSemidef k hk
  have hKpos : ∀ c c', 0 < K c c' := tensorKernel_pos k fun a b => lt_of_lt_of_le hklo (hk_lo a b)
  obtain ⟨Ω, hn, hΩ, hne, -⟩ := slab_tendsto D hD K hK hKpos (fun _ => (1 : ℝ))
  exact eigenvalue_le_of_decay (transfer D K) (transfer_posSemidef D K hK) (transfer_pos D hD K hKpos) Ω hΩ α hα0
    (slab_decay sq w' wlo whi hwlo hw'lo hw'hi k hk klo khi hklo hk_lo hk_hi α hα0 hα1 C hC0 hCW hrow hR1 Ω hΩ hn hne)
    j hj

/-- THE RATIO INSTANCE: the factor system's own interdependence matrix, C = 1 − ρ⁻² -/
theorem transfer_gap_ratio (α : ℝ) (hα0 : 0 ≤ α) (hα1 : α < 1)
    (hrow : ∀ T s, ∑ t, interdepMat (slabFactors sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi T) s t ≤ α)
    (j : Lk → G)
    (hj : (transfer_posSemidef (plaqWeight sq w') _ (tensorKernel_posSemidef k hk)).1.eigenvalues j ≠
      lamMax (transfer (plaqWeight sq w') (tensorKernel k))
        (transfer_posSemidef (plaqWeight sq w') _ (tensorKernel_posSemidef k hk)).1) :
    (transfer_posSemidef (plaqWeight sq w') _ (tensorKernel_posSemidef k hk)).1.eigenvalues j ≤
      α * lamMax (transfer (plaqWeight sq w') (tensorKernel k))
        (transfer_posSemidef (plaqWeight sq w') _ (tensorKernel_posSemidef k hk)).1 :=
  transfer_gap_uniform sq w' wlo whi hwlo hw'lo hw'hi k hk klo khi hklo hk_lo hk_hi α hα0 hα1
    (fun T => interdepMat (slabFactors sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi T))
    (fun T => interdepMat_nonneg _) (fun T => interdep_factors _) hrow
    (fun T => slab_rangeOne sq w' wlo whi hwlo hw'lo hw'hi k klo khi hklo hk_lo hk_hi T) j hj

end SlabGap

end Aperanton
