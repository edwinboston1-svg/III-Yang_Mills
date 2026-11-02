import sys, re
sys.stdout.reconfigure(encoding='utf-8')
src = sys.argv[1]
seen = {}
r = re.compile(r'^=== (\d{4}-\d\d-\d\dT\d\d)')
with open(src, encoding='utf-8', errors='replace') as f:
    for i, ln in enumerate(f, 1):
        m = r.match(ln)
        if m and m.group(1) not in seen:
            seen[m.group(1)] = i
for k in sorted(seen): print(k, seen[k])
