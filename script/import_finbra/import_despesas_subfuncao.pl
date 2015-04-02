use strict;
use warnings;
use WikiPoliticos::Web::Model::DB;
use Data::Dumper;

my $schema = WikiPoliticos::Web::Model::DB->new->schema;
my $csvs_basedir = $ARGV[0];

my $locations_rs = $schema->resultset('Location')->search_rs;
my $finbra_subfuncoes_rs = $schema->resultset('FinbraSubfuncao')->search_rs;
my $finbra_despesas_subfuncao_rs =
  $schema->resultset('FinbraDespesasSubfuncao')->search_rs;

my @finbra_subfuncoes = $finbra_subfuncoes_rs->all;
my @finbra_subfuncoes_codigos = map { $_->subfuncao_codigo } @finbra_subfuncoes;
@finbra_subfuncoes_codigos = sort { $a <=> $b } @finbra_subfuncoes_codigos;

open my $fh, '<:encoding(utf8)', $csvs_basedir;

my @column_names = split /,/, <$fh>;

while (my $line = <$fh>) {
    my ($location, $subfuncoes_despesas) = process_line($line, @column_names);

    while (my ($subfuncao_id, $despesa) = each %{$subfuncoes_despesas}) {
        my $despesa_to_create = { ano => 2012,
                                  location_id => $location->id,
                                  finbra_subfuncao_id => $subfuncao_id,
                                  valor => $despesa };

        $finbra_despesas_subfuncao_rs->create($despesa_to_create);
    }
}

close $fh or die "$fh: $!";

sub process_line {
    my ($line, @column_names) = @_;
    my @split_line = split /,/, $line;
    my $estado_codigo = $split_line[0];
    my $municipio_codigo = $split_line[1];
    my %subfuncoes_despesas;

    my $location = $locations_rs->find
      ({ ibge_estado_codigo => $estado_codigo,
         ibge_municipio_codigo => $municipio_codigo });

    my @finbra_subfuncoes_despesas;

    for my $i (4 .. $#column_names) {
        push @finbra_subfuncoes_despesas, $split_line[$i];

        if ($column_names[$i] =~ /^Demais Sub/) { $i += 2 }
        else { $i++ }
    }

    @subfuncoes_despesas{ @finbra_subfuncoes_codigos } = @finbra_subfuncoes_despesas;

    return $location, \%subfuncoes_despesas;
}
