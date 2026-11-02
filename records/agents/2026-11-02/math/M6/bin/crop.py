import sys, fitz
# usage: crop.py <pdf> <out.png> <first_journal_page> <page> <y0frac> <y1frac> [dpi]
pdf, out, first, p, y0, y1 = sys.argv[1], sys.argv[2], int(sys.argv[3]), int(sys.argv[4]), float(sys.argv[5]), float(sys.argv[6])
dpi = int(sys.argv[7]) if len(sys.argv) > 7 else 220
doc = fitz.open(pdf); pg = doc[p - first]; r = pg.rect
clip = fitz.Rect(r.x0, r.y0 + y0 * r.height, r.x1, r.y0 + y1 * r.height)
pix = pg.get_pixmap(dpi=dpi, colorspace=fitz.csGRAY, clip=clip); pix.save(out); print(out, pix.width, pix.height)
