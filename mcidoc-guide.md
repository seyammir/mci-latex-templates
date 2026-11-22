# mcidoc class guide

`mcidoc` is a LaTeX class for MCI Mechatronics documents. This guide covers its document types, metadata, front matter and common content features. It describes the class implementation; supplementary packages can override its behavior.

Use **LuaLaTeX** and a recent LaTeX distribution. Place `mcidoc.cls` beside the main `.tex` file, or install it in a TeX search path.

## Document types

```latex
\documentclass[state=Thesis]{mcidoc}
```

| State | Intended use | Implementation |
| --- | --- | --- |
| `Thesis` | Bachelor's/master's theses, internal/company supervision and double degrees | Main thesis implementation |
| `Report` | Laboratory reports and coursework/project reports | Main report implementation |
| `Paper` | Short papers | Experimental; two columns and paper-specific spacing/margins |
| `Notes` | Lecture notes | Experimental; dedicated cover and running headings |
| `Slide` | Presentations | Experimental; loads Beamer |
| `Poster` | Posters | Listed as work in progress; no complete layout in this implementation |

Report, thesis, paper and notes modes use KOMA-Script's `scrreprt` and support chapters. Experimental modes need separate compatibility/layout checks; they are not interchangeable with the report/thesis starters.

## Notes mode

`\documentclass[state=Notes]{mcidoc}` is intended for lecture/study notes and can hold worked exercises using ordinary sections and equations. Its native layout includes a cover, contents and running headings; it has no dedicated problem/solution or answer-key commands. Abstract and acknowledgment environments are ignored in this mode.

Use the top-level `Title` for the cover and the absolute `/Notes/Lecture` key for the course name:

```latex
\SetMCI{%
  Title = {Worked exercises},%
  /Notes/Lecture = {Course name},%
}
```

The `Notes/Title` field exists, but the cover reads the top-level title. The native contents routine reads `Thesis/ToC` switches, and its cover uses a fixed English `Lecture Notes` label. A supplementary notes package can replace those routines with a compact assignment heading, exercise numbering and optional contents. See the calculation-notes starter's README for that package's additional commands; they are not native class features.

## Metadata with `\SetMCI`

Call `\SetMCI` in the preamble. Keys and switch values are case-sensitive. Use commas between entries and braces around text containing commas. Preserve the `%` line endings in multiline blocks to prevent unwanted spaces in keys.

```latex
\SetMCI{%
  StudentName = {Name = {First Middle Last}},%
  StudentID   = {51234567},%
  Degree      = BSc,%
  Language    = DE,%
  Department  = MECH,%
  Title       = {Document title},%
}
```

| Key | Values / meaning |
| --- | --- |
| `StudentName` | Nested `Name`, optional `Prefix` and `Postfix`. Put the entire personal name in `Name`; titles belong in the other fields. |
| `StudentID` | Student identifier printed on the cover. The documented initial-digit convention is not actively enforced by this implementation. |
| `Degree` | `BSc` or `MSc`; selects degree wording. |
| `Language` | `DE` or `EN`; native default is `EN`. Selects generated language-dependent material. |
| `Department` | `MECH` is the documented department. |
| `Title` | Top-level document title, read by report and thesis covers. |

Omit unused student titles rather than putting words of a personal name into `Prefix` or `Postfix`. The native student-title sentinel is `unset`.

Nested paths correspond to nested blocks: `Thesis/ToC/Figures` is set as `Thesis = {ToC = {Figures = unset}}`. Feature switches generally use `set` / `unset`.

## Thesis configuration

```latex
\SetMCI{%
  Thesis = {%
    StudyProgram = {Study program},%
    Supervisor = {Name = {Supervisor name}, Prefix = {}, Postfix = {}},%
    Location = {Innsbruck},%
    Date = {DD.MM.YYYY},%
    Novelty = set,%
    Embargo = unset,%
    ToC = {Primary = set, Figures = set, Tables = set},%
    Bibliography = {Print = unset},%
  },%
}
```

| Path inside `Thesis` | Purpose |
| --- | --- |
| `StudyProgram` | Program name on the cover |
| `Supervisor` | Nested `Name`, `Prefix`, `Postfix`, optional `Company` |
| `Reviewer` | Nested `Name`, `Prefix`, `Postfix`; used with company supervision |
| `Location` | Signing place; native default is Innsbruck |
| `Date` | Signing date; native default is the build date |
| `Novelty` | `set` prints the declaration; native default is `set` |
| `Embargo` | `unset` omits the embargo page; an approved end date adds it |
| `ToC/Primary` | Print contents |
| `ToC/Figures` | Print figure list |
| `ToC/Tables` | Print table list |
| `Bibliography/Print` | Automatically print references at document end; native default is `set` |
| `Bibliography/Location` | Store a database filename; does not load it |
| `Bibliography/State`, `Bibliography/Style` | Stored fields; do not select a backend or citation style |

Use explicit empty `Prefix` and `Postfix` for an ordinary supervisor/reviewer with no titles. Set an actual signing date when a document must remain reproducible across builds.

### Company supervision

Add `Company` to the supervisor and provide the academic reviewer:

```latex
\SetMCI{%
  Thesis = {%
    Supervisor = {%
      Name = {Company supervisor}, Prefix = {}, Postfix = {},%
      Company = {Company name},%
    },%
    Reviewer = {Name = {Academic reviewer}, Prefix = {}, Postfix = {}},%
  },%
}
```

For internal supervision, omit `Company` and `Reviewer`.

### Double degrees

The cover implements `ASU` and `ESILV` partner variants. `Institution = unset` selects the ordinary single-degree cover.

```latex
\SetMCI{%
  Degree = MSc,%
  Thesis = {%
    Supervisor = {Name = {MCI supervisor}, Prefix = unset, Postfix = unset},%
    Double-Degree = {%
      Institution = ASU,% ASU or ESILV
      Student-Number = {Partner student identifier},%
      Supervisor = {Name = {Partner supervisor}, Prefix = unset, Postfix = unset},%
    },%
  },%
}
```

The ordinary `StudentID` remains the MCI identifier. The institution key selects partner-specific degree/program labels. In the double-degree branch, use `unset` for unused supervisor titles, including the MCI supervisor. Inspect the resulting cover for the actual program and names.

### Abstracts and acknowledgments

Register these environments **in the preamble**, before `\begin{document}`:

```latex
\begin{Abstract}{DE}
German summary text.
\end{Abstract}

\begin{Abstract}{EN}
English abstract text.
\end{Abstract}

\begin{Acknowledgments}
Optional acknowledgment text.
\end{Acknowledgments}
```

A German thesis prints both abstracts, German first. An English thesis prints the English abstract only. Omit the entire acknowledgment environment when unnecessary.

The class writes these bodies to `aux-<jobname>-abstract-de.abs`, `aux-<jobname>-abstract-en.abs` and `aux-<jobname>-acknowledgement.ack`, then reads them while generating the opening pages. Edit the source environments, not those generated files. Keep closing commands on separate lines.

Native front-matter order is cover, optional embargo, declaration, optional acknowledgments, abstracts and contents. Figure/table lists follow the contents in the unmodified class. Front matter is inserted automatically; calling the title/contents routines again duplicates it.

## Report configuration

```latex
\SetMCI{%
  Title = {Report title},%
  Report = {%
    Lecture = {Course name},%
    Cohort = {Cohort},%
    Mode = Lab,% Lab or Assignment
    Group = {Group identifier},%
    ToC = {Primary = set, Figures = set, Tables = set},%
  },%
  /Report/Supervisor/Name = {Supervisor name},%
}
```

| Path | Purpose |
| --- | --- |
| `Report/Lecture` | Course name |
| `Report/Cohort` | Cohort |
| `Report/Mode` | `Lab` or `Assignment` |
| `Report/Group` | Optional group; `unset` hides it in the native English cover |
| `/Report/Supervisor/Name` | Supervisor field, set using the absolute key |
| `Report/ToC` | Report-specific contents/list switches; see implementation notes below |
| `Report/Title` | Defined, but the cover reads the top-level `Title` instead |

Report mode inserts its cover and contents automatically. Its native `Abstract` environment is stored but not automatically printed, and references must be printed explicitly. A report summary environment supplied by another package is an extension, not a native class feature.

## English and German

Set `Language = EN` or `DE` in the metadata. This selects generated class text; it does not translate titles, chapters, captions, axes or bibliography records.

For additional language-sensitive text:

```latex
\LanguageNoCondition{EN}{English text}
\LanguageNoCondition{DE}{Deutscher Text}
```

The class loads Babel with English and German. The native report's body language may need explicit selection; a compatibility package can handle this. The class initializes `siunitx` to German formatting independently of `Language`; when using the class directly, select the desired numeric locale yourself:

```latex
\sisetup{locale=US} % Decimal point; use DE for a decimal comma
```

Translate all user-supplied text consistently and follow the permitted submission language.

## Chapters and content

### Chapter files

```latex
\chapter{Introduction}
\section{Objective}
\label{sec:objective}
```

Use `\input{sections/introduction}` to insert a file. `\include{sections/introduction}` starts/ends pages, writes a separate auxiliary file and supports selective compilation with `\includeonly{sections/introduction}` in the preamble. Use a complete build for final references and numbering.

### Equations and units

The class loads `amsmath`, `amssymb` and `siunitx`:

```latex
\begin{equation}
  R = \frac{U}{I}
  \label{eq:resistance}
\end{equation}
See Eq.~\eqref{eq:resistance}.
\qty{12.3}{\volt}
\unit{\ohm}
```

Explain symbols and units in the document. Use an unnumbered `equation*` where appropriate.

### Figures, tables and plots

The class includes graphics support and TikZ, places table captions above data and figure captions below graphics, and loads `caption` and `floatrow`. Prefer explicit source order and concise optional list titles:

```latex
\begin{figure}[htbp]
  \centering
  \includegraphics[width=0.8\linewidth]{figures/example.pdf}
  \caption[Short list title]{Full figure explanation.}
  \label{fig:example}
\end{figure}
```

Reference the figure with `\ref{fig:example}`. For tables, use the analogous `table` environment with its caption before the tabular material. Load `booktabs`, `tabularx` or `longtable` when needed; they are not all native class dependencies. Load `pgfplots` explicitly to use its `axis` environment and choose a compatibility level supported by the installation.

### Source-code listings

The class loads `listings` and defines a `mainStyle`:

```latex
\lstinputlisting[
  language=C++,
  caption={[Short list title]Full listing explanation},
  label={lst:example}
]{codes/example.cpp}
```

Create the referenced file, cite external code and refer to `Listing~\ref{lst:example}` in the text. `\lstlistoflistings` prints a listing directory. Change listing styles with `\lstset` or `\lstdefinestyle`; verify that syntax remains readable in grayscale.

### Bibliography

The class does not load/configure `biblatex`. For example:

```latex
\usepackage[backend=biber,style=ieee,sorting=none]{biblatex}
\addbibresource{references.bib}
```

Use `\cite{key}` in text. Run Biber between LaTeX passes, or let `latexmk` manage it. For reports, call `\printbibliography` at the intended position. For theses, either allow the class's automatic output or set `Thesis/Bibliography/Print = unset` and print it explicitly. Do not enable both paths.

The bibliography backend and citation style are package choices; setting the class's stored `Style` or `State` keys does not configure them.

### Appendices and directories

Use `\appendix` before appendix chapters to switch chapter letters. It does not itself select page numbering. Use `\listoffigures`, `\listoftables` and `\lstlistoflistings` at the required locations when controlling the document structure yourself. Abbreviation and symbol overviews must be authored explicitly; the class does not populate them automatically.

## Implementation notes

These points matter when using the unmodified class directly. A supplementary compatibility package may already address them.

| Area | Behavior to account for |
| --- | --- |
| Author identity | The cover reads `\Student@Name`; declarations/report footer use `\Global@StudentName`. Synchronize the two to avoid a default name in declarations. |
| Report supervisor | The native English cover prints a literal `a` instead of the stored supervisor name. |
| German report cover | Uses obsolete fields and needs a replacement/fix. |
| Report switches | The native contents routine reads `Thesis/ToC`, even though `Report/ToC` keys exist. |
| Report page breaks | Its native contents routine disables `\clearpage` without sufficient scoping. |
| Bibliography | Backend/database setup is separate from class metadata. |
| Page numbering | Thesis front/main numbering and the assignment to `savedpage` are commented out. Manage numbering explicitly rather than relying on that counter. |
| Unicode in T1 fonts | Under LuaLaTeX, raw German `ß` needs the correct text-command mapping when using the native T1 font setup. |

For direct class use, author synchronization can be added after metadata:

```latex
\makeatletter
\renewcommand*{\Global@StudentName}{\Student@Name}
\makeatother
```

Keep compatibility fixes in a separate package/preamble. Recheck them when changing the class version. Formal requirements belong to the applicable assignment/program; a class layout alone does not establish compliance.

## Further documentation

- [mcidoc documentation](https://dtmc0945.github.io/C-MCI-LaTeX-Class-mcidoc/)
- [Source repository and examples](https://github.com/dTmC0945/C-MCI-LaTeX-Class-mcidoc)
