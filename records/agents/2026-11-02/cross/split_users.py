import sys, re, os
sys.stdout.reconfigure(encoding='utf-8')
# split_users.py -- split a users_msgs output into the operator's own words, cross-session messages, side-agent notes
# and machine notices. usage: python -I split_users.py <users.txt> <outdir>
src, outdir = sys.argv[1], sys.argv[2]
base = os.path.basename(src).split('.')[0]
txt = open(src, encoding='utf-8', errors='replace').read()
parts = re.split(r'(?m)^(=== \d{4}-\d\d-\d\dT[^\n]*)\n', txt)
# parts: [pre, head1, body1, head2, body2, ...]
outs = {k: open(os.path.join(outdir, '%s.%s.txt' % (base, k)), 'w', encoding='utf-8') for k in ('operator', 'xsession', 'notes', 'machine')}
cnt = {k: 0 for k in outs}
for i in range(1, len(parts) - 1, 2):
    head, body = parts[i], parts[i + 1]
    b = body.lstrip()
    if b.startswith('<cross-session-message') or b.startswith('[Cross-session delivery notice]'):
        k = 'xsession'
    elif b.startswith('Here is a note offered by a side agent'):
        k = 'notes'
    elif b.startswith('<task-notification>') or b.startswith('Your claude.ai usage limit') or b.startswith('<local-command'):
        k = 'machine'
    elif b.startswith('<command-message>') or b.startswith('<command-name>'):
        m = re.search(r'<command-args>(.*?)</command-args>', b, re.S)
        if m and m.group(1).strip():
            k = 'operator'
            body = '[skill command %s] %s\n' % (re.search(r'<command-name>(.*?)</command-name>', b).group(1) if re.search(r'<command-name>(.*?)</command-name>', b) else '?', m.group(1).strip())
        else:
            k = 'machine'
    else:
        k = 'operator'
    outs[k].write(head + '\n' + body.rstrip() + '\n\n')
    cnt[k] += 1
print(base, cnt)
