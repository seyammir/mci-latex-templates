$pdf_mode = 4;
$lualatex = 'lualatex -interaction=nonstopmode -halt-on-error -file-line-error -synctex=1 %O %S';
$bibtex_use = 2;
$max_repeat = 6;
$clean_ext = 'bbl run.xml';
push @std_small_cleanup_files, glob('aux-*-abstract-*.abs'), glob('aux-*-acknowledgement.ack');
push @std_small_cleanup_files, glob('*.synctex'), glob('*.synctex.gz');
