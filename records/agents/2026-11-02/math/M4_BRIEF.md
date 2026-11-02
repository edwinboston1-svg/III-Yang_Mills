# M4 — THE WINDOW (brief, 2026-11-02)

Read first: `../math/MATH_BRIEF.md` (the goal, the chain, the record, how you work) — in full.

## The object

A rigorous mass gap for the SU(2) Wilson lattice gauge theory on ℤ⁴ (infinite volume) at the crossover couplings
β ∈ [0.4764, β_UV] — the window where neither the strong-coupling expansion (proved to 0.2452 unconditionally, to 0.4764 under
S12's remainder, which another agent is proving) nor Bałaban's small-field analysis (coupling below an uncomputed γ) converges —
with constants controlled well enough to feed Theorem 8.5 (or its L² form) at a fixed physical scale uniformly in the cutoff.
This is the open core of the problem. Derive it; where a step does not yet hold, derive the exact lemma that would make it hold
and attack that lemma.

## What the record gives you to stand on (read the sources before relying on them)

- The exit lemma (III-Yang_Mills commit 8bcfffd; OPEN/the-crossing-campaign.md): if the Kotecký–Preiss certificate of Theorem
  8.9 passes at a blocked action's own coefficients, Hypothesis I holds at that scale. The certificate engine (III tree,
  `STDLIB/build/aperanton/table_gate/` path of b3c0b51b3 — HEAD's `STDLIB/scripts/aperanton_kp_cert.awk` is stale) has a
  coefficient-supplied mode.
- Readings (NOT certificates) of two exact blocking steps from β = 2.2 at fixed outside data: the blocked one-plaquette
  coefficient a′_½ = 0.12163 (ordered datum) and 0.07594 (cancelling), against Wilson's a_½(0.4764) ≈ 0.118; the first step's
  coefficients made the certificate FAIL ("dressing iteration leaves [0, 3]: no root"); the half/wall factors at n = 4 never
  priced. The flow readings 2.2 → 1.888 → 1.553 → 1.161 → 0.662 → 0.109 (spins ≤ 2, ordered datum).
- M2 (`../math/M2/WORK.md`): the gap is exactly −log‖P‖ on L²₀(π); Theorem 8.5 holds in the L² currency (conditional maximal
  correlations, a fibre clause averaged over the blocked measure); two-step 20ρ at 2.2: W2L2 0.304/0.349, W3L2 0.630/0.772,
  U(1) at 1.2 2.40/2.96, gapped U(1) at 0.9 1.31/1.49 — readings; the two-step coupling carried by the centre-odd (½,½)
  channel, ρ/C → 3π/16. M2b is running on the hypercontractivity replacement of the coarse-environment supremum, on the W4
  convergence run and on the outside-mediated variance: do NOT duplicate those; use their results if they land.
- The hierarchical model: the certified Migdal–Kadanoff descent enters the Dobrushin disk at the eighth step from 2.2 and 2.3
  (THE GROUND revision 31, §8.3); MK confines U(1) too, so a transfer to ℤ⁴ must use the group; the groups part in the RATE
  (SU(2) ≈ 0.257 per step at weak coupling, the one-loop rate; U(1) exponentially slow).
- The Lean kernel (III-Yang_Mills `kernel/aperanton/Aperanton/*.lean`): for every finite gauge group on every finite
  cross-section, a mass gap and a positive static potential at every β; Z₂ Griffiths inequalities, string tension; the twist
  eater's law (TwistEater*.lean); the 't Hooft flux sectors of finite groups (StrongCoupling, Separation, Nonabelian). The
  BondMoving sandwich (free energy, not the gap).
- Classical inputs you may use with citation: Tomboulis–Yaffe (1985) — confinement ⟺ the 't Hooft electric-flux (vortex) free
  energy decays; Fröhlich–Israel–Lieb–Simon (1978) and Borgs–Seiler (1983) — chessboard estimates in lattice gauge theory;
  Osterwalder–Seiler (1978); Guth (1980) and Fröhlich–Spencer (1982) — the U(1) massless phase (the control your argument
  must fail on); Ito–Seiler (2007–08) on why Tomboulis's every-coupling argument would confine U(1).

## The routes, in the order this brief would try them (your judgement overrides it)

1. THE CENTRE. The group dependence the record demands is the centre: SU(2) has a discrete centre Z₂, U(1)'s centre is the
   whole group, so a bound that runs through Z₂ flux sectors (twisted boundary conditions, vortex free energies, the
   centre-odd channel M2 found carrying the two-step coupling) is group-dependent by construction and passes the U(1) test.
   State the strongest true statement linking the decay of the vortex free energy (or of the centre-odd channel's coupling)
   at one blocking scale to Hypothesis I (or I-L²) at that scale — the mass gap, not only the area law — prove it, and decide
   what part of it a finite, exactly computable object (a tube, a box with twisted boundary conditions, the kernel's finite
   groups 2T/2O/2I which track SU(2) to β ≈ 2.27/…/5.52 by the design residue) can certify.
2. THE CONE. Theorem 8.9's certificate restated over a cone of blocked actions (one-plaquette weights with their higher-spin
   coefficients and the small loops a blocking produces, every coefficient an interval), so that a blocked action with
   coefficients in the cone has the gap; then the exact statement a blocking step from β = 2.2 must satisfy to land in the cone.
3. CHESSBOARD PRICING of the frustrated data: the bad events of the blocked measure are compound (a single plaquette's
   z ≥ μ(tr U_p ≤ 0) ≈ 0.1 at 2.2); price compound events by reflection positivity and charge them to the certificate's margin.

## How you work

As in MATH_BRIEF.md: deep-think first, clear-thought sequential thinking while deriving, creative-solve where a step resists;
proofs on the page; every number that enters a proof exact or outward-rounded; a stake before each computation; under 2 GB and
60 minutes per computation (check free memory first; never kill a process you did not start); read-only in both repositories;
no messages to other sessions; never python from a bash heredoc. Work directory `../math/M4/` (WORK.md, code, records,
appending as you go). Final message as MATH_BRIEF.md specifies (at most 500 words).
