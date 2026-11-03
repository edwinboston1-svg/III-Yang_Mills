# s8_kat.py -- known answers for Lemma S8 (the crossing law), by deterministic quadrature on SU(2).
# Not a physics reading: an identity check of three Haar integrals of character products.
#   touching:  I_t = int chi_h(z1) chi_h(z2) chi_h(z2 z1) chi_1(z1) chi_1(z2) / int chi_h(z1) chi_h(z2) chi_h(z2 z1)   -> expected 1
#   crossing:  I_c = int chi_h([z1,z2]) chi_1(z1) chi_1(z2) / int chi_h([z1,z2])                                     -> expected -1/3
#   and the two denominators themselves (1/2 and 1/2).
# Haar on SU(2) via Euler angles z = exp(i a s3/2) exp(i b s2/2) exp(i c s3/2), density sin(b) da db dc / (8 pi^2) on a, c in [0, 2 pi) (the SO(3) range; every integrand here is even).
import numpy as np
def su2(a, b, c):
    # returns array of 2x2 matrices for broadcasted angle arrays
    ca, sa = np.cos(a/2), np.sin(a/2); cb, sb = np.cos(b/2), np.sin(b/2); cc, sc = np.cos(c/2), np.sin(c/2)
    ea, ec = ca + 1j*sa, cc + 1j*sc            # exp(i a/2), exp(i c/2)
    # exp(i a s3/2) = diag(ea, conj(ea)); exp(i b s2/2) = [[cb, sb],[-sb, cb]]
    m = np.empty(a.shape + (2, 2), dtype=complex)
    m[..., 0, 0] = ea*cb*ec;            m[..., 0, 1] = ea*sb*np.conj(ec)
    m[..., 1, 0] = -np.conj(ea)*sb*ec;  m[..., 1, 1] = np.conj(ea)*cb*np.conj(ec)
    return m
def chi_h(m): return np.real(np.trace(m, axis1=-2, axis2=-1))
def chi_1(m): return chi_h(m)**2 - 1.0
def grid(n):
    # Gauss-Legendre in cos(b), uniform trapezoid in a, c (periodic): exact for trig polynomials of low degree
    x, w = np.polynomial.legendre.leggauss(n)          # cos b in [-1,1], weight = sin b db
    b = np.arccos(x)
    a = 2*np.pi*(np.arange(n) + 0.5)/n; c = 2*np.pi*(np.arange(n) + 0.5)/n
    A, B, C = np.meshgrid(a, b, c, indexing='ij'); W = np.broadcast_to(w[None, :, None], A.shape)
    return su2(A.ravel(), B.ravel(), C.ravel()), (W.ravel() * (2*np.pi/n)**2 / (8*np.pi**2))
n = 24
Z, W = grid(n)                                            # z1 on the full Haar grid (n^3 points)
# z2 can be reduced to its class angle t by invariance of Haar (conjugation by z1 is absorbed): z2 = diag(e^{it}, e^{-it}),
# Weyl density (2/pi) sin^2 t dt on [0, pi]  -- valid because the integrands are invariant under z2 -> g z2 g^-1 with z1 -> g z1 g^-1.
tt, tw = np.polynomial.legendre.leggauss(60); t = (tt + 1)*np.pi/2; tw = tw*np.pi/2*(2/np.pi)*np.sin(t)**2
num_t = den_t = num_c = den_c = 0.0
Zinv = np.conj(np.swapaxes(Z, -1, -2))
for ti, wi in zip(t, tw):
    z2 = np.array([[np.exp(1j*ti), 0], [0, np.exp(-1j*ti)]]); z2inv = np.conj(z2.T)
    c1 = chi_1(Z); c2 = (2*np.cos(ti))**2 - 1.0; h1 = chi_h(Z); h2 = 2*np.cos(ti)
    prod = chi_h(np.matmul(z2[None], Z))                            # chi_h(z2 z1)
    comm = chi_h(np.matmul(np.matmul(Z, z2[None]), np.matmul(Zinv, z2inv[None])))   # chi_h(z1 z2 z1^-1 z2^-1)
    den_t += wi*np.sum(W*h1*h2*prod);           num_t += wi*np.sum(W*h1*h2*prod*c1*c2)
    den_c += wi*np.sum(W*comm);                 num_c += wi*np.sum(W*comm*c1*c2)
print("touching: den = %.6f (1/2)  num = %.6f (1/2)  ratio = %.6f (expected 1)" % (den_t, num_t, num_t/den_t))
print("crossing: den = %.6f (1/2)  num = %.6f (-1/6)  ratio = %.6f (expected -1/3)" % (den_c, num_c, num_c/den_c))
