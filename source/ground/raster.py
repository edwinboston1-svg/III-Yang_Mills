import sys
import fitz  # PyMuPDF

pdf, outdir, dpi = sys.argv[1], sys.argv[2], int(sys.argv[3]) if len(sys.argv) > 3 else 70
doc = fitz.open(pdf)
for i, page in enumerate(doc, start=1):
    pix = page.get_pixmap(dpi=dpi)
    pix.save(f"{outdir}/pg-{i:02d}.png")
print("pages", len(doc))
