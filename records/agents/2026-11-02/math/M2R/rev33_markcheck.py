# -*- coding: utf-8 -*-
"""rev33_markcheck.py -- check the inserted JS text of rev33_l2.py against lib.js's inline markup rules: italic toggles balanced in
every template literal and every footnote, every ^{ and _{ closed before any nested brace, no bare ^ or _ that would print literally,
no ** (bold), and every footnote bracket matched. Usage: python rev33_markcheck.py <path to rev33_l2.py>"""
import re
import sys

src = open(sys.argv[1], encoding="utf-8").read()
block = src.split('BLOCK = r"""', 1)[1].split('"""', 1)[0]
lits = re.findall(r"`([^`]*)`", block)
bad = 0
for k, s in enumerate(lits):
    # split off footnotes (no nesting is used in this text)
    fns = re.findall(r"\[\[fn:(.*?)\]\]", s)
    body = re.sub(r"\[\[fn:.*?\]\]", "", s)
    for name, t in [("text", body)] + [("footnote", f) for f in fns]:
        if t.count("*") % 2:
            print("UNBALANCED ITALIC in %s of literal %d: %s..." % (name, k, t[:90])); bad += 1
        if "**" in t:
            print("BOLD MARKER in %s of literal %d" % (name, k)); bad += 1
        for m in re.finditer(r"[\^_]\{", t):
            j = t.find("}", m.end())
            inner = t[m.end():j]
            if j < 0 or "{" in inner:
                print("NESTED OR OPEN SCRIPT in %s of literal %d at ...%s..." % (name, k, t[max(0, m.start() - 20):m.start() + 30])); bad += 1
        for m in re.finditer(r"[\^_](?!\{)", t):
            print("BARE %r in %s of literal %d at ...%s..." % (m.group(0), name, k, t[max(0, m.start() - 20):m.start() + 20])); bad += 1
    if s.count("[[") != s.count("]]"):
        print("FOOTNOTE BRACKETS UNMATCHED in literal %d" % k); bad += 1
print("rev33_markcheck: %d template literals, %d footnotes, %d defects" % (len(lits), sum(len(re.findall(r"\[\[fn:", s)) for s in lits), bad))
sys.exit(1 if bad else 0)
