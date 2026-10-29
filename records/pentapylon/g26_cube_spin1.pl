#!/usr/bin/perl
# g26_cube_spin1.pl -- THE CUBE'S BLOCK TRANSMISSION AT SPINS <= 1, SO THE CROSSOVER ITSELF CAN BE READ ON A 4D OBJECT (ΠΕΝΤΑΠΥΛΟΝ G26,
# 2026-10-29 03:2x EDT, the desktop seat; the plan seat's and iii-43's assignment: "the spins-<=-1 cube at 2.2, the crossover's first four-
# dimensional reading").  A READING of a TRUNCATED model, said so: every plaquette weight is w(V) = 1 + 2 a_1 chi_1/2(V) + 3 a_2 chi_1(V),
# a_n = I_{n+1}(beta)/I_1(beta) (the Wilson weight's first three characters), positive at beta = 2.2 (its minimum over V is 0.071), the dropped
# spin-3/2 term 4 a_3 chi_3/2 printed beside every reading.  g14_su2_cube.pl's spin-1/2 cube (positive only for a_1 < 1/4, i.e. beta < 1.04) is
# the a_2 = 0 restriction of this one, and is left untouched.
# THE OBJECT (as g14): the twelve links of a unit 3-cube in Z^4, its six faces, every cube link with four external plaquettes on 88 outside links
# (the data d).  Z_d = the integral over the twelve cube links of prod_faces w(U_f) prod_ext w(U_x T_e).  THE CONTRACTION: each face expanded in
# characters, inactive / spin 1/2 (a chain of 2 x 2 matrix elements around its four links, factor 2 a_1) / spin 1 (3 x 3, factor 3 a_2); the
# dangling plaquettes of a link stay as the polynomial W_x(U) = prod_e w(U T_e) (degree <= 8); every link integral int dU D^s1(U)_ab D^s2(U)_cd W_x(U)
# has degree <= 12 and is EXACT on RULE12, the product rule (Gauss-Chebyshev-U in theta, 7 nodes, weight (2/pi) sin^2) x (Gauss-Legendre in the
# axis's polar cosine, 7 nodes) x (13 equal azimuths), 637 points, exact for every polynomial of degree <= 12 on S^3 (the theta and polar parts
# to 13, the azimuth to 12).  The spin-1 representation is the real rotation matrix R(q), tr R = 4 w^2 - 1 = chi_1.  The cube is contracted as
# a RING of four columns (a top edge, a bottom edge, a vertical); the cut state carries the top face's (spin, index), the bottom face's, and
# the side face's (spin, two bonds); the top and bottom spins are constant around the ring, so the cut space splits into nine sectors of at most
# 3 x 3 x 14 = 126 states; Z = the trace of the ring product.
# THE READING (delta mode, as g14's): Delta(u, u'; d) = max over g' of osc over g of [F(d; u -> g u, u' -> g' u') - F(d; u -> g u)], F = -log Z,
# g over the 48-design, g' over GPSET (default: -1 alone, the argmax at every pair and datum of g14's 0.5 record), for the pair b0:near -> t0:near
# (the argmax pair there) at the symmetric datum; beside it Delta_link under the SAME truncated law (one link, six weights, exact on RULE12).
# KNOWN ANSWERS: RULE12's moments E w^{2k} = Catalan(k)/4^k for k <= 6 and E x^4 y^4 z^4 against its exact value; R a homomorphism with tr R =
# 4 w^2 - 1; at a_2 = 0 (MODE=spinhalf) the reading equals g14's delta record at 0.5 for the same pair (Delta = 0.005857, symmetric datum).
# MODE=quotrow (05:0x EDT; RESULTS 16.20 S2, the quotient ROW at side 1): the 88 outside links fall into FOURTEEN classes under the symmetries
# of (cube, top face) -- D_4 on the square x the t-reflection -- and at the symmetric datum a single change g acts through its CONJUGACY CLASS
# alone (the global conjugation of every link by h preserves d_0 = 1 and carries g to h g h^-1), so the response is a function of g's angle;
# each class's representative is changed by g = (cos th, sin th, 0, 0) on an angle grid, the response R(th) = E[tr U_top | d_g] - E[tr U_top | d_0]
# read, and the row = sum over classes of |class| x sup_th |R|, the near classes (touching or adjacent to the top face) apart from the far.
# Two controls per run: a second member of one class at one angle (the class label's own check) and a second design element of one
# conjugacy class (the class-function reduction's check).  The caches are cleared after every datum (the delta runs hold 2 GB each).
# usage: perl g26_cube_spin1.pl beta [MODE=delta|spinhalf|kat|faceresp|quotrow] [GPSET=1]       (GPSET: comma-separated design indices for g')
use strict; use warnings; use POSIX (); $| = 1;
my ($beta, $MODE, $GPSET) = @ARGV; die "usage: beta [delta|spinhalf|kat] [GPSET]" unless defined $beta; $MODE //= 'delta'; $GPSET //= '1';
my $PI = 3.141592653589793;
sub bessel { my ($n, $x) = @_; my $s = 0; my $t = ($x / 2) ** $n; my $f = 1; $f *= $_ for 1 .. $n; $t /= $f; for my $k (0 .. 80) { $s += $t; $t *= ($x / 2) ** 2 / (($k + 1) * ($k + 1 + $n)) } return $s }
my $A1 = bessel(2, $beta) / bessel(1, $beta); my $A2 = bessel(3, $beta) / bessel(1, $beta); my $A3 = bessel(4, $beta) / bessel(1, $beta);
$A2 = 0 if $MODE eq 'spinhalf';
my @FAC = (1, 2 * $A1, 3 * $A2); my @DIM = (1, 2, 3);
# ---- quaternions; complex numbers as [re, im]
sub qmul { my ($a, $b) = @_; return [ $a->[0]*$b->[0] - $a->[1]*$b->[1] - $a->[2]*$b->[2] - $a->[3]*$b->[3], $a->[0]*$b->[1] + $a->[1]*$b->[0] + $a->[2]*$b->[3] - $a->[3]*$b->[2], $a->[0]*$b->[2] - $a->[1]*$b->[3] + $a->[2]*$b->[0] + $a->[3]*$b->[1], $a->[0]*$b->[3] + $a->[1]*$b->[2] - $a->[2]*$b->[1] + $a->[3]*$b->[0] ] }
sub qinv { my $a = shift; return [ $a->[0], -$a->[1], -$a->[2], -$a->[3] ] }
sub cm { my ($a, $b) = @_; return [ $a->[0]*$b->[0] - $a->[1]*$b->[1], $a->[0]*$b->[1] + $a->[1]*$b->[0] ] }
sub ca { my ($a, $b) = @_; return [ $a->[0] + $b->[0], $a->[1] + $b->[1] ] }
sub Dhalf { my $q = shift; return [ [ [$q->[0], $q->[1]], [$q->[2], $q->[3]] ], [ [-$q->[2], $q->[3]], [$q->[0], -$q->[1]] ] ] }   # g14's [[w+ix, y+iz], [-y+iz, w-ix]]
sub Rone { my $q = shift; my ($w, $x, $y, $z) = @$q;
  my @R = ([1 - 2*($y*$y + $z*$z), 2*($x*$y - $w*$z), 2*($x*$z + $w*$y)], [2*($x*$y + $w*$z), 1 - 2*($x*$x + $z*$z), 2*($y*$z - $w*$x)], [2*($x*$z - $w*$y), 2*($y*$z + $w*$x), 1 - 2*($x*$x + $y*$y)]);
  return [ map { my $r = $_; [ map { [$_, 0] } @$r ] } @R ] }
sub rep { my ($s, $q) = @_; return [[[1, 0]]] if $s == 0; return $s == 1 ? Dhalf($q) : Rone($q) }
sub chi_half { my $q = shift; return 2 * $q->[0] } sub chi_one { my $q = shift; return 4 * $q->[0] * $q->[0] - 1 }
sub wgt { my $V = shift; return 1 + 2 * $A1 * chi_half($V) + 3 * $A2 * chi_one($V) }
# ---- RULE12
my @RULE; { my @gl_x = (-0.9491079123427585, -0.7415311855993945, -0.4058451513773972, 0, 0.4058451513773972, 0.7415311855993945, 0.9491079123427585);
  my @gl_w = (0.1294849661688697, 0.2797053914892766, 0.3818300505051189, 0.4179591836734694, 0.3818300505051189, 0.2797053914892766, 0.1294849661688697);
  for my $k (1 .. 7) { my $th = $k * $PI / 8; my $wt = sin($th) ** 2 / 4;
    for my $j (0 .. 6) { my $t = $gl_x[$j]; my $st = sqrt(1 - $t * $t);
      for my $l (0 .. 12) { my $ph = 2 * $PI * $l / 13; push @RULE, [[cos($th), sin($th) * $st * cos($ph), sin($th) * $st * sin($ph), sin($th) * $t], $wt * $gl_w[$j] / 2 / 13] } } } }
# the 48-design (the changes g, g')
my @DES; { my $h = 1 / sqrt(2);
  for my $i (0 .. 3) { for my $s (1, -1) { my @q = (0, 0, 0, 0); $q[$i] = $s; push @DES, [@q] } }
  for my $a (1, -1) { for my $b (1, -1) { for my $c (1, -1) { for my $d (1, -1) { push @DES, [$a / 2, $b / 2, $c / 2, $d / 2] } } } }
  for my $i (0 .. 3) { for my $j ($i + 1 .. 3) { for my $a (1, -1) { for my $b (1, -1) { my @q = (0, 0, 0, 0); $q[$i] = $a * $h; $q[$j] = $b * $h; push @DES, [@q] } } } } }
# ---- the known answers of the rule and the representation
{ my @cat = (1, 1, 2, 5, 14, 42, 132); my $bad = 0; my $line = '';
  for my $k (1 .. 6) { my $m = 0; $m += $_->[1] * $_->[0][0] ** (2 * $k) for @RULE; my $ex = $cat[$k] / 4 ** $k; $bad++ if abs($m - $ex) > 1e-13; $line .= sprintf(" E w^%d=%.15f(%.15f)", 2 * $k, $m, $ex) }
  my $m = 0; $m += $_->[1] * ($_->[0][1] * $_->[0][2] * $_->[0][3]) ** 4 for @RULE;
  # E[x^4 y^4 z^4] on S^3: by the Dirichlet moments of the squared coordinates, Gamma(5/2)^3 Gamma(1/2) Gamma(2) / (Gamma(1/2)^4 Gamma(8)) = (3/4)^3 x 1 / 5040 x 1 ... computed below exactly
  my $ex = (0.75 ** 3) * 0.5 * 1 * 1 / (0.5 * 0.5 * 0.5 * 0.5) * (1 * 0.5 * 0.5 * 0.5 * 0.5) / 5040 * 0 ; $ex = (105 / 16) * (105 / 16) * (105 / 16) / 1 / 1;   # placeholder overwritten below
  # exact: E[prod x_i^{2a_i}] on S^{n-1} (n = 4) = Gamma(n/2) prod Gamma(a_i + 1/2) / (Gamma(1/2)^n Gamma(n/2 + sum a_i)); here a = (0, 2, 2, 2): Gamma(2) Gamma(1/2) Gamma(5/2)^3 / (Gamma(1/2)^4 Gamma(8))
  $ex = 1 * (0.75) ** 3 / 5040;                                                                    # Gamma(5/2)/Gamma(1/2) = 3/4, Gamma(2) = 1, Gamma(8) = 5040
  $bad++ if abs($m - $ex) > 1e-15; $line .= sprintf(" E x^4y^4z^4=%.3e(%.3e)", $m, $ex);
  my $q1 = [0.5, 0.5, 0.5, 0.5]; my $q2 = [1 / sqrt(2), 0, 1 / sqrt(2), 0]; my ($P, $A, $B) = (Rone(qmul($q1, $q2)), Rone($q1), Rone($q2));
  for my $i (0 .. 2) { for my $j (0 .. 2) { my $s = 0; $s += $A->[$i][$_][0] * $B->[$_][$j][0] for 0 .. 2; $bad++ if abs($s - $P->[$i][$j][0]) > 1e-12 } }
  my $tr = $A->[0][0][0] + $A->[1][1][0] + $A->[2][2][0]; $bad++ if abs($tr - chi_one($q1)) > 1e-12;
  printf "G26-KAT RULE12 %d points:%s; R(q1 q2) = R(q1) R(q2) and tr R = 4w^2 - 1: %s  [%s]\n", scalar @RULE, $line, $bad ? 'FAILED' : 'MET', $bad ? 'KAT-RED' : 'KAT-GREEN';
  exit 1 if $bad }
my $minw = 1e9; for my $k (0 .. 2000) { my $th = $PI * $k / 2000; my $v = wgt([cos($th), sin($th), 0, 0]); $minw = $v if $v < $minw }
printf "G26 beta=%g MODE=%s a_1=%.6f a_2=%.6f a_3=%.6f; the truncated weight's minimum over V = %.6f (%s); the dropped spin-3/2 term's size against the kept: 16 a_3 / (1 + 4 a_1 + 9 a_2) = %.3f\n", $beta, $MODE, $A1, $A2, $A3, $minw, $minw > 0 ? 'positive' : 'NOT POSITIVE', 16 * $A3 / (1 + 4 * $A1 + 9 * $A2);
die "the truncated weight is not positive" unless $minw > 0;
exit 0 if $MODE eq 'kat';
# ---- the cube (g14's construction verbatim)
my @C = ([0, 0], [1, 0], [1, 1], [0, 1]); my %EDGE;
for my $i (0 .. 3) { my $n = ($i + 1) % 4; my ($x0, $y0) = @{$C[$i]}; my ($x1, $y1) = @{$C[$n]};
  my $dir = ($x1 != $x0) ? 1 : 2; my $fwd = ($x1 + $y1 > $x0 + $y0) ? 1 : -1; my $bx = $fwd > 0 ? $x0 : $x1; my $by = $fwd > 0 ? $y0 : $y1;
  $EDGE{"b$i"} = { base => [$bx, $by, 0, 0], dir => $dir, sgn => $fwd }; $EDGE{"t$i"} = { base => [$bx, $by, 1, 0], dir => $dir, sgn => $fwd };
  $EDGE{"v$i"} = { base => [$x0, $y0, 0, 0], dir => 3, sgn => 1 } }
my %FACE = (bottom => [ map { ["b$_", $EDGE{"b$_"}{sgn}] } 0 .. 3 ], top => [ map { ["t$_", $EDGE{"t$_"}{sgn}] } 0 .. 3 ]);
for my $i (0 .. 3) { my $n = ($i + 1) % 4; $FACE{"side$i"} = [ ["b$i", $EDGE{"b$i"}{sgn}], ["v$n", 1], ["t$i", -$EDGE{"t$i"}{sgn}], ["v$i", -1] ] }
my %OUT; my @OUTKEYS; sub okey { my ($b, $d) = @_; my $k = join(',', @$b) . ":$d"; unless (exists $OUT{$k}) { $OUT{$k} = scalar @OUTKEYS; push @OUTKEYS, $k } return $OUT{$k} }
sub vadd { my ($p, $d, $s) = @_; my @q = @$p; $q[$d - 1] += $s; return \@q }
my %DANG;
for my $e (sort keys %EDGE) { my ($p, $d) = ($EDGE{$e}{base}, $EDGE{$e}{dir}); my $pd = vadd($p, $d, 1);
  for my $k (1 .. 4) { next if $k == $d; my @sides = ($k == 4) ? (1, -1) : ($p->[$k - 1] == 1 ? (1) : (-1));
    for my $s (@sides) { my ($l1, $l2, $l3);
      $l1 = ($s > 0) ? [okey($pd, $k), 1] : [okey(vadd($pd, $k, -1), $k), -1];
      $l2 = [okey(vadd($p, $k, $s), $d), -1];
      $l3 = ($s > 0) ? [okey($p, $k), -1] : [okey(vadd($p, $k, -1), $k), 1];
      push @{$DANG{$e}}, [$l1, $l2, $l3] } } }
my $NOUT = scalar @OUTKEYS; die "outside links: $NOUT, not 88" unless $NOUT == 88;
sub staple { my ($pl, $dat) = @_; my $T = [1, 0, 0, 0]; for my $l (@$pl) { my $V = $dat->[$l->[0]]; $V = qinv($V) if $l->[1] < 0; $T = qmul($T, $V) } return $T }
my %SLOT; for my $f (sort keys %FACE) { my $cyc = $FACE{$f}; for my $m (0 .. 3) { my ($e, $sg) = @{$cyc->[$m]}; push @{$SLOT{$e}}, [$f, $m, $sg] } }
# ---- link tensors, cached by the edge and its four staples: L->[s1][s2][a][b][c][d] (complex)
my %LTC;
sub linktensor { my ($e, $dat) = @_; my @T = map { staple($_, $dat) } @{$DANG{$e}}; my $key = $e . '|' . join(';', map { join(',', map { sprintf('%.12f', $_) } @$_) } @T);
  return $LTC{$key} if exists $LTC{$key};
  my @S = @{$SLOT{$e}}; my $L;
  for my $pt (@RULE) { my ($U, $wq) = @$pt; my $w = $wq; $w *= wgt(qmul($U, $_)) for @T;
    my @R1 = map { rep($_, $S[0][2] > 0 ? $U : qinv($U)) } 0 .. 2; my @R2 = map { rep($_, $S[1][2] > 0 ? $U : qinv($U)) } 0 .. 2;
    for my $s1 (0 .. 2) { next if $s1 == 2 && $A2 == 0; my $n1 = $DIM[$s1]; for my $s2 (0 .. 2) { next if $s2 == 2 && $A2 == 0; my $n2 = $DIM[$s2];
      for my $a (0 .. $n1 - 1) { for my $b (0 .. $n1 - 1) { my $f1 = $R1[$s1][$a][$b];
        for my $c (0 .. $n2 - 1) { for my $d (0 .. $n2 - 1) { my $v = cm($f1, $R2[$s2][$c][$d]); my $cur = $L->[$s1][$s2][$a][$b][$c][$d] //= [0, 0]; $cur->[0] += $v->[0] * $w; $cur->[1] += $v->[1] * $w } } } } } } }
  return $LTC{$key} = $L }
sub tensorget { my ($L, $e, $fA, $sA, $iA, $oA, $fB, $sB, $iB, $oB) = @_; my @S = @{$SLOT{$e}};
  return ($S[0][0] eq $fA) ? ($L->[$sA][$sB][$iA][$oA][$iB][$oB] // [0, 0]) : ($L->[$sB][$sA][$iB][$oB][$iA][$oA] // [0, 0]) }
# ---- cut states: (tT, ti, tB, bi, sS, p, q) -> integer; the list of states per sector (tT, tB)
my $SMAX = ($A2 == 0) ? 1 : 2; my (@ST, %SID);
for my $tT (0 .. $SMAX) { for my $ti (0 .. $DIM[$tT] - 1) { for my $tB (0 .. $SMAX) { for my $bi (0 .. $DIM[$tB] - 1) { for my $sS (0 .. $SMAX) { for my $p (0 .. $DIM[$sS] - 1) { for my $q (0 .. $DIM[$sS] - 1) {
  my $k = join(',', $tT, $ti, $tB, $bi, $sS, $p, $q); $SID{$k} = scalar @ST; push @ST, [$tT, $ti, $tB, $bi, $sS, $p, $q] } } } } } } }
# column i holds t_i, b_i, v_{i+1}; returns a sparse matrix M{zin}{zout} (complex)
my %COLC;
sub column { my ($i, $LT, $tkey) = @_; my $ck = "$i|$tkey"; return $COLC{$ck} if exists $COLC{$ck};
  my $n = ($i + 1) % 4; my ($t, $b, $v) = ("t$i", "b$i", "v$n"); my $sf = "side$i"; my $sn = "side$n"; my %M;
  for my $zi (0 .. $#ST) { my ($tT, $ti, $tB, $bi, $sS, $tv, $vb) = @{$ST[$zi]};
    for my $zo (0 .. $#ST) { my ($tT2, $to, $tB2, $bo, $sS2, $tvn, $vbn) = @{$ST[$zo]}; next unless $tT2 == $tT && $tB2 == $tB;
      my $acc = [0, 0]; my $dS = $DIM[$sS];
      for my $bv (0 .. $dS - 1) { for my $vt (0 .. $dS - 1) {
        my $fb = tensorget($LT->{$b}, $b, 'bottom', $tB, $bi, $bo, $sf, $sS, $vb, $bv); next if $fb->[0] == 0 && $fb->[1] == 0;
        my $fv = tensorget($LT->{$v}, $v, $sf, $sS, $bv, $vt, $sn, $sS2, $tvn, $vbn); next if $fv->[0] == 0 && $fv->[1] == 0;
        my $ft = tensorget($LT->{$t}, $t, 'top', $tT, $ti, $to, $sf, $sS, $vt, $tv);
        $acc = ca($acc, cm(cm($fb, $fv), $ft)) } }
      my $fac = $FAC[$sS]; $fac *= $FAC[$tT] * $FAC[$tB] if $i == 0;
      $M{$zi}{$zo} = [$acc->[0] * $fac, $acc->[1] * $fac] if $acc->[0] != 0 || $acc->[1] != 0 } }
  return $COLC{$ck} = \%M }
sub matmul { my ($A, $B) = @_; my %C; for my $i (keys %$A) { for my $k (keys %{$A->{$i}}) { my $a = $A->{$i}{$k}; next unless $B->{$k}; my $Bk = $B->{$k}; for my $j (keys %$Bk) { my $b = $Bk->{$j}; my $c = $C{$i}{$j} //= [0, 0]; $c->[0] += $a->[0] * $b->[0] - $a->[1] * $b->[1]; $c->[1] += $a->[0] * $b->[1] + $a->[1] * $b->[0] } } } return \%C }
my %ZSEC;
# E[tr U_top | d] = (1/Z) sum_s FAC[s] sum_{s' in s x 1/2} Z_top(s'), Z_top(s') = the sector sum with the top face at spin s' and weight 1 (= ZSEC{s'}/FAC[s']);
# the s' = 3/2 term lies outside the truncation and is dropped (its size ~ 3 a_2 x the spin-3/2 share, printed as the top face's c_3 share)
sub Etop { my $dat = shift; my $Z = Zof($dat); my @zt = map { ($ZSEC{$_} // 0) / $FAC[$_] } 0 .. 2; my $e = ($FAC[0] * $zt[1] + $FAC[1] * ($zt[0] + $zt[2]) + $FAC[2] * $zt[1]) / $Z; return ($e, $Z, @zt) }
sub Zof { my $dat = shift; my %LT; my %TK; for my $e (keys %EDGE) { $LT{$e} = linktensor($e, $dat); $TK{$e} = "$LT{$e}" }
  my @M = map { my $i = $_; my $n = ($i + 1) % 4; column($i, \%LT, join('|', $TK{"t$i"}, $TK{"b$i"}, $TK{"v$n"})) } 0 .. 3;
  my $P = matmul(matmul($M[0], $M[1]), matmul($M[2], $M[3])); my $Z = [0, 0]; %ZSEC = (); for my $z (keys %$P) { next unless exists $P->{$z}{$z}; $Z = ca($Z, $P->{$z}{$z}); my $tT = $ST[$z][0]; $ZSEC{$tT} += $P->{$z}{$z}[0] }   # the trace split by the top face's spin (FACE mode)
  die sprintf("Z not real positive: %.6e + %.6e i", @$Z) unless $Z->[0] > 0 && abs($Z->[1]) < 1e-9 * $Z->[0]; return $Z->[0] }
# ---- the reading
my %EDGEOUT; my $t = sub { my ($name, $which) = @_; my $e = $EDGE{$name}; my ($p, $d) = ($e->{base}, $e->{dir}); my $s = ($p->[2] == 1) ? 1 : -1; return $which eq 'par' ? okey(vadd($p, 3, $s), $d) : ($s > 0 ? okey($p, 3) : okey(vadd($p, 3, -1), 3)) };
my ($u, $up) = ($t->('b0', 'near'), $t->('t0', 'near')); my @GP = split /,/, $GPSET;
my $t0 = time;
# Delta_link under the same truncated law: one link with four staples at 1 and two moved by g, g'
my $dlink = 0; { my %F; for my $gi (0 .. 47) { for my $gp (0, @GP) { my $Z = 0; for my $pt (@RULE) { my ($U, $wq) = @$pt; $Z += $wq * wgt($U) ** 4 * wgt(qmul($U, $DES[$gi])) * wgt(qmul($U, $DES[$gp])) } $F{$gi}{$gp} = -log($Z) } }
  for my $gp (@GP) { my ($mx, $mn) = (-1e9, 1e9); for my $gi (0 .. 47) { my $m = $F{$gi}{$gp} - $F{$gi}{0}; $mx = $m if $m > $mx; $mn = $m if $m < $mn } $dlink = $mx - $mn if $mx - $mn > $dlink } }
printf "G26-LINK beta=%g MODE=%s Delta_link (one link, two of six staples moved by g and g' in {%s}, the rest 1) under the truncated law = %.6f\n", $beta, $MODE, join(',', @GP), $dlink;
# ---- MODE=faceresp (04:0x EDT; RESULTS 16.8 (ii), the first-moment QUOTIENT response): E[tr U_top | d] at the symmetric datum and under every
# design change of ONE boundary link -- u (the near vertical under b0, far from the top face) and u' (the near vertical above t0, at its corner);
# the response sup_g |E[tr U_top | d_g] - E[tr U_top | d]| is a gauge-invariant block observable's answer to a boundary change, to be set beside
# the link-marginal influences (the crystal) at the same coupling.
if ($MODE eq 'faceresp') { my @d0 = map { [1, 0, 0, 0] } 1 .. $NOUT; my ($e0, $Z0, @zt0) = Etop(\@d0);
  printf "G26-FACE beta=%g datum=symmetric E[tr U_top] = %.6f (Z = %.6e; the sector shares Z_top(0,1/2,1)/Z = %.4f %.4f %.4f) (%d s)\n", $beta, $e0, $Z0, map({ $_ / $Z0 } @zt0), time - $t0;
  for my $pair ([$u, 'u: the near vertical under b0 (far from the top face)'], [$up, "u': the near vertical above t0 (at the top face's corner)"]) { my ($lk, $name) = @$pair; my ($mx, $mg) = (0, -1); my $sum = 0;
    for my $gi (1 .. 47) { my @dd = map { [@$_] } @d0; $dd[$lk] = qmul($DES[$gi], $d0[$lk]); my ($e) = Etop(\@dd); my $r = abs($e - $e0); $sum += $r; if ($r > $mx) { $mx = $r; $mg = $gi } printf "G26-FACE-PROGRESS %s g=%d of 47 |dE|=%.6f (%d s)\n", $OUTKEYS[$lk], $gi, $r, time - $t0 if $gi % 8 == 0 }
    printf "G26-FACE beta=%g link=%s (%s): sup over the 47 changes of |E[tr U_top | d_g] - E[tr U_top | d]| = %.6f at g=(%s); the mean over changes %.6f  (%d s)\n", $beta, $OUTKEYS[$lk], $name, $mx, join(',', map { sprintf('%.3f', $_) } @{$DES[$mg]}), $sum / 47, time - $t0 }
  POSIX::_exit(0) }
# ---- MODE=quotrow (RESULTS 16.20 S2): the fourteen classes of outside links, the angle grid, the row at the symmetric datum
if ($MODE eq 'quotrow') {
  my %cube = map { my ($x, $y, $z) = @$_; ("$x,$y,$z,0" => 1) } ([0,0,0],[1,0,0],[1,1,0],[0,1,0],[0,0,1],[1,0,1],[1,1,1],[0,1,1]);
  my $DN = ('x', 'y', 'z', 't'); my @DN = ('x', 'y', 'z', 't');
  my $classify = sub { my $k = shift; my ($pos, $d) = split /:/, $k; my @p = split /,/, $pos; my @q = @p; $q[$d - 1]++;
    my $ends = (exists $cube{join(',', @p)} ? 1 : 0) + (exists $cube{join(',', @q)} ? 1 : 0); die "cube link in the outside list: $k" if $ends == 2;
    if ($ends == 1) { my @v = exists $cube{join(',', @p)} ? @p : @q; my $side = $v[2] == 1 ? 'near' : 'far'; my $dt = $d == 4 ? 't' : $d == 3 ? 'z' : 'inplane'; return "$dt-$side" }
    for my $kk (1 .. 4) { next if $kk == $d; for my $s (1, -1) { my @a = @p; $a[$kk - 1] += $s; my @b = @q; $b[$kk - 1] += $s;
      if (exists $cube{join(',', @a)} && exists $cube{join(',', @b)}) { my $st = $kk == 4 ? 't' : $kk == 3 ? 'z' : 'inplane'; my $et = $d == 3 ? 'vert' : ($a[2] == 1 ? 'top' : 'bottom'); return "$st-middle-$et" } } }
    die "unclassified outside link $k" };
  my (%CLS, %CNT); for my $k (@OUTKEYS) { my $c = $classify->($k); push @{$CLS{$c}}, $k; $CNT{$c}++ }
  my @ORDER = ('t-near', 'inplane-near', 'z-near', 't-middle-top', 'z-middle-top', 'inplane-middle-top', 't-middle-vert', 'inplane-middle-vert', 't-far', 'inplane-far', 'z-far', 't-middle-bottom', 'z-middle-bottom', 'inplane-middle-bottom');
  my %EXP = ('t-near' => 8, 'inplane-near' => 8, 'z-near' => 4, 't-middle-top' => 8, 'z-middle-top' => 4, 'inplane-middle-top' => 4, 't-middle-vert' => 8, 'inplane-middle-vert' => 8, 't-far' => 8, 'inplane-far' => 8, 'z-far' => 4, 't-middle-bottom' => 8, 'z-middle-bottom' => 4, 'inplane-middle-bottom' => 4);
  my $tot = 0; my $cbad = 0; for my $c (@ORDER) { $tot += $CNT{$c} // 0; $cbad++ unless ($CNT{$c} // 0) == $EXP{$c} } $cbad++ unless $tot == 88 && scalar(keys %CNT) == 14;
  printf "G26-QROW-CENSUS the 88 outside links in %d classes: %s [%s]\n", scalar(keys %CNT), join(' ', map { "$_=" . ($CNT{$_} // 0) } @ORDER), $cbad ? 'CENSUS-RED' : 'CENSUS-MET';
  die "the class census is not the staked one" if $cbad;
  my @ANG = split / /, ($ENV{G26_ANGLES} // '15 30 45 60 75 90 105 120 135 150 165 180'); my @USE = split / /, ($ENV{G26_ORBITS} // join(' ', @ORDER));
  my @d0 = map { [1, 0, 0, 0] } 1 .. $NOUT; my ($e0, $Z0, @zt0) = Etop(\@d0);
  my %BASE_L = map { $_ => 1 } keys %LTC; my %BASE_C = map { $_ => 1 } keys %COLC;
  my $clear = sub { for my $k (keys %LTC) { delete $LTC{$k} unless $BASE_L{$k} } for my $k (keys %COLC) { delete $COLC{$k} unless $BASE_C{$k} } };
  printf "G26-QROW beta=%g datum=symmetric E[tr U_top] = %.9f (Z = %.6e; sector shares %.4f %.4f %.4f); angles %s (%d s)\n", $beta, $e0, $Z0, map({ $_ / $Z0 } @zt0), join(',', @ANG), time - $t0;
  my $resp = sub { my ($lk, $g) = @_; my @dd = map { [@$_] } @d0; $dd[$lk] = qmul($g, $d0[$lk]); my ($e) = Etop(\@dd); $clear->(); return $e - $e0 };
  # the two controls first: the class label (a second member of t-near at 120 deg) and the class function (two design elements with w = 0)
  { my ($a, $b) = @{$CLS{'t-near'}}[0, -1]; my $g = [cos(2 * $PI / 3), sin(2 * $PI / 3), 0, 0]; my ($ra, $rb) = ($resp->($OUT{$a}, $g), $resp->($OUT{$b}, $g));
    printf "G26-QROW-CONTROL class label: t-near members %s and %s at 120 deg respond %.9f and %.9f [%s] (%d s)\n", $a, $b, $ra, $rb, abs($ra - $rb) < 1e-7 * (1 + abs($ra)) ? 'EQUAL' : 'UNEQUAL', time - $t0;
    my $lk = $OUT{$CLS{'z-near'}[0]}; my ($r1, $r2, $r3) = map { $resp->($lk, $_) } ([0, 1, 0, 0], [0, 0, 0, 1], [0, 1 / sqrt(2), 1 / sqrt(2), 0]);
    printf "G26-QROW-CONTROL class function: z-near %s under three design elements of angle 90 deg responds %.9f %.9f %.9f [%s] (%d s)\n", $CLS{'z-near'}[0], $r1, $r2, $r3, (abs($r1 - $r2) < 1e-7 * (1 + abs($r1)) && abs($r1 - $r3) < 1e-7 * (1 + abs($r1))) ? 'EQUAL' : 'UNEQUAL', time - $t0 }
  my (%SUP, %ARG); for my $c (@USE) { my $lk = $OUT{$CLS{$c}[0]}; my ($mx, $mt) = (0, 0); my @prof;
    for my $th (@ANG) { my $g = [cos($th * $PI / 180), sin($th * $PI / 180), 0, 0]; my $r = $resp->($lk, $g); push @prof, sprintf('%g:%+.6f', $th, $r); if (abs($r) > $mx) { $mx = abs($r); $mt = $th } }
    $SUP{$c} = $mx; $ARG{$c} = $mt; printf "G26-QROW-CLASS %s (%d links, rep %s): sup_th |E[tr U_top | d_g] - E[tr U_top | d_0]| = %.9f at %g deg; profile %s (%d s)\n", $c, $CNT{$c}, $CLS{$c}[0], $mx, $mt, join(' ', @prof), time - $t0 }
  my ($near, $far) = (0, 0); for my $c (@USE) { my $v = $CNT{$c} * $SUP{$c}; if ($c =~ /near|top|vert/) { $near += $v } else { $far += $v } }
  printf "G26-QROW-ROW beta=%g the first-moment quotient row of the top face at the symmetric datum: sum over classes |class| x sup |dE[tr U_top]| = %.6f (near %.6f + far %.6f) over %d of 14 classes; in the 1-Lipschitz unit (cos theta_top, the row / 2) %.6f; the mean E[tr U_top] %.6f  [%s] (%d s)\n",
    $beta, $near + $far, $near, $far, scalar @USE, ($near + $far) / 2, $e0, scalar(@USE) == 14 ? 'ROW-COMPLETE' : 'ROW-PARTIAL', time - $t0;
  POSIX::_exit(0) }
# ---- MODE=quotworst (05:0x EDT; RESULTS 16.21 (iv), the WORST CASE): the cancelling datum d_c -- the four middle links of t0's staples set so the
# staples read 1, -1, i, -i (sum zero) -- then the un-cancelling change: the first middle link under every design change g (47), the response of
# E[tr U_top] read; beside it the same 47 changes of a near link NOT in t0's staples (the z-near above t1's base) at d_c, and the symmetric datum's
# value for the comparison.  Staked: E[tr U_top](d_c) in [0.95, 1.25]; the un-cancelling sup in [0.15, 0.45], argmax with w_g <= 0, >= 3 x 0.058585.
if ($MODE eq 'quotworst') {
  my @d0 = map { [1, 0, 0, 0] } 1 .. $NOUT; my ($e0, $Z0) = Etop(\@d0);
  my %BASE_L = map { $_ => 1 } keys %LTC; my %BASE_C = map { $_ => 1 } keys %COLC;
  my $clear = sub { for my $k (keys %LTC) { delete $LTC{$k} unless $BASE_L{$k} } for my $k (keys %COLC) { delete $COLC{$k} unless $BASE_C{$k} } };
  my @want = ([1, 0, 0, 0], [-1, 0, 0, 0], [0, 1, 0, 0], [0, -1, 0, 0]); my @mid = map { $_->[1][0] } @{$DANG{'t0'}}; die "t0 has " . scalar(@mid) . " staples, not 4" unless @mid == 4;
  my @dc = map { [@$_] } @d0; for my $s (0 .. 3) { $dc[$mid[$s]] = qinv($want[$s]) }                   # the staple is l1 . l2^-1 . l3 with l1 = l3 = 1
  my @T = map { staple($_, \@dc) } @{$DANG{'t0'}}; my @sum = (0, 0, 0, 0); for my $T (@T) { $sum[$_] += $T->[$_] for 0 .. 3 } my $ns = 0; $ns += $_ ** 2 for @sum;
  printf "G26-QWORST-KAT the staples of t0 at d_c: %s; their sum (%s) has norm %.1e [%s]\n", join(' ', map { '(' . join(',', map { sprintf('%+.0f', $_) } @$_) . ')' } @T), join(',', map { sprintf('%.3f', $_) } @sum), sqrt($ns), sqrt($ns) < 1e-12 ? 'CANCELLED' : 'NOT-CANCELLED';
  die "the datum does not cancel" unless sqrt($ns) < 1e-12;
  my ($ec, $Zc) = Etop(\@dc); $clear->();
  printf "G26-QWORST beta=%g E[tr U_top] at the symmetric datum %.9f, at the cancelling datum d_c(t0) %.9f (Z_c = %.6e); the drop %.6f  [%s] (%d s)\n", $beta, $e0, $ec, $Zc, $e0 - $ec, ($ec >= 0.95 && $ec <= 1.25) ? 'STAKE-MET' : 'STAKE-MISSED', time - $t0;
  my $zn = okey([1, 0, 1, 0], 3); die "z-near above t1's base is in t0's staples" if grep { $_ == $zn } @mid;
  for my $series ([$mid[0], "the un-cancelling change (t0's first middle link, staple 1 -> g^-1)"], [$zn, "a near link outside t0's staples (the z-near above (1,0,1))"]) { my ($lk, $name) = @$series; my ($mx, $mg, $sum) = (0, -1, 0); my @prof;
    for my $gi (1 .. 47) { my @dd = map { [@$_] } @dc; $dd[$lk] = qmul($DES[$gi], $dc[$lk]); my ($e) = Etop(\@dd); $clear->(); my $r = $e - $ec; $sum += abs($r); push @prof, sprintf('%d:%+.5f', $gi, $r); if (abs($r) > $mx) { $mx = abs($r); $mg = $gi }
      printf "G26-QWORST-PROGRESS %s g=%d of 47 dE=%+.6f (%d s)\n", $OUTKEYS[$lk], $gi, $r, time - $t0 if $gi % 8 == 0 }
    printf "G26-QWORST-SERIES beta=%g link=%s (%s) at d_c: sup over the 47 changes of |E[tr U_top | d_c,g] - E[tr U_top | d_c]| = %.6f at g=(%s) (w_g = %+.3f), the mean %.6f; against the symmetric datum's near sup 0.058585: %.2f x; profile %s  (%d s)\n",
      $beta, $OUTKEYS[$lk], $name, $mx, join(',', map { sprintf('%.3f', $_) } @{$DES[$mg]}), $DES[$mg][0], $sum / 47, $mx / 0.058585, join(' ', @prof), time - $t0 }
  POSIX::_exit(0) }
my @d0 = map { [1, 0, 0, 0] } 1 .. $NOUT; my $Z0 = Zof(\@d0); printf "G26-Z0 beta=%g MODE=%s Z at the symmetric datum = %.12e (%d s)\n", $beta, $MODE, $Z0, time - $t0;
my %F; for my $gi (0 .. 47) { for my $gp (0, @GP) { my @dd = map { [@$_] } @d0; $dd[$u] = qmul($DES[$gi], $d0[$u]); $dd[$up] = qmul($DES[$gp], $d0[$up]); $F{$gi}{$gp} = -log(Zof(\@dd)) }
  printf "G26-PROGRESS g=%d of 48 (%d s)\n", $gi + 1, time - $t0 if ($gi + 1) % 8 == 0 }
my ($best, $bg) = (0, -1); for my $gp (@GP) { my ($mx, $mn) = (-1e9, 1e9); for my $gi (0 .. 47) { my $m = $F{$gi}{$gp} - $F{$gi}{0}; $mx = $m if $m > $mx; $mn = $m if $m < $mn } if ($mx - $mn > $best) { $best = $mx - $mn; $bg = $gp } }
printf "G26-DELTA beta=%g MODE=%s datum=symmetric pair=b0:near -> t0:near u=%s u'=%s Delta_cube=%.6f argmax-g'=(%s) Delta_link=%.6f ratio=%.4f (a_1^4 = %.4e; Delta/a_1^4 = %.2f)  (%d s)\n", $beta, $MODE, $OUTKEYS[$u], $OUTKEYS[$up], $best, join(',', map { sprintf('%.3f', $_) } @{$DES[$bg]}), $dlink, $best / $dlink, $A1 ** 4, $best / $A1 ** 4, time - $t0;
POSIX::_exit(0);
