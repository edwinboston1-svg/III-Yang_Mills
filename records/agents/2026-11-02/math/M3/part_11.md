
## 11. CORRECTIONS, DATED (2026-11-02, after §§1–10 were written; nothing above edited)

### 11.1 The payable (R) of §5.4 DISSOLVES: the β-functions of record are CMP 109's (creative-solve: the constraint that was belief)

The belief: that the β-function of the sequence of record must be controlled inside CMP 119's complete description, with its
g-proportional radii. The record's own reading log says otherwise:
 – CMP 119 p. 253 (1.27): "the first renormalization group equation 1/g₀² = 1/g₁²(x) + β₁(g₀)φ₁(x). The difference in
   comparison with Eq. (I.0.20) is that here we have functions on the lattice T instead of the constants there, but on
   Λ₁^(~−1) we have the same equation, which defines the same coupling constant g₁."
 – CMP 119 p. 259 (2.24): "the coupling constants g_{j−1} are defined as in (I.0.20)".
 – CMP 119 p. 279: the coupling renormalisation subtracts "β_{k+1}(g_k)A(φ_{k+1}, U_{k+1})" — the function of (I.0.20).
So the coupling sequence of record and its β-functions are CMP 109's small-field objects, and Theorem 2 — a statement about that
sequence — lives entirely in CMP 109's small-field model, where the analyticity radii are absolute (p. 263 (1.17)–(1.18)) and
Theorem 3 assumes only the window ("we do not assume any special asymptotic behavior", p. 259). §5.4's proof of Lemma C in CMP
109's model IS Lemma C for the sequence of record. The complete model's departures from the small-field computation are carried
as its own remainders — R^{(j)} with |R^{(j)}(X)| ≤ g_j^{κ₀}e^{−κd_j(X)} (CMP 119 (2.31)), summed over scales by (2.44)–(2.46),
Σ_{j≤n}g_j^{κ₀} < g_n^{κ₀−6} — which is exactly where the complete model needs the PROFILE, and Theorem 2's (5.1) supplies it along
the trajectory.
CONSEQUENCES. (a) Lemma C: PROVED (given BB1–BB5) for the sequence of record; (R) is withdrawn as a payable. (b) Theorem 2's black
box narrows to the SMALL-FIELD papers — CMP 95, 99, 102 (the operators and minimal configurations), 109 (Theorem 3 and its
inductive assumptions), 116 (the cluster expansion); LFR I–II and CMP 119 enter only downstream, in Theorem 1, which consumes the
window and, through (2.46), the profile. (c) The divergence found in §5.4 stands as a statement about CMP 119's radii: the record's
(log g^{−2})^{−2q₁} bound remains withdrawn as a bound on β, and it was never needed.
FALSIFIER (named, so the reading can be checked by the next reader of CMP 119): a line of CMP 119 or LFR I–II that defines the
coupling of step k+1 from the complete model's OWN marginal coefficient (with its own radii) rather than from (I.0.20).

### 11.2 F2 and §5.2 sharpened (what exactly Lemma A′ repairs)

Since the β-functions are CMP 109's, the right quantifier to compare with is CMP 109's Theorem 3 (p. 264): it controls the actions
"defined inductively by the small field renormalization transformations (0.17)–(0.20)" under the window — i.e. ALONG TRAJECTORIES,
with no profile. CouplingTransient.lean's hr asks for the bound at clamped histories that are not trajectories. In CMP 109's model
those values CAN be supplied — run the construction with prescribed couplings, parametrised by (x_k, E_k), since its inductive step
reads only the current coupling and the history's bounds — but Bałaban states nothing off the recursion; and in the complete model
(whose induction uses the master inequalities (2.6)–(2.9), derived along the trajectory) the clamped histories fall outside the
induction (the scale sum (2.46) fails when a clamp is active). Lemma A′ needs b only on true trajectories: its hypothesis is
Theorem 3's own quantifier, and its propagated profile is what the complete model's (2.46) then consumes. The Lean lemma stays
correct and becomes applicable after the (x, E) extension is written; Lemma A′ needs no extension.

### 11.3 The ledger rows superseded by 11.1–11.2

| Item | Status (superseding §8) | Where |
|---|---|---|
| THEOREM 2 (bounded-transient form) | PROVED modulo the SMALL-FIELD black box (CMP 95, 99, 102, 109 Thm 3, 116) | §5, §11.1 |
| Lemma C for the sequence of record | PROVED given BB1–BB5 (ρ ≤ C(ε₁² + g²) + C₁e^{−c₁ε₁²/g²}; sharp form C′g²) | §5.4, §11.1 |
| (R), the complete-model background radius | WITHDRAWN as a payable (not needed: β is CMP 109's) | §11.1 |
| the Lean hypothesis hr | supplied only after an (x, E) extension Bałaban does not state; Lemma A′ needs none | §11.2 |
| LEFT for Theorem 2 | the kernel on Lemma A′ and Lemma B; a second reader on (B1)'s infrared identification; the falsifier of §11.1 checked on CMP 119 | — |

§9's next object is unchanged: (S₁). The "immediate step under it" named there is now the falsifier check of §11.1 (a reading),
no longer a needed estimate.
