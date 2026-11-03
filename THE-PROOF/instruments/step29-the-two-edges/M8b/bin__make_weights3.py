"""Write bin/m8b_weights3.py: m8b_weights.py with the torus replaced by the L = 3 CENTRED (Balaban) block slice on (6,3,3,3)."""
import os
here = os.path.dirname(os.path.abspath(__file__))
src = open(os.path.join(here, 'm8b_weights.py'), encoding='utf-8').read()
a = src.index('# ---------------------------------------------------------------- the torus and the slice')
b = src.index('Qm = np.array(Qrows)')
new = '''# ---------------------------------------------------------------- the torus and the slice: L = 3 CENTRED blocks (Balaban's), (6,3,3,3)
LB = 3
ext = np.array([6, 3, 3, 3])
sites = [np.array(s) for s in itertools.product(*[range(e) for e in ext])]
sidx = {tuple(s): i for i, s in enumerate(sites)}
nS = len(sites)


def lid(s, mu):
    return 4 * sidx[tuple(np.mod(s, ext))] + mu


nLk = 4 * nS
nV = 3 * nLk
E = np.eye(4, dtype=int)
plaqs = []
for s in sites:
    for mu in range(4):
        for nu in range(mu + 1, 4):
            plaqs.append((lid(s, mu), lid(s + E[mu], nu), lid(s + E[nu], mu), lid(s, nu)))
plaqs = np.array(plaqs)


def iscoarse(s):
    return all(s % LB == 0)


coarse = [s for s in sites if iscoarse(s)]
Gcols = []
for s in sites:
    if iscoarse(s):
        continue
    for a in range(3):
        v = np.zeros(nV)
        for mu in range(4):
            v[3 * lid(s, mu) + a] -= 1.0
            v[3 * lid(s - E[mu], mu) + a] += 1.0
        Gcols.append(v)
G = np.array(Gcols).T
BSET = [np.array(n) for n in itertools.product(range(-(LB - 1) // 2, (LB - 1) // 2 + 1), repeat=4)]
Qrows = []
for y in coarse:
    for mu in range(4):
        row = np.zeros(nLk)
        for n in BSET:
            for j in range(LB):
                row[lid(y + n + j * E[mu], mu)] += 1.0
            nz = [nu for nu in range(4) if n[nu] != 0]
            perms = list(itertools.permutations(nz))
            for start, sign in ((y, 1.0), (y + LB * E[mu], -1.0)):
                for perm in perms:
                    z = start.copy()
                    for nu in perm:
                        for _ in range(abs(int(n[nu]))):
                            if n[nu] > 0:
                                row[lid(z, nu)] += sign / len(perms)
                                z = z + E[nu]
                            else:
                                z = z - E[nu]
                                row[lid(z, nu)] -= sign / len(perms)
        row /= float(LB ** 4)
        for a in range(3):
            r = np.zeros(nV); r[a::3] = row
            Qrows.append(r)
'''
src = src[:a] + new + src[b:]
src = src.replace('M8b CONVEXITY UNDER THREE PLAQUETTE WEIGHTS', 'M8b CONVEXITY UNDER THREE PLAQUETTE WEIGHTS, L = 3 CENTRED (6,3,3,3) VERSION')
src = src.replace("(Wilson's free gamma0 on this torus 1.849564; hk scales it by 1 - 1/(3 beta); HAAR adds 2/(3 beta))",
                  "(L = 3 centred: Fourier gamma0 = 1 at the face k = (pi/3,0,0,0), present on this torus)")
open(os.path.join(here, 'm8b_weights3.py'), 'w', encoding='utf-8').write(src)
print('wrote m8b_weights3.py')
