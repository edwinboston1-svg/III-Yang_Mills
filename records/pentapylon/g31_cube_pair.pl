#!/usr/bin/perl
# g31_cube_pair.pl -- THE CUBE'S PLAQUETTE PAIRS AND ITS FACE LAW, EXACT IN THE SPINS-<=-1 MODEL WITH THE READ FACES' SECTORS WIDENED
# (ΠΕΝΤΑΠΥΛΟΝ G31, 2026-10-29 05:1x EDT, the desktop seat; RESULTS 16.20 S2 and the Griffiths decider the plan seat's C4 names).
# THE MODEL is g26's (every plaquette weight w(V) = 1 + 2 a_1 chi_1/2 + 3 a_2 chi_1, positive at 2.2; the same twelve cube links, six faces, 88
# outside links as data) and the contraction is g26's ring of four columns; what is new is EXACTNESS OF THE READ FACES: the top face, the bottom
# face and side face 0 carry NO weight in the ring (their sectors are RESOLVED in the trace, ZRES{top}{side0}{bottom}), their sectors run past the
# weight's truncation (the top to spin TMAX/2, side 0 to S0MAX/2, the bottom to BMAX/2, the other three sides to spin 1 as the weight needs), and
# every character moment and pair moment is assembled from ZRES by the fusion rule chi_s chi_a = sum_k chi_k: E[chi_a(top)] = (1/Z) sum FAC[t]
# FAC[s] FAC[b] sum_{k in t x a} ZRES{k}{s}{b}, and the pairs likewise.  Nothing is dropped: g26's "dropped spin-3/2 term" is the k = 3/2 sector
# this instrument carries.  THE REPRESENTATIONS past spin 1 are the symmetric powers of the fundamental (the generic D^j, complex, proved a
# HOMOMORPHISM and traced to chi_j at load, or the instrument refuses); THE RULE is the product rule at the degree the caps need (Gauss-Chebyshev-U
# x Gauss-Legendre x equal azimuths, exact to the degree 2 j_top + 2 j_side + 8 of the link integrals), its moments against the Dirichlet
# formula at load.  KNOWN ANSWERS (MODE=kat): the rule's moments to its degree; D^{3/2}, D^2 homomorphisms with trace chi; THE FREE CUBE (no
# dangling weights): every link in exactly two faces forces one spin j on all six faces, ZRES{j}{j}{j} = f_j^3 / (2j+1)^4 and ZERO off the
# diagonal (the widened sectors included), E[chi_1/2(top)] and the pair moments against the closed form sum_j (f_{j-1/2} + f_{j+1/2})^n f_j^{6-n}
# /(2j+1)^4; and g26's own reading: at caps (2,2,2) Z at the symmetric datum = 1.981803e+16 and E[tr U_top] = 1.282646004 at 2.2 (g26 drops the
# 3/2 sector; this instrument with TMAX = 2 drops it the same way).
# MODE=pair: the connected correlations of chi_1/2 and chi_1 between the top face and side 0 (adjacent, one shared link) and the top face and the
# bottom (opposite, no shared link) at the datum (symmetric by default) -- GRIFFITHS II for plaquette characters in a positive-character-weight
# SU(2) gauge theory with positive boundary fields: a negative connected correlation beyond 1e-9 REFUTES the general inequality (the truncated
# weight has nonnegative character coefficients, so an inequality quantified over such weights would cover it); positives are evidence, not proof.
# usage: perl g31_cube_pair.pl beta [MODE=pair|kat] [TMAX=4] [S0MAX=3] [BMAX=3] [DEG=0: derived]   env G31_DATUM=symmetric|cancel
use strict; use warnings; use POSIX (); $| = 1;
my ($beta, $MODE, $TMAX, $S0MAX, $BMAX, $DEG) = @ARGV; die "usage: beta [pair|kat] [TMAX] [S0MAX] [BMAX] [DEG]" unless defined $beta;
$MODE //= 'pair'; $TMAX //= 4; $S0MAX //= 3; $BMAX //= 3; $DEG //= 0; my $DATUM = $ENV{G31_DATUM} // 'symmetric';
my $PI = 3.141592653589793; my $t0 = time;
sub bessel { my ($n, $x) = @_; my $s = 0; my $t = ($x / 2) ** $n; my $f = 1; $f *= $_ for 1 .. $n; $t /= $f; for my $k (0 .. 80) { $s += $t; $t *= ($x / 2) ** 2 / (($k + 1) * ($k + 1 + $n)) } return $s }
my @A = map { bessel($_ + 1, $beta) / bessel(1, $beta) } 0 .. 8;                      # a_s = I_{s+1}/I_1, a_0 = 1
my $SMAX = (sort { $b <=> $a } ($TMAX, $S0MAX, $BMAX, 2))[0];
my @FAC = map { $_ <= 2 ? ($_ + 1) * $A[$_] : 0 } 0 .. $SMAX; my @DIM = map { $_ + 1 } 0 .. $SMAX;   # the weight's coefficients f_s, zero past spin 1
my @FACT = (1); $FACT[$_] = $FACT[$_ - 1] * $_ for 1 .. 20;
# ---- quaternions and complex numbers
sub qmul { my ($a, $b) = @_; return [ $a->[0]*$b->[0] - $a->[1]*$b->[1] - $a->[2]*$b->[2] - $a->[3]*$b->[3], $a->[0]*$b->[1] + $a->[1]*$b->[0] + $a->[2]*$b->[3] - $a->[3]*$b->[2], $a->[0]*$b->[2] - $a->[1]*$b->[3] + $a->[2]*$b->[0] + $a->[3]*$b->[1], $a->[0]*$b->[3] + $a->[1]*$b->[2] - $a->[2]*$b->[1] + $a->[3]*$b->[0] ] }
sub qinv { my $a = shift; return [ $a->[0], -$a->[1], -$a->[2], -$a->[3] ] }
sub cm { my ($a, $b) = @_; return [ $a->[0]*$b->[0] - $a->[1]*$b->[1], $a->[0]*$b->[1] + $a->[1]*$b->[0] ] }
sub ca { my ($a, $b) = @_; return [ $a->[0] + $b->[0], $a->[1] + $b->[1] ] }
sub Dhalf { my $q = shift; return [ [ [$q->[0], $q->[1]], [$q->[2], $q->[3]] ], [ [-$q->[2], $q->[3]], [$q->[0], -$q->[1]] ] ] }
sub Rone { my $q = shift; my ($w, $x, $y, $z) = @$q;
  my @R = ([1 - 2*($y*$y + $z*$z), 2*($x*$y - $w*$z), 2*($x*$z + $w*$y)], [2*($x*$y + $w*$z), 1 - 2*($x*$x + $z*$z), 2*($y*$z - $w*$x)], [2*($x*$z - $w*$y), 2*($y*$z + $w*$x), 1 - 2*($x*$x + $y*$y)]);
  return [ map { my $r = $_; [ map { [$_, 0] } @$r ] } @R ] }
# the generic spin-s/2 representation on the symmetric power: e_q = u^q v^{s-q}/sqrt(q!(s-q)!), the substitution chosen so that D(gh) = D(g)D(h)
my $GENINV = 0;                                                                        # set at load: 0 = substitute by M_g, 1 = by M_{g^-1}
sub Dsub { my ($s, $q) = @_; my $a = [$q->[0], $q->[1]]; my $b = [$q->[2], $q->[3]]; my $ab = [$q->[0], -$q->[1]]; my $nbb = [-$q->[2], $q->[3]];
  my @D; for my $qq (0 .. $s) { my @poly = ([1, 0]);
    for (1 .. $qq) { my @np = map { [0, 0] } 0 .. scalar(@poly); for my $k (0 .. $#poly) { $np[$k + 1] = ca($np[$k + 1], cm($poly[$k], $a)); $np[$k] = ca($np[$k], cm($poly[$k], $b)) } @poly = @np }
    for (1 .. $s - $qq) { my @np = map { [0, 0] } 0 .. scalar(@poly); for my $k (0 .. $#poly) { $np[$k + 1] = ca($np[$k + 1], cm($poly[$k], $nbb)); $np[$k] = ca($np[$k], cm($poly[$k], $ab)) } @poly = @np }
    for my $p (0 .. $s) { my $sc = sqrt($FACT[$p] * $FACT[$s - $p] / ($FACT[$qq] * $FACT[$s - $qq])); $D[$p][$qq] = [$poly[$p][0] * $sc, $poly[$p][1] * $sc] } }
  return \@D }
sub Dgen { my ($s, $q) = @_; return Dsub($s, $GENINV ? qinv($q) : $q) }
sub rep { my ($s, $q) = @_; return [[[1, 0]]] if $s == 0; return Dhalf($q) if $s == 1; return Rone($q) if $s == 2; return Dgen($s, $q) }
sub chi { my ($s, $q) = @_; my $w = $q->[0]; my ($u0, $u1) = (1, 2 * $w); return $u0 if $s == 0; for (2 .. $s) { ($u0, $u1) = ($u1, 2 * $w * $u1 - $u0) } return $u1 }   # Chebyshev U_s(w) = chi_{s/2}
sub cmatmul { my ($X, $Y) = @_; my $n = scalar @$X; my @Z; for my $i (0 .. $n - 1) { for my $j (0 .. $n - 1) { my $acc = [0, 0]; $acc = ca($acc, cm($X->[$i][$_], $Y->[$_][$j])) for 0 .. $n - 1; $Z[$i][$j] = $acc } } return \@Z }
sub cmatdiff { my ($X, $Y) = @_; my $n = scalar @$X; my $m = 0; for my $i (0 .. $n - 1) { for my $j (0 .. $n - 1) { my $d = abs($X->[$i][$j][0] - $Y->[$i][$j][0]) + abs($X->[$i][$j][1] - $Y->[$i][$j][1]); $m = $d if $d > $m } } return $m }
sub ctrace { my $X = shift; my $t = [0, 0]; $t = ca($t, $X->[$_][$_]) for 0 .. $#$X; return $t }
# ---- the representation's known answers: choose the substitution that composes as a homomorphism, trace = chi
{ my $q1 = [0.5, 0.5, 0.5, 0.5]; my $q2 = [1 / sqrt(2), 0, 1 / sqrt(2), 0]; my $q3 = [0.6, 0.0, 0.8, 0.0]; my $q12 = qmul($q1, $q2); my $bad = 0; my $line = '';
  for my $s (3 .. ($SMAX < 3 ? 2 : $SMAX)) {
    my $d0 = cmatdiff(Dsub($s, $q12), cmatmul(Dsub($s, $q1), Dsub($s, $q2))); my $d1 = cmatdiff(Dsub($s, qinv($q12)), cmatmul(Dsub($s, qinv($q1)), Dsub($s, qinv($q2))));
    if ($s == 3) { $GENINV = ($d0 < 1e-12) ? 0 : (($d1 < 1e-12) ? 1 : -1) }
    my $hom = $GENINV < 0 ? 1 : cmatdiff(Dgen($s, $q12), cmatmul(Dgen($s, $q1), Dgen($s, $q2))); my $tr = $GENINV < 0 ? [0, 0] : ctrace(Dgen($s, $q3)); my $ch = chi($s, $q3);
    $bad++ if $GENINV < 0 || $hom > 1e-12 || abs($tr->[0] - $ch) > 1e-12 || abs($tr->[1]) > 1e-12;
    $line .= sprintf(" s=%d: hom-defect %.1e (sub %.1e, inv-sub %.1e) tr=%.12f chi=%.12f;", $s, $hom, $d0, $d1, $tr->[0], $ch) }
  $line = ' (no spin past 1 in use)' unless $line;
  printf "G31-KAT representations (GENINV=%d):%s [%s]\n", $GENINV, $line, $bad ? 'FAILED' : 'MET'; exit 1 if $bad }
# ---- the rule at the needed degree
my $NEED = 2 * ((sort { $b <=> $a } ($TMAX, $BMAX))[0] + $S0MAX) + 8; $NEED = 12 if $NEED < 12; $DEG = $NEED if $DEG < $NEED;
my ($NTH, $NGL, $NAZ) = (POSIX::ceil(($DEG + 1) / 2), POSIX::ceil(($DEG + 1) / 2), $DEG + 1);
sub gauss_legendre { my $n = shift; my (@x, @w); for my $i (1 .. $n) { my $x = cos($PI * ($i - 0.25) / ($n + 0.5)); my $dp;
    for (1 .. 200) { my ($p0, $p1) = (1, $x); for my $k (2 .. $n) { ($p0, $p1) = ($p1, ((2 * $k - 1) * $x * $p1 - ($k - 1) * $p0) / $k) } $dp = $n * ($x * $p1 - $p0) / ($x * $x - 1); my $dx = $p1 / $dp; $x -= $dx; last if abs($dx) < 1e-16 }
    my ($p0, $p1) = (1, $x); for my $k (2 .. $n) { ($p0, $p1) = ($p1, ((2 * $k - 1) * $x * $p1 - ($k - 1) * $p0) / $k) } $dp = $n * ($x * $p1 - $p0) / ($x * $x - 1);
    push @x, $x; push @w, 2 / ((1 - $x * $x) * $dp * $dp) } return (\@x, \@w) }
my @RULE; { my ($gx, $gw) = gauss_legendre($NGL);
  for my $k (1 .. $NTH) { my $th = $k * $PI / ($NTH + 1); my $wt = 2 * sin($th) ** 2 / ($NTH + 1);
    for my $j (0 .. $NGL - 1) { my $t = $gx->[$j]; my $st = sqrt(1 - $t * $t);
      for my $l (0 .. $NAZ - 1) { my $ph = 2 * $PI * $l / $NAZ; push @RULE, [[cos($th), sin($th) * $st * cos($ph), sin($th) * $st * sin($ph), sin($th) * $t], $wt * $gw->[$j] / 2 / $NAZ] } } } }
{ my @cat = (1, 1, 2, 5, 14, 42, 132, 429, 1430, 4862, 16796, 58786, 208012, 742900); my $bad = 0; my $line = ''; my $wsum = 0; $wsum += $_->[1] for @RULE; $bad++ if abs($wsum - 1) > 1e-13;
  for my $k (1 .. int($DEG / 2)) { my $m = 0; $m += $_->[1] * $_->[0][0] ** (2 * $k) for @RULE; my $ex = $cat[$k] / 4 ** $k; $bad++ if abs($m - $ex) > 1e-13 * (1 + $ex); $line .= sprintf(" w^%d:%.1e", 2 * $k, abs($m - $ex)) }
  my $dir = sub { my @a = @_; my $num = 1; $num *= ($FACT[2 * $_] / (4 ** $_ * $FACT[$_])) for @a; my $tot = 0; $tot += $_ for @a; return $num / $FACT[1 + $tot] };   # Gamma(a+1/2)/Gamma(1/2) = (2a)!/(4^a a!); Gamma(2)/Gamma(2+sum) = 1/(1+sum)!
  for my $a ([1, 1, 1, 1], [2, 2, 2, 0], [2, 2, 2, 1], [2, 2, 2, 2]) { my $deg = 2 * ($a->[0] + $a->[1] + $a->[2] + $a->[3]); next if $deg > $DEG; my $m = 0; $m += $_->[1] * $_->[0][0] ** (2 * $a->[3]) * $_->[0][1] ** (2 * $a->[0]) * $_->[0][2] ** (2 * $a->[1]) * $_->[0][3] ** (2 * $a->[2]) for @RULE; my $ex = $dir->(@$a); $bad++ if abs($m - $ex) > 1e-12 * $ex; $line .= sprintf(" x^%dy^%dz^%dw^%d:%.1e", 2 * $a->[0], 2 * $a->[1], 2 * $a->[2], 2 * $a->[3], abs($m - $ex) / $ex) }
  printf "G31-KAT RULE%d (%d x %d x %d = %d points, needed %d): errors%s [%s]\n", $DEG, $NTH, $NGL, $NAZ, scalar @RULE, $NEED, $line, $bad ? 'FAILED' : 'MET'; exit 1 if $bad }
sub wgt { my $V = shift; return 1 + 2 * $A[1] * chi(1, $V) + 3 * $A[2] * chi(2, $V) }
my $minw = 1e9; for my $k (0 .. 2000) { my $th = $PI * $k / 2000; my $v = wgt([cos($th), sin($th), 0, 0]); $minw = $v if $v < $minw } die "the truncated weight is not positive" unless $minw > 0;
printf "G31 beta=%g MODE=%s caps top=%d side0=%d bottom=%d (others 2) rule degree %d; a_1=%.6f a_2=%.6f; f = %s; the weight's minimum %.6f; datum %s\n", $beta, $MODE, $TMAX, $S0MAX, $BMAX, $DEG, $A[1], $A[2], join(',', map { sprintf('%.6f', $_) } @FAC), $minw, $DATUM;
# ---- the cube (g14's construction verbatim)
my @C = ([0, 0], [1, 0], [1, 1], [0, 1]); my %EDGE;
for my $i (0 .. 3) { my $n = ($i + 1) % 4; my ($x0, $y0) = @{$C[$i]}; my ($x1, $y1) = @{$C[$n]};
  my $dir = ($x1 != $x0) ? 1 : 2; my $fwd = ($x1 + $y1 > $x0 + $y0) ? 1 : -1; my $bx = $fwd > 0 ? $x0 : $x1; my $by = $fwd > 0 ? $y0 : $y1;
  $EDGE{"b$i"} = { base => [$bx, $by, 0, 0], dir => $dir, sgn => $fwd }; $EDGE{"t$i"} = { base => [$bx, $by, 1, 0], dir => $dir, sgn => $fwd };
  $EDGE{"v$i"} = { base => [$x0, $y0, 0, 0], dir => 3, sgn => 1 } }
my %FACE = (bottom => [ map { ["b$_", $EDGE{"b$_"}{sgn}] } 0 .. 3 ], top => [ map { ["t$_", $EDGE{"t$_"}{sgn}] } 0 .. 3 ]);
for my $i (0 .. 3) { my $n = ($i + 1) % 4; $FACE{"side$i"} = [ ["b$i", $EDGE{"b$i"}{sgn}], ["v$n", 1], ["t$i", -$EDGE{"t$i"}{sgn}], ["v$i", -1] ] }
my %CAP = (top => $TMAX, bottom => $BMAX, side0 => $S0MAX, side1 => 2, side2 => 2, side3 => 2);
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
my $FREE = 0;                                                                           # 1: no dangling weights (the free cube, a known answer)
# ---- link tensors: L->[s1][s2][a][b][c][d], the caps those of the edge's two faces
my %LTC;
sub linktensor { my ($e, $dat) = @_; my @T = $FREE ? () : map { staple($_, $dat) } @{$DANG{$e}}; my $key = $e . '|' . ($FREE ? 'free' : join(';', map { join(',', map { sprintf('%.12f', $_) } @$_) } @T));
  return $LTC{$key} if exists $LTC{$key};
  my @S = @{$SLOT{$e}}; my ($c1, $c2) = ($CAP{$S[0][0]}, $CAP{$S[1][0]}); my $L;
  for my $pt (@RULE) { my ($U, $wq) = @$pt; my $w = $wq; $w *= wgt(qmul($U, $_)) for @T;
    my @R1 = map { rep($_, $S[0][2] > 0 ? $U : qinv($U)) } 0 .. $c1; my @R2 = map { rep($_, $S[1][2] > 0 ? $U : qinv($U)) } 0 .. $c2;
    for my $s1 (0 .. $c1) { my $n1 = $DIM[$s1]; for my $s2 (0 .. $c2) { my $n2 = $DIM[$s2];
      for my $a (0 .. $n1 - 1) { for my $b (0 .. $n1 - 1) { my $f1 = $R1[$s1][$a][$b]; my ($f1r, $f1i) = ($f1->[0] * $w, $f1->[1] * $w);
        for my $c (0 .. $n2 - 1) { for my $d (0 .. $n2 - 1) { my $g = $R2[$s2][$c][$d]; my $cur = $L->[$s1][$s2][$a][$b][$c][$d] //= [0, 0]; $cur->[0] += $f1r * $g->[0] - $f1i * $g->[1]; $cur->[1] += $f1r * $g->[1] + $f1i * $g->[0] } } } } } } }
  return $LTC{$key} = $L }
sub tensorget { my ($L, $e, $fA, $sA, $iA, $oA, $fB, $sB, $iB, $oB) = @_; my @S = @{$SLOT{$e}};
  return ($S[0][0] eq $fA) ? ($L->[$sA][$sB][$iA][$oA][$iB][$oB] // [0, 0]) : ($L->[$sB][$sA][$iB][$oB][$iA][$oA] // [0, 0]) }
# ---- cut states (tT, ti, tB, bi, sS, p, q); the side spin of the cut after column i is side_{i+1}'s, capped by that face
my @ST;
for my $tT (0 .. $TMAX) { for my $ti (0 .. $DIM[$tT] - 1) { for my $tB (0 .. $BMAX) { for my $bi (0 .. $DIM[$tB] - 1) { for my $sS (0 .. $S0MAX) { for my $p (0 .. $DIM[$sS] - 1) { for my $q (0 .. $DIM[$sS] - 1) {
  push @ST, [$tT, $ti, $tB, $bi, $sS, $p, $q] } } } } } } }
printf "G31-SPACE %d cut states\n", scalar @ST;
my %COLC;
sub column { my ($i, $LT, $tkey) = @_; my $ck = "$i|$tkey"; return $COLC{$ck} if exists $COLC{$ck};
  my $n = ($i + 1) % 4; my ($t, $b, $v) = ("t$i", "b$i", "v$n"); my $sf = "side$i"; my $sn = "side$n"; my %M; my ($cin, $cout) = ($CAP{$sf}, $CAP{$sn});
  for my $zi (0 .. $#ST) { my ($tT, $ti, $tB, $bi, $sS, $tv, $vb) = @{$ST[$zi]}; next if $sS > $cin;
    for my $zo (0 .. $#ST) { my ($tT2, $to, $tB2, $bo, $sS2, $tvn, $vbn) = @{$ST[$zo]}; next unless $tT2 == $tT && $tB2 == $tB; next if $sS2 > $cout;
      my $acc = [0, 0]; my $dS = $DIM[$sS];
      for my $bv (0 .. $dS - 1) { for my $vt (0 .. $dS - 1) {
        my $fb = tensorget($LT->{$b}, $b, 'bottom', $tB, $bi, $bo, $sf, $sS, $vb, $bv); next if $fb->[0] == 0 && $fb->[1] == 0;
        my $fv = tensorget($LT->{$v}, $v, $sf, $sS, $bv, $vt, $sn, $sS2, $tvn, $vbn); next if $fv->[0] == 0 && $fv->[1] == 0;
        my $ft = tensorget($LT->{$t}, $t, 'top', $tT, $ti, $to, $sf, $sS, $vt, $tv);
        $acc = ca($acc, cm(cm($fb, $fv), $ft)) } }
      my $fac = ($i == 0) ? 1 : $FAC[$sS];                                               # side 0, the top and the bottom carry weight 1: RESOLVED
      $M{$zi}{$zo} = [$acc->[0] * $fac, $acc->[1] * $fac] if $acc->[0] != 0 || $acc->[1] != 0 } }
  return $COLC{$ck} = \%M }
sub matmul { my ($A, $B) = @_; my %C; for my $i (keys %$A) { for my $k (keys %{$A->{$i}}) { my $a = $A->{$i}{$k}; next unless $B->{$k}; my $Bk = $B->{$k}; for my $j (keys %$Bk) { my $b = $Bk->{$j}; my $c = $C{$i}{$j} //= [0, 0]; $c->[0] += $a->[0] * $b->[0] - $a->[1] * $b->[1]; $c->[1] += $a->[0] * $b->[1] + $a->[1] * $b->[0] } } } return \%C }
my %ZRES; my $DROP = 0;                                                                  # 1: a fusion target past its cap is DROPPED (g26's reading); 0: refused
sub Zres { my $dat = shift; my %LT; my %TK; for my $e (keys %EDGE) { $LT{$e} = linktensor($e, $dat); $TK{$e} = "$LT{$e}" }
  my @M = map { my $i = $_; my $n = ($i + 1) % 4; column($i, \%LT, join('|', $TK{"t$i"}, $TK{"b$i"}, $TK{"v$n"})) } 0 .. 3;
  my $P = matmul(matmul($M[0], $M[1]), matmul($M[2], $M[3])); %ZRES = (); my $imax = 0;
  for my $z (keys %$P) { next unless exists $P->{$z}{$z}; my ($tT, $ti, $tB, $bi, $sS) = @{$ST[$z]}; $ZRES{$tT}{$sS}{$tB} += $P->{$z}{$z}[0]; $imax = abs($P->{$z}{$z}[1]) if abs($P->{$z}{$z}[1]) > $imax }
  return $imax }
sub fuse { my ($s, $a) = @_; my @k; for (my $k = abs($s - $a); $k <= $s + $a; $k += 2) { push @k, $k } return @k }
sub zr { my ($t, $s, $b) = @_; return $ZRES{$t}{$s}{$b} // 0 }
# the moments from the resolved trace: faces 'top' (t), 'side0' (s), 'bottom' (b); %ins = (face => character index a)
sub moment { my %ins = @_; my $sum = 0;
  for my $t (0 .. 2) { for my $s (0 .. 2) { for my $b (0 .. 2) { my $w = $FAC[$t] * $FAC[$s] * $FAC[$b]; next if $w == 0;
    my @kt = exists $ins{top} ? fuse($t, $ins{top}) : ($t); my @ks = exists $ins{side0} ? fuse($s, $ins{side0}) : ($s); my @kb = exists $ins{bottom} ? fuse($b, $ins{bottom}) : ($b);
    for my $kt (@kt) { if ($kt > $TMAX) { next if $DROP; die "top cap $TMAX below the needed $kt" } for my $ks (@ks) { if ($ks > $S0MAX) { next if $DROP; die "side0 cap $S0MAX below the needed $ks" } for my $kb (@kb) { if ($kb > $BMAX) { next if $DROP; die "bottom cap $BMAX below the needed $kb" } $sum += $w * zr($kt, $ks, $kb) } } } } } }
  return $sum }
# ---- the data
my @d0 = map { [1, 0, 0, 0] } 1 .. $NOUT;
if ($DATUM eq 'cancel') { my @want = ([1, 0, 0, 0], [-1, 0, 0, 0], [0, 1, 0, 0], [0, -1, 0, 0]); my @mid = map { $_->[1][0] } @{$DANG{'t0'}}; for my $s (0 .. 3) { $d0[$mid[$s]] = qinv($want[$s]) } }
# ---- MODE=kat: the free cube against the closed form, then g26's reading
if ($MODE eq 'kat') { $FREE = 1; $DROP = 1; my $imax = Zres(\@d0); my $bad = 0; my $line = '';
  for my $t (0 .. $TMAX) { for my $s (0 .. $S0MAX) { for my $b (0 .. $BMAX) { my $v = zr($t, $s, $b);
    my $ex = ($t == $s && $s == $b) ? ($FAC[$t] ** 3 / $DIM[$t] ** 4) : 0; $bad++ if abs($v - $ex) > 1e-10 * (1 + abs($ex)); $line .= sprintf(" (%d,%d,%d)=%.6e", $t, $s, $b, $v) if ($t == $s && $s == $b) || abs($v) > 1e-10 } } }
  my $Z = moment(); my $Zc = 0; $Zc += $FAC[$_] ** 6 / $DIM[$_] ** 4 for 0 .. 2;
  my $f = sub { my $j = shift; return ($j < 0 || $j > $SMAX) ? 0 : $FAC[$j] };
  my ($Z1, $Z12) = (0, 0); for my $j (0 .. 2) { my $g = $f->($j - 1) + $f->($j + 1); $Z1 += $g * $FAC[$j] ** 5 / $DIM[$j] ** 4; $Z12 += $g * $g * $FAC[$j] ** 4 / $DIM[$j] ** 4 }
  my ($e1, $e12s, $e12b) = (moment(top => 1) / $Z, moment(top => 1, side0 => 1) / $Z, moment(top => 1, bottom => 1) / $Z);
  $bad++ if abs($Z - $Zc) > 1e-10 * $Zc || abs($e1 - $Z1 / $Zc) > 1e-10 || abs($e12s - $Z12 / $Zc) > 1e-10 || abs($e12b - $Z12 / $Zc) > 1e-10;
  printf "G31-KAT the free cube: resolved sectors%s (imag %.1e); Z = %.12e (closed form %.12e); E[chi_1/2(top)] = %.12f (%.12f); E[chi chi] top-side0 %.12f top-bottom %.12f (closed form %.12f); the connected pair %+.9f [%s] (%d s)\n", $line, $imax, $Z, $Zc, $e1, $Z1 / $Zc, $e12s, $e12b, $Z12 / $Zc, $e12s - $e1 * $e1, $bad ? 'FAILED' : 'MET', time - $t0;
  exit 1 if $bad; $FREE = 0; %LTC = (); %COLC = ();
  if ($TMAX == 2 && $S0MAX == 2 && $BMAX == 2) { Zres(\@d0); my $Z = moment(); my $e = moment(top => 1) / $Z;
    printf "G31-KAT g26's reading at caps (2,2,2): Z = %.6e against 1.981803e+16, E[tr U_top] = %.9f against 1.282646004 [%s] (%d s)\n", $Z, $e, (abs($Z / 1.981803e16 - 1) < 2e-6 && abs($e - 1.282646004) < 2e-9) ? 'MET' : 'FAILED', time - $t0 }
  POSIX::_exit(0) }
# ---- MODE=pair: the moments and the connected pairs at the datum
my $imax = Zres(\@d0); my $Z = moment(); printf "G31-Z beta=%g datum=%s Z = %.12e (resolved trace's max imaginary part %.1e) (%d s)\n", $beta, $DATUM, $Z, $imax, time - $t0;
my %E; for my $face ('top', 'side0', 'bottom') { for my $a (1, 2) { my $cap = $face eq 'top' ? $TMAX : $face eq 'side0' ? $S0MAX : $BMAX; next if 2 + $a > $cap; $E{$face}{$a} = moment($face => $a) / $Z } }
printf "G31-MOMENTS beta=%g datum=%s E[chi_1/2]: top %.9f side0 %.9f bottom %.9f; E[chi_1]: top %s side0 %s bottom %s\n", $beta, $DATUM, $E{top}{1}, $E{side0}{1}, $E{bottom}{1}, map({ defined $E{$_}{2} ? sprintf('%.9f', $E{$_}{2}) : 'n/a' } 'top', 'side0', 'bottom');
my ($neg, $tot) = (0, 0); my @rows;
for my $pair (['top', 'side0', 'ADJACENT (one shared link t0)'], ['top', 'bottom', 'OPPOSITE (no shared link)']) { my ($f1, $f2, $name) = @$pair;
  for my $a (1, 2) { for my $c (1, 2) { my $cap1 = $TMAX; my $cap2 = $f2 eq 'side0' ? $S0MAX : $BMAX; next if 2 + $a > $cap1 || 2 + $c > $cap2;
    my $m = moment($f1 => $a, $f2 => $c) / $Z; my $cc = $m - $E{$f1}{$a} * $E{$f2}{$c}; $tot++; $neg++ if $cc < -1e-9;
    push @rows, sprintf("<chi_%s(%s) chi_%s(%s)>_c = %+.9f (joint %.9f)", $a == 1 ? '1/2' : '1', $f1, $c == 1 ? '1/2' : '1', $f2, $cc, $m) } }
  printf "G31-PAIR beta=%g datum=%s %s: %s\n", $beta, $DATUM, $name, join('; ', @rows); @rows = () }
printf "G31-VERDICT beta=%g datum=%s caps (%d,%d,%d): %d of %d connected character pairs NEGATIVE beyond 1e-9 -> %s  (%d s)\n", $beta, $DATUM, $TMAX, $S0MAX, $BMAX, $neg, $tot, $neg ? 'GRIFFITHS-II-REFUTED-FOR-PLAQUETTE-CHARACTERS' : 'ALL-PAIRS-POSITIVE (evidence, not proof)', time - $t0;
POSIX::_exit(0);
