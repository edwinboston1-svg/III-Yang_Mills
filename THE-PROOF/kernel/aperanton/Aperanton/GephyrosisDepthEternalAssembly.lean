import Aperanton.GephyrosisDepthEternalChunk0
import Aperanton.GephyrosisDepthEternalChunk1
import Aperanton.GephyrosisDepthEternalChunk2
import Aperanton.GephyrosisDepthEternalChunk3
import Aperanton.GephyrosisDepthEternalChunk4
import Aperanton.GephyrosisDepthEternalChunk5
import Aperanton.GephyrosisDepthEternalChunk6
import Aperanton.GephyrosisDepthEternalChunk7
import Aperanton.GephyrosisDepthEternalChunk8
import Aperanton.GephyrosisDepthEternalChunk9

/-! # ΓΕΦΥΡΩΣΙΣ — THE FIRST ETERNAL LAW AT AN ODD PRIME FOR THE DEFAULT SEED, assembled from its chunks

In the 2D box `K = 4` at the prime 5 the default seed 5 attains the depth-two bound `2^s` at every step: its
normalised automaton state closes at step 10 with period 40 (the profile shifted by `2^50 − 2^10`, the residues
returning unscaled). The 80-coordinate walk runs on the literal road `R24lit` in ten chunks of five steps, one
kernel process each, and `ratOrbit_K4lit` carries the law to the exact orbit of `road2D 4`. -/

namespace Gephyrosis

theorem GephyrosisDepthEternal_reach5 : autoFrom R24lit 5 initK4 5 = stK4_5 := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  exact (chunk_read R24lit _ _ 0 5 chkGephyrosisDepthEternal GephyrosisDepthEternal_chunk0).2

theorem GephyrosisDepthEternal_reach10 : autoFrom R24lit 5 initK4 10 = stK4_10 := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  rw [show (10 : ℕ) = 5 + 5 from rfl, autoFrom_add, GephyrosisDepthEternal_reach5]
  exact (chunk_read R24lit _ _ 5 5 chkGephyrosisDepthEternal GephyrosisDepthEternal_chunk1).2

theorem GephyrosisDepthEternal_reach15 : autoFrom R24lit 5 initK4 15 = stK4_15 := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  rw [show (15 : ℕ) = 10 + 5 from rfl, autoFrom_add, GephyrosisDepthEternal_reach10]
  exact (chunk_read R24lit _ _ 10 5 chkGephyrosisDepthEternal GephyrosisDepthEternal_chunk2).2

theorem GephyrosisDepthEternal_reach20 : autoFrom R24lit 5 initK4 20 = stK4_20 := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  rw [show (20 : ℕ) = 15 + 5 from rfl, autoFrom_add, GephyrosisDepthEternal_reach15]
  exact (chunk_read R24lit _ _ 15 5 chkGephyrosisDepthEternal GephyrosisDepthEternal_chunk3).2

theorem GephyrosisDepthEternal_reach25 : autoFrom R24lit 5 initK4 25 = stK4_25 := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  rw [show (25 : ℕ) = 20 + 5 from rfl, autoFrom_add, GephyrosisDepthEternal_reach20]
  exact (chunk_read R24lit _ _ 20 5 chkGephyrosisDepthEternal GephyrosisDepthEternal_chunk4).2

theorem GephyrosisDepthEternal_reach30 : autoFrom R24lit 5 initK4 30 = stK4_30 := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  rw [show (30 : ℕ) = 25 + 5 from rfl, autoFrom_add, GephyrosisDepthEternal_reach25]
  exact (chunk_read R24lit _ _ 25 5 chkGephyrosisDepthEternal GephyrosisDepthEternal_chunk5).2

theorem GephyrosisDepthEternal_reach35 : autoFrom R24lit 5 initK4 35 = stK4_35 := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  rw [show (35 : ℕ) = 30 + 5 from rfl, autoFrom_add, GephyrosisDepthEternal_reach30]
  exact (chunk_read R24lit _ _ 30 5 chkGephyrosisDepthEternal GephyrosisDepthEternal_chunk6).2

theorem GephyrosisDepthEternal_reach40 : autoFrom R24lit 5 initK4 40 = stK4_40 := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  rw [show (40 : ℕ) = 35 + 5 from rfl, autoFrom_add, GephyrosisDepthEternal_reach35]
  exact (chunk_read R24lit _ _ 35 5 chkGephyrosisDepthEternal GephyrosisDepthEternal_chunk7).2

theorem GephyrosisDepthEternal_reach45 : autoFrom R24lit 5 initK4 45 = stK4_45 := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  rw [show (45 : ℕ) = 40 + 5 from rfl, autoFrom_add, GephyrosisDepthEternal_reach40]
  exact (chunk_read R24lit _ _ 40 5 chkGephyrosisDepthEternal GephyrosisDepthEternal_chunk8).2

theorem GephyrosisDepthEternal_reach50 : autoFrom R24lit 5 initK4 50 = stK4_50 := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  rw [show (50 : ℕ) = 45 + 5 from rfl, autoFrom_add, GephyrosisDepthEternal_reach45]
  exact (chunk_read R24lit _ _ 45 5 chkGephyrosisDepthEternal GephyrosisDepthEternal_chunk9).2

theorem GephyrosisDepthEternal_seg (s0 N : ℕ) (stq stN : List ℤ × List ℕ) (hreach : autoFrom R24lit 5 initK4 s0 = stq)
    (hc : chunkCert R24lit 5 stq stN s0 N chkGephyrosisDepthEternal = true) :
    ∀ i ≤ N, chkGephyrosisDepthEternal (s0 + i) (autoFrom R24lit 5 initK4 (s0 + i)) = true := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  intro i hi
  rw [autoFrom_add, hreach]
  exact (chunk_read R24lit _ _ s0 N chkGephyrosisDepthEternal hc).1 i hi

theorem GephyrosisDepthEternal_all (s : ℕ) (hs : s ≤ 50) : chkGephyrosisDepthEternal s (autoOrbit R24lit 5 seed5_K4 s) = true := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  rw [autoOrbit_eq_from]
  show chkGephyrosisDepthEternal s (autoFrom R24lit 5 initK4 s) = true
  by_cases h0 : s ≤ 5
  · simpa using GephyrosisDepthEternal_seg 0 5 initK4 stK4_5 rfl GephyrosisDepthEternal_chunk0 s h0
  by_cases h1 : s ≤ 10
  · have := GephyrosisDepthEternal_seg 5 5 _ _ GephyrosisDepthEternal_reach5 GephyrosisDepthEternal_chunk1 (s - 5) (by omega)
    rwa [show 5 + (s - 5) = s by omega] at this
  by_cases h2 : s ≤ 15
  · have := GephyrosisDepthEternal_seg 10 5 _ _ GephyrosisDepthEternal_reach10 GephyrosisDepthEternal_chunk2 (s - 10) (by omega)
    rwa [show 10 + (s - 10) = s by omega] at this
  by_cases h3 : s ≤ 20
  · have := GephyrosisDepthEternal_seg 15 5 _ _ GephyrosisDepthEternal_reach15 GephyrosisDepthEternal_chunk3 (s - 15) (by omega)
    rwa [show 15 + (s - 15) = s by omega] at this
  by_cases h4 : s ≤ 25
  · have := GephyrosisDepthEternal_seg 20 5 _ _ GephyrosisDepthEternal_reach20 GephyrosisDepthEternal_chunk4 (s - 20) (by omega)
    rwa [show 20 + (s - 20) = s by omega] at this
  by_cases h5 : s ≤ 30
  · have := GephyrosisDepthEternal_seg 25 5 _ _ GephyrosisDepthEternal_reach25 GephyrosisDepthEternal_chunk5 (s - 25) (by omega)
    rwa [show 25 + (s - 25) = s by omega] at this
  by_cases h6 : s ≤ 35
  · have := GephyrosisDepthEternal_seg 30 5 _ _ GephyrosisDepthEternal_reach30 GephyrosisDepthEternal_chunk6 (s - 30) (by omega)
    rwa [show 30 + (s - 30) = s by omega] at this
  by_cases h7 : s ≤ 40
  · have := GephyrosisDepthEternal_seg 35 5 _ _ GephyrosisDepthEternal_reach35 GephyrosisDepthEternal_chunk7 (s - 35) (by omega)
    rwa [show 35 + (s - 35) = s by omega] at this
  by_cases h8 : s ≤ 45
  · have := GephyrosisDepthEternal_seg 40 5 _ _ GephyrosisDepthEternal_reach40 GephyrosisDepthEternal_chunk8 (s - 40) (by omega)
    rwa [show 40 + (s - 40) = s by omega] at this
  · have := GephyrosisDepthEternal_seg 45 5 _ _ GephyrosisDepthEternal_reach45 GephyrosisDepthEternal_chunk9 (s - 45) (by omega)
    rwa [show 45 + (s - 45) = s by omega] at this

theorem GephyrosisDepthEternal_close : stK4_50 = (stK4_10.1.map (· + 1125899906841600), scaleR 5 1 stK4_10.2) := by
  decide +kernel

theorem GephyrosisDepthEternal_live (hwf : wfCheck R24lit = true) : ∀ s, 1 ≤ s → TopLive R24lit 5 seed5_K4 s := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  have hclose : autoOrbit R24lit 5 seed5_K4 (10 + 40)
      = ((autoOrbit R24lit 5 seed5_K4 10).1.map (· + 1125899906841600), scaleR 5 1 (autoOrbit R24lit 5 seed5_K4 10).2) := by
    rw [autoOrbit_eq_from, autoOrbit_eq_from]
    show autoFrom R24lit 5 initK4 50 = ((autoFrom R24lit 5 initK4 10).1.map (· + 1125899906841600), scaleR 5 1 (autoFrom R24lit 5 initK4 10).2)
    rw [GephyrosisDepthEternal_reach50, GephyrosisDepthEternal_reach10]
    exact GephyrosisDepthEternal_close
  have hNA : ∀ i < 40, NonAttain R24lit 5 (autoOrbit R24lit 5 seed5_K4 (10 + i)).1 := by
    intro i hi
    have := GephyrosisDepthEternal_all (10 + i) (by omega)
    unfold chkGephyrosisDepthEternal at this
    simp only [Bool.and_eq_true, Bool.or_eq_true, decide_eq_true_eq] at this
    rcases this.2 with h | h
    · omega
    · exact nonAttain_of_check _ _ _ h
  have hinit : ∀ s, 1 ≤ s → s ≤ 10 + 40 → TopLive R24lit 5 seed5_K4 s := by
    intro s h1 h2
    have := GephyrosisDepthEternal_all s (by omega)
    unfold chkGephyrosisDepthEternal at this
    simp only [Bool.and_eq_true, Bool.or_eq_true, decide_eq_true_eq] at this
    rcases this.1 with h | h
    · omega
    · exact topLive_of_check _ _ _ h
  exact class_eternal_pieces R24lit seed5_K4 10 40 (by norm_num) 1125899906841600 (by norm_num) 1
    (by norm_num) (by rw [R24lit_n]; norm_num) (wellformed_of_check _ hwf) hclose hNA hinit

/-- **THE FIRST ETERNAL LAW AT AN ODD PRIME FOR THE DEFAULT SEED.** The orbit of seed 5 in the 2D
box `K = 4` carries EXACTLY `5^{2^s}` in its denominators at every step `s ≥ 1`. -/
theorem seed5_K4_eternal_law (s : ℕ) (hs : 1 ≤ s) :
    (∀ k < 80, (ratOrbit (road2D 4) (seedData 5 80) s).getD k 0 ≠ 0 →
        -padicValRat 5 ((ratOrbit (road2D 4) (seedData 5 80) s).getD k 0) ≤ 2 ^ s) ∧
    (∃ k < 80, (ratOrbit (road2D 4) (seedData 5 80) s).getD k 0 ≠ 0 ∧
        -padicValRat 5 ((ratOrbit (road2D 4) (seedData 5 80) s).getD k 0) = 2 ^ s) := by
  have : Fact (Nat.Prime 5) := ⟨by norm_num⟩
  have hc := certK4_true
  unfold certK4 at hc
  simp only [Bool.and_eq_true] at hc
  obtain ⟨⟨⟨hwf, -⟩, -⟩, -⟩ := hc
  have h := law_of_top R24lit R24lit_D_ne seed5_K4 s (GephyrosisDepthEternal_live hwf s hs)
  rw [top24_five _ s hs, R24lit_n, show seed5_K4 = seedData 5 80 from rfl, ratOrbit_K4lit] at h
  exact h

end Gephyrosis
