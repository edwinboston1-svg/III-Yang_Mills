#!/usr/bin/perl
# g23_decim.pl -- THE CEILING OF THE PERFECT DECIMATION: the true Dobrushin coefficients of the decimated specification, searched
# (ΠΕΝΤΑΠΥΛΟΝ G23, 2026-10-29 03:1x EDT, the desktop seat; the plan seat's §73).  A READING, not a certificate: it searches a sup from
# below, so it bounds the decimation route's best possible constant from below and checks any certified bound from below (law 4).
# THE OBJECT.  Integrate an independent link set S meeting every plaquette exactly once (one link per site in 4D).  A kept link y lies in six
# plaquettes p, each holding one integrated link a_p (distinct, since two links share at most one plaquette); a_p's Boltzmann factor integrated
# is Z_1(|eta|) ∝ I_1(|eta|)/|eta|, eta = beta (staple of a_p in p + R_p), R_p the sum of a_p's other five staples.  The staple through y is
# A y B for unit quaternions A, B (the plaquette's other two kept links), and left/right multiplication is an isometry, so
#     f(y | rest) ∝ prod_{q=1..6} exp(phi(beta |y + w_q|)),   phi(r) = log(I_1(r)/r),   w_q = A^-1 R_q B^-1,  |w_q| <= 5,
# and the neighbours enter ONLY through the six vectors w_q.  TYPE I (12 kept links per y: the two other kept links of each plaquette): a change
# rotates one w_p on its sphere (|w'_p| = |w_p|, any direction, by left multiplication).  TYPE II (90 per y: the three kept links of each of
# a_p's five other plaquettes): a change replaces one summand u of R_p by u', so w'_p = w_p + (u' - u) rotated, |w_p - u| <= 4.  Dobrushin's
# coefficient C(y, y') is the sup over all such configurations of TV(f, f'); the row sum is at most 12 C_I + 90 C_II (a link in two roles
# carries at most the sum).  The six w_q are treated as INDEPENDENT (two integrated neighbours may share kept links), so the sup searched here is
# over a superset of the realisable configurations: it is the constant the plan seat's form of argument would need, not the specification's own.
# THE SEARCH.  TV by quadrature on S^3 (theta midpoints, weight (2/pi) sin^2, the axis on a Fibonacci sphere; NTH x NSPH points); phi by its
# series (r <= 8 here); the sup by random starts (the five other w's aligned or random, |w| in [0, 5]) and coordinate refinement.  KNOWN ANSWERS:
# at five w's = 0 and |w_p| -> 0 the TYPE I coefficient tends to the bare one-link law (the tilt-free vMF at kappa = beta|w_p| rotated: TV ->
# 0); the TYPE I sup with the other five w's = 0 must not exceed the sharp one-link bound (2 beta/(3 pi)) x |w_p - w'_p| <= (2 beta/3pi) x 2|w_p|
# (it is a vMF in y with kappa = beta|w_p| to first order) -- printed as a check, and TV(f, f) = 0.
# usage: perl g23_decim.pl beta [NSTART=300] [NREF=200] [NTH=24] [NSPH=96] [SEED=1]
use strict; use warnings; use POSIX (); $| = 1;                                          # autoflush: the run ends in POSIX::_exit, which skips the buffer
my ($beta, $NSTART, $NREF, $NTH, $NSPH, $SEED) = @ARGV; die "usage: beta [NSTART] [NREF] [NTH] [NSPH] [SEED]" unless defined $beta;
$NSTART //= 300; $NREF //= 200; $NTH //= 24; $NSPH //= 96; $SEED //= 1; srand($SEED);
my $PI = 3.141592653589793;
sub phi { my $r = shift; return -log(2) if $r < 1e-12; my $z = $r * $r / 4; my ($s, $t) = (0, 1); for my $k (0 .. 40) { $s += $t; $t *= $z / (($k + 1) * ($k + 2)); last if $t < 1e-18 * $s } return log($s / 2) }   # I_1(r)/r = (1/2) sum z^k/(k!(k+1)!)
my @Q; { for my $it (0 .. $NTH - 1) { my $th = $PI * ($it + 0.5) / $NTH; my $wt = (2 / $PI) * sin($th) ** 2 * ($PI / $NTH) / $NSPH;
  for my $k (0 .. $NSPH - 1) { my $z = 1 - 2 * ($k + 0.5) / $NSPH; my $r = sqrt(1 - $z * $z); my $ph = $k * $PI * (3 - sqrt(5)); push @Q, [[cos($th), sin($th) * $r * cos($ph), sin($th) * $r * sin($ph), sin($th) * $z], $wt] } } }
my $NQ = scalar @Q;
sub nrm { my $v = shift; return sqrt($v->[0] ** 2 + $v->[1] ** 2 + $v->[2] ** 2 + $v->[3] ** 2) }
sub randunit { my @v = map { my $u1 = rand() || 1e-12; my $u2 = rand(); sqrt(-2 * log($u1)) * cos(2 * $PI * $u2) } 1 .. 4; my $n = nrm(\@v); return [ map { $_ / $n } @v ] }
sub scale { my ($v, $s) = @_; return [ map { $_ * $s } @$v ] }
sub add { my ($a, $b) = @_; return [ map { $a->[$_] + $b->[$_] } 0 .. 3 ] }
# log-density at each quadrature point for the six w's; the TV between two w-sets differing in w_p only
sub logf { my $W = shift; my @L; for my $q (@Q) { my $y = $q->[0]; my $s = 0; for my $w (@$W) { my @u = map { $y->[$_] + $w->[$_] } 0 .. 3; $s += phi($beta * sqrt($u[0] ** 2 + $u[1] ** 2 + $u[2] ** 2 + $u[3] ** 2)) } push @L, $s } return \@L }
sub tv { my ($L1, $L2) = @_; my ($m1, $m2) = (-1e300, -1e300); for (0 .. $NQ - 1) { $m1 = $L1->[$_] if $L1->[$_] > $m1; $m2 = $L2->[$_] if $L2->[$_] > $m2 }
  my ($z1, $z2) = (0, 0); my (@e1, @e2); for (0 .. $NQ - 1) { $e1[$_] = exp($L1->[$_] - $m1); $e2[$_] = exp($L2->[$_] - $m2); $z1 += $Q[$_][1] * $e1[$_]; $z2 += $Q[$_][1] * $e2[$_] }
  my $s = 0; for (0 .. $NQ - 1) { $s += $Q[$_][1] * abs($e1[$_] / $z1 - $e2[$_] / $z2) } return $s / 2 }
# the reduced logf: the five fixed factors once, plus the varying factor
sub logpart { my $W = shift; my @L = (0) x $NQ; for my $i (0 .. $NQ - 1) { my $y = $Q[$i][0]; for my $w (@$W) { my @u = map { $y->[$_] + $w->[$_] } 0 .. 3; $L[$i] += phi($beta * sqrt($u[0] ** 2 + $u[1] ** 2 + $u[2] ** 2 + $u[3] ** 2)) } } return \@L }
sub tv_pair { my ($Lfix, $wp, $wq) = @_; my $A = logpart([$wp]); my $B = logpart([$wq]); my @L1 = map { $Lfix->[$_] + $A->[$_] } 0 .. $NQ - 1; my @L2 = map { $Lfix->[$_] + $B->[$_] } 0 .. $NQ - 1; return tv(\@L1, \@L2) }
# a configuration: five fixed w's (as a list) and the pair (w_p, w'_p) by type
sub legal_I { my ($wp, $wq) = @_; return nrm($wp) <= 5 + 1e-9 && abs(nrm($wq) - nrm($wp)) < 1e-9 }
sub mk_I { my ($r, $d1, $d2) = @_; return (scale($d1, $r), scale($d2, $r)) }                       # w_p = r d1, w'_p = r d2
sub mk_II { my ($r, $d1, $u, $up) = @_; my $wp = scale($d1, $r); my $base = add($wp, scale($u, -1)); return undef if nrm($base) > 4 + 1e-9; return ($wp, add($base, $up)) }   # w_p = r d1, u a summand with |w_p - u| <= 4, w'_p = w_p - u + u'
my $TYPES = $ENV{G23_TYPES} // "I II"; my @TYPES = split / /, $TYPES;
my $t0 = time;
printf "G23 beta=%g the decimated specification's coefficients searched: quadrature %d points, %d starts x %d refinements per type (seed %d)\n", $beta, $NQ, $NSTART, $NREF, $SEED;
# known answers
{ my $W0 = [ map { [0, 0, 0, 0] } 1 .. 5 ]; my $Lf = logpart($W0); my $w = [3, 0, 0, 0]; printf "G23-KAT tv(f, f) = %.2e (must be 0)\n", tv_pair($Lf, $w, $w);
  my $t = tv_pair($Lf, [0.01, 0, 0, 0], [-0.01, 0, 0, 0]); printf "G23-KAT the tilt-free TYPE I at |w_p| = 0.01, antipodal: tv = %.3e against the sharp one-link bound (2 beta/3pi) x 0.02 = %.3e  [%s]\n", $t, 2 * $beta / (3 * $PI) * 0.02, $t <= 2 * $beta / (3 * $PI) * 0.02 * 1.01 ? 'WITHIN' : 'EXCEEDS';
  my $t5 = tv_pair($Lf, [5, 0, 0, 0], [-5, 0, 0, 0]); printf "G23-KAT the tilt-free TYPE I at |w_p| = 5, antipodal: tv = %.6f\n", $t5 }
# the search
my %best = (I => [0, ''], II => [0, '']);
for my $type (@TYPES) {
  for my $s (1 .. $NSTART) {
    my $mode = ($s % 3); my @W; my $nd = randunit(); for (1 .. 5) { my $r = 5 * rand() ** 0.5; push @W, ($mode == 0) ? scale($nd, 5) : ($mode == 1 ? scale(randunit(), $r) : scale($nd, $r)) }
    my $Lf = logpart(\@W); my ($wp, $wq);
    if ($type eq 'I') { my $r = 5 * rand() ** 0.3; ($wp, $wq) = mk_I($r, randunit(), randunit()) }
    else { my ($tries) = (0); while (1) { my $r = 5 * rand() ** 0.3; my $d1 = randunit(); my $u = randunit(); my $up = randunit(); my @o = mk_II($r, $d1, $u, $up); if (defined $o[0]) { ($wp, $wq) = @o; last } last if ++$tries > 50 } next unless defined $wp }
    my $t = tv_pair($Lf, $wp, $wq);
    # refinement: perturb (w_p, w'_p) and the common direction of the fixed five, keep improvements
    for my $k (1 .. $NREF) { my $eps = 0.5 * (1 - $k / ($NREF + 1)) + 0.02; my ($wp2, $wq2, @W2);
      @W2 = map { my $v = add($_, scale(randunit(), $eps * rand())); my $n = nrm($v); $n > 5 ? scale($v, 5 / $n) : $v } @W;
      if ($type eq 'I') { my $r = nrm($wp) + $eps * (rand() - 0.5); $r = 5 if $r > 5; $r = 0 if $r < 0; my $d1 = add(scale($wp, 1 / (nrm($wp) || 1)), scale(randunit(), $eps * rand())); my $d2 = add(scale($wq, 1 / (nrm($wq) || 1)), scale(randunit(), $eps * rand()));
        ($wp2, $wq2) = mk_I($r, scale($d1, 1 / nrm($d1)), scale($d2, 1 / nrm($d2))) }
      else { my $u = add($wp, scale($wp, 0)); my $base = add($wq, scale($wp, -1));                       # keep the structure: perturb w_p and the summand pair
        my $r = nrm($wp) + $eps * (rand() - 0.5); $r = 5 if $r > 5; $r = 0.01 if $r < 0.01; my $d1 = add(scale($wp, 1 / (nrm($wp) || 1)), scale(randunit(), $eps * rand())); $d1 = scale($d1, 1 / nrm($d1));
        my $uu = randunit(); my $upp = randunit(); my @o = mk_II($r, $d1, $uu, $upp); next unless defined $o[0]; ($wp2, $wq2) = @o; my $Lf2 = logpart(\@W2); my $t2 = tv_pair($Lf2, $wp2, $wq2); if ($t2 > $t) { ($t, $wp, $wq, $Lf) = ($t2, $wp2, $wq2, $Lf2); @W = @W2 } next }
      my $Lf2 = logpart(\@W2); my $t2 = tv_pair($Lf2, $wp2, $wq2); if ($t2 > $t) { ($t, $wp, $wq, $Lf) = ($t2, $wp2, $wq2, $Lf2); @W = @W2 } }
    die "the fixed w-list has " . scalar(@W) . " entries, not 5" unless @W == 5;
    if ($t > $best{$type}[0]) { $best{$type} = [$t, sprintf("|w_p|=%.3f |w'_p|=%.3f |w_p-w'_p|=%.3f the five |w|: %s", nrm($wp), nrm($wq), nrm(add($wp, scale($wq, -1))), join(' ', map { sprintf('%.2f', nrm($_)) } @W))] }
    printf "G23-START beta=%g type=%s start=%d tv=%.6f best=%.6f (%d s)\n", $beta, $type, $s, $t, $best{$type}[0], time - $t0 if $s % 25 == 0 }
  printf "G23-SUP beta=%g type=%s searched sup C_%s >= %.6f at %s\n", $beta, $type, $type, $best{$type}[0], $best{$type}[1] }
my $row = 12 * $best{I}[0] + 90 * $best{II}[0];
printf "G23-ROW beta=%g the row sum's searched value 12 C_I + 90 C_II >= %.6f (12 x %.6f + 90 x %.6f) -- a LOWER estimate of the decimation's best constant under independent w's  [%s]  (%d s)\n", $beta, $row, $best{I}[0], $best{II}[0], $row < 1 ? 'BELOW-1' : 'AT-OR-ABOVE-1', time - $t0;
POSIX::_exit(0);
