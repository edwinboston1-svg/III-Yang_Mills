import sys, re
# usage: python ctx.py WIDTH PATTERN FILE...   (PATTERN is a literal string; prints every occurrence with WIDTH chars each side)
w = int(sys.argv[1]); pat = sys.argv[2]
for f in sys.argv[3:]:
    with open(f, encoding='utf-8') as h:
        lines = h.read().split('\n')
    for i, line in enumerate(lines):
        start = 0
        while True:
            k = line.find(pat, start)
            if k < 0: break
            a = max(0, k - w); b = min(len(line), k + len(pat) + w)
            print('%s:%d:%d: ...%s...' % (f.split('/')[-1], i + 1, k, line[a:b]))
            print()
            start = k + len(pat)
