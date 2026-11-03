# debug of the three-scale lam_max > 1 (M3g S2): check positivity of G^{-1} and the inverse
import numpy as np, sys
sys.path.insert(0, __import__('os').path.dirname(__file__))
from toy2d import build
N = 32
inner = lambda x, y, lo, hi: lo <= x < hi and lo <= y < hi
blocks = []
for x0 in range(8, 24, 4):
    for y0 in range(8, 24, 4): blocks.append((x0, y0, 4))
for x0 in range(4, 28, 2):
    for y0 in range(4, 28, 2):
        if not inner(x0, y0, 8, 24): blocks.append((x0, y0, 2))
for x0 in range(0, 32):
    for y0 in range(0, 32):
        if not inner(x0, y0, 4, 28): blocks.append((x0, y0, 1))
o = build(N, blocks)
Q, Ginv, R = o['Q'], o['Ginv'], o['R']
evG = np.linalg.eigvalsh(Ginv)
print("Ginv eig min/max:", evG[0], evG[-1])
evR = np.linalg.eigvalsh(R)
print("R eig min/max:", evR[0], evR[-1])
G = np.linalg.inv(Ginv)
print("|Ginv G - I| =", np.abs(Ginv @ G - np.eye(len(G))).max())
That = Q @ G @ Q.T
w = np.linalg.eigvalsh((That + That.T) / 2)
print("That eig max:", w[-1], " QQ^T eig max:", np.linalg.eigvalsh(Q @ Q.T)[-1])
# direct check of the variational bound on the top eigenvector
v = np.linalg.eigh((That + That.T) / 2)[1][:, -1]
A = G @ Q.T @ v
print("2<QA,h>-<A,Ginv A> =", 2 * (Q @ A) @ v - A @ Ginv @ A, " |h|^2/a =", v @ v, " a|QA|^2 =", (Q @ A) @ (Q @ A),
      " <A,X A> =", A @ (Ginv - Q.T @ Q) @ A)
X = Ginv - Q.T @ Q
print("X eig min:", np.linalg.eigvalsh(X)[0])
