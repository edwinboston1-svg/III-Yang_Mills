#!/bin/bash
# ordsub_build.sh -- builds ordsub.c from EI's ordcost.c (the instruments record) and the two fragments, then ordsub.exe.  Run from this directory.
set -u
SRC="${1:-../instruments/2026-11-02/math/EI/code/ordcost.c}"
[ -f "$SRC" ] || { echo "ordsub_build: no ordcost.c at $SRC"; exit 2; }
gawk -v FRAG=ordsub_frag.c -v CALL=ordsub_call.c '
/^static void push\(int x, int y, int z, int d\) \{ int l = lk\(x, y, z, d\);/ { sub(/int l = lk\(x, y, z, d\);/, "int b_[4] = { x, y, z, 0 }; int l = lkey(b_, d, 0); if (l < 0) return;   /* ordsub: an eliminated link is skipped */"); print; next }
/^int main\(int argc, char \*\*argv\) \{/ { while ((getline line < FRAG) > 0) print line; close(FRAG); print; next }
/^  build\(\); int ncorn = NC - NP - 2;/ { print; while ((getline line < CALL) > 0) print line; close(CALL); next }
{ print }' "$SRC" > ordsub.c && gcc -O2 -o ordsub.exe ordsub.c -lm && echo "ordsub.exe built from $SRC"
