
## 11. DATED CORRECTIONS AND ONE STRUCTURAL READING (2026-11-02, after sections 0-10; nothing above edited)

11.1 THE "CRUDE PROVABLE" CONVEXITY RADIUS 0.063 IS A READING, NOT PROVED. The e(b) values of section 5 are LOWER bounds on the sup
(multi-start hill climbing; the record prints "e(b) >="); inserting a lower bound into 6 e(b) <= gamma0 bounds the crude radius from ABOVE.
What is PROVED: the cubic (second-order BCH) part of one plaquette's action, V3 = -sum over the four link triples of det[phi_a, phi_b, phi_c],
has a Hessian whose 3x3 blocks are sums of two cross-product matrices of norm <= b each, three off-diagonal blocks per block row, so
||Hess V3|| <= 6b on |phi_i| <= b; hence the cubic part alone forces 36 b <= gamma0 (eta = 1), b <= 0.051 at L = 2 (gamma0 = 1.8496 as
read). The quartic and higher remainder is not bounded here. Relabel throughout: "crude provable radius 0.063" -> "crude radius about
0.05-0.063 (cubic part PROVED at 6b; the rest READING)"; the floor "372 at the provable radius" -> "about 372-570 at the crude radius
(READING)". Sections 6.2, 6.3, 6.4, 9.3 (N1) and the ledger carry this label.
11.2 "EQUIVALENT" -> "SUFFICIENT, GIVEN THE CHAIN". Section 6.4 and the ledger say the beta = 50 cone property is EQUIVALENT to
K3 <= 417 / 792 together with b_cvx >= 0.3. The chain (H1)-(H6) is a reduction stated and proved in the direction (H1)-(H6) => cone
property; it is not shown necessary, and another cone could close otherwise. What holds: the cone property holds at beta IF (6.1) and (H6)
hold (with (H2), (H4), (H5) at their stated constants).
11.3 THE LINK-DOMAIN SHEARER RADIUS IS A NAMED ASSUMPTION. Gaussian correlations of the fluctuation field are not finite-range, so the use of
z_c(18) in section 5.0 and the floors 1.4771/b^2, 1.2346/b^2 is M6-style: ASSUMPTION (named): the large-field link events are treated as a
hard-core gas on the link graph of dependency degree 18 (links sharing a plaquette), with activities at least the Gaussian probability.
11.4 "THE GAUSSIAN PART OF THE STEP IS IN HAND" -> "READ". Of the Gaussian constants only K_var's bounds [(1/2)(1 - L^-4), 1/2] are PROVED;
gamma0, K_link, l1(C) and rho_tree are READINGS whose certification is item 7.2(a). The verdict sentence of 6.4 reads accordingly.
11.5 THE LABEL OF c1. The numbers c1(L) = 8 b0 ln L are COMPUTED (interval arithmetic) from the universal one-loop coefficient
b0 = 11 C_A/(48 pi^2), which is READ (universality of the first two beta-function coefficients on the renormalised trajectory). The block
map's own one-loop shift — including its first-step transient from Wilson's action — was NOT computed here.
11.6 TWO HEDGES. (i) "The crude expansion does not even converge at beta = 50" (6.4) is a consequence of the ESTIMATED tree-graph count
390/sqrt(beta): read "on this counting". (ii) The preference for L = 3 (tolerance 1.73 times L = 2's) is not settled: K3 grows with L (more
fine plaquettes per coarse cell, more scales per step), and the ratio of K3(3) to K3(2) is not known.
11.7 MONOTONICITY (7.1) IS CONDITIONAL. "(6.1) at beta* certifies every step down to beta*" holds provided the remainder lemma delivers a
beta-UNIFORM constant K3 (and A1) — which is how (N2) must be stated.
11.8 THE GAP MINIMISER, READ (record `rec/gamma0_mode.2026-11-02a.txt`, rc = 0): at the zone-face centre k = (pi/L, 0, 0, 0) of the CENTRED
L = 3 block the softest constrained mode has eigenvalue 1.0000000000 = 4 sin^2(pi/6) (triply degenerate), weight exactly 1/2 on the m = 0
alias and 1/2 on its mirror alias p = -pi/L (the two face-degenerate aliases), |Qv| = 4e-18, while the pure m = 0 transverse vector is NOT in
ker Q (|Qe| = 0.0247): the softest fluctuation is the standing wave of the two face aliases whose centred block averages cancel. With
gamma0(k -> 0) -> 3.0000 = 4 sin^2(pi/3) (the first nonzero alias 2 pi/L, read in section 5) this gives the structural reading
gamma0(centred L) = 4 sin^2(pi/(2L)) — the free Wilson eigenvalue at the coarse zone face, attained because the centred average is
reflection symmetric — READ at L = 3, a conjecture for odd L >= 5 (L = 5: 0.3820; L -> infinity: (pi/L)^2). For the half-open L = 2 block the
gap 1.8496 lies BELOW the face value 4 sin^2(pi/4) = 2: its minimiser has weight 0.469 on m = 0 and a longitudinal component — the
half-open average lacks the reflection that makes the standing wave exact. A second structural reason to prefer centred blocks.
11.9 PROCESS NOTE. One `python - <<` heredoc was run (the patch of bin/m8_c3_table.py). It did not hang, but the assignment forbade it; every
later script was written to a file.
