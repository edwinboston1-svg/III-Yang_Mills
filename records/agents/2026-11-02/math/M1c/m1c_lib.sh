#!/bin/bash
# m1c_lib.sh -- M1c's drivers (2026-11-02); sourced, never edited while a run reads it. gawk -M, the 2^-128 grid, AWKPATH = III STDLIB/scripts (read only).
W="/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/M1c"
M1="/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math/M1"
AWKP="/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/scripts"
TAB=$(cat "$W/r2tab_g.txt")
point() { local E="$1" B="$2" A="$3" D="$4" F="$5"; shift 5
  AWKPATH="$AWKP" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v "R2TAB=$TAB" -v DRESS="$D" -v P="$B" -v Q=10000 -v AN="$A" -v AD=10000 -v F0="$F" -v NC22=46816 "$@" -f "$E" 2>&1 | tr -d '\r' | grep "KP-CERT"; }
scan1() { local E="$1" B="$2" D="$3" F="$4"; shift 4
  AWKPATH="$AWKP" gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v "R2TAB=$TAB" -v DRESS="$D" -v SCAN=1 -v BETA0="$B" -v BETA1="$B" -v AK0=10 -v AK1=120 -v F0="$F" -v NC22=46816 "$@" -f "$E" 2>&1 | tr -d '\r' | grep "KP-CERT SCAN.*beta=0\.$(printf %04d $B) "; }
stamp() { echo "$1 $(date '+%Y-%m-%d %H:%M:%S')"; }
