
## 3. FIVE LEMMAS THE PROOF RUNS ON (each PROVED here)

### 3.1 LEMMA SD — THE SUPPORT DECOMPOSITION (PROVED)

SETTING. S a finite set of decoupling cubes; Ω a countable set of walks; for ω ∈ Ω a set c(ω) of decoupling cubes it touches and a
monomial m_ω(s) := Π_{Δ∈c(ω)} s(Δ) (CMP 116 p. 3: each walk is multiplied by s(Δ₁)⋯s(Δ_m), each touched cube ONCE); h_ω ∈ 𝔅, a
complex Banach space (for CMP 116: the product of the operator spaces of H, G̃, H₀ under the maximum of all the norms of
Theorems 3.1–3.10 [13], in which (1.7) holds term by term); H(s) := Σ_ω m_ω(s)h_ω. Φ: {h ∈ 𝔅 : ‖h‖ < R} → 𝔉 holomorphic, 𝔉 a
complex Banach space (for CMP 116: bounded analytic functions of (U, J, B) on Bałaban's domain, sup norm), ‖Φ‖ ≤ K_Φ. Write L_n for
the symmetric n-linear form with Φ(h) = Σ_n L_n[h, …, h] near 0. Let w: Ω → [1, ∞) and put B_w := Σ_ω ‖h_ω‖w(ω).

LEMMA SD. Assume eB_w < R and w(ω) ≥ (1+η)^{|c(ω)|} for some η > 0. Put F(s) := Φ(H(s)) and, for the cubes of S,
F_S := ∫_{[0,1]^S} Π_{Δ∈S} ds(Δ) ∂^S F(s)|_{s = 0 off S}. Then
 (i) F is real-analytic on a neighbourhood of [0,1]^S, and F_S = Σ_{T⊆S} (−1)^{|S∖T|} F(1_T) (1_T: s = 1 on T, 0 elsewhere);
 (ii) F_S = Σ_{n≥0} Σ_{(ω₁,…,ω_n): c(ω₁)∪⋯∪c(ω_n) = S} L_n[h_{ω₁}, …, h_{ω_n}], absolutely convergent: EVERY MULTILINEAR TERM LANDS IN
   EXACTLY ONE POLYMER, ITS SUPPORT;
 (iii) if a ≥ 0, N₀ ≥ 0 and every tuple with L_n[h_{ω₁}, …] ≠ 0 satisfies |∪_i c(ω_i)| ≤ N₀ + a⁻¹Σ_i ln w(ω_i), then
   Σ_S e^{a|S|} ‖F_S‖ ≤ e^{aN₀} K_Φ (1 − eB_w/R)⁻¹,  the sum over ALL finite S.
PROOF. Polarization: ‖L_n[h₁, …, h_n]‖ ≤ (nⁿ/n!) K_Φ R⁻ⁿ Π‖h_i‖ ≤ eⁿ K_Φ R⁻ⁿ Π‖h_i‖ (the n-homogeneous term is bounded by K_Φ(‖h‖/R)ⁿ by
Cauchy's estimate on the disc z ↦ Φ(zh), and the polarization formula costs nⁿ/n!). For s in the polydisc |s(Δ)| ≤ 1 + η,
|m_ω(s)| ≤ (1+η)^{|c(ω)|} ≤ w(ω), so Σ_n Σ_{ω₁…ω_n} Π|m_{ω_i}(s)|‖L_n[h_{ω₁}, …]‖ ≤ K_Φ Σ_n (eB_w/R)ⁿ < ∞: the multilinear series of
Φ(H(s)) converges absolutely and uniformly there, so F is holomorphic on that polydisc, in particular real-analytic near [0,1]^S.
(i) is the iterated fundamental theorem of calculus, ∫₀¹ds(Δ)∂_{s(Δ)}G = G|_{s(Δ)=1} − G|_{s(Δ)=0}, one cube at a time.
(ii) For a tuple put U := ∪c(ω_i). At s = 1_T, Π_i m_{ω_i}(1_T) = 1 if U ⊆ T and 0 otherwise — whatever the multiplicity with which a cube
is touched, because 1ᵏ = 1 and 0ᵏ = 0 for k ≥ 1. With s = 0 off S a tuple with U ⊄ S vanishes for every T ⊆ S; for U ⊆ S,
Σ_{T⊆S}(−1)^{|S∖T|}1_{U⊆T} = Σ_{U⊆T⊆S}(−1)^{|S∖T|} = (1 − 1)^{|S∖U|} = 1_{U=S}. Absolute convergence lets the finite alternating sum
pass inside the series.
(iii) Σ_S e^{a|S|}‖F_S‖ ≤ Σ_n Σ_{tuples, L_n ≠ 0} e^{a|∪c(ω_i)|}‖L_n[…]‖ ≤ e^{aN₀} Σ_n eⁿK_ΦR⁻ⁿ Π_i(Σ_{ω_i}‖h_{ω_i}‖w(ω_i)) by (ii), the
hypothesis and polarization. ∎
REMARK. No s-derivative is ever bounded. The sum over polymers costs NOTHING: Bałaban's (1.27) spends e^{−½(κ₁−1)} on each of up to
8·12³ cubes to sum over subsets, because a Cauchy bound bounds every subset by the same supremum; here a multilinear term is counted
once, in the one polymer it belongs to.

### 3.2 LEMMA C — LOCALITY OF THE MULTILINEAR COEFFICIENTS (PROVED GIVEN Bałaban's p. 4 locality statement)

Let Φ be one of CMP 116's functionals — D(H, A′) of (1.3), A₀(H, G̃, H₀B′) of (1.4), H_k of (1.2)/(1.17), or E(□₀, ·) evaluated at
them — and x the region where the output is read (□₀ for E(□₀, ·); a point for H_k(x)). Two walks are LINKED if their kernel supports
lie within distance r_loc, the range of the local functions C, V₀ of (1.3)–(1.4) and of B ↦ B′ (I.3.2).
LEMMA C. L_n[h_{ω₁}, …, h_{ω_n}] = 0 unless {ω₁, …, ω_n} ∪ {x} is linked-connected.
PROOF. Suppose the walks split into G₁ (those linked-connected to x) and G₂ ≠ ∅ with dist(supp G₂, supp G₁ ∪ x) > r_loc. Put
h = Σ_{i∈G₁}z_ih_{ω_i} + Σ_{i∈G₂}z_ih_{ω_i}, |z| small, and let R₁ be the r_loc-neighbourhood of supp G₁ ∪ x. For y ∈ R₁ the G₂-kernels
vanish at y, so the fixed-point equations (1.3)–(1.4) restricted to R₁ form a closed system in the G₁-operators and the local
functions; it is a contraction on the restricted ball, so by uniqueness the solution restricted to R₁ is the solution of the
G₁-system, independent of (z_i)_{i∈G₂}. This is Bałaban's p. 4 argument ("the solution D(H(s), A′) restricted to the interior of a
component depends on A′, H(s), hence s, restricted to this component"), which uses only that kernels vanish off a region. The output
read in x ⊂ R₁ is then independent of z_i for i ∈ G₂, and ∂_{z₁}⋯∂_{z_n}Φ(h)|_{z=0} = n!L_n[h_{ω₁}, …] = 0 (distinct walks; repeated
walks by the same argument on the coefficient of Π z_i^{k_i}). ∎

### 3.3 LEMMA G — WALK GEOMETRY: THE DECAY PER CUBE COMES FROM THE WALKS (PROVED)

r′: the radius of an enlarged localization domain X̃⁵ of a walk (r′ ≤ c₅M₁, the domains being "unions of connected families
containing several cubes from π_k(1)", p. 3); d(ω): the length of a shortest tree graph intersecting all localization domains of ω
(p. 5); L₀ := M − 2r′ − 2; λ := 2r′ + r_loc. Lengths in lattice units; M-cubes closed.
LEMMA G. (i) If K ⊂ N_{r′}(T) for a tree T of length ℓ, K meets at most 2^d·max(1, ⌈2ℓ/L₀⌉) M-cubes.
(ii) If moreover K contains a point x with dist(x, ∪ decoupling cubes) > L₀/2 + r′, K meets at most 2^{d+1}ℓ/L₀ decoupling cubes; in
general at most 2^{d+1}ℓ/L₀ + 2^d·1[dist(x, decoupling cubes) ≤ L₀/2 + r′].
(iii) For a linked-connected family {ω₁, …, ω_n} ∪ {x}: K := ∪supp ω_i ∪ {x} ⊂ N_{r′}(T) with length(T) ≤ Σ_i (d(ω_i) + λ).
(iv) Consequently, with w(ω) := exp(a2^{d+1}(d(ω) + λ)/L₀), every nonvanishing tuple satisfies |∪c(ω_i)| ≤ N₀ + a⁻¹Σ_i ln w(ω_i) with
N₀ = 2^d·1[x within L₀/2 + r′ of a decoupling cube]; and if δ₀L₀ ≥ 2^{d+1}a and 2^{d+1}aλ ≤ L₀ln(1+η), then by (1.7)
   B_w = Σ_ω‖h_ω‖w(ω) ≤ B₀·sup_ω[M₁^{−½|ω|}e^{−δ₀d(ω)}w(ω)] ≤ (1 + η)B₀.
PROOF. (i) The Euler tour of T has length 2ℓ; cut it into ⌈2ℓ/L₀⌉ arcs of length ≤ L₀ (one point if ℓ = 0). Each arc lies in the ball of
radius L₀/2 about its midpoint, so K lies in ⌈2ℓ/L₀⌉ balls of radius L₀/2 + r′ < M/2. A ball of diameter < M has every coordinate
projection an interval of length < M, which meets at most two closed M-intervals (it contains at most one lattice point jM); so it
meets at most 2^d closed M-cubes. (ii) The arc through x lies in a ball meeting no decoupling cube; the other ⌈2ℓ/L₀⌉ − 1 ≤ 2ℓ/L₀ balls
meet at most 2^d each. (iii) Each walk's kernel support lies in N_{r′}(T_i), T_i a shortest tree of ω_i; linked walks have trees within
2r′ + r_loc of each other; join them (and x) by segments of that length. (iv) is (ii)+(iii) with a·2^{d+1}Σ_i(d(ω_i) + λ)/L₀ = Σ_i ln w(ω_i);
for the walk sum, (1.7) bounds ‖h_ω‖ by [O(1)O(M₁^{−1/2})^{|ω|}]·M₁^{−½|ω|}e^{−δ₀d(ω)}, the bracket summing to B₀ ("the first two
factors … determine the constant B₀", p. 3), and M₁^{−½|ω|}e^{−δ₀d(ω)}w(ω) ≤ e^{a2^{d+1}λ/L₀}e^{−(δ₀ − a2^{d+1}/L₀)d(ω)} ≤ 1 + η. Finally
w(ω) ≥ (1+η′)^{|c(ω)|} with 1 + η′ := e^{a/2^d}... by (i)–(ii) (|c(ω)| ≤ 2^d + 2^{d+1}(d(ω)+λ)/L₀), as Lemma SD requires. ∎
REMARK (Bałaban's own form). p. 5: "If m is big enough, e.g. m > 2⁴, then δ₀d(ω) ≥ δ₁mM … for δ₁M ≥ κ₁" — the same geometry; Lemma G
spends it on decay instead of on surviving the radius e^{κ₁}. The conditions δ₀L₀ ≥ 2^{d+1}a and 2^{d+1}aλ ≤ L₀ln(1+η) are of Bałaban's
own kind ("M ≥ M(κ)", δ₁M ≥ κ₁, δ₀M ≥ κ, e^{−⅓δ₀M}e^{16κ₁} < 1): polynomial in a, M₁, 1/δ₀, with no γ in them.

### 3.4 LEMMA MS — THE MINKOWSKI–STEINER BOUND ON THE LINEAR SIZE (PROVED)

LEMMA MS. For every localization domain Y ∈ D_k made of n(Y) M-cubes, d_k(Y) ≥ (n(Y) − 2^d)/(2^{d−1}√d); at d = 4,
d_k(Y) ≥ (n(Y) − 16)/16. In particular d_k(□̃⁵) ≥ (11⁴ − 16)/16 = 14625/16 = 914.0625, d_k(□̃⁴) ≥ 409.0625, d_k(□̃²) ≥ 38.0625.
PROOF. Rescale so that M-cubes are unit cubes (CMP 109 p. 257: d_j(X) is the length of a shortest tree graph contained in X and
intersecting all the cubes of X, divided by M; the tree may be taken polygonal, "formed by edges of cubes"). Let T be such a tree of
length ℓ and K := [−1, 1]^d. Every closed unit cube Q meeting T at p satisfies Q ⊂ p + K ⊂ T ⊕ K, and distinct cubes have disjoint
interiors, so n(Y) ≤ vol(T ⊕ K). Build T one segment at a time, each new segment [p, q] attached at a point p already present: the
volume added is at most vol(([p,q] ⊕ K) ∖ (p ⊕ K)) = |q − p|·vol_{d−1}(proj_{u⊥}K), u = (q − p)/|q − p| (Steiner's formula for a
segment), and by Cauchy's projection formula vol_{d−1}(proj_{u⊥}[−1,1]^d) = 2^{d−1}Σ_i|u_i| ≤ 2^{d−1}√d. Hence
n(Y) ≤ 2^d + 2^{d−1}√d·ℓ. ∎
(Bałaban's own (2.30), READ p. 18, states (3·2³)⁻¹M⁻⁴|Y| ≤ d_k(Y), i.e. d_k(□̃⁵) ≥ 610.04; Lemma MS is sharper and holds for every n —
(2.30)'s lower half is false for n ≤ 16, where d_k can vanish.)
UPPER COMPANION (PROVED). If Y = N ∪ F with N a family of cubes sharing a common point P and Y face-connected, then d_k(Y) ≤ |F|:
start from the tree {P} ⊂ Y; add the cubes of F in an order in which each is face-adjacent to a cube already present; the tree meets
that neighbour at a point, and a segment of length ≤ 1 inside the neighbour reaches the common (d−1)-face. In particular a family met
by one short chain from one point (Lemma G (i) with one ball: all its cubes share a point) has d_k = 0, and adding a face-connected
family to a domain raises d_k by at most the number of cubes added.

### 3.5 LEMMA F — THE FLOOR OF THE LOCALIZATION SUMS (PROVED)

LEMMA F. Let c_{d−1} be the number of connected induced subgraphs of the (d−1)-cube graph Q_{d−1} containing a fixed vertex. For every
cube □′ ∈ π_j and integer t ≥ 1, N(t) := #{X ∈ D_j : □′ ⊂ X, d_j(X) ≤ t} ≥ (c_{d−1})^t. Hence Σ_{X∈D_j, X⊃□′}e^{−s·d_j(X)} = ∞ for every
s < ln c_{d−1}, and every use of (1.26) at rate s needs s ≥ ln c_{d−1}.
PROOF. Units of M; the edge-line ℓ_t := {(x, 0, …, 0) : 0 ≤ x ≤ t}. For i ∈ {0, …, t−1} and v ∈ {−1, 0}^{d−1} let Q(i, v) be the closed
cube [i, i+1] × Π_m[v_m, v_m + 1]; each Q(i, v) contains the segment [i, i+1] × {0}^{d−1}. Fix v₀ = 0 and choose for each i a set
S_i ⊂ {−1,0}^{d−1} containing v₀, connected in Q_{d−1} (Hamming adjacency). Put X := ∪_i ∪_{v∈S_i} Q(i, v). Q(i,v), Q(i,v′) share a
(d−1)-face iff v, v′ are adjacent in Q_{d−1}, and Q(i, v₀), Q(i+1, v₀) share one; so X is face-connected, X ∈ D_j (CMP 109 p. 257), and
X ⊃ □′ := Q(0, v₀). The tree ℓ_t lies in ∪_iQ(i, v₀) ⊂ X and meets every cube of X, so d_j(X) ≤ t. Distinct (S_0, …, S_{t−1}) give
distinct X, so N(t) ≥ c_{d−1}^t, and Σ_X e^{−s d_j(X)} ≥ N(t)e^{−st} ≥ (c_{d−1}e^{−s})^t → ∞ for s < ln c_{d−1}. ∎
CONSEQUENCE FOR THE PAGE. p. 9 sums the (I.3.7) terms over X ∋ □′ "using the second exponential in (1.32)", e^{−δκd_j(X)}, "and the
inequality (1.26) for δκ sufficiently large"; p. 21 fixes δ = (1/10)(1 − 2L⁻¹). So the printed proof needs δκ ≥ ln c₃:
   κ ≥ 10 ln c₃/(1 − 2/L)                                                                                              (3.1)
is the least κ the page allows. M6 evaluated its chain at κ = 1 (M6 T5 labelled κ₀ EXISTENTIAL); (3.1) makes the floor COMPUTED.
c₃ is computed in run a (§8).
