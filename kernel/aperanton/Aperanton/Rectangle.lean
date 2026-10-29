/-
  APERANTON -- THE BOUNDLESS, stage A5 (third landing): THE STRING TENSION OF Z₂ LATTICE GAUGE THEORY EXISTS.

  The lattice is ℤ³ (a link a site and a direction, a plaquette a site and its normal), the loop the R × T rectangle
  in the (0,1)-plane.  Three facts, each proved: (G1) the rectangle of width R₁ + R₂ is the xor of the rectangle of
  width R₁ and the rectangle of width R₂ shifted by R₁ (the shared side cancels); (G2) the infinite-volume
  expectation is translation invariant; (G3) Griffiths II survives the limit, W_∞(A ⊕ B) ≥ W_∞(A) W_∞(B), and the
  rectangle's expectation is positive (the minimal surface is a surface bounded by it, ∂(surf R T) = rect R T).
  Hence R ↦ −log W_∞(R × T) is subadditive and bounded below, and Fekete's lemma (Mathlib's
  `Subadditive.tendsto_lim`) gives the limit σ(T) = lim −log W_∞(R × T)/R: THE STRING TENSION EXISTS as a theorem.
  Mechanism S, second half.  No sorry, no axiom.
-/
import Mathlib
import Aperanton.Lattice

open Finset Filter Topology

set_option maxHeartbeats 800000

namespace Aperanton

/-- a site of ℤ³ -/
abbrev Site := ℤ × ℤ × ℤ
/-- a link: a site and a direction -/
abbrev Link := Site × Fin 3
/-- a plaquette: a site and the direction normal to its plane -/
abbrev Plaq := Site × Fin 3

/-- the unit vectors -/
def unit : Fin 3 → Site := ![(1, 0, 0), (0, 1, 0), (0, 0, 1)]

/-- the two directions spanning the plane normal to k -/
def plane : Fin 3 → Fin 3 × Fin 3 := ![(1, 2), (0, 2), (0, 1)]

/-- the four links of a plaquette -/
def plaqZ (p : Plaq) : Finset Link :=
  {(p.1, (plane p.2).1), (p.1, (plane p.2).2), (p.1 + unit (plane p.2).1, (plane p.2).2),
    (p.1 + unit (plane p.2).2, (plane p.2).1)}

/-- translation of links and plaquettes -/
def shiftL (v : Site) (l : Link) : Link := (l.1 + v, l.2)
def shiftP (v : Site) (p : Plaq) : Plaq := (p.1 + v, p.2)

theorem shiftL_injective (v : Site) : Function.Injective (shiftL v) := by
  intro l l' h
  simp only [shiftL, Prod.mk.injEq] at h
  exact Prod.ext (add_right_cancel h.1) h.2

theorem shiftP_injective (v : Site) : Function.Injective (shiftP v) := by
  intro p p' h
  simp only [shiftP, Prod.mk.injEq] at h
  exact Prod.ext (add_right_cancel h.1) h.2

def shiftLEmb (v : Site) : Link ↪ Link := ⟨shiftL v, shiftL_injective v⟩
def shiftPEmb (v : Site) : Plaq ↪ Plaq := ⟨shiftP v, shiftP_injective v⟩

theorem shiftL_neg_shiftL (v : Site) (l : Link) : shiftL (-v) (shiftL v l) = l := by
  simp [shiftL, add_assoc]

theorem shiftL_shiftL_neg (v : Site) (l : Link) : shiftL v (shiftL (-v) l) = l := by
  simp [shiftL, add_assoc]

theorem shiftP_neg_shiftP (v : Site) (p : Plaq) : shiftP (-v) (shiftP v p) = p := by
  simp [shiftP, add_assoc]

theorem shiftP_shiftP_neg (v : Site) (p : Plaq) : shiftP v (shiftP (-v) p) = p := by
  simp [shiftP, add_assoc]

/-- a shifted plaquette's links are the shifted links -/
theorem mem_plaqZ_shift (v : Site) (p : Plaq) (l : Link) :
    shiftL v l ∈ plaqZ (shiftP v p) ↔ l ∈ plaqZ p := by
  obtain ⟨ls, ld⟩ := l
  simp only [plaqZ, shiftL, shiftP, Finset.mem_insert, Finset.mem_singleton, Prod.mk.injEq,
    add_right_comm _ v, add_left_inj]

/-- the boundary is translation covariant -/
theorem bdL_shift (v : Site) (t : Finset Plaq) (l : Link) :
    bdL (toInd plaqZ) (t.map (shiftPEmb v)) (shiftL v l) = bdL (toInd plaqZ) t l := by
  simp only [bdL, Finset.filter_map, Finset.card_map]
  congr 3
  apply Finset.filter_congr
  intro p _
  simp only [Function.comp_def, shiftPEmb, Function.Embedding.coeFn_mk, toInd, decide_eq_true_eq]
  exact mem_plaqZ_shift v p l

/-- the powerset of a shifted box is the shifted powerset: a sum over it reindexes -/
theorem sum_powerset_shift (v : Site) (Λ : Finset Plaq) (F : Finset Plaq → ℝ) :
    ∑ t ∈ (Λ.map (shiftPEmb v)).powerset, F t = ∑ t ∈ Λ.powerset, F (t.map (shiftPEmb v)) := by
  symm
  refine Finset.sum_bij' (fun t _ => t.map (shiftPEmb v)) (fun t _ => t.map (shiftPEmb (-v))) ?_ ?_ ?_ ?_ ?_
  · intro t ht
    rw [Finset.mem_powerset] at ht ⊢
    exact Finset.map_subset_map.mpr ht
  · intro t ht
    rw [Finset.mem_powerset] at ht ⊢
    intro p hp
    rw [Finset.mem_map] at hp
    obtain ⟨q, hq, rfl⟩ := hp
    have hq' := ht hq
    rw [Finset.mem_map] at hq'
    obtain ⟨r, hr, rfl⟩ := hq'
    simpa [shiftPEmb, shiftP_neg_shiftP] using hr
  · intro t _
    rw [Finset.map_map]
    have he : (shiftPEmb v).trans (shiftPEmb (-v)) = Function.Embedding.refl Plaq := by
      ext p : 1
      simp [shiftPEmb, shiftP_neg_shiftP]
    rw [he, Finset.map_refl]
  · intro t _
    rw [Finset.map_map]
    have he : (shiftPEmb (-v)).trans (shiftPEmb v) = Function.Embedding.refl Plaq := by
      ext p : 1
      simp [shiftPEmb, shiftP_shiftP_neg]
    rw [he, Finset.map_refl]
  · intro t _
    rfl

/-- (G2) THE BOX EXPECTATION IS TRANSLATION INVARIANT at uniform coupling -/
theorem WcL_shift (y : ℝ) (v : Site) (Λ : Finset Plaq) (A : Link → Bool) :
    WcL (toInd plaqZ) (fun _ => y) (Λ.map (shiftPEmb v)) (fun l => A (shiftL (-v) l))
      = WcL (toInd plaqZ) (fun _ => y) Λ A := by
  classical
  unfold WcL
  have hbd : ∀ (B : Link → Bool) (t : Finset Plaq),
      (bdL (toInd plaqZ) (t.map (shiftPEmb v)) = fun l => B (shiftL (-v) l)) ↔ bdL (toInd plaqZ) t = B := by
    intro B t
    constructor
    · intro h
      funext l
      have := congrFun h (shiftL v l)
      rw [bdL_shift, shiftL_neg_shiftL] at this
      exact this
    · intro h
      funext l
      rw [← shiftL_shiftL_neg v l, bdL_shift, shiftL_neg_shiftL, h]
  have key : ∀ B : Link → Bool,
      (∑ t ∈ (Λ.map (shiftPEmb v)).powerset, if bdL (toInd plaqZ) t = (fun l => B (shiftL (-v) l))
          then ∏ _p ∈ t, y else 0)
        = ∑ t ∈ Λ.powerset, if bdL (toInd plaqZ) t = B then ∏ _p ∈ t, y else 0 := by
    intro B
    rw [sum_powerset_shift]
    apply Finset.sum_congr rfl
    intro t _
    rw [Finset.prod_const, Finset.prod_const, Finset.card_map]
    by_cases h : bdL (toInd plaqZ) t = B
    · rw [if_pos h, if_pos ((hbd B t).mpr h)]
    · rw [if_neg h, if_neg (fun h' => h ((hbd B t).mp h'))]
  rw [key A]
  have hz : (fun l : Link => (fun _ : Link => false) (shiftL (-v) l)) = fun _ => false := rfl
  rw [← hz, key (fun _ => false)]

/-- the shift of boxes is onto -/
theorem shiftP_map_surjective (v : Site) :
    Function.Surjective (fun Λ : Finset Plaq => Λ.map (shiftPEmb v)) := by
  intro Λ'
  refine ⟨Λ'.map (shiftPEmb (-v)), ?_⟩
  show Finset.map (shiftPEmb v) (Finset.map (shiftPEmb (-v)) Λ') = Λ'
  rw [Finset.map_map]
  have he : (shiftPEmb (-v)).trans (shiftPEmb v) = Function.Embedding.refl Plaq := by
    ext p : 1
    simp [shiftPEmb, shiftP_shiftP_neg]
  rw [he, Finset.map_refl]

/-- (G2) THE INFINITE-VOLUME EXPECTATION IS TRANSLATION INVARIANT -/
theorem Winf_shift (y : ℝ) (v : Site) (A : Link → Bool) :
    Winf plaqZ (fun _ => y) (fun l => A (shiftL (-v) l)) = Winf plaqZ (fun _ => y) A := by
  unfold Winf
  rw [← (shiftP_map_surjective v).iSup_comp]
  simp only [WcL_shift]

/-- the xor of two decisions is the decision of their inequivalence -/
theorem xor_decide (p q : Prop) [Decidable p] [Decidable q] :
    xor (decide p) (decide q) = decide (¬(p ↔ q)) := by
  by_cases hp : p <;> by_cases hq : q <;> simp [hp, hq]

/-- the rectangle loop of width R and height T in the (0,1)-plane at height 0: a horizontal link at height b is
on it iff exactly one of b = 0, b = T holds (so a degenerate rectangle is the empty loop), and likewise a
vertical link at abscissa a -/
def rect (R T : ℕ) : Link → Bool := fun l =>
  decide ((l.2 = 0 ∧ l.1.2.2 = 0 ∧ ((l.1.2.1 = 0 ∧ l.1.2.1 ≠ (T : ℤ)) ∨ (l.1.2.1 = (T : ℤ) ∧ l.1.2.1 ≠ 0))
            ∧ 0 ≤ l.1.1 ∧ l.1.1 < (R : ℤ)) ∨
          (l.2 = 1 ∧ l.1.2.2 = 0 ∧ ((l.1.1 = 0 ∧ l.1.1 ≠ (R : ℤ)) ∨ (l.1.1 = (R : ℤ) ∧ l.1.1 ≠ 0))
            ∧ 0 ≤ l.1.2.1 ∧ l.1.2.1 < (T : ℤ)))

/-- (G1) THE RECTANGLE OF WIDTH R₁ + R₂ IS THE XOR OF TWO RECTANGLES SIDE BY SIDE: the shared side cancels -/
theorem rect_add (R₁ R₂ T : ℕ) (l : Link) :
    rect (R₁ + R₂) T l = xor (rect R₁ T l) (rect R₂ T (shiftL (-((R₁ : ℤ), (0 : ℤ), (0 : ℤ))) l)) := by
  obtain ⟨⟨a, b, c⟩, d⟩ := l
  simp only [rect, shiftL, Prod.neg_mk, neg_zero, Prod.mk_add_mk, add_zero, Nat.cast_add]
  rw [xor_decide, decide_eq_decide]
  fin_cases d <;> simp <;> omega

/-- the plaquettes of the cube [−n, n]³, all orientations -/
def cube (n : ℕ) : Finset Plaq :=
  (Finset.Icc (-(n : ℤ)) n ×ˢ Finset.Icc (-(n : ℤ)) n ×ˢ Finset.Icc (-(n : ℤ)) n) ×ˢ (Finset.univ : Finset (Fin 3))

theorem mem_cube (n : ℕ) (p : Plaq) :
    p ∈ cube n ↔ (-(n : ℤ) ≤ p.1.1 ∧ p.1.1 ≤ n) ∧ (-(n : ℤ) ≤ p.1.2.1 ∧ p.1.2.1 ≤ n) ∧
      (-(n : ℤ) ≤ p.1.2.2 ∧ p.1.2.2 ≤ n) := by
  simp [cube, Finset.mem_product, Finset.mem_Icc]

theorem cube_mono : Monotone cube := by
  intro m n hmn p hp
  rw [mem_cube] at hp ⊢
  omega

theorem cube_exhausts (S : Finset Plaq) : ∃ n, S ⊆ cube n := by
  refine ⟨S.sup (fun p => (p.1.1.natAbs ⊔ p.1.2.1.natAbs) ⊔ p.1.2.2.natAbs), ?_⟩
  intro p hp
  have h := Finset.le_sup (f := fun p : Plaq => (p.1.1.natAbs ⊔ p.1.2.1.natAbs) ⊔ p.1.2.2.natAbs) hp
  rw [mem_cube]
  simp only [sup_le_iff] at h
  omega

/-- the R × T rectangle of plaquettes in the (0,1)-plane -/
def surf (R T : ℕ) : Finset Plaq :=
  (Finset.range R ×ˢ Finset.range T).image
    (fun ab : ℕ × ℕ => ((((ab.1 : ℕ) : ℤ), ((ab.2 : ℕ) : ℤ), (0 : ℤ)), (2 : Fin 3)))

theorem mem_surf (R T : ℕ) (p : Plaq) :
    p ∈ surf R T ↔ p.2 = 2 ∧ p.1.2.2 = 0 ∧ 0 ≤ p.1.1 ∧ p.1.1 < R ∧ 0 ≤ p.1.2.1 ∧ p.1.2.1 < T := by
  obtain ⟨⟨a, b, c⟩, d⟩ := p
  simp only [surf, Finset.mem_image, Finset.mem_product, Finset.mem_range, Prod.mk.injEq, Prod.exists]
  constructor
  · rintro ⟨i, j, ⟨hi, hj⟩, ⟨rfl, rfl, rfl⟩, rfl⟩
    refine ⟨rfl, rfl, ?_, ?_, ?_, ?_⟩ <;> omega
  · rintro ⟨rfl, rfl, ha0, haR, hb0, hbT⟩
    exact ⟨a.toNat, b.toNat, ⟨by omega, by omega⟩, ⟨by omega, by omega, rfl⟩, rfl⟩

/-- the rectangle's links are links of the cube containing it -/
theorem rect_subset_links (R T n : ℕ) (hR : R ≤ n) (hT : T ≤ n) :
    ∀ l, rect R T l = true → l ∈ linksOf plaqZ (cube n) := by
  intro l hl
  obtain ⟨⟨a, b, c⟩, d⟩ := l
  simp only [rect, decide_eq_true_eq] at hl
  unfold linksOf
  rw [Finset.mem_biUnion]
  rcases hl with ⟨hd, hc, hb, ha0, haR⟩ | ⟨hd, hc, ha, hb0, hbT⟩
  · refine ⟨((a, b, c), 2), ?_, ?_⟩
    · rw [mem_cube]; simp only; omega
    · subst hd hc; simp [plaqZ, plane]
  · refine ⟨((a, b, c), 2), ?_, ?_⟩
    · rw [mem_cube]; simp only; omega
    · subst hd hc; simp [plaqZ, plane]

/-- the shifted rectangle's links are links of the cube containing it -/
theorem rect_shift_subset_links (R₁ R T n : ℕ) (hR : R₁ + R ≤ n) (hT : T ≤ n) :
    ∀ l, rect R T (shiftL (-((R₁ : ℤ), (0 : ℤ), (0 : ℤ))) l) = true → l ∈ linksOf plaqZ (cube n) := by
  intro l hl
  obtain ⟨⟨a, b, c⟩, d⟩ := l
  simp only [rect, shiftL, Prod.neg_mk, neg_zero, Prod.mk_add_mk, add_zero, decide_eq_true_eq] at hl
  unfold linksOf
  rw [Finset.mem_biUnion]
  rcases hl with ⟨hd, hc, hb, ha0, haR⟩ | ⟨hd, hc, ha, hb0, hbT⟩
  · refine ⟨((a, b, c), 2), ?_, ?_⟩
    · rw [mem_cube]; simp only; omega
    · subst hd hc; simp [plaqZ, plane]
  · refine ⟨((a, b, c), 2), ?_, ?_⟩
    · rw [mem_cube]; simp only; omega
    · subst hd hc; simp [plaqZ, plane]

/-- a column of the surface: the width-one surface shifted to x = R -/
theorem surf_succ (R T : ℕ) : surf (R + 1) T = surf R T ∪ (surf 1 T).map (shiftPEmb ((R : ℤ), 0, 0)) := by
  ext ⟨⟨a, b, c⟩, d⟩
  simp only [Finset.mem_union, Finset.mem_map, mem_surf, shiftPEmb, Function.Embedding.coeFn_mk, shiftP,
    Nat.cast_add, Nat.cast_one]
  constructor
  · rintro ⟨hd, hc, ha0, haR, hb0, hbT⟩
    by_cases hx : a < R
    · left; exact ⟨hd, hc, ha0, hx, hb0, hbT⟩
    · right
      refine ⟨((a - R, b, c), d), ⟨hd, hc, ?_, ?_, hb0, hbT⟩, ?_⟩
      · show (0 : ℤ) ≤ a - R
        omega
      · show a - (R : ℤ) < ((1 : ℕ) : ℤ)
        omega
      · simp
  · rintro (⟨hd, hc, ha0, haR, hb0, hbT⟩ | ⟨⟨⟨a', b', c'⟩, d'⟩, ⟨hd, hc, ha0, ha1, hb0, hbT⟩, heq⟩)
    · exact ⟨hd, hc, ha0, by omega, hb0, hbT⟩
    · simp only [Prod.mk_add_mk, add_zero, Prod.mk.injEq] at heq
      obtain ⟨⟨rfl, rfl, rfl⟩, rfl⟩ := heq
      simp only at hd hc ha0 ha1 hb0 hbT ⊢
      exact ⟨hd, hc, by omega, by omega, hb0, hbT⟩

theorem surf_disjoint_column (R T : ℕ) :
    Disjoint (surf R T) ((surf 1 T).map (shiftPEmb ((R : ℤ), 0, 0))) := by
  rw [Finset.disjoint_left]
  rintro ⟨⟨a, b, c⟩, d⟩ hp hp'
  rw [mem_surf] at hp
  rw [Finset.mem_map] at hp'
  obtain ⟨⟨⟨a', b', c'⟩, d'⟩, hq, heq⟩ := hp'
  rw [mem_surf] at hq
  simp only [shiftPEmb, Function.Embedding.coeFn_mk, shiftP, Prod.mk_add_mk, add_zero, Prod.mk.injEq] at heq
  obtain ⟨⟨rfl, rfl, rfl⟩, rfl⟩ := heq
  simp only at hp hq
  omega

theorem surf_one_succ (T : ℕ) :
    surf 1 (T + 1) = insert (((0 : ℤ), (T : ℤ), (0 : ℤ)), (2 : Fin 3)) (surf 1 T) := by
  ext ⟨⟨a, b, c⟩, d⟩
  rw [Finset.mem_insert, mem_surf, mem_surf]
  simp only [Prod.mk.injEq, Nat.cast_add, Nat.cast_one]
  constructor
  · rintro ⟨hd, hc, ha0, ha1, hb0, hbT⟩
    by_cases hb : b = T
    · left; exact ⟨⟨by omega, hb, hc⟩, hd⟩
    · right; exact ⟨hd, hc, ha0, ha1, hb0, by omega⟩
  · rintro (⟨⟨rfl, rfl, rfl⟩, rfl⟩ | ⟨hd, hc, ha0, ha1, hb0, hbT⟩)
    · exact ⟨rfl, rfl, le_rfl, by norm_num, by omega, by omega⟩
    · exact ⟨hd, hc, ha0, ha1, hb0, by omega⟩

theorem surf_zero_left (T : ℕ) : surf 0 T = ∅ := by
  ext p; rw [mem_surf]; simp; omega

theorem surf_one_zero : surf 1 0 = ∅ := by
  ext p; rw [mem_surf]; simp

theorem top_plaquette_notMem (T : ℕ) : (((0 : ℤ), (T : ℤ), (0 : ℤ)), (2 : Fin 3)) ∉ surf 1 T := by
  rw [mem_surf]; simp

/-- the links of the plaquette at (0, T, 0) in the (0,1)-plane, read as an indicator -/
theorem toInd_top_plaquette (T : ℕ) (l : Link) :
    toInd plaqZ (((0 : ℤ), (T : ℤ), (0 : ℤ)), (2 : Fin 3)) l
      = decide ((l.2 = 0 ∧ l.1.2.2 = 0 ∧ (l.1.2.1 = (T : ℤ) ∨ l.1.2.1 = (T : ℤ) + 1) ∧ l.1.1 = 0) ∨
                (l.2 = 1 ∧ l.1.2.2 = 0 ∧ l.1.2.1 = (T : ℤ) ∧ (l.1.1 = 0 ∨ l.1.1 = 1))) := by
  obtain ⟨⟨a, b, c⟩, d⟩ := l
  simp only [toInd, plaqZ, plane, unit, Finset.mem_insert, Finset.mem_singleton, Prod.mk.injEq,
    Prod.mk_add_mk]
  rw [decide_eq_decide]
  fin_cases d <;> simp <;> omega

/-- (G1′) the width-one rectangle grows by one plaquette at its top -/
theorem rect_one_succ (T : ℕ) (l : Link) :
    rect 1 (T + 1) l = xor (rect 1 T l) (toInd plaqZ (((0 : ℤ), (T : ℤ), (0 : ℤ)), (2 : Fin 3)) l) := by
  rw [toInd_top_plaquette]
  obtain ⟨⟨a, b, c⟩, d⟩ := l
  simp only [rect, Nat.cast_add, Nat.cast_one]
  rw [xor_decide, decide_eq_decide]
  fin_cases d <;> simp <;> omega

/-- the empty surface has the empty boundary, and the empty loop is the degenerate rectangle -/
theorem bdL_empty_plaq : bdL (toInd plaqZ) (∅ : Finset Plaq) = fun _ => false := by
  funext l; simp [bdL]

theorem rect_zero_left (T : ℕ) : rect 0 T = fun _ => false := by
  funext ⟨⟨a, b, c⟩, d⟩
  simp only [rect]
  apply decide_eq_false
  fin_cases d <;> simp <;> omega

theorem rect_zero_right (R : ℕ) : rect R 0 = fun _ => false := by
  funext ⟨⟨a, b, c⟩, d⟩
  simp only [rect]
  apply decide_eq_false
  fin_cases d <;> simp <;> omega

/-- THE MINIMAL SURFACE IS BOUNDED BY THE RECTANGLE: ∂(surf R T) = rect R T -/
theorem bdL_surf_one (T : ℕ) : bdL (toInd plaqZ) (surf 1 T) = rect 1 T := by
  induction T with
  | zero => rw [surf_one_zero, bdL_empty_plaq, rect_zero_right]
  | succ T ih =>
    rw [surf_one_succ, bdL_insert _ _ _ (top_plaquette_notMem T), ih]
    funext l
    rw [rect_one_succ]
    rcases Bool.eq_false_or_eq_true (rect 1 T l) with h1 | h1 <;>
      rcases Bool.eq_false_or_eq_true (toInd plaqZ (((0 : ℤ), (T : ℤ), (0 : ℤ)), (2 : Fin 3)) l) with h2 | h2 <;>
      simp [h1, h2]

theorem bdL_surf (R T : ℕ) : bdL (toInd plaqZ) (surf R T) = rect R T := by
  induction R with
  | zero => rw [surf_zero_left, bdL_empty_plaq, rect_zero_left]
  | succ R ih =>
    rw [surf_succ, bdL_union _ _ _ (surf_disjoint_column R T), ih]
    funext l
    rw [rect_add R 1 T l]
    congr 1
    rw [← shiftL_shiftL_neg ((R : ℤ), 0, 0) l, bdL_shift, shiftL_neg_shiftL, bdL_surf_one]

/-- THE RECTANGLE'S EXPECTATION IS POSITIVE: the minimal surface is a surface bounded by it -/
theorem Winf_rect_pos (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (R T : ℕ) :
    0 < Winf plaqZ (fun _ => y) (rect R T) := by
  classical
  obtain ⟨n, hn⟩ := cube_exhausts (surf R T)
  refine lt_of_lt_of_le ?_ (WcL_le_Winf plaqZ (fun _ => y) (fun _ => le_of_lt hy0) (fun _ => hy1) (cube n) _)
  unfold WcL
  apply div_pos
  · have hterm : ∀ t ∈ (cube n).powerset,
        0 ≤ (if bdL (toInd plaqZ) t = rect R T then ∏ _p ∈ t, y else 0) := by
      intro t _
      split_ifs
      · exact Finset.prod_nonneg (fun _ _ => le_of_lt hy0)
      · exact le_rfl
    have hmem : surf R T ∈ (cube n).powerset := Finset.mem_powerset.mpr hn
    have h1 := Finset.single_le_sum hterm hmem
    rw [if_pos (bdL_surf R T)] at h1
    exact lt_of_lt_of_le (Finset.prod_pos (fun _ _ => hy0)) h1
  · have hterm : ∀ t ∈ (cube n).powerset,
        0 ≤ (if bdL (toInd plaqZ) t = (fun _ => false) then ∏ _p ∈ t, y else 0) := by
      intro t _
      split_ifs
      · exact Finset.prod_nonneg (fun _ _ => le_of_lt hy0)
      · exact le_rfl
    have hmem : (∅ : Finset Plaq) ∈ (cube n).powerset := Finset.empty_mem_powerset _
    have h1 := Finset.single_le_sum hterm hmem
    rw [if_pos bdL_empty_plaq, Finset.prod_empty] at h1
    exact lt_of_lt_of_le one_pos h1

theorem Winf_le_one (plaqF : Plaq → Finset Link) (y : ℝ) (hy0 : 0 ≤ y) (hy1 : y ≤ 1) (A : Link → Bool) :
    Winf plaqF (fun _ => y) A ≤ 1 :=
  ciSup_le (fun Λ => WcL_le_one plaqF (fun _ => y) (fun _ => hy0) (fun _ => hy1) Λ A)

/-- the rectangle of width R₁ + R₂ as the xor of two rectangles, as functions -/
theorem rect_add_fun (R₁ R₂ T : ℕ) :
    rect (R₁ + R₂) T = fun l => xor (rect R₁ T l) (rect R₂ T (shiftL (-((R₁ : ℤ), (0 : ℤ), (0 : ℤ))) l)) := by
  funext l; exact rect_add R₁ R₂ T l

/-- SUBADDITIVITY OF THE WILSON LOOP'S LOGARITHM IN THE WIDTH: W_∞(R₁ + R₂) ≥ W_∞(R₁) W_∞(R₂) -/
theorem Winf_rect_mul_le (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (T R₁ R₂ : ℕ) :
    Winf plaqZ (fun _ => y) (rect R₁ T) * Winf plaqZ (fun _ => y) (rect R₂ T)
      ≤ Winf plaqZ (fun _ => y) (rect (R₁ + R₂) T) := by
  set N := R₁ + R₂ + T with hN
  have hmono : Monotone (fun n => cube (n + N)) := fun m n h => cube_mono (by omega)
  have hex : ∀ S : Finset Plaq, ∃ n, S ⊆ cube (n + N) := by
    intro S
    obtain ⟨n, hn⟩ := cube_exhausts S
    exact ⟨n, le_trans hn (cube_mono (by omega))⟩
  have hA : ∀ l, rect R₁ T l = true → l ∈ linksOf plaqZ (cube (0 + N)) :=
    rect_subset_links R₁ T (0 + N) (by omega) (by omega)
  have hB : ∀ l, rect R₂ T (shiftL (-((R₁ : ℤ), (0 : ℤ), (0 : ℤ))) l) = true →
      l ∈ linksOf plaqZ (cube (0 + N)) :=
    rect_shift_subset_links R₁ R₂ T (0 + N) (by omega) (by omega)
  have h := Winf_mul_le plaqZ (fun _ => y) (fun _ => le_of_lt hy0) (fun _ => hy1) (fun n => cube (n + N))
    hmono hex (rect R₁ T) (fun l => rect R₂ T (shiftL (-((R₁ : ℤ), (0 : ℤ), (0 : ℤ))) l)) hA hB
  rw [Winf_shift] at h
  beta_reduce at h
  rw [← rect_add_fun] at h
  exact h

/-- THE STRING TENSION EXISTS: for every height T, −log W_∞(R × T)/R converges as R → ∞, to a nonnegative limit -/
theorem string_tension_exists (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (T : ℕ) :
    ∃ σ : ℝ, 0 ≤ σ ∧
      Tendsto (fun R : ℕ => -Real.log (Winf plaqZ (fun _ => y) (rect R T)) / R) atTop (𝓝 σ) := by
  set u : ℕ → ℝ := fun R => -Real.log (Winf plaqZ (fun _ => y) (rect R T)) with hu
  have hpos : ∀ R, 0 < Winf plaqZ (fun _ => y) (rect R T) := fun R => Winf_rect_pos y hy0 hy1 R T
  have hle1 : ∀ R, Winf plaqZ (fun _ => y) (rect R T) ≤ 1 :=
    fun R => Winf_le_one plaqZ y (le_of_lt hy0) hy1 _
  have hsub : Subadditive u := by
    show ∀ m n, u (m + n) ≤ u m + u n
    intro m n
    simp only [hu]
    have := Winf_rect_mul_le y hy0 hy1 T m n
    have hlog := Real.log_le_log (mul_pos (hpos m) (hpos n)) this
    rw [Real.log_mul (ne_of_gt (hpos m)) (ne_of_gt (hpos n))] at hlog
    linarith
  have hnn : ∀ R, 0 ≤ u R := by
    intro R
    simp only [hu]
    have := Real.log_nonpos (le_of_lt (hpos R)) (hle1 R)
    linarith
  have hbdd : BddBelow (Set.range fun n => u n / n) := by
    refine ⟨0, ?_⟩
    rintro _ ⟨n, rfl⟩
    exact div_nonneg (hnn n) (Nat.cast_nonneg n)
  refine ⟨hsub.lim, ?_, hsub.tendsto_lim hbdd⟩
  exact ge_of_tendsto' (hsub.tendsto_lim hbdd) (fun n => div_nonneg (hnn n) (Nat.cast_nonneg n))

end Aperanton
