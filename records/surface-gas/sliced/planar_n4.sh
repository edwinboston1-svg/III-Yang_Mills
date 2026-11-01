#!/bin/bash
# planar_n4.sh -- §12 (b): THE PLANAR TWO-STEP OBJECT at W2L2 under the slice mode, at §10's three data, after the control (the planar
# one-step at W2L1 unsliced against sliced, every value equal).  Records w2n4_W2L2_planar.2026-11-01a.<datum>.txt; the control's two
# files under sliced/.  8 threads.  A frozen copy in the scratchpad, never edited while it runs.
set -u
cd "/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/build/aperanton/surface-gas" || exit 2
cmpvals(){ paste -d'\n' <(grep '^W2-CLASS\|^W2-CHANNEL\|^W2-CONN\|^W2-Z' "$1" | sed -E 's/; [0-9.]+ s(; [0-9]+ slices)?\)/)/; s/max state [0-9]+/max state X/') <(grep '^W2-CLASS\|^W2-CHANNEL\|^W2-CONN\|^W2-Z' "$2" | sed -E 's/; [0-9.]+ s(; [0-9]+ slices)?\)/)/; s/max state [0-9]+/max state X/') | gawk 'NR % 2 == 1 { a = $0; next } { b = $0; na = split(a, A, /[ ()=;,]+/); nb = split(b, B, /[ ()=;,]+/); if (na != nb) { print "FIELD COUNT DIFFERS:"; print a; print b; bad++; next } for (i = 1; i <= na; i++) { if (A[i] == B[i]) continue; if (A[i] ~ /^[-+]?[0-9.]+e?[-+]?[0-9]*$/ && B[i] ~ /^[-+]?[0-9.]+e?[-+]?[0-9]*$/) { x = A[i] + 0; y = B[i] + 0; d = x - y; if (d < 0) d = -d; s = (x < 0 ? -x : x) + (y < 0 ? -y : y); r = s > 0 ? 2 * d / s : 0; if (d > dmax) dmax = d; if (r > rmax && s > 1e-9) rmax = r } else { print "TEXT DIFFERS: " A[i] " vs " B[i]; bad++ } } n++ } END { printf "%d line pairs; max abs diff %.3e, max rel diff %.3e, text/field mismatches %d\n", n, dmax, rmax, bad; if (bad || rmax > 1e-9) exit 3 }'; }
echo "start $(date '+%H:%M:%S %Z')"
mkdir -p sliced
OMP_NUM_THREADS=8 ./w2_strip_s.exe 2.2 2 1 ordered fwd planar 2 > sliced/ctl_planar_n2_W2L1_unsliced.txt 2>&1
W2_SLICE=full OMP_NUM_THREADS=8 ./w2_strip_s.exe 2.2 2 1 ordered fwd planar 2 > sliced/ctl_planar_n2_W2L1_full.txt 2>&1
echo "control (planar one-step W2L1, unsliced against sliced):"; if cmpvals sliced/ctl_planar_n2_W2L1_unsliced.txt sliced/ctl_planar_n2_W2L1_full.txt; then echo "control MET"; else echo "REFUSED: the planar control parted"; exit 3; fi
for d in ordered cancel random:1; do tag=${d/:/}; out="w2n4_W2L2_planar.2026-11-01a.$tag.txt"
  if [ -e "$out" ]; then echo "REFUSED: $out exists"; exit 4; fi
  echo "planar W2L2 $d begins $(date '+%H:%M:%S')"
  W2_SLICE=full OMP_NUM_THREADS=8 ./w2_strip_s.exe 2.2 2 2 $d fwd planar 4 > "$out" 2>&1
  echo "planar W2L2 $d ends $(date '+%H:%M:%S'): $(grep -c '^W2-CLASS' "$out") classes; $(grep 'REFUSED\|out of memory\|slice ended' "$out" | head -1)"
done
echo "P1 (the ordered datum equals the bent two-step, nine class moments):"; cmpvals w2n4_W2L2_planar.2026-11-01a.ordered.txt w2n4_W2L2.2026-11-01a.ordered.txt && echo "P1 HELD" || echo "P1 FAILED (read the fields above)"
echo "end $(date '+%H:%M:%S %Z')"
