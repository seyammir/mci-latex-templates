$pdf_mode = 4;
$lualatex = 'lualatex -interaction=nonstopmode -halt-on-error -file-line-error -synctex=1 %O %S';
$bibtex_use = 0;
$max_repeat = 6;
push @std_small_cleanup_files, glob('*.synctex'), glob('*.synctex.gz');
