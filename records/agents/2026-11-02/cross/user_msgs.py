import json, sys, os
sys.stdout.reconfigure(encoding='utf-8')
# user_msgs.py -- the operator's own words in one transcript: typed or pasted prompts (string content or text blocks,
# not tool results, not meta/hook entries), queued mid-turn commands of human origin, and enqueue operations. Each
# message printed once (a queued message reappears as an attachment and as a queue entry; dedup by text).
# usage: python -I user_msgs.py <jsonl> <lo> <hi> [maxlen]
path, lo, hi = sys.argv[1], sys.argv[2], sys.argv[3]
maxlen = int(sys.argv[4]) if len(sys.argv) > 4 else 6000
seen = set()
def out(ts, kind, s):
    s = s.strip()
    if not s: return
    key = s[:400]
    if key in seen: return
    seen.add(key)
    if len(s) > maxlen: s = s[:maxlen] + ' [... %d chars total]' % len(s)
    print('=== %s %s' % (ts, kind))
    print(s)
with open(path, 'r', encoding='utf-8', errors='replace') as f:
    for line in f:
        try: e = json.loads(line)
        except Exception: continue
        ts = str(e.get('timestamp', ''))
        if not (lo <= ts < hi): continue
        t = e.get('type')
        if e.get('isSidechain'): continue
        if t == 'user' and not e.get('isMeta') and not e.get('isCompactSummary'):
            c = (e.get('message') or {}).get('content')
            if isinstance(c, str):
                if c.startswith('<local-command') or c.startswith('<command-name>') and 'clear' in c[:40]: continue
                out(ts, 'USER', c)
            elif isinstance(c, list):
                for x in c:
                    if isinstance(x, dict) and x.get('type') == 'text':
                        s = x.get('text', '')
                        if s.startswith('<system-reminder>') or s.startswith('[Request interrupted'): continue
                        out(ts, 'USER', s)
                    elif isinstance(x, dict) and x.get('type') == 'tool_result':
                        cc = x.get('content')
                        if isinstance(cc, list):
                            for y in cc:
                                if isinstance(y, dict) and y.get('type') == 'text' and 'The user sent a new message while you were working' in y.get('text', ''):
                                    out(ts, 'USER (mid-turn, inside a tool result)', y['text'])
        elif t == 'attachment':
            a = e.get('attachment') or {}
            if a.get('type') == 'queued_command':
                o = a.get('origin') or {}
                if o.get('kind', 'human') == 'human':
                    p = a.get('prompt')
                    if isinstance(p, list):
                        p = '\n'.join(y.get('text', '') if isinstance(y, dict) else str(y) for y in p)
                    out(ts, 'USER (queued)', str(p))
        elif t == 'queue-operation' and e.get('operation') == 'enqueue':
            c = e.get('content')
            if isinstance(c, list):
                c = '\n'.join(y.get('text', '') if isinstance(y, dict) else str(y) for y in c)
            if c and not str(c).startswith('<task-notification>'): out(ts, 'USER (enqueue)', str(c))
