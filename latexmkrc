use Cwd;
my $root = getcwd();

@default_files = ('main.tex');
$out_dir = 'out';
$pdf_mode = 1;
$pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';

$ENV{TEXINPUTS} = join(':', '.', "$root/", "$root/styles//", "$root/config//", "$root/chapters//", $ENV{TEXINPUTS} // '');
$ENV{BIBINPUTS} = join(':', '.', "$root/bibliography//", $ENV{BIBINPUTS} // '');
$ENV{max_print_line} = 10000;
