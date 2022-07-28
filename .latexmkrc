#!/usr/bin/env perl

# LaTeX
$latex = 'uplatex -synctex=1 -file-line-error -interaction=nonstopmode %S';
$max_repeat = 5;

# BibTeX
$bibtex = 'upbibtex %S';
$biber = 'biber --bblencoding=utf8 -u -U --output_safechars %S';

# index
$makeindex = 'upmendex -o %D %S';

# DVI / PDF
$dvipdf = 'dvipdfmx -o %D %S';
$pdf_mode = 3;

$max_repeat = 10;