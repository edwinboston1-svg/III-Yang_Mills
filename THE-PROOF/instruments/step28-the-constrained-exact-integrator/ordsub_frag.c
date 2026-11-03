/* ---- ordsub: THE SUBSTITUTED OBJECT (the author, 2026-11-02 17:2x EST; the campaign's §31.10 substitution road, priced on EI's cost model).
   With ORD_SUBST=1 every coarse edge of the two loops (a straight path of n fine links; seven distinct edges, the shared one once) has its LAST
   link in loop A's step order eliminated: every cycle holding that link holds instead the edge's other links (inverted, reversed -- the signs do
   not enter the state size), the eliminated link leaves the link set, and the order modes skip it.  The cost model is unchanged: a wire is open
   iff exactly one of its steps is processed, which already handles a cycle holding one link at two steps. ---- */
static int NELIM = 0;
static void subst_edge(const int *E, int n) {
  int elim = E[n - 1];
  for (int c = 0; c < NC; c++) { int NSL[MAXST], ns = 0;
    for (int i = 0; i < NS[c]; i++) {
      if (SL[c][i] == elim) { for (int k = n - 2; k >= 0; k--) { if (ns >= MAXST) { fprintf(stderr, "ordsub: a cycle outgrew MAXST\n"); exit(1); } NSL[ns++] = E[k]; } }
      else NSL[ns++] = SL[c][i]; }
    if (ns == 0) { fprintf(stderr, "ordsub: a cycle emptied\n"); exit(1); }
    memcpy(SL[c], NSL, sizeof(int) * ns); NS[c] = ns; }
  int map[MAXL]; int nl = 0;
  for (int l = 0; l < NL; l++) { if (l == elim) { map[l] = -1; continue; } map[l] = nl; memcpy(LB[nl], LB[l], sizeof(int) * 4); LD[nl] = LD[l]; nl++; }
  NL = nl;
  for (int c = 0; c < NC; c++) for (int i = 0; i < NS[c]; i++) { if (map[SL[c][i]] < 0) { fprintf(stderr, "ordsub: an eliminated link survived\n"); exit(1); } SL[c][i] = map[SL[c][i]]; }
  NELIM++; }
static void substitute_exact(void) { int n = NN; int cA = NP, cB = NP + 1; int A0[MAXST], B0[MAXST], nA = NS[cA], nB = NS[cB];
  memcpy(A0, SL[cA], sizeof(int) * nA); memcpy(B0, SL[cB], sizeof(int) * nB);
  int EB[7][MAXST][4], ED[7][MAXST];
  for (int e = 0; e < 4; e++) for (int k = 0; k < n; k++) { memcpy(EB[e][k], LB[A0[e * n + k]], sizeof(int) * 4); ED[e][k] = LD[A0[e * n + k]]; }
  for (int e = 0; e < 3; e++) for (int k = 0; k < n; k++) { memcpy(EB[4 + e][k], LB[B0[e * n + k]], sizeof(int) * 4); ED[4 + e][k] = LD[B0[e * n + k]]; }
  for (int e = 0; e < 7; e++) { int E[MAXST]; for (int k = 0; k < n; k++) { E[k] = lkey(EB[e][k], ED[e][k], 0); if (E[k] < 0) { fprintf(stderr, "ordsub: an edge link is missing\n"); exit(1); } } subst_edge(E, n); } }
