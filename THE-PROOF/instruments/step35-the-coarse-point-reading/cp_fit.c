/* cp_fit.c -- THE SCORE-MATCHING FIT OF THE COARSE ACTION, IN THE HOUSE (§35.3): the port of the earlier instrument's fit.py to C, reading ymc.c's
 * .stats record and solving theta = -M^{-1} b per block scale for the FULL twelve-coupling model (and P1, the plaquette alone),
 * with jackknife errors over nbin bins of configurations.  The known answer: the N24 record's n = 4 FULL line as fit.py printed it
 * (plaq_1/2 +0.12845(0.00096) ... parag_3/2 +0.00053(0.00136)); the new reading: the N32 record's n = 8 couplings, which no fit line
 * of the record carries.
 *
 * The .stats layout (fit.py's read_stats): header 8 x int32 (gsu2, N, nn, nfeat, nrep, nfam, nconf, savec); nn x int32 (the block
 * sizes); beta (double); then per configuration: plaq (double), and per block size: qm, qmin (2 doubles), M (nfeat x nfeat doubles,
 * row-major), b (nfeat), g (nfeat), nlink (int64) + 8 bytes of padding.  Features f < 12 are (family, rep) = divmod(f, 3) with the
 * families plaq, rect, chair, parag and the reps 1/2, 1, 3/2; f >= 12 the eight-link classes of the L8 records.
 *
 * build: gcc -O2 -o cp_fit cp_fit.c -lm ; usage: cp_fit FILE.stats [nbin=20] [skip=0] */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <math.h>

static const char *FAM[4] = {"plaq", "rect", "chair", "parag"}; static const char *REP[3] = {"1/2", "1", "3/2"};
static const int FAMN[4] = {6, 12, 48, 16};

static int solve(int n, const double *A, const double *b, double *x) {   /* Gaussian elimination with partial pivoting on a copy */
    double *M = malloc(sizeof(double) * n * n), *r = malloc(sizeof(double) * n);
    memcpy(M, A, sizeof(double) * n * n); memcpy(r, b, sizeof(double) * n);
    for (int c = 0; c < n; c++) { int p = c; for (int i = c + 1; i < n; i++) if (fabs(M[i * n + c]) > fabs(M[p * n + c])) p = i;
        if (fabs(M[p * n + c]) < 1e-300) { free(M); free(r); return 1; }
        if (p != c) { for (int k = 0; k < n; k++) { double t = M[c * n + k]; M[c * n + k] = M[p * n + k]; M[p * n + k] = t; } double t = r[c]; r[c] = r[p]; r[p] = t; }
        for (int i = c + 1; i < n; i++) { double f = M[i * n + c] / M[c * n + c]; for (int k = c; k < n; k++) M[i * n + k] -= f * M[c * n + k]; r[i] -= f * r[c]; } }
    for (int i = n - 1; i >= 0; i--) { double s = r[i]; for (int k = i + 1; k < n; k++) s -= M[i * n + k] * x[k]; x[i] = s / M[i * n + i]; }
    free(M); free(r); return 0;
}
static void fitmodel(const char *name, int nfeat, const double *Mt, const double *bt, const double *Mb, const double *bb, int nbin, const int *idx, int ni, int gsu2) {
    double *A = malloc(sizeof(double) * ni * ni), *v = malloc(sizeof(double) * ni), *th = malloc(sizeof(double) * ni), *jk = malloc(sizeof(double) * nbin * ni), *err = calloc(ni, sizeof(double));
    for (int i = 0; i < ni; i++) { for (int j = 0; j < ni; j++) A[i * ni + j] = Mt[idx[i] * nfeat + idx[j]]; v[i] = bt[idx[i]]; }
    if (solve(ni, A, v, th)) { printf("   model %-7s SINGULAR\n", name); return; }
    for (int i = 0; i < ni; i++) th[i] = -th[i];
    for (int k = 0; k < nbin; k++) { for (int i = 0; i < ni; i++) { for (int j = 0; j < ni; j++) A[i * ni + j] = Mt[idx[i] * nfeat + idx[j]] - Mb[(size_t) k * nfeat * nfeat + idx[i] * nfeat + idx[j]]; v[i] = bt[idx[i]] - bb[(size_t) k * nfeat + idx[i]]; }
        solve(ni, A, v, jk + k * ni); for (int i = 0; i < ni; i++) jk[k * ni + i] = -jk[k * ni + i]; }
    for (int i = 0; i < ni; i++) { double m = 0; for (int k = 0; k < nbin; k++) m += jk[k * ni + i]; m /= nbin; double s = 0; for (int k = 0; k < nbin; k++) s += (jk[k * ni + i] - m) * (jk[k * ni + i] - m); err[i] = sqrt((nbin - 1.0) / nbin * s); }
    printf("   model %-7s", name);
    for (int i = 0; i < ni; i++) { int f = idx[i]; if (f < 12) printf("  %s_%s %+.5f(%.5f)", FAM[f / 3], gsu2 ? REP[f % 3] : (f % 3 == 0 ? "q1" : f % 3 == 1 ? "q2" : "q3"), th[i], err[i]); else printf("  L8_%d %+.5f(%.5f)", f - 12, th[i], err[i]); }
    printf("\n");
    if (ni == 12) {   /* the FULL model's central and jackknife coupling sets, one line each, for the row's own jackknife */
        printf("   FULL-CENTRAL"); for (int i = 0; i < ni; i++) printf(" %+.7f", th[i]); printf("\n");
        for (int k = 0; k < nbin; k++) { printf("   FULL-JACK %d", k); for (int i = 0; i < ni; i++) printf(" %+.7f", jk[k * ni + i]); printf("\n"); } }
    free(A); free(v); free(th); free(jk); free(err);
}
int main(int argc, char **argv) {
    if (argc < 2) { fprintf(stderr, "usage: cp_fit FILE.stats [nbin] [skip]\n"); return 2; }
    int nbin = argc > 2 ? atoi(argv[2]) : 20, skip = argc > 3 ? atoi(argv[3]) : 0;
    FILE *fp = fopen(argv[1], "rb"); if (!fp) { perror(argv[1]); return 2; }
    fseek(fp, 0, SEEK_END); long len = ftell(fp); fseek(fp, 0, SEEK_SET);
    unsigned char *raw = malloc(len); if (fread(raw, 1, len, fp) != (size_t) len) { fprintf(stderr, "short read\n"); return 2; } fclose(fp);
    int32_t hdr[8]; memcpy(hdr, raw, 32); int gsu2 = hdr[0], N = hdr[1], nn = hdr[2], nfeat = hdr[3]; long off = 32;
    int32_t *nl = malloc(sizeof(int32_t) * nn); memcpy(nl, raw + off, 4 * nn); off += 4 * nn;
    double beta; memcpy(&beta, raw + off, 8); off += 8;
    long stsz = ((long) nfeat * nfeat + 2 * nfeat) * 8 + 16, rec = 8 + nn * (16 + stsz); long nc = (len - off) / rec;
    printf("CP-FIT %s: G=%s beta=%.6f N=%d nconf=%ld (skip %d) nfeat=%d nlist=[", argv[1], gsu2 ? "su2" : "vil", beta, N, nc, skip, nfeat);
    for (int i = 0; i < nn; i++) printf("%s%d", i ? ", " : "", nl[i]); printf("]\n");
    double plaqsum = 0; for (long c = skip; c < nc; c++) { double p; memcpy(&p, raw + off + c * rec, 8); plaqsum += p; }
    printf("  fine plaquette <Re U_p> = %.6f\n", plaqsum / (nc - skip));
    int ncu = (int) (nc - skip), per = ncu / nbin;
    for (int i = 0; i < nn; i++) {
        double *Mt = calloc((size_t) nfeat * nfeat, sizeof(double)), *bt = calloc(nfeat, sizeof(double)), *gt = calloc(nfeat, sizeof(double));
        double *Mb = calloc((size_t) nbin * nfeat * nfeat, sizeof(double)), *bb = calloc((size_t) nbin * nfeat, sizeof(double));
        double qmsum = 0, qminmin = 1e9, nlsum = 0;
        for (long c = skip; c < nc; c++) { long o = off + c * rec + 8 + i * (16 + stsz); double qm, qmin; memcpy(&qm, raw + o, 8); memcpy(&qmin, raw + o + 8, 8); qmsum += qm; if (qmin < qminmin) qminmin = qmin;
            const double *arr = (const double *) (raw + o + 16); int k = (int) ((c - skip) / per); if (k >= nbin) k = nbin - 1;
            for (int a = 0; a < nfeat * nfeat; a++) { Mt[a] += arr[a]; if (k < nbin) Mb[(size_t) k * nfeat * nfeat + a] += arr[a]; }
            for (int a = 0; a < nfeat; a++) { bt[a] += arr[nfeat * nfeat + a]; bb[(size_t) k * nfeat + a] += arr[nfeat * nfeat + a]; gt[a] += arr[nfeat * nfeat + nfeat + a]; }
            int64_t nlink; memcpy(&nlink, raw + o + 16 + ((long) nfeat * nfeat + 2 * nfeat) * 8, 8); nlsum += (double) nlink; }
        printf("  n=%d (coarse %d^4): |qbar| mean %.5f min %.5f; links used %.0f; loop averages:\n     ", nl[i], N / nl[i], qmsum / ncu, qminmin, nlsum);
        double visited = nlsum / 4.0;
        for (int f = 0; f < nfeat && f < 12; f++) printf("%s_%s %.6f  ", FAM[f / 3], gsu2 ? REP[f % 3] : "q", gt[f] / (FAMN[f / 3] * visited));
        printf("\n");
        int idxP1[1] = {0}; fitmodel("P1", nfeat, Mt, bt, Mb, bb, nbin, idxP1, 1, gsu2);
        int idxL1[4] = {0, 3, 6, 9}; fitmodel("L1", nfeat, Mt, bt, Mb, bb, nbin, idxL1, 4, gsu2);
        int idxF[12] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}; fitmodel("FULL", nfeat, Mt, bt, Mb, bb, nbin, idxF, 12, gsu2);
        free(Mt); free(bt); free(gt); free(Mb); free(bb);
    }
    free(raw); free(nl); return 0;
}
