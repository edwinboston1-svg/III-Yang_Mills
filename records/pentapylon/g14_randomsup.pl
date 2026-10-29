#!/usr/bin/perl
# g14_randomsup.pl -- THE SUP OVER DATA READ LINK BY LINK: the randomall record's per-link influences against the symmetric datum's orbit values,
# by face-distance class (ΠΕΝΤΑΠΥΛΟΝ G14d, 2026-10-29 01:2x EDT).  usage: perl g14_randomsup.pl symmetric-record randomall-record
use strict; use warnings;
my ($SYM, $RND) = @ARGV; die "usage: sym rnd" unless defined $RND;
my @CUBE; for my $d (1 .. 3) { for my $x (0, 1) { for my $y (0, 1) { for my $z (0, 1) { my @p = ($x, $y, $z, 0); next if $p[$d - 1] == 1; push @CUBE, [[@p], $d] } } } }
sub key { my ($p, $d) = @_; return join(',', @$p) . ":$d" } sub vadd { my ($p, $k, $s) = @_; my @q = @$p; $q[$k - 1] += $s; return \@q }
my $T0 = key([0, 0, 1, 0], 1); my %faces; for my $e (@CUBE) { my ($p, $d) = @$e; for my $k (1 .. 3) { next if $k == $d; my ($u, $v) = sort { $a <=> $b } ($d, $k); my ($w) = grep { $_ != $d && $_ != $k } 1 .. 3; push @{$faces{"$u$v" . $p->[$w - 1]}}, key($p, $d) } }
my %adj; for my $f (values %faces) { for my $a (@$f) { for my $b (@$f) { $adj{$a}{$b} = 1 } } } my %DIST; for my $e (@CUBE) { my $k = key(@$e); $DIST{$k} = $k eq $T0 ? 0 : ($adj{$T0}{$k} ? 1 : 2) }
my %OUTD; for my $e (@CUBE) { my ($p, $d) = @$e; my $pd = vadd($p, $d, 1); my $de = $DIST{key($p, $d)}; for my $k (1 .. 4) { next if $k == $d; my @sides = ($k == 4) ? (1, -1) : ($p->[$k - 1] == 1 ? (1) : (-1));
  for my $s (@sides) { my @ls = (($s > 0) ? key($pd, $k) : key(vadd($pd, $k, -1), $k), key(vadd($p, $k, $s), $d), ($s > 0) ? key($p, $k) : key(vadd($p, $k, -1), $k)); for my $l (@ls) { $OUTD{$l} = $de if !exists $OUTD{$l} || $de < $OUTD{$l} } } } }
sub mapkey { my ($k, $m) = @_; my ($b, $d) = split /:/, $k; my @p = split /,/, $b; my @q = @p; $q[$d - 1] += 1; my @ends = (\@p, \@q);
  my @im = map { my @r = @$_; @r = (1 - $r[0], $r[1], $r[2], $r[3]) if $m & 1; @r = ($r[0], 1 - $r[2], 1 - $r[1], $r[3]) if $m & 2; @r = ($r[0], $r[1], $r[2], -$r[3]) if $m & 4; \@r } @ends;
  my ($dd) = grep { $im[0][$_] != $im[1][$_] } 0 .. 3; my $lo = ($im[0][$dd] < $im[1][$dd]) ? $im[0] : $im[1]; return join(',', @$lo) . ':' . ($dd + 1) }
sub canon { my $k = shift; my @o = sort map { mapkey($k, $_) } 0 .. 7; return $o[0] }
my (%symrho, $beta, $symsum); open my $fh, '<', $SYM or die; while (<$fh>) { $beta = $1 if /^G14-CUBE beta=([\d.]+)/; if (/^G14-ORBIT j=(\S+) size=\d+ rho=([\d.]+)/) { $symrho{canon($1)} = $2 } $symsum = $1 if /^G14-SYM .* = ([\d.]+) \(criterion/ } close $fh;
my %tr; open $fh, '<', $RND or die; while (<$fh>) { if (/^G14-RANDOM-LINK trial=(\d+) j=(\S+) rho=([\d.]+)/) { $tr{$1}{$2} = $3 } } close $fh;
printf "G14RS beta=%s symmetric DS-sum/|V|=%s; trials with complete link sets: %s\n", $beta, $symsum, join(' ', grep { scalar(keys %{$tr{$_}}) == 88 } sort { $a <=> $b } keys %tr);
for my $t (sort { $a <=> $b } keys %tr) { my $n = scalar keys %{$tr{$t}}; my (%sum, %max, %arg, %symc); for my $j (keys %{$tr{$t}}) { my $d = $OUTD{$j}; my $r = $tr{$t}{$j}; my $s = $symrho{canon($j)} // 0; $sum{$d} += $r; $symc{$d} += $s; my $q = $s > 0 ? $r / $s : 0; if (!defined $max{$d} || $q > $max{$d}) { $max{$d} = $q; $arg{$d} = sprintf("%s rho=%.5f sym=%.5f", $j, $r, $s) } }
  my $tot = 0; $tot += $sum{$_} for keys %sum; printf "G14RS trial=%d links=%d/88 DS-sum/|V| at this datum=%.6f (symmetric %s)%s\n", $t, $n, $tot, $symsum // '?', $n < 88 ? ' PARTIAL' : '';
  for my $d (sort keys %sum) { printf "G14RS trial=%d d=%d sum rho=%.6f (symmetric %.6f, ratio %.3f) max link ratio over symmetric = %.3f at %s\n", $t, $d, $sum{$d}, $symc{$d}, $symc{$d} > 0 ? $sum{$d} / $symc{$d} : 0, $max{$d}, $arg{$d} } }
