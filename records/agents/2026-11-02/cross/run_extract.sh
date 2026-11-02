#!/bin/bash
# run_extract.sh -- the Yang-Mills transcripts of 2026-10-26 on, extracted whole into cross/transcripts/ in parallel.
S="/c/Users/EDWINB~1/AppData/Local/Temp/claude/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad"
X="$S/logs2/extract_full.py"
T="$S/cross/transcripts"
P="/c/Users/Edwin Boston/.claude/projects/C--Users-Edwin-Boston-OneDrive-Desktop-III"
LO="2026-10-26T00:00:00"
CUT="2026-11-01T04:00:00"
END="2026-11-03T00:00:00"
cd "$P" || exit 1
run() { python -I "$X" "$1" "$2" "$3" "$4" > "$2.log" 2>&1; echo "$(date +%H:%M:%S) done $2 rc=$?" >> "$T/progress.txt"; }
: > "$T/progress.txt"
run b10e8d4b-6689-426c-b1b0-7a2565121b61.jsonl "$T/b10e8d4b.txt" "$LO" "$CUT" &
run 0964fd4b-948b-4839-8e02-78012b892b0d.jsonl "$T/0964fd4b.txt" "$LO" "$CUT" &
run cd9abb9e-ced1-4c0b-8c4f-24aab1050947.jsonl "$T/cd9abb9e.txt" "$LO" "$END" &
run 73cd2372-e477-495f-9436-9b5af3f34394.jsonl "$T/73cd2372.txt" "$LO" "$END" &
run 59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb.jsonl "$T/59ca2c52.txt" "$LO" "$CUT" &
run c3419161-1496-4c60-853d-6b9a49a534f2.jsonl "$T/c3419161.txt" "$LO" "$CUT" &
run 5cf16cea-92b5-4e54-885f-89502ddc48bc.jsonl "$T/5cf16cea.txt" "$LO" "$CUT" &
wait
for f in eed37199-d0ea-4c68-99f0-ee612c27c50d cc4b019c-5b55-4d8d-b416-5d3e437bb6c1 59881dc0-c774-4657-b7a9-93d5fbb110fa \
         20a134e4-9910-437f-abf7-4609ccf987eb b0190fac-9ce4-46d2-81eb-7b9b14ae69af 8aa1fb9f-b834-405f-a55b-9821bb29b200 \
         1a1c7f36-bc7d-4604-94c5-422e9f830347 138127c7-a673-460a-9249-85ddb1faee7a 0ddf0734-9abb-4758-95ac-5a8b180c0ed8 \
         f3987dd2-21aa-4a34-9db5-920719805034 98213549-ce72-4674-a338-76235b1c188b 518d732d-fa99-4010-b0bb-234c50dc276c \
         0b727b2a-2433-4798-b652-e44a290cc029 5cc796ba-6abc-4da4-ae25-35eafa5a7eff 329d068d-1f2e-4428-99b0-dffd18c36b13 \
         8dd7e25a-17ae-452a-85f3-8c0232a1de25 b7e5b036-e36c-48ed-a10c-fb6b7b290118; do
  run "$f.jsonl" "$T/small_${f:0:8}.txt" "$LO" "$CUT"
done
mkdir -p "$T/sub"
for d in b10e8d4b-6689-426c-b1b0-7a2565121b61 5cf16cea-92b5-4e54-885f-89502ddc48bc; do
  for a in "$d"/subagents/agent-*.jsonl; do
    b=$(basename "$a" .jsonl)
    run "$a" "$T/sub/${d:0:8}_${b}.txt" "$LO" "$CUT" &
  done
  wait
done
echo "$(date +%H:%M:%S) ALL DONE" >> "$T/progress.txt"
