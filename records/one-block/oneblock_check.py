import itertools, numpy as np
from fractions import Fraction
from math import cos, exp, sin, pi, log
# the 2^4 block: vertices {0,1}^4, edges (v,mu) with v_mu=0, plaquettes (v,mu<nu) with v_mu=v_nu=0
V=list(itertools.product([0,1],repeat=4))
E=[(v,m) for v in V for m in range(4) if v[m]==0]; ei={e:i for i,e in enumerate(E)}
def sh(v,m): w=list(v); w[m]+=1; return tuple(w)
Pq=[(v,m,n) for v in V for m in range(4) for n in range(m+1,4) if v[m]==0 and v[n]==0]
F=np.zeros((len(Pq),len(E)),dtype=np.int64)
for r,(v,m,n) in enumerate(Pq):
    F[r,ei[(v,m)]]+=1; F[r,ei[(sh(v,m),n)]]+=1; F[r,ei[(sh(v,n),m)]]-=1; F[r,ei[(v,n)]]-=1
H=F.T@F+3*np.eye(32,dtype=np.int64)
I=np.eye(32,dtype=np.int64)
ann=(H-3*I)@(H-7*I)@(H-9*I)@(H-11*I)
tr=[int(np.trace(np.linalg.matrix_power(H,k))) for k in (1,2,3)]
# multiplicities from the four traces (k=0..3) with eigenvalues 3,7,9,11
A=np.array([[1,1,1,1],[3,7,9,11],[9,49,81,121],[27,343,729,1331]],dtype=float); b=np.array([32]+tr,dtype=float)
m=np.linalg.solve(A,b)
# external plaquettes: plaquettes of Z^4 containing >=1 block edge, not in the block
ext=set()
for (v,mu) in E:
    for nu in range(4):
        if nu==mu: continue
        for s in (-1,):   # the plaquette offset outward in -nu (the +nu one is the block's own since v_nu=0)
            w=list(v); w[nu]+=s; ext.add((tuple(w),min(mu,nu),max(mu,nu)))
        # also +nu side when v_nu==1? v_nu=0 or 1: if v_nu==1 the +nu plaquette is external
        if v[nu]==1:
            ext.add((tuple(v),min(mu,nu),max(mu,nu)))
print("block: V",len(V),"E",len(E),"P",len(Pq),"| annihilated:",int(np.abs(ann).max())==0,"| tr H,H2,H3:",tr,"| multiplicities 3,7,9,11:",np.round(m,9).tolist(),"| external plaquettes:",len(ext))
# the one-plaquette marginal mu1(beta,th*) = int_{th*}^pi e^{b cos} sin^2 / int_0^pi, vs e^{-b(1-cos th*)}
def mu1(b,t,n=400000):
    xs=np.linspace(0,pi,n+1); w=np.exp(b*(np.cos(xs)-1))*np.sin(xs)**2
    tot=np.trapz(w,xs); k=np.searchsorted(xs,t); tail=np.trapz(w[k:],xs[k:])
    return tail/tot
for b,t in ((9587,0.025),(150,0.2237),(20,0.7383)):
    r=mu1(b,t); e=exp(-b*(1-cos(t))); print(f"beta={b} th*={t}: mu1={r:.4f} bound={e:.4f} ratio={r/e:.2f} 20*mu1={20*r:.2f} 54.4*mu1={54.4*r:.2f}")
print("Peierls threshold ln20/(1-cos0.025) =",log(20)/(1-cos(0.025)))
