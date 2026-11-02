
---

## 3. ITEM 2 — THE MEASUREMENT

### 3.0 What can be read exactly, and what cannot (decided before any run)

Hypothesis II′ is a rate (Prop. 2.1(c)). Reading it on SU(2) at β = 2.2 needs the fibre averaged over the coarse measure at coarse
distance ≥ 2, i.e. at least three blocks in a row with their whole fine content integrated against the true law of the outside: in 4D
at L = 2 that is a lattice of ≥ 2·2·2·6 sites, 4·48 = 192 SU(2) links integrated exactly — out of reach of every engine in the tree (the
two-face engine integrates ≤ 40 links with the outside PINNED, and pinning is exactly what §20 showed discards the content). So the
crossover fibre at 2.2 has NO exact reading, and none is claimed. What IS exact:
(A) the GAUSSIAN fibre — the linearised fibre of every theory, the whole fibre of the free field — for every block map, every L, every
d, by an alias (Bloch) decomposition: the fibre's collective rate as a function of the coarse map and the block size, the U(1) control
included (§3.1–3.3);
(B) the single-pair coefficients of the SU(2) fibre at 2.2 in the L² currency (the ess-sup form, exact; §3.4) — the right comparison for
"the sup form is 13.24", and by A1 not a reading of II′.

### 3.1 The Gaussian fibre engine (gfib.c, this directory)

Massless lattice field on ℤ^d, Ĉ(p) = 1/λ(p), λ(p) = Σ_μ 2(1 − cos p_μ). Coarse variable Φ(X) = Σ_z q(z) φ(LX + z) with kernel q:
dec (q = δ₀), box_k (average over the k-dimensional sub-box {0..L−1}^k × {0}^{d−k}), heat:c (q = e^{tΔ}(·, 0), t = cL²). Fine momenta
p_n(K) = (K + 2πn)/L, K the coarse momentum, n ∈ {−L/2+1, …, L/2}^d the aliases; S(K) = Σ_n |q̂(p_n)|² Ĉ(p_n). The fibre covariance
(independent of Φ — Gaussian) between LX + a and LY + b is N^{−d} Σ_K e^{iK(X−Y)} T_ab(K) with, the n = 0 alias treated in closed form
(c₀ = 1/λ₀, w₀ = q̂(p₀), S′, u′ and R′ the sums over n ≠ 0),

  T_ab = R′_ab + [e^{ip₀(a−b)} S′ − e^{ip₀a} w̄₀ ū′_b − u′_a e^{−ip₀b} w₀ − λ₀ u′_a ū′_b] / (|w₀|² + λ₀ S′),

regular at K = 0 (no large cancelling terms). ROAD A: the transverse-summed fibre covariance Σ_{Y_⊥} C_fib(a, L(D e₁ + Y_⊥) + a), the
K_⊥ = 0 sector, by the sum over M₁ values of K₁ (an analytic periodic summand: exponentially accurate), its decay rate per coarse unit
read from successive ratios. ROAD B: the smallest κ > 0 with Den(iκ, K_⊥) = |w₀|²(K) + λ₀S′(K) continued analytically
(|q̂|² → q̂(p)q̂(−p), even in K₁, so real on the imaginary axis) equal to zero, by bisection, scanned over K_⊥. The fibre mean's kernel
E[φ_x | Φ] = Σ_X 𝒦(x, X)Φ(X) has the same denominator, so II′(b)'s rate is road B's κ too.
KNOWN ANSWERS (the engine is not read until they are met): K1 d = 1, dec: the fibre is a chain of independent discrete Brownian bridges —
C_fib = 0 across blocks, a(L − b)/L within (a ≤ b); K2 the constraint reproduced: Σ_z q(z) C_fib(LX + z, y) = 0; K3 the sum rule
Σ_X 𝒦(x, X) = 1 (the constant coarse field has the constant fibre mean); K4 roads A and B agree to 1 %; K5 THEOREM G(a) (§5.1, proved): for
box_d, |C_fib(x, y)| ≤ (2/g_L) e^{−η_L |X₁ − Y₁|}, g_L = 2 − 2cos(π/L), η_L = log(1 + g_L/2) — a reading below the proved rate convicts
the instrument (law 4).

### 3.2 THE STAKES (written 2026-11-02 before the engine exists; none edited after)

κ(L) is the fibre's decay rate per coarse unit (the slowest over K_⊥ and over the coordinate directions).
- S1 (d = 4, box_4, the full block average ≈ Bałaban's): κ(2) ∈ [1.0, 3.5]; UNIFORM: κ(16)/κ(2) ∈ [0.7, 1.3]; κ(L) ≥ η_L everywhere.
- S2 (d = 4, dec): κ(L) ∝ L^{1−d/2} = 1/L: κ(16)/κ(2) ∈ [0.08, 0.2].
- S3 (d = 4, box_1, the line ≈ the holonomy map's scaling): κ ∝ L^{−1/2}: κ(16)/κ(2) ∈ [0.25, 0.5].
- S4 (d = 4, box_2, codimension 2): κ ∝ (log L)^{−1/2}: κ(16)/κ(2) ∈ [0.45, 0.9] (UNGUESSED within the band).
- S5 (d = 4, box_3, codimension 1): uniform: κ(16)/κ(2) ∈ [0.7, 1.3].
- S6 (d = 4, heat:1/8): uniform: κ(16)/κ(2) ∈ [0.7, 1.4].
- S7 (d = 2): dec κ ∝ (log L)^{−1/2}: κ(16)/κ(2) ∈ [0.4, 0.85]; box_2 uniform [0.7, 1.3].
- S8 (d = 3): dec κ ∝ L^{−1/2}: [0.25, 0.5]; box_1 (codim 2) log: [0.45, 0.9]; box_2 (codim 1) uniform [0.7, 1.3].
- S9 (the rule): uniform iff the averaged sub-box has codimension ≤ 1 (k ≥ d − 1); logarithmic at k = d − 2; power L^{−(d−2−k)/2} below.
- S10 (the coupling, a theorem not a run): the Gaussian fibre covariance scales as 1/β, so κ is the same for U(1) at 1.2 (Villain
  spin-wave) and SU(2) at 2.2 linearised: the Gaussian fibre does not see the group.
