use strict; use warnings; use Math::BigInt; use Math::BigRat;
# g6_inertia.pl -- STAKE 8, THE INERTIA ROAD (DOCS/III-PENTAPYLON-THE-FIVE-GATES-PREREGISTRATION.md): the symmetric sector's two
# leading eigenvalues bracketed by EXACT SIGN COUNTS.  Stage 1's table (g6_dual.pl) gives M_ij = sum_{s in i} <s|T|s0_j> as integer
# polynomials in u; W_ij = D_j M_ij (D the orbit sizes) is symmetric and M = W D^-1 is similar to D^-1/2 W D^-1/2, so the number of
# sector eigenvalues above a rational c is the number of positive pivots of the fraction-free (Bareiss) elimination of W - c D --
# Sylvester's law of inertia and Jacobi's rule on the leading principal minors (W = 0).  No power iteration, no convergence criterion,
# no deflation: the only arithmetic is integer multiply, subtract and exact divide, and the only decision a sign.  u = P/Q, c dyadic.
# usage: perl g6_inertia.pl <table> P Q [BITS] [lambda0-reading] [lambda1-reading]   (the readings are compared exactly, never used)
my ($tab, $P, $Q, $BITS, $r0, $r1) = @ARGV; $BITS //= 48;
open(my $h, '<', $tab) or die "no table $tab"; my (@D, %E, $n, $kmax, $L1, $L2, $NP); $kmax = 0;
while (my $l = <$h>) { $l =~ s/\r?\n$//;
  if ($l =~ /^DUAL-TAB L1=(\d+) L2=(\d+) NP=(\d+) .*orbits=(\d+)/) { ($L1,$L2,$NP,$n) = ($1,$2,$3,$4); next }
  if ($l =~ /^ORB (\d+) size=(\d+)/) { $D[$1] = $2; next }
  if ($l =~ /^M (\d+) (\d+) (.*)$/) { my ($i,$j,$rest) = ($1,$2,$3); for my $f (split ' ', $rest) { my ($k,$c) = split /:/, $f; push @{$E{$i}{$j}}, [$k,$c]; $kmax = $k if $k > $kmax } next }
}
close $h; die "no header" unless defined $n; die "orbit sizes" unless @D == $n;
my $Qk = Math::BigInt->new($Q)->bpow($kmax); my $Pb = Math::BigInt->new($P); my $Qb = Math::BigInt->new($Q);
my @Pp = (Math::BigInt->new(1)); $Pp[$_] = $Pp[$_-1] * $Pb for 1..$kmax;        # P^k
my @Qp = (Math::BigInt->new(1)); $Qp[$_] = $Qp[$_-1] * $Qb for 1..$kmax;        # Q^k
my @W; for my $i (0..$n-1) { for my $j (0..$n-1) { my $s = Math::BigInt->new(0);
  for my $kc (@{$E{$i}{$j} || []}) { my ($k,$c) = @$kc; $s += $Pp[$k] * $Qp[$kmax-$k] * $c }     # Q^kmax * M_ij at u = P/Q
  $W[$i][$j] = $s * $D[$j] } }
for my $i (0..$n-1) { for my $j ($i+1..$n-1) { die "W not symmetric at $i,$j: D_j M_ij != D_i M_ji (the table's own law)" unless $W[$i][$j] == $W[$j][$i] } }
my $rowsum = Math::BigRat->new(0); for my $i (0..$n-1) { my $s = Math::BigRat->new(0); for my $j (0..$n-1) { $s += Math::BigRat->new($W[$i][$j]) / $D[$j] } $rowsum = $s if $s > $rowsum }
$rowsum = $rowsum / Math::BigRat->new($Qk);                                      # max row sum of M: a Perron bound on every eigenvalue
my $counts = 0;
sub inertia_above {                                                                 # the number of eigenvalues of M above c = a / 2^b
  my ($a, $b) = @_; $counts++;
  my $two = Math::BigInt->new(2)->bpow($b); my $sh = $a * $Qk;                     # 2^b (W - c D) = 2^b W - a Q^kmax D
  my @A; for my $i (0..$n-1) { for my $j (0..$n-1) { $A[$i][$j] = $W[$i][$j] * $two; } $A[$i][$i] -= $sh * $D[$i] }
  my $prev = Math::BigInt->new(1); my $pos = 0; my $lastsign = 1;
  for my $k (0..$n-1) { my $piv = $A[$k][$k]; return (-1) if $piv->is_zero;
    my $sg = $piv->is_neg ? -1 : 1; $pos++ if $sg == $lastsign; $lastsign = $sg;      # Jacobi: a positive ratio of consecutive minors
    for my $i ($k+1..$n-1) { for my $j ($i..$n-1) { my $v = ($piv * $A[$i][$j] - $A[$i][$k] * $A[$k][$j]); my ($q, $r) = $v->copy->bdiv($prev); die "inexact Bareiss division" unless $r->is_zero; $A[$i][$j] = $q; } }
    for my $i ($k+1..$n-1) { for my $j ($k+1..$i-1) { $A[$i][$j] = $A[$j][$i] } }    # the symmetric half
    $prev = $piv }
  return $pos;
}
sub count_at { my ($a,$b) = @_; my $c = inertia_above($a,$b); my $nudge = 0; while ($c < 0) { $nudge++; $a = $a * 4 + 1; $b += 2; $c = inertia_above($a,$b); die "zero pivots persist" if $nudge > 8 } return ($c, $nudge) }
sub bracket {                                                                       # the largest c with count >= m and the least with count < m, to 2^-BITS
  my ($m) = @_; my $hi = Math::BigInt->new(int($rowsum->numify) + 1); my $b = 0; my ($chi) = count_at($hi, 0); die "the Perron bound fails" unless $chi < $m;
  my $lo = Math::BigInt->new(0); my ($clo) = count_at($lo, 0); die "count at 0 below $m" unless $clo >= $m;   # every sector eigenvalue is positive
  my $nudged = 0;
  for my $step (1..$BITS) { $lo *= 2; $hi *= 2; $b++; my $mid = ($lo + $hi) / 2; my ($c, $nu) = count_at($mid, $b); $nudged += $nu; if ($c >= $m) { $lo = $mid } else { $hi = $mid } }
  return (Math::BigRat->new($lo) / Math::BigRat->new(2)->bpow($b), Math::BigRat->new($hi) / Math::BigRat->new(2)->bpow($b), $nudged);
}
my $t0 = time;
my ($lo0, $hi0, $nz0) = bracket(1); my ($lo1, $hi1, $nz1) = bracket(2);
my $gl = log($lo0->numify / $hi1->numify); my $gh = log($hi0->numify / $lo1->numify);
printf "G6I table=%s L=%dx%d u=%s/%s n=%d kmax=%d bits=%d counts=%d nudges=%d seconds=%d\n", $tab =~ s{.*/}{}r, $L1, $L2, $P, $Q, $n, $kmax, $BITS, $counts, $nz0 + $nz1, time - $t0;
printf "G6I-LAM0 L=%dx%d u=%s/%s in (%s, %s) width=%.3e\n", $L1, $L2, $P, $Q, $lo0->numify, $hi0->numify, ($hi0 - $lo0)->numify;
printf "G6I-LAM1 L=%dx%d u=%s/%s in (%s, %s) width=%.3e\n", $L1, $L2, $P, $Q, $lo1->numify, $hi1->numify, ($hi1 - $lo1)->numify;
my $v = 'NOREF';
if (defined $r0 && defined $r1) { my ($R0, $R1) = (Math::BigRat->new($r0), Math::BigRat->new($r1));
  $v = ($R0 > $lo0 && $R0 < $hi0 && $R1 > $lo1 && $R1 < $hi1) ? 'CONTAINS' : 'OUTSIDE' }
printf "G6I-GAP L=%dx%d u=%s/%s gap in [%.15f, %.15f] width=%.3e dual-road-lambdas=%s\n", $L1, $L2, $P, $Q, $gl, $gh, $gh - $gl, $v;
