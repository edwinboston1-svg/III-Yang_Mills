#!/bin/bash
# pt.sh ENGINE BETA4 ALPHA4 [extra -v ...]: one certificate point, TABLE mode tag g, page dressing, F0 = 22, full report lines
W="$(cd "$(dirname "$0")" && pwd)"; E="$1"; B="$2"; A="$3"; shift 3
TAB=$(cat "$W/r2tab_g.txt")
AWKPATH="/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/scripts" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v "R2TAB=$TAB" -v DRESS=page -v P="$B" -v Q=10000 -v AN="$A" -v AD=10000 -v F0=22 -v NC22=46816 "$@" -f "$W/$E" 2>&1 | tr -d '\r' | grep -E "KP-CERT|REFUSED"
