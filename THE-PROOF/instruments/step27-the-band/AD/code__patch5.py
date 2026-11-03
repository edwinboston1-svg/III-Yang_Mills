src = open('fit.py', encoding='utf-8').read()
src = src.replace("""def label(f, gsu2, nrep=3):
    fam, rep = divmod(f, nrep)""", """L8N = ['1x3', '2x2', 'cube', 'box', 'tess']
L8C = [24, 60, 48, 1440, 1296]
def label(f, gsu2, nrep=3):
    if f >= 12: return 'L8_%s' % L8N[f - 12]
    fam, rep = divmod(f, nrep)""")
src = src.replace("""        gav = np.array([gc[:, f].sum() / (famn[f // 3] * visited.sum()) for f in range(12)])""",
"""        gav = np.array([gc[:, f].sum() / (famn[f // 3] * visited.sum()) if f < 12 else gc[:, f].sum() / (nlc.sum() * L8C[f - 12]) for f in range(d['nfeat'])])""")
src = src.replace("""        print('     ' + '  '.join('%s %.6f' % (label(f, gs), gav[f]) for f in range(12)))
        blk = {'qbar_mean': float(d['qm'][i, skip:].mean()), 'loop_avg': {label(f, gs): float(gav[f]) for f in range(12)}, 'models': {}}
        for nm, idx in MODELS.items():""", """        print('     ' + '  '.join('%s %.6f' % (label(f, gs), gav[f]) for f in range(d['nfeat'])))
        blk = {'qbar_mean': float(d['qm'][i, skip:].mean()), 'loop_avg': {label(f, gs): float(gav[f]) for f in range(d['nfeat'])}, 'models': {}}
        models = dict(MODELS)
        if d['nfeat'] == 17:
            models['FULL+8'] = list(range(17)); models['L1+8'] = [0, 3, 6, 9, 12, 13, 14, 15, 16]; models['P123+L1+8'] = [0, 1, 2, 3, 6, 9, 12, 13, 14, 15, 16]
        for nm, idx in models.items():""")
open('fit.py', 'w', encoding='utf-8').write(src)
print('patched', src.count('L8C'), src.count("models['FULL+8']"))
