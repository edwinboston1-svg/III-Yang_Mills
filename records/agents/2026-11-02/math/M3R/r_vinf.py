"""M3R check 3: the continuum limit v_inf of the block-averaged variable (Prop. 6.2(ii)), computed directly, and the
Gaussian expectation of 1/2 Tr exp(i Phi.sigma/2) that the record's AF-sequence column claims to print.

v_inf = 2 int d^4q/(2pi)^4 |prod_nu phi(q_nu)|^2 |1 - e^{i q_2}|^2 / |q|^2,  phi(q) = (e^{iq}-1)/(iq).
Heat kernel: 1/|q|^2 = int_0^inf e^{-t|q|^2} dt, and int dq/(2pi) |phi(q)|^2 e^{iqx} e^{-tq^2} = (Lambda * p_t)(x),
Lambda(u) = (1-|u|)_+, p_t(u) = (4 pi t)^{-1/2} e^{-u^2/(4t)}.  With R(u) = u_+ and sigma = sqrt(2t),
(R * p_t)(y) = psi(y) = y Phi(y/sigma) + sigma phi(y/sigma), Lambda = R(.+1) - 2R(.) + R(.-1), so
A(t) = (Lambda*p_t)(0) = psi(1) - 2 psi(0) + psi(-1),  C(t) = (Lambda*p_t)(1) = psi(2) - 2 psi(1) + psi(0),
v_inf = 2 int_0^inf A(t)^3 * 2 (A(t) - C(t)) dt.
"""
import sys
sys.path.append(r"C:\Users\Edwin Boston\AppData\Roaming\Python\Python314\site-packages")
import mpmath as mp

mp.mp.dps = 40


def psi(y, s):
    return y * mp.ncdf(y / s) + s * mp.npdf(y / s)


def integrand(t):
    s = mp.sqrt(2 * t)
    A = psi(1, s) - 2 * psi(0, s) + psi(-1, s)
    C = psi(2, s) - 2 * psi(1, s) + psi(0, s)
    return 2 * A ** 3 * 2 * (A - C)


pts = [mp.mpf(0)] + [mp.mpf(10) ** k for k in range(-6, 9)]
head = mp.quad(integrand, pts)
Tend = pts[-1]
# tail: integrand ~ K t^{-3}; K read off at two large t to confirm the power
K1 = integrand(Tend) * Tend ** 3
K2 = integrand(Tend / 10) * (Tend / 10) ** 3
tail = K1 / (2 * Tend ** 2)
vinf = head + tail
print("v_inf head =", mp.nstr(head, 20), " tail K t^-3 with K =", mp.nstr(K1, 12), "(at T/10:", mp.nstr(K2, 12), ") tail =", mp.nstr(tail, 5))
print("v_inf      =", mp.nstr(vinf, 15))
rec = {64: mp.mpf("0.18661644"), 96: mp.mpf("0.18654471"), 128: mp.mpf("0.18651959")}
for n, v in rec.items():
    print(f"  record n={n}: {v}   n*(v - v_inf) = {mp.nstr(n * (v - vinf), 8)}")
# fit v(n) = v_inf + a/n + b/n^2 on the three record rows (v_inf free) to see whether the record extrapolates to it
M = mp.matrix([[1, mp.mpf(1) / n, mp.mpf(1) / n ** 2] for n in rec])
y = mp.matrix([rec[n] for n in rec])
sol = mp.lu_solve(M, y)
print("  3-point fit of the record: v_inf =", mp.nstr(sol[0], 10), " a =", mp.nstr(sol[1], 8), " b =", mp.nstr(sol[2], 8))

# the Gaussian expectation of 1/2 Tr exp(i Phi.sigma/2) = cos(|Phi|/2), Phi ~ N(0, v I_3): exact (1 - v/4) e^{-v/8}
for v in (mp.mpf("88.17984"), mp.mpf("28.74138")):
    exact = (1 - v / 4) * mp.exp(-v / 8)
    # numerical check by the radial (Maxwell) density
    num = mp.quad(lambda r: 4 * mp.pi * r ** 2 * (2 * mp.pi * v) ** (-1.5) * mp.exp(-r ** 2 / (2 * v)) * mp.cos(r / 2), [0, mp.sqrt(v), 4 * mp.sqrt(v), 20 * mp.sqrt(v)])
    print(f"  v = {v}: E cos(|Phi|/2) = (1-v/4)e^(-v/8) = {mp.nstr(exact, 8)}  (quadrature {mp.nstr(num, 8)});  record column exp(-3v/8) = {mp.nstr(mp.exp(-3 * v / 8), 6)}")
