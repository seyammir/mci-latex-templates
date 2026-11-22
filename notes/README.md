# Calculation notes template

A compact `mcidoc` Notes starter for calculation assignments and worked exercises. The assignment heading and solutions share the first page. There is no separate cover, abstract or bibliography; contents are optional.

## Start

1. Copy this entire folder, including `.latexmkrc` and the attribution/license notices.
2. Edit `metadata.tex`: full name, student ID, title, course, sheet number and due date.
3. Replace the two worked examples in `exercises.tex` with your assignment.
4. Run `latexmk main.tex` from this folder and open `main.pdf`.

A recent TeX Live, MacTeX or MiKTeX installation with LuaLaTeX and latexmk is required. Biber is not needed for ordinary calculations. Without latexmk, run `lualatex main.tex` twice. On Overleaf, select `main.tex` and LuaLaTeX.

## Add a problem

```latex
\begin{exercise}[Problem title]
\label{ex:example}
\given $U=\qty{12.0}{\volt}$, $I=\qty{0.150}{\ampere}$.
\find The resistance $R$.
\solution
\begin{equation}
  R=\frac{U}{I}
   =\frac{\qty{12.0}{\volt}}{\qty{0.150}{\ampere}}
   =\qty{80.0}{\ohm}.
  \label{eq:example}
\end{equation}
The calculation is shown in \eqnref{eq:example}.
\result{R=\qty{80.0}{\ohm}}
\end{exercise}
```

The title is optional: `\begin{exercise}` gives a numbered problem without a title. Each exercise is a section; equation numbers restart for each problem, for example `(1.1)` and `(2.1)`. Reference a problem with `\ref{ex:example}`. Use `align` for several numbered calculation lines and `align*` / `equation*` for unnumbered steps. `\result{...}` accepts math content and draws a simple result box.

The step commands are optional. Ordinary text and standard LaTeX equations also work. Problems may continue across pages; use `\clearpage` before an exercise only when a new page is wanted. For a larger collection, split problems into files and include them with `\input{filename}`.

## English and contents

Set `Language = EN` in `metadata.tex` for English labels and decimal points. Translate your title, problem text, problem titles and symbol descriptions yourself. The example prose remains German until translated. `\NotesText{Deutsch}{English}` can select bilingual text.

Change `\NotesContentsfalse` to `\NotesContentstrue` for a contents page followed by problems starting at Arabic page 1. The contents pages use Roman numbers and do not list themselves. Contents are off by default for short assignments.

## Files and customization

| File | Purpose |
| --- | --- |
| `main.tex` | Entry point and problem-file inputs |
| `metadata.tex` | Assignment identity and switches |
| `exercises.tex` | Problem statements, calculations and symbol definitions |
| `notes-template.sty` | Compact title, exercise helpers, typography and language handling |
| `mcidoc.cls` | Original class, unchanged |

Keep this folder's `notes-template.sty`; do not replace it with the report/thesis support package. It adapts the class's experimental Notes mode to this compact format. Adjust typography in that file or add packages/settings to the preamble in `main.tex`.

The starter does not load a bibliography package. If sources are needed, add the required bibliography setup and citations; set `$bibtex_use = 2` in `.latexmkrc` for automated bibliography processing. The report/thesis citation helpers are not loaded here. Extra figures, tables or a formal appendix may require additional directories and numbering under the assignment's rules.

Use correct units and justified precision, show the calculation steps and define the symbols used. Keep the final symbol paragraph consistent with the actual problems, or replace it with the overview required by the assignment. The example electrical values are illustrative inputs, not measurements. Check course-specific submission requirements when using this compact format for grading.

Run `latexmk -c main.tex` after a successful build to remove auxiliary files while keeping the PDF. Resolve all `OFFEN` / `OPEN` placeholders before submission.
