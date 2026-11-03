# hdrfix.awk -- the su2mhb header line: insert the geometry argument for the %s (the patch's first sub matched the format, not the argument list)
/# su2mhb %s D=%d/ { i = index($0, "\", D, LS, BETA"); if (i > 0) { $0 = substr($0, 1, i) ", BENT ? \"bent\" : \"planar\"" substr($0, i + 1) } }
{ print }
