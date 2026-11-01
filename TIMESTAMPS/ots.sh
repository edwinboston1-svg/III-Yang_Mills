#!/bin/sh
# ots.sh -- the OpenTimestamps client over the proofs in this directory.
#
#   sh TIMESTAMPS/ots.sh info    TIMESTAMPS/2026-11-01-revision-26.txt.ots
#   sh TIMESTAMPS/ots.sh verify  TIMESTAMPS/2026-11-01-revision-26.txt.ots
#   sh TIMESTAMPS/ots.sh upgrade TIMESTAMPS/2026-11-01-revision-26.txt.ots
#
# verify without a local Bitcoin node:  sh TIMESTAMPS/ots.sh --no-bitcoin verify <proof>
# (it then prints the block height and merkle root to check by hand against any block explorer).
# A fresh proof reads "Pending confirmation in Bitcoin blockchain" at every calendar until a
# calendar's aggregate is mined, usually within a day; `upgrade` then writes the Bitcoin
# attestation into the .ots file and `verify` names the block.
#
# The client is opentimestamps-client (pip install opentimestamps-client; 0.8.0 at the time of
# writing). Its dependency python-bitcoinlib loads OpenSSL through
# ctypes.util.find_library('ssl.35' | 'ssl' | 'libeay32'); on Windows that lookup walks PATH for
# a DLL of that name, so a directory holding libcrypto under those names is put first on PATH
# (it must be libcrypto -- the BN_* and EC_* symbols -- not libssl). Set OTS_DLL_DIR to that
# directory; the default below is the user-site Scripts/otsdll beside the client's own script.
# Anywhere `ots` is already on PATH (Linux, macOS, a Windows PATH that has it), it is used as is.

set -u
if [ -n "${OTS_DLL_DIR:-}" ] && [ -d "$OTS_DLL_DIR" ]; then
  PATH="$OTS_DLL_DIR:$PATH"; export PATH
elif [ -d "${APPDATA:-}/Python/Python314/Scripts/otsdll" ]; then
  PATH="${APPDATA}/Python/Python314/Scripts/otsdll:${APPDATA}/Python/Python314/Scripts:$PATH"; export PATH
elif [ -d "$HOME/AppData/Roaming/Python/Python314/Scripts/otsdll" ]; then
  PATH="$HOME/AppData/Roaming/Python/Python314/Scripts/otsdll:$HOME/AppData/Roaming/Python/Python314/Scripts:$PATH"; export PATH
fi
if command -v ots >/dev/null 2>&1; then
  exec ots "$@"
fi
for PY in python3 python; do
  if command -v "$PY" >/dev/null 2>&1; then
    exec "$PY" -m otsclient.ots "$@"
  fi
done
echo "ots.sh: no ots client and no python on PATH (pip install opentimestamps-client)" >&2
exit 2
