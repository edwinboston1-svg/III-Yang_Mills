#!/usr/bin/env python3
"""even_stars_table.py -- THE EVEN STARS, the table (S1 §27; the trunk seat, 2026-11-01 03:xx EST): every orbit of even
subgraphs of K_{2,2,2,2} under B4, its exact spin-½ star integral S_½ (even_stars.py), the excess e_v = sqrt(S_½ / 2^{2−d}),
the largest sheet-vertex count m_max over the vertex's resolutions, and THE BUDGET RATIO rho = e_v / 2^{m_max − 1}: a star
with rho ≤ 1 can be paid by the resolution's vertex splitting in Theorem V's bound (the pinch reads e = 2, m = 2, rho = 1
exactly); a star with rho > 1 cannot be paid locally (K_{2,2,2}: e = 15.2, m_max = 4, rho = 1.9).  Orbits are found by
their group images (one orbit at a time), the output is line-buffered so a partial table is readable, every line carries
its seconds.  usage: python even_stars_table.py <out>
"""
import sys, time, math
from fractions import Fraction
import even_stars as ES

def main(out):
    evens = ES.all_even()
    seen = set(); orbits = {}
    for m in evens:
        if m in seen:
            continue
        orb = {ES.act(m, ep) for ep in ES.GP}
        seen |= orb; orbits[min(orb)] = len(orb)
    assert sum(orbits.values()) == len(evens), (sum(orbits.values()), len(evens))
    reps = sorted(orbits.keys(), key=lambda m: (bin(m).count("1"), m))
    best = (Fraction(0), None); worst_rho = (0.0, None); tame = 0
    with open(out, "w", buffering=1, encoding="utf-8") as f:
        f.write(f"# even_stars_table.py: {len(evens)} even subgraphs of K_2,2,2,2, {len(reps)} orbits under B4 (order 384); "
                f"columns: mask |E| degrees N S e2 e m_max matchings orbit rho secs\n")
        for n, m in enumerate(reps):
            t0 = time.time()
            S, N, mmax, nm, d, E = ES.S_half(m)
            dv = E
            e2 = S / Fraction(1, 2 ** (dv - 2)) if dv >= 2 else Fraction(1)
            e = math.sqrt(e2)
            rho = e / (2 ** (mmax - 1)) if mmax >= 1 else e
            if rho <= 1.0 + 1e-12: tame += 1
            if e2 > best[0]: best = (e2, m)
            if rho > worst_rho[0]: worst_rho = (rho, m)
            f.write(f"mask={m:024b} E={E} deg={''.join(str(x) for x in d)} N={N} S={S} e2={e2} e={e:.6f} mmax={mmax} "
                    f"matchings={nm} orbit={orbits[m]} rho={rho:.6f} secs={time.time() - t0:.1f}\n")
        f.write(f"# orbits={len(reps)} tame(rho<=1)={tame} max_e2={best[0]} (e={math.sqrt(best[0]):.6f}) at mask {best[1]:024b}; "
                f"max_rho={worst_rho[0]:.6f} at mask {worst_rho[1]:024b}\n")
    print(f"{len(evens)} even subgraphs, {len(reps)} orbits -> {out}; tame {tame}; max e2 {best[0]} (e = {math.sqrt(best[0]):.6f}); max rho {worst_rho[0]:.6f}")

if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "even_stars.table.txt")
