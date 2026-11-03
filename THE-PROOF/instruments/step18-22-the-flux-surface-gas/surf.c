/* surf.c -- the closed flux surfaces of Z^d through one plaquette, counted by size.
 *
 * A surface is a set P of plaquettes, connected through shared links, in which every
 * link lies in exactly 0 or 2 plaquettes of P (a closed Z2 2-cycle without branching).
 * In the SU(2) character expansion with every plaquette in the fundamental, such a P
 * carries the weight u^F 2^{chi'}, chi' = V' - F, where V' counts the vertex cycles
 * (V' = V at every vertex where P is locally a disc).  This program counts, for each F,
 * the surfaces through a fixed plaquette p0 and the sum of 2^{chi'} over them.
 *
 * Search: grow P from p0, always closing the smallest open link (multiplicity 1) by one
 * of the plaquettes at that link; a plaquette is refused if it is already in P or would
 * give any link multiplicity 3.  A connected branch-free closed surface has no proper
 * closed sub-surface, so each is reached by exactly one choice sequence (no duplicates);
 * the hash check below verifies that on every run (DUP must print 0).
 *
 * Usage: surf d Fmax        prints, per F: count, sum of 2^{chi'}, chi histogram.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <math.h>

static int D, FMAX, R, W;           /* dimension, max size, box radius, box width */
static long NS;                     /* sites in the box */
static int NPAIR;                   /* plaquette orientations per site */
static int PMU[16], PNU[16];
static unsigned char *mult;         /* link multiplicity in P */
static unsigned char *inP;          /* plaquette in P */
static long stride[8];

static long cnt[64];
static double w2[64];               /* sum of 2^{chi'} */
static long chist[64][64];          /* chi' + 32 histogram */
static long nodes = 0, dups = 0;

static long site_of(const int *x) { long s = 0; for (int i = 0; i < D; i++) s += (long)(x[i] + R) * stride[i]; return s; }
static void coords(long s, int *x) { for (int i = 0; i < D; i++) { x[i] = (int)(s / stride[i]) % W - R; } }
static long link_id(long s, int mu) { return s * D + mu; }
static long plaq_id(long s, int k) { return s * NPAIR + k; }
static int pair_index(int mu, int nu) { for (int k = 0; k < NPAIR; k++) if (PMU[k] == mu && PNU[k] == nu) return k; return -1; }

/* the four links of plaquette (s,k) */
static void plaq_links(long p, long *L) {
    long s = p / NPAIR; int k = (int)(p % NPAIR); int mu = PMU[k], nu = PNU[k];
    L[0] = link_id(s, mu);
    L[1] = link_id(s + stride[mu], nu);
    L[2] = link_id(s + stride[nu], mu);
    L[3] = link_id(s, nu);
}
/* the 2(d-1) plaquettes containing link l */
static int link_plaqs(long l, long *Q) {
    long s = l / D; int mu = (int)(l % D); int n = 0;
    for (int nu = 0; nu < D; nu++) if (nu != mu) {
        int a = mu < nu ? mu : nu, b = mu < nu ? nu : mu; int k = pair_index(a, b);
        Q[n++] = plaq_id(s, k);                 /* (s; mu,nu) */
        Q[n++] = plaq_id(s - stride[nu], k);    /* (s - nu; mu,nu) */
    }
    return n;
}

static long P[128]; static int F = 0;
static long openL[512]; static int nopen = 0;

static void add_open(long l) { openL[nopen++] = l; }
static void del_open(long l) { for (int i = 0; i < nopen; i++) if (openL[i] == l) { openL[i] = openL[--nopen]; return; } fprintf(stderr, "del_open miss\n"); exit(3); }

/* duplicate check: hash of the sorted plaquette list */
#define HB (1u << 26)
static uint64_t *htab;
static int cmpl(const void *a, const void *b) { long x = *(const long *)a, y = *(const long *)b; return x < y ? -1 : x > y; }
static int seen(void) {
    long t[128]; memcpy(t, P, sizeof(long) * F); qsort(t, F, sizeof(long), cmpl);
    uint64_t h = 1469598103934665603ULL; for (int i = 0; i < F; i++) { h ^= (uint64_t)t[i]; h *= 1099511628211ULL; }
    h ^= (uint64_t)F; if (h == 0) h = 1;
    uint32_t i = (uint32_t)(h >> 38) & (HB - 1);
    while (htab[i]) { if (htab[i] == h) return 1; i = (i + 1) & (HB - 1); }
    htab[i] = h; return 0;
}

/* vertex cycles: for each vertex touched, the plaquettes of P at it, glued along
 * shared links of P at that vertex, form cycles; count them (V' = sum of cycles). */
static int vertex_cycles(void) {
    /* collect (vertex, plaquette) incidences */
    static long vx[512], vp[512]; int n = 0;
    for (int i = 0; i < F; i++) {
        long p = P[i], s = p / NPAIR; int k = (int)(p % NPAIR); int mu = PMU[k], nu = PNU[k];
        long v[4] = { s, s + stride[mu], s + stride[mu] + stride[nu], s + stride[nu] };
        for (int j = 0; j < 4; j++) { vx[n] = v[j]; vp[n] = i; n++; }
    }
    /* union-find over incidences: two incidences at the same vertex are joined when their
       plaquettes share a link of P that contains that vertex */
    static int par[512];
    for (int i = 0; i < n; i++) par[i] = i;
    #define FIND(a) ({ int _a = (a); while (par[_a] != _a) _a = par[_a] = par[par[_a]]; _a; })
    for (int i = 0; i < n; i++) for (int j = i + 1; j < n; j++) if (vx[i] == vx[j]) {
        long Li[4], Lj[4]; plaq_links(P[vp[i]], Li); plaq_links(P[vp[j]], Lj);
        int share = 0;
        for (int a = 0; a < 4 && !share; a++) for (int b = 0; b < 4; b++) if (Li[a] == Lj[b]) {
            /* does that link contain vertex vx[i]? */
            long l = Li[a], s = l / D; int mu = (int)(l % D);
            if (s == vx[i] || s + stride[mu] == vx[i]) { share = 1; break; }
        }
        if (share) { int ri = FIND(i), rj = FIND(j); if (ri != rj) par[ri] = rj; }
    }
    int cyc = 0;
    for (int i = 0; i < n; i++) if (FIND(i) == i) cyc++;
    return cyc;
}

static void record(void) {
    if (seen()) { dups++; return; }
    int vc = vertex_cycles();
    int chi = vc - F;
    cnt[F]++;
    w2[F] += (chi >= 0) ? (double)(1L << chi) : 1.0 / (double)(1L << (-chi));
    if (chi + 32 >= 0 && chi + 32 < 64) chist[F][chi + 32]++;
}

static void search(void) {
    nodes++;
    if (nopen == 0) { record(); return; }
    if (F + (nopen + 3) / 4 > FMAX) return;
    /* smallest open link */
    long l = openL[0]; for (int i = 1; i < nopen; i++) if (openL[i] < l) l = openL[i];
    long Q[16]; int nq = link_plaqs(l, Q);
    for (int qi = 0; qi < nq; qi++) {
        long q = Q[qi];
        if (inP[q]) continue;
        long L4[4]; plaq_links(q, L4);
        int ok = 1;
        for (int a = 0; a < 4; a++) if (mult[L4[a]] >= 2) { ok = 0; break; }
        if (!ok) continue;
        /* box guard */
        { long s = q / NPAIR; int x[8]; coords(s, x); int in = 1; for (int i = 0; i < D; i++) if (x[i] <= -R + 1 || x[i] >= R - 1) in = 0; if (!in) { fprintf(stderr, "BOX: radius too small\n"); exit(4); } }
        inP[q] = 1; P[F++] = q;
        for (int a = 0; a < 4; a++) { if (mult[L4[a]] == 0) add_open(L4[a]); else del_open(L4[a]); mult[L4[a]]++; }
        search();
        for (int a = 0; a < 4; a++) { mult[L4[a]]--; if (mult[L4[a]] == 0) del_open(L4[a]); else add_open(L4[a]); }
        F--; inP[q] = 0;
    }
}

int main(int argc, char **argv) {
    if (argc < 3) { fprintf(stderr, "usage: surf d Fmax\n"); return 1; }
    D = atoi(argv[1]); FMAX = atoi(argv[2]);
    R = FMAX + 3; W = 2 * R + 1;
    NS = 1; for (int i = 0; i < D; i++) NS *= W;
    stride[0] = 1; for (int i = 1; i < D; i++) stride[i] = stride[i - 1] * W;
    NPAIR = 0; for (int a = 0; a < D; a++) for (int b = a + 1; b < D; b++) { PMU[NPAIR] = a; PNU[NPAIR] = b; NPAIR++; }
    mult = calloc((size_t)NS * D, 1); inP = calloc((size_t)NS * NPAIR, 1); htab = calloc(HB, sizeof(uint64_t));
    if (!mult || !inP || !htab) { fprintf(stderr, "alloc\n"); return 2; }
    int x0[8] = {0}; long s0 = site_of(x0); long p0 = plaq_id(s0, 0);
    long L4[4]; plaq_links(p0, L4);
    inP[p0] = 1; P[F++] = p0; for (int a = 0; a < 4; a++) { mult[L4[a]] = 1; add_open(L4[a]); }
    search();
    printf("# surf d=%d Fmax=%d R=%d  nodes=%ld  DUP=%ld\n", D, FMAX, R, nodes, dups);
    printf("# F  N_plaq(F)  sum2^chi  N^(1/F)  ratio N(F)/N(F-2)  | chi histogram (chi:count)\n");
    long prev = 0;
    for (int f = 1; f <= FMAX; f++) if (cnt[f]) {
        printf("%2d %12ld %16.4f %8.4f %8.3f |", f, cnt[f], w2[f], pow((double)cnt[f], 1.0 / f), prev ? (double)cnt[f] / prev : 0.0);
        for (int c = 0; c < 64; c++) if (chist[f][c]) printf(" %d:%ld", c - 32, chist[f][c]);
        printf("\n");
        prev = cnt[f];
    }
    return 0;
}
