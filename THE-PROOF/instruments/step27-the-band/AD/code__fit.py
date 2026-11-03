"""fit.py -- AD: the score-matching fit of the coarse action from ymc.c's .stats file, with jackknife errors over binned configurations.
theta = -M^-1 b for S = -sum theta_(f,r) F_(f,r); M, b the per-link averages.  Sub-models are sub-blocks of the same M, b.
usage: python fit.py PREFIX [nbin] [skip]   (reads PREFIX.stats)  -> prints, and writes PREFIX.fit.json"""
import sys, struct, json
import numpy as np

FAM = ['plaq', 'rect', 'chair', 'parag']

def read_stats(fn):
    raw = open(fn, 'rb').read()
    hdr = struct.unpack_from('8i', raw, 0); off = 32
    gsu2, N, nn, nfeat, nrep, nfam, nconf, savec = hdr
    nl = list(struct.unpack_from('%di' % nn, raw, off)); off += 4 * nn
    beta = struct.unpack_from('d', raw, off)[0]; off += 8
    stsz = (nfeat * nfeat + 2 * nfeat) * 8 + 16
    rec = 8 + nn * (16 + stsz)
    nc = (len(raw) - off) // rec
    plaq = np.zeros(nc); qm = np.zeros((nn, nc)); qmin = np.zeros((nn, nc))
    M = np.zeros((nn, nc, nfeat, nfeat)); b = np.zeros((nn, nc, nfeat)); g = np.zeros((nn, nc, nfeat)); nlink = np.zeros((nn, nc))
    for c in range(nc):
        o = off + c * rec
        plaq[c] = struct.unpack_from('d', raw, o)[0]; o += 8
        for i in range(nn):
            qm[i, c], qmin[i, c] = struct.unpack_from('2d', raw, o); o += 16
            arr = np.frombuffer(raw, dtype=np.float64, count=nfeat * nfeat + 2 * nfeat, offset=o)
            M[i, c] = arr[:nfeat * nfeat].reshape(nfeat, nfeat); b[i, c] = arr[nfeat * nfeat:nfeat * nfeat + nfeat]; g[i, c] = arr[nfeat * nfeat + nfeat:]
            o += (nfeat * nfeat + 2 * nfeat) * 8
            nlink[i, c] = struct.unpack_from('q', raw, o)[0]; o += 16
    return dict(gsu2=gsu2, N=N, nl=nl, beta=beta, nfeat=nfeat, nrep=nrep, nfam=nfam, nc=nc, plaq=plaq, qm=qm, qmin=qmin, M=M, b=b, g=g, nlink=nlink)

L8N = ['1x3', '2x2', 'cube', 'box', 'tess']
L8C = [24, 60, 48, 1440, 1296]
def label(f, gsu2, nrep=3):
    if f >= 12: return 'L8_%s' % L8N[f - 12]
    fam, rep = divmod(f, nrep)
    return '%s_%s' % (FAM[fam], ['1/2', '1', '3/2'][rep] if gsu2 else ['q1', 'q2', 'q3'][rep])

def solve(Msum, bsum, idx):
    A = Msum[np.ix_(idx, idx)]; bb = bsum[idx]
    return -np.linalg.solve(A, bb)

def jack(Mc, bc, nlc, idx, nbin):
    nc = Mc.shape[0]; per = nc // nbin
    Mb = np.array([Mc[k * per:(k + 1) * per].sum(0) for k in range(nbin)]); bb = np.array([bc[k * per:(k + 1) * per].sum(0) for k in range(nbin)])
    Mt, bt = Mb.sum(0), bb.sum(0)
    th = solve(Mt, bt, idx)
    jk = np.array([solve(Mt - Mb[k], bt - bb[k], idx) for k in range(nbin)])
    err = np.sqrt((nbin - 1) / nbin * ((jk - jk.mean(0)) ** 2).sum(0))
    return th, err, jk

MODELS = {
    'P1': [0],                                   # plaquette, fundamental only
    'P123': [0, 1, 2],                           # plaquette, three reps
    'L1': [0, 3, 6, 9],                          # four families, fundamental
    'L1+P23': [0, 1, 2, 3, 6, 9],                # four families fundamental + plaquette higher reps
    'FULL': list(range(12)),
}

def main():
    pre = sys.argv[1]; nbin = int(sys.argv[2]) if len(sys.argv) > 2 else 20; skip = int(sys.argv[3]) if len(sys.argv) > 3 else 0
    d = read_stats(pre + '.stats')
    gs = d['gsu2']
    print('FIT %s: G=%s beta=%.6f N=%d nconf=%d (skip %d) nlist=%s' % (pre, 'su2' if gs else 'vil', d['beta'], d['N'], d['nc'], skip, d['nl']))
    print('  fine plaquette <Re U_p> = %.6f +- %.6f' % (d['plaq'][skip:].mean(), d['plaq'][skip:].std() / np.sqrt(d['nc'] - skip) * 3))
    out = {'prefix': pre, 'G': 'su2' if gs else 'vil', 'beta': d['beta'], 'N': d['N'], 'nconf': d['nc'] - skip, 'blocks': {}}
    for i, n in enumerate(d['nl']):
        Mc = d['M'][i, skip:]; bc = d['b'][i, skip:]; gc = d['g'][i, skip:]; nlc = d['nlink'][i, skip:]
        nlk = nlc.sum()
        nsites_per_loop = (d['N'] // n) ** 4
        # loop averages: per-loop expectation of g = sum gavg / (#loops counted); counted loops per conf = (#families per site) * (#sites visited)
        famn = [6, 12, 48, 16]
        visited = nlc / 4.0
        gav = np.array([gc[:, f].sum() / (famn[f // 3] * visited.sum()) if f < 12 else gc[:, f].sum() / (nlc.sum() * L8C[f - 12]) for f in range(d['nfeat'])])
        print('  n=%d (coarse %d^4): |qbar| mean %.5f min %.5f; links used %d; loop averages:' % (n, d['N'] // n, d['qm'][i, skip:].mean(), d['qmin'][i, skip:].min(), nlk))
        print('     ' + '  '.join('%s %.6f' % (label(f, gs), gav[f]) for f in range(d['nfeat'])))
        blk = {'qbar_mean': float(d['qm'][i, skip:].mean()), 'loop_avg': {label(f, gs): float(gav[f]) for f in range(d['nfeat'])}, 'models': {}}
        models = dict(MODELS)
        if d['nfeat'] == 17:
            models['FULL+8'] = list(range(17)); models['L1+8'] = [0, 3, 6, 9, 12, 13, 14, 15, 16]; models['P123+L1+8'] = [0, 1, 2, 3, 6, 9, 12, 13, 14, 15, 16]
        for nm, idx in models.items():
            th, err, jk = jack(Mc, bc, nlc, idx, nbin)
            print('   model %-7s ' % nm + '  '.join('%s %+.5f(%.5f)' % (label(f, gs), th[k], err[k]) for k, f in enumerate(idx)))
            blk['models'][nm] = {'idx': idx, 'theta': th.tolist(), 'err': err.tolist(), 'labels': [label(f, gs) for f in idx],
                                 'jack': jk.tolist()}
        out['blocks'][str(n)] = blk
    json.dump(out, open(pre + '.fit.json', 'w'), indent=1)

if __name__ == '__main__':
    main()
