# -*- coding: utf-8 -*-
"""M2RR: apply the second reader's repairs to a copy of rev33_test/content4.js, each old string required to occur
exactly once (refused otherwise), so the replacement texts in REVIEW.md are exact and buildable.
Usage: python apply_repairs.py <in content4.js> <out content4.js> required|all"""
import sys

REQUIRED = [
    # R1, line 116: the complex variance
    ("and for bounded *F* it is at most δ_{y}(*F*)/2, with δ_{y}(*F*) the oscillation of *F* under changes of *v*_{y} alone, a variance being at most a quarter of the squared oscillation.",
     "and for bounded *F* it is at most δ_{y}(*F*)/2 when *F* is real and at most δ_{y}(*F*)/√2 in general, with δ_{y}(*F*) the oscillation of *F* under changes of *v*_{y} alone, a real variance being at most a quarter of the squared oscillation and the variance of a complex function the sum of the variances of its real and imaginary parts, each of oscillation at most δ_{y}(*F*)."),
    # R1b, line 130
    ("and ℓ_{y}(*F*) ≤ δ_{y}(*F*)/2. Hypothesis I implies",
     "and ℓ_{y}(*F*) ≤ δ_{y}(*F*)/√2 ≤ δ_{y}(*F*). Hypothesis I implies"),
    # R2, lines 117-118: |Cov| and the degenerate convention
    ("mr('(y, y′) = sup { '), sub('Cov', sub('π', 'ξ'))",
     "mr('(y, y′) = sup { |'), sub('Cov', sub('π', 'ξ'))"),
    ("sub('v', 'y′'), mr(')) : '), sub('Var', sub('π', 'ξ'))",
     "sub('v', 'y′'), mr('))| : '), sub('Var', sub('π', 'ξ'))"),
    ("for its maximal correlation, the supremum over real or over complex functions being the same;",
     "for its maximal correlation, zero when *v*_{y} or *v*_{y′} is almost surely constant under π_{ξ}, the supremum over real or over complex functions being the same;"),
    # R3, lines 148-164: the generator L -> ℒ (the integer L of the construction keeps its letter)
    ("`Let L = Σ_{y∈Y} (K_{y} − I)", "`Let ℒ = Σ_{y∈Y} (K_{y} − I)"),
    ("and P_{t} = e^{tL} the semigroup", "and P_{t} = e^{tℒ} the semigroup"),
    ("*I* + *hL* = (1 − |*Y*|*h*)*I*", "*I* + *h*ℒ = (1 − |*Y*|*h*)*I*"),
    ("mr('((I + hL)G) ≤ (1 − |Y|h)')", "mr('((I + hℒ)G) ≤ (1 − |Y|h)')"),
    ("ℓ((*I* + *tL*/*n*)^{n}*F*)", "ℓ((*I* + *t*ℒ/*n*)^{n}*F*)"),
    ("(*I* + *tL*/*n*)^{n} → *e*^{tL} in operator norm, *L* being bounded",
     "(*I* + *t*ℒ/*n*)^{n} → *e*^{tℒ} in operator norm, ℒ being bounded"),
    ("⟨*F*, −*LG*⟩", "⟨*F*, −ℒ*G*⟩"),
    ("The kernel of *L* is", "The kernel of ℒ is"),
    ("since *LF* = 0 gives", "since ℒ*F* = 0 gives"),
    ("⟨*F*, −*LF*⟩ = 0", "⟨*F*, −ℒ*F*⟩ = 0"),
    ("self-adjoint operator *L* ≤ 0", "self-adjoint operator ℒ ≤ 0"),
    # R4, line 177: translation covariance through covariant versions
    ("For a translation-covariant block map the blocked measure is invariant under the translations of *Y*, so *C*^{λ}_{j}(*y*, *y*′) depends on *y*′ − *y* alone and the weighted column sums of *C*^{λ}_{j} equal its weighted row sums; then",
     "For a translation-covariant block map the blocked measure is invariant under the translations of *Y*, so the translates of the given versions at one coarse point *y*₀ are versions at every coarse point; read with them, *C*^{λ}_{j}(*y*, *y*′) is the given matrix's entry at (*y*₀, *y*₀ + *y*′ − *y*), its weighted row and column sums all equal the weighted row sum of the given matrix at *y*₀, at most α under Hypothesis I, and (8.8d) holds for these versions as for any, *R*_{j} not depending on them; then"),
    # R5, lines 208 and 211: the corollary's consequence uniformly in the lattice
    ("tend to zero, Hypothesis I′ at the rung j₁ with the constant α₁",
     "tend to zero as j → ∞, uniformly in the lattice, Hypothesis I′ at the rung j₁ with the constant α₁"),
    ("which is below any α ∈ (α₁, 1) once the two tails are small.",
     "which is below any α ∈ (α₁, 1) once the two quantities are small, at a rung that the uniformity makes independent of the lattice."),
    # R6, line 189
    ("uses the reflection invariance of μ_{j} alone.",
     "uses the invariance of μ_{j} under θ and τ_{t} alone, not its positivity."),
]

OPTIONAL = [
    # O1, line 120: Hirschfeld's priority on the maximal correlation
    ("[[fn:The maximal correlation is H. Gebelein's,",
     "[[fn:The maximal correlation is H. O. Hirschfeld's, \"A connection between correlation and contingency\", *Proc. Cambridge Philos. Soc.* 31 (1935), 520–524, H. Gebelein's,"),
    # O2, line 167: the priority sentence of Theorem 8.5D's footnote, with the gradient-currency counterpart named
    ("under the weighted row sums, is this paper's; it does not follow from the quadratic form, which by polarisation loses the decay, and it is the form Theorem 8.5′ uses.]]",
     "under the weighted row sums, is this paper's in the currency of conditional maximal correlations; it does not follow from the quadratic form, which by polarisation loses the decay, and it is the form Theorem 8.5′ uses. Its counterpart in the gradient currency, for measures *e*^{−Φ}*dx*, where the covariance is represented through the inverse of the Witten Laplacian on one-forms and a maximum principle bounds it by the fundamental solution of a comparison operator, is B. Helffer and J. Sjöstrand's, \"On the correlation for Kac-like models in the convex case\", *J. Statist. Phys.* 74 (1994), 349–409, and J. Sjöstrand's, \"Ferromagnetic integrals, correlations and maximum principles\", *Ann. Inst. Fourier* 44 (1994), 601–628.]]"),
    # O3, line 167: integrability in the (S) step
    ("and integrating out the coordinates one at a time with Fubini's theorem on the product measure shows that it is ∏*m*-almost everywhere constant.",
     "and integrating out the coordinates one at a time with Fubini's theorem on the product measure, applied to the arctangents of its real and imaginary parts, which are bounded and have the same property, shows that it is ∏*m*-almost everywhere constant."),
    # O4, line 199: complex F in the second fact
    ("π″((*F* − *c*(*X*))²) ≥ *a* inf_{c} π((*F* − *c*(*X*))²)",
     "π″(|*F* − *c*(*X*)|²) ≥ *a* inf_{c} π(|*F* − *c*(*X*)|²)"),
    ("inf_{c} π″((*F* − *c*)²) ≤ *b* Var_{π}(*F*)",
     "inf_{c} π″(|*F* − *c*|²) ≤ *b* Var_{π}(*F*)"),
]

PLACE_START = "  // ---------------------------------------------------------------- the reduction in L² (revision 33)"
PLACE_AFTER = "the number that a certificate of the second link must deliver at the coarse scale.`, { before: 120 }));"


def main():
    src_path, dst_path, mode = sys.argv[1], sys.argv[2], sys.argv[3]
    raw = open(src_path, "rb").read()
    crlf = b"\r\n" in raw
    s = raw.decode("utf-8").replace("\r\n", "\n")
    todo = REQUIRED + (OPTIONAL if mode == "all" else [])
    for k, (old, new) in enumerate(todo):
        n = s.count(old)
        if n != 1:
            sys.stderr.write("REFUSED: repair %d: old string occurs %d times: %r\n" % (k, n, old[:80]))
            sys.exit(1)
        s = s.replace(old, new)
    if mode == "all":
        # the placement of PAPER_DRAFT.md: the block after the paragraph that reads Hypothesis I on the effective action
        lines = s.split("\n")
        i0 = lines.index(PLACE_START)
        j = next(k for k in range(i0, len(lines)) if lines[k].startswith("  push(P(`Hypothesis I is read on the effective action"))
        assert lines[j].endswith(PLACE_AFTER), "the effective-action paragraph does not end as expected"
        block = lines[i0:j]
        lines = lines[:i0] + [lines[j]] + block + lines[j + 1:]
        s = "\n".join(lines)
    if crlf:
        s = s.replace("\n", "\r\n")
    open(dst_path, "wb").write(s.encode("utf-8"))
    print("applied %d repairs (%s) -> %s" % (len(todo), mode, dst_path))


if __name__ == "__main__":
    main()
