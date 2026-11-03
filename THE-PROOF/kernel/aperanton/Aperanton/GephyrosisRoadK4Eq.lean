import Aperanton.GephyrosisRoadK4Tb0
import Aperanton.GephyrosisRoadK4Tb1
import Aperanton.GephyrosisRoadK4Tb2
import Aperanton.GephyrosisRoadK4Tb3
import Aperanton.GephyrosisRoadK4Tb4
import Aperanton.GephyrosisRoadK4Tb5
import Aperanton.GephyrosisRoadK4Tb6
import Aperanton.GephyrosisRoadK4Tb7

namespace Gephyrosis

theorem R24lit_tb_agree : ∀ k < 80, (road2Dsym 4).tb.getD k [] = R24lit.tb.getD k [] := by
  intro k hk
  interval_cases k
  exacts [tb24_eq_0, tb24_eq_1, tb24_eq_2, tb24_eq_3, tb24_eq_4, tb24_eq_5, tb24_eq_6, tb24_eq_7, tb24_eq_8, tb24_eq_9, tb24_eq_10, tb24_eq_11, tb24_eq_12, tb24_eq_13, tb24_eq_14, tb24_eq_15, tb24_eq_16, tb24_eq_17, tb24_eq_18, tb24_eq_19, tb24_eq_20, tb24_eq_21, tb24_eq_22, tb24_eq_23, tb24_eq_24, tb24_eq_25, tb24_eq_26, tb24_eq_27, tb24_eq_28, tb24_eq_29, tb24_eq_30, tb24_eq_31, tb24_eq_32, tb24_eq_33, tb24_eq_34, tb24_eq_35, tb24_eq_36, tb24_eq_37, tb24_eq_38, tb24_eq_39, tb24_eq_40, tb24_eq_41, tb24_eq_42, tb24_eq_43, tb24_eq_44, tb24_eq_45, tb24_eq_46, tb24_eq_47, tb24_eq_48, tb24_eq_49, tb24_eq_50, tb24_eq_51, tb24_eq_52, tb24_eq_53, tb24_eq_54, tb24_eq_55, tb24_eq_56, tb24_eq_57, tb24_eq_58, tb24_eq_59, tb24_eq_60, tb24_eq_61, tb24_eq_62, tb24_eq_63, tb24_eq_64, tb24_eq_65, tb24_eq_66, tb24_eq_67, tb24_eq_68, tb24_eq_69, tb24_eq_70, tb24_eq_71, tb24_eq_72, tb24_eq_73, tb24_eq_74, tb24_eq_75, tb24_eq_76, tb24_eq_77, tb24_eq_78, tb24_eq_79]

theorem R24lit_agree : RoadAgree (road2Dsym 4) R24lit := by
  refine ⟨by rw [R24lit_src_n, R24lit_n], ?_, ?_, ?_⟩
  · intro k hk
    rw [R24lit_src_n] at hk
    have := R24lit_kappa_agree
    rw [List.all_eq_true] at this
    exact of_decide_eq_true (this k (List.mem_range.2 hk))
  · intro k hk
    rw [R24lit_src_n] at hk
    have := R24lit_dee_agree
    rw [List.all_eq_true] at this
    exact of_decide_eq_true (this k (List.mem_range.2 hk))
  · intro k hk
    rw [R24lit_src_n] at hk
    exact R24lit_tb_agree k hk

end Gephyrosis

namespace Gephyrosis

/-- the exact orbit of the literal road IS the exact orbit of the box `K = 4` -/
theorem ratOrbit_K4lit (c0 : List ℤ) (s : ℕ) : ratOrbit R24lit c0 s = ratOrbit (road2D 4) c0 s := by
  rw [← ratOrbit_congr (road2Dsym 4) R24lit R24lit_agree, ratOrbit_sym2]

theorem autoOrbit_K4lit {p : ℕ} [Fact p.Prime] (c0 : List ℤ) (s : ℕ) :
    autoOrbit R24lit p c0 s = autoOrbit (road2Dsym 4) p c0 s :=
  (autoOrbit_congr (road2Dsym 4) R24lit R24lit_agree c0 s).symm

end Gephyrosis
