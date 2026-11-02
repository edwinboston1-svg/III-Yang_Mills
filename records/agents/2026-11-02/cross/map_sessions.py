import json, sys, os, re, collections
sys.stdout.reconfigure(encoding="utf-8")
# map_sessions.py -- for each transcript: first/last timestamp, entries per UTC date, and per-date counts of lines
# carrying the crossover vocabulary. usage: python -I map_sessions.py <jsonl> [<jsonl> ...]
pats = ['Tomboulis', 'K* = 7', 'K*=7', 'closed at k = 8', 'crossover theorem', 'Migdal', 'β = 2.3', 'beta=2.3',
        'β = 2.2', 'beta=2.2', 'hierarchical', 'crossover', 'Yang', 'mass gap']
for path in sys.argv[1:]:
    first = last = None
    per = collections.OrderedDict()
    with open(path, 'r', encoding='utf-8', errors='replace') as f:
        for line in f:
            m = re.search(r'"timestamp":"([0-9T:\-\.]+)Z?"', line)
            if not m: continue
            ts = m.group(1)
            if first is None or ts < first: first = ts
            if last is None or ts > last: last = ts
            d = ts[:13]  # hour resolution in UTC
            row = per.setdefault(d[:10], collections.Counter())
            row['_n'] += 1
            for p in pats:
                if p in line: row[p] += 1
    print('#', os.path.basename(path)[:8], 'first', first, 'last', last, 'bytes', os.path.getsize(path))
    for d, c in sorted(per.items()):
        print('  ', d, 'n=%d' % c['_n'], ' '.join('%s:%d' % (p, c[p]) for p in pats if c[p]))
    sys.stdout.flush()
