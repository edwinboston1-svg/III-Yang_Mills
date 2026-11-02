import importlib
for m in ["fitz","pypdfium2","pdf2image","PIL","mpmath","numpy","scipy","sympy"]:
    try:
        importlib.import_module(m); print(m,"OK")
    except Exception as e:
        print(m,"NO",type(e).__name__)
