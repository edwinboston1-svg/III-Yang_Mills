#!/bin/bash
# w3l2_sliced.sh -- THE SLICED SWEEP ON THE TWO-STEP OBJECT: first the control (the two-step W2L2 ordered object, landed unsliced on
# 2026-11-01a, re-swept under W2_SLICE=full and compared field by field), then the object §8/§10 refused at link 45 of 76 -- W3L2
# (plaquette spins to 3/2, loop representations to 1) at the three data of §10 (ordered, cancelling, Haar-random seed 1) -- under the
# slice mode, each to a new record name (letter b).  A frozen copy in the scratchpad, never edited while it runs.
set -u
cd "/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/build/aperanton/surface-gas" || exit 2
S="/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad"
cmpvals(){ paste -d'\n' <(grep '^W2-CLASS\|^W2-CHANNEL\|^W2-CONN\|^W2-Z' "$1" | sed -E 's/; [0-9.]+ s(; [0-9]+ slices)?\)/)/; s/max state [0-9]+/max state X/') <(grep '^W2-CLASS\|^W2-CHANNEL\|^W2-CONN\|^W2-Z' "$2" | sed -E 's/; [0-9.]+ s(; [0-9]+ slices)?\)/)/; s/max state [0-9]+/max state X/') | gawk 'NR % 2 == 1 { a = $0; next } { b = $0; na = split(a, A, /[ ()=;,]+/); nb = split(b, B, /[ ()=;,]+/); if (na != nb) { print "FIELD COUNT DIFFERS:"; print a; print b; bad++; next } for (i = 1; i <= na; i++) { if (A[i] == B[i]) continue; if (A[i] ~ /^[-+]?[0-9.]+e?[-+]?[0-9]*$/ && B[i] ~ /^[-+]?[0-9.]+e?[-+]?[0-9]*$/) { x = A[i] + 0; y = B[i] + 0; d = x - y; if (d < 0) d = -d; s = (x < 0 ? -x : x) + (y < 0 ? -y : y); r = s > 0 ? 2 * d / s : 0; if (d > dmax) dmax = d; if (r > rmax && s > 1e-9) rmax = r } else { print "TEXT DIFFERS: " A[i] " vs " B[i]; bad++ } } n++ } END { printf "%d line pairs; max abs diff %.3e, max rel diff %.3e, text/field mismatches %d\n", n, dmax, rmax, bad; if (bad || rmax > 1e-9) exit 3 }'; }
echo "start $(date '+%H:%M:%S %Z')"
W2_SLICE=full OMP_NUM_THREADS=8 ./w2_strip_s.exe 2.2 2 2 ordered fwd bent 4 > "$S/ctl_n4_W2L2_full.txt" 2>&1
echo "control: the two-step W2L2 ordered object under the slice mode against w2n4_W2L2.2026-11-01a.ordered.txt ($(date '+%H:%M:%S')):"
grep '^W2-CLASS' "$S/ctl_n4_W2L2_full.txt" | sed 's/E\[chi_a(A) chi_c(B)\] = [^ ]* (imag [^;]*; //' | cut -c1-120
if cmpvals "$S/ctl_n4_W2L2_full.txt" w2n4_W2L2.2026-11-01a.ordered.txt; then echo "control MET"; else echo "REFUSED: the two-step control parted from the landed record"; exit 3; fi
for d in ordered cancel random:1; do tag=${d/:/}; out="w2n4_W3L2.2026-11-01b.$tag.txt"
  if [ -e "$out" ]; then echo "REFUSED: $out exists (a re-run never writes to a landed record's name)"; exit 4; fi
  echo "W3L2 $d begins $(date '+%H:%M:%S')"
  W2_SLICE=full OMP_NUM_THREADS=8 ./w2_strip_s.exe 2.2 3 2 $d fwd bent 4 > "$out" 2>&1
  echo "W3L2 $d ends $(date '+%H:%M:%S'): $(grep -c '^W2-CLASS' "$out") classes; $(grep 'REFUSED\|out of memory\|slice ended' "$out" | head -1)"
  grep '^W2-CLASS a=2 c=2\|^W2-DONE' "$out" | cut -c1-200
done
echo "end $(date '+%H:%M:%S %Z')"
