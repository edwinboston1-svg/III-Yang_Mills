# THE GROUND, revision 32 — §8.3, the reduction in L²: draft text for insertion beside Theorem 8.5

Drafted 2026-11-02 by the second reader of M2 (M2R), from THE GROUND §8.3 (source/ground/content4.js lines 66–106, read only) and the
reviewed draft M2/WORK.md. Theorems and proofs only. New statements carry primes and letters (Proposition 8.1′, Proposition 8.4′,
Hypotheses I′ and II′, Lemmas 8.5A–8.5B, Proposition 8.5C, Theorem 8.5D, Proposition 8.5E, Theorem 8.5′, Corollary 8.5F), so nothing
after Theorem 8.5 renumbers. Footnotes are in the source's [[fn:…]] form. Placement notes are in square brackets and are not paper text.

[Placement. Part 1 replaces the first two paragraphs of §8.3 (the partition and the block map): it states the widened setting, in which
Theorem 8.5 and its proof stand unchanged. Parts 2–6 follow the paragraph after Theorem 8.5's proof that reads Hypothesis I on the
effective action, and precede the paragraph on whole-block total variation.]

---

## 1. The setting, widened

The passage from the second link to the gap is itself a theorem, and this section proves it at the strength of its hypotheses, in two
currencies. Fix a physical length *a*_c = *n*_c *a*₀, a positive integer multiple of the unit *a*₀ of Theorem 7.4, and call it the coarse
scale. Take the construction of Theorem 7.4 with any fixed integer *L* ≥ 2, on lattices whose sides are multiples of *a*_c, with an even
number of blocks in the time direction, and whose reflection hyperplane is one of the hyperplanes *x*₀ = *n a*_c. Every spacing
*a*_j = *a*₀*L*^{−K_j} then divides *a*_c, the number of lattice sites in the time direction is even, and the Wilson measure μ_j is reflection
positive through each hyperplane *x*₀ = *n a*_c.[[fn:K. Osterwalder and E. Seiler, "Gauge field theories on a lattice", *Ann. Physics* 110
(1978), 440–471.]] The half-open cubes of side *a*_c with corners on the coarse lattice ℤ⁴ of spacing *a*_c, reduced modulo the sides,
partition the lattice of rung *j* into blocks, each link assigned to the block containing its midpoint. Write *Y* for the set of coarse
points of the lattice, *B*_y for the block at *y* ∈ *Y*, and |*y* − *y*′| = max_ν |*y*_ν − *y*′_ν| for the distance on the coarse torus; the four
links of a plaquette lie in blocks at mutual distance at most one. For a bounded observable *f*, a function of the links, let *S*(*f*) be the
set of blocks containing a link on which *f* depends, *N*(*f*) its cardinality, ‖*f*‖ its supremum norm, and δ_y(*f*) the oscillation of *f* under
changes of the links of *B*_y alone, so that δ_y(*f*) ≤ 2‖*f*‖ and δ_y(*f*) = 0 off *S*(*f*); the distance between two sets of blocks is the least
distance between their members. For a smeared Wilson loop, for a polynomial in such loops, and for every observable
whose support and bound are fixed in physical units, *N*(*f*) and ‖*f*‖ are bounded uniformly in *j*.

A coarse map at rung *j* is a measurable map Φ_j from the link configurations of the lattice of rung *j* to *V*^Y, in which *V* is a fixed
compact metric space, the space of the coarse variables; write *v*_y for the coordinate of Φ_j at *y*. No locality is asked of it: *v*_y
may depend on links outside *B*_y, so averaged variables whose supports straddle adjacent blocks are admitted, as soon as they are defined,
measurably, on every configuration. A block map — a measurable bijection of the configurations of a block onto a product *V* × Φ_j, with
measurable inverse, the same for every block, such as one SU(2) element per coarse link, the holonomy of the block along a fixed path, with
the remaining links in a fixed gauge — gives a coarse map with *v*_y a function of the links of *B*_y alone. A coarse map is translation
covariant when it commutes with the translations of the lattice by multiples of *a*_c; its blocked measure is then invariant under the
translations of *Y*. The blocked measure λ_j is the law of *v* = Φ_j under μ_j, and the fibre measure ν_j(· | *v*) is a regular version of the
conditional law of the configuration given Φ_j = *v*, which exists because the configuration space is compact metric. The blocked measure
is assumed to have the form

(S)  λ_j(*dv*) = *e*^{−A_j(v)} ∏_{y∈Y} *m*(*dv*_y),

with *m* a Borel probability measure on *V* and *A*_j a measurable function finite ∏*m*-almost everywhere: the effective action at the
coarse scale. Dobrushin's interdependence matrix (8.5), Hypotheses I and II, and the oscillations δ_y(*F*) of functions *F* of the coarse
configuration under changes of *v*_y alone are read for versions of the conditional laws of λ_j and of ν_j(· | *v*) defined for every coarse
configuration; the hypotheses in the L² currency below involve those laws only λ_j-almost everywhere.

[With this paragraph, (8.5), Proposition 8.4, Hypotheses I and II and Theorem 8.5 with its proof stand as written, with "block map" read as
"coarse map" and "L = 2" as "L as above": the proof of Theorem 8.5 uses neither the bijection, nor the locality of v_y, nor the value of L.]

---

## 2. The L² currency and the two hypotheses

The gap of a positive transfer operator is an L² quantity, and the coefficient of Proposition 8.1 is a supremum that dominates it.

**Proposition 8.1′** (The gap is an L² norm). *Let T be a transfer operator on a compact space X with kernel T(x, dy) = t(x, y) dy, t
continuous, strictly positive and symmetric, and T positive as an operator on L²(dy); let λ₀ > λ₁ be its two largest eigenvalues, ψ₀ the
positive eigenfunction normalised in L²(dy), π(dx) = ψ₀(x)² dx, and P the Doob transform of Proposition 8.1. Then P is self-adjoint on
L²(π), and on L²₀(π) = {u : π(u) = 0}*

  ‖*P*^k‖_{L²₀(π)} = (λ₁/λ₀)^k  for every *k* ≥ 1,   so that  *m*_lat = −log ‖*P*‖_{L²₀(π)};

*moreover ‖P^k‖_{L²₀(π)} ≤ δ(P^k), and*

  ∫ χ²(*P*^k(*x*, ·) ‖ π) π(*dx*) = Tr *T*^{2k}/λ₀^{2k} − 1 = Σ_{i≥1} (λ_i/λ₀)^{2k},

*the eigenvalues λ_i counted with multiplicity.*

*Proof.* For bounded *u* and *w*, ∫ *w* · *Pu* dπ = λ₀⁻¹ ∬ *w*(*x*)ψ₀(*x*) *t*(*x*, *y*) ψ₀(*y*)*u*(*y*) *dx dy*, which is symmetric in *u* and *w*;
so *P* is self-adjoint on L²(π). Multiplication by ψ₀ is a unitary map *U* of L²(π) onto L²(*dx*), ψ₀ being continuous and bounded below on
the compact space *X*, and (*T*/λ₀)(ψ₀*u*) = ψ₀ *Pu*, that is *UPU*⁻¹ = *T*/λ₀. The map *U* carries the constants to ψ₀ and L²₀(π) onto the
orthogonal complement of ψ₀, so *P* on L²₀(π) is unitarily equivalent to *T*/λ₀ on ψ₀^⊥, a compact positive operator whose norm is its
largest eigenvalue λ₁/λ₀; powers pass through the equivalence. For an eigenvalue λ ≠ 0 of *T* with eigenfunction ψ, the eigenfunction ψ/ψ₀ of
*P* is continuous, hence bounded, and it is nonconstant when λ ≠ λ₀, so the oscillation argument of Proposition 8.1 gives |λ/λ₀|^k ≤ δ(*P*^k)
for every eigenvalue λ ≠ λ₀ of *T*; the norm of the self-adjoint *P*^k on L²₀(π) is the largest of these numbers. Finally *P*^k(*x*, *dy*) has density
*p*_k(*x*, *y*) = *t*_k(*x*, *y*)/(λ₀^k ψ₀(*x*)ψ₀(*y*)) with respect to π, *t*_k the kernel of *T*^k, so ∬ *p*_k² dπ dπ = λ₀^{−2k} ∬ *t*_k(*x*, *y*)² *dx dy* =
λ₀^{−2k} Tr *T*^{2k} = Σ_i (λ_i/λ₀)^{2k}, the operator *T*^k being Hilbert–Schmidt with continuous symmetric kernel; since ∫ *p*_k(*x*, *y*) π(*dy*) = 1
for every *x*, ∬ (*p*_k − 1)² dπ dπ = Tr *T*^{2k}/λ₀^{2k} − 1, and the inner integral is χ²(*P*^k(*x*, ·) ‖ π). ∎[[fn:The Doob transform and the
averaged χ² identity for reversible chains are classical: L. Saloff-Coste, "Lectures on finite Markov chains", *Lectures on Probability Theory
and Statistics (Saint-Flour, 1996)*, Lecture Notes in Math. 1665, Springer, Berlin, 1997, 301–413; D. A. Levin, Y. Peres and E. L. Wilmer,
*Markov Chains and Mixing Times*, second edition, American Mathematical Society, Providence, 2017, chapter 12. That the subdominant spectrum
is bounded by Dobrushin's coefficient is classical as well: E. Seneta, *Non-negative Matrices and Markov Chains*, second edition, Springer,
New York, 1981; R. L. Dobrushin, "Central limit theorem for nonstationary Markov chains. I, II", *Theory Probab. Appl.* 1 (1956), 65–80
and 329–383.]]

The average in the last display is at least the multiplicity of λ₁ times (λ₁/λ₀)^{2k}, so it controls the gap only once the decay beats
that multiplicity; the norm carries no multiplicity, and Proposition 8.1 dominates it by a supremum over pairs of starting points. The
reduction below is stated in the same currency.

For a rung *j* and a lattice of the construction, the inner product of L²(λ_j) is ⟨*F*, *G*⟩ = λ_j(*F̄G*); in Lemmas 8.5A and 8.5B,
Proposition 8.5C, Theorem 8.5D and Proposition 8.5E the rung and the lattice are fixed. For *y* ∈ *Y* let
*H*_y be the closed subspace of L²(λ_j) of functions of *v*_{y^c} = (*v*_{y′})_{y′≠y}, *K*_y the orthogonal projection onto it, which is the
conditional expectation *K*_y*F* = λ_j(*F* | *v*_{y^c}), and *Q*_y = *I* − *K*_y. The L² local fluctuation of *F* ∈ L²(λ_j) at *y* is

  ℓ_y(*F*) = ‖*Q*_y*F*‖ = λ_j( Var_{λ_j}(*F* | *v*_{y^c}) )^{1/2};

it vanishes unless *F* depends on *v*_y, it equals ℓ_y(*F̄*), and for bounded *F* it is at most δ_y(*F*)/2, a variance being at most a quarter of
the squared oscillation. For distinct *y*, *y*′ write ξ = *v*_{{y,y′}^c} for the coarse environment of the pair, π_ξ for a version of the
conditional law of (*v*_y, *v*_{y′}) given ξ, and

  ρ_ξ(*y*, *y*′) = sup{ Cov_{π_ξ}(*f*(*v*_y), *g*(*v*_{y′})) : Var_{π_ξ} *f* = Var_{π_ξ} *g* = 1 }

for its maximal correlation, the supremum over real or over complex functions being the same; it is a countable supremum over *f* and *g* in
a uniformly dense subset of the continuous functions on *V*, hence measurable in ξ. The conditional maximal correlation matrix of the
blocked measure is

  *R*_j(*y*, *y*′) = ess sup_ξ ρ_ξ(*y*, *y*′),   *R*_j(*y*, *y*) = 0,   (8.5′)

the essential supremum taken under λ_j. It is symmetric, its entries lie in [0, 1], and it does not depend on the versions.[[fn:The maximal
correlation is H. Gebelein's, "Das statistische Problem der Korrelation als Variations- und Eigenwertproblem und sein Zusammenhang mit der
Ausgleichsrechnung", *Z. Angew. Math. Mech.* 21 (1941), 364–379, and A. Rényi's, "On measures of dependence", *Acta Math. Acad. Sci. Hungar.*
10 (1959), 441–451.]]

**Hypothesis I′** (The blocked bound in L²). *There are numbers κ > 0 and α < 1 and a rung j₀ such that at every rung j ≥ j₀, on every
lattice of the construction, Σ_{y′} R_j(y, y′) e^{κ|y−y′|} ≤ α for every coarse point y.*

**Hypothesis II′** (The fibre clustering, averaged over the blocked measure). *There are a number ρ′ < 1, a constant K′ and a rung j₀ such
that at every rung j ≥ j₀, on every lattice of the construction, for all bounded observables f and g, with d the distance between S(f) and
S(g):*

*(a) |λ_j( ν_j(fg | ·) − ν_j(f | ·) ν_j(g | ·) )| ≤ K′ N(f) ‖f‖ ‖g‖ ρ′^d;*

*(b) the fibre mean F = ν_j(f | ·), as a function of the coarse configuration, satisfies ℓ_y(F) ≤ K′ N(f) ‖f‖ ρ′^r for every coarse point y,
where r is the distance from y to S(f).*

Both hypotheses involve the fibre measure and the conditional laws of λ_j only through λ_j-integrals and λ_j-essential suprema, so they do
not depend on the versions. The one supremum in them is the essential supremum over the coarse environment in (8.5′): the conditional law of a
pair of coarse variables is still taken at every environment, but the field inside the blocks enters it integrated with its true conditional
weight, and in Hypothesis II′ an adversarial coarse configuration enters weighted by its probability. Neither hypothesis refers to a limit,
and neither asks for a relation between rungs: each is used at each rung separately.

Hypothesis II implies Hypothesis II′ with the same ρ′ and *K*′, since the λ_j-mean of a function is at most its supremum and ℓ_y(*F*) ≤ δ_y(*F*)/2.
Hypothesis I implies Hypothesis I′ with the same κ and α when the coarse map is translation covariant, by Proposition 8.5E below; when it is
not, Hypothesis I′ follows from Hypothesis I with ½(α + α*) in place of α, provided the weighted column sums Σ_{y′} *C*^λ_j(*y*′, *y*)*e*^{κ|y−y′|}
are at most some α* with α + α* < 2.

---

## 3. The instruments in the L² currency

**Lemma 8.5A** (Two projections). *Let P and Q be orthogonal projections on a Hilbert space, N = ran P ∩ ran Q, P_N the orthogonal
projection onto N, and c = ‖PQ − P_N‖, the cosine of Friedrichs' angle between ran P and ran Q. Then for every vector F,*

  ‖(*I* − *Q*)*PF*‖ ≤ ‖(*I* − *Q*)*F*‖ + *c* ‖(*I* − *P*)*F*‖.

*Proof.* By Halmos' theorem on two subspaces the space is the orthogonal sum of ran *P* ∩ ran *Q*, ran *P* ∩ ker *Q*, ker *P* ∩ ran *Q*,
ker *P* ∩ ker *Q* and a generic part unitarily equivalent to *K* ⊕ *K*, on which *P* = [[*I*, 0], [0, 0]] and
*Q* = [[*C*², *CS*], [*CS*, *S*²]] with *C* = cos Θ and *S* = sin Θ for a positive operator Θ on *K* with 0 < Θ < π/2 and trivial kernels of Θ and
π/2 − Θ; every summand reduces *P* and *Q*. On the four trivial summands *PQ* − *P*_N vanishes, and on the generic part *P*_N = 0 and
‖*PQ*‖ = ‖[*C*², *CS*]‖ = ‖*C*‖, so *c* = ‖*C*‖ when the generic part is not zero. On ran *P* ∩ ran *Q*, (*I* − *Q*)*PF* = 0; on ran *P* ∩ ker *Q*,
(*I* − *Q*)*PF* = *F* = (*I* − *Q*)*F*; on the two summands inside ker *P*, *PF* = 0: on each the inequality holds with 0 in place of *c*. On the
generic part write *F* = (*x*, *y*). Then (*I* − *Q*) = [[*S*², −*CS*], [−*CS*, *C*²]], so (*I* − *Q*)*PF* = (*S*·*Sx*, −*C*·*Sx*), of norm ‖*Sx*‖ since
*C*² + *S*² = *I*, and (*I* − *Q*)*F* = (*S*(*Sx* − *Cy*), −*C*(*Sx* − *Cy*)), of norm ‖*Sx* − *Cy*‖. Hence ‖(*I* − *Q*)*PF*‖ = ‖*Sx*‖ ≤ ‖*Sx* − *Cy*‖ + ‖*Cy*‖
≤ ‖(*I* − *Q*)*F*‖ + *c*‖*y*‖, and ‖*y*‖ = ‖(*I* − *P*)*F*‖. The summands are orthogonal and preserved by *P* and *Q*, so Minkowski's inequality over
them gives the claim. ∎[[fn:P. R. Halmos, "Two subspaces", *Trans. Amer. Math. Soc.* 144 (1969), 381–389; K. Friedrichs, "On certain
inequalities and characteristic value problems for analytic functions and for functions of two variables", *Trans. Amer. Math. Soc.* 41
(1937), 321–364; for the angle and its equivalent forms, F. Deutsch, *Best Approximation in Inner Product Spaces*, Springer, New York, 2001,
chapter 9.]]

**Lemma 8.5B** (The angle between two coarse variables). *For distinct y, y′ the cosine c(y, y′) of Friedrichs' angle between H_y and H_{y′}
is at most R_j(y, y′). Consequently, for every F ∈ L²(λ_j), ℓ_y(K_yF) = 0 and*

  ℓ_{y′}(*K*_y*F*) ≤ ℓ_{y′}(*F*) + *R*_j(*y*, *y*′) ℓ_y(*F*).

*Proof.* The intersection *H*_y ∩ *H*_{y′} contains every function of ξ. The cosine *c*(*y*, *y*′) is the supremum of |⟨*F*, *G*⟩| over unit vectors
*F* ∈ *H*_y orthogonal to *H*_y ∩ *H*_{y′} and *G* ∈ *H*_{y′} orthogonal to *H*_y ∩ *H*_{y′}. Such an *F* is a function of (*v*_{y′}, ξ) orthogonal to every
function of ξ, so λ_j(*F* | ξ) = 0: for λ_j-almost every ξ, *F*(·, ξ) has mean zero under the law of *v*_{y′} under π_ξ. Likewise *G* is a
function of (*v*_y, ξ) with *G*(·, ξ) of mean zero under the law of *v*_y under π_ξ. Disintegrating λ_j over ξ,

  ⟨*F*, *G*⟩ = ∫ λ_j(*d*ξ) ∫ π_ξ(*dv*_y *dv*_{y′}) *F̄*(*v*_{y′}, ξ) *G*(*v*_y, ξ),

and the inner integral is at most ρ_ξ(*y*, *y*′) times the product of the norms of *F*(·, ξ) and *G*(·, ξ) in L²(π_ξ), by the definition of the
maximal correlation. The Cauchy–Schwarz inequality over ξ gives |⟨*F*, *G*⟩| ≤ *R*_j(*y*, *y*′)‖*F*‖‖*G*‖, which is the first assertion. The second is
‖*Q*_y*K*_y*F*‖ = 0, and the third is Lemma 8.5A with *P* = *K*_y and *Q* = *K*_{y′}. ∎

**Proposition 8.5C** (The fluctuation vector decays). *Let L = Σ_{y∈Y} (K_y − I), a bounded self-adjoint operator on L²(λ_j), and
P_t = e^{tL} the semigroup of the heat-bath dynamics that resamples each coarse variable from its conditional law at rate one. Write
ℓ(F) = (ℓ_y(F))_{y∈Y}. Then for every F ∈ L²(λ_j) and every t ≥ 0, componentwise,*

  ℓ(*P*_t*F*) ≤ *e*^{−t(I − R_j)} ℓ(*F*).

*Proof.* For 0 < *h* ≤ 1/|*Y*|, *I* + *hL* = (1 − |*Y*|*h*)*I* + *h* Σ_y *K*_y with non-negative coefficients. Since ℓ_z is a seminorm, ℓ_z(*K*_z*G*) = 0, and
ℓ_z(*K*_y*G*) ≤ ℓ_z(*G*) + *R*_j(*y*, *z*)ℓ_y(*G*) for *y* ≠ *z* by Lemma 8.5B,

  ℓ_z((*I* + *hL*)*G*) ≤ (1 − |*Y*|*h*)ℓ_z(*G*) + *h*(|*Y*| − 1)ℓ_z(*G*) + *h* Σ_{y≠z} *R*_j(*y*, *z*)ℓ_y(*G*) = (((1 − *h*)*I* + *hR*_j) ℓ(*G*))_z.

The matrix (1 − *h*)*I* + *hR*_j has non-negative entries, so it preserves the componentwise order, and induction gives
ℓ((*I* + *tL*/*n*)^n *F*) ≤ ((1 − *t*/*n*)*I* + (*t*/*n*)*R*_j)^n ℓ(*F*) for *n* ≥ *t*|*Y*|. As *n* → ∞, (*I* + *tL*/*n*)^n → *e*^{tL} in operator norm, *L* being
bounded, each ℓ_z is continuous on L²(λ_j), and ((1 − *t*/*n*)*I* + (*t*/*n*)*R*_j)^n → *e*^{−t(I−R_j)}. ∎

**Theorem 8.5D** (The covariance theorem in L²; Edwin Boston III). *Suppose that ∩_{y∈Y} H_y consists of the constants and that the spectral
radius ρ(R_j) of R_j is less than one. Then for all F and G in L²(λ_j),*

  |λ_j(*FG*) − λ_j(*F*)λ_j(*G*)| ≤ Σ_{x,y∈Y} ℓ_x(*F*) *D*(*x*, *y*) ℓ_y(*G*),   *D* = (*I* − *R*_j)⁻¹ = Σ_{n≥0} *R*_j^n,

*with D entrywise non-negative, and*

  Var_{λ_j}(*F*) ≤ (1 − ρ(*R*_j))⁻¹ Σ_{y∈Y} λ_j( Var_{λ_j}(*F* | *v*_{y^c}) ).

*If moreover Σ_{y′} R_j(y, y′) e^{κ|y−y′|} ≤ α < 1 for every y, then ρ(R_j) ≤ α and D(x, y) ≤ e^{−κ|x−y|}/(1 − α). Under (S) the intersection
∩_y H_y consists of the constants.*

*Proof.* The Dirichlet form of the dynamics is *E*(*F*, *G*) = ⟨*F*, −*LG*⟩ = Σ_y ⟨*Q*_y*F*, *Q*_y*G*⟩, so |*E*(*F*, *G*)| ≤ Σ_y ℓ_y(*F*)ℓ_y(*G*). The kernel of *L*
is ∩_y *H*_y, since *LF* = 0 gives Σ_y ‖*Q*_y*F*‖² = ⟨*F*, −*LF*⟩ = 0; it consists of the constants by assumption, so the spectral theorem for the
bounded self-adjoint operator *L* ≤ 0 gives *P*_t*G* → λ_j(*G*) in L²(λ_j) as *t* → ∞. Since λ_j(*FG*) = ⟨*F̄*, *G*⟩ and
(*d*/*dt*)⟨*F̄*, *P*_t*G*⟩ = −*E*(*F̄*, *P*_t*G*),

  λ_j(*FG*) − λ_j(*F*)λ_j(*G*) = ∫₀^∞ *E*(*F̄*, *P*_t*G*) *dt*,

and by Proposition 8.5C, with ℓ_y(*F̄*) = ℓ_y(*F*), |*E*(*F̄*, *P*_t*G*)| ≤ Σ_y ℓ_y(*F*)(*e*^{−t(I−R_j)}ℓ(*G*))_y. The matrix *R*_j is symmetric with non-negative
entries and spectral radius less than one, so *e*^{−t(I−R_j)} = *e*^{−t}*e*^{tR_j} has non-negative entries and ∫₀^∞ *e*^{−t(I−R_j)} *dt* =
(*I* − *R*_j)⁻¹ = Σ_n *R*_j^n; this is the covariance bound. For the variance, (*d*/*dt*)‖*P*_t*F* − λ_j(*F*)‖² = −2*E*(*P*_t*F*, *P*_t*F*) = −2|ℓ(*P*_t*F*)|²,
with |·| the euclidean norm on ℝ^Y; the componentwise domination of Proposition 8.5C by a non-negative vector gives
|ℓ(*P*_t*F*)| ≤ |*e*^{−t(I−R_j)}ℓ(*F*)| ≤ *e*^{−t(1−ρ(R_j))}|ℓ(*F*)|, the largest eigenvalue of the symmetric non-negative *R*_j being its spectral radius,
and integration over [0, ∞) gives Var(*F*) ≤ (1 − ρ(*R*_j))⁻¹|ℓ(*F*)|², which is the second inequality. Under the weighted row-sum bound put
*R̃*(*y*, *y*′) = *R*_j(*y*, *y*′)*e*^{κ|y−y′|}, with row sums at most α; since |*y* − *y*″| ≤ |*y* − *y*′| + |*y*′ − *y*″|, induction on *n* gives
*R*_j^n(*y*, *y*′)*e*^{κ|y−y′|} ≤ *R̃*^n(*y*, *y*′), and the row sums of *R̃*^n are at most α^n, so *D*(*x*, *y*)*e*^{κ|x−y|} ≤ Σ_n α^n = 1/(1 − α), while
ρ(*R*_j) is at most the largest row sum of *R*_j, hence at most α. Under (S), λ_j and ∏*m* have the same null sets; a function in ∩_y *H*_y agrees
∏*m*-almost everywhere, for each *y*, with a function not depending on *v*_y, and integrating out the coordinates one at a time with Fubini's
theorem on the product measure shows that it is ∏*m*-almost everywhere constant. ∎[[fn:The variance inequality of Theorem 8.5D, in the
sharper quadratic form Var(*F*) ≤ ℓ(*F*)ᵀ(*I* − *R*_j)⁻¹ℓ(*F*), is M. Kassabov's theorem on arrangements of subspaces, "Subspace arrangements and
property T", *Groups Geom. Dyn.* 5 (2011), 445–477, Theorem 5.1, read for the arrangement of the subspaces *H*_y, whose pairwise angles there
are Friedrichs' angles, the intersections factored out (Lemma 8.5B). For the heat-bath dynamics of a Gibbs measure, R. Peyre, "Tensorizing
maximal correlations", arXiv:1004.1602 (2010), Corollary 4.2.12, gives the spectral gap (1 − ‖ε‖)₊² for a matrix ε bounding the maximal
correlations of two sites under the conditional laws given every subset of the other sites. For two blocks the rate is the squared maximal
correlation between them: J. S. Liu, W. H. Wong and A. Kong, "Covariance structure of the Gibbs sampler with applications to the comparisons
of estimators and augmentation schemes", *Biometrika* 81 (1994), 27–40; Y. Amit, "On rates of convergence of stochastic relaxation for
Gaussian and non-Gaussian distributions", *J. Multivariate Anal.* 38 (1991), 82–99, which computes such rates as products of projections
through the angles between subspaces, and "Convergence properties of the Gibbs sampler for perturbations of Gaussians", *Ann. Statist.* 24
(1996), 122–140. The covariance bound in total variation, with Dobrushin's oscillations in place of the local fluctuations and his
interdependence matrix in place of *R*_j, is H. Föllmer's, "A covariance estimate for Gibbs measures", *J. Funct. Anal.* 46 (1982), 387–395,
and H. Künsch's, "Decay of correlations under Dobrushin's uniqueness condition and its applications", *Comm. Math. Phys.* 84 (1982),
207–222. The two-sided covariance bound in L², with the exponential decay of (*I* − *R*_j)⁻¹ under the weighted row sums, is this paper's; it
does not follow from the quadratic form, which by polarisation loses the decay, and it is the form Theorem 8.5′ uses.]]

**Proposition 8.5E** (The currency inequality). *With versions of the conditional laws λ_j(dv_y | v) defined for every coarse configuration,
as in (8.5), for distinct y and y′*

  *R*_j(*y*, *y*′)² ≤ *C*^λ_j(*y*, *y*′) *C*^λ_j(*y*′, *y*),   so that   *R*_j(*y*, *y*′) ≤ ½( *C*^λ_j(*y*, *y*′) + *C*^λ_j(*y*′, *y*) ).

*For a translation-covariant coarse map, Hypothesis I therefore implies Hypothesis I′ with the same κ and α. When V has two points, at
λ_j-almost every environment ξ at which both coordinates charge both points, ρ_ξ(y, y′)² = C_ξ(y | y′) C_ξ(y′ | y) in the notation of the
proof: the inequality of the proof cannot be improved.*

*Proof.* Fix *y* ≠ *y*′ and an environment ξ, and write *X* = *v*_y, *Y* = *v*_{y′}. For λ_j-almost every ξ the single-site laws of (8.5) at the
configurations (*X*, *Y*, ξ) are conditional laws of π_ξ, and the operator *M*,

  *Mg*(*b*) = ∫ λ_j(*dv*_y | *Y* = *b*, ξ) ∫ λ_j(*dv*_{y′} | *X* = *v*_y, ξ) *g*(*v*_{y′}),

which goes from *Y* to *X* and back, is a Markov kernel defined at every point, self-adjoint on L²(π_ξ^Y), π_ξ^Y the law of *Y* under π_ξ, with
norm ρ_ξ(*y*, *y*′)² on the functions of mean zero: it is *T*\**T* for the conditional expectation *T* from functions of *Y* to functions of *X*,
whose norm on the functions of mean zero is the maximal correlation. Its kernel is the composition of two kernels whose Dobrushin
coefficients are *C*_ξ(*y* | *y*′) = sup_{b,b′} ‖λ_j(*dv*_y | *Y* = *b*, ξ) − λ_j(*dv*_y | *Y* = *b*′, ξ)‖_TV ≤ *C*^λ_j(*y*, *y*′) and
*C*_ξ(*y*′ | *y*) ≤ *C*^λ_j(*y*′, *y*), and Dobrushin's coefficient is submultiplicative, so δ(*M*) ≤ *C*^λ_j(*y*, *y*′)*C*^λ_j(*y*′, *y*). It remains to show
that the norm of *M* on the functions of mean zero is at most δ(*M*). For a bounded *g* of mean zero and *n* ≥ 1 the oscillation argument of
Proposition 8.1 gives osc(*M*^n*g*) ≤ δ(*M*)^n osc(*g*), and *M*^n*g* has mean zero, so its L² norm is at most sup|*M*^n*g*| ≤ osc(*M*^n*g*). If the
spectral projection *E* of the self-adjoint *M*, restricted to the functions of mean zero, onto {|λ| ≥ δ(*M*) + ε} were not zero for some ε > 0,
there would be a bounded *g* of mean zero with *Eg* ≠ 0, the bounded functions being dense, and ‖*M*^n*g*‖ ≥ (δ(*M*) + ε)^n‖*Eg*‖ would contradict
‖*M*^n*g*‖ ≤ δ(*M*)^n osc(*g*) for large *n*. Hence ρ_ξ(*y*, *y*′)² ≤ *C*^λ_j(*y*, *y*′)*C*^λ_j(*y*′, *y*) for λ_j-almost every ξ, which is the first assertion,
and the arithmetic–geometric mean inequality gives the second. For a translation-covariant coarse map the blocked measure is invariant under
the translations of *Y*, so *C*^λ_j(*y*, *y*′) depends on *y*′ − *y* alone and the weighted column sums of *C*^λ_j equal its weighted row sums; then
Σ_{y′} *R*_j(*y*, *y*′)*e*^{κ|y−y′|} ≤ ½ Σ_{y′} (*C*^λ_j(*y*, *y*′) + *C*^λ_j(*y*′, *y*))*e*^{κ|y−y′|} ≤ α. When *V* = {0, 1}, write *p*_{ab} for the probability
of *X* = *a*, *Y* = *b* under π_ξ, *p*_{a·} and *p*_{·b} for its marginals, and Δ = *p*₁₁*p*₀₀ − *p*₁₀*p*₀₁; every function of a two-point variable is
affine in its indicator, so ρ_ξ = |Δ|/(*p*_{1·}*p*_{0·}*p*_{·1}*p*_{·0})^{1/2}, while *C*_ξ(*y* | *y*′) = |*p*₁₁/*p*_{·1} − *p*₁₀/*p*_{·0}| = |Δ|/(*p*_{·1}*p*_{·0}) and
*C*_ξ(*y*′ | *y*) = |Δ|/(*p*_{1·}*p*_{0·}), whose product is ρ_ξ². ∎

---

## 4. The reduction in L²

**Theorem 8.5′** (The reduction of the gap to the blocked bound, in L²). *Let a construction be as in Theorem 7.4, with any fixed integer
L ≥ 2, blocked at the coarse scale a_c with a coarse map as above satisfying (S), and suppose Hypotheses I′ and II′. Put ρ = max(e^{−κ}, ρ′).
Then for every ρ₁ with ρ < ρ₁ < 1 there is a constant K, depending on ρ, ρ₁, α, K′, N(f), N(g), ‖f‖ and ‖g‖ and on nothing else, such that
at every rung j ≥ j₀, on every lattice of the construction, for all bounded observables f and g, |S_j(fg) − S_j(f) S_j(g)| ≤ K ρ₁^d, with d
the distance between S(f) and S(g); and every limit point of the construction's Schwinger functions, on the sector generated by the
observables that are bounded uniformly in j, has a unique vacuum and a Hamiltonian with no spectrum in (0, m), where m is the number of
(8.8):*

  *m* = (1/*a*_c) min( κ, log(1/ρ′) ).

*Proof.* Fix *j* ≥ *j*₀, a lattice, and bounded observables *f* and *g*; write *F*(*v*) = ν_j(*f* | *v*) and *G*(*v*) = ν_j(*g* | *v*) for their fibre
means, bounded by ‖*f*‖ and ‖*g*‖. The covariance splits along the coarse map, by the law of total covariance:

  μ_j(*fg*) − μ_j(*f*)μ_j(*g*) = [λ_j(*FG*) − λ_j(*F*)λ_j(*G*)] + λ_j( ν_j(*fg* | ·) − *FG* ).

The second term is at most *K*′*N*(*f*)‖*f*‖‖*g*‖ρ′^d by Hypothesis II′(a). For the first, Hypothesis I′ gives ρ(*R*_j) ≤ α < 1 and
*D*(*i*, *y*) ≤ *e*^{−κ|i−y|}/(1 − α), (S) identifies ∩_y *H*_y with the constants, and Theorem 8.5D gives |λ_j(*FG*) − λ_j(*F*)λ_j(*G*)| ≤
Σ_{i,y} ℓ_i(*F*)*D*(*i*, *y*)ℓ_y(*G*). By Hypothesis II′(b), ℓ_i(*F*) ≤ *K*′*N*(*f*)‖*f*‖ρ′^{r_i} and ℓ_y(*G*) ≤ *K*′*N*(*g*)‖*g*‖ρ′^{r′_y}, with *r*_i the distance from *i*
to *S*(*f*) and *r*′_y that from *y* to *S*(*g*), so that

  |λ_j(*FG*) − λ_j(*F*)λ_j(*G*)| ≤ (*K*′² *N*(*f*) *N*(*g*) ‖*f*‖ ‖*g*‖/(1 − α)) Σ_{i,y} ρ^{e(i,y)},   *e*(*i*, *y*) = *r*_i + |*i* − *y*| + *r*′_y,

ρ = max(*e*^{−κ}, ρ′) bounding the base of each of the three factors. By the triangle inequality *e*(*i*, *y*) ≥ *d*, and the number of pairs
(*i*, *y*) with *e*(*i*, *y*) ≤ *n* is at most *N*(*f*)*N*(*g*)(2*n* + 1)⁸, since *i* then lies within distance *n* of *S*(*f*) and *y* within distance *n* of
*S*(*g*). Hence the last sum is at most *N*(*f*)*N*(*g*) Σ_{n≥d} (2*n* + 1)⁸ ρ^n, which is ρ^d times a polynomial in *d* and is therefore at most
*K*₁ρ₁^d for every ρ₁ ∈ (ρ, 1), with *K*₁ depending on ρ, ρ₁, *N*(*f*) and *N*(*g*). Adding the second term gives the covariance inequality, with
*K* = *K*′²*N*(*f*)*N*(*g*)‖*f*‖‖*g*‖*K*₁/(1 − α) + *K*′*N*(*f*)‖*f*‖‖*g*‖.

For the gap, let *f* be an observable, bounded uniformly in *j*, whose links lie in the time interval [0, *w*]. The links of θ*f̄* lie in [−*w*, 0]
and those of τ_t*f* in [*t*, *t* + *w*]; the block boundaries in time are the multiples of *a*_c and a link belongs to the block of its midpoint, so
*S*(θ*f̄*) lies in blocks of time index at most 0, *S*(τ_t*f*) in blocks of time index at least ⌊*t*/*a*_c⌋, and the distance between them is at
least ⌊*t*/*a*_c⌋ ≥ *t*/*a*_c − 1. For *t* ∈ *D* and all large *j*, *t* is an integer multiple of *a*_j; the measure μ_j is invariant under the
reflection θ and under the translation τ_t, so μ_j(θ*f̄*) is the complex conjugate of μ_j(*f*) and μ_j(τ_t*f*) = μ_j(*f*), and the covariance
inequality gives *S*_j(θ*f̄* · τ_t*f*) − |*S*_j(*f*)|² ≤ (*K*/ρ₁)*e*^{−m₁t} with *m*₁ = log(1/ρ₁)/*a*_c, the constant independent of *j* and of the lattice
because *N*(*f*) and ‖*f*‖ are. This is the hypothesis of Theorem 7.4 with *r*_j = 0 at every *t* ∈ *D*, so Theorem 7.4 leaves no spectrum in
(0, *m*₁) for every ρ₁ ∈ (ρ, 1), hence none in (0, *m*) with *m* = log(1/ρ)/*a*_c, which is (8.8). ∎

Theorem 8.5′ contains Theorem 8.5 for every translation-covariant coarse map satisfying (S), which Theorem 8.5 itself does not need: under
Hypotheses I and II and (S), the hypotheses of Theorem 8.5′ hold with the same constants, by Proposition 8.5E and the remark after
Hypothesis II′, and its conclusion is the same, the factor 3 that the tilt by *G*′ puts into *K* in the proof of Theorem 8.5 being absent. Reflection positivity enters the proof only through Theorem 7.4, applied to the
lattice measures μ_j; the blocked measure is not required to be reflection positive, and the step μ_j(θ*f̄*)μ_j(τ_t*f*) = |μ_j(*f*)|² uses the
reflection invariance of μ_j alone. The fibre clause enters only through the λ_j-mean of the fibre covariance and the L²(λ_j) local
fluctuations of the fibre means; that is why its average suffices, and why the matrix of the coarse variables must be read in the same
currency, Dobrushin's comparison theorem consuming the supremum oscillations δ_y.

---

## 5. The fourth link in L²

**Proposition 8.4′** (The tilt lemma in L²; Edwin Boston III). *Let π be the law of a pair (X, Y) of random variables with values in compact
metric spaces, δ a bounded measurable function of (x, y), and π′ = e^δ π/π(e^δ) the tilt of π by δ. Put o_X = sup_y osc_x δ(x, y),
o_Y = sup_x osc_y δ(x, y), and Δ = sup_{y,y′} osc_x (δ(x, y) − δ(x, y′)), the mixed second difference of δ in the sense of Proposition 8.4.
Then the maximal correlations of the two laws satisfy*

  ρ(π′) ≤ *e*^{(o_X + o_Y)/2} ρ(π) + 1 − *e*^{−2Δ}.   (8.7′)

*Proof.* If (*X*, *Y*) is almost surely constant under π, both maximal correlations vanish and there is nothing to prove; otherwise three
facts. First, for every law π of (*X*, *Y*) under which (*X*, *Y*) is not almost surely constant,

  1 − ρ(π) = inf { [π(Var_π(*F* | *X*)) + π(Var_π(*F* | *Y*))] / Var_π(*F*) : *F* ∈ L²(π) not constant }.

Let *P*_X and *P*_Y be the conditional expectations onto the functions of *X* and of *Y*, orthogonal projections on L²(π), so that the
numerator is ‖*F* − *P*_X*F*‖² + ‖*F* − *P*_Y*F*‖² = ⟨*F*, (2*I* − *P*_X − *P*_Y)*F*⟩. If ρ(π) < 1, the ranges of *P*_X and *P*_Y meet in the constants, a
nonconstant function of *X* almost surely equal to a function of *Y* having correlation one with it, and the cosine of Friedrichs' angle between
them is ρ(π); in the decomposition of Lemma 8.5A, *P*_X + *P*_Y has spectrum {1 ± cos θ} on the generic part, 1 on the two mixed summands and 0
on ker *P*_X ∩ ker *P*_Y, and since *X* or *Y* is not almost surely constant, the generic part or a mixed summand is not zero; so the spectrum of
*P*_X + *P*_Y off the constants has supremum 1 + ρ(π), and the infimum above is 1 − ρ(π). If ρ(π) = 1, either the
two ranges share a nonconstant function, at which the quotient vanishes, or the cosine is one and the same decomposition makes the infimum
zero. Second, if π″ = *h*π with *a* ≤ *h* ≤ *b* for constants 0 < *a* ≤ *b*, then 1 − ρ(π″) ≥ (*a*/*b*)(1 − ρ(π)): indeed
π″(Var_{π″}(*F* | *X*)) = inf_c π″((*F* − *c*(*X*))²) ≥ *a* inf_c π((*F* − *c*(*X*))²) = *a* π(Var_π(*F* | *X*)), the infimum over functions *c* of *X*, the
same holds with *Y*, and Var_{π″}(*F*) = inf_c π″((*F* − *c*)²) ≤ *b* Var_π(*F*); the first fact finishes. Third, if π₁ = (*u* ⊗ *w*)π/π(*u* ⊗ *w*) for
bounded functions *u* of *x* and *w* of *y* with positive infima, then ρ(π₁) ≤ (sup *u* · sup *w*/(inf *u* · inf *w*))^{1/2} ρ(π). Write
β(*x*) = π(*w*(*Y*) | *X* = *x*), ζ(*y*) = π(*u*(*X*) | *Y* = *y*) and *Z* = π(*u* ⊗ *w*); the laws of *X* and *Y* under π₁ have densities *u*β/*Z* and *w*ζ/*Z*
with respect to those under π, so the maps *f* ↦ *f*(*u*β/*Z*)^{1/2} and *g* ↦ *g*(*w*ζ/*Z*)^{1/2} are unitary from L²(π₁^X) onto L²(π^X) and from
L²(π₁^Y) onto L²(π^Y), and π₁(*f*(*X*)*g*(*Y*)) = π(*a*₁ *f̃*(*X*) · *a*₂ *g̃*(*Y*)) with *f̃*, *g̃* the images and *a*₁ = (*u*/β)^{1/2}, *a*₂ = (*w*/ζ)^{1/2}.
Hence the operator *T*₁ of π₁, *T*₁*g* = π₁(*g*(*Y*) | *X*), is unitarily equivalent to *a*₁*Ta*₂, *T* the operator of π and *a*₁, *a*₂ acting by
multiplication. For each of these laws the operator maps the constants to the constants and the functions of mean zero to the functions of
mean zero, so it is the orthogonal sum of the identity on the constants and its restriction to mean zero, whose norm is the maximal
correlation; the maximal correlation is therefore the second singular number inf{‖*A* − *E*‖ : rank *E* ≤ 1} of the operator. Writing
*T* = 1 ⊗ 1 + *T*₀ with ‖*T*₀‖ = ρ(π), the operator *a*₁*Ta*₂ is a rank-one operator plus *a*₁*T*₀*a*₂, so its second singular number, which is ρ(π₁), is
at most ‖*a*₁‖_∞‖*a*₂‖_∞ρ(π); and β ≥ inf *w*, ζ ≥ inf *u* give ‖*a*₁‖_∞‖*a*₂‖_∞ ≤ (sup *u* · sup *w*/(inf *u* · inf *w*))^{1/2}. Now fix (*x*₀, *y*₀) and write
δ(*x*, *y*) = δ(*x*, *y*₀) + (δ(*x*₀, *y*) − δ(*x*₀, *y*₀)) + δ₁₂(*x*, *y*), where δ₁₂(*x*, *y*) = (δ(*x*, *y*) − δ(*x*, *y*₀)) − (δ(*x*₀, *y*) − δ(*x*₀, *y*₀)) is at most Δ in
modulus. The tilt by the first two terms is a tilt by *u* ⊗ *w* with sup *u*/inf *u* ≤ *e*^{o_X} and sup *w*/inf *w* ≤ *e*^{o_Y}, so the third fact gives
ρ(π₁) ≤ *e*^{(o_X+o_Y)/2}ρ(π); the tilt of π₁ by δ₁₂ has a density between two constants of ratio at most *e*^{2Δ}, so the second fact gives
1 − ρ(π′) ≥ *e*^{−2Δ}(1 − ρ(π₁)). Hence ρ(π′) ≤ *e*^{−2Δ}ρ(π₁) + 1 − *e*^{−2Δ} ≤ *e*^{(o_X+o_Y)/2}ρ(π) + 1 − *e*^{−2Δ}. ∎[[fn:The second fact is the
perturbation argument of R. Holley and D. Stroock, "Logarithmic Sobolev inequalities and stochastic Ising models", *J. Stat. Phys.* 46 (1987),
1159–1194, read for the two-site heat bath.]]

The oscillations along each variable enter (8.7′) as a factor and the mixed difference as an addend, as in (8.7); an addend carrying the
oscillations would not vanish for a pair on which δ has no joint term, while 1 − *e*^{−2Δ} does, and it is the addends that the weighted
row sums of Corollary 8.5F add up.

**Corollary 8.5F** (The effective action and the fourth link, in L²). *(i) When the effective action A_j of (S) is bounded and the conditional
laws λ_j(dv_y | v) ∝ e^{−A_j(v)} m(dv_y) are used in (8.5), R_j(y, y′) ≤ 1 − e^{−Δ_{yy′}(A_j)} for distinct y and y′, with Δ_{yy′}(A_j) the mixed
second difference of the effective action in the sense of Proposition 8.4. (ii) Let the blocked measures of rungs j ≥ j₁ on a common coarse
torus be tilts λ_j = e^{δ_j}λ_{j₁}/λ_{j₁}(e^{δ_j}) of that of the rung j₁ by bounded functions δ_j. Then*

  *R*_j(*y*, *y*′) ≤ *e*^{(o_y(δ_j) + o_{y′}(δ_j))/2} *R*_{j₁}(*y*, *y*′) + 1 − *e*^{−2Δ_{yy′}(δ_j)},

*with o_y and Δ_{yy′} as in Proposition 8.4; consequently, if o_j = sup_y o_y(δ_j) and sup_y Σ_{y′}(1 − e^{−2Δ_{yy′}(δ_j)}) e^{κ|y−y′|} tend to zero,
Hypothesis I′ at the rung j₁ with the constant α₁ implies it at every sufficiently late rung with any α ∈ (α₁, 1).*

*Proof.* (i) The conditional laws λ_j(*dv*_y | *v*) ∝ *e*^{−A_j(v)}*m*(*dv*_y) are defined for every *v* when *A*_j is bounded, the normalisations lying
between *e*^{−sup A_j} and *e*^{−inf A_j}, and (8.5) and Proposition 8.5E are read with them. The conditional law of *v*_y under one of two coarse
configurations differing only at *y*′ is the tilt of its conditional law under the other by the difference of the two actions, so the first
inequality of Proposition 8.4 gives *C*^λ_j(*y*, *y*′) ≤ 1 − *e*^{−Δ_{yy′}(A_j)}. The mixed
difference is the supremum of |*A*_j(*a*, *b*) − *A*_j(*a*, *b*′) − *A*_j(*a*′, *b*) + *A*_j(*a*′, *b*′)| over the values *a*, *a*′ of *v*_y, *b*, *b*′ of *v*_{y′} and the
environment, so Δ_{yy′}(*A*_j) = Δ_{y′y}(*A*_j), and Proposition 8.5E gives *R*_j(*y*, *y*′) ≤ (*C*^λ_j(*y*, *y*′)*C*^λ_j(*y*′, *y*))^{1/2} ≤ 1 − *e*^{−Δ_{yy′}(A_j)}.
(ii) The measures λ_j and λ_{j₁} are equivalent, with density proportional to *e*^{δ_j}, so for λ_j-almost every environment ξ the conditional law of
(*v*_y, *v*_{y′}) under λ_j is the tilt of that under λ_{j₁} by δ_j(·, ·, ξ), whose oscillations along *v*_y and *v*_{y′} are at most *o*_y(δ_j) and *o*_{y′}(δ_j)
and whose mixed difference is at most Δ_{yy′}(δ_j); Proposition 8.4′ and the essential supremum over ξ give the bound. Weighting and summing,
Σ_{y′} *R*_j(*y*, *y*′)*e*^{κ|y−y′|} ≤ *e*^{o_j}α₁ + Σ_{y′}(1 − *e*^{−2Δ_{yy′}(δ_j)})*e*^{κ|y−y′|}, which is below any α ∈ (α₁, 1) once the two tails are small. ∎

Corollary 8.5F (ii) is the fourth link of §8.1 in the L² currency, with the inputs that (8.7) asks of the tilts in total variation: their
oscillations and their weighted mixed differences tending to zero.

---

## 6. What the widening costs

The widened setting costs three conditions, each used at a named place. First, Theorem 7.4 uses the reflection positivity of the lattice
measures μ_j, which needs an even number of lattice sites in the time direction; the even number of blocks in the time direction asked in the
setting provides it at every rung, and for even *L* it holds at every rung with *K*_j ≥ 1 whatever the number of blocks. Second, (S) is used in
the proofs only to identify
∩_y *H*_y with the constants, in Theorem 8.5D and through it in Theorem 8.5′, and to name the effective action that Corollary 8.5F (i)
reads; for a coarse map whose blocked law is not of the form (S), Theorem 8.5D and Theorem 8.5′ hold verbatim with (S) replaced by that
identification. Third, the passage from Hypothesis I to Hypothesis I′ uses translation covariance, through the equality of the weighted row
and column sums of *C*^λ_j; without it, Hypothesis I′ holds with ½(α + α*) in place of α, α* a bound on the weighted column sums, which must
satisfy α + α* < 2. Nothing in the proofs of Theorem 8.5′, Theorem 8.5D, Propositions 8.4′, 8.5C and 8.5E, Corollary 8.5F, or Lemmas 8.5A and
8.5B uses that *v*_y is a function of the links of *B*_y, that the coarse map is a bijection of block configurations, or the value of *L*.
Apart from Proposition 8.5E and Corollary 8.5F (i), whose subject is the matrix (8.5), none of them asks for a version of a conditional law
beyond λ_j-almost every coarse configuration; Hypotheses I and II and the matrix (8.5) use versions defined for every coarse configuration.
