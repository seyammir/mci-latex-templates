# Report template

A German laboratory/project report starter using `mcidoc` and `mci-template.sty`.

## Start

Copy this entire folder, including `.latexmkrc`. Edit these files:

| File | What to change |
| --- | --- |
| `metadata.tex` | Title, every author and student ID, course, cohort, supervisor, group and submission date |
| `frontmatter.tex` | Optional report summary; remove its environment if unnecessary |
| `sections/` | Chapter content, symbol overview and appendix |
| `references.bib` | Replace the placeholder with verified sources |
| `main.tex` | Add, remove or reorder chapter inputs |
| `preamble.tex` | Additional packages, bibliography files and settings |

Place graphics in `figures/` and measurement files in `data/`. The included table, plot and calculation use **synthetic data**. Replace all `OFFEN` / `OPEN` placeholders and demonstration content before submission.

## Build

Install a recent TeX Live, MacTeX or MiKTeX distribution with LuaLaTeX, latexmk and Biber. From this folder, run:

```sh
latexmk main.tex
```

Open `main.pdf`. The configuration selects LuaLaTeX and runs Biber automatically. Alternatively, run `lualatex main.tex`, `biber main`, then `lualatex main.tex` twice. On Overleaf, upload the whole folder, select `main.tex` and choose LuaLaTeX.

After a successful build, `latexmk -c main.tex` removes auxiliary files and preserves the PDF.

## Report settings

In `metadata.tex`:

- `Mode = Lab` selects a laboratory report; `Mode = Assignment` selects a project report.
- `Group = unset` hides the group row.
- `ToC = {Primary = set, Figures = set, Tables = set}` controls contents and lists. Use `unset` for unused lists.
- Enter the complete author name in `StudentName/Name`. For group reports, list all names and corresponding IDs in the same order, separated by `\newline`.
- `\MCISubmissionDate` sets the cover date.

Keep the `%` line endings in multiline `\SetMCI` blocks. Values containing commas belong in braces.

## Switch to English

Set `Language = EN` in `metadata.tex`. This changes generated labels and unit formatting to decimal points. Then translate:

1. The title, course/cohort text and report summary.
2. Chapter headings and prose.
3. Table headings, captions, plot axes and legends.
4. Symbol descriptions and appendix text.

Language selection does not translate source text. The IEEE citation style remains the same. Use English where permitted by the assignment. For optional bilingual text, use `\MCIText{Deutsch}{English}`.

## Writing commands

```latex
\qty{12.3}{\volt}             % Number and unit
\unit{\volt}                 % Unit only
\figref{fig:setup}
\tabref{tab:results}
\eqnref{eq:model}
A supported statement.\mcicite{source-key}
\mcicite[p.~12]{source-key}   % Citation with a locator
```

Add sources to `references.bib`. The bibliography is printed in citation order. Put labels after figure/table captions, reference each figure/table in the text and use a short list title:

```latex
\caption[Short title]{Full explanatory caption.}
\label{fig:example}
```

Figures use a centered `figure` environment with a caption below the graphic. Tables use a centered `table` environment with a caption above the data. The sample chapters show working examples.

For bioscience formatting, enable `\MCIBiosciencetrue`: place citations before punctuation, write methods/results in the past tense and use `mcimethods` for ragged-right methods. Apply any prescribed course citation style separately.

## Layout and required files

`mci-template.sty` supplies typography, references, page numbering and report-cover fixes. Keep it beside the unchanged `mcidoc.cls`. Adjust typography there or add overrides in `preamble.tex`.

The main text starts at Arabic 1. Figure/table lists, symbols and appendix follow the bibliography and continue the front-matter Roman numbering. Keep `\MCIPrintBackMatter` before those sections. Remove the corresponding `\input` lines from `main.tex` if symbols or an appendix are unnecessary.

The folder builds independently of the thesis template. Retain its attribution/license notices when sharing. For advanced class options, consult the [mcidoc documentation](https://dtmc0945.github.io/C-MCI-LaTeX-Class-mcidoc/).
