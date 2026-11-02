#!/bin/bash
# ship_agents.sh -- copy the session's proof-agent work (the findings) into III-Yang_Mills records/agents/2026-11-02/, with a manifest
# of SHA-256 digests; exclude rendered pages and downloaded papers (third-party copyright), binaries, and nothing else.
# The reading digests (read/) are NOT copied: they quote private session transcripts. No commit here.
set -u
S="/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad"
Y="/c/Users/Edwin Boston/OneDrive/Desktop/III-Yang_Mills"
D="$Y/records/agents/2026-11-02"
[ -e "$D" ] && { echo "REFUSED: $D exists"; exit 2; }
mkdir -p "$D" || exit 2
LIST="$S/ship_agents.list"; : > "$LIST"
cd "$S" || exit 9
# the proof agents' directories, the brief, and the trunk seat's own desk work
find math check19 reduction corr0502 rev32 -type f \
  ! -path "*/render/*" ! -path "*/dl_*" ! -path "rev32/r32/*" \
  ! -iname "*.png" ! -iname "*.jpg" ! -iname "*.pdf" ! -iname "*.exe" ! -iname "*.o" ! -iname "*.dll" ! -iname "*.docx" \
  -size -3M 2>/dev/null | sort > "$LIST"
N=$(wc -l < "$LIST"); echo "files to copy: $N"
# credential-shaped content: refuse if any file matches
if xargs -d '\n' -a "$LIST" grep -l -I -E '(ghp_[A-Za-z0-9]{20,}|github_pat_|sk-[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16}|BEGIN (RSA|EC|OPENSSH|PRIVATE) KEY|xox[baprs]-[A-Za-z0-9-]{10,})' 2>/dev/null | head -5 | grep -q .; then
  echo "REFUSED: credential-shaped content in:"; xargs -d '\n' -a "$LIST" grep -l -I -E '(ghp_[A-Za-z0-9]{20,}|github_pat_|sk-[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16}|BEGIN (RSA|EC|OPENSSH|PRIVATE) KEY|xox[baprs]-[A-Za-z0-9-]{10,})' | head; rm -rf "$D"; exit 2; fi
while IFS= read -r f; do mkdir -p "$D/$(dirname "$f")" && cp -p "$f" "$D/$f" || { echo "REFUSED: copy $f"; exit 2; }; done < "$LIST"
# the manifest
{
  echo "# The proof agents' work of 2 November 2026 (Edwin Boston III's program; the trunk seat iii-43)"
  echo
  echo "Copied from the session's scratchpad on $(date '+%Y-%m-%d %H:%M %Z'), byte for byte, with the SHA-256 of every file below."
  echo "Agents still running at the copy carry a snapshot of their work page at that instant; a later copy supersedes it."
  echo "Excluded: rendered pages of Bałaban's papers and two downloaded papers (third-party copyright), binaries, and the reading"
  echo "digests of the session transcripts (they quote private sessions). Each WORK.md states every result at its own strength:"
  echo "PROVED on its page, CERTIFIED, MEASURED, READING, CONDITIONAL, OPEN; second readers' verdicts are in */REVIEW.md."
  echo
  echo "| Directory | Agent | Object |"
  echo "|---|---|---|"
  echo "| math/MATH_BRIEF.md | — | the brief every proof agent read first |"
  echo "| math/M1 | M1 | Lemma S12 and the strong end: T1, T2, Lemmas R, M′, E, S, E4, Corollary U″; the S12-free certified 0.3650 / 0.3656 and the conditional 0.5100 / 0.5198; κ*(β) |"
  echo "| math/M1R | M1R | second reader of M1, re-running the certificate (snapshot) |"
  echo "| math/M1b | M1b | the density exponent below 1/2 by discharging on 3-cubes (snapshot) |"
  echo "| math/M2 | M2 | the crossover in L²: Theorem 3.1 (the reduction in L²), the bent-object finding §6.0 |"
  echo "| math/M2R | M2R | second reader of M2 (REVIEW.md); the paper draft of Theorem 8.5′ and its conversion rev33_l2.py |"
  echo "| math/M2RR | M2RR | second reader of revision 33's inserted text (snapshot) |"
  echo "| math/M2b | M2b | Theorem A1 (no typical-environment criterion), Lemma A2, Theorem C1; (W-S) (snapshot) |"
  echo "| math/M3 | M3 | the UV half: §4, Lemmas A′, B, C, D, Theorem 2; §6 the block map (Prop. 6.2) |"
  echo "| math/M3R | M3R | second reader of M3 (REVIEW.md): (BB4) the missing estimate |"
  echo "| math/M3b | M3b | Bałaban with a position coupling: (S₁), Lemma P3, Prop. D∞, BB4* named, (PI) named |"
  echo "| math/M3c | M3c | Lemma M, THEOREM BB4*, the moment form, Lemma W, LEMMA FP, Lemmas C/C′, (PI)_H; (PI-4), (PI-5) named |"
  echo "| math/M3cR | M3cR | second reader of M3c (snapshot) |"
  echo "| math/M3d | M3d | (PI-4) and (PI-5) (snapshot) |"
  echo "| math/M3e | M3e | Bałaban's CMP 102 (189)–(190) carried out; the CMP 99 audit (snapshot) |"
  echo "| math/M4 | M4 | the window: the twist identity, the vortex recursion, the channel split, Theorem 4.1, the no-go, Turán slaving; Lemma W |"
  echo "| math/M4R | M4R | second reader of M4 (snapshot) |"
  echo "| math/M5 | M5 | (W-V), the vortex half of Lemma W (snapshot) |"
  echo "| math/M6 | M6 | Bałaban's threshold, constant by constant (snapshot) |"
  echo "| math/M7 | M7 | the two-step landing test (snapshot) |"
  echo "| check19 | iii-43 | the independent inversion of the Wilson coefficient for THE CROSSING CAMPAIGN §19 |"
  echo "| reduction | iii-43 | THE CROSSING CAMPAIGN §20: the reduction's constant S and its table |"
  echo "| corr0502 | iii-43 | the dated sections §18–§19 and their commit texts |"
  echo "| rev32 | iii-43 | the scripts of THE GROUND's revision 32 |"
  echo
  echo "## Files"
  echo
  echo '```'
  ( cd "$D" && while IFS= read -r f; do sha256sum "$f"; done < "$LIST" )
  echo '```'
} > "$D/MANIFEST.md"
echo "copied $N files; $(du -sh "$D" | cut -f1)"
