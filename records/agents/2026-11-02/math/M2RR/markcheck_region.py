# -*- coding: utf-8 -*-
"""M2R's rev33_markcheck rules applied to the revision-33 region of a content4.js (from the revision-33 comment line to the
paragraph 'Theorem 8.5′ and the statements it rests on' inclusive): italic toggles balanced in every template literal and
footnote, no bold marker, every ^{ / _{ closed before a nested brace, no bare ^ or _, footnote brackets matched.
Usage: python markcheck_region.py <content4.js>"""
import re
import sys

s = open(sys.argv[1], encoding="utf-8").read().replace("\r\n", "\n")
i0 = s.index("// ---------------------------------------------------------------- the reduction in L² (revision 33)")
i1 = s.index("Theorem 8.5′ and the statements it rests on cost two conditions")
i1 = s.index("\n", i1)
block = s[i0:i1]
lits = re.findall(r"`([^`]*)`", block)
bad = 0
for k, t0 in enumerate(lits):
    fns = re.findall(r"\[\[fn:(.*?)\]\]", t0)
    body = re.sub(r"\[\[fn:.*?\]\]", "", t0)
    for name, t in [("text", body)] + [("footnote", f) for f in fns]:
        if t.count("*") % 2:
            print("UNBALANCED ITALIC in %s of literal %d" % (name, k)); bad += 1
        if "**" in t:
            print("BOLD MARKER in %s of literal %d" % (name, k)); bad += 1
        for m in re.finditer(r"[\^_]\{", t):
            j = t.find("}", m.end())
            if j < 0 or "{" in t[m.end():j]:
                print("NESTED OR OPEN SCRIPT in %s of literal %d" % (name, k)); bad += 1
        for m in re.finditer(r"[\^_](?!\{)", t):
            print("BARE %r in %s of literal %d" % (m.group(0), name, k)); bad += 1
    if t0.count("[[") != t0.count("]]"):
        print("FOOTNOTE BRACKETS UNMATCHED in literal %d" % k); bad += 1
    for bad_seq in ("${", "\\"):
        if bad_seq in t0:
            print("FORBIDDEN %r in literal %d" % (bad_seq, k)); bad += 1
print("markcheck_region: %d template literals, %d defects" % (len(lits), bad))
sys.exit(1 if bad else 0)
