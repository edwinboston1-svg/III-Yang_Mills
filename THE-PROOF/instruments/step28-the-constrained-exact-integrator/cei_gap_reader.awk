# cei_gap_reader.awk -- THE GAP READER of a transfer-scan record (campaign 31.15 RESULTS 6): the fibre's gap at a datum is the SLOWEST MODE by
# MODULUS, min over m >= 2 of |lambda_1| / |lambda_m| -- the driver's printed `lambda_1/lambda` is real/real, and at a Haar datum the members
# are complex with imaginary parts the size of the real parts (the ordered datum's are 1e-13), so the printed ratio is not the decay rate: the
# modulus is.  Two minima are reported: over ALL modes m >= 2, and over the PHYSICAL ones (weight in the sweep's cut state >= WMIN; exact at
# the ordered datum where a symmetry sector makes it so, with the numerical-zero sector at 1e-13 against the physical 3e-7; at a Haar datum no
# symmetry exists and every mode is physical).  NOT the first physical mode in the chain's order (RESULTS 4's rule, corrected here: the Wielandt
# chain's unconverged members come out in no order, so at W3 random:2 it reported mode 2 at 53.5 while mode 5 carried weight 0.76 at 15.2).
# A member whose power iteration hit the cap is a RAYLEIGH READING (a quotient of an unconverged vector, inside the hull of the spectrum it
# mixes), flagged `~`, and a summary with any flagged chosen member is RAYLEIGH, not a gap: the eigensolver (cei_spectrum.c) on the dumped matrix
# reads the spectrum whole.  Reads the raw MODE lines (`  <datum> <W>   MODE m lambda = re (imi; k steps) lambda_1/lambda = r; weight in the
# sweep's cut state w, ...` or the W2 form `  <datum>   MODE ...` with the W from the header).   usage: gawk -v WMIN=1e-9 -f cei_gap_reader.awk
# record.txt   |   gawk -v SELFTEST=1 -f cei_gap_reader.awk   (three planted lines: the modulus of a complex member, the ~ on a capped member)
function parse(line,   a, b) {
  if (!match(line, /MODE +([0-9]+) lambda = ([-+0-9.eE]+) \(([-+0-9.eE]+)i; ([0-9]+) steps\) lambda_1\/lambda = ([-+0-9.eE]+); weight in the sweep's cut state ([-+0-9.eE]+)/, a)) return 0
  PM = a[1] + 0; PRE = a[2] + 0; PIM = a[3] + 0; PSTEPS = a[4] + 0; PRATIO = a[5] + 0; PW = a[6] + 0
  if (match(line, /^  ([A-Za-z:0-9_.]+) +(W[0-9]+)? *MODE/, b)) { PDATUM = b[1]; PLAB = (b[2] != "") ? b[2] : LASTW } else { PDATUM = LASTD; PLAB = LASTW }
  return 1 }
function clear() { NM = 0; delete RE; delete IM; delete W; delete CONV; delete PR }
function flush(   m, mod, r, best, bm, bphys, bpm, L1, t1, t2) {
  if (cur == "") return
  if (!(1 in RE)) { cur = ""; clear(); return }
  L1 = sqrt(RE[1] * RE[1] + IM[1] * IM[1]); best = -1; bphys = -1; bm = 0; bpm = 0
  for (m = 2; m <= NM; m++) { if (!(m in RE)) continue; mod = sqrt(RE[m] * RE[m] + IM[m] * IM[m]); if (mod == 0) continue; r = L1 / mod
    if (best < 0 || r < best) { best = r; bm = m }
    if (W[m] >= WMIN && (bphys < 0 || r < bphys)) { bphys = r; bpm = m } }
  if (best < 0) { printf "GAP %-12s %s: NO MODE past the first among %d\n", cur, lab, NM; cur = ""; clear(); return }
  t1 = CONV[bm] ? "" : "~"; t2 = (bpm && CONV[bpm]) ? "" : "~"
  printf "GAP %-12s %s: all modes: slowest %d of %d, |lambda_1|/|lambda| = %.6f%s (the driver's real/real %.6f, im/re %.2f); physical (weight >= %g): ", cur, lab, bm, NM, best, t1, PR[bm], (RE[bm] != 0) ? IM[bm] / RE[bm] : 0, WMIN
  if (bpm) printf "mode %d, %.6f%s (weight %.3e; ln = %.4f per cell)\n", bpm, bphys, t2, W[bpm], log(bphys); else printf "NONE\n"
  n++; GA[n] = best; GP[n] = (bpm ? bphys : best); if (t1 == "~" || (bpm && t2 == "~")) NUNC++
  cur = ""; clear() }
BEGIN { if (WMIN == "") WMIN = 1e-9; CAP = 5000; cur = ""; n = 0; NUNC = 0; LASTD = ""; LASTW = ""; if (SELFTEST) { selftest(); exit } }
/^DATUM|^GAP/ { next }   # earlier readers' verdict lines are not read
/MODE +[0-9]+ lambda = / { if (!parse($0)) { printf "UNPARSED: %s\n", substr($0, 1, 80); next }
  if (PDATUM != cur) { flush(); cur = PDATUM; lab = PLAB }
  RE[PM] = PRE; IM[PM] = PIM; W[PM] = PW; CONV[PM] = (PSTEPS < CAP); PR[PM] = PRATIO; if (PM > NM) NM = PM; next }
/^THE FIBRE|^== |^datum / { if (match($0, /random:[0-9]+|ordered|cancel/)) LASTD = substr($0, RSTART, RLENGTH); if (match($0, /W[0-9]/)) LASTW = substr($0, RSTART, RLENGTH) }
END { if (SELFTEST) exit; flush(); if (n > 0) { sa = 0; sp = 0; for (i = 1; i <= n; i++) { sa += log(GA[i]); sp += log(GP[i]) }
    printf "GAP-SUMMARY %d data: geometric mean over all modes %.4f, over the physical %.4f; %d of %d data have an unconverged chosen member -- %s\n", n, exp(sa / n), exp(sp / n), NUNC, n, (NUNC > 0) ? "RAYLEIGH READINGS, not gaps: read the dumped matrices with cei_spectrum" : "every chosen member converged" } }
function selftest(   ok, l1, l2, l3) {
  l1 = "  test W9   MODE  1 lambda = 4.000000000000e+00 (+0.0e+00i; 7 steps) lambda_1/lambda = 1.000000; weight in the sweep's cut state 1.000e+00, in the source-p cut state 1.000e+00"
  l2 = "  test W9   MODE  2 lambda = 1.000000000000e+00 (+1.0e+00i; 5000 steps) lambda_1/lambda = 4.000000; weight in the sweep's cut state 5.000e-01, in the source-p cut state 5.000e-01"
  l3 = "  test W9   MODE  3 lambda = 5.000000000000e-01 (+0.0e+00i; 9 steps) lambda_1/lambda = 8.000000; weight in the sweep's cut state 1.000e-13, in the source-p cut state 1.000e-13"
  ok = 0
  if (parse(l1) && PM == 1 && PRE == 4 && PIM == 0 && PSTEPS == 7 && PDATUM == "test" && PLAB == "W9") ok++; else print "SELFTEST FAILED: line 1 parse"
  if (parse(l2) && PM == 2 && PRE == 1 && PIM == 1 && PSTEPS == 5000 && PRATIO == 4 && PW == 0.5) ok++; else print "SELFTEST FAILED: line 2 parse"
  if (parse(l3) && PM == 3 && PRE == 0.5 && PSTEPS == 9 && PW == 1e-13) ok++; else print "SELFTEST FAILED: line 3 parse"
  # the modulus of the complex member: |1+i| = sqrt 2, so the all-modes slowest is mode 2 at 2.828427 (the driver's real/real says 4), capped -> ~; the physical slowest (WMIN 1e-9) is mode 2 too (mode 3 is numerical zero)
  cur = "test"; lab = "W9"; parse(l1); RE[1] = PRE; IM[1] = PIM; W[1] = PW; CONV[1] = 1; PR[1] = 1; NM = 1
  parse(l2); RE[2] = PRE; IM[2] = PIM; W[2] = PW; CONV[2] = 0; PR[2] = PRATIO; NM = 2
  parse(l3); RE[3] = PRE; IM[3] = PIM; W[3] = PW; CONV[3] = 1; PR[3] = PRATIO; NM = 3
  flush()
  if (n == 1 && GA[1] > 2.8284 && GA[1] < 2.8285 && NUNC == 1) ok++; else printf "SELFTEST FAILED: the chosen member must read 2.828427~ (read %.6f, unconverged count %d)\n", GA[1], NR
  printf "SELFTEST %s: %d of 4 (three parses; the complex member's modulus 2.828427 chosen over the driver's 4.0 and flagged ~ at the cap)\n", (ok == 4) ? "MET" : "FAILED", ok }
