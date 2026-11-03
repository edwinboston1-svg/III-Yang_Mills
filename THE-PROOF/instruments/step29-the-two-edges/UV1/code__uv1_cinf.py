"""UV1: the TRUE gap C at beta -> infinity (Gaussian), and the deficits of the bounds (READINGS, mpmath quad at 30 digits).

G_d := int d^dk/(2pi)^d ln(sum_i 4 sin^2(k_i/2)) = int_0^inf [e^{-t} - (e^{-2t} I_0(2t))^d] dt/t   (Frullani).
C_inf^true = (dim G/2) (G_4 - G_2)  (removing one orientation: det' M_0 / det' M_1 = |k|^2/(k_rho^2 + k_sigma^2) per colour);
f_0 ~ 3 ln c(beta) - 3 G_4,  f_1 ~ 3 ln c(beta) - (3/2)(G_4 + G_2)  (axial gauge determinants: 2 G_4 and G_4 + G_2 per colour);
product-trial deficit 4.5 ln 6 - 3 G_4; design-B' deficit (3/2)(G_4 + G_2 - Lambda_D), Lambda_D = 1/2 ln5 + 1/8 ln28 + 1/8 ln9 + 1/4 ln5.
Run: python -u -E -P code/uv1_cinf.py > rec/cinf.<date>.txt
"""
import mpmath as m
from mpmath import mp, mpf

mp.dps = 30


def G(d):
    f = lambda t: (m.exp(-t) - (m.besseli(0, 2 * t) * m.exp(-2 * t)) ** d) / t
    return m.quad(f, [0, 1, 10, 100, 1000, m.inf])


G2 = G(2)
G3 = G(3)
G4 = G(4)
print("G_2 = %s   (4G/pi = %s)" % (m.nstr(G2, 20), m.nstr(4 * m.catalan / m.pi, 20)))
print("G_3 = %s   (3D spanning-tree constant, literature 1.673389...)" % m.nstr(G3, 20))
print("G_4 = %s" % m.nstr(G4, 20))
Cinf = 1.5 * (G4 - G2)
LamD = m.log(5) / 2 + m.log(28) / 8 + m.log(9) / 8 + m.log(5) / 4
print("C_inf^true (SU(2)) = (3/2)(G_4 - G_2) = %s" % m.nstr(Cinf, 15))
print("deficit of the product trial (lower bound): 4.5 ln 6 - 3 G_4 = %s" % m.nstr(4.5 * m.log(6) - 3 * G4, 12))
print("deficit of M8b's U1 (upper bound): (3/2)(G_4 + G_2) = %s" % m.nstr(1.5 * (G4 + G2), 12))
print("Lambda_D (design B') = %s ; deficit of U1(B'): (3/2)(G_4 + G_2 - Lambda_D) = %s" % (m.nstr(LamD, 12), m.nstr(1.5 * (G4 + G2 - LamD), 12)))
print("asymptotic Cbar: M8b 4.5 ln 6 = %s ; B' 4.5 ln 6 - 1.5 Lambda_D = %s" % (m.nstr(4.5 * m.log(6), 12), m.nstr(4.5 * m.log(6) - 1.5 * LamD, 12)))
print("check: C_inf^true + both deficits (B') = %s" % m.nstr(Cinf + 4.5 * m.log(6) - 3 * G4 + 1.5 * (G4 + G2 - LamD), 12))
for name, dimG in (("SU(3)", 8), ("SU(4)", 15), ("G2", 14), ("E8", 248)):
    print("C_inf^true(%s) = (dim G/2)(G_4 - G_2) = %s" % (name, m.nstr(dimG / 2 * (G4 - G2), 10)))
# dense cell: -f_0/6 per plaquette; f_0 ~ 1.5 ln(2/pi) - 4.5 ln beta - 3 G_4
for b in (10, 15, 20, 30, 60):
    f0 = 1.5 * m.log(2 / m.pi) - 4.5 * m.log(b) - 3 * G4
    print("Gaussian -f_0/6 at beta = %d: %s" % (b, m.nstr(-f0 / 6, 8)))
