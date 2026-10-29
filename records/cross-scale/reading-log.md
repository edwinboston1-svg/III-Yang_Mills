# The per-page reading log behind OPEN/ledger/d4b-the-cross-scale-comparisons.md (iii-43, 29 October 2026, 10:2x-11:1x EDT). Working notes, kept as written; the page is the statement.

# Cross-scale coupling comparisons in Bałaban's 4D corpus — reading notes (iii-43, 2026-10-29)

Convention (Bałaban): k grows toward COARSE scales; g_k grows with k (asymptotic freedom); x_k := 1/g_k².
The bounded transient (CouplingTransient.lean): x_i ≥ x_j + (j−i)(c−ρ) − 2F and x_i ≤ x_j + (j−i)(c+ρ) + 2F for i < j.
Then for i < j: g_i ≤ (1 − 2F g_j²)^(−1/2) g_j  (the no-log factor), and every log comparison absorbs 2F into (1+β0).

## Pages read with images in view, 10:3x–10:5x (this batch)

### CMP 119 (Convergent Renormalization Expansions, 243–285)
- p.270, before (3.26): k_1 = largest integer with L^(−(k−k_1)) M R_j ≤ L; "for j ≤ k_1 the cubes of the partition are
  contained in L-cubes" — nesting over all j ≤ k_1 compares R_j across scales (the (2.9) kind, implicit).
- p.271 (3.26)/(3.27): the parameter t multiplies A(1/g_k²(·) − 1/g_k², U_k(...)) − A(1/g_k²(·) − 1/g_k², U_{k+1}):
  the POSITION-DEPENDENT coupling g_k(·) (built by (2.24) from earlier scales) against the uniform g_k.
- p.272–275 (3.28)–(3.42): single scale (g_k only; (3.30) expands in g_k).
- p.276 (3.43): Ũ^c_{k+1}(Y,(1+β)α̃0,(1+β)α̃1) × {|A| < C1 p1(g_k)}: single scale; lengths L^(−n) vs L^(−k).
- p.277: "supp(g_k^(−2)(·) − g_k^(−2)) ⊂ Z_k ... Notice that the large values of the function g_k^(−2)(·) − g_k^(−2)
  are suppressed by the exponential decay of H_k." — CROSS-SCALE (position coupling minus uniform; can be large).
  Also: "The analyticity domains become smaller after each step, but the difference is very small and exponentially
  decreasing in the number of steps" (the powers of 1/2 in (2.36)–(2.39); α_{0,j}, α_{1,j} across steps).
- p.279: coupling constant renormalization: subtract β_{k+1}(g_k) A(ϕ_{k+1}, U_{k+1}) from E^(k+1) − E^(k+1)(1);
  replace g_k^(−2)(·) in A(g_k^(−2)(·), U_{k+1}) by g_{k+1}^(−2)(·) "defined by the equation (2.24) with j = k+1".
  — THE RUNNING STEP ITSELF (one-step relation g_k → g_{k+1}).
- p.280–284 (proof of CMP 119's Theorem 2 = the β-function identity): (3.48) lengths only; (3.64) β′_j = β_j
  single scale; (3.67) O((L^j L^(−n))^(5−β)) lengths; (3.68) |V′−1| < 11d²ε_n(L^jL^(−n))² + dM(n−j+2)ε_n(L^jL^(−n))²
  — only ε_n appears; the factor (n−j+2) may come from summing per-scale terms each converted to ε_n (would be
  (2.8)); NOT explicit. (3.69)–(3.72) lengths.

### LFR I (CMP 122, 175–202)
- p.176–177 (0.2)–(1.1): definitions; no coupling comparison.
- p.180 (1.15)–(1.20): determining sets; none.
- p.182 (1.24): shell conditions with ε_{k0}, ε_{k0+1}, L0²ε_{k0+2}, ..., ε_{j−1}, ε_j on successive shells, with
  factors L0^(2(j−k0−1)), (L^(k−i)η)²; "2 ≤ L0 < L/2". The shells' nesting compares ε_i(L^(k−i)η)² across
  consecutive i — needs ε_{i+1} ≤ C ε_i with C < (L/L0)² (one-step (2.8)); implicit.
- p.183: δ′_j = g_j A1 p1(g_j), p1(g) = (log g^(−2))^(p1): single scale.
- p.185 (1.38): |H| < B3(4δ′_j + e^(−δMR_{j+1})22d²ε_{j+1} + e^(−δ6LMR_{j+1})22d²ε_j)
  ≤ B3(4δ′_j + e^(−δMR_{j+1})44d²(1+β0)ε_j) — EXPLICIT one-step: ε_{j+1} ≤ (1+β0) ε_j.
- p.186 (1.46): ... + 9B3 (A1 p1(g_j))/(A0 p0(g_j)) (1+β0)(1+(j−i)^(1/2)) e^(−δd(...)) ε_i (L^(k−i)η)²
  — EXPLICIT (2.8) first inequality (ε at scale j bounded by ε at the finer scale i < j, factor (1+β0)(j−i)^(1/2)).
  (1.47) distances; then 1+(j−i)^(1/2) times exp factor ≤ exp(−(j−i)).
- p.189 (1.60)–(1.62): A(1/(g_k^(n)(·))² − 1/g_j², U^(n)(...)) and C_k^(n+1) contains
  A(1/(g_k^(n+1)(·))² − 1/(g_k^(n)(·))², U^(n+1)) — renormalization of the Wilson action in the preliminary
  integrations; position-dependent couplings at successive n against g_j. CROSS-SCALE (definitional).
- p.190–191 (1.65)–(1.69): spaces Ũ with α_{0,m}, α_{1,m}, ε at each m; "a descending sequence for increasing n,
  if β ≤ 1/4 and L0² ≤ L/3" — compares conditions at successive steps; implicit.
- p.194–197 (1.76)–(1.87): Proposition 1; single scale.
- p.198 (1.94): B3 δ′_k + L^(−(k−h)) O(1) B3³B5M⁶ ε_h ≤ B3(1+β0)N^(1/2) (A1p1(g_h))/(A0p0(g_h)) ε_h + ...
  — EXPLICIT: δ′_k (scale k) bounded by ε_h (scale h = k − N): uses g_k ≤ (1+β0)N^(1/2) g_h [(2.6) first] and
  p1(g_k) ≤ p1(g_h) [log, monotone]. And: "N ≤ O(1)(log g_k^(−2))^ν ≤ O(1)(1+β0)(log g_h^(−2))^ν" — EXPLICIT (2.7) first.
- p.201 (1.99)–(1.102): single scale.

### LFR II (CMP 122, 355–392)
- p.357 (1.2), (1.6): single scale k.
- p.358 (1.7)–(1.11): single scale ((1.10) E_k(Λ) = (−½d(g) log g_k^(−2) + log σ0)|Λ^(k) \ G0|).
- p.359 (1.12)–(1.15): (1.14) A(1/(g″_k(·))², U″_k) = (1/g_k²)A(U″_k) + A(1/(g″_k(·))² − 1/g_k², U″_k) — position coupling.
- p.363 (1.28)–(1.29): bound g_k(L^hη)^(d−1)(100MR_{k+1})^(d−1)·...·ε_k ≤ g_k² L^(−(d−1)N) N^((d−1)β0) O(1) A0²B3²B5 M^(d+5) R_k^(d−1) p0²(g_k)
  — EXPLICIT cross-scale: R_{k+1} and the domains at scale h = k−N bounded by R_k with factor N^((d−1)β0) [(2.9) second / (2.8) second].
  Also "L^(−N) ≤ (log g_k^(−2))^(−ν) ... N ≥ (ν/log L) log log g_k^(−2)" single scale.
- p.364 (1.31): 0 ≤ A(ζ1,U0) < g_k² L^(−4N) N^(4β0) O(1)A0²B3²B5²M^14 R_k⁴ p0²(g_k) — EXPLICIT N^(4β0) [(2.8)/(2.9) second].
  Text: "(1/(g″_k(·))² − 1/g_k²) is bounded by O(1)(k−j) on Ω″_j \ Ω″_{j+1}, and the exponential decay of H″_{k,Z}
  suppresses this bound." — EXPLICIT cross-scale, position coupling: x_k(x) − x_k ≤ O(1)(k−j).
- p.365 (1.33)–(1.37): new function 1/(g_k(·))² = 1/(g″_k(·))² on Z^c, 1/g_k² on Z — the position coupling reset on
  the large-field region. (1.37): −A(1/(g_k(·))², U_k) − A((1/(g″_k(·))² − 1/g_k²)ζ, U″_{k,Z}) − A(1/(g″_k(·))² ζ1, U″_{k,Z}) ...
- p.366: "1/(g″_k(·))² − 1/g_k² = O(N) ≤ O(R_k) on the support of ζ" — EXPLICIT cross-scale.
  Bound O(1) N^(2+4β0)(100MR_k)⁴(...)² ≤ O(1)B3²B5²M⁹R_k⁷ε_k² — EXPLICIT N^(4β0).
  Positivity: "the obvious positivity properties of the Wilson action are lost" for the complex extension; shown to be
  "a small perturbation of a positive Wilson action" — the Wilson action with 1/g_k²(·) > 0 is used as positive.
- p.367 (1.40)–(1.45): single scale.
- p.368 (1.47): |<DH″_{h+2}, (1/(g″_k(·))²)ζ1 η^(−2) Im ∂U″_{h+2}>| < Σ_{j=1}^{h} Σ_{x∈Γ″_j} B3 e^(−δd)O(1)L^(−N)B3²B5M⁶(α0,k+α1,k)
  ·((1/g_k²) + O(k−j)) ε_j ≤ O(1)(1/g_k²)(α0,k+α1,k) ε_k L^(−N) N^(1+β0) B3³B5M⁶ Σ_j Σ_x e^(−½δd) e^(−½δM(h−j)) (1+h−j)^(1+β0)
  ≤ O(1)A0C1B3³B5M^10 p0(g_k)q1(g_k)R_k^d L^(−N)
  — EXPLICIT, THREE comparisons in one line: (i) 1/(g″_k(·))² ≤ 1/g_k² + O(k−j) on Γ″_j (position coupling);
  (ii) ε_j ≤ (1+β0)²(k−j)^(β0) ε_k [(2.8) second]; (iii) a SUM over j = 1..h of scale-j terms, controlled by
  e^(−½δM(h−j)) against the polynomial (1+h−j)^(1+β0).
- p.369 (1.49): single scale; R_k = R_{k−1} + R″^(k).
- p.370–375 (1.50)–(1.65): expansions of U″_k; single scale (lengths L^(−n)).
- p.376 (1.66)–(1.67): lengths only (d_j vs d_k).
- p.377 (1.68)–(1.70): |V(Y,(U,J))| ≤ O(1) Σ_{j=1}^{k} |Γ⁰_j ∩ Y| — sum over scales of volumes, coupling-free; "α arbitrarily small for γ small".
- p.378–379 (1.71)–(1.72): single scale.
- p.380 (1.73)–(1.75): per large-field domain Z_j: O(1) log g_j^(−2)|Z_j| ≤ O(1)M^d R_j^(d+1) d′_j(Z_j); factors
  e^(−γ0(1/(2g_j²))(B3^(−1)ε_j)²(LM2R_j)^(−d)|P_j|) etc. — each at its own scale j (the product over j of such
  factors is assembled on p.381, read before compaction: ε_m, δ′_m against p0(g_j), p1(g_j) for j−N ≤ m ≤ j).
- p.391–392: none.

## Still to re-read (images dropped from view before notes were taken)
CMP 109 pp.255, 257, 266, 292, 297, 298; CMP 116 p.15; CMP 119 pp.244, 248–254, 256–261, 263–265, 269, 282;
LFR I pp.178, 179, 181, 193, 200; LFR II pp.360, 361, 390.

## Re-read batch 1 (10:5x)
- CMP 109 p.255 (0.17)–(0.19): A_1 determines β_1(g_0) on [0,γ]; (0.18) 1/g_0² = 1/g_1² + β_1(g_0), i.e.
  1/g_1² = 1/g_0² − β_1(g_0), "a finite difference approximation ... of (d/ds)(1/g²) = −β(g)". (0.19): A_{k+1}(g_{k+1},V)
  = (T_k A_k)(g_{k+1},V) with exp[−(1/g_k²)Σ(1 − Re tr U) + A_k(g_k,U)]. — THE RUNNING LAW (the one-step comparison that
  every other line is derived from). Per step: x_k − x_{k−1} = −β_k(g_{k−1}) (x falls toward coarse scales).
- CMP 109 p.257 (0.24)–(0.26): |E^(j)(X,U)| ≤ E0 exp(−κ d_j(X)) — COUPLING-FREE; (0.26) Σ_{j=1}^{k} E^(j)(U_k) ≤
  E0 O(1)M^(−4)|T_1^(k)|η^(−4) — a sum over scales of volumes, no coupling. NOT a comparison.
- CMP 119 p.259 (2.24): 1/g²_{j−1}(x) = 1/g_j²(x) + β_j(g_{j−1}) φ_j(x), "the coupling constants g_{j−1} are defined
  as in (I.0.20), and φ_j ∈ C0^∞(Λ_j), φ_j = 1 on Λ_j^(~−1). Thus g_j²(x) = g_j² on the last domain."
  So D_k(x) := 1/g_k²(x) − 1/g_k² = Σ_{j=1}^{k} β_j(g_{j−1})(1 − φ_j(x)) (until a reset; LFR II p.365 resets to 1/g_k² on Z).
  (2.25) E_k(U_k) = Σ_{j=1}^{k}[E^(j)(Λ_j,g_{j−1},U_k) − E^(j)(Λ_j,g_{j−1},1) − β_j(g_{j−1})A(ϕ_j,U_k)] — every scale's
  counterterm β_j(g_{j−1}) carried in the current action. (2.28) α_{0,j} = g_j C0 (log g_j^(−2))^{q0}, α_{1,j} = g_j C1 (log g_j^(−2))^{q1}.
- CMP 119 p.260 (2.31): |R^(j)(X,(U,J))| ≤ g_j^{κ0} exp(−κ d_j(X)); text: "terms with bounds O(1)(L^jη)⁴ g_j^{κ0}
  exp(−κd_j(X)). The sum over X is controlled by the exponential factor, and by the factor (L^jη)⁴. The sum over j is
  controlled by g_j^{κ0}." — EXPLICIT cross-scale SUM Σ_{j=1}^{k} g_j^{κ0}: bounded uniformly in k only because the
  finer couplings are smaller, x_j ≥ x_k + (slope)(k−j). Under the transient: g_j ≤ (1 − 2F g_k²)^(−1/2)(x_k + (c−ρ)(k−j))^(−1/2),
  so Σ_j g_j^{κ0} ≤ (1 − 2F g_k²)^(−κ0/2) Σ_m (x_k + (c−ρ)m)^(−κ0/2) = O(g_k^{κ0−2}) for κ0 > 2, c − ρ > 0. COVERED, cost the
  operator's factor to the power κ0.

## Re-read batch 2 (CMP 109 §2, §4–5)
- CMP 109 p.266 (2.4)–(2.9): one step at scale k. End: "Another possibility is to take g_k/γ_k ε_1 instead of ε_1, where
  γ_k = C log(L^k ε)^(−1) ... the functions E^(j), β_j are analytic functions of the effective coupling constants" — single scale.
- CMP 109 p.292 (4.45) and text: "the only terms in the expansion of (4.38), which we do not control yet, more exactly for
  which the sum over j has not a uniform bound, are terms (4.42), (4.44) ... We define the β-function β_j(g_{j−1}) equal to
  this coefficient ... hence both groups of terms cancel" — the SUM OVER SCALES j of marginal terms, resolved by defining
  β_j: the origin of the running, not an inequality.
- CMP 109 p.297 (5.36)–(5.44): (5.42) β = −(∂²Π_12/∂p1∂p2)(0) = Σ_x Π_μν(x)x_μx_ν, "the fundamental equality defining the
  β-function" — single scale.
- CMP 109 p.298: "We write β_j as explicitly dependent on g_{j−1}, although it depends also on all preceding coupling
  constants. The dependence on g_{j−1} is important and it determines main properties of the renormalization group
  equations." — EXPLICIT STRUCTURAL CROSS-SCALE DEPENDENCE: β_j = β_j(g_0, …, g_{j−1}). Every bound on β_j (hence (0.31),
  (2.6)–(2.9)) must hold uniformly over histories; this is exactly the YM seat's §104 form f(k) = c_W − c(S_k) (S_k carries
  the history).

## Re-read batch 3 (CMP 119 §0–2)
- CMP 119 p.244 (after (0.2)): large-field plaquette at the first step, |U(∂p) − 1| ≥ g_0 p_0(g_0), p_0(g_0) = A_0(log g_0^(−2))^{p0};
  exp[−(1/g_0²)(1 − Re tr U(∂p))] ≤ exp(−½p_0²(g_0)) ≤ g_0^{A_0(log g_0^(−2))^{p0−1}}. "For d = 4 the bare coupling constant
  behaves asymptotically as (a + b log ε^(−1))^(−1/2) ... hence the bound does not give any positive power of ε. It is still
  small ... and it controls a large number of steps, but this number is a small fraction of the total number of steps."
  — EXPLICIT CROSS-SCALE (bare coupling vs the number of steps it must control; the profile's asymptotics). Qualitative;
  under the transient 1/g_0² = x_K + cK + f(K) − f(0) ∈ [x_K + (c−ρ)K − 2F, x_K + (c+ρ)K + 2F]: same asymptotics. COVERED.
  This is the reason the R-operation exists.
- CMP 119 p.249 (1.14)–(1.16): first step, g_0 only.
- CMP 119 p.253 (1.27): "the first renormalization group equation 1/g_0² = 1/g_1²(x) + β_1(g_0)φ_1(x). The difference in comparison
  with Eq. (I.0.20) is that here we have functions on the lattice T instead of the constants there, but on Λ_1^(~−1) we have the
  same equation, which defines the same coupling constant g_1." — position-dependent running law, step 1.
- CMP 119 p.256 (2.8)–(2.9) confirmed verbatim:
  (2.8) ε_n ≤ (1+β0)(n−m)^(1/2) ε_m;  ε_m ≤ (1+β0)(1 + g_n²β′(n−m))^{β0} ε_n ≤ (1+β0)²(n−m)^{β0} ε_n;
  (2.9) R_n ≤ L R_m;  R_m ≤ L(1 + g_n²β′(n−m))^{β0} R_n ≤ (L+1)(n−m)^{β0} R_n.  "Similar inequalities hold for other constants,
  which will be introduced later." Then: Ω_j, Λ_j "unions of MR_j-cubes ... the distance between their boundaries is at least
  equal to 2MR_j"; the field V_{j−1} regular on Γ_{j−1}: |∂V_{j−1} − 1| < O(L²)ε_{j−1}; minimal determining sets Ω = Ω_0 ⊃ Ω_1 ⊃ …
  ⊃ Ω_j with dist(Ω_n, Ω_{n−1}^c) ≥ L^n ξ M_1 (nested, with margins).

## Re-read batch 4
- CMP 119 p.264 (2.47)–(2.49): |B^(j,n)| ≤ B_1 2^(−(j−n))|Γ_n| for j > n; summed over j from n to k, then n from 1 to k:
  |(2.40)| ≤ 2B_1 Σ_{n=1}^{k}|Γ_n| (2.48) — geometric in scale difference, COUPLING-FREE. "the vacuum energy counterterm E_k, except
  the terms logarithmic in coupling constants, has the same bound"; (2.49) A_k(1/g_k², U_k) = −A(1/g_k², U_k) + (the logarithmic
  terms) + O(1)Σ_{j=1}^{k}|Γ_j|; "The first term ... yields the small factors for large field characteristic functions. It also
  controls the logarithmic terms." — CROSS-SCALE: log g_j^(−2) volume terms from every scale j ≤ k controlled by the scale-k
  Wilson action/small factors (the comparison of log g_j^(−2) with scale-k quantities is the (2.7) kind; logarithmic; COVERED).
  Corollary 3 (2.50) UV stability: E_−, E_+ "independent of η and T, but depending on g_k".
  §3 (3.1): "the new fields V_{k+1} satisfy the bounds |V_{k+1}(∂p′) − 1| < 2L²ε_k" — the new scale's field bounded by ε_k.
- CMP 119 p.265 (3.2)–(3.5): new restrictions with ε_{k+1}(L^(−1)η)² and δ_k = g_k A_1/A_0 p_0(g_k); "with V_k, ε_k, g_k instead of
  U, ε_0, g_0"; then "we prove that on Ω̃_{k+1} the functions χ_{Λk} and χ_k are equal to 1" — the new (k+1) restrictions imply
  the old (k) ones: ONE-STEP comparison ε_{k+1} vs ε_k (carried out on p.266 (3.7)–(3.8), read before compaction). COVERED by
  (2.8) at n − m = 1, cost the no-log factor.
- CMP 119 p.282 (3.58)–(3.63): Euclidean covariance; (3.61) β′_j = Π^(j)_{22,11} "a possible definition of the β-function" — single scale.
- CMP 116 p.15 (before (2.14)): "[the potentials] can be extended to functions of (U,J), analytic on the space
  U^c_{k+1}(Y,(1+β)α_0,(1+β)α_1,α_0) ... The quadratic forms and covariances in H(Z) are analytic functions on the space of
  configurations (U,J) satisfying the conditions I.(i)–(iii) on the domain Z, with constants α′_0, α′_1 much bigger than α_0, α_1,
  therefore we can restrict them, as analytic functions, to the above subspace. Thus the activities in (2.13), and the whole sum
  E^(k+1)(X), are analytic functions of (U,J), on the space U^c_{k+1}(X,α_0,α_1). This is the analyticity statement in the
  inductive assumptions." — THE LINE THE YM SEAT ASKED FOR (E^(k+1)'s field-analyticity re-established with the SAME α_0, α_1).
  Its variables: U = U′U, U′ = exp(iL^(−1)ηA′), |A″|, |∇A′| < α_1, |J| < α_0 (A′ NOT scaled by g). In the complete model
  CMP 119 (2.28) the radii become α_{0,j} = g_j C_0(log g_j^(−2))^{q0}, α_{1,j} = g_j C_1(log g_j^(−2))^{q1}, shrinking per step by the
  powers of 1/2 in (2.36)–(2.39), "very small and exponentially decreasing in the number of steps" (p.277).
  (2.14)–(2.15): the activity bound, single scale.

## CMP 109 / CMP 116 remaining keyword hits (checked on the text layer, 11:0x)
- CMP 109 pp.249–252, 262, 273, 283–285, 289–290, 295–296: prose ("sequence of effective actions/identities"); p.268 (2.14)
  "Finally we perform the coupling constant renormalization" (the running step k → k+1, single-step definition); p.276 (3.31),
  p.279 "(1+6β)": analyticity-domain factors, not couplings; p.291 β_j(g_{j−1}) in the Ward expansion, single step.
- CMP 116 pp.4, 8, 11, 17, 20: geometry, ε and α_5 at one scale. No further cross-scale coupling comparison in either paper.

## Re-read batch 5 (CMP 119 pp.248, 250–252): first step only (g_0, δ_0, ε_1; (1.10)–(1.25)). No cross-scale comparison.

## Re-read batch 6 (CMP 119 pp.254, 257, 258, 261)
- p.254 (1.29)–(1.30) first step; §2 (2.1): the admissible sequences are NESTED: Ω_1 ⊃ Λ_1 ⊃ Ω_2 ⊃ Λ_2 ⊃ … ⊃ Ω_j ⊃ Λ_j ⊃ … ⊃ Ω_k ⊃ Λ_k;
  S_j ⊂ Ω_j ∩ Λ_j^c unions of LM_2R_j-cubes.  → With p.256's margin (dist between the boundaries of Ω_j and Λ_j ≥ 2MR_j) and
  Λ_{j+1} ⊂ Ω_{j+1} ⊂ Λ_j, the smooth cutoffs φ_j ∈ C0^∞(Λ_j), φ_j = 1 on Λ_j^(~−1), satisfy supp φ_{j+1} ⊂ {φ_j = 1} as soon as the
  margin 2MR_{j+1} (scale j+1) covers one layer of scale-j cubes, which (2.9) at n − m = 1 gives (MR_{j+1}L^{j+1} ≥ MR_jL^j·L/(L+1)).
  Then j ↦ φ_j(x) is NON-INCREASING between R-resets: the weighted sums of (2.24) are convex combinations of partial sums.
- p.257 (2.13)–(2.18): determining sets; (2.17) χ_k(Ω_k) with ε_kη²; (2.18) ρ_k = Σ χ_k T_k exp A_k(1/g_k², U_k) — single scale.
- p.258 (2.19)–(2.23): T_k(X) = Π_{j=k−1}^{0} T^(j)(Z_{j+1} ∩ X), each factor at its own scale; (2.23) A_k(1/g_k², U_k) = −A(1/g_k², U_k)
  + E_k + R_k + B_k − E_k, the Wilson term carrying the position-dependent g_k(·) of (2.24).
- p.261 (2.34)–(2.42): the analyticity space Ũ_j^c(X, α̃_0, α̃_1): on X ∩ (Ω_n \ Ω_{n+1}), n = 1..j−1, the radii are
  (1 − β(1 − 2^(−(j−n)))) α_{0,n}, α_{1,n} — the n-th scale's α, shrink factor ≥ 1 − β, "we can take β = 1/4": CROSS-SCALE IN THE
  DEFINITION (a term made at step j is analytic on shells with each shell's own scale n), k-uniform shrink. (2.42) |B^(j)| < B_0 e^(−κd_j(X)),
  coupling-free.

## Re-read batch 7 (CMP 119 pp.263, 269; LFR II pp.360, 361)
- CMP 119 p.263, CMP 119's Theorem 2: (2.43) |Σ_z [E^(j)(Λ_j,U_k,z) − E^(j)(Λ_j,1,z)] − β_j(g_{j−1})A(ϕ,U_k)| ≤ E_1 Σ_{n=j}^{k} (L^{j−n})^β |Γ_n ∩ Ω|
  (β < 1) — the scale-j counterterm with its own coupling g_{j−1} inside the scale-k action; geometric in n − j, coupling-free bound.
  (2.44) |Σ_X [R^(j)(X,U_k) − R^(j)(X,1)]| ≤ R_1 g_j^{κ0} Σ_{n=j}^{k}|Γ_n ∩ Ω|.
  (2.45) |E_k(U_k)| ≤ E_1 Σ_n |Γ_n| Σ_{j≤n}(L^{j−n})^β < E_1(1 − L^(−β))^(−1) Σ_n |Γ_n| — coupling-free.
  (2.46) |R_k(U_k)| ≤ R_1 Σ_{n=1}^{k}|Γ_n| Σ_{j=1}^{n} g_j^{κ0} < R_1 Σ_n |Γ_n| g_n^{κ0−6} < Σ_n |Γ_n| "for κ0 ≥ 7 and g sufficiently small"
  — EXPLICIT CROSS-SCALE SUM: Σ_{j≤n} g_j^{κ0} < g_n^{κ0−6}. Profile gives O(g_n^{κ0−2}); under the transient
  Σ_{j≤n} g_j^{κ0} ≤ (1 − 2F g_n²)^(−κ0/2) (c−ρ)^(−1) O(g_n^{κ0−2}) < g_n^{κ0−6}. COVERED (lower profile, power κ0 of the no-log factor).
- CMP 119 p.269 (3.20)–(3.22): H^(k) "bounded on the set S_{k+1} by O(1)ε_k exp(−R_k), hence by any positive power of g_k" — single scale.
- LFR II p.360 (1.16)–(1.19): H″_{k,Z} ≤ 44d²ε_k; "exp(−(1/2)δMR_k). It suppresses all powers of log g_k^(−2)"; |B| < g_k^(−1)δ′_k — single scale.
- LFR II p.361 (1.20)–(1.22): "this time bounds are a bit more difficult and larger, because of the many scales in the definitions of the
  operators and the field B. Thus the last term is bounded by O(1)|B_0|δ′_k³ ≤ O(1)(100MR_k)^d N² δ′_k³ ≤ g_k³ O(1)M^dR_k^{d+2}A_1³p_1³(g_k) ...
  We have assumed here that N ≤ R_k." — the N scales' field restrictions bounded through the scale-k δ′_k (the factor N²; implicit
  (2.8)-type); and N ≤ R_k compares the step count with a scale-k function. "U⁰_{k,Z} satisfies the usual regularity conditions (2) [15],
  for the sequence {Ω″_j} ... with the constant O(1)B_3²B_5M⁵ε_k instead of ε_0" — one constant ε_k for every shell of the sequence.

## Re-read batch 8 (LFR II p.390; LFR I pp.178, 179, 181)
- LFR II p.390 (1.97)–(1.102): c_1 = exp(−p_0(g_k)) or α^{1/3}; (1.100) |R′^(k)(X,(U,J))| ≤ exp(−p_0(g_k)) exp(−κd_k(X)) — single scale;
  (1.101) A_k(1/(g_k(·))², U_k) = A′_k + ΣR′^(k) + ΣB′^(k) "satisfies the induction hypothesis" (the position coupling carried).
- LFR I p.178 (1.2)–(1.9): T_k(Z)exp A_k = χ_k Π_{j=k−1}^{h} T^(j)(Z_{j+1}) χ_h T_h(Z_h) exp A_k, h = k − N: the last N one-step operations,
  each with ITS OWN scale's restrictions ε_j(L^{k−j}η)², ε_{j+1}(L^{k−j−1}η)², |V_j − 1| < ε_j, (1/z)exp[−(1/g_j²)(1 − Re tr V_j)] (1.6),
  2δ_j, |A_j| < g_j^(−1)δ_j (1.9) — "we have to compare them with other characteristic functions" — THE R-OPERATION'S BASIC COMPARISON:
  restrictions at scales j = h..k−1 against the scale-k ones (carried out with (2.8) on pp.181–186). The Wilson factor (1.6) at g_j inside
  the scale-k operation.
- LFR I p.179 (1.10)–(1.14): N_0 = smallest integer with L^{−N_0+1}MR_{k−N_0+1} = M; "either there is exactly one such integer, or there
  are two"; N > N_0, "N is much greater than N_0" — CROSS-SCALE: N_0 defined by comparing R_{k−N_0+1} at a finer scale; uniqueness
  ("one or two") rests on R_{j+1} ≤ LR_j [(2.9) first]. Coupling enters only through R_j = R(g_j).
- LFR I p.181 (1.22)–(1.23) and the χ^(n) definition: shells with (1 − β(1 − 2^{−(j−h+1)}))ε_h(L^{k−h}η)² and ε_{h+1}(L^{k−h−1}η)²,
  for j ≤ k_0 = k − N_0 disjoint, beyond k_0 "regions overlap ... we change the regularity conditions by a factor, which is a power of
  some number, the power being proportional to a number of overlapping regions" — consecutive-scale ε comparisons (implicit (2.8),
  n − m = 1), factors 1 − β(1 − 2^{−m}) ≥ 1 − β.

## Re-read batch 9 (LFR I pp.187, 192, 193, 200)
- LFR I p.187 (1.50)–(1.52): (1.52) |U^(n)_{k,Z}(∂p) − 1| < (1 − β/2)L_0^{2max{0,j−l}} ε_{j+1}(L^{k−j−1}η)²(1+αβ) + αβ ε_j(L^{k−j}η)²
  < ((1+β0)(1+αβ)L_0²/L² + 2αβ/(2−β)) (1 − β/2)L_0^{2max{0,j−l−1}} ε_j(L^{k−j}η)² — EXPLICIT ε_{j+1} ≤ (1+β0)ε_j [(2.8) first, n − m = 1],
  "under the usual restrictions on β0, β, L_0 (i.e., β0 ≤ 1/2, β ≤ 1/2, L_0 < (1/2)L)". Then (1.53)–(1.54) and: "All the formulas are the same as in
  Sect. 3, or in Sect. 2[I], only we have to replace the function (g_k^(n)(·))^(−2) in the Wilson term of the action by g_j^(−2), the term with the
  difference (g_k^(n)(·))^(−2) − g_j^(−2) is put into the interaction." — EXPLICIT CROSS-SCALE (position coupling of the scale-k action against
  the scale-j constant, the difference treated as a perturbation; its size = LFR II p.364's O(1)(k − j)).
- LFR I p.192: "the bounds of the terms involve δ′_j, but δ′_j ≤ (1+β0)²(k−j)^{β0}δ′_k ≤ (1+β0)²N_0^{β0}δ′_k, so N_0δ′_j ≤ (1+β0)²N_0^{1+β0}δ′_k < 4N_0²δ′_k,
  and we assume that N_0² makes only a logarithmic contribution to δ′_k, e.g., N_0 = O(log g_k^(−2))." — EXPLICIT [(2.6) second × (2.7) second].
  "L^{−N_0+1}R_{k−N_0+1} = 1, from which we get L^{N_0−1} = R_{k−N_0+1} ≤ (L+1)(N_0+1)^{β0}R_k" — EXPLICIT (2.9) second; then
  L_0^{2N_0} ≤ (1/3)^{N_0}L(L+1)(N_0+1)^{β0}R_k < L(L+1)N_0^{−1}R_k: "the powers of L_0 make only unessential logarithmic contributions to the
  constants α_{0,j}, α_{1,j}, ε_j in the definitions." (1.70) |C_k^(n)| ≤ C_0 exp(−(1+3β)κd_m(X)).
- LFR I p.193 (1.75): χ_k(Ω̃_k^{−4}), χ″_k restrict V_k on Ω″_k: |∂V_k − 1| < 2L_0^{2N_0}ε_k < 2L(L+1)N_0^{−1}R_kε_k — via p.192 (2.9).
- LFR I p.200 (1.98): ε_kη² converted to ε_j(L^{k−j}η)² with factor 2L^{−(k−j)} [(2.8) first: (1+β0)(k−j)^{1/2}L^{−2(k−j)} ≤ L^{−(k−j)}];
  "O(1)B_3B_5M⁵L_0^{−2(N_0−1)} ≤ O(1)B_3B_5M⁵L_0²R_k^{−α_0}, α_0 = (log L_0²)/(log L)" — EXPLICIT (2.9) first (R_k ≤ LR_{k−N_0+1});
  "≤ 1/4 for R_k^{α_0} or γ sufficiently small"; "because k − j ≥ N_0".

## Definitions confirmed on CMP 119 p.255 (image)
(2.4) ε_j = g_j A_0(log g_j^(−2))^{p0} = g_j p_0(g_j);  (2.5) R_j = the smallest number of the form L^r such that R_j ≥ (log g_j^(−2))^r;
(2.6) g_n ≤ (1 + g_n²β′(n−m))^{1/2} g_m ≤ (1 + g_n²β′)^{1/2}(n−m)^{1/2} g_m ≤ (1+β0)(n−m)^{1/2} g_m,  g_m ≤ (1+β0) g_n  (n > m),
"β0 > 0 can be chosen arbitrarily small, if g is sufficiently small. The inequalities follow from the renormalization group equations (0.20) [I],
and from the properties of the β-functions."
(2.7) (log g_n^(−2))^p ≤ (1+β0)(log g_m^(−2))^p;  (log g_m^(−2))^p ≤ (1 + g_n²β′(n−m))^{β0}(log g_n^(−2))^p ≤ (1+β0)(n−m)^{β0}(log g_n^(−2))^p.

## CMP 109 p.263 (image), for the YM seat's Lemma C check
(1.17)–(1.19): "the function E^(j)(X, g_{j−1}, U, J) is defined and analytic on the space U_j^c(X, α_0, α_1), with some positive, absolute
constants α_0, α_1 (i.e., constants independent of X and j). ... It is a C^∞-function of g_{j−1} ∈ [0, γ], (or analytic), with a positive,
absolute γ. There exists a constant E_0 such that |E^(j)(X, g_{j−1}, U, J)| ≤ E_0 exp(−κd_j(X)) (1.18)". (1.17): |∂U_n(M(U)) − 1| <
B_3 2α′_0 L^(−2n)(L^nξ)² = 2B_3α′_0ξ² — the shells' conditions with one absolute α′_0 (no coupling).
CMP 109 p.265 (2.1)–(2.3): T_k A_k with χ_k and (1/g_k²)G(V), (1/g_k²)A(U_k(V)) — single scale.

## CMP 109 §0–§1 closed (pp.253, 254, 261, 262 on images)
- p.253–254 (0.4)–(0.15): averaging operations and the gauge fixing; ε_0, α absolute. No coupling.
- p.261 (1.6): A_k(U_k) = −(1/g_k²)A(U_k) + Σ_{j=0}^{k−1}{−β_{j+1}(g_j)A(U_k) + [E^(j+1)(g_j,U_k) − E^(j+1)(g_j,1)]} — every scale's counterterm with its
  own coupling inside the scale-k action (the telescoped running law: Σ_j β_{j+1}(g_j) = 1/g_0² − 1/g_k²). Definitional.
- p.262 (1.10)–(1.16): U_j^c(X, α_0, α_1, γ_0): |∂U − 1| < α_0ξ², |A′|, |∇A′| < α_1, |J| < γ_0, the shells (1.16) with one absolute α_0. No coupling.

## RESOLUTION of the weighted-sum item (flagged before compaction)
(2.1) nesting Λ_{j+1} ⊂ Ω_{j+1} ⊂ Λ_j, with Ω_{j+1} ⊂ (Z′_j^{~8})^c by (3.2)–(3.5) (eight layers of LMR_{j+1}-cubes off Z_j = Λ_j^c), and one step of (2.9)
(R_j ≤ (L+1)R_{j+1}, so eight scale-(j+1) layers exceed one scale-j layer) give supp φ_{j+1} ⊂ Λ_{j+1} ⊂ Λ_j^{~−1} = {φ_j = 1}. Hence φ_{j+1} ≤ φ_j
everywhere: j ↦ φ_j(x) is NON-INCREASING. Then D_k(x) := 1/g_k²(x) − 1/g_k² = Σ_{j=1}^{k} β_j(g_{j−1})(1 − φ_j(x)) and, by Abel summation with
w_j = 1 − φ_j(x) non-decreasing in [0,1] and tail sums T_i = Σ_{j=i}^{k} β_j = x_{i−1} − x_k,
  D_k(x) = Σ_{i=1}^{k} (w_i − w_{i−1}) T_i,  weights ≥ 0 summing to w_k ≤ 1:
a sub-convex combination of tail partial sums. The transient gives T_i ∈ [(k−i+1)(c−ρ) − 2F, (k−i+1)(c+ρ) + 2F], so
  −2F ≤ D_k(x) ≤ (k − j + 1)(c + ρ) + 2F on the j-th shell,
i.e. 1/g_k²(x) ≥ 1/g_k² − 2F, g_k(x) ≤ (1 − 2F g_k²)^(−1/2) g_k (the operator's factor), the Wilson coefficient stays positive for 2F g_k² < 1, and
LFR II p.364's O(1)(k − j) becomes O(1)(k − j) + 2F. The R-operation's reset (LFR II (1.33)) restarts the sum on an admissible (nested) sequence
(LFR I (1.12)), so the argument repeats piece by piece.
