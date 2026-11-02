import sys, re
sys.stdout.reconfigure(encoding='utf-8')
src, maxlen, lo, hi = sys.argv[1], int(sys.argv[2]), sys.argv[3], sys.argv[4]
txt = open(src, encoding='utf-8', errors='replace').read()
parts = re.split(r'(?m)^(=== \d{4}-\d\d-\d\dT[^\n]*)\n', txt)
for i in range(1, len(parts) - 1, 2):
    head, body = parts[i], parts[i + 1].strip()
    ts = head[4:28]
    if not (lo <= ts < hi): continue
    if len(body) > maxlen: continue
    if body.startswith('[Cross-session idle notice]') or body.startswith('<agent-message'): continue
    print(head); print(body); print()
