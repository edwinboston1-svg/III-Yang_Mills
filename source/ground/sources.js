// Citation forms used in the footnotes of THE GROUND: the first use of a source prints it in full, later uses print a short form.
const REPO = 'https://github.com/ethanwsussman/Yang--Mills-LLM-experiment';
const forms = {
  clay: ['A. Jaffe and E. Witten, "Quantum Yang–Mills theory", official problem description of the Clay Mathematics Institute, https://www.claymath.org/wp-content/uploads/2022/06/yangmills.pdf',
         'Jaffe and Witten, *op. cit.*'],
  readme: [`L. Alpöge and E. Sussman, README of the repository *Yang--Mills-LLM-experiment*, ${REPO} (repository created 6 October 2026, 09:51:17 UTC; README last changed 26 October 2026, 16:18:10 UTC; read 28 October 2026).`,
           'README of the repository, *op. cit.*'],
  counts: [`Measured by counting the page breaks of the text extracted from each file of ${REPO}: YM3/YMM1.pdf, 854 pages (posted 26 October 2026, 02:10 UTC); YM3/Revisions/YMM1-2026-10-26.pdf, 856; YM3/YMM2.pdf, 1,044 (posted 27 October 2026, 01:14 UTC); QED3/qed3.pdf, 263; RPM1.pdf, 30; ym4_manuscript_zeroth_draft.pdf, 153.`,
           'Page counts measured as stated in the Introduction.'],
  woit: ['P. Woit, "Secret Unified Physics Slop", *Not Even Wrong*, 26 October 2026, with its updates and comments, https://www.math.columbia.edu/~woit/wordpress/?p=15948 (read 28 October 2026).',
         'Woit, *op. cit.*'],
  ymm1: ['*YMM1*, "Scalar fields from three-dimensional lattice Yang–Mills theory", YM3/YMM1.pdf and its source YM3/YMM1.tex in the repository,',
         '*YMM1*,'],
  ym4: ['*The zeroth draft*, "SU(2) Yang–Mills theory in four dimensions via Balaban\'s renormalisation group: construction, axioms and non-triviality", dated 6 October 2026, ym4_manuscript_zeroth_draft.pdf in the repository,',
        '*The zeroth draft*,'],
};
const used = {};
const out = { REPO, changes: 'YM3/Revisions/CHANGES-2026-10-26.md in the repository',
  ymm2: '*YMM2*, "Curvature observables, dynamics, and conditional confinement in three-dimensional lattice Yang–Mills theory", YM3/YMM2.pdf in the repository,' };
for (const k of Object.keys(forms)) {
  Object.defineProperty(out, k, { get() { if (!used[k]) { used[k] = true; return forms[k][0]; } return forms[k][1]; } });
}
Object.defineProperty(out, 'ymm1short', { get() { return out.ymm1; } });
Object.defineProperty(out, 'ym4short', { get() { return out.ym4; } });
module.exports = out;
