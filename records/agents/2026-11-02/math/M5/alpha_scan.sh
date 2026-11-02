#!/bin/bash
# M5 alpha_scan.sh -- S4' / S3' (ADDED AFTER the section-1b stakes, labelled so): the verdicts of section 1b were read at alpha = 1/1000, the
# gate's coefficient-mode choice; near the edge the certificate's own alpha matters (the table mode passes at 0.4764 only for alpha in
# [0.0041, 0.0047]).  Here alpha is scanned over AK in {1,2,5,10,20,30,40,47,55,65,80} (units 1e-4) and the PASS set is printed, for:
#   (i)   the record's two-step call as printed (WALL 0.30 / 0.34);
#   (ii)  the wall floor of the FOUR COPLANAR pairs only, a'_1 + 4 s_one / 3 (the geometry actually read), HALF as recorded;
#   (iii) H1 at the planar r (WALL off);
#   (iv)  the one-plaquette part alone (WALL off, no dressing) -- the control that must pass.
ROOT="/c/Users/Edwin Boston/OneDrive/Desktop/III"; W="$(cd "$(dirname "$0")" && pwd)"
scan() { # $1 datum $2 dress, then overrides
  local d="$1" m="$2"; shift 2; local pass=""; local last=""
  for ak in 1 2 5 10 20 30 40 47 55 65 80; do out="$(bash "$W/cert_runs.sh" CALL $d $m $ak 10000 "$@")"
    if echo "$out" | grep -q -- '-> PASS'; then pass="$pass $ak"; else last="$(echo "$out" | sed 's/.*-> //')"; fi; done
  [ -n "$pass" ] && echo "PASS at alpha (1e-4):$pass" || echo "NO PASS for alpha in [1, 80]e-4 (last: $last)"; }
for d in ordered cancel; do
  F="$ROOT/STDLIB/build/aperanton/surface-gas/w2n4_W2L2_modes.2026-11-01a.$d.txt"
  L="$(grep '^W2-CERT-CALL' "$F" | tr -d '\r')"; COEF="$(echo "$L" | sed 's/.*COEF=\([^ ]*\).*/\1/')"; A1="${COEF%%/*}"; REST="${COEF#*,}"
  A2="${REST%%/*}"; SONE="$(grep '^W2-SHARES' "$F" | tr -d '\r' | sed 's/.*s_one = \([^ ]*\).*/\1/')"
  R="$(grep '^W2-MODE a=1 c=1 ' "$F" | tr -d '\r' | sed 's/.*ratio=\([^ ]*\).*/\1/')"
  W4="$(gawk -M -v a2="$A2" -v s="$SONE" 'BEGIN { printf "%d", a2 + 4 * s / 3 * 1e12 + 0.5 }')"
  NA="$(gawk -M -v a="$A1" -v r="$R" 'BEGIN { printf "%d", a * (1 + 2 * r) + 0.5 }')"
  for m in page local; do
    echo "S3'(i)  $d $m record call: $(scan $d $m)"
    echo "S3'(ii) $d $m coplanar wall floor $W4 e-12: $(scan $d $m WALLN=$W4)"
    echo "S4'(iii) $d $m H1 at r=$R (u-coef $NA e-12): $(scan $d $m WALLN=0 "COEF=$NA/1000000000000,$REST")"
    echo "S4'(iv) $d $m one-plaquette part alone: $(scan $d $m WALLN=0)"
  done
done
