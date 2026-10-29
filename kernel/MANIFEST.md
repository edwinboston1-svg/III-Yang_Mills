# The kernel record

The directory `aperanton/` is the content of `LEAN/aperanton/` at commit 7dd4c66b20bef5a8ce9c51188077b38f15e69fa9 of the III tree (2026-10-27 21:17:56 -0400), extracted with `git archive` and reproduced byte for byte; the toolchain is `leanprover/lean4:v4.35.0` with Mathlib pinned in `lake-manifest.json`. Its run of record is `runs/aperanton_gate.2026-10-27u.run` (its start line in `runs/aperanton_gate.2026-10-27u.start`), the gate `STDLIB/scripts/aperanton_gate.sh` of that tree, whose verdict line is reproduced here verbatim:

```
[aperanton] GATE_RC=0  ΑΠΕΡΑΝΤΟΝ THE BOUNDLESS Α0+Α1+Α2+Α3+Α4+Α5+Α6+Α8+Β1+Β2+Β3+Β4+W4+W7 CUSTODY GREEN: 48 arms, 29/29 teeth -- THE SELF-DUALITY OF THE FOUR-TORUS DECIDED, THE VACUUM SECTOR AS A DUAL-SECTOR MIXTURE WITH ITS COVARIANCE SPLIT (vacuum_cov_le), AND THE FIBRE COUNT (sum_comp_linear); THE MASS GAP OF THE Z2 WILSON SLAB AT STRONG COUPLING WITH THE PER-SITE COEFFICIENT (3m + 2)(1 - y)/(1 + y) (transfer_gap_sharp: beta < 0.1257 at d = 3, 0.0716 at d = 4, 8.0x and 6.9x the LGT kernel's thresholds), the uniform gap of the X-transfer slab under any interdependence matrix with Dobrushin's comparison theorem by levels and the gap read off the decay, the realification of unitary representations, the scaling target as a def, the duality on codes with Wegner's dual variable and the mixture lemma's epsilon-form, two-dimensional Yang-Mills on any coefficient ring decided on Q8, the four-torus's ranks 45 / 45 / 51 with its echelon certificates re-emitted byte for byte and decided, and THE SECTOR SPLIT OF THE FOUR-TORUS AS A THEOREM (torus4Split); the Wilson kernel of a faithful representation positive definite by separation, W(1) > 0 discharged for faithful actions; the Wilson action's kernel positive semidefinite by the closed cone; the polynomial actions' kernels positive semidefinite by the Schur product; the nonabelian Wilson loop's static potential at least the gap on any lattice cross-section for any finite group, the linear action's hypotheses discharged from a real orthogonal representation; the static potential a gap (strictly positive, at least the finite-volume mass gap of its sector; the Z2 instance hypothesis-free) and the spectral law decided by the kernel on ΣΤΡΟΦΙΓΞ's integers; the spectral law of the Wilson loop and the x-transfer model's infinite slab, the string tension of every finite group on every finite cross-section; the Z2 kernel instance of the centre's inversion theorem re-emitted from ΣΤΡΟΦΙΓΞ's committed dump and reduced by the bare kernel at both couplings; the finite core of the flux-sector results re-emits byte for byte from the record with decide as its only proof term, its literals the record's; the kernel on this desktop reduced all 15 theorems (OD:2) and refused every bent emission; Theorem T and MacWilliams in general form, even-time reflection positivity, the transfer theorem whole (the spectral sum, Perron's simple dominant root with its residual law, the string energy as the exact limit of two Perron roots, the mass gap on every finite cross-section), Griffiths' inequalities with the coupling monotonicity, the infinite-volume Wilson expectation, THE STRING TENSION'S EXISTENCE with its strong-coupling bound, and the inversion theorem of the centre elaborated above Mathlib with no sorry; the row's verdict stays a foreign hand's (OD:1)
```

The run elaborated every file below with the Lean kernel, with no `sorry`, no added axiom and no `native_decide` (the gate strips comments before it checks), re-derived the certificates from their committed records, and bled all 29 mutant tests, each in its named arm. The arms that name a file:

```
arm 1 (CUSTODY): FluxCore.lean
arm 6 (STAGE Α1, ABOVE MATHLIB): TheoremT.lean
arm 7 (STAGE Α4, THE SPECTRAL HALF): Transfer.lean
arm 8 (STAGE Α4, THE PERRON HALF): Perron.lean
arm 9 (STAGE Α3, REFLECTION POSITIVITY AT EVEN TIME): EvenTime.lean
arm 10 (STAGE Α4c, THE STRING ENERGY AS AN EXACT LIMIT): StringEnergy.lean
arm 11 (STAGE Α5a, MECHANISM S's INEQUALITIES): Griffiths.lean
arm 12 (STAGE Α5b, THE INFINITE VOLUME): Lattice.lean
arm 13 (STAGE Α5c, THE STRING TENSION): Rectangle.lean
arm 14 (STAGE Α2, THE MEET IN GENERAL FORM): MacWilliams.lean
arm 15 (STAGE Α4d, THE MASS GAP ON EVERY FINITE CROSS-SECTION): MassGap.lean
arm 16 (STAGE Α5d, THE STRONG-COUPLING FLOOR): StrongCoupling.lean
arm 17 (STAGE Α6a, THE INVERSION THEOREM OF THE CENTRE, ABSTRACT): Inversion.lean
arm 19 (STAGE Α8a, THE SPECTRAL LAW OF THE WILSON LOOP): Spectral.lean
arm 20 (STAGE Α8b, THE X-TRANSFER MODEL AND THE INFINITE SLAB): XTransfer.lean
arm 21 (STAGE Α8c, THE STRING TENSION IS A GAP): GapBound.lean
arm 23 (STAGE Α8d, THE NONABELIAN WILSON LOOP'S STATIC POTENTIAL): Nonabelian.lean
arm 24 (STAGE Α8e, THE GAUGE ACTION): GaugeAction.lean
arm 25 (STAGE Α8f, THE LINEAR ACTION): LinearAction.lean
arm 26 (STAGE Α8g, THE SCHUR PRODUCT): Schur.lean
arm 27 (STAGE Α8h, THE WILSON ACTION): Wilson.lean
arm 28 (STAGE Β1, THE SEPARATION THEOREM): Separation.lean
arm 29 (STAGE Β3a, DOBRUSHIN'S COMPARISON THEOREM, FINITE): Dobrushin.lean
arm 30 (STAGE Β3b, THE FACTOR SYSTEM): Factors.lean
arm 31 (STAGE Β3c, THE GAP READ OFF THE DECAY): Decay.lean
arm 32 (STAGE Β3, THE SLAB AS A FACTOR SYSTEM): Slab.lean
arm 33 (STAGE Β3's GENERIC COEFFICIENT, THE ROW-SUM LAW): Rowsum.lean
arm 34 (STAGE Β3's SHARP COEFFICIENT, THE PER-SITE BOUND WIRED): Z2Slab.lean
arm 35 (STAGE Β3b, THE EVEN-SITE STEP LEMMA): Z2Interdep.lean
arm 36 (STAGE Β2, THE COMPLEX LIFT): Unitary.lean
arm 37 (STAGE Β4, THE SCALING TARGET): Scaling.lean
arm 38 (STAGE W4, THE DUALITY ON CODES): Duality.lean
arm 39 (STAGE W7 = Ω2, THE PLANE): YM2.lean
arm 40 (STAGE W7, THE FIRST NONABELIAN INSTANCE): YM2Q8.lean
arm 41 (STAGE W4's INSTANCE, THE FOUR-TORUS OF SIDE TWO): Torus4.lean
arm 42 (STAGE W4's BRIDGE, THE ε-FORM): Bridge.lean
arm 43 (STAGE W4's BRIDGE B3, THE ECHELON CERTIFICATE): Echelon.lean
arm 44 (STAGE W4's BRIDGE B3, THE CERTIFICATES, OD:2 CUSTODY): Torus4Cert.lean
arm 45 (STAGE W4's BRIDGE B4, THE SECTOR SPLIT OF THE FOUR-TORUS): Torus4Bridge.lean
arm 46 (STAGE W4's GEOMETRY, THE SELF-DUALITY OF THE FOUR-TORUS, DECIDED): DualTorus.lean
arm 47 (STAGE W4, THE VACUUM SECTOR AS A DUAL-SECTOR MIXTURE): Weak.lean
arm 48 (STAGE W4's COUNTING LEMMA, THE FIBRES OF A LINEAR MAP OVER F2): Fibre.lean
```

Every tracked file of the directory at that commit, with its git blob identifier:

```
bfb30ec8c762cc74d4ee1593ab48fc091d04ca4c .gitignore
1a1ddc75b362499c7457dbbb2639a9c29c6976a3 Aperanton.lean
4a95ba1ae45d6fb54f6aaa7cfb75099b279dbb91 Aperanton/Bridge.lean
851dc74c746c7a9e4aa4bd2b7408bce038ae5393 Aperanton/Decay.lean
65848e31a566be8a4bfce7401f6932e886a3a1ef Aperanton/Dobrushin.lean
9aa9c6fdfbc8ec3a84901745815f47be252ae6d4 Aperanton/DualTorus.lean
0b307a618126d5ca11e9b8e30eb14674320505f6 Aperanton/Duality.lean
90e422d769a98a989ec4d626952c386457ea599e Aperanton/Echelon.lean
96b76b4828b2c0e74e7fb0d77ad8955dc238ee08 Aperanton/EvenTime.lean
7af92a8ed52b96de3835165b049e37b67cbee2d9 Aperanton/Factors.lean
63e514f4605f248f4d2a274c2ee1ba24b93caae6 Aperanton/Fibre.lean
ec9b8ee509434a736601aeb7e805b693321fb0c7 Aperanton/FluxCore.lean
743a150ca38c90bf24ea5df93264a53bb17f655d Aperanton/GapBound.lean
37ef815e0eb5c4b325eeb4158414bf522584a2de Aperanton/GaugeAction.lean
0f1b3a76eb42f7642f56faed0e808625d9640093 Aperanton/Griffiths.lean
4b57ec3f30eddc2db9b7684274a5a61413b726a0 Aperanton/Inversion.lean
6888259a7fad3495582c89591eb966f93f441fb5 Aperanton/Lattice.lean
2382b2e89f2e14643661a9798b74cb1e04d47c06 Aperanton/LinearAction.lean
4fba57dad4c9dd6efe9ba2f3fa033d204a5f5cce Aperanton/MacWilliams.lean
eaeb06c8130008eeb19a9bd7e413bd617ae071d0 Aperanton/MassGap.lean
f0296a00c4964657ebaa86905f279fb4c2f82dbe Aperanton/Nonabelian.lean
7b2a26715cbbc6b1393e48c6608b2c367a3a7bf5 Aperanton/Perron.lean
411e02341611a3f20526a05a8f5d47e2d995774c Aperanton/Rectangle.lean
8f300f6920669fe627cbb8e52a62f431f5c71586 Aperanton/Rowsum.lean
7a16e76c1e94f25b25734403fc33f7600ff40edd Aperanton/Scaling.lean
e14ce6fb264cd163f0d0f6a376a6bc1d84876556 Aperanton/Schur.lean
fab3dba63186ada65127e7170168f216ef3663ad Aperanton/Separation.lean
25f4d5c1f8da79b46c6ac3eef64b39b334910bf0 Aperanton/Slab.lean
3d484644bf7deccf299c4585c2ef6260fdafc756 Aperanton/Spectral.lean
b760799530f5031a93f7153fd953e5dd53c14768 Aperanton/StringEnergy.lean
9126c9d4efb84d6b503a0f2a762cd2db2f3488a1 Aperanton/StrongCoupling.lean
d543edf3dd2d87c663bab114c702cee7df477cc3 Aperanton/TheoremT.lean
d4770a319490aabd26a8b699dbfd8e5e21000013 Aperanton/Torus4.lean
1927f38508ef01ae5bc2105f9081fb955bc10af9 Aperanton/Torus4Bridge.lean
7aa7fb03bd3fb49ce3c32b61ef098c785d83fcfc Aperanton/Torus4Cert.lean
9ac84df61025c0222e2c7e6c7cbb4d952854f3a1 Aperanton/Transfer.lean
16081bdf5f97ccd682680817974580707b6c550b Aperanton/Unitary.lean
bbe9d7b832c42d7b9832a5fbe1adc825beda8fee Aperanton/Weak.lean
02a04c552fdcd7594b35d75fc633adfd2c24c630 Aperanton/Wilson.lean
bbb8c2a026a5e186fbfee8cecda96850f2d5c42c Aperanton/XTransfer.lean
de24c9a93e778c65f4a0272f569c87533545700b Aperanton/YM2.lean
4b8cedc1f68e2c5861e52f9e2b1714383aeafa27 Aperanton/YM2Q8.lean
8ab0743ba149a5b29f47f28ebed99a7ea0fa7a28 Aperanton/Z2Interdep.lean
a97c3aff5250056c417a6d9bae71b5938b28016b Aperanton/Z2Inversion.lean
a09dfdf5f5ee2d7dac63ba024d9efdebf31f6420 Aperanton/Z2Moment.lean
2629aba4f3a2f93ab76ff96a6f3da8a7346e59b8 Aperanton/Z2Slab.lean
5f2f142d411699a34b82ee09e9ed6865411d8829 lake-manifest.json
437d0d9a3a44bd11ea9c6138e1b0d9fb6d319545 lakefile.toml
a6aff065db2882c535684f8c5bcd4f16e9a23915 lean-toolchain
```

Theorem names cited by *The Ground* (Records R4): `EvenTime`, `Spectral`, `Perron`, `StringEnergy`, `MassGap`, `Nonabelian`, `Separation`, `Griffiths`, `Rectangle`, `StrongCoupling`, `Slab`, `Z2Slab` (`transfer_gap_sharp`), `Scaling` (`twopoint_le_of_gap`, `PhysicalGapAlong`), `Decay` (`gap_of_decay`, `eigenvalue_le_of_decay`), `Dobrushin` (`cov_le`). The scopes are those stated in the paper's Records and in SOURCES.md §9. Files written after this commit (among them CrossoverCriterion, UVInterface, DobrushinMeasure, MassGapChain) enter this directory only from the commit of a later GREEN run of record.
