#!/bin/bash
# M7b certificate harness: HEAD 88e069862's aperanton_kp_cert.awk (md5 7aea522c...) and its Bessel library, both copied into code/
# usage: cert.sh MODE COEF [extra -v args...]   MODE = local (LOCAL=1 R2TAB page, alpha scanned 1..80 e-4) | graded (GRADED=1 R2TAB page alpha=1/1000)
cd "$(dirname "$0")"; TAB="$(cat R2TAB.txt)"; MODE=$1; C=$2; shift 2
if [ "$MODE" = local ]; then
  AWKPATH=. gawk -M -v BESSEL_LIB=1 -v LOCAL=1 -v "R2TAB=$TAB" -v DRESS=page -v SCAN=1 -v BETA0=4764 -v BETA1=4764 -v AK0=1 -v AK1=80 -v F0=20 -v COEF="$C" "$@" -f kp_cert.HEAD.awk 2>&1 | tr -d '\r' | grep -E 'KP-CERT (SCAN dress|REFUSED)' | head -1
else
  AWKPATH=. gawk -M -v BESSEL_LIB=1 -v GRADED=1 -v "R2TAB=$TAB" -v DRESS=page -v P=4764 -v Q=10000 -v AN=1 -v AD=1000 -v GN=6 -v GD=1 -v F0=20 -v COEF="$C" "$@" -f kp_cert.HEAD.awk 2>&1 | tr -d '\r' | grep -E 'KP-CERT (dress|REFUSED)' | tail -1
fi
