#!/bin/bash
# usage: page.sh <textfile> <first journal page of the paper> <page> [<page2>]
f="$1"; first="$2"; p="$3"; q="${4:-$3}"
awk -v RS='\f' -v a=$((p-first+1)) -v b=$((q-first+1)) -v first="$first" 'NR>=a && NR<=b {print "=== page " (NR+first-1) " ==="; print}' "$f"
