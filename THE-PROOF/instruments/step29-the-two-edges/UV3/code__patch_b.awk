{
  if ($0 ~ /^RUNGS = \["A", "B", "C", "D", "E", "F", "G"\]$/) { print "RUNGS = [\"A\", \"B\", \"C\", \"Cm\", \"D\", \"Dm\", \"E\", \"F\", \"Fp\", \"G\", \"Gp\"]"; next }
  if (index($0, "print(\"   L      M   X_small  PS(q1=1) PS(q1=0) |") == 1) { print "print(\"   L      M   X_small  PS(q1=1) PS(q1=0) |       A       A'        B        C       Cm        D       Dm        E        F       Fp        G       Gp\")"; next }
  if (index($0, "for k in [\"A\", \"A'\", \"B\", \"C\", \"D\", \"E\", \"F\", \"G\"]))") > 0) { sub(/\["A", "A'", "B", "C", "D", "E", "F", "G"\]/, "[\"A\", \"A'\", \"B\", \"C\", \"Cm\", \"D\", \"Dm\", \"E\", \"F\", \"Fp\", \"G\", \"Gp\"]"); print; next }
  if ($0 ~ /^for r in \["A", "A'", "B", "C", "D", "E", "F", "G"\]:$/) { print "for r in [\"A\", \"A'\", \"B\", \"C\", \"Cm\", \"D\", \"Dm\", \"E\", \"F\", \"Fp\", \"G\", \"Gp\"]:"; next }
  if (index($0, "parts.append(f\"{k} = {mpmath.nstr(det[k].a, 6)}\")") > 0) { sub(/mpmath.nstr\(det\[k\].a, 6\)/, "mpmath.nstr(mpf(det[k].a.a), 6)"); print; next }
  if (index($0, "print(f\"  rung {r}: X = {mpmath.nstr(X.a, 10)}") > 0) { sub(/mpmath.nstr\(X.a, 10\)/, "mpmath.nstr(mpf(X.a.a), 10)"); print; next }
  print
}
