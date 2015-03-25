use strict;
use warnings;
use WikiPoliticos::Web::Model::DB;
use WikiPoliticos::Util;
use Data::Dumper;

my $schema = WikiPoliticos::Web::Model::DB->new->schema;
my $csvs_basedir = $ARGV[0];

my $finbra_locations_rs = $schema->resultset('Location')->search_rs;
my %municipios_csv = municipios_from_csv();

while (my $location = $finbra_locations_rs->next) {
	my $pais_uf = substr $location->id, 0, 6;
	my $municipio_token = WikiPoliticos::Util::make_token($location->name);
	$municipio_token =~ s/$pais_uf//; # Retirando o prefixo pais-uf do nome do municipio
	
	if (my $municipio_csv = $municipios_csv{ $municipio_token }) {
		$location->ibge_estado_codigo($municipio_csv->{estado_codigo});
		$location->ibge_municipio_codigo($municipio_csv->{municipio_codigo});
		$location->update;
	}
}

sub municipios_from_csv {
	open my $fh, '<:encoding(utf8)', $csvs_basedir;
	my %municipios_csv;
	
	while (my $line = <$fh>) {
		next if $line =~ /^CD/;
		my @array = split /,/, $line;
		$array[2] =~ s/^"//; 
		$array[2] =~ s/"$//; 
		my $municipio_csv_tokenized = WikiPoliticos::Util::make_token($array[2]); # Tokenizando o nome do municipio para comparação
		$municipios_csv{ $municipio_csv_tokenized } = 
		{ estado_codigo => $array[0],
			municipio_codigo => $array[1]
		};
	}

	close $fh or die "$fh: $!"; 
	return %municipios_csv; 
}