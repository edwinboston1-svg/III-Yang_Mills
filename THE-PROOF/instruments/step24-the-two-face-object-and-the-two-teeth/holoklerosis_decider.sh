#!/usr/bin/env bash
# holoklerosis_decider.sh -- ΟΛΟΚΛΗΡΩΣΙΣ Ο15, THE DECIDER'S SECOND ROAD: the author's decider.py (the verdict rule as code, in HEAD)
# re-derived in POSIX shell and gawk -M from the SAME records in HEAD and nothing else -- photon_gauss.2026-11-02b.txt (tooth 1: the
# proper-form ratios r_inf), arms.2026-11-02b.txt (the charged-scalar control, D at p = 0.785 on the largest N present),
# su2_remainder.2026-11-02b/c/d.txt (tooth 2: the shifts beta_eff - beta at (N, m) for the full theory, paired as
# D(p) = shift(N, m/2) - shift(N, m), p = 2 pi m / N, the rows with p <= 0.8, N >= 48, m >= 4).  THE FIT IS EXACT: the three-parameter
# least squares D = D0 + a p^2 + c/(pN)^2 is solved by Cramer's rule on the normal equations in exact rationals with the columns
# [1, (m/N)^2, 1/m^2] -- p = 2 pi m/N carries pi, but a column scaling leaves the intercept D0 unchanged, so D0 needs no pi and no float.
# The same verdict alphabet (CERTIFIED / REFUSED / UNVALIDATED), the same rule: a path speaks only through the theorem's input (a Dobrushin
# row certified through Ο6's door, or KP on L1-Haar activities) AND every tooth; P1 is a calibrator, so its 2.2 reading is UNVALIDATED;
# CERTIFIED is admitted only with a certificate file that passes the door (none exists in HEAD: the P2 speaker is under construction).
# Page DOCS/III-HOLOKLEROSIS-THE-COMPLETION-PREREGISTRATION.md (e6c1349a9), Ο15.
set -u
ROOT="${HLK_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)}"; cd "$ROOT" || exit 9
PC="STDLIB/build/aperanton/photon_carried"; LIB="${HLK_CERT_LIB:-STDLIB/scripts/lib/holoklerosis_cert.awk}"
PG="$PC/photon_gauss.2026-11-02b.txt"; AR="$PC/arms.2026-11-02b.txt"; SR="$PC/su2_remainder.2026-11-02b.txt $PC/su2_remainder.2026-11-02c.txt $PC/su2_remainder.2026-11-02d.txt"
CERT="${HLK_DOBRUSHIN_CERT:-}"
for f in "$PG" "$AR" $SR "$LIB"; do [ -f "$f" ] || { echo "DC-REFUSED: record absent: $f"; echo "DECIDER-VERDICT-AT-2.2: UNVALIDATED (a record absent)"; exit 0; }; done
C1="0.257512"
# --- tooth 1: the proper-form ratios, all within 0.01 of 1; the scalar control's D at p = 0.785 on the largest N, positive
R=$(tr -d '\r' < "$PG" | grep -oE 'r_inf = [0-9.]+ \(c =' | sed 's/r_inf = //; s/ (c =//' | tr '\n' ' ')
T1=$(printf '%s\n' "$R" | gawk -M '{ ok = 1; n = 0; for (i = 1; i <= NF; i++) { n++; d = $i - 1; if (d < 0) d = 0 - d; if (d > 0.01) ok = 0 } print (n > 0 && ok) ? "PASS" : "FAIL", n }')
SC=$(tr -d '\r' < "$AR" | gawk '/^ARM N=/ { split($2, a, "="); N = a[2] + 0 } /p = 0\.785398 \(m [0-9]+ -> [0-9]+\): D =/ { sub(/.*D = */, ""); if (N >= bestN) { bestN = N; best = $1 } } END { print bestN, best }')
SCN=${SC%% *}; SCD=${SC##* }
SCV=$(gawk -M -v d="$SCD" 'BEGIN { print (d > 0) ? "SCREENS" : "DOES-NOT-SCREEN" }')
T1V=${T1%% *}; [ "$SCV" = "SCREENS" ] || T1V=FAIL
echo "DC-T1 ratios=$(echo $R) count=${T1##* } scalar-D(0.785,N=$SCN)=$SCD $SCV verdict=$T1V"
# --- tooth 2: the shifts paired across (N, m) and the exact least squares
cat $SR | tr -d '\r' | gawk '
  /^RUN N=/ { blk = ($0 ~ / spin=1 xi=1 ghosts=True bg=1/); if (blk) { split($2, a, "="); N = a[2] + 0 } }
  blk && /beta_eff - beta =/ { if (!match($0, /m= *[0-9]+/)) next; m = substr($0, RSTART + 2, RLENGTH - 2) + 0; s = $0; sub(/.*beta_eff - beta = */, "", s); sub(/ .*/, "", s); S[N, m] = s; K[N, m] = 1 }
  END { for (k in K) { split(k, a, SUBSEP); N = a[1] + 0; m = a[2] + 0; if (m % 2 == 0 && ((N, m / 2) in K)) printf "%d %d %s %s\n", N, m, S[N, m / 2], S[N, m] } }' | sort -n > "${TMPDIR:-/tmp}/dc_rows.$$"
ROWS="${TMPDIR:-/tmp}/dc_rows.$$"
gawk -M '
  function gcd(a, b,   t) { if (a < 0) a = 0 - a; if (b < 0) b = 0 - b; while (b) { t = a % b; a = b; b = t } return a }
  function rat(s,   i, n, d, k) { # a decimal string -> numerator over 10^k
    neg = (substr(s, 1, 1) == "-"); if (neg) s = substr(s, 2); i = index(s, "."); if (i) { k = length(s) - i; n = substr(s, 1, i - 1) substr(s, i + 1) } else { k = 0; n = s }
    n = n + 0; if (neg) n = 0 - n; return n "/" (10 ^ k) }
  function num(r) { return substr(r, 1, index(r, "/") - 1) + 0 }  function den(r) { return substr(r, index(r, "/") + 1) + 0 }
  function mk(n, d,   g) { if (d < 0) { n = 0 - n; d = 0 - d } g = gcd(n, d); if (!g) g = 1; return (n / g) "/" (d / g) }
  function add(a, b) { return mk(num(a) * den(b) + num(b) * den(a), den(a) * den(b)) }
  function sub2(a, b) { return mk(num(a) * den(b) - num(b) * den(a), den(a) * den(b)) }
  function mul(a, b) { return mk(num(a) * num(b), den(a) * den(b)) }
  function dec(r, dig,   n, d, neg, ip, rem, s, i, q) { n = num(r); d = den(r); neg = 0; if (n < 0) { neg = 1; n = 0 - n } ip = int(n / d); rem = n - ip * d; s = ""
    for (i = 0; i < dig; i++) { rem *= 10; q = int(rem / d); s = s q; rem -= q * d } return (neg ? "-" : "") ip "." s }
  { N = $1; m = $2; p = 2 * 3.141592653589793 * m / N   # the admission filter as decider.py states it (p <= 0.8, N >= 48, N p / 2 pi >= 3.99 i.e. m >= 4): a float only decides admission, never a value
    if (!(p <= 0.8 && N >= 48 && m >= 4)) next
    rows++; D = sub2(rat($3), rat($4)); x1 = mk(m * m, N * N); x2 = mk(1, m * m)
    printf "DC-ROW N=%d m=%d D=%s (%s)\n", N, m, D, dec(D, 6)
    # the normal equations: columns [1, x1, x2]
    A11 = add(A11, "1/1"); A12 = add(A12, x1); A13 = add(A13, x2); A22 = add(A22, mul(x1, x1)); A23 = add(A23, mul(x1, x2)); A33 = add(A33, mul(x2, x2))
    B1 = add(B1, D); B2 = add(B2, mul(x1, D)); B3 = add(B3, mul(x2, D)) }
  BEGIN { A11 = "0/1"; A12 = "0/1"; A13 = "0/1"; A22 = "0/1"; A23 = "0/1"; A33 = "0/1"; B1 = "0/1"; B2 = "0/1"; B3 = "0/1" }
  END { if (rows < 3) { printf "DC-T2 rows=%d verdict=FAIL (too few rows)\n", rows; exit }
    # Cramer: det = |A|, D0 = |A with column 1 replaced by B| / det
    det = sub2(add(mul(A11, sub2(mul(A22, A33), mul(A23, A23))), mul(A13, sub2(mul(A12, A23), mul(A22, A13)))), mul(A12, sub2(mul(A12, A33), mul(A23, A13))))
    d0n = sub2(add(mul(B1, sub2(mul(A22, A33), mul(A23, A23))), mul(A13, sub2(mul(B2, A23), mul(A22, B3)))), mul(A12, sub2(mul(B2, A33), mul(A23, B3))))
    if (num(det) == 0) { printf "DC-T2 rows=%d verdict=FAIL (singular normal equations)\n", rows; exit }
    D0 = mk(num(d0n) * den(det), den(d0n) * num(det))
    diff = add(D0, "257512/1000000"); if (num(diff) < 0) diff = mk(0 - num(diff), den(diff))
    ok = (num(diff) * 100 <= den(diff))   # |D0 + c1| <= 0.01
    printf "DC-T2 rows=%d D0=%s stake=-0.257512 gap=%s verdict=%s\n", rows, dec(D0, 7), dec(diff, 7), (ok ? "PASS" : "FAIL") }' "$ROWS" > "${ROWS}.out"
rm -f "$ROWS"; cat "${ROWS}.out"; T2V=$(grep -oE 'verdict=(PASS|FAIL)' "${ROWS}.out" | tail -1 | cut -d= -f2); rm -f "${ROWS}.out"
# --- the verdict rule
echo "DC-PATH P1 (one loop: photon exact, charged remainder at Gaussian order; a CALIBRATOR, its output a coupling) T1=$T1V T2=$T2V T0=NOT-PASSABLE reading-at-2.2=UNVALIDATED"
if [ -n "$CERT" ] && [ -f "$CERT" ]; then
  out=$(gawk -M -v VERB=DOMINANCE -f "$LIB" "$CERT" 2>&1 | tr -d '\r'); echo "DC-DOOR $out"
  case "$out" in *verdict=CERTIFIED-ROW*) P2V="CERTIFIED (a Dobrushin row through the door)";; *) P2V="REFUSED (the door refused the certificate)";; esac
else P2V="UNVALIDATED (no certificate: the P2 speaker is under construction, HLK_DOBRUSHIN_CERT unset)"; fi
echo "DC-PATH P2 (exact local engine inside, Gaussian exterior integrated, block-averaged coordinates; output = the row with its certificate) T1=NOT-RUN T2=NOT-RUN T0=NOT-RUN reading-at-2.2=$P2V"
case "$P2V" in CERTIFIED*) V=CERTIFIED;; REFUSED*) V=REFUSED;; *) V=UNVALIDATED;; esac
echo "DECIDER-VERDICT-AT-2.2: $V"
