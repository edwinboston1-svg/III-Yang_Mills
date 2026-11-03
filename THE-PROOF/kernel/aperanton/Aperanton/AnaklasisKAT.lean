import Mathlib

/-!
# ΑΝΑΚΛΑΣΙΣ — THE 4-TORUS KNOWN ANSWER, RE-DERIVED BY THE KERNEL

The engine `STDLIB/build/anaklasis/ising_torus.awk` reads the Ising measure on the `4 × 4` torus at `t = ½` (the integer bond
weight `2 + s s'`, i.e. `3` on an agreeing bond and `1` on a disagreeing one) by two roads sharing no line (brute force over `2^16`
configurations; the row transfer matrix) and agrees on `Z = 4804281924386816`, `Σ w·s₀₀s₁₁ = 4393991261388800`,
`Σ w·s₀₀s₂₂ = 4369138319360000`.  The kernel re-derives the three integers here by `decide` over every configuration, in the
NATURAL NUMBERS alone (a configuration's weight is `3^(number of agreeing bonds)`; a correlator is the difference of the weight sums
over the agreeing and the disagreeing site pairs, stated as `plus = minus + G`), the sums halved to a recursion depth of 17 — the
signed form in `ℤ` and the linear recursion both exceeded the kernel's limits (a deterministic timeout; a depth of 65536).
Nothing about the `6`-torus is proved here: that reading is the engine's, under its gate, with this file as its known answer.
-/

namespace Anaklasis

/-- the spin bit at site `(i, j)` of the configuration `c` (bit `i + 4j`), as `0` or `1` -/
def sbit (c : ℕ) (i j : ℕ) : ℕ := if c.testBit (i + 4 * j) then 1 else 0

/-- `1` when the two bits agree -/
def agree (a b : ℕ) : ℕ := if a = b then 1 else 0

/-- the number of agreeing bonds of the configuration (horizontal and vertical, every site) -/
def nagree (c : ℕ) : ℕ :=
  (List.range 4).foldl (fun acc j =>
    (List.range 4).foldl (fun acc' i =>
      acc' + agree (sbit c i j) (sbit c ((i + 1) % 4) j) + agree (sbit c i j) (sbit c i ((j + 1) % 4))) acc) 0

/-- the weight `3^nagree` -/
def wgt (c : ℕ) : ℕ := 3 ^ nagree c

/-- the summand for `(k, side)`: `k = 0` the bare weight; otherwise the weight where `s₀₀ = s_kk` (side `1`) or `s₀₀ ≠ s_kk` (side `0`) -/
def term (k side : ℕ) (c : ℕ) : ℕ :=
  if k = 0 then wgt c else (if agree (sbit c 0 0) (sbit c k k) = side then wgt c else 0)

/-- `Σ_{lo ≤ c < hi} term k side c` by halving under a fuel of structural recursion -/
def sumRange (k side : ℕ) : ℕ → ℕ → ℕ → ℕ
  | 0, lo, hi => if lo < hi then term k side lo else 0
  | f + 1, lo, hi =>
      if hi ≤ lo + 1 then (if lo < hi then term k side lo else 0)
      else sumRange k side f lo ((lo + hi) / 2) + sumRange k side f ((lo + hi) / 2) hi

set_option maxRecDepth 8192 in
set_option maxHeartbeats 0 in
theorem z4 : sumRange 0 0 17 0 65536 = 4804281924386816 := by decide +kernel

set_option maxRecDepth 8192 in
set_option maxHeartbeats 0 in
theorem g11_4 : sumRange 1 1 17 0 65536 = sumRange 1 0 17 0 65536 + 4393991261388800 := by decide +kernel

set_option maxRecDepth 8192 in
set_option maxHeartbeats 0 in
theorem g22_4 : sumRange 2 1 17 0 65536 = sumRange 2 0 17 0 65536 + 4369138319360000 := by decide +kernel

#print axioms z4
#print axioms g11_4
#print axioms g22_4

end Anaklasis
