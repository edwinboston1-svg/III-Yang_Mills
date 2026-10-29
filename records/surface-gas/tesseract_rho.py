# tesseract_rho.py -- the weight of the full plaquette set of the 4-cube [0,1]^4 at spin 1 (24 plaquettes, 32 links,
# every link in exactly three plaquettes), exactly:  int prod_{q} chi_1(U_q) dU.
# At a link of multiplicity three the Haar integral is the rank-one projector  eps_{X1X2X3} eps_{Y1Y2Y3} / 6  (the row
# indices at the link's tail, the column indices at its head, the three plaquettes in one fixed order on both), so
# the whole integral FACTORISES over the sixteen vertices:  6^{-32} * prod_v t_v,  t_v the closed eps-network at v
# (four eps's -- one per link at v -- contracted along the six plaquette corners at v: the tetrahedral net).
import itertools
def eps(a, b, c):
    return (a - b) * (b - c) * (c - a) // 2 * (1 if (a, b, c) in ((0,1,2),(1,2,0),(2,0,1)) else (-1 if (a,b,c) in ((0,2,1),(2,1,0),(1,0,2)) else 0)) if len({a,b,c}) == 3 else 0
# simpler and safe:
def eps(a, b, c):
    s = {(0,1,2): 1, (1,2,0): 1, (2,0,1): 1, (0,2,1): -1, (2,1,0): -1, (1,0,2): -1}
    return s.get((a, b, c), 0)
verts = list(itertools.product((0, 1), repeat=4))
def add(v, d):
    w = list(v); w[d] += 1; return tuple(w)
links = [(v, d) for v in verts for d in range(4) if v[d] == 0]                      # 32: tail v, head v + e_d
plaqs = [(v, d1, d2) for v in verts for d1 in range(4) for d2 in range(d1+1, 4) if v[d1] == 0 and v[d2] == 0]   # 24
assert len(links) == 32 and len(plaqs) == 24
def plaq_links(q):
    v, d1, d2 = q
    return [(v, d1), (add(v, d1), d2), (add(v, d2), d1), (v, d2)]        # the four links of the square (as undirected links)
# the three plaquettes of each link, in a fixed order (the order is the same on the row and the column eps)
lp = {l: sorted(q for q in plaqs if l in plaq_links(q)) for l in links}
assert all(len(x) == 3 for x in lp.values())
def links_at(c):
    out = []
    for d in range(4):
        if c[d] == 0: out.append(((c, d), 'tail'))
        else:
            w = list(c); w[d] -= 1; out.append(((tuple(w), d), 'head'))
    return out
total_sign = 1; total_mag = 1
for c in verts:
    L = links_at(c)                                   # four links at c with the port (tail: row eps, head: column eps)
    # the plaquettes at c: pairs of directions; the corner joins the two links of that plaquette at c
    corners = []
    for d1 in range(4):
        for d2 in range(d1+1, 4):
            v = list(c); v[d1] = 0; v[d2] = 0; q = (tuple(v), d1, d2)
            l1 = L[d1][0]; l2 = L[d2][0]
            corners.append((q, (d1, lp[l1].index(q)), (d2, lp[l2].index(q))))   # (plaquette, leg of link d1, leg of link d2)
    assert len(corners) == 6
    # t_c = sum over the six corner values of prod over the four links of eps(its three legs)
    t = 0
    for vals in itertools.product(range(3), repeat=6):
        legs = [[None]*3 for _ in range(4)]
        for (q, (da, ia), (db, ib)), x in zip(corners, vals):
            legs[da][ia] = x; legs[db][ib] = x
        term = 1
        for d in range(4):
            term *= eps(*legs[d])
            if term == 0: break
        t += term
    print("vertex", c, "t_v =", t)
    total_sign *= (1 if t > 0 else -1); total_mag *= abs(t)
print("prod_v t_v = %s%d ; integral = prod / 6^32 = %s 6^-16 (= %.4e) ; rho = (6^-16)^(1/24) = 6^(-2/3) = %.4f"
      % ("+" if total_sign > 0 else "-", total_mag, "+" if total_sign > 0 else "-", total_mag/6**32, 6**(-2/3)))
