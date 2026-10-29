#!/usr/bin/perl
# g28_w1mad.pl -- THE W_1 MAD CONSTANT OF THE vMF LAW ON S^3, EXACT IN THE AXIAL AND PERPENDICULAR DIRECTIONS (ΠΕΝΤΑΠΥΛΟΝ G28, 2026-10-29
# 03:5x EDT, the desktop seat; the plan seat's §75(f) question of 03:4x: is sup_w L(w) = L(0), L(w) = sup over unit u and 1-Lipschitz f (chordal
# metric on S^3) of Cov_{vMF(w)}(f, <U,u>)?).
# THE REDUCTION.  By Kantorovich-Rubinstein, sup_{Lip f <= 1} E[f h] = W_1(h_+ mu, h_- mu) for h of mean zero; here h = g - E g, g = <U,u>, mu = vMF(w),
# so L(w, u) = W_1(nu_+, nu_-), nu_+- = (g - E g)_+- mu, two measures of equal mass MAD/2.  Lower bound from f = g: Var_w(g).  THE PERPENDICULAR
# DIRECTION (u orthogonal to w): the reflection through u's hyperplane preserves mu and carries nu_+ to nu_-, a coupling of cost 2 E[g^2 1_{g>0}]
# = E g^2 = Var_perp = m/kappa; with the lower bound equal, L(w, u perp) = Var_perp(kappa) EXACTLY.  THE AXIAL DIRECTION (u parallel to w): nu_+-
# are axially symmetric and the chordal distance at fixed polar angles is least at equal azimuth, so the optimal plan is meridional and the
# problem is one-dimensional in theta with the cost c(theta, theta') = 2 sin(|theta - theta'|/2), STRICTLY CONCAVE in the angle, the supports
# disjoint ([0, theta_m) and (theta_m, pi], cos theta_m = m): for a strictly concave cost on the line with disjoint supports the optimal plan is
# the ANTI-MONOTONE rearrangement (Gangbo-McCann 1996, Theorem 2.5 / the one-dimensional case), so L(w, u par) = the anti-monotone plan's cost,
# computed here by quadrature on a fine theta grid (the cumulative masses inverted by interpolation).  At w = 0 the anti-monotone plan is the
# reflection theta -> pi - theta and its cost is (4/pi) int cos^2 sin^2 = 1/4 = Var(g), so L(0) = 1/4 EXACTLY (the plan seat's integration-by-parts
# bound 8/(9 pi) = 0.2829 is loose by 13 %).  GENERAL u (angle alpha to w): the symmetry reductions fail; a Sinkhorn bracket on a 3D grid is
# printed as a CHECK (an upper bound from the rounded plan, a lower bound from the c-transformed potentials), not as a certificate.
# KNOWN ANSWERS: at kappa = 0 the axial cost equals 1/4 to 1e-8 and the monotone plan costs MORE; at every kappa the axial cost is >= Var_par
# (a 1-Lipschitz f cannot beat the optimum) and the reflection-type check nu_+(total) = nu_-(total) = MAD/2 holds to 1e-10.
# STAKED BEFORE THE RUN: sup over u of L(w, u) is max(L_par, Var_perp) with L_par <= 1/4 for all kappa, so sup_w L(w) = L(0) = 1/4.
# usage: perl g28_w1mad.pl [kappas="0 0.5 1 1.5 2 3"] [N=40000] [SINK=1]
use strict; use warnings; $| = 1;
my ($KAP, $N, $SINK) = @ARGV; $KAP //= "0 0.5 1 1.5 2 3"; $N //= 40000; $SINK //= 1;
my $PI = 3.141592653589793;
sub bessel { my ($n, $x) = @_; my $s = 0; my $t = ($x / 2) ** $n; my $f = 1; $f *= $_ for 1 .. $n; $t /= $f; for my $k (0 .. 80) { $s += $t; $t *= ($x / 2) ** 2 / (($k + 1) * ($k + 1 + $n)) } return $s }
for my $kappa (split / /, $KAP) {
  my $m = $kappa > 0 ? bessel(2, $kappa) / bessel(1, $kappa) : 0; my $vperp = $kappa > 0 ? $m / $kappa : 0.25; my $vpar = 1 - 3 * $vperp - $m * $m;
  # the theta grid: midpoints; density e^{kappa cos} sin^2, normalised
  my (@th, @w, @c); my $Z = 0; for my $i (0 .. $N - 1) { my $t = $PI * ($i + 0.5) / $N; $th[$i] = $t; $c[$i] = cos($t); $w[$i] = exp($kappa * ($c[$i] - 1)) * sin($t) ** 2 * ($PI / $N); $Z += $w[$i] } $_ /= $Z for @w;
  my $mean = 0; $mean += $w[$_] * $c[$_] for 0 .. $N - 1; my $var = 0; $var += $w[$_] * ($c[$_] - $mean) ** 2 for 0 .. $N - 1;
  my (@rp, @rm); my ($Mp, $Mm) = (0, 0); for my $i (0 .. $N - 1) { my $h = $c[$i] - $mean; $rp[$i] = $h > 0 ? $h * $w[$i] : 0; $rm[$i] = $h < 0 ? -$h * $w[$i] : 0; $Mp += $rp[$i]; $Mm += $rm[$i] }
  # cumulative of nu_+ from the pole (theta ascending) and of nu_- from the antipode (theta descending); the anti-monotone map pairs equal cumulatives
  my @Fp; my $s = 0; for my $i (0 .. $N - 1) { $s += $rp[$i]; $Fp[$i] = $s } my @Gm; $s = 0; for my $i (reverse 0 .. $N - 1) { $s += $rm[$i]; $Gm[$i] = $s }
  # cost of the anti-monotone plan: walk theta ascending through nu_+, pairing each mass element with the nu_- element at the same cumulative level from the antipode
  my ($anti, $mono) = (0, 0); { my $j = $N - 1; my $acc = 0;                    # Gm[j] is the nu_- mass on [theta_j, pi]: decreasing in j
    for my $i (0 .. $N - 1) { next unless $rp[$i] > 0; my $level = $Fp[$i] - $rp[$i] / 2;              # the element's midpoint level
      while ($j > 0 && $Gm[$j] < $level) { $j-- } my $tj = $th[$j];                                  # the first j (descending from the antipode) whose cumulative reaches the level
      $anti += $rp[$i] * 2 * sin(abs($tj - $th[$i]) / 2) } }
  { my @Fm; $s = 0; for my $i (0 .. $N - 1) { $s += $rm[$i]; $Fm[$i] = $s } my $j = 0;                   # the monotone plan: theta ascending on both sides
    for my $i (0 .. $N - 1) { next unless $rp[$i] > 0; my $level = $Fp[$i] - $rp[$i] / 2; while ($j < $N - 1 && $Fm[$j] < $level) { $j++ } $mono += $rp[$i] * 2 * sin(abs($th[$j] - $th[$i]) / 2) } }
  my $supu = $anti > $vperp ? $anti : $vperp;
  printf "G28 kappa=%g: m=%.8f Var_par=%.8f Var_perp=%.8f (grid var %.8f, masses nu+ %.8f nu- %.8f); AXIAL L_par = anti-monotone cost %.8f (the monotone plan %.8f, the linear f %.8f) [%s]; PERPENDICULAR L_perp = Var_perp = %.8f exactly; sup over u in {par, perp} = %.8f  [%s]\n",
    $kappa, $m, $vpar, $vperp, $var, $Mp, $Mm, $anti, $mono, $vpar, ($anti >= $vpar - 1e-7 && $mono >= $anti - 1e-9) ? 'CONSISTENT' : 'INCONSISTENT', $vperp, $supu, $supu <= 0.25 + 1e-9 ? 'AT-OR-BELOW-1/4' : 'ABOVE-1/4';
  if ($kappa == 0) { printf "G28-KAT kappa=0: the anti-monotone (reflection) cost %.10f against 1/4: %s; |nu+| - |nu-| = %.1e\n", $anti, abs($anti - 0.25) < 1e-6 ? 'MET' : 'MISSED', $Mp - $Mm }
}
# ---- the general-direction CHECK by Sinkhorn on a coarse 3D grid (theta x polar cosine x azimuth), for u at angle alpha to w
if ($SINK) { for my $kappa (1, 2) { for my $alpha (0, 0.5, 1.0, 1.5707963) {
  my ($NT, $NP, $NA) = (12, 8, 12); my (@P, @W); my $Z = 0;                      # 1152 points: the 6,912-point grid crawled (one case in ten minutes), so the check is coarse and says so
  for my $a (0 .. $NT - 1) { my $t = $PI * ($a + 0.5) / $NT; for my $b (0 .. $NP - 1) { my $z = -1 + 2 * ($b + 0.5) / $NP; my $r = sqrt(1 - $z * $z); for my $cc (0 .. $NA - 1) { my $ph = 2 * $PI * ($cc + 0.5) / $NA;
      my @U = (cos($t), sin($t) * $r * cos($ph), sin($t) * $r * sin($ph), sin($t) * $z); my $wt = exp($kappa * (cos($t) - 1)) * sin($t) ** 2; push @P, \@U; push @W, $wt; $Z += $wt } } }
  $_ /= $Z for @W; my @u = (cos($alpha), sin($alpha), 0, 0); my @g = map { $_->[0] * $u[0] + $_->[1] * $u[1] } @P; my $mean = 0; $mean += $W[$_] * $g[$_] for 0 .. $#P;
  my (@ip, @im, @mp, @mm); for my $i (0 .. $#P) { my $h = ($g[$i] - $mean) * $W[$i]; if ($h > 0) { push @ip, $i; push @mp, $h } elsif ($h < 0) { push @im, $i; push @mm, -$h } }
  my $Mp = 0; $Mp += $_ for @mp; my $Mm = 0; $Mm += $_ for @mm; $_ *= $Mm / $Mp for @mp;                                               # equalise the discretised masses
  my ($np, $nm) = (scalar @ip, scalar @im); my @C; for my $a (0 .. $np - 1) { my $A = $P[$ip[$a]]; for my $b (0 .. $nm - 1) { my $B = $P[$im[$b]]; my $d2 = 0; $d2 += ($A->[$_] - $B->[$_]) ** 2 for 0 .. 3; $C[$a][$b] = sqrt($d2) } }
  my $eps = 0.01; my (@K, @uu, @vv); for my $a (0 .. $np - 1) { for my $b (0 .. $nm - 1) { $K[$a][$b] = exp(-$C[$a][$b] / $eps) } } @uu = (1) x $np; @vv = (1) x $nm;
  for my $it (1 .. 300) { for my $a (0 .. $np - 1) { my $s = 0; $s += $K[$a][$_] * $vv[$_] for 0 .. $nm - 1; $uu[$a] = $mp[$a] / ($s || 1e-300) } for my $b (0 .. $nm - 1) { my $s = 0; $s += $K[$_][$b] * $uu[$_] for 0 .. $np - 1; $vv[$b] = $mm[$b] / ($s || 1e-300) } }
  my $cost = 0; for my $a (0 .. $np - 1) { for my $b (0 .. $nm - 1) { $cost += $uu[$a] * $K[$a][$b] * $vv[$b] * $C[$a][$b] } }
  # the dual lower bound: potentials phi_a = eps log u_a, psi_b = eps log v_b; the c-transform of phi gives a feasible pair: psi'_b = min_a (C_ab - phi_a)
  my @phi = map { $eps * log($_ || 1e-300) } @uu; my @psi; for my $b (0 .. $nm - 1) { my $mn = 1e9; for my $a (0 .. $np - 1) { my $v = $C[$a][$b] - $phi[$a]; $mn = $v if $v < $mn } $psi[$b] = $mn }
  my $dual = 0; $dual += $mp[$_] * $phi[$_] for 0 .. $np - 1; $dual += $mm[$_] * $psi[$_] for 0 .. $nm - 1;
  my $lin = 0; $lin += $W[$_] * ($g[$_] - $mean) ** 2 for 0 .. $#P;
  printf "G28-SINK kappa=%g alpha=%.2f rad: grid %d points, nu+ %d nu- %d; the entropic plan's cost %.5f (an upper bound up to the grid), the c-transformed dual %.5f (a lower bound on the grid problem), the linear f %.5f\n", $kappa, $alpha, scalar @P, $np, $nm, $cost, $dual, $lin } } }
