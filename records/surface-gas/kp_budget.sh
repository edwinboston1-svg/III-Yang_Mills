#!/bin/bash
# kp_budget.sh -- THE EXIT BUDGET epsilon(beta) (the far shore section 10; the trunk seat, 2026-11-01 02:5x EST): at each coupling of
# the strong-coupling disk and each rate alpha, the largest per-plaquette tilt (every character coefficient a_j multiplied by e^{tilt},
# every polymer's weight by e^{tilt |X|}) under which the certified Kotecky-Preiss inequality of the flux-surface gas still PASSES --
# bisected on the grid 1/100 from [0, 3]; the TABLE mode of record (GRADED=1, R2TAB from the table record of the named tag), the page
# dressing (the paper's number) unless DRESS says otherwise.  Known answer: epsilon = 0 at beta* = 0.4764 (the number is the boundary);
# sighted control: a tilt above epsilon refuses.  One line per (beta, alpha), line-buffered.
# usage: kp_budget.sh <table tag, e.g. 2026-10-31g> <out> [DRESS=page] [ALPHAS="1 4"] [BETAS="500 1000 ... 4764"]
set -u
ROOT="/c/Users/Edwin Boston/OneDrive/Desktop/III"; A="$ROOT/STDLIB/build/aperanton"; C="$ROOT/STDLIB/scripts/aperanton_kp_cert.awk"; d="$ROOT/STDLIB/scripts"
TAG="${1:?table tag}"; OUT="${2:?out}"; DRESS="${3:-page}"; ALPHAS="${4:-1 4}"; BETAS="${5:-500 1000 1500 2000 2500 3000 3500 4000 4500 4764}"
cd "$ROOT" || exit 9
TAB=$(grep '^R2TAB=' "$A/local_tail_table.$TAG.txt" | sed 's/^R2TAB=//'); [ -n "$TAB" ] || { echo "REFUSED: no R2TAB in local_tail_table.$TAG.txt"; exit 2; }
verdict(){ # beta(1e-4) alpha(1e-3) tiltN (1/100)
  AWKPATH="$d" gawk -M -v BESSEL_LIB=1 -v GRADED=1 -v "R2TAB=$TAB" -v DRESS="$DRESS" -v P="$1" -v Q=10000 -v AN="$2" -v AD=1000 -v GN=6 -v GD=1 -v F0=20 -v TILTN="$3" -v TILTD=100 -f "$C" 2>&1 | tr -d '\r' | grep -o -E ' -> (PASS|FAIL)' | tail -1 | tr -d ' ->'
}
{ echo "# kp_budget.sh tag=$TAG dress=$DRESS mode=TABLE(GRADED=1,R2TAB) F0=20; tilt on the 1/100 grid; $(date '+%Y-%m-%d %H:%M:%S %Z')"
  for b in $BETAS; do for a in $ALPHAS; do
    v0=$(verdict "$b" "$a" 0); if [ "$v0" != "PASS" ]; then echo "KP-BUDGET beta=$b/10000 alpha=$a/1000: NO-PASS at tilt 0 ($v0)"; continue; fi
    lo=0; hi=300; vh=$(verdict "$b" "$a" "$hi")
    if [ "$vh" = "PASS" ]; then echo "KP-BUDGET beta=$b/10000 alpha=$a/1000: epsilon >= 3.00 (PASS at the ceiling 300/100)"; continue; fi
    while [ $((hi - lo)) -gt 1 ]; do mid=$(( (lo + hi) / 2 )); v=$(verdict "$b" "$a" "$mid"); if [ "$v" = "PASS" ]; then lo=$mid; else hi=$mid; fi; done
    echo "KP-BUDGET beta=$b/10000 alpha=$a/1000: epsilon in [$lo/100, $hi/100) (PASS at $lo/100, refused at $hi/100) $(date '+%H:%M:%S')"
  done; done
  echo "# END $(date '+%Y-%m-%d %H:%M:%S %Z')"; } > "$OUT"
