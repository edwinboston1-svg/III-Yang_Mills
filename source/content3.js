// Sections 7-8 of THE GROUND: the residue, the completion, and the ground handed over.
module.exports = function (L) {
  const { P, P0, H1, H2, Thm, Proof, Quote, Item, Eq, Grid, mr, frac, sub, sup } = L;
  const S = require('./sources.js');
  const out = [];
  const push = (...xs) => xs.flat().forEach(x => out.push(x));

  // ---------------------------------------------------------------- 7
  push(H1('7.  The Residue and Its Completion'));
  push(P0(`*This section proves part (iv) of the Ground Theorem.*`, { after: 100 }));
  push(H2('7.1  The residue'));
  push(P0(`Table 1 sets each demand of the problem statement beside what the two manuscripts assert, with the section of this paper that carries the evidence.`, { keepNext: true }));
  push(Grid(
    ['The problem demands', 'YMM1, three dimensions', 'The zeroth draft, four dimensions'],
    [
      ['Every compact simple gauge group', 'SU(2) (§5.2)', 'SU(2); no statement for SU(*N*), *N* ≥ 3 (§6.3)'],
      ['All gauge-invariant local polynomials in the curvature', 'The scalar plaquette-energy density; curvature bilinears in YMM2 (§§5.1–5.2)', 'The action density (§6.2)'],
      ['The infinite volume', 'Limits along subsequences (§5.3)', 'Limits along subsequences of cutoffs and volumes, under the declared inputs (§6.2)'],
      ['Euclidean invariance (E1)', 'Asserted (§5.3)', 'Translations and the hypercubic group; O(4) under the flux hypothesis (§6.2)'],
      ['Reflection positivity and symmetry (E2), (E3)', 'Asserted (§§5.3–5.4)', 'Asserted under the declared inputs (§6.2)'],
      ['The cluster property (E4) and a unique vacuum', 'In each component, with decay |*v*|^{−1}; not for the original limit (§§5.3–5.4)', 'Not claimed (§6.3)'],
      ['Field operators and the relativistic spectral condition', 'A scalar Wightman field in each component (§5.4)', 'Not claimed; a non-negative Hamiltonian (§§6.2–6.3)'],
      ['Short-distance agreement with asymptotic freedom', 'The two-point law (5.3) (§5.5)', 'A two-point law in the running coupling, uniform in the volume (§6.2)'],
      ['A mass gap Δ > 0 with finite mass', 'Not asserted (§5.6)', 'Not addressed (§6.3)'],
      ['A verified proof', 'Not satisfactorily vetted, by the authors\' statement (§6.4)', 'Conditional; two supporting statements not yet written (§6.2)'],
    ],
    [2700, 3330, 3330]));
  push(P0(`*Table 1.* The demands of the problem statement and the assertions of the corpus.`, { align: L.d.AlignmentType.CENTER, before: 80, after: 200, base: { size: 19 } }));

  push(H2('7.2  The gap is exponential clustering'));
  push(P0(`The decisive observation is that, for a reflection-positive theory, a mass gap and exponential decay of the reflection-positive correlations are one and the same property. The argument is the spectral theorem applied to the semigroup of Osterwalder and Schrader; its weight here lies in the identification it makes. Let *S* be reflection positive and invariant under time translations, and let H, Ω and *H* ≥ 0 be the Hilbert space, the vacuum and the Hamiltonian that Osterwalder and Schrader construct from these two properties, with the relations of Theorem 3.1. This is exactly the structure that both manuscripts assert for their limits.`));
  push(Thm('Theorem 7.1', 'The gap is exponential clustering', [
    `Let m > 0. The following conditions are equivalent.`,
    `(a) Ω is, up to a phase, the only vector annihilated by H, and H has no spectrum in the interval (0, m).`,
    `(b) For every finite family f and every t ≥ 0, S(θf̄ · τ_{t}f) − |S(f)|² ≤ e^{−mt} ( S(θf̄ · f) − |S(f)|² ).`,
    `(c) For every finite family f there are a constant C_{f} and an unbounded set T_{f} ⊂ [0, ∞) such that S(θf̄ · τ_{t}f) − |S(f)|² ≤ C_{f} e^{−mt} for every t ∈ T_{f}.`,
    `When they hold and H has dimension at least two, the mass m\\* = inf spec(H restricted to Ω^{⊥}) satisfies m ≤ m\\* < ∞.`,
  ]));
  push(P0(`*Proof.* For a finite family *f* put ψ_{f} = [*f*] − *S*(*f*)Ω. Since ⟨Ω, [*f*]⟩ = *S*(*f*), the vector ψ_{f} is the orthogonal projection of [*f*] onto Ω^{⊥}, and since *e*^{−tH}Ω = Ω,`));
  push(Eq([mr('⟨'), sub('ψ', 'f'), mr(', '), sup('e', '−tH'), mr(' '), sub('ψ', 'f'), mr('⟩ = S(θf̄ · '), sub('τ', 't'), mr('f) − '), sup('|S(f)|', '2'), mr(',      t ≥ 0.')], '7.1'));
  push(P0(`The space Ω^{⊥} reduces *H*, and since the vectors [*f*] are dense in H, the vectors ψ_{f} are dense in Ω^{⊥}.`));
  push(P(`(a) ⇒ (b). By (a) the restriction of *H* to Ω^{⊥} has spectrum in [*m*, ∞), so *e*^{−tH} ≤ *e*^{−mt} on Ω^{⊥} by the spectral theorem. Apply this to ψ_{f} in (7.1); the case *t* = 0 of (7.1) identifies ‖ψ_{f}‖².`));
  push(P(`(b) ⇒ (c). Take *C*_{f} = *S*(θ*f̄* · *f*) − |*S*(*f*)|² and *T*_{f} = [0, ∞).`));
  push(P(`(c) ⇒ (a). Let μ_{f} be the spectral measure of *H* in the vector ψ_{f}, a finite positive measure on [0, ∞). For 0 ≤ *m*′ < *m* and *t* ∈ *T*_{f}, identity (7.1) and condition (c) give`));
  push(Eq([sub('μ', 'f'), mr('([0, m′]) '), sup('e', '−tm′'), mr(' ≤ ∫ '), sup('e', '−tλ'), mr(' d'), sub('μ', 'f'), mr('(λ) ≤ '), sub('C', 'f'), mr(' '), sup('e', '−mt'), mr(',')], '7.2'));
  push(P0(`so μ_{f}([0, *m*′]) ≤ *C*_{f} *e*^{−(m−m′)t} for arbitrarily large *t*, and μ_{f}([0, *m*′]) = 0. Letting *m*′ increase to *m* gives μ_{f}([0, *m*)) = 0, which says that *E*ψ_{f} = 0 for the spectral projection *E* of *H* onto [0, *m*). The ψ_{f} are dense in Ω^{⊥} and *E* is bounded, so *E* vanishes on Ω^{⊥}. Hence *H* ≥ *m* on Ω^{⊥}: no nonzero vector of Ω^{⊥} is annihilated by *H*, and *H* has no spectrum in (0, *m*). This is (a).`));
  push(P(`Finally, if dim H ≥ 2 then Ω^{⊥} ≠ {0}, the spectrum of *H* on Ω^{⊥} is a nonempty closed subset of [*m*, ∞), and its infimum *m*\\* is finite. ∎`));
  push(P0(`The finite form of the implication (c) ⇒ (a), the gap read off the decay of a positive symmetric transfer matrix, is checked by the Lean kernel.[[fn:Edwin Boston III; listed in the Records under the lattice theorems in Lean.]]`, { before: 60 }));
  push(Thm('Corollary 7.2', 'Clustering', [
    `Under the conditions of Theorem 7.1, for all finite families f and g and every t ≥ 0, |S(θḡ · τ_{t}f) − S(θḡ) S(f)| ≤ e^{−mt} ‖ψ_{g}‖ ‖ψ_{f}‖. If S also satisfies (E0)–(E3), the cluster property (E4) holds, and the same bound holds with τ_{t} replaced by the translation by t in any direction.`,
  ]));
  push(Proof(`The left side is |⟨ψ_{g}, *e*^{−tH}ψ_{f}⟩|, and *e*^{−tH} has norm at most *e*^{−mt} on Ω^{⊥}. Under (E0)–(E3) the vacuum is unique by Theorem 7.1, and Theorem 3.1 gives (E4). A translation in another direction is conjugate to τ_{t} by a Euclidean rotation, under which *S* is invariant by (E1), and the reflection Hilbert space built across the rotated hyperplane carries the same Hamiltonian spectrum, since the Schwinger functions it is built from are the same functions.`));
  push(P0(`Measured against Theorem 7.1, the decay (5.2) asserted for the components of YMM1 is the decay of a theory whose mass gap has not been established: a bound by an inverse power of the separation is compatible with spectrum reaching down to zero. The distance between the power and the exponential is the mass gap.`));

  push(H2('7.3  From the lattice to the limit'));
  push(Thm('Lemma 7.3', 'Passage to the limit', [
    `Let S_{j} be Schwinger functions converging to S, along a subsequence, on the test functions flat at the coincidence diagonals, and let D ⊂ [0, ∞) be unbounded. Suppose that for every finite family f there are a constant C_{f} and numbers r_{j}(t; f), with r_{j}(t; f) → 0 as j → ∞ for each t ∈ D, such that S_{j}(θf̄ · τ_{t}f) − |S_{j}(f)|² ≤ C_{f} e^{−mt} + r_{j}(t; f) for t ∈ D. Then S satisfies condition (c) of Theorem 7.1.`,
  ]));
  push(Proof(`For a finite family *f* and *t* ≥ 0 the families θ*f̄* and τ_{t}*f* are supported in opposite half-spaces, so every test function entering *S*_{j}(θ*f̄* · τ_{t}*f*) is flat at the coincidence diagonals, and both sides of the hypothesis converge along the subsequence. The inequality passes to the limit, with *T*_{f} = *D*.`));
  push(Thm('Theorem 7.4', 'The completion', [
    `Let a construction be given by Wilson measures on periodic lattices of spacings a_{j} = a₀L^{−Kⱼ}, with L a fixed integer and K_{j} → ∞, whose sides tend to infinity, with bare couplings tuned along the sequence; and let the Schwinger functions S_{j} of smeared gauge-invariant observables converge along a subsequence to S. Let D be the set of times n a₀L^{−k} with n, k ≥ 0. Suppose that the lattice correlations cluster uniformly at a physical rate m > 0: for every finite family f there are a constant C_{f} and numbers r_{j}(t; f) → 0 as j → ∞ for each t ∈ D, such that`,
    `S_{j}(θf̄ · τ_{t}f) − |S_{j}(f)|² ≤ C_{f} e^{−mt} + r_{j}(t; f)   for t ∈ D.`,
    `Then S has a unique vacuum, its Hamiltonian has no spectrum in (0, m), and its connected reflection-positive correlations decay in time at the rate m. If S is non-trivial, its mass is finite. The hypothesis holds, with r_{j} = 0, when the S_{j} are the correlations of the states ψ₀ of spatial tori, the transfer matrices satisfy m_{lat}(j) ≥ m a_{j} on the sector generated by the observables, and the correlations at separated points are bounded uniformly in j.`,
  ]));
  push(Proof(`The set *D* is unbounded and independent of *f*. Lemma 7.3 gives condition (c) of Theorem 7.1 for *S*, and Theorem 7.1 with Corollary 7.2 gives the conclusions; non-triviality means that H has dimension at least two. For the last sentence, each *t* ∈ *D* is an integer multiple *n*_{j}*a*_{j} of the spacing for all large *j*, and the smeared observable of τ_{t}*f* is then the lattice translate by *n*_{j} steps of the smeared observable of *f*. With *q*_{j} = λ₁/λ₀ for the transfer matrix of rung *j*, so that −log *q*_{j} = *m*_{lat}(*j*) ≥ *m a*_{j}, Lemma 4.2 gives *S*_{j}(θ*f̄* · τ_{t}*f*) − |*S*_{j}(*f*)|² ≤ *q*_{j}^{nⱼ} (*S*_{j}(θ*f̄* · *f*) − |*S*_{j}(*f*)|²) ≤ *e*^{−mt} (*S*_{j}(θ*f̄* · *f*) − |*S*_{j}(*f*)|²), and the bracket is a correlation at separated points, bounded uniformly in *j* by a constant depending only on *f*.`));
  push(Thm('Corollary 7.5', 'What the gap supplies against the footnote', [
    `For a construction by compactness of the kind in Theorem 7.4, uniform clustering at a physical rate, and in particular a lattice gap uniform in physical units, supplies the mass gap and the uniqueness of the vacuum. With (E0)–(E3), (E1) meaning full Euclidean invariance, it supplies the properties that the footnote of Proposition 3.2 names: the mass gap and the axioms.`,
  ]));
  push(Proof(`Theorem 7.4 gives the gap and the unique vacuum; with (E0)–(E3), Corollary 7.2 gives the cluster property (E4), which completes the axioms.`));

  push(H2('7.4  The collapse of the components'));
  push(Thm('Corollary 7.6', 'The gap collapses the component measure', [
    `If the original limit σ of Theorem B of YMM1 satisfies condition (c) of Theorem 7.1, then its component measure λ is a point mass, σ is itself a clustering theory, and its connected correlations decay exponentially in every direction.`,
  ]));
  push(Proof(`By Theorem B of YMM1 the zero-energy space of σ is L²(X, λ), with the vacuum the constant 1 (§5.4). By Theorem 7.1 the zero-energy space is spanned by Ω, so L²(X, λ) is one-dimensional. If λ were not a point mass, a Borel set *B* with 0 < λ(*B*) < 1 would give a function 1_{B} independent of 1 in L²(X, λ). Hence λ is a point mass; since λ has full support, X is a single point and σ = σ_{ξ}. The decay is exponential in time by Corollary 7.2 and in every direction by the Euclidean invariance of σ.`));
  push(P0(`A gap would therefore do more than add a property to the limit: it would remove the need for the conditioning by which the corpus obtains its clustering components.`));
  push(Proof(`The residue is Table 1, each entry of which is proved in Sections 5 and 6. The completion is Theorem 7.4, and its equivalence with uniform exponential clustering is Theorem 7.1, carried along the sequence by Lemma 7.3.`, 'Proof of part (iv)'));
  return out;
};
