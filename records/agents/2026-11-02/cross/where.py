import json, sys, re
sys.stdout.reconfigure(encoding='utf-8')
# where.py -- every transcript entry holding a phrase: timestamp, entry type, block kind, sidechain flag, and a window of
# context around the phrase taken from the DECODED text of the block that holds it.
# usage: python -I where.py <jsonl> <phrase> [maxhits] [before] [after] [lo] [hi]
path, phrase = sys.argv[1], sys.argv[2]
maxhits = int(sys.argv[3]) if len(sys.argv) > 3 else 50
before = int(sys.argv[4]) if len(sys.argv) > 4 else 300
after = int(sys.argv[5]) if len(sys.argv) > 5 else 300
lo = sys.argv[6] if len(sys.argv) > 6 else ''
hi = sys.argv[7] if len(sys.argv) > 7 else '9999'
def blocks(e):
    t = e.get('type')
    if t in ('user', 'assistant'):
        c = (e.get('message') or {}).get('content')
        if isinstance(c, str):
            yield t + ':str', c
        elif isinstance(c, list):
            for x in c:
                if not isinstance(x, dict): continue
                k = x.get('type')
                if k == 'text': yield t + ':text', x.get('text', '')
                elif k == 'thinking': yield t + ':thinking', x.get('thinking', '')
                elif k == 'tool_use': yield t + ':tool_use:' + str(x.get('name')), json.dumps(x.get('input', {}), ensure_ascii=False)
                elif k == 'tool_result':
                    cc = x.get('content')
                    if isinstance(cc, list):
                        cc = '\n'.join(y.get('text', '') if isinstance(y, dict) else str(y) for y in cc)
                    yield t + ':tool_result', str(cc)
                else: yield t + ':' + str(k), json.dumps(x, ensure_ascii=False)
    elif t == 'attachment':
        yield 'attachment', json.dumps(e.get('attachment'), ensure_ascii=False)
    elif t == 'queue-operation':
        yield 'queued', json.dumps(e.get('content'), ensure_ascii=False)
    else:
        yield 'entry:' + str(t), json.dumps(e, ensure_ascii=False)
n = 0
with open(path, 'r', encoding='utf-8', errors='replace') as f:
    for line in f:
        if phrase not in line and phrase.encode('unicode_escape').decode() not in line: continue
        try: e = json.loads(line)
        except Exception: continue
        ts = str(e.get('timestamp', ''))
        if not (lo <= ts < hi): continue
        for kind, s in blocks(e):
            i = s.find(phrase)
            if i < 0: continue
            n += 1
            print('=====', ts, kind, 'SIDECHAIN' if e.get('isSidechain') else '', 'len', len(s), 'at', i)
            print(s[max(0, i - before): i + after])
            break
        if n >= maxhits: break
print('## hits printed', n)
