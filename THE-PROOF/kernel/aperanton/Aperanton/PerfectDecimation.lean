/-
  APERANTON -- THE BOUNDLESS, THE PERFECT DECIMATION (the ledger §73(f), 2026-10-29 02:4x): THE COVER IN THE KERNEL. A set L₁ of
  links of ℤ⁴ that is INDEPENDENT (no two of its links lie in one plaquette) and meets EVERY plaquette is the one decimation
  under which the fibre (the L₁ links given the rest) is an exact product measure -- each integrated link a von Mises--Fisher law
  of its six fixed staples -- so Hypothesis II of the chain holds exactly and the coarse specification on L₀ = L ∖ L₁ has range
  two with explicit Dobrushin entries (twelve direct neighbours at (4β/(3π))·m(5β), ninety mediated at β²/(3π) + β²|D(5β)|/2),
  its row sum crossing one near β = 0.244 (the instrument STDLIB/scripts/aperanton_decimation_rowsum.awk). This file holds the
  COMBINATORIAL FACT the chain stands on, decided in the bare kernel: the period-2 cover found by exact-cover search
  (STDLIB/scripts/aperanton_perfect_cover.pl, record STDLIB/build/aperanton/perfect_cover.2026-10-29a.txt, 17 search nodes) --
  one link per site of the 2⁴ torus, its direction d(s) read from the site's bits with the first coordinate as the pointer:
  direction 0 if x₂ = x₃ = x₄; else 1 if x₄ = x₁ and x₃ ≠ x₁; else 2 if x₂ = x₁ and x₄ ≠ x₁; else 3 -- meets each of the 96
  plaquettes of the torus in EXACTLY ONE link (`perfect_cover`), is independent (`cover_independent`, a corollary stated
  directly), has sixteen members (`cover_card`), and lifts to ℤ⁴ by periodicity since the plaquette condition is local
  (the lift is one line on the page: the plaquette condition is local and the cover periodic). Every theorem is `decide` over
  Fin 16 × Fin 4: no sorry, no axiom, no native_decide. W = 0 on the search; the fact that the cover exists, and what it buys
  (the exact fibre), is this tree's.
-/
import Mathlib

namespace Aperanton

/-- the i-th bit of a site of the 2⁴ torus (sites are Fin 16, bit i the coordinate x_{i+1}) -/
def bit (s : Fin 16) (i : Fin 4) : Fin 2 := ⟨(s.val / 2 ^ i.val) % 2, Nat.mod_lt _ (by decide)⟩

/-- the neighbour of s one step in direction i (the torus has period 2, so forward = backward) -/
def flip (s : Fin 16) (i : Fin 4) : Fin 16 := ⟨(s.val ^^^ (2 ^ i.val)) % 16, Nat.mod_lt _ (by decide)⟩

/-- THE COVER'S DIRECTION at a site: the rule read off the search's record -/
def coverDir (s : Fin 16) : Fin 4 :=
  let x1 := bit s 0; let x2 := bit s 1; let x3 := bit s 2; let x4 := bit s 3
  if x2 = x3 ∧ x3 = x4 then 0
  else if x4 = x1 ∧ x3 ≠ x1 then 1
  else if x2 = x1 ∧ x4 ≠ x1 then 2
  else 3

/-- membership in L₁: the link (s, k) is integrated iff k is the cover's direction at s -/
def inL1 (l : Fin 16 × Fin 4) : Bool := decide (coverDir l.1 = l.2)

/-- the four links of the (i, j)-plaquette at s: the two direction-i sides and the two direction-j sides -/
def plaqLinks (s : Fin 16) (i j : Fin 4) : List (Fin 16 × Fin 4) :=
  [(s, i), (flip s j, i), (s, j), (flip s i, j)]

/-- how many of a plaquette's links are integrated -/
def coverCount (s : Fin 16) (i j : Fin 4) : Nat := (plaqLinks s i j).countP inL1

/-- THE PERFECT COVER: every plaquette of the 2⁴ torus meets L₁ in exactly one link -/
theorem perfect_cover : ∀ s : Fin 16, ∀ i j : Fin 4, i < j → coverCount s i j = 1 := by decide

/-- L₁ IS INDEPENDENT: two integrated links of one plaquette are the same link -/
theorem cover_independent : ∀ s : Fin 16, ∀ i j : Fin 4, i < j →
    ∀ l₁ ∈ plaqLinks s i j, ∀ l₂ ∈ plaqLinks s i j, inL1 l₁ = true → inL1 l₂ = true → l₁ = l₂ := by decide

/-- ONE LINK PER SITE: L₁ has sixteen members on the sixteen sites, density one quarter of the sixty-four links -/
theorem cover_card : (Finset.univ.filter (fun l : Fin 16 × Fin 4 => inL1 l = true)).card = 16 := by decide

/-- every link of the torus lies in exactly six plaquettes (the incidence the row-sum count rests on) -/
def linkPlaqCount (l : Fin 16 × Fin 4) : Nat :=
  (Finset.univ.filter (fun t : Fin 16 × Fin 4 × Fin 4 => t.2.1 < t.2.2 ∧ l ∈ plaqLinks t.1 t.2.1 t.2.2)).card

theorem link_in_six : ∀ l : Fin 16 × Fin 4, linkPlaqCount l = 6 := by decide

end Aperanton
