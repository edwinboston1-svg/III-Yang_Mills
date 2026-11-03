import sys, fitz
pdf, outdir, pages = sys.argv[1], sys.argv[2], sys.argv[3]
zoom = float(sys.argv[4]) if len(sys.argv) > 4 else 1.6
doc = fitz.open(pdf)
lo, hi = [int(x) for x in pages.split('-')]
for p in range(lo, hi + 1):
    pg = doc[p - 1]
    pix = pg.get_pixmap(matrix=fitz.Matrix(zoom, zoom))
    fn = f"{outdir}/p{p:03d}.png"
    pix.save(fn)
    print(fn, pix.width, pix.height)
