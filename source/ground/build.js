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
  center('28 October 2026', 22, { after: 960 }),
  new Paragraph({ children: [new TextRun({ text: 'Abstract', bold: true, size: 22, font: FONT })], alignment: AlignmentType.CENTER, spacing: { after: 120 } }),
  new Paragraph({
    children: runs(`A proof that quantum Yang–Mills theory has a mass gap must stand on a construction of the theory, and the most complete public construction now in view is the corpus of manuscripts that Levent Alpöge and Ethan Sussman have posted since 6 October 2026, carrying Bałaban's renormalisation group from the lattice to the continuum for the gauge group SU(2). This paper fixes that ground. It reads the corpus from its primary sources and proves, clause by clause and with exact references, what the corpus asserts and at what strength. In three dimensions an 854-page manuscript asserts continuum Schwinger functions of the plaquette-energy density, the lattice form of tr F², which satisfy the Osterwalder–Schrader axioms in the clustering components of infinite-volume limits taken along subsequences, together with a short-distance law that makes the theory non-trivial; it asserts no mass gap. In four dimensions a 153-page draft deduces, from inputs it declares clause by clause and from supporting statements two of which are not yet written, continuum limits on ℝ⁴ along subsequences with regularity, reflection positivity, symmetry and hypercubic invariance; its authors call the underlying argument extremely long and not understandable as it stands, and state that the corpus has not been satisfactorily vetted. The paper then proves that, for a reflection-positive theory, a mass gap is the same property as exponential clustering of the reflection-positive correlations, and that a lower bound on the lattice mass gap, uniform in physical units along the lattice sequence of such a construction, supplies at once the three properties the corpus withholds: a unique vacuum, the cluster property and a mass gap. This identifies the object on which the proof that follows must stand.`, { size: 20 }),
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
  H2('Records of the computations of Edwin Boston III'),
  P0('Each record is held, with its instrument and its run of record, in the repository of Edwin Boston III.', { after: 120 }),
  ref('R1', '*The shadow ladder* (Proposition 8.3): record g6_tube.2026-10-28a, with its instrument g6_tube.pl; landed in commit aea98a3af; re-derived in the run of record pentapylon_gate.2026-10-28r, nine arms, nineteen mutant tests, verdict GREEN.'),
  ref('R2', '*The gap by counting* (§8.2): record g6_inertia.2026-10-28b; run of record pentapylon_gate.2026-10-28r, verdict GREEN; landed in commit e11e1269c. The independently certified intervals it meets: run of record tomeus_gate.2026-10-27e, ten arms, ten mutant tests, verdict GREEN.'),
  ref('R3', '*The gap through duality* (§8.2): the dual-road records of 28 October 2026 and record g6_ising_anchor.2026-10-28a; landed in commit 44be883de with the run pentapylon_gate.2026-10-28q, eight arms, seventeen mutant tests, verdict GREEN; re-derived in run r.'),
  ref('R5', '*The chain lemma* (Proposition 8.2): instrument g9_chain.pl and record g9_chain.2026-10-29a; landed in commit 103e8425a; run of record pentapylon_gate.2026-10-28s, twelve arms, twenty-five mutant tests, verdict GREEN.'),
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
