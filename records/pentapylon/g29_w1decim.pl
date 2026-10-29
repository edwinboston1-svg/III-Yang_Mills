#!/usr/bin/perl
# g29_w1decim.pl -- THE TRUE WASSERSTEIN COEFFICIENTS OF THE DECIMATED SPECIFICATION, SEARCHED FROM BELOW (ΠΕΝΤΑΠΥΛΟΝ G29, 2026-10-29 03:5x EDT,
# the desktop seat; iii-43's and the plan seat's falsifier for the Wasserstein form of Dobrushin on the perfect decimation, §75(f)).  A READING
# from below: every number is a lower bound (up to quadrature) on a coefficient the Wasserstein row sum must dominate; a searched coefficient
# above the certified one at the same beta refutes the certificate's accounting.
# THE OBJECT (g23's): a kept link y's conditional law f(y | rest) ∝ prod_{q=1..6} exp(phi(beta |y + w_q|)), phi(r) = log(I_1(r)/r), |w_q| <= 5; the
# neighbours enter through the six pinning vectors.  TYPE I (a kept link of y's plaquette p changes by g: A -> gA): w_p rotates on its sphere,
# |w_p - w'_p| = |1 - g| |w_p|, so the chordal change at y' is d = |w_p - w'_p|/|w_p|.  TYPE II (a kept link of one of a_p's other plaquettes
# changes, u -> u' in R_p): w'_p = w_p + (u' - u) rotated, d = |u - u'| = |w_p - w'_p|.  THE COEFFICIENT: C(y, y') = sup over configurations of
# W_1(f, f')/d, W_1 the Kantorovich distance for the chordal metric on S^3.  THE LOWER BOUND: W_1(f, f') >= |E_f h - E_f' h| for every 1-Lipschitz
# h; the family here is h_v(U) = <U, v> and h_P(U) = |U - P| for v, P over the 48-design and the directions of w_p, w'_p, w_p - w'_p (linear
# functionals and distances to points are 1-Lipschitz in the chordal metric); expectations by the quadrature on S^3 (theta midpoints with
# (2/pi) sin^2, the axis on a Fibonacci sphere).  THE SEARCH as g23's: random starts, coordinate refinement, the array assigned after the scalars
# and the fixed list's length asserted (the 03:3x trap).  KNOWN ANSWERS: at five w's = 0 and |w_p| -> 0 (TYPE I, antipodal) the bound tends to
# the linear-response value Var x beta m(beta) x |w_p - w'_p| (the pinning enters through phi, whose derivative is m, NOT through beta alone --
# the 03:5x correction of the first draft's known answer): at w_p = 0.01 e, w'_p = -0.01 e the family's best is within 5 % of 0.25 x 0.02 x beta x m(beta);
# and the bound is 0 for the identical configuration.
# usage: perl g29_w1decim.pl beta [NSTART=60] [NREF=60] [NTH=24] [NSPH=96] [SEED=1]     (G29_TYPES="I II" selects the kinds)
use strict; use warnings; use POSIX (); $| = 1;
my ($beta, $NSTART, $NREF, $NTH, $NSPH, $SEED) = @ARGV; die "usage: beta [NSTART] [NREF] [NTH] [NSPH] [SEED]" unless defined $beta;
$NSTART //= 60; $NREF //= 60; $NTH //= 24; $NSPH //= 96; $SEED //= 1; srand($SEED);
my $PI = 3.141592653589793;
sub phi { my $r = shift; return -log(2) if $r < 1e-12; my $z = $r * $r / 4; my ($s, $t) = (0, 1); for my $k (0 .. 40) { $s += $t; $t *= $z / (($k + 1) * ($k + 2)); last if $t < 1e-18 * $s } return log($s / 2) }
my @Q; { for my $it (0 .. $NTH - 1) { my $th = $PI * ($it + 0.5) / $NTH; my $wt = (2 / $PI) * sin($th) ** 2 * ($PI / $NTH) / $NSPH;
  for my $k (0 .. $NSPH - 1) { my $z = 1 - 2 * ($k + 0.5) / $NSPH; my $r = sqrt(1 - $z * $z); my $ph = $k * $PI * (3 - sqrt(5)); push @Q, [[cos($th), sin($th) * $r * cos($ph), sin($th) * $r * sin($ph), sin($th) * $z], $wt] } } }
my $NQ = scalar @Q;
my @DES; { my $h = 1 / sqrt(2);
  for my $i (0 .. 3) { for my $s (1, -1) { my @q = (0, 0, 0, 0); $q[$i] = $s; push @DES, [@q] } }
  for my $a (1, -1) { for my $b (1, -1) { for my $c (1, -1) { for my $d (1, -1) { push @DES, [$a / 2, $b / 2, $c / 2, $d / 2] } } } }
  for my $i (0 .. 3) { for my $j ($i + 1 .. 3) { for my $a (1, -1) { for my $b (1, -1) { my @q = (0, 0, 0, 0); $q[$i] = $a * $h; $q[$j] = $b * $h; push @DES, [@q] } } } } }
sub bessel { my ($n, $x) = @_; my $s = 0; my $t = ($x / 2) ** $n; my $f = 1; $f *= $_ for 1 .. $n; $t /= $f; for my $k (0 .. 60) { $s += $t; $t *= ($x / 2) ** 2 / (($k + 1) * ($k + 1 + $n)) } return $s }
sub nrm { my $v = shift; return sqrt($v->[0] ** 2 + $v->[1] ** 2 + $v->[2] ** 2 + $v->[3] ** 2) }
sub randunit { my @v = map { my $u1 = rand() || 1e-12; my $u2 = rand(); sqrt(-2 * log($u1)) * cos(2 * $PI * $u2) } 1 .. 4; my $n = nrm(\@v); return [ map { $_ / $n } @v ] }
sub scale { my ($v, $s) = @_; return [ map { $_ * $s } @$v ] }
sub add { my ($a, $b) = @_; return [ map { $a->[$_] + $b->[$_] } 0 .. 3 ] }
sub logpart { my $W = shift; my @L = (0) x $NQ; for my $i (0 .. $NQ - 1) { my $y = $Q[$i][0]; for my $w (@$W) { my @u = map { $y->[$_] + $w->[$_] } 0 .. 3; $L[$i] += phi($beta * sqrt($u[0] ** 2 + $u[1] ** 2 + $u[2] ** 2 + $u[3] ** 2)) } } return \@L }
sub density { my $L = shift; my $m = -1e300; for (0 .. $NQ - 1) { $m = $L->[$_] if $L->[$_] > $m } my @e = map { exp($L->[$_] - $m) * $Q[$_][1] } 0 .. $NQ - 1; my $z = 0; $z += $_ for @e; $_ /= $z for @e; return \@e }
# the test functions' values on the grid, for the fixed design directions (built once) and for the three configuration directions (per call)
my @HV; my @HP; for my $v (@DES) { push @HV, [ map { my $y = $Q[$_][0]; $y->[0] * $v->[0] + $y->[1] * $v->[1] + $y->[2] * $v->[2] + $y->[3] * $v->[3] } 0 .. $NQ - 1 ];
  push @HP, [ map { my $y = $Q[$_][0]; sqrt(($y->[0] - $v->[0]) ** 2 + ($y->[1] - $v->[1]) ** 2 + ($y->[2] - $v->[2]) ** 2 + ($y->[3] - $v->[3]) ** 2) } 0 .. $NQ - 1 ] }
sub w1lower { my ($Lfix, $wp, $wq) = @_; my $A = logpart([$wp]); my $B = logpart([$wq]);
  my $p1 = density([ map { $Lfix->[$_] + $A->[$_] } 0 .. $NQ - 1 ]); my $p2 = density([ map { $Lfix->[$_] + $B->[$_] } 0 .. $NQ - 1 ]); my @dd = map { $p1->[$_] - $p2->[$_] } 0 .. $NQ - 1;
  my $best = 0; for my $h (@HV, @HP) { my $s = 0; $s += $dd[$_] * $h->[$_] for 0 .. $NQ - 1; $s = -$s if $s < 0; $best = $s if $s > $best }
  for my $dir ($wp, $wq, add($wp, scale($wq, -1))) { my $n = nrm($dir); next if $n < 1e-9; my $v = scale($dir, 1 / $n);
    my $s = 0; for (0 .. $NQ - 1) { my $y = $Q[$_][0]; $s += $dd[$_] * ($y->[0] * $v->[0] + $y->[1] * $v->[1] + $y->[2] * $v->[2] + $y->[3] * $v->[3]) } $s = -$s if $s < 0; $best = $s if $s > $best;
    $s = 0; for (0 .. $NQ - 1) { my $y = $Q[$_][0]; $s += $dd[$_] * sqrt(($y->[0] - $v->[0]) ** 2 + ($y->[1] - $v->[1]) ** 2 + ($y->[2] - $v->[2]) ** 2 + ($y->[3] - $v->[3]) ** 2) } $s = -$s if $s < 0; $best = $s if $s > $best }
  return $best }
sub coef { my ($type, $Lfix, $wp, $wq) = @_; my $dist = nrm(add($wp, scale($wq, -1))); return 0 if $dist < 1e-9; my $d = ($type eq 'I') ? $dist / (nrm($wp) || 1e-9) : $dist; return w1lower($Lfix, $wp, $wq) / $d }
sub mk_I { my ($r, $d1, $d2) = @_; return (scale($d1, $r), scale($d2, $r)) }
sub mk_II { my ($r, $d1, $u, $up) = @_; my $wp = scale($d1, $r); my $base = add($wp, scale($u, -1)); return undef if nrm($base) > 4 + 1e-9; return ($wp, add($base, $up)) }
my @TYPES = split / /, ($ENV{G29_TYPES} // "I II"); my $t0 = time;
printf "G29 beta=%g the decimated specification's W_1 coefficients searched from below: quadrature %d points, %d starts x %d refinements per type, test family %d functions + 6 per configuration (seed %d)\n", $beta, $NQ, $NSTART, $NREF, 2 * scalar(@DES), $SEED;
{ my $W0 = [ map { [0, 0, 0, 0] } 1 .. 5 ]; my $Lf = logpart($W0); my $w = [3, 0, 0, 0]; printf "G29-KAT identical configurations: bound = %.2e (must be 0)\n", w1lower($Lf, $w, $w);
  my $mb = bessel(2, $beta) / bessel(1, $beta); my $lr = 0.25 * 0.02 * $beta * $mb; my $b = w1lower($Lf, [0.01, 0, 0, 0], [-0.01, 0, 0, 0]);
  printf "G29-KAT the tilt-free TYPE I at |w_p| = 0.01, antipodal: W_1 lower bound %.4e against the linear response Var x d/dw of beta phi(|y + w|) = 0.25 x 0.02 x beta x m(beta) = %.4e (ratio %.3f) [%s]\n", $b, $lr, $b / $lr, abs($b / $lr - 1) < 0.05 ? 'WITHIN-5%' : 'OFF' }
my %best = (I => [0, ''], II => [0, '']);
for my $type (@TYPES) {
  for my $s (1 .. $NSTART) {
    my $mode = ($s % 3); my @W; my $nd = randunit(); for (1 .. 5) { my $r = 5 * rand() ** 0.5; push @W, ($mode == 0) ? scale($nd, 5) : ($mode == 1 ? scale(randunit(), $r) : scale($nd, $r)) }
    my $Lf = logpart(\@W); my ($wp, $wq);
    if ($type eq 'I') { my $r = 0.05 + 4.95 * rand() ** 0.3; ($wp, $wq) = mk_I($r, randunit(), randunit()) }
    else { my $tries = 0; while (1) { my $r = 5 * rand() ** 0.3; my @o = mk_II($r, randunit(), randunit(), randunit()); if (defined $o[0]) { ($wp, $wq) = @o; last } last if ++$tries > 50 } next unless defined $wp }
    my $t = coef($type, $Lf, $wp, $wq);
    for my $k (1 .. $NREF) { my $eps = 0.5 * (1 - $k / ($NREF + 1)) + 0.02; my ($wp2, $wq2);
      my @W2 = map { my $v = add($_, scale(randunit(), $eps * rand())); my $n = nrm($v); $n > 5 ? scale($v, 5 / $n) : $v } @W;
      if ($type eq 'I') { my $r = nrm($wp) + $eps * (rand() - 0.5); $r = 5 if $r > 5; $r = 0.05 if $r < 0.05; my $d1 = add(scale($wp, 1 / (nrm($wp) || 1)), scale(randunit(), $eps * rand())); my $d2 = add(scale($wq, 1 / (nrm($wq) || 1)), scale(randunit(), $eps * rand()));
        ($wp2, $wq2) = mk_I($r, scale($d1, 1 / nrm($d1)), scale($d2, 1 / nrm($d2))) }
      else { my $r = nrm($wp) + $eps * (rand() - 0.5); $r = 5 if $r > 5; $r = 0.01 if $r < 0.01; my $d1 = add(scale($wp, 1 / (nrm($wp) || 1)), scale(randunit(), $eps * rand())); $d1 = scale($d1, 1 / nrm($d1));
        my @o = mk_II($r, $d1, randunit(), randunit()); next unless defined $o[0]; ($wp2, $wq2) = @o }
      my $Lf2 = logpart(\@W2); my $t2 = coef($type, $Lf2, $wp2, $wq2); if ($t2 > $t) { ($t, $wp, $wq, $Lf) = ($t2, $wp2, $wq2, $Lf2); @W = @W2 } }
    die "the fixed w-list has " . scalar(@W) . " entries, not 5" unless @W == 5;
    if ($t > $best{$type}[0]) { $best{$type} = [$t, sprintf("|w_p|=%.3f |w'_p|=%.3f |w_p-w'_p|=%.3f the five |w|: %s", nrm($wp), nrm($wq), nrm(add($wp, scale($wq, -1))), join(' ', map { sprintf('%.2f', nrm($_)) } @W))] }
    printf "G29-START beta=%g type=%s start=%d coef=%.6f best=%.6f (%d s)\n", $beta, $type, $s, $t, $best{$type}[0], time - $t0 if $s % 10 == 0 }
  printf "G29-SUP beta=%g type=%s searched sup of the W_1 coefficient C^W_%s >= %.6f at %s\n", $beta, $type, $type, $best{$type}[0], $best{$type}[1] }
if (@TYPES == 2) { my $row = 12 * $best{I}[0] + 90 * $best{II}[0]; printf "G29-ROW beta=%g the Wasserstein row's searched value 12 C_I + 90 C_II >= %.6f (12 x %.6f + 90 x %.6f) -- a LOWER estimate under independent w's  [%s]  (%d s)\n", $beta, $row, $best{I}[0], $best{II}[0], $row < 1 ? 'BELOW-1' : 'AT-OR-ABOVE-1', time - $t0 }
POSIX::_exit(0);
