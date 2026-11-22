# MCI LaTeX templates

Reusable report, thesis and calculation-notes starters based on `mcidoc`. Each folder builds independently.

| Template | Main document | Preview | Instructions |
| --- | --- | --- | --- |
| Laboratory or project report | [report/main.tex](report/main.tex) | [PDF](report/main.pdf) | [Report README](report/README.md) |
| Bachelor's or master's thesis | [thesis/main.tex](thesis/main.tex) | [PDF](thesis/main.pdf) | [Thesis README](thesis/README.md) |
| Calculation assignments / worked exercises | [notes/main.tex](notes/main.tex) | [PDF](notes/main.pdf) | [Notes README](notes/README.md) |

## Quick start

1. Copy the complete `report`, `thesis` or `notes` folder, including its hidden `.latexmkrc` file.
2. Edit `metadata.tex`: title, full author name(s), student ID(s), course or study program, supervisor and date. Select `BSc` or `MSc` for a thesis.
3. Replace the draft chapters in `sections/`, summaries in `frontmatter.tex` and source placeholder in `references.bib`. The numerical examples are synthetic.
4. Compile from the copied folder:

   ```sh
   latexmk main.tex
   ```

5. Open `main.pdf` and review the result. Replace all `OFFEN` / `OPEN` placeholders before submission.

For short calculation assignments, choose `notes`: edit `metadata.tex` and `exercises.tex`. It has a compact first-page heading, numbered problems, solution steps and result boxes. Contents are off by default, and Biber is unnecessary unless bibliography support is added. Its independent [README](notes/README.md) covers the commands and switches below.

## Requirements and compilation

Use a recent TeX Live, MacTeX or MiKTeX installation with **LuaLaTeX**, **latexmk** and **Biber**. A full TeX Live installation includes the packages and fonts used here. Keep the bundled `mcidoc.cls` beside `main.tex`.

The compact Notes starter only needs LuaLaTeX and latexmk; its default build does not use Biber.

The `.latexmkrc` file selects LuaLaTeX. `latexmk` runs Biber and repeats LaTeX as needed to resolve citations and references. Without `latexmk`, run:

```sh
lualatex main.tex
biber main
lualatex main.tex
lualatex main.tex
```

On Overleaf, upload a complete template folder, select `main.tex` as the main document and **LuaLaTeX** as the compiler. Use a sufficiently recent TeX Live version if the class's key-processing commands are unavailable.

On Windows, templates can also be built from the distribution root:

```powershell
.\build.ps1
.\build.ps1 -Template report
.\build.ps1 -Template thesis
.\build.ps1 -Template notes
```

## Files to edit

| File or folder | Purpose |
| --- | --- |
| `metadata.tex` | Document identity and `\SetMCI` options |
| `frontmatter.tex` | Report summary or thesis abstracts and optional acknowledgments |
| `main.tex` | Chapter order, bibliography and back matter |
| `sections/` | Chapter text, symbol overview and appendix |
| `references.bib` | Bibliographic records |
| `figures/` | Figures, preferably vector PDFs for diagrams |
| `data/` | Measurement data and associated documentation |
| `preamble.tex` | Additional packages and document-specific settings |
| `mci-template.sty` | Template typography, helper commands and class compatibility fixes |
| `mcidoc.cls` | Original class; customize through the other files |

The support-package copies are independent. The thesis package uses the class's Gudea font and native layout for opening pages; its main text uses TeX Gyre Heros. The report uses TeX Gyre Heros throughout. Body line spacing is 1.2; thesis front-matter spacing is 1.5. Change typography in the relevant `mci-template.sty`, or add suitable overrides in `preamble.tex`.

## English language

In `metadata.tex`, change:

```latex
Language = EN,%
```

This changes generated labels and selects decimal points for `siunitx`. It **does not translate document content**. Translate metadata text, chapter headings and prose, captions, plot axes/legends, table headings, symbol descriptions and appendix text. An English thesis prints the English abstract only; a German thesis prints both abstracts. Keep the abstract environments in the preamble.

The IEEE citation style is unchanged. Check that English is permitted for the particular submission. Optional bilingual text can use `\MCIText{Deutsch}{English}`.

## References, figures and equations

The template loads `biblatex` with Biber and IEEE numeric citations, ordered by first citation. Register additional databases in `preamble.tex`. Replace the supplied source placeholder with verified records.

```latex
Eine belegte Aussage.\mcicite{source-key}
Eine Aussage mit genauer Fundstelle.\mcicite[S.~12]{source-key}
```

Use `\figref{label}`, `\tabref{label}` and `\eqnref{label}` for consistent references. Place a `\label` after its figure/table caption. Give captions a short optional list title:

```latex
\caption[Short list title]{Full explanatory caption.}
\label{fig:example}
```

Table captions go above the table; figure captions go below the figure. Use `\qty{12.3}{\volt}` and `\unit{\volt}` for quantities and units. The worked examples demonstrate these commands, an uncertainty calculation and a grayscale plot.

## Structure and options

The cover is unnumbered. Front matter uses Roman numerals; the main text starts at 1. The bibliography is followed by figure/table lists, symbols and the appendix, continuing the earlier Roman sequence. `\MCIPrintBackMatter` performs that transition. Disable unused lists with the `Figures` and `Tables` switches in `metadata.tex`; remove unused symbol/appendix inputs from `main.tex`.

For bioscience formatting, set `\MCIBiosciencetrue` in `metadata.tex`. Citations then use baseline brackets and must be placed before punctuation; `mcimethods` uses ragged-right text. Apply the required tense and any course-specific citation style to the content as well.

For company supervision, embargo, double degrees and other class features, see [the mcidoc guide](mcidoc-guide.md). It describes the class itself; the support packages override some native behavior.

## Cleaning and sharing

Run `latexmk -c main.tex` in a template folder to remove build files while retaining the PDF. The configuration also removes the class-generated abstract and acknowledgment files. Their editable source remains in `frontmatter.tex`.

Share the complete distribution or either complete template folder. Retain `mcidoc.cls`, `mci-template.sty`, `.latexmkrc` and the attribution/license notices. Generated logs, auxiliary files and synchronization files are unnecessary.

Before submission, resolve placeholders, replace synthetic data, complete sources, update the symbol overview, check cross-references and inspect the PDF in grayscale. Assignment instructions and approved program-specific requirements take precedence over starter defaults.
