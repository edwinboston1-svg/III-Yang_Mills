/-
  ΠΕΡΙΠΛΟΚΗ -- THE ENTWINING: THEOREM H, THE THIRD ORTHOGONALITY LAW, ITS FINITE PIECE FOR THE KERNEL
  (the Navier–Stokes road, beside ΑΡΡΗΚΤΟΝ and ΓΕΦΥΡΩΣΙΣ; not a Yang–Mills object).
  Page DOCS/III-PERIPLOKE-THE-ENTWINING-PREREGISTRATION.md (2cc4d684a) §5; canon T-815 (7b8997867).

  THE STATEMENT AT ITS STRENGTH.  PROVED at the desk: for every state c of the Fourier–Galerkin truncation of the
  Euler equations on a box closed under k ↦ −k, B_H(c, N(c)) = 0 for the helicity form B_H -- the truncated flow
  conserves helicity exactly -- hence the forward-Euler step obeys
      B_H(c(s), c(s+1) − c(s)) + h · B_H(c(s), κ c(s)) = 0   at every step,
      H(c(s+1)) − H(c(s)) = −2h · B_H(c(s), κ c(s)) + H(c(s+1) − c(s)).
  The proof (Kraichnan 1973; Waleffe 1992; W = 0 in its mathematics): in the helical basis the helicity form is
  DIAGONAL with weights s|k|, and the truncated nonlinearity reads triad by triad (k + p + q = 0, every member in the
  box, one coefficient g for the triad)
      ȧ_k = (s_p|p| − s_q|q|) g ā_p ā_q,   ȧ_p = (s_q|q| − s_k|k|) g ā_q ā_k,   ȧ_q = (s_k|k| − s_p|p|) g ā_k ā_p,
  so the triad's contribution to d/dt Σ_j w_j |a_j|² is 2 Re(g ā_k ā_p ā_q) times the cyclic sum
  Σ_cyc w_k (s_p|p| − s_q|q|), which vanishes identically for w ≡ 1 (energy) and for w_j = s_j|j| (helicity).
  Those two polynomial identities are THE FINITE PIECE, below: universal over ℤ by `ring`, and on a finite box of
  signed magnitudes by `decide` alone (the bare-kernel form).  Everything else in Theorem H is the quoted helical
  form of the truncated nonlinearity and bilinearity.

  NOT RUN: the print `Hres` beside `Zres` on the integer road (STDLIB/build/gephyrosis/dinop.iii) is a transcription
  of the road form H = V · Σ_m τ_m (a_{m1} b_{m2} − a_{m2} b_{m1}), τ_m = ε_{m1} · (K_m × ε_{m2}) ∈ ℤ; the engine's
  working copy was mid-write when this landed (a file mid-write is UNSTABLE, read twice or refused -- law 40), so the
  measurement on the exact orbit is the next stone, not this file's.
-/
import Mathlib

namespace Periploke

/-- The energy identity of a triad: the cyclic sum of Waleffe's coefficients vanishes, for all integers
    (`a, b, c` the signed magnitudes `s_k|k|, s_p|p|, s_q|q|`). -/
theorem triad_energy (a b c : ℤ) : (b - c) + (c - a) + (a - b) = 0 := by ring

/-- The helicity identity of a triad: weighted by the signed magnitudes themselves, the cyclic sum vanishes. -/
theorem triad_helicity (a b c : ℤ) : a * (b - c) + b * (c - a) + c * (a - b) = 0 := by ring

/-- The six-integer form as the page states it: signs `s_k, s_p, s_q` and magnitudes `|k|, |p|, |q|`. -/
theorem triad_helicity_signed (sk sp sq : ℤ) (k p q : ℕ) :
    sk * k * (sp * p - sq * q) + sp * p * (sq * q - sk * k) + sq * q * (sk * k - sp * p) = 0 := by ring

/-- The signs really are signs: with `s² = 1` the weights `s|k|` are the signed magnitudes; the identity does
    not need it, and the hypothesis is carried only to say so. -/
theorem triad_helicity_pm (sk sp sq : ℤ) (hk : sk * sk = 1) (hp : sp * sp = 1) (hq : sq * sq = 1)
    (k p q : ℕ) :
    sk * k * (sp * p - sq * q) + sp * p * (sq * q - sk * k) + sq * q * (sk * k - sp * p) = 0 := by
  have _ := hk; have _ := hp; have _ := hq
  ring

/-- THE BARE-KERNEL FORM: the helicity identity decided by the kernel on the finite box of signed magnitudes
    `[−4, 4]³` (729 triads), `decide` the only proof term. -/
theorem triad_helicity_box :
    ∀ i j l : Fin 9,
      ((i : ℤ) - 4) * (((j : ℤ) - 4) - ((l : ℤ) - 4))
        + ((j : ℤ) - 4) * (((l : ℤ) - 4) - ((i : ℤ) - 4))
        + ((l : ℤ) - 4) * (((i : ℤ) - 4) - ((j : ℤ) - 4)) = 0 := by decide

/-- The energy identity on the same box, by the kernel. -/
theorem triad_energy_box :
    ∀ i j l : Fin 9,
      (((j : ℤ) - 4) - ((l : ℤ) - 4)) + (((l : ℤ) - 4) - ((i : ℤ) - 4)) + (((i : ℤ) - 4) - ((j : ℤ) - 4)) = 0 := by
  decide

end Periploke

#print axioms Periploke.triad_energy
#print axioms Periploke.triad_helicity
#print axioms Periploke.triad_helicity_signed
#print axioms Periploke.triad_helicity_pm
#print axioms Periploke.triad_helicity_box
#print axioms Periploke.triad_energy_box
