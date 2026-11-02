# Yang Mills gap literature map

*Manual research by the trunk seat (no research subagents, by the operator's order), 2026-11-02 10:47–11:2x EST. Question: what does the published literature offer for the open objects of a proof of the 4D Yang–Mills mass gap for every compact simple G? Each item is marked USE, CREDIT, or BOUNDS (it limits or refutes a route of the program). Sources are listed at the end.*

## 1. The strong-coupling frontier: no published explicit threshold beats the program's numbers

- **Shen–Zhu–Zhu**, *A stochastic analysis approach to lattice Yang–Mills at strong coupling*, CMP 400 (2023), arXiv:2204.12737 [1].
  - **What it proves:** for SU(N) with |β| < 1/(16(d−1)) in 't Hooft scaling (SO(N): (N−2)/(32(d−1)N)), uniqueness of the Langevin dynamics' invariant measure, log-Sobolev and Poincaré inequalities, and a strictly positive mass gap (exponential decay of correlations) in any d > 1.
  - **Read in full by the proof agent MG2:** the method is Bakry–Émery. It extends to every compact G at λ > 32(d−1). It does not prove uniqueness among all DLR Gibbs measures. The transfer-matrix gap follows through reflection positivity (THE GROUND's Theorem 7.1).
  - **Against the program:** for SU(2), d = 4 this is far below the program's certified 0.2452. **CREDIT** as the dynamical strong-coupling gap. MG2 found the program's Theorem 8.7_G wider for 13 of 15 groups, narrower for E₇ and E₈.
- **Cao–Nissim–Sheffield**, *Expanded regimes of area law for lattice Yang–Mills theories*, arXiv:2505.16585 (v3, Sep 2025) [2].
  - **What it proves:** Theorem 1.2, an area law for U(N), every d ≥ 2, for β ≤ β₀(d) with β₀ an unspecified small dimensional constant, uniformly in N, under the action exp(2β Re Tr U_p). It improves Osterwalder–Seiler's β ≲ c(d)/N only for large N (the authors' Remark 1.3(1)). The proof uses the master loop equation with a truncated model for the merger term.
  - **Limits:** no explicit SU(2) number. It concerns the area law, not the gap. A dynamical companion (*Dynamical approach to area law*, same authors, combining Shen–Zhu–Zhu with Durhuus–Fröhlich) is listed on Cao's page [3] with no arXiv number found.
  - **CREDIT**; it does not move SU(2)'s window.
- **Osterwalder–Seiler**, Ann. Phys. 110 (1978) 440 [4]: the classical strong-coupling confinement and gap, with threshold β ≲ c(d)/N (as quoted in [2]). **CREDIT.** Its explicit SU(2) constant is not given in the sources read; Seiler's 1982 book is the place to check.
- **Adhikari–Cao**, *Correlation decay for finite lattice gauge theories at weak coupling*, Ann. Probab. 53 (2025), arXiv:2202.10375 [5]: exponential decay for FINITE non-abelian groups at large β. The gap comes from discreteness, not running.
  - **BOUNDS** any finite-subgroup approximation of SU(2) at weak coupling, because 2T, 2O and 2I are gapped where SU(2) is critical in lattice units, so such an approximation cannot carry SU(2)'s weak-coupling physics.
  - **USE** as the model for a rare-excitation expansion in an ordered sea, the mirror of the IR large-field object the proof agent MIR carries.
- **No accepted proof of the 4D gap** exists as of 2026 [6]. Self-published Zenodo claims (March 2026, for SU(3) and for all compact simple groups) are unrefereed, with no sign of acceptance [6].

## 2. Multiscale functional inequalities: powerful, but not for gauge theories in print

- **Bauerschmidt–Bodineau–Dagallier**, the Polchinski-flow (multiscale Bakry–Émery) criterion: arXiv:2202.02295 (φ⁴₂, φ⁴₃) and arXiv:2307.07619 (near-critical Ising), with the survey *Stochastic dynamics and the Polchinski equation*, Probab. Surveys 21 (2024) [7].
  - **What it does:** it turns a bound on the susceptibility into a log-Sobolev inequality, uniformly up to criticality, through a Gaussian (Hubbard–Stratonovich) decomposition of the interaction.
  - **BOUNDS the hope for the band:** the method converts decay into a functional inequality and does not produce decay. It needs a Gaussian decomposition the Wilson plaquette action does not have. No gauge-theory version was found [7].
  - **USE:** if the band's clustering were proved by other means, this machinery would upgrade it to a log-Sobolev inequality uniform in the volume, which is what the reduction's dynamical forms want.
- **Computer-assisted finite-size criteria** (Dobrushin–Shlosman): computer-assisted proofs exist for discrete spins (Dobrushin–Kolafa–Shlosman 1985, the 2D Ising antiferromagnet; Salas–Sokal for Potts antiferromagnets) [8]. None was found for continuous spins or gauge theories [8]. A certified finite-size criterion for a compact-group gauge theory would be NEW.

## 3. Rare regions and chessboard estimates in gauge theories

- **Borgs–Seiler**, *Lattice Yang–Mills theory at nonzero temperature and the confinement problem*, CMP 91 (1983) 329 [9]: sharp upper bounds on the deconfinement critical coupling, through the finite-temperature ↔ spin-model connection. The search did not confirm chessboard content. **CREDIT** where the program uses finite-temperature comparisons. **READ** before MIR builds chessboard bounds for the blocked measure.
- The rare-region structure the record found after two blocking steps (disordered typical environment, aligned rare environment) has its published mirror in Adhikari–Cao's ordered sea with rare excitations [5]. No published IR large-field expansion for a non-abelian gauge theory at intermediate coupling was found.

## 4. Fixed-point (classically perfect) actions: the convexity wall is Wilson's

- **DeGrand–Hasenfratz–Zhu**, *Scaling and topological charge of a fixed point action for SU(2) gauge theory*, hep-lat/9604018 [10].
  - **The action:** the eight-parameter approximate fixed-point action S(V) = ½ Σ_C Σ_{k=1}^{4} c_k(C)(2 − Tr V_C)^k over the plaquette and the perimeter-six loop. Plaquette coefficients: 0.3333, 0.00402, 0.00674, 0.0152. Six-link: 0.08333, 0.0156, 0.0149, −0.0035.
  - **Desk computation (trunk seat, unverified by a second hand):** the plaquette part's radial second derivative in the angle stays positive to θ_c ≈ 136° (c = cos θ_c ≈ −0.7205), against Wilson's 90°.
  - **What it means:** the 90° convexity wall that sets the tube's large-field floor (M8: β ≥ 16.4 at b = 0.3) belongs to the Wilson cosine, not to the renormalised trajectory. **USE:** handed to the proof agent M8b as a fourth weight for the convexity test. Caveats: the six-link quartic coefficient is negative, and the link-coordinate Hessian's BCH term grows with s′.
- **Related:** fixed-point actions are one-loop perfect, and smooth configurations with nonzero topological charge have action ≥ 8π²/g² [10, 11]. That bears on the tube's large-field regulator: the perfect action carries no "dislocations below the instanton bound" for smooth fields.

## 5. Not found

- No public work by "Alpöge–Sussman" on Bałaban's renormalization group or Yang–Mills; the record's "Alpöge–Sussman corpus" stays unverified.
- Dimock's expositions of Bałaban's method (*The renormalization group according to Balaban*, arXiv:1108.1335, 1304.0705; and the 2022 non-linear sigma model paper) treat model problems, not 4D Yang–Mills [12]. **CREDIT** as expositions.

## 6. What this changes in the program

1. **The program's SU(2) 0.2452 stands as the best explicit unconditional window found.** MG2's Theorem 8.7_G gives explicit unconditional windows for every compact group, which no publication found does.
2. **The band needs new mathematics.** No published method certifies clustering at intermediate coupling for a continuous non-abelian gauge theory. The multiscale log-Sobolev machinery upgrades decay but does not create it. A certified finite-size criterion for a compact-group gauge theory would itself be new.
3. **The tube's convexity wall is movable:** the published fixed-point action is convex to ≈ 136°.
4. **Credit list for revision 34:** Shen–Zhu–Zhu [1], Cao–Nissim–Sheffield [2], Osterwalder–Seiler [4], Adhikari–Cao [5], Bauerschmidt–Bodineau–Dagallier [7], Borgs–Seiler [9], DeGrand–Hasenfratz–Zhu [10].

## Sources

1. Shen, Zhu, Zhu, arXiv:2204.12737 — https://ar5iv.labs.arxiv.org/html/2204.12737 ; https://pure.bit.edu.cn/en/publications/a-stochastic-analysis-approach-to-lattice-yangmills-at-strong-cou
2. Cao, Nissim, Sheffield, arXiv:2505.16585 — https://arxiv.org/abs/2505.16585 (Theorem 1.2 and Remark 1.3 read from the PDF, pp. 1–3)
3. Sky Cao, research page — https://www.mit.edu/~skycao/research.html ; UCSD seminar abstract — https://math.ucsd.edu/seminar/area-law-lattice-yang-mills-strong-coupling
4. Osterwalder–Seiler 1978, as cited in [2]
5. Adhikari, Cao, arXiv:2202.10375 — https://www.arxiv.org/abs/2202.10375 ; https://projecteuclid.org/journals/annals-of-probability/volume-53/issue-1/Correlation-decay-for-finite-lattice-gauge-theories-at-weak-coupling/10.1214/24-AOP1702.short
6. Status search (Clay lecture page; Zenodo claims) — https://www.claymath.org/lectures/yang-mills-and-the-mass-gap/ ; https://zenodo.org/records/19006612 ; https://zenodo.org/records/18836567
7. Bauerschmidt, Dagallier, arXiv:2202.02295 — https://arxiv.org/abs/2202.02295v2 ; arXiv:2307.07619 — https://arxiv.org/abs/2307.07619v1 ; survey — https://projecteuclid.org/journals/probability-surveys/volume-21/issue-none/Stochastic-dynamics-and-the-Polchinski-equation-An-introduction/10.1214/24-PS27.pdf
8. Dobrushin–Shlosman computer-assisted context — https://web.ma.utexas.edu/mp_arc-bin/mpa?yn=96-74 ; https://link.springer.com/article/10.1007/BF01208821
9. Borgs, Seiler, CMP 91 (1983) — https://projecteuclid.org/journals/communications-in-mathematical-physics/volume-91/issue-3/Lattice-Yang-Mills-theory-at-nonzero-temperature-and-the-confinement/cmp/1103940613.full
10. DeGrand, Hasenfratz, Zhu, hep-lat/9604018 — https://ar5iv.labs.arxiv.org/html/hep-lat/9604018 (Eq. 4, Table 1)
11. DeGrand, Hasenfratz, Zhu, hep-lat/9603015 — https://arxiv.org/abs/hep-lat/9603015
12. Dimock — https://ar5iv.labs.arxiv.org/html/1108.1335 ; https://ar5iv.arxiv.org/html/1304.0705 ; https://ar5iv.labs.arxiv.org/html/2204.08252
