/* ---- cei_face (the author, 2026-11-02 17:3x EST): THE SINGLE-PATH FACE FIBRE BY SUBSTITUTION, exact in epsilon (campaign §31.10-§31.11).
   With CEI_SUBST=1 (n = 2 only) each of the seven coarse edges of the two loops -- a straight path of two fine links, U_p^{sp} U_e^{se} = c in
   the loop's order -- has its last link e eliminated: U_e^{se} = U_p^{-sp} c.  Every cycle's step on e with sign tau becomes a step on p:
   tau = se gives D(U_p^{-sp} . c . M) (the constant c BEFORE the step's datum multipliers M); tau = -se gives D(c^-1 U_p^{sp} M), the c^-1
   folded into the preceding step's right multiplier AFTER its own.  The eliminated link's staples become the partner's "inverse staples",
   read at U_e = (U_p^{-sp} c)^{se}.  The loop cycles are DROPPED (their holonomies are constants of the fibre), which keeps every link within
   the engine's four slots.  The fine observables come from PER-PLAQUETTE SOURCE WEIGHTS: a plaquette tilted by chi_1 closes with
   FAC[s-1] + FAC[s+1], so <1/2 tr U_p> = Z'_p / (2 Z) and the connected pair is Z''_pq/(4Z) - Z'_p Z'_q/(4 Z^2), four sweeps.
   Unset, every byte of the output is w2e.c's. ---- */
static int CEI = 0;                                                   /* CEI_SUBST=1 */
static quat CEIC = { 1, 0, 0, 0 };                                    /* the coarse datum c (CEI_C="w:x:y:z", a unit quaternion; the identity unset) */
static int STEPPRE[MAXCYC][MAXSTEP], STEPPOST[MAXCYC][MAXSTEP];       /* constant multipliers: PRE before the datum multipliers, POST after */
static quat STEPPREQ[MAXCYC][MAXSTEP], STEPPOSTQ[MAXCYC][MAXSTEP];
static int ELIM[MAXL], NELIM = 0;                                     /* the eliminated links */
static int NISTAP[MAXL], ISTAP[MAXL][8][3][2], ISIGP[MAXL][8], ISIGE[MAXL][8];   /* the partner's inverse staples: the eliminated link's staples, with the path signs */
static double PFAC[MAXCYC][32];                                       /* per-cycle closing weights: FAC, or the chi_1 source on a source plaquette */
static int NSRC = 0, SRC[2];                                          /* CEI_SRC="p" or "p,q": face plaquette indices 0..NP-1 */
static int CEIORD[MAXL], NCEIORD = 0;                                 /* CEI_ORDER=<file>: "x y z d" per line (ordsub's best order), eliminated links skipped */
static int CLAMPC = -1, CLAMPS = -1, CLAMPWA = -1, CLAMPWB = -1;      /* CEI_CLAMP="cycle:wireA:wireB" (campaign §31.13, lead 2): one cycle's spin and two of its wires fixed per slice, the slices summed outside -- an exact rearrangement of the sum that takes the peak from (sum d_s^2)^K to (sum d_s^2)^(K-1) */
static int PEAKLIST = 0;                                              /* CEI_PEAK=1: list the open wires at the peak step, with their cycles */
static int PROFILE = 0;                                               /* CEI_PROFILE=1: one line per step of the first sweep -- the state's size, the open cycles with their open-wire counts */
static int BRANCH = 1;                                                /* the source branch: the configurations share the sweep up to the first source closing (CEI_NOBRANCH=1 runs each whole) */
static int SELFON = 0, KSELF = 0, ELIMOF[MAXL];                       /* CEI_SELF=<file> (campaign 31.14, lead 1 in its diagonal form): per object link "x y z d kappa", the exterior's Gaussian
                                                                         self-energy as an effective staple count -- the link's weight exp(kappa beta (1/2 tr U - 1)) in characters to KSELF
                                                                         (CEI_KSELF, WMAX + 4 unset) in place of its staples at a datum; an eliminated link's rides on its partner's value */
static double KEFF[MAXL], FS[MAXL][32];
static int STRIPK = 0;                                                /* CEI_STRIP=K (campaign 31.15): the object a planar strip of K coarse cells (faces f = 0..K-1 at x in [-(f-1)n - n, -(f-1)n],
                                                                         face 0 EI's face A, face 1 EI's planar face B), K loops, 3K + 1 coarse edges; the substitution eliminates one link per
                                                                         edge; the two-point function along the strip at separations fn + 1 between face 0's far column and face f's */
