#!/bin/bash
cd "$(dirname "$0")"
OUT=rec/photon.2026-11-02a.txt
: > $OUT
for L in 2 4 8 16; do for map in H A; do for dir in 0 3; do
  ./photon.exe $L $map 256 $((L/2)) $dir 2>/dev/null | grep -E "^PHOTON" | tee -a $OUT
done; done; done
