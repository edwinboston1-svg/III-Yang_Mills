import sys, fitz
# usage: render_clip.py <pdf> <out.png> <first_journal_page> <page> <dpi> <y0frac> <y1frac>
pdf, out, first, page, dpi, y0, y1 = sys.argv[1], sys.argv[2], int(sys.argv[3]), int(sys.argv[4]), int(sys.argv[5]), float(sys.argv[6]), float(sys.argv[7])
doc = fitz.open(pdf)
pg = doc[page - first]
r = pg.rect
clip = fitz.Rect(r.x0, r.y0 + y0 * r.height, r.x1, r.y0 + y1 * r.height)
pix = pg.get_pixmap(dpi=dpi, clip=clip, colorspace=fitz.csGRAY)
pix.save(out)
print(out, pix.width, pix.height)
