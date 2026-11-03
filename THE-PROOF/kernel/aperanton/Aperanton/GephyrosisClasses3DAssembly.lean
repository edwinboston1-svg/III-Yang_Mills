import Aperanton.GephyrosisClasses3DS21Chunk0
import Aperanton.GephyrosisClasses3DS21Chunk1
import Aperanton.GephyrosisClasses3DS21Chunk2
import Aperanton.GephyrosisClasses3DS21Chunk3
import Aperanton.GephyrosisClasses3DS21Chunk4
import Aperanton.GephyrosisClasses3DS21Chunk5
import Aperanton.GephyrosisClasses3DS36Chunk0
import Aperanton.GephyrosisClasses3DS36Chunk1
import Aperanton.GephyrosisClasses3DS36Chunk2
import Aperanton.GephyrosisClasses3DS36Chunk3
import Aperanton.GephyrosisClasses3DS36Chunk4
import Aperanton.GephyrosisClasses3DS36Chunk5
import Aperanton.GephyrosisClasses3DS36Chunk6
import Aperanton.GephyrosisClasses3DS36Chunk7
import Aperanton.GephyrosisClasses3DS36Chunk8
import Aperanton.GephyrosisClasses3DS36Chunk9
import Aperanton.GephyrosisClasses3DS36Chunk10

/-! # ΓΕΦΥΡΩΣΙΣ — two eternal Jacobsthal laws in three dimensions, assembled from their chunks

The seeds 21 and 36 of the 3D box `K = 1` close at (37, 16) and (101, 6): 53 and 107 steps of the 52-coordinate
automaton, read in chunks of ten steps on the literal road `R31lit` (one kernel process each), the closure decided on
the literal states, `class_eternal_pieces` drawing the conclusion, and `ratOrbit_K31lit` carrying it to the exact
orbit. -/

namespace Gephyrosis

/-- the literal 3D road is well formed (one kernel check, shared by both seeds) -/
theorem wf31 : wfCheck R31lit = true := by decide +kernel

theorem GephyrosisClasses3DS21_reach10 : autoFrom R31lit 3 init3D21 10 = st3D21_10 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  exact (chunk_read R31lit _ _ 0 10 chkGephyrosisClasses3DS21 GephyrosisClasses3DS21_chunk0).2

theorem GephyrosisClasses3DS21_reach20 : autoFrom R31lit 3 init3D21 20 = st3D21_20 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (20 : ℕ) = 10 + 10 from rfl, autoFrom_add, GephyrosisClasses3DS21_reach10]
  exact (chunk_read R31lit _ _ 10 10 chkGephyrosisClasses3DS21 GephyrosisClasses3DS21_chunk1).2

theorem GephyrosisClasses3DS21_reach30 : autoFrom R31lit 3 init3D21 30 = st3D21_30 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (30 : ℕ) = 20 + 10 from rfl, autoFrom_add, GephyrosisClasses3DS21_reach20]
  exact (chunk_read R31lit _ _ 20 10 chkGephyrosisClasses3DS21 GephyrosisClasses3DS21_chunk2).2

theorem GephyrosisClasses3DS21_reach37 : autoFrom R31lit 3 init3D21 37 = st3D21_37 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (37 : ℕ) = 30 + 7 from rfl, autoFrom_add, GephyrosisClasses3DS21_reach30]
  exact (chunk_read R31lit _ _ 30 7 chkGephyrosisClasses3DS21 GephyrosisClasses3DS21_chunk3).2

theorem GephyrosisClasses3DS21_reach47 : autoFrom R31lit 3 init3D21 47 = st3D21_47 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (47 : ℕ) = 37 + 10 from rfl, autoFrom_add, GephyrosisClasses3DS21_reach37]
  exact (chunk_read R31lit _ _ 37 10 chkGephyrosisClasses3DS21 GephyrosisClasses3DS21_chunk4).2

theorem GephyrosisClasses3DS21_reach53 : autoFrom R31lit 3 init3D21 53 = st3D21_53 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (53 : ℕ) = 47 + 6 from rfl, autoFrom_add, GephyrosisClasses3DS21_reach47]
  exact (chunk_read R31lit _ _ 47 6 chkGephyrosisClasses3DS21 GephyrosisClasses3DS21_chunk5).2

theorem GephyrosisClasses3DS21_seg (s0 N : ℕ) (stq stN : List ℤ × List ℕ) (hreach : autoFrom R31lit 3 init3D21 s0 = stq)
    (hc : chunkCert R31lit 3 stq stN s0 N chkGephyrosisClasses3DS21 = true) :
    ∀ i ≤ N, chkGephyrosisClasses3DS21 (s0 + i) (autoFrom R31lit 3 init3D21 (s0 + i)) = true := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  intro i hi
  rw [autoFrom_add, hreach]
  exact (chunk_read R31lit _ _ s0 N chkGephyrosisClasses3DS21 hc).1 i hi

theorem GephyrosisClasses3DS21_all (s : ℕ) (hs : s ≤ 53) : chkGephyrosisClasses3DS21 s (autoOrbit R31lit 3 seed21_3D s) = true := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [autoOrbit_eq_from]
  show chkGephyrosisClasses3DS21 s (autoFrom R31lit 3 init3D21 s) = true
  by_cases h0 : s ≤ 10
  · simpa using GephyrosisClasses3DS21_seg 0 10 init3D21 st3D21_10 rfl GephyrosisClasses3DS21_chunk0 s h0
  by_cases h1 : s ≤ 20
  · have := GephyrosisClasses3DS21_seg 10 10 _ _ GephyrosisClasses3DS21_reach10 GephyrosisClasses3DS21_chunk1 (s - 10) (by omega)
    rwa [show 10 + (s - 10) = s by omega] at this
  by_cases h2 : s ≤ 30
  · have := GephyrosisClasses3DS21_seg 20 10 _ _ GephyrosisClasses3DS21_reach20 GephyrosisClasses3DS21_chunk2 (s - 20) (by omega)
    rwa [show 20 + (s - 20) = s by omega] at this
  by_cases h3 : s ≤ 37
  · have := GephyrosisClasses3DS21_seg 30 7 _ _ GephyrosisClasses3DS21_reach30 GephyrosisClasses3DS21_chunk3 (s - 30) (by omega)
    rwa [show 30 + (s - 30) = s by omega] at this
  by_cases h4 : s ≤ 47
  · have := GephyrosisClasses3DS21_seg 37 10 _ _ GephyrosisClasses3DS21_reach37 GephyrosisClasses3DS21_chunk4 (s - 37) (by omega)
    rwa [show 37 + (s - 37) = s by omega] at this
  · have := GephyrosisClasses3DS21_seg 47 6 _ _ GephyrosisClasses3DS21_reach47 GephyrosisClasses3DS21_chunk5 (s - 47) (by omega)
    rwa [show 47 + (s - 47) = s by omega] at this

theorem GephyrosisClasses3DS21_close : st3D21_53 = (st3D21_37.1.map (· + 3002353938595840), scaleR 3 1 st3D21_37.2) := by
  decide +kernel

theorem GephyrosisClasses3DS21_live (hwf : wfCheck R31lit = true) : ∀ s, 1 ≤ s → TopLive R31lit 3 seed21_3D s := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  have hclose : autoOrbit R31lit 3 seed21_3D (37 + 16)
      = ((autoOrbit R31lit 3 seed21_3D 37).1.map (· + 3002353938595840), scaleR 3 1 (autoOrbit R31lit 3 seed21_3D 37).2) := by
    rw [autoOrbit_eq_from, autoOrbit_eq_from]
    show autoFrom R31lit 3 init3D21 53 = ((autoFrom R31lit 3 init3D21 37).1.map (· + 3002353938595840), scaleR 3 1 (autoFrom R31lit 3 init3D21 37).2)
    rw [GephyrosisClasses3DS21_reach53, GephyrosisClasses3DS21_reach37]
    exact GephyrosisClasses3DS21_close
  have hNA : ∀ i < 16, NonAttain R31lit 3 (autoOrbit R31lit 3 seed21_3D (37 + i)).1 := by
    intro i hi
    have := GephyrosisClasses3DS21_all (37 + i) (by omega)
    unfold chkGephyrosisClasses3DS21 at this
    simp only [Bool.and_eq_true, Bool.or_eq_true, decide_eq_true_eq] at this
    rcases this.2 with h | h
    · omega
    · exact nonAttain_of_check _ _ _ h
  have hinit : ∀ s, 1 ≤ s → s ≤ 37 + 16 → TopLive R31lit 3 seed21_3D s := by
    intro s h1 h2
    have := GephyrosisClasses3DS21_all s (by omega)
    unfold chkGephyrosisClasses3DS21 at this
    simp only [Bool.and_eq_true, Bool.or_eq_true, decide_eq_true_eq] at this
    rcases this.1 with h | h
    · omega
    · exact topLive_of_check _ _ _ h
  exact class_eternal_pieces R31lit seed21_3D 37 16 (by norm_num) 3002353938595840 (by norm_num) 1
    (by norm_num) (by rw [R31lit_n]; norm_num) (wellformed_of_check _ hwf) hclose hNA hinit

theorem GephyrosisClasses3DS36_reach10 : autoFrom R31lit 3 init3D36 10 = st3D36_10 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  exact (chunk_read R31lit _ _ 0 10 chkGephyrosisClasses3DS36 GephyrosisClasses3DS36_chunk0).2

theorem GephyrosisClasses3DS36_reach20 : autoFrom R31lit 3 init3D36 20 = st3D36_20 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (20 : ℕ) = 10 + 10 from rfl, autoFrom_add, GephyrosisClasses3DS36_reach10]
  exact (chunk_read R31lit _ _ 10 10 chkGephyrosisClasses3DS36 GephyrosisClasses3DS36_chunk1).2

theorem GephyrosisClasses3DS36_reach30 : autoFrom R31lit 3 init3D36 30 = st3D36_30 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (30 : ℕ) = 20 + 10 from rfl, autoFrom_add, GephyrosisClasses3DS36_reach20]
  exact (chunk_read R31lit _ _ 20 10 chkGephyrosisClasses3DS36 GephyrosisClasses3DS36_chunk2).2

theorem GephyrosisClasses3DS36_reach40 : autoFrom R31lit 3 init3D36 40 = st3D36_40 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (40 : ℕ) = 30 + 10 from rfl, autoFrom_add, GephyrosisClasses3DS36_reach30]
  exact (chunk_read R31lit _ _ 30 10 chkGephyrosisClasses3DS36 GephyrosisClasses3DS36_chunk3).2

theorem GephyrosisClasses3DS36_reach50 : autoFrom R31lit 3 init3D36 50 = st3D36_50 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (50 : ℕ) = 40 + 10 from rfl, autoFrom_add, GephyrosisClasses3DS36_reach40]
  exact (chunk_read R31lit _ _ 40 10 chkGephyrosisClasses3DS36 GephyrosisClasses3DS36_chunk4).2

theorem GephyrosisClasses3DS36_reach60 : autoFrom R31lit 3 init3D36 60 = st3D36_60 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (60 : ℕ) = 50 + 10 from rfl, autoFrom_add, GephyrosisClasses3DS36_reach50]
  exact (chunk_read R31lit _ _ 50 10 chkGephyrosisClasses3DS36 GephyrosisClasses3DS36_chunk5).2

theorem GephyrosisClasses3DS36_reach70 : autoFrom R31lit 3 init3D36 70 = st3D36_70 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (70 : ℕ) = 60 + 10 from rfl, autoFrom_add, GephyrosisClasses3DS36_reach60]
  exact (chunk_read R31lit _ _ 60 10 chkGephyrosisClasses3DS36 GephyrosisClasses3DS36_chunk6).2

theorem GephyrosisClasses3DS36_reach80 : autoFrom R31lit 3 init3D36 80 = st3D36_80 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (80 : ℕ) = 70 + 10 from rfl, autoFrom_add, GephyrosisClasses3DS36_reach70]
  exact (chunk_read R31lit _ _ 70 10 chkGephyrosisClasses3DS36 GephyrosisClasses3DS36_chunk7).2

theorem GephyrosisClasses3DS36_reach90 : autoFrom R31lit 3 init3D36 90 = st3D36_90 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (90 : ℕ) = 80 + 10 from rfl, autoFrom_add, GephyrosisClasses3DS36_reach80]
  exact (chunk_read R31lit _ _ 80 10 chkGephyrosisClasses3DS36 GephyrosisClasses3DS36_chunk8).2

theorem GephyrosisClasses3DS36_reach101 : autoFrom R31lit 3 init3D36 101 = st3D36_101 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (101 : ℕ) = 90 + 11 from rfl, autoFrom_add, GephyrosisClasses3DS36_reach90]
  exact (chunk_read R31lit _ _ 90 11 chkGephyrosisClasses3DS36 GephyrosisClasses3DS36_chunk9).2

theorem GephyrosisClasses3DS36_reach107 : autoFrom R31lit 3 init3D36 107 = st3D36_107 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (107 : ℕ) = 101 + 6 from rfl, autoFrom_add, GephyrosisClasses3DS36_reach101]
  exact (chunk_read R31lit _ _ 101 6 chkGephyrosisClasses3DS36 GephyrosisClasses3DS36_chunk10).2

theorem GephyrosisClasses3DS36_seg (s0 N : ℕ) (stq stN : List ℤ × List ℕ) (hreach : autoFrom R31lit 3 init3D36 s0 = stq)
    (hc : chunkCert R31lit 3 stq stN s0 N chkGephyrosisClasses3DS36 = true) :
    ∀ i ≤ N, chkGephyrosisClasses3DS36 (s0 + i) (autoFrom R31lit 3 init3D36 (s0 + i)) = true := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  intro i hi
  rw [autoFrom_add, hreach]
  exact (chunk_read R31lit _ _ s0 N chkGephyrosisClasses3DS36 hc).1 i hi

theorem GephyrosisClasses3DS36_all (s : ℕ) (hs : s ≤ 107) : chkGephyrosisClasses3DS36 s (autoOrbit R31lit 3 seed36_3D s) = true := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [autoOrbit_eq_from]
  show chkGephyrosisClasses3DS36 s (autoFrom R31lit 3 init3D36 s) = true
  by_cases h0 : s ≤ 10
  · simpa using GephyrosisClasses3DS36_seg 0 10 init3D36 st3D36_10 rfl GephyrosisClasses3DS36_chunk0 s h0
  by_cases h1 : s ≤ 20
  · have := GephyrosisClasses3DS36_seg 10 10 _ _ GephyrosisClasses3DS36_reach10 GephyrosisClasses3DS36_chunk1 (s - 10) (by omega)
    rwa [show 10 + (s - 10) = s by omega] at this
  by_cases h2 : s ≤ 30
  · have := GephyrosisClasses3DS36_seg 20 10 _ _ GephyrosisClasses3DS36_reach20 GephyrosisClasses3DS36_chunk2 (s - 20) (by omega)
    rwa [show 20 + (s - 20) = s by omega] at this
  by_cases h3 : s ≤ 40
  · have := GephyrosisClasses3DS36_seg 30 10 _ _ GephyrosisClasses3DS36_reach30 GephyrosisClasses3DS36_chunk3 (s - 30) (by omega)
    rwa [show 30 + (s - 30) = s by omega] at this
  by_cases h4 : s ≤ 50
  · have := GephyrosisClasses3DS36_seg 40 10 _ _ GephyrosisClasses3DS36_reach40 GephyrosisClasses3DS36_chunk4 (s - 40) (by omega)
    rwa [show 40 + (s - 40) = s by omega] at this
  by_cases h5 : s ≤ 60
  · have := GephyrosisClasses3DS36_seg 50 10 _ _ GephyrosisClasses3DS36_reach50 GephyrosisClasses3DS36_chunk5 (s - 50) (by omega)
    rwa [show 50 + (s - 50) = s by omega] at this
  by_cases h6 : s ≤ 70
  · have := GephyrosisClasses3DS36_seg 60 10 _ _ GephyrosisClasses3DS36_reach60 GephyrosisClasses3DS36_chunk6 (s - 60) (by omega)
    rwa [show 60 + (s - 60) = s by omega] at this
  by_cases h7 : s ≤ 80
  · have := GephyrosisClasses3DS36_seg 70 10 _ _ GephyrosisClasses3DS36_reach70 GephyrosisClasses3DS36_chunk7 (s - 70) (by omega)
    rwa [show 70 + (s - 70) = s by omega] at this
  by_cases h8 : s ≤ 90
  · have := GephyrosisClasses3DS36_seg 80 10 _ _ GephyrosisClasses3DS36_reach80 GephyrosisClasses3DS36_chunk8 (s - 80) (by omega)
    rwa [show 80 + (s - 80) = s by omega] at this
  by_cases h9 : s ≤ 101
  · have := GephyrosisClasses3DS36_seg 90 11 _ _ GephyrosisClasses3DS36_reach90 GephyrosisClasses3DS36_chunk9 (s - 90) (by omega)
    rwa [show 90 + (s - 90) = s by omega] at this
  · have := GephyrosisClasses3DS36_seg 101 6 _ _ GephyrosisClasses3DS36_reach101 GephyrosisClasses3DS36_chunk10 (s - 101) (by omega)
    rwa [show 101 + (s - 101) = s by omega] at this

theorem GephyrosisClasses3DS36_close : st3D36_107 = (st3D36_101.1.map (· + 53241325209585634862861534625792), scaleR 3 1 st3D36_101.2) := by
  decide +kernel

theorem GephyrosisClasses3DS36_live (hwf : wfCheck R31lit = true) : ∀ s, 1 ≤ s → TopLive R31lit 3 seed36_3D s := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  have hclose : autoOrbit R31lit 3 seed36_3D (101 + 6)
      = ((autoOrbit R31lit 3 seed36_3D 101).1.map (· + 53241325209585634862861534625792), scaleR 3 1 (autoOrbit R31lit 3 seed36_3D 101).2) := by
    rw [autoOrbit_eq_from, autoOrbit_eq_from]
    show autoFrom R31lit 3 init3D36 107 = ((autoFrom R31lit 3 init3D36 101).1.map (· + 53241325209585634862861534625792), scaleR 3 1 (autoFrom R31lit 3 init3D36 101).2)
    rw [GephyrosisClasses3DS36_reach107, GephyrosisClasses3DS36_reach101]
    exact GephyrosisClasses3DS36_close
  have hNA : ∀ i < 6, NonAttain R31lit 3 (autoOrbit R31lit 3 seed36_3D (101 + i)).1 := by
    intro i hi
    have := GephyrosisClasses3DS36_all (101 + i) (by omega)
    unfold chkGephyrosisClasses3DS36 at this
    simp only [Bool.and_eq_true, Bool.or_eq_true, decide_eq_true_eq] at this
    rcases this.2 with h | h
    · omega
    · exact nonAttain_of_check _ _ _ h
  have hinit : ∀ s, 1 ≤ s → s ≤ 101 + 6 → TopLive R31lit 3 seed36_3D s := by
    intro s h1 h2
    have := GephyrosisClasses3DS36_all s (by omega)
    unfold chkGephyrosisClasses3DS36 at this
    simp only [Bool.and_eq_true, Bool.or_eq_true, decide_eq_true_eq] at this
    rcases this.1 with h | h
    · omega
    · exact topLive_of_check _ _ _ h
  exact class_eternal_pieces R31lit seed36_3D 101 6 (by norm_num) 53241325209585634862861534625792 (by norm_num) 1
    (by norm_num) (by rw [R31lit_n]; norm_num) (wellformed_of_check _ hwf) hclose hNA hinit

/-- **AN ETERNAL JACOBSTHAL LAW IN THREE DIMENSIONS**: the integer seed 21 of the 3D box `K = 1`
attains `J_s` at every step. -/
theorem seed21_3D_eternal_law (s : ℕ) (hs : 1 ≤ s) :
    (∀ k < 52, (rorbit31 21 s).getD k 0 ≠ 0 →
        -padicValRat 3 ((rorbit31 21 s).getD k 0) ≤ (jacobsthal s : ℤ)) ∧
    (∃ k < 52, (rorbit31 21 s).getD k 0 ≠ 0 ∧
        -padicValRat 3 ((rorbit31 21 s).getD k 0) = (jacobsthal s : ℤ)) := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  have h := law_of_top R31lit R31lit_D_ne seed21_3D s (GephyrosisClasses3DS21_live wf31 s hs)
  rw [topOf_K31lit, top31_three _ s hs, show seed21_3D = seedData 21 52 from rfl, ratOrbit_K31lit,
    ratOrbit_eq_rorbit31, R31lit_n] at h
  exact h

/-- **AN ETERNAL JACOBSTHAL LAW IN THREE DIMENSIONS**: the integer seed 36 of the 3D box `K = 1`
attains `J_s` at every step. -/
theorem seed36_3D_eternal_law (s : ℕ) (hs : 1 ≤ s) :
    (∀ k < 52, (rorbit31 36 s).getD k 0 ≠ 0 →
        -padicValRat 3 ((rorbit31 36 s).getD k 0) ≤ (jacobsthal s : ℤ)) ∧
    (∃ k < 52, (rorbit31 36 s).getD k 0 ≠ 0 ∧
        -padicValRat 3 ((rorbit31 36 s).getD k 0) = (jacobsthal s : ℤ)) := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  have h := law_of_top R31lit R31lit_D_ne seed36_3D s (GephyrosisClasses3DS36_live wf31 s hs)
  rw [topOf_K31lit, top31_three _ s hs, show seed36_3D = seedData 36 52 from rfl, ratOrbit_K31lit,
    ratOrbit_eq_rorbit31, R31lit_n] at h
  exact h

end Gephyrosis
