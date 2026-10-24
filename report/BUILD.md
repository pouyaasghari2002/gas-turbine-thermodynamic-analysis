# Compile the English report

The report is self-contained in this folder. No custom fonts, bibliography, external code files, or shell escape are required.

Overleaf: upload the report-only ZIP, choose `main.tex`, and use pdfLaTeX. For the complete repository ZIP, choose `report/main.tex` (or the same path inside its enclosing folder).

Local build from the repository root:

```bash
cd report
pdflatex -interaction=nonstopmode -halt-on-error main.tex
pdflatex -interaction=nonstopmode -halt-on-error main.tex
```

Keep `figures/` and `listings/` beside `main.tex`. The standard packages listed in the preamble and Latin Modern fonts are sufficient.
