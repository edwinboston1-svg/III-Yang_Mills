import sys, re
sys.stdout.reconfigure(encoding='utf-8')
# pb.py -- print blocks of an extract starting at a header line number.
# usage: python -I pb.py <extract> <start_line> [nblocks=1] [maxchars_per_block=25000] [kinds_regex=.] [total_cap=25000]
# kinds_regex filters which headers are printed (e.g. 'ASSISTANT text|USER$|QUEUED|TOOL CALL'); skipped blocks are
# listed by header only, so the sequence stays visible.
src, start = sys.argv[1], int(sys.argv[2])
nb = int(sys.argv[3]) if len(sys.argv) > 3 else 1
mx = int(sys.argv[4]) if len(sys.argv) > 4 else 25000
kre = re.compile(sys.argv[5]) if len(sys.argv) > 5 else re.compile('.')
cap = int(sys.argv[6]) if len(sys.argv) > 6 else 25000
head_re = re.compile(r'^=== (\d{4}-\d\d-\d\dT\S+) (.*)$')
out = 0
blocks = 0
cur = None
buf = []
def flush():
    global out
    if cur is None: return
    body = '\n'.join(buf)
    if kre.search(cur):
        s = cur + '\n' + (body[:mx] + ('\n[... block cut at %d of %d chars]' % (mx, len(body)) if len(body) > mx else ''))
        sys.stdout.write(s + '\n')
        out += len(s)
    else:
        sys.stdout.write('[skipped] ' + cur + ' (%d chars)\n' % len(body))
with open(src, encoding='utf-8', errors='replace') as f:
    for i, ln in enumerate(f, 1):
        if i < start: continue
        ln = ln.rstrip('\n')
        if head_re.match(ln):
            if cur is not None:
                flush()
                blocks += 1
                if blocks >= nb or out >= cap: break
            cur = ln
            buf = []
        elif cur is not None:
            buf.append(ln)
    else:
        flush()
print('## printed through line', i)
