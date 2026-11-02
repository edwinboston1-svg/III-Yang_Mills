# Locate the largest two-road difference of instrument B (SU(3)); report absolute and relative differences per coefficient.
import sys, os; sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import coeffs as C
betas = [0.001, 0.01, 0.1, 0.5, 1.0, 2.0, 5.0, 10.0, 20.0]
kat, r1 = C.su3_road1(betas)
for b, c in zip(betas, r1):
    worst = max(C.PART, key=lambda k: abs(c[k]-C.su3_road2(C.PART[k], b))/abs(C.su3_road2(C.PART[k], b)))
    c2 = C.su3_road2(C.PART[worst], b)
    print(f"beta {b:6.3f}: worst {worst:>3}: road1 {c[worst]:.15e} road2 {c2:.15e} abs {abs(c[worst]-c2):.2e} rel {abs(c[worst]-c2)/abs(c2):.2e} (c0 = {c['1']:.6e})")
