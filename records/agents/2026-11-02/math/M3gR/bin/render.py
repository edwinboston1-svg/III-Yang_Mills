import sys, fitz
# usage: render.py <pdf> <outprefix> <first_journal_page> <dpi> <page> [<page> ...]
pdf, out, first, dpi = sys.argv[1], sys.argv[2], int(sys.argv[3]), int(sys.argv[4])
doc = fitz.open(pdf)
for p in sys.argv[5:]:
    p = int(p); i = p - first
    pix = doc[i].get_pixmap(dpi=dpi, colorspace=fitz.csGRAY)
    fn = f"{out}_{p}.png"; pix.save(fn); print(fn, pix.width, pix.height)
