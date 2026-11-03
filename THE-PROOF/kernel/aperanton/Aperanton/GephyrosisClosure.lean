import Aperanton.GephyrosisAutomaton

/-!
# ΓΕΦΥΡΩΣΙΣ — THEOREM D, the closure (Addendum IV §6), generically

The profile step of the one-digit automaton is max-plus and, once no linear term attains a
maximum, HOMOGENEOUS: shifting every pole order by `c` shifts the next profile by `2c`, and scaling
the residues by a unit `λ` scales the next residues by `λ²` (the residue step is a homogeneous
quadratic map). So if the automaton's state at step `M + L` is the state at step `M` shifted by
`c` and scaled by `λ`, then for every `i` the state at `M + L + i` is the state at `M + i` shifted
by `c·2^i` and scaled by `λ^{2^i}`: the normalised state `(d, [r])` is periodic, the top of the
profile obeys `T(s + L) = T(s) + c·2^{s−M}` forever, and top-liveness is periodic forever.

**THEOREM D.** If the orbit of the normalised state closes at `M < M + L` and the top is live at
every phase of one turn, the block law holds with EQUALITY at every step `s ≥ M`, forever.

With Theorem T this turns a finite computation — `M + L` steps of the automaton, each a handful
of integers — into a statement about every step of the exact rational orbit
(`law_of_top`), and a dead top into a strict inequality (`break_of_dead`).
-/

namespace Gephyrosis

/-! ## Shifts of the profile, scalings of the residue -/

theorem getD_map_add (t : List ℤ) (c : ℤ) (k : ℕ) (hk : k < t.length) :
    (t.map (· + c)).getD k 0 = t.getD k 0 + c := by
  rw [List.getD_eq_getElem?_getD, List.getD_eq_getElem?_getD, List.getElem?_map,
    List.getElem?_eq_getElem hk]
  rfl

/-- the residues scaled by `lam` modulo `p` -/
def scaleR (p lam : ℕ) (r : List ℕ) : List ℕ := r.map fun x => (lam * x) % p

theorem getD_scaleR (p lam : ℕ) (r : List ℕ) (k : ℕ) (hk : k < r.length) :
    (scaleR p lam r).getD k 0 = (lam * r.getD k 0) % p := by
  unfold scaleR
  rw [List.getD_eq_getElem?_getD, List.getD_eq_getElem?_getD, List.getElem?_map,
    List.getElem?_eq_getElem hk]
  rfl

theorem foldl_max_map_add (l : List ℤ) (b d : ℤ) :
    (l.map (· + d)).foldl max (b + d) = l.foldl max b + d := by
  induction l generalizing b with
  | nil => rfl
  | cons c l ih =>
    simp only [List.map_cons, List.foldl_cons]
    rw [max_add_add_right]
    exact ih (max b c)

theorem maxL_map_add (l : List ℤ) (hl : l ≠ []) (d : ℤ) :
    maxL (l.map (· + d)) = maxL l + d := by
  cases l with
  | nil => exact absurd rfl hl
  | cons a l =>
    simp only [maxL, List.map_cons]
    exact foldl_max_map_add l a d

/-! ## Well-formed roads and non-attaining linear terms -/

/-- every coordinate is fed, and every term's inputs are coordinates -/
def Wellformed (R : Road) : Prop :=
  ∀ k < R.n, R.tb.getD k [] ≠ [] ∧ ∀ tm ∈ R.tb.getD k [], tm.a < R.n ∧ tm.b < R.n

def wfCheck (R : Road) : Bool :=
  (List.range R.n).all fun k =>
    decide (R.tb.getD k [] ≠ []) &&
      (R.tb.getD k []).all fun tm => decide (tm.a < R.n) && decide (tm.b < R.n)

theorem wellformed_of_check (R : Road) (h : wfCheck R = true) : Wellformed R := by
  intro k hk
  unfold wfCheck at h
  rw [List.all_eq_true] at h
  have h1 := h k (List.mem_range.2 hk)
  simp only [Bool.and_eq_true, decide_eq_true_eq, List.all_eq_true] at h1
  exact h1

/-- the linear term of no coordinate attains the maximum at profile `t` -/
def NonAttain (R : Road) (p : ℕ) (t : List ℤ) : Prop :=
  ∀ k < R.n, lamOf R k = 0 ∨ lscale p t (lamOf R k) k < qmax R p t k

def naCheck (R : Road) (p : ℕ) (t : List ℤ) : Bool :=
  (List.range R.n).all fun k =>
    decide (lamOf R k = 0) || decide (lscale p t (lamOf R k) k < qmax R p t k)

theorem nonAttain_of_check (R : Road) (p : ℕ) (t : List ℤ) (h : naCheck R p t = true) :
    NonAttain R p t := by
  intro k hk
  unfold naCheck at h
  rw [List.all_eq_true] at h
  have h1 := h k (List.mem_range.2 hk)
  simpa using h1

/-! ## Homogeneity of one step -/

theorem qscale_shift (p : ℕ) (t : List ℤ) (D c : ℤ) (tm : Term)
    (ha : tm.a < t.length) (hb : tm.b < t.length) :
    qscale p (t.map (· + c)) D tm = qscale p t D tm + 2 * c := by
  unfold qscale
  rw [getD_map_add t c _ ha, getD_map_add t c _ hb]
  ring

theorem lscale_shift (p : ℕ) (t : List ℤ) (lam c : ℤ) (k : ℕ) (hk : k < t.length) :
    lscale p (t.map (· + c)) lam k = lscale p t lam k + c := by
  unfold lscale
  rw [getD_map_add t c k hk]
  ring

theorem qmax_shift (R : Road) (p : ℕ) (t : List ℤ) (c : ℤ) (k : ℕ) (hk : k < R.n)
    (hwf : Wellformed R) (hlen : t.length = R.n) :
    qmax R p (t.map (· + c)) k = qmax R p t k + 2 * c := by
  obtain ⟨hne, hidx⟩ := hwf k hk
  unfold qmax
  have hmap : (R.tb.getD k []).map (qscale p (t.map (· + c)) (R.D k))
      = ((R.tb.getD k []).map (qscale p t (R.D k))).map (· + 2 * c) := by
    rw [List.map_map]
    apply List.map_congr_left
    intro tm hm
    obtain ⟨ha, hb⟩ := hidx tm hm
    exact qscale_shift p t (R.D k) c tm (by omega) (by omega)
  rw [hmap, maxL_map_add _ (by simpa using hne)]

theorem qmax_le_tNext (R : Road) (p : ℕ) (t : List ℤ) (k : ℕ) :
    qmax R p t k ≤ tNext R p t k := by
  unfold tNext
  split_ifs
  · exact le_rfl
  · exact le_max_right _ _

theorem tNext_shift (R : Road) (p : ℕ) (t : List ℤ) (c : ℤ) (k : ℕ) (hk : k < R.n)
    (hwf : Wellformed R) (hlen : t.length = R.n) (hc : 0 ≤ c) (hna : NonAttain R p t) :
    tNext R p (t.map (· + c)) k = tNext R p t k + 2 * c := by
  unfold tNext
  rw [qmax_shift R p t c k hk hwf hlen]
  split_ifs with hl
  · rfl
  · rw [lscale_shift p t _ c k (by omega)]
    rcases hna k hk with h | h
    · exact absurd h hl
    · rw [max_eq_right (show lscale p t (lamOf R k) k + c ≤ qmax R p t k + 2 * c by linarith),
        max_eq_right (show lscale p t (lamOf R k) k ≤ qmax R p t k by linarith)]

theorem nonAttain_shift (R : Road) (p : ℕ) (t : List ℤ) (c : ℤ) (hwf : Wellformed R)
    (hlen : t.length = R.n) (hc : 0 ≤ c) (hna : NonAttain R p t) :
    NonAttain R p (t.map (· + c)) := by
  intro k hk
  rcases hna k hk with h | h
  · exact Or.inl h
  · right
    rw [lscale_shift p t _ c k (by omega), qmax_shift R p t c k hk hwf hlen]
    linarith

theorem linRes_zero (R : Road) (p : ℕ) (t : List ℤ) (r : List ℕ) (k : ℕ) (hk : k < R.n)
    (hna : NonAttain R p t) : linRes R p t r k = 0 := by
  unfold linRes
  rcases hna k hk with h | h
  · rw [if_neg (fun h' => h'.1 h)]
  · have := qmax_le_tNext R p t k
    rw [if_neg (fun h' => by have := h'.2; linarith)]

section Scaling

variable {p : ℕ} [hp : Fact p.Prime]

theorem quadRes_shift_scale (R : Road) (t : List ℤ) (r : List ℕ) (c : ℤ) (lam : ℕ) (k : ℕ)
    (hk : k < R.n) (hwf : Wellformed R) (hlen : t.length = R.n) (hrlen : r.length = R.n)
    (hc : 0 ≤ c) (hna : NonAttain R p t) :
    ((quadRes R p (t.map (· + c)) (scaleR p lam r) k : ℕ) : ZMod p)
      = (lam : ZMod p) ^ 2 * ((quadRes R p t r k : ℕ) : ZMod p) := by
  unfold quadRes
  rw [tNext_shift R p t c k hk hwf hlen hc hna]
  rw [Nat.cast_list_sum, Nat.cast_list_sum, List.map_map, List.map_map, ← List.sum_map_mul_left]
  apply congrArg List.sum
  apply List.map_congr_left
  intro tm hm
  obtain ⟨ha, hb⟩ := (hwf k hk).2 tm hm
  simp only [Function.comp]
  rw [qscale_shift p t (R.D k) c tm (by omega) (by omega), getD_scaleR p lam r _ (by omega),
    getD_scaleR p lam r _ (by omega)]
  simp only [add_left_inj]
  split_ifs
  · push_cast [ZMod.natCast_mod]
    ring
  · simp

theorem rNext_shift_scale (R : Road) (t : List ℤ) (r : List ℕ) (c : ℤ) (lam : ℕ) (k : ℕ)
    (hk : k < R.n) (hwf : Wellformed R) (hlen : t.length = R.n) (hrlen : r.length = R.n)
    (hc : 0 ≤ c) (hna : NonAttain R p t) :
    rNext R p (t.map (· + c)) (scaleR p lam r) k = (lam ^ 2 * rNext R p t r k) % p := by
  have hcast : ((rNext R p (t.map (· + c)) (scaleR p lam r) k : ℕ) : ZMod p)
      = (((lam ^ 2 * rNext R p t r k) % p : ℕ) : ZMod p) := by
    rw [ZMod.natCast_mod, Nat.cast_mul, Nat.cast_pow, rNext_cast, rNext_cast,
      linRes_zero R p _ _ k hk (nonAttain_shift R p t c hwf hlen hc hna),
      linRes_zero R p t r k hk hna, quadRes_shift_scale R t r c lam k hk hwf hlen hrlen hc hna]
    push_cast
    ring
  have h1 : rNext R p (t.map (· + c)) (scaleR p lam r) k < p := Nat.mod_lt _ hp.out.pos
  have h2 : (lam ^ 2 * rNext R p t r k) % p < p := Nat.mod_lt _ hp.out.pos
  have h3 := (ZMod.natCast_eq_natCast_iff' _ _ _).mp hcast
  rwa [Nat.mod_eq_of_lt h1, Nat.mod_eq_of_lt h2] at h3

theorem autoStep_shift_scale (R : Road) (t : List ℤ) (r : List ℕ) (c : ℤ) (lam : ℕ)
    (hwf : Wellformed R) (hlen : t.length = R.n) (hrlen : r.length = R.n)
    (hc : 0 ≤ c) (hna : NonAttain R p t) :
    autoStep R p (t.map (· + c), scaleR p lam r)
      = ((autoStep R p (t, r)).1.map (· + 2 * c), scaleR p (lam ^ 2) (autoStep R p (t, r)).2) := by
  unfold autoStep scaleR
  simp only [List.map_map]
  refine Prod.ext ?_ ?_
  · apply List.map_congr_left
    intro k hk
    rw [List.mem_range] at hk
    exact tNext_shift R p t c k hk hwf hlen hc hna
  · apply List.map_congr_left
    intro k hk
    rw [List.mem_range] at hk
    exact rNext_shift_scale R t r c lam k hk hwf hlen hrlen hc hna

theorem orbit_len (R : Road) (c0 : List ℤ) (s : ℕ) :
    (autoOrbit R p c0 s).1.length = R.n ∧ (autoOrbit R p c0 s).2.length = R.n := by
  cases s with
  | zero => simp [autoOrbit, autoInit]
  | succ s => simp [autoOrbit, autoStep]

theorem res_lt (R : Road) (c0 : List ℤ) (s k : ℕ) : (autoOrbit R p c0 s).2.getD k 0 < p := by
  cases s with
  | zero =>
    show ((List.range R.n).map _).getD k 0 < p
    rw [getD_map_range]
    split_ifs
    · have h0 : (0 : ℤ) ≤ c0.getD k 0 % (p : ℤ) :=
        Int.emod_nonneg _ (by exact_mod_cast hp.out.ne_zero)
      have h1 : c0.getD k 0 % (p : ℤ) < p := Int.emod_lt_of_pos _ (by exact_mod_cast hp.out.pos)
      omega
    · exact hp.out.pos
  | succ s =>
    show ((List.range R.n).map _).getD k 0 < p
    rw [getD_map_range]
    split_ifs
    · exact Nat.mod_lt _ hp.out.pos
    · exact hp.out.pos

/-! ## THEOREM D: the closure -/

/-- THEOREM D, the closure. A turn that returns shifted and scaled returns forever. -/
theorem closure (R : Road) (c0 : List ℤ) (hwf : Wellformed R) (M L : ℕ) (hL : 0 < L)
    (c : ℤ) (hc : 0 ≤ c) (lam : ℕ)
    (hclose : autoOrbit R p c0 (M + L)
      = ((autoOrbit R p c0 M).1.map (· + c), scaleR p lam (autoOrbit R p c0 M).2))
    (hNA : ∀ i < L, NonAttain R p (autoOrbit R p c0 (M + i)).1) :
    ∀ i, autoOrbit R p c0 (M + L + i)
        = ((autoOrbit R p c0 (M + i)).1.map (· + c * 2 ^ i),
            scaleR p (lam ^ 2 ^ i) (autoOrbit R p c0 (M + i)).2)
      ∧ NonAttain R p (autoOrbit R p c0 (M + i)).1 := by
  intro i
  induction i using Nat.strong_induction_on with
  | _ i ih =>
    have hna_i : NonAttain R p (autoOrbit R p c0 (M + i)).1 := by
      by_cases hi : i < L
      · exact hNA i hi
      · have hiL : i - L < i := by omega
        obtain ⟨heq, hna'⟩ := ih (i - L) hiL
        have hMi : M + i = M + L + (i - L) := by omega
        rw [hMi, heq]
        exact nonAttain_shift R p _ _ hwf (orbit_len R c0 _).1 (by positivity) hna'
    refine ⟨?_, hna_i⟩
    cases i with
    | zero => simpa using hclose
    | succ i =>
      obtain ⟨heq, hna⟩ := ih i (Nat.lt_succ_self i)
      have h1 : autoOrbit R p c0 (M + L + (i + 1))
          = autoStep R p (autoOrbit R p c0 (M + L + i)) := by
        rw [show M + L + (i + 1) = (M + L + i) + 1 by omega]
        rfl
      have h2 : autoOrbit R p c0 (M + (i + 1)) = autoStep R p (autoOrbit R p c0 (M + i)) := by
        rw [show M + (i + 1) = (M + i) + 1 by omega]
        rfl
      rw [h1, h2, heq, autoStep_shift_scale R _ _ _ _ hwf (orbit_len R c0 _).1
        (orbit_len R c0 _).2 (by positivity) hna]
      rw [show c * 2 ^ (i + 1) = 2 * (c * 2 ^ i) by ring,
        show lam ^ 2 ^ (i + 1) = (lam ^ 2 ^ i) ^ 2 by rw [← pow_mul, pow_succ]]

/-! ## The top of the profile and its liveness -/

/-- `T(s)`, the largest pole-order bound at step `s` -/
def topOf (R : Road) (p : ℕ) (c0 : List ℤ) (s : ℕ) : ℤ := maxL (autoOrbit R p c0 s).1

/-- the top is LIVE at step `s`: some coordinate at the top has a nonzero residue -/
def TopLive (R : Road) (p : ℕ) (c0 : List ℤ) (s : ℕ) : Prop :=
  ∃ k < R.n, (autoOrbit R p c0 s).1.getD k 0 = topOf R p c0 s ∧
    (autoOrbit R p c0 s).2.getD k 0 ≠ 0

def topLiveB (R : Road) (st : List ℤ × List ℕ) : Bool :=
  (List.range R.n).any fun k => decide (st.1.getD k 0 = maxL st.1) && decide (st.2.getD k 0 ≠ 0)

theorem topLive_of_check (R : Road) (c0 : List ℤ) (s : ℕ)
    (h : topLiveB R (autoOrbit R p c0 s) = true) : TopLive R p c0 s := by
  unfold topLiveB at h
  rw [List.any_eq_true] at h
  obtain ⟨k, hk, hk'⟩ := h
  rw [List.mem_range] at hk
  simp only [Bool.and_eq_true, decide_eq_true_eq] at hk'
  exact ⟨k, hk, hk'.1, hk'.2⟩

theorem topDead_of_check (R : Road) (c0 : List ℤ) (s : ℕ)
    (h : topLiveB R (autoOrbit R p c0 s) = false) : ¬ TopLive R p c0 s := by
  rintro ⟨k, hk, h1, h2⟩
  unfold topOf at h1
  have h' : topLiveB R (autoOrbit R p c0 s) = true := by
    unfold topLiveB
    rw [List.any_eq_true]
    exact ⟨k, List.mem_range.2 hk, by
      rw [Bool.and_eq_true, decide_eq_true_eq, decide_eq_true_eq]
      exact ⟨h1, h2⟩⟩
  rw [h] at h'
  exact Bool.false_ne_true h'

theorem top_shift (R : Road) (c0 : List ℤ) (hwf : Wellformed R) (M L : ℕ) (hL : 0 < L)
    (c : ℤ) (hc : 0 ≤ c) (lam : ℕ)
    (hclose : autoOrbit R p c0 (M + L)
      = ((autoOrbit R p c0 M).1.map (· + c), scaleR p lam (autoOrbit R p c0 M).2))
    (hNA : ∀ i < L, NonAttain R p (autoOrbit R p c0 (M + i)).1) (hn : 0 < R.n) (i : ℕ) :
    topOf R p c0 (M + L + i) = topOf R p c0 (M + i) + c * 2 ^ i := by
  unfold topOf
  rw [(closure R c0 hwf M L hL c hc lam hclose hNA i).1]
  exact maxL_map_add _ (List.ne_nil_of_length_pos (by rw [(orbit_len (p := p) R c0 _).1]; exact hn)) _

theorem topLive_shift (R : Road) (c0 : List ℤ) (hwf : Wellformed R) (M L : ℕ) (hL : 0 < L)
    (c : ℤ) (hc : 0 ≤ c) (lam : ℕ) (hlam : ¬ p ∣ lam)
    (hclose : autoOrbit R p c0 (M + L)
      = ((autoOrbit R p c0 M).1.map (· + c), scaleR p lam (autoOrbit R p c0 M).2))
    (hNA : ∀ i < L, NonAttain R p (autoOrbit R p c0 (M + i)).1) (hn : 0 < R.n) (i : ℕ) :
    TopLive R p c0 (M + L + i) ↔ TopLive R p c0 (M + i) := by
  have hcl := (closure R c0 hwf M L hL c hc lam hclose hNA i).1
  have hlen1 := (orbit_len (p := p) R c0 (M + i)).1
  have hlen2 := (orbit_len (p := p) R c0 (M + i)).2
  unfold TopLive
  rw [top_shift R c0 hwf M L hL c hc lam hclose hNA hn i]
  constructor
  · rintro ⟨k, hk, h1, h2⟩
    refine ⟨k, hk, ?_, ?_⟩
    · rw [hcl] at h1
      dsimp only at h1
      rw [getD_map_add _ _ k (by omega)] at h1
      linarith
    · rw [hcl] at h2
      dsimp only at h2
      rw [getD_scaleR _ _ _ k (by omega)] at h2
      intro h0
      apply h2
      rw [h0, mul_zero, Nat.zero_mod]
  · rintro ⟨k, hk, h1, h2⟩
    refine ⟨k, hk, ?_, ?_⟩
    · rw [hcl]
      dsimp only
      rw [getD_map_add _ _ k (by omega)]
      linarith
    · rw [hcl]
      dsimp only
      rw [getD_scaleR _ _ _ k (by omega)]
      intro h0
      have hd : p ∣ lam ^ 2 ^ i * (autoOrbit R p c0 (M + i)).2.getD k 0 :=
        Nat.dvd_of_mod_eq_zero h0
      rcases (Nat.Prime.dvd_mul hp.out).mp hd with h | h
      · exact hlam (hp.out.dvd_of_dvd_pow h)
      · exact h2 (Nat.eq_zero_of_dvd_of_lt h (res_lt (p := p) R c0 _ k))

/-! ## The readings of the exact orbit -/

theorem getD_le_top (R : Road) (c0 : List ℤ) (s k : ℕ) (hk : k < R.n) :
    (autoOrbit R p c0 s).1.getD k 0 ≤ topOf R p c0 s := by
  unfold topOf
  apply le_maxL
  have hlen := (orbit_len (p := p) R c0 s).1
  rw [List.getD_eq_getElem?_getD, List.getElem?_eq_getElem (by omega)]
  exact List.getElem_mem _

/-- THE LAW AT A LIVE TOP: every nonzero coordinate has pole order at most `T(s)` and some
coordinate has pole order exactly `T(s)`. -/
theorem law_of_top (R : Road) (hD : ∀ k < R.n, R.D k ≠ 0) (c0 : List ℤ) (s : ℕ)
    (hlive : TopLive R p c0 s) :
    (∀ k < R.n, (ratOrbit R c0 s).getD k 0 ≠ 0 →
        -padicValRat p ((ratOrbit R c0 s).getD k 0) ≤ topOf R p c0 s) ∧
    (∃ k < R.n, (ratOrbit R c0 s).getD k 0 ≠ 0 ∧
        -padicValRat p ((ratOrbit R c0 s).getD k 0) = topOf R p c0 s) := by
  refine ⟨fun k hk hne => ?_, ?_⟩
  · have ht := getD_le_top (p := p) R c0 s k hk
    by_cases hr : (autoOrbit R p c0 s).2.getD k 0 = 0
    · rcases pole_of_dead R hD c0 s k hr with h | h
      · exact absurd h hne
      · linarith
    · have := (pole_of_live R hD c0 s k hr (res_lt (p := p) R c0 s k)).2
      linarith
  · obtain ⟨k, hk, h1, h2⟩ := hlive
    obtain ⟨hne, hv⟩ := pole_of_live R hD c0 s k h2 (res_lt (p := p) R c0 s k)
    exact ⟨k, hk, hne, by rw [hv, h1]; ring⟩

/-- THE BREAK AT A DEAD TOP: every nonzero coordinate has pole order strictly below `T(s)`. -/
theorem break_of_dead (R : Road) (hD : ∀ k < R.n, R.D k ≠ 0) (c0 : List ℤ) (s : ℕ)
    (hdead : ¬ TopLive R p c0 s) :
    ∀ k < R.n, (ratOrbit R c0 s).getD k 0 ≠ 0 →
      -padicValRat p ((ratOrbit R c0 s).getD k 0) ≤ topOf R p c0 s - 1 := by
  intro k hk hne
  have ht := getD_le_top (p := p) R c0 s k hk
  by_cases hr : (autoOrbit R p c0 s).2.getD k 0 = 0
  · rcases pole_of_dead R hD c0 s k hr with h | h
    · exact absurd h hne
    · linarith
  · have hlt : (autoOrbit R p c0 s).1.getD k 0 < topOf R p c0 s := by
      rcases lt_or_eq_of_le ht with h | h
      · exact h
      · exact absurd ⟨k, hk, h, hr⟩ hdead
    have := (pole_of_live R hD c0 s k hr (res_lt (p := p) R c0 s k)).2
    linarith

end Scaling


/-! ## The orbit as one list, for linear-time certificates

A certificate that asks `autoOrbit R p c0 s` for every `s ≤ N` makes the kernel recompute each
state from the seed, `N²/2` steps in all. `orbitAux` walks the orbit ONCE; `orbit_check` reads a
predicate verified on the list back onto `autoOrbit`. -/

/-- `[st, step st, …, stepⁿ st]` -/
def orbitAux (R : Road) (p : ℕ) : ℕ → (List ℤ × List ℕ) → List (List ℤ × List ℕ)
  | 0, st => [st]
  | n + 1, st => st :: orbitAux R p n (autoStep R p st)

theorem orbitAux_length (R : Road) (p : ℕ) :
    ∀ (n : ℕ) (st : List ℤ × List ℕ), (orbitAux R p n st).length = n + 1 := by
  intro n
  induction n with
  | zero => intro st; rfl
  | succ n ih => intro st; simp [orbitAux, ih]

theorem orbitAux_getD (R : Road) (p : ℕ) (c0 : List ℤ) :
    ∀ (n s0 i : ℕ), i ≤ n →
      (orbitAux R p n (autoOrbit R p c0 s0)).getD i ([], []) = autoOrbit R p c0 (s0 + i) := by
  intro n
  induction n with
  | zero =>
    intro s0 i hi
    have : i = 0 := by omega
    subst this
    rfl
  | succ n ih =>
    intro s0 i hi
    cases i with
    | zero => rfl
    | succ i =>
      have h1 : orbitAux R p (n + 1) (autoOrbit R p c0 s0)
          = autoOrbit R p c0 s0 :: orbitAux R p n (autoOrbit R p c0 (s0 + 1)) := rfl
      rw [h1, List.getD_cons_succ, ih (s0 + 1) i (by omega)]
      congr 1
      omega

/-- `f` holds at every indexed state of the list -/
def checkOrbit (f : ℕ → (List ℤ × List ℕ) → Bool) : ℕ → List (List ℤ × List ℕ) → Bool
  | _, [] => true
  | s, st :: rest => f s st && checkOrbit f (s + 1) rest

theorem checkOrbit_spec (f : ℕ → (List ℤ × List ℕ) → Bool) :
    ∀ (l : List (List ℤ × List ℕ)) (s0 : ℕ), checkOrbit f s0 l = true →
      ∀ i < l.length, f (s0 + i) (l.getD i ([], [])) = true := by
  intro l
  induction l with
  | nil => intro s0 _ i hi; simp at hi
  | cons st rest ih =>
    intro s0 h i hi
    simp only [checkOrbit, Bool.and_eq_true] at h
    cases i with
    | zero => simpa using h.1
    | succ i =>
      rw [List.getD_cons_succ]
      have := ih (s0 + 1) h.2 i (by simpa using hi)
      rwa [show s0 + (i + 1) = s0 + 1 + i by omega]

/-- reading a certificate verified on the orbit list back onto the orbit -/
theorem orbit_check (R : Road) (p : ℕ) (c0 : List ℤ) (N : ℕ) (f : ℕ → (List ℤ × List ℕ) → Bool)
    (h : checkOrbit f 0 (orbitAux R p N (autoInit R p c0)) = true) :
    ∀ s ≤ N, f s (autoOrbit R p c0 s) = true := by
  intro s hs
  have := checkOrbit_spec f _ 0 h s (by rw [orbitAux_length]; omega)
  rw [show autoInit R p c0 = autoOrbit R p c0 0 from rfl, orbitAux_getD R p c0 N 0 s hs] at this
  simpa using this

end Gephyrosis
