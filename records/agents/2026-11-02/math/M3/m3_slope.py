"""Identify the path-variance slope: alpha = 4 sum_m G4(m e1) = 4 G3(0) (Watson), and fit Var_path = alpha n - beta ln n + gamma."""
import numpy as np
from scipy.special import ive
from scipy.integrate import quad
def tint(fun, T=18.0):
    g = lambda u: fun(np.exp(u))*np.exp(u)
    s=0.0
    for a,b in zip([-40,-10,-5,-2,0,2,4,6,8,10,12,14,16],[-10,-5,-2,0,2,4,6,8,10,12,14,16,T]):
        s+=quad(g,a,b,limit=400,epsabs=1e-15,epsrel=1e-13)[0]
    return s
G3 = tint(lambda t: ive(0,2*t)**3)            # 3D lattice Green function at 0; tail ~ int (4 pi t)^{-3/2} dt -> 2/( (4pi)^{3/2} sqrt(T))
tail3 = 2.0/((4*np.pi)**1.5*np.sqrt(np.exp(18.0)))
print(f"G3(0) = {G3:.12f} + tail {tail3:.3e} = {G3+tail3:.12f}  (Watson 0.252731009858...)")
print(f"alpha = 4 G3(0) = {4*(G3+tail3):.10f}")
data = [(16,15.115398),(24,23.120733),(32,31.149865),(48,47.242512),(64,63.359009),(96,95.626421),(128,127.917696)]
n = np.array([d[0] for d in data],float); v=np.array([d[1] for d in data])
A = np.vstack([n, -np.log(n), np.ones_like(n)]).T
coef,res,rk,sv = np.linalg.lstsq(A,v,rcond=None)
print("fit Var_path/g2 = alpha n - beta ln n + gamma:", coef, "max resid", np.max(np.abs(A@coef-v)))
