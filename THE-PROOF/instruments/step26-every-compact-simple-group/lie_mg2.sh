#!/usr/bin/env bash
# lie_mg2.sh -- ΟΛΟΚΛΗΡΩΣΙΣ Addendum VI, STEP 6(a) CLOSED ON Ο5: MG2's threshold beta*_G re-decided by mg2_cert.awk with the per-group inputs
# taken from III's own derivation (lie_moments.2026-11-03a.txt: the LM-SEVEN lines) instead of general_eval.py's typed table.  The synthetic
# record carries, per group, a "== NAME ..." line built from LM-SEVEN (type, d, n, t3, t4, o3, m4, c3exact -- the fields mg2_cert.awk reads;
# h and kappa are copied from the python line because mg2_cert.awk prints, never reads, them) and the python's own "CERTIFIED alpha_G < 1
# on [0, B]" line -- the CLAIM under test.  Ο5's parity (PASS at beta*, FAIL at beta* + 1e-4) must then read WHOLE on III's inputs exactly
# as it did on the python's: a parting group would mean the typed table and the derivation disagree where the threshold is sensitive.
#   usage: bash lie_mg2.sh [lie record] [python record] > record
set -u
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"; cd "$ROOT" || exit 9
LM="${1:-STDLIB/build/holoklerosis/lie_moments.2026-11-03a.txt}"; PY="${2:-STDLIB/build/aperanton/instruments/2026-11-02/math/MG2/runs/general_eval.2026-11-02a.txt}"
[ -f "$LM" ] || { echo "LG-REFUSED: the derivation record is absent: $LM"; exit 2; }
[ -f "$PY" ] || { echo "LG-REFUSED: the python record is absent: $PY"; exit 2; }
SYN="STDLIB/build/holoklerosis/lie_mg2.synthetic.txt"; rm -f "$SYN"
n=0; miss=0
while IFS= read -r line; do line="${line%$'\r'}"
  case "$line" in "LM-SEVEN "*) ;; *) continue;; esac
  name=$(printf '%s\n' "$line" | sed -E 's/^LM-SEVEN name=([^ ]+) .*/\1/')
  kv(){ printf '%s\n' "$line" | sed -E "s/.* $1=([^ (]+).*/\1/"; }
  typ=$(kv type); d=$(kv d); nn=$(kv n); t3=$(kv t3); t4=$(kv t4); o3=$(kv o3); m4=$(kv m4); c3=$(kv c3exact)
  py=$(grep -m1 -F -- "== $name " "$PY" | tr -d '')   # a FIXED string: the names carry parentheses; the first draft escaped them for grep -E, sed read \  py=$(grep -m1 -E "^== $(printf '%s' "$name" | sed 's/[()]/\&/g') " "$PY" | tr -d '\r') as a literal ampersand, and ten groups missed (05:15)
  if [ -z "$py" ]; then echo "LG-NOTE no python line for $name"; miss=$((miss+1)); continue; fi
  h=$(printf '%s\n' "$py" | sed -E 's/.* h=([^ ]+).*/\1/'); kappa=$(printf '%s\n' "$py" | sed -E 's/.* kappa=([^ ]+).*/\1/'); hk=$(printf '%s\n' "$py" | sed -E 's/.* hk=([^ ]+).*/\1/')
  cert=$(awk -v nm="$name" '$1 == "==" && $2 == nm {f=1; next} f && /CERTIFIED alpha_G < 1 on \[0, / {print; exit}' "$PY" | tr -d '\r')
  [ -n "$cert" ] || { echo "LG-NOTE no certified line for $name"; miss=$((miss+1)); continue; }
  printf '== %s type=%s d=%s n=%s h=%s kappa=%s hk=%s | t3=%s t4=%s o3=%s m4=%s (from lie_moments) c3exact=%s\n%s\n' "$name" "$typ" "$d" "$nn" "$h" "$kappa" "$hk" "$t3" "$t4" "$o3" "$m4" "$c3" "$cert" >> "$SYN"
  n=$((n+1))
done < "$LM"
echo "LG-SYNTHETIC groups=$n missing=$miss source=$LM claims=$PY"
gawk -M -f STDLIB/build/holoklerosis/mg2_cert.awk "$SYN" | tr -d '\r' | sed 's/^MG-/LG-MG-/'
echo "LG-END groups=$n"
