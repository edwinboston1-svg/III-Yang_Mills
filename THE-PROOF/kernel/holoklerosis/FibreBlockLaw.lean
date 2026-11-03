/-
  ΟΛΟΚΛΗΡΩΣΙΣ -- THE COMPLETION, Addendum IV: THE LAW OF THE BLOCKED GAUSSIAN FIBRE IN THE BARE LEAN 4 KERNEL.
  No import, no axiom, no sorry, no native_decide: every theorem is proved by `decide`, the kernel's own reduction the whole verification.
  THE OBJECTS.  P_n(x) = 2 T_n(x/2), the Chebyshev product polynomial: the identity prod_{c<n} (x - 2 cos(theta + 2 pi c/n)) = P_n(x) - 2 cos(n theta)
  is classical; the finite pieces the kernel decides are (i) the three P_n as integer coefficient lists with their values and derivatives at 2
  (P_n(2) = 2, P_n'(2) = n^2, P_n''(2) = n^2 (n^2 - 1)/6 -- the csc^2 and csc^4 alias sums at K = 0), (ii) THE LAW: the csc^4 numerator
  6 n^4 - n^2 (n^2 - 1)(2 - u) equals n^2 ((n^2 - 1) u + (4 n^2 + 2)) as polynomials in u = 2 cos K, so the block-average variance vanishes
  at u = -(4 n^2 + 2)/(n^2 - 1), cosh kappa_n = (2 n^2 + 1)/(n^2 - 1), and (iii) THE SECOND ROAD: the longitudinal numerator
  N_n(w) = sum_{c<n} (w zeta^c)^2 prod_{c' != c} (w zeta^{c'} - 1)^4 over Z[zeta_n] = Z[x]/(x^{n/2} + 1) (zeta_2 = -1 in Z) -- the numerator of
  the alias sum sum_c |w zeta^c - 1|^{-4} over its common denominator (w^n - 1)^4, since |e^{i t} - 1|^{-4} = e^{2 i t} (e^{i t} - 1)^{-4} --
  computed by the kernel satisfies 3 N_n(w) = C_n w^n q_n(w^n), q_n(z) = (n^2 - 1) + 2 (2 n^2 + 1) z + (n^2 - 1) z^2, C_2 = 2, C_4 = 8, C_8 = 32:
  the law's quadratic in z = w^n, whose primitive part q_n/3 = (1, 6, 1), (5, 22, 5), (21, 86, 21) is what fibre_block.awk printed
  (fibre_block.2026-11-03a.txt).  Every number here is either a mathematical constant or the kernel's own result; nothing is read from a run.
  CONTROLS (the sighted negatives): the law's middle coefficient bent, and the content bent -- stated as inequalities the kernel decides.
  Page DOCS/III-HOLOKLEROSIS-THE-COMPLETION-PREREGISTRATION.md, Addendum IV.  Written by hand 2026-11-03; CUSTODY of the development's gate.
-/
set_option maxRecDepth 8192

/-! ## Polynomials over Int as coefficient lists, low degree first -/
def padd : List Int → List Int → List Int
  | [], q => q
  | p, [] => p
  | a :: p, b :: q => (a + b) :: padd p q

def pscale (c : Int) : List Int → List Int
  | [] => []
  | a :: p => c * a :: pscale c p

def pmul : List Int → List Int → List Int
  | [], _ => []
  | a :: p, q => padd (pscale a q) (0 :: pmul p q)

def peval (p : List Int) (x : Int) : Int :=
  match p with
  | [] => 0
  | a :: q => a + x * peval q x

def pderivAux : List Int → Nat → List Int
  | [], _ => []
  | a :: p, k => (Int.ofNat k) * a :: pderivAux p (k + 1)

def pderiv : List Int → List Int
  | [] => []
  | _ :: p => pderivAux p 1

/-! ## The Chebyshev product polynomials P_n(x) = 2 T_n(x/2) -/
def P2 : List Int := [-2, 0, 1]
def P4 : List Int := [2, 0, -4, 0, 1]
def P8 : List Int := [2, 0, -16, 0, 20, 0, -8, 0, 1]

-- (i) the alias sums at K = 0: P_n(2) = 2 (the product), P_n'(2) = n^2 (the csc^2 sum), P_n''(2) = n^2 (n^2 - 1)/6 (the csc^4 sum)
theorem P2_at2 : peval P2 2 = 2 := by decide
theorem P4_at2 : peval P4 2 = 2 := by decide
theorem P8_at2 : peval P8 2 = 2 := by decide
theorem P2_d1 : peval (pderiv P2) 2 = 4 := by decide
theorem P4_d1 : peval (pderiv P4) 2 = 16 := by decide
theorem P8_d1 : peval (pderiv P8) 2 = 64 := by decide
theorem P2_d2 : peval (pderiv (pderiv P2)) 2 = 2 := by decide
theorem P4_d2 : peval (pderiv (pderiv P4)) 2 = 40 := by decide
theorem P8_d2 : peval (pderiv (pderiv P8)) 2 = 672 := by decide
-- the second derivatives ARE n^2 (n^2 - 1)/6: 4*3/6 = 2, 16*15/6 = 40, 64*63/6 = 672
theorem d2_law_2 : 6 * 2 = 4 * (4 - 1) := by decide
theorem d2_law_4 : 6 * 40 = 16 * (16 - 1) := by decide
theorem d2_law_8 : 6 * 672 = 64 * (64 - 1) := by decide

/-! ## (ii) THE LAW: the csc^4 numerator 6 n^4 - n^2 (n^2 - 1)(2 - u) as a polynomial in u equals n^2 ((n^2 - 1) u + (4 n^2 + 2)) -/
-- 6 n^4 - n^2 (n^2 - 1)(2 - u) = [6 n^4 - 2 n^2 (n^2 - 1)] + n^2 (n^2 - 1) u
theorem law_2 : padd [6 * 16] (pscale (4 * 3) [-2, 1]) = pscale 4 [4 * 4 + 2, 4 - 1] := by decide
theorem law_4 : padd [6 * 256] (pscale (16 * 15) [-2, 1]) = pscale 16 [4 * 16 + 2, 16 - 1] := by decide
theorem law_8 : padd [6 * 4096] (pscale (64 * 63) [-2, 1]) = pscale 64 [4 * 64 + 2, 64 - 1] := by decide
-- the zero of (n^2 - 1) u + (4 n^2 + 2) is u = -(4 n^2 + 2)/(n^2 - 1): cosh kappa_n = (2 n^2 + 1)/(n^2 - 1) -- 3, 11/5, 43/21
theorem root_2 : (4 - 1) * (-(4 * 4 + 2)) + (4 * 4 + 2) * (4 - 1) = 0 := by decide
theorem cosh_2 : 2 * 3 * (4 - 1) = 4 * 4 + 2 := by decide
theorem cosh_4 : 2 * 33 = 4 * 16 + 2 ∧ 15 = 16 - 1 ∧ 33 * 5 = 11 * 15 := by decide
theorem cosh_8 : 2 * 129 = 4 * 64 + 2 ∧ 63 = 64 - 1 ∧ 129 * 21 = 43 * 63 := by decide

/-! ## (iii) THE SECOND ROAD over Z[zeta_n]: elements of Z[x]/(x^d + 1) as lists of d Ints -/
-- the ring Z[x]/(x^d + 1): addition componentwise, multiplication by convolution with x^d = -1
def zadd : List Int → List Int → List Int := padd

-- a direct convolution: the coefficient of x^m in a*b is sum_{i+j=m} a_i b_j, and x^m for m >= d is -x^{m-d}
def zmulAt (d : Nat) (a b : List Int) (m : Nat) : Int :=
  let rec go (i : Nat) (acc : Int) : Int :=
    match i with
    | 0 => acc
    | i' + 1 =>
      let ii := i'
      let ai := a.getD ii 0
      let bj := if m ≥ ii then b.getD (m - ii) 0 else 0
      let bjw := if m + d ≥ ii ∧ m + d - ii < d then b.getD (m + d - ii) 0 else 0   -- the wrapped part: i + j = m + d
      go i' (acc + ai * bj - ai * bjw)
  go d 0

def zmul (d : Nat) (a b : List Int) : List Int :=
  (List.range d).map (zmulAt d a b)

def zint (d : Nat) (v : Int) : List Int := v :: (List.replicate (d - 1) 0)

-- zeta^c as an element: x^c reduced by x^d = -1 (c < 2d)
def zpow (d : Nat) (c : Nat) : List Int :=
  (List.range d).map (fun i => if c < d then (if i = c then 1 else 0) else (if i = c - d then -1 else 0))

/-! polynomials in w over the ring: lists of elements, low degree first -/
def wadd (d : Nat) : List (List Int) → List (List Int) → List (List Int)
  | [], q => q
  | p, [] => p
  | a :: p, b :: q => zadd a b :: wadd d p q

def wscale (d : Nat) (c : List Int) : List (List Int) → List (List Int)
  | [] => []
  | a :: p => zmul d c a :: wscale d c p

def wmul (d : Nat) : List (List Int) → List (List Int) → List (List Int)
  | [], _ => []
  | a :: p, q => wadd d (wscale d a q) (zint d 0 :: wmul d p q)

def wpow (d : Nat) (p : List (List Int)) : Nat → List (List Int)
  | 0 => [zint d 1]
  | k + 1 => wmul d p (wpow d p k)

-- the factor (w zeta^c - 1) and the term (w zeta^c)^2 prod_{c' != c} (w zeta^{c'} - 1)^4, n = 2d
def lin (d : Nat) (c : Nat) : List (List Int) := [zint d (-1), zpow d c]

def prodOthers (d : Nat) (n : Nat) (c : Nat) : List (List Int) :=
  (List.range n).foldl (fun acc c' => if c' = c then acc else wmul d acc (wpow d (lin d c') 4)) [zint d 1]

def term (d : Nat) (n : Nat) (c : Nat) : List (List Int) :=
  wmul d (wpow d [zint d 0, zpow d c] 2) (prodOthers d n c)

def numerator (d : Nat) (n : Nat) : List (List Int) :=
  (List.range n).foldl (fun acc c => wadd d acc (term d n c)) []

-- THE LAW'S SHAPE in w, at the numerator's own length 4n - 1 (its degree is 2 + 4(n - 1)): C w^n q_n(w^n) with q_n(z) = (n^2 - 1) + 2(2n^2 + 1) z + (n^2 - 1) z^2,
-- as a ring-coefficient polynomial (every zeta-component zero); the middle coefficient is a parameter so the control below may bend it alone
def lawShapeMid (d : Nat) (n : Nat) (C : Int) (mid : Int) : List (List Int) :=
  let nn : Int := Int.ofNat (n * n)
  (List.range (4 * n - 1)).map (fun k =>
    if k = n then zint d (C * (nn - 1))
    else if k = 2 * n then zint d (C * mid)
    else if k = 3 * n then zint d (C * (nn - 1))
    else zint d 0)

def lawShape (d : Nat) (n : Nat) (C : Int) : List (List Int) :=
  lawShapeMid d n C (2 * (2 * Int.ofNat (n * n) + 1))

-- THE SECOND ROAD: 3 N_n(w) = C_n w^n q_n(w^n), C_2 = 2, C_4 = 8, C_8 = 32 -- q_n is divisible by 3 at every n prime to 3 (n^2 = 1 mod 3), and
-- q_n/3 = (1, 6, 1), (5, 22, 5), (21, 86, 21) is the primitive quadratic fibre_block.awk printed; the zero of q_n: z + 1/z = -2(2n^2+1)/(n^2-1),
-- cosh kappa_n = (2n^2 + 1)/(n^2 - 1).  n = 2: zeta_2 = -1 lives in Z itself (d = 1, Z[x]/(x + 1) = Z); n = 4: d = 2 (Z[i]); n = 8: d = 4 (Z[zeta_8]).
theorem numerator_2 : wscale 1 (zint 1 3) (numerator 1 2) = lawShape 1 2 2 := by decide
theorem numerator_4 : wscale 2 (zint 2 3) (numerator 2 4) = lawShape 2 4 8 := by decide
-- the n = 8 identity is some thirty times the n = 4 computation (n^3 d^2); the elaborator's default heartbeat limit (200000) is reached before its
-- evaluation ends, so it is raised for this one theorem -- the kernel re-checks the finished term as it does every other
set_option maxHeartbeats 1000000 in
theorem numerator_8 : wscale 4 (zint 4 3) (numerator 4 8) = lawShape 4 8 32 := by decide

-- THE SIGHTED CONTROLS (law 16): the law's middle coefficient bent 2(2n^2 + 1) -> 2(2n^2 - 1), the gate's qbbend tooth in the kernel's words, and the
-- content bent 2 -> 4; the kernel REFUSES both.  (A sign bend w zeta^c - 1 -> w zeta^c + 1 is NOT a control at n = 2: the fourth power is sign-blind
-- there, (w+1)^4 + (w-1)^4 either way -- law 20 (v), a symmetry shielding the defect; it is not planted.)
theorem control_qbbend_2 : wscale 1 (zint 1 3) (numerator 1 2) ≠ lawShapeMid 1 2 2 (2 * (2 * 4 - 1)) := by decide
theorem control_content_2 : wscale 1 (zint 1 3) (numerator 1 2) ≠ lawShape 1 2 4 := by decide
theorem control_law_2 : padd [6 * 16] (pscale (4 * 3) [-2, 1]) ≠ pscale 4 [4 * 4 - 2, 4 - 1] := by decide
