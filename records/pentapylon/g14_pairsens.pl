#!/usr/bin/perl
# g14_pairsens.pl -- THE PER-LINK MARGINAL SENSITIVITIES OF THE INTERIOR LINK t_0 TO THE BOUNDARY LINKS OF THE delta MODE'S TEN PAIRS (ΠΕΝΤΑΠΥΛΟΝ
# G14e, 2026-10-29 01:5x EDT; the orchestrating seat's (2)): rho_{t0,u} = TV of t_0's conditional marginal under the worst 48-design change of u, read
# from the symmetric-data record by the link's orbit and from the per-link random-data record where the link has been read.
# usage: perl g14_pairsens.pl sym-record randomall-record
use strict; use warnings;
my ($SYM, $RND) = @ARGV; die "usage" unless defined $RND;
sub mapkey { my ($k, $m) = @_; my ($b, $d) = split /:/, $k; my @p = split /,/, $b; my @q = @p; $q[$d - 1] += 1; my @ends = (\@p, \@q);
  my @im = map { my @r = @$_; @r = (1 - $r[0], $r[1], $r[2], $r[3]) if $m & 1; @r = ($r[0], 1 - $r[2], 1 - $r[1], $r[3]) if $m & 2; @r = ($r[0], $r[1], $r[2], -$r[3]) if $m & 4; \@r } @ends;
  my ($dd) = grep { $im[0][$_] != $im[1][$_] } 0 .. 3; my $lo = ($im[0][$dd] < $im[1][$dd]) ? $im[0] : $im[1]; return join(',', @$lo) . ':' . ($dd + 1) }
sub canon { my $k = shift; my @o = sort map { mapkey($k, $_) } 0 .. 7; return $o[0] }
my (%sym, $beta); open my $f, '<', $SYM or die; while (<$f>) { $beta = $1 if /^G14-CUBE beta=([\d.]+)/; $sym{canon($1)} = $2 if /^G14-ORBIT j=(\S+) size=\d+ rho=([\d.]+)/ } close $f;
my %rnd; open $f, '<', $RND or die; while (<$f>) { $rnd{$1}{$2} = $3 if /^G14-RANDOM-LINK trial=(\d+) j=(\S+) rho=([\d.]+)/ } close $f;
# the delta mode's links: under the bottom edge b0 = (0,0,0,0):1 the parallel link (0,0,-1,0):1 and the near vertical (0,0,-1,0):3; above the top edges
# t_j the parallel links at z = 2 and the near vertical above t0 (0,0,1,0):3
my @links = ('0,0,-1,0:1', '0,0,-1,0:3', '0,0,2,0:1', '1,0,2,0:2', '0,1,2,0:1', '0,0,2,0:2', '0,0,1,0:3');
my %role = ('0,0,-1,0:1' => 'u: parallel under b0', '0,0,-1,0:3' => 'u: near vertical under b0', '0,0,2,0:1' => "u': parallel above t0", '1,0,2,0:2' => "u': parallel above t1", '0,1,2,0:1' => "u': parallel above t2", '0,0,2,0:2' => "u': parallel above t3", '0,0,1,0:3' => "u': near vertical above t0");
printf "G14E beta=%s rho_{t0,link} = TV(marginal of t_0 | d, | d with the link changed), the worst change over the 48-design; t_0 = (0,0,1,0):1 (the top edge t0)\n", $beta;
for my $l (@links) { my $s = $sym{canon($l)} // 'absent'; my @r = map { defined $rnd{$_}{$l} ? sprintf('%.6f', $rnd{$_}{$l}) : '-' } sort { $a <=> $b } keys %rnd; printf "G14E link=%-12s %-28s symmetric=%s  random data: %s\n", $l, $role{$l}, ref($s) ? $s : (($s eq 'absent') ? $s : sprintf('%.6f', $s)), join(' ', @r) || 'none read yet' }
