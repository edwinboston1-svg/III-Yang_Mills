# ladder_house.awk -- THE REGISTER'S LADDER, IN THE HOUSE (gawk -M, 256 bits; every bound in a named rounding mode).
#
# The upper edge of THE CROSSING CAMPAIGN (THE GROUND's Theorem 8.5' half: Balaban's induction, CMP 116 in M6's convention
# beta = 1/g^2, beta_B = 1/gamma^2) was priced on a foreign instrument (M6b's thresholds scripts, mpmath).  This instrument
# re-derives every row of record on the house's own arithmetic, with the foreign values as KNOWN ANSWERS, and adds the rows
# the note and the note owed:
#   (i)   the base row of Lemma RD at L = 11 exactly (the only L at which (2.36) is not refuted on the block family);
#   (ii)  the same row with alpha_6 -> alpha_6 / 11^4 (C_3 carries alpha_6^{-1}; the relocalization base has 11^4 cubes):
#         + 2 ln 11^4 = 8 ln 11 in log beta;
#   (iii) the M_w + KP column at L = 11 with the JUNCTION CONSTANT c = L c0 / 2 of the additive form of (2.36),
#         d_{k+1}(Z') <= (2/L) d_k(Z) + c0, entering the activity as e^{(1-6 delta) kappa c}: + 2 (1-6 delta) kappa_KP c in log beta;
#   (iv)  (2.36) as printed (no constant) tested on the BLOCK family (Z = one big cube's L^4 small cubes; Z' = the 3^4 block of
#         big cubes; d_{k+1}(Z') = 15 exactly by the sixteen-corner argument; d_k(Z) = delta_L >= (L^4-16)/16 by Lemma MS, = 15
#         exactly at L = 3) and on the CHAIN family (m cubes in a row: d_k = max(m-2, 0); the enlargement's span m+2 meets j big
#         cubes in a row, j by the closed ("touch") or the positive-measure ("proper") convention; d_{k+1} = j-2), with
#         the delta's of CMP 116 p. 21 (delta = (1-2/L)/10) on both sides: 2 (1-5 delta) d_k >= (1-6 delta) L d_{k+1};
#   (v)   the vacuity theorem for small domains: n cubes span <= n per axis, the enlargement <= n+2, so for n+2 < L (touch) or
#         n+2 <= L (proper) every big cube met shares one corner point and d_{k+1}(Z') = 0: (2.36) holds trivially.
#
# Rounding: a quantity that is a sum and product of positives and logarithms of positives is computed once with ROUNDMODE = "U"
# (an upper bound) and once with "D" (a lower bound); rationals are formed from integers in one division; a root X* of
# f(X) = a ln X + K - X/2 is bracketed by bisection in "N" and then CERTIFIED: f_D(lo) > 0 (every operation rounded down, X/2 exact)
# and f_U(hi) < 0.  log10 beta = X / ln 10 with ln 10 rounded the other way.
#
# usage: gawk -M -f ladder_house.awk          (no input; the record is the output)

function up()   { ROUNDMODE = "U" }
function down() { ROUNDMODE = "D" }
function near() { ROUNDMODE = "N" }

# a row that is monotone increasing in every operation: compute in U and in D, return via globals R_lo, R_hi
function enclose_base(L, kap, extra,    om) {
    # base row of Lemma RD in Balaban's format: 2 (1-2delta) kappa D0 + 10 kappa + ln(80 kappa) [+ extra (nat)]
    # 1 - 2 delta = (4L+2)/(5L) exactly (L finite), 4/5 at L = inf
    up();   om = (L == 0) ? 4/5 : (4*L+2)/(5*L); R_hi = 2*om*kap*D0 + 10*kap + log(80*kap) + extra
    down(); om = (L == 0) ? 4/5 : (4*L+2)/(5*L); R_lo = 2*om*kap*D0 + 10*kap + log(80*kap) + extra
    near()
}
function enclose_kkp(L) {
    up();   R_hi = (L == 0) ? log(91) : log(91)*L/(L-2)
    down(); R_lo = (L == 0) ? log(91) : log(91)*L/(L-2)
    near()
}
function enclose_row5(kap_lo, kap_hi) {
    up();   R_hi = 10*kap_hi + log(80*kap_hi)
    down(); R_lo = 10*kap_lo + log(80*kap_lo)
    near()
}
function l10_hi(x_hi,    r) { down(); r = log(10); up(); r = x_hi / r; near(); return r }
function l10_lo(x_lo,    r) { up();   r = log(10); down(); r = x_lo / r; near(); return r }
function show(name, lo, hi) {
    printf "%s: log beta in [%.15g, %.15g]; log10 beta in [%.12f, %.12f]\n", name, lo, hi, l10_lo(lo), l10_hi(hi)
}
# f(X) = a ln X + K - X/2, with K given as a function of M (two forms); mode-aware evaluation
function f18(X, a, M,    K) { K = log(8) + 6*log(M) + 5*log(100*M); return a*log(X) + K - X/2 }
function f17(X, a, M,    K) { K = log(3/2) + 4*log(100*M) + 6*log(M); return a*log(X) + K - X/2 }
function root_cert(which, a, M, lo, hi,    mid, i, flo, fhi, s) {
    near()
    for (i = 0; i < 400; i++) {
        if (hi - lo < 1e-32) break
        mid = (lo + hi) / 2
        s = (which == 18) ? f18(mid, a, M) : f17(mid, a, M)
        if (s > 0) lo = mid; else hi = mid
    }
    down(); flo = (which == 18) ? f18(lo, a, M) : f17(lo, a, M)
    up();   fhi = (which == 18) ? f18(hi, a, M) : f17(hi, a, M)
    near()
    if (!(flo > 0 && fhi < 0)) { printf "ROOT NOT CERTIFIED (which=%d a=%d M=%d): f_D(lo)=%.3e f_U(hi)=%.3e\n", which, a, M, flo, fhi; CERT_FAIL++ }
    R_lo = lo; R_hi = hi
}
function kat(name, got_lo, got_hi, want, tol,    ok) {
    ok = (got_lo - tol <= want && want <= got_hi + tol)
    printf "  KAT %-44s want %s got [%.12f, %.12f] %s\n", name, want, got_lo, got_hi, ok ? "MET" : "FAILED"
    if (!ok) KAT_FAIL++
}
function jtouch(s, L) { return (s >= L) ? int(s / L) + 2 : 2 }
function jproper(s, L,    q, r) { q = int(s / L); r = s - q*L; return (r >= 2) ? q + 2 : q + 1 }

BEGIN {
    PREC = 256; near()
    D0 = 14625 / 16          # Lemma MS: d_k(box~^5) >= (11^4 - 16)/16
    CERT_FAIL = 0; KAT_FAIL = 0
    print "LADDER-HOUSE: the register's ladder on gawk -M at 256 bits; every row an enclosure in named rounding modes"
    print "---- the known answers (M6b's foreign records, run a and run b), re-derived"
    enclose_kkp(3);  k3lo = R_lo; k3hi = R_hi;  kat("kappa_KP(L=3)  = 3 ln 91", k3lo, k3hi, 13.532578519551, 1e-9)
    enclose_kkp(11); k11lo = R_lo; k11hi = R_hi; kat("kappa_KP(L=11) = 11 ln 91 / 9", k11lo, k11hi, 5.513272730187, 1e-9)
    enclose_kkp(0);  kinflo = R_lo; kinfhi = R_hi; kat("kappa_KP(L=inf) = ln 91", kinflo, kinfhi, 4.510859506517, 1e-9)
    enclose_base(3, 1, 0);  show("B3 Lemma RD base row, L = 3, kappa = 1", R_lo, R_hi); kat("B3 L=3 log10 (M6b run a: 747.26)", l10_lo(R_lo), l10_hi(R_hi), 747.26, 0.01)
    enclose_base(0, 1, 0);  show("B3 Lemma RD base row, L = inf, kappa = 1", R_lo, R_hi); kat("B3 L=inf log10 (M6b run a: 641.40)", l10_lo(R_lo), l10_hi(R_hi), 641.40, 0.01)
    enclose_row5(1, 1);     show("A1 T11' e^(5kappa) row at kappa = 1", R_lo, R_hi); kat("A1 log10 (M6b: 6.246034806024)", l10_lo(R_lo), l10_hi(R_hi), 6.246034806024, 1e-9)
    root_cert(18, 12, 27, 24, 50000);   show("A7 T18 LFR II (1.9), p0 = 10, r = 2, M = 27", R_lo, R_hi); kat("T18 M=27 log10 (M6: 111.09)", l10_lo(R_lo), l10_hi(R_hi), 111.09, 0.01)
    root_cert(17, 12, 27, 30, 50000);   show("A6 T17 LFR II (1.88) x LFR I (1.87), r = 2, M = 27", R_lo, R_hi); kat("T17 M=27 log10 (M6: 101.87)", l10_lo(R_lo), l10_hi(R_hi), 101.87, 0.01)
    root_cert(18, 12, 1331, 24, 50000); t18lo = R_lo; t18hi = R_hi; show("T18 at M = 1331 (L = 11, M = L^3)", R_lo, R_hi); kat("T18 M=1331 log10 (M6b run b: 151.5656957412)", l10_lo(R_lo), l10_hi(R_hi), 151.5656957412, 1e-8)
    root_cert(17, 12, 1331, 30, 50000); show("T17 at M = 1331", R_lo, R_hi); kat("T17 M=1331 log10 (M6b run b: 138.95814)", l10_lo(R_lo), l10_hi(R_hi), 138.95814, 1e-4)
    enclose_row5(k11lo, k11hi); r5lo = R_lo; r5hi = R_hi; show("e^(5kappa) row at kappa_KP(11)", R_lo, R_hi); kat("row5 L=11 log10 (M6b run b: 26.58834)", l10_lo(R_lo), l10_hi(R_hi), 26.58834, 1e-4)
    enclose_row5(k3lo, k3hi);   show("e^(5kappa) row at kappa_KP(3)", R_lo, R_hi); kat("row5 L=3 log10 (M6b run b: 61.80571)", l10_lo(R_lo), l10_hi(R_hi), 61.80571, 1e-4)
    enclose_row5(kinflo, kinfhi); show("e^(5kappa) row at kappa_KP(inf)", R_lo, R_hi); kat("row5 L=inf log10 (M6b run b: 22.14776)", l10_lo(R_lo), l10_hi(R_hi), 22.14776, 1e-4)
    # E2 residual after M_w at L = 3: 2 (1-2delta) kappa 15 + 10 kappa + ln(80 kappa)
    up();   om3 = (4*3+2)/(5*3); e2hi = 2*om3*15 + 10 + log(80);  down(); om3 = (4*3+2)/(5*3); e2lo = 2*om3*15 + 10 + log(80); near()
    show("E2 residual after Lemma M_w, L = 3, kappa = 1", e2lo, e2hi); kat("E2 resid L=3 log10 (M6b run b: 18.40628)", l10_lo(e2lo), l10_hi(e2hi), 18.40628, 1e-4)
    up();   om3 = (4*3+2)/(5*3); e2hi = 2*om3*k3hi*15 + 10*k3hi + log(80*k3hi);  down(); om3 = (4*3+2)/(5*3); e2lo = 2*om3*k3lo*15 + 10*k3lo + log(80*k3lo); near()
    show("E2 residual + e^(5kappa) at L = 3, kappa = kappa_KP", e2lo, e2hi); kat("E2+row5 L=3 log10 (M6b run b: 226.36519)", l10_lo(e2lo), l10_hi(e2hi), 226.36519, 1e-4)
    print "---- the rows owed (the note, the note): L = 11, the only ladder column standing after (2.36)'s refutation at L = 3"
    enclose_base(11, 1, 0);  b11lo = R_lo; b11hi = R_hi; show("B3 Lemma RD base row, L = 11, kappa = 1 (EXACT; the author's interpolation ~670)", R_lo, R_hi)
    up(); a6hi = 8*log(11); down(); a6lo = 8*log(11); near()
    printf "alpha_6 -> alpha_6/11^4: + 8 ln 11 in log beta = [%.12f, %.12f] nat = [%.9f, %.9f] in log10\n", a6lo, a6hi, l10_lo(a6lo), l10_hi(a6hi)
    enclose_base(11, 1, a6lo); lo = R_lo; enclose_base(11, 1, a6hi); show("B3 at L = 11 with alpha_6/11^4", lo, R_hi)
    # the M_w + KP column at L = 11 with the junction constant: row5(kappa_KP) + 2 (1-6delta) kappa_KP (L c0 / 2) + 8 ln 11, against T18(1331)
    print "---- the M_w + KP column at L = 11 against T18(M = 1331), with the junction constant c = L c0/2 and alpha_6/11^4"
    printf "T18(1331) log10 in [%.9f, %.9f]\n", l10_lo(t18lo), l10_hi(t18hi)
    split("0 0.5 1 2 4 8 16", C0S, " ")
    for (i = 1; i <= 7; i++) {
        c0 = C0S[i] + 0
        up();   om6 = (10*11 - 6*(11-2))/(10*11); jhi = 2*om6*k11hi*(11*c0/2); colhi = r5hi + jhi + a6hi
        down(); om6 = (10*11 - 6*(11-2))/(10*11); jlo = 2*om6*k11lo*(11*c0/2); collo = r5lo + jlo + a6lo
        near()
        printf "  c0 = %-4s junction term [%.6f, %.6f] nat; e^(5kappa)+junction+alpha_6 row log10 in [%.6f, %.6f]; column binds at %s\n", C0S[i], jlo, jhi, l10_lo(collo), l10_hi(colhi), (l10_hi(colhi) < l10_lo(t18lo)) ? "T18 = 151.5657 (the large-field row)" : "THE JUNCTION ROW"
    }
    print "---- (2.36) as printed, no constant: 2 (1-5delta) d_k(Z) >= (1-6delta) L d_{k+1}(Z') on two families, delta = (1-2/L)/10"
    print "  BLOCK family: Z = one big cube's L^4 small cubes, Z' = the 3^4 block, d_{k+1}(Z') = 15 (sixteen corner cubes need sixteen"
    print "  tree vertices, two per differing coordinate at distance >= 1: fifteen edges; attained by the central cube's skeleton), d_k(Z) = delta_L"
    split("3 5 7 9 11 13", LS, " ")
    for (i = 1; i <= 6; i++) {
        L = LS[i] + 0
        near(); d5 = (1 - 5*(L-2)/(10*L)); d6 = (1 - 6*(L-2)/(10*L))
        dL = (L == 3) ? 15 : (L^4 - 16)/16      # exact at L = 3; Lemma MS lower bound otherwise (a PASS is then rigorous)
        lhs = 2*d5*dL; rhs = d6*L*15
        printf "  L = %2d: 2(1-5delta) delta_L %s %.4f  vs  (1-6delta) L 15 = %.4f  -> %s%s\n", L, (L == 3) ? "=" : ">=", lhs, rhs, (lhs >= rhs) ? "PASS" : "FAIL", (L == 3) ? " (exact: (2.36) is FALSE at L = 3)" : ""
    }
    print "  CHAIN family: m cubes in a row; d_k = max(m-2,0); the enlargement's span m+2 meets j big cubes; d_{k+1} = j-2; worst m <= 120"
    for (i = 1; i <= 6; i++) {
        L = LS[i] + 0
        near(); d5 = (1 - 5*(L-2)/(10*L)); d6 = (1 - 6*(L-2)/(10*L))
        for (conv = 1; conv <= 2; conv++) {
            worst = -1e9; wm = 0
            for (m = 1; m <= 120; m++) {
                s = m + 2; j = (conv == 1) ? jtouch(s, L) : jproper(s, L); dk = (m > 2) ? m - 2 : 0; dk1 = (j > 2) ? j - 2 : 0
                def = d6*L*dk1 - 2*d5*dk
                if (def > worst) { worst = def; wm = m }
            }
            printf "  L = %2d, %-6s convention: max deficit (1-6delta)L d_{k+1} - 2(1-5delta) d_k = %.4f at m = %d -> %s\n", L, (conv == 1) ? "touch" : "proper", worst, wm, (worst <= 0) ? "PASS" : "FAIL"
        }
    }
    print "  SMALL-DOMAIN VACUITY: a wall-connected domain of n cubes spans <= n per axis; its enlargement <= n+2; if n+2 < L (touch) or"
    print "  n+2 <= L (proper) every big cube met shares one corner, d_{k+1}(Z') = 0 and (2.36) holds trivially:"
    for (i = 1; i <= 6; i++) { L = LS[i] + 0; printf "  L = %2d: vacuous for n <= %d (touch), n <= %d (proper); the named n <= 8 instrument at L = 11 decides nothing\n", L, L-3, L-2 }
    printf "LADDER-HOUSE END: root certificates failed %d, known answers failed %d -> %s\n", CERT_FAIL, KAT_FAIL, (CERT_FAIL == 0 && KAT_FAIL == 0) ? "LADDER-MET" : "LADDER-FAILED"
}
