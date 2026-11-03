{
  if (index($0, "    if rung in (\"G\", \"Gp\"):") == 1) { sub(/\("G", "Gp"\)/, "(\"G\", \"Gp\", \"H\")"); print; next }
  if (index($0, "        COST = X * Mi ** D if rung == \"G\" else Mi ** D") == 1) { print; next }
  if (index($0, "        K = iv.log(SQRT2 * (D - 1) * ell * cF * P / ((1 - 1 / SQRT2) * iv.sin(iv.pi / (2 * (ell + 1)))))") == 1 && !doneG) {
    print "        if rung == \"H\":                          # WORK.md 13/16.3: multiscale R-operation (projection): the row g P M <= 1"
    print "            K = iv.log(Mi * P)"
    print "        else:"
    print "            K = iv.log(SQRT2 * (D - 1) * ell * cF * P / ((1 - 1 / SQRT2) * iv.sin(iv.pi / (2 * (ell + 1)))))"
    doneG = 1; next
  }
  if ($0 ~ /^RUNGS = /) { print "RUNGS = [\"A\", \"B\", \"C\", \"Cm\", \"D\", \"Dm\", \"E\", \"F\", \"Fp\", \"G\", \"Gp\", \"H\"]"; next }
  if (index($0, "for L in list(range(3, 21)) + [24, 30, 40]:") == 1) { print "for L in list(range(3, 17)):"; next }
  if (index($0, "print(\"   L      M   X_small  PS(q1=1) PS(q1=0) |") == 1) { print "print(\"   L      M   X_small  PS(q1=1) PS(q1=0) |       A       A'        B        C       Cm        D       Dm        E        F       Fp        G       Gp        H\")"; next }
  if (index($0, "for k in [\"A\", \"A'\", \"B\", \"C\", \"Cm\", \"D\", \"Dm\", \"E\", \"F\", \"Fp\", \"G\", \"Gp\"]))") > 0) { sub(/"Gp"\]/, "\"Gp\", \"H\"]"); print; next }
  if ($0 ~ /^for r in \["A", "A'", "B", "C", "Cm", "D", "Dm", "E", "F", "Fp", "G", "Gp"\]:$/) { print "for r in [\"A\", \"A'\", \"B\", \"C\", \"Cm\", \"D\", \"Dm\", \"E\", \"F\", \"Fp\", \"G\", \"Gp\", \"H\"]:"; next }
  print
}
