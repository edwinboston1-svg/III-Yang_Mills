#!/usr/bin/perl
# g14_su2_cube.pl -- THE CUBE'S TRUE DOBRUSHIN-SHLOSMAN SUM FOR SU(2) ON Z^4, READ EXACTLY FOR GIVEN BOUNDARY DATA (ΠΕΝΤΑΠΥΛΟΝ G14, 2026-10-29
# 00:4x EDT, the desktop seat; the Yang-Mills seat's order: "build the reader ... the reader prints the argmax data, not only the max").
#
# THE OBJECT.  Block V = the twelve links of a unit cube in directions 1-3 of Z^4; faces = its six plaquettes; every cube link has four EXTERNAL
# plaquettes (two in its cube planes on the outward sides, two in the 4-direction), each with three OUTSIDE links -- 48 external plaquettes on
# 88 distinct outside links (48 parallel ones in one plaquette each, 24 vertex links of directions 1-3 in two, 16 vertex links of direction 4
# in three).  Wilson action truncated at spin 1/2: every plaquette weight is w(V) = 1 + 2 a_1 tr V with a_1 = I_2(beta)/I_1(beta) (positive
# for a_1 < 1/4), the dropped spin-1 term 3 a_2 chi_1 priced beside the reading.  The conditional marginal of a cube link x given the outside
# data d is mu_x(U) = N_d(U)/Z_d with N_d(U) the integral over the eleven other cube links of prod_faces w(U_f) prod_ext w(U_{x(e)} T_e),
# T_e the external staple (the ordered product of the three outside links).  EXACT EVALUATION: expand only the six FACES in characters
# (each face active = spin 1/2, a chain of 2 x 2 matrix elements around its four links, or inactive); the dangling plaquettes of a link stay
# as the polynomial W_y(U) = prod (1 + 2 a_1 tr(U T_e)); every link integral int dU D(U)_{ab} D(U)_{cd} W_y(U) has degree <= 6 in the unit
# quaternion's coordinates and is EXACT by the 7-design of the binary octahedral group (48 points; its moments E w^2 = 1/4, E w^4 = 1/8,
# E w^6 = 5/64 checked at load).  The cube is contracted as a RING of four columns (a top edge, a bottom edge, a vertical) with a 45-state
# cut (top chain bond, bottom chain bond, the side face's two bonds on the vertical, each face inactive or 2-dimensional); the marginal's link
# x = t_0 is left OPEN, so N_d(U) is a 16-entry tensor contracted with D(U) D(U) W_x(U), Z_d its design average (exact), and the total
# variation between two data is a quadrature on S^3 (theta by midpoints, the axis by a Fibonacci sphere).  Anchors: tv(d, d) = 0; the direct
# influence at small beta against the single-link law (4/3pi) beta (the first-order TV is a_1 int |tr(U dT)| dU = (8/3pi) a_1 |dT|/... = 0.4244 beta
# at a sign flip of a staple); the orbit of an outside link under the stabiliser of x (eight maps) gives equal influences.
# THE READING.  For data d and an outside link j, rho_xj(d) = max over g in 2O of tv(mu_x | d, mu_x | d with V_j -> g V_j); the DS sum at d is
# 12 sum_j rho_xj(d) (the twelve cube links equivalent), the criterion holds iff it is below 12.  Printed: at the SYMMETRIC data (every outside
# link 1) the influence of every orbit of j with its maximising g; then random data (the seat's question: does the maximiser wander?).
# MODE=randomall (2026-10-29 00:3x EDT, for the plan seat's sup over data): at each random datum EVERY outside link's influence (max over the 48-design
# of the changed link), printed per link with its argmax, and the DS sum at that datum -- the orbit structure does not apply off the symmetric point.
# usage: perl g14_su2_cube.pl beta [MODE=sym|random] [NRAND=8] [NTH=36] [NSPH=120] [SEED=1]
use strict; use warnings;
my ($beta, $MODE, $NRAND, $NTH, $NSPH, $SEED) = @ARGV; $MODE //= 'sym'; $NRAND //= 8; $NTH //= 36; $NSPH //= 120; $SEED //= 1; die "usage: beta [sym|random] [NRAND] [NTH] [NSPH] [SEED]" unless defined $beta;
my $PI = 3.141592653589793;
sub bessel { my ($n, $x) = @_; my $s = 0; my $t = ($x / 2) ** $n; my $f = 1; $f *= $_ for 1 .. $n; $t /= $f; for my $k (0 .. 60) { $s += $t; $t *= ($x / 2) ** 2 / (($k + 1) * ($k + 1 + $n)) } return $s }
my $A1 = bessel(2, $beta) / bessel(1, $beta); my $A2 = bessel(3, $beta) / bessel(1, $beta); die "a_1 >= 1/4: the truncated weight is not positive" if $A1 >= 0.25;
# ---- quaternions and the spin-1/2 matrix; complex numbers as [re, im]
sub qmul { my ($a, $b) = @_; return [ $a->[0]*$b->[0] - $a->[1]*$b->[1] - $a->[2]*$b->[2] - $a->[3]*$b->[3], $a->[0]*$b->[1] + $a->[1]*$b->[0] + $a->[2]*$b->[3] - $a->[3]*$b->[2], $a->[0]*$b->[2] - $a->[1]*$b->[3] + $a->[2]*$b->[0] + $a->[3]*$b->[1], $a->[0]*$b->[3] + $a->[1]*$b->[2] - $a->[2]*$b->[1] + $a->[3]*$b->[0] ] }
sub qinv { my $a = shift; return [ $a->[0], -$a->[1], -$a->[2], -$a->[3] ] }
sub qtr { my ($a, $b) = @_; return 2 * ($a->[0]*$b->[0] - $a->[1]*$b->[1] - $a->[2]*$b->[2] - $a->[3]*$b->[3]) }                # tr(D(a) D(b)) = 2 Re(ab)
sub Dm { my $q = shift; return [ [ [$q->[0], $q->[1]], [$q->[2], $q->[3]] ], [ [-$q->[2], $q->[3]], [$q->[0], -$q->[1]] ] ] }   # [[w+ix, y+iz], [-y+iz, w-ix]]
sub cm { my ($a, $b) = @_; return [ $a->[0]*$b->[0] - $a->[1]*$b->[1], $a->[0]*$b->[1] + $a->[1]*$b->[0] ] }
sub ca { my ($a, $b) = @_; return [ $a->[0] + $b->[0], $a->[1] + $b->[1] ] }
# the 7-design: the binary octahedral group, 48 unit quaternions
my @DES; { my $h = 1 / sqrt(2);
  for my $i (0 .. 3) { for my $s (1, -1) { my @q = (0, 0, 0, 0); $q[$i] = $s; push @DES, [@q] } }
  for my $a (1, -1) { for my $b (1, -1) { for my $c (1, -1) { for my $d (1, -1) { push @DES, [$a / 2, $b / 2, $c / 2, $d / 2] } } } }
  for my $i (0 .. 3) { for my $j ($i + 1 .. 3) { for my $a (1, -1) { for my $b (1, -1) { my @q = (0, 0, 0, 0); $q[$i] = $a * $h; $q[$j] = $b * $h; push @DES, [@q] } } } } }
die "the design has " . scalar(@DES) . " points, not 48" unless @DES == 48;
{ my ($m2, $m4, $m6) = (0, 0, 0); for my $q (@DES) { $m2 += $q->[0] ** 2; $m4 += $q->[0] ** 4; $m6 += $q->[0] ** 6 } $_ /= 48 for ($m2, $m4, $m6);
  die "the design's moments are off: $m2 $m4 $m6" unless abs($m2 - 0.25) < 1e-12 && abs($m4 - 0.125) < 1e-12 && abs($m6 - 5 / 64) < 1e-12;
  my $q1 = [0.5, 0.5, 0.5, 0.5]; my $q2 = [1 / sqrt(2), 0, 1 / sqrt(2), 0]; my $P = Dm(qmul($q1, $q2)); my ($A, $B) = (Dm($q1), Dm($q2));
  for my $i (0, 1) { for my $j (0, 1) { my $s = ca(cm($A->[$i][0], $B->[0][$j]), cm($A->[$i][1], $B->[1][$j])); die "D is not a homomorphism" if abs($s->[0] - $P->[$i][$j][0]) + abs($s->[1] - $P->[$i][$j][1]) > 1e-12 } } }
# ---- the cube: corners c_i = (x, y) in cyclic order, verticals v_i at (c_i, z: 0 -> 1), bottom edges b_i and top edges t_i from corner i to corner i+1
my @C = ([0, 0], [1, 0], [1, 1], [0, 1]);
my %EDGE;                                                                                     # name -> { base => [x,y,z,0], dir => 1..3, sgn => traversal sign in its ring role }
for my $i (0 .. 3) { my $n = ($i + 1) % 4; my ($x0, $y0) = @{$C[$i]}; my ($x1, $y1) = @{$C[$n]};
  my $dir = ($x1 != $x0) ? 1 : 2; my $fwd = ($x1 + $y1 > $x0 + $y0) ? 1 : -1; my $bx = $fwd > 0 ? $x0 : $x1; my $by = $fwd > 0 ? $y0 : $y1;
  $EDGE{"b$i"} = { base => [$bx, $by, 0, 0], dir => $dir, sgn => $fwd }; $EDGE{"t$i"} = { base => [$bx, $by, 1, 0], dir => $dir, sgn => $fwd };
  $EDGE{"v$i"} = { base => [$x0, $y0, 0, 0], dir => 3, sgn => 1 } }
# faces as cycles of (edge, sign): bottom b_0 b_1 b_2 b_3 (signs their fwd), top likewise, side_i = (b_i, +fwd), (v_{i+1}, +), (t_i, -fwd), (v_i, -)
my %FACE = (bottom => [ map { ["b$_", $EDGE{"b$_"}{sgn}] } 0 .. 3 ], top => [ map { ["t$_", $EDGE{"t$_"}{sgn}] } 0 .. 3 ]);
for my $i (0 .. 3) { my $n = ($i + 1) % 4; $FACE{"side$i"} = [ ["b$i", $EDGE{"b$i"}{sgn}], ["v$n", 1], ["t$i", -$EDGE{"t$i"}{sgn}], ["v$i", -1] ] }
# ---- the outside links: key "x,y,z,w:dir" for the lattice link from that base in +dir; the external plaquettes of every cube edge
my %OUT; my @OUTKEYS; sub okey { my ($b, $d) = @_; my $k = join(',', @$b) . ":$d"; unless (exists $OUT{$k}) { $OUT{$k} = scalar @OUTKEYS; push @OUTKEYS, $k } return $OUT{$k} }
sub vadd { my ($p, $d, $s) = @_; my @q = @$p; $q[$d - 1] += $s; return \@q }
my %DANG;                                                                                     # edge -> list of external plaquettes, each [ [idx, sign], [idx, sign], [idx, sign] ] : T_e = prod V_idx^{sign}
for my $e (keys %EDGE) { my ($p, $d) = ($EDGE{$e}{base}, $EDGE{$e}{dir}); my $pd = vadd($p, $d, 1);
  for my $k (1 .. 4) { next if $k == $d; my @sides = ($k == 4) ? (1, -1) : ($p->[$k - 1] == 1 ? (1) : (-1));
    for my $s (@sides) { my ($l1, $l2, $l3);
      $l1 = ($s > 0) ? [okey($pd, $k), 1] : [okey(vadd($pd, $k, -1), $k), -1];                     # p+e_d -> p+e_d+s e_k
      $l2 = [okey(vadd($p, $k, $s), $d), -1];                                                      # p+e_d+s e_k -> p+s e_k : the parallel link backward
      $l3 = ($s > 0) ? [okey($p, $k), -1] : [okey(vadd($p, $k, -1), $k), 1];                       # p+s e_k -> p
      push @{$DANG{$e}}, [$l1, $l2, $l3] } } }
my $NOUT = scalar @OUTKEYS; die "outside links: $NOUT, not 88" unless $NOUT == 88;
for my $e (keys %EDGE) { die "edge $e has " . scalar(@{$DANG{$e}}) . " external plaquettes, not 4" unless @{$DANG{$e}} == 4 }
sub staple { my ($pl, $dat) = @_; my $T = [1, 0, 0, 0]; for my $l (@$pl) { my $V = $dat->[$l->[0]]; $V = qinv($V) if $l->[1] < 0; $T = qmul($T, $V) } return $T }
sub Wfun { my ($e, $dat, $U) = @_; my $w = 1; for my $pl (@{$DANG{$e}}) { $w *= 1 + 2 * $A1 * qtr($U, staple($pl, $dat)) } return $w }
# ---- link tensors.  Each edge has two face slots; slot = (face, position in the cycle, sign).  L[act1][act2]{a,b,c,d} = (1/48) sum_U D^{s1}(U)_{ab} D^{s2}(U)_{cd} W_y(U)
my %SLOT; for my $f (keys %FACE) { my $cyc = $FACE{$f}; for my $m (0 .. 3) { my ($e, $sg) = @{$cyc->[$m]}; push @{$SLOT{$e}}, [$f, $m, $sg] } }
for my $e (keys %EDGE) { die "edge $e has " . scalar(@{$SLOT{$e}}) . " face slots" unless @{$SLOT{$e}} == 2 }
sub Dsg { my ($U, $sg) = @_; return Dm($sg > 0 ? $U : qinv($U)) }
sub linktensor {                                                                              # returns $L->[act1][act2][a][b][c][d] (complex); inactive slot: indices 0,0 only
  my ($e, $dat) = @_; my @S = @{$SLOT{$e}}; my $L;
  for my $U (@DES) { my $w = Wfun($e, $dat, $U) / 48; my ($D1, $D2) = (Dsg($U, $S[0][2]), Dsg($U, $S[1][2]));
    for my $a1 (0, 1) { for my $a2 (0, 1) { my ($n1, $n2) = ($a1 ? 2 : 1, $a2 ? 2 : 1);
      for my $a (0 .. $n1 - 1) { for my $b (0 .. $n1 - 1) { my $f1 = $a1 ? $D1->[$a][$b] : [1, 0];
        for my $c (0 .. $n2 - 1) { for my $d (0 .. $n2 - 1) { my $f2 = $a2 ? $D2->[$c][$d] : [1, 0]; my $v = cm($f1, $f2);
          $L->[$a1][$a2][$a][$b][$c][$d] = ca($L->[$a1][$a2][$a][$b][$c][$d] // [0, 0], [$v->[0] * $w, $v->[1] * $w]) } } } } } } }
  return $L }
# ---- the ring contraction.  Cut state before column i: (top bond, bottom bond, side_i activity+bonds (t_i->v_i, v_i->b_i)); encoded 0..44
sub enc { my ($t, $b, $s, $p, $q) = @_; return ($t * 3 + $b) * 5 + ($s ? 1 + 2 * $p + $q : 0) }   # t,b in 0..2 (0 inactive, 1-2 index+1); s activity; p,q bonds
sub dec { my $z = shift; my $s5 = $z % 5; my $tb = int($z / 5); return (int($tb / 3), $tb % 3, $s5 ? 1 : 0, $s5 ? int(($s5 - 1) / 2) : 0, $s5 ? ($s5 - 1) % 2 : 0) }
sub slotof { my ($e, $f) = @_; for my $s (@{$SLOT{$e}}) { return $s if $s->[0] eq $f } die "no slot $f on $e" }
sub tensorget { my ($L, $e, $fA, $actA, $iA, $oA, $fB, $actB, $iB, $oB) = @_;                        # entry of L_e with face fA's (in,out) and fB's (in,out), ordered by the edge's slot order
  my @S = @{$SLOT{$e}}; my ($a1, $a2, @ix);
  if ($S[0][0] eq $fA) { ($a1, $a2) = ($actA, $actB); @ix = ($iA, $oA, $iB, $oB) } else { ($a1, $a2) = ($actB, $actA); @ix = ($iB, $oB, $iA, $oA) }
  return $L->[$a1][$a2][$ix[0]][$ix[1]][$ix[2]][$ix[3]] // [0, 0] }
# column i holds t_i, b_i, v_{i+1}; the open edge is t_0 (column 0): its tensor is replaced by external labels (top in/out, side_0 in/out)
sub column {
  my ($i, $LT, $open) = @_; my $n = ($i + 1) % 4; my ($t, $b, $v) = ("t$i", "b$i", "v$n"); my $sf = "side$i"; my $sn = "side$n"; my %M;   # $M{in}{out} -> complex (or -> {open}{...})
  for my $zin (0 .. 44) { my ($Tin, $Bin, $Sin, $tv, $vb) = dec($zin);                                      # tv = bond t_i->v_i, vb = bond v_i->b_i (side_i, inherited)
    for my $zout (0 .. 44) { my ($Tout, $Bout, $Sout, $tvn, $vbn) = dec($zout);                              # tvn = bond t_{i+1}->v_{i+1}, vbn = v_{i+1}->b_{i+1} (side_{i+1})
      next if (($Tin == 0) != ($Tout == 0)) || (($Bin == 0) != ($Bout == 0));                               # top/bottom activity constant around the ring
      my $acc = [0, 0]; my $accopen;
      for my $bv (0 .. ($Sin ? 1 : 0)) { for my $vt (0 .. ($Sin ? 1 : 0)) {                                   # side_i's internal bonds b_i->v_{i+1}, v_{i+1}->t_i
        my $fb = tensorget($LT->{$b}, $b, 'bottom', $Bin ? 1 : 0, $Bin ? $Bin - 1 : 0, $Bout ? $Bout - 1 : 0, $sf, $Sin, $vb, $bv);
        my $fv = tensorget($LT->{$v}, $v, $sf, $Sin, $bv, $vt, $sn, $Sout, $tvn, $vbn);
        my $w = cm($fb, $fv); my $fac = 1; $fac *= 2 * $A1 if $Sin; $fac *= 2 * $A1 if $i == 0 && $Tin; $fac *= 2 * $A1 if $i == 0 && $Bin;
        $w = [$w->[0] * $fac, $w->[1] * $fac];
        if ($open) { my $key = join(',', $Tin, $Tout, $Sin, $vt, $tv); $accopen->{$key} = ca($accopen->{$key} // [0, 0], $w) }                  # t_0's labels: top in,out; side_0 in = vt (v_1->t_0), out = tv (t_0->v_0)
        else { my $ft = tensorget($LT->{$t}, $t, 'top', $Tin ? 1 : 0, $Tin ? $Tin - 1 : 0, $Tout ? $Tout - 1 : 0, $sf, $Sin, $vt, $tv); $acc = ca($acc, cm($w, $ft)) } } }
      if ($open) { $M{$zin}{$zout} = $accopen } else { $M{$zin}{$zout} = $acc if $acc->[0] != 0 || $acc->[1] != 0 } } }
  return \%M }
sub matmul45 { my ($A, $B) = @_; my %C; for my $i (keys %$A) { for my $k (keys %{$A->{$i}}) { my $a = $A->{$i}{$k}; next unless $B->{$k}; for my $j (keys %{$B->{$k}}) { $C{$i}{$j} = ca($C{$i}{$j} // [0, 0], cm($a, $B->{$k}{$j})) } } } return \%C }
sub openC {                                                                                   # C{"Tin,Tout,Sact,vt,tv"} = sum_{zin,zout} M0open{zin}{zout}{key} * P{zout}{zin}
  my $dat = shift; my %LT; $LT{$_} = linktensor($_, $dat) for keys %EDGE;
  my $M1 = column(1, \%LT); my $M2 = column(2, \%LT); my $M3 = column(3, \%LT); my $P = matmul45(matmul45($M1, $M2), $M3); my $M0 = column(0, \%LT, 1); my %Cc;
  for my $zin (keys %$M0) { for my $zout (keys %{$M0->{$zin}}) { my $p = $P->{$zout}{$zin} or next; my $h = $M0->{$zin}{$zout} or next; for my $key (keys %$h) { $Cc{$key} = ca($Cc{$key} // [0, 0], cm($h->{$key}, $p)) } } }
  return \%Cc }
sub Nfun {                                                                                    # N_d(U) for the open edge t_0 from the contracted tensor
  my ($Cc, $dat, $U) = @_; my ($st, $ss) = (slotof('t0', 'top'), slotof('t0', 'side0')); my ($DT, $DS) = (Dsg($U, $st->[2]), Dsg($U, $ss->[2])); my $w = Wfun('t0', $dat, $U); my $acc = [0, 0];
  for my $key (keys %$Cc) { my ($Tin, $Tout, $S, $vt, $tv) = split /,/, $key; my $f = $Tin ? $DT->[$Tin - 1][$Tout - 1] : [1, 0]; my $g = $S ? $DS->[$vt][$tv] : [1, 0]; $acc = ca($acc, cm($Cc->{$key}, cm($f, $g))) }
  return $acc->[0] * $w }
# ---- the quadrature on S^3 for the total variation: theta midpoints with (2/pi) sin^2, the axis on a Fibonacci sphere
my @QP; { for my $it (0 .. $NTH - 1) { my $th = $PI * ($it + 0.5) / $NTH; my $wt = (2 / $PI) * sin($th) ** 2 * ($PI / $NTH) / $NSPH;
  for my $k (0 .. $NSPH - 1) { my $z = 1 - 2 * ($k + 0.5) / $NSPH; my $r = sqrt(1 - $z * $z); my $ph = $k * $PI * (3 - sqrt(5)); push @QP, [[cos($th), sin($th) * $r * cos($ph), sin($th) * $r * sin($ph), sin($th) * $z], $wt] } } }
sub marginal { my $dat = shift; my $Cc = openC($dat); my $Z = 0; $Z += Nfun($Cc, $dat, $_) / 48 for @DES; die "Z not positive: $Z" unless $Z > 0; return [ map { Nfun($Cc, $dat, $_->[0]) / $Z } @QP ] }
sub tv { my ($m1, $m2) = @_; my $s = 0; $s += $QP[$_][1] * abs($m1->[$_] - $m2->[$_]) for 0 .. $#QP; return $s / 2 }
# ---- the stabiliser of t_0 (base (0,0,1,0), direction 1): x1 -> 1-x1; (x2,x3) -> (1-x3, 1-x2); x4 -> -x4; and their products: the orbits of outside links
sub mapkey { my ($k, $m) = @_; my ($b, $d) = split /:/, $k; my @p = split /,/, $b; my @q = @p; $q[$d - 1] += 1; my @ends = (\@p, \@q);
  my @im = map { my @r = @$_; @r = (1 - $r[0], $r[1], $r[2], $r[3]) if $m & 1; @r = ($r[0], 1 - $r[2], 1 - $r[1], $r[3]) if $m & 2; @r = ($r[0], $r[1], $r[2], -$r[3]) if $m & 4; \@r } @ends;
  my ($dd) = grep { $im[0][$_] != $im[1][$_] } 0 .. 3; my $lo = ($im[0][$dd] < $im[1][$dd]) ? $im[0] : $im[1]; return join(',', @$lo) . ':' . ($dd + 1) }
my (%ORB, @REPS); for my $j (0 .. $NOUT - 1) { next if exists $ORB{$j}; my @o; for my $m (0 .. 7) { my $k = mapkey($OUTKEYS[$j], $m); die "map lost $k" unless exists $OUT{$k}; push @o, $OUT{$k} } my %u = map { $_ => 1 } @o; my @mem = sort { $a <=> $b } keys %u; $ORB{$_} = $j for @mem; push @REPS, [$j, scalar @mem] }
printf "G14-CUBE beta=%.4f a_1=%.6f a_2=%.6f (the dropped spin-1 weight 3a_2 against 2a_1: %.3f) outside-links=%d orbits-under-stab(t0)=%d quadrature=%d points\n", $beta, $A1, $A2, 3 * $A2 / (2 * $A1), $NOUT, scalar @REPS, scalar @QP;
# ---- anchors
{ my @d0 = map { [1, 0, 0, 0] } 1 .. $NOUT; my $m0 = marginal(\@d0); printf "G14-ANCHOR tv(d,d)=%.3e (must be 0)\n", tv($m0, $m0);
  my ($jx) = ($DANG{t0}[0][0][0]); my @d1 = map { [@$_] } @d0; $d1[$jx] = [-1, 0, 0, 0]; my $m1 = marginal(\@d1); my $t = tv($m0, $m1);
  printf "G14-ANCHOR direct sign flip of a staple link of t0 at symmetric data: tv=%.6f against the single-link law (4/3pi)beta=%.6f (ratio %.4f; equal only as beta -> 0)\n", $t, 4 / (3 * $PI) * $beta, $t / (4 / (3 * $PI) * $beta);
}
# ---- the reading at the symmetric data: for every orbit representative j, the max over g in 2O of tv(mu | d0, mu | d0 with V_j = g)
my @d0 = map { [1, 0, 0, 0] } 1 .. $NOUT; my $m0 = marginal(\@d0); my $sum = 0; my @rows;
for my $r (@REPS) { my ($j, $size) = @$r; my ($best, $bg, $second, $sg) = (0, 0, 0, 0); for my $gi (1 .. 47) { my @d = map { [@$_] } @d0; $d[$j] = $DES[$gi]; my $t = tv($m0, marginal(\@d)); if ($t > $best) { ($second, $sg) = ($best, $bg); ($best, $bg) = ($t, $gi) } elsif ($t > $second) { ($second, $sg) = ($t, $gi) } }
  $sum += $size * $best; my $g = $DES[$bg]; my $g2 = $DES[$sg]; push @rows, sprintf("j=%s size=%d rho=%.6f argmax-g=(%.3f,%.3f,%.3f,%.3f) second-best=%.6f at g=(%.3f,%.3f,%.3f,%.3f) gap=%.2e", $OUTKEYS[$j], $size, $best, @$g, $second, @$g2, $best - $second);
  printf "G14-ORBIT %s\n", $rows[-1] }
printf "G14-SYM beta=%.4f DS-sum/|V| = sum_j rho_xj = %.6f (criterion holds iff < 1) [%s]  (12 x this is the cube's double sum against |V| = 12)\n", $beta, $sum, ($sum < 1) ? 'DS-HOLDS' : 'DS-FAILS';
if ($MODE eq 'random') { srand($SEED); my ($bestsum, $bestdesc) = ($sum, 'symmetric');                       # random data: does any beat the symmetric one on the worst orbit?
  my ($jw) = map { $_->[0] } sort { $b->[1] <=> $a->[1] } map { my ($j) = @$_; my $rr = (grep { $_ =~ /^j=\Q$OUTKEYS[$j]\E / } @rows)[0]; $rr =~ /rho=([0-9.]+)/; [$j, $1] } @REPS;
  for my $trial (1 .. $NRAND) { my @d = map { $DES[int(rand(48))] } 1 .. $NOUT; my $mr = marginal(\@d); my ($best, $bg) = (0, 0);
    for my $gi (0 .. 47) { my @dd = map { [@$_] } @d; $dd[$jw] = qmul($DES[$gi], $d[$jw]); next if $gi == 0; my $t = tv($mr, marginal(\@dd)); if ($t > $best) { ($best, $bg) = ($t, $gi) } }
    printf "G14-RANDOM trial=%d worst-orbit j=%s rho=%.6f (symmetric data gave the orbit's %s) argmax-g=(%.3f,%.3f,%.3f,%.3f)\n", $trial, $OUTKEYS[$jw], $best, (grep { $_ =~ /^j=\Q$OUTKEYS[$jw]\E / } @rows)[0] =~ /rho=([0-9.]+)/ ? $1 : '?', @{$DES[$bg]} } }
if ($MODE eq "randomall") { srand($SEED); for my $trial (1 .. $NRAND) { my @d = map { $DES[int(rand(48))] } 1 .. $NOUT; my $mr = marginal(\@d); my $tot = 0;
    for my $j (0 .. $NOUT - 1) { my ($best, $bg) = (0, 0); for my $gi (1 .. 47) { my @dd = map { [@$_] } @d; $dd[$j] = qmul($DES[$gi], $d[$j]); my $t = tv($mr, marginal(\@dd)); if ($t > $best) { ($best, $bg) = ($t, $gi) } }
      $tot += $best; printf "G14-RANDOM-LINK trial=%d j=%s rho=%.6f argmax-g=(%.3f,%.3f,%.3f,%.3f)
", $trial, $OUTKEYS[$j], $best, @{$DES[$bg]} }
    printf "G14-RANDOM-SUM trial=%d DS-sum/|V| at this datum = %.6f [%s]
", $trial, $tot, $tot < 1 ? "DS-HOLDS" : "DS-FAILS" } }
