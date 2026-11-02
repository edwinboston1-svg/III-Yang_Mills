#!/bin/bash
# run_twist: the centre-twist distinguishability T of the coarse pair's law on every dump, at rule degrees 32 and 40, Richardson-extrapolated
# (the |.| kink converges as 1/nth^2: nth = 17, 21), beside rho from l2dob; the leading-mode identity rho/T = 9 pi^2/64 = 1.387913.
W="$(cd "$(dirname "$0")" && pwd)"; cd "$W" || exit 1
D="/c/Users/Edwin Boston/OneDrive/Desktop/III/STDLIB/build/aperanton/surface-gas"; R="$W/../rec/twist"; mkdir -p "$R"; export OMP_NUM_THREADS=${OMP_NUM_THREADS:-8}
for f in "$D/dob_n2_W2L2_planar_ordered.txt" "$D/dob_n2_W2L2_planar_cancel.txt" "$D/dob_n4_W2L2_planar_ordered.txt" "$D/dob_n4_W2L2_planar_cancel.txt" "$D/dob_n4_W3L2_cancel.txt" "$W/../rec/w4/dob_n4_W3L1_planar_ordered.txt" "$@"; do
  [ -f "$f" ] || f2="$D/dob/$(basename "$f")"; [ -f "$f" ] || { [ -f "$f2" ] && f="$f2" || { echo "missing $f"; continue; }; }
  b=$(basename "$f" .txt); ./twist.exe "$f" 32 > "$R/$b.t32.txt" 2>&1; ./twist.exe "$f" 40 > "$R/$b.t40.txt" 2>&1
  rho=$(./l2dob.exe "$f" 30 20 12 2>/dev/null | grep L2DOB-RESULT | sed -E 's/.*rhoA=([0-9.]+).*Cgrid=([0-9.]+).*/\1 \2/')
  awk -v b="$b" -v rc="$rho" 'FNR==1 { f++ } /^TWIST / { for (i = 1; i <= NF; i++) { if ($i == "T_conn(A)") tc[f] = $(i+2); if ($i == "T_full(A)") tf[f] = $(i+2); if ($i == "int|c|") ic[f] = $(i+2) } }
    END { split(rc, r, " "); n1 = 17; n2 = 21; e = n1*n1/(n2*n2 - n1*n1); Tc = tc[2] + (tc[2]-tc[1])*e; Tf = tf[2] + (tf[2]-tf[1])*e; Ic = ic[2] + (ic[2]-ic[1])*e;
      printf "%-34s rho=%s C=%s | T_conn(A) %.9f (deg32 %.9f, deg40 %.9f) T_full(A) %.9f odd/all %.4f | rho/T_conn %.4f (leading 1.3879) C/T_conn %.4f (leading 2.3562)\n", b, r[1], r[2], Tc, tc[1], tc[2], Tf, Tc/Ic, r[1]/Tc, r[2]/Tc }' "$R/$b.t32.txt" "$R/$b.t40.txt"
done
echo RUN-TWIST-DONE
