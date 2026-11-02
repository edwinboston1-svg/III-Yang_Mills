
---------------------------------------------------------------------------------------------------------------
## 4. THE UNIFICATION (where these pieces live elsewhere)

- **The gas's classification is the binary matroid of the plaquette boundaries.** Let M be the binary matroid on the plaquettes of ℤ⁴
  whose ground vectors are the Z₂ boundaries ∂p ∈ Z₂^{links}. Then: the LEAVES of the record (Z₂-minimal sets) are exactly the
  CIRCUITS of M; an even set is a cycle (a disjoint union of circuits, Lemma P (P3)); the leafless class Ω is exactly the set of CLOSED
  INDEPENDENT sets (independent in M, every link covered at least twice); the odd-rule tree T_odd is a circuit enumerator, and
  `omega_census.c` is an enumerator of closed independent sets (its prune is the matroid's independence oracle). In the frame's words
  (THE BOSTON CONJECTURE): the observer "∂ over Z₂" restricted to a support is BLIND exactly on its even subsets (its kernel), so the
  leaves are the minimal blind spots and Ω is the class on which that observer has NO blindness at all — the supports that carry no
  sheet. The census reads that a closed support with no blind spot needs at least 22 plaquettes in ℤ⁴: the lattice's systole for
  Z₂-acyclic 2-complexes without free edges (the cubical cousins of Bing's house, the dunce hat, the mod-3 Moore space).
- **Corollary Ω2 is Finner's form of Brascamp–Lieb on the cubical complex.** The exponents p_q = 6 are a FRACTIONAL COVER of the links by
  plaquettes (Σ_{q∋ℓ} 1/p_q ≤ 1), the hypergraph Hölder inequality behind Shearer's lemma and the Loomis–Whitney inequality. Its
  constant 3·15^{1/6}a₁ is the L⁶ norm of the spin-1 character, i.e. the number of SU(2)-invariants in 1^{⊗6} (the Riordan number 15,
  the same 15 as the six-fold link's invariant dimension R₆ in the realigned bound). A sharper fractional cover (p_q equal to the
  largest multiplicity on q, not 6) lowers the rate on sparse complexes: for even p, ‖χ₁‖_p^p = E[χ₁^p] = dim Inv(1^{⊗p}), so a complex
  whose links all have multiplicity ≤ 4 carries the rate 3·3^{1/4}a₁ = 3.95a₁ (Inv(1^{⊗4}) has dimension 3) in place of 4.71a₁.
- **§25 (c)'s realigned matrix is the REALIGNMENT map of quantum-information separability theory** (the Chen–Wu / Rudolph cross-norm
  criterion: for a bipartite operator, the realigned matrix's norms bound entanglement). The bound ‖M_t‖²_op ≤ λ_max(Tr_N P_t)·λ_max(Tr_S P_t)
  is the statement that a projector's realignment is controlled by the largest eigenvalues of its two reduced "density matrices"; a link
  projector whose invariant space is close to a product across the split has small realigned norm, and the dense k = 15, 16 stars are
  exactly the ones whose invariants are most entangled across every split.
- **Lemma G is the gluing law of a tensor network's bond rank, at Z₂ resolution.** A resolved chord on the gluing cycle chooses ONE of the
  three ways the two constituents' even halves can be paired, so at most one extra even union survives each resolution — the same
  "a contraction cannot create more than one new closed loop per resolved bond" that makes the Temperley–Lieb/binor calculus of M1's
  Lemma R a loop model at fugacity −2.
- **The neck is the domain-wall sector of the spin assignment.** A one-plaquette domain raised to 3/2 inside a ½ sheet, bounded by a
  piece's or four walls' attachment links, is a spin domain wall whose cost per unit area is a_{3/2}/u and whose boundary carries the
  mixed 3j insertions: the gas's analogue of a twisted-sector (orbifold) defect line, priced by its own vertex law — the mixed vertex law
  is the object.
