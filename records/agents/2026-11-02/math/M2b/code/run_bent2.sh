#!/bin/bash
# run_bent2: THE TRUE BENT ROW AT TWO STEPS (n = 4, W2L2, corners as cycles), the cancelling then the ordered datum, read by l2dob, the twist
# reader and the SO(3) channel; the planar two-step W2L2 values are M2's records (0.015210922 ordered, 0.017433784 cancelling).
W="$(cd "$(dirname "$0")" && pwd)"; cd "$W" || exit 1
R="$W/../rec/bent2"; mkdir -p "$R"
export OMP_NUM_THREADS=12 W2_SLICE=full W2_LEAN=1 W2_NOSNAP=1 W2_WEIGHT0=1 W2_DUMPF=1 W2_CORNER=1
for d in cancel ordered; do tag=bent_n4_W2L2_$d; echo "== $tag start $(date '+%H:%M:%S')"
  ./w2c.exe 2.2 2 2 $d fwd bent 4 > "$R/$tag.txt" 2>&1; echo "   rc=$? end $(date '+%H:%M:%S') $(grep -E 'M2b peak|W2-DONE' "$R/$tag.txt" | tr '\n' ' ')"
  OMP_NUM_THREADS=8 ./l2dob.exe "$R/$tag.txt" 30 20 12 > "$R/$tag.l2.txt" 2>&1; OMP_NUM_THREADS=8 ./twist.exe "$R/$tag.txt" 32 > "$R/$tag.t32.txt" 2>&1
  awk '/^W2-F / { split($2,A,"="); split($3,C,"="); if (A[2]%2==0 && C[2]%2==0) print; next } { print }' "$R/$tag.txt" > "$R/${tag}_so3.txt"; OMP_NUM_THREADS=8 ./l2dob.exe "$R/${tag}_so3.txt" 30 20 12 > "$R/${tag}_so3.l2.txt" 2>&1
  echo "   $(grep -E 'L2DOB-RESULT|REFUS' "$R/$tag.l2.txt" | head -1 | sed -E 's/.*(rhoA=[0-9.e+-]+).*(Cgrid=[0-9.e+-]+).*/\1 \2/')  SO3 $(grep -E 'L2DOB-RESULT|REFUS' "$R/${tag}_so3.l2.txt" | head -1 | sed -E 's/.*(rhoA=[0-9.e+-]+).*/\1/')  E=$(grep 'W2-CLASS a=1 c=0' "$R/$tag.txt" | sed -E 's/.*= ([+0-9.e-]+) .*/\1/')  $(grep '^TWIST ' "$R/$tag.t32.txt" | sed -E 's/.*(T_conn\(A\) = [0-9.]+).*/\1/')"
done
echo RUN-BENT2-DONE $(date '+%H:%M:%S')
