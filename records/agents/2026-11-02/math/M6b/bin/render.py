import sys, fitz
# usage: render.py <pdf> <outprefix> <first_journal_page> <page> [<page> ...]  (journal page numbers)
pdf, out, first = sys.argv[1], sys.argv[2], int(sys.argv[3])
doc = fitz.open(pdf)
for p in sys.argv[4:]:
    p = int(p); i = p - first
    pix = doc[i].get_pixmap(dpi=110, colorspace=fitz.csGRAY)
    fn = f"{out}_{p}.png"; pix.save(fn); print(fn, pix.width, pix.height)
