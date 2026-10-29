#!/usr/bin/perl
# g17_mixed_survey.pl -- THE MIXED CASE OF THE SHARP ONE-LINK LEMMA, SURVEYED IN DOUBLES BEFORE ANY ENCLOSURE IS BUILT (ΠΕΝΤΑΠΥΛΟΝ G17,
# 2026-10-28 23:1x EDT, the desktop seat; the Yang-Mills seat's reduction of 01:5x).  For U ~ vMF(kappa) on S^3 and a unit vector e at angle
# alpha to the tilt axis, u = <U, e> has the EXACT marginal density  f(u) ∝ e^{kappa_1 u} sqrt(1-u^2) phi(kappa_2 sqrt(1-u^2)),  phi(z) = sinh z / z,
# kappa_1 = kappa cos alpha, kappa_2 = kappa sin alpha (the fibre over u is a 2-sphere of radius r = sqrt(1-u^2); Archimedes makes the v-marginal
# uniform; its exponential moment is phi).  The lemma's mixed case: F(kappa_1, kappa_2) := E|u - m| <= 4/(3 pi) on the whole quarter plane.
# THE SURVEY reads, on a grid: F, the partial derivatives by the exponential-family calculus (the kappa_1 score is u itself, so
# dF/dkappa_1 = 2 D_1, D_1 = A - V p with A = E[(u-m)^2; u > m], V = Var u, p = P(u > m); the kappa_2 score is l_2(u) = r psi(kappa_2 r),
# psi(z) = coth z - 1/z, so dF/dkappa_2 = Cov(l_2, |u-m|) - Cov(l_2, u)(p - q)), and at kappa_1 = 0 the one-parameter function
# D_1'(0; kappa_2) = T - 3 V H + V^2 f(0)  (T = E[u^3; u > 0], H = E[u; u > 0]) whose sign decides whether F falls along kappa_1 from the
# symmetric axis -- at kappa_2 = 0 it is -13/(120 pi) exactly (the axial case); in the Gaussian limit kappa_2 -> inf its three terms CANCEL
# at leading order, so the sign there is the base measure's non-Gaussian correction and must be read.
# usage: perl g17_mixed_survey.pl [N=20000] [K=20]
use strict; use warnings;
my ($N, $K) = @ARGV; $N //= 20000; $K //= 20; my $PI = 3.141592653589793; my $MAD0 = 4 / (3 * $PI);
my (@C, @S, @W0); for my $i (0 .. $N - 1) { my $th = $PI * ($i + 0.5) / $N; $C[$i] = cos($th); $S[$i] = sin($th); $W0[$i] = (2 / $PI) * $S[$i] ** 2 * ($PI / $N) }
sub phi { my $z = shift; return $z < 1e-6 ? 1 + $z * $z / 6 : (exp($z) - exp(-$z)) / (2 * $z) }
sub psi { my $z = shift; return $z < 1e-4 ? $z / 3 : (exp($z) + exp(-$z)) / (exp($z) - exp(-$z)) - 1 / $z }          # coth z - 1/z, the log-derivative of phi
sub law {                                                                                                                  # all the moments of the (k1, k2) law
  my ($k1, $k2) = @_; my (@w, $Z, $M1); $Z = 0; $M1 = 0; my $k2s = $k2 == 0 ? 0 : $k2;
  for my $i (0 .. $N - 1) { my $wt = exp($k1 * ($C[$i] - 1)) * phi($k2 * $S[$i]) / phi($k2) * $W0[$i]; $w[$i] = $wt; $Z += $wt; $M1 += $C[$i] * $wt }   # shifted by e^{-k1} phi(k2)^{-1}: no overflow
  my $m = $M1 / $Z; my ($V, $p, $A, $B, $H, $T, $M3, $F, $cl2F, $cl2u, $El2, $fm) = (0) x 12; my $qm = 0;
  for my $i (0 .. $N - 1) { my $d = $C[$i] - $m; my $wt = $w[$i] / $Z; $V += $d * $d * $wt; $F += abs($d) * $wt; $M3 += $d ** 3 * $wt;
    if ($d > 0) { $p += $wt; $A += $d * $d * $wt; $H += $d * $wt; $T += $d ** 3 * $wt } else { $B += $d * $d * $wt }
    my $l2 = $S[$i] * psi($k2 * $S[$i]); $El2 += $l2 * $wt; $cl2F += $l2 * abs($d) * $wt; $cl2u += $l2 * $d * $wt }
  $cl2F -= $El2 * $F;                                                                                                      # Cov(l2, |u-m|); Cov(l2, u-m) = cl2u already centred in u
  my $im = 0; my $best = 9; for my $i (0 .. $N - 1) { if (abs($C[$i] - $m) < $best) { $best = abs($C[$i] - $m); $im = $i } }
  $fm = $w[$im] / $Z / ((2 / $PI) * $S[$im] ** 2 * ($PI / $N)) * (2 / $PI) * $S[$im] ** 2 / $S[$im];                      # the density of u at m: f(u) = f_theta / |du/dtheta| = f_theta / sin
  my $D1 = $A - $V * $p; my $dF1 = 2 * $D1; my $dF2 = $cl2F - $cl2u * ($p - (1 - $p));
  return { m => $m, V => $V, p => $p, A => $A, B => $B, H => $H, T => $T, M3 => $M3, F => $F, D1 => $D1, dF1 => $dF1, dF2 => $dF2, fm => $fm, Dp0 => $T - 3 * $V * $H + $V * $V * $fm } }
printf "G17-SURVEY N=%d, kappa to %g; MAD(0) = 4/(3 pi) = %.8f; the quarter plane (kappa_1, kappa_2) read on a log grid\n", $N, $K, $MAD0;
my @grid = (0, 0.01, 0.03, 0.1, 0.3, 0.5, 1, 1.5, 2, 3, 4, 6, 8, 10, 14, 20); my ($maxF, $argF, $pos1, $pos2, $n) = (-1, '', 0, 0, 0); my (@pos1, @pos2);
for my $k1 (@grid) { for my $k2 (@grid) { next if $k1 == 0 && $k2 == 0; my $L = law($k1, $k2); $n++;
  if ($L->{F} > $maxF) { $maxF = $L->{F}; $argF = "k1=$k1 k2=$k2" }
  if ($k1 > 0 && $L->{dF1} >= 0) { $pos1++; push @pos1, sprintf("(%g,%g):%.2e", $k1, $k2, $L->{dF1}) }
  if ($k2 > 0 && $L->{dF2} >= 0) { $pos2++; push @pos2, sprintf("(%g,%g):%.2e", $k1, $k2, $L->{dF2}) }
  printf "G17-CELL k1=%-5g k2=%-5g F=%.8f  (4/3pi - F)=%.3e  m=%.6f V=%.6f p=%.5f  dF/dk1=%+.3e  dF/dk2=%+.3e\n", $k1, $k2, $L->{F}, $MAD0 - $L->{F}, $L->{m}, $L->{V}, $L->{p}, $L->{dF1}, $L->{dF2} if $k1 == 0 || $k2 == 0 || ($k1 == $k2) || $k1 == 0.3 || $k2 == 0.3 || $k1 == 3 || $k2 == 3 } }
printf "G17-MAX  F over %d cells: %.8f at %s  (%s 4/(3 pi) = %.8f)\n", $n, $maxF, $argF, $maxF < $MAD0 ? 'BELOW' : 'NOT BELOW', $MAD0;
printf "G17-SIGN dF/dkappa_1 >= 0 at %d cells%s\n", $pos1, $pos1 ? ': ' . join(' ', @pos1) : ' (F falls along kappa_1 at every cell read)';
printf "G17-SIGN dF/dkappa_2 >= 0 at %d cells%s\n", $pos2, $pos2 ? ': ' . join(' ', @pos2) : ' (F falls along kappa_2 at every cell read)';
printf "G17-AXIS D_1'(0; kappa_2) = T - 3VH + V^2 f(0) on the symmetric axis kappa_1 = 0 (at kappa_2 = 0 exactly -13/(120 pi) = %.8f):\n", -13 / (120 * $PI);
for my $k2 (0, 0.1, 0.3, 0.5, 1, 1.5, 2, 3, 4, 6, 8, 10, 14, 20, 30, 50) { my $L = law(0, $k2); printf "G17-AXIS k2=%-4g D1'(0)=%+.6e  (x k2^{3/2} = %+.5f)  T=%.6f V=%.6f H=%.6f f(0)=%.5f  F=%.8f\n", $k2, $L->{Dp0}, $L->{Dp0} * ($k2 > 0 ? $k2 ** 1.5 : 1), $L->{T}, $L->{V}, $L->{H}, $L->{fm}, $L->{F} }
