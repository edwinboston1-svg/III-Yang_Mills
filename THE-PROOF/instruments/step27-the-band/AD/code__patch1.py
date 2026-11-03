import re
src = open('gauss.py', encoding='utf-8').read()
# (1) alias normalisation: Chat = n^-4 sum_m n^-6 prod D_n/(phat^2+M2) (the exact torus identity; blockfree's lacks the n^-4, rows unaffected)
src = src.replace("    C /= float(n) ** 4 * float(n) ** 6 / float(n) ** 4   # blockfree normalisation: sum_m S/(n^6 (phat^2 + M2)); n^-4 of the fold absorbed\n",
                  "    C /= float(n) ** 10   # Chat = n^-4 sum_m n^-6 prod D_n/(phat^2 + M2) (the exact torus identity; blockfree.c omits n^-4: rows unaffected)\n")
# (2) road 2 memory: broadcast sums instead of four meshgrids
src = src.replace("""    k = 2 * np.pi * np.arange(N) / N
    k0, k1, k2, k3 = np.meshgrid(k, k, k, k, indexing='ij')
    ph2 = 4 * (np.sin(k0 / 2) ** 2 + np.sin(k1 / 2) ** 2 + np.sin(k2 / 2) ** 2 + np.sin(k3 / 2) ** 2) + M2
    del k0, k1, k2, k3
""", """    k = 2 * np.pi * np.arange(N) / N
    s = 4 * np.sin(k / 2) ** 2
    ph2 = s[:, None, None, None] + s[None, :, None, None] + s[None, None, :, None] + s[None, None, None, :] + M2
""")
# (3) vectorised pseudo-inverse in photon_coords
old = src[src.index("    Hk = np.zeros((LC,) * 4 + (4, 4), dtype=complex)"):src.index("    # gauge check: w^H H = 0")]
new = """    Wf = W.reshape(-1, 4); Cf = Cv.reshape(-1, 4)
    nw = np.einsum('ki,ki->k', Wf.conj(), Wf).real
    nz = nw > 1e-14
    Pt = np.zeros((Wf.shape[0], 4, 4), dtype=complex)
    Pt[nz] = np.eye(4)[None] - np.einsum('ki,kj->kij', Wf[nz], Wf[nz].conj()) / nw[nz, None, None]
    Cm = np.einsum('kij,kj,kjl->kil', Pt, Cf, Pt)
    ev, U = np.linalg.eigh(Cm)
    emax = ev.max(axis=1, keepdims=True)
    inv = np.where(ev > 1e-12 * np.maximum(emax, 1e-300), 1.0 / np.where(ev > 0, ev, 1.0), 0.0)
    Hf = np.einsum('kia,ka,kja->kij', U, inv, U.conj())
    Hf[~nz] = 0.0
    Hk = Hf.reshape((LC,) * 4 + (4, 4))
"""
src = src.replace(old, new)
src = src.replace("    it = np.ndindex(LC, LC, LC, LC)\n", "")
open('gauss.py', 'w', encoding='utf-8').write(src)
print('patched', 'n^10' in src, 'einsum' in src)
