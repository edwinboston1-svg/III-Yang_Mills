# ME2b — (E2), EUCLIDEAN INVARIANCE: THE TWO NEW INPUTS, (E1-scale), AND THE RP ROUTE

Proof agent ME2b, 2026-11-02 (10:3x EST). Work directory `.../scratchpad/math/ME2b/`. Appended as the work proceeds;
nothing above a line is edited after it is written except by a dated correction below it. Labels: PROVED (full proof
here), PROVED GIVEN [named input], OPEN (stated, with the next step), COMPUTED (exact arithmetic, record named), READ
(primary source read today by this agent), CITED.

## 0. Sources read before deriving

- `math/MATH_BRIEF.md` (re-read after its 10:2x update: PI-4 holds only at small or real coupling deviation d).
- `math/ME2/WORK.md` §§0–15 whole and `ME2/rec/` (three records).
- `math/M3f/WORK.md` §§0–17 whole (Theorem U; Lemma 6.2 the sandwich; E1 for two cutoffs given (T_loc), (CB); Lemma B
  = f(k) = c_W − c(S_k) by the stage identity; Theorem B1; §2: rho_K is not the blocked law, E1 is about W_K(tau)).
- `math/M3dR/REVIEW.md` whole (part (a): PI-4 holds for real d or |d_j| <= c eps_*/(C_W C_1 p_1(g_j)); the cross term
  −2d W(A, A_k) at complex d is the hole).
- THE GROUND (`cross/ground_docx.txt`) lines 53–146 (the corpus; YMM1 asserts limits "invariant under all Euclidean
  isometries" on disjoint supports with (E0); the 4D draft claims O(4) only under the rotation-current hypothesis).
- RPM1 (Alpöge–Sussman, "Rotation invariance from lattice symmetry and reflection positivity", AI-written, unvetted):
  `src_rpm1/RPM1.tex` (2866 lines, sha256 73ef6089…07783f, downloaded today from the repository
  ethanwsussman/Yang--Mills-LLM-experiment, directory "RP O(d) trick (RP1)") READ IN FULL, main text lines 692–2866;
  `src_rpm1/README_RP1.md` (sha256 ef1ca4e0…c047c056).

## 1. THE DECISION (deep-think synthesis, written before the derivations; what moved the plan is recorded)

(A) LEMMA Sigma_chi. FIRST-PRINCIPLES on the stage identity (M3f 7.1–7.4, 8.3) changed the object. The one-loop
dimension-four coefficient of the SKEW construction after k steps is, by the same identity M3f uses for Lemma B,
  [8 b_0 k ln L + c_W(R-Wilson)] Id − c(S^R_k),
and c_W(R-Wilson) is ISOTROPIC (the rotated Wilson action is isometric to Wilson's; its P^2 polarization is
R B_4 R^{-1}-invariant, hence a multiple of Id). So the anisotropic part is −c^an(S^R_k), which tends to 0 with the
tree-level contraction S^R_k -> S_infty (both constructions flow to the SAME classically perfect action). The O(1)
anisotropic remnant y_1 created by the skew step is a ONE-LOOP TRANSIENT, cancelled by the later standard steps, not a
persistent marginal coupling. ME2 §6.4's picture (y_1 persists, runs by Colladay–McDonald) is corrected: the persistent
anisotropy starts at two-loop order. Lemma Sigma_chi is then: (i) the per-step map is DIAGONAL on (metric, Weyl) by
Schur on the S_4-irreps of the plaquette-orientation weights (for a planar rotation, where the G'-invariant forms are
diagonal — to be COMPUTED); (ii) log parts: metric 0 relative (GL(4) covariance), Weyl −c_W g^2 (my own one-loop
computation, Colladay–McDonald as an outside check); (iii) the one-loop sources telescope (anisotropic Lemma B);
(iv) constants. For planar R the anisotropic row is an orientation-dependent coupling field D(p) = x d_{plane(p)} —
M3d's R_D device at REAL d, where M3dR's PI-4 verdict is HOLDS.
(B) (E1-scale). SECOND-ORDER on (A): the same telescoping kills the isotropic one-loop shift too: delta x^(1) =
[c_W(R-Wilson) − c_W] + [c^iso(S_K) − c^iso(S^R_K)] -> 0. So the rotated and original constructions at the SAME bare
coupling reach the same unit-scale coupling up to o(1) (the higher orders O(g_0^2)). ME2's premise "delta x = O(1),
non-vanishing" fails; E2-UV holds at the SAME bare coupling, R itself stabilizes the limit (Cor. 3.4), and (E1-scale)
is NOT an input of (E2). Separately: (E1-scale) itself — discrete dilations exact on the lattice + bare-coupling
uniqueness; continuous dilations from one centred factor-q step (q odd, coprime to L), a B_4-covariant comparison of
E1's own type with no extra row, plus density of L^Z q^Z.
(C) THE RP ROUTE. Reading RPM1 whole: hypothesis (i) (Glimm–Jaffe growth) is used at coincident points in exactly one
structural place, §5.2 "A field in a time slab" (the Seiler–Simon dyadic reflection terminating in E e^{2F(h_r)}),
which yields bounded planar insertions; the L^2(mu) framework elsewhere is a convenience replaceable by the OS
construction on disjoint-support tuples. The exponent 3 in M_N <= 3N is 1 (insertion power) + 2 (tensor weight), and
the integer lemma closes iff the per-point exponent c < 4 (sharp: M_n = 4n meets every constraint at c = 4). For the
scalar 0++ field, weight 0 and the scaling of tr F^2 in d = 4 give insertion power 3 < 4. So the version that can hold
is Theorem A' with (i) replaced by a planar insertion bound (P_k), k < 4 − w; N = 2 follows from the real two-point
function and H >= |P|; N >= 3 is a local field bound — the next object.

KILL-SWITCHES. (K-A) a G'-invariant anisotropic form for the planar rotation that is not diagonal in the plaquette
basis (then the row needs chair terms, outside M3d's device); (K-B) a step of the stage identity for the skew
construction that does not transcribe (e.g. the zero-alias amplitude not I + O(P^2)); (K-C) my one-loop Weyl coefficient
of the wrong sign exceeding the isotropic one; (K-D) a use of (i) in RPM1 outside §5.2 that is genuinely coincident.

## 2. STAKES FOR THE TWO INSTRUMENTS (written before either script exists; not edited after the runs)

### 2.1 `bin/me2b_planar.py` (exact rationals) — the marginal sector of the planar skew block
R = rotation by arctan(4/3) in the (0,1)-plane, 5R integral (L = 5). Stakes:
 P-1: |G'| = 32, G' = C_4 (quarter turns in the (0,1)-plane) x D_4 (the square's group in the (2,3)-plane), 16 elements
      orientation-reversing (ME2 record a reports |G'| = 32, 16 reversing).
 P-2: the G'-invariant symmetric forms on Lambda^2 are 3-dimensional and EVERY one is DIAGONAL in the basis e_mu^e_nu
      (kill-switch K-A NOT met): isotropic w = 1; metric w = h_mu + h_nu with h = (1,1,-1,-1), i.e. w_01 = 2, w_23 = -2,
      rest 0; Weyl w_01 = w_23 = 1, w_02 = w_03 = w_12 = w_13 = -1/2. No theta component (G' has reflections).
 P-3: under B_4 the diagonal forms split as trivial (1) + standard (3) + two-dimensional (2) of S_4, the sign subgroup
      (Z/2)^4 acting trivially on them and by non-trivial characters on every off-diagonal pair; the metric invariant lies
      in the standard summand, the Weyl invariant in the two-dimensional one (so no B_4-equivariant map mixes them).

### 2.2 `bin/me2b_oneloop.py` (exact rational arithmetic, sympy) — the one-loop anisotropic log coefficients
Background field method, Euclidean, action (1/4g^2) chi^{mu nu rho sigma} F^a_{mu nu} F^a_{rho sigma}, chi = chi_0 + k,
k-independent background Feynman gauge (ghosts k-independent). The k-linear part of the p^2 log-divergent coefficient
of the background two-point function, delta Gamma = (1/2)[-Tr(G V1 G d1) + Tr(G V1 G V1 G d0)]_{p^2, log}, against the
k = 0 coefficient a (gluon loop + ghost loop). Known answers the instrument must meet FIRST:
 K-1: the k = 0 gluon loop and ghost loop are each transverse, in the ratio 10 : 1, total proportional to 11/3 C_2
      (asymptotic freedom; background Feynman gauge decomposition 11/3 = 10/3 + 1/3);
 K-2: the response to the isotropic direction k = chi_0 VANISHES (one-loop log det is coupling-independent; the
      gauge-parameter dependence of the divergence is zero) — lambda(chi_0) = 0;
 K-3: every response tensor is transverse in the background (gauge invariance).
STAKES (the anchor, derived here and only compared with Colladay–McDonald afterwards):
 O-1: METRIC-type k (diagonal h = (1,1,-1,-1) and an off-diagonal h = e_0 e_1 + e_1 e_0): lambda(k) = a k exactly, i.e.
      the relative metric anisotropy has NO one-loop logarithm (GL(4) covariance of the continuum divergence);
 O-2: WEYL-type k (the diagonal Weyl form of P-2 and a random Weyl tensor): lambda(k) = b_W k with b_W/a = 18/11, i.e.
      the relative Weyl anisotropy runs as d ln(delta_W)/d ln(mu) = +(14/3) C_2 g^2/(16 pi^2) (Colladay–McDonald,
      PRD 75 (2007) 105002, eqs. (43)-(44)): per Balaban step delta_W -> delta_W (1 - (14/3) C_2 g^2 ln L /(16 pi^2)).
      UNGUESSED if O-2 fails: the true ratio; a ratio b_W/a < 1 (Weyl growing toward the infrared) would meet K-C only if
      the growth exceeds the coupling's (b_W < 0 in units where a < 0 ... recorded as read).

## 3. RESULTS OF `bin/me2b_planar.py` (record `rec/me2b_planar_run.2026-11-02a.txt`, rc = 0; §2.1 not edited)

- P-1 MET: |G'| = 32, 16 orientation-reversing; G' preserves the (0,1)- and (2,3)-planes; its (0,1)-block is the cyclic
  group of the four quarter turns (all determinant 1), its (2,3)-block the 8-element group of the square: G' = C_4 x D_4.
- P-2 MET: the G'-invariant symmetric forms on Lambda^2 are 3-dimensional, spanned by the diagonal forms with weights
  (w_01, w_02 = w_03 = w_12 = w_13, w_23) = (1,0,0), (0,1,0), (0,0,1); EVERY invariant form is diagonal (kill-switch K-A
  NOT met). The metric stake w = (2; 0,0,0,0; -2) equals the form of h = diag(1,1,-1,-1) and lies in the span; the Weyl
  stake w = (1; -1/2 x4; 1) lies in the span, is orthogonal to all nine metric forms, to theta and to Id (pure Weyl).
  The metric forms have rank 9 and are orthogonal to Id and theta (decomposition check).
- P-3 MET: metric invariant: mean 0, row sums sum_n w_mn = (2,2,-2,-2) = 2h (the standard S_4-summand
  {w_mn = h_m + h_n, sum h = 0}); Weyl invariant: mean 0, row sums 0 (the two-dimensional summand); all 15 off-diagonal
  pairs carry a non-trivial character of the sign subgroup (Z/2)^4.

## 4. LEMMA Sigma_chi, PART 1 — CMP 119 (3.56)–(3.64) WITHOUT W(B_4) (PROVED)

READ ON IMAGE TODAY: CMP 119 pp. 281–283 (M3d's renders `M3d/render/cmp119_281.png`–`_283.png`). Balaban's argument:
(3.56) the second-order part of the step's localized expression is (1/2) sum_{kappa<mu, lambda<nu} E^(2)_{mu nu, kappa lambda}
tr F_{kappa mu} F_{lambda nu} + irrelevant; resummed (3.57) with Pi^(j)_{mu nu, kappa lambda} = sum_{x,y} Pi^(j)_{mu nu}(x,y,z)
(x_kappa - z_kappa)(y_lambda - z_lambda), translation invariant; (3.58)–(3.60) Euclidean covariance from (2.29) gives
(tensor^4 r) Pi^(j) = Pi^(j) for the lattice symmetries r; then "Considering reflections ... different from 0 only if
mu = nu and kappa = lambda. Considering permutations ... they are all equal" (p. 282), whence (3.61)
(3.57) = beta'_j (1/2) sum_{mu<nu} tr F_{mu nu}^2, beta'_j = Pi^(j)_{22,11}; (3.62)–(3.64) identify beta'_j with the
second moment of Pi^(j)_22, the definition (I.1.22); (3.65)–(3.67) the counterterm -beta_j A(h_z, U_k), "Euclidean
covariant", cancels the second-order part and leaves irrelevant terms O((L^j L^{-n})^{5-beta}).

THE STRUCTURE OF Pi^(j). After the antisymmetrization (3.55) the coefficient matrix of (3.57) is a bilinear form on
Lambda^2 (the plaquettes (kappa mu) and (lambda nu)), SYMMETRIC because Pi^(j)_{mu nu}(x,y,z) is a second functional derivative
(symmetric under (mu,x) <-> (nu,y)). So it is an element of Sym^2(Lambda^2), and (3.60) says it is invariant under the
symmetry group of the construction.

PROPOSITION 4.1 (the reduction for the planar skew construction). Let R be the rotation by arctan(4/3) in the
(0,1)-plane, L = 5^m, and let the localized terms E^(j) be G'-covariant, G' = B_4 cap R B_4 R^{-1} (true for the skew
construction: the skew block map is G'-covariant and every later step is B_4-covariant, so every composite is
G'-covariant). Then (3.57) equals
  (1/2) sum_{mu<nu} beta'_{j,mu nu} tr F_{mu nu}^2(z),   beta'_j = b_j iota + y^m_j mu + y^W_j omega,
with iota = (1;1,1,1,1;1), mu = (2;0,0,0,0;-2), omega = (1;-1/2,-1/2,-1/2,-1/2;1) in the order (01; 02,03,12,13; 23); in terms
of the three free entries A = beta'_{j,01}, B = beta'_{j,23}, C = beta'_{j,02} (= 03 = 12 = 13):
  b_j = (A + B + 4C)/6,   y^m_j = (A - B)/4,   y^W_j = (A + B - 2C)/3.
PROOF. (3.60) holds for r in G'. By P-2 (exact, record of §3) every G'-invariant element of Sym^2(Lambda^2) is diagonal in
the basis e_mu ^ e_nu with the three free entries A, B, C; this replaces Balaban's "reflections" and "permutations" steps.
The decomposition is linear algebra: A = b + 2y^m + y^W, B = b - 2y^m + y^W, C = b - y^W/2. The identification
(3.62)–(3.64) is entrywise: beta'_{j,mu nu} = -(1/2) sum Pi^(j)_{nu nu}(x,0,z) x_mu^2 for the plaquette (mu nu) (translation
invariance and the Ward–Takahashi identity (I.4.15) are used exactly as on p. 282; no rotation is used there). ∎
CONSEQUENCE. Balaban's isotropic counterterm -b_j A(h_z, U_k) removes b_j iota; the remainder y_j := (y^m_j, y^W_j) is a
constant ORIENTATION-DEPENDENT plaquette weight. It is carried as a coupling field in the reference action:
  x_j A(U)  ->  sum_p x_j (1 + d_j(pi(p))) A_p(U),   d_j(pi) = d^m_j mu_pi + d^W_j omega_pi,   d_j real,
pi(p) the orientation of the plaquette p. This is M3d's coupling-field device with D(p) = x_j d_j(pi(p)), depending on p
only through its orientation, constant in position, REAL — the regime in which M3dR's verdict on Theorem PI-4 is HOLDS
(REVIEW 5.7, 5.13: real d, Balaban's real shift) — and polylog-small (|d_j| = O(g^2), §5), the regime in which M3dR 5.1
finds even the reference R-operation sufficient. Kill-switch K-A is not met: no chair (off-diagonal) term is needed.
For the left multiplication L_q (ME2's choice, G' = Q_8) the invariant forms include theta and seven Weyl directions, some
off-diagonal, which would need chair terms outside the device; the PLANAR rotation is the right choice for Route C.

## 5. LEMMA Sigma_chi, PART 2 — AT ONE LOOP THE ANISOTROPIC REMNANT IS A TRANSIENT (PROVED GIVEN the inputs named)

Notation. S^R_k: the k-step tree action of the skew construction (skew step R(a Z^4) -> L a Z^4, then k - 1 standard
steps), a functional on L^k a Z^4; S_k: the standard k-step tree action from a Z^4; S_infty := lim S_k (the classically
perfect action of the standard blocking, M3f (U1)). For S in Balaban's class with Wilson's dimension-four part (Lemma
6.2' of ME2 for S^R_k; Lemma WI of M3f), define the ONE-LOOP FINITE TENSOR c(S) in Sym^2(Lambda^2) by
  Pi^T_S(P)_{lambda kappa} = 2 [ 8 b_0 ln(1/|P|) chi_0 + c(S) ]^{mu lambda rho kappa} P_mu P_rho + o(P^2),
the transverse one-loop polarization of S read as a form on Lambda^2 (M3f §9's scalar c(S) is its trace part when S is
B_4-invariant; for S^R_k it is a G'-invariant form). c^an(S) := its anisotropic (trace-free on Lambda^2, theta-free) part.

THEOREM 5.1 (the one-loop dimension-four coefficient of the skew construction). For every k >= 1,
 (a) W^(1)_k = [8 b_0 k ln L + c_W] Id - c(S^R_k)  (skew construction),   W^(1)_k = [8 b_0 k ln L + c_W] Id - c(S_k)  (standard);
 (b) c(S_k) and c(S_infty) are multiples of Id; c(S^R_k) is G'-invariant;
 (c) |c(S^R_k) - c(S_k)| <= C_B d(S^R_k, S_k) <= C_B C_T L^{-2k} k^c, d the kernel distance of Theorem B1's proof.
Hence the anisotropic one-loop coefficient y^(1)_k = -c^an(S^R_k) is O(L^{-2k} k^c), and at the SAME bare coupling the
isotropic one-loop coefficients of the two constructions differ by c^iso(S_k) - c^iso(S^R_k) = O(L^{-2k} k^c).
PROOF. (a) M3f's stage identity (Theorem 7.1, Lemma 7.2, Lemma 7.3 with local covariance 14.2, Corollary 7.4) is finite-
dimensional Gaussian algebra for any surjective linear constraint D = dQ at a non-degenerate constrained minimum; apply it to
the composite constraint Q^(k-1) Q^R. Its hypotheses: (h1) invariance under R = ker pi: unchanged; (h2) non-degeneracy of the
skew-constrained minimum: CMP 102 Theorem 1 for one skew block type (ME2 6.5's single-step input); (h3) the axial gauge on
each skew block (its own tree of paths); (h4) the coarse gauge condition, G'-covariant. So, at order P^2,
Pi_{W_k}(P) = Pi^R_f(P; U*) - Pi_{S^R_k}(P) + o(P^2). The fine term: by M3f §8 with the correction 14.1 (the Euler–Lagrange
equation d*dA* = Q*lambda, lambda = Delta_k a; d*d invertible on transverse modes at every alias p_l != 0 of the FINE lattice
R(a Z^4)) the alias terms are O(P^4); the zero alias has amplitude I + O(P^2) (ME2 6.7: gauge covariance fixes I, -1 in G'
kills O(P)) and contributes Pi^R_f(P) + O(P^4). Pi^R_f is the one-loop polarization of the ROTATED Wilson action: at order P^2
it is R B_4 R^{-1}-invariant, and R B_4 R^{-1} acts absolutely irreducibly on Lambda^2 (Lemma 3.1 of ME2 transported by R),
so it is [8 b_0 ln(L^k/|P|) + c_W] Id with Wilson's own c_W (an isometry does not change a dimensionless constant). The
coarse term: Theorem B1 applies to S^R_k on the class with G' in place of W(B_4): Lemma WI uses the inversion -1 (in G') to
kill dimension-five parts and a reflection to kill the theta part (G' contains the reflections of the (2,3)-plane), and
transversality from the Ward identities; so Pi_{S^R_k} = [8 b_0 ln(1/|P|) Id + c(S^R_k)] (P,P) + o(P^2). Subtract.
(b) B_4-invariant forms on Lambda^2 are multiples of Id (S-1); G'-invariance is inherited from the construction.
(c) In Theorem B1's proof c(S) - c_W = integral of c_2^S(q) d^4q, and c_2^S is a sum of products of the kernels G_S, V_3^S,
V_4^S with at least one difference factor. For two actions of the class, c_2^S - c_2^{S'} is a sum of terms each containing
a factor K_n^S - K_n^{S'} (n = 2, 3, 4) and otherwise class-bounded factors; since both actions have Wilson's dimension-four
part, K_2 differs by O(|p|^4), K_3 by O(|p|^3), K_4 by O(|p|^2), with coefficients <= d(S, S'), and the power counting of
B1 step (4) gives |c_2^S - c_2^{S'}| <= C (1 + |q|^{-2}) d(S, S'), integrable. For the pair (S^R_k, S_k) the kernel distance
is the tree-level contraction at the level of Taylor kernels, d <= C_T L^{-2k} k^c: the kernel form of (T_loc) for the
rotated pair (Lemma 6.2's sandwich gives it for the action values; Cauchy estimates on Balaban's complex domain give the
kernels once (T_loc) holds). ∎
STATUS: PROVED GIVEN [(h2) for the skew block = ME2 6.5; (r1)–(r2) of M3f 7.3; Theorem B1's inputs ((190), M3e); (T_loc)
at kernel level for the rotated pair]. Every input is one E1 already needs, or ME2's skew single step.

COROLLARY 5.2 (THE REMNANT IS A ONE-LOOP TRANSIENT). The O(1) anisotropic remnant created by the skew step (ME2 6.3),
y_1 = -c^an(S^R_1), is cancelled by the later standard steps: the per-step one-loop anisotropic increments are
sigma_0 = -c^an(S^R_1), sigma_j = c^an(S^R_j) - c^an(S^R_{j+1}) (j >= 1), they TELESCOPE, and the cumulative one-loop
anisotropy after k steps is -c^an(S^R_k) = O(L^{-2k} k^c). WHY: the full one-loop integration of the rotated Wilson theory is
isotropic at dimension four (its P^2 polarization is R B_4 R^{-1}-invariant); the skew step's anisotropy is an artefact of
splitting that integral with an anisotropic cutoff (the skew block), and the B_4-symmetric later steps, which integrate the
modes just below the skew block's scale where S^R_1's anisotropic irrelevant terms are still O(1), see that edge and
compensate. Only the not-yet-integrated remainder -c(S^R_k) is anisotropic, and it is exactly as anisotropic as the tree
action S^R_k, which contracts to the B_4-symmetric perfect action.
CORRECTION TO ME2 §6.4 (ME2's file untouched). "The row CONTRACTS, but at the asymptotic-freedom rate, not geometrically"
holds for an anisotropy placed in the BARE action (the SME k_F of Colladay–McDonald). For the skew construction the
one-loop row contracts at the TREE-LEVEL rate L^{-2k}; the asymptotic-freedom running acts only on the residue that
survives at the next order (§6). ME2's "feed-in ... O(g_k^2 L^{-beta'(k-1)}) per step" undercounts the first standard step:
there S^R_1's anisotropic irrelevant part is O(1) in units of the current scale, and its one-loop feed-in is c^an(S^R_1)(1 -
O(L^{-2})) — the SAME order as y_1 and of the opposite sign; that is the telescoping.

## 6. RESULTS OF `bin/me2b_oneloop.py` AND LEMMA Sigma_chi, PART 3 (THE PER-STEP MAP WITH CONSTANTS)

### 6.1 RESULTS (record `rec/me2b_oneloop_run.2026-11-02b.txt`, rc = 0, about 6 min; §2.2 not edited)
Run a (`rec/me2b_oneloop_run.2026-11-02a.txt`) died at `import sympy` under `python -I`, which hides the user
site-packages; run b without -I (the script reads no downloaded data). Built-in checks: u(chi_0) + (gauge-fixing vertex)
= v and d0(chi_0) + q q = q^2 delta, both TRUE (the vertices are right).
- K-1 MET: gluon loop = -10/3 (p^2 delta - pp), ghost loop = -1/3 (p^2 delta - pp), both transverse; A_0 = -11/3 (unit:
  C_2 ln(Lambda/mu)/(8 pi^2) times the tree structure 2 chi_0 pp): 1/g^2_eff = 1/g^2 - (11/3) C_2 ln/(8 pi^2).
- K-2 MET: the response to k = chi_0 is EXACTLY 0. theta: tree structure and response both identically 0.
- O-1 MET: metric h = diag(1,1,-1,-1): lambda = -11/3, lambda/A_0 = 1; metric h = e_0e_1 + e_1e_0: lambda = -11/3,
  lambda/A_0 = 1; both transverse. THE RELATIVE METRIC ANISOTROPY HAS NO ONE-LOOP LOGARITHM.
- O-2 MET: Weyl (the planar invariant omega): lambda = -6; Weyl (a random Weyl tensor, projected exactly off iota, theta
  and the nine metric forms): lambda = -6; lambda/A_0 = 18/11 for both; transverse. So, relative to the coupling,
  delta_W(mu) = delta_W(Lambda) [1 + (lambda_W - A_0) C_2 g^2 ln(Lambda/mu)/(8 pi^2)], lambda_W - A_0 = -7/3, i.e.
  d ln(delta_W)/d ln(mu) = +(14/3) C_2 g^2/(16 pi^2): Colladay–McDonald's eq. (44), DERIVED HERE INDEPENDENTLY and met
  exactly. Per Balaban step (ln L of momentum integrated):
     delta^W_{k+1} = delta^W_k (1 - c_W g_k^2),   c_W = (14/3) C_2 ln L/(16 pi^2) = (7/11) c_0,
  with c_0 g_k^2 := (x_k - x_{k+1})/x_k at one loop; in ANY normalization delta^W_{k+1}/delta^W_k = (x_{k+1}/x_k)^{7/11}
  + O(g^4). The exponent 7/11 is the same for every compact simple G (both coefficients are proportional to C_2(G)).
What the computation is: the k-linear part of the p^2 log coefficient of the background two-point function for the action
(1/4g^2)(chi_0 + k) F F in k-independent background Feynman gauge, delta Gamma = (1/2)[-Tr(G V1 G d1) + Tr(G V1 G V1 G d0)],
in exact rational arithmetic (S^3 angular averages of monomials through Gamma(a+1/2) products). By Schur the response is a
scalar on each O(4)-irreducible summand of the Riemann-type tensors; the run reads the two scalars and checks the claim on
a random Weyl tensor. The divergent part is gauge-fixing independent (a difference between gauges is proportional to the
equations of motion D_mu(chi F)^{mu nu}, and no dimension-four gauge-invariant local functional is: it would need a local
covariant dimension-one vector), so the k-independent gauge fixing is legitimate; K-2 is that statement, checked.

### 6.2 THE PER-STEP MAP (Lemma Sigma_chi, the statement)
Setting of Proposition 4.1 (planar R, L = 5^m); the anisotropic row d_k = (d^m_k, d^W_k), the real orientation field of §4.
For every standard step k -> k+1 (k >= 1) and P in {m, W},
   d^P_{k+1} = (1 + mu^P_k) d^P_k + s^P_k,
 (i) NO MIXING: the linear map d_k -> d_{k+1} is diagonal in (metric, Weyl) and does not feed the isotropic coupling;
 (ii) MULTIPLIERS: mu^m_k = g_k^2 (phi^m_k - phi^m_{k+1}) + rho^m_k,  mu^W_k = -c_W g_k^2 + g_k^2 (phi^W_k - phi^W_{k+1}) + rho^W_k,
      |phi^P_k| <= Phi,  |phi^P_k - phi^P_{k+1}| <= Phi' L^{-2k} k^c,  |rho^P_k| <= C_rho [(g_k^2 + eps_1 g_k) g_k^2 + e^{-p_0(g_k)}];
 (iii) SOURCES: s^P_k = sigma^P_k / x_{k+1} + r^P_k, sigma_k the telescoping one-loop increments of Corollary 5.2, and
      |r^P_k| <= C_r [ (g_k^2 + eps_1 g_k) g_k^2 + e^{-p_0(g_k)} ] [ L^{-2k} k^c + E_0 L^{-k} ];
 (iv) UNIT SCALE: |d^m_K| <= C [ gamma^2 L^{-2K} K^c + (g_0^2 + eps_1 g_0) g_0^2 E_0 + e^{-p_0(g_0)} ],
      |d^W_K| <= C [ gamma^2 L^{-2K} K^c + ((g_0^2 + eps_1 g_0) g_0^2 E_0 + e^{-p_0(g_0)}) (x_K/x_0)^{7/11} ].
 In absolute units (y = x d): |y^m_K| = O(X (eps_1 g_0^3 + g_0^4)) = O((log 1/eps)^{-3/2}) -> 0, the Weyl part smaller by
 the factor (g_0^2/gamma^2)^{7/11}.

### 6.3 PROOFS
(i) PROVED. A standard step is B_4-covariant, so its linear response on Sym^2(Lambda^2) is B_4-equivariant. It commutes
with the sign subgroup (Z/2)^4, which acts trivially on diagonal forms and by non-trivial characters on every off-diagonal
pair (P-3), so it maps diagonal forms to diagonal forms; on diagonal forms it is S_4-equivariant, and the S_4-summands trivial
(1), standard (3) and two-dimensional (2) are pairwise non-isomorphic and absolutely irreducible, so it is a scalar on each
(Schur) and maps no summand into another. mu (row sums 2h) lies in the standard summand, omega (row sums 0, mean 0) in the
two-dimensional one, iota in the trivial one (P-3). ∎
(ii) The ONE-LOOP part of the multiplier is the d-derivative of the step's one-loop second-order output. By the stage
identity with the orientation field in the reference action (Theorem 5.1(a) for the d-deformed construction: the bare
action is the orientation-weighted Wilson action and the tree actions S^R_k(d) are its blockings, which converge as
k -> infinity because blocking preserves a dimension-four term and contracts the rest), the cumulative one-loop coefficient
is [(log part)(d) + c_W(d)] - c(S^R_k(d)), so the per-step one-loop response along P is
   (universal log part) + [phi^P_k - phi^P_{k+1}],   phi^P_k := (d/dd) [P-component of c(S^R_k(d))] at d = 0.
The universal log part is the continuum one-loop coefficient, COMPUTED in 6.1: zero relative to the coupling for P = m,
-c_W g_k^2 for P = W (the absolute coefficient y = x d changes by lambda_P C ln L (y/x) while x changes by A_0 C ln L, so d
changes by (lambda_P - A_0) C g^2 ln L d, C = C_2/(8 pi^2)). Theorem B1's difference integral with the orientation-weighted
Wilson action as the reference (same infrared, so the difference integrand has no 1/q^4 singularity) gives |phi^P_k| <= Phi;
its Lipschitz form (proof of Theorem 5.1(c)) with the kernel contraction of S^R_k(d) gives |phi^P_k - phi^P_{k+1}| <=
Phi' L^{-2k} k^c. The HIGHER-ORDER part rho: the step's second-order output is analytic in d on |d| < theta_G (M3f Lemma D,
10.3 (a); d is real here, so M3dR's PI-4 hole does not arise), its history part is of order (g_k^2 + eps_1 g_k) (M3d PI-5
(3.2) with M3dR's repair 5.10: the moment-form computation to be written out), and its large-field part is bounded by
e^{-p_0(g_k)}; Cauchy's estimate on the disc bounds the d-derivative beyond one loop. PROVED GIVEN [the stage identity's
inputs as in Theorem 5.1; Theorem B1 on the orientation-weighted class; Lemma D; PI-5 (3.2) with M3dR's repair].
ME2's FALSIFIERS, now DECIDED at one loop: a per-step O(g^2) logarithm in the metric multiplier — NOT MET (lambda_m = A_0
exactly); a Weyl coefficient of the wrong sign exceeding c_0 — NOT MET (c_W = (7/11) c_0 > 0).
(iii) The one-loop sources are Corollary 5.2's sigma_k. The rest: for a B_4-invariant input a standard step produces NO
anisotropic second-order output (B_4-covariance and S-1), its large-field R-terms included; the output is analytic in the
input data (Lemma RL, M3f 3.3), so its anisotropic part is Lipschitz in the input's anisotropy — the tree background
(O(L^{-2k} k^c), Theorem 5.1(c)'s kernel distance), the orientation field (that part is the multiplier), and the
anisotropic E-history (created at the skew step with norm <= E_0, entering step k with the weight L^{-(k-m)} of (W), M3f 3.4).
The Lipschitz constants are those of the higher-order part, (g_k^2 + eps_1 g_k) (PI-5 (3.2)) and e^{-p_0(g_k)} (LFR II
(1.100)). Dividing by x_{k+1} gives relative units. PROVED GIVEN [Lemma RL with (ROB); (W); PI-5 (3.2) repaired; LFR II (1.100)].
(iv) Solve the linear recursion: d^P_K = sum_k [prod_{k<j<K} (1 + mu^P_j)] s^P_k (with d^P_1 = s^P_0). METRIC: sum_j |mu^m_j|
<= Phi' gamma^2 sum_j L^{-2j} j^c + C_rho sum_j [(g_j^2 + eps_1 g_j) g_j^2 + e^{-p_0(g_j)}] <= C gamma^2 (sum_j g_j^4 <= C gamma^2
along Theorem 2's profile), so every product is 1 + O(gamma^2). WEYL: prod_{k<j<K} (1 - c_W g_j^2) = (x_K/x_k)^{7/11} (1 + O(gamma^2))
(the one-loop flow x_{j+1} = x_j - c_0 x_j g_j^2 + O(1)). ONE-LOOP SOURCES by Abel summation: with T_k := sum_{j<k} sigma_j =
-c^an(S^R_k) and w_k := prod_{k<j<K} (1 + mu_j) / x_{k+1},
   sum_k (T_{k+1} - T_k) w_k = T_K w_{K-1} - sum_{k<K} T_k (w_k - w_{k-1});
|T_k| <= C L^{-2k} k^c and |w_k - w_{k-1}| <= C (g_k^4 + |mu_k| g_k^2), so the sum is (T_K/X)(1 + O(gamma^2)) + O(g_0^4): the
transient at the unit scale, O(gamma^2 L^{-2K} K^c), plus a residue O(g_0^4). The r-sources sum to the stated bound, dominated
by k = O(1) because of the factors L^{-k}, L^{-2k}. ∎
WHAT CHANGED AGAINST ME2 §6.4. ME2: relative anisotropy at the unit scale O(g_0^2) (metric), O(g_0^2 (g_0^2/gamma^2)^{7/11})
(Weyl), absolute O((log 1/eps)^{-1}). Here: O(eps_1 g_0^3 + g_0^4) relative, O((log 1/eps)^{-3/2}) absolute: the one-loop part
telescopes (Corollary 5.2), the persistent residue starts at the next order, and the Colladay–McDonald running acts on it.

## 7. (E1-scale): NOT AN INPUT OF (E2); AND ITSELF REDUCED TO E1'S OWN KIND OF STATEMENT

### 7.1 THE SAME-BARE-COUPLING THEOREM
THEOREM 7.1 (FIRST-STEP SCHEME INDEPENDENCE OF THE UNIT-SCALE COUPLING). Let x_0(K) be the bare coupling that tunes the
original lattice a Z^4 (a = L^{-K}) to the unit-scale coupling X (unique, strictly increasing in X: M3f 14.6 (c)), and let
X^R(K) be the unit-scale coupling of the skew construction (lattice R(a Z^4), skew step, K - 1 standard steps) at the SAME
bare coupling x_0(K). Then
   |X^R(K) - X| <= C [ L^{-2K} K^c + (g_0^2 + eps_1 g_0) E_0 j_* + e^{-p_0(g_0)} ] -> 0   (K -> infinity),
g_0 = g_0(K) -> 0, j_* = O(log K) the (CB) step of M3f 6.5.
PROOF. x_K = x_0 - sum_k beta_k for each construction. ONE LOOP: the cumulative one-loop parts are beta^(1)(Q^K) =
8 b_0 K ln L + c_W - c(S_K) (M3f 8.3) and beta^{R,(1)}(Q^K) = 8 b_0 K ln L + c_W - c^iso(S^R_K) (Theorem 5.1(a), the rotated
Wilson action having Wilson's c_W): the difference c^iso(S^R_K) - c(S_K) is O(L^{-2K} K^c) by Theorem 5.1(c). The SAME total
log 8 b_0 K ln L appears in both because the skew step has scale factor L exactly (R(a Z^4) has spacing a, the coarse lattice
L a). BEYOND ONE LOOP: for k < j_* each construction's higher-order coupling increment is bounded by C (g_k^2 + eps_1 g_k) E_0
(Lemma M, PI-5 (3.2)), so their difference by twice that; for k >= j_* both densities are in one class after (CB) with
H_{j_*} <= C and Theorem U's coupling inequality (C), |delta_{k+1} - delta_k| <= w_k delta_k + C (g_k^2 + eps_1 g_k) g_k^2 H_k,
H_k <= q^{k - j_*} H_{j_*} + (terms driven by delta), with Gronwall (sum w_k <= C gamma) adds C (g_{j_*}^2 + eps_1 g_{j_*})
H_{j_*}. The anisotropic row feeds the isotropic coupling only at second order in d (Schur: a B_4-equivariant LINEAR map sends
the standard and two-dimensional summands to zero in the trivial one), O(g^4 |d|^2) per step. Sum. ∎
PROVED GIVEN [Theorem 5.1's inputs; Lemma M and PI-5 (3.2) for each construction; (CB) and Theorem U from j_* on] — the inputs
of ME2's E2-UV(T), nothing more.
CORRECTION TO ME2 §5.3 (ME2's file untouched). ME2's premise "the rotated lattice theory ... reaches the unit scale with an
isotropic coupling shifted by delta x = O(1) ... which does NOT vanish as a -> 0" is FALSE for the unit-scale coupling: the
skew step's O(1) one-loop finite part is cancelled by the finite parts of the following standard steps, because both
constructions' tree actions flow to the SAME perfect action S_infty and the bare actions are isometric (equal c_W). ME2's
Corollary 5.4 conclusion ("the skew and standard block schemes have equal Lambda-parameters in the limit") is thereby PROVED
DIRECTLY, without the mass gap. (Two schemes differing in EVERY step have a genuine one-loop Lambda-ratio c(S_infty) -
c(S'_infty); two bare actions that are not isometric have c_W - c_W'; neither occurs here.)

COROLLARY 7.2 (E2-UV AT THE SAME BARE COUPLING; R ITSELF STABILIZES THE LIMIT). Given ME2's E2-UV(T) (its backward-tuned
form, with §§4–6 in place of its §6.4) and the continuity of the limit in the unit-scale coupling,
|W_K(tau; X') - W_K(tau; X)| <= C N_T |X' - X| uniformly in K (the unit-scale density is analytic in its coupling; Theorem U
compares the histories; M3f Lemma D), one has
   W^rot_{K,T}(tau; x_0(K)) - W^orig_{K,T}(tau; x_0(K)) -> 0 .
By exact lattice covariance W^rot_{K,T}(tau; x_0; h) = W^orig_{K,R^{-1}T}(tau; x_0; h o R). Hence the original limit along
x_0(K) satisfies S_{R^{-1}T}(h o R) = S_T(h) on every common torus, and with the torus-shape independence of the
infinite-volume limit (ME2 7.6, given Hypotheses I–II at the exit scale), S_infty(h o R) = S_infty(h). ME2's Corollary 3.4
gives O(4). The similarity trick (ME2 Lemma 5.3), Corollary 5.4 (lambda = 1 from the gap) and (E1-scale) are NOT used.
PROOF. E2-UV(T) gives W^rot(x_0(K)) - W^orig(x_0'(K)) -> 0 with x_0'(K) tuning the original to X^R(K). Theorem 7.1 gives
X^R(K) -> X, continuity gives W^orig(x_0'(K)) - W^orig(x_0(K)) -> 0. ∎
PRECISION (on the infrared side of Route C). E2-UV(T) is a statement about GENERATING FUNCTIONALS, which are the exact torus
partition functions with sources (M3f 2.4 (a)); so on a FIXED torus it already gives equal limits of the 0++ Schwinger
functions, with no Dobrushin comparison. ME2's Theorem 7.1 (the averaged comparison at the exit scale) is one way to get the
torus-shape independence of the infinite-volume limit; any infrared control that gives that independence suffices.

### 7.2 (E1-scale) ITSELF
Notation: W_{X,T}(tau; h) := lim_K W_K(tau; h) along the tuning to X on the torus T (exists given E1, M3f 6.6).
PROPOSITION 7.3 (DISCRETE DILATIONS; PROVED GIVEN E1, continuity in X, and the convergence of X_j(K)). For j in Z with X and
Phi^j(X) in the weak-coupling range, W_{Phi^j(X), L^{-j}T}(tau; h) = W_{X,T}(tau; h o D_{L^{-j}}), D_lambda(x) = lambda x.
PROOF. Theory A: spacing L^{-K}, torus T, bare x_0(K, X); its coupling at scale L^j is X_j(K) (j more steps). Dilating
by L^{-j} gives EXACTLY theory B: spacing L^{-(K+j)}, torus L^{-j}T, the same bare coupling, which reaches X_j(K) at scale 1
after K + j steps. A source h on L^{-j}T for B is the source h o D_{L^{-j}} for A, and W^B_{K+j}(tau; h) =
W^A_K(tau; h o D_{L^{-j}}) identically (the source multiplies the same bare operator: no field renormalization enters at
the level of generating functionals). Let K -> infinity: X_j(K) -> Phi^j(X) (j further Balaban steps act continuously on the
convergent unit-scale density inside the weak-coupling range), and continuity in X identifies the limit of B. ∎
PROPOSITION 7.4 (CONTINUOUS DILATIONS; PROVED GIVEN the inputs of E1 for the DILATION PAIR). Let q >= 3 be odd with
log q / log L irrational (q = 3, L = 5^m: by unique factorization 3^a != 5^b). Assume E1's two-cutoff argument for the pair
(Wilson on (1/q) a Z^4, one centred factor-q step onto a Z^4, then standard steps) versus (Wilson on a Z^4, standard steps):
the sandwich (M3f Lemma 6.2, verbatim — hard constraints compose), Lemma 6.2' (B_4-symmetric block, normalization by gauge
covariance: verbatim), Theorem U with NO extra row (the factor-q block is B_4-covariant, its one-loop terms are B_4-invariant
and (Sym^2 Lambda^2)^{B_4} = R Id), (T_loc) and (CB) for this pair, and Balaban's single-step estimates for one centred cube of
side q (a finite-geometry instance, as ME2 6.5). Then for every lambda > 0 and admissible X there is X(lambda) with
W_{X(lambda), lambda T}(tau; h) = W_{X,T}(tau; h o D_lambda): the limits at all renormalization conditions form ONE
dilation family.
PROOF. Theory B on (1/q) a Z^4 at bare x_0 is EXACTLY D_{1/q} of the theory on a Z^4 at bare x_0. The comparison gives
lim B = the original limit at B's own unit-scale coupling X^q(K) (backward tuning plus continuity); by the one-loop
telescoping of §5 applied to this pair, X^q(K) - X = -8 b_0 ln q + [c(S^q_K) - c(S_K)] + O(g_0^2 + eps_1 g_0) -> -8 b_0 ln q +
(universal higher-loop terms), convergent. So lambda = 1/q maps the family into itself. With Proposition 7.3, every lambda in
the group L^Z q^Z does, and L^Z q^Z is dense in R_{>0}. For general lambda take lambda_n -> lambda in that group: the
generating functionals are continuous in lambda (dilation acts continuously on the source space), X(lambda_n) stays in a
compact interval (|X(lambda_n) - X| <= 8 b_0 |ln lambda_n| + C), and a convergent subsequence X(lambda_n) -> X* gives
W_{X*, lambda T} = W_{X,T}(. o D_lambda) by continuity in X. ∎
THE EXPLICIT PARAMETRIZATION (by-product of the telescoping): X(lambda) = X + 8 b_0 ln lambda + (two-loop universal
terms) + o(1): the finite one-loop parts of the two schemes cancel, so the family is parametrized by the universal running alone.
STATUS. (E1-scale) is PROVED GIVEN E1's inputs for one more commensurable pair — a cutoff change by the odd factor q, the same
kind of object as the two-cutoff comparison itself, with no anisotropic row. It is NOT an input of (E2) (Corollary 7.2).

## 8. THE TARGET: ALPÖGE–SUSSMAN'S RP TRICK, READ WHOLE — VERDICT, THE FALSIFIER'S SITE, THE VERSION THAT HOLDS

### 8.1 WHAT RPM1 PROVES AND HOW (READ IN FULL, `src_rpm1/RPM1.tex` lines 692–2866)
Theorem A: a Borel law mu on S'(R^d; T) (T a real orthogonal O(d)-representation with planar weights in {-2,...,2}) with
(i) the Glimm–Jaffe growth bound E e^{F(chi)} <= exp C(|chi|_1 + |chi|_2^2) for EVERY real Schwartz chi, (ii) translation
invariance, (iii) reflection positivity across every coordinate hyperplane and every diagonal hyperplane {x_j +- x_k = 0},
has S_N(R* chi) = S_N(chi) for all R in O(d) and all disjoint-support tuples chi. The chain: OS Hilbert spaces for the
time and for the diagonal reflection; Prop. 3.1 H >= |P| (the same translated reflection pairing read in both spaces, then a
Laplace transform with h(s) = s^{i F} e^{-eps s}); complex translations on {Re t > |Im x|}; §5.2 a field in a time slab is a
bounded operator between Euclidean evolutions; §5.3 a field localized at a planar point (transverse variables smeared) between
complex translations has norm <= K(|f|_1 + |f|_2/q_0); §5.4 ordered kernels |S_N(Z; f)| <= K^N prod(|f_j|_1 + q_*^{-1}|f_j|_2);
§6 for narrow configurations the angular defect D_N continues to an entire 2 pi-periodic function with |D_N(theta + i beta)|
<= C e^{3N|beta|} (insertion power 1 plus tensor weight 2), so its frequencies satisfy |l| <= 3N, l in 4Z; §6.2–7 Glaser's
continuation of the reflection form to imaginary angles, Cauchy–Schwarz (2M_{a+b} <= M_{2a} + M_{2b}), the comparison with
the law rotated by 45 degrees (M_{2a} in 8Z), and the integer lemma force every M_N = 0.

### 8.2 VERIFICATION OF THE DEDUCTION (each step re-derived here; CHECKED)
- Prop. 3.1 (H >= |P|): CHECKED. The identity int|Lh((omega - ip)/2)|^2 d rho = int Lh(omega) conj(Lh(ip)) d rho_Delta holds on
  delta u, delta v > 0; |Lh(z)| = |C| |1 + z/eps|^{-1} e^{F arg(eps + z)} gives the right side <= ||rho_Delta|| |C|^2 e^{pi|F|/2}
  and the left side >= c e^{(pi/2 + 2 eta)|F|} on any spectral set with |arg(eps + (omega - ip)/2)| > pi/4 + eta; so
  supp rho in {|p| <= omega + 2 eps}. The two pairings agree because A in {t > |x|} gives T A and J_Delta J_o A in {v > 0}.
- Lemma 4.1 / Theorem 4.2 (Glaser): CHECKED (the congruence Z_L M[N+L](z_0) Z_L^dagger; openness and closedness; connected O).
- Lemma 2.3 (analyticity across a separating hyperplane): CHECKED; it needs H >= |p_i| for every tangential coordinate, i.e. the
  diagonal reflections in every coordinate plane containing the normal.
- §§5.2–5.4: the dyadic reflection, Cauchy's estimate and the holomorphic mean value on a polydisc: CHECKED as inequalities,
  GIVEN (i).
- Prop. 6.1 (growth): CHECKED: q(R(-i beta) z) >= e^{-|beta|} q(z), the quarter-turn charts cover C with overlapping strips, the
  tensor bound e^{2|beta|} for weights <= 2, the contour shift.
- Lemma 6.2 (testing), the continued pairing, convexity, the 45-degree divisibility: CHECKED (the 45-degree rotated law
  satisfies (i)–(iii) because Q permutes the four planar mirrors and |.|_1, |.|_2 are rotation invariant).
- Lemma 7.1 (integer lemma): CHECKED, and SHARP IN ITS CONSTANT: with M_N <= c N in place of 3N the lemma closes IFF c < 4
  (M_2 <= 2c < 8 forces M_2 = 0, and a positive even increment >= 8 contradicts M_{2n} <= 2cn); at c = 4 the sequence M_n = 4n
  meets every constraint (M_n in 4Z, M_{2n} = 8n in 8Z, convexity with equality) — which is RPM1's own weight-3 example (M_2 = 8).
VERDICT: the deduction (i) + (ii) + (iii) => O(d)-covariance off coincidences is CORRECT as written (no gap found in any step).

### 8.3 WHERE THE GROWTH BOUND IS USED — THE FALSIFIER IS MET, AT ONE SITE
(i) enters in three ways. (1) STRUCTURAL, AT COINCIDENT POINTS — THE FALSIFIER: §5.2 "A field in a time slab", eq.
(slab-source): ||e^{F(h)} U(l e_0) A|| <= e^{C(|Re h|_1 + |Re h|_2^2)} ||A||, proved by the Seiler–Simon dyadic reflection whose
terminal step applies (i) to E e^{2F(Re h_r)}, h_r the sum of 2^r reflected copies of h — the full exponential moment of one
smeared field, every self-coincidence F(h)^n included; then (insertion-bound) ||B_delta(chi)|| <= K(|chi|_1 + |chi|_2) by
Cauchy's estimate, and (point-bound) by the mean value. (2) CONVENIENCE: the L^2(mu) framework (moments of F(chi), density of
polynomials, the L^4 truncation footnote, Appendix A). (3) CONVENIENCE: the passage from compactly supported to Schwartz
disjoint tuples (§8). For the renormalized action density in d = 4, (i) fails in the strongest way: S_2(x) ~ c|x|^{-8}
(log 1/|x|)^{-2} is not locally integrable, so E F(chi)^2 = infinity for chi >= 0 not vanishing at coincidence — even (2)
fails, not only the constant. RPM1 also says so for Gaussian laws: (i) forces the covariance to be L^2-bounded.
REPLACEMENTS FOR (2), (3) (PROVED): the OS reconstruction from Schwinger functions defined on disjoint-support tuples only.
The Hilbert space H_o is the completion of span{Psi(chi)}, chi disjoint-support tuples in {t > 0}, with <Psi(chi),Psi(eta)> =
S(J chi, eta) — all points distinct (J chi in t < 0, eta in t > 0, each tuple disjoint); contractivity of e^{-sH} from the
OS iteration ||U(s)A||^{2^n} <= ||A||^{2^n - 1} ||U(2^n s) A|| with POLYNOMIAL growth of S(J chi, tau_{2r} chi) in r (from (E0)-
continuity: translated Schwartz norms grow polynomially) instead of the L^2(mu) bound; the same for H_Delta. Prop. 3.1 then
holds verbatim: for A = Psi(chi) with chi in {t > |x|}, T A and J_Delta J_o A are disjoint-support tuples in {v > 0}, and every
quantity in its proof is a Schwinger function at distinct points. Lemma 2.3 likewise. Only (1) carries content.

### 8.4 THE VERSION THAT HOLDS FOR SMEARED RENORMALIZED FIELDS
THEOREM 8.1 (A' — RPM1 with the growth bound replaced by a planar insertion bound). Let S_N be defined on disjoint-support
tuples, (E0)-continuous, polynomially bounded under separating translations, translation invariant and reflection positive
across every hyperplane of the family N. Suppose
 (P_k) the planar-point insertion of the field (transverse profile f in L^1 cap L^infty), defined as the limit of slab
       insertions on the OS Hilbert space, satisfies ||V(q_0 e_0) phi(0; f) V(q_0 e_0)|| <= K(f) (1 + q_0^{-k}),
with k + w < 4, w the largest planar weight. Then S_N(R* chi) = S_N(chi) for all R in O(d), all disjoint tuples chi.
PROOF. After §5.2, (i) is used only through (insertion-bound)/(point-bound). Complex translations factor as
V(xi) = V(q_0 e_0) V(xi - q_0 e_0) with V(xi - q_0 e_0) a contraction (|p| <= omega), so (P_k) gives ||A_f(xi, eta)|| <=
K(1 + min(q(xi), q(eta))^{-k}): (P_k) IS a real-time statement. The ordered kernels obey |S_N(Z; f)| <= K^N prod_j (1 + q_*^{-k}),
Prop. 6.1 gives |D_N(theta + i beta)| <= C e^{(k + w) N |beta|}, so M_N <= (k + w) N, and the integer lemma (8.2, sharp form)
closes because k + w < 4. Every other step is §8.2/§8.3. ∎
FOR THE PROGRAM'S OBSERVABLE. The 0++ field is a scalar (w = 0). Its scaling dimension is 4, so the planar two-point singularity
of the transversely smeared field is s^{-(2.4 - 2)} = s^{-6}, i.e. power k = 3 per insertion, with the logarithmic suppression of
asymptotic freedom: INSIDE the margin (3 < 4). In d dimensions tr F^2 has k = d/2 + 1: d = 3 gives 5/2 (consistent with YMM1's
3D claim of Euclidean invariance), d = 4 gives 3, d = 5 gives 7/2, d = 6 gives 4 (fails). The stress tensor (dimension 4,
weight 2) has k + w = 5: NOT covered; F_mu nu (dimension 2, two-form weight 1) has 2: covered.
GRADIENT-FLOWED FIELDS: at fixed flow time they obey growth bounds, but the heat kernel's Gaussian tails cross every reflection
plane, so their correlations are not exactly reflection positive: they do not satisfy (iii). Compactly supported smearings of
the renormalized field satisfy (iii) and the OS replacements of §8.3 but violate (i); Theorem 8.1 is the version that fits them.

### 8.5 THE TWO-POINT THEOREM — NO OPERATOR BOUND, NO INFRARED INPUT
THEOREM 8.2 (EUCLIDEAN INVARIANCE OF A REFLECTION-POSITIVE TWO-POINT FUNCTION). Let S_2 be a translation-invariant two-point
function of a real scalar field on R^d, defined on disjoint supports, (E0)-continuous and polynomially bounded at large
separation, reflection positive as a two-point form across every hyperplane of N, with the short-distance bound
 (SD_2) |S_2(x)| <= C |x|^{-2Delta} for 0 < |x| <= 1, with 2 Delta - (d - 2) < 8.
Then S_2(R* chi) = S_2(chi) for every R in O(d) and every disjoint pair chi.
PROOF (the N = 2 case of RPM1, every step using S_2 alone).
 1. Hilbert spaces from single-field vectors Psi(chi) (RP of S_2); contractivity by the OS iteration with polynomial growth.
 2. Cone: the spectral measure of every single-field vector is supported in {omega >= |p_i|} for each tangential coordinate:
    Prop. 3.1 with A = Psi(chi) involves only S_2.
 3. THE CONTINUATION BOUND. For the planar-point vectors Psi_s(f) := lim_{eps -> 0} Psi(j_eps(. - s e_0) f) (Cauchy in the OS
    norm: the differences involve S_2 only at time separations close to 2s), S_2(Delta; f_1, f_2) = <Psi_{q'/2}(f_1),
    V(Delta - q' e_0) Psi_{q'/2}(f_2)> for Delta in W, 0 < q' < q(Delta), and V(Delta - q' e_0) is a contraction (its spectral
    multiplier has modulus e^{-omega(Re Delta_t - q') + p Im Delta_x} <= 1 on {|p| <= omega}). Cauchy–Schwarz and q' -> q(Delta):
       |S_2(Delta; f_1, f_2)| <= [S_2^re(q(Delta) e_0; f_1) S_2^re(q(Delta) e_0; f_2)]^{1/2},
    S_2^re(s e_0; f) = int int conj(f(y)) f(y') S_2(s, 0, y - y') dy dy' <= |f|_inf |f|_1 int_{R^{d-2}} C (s^2 + u^2)^{-Delta} du
    = C' s^{-(2 Delta - (d-2))} by (SD_2). THE CONTINUED TWO-POINT FUNCTION IS BOUNDED BY THE REAL ONE AT q(Delta).
 4. Growth: on narrow pairs D_2 continues to an entire periodic function with |D_2(theta + i beta)| <= C e^{(2Delta - (d-2))|beta|}
    (q(R(-i beta)Delta) >= e^{-|beta|} q(Delta); the scalar profiles do not rotate). Frequencies: l in 4Z (quarter turns are
    symmetries, Prop. B.1 of RPM1 from RP + translations), |l| <= 2 Delta - (d - 2) < 8, so l in {0, +-4}.
 5. l = +-4 is excluded: the reflection form on single fields continues (Glaser's lemma; joint holomorphy from step 3) and its
    leading coefficient c_{-4}[J chi, chi] is >= 0, and > 0 for some admissible chi if M_2 = 4 (testing lemma, N = 2); the law
    rotated by 45 degrees satisfies every hypothesis and has leading coefficient e^{-i pi} c_{-4} < 0. So M_2 = 0 and D_2 = 0 on
    narrow pairs. EVERY pair with distinct planar projections is narrow (one difference vector); pairs with equal planar
    projections are reached by Lemma 2.3 across a transverse hyperplane (step 2 in the other planes); the small-angle lemma
    gives all angles; every coordinate plane gives SO(d), the reflections O(d). ∎
FOR THE PROGRAM. The continuum 0++ two-point function: lattice RP across coordinate planes (Osterwalder–Seiler) and across
diagonal planes (ME2 Theorem 9.1, every compact G), passing to limits; translation invariance from the dense lattice
translations; (E0) from the construction. With Delta = 4, d = 4: 2 Delta - (d - 2) = 6 < 8, margin 2 (asymptotic freedom's
(log)^{-2} only helps). So:
COROLLARY 8.3 (THE GAP-CARRYING CHANNEL IS EUCLIDEAN INVARIANT). Every subsequential infinite-volume continuum limit of the
SU(2) Wilson theory whose 0++ two-point function obeys (SD_2) with Delta < 5 has an O(4)-invariant 0++ two-point function.
PROVED GIVEN [(SD_2); diagonal RP on the tori of the construction (ME2 Theorem 9.1 is proved on boxes; on a torus of even side
the diagonal reflection has a second invariant set, x_1 - x_2 = N/2, whose bisected plaquettes have the same structure — to be
written); existence of subsequential limits with (E0), which the corpus's 4D draft asserts]. NO crossover, NO gap, NO
uniqueness of the limit, NO Lemma Sigma_chi, NO (E1-scale): every subsequential limit qualifies.
THE NEXT OBJECT OF THE RP ROUTE (full (E2)): (P_k) with k < 4 for the renormalized action density, N >= 3 — the operator bound
||e^{-q_0 H} O(0; f) e^{-q_0 H}|| <= K (1 + q_0^{-k}) on the OS Hilbert space, uniformly in the cutoff. FALSIFIER: a state on
which the transversely smeared action density between Euclidean evolutions grows faster than q_0^{-4}. Its infrared content is
an operator norm over all states; in d = 4 the free massless analogue is IR-finite (||a(g) e^{-q_0 H}|| <= |g/sqrt(omega)|
(2 e q_0)^{-1/2} with int |f^|^2/omega^2 d^3k < infinity in three space dimensions), so the bound is short-distance in nature.

### 8.6 THE THRESHOLD OF THEOREM 8.2 IS SHARP (PROVED; an adversarial test of 8.2, run after it was written)
Let psi be the massive free field on R^d (covariance (p^2 + m^2)^{-1}, scaling dimension (d-2)/2) and phi := (sum_mu d_mu^4) psi.
Then phi is a scalar under the hyperoctahedral group B_d (sum_mu p_mu^4 is B_d-invariant), its two-point function
S^_2(p) = (sum_mu p_mu^4)^2/(p^2 + m^2) is translation invariant and NOT rotation invariant, and it is reflection positive
across every hyperplane of N: across t = 0, for t != 0, S_2(t, x) = int d^{d-1}p e^{ipx} e^{-omega|t|} (omega^4 + sum_i p_i^4)^2/(2 omega),
omega = (p^2 + m^2)^{1/2}, a positive spectral weight (the residue at p_t = i omega of an even polynomial in p_t); across the
other coordinate and diagonal hyperplanes by the B_d-symmetry of sum p_mu^4. Its short-distance singularity is |x|^{-2 Delta} with
Delta = (d-2)/2 + 4, so 2 Delta - (d-2) = 8 EXACTLY: the borderline excluded by (SD_2). In the proof this is the frequency
l = 8, which passes the 45-degree test ((-1)^{8/4} = +1). So "2 Delta - (d - 2) < 8" cannot be relaxed to "<= 8". The operator
sum_mu d_mu^4 is the first B_d-invariant, O(d)-non-invariant differential structure — the Coxeter degree-4 invariant sum x_mu^4 of
ME2 Remark 3.5, the hypercubic lattice's dimension-six artefact — and the theorem says precisely that a reflection-positive
scalar of dimension below (d-2)/2 + 4 cannot carry it. The 0++ field (Delta = 4 in d = 4, threshold 5) sits one unit below.

## 9. THE LEDGER (this agent's rows)

| Item | Status | Where |
|---|---|---|
| G' for the planar skew block = C_4 x D_4 (32, 16 reversing); invariant forms on Lambda^2: 3, ALL DIAGONAL; metric (standard S_4-summand) and Weyl (2-dim summand) separate | COMPUTED (exact), stakes P-1..P-3 MET | §3, rec planar a |
| CMP 119 (3.56)–(3.64) without W(B_4): (3.61) becomes (1/2) sum beta'_{j,mu nu} tr F^2, three entries; isotropic b_j + anisotropic row (y^m, y^W) = a REAL orientation field in M3d's device | PROVED (from P-2 and pp. 281–283 READ on image) | Prop 4.1 |
| At one loop the anisotropic remnant is a TRANSIENT: cumulative W^(1)_k = [8 b_0 k ln L + c_W] Id - c(S^R_k), anisotropic part -c^an(S^R_k) = O(L^{-2k} k^c) | PROVED GIVEN [skew (h2) = ME2 6.5; (r1)–(r2); B1's inputs; (T_loc) at kernel level for the rotated pair] | Thm 5.1, Cor 5.2 |
| ME2 §6.4 corrected: the one-loop row contracts at the TREE rate L^{-2k}, not the asymptotic-freedom rate | PROVED (consequence of 5.1) | Cor 5.2 |
| One-loop anisotropic log coefficients of YM: metric lambda = A_0 (no relative log), Weyl lambda = (18/11) A_0, A_0 = -11/3 (gluon -10/3, ghost -1/3); Colladay–McDonald's 14/3 re-derived independently | COMPUTED (exact rationals), stakes K-1..K-3, O-1, O-2 MET | §6.1, rec oneloop b |
| Lemma Sigma_chi: per-step map diagonal; multipliers 1 + O(g^4)+telescoping (metric), 1 - c_W g^2 (Weyl), c_W = (14/3) C_2 ln L/(16 pi^2) = (7/11) c_0; sources telescoping + O((g^2 + eps_1 g) g^2 L^{-k}); unit-scale anisotropy O(eps_1 g_0^3 + g_0^4) relative | (i) PROVED; (ii)–(iv) PROVED GIVEN [Thm 5.1's inputs; B1 on the weighted class; Lemma D; PI-5 (3.2) repaired; Lemma RL, (W), LFR II (1.100)] | §6.2–6.3 |
| ME2's two falsifiers for the row (metric one-loop log; Weyl wrong sign > c_0) | DECIDED: NOT MET | §6.3 (ii) |
| Same-bare-coupling theorem: X^R(K) - X -> 0; ME2's "delta x = O(1) non-vanishing" FALSE; equal Lambda-parameters proved without the gap | PROVED GIVEN [E2-UV's inputs] | Thm 7.1 |
| E2-UV at the same bare coupling; R itself stabilizes the limit; similarity trick, Cor 5.4 and (E1-scale) NOT needed for (E2) | PROVED GIVEN [E2-UV(T), continuity in X, torus-shape independence] | Cor 7.2 |
| (E1-scale) discrete dilations L^Z | PROVED GIVEN [E1, continuity in X, convergence of X_j(K)] | Prop 7.3 |
| (E1-scale) continuous: one centred factor-q step (q odd, log q/log L irrational), B_4-covariant, no extra row; density of L^Z q^Z; X(lambda) = X + 8 b_0 ln lambda + ... | PROVED GIVEN [E1's inputs for the dilation pair + the single factor-q step] | Prop 7.4 |
| RPM1 (Alpöge–Sussman): the deduction (i)+(ii)+(iii) => O(d) off coincidences | CHECKED step by step, CORRECT as written | §8.2 |
| RPM1's integer lemma: closes iff the per-point exponent c < 4; c = 4 admits M_n = 4n | PROVED (sharp) | §8.2 |
| Falsifier "growth bound at coincident points" | MET, at exactly one structural site: §5.2 slab source (E e^{2F(h_r)}); everything else replaceable by OS on disjoint supports | §8.3 |
| Theorem A': (i) replaced by the planar insertion bound (P_k), k + w < 4; for the 0++ field k = 3 (scaling), inside the margin | PROVED (as a deduction) | Thm 8.1 |
| TWO-POINT THEOREM: RP across coordinate+diagonal planes + translations + (SD_2) with 2 Delta - (d-2) < 8 => O(d)-invariant two-point function; no operator bound, no IR input | PROVED | Thm 8.2 |
| The 0++ two-point function of every subsequential continuum limit is O(4)-invariant | PROVED GIVEN [(SD_2) with Delta < 5; diagonal RP on tori (second invariant set); subsequential limits with (E0)] | Cor 8.3 |
| Threshold of Thm 8.2 sharp: phi = (sum d_mu^4) psi is RP, B_d-scalar, anisotropic, with 2 Delta - (d-2) = 8 | PROVED | §8.6 |

## 10. THE PRECISE NEXT OBJECTS

FIRST (the RP route to full (E2), no infrared input): (P_k) with k < 4 for the renormalized action density at every order —
the cutoff-uniform operator bound ||e^{-q_0 H} O(0; f) e^{-q_0 H}|| <= K (1 + q_0^{-k}) on the OS Hilbert space (O at a point of
the (t,x)-plane, smeared over the two transverse directions). On the lattice: ||T^{q_0/a} O_a(0; f) T^{q_0/a}|| <= K(1 + q_0^{-3})
uniformly in a, T Lüscher's transfer matrix. The two-point case is Theorem 8.2 (needs only (SD_2)); the operator form is what
N >= 3 needs. FALSIFIER: a state on which the smeared action density between Euclidean evolutions grows faster than q_0^{-4}.
SECOND (the two inputs Corollary 8.3 still names): (SD_2) — |S_2(x)| <= C |x|^{-8} for the continuum 0++ two-point function at
|x| <= 1, a short-distance statement for Balaban's construction at the scale of the separation (the source theory of M3b (S_1)
read at each scale); and Theorem 9.1 of ME2 on the tori of the construction (the second invariant set x_1 - x_2 = N/2).
THIRD (Route C, if pursued): (T_loc) at kernel level for the rotated pair — the single input under Theorem 5.1(c), Lemma
Sigma_chi's sources and Theorem 7.1; it is M3f's §12 object with the skew first step.

## 11. CROSS-FIELD UNIFICATIONS FOUND

(U1) THE SKEW STEP'S ANISOTROPY IS AN INTEGRATION-SPLITTING ARTEFACT, AND ITS CANCELLATION IS THE SAME TELESCOPING AS THE
Lambda-PARAMETER'S. The one-loop coupling of a block scheme is (bare finite part) - (tree action's finite part); two schemes
that differ only in their first step share the perfect action, hence the coupling AND the anisotropy cancel in the limit.
This is renormalization-scheme conversion (Hasenfratz–Hasenfratz; M3f (U4)) applied to a SKEW scheme: the conversion constant
between "skew first step" and "standard first step" is ZERO, because the tree-level RG forgets the first step at rate L^{-2k}.
Classically perfect actions (Hasenfratz–Niedermayer) are the reason rotation is restored at one loop.
(U2) THE SME RUNNING IS THE RG'S SECOND-ORDER CORRECTION, NOT ITS FIRST. Colladay–McDonald's k_F ~ (g^2)^{-7/11} — re-derived
exactly here (metric 1, Weyl 18/11 against the coupling's 11/3) — governs a BARE anisotropy; in a commensurable-rotation
comparison it acts only on the two-loop residue O(eps_1 g_0^3 + g_0^4). Lorentz invariance as an infrared phenomenon
(Nielsen–Ninomiya, Chadha–Nielsen) appears twice over: the anisotropy created is a transient, and what survives decays.
(U3) THE RP TRICK IS STREATER'S METHOD, AND ITS ARITHMETIC IS A DIMENSION COUNT. The integer lemma closes iff (insertion power)
+ (tensor weight) < 4; for a scalar the insertion power is Delta - (d-2)/2. So "Euclidean invariance from reflection positivity"
holds for fields of dimension below (d-2)/2 + 4 and fails at it, the failure realized by the hypercubic invariant sum d_mu^4 —
the Coxeter degree-4 invariant of B_d, the lattice's first rotation-breaking structure. The 45-degree comparison is a parity
(Z/2 = 8Z/4Z) argument on frequencies — the same mod-8 arithmetic that Theorem 3.3 of ME2 meets as the index 2 of W(F_4) in
Aut(F_4) and the binary octahedral group's order 48.
(U4) THE GAP-CARRYING CHANNEL NEEDS NO INFRARED INPUT FOR ITS SYMMETRY. Theorem 8.2 decouples Euclidean invariance of the 0++
two-point function from the crossover entirely: positivity (lattice RP, including ME2's diagonal RP for gauge fields) plus the
short-distance law of asymptotic freedom (Delta = 4 < 5) suffices. The mass gap and the symmetry of the channel that carries it
are independent problems; the symmetry is the cheaper one, and it is closed modulo (SD_2).

## 12. DATED PRECISIONS (2026-11-02, after §§0–11, from a review pass; nothing above edited)

12.1 TO LEMMA Sigma_chi (i) ("NO MIXING — PROVED"): OVERCLAIMED AS WRITTEN; CORRECTED. The Schur argument of §6.3 (i) is
valid for the linear response taken at a B_4-SYMMETRIC base point. The response d -> (step output) is taken at the ACTUAL
input, whose tree background S^R_k and E-history are only G'-symmetric; the stabilizer of that base point is G', so the
response is G'-equivariant, and on the 3-dimensional space (Sym^2 Lambda^2)^{G'} a G'-equivariant linear map can be any
3 x 3 matrix. CORRECT STATEMENT (PROVED GIVEN the inputs of §6.3 (ii)): expand the response around the B_4-symmetric input
(S_k, isotropic history), where Schur applies (§6.3 (i), verbatim); the deviation is Lipschitz in the input's anisotropy (Lemma
RL), so the metric <-> Weyl entries and the anisotropic -> isotropic entries of the per-step linear map are bounded by
   C g_k^2 [ d(S^R_k, S_k) + E_0 L^{-k} ] <= C g_k^2 [ C_T L^{-2k} k^c + E_0 L^{-k} ]
(O(g_k^2) at k = 1). (i) therefore reads: THE PER-STEP MAP IS DIAGONAL UP TO ENTRIES OF SIZE C g_k^2 (L^{-2k} k^c + E_0 L^{-k}).
These entries are of the order of the telescoping finite parts phi_k - phi_{k+1}, summable over k: the mixing transfers Weyl
<-> metric at rate g_k^2 L^{-k}, which cannot accumulate a logarithm; the products in (iv) stay 1 + O(gamma^2) (metric) and
(x_K/x_k)^{7/11}(1 + O(gamma^2)) (Weyl: a 2 x 2 product of matrices diag(1, 1 - c_W g_j^2) + O(g_j^2 L^{-j}) differs from the
diagonal product by a relative O(gamma^2 sum_j L^{-j}) <= O(gamma^2)), so §6.2 (iv) is UNCHANGED. The anisotropic -> isotropic
entries feed the coupling by O(g_k^2 L^{-k} |d_k|) per step, summable to O(g_0^2 sup|d|): negligible in Theorem 7.1.

12.2 TO THEOREM 7.1 (the line "The anisotropic row feeds the isotropic coupling only at second order in d (Schur ...)"): by
12.1 the feed is FIRST order in d times the background anisotropy, O(g_k^2 (L^{-2k} k^c + E_0 L^{-k}) |d_k|) per step, plus
O(g_k^4 |d_k|^2); summed, O(g_0^2 sup_k |d_k|) = O(g_0^4) relative. The bound of Theorem 7.1 is unchanged.

12.3 TO THEOREM 8.2 (which law each step needs). The 45-degree-rotated two-point function (step 5) is used ONLY on narrow
pairs in the (t,x)-plane, and needs only the four planar mirrors {t = 0}, {x = 0}, {t +- x = 0}, which the rotation Q by
45 degrees in that plane permutes. The transverse reduction (Lemma 2.3 across a y-hyperplane, step 5's last sentence) is applied
to the ORIGINAL two-point function only (both terms of D_2[T* chi](theta) are values of the original S_2 at translated
configurations), and needs RP across {y = 0}, {y +- t = 0}, {y +- x = 0}, all in N. No reflection positivity across a plane
outside N (such as {y +- (t + x)/sqrt 2 = 0}) is ever used.
