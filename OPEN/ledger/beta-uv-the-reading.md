> Posted by Edwin Boston III at 04:46 EDT on 29 October 2026 as written by the fourth seat. One provenance mark entered by its author afterwards: the sentence of §2 placing the smallness condition on the effective coupling at the coarsest scale is the seat's reading of the method from Dimock's abelian exposition, not a sentence of Bałaban's Theorem 1, which is unread; the verdict (a named unknown) does not depend on it. The two unread spans are named in §4; the papers are open access at Project Euclid behind a bot wall.

# β_UV — THE READING (the seat iii-3a, 2026-10-29 04:4x EDT, for iii-43's §8.3 and the plan seat's 05:00 item)

**Verdict: a NAMED UNKNOWN. No paper states a constant.** The coupling below which Bałaban's small-field analysis holds
is the g₀ of "Theorem 1" of *Large field renormalization I–II* (CMP 122, 1989), a threshold on the effective coupling
at the coarsest scale treated, defined by existence ("sufficiently small", with the block scale L "sufficiently
large") and never computed. In SU(2) Wilson normalisation β_UV = 4/g₀². The distance Σ2 must cross is
[0.2452, 4/g₀²] with the top end a symbol.

## 1. Where the four-dimensional claim lives (the coordinates; abstracts verbatim from INSPIRE / zbMATH)

- T. Bałaban, *Renormalization group approach to lattice gauge field theories. I. Generation of effective actions in a
  small field approximation and a coupling constant renormalization in four dimensions*, Commun. Math. Phys. 109
  (1987) 249–301, doi 10.1007/BF01215223, Zbl 0611.53080. The zbMATH review (verbatim): "The author studies
  four-dimensional pure gauge field theories by the renormalization group approach. The analysis is restricted to small
  field approximation. In this region he constructs a sequence of localized effective actions by cluster expansions in
  one step renormalization transformations. He also defines a coupling constant renormalization by a recursive system
  of renormalization group equations." — THE SMALL-FIELD EXPANSION AND THE COUPLING RECURSION ARE HERE.
- *…II. Cluster expansions*, CMP 116 (1988) 1–22, Zbl 0688.53045.
- *Convergent renormalization expansions for lattice gauge theories*, CMP 119 (1988) 243–285, doi 10.1007/BF01217741.
  Abstract (verbatim): "In this paper we introduce an inductive description of the complete effective densities
  including large field domains, and we show that the renormalization transformations preserve the form of the
  densities. This completes the renormalization group analysis for superrenormalizable models and yields convergent
  expansions in this case." — i.e. d = 3 is completed here; NOT a four-dimensional result.
- *Large field renormalization. I. The basic step of the ℝ operation*, CMP 122 (1989) 175–202, doi 10.1007/BF01257412.
  Abstract (verbatim): "We construct the renormalization operation of the expressions connected with the large field
  regions. This operation, denoted by ℝ, removes the main obstacle to prove the ultraviolet stability of
  four-dimensional gauge field theories. The proof will be completed in the second part of this paper."
- *Large field renormalization. II. Localization, exponentiation, and bounds for the ℝ operation*, CMP 122 (1989)
  355–392, doi 10.1007/BF01238433. Abstract (verbatim): "In this paper we conclude the discussion of the basic
  properties and bounds for the ℝ operation. This allows us to complete the proof of the ultraviolet stability of
  four-dimensional pure gauge field theories, as formulated in Theorem 1." — THE FOUR-DIMENSIONAL THEOREM IS "THEOREM 1"
  OF THIS PAIR; its hypotheses on g and L are the place a constant would sit.
- (3D, for contrast) *Ultraviolet stability of three-dimensional lattice pure gauge field theories*, CMP 102 (1985)
  255–275, doi 10.1007/BF01229380: "We prove the ultraviolet stability for three-dimensional lattice gauge field
  theories. We consider only the Wilson lattice approximation for pure Yang-Mills field theories."

## 2. What the condition is on, and why it is the road's β_UV

In the scheme (Bałaban's, and Dimock's exposition of it) the fine lattice of spacing L⁻ᴺ in a fixed finite volume is
scaled to a unit lattice; one renormalization step integrates the fields with fixed L-block averages; the effective
coupling g_k at scale k obeys the asymptotic-freedom recursion of CMP 109 (one loop at leading order, the coupling
GROWING towards coarse scales). The small-field expansion must converge at every scale k ≤ N, so the binding
constraint is at the coarsest scale treated: the effective coupling at the unit scale must be ≤ g₀, and the bare
coupling g(L⁻ᴺ) is chosen on the recursion's trajectory so that it is. Hence the condition "g sufficiently small" is a
condition on the unit-scale effective coupling, β_unit = 4/g_unit² ≥ 4/g₀² = β_UV. The theorem is ultraviolet
stability (bounds on the partition function / effective densities uniform in N) in a FINITE volume, with a
subsequential continuum limit by compactness; no infinite-volume limit, no gap (Chatterjee §6, below).

## 3. The form of the smallness condition in every open account (verbatim, with pages)

- Jaffe–Witten, *Quantum Yang–Mills theory* (the Clay problem description), p. 11: "Balaban studied this program in a
  three-dimensional lattice with periodic boundary conditions, approximating a space-time torus [2]. … These estimates
  are uniform in the lattice spacing, as the spacing tends to zero." and "While this work in three dimensions is
  important in its own right, a qualitative breakthrough came with Balaban's extension of this analysis to four
  dimensions [3]. This includes an analysis of asymptotic freedom to control the renormalization group flow as well
  as obtaining quantitative estimates on effects arising from large values of the gauge field." — no coupling
  threshold stated; [3] is CMP 109.
- Chatterjee, *Yang–Mills for probabilists* (arXiv 1803.01950), §6, p. 12: "Usually, convergence is hard to prove, so
  one settles for subsequential convergence by a compactness argument. The existence of a convergent subsequence is
  known as ultraviolet stability" and "Ultraviolet stability of three- and four-dimensional non-Abelian lattice gauge
  theories by phase cell renormalization, as outlined above, was famously established by Bałaban [1–14] in a long
  series of papers spanning six years." and (p. 12) "there is yet no construction of a continuum limit of a lattice
  gauge theory in any dimension higher than two where Wilson loop variables have been shown to have nontrivial
  behavior." — no constant.
- Dimock, *Stability for QED in d=3: an overview* (arXiv 2204.07201), p. 2, Theorem 1 (Ultraviolet Stability),
  verbatim: "Assume m̄ > 0 and e is sufficiently small. Then one can fix the gauge and choose counterterms m_N, ε_N so
  that for all N  K₋ ≤ Z_N(e)/Z_N(0) ≤ K₊  for some constants K±." and p. 2: "The method was introduced by Balaban
  [1]–[4] for scalar electrodynamics in d=3. It was further developed by Balaban, Imbrie, and Jaffe [14],[15],[24]
  for the abelian Higgs model in d=3 and by Balaban [5]–[13] for Yang Mills in d=3,4."
- Dimock, *Lectures on the ultraviolet problem for QED in d=3* (Roma Tre 2022, nsm.buffalo.edu/~dimock/Rome.final.pdf),
  Theorem 1: "Let L be sufficiently large, let M be sufficiently large (depending on L), …"; Theorem 2: "Let L be
  sufficiently large and e be sufficiently small. Then for each N …"; Theorem 3 (UV stability bound): "Let the coupling
  constant e be sufficiently small and choose counterterms as in theorem 2. Then for all N …". The author of the
  method's only complete modern exposition, in the (abelian, d = 3) case he carried out line by line, states every
  threshold as an existence. His gauge-theory papers are QED in d = 3 only (1512.04373, 1712.10029, 2009.01156,
  2204.07201); *The renormalization group according to Balaban I–III* (1108.1335, 1212.5562, 1304.0705) treat the
  scalar φ⁴₃ model. There is no Dimock exposition of the four-dimensional Yang–Mills papers, hence no constant from
  that side.

## 4. What this seat could not read tonight, and where the constant would be

Bałaban's own pages: Project Euclid (open access there) answers this seat's fetchers with a bot wall; Springer's copies
are paywalled; the browser extension is disconnected. So the verbatim text of Theorem 1 (CMP 122 I, pp. 175–202,
presumably its §1) and of CMP 109's small-field restrictions and recursion (pp. 249–301) is UNREAD here. Those two
spans are the pages that would give the constant if any does; every secondary account read says none does. Open in a
browser: projecteuclid.org/euclid.cmp/1104178393 (CMP 122 I), /euclid.cmp/1104116842 (CMP 109); part II's id is in
the volume-122 issue-3 listing.

A pointer, unread: V. F. Müller and J. Schiemann, *Continuum limit of a hierarchical SU(2) lattice gauge theory in 4
dimensions*, CMP (1987) 261–286 — the hierarchical analogue of the road's Migdal–Kadanoff descent; a hierarchical
model is where an explicit small-field domain is most likely to be written down.

## 5. For §8.3

β_UV is a named unknown: g₀ of Bałaban's Theorem 1 (Large field renormalization I–II, CMP 122, 1989), the threshold on
the coarsest-scale effective coupling keeping the small-field expansions of CMP 109/116 convergent, defined by
existence and never computed; β_UV = 4/g₀² in SU(2) Wilson normalisation. The absence of a number is a property of
the method as published (the same form in Dimock's completed abelian case), not of the four-dimensional papers alone.
