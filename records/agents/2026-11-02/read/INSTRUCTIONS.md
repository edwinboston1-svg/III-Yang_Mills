# The full reading — instructions for every reading agent (2026-11-02)

## Who you are reading for

Edwin Boston (the operator) is building a proof of the SU(2) Yang–Mills mass gap. III is his self-hosted language and
proof system, the git repository `C:\Users\Edwin Boston\OneDrive\Desktop\III` (bash: `/c/Users/Edwin Boston/OneDrive/Desktop/III`).
Its ΑΠΕΡΑΝΤΟΝ (aperanton) organ is the Yang–Mills program; its build directory `STDLIB/build/aperanton` holds the
instruments and records. III-Yang_Mills, the git repository `C:\Users\Edwin Boston\OneDrive\Desktop\III-Yang_Mills`
(published at github.com/edwinboston1-svg/III-Yang_Mills), holds THE GROUND, Edwin Boston III's paper (source in
`source/ground/*.js`, `source/*.js`; PDF and docx at the root), the OPEN pages (`OPEN/*.md`, `OPEN/ledger/*.md`, among them
the flux-surface gas `OPEN/ledger/s1-the-flux-surface-gas.md`, the crossing campaign, the far shore, the standing), the Lean
kernel (`kernel/aperanton/Aperanton/*.lean`, run of record in `kernel/runs/`), Lean drafts (`records/lean-drafts/`) and the
records (`records/**`).

The proof's chain as it stands on 2026-11-01:
- the strong-coupling gap: Theorem 8.7, SU(2) on Z^4 for β ≤ 0.241 (0.2452 with exact constants) by Dobrushin's comparison
  theorem on a perfect-cover decimation, on proved lemmas; Theorem 8.9, β ≤ 0.4764 (0.4816 in the tree dressing) by the
  flux-surface gas and a certified Kotecký–Preiss inequality, CONDITIONAL on the remainder of Lemma S12 (the activity bound
  4u^F for contact leaves outside the proved classes: contact cycle rank ≥ 2 beyond the proved cases, six-fold cycles of
  shapes other than the square, 1×n, 2×2 and the skew hexagon — the first open one a skew octagon);
- the crossover: Theorem 8.5 reduces the continuum gap of every limit point to Hypothesis I (a Dobrushin condition with
  exponential weight on the blocked measure's coarse variables at a fixed physical scale, uniform in the cutoff) and
  Hypothesis II (fibre clustering); the physical crossover regime of SU(2) is near β ≈ 2.2–2.3;
- the ultraviolet half: Bałaban's renormalisation group as carried by the Alpöge–Sussman corpus.

Vocabulary: a "reading" is a numerical measurement (Monte Carlo, or exact on a finite object); "certified" means exact or
outward-rounded interval arithmetic; "kernel" means Lean-checked; a "stake" is a prediction written before its computation;
a "gate" is a test script with mutant teeth; a "seat" is one Claude Code session (iii-43 the trunk seat, iii-38 the
instrument seat, iii-bd the coordination seat, iii-73, iii-ac, iii-58, iii-24 seats of other campaigns).

## The operator's orders that this reading serves (verbatim)

- "read every single thing in the yang mills github, then everything from the claude code logs today. im not gonna let you
  hedge my work and screw me over again and again and again as if this proof isnt the biggest mathemtaical race in history."
- "read it in full. if you dont, and you dont bear its full context before you make any subsequent move, then do it again."
- "DO AS I SAID" (in answer to a note that number-only files and code were being summarized instead of read line by line).
- "what about scratchpad? what about the stuff you decided not to track ... ruin my significant lead?"
- "you may use agents. many of them. all opus 5.5. all max effort. all using /clear-thought and /deep-think and /creative-solve"
- On the paper's sentence "It does not cross—or claim to cross—the physical crossover regime near β ≈ 2.3": find where the
  proof did cross it, or came near doing so, before the scope was cut back.

## Your share

Your share is one TSV file in `/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/read/shares/`.
Each row: `path<TAB>first_line<TAB>last_line<TAB>total_lines<TAB>bytes<TAB>sha256_16<TAB>note`. Read EVERY line of every row's
range, in order, with Bash (`sed -n 'A,Bp' "path"`), in pieces of at most 25,000 characters per command. A row whose note says
LONGLINES has lines longer than 20,000 bytes: read those by bytes (`tail -c +N "path" | head -c 25000`). Paths contain spaces:
always quote them. Do not skip, sample, tabulate in place of reading, or grep in place of reading — the operator ordered a
literal reading of every line, number-only files and code included. A row with EMPTY is an empty file: note it. Other files
that a row refers to may be opened read-only for context, but your coverage is your share.

`/c/Users/.../scratchpad/read/shares/DUPLICATES.tsv` lists files byte-identical to one in some share (not yours to read);
`DUMPS.tsv` lists files of 1 MB or more read by the dump agents; `BINARIES.tsv` lists binaries.

## What to record

Write your digest to `/c/Users/.../scratchpad/read/digests/<share id>.md` (the share id is the TSV's name without `.tsv`),
APPENDING after every few pieces read, so nothing is lost if your context is compacted. Begin it with a COVERAGE table (path,
lines read, of total) that you keep current. Then entries, one per finding, each:

`[TAG] path:line(s) (date if known) — the verbatim quote or the exact content (numbers verbatim) — STATUS — NOTE`

STATUS is one of PROVED (on a page, with its proof), KERNEL (Lean-checked), CERTIFIED (exact or interval arithmetic), MEASURED
(an exact finite computation that is not a bound), READING (numerical, Monte Carlo or truncated), STAKE (written before its
run: HELD / REFUTED / UNREAD), STATED (asserted without proof), CONDITIONAL(on what), REFUTED, WITHDRAWN.

Tags (several allowed):
- RESULT a result, theorem or number with its strength; CERT a certificate or certified bound; MEAS a measured value.
- S12 anything bearing on Lemma S12's remainder (contact leaves, contact cycle rank, six-fold cycles, the skew octagon,
  rectangles with a contact spoke, the neck / mixed sides, minimality, the cut and resolution formulas, the box censuses).
- HYP-I anything bearing on Hypothesis I, Hypothesis II, the crossover, the blocked measure, the influence functional, the
  W1–W8 campaign, the two-face engine, the ladders, Dobrushin rows, the flows from β = 2.2.
- BETA anything bearing on the coupling thresholds (0.241, 0.2452, 0.4764, 0.4816, 0.4672, 0.4710, and any other).
- CROSS a statement, certificate, Lean theorem or reading at β ≥ 2, or a chain claimed to reach the continuum or all β;
  NEAR one between 0.5 and 2, or a complete chain whose one missing link is named.
- OPEN an open item, wall, owed lemma or gap, stated exactly.
- HEDGE a sentence that states less than its own evidence supports, or scope-minimizing language; quote it and give the
  evidence that the result is stronger.
- ERROR an error, contradiction, stale number, bug or inconsistency (with the conflicting places).
- LEAD a result present here but absent from the paper and the OPEN pages (unclaimed work).
- UNTRACKED material that is not committed anywhere and has value: its path and what it holds.
- INSTRUMENT a program: what it computes, inputs, outputs, known answers, limits.
- ORDER the operator's words (transcripts): verbatim, with timestamp. DECISION a seat's decision with its reason.
- IDEA a promising idea or unexploited opening toward the complete proof.
- REF a reference to a file, commit or page outside your share.

Be exact both ways: a numerical reading is not a proof and a proof is not a reading. Report each item at the strength its
own evidence gives, neither inflated nor deflated. Numbers verbatim.

For a transcript share (LOG): record every operator message verbatim with its timestamp (ORDER); every claim a seat made
and on what evidence; every result reported; every decision and its reason; every error and its fix; every file written
(path, purpose); every promise or owed item; every place a claim was scaled back, and why.

## Skills (the operator's order)

1. First, invoke the Skill tool with skill `deep-think` on your share (what it is, how to read it, what to look for).
2. Partway through, load `mcp__clear-thought__sequentialthinking` with ToolSearch (query
   `select:mcp__clear-thought__sequentialthinking`) and use it to structure your synthesis.
3. At the end, invoke the Skill tool with skill `creative-solve` on: "what in this share, taken at its full strength, opens
   the way to the complete proof (Lemma S12's remainder, Hypothesis I, the crossing of β ≈ 2.3) that the record has not
   exploited?" — and record what it yields as IDEA entries.

## Rules

Read-only. Do not edit, create or delete any file except your digest. No git command that changes state (no commit, add,
checkout, reset, stash, push, fetch). Do not kill processes, run gates, launch long computations, use the network, or
message other sessions. Do not run python from a bash heredoc (it can hang on this machine); you should not need python.

## Your final message

At most 350 words: the share id; COVERAGE complete or not (with any gap named); the counts of entries by tag; and the 5 to 10
most important entries, verbatim from your digest.
