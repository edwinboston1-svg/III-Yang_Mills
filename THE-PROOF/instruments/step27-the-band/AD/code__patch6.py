src = open('gauss_pipe.py', encoding='utf-8').read()
old = src[src.index("def write_stats(fn, n, M2, r, LC=16):"):src.index("def pair_rho(h, t, ng=64):")]
new = '''def write_stats(fn, n, M2, r, LC=16):
    Ch = chat_alias(n, LC, M2)
    if M2 == 0: Ch[0, 0, 0, 0] = 0.0                 # the zero mode removed (the constant field); the Lagrange constraint restores it
    keys, cl = classes(r)
    nf = len(keys)
    # class indicators on the torus (class 0 = the site itself) and M_ab = sum_{Y1 in a, Y2 in b} C(Y1 - Y2) = V^-1 sum_K Chat conj(Ia) Ib
    ind = np.zeros((nf, LC, LC, LC, LC))
    ind[0, 0, 0, 0, 0] = 1.0
    for i, k in enumerate(keys[1:], start=1):
        for Y in cl[k]: ind[(i,) + tuple(c % LC for c in Y)] += 1.0
    F = np.fft.fftn(ind, axes=(1, 2, 3, 4)).reshape(nf, -1)
    M = (np.conj(F) * Ch.ravel()[None, :]) @ F.T / LC ** 4
    M = M.real
    bvec = np.zeros(nf); bvec[0] = -1.0
    with open(fn, 'wb') as h:
        h.write(struct.pack('8i', 1, n * LC, 1, nf, 1, nf, 2, 0)); h.write(struct.pack('i', n)); h.write(struct.pack('d', M2))
        for rep in range(2):                         # two identical 'configurations' so that the jackknife runs (zero error)
            h.write(struct.pack('d', 0.0)); h.write(struct.pack('2d', 0.0, 0.0))
            h.write(M.astype(np.float64).tobytes()); h.write(bvec.astype(np.float64).tobytes()); h.write(np.zeros(nf).tobytes())
            h.write(struct.pack('2q', 1, 0))
    return keys, cl

'''
src = src.replace(old, new)
open('gauss_pipe.py', 'w', encoding='utf-8').write(src)
print('ok')
