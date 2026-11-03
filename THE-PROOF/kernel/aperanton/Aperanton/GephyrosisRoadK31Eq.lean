import Aperanton.GephyrosisRoadK31Tb0
import Aperanton.GephyrosisRoadK31Tb1
import Aperanton.GephyrosisRoadK31Tb2
import Aperanton.GephyrosisRoadK31Tb3
import Aperanton.GephyrosisRoadK31Tb4
import Aperanton.GephyrosisRoadK31Tb5

namespace Gephyrosis

theorem R31lit_tb_agree : ∀ k < 52, (road3Dsym 1).tb.getD k [] = R31lit.tb.getD k [] := by
  intro k hk
  interval_cases k
  exacts [tb31_eq_0, tb31_eq_1, tb31_eq_2, tb31_eq_3, tb31_eq_4, tb31_eq_5, tb31_eq_6, tb31_eq_7, tb31_eq_8, tb31_eq_9, tb31_eq_10, tb31_eq_11, tb31_eq_12, tb31_eq_13, tb31_eq_14, tb31_eq_15, tb31_eq_16, tb31_eq_17, tb31_eq_18, tb31_eq_19, tb31_eq_20, tb31_eq_21, tb31_eq_22, tb31_eq_23, tb31_eq_24, tb31_eq_25, tb31_eq_26, tb31_eq_27, tb31_eq_28, tb31_eq_29, tb31_eq_30, tb31_eq_31, tb31_eq_32, tb31_eq_33, tb31_eq_34, tb31_eq_35, tb31_eq_36, tb31_eq_37, tb31_eq_38, tb31_eq_39, tb31_eq_40, tb31_eq_41, tb31_eq_42, tb31_eq_43, tb31_eq_44, tb31_eq_45, tb31_eq_46, tb31_eq_47, tb31_eq_48, tb31_eq_49, tb31_eq_50, tb31_eq_51]

theorem R31lit_agree : RoadAgree (road3Dsym 1) R31lit := by
  refine ⟨by rw [R31lit_src_n, R31lit_n], ?_, ?_, ?_⟩
  · intro k hk
    rw [R31lit_src_n] at hk
    have := R31lit_kappa_agree
    rw [List.all_eq_true] at this
    exact of_decide_eq_true (this k (List.mem_range.2 hk))
  · intro k hk
    rw [R31lit_src_n] at hk
    have := R31lit_dee_agree
    rw [List.all_eq_true] at this
    exact of_decide_eq_true (this k (List.mem_range.2 hk))
  · intro k hk
    rw [R31lit_src_n] at hk
    exact R31lit_tb_agree k hk

end Gephyrosis

namespace Gephyrosis

/-- the exact orbit of the literal 3D road IS the exact orbit of `R31s = road3Dsym 1` -/
theorem ratOrbit_K31lit (c0 : List ℤ) (s : ℕ) : ratOrbit R31lit c0 s = ratOrbit R31s c0 s :=
  (ratOrbit_congr (road3Dsym 1) R31lit R31lit_agree c0 s).symm

theorem autoOrbit_K31lit {p : ℕ} [Fact p.Prime] (c0 : List ℤ) (s : ℕ) :
    autoOrbit R31lit p c0 s = autoOrbit R31s p c0 s :=
  (autoOrbit_congr (road3Dsym 1) R31lit R31lit_agree c0 s).symm

theorem topOf_K31lit (c0 : List ℤ) (s : ℕ) : topOf R31lit 3 c0 s = topOf R31s 3 c0 s := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  unfold topOf
  rw [autoOrbit_K31lit]

end Gephyrosis
