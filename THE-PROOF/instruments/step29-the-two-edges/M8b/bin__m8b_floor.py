"""M8b THE CHESSBOARD LARGE-FIELD FLOOR, CERTIFIED ON A GRID (mpmath interval arithmetic, 40 digits).

On each grid cell [b_i, b_{i+1}] (step 0.25 on [4, 60]):  C(beta) <= Cbar_i := U1(b_i) - L0_t(b_{i+1}),
  U1(beta) = 3 ln c(beta) is DECREASING in beta (c(t) = 2 e^{-t} I_1(t)/t = int e^{-t(1 - cos theta)} dHaar decreases), and for a FIXED
  trial parameter t the trial value L0_t(beta) = 3 ln c(t) + 3 t (1 - r(t)) - 3 beta (2 - r(t)^2 - r(t)^4) is DECREASING in beta
  (r = I_2/I_1 in (0, 1)); so on the cell U1(beta) <= U1(b_i) and L0(beta) >= L0_t(beta) >= L0_t(b_{i+1}) (t = 5.8 b_i, any t is valid).
The activity bound of Lemma CB-0 on the cell: ln z_0 <= -(sqrt(b_i s) - sqrt(Cbar_i))^2 when sqrt(b_i s) > sqrt(Cbar_i).
FLOOR(a, z*) := the least grid point b_i such that every cell from b_i to 60 satisfies (sqrt(b_i s) - sqrt(Cbar_i))^2 >= ln(1/z*).
Barriers s(a): Wilson's 1 - cos a (the fine-scale collective event; the constant-field configuration attains it, kappa = 1) and, for
comparison, the Manton/perfect-action shape a^2/2 (the coarse-scale collective event's tree-level barrier, Lemma CB-k, NAMED).
Run: python -u -E -P bin/m8b_floor.py > rec/floor.<date>.txt
"""
from mpmath import iv, mp, mpf
iv.dps = 40
mp.dps = 40


def besselI(nu, x):
    half = x / 2
    term = half ** nu / iv.factorial(nu)
    s = term
    k = 0
    while True:
        k += 1
        term = term * half ** 2 / (k * (k + nu))
        s = s + term
        ratio = half ** 2 / ((k + 1) * (k + 1 + nu))
        if k > 10 and ratio.b < 0.5:
            tail = term * ratio / (1 - ratio)
            if tail.b < mpf(10) ** (-35) * s.a:
                return s + iv.mpf([0, tail.b])


def c_of(t):
    return 2 * iv.exp(-t) * besselI(1, t) / t


def L0t(beta, t):
    r = besselI(2, t) / besselI(1, t)
    return 3 * iv.log(c_of(t)) + 3 * t * (1 - r) - 3 * beta * (2 - r ** 2 - r ** 4)


grid = [iv.mpf(4) + iv.mpf(k) / 4 for k in range(0, 225)]      # 4 .. 60
Cbar = []
for i in range(len(grid) - 1):
    bi, bj = grid[i], grid[i + 1]
    U1 = 3 * iv.log(c_of(bi))
    t = iv.mpf('5.8') * bi
    Cbar.append(iv.mpf((U1 - L0t(bj, t)).b))
print("C-bar on the cells (every 10th cell shown): " + "  ".join("[%s,%s]: %s" % (mp.nstr(mpf(grid[i].a), 4), mp.nstr(mpf(grid[i + 1].a), 4),
                                                                                   mp.nstr(mpf(Cbar[i].b), 6)) for i in range(0, len(Cbar), 10)))
print("max C-bar over [4, 60]: %s" % mp.nstr(max(mpf(c.b) for c in Cbar), 8))
zc20 = iv.mpf(19) ** 19 / iv.mpf(20) ** 20
zperc = 1 / (19 * iv.e)
zKP = iv.mpf('0.006488429773')
PR = (('z_perc = 1/(19e)', zperc), ('Shearer z_c(20)', zc20), ('Kotecky-Preiss z_KP', zKP))


def floor(s):
    out = []
    for name, z in PR:
        target = iv.log(1 / z).b
        ok = [False] * len(Cbar)
        for i in range(len(Cbar)):
            x = iv.sqrt(grid[i] * s) - iv.sqrt(Cbar[i])
            ok[i] = (x.a > 0) and ((x ** 2).a >= target)
        f = None
        for i in range(len(Cbar) - 1, -1, -1):
            if ok[i]:
                f = grid[i]
            else:
                break
        out.append(None if (f is None or not ok[-1]) else mpf(f.a))
    return out


print("FLOORS beta_LF(a) (the least grid point from which the activity bound is <= z* on every cell to 60; '>60' = none):")
print("  barrier       | a (rad) | s(a)     | z_perc | Shearer | KP")
for lab, sfun in (("Wilson 1-cos a", lambda a: 1 - iv.cos(a)), ("Manton a^2/2  ", lambda a: a ** 2 / 2)):
    for a in ('0.5', '1.0', '1.5707963267948966', '2.0', '2.4', '3.14159'):
        A = iv.mpf(a)
        s = sfun(A)
        fl = floor(s)
        print("  %s | %7s | %8s | %6s | %7s | %s" % (lab, a[:7], mp.nstr(mpf(s.a), 6), *[("%.2f" % x) if x is not None else ">60" for x in fl]))
