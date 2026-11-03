# lie_moments.awk -- ΟΛΟΚΛΗΡΩΣΙΣ Addendum VI (the development's Step 6(a)): THE PER-GROUP INPUTS OF LEMMA NH DERIVED FROM THE ROOT
# SYSTEM ALONE, EXACTLY, sharing no line with MG2's table (general_eval.py's group_table(), typed by hand there from the literature).
# WHAT THE INPUTS ARE (MG2 WORK.md §4.5): for the group's defining representation ρ of dimension d with character χ,
#   n = d² (real or quaternionic type) or 2d² (complex);  t_k = ∫(Re χ)^k / d^k  (k = 3, 4);  o₃ = |∫(Re χ)² χ| / d³;
#   m₄ = the page's bound on E z⁴ (z = tr(e†ρ(U)), ‖e‖ = 1) from the DIMENSIONS of the irreducible components of Sym²ρ and Λ²ρ, linear in
#   t ∈ [1/d, 1] (real, complex) or [1/d, ½] (quaternionic) and so maximised at an endpoint -- EXACT when each block minus its trivial part
#   is irreducible, an upper bound otherwise;  c₃ = 0 when ρ⊗ρ⊗ρ and ρ⊗ρ⊗ρ̄ carry no invariant.
# EVERY ONE OF THEM IS A TENSOR MULTIPLICITY OR A DIMENSION: ∫χ^a χ̄^b (a + b ≤ 4) reduce to the decomposition of ρ⊗ρ --
#   ∫χ³ = m_{θ*}(ρ⊗ρ), ∫χ²χ̄ = m_θ(ρ⊗ρ), ∫χ²χ̄² = Σ m_λ², ∫χ⁴ = Σ m_λ m_{λ*}, ∫χ³χ̄ = Σ_λ m_λ(ρ⊗ρ) m_θ(V_λ⊗ρ) --
# and Weyl's dimension formula gives every d_λ.  No quadrature, no series, no tail: the sum is finite and the arithmetic is gawk -M's exact
# integers (the plan's "certified Weyl quadrature" and "Brauer-Klimyk series with certified tails" are both this one finite computation).
# THE ONE ALGORITHM (Brauer-Klimyk / Racah-Speiser, μ = 0): a W-invariant weight multiset M decomposes as Σ_{m ∈ M} ε(m) χ_{dom(m + ρ) − ρ}:
#   reflect m + ρ into the dominant chamber by simple reflections s_i(v) = v − v_i A[i,·], each flipping the sign; a wall (a zero label)
#   contributes nothing.  With μ = λ it decomposes V_λ ⊗ ρ from ρ's weights.  Weights are Dynkin labels; A[i,j] = ⟨α_i, α_j^∨⟩ (row i = α_i).
# THE WEIGHT MULTISET OF ρ: the W-orbit of the highest weight (breadth-first by simple reflections) plus the zero weight with multiplicity
#   d − |orbit| (none for a minuscule weight; one or more for the quasi-minuscule 7 of G2, 26 of F4, the vector of SO(2n+1), the adjoint 248
#   of E8) -- CHECKED: Brauer-Klimyk on the built multiset must return exactly {θ : 1}, else the group is REFUSED by name.
# SELF-CHECKS that convict a wrong labelling before any anchor is consulted: A[i,j](α_j,α_j) = A[j,i](α_i,α_i); the positive-root count;
#   Weyl's dimension of ρ against the table's d; Σ m_λ d_λ = d², d(d+1)/2, d(d−1)/2 for ρ⊗ρ, Sym², Λ²; no negative multiplicity.
# THE TYPE is the Frobenius-Schur indicator ∫χ(g²) = the trivial coefficient of Brauer-Klimyk on the doubled weights (+1 R, −1 Q, 0 C).
# THE CUBIC INVARIANT'S SYMMETRY: m₀(Λ³ρ) = (∫χ³ − 3 m₀(ψ²χ·χ) + 2 m₀(ψ³χ))/6 and m₀(Sym³ρ) = (∫χ³ + 3 m₀(ψ²χ·χ) + 2 m₀(ψ³χ))/6, the
#   ψ^k characters having the weights k·m -- so general_eval.py's antisym flag (G2, E8) is DERIVED, never read.
# THE ANCHOR (law 3): the python record's "== NAME type= d= n= ... | t3= t4= o3= m4= ... c3exact=" lines are compared field by field,
#   MEET / PART, never copied into a result.  The two typed theorems the page keeps: E z⁴ for SU(4) is det e† with |det e| ≤ 4⁻² (the
#   singular values' AM-GM), and the exact c₃ of SU(3) (1/108) and SO(3) (1/27) from the ε-integral -- printed as THEOREM, not derived here.
# gawk traps honoured: 0 - x never -x; arrays named past the builtins; one BEGIN scope; every number an exact integer or a reduced fraction.
# usage: gawk -M -f lie_moments.awk [-v ANCHOR=<general_eval record>] [-v ONLY=<group name>]
# Page DOCS/III-HOLOKLEROSIS-THE-COMPLETION-PREREGISTRATION.md, Addendum VI.  2026-11-03.

function iabs(x) { return (x < 0) ? 0 - x : x }
function igcd(a, b,   t) { a = iabs(a); b = iabs(b); while (b != 0) { t = a % b; a = b; b = t } return a }
# rationals as "num/den" strings, den > 0, reduced; integers print bare
function rmake(n, d,   g) { if (d < 0) { n = 0 - n; d = 0 - d } if (d == 0) { REFUSALS++; return "NaN" } g = igcd(n, d); if (g == 0) g = 1; n = n / g; d = d / g; return (d == 1) ? ("" n) : (n "/" d) }
function rnum(x,   i) { i = index(x, "/"); return (i == 0) ? (x + 0) : (substr(x, 1, i - 1) + 0) }
function rden(x,   i) { i = index(x, "/"); return (i == 0) ? 1 : (substr(x, i + 1) + 0) }
function radd(x, y) { return rmake(rnum(x) * rden(y) + rnum(y) * rden(x), rden(x) * rden(y)) }
function rsub(x, y) { return rmake(rnum(x) * rden(y) - rnum(y) * rden(x), rden(x) * rden(y)) }
function rmul(x, y) { return rmake(rnum(x) * rnum(y), rden(x) * rden(y)) }
function rdiv(x, y) { return rmake(rnum(x) * rden(y), rden(x) * rnum(y)) }
function rcmp(x, y,   l) { l = rnum(x) * rden(y) - rnum(y) * rden(x); return (l > 0) ? 1 : ((l < 0) ? -1 : 0) }
function rmax(x, y) { return (rcmp(x, y) >= 0) ? x : y }
function rabs(x) { return (rnum(x) < 0) ? rmake(0 - rnum(x), rden(x)) : x }

# ---- the Cartan matrix A[i,j] = <alpha_i, alpha_j^vee> and the squared lengths LEN[j] = (alpha_j, alpha_j) (long 2, short 1; G2 long 6 short 2)
function cartan(T, r,   i, j) {
  for (i = 1; i <= r; i++) { for (j = 1; j <= r; j++) A[i, j] = 0; A[i, i] = 2; LEN[i] = 2 }
  if (T == "A") { for (i = 1; i < r; i++) { A[i, i + 1] = -1; A[i + 1, i] = -1 } }
  else if (T == "B") { for (i = 1; i < r; i++) { A[i, i + 1] = -1; A[i + 1, i] = -1 } A[r - 1, r] = -2; LEN[r] = 1 }
  else if (T == "C") { for (i = 1; i < r; i++) { A[i, i + 1] = -1; A[i + 1, i] = -1 } A[r, r - 1] = -2; for (i = 1; i < r; i++) LEN[i] = 1 }
  else if (T == "D") { for (i = 1; i < r - 1; i++) { A[i, i + 1] = -1; A[i + 1, i] = -1 } A[r - 2, r] = -1; A[r, r - 2] = -1 }
  else if (T == "G") { A[1, 2] = -1; A[2, 1] = -3; LEN[1] = 2; LEN[2] = 6 }
  else if (T == "F") { A[1, 2] = -1; A[2, 1] = -1; A[2, 3] = -2; A[3, 2] = -1; A[3, 4] = -1; A[4, 3] = -1; LEN[3] = 1; LEN[4] = 1 }
  else if (T == "E") { A[1, 3] = -1; A[3, 1] = -1; A[3, 4] = -1; A[4, 3] = -1; A[2, 4] = -1; A[4, 2] = -1; for (i = 4; i < r; i++) { A[i, i + 1] = -1; A[i + 1, i] = -1 } }
  else return 0
  for (i = 1; i <= r; i++) for (j = 1; j <= r; j++) if (A[i, j] * LEN[j] != A[j, i] * LEN[i]) return 0   # the symmetrizer must symmetrize
  return 1
}
# ---- the positive roots in the root basis (the alpha_i-string algorithm): PR[k] = "k1,...,kr", NPR their number
function roots(r,   i, j, h, k, n, parts, b, cb, p, q, s, key, nxt, cnt, HGT, layer, l, lk) {
  NPR = 0; delete PRSET; delete PR
  for (i = 1; i <= r; i++) { s = ""; for (j = 1; j <= r; j++) s = s (j > 1 ? "," : "") (j == i ? 1 : 0); NPR++; PR[NPR] = s; PRSET[s] = 1; HGT[NPR] = 1 }
  k = 0
  while (k < NPR) { k++; split(PR[k], parts, ",")
    for (i = 1; i <= r; i++) {
      cb = 0; for (j = 1; j <= r; j++) cb += parts[j] * A[j, i]             # <beta, alpha_i^vee>
      p = 0; for (l = 1; ; l++) { s = ""; for (j = 1; j <= r; j++) s = s (j > 1 ? "," : "") (parts[j] - (j == i ? l : 0)); if (!(s in PRSET)) break; p = l }
      q = p - cb
      if (q > 0) { s = ""; for (j = 1; j <= r; j++) s = s (j > 1 ? "," : "") (parts[j] + (j == i ? 1 : 0)); if (!(s in PRSET)) { NPR++; PR[NPR] = s; PRSET[s] = 1 } }
    } }
  return NPR
}
# ---- Weyl's dimension formula on Dynkin labels: prod_beta (lambda + rho, beta) / (rho, beta), (lambda, beta) = sum_j k_j lambda_j LEN[j] / 2
function wdim(lam, r,   k, j, parts, lp, num, den, a, b) {
  split(lam, lp, ","); num = 1; den = 1
  for (k = 1; k <= NPR; k++) { split(PR[k], parts, ","); a = 0; b = 0; for (j = 1; j <= r; j++) { a += parts[j] * (lp[j] + 1) * LEN[j]; b += parts[j] * LEN[j] } num *= a; den *= b }
  if (num % den != 0) { REFUSALS++; return -1 }
  return num / den
}
# ---- the dominant representative under W (walls allowed), as a string; and the Brauer-Klimyk reflection (walls refuse: returns "")
function join(v, r,   j, s) { s = ""; for (j = 1; j <= r; j++) s = s (j > 1 ? "," : "") v[j]; return s }
function dominant(lam, r,   v, i, j, c, changed) { split(lam, v, ",")
  do { changed = 0; for (i = 1; i <= r; i++) if (v[i] < 0) { c = v[i]; for (j = 1; j <= r; j++) v[j] -= c * A[i, j]; changed = 1; break } } while (changed)
  return join(v, r) }
function bk_reflect(lam, r,   v, i, j, c, changed) { split(lam, v, ",") ; BKSIGN = 1
  do { changed = 0; for (i = 1; i <= r; i++) if (v[i] < 0) { c = v[i]; for (j = 1; j <= r; j++) v[j] -= c * A[i, j]; BKSIGN = 0 - BKSIGN; changed = 1; break } } while (changed)
  for (i = 1; i <= r; i++) if (v[i] == 0) return ""
  for (i = 1; i <= r; i++) v[i] -= 1
  return join(v, r) }
# Brauer-Klimyk with highest weight MU on the multiset MS (weight -> multiplicity): fills OUT[lambda] += sign * mult
function bk(MU, MS, OUT, r,   w, parts, mp, j, s, lam) { delete OUT; split(MU, mp, ",")
  for (w in MS) { split(w, parts, ","); s = ""; for (j = 1; j <= r; j++) s = s (j > 1 ? "," : "") (parts[j] + mp[j] + 1)
    lam = bk_reflect(s, r); if (lam == "") continue; OUT[lam] += BKSIGN * MS[w] }
  for (lam in OUT) if (OUT[lam] == 0) delete OUT[lam] }
# ---- the W-orbit of a weight, breadth-first: ORB[1..NORB]
function orbit(hw, r,   k, i, j, v, c, s, parts) { NORB = 0; delete ORBSET; delete ORB; NORB = 1; ORB[1] = hw; ORBSET[hw] = 1; k = 0
  while (k < NORB) { k++; split(ORB[k], parts, ",")
    for (i = 1; i <= r; i++) { if (parts[i] == 0) continue; c = parts[i]; s = ""; for (j = 1; j <= r; j++) s = s (j > 1 ? "," : "") (parts[j] - c * A[i, j]); if (!(s in ORBSET)) { NORB++; ORB[NORB] = s; ORBSET[s] = 1 } } }
  return NORB }
function scaled(w, f, r,   parts, j, s) { split(w, parts, ","); s = ""; for (j = 1; j <= r; j++) s = s (j > 1 ? "," : "") (f * parts[j]); return s }
function wsum(a, b, r,   pa, pb, j, s) { split(a, pa, ","); split(b, pb, ","); s = ""; for (j = 1; j <= r; j++) s = s (j > 1 ? "," : "") (pa[j] + pb[j]); return s }
function neg(a, r,   pa, j, s) { split(a, pa, ","); s = ""; for (j = 1; j <= r; j++) s = s (j > 1 ? "," : "") (0 - pa[j]); return s }
function zero(r,   j, s) { s = ""; for (j = 1; j <= r; j++) s = s (j > 1 ? "," : "") 0; return s }
# the decomposition's print form, sorted by dimension: "labels:mult:dim,..." plus the dimension sum (DIMSUM) and the trivial multiplicity (TRIV)
function decomp_str(OUT, r,   lam, n, keys, i, j, t, s, dm) { n = 0; DIMSUM = 0; TRIV = 0; MINNONTRIV = 0; NONTRIV = 0; NEGMULT = 0
  for (lam in OUT) { n++; dm = wdim(lam, r); DIMV[lam] = dm; keys[n] = lam; DIMSUM += OUT[lam] * dm; if (OUT[lam] < 0) NEGMULT++
    if (lam == zero(r)) TRIV = OUT[lam]; else { NONTRIV += OUT[lam]; if (MINNONTRIV == 0 || dm < MINNONTRIV) MINNONTRIV = dm } }
  for (i = 2; i <= n; i++) { t = keys[i]; j = i - 1; while (j >= 1 && (DIMV[keys[j]] > DIMV[t] || (DIMV[keys[j]] == DIMV[t] && keys[j] > t))) { keys[j + 1] = keys[j]; j-- } keys[j + 1] = t }
  s = ""; for (i = 1; i <= n; i++) s = s (i > 1 ? " " : "") "[" keys[i] "]x" OUT[keys[i]] ":" DIMV[keys[i]]
  return (n == 0) ? "none" : s }

function anchor_field(line, k,   i, n, parts, p) { n = split(line, parts, " "); for (i = 1; i <= n; i++) { p = index(parts[i], "="); if (p && substr(parts[i], 1, p - 1) == k) return substr(parts[i], p + 1) } return "" }
function meet(label, ours, theirs) { if (theirs == "") { printf " %s=%s(no-anchor)", label, ours; return } if (ours == theirs) { printf " %s=%s MEET", label, ours; NMEET++ } else { printf " %s=%s vs %s PART", label, ours, theirs; NPART++ } }

function process(name, T, r, hw, dexp,   d, i, j, k, lam, z, nz, s, w, a, b, M1, LIST, nl, P2, SY, LA, C2, CS, CL, CZ, FSM, fsv, typ, chi3, chi2cb, chi2cb2, chi4, chi3cb, OUTL, dual, hwd, sym_str, lam_str, symtriv, lamtriv, symmin, lammin, symn, lamn, exact, n, t3, t4, o3, m4, b1, b2, tlo, thi, WS, WL, inv, ez4abs, c3, PSI2, PSI3, psi2v, psi3v, lam3, sym3, mixed, antisym, aline, c3a, m4a, refused_here, okchar, vxv_str) {
  NGROUPS++; refused_here = 0
  if (!cartan(T, r)) { printf "LM-REFUSED group=%s the Cartan matrix of type %s rank %d does not symmetrize\n", name, T, r; REFUSALS++; return }
  roots(r)
  d = wdim(hw, r)
  if (d != dexp) { printf "LM-REFUSED group=%s type=%s rank=%d hw=%s: Weyl's dimension reads %d, the table's d is %d (the labelling is wrong)\n", name, T, r, hw, d, dexp; REFUSALS++; return }
  orbit(hw, r); z = d - NORB
  if (z < 0) { printf "LM-REFUSED group=%s the orbit of %s has %d weights, more than d = %d\n", name, hw, NORB, d; REFUSALS++; return }
  delete M1; for (k = 1; k <= NORB; k++) M1[ORB[k]] = 1; if (z > 0) M1[zero(r)] += z
  # the character check: the built multiset must be exactly V_hw
  bk(zero(r), M1, CS, r); okchar = 1; for (lam in CS) if (!(lam == hw && CS[lam] == 1)) okchar = 0; if (!(hw in CS)) okchar = 0
  if (!okchar) { printf "LM-REFUSED group=%s the orbit-plus-zero multiset (orbit %d, zero x%d) is not the character of V_%s: %s\n", name, NORB, z, hw, decomp_str(CS, r); REFUSALS++; return }
  # the type by Frobenius-Schur
  delete FSM; for (w in M1) FSM[scaled(w, 2, r)] += M1[w]; bk(zero(r), FSM, CS, r); fsv = (zero(r) in CS) ? CS[zero(r)] : 0
  typ = (fsv == 1) ? "R" : ((fsv == -1) ? "Q" : ((fsv == 0) ? "C" : "?"))
  if (typ == "?") { printf "LM-REFUSED group=%s the Frobenius-Schur indicator reads %d\n", name, fsv; REFUSALS++; return }
  printf "LM-GROUP name=%s type=%s(FSM=%d) cartan=%s%d hw=%s d=%d positive-roots=%d dimG=%d orbit=%d zero-weight-x%d character=MET\n", name, typ, fsv, T, r, hw, d, NPR, 2 * NPR + r, NORB, z
  # the list of d weights (zeros included), the pair multisets
  nl = 0; delete LIST; for (k = 1; k <= NORB; k++) { nl++; LIST[nl] = ORB[k] } for (k = 1; k <= z; k++) { nl++; LIST[nl] = zero(r) }
  delete P2; delete SY; delete LA
  for (i = 1; i <= nl; i++) for (j = 1; j <= nl; j++) { s = wsum(LIST[i], LIST[j], r); P2[s]++; if (i <= j) SY[s]++; if (i < j) LA[s]++ }
  bk(zero(r), P2, C2, r); vxv_str = decomp_str(C2, r)
  if (DIMSUM != d * d || NEGMULT > 0) { printf "LM-REFUSED group=%s rho x rho decomposes to dimension %d (d^2 = %d), negative multiplicities %d\n", name, DIMSUM, d * d, NEGMULT; REFUSALS++; return }
  printf "LM-TENSOR name=%s rho.rho=%s dim-sum=%d\n", name, vxv_str, DIMSUM
  bk(zero(r), SY, CS, r); sym_str = decomp_str(CS, r); symtriv = TRIV; symmin = MINNONTRIV; symn = NONTRIV
  if (DIMSUM != d * (d + 1) / 2 || NEGMULT > 0) { printf "LM-REFUSED group=%s Sym^2 decomposes to dimension %d (d(d+1)/2 = %d)\n", name, DIMSUM, d * (d + 1) / 2; REFUSALS++; return }
  bk(zero(r), LA, CL, r); lam_str = decomp_str(CL, r); lamtriv = TRIV; lammin = MINNONTRIV; lamn = NONTRIV
  if (DIMSUM != d * (d - 1) / 2 || NEGMULT > 0) { printf "LM-REFUSED group=%s Lambda^2 decomposes to dimension %d (d(d-1)/2 = %d)\n", name, DIMSUM, d * (d - 1) / 2; REFUSALS++; return }
  exact = (symn <= 1 && lamn <= 1) ? "EXACT" : "BOUND"
  printf "LM-SPLIT name=%s Sym2=%s trivial-in-Sym2=%d Lam2=%s trivial-in-Lam2=%d min-nontrivial-dims=%d,%d blocks-minus-trivial-irreducible=%s\n", name, sym_str, symtriv, lam_str, lamtriv, symmin, lammin, exact
  # the integrals from rho x rho
  hwd = dominant(neg(hw, r), r)
  chi3 = (hwd in C2) ? C2[hwd] : 0; chi2cb = (hw in C2) ? C2[hw] : 0; chi2cb2 = 0; chi4 = 0; chi3cb = 0
  for (lam in C2) { chi2cb2 += C2[lam] * C2[lam]; dual = dominant(neg(lam, r), r); chi4 += C2[lam] * ((dual in C2) ? C2[dual] : 0)
    bk(lam, M1, OUTL, r); chi3cb += C2[lam] * ((hw in OUTL) ? OUTL[hw] : 0) }
  # the cubic invariant's symmetry: m0(Lambda^3) and m0(Sym^3) through the Adams characters psi^2 chi . chi and psi^3 chi
  delete PSI2; for (i = 1; i <= nl; i++) for (j = 1; j <= nl; j++) PSI2[wsum(scaled(LIST[i], 2, r), LIST[j], r)]++
  bk(zero(r), PSI2, CS, r); psi2v = (zero(r) in CS) ? CS[zero(r)] : 0
  delete PSI3; for (i = 1; i <= nl; i++) PSI3[scaled(LIST[i], 3, r)]++
  bk(zero(r), PSI3, CS, r); psi3v = (zero(r) in CS) ? CS[zero(r)] : 0
  if ((chi3 - 3 * psi2v + 2 * psi3v) % 6 != 0 || (chi3 + 3 * psi2v + 2 * psi3v) % 6 != 0) { printf "LM-REFUSED group=%s the Lambda^3/Sym^3 trivial multiplicities are not integers (chi3=%d psi2=%d psi3=%d)\n", name, chi3, psi2v, psi3v; REFUSALS++; return }
  lam3 = (chi3 - 3 * psi2v + 2 * psi3v) / 6; sym3 = (chi3 + 3 * psi2v + 2 * psi3v) / 6; mixed = chi3 - lam3 - sym3
  if (lam3 < 0 || sym3 < 0 || mixed < 0 || mixed % 2 != 0) { printf "LM-REFUSED group=%s the cubic split reads Lambda^3 %d, Sym^3 %d, mixed %d\n", name, lam3, sym3, mixed; REFUSALS++; return }
  antisym = (lam3 >= 1 && sym3 == 0) ? "yes" : "no"
  printf "LM-INTEGRALS name=%s int-chi3=%d int-chi2chibar=%d int-chi2chibar2=%d int-chi4=%d int-chi3chibar=%d cubic-invariants:Lambda3=%d Sym3=%d mixed=%d antisymmetric-cubic=%s\n", name, chi3, chi2cb, chi2cb2, chi4, chi3cb, lam3, sym3, mixed / 2, antisym
  # the seven numbers
  if (typ == "C") { n = 2 * d * d
    t3 = rmake(chi3 + 3 * chi2cb, 4 * d * d * d); o3 = rabs(t3)
    t4 = rmake(2 * chi4 + 8 * chi3cb + 6 * chi2cb2, 16 * d * d * d * d) }
  else { n = d * d; t3 = rmake(chi3, d * d * d); o3 = t3; t4 = rmake(chi4, d * d * d * d) }
  # m4: the page's bound, linear in t, at both endpoints
  tlo = rmake(1, d); thi = (typ == "Q") ? rmake(1, 2) : "1"
  ez4abs = "0"
  if (typ == "C" && chi4 != 0) { if (d == 4 && chi4 == 1) ez4abs = rmake(1, 16); else { printf "LM-REFUSED group=%s a complex type with int chi^4 = %d at d = %d: E z^4 has no theorem on the page\n", name, chi4, d; REFUSALS++; return } }
  for (k = 1; k <= 2; k++) { s = (k == 1) ? tlo : thi; WS = rdiv(radd("1", s), "2"); WL = rdiv(rsub("1", s), "2")
    if (typ == "R") { b1 = rmake(1, d * d); b1 = radd(b1, rdiv(rsub(WS, rmake(1, d * d)), "" symmin)); if (lamn > 0) b1 = radd(b1, rdiv(WL, "" lammin)) }
    else if (typ == "Q") { b1 = rmake(1, d * d); b1 = radd(b1, rdiv(WS, "" symmin)); if (lamn > 0) b1 = radd(b1, rdiv(rsub(WL, rmake(1, d * d)), "" lammin)) }
    else { b1 = radd(rdiv(WS, "" symmin), rdiv(WL, "" lammin)); b1 = rdiv(radd(rmul("6", b1), rmul("2", ez4abs)), "16") }
    m4 = (k == 1) ? b1 : rmax(m4, b1) }
  m4 = rdiv(m4, "" (d * d))
  if (chi3 == 0 && chi2cb == 0) c3 = "0"
  else if (name == "SU(3)") c3 = "1/108"
  else if (name == "SO(3)") c3 = "1/27"
  else c3 = "None"
  printf "LM-SEVEN name=%s type=%s d=%d n=%d t3=%s t4=%s o3=%s m4=%s(%s) c3exact=%s%s antisym=%s\n", name, typ, d, n, t3, t4, o3, m4, exact, c3, (c3 == "1/108" || c3 == "1/27") ? "(THEOREM: the epsilon-integral)" : "", antisym
  # the anchor
  aline = ANCH[name]
  if (aline == "") { printf "LM-ANCHOR name=%s no line in the anchor record\n", name; NOANCHOR++; return }
  printf "LM-ANCHOR name=%s", name
  meet("type", typ, anchor_field(aline, "type")); meet("d", "" d, anchor_field(aline, "d")); meet("n", "" n, anchor_field(aline, "n"))
  meet("t3", t3, anchor_field(aline, "t3")); meet("t4", t4, anchor_field(aline, "t4")); meet("o3", o3, anchor_field(aline, "o3"))
  meet("m4", m4, anchor_field(aline, "m4")); meet("c3exact", c3, anchor_field(aline, "c3exact"))
  if (anchor_field(aline, "c3exact") == "None") meet("antisym", antisym, (name in PYANTI) ? "yes" : "no"); else printf " antisym=%s(derived; the anchor's flag is unused where c3 is exact)", antisym
  printf "\n"
}

BEGIN {
  if (ANCHOR == "") ANCHOR = "STDLIB/build/aperanton/instruments/2026-11-02/math/MG2/runs/general_eval.2026-11-02a.txt"
  PYANTI["G2"] = 1; PYANTI["E8"] = 1   # general_eval.py's antisym flags, compared against the DERIVED symmetry (never used in a result)
  NANCH = 0; while ((getline aline < ANCHOR) > 0) { sub(/\r$/, "", aline); if (aline ~ /^== /) { split(aline, ap, " "); ANCH[ap[2]] = aline; NANCH++ } }
  if (NANCH == 0) printf "LM-NOTE the anchor record %s has no group lines; every group prints no-anchor\n", ANCHOR
  NGROUPS = 0; REFUSALS = 0; NMEET = 0; NPART = 0; NOANCHOR = 0
  # name, Cartan type, rank, highest weight (Bourbaki labels), the table's d
  GT[1] = "SU(2) A 1 1 2";            GT[2] = "SU(3) A 2 1,0 3";          GT[3] = "SU(4) A 3 1,0,0 4";        GT[4] = "SU(5) A 4 1,0,0,0 5"
  GT[5] = "Sp(2) C 2 1,0 4";          GT[6] = "SO(3) A 1 2 3";            GT[7] = "SO(5) B 2 1,0 5";          GT[8] = "SO(6) A 3 0,1,0 6"
  GT[9] = "SO(7) B 3 1,0,0 7";        GT[10] = "SO(8) D 4 1,0,0,0 8";     GT[11] = "G2 G 2 1,0 7";            GT[12] = "F4 F 4 0,0,0,1 26"
  GT[13] = "E6 E 6 1,0,0,0,0,0 27";   GT[14] = "E7 E 7 0,0,0,0,0,0,1 56"; GT[15] = "E8 E 8 0,0,0,0,0,0,0,1 248"
  for (gi = 1; gi <= 15; gi++) { split(GT[gi], gp, " "); if (ONLY != "" && gp[1] != ONLY) continue; process(gp[1], gp[2], gp[3] + 0, gp[4], gp[5] + 0) }
  printf "LM-END groups=%d refused=%d anchor-fields-meet=%d part=%d no-anchor=%d verdict=%s\n", NGROUPS, REFUSALS, NMEET, NPART, NOANCHOR, (REFUSALS == 0 && NPART == 0 && NGROUPS > 0) ? "MET" : ((NPART > 0) ? "PARTED" : "REFUSED")
  exit (REFUSALS == 0 && NPART == 0) ? 0 : 1
}
