#!/usr/bin/perl
# g35_u1_square.pl -- THE U(1) 2x2 SQUARE: THE BLOCKED PLAQUETTE, THE CREUTZ RATIO AND THE ONE-STEP BLOCKED COUPLING, EXACT, WITH THEIR QUOTIENT
# INFLUENCES (ΠΕΝΤΑΠΥΛΟΝ G35, 2026-10-29 05:5x EDT, the desktop seat; RESULTS 16.24: the theorem must live on a COARSE variable after blocking,
# where SU(2)'s coupling runs and U(1)'s does not -- this is the abelian half of that reading on a four-dimensional object).
# THE OBJECT: the 2x2 planar square in the xy-plane of Z^4 -- nine vertices, twelve links (six in x, six in y), four faces f(x,y) in a RING around
# the centre vertex (1,1) -- every link with its outside plaquettes (four in the z and t directions; one more in the plane for the eight outer
# links) on outside links that are the DATA.  THE EXACTNESS is g33's: face modes n_i with weights I_{n_i}(beta), a link's net flux k_e, its outside
# staples summing as a complex number S_e, the link integral I_k(beta|S_e|) e^{-i k arg S_e} =: L_e(k).  A LOOP OBSERVABLE e^{i m Phi_W} (W any of
# the plaquette W(1,1), the rectangles W(1,2), W(2,1), the big loop W(2,2), each a list of (edge, sign)) adds m sigma_W(e) to the flux of its edges
# and costs nothing: R_W(m) = sum over the four face modes of prod_i I_{n_i} prod_e L_e(k_e), a trace of four (2N+1) x (2N+1) matrices (column i =
# face i's two outer edges and the spoke it shares with face i+1), and E[e^{i m Phi_W}] = R_W(m)/R(0).  The whole class law of every loop follows.
# READINGS: W(1,1), W(1,2), W(2,1), W(2,2) = E[cos Phi]; THE CREUTZ RATIO chi(2,2) = -log(W(2,2) W(1,1) / (W(2,1) W(1,2))); THE ONE-STEP BLOCKED
# COUPLING beta_eff(2a) = the coupling at which the one-plaquette law I_1/I_0 equals W(2,2) (the blocked plaquette read as a plaquette); and under
# single-link changes of the data the responses of W(2,2) and the TV of the big loop's class law (the BLOCKED quotient influence) beside the
# plaquette's.  KNOWN ANSWERS: the free square (no staples): the four plaquettes independent, W(1,1) = I_1/I_0, W(1,2) = W(2,1) = (I_1/I_0)^2,
# W(2,2) = (I_1/I_0)^4, chi(2,2) = -log(I_1/I_0); the symmetric datum's Z equal at N and N + 2; every class law of mass one and nonnegative.
# usage: perl g35_u1_square.pl beta [MODE=base|faceresp|kat] [N=10]    env G35_ANGLES
use strict; use warnings; use POSIX (); $| = 1;
my ($beta, $MODE, $N) = @ARGV; die "usage: beta [base|faceresp|kat] [N]" unless defined $beta; $MODE //= 'base'; $N //= 10;
my $PI = 3.141592653589793; my $t0 = time; my @ANG = split / /, ($ENV{G35_ANGLES} // '30 60 90 120 150 180');
sub bessel { my ($n, $x) = @_; $n = -$n if $n < 0; return ($n == 0 ? 1 : 0) if $x == 0; my $s = 0; my $t = ($x / 2) ** $n; my $f = 1; $f *= $_ for 1 .. $n; $t /= $f; for my $k (0 .. 300) { $s += $t; $t *= ($x / 2) ** 2 / (($k + 1) * ($k + 1 + $n)); last if $t < 1e-18 * $s } return $s }
my @IB; sub ib { my $n = shift; $n = -$n if $n < 0; return $IB[$n] //= bessel($n, $beta) }
# ---- the square: links X(x,y): (x,y)->(x+1,y), x in 0..1, y in 0..2; Y(x,y): (x,y)->(x,y+1), x in 0..2, y in 0..1; the plane z = t = 0
my %EDGE; for my $x (0, 1) { for my $y (0 .. 2) { $EDGE{"X$x$y"} = { base => [$x, $y, 0, 0], dir => 1 } } } for my $x (0 .. 2) { for my $y (0, 1) { $EDGE{"Y$x$y"} = { base => [$x, $y, 0, 0], dir => 2 } } }
sub face { my ($x, $y) = @_; return [ ["X$x$y", 1], ["Y" . ($x + 1) . "$y", 1], ["X$x" . ($y + 1), -1], ["Y$x$y", -1] ] }
my @FACES = (face(0, 0), face(1, 0), face(1, 1), face(0, 1));                                             # the ring around (1,1): counterclockwise
my @SPOKE = ('Y10', 'X11', 'Y11', 'X01');                                                                  # SPOKE[i] is shared by face i and face i+1
my %LOOP = ( 'W11' => face(0, 0),
             'W12' => [ ['X00', 1], ['X10', 1], ['Y20', 1], ['X11', -1], ['X01', -1], ['Y00', -1] ],           # f(0,0) u f(1,0): two wide in x
             'W21' => [ ['X00', 1], ['Y10', 1], ['Y11', 1], ['X02', -1], ['Y01', -1], ['Y00', -1] ],           # f(0,0) u f(0,1): two high in y
             'W22' => [ ['X00', 1], ['X10', 1], ['Y20', 1], ['Y21', 1], ['X12', -1], ['X02', -1], ['Y01', -1], ['Y00', -1] ] );
my %SIG; for my $i (0 .. 3) { for my $es (@{$FACES[$i]}) { $SIG{$i}{$es->[0]} = $es->[1] } }                 # the sign of edge e in face i
# ---- the outside plaquettes (staples) of every link: the two perpendicular directions z, t both sides; the in-plane perpendicular on the outer side
my %OUT; my @OUTKEYS; sub okey { my ($b, $d) = @_; my $k = join(',', @$b) . ":$d"; unless (exists $OUT{$k}) { $OUT{$k} = scalar @OUTKEYS; push @OUTKEYS, $k } return $OUT{$k} }
sub vadd { my ($p, $d, $s) = @_; my @q = @$p; $q[$d - 1] += $s; return \@q }
my %DANG;
for my $e (sort keys %EDGE) { my ($p, $d) = ($EDGE{$e}{base}, $EDGE{$e}{dir}); my $pd = vadd($p, $d, 1);
  for my $k (1 .. 4) { next if $k == $d; my @sides;
    if ($k >= 3) { @sides = (1, -1) } else { my $c = $p->[$k - 1]; @sides = ($c == 0) ? (-1) : ($c == 2) ? (1) : () }                 # in-plane: only the outer side; a spoke has none
    for my $s (@sides) { my ($l1, $l2, $l3);
      $l1 = ($s > 0) ? [okey($pd, $k), 1] : [okey(vadd($pd, $k, -1), $k), -1];
      $l2 = [okey(vadd($p, $k, $s), $d), -1];
      $l3 = ($s > 0) ? [okey($p, $k), -1] : [okey(vadd($p, $k, -1), $k), 1];
      push @{$DANG{$e}}, [$l1, $l2, $l3] } } }
my $NOUT = scalar @OUTKEYS; my $nst = 0; $nst += scalar @{$DANG{$_}} for keys %EDGE;
sub stapleang { my ($pl, $dat) = @_; my $a = 0; $a += $_->[1] * $dat->[$_->[0]] for @$pl; return $a }
my $FREE = 0; my $K;
sub linkfactors { my ($e, $dat) = @_; my ($sr, $si) = (0, 0); unless ($FREE) { for my $pl (@{$DANG{$e}}) { my $a = stapleang($pl, $dat); $sr += cos($a); $si += sin($a) } }
  my $mod = sqrt($sr * $sr + $si * $si); my $alpha = ($mod > 0) ? atan2($si, $sr) : 0; my @L; for my $k (-$K .. $K) { my $v = bessel($k, $beta * $mod); $L[$k + $K] = [$v * cos($k * $alpha), -$v * sin($k * $alpha)] } return \@L }
# the ring trace for a loop W at mode m: R_W(m)
sub ring { my ($loop, $m, $dat, $LF) = @_; my %ls; if ($loop) { $ls{$_->[0]} = $_->[1] for @$loop } my $W = 2 * $N + 1; my $P;
  for my $i (0 .. 3) { my $n = ($i + 1) % 4; my $sp = $SPOKE[$i]; my @outer = grep { $_ ne $SPOKE[$i] && $_ ne $SPOKE[($i + 3) % 4] } map { $_->[0] } @{$FACES[$i]}; die "face $i has " . scalar(@outer) . " outer edges" unless @outer == 2;
    my @M; for my $a (0 .. $W - 1) { my $ni = $a - $N; my ($dr, $di) = (ib($ni), 0);
      for my $e (@outer) { my $l = $LF->{$e}[$SIG{$i}{$e} * $ni + $m * ($ls{$e} // 0) + $K]; ($dr, $di) = ($dr * $l->[0] - $di * $l->[1], $dr * $l->[1] + $di * $l->[0]) }
      for my $b (0 .. $W - 1) { my $nn = $b - $N; my $l = $LF->{$sp}[$SIG{$i}{$sp} * $ni + $SIG{$n}{$sp} * $nn + $m * ($ls{$sp} // 0) + $K]; $M[$a][$b] = [$dr * $l->[0] - $di * $l->[1], $dr * $l->[1] + $di * $l->[0]] } }
    if (!defined $P) { $P = \@M } else { my @Q; for my $a (0 .. $W - 1) { my $Pa = $P->[$a]; for my $b (0 .. $W - 1) { my ($r, $im) = (0, 0); for my $c (0 .. $W - 1) { my ($p, $q) = ($Pa->[$c], $M[$c][$b]); $r += $p->[0] * $q->[0] - $p->[1] * $q->[1]; $im += $p->[0] * $q->[1] + $p->[1] * $q->[0] } $Q[$a][$b] = [$r, $im] } } $P = \@Q } }
  my ($tr, $ti) = (0, 0); for my $a (0 .. $W - 1) { $tr += $P->[$a][$a][0]; $ti += $P->[$a][$a][1] } return [$tr, $ti] }
# all readings at a datum: Z, the four loops' modes c_m for |m| <= N, their class laws
my $NQ = 1440;
sub readings { my $dat = shift; $K = 3 * $N + 2; my %LF; $LF{$_} = linkfactors($_, $dat) for keys %EDGE; my $Z = ring(undef, 0, $dat, \%LF); die sprintf("Z not real positive: %.3e + %.3e i", @$Z) unless $Z->[0] > 0 && abs($Z->[1]) < 1e-9 * $Z->[0];
  my %R; for my $w (sort keys %LOOP) { for my $m (-$N .. $N) { my $r = ring($LOOP{$w}, $m, $dat, \%LF); $R{$w}{$m} = [$r->[0] / $Z->[0], $r->[1] / $Z->[0]] } } return ($Z->[0], \%R) }
sub density { my $c = shift; my @p; for my $q (0 .. $NQ - 1) { my $ph = 2 * $PI * $q / $NQ; my $s = $c->{0}[0]; for my $m (1 .. $N) { $s += 2 * ($c->{$m}[0] * cos($m * $ph) + $c->{$m}[1] * sin($m * $ph)) } push @p, $s / (2 * $PI) } return \@p }
sub tv { my ($p, $q) = @_; my $s = 0; $s += abs($p->[$_] - $q->[$_]) for 0 .. $NQ - 1; return 0.5 * $s * 2 * $PI / $NQ }
sub massmin { my $p = shift; my ($s, $mn) = (0, 1e9); for (@$p) { $s += $_; $mn = $_ if $_ < $mn } return ($s * 2 * $PI / $NQ, $mn) }
sub beff { my $w = shift; return 0 if $w <= 0; my ($lo, $hi) = (0, 50); for (1 .. 200) { my $mid = ($lo + $hi) / 2; if (bessel(1, $mid) / bessel(0, $mid) < $w) { $lo = $mid } else { $hi = $mid } } return ($lo + $hi) / 2 }
sub creutz { my $R = shift; my ($w11, $w12, $w21, $w22) = map { $R->{$_}{1}[0] } ('W11', 'W12', 'W21', 'W22'); return ($w11, $w12, $w21, $w22, -log($w22 * $w11 / ($w21 * $w12)), beff($w22)) }
printf "G35 beta=%g MODE=%s N=%d: %d outside links, %d staples (the eight outer links five each, the four spokes four); I_1/I_0 = %.6f, I_{%d}/I_0 = %.2e\n", $beta, $MODE, $N, $NOUT, $nst, ib(1) / ib(0), $N + 1, ib($N + 1) / ib(0);
my @d0 = (0) x $NOUT; my $DATUM = $ENV{G35_DATUM} // 'ordered'; if ($DATUM =~ /^random:(d+)$/) { srand($1); @d0 = map { 2 * $PI * rand() } 1 .. $NOUT }      # random:SEED = every outside angle uniform (06:0x EDT)
if ($MODE eq 'kat') { $FREE = 1; my ($Z, $R) = readings(\@d0); my ($w11, $w12, $w21, $w22, $chi, $be) = creutz($R); my $m1 = ib(1) / ib(0); $FREE = 0;
  my $bad = (abs($Z - ib(0) ** 4) > 1e-12 * ib(0) ** 4 || abs($w11 - $m1) > 1e-12 || abs($w12 - $m1 ** 2) > 1e-12 || abs($w21 - $m1 ** 2) > 1e-12 || abs($w22 - $m1 ** 4) > 1e-12 || abs($chi + log($m1)) > 1e-10 || abs($be - beff($m1 ** 4)) > 1e-8) ? 1 : 0;
  printf "G35-KAT the free square: Z = %.12f (I_0^4 = %.12f), W(1,1) = %.12f (%.12f), W(1,2) = %.12f, W(2,1) = %.12f ((I_1/I_0)^2 = %.12f), W(2,2) = %.12f ((I_1/I_0)^4 = %.12f), chi(2,2) = %.12f (-log(I_1/I_0) = %.12f), beta_eff(2a) = %.9f (beta) [%s] (%d s)\n", $Z, $w11, $m1, $w12, $w21, $m1 ** 2, $w22, $m1 ** 4, $chi, -log($m1), $be, beff($m1 ** 4), $bad ? 'FAILED' : 'MET', time - $t0; exit 1 if $bad;
  my ($Z0, $R0) = readings(\@d0); my @c0 = creutz($R0); my ($mass, $mn) = massmin(density($R0->{W22})); $N += 2; @IB = (); my ($Z2, $R2) = readings(\@d0); my @c2 = creutz($R2); $N -= 2; @IB = ();
  printf "G35-KAT the symmetric datum: Z = %.12e, W(2,2) = %.12f, chi(2,2) = %.12f; at N + 2: Z = %.12e, W(2,2) = %.12f, chi = %.12f (relative %.1e); the big loop's law: mass %.12f, minimum %.3e [%s] (%d s)\n", $Z0, $c0[3], $c0[4], $Z2, $c2[3], $c2[4], abs($Z2 / $Z0 - 1), $mass, $mn, (abs($Z2 / $Z0 - 1) < 1e-8 && abs($c2[3] - $c0[3]) < 1e-9 && abs($mass - 1) < 1e-9 && $mn > -1e-9) ? 'MET' : 'FAILED', time - $t0; exit 0 }
my ($Z0, $R0) = readings(\@d0); my ($w11, $w12, $w21, $w22, $chi, $be) = creutz($R0); my $p22 = density($R0->{W22}); my $p11 = density($R0->{W11});
printf "G35-BASE beta=%g datum=%s Z = %.9e; W(2,2) second mode E[cos 2Phi] = %.9f; W(1,1) = %.9f W(1,2) = %.9f W(2,1) = %.9f W(2,2) = %.9f; CREUTZ chi(2,2) = %.9f (the free-plaquette value -log(I_1/I_0) = %.6f); BLOCKED COUPLING beta_eff(2a) = %.6f against beta = %g (ratio %.4f) (%d s)\n", $beta, $DATUM, $Z0, $R0->{W22}{2}[0], $w11, $w12, $w21, $w22, $chi, -log(ib(1) / ib(0)), $be, $beta, $be / $beta, time - $t0;
POSIX::_exit(0) if $MODE eq 'base';
if ($MODE eq 'faceresp') { my @links = ([okey([1, 1, 0, 0], 3), 'the z-link above the CENTRE (in the staples of all four spokes)'], [okey([0, 0, 0, 0], 3), 'the z-link above a CORNER (two outer links)'], [okey([1, 1, 0, 0], 4), 'the t-link at the centre'], [okey([0, 0, 1, 0], 1), "a staple's middle link (X00 shifted by +z)"], [okey([1, 0, 0, 0], 3), 'the z-link above an edge-midpoint vertex (1,0)']);
  for my $lk (@links) { my ($id, $name) = @$lk; my ($mx22, $t22, $mx11, $t11, $mxb, $mxc) = (0) x 6; my @prof;
    for my $th (@ANG) { my @dd = @d0; $dd[$id] += $th * $PI / 180; my ($Z, $R) = readings(\@dd); my @c = creutz($R); my $tv22 = tv(density($R->{W22}), $p22); my $tv11 = tv(density($R->{W11}), $p11);
      push @prof, sprintf('%g:W22%+.5f/TV%.5f/W11%+.5f/TV%.5f/chi%+.4f/be%+.4f', $th, $c[3] - $w22, $tv22, $c[0] - $w11, $tv11, $c[4] - $chi, $c[5] - $be);
      $mx22 = abs($c[3] - $w22) if abs($c[3] - $w22) > $mx22; $t22 = $tv22 if $tv22 > $t22; $mx11 = abs($c[0] - $w11) if abs($c[0] - $w11) > $mx11; $t11 = $tv11 if $tv11 > $t11; $mxb = abs($c[5] - $be) if abs($c[5] - $be) > $mxb; $mxc = abs($c[4] - $chi) if abs($c[4] - $chi) > $mxc }
    printf "G35-RESP beta=%g link=%s (%s): sup |dW(2,2)| = %.6f, sup TV of the big loop's law = %.6f; sup |dW(1,1)| = %.6f, sup TV of the plaquette's law = %.6f; sup |d beta_eff| = %.6f, sup |d chi| = %.6f; profile %s (%d s)\n", $beta, $OUTKEYS[$id], $name, $mx22, $t22, $mx11, $t11, $mxb, $mxc, join(' ', @prof), time - $t0 }
  POSIX::_exit(0) }
die "unknown mode $MODE";
