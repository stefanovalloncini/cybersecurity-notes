# Cybersecurity Notes

Personal LaTeX notes for the Master's Program in **Cybersecurity: From Design to Operations** (A.Y. 2026/2027).

> **Note.** These are personal study notes, not official course or instructor material. Original lecture slides and handouts are **not included** in this repository.

## Modules

| # | Module | Part |
|---|---|---|
| 01 | Fundamentals of Security and Cryptography | I — Foundations and Infrastructure Security |
| 02 | Network Security and Administration | I — Foundations and Infrastructure Security |
| 03 | Computer Security and Administration | I — Foundations and Infrastructure Security |
| 04 | Security Engineering I: Secure Coding | II — Security Engineering |
| 05 | Security Engineering I Workshop: Static Application Security Testing | II — Security Engineering |
| 06 | Security Engineering II: Web App Security and Testing | II — Security Engineering |
| 07 | Security Engineering III: Mobile Security and Testing | II — Security Engineering |
| 08 | Security Engineering IV: Industrial Control Systems | II — Security Engineering |
| 09 | Security Monitoring I: Malware Analysis and Detection | III — Security Monitoring, Incident Response, and Forensics |
| 10 | Security Monitoring II: Information Correlation | III — Security Monitoring, Incident Response, and Forensics |
| 11 | Incident Response | III — Security Monitoring, Incident Response, and Forensics |
| 12 | Cyber Forensics | III — Security Monitoring, Incident Response, and Forensics |
| 13 | NIS2 and CRA Regulations | IV — Governance and Regulation |

Chapter numbers (`#`) follow this repository; the official module number (e.g. `Module 4.1/11`) is noted at the top of each chapter file.

## Structure

```
cybersecurity-notes/
├── main.tex                 # master document (parts + chapters + bibliography)
├── config/config.tex        # title, author, year, repo URL, solutions toggle
├── frontmatter/             # copyright page, AI use disclosure, licence
├── chapters/
│   ├── 01_fundamentals_security_cryptography.tex   # chapter wrapper (subfile)
│   ├── 01_fundamentals/     # one file per topic, \input by the wrapper
│   └── 02_... .tex          # other modules (split into a folder once they grow)
├── styles/                  # shared LaTeX packages (notes.sty loads the rest)
├── figures/                 # images (diagrams are drawn inline with TikZ)
├── bibliography/references.bib
└── Makefile
```

## Writing conventions

| Environment | Use for |
|---|---|
| `definition` | Terms to know precisely |
| `theorem` + `proof` | The few formal results (e.g. perfect secrecy of the one-time pad) |
| `example` | Worked examples (e.g. RSA with small numbers) |
| `remark` | Pitfalls, subtleties, things that differ between sources |
| `exercise` + `solution` | Exam-style questions |
| `summary` | Key points at the end of a section |

All take an optional title, e.g. `\begin{definition}[Vulnerability]`. Citations: `\cite{shannon1949}`.

Crypto notation: `\Enc`, `\Dec`, `\KeyGen`, `\Sign`, `\Vrfy`, `\MAC`, `\Z`, `\xor`, `\concat`, `\sample`.

Write accented characters directly in UTF-8 (`à`, not `\`a`). The pre-commit hook enforces this.

**Self-test mode:** uncomment `\showsolutionsfalse` in `config/config.tex` to build the PDF without solutions.

## Build

```bash
make all                 # full build -> out/main.pdf
make chapter name=01     # single chapter -> out/chapters/
make watch               # continuous rebuild
make clean               # remove temp files (keep PDFs)
make distclean           # remove out/
make install-hooks       # enable the pre-commit hook
```

Requires TeX Live 2026 (with `biber`) and `latexminted` (or Python Pygments) for `minted`.

## AI use

Large language models (LLMs) were used in preparing these notes.

## License

[![CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

- **Notes** (text, figures, exercises): [CC BY-NC-SA 4.0](LICENSE). You may share and adapt them with credit, not commercially, and adapted versions must use the same license.
- **LaTeX template and build files** (`styles/`, `Makefile`, `.githooks/`): [MIT](LICENSE-CODE).
- Course slides, recordings and handouts belong to their authors and the University of Bologna; they are not in this repository and not covered by these licenses.

A plain-language summary is on the *Licence* page of the PDF (`frontmatter/license.tex`).
