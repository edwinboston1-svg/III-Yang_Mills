# -*- coding: utf-8 -*-
"""List every capital L in lines 102-214 of rev33_test/content4.js that is not the L of L^2 and not the first letter of a
word of two or more letters (Lemma, Liu, Lean, ...), with line, column and context, into a UTF-8 file.
Usage: python find_L.py <content4.js> <out>"""
import re
import sys

lines = open(sys.argv[1], encoding="utf-8").read().split("\n")
out = open(sys.argv[2], "w", encoding="utf-8")
count = 0
for n in range(102, 215):
    s = lines[n - 1]
    # the generator appears as: 'L =', 'tL', 'hL', '*L*', 'LG', 'LF', '−*L', in math runs 'hL)'
    for m in re.finditer(r"L", s):
        i = m.start()
        nxt = s[i + 1] if i + 1 < len(s) else ""
        prv = s[i - 1] if i > 0 else ""
        if nxt == "²":
            continue
        word = re.match(r"L[a-zâêéèôüöäí]+", s[i:])
        if word and not (word.group(0) in ("LG", "LF")):
            continue
        if prv == "." or (prv == " " and nxt == "."):
            continue        # initials such as 'L. Saloff-Coste', 'E. L. Wilmer'
        count += 1
        out.write("%d:%d  ...%s...\n" % (n, i, s[max(0, i - 30):i + 25]))
out.write("total %d\n" % count)
out.close()
