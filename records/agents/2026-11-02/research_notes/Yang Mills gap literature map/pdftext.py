import sys, re
import fitz  # PyMuPDF
# usage: python pdftext.py <pdf> <out.txt> [first_page last_page]
pdf, out = sys.argv[1], sys.argv[2]
a = int(sys.argv[3]) if len(sys.argv) > 3 else 0
d = fitz.open(pdf)
b = int(sys.argv[4]) if len(sys.argv) > 4 else len(d)
with open(out, 'w', encoding='utf-8') as h:
    for i in range(a, min(b, len(d))):
        h.write('\n=== PAGE %d ===\n' % (i + 1))
        h.write(d[i].get_text())
print('pages', len(d), 'wrote', out)
