import sys, io
# dump_lines.py FILE LINENO [LINENO ...] -> writes each line split into sentences (at '. ' / '; ' boundaries kept) to stdout, utf-8
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', newline='\n')
path = sys.argv[1]
with open(path, encoding='utf-8', newline='') as h:
    lines = h.read().split('\n')
for a in sys.argv[2:]:
    n = int(a)
    s = lines[n - 1]
    print('===== %s line %d (%d chars) =====' % (path.split('/')[-1], n, len(s)))
    parts, cur = [], ''
    i = 0
    while i < len(s):
        cur += s[i]
        if s[i] in '.;:' and i + 1 < len(s) and s[i + 1] == ' ':
            parts.append(cur)
            cur = ''
        i += 1
    if cur:
        parts.append(cur)
    for k, p in enumerate(parts):
        print('[%02d] %s' % (k, p))
    print()
