#!/bin/bash
# run_frame2: THE FRAME EXTENT VARIED (the review's law 2-quater point): n = 2 W2L2 at beta = 2.2, ordered and cancelling, with one row above
# (1,0,0,0) and all four sides (1,1,1,1) integrated, beside the records' (1,1,0,0). Same flags, binary and readers as run_frame.sh.
# Stakes SF1, SF2 and the KILL: WORK.md section 7.7, written before this run.
W="$(cd "$(dirname "$0")" && pwd)"; cd "$W" || exit 1
R="$W/../rec/frame"; mkdir -p "$R"
export OMP_NUM_THREADS=8 W2_SLICE=full W2_LEAN=1 W2_NOSNAP=1 W2_WEIGHT0=1 W2_DUMPF=1
readall() { local f=$1; ./l2dob.exe "$f" 30 20 12 > "${f%.txt}.l2.txt" 2>&1
  awk '/^W2-F / { split($2,A,"="); split($3,C,"="); if (A[2]%2==0 && C[2]%2==0) print; next } { print }' "$f" > "${f%.txt}_so3.txt"
  ./l2dob.exe "${f%.txt}_so3.txt" 30 20 12 > "${f%.txt}_so3.l2.txt" 2>&1
  echo "   full: $(grep L2DOB-RESULT "${f%.txt}.l2.txt" | sed -E 's/.*(rhoA=[0-9.e+-]+).*(Cgrid=[0-9.e+-]+).*/\1 \2/')  SO3: $(grep -E 'L2DOB-RESULT|REFUS' "${f%.txt}_so3.l2.txt" | head -1 | sed -E 's/.*(rhoA=[0-9.e+-]+).*/\1/')  E[chi_1/2(A)]: $(grep 'W2-CLASS a=1 c=0' "$f" | sed -E 's/.*= ([+0-9.e-]+) .*/\1/')  census: $(grep -E 'L2DOB-CENSUS' "${f%.txt}.l2.txt" | sed -E 's/.*(min [0-9.e+-]+, negative at [0-9]+).*/\1/')"; }
run() { local tag=$1 fr=$2; shift 2; echo "== $tag (frame $fr) start $(date '+%H:%M:%S')"; W2_FRAME=$fr ./w2f.exe "$@" > "$R/$tag.txt" 2>&1; echo "   rc=$? end $(date '+%H:%M:%S') $(grep -E 'M2b peak|W2-DONE' "$R/$tag.txt" | tr '\n' ' ')"; readall "$R/$tag.txt"; }
for d in ordered cancel; do
  run fr_n2_W2L2_top_$d 1,0,0,0 2.2 2 2 $d fwd planar 2
  run fr_n2_W2L2_all_$d 1,1,1,1 2.2 2 2 $d fwd planar 2
done
echo RUN-FRAME2-DONE $(date '+%H:%M:%S')
