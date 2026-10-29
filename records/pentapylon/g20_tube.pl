#!/usr/bin/perl
# g20_tube.pl -- THE FIRST EXACT NON-ABELIAN OBJECT OF THE CROSSOVER'S SHAPE: SU(2) LATTICE GAUGE THEORY IN 2+1 DIMENSIONS ON A 2x2 SPATIAL
# TORUS, ITS TRANSFER MATRIX IN THE SPIN-NETWORK BASIS, THE GAP AND THE BLOCK COVARIANCE FUNCTIONAL K ALONG THE TUBE (ΠΕΝΤΑΠΥΛΟΝ G20,
# 2026-10-29 00:4x EDT, the desktop seat; the plan seat's order of 00:3x: "START your perl j <= 1 spin-network road now").
#
# THE OBJECT.  Wilson action e^{(beta/2) sum_p tr U_p} on Z^2 x Z (2+1), the spatial lattice a 2x2 periodic torus: sites (x,y) in {0,1}^2,
# links Lx(x,y): (x,y)->(x+1,y) and Ly(x,y): (x,y)->(x,y+1), eight in all; plaquettes p(x,y) = Lx(x,y) Ly(x+1,y) Lx(x,y+1)^-1 Ly(x,y)^-1, four,
# each through all four sites (every site has four legs: out-x, in-x, out-y, in-y).  In temporal gauge the transfer matrix on L^2(SU(2)^8) is
#   T = P^{1/2} D P^{1/2},   D = (x)_links (convolution by e^{(beta/2) tr(U U'^dagger)}),   P^{1/2} = prod_p (multiplication by e^{(beta/4) tr U_p}),
# symmetric and positive; its physical spectrum is on the gauge-invariant subspace.  THE SPIN-NETWORK BASIS of that subspace: spins j_e on the
# links, an orthonormal intertwiner iota_v in Inv(V_{j_out-x} (x) V*_{j_in-x} (x) V_{j_out-y} (x) V*_{j_in-y}) at each site, the state
# Psi = prod_e sqrt(d_j) D^{j_e}(U_e)_{m n} contracted at the vertices (the row index at the source, the column at the target); orthonormal by
# Peter-Weyl.  D is DIAGONAL there: eigenvalue prod_e c_{j_e}, c_j = I_{2j+1}(beta)/I_1(beta) (the MK flow's c_n at n = 2j).  P^{1/2}'s factor
# e^{(beta/4) tr U_p} = sum_J d_J c''_J chi_J(U_p), c''_J = I_{2J+1}(beta/2)/I_1(beta/2) (the same coefficients at half the coupling), and
# chi_J(U_p) acts by fusing a spin-J loop into the four links of p: D^j D^J = sum_{j'} C C D^{j'} (the Clebsch-Gordan series), the two CG
# factors attaching to the vertex tensors at the edge's two ends, the loop's own index summed at each vertex; the new vertex tensor is
# re-expanded in the orthonormal invariant basis at the new spins.  EVERYTHING IS COMPUTED BY EXPLICIT INDEX CONTRACTION -- the invariant
# bases as null spaces of the total angular-momentum generators (-J^T on an incoming leg), the CG coefficients by Racah's formula -- so no 6j
# table and no sign convention enters by hand; the signs of the inverted edges' conjugate factors conj(D_{ab}) = (-1)^{a-b} D_{-a,-b} are
# carried as (-1)^{a_1 - J} at p's base corner and (-1)^{J - a_3} at the opposite corner.  THE TRUNCATION: link spins j <= JMAX (every J <= 2 JMAX
# of the plaquette expansion kept), the Galerkin form T_tr = Q^T D Q with Q = Pi P_1^{1/2} Pi ... Pi P_4^{1/2} Pi; its error read against the
# electric weight of the first dropped spin, c_{JMAX+1/2}, and against JMAX + 1/2 where it runs.
# THE READINGS.  lambda_0 > lambda_1 by Lanczos (the full gap -ln(lambda_1/lambda_0), which in a 2-wide tube may be a centre-flux torelon);
# and THE BLOCK COVARIANCE FUNCTIONAL along the tube: with O = (1/4) sum_p (1/2) tr U_p the plaquette average, K(d) = <psi_0| O T^d O |psi_0> /
# lambda_0^d - <O>^2, the connected plaquette-plaquette correlator d slices apart, m_eff(d) = -ln(K(d+1)/K(d)) -> the 0++ rate in the tube.
# KNOWN ANSWERS (the sign conventions have no other check): every W_J(p) symmetric; ||W_{1/2}(p)|0>||^2 = 1 and <0|W_1(p)|0> = 0, ||W_1|0>|| = 1
# (int chi^2 = 1, int chi_1 = 0); <0|W_{1/2}(p) W_{1/2}(p')|0> = 0 for p != p'; at beta -> 0 the gap is the single-plaquette excitation
# -4 ln c_{1/2} + O(beta^2) (staked: at beta = 0.2, m within 5 % of 12.0).  STAKED BLIND: at beta_3 = 2 the 0++ rate in the 2x2 tube lies in
# [1.5, 3.5]; K(d) falls monotonically; the full gap lies below the 0++ rate for beta_3 >= 2 (a flux state is cheap in a 2-wide tube).
# usage: perl g20_tube.pl beta [JMAX=1] [LANCZOS=60] [DMAX=8] [kat]
use strict; use warnings; $| = 1;
my ($beta, $JMAX, $NLAN, $DMAX, $KAT) = @ARGV; die "usage: beta [JMAX] [LANCZOS] [DMAX] [kat]" unless defined $beta; $JMAX //= 1; $NLAN //= 60; $DMAX //= 8; $KAT //= '';
my $J2MAX = 2 * $JMAX;                                                                           # spins as twice-integers: j2 = 0 .. J2MAX
sub bessel { my ($n, $x) = @_; my $s = 0; my $t = ($x / 2) ** $n; my $f = 1; $f *= $_ for 1 .. $n; $t /= $f; for my $k (0 .. 80) { $s += $t; $t *= ($x / 2) ** 2 / (($k + 1) * ($k + 1 + $n)) } return $s }
my @FACT = (1); $FACT[$_] = $FACT[$_ - 1] * $_ for 1 .. 40;
sub fac { my $n = shift; die "negative factorial" if $n < 0; return $FACT[$n] }
# ---- Clebsch-Gordan <j1 m1 j2 m2 | J M> by Racah, all arguments as twice-integers
my %CGC;
sub cg { my ($j1, $m1, $j2, $m2, $J, $M) = @_; return 0 unless $m1 + $m2 == $M; return 0 if $J < abs($j1 - $j2) || $J > $j1 + $j2 || (($j1 + $j2 + $J) % 2); return 0 if abs($M) > $J || abs($m1) > $j1 || abs($m2) > $j2;
  my $key = "$j1,$m1,$j2,$m2,$J"; return $CGC{$key} if exists $CGC{$key};
  my ($a, $b, $c, $d, $e, $f) = (($J + $j1 - $j2) / 2, ($J - $j1 + $j2) / 2, ($j1 + $j2 - $J) / 2, ($j1 + $j2 + $J) / 2 + 1, ($J + $M) / 2, ($J - $M) / 2);
  my $pre = sqrt(($J + 1) * fac($a) * fac($b) * fac($c) / fac($d)) * sqrt(fac($e) * fac($f) * fac(($j1 - $m1) / 2) * fac(($j1 + $m1) / 2) * fac(($j2 - $m2) / 2) * fac(($j2 + $m2) / 2));
  my $s = 0; for my $k (0 .. 20) { my @t = ($k, $c - $k, ($j1 - $m1) / 2 - $k, ($j2 + $m2) / 2 - $k, ($J - $j2 + $m1) / 2 + $k, ($J - $j1 - $m2) / 2 + $k); next if grep { $_ < 0 } @t; my $den = 1; $den *= fac($_) for @t; $s += (-1) ** $k / $den }
  return $CGC{$key} = $pre * $s }
# ---- the invariant subspace at a vertex with leg spins (out-x, in-x, out-y, in-y): the real null space of the total generators, orthonormal
my %INV;
sub invbasis { my @j = @_; my $key = join(',', @j); return $INV{$key} if exists $INV{$key}; my @d = map { $_ + 1 } @j; my $dim = $d[0] * $d[1] * $d[2] * $d[3];
  my @rows;                                                                                      # rows of the stacked generator matrix [Jz; J+; J-] on the product space
  for my $gen (0 .. 2) { for my $I (0 .. $dim - 1) { my @row = (0) x $dim; my @i = (int($I / ($d[1] * $d[2] * $d[3])), int($I / ($d[2] * $d[3])) % $d[1], int($I / $d[3]) % $d[2], $I % $d[3]);
      for my $leg (0 .. 3) { my $sign = ($leg == 1 || $leg == 3) ? -1 : 1; my $jj = $j[$leg]; my $m2 = 2 * $i[$leg] - $jj;                 # m as twice-integer; incoming legs carry -J^T
        if ($gen == 0) { $row[$I] += $sign * $m2 / 2 } else { my $up = ($gen == 1) ? 1 : -1; my $dirn = $sign > 0 ? $up : -$up;              # J+ on an out leg raises; -J^T: -(J+)^T = -J-, so an in leg with gen J+ lowers (sign -1)
          my $mt = $m2 + 2 * $dirn; next if abs($mt) > $jj; my $amp = sqrt(($jj * ($jj + 2) - $m2 * ($m2 + 2 * $dirn)) / 4); my @k = @i; $k[$leg] = ($mt + $jj) / 2;
          my $K = (($k[0] * $d[1] + $k[1]) * $d[2] + $k[2]) * $d[3] + $k[3]; $row[$K] += $sign * $amp } }
      push @rows, \@row } }
  # null space by row reduction
  my $n = $dim; my @A = map { [@$_] } @rows; my @piv; my $r = 0;
  for my $col (0 .. $n - 1) { my ($best, $bi) = (1e-9, -1); for my $i ($r .. $#A) { if (abs($A[$i][$col]) > $best) { $best = abs($A[$i][$col]); $bi = $i } } next if $bi < 0;
    @A[$r, $bi] = @A[$bi, $r]; my $pv = $A[$r][$col]; $_ /= $pv for @{$A[$r]}; for my $i (0 .. $#A) { next if $i == $r; my $f = $A[$i][$col]; next if $f == 0; $A[$i][$_] -= $f * $A[$r][$_] for 0 .. $n - 1 } push @piv, $col; $r++; last if $r == $n }
  my %ispiv = map { $_ => 1 } @piv; my @basis;
  for my $free (grep { !$ispiv{$_} } 0 .. $n - 1) { my @v = (0) x $n; $v[$free] = 1; for my $k (0 .. $#piv) { $v[$piv[$k]] = -$A[$k][$free] } push @basis, \@v }
  my @ob; for my $v (@basis) { my @w = @$v; for my $u (@ob) { my $dot = 0; $dot += $w[$_] * $u->[$_] for 0 .. $n - 1; $w[$_] -= $dot * $u->[$_] for 0 .. $n - 1 } my $nn = 0; $nn += $_ * $_ for @w; next if $nn < 1e-12; $nn = sqrt($nn); push @ob, [ map { $_ / $nn } @w ] }
  return $INV{$key} = \@ob }
# ---- the lattice: links 0..3 = Lx(x,y) for (x,y) = (0,0),(1,0),(0,1),(1,1); links 4..7 = Ly(x,y) likewise.  site s = x + 2y.
sub lx { my ($x, $y) = @_; return ($x % 2) + 2 * ($y % 2) } sub ly { my ($x, $y) = @_; return 4 + ($x % 2) + 2 * ($y % 2) }
my @LEG;                                                                                         # LEG[site][leg 0..3] = link index: out-x, in-x, out-y, in-y
for my $y (0, 1) { for my $x (0, 1) { $LEG[$x + 2 * $y] = [ lx($x, $y), lx($x - 1, $y), ly($x, $y), ly($x, $y - 1) ] } }
my @PLAQ;                                                                                        # plaquette p(x,y): [e1 forward, e2 forward, e3 backward, e4 backward] and its four corners with the loop-leg data
for my $y (0, 1) { for my $x (0, 1) { my ($e1, $e2, $e3, $e4) = (lx($x, $y), ly($x + 1, $y), lx($x, $y + 1), ly($x, $y)); my @s = ($x + 2 * $y, (($x + 1) % 2) + 2 * $y, (($x + 1) % 2) + 2 * (($y + 1) % 2), $x + 2 * (($y + 1) % 2));
  # at each corner: the two loop legs as [leg slot, loop-index sign], and the corner's sign rule: 0 none, 1 = (-1)^{a - J}, 2 = (-1)^{J - a}
  my %c = ( $s[0] => { legs => [[0, +1], [2, -1]], srule => 1 },                                  # (x,y): e1 out-x with a1; e4 out-y with -a1
            $s[1] => { legs => [[1, +1], [2, +1]], srule => 0 },                                  # (x+1,y): e1 in-x with a2; e2 out-y with a2
            $s[2] => { legs => [[3, +1], [1, -1]], srule => 2 },                                  # (x+1,y+1): e2 in-y with a3; e3 in-x with -a3  (the in-y sign +1: corrected 00:5x, the KAT ||W|0>|| read 0 with -1)
            $s[3] => { legs => [[0, -1], [3, -1]], srule => 0 } );                                # (x,y+1): e3 out-x with -a4; e4 in-y with -a4
  push @PLAQ, { edges => [$e1, $e2, $e3, $e4], corners => \%c } } }
# ---- the vertex loop factor: F(jin, alpha, jout, alpha'; legs, J, srule) by explicit contraction, cached
my %VF;
sub vfactor { my ($jin, $jout, $legs, $J2, $srule) = @_;                                        # returns a matrix [alpha][alpha'] of overlaps
  my $key = join('|', @$jin, @$jout, map({ "$_->[0]:$_->[1]" } @$legs), $J2, $srule); return $VF{$key} if exists $VF{$key};
  my $Bin = invbasis(@$jin); my $Bout = invbasis(@$jout); my @din = map { $_ + 1 } @$jin; my @dout = map { $_ + 1 } @$jout;
  my ($l1, $s1) = @{$legs->[0]}; my ($l2, $s2) = @{$legs->[1]}; my @M;
  for my $a (0 .. $#$Bin) { for my $b (0 .. $#$Bout) { my $sum = 0;
    for my $I (0 .. $din[0] * $din[1] * $din[2] * $din[3] - 1) { my $v = $Bin->[$a][$I]; next if $v == 0; my @i = (int($I / ($din[1] * $din[2] * $din[3])), int($I / ($din[2] * $din[3])) % $din[1], int($I / $din[3]) % $din[2], $I % $din[3]);
      for (my $a2 = -$J2; $a2 <= $J2; $a2 += 2) { my $sg = 1; if ($srule == 1) { $sg = ((($a2 - $J2) / 2) % 2) ? -1 : 1 } elsif ($srule == 2) { $sg = ((($J2 - $a2) / 2) % 2) ? -1 : 1 }
        my $m1 = 2 * $i[$l1] - $jin->[$l1]; my $m1n = $m1 + $s1 * $a2; next if abs($m1n) > $jout->[$l1]; my $c1 = cg($jin->[$l1], $m1, $J2, $s1 * $a2, $jout->[$l1], $m1n); next if $c1 == 0;
        my $m2 = 2 * $i[$l2] - $jin->[$l2]; my $m2n = $m2 + $s2 * $a2; next if abs($m2n) > $jout->[$l2]; my $c2 = cg($jin->[$l2], $m2, $J2, $s2 * $a2, $jout->[$l2], $m2n); next if $c2 == 0;
        my @k = @i; $k[$l1] = ($m1n + $jout->[$l1]) / 2; $k[$l2] = ($m2n + $jout->[$l2]) / 2; my $K = (($k[0] * $dout[1] + $k[1]) * $dout[2] + $k[2]) * $dout[3] + $k[3];
        $sum += $v * $sg * $c1 * $c2 * $Bout->[$b][$K] } }
    $M[$a][$b] = $sum } }
  return $VF{$key} = \@M }
# ---- the state space: spins on 8 links (twice-integers), intertwiner choices at 4 sites
my (@ST, %ID);                                                                                   # ST[i] = [ [j2 x 8], [alpha x 4] ]; ID{"j|alpha"} = i
{ my @j = (0) x 8; my $count = 0;
  my $rec; $rec = sub { my $e = shift; if ($e == 8) { my @dims = map { scalar @{ invbasis(map { $j[$_] } @{$LEG[$_]}) } } 0 .. 3; return if grep { $_ == 0 } @dims;
      my @al = (0) x 4; my $r2; $r2 = sub { my $v = shift; if ($v == 4) { my $id = join(',', @j) . '|' . join(',', @al); $ID{$id} = scalar @ST; push @ST, [[@j], [@al]]; return } for my $a (0 .. $dims[$v] - 1) { $al[$v] = $a; $r2->($v + 1) } }; $r2->(0); return }
    for (my $s = 0; $s <= $J2MAX; $s++) { $j[$e] = $s; $rec->($e + 1) } }; $rec->(0) }
my $NS = scalar @ST; printf "G20-SPACE beta=%g JMAX=%g: %d gauge-invariant spin-network states on the 2x2 torus (spins 0..%g on 8 links), %d distinct vertex invariant spaces\n", $beta, $JMAX, $NS, $JMAX, scalar keys %INV;
# ---- the plaquette operators W_J(p) as sparse matrices (hash of row -> { col => val }), J2 = 1 .. 2 J2MAX
sub wmat { my ($p, $J2) = @_; my $P = $PLAQ[$p]; my @E = @{$P->{edges}}; my %W;
  for my $i (0 .. $NS - 1) { my ($j, $al) = @{$ST[$i]}; my @cand;                                # new spins on the four edges of p
    for my $e (@E) { my @c; for (my $s = abs($j->[$e] - $J2); $s <= $j->[$e] + $J2 && $s <= $J2MAX; $s += 2) { push @c, $s } push @cand, \@c }
    for my $n1 (@{$cand[0]}) { for my $n2 (@{$cand[1]}) { for my $n3 (@{$cand[2]}) { for my $n4 (@{$cand[3]}) { my @jn = @$j; @jn[@E] = ($n1, $n2, $n3, $n4);
      my $pref = 1; $pref *= sqrt(($j->[$_] + 1) / ($jn[$_] + 1)) for @E;                       # prod sqrt(d_j / d_j') over the plaquette's edges
      my @F; my $dead = 0; for my $s (0 .. 3) { my $cn = $P->{corners}{$s}; my @jin = map { $j->[$_] } @{$LEG[$s]}; my @jout = map { $jn[$_] } @{$LEG[$s]}; my $B = invbasis(@jout); if (!@$B) { $dead = 1; last }
        $F[$s] = vfactor(\@jin, \@jout, $cn->{legs}, $J2, $cn->{srule}) } next if $dead;
      my @dims = map { scalar @{ invbasis(map { $jn[$_] } @{$LEG[$_]}) } } 0 .. 3; my @b = (0) x 4; my $r; $r = sub { my $v = shift; if ($v == 4) { my $val = $pref; $val *= $F[$_][$al->[$_]][$b[$_]] for 0 .. 3; return if abs($val) < 1e-14;
          my $id = join(',', @jn) . '|' . join(',', @b); my $k = $ID{$id}; die "state $id missing" unless defined $k; $W{$i}{$k} += $val; return } for my $a (0 .. $dims[$v] - 1) { $b[$v] = $a; $r->($v + 1) } }; $r->(0) } } } } }
  return \%W }
my $J2TOP = 2 * $J2MAX; my (@WH, @Q, @O);                                                       # WH[p][J2] = W_J(p); Q[p] = sum_J d_J c''_J W_J(p) (+ identity); O = the plaquette average
my $t0 = time; my @cpp = map { bessel($_ + 1, $beta / 2) / bessel(1, $beta / 2) } 0 .. $J2TOP;  # c''_n at n = 2J, coupling beta/2
my @cel = map { bessel($_ + 1, $beta) / bessel(1, $beta) } 0 .. $J2MAX;                          # the electric factors c_n(beta)
for my $p (0 .. 3) { my %Qp; for my $i (0 .. $NS - 1) { $Qp{$i}{$i} = 1 }
  for (my $J2 = 1; $J2 <= $J2TOP; $J2++) { my $W = wmat($p, $J2); $WH[$p][$J2] = $W; my $coef = ($J2 + 1) * $cpp[$J2]; for my $i (keys %$W) { for my $k (keys %{$W->{$i}}) { $Qp{$i}{$k} += $coef * $W->{$i}{$k} } } }
  $Q[$p] = \%Qp; my $nnz = 0; $nnz += scalar keys %{$Qp{$_}} for keys %Qp; printf "G20-BUILD plaquette %d: Q_p = sum_{J<=%g} d_J c''_J W_J(p) with %d nonzeros (%d s)\n", $p, $J2TOP / 2, $nnz, time - $t0 }
# ---- known answers on the operators
{ my $asym = 0; my $pairs = 0; for my $p (0 .. 3) { for (my $J2 = 1; $J2 <= $J2TOP; $J2++) { my $W = $WH[$p][$J2]; for my $i (keys %$W) { for my $k (keys %{$W->{$i}}) { my $w = $W->{$i}{$k}; my $wt = $W->{$k}{$i} // 0; my $dd = abs($w - $wt); $asym = $dd if $dd > $asym; $pairs++ } } } }
  printf "G20-KAT symmetry of every W_J(p): max |W_ik - W_ki| = %.2e over %d entries  [%s]\n", $asym, $pairs, $asym < 1e-9 ? 'SYMMETRIC' : 'NOT SYMMETRIC';
  my $zero = $ID{ join(',', (0) x 8) . '|' . join(',', (0) x 4) }; my ($ok1, $ok2, $ok3) = (1, 1, 1);
  for my $p (0 .. 3) { my $W = $WH[$p][1]; my $nn = 0; $nn += $_ ** 2 for values %{$W->{$zero}}; printf "G20-KAT ||W_{1/2}(p=%d)|0>||^2 = %.12f (must be 1)\n", $p, $nn; $ok1 = 0 if abs($nn - 1) > 1e-9;
    my $W1 = $WH[$p][2]; my $d0 = $W1->{$zero}{$zero} // 0; my $n1 = 0; $n1 += $_ ** 2 for values %{$W1->{$zero}}; printf "G20-KAT <0|W_1(p=%d)|0> = %.2e (must be 0), ||W_1|0>||^2 = %.12f (must be 1)\n", $p, $d0, $n1; $ok2 = 0 if abs($d0) > 1e-9 || abs($n1 - 1) > 1e-9 }
  for my $p (0 .. 3) { for my $q (0 .. 3) { next if $q == $p; my ($Wp, $Wq) = ($WH[$p][1], $WH[$q][1]); my $ov = 0; for my $k (keys %{$Wp->{$zero}}) { $ov += $Wp->{$zero}{$k} * ($Wq->{$zero}{$k} // 0) } $ok3 = 0 if abs($ov) > 1e-9 } }
  printf "G20-KAT <0|W_{1/2}(p) W_{1/2}(p')|0> = 0 for all p != p'  [%s]\n", $ok3 ? 'MET' : 'FAILED'; printf "G20-KAT operators  [%s]\n", ($asym < 1e-9 && $ok1 && $ok2 && $ok3) ? 'ALL MET' : 'FAILED'; exit if $KAT eq 'kat' }
# ---- T = Q^T D Q applied to a vector; D diagonal
my @Dg = map { my $j = $ST[$_][0]; my $d = 1; $d *= $cel[$_] for @$j; $d } 0 .. $NS - 1;
sub spmv { my ($M, $v, $trans) = @_; my @w = (0) x $NS; for my $i (keys %$M) { my $row = $M->{$i}; if ($trans) { my $vi = $v->[$i]; next if $vi == 0; $w[$_] += $row->{$_} * $vi for keys %$row } else { my $s = 0; $s += $row->{$_} * $v->[$_] for keys %$row; $w[$i] = $s } } return \@w }
sub applyT { my $v = shift; for my $p (3, 2, 1, 0) { $v = spmv($Q[$p], $v, 0) } my @w = map { $Dg[$_] * $v->[$_] } 0 .. $NS - 1; $v = \@w; for my $p (0 .. 3) { $v = spmv($Q[$p], $v, 1) } return $v }
sub dot { my ($a, $b) = @_; my $s = 0; $s += $a->[$_] * $b->[$_] for 0 .. $NS - 1; return $s }
# ---- Lanczos with full reorthogonalisation
srand(7); my @v0 = map { rand() - 0.5 } 1 .. $NS; { my $n = sqrt(dot(\@v0, \@v0)); $_ /= $n for @v0 }
my (@V, @alpha, @bet); push @V, \@v0; my $vprev; my $w;
for my $k (0 .. $NLAN - 1) { $w = applyT($V[$k]); my $a = dot($w, $V[$k]); push @alpha, $a; for my $i (0 .. $k) { my $c = dot($w, $V[$i]); $w->[$_] -= $c * $V[$i][$_] for 0 .. $NS - 1 } my $b = sqrt(dot($w, $w)); last if $b < 1e-13; push @bet, $b; push @V, [ map { $_ / $b } @$w ]; last if $k == $NLAN - 1 }
my $m = scalar @alpha; my @ev;                                                                   # the tridiagonal's eigenvalues by bisection (Sturm count), the top two
{ my @a = @alpha; my @b = @bet; my $lo = -1e9; my $hi = 1e9; my $count = sub { my $x = shift; my $c = 0; my $q = 1; for my $i (0 .. $m - 1) { $q = $a[$i] - $x - ($i ? $b[$i - 1] ** 2 / $q : 0); $c++ if $q < 0 } return $c };
  for my $want (0, 1, 2) { my ($L, $H) = ($lo, $hi); for (1 .. 200) { my $mid = ($L + $H) / 2; if ($count->($mid) >= $m - $want) { $H = $mid } else { $L = $mid } } push @ev, ($L + $H) / 2 } }
my ($l0, $l1, $l2) = @ev; my $gap = -log($l1 / $l0); printf "G20-SPECTRUM beta=%g JMAX=%g lambda_0=%.12g lambda_1/lambda_0=%.10g lambda_2/lambda_0=%.10g  full gap -ln(l1/l0)=%.6f  (Lanczos %d steps, %d s)\n", $beta, $JMAX, $l0, $l1 / $l0, $l2 / $l0, $gap, $m, time - $t0;
# ---- the centre flux: the Z_2 x Z_2 label (parity of sum 2j over the cut {Lx(0,0), Lx(0,1)}, over {Ly(0,0), Ly(1,0)}) is conserved by T (the
# centre commutes with every plaquette operator and with D), so the chain LUMPS EXACTLY by it: Lanczos within each sector, the 0++ gap in (0,0)
my @SEC = map { my $j = $ST[$_][0]; (($j->[0] + $j->[2]) % 2) . (($j->[4] + $j->[5]) % 2) } 0 .. $NS - 1;
sub lanczos_in { my $mask = shift; my @v = map { $mask->[$_] ? rand() - 0.5 : 0 } 0 .. $NS - 1; my $n = sqrt(dot(\@v, \@v)); return () if $n == 0; $_ /= $n for @v; my (@Vs, @as, @bs); push @Vs, \@v;
  for my $k (0 .. $NLAN - 1) { my $w = applyT($Vs[$k]); my $leak = 0; for my $i (0 .. $NS - 1) { if (!$mask->[$i]) { $leak += $w->[$i] ** 2; $w->[$i] = 0 } } die "T mixes the flux sectors: leak $leak" if $leak > 1e-18;
    my $a = dot($w, $Vs[$k]); push @as, $a; for my $i (0 .. $k) { my $c = dot($w, $Vs[$i]); $w->[$_] -= $c * $Vs[$i][$_] for 0 .. $NS - 1 } my $b = sqrt(dot($w, $w)); last if $b < 1e-13; push @bs, $b; push @Vs, [ map { $_ / $b } @$w ] }
  my $mm = scalar @as; my @e; my $count = sub { my $x = shift; my $c = 0; my $q = 1; for my $i (0 .. $mm - 1) { $q = $as[$i] - $x - ($i ? $bs[$i - 1] ** 2 / $q : 0); $c++ if $q < 0 } return $c };
  for my $want (0, 1) { my ($L, $H) = (-1e9, 1e9); for (1 .. 200) { my $mid = ($L + $H) / 2; if ($count->($mid) >= $mm - $want) { $H = $mid } else { $L = $mid } } push @e, ($L + $H) / 2 } return @e }
my %SG; for my $s ('00', '10', '01', '11') { my @mask = map { $SEC[$_] eq $s ? 1 : 0 } 0 .. $NS - 1; my $cnt = grep { $_ } @mask; my ($e0, $e1) = lanczos_in(\@mask); next unless defined $e0; $SG{$s} = [$e0, $e1, $cnt];
  printf "G20-SECTOR beta=%g flux=(%s) states=%d top=%.12g second=%.12g  gap-in-sector=-ln(second/top)=%.6f  (against lambda_0: -ln(top/lambda_0)=%.6f)\n", $beta, $s, $cnt, $e0, $e1, -log($e1 / $e0), -log($e0 / $l0) }
my $m00 = defined $SG{'00'} ? -log($SG{'00'}[1] / $SG{'00'}[0]) : 9; my $mtor = defined $SG{'10'} ? -log($SG{'10'}[0] / $l0) : 9;
printf "G20-LUMP beta=%g the 0++ gap in the zero-flux sector = %.6f; the torelon (flux (1,0) top against lambda_0) = %.6f; the full gap %.6f %s the torelon\n", $beta, $m00, $mtor, $gap, abs($gap - $mtor) < 1e-6 ? 'IS' : 'IS NOT';
# ---- the ground state by power iteration from the Lanczos vector, then K(d)
my $psi = $V[0]; for (1 .. 60) { $psi = applyT($psi); my $n = sqrt(dot($psi, $psi)); $_ /= $n for @$psi } my $Tpsi = applyT($psi); my $lam = dot($Tpsi, $psi); my $res = 0; $res += ($Tpsi->[$_] - $lam * $psi->[$_]) ** 2 for 0 .. $NS - 1;
printf "G20-GROUND lambda_0=%.12g residual=%.2e; the electric weight of the first dropped spin c_{%g}=%.5f (truncation's size)\n", $lam, sqrt($res), $JMAX + 0.5, bessel($J2MAX + 2, $beta) / bessel(1, $beta);
my @Ov = (0) x $NS; for my $p (0 .. 3) { my $W = $WH[$p][1]; my $u = spmv($W, $psi, 0); $Ov[$_] += 0.125 * $u->[$_] for 0 .. $NS - 1 }   # O psi, O = (1/4) sum_p (1/2) tr U_p
my $Obar = dot(\@Ov, $psi); my $x = \@Ov; my @K;
for my $d (0 .. $DMAX) { my $val = dot($x, \@Ov) / $lam ** $d - $Obar ** 2; last if $d > 0 && abs($val) < 1e-12 * $K[0]; push @K, $val; $x = applyT($x) if $d < $DMAX }   # stop at the double-precision floor: a K below 1e-12 K(0) is noise
printf "G20-K beta=%g <O>=%.8f K(0)=Var(O)=%.8e\n", $beta, $Obar, $K[0];
my $DL = $#K; for my $d (1 .. $DL) { my $r = $K[$d] / $K[$d - 1]; printf "G20-K beta=%g d=%d K(d)=%.6e K(d)/K(d-1)=%.8f m_eff=%.6f\n", $beta, $d, $K[$d], $r, ($r > 0 ? -log($r) : 9) }
my $m0 = $DL >= 1 ? -log($K[$DL] / $K[$DL - 1]) : 9; my $sc = -4 * log($cel[1]); $m00 = exists $SG{"00"} ? -log($SG{"00"}[1] / $SG{"00"}[0]) : 9;
printf "G20-VERDICT beta=%g JMAX=%g states=%d full-gap=%.6f 0++rate(d=%d)=%.6f 0++gap(sector)=%.6f strong-coupling -4 ln c_{1/2}=%.4f ratio=%.4f monotone-K=%s torelon-below-0++=%s (%d s)\n", $beta, $JMAX, $NS, $gap, $DL, $m0, $m00, $sc, $m0 / $sc, (grep { $K[$_] > $K[$_ - 1] } 1 .. $DL) ? 'NO' : 'YES', ($gap < $m0) ? 'YES' : 'NO', time - $t0;
