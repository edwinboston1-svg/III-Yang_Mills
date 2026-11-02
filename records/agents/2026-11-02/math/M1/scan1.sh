#!/bin/bash
# scan1.sh ENGINE DRESS F0 BETA0 BETA1 AK0 AK1 OUT [extra -v ...]: the engine's SCAN mode (beta step 2e-4, alpha step 1e-4)
W="$(cd "$(dirname "$0")" && pwd)"; E="$1"; D="$2"; F0="$3"; B0="$4"; B1="$5"; K0="$6"; K1="$7"; OUT="$8"; shift 8
TAB=$(cat "$W/r2tab_g.txt")
{ echo "START $(date '+%Y-%m-%d %H:%M:%S') engine=$E md5=$(md5sum "$W/$E" | cut -c1-32) dress=$D F0=$F0 beta=[$B0,$B1] alpha=[$K0,$K1] extra=$*"
  AWKPATH="/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/scripts" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v "R2TAB=$TAB" -v DRESS="$D" -v SCAN=1 -v BETA0="$B0" -v BETA1="$B1" -v AK0="$K0" -v AK1="$K1" -v F0="$F0" -v NC22=46816 "$@" -f "$W/$E" 2>&1 | tr -d '\r'
  echo "END $(date '+%Y-%m-%d %H:%M:%S')"; } > "$W/$OUT"
grep "beta\* =" "$W/$OUT"
