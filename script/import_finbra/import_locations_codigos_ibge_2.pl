use strict;
use warnings;
use WikiPoliticos::Web::Model::DB;
use WikiPoliticos::Util;
use Data::Dumper;

my $schema = WikiPoliticos::Web::Model::DB->new->schema;
my $csvs_basedir = $ARGV[0];

open my $fh, '<:encoding(utf8)', $csvs_basedir;

my %municipios_csv = make_municipios_csv($fh);

close $fh or die "$fh: $!";

my $locations_rs = $schema->resultset('Location')->search_rs;

while (my $location = $locations_rs->next) {
    my $location_name_tokenized =
      WikiPoliticos::Util::make_token($location->name);

    if (my $municipio_csv = $municipios_csv{$location_name_tokenized}) {
        $location->ibge_estado_codigo   ( $municipio_csv->{estado_codigo}    );
        $location->ibge_municipio_codigo( $municipio_csv->{municipio_codigo} );
        $location->update;
    }
}

=pod

Recebe um filehandle do CSV que contém os municípios do Finbra.

Itera as linhas do CSV. A cada iteração, coloca um item no hash
%municipios_csv .  Cada item do hash %municipios_csv tem como chave o
nome tokenizado de um município; e como valor, um hashref com as
chaves "estado_codigo" e "municipio_codigo".

Retorna o hash %municipios_csv.

Exemplo:

    # 23 = Ceará; 440 = Fortaleza
    $municipios_csv{fortaleza} = { estado_codigo => 23,
                                   municipio_codigo => 440 };

=cut

sub make_municipios_csv {
    my $fh = shift;
    my %municipios;

    while (my $line = <$fh>) {
	next if $line =~ /^CD/;

	my @array = split /,/, $line;
	$array[2] =~ s/^"//;
	$array[2] =~ s/"$//;

        # Tokenizando o nome do município
	my $municipio_nome_tokenized =
          WikiPoliticos::Util::make_token($array[2]);

	print "$municipio_nome_tokenized\n";

        my $estado_codigo = 1;       # TODO
        my $municipio_codigo = 1;    # TODO

        $municipios{ $municipio_nome_tokenized } =
          { estado_codigo    => $estado_codigo,
            municipio_codigo => $municipio_codigo };
    }

    return %municipios;
}
