
---

## 11. ADDENDA (2026-11-02, after review; nothing above edited)

**§3 ADDENDUM — Corollary 3.1′ (the exact-block form; the TIGHT form of the decomposition).** In Lemma 3.1's notation let
L²₀(π_X) = E_X ⊕ O_X with E_X the centred functions of X̃ and O_X = {f⊥ : E[f⊥ | X̃] = 0} (orthogonal in L²(π_X)), likewise for Y,
and T the conditional-expectation operator L²₀(π_X) → L²₀(π_Y). With ρ_EE = ‖T restricted E_X → E_Y‖ (= ρ̃), ρ_EO = ‖E_X → O_Y‖,
ρ_{O·} = ‖O_X → L²₀(π_Y)‖:
 ρ ≤ ( ρ_EE² + ρ_EO² + ρ_{O·}² )^{1/2},  and  ρ_{O·} ≤ τ_X,  ρ_EO ≤ τ_Y.
*Proof.* The three-term split of Lemma 3.1 with the block norms kept as norms: |Cov(f̃, g̃)| ≤ ρ_EE‖f̃‖‖g̃‖, |Cov(f̃, g⊥)| ≤
ρ_EO‖f̃‖‖g⊥‖, |Cov(f⊥, g)| ≤ ρ_{O·}‖f⊥‖‖g‖ by definition of the norms; then the same two Cauchy–Schwarz steps. The second line is
steps (2) and (3) of Lemma 3.1's proof. ∎ On the record's objects (§7) the right side meets ρ to 10⁻⁵ relative at two steps:
the decomposition loses nothing once the O-channel is read exactly. Lemma 3.2's τ is the FREE-ENERGY HANDLE on ρ_{O·} — it turns
the O-channel into the oscillation of the conditional vortex free energy — at the price of the ess sup over the orbit, measured at
exactly the leading mode's 2√2 (SU(2)) and 2 (U(1)) at two steps. In the reader: ρ_{O·} is ‖K_A^{1/2} G Φ_B^{1/2}‖, with K the
O-channel Gram of §6 and Φ = E + K.

**§7 ADDENDUM — LOOPS, NOT LINKS.** The objects' channel shares are read on the two coarse LOOP holonomies (A ↦ −A, the coarse
plaquettes of the two faces). Theorem 3.3's R̃ and T are stated on coarse LINK variables at coarse sites, as THE GROUND's (8.5)
is. The link → loop direction is proved (a loop holonomy is a function of the links; maximal correlation, like total variation,
contracts under functions and under mixtures of conditionings: campaign §14 RESULTS Part 1, §17 item 2); the loop → link direction
— (8.5)'s link coefficient controlled by the loop one after a maximal-tree gauge fixing — is the record's open loop–link lemma
(M2 §5.2 flagged the same relation). So "the SO(3) share is ≤ 0.87 % at two steps" is a reading of the LOOP pair's direct
coupling on the planar pinned object, not a reading of Theorem 3.3's R̃.

**§9 ADDENDUM — WHAT THE FINITE SHADOWS CERTIFY (the brief's question for Q₈, 2T, 2O, 2I).** Each of Q₈, 2T, 2O, 2I contains −1,
which is central, and Haar measure on a finite group is invariant under multiplication by it; so Theorem 2.1 (the twist identity,
with Haar integrals replaced by finite sums), Proposition 2.2, Lemma 3.1–3.2, Corollary 3.1′ and Theorem 3.3 hold VERBATIM for
the finite-group Wilson theories, with the SO(3) channel replaced by the polyhedral quotient G/{±1} (the Klein four-group V₄ for
Q₈, and T ≅ A₄, O ≅ S₄, I ≅ A₅ for the binary polyhedral groups). On finite cross-sections the kernel's transfer-matrix theorems
(MassGap.lean, Separation.lean: a gap on every finite cross-section at every β for every finite group) can therefore read BOTH
channels exactly, in exact arithmetic: the vortex half as the 't Hooft-surface ratio of the twisted to the untwisted transfer
matrix, the polyhedral half as the gap of the transfer matrix on G/{±1}-class functions — with no uniformity in the cross-section,
as the record already says of every shadow. And the design residue places where a shadow can stand in for SU(2) at all: the
shadow's fundamental character coefficient agrees with SU(2)'s through order β^{t−2} and parts at β^{t−1} (t the design strength,
Proposition 8.3 of THE GROUND), so any channel reading on a shadow (Theorem 8.1 is stated for SU(2) class functions and is not
claimed for the shadows) is SU(2)'s only to that order; a finite object certifies the two-channel split of a SHADOW at one
cross-section, never the infinite-volume window.
