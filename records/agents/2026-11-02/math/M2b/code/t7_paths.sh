#!/bin/bash
# t7 (the advisor's blocking items): the production path (sliced, LEAN, NOSNAP, WEIGHT0) on the NEW geometries against the unsliced sweep;
# Lemma 0.1 checked on the new geometries with full slices (no WEIGHT0: the nonzero-weight entries must be at roundoff); the frame's
# weight-level check, the reversed order against the forward one (unsliced). w2c.exe = w2f.c with the corner code (frames identical).
W="$(cd "$(dirname "$0")" && pwd)"; cd "$W" || exit 1
T="$W/../rec/t7"; mkdir -p "$T"; export OMP_NUM_THREADS=6 W2_DUMPF=1
cmpF() { awk 'NR==FNR { if ($1=="W2-F") { k=$2" "$3" "$4" "$5" "$6" "$7; re[k]=$8; im[k]=$9; if ((t=($8<0?-$8:$8))>mx) mx=t } next }
  $1=="W2-F" { k=$2" "$3" "$4" "$5" "$6" "$7; d=$8-re[k]; if (d<0) d=-d; e=$9-im[k]; if (e<0) e=-e; if (d+e>dm) dm=d+e; n++ }
  END { printf "  %d entries, max |dF| relative to max|F| = %.3e\n", n, dm/mx }' "$1" "$2"; }
w0() { awk '/^W2-F / { split($4,R,"="); split($5,Q,"="); split($6,RP,"="); split($7,QP,"="); v=sqrt($8*$8+$9*$9); if (v>mx) mx=v; if ((R[2]-Q[2])+(RP[2]-QP[2])!=0 && v>nz) nz=v } END { printf "  Lemma 0.1: largest nonzero-weight entry / largest entry = %.3e\n", nz/mx }' "$1"; }
P="W2_SLICE=full W2_LEAN=1 W2_NOSNAP=1 W2_WEIGHT0=1"
cell() { local name=$1; shift; echo "== $name"
  env "$@" ./w2c.exe > "$T/u.txt" 2>&1 < /dev/null
  echo " production path against unsliced:"; env $P "$@" ./w2c.exe > "$T/p.txt" 2>&1; cmpF "$T/u.txt" "$T/p.txt"
  echo " full slices (no WEIGHT0) against unsliced, and Lemma 0.1:"; env W2_SLICE=full "$@" ./w2c.exe > "$T/f.txt" 2>&1; cmpF "$T/u.txt" "$T/f.txt"; w0 "$T/f.txt"; }
# env with the engine's arguments after the variables: build the calls explicitly
run_cell() { local name=$1 vars=$2 args=$3; echo "== $name"
  env $vars ./w2c.exe $args > "$T/u.txt" 2>&1
  echo " production path against unsliced:"; env $vars $P ./w2c.exe $args > "$T/p.txt" 2>&1; cmpF "$T/u.txt" "$T/p.txt"
  echo " full slices (no WEIGHT0) against unsliced, and Lemma 0.1:"; env $vars W2_SLICE=full ./w2c.exe $args > "$T/f.txt" 2>&1; cmpF "$T/u.txt" "$T/f.txt"; w0 "$T/f.txt"; }
run_cell "frame 1,1,0,0 n=2 W2L2 cancel" "W2_FRAME=1,1,0,0" "2.2 2 2 cancel fwd planar 2"
run_cell "frame 1,1,0,0 n=2 W2L2 ordered" "W2_FRAME=1,1,0,0" "2.2 2 2 ordered fwd planar 2"
run_cell "frame 1,0,0,0 n=4 W2L1 cancel (two steps)" "W2_FRAME=1,0,0,0" "2.2 2 1 cancel fwd planar 4"
run_cell "corner n=2 W2L2 cancel" "W2_CORNER=1" "2.2 2 2 cancel fwd bent 2"
run_cell "corner n=2 W2L2 ordered" "W2_CORNER=1" "2.2 2 2 ordered fwd bent 2"
run_cell "corner n=4 W2L1 cancel (two steps)" "W2_CORNER=1" "2.2 2 1 cancel fwd bent 4"
echo "== the frame's weight-level check: reversed order against forward, unsliced (n=2 W2L2, frame 1,1,0,0 and 1,1,1,1; random datum)"
for fr in 1,1,0,0 1,1,1,1; do W2_FRAME=$fr ./w2c.exe 2.2 2 2 random:5 fwd planar 2 > "$T/fw.txt" 2>&1; W2_FRAME=$fr ./w2c.exe 2.2 2 2 random:5 rev planar 2 > "$T/rv.txt" 2>&1; echo " frame $fr:"; cmpF "$T/fw.txt" "$T/rv.txt"; done
echo "== the corner's weight-level check: reversed order (unsliced, n=2 W2L2 corner, random datum)"
W2_CORNER=1 ./w2c.exe 2.2 2 2 random:5 fwd bent 2 > "$T/fw.txt" 2>&1; W2_CORNER=1 ./w2c.exe 2.2 2 2 random:5 rev bent 2 > "$T/rv.txt" 2>&1; cmpF "$T/fw.txt" "$T/rv.txt"
echo T7-DONE
