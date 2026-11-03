# cei_eig.awk -- the eigen-decomposition of the exterior's correction C = P_OO - S (22 x 22, symmetric, positive semidefinite) by Jacobi
# rotations, from cei_dtn's output (DTN-S and DTN-P rows): the eigenvalues with their cumulative share, and with -v VEC=1 the eigenvectors
# (EIGVEC m lambda_m v_1 .. v_22, the links in cei_dtn's DTN-KEFF order) for the cubature of the Gaussian exterior (cei_cub.awk)
/^  DTN-S/ { n++; for (c = 1; c <= 22; c++) S[n, c] = $(c + 1) + 0 }
/^  DTN-P/ { m++; for (c = 1; c <= 22; c++) P[m, c] = $(c + 1) + 0 }
END { for (i = 1; i <= 22; i++) for (j = 1; j <= 22; j++) { A[i, j] = P[i, j] - S[i, j]; V[i, j] = (i == j) }
  for (sweep = 0; sweep < 100; sweep++) { off = 0; for (i = 1; i <= 22; i++) for (j = i + 1; j <= 22; j++) off += A[i, j] * A[i, j]; if (off < 1e-26) break
    for (p = 1; p <= 22; p++) for (q = p + 1; q <= 22; q++) { if (A[p, q] == 0) continue; th = (A[q, q] - A[p, p]) / (2 * A[p, q]); t = (th >= 0 ? 1 : -1) / ((th < 0 ? -th : th) + sqrt(th * th + 1)); c = 1 / sqrt(t * t + 1); s = t * c
      for (k = 1; k <= 22; k++) { akp = A[k, p]; akq = A[k, q]; A[k, p] = c * akp - s * akq; A[k, q] = s * akp + c * akq }
      for (k = 1; k <= 22; k++) { apk = A[p, k]; aqk = A[q, k]; A[p, k] = c * apk - s * aqk; A[q, k] = s * apk + c * aqk }
      for (k = 1; k <= 22; k++) { vkp = V[k, p]; vkq = V[k, q]; V[k, p] = c * vkp - s * vkq; V[k, q] = s * vkp + c * vkq } } }
  for (i = 1; i <= 22; i++) { EV[i] = A[i, i]; ORD[i] = i } tot = 0; for (i = 1; i <= 22; i++) tot += EV[i]
  for (i = 1; i <= 22; i++) for (j = i + 1; j <= 22; j++) if (EV[ORD[j]] > EV[ORD[i]]) { t1 = ORD[i]; ORD[i] = ORD[j]; ORD[j] = t1 }
  # the reconstruction check: C = V diag(EV) V^T
  rmax = 0; for (i = 1; i <= 22; i++) for (j = 1; j <= 22; j++) { r = 0; for (k = 1; k <= 22; k++) r += V[i, k] * EV[k] * V[j, k]; d = r - (P[i, j] - S[i, j]); if (d < 0) d = -d; if (d > rmax) rmax = d }
  printf "CEI-EIG: the correction C = P_OO - S, %d Jacobi sweeps, trace %.6f, reconstruction max |V D V^T - C| = %.1e; eigenvalues (descending) and cumulative share:\n", sweep, tot, rmax
  cum = 0; for (i = 1; i <= 22; i++) { k = ORD[i]; cum += EV[k]; printf "  lambda_%02d = %+.6f  share %.4f  cumulative %.4f\n", i, EV[k], EV[k] / tot, cum / tot }
  if (VEC) for (i = 1; i <= 22; i++) { k = ORD[i]; printf "EIGVEC %d %.12f", i, EV[k]; for (r = 1; r <= 22; r++) printf " %.12f", V[r, k]; printf "\n" } }
