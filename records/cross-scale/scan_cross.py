# scan_cross.py -- second, wider sweep for cross-scale coupling comparisons in an extracted journal text.
# The OCR layer destroys most formulas (subscripts, primes), so this sweep keys on what survives:
# equation CITATIONS of the master inequalities and the running law, and the PROSE around them.
# Usage: python -P scan_cross.py text.txt first_journal_page
import re, sys
sys.stdout.reconfigure(encoding="utf-8")
txt = open(sys.argv[1], encoding="utf-8").read()
first = int(sys.argv[2])
pages = re.split(r"\n===== page (\d+) =====\n", txt)
pats = [
    ("cite26",  r"\(2\.[6-9]\)"),                                   # CMP 119's master inequalities (2.6)-(2.9)
    ("cite0",   r"\(0\.(1[89]|2[0-9]|3[0-3])\)|I\.0\.3"),           # CMP 109's running law and profile
    ("ineq",    r"inequalit"),
    ("coupl",   r"coupling"),
    ("beta",    r"β-function|functions β|\^-function|beta.function"),
    ("asym",    r"asymptotic|logarithm|log\s*g"),
    ("nm",      r"n\s*-\s*m|k\s*-\s*j|j\s*-\s*N|N\s*0\b|N0"),
]
for i in range(1, len(pages), 2):
    pno = int(pages[i]); body = pages[i + 1]
    out = []
    for ln in body.split("\n"):
        tags = [k for k, p in pats if re.search(p, ln, flags=re.I)]
        if tags and (("cite26" in tags) or ("cite0" in tags) or ("beta" in tags) or ("nm" in tags)
                     or ("coupl" in tags) or (("ineq" in tags) and ("asym" in tags))):
            out.append("   [%s] %s" % (",".join(tags), ln.strip()[:140]))
    if out:
        print("journal p.%d (pdf %d): %d lines" % (first + pno - 1, pno, len(out)))
        for o in out[:14]:
            print(o)
