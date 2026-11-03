import Aperanton.GephyrosisBreak3DChunk0
import Aperanton.GephyrosisBreak3DChunk1
import Aperanton.GephyrosisBreak3DChunk2
import Aperanton.GephyrosisBreak3DChunk3
import Aperanton.GephyrosisBreak3DChunk4
import Aperanton.GephyrosisBreak3DChunk5
import Aperanton.GephyrosisBreak3DChunk6
import Aperanton.GephyrosisBreak3DChunk7
import Aperanton.GephyrosisBreak3DChunk8
import Aperanton.GephyrosisBreak3DChunk9
import Aperanton.GephyrosisBreak3DChunk10
import Aperanton.GephyrosisBreak3DChunk11
import Aperanton.GephyrosisBreak3DChunk12
import Aperanton.GephyrosisBreak3DChunk13
import Aperanton.GephyrosisBreak3DChunk14
import Aperanton.GephyrosisBreak3DChunk15
import Aperanton.GephyrosisBreak3DChunk16
import Aperanton.GephyrosisBreak3DChunk17
import Aperanton.GephyrosisBreak3DChunk18
import Aperanton.GephyrosisBreak3DChunk19
import Aperanton.GephyrosisBreak3DChunk20
import Aperanton.GephyrosisBreak3DChunk21
import Aperanton.GephyrosisBreak3DChunk22
import Aperanton.GephyrosisBreak3DChunk23
import Aperanton.GephyrosisBreak3DChunk24
import Aperanton.GephyrosisBreak3DChunk25
import Aperanton.GephyrosisBreak3DChunk26
import Aperanton.GephyrosisBreak3DChunk27
import Aperanton.GephyrosisBreak3DChunk28
import Aperanton.GephyrosisBreak3DChunk29
import Aperanton.GephyrosisBreak3DChunk30
import Aperanton.GephyrosisBreak3DChunk31
import Aperanton.GephyrosisBreak3DChunk32
import Aperanton.GephyrosisBreak3DChunk33
import Aperanton.GephyrosisBreak3DChunk34
import Aperanton.GephyrosisBreak3DChunk35
import Aperanton.GephyrosisBreak3DChunk36
import Aperanton.GephyrosisBreak3DChunk37
import Aperanton.GephyrosisBreak3DChunk38
import Aperanton.GephyrosisBreak3DChunk39
import Aperanton.GephyrosisBreak3DChunk40
import Aperanton.GephyrosisBreak3DChunk41
import Aperanton.GephyrosisBreak3DChunk42
import Aperanton.GephyrosisBreak3DChunk43
import Aperanton.GephyrosisBreak3DChunk44
import Aperanton.GephyrosisBreak3DChunk45
import Aperanton.GephyrosisBreak3DChunk46
import Aperanton.GephyrosisBreak3DChunk47
import Aperanton.GephyrosisBreak3DChunk48
import Aperanton.GephyrosisBreak3DChunk49
import Aperanton.GephyrosisBreak3DChunk50
import Aperanton.GephyrosisBreak3DChunk51
import Aperanton.GephyrosisBreak3DChunk52
import Aperanton.GephyrosisBreak3DChunk53
import Aperanton.GephyrosisBreak3DChunk54
import Aperanton.GephyrosisBreak3DChunk55
import Aperanton.GephyrosisBreak3DChunk56
import Aperanton.GephyrosisBreak3DChunk57
import Aperanton.GephyrosisBreak3DChunk58
import Aperanton.GephyrosisBreak3DChunk59
import Aperanton.GephyrosisBreak3DChunk60
import Aperanton.GephyrosisBreak3DChunk61
import Aperanton.GephyrosisBreak3DChunk62
import Aperanton.GephyrosisBreak3DChunk63
import Aperanton.GephyrosisBreak3DChunk64
import Aperanton.GephyrosisBreak3DChunk65
import Aperanton.GephyrosisBreak3DChunk66
import Aperanton.GephyrosisBreak3DChunk67
import Aperanton.GephyrosisBreak3DChunk68
import Aperanton.GephyrosisBreak3DChunk69
import Aperanton.GephyrosisBreak3DChunk70

/-! # ΓΕΦΥΡΩΣΙΣ — THE BREAK AT 705, the assembly: the seventy-one chunk certificates on the literal 3D road chained,
the reading at every step, Theorems T and D turning it into the Jacobsthal law through 704 and the break at 705,
and `ratOrbit_K31lit` carrying it to the exact orbit. -/

namespace Gephyrosis

theorem GephyrosisBreak3D_reach10 : autoFrom R31lit 3 init3D 10 = st3D_10 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  exact (chunk_read R31lit _ _ 0 10 chk3D GephyrosisBreak3D_chunk0).2

theorem GephyrosisBreak3D_reach20 : autoFrom R31lit 3 init3D 20 = st3D_20 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (20 : ℕ) = 10 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach10]
  exact (chunk_read R31lit _ _ 10 10 chk3D GephyrosisBreak3D_chunk1).2

theorem GephyrosisBreak3D_reach30 : autoFrom R31lit 3 init3D 30 = st3D_30 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (30 : ℕ) = 20 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach20]
  exact (chunk_read R31lit _ _ 20 10 chk3D GephyrosisBreak3D_chunk2).2

theorem GephyrosisBreak3D_reach40 : autoFrom R31lit 3 init3D 40 = st3D_40 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (40 : ℕ) = 30 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach30]
  exact (chunk_read R31lit _ _ 30 10 chk3D GephyrosisBreak3D_chunk3).2

theorem GephyrosisBreak3D_reach50 : autoFrom R31lit 3 init3D 50 = st3D_50 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (50 : ℕ) = 40 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach40]
  exact (chunk_read R31lit _ _ 40 10 chk3D GephyrosisBreak3D_chunk4).2

theorem GephyrosisBreak3D_reach60 : autoFrom R31lit 3 init3D 60 = st3D_60 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (60 : ℕ) = 50 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach50]
  exact (chunk_read R31lit _ _ 50 10 chk3D GephyrosisBreak3D_chunk5).2

theorem GephyrosisBreak3D_reach70 : autoFrom R31lit 3 init3D 70 = st3D_70 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (70 : ℕ) = 60 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach60]
  exact (chunk_read R31lit _ _ 60 10 chk3D GephyrosisBreak3D_chunk6).2

theorem GephyrosisBreak3D_reach80 : autoFrom R31lit 3 init3D 80 = st3D_80 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (80 : ℕ) = 70 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach70]
  exact (chunk_read R31lit _ _ 70 10 chk3D GephyrosisBreak3D_chunk7).2

theorem GephyrosisBreak3D_reach90 : autoFrom R31lit 3 init3D 90 = st3D_90 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (90 : ℕ) = 80 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach80]
  exact (chunk_read R31lit _ _ 80 10 chk3D GephyrosisBreak3D_chunk8).2

theorem GephyrosisBreak3D_reach100 : autoFrom R31lit 3 init3D 100 = st3D_100 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (100 : ℕ) = 90 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach90]
  exact (chunk_read R31lit _ _ 90 10 chk3D GephyrosisBreak3D_chunk9).2

theorem GephyrosisBreak3D_reach110 : autoFrom R31lit 3 init3D 110 = st3D_110 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (110 : ℕ) = 100 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach100]
  exact (chunk_read R31lit _ _ 100 10 chk3D GephyrosisBreak3D_chunk10).2

theorem GephyrosisBreak3D_reach120 : autoFrom R31lit 3 init3D 120 = st3D_120 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (120 : ℕ) = 110 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach110]
  exact (chunk_read R31lit _ _ 110 10 chk3D GephyrosisBreak3D_chunk11).2

theorem GephyrosisBreak3D_reach130 : autoFrom R31lit 3 init3D 130 = st3D_130 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (130 : ℕ) = 120 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach120]
  exact (chunk_read R31lit _ _ 120 10 chk3D GephyrosisBreak3D_chunk12).2

theorem GephyrosisBreak3D_reach140 : autoFrom R31lit 3 init3D 140 = st3D_140 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (140 : ℕ) = 130 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach130]
  exact (chunk_read R31lit _ _ 130 10 chk3D GephyrosisBreak3D_chunk13).2

theorem GephyrosisBreak3D_reach150 : autoFrom R31lit 3 init3D 150 = st3D_150 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (150 : ℕ) = 140 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach140]
  exact (chunk_read R31lit _ _ 140 10 chk3D GephyrosisBreak3D_chunk14).2

theorem GephyrosisBreak3D_reach160 : autoFrom R31lit 3 init3D 160 = st3D_160 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (160 : ℕ) = 150 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach150]
  exact (chunk_read R31lit _ _ 150 10 chk3D GephyrosisBreak3D_chunk15).2

theorem GephyrosisBreak3D_reach170 : autoFrom R31lit 3 init3D 170 = st3D_170 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (170 : ℕ) = 160 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach160]
  exact (chunk_read R31lit _ _ 160 10 chk3D GephyrosisBreak3D_chunk16).2

theorem GephyrosisBreak3D_reach180 : autoFrom R31lit 3 init3D 180 = st3D_180 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (180 : ℕ) = 170 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach170]
  exact (chunk_read R31lit _ _ 170 10 chk3D GephyrosisBreak3D_chunk17).2

theorem GephyrosisBreak3D_reach190 : autoFrom R31lit 3 init3D 190 = st3D_190 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (190 : ℕ) = 180 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach180]
  exact (chunk_read R31lit _ _ 180 10 chk3D GephyrosisBreak3D_chunk18).2

theorem GephyrosisBreak3D_reach200 : autoFrom R31lit 3 init3D 200 = st3D_200 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (200 : ℕ) = 190 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach190]
  exact (chunk_read R31lit _ _ 190 10 chk3D GephyrosisBreak3D_chunk19).2

theorem GephyrosisBreak3D_reach210 : autoFrom R31lit 3 init3D 210 = st3D_210 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (210 : ℕ) = 200 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach200]
  exact (chunk_read R31lit _ _ 200 10 chk3D GephyrosisBreak3D_chunk20).2

theorem GephyrosisBreak3D_reach220 : autoFrom R31lit 3 init3D 220 = st3D_220 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (220 : ℕ) = 210 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach210]
  exact (chunk_read R31lit _ _ 210 10 chk3D GephyrosisBreak3D_chunk21).2

theorem GephyrosisBreak3D_reach230 : autoFrom R31lit 3 init3D 230 = st3D_230 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (230 : ℕ) = 220 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach220]
  exact (chunk_read R31lit _ _ 220 10 chk3D GephyrosisBreak3D_chunk22).2

theorem GephyrosisBreak3D_reach240 : autoFrom R31lit 3 init3D 240 = st3D_240 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (240 : ℕ) = 230 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach230]
  exact (chunk_read R31lit _ _ 230 10 chk3D GephyrosisBreak3D_chunk23).2

theorem GephyrosisBreak3D_reach250 : autoFrom R31lit 3 init3D 250 = st3D_250 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (250 : ℕ) = 240 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach240]
  exact (chunk_read R31lit _ _ 240 10 chk3D GephyrosisBreak3D_chunk24).2

theorem GephyrosisBreak3D_reach260 : autoFrom R31lit 3 init3D 260 = st3D_260 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (260 : ℕ) = 250 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach250]
  exact (chunk_read R31lit _ _ 250 10 chk3D GephyrosisBreak3D_chunk25).2

theorem GephyrosisBreak3D_reach270 : autoFrom R31lit 3 init3D 270 = st3D_270 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (270 : ℕ) = 260 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach260]
  exact (chunk_read R31lit _ _ 260 10 chk3D GephyrosisBreak3D_chunk26).2

theorem GephyrosisBreak3D_reach280 : autoFrom R31lit 3 init3D 280 = st3D_280 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (280 : ℕ) = 270 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach270]
  exact (chunk_read R31lit _ _ 270 10 chk3D GephyrosisBreak3D_chunk27).2

theorem GephyrosisBreak3D_reach290 : autoFrom R31lit 3 init3D 290 = st3D_290 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (290 : ℕ) = 280 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach280]
  exact (chunk_read R31lit _ _ 280 10 chk3D GephyrosisBreak3D_chunk28).2

theorem GephyrosisBreak3D_reach300 : autoFrom R31lit 3 init3D 300 = st3D_300 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (300 : ℕ) = 290 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach290]
  exact (chunk_read R31lit _ _ 290 10 chk3D GephyrosisBreak3D_chunk29).2

theorem GephyrosisBreak3D_reach310 : autoFrom R31lit 3 init3D 310 = st3D_310 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (310 : ℕ) = 300 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach300]
  exact (chunk_read R31lit _ _ 300 10 chk3D GephyrosisBreak3D_chunk30).2

theorem GephyrosisBreak3D_reach320 : autoFrom R31lit 3 init3D 320 = st3D_320 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (320 : ℕ) = 310 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach310]
  exact (chunk_read R31lit _ _ 310 10 chk3D GephyrosisBreak3D_chunk31).2

theorem GephyrosisBreak3D_reach330 : autoFrom R31lit 3 init3D 330 = st3D_330 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (330 : ℕ) = 320 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach320]
  exact (chunk_read R31lit _ _ 320 10 chk3D GephyrosisBreak3D_chunk32).2

theorem GephyrosisBreak3D_reach340 : autoFrom R31lit 3 init3D 340 = st3D_340 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (340 : ℕ) = 330 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach330]
  exact (chunk_read R31lit _ _ 330 10 chk3D GephyrosisBreak3D_chunk33).2

theorem GephyrosisBreak3D_reach350 : autoFrom R31lit 3 init3D 350 = st3D_350 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (350 : ℕ) = 340 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach340]
  exact (chunk_read R31lit _ _ 340 10 chk3D GephyrosisBreak3D_chunk34).2

theorem GephyrosisBreak3D_reach360 : autoFrom R31lit 3 init3D 360 = st3D_360 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (360 : ℕ) = 350 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach350]
  exact (chunk_read R31lit _ _ 350 10 chk3D GephyrosisBreak3D_chunk35).2

theorem GephyrosisBreak3D_reach370 : autoFrom R31lit 3 init3D 370 = st3D_370 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (370 : ℕ) = 360 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach360]
  exact (chunk_read R31lit _ _ 360 10 chk3D GephyrosisBreak3D_chunk36).2

theorem GephyrosisBreak3D_reach380 : autoFrom R31lit 3 init3D 380 = st3D_380 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (380 : ℕ) = 370 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach370]
  exact (chunk_read R31lit _ _ 370 10 chk3D GephyrosisBreak3D_chunk37).2

theorem GephyrosisBreak3D_reach390 : autoFrom R31lit 3 init3D 390 = st3D_390 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (390 : ℕ) = 380 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach380]
  exact (chunk_read R31lit _ _ 380 10 chk3D GephyrosisBreak3D_chunk38).2

theorem GephyrosisBreak3D_reach400 : autoFrom R31lit 3 init3D 400 = st3D_400 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (400 : ℕ) = 390 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach390]
  exact (chunk_read R31lit _ _ 390 10 chk3D GephyrosisBreak3D_chunk39).2

theorem GephyrosisBreak3D_reach410 : autoFrom R31lit 3 init3D 410 = st3D_410 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (410 : ℕ) = 400 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach400]
  exact (chunk_read R31lit _ _ 400 10 chk3D GephyrosisBreak3D_chunk40).2

theorem GephyrosisBreak3D_reach420 : autoFrom R31lit 3 init3D 420 = st3D_420 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (420 : ℕ) = 410 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach410]
  exact (chunk_read R31lit _ _ 410 10 chk3D GephyrosisBreak3D_chunk41).2

theorem GephyrosisBreak3D_reach430 : autoFrom R31lit 3 init3D 430 = st3D_430 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (430 : ℕ) = 420 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach420]
  exact (chunk_read R31lit _ _ 420 10 chk3D GephyrosisBreak3D_chunk42).2

theorem GephyrosisBreak3D_reach440 : autoFrom R31lit 3 init3D 440 = st3D_440 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (440 : ℕ) = 430 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach430]
  exact (chunk_read R31lit _ _ 430 10 chk3D GephyrosisBreak3D_chunk43).2

theorem GephyrosisBreak3D_reach450 : autoFrom R31lit 3 init3D 450 = st3D_450 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (450 : ℕ) = 440 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach440]
  exact (chunk_read R31lit _ _ 440 10 chk3D GephyrosisBreak3D_chunk44).2

theorem GephyrosisBreak3D_reach460 : autoFrom R31lit 3 init3D 460 = st3D_460 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (460 : ℕ) = 450 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach450]
  exact (chunk_read R31lit _ _ 450 10 chk3D GephyrosisBreak3D_chunk45).2

theorem GephyrosisBreak3D_reach470 : autoFrom R31lit 3 init3D 470 = st3D_470 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (470 : ℕ) = 460 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach460]
  exact (chunk_read R31lit _ _ 460 10 chk3D GephyrosisBreak3D_chunk46).2

theorem GephyrosisBreak3D_reach480 : autoFrom R31lit 3 init3D 480 = st3D_480 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (480 : ℕ) = 470 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach470]
  exact (chunk_read R31lit _ _ 470 10 chk3D GephyrosisBreak3D_chunk47).2

theorem GephyrosisBreak3D_reach490 : autoFrom R31lit 3 init3D 490 = st3D_490 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (490 : ℕ) = 480 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach480]
  exact (chunk_read R31lit _ _ 480 10 chk3D GephyrosisBreak3D_chunk48).2

theorem GephyrosisBreak3D_reach500 : autoFrom R31lit 3 init3D 500 = st3D_500 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (500 : ℕ) = 490 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach490]
  exact (chunk_read R31lit _ _ 490 10 chk3D GephyrosisBreak3D_chunk49).2

theorem GephyrosisBreak3D_reach510 : autoFrom R31lit 3 init3D 510 = st3D_510 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (510 : ℕ) = 500 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach500]
  exact (chunk_read R31lit _ _ 500 10 chk3D GephyrosisBreak3D_chunk50).2

theorem GephyrosisBreak3D_reach520 : autoFrom R31lit 3 init3D 520 = st3D_520 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (520 : ℕ) = 510 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach510]
  exact (chunk_read R31lit _ _ 510 10 chk3D GephyrosisBreak3D_chunk51).2

theorem GephyrosisBreak3D_reach530 : autoFrom R31lit 3 init3D 530 = st3D_530 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (530 : ℕ) = 520 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach520]
  exact (chunk_read R31lit _ _ 520 10 chk3D GephyrosisBreak3D_chunk52).2

theorem GephyrosisBreak3D_reach540 : autoFrom R31lit 3 init3D 540 = st3D_540 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (540 : ℕ) = 530 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach530]
  exact (chunk_read R31lit _ _ 530 10 chk3D GephyrosisBreak3D_chunk53).2

theorem GephyrosisBreak3D_reach550 : autoFrom R31lit 3 init3D 550 = st3D_550 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (550 : ℕ) = 540 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach540]
  exact (chunk_read R31lit _ _ 540 10 chk3D GephyrosisBreak3D_chunk54).2

theorem GephyrosisBreak3D_reach560 : autoFrom R31lit 3 init3D 560 = st3D_560 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (560 : ℕ) = 550 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach550]
  exact (chunk_read R31lit _ _ 550 10 chk3D GephyrosisBreak3D_chunk55).2

theorem GephyrosisBreak3D_reach570 : autoFrom R31lit 3 init3D 570 = st3D_570 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (570 : ℕ) = 560 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach560]
  exact (chunk_read R31lit _ _ 560 10 chk3D GephyrosisBreak3D_chunk56).2

theorem GephyrosisBreak3D_reach580 : autoFrom R31lit 3 init3D 580 = st3D_580 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (580 : ℕ) = 570 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach570]
  exact (chunk_read R31lit _ _ 570 10 chk3D GephyrosisBreak3D_chunk57).2

theorem GephyrosisBreak3D_reach590 : autoFrom R31lit 3 init3D 590 = st3D_590 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (590 : ℕ) = 580 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach580]
  exact (chunk_read R31lit _ _ 580 10 chk3D GephyrosisBreak3D_chunk58).2

theorem GephyrosisBreak3D_reach600 : autoFrom R31lit 3 init3D 600 = st3D_600 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (600 : ℕ) = 590 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach590]
  exact (chunk_read R31lit _ _ 590 10 chk3D GephyrosisBreak3D_chunk59).2

theorem GephyrosisBreak3D_reach610 : autoFrom R31lit 3 init3D 610 = st3D_610 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (610 : ℕ) = 600 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach600]
  exact (chunk_read R31lit _ _ 600 10 chk3D GephyrosisBreak3D_chunk60).2

theorem GephyrosisBreak3D_reach620 : autoFrom R31lit 3 init3D 620 = st3D_620 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (620 : ℕ) = 610 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach610]
  exact (chunk_read R31lit _ _ 610 10 chk3D GephyrosisBreak3D_chunk61).2

theorem GephyrosisBreak3D_reach630 : autoFrom R31lit 3 init3D 630 = st3D_630 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (630 : ℕ) = 620 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach620]
  exact (chunk_read R31lit _ _ 620 10 chk3D GephyrosisBreak3D_chunk62).2

theorem GephyrosisBreak3D_reach640 : autoFrom R31lit 3 init3D 640 = st3D_640 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (640 : ℕ) = 630 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach630]
  exact (chunk_read R31lit _ _ 630 10 chk3D GephyrosisBreak3D_chunk63).2

theorem GephyrosisBreak3D_reach650 : autoFrom R31lit 3 init3D 650 = st3D_650 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (650 : ℕ) = 640 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach640]
  exact (chunk_read R31lit _ _ 640 10 chk3D GephyrosisBreak3D_chunk64).2

theorem GephyrosisBreak3D_reach660 : autoFrom R31lit 3 init3D 660 = st3D_660 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (660 : ℕ) = 650 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach650]
  exact (chunk_read R31lit _ _ 650 10 chk3D GephyrosisBreak3D_chunk65).2

theorem GephyrosisBreak3D_reach670 : autoFrom R31lit 3 init3D 670 = st3D_670 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (670 : ℕ) = 660 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach660]
  exact (chunk_read R31lit _ _ 660 10 chk3D GephyrosisBreak3D_chunk66).2

theorem GephyrosisBreak3D_reach680 : autoFrom R31lit 3 init3D 680 = st3D_680 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (680 : ℕ) = 670 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach670]
  exact (chunk_read R31lit _ _ 670 10 chk3D GephyrosisBreak3D_chunk67).2

theorem GephyrosisBreak3D_reach690 : autoFrom R31lit 3 init3D 690 = st3D_690 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (690 : ℕ) = 680 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach680]
  exact (chunk_read R31lit _ _ 680 10 chk3D GephyrosisBreak3D_chunk68).2

theorem GephyrosisBreak3D_reach700 : autoFrom R31lit 3 init3D 700 = st3D_700 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (700 : ℕ) = 690 + 10 from rfl, autoFrom_add, GephyrosisBreak3D_reach690]
  exact (chunk_read R31lit _ _ 690 10 chk3D GephyrosisBreak3D_chunk69).2

theorem GephyrosisBreak3D_reach705 : autoFrom R31lit 3 init3D 705 = st3D_705 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [show (705 : ℕ) = 700 + 5 from rfl, autoFrom_add, GephyrosisBreak3D_reach700]
  exact (chunk_read R31lit _ _ 700 5 chk3D GephyrosisBreak3D_chunk70).2

theorem GephyrosisBreak3D_seg (s0 N : ℕ) (stq stN : List ℤ × List ℕ) (hreach : autoFrom R31lit 3 init3D s0 = stq)
    (hc : chunkCert R31lit 3 stq stN s0 N chk3D = true) :
    ∀ i ≤ N, chk3D (s0 + i) (autoFrom R31lit 3 init3D (s0 + i)) = true := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  intro i hi
  rw [autoFrom_add, hreach]
  exact (chunk_read R31lit _ _ s0 N chk3D hc).1 i hi

theorem GephyrosisBreak3D_all (s : ℕ) (hs : s ≤ 705) : chk3D s (autoOrbit R31lit 3 seed5_3D s) = true := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  rw [autoOrbit_eq_from]
  show chk3D s (autoFrom R31lit 3 init3D s) = true
  by_cases h0 : s ≤ 10
  · simpa using GephyrosisBreak3D_seg 0 10 init3D st3D_10 rfl GephyrosisBreak3D_chunk0 s h0
  by_cases h1 : s ≤ 20
  · have := GephyrosisBreak3D_seg 10 10 _ _ GephyrosisBreak3D_reach10 GephyrosisBreak3D_chunk1 (s - 10) (by omega)
    rwa [show 10 + (s - 10) = s by omega] at this
  by_cases h2 : s ≤ 30
  · have := GephyrosisBreak3D_seg 20 10 _ _ GephyrosisBreak3D_reach20 GephyrosisBreak3D_chunk2 (s - 20) (by omega)
    rwa [show 20 + (s - 20) = s by omega] at this
  by_cases h3 : s ≤ 40
  · have := GephyrosisBreak3D_seg 30 10 _ _ GephyrosisBreak3D_reach30 GephyrosisBreak3D_chunk3 (s - 30) (by omega)
    rwa [show 30 + (s - 30) = s by omega] at this
  by_cases h4 : s ≤ 50
  · have := GephyrosisBreak3D_seg 40 10 _ _ GephyrosisBreak3D_reach40 GephyrosisBreak3D_chunk4 (s - 40) (by omega)
    rwa [show 40 + (s - 40) = s by omega] at this
  by_cases h5 : s ≤ 60
  · have := GephyrosisBreak3D_seg 50 10 _ _ GephyrosisBreak3D_reach50 GephyrosisBreak3D_chunk5 (s - 50) (by omega)
    rwa [show 50 + (s - 50) = s by omega] at this
  by_cases h6 : s ≤ 70
  · have := GephyrosisBreak3D_seg 60 10 _ _ GephyrosisBreak3D_reach60 GephyrosisBreak3D_chunk6 (s - 60) (by omega)
    rwa [show 60 + (s - 60) = s by omega] at this
  by_cases h7 : s ≤ 80
  · have := GephyrosisBreak3D_seg 70 10 _ _ GephyrosisBreak3D_reach70 GephyrosisBreak3D_chunk7 (s - 70) (by omega)
    rwa [show 70 + (s - 70) = s by omega] at this
  by_cases h8 : s ≤ 90
  · have := GephyrosisBreak3D_seg 80 10 _ _ GephyrosisBreak3D_reach80 GephyrosisBreak3D_chunk8 (s - 80) (by omega)
    rwa [show 80 + (s - 80) = s by omega] at this
  by_cases h9 : s ≤ 100
  · have := GephyrosisBreak3D_seg 90 10 _ _ GephyrosisBreak3D_reach90 GephyrosisBreak3D_chunk9 (s - 90) (by omega)
    rwa [show 90 + (s - 90) = s by omega] at this
  by_cases h10 : s ≤ 110
  · have := GephyrosisBreak3D_seg 100 10 _ _ GephyrosisBreak3D_reach100 GephyrosisBreak3D_chunk10 (s - 100) (by omega)
    rwa [show 100 + (s - 100) = s by omega] at this
  by_cases h11 : s ≤ 120
  · have := GephyrosisBreak3D_seg 110 10 _ _ GephyrosisBreak3D_reach110 GephyrosisBreak3D_chunk11 (s - 110) (by omega)
    rwa [show 110 + (s - 110) = s by omega] at this
  by_cases h12 : s ≤ 130
  · have := GephyrosisBreak3D_seg 120 10 _ _ GephyrosisBreak3D_reach120 GephyrosisBreak3D_chunk12 (s - 120) (by omega)
    rwa [show 120 + (s - 120) = s by omega] at this
  by_cases h13 : s ≤ 140
  · have := GephyrosisBreak3D_seg 130 10 _ _ GephyrosisBreak3D_reach130 GephyrosisBreak3D_chunk13 (s - 130) (by omega)
    rwa [show 130 + (s - 130) = s by omega] at this
  by_cases h14 : s ≤ 150
  · have := GephyrosisBreak3D_seg 140 10 _ _ GephyrosisBreak3D_reach140 GephyrosisBreak3D_chunk14 (s - 140) (by omega)
    rwa [show 140 + (s - 140) = s by omega] at this
  by_cases h15 : s ≤ 160
  · have := GephyrosisBreak3D_seg 150 10 _ _ GephyrosisBreak3D_reach150 GephyrosisBreak3D_chunk15 (s - 150) (by omega)
    rwa [show 150 + (s - 150) = s by omega] at this
  by_cases h16 : s ≤ 170
  · have := GephyrosisBreak3D_seg 160 10 _ _ GephyrosisBreak3D_reach160 GephyrosisBreak3D_chunk16 (s - 160) (by omega)
    rwa [show 160 + (s - 160) = s by omega] at this
  by_cases h17 : s ≤ 180
  · have := GephyrosisBreak3D_seg 170 10 _ _ GephyrosisBreak3D_reach170 GephyrosisBreak3D_chunk17 (s - 170) (by omega)
    rwa [show 170 + (s - 170) = s by omega] at this
  by_cases h18 : s ≤ 190
  · have := GephyrosisBreak3D_seg 180 10 _ _ GephyrosisBreak3D_reach180 GephyrosisBreak3D_chunk18 (s - 180) (by omega)
    rwa [show 180 + (s - 180) = s by omega] at this
  by_cases h19 : s ≤ 200
  · have := GephyrosisBreak3D_seg 190 10 _ _ GephyrosisBreak3D_reach190 GephyrosisBreak3D_chunk19 (s - 190) (by omega)
    rwa [show 190 + (s - 190) = s by omega] at this
  by_cases h20 : s ≤ 210
  · have := GephyrosisBreak3D_seg 200 10 _ _ GephyrosisBreak3D_reach200 GephyrosisBreak3D_chunk20 (s - 200) (by omega)
    rwa [show 200 + (s - 200) = s by omega] at this
  by_cases h21 : s ≤ 220
  · have := GephyrosisBreak3D_seg 210 10 _ _ GephyrosisBreak3D_reach210 GephyrosisBreak3D_chunk21 (s - 210) (by omega)
    rwa [show 210 + (s - 210) = s by omega] at this
  by_cases h22 : s ≤ 230
  · have := GephyrosisBreak3D_seg 220 10 _ _ GephyrosisBreak3D_reach220 GephyrosisBreak3D_chunk22 (s - 220) (by omega)
    rwa [show 220 + (s - 220) = s by omega] at this
  by_cases h23 : s ≤ 240
  · have := GephyrosisBreak3D_seg 230 10 _ _ GephyrosisBreak3D_reach230 GephyrosisBreak3D_chunk23 (s - 230) (by omega)
    rwa [show 230 + (s - 230) = s by omega] at this
  by_cases h24 : s ≤ 250
  · have := GephyrosisBreak3D_seg 240 10 _ _ GephyrosisBreak3D_reach240 GephyrosisBreak3D_chunk24 (s - 240) (by omega)
    rwa [show 240 + (s - 240) = s by omega] at this
  by_cases h25 : s ≤ 260
  · have := GephyrosisBreak3D_seg 250 10 _ _ GephyrosisBreak3D_reach250 GephyrosisBreak3D_chunk25 (s - 250) (by omega)
    rwa [show 250 + (s - 250) = s by omega] at this
  by_cases h26 : s ≤ 270
  · have := GephyrosisBreak3D_seg 260 10 _ _ GephyrosisBreak3D_reach260 GephyrosisBreak3D_chunk26 (s - 260) (by omega)
    rwa [show 260 + (s - 260) = s by omega] at this
  by_cases h27 : s ≤ 280
  · have := GephyrosisBreak3D_seg 270 10 _ _ GephyrosisBreak3D_reach270 GephyrosisBreak3D_chunk27 (s - 270) (by omega)
    rwa [show 270 + (s - 270) = s by omega] at this
  by_cases h28 : s ≤ 290
  · have := GephyrosisBreak3D_seg 280 10 _ _ GephyrosisBreak3D_reach280 GephyrosisBreak3D_chunk28 (s - 280) (by omega)
    rwa [show 280 + (s - 280) = s by omega] at this
  by_cases h29 : s ≤ 300
  · have := GephyrosisBreak3D_seg 290 10 _ _ GephyrosisBreak3D_reach290 GephyrosisBreak3D_chunk29 (s - 290) (by omega)
    rwa [show 290 + (s - 290) = s by omega] at this
  by_cases h30 : s ≤ 310
  · have := GephyrosisBreak3D_seg 300 10 _ _ GephyrosisBreak3D_reach300 GephyrosisBreak3D_chunk30 (s - 300) (by omega)
    rwa [show 300 + (s - 300) = s by omega] at this
  by_cases h31 : s ≤ 320
  · have := GephyrosisBreak3D_seg 310 10 _ _ GephyrosisBreak3D_reach310 GephyrosisBreak3D_chunk31 (s - 310) (by omega)
    rwa [show 310 + (s - 310) = s by omega] at this
  by_cases h32 : s ≤ 330
  · have := GephyrosisBreak3D_seg 320 10 _ _ GephyrosisBreak3D_reach320 GephyrosisBreak3D_chunk32 (s - 320) (by omega)
    rwa [show 320 + (s - 320) = s by omega] at this
  by_cases h33 : s ≤ 340
  · have := GephyrosisBreak3D_seg 330 10 _ _ GephyrosisBreak3D_reach330 GephyrosisBreak3D_chunk33 (s - 330) (by omega)
    rwa [show 330 + (s - 330) = s by omega] at this
  by_cases h34 : s ≤ 350
  · have := GephyrosisBreak3D_seg 340 10 _ _ GephyrosisBreak3D_reach340 GephyrosisBreak3D_chunk34 (s - 340) (by omega)
    rwa [show 340 + (s - 340) = s by omega] at this
  by_cases h35 : s ≤ 360
  · have := GephyrosisBreak3D_seg 350 10 _ _ GephyrosisBreak3D_reach350 GephyrosisBreak3D_chunk35 (s - 350) (by omega)
    rwa [show 350 + (s - 350) = s by omega] at this
  by_cases h36 : s ≤ 370
  · have := GephyrosisBreak3D_seg 360 10 _ _ GephyrosisBreak3D_reach360 GephyrosisBreak3D_chunk36 (s - 360) (by omega)
    rwa [show 360 + (s - 360) = s by omega] at this
  by_cases h37 : s ≤ 380
  · have := GephyrosisBreak3D_seg 370 10 _ _ GephyrosisBreak3D_reach370 GephyrosisBreak3D_chunk37 (s - 370) (by omega)
    rwa [show 370 + (s - 370) = s by omega] at this
  by_cases h38 : s ≤ 390
  · have := GephyrosisBreak3D_seg 380 10 _ _ GephyrosisBreak3D_reach380 GephyrosisBreak3D_chunk38 (s - 380) (by omega)
    rwa [show 380 + (s - 380) = s by omega] at this
  by_cases h39 : s ≤ 400
  · have := GephyrosisBreak3D_seg 390 10 _ _ GephyrosisBreak3D_reach390 GephyrosisBreak3D_chunk39 (s - 390) (by omega)
    rwa [show 390 + (s - 390) = s by omega] at this
  by_cases h40 : s ≤ 410
  · have := GephyrosisBreak3D_seg 400 10 _ _ GephyrosisBreak3D_reach400 GephyrosisBreak3D_chunk40 (s - 400) (by omega)
    rwa [show 400 + (s - 400) = s by omega] at this
  by_cases h41 : s ≤ 420
  · have := GephyrosisBreak3D_seg 410 10 _ _ GephyrosisBreak3D_reach410 GephyrosisBreak3D_chunk41 (s - 410) (by omega)
    rwa [show 410 + (s - 410) = s by omega] at this
  by_cases h42 : s ≤ 430
  · have := GephyrosisBreak3D_seg 420 10 _ _ GephyrosisBreak3D_reach420 GephyrosisBreak3D_chunk42 (s - 420) (by omega)
    rwa [show 420 + (s - 420) = s by omega] at this
  by_cases h43 : s ≤ 440
  · have := GephyrosisBreak3D_seg 430 10 _ _ GephyrosisBreak3D_reach430 GephyrosisBreak3D_chunk43 (s - 430) (by omega)
    rwa [show 430 + (s - 430) = s by omega] at this
  by_cases h44 : s ≤ 450
  · have := GephyrosisBreak3D_seg 440 10 _ _ GephyrosisBreak3D_reach440 GephyrosisBreak3D_chunk44 (s - 440) (by omega)
    rwa [show 440 + (s - 440) = s by omega] at this
  by_cases h45 : s ≤ 460
  · have := GephyrosisBreak3D_seg 450 10 _ _ GephyrosisBreak3D_reach450 GephyrosisBreak3D_chunk45 (s - 450) (by omega)
    rwa [show 450 + (s - 450) = s by omega] at this
  by_cases h46 : s ≤ 470
  · have := GephyrosisBreak3D_seg 460 10 _ _ GephyrosisBreak3D_reach460 GephyrosisBreak3D_chunk46 (s - 460) (by omega)
    rwa [show 460 + (s - 460) = s by omega] at this
  by_cases h47 : s ≤ 480
  · have := GephyrosisBreak3D_seg 470 10 _ _ GephyrosisBreak3D_reach470 GephyrosisBreak3D_chunk47 (s - 470) (by omega)
    rwa [show 470 + (s - 470) = s by omega] at this
  by_cases h48 : s ≤ 490
  · have := GephyrosisBreak3D_seg 480 10 _ _ GephyrosisBreak3D_reach480 GephyrosisBreak3D_chunk48 (s - 480) (by omega)
    rwa [show 480 + (s - 480) = s by omega] at this
  by_cases h49 : s ≤ 500
  · have := GephyrosisBreak3D_seg 490 10 _ _ GephyrosisBreak3D_reach490 GephyrosisBreak3D_chunk49 (s - 490) (by omega)
    rwa [show 490 + (s - 490) = s by omega] at this
  by_cases h50 : s ≤ 510
  · have := GephyrosisBreak3D_seg 500 10 _ _ GephyrosisBreak3D_reach500 GephyrosisBreak3D_chunk50 (s - 500) (by omega)
    rwa [show 500 + (s - 500) = s by omega] at this
  by_cases h51 : s ≤ 520
  · have := GephyrosisBreak3D_seg 510 10 _ _ GephyrosisBreak3D_reach510 GephyrosisBreak3D_chunk51 (s - 510) (by omega)
    rwa [show 510 + (s - 510) = s by omega] at this
  by_cases h52 : s ≤ 530
  · have := GephyrosisBreak3D_seg 520 10 _ _ GephyrosisBreak3D_reach520 GephyrosisBreak3D_chunk52 (s - 520) (by omega)
    rwa [show 520 + (s - 520) = s by omega] at this
  by_cases h53 : s ≤ 540
  · have := GephyrosisBreak3D_seg 530 10 _ _ GephyrosisBreak3D_reach530 GephyrosisBreak3D_chunk53 (s - 530) (by omega)
    rwa [show 530 + (s - 530) = s by omega] at this
  by_cases h54 : s ≤ 550
  · have := GephyrosisBreak3D_seg 540 10 _ _ GephyrosisBreak3D_reach540 GephyrosisBreak3D_chunk54 (s - 540) (by omega)
    rwa [show 540 + (s - 540) = s by omega] at this
  by_cases h55 : s ≤ 560
  · have := GephyrosisBreak3D_seg 550 10 _ _ GephyrosisBreak3D_reach550 GephyrosisBreak3D_chunk55 (s - 550) (by omega)
    rwa [show 550 + (s - 550) = s by omega] at this
  by_cases h56 : s ≤ 570
  · have := GephyrosisBreak3D_seg 560 10 _ _ GephyrosisBreak3D_reach560 GephyrosisBreak3D_chunk56 (s - 560) (by omega)
    rwa [show 560 + (s - 560) = s by omega] at this
  by_cases h57 : s ≤ 580
  · have := GephyrosisBreak3D_seg 570 10 _ _ GephyrosisBreak3D_reach570 GephyrosisBreak3D_chunk57 (s - 570) (by omega)
    rwa [show 570 + (s - 570) = s by omega] at this
  by_cases h58 : s ≤ 590
  · have := GephyrosisBreak3D_seg 580 10 _ _ GephyrosisBreak3D_reach580 GephyrosisBreak3D_chunk58 (s - 580) (by omega)
    rwa [show 580 + (s - 580) = s by omega] at this
  by_cases h59 : s ≤ 600
  · have := GephyrosisBreak3D_seg 590 10 _ _ GephyrosisBreak3D_reach590 GephyrosisBreak3D_chunk59 (s - 590) (by omega)
    rwa [show 590 + (s - 590) = s by omega] at this
  by_cases h60 : s ≤ 610
  · have := GephyrosisBreak3D_seg 600 10 _ _ GephyrosisBreak3D_reach600 GephyrosisBreak3D_chunk60 (s - 600) (by omega)
    rwa [show 600 + (s - 600) = s by omega] at this
  by_cases h61 : s ≤ 620
  · have := GephyrosisBreak3D_seg 610 10 _ _ GephyrosisBreak3D_reach610 GephyrosisBreak3D_chunk61 (s - 610) (by omega)
    rwa [show 610 + (s - 610) = s by omega] at this
  by_cases h62 : s ≤ 630
  · have := GephyrosisBreak3D_seg 620 10 _ _ GephyrosisBreak3D_reach620 GephyrosisBreak3D_chunk62 (s - 620) (by omega)
    rwa [show 620 + (s - 620) = s by omega] at this
  by_cases h63 : s ≤ 640
  · have := GephyrosisBreak3D_seg 630 10 _ _ GephyrosisBreak3D_reach630 GephyrosisBreak3D_chunk63 (s - 630) (by omega)
    rwa [show 630 + (s - 630) = s by omega] at this
  by_cases h64 : s ≤ 650
  · have := GephyrosisBreak3D_seg 640 10 _ _ GephyrosisBreak3D_reach640 GephyrosisBreak3D_chunk64 (s - 640) (by omega)
    rwa [show 640 + (s - 640) = s by omega] at this
  by_cases h65 : s ≤ 660
  · have := GephyrosisBreak3D_seg 650 10 _ _ GephyrosisBreak3D_reach650 GephyrosisBreak3D_chunk65 (s - 650) (by omega)
    rwa [show 650 + (s - 650) = s by omega] at this
  by_cases h66 : s ≤ 670
  · have := GephyrosisBreak3D_seg 660 10 _ _ GephyrosisBreak3D_reach660 GephyrosisBreak3D_chunk66 (s - 660) (by omega)
    rwa [show 660 + (s - 660) = s by omega] at this
  by_cases h67 : s ≤ 680
  · have := GephyrosisBreak3D_seg 670 10 _ _ GephyrosisBreak3D_reach670 GephyrosisBreak3D_chunk67 (s - 670) (by omega)
    rwa [show 670 + (s - 670) = s by omega] at this
  by_cases h68 : s ≤ 690
  · have := GephyrosisBreak3D_seg 680 10 _ _ GephyrosisBreak3D_reach680 GephyrosisBreak3D_chunk68 (s - 680) (by omega)
    rwa [show 680 + (s - 680) = s by omega] at this
  by_cases h69 : s ≤ 700
  · have := GephyrosisBreak3D_seg 690 10 _ _ GephyrosisBreak3D_reach690 GephyrosisBreak3D_chunk69 (s - 690) (by omega)
    rwa [show 690 + (s - 690) = s by omega] at this
  · have := GephyrosisBreak3D_seg 700 5 _ _ GephyrosisBreak3D_reach700 GephyrosisBreak3D_chunk70 (s - 700) (by omega)
    rwa [show 700 + (s - 700) = s by omega] at this

theorem cert3D_read (s : ℕ) (h1 : 1 ≤ s) (h705 : s ≤ 705) :
    topOf R31lit 3 seed5_3D s = (jacobsthal s : ℤ) ∧
      (s < 705 → TopLive R31lit 3 seed5_3D s) ∧ (s = 705 → ¬ TopLive R31lit 3 seed5_3D s) := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  have hc := GephyrosisBreak3D_all s h705
  unfold chk3D at hc
  simp only [Bool.or_eq_true, decide_eq_true_eq, Bool.and_eq_true] at hc
  rcases hc with h | ⟨ht, hl⟩
  · omega
  · refine ⟨by unfold topOf; rw [ht, jacF_eq], ?_, ?_⟩
    · intro hlt
      rw [if_pos hlt] at hl
      exact topLive_of_check _ _ _ hl
    · intro heq
      rw [if_neg (by omega)] at hl
      exact topDead_of_check _ _ _ (of_decide_eq_true hl)

/-- **THE JACOBSTHAL LAW OF SEED 5 IN 3D TO STEP 704.** -/
theorem seed5_3D_three_law_to_704 (s : ℕ) (hs : 1 ≤ s) (h704 : s ≤ 704) :
    (∀ k < 52, (rorbit31 5 s).getD k 0 ≠ 0 →
        -padicValRat 3 ((rorbit31 5 s).getD k 0) ≤ (jacobsthal s : ℤ)) ∧
    (∃ k < 52, (rorbit31 5 s).getD k 0 ≠ 0 ∧
        -padicValRat 3 ((rorbit31 5 s).getD k 0) = (jacobsthal s : ℤ)) := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  obtain ⟨htop, hlive, -⟩ := cert3D_read s hs (by omega)
  have h := law_of_top R31lit R31lit_D_ne seed5_3D s (hlive (by omega))
  rw [htop, show seed5_3D = seedData 5 52 from rfl, ratOrbit_K31lit, ratOrbit_eq_rorbit31, R31lit_n] at h
  exact h

/-- **THE BREAK AT 705 (`BREAKS-AT-STEP 705`).** At step 705 every nonzero coordinate of seed 5's
exact 3D orbit has 3-adic pole order STRICTLY BELOW the Jacobsthal number `J_{705}`. -/
theorem seed5_3D_breaks_at_705 :
    ∀ k < 52, (rorbit31 5 705).getD k 0 ≠ 0 →
      -padicValRat 3 ((rorbit31 5 705).getD k 0) ≤ (jacobsthal 705 : ℤ) - 1 := by
  have : Fact (Nat.Prime 3) := ⟨by norm_num⟩
  obtain ⟨htop, -, hdead⟩ := cert3D_read 705 (by norm_num) le_rfl
  have h := break_of_dead R31lit R31lit_D_ne seed5_3D 705 (hdead rfl)
  rw [htop, show seed5_3D = seedData 5 52 from rfl, ratOrbit_K31lit, ratOrbit_eq_rorbit31, R31lit_n] at h
  exact h


end Gephyrosis
