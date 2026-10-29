/-
  APERANTON -- THE BOUNDLESS, stage A5 (fourth landing): THE STRONG-COUPLING FLOOR AND THE STRING TENSION'S BOUND.

  With the couplings cut to the minimal surface alone, the only surface bounded by the rectangle is the minimal
  surface and the only closed surface is empty (a nonempty set of plaquettes of a planar rectangle has a boundary:
  its lowest plaquette's bottom link is covered once), so the box expectation is exactly y^{RT}.  Monotonicity in
  the couplings lifts the floor to every box and to infinite volume: W_∞(R × T) ≥ y^{RT}, hence the string tension
  of Rectangle.lean is finite and bounded by the strong-coupling value, σ(T) ≤ T log(1/y).  No sorry, no axiom.
-/
import Mathlib
import Aperanton.Rectangle

open Finset Filter Topology

set_option maxHeartbeats 800000

namespace Aperanton

variable {E : Type*} {P : Type*} [DecidableEq E] [DecidableEq P]

/-- the boundary of a symmetric difference is the xor of the boundaries -/
theorem bdL_symmDiff (plaq : P → E → Bool) (s t : Finset P) :
    bdL plaq (symmDiff s t) = fun e => xor (bdL plaq s e) (bdL plaq t e) := by
  have hs : s = (s \ t) ∪ (s ∩ t) := (Finset.sdiff_union_inter s t).symm
  have ht : t = (t \ s) ∪ (s ∩ t) := by rw [Finset.inter_comm]; exact (Finset.sdiff_union_inter t s).symm
  have hsd : symmDiff s t = (s \ t) ∪ (t \ s) := Finset.symmDiff_def s t
  have d1 : Disjoint (s \ t) (s ∩ t) := Finset.disjoint_sdiff_inter s t
  have d2 : Disjoint (t \ s) (s ∩ t) := by rw [Finset.inter_comm]; exact Finset.disjoint_sdiff_inter t s
  have d3 : Disjoint (s \ t) (t \ s) := by
    rw [Finset.disjoint_left]
    intro p hp hp'
    rw [Finset.mem_sdiff] at hp hp'
    exact hp'.2 hp.1
  have e1 : bdL plaq s = fun e => xor (bdL plaq (s \ t) e) (bdL plaq (s ∩ t) e) := by
    conv_lhs => rw [hs]
    exact bdL_union plaq _ _ d1
  have e2 : bdL plaq t = fun e => xor (bdL plaq (t \ s) e) (bdL plaq (s ∩ t) e) := by
    conv_lhs => rw [ht]
    exact bdL_union plaq _ _ d2
  rw [hsd, bdL_union plaq _ _ d3, e1, e2]
  funext e
  rcases Bool.eq_false_or_eq_true (bdL plaq (s \ t) e) with g1 | g1 <;>
    rcases Bool.eq_false_or_eq_true (bdL plaq (t \ s) e) with g2 | g2 <;>
    rcases Bool.eq_false_or_eq_true (bdL plaq (s ∩ t) e) with g3 | g3 <;> simp [g1, g2, g3]

/-- the couplings monotonicity, read on the box expectation -/
theorem WcL_mono_coupling (plaqF : P → Finset E) (y y' : P → ℝ) (hy0 : ∀ p, 0 ≤ y p) (hyy : ∀ p, y p ≤ y' p)
    (hy1 : ∀ p, y' p ≤ 1) (Λ : Finset P) (A : E → Bool) (hA : ∀ e, A e = true → e ∈ linksOf plaqF Λ) :
    WcL (toInd plaqF) y Λ A ≤ WcL (toInd plaqF) y' Λ A := by
  rw [WcL_eq_expect plaqF y Λ A hA, WcL_eq_expect plaqF y' Λ A hA]
  exact expect_mono (fun (p : ↥Λ) (e : ↥(linksOf plaqF Λ)) => toInd plaqF p.1 e.1) (fun (p : ↥Λ) => y p.1)
    (fun (p : ↥Λ) => y' p.1) (fun (p : ↥Λ) => hy0 p.1) (fun (p : ↥Λ) => hyy p.1) (fun (p : ↥Λ) => hy1 p.1)
    (fun e => A e.1)

/-- which plaquettes of the plane contain the bottom link of the plaquette at (a, b): that plaquette and the one
below it -/
theorem bottom_link_mem_plaqZ (a b x y : ℤ) :
    (((a, b, (0 : ℤ)), (0 : Fin 3)) ∈ plaqZ (((x, y, (0 : ℤ)), (2 : Fin 3)))) ↔ (x = a ∧ y = b) ∨ (x = a ∧ y + 1 = b) := by
  simp only [plaqZ, plane, unit, Finset.mem_insert, Finset.mem_singleton, Prod.mk.injEq, Prod.mk_add_mk]
  simp
  omega

/-- A NONEMPTY SET OF PLAQUETTES OF THE PLANAR RECTANGLE HAS A BOUNDARY: its lowest plaquette's bottom link is
covered exactly once -/
theorem bdL_ne_of_nonempty (R T : ℕ) (t : Finset Plaq) (ht : t ⊆ surf R T) (hne : t.Nonempty) :
    bdL (toInd plaqZ) t ≠ fun _ => false := by
  obtain ⟨p₀, hp₀, hmin⟩ := Finset.exists_min_image t (fun p => p.1.2.1) hne
  obtain ⟨⟨a, b, c⟩, d⟩ := p₀
  have hp₀s := ht hp₀
  rw [mem_surf] at hp₀s
  obtain ⟨hd, hc, -, -, -, -⟩ := hp₀s
  simp only at hd hc
  subst hd hc
  intro hcontra
  have := congrFun hcontra ((a, b, (0 : ℤ)), (0 : Fin 3))
  simp only [bdL] at this
  -- the filter is exactly {((a, b, 0), 2)}
  have hfilt : t.filter (fun p => toInd plaqZ p ((a, b, (0 : ℤ)), (0 : Fin 3)) = true) = {((a, b, (0 : ℤ)), (2 : Fin 3))} := by
    ext ⟨⟨x, y, z⟩, k⟩
    rw [Finset.mem_filter, Finset.mem_singleton]
    constructor
    · rintro ⟨hq, hqe⟩
      have hqs := ht hq
      rw [mem_surf] at hqs
      obtain ⟨hk, hz, -, -, -, -⟩ := hqs
      simp only at hk hz
      subst hk hz
      simp only [toInd, decide_eq_true_eq] at hqe
      rw [bottom_link_mem_plaqZ] at hqe
      have hm := hmin _ hq
      simp only at hm
      rcases hqe with ⟨rfl, rfl⟩ | ⟨rfl, hy⟩
      · rfl
      · omega
    · rintro ⟨⟩
      refine ⟨hp₀, ?_⟩
      simp only [toInd, decide_eq_true_eq]
      rw [bottom_link_mem_plaqZ]
      left; exact ⟨rfl, rfl⟩
  rw [hfilt, Finset.card_singleton] at this
  simp at this

/-- INSIDE THE MINIMAL SURFACE THE ONLY CLOSED SURFACE IS EMPTY -/
theorem closed_subsurface_empty (R T : ℕ) (t : Finset Plaq) (ht : t ⊆ surf R T)
    (hb : bdL (toInd plaqZ) t = fun _ => false) : t = ∅ := by
  by_contra h
  exact bdL_ne_of_nonempty R T t ht (Finset.nonempty_iff_ne_empty.mpr h) hb

/-- INSIDE THE MINIMAL SURFACE THE ONLY SURFACE BOUNDED BY THE RECTANGLE IS THE MINIMAL SURFACE -/
theorem surface_unique (R T : ℕ) (t : Finset Plaq) (ht : t ⊆ surf R T) (hb : bdL (toInd plaqZ) t = rect R T) :
    t = surf R T := by
  have hsd : bdL (toInd plaqZ) (symmDiff t (surf R T)) = fun _ => false := by
    rw [bdL_symmDiff, hb, bdL_surf]
    funext e
    cases rect R T e <;> rfl
  have h0 := closed_subsurface_empty R T _ (by
    intro p hp
    rw [Finset.mem_symmDiff] at hp
    rcases hp with ⟨h1, -⟩ | ⟨h1, -⟩
    · exact ht h1
    · exact h1) hsd
  rw [Finset.symmDiff_eq_empty] at h0
  exact h0

/-- THE FLOOR ON THE MINIMAL SURFACE: with couplings y on the surface alone the rectangle's expectation is y^{RT} -/
theorem WcL_surf_eq (y : ℝ) (R T : ℕ) :
    WcL (toInd plaqZ) (fun _ => y) (surf R T) (rect R T) = y ^ (surf R T).card := by
  classical
  unfold WcL
  have hnum : (∑ t ∈ (surf R T).powerset, if bdL (toInd plaqZ) t = rect R T then ∏ _p ∈ t, y else 0)
      = y ^ (surf R T).card := by
    rw [Finset.sum_eq_single (surf R T)]
    · rw [if_pos (bdL_surf R T), Finset.prod_const]
    · intro t ht hne
      rw [if_neg]
      intro hb
      exact hne (surface_unique R T t (Finset.mem_powerset.mp ht) hb)
    · intro h; exact absurd (Finset.mem_powerset.mpr (le_refl _)) h
  have hden : (∑ t ∈ (surf R T).powerset, if bdL (toInd plaqZ) t = (fun _ => false) then ∏ _p ∈ t, y else 0)
      = 1 := by
    rw [Finset.sum_eq_single (∅ : Finset Plaq)]
    · rw [if_pos bdL_empty_plaq, Finset.prod_empty]
    · intro t ht hne
      rw [if_neg]
      intro hb
      exact hne (closed_subsurface_empty R T t (Finset.mem_powerset.mp ht) hb)
    · intro h; exact absurd (Finset.empty_mem_powerset _) h
  rw [hnum, hden, div_one]

theorem card_surf (R T : ℕ) : (surf R T).card = R * T := by
  unfold surf
  rw [Finset.card_image_of_injective]
  · simp [Finset.card_product]
  · intro ab ab' h
    simp only [Prod.mk.injEq, Nat.cast_inj] at h
    exact Prod.ext h.1.1 h.1.2.1

/-- THE STRONG-COUPLING FLOOR IN INFINITE VOLUME: W_∞(R × T) ≥ y^{RT} -/
theorem Winf_rect_ge (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (R T : ℕ) :
    y ^ (R * T) ≤ Winf plaqZ (fun _ => y) (rect R T) := by
  obtain ⟨n₀, hn₀⟩ := cube_exhausts (surf R T)
  -- a cube large enough for the surface and for the loop's two side lengths
  have hn : surf R T ⊆ cube (n₀ + R + T) := le_trans hn₀ (cube_mono (by omega))
  have hA : ∀ l, rect R T l = true → l ∈ linksOf plaqZ (cube (n₀ + R + T)) :=
    rect_subset_links R T (n₀ + R + T) (by omega) (by omega)
  calc y ^ (R * T) = y ^ (surf R T).card := by rw [card_surf]
    _ = WcL (toInd plaqZ) (fun _ => y) (surf R T) (rect R T) := (WcL_surf_eq y R T).symm
    _ = WcL (toInd plaqZ) (cut (fun _ => y) (surf R T)) (surf R T) (rect R T) := (WcL_cut _ _ _ _).symm
    _ = WcL (toInd plaqZ) (cut (fun _ => y) (surf R T)) (cube (n₀ + R + T)) (rect R T) :=
        (WcL_restrict _ _ hn (cut_zero_outside _ _) _).symm
    _ ≤ WcL (toInd plaqZ) (fun _ => y) (cube (n₀ + R + T)) (rect R T) :=
        WcL_mono_coupling plaqZ _ _ (cut_nonneg _ (fun _ => le_of_lt hy0) _) (cut_le _ (fun _ => le_of_lt hy0) _)
          (fun _ => hy1) (cube (n₀ + R + T)) (rect R T) hA
    _ ≤ Winf plaqZ (fun _ => y) (rect R T) :=
        WcL_le_Winf plaqZ (fun _ => y) (fun _ => le_of_lt hy0) (fun _ => hy1) (cube (n₀ + R + T)) _

/-- THE STRING TENSION IS BOUNDED BY THE STRONG-COUPLING VALUE: σ(T) ≤ T log(1/y) -/
theorem string_tension_le (y : ℝ) (hy0 : 0 < y) (hy1 : y ≤ 1) (T : ℕ) (σ : ℝ)
    (hσ : Tendsto (fun R : ℕ => -Real.log (Winf plaqZ (fun _ => y) (rect R T)) / R) atTop (𝓝 σ)) :
    σ ≤ (T : ℝ) * Real.log (1 / y) := by
  refine le_of_tendsto' hσ (fun R => ?_)
  rcases Nat.eq_zero_or_pos R with hR | hR
  · subst hR
    simp only [Nat.cast_zero, div_zero]
    exact mul_nonneg (Nat.cast_nonneg T) (Real.log_nonneg (by rw [one_div]; exact one_le_inv_iff₀.mpr ⟨hy0, hy1⟩))
  · have hpos := Winf_rect_pos y hy0 hy1 R T
    have hfloor := Winf_rect_ge y hy0 hy1 R T
    have hlog : Real.log (y ^ (R * T)) ≤ Real.log (Winf plaqZ (fun _ => y) (rect R T)) :=
      Real.log_le_log (pow_pos hy0 _) hfloor
    rw [Real.log_pow] at hlog
    rw [div_le_iff₀ (Nat.cast_pos.mpr hR)]
    have : Real.log (1 / y) = -Real.log y := by rw [one_div, Real.log_inv]
    rw [this]
    push_cast at hlog ⊢
    nlinarith [hlog]

end Aperanton
