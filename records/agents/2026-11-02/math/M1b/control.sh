#!/bin/bash
# control.sh: the engine control of WORK.md section 5 (P-a, P-b): m1 U12 vs m1b U12 vs m1b UPQ(1,2,1) at beta 0.3650, 0.3652, alpha 0.0045
W="$(cd "$(dirname "$0")" && pwd)"; cd "$W"
COM="-v EVENTAIL=1 -v UNCOND=1 -v NCSIG=1"
echo "START $(date '+%Y-%m-%d %H:%M:%S') m1=$(md5sum kp_cert_m1.awk | cut -c1-32) m1b=$(md5sum kp_cert_m1b.awk | cut -c1-32)"
for b in 3650 3652; do
  echo "== beta=0.$b alpha=0.0045"
  ./pt.sh kp_cert_m1.awk $b 45 $COM -v U12=1 > ctl_a_$b.txt
  ./pt.sh kp_cert_m1b.awk $b 45 $COM -v U12=1 > ctl_b_$b.txt
  ./pt.sh kp_cert_m1b.awk $b 45 $COM -v UPQ=1 -v UPN=1 -v UPD=2 -v UC0=1 > ctl_c_$b.txt
  echo "[a] m1 U12:"; cat ctl_a_$b.txt
  if cmp -s ctl_a_$b.txt ctl_b_$b.txt; then echo "[b] m1b U12: CHARACTER-IDENTICAL to [a]"; else echo "[b] m1b U12: DIFFERS"; cat ctl_b_$b.txt; fi
  if cmp -s ctl_a_$b.txt ctl_c_$b.txt; then echo "[c] m1b UPQ(1,2,1): CHARACTER-IDENTICAL to [a]"; else echo "[c] m1b UPQ(1,2,1): DIFFERS"; cat ctl_c_$b.txt; fi
done
echo "END $(date '+%Y-%m-%d %H:%M:%S')"
