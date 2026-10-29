// Build THE GROUND (Edwin Boston III) as a Word document.
// Usage: node build.js <output.docx>
const fs = require('fs');
const L = require('./lib.js');
const { d, FONT, runs, P, P0, H1, H2, Break, Spacer, footnotes } = L;
const { Document, Packer, Paragraph, TextRun, AlignmentType, Header, Footer, PageNumber,
  TableOfContents, LevelFormat, BorderStyle, PageBreak } = d;

const out = process.argv[2];
if (!out) { console.error('usage: node build.js <output.docx>'); process.exit(2); }

const center = (markup, size, extra = {}) => new Paragraph({
  children: runs(markup, { size, ...extra }), alignment: AlignmentType.CENTER, spacing: { after: extra.after ?? 120, before: extra.before ?? 0 },
});

// ---------- title page ----------
const title = [
  new Paragraph({ children: [], spacing: { before: 2000 } }),
  new Paragraph({ children: [new TextRun({ text: 'THE GROUND', bold: true, size: 56, font: FONT, characterSpacing: 60 })], alignment: AlignmentType.CENTER, spacing: { after: 360 } }),
  center('Yang–Mills Theory after the Alpöge–Sussman Manuscripts', 30, { after: 120 }),
  center('*What Is Constructed, What Is Claimed, and the Object That Remains*', 25, { after: 720 }),
  new Paragraph({ children: [], border: { bottom: { style: BorderStyle.SINGLE, size: 6, color: '8C8C8C', space: 1 } }, indent: { left: 2880, right: 2880 }, spacing: { after: 480 } }),
  center('Edwin Boston III', 28, { after: 120 }),
  center('28 October 2026 · revised 29 October 2026', 22, { after: 960 }),
  new Paragraph({ children: [new TextRun({ text: 'Abstract', bold: true, size: 22, font: FONT })], alignment: AlignmentType.CENTER, spacing: { after: 120 } }),
  new Paragraph({
    children: runs(`A proof that quantum Yang–Mills theory has a mass gap must stand on a construction of the theory, and the most complete public construction now in view is the corpus of manuscripts that Levent Alpöge and Ethan Sussman have posted since 6 October 2026, carrying Bałaban's renormalisation group from the lattice to the continuum for the gauge group SU(2). This paper fixes that ground. It reads the corpus from its primary sources and proves, clause by clause and with exact references, what the corpus asserts and at what strength. In three dimensions an 854-page manuscript asserts continuum Schwinger functions of the plaquette-energy density, the lattice form of tr F², which satisfy the Osterwalder–Schrader axioms in the clustering components of infinite-volume limits taken along subsequences, together with a short-distance law that makes the theory non-trivial; it asserts no mass gap. In four dimensions a 153-page draft deduces, from inputs it declares clause by clause and from supporting statements two of which are not yet written, continuum limits on ℝ⁴ along subsequences with regularity, reflection positivity, symmetry and hypercubic invariance; its authors call the underlying argument extremely long and not understandable as it stands, and state that the corpus has not been satisfactorily vetted. The paper then proves that, for a reflection-positive theory, a mass gap is the same property as exponential clustering of the reflection-positive correlations, and that a lower bound on the lattice mass gap, uniform in physical units along the lattice sequence of such a construction, supplies at once the three properties the corpus withholds: a unique vacuum, the cluster property and a mass gap. It then reduces that bound to two finite statements: if, at a fixed physical scale, the blocked measure satisfies Dobrushin's condition with an exponential weight and the field inside the blocks clusters at the block scale, both uniformly in the cutoff, then every limit point has a unique vacuum and a mass gap of at least min(κ, log(1/ρ′))/a_c; the open mathematics of the problem is thereby two statements about one block at the crossover scale, stated in the form that is uniform in the cutoff, and the paper says why the form on the fine measure's blocks is not. Finally it proves a theorem at the strong end: for the SU(2) Wilson theory on ℤ⁴ at β ≤ 0.241, an exact decimation of one link in every plaquette and Dobrushin's criterion, with constants that Turán's inequality for the modified Bessel functions makes exact, give a unique infinite-volume Gibbs measure, exponential clustering and a mass gap of the lattice theory (Theorem 8.7). The theorem lies at strong coupling; the interval between it and the crossover is the open part of the problem, and the object on which the proof that follows must stand.`, { size: 20 }),
    alignment: AlignmentType.JUSTIFIED, indent: { left: 720, right: 720 }, spacing: { after: 120, line: 264 },
  }),
];

// ---------- contents ----------
const contents = [
  new Paragraph({ children: [new TextRun({ text: 'Contents', bold: true, size: 28, font: FONT })], spacing: { after: 200 }, pageBreakBefore: true }),
  new TableOfContents('Contents', { hyperlink: true, headingStyleRange: '1-2' }),
];

// ---------- body ----------
const body = [
  ...require('./content1.js')(L),
  ...require('./content2.js')(L),
  ...require('./content3.js')(L),
  ...require('./content4.js')(L),
];

// ---------- sources and records ----------
const S = require('./sources.js');
const ref = (n, markup) => new Paragraph({
  children: [new TextRun({ text: `[${n}]\t`, size: 19, font: FONT }), ...runs(markup, { size: 19 })],
  indent: { left: 540, hanging: 540 }, spacing: { after: 70, line: 250 }, alignment: AlignmentType.LEFT,
});
const sources = [
  H1('Sources', { pageBreakBefore: true }),
  P0('Every source was read on 28 October 2026. The repository sources are cited by file name; the repository is at ' + S.REPO + '.', { after: 160 }),
  ref(1, 'A. Jaffe and E. Witten, "Quantum Yang–Mills theory", official problem description, Clay Mathematics Institute; in *The Millennium Prize Problems*, Clay Mathematics Institute and American Mathematical Society, 2006; https://www.claymath.org/wp-content/uploads/2022/06/yangmills.pdf.'),
  ref(2, 'L. Alpöge and E. Sussman, repository *Yang--Mills-LLM-experiment*: README.md (last changed 26 October 2026, 16:18:10 UTC); YM3/YMM1.pdf and YM3/YMM1.tex, "Scalar fields from three-dimensional lattice Yang–Mills theory", 854 pages; YM3/Revisions/YMM1-2026-10-26.pdf, 856 pages, and YM3/Revisions/CHANGES-2026-10-26.md; YM3/YMM2.pdf, "Curvature observables, dynamics, and conditional confinement in three-dimensional lattice Yang–Mills theory", 1,044 pages; ym4_manuscript_zeroth_draft.pdf, "SU(2) Yang–Mills theory in four dimensions via Balaban\'s renormalisation group: construction, axioms and non-triviality", 6 October 2026, 153 pages; QED3/qed3.pdf, 263 pages; RPM1.pdf, 30 pages; theorem_0_complete_account_raw_I–III.tex. Repository created 6 October 2026, 09:51:17 UTC; most recent commit 27 October 2026, 10:45:28 UTC.'),
  ref(3, 'P. Woit, "Secret Unified Physics Slop", *Not Even Wrong*, 26 October 2026, with its updates and its comments through 28 October 2026, https://www.math.columbia.edu/~woit/wordpress/?p=15948.'),
  ref(4, 'K. Osterwalder and R. Schrader, "Axioms for Euclidean Green\'s functions", *Comm. Math. Phys.* 31 (1973), 83–112; "Axioms for Euclidean Green\'s functions. II", *Comm. Math. Phys.* 42 (1975), 281–305.'),
  ref(5, 'K. Osterwalder and E. Seiler, "Gauge field theories on a lattice", *Ann. Physics* 110 (1978), 440–471.'),
  ref(6, 'K. G. Wilson, "Confinement of quarks", *Phys. Rev. D* 10 (1974), 2445–2459.'),
  ref(7, 'M. Lüscher, "Construction of a selfadjoint, strictly positive transfer matrix for Euclidean lattice gauge theories", *Comm. Math. Phys.* 54 (1977), 283–292.'),
  ref(8, 'T. Bałaban, "Ultraviolet stability of three-dimensional lattice pure gauge field theories", *Comm. Math. Phys.* 102 (1985), 255–275; "Renormalization group approach to lattice gauge field theories. I. Generation of effective actions in a small field approximation and a coupling constant renormalization in four dimensions", *Comm. Math. Phys.* 109 (1987), 249–301; "Large field renormalization. II. Localization, exponentiation, and bounds for the R operation", *Comm. Math. Phys.* 122 (1989), 355–392; and the further papers of the series in *Comm. Math. Phys.* 95–122 (1984–1989).'),
  ref(9, 'B. K. Driver, "YM₂: continuum expectations, lattice convergence, and lassos", *Comm. Math. Phys.* 123 (1989); L. Gross, C. King and A. Sengupta, "Two dimensional Yang–Mills theory via stochastic differential equations", *Ann. Physics* 194 (1989).'),
  ref(10, 'J. Glimm and A. Jaffe, *Quantum Physics: A Functional Integral Point of View*, 2nd ed., Springer, 1987.'),
  ref(11, 'R. Jentzsch, "Über Integralgleichungen mit positivem Kern", *J. Reine Angew. Math.* 141 (1912), 235–244.'),
  ref(12, 'R. L. Dobrushin, "Central limit theorem for nonstationary Markov chains. I, II", *Theory Probab. Appl.* 1 (1956), 65–80 and 329–383.'),
  ref(13, 'I. Gelfand, "Normierte Ringe", *Mat. Sbornik* 9 (51) (1941), 3–24.'),
  ref(14, 'J. J. Sylvester, "A demonstration of the theorem that every homogeneous quadratic polynomial is reducible by real orthogonal substitutions to the form of a sum of positive and negative squares", *Philosophical Magazine* 4 (1852), 138–142.'),
  ref(15, 'F. J. Wegner, "Duality in generalized Ising models and phase transitions without local order parameters", *J. Math. Phys.* 12 (1971), 2259–2272.'),
  ref(16, 'H. Arisue and K. Tabata, "Low-temperature series for the correlation length in d = 3 Ising model", *Nucl. Phys.* B435 (1995), 555–566.'),
  ref(17, 'R. L. Dobrushin, "Prescribing a system of random variables by conditional distributions", *Theory Probab. Appl.* 15 (1970), 458–486.'),
  ref(18, 'H.-O. Georgii, *Gibbs Measures and Phase Transitions*, de Gruyter Studies in Mathematics 9, second edition, de Gruyter, Berlin, 2011; Chapter 8, Theorem 8.20.'),
  ref(19, 'M. Faizal and A. Shabir, "Reflection-Positive Construction of a Four-Dimensional SU(N) Yang–Mills Theory with Mass Gap and Confinement", arXiv:2606.19362 [hep-lat], 9 June 2026, 593 pages; *Fortschritte der Physik* 74 (2026), e70097, doi 10.1002/prop.70097; with four companion papers in *Int. J. Geom. Methods Mod. Phys.* (2026) cited therein.'),
  ref(20, 'A. H. Guth, "Existence proof of a nonconfining phase in four-dimensional U(1) lattice gauge theory", *Phys. Rev. D* 21 (1980), 2291–2307.'),
  ref(21, 'J. Fröhlich and T. Spencer, "Massless phases and symmetry restoration in abelian gauge theories and spin systems", *Comm. Math. Phys.* 83 (1982), 411–454.'),
  ref(22, 'E. T. Tomboulis, "Confinement for all values of the coupling in four-dimensional SU(2) gauge theory", arXiv:0707.2179 [hep-th], 2007; reply to Ito and Seiler, arXiv:0712.2620, 2007.'),
  ref(23, 'K. R. Ito and E. Seiler, "On the recent paper on quark confinement by Tomboulis", arXiv:0711.4930 [hep-th], 2007; "Further discussion of Tomboulis\' approach to the confinement problem", arXiv:0803.3019 [hep-th], 2008.'),
  H2('Records of the computations of Edwin Boston III'),
  P0('Each record is held, with its instrument and its run of record, in the repository of Edwin Boston III.', { after: 120 }),
  ref('R1', '*The shadow ladder* (Proposition 8.3): record g6_tube.2026-10-28a, with its instrument g6_tube.pl; landed in commit aea98a3af; re-derived in the run of record pentapylon_gate.2026-10-28r, nine arms, nineteen mutant tests, verdict GREEN.'),
  ref('R2', '*The gap by counting* (§8.2): record g6_inertia.2026-10-28b; run of record pentapylon_gate.2026-10-28r, verdict GREEN; landed in commit e11e1269c. The independently certified intervals it meets: run of record tomeus_gate.2026-10-27e, ten arms, ten mutant tests, verdict GREEN.'),
  ref('R3', '*The gap through duality* (§8.2): the dual-road records of 28 October 2026 and record g6_ising_anchor.2026-10-28a; landed in commit 44be883de with the run pentapylon_gate.2026-10-28q, eight arms, seventeen mutant tests, verdict GREEN; re-derived in run r.'),
  ref('R5', '*The chain lemma* (Proposition 8.2): instrument g9_chain.pl and record g9_chain.2026-10-29a; landed in commit 103e8425a; run of record pentapylon_gate.2026-10-28s, twelve arms, twenty-five mutant tests, verdict GREEN.'),
  ref('R6', '*The sharp one-link lemma, the certified descent and the transform on a tube* (§§8.1, 8.2, 8.3): instruments g18_mad_lemma.pl with g17_mixed_survey.pl, mkflow.awk and g20_tube.pl; records g18_m1, g18_axis, g18_mono and g18_direct_b0_1 … b8_20 of 2026-10-29b, mkflow_b2.2, b2.3, b5 and b10 of 2026-10-29d, and g20_tube_j1.2026-10-29b with the spin-3/2 readings g20_tube_j32_b2 and b2.3 of 2026-10-29a; run of record pentapylon_gate.2026-10-29w, fifteen arms, thirty-two mutant tests, verdict GREEN at 02:20 EDT on 29 October 2026. The instruments, the records and the run\'s own file are posted with their digests in the repository, under records/pentapylon.'),
  ref('R7', '*The lattice mass gap at strong coupling* (Theorem 8.7): the cover, instrument aperanton_perfect_cover.pl and record perfect_cover.2026-10-29a; the certificate, instrument aperanton_decimation_cert.awk and records decimation_cert.2026-10-29a and, with the exact constants, 2026-10-29b; the enclosures of the two constants, record g19_vmf.2026-10-29b with its instrument; the third road, instrument g24_rowsum.awk and record g24_rowsum.2026-10-29a; and the second evaluation, verify73ter.py with its output, which shares no line with the certificate and checks the cover on the tori of side two and four, the coefficients of Turán\'s inequality exactly, and the row sum to sixty digits. The enclosures of the two constants and the one-face constants are of record: the run pentapylon_gate.2026-10-29x, seventeen arms, thirty-eight mutant tests, verdict GREEN at 04:06 EDT on 29 October 2026, re-runs them live and compares them byte for byte; the certificate, its second evaluation and the third road await their own gate run. The derivation is the proof of §8.3; its test from outside is the search from below, instrument g23_decim.pl with its records of 2026-10-29b, which found no configuration exceeding the constants. The files and their digests are posted in the repository, under records/aperanton, records/pentapylon and records/second-road.'),
  ref('R4', '*The lattice theorems in Lean* (§§4.2, 7.2, 8.2): the files EvenTime.lean, Spectral.lean, Perron.lean, StringEnergy.lean and MassGap.lean (the transfer theorem for every finite group); Nonabelian.lean and Separation.lean (the static potential); Griffiths.lean, Rectangle.lean and StrongCoupling.lean (the Z₂ inequalities, expectation and string tension); Slab.lean and Z2Slab.lean, theorem transfer_gap_sharp (the Z₂ slab); Scaling.lean, theorem twopoint_le_of_gap and definition PhysicalGapAlong; Decay.lean, theorems gap_of_decay and eigenvalue_le_of_decay; Dobrushin.lean, theorem cov_le. Run of record aperanton_gate.2026-10-27u, forty-eight arms, twenty-nine mutant tests, verdict GREEN; landed in commit 7dd4c66b2.'),
];

const doc = new Document({
  creator: 'Edwin Boston III',
  title: 'The Ground',
  description: 'Yang–Mills theory after the Alpöge–Sussman manuscripts: what is constructed, what is claimed, and the object that remains.',
  styles: {
    default: { document: { run: { font: FONT, size: 22 }, paragraph: { spacing: { line: 276 } } } },
    paragraphStyles: [
      { id: 'Heading1', name: 'Heading 1', basedOn: 'Normal', next: 'Normal', quickFormat: true,
        run: { size: 28, bold: true, font: FONT, color: '1F1F1F' }, paragraph: { spacing: { before: 360, after: 160 }, outlineLevel: 0 } },
      { id: 'Heading2', name: 'Heading 2', basedOn: 'Normal', next: 'Normal', quickFormat: true,
        run: { size: 23, bold: true, italics: true, font: FONT, color: '1F1F1F' }, paragraph: { spacing: { before: 240, after: 100 }, outlineLevel: 1 } },
    ],
  },
  footnotes,
  sections: [{
    properties: {
      page: { size: { width: 12240, height: 15840 }, margin: { top: 1440, right: 1440, bottom: 1440, left: 1440 } },
      titlePage: true,
    },
    headers: {
      default: new Header({ children: [new Paragraph({ children: [new TextRun({ text: 'THE GROUND  ·  EDWIN BOSTON III', size: 16, font: FONT, color: '6B6B6B', characterSpacing: 20 })], alignment: AlignmentType.CENTER })] }),
      first: new Header({ children: [new Paragraph({ children: [] })] }),
    },
    footers: {
      default: new Footer({ children: [new Paragraph({ children: [new TextRun({ children: [PageNumber.CURRENT], size: 18, font: FONT })], alignment: AlignmentType.CENTER })] }),
      first: new Footer({ children: [new Paragraph({ children: [] })] }),
    },
    children: [...title, ...contents, ...body, ...sources],
  }],
});

Packer.toBuffer(doc).then(buf => { fs.writeFileSync(out, buf); console.log('wrote', out, buf.length, 'bytes;', Object.keys(footnotes).length, 'footnotes'); });
