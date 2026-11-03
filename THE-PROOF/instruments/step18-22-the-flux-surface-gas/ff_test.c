/* ff_test.c -- the free-factor column's known answers (S1 (p), 2026-11-01 15:4x EST; the author): four word sets in F_2,
 * each with the answer worked out in advance: {a b a^-1 b^-1 a} NOT a free factor (the author's obstruction: primitive abelianisation,
 * not primitive); {a, b, ab} = F_2 a free factor (Object C's words); {a, b a b^-1} rank two and NOT a free factor (b is not in it);
 * {ab, a} = F_2 a free factor; and in F_1 {U, U^-1} (Object A's) a free factor of rank one. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define CT_MAXW 64
#define CT_MAXL 256
static int WW[CT_MAXW][CT_MAXL], WL[CT_MAXW], NW = 0;
static int ct_let_idx(int let, int r) { return let > 0 ? let - 1 : r + (-let) - 1; }
#include "ct_freefactor.c"
static void setw(int n, ...) { }
static int run(const char *name, int r, int nw, const int *lens, const int *flat, int expect) {
  NW = nw; int pos = 0; for (int b = 0; b < nw; b++) { WL[b] = lens[b]; for (int k = 0; k < lens[b]; k++) WW[b][k] = flat[pos++]; }
  int rank = -1, edges = -1; int ff = ct_freefactor(r, &rank, &edges);
  printf("FF-KAT %-28s r=%d: %s (rank %d, core edges %d) expected %s -> %s\n", name, r, ff == 1 ? "FREE-FACTOR" : ff == 0 ? "NOT-FREE-FACTOR" : "OVERFLOW", rank, edges, expect ? "FREE-FACTOR" : "NOT-FREE-FACTOR", (ff == expect) ? "MET" : "FAILED");
  return ff == expect; }
int main(void) { int ok = 1;
  { int lens[1] = {5}; int flat[5] = {1, 2, -1, -2, 1}; ok &= run("{a b a^-1 b^-1 a}", 2, 1, lens, flat, 0); }
  { int lens[3] = {1, 1, 2}; int flat[4] = {1, 2, 1, 2}; ok &= run("{a, b, ab}", 2, 3, lens, flat, 1); }
  { int lens[2] = {1, 3}; int flat[4] = {1, 2, 1, -2}; ok &= run("{a, b a b^-1}", 2, 2, lens, flat, 0); }
  { int lens[2] = {2, 1}; int flat[3] = {1, 2, 1}; ok &= run("{ab, a}", 2, 2, lens, flat, 1); }
  { int lens[2] = {1, 1}; int flat[2] = {1, -1}; ok &= run("{U, U^-1} in F_1", 1, 2, lens, flat, 1); }
  { int lens[1] = {2}; int flat[2] = {1, 1}; ok &= run("{a^2}", 1, 1, lens, flat, 0); }
  { int lens[2] = {1, 2}; int flat[3] = {1, 2, 2}; ok &= run("{a, b^2}", 2, 2, lens, flat, 0); }
  printf("FF-KAT %s\n", ok ? "ALL MET" : "FAILED"); return ok ? 0 : 1; }
