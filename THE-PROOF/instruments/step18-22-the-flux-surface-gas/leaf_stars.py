#!/usr/bin/env python3
"""leaf_stars.py -- THE EVEN STARS read on the census (S1 §27 E6; the author, 2026-11-01 03:xx EST): every EVEN set of a
G48 listing (the contact leaves, `G48-IRREDUCIBLE F=.. EVEN: ... plaquettes: (x,y,z,w)ab ...`) is read plaquette by
plaquette; at every lattice vertex the leaf's star is formed (the plaquettes at the vertex as edges of K_{2,2,2,2} on the
eight half-axes: a plaquette of plane (a, b) based at p has the corners p, p+e_a, p+e_b, p+e_a+e_b, with the half-axes
(+a, +b), (−a, +b), (+a, −b), (−a, −b) at them); each star's orbit under B4, its exact spin-½ integral, its excess e and its
budget ratio rho (even_stars.py) are tallied; per leaf the maximal rho; the census is read two-sided: a vertex with rho > 1
anywhere refutes the sparsity stake E6, and the orbits that occur are listed with their counts.
usage: python leaf_stars.py <listing> [<listing> ...]
"""
import sys, re, math
from fractions import Fraction
from collections import Counter, defaultdict
import even_stars as ES

PLQ = re.compile(r"\((-?\d+),(-?\d+),(-?\d+),(-?\d+)\)(\d)(\d)")

def star_masks(plaqs):
    """plaqs: list of (x, y, z, w, a, b) with a, b in 1..4 -> dict vertex -> 24-bit star mask"""
    stars = defaultdict(int)
    for (x, y, z, w, a, b) in plaqs:
        a -= 1; b -= 1
        base = [x, y, z, w]
        for sa in (0, 1):
            for sb in (0, 1):
                v = list(base); v[a] += sa; v[b] += sb
                ha = 2 * a + sa            # sign 0 = +, 1 = − : at the far corner the link points back (−)
                hb = 2 * b + sb
                i, j = (ha, hb) if ha < hb else (hb, ha)
                stars[tuple(v)] |= 1 << ES.EIDX[(i, j)]
    return stars

_cache = {}
def star_row(mask):
    c = ES.canon(mask)
    if c not in _cache:
        S, N, mmax, nm, d, E = ES.S_half(c)
        e2 = S / Fraction(1, 2 ** (E - 2)) if E >= 2 else Fraction(1)
        e = math.sqrt(e2); rho = e / (2 ** (mmax - 1))
        _cache[c] = (S, e2, e, mmax, rho, E, "".join(str(t) for t in d))
    return c, _cache[c]

def main(files):
    for fn in files:
        nsets = 0; orbit_count = Counter(); worst = (0.0, None, None); refuted = 0; maxdeg = 0
        with open(fn, encoding="utf-8", errors="replace") as f:
            for line in f:
                if not line.startswith("G48-IRREDUCIBLE") or " EVEN:" not in line:
                    continue
                m = re.search(r"plaquettes:(.*)$", line)
                if not m: continue
                plaqs = [tuple(int(t) for t in g) for g in PLQ.findall(m.group(1))]
                if not plaqs: continue
                nsets += 1
                stars = star_masks(plaqs)
                leaf_worst = 0.0
                for v, mask in stars.items():
                    c, (S, e2, e, mmax, rho, E, deg) = star_row(mask)
                    orbit_count[c] += 1
                    maxdeg = max(maxdeg, max(int(t) for t in deg))
                    if rho > leaf_worst: leaf_worst = rho
                    if rho > 1.0 + 1e-12:
                        refuted += 1
                        if rho > worst[0]: worst = (rho, c, nsets)
                if leaf_worst > worst[0] and refuted == 0: pass
        print(f"LEAF-STARS {fn}: EVEN sets {nsets}; distinct star orbits {len(orbit_count)}; max half-axis degree {maxdeg}; "
              f"vertices with rho > 1: {refuted}" + (f" (worst rho {worst[0]:.6f} at orbit {worst[1]:024b}, set {worst[2]})" if refuted else " -- E6 HELD on this listing"))
        for c, n in sorted(orbit_count.items(), key=lambda kv: -kv[1]):
            S, e2, e, mmax, rho, E, deg = _cache[c]
            print(f"  orbit mask={c:024b} E={E} deg={deg} S={S} e={e:.6f} mmax={mmax} rho={rho:.6f} vertices={n}")

if __name__ == "__main__":
    main(sys.argv[1:])
