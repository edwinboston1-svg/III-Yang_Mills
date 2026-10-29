// Helpers for the groundwork document: inline markup, footnotes, theorem blocks, display math.
const d = require('docx');
const {
  Paragraph, TextRun, FootnoteReferenceRun, AlignmentType, HeadingLevel,
  Math: OMath, MathRun, MathFraction, MathSubScript, MathSuperScript, MathSubSuperScript,
  Table, TableRow, TableCell, WidthType, BorderStyle, ShadingType, VerticalAlign,
  TabStopType, PageBreak,
} = d;

const FONT = 'Cambria';
const BODY = 22; // 11 pt in half-points

// ---------- footnotes ----------
const footnotes = {};
let fnCount = 0;
function addFootnote(markup) {
  fnCount += 1;
  footnotes[fnCount] = { children: [new Paragraph({
    children: runs(markup, { size: 17 }),
    spacing: { after: 40, line: 240 },
    alignment: AlignmentType.LEFT,
  })] };
  return fnCount;
}

// ---------- inline markup ----------
// *italic*  **bold**  ^{sup}  _{sub}  [[fn:footnote markup]]
function runs(src, base = {}) {
  const out = [];
  let italic = !!base.italics, bold = !!base.bold;
  let buf = '';
  const size = base.size || BODY;
  const font = base.font || FONT;
  const flush = (extra = {}) => {
    if (!buf) return;
    out.push(new TextRun({ text: buf, italics: italic, bold, size, font, ...extra }));
    buf = '';
  };
  let i = 0;
  while (i < src.length) {
    if (src.startsWith('[[fn:', i)) {
      // footnote: find the matching ']]' allowing nested brackets
      let depth = 0, j = i;
      for (; j < src.length; j++) {
        if (src.startsWith('[[', j)) { depth++; j++; continue; }
        if (src.startsWith(']]', j)) { depth--; if (depth === 0) break; j++; continue; }
      }
      const inner = src.slice(i + 5, j);
      flush();
      const id = addFootnote(inner);
      out.push(new FootnoteReferenceRun(id));
      i = j + 2; continue;
    }
    if (src.startsWith('**', i)) { flush(); bold = !bold; i += 2; continue; }
    if (src[i] === '*') { flush(); italic = !italic; i += 1; continue; }
    if ((src.startsWith('^{', i) || src.startsWith('_{', i))) {
      const sup = src[i] === '^';
      const j = src.indexOf('}', i + 2);
      flush();
      const t = src.slice(i + 2, j);
      out.push(new TextRun({ text: t, italics: italic, bold, size, font, superScript: sup, subScript: !sup }));
      i = j + 1; continue;
    }
    if (src[i] === '\\' && (src[i + 1] === '*' || src[i + 1] === '_' || src[i + 1] === '^')) {
      buf += src[i + 1]; i += 2; continue;
    }
    buf += src[i]; i += 1;
  }
  flush();
  return out;
}

// ---------- block builders ----------
function P(markup, opts = {}) {
  return new Paragraph({
    children: runs(markup, opts.base || {}),
    alignment: opts.align || AlignmentType.JUSTIFIED,
    indent: opts.indent || (opts.noIndent ? undefined : { firstLine: 360 }),
    spacing: { after: opts.after ?? 120, before: opts.before ?? 0, line: opts.line ?? 276 },
    keepNext: opts.keepNext,
  });
}
function P0(markup, opts = {}) { return P(markup, { ...opts, noIndent: true }); }

function H1(text, opts = {}) {
  return new Paragraph({
    heading: HeadingLevel.HEADING_1,
    children: [new TextRun({ text, bold: true, size: 28, font: FONT })],
    spacing: { before: opts.pageBreakBefore ? 0 : 360, after: 160 },
    keepNext: true,
    pageBreakBefore: !!opts.pageBreakBefore,
  });
}
function H2(text) {
  return new Paragraph({
    heading: HeadingLevel.HEADING_2,
    children: [new TextRun({ text, bold: true, italics: true, size: 23, font: FONT })],
    spacing: { before: 240, after: 100 },
    keepNext: true,
  });
}

// Theorem-like block: label (bold) + optional title + statement in italics.
function Thm(label, title, statementParas) {
  const paras = Array.isArray(statementParas) ? statementParas : [statementParas];
  const blocks = [];
  paras.forEach((m, k) => {
    const head = k === 0 ? [
      new TextRun({ text: label + (title ? ' ' : '. '), bold: true, size: BODY, font: FONT }),
      ...(title ? [new TextRun({ text: '(' + title + '). ', bold: true, size: BODY, font: FONT })] : []),
    ] : [];
    blocks.push(new Paragraph({
      children: [...head, ...runs(m, { italics: true })],
      alignment: AlignmentType.JUSTIFIED,
      indent: k === 0 ? undefined : { left: 360 },
      spacing: { before: k === 0 ? 160 : 40, after: 80, line: 276 },
      keepNext: k < paras.length - 1,
    }));
  });
  return blocks;
}

// Proof: paragraphs; the first begins with "Proof." and the last ends with the tombstone.
function Proof(paras, label = 'Proof', open = false) {
  const list = Array.isArray(paras) ? paras : [paras];
  return list.map((m, k) => {
    const head = k === 0 ? [new TextRun({ text: label + '. ', italics: true, size: BODY, font: FONT })] : [];
    const tail = (k === list.length - 1 && !open) ? [new TextRun({ text: ' ∎', size: BODY, font: FONT })] : [];
    return new Paragraph({
      children: [...head, ...runs(m), ...tail],
      alignment: AlignmentType.JUSTIFIED,
      indent: k === 0 ? undefined : { firstLine: 360 },
      spacing: { after: 120, line: 276 },
    });
  });
}

// Block quotation, indented both sides.
function Quote(markup, opts = {}) {
  return new Paragraph({
    children: runs(markup, { size: 20 }),
    alignment: AlignmentType.JUSTIFIED,
    indent: { left: 720, right: 720 },
    spacing: { before: 60, after: 140, line: 260 },
    keepNext: opts.keepNext,
  });
}

// An enumerated clause with hanging indent: "(i) text".
function Item(tag, markup, opts = {}) {
  return new Paragraph({
    children: [new TextRun({ text: tag + '\t', size: BODY, font: FONT, italics: !!opts.italic }), ...runs(markup, { italics: !!opts.italic })],
    alignment: AlignmentType.JUSTIFIED,
    indent: { left: 720, hanging: 540 },
    tabStops: [{ type: TabStopType.LEFT, position: 720 }],
    spacing: { after: 80, line: 276 },
  });
}

// ---------- display mathematics (Office Math) ----------
const mr = (s) => new MathRun(s);
const frac = (n, den) => new MathFraction({ numerator: toM(n), denominator: toM(den) });
const sub = (b, s) => new MathSubScript({ children: toM(b), subScript: toM(s) });
const sup = (b, s) => new MathSuperScript({ children: toM(b), superScript: toM(s) });
const subsup = (b, s, p) => new MathSubSuperScript({ children: toM(b), subScript: toM(s), superScript: toM(p) });
function toM(x) { if (Array.isArray(x)) return x.map(y => (typeof y === 'string' ? mr(y) : y)); return [typeof x === 'string' ? mr(x) : x]; }

function Eq(parts, number) {
  const children = [new TextRun({ text: '\t', size: BODY, font: FONT }), new OMath({ children: toM(parts) })];
  if (number) children.push(new TextRun({ text: '\t(' + number + ')', size: BODY, font: FONT }));
  return new Paragraph({
    children,
    tabStops: [{ type: TabStopType.CENTER, position: 4680 }, { type: TabStopType.RIGHT, position: 9360 }],
    spacing: { before: 100, after: 140 },
  });
}

// ---------- tables ----------
function Grid(headers, rows, widths) {
  const total = widths.reduce((a, b) => a + b, 0);
  const border = { style: BorderStyle.SINGLE, size: 4, color: '8C8C8C' };
  const borders = { top: border, bottom: border, left: border, right: border };
  const cell = (markup, w, head) => new TableCell({
    borders,
    width: { size: w, type: WidthType.DXA },
    shading: head ? { fill: 'E8E6E1', type: ShadingType.CLEAR, color: 'auto' } : undefined,
    margins: { top: 70, bottom: 70, left: 110, right: 110 },
    verticalAlign: VerticalAlign.TOP,
    children: [new Paragraph({ children: runs(markup, { size: 18, bold: !!head }), spacing: { after: 0, line: 240 } })],
  });
  return new Table({
    width: { size: total, type: WidthType.DXA },
    columnWidths: widths,
    rows: [
      new TableRow({ tableHeader: true, children: headers.map((h, k) => cell(h, widths[k], true)) }),
      ...rows.map(r => new TableRow({ children: r.map((c, k) => cell(c, widths[k], false)) })),
    ],
  });
}

function Break() { return new Paragraph({ children: [new PageBreak()] }); }
function Spacer(after = 120) { return new Paragraph({ children: [], spacing: { after } }); }

module.exports = { d, FONT, BODY, runs, P, P0, H1, H2, Thm, Proof, Quote, Item, Eq, Grid, Break, Spacer,
  mr, frac, sub, sup, subsup, footnotes, addFootnote };
