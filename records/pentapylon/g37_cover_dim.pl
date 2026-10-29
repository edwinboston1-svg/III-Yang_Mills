#!/usr/bin/perl
# g37_cover_dim.pl -- THE PERFECT LINK DECIMATION IN DIMENSION D: a periodic set of links of Z^D meeting every plaquette EXACTLY ONCE, found by
# exact cover and verified, with the decimated row's neighbour counts ENUMERATED from the cover (ΠΕΝΤΑΠΥΛΟΝ G37, 2026-10-29 06:1x EDT, the desktop
# seat; the plan seat's C3: "the three-dimensional perfect cover (each link in four plaquettes) and the 3D counts for the 3D Theorem 8.7").
# THE OBJECT: a link of Z^D lies in 2(D-1) plaquettes; a set of links meeting every plaquette exactly once has density (D(D-1)/2)/(2(D-1)) = D/4
# links per site (D = 4: one; D = 3: three quarters; D = 2: one half).  Every plaquette then holds ONE decimated link and three kept ones; integrating
# a decimated link turns its 2(D-1) plaquettes into ONE star term on their 3 x 2(D-1) kept links, and a kept link lies in 2(D-1) stars (one per
# plaquette).  THE COUNTS read from the cover: per kept link, the kept neighbours sharing a plaquette with it inside some star (DIRECT: 2 per star,
# 4(D-1) in all) and the kept links of the star's OTHER plaquettes (MEDIUM: 3(2D-3) per star, 6(D-1)(2D-3) in all) -- D = 4: 12 and 90, the plan
# seat's row; D = 3: 8 and 36 -- with the multiplicity of each neighbour (a neighbour met through two stars is counted twice, as the Dobrushin sum
# over interactions counts it).  THE SEARCH: Knuth's Algorithm X over the torus (Z/L)^D for a period vector (each L even; the plaquette count must be
# divisible by 2(D-1)); the first cover is VERIFIED by an independent recount.  KNOWN ANSWERS: D = 4 at period 2 FOUND (the plan seat's cover, one
# link per site); D = 2 at period 2 FOUND (the horizontal links of even rows); the counts at D = 4 equal 12 and 90 for every kept link.
# usage: perl g37_cover_dim.pl D L1 .. LD [MAXNODES=2e7]
use strict; use warnings; $| = 1;
my ($D, @L) = @ARGV; die "usage: D L1 .. LD [MAXNODES]" unless defined $D && @L >= $D; my $MAXN = (@L > $D) ? pop @L : 2e7; @L = @L[0 .. $D - 1];
my $NS = 1; $NS *= $_ for @L; my $t0 = time;
sub sidx { my @x = @_; my $i = 0; for my $d (0 .. $D - 1) { $i = $i * $L[$d] + (($x[$d] % $L[$d]) + $L[$d]) % $L[$d] } return $i }
sub coords { my $i = shift; my @x; for my $d (reverse 0 .. $D - 1) { unshift @x, $i % $L[$d]; $i = int($i / $L[$d]) } return @x }
my @PAIRS; for my $a (0 .. $D - 1) { for my $b ($a + 1 .. $D - 1) { push @PAIRS, [$a, $b] } } my $NPD = scalar @PAIRS;
sub lid { my ($x, $d) = @_; return sidx(@$x) * $D + $d }
sub pid { my ($x, $a, $b) = @_; my ($k) = grep { $PAIRS[$_][0] == $a && $PAIRS[$_][1] == $b } 0 .. $NPD - 1; return sidx(@$x) * $NPD + $k }
sub vshift { my ($x, $d, $s) = @_; my @y = @$x; $y[$d] += $s; return \@y }
sub plaqs_of_link { my ($x, $d) = @_; my @p; for my $e (0 .. $D - 1) { next if $e == $d; my ($a, $b) = sort { $a <=> $b } ($d, $e); push @p, pid($x, $a, $b), pid(vshift($x, $e, -1), $a, $b) } return @p }
sub links_of_plaq { my ($x, $a, $b) = @_; return (lid($x, $a), lid(vshift($x, $a, 1), $b), lid(vshift($x, $b, 1), $a), lid($x, $b)) }
my $NP = $NS * $NPD; my $NL = $NS * $D; my $per = 2 * ($D - 1);
die "the plaquette count $NP is not divisible by $per" if $NP % $per;
my @cand; for my $s (0 .. $NS - 1) { my @x = coords($s); for my $d (0 .. $D - 1) { my %u = map { $_ => 1 } plaqs_of_link(\@x, $d); die "a link meets a plaquette twice (period too small)" unless keys(%u) == $per; push @cand, [[sort { $a <=> $b } keys %u], lid(\@x, $d)] } }
# ---- Algorithm X (dancing-links-free version: column counts and recursion on the column with fewest candidates)
my @colrows; for my $r (0 .. $#cand) { push @{$colrows[$_]}, $r for @{$cand[$r][0]} }
my (@covered, @sol); my $nodes = 0; my $found = 0; my @alive = (1) x scalar(@cand);
sub search { return 1 if $found; $nodes++; return 0 if $nodes > $MAXN;
  my ($best, $bc) = (1e9, -1); for my $c (0 .. $NP - 1) { next if $covered[$c]; my $n = 0; for my $r (@{$colrows[$c]}) { $n++ if $alive[$r] } if ($n < $best) { $best = $n; $bc = $c; last if $n == 0 } }
  if ($bc < 0) { $found = 1; return 1 } return 0 if $best == 0;
  for my $r (@{$colrows[$bc]}) { next unless $alive[$r]; my @killed; my @cols = @{$cand[$r][0]};
    for my $c (@cols) { $covered[$c] = 1; for my $r2 (@{$colrows[$c]}) { if ($alive[$r2]) { $alive[$r2] = 0; push @killed, $r2 } } }
    push @sol, $r; return 1 if search(); pop @sol;
    $alive[$_] = 1 for @killed; $covered[$_] = 0 for @cols }
  return 0 }
search();
my $plen = join('x', @L);
unless ($found) { printf "G37-RESULT D=%d period %s: %s after %d nodes  (%d s)\n", $D, $plen, $nodes > $MAXN ? 'UNDECIDED (node cap)' : 'NO EXACT COVER', $nodes, time - $t0; exit 0 }
# ---- verify independently: every plaquette's decimated links counted afresh
my %DEC = map { $cand[$_][1] => 1 } @sol; my $bad = 0;
for my $s (0 .. $NS - 1) { my @x = coords($s); for my $pr (@PAIRS) { my $n = grep { $DEC{$_} } links_of_plaq(\@x, @$pr); $bad++ unless $n == 1 } }
my $dens = scalar(@sol) / $NS;
# ---- the counts: for each kept link, its stars (one per plaquette, the star of that plaquette's decimated link), the direct and medium neighbours
my ($dmin, $dmax, $mmin, $mmax, $nk) = (1e9, 0, 1e9, 0, 0); my %starof;                         # starof{decimated link} = its plaquettes
for my $l (keys %DEC) { my $s = int($l / $D); my $d = $l % $D; my @x = coords($s); $starof{$l} = [plaqs_of_link(\@x, $d)] }
my %plaqlinks; for my $s (0 .. $NS - 1) { my @x = coords($s); for my $pr (@PAIRS) { my $p = pid(\@x, @$pr); $plaqlinks{$p} = [links_of_plaq(\@x, @$pr)] } }
for my $s (0 .. $NS - 1) { my @x = coords($s); for my $d (0 .. $D - 1) { my $u = lid(\@x, $d); next if $DEC{$u}; $nk++; my ($dir, $med) = (0, 0);
    for my $p (plaqs_of_link(\@x, $d)) { my ($dl) = grep { $DEC{$_} } @{$plaqlinks{$p}};                          # this plaquette's decimated link: its star
      for my $q (@{$starof{$dl}}) { for my $v (@{$plaqlinks{$q}}) { next if $DEC{$v} || $v == $u; if ($q == $p) { $dir++ } else { $med++ } } } }
    $dmin = $dir if $dir < $dmin; $dmax = $dir if $dir > $dmax; $mmin = $med if $med < $mmin; $mmax = $med if $med > $mmax } }
my ($edir, $emed) = (4 * ($D - 1), 6 * ($D - 1) * (2 * $D - 3));
printf "G37-RESULT D=%d period %s: EXACT COVER FOUND after %d nodes: %d decimated links over %d sites (density %.4f, expected %.4f); independent recount: %d plaquettes with a count other than one [%s]; per kept link (%d kept): DIRECT neighbours %d..%d (expected %d), MEDIUM %d..%d (expected %d) [%s]  (%d s)\n",
  $D, $plen, $nodes, scalar @sol, $NS, $dens, $D / 4, $bad, $bad ? 'COVER-RED' : 'COVER-VERIFIED', $nk, $dmin, $dmax, $edir, $mmin, $mmax, $emed, ($dmin == $edir && $dmax == $edir && $mmin == $emed && $mmax == $emed) ? 'COUNTS-MET' : 'COUNTS-DIFFER', time - $t0;
printf "G37-COVER D=%d: %s\n", $D, join(' ', map { my $l = $cand[$_][1]; my $s = int($l / $D); '(' . join(',', coords($s)) . ')+e' . ($l % $D + 1) } sort { $cand[$a][1] <=> $cand[$b][1] } @sol) if scalar(@sol) <= 64;
