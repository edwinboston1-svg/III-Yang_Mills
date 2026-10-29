#!/usr/bin/perl
# g27_blocksplit.pl -- WHERE A BLOCK CRITERION PAYS ON THE PERFECT DECIMATION: the row sum's incidences split by the side-2 block (ΠΕΝΤΑΠΥΛΟΝ G27,
# 2026-10-29 03:3x EDT, the desktop seat; iii-43's (4) of 03:2x).  A READING of the bound's bookkeeping, not a theorem: a Dobrushin-Shlosman block
# criterion does not simply drop in-block neighbours (the block's own conditional law and its response to the outside both enter); this counts
# what the uniform-constant row ROW = 12 C_dir + 90 C_med would be if the neighbours sharing y's side-2 block were removed, to show where it pays.
# THE GEOMETRY.  The perfect decimation S: one link per site, every plaquette meeting exactly one S link -- the period-2 cover g25_cubecover.pl
# finds (kind=link), extended periodically to Z^4.  For a kept link y (not in S): its six plaquettes p each carry one S link a_p; TYPE I neighbours
# are p's two other kept links (12 incidences); TYPE II are the three kept links of each of a_p's five other plaquettes (90).  Side-2 blocks are
# {2k_1, 2k_1+1} x ... x {2k_4, 2k_4+1}; a link is INTRA-block when both its ends lie in one block (its base coordinate even in its direction).  For
# every kept link class (base mod 2, direction) the incidences are counted, split into in-block (both y and y' intra-block in the same block) and
# out-of-block, TYPE II also split by which of a_p's five other plaquettes (the one coplanar with p, or the four in the other two planes).
# STAKED BEFORE THE COUNT (03:3x EDT): for an intra-block kept link at least a quarter of its 102 incidences lie in its block, and the row with
# them removed is below 1 at beta = 0.26 and at 0.28 (C_dir, C_med from g24's formula with the PROVED constants at those couplings (the sharp set is certified only for 6 beta <= 1.5), entered on the command line).
# usage: perl g27_blocksplit.pl
use strict; use warnings; $| = 1;
# the period-2 cover: d(x mod 2) from g25's members at period (2,2,2,2), kind=link (re-derived here by the same exact cover, so this file stands alone)
my %D; { my @cand; my $NS = 16; my @L = (2, 2, 2, 2);
  my $sidx = sub { my @x = @_; my $i = 0; for my $d (0 .. 3) { $i = $i * 2 + ((($x[$d] % 2) + 2) % 2) } return $i };
  my $pid = sub { my ($x, $a, $b) = @_; my @pairs = ([0,1],[0,2],[0,3],[1,2],[1,3],[2,3]); my ($k) = grep { $pairs[$_][0] == $a && $pairs[$_][1] == $b } 0 .. 5; return $sidx->(@$x) * 6 + $k };
  for my $s (0 .. 15) { my @x = map { ($s >> (3 - $_)) & 1 } 0 .. 3; for my $d (0 .. 3) { my %t; for my $e (0 .. 3) { next if $e == $d; my ($a, $b) = sort { $a <=> $b } ($d, $e); my @y = @x; $y[$e] -= 1; $t{$pid->(\@x, $a, $b)} = 1; $t{$pid->(\@y, $a, $b)} = 1 } push @cand, [[ sort { $a <=> $b } keys %t ], $s, $d] } }
  my @cov = (0) x 96; my @sol; my $ok;
  my $rec; $rec = sub { my ($bc) = grep { !$cov[$_] } 0 .. 95; return 1 unless defined $bc; for my $c (@cand) { next unless grep { $_ == $bc } @{$c->[0]}; next if grep { $cov[$_] } @{$c->[0]}; $cov[$_] = 1 for @{$c->[0]}; push @sol, $c; return 1 if $rec->(); pop @sol; $cov[$_] = 0 for @{$c->[0]} } return 0 };
  $ok = $rec->(); die "no period-2 cover" unless $ok; $D{$_->[1]} = $_->[2] for @sol }
sub cell { my @x = @_; my $s = 0; for my $d (0 .. 3) { $s = $s * 2 + ((($x[$d] % 2) + 2) % 2) } return $s }
sub inS { my ($x, $d) = @_; return $D{cell(@$x)} == $d }
sub lkey { my ($x, $d) = @_; return join(',', @$x) . ":$d" }
sub plaq_links { my ($x, $a, $b) = @_; my @xa = @$x; $xa[$a]++; my @xb = @$x; $xb[$b]++; return ([[@$x], $a], [\@xa, $b], [\@xb, $a], [[@$x], $b]) }   # the four links of plaquette (x; a, b)
sub plaqs_of { my ($x, $d) = @_; my @p; for my $e (0 .. 3) { next if $e == $d; my ($a, $b) = sort { $a <=> $b } ($d, $e); push @p, [[@$x], $a, $b]; my @y = @$x; $y[$e]--; push @p, [\@y, $a, $b] } return @p }
sub intra { my ($x, $d) = @_; return ($x->[$d] % 2 + 2) % 2 == 0 }
sub blockof { my ($x) = @_; return join(',', map { int(($_ - (($_ % 2 + 2) % 2)) / 2) } @$x) }
# C_dir, C_med at the couplings (g24's formula, sharp constants; values from the g24 machinery at these couplings, entered from its record run below)
my %CC = (0.26 => [undef, undef], 0.28 => [undef, undef]);
if (@ARGV) { for my $a (@ARGV) { my ($b, $cd, $cm) = split /:/, $a; $CC{$b} = [$cd, $cm] } }
my (%tot, %inb, %t2plane); my $classes = 0;
for my $s (0 .. 15) { my @x = map { ($s >> (3 - $_)) & 1 } 0 .. 3; for my $d (0 .. 3) { next if inS(\@x, $d); $classes++;
  my $yk = lkey(\@x, $d); my $yintra = intra(\@x, $d); my $yb = blockof(\@x);
  my ($n1, $n1in, $n2, $n2in, %plane) = (0, 0, 0, 0);
  for my $p (plaqs_of(\@x, $d)) { my @ls = plaq_links(@$p); my ($a) = grep { inS($_->[0], $_->[1]) } @ls; die "plaquette without its S link" unless $a; my @S = grep { inS($_->[0], $_->[1]) } @ls; die "plaquette with two S links" if @S != 1;
    for my $l (@ls) { next if lkey(@$l) eq $yk || inS(@$l); $n1++; $n1in++ if $yintra && intra(@$l) && blockof($l->[0]) eq $yb }
    # a's five other plaquettes
    my $pkey = join(',', @{$p->[0]}) . ";$p->[1],$p->[2]";
    for my $q (plaqs_of(@$a)) { my $qkey = join(',', @{$q->[0]}) . ";$q->[1],$q->[2]"; next if $qkey eq $pkey; my $cop = ($q->[1] == $p->[1] && $q->[2] == $p->[2]) ? 'coplanar' : 'other-plane';
      for my $l (plaq_links(@$q)) { next if inS(@$l); $n2++; $plane{$cop}++; $n2in++ if $yintra && intra(@$l) && blockof($l->[0]) eq $yb } } }
  my $tag = $yintra ? 'intra' : 'inter'; $tot{$tag}{I} += $n1; $tot{$tag}{II} += $n2; $inb{$tag}{I} += $n1in; $inb{$tag}{II} += $n2in; $tot{$tag}{n}++; $t2plane{$tag}{$_} += $plane{$_} for keys %plane;
  printf "G27-LINK y=%s (%s) TYPE I %d (in-block %d), TYPE II %d (in-block %d; coplanar %d, other-plane %d)\n", $yk, $tag, $n1, $n1in, $n2, $n2in, $plane{coplanar} // 0, $plane{'other-plane'} // 0 } }
for my $tag (sort keys %tot) { my $n = $tot{$tag}{n}; my ($fI, $fII) = ($inb{$tag}{I} / $tot{$tag}{I}, $inb{$tag}{II} / $tot{$tag}{II});
  printf "G27-CLASS %s kept links: %d classes; per link TYPE I %.2f (in-block %.2f, fraction %.3f), TYPE II %.2f (in-block %.2f, fraction %.3f); TYPE II coplanar %.2f other-plane %.2f per link\n", $tag, $n, $tot{$tag}{I} / $n, $inb{$tag}{I} / $n, $fI, $tot{$tag}{II} / $n, $inb{$tag}{II} / $n, $fII, ($t2plane{$tag}{coplanar} // 0) / $n, ($t2plane{$tag}{'other-plane'} // 0) / $n;
  for my $b (sort keys %CC) { my ($cd, $cm) = @{$CC{$b}}; next unless defined $cd; my $full = 12 * $cd + 90 * $cm; my $red = 12 * (1 - $fI) * $cd + 90 * (1 - $fII) * $cm;
    printf "G27-ROW beta=%s %s: the full row 12 C_dir + 90 C_med = %.6f; with the in-block incidences removed %.6f  [%s]\n", $b, $tag, $full, $red, $red < 1 ? 'BELOW-1' : 'AT-OR-ABOVE-1' } }
