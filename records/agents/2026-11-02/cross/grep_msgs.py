import sys, re
sys.stdout.reconfigure(encoding='utf-8')
# grep_msgs.py -- in an operator/xsession file of '=== <ts> <kind>' messages, print each message that matches the regex
# (case-insensitive), whole, up to maxlen chars; or with -l list only headers + length + first 160 chars.
# usage: python -I grep_msgs.py <file> <regex> [maxlen|-l] [lo] [hi]
src, rx = sys.argv[1], re.compile(sys.argv[2], re.I)
mode = sys.argv[3] if len(sys.argv) > 3 else '20000'
lo = sys.argv[4] if len(sys.argv) > 4 else ''
hi = sys.argv[5] if len(sys.argv) > 5 else '9999'
txt = open(src, encoding='utf-8', errors='replace').read()
parts = re.split(r'(?m)^(=== \d{4}-\d\d-\d\dT[^\n]*)\n', txt)
n = 0
for i in range(1, len(parts) - 1, 2):
    head, body = parts[i], parts[i + 1]
    ts = head[4:28]
    if not (lo <= ts < hi): continue
    if not rx.search(body): continue
    n += 1
    if mode == '-l':
        print(head, '| len', len(body), '|', body.strip()[:160].replace('\n', ' '))
    else:
        ml = int(mode)
        print(head)
        print(body.strip()[:ml] + (' [...cut at %d of %d]' % (ml, len(body)) if len(body) > ml else ''))
        print()
print('## matched', n)
