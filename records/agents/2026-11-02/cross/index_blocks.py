import sys, re, os
sys.stdout.reconfigure(encoding='utf-8')
# index_blocks.py -- split an extract into its blocks (=== <ts> <ROLE> <kind>) and score each block against the crossing
# vocabulary. Prints one line per scoring block: line number, header, size, which CORE patterns matched, which HEDGE
# patterns matched, and a 220-char snippet around the first core hit.
# usage: python -I index_blocks.py <extract.txt> [minscore]
src = sys.argv[1]
minscore = int(sys.argv[2]) if len(sys.argv) > 2 else 1
CORE = [
 ('Kstar7', r'K\s*[\*⋆∗]\s*=\s*7|K_\{?\*\}?\s*=\s*7|K\^\{?\*\}?\s*=\s*7|K\*\s*=\s*7'),
 ('closed_k8', r'closed at k\s*=\s*8|closed at \$?k\s*=\s*8'),
 ('Tomboulis', r'Tomboulis'),
 ('n0', r"n[₀_]0?\b|n_0|n₀|\bn0\b"),
 ('MK', r'Migdal|Kadanoff|\bMK\b'),
 ('hier', r'[Hh]ierarchical'),
 ('beta22_23', r'(β|\\beta|beta)\s*(=|≈|~|\\approx|near|of|at)?\s*2\.[23]\d?|2\.2\s*[–-]\s*2\.3'),
 ('cross_thm', r'crossover theorem'),
 ('crosses', r'\bcross(es|ed|ing)?\b(?! ?-?(section|check|ref|session|road|platform))'),
 ('crossover', r'[Cc]rossover'),
 ('allbeta', r'(all|every|each) (β|beta|\\beta|couplings?)\b'),
 ('continuum', r'continuum limit'),
 ('hypI', r'Hypothes[ie]s I\b|Hypothesis I and II|Hypotheses I and II'),
 ('gap_at', r'mass gap at|gap at (β|beta)'),
 ('certified', r'[Cc]ertified (descent|crossing|flow|bound|interval)'),
]
HEDGE = [
 ('a_reading', r'\ba reading\b'),
 ('not_proof', r'not a proof|is not a proof|not yet a proof'),
 ('not_claimed', r'not claimed|no claim|does not claim|claims? nothing'),
 ('withdrawn', r'[Ww]ithdr[ae]wn?|[Ww]ithdraw'),
 ('hier_models', r"hierarchical model'?s?"),
 ('does_not_cross', r'does not cross|did not cross|cannot cross|never crossed'),
 ('scope', r'\bscope\b'),
 ('conditional', r'\b[Cc]onditional\b'),
 ('open', r'\bOPEN\b|remains open|still open'),
]
CRE = [(n, re.compile(p)) for n, p in CORE]
HRE = [(n, re.compile(p)) for n, p in HEDGE]
head_re = re.compile(r'^=== (\d{4}-\d\d-\d\dT\S+) (.*)$')
lines = open(src, encoding='utf-8', errors='replace').read().split('\n')
blocks = []  # (start_line, header, [lines])
cur = None
for i, ln in enumerate(lines):
    m = head_re.match(ln)
    if m:
        if cur: blocks.append(cur)
        cur = [i + 1, ln, []]
    elif cur is not None:
        cur[2].append(ln)
if cur: blocks.append(cur)
for start, head, body in blocks:
    text = '\n'.join(body)
    core = [n for n, r in CRE if r.search(text)]
    strong = [n for n in core if n not in ('crosses', 'crossover', 'continuum', 'hypI', 'n0')]
    score = len(strong) + (1 if 'crossover' in core and ('crosses' in core or 'beta22_23' in core) else 0)
    if score < minscore: continue
    hedge = [n for n, r in HRE if r.search(text)]
    first = None
    for n, r in CRE:
        if n in strong:
            m = r.search(text)
            if m and (first is None or m.start() < first): first = m.start()
    if first is None: first = 0
    snip = text[max(0, first - 100): first + 120].replace('\n', ' ')
    print('%d\t%s\t%d\tS=%d\t%s\t|%s\t%s' % (start, head[4:90], len(text), score, ','.join(core), ','.join(hedge), snip))
