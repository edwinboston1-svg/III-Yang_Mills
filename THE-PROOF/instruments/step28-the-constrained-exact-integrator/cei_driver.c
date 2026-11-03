  if (CEI) {   /* ---- cei_face: the sweeps of the substituted object -- Z and its source-tilted companions; the slices when a cycle is clamped; the configurations branched at the first source closing ---- */
    if (LMAX != 0) { fprintf(stderr, "CEI REFUSED: the loop cycles are dropped, so LMAX must be 0\n"); return 1; }
    for (int w = 0; w < NW; w++) FIXV[w] = -1;   /* no wire clamped (the engine initialises this after the point where this driver runs) */
    if (getenv("CEI_PEAK")) PEAKLIST = atoi(getenv("CEI_PEAK")); if (getenv("CEI_PROFILE")) PROFILE = atoi(getenv("CEI_PROFILE")); if (getenv("CEI_NOBRANCH") && atoi(getenv("CEI_NOBRANCH")) == 1) BRANCH = 0;
    if (getenv("CEI_LISTOUT") && atoi(getenv("CEI_LISTOUT")) == 1) cei_list_out(DATA);   /* the outside links with the datum's values, "x y z t d w x y z" -- the datum file's own format */
    if (getenv("CEI_PIN") && atoi(getenv("CEI_PIN")) == 1) {   /* THE PINNING (campaign 31.17): per surviving link, the norm of the sum of its staples' group elements at the datum (5 at the identity datum, 0 when they cancel) and of the partner's inverse staples' -- a datum invariant to put beside the cell's gap */
      for (int l = 0; l < NL; l++) { if (ELIM[l]) continue; quat s = { 0, 0, 0, 0 }; for (int k = 0; k < NSTAP[l]; k++) { quat T = staple(l, k, DATA); s.w += T.w; s.x += T.x; s.y += T.y; s.z += T.z; }
        quat si = { 0, 0, 0, 0 }; for (int k = 0; k < NISTAP[l]; k++) { quat T = istaple(l, k, DATA); si.w += T.w; si.x += T.x; si.y += T.y; si.z += T.z; }
        printf("CEI-PIN link %d (%d,%d,%d) d%d staples %d |sum| = %.6f inverse-staples %d |sum| = %.6f\n", l, LB[l][0], LB[l][1], LB[l][2], LD[l], NSTAP[l], sqrt(s.w * s.w + s.x * s.x + s.y * s.y + s.z * s.z), NISTAP[l], sqrt(si.w * si.w + si.x * si.x + si.y * si.y + si.z * si.z)); } }
    if (getenv("CEI_CLAMP")) { if (sscanf(getenv("CEI_CLAMP"), "%d:%d:%d", &CLAMPC, &CLAMPWA, &CLAMPWB) != 3 || CLAMPC < 0 || CLAMPC >= NCYC || ISLOOP[CLAMPC] || NSTEP[CLAMPC] == 0) { fprintf(stderr, "CEI_CLAMP must be cycle:wireA:wireB with a live plaquette or corner cycle\n"); return 1; }
      if (CLAMPWA < WBASE[CLAMPC] || CLAMPWA >= WBASE[CLAMPC] + NWIRE[CLAMPC] || CLAMPWB < WBASE[CLAMPC] || CLAMPWB >= WBASE[CLAMPC] + NWIRE[CLAMPC] || CLAMPWA == CLAMPWB) { fprintf(stderr, "CEI_CLAMP: the two wires must be distinct wires of cycle %d (%d..%d)\n", CLAMPC, WBASE[CLAMPC], WBASE[CLAMPC] + NWIRE[CLAMPC] - 1); return 1; }
      int nsl = 0; for (int s = 0; s <= WMAX; s++) nsl += DIM[s] * DIM[s];
      printf("CEI-CLAMP cycle %d (steps %d) wires %d and %d: the slices (spin s, two indices < d_s) summed outside -- %d slices at WMAX %d; %s\n", CLAMPC, NSTEP[CLAMPC], CLAMPWA, CLAMPWB, nsl, WMAX,
        NWIRE[CLAMPC] == 2 ? "every wire of the cycle fixed, so it never enters the state and its closing weight is applied once per slice by the driver" : "the cycle's other wires open as usual, its closing through the state at the slice's spin"); }
    if (SELFON) { double FS1[32], dmax = 0; double i1 = bessel(1, BETA); for (int k = 1; k <= WMAX; k++) FS1[k] = (k + 1) * bessel(k + 1, BETA) / i1;
      for (int pt = 0; pt < NPT; pt++) { double a = 1; for (int k = 1; k <= WMAX; k++) a += FS1[k] * chi(k, RU[pt]); double dd = fabs(a - wgt(RU[pt])); if (dd > dmax) dmax = dd; }
      printf("CEI-SELF-KAT kappa=1 at the cap WMAX: max |self weight - the staple weight wgt| over the rule's %d points = %.1e (the same Bessel ratios); kappa=0: the weight is 1 by construction\n", NPT, dmax); }
    int ncfg = (NSRC == 0) ? 1 : (NSRC == 1 ? 2 : 4); double ZZ[4] = { 0, 0, 0, 0 }, ZI[4] = { 0, 0, 0, 0 }, tcfg[4] = { 0, 0, 0, 0 }; const char *nm[4] = { "none", "p", "q", "pq" };
    const int *ord = NCEIORD ? CEIORD : order; int nord = NCEIORD ? NCEIORD : NORD;
    if (getenv("CEI_TRANSFER")) {   /* ---- THE TRANSFER OPERATOR OF ONE CELL (campaign 31.15): the sweep to the cut after step iA (1-based over the order, eliminated
         links counted as the profile counts them), every basis vector of that cut's state space injected and carried through the links of steps iA+1..iB, the
         cut after iB read back as the translate (cycles + csh, wires + wsh); then the two leading eigenvalues by power iteration and deflation ---- */
      int iA, iB, csh, wsh; if (sscanf(getenv("CEI_TRANSFER"), "%d:%d:%d:%d", &iA, &iB, &csh, &wsh) != 4 || iA < 1 || iB <= iA || iB > nord) { fprintf(stderr, "CEI_TRANSFER must be iA:iB:cycleshift:wireshift\n"); return 1; }
      for (int c = 0; c < NCYC; c++) for (int q = 0; q <= WMAX; q++) PFAC[c][q] = FAC[q];
      state_t SA; SA.nopen = 0; SA.ncyc = 0; SA.nblk = 1; SA.blk = calloc(1, sizeof(cplx *)); SA.size = calloc(1, sizeof(size_t)); SA.blk[0] = calloc(1, sizeof(cplx)); SA.blk[0][0] = 1; SA.size[0] = 1;
      for (int i = 0; i < iA; i++) { if (ELIM[ord[i]]) continue; process(&SA, ord[i]); }
      int dim = 0; size_t boff[4096]; if (SA.nblk > 4096) { fprintf(stderr, "CEI_TRANSFER: too many blocks\n"); return 1; }
      for (int b = 0; b < SA.nblk; b++) { boff[b] = dim; dim += (int)SA.size[b]; }
      printf("CEI-TRANSFER the cut after step %d: %d open cycles (", iA, SA.ncyc); for (int i = 0; i < SA.ncyc; i++) printf("%sc%d", i ? " " : "", SA.cyc[i]); printf("), %d open wires (", SA.nopen); for (int w = 0; w < SA.nopen; w++) printf("%sw%d", w ? " " : "", SA.open[w]);
      printf("), dimension %d; the cell's links are steps %d..%d; the cut after step %d read as the translate (cycles +%d, wires +%d)\n", dim, iA + 1, iB, iB, csh, wsh);
      cplx *T = calloc((size_t)dim * dim, sizeof(cplx)); if (!T) { fprintf(stderr, "CEI_TRANSFER: out of memory for T (%d x %d)\n", dim, dim); return 3; }
      int ncol = 0, bad = 0;
      for (int b = 0; b < SA.nblk; b++) { if (!SA.blk[b]) continue;
        for (size_t e = 0; e < SA.size[b]; e++) {
          state_t U; U.nopen = SA.nopen; memcpy(U.open, SA.open, sizeof(int) * SA.nopen); U.ncyc = SA.ncyc; memcpy(U.cyc, SA.cyc, sizeof(int) * SA.ncyc); U.nblk = SA.nblk;
          U.blk = calloc(U.nblk, sizeof(cplx *)); U.size = calloc(U.nblk, sizeof(size_t)); U.blk[b] = calloc(SA.size[b], sizeof(cplx)); U.blk[b][e] = 1; U.size[b] = SA.size[b];
          for (int i = iA; i < iB; i++) { if (ELIM[ord[i]]) continue; process(&U, ord[i]); }
          if (U.ncyc != SA.ncyc || U.nopen != SA.nopen) { fprintf(stderr, "CEI_TRANSFER: the cut after step %d has %d cycles and %d wires, the cut after %d had %d and %d\n", iB, U.ncyc, U.nopen, iA, SA.ncyc, SA.nopen); return 1; }
          int pin[MAXCYC], pw[128];
          for (int i = 0; i < U.ncyc; i++) { pin[i] = in_list(U.cyc[i] - csh, SA.cyc, SA.ncyc); if (pin[i] < 0) { if (!bad) fprintf(stderr, "CEI_TRANSFER: output cycle c%d is not a translate of the cut's\n", U.cyc[i]); bad++; } }
          for (int w = 0; w < U.nopen; w++) { pw[w] = in_list(U.open[w] - wsh, SA.open, SA.nopen); if (pw[w] < 0) { if (!bad) fprintf(stderr, "CEI_TRANSFER: output wire w%d is not a translate of the cut's\n", U.open[w]); bad++; } }
          if (bad) return 1;
          for (int b2 = 0; b2 < U.nblk; b2++) { if (!U.blk[b2]) continue;
            int sp[MAXCYC]; { int bb = b2; for (int i = 0; i < U.ncyc; i++) { sp[i] = bb % (WMAX + 1); bb /= WMAX + 1; } }
            int bin = 0; { for (int i = 0; i < U.ncyc; i++) { int mul = 1; for (int k = 0; k < pin[i]; k++) mul *= WMAX + 1; bin += sp[i] * mul; } }
            int spinin[MAXCYC]; for (int c = 0; c < NCYC; c++) spinin[c] = -1; for (int i = 0; i < U.ncyc; i++) spinin[SA.cyc[pin[i]]] = sp[i];
            size_t sin_[128]; { size_t mul = 1; for (int i = SA.nopen - 1; i >= 0; i--) { sin_[i] = mul; mul *= DIM[spinin[WCYC[SA.open[i]]]]; } }
            int od[128]; { for (int w = 0; w < U.nopen; w++) { int c = U.cyc[0]; for (int i = 0; i < U.ncyc; i++) if (WCYC[U.open[w]] == U.cyc[i]) c = i; od[w] = DIM[sp[c]]; } }
            for (size_t e2 = 0; e2 < U.size[b2]; e2++) { cplx v = U.blk[b2][e2]; if (v == 0) continue; size_t rem = e2, ein = 0; for (int w = U.nopen - 1; w >= 0; w--) { size_t ix = rem % od[w]; rem /= od[w]; ein += ix * sin_[pw[w]]; }
              T[(boff[bin] + ein) * dim + (boff[b] + e)] += v; } }
          free_state(&U); ncol++; } }
      printf("  T built: %d columns of %d; |T| max %.6e\n", ncol, dim, 0.0);
      { double tmax = 0; for (size_t k = 0; k < (size_t)dim * dim; k++) if (cabs(T[k]) > tmax) tmax = cabs(T[k]); double fro = 0, asym = 0; for (int i = 0; i < dim; i++) for (int j = 0; j < dim; j++) { fro += cabs(T[(size_t)i * dim + j]) * cabs(T[(size_t)i * dim + j]); asym += cabs(T[(size_t)i * dim + j] - T[(size_t)j * dim + i]) * cabs(T[(size_t)i * dim + j] - T[(size_t)j * dim + i]); }
        printf("  |T|: max entry %.6e, Frobenius %.6e, ||T - T^t||_F / ||T||_F = %.3e (T is symmetric in the wire basis iff the reflected cell is the cell)\n", tmax, sqrt(fro), sqrt(asym / fro)); }
      /* the leading eigenpair by power iteration, the left vector from T^t, the second eigenvalue by deflation */
      cplx *v = malloc(sizeof(cplx) * dim), *w = malloc(sizeof(cplx) * dim), *u = malloc(sizeof(cplx) * dim); double lam1 = 0, lam2 = 0; int it1 = 0, it2 = 0, itu = 0;
      for (int i = 0; i < dim; i++) v[i] = 1.0 / sqrt((double)dim);
      for (it1 = 0; it1 < 20000; it1++) { for (int i = 0; i < dim; i++) { cplx s = 0; for (int j = 0; j < dim; j++) s += T[(size_t)i * dim + j] * v[j]; w[i] = s; }
        double nw = 0; for (int i = 0; i < dim; i++) nw += cabs(w[i]) * cabs(w[i]); nw = sqrt(nw); double dd = 0, dd2 = 0; for (int i = 0; i < dim; i++) { cplx nv = w[i] / nw; dd += cabs(nv - v[i]) * cabs(nv - v[i]); dd2 += cabs(nv + v[i]) * cabs(nv + v[i]); v[i] = nv; } if (dd2 < dd) dd = dd2; lam1 = nw; if (sqrt(dd) < 1e-14) break; }
      for (int i = 0; i < dim; i++) u[i] = 1.0 / sqrt((double)dim);
      for (itu = 0; itu < 20000; itu++) { for (int i = 0; i < dim; i++) { cplx s = 0; for (int j = 0; j < dim; j++) s += T[(size_t)j * dim + i] * u[j]; w[i] = s; }
        double nw = 0; for (int i = 0; i < dim; i++) nw += cabs(w[i]) * cabs(w[i]); nw = sqrt(nw); double dd = 0, dd2 = 0; for (int i = 0; i < dim; i++) { cplx nu = w[i] / nw; dd += cabs(nu - u[i]) * cabs(nu - u[i]); dd2 += cabs(nu + u[i]) * cabs(nu + u[i]); u[i] = nu; } if (dd2 < dd) dd = dd2; if (sqrt(dd) < 1e-14) break; }
      cplx uv = 0; for (int i = 0; i < dim; i++) uv += u[i] * v[i];
      cplx *x = malloc(sizeof(cplx) * dim); for (int i = 0; i < dim; i++) x[i] = (i % 2 ? 1.0 : -1.0) / sqrt((double)dim);
      for (it2 = 0; it2 < 20000; it2++) { cplx ux = 0; for (int i = 0; i < dim; i++) ux += u[i] * x[i]; for (int i = 0; i < dim; i++) x[i] -= v[i] * ux / uv;   /* project out the leading mode */
        for (int i = 0; i < dim; i++) { cplx s = 0; for (int j = 0; j < dim; j++) s += T[(size_t)i * dim + j] * x[j]; w[i] = s; }
        double nw = 0; for (int i = 0; i < dim; i++) nw += cabs(w[i]) * cabs(w[i]); nw = sqrt(nw); double dd = 0, dd2 = 0; for (int i = 0; i < dim; i++) { cplx nx = w[i] / nw; dd += cabs(nx - x[i]) * cabs(nx - x[i]); dd2 += cabs(nx + x[i]) * cabs(nx + x[i]); x[i] = nx; } if (dd2 < dd) dd = dd2; lam2 = nw; if (sqrt(dd) < 1e-13) break; }
      cplx r1 = 0, r2 = 0; for (int i = 0; i < dim; i++) { cplx s = 0, t = 0; for (int j = 0; j < dim; j++) { s += T[(size_t)i * dim + j] * v[j]; t += T[(size_t)i * dim + j] * x[j]; } r1 += conj(v[i]) * s; r2 += conj(x[i]) * t; }
      printf("CEI-TRANSFER-SPECTRUM lambda_1 = %.15e (power iteration, %d steps; Rayleigh %.15e %+.1ei) lambda_2 = %.15e (%d steps after deflation; Rayleigh %.15e %+.1ei); lambda_1/lambda_2 = %.6f, the gap ln(lambda_1/lambda_2) = %.6f per cell, %.6f per fine unit (n = %d)\n", lam1, it1, creal(r1), cimag(r1), lam2, it2, creal(r2), cimag(r2), lam1 / lam2, log(lam1 / lam2), log(lam1 / lam2) / NN, NN);
      /* THE PHYSICAL SECTOR: the leading modes by a Wielandt deflation chain, each with its weight in the sweep's own cut state (no source) and in the
         cut state with the chi_1 source on plaquette SRC[0] (closed before the cut) -- a mode no source reaches is not the two-point function's */
      { int M = 10; if (M > dim) M = dim; cplx *TD = malloc(sizeof(cplx) * (size_t)dim * dim); memcpy(TD, T, sizeof(cplx) * (size_t)dim * dim);
        cplx *VV = malloc(sizeof(cplx) * (size_t)M * dim), *UU = malloc(sizeof(cplx) * (size_t)M * dim); double LL[16]; int IT[16];
        cplx *sa = calloc(dim, sizeof(cplx)), *sp = calloc(dim, sizeof(cplx));
        for (int b = 0; b < SA.nblk; b++) if (SA.blk[b]) for (size_t e = 0; e < SA.size[b]; e++) sa[boff[b] + e] = SA.blk[b][e];
        if (NSRC >= 1) { cei_source(SRC[0]);
          state_t SP; SP.nopen = 0; SP.ncyc = 0; SP.nblk = 1; SP.blk = calloc(1, sizeof(cplx *)); SP.size = calloc(1, sizeof(size_t)); SP.blk[0] = calloc(1, sizeof(cplx)); SP.blk[0][0] = 1; SP.size[0] = 1;
          for (int i = 0; i < iA; i++) { if (ELIM[ord[i]]) continue; process(&SP, ord[i]); }
          if (SP.nblk == SA.nblk) for (int b = 0; b < SP.nblk; b++) if (SP.blk[b]) for (size_t e = 0; e < SP.size[b]; e++) sp[boff[b] + e] = SP.blk[b][e];
          free_state(&SP); for (int q = 0; q <= WMAX; q++) PFAC[SRC[0]][q] = FAC[q]; }
        for (int m = 0; m < M; m++) { cplx *vm = VV + (size_t)m * dim, *um = UU + (size_t)m * dim; for (int i = 0; i < dim; i++) { vm[i] = ((i * 7 + m * 3) % 11 - 5.0) / sqrt((double)dim); um[i] = ((i * 5 + m * 7) % 13 - 6.0) / sqrt((double)dim); } double lm = 0; int it;
          for (it = 0; it < 5000; it++) { for (int i = 0; i < dim; i++) { cplx s = 0; for (int j = 0; j < dim; j++) s += TD[(size_t)i * dim + j] * vm[j]; w[i] = s; }
            double nw = 0; for (int i = 0; i < dim; i++) nw += cabs(w[i]) * cabs(w[i]); nw = sqrt(nw); if (nw == 0) break; double dd = 0, dd2 = 0; for (int i = 0; i < dim; i++) { cplx nv = w[i] / nw; dd += cabs(nv - vm[i]) * cabs(nv - vm[i]); dd2 += cabs(nv + vm[i]) * cabs(nv + vm[i]); vm[i] = nv; } if (dd2 < dd) dd = dd2; lm = nw; if (sqrt(dd) < 1e-13) break; }
          IT[m] = it; for (int it2_ = 0; it2_ < 5000; it2_++) { for (int i = 0; i < dim; i++) { cplx s = 0; for (int j = 0; j < dim; j++) s += TD[(size_t)j * dim + i] * um[j]; w[i] = s; }
            double nw = 0; for (int i = 0; i < dim; i++) nw += cabs(w[i]) * cabs(w[i]); nw = sqrt(nw); if (nw == 0) break; double dd = 0, dd2 = 0; for (int i = 0; i < dim; i++) { cplx nu = w[i] / nw; dd += cabs(nu - um[i]) * cabs(nu - um[i]); dd2 += cabs(nu + um[i]) * cabs(nu + um[i]); um[i] = nu; } if (dd2 < dd) dd = dd2; if (sqrt(dd) < 1e-13) break; }
          cplx ray = 0, nrm = 0; for (int i = 0; i < dim; i++) { cplx s = 0; for (int j = 0; j < dim; j++) s += TD[(size_t)i * dim + j] * vm[j]; ray += conj(vm[i]) * s; nrm += conj(vm[i]) * vm[i]; } ray /= nrm; LL[m] = creal(ray);
          cplx uv_ = 0; for (int i = 0; i < dim; i++) uv_ += um[i] * vm[i];
          cplx ca = 0, cp = 0, na = 0, np_ = 0; for (int i = 0; i < dim; i++) { ca += um[i] * sa[i]; cp += um[i] * sp[i]; na += conj(sa[i]) * sa[i]; np_ += conj(sp[i]) * sp[i]; }
          printf("  MODE %2d lambda = %.12e (%+.1ei; %d steps) lambda_1/lambda = %.6f; weight in the sweep's cut state %.3e, in the source-p cut state %.3e\n", m + 1, LL[m], cimag(ray), it, LL[0] / LL[m], cabs(ca / uv_) / sqrt(cabs(na)), (NSRC >= 1) ? cabs(cp / uv_) / sqrt(cabs(np_)) : 0.0);
          for (int i = 0; i < dim; i++) for (int j = 0; j < dim; j++) TD[(size_t)i * dim + j] -= ray * vm[i] * um[j] / uv_; }
        free(TD); free(VV); free(UU); free(sa); free(sp); }
      if (dim <= 1000 && getenv("CEI_TRANSFER_OUT")) { FILE *f = fopen(getenv("CEI_TRANSFER_OUT"), "w"); if (f) { fprintf(f, "# T %d x %d (row-major; re im), the cut after step %d, the cell's links steps %d..%d, WMAX %d beta %g datum %s\n", dim, dim, iA, iA + 1, iB, WMAX, BETA, datum);
        for (int i = 0; i < dim; i++) { for (int j = 0; j < dim; j++) fprintf(f, "%.17e %.17e\n", creal(T[(size_t)i * dim + j]), cimag(T[(size_t)i * dim + j])); } fclose(f); printf("  T written to %s\n", getenv("CEI_TRANSFER_OUT")); } }
      free(T); free(v); free(w); free(u); free(x); free_state(&SA); printf("CEI-DONE transfer %.1f s\n", now() - t0); return 0; }
    int ibr = nord;   /* the branch step: the first step at which a source cycle closes (its last link in the order); every closing before it is source-free */
    if (BRANCH && ncfg > 1) for (int k = 0; k < NSRC; k++) { int last = -1; for (int i = 0; i < nord; i++) { if (ELIM[ord[i]]) continue; for (int st = 0; st < NSTEP[SRC[k]]; st++) if (STEPL[SRC[k]][st] == ord[i]) last = i; } if (last >= 0 && last < ibr) ibr = last; }
    if (BRANCH && ncfg > 1) printf("CEI-BRANCH the source cycles first close at step %d of %d: the %d configurations share the sweep to there\n", ibr + 1, nord, ncfg);
    size_t maxstate = 1; int maxopen = 0, nsteps = 0, nslices = 0; int peakopen[128], npeak = 0, peakstep = -1;
    int smax = (CLAMPC >= 0) ? WMAX : 0;
    for (int s = 0; s <= smax; s++) { int dv = (CLAMPC >= 0) ? DIM[s] : 1;
      for (int va = 0; va < dv; va++) for (int vb = 0; vb < dv; vb++) {
        if (CLAMPC >= 0) { CLAMPS = s; FIXV[CLAMPWA] = va; FIXV[CLAMPWB] = vb; }
        state_t SNAP; int snapped = 0;
        for (int cfg = 0; cfg < ncfg; cfg++) { double ts = now();
          for (int c = 0; c < NCYC; c++) for (int q = 0; q <= WMAX; q++) PFAC[c][q] = FAC[q];
          int usep = (NSRC >= 1) && (cfg == 1 || cfg == 3), useq = (NSRC == 2) && (cfg == 2 || cfg == 3);
          if (usep) cei_source(SRC[0]);
          if (useq) cei_source(SRC[1]);
          state_t S; int i0 = 0;
          if (cfg > 0 && snapped) { state_copy(&SNAP, &S); i0 = ibr; }
          else { S.nopen = 0; S.ncyc = 0; S.nblk = 1; S.blk = calloc(1, sizeof(cplx *)); S.size = calloc(1, sizeof(size_t)); S.blk[0] = calloc(1, sizeof(cplx)); S.blk[0][0] = 1; S.size[0] = 1; }
          int nst = 0;
          for (int i = i0; i < nord; i++) { if (ELIM[ord[i]]) continue;
            if (cfg == 0 && BRANCH && ncfg > 1 && i == ibr) { state_copy(&S, &SNAP); snapped = 1; }
            process(&S, ord[i]); nst++; size_t tot = 0; for (int b = 0; b < S.nblk; b++) tot += S.size[b];
            if (tot > maxstate) { maxstate = tot; if (PEAKLIST) { npeak = S.nopen; memcpy(peakopen, S.open, sizeof(int) * S.nopen); peakstep = i; } }
            if (S.ncyc > maxopen) maxopen = S.ncyc;
            if (PROFILE && cfg == 0 && nslices == 0) { int l = ord[i]; printf("CEI-STEP %d link (%d,%d,%d) d%d entries=%zu open-cycles=%d:", i + 1, LB[l][0], LB[l][1], LB[l][2], LD[l], tot, S.ncyc);
              for (int j = 0; j < S.ncyc; j++) { int c = S.cyc[j], kw = 0; for (int w = 0; w < S.nopen; w++) if (WCYC[S.open[w]] == c) kw++; printf(" c%d(%d wires:", c, kw); for (int w = 0; w < S.nopen; w++) if (WCYC[S.open[w]] == c) printf(" w%d", S.open[w]); printf(")"); } printf("\n"); }
            if (tot > CEIL) { fprintf(stderr, "CEI-REFUSED: the state reached %zu entries after link %d (%d cycles open), above the ceiling %zu (W2_CEIL)\n", tot, i + 1, S.ncyc, CEIL); return 3; } }
          if (cfg == 0) nsteps = nst;
          if (S.nopen != 0 || S.ncyc != 0 || S.nblk != 1 || !S.blk[0]) { fprintf(stderr, "CEI: the sweep ended with %d open wires and %d open cycles\n", S.nopen, S.ncyc); return 1; }
          cplx z = S.blk[0][0]; if (CLAMPC >= 0 && NWIRE[CLAMPC] == 2) z *= PFAC[CLAMPC][CLAMPS];   /* the all-fixed cycle's closing weight, once per slice */
          ZZ[cfg] += creal(z); ZI[cfg] += cimag(z); free_state(&S); tcfg[cfg] += now() - ts; }
        if (snapped) free_state(&SNAP); nslices++; } }
    if (CLAMPC >= 0) { CLAMPS = -1; FIXV[CLAMPWA] = -1; FIXV[CLAMPWB] = -1; }
    for (int cfg = 0; cfg < ncfg; cfg++) printf("CEI-Z src=%s Z = %.17e (imag %.1e; %d links swept; max state %zu; open cycles at most %d; %d slice(s); %.1f s)\n", nm[cfg], ZZ[cfg], ZI[cfg], nsteps, maxstate, maxopen, nslices, tcfg[cfg]);
    if (PEAKLIST) { printf("CEI-PEAK after link %d of the order, %d open wires:", peakstep + 1, npeak); for (int w = 0; w < npeak; w++) printf(" w%d(cycle %d)", peakopen[w], WCYC[peakopen[w]]); printf("\n"); }
    if (NSRC >= 1) printf("CEI-SRC p=%d <1/2 tr U_p> = %.15e\n", SRC[0], ZZ[1] / (2 * ZZ[0]));
    if (NSRC == 2) { double ep = ZZ[1] / (2 * ZZ[0]), eq = ZZ[2] / (2 * ZZ[0]), epq = ZZ[3] / (4 * ZZ[0]);
      printf("CEI-SRC q=%d <1/2 tr U_q> = %.15e; <1/2 tr U_p 1/2 tr U_q> = %.15e; CONNECTED = %.15e\n", SRC[1], eq, epq, epq - ep * eq); }
    printf("CEI-DONE beta=%g WMAX=%d datum=%s mode=%d %.1f s\n", BETA, WMAX, datum, CEI, now() - t0); return 0; }
