#!/usr/bin/perl
# perfect_cover.pl -- does Z^4 admit a set L1 of links meeting EVERY plaquette in EXACTLY ONE link (a perfect link-cover of the
# plaquettes, period P in every direction)?  Exact cover by backtracking over the links of the P^4 torus (4 P^4 links, 6 P^4
# plaquettes): choose the first uncovered plaquette, try each of its 4 links whose 6 plaquettes are all uncovered.
# usage: perl perfect_cover.pl <P>
use strict; use warnings;
my $P = shift // 2; my $N = $P**4;
sub site { my ($x) = @_; my $s = 0; for my $i (0..3) { $s = $s * $P + (($x->[$i] % $P) + $P) % $P } $s }
sub addv { my ($x, $i, $k) = @_; my @y = @$x; $y[$i] += $k; \@y }
my (%plq, @plqs); my $np = 0;           # plaquette id by (site, i, j)
my @links; my %lid; my $nl = 0;
for my $s (0..$N-1) { my @x; my $t = $s; for (my $i = 3; $i >= 0; $i--) { $x[$i] = $t % $P; $t = int($t/$P) }
  for my $i (0..3) { $lid{"$s,$i"} = $nl++; push @links, [\@x, $i] } }
my @lp;                                  # links -> plaquettes
for my $s (0..$N-1) { my @x; my $t = $s; for (my $i = 3; $i >= 0; $i--) { $x[$i] = $t % $P; $t = int($t/$P) }
  for my $i (0..2) { for my $j ($i+1..3) { my $id = $np++;
    my @ls = ($lid{site(\@x).",$i"}, $lid{site(addv(\@x,$j,1)).",$i"}, $lid{site(\@x).",$j"}, $lid{site(addv(\@x,$i,1)).",$j"});
    $plqs[$id] = \@ls; push @{$lp[$_]}, $id for @ls } } }
my @cov = (0) x $np; my @chosen; my $nodes = 0;
sub solve {
  my $p0 = -1; for my $p (0..$np-1) { if (!$cov[$p]) { $p0 = $p; last } }
  return 1 if $p0 < 0;
  $nodes++; return 0 if $nodes > 5e6;
  for my $l (@{$plqs[$p0]}) { my $ok = 1; for my $q (@{$lp[$l]}) { if ($cov[$q]) { $ok = 0; last } } next unless $ok;
    $cov[$_] = 1 for @{$lp[$l]}; push @chosen, $l;
    return 1 if solve(); pop @chosen; $cov[$_] = 0 for @{$lp[$l]} }
  0 }
my $r = solve();
print "P=$P links=$nl plaquettes=$np nodes=$nodes result=", ($r ? "FOUND |L1|=".scalar(@chosen) : ($nodes > 5e6 ? "UNDECIDED (node cap)" : "NONE")), "\n";
if ($r) { for my $l (@chosen) { my ($x, $i) = @{$links[$l]}; print "  link (", join(",", @$x), ") dir ", $i+1, "\n" } }
