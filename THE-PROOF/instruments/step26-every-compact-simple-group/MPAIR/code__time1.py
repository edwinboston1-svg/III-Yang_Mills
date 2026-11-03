import sys, time
sys.path.insert(0, sys.argv[1])
import mg2_su2_eval as S2
t = time.time(); R = S2.alpha_su2('0.2400', 'EXACT'); print('EXACT call', time.time() - t, 's', R['alpha'])
t = time.time(); R = S2.alpha_su2('0.2400', 'L86'); print('L86 call', time.time() - t, 's', R['alpha'])
