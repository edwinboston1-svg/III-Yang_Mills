#!/bin/bash
# run_u1: THE ABELIAN CONTROL BESIDE THE SU(2) SPIN-CAP LADDER -- U(1)'s plaquette-charge-cap ladder at two steps (n = 4, planar), NMAX = 1..4
# with LMAX = NMAX (a loop charge above NMAX has no flux to carry it: its moments vanish identically), at beta = 1.2 (Coulomb) and 0.9 (confined),
# the ordered and the cancelling data; NMAX = 6 is M2's record. Every record read by M2's reader l2dob.
W="$(cd "$(dirname "$0")" && pwd)"; cd "$W" || exit 1
R="$W/../rec/u1"; mkdir -p "$R"; export OMP_NUM_THREADS=8
for b in 1.2 0.9; do for d in ordered cancel; do for N in 1 2 3 4; do
  tag="u1_n4_b${b}_N${N}_L${N}_${d}"; S=$(date +%s)
  ./w2_u1.exe $b $N $N $d planar 4 > "$R/$tag.txt" 2>&1; rc=$?
  ./l2dob.exe "$R/$tag.txt" > "$R/$tag.l2.txt" 2>&1
  echo "$tag rc=$rc $(( $(date +%s) - S )) s: $(grep -E 'L2DOB-U1' "$R/$tag.l2.txt" | sed -E 's/.*(rhoA=[0-9.e+-]+).*(Cgrid=[0-9.e+-]+).*/\1 \2/')"
done; done; done
echo RUN-U1-DONE
