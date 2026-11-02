# -*- coding: utf-8 -*-
"""Count every repair's old string in the BLOCK of M2R/rev33_l2.py (read only) and in rev33_test/content4.js; each must
occur exactly once in both, so the repairs apply to the real edit target. Usage: python check_block.py <rev33_l2.py> <content4.js>"""
import sys
import apply_repairs as ar

l2 = open(sys.argv[1], encoding="utf-8").read().replace("\r\n", "\n")
block = l2.split('BLOCK = r"""', 1)[1].split('"""', 1)[0]
c4 = open(sys.argv[2], encoding="utf-8").read().replace("\r\n", "\n")
bad = 0
for tag, lst in (("REQUIRED", ar.REQUIRED), ("OPTIONAL", ar.OPTIONAL)):
    for k, (old, new) in enumerate(lst):
        nb = block.count(old)
        nc = c4.count(old)
        ok = (nb == 1 and nc == 1)
        bad += (not ok)
        print("%s %2d  block=%d content4=%d  %s" % (tag, k, nb, nc, "ok" if ok else "MISMATCH"))
print("block in content4 verbatim:", block.strip("\n") in c4)
print("check_block: %d mismatches" % bad)
