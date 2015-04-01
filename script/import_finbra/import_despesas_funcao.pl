use strict;
use warnings;
use WikiPoliticos::Web::Model::DB;
use Data::Dumper;

my $schema = WikiPoliticos::Web::Model::DB->new->schema;
my $csvs_basedir = $ARGV[0];

my $finbra_funcoes_rs = $schema->resultset('FinbraFuncao')->search_rs;
my $finbra_despesas_funcao_rs = $schema->resultset('FinbraDespesasFuncao')->search_rs;
my $locations_rs = $schema->resultset('Location')->search_rs;

open my $fh, '<:encoding(utf8)', $csvs_basedir;

my @column_names = split /,/, <$fh>;

while (my $line = <$fh>) {
    next if $line =~ /^UF/;
    my ($location, $funcoes_despesas) = process_line($line, @column_names);
    last;
    # while (my ($funcao_id, $despesa) = each %{$funcoes_despesas}) {
    #   $despesa_to_create = { location_id => $location->id,
    #                          finbra_funcao_id => $funcao_id,
    #                          valor => $despesa };

    #   $finbra_despesas_funcao_rs->create($despesa_to_create);
    # }
}

sub process_line {
    my ($line, @column_names) = @_;
    my @array = split /,/, $line;
    my $estado_codigo = $array[0];
    my $municipio_codigo = $array[1];
    my %funcoes_despesas;

    my $location = $locations_rs->find(
        { ibge_estado_codigo => $estado_codigo },
        { ibge_municipio_codigo => $municipio_codigo });

    my @finbra_funcoes = $finbra_funcoes_rs->search
      (undef, { order_by => { -asc => 'funcao_codigo' } });

    my @finbra_funcoes_codigos = map { $_->funcao_codigo } @finbra_funcoes;
    @finbra_funcoes_codigos = sort {$a <=> $b} @finbra_funcoes_codigos; # Deixando codigos em ordem crescente

    my @finbra_funcoes_despesas = ();
    push @finbra_funcoes_despesas, $array[3]; # Adicionando a despesa da primeira funcao

    for my $i (4 .. $#column_names) {
        if ($column_names[$i] =~ /^Demais Sub/) {
            push @finbra_funcoes_despesas, $array[$i + 1]; # Adicionando a despesa da funcao
        }
    }

    # print "@finbra_funcoes_codigos \n";
    print "@finbra_funcoes_despesas \n";
    @funcoes_despesas{ @finbra_funcoes_codigos } = @finbra_funcoes_despesas;

    print Dumper \%funcoes_despesas;

    return $location, \%funcoes_despesas;
}

close $fh or die "$fh: $!";
