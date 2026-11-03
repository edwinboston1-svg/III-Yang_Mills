#!/bin/bash
# cei_build.sh -- builds cei_face.c from EI's w2e.c (the instruments record) and the three fragments by cei_insert.awk, then cei_face.exe.
# Run from this directory: bash cei_build.sh [path/to/w2e.c]
set -u
SRC="${1:-../instruments/2026-11-02/math/EI/code/w2e.c}"
[ -f "$SRC" ] || { echo "cei_build: no w2e.c at $SRC"; exit 2; }
gawk -v DECL=cei_decl.c -v FUNCS=cei_funcs.c -v DRIVER=cei_driver.c -f cei_insert.awk "$SRC" > cei_face.c || exit 3
OUT="${2:-cei_face.exe}"
gcc -O2 -fopenmp -o "$OUT" cei_face.c -lm && echo "$OUT built from $SRC"
