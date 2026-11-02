#!/bin/bash
# run1.sh ENGINE DRESS P AN F0 [extra -v args...]: one point of the certificate, TABLE mode with the tag-g table
W="$(cd "$(dirname "$0")" && pwd)"; E="$1"; D="$2"; P="$3"; AN="$4"; F0="$5"; shift 5
TAB=$(cat "$W/r2tab_g.txt")
AWKPATH="/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/scripts" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v "R2TAB=$TAB" -v DRESS="$D" -v P="$P" -v Q=10000 -v AN="$AN" -v AD=10000 -v F0="$F0" -v NC22=46816 "$@" -f "$W/$E" 2>&1 | tr -d '\r' | grep -E "KP-CERT dress|M1-TAIL|M1-UNCOND|REFUSED"
