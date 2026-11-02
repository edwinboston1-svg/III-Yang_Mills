
RESULTS OF `bin/m8_h6_adversary.py` (record `rec/h6_adversary.2026-11-02a.txt`, rc = 0; READING; 8 starts x 120 hill-climbing moves per b):
the most negative lambda_min of the Wilson Hessian on the slice at link-angle sup norm b is 1.6259 (b = 0.2), 1.3107 (0.3), 0.9096 (0.4),
0.1986 (0.5), against the free 1.8496. S-H6.4: convex at 0.2 and 0.3 HELD; "non-convex exhibited at 0.5" REFUTED (still convex there, margin
11 % of gamma0, the worst configurations carrying plaquettes at 1.56-1.77 rad). So on this torus b_cvx lies in (0.5, 0.656] by search,
against the crude provable 0.063: the provable bound is a factor 8-10 below the observed radius, a factor 60-100 in the floor 1.4771/b^2.

## 7. COST OF CERTIFYING THE MIDDLE REGION

7.1 THE CERTIFICATE IS ONE INEQUALITY, NOT 24,489-38,814. Every coefficient of (6.1) is beta-independent (the step's Gaussian part scales as
1/beta exactly; the perturbative coefficients are numbers; K3 is a constant by construction), and A1/beta + K3/beta^2 decreases in beta. So
once the constants are certified, (6.1) at beta* certifies EVERY step from any bare coupling down to beta* (PROVED: monotonicity). The
one-loop step counts (10^4 - 5)/c1 = 38,813.754 (L = 2) and 24,488.752 (L = 3) (COMPUTED) count the steps the flow takes, not the
certificates.
7.2 WHAT MUST BE COMPUTED ONCE (machine-time estimates from the speeds measured today: one L = 2 fluctuation problem 4 ms, one L = 3
problem 0.48 s per coarse momentum):
 (a) the Gaussian constants certified (gamma0 lower bound, K_link and l1(C) upper bounds): an interval/Weyl-Lipschitz cover of 1/384 of the
     coarse zone (the hyperoctahedral symmetry of the centred average); L = 3 about 10^4 boxes x 0.5-1 s, 2-3 h; L = 2 minutes.
 (b) the convexity certificate b_cvx >= 0.3 (section 5): a branch-and-bound over plaquette configurations with a mode-resolved global
     assembly; hours.
 (c) the one-loop sensitivities (S' and the one-loop fixed-point correction c*_1): one-loop background-field integrals with the block
     propagator, a 12 L^4-dimensional problem per coarse momentum, certified quadrature (exponential convergence: the integrand is analytic
     in a strip set by gamma0); L = 2 minutes, L = 3 3-30 h.
 (d) K3 by a loop-preserving remainder bound: certified two- and three-loop lattice integrals in the coarse-momentum/alias factorisation;
     the two-loop integral over (k1, k2) with L^4 x L^4 alias pairs is about 10^12 operations at L = 2 (days on this host) and 10^14 at
     L = 3 (weeks on a workstation, hours on a cluster).
7.3 BELOW beta*, THE CONE CERTIFIES NOTHING. If beta* > 5 the interval [5, beta*] needs certified exact engines extended upward; their spin
cap grows like (beta ln(1/tol))^(1/2) (about 42 at beta = 50, 88 at beta = 220, for tol = e^-35).

## 8. EVERY COMPACT SIMPLE G (statement)

 * The rate: for SU(N) with beta = 2N/g^2, c1 = 4N b0 ln L = (11 N^2/(12 pi^2)) ln L (SU(2): 0.3715 ln L; SU(3): 0.8359 ln L, so
   c1(3) = 0.918); in general C_A -> h^vee, the dual Coxeter number, in b0 = 11 h^vee/(48 pi^2) and b1 = (34/3)(h^vee)^2/(16 pi^2)^2, with
   beta's normalisation fixed by the trace in the fundamental.
 * The Gaussian part (C1) is G-independent per colour component (the linearisation is abelian per generator): the equipartition identity
   (1/2)(1 - L^-4), gamma0, K_link and l1(C) hold verbatim for every G; the number of components is dim G.
 * dim G enters the large-field floor through the chi^2_{dim G} quantile (11.47 for dim 3 at z_c(20)/2; about 21-24 for dim 8): the floor
   K q / b^2 roughly doubles from SU(2) to SU(3); and the vertex counts of K3 (the cubic vertex is f^{abc}-weighted; its count grows like
   dim G times h^vee).
 * The heat kernel on G (the plaquette-class choice of section 2.2) is sum_lambda d_lambda exp(-t C2(lambda)) chi_lambda with the Casimir
   spectrum C2(lambda); the Haar density in exponential coordinates, det(sin(ad X/2)/(ad X/2)), is log-concave on the injectivity ball and
   helps convexity for every G; the convexity radius scales with the structure constants and is lost where single plaquettes reach the edge
   of the radial Hessian.
 * For G with complex representations the six-link loop traces are complex: the cone carries Re tr (the action is real); the parameter
   count is unchanged.

## 9. THE TWO EXIT NUMBERS, THE NEXT OBJECT, AND WHAT UNIFIES

9.1 EXIT NUMBER ONE, THE LOWEST beta AT WHICH A CERTIFIED STEP CLOSES: NONE IS CERTIFIED TODAY. Conditional on the named objects,
beta*(K3) from (6.1) with A1 = 2 + K2 (COMPUTED from the table's inputs): K3 = 1 gives 10.3 (L = 2) / 6.2 (L = 3); 10^2: 27.4 / 19.8;
10^4: 224 / 170; 10^6: 2196 / 1675; 10^8: 21,950 / 16,700. With crude (tree-graph) remainder constants, K3 about 10^4-10^9 (ESTIMATED):
beta* about 200 to 7.10^4. M6's literal Balaban chain: 10^982.39. With a loop-preserving remainder (K3 about 10-100): beta* about 7-27.
L = 3 (centred, Balaban's block) is preferred: its tolerance eps = 0.358 is 1.73 times L = 2's.
9.2 EXIT NUMBER TWO, THE MEETING WITH THE EXACT ENGINES: the W2 strip engines give READINGS at beta <= 3-5; a certified Hypothesis I exists
at beta <= 0.4764 (Theorem 8.9, conditional on S12). Even a cone closing at beta* = 7 leaves [0.48, 7] to engines that today only read to
3-5. The two numbers are different objects; the first does not close the chain.
9.3 THE NEXT OBJECT (in order of leverage):
 (N1) THE CONVEXITY CERTIFICATE b_cvx >= 0.3 on the slice of the centred L = 3 block (and L = 2): a mode-resolved bound on the Hessian change
      in place of the Gershgorin 6 e(b) <= gamma0, which loses the factor 8-10. It moves the convex moment class's floor from 311-372 to
      14-16.
 (N2) THE LOOP-PRESERVING REMAINDER LEMMA: K3 <= about 500 at L = 3 from certified two- and three-loop lattice integrals with the block
      propagator (C1's inputs gamma0, K_link, l1(C)) and the tree-graph bound only from four loops on, where the extra 1/beta^2 pays for the
      crude constant. FALSIFIER: a three-loop contribution to the per-step coupling flow whose certified absolute value already exceeds 500.
 (N3) THE ONE-LOOP SENSITIVITIES S' and c*_1 for the centred average: removes the only ESTIMATED entry of the chain (S'K_r about 2).
9.4 WHAT UNIFIES.
 (U1) THE BLOCK-SPIN STEP IS A TWO-GRID METHOD. Balaban's average is the restriction operator; the constrained fluctuation form's gap gamma0
      is the two-level approximation/smoothing constant of multigrid theory (Brandt, Hackbusch) for the lattice Maxwell operator; the
      equipartition identity (1/2)(1 - L^-4) says the coarse correction carries exactly 1/L^4 of the fluctuation variance, the multigrid
      count of what a coarse space can remove. gamma0 = 1.0000 at the face centre for L = 3 is a two-grid constant.
 (U2) THE CONE IS AN EULER STEP WITH A CERTIFIED LOCAL ERROR. One blocking step is one Euler step of d beta/d l = -8 b0 - 32 b1/beta - ...;
      (6.1) is the condition that the step's local truncation error (A1/beta + K3/beta^2) stays below its progress (c1 - delta_min): the
      validated-numerics criterion for integrating an ODE whose vector field is known only within bounds (Lohner; Zgliczynski), with step
      size ln L.
 (U3) THE TUBE IS A STABLE MANIFOLD. The L^-2 contraction of the dimension-six ratios (read exactly in the rectangle direction) and the
      L-independent free fixed point (tau* = (kL)^2/6 on an axis, (kL)^2/8 on the diagonal) are the Hasenfratz-Niedermayer perfect action
      as the hyperbolic fixed point of the tree-level map; the cone is a neighbourhood of its stable manifold (Hirsch-Pugh-Shub).
 (U4) THE CONVEXITY EDGE IS THE PLAQUETTE'S 90 DEGREES. Convexity on the slice is lost where single plaquettes pass pi/2, the radial
      Hessian cos|Theta| changing sign: M6's "convexity edge at 90 degrees" found here as the true edge of the slice.

## 10. LEDGER (this agent's rows)

| Item | Status | Where |
|---|---|---|
| the cone as a tube around the renormalised trajectory; the reduction to (H1)-(H6) and to (6.1) | PROVED (the reduction) | sections 2, 6.1 |
| the tolerance eps = c1 - delta_min in absolute beta units; the per-step scheme deviation S'(1 - rho)|c - c*| | PROVED | section 2.4 |
| Balaban's linearised average is gauge covariant, Q(d lambda) = d'lambda | PROVED (Fourier identity); checked to 4.4e-15 | section 4 |
| K_var in [(1/2)(1 - L^-4), 1/2]; its mean exactly (1/2)(1 - L^-4) (equipartition) | PROVED; READING agrees to 6 digits | section 4.1 |
| gamma0 = 1.8496 (L = 2), 1.0000 (L = 3); K_link 0.1315 / 0.1099; l1(C) <= 2.70 (L = 2) | READING | sections 4-5 |
| tree-level F^2 coefficient preserved; rho_tree = L^-2 in the rectangle direction; free fixed point 1/6, 1/8 per (kL)^2, L-independent | READING (limits exact to 4-5 digits) | sections 4.3, 5 |
| c1, K2, z_c, chi^2 quantiles, floors, budgets, step counts | COMPUTED (mpmath.iv, 40 digits) | rec/c3_table |
| convexity radius: crude provable 0.063; convex under adversarial search to b = 0.5; rays cross at >= 0.656 | READING | section 5 |
| the verdict at beta = 50: NOT CERTIFIED; equivalent to K3 <= 417 / 792 together with b_cvx >= 0.3 | PROVED (the equivalence, given the chain) | section 6.4 |
| crude remainder methods close at beta* about 200-7.10^4 | ESTIMATED (tree-graph counting) | sections 6.4, 9.1 |
| cost: one inequality by monotonicity; the constants once (hours to weeks) | PROVED (monotonicity) / ESTIMATED (times) | section 7 |
