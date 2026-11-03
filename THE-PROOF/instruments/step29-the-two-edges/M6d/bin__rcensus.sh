#!/bin/bash
# census of corridor-size uses in the text layers (formulas garbled; locator only)
S=/c/Users/EDWINB~1/AppData/Local/Temp/the author/C--Users-Edwin-Boston-OneDrive-Desktop-III/59ca2c52-22a2-4ac6-93d9-5dadb2bb3bcb/scratchpad/math
for f in cmp119 cmp122a_lfr1 cmp122b_lfr2; do
  echo "=================== $f"
  awk -v F=$f '
    /^2[4-9][0-9]$|^3[5-9][0-9]$|^1[7-9][0-9]$|^20[0-2]$/ { page=$0 }
    { line=$0
      if (line ~ /M *R *[kjhn0-9]|M[0-9]? *R[kjhn0-9]|M2 *R|exp *\( *-+ *R|exp\(-- *R|R *[kjhn] *\^|N *= *R|N *\^ *R|Rk *d|R ?k ?\+ ?1|\( *log *g|logg|N0|No\b/) {
        n++; printf("%s p~%s L%d: %s\n", F, page, NR, substr(line,1,260)) } }
    END { print "matches:", n }' $S/M3b/src/$f.txt
done
