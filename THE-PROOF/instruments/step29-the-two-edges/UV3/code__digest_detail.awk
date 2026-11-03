/^DETAIL/ {print; next}
/^  rung/ {
  line = $0
  out = substr(line, 1, 9)
  n = split(line, parts, /, /)
  for (i = 1; i <= n; i++) {
    p = parts[i]
    if (match(p, /([A-Za-z0-9]+) = \[+([-0-9.e+]+)/, m)) out = out " " m[1] "=" sprintf("%.6g", m[2])
    if (match(p, /\(([0-9.]+) decades\)/, m2)) out = out " dec=" m2[1]
  }
  print out
}
