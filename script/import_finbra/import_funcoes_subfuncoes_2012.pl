use strict;
use warnings;
use WikiPoliticos::Web::Model::DB;

my $schema = WikiPoliticos::Web::Model::DB->new->schema;
my $csvs_basedir = $ARGV[0];

my $finbra_funcoes_rs = $schema->resultset('FinbraFuncao')->search_rs;
my $finbra_subfuncoes_rs = $schema->resultset('FinbraSubfuncao')->search_rs;

open my $fh, '<:encoding(utf8)', $csvs_basedir;

while (my $line = <$fh>) {
	next if $line =~ /^COD/;
	my @array = split /,/, $line;
	$array[1] =~ s/^"//; 
	$array[1] =~ s/"$//;
	$array[3] =~ s/^"//;
	$array[3] =~ s/"$//;

	if ($array[1] && $array[1] <= 28) { # Função
		$array[1] =~ s/0*//; # Retira os 0's do número da função
		
		$finbra_funcoes_rs->create({
		  funcao_codigo => $array[1],
		  nome => $array[3]
		}); 
	} elsif ($array[1]) { # Subfunção
		my $finbra_funcao_id = substr $array[1], 0, 2;
		$finbra_funcao_id =~ s/0*//; # Retira os 0's do número da função
		$array[1] =~ s/^0//; # Retira o primeiro 0 do número da subfunção

		$finbra_subfuncoes_rs->create({
		  subfuncao_codigo => $array[1],
		  nome => $array[3],
		  finbra_funcao_id => $finbra_funcao_id
		});
	}
}

close $fh or die "$fh: $!"; 