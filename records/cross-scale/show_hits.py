# show_hits.py -- print the lines (with one line of context each side) that match the first sweep's patterns,
# for chosen journal pages.  Usage: python -P show_hits.py text.txt first_journal_page p1 p2 ...
import re, sys
sys.stdout.reconfigure(encoding="utf-8")
txt = open(sys.argv[1], encoding="utf-8").read()
first = int(sys.argv[2])
want = set(int(s) for s in sys.argv[3:])
pages = re.split(r"\n===== page (\d+) =====\n", txt)
pats = {
    "seq":     r"sequence|monoton|decreas|increas",
    "thresh":  r"p\s*[0o0]\s*\(|p\s*\(\s*[gq9]|p\s*1\s*\(|ε\s*\(|e\s*\(\s*[gq9]",
    "beta0":   r"β\s*[0o]|\(1\s*\+\s*β|l\s*\+\s*β",
    "prof":    r"\(0\.3[0-9]\)|\(0\.2[0-9]\)",
    "gcmp":    r"g\s*[jkJK]\s*[-+]\s*1|g\s*[jk]\s*[<>≦≧≤≥]|[<>≦≧≤≥]\s*g\s*[jk]",
    "coupl":   r"coupling",
}
for i in range(1, len(pages), 2):
    pno = int(pages[i]); jp = first + pno - 1
    if jp not in want:
        continue
    lines = pages[i + 1].split("\n")
    print("==== journal p.%d" % jp)
    for n, ln in enumerate(lines):
        tags = [k for k, p in pats.items() if re.search(p, ln, flags=re.I)]
        if tags:
            ctx = " | ".join(x.strip() for x in lines[max(0, n - 1): n + 2])
            print("  [%s] %s" % (",".join(tags), ctx[:230]))
