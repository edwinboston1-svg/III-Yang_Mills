# cei_gram.awk -- the Gram matrix G = T^H T of a dumped transfer operator, in the dump's own format, so cei_spectrum reads
# the squared singular values of T as G's eigenvalues (campaign §32's control, 2026-11-03: singular values survive a unitary
# equivalence U_B T U_A^-1, eigenvalues survive only a similarity).  usage: gawk -f cei_gram.awk T.txt > G.txt
BEGIN { cnt = 0; n = 0 }   # cnt initialised: an unset awk variable keys an array by the EMPTY STRING, not "0" (the KAT caught it, 03:5x)
NR == 1 { if ($1 != "#" || $2 != "T") { print "CEI-GRAM REFUSED: not a dump (" $0 ")" > "/dev/stderr"; exit 2 }
          n = $3 + 0; if (n < 1 || $5 + 0 != n) { print "CEI-GRAM REFUSED: a bad header (" $0 ")" > "/dev/stderr"; exit 2 }
          hdr = $0; sub(/^# T /, "", hdr); next }
NR > 1 && cnt < n * n { re[cnt] = $1 + 0; im[cnt] = $2 + 0; cnt++; next }
END { if (n < 1) { print "CEI-GRAM REFUSED: no dump read" > "/dev/stderr"; exit 2 }
      if (cnt != n * n) { print "CEI-GRAM REFUSED: " cnt " entries for n = " n > "/dev/stderr"; exit 2 }
      printf "# T %d x %d (row-major; re im), the Gram T^H T of the dump headed: %s\n", n, n, hdr
      for (j = 0; j < n; j++) for (k = 0; k < n; k++) { gr = 0; gi = 0
        for (i = 0; i < n; i++) { a = i * n + j; b = i * n + k; gr += re[a] * re[b] + im[a] * im[b]; gi += re[a] * im[b] - im[a] * re[b] }
        printf "%.17e %.17e\n", gr, gi } }
