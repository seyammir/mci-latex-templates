# Thesis template

A German bachelor's/master's thesis starter using `mcidoc` and `mci-template.sty`.

## Start

Copy this entire folder, including `.latexmkrc`. Edit these files:

| File | What to change |
| --- | --- |
| `metadata.tex` | Title, full author name, student ID, degree, study program, supervisor, signing place and date |
| `frontmatter.tex` | German/English abstracts and optional acknowledgments |
| `sections/` | Chapter content, symbol overview and appendix |
| `references.bib` | Replace the placeholder with verified sources |
| `main.tex` | Add, remove or reorder chapter inputs |
| `preamble.tex` | Additional packages, bibliography files and settings |

Select `Degree = BSc` or `MSc`. Enter the entire author name in `StudentName/Name`; `Prefix` and `Postfix` are for academic titles. Use the actual signing date rather than the build date.

Put graphics in `figures/` and data in `data/`. The numerical examples are **synthetic**. Replace all `OFFEN` / `OPEN` placeholders and demonstration content before submission.

## Build

Install a recent TeX Live, MacTeX or MiKTeX distribution with LuaLaTeX, latexmk and Biber. From this folder, run:

```sh
latexmk main.tex
```

Open `main.pdf`. The configuration selects LuaLaTeX and runs Biber automatically. Alternatively, run `lualatex main.tex`, `biber main`, then `lualatex main.tex` twice. On Overleaf, upload the whole folder, select `main.tex` and choose LuaLaTeX.

After a successful build, `latexmk -c main.tex` removes auxiliary files and preserves the PDF.

## Abstracts and optional pages

Keep `frontmatter.tex` in the preamble, before `\begin{document}`. The class writes abstract/acknowledgment text to temporary files; always edit the environments in `frontmatter.tex`, not those generated files. Keep each closing environment command on its own line.

- `Language = DE` prints the German Zusammenfassung and English Abstract.
- `Language = EN` prints the English Abstract only.
- Uncomment the complete `Acknowledgments` environment to include a personal acknowledgment.
- `Novelty = set` includes the class declaration; use the wording required by the program.
- `Embargo = unset` omits the embargo page. For an approved embargo, supply its end date as `{DD.MM.YYYY}`.

Keep the `%` line endings in multiline `\SetMCI` blocks. Values containing commas belong in braces.

## Switch to English

Set `Language = EN` in `metadata.tex`. Generated labels switch to English and `siunitx` uses decimal points. Then translate:

1. The title, program information and any acknowledgment.
2. Chapter headings and prose.
3. Table headings, captions, plot axes and legends.
4. Symbol descriptions and appendix text.

Complete the English abstract; the German abstract may remain in the source without being printed. Language selection does not translate source content. The IEEE citation style remains the same. Use English where permitted by the program. For optional bilingual text, use `\MCIText{Deutsch}{English}`.

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

Add sources to `references.bib`; the bibliography is printed in citation order. Put labels after figure/table captions and use a concise optional list title:

```latex
\caption[Short title]{Full explanatory caption.}
\label{fig:example}
```

Figure captions belong below graphics; table captions belong above data. Reference every figure/table in the text. The sample chapters demonstrate equations, units, uncertainty calculations and plots.

For bioscience formatting, enable `\MCIBiosciencetrue`: move citations before punctuation, write methods/results in the past tense and use `mcimethods` for ragged-right methods. Apply any prescribed course citation style separately.

## Structure and appearance

The opening pages use the class's Gudea font, native declaration/abstract layout and 1.5 spacing, with centered Roman page numbers. The main text uses TeX Gyre Heros and 1.2 spacing. Adjust typography in `mci-template.sty` or add overrides in `preamble.tex`.

The main text starts at Arabic 1. The bibliography is printed explicitly in `main.tex`; leave `Thesis/Bibliography/Print = unset` to avoid duplicate output. `\MCIPrintBackMatter` prints enabled figure/table lists and resumes Roman numbering for lists, symbols and appendix. Disable unused lists in `Thesis/ToC`, and remove unused symbol/appendix inputs from `main.tex`.

Keep both `mcidoc.cls` and this folder's `mci-template.sty`. The folder builds independently of the report template. Retain its attribution/license notices when sharing. Company-supervised and double-degree options require additional metadata and a layout check; consult the full distribution's class guide or the [mcidoc documentation](https://dtmc0945.github.io/C-MCI-LaTeX-Class-mcidoc/).
