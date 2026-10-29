#!/usr/bin/perl
# g14_ratios.pl -- THE CUBE'S INFLUENCES SORTED BY FACE DISTANCE AND READ AGAINST THE PROPAGATION BOUND (ΠΕΝΤΑΠΥΛΟΝ G14b, 2026-10-28 23:4x EDT;
# the plan seat's three questions of 23:3x).  For every outside link j of g14's cube the FACE DISTANCE d(j) = min over the cube edges e whose
# external plaquettes hold j of the number of cube faces between t_0 and e (0 for t_0's own plaquettes, 1 across one face, 2 across two); the
# record's orbit influences rho_j at the symmetric data are read against a_1^d rho_1 with rho_1 the record's own direct anchor (the sign flip
# of a staple link of t_0) -- the ratio is the per-path factor f_d; per distance class: the links, the nonzero count, the ratio's range and
# the class's share of the DS sum.  The geometry re-derived here from the labels (base (0,0,1,0), direction 1 for t_0; the cube spans
# [0,1]^3 x {0}; a link's external plaquettes as g14 builds them), two-sided: every one of the 88 links lands in exactly one class.
# usage: perl g14_ratios.pl record [record ...]
use strict; use warnings;
my @CUBE; for my $d (1 .. 3) { for my $x (0, 1) { for my $y (0, 1) { for my $z (0, 1) { my @p = ($x, $y, $z, 0); next if $p[$d - 1] == 1; push @CUBE, [[@p], $d] } } } } die scalar(@CUBE) unless @CUBE == 12;
sub key { my ($p, $d) = @_; return join(',', @$p) . ":$d" }
my %DIST; { my %face; for my $e (@CUBE) { my ($p, $d) = @$e; for my $k (1 .. 3) { next if $k == $d; my @q = @$p; my ($u, $v) = sort { $a <=> $b } ($d, $k); my $w = ({1=>0,2=>0,3=>0}, grep { $_ != $d && $_ != $k } 1 .. 3)[1]; my $c = $p->[$w - 1]; push @{$face{"$u$v$c"}}, key($p, $d) } }
  my $t0 = key([0, 0, 1, 0], 1); my %adj; for my $f (values %face) { for my $a (@$f) { for my $b (@$f) { $adj{$a}{$b} = 1 } } }
  for my $e (@CUBE) { my $k = key(@$e); $DIST{$k} = $k eq $t0 ? 0 : ($adj{$t0}{$k} ? 1 : 2) } }
sub vadd { my ($p, $k, $s) = @_; my @q = @$p; $q[$k - 1] += $s; return \@q }
my %OUTD; for my $e (@CUBE) { my ($p, $d) = @$e; my $pd = vadd($p, $d, 1); my $de = $DIST{key($p, $d)};
  for my $k (1 .. 4) { next if $k == $d; my @sides = ($k == 4) ? (1, -1) : ($p->[$k - 1] == 1 ? (1) : (-1));
    for my $s (@sides) { my @ls = (($s > 0) ? key($pd, $k) : key(vadd($pd, $k, -1), $k), key(vadd($p, $k, $s), $d), ($s > 0) ? key($p, $k) : key(vadd($p, $k, -1), $k));
      for my $l (@ls) { $OUTD{$l} = $de if !exists $OUTD{$l} || $de < $OUTD{$l} } } } }
my $n = scalar keys %OUTD; die "outside links: $n, not 88" unless $n == 88; my %cnt; $cnt{$_}++ for values %OUTD;
printf "G14R-GEOMETRY 88 outside links by face distance from t_0: d=0: %d  d=1: %d  d=2: %d\n", map { $cnt{$_} // 0 } 0 .. 2;
for my $rec (@ARGV) { open my $fh, '<', $rec or die "$rec: $!"; my ($beta, $a1, $rho1, $sum); my @orb;
  while (<$fh>) { if (/^G14-CUBE beta=([\d.]+) a_1=([\d.]+)/) { ($beta, $a1) = ($1, $2) } if (/^G14-ANCHOR direct sign flip .* tv=([\d.]+)/) { $rho1 = $1 } if (/^G14-SYM .* = ([\d.]+) \(criterion/) { $sum = $1 }
    if (/^G14-ORBIT j=(\S+) size=(\d+) rho=([\d.]+)/) { my ($j, $size, $rho) = ($1, $2, $3); die "unknown link $j" unless exists $OUTD{$j}; push @orb, [$j, $size, $rho, $OUTD{$j}] } }
  close $fh; die "$rec: no header" unless defined $beta && defined $rho1; my $law = 4 / (3 * 3.141592653589793) * $beta;
  printf "G14R-RECORD %s: beta=%.4f a_1=%.6f rho_1(measured direct)=%.6f (law (4/3pi)beta=%.6f) DS-sum/|V|=%s; %d orbits\n", $rec, $beta, $a1, $rho1, $law, $sum // '?', scalar @orb;
  my (%links, %nz, %sumd, %rmin, %rmax);
  for my $o (sort { $a->[3] <=> $b->[3] || $b->[2] <=> $a->[2] } @orb) { my ($j, $size, $rho, $d) = @$o; my $bound = $a1 ** $d * $rho1; my $ratio = $rho / $bound;
    $links{$d} += $size; $nz{$d} += $size if $rho > 1e-7; $sumd{$d} += $size * $rho; $rmin{$d} = $ratio if !defined $rmin{$d} || $ratio < $rmin{$d}; $rmax{$d} = $ratio if !defined $rmax{$d} || $ratio > $rmax{$d};
    printf "G14R-ORBIT beta=%.2f d=%d j=%-10s size=%d rho=%.6f  a_1^d rho_1=%.6f  f_%d = rho/(a_1^d rho_1) = %.4f\n", $beta, $d, $j, $size, $rho, $bound, $d, $ratio }
  for my $d (0 .. 2) { printf "G14R-CLASS beta=%.2f d=%d links=%d nonzero=%d sum_j rho=%.6f (share of the DS sum %.4f)  f_%d in [%.4f, %.4f]  (one-face bound a_1^d rho_1 x links = %.6f)\n", $beta, $d, $links{$d} // 0, $nz{$d} // 0, $sumd{$d} // 0, ($sum ? ($sumd{$d} // 0) / $sum : 0), $d, $rmin{$d} // 0, $rmax{$d} // 0, $a1 ** $d * $rho1 * ($links{$d} // 0) }
  my $c1 = ($sumd{1} // 0) / ($a1 * $rho1); my $c2 = ($sumd{2} // 0) / ($a1 * $a1 * $rho1);
  printf "G14R-STEP beta=%.2f the effective next-link count per step: C_1 = sum_{d=1} rho / (a_1 rho_1) = %.4f against 18 (the path bound's)  C_2 = sum_{d=2} rho / (a_1^2 rho_1) = %.4f; the certified radius of the propagation series by C_1: 1/(C_1 a_1) = 1 at beta where C_1 a_1 = 1 (here C_1 a_1 = %.4f)\n", $beta, $c1, $c2, $c1 * $a1 }
