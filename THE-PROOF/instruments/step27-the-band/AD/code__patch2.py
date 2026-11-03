src = open('gauss.py', encoding='utf-8').read()
a = src.index("def chat_alias(n, LC, M2):")
b = src.index("def chat_fine(n, LC, M2):")
new = '''def chat_alias(n, LC, M2):
    """Chat(K) on the LC^4 coarse momenta for the coarse variable n^-3 * block sum: Chat = n^-4 sum_m n^-6 prod_r D_n(k_r)/(phat^2 + M2),
    k = (K + 2 pi m)/n; vectorised over (m2, m3) with a Python loop over (m0, m1)"""
    K1 = 2 * np.pi * np.arange(LC) / LC
    kk = (K1[None, :] + 2 * np.pi * np.arange(n)[:, None]) / n          # (n, LC): k for alias m and coarse K
    Dm = np.stack([Dn(kk[m], n) for m in range(n)])                     # (n, LC)
    Sm = 4 * np.sin(kk / 2) ** 2                                         # (n, LC)
    C = np.zeros((LC,) * 4)
    D23 = Dm[:, None, None, :, None] * Dm[None, :, None, None, :]        # (m2, m3, 1, K2, K3) -> reshaped below
    D23 = (Dm[:, None, :, None] * Dm[None, :, None, :])                  # (m2, m3, K2, K3)
    S23 = (Sm[:, None, :, None] + Sm[None, :, None, :])                  # (m2, m3, K2, K3)
    for m0 in range(n):
        for m1 in range(n):
            num01 = Dm[m0][:, None] * Dm[m1][None, :]                      # (K0, K1)
            s01 = Sm[m0][:, None] + Sm[m1][None, :]                        # (K0, K1)
            den = s01[None, None, :, :, None, None] + S23[:, :, None, None, :, :] + M2
            num = num01[None, None, :, :, None, None] * D23[:, :, None, None, :, :]
            with np.errstate(divide='ignore', invalid='ignore'):
                t = num / den
            C += t.sum(axis=(0, 1))
    C /= float(n) ** 10   # Chat = n^-4 sum_m n^-6 prod D_n/(phat^2 + M2) (the exact torus identity; blockfree.c omits n^-4: rows unaffected)
    return C

'''
src = src[:a] + new + src[b:]
open('gauss.py', 'w', encoding='utf-8').write(src)
print('ok')
