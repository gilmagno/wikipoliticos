use strict;
use warnings;
use WikiPoliticos::Web::Model::DB;
use WikiPoliticos::Util;
use Data::Dumper;

my $schema = WikiPoliticos::Web::Model::DB->new->schema;
my $csvs_basedir = $ARGV[0];

my %hash_id_tokens;
my $finbra_locations_rs = $schema->resultset('Location')->search_rs;

while (my $location = $finbra_locations_rs->next) {
		my $pais_uf = substr $location->id, 0, 6;
		my $municipio_token = $location->id;
		$municipio_token =~ s/$pais_uf//;
    # $hash_id_tokens{ $municipio_token } = $location->id;
}

print Dumper %hash_id_tokens;

open my $fh, '<:encoding(utf8)', $csvs_basedir;

while (my $line = <$fh>) {
	next if $line =~ /^CD/;
	my @array = split /,/, $line;
	$array[2] =~ s/^"//; 
	$array[2] =~ s/"$//; 
	$array[2] = WikiPoliticos::Util::make_token($array[2]); # Tokenizando o nome do municipio para comparação

	# $finbra_locations_rs->search({ id => })
	# print "$array[2] \n"
}

close $fh or die "$fh: $!"; 