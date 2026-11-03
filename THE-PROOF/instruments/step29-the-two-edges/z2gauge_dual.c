/* z2gauge_dual.c -- ΑΝΑΚΛΑΣΙΣ, the Wilson instance in d = 3: Z_2 gauge theory on the N1 x N2 x N3 torus at tanh(beta) = 1/2,
 * its plaquette two-point functions EXACTLY, by the Kramers-Wannier-Wegner duality to the Ising model on the dual torus
 * summed over the eight twist sectors, the dual Ising read by row transfer matrices along direction 1 with every number an
 * integer modulo a prime (the exact integers by the Chinese remainder theorem over several primes, outside, in gawk -M).
 *
 *   THE IDENTITY (the character expansion; every step on the page ΑΝΑΚΛΑΣΙΣ Addendum I §4 / RESULTS):
 *     Z_gauge ∝ Σ_{closed 2-chains S} t^{|S|} = (1/2) Σ_{τ ∈ {0,1}^3} Σ_{spins s} t^{|wall(s, τ)|}
 *     <U_p U_q> = t^2 · Σ_{S} t^{|S| − 2·1_p(S) − 2·1_q(S)} / Σ_S t^{|S|}
 *   so at t = 1/2, with the integer bond weight 2 (agree) / 1 (disagree) and the two DUAL bonds of p, q given the weight
 *   2 (agree) / 4 (disagree): <U_p U_q> = (1/4) · Σ_τ N_τ / Σ_τ Z_τ.
 *   A plaquette (x; μ,ν) is dual to the bond of direction ρ (ρ ∉ {μ,ν}) between the dual sites x − e_ρ and x.
 *   The twist τ_ρ flips the sign of every direction-ρ bond crossing x_ρ = N_ρ − 1 → 0.
 *
 *   MODES:  z2gauge_dual mod  N1 N2 N3 PRIME  p1 p2 ... (pairs of plaquettes)     -> residues per sector (τ1 by the flip matrix)
 *           z2gauge_dual exact N1 N2 N3        p1 p2 ...                           -> 64-bit exact (small tori only)
 *           z2gauge_dual gauge N1 N2 N3        p1 p2 ...                           -> brute force over every link configuration
 *                                                                                   (2^{3 N1 N2 N3} states; N = 2,2,2 only)
 *   a plaquette is written x1,x2,x3,mu,nu (mu < nu in {1,2,3}); pairs consecutive.  gcc -O2 -o z2gauge_dual z2gauge_dual.c
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
typedef unsigned __int128 u128;
typedef uint64_t u64;

static int N1, N2, N3, NS, S;          /* NS = N2*N3 spins per slice, S = 2^NS states */
static u64 PR;                          /* the prime (mod mode) or 0 (exact mode) */
static int mode_exact = 0;

typedef struct { int x1, x2, x3, mu, nu; } Plaq;
typedef struct { int dir, x1, x2, x3; } Bond;   /* the dual bond: direction and the base dual site (the bond goes from x - e_dir to x) */

static Bond dual_of(Plaq p) {
  Bond b; int rho = 6 - p.mu - p.nu;    /* {1,2,3} minus {mu,nu} */
  b.dir = rho; b.x1 = p.x1; b.x2 = p.x2; b.x3 = p.x3; return b;
}
static inline int spin(int r, int i) { return (r >> i) & 1; }
static inline int idx(int x2, int x3) { return x2 + N2 * x3; }

/* multiply-accumulate mod PR, or plain 64-bit in exact mode */
static inline u64 mulmod(u64 a, u64 b) { if (mode_exact) return a * b; return (u64)(((u128)a * b) % PR); }
static inline u64 addmod(u64 a, u64 b) { if (mode_exact) return a + b; u64 c = a + b; if (c >= PR) c -= PR; return c; }

/* C = A * B (S x S), each entry accumulated in 128 bits then reduced once; B is transposed first so that both operands of the
 * inner product are read contiguously (the strided column read of B was the cost) */
static u64 *BT = NULL;
static void matmul(const u64 *A, const u64 *B, u64 *C) {
  if (!BT) BT = malloc((size_t)S * S * sizeof(u64));
  for (int k = 0; k < S; k++) for (int q = 0; q < S; q++) BT[(size_t)q * S + k] = B[(size_t)k * S + q];
  for (int r = 0; r < S; r++) {
    const u64 *Ar = A + (size_t)r * S;
    for (int q = 0; q < S; q++) {
      const u64 *Bq = BT + (size_t)q * S;
      u128 acc = 0;
      for (int k = 0; k < S; k++) acc += (u128)Ar[k] * Bq[k];
      C[(size_t)r * S + q] = mode_exact ? (u64)acc : (u64)(acc % PR);
    }
  }
}

/* the intra-slice weight of state r in a slice (twists t2, t3), with optional special intra bonds (i, j) at weight 2/4 */
static u64 hweight(int r, int t2, int t3, int nsp, const int *spi, const int *spj) {
  u64 w = 1;
  for (int x3 = 0; x3 < N3; x3++) for (int x2 = 0; x2 < N2; x2++) {
    int i = idx(x2, x3), j2 = idx((x2 + 1) % N2, x3), j3 = idx(x2, (x3 + 1) % N3);
    int tw2 = (x2 == N2 - 1) ? t2 : 0, tw3 = (x3 == N3 - 1) ? t3 : 0;
    int agree2 = ((spin(r, i) ^ spin(r, j2)) ^ tw2) == 0;
    int agree3 = ((spin(r, i) ^ spin(r, j3)) ^ tw3) == 0;
    int sp2 = 0, sp3 = 0;
    for (int s = 0; s < nsp; s++) { if (spi[s] == i && spj[s] == j2) sp2 = 1; if (spi[s] == i && spj[s] == j3) sp3 = 1; }
    w *= agree2 ? 2 : (sp2 ? 4 : 1);
    if (N3 == 1) { /* a direction-3 bond from a site to itself: agree always */ w *= 2; }
    else w *= agree3 ? 2 : (sp3 ? 4 : 1);
  }
  return w;
}
/* the inter-slice weight between states r (slice j) and q (slice j+1), with optional special inter bonds at sites i */
static u64 vweight(int r, int q, int nsp, const int *spi) {
  u64 w = 1;
  for (int i = 0; i < NS; i++) {
    int agree = spin(r, i) == spin(q, i), sp = 0;
    for (int s = 0; s < nsp; s++) if (spi[s] == i) sp = 1;
    w *= agree ? 2 : (sp ? 4 : 1);
  }
  return w;
}

/* build T_j for slice j (0..N1-1): entries h(r) * v(r,q), with the special bonds that live at slice j */
static void build_T(u64 *T, int j, int t2, int t3, int nb, const Bond *bs) {
  int ii[8], jj[8], ni = 0, vi[8], nv = 0;
  for (int b = 0; b < nb; b++) {
    if (bs[b].dir == 1) { if (((bs[b].x1 - 1 + N1) % N1) == j) vi[nv++] = idx(bs[b].x2, bs[b].x3); }      /* inter bond from slice x1-1 to x1 */
    else if (bs[b].x1 == j) {
      if (bs[b].dir == 2) { ii[ni] = idx((bs[b].x2 - 1 + N2) % N2, bs[b].x3); jj[ni] = idx(bs[b].x2, bs[b].x3); ni++; }
      else                { ii[ni] = idx(bs[b].x2, (bs[b].x3 - 1 + N3) % N3); jj[ni] = idx(bs[b].x2, bs[b].x3); ni++; }
    }
  }
  for (int r = 0; r < S; r++) {
    u64 h = hweight(r, t2, t3, ni, ii, jj); if (!mode_exact) h %= PR;
    for (int q = 0; q < S; q++) { u64 v = vweight(r, q, nv, vi); if (!mode_exact) v %= PR; T[(size_t)r * S + q] = mulmod(h, v); }
  }
}

/* the chain product T_0 ... T_{N1-1} once, then BOTH traces: with Π^{t1}, Π the global flip of the last slice's partner */
static void trace_chain2(u64 **Tj, u64 *tmpA, u64 *tmpB, u64 *tr0, u64 *tr1) {
  memcpy(tmpA, Tj[0], (size_t)S * S * sizeof(u64));
  u64 *cur = tmpA, *nxt = tmpB;
  for (int j = 1; j < N1; j++) { matmul(cur, Tj[j], nxt); u64 *t = cur; cur = nxt; nxt = t; }
  u64 a = 0, b = 0; int flip = (1 << NS) - 1;
  for (int r = 0; r < S; r++) { a = addmod(a, cur[(size_t)r * S + r]); b = addmod(b, cur[(size_t)r * S + (r ^ flip)]); }
  *tr0 = a; *tr1 = b;
}

static int parse_plaq(const char *s, Plaq *p) { return sscanf(s, "%d,%d,%d,%d,%d", &p->x1, &p->x2, &p->x3, &p->mu, &p->nu) == 5; }

/* brute force over every link configuration of the gauge theory on a tiny torus (N = 2,2,2: 24 links) */
static void gauge_brute(int np, const Plaq *pl) {
  int V = N1 * N2 * N3, NL = 3 * V;
  if (NL > 30) { fprintf(stderr, "gauge: too many links (%d)\n", NL); exit(2); }
  /* link index: site (x1,x2,x3) -> v = x1 + N1*(x2 + N2*x3); link (v, mu) -> 3v + (mu-1) */
  #define SITE(a,b,c) ((((a)%N1+N1)%N1) + N1*((((b)%N2+N2)%N2) + N2*(((c)%N3+N3)%N3)))
  #define LINK(v,m) (3*(v) + ((m)-1))
  /* plaquette list of the torus */
  int NP = 3 * V; int (*pl4)[4] = malloc(sizeof(int[4]) * NP); int npq = 0;
  for (int x3 = 0; x3 < N3; x3++) for (int x2 = 0; x2 < N2; x2++) for (int x1 = 0; x1 < N1; x1++) {
    int d[4] = {0, x1, x2, x3};
    for (int mu = 1; mu <= 3; mu++) for (int nu = mu + 1; nu <= 3; nu++) {
      int e1[4] = {0,0,0,0}, e2[4] = {0,0,0,0}; e1[mu] = 1; e2[nu] = 1;
      int v0 = SITE(d[1], d[2], d[3]), v1 = SITE(d[1]+e1[1], d[2]+e1[2], d[3]+e1[3]), v2 = SITE(d[1]+e2[1], d[2]+e2[2], d[3]+e2[3]);
      pl4[npq][0] = LINK(v0, mu); pl4[npq][1] = LINK(v1, nu); pl4[npq][2] = LINK(v2, mu); pl4[npq][3] = LINK(v0, nu); npq++;
    }
  }
  /* the requested plaquettes' indices */
  int *pid = malloc(sizeof(int) * np);
  for (int k = 0; k < np; k++) {
    int e1[4] = {0,0,0,0}, e2[4] = {0,0,0,0}; e1[pl[k].mu] = 1; e2[pl[k].nu] = 1;
    int v0 = SITE(pl[k].x1, pl[k].x2, pl[k].x3);
    int v1 = SITE(pl[k].x1+e1[1], pl[k].x2+e1[2], pl[k].x3+e1[3]), v2 = SITE(pl[k].x1+e2[1], pl[k].x2+e2[2], pl[k].x3+e2[3]);
    int l0 = LINK(v0, pl[k].mu), l1 = LINK(v1, pl[k].nu), l2 = LINK(v2, pl[k].mu), l3 = LINK(v0, pl[k].nu);
    pid[k] = -1;
    for (int q = 0; q < npq; q++) if (pl4[q][0]==l0 && pl4[q][1]==l1 && pl4[q][2]==l2 && pl4[q][3]==l3) pid[k] = q;
    if (pid[k] < 0) { fprintf(stderr, "gauge: plaquette %d not found\n", k); exit(2); }
  }
  /* Σ over links of Π_p (1 + t U_p) scaled: weight 3^{#(U_p = +1)} · 1^{#(U_p=-1)} at t = 1/2 (2 + U_p = 3 or 1) */
  u128 Z = 0; u128 *num = calloc(np / 2, sizeof(u128));
  for (u64 c = 0; c < (1ull << NL); c++) {
    int up[72]; u64 w = 1;
    for (int q = 0; q < npq; q++) {
      int sgn = ((c >> pl4[q][0]) ^ (c >> pl4[q][1]) ^ (c >> pl4[q][2]) ^ (c >> pl4[q][3])) & 1;  /* 1 = U_p = -1 */
      up[q] = sgn ? -1 : 1; w *= sgn ? 1 : 3;
    }
    Z += w;
    for (int k = 0; k < np / 2; k++) { long long pr = (long long)up[pid[2*k]] * up[pid[2*k+1]]; if (pr > 0) num[k] += w; else num[k] -= w; }
  }
  printf("GAUGE-BRUTE N=%d,%d,%d links=%d Z=%llu", N1, N2, N3, NL, (unsigned long long)Z);
  for (int k = 0; k < np / 2; k++) printf(" C%d=%lld", k, (long long)num[k]);
  printf(" ;\n");
  free(pl4); free(pid); free(num);
}

int main(int argc, char **argv) {
  if (argc < 6) { fprintf(stderr, "usage: z2gauge_dual mod|exact|gauge N1 N2 N3 [PRIME] p1 p2 ...\n"); return 2; }
  const char *mode = argv[1]; N1 = atoi(argv[2]); N2 = atoi(argv[3]); N3 = atoi(argv[4]);
  int ai = 5; PR = 0; mode_exact = 0;
  if (!strcmp(mode, "mod")) { PR = strtoull(argv[5], NULL, 10); ai = 6; }
  else if (!strcmp(mode, "exact")) mode_exact = 1;
  int np = argc - ai; Plaq *pl = malloc(sizeof(Plaq) * (np > 0 ? np : 1));
  for (int k = 0; k < np; k++) if (!parse_plaq(argv[ai + k], &pl[k])) { fprintf(stderr, "bad plaquette %s\n", argv[ai + k]); return 2; }
  if (np % 2) { fprintf(stderr, "plaquettes come in pairs\n"); return 2; }
  if (!strcmp(mode, "gauge")) { gauge_brute(np, pl); return 0; }
  NS = N2 * N3; S = 1 << NS;
  if (NS > 14) { fprintf(stderr, "slice too large (%d spins)\n", NS); return 2; }
  printf("DUAL-ISING mode=%s N=%d,%d,%d spins_per_slice=%d states=%d prime=%llu pairs=%d ;\n", mode, N1, N2, N3, NS, S, (unsigned long long)PR, np / 2);
  size_t SZ = (size_t)S * S;
  u64 *T = malloc(SZ * 8), *tmpA = malloc(SZ * 8), *tmpB = malloc(SZ * 8);
  u64 **Tj = malloc(sizeof(u64*) * N1); for (int j = 0; j < N1; j++) Tj[j] = NULL;
  for (int t3 = 0; t3 < 2; t3++) for (int t2 = 0; t2 < 2; t2++) {
    /* Z: every slice the plain T */
    build_T(T, 0, t2, t3, 0, NULL);
    for (int j = 0; j < N1; j++) Tj[j] = T;
    u64 Z0, Z1; trace_chain2(Tj, tmpA, tmpB, &Z0, &Z1);
    printf("SECTOR t2=%d t3=%d Z(t1=0)=%llu Z(t1=1)=%llu", t2, t3, (unsigned long long)Z0, (unsigned long long)Z1);
    /* each pair: the slices carrying a dual bond get their own modified T */
    for (int k = 0; k < np / 2; k++) {
      Bond bs[2] = { dual_of(pl[2*k]), dual_of(pl[2*k+1]) };
      int touched[64]; for (int j = 0; j < N1; j++) touched[j] = 0;
      for (int b = 0; b < 2; b++) { int j = (bs[b].dir == 1) ? ((bs[b].x1 - 1 + N1) % N1) : bs[b].x1; touched[j] = 1; }
      u64 *Tm[64];
      for (int j = 0; j < N1; j++) { if (touched[j]) { Tm[j] = malloc(SZ * 8); build_T(Tm[j], j, t2, t3, 2, bs); Tj[j] = Tm[j]; } else Tj[j] = T; }
      u64 n0, n1; trace_chain2(Tj, tmpA, tmpB, &n0, &n1);
      printf(" N%d(t1=0)=%llu N%d(t1=1)=%llu", k, (unsigned long long)n0, k, (unsigned long long)n1);
      for (int j = 0; j < N1; j++) if (touched[j]) free(Tm[j]);
    }
    printf(" ;\n"); fflush(stdout);
  }
  printf("DUAL-END ;\n");
  return 0;
}
