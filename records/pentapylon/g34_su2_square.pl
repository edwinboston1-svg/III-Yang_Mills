#!/usr/bin/perl
# g34_su2_square.pl -- THE SU(2) 2x2 SQUARE: THE BLOCKED PLAQUETTE W(2,2), THE PLAQUETTE, THE ONE-STEP BLOCKED COUPLING AND THEIR QUOTIENT INFLUENCES,
# EXACT IN THE SPINS-<=-1 MODEL (ΠΕΝΤΑΠΥΛΟΝ G34, 2026-10-29 05:5x EDT, the desktop seat; RESULTS 16.24-16.25: the crossing's theorem lives on a COARSE
# variable after blocking, where SU(2)'s coupling runs and U(1)'s does not -- this is the non-abelian half of that reading, g35's twin).
# THE OBJECT: the 2x2 planar square in the xy-plane of Z^4 -- twelve links, four faces in a RING around the centre (1,1), every link with its outside
# plaquettes (four in z and t; one more in the plane for the eight outer links) on 104 outside links, the DATA; every plaquette weight the truncated
# w(V) = 1 + 2 a_1 chi_1/2 + 3 a_2 chi_1 of g26/g31.  THE CONTRACTION is g31's ring with the cube's top face replaced by THE BIG LOOP W(2,2) (the eight
# outer edges): its sector is RESOLVED (weight 1), its index carried around the ring, so E[chi_a(W(2,2))] = sum_s FAC[s] ZRES{a}{s} / Z for a <= LMAX
# with no fusion; face 0 is resolved as the cube's top (its weight 1, its sector widened to S0MAX), so E[chi_a(P_0)] = sum_s FAC[s] sum_{k in s x a}
# ZRES{0}{k} / Z (THE PLAQUETTE); the representations past spin 1 are g31's generic D^j (homomorphism and trace checked at load), the rule at the
# derived degree.  READINGS at a datum: W(1,1) = E[chi_1/2(P_0)]/2, W(2,2) = E[chi_1/2(W)]/2, the loop's characters to LMAX (its truncated class law),
# THE BLOCKED COUPLING beta_eff(2a) solving I_2/I_1(beta') = W(2,2) (the blocked plaquette read by the one-plaquette law), and under single-link
# changes of the data (the symmetric datum, where a change acts through its conjugacy class, so an angle grid) the responses of W(2,2), W(1,1) and
# beta_eff and the TV of the loop's truncated law.  KNOWN ANSWERS: the free square (no staples): every outer edge in one face and the loop forces the
# face spins equal to the loop's, the spokes agree, nine index loops over twelve links give ZRES{l}{l} = FAC[l]^3/(2l+1)^3 and ZERO off the diagonal,
# E[chi_1/2(W(2,2))] = 2 a_1^4 (four independent plaquettes) and E[chi_1/2(P_0)] = 2 a_1 (one free plaquette); the symmetric datum's Z real positive.
# usage: perl g34_su2_square.pl beta [MODE=base|resp|kat] [LMAX=2] [S0MAX=3]    env G34_ANGLES
use strict; use warnings; use POSIX (); $| = 1;
my ($beta, $MODE, $LMAX, $S0MAX) = @ARGV; die "usage: beta [base|resp|kat] [LMAX] [S0MAX]" unless defined $beta; $MODE //= 'base'; $LMAX //= 2; $S0MAX //= 3;
my $PI = 3.141592653589793; my $t0 = time; my @ANG = split / /, ($ENV{G34_ANGLES} // '30 60 90 120 150 180');
sub bessel { my ($n, $x) = @_; my $s = 0; my $t = ($x / 2) ** $n; my $f = 1; $f *= $_ for 1 .. $n; $t /= $f; for my $k (0 .. 200) { $s += $t; $t *= ($x / 2) ** 2 / (($k + 1) * ($k + 1 + $n)); last if $t < 1e-18 * $s } return $s }
my @A = map { bessel($_ + 1, $beta) / bessel(1, $beta) } 0 .. 8;
my $SMAX = (sort { $b <=> $a } ($LMAX, $S0MAX, 2))[0];
my @FAC = map { $_ <= 2 ? ($_ + 1) * $A[$_] : 0 } 0 .. $SMAX; my @DIM = map { $_ + 1 } 0 .. $SMAX;
my @FACT = (1); $FACT[$_] = $FACT[$_ - 1] * $_ for 1 .. 20;
sub qmul { my ($a, $b) = @_; return [ $a->[0]*$b->[0] - $a->[1]*$b->[1] - $a->[2]*$b->[2] - $a->[3]*$b->[3], $a->[0]*$b->[1] + $a->[1]*$b->[0] + $a->[2]*$b->[3] - $a->[3]*$b->[2], $a->[0]*$b->[2] - $a->[1]*$b->[3] + $a->[2]*$b->[0] + $a->[3]*$b->[1], $a->[0]*$b->[3] + $a->[1]*$b->[2] - $a->[2]*$b->[1] + $a->[3]*$b->[0] ] }
sub qinv { my $a = shift; return [ $a->[0], -$a->[1], -$a->[2], -$a->[3] ] }
sub cm { my ($a, $b) = @_; return [ $a->[0]*$b->[0] - $a->[1]*$b->[1], $a->[0]*$b->[1] + $a->[1]*$b->[0] ] }
sub ca { my ($a, $b) = @_; return [ $a->[0] + $b->[0], $a->[1] + $b->[1] ] }
sub Dhalf { my $q = shift; return [ [ [$q->[0], $q->[1]], [$q->[2], $q->[3]] ], [ [-$q->[2], $q->[3]], [$q->[0], -$q->[1]] ] ] }
sub Rone { my $q = shift; my ($w, $x, $y, $z) = @$q;
  my @R = ([1 - 2*($y*$y + $z*$z), 2*($x*$y - $w*$z), 2*($x*$z + $w*$y)], [2*($x*$y + $w*$z), 1 - 2*($x*$x + $z*$z), 2*($y*$z - $w*$x)], [2*($x*$z - $w*$y), 2*($y*$z + $w*$x), 1 - 2*($x*$x + $y*$y)]);
  return [ map { my $r = $_; [ map { [$_, 0] } @$r ] } @R ] }
my $GENINV = 0;
sub Dsub { my ($s, $q) = @_; my $a = [$q->[0], $q->[1]]; my $b = [$q->[2], $q->[3]]; my $ab = [$q->[0], -$q->[1]]; my $nbb = [-$q->[2], $q->[3]];
  my @D; for my $qq (0 .. $s) { my @poly = ([1, 0]);
    for (1 .. $qq) { my @np = map { [0, 0] } 0 .. scalar(@poly); for my $k (0 .. $#poly) { $np[$k + 1] = ca($np[$k + 1], cm($poly[$k], $a)); $np[$k] = ca($np[$k], cm($poly[$k], $b)) } @poly = @np }
    for (1 .. $s - $qq) { my @np = map { [0, 0] } 0 .. scalar(@poly); for my $k (0 .. $#poly) { $np[$k + 1] = ca($np[$k + 1], cm($poly[$k], $nbb)); $np[$k] = ca($np[$k], cm($poly[$k], $ab)) } @poly = @np }
    for my $p (0 .. $s) { my $sc = sqrt($FACT[$p] * $FACT[$s - $p] / ($FACT[$qq] * $FACT[$s - $qq])); $D[$p][$qq] = [$poly[$p][0] * $sc, $poly[$p][1] * $sc] } }
  return \@D }
sub Dgen { my ($s, $q) = @_; return Dsub($s, $GENINV ? qinv($q) : $q) }
sub rep { my ($s, $q) = @_; return [[[1, 0]]] if $s == 0; return Dhalf($q) if $s == 1; return Rone($q) if $s == 2; return Dgen($s, $q) }
sub chi { my ($s, $q) = @_; my $w = $q->[0]; my ($u0, $u1) = (1, 2 * $w); return $u0 if $s == 0; for (2 .. $s) { ($u0, $u1) = ($u1, 2 * $w * $u1 - $u0) } return $u1 }
sub cmatmul { my ($X, $Y) = @_; my $n = scalar @$X; my @Z; for my $i (0 .. $n - 1) { for my $j (0 .. $n - 1) { my $acc = [0, 0]; $acc = ca($acc, cm($X->[$i][$_], $Y->[$_][$j])) for 0 .. $n - 1; $Z[$i][$j] = $acc } } return \@Z }
sub cmatdiff { my ($X, $Y) = @_; my $n = scalar @$X; my $m = 0; for my $i (0 .. $n - 1) { for my $j (0 .. $n - 1) { my $d = abs($X->[$i][$j][0] - $Y->[$i][$j][0]) + abs($X->[$i][$j][1] - $Y->[$i][$j][1]); $m = $d if $d > $m } } return $m }
sub ctrace { my $X = shift; my $t = [0, 0]; $t = ca($t, $X->[$_][$_]) for 0 .. $#$X; return $t }
{ my $q1 = [0.5, 0.5, 0.5, 0.5]; my $q2 = [1 / sqrt(2), 0, 1 / sqrt(2), 0]; my $q3 = [0.6, 0.0, 0.8, 0.0]; my $q12 = qmul($q1, $q2); my $bad = 0; my $line = '';
  for my $s (3 .. ($SMAX < 3 ? 2 : $SMAX)) { my $d0 = cmatdiff(Dsub($s, $q12), cmatmul(Dsub($s, $q1), Dsub($s, $q2))); my $d1 = cmatdiff(Dsub($s, qinv($q12)), cmatmul(Dsub($s, qinv($q1)), Dsub($s, qinv($q2))));
    if ($s == 3) { $GENINV = ($d0 < 1e-12) ? 0 : (($d1 < 1e-12) ? 1 : -1) } my $hom = $GENINV < 0 ? 1 : cmatdiff(Dgen($s, $q12), cmatmul(Dgen($s, $q1), Dgen($s, $q2))); my $tr = $GENINV < 0 ? [0, 0] : ctrace(Dgen($s, $q3)); my $ch = chi($s, $q3);
    $bad++ if $GENINV < 0 || $hom > 1e-12 || abs($tr->[0] - $ch) > 1e-12 || abs($tr->[1]) > 1e-12; $line .= sprintf(" s=%d: hom %.1e tr-chi %.1e;", $s, $hom, abs($tr->[0] - $ch)) }
  $line = ' (no spin past 1 in use)' unless $line; printf "G34-KAT representations (GENINV=%d):%s [%s]\n", $GENINV, $line, $bad ? 'FAILED' : 'MET'; exit 1 if $bad }
my $NEED = (sort { $b <=> $a } ($S0MAX + $LMAX + 10, $S0MAX + 2 + 8, 2 + $LMAX + 10, 12))[0]; my $DEG = $NEED;
my ($NTH, $NGL, $NAZ) = (POSIX::ceil(($DEG + 1) / 2), POSIX::ceil(($DEG + 1) / 2), $DEG + 1);
sub gauss_legendre { my $n = shift; my (@x, @w); for my $i (1 .. $n) { my $x = cos($PI * ($i - 0.25) / ($n + 0.5)); my $dp;
    for (1 .. 200) { my ($p0, $p1) = (1, $x); for my $k (2 .. $n) { ($p0, $p1) = ($p1, ((2 * $k - 1) * $x * $p1 - ($k - 1) * $p0) / $k) } $dp = $n * ($x * $p1 - $p0) / ($x * $x - 1); my $dx = $p1 / $dp; $x -= $dx; last if abs($dx) < 1e-16 }
    my ($p0, $p1) = (1, $x); for my $k (2 .. $n) { ($p0, $p1) = ($p1, ((2 * $k - 1) * $x * $p1 - ($k - 1) * $p0) / $k) } $dp = $n * ($x * $p1 - $p0) / ($x * $x - 1); push @x, $x; push @w, 2 / ((1 - $x * $x) * $dp * $dp) } return (\@x, \@w) }
my @RULE; { my ($gx, $gw) = gauss_legendre($NGL); for my $k (1 .. $NTH) { my $th = $k * $PI / ($NTH + 1); my $wt = 2 * sin($th) ** 2 / ($NTH + 1); for my $j (0 .. $NGL - 1) { my $t = $gx->[$j]; my $st = sqrt(1 - $t * $t); for my $l (0 .. $NAZ - 1) { my $ph = 2 * $PI * $l / $NAZ; push @RULE, [[cos($th), sin($th) * $st * cos($ph), sin($th) * $st * sin($ph), sin($th) * $t], $wt * $gw->[$j] / 2 / $NAZ] } } } }
{ my @cat = (1, 1, 2, 5, 14, 42, 132, 429, 1430, 4862, 16796, 58786, 208012, 742900); my $bad = 0; my $wsum = 0; $wsum += $_->[1] for @RULE; $bad++ if abs($wsum - 1) > 1e-13;
  for my $k (1 .. int($DEG / 2)) { my $m = 0; $m += $_->[1] * $_->[0][0] ** (2 * $k) for @RULE; my $ex = $cat[$k] / 4 ** $k; $bad++ if abs($m - $ex) > 1e-13 * (1 + $ex) }
  printf "G34-KAT RULE%d (%d x %d x %d = %d points): the even moments to degree %d [%s]\n", $DEG, $NTH, $NGL, $NAZ, scalar @RULE, 2 * int($DEG / 2), $bad ? 'FAILED' : 'MET'; exit 1 if $bad }
sub wgt { my $V = shift; return 1 + 2 * $A[1] * chi(1, $V) + 3 * $A[2] * chi(2, $V) }
my $minw = 1e9; for my $k (0 .. 2000) { my $th = $PI * $k / 2000; my $v = wgt([cos($th), sin($th), 0, 0]); $minw = $v if $v < $minw } die "the truncated weight is not positive" unless $minw > 0;
# ---- the square: links X(x,y): (x,y)->(x+1,y); Y(x,y): (x,y)->(x,y+1); faces in a ring around (1,1); spoke i shared by face i and face i+1
my %EDGE; for my $x (0, 1) { for my $y (0 .. 2) { $EDGE{"X$x$y"} = { base => [$x, $y, 0, 0], dir => 1 } } } for my $x (0 .. 2) { for my $y (0, 1) { $EDGE{"Y$x$y"} = { base => [$x, $y, 0, 0], dir => 2 } } }
sub face { my ($x, $y) = @_; return [ ["X$x$y", 1], ["Y" . ($x + 1) . "$y", 1], ["X$x" . ($y + 1), -1], ["Y$x$y", -1] ] }
my @FACES = (face(0, 0), face(1, 0), face(1, 1), face(0, 1)); my @SPOKE = ('Y10', 'X11', 'Y11', 'X01');
my @LOOP = ( ['X00', 1], ['X10', 1], ['Y20', 1], ['Y21', 1], ['X12', -1], ['X02', -1], ['Y01', -1], ['Y00', -1] );                  # W(2,2) counterclockwise
my %FNAME = map { ($_ => "f$_") } 0 .. 3; my %CAP = (f0 => $S0MAX, f1 => 2, f2 => 2, f3 => 2, loop => $LMAX);
# the slots of every link: [face, cycle position, sign] for its faces, ['loop', loop position, sign] for the big loop
my %SLOT; for my $i (0 .. 3) { for my $m (0 .. 3) { my ($e, $sg) = @{$FACES[$i][$m]}; push @{$SLOT{$e}}, ["f$i", $m, $sg] } } for my $m (0 .. 7) { my ($e, $sg) = @{$LOOP[$m]}; push @{$SLOT{$e}}, ['loop', $m, $sg] }
for my $e (keys %EDGE) { die "link $e has " . scalar(@{$SLOT{$e}}) . " slots" unless @{$SLOT{$e}} == 2 }
# per face: the position of its previous spoke and next spoke in its cycle, and its two outer edges in the LOOP's order
my (@PREVPOS, @NEXTPOS, @LOOPSEQ); for my $i (0 .. 3) { my $prev = $SPOKE[($i + 3) % 4]; my $next = $SPOKE[$i]; for my $m (0 .. 3) { my $e = $FACES[$i][$m][0]; $PREVPOS[$i] = $m if $e eq $prev; $NEXTPOS[$i] = $m if $e eq $next }
  my @outer = grep { my $e = $_->[0]; $e ne $prev && $e ne $next } @{$FACES[$i]}; my %lp; for my $m (0 .. 7) { $lp{$LOOP[$m][0]} = $m } my @seq = sort { $lp{$a->[0]} <=> $lp{$b->[0]} } @outer;
  # the loop's consecutive pair in this face: if the two positions wrap (7 then 0) the order is reversed
  @seq = reverse @seq if $lp{$seq[0][0]} == 0 && $lp{$seq[1][0]} == 7; $LOOPSEQ[$i] = \@seq; die "face $i: the outer edges are not consecutive in the loop" unless ($lp{$seq[1][0]} - $lp{$seq[0][0]}) % 8 == 1 }
# ---- the outside plaquettes (staples): the perpendicular directions z and t both sides; the in-plane perpendicular on the outer side only
my %OUT; my @OUTKEYS; sub okey { my ($b, $d) = @_; my $k = join(',', @$b) . ":$d"; unless (exists $OUT{$k}) { $OUT{$k} = scalar @OUTKEYS; push @OUTKEYS, $k } return $OUT{$k} }
sub vadd { my ($p, $d, $s) = @_; my @q = @$p; $q[$d - 1] += $s; return \@q }
my %DANG; for my $e (sort keys %EDGE) { my ($p, $d) = ($EDGE{$e}{base}, $EDGE{$e}{dir}); my $pd = vadd($p, $d, 1);
  for my $k (1 .. 4) { next if $k == $d; my @sides; if ($k >= 3) { @sides = (1, -1) } else { my $c = $p->[$k - 1]; @sides = ($c == 0) ? (-1) : ($c == 2) ? (1) : () }
    for my $s (@sides) { my ($l1, $l2, $l3); $l1 = ($s > 0) ? [okey($pd, $k), 1] : [okey(vadd($pd, $k, -1), $k), -1]; $l2 = [okey(vadd($p, $k, $s), $d), -1]; $l3 = ($s > 0) ? [okey($p, $k), -1] : [okey(vadd($p, $k, -1), $k), 1]; push @{$DANG{$e}}, [$l1, $l2, $l3] } } }
my $NOUT = scalar @OUTKEYS; die "outside links: $NOUT, not 104" unless $NOUT == 104;
sub staple { my ($pl, $dat) = @_; my $T = [1, 0, 0, 0]; for my $l (@$pl) { my $V = $dat->[$l->[0]]; $V = qinv($V) if $l->[1] < 0; $T = qmul($T, $V) } return $T }
my $FREE = 0; my %LTC;
sub linktensor { my ($e, $dat) = @_; my @T = $FREE ? () : map { staple($_, $dat) } @{$DANG{$e}}; my $key = $e . '|' . ($FREE ? 'free' : join(';', map { join(',', map { sprintf('%.12f', $_) } @$_) } @T)); return $LTC{$key} if exists $LTC{$key};
  my @S = @{$SLOT{$e}}; my ($c1, $c2) = ($CAP{$S[0][0]}, $CAP{$S[1][0]}); my $L;
  for my $pt (@RULE) { my ($U, $wq) = @$pt; my $w = $wq; $w *= wgt(qmul($U, $_)) for @T; my @R1 = map { rep($_, $S[0][2] > 0 ? $U : qinv($U)) } 0 .. $c1; my @R2 = map { rep($_, $S[1][2] > 0 ? $U : qinv($U)) } 0 .. $c2;
    for my $s1 (0 .. $c1) { my $n1 = $DIM[$s1]; for my $s2 (0 .. $c2) { my $n2 = $DIM[$s2]; for my $a (0 .. $n1 - 1) { for my $b (0 .. $n1 - 1) { my $f1 = $R1[$s1][$a][$b]; my ($f1r, $f1i) = ($f1->[0] * $w, $f1->[1] * $w);
      for my $c (0 .. $n2 - 1) { for my $d (0 .. $n2 - 1) { my $g = $R2[$s2][$c][$d]; my $cur = $L->[$s1][$s2][$a][$b][$c][$d] //= [0, 0]; $cur->[0] += $f1r * $g->[0] - $f1i * $g->[1]; $cur->[1] += $f1r * $g->[1] + $f1i * $g->[0] } } } } } } }
  return $LTC{$key} = $L }
sub tensorget { my ($L, $e, $fA, $sA, $iA, $oA, $fB, $sB, $iB, $oB) = @_; my @S = @{$SLOT{$e}}; return ($S[0][0] eq $fA) ? ($L->[$sA][$sB][$iA][$oA][$iB][$oB] // [0, 0]) : ($L->[$sB][$sA][$iB][$oB][$iA][$oA] // [0, 0]) }
# ---- cut states (l, li, s, p, q): the loop's spin and index, the entered face's spin and the previous spoke's index pair in its rep
my @ST; for my $l (0 .. $LMAX) { for my $li (0 .. $DIM[$l] - 1) { for my $s (0 .. $S0MAX) { for my $p (0 .. $DIM[$s] - 1) { for my $q (0 .. $DIM[$s] - 1) { push @ST, [$l, $li, $s, $p, $q] } } } } }
printf "G34 beta=%g MODE=%s caps loop=%d face0=%d (others 2) rule degree %d; a_1=%.6f a_2=%.6f; %d cut states; %d outside links; datum symmetric\n", $beta, $MODE, $LMAX, $S0MAX, $DEG, $A[1], $A[2], scalar @ST, $NOUT;
my %COLC;
sub column { my ($i, $LT, $tkey) = @_; my $ck = "$i|$tkey"; return $COLC{$ck} if exists $COLC{$ck}; my $n = ($i + 1) % 4; my ($fa, $fb) = ("f$i", "f$n"); my ($cin, $cout) = ($CAP{$fa}, $CAP{$fb});
  my ($kp, $kn) = ($PREVPOS[$i], $NEXTPOS[$i]); my @free = grep { $_ != $kp && $_ != ($kp + 1) % 4 } 0 .. 3;                              # the two vertex indices not on the previous spoke
  my ($o1, $o2) = @{$LOOPSEQ[$i]}; my %pos; for my $m (0 .. 3) { $pos{$FACES[$i][$m][0]} = $m } my ($m1, $m2) = ($pos{$o1->[0]}, $pos{$o2->[0]}); my $next = $SPOKE[$i]; my %M;
  for my $zi (0 .. $#ST) { my ($l, $li, $s, $p, $q) = @{$ST[$zi]}; next if $s > $cin; my $ds = $DIM[$s]; my $dl = $DIM[$l];
    for my $zo (0 .. $#ST) { my ($l2, $lo, $s2, $p2, $q2) = @{$ST[$zo]}; next unless $l2 == $l; next if $s2 > $cout; my $acc = [0, 0];
      for my $va (0 .. $ds - 1) { for my $vb (0 .. $ds - 1) { my @v; $v[$kp] = $p; $v[($kp + 1) % 4] = $q; $v[$free[0]] = $va; $v[$free[1]] = $vb;
        my $fn = tensorget($LT->{$next}, $next, $fa, $s, $v[$kn], $v[($kn + 1) % 4], $fb, $s2, $p2, $q2); next if $fn->[0] == 0 && $fn->[1] == 0;
        for my $lm (0 .. $dl - 1) { my $f1 = tensorget($LT->{$o1->[0]}, $o1->[0], $fa, $s, $v[$m1], $v[($m1 + 1) % 4], 'loop', $l, $li, $lm); next if $f1->[0] == 0 && $f1->[1] == 0;
          my $f2 = tensorget($LT->{$o2->[0]}, $o2->[0], $fa, $s, $v[$m2], $v[($m2 + 1) % 4], 'loop', $l, $lm, $lo); $acc = ca($acc, cm(cm($f1, $f2), $fn)) } } }
      my $fac = ($i == 0) ? 1 : $FAC[$s]; $M{$zi}{$zo} = [$acc->[0] * $fac, $acc->[1] * $fac] if $acc->[0] != 0 || $acc->[1] != 0 } }
  return $COLC{$ck} = \%M }
sub matmul { my ($A, $B) = @_; my %C; for my $i (keys %$A) { for my $k (keys %{$A->{$i}}) { my $a = $A->{$i}{$k}; next unless $B->{$k}; my $Bk = $B->{$k}; for my $j (keys %$Bk) { my $b = $Bk->{$j}; my $c = $C{$i}{$j} //= [0, 0]; $c->[0] += $a->[0] * $b->[0] - $a->[1] * $b->[1]; $c->[1] += $a->[0] * $b->[1] + $a->[1] * $b->[0] } } } return \%C }
my %ZRES;
sub Zres { my $dat = shift; my %LT; my %TK; for my $e (keys %EDGE) { $LT{$e} = linktensor($e, $dat); $TK{$e} = "$LT{$e}" } my @M = map { my $i = $_; column($i, \%LT, join('|', map { $TK{$_} } sort keys %EDGE)) } 0 .. 3;
  my $P = matmul(matmul($M[0], $M[1]), matmul($M[2], $M[3])); %ZRES = (); my $imax = 0; for my $z (keys %$P) { next unless exists $P->{$z}{$z}; my ($l, $li, $s) = @{$ST[$z]}; $ZRES{$l}{$s} += $P->{$z}{$z}[0]; $imax = abs($P->{$z}{$z}[1]) if abs($P->{$z}{$z}[1]) > $imax } return $imax }
sub fuse { my ($s, $a) = @_; my @k; for (my $k = abs($s - $a); $k <= $s + $a; $k += 2) { push @k, $k } return @k }
sub zr { my ($l, $s) = @_; return $ZRES{$l}{$s} // 0 }
sub Zof { my $z = 0; $z += $FAC[$_] * zr(0, $_) for 0 .. 2; return $z }
sub Eloop { my $a = shift; my $z = 0; $z += $FAC[$_] * zr($a, $_) for 0 .. 2; return $z / Zof() }
sub Eplaq { my $a = shift; my $z = 0; for my $s (0 .. 2) { for my $k (fuse($s, $a)) { die "face0 cap $S0MAX below the needed $k" if $k > $S0MAX; $z += $FAC[$s] * zr(0, $k) } } return $z / Zof() }
sub beff { my $w = shift; return 0 if $w <= 0; my ($lo, $hi) = (0, 60); for (1 .. 200) { my $mid = ($lo + $hi) / 2; if (bessel(2, $mid) / bessel(1, $mid) < $w) { $lo = $mid } else { $hi = $mid } } return ($lo + $hi) / 2 }
my $NQ = 1440; sub looplaw { my @c = map { Eloop($_) } 0 .. $LMAX; my @p; for my $q (0 .. $NQ - 1) { my $th = $PI * ($q + 0.5) / $NQ; my $s = 0; for my $l (0 .. $LMAX) { $s += $c[$l] * sin(($l + 1) * $th) / sin($th) } push @p, $s * (2 / $PI) * sin($th) ** 2 } return (\@p, \@c) }   # the truncated class law (2/pi) sin^2 sum_l c_l chi_l
sub tv { my ($p, $q) = @_; my $s = 0; $s += abs($p->[$_] - $q->[$_]) for 0 .. $NQ - 1; return 0.5 * $s * $PI / $NQ }
my @d0 = map { [1, 0, 0, 0] } 1 .. $NOUT; my $DATUM = $ENV{G34_DATUM} // 'ordered';                                      # random:SEED = every outside link Haar-random (06:0x EDT, the plan seat's order)
if ($DATUM =~ /^random:(d+)$/) { srand($1); @d0 = map { my @g = map { my ($u1, $u2) = (rand() || 1e-300, rand()); sqrt(-2 * log($u1)) * cos(2 * $PI * $u2) } 1 .. 4; my $n = 0; $n += $_ ** 2 for @g; $n = sqrt($n); [ map { $_ / $n } @g ] } 1 .. $NOUT }
if ($MODE eq 'kat') { $FREE = 1; my $imax = Zres(\@d0); my $bad = 0; my $line = '';
  for my $l (0 .. $LMAX) { for my $s (0 .. $S0MAX) { my $v = zr($l, $s); my $ex = ($l == $s) ? $FAC[$l] ** 3 / $DIM[$l] ** 3 : 0; $bad++ if abs($v - $ex) > 1e-10 * (1 + abs($ex)); $line .= sprintf(" (%d,%d)=%.6e", $l, $s, $v) if $l == $s || abs($v) > 1e-10 } }
  my ($Z, $ew, $ep) = (Zof(), Eloop(1), Eplaq(1)); $bad++ if abs($Z - 1) > 1e-10 || abs($ew - 2 * $A[1] ** 4) > 1e-10 || abs($ep - 2 * $A[1]) > 1e-10;
  printf "G34-KAT the free square: resolved sectors%s (imag %.1e); Z = %.12f (1); E[chi_1/2(W(2,2))] = %.12f (2 a_1^4 = %.12f); E[chi_1/2(P_0)] = %.12f (2 a_1 = %.12f) [%s] (%d s)\n", $line, $imax, $Z, $ew, 2 * $A[1] ** 4, $ep, 2 * $A[1], $bad ? 'FAILED' : 'MET', time - $t0; exit($bad ? 1 : 0) }
my $imax = Zres(\@d0); my $Z0 = Zof(); my ($w11, $w22) = (Eplaq(1) / 2, Eloop(1) / 2); my ($p0, $c0) = looplaw(); my $be0 = beff($w22);
printf "G34-BASE beta=%g datum=%s Z = %.9e (imag %.1e); W(1,1) = E[tr P_0]/2 = %.9f; W(2,2) = E[tr W]/2 = %.9f; the loop's characters %s; BLOCKED COUPLING beta_eff(2a) = %.6f against beta = %g (ratio %.4f); the one-plaquette law's value at beta, I_2/I_1 = %.6f (%d s)\n", $beta, $DATUM, $Z0, $imax, $w11, $w22, join(',', map { sprintf('%.6f', $_) } @$c0), $be0, $beta, $be0 / $beta, $A[1], time - $t0;
POSIX::_exit(0) if $MODE eq 'base';
if ($MODE eq 'resp') { my @links = ([okey([1, 1, 0, 0], 3), 'the z-link above the CENTRE'], [okey([0, 0, 0, 0], 3), 'the z-link above a CORNER'], [okey([1, 1, 0, 0], 4), 'the t-link at the centre'], [okey([0, 0, 1, 0], 1), "a staple's middle link (X00 shifted by +z)"], [okey([1, 0, 0, 0], 3), 'the z-link above the edge-midpoint (1,0)']);
  my %BASE_L = map { $_ => 1 } keys %LTC; my %BASE_C = map { $_ => 1 } keys %COLC; my $clear = sub { for my $k (keys %LTC) { delete $LTC{$k} unless $BASE_L{$k} } for my $k (keys %COLC) { delete $COLC{$k} unless $BASE_C{$k} } };
  for my $lk (@links) { my ($id, $name) = @$lk; my ($mx22, $t22, $mx11, $mxb) = (0, 0, 0, 0); my @prof;
    for my $th (@ANG) { my @dd = map { [@$_] } @d0; $dd[$id] = qmul([cos($th * $PI / 360), sin($th * $PI / 360), 0, 0], $d0[$id]); Zres(\@dd); my ($w1, $w2) = (Eplaq(1) / 2, Eloop(1) / 2); my ($p) = looplaw(); my $be = beff($w2); my $t = tv($p, $p0); $clear->();
      push @prof, sprintf('%g:W22%+.5f/TV%.5f/W11%+.5f/be%+.4f', $th, $w2 - $w22, $t, $w1 - $w11, $be - $be0); $mx22 = abs($w2 - $w22) if abs($w2 - $w22) > $mx22; $t22 = $t if $t > $t22; $mx11 = abs($w1 - $w11) if abs($w1 - $w11) > $mx11; $mxb = abs($be - $be0) if abs($be - $be0) > $mxb }
    printf "G34-RESP beta=%g link=%s (%s): sup |dW(2,2)| = %.6f, sup TV of the loop's truncated law = %.6f; sup |dW(1,1)| = %.6f; sup |d beta_eff| = %.6f; profile (rotation angle) %s (%d s)\n", $beta, $OUTKEYS[$id], $name, $mx22, $t22, $mx11, $mxb, join(' ', @prof), time - $t0 }
  POSIX::_exit(0) }
die "unknown mode $MODE";
