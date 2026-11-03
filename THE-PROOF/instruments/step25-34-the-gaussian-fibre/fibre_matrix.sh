#!/usr/bin/env bash
# fibre_matrix.sh -- THE OBJECT FOR THE CROSSING DEVELOPMENT: the block-averaged fibre's cell operator at the eight cells of fibre_pole.sh,
# exported by fibre_pole.awk's EXPORT mode (FM-OBJECT, 256 FM-J and 256 FM-C lines per cell), each cell followed by its known answers
# from the same run (FP-KAT, FP-DET, FP-COEFFS, FP-QUAD, FP-LAW): the determinant of the FM-C matrix is the FP-COEFFS polynomial, and
# z^2 + 6 z + 1 divides it at Kperp = 0, m = 0.  A stranger re-derives det C(z) from the FM-C lines alone.  usage: bash fibre_matrix.sh > record
set -u
ROOT="${HLK_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)}"; cd "$ROOT" || exit 9
AWK="STDLIB/build/holoklerosis/fibre_pole.awk"
echo "FM-INSTRUMENT $AWK cksum=$(cksum < "$AWK" | cut -d' ' -f1,2)"
cells=0
for cfg in "1 1 1 0 1" "-1 1 1 0 1" "-1 -1 1 0 1" "-1 -1 -1 0 1" "1 1 1 1 4" "1 1 1 1 1" "-1 1 1 1 4" "-1 -1 -1 1 1"; do
  set -- $cfg
  gawk -M -v EXPORT=1 -v E1="$1" -v E2="$2" -v E3="$3" -v MN="$4" -v MD="$5" -f "$AWK" 2>&1 | tr -d '\r' | grep -E '^FM-|^FP-(KAT|DET|COEFFS|QUAD|LAW) '
  cells=$((cells+1))
done
echo "FM-END cells=$cells entries-per-cell=256 (FM-J) + 256 (FM-C)"
