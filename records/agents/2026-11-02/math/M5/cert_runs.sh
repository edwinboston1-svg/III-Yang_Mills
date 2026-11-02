#!/bin/bash
# M5 cert_runs.sh -- the two-step exit call of the record, run (stakes K0, K1, S1-S4 in WORK.md section 1b, written before this file).
# The engine is read from III's tree read-only; every output lands in rec/ here.
ROOT="/c/Users/Edwin Boston/OneDrive/Desktop/III"
CERT="$ROOT/STDLIB/build/aperanton/kp_cert_table_wip.awk"
W="$(cd "$(dirname "$0")" && pwd)"; R="$W/rec"; mkdir -p "$R"
TAB="$(grep -h '^R2TAB=' "$ROOT/STDLIB/build/aperanton/table_gate/table.run" | head -1 | sed 's/^R2TAB=//')"
cert() { AWKPATH="$ROOT/STDLIB/scripts" gawk -M -v BESSEL_LIB=1 "$@" -f "$CERT" 2>&1 | tr -d '\r'; }
coefr() { gawk -M -v PREC=256 -v B="$1" 'function I(n,x,  k,t,s){t=(x/2)^n; for(k=1;k<=n;k++) t/=k; s=t; for(k=0;k<400;k++){t*=(x/2)*(x/2)/((k+1)*(k+n+1)); s+=t} return s} BEGIN{b=B+0; for(j2=1;j2<=16;j2++){r=I(j2+1,b)/I(1,b); printf "%s%d/1000000000000000000000000000000", (j2>1?",":""), int(r*1e30)}}'; }
MODE="$1"
case "$MODE" in
  K0) C="$(coefr 0.25)"; cert -v DRESS=page -v P=2500 -v Q=10000 -v AN=1 -v AD=1000 -v GN=6 -v GD=1 -v F0=20 -v COEF="$C" | tail -1 ;;
  K1) C="$(coefr 0.4764)"
      echo "COEF+LOCAL:"; cert -v LOCAL=1 -v "R2TAB=$TAB" -v DRESS=page -v P=4764 -v Q=10000 -v AN=44 -v AD=10000 -v F0=20 -v COEF="$C" | tail -1
      echo "TABLE MODE:"; cert -v LOCAL=1 -v "R2TAB=$TAB" -v DRESS=page -v P=4764 -v Q=10000 -v AN=44 -v AD=10000 -v F0=20 | tail -1 ;;
  CALL) # $2 = datum (ordered|cancel), $3 = dress options tag (page|local), $4 = AN, $5 = AD, then optional overrides as NAME=VALUE
      D="$2"; DRS="$3"; XAN="$4"; XAD="$5"; F="$ROOT/STDLIB/build/aperanton/surface-gas/w2n4_W2L2_modes.2026-11-01a.$D.txt"
      L="$(grep '^W2-CERT-CALL' "$F" | tr -d '\r')"
      COEF="$(echo "$L" | sed 's/.*COEF=\([^ ]*\).*/\1/')"; HN="$(echo "$L" | sed 's/.*HALFN=\([0-9]*\).*/\1/')"; WN="$(echo "$L" | sed 's/.*WALLN=\([0-9]*\).*/\1/')"
      shift 5; for kv in "$@"; do case "$kv" in COEF=*) COEF="${kv#COEF=}";; HALFN=*) HN="${kv#HALFN=}";; WALLN=*) WN="${kv#WALLN=}";; esac; done
      if [ "$DRS" = "local" ]; then OPT=(-v LOCAL=1 -v "R2TAB=$TAB"); else OPT=(-v GN=6 -v GD=1); fi
      cert "${OPT[@]}" -v DRESS=page -v P=1 -v Q=1 -v AN="$XAN" -v AD="$XAD" -v F0=20 -v COEF="$COEF" -v HALFN="$HN" -v HALFD=1000000000000 -v WALLN="$WN" -v WALLD=1000000000000 | tail -1 ;;
  *) echo "usage: cert_runs.sh K0|K1|CALL datum page|local AN AD [COEF=..] [HALFN=..] [WALLN=..]"; exit 2 ;;
esac
