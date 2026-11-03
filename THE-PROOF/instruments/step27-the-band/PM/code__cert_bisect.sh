#!/bin/bash
# cert_bisect.sh A12N [STEPS] -- THE WALL CEILING OF THE COMMITTED CERTIFICATE (copy: kp_cert.awk, sha b17b8d37..., = MIR's = III HEAD's
# aperanton_kp_cert.awk) RE-BISECTED AT THE MONTE CARLO COEFFICIENTS (PM, 2026-11-02): COEF = a'_1/2 = A12N/10^12, a'_1 = 0 (the true value is
# >= 0 by Lemma D2 and read at -1.4e-7 +- 3.2e-7; the certificate refuses a negative entry by name), every higher entry 0; HALFN = 1 (the
# measured half factor 1 + 16 r_mod differs from 1 below 10^-7); GRADED, page dressing, alpha = 1/1000, the beta slot 0.4764 -- MIR's cert1.sh
# call, unchanged.  Bisects WALLN/10^12 in [lo, hi] = [0.010, 0.025] for the PASS/FAIL edge, printing every probe.
D="$(cd "$(dirname "$0")" && pwd)"; cd "$D"; TAB="$(cat R2TAB.txt)"; A12=$1; STEPS=${2:-12}; A1N=${3:-500000}
Z=0/1000000000000; COEF="$A12/1000000000000,$A1N/1000000000000"; for ((j = 3; j <= 16; j++)); do COEF="$COEF,$Z"; done
probe() { AWKPATH="$D" gawk -M -v BESSEL_LIB=1 -v GRADED=1 -v "R2TAB=$TAB" -v DRESS=page -v P=4764 -v Q=10000 -v AN=1 -v AD=1000 -v GN=6 -v GD=1 -v F0=20 \
  -v COEF="$COEF" -v HALFN=0 -v HALFD=1000000000000 -v WALLN="$1" -v WALLD=1000000000000 -f kp_cert.awk 2>&1 | tr -d '\r' | grep -m1 'KP-CERT dress\|REFUSED'; }
echo "CERT-BISECT COEF a_half = $A12/10^12, a_1 = $A1N/10^12 (the spin-1 entry must be positive: the c2 sum divides by it), the rest 0"
echo "CERT-BISECT probe WALL=0: $(probe 0)"
lo=10000000000; hi=25000000000
echo "CERT-BISECT probe lo $lo: $(probe $lo)"; echo "CERT-BISECT probe hi $hi: $(probe $hi)"
for ((k = 0; k < STEPS; k++)); do mid=$(( (lo + hi) / 2 )); r=$(probe $mid); v=$(echo "$r" | grep -o 'PASS\|FAIL' | tail -1)
  echo "CERT-BISECT probe $mid: $v"; if [ "$v" = PASS ]; then lo=$mid; elif [ "$v" = FAIL ]; then hi=$mid; else echo "CERT-BISECT a probe neither passed nor failed: $r"; exit 2; fi; done
echo "CERT-BISECT THE WALL CEILING in [$lo, $hi] / 10^12"
