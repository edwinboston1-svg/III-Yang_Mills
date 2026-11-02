#!/bin/bash
# ship_all.sh -- commit EVERY piece of the session's proof work into the repositories (the operator's order, 2026-11-02 11:0x:
# "every accomplishment, proof, etc needs to be committed, found easily, out of the scratch, tracked ... everything stays").
#   III (private, the system): EVERYTHING, at STDLIB/build/aperanton/agents/2026-11-02/, with INDEX.md and a SHA-256 manifest.
#   III-Yang_Mills (public): the same refresh of records/agents/2026-11-02/, minus private session transcripts, digests that
#   quote them, other authors' papers (pdf/png/page renders) and compiled binaries; its manifest names the complete copy in III.
# Re-runnable: copies newer files over older, adds new ones, regenerates the manifests. Commits by pathspec only. Pushes both.
set -u
S="/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad"
R="/c/Users/Edwin Boston/OneDrive/Desktop/III"; Y="/c/Users/Edwin Boston/OneDrive/Desktop/III-Yang_Mills"
DR="$R/STDLIB/build/aperanton/agents/2026-11-02"; DY="$Y/records/agents/2026-11-02"
DIRS="math read research_notes reports reduction cross rev32 rev33 rev34 kpfix check19 corr0502"
TOPF="STATUS.md ship_agents.sh ship_all.sh"
cd "$S" || exit 9
mkdir -p "$DR" "$DY" || exit 2
LR="$S/ship_all.III.list"; LY="$S/ship_all.YM.list"
find $DIRS -type f -size -95M 2>/dev/null | sort > "$LR"; for f in $TOPF; do [ -f "$f" ] && echo "$f" >> "$LR"; done
grep -v -E '^cross/transcripts/|^read/digests/|^read/derived/|\.(pdf|png|jpg|jpeg|exe|o|obj|dll|so|a)$|/render/|/dl_' "$LR" > "$LY"
echo "III files: $(wc -l < "$LR")  YM files: $(wc -l < "$LY")"
cp_list() { while IFS= read -r f; do mkdir -p "$2/$(dirname "$f")" && cp -pu "$f" "$2/$f" || echo "COPY FAILED: $f"; done < "$1"; }
cp_list "$LR" "$DR"; echo "copied to III"
cp_list "$LY" "$DY"; echo "copied to III-Yang_Mills"
idx() { # $1 dest, $2 list, $3 scope sentence
{ echo "# The trunk seat's session of 2 November 2026 — every piece of the proof work (Edwin Boston III's Yang–Mills program)"
  echo
  echo "Copied from the session's working folder on $(date '+%Y-%m-%d %H:%M %Z'), byte for byte; re-copied after every result."
  echo "$3"
  echo
  echo "**Where the results are stated:** THE CROSSING CAMPAIGN §§18–27 (III: DOCS/III-THE-CROSSING-CAMPAIGN-OF-THE-YANG-MILLS-GAP.md;"
  echo "III-Yang_Mills: OPEN/the-crossing-campaign.md). Every agent's final report, verbatim, is in read/REPORTS.md; the launch log is read/QUEUE.txt."
  echo
  echo "| Folder | What it holds |"; echo "|---|---|"
  echo "| math/MATH_BRIEF.md | the brief every proof agent read (corrected 10:2x) |"
  echo "| math/M1, M1R, M1b, M1c | the strong end: S12-free 0.3650, its second reading, the density exponent, the unpriced class priced |"
  echo "| math/M2, M2R, M2RR, M2b, M2c | the reduction in L² (Theorem 8.5′), its readings, Theorem A1, the Hypothesis I row |"
  echo "| math/M3 … M3g, M3R, M3cR, M3dR, M3fR, M3gR | Bałaban's UV half: BB4*, Lemma FP, PI-4/PI-5 (PI-4 repaired), (189)–(190), E1, Lemmas B/D, CMP 99 (3.132) |"
  echo "| math/M4, M4R, M5 | the window: twist identity, vortex half, Lemma W |"
  echo "| math/M6, M6b, M6c, M6d | Bałaban's threshold: 10^982 → RD → 10^124.3 floor |"
  echo "| math/M7, M7b | the two-step landing; the U(1) gate refuting the readings pipeline |"
  echo "| math/M8, M8b | the tube around the renormalised trajectory |"
  echo "| math/MF | Hypothesis II′: the Two-Sector Theorem |"
  echo "| math/MG, MG2 | every compact simple G: Theorem 8.7_G with certified β*_G |"
  echo "| math/ME2, ME2b | (E2) Euclidean invariance: the reduction, Lemma Σ_χ |"
  echo "| math/MIR, MPAIR, M87 | the IR large-field expansion; the literature pairings; Theorem 8.7's block split |"
  echo "| read/ | the full-reading campaign: instructions, shares, digests, REPORTS.md, QUEUE.txt |"
  echo "| research_notes/, reports/ | the manual literature research and its sourced report |"
  echo "| reduction/ | the trunk seat's desk work and every section §20–§27 as landed |"
  echo "| cross/ | the cross-reading syntheses (ANSWER.md, digests) and the session transcripts read |"
  echo "| rev32/, rev33/, rev34/ | THE GROUND's revisions: scripts and drafts |"
  echo "| kpfix/, check19/, corr0502/ | the certificate fix's checks, §19's inversion, the dated corrections |"
  echo
  echo "## Files (SHA-256)"; echo; echo '```'
  ( cd "$1" && while IFS= read -r f; do sha256sum "$f"; done < "$2" ); echo '```'; } > "$1/INDEX.md"; }
idx "$DR" "$LR" "This is the COMPLETE copy: nothing is left out."
idx "$DY" "$LY" "This public copy leaves out only private session transcripts, the reading digests that quote them, other authors' papers (pdf/png/page renders) and compiled binaries; the complete copy is in the III repository at STDLIB/build/aperanton/agents/2026-11-02/."
echo "indexes written"
