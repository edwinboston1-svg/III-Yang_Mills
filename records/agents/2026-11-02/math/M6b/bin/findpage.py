import sys, fitz
pdf, first, needle = sys.argv[1], int(sys.argv[2]), sys.argv[3]
doc = fitz.open(pdf)
for i, pg in enumerate(doc):
    t = pg.get_text()
    if needle in t:
        print(first + i)
