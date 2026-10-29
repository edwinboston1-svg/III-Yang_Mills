#!/usr/bin/perl
# g14_shell.pl -- THE d = 1 SHELL OF THE CUBE SPLIT BY HOW MANY OF THE FACE'S OTHER EDGES PIN THE LINK, AND THE ORDER IN beta OF EACH SUB-CLASS
# (ΠΕΝΤΑΠΥΛΟΝ G14c, 2026-10-29 01:2x EDT, the desktop seat; the plan seat's ask of 01:1x for Lemma T's cubic coefficient).
# t_0 lies in two cube faces; in each face F = (t_0, a, y, b) the edge y is parallel to t_0 and a, b are adjacent to it; the d = 1 links are the
# outside links of the dangling plaquettes of a, b, y, a', b', y'.  For a d = 1 link z and each face, the ROLES of the face's other edges whose
# dangling plaquettes contain z are listed (y: opposite, a/b: adjacent); the class is the largest count over the two faces.  Each orbit's rho at
# beta = 0.1, 0.3, 0.5, 0.7 (the symmetric-data records) gives the local order k = ln(rho_2/rho_1)/ln(beta_2/beta_1); a beta^3 class scales by 27
# from 0.1 to 0.3 and 4.63 from 0.3 to 0.5, a beta^4 class by 81 and 7.72.  The 0.1 reading of a d = 1 orbit (~1e-5) sits near the 480-point
# quadrature's floor and is read as such.
# usage: perl g14_shell.pl rec0.1 rec0.3 rec0.5 rec0.7
use strict; use warnings;
my @CUBE; for my $d (1 .. 3) { for my $x (0, 1) { for my $y (0, 1) { for my $z (0, 1) { my @p = ($x, $y, $z, 0); next if $p[$d - 1] == 1; push @CUBE, [[@p], $d] } } } }
sub key { my ($p, $d) = @_; return join(',', @$p) . ":$d" }
sub vadd { my ($p, $k, $s) = @_; my @q = @$p; $q[$k - 1] += $s; return \@q }
my $T0 = key([0, 0, 1, 0], 1);
my %faces;                                                                                       # face id -> list of edge keys
for my $e (@CUBE) { my ($p, $d) = @$e; for my $k (1 .. 3) { next if $k == $d; my ($u, $v) = sort { $a <=> $b } ($d, $k); my ($w) = grep { $_ != $d && $_ != $k } 1 .. 3; my $c = $p->[$w - 1]; push @{$faces{"$u$v$c"}}, key($p, $d) } }
my @F0 = grep { grep { $_ eq $T0 } @{$faces{$_}} } keys %faces; die "t0 in " . scalar(@F0) . " faces" unless @F0 == 2;
my %role;                                                                                        # face -> edge -> role (y opposite, a/b adjacent)
for my $f (@F0) { my @E = grep { $_ ne $T0 } @{$faces{$f}}; my ($t0p, $t0d) = ($T0 =~ /^(.*):(\d)$/); my $ab = 0; for my $e (@E) { my ($ep, $ed) = ($e =~ /^(.*):(\d)$/); $role{$f}{$e} = ($ed == $t0d) ? 'y' : ('a', 'b')[$ab++] } }
my %dangof;                                                                                      # outside link -> { edge => 1 }
for my $e (@CUBE) { my ($p, $d) = @$e; my $pd = vadd($p, $d, 1); my $ek = key($p, $d);
  for my $k (1 .. 4) { next if $k == $d; my @sides = ($k == 4) ? (1, -1) : ($p->[$k - 1] == 1 ? (1) : (-1));
    for my $s (@sides) { my @ls = (($s > 0) ? key($pd, $k) : key(vadd($pd, $k, -1), $k), key(vadd($p, $k, $s), $d), ($s > 0) ? key($p, $k) : key(vadd($p, $k, -1), $k)); $dangof{$_}{$ek} = 1 for @ls } } }
my %dist1 = map { $_ => 1 } map { keys %{$role{$_}} } @F0;                                       # the six edges at face distance 1
sub signature { my $j = shift; return undef if $dangof{$j}{$T0}; my @sig; my $best = 0;
  for my $f (sort @F0) { my @r = sort map { $role{$f}{$_} } grep { $role{$f}{$_} } keys %{$dangof{$j}}; push @sig, (@r ? join('', @r) : '-'); $best = @r if @r > $best }
  return undef unless $best; return ($best, join('|', @sig)) }
# the orbit of an outside link under t_0's stabiliser (g14's eight maps); every record names its orbit by whichever member it met first, so the records are joined by the CANONICAL member
sub mapkey { my ($k, $m) = @_; my ($b, $d) = split /:/, $k; my @p = split /,/, $b; my @q = @p; $q[$d - 1] += 1; my @ends = (\@p, \@q);
  my @im = map { my @r = @$_; @r = (1 - $r[0], $r[1], $r[2], $r[3]) if $m & 1; @r = ($r[0], 1 - $r[2], 1 - $r[1], $r[3]) if $m & 2; @r = ($r[0], $r[1], $r[2], -$r[3]) if $m & 4; \@r } @ends;
  my ($dd) = grep { $im[0][$_] != $im[1][$_] } 0 .. 3; my $lo = ($im[0][$dd] < $im[1][$dd]) ? $im[0] : $im[1]; return join(',', @$lo) . ':' . ($dd + 1) }
sub canon { my $k = shift; my @o = sort map { mapkey($k, $_) } 0 .. 7; return $o[0] }
sub orbit { my $k = shift; my %o = map { mapkey($k, $_) => 1 } 0 .. 7; return [ sort keys %o ] }
my %rho; my @betas;
for my $rec (@ARGV) { open my $fh, '<', $rec or die "$rec: $!"; my $beta; while (<$fh>) { if (/^G14-CUBE beta=([\d.]+)/) { $beta = $1 + 0; push @betas, $beta } if (/^G14-ORBIT j=(\S+) size=(\d+) rho=([\d.]+)/) { my $c = canon($1); $rho{$c}{$beta} = $3; $rho{$c}{size} = $2; $rho{$c}{seen}{$1} = 1 } } close $fh }
@betas = sort { $a <=> $b } @betas; printf "G14S betas read: %s; t0 = %s in faces %s with roles %s\n", join(' ', @betas), $T0, join(' ', sort @F0), join('; ', map { my $f = $_; "$f: " . join(',', map { "$_=$role{$f}{$_}" } sort keys %{$role{$f}}) } sort @F0);
my (%cls, %clsn);
for my $j (sort keys %rho) { my ($best, $sig) = signature($j); next unless defined $best; my %sigs = map { my ($bb, $ss) = signature($_); (defined $bb ? "$bb:$ss" : 'none') => 1 } @{ orbit($j) }; my $inv = (keys %sigs) == 1 ? 'invariant' : 'VARIES(' . join(' ', sort keys %sigs) . ')'; my $r = $rho{$j}; my @k;
  for my $i (1 .. $#betas) { my ($b1, $b2) = ($betas[$i - 1], $betas[$i]); push @k, ($r->{$b1} > 0 && $r->{$b2} > 0) ? sprintf("%.2f", log($r->{$b2} / $r->{$b1}) / log($b2 / $b1)) : 'nan' }
  printf "G14S-ORBIT j=%-10s size=%d class=%d sig=%-8s rho(%s)=%s  k(0.1->0.3)=%s k(0.3->0.5)=%s k(0.5->0.7)=%s\n", $j, $r->{size}, $best, $sig, join('/', @betas), join('/', map { sprintf('%.2e', $r->{$_}) } @betas), @k;
  for my $b (@betas) { $cls{$best}{$b} += $r->{size} * $r->{$b} } $clsn{$best} += $r->{size} }
for my $c (sort keys %cls) { my @k; for my $i (1 .. $#betas) { my ($b1, $b2) = ($betas[$i - 1], $betas[$i]); push @k, sprintf("%.2f", log($cls{$c}{$b2} / $cls{$c}{$b1}) / log($b2 / $b1)) }
  printf "G14S-CLASS pinned-by=%d links=%d sum rho at %s = %s  orders k = %s  (beta^3 reads 3.00, beta^4 4.00)\n", $c, $clsn{$c}, join('/', @betas), join('/', map { sprintf('%.3e', $cls{$c}{$_}) } @betas), join(' / ', @k) }
my $tot = 0; $tot += $clsn{$_} for keys %clsn; printf "G14S-VERDICT %d links in the d = 1 shell split by class: %s\n", $tot, join(', ', map { "$_ pinning edge(s): $clsn{$_} links" } sort keys %clsn);
