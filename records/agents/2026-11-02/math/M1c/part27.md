
### 2.7 RESULTS of the reruns with the leafless class included (record `rerun_omega.2026-11-02.txt`, 09:33–09:59)

Engine: `kp_cert_m1c.awk` md5 d16a81df… at the job's START; it gained three INERT modes during the job (Z1N/ZPN, their defaults, DRESSREF),
and the final engine (md5 9fcc99a2…) re-reads the 0.5100 and 0.5198 OMEGA point lines CHARACTER-IDENTICAL to the record's (checked).
(Ω-d) HELD: OMEGA unset, character-identical to M1's engine at 0.4764 (page and tree, α = 0.0044, F₀ = 20) and at the U″ point 0.3650.
(Ω-e) HELD: the engine's E[f_even⁶] at 0.4764, [0.00000000739318, 0.00000000739318], equals `feven_norm.awk`'s 512-bit enclosure
7.39318591407309933810·10⁻⁹ to its printed digits; ‖f_even‖₆ ≤ 0.0441372500 on both.
(Ω-f) HELD — the Ω term and every verdict:

| point (α) | w = ‖f_even‖₆e^{2α̃} | κ_Ω | ρ_Ω | T_Ω (n_Ω = 21) | LHS upper end with T_Ω |
|---|---|---|---|---|---|
| 0.3650 page U″ (0.0044) | 0.026940 | 0.0926 | 0.1478 | < 10⁻¹⁶ | 0.0043576 (unchanged) |
| 0.4764 page record (0.0044) | 0.045719 | 0.2465 | 0.2925 | 5.2·10⁻¹² | 0.0043833 (unchanged) |
| 0.5100 page conditional (0.0034) | 0.051907 | 0.3489 | 0.3679 | 7.2·10⁻¹⁰ | 0.0033872 (unchanged) |
| 0.5198 tree conditional (0.0039) | 0.054115 | 0.4090 | 0.4073 | 6.5·10⁻⁹ | 0.0038800 (unchanged) |

Verdicts with OMEGA = 1: U″ page 0.3650 PASS [0.0039, 0.0050] / 0.3652 FAIL; tree 0.3656 PASS [0.0038, 0.0051] / 0.3658 FAIL; the record's
table mode page 0.4764 PASS [0.0041, 0.0047] / 0.4766 FAIL; tree 0.4816 PASS [0.0041, 0.0052] / 0.4818 FAIL; conditional page 0.5100 PASS
[0.0033, 0.0038] / 0.5102 FAIL; tree 0.5198 PASS [0.0036, 0.0043] / 0.5200 FAIL — the record's and M1R's windows to the grid digit. (At
0.5102 and 0.5200 the scan's LAST α, 0.0120, is refused by the Ω dressing's own convergence edge, "no kappa-bar for the leafless dressing
below 2", far outside every passing window; the verdicts are the record's.)
(Ω-g) THE PRICE OF n_Ω (a reading): at 0.5100 page, α = 0.0034, the Ω term alone refuses the verdict if Ω had members of ≤ 11
plaquettes (NOM = 11: LHS 0.0034030 > α; NOM = 10: 0.0034303; NOM = 8: 0.0037058; NOM = 6: 0.0057409) and passes from NOM = 12 on
(0.0033930). The census's n_Ω ≥ 22 clears it by ten plaquettes.
**So: the leafless class was an uncovered class of Theorem 8.9's Kotecký–Preiss sum; priced (Finner + the first-closed-set count + the
census n_Ω ≥ 22), it adds at most 7·10⁻⁹ to the left side at every number of record, and no threshold — 0.3650/0.3656 S12-free,
0.4764/0.4816 of record, 0.5100/0.5198 conditional — moves.**
