/* cp_row.c -- THE COARSE-POINT ROW AT FIRST ORDER (THE CROSSING CAMPAIGN §35.2 (c), §35.3): Hypothesis I's row in THE GROUND's
 * SU(2)^4-per-site form, read to first order in the fitted coarse couplings, exactly, with no quadrature and no sampling.
 *
 * THE OBJECT.  A coarse site Y carries the bundle V(Y) = (V_0, V_1, V_2, V_3) in SU(2)^4; the fitted coarse action is
 * S = - sum over loops l of t_{fam(l), j} chi_j(U_l) / d_j (the fit's normalised characters: x, (4x^2-1)/3, 2x^3-x in x = tr U / 2),
 * over four loop families per site (plaquettes 6, rectangles 12, chairs 48, parallelograms 16 -- the census of the fitted action,
 * 120 loop incidences per link).  At first order a loop l through link (0, a) and link (y, b) couples the normalised spin-j
 * matrix-element functions of the two links at strength t_{l,j} / d_j^2, with the pairing fixed by the loop's traversal: with every
 * other link the identity the loop's trace is chi_j(V_a V_b^{s}), s = sigma_a sigma_b the product of the two traversal directions;
 * for spin 1/2 in the real quaternion coordinates (w, x, y, z), chi(V_a V_b) = 2(w_a w_b - x_a x_b - y_a y_b - z_a z_b) and
 * chi(V_a V_b^{-1}) = 2(w_a w_b + x_a x_b + y_a y_b + z_a z_b), so the first-order kernel between the bundles' spin-1/2 coordinate
 * functions is block-diagonal in the coordinate: B^{(w)}_{ab} = sum_l t_l / 4 and B^{(x,y,z)}_{ab} = sum_l (-s_l) t_l / 4.
 *
 * TWO READINGS PER SITE PAIR, both exact arithmetic on the couplings:
 *   ORDERED  rho_1(0, y) = max( ||B^{(w)}||_2, ||B^{(xyz)}||_2 ) at spin 1/2 (exact first order at the ordered environment), and
 *            the spins 1 and 3/2 by the triangle bound ||[sum_l |t_l| / d_j^2]||_2 (their couplings are a hundredth of the plaquette's);
 *   ALIGNED  rho_1(0, y) = max_j ||[sum_l |t_{l,j}| / d_j^2]_{ab}||_2 -- every loop's sign aligned, the environment-supremum reading
 *            at first order (the earlier instrument's Lemma E lifted from a link to a bundle; its single-link form is the earlier instrument's R_first).
 * THE ROW is sum over y != 0 of rho_1(0, y) (kappa = 0), printed with the per-site table by sup-distance; the single-link row of the
 * same code (one link against its 122 neighbour links) is the known answer against the earlier instrument's record.
 *
 * WHAT IT IS NOT: a certificate.  The couplings are a reading (score matching on a Monte Carlo record); the first order discards the
 * couplings' squares; a row below one here proves nothing (the ess sup over environments is not read) and a row at or above one at
 * the ordered environment refutes Hypothesis I on the fitted action at first order only.  The exact row at the ordered environment is
 * the Monte Carlo reading §35.2 (d) names.
 *
 * build: gcc -O2 -o cp_row cp_row.c -lm
 * usage: cp_row t_plaq_1/2 t_plaq_1 t_plaq_3/2 t_rect_1/2 t_rect_1 t_rect_3/2 t_chair_1/2 t_chair_1 t_chair_3/2 t_parag_1/2 t_parag_1 t_parag_3/2
 *        (twelve couplings, family-major, as the fit prints them); no arguments: the dead instrument (every coupling zero) and the census. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

typedef struct { int st[4]; int n; int step[6][2]; int fam; } Loop;
static Loop LOOPS[128]; static int NL = 0;
static const char *FAMN[4] = {"plaquette", "rectangle", "chair", "parallelogram"};
static const int FAM_PER_SITE[4] = {6, 12, 48, 16}, FAM_PER_LINK[4] = {6, 18, 72, 24};

static void addloop(int fam, const int st[4], int n, int steps[][2]) {
    Loop *L = &LOOPS[NL++]; memcpy(L->st, st, sizeof(int) * 4); L->n = n; L->fam = fam;
    for (int i = 0; i < n; i++) { L->step[i][0] = steps[i][0]; L->step[i][1] = steps[i][1]; }
}
static void build_loops(void) {
    int z[4] = {0, 0, 0, 0}, s[6][2];
    for (int mu = 0; mu < 4; mu++) for (int nu = mu + 1; nu < 4; nu++) {               /* plaquettes */
        s[0][0] = mu; s[0][1] = 1; s[1][0] = nu; s[1][1] = 1; s[2][0] = mu; s[2][1] = -1; s[3][0] = nu; s[3][1] = -1; addloop(0, z, 4, s); }
    for (int mu = 0; mu < 4; mu++) for (int nu = 0; nu < 4; nu++) { if (nu == mu) continue;  /* rectangles 2 x 1 */
        s[0][0] = mu; s[0][1] = 1; s[1][0] = mu; s[1][1] = 1; s[2][0] = nu; s[2][1] = 1; s[3][0] = mu; s[3][1] = -1; s[4][0] = mu; s[4][1] = -1; s[5][0] = nu; s[5][1] = -1; addloop(1, z, 6, s); }
    for (int nu = 0; nu < 4; nu++) {                                                   /* chairs */
        int oth[3], k = 0; for (int d = 0; d < 4; d++) if (d != nu) oth[k++] = d;
        for (int i = 0; i < 3; i++) for (int j = i + 1; j < 3; j++) { int mu = oth[i], rho = oth[j];
            for (int s1 = 1; s1 >= -1; s1 -= 2) for (int s2 = 1; s2 >= -1; s2 -= 2) {
                int st[4] = {0, 0, 0, 0}; st[mu] = s1;
                s[0][0] = mu; s[0][1] = -s1; s[1][0] = rho; s[1][1] = s2; s[2][0] = nu; s[2][1] = 1; s[3][0] = rho; s[3][1] = -s2; s[4][0] = mu; s[4][1] = s1; s[5][0] = nu; s[5][1] = -1;
                addloop(2, st, 6, s); } } }
    for (int a0 = 0; a0 < 4; a0++) for (int a1 = a0 + 1; a1 < 4; a1++) for (int a2 = a1 + 1; a2 < 4; a2++) {   /* parallelograms: the Petrie hexagons */
        int ax[3] = {a0, a1, a2};
        for (int v = 0; v < 8; v++) { if (v & 4) continue;                           /* v with its first bit 0; vb = complement */
            int vb = 7 - v, rest[6], r = 0; for (int w = 0; w < 8; w++) if (w != v && w != vb) rest[r++] = w;
            int cyc[6], used[6] = {0, 0, 0, 0, 0, 0}; cyc[0] = rest[0]; used[0] = 1;
            for (int c = 1; c < 6; c++) { int cur = cyc[c - 1], found = -1;
                for (int q = 0; q < 6 && found < 0; q++) { if (used[q]) continue; int dif = cur ^ rest[q]; if (dif && !(dif & (dif - 1))) found = q; }
                if (found < 0) { fprintf(stderr, "petrie cycle broken\n"); exit(2); } cyc[c] = rest[found]; used[found] = 1; }
            { int dif = cyc[5] ^ cyc[0]; if (!(dif && !(dif & (dif - 1)))) { fprintf(stderr, "petrie not closed\n"); exit(2); } }
            int st[4] = {0, 0, 0, 0};
            for (int i = 0; i < 6; i++) { int A = cyc[i], B = cyc[(i + 1) % 6], dif = A ^ B, bit = (dif == 1) ? 0 : (dif == 2) ? 1 : 2;
                s[i][0] = ax[bit]; s[i][1] = ((B >> bit) & 1) - ((A >> bit) & 1); }
            for (int bit = 0; bit < 3; bit++) st[ax[bit]] = (cyc[0] >> bit) & 1;
            addloop(3, st, 6, s); } }
}
/* the links of a loop at base b: (x, d, sigma) */
static int links_of(const Loop *L, const int b[4], int X[6][4], int D[6], int S[6]) {
    int x[4]; for (int i = 0; i < 4; i++) x[i] = b[i] + L->st[i];
    for (int i = 0; i < L->n; i++) { int d = L->step[i][0], sg = L->step[i][1];
        if (sg > 0) { memcpy(X[i], x, sizeof x); D[i] = d; S[i] = 1; x[d] += 1; } else { x[d] -= 1; memcpy(X[i], x, sizeof x); D[i] = d; S[i] = -1; } }
    for (int i = 0; i < 4; i++) if (x[i] != b[i] + L->st[i]) { fprintf(stderr, "loop not closed\n"); exit(2); }
    return L->n;
}
/* 4x4 operator norm: sqrt(lambda_max(B^T B)) by Jacobi on the symmetric 4x4 */
static double opnorm4(double B[4][4]) {
    double A[4][4]; for (int i = 0; i < 4; i++) for (int j = 0; j < 4; j++) { double s = 0; for (int k = 0; k < 4; k++) s += B[k][i] * B[k][j]; A[i][j] = s; }
    for (int sweep = 0; sweep < 60; sweep++) { double off = 0; for (int i = 0; i < 4; i++) for (int j = i + 1; j < 4; j++) off += A[i][j] * A[i][j]; if (off < 1e-40) break;
        for (int p = 0; p < 4; p++) for (int q = p + 1; q < 4; q++) { if (fabs(A[p][q]) < 1e-300) continue;
            double th = (A[q][q] - A[p][p]) / (2 * A[p][q]), t = (th >= 0 ? 1 : -1) / (fabs(th) + sqrt(th * th + 1)), c = 1 / sqrt(t * t + 1), s = t * c;
            for (int k = 0; k < 4; k++) { double akp = A[k][p], akq = A[k][q]; A[k][p] = c * akp - s * akq; A[k][q] = s * akp + c * akq; }
            for (int k = 0; k < 4; k++) { double apk = A[p][k], aqk = A[q][k]; A[p][k] = c * apk - s * aqk; A[q][k] = s * apk + c * aqk; } } }
    double m = 0; for (int i = 0; i < 4; i++) if (A[i][i] > m) m = A[i][i]; return sqrt(m);
}
#define W 4
#define NS ((2*W+1)*(2*W+1)*(2*W+1)*(2*W+1))
static int sidx(const int y[4]) { int k = 0; for (int i = 0; i < 4; i++) { if (y[i] < -W || y[i] > W) return -1; k = k * (2 * W + 1) + (y[i] + W); } return k; }
static double TP[NS][3][4][4], TM[NS][3][4][4], TA[NS][3][4][4];   /* per site: sum t (s=+1), sum t (s=-1), sum |t|, per spin, per (a, b) */
static int NSITE_HIT[NS];
static double LP[3][4][4], LM[3][4][4], LA[3][4][4];               /* single-link accumulators: link (0,0) against (y,b) -> aggregated per neighbour below */
static double SL_abs[NS][4][3], SL_p[NS][4][3], SL_m[NS][4][3];    /* single-link: neighbour (y, b), per spin */

int main(int argc, char **argv) {
    double t[4][3] = {{0}}; int dead = (argc < 13);
    if (!dead) for (int f = 0; f < 4; f++) for (int j = 0; j < 3; j++) t[f][j] = atof(argv[1 + 3 * f + j]);
    build_loops();
    int per_site[4] = {0, 0, 0, 0}; for (int i = 0; i < NL; i++) per_site[LOOPS[i].fam]++;
    printf("CP-CENSUS loops per site: plaquette %d rectangle %d chair %d parallelogram %d (expected 6 12 48 16) total %d\n", per_site[0], per_site[1], per_site[2], per_site[3], NL);
    int ok = 1; for (int f = 0; f < 4; f++) if (per_site[f] != FAM_PER_SITE[f]) ok = 0;
    /* incidence of the links (0, a), and the accumulation over all loops in a window of bases */
    int inc[4][4] = {{0}}; int X[6][4], D[6], S[6]; int b[4];
    for (b[0] = -3; b[0] <= 3; b[0]++) for (b[1] = -3; b[1] <= 3; b[1]++) for (b[2] = -3; b[2] <= 3; b[2]++) for (b[3] = -3; b[3] <= 3; b[3]++)
        for (int li = 0; li < NL; li++) { const Loop *L = &LOOPS[li]; int n = links_of(L, b, X, D, S);
            for (int i = 0; i < n; i++) { if (X[i][0] || X[i][1] || X[i][2] || X[i][3]) continue; int a = D[i], sa = S[i]; inc[a][L->fam]++;
                for (int k = 0; k < n; k++) { if (k == i) continue; int y[4]; memcpy(y, X[k], sizeof y); int bb = D[k], s = sa * S[k];
                    int samesite = (!y[0] && !y[1] && !y[2] && !y[3]);
                    int si = sidx(y); if (si < 0) { fprintf(stderr, "site out of window\n"); exit(3); }
                    /* the single link (0, 0) against every other link, the same site's three links included (the earlier instrument's 122 neighbours) */
                    if (a == 0) for (int j = 0; j < 3; j++) { double tt = t[L->fam][j]; SL_abs[si][bb][j] += fabs(tt); if (s > 0) SL_p[si][bb][j] += tt; else SL_m[si][bb][j] += tt; }
                    if (samesite) continue;                                     /* the bundle's own links: not a row entry */
                    NSITE_HIT[si] = 1;
                    for (int j = 0; j < 3; j++) { double tt = t[L->fam][j]; TA[si][j][a][bb] += fabs(tt); if (s > 0) TP[si][j][a][bb] += tt; else TM[si][j][a][bb] += tt; } } } }
    printf("CP-CENSUS incidences of the link (0, 0): plaquette %d rectangle %d chair %d parallelogram %d (expected 6 18 72 24) total %d\n", inc[0][0], inc[0][1], inc[0][2], inc[0][3], inc[0][0] + inc[0][1] + inc[0][2] + inc[0][3]);
    for (int a = 0; a < 4; a++) for (int f = 0; f < 4; f++) if (inc[a][f] != FAM_PER_LINK[f]) ok = 0;
    printf("CP-CENSUS %s\n", ok ? "MET" : "FAILED");
    /* the bundle row */
    static const double DJ2[3] = {4, 9, 16};
    double row_ord = 0, row_ali = 0; int nsites = 0; double by_dist_ord[8] = {0}, by_dist_ali[8] = {0}; int by_dist_n[8] = {0};
    printf("CP-SITES (per site y != 0: sup-distance, rho_1 ordered, rho_1 aligned), the ten largest:\n");
    double top[10][3]; int ntop = 0;
    for (int si = 0; si < NS; si++) { if (!NSITE_HIT[si]) continue; nsites++;
        int y[4], k = si; for (int i = 3; i >= 0; i--) { y[i] = k % (2 * W + 1) - W; k /= (2 * W + 1); }
        int dist = 0; for (int i = 0; i < 4; i++) if (abs(y[i]) > dist) dist = abs(y[i]);
        double B[4][4], ro = 0, ra = 0;
        /* spin 1/2 ordered: w-block and xyz-block */
        for (int a = 0; a < 4; a++) for (int bb = 0; bb < 4; bb++) B[a][bb] = (TP[si][0][a][bb] + TM[si][0][a][bb]) / 4; double nw = opnorm4(B);
        for (int a = 0; a < 4; a++) for (int bb = 0; bb < 4; bb++) B[a][bb] = (-TP[si][0][a][bb] + TM[si][0][a][bb]) / 4; double nx = opnorm4(B);
        ro = nw > nx ? nw : nx;
        for (int j = 1; j < 3; j++) { for (int a = 0; a < 4; a++) for (int bb = 0; bb < 4; bb++) B[a][bb] = TA[si][j][a][bb] / DJ2[j]; double nj = opnorm4(B); if (nj > ro) ro = nj; }
        for (int j = 0; j < 3; j++) { for (int a = 0; a < 4; a++) for (int bb = 0; bb < 4; bb++) B[a][bb] = TA[si][j][a][bb] / DJ2[j]; double nj = opnorm4(B); if (nj > ra) ra = nj; }
        row_ord += ro; row_ali += ra; if (dist < 8) { by_dist_ord[dist] += ro; by_dist_ali[dist] += ra; by_dist_n[dist]++; }
        /* keep the ten largest aligned entries */
        if (ntop < 10 || ra > top[9][2]) { int p = ntop < 10 ? ntop++ : 9; top[p][0] = (double) si; top[p][1] = ro; top[p][2] = ra;
            for (int q = p; q > 0 && top[q][2] > top[q - 1][2]; q--) { double tmp[3]; memcpy(tmp, top[q], sizeof tmp); memcpy(top[q], top[q - 1], sizeof tmp); memcpy(top[q - 1], tmp, sizeof tmp); } }
    }
    for (int p = 0; p < ntop; p++) { int si = (int) top[p][0], y[4], k = si; for (int i = 3; i >= 0; i--) { y[i] = k % (2 * W + 1) - W; k /= (2 * W + 1); }
        printf("  y = (%2d,%2d,%2d,%2d)  ordered %.6f  aligned %.6f\n", y[0], y[1], y[2], y[3], top[p][1], top[p][2]); }
    printf("CP-BYDIST (sup-distance: sites, ordered sum, aligned sum):");
    for (int d = 1; d < 8; d++) if (by_dist_n[d]) printf("  %d: %d %.6f %.6f", d, by_dist_n[d], by_dist_ord[d], by_dist_ali[d]); printf("\n");
    printf("CP-ROW bundle, first order, kappa = 0: sites %d; ORDERED %.6f; ALIGNED %.6f\n", nsites, row_ord, row_ali);
    /* the single-link row: link (0, 0) against every neighbour link (y, b) */
    double sl_ali = 0, sl_ord = 0; int nnb = 0;
    for (int si = 0; si < NS; si++) for (int bb = 0; bb < 4; bb++) { int hit = 0; for (int j = 0; j < 3; j++) if (SL_abs[si][bb][j] != 0) hit = 1;
        if (!hit) { /* a neighbour may share loops with zero couplings; count it from the census by the dead run instead */ continue; }
        nnb++; double ra = 0, ro = 0;
        for (int j = 0; j < 3; j++) { double v = SL_abs[si][bb][j] / DJ2[j]; if (v > ra) ra = v; }
        { double nw = fabs(SL_p[si][bb][0] + SL_m[si][bb][0]) / 4, nx = fabs(-SL_p[si][bb][0] + SL_m[si][bb][0]) / 4; ro = nw > nx ? nw : nx;
          for (int j = 1; j < 3; j++) { double v = SL_abs[si][bb][j] / DJ2[j]; if (v > ro) ro = v; } }
        sl_ali += ra; sl_ord += ro; }
    printf("CP-SINGLE link (0,0), first order, kappa = 0: neighbour links with a nonzero coupling %d (122 share a loop); ORDERED %.6f; ALIGNED %.6f (the earlier instrument's R_first form)\n", nnb, sl_ord, sl_ali);
    /* the same-site count of neighbour links from the census (dead run prints it) */
    if (dead) { int cnt = 0; for (int si = 0; si < NS; si++) if (NSITE_HIT[si]) cnt++; printf("CP-DEAD every coupling zero: sites sharing a loop with the origin's bundle %d; rows 0 as printed\n", cnt); }
    return ok ? 0 : 1;
}
