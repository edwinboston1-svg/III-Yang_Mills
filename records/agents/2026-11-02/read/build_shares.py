import os, sys, hashlib, re
# build_shares.py -- every file of the reading cut into shares, de-duplicated by sha256 (the first copy wins, by source order).
# Writes one TSV per share: path, first_line, last_line, total_lines, bytes, sha256_16, note.
SP = sys.argv[1]
REPO = 'C:/Users/Edwin Boston/OneDrive/Desktop/III-Yang_Mills'
III = 'C:/Users/Edwin Boston/OneDrive/Desktop/III'
TMP = 'C:/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III'
DL = 'C:/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-Downloads'
OUT = SP + '/read'
IGN = chr(33) * 2 + ' '
BIN_EXT = {'.exe', '.o', '.a', '.dll', '.whl', '.node', '.pdf', '.docx', '.pptx', '.png', '.jpg', '.jpeg', '.gif', '.ots', '.zip', '.gz', '.pyc', '.lib', '.obj', '.ico', '.woff', '.woff2', '.ttf'}
YM = re.compile(r'aperanton|ΑΠΕΡΑΝΤΟΝ|yang.mills|flux.surface|surface-gas|pentapylon|ΠΕΝΤΑΠΥΛΟΝ', re.I)
LEDGER = re.compile(r'(tasks|tally|memory|memidx|canon|claude|sympan|euporia|every-theorem)', re.I)
seen = {}; items = []; dumps = []; binaries = []; dups = []


def sha(p):
    h = hashlib.sha256()
    with open(p, 'rb') as f:
        for b in iter(lambda: f.read(1 << 20), b''):
            h.update(b)
    return h.hexdigest()


def is_bin(p):
    if os.path.splitext(p)[1].lower() in BIN_EXT:
        return True
    with open(p, 'rb') as f:
        return b'\0' in f.read(65536)


def add(p, cat, crit=False, maxdump=1000000, need_ym=False):
    try:
        sz = os.path.getsize(p)
    except OSError:
        return
    if sz == 0:
        items.append((p, cat, crit, 0, '', 'EMPTY'))
        return
    h = sha(p)
    if h in seen:
        dups.append((p, seen[h]))
        return
    seen[h] = p
    if is_bin(p):
        binaries.append((p, cat, sz, h[:16]))
        return
    if 'node_modules' in p:
        return
    if need_ym and LEDGER.search(os.path.basename(p)):
        return
    if need_ym:
        with open(p, 'r', encoding='utf-8', errors='replace') as f:
            if not YM.search(f.read()):
                return
    if sz >= maxdump:
        dumps.append((p, cat, sz, h[:16]))
        return
    items.append((p, cat, crit, sz, h, ''))


CRIT_EXT = {'.md', '.js', '.lean', '.awk', '.c', '.sh', '.py', '.pl', '.iii', '.toml', '.json', '.ps1', '.cjs', '.mjs', '.ts', '.h'}
# 1. the repository, tracked files
for line in open(SP + '/ym_inventory.tsv', encoding='utf-8'):
    sz, rel = line.rstrip('\n').split('\t', 1)
    top = rel.split('/')[0]
    crit = top in ('OPEN', 'source', 'kernel', 'TIMESTAMPS') or '/' not in rel or os.path.splitext(rel)[1] in CRIT_EXT or 'lean-drafts' in rel
    add(REPO + '/' + rel, 'REPO:' + (rel.rsplit('/', 1)[0] if '/' in rel else '(root)'), crit, maxdump=10**9)
# 1b. the repository, ignored files (the generated builds of the paper)
for line in open(SP + '/ym_status.txt', encoding='utf-8'):
    if line.startswith(IGN):
        rel = line[3:].strip().strip('"')
        p = REPO + '/' + rel
        if os.path.isdir(p):
            for r, ds, fs in os.walk(p):
                for fn in sorted(fs):
                    add(os.path.join(r, fn).replace(os.sep, '/'), 'REPO-IGNORED', False, maxdump=10**9)
        else:
            add(p, 'REPO-IGNORED', False, maxdump=10**9)
# 2. III: the Yang-Mills files whose disk copy differs from III's HEAD, whole, then their differences (derived/)
for rel in open(SP + '/preserve/modified.txt', encoding='utf-8'):
    rel = rel.strip()
    if rel:
        add(III + '/' + rel, 'III-MODIFIED', True, maxdump=10**9)
for fn in sorted(os.listdir(OUT + '/derived')):
    add(OUT + '/derived/' + fn, 'DERIVED:' + fn, True, maxdump=10**9)
# 3. III: the untracked Yang-Mills files
for line in open(OUT + '/ym_iii_untracked.tsv', encoding='utf-8'):
    rel = line.rstrip('\n').split('\t', 1)[1]
    add(III + '/' + rel, 'III-UNTRACKED:' + rel.rsplit('/', 1)[0], os.path.splitext(rel)[1] in CRIT_EXT)
# 4. this seat's scratchpad (iii-43), without its derived copies of the transcripts and of this reading
S43 = TMP + '/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad'
for r, ds, fs in os.walk(S43):
    rr = r.replace(os.sep, '/')
    rel = rr[len(S43):].lstrip('/')
    if rel.split('/')[0] in ('logs2', 'chunks', 'logs_today', 'read', 'preserve', 'cross'):
        continue
    ds.sort()
    for fn in sorted(fs):
        if fn.startswith('TASKS.') or fn in ('ym_inventory.tsv', 'ym_status.txt'):
            continue
        add(rr + '/' + fn, 'SCRATCH-iii-43:' + (rel or '.'), os.path.splitext(fn)[1] in CRIT_EXT, maxdump=3000000)
# 5. the coordination seat's scratchpad (iii-bd)
SBD = TMP + '/5cf16cea-92b5-4e54-885f-89502ddc48bc/scratchpad'
for r, ds, fs in os.walk(SBD):
    rr = r.replace(os.sep, '/')
    rel = rr[len(SBD):].lstrip('/')
    ds.sort()
    for fn in sorted(fs):
        add(rr + '/' + fn, 'SCRATCH-iii-bd:' + (rel or '.'), os.path.splitext(fn)[1] in CRIT_EXT, maxdump=3000000)
# 6. the other seats' scratchpads: every text file that touches the Yang-Mills work
for label, d in (('SCRATCH-iii-ac', TMP + '/c3419161-1496-4c60-853d-6b9a49a534f2/scratchpad'),
                 ('SCRATCH-iii-73', TMP + '/113c4e67-325f-42ca-99a9-3cbe27b0817a/scratchpad'),
                 ('SCRATCH-downloads', DL + '/323ff9aa-d71b-406e-a6d9-7a5fbdba1413/scratchpad')):
    for r, ds, fs in os.walk(d):
        rr = r.replace(os.sep, '/')
        rel = rr[len(d):].lstrip('/')
        if 'node_modules' in rel:
            continue
        ds.sort()
        for fn in sorted(fs):
            add(rr + '/' + fn, label + ':' + (rel or '.'), os.path.splitext(fn)[1] in CRIT_EXT, maxdump=3000000, need_ym=True)
# 7. the day's transcripts, whole
for fn in ('59ca2c52.txt', '1b475c5c.txt', '5cf16cea.txt', 'b7e5b036_eve.txt', '113c4e67.txt', 'c3419161.txt', '8b416eda.txt', '323ff9aa.txt'):
    add(SP + '/logs2/full/' + fn, 'LOG:' + fn, False, maxdump=10**9)


def line_lengths(p):
    with open(p, 'rb') as f:
        return [len(ln) for ln in f]


shares = []
cur = {}


def new_share(kind):
    global cur
    cur = {'kind': kind, 'rows': [], 'bytes': 0}
    shares.append(cur)


groups = {}
for it in items:
    key = 'LOG' if it[1].startswith('LOG') else ('P' if it[2] else 'R')
    groups.setdefault(key, []).append(it)
for key, cap in (('P', 350000), ('R', 1000000), ('LOG', 1000000)):
    new_share(key)
    lastcat = None
    for p, cat, crit, sz, h, note in groups.get(key, []):
        if sz == 0:
            cur['rows'].append((p, 0, 0, 0, 0, '-', 'EMPTY ' + cat))
            continue
        offs = line_lengths(p)
        tot = len(offs)
        mx = max(offs) if offs else 0
        nt = cat + (' LONGLINES(max %d bytes)' % mx if mx > 20000 else '')
        if key == 'LOG' and lastcat is not None and cat != lastcat and cur['bytes'] > 0:
            new_share(key)
        lastcat = cat
        a = 0
        while a < tot:
            room = cap - cur['bytes']
            if room < cap * 0.15 and cur['bytes'] > 0:
                new_share(key)
                room = cap
            b = a
            acc = 0
            while b < tot and (acc + offs[b] <= room or b == a):
                acc += offs[b]
                b += 1
            cur['rows'].append((p, a + 1, b, tot, acc, h[:16], nt))
            cur['bytes'] += acc
            a = b
            if a < tot:
                new_share(key)
shares = [s for s in shares if s['rows']]
with open(OUT + '/shares/INDEX.tsv', 'w', encoding='utf-8') as idx:
    for i, s in enumerate(shares, 1):
        sid = '%03d_%s' % (i, s['kind'])
        with open(OUT + '/shares/' + sid + '.tsv', 'w', encoding='utf-8') as o:
            o.write('#path\tfirst_line\tlast_line\ttotal_lines\tbytes\tsha256_16\tnote\n')
            for r in s['rows']:
                o.write('\t'.join(str(x) for x in r) + '\n')
        cats = sorted(set(r[6].split(' ')[0] for r in s['rows']))
        idx.write('%s\t%d\t%d\t%s\n' % (sid, s['bytes'], len(s['rows']), ';'.join(cats)[:400]))
with open(OUT + '/shares/DUMPS.tsv', 'w', encoding='utf-8') as o:
    for p, cat, sz, h in dumps:
        o.write('%s\t%s\t%d\t%s\n' % (p, cat, sz, h))
with open(OUT + '/shares/BINARIES.tsv', 'w', encoding='utf-8') as o:
    for p, cat, sz, h in binaries:
        o.write('%s\t%s\t%d\t%s\n' % (p, cat, sz, h))
with open(OUT + '/shares/DUPLICATES.tsv', 'w', encoding='utf-8') as o:
    for p, q in dups:
        o.write('%s\tsame bytes as\t%s\n' % (p, q))
tb = {}
for s in shares:
    tb.setdefault(s['kind'], [0, 0])
    tb[s['kind']][0] += 1
    tb[s['kind']][1] += s['bytes']
print('shares', len(shares), tb)
print('dumps', len(dumps), sum(d[2] for d in dumps), 'binaries', len(binaries), sum(b[2] for b in binaries), 'duplicates', len(dups))
