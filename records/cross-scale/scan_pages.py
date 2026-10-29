# scan_pages.py -- report, per journal page, the hits of a set of regexes in an extracted text.
# Usage: python -P scan_pages.py text.txt first_journal_page
import re, sys
txt = open(sys.argv[1], encoding="utf-8").read()
first = int(sys.argv[2])
pages = re.split(r"\n===== page (\d+) =====\n", txt)
# pages = ['', '1', text1, '2', text2, ...]
pats = {
    "coupl":   r"coupling",
    "seq":     r"sequence|monoton|decreas|increas",
    "thresh":  r"p\s*[0o0]\s*\(|p\s*\(\s*[gq9]|p\s*1\s*\(|ε\s*\(|e\s*\(\s*[gq9]",
    "beta0":   r"β\s*[0o]|\(1\s*\+\s*β|l\s*\+\s*β",
    "prof":    r"\(0\.3[0-9]\)|\(0\.2[0-9]\)",
    "gcmp":    r"g\s*[jkJK]\s*[-+]\s*1|g\s*[jk]\s*[<>≦≧≤≥]|[<>≦≧≤≥]\s*g\s*[jk]",
    "sumscal": r"Σ\s*[jk]\s*=|sum over scales|over all scales|j\s*=\s*0\s*,\s*1|k\s*=\s*0\s*,\s*1",
}
for i in range(1, len(pages), 2):
    pno = int(pages[i]); body = pages[i + 1]
    hits = {k: len(re.findall(p, body, flags=re.I)) for k, p in pats.items()}
    tot = sum(hits.values())
    if tot:
        tags = " ".join("%s:%d" % (k, v) for k, v in hits.items() if v)
        print("journal p.%d (pdf %d): %s" % (first + pno - 1, pno, tags))
