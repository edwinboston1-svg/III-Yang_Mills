# stamp_ots.py -- an OpenTimestamps proof for one file, written from the protocol alone (Edwin Boston III, 2026-11-01).
# The client's `ots stamp` could not be installed on the machine that night; the file format it writes is public and small, so this script
# writes the same proof: the detached-timestamp header, the sha256 file operation and the file's digest, an append of sixteen random bytes
# and a sha256 (the nonce the client adds so a calendar never sees the bare digest), then the calendars' responses, each a serialised
# timestamp ending in a pending attestation, joined as forks.  `ots verify` / `ots upgrade` read the result as they read any proof of the
# client's own (the proof of revision 25 in this directory, read byte by byte, has exactly this layout).
# usage: python stamp_ots.py <file> [<file.ots>]      (prints the digest and the calendars that answered)
import sys, os, hashlib, urllib.request

MAGIC = b"\x00OpenTimestamps\x00\x00Proof\x00\xbf\x89\xe2\xe8\x84\xe8\x92\x94"
CALENDARS = ["https://a.pool.opentimestamps.org", "https://b.pool.opentimestamps.org", "https://a.pool.eternitywall.com", "https://ots.btc.catallaxy.com"]


def submit(url, digest):
    req = urllib.request.Request(url + "/digest", data=digest, method="POST",
                                 headers={"Accept": "application/vnd.opentimestamps.v1", "User-Agent": "stamp_ots.py (Edwin Boston III)",
                                          "Content-Type": "application/x-www-form-urlencoded"})
    with urllib.request.urlopen(req, timeout=30) as r:
        return r.read()


def main():
    if len(sys.argv) < 2:
        print("usage: stamp_ots.py <file> [<file.ots>]"); sys.exit(2)
    path = sys.argv[1]
    out = sys.argv[2] if len(sys.argv) > 2 else path + ".ots"
    with open(path, "rb") as f:
        filedigest = hashlib.sha256(f.read()).digest()
    nonce = os.urandom(16)
    stamped = hashlib.sha256(filedigest + nonce).digest()
    responses = []
    for cal in CALENDARS:
        try:
            resp = submit(cal, stamped)
            if resp:
                responses.append((cal, resp))
                print("calendar %s: %d bytes" % (cal, len(resp)))
        except Exception as e:            # a calendar that does not answer is left out; the proof needs one
            print("calendar %s: no answer (%s)" % (cal, str(e)[:80]))
    if not responses:
        print("STAMP REFUSED: no calendar answered"); sys.exit(3)
    body = bytearray()
    body += MAGIC + b"\x01"                     # version 1
    body += b"\x08" + filedigest                # the file operation sha256 and the file's digest
    body += b"\xf0" + bytes([len(nonce)]) + nonce + b"\x08"     # append the nonce, sha256
    for i, (cal, resp) in enumerate(responses):
        if i < len(responses) - 1:
            body += b"\xff"                     # a fork: every branch but the last is prefixed
        body += resp
    with open(out, "wb") as f:
        f.write(bytes(body))
    print("digest %s" % filedigest.hex())
    print("written %s (%d bytes, %d calendars)" % (out, len(body), len(responses)))


if __name__ == "__main__":
    main()
