
## 6. G₂'S WINDOW — (W-S)_{G₂}, WHERE IT IS THE WHOLE OF HYPOTHESIS I (stake first)

### 6.0 What the SU(2) engine is, and what a G₂ engine needs (READ: w2_strip.c, w2_strip_n.c headers and build(), lines 1–120)

The two-face object: faces A, B = n × n blocks of fine plaquettes sharing a coarse edge (n = 2: one blocking step; n = 4: two); every object
link also lies in staples outside the object whose other links are THE DATUM (ordered = identity, random:SEED = Haar, cancel, free = off);
plaquette weights truncated at spin ≤ WMAX/2; the coarse loops carry representations a, c and the joint law of (A, B) is contracted by a
matrix-free sweep, each link's tensor being an EXACT product quadrature on S³ of Wigner D-matrices against the product of its staples'
weights. Integrity facts carried (MATH_BRIEF): the BENT object double-counts the n + 1 hinge plaquettes (planar objects are clean); the W3
truncation is signed (use positive truncations, check positivity). WHAT G₂ NEEDS FOR n ≥ 2: either (i) representation matrices D^λ of
G₂ for λ in the truncation (1, 7, 14, 27, 64, 77, 77′, …) and an exact quadrature on the 14-dimensional G₂ for their products — no product
rule exists — or (ii) the link integrals done representation-theoretically: ∫ D^{λ₁}⊗…⊗D^{λ_k}(U) w(U)^m dU = Σ_ν φ_ν(mβ)·(the projector onto the
invariants of λ₁⊗…⊗λ_k⊗ν), i.e. G₂'s Clebsch–Gordan intertwiners and their recoupling (6j / F-matrices) for every λ in the truncation.
THIS SESSION READS, EXACTLY: (a) G₂'s crossover from MG's coefficient instrument (two criteria, a literature check labelled); (b) the core
recoupling datum, the F-matrix of 7 ⊗ 7 ⊗ 7 → 7 over the channels {1, 7, 14, 27}, from explicit g₂ ⊂ so(7); (c) the n = 1 PLANAR two-face object
(zero blocking steps; clean) with the ORDERED datum, where every link weight is a class function and the joint law of the two loops on class
functions needs no recoupling data at all — for G₂ beside SU(2), the first exact reading of the trivial-centre core.

### 6.1 STAKES (written before g2_window.py exists)

S-6a (crossover). SU(2)'s a_½ at 2.2–2.3 is about 0.5; G₂'s a₇ reaches it near β ≈ 14 (UNGUESSED to one digit); the 't Hooft matching
λ_c(SU(2)) = 8/2.25 gives β_c(G₂) = 28·2.25/8 = 7.875; the literature's first-order bulk transition of the G₂ Wilson action sits near β ≈ 9.45
(Pepe–Wiese; recollection, LITERATURE, not a proof input). The three disagree; the readings run at all three.
S-6b (F-matrix). 7 ⊗ 7 ⊗ 7 contains 7 with multiplicity four (one per channel 1, 7, 14, 27 of the first pair); the change of bracketing is an
orthogonal 4×4 matrix F whose row/column through the trivial channel is (√1, √7, √14, √27)/7 up to signs (d_j/d_7² summing to 1); the 7-channel
entry F_{77} is UNGUESSED; MG's crossing ratio 0 for G₂ is a statement about the adjoint channel and is predicted to appear as a vanishing
combination of F-entries (UNGUESSED which).
S-6c (n = 1 reading). With the FREE datum the two plaquettes are independent (maximal class correlation 0, a control); with the ORDERED datum
the whole correlation is outside-mediated (the shared link's four outside staples): SU(2) at 2.2 reads a maximal class correlation in
(0.05, 0.5) (UNGUESSED where); G₂ at its 't Hooft-matched coupling reads SMALLER than SU(2) (UNGUESSED by how much); in both the leading
channel is the defining one (SU(2): χ_½, centre-odd — so SU(2)'s SO(3) channel, the centre-even part, reads strictly below the full value);
for G₂ there is no centre, the full value IS (W-S).
