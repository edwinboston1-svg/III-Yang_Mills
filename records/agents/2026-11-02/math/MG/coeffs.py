# MG instrument B: Wilson character coefficients a_lam(beta) = c_lam / (d_lam c_0), c_lam = int exp((beta/d) Re chi_rho) conj chi_lam,
# for SU(3) (fundamental action) by two roads sharing no line, and for G2 (7-dimensional action) by Weyl integration.
# Double precision: a CHECK of the exact leading-order formulas of WORK.md section 6, not a proof input.
import numpy as np
from scipy.special import iv

# ---------------- SU(3), road 1: Weyl integration on the maximal torus ----------------
def su3_torus(n):
    t = 2*np.pi*np.arange(n)/n
    T1, T2 = np.meshgrid(t, t, indexing='ij')
    th = [T1, T2, -T1-T2]
    z = [np.exp(1j*x) for x in th]
    D = (z[0]-z[1])*(z[0]-z[2])*(z[1]-z[2])
    dens = np.abs(D)**2/6.0/(n*n)          # normalised Haar weight per grid point
    p = lambda k: sum(zz**k for zz in z)
    chi = {}
    chi['1'] = np.ones_like(T1, dtype=complex)
    chi['3'] = p(1)
    chi['3b'] = np.conj(p(1))
    chi['8'] = np.abs(p(1))**2 - 1
    chi['6'] = (p(1)**2 + p(2))/2
    chi['10'] = (p(1)**3 + 3*p(1)*p(2) + 2*p(3))/6
    return dens, chi

def su3_road1(betas, n=192):
    dens, chi = su3_torus(n)
    kat = {'int1': np.sum(dens), 'chi3chi3b': np.sum(dens*np.abs(chi['3'])**2), 'chi3': abs(np.sum(dens*chi['3'])),
           'chi3^3': np.sum(dens*chi['3']**3).real, 'chi8^2': np.sum(dens*chi['8']**2).real,
           'chi6chi6b': np.sum(dens*np.abs(chi['6'])**2), 'chi10chi10b': np.sum(dens*np.abs(chi['10'])**2)}
    out = []
    for b in betas:
        w = np.exp((b/3.0)*chi['3'].real)
        c = {k: np.sum(dens*w*np.conj(v)).real for k, v in chi.items()}
        out.append(c)
    return kat, out

# ---------------- SU(3), road 2: Toeplitz–Bessel determinants ----------------
def su3_road2(lam, beta, qmax=40):
    x = beta/3.0
    s = 0.0
    for q in range(-qmax, qmax+1):
        M = np.array([[iv(lam[j] - (j+1) + (i+1) - q, x) for j in range(3)] for i in range(3)])
        s += np.linalg.det(M)
    return s

PART = {'1': (0, 0, 0), '3': (1, 0, 0), '3b': (1, 1, 0), '8': (2, 1, 0), '6': (2, 0, 0), '10': (3, 0, 0)}
DIM3 = {'1': 1, '3': 3, '3b': 3, '8': 8, '6': 6, '10': 10}

# ---------------- G2: Weyl integration on its maximal torus ----------------
SHORT = [(1, 0), (0, 1), (1, 1)]
LONG = [(2, 1), (-1, 1), (-1, -2)]
POS = SHORT + LONG

def g2_torus(n):
    t = 2*np.pi*np.arange(n)/n
    P1, P2 = np.meshgrid(t, t, indexing='ij')
    ang = lambda m: m[0]*P1 + m[1]*P2
    dens = np.ones_like(P1)
    for a in POS:
        dens = dens*4*np.sin(ang(a)/2)**2
    dens = dens/12.0/(n*n)
    chi7 = 1 + 2*sum(np.cos(ang(a)) for a in SHORT)
    chi14 = 2 + 2*sum(np.cos(ang(a)) for a in POS)
    chi27 = chi7**2 - 1 - chi7 - chi14
    return dens, {'1': np.ones_like(P1), '7': chi7, '14': chi14, '27': chi27}

def g2_run(betas, n=192):
    dens, chi = g2_torus(n)
    kat = {'int1': dens.sum(), 'chi7^2': (dens*chi['7']**2).sum(), 'chi14^2': (dens*chi['14']**2).sum(),
           'chi27^2': (dens*chi['27']**2).sum(), 'chi7chi14': (dens*chi['7']*chi['14']).sum(), 'chi7^3': (dens*chi['7']**3).sum(),
           'chi7': (dens*chi['7']).sum()}
    out = []
    for b in betas:
        w = np.exp((b/7.0)*chi['7'])
        out.append({k: (dens*w*v).sum() for k, v in chi.items()})
    return kat, out

if __name__ == '__main__':
    betas = [0.001, 0.01, 0.1, 0.5, 1.0, 2.0, 3.0, 4.0, 5.0, 5.7, 6.0, 8.0, 10.0, 12.0, 15.0, 20.0]
    kat1, r1 = su3_road1(betas)
    print('== SU(3) road 1 known answers:', {k: round(float(v), 13) for k, v in kat1.items()})
    print('== SU(3): beta | a3 (road1) | a3 (road2) | rel.diff | a8 | a6 | a10 | R3 = a8/(a3 a3b) | max_other/a3')
    maxrel = 0.0
    for b, c in zip(betas, r1):
        c2 = {k: su3_road2(PART[k], b) for k in PART}
        for k in PART:
            maxrel = max(maxrel, abs(c[k]-c2[k])/max(abs(c2[k]), 1e-300))
        a = {k: c2[k]/(DIM3[k]*c2['1']) for k in PART}
        R3 = a['8']/(a['3']*a['3b'])
        mo = max(a['8'], a['6'], a['10'])/a['3']
        print(f"   {b:7.3f} | {c['3']/(3*c['1']):.12e} | {a['3']:.12e} | {abs(c['3']-c2['3'])/c2['3']:.1e} | {a['8']:.6e} | {a['6']:.6e} | {a['10']:.6e} | {R3:.9f} | {mo:.6f}")
    print(f'== SU(3) two roads: max relative difference over all coefficients and couplings = {maxrel:.2e}')
    # the crossing beta1 of R3 = 1, by bisection on road 2
    def R3(b):
        c = {k: su3_road2(PART[k], b) for k in ('1', '3', '3b', '8')}
        return (c['8']/(8*c['1']))/((c['3']/(3*c['1']))*(c['3b']/(3*c['1'])))
    lo, hi = 0.5, 20.0
    if (R3(lo)-1)*(R3(hi)-1) < 0:
        for _ in range(60):
            mid = 0.5*(lo+hi)
            if (R3(mid)-1)*(R3(lo)-1) > 0: lo = mid
            else: hi = mid
        print(f'== SU(3): R3 crosses 1 at beta1 = {0.5*(lo+hi):.9f}')
    else:
        print('== SU(3): R3 does not cross 1 on [0.5, 20]', R3(lo), R3(hi))
    # monotonicity check of R3 on a fine grid
    grid = np.linspace(0.01, 20, 400)
    vals = [R3(b) for b in grid]
    inc = sum(1 for i in range(1, len(vals)) if vals[i] > vals[i-1])
    print(f'== SU(3): R3 on 400 points of [0.01, 20]: max {max(vals):.9f} at beta {grid[int(np.argmax(vals))]:.3f}, min {min(vals):.9f}, increasing steps {inc}')
    kat2, r2 = g2_run(betas)
    print('== G2 known answers:', {k: round(float(v), 13) for k, v in kat2.items()})
    print('== G2: beta | a7 | a14 | a27 | a27/a7^2 | a14/a7^2 | max_other/a7')
    for b, c in zip(betas, r2):
        a = {'7': c['7']/(7*c['1']), '14': c['14']/(14*c['1']), '27': c['27']/(27*c['1'])}
        print(f"   {b:7.3f} | {a['7']:.9e} | {a['14']:.6e} | {a['27']:.6e} | {a['27']/a['7']**2:.9f} | {a['14']/a['7']**2:.9f} | {max(a['14'], a['27'])/a['7']:.6f}")
    # quadrature convergence: n = 192 against n = 256 at beta = 20
    k3, rr = su3_road1([20.0], n=256)
    k4, rg = g2_run([20.0], n=256)
    print(f"== quadrature: SU(3) c8 at beta 20, n=192 vs 256: {r1[-1]['8']:.15e} vs {rr[0]['8']:.15e}; G2 c14: {r2[-1]['14']:.15e} vs {rg[0]['14']:.15e}")
