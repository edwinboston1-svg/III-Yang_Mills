# s8_local.py -- the local vertex factors of Lemma S8 (the crossing law), by the one-dimensional-invariant
# contraction.  Every T-link carries the strands (1/2 forward, 1/2 backward, 1 wall); its Haar integral is the
# rank-one projector |iota><iota| on Inv(1/2 x 1/2* x 1) (numerator) or |iota0><iota0| on Inv(1/2 x 1/2*)
# (denominator).  The integral over all of T is then a product over vertices of local contractions c(v), and
# r = prod_v c_num(v)/c_den(v).  Here c is computed for every chord diagram of m walls through one vertex
# (m = 1..4), the walls' two links at v in cyclic order, the first oriented into v and the second out of v,
# the curves passing each corner (e_s, e_{s+1}) from e_s toward v to e_{s+1} away from v (the counterclockwise
# convention; the clockwise one is the complex conjugate).  Known answers: m = 1 -> 1; touching (aabb) -> 1;
# crossing (abab) -> -1/3 (the global integrals in s8_kat.py).
import numpy as np, itertools
# the link projector by exact quadrature (degree <= 4 trigonometric polynomials: 24 points suffice)
def su2(a, b, c):
    ca, sa = np.cos(a/2), np.sin(a/2); cb, sb = np.cos(b/2), np.sin(b/2); cc, sc = np.cos(c/2), np.sin(c/2)
    ea, ec = ca + 1j*sa, cc + 1j*sc
    m = np.empty(a.shape + (2, 2), dtype=complex)
    m[..., 0, 0] = ea*cb*ec;            m[..., 0, 1] = ea*sb*np.conj(ec)
    m[..., 1, 0] = -np.conj(ea)*sb*ec;  m[..., 1, 1] = np.conj(ea)*cb*np.conj(ec)
    return m
def spin1(U):
    # the adjoint (real orthogonal) representation: R_{ij} = (1/2) tr(s_i U s_j U^-1)
    s = [np.array([[0, 1], [1, 0]], complex), np.array([[0, -1j], [1j, 0]]), np.array([[1, 0], [0, -1]], complex)]
    Ui = np.conj(np.swapaxes(U, -1, -2))
    R = np.empty(U.shape[:-2] + (3, 3))
    for i in range(3):
        for j in range(3):
            R[..., i, j] = np.real(0.5*np.trace(np.matmul(np.matmul(s[i][None], U), np.matmul(s[j][None], Ui)), axis1=-2, axis2=-1))
    return R
n = 24
x, w = np.polynomial.legendre.leggauss(n); b = np.arccos(x)
a = 2*np.pi*(np.arange(n) + 0.5)/n; c = a.copy()
A, B, C = np.meshgrid(a, b, c, indexing='ij'); W = (np.broadcast_to(w[None, :, None], A.shape)*(2*np.pi/n)**2/(8*np.pi**2)).ravel()
U = su2(A.ravel(), B.ravel(), C.ravel()); R = spin1(U)
# P[a,a',b,b',c,c'] = int D_{aa'} conj(D_{bb'}) R_{cc'};  P0[a,a',b,b'] = int D_{aa'} conj(D_{bb'})
P = np.einsum('n,nx,ny,nz->xyz', W, U.reshape(-1, 4), np.conj(U).reshape(-1, 4), R.reshape(-1, 9)).reshape(2, 2, 2, 2, 3, 3)
P0 = np.einsum('n,nx,ny->xy', W, U.reshape(-1, 4), np.conj(U).reshape(-1, 4)).reshape(2, 2, 2, 2)
# rank-one factorisation: P[a,a',b,b',c,c'] = iota[a,b,c] conj(iota[a',b',c'])  (indices: start, end)
M = np.transpose(P, (0, 2, 4, 1, 3, 5)).reshape(12, 12); vals, vecs = np.linalg.eigh(M)
assert abs(vals[-1] - 1) < 1e-9 and abs(vals[-2]) < 1e-9, vals[-3:]
iota = vecs[:, -1].reshape(2, 2, 3)
M0 = np.transpose(P0, (0, 2, 1, 3)).reshape(4, 4); vals0, vecs0 = np.linalg.eigh(M0)
assert abs(vals0[-1] - 1) < 1e-9 and abs(vals0[-2]) < 1e-9, vals0
iota0 = vecs0[:, -1].reshape(2, 2)
print("link projectors: rank one, eigenvalue 1 (numerator and denominator); iota = sigma_c/sqrt6 up to phase:",
      np.allclose(abs(iota)**2, np.array([[[0,0,.5],[.5,.5,0]],[[.5,.5,0],[0,0,.5]]])/3))
def local_factor(word, conj_convention=False):
    # word: a cyclic sequence of wall labels, each label exactly twice; link s is the s-th position
    L = len(word); first = {}
    orient = []            # +1 = out of v (start at v, tensor iota), -1 = into v (end at v, tensor conj(iota))
    for s, lab in enumerate(word):
        if lab not in first: first[lab] = s; orient.append(-1)
        else: orient.append(+1)
    # index bookkeeping: for link s, strand ends at v: a_s (forward curve), b_s (backward curve), c_s (wall)
    # einsum over 3L indices: build a list of operands and subscripts
    import string
    letters = string.ascii_letters
    idx = {}; k = 0
    for s in range(L):
        for t in 'abc':
            idx[(s, t)] = letters[k]; k += 1
    ops, subs = [], []
    for s in range(L):
        T = iota if orient[s] == +1 else np.conj(iota)
        ops.append(T); subs.append(idx[(s, 'a')] + idx[(s, 'b')] + idx[(s, 'c')])
    # corners: curve enters along e_s toward v and leaves along e_{s+1} away from v
    #   toward v on e: forward strand (a) if e is oriented into v (-1), else backward (b)
    #   away from v on e: forward strand (a) if oriented out of v (+1), else backward (b)
    delta2 = np.eye(2); delta3 = np.eye(3)
    for s in range(L):
        s1 = (s + 1) % L
        i_to = idx[(s, 'a')] if orient[s] == -1 else idx[(s, 'b')]
        i_from = idx[(s1, 'a')] if orient[s1] == +1 else idx[(s1, 'b')]
        if conj_convention:   # clockwise: enter along e_{s+1}, leave along e_s
            i_to = idx[(s1, 'a')] if orient[s1] == -1 else idx[(s1, 'b')]
            i_from = idx[(s, 'a')] if orient[s] == +1 else idx[(s, 'b')]
        ops.append(delta2); subs.append(i_to + i_from)
    # walls: the 1-strand continues from the incoming link to the outgoing link of the same wall
    for lab, s0 in first.items():
        s1 = [s for s in range(L) if word[s] == lab and s != s0][0]
        ops.append(delta3); subs.append(idx[(s0, 'c')] + idx[(s1, 'c')])
    num = np.einsum(','.join(subs) + '->', *ops)
    # denominator: iota0 in place of iota, no wall strands
    ops0, subs0 = [], []
    for s in range(L):
        T = iota0 if orient[s] == +1 else np.conj(iota0)
        ops0.append(T); subs0.append(idx[(s, 'a')] + idx[(s, 'b')])
    for s in range(L):
        s1 = (s + 1) % L
        i_to = idx[(s, 'a')] if orient[s] == -1 else idx[(s, 'b')]
        i_from = idx[(s1, 'a')] if orient[s1] == +1 else idx[(s1, 'b')]
        if conj_convention:
            i_to = idx[(s1, 'a')] if orient[s1] == -1 else idx[(s1, 'b')]
            i_from = idx[(s, 'a')] if orient[s] == +1 else idx[(s, 'b')]
        ops0.append(delta2); subs0.append(i_to + i_from)
    den = np.einsum(','.join(subs0) + '->', *ops0)
    return num, den
def chord_diagrams(m):
    # all words with labels 0..m-1 each twice, canonical under rotation and reflection and relabelling
    seen = set(); out = []
    for perm in itertools.permutations(range(2*m)):
        pass
    # simpler: generate all words, canonicalise
    from itertools import product
    labels = list(range(m))
    def canon(word):
        L = len(word); best = None
        for rot in range(L):
            for refl in (False, True):
                w2 = word[rot:] + word[:rot]
                if refl: w2 = w2[::-1]
                # relabel by first occurrence
                mp = {}; w3 = []
                for ch in w2:
                    if ch not in mp: mp[ch] = len(mp)
                    w3.append(mp[ch])
                t = tuple(w3)
                if best is None or t < best: best = t
        return best
    for word in product(labels, repeat=2*m):
        if all(word.count(l) == 2 for l in labels):
            cw = canon(list(word))
            if cw not in seen: seen.add(cw); out.append(cw)
    return out
def crossings(word):
    m = len(word)//2; cnt = 0
    pos = {l: [s for s in range(len(word)) if word[s] == l] for l in set(word)}
    for l1 in pos:
        for l2 in pos:
            if l1 < l2:
                p, q = pos[l1], pos[l2]
                # l1 and l2 cross iff exactly one of l2's positions lies strictly between l1's positions
                between = sum(1 for s in q if p[0] < s < p[1])
                cnt += (between == 1)
    return cnt
names = {0: 'a', 1: 'b', 2: 'c', 3: 'd'}
for m in (1, 2, 3, 4):
    for word in chord_diagrams(m):
        num, den = local_factor(list(word))
        r = num/den
        print("m = %d  pattern %-8s crossings %d : c_num = %+.6f%+.6fi  c_den = %.6f  r = %+.6f" % (
            m, ''.join(names[x] for x in word), crossings(word), num.real, num.imag, den.real, (r).real),
            "" if abs(r.imag) < 1e-9 else "  (imag %.3e)" % r.imag)
