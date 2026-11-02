# -*- coding: utf-8 -*-
"""Render a .docx built by the groundwork's lib.js to plain text, keeping super/subscripts (^{..}, _{..}), italics (*..*),
and Office Math (sSub/sSup/f/nary) in a linear form, so the inserted section can be read as the reader will see it.
Usage: python docx_text.py <in.docx> <out.txt> [start marker] [end marker]"""
import sys
import zipfile
import xml.etree.ElementTree as ET

W = "{http://schemas.openxmlformats.org/wordprocessingml/2006/main}"
M = "{http://schemas.openxmlformats.org/officeDocument/2006/math}"


def mtext(e):
    tag = e.tag
    if tag == M + "r":
        return "".join(t.text or "" for t in e.iter(M + "t"))
    if tag == M + "sSub":
        return mkids(e.find(M + "e")) + "_{" + mkids(e.find(M + "sub")) + "}"
    if tag == M + "sSup":
        return mkids(e.find(M + "e")) + "^{" + mkids(e.find(M + "sup")) + "}"
    if tag == M + "sSubSup":
        return mkids(e.find(M + "e")) + "_{" + mkids(e.find(M + "sub")) + "}^{" + mkids(e.find(M + "sup")) + "}"
    if tag == M + "f":
        return "[" + mkids(e.find(M + "num")) + "]/[" + mkids(e.find(M + "den")) + "]"
    return mkids(e)


def mkids(e):
    if e is None:
        return ""
    return "".join(mtext(c) for c in e if not c.tag.endswith("Pr"))


def para_text(p):
    out = []
    for c in p.iter():
        pass
    for c in list(p):
        if c.tag == W + "r":
            rpr = c.find(W + "rPr")
            va = None
            ital = False
            if rpr is not None:
                v = rpr.find(W + "vertAlign")
                if v is not None:
                    va = v.get(W + "val")
                ie = rpr.find(W + "i")
                if ie is not None and ie.get(W + "val") not in ("false", "0", "off"):
                    ital = True
            txt = "".join((t.text or "") for t in c.iter(W + "t"))
            if c.find(W + "footnoteReference") is not None:
                txt += "[fn]"
            if c.find(W + "tab") is not None:
                txt = "\t" + txt
            if va == "superscript":
                txt = "^{" + txt + "}"
            elif va == "subscript":
                txt = "_{" + txt + "}"
            if ital and txt.strip():
                txt = "*" + txt + "*"
            out.append(txt)
        elif c.tag == M + "oMath" or c.tag == M + "oMathPara":
            out.append(" $" + mkids(c) + "$ ")
    return "".join(out)


def main():
    src, dst = sys.argv[1], sys.argv[2]
    start = sys.argv[3] if len(sys.argv) > 3 else None
    end = sys.argv[4] if len(sys.argv) > 4 else None
    z = zipfile.ZipFile(src)
    root = ET.fromstring(z.read("word/document.xml"))
    body = root.find(W + "body")
    lines = [para_text(p) for p in body.iter(W + "p")]
    if start:
        i0 = next(i for i, l in enumerate(lines) if start in l.replace("*", ""))
        i1 = next(i for i, l in enumerate(lines) if i > i0 and end in l.replace("*", "")) if end else len(lines)
        lines = lines[i0:i1 + 1]
    with open(dst, "w", encoding="utf-8") as f:
        for l in lines:
            f.write(l + "\n\n")
    # footnotes too
    try:
        froot = ET.fromstring(z.read("word/footnotes.xml"))
        with open(dst + ".footnotes.txt", "w", encoding="utf-8") as f:
            for fn in froot.iter(W + "footnote"):
                f.write("[%s] " % fn.get(W + "id") + " ".join(para_text(p) for p in fn.iter(W + "p")) + "\n")
    except KeyError:
        pass
    print("wrote %d paragraphs to %s" % (len(lines), dst))


main()
