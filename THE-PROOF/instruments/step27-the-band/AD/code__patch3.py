src = open('ymc.c', encoding='utf-8').read()
src = src.replace("  if (k < 1e-14) { U[s*4+mu] = randsu2_a0(2*rnd(r) - 1 , r); /* not Haar in a0 -- corrected below */ }\n", "")
src = src.replace("            if (sg > 0 && pos == 0) loc.gavg[f] += g; }     /* each loop counted once: at its first link, when that link is c */",
                  "            if (pos == 0) loc.gavg[f] += g; }     /* each loop counted once: at its first link, when that link is c */")
open('ymc.c', 'w', encoding='utf-8').write(src)
print(src.count('pos == 0) loc.gavg'), src.count('not Haar'))
