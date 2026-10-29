#!/usr/bin/perl
# g33_u1_cube.pl -- THE U(1) CUBE, THE ABELIAN CONTROL OF EVERY SU(2) CUBE READING, EXACT (ΠΕΝΤΑΠΥΛΟΝ G33, 2026-10-29 05:4x EDT, the desktop seat;
# RESULTS 16.24: the plan seat's control -- compact U(1) in four dimensions has no gap above beta ~ 1.01, so a reading that cannot part U(1) at 1.2
# from SU(2) at 2.2 is blind to the gap).
# THE OBJECT is g14/g26's: the twelve links of a unit 3-cube in Z^4, its six faces, every cube link with four external plaquettes on 88 outside
# links (the data), now with ONE ANGLE PER LINK and the Wilson weight e^{beta cos Phi} on every plaquette.  THE EXACTNESS: expand each face weight in
# modes, e^{beta cos Phi} = sum_n I_n(beta) e^{i n Phi}; a cube link e carries the net face flux k_e (its two faces' modes with the cycle signs) and
# four outside staples whose angles phi_s SUM as complex numbers, S_e = sum_s e^{i phi_s} = |S_e| e^{i alpha_e}, so its integral is
# int dtheta/2pi e^{i k theta} e^{beta |S_e| cos(theta + alpha_e)} = I_k(beta |S_e|) e^{-i k alpha_e} =: L_e(k) -- no truncation of the staples at all.
# Z_d = sum over the six face modes of prod_f I_{n_f}(beta) prod_e L_e(k_e), contracted as a RING: the top and bottom modes (n_t, n_b) fixed, the
# four side modes n_{s_i} summed as the trace of four (2N+1) x (2N+1) matrices M_i[n_s][n_s'] = I_{n_s}(beta) L_{t_i}(sgn_i (n_t - n_s)) L_{b_i}(sgn_i
# (n_b + n_s)) L_{v_{i+1}}(n_s - n_s'); the face modes are truncated at |n| <= N where the face weight I_{N+1}(beta) is below 1e-9 (N = 10 at beta
# <= 2), and the truncation is MEASURED by re-running at N + 2.  The whole class law of the top face comes from the same pass: with R(n_t, n_b) =
# tr prod M_i, E[e^{i m Phi_top}] = (1/Z) sum I_{n_t - m}(beta) I_{n_b}(beta) R(n_t, n_b), so the quotient influence here is the EXACT total variation
# of the top face's class law, not a first moment.
# KNOWN ANSWERS: the free cube (no staples): every link in two faces forces one mode n on the six faces, Z = sum_n I_n(beta)^6 and E[cos Phi_top] =
# sum_n (I_{n-1} + I_{n+1}) I_n^5 / (2 Z); the symmetric datum's Z real and positive, equal at N and N + 2 to 1e-9; the class law's density
# nonnegative and of mass one.
# MODES: faceresp (the far and near vertical links under rotations by gamma on a grid; the response of E[cos Phi_top] and the TV of the class law),
# quotrow (the fourteen classes of 16.20 S2 under the same grid: the row in both measures), quotworst (the cancelling datum -- t0's four staples at
# 0, pi, pi/2, -pi/2 -- then the un-cancelling rotations of its first middle link), delta (the two-link law Delta_cube(u, u') on the grid, beside
# Delta_link).  usage: perl g33_u1_cube.pl beta [MODE] [N=10]    env G33_ANGLES="15 30 ... 180"
use strict; use warnings; use POSIX (); $| = 1;
my ($beta, $MODE, $N) = @ARGV; die "usage: beta [faceresp|quotrow|quotworst|delta|kat] [N]" unless defined $beta; $MODE //= 'faceresp'; $N //= 10;
my $PI = 3.141592653589793; my $t0 = time; my @ANG = split / /, ($ENV{G33_ANGLES} // '15 30 45 60 75 90 105 120 135 150 165 180');
sub bessel { my ($n, $x) = @_; $n = -$n if $n < 0; return ($n == 0 ? 1 : 0) if $x == 0; my $s = 0; my $t = ($x / 2) ** $n; my $f = 1; $f *= $_ for 1 .. $n; $t /= $f; for my $k (0 .. 200) { $s += $t; $t *= ($x / 2) ** 2 / (($k + 1) * ($k + 1 + $n)); last if $t < 1e-18 * $s } return $s }
# ---- the cube (g14's construction verbatim)
my @C = ([0, 0], [1, 0], [1, 1], [0, 1]); my %EDGE;
for my $i (0 .. 3) { my $n = ($i + 1) % 4; my ($x0, $y0) = @{$C[$i]}; my ($x1, $y1) = @{$C[$n]};
  my $dir = ($x1 != $x0) ? 1 : 2; my $fwd = ($x1 + $y1 > $x0 + $y0) ? 1 : -1; my $bx = $fwd > 0 ? $x0 : $x1; my $by = $fwd > 0 ? $y0 : $y1;
  $EDGE{"b$i"} = { base => [$bx, $by, 0, 0], dir => $dir, sgn => $fwd }; $EDGE{"t$i"} = { base => [$bx, $by, 1, 0], dir => $dir, sgn => $fwd };
  $EDGE{"v$i"} = { base => [$x0, $y0, 0, 0], dir => 3, sgn => 1 } }
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
sub stapleang { my ($pl, $dat) = @_; my $a = 0; $a += $_->[1] * $dat->[$_->[0]] for @$pl; return $a }
my $FREE = 0;
# ---- the ring: Z and the top face's class law at a datum
my @IB; sub ib { my $n = shift; $n = -$n if $n < 0; return $IB[$n] //= bessel($n, $beta) }                      # the face weights I_n(beta)
my $K = 2 * $N + 2;                                                                                               # the link flux range |k| <= 2N + 1 (+1 for the moments' shift)
sub linkfactors { my ($e, $dat) = @_; my ($sr, $si) = (0, 0); unless ($FREE) { for my $pl (@{$DANG{$e}}) { my $a = stapleang($pl, $dat); $sr += cos($a); $si += sin($a) } }
  my $mod = sqrt($sr * $sr + $si * $si); my $alpha = ($mod > 0) ? atan2($si, $sr) : 0; my @L;                       # L[k + K] = I_k(beta |S|) e^{-i k alpha} as [re, im]
  for my $k (-$K .. $K) { my $v = bessel($k, $beta * $mod); $L[$k + $K] = [$v * cos($k * $alpha), -$v * sin($k * $alpha)] } return \@L }
sub ring { my $dat = shift; my %L; $L{$_} = linkfactors($_, $dat) for keys %EDGE; my $W = 2 * $N + 1; my %R;
  # the vertical link matrices C_i[n_s][n_s'] = L_{v_{i+1}}(n_s - n_s') are independent of (n_t, n_b)
  my @Cm; for my $i (0 .. 3) { my $v = "v" . (($i + 1) % 4); for my $a (0 .. $W - 1) { for my $b (0 .. $W - 1) { $Cm[$i][$a][$b] = $L{$v}[($a - $N) - ($b - $N) + $K] } } }
  for my $nt (-$N .. $N) { for my $nb (-$N .. $N) {
    # M_i = D_i C_i with D_i diagonal: I_{n_s}(beta) L_{t_i}(sgn (n_t - n_s)) L_{b_i}(sgn (n_b + n_s)); the trace of the product by accumulating P = M_0 M_1 M_2 M_3
    my $P; for my $i (0 .. 3) { my $sg = $EDGE{"t$i"}{sgn}; my @M;
      for my $a (0 .. $W - 1) { my $ns = $a - $N; my $lt = $L{"t$i"}[$sg * ($nt - $ns) + $K]; my $lb = $L{"b$i"}[$sg * ($nb + $ns) + $K]; my $f = ib($ns);
        my ($dr, $di) = ($f * ($lt->[0] * $lb->[0] - $lt->[1] * $lb->[1]), $f * ($lt->[0] * $lb->[1] + $lt->[1] * $lb->[0]));
        for my $b (0 .. $W - 1) { my $c = $Cm[$i][$a][$b]; $M[$a][$b] = [$dr * $c->[0] - $di * $c->[1], $dr * $c->[1] + $di * $c->[0]] } }
      if (!defined $P) { $P = \@M } else { my @Q; for my $a (0 .. $W - 1) { my $Pa = $P->[$a]; for my $b (0 .. $W - 1) { my ($r, $im) = (0, 0); for my $c (0 .. $W - 1) { my ($p, $m) = ($Pa->[$c], $M[$c][$b]); $r += $p->[0] * $m->[0] - $p->[1] * $m->[1]; $im += $p->[0] * $m->[1] + $p->[1] * $m->[0] } $Q[$a][$b] = [$r, $im] } } $P = \@Q } }
    my ($tr, $ti) = (0, 0); for my $a (0 .. $W - 1) { $tr += $P->[$a][$a][0]; $ti += $P->[$a][$a][1] } $R{$nt}{$nb} = [$tr, $ti] } }
  return \%R }
# from R: Z, E[cos Phi_top], the class law's Fourier modes c_m = E[e^{i m Phi_top}] for |m| <= N
sub lawof { my $R = shift; my ($Z, $Zi) = (0, 0); my %c;
  for my $m (-$N .. $N) { my ($cr, $ci) = (0, 0); for my $nt (-$N .. $N) { my $f = ib($nt - $m); next if $f == 0; for my $nb (-$N .. $N) { my $g = $f * ib($nb); my $r = $R->{$nt}{$nb}; $cr += $g * $r->[0]; $ci += $g * $r->[1] } } $c{$m} = [$cr, $ci] }
  ($Z, $Zi) = @{$c{0}}; die sprintf("Z not real positive: %.6e + %.6e i", $Z, $Zi) unless $Z > 0 && abs($Zi) < 1e-9 * $Z;
  for my $m (keys %c) { $c{$m} = [$c{$m}[0] / $Z, $c{$m}[1] / $Z] } my $ecos = $c{1}[0];                                # E[cos Phi] = Re c_1 (c_{-1} = conj c_1)
  return ($Z, $ecos, \%c) }
my $NQ = 1440; sub density { my $c = shift; my @p; for my $q (0 .. $NQ - 1) { my $ph = 2 * $PI * $q / $NQ; my $s = $c->{0}[0]; for my $m (1 .. $N) { $s += 2 * ($c->{$m}[0] * cos($m * $ph) + $c->{$m}[1] * sin($m * $ph)) } push @p, $s / (2 * $PI) } return \@p }   # p(Phi) = (1/2pi) sum_m c_m e^{-i m Phi}
sub tv { my ($p, $q) = @_; my $s = 0; $s += abs($p->[$_] - $q->[$_]) for 0 .. $NQ - 1; return 0.5 * $s * 2 * $PI / $NQ }
sub massmin { my $p = shift; my ($s, $mn) = (0, 1e9); for (@$p) { $s += $_; $mn = $_ if $_ < $mn } return ($s * 2 * $PI / $NQ, $mn) }
# ---- the data
my @d0 = (0) x $NOUT;
my ($uf, $un) = (okey([0, 0, -1, 0], 3), okey([0, 0, 1, 0], 3));                                                     # the far vertical under b0 and the near vertical above t0, as g26
printf "G33 beta=%g MODE=%s N=%d: the face weights I_n(beta)/I_0: n=1 %.6f, n=2 %.6f, n=%d %.2e (the truncation's size)\n", $beta, $MODE, $N, ib(1) / ib(0), ib(2) / ib(0), $N + 1, ib($N + 1) / ib(0);
# ---- MODE=kat2 (05:4x EDT; the plan seat's convention check): ONE face Phi = th1 + th2 - th3 - th4 with two staples per link at fixed angles, Z and
# E[e^{i Phi}] by the mode formula under THIS convention (k_e = sum sigma n_f enters as e^{+i k theta}, so L_e(k) = I_k(beta|S|) e^{-i k arg S}) against
# the trapezoid rule on the four angles (spectrally exact for e^{beta cos}); the FLIPPED convention beside it must FAIL on E[sin Phi] (the sighted half:
# Z and E[cos] are blind to the flip by charge conjugation).
if ($MODE eq 'kat2') { my @sig = (1, 1, -1, -1); my @ph = ([0.3, -0.7], [0.5, 1.9], [-1.1, 0.4], [2.2, -0.9]); my $M = 28;
  my ($Zq, $Cq, $Sq) = (0, 0, 0); my @th = map { 2 * $PI * $_ / $M } 0 .. $M - 1;
  my @w1; for my $i (0 .. 3) { for my $a (0 .. $M - 1) { my $s = 0; $s += cos($th[$a] + $_) for @{$ph[$i]}; $w1[$i][$a] = exp($beta * $s) } }
  for my $a (0 .. $M - 1) { for my $b (0 .. $M - 1) { my $wab = $w1[0][$a] * $w1[1][$b]; for my $c (0 .. $M - 1) { my $wabc = $wab * $w1[2][$c]; for my $d (0 .. $M - 1) { my $F = $th[$a] + $th[$b] - $th[$c] - $th[$d]; my $w = $wabc * $w1[3][$d] * exp($beta * cos($F)); $Zq += $w; $Cq += $w * cos($F); $Sq += $w * sin($F) } } } }
  $Cq /= $Zq; $Sq /= $Zq; $Zq /= $M ** 4;
  my $mode = sub { my $flip = shift; my @L; for my $i (0 .. 3) { my ($sr, $si) = (0, 0); for my $p (@{$ph[$i]}) { $sr += cos($p); $si += sin($p) } my $mod = sqrt($sr * $sr + $si * $si); my $al = atan2($si, $sr) * ($flip ? -1 : 1); $L[$i] = sub { my $k = shift; my $v = bessel($k, $beta * $mod); return [$v * cos($k * $al), -$v * sin($k * $al)] } }
    my %c; for my $m (0, 1) { my ($cr, $ci) = (0, 0); for my $n (-$N .. $N) { my $f = ib($n - $m); my ($pr, $pi) = ($f, 0); for my $i (0 .. 3) { my $l = $L[$i]->($sig[$i] * $n); ($pr, $pi) = ($pr * $l->[0] - $pi * $l->[1], $pr * $l->[1] + $pi * $l->[0]) } $cr += $pr; $ci += $pi } $c{$m} = [$cr, $ci] } return ($c{0}[0], $c{1}[0] / $c{0}[0], $c{1}[1] / $c{0}[0]) };
  my ($Zm, $Cm, $Sm) = $mode->(0); my ($Zf, $Cf, $Sf) = $mode->(1);
  my $ok = (abs($Zm - $Zq) < 1e-9 * $Zq && abs($Cm - $Cq) < 1e-9 && abs($Sm - $Sq) < 1e-9) ? 1 : 0; my $flipfails = (abs($Sf - $Sq) > 1e-6) ? 1 : 0;
  printf "G33-KAT2 one face with staples, beta=%g: quadrature Z=%.12f E[cos Phi]=%.12f E[sin Phi]=%.12f; the mode formula (this convention) %.12f %.12f %.12f [%s]; the flipped convention %.12f %.12f %.12f [%s]  (%d s)\n", $beta, $Zq, $Cq, $Sq, $Zm, $Cm, $Sm, $ok ? 'MET' : 'FAILED', $Zf, $Cf, $Sf, $flipfails ? 'FAILS-ON-SIN-AS-IT-MUST' : 'BLIND', time - $t0; exit($ok && $flipfails ? 0 : 1) }
if ($MODE eq 'kat') { $FREE = 1; my ($Z, $e) = lawof(ring(\@d0)); my ($Zc, $Ec) = (0, 0); for my $n (-$N .. $N) { $Zc += ib($n) ** 6; $Ec += (ib($n - 1) + ib($n + 1)) * ib($n) ** 5 / 2 } $Ec /= $Zc; $FREE = 0;
  my $bad = (abs($Z - $Zc) > 1e-10 * $Zc || abs($e - $Ec) > 1e-10) ? 1 : 0;
  printf "G33-KAT the free cube: Z = %.12e (closed form %.12e), E[cos Phi_top] = %.12f (%.12f) [%s] (%d s)\n", $Z, $Zc, $e, $Ec, $bad ? 'FAILED' : 'MET', time - $t0; exit 1 if $bad;
  my ($Z0, $e0, $c0) = lawof(ring(\@d0)); my $p0 = density($c0); my ($mass, $mn) = massmin($p0); $N += 2; @IB = (); $K = 2 * $N + 2; my ($Z2, $e2) = lawof(ring(\@d0)); $N -= 2; @IB = (); $K = 2 * $N + 2;
  printf "G33-KAT the symmetric datum: Z = %.12e, E[cos Phi_top] = %.12f; at N + 2: Z = %.12e, E = %.12f (relative %.1e, %.1e); the density's mass %.12f and minimum %.3e [%s] (%d s)\n", $Z0, $e0, $Z2, $e2, abs($Z2 / $Z0 - 1), abs($e2 - $e0), $mass, $mn, (abs($Z2 / $Z0 - 1) < 1e-8 && abs($e2 - $e0) < 1e-9 && abs($mass - 1) < 1e-9 && $mn > -1e-9) ? 'MET' : 'FAILED', time - $t0; exit 0 }
my ($Z0, $e0, $c0) = lawof(ring(\@d0)); my $p0 = density($c0); printf "G33-BASE beta=%g datum=symmetric Z = %.12e E[cos Phi_top] = %.9f (%d s)\n", $beta, $Z0, $e0, time - $t0;
my $resp = sub { my ($dat, $lk, $g, $pbase, $ebase) = @_; my @dd = @$dat; $dd[$lk] += $g; my ($Z, $e, $c) = lawof(ring(\@dd)); my $p = density($c); return ($e - $ebase, tv($p, $pbase), $Z) };
if ($MODE eq 'faceresp') { for my $pair ([$uf, 'u: the far vertical under b0'], [$un, "u': the near vertical above t0"]) { my ($lk, $name) = @$pair; my ($mx, $mt, $tvx, $tvt) = (0, 0, 0, 0); my @prof;
    for my $th (@ANG) { my ($r, $t) = $resp->(\@d0, $lk, $th * $PI / 180, $p0, $e0); push @prof, sprintf('%g:%+.6f/%.5f', $th, $r, $t); if (abs($r) > $mx) { $mx = abs($r); $mt = $th } if ($t > $tvx) { $tvx = $t; $tvt = $th } }
    printf "G33-FACE beta=%g link=%s (%s): sup over the grid of |E[cos Phi_top | d_g] - E[cos Phi_top | d_0]| = %.9f at %g deg; sup TV of the top face's class law = %.9f at %g deg; profile (deg:dE/TV) %s (%d s)\n", $beta, $OUTKEYS[$lk], $name, $mx, $mt, $tvx, $tvt, join(' ', @prof), time - $t0 }
  POSIX::_exit(0) }
if ($MODE eq 'quotrow') {
  my %cube = map { my ($x, $y, $z) = @$_; ("$x,$y,$z,0" => 1) } ([0,0,0],[1,0,0],[1,1,0],[0,1,0],[0,0,1],[1,0,1],[1,1,1],[0,1,1]);
  my $classify = sub { my $k = shift; my ($pos, $d) = split /:/, $k; my @p = split /,/, $pos; my @q = @p; $q[$d - 1]++;
    my $ends = (exists $cube{join(',', @p)} ? 1 : 0) + (exists $cube{join(',', @q)} ? 1 : 0); die "cube link in the outside list: $k" if $ends == 2;
    if ($ends == 1) { my @v = exists $cube{join(',', @p)} ? @p : @q; my $side = $v[2] == 1 ? 'near' : 'far'; my $dt = $d == 4 ? 't' : $d == 3 ? 'z' : 'inplane'; return "$dt-$side" }
    for my $kk (1 .. 4) { next if $kk == $d; for my $s (1, -1) { my @a = @p; $a[$kk - 1] += $s; my @b = @q; $b[$kk - 1] += $s;
      if (exists $cube{join(',', @a)} && exists $cube{join(',', @b)}) { my $st = $kk == 4 ? 't' : $kk == 3 ? 'z' : 'inplane'; my $et = $d == 3 ? 'vert' : ($a[2] == 1 ? 'top' : 'bottom'); return "$st-middle-$et" } } }
    die "unclassified outside link $k" };
  my (%CLS, %CNT); for my $k (@OUTKEYS) { my $c = $classify->($k); push @{$CLS{$c}}, $k; $CNT{$c}++ }
  my @ORDER = ('t-near', 'inplane-near', 'z-near', 't-middle-top', 'z-middle-top', 'inplane-middle-top', 't-middle-vert', 'inplane-middle-vert', 't-far', 'inplane-far', 'z-far', 't-middle-bottom', 'z-middle-bottom', 'inplane-middle-bottom');
  my %EXP = ('t-near' => 8, 'inplane-near' => 8, 'z-near' => 4, 't-middle-top' => 8, 'z-middle-top' => 4, 'inplane-middle-top' => 4, 't-middle-vert' => 8, 'inplane-middle-vert' => 8, 't-far' => 8, 'inplane-far' => 8, 'z-far' => 4, 't-middle-bottom' => 8, 'z-middle-bottom' => 4, 'inplane-middle-bottom' => 4);
  my $cbad = 0; for my $c (@ORDER) { $cbad++ unless ($CNT{$c} // 0) == $EXP{$c} } $cbad++ unless scalar(keys %CNT) == 14; die "the class census is not the staked one" if $cbad;
  { my ($a, $b) = @{$CLS{'t-near'}}[0, -1]; my ($ra) = $resp->(\@d0, $OUT{$a}, 2 * $PI / 3, $p0, $e0); my ($rb) = $resp->(\@d0, $OUT{$b}, 2 * $PI / 3, $p0, $e0);
    printf "G33-QROW-CONTROL class label: t-near members %s and %s at 120 deg respond %.9f and %.9f [%s] (%d s)\n", $a, $b, $ra, $rb, abs($ra - $rb) < 1e-9 * (1 + abs($ra)) ? 'EQUAL' : 'UNEQUAL', time - $t0 }
  my (%SUP, %SUPT); for my $c (@ORDER) { my $lk = $OUT{$CLS{$c}[0]}; my ($mx, $mt, $tvx, $tvt) = (0, 0, 0, 0); my @prof;
    for my $th (@ANG) { my ($r, $t) = $resp->(\@d0, $lk, $th * $PI / 180, $p0, $e0); push @prof, sprintf('%g:%+.6f/%.5f', $th, $r, $t); if (abs($r) > $mx) { $mx = abs($r); $mt = $th } if ($t > $tvx) { $tvx = $t; $tvt = $th } }
    $SUP{$c} = $mx; $SUPT{$c} = $tvx; printf "G33-QROW-CLASS %s (%d links, rep %s): sup |dE[cos Phi_top]| = %.9f at %g deg; sup TV = %.9f at %g deg; profile %s (%d s)\n", $c, $CNT{$c}, $CLS{$c}[0], $mx, $mt, $tvx, $tvt, join(' ', @prof), time - $t0 }
  my ($near, $far, $tn, $tf) = (0, 0, 0, 0); for my $c (@ORDER) { my $v = $CNT{$c} * $SUP{$c}; my $w = $CNT{$c} * $SUPT{$c}; if ($c =~ /near|top|vert/) { $near += $v; $tn += $w } else { $far += $v; $tf += $w } }
  printf "G33-QROW-ROW beta=%g the quotient row of the top face at the symmetric datum: in E[cos Phi_top] (the SU(2) rows' unit halved) %.6f (near %.6f + far %.6f); in EXACT TOTAL VARIATION %.6f (near %.6f + far %.6f); E[cos Phi_top] %.6f  [%s] (%d s)\n", $beta, $near + $far, $near, $far, $tn + $tf, $tn, $tf, $e0, ($tn + $tf) < 1 ? 'TV-ROW-BELOW-1' : 'TV-ROW-AT-OR-ABOVE-1', time - $t0;
  POSIX::_exit(0) }
if ($MODE eq 'quotworst') { my @mid = map { $_->[1][0] } @{$DANG{'t0'}}; my @dc = @d0; my @want = (0, $PI, $PI / 2, -$PI / 2); $dc[$mid[$_]] = -$want[$_] for 0 .. 3;
  my ($sr, $si) = (0, 0); for my $pl (@{$DANG{'t0'}}) { my $a = stapleang($pl, \@dc); $sr += cos($a); $si += sin($a) } printf "G33-QWORST-KAT the staple sum of t0 at d_c = (%.1e, %.1e) [%s]\n", $sr, $si, sqrt($sr * $sr + $si * $si) < 1e-12 ? 'CANCELLED' : 'NOT-CANCELLED';
  my ($Zc, $ec, $cc) = lawof(ring(\@dc)); my $pc = density($cc); printf "G33-QWORST beta=%g E[cos Phi_top]: symmetric %.9f, cancelling d_c(t0) %.9f (TV between the two class laws %.6f) (%d s)\n", $beta, $e0, $ec, tv($pc, $p0), time - $t0;
  for my $series ([$mid[0], "the un-cancelling rotation of t0's first middle link"], [okey([1, 0, 1, 0], 3), "the z-near above (1,0,1), outside t0's staples"]) { my ($lk, $name) = @$series; my ($mx, $mt, $tvx, $tvt) = (0, 0, 0, 0); my @prof;
    for my $th (@ANG) { my ($r, $t) = $resp->(\@dc, $lk, $th * $PI / 180, $pc, $ec); push @prof, sprintf('%g:%+.6f/%.5f', $th, $r, $t); if (abs($r) > $mx) { $mx = abs($r); $mt = $th } if ($t > $tvx) { $tvx = $t; $tvt = $th } }
    printf "G33-QWORST-SERIES beta=%g link=%s (%s) at d_c: sup |dE[cos Phi_top]| = %.9f at %g deg; sup TV = %.9f at %g deg; profile %s (%d s)\n", $beta, $OUTKEYS[$lk], $name, $mx, $mt, $tvx, $tvt, join(' ', @prof), time - $t0 }
  POSIX::_exit(0) }
if ($MODE eq 'delta') { my %F; my @G = (0, map { $_ * $PI / 180 } @ANG);
  for my $gi (0 .. $#G) { for my $gp (0 .. $#G) { my @dd = @d0; $dd[$uf] += $G[$gi]; $dd[$un] += $G[$gp]; my ($Z) = lawof(ring(\@dd)); $F{$gi}{$gp} = -log($Z) } }
  my ($best, $bg) = (0, 0); for my $gp (1 .. $#G) { my ($mx, $mn) = (-1e9, 1e9); for my $gi (0 .. $#G) { my $m = $F{$gi}{$gp} - $F{$gi}{0}; $mx = $m if $m > $mx; $mn = $m if $m < $mn } if ($mx - $mn > $best) { $best = $mx - $mn; $bg = $gp } }
  # Delta_link: one link, six staples at angle 0 but two rotated by g and g': Z_1 = I_0(beta |4 + e^{ig} + e^{ig'}|)
  my $dl = 0; for my $gp (1 .. $#G) { my ($mx, $mn) = (-1e9, 1e9); for my $gi (0 .. $#G) { my ($sr, $si) = (4 + cos($G[$gi]) + cos($G[$gp]), sin($G[$gi]) + sin($G[$gp])); my ($sr0, $si0) = (5 + cos($G[$gi]), sin($G[$gi]));
      my $m = -log(bessel(0, $beta * sqrt($sr * $sr + $si * $si))) + log(bessel(0, $beta * sqrt($sr0 * $sr0 + $si0 * $si0))); $mx = $m if $m > $mx; $mn = $m if $m < $mn } $dl = $mx - $mn if $mx - $mn > $dl }
  printf "G33-DELTA beta=%g pair=far:near Delta_cube = %.9f (argmax g' = %g deg) Delta_link = %.9f ratio = %.4f; the single-link weight (I_1/I_0)(beta) = %.6f (%d s)\n", $beta, $best, $bg ? $ANG[$bg - 1] : 0, $dl, $dl > 0 ? $best / $dl : 0, ib(1) / ib(0), time - $t0; POSIX::_exit(0) }
die "unknown mode $MODE";
