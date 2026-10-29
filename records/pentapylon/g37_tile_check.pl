#!/usr/bin/perl
# g37_tile_check.pl -- THE PERIOD-2 3D COVER RULE TILED ON TORI OF SIDE L, RECOUNTED (ΠΕΝΤΑΠΥΛΟΝ G37b, 2026-10-29 06:2x EDT): the rule, six links of
# the 2x2x2 cell -- (0,0,0)+e1 (0,0,1)+e2 (0,1,1)+e2 (1,0,0)+e1 (1,1,0)+e3 (1,1,1)+e3 -- repeated with period 2 on (Z/L)^3 (L even); every plaquette's
# links listed afresh and the rule's members among them counted; the verdict is the number of plaquettes with a count other than one.
use strict; use warnings; my @RULE = ([0,0,0,0], [0,0,1,1], [0,1,1,1], [1,0,0,0], [1,1,0,2], [1,1,1,2]);   # (x, y, z, direction 0..2)
my %R = map { join(',', @$_) => 1 } @RULE;
sub inrule { my ($x, $y, $z, $d) = @_; return $R{join(',', $x % 2, $y % 2, $z % 2, $d)} ? 1 : 0 }
for my $L (2, 4, 6, 8) { my ($bad, $np, $nl) = (0, 0, 0); my @e = ([1,0,0], [0,1,0], [0,0,1]);
  for my $x (0 .. $L - 1) { for my $y (0 .. $L - 1) { for my $z (0 .. $L - 1) { for my $d (0 .. 2) { $nl += inrule($x, $y, $z, $d) }
    for my $a (0 .. 2) { for my $b ($a + 1 .. 2) { $np++; my @p = ($x, $y, $z);
      my @q = map { ($p[$_] + $e[$a][$_]) % $L } 0 .. 2; my @r = map { ($p[$_] + $e[$b][$_]) % $L } 0 .. 2;
      my $n = inrule(@p, $a) + inrule(@q, $b) + inrule(@r, $a) + inrule(@p, $b); $bad++ unless $n == 1 } } } } }
  printf "G37-TILE period-2 rule on (Z/%d)^3: %d plaquettes, %d rule links (density %.4f per site), %d plaquettes with a count other than one [%s]\n", $L, $np, $nl, $nl / $L ** 3, $bad, $bad ? 'TILE-RED' : 'TILE-VERIFIED' }
