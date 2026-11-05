#!/bin/sh
# stamp_ots.sh -- an OpenTimestamps proof for one file, in POSIX sh with sha256sum, xxd and curl (Edwin Boston III, 2026-11-05).
# It writes the proof stamp_ots.py writes, by the same public layout: the detached-timestamp header and version, the sha256 file
# operation with the file's digest, an append of sixteen random bytes and a sha256 (the nonce, so a calendar never sees the bare
# digest), then the calendars' responses, each a serialised timestamp ending in a pending attestation, joined as forks.
# `ots verify` / `ots upgrade` read the result as they read any proof of the client's own.
# KNOWN ANSWER (run by `sh stamp_ots.sh --kat <existing.ots> <its file>`): the header this script writes and the digest it computes
# equal the first 65 bytes of a proof already in this directory.
# usage: sh stamp_ots.sh <file> [<file.ots>]      (prints the digest and the calendars that answered)
set -u
HDR=004f70656e54696d657374616d7073000050726f6f6600bf89e2e884e8929401
if [ "${1:-}" = "--kat" ]; then
  p="${2:?an existing proof}"; f="${3:?the file it stamps}"
  want="${HDR}08$(sha256sum "$f" | cut -c1-64)"; have=$(head -c 65 "$p" | xxd -p | tr -d '\n')
  if [ "$want" = "$have" ]; then echo "STAMP-KAT MET: header, version, sha256 operation and digest equal the first 65 bytes of $p"; exit 0; fi
  echo "STAMP-KAT FAILED on $p"; exit 4
fi
f="${1:?usage: stamp_ots.sh <file> [<file.ots>]}"; out="${2:-$f.ots}"
[ -s "$f" ] || { echo "STAMP REFUSED: $f is empty or missing"; exit 2; }
tmp=$(mktemp -d) || exit 9
fd=$(sha256sum "$f" | cut -c1-64)
nonce=$(head -c 16 /dev/urandom | xxd -p | tr -d '\n')
printf '%s%s' "$fd" "$nonce" | xxd -r -p > "$tmp/pre"
printf '%s' "$(sha256sum "$tmp/pre" | cut -c1-64)" | xxd -r -p > "$tmp/stamped"
n=0
for cal in https://a.pool.opentimestamps.org https://b.pool.opentimestamps.org https://a.pool.eternitywall.com https://ots.btc.catallaxy.com; do
  if curl -s -S -m 30 -X POST -H 'Accept: application/vnd.opentimestamps.v1' -H 'Content-Type: application/x-www-form-urlencoded' -A 'stamp_ots.sh (Edwin Boston III)' --data-binary "@$tmp/stamped" "$cal/digest" -o "$tmp/resp.$n" 2> "$tmp/err" && [ -s "$tmp/resp.$n" ]; then
    echo "calendar $cal: $(wc -c < "$tmp/resp.$n") bytes"; n=$((n + 1))
  else
    echo "calendar $cal: no answer ($(head -c 80 "$tmp/err" | tr '\n' ' '))"
  fi
done
if [ "$n" -eq 0 ]; then echo "STAMP REFUSED: no calendar answered"; rm -rf "$tmp"; exit 3; fi
{
  printf '%s' "$HDR" | xxd -r -p
  printf '08%s' "$fd" | xxd -r -p
  printf 'f010%s08' "$nonce" | xxd -r -p
  i=0
  while [ "$i" -lt "$n" ]; do
    if [ "$i" -lt $((n - 1)) ]; then printf 'ff' | xxd -r -p; fi
    cat "$tmp/resp.$i"
    i=$((i + 1))
  done
} > "$out"
echo "digest $fd"
echo "written $out ($(wc -c < "$out") bytes, $n calendars)"
rm -rf "$tmp"
