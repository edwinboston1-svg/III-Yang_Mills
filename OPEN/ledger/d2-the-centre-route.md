> Posted by Edwin Boston III at 04:46 EDT on 29 October 2026 as written by the fourth seat; every quotation is from the arXiv texts named. Read and checked here: the U(1) argument of §0 is the test of §8.3 of THE GROUND applied to the derivation of V.1, and it convicts; §5(iii) is the same wall as the paper's strong-end standing.

# D2 — THE CENTRE ROUTE AT THE PAGE LEVEL: Tomboulis 0707.2179, Ito–Seiler 0711.4930 and 0803.3019, Tomboulis's reply 0712.2620
(the seat iii-3a, 2026-10-29 05:0x EDT; every page read from the arXiv texts, quotes verbatim)

## 0. The U(1) reading, first

Tomboulis's derivation uses the gauge group in exactly two places: the positivity of the character coefficients
c_j ≥ 0 (true for U(1)), and the convergence of the upper-bound flow to strong coupling — his V.1's hypothesis
"Assume that there is an n₀ such that the upper bound coefficients c^U_j(n) become sufficiently small for n ≥ n₀"
(p. 27). At r = 1 that flow is the Migdal–Kadanoff recursion, and Ito's theorem (PRL 55 (1985) 558, quoted by
Ito–Seiler as Theorem 2.1: "For D ≤ 4 and for G = SU(N) or G = U(N), lim c_j(n) = 0 for j ≠ 0") makes the hypothesis
TRUE FOR U(1) AT EVERY β. The inequality (5.15) at strong coupling is, by Tomboulis's own footnote 10 (p. 27), EASIER
for abelian groups: "For Abelian systems, comparison inequalities of the type (5.15) either follow from Griffith's
inequalities, or can be approached by the same methods. All such known methods fail in the non-Abelian case." So
for four-dimensional U(1) every premise of V.1 holds at every β, and V.1's conclusion — (5.17) with its corollary
(5.22), the vortex free energy bounded by its strong-coupling value, i.e. the area law — is FALSE for β above β₀
(Guth 1980; Fröhlich–Spencer 1982; Ito–Seiler 0803.3019 Theorem 2.2(2), p. 6: for U(1) and β > β₀,
lim (1/L₃L₄) F ≥ const/(L₁L₂), deconfinement). Therefore the derivation of V.1 from its hypothesis fails for U(1),
and since no step of it mentions the group, it fails as a derivation: the gap is in the group-blind steps — the
matching of the two interpolations (5.9), (5.14) and the continuation argument of Appendix C. This is Ito–Seiler's
sentence on p. 12 of 0803.3019 ("there must be something missing since this proof seems to work even for G = U(1)"),
and it is decisive. What the inequality itself reads for U(1) at weak coupling (n = 0, large β): unknown and, by
Tomboulis's own words (reply, p. 5), "not a priori clear whether it holds at large β" — but it is never invoked there,
so its weak-coupling status is not what the test convicts.

## 1. The inequality at the centre, in Tomboulis's notation, with pages

Setting (0707.2179 §2–3): decimations Λ → Λ(1) → … → Λ(n) of the potential-moving type with parameters ζ (the
plaquette-moving renormalisation, (2.17)) and r, the character coefficients c_j(n) = ĉ_j(n)^{b²r} (2.19), p. 8.
III.1 (p. 17): with ζ = b^{d−2} and 0 < r ≤ 1 the decimated partition function is an UPPER bound,
Z_{Λ(n−1)}({c_j(n−1)}) ≤ F₀ᵁ(n)^{|Λ(n)|} Z_{Λ(n)}({c^U_j(n, r)}) (3.4), "optimized for r = 1" (p. 15), with
c^U_j(n, r) = c^U_j(n, 1)^r (3.3); III.2 (p. 17): a lower bound with c^L_j. Interpolating coefficients
c̃_j(m, α, r) between the lower (α = 0) and upper (α = 1) bounds, and a family h(α, t) of normalisations, the
sandwich gives for each (t, r) an α = α^{(m)}_{Λ,h}(t, r) ∈ (0, 1) with the decimated representation EXACT:
Z̃_{Λ(m)}(β, h, α^{(m)}_{Λ,h}(t, r), t, r) = Z_{Λ(m−1)} (3.24), p. 13; likewise α⁺^{(m)} for Z⁺ = ½(Z + Z^(−)) by (4.19),
p. 22. The derivative that governs the level surface:

  A_{Λ(m)}(α, r) ≡ (1/ln F₀ᵁ(m)) (1/|Λ(m)|) ∂/∂α ln Z_{Λ(m)}({c̃_j(m, α, r)}) > 0        (3.27), p. 14,
  A⁺_{Λ(m)}(α, r) ≡ (1/ln F₀ᵁ(m)) (1/|Λ(m)|) ∂/∂α ln Z⁺_{Λ(m)}({c̃_j(m, α, r)}) > 0       (4.22), p. 22,

and ∂α/∂t = v(α, t, r) = −(∂h/∂t)/(∂h/∂α + A) (3.25)–(3.26), p. 14. THE INEQUALITY AT THE CENTRE:

  A_{Λ(n)}(α, r) ≥ A⁺_{Λ(n)}(α, r)   with r in (3.31)                                     (5.15), p. 26,
  equivalently A_{Λ(n)}(α, r) ≥ A^(−)_{Λ(n)}(α, r)                                          (5.16), p. 26,

A^(−) being (4.22) with Z^(−). Its role: "A unique solution to (5.14) indeed exists as shown in Appendix C provided
(5.15)" (p. 26), (5.14) being the equation Z̃⁺_{Λ(n)}(β, h, α^{(n)}_{Λ,h}(t), t) = Z⁺_{Λ(n−1)} for t — the value
t^{(n)}_{Λ,h} at which "the graphs of α^{(n)}_{Λ,h}(t) and α⁺^{(n)}_{Λ,h}(t) must intersect" (p. 26). With that
crossing, V.1 (p. 27): Z^(−)_Λ/Z_Λ = Z^(−)_{Λ(n)}({c̃_j(n, α*)})/Z_{Λ(n)}({c̃_j(n, α*)}) (5.17), α* = α^{(n)}(t^{(n)})
(5.18), and by Cauchy's mean value theorem with (5.16), the lower bound by the upper-bound coefficients
Z^(−)_Λ/Z_Λ ≥ Z^(−)_{Λ(n)}({c^U_j(n)})/Z_{Λ(n)}({c^U_j(n)}) (5.22), p. 27 — the area law for the vortex free energy
once c^U(n) is at strong coupling. Where (5.15) is proved: p. 27, "Assume now that under successive decimations the
coefficients c^U_j(m) in (4.28) evolve within the convergence radius of the strong coupling cluster expansion.
Taking then n in (5.10) sufficiently large, we need establish inequality (5.15) only at strong coupling. Within this
expansion it is a straightforward exercise to establish the validity of (5.15), with strict inequality on any finite
lattice." No proof is written; at strong coupling the claim is credible (the twist flips the sign of the half-integer
characters on the vortex sheet; the leading closed surfaces meeting the sheet lower ln Z⁺ relative to ln Z, more so
as α grows).

## 2. Finite-dimensional per scale, or a statement on the full measure?

(5.15) is a statement about the FULL LATTICE MEASURE at scale n: both sides are α-derivatives of the free energy per
site of the whole decimated lattice Λ(n) (|Λ(n)| = |Λ|/b^{4n} sites) with the interpolated coefficients, the vortex
sheet V spanning Λ(n) in two directions. No finite-dimensional instrument reads it. At strong coupling it becomes a
convergent cluster expansion whose terms ARE finite-dimensional (polymers meeting V, each an integral over finitely
many links), so it is "finite computation plus a tail bound" there — certifiable term by term with a convergence
certificate (Kotecký–Preiss-type constants), never as a closed finite object. What our instruments CAN certify is
V.1's HYPOTHESIS at r = 1: c^U_j(n) is the Migdal–Kadanoff recursion (ζ = b^{d−2}, r = 1, (2.19)–(2.22)), single-
plaquette integrals and powers, exactly the road's certified descent — if the b's agree (the road's b against
Tomboulis's; the first thing to check), the rung K* = 7 at which the certified flow from 2.3 enters the strong-
coupling disk IS the n₀ of V.1. What no instrument of ours reaches, and where the proof fails, is the matching: the
existence of the t-shifts (5.7), (5.9) at every step and of the crossing t^{(n)} in (5.14) — statements about two
full-lattice level surfaces α(t), α⁺(t) differing by O(1/|Λ(n)|), (5.6), (5.12), which is the whole size of the
free-energy difference being extracted (p. 25: "any discrepancy of the size (5.6) means that the first factor in
(5.2) can contribute as much as the second factor in round brackets").

## 3. The objection and the reply, with pages

ITO–SEILER I (0711.4930). pp. 6–7: Tomboulis "claims that there exists a t* > 0 such that α(t*) = α⁺(t*) (3.2) …
But this is not proved in the paper"; p. 7: the author "proves that if A(α) > A⁺(α) (3.5) then equation (3.2) has
the solution. Namely equation (3.2) is reduced to inequality (3.5) which is, as far as we can see, not proven";
p. 8: "It is not clear where and how his claim is proven for large β where the high-temperature expansion never
works!"; p. 9: the continuation t(λ) of Ψ(λ, t) = 0: "if A⁺(α) > A(α) … the integrand F(s, t) diverges at some
s = s₀ < 1"; §4 p. 9: "it is again a very subtle problem to show the existence of t such that α(t) = α⁺(t) since
it does not exist in the case of G = U(1)"; Remark 2.2(2) p. 6: "The parameter r increases the dimension D from
D = 4 to D ≥ 4 … So we set r = 1 in this paper."

TOMBOULIS'S REPLY (0712.2620). Abstract and §1 p. 1: "the inequality in question is invoked only at strong
coupling, where it is easily proven"; "by first allowing for a sufficiently large number of RG decimations, the RG
flow enters the regime of the convergence of the strong coupling expansion. It is only at this point that the
further development of the argument leads to invoking inequality (5.15)." p. 4: the t-shifts (2.8) are "always
possible as long as the derivatives of α^{(m)}_Λ(t, r) and α⁺^{(m)}_Λ(t, r) w.r.t. t do not vanish, or more precisely
are bounded from below by a non-zero constant independent of the lattice volume. As discussed in detail in [1], this
can always be ensured by taking the decimation parameter r < 1." p. 5: "there was never any issue of proving the
inequality at large β … It is, in fact, not a priori clear whether it holds at large β"; Ito–Seiler's r remark is
"manifestly incorrect, and in fact absurd"; p. 6: "Allowing variation of this parameter is an integral part of the
argument in [1] since such variation ensures that derivatives of the level-surfaces … do not vanish … Without this
assurance, the argument cannot go through."

ITO–SEILER II (0803.3019). §3.2 p. 12, three problems: "Problem 1. The existence of t_m satisfying (5.9) in [1] …
is not established. Problem 2. The existence of t* satisfying α⁺^{(n)}(t*) = α^{(n)}(t*) is not established.
Problem 3. The implicit function theorem is used to obtain t(λ) … It is not proven that t(λ) can be extended from
t = 0 to t = 1 even if Ψ_t ≠ 0." And: "all these claims depend on the hypothesis that both ∂α/∂t and ∂α⁺/∂t are
bounded from below by strictly positive constants … uniformly in t ∈ ℝ. But this cannot be correct without assuming
α(t) ≤ 1 − δ (δ > 0) for all t uniformly in n or Λ(n)." §3.3 pp. 12–15, the origin: r is introduced to keep
α < 1 − δ, "But the price to pay for this is that c_j(n) may not converge to 0 (the strong coupling fixed point) as
n → ∞!"; "If r < 1, the recursion formula drives the system to the weak coupling fixed point if β is large and α is
close to 1. Namely if r < 1 and β is large, Theorem 2.1 does not hold"; the Gaussian example f₀ → f_n(θ) =
exp(−βθ²/(2rⁿ)); the numerical SU(2) flow at r = 0.9: "a 'critical point' at β ≈ 4.8: for β ≥ 4.8 the modified MK
flow goes to the weak coupling fixed point" (Figure 1, p. 14). The dilemma, pp. 14–15: "1. r < 1. The larger β, the
closer to one r will have to be chosen … But then it will be very difficult to ensure that α is sufficiently far from
1. 2. r = 1. All parameters depend on β and |Λ| in a very subtle way in this case. (But this is sure to fail for
G = U(N).)" p. 16, Kanazawa's example against Appendix C's continuation: "Ψ(λ, t) = e^{−t} − 1 + 2λ"; §4 p. 16:
"For large β and r = 1 such a t* does not exist [for U(1)], whereas for r < 1 t* may exist, but does not imply
confinement."

TOMBOULIS'S OWN TEXT on the two hinges. p. 15: "Consider the possibility that one finds that α^{(m)}_{Λ,h}(t_m, 1)
differs from 1 only by terms that vanish as the lattice size grows. This means that, since v ≥ 0 in (3.25),
α^{(m)}_{Λ,h}(t, 1) is, to within such terms, a constant function of t for all t ≥ t_m. For the purposes of the
argument in the following sections we want to exclude this possibility" — the exclusion is by r < 1, (3.30)–(3.32),
with "ε independent of |Λ(m)|" and "This ε may eventually be taken as small as one pleases after a sufficiently large
number of decimations". Appendix C, p. 45: (C.9) Ψ_t < 0 by (5.15), (C.10) Ψ_λ > 0, "Thus, from (C.8), t(λ) is an
increasing function of λ, and extends to the solution t(1) > t₀"; the general principle invoked, p. 45: "this
procedure constructs the desired branch away from the initial point as long as Ψ_t ≠ 0 along the branch. The
existence of a solution t(1) is therefore guaranteed by basic existence theorems if this condition is satisfied
throughout the interval 0 ≤ λ ≤ 1." I checked Kanazawa's example by hand: Ψ = e^{−t} − 1 + 2λ has Ψ_t = −e^{−t} < 0
everywhere and Ψ_λ = 2 > 0, the branch from t(0) = 0 is t(λ) = −ln(1 − 2λ), increasing, and it escapes to +∞ at
λ = ½: no solution for λ ≥ ½. So the principle as stated on p. 45 is false; monotonicity plus Ψ_t ≠ 0 gives
continuation only with an a priori bound on t(λ) over [0, 1], which in this setting means α_h(t(λ)) kept away from 1
along the branch (t → ∞ is h → 0, the degenerate edge of the interpolation) — the very bound (3.30) whose
uniformity in n, |Λ| and β is the r-dilemma. The three problems are one problem.

## 4. Verdict, at strength

The pages support Ito–Seiler. Tomboulis's reply is right on the one narrow point it answers: the first note misplaced
where (5.15) is invoked; by construction (p. 27, V.1) it is invoked only after the upper-bound flow has entered the
strong-coupling radius, and there it is credible. It is wrong to dismiss the r remark as semantics: with r < 1 the
upper-bound flow c^U(n, r) = c^U(n, 1)^r is pushed toward weak coupling, and for β large enough it no longer reaches
strong coupling at all (the Gaussian example exactly, SU(2) at r = 0.9 numerically from β ≈ 4.8), so V.1's hypothesis
fails exactly where confinement is to be proved; with r = 1 the lower bound on ∂α/∂t that every t-shift and the
crossing need is, by Tomboulis's own p. 15, not lattice-size independent, and for U(1) it must fail. Appendix C's
continuation argument is invalid as a general principle (the counterexample above) and supplies no bound on the
branch. And the U(1) test (§0) convicts the derivation of V.1 outright: every premise of V.1 holds for
four-dimensional U(1) at every β, its conclusion is false above β₀, and no step of the derivation sees the group.
0707.2179 therefore does not prove confinement; V.1 is a conditional statement whose derivation has a gap at the
matching, and the gap is not a detail. I find no reply by Tomboulis to 0803.3019 among the four papers; whether one
exists elsewhere I did not search.

## 5. What the road can use

(i) The sandwich-and-continuity identity (3.24) is sound: for every t there is an α with the decimated interpolated
partition function EQUAL to the original — the partition function is transported exactly. (ii) The upper-bound
flow at r = 1 is the certified Migdal–Kadanoff descent; V.1's n₀ is our K*. (iii) THE OBSTRUCTION, cleanly stated:
transporting a free-energy DIFFERENCE (twisted/untwisted, or any correlation) across a decimation needs the two
level surfaces α(t), α⁺(t) to cross, and whether they cross is a statement about the full measure that no finite-
dimensional certificate reaches; the per-observable α's differ by O(1/|Λ(n)|), which is the size of the quantity
sought. This is the same wall as THE GROUND's "strong end's standing" (no composition theorem) and the road's refuted
first MK hypothesis (RESULTS 16.5): a bracket on Z is not a bracket on the measure. The centre route at the page
level adds no instrument the road lacks and carries one proven-invalid step; its value is the exact form of the
missing object.
