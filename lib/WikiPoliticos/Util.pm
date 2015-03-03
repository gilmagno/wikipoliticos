package WikiPoliticos::Util;
use strict;
use warnings;
use WikiPoliticos::Web::Model::DB;
use Text::Unidecode;

our @ufs = ('AC', 'AL', 'AM', 'AP', 'BA', 'BR', 'CE', 'DF', 'ES', 'GO', 'MA',
            'MG', 'MS', 'MT', 'PA', 'PB', 'PE', 'PI', 'PR', 'RJ', 'RN', 'RO',
            'RR', 'RS', 'SC', 'SE', 'SP', 'TO');

=head2 make_donation_hash $line, $resultset

Recebe uma linha no formado CSV e um resultset. Trata a linha (ver
código) e faz um hash no formato:

- as chaves são as colunas da tabela do resultset (!!!)
- os valores são os valores da linha

(!!!) Atenção: a primeira coluna do resultset (a coluna "id") é
descartada, já que não há coluna "id" correspondente nos valores da
linha.

=cut

sub make_donation_hash {
    my ($line, $rs) = @_;

    $line =~ s/^\s+|\s+$//g;
    my $original_line = $line;
    $line =~ s/^"|"$//g;
    my @line_values = split '";"', $line;

    my @columns = $rs->result_source->columns;
    shift @columns;
    my %donation_hash;
    @donation_hash{@columns} = @line_values;

    $donation_hash{dados_originais} = $original_line;

    $donation_hash{receita_valor} =~ s/^,/0\./;
    $donation_hash{receita_valor} =~ s/,/\./;

    chomp $donation_hash{dados_originais};
    chomp $donation_hash{doador_originario_nome_receita_federal}
      if $donation_hash{doador_originario_nome_receita_federal};
    chomp $donation_hash{receita_descricao}
      if $donation_hash{receita_descricao};

    return %donation_hash;
}

#$data's keys: cpf, name, party
sub add_politician {
    my ($data, $politicians_rs) = @_;

    unless ( $politicians_rs->find({ cpf => $data->{cpf} }) ) {
        my $token = make_token($data->{name}, $politicians_rs);
        my $name = ucfirst_words_br($data->{name});

        #print "Adding politician $name $token\n";

        $politicians_rs->create({ token => $token,
                                  name  => $name,
                                  party => $data->{party},
                                  cpf   => $data->{cpf}  });
    }
}

#$data's keys: cnpjf, name
sub add_financier {
    my ($data, $financiers_rs) = @_;

    unless ( $financiers_rs->find({ cnpjf => $data->{cnpjf} }) ) {
        my $token = make_token($data->{name}, $financiers_rs);
        my $name = ucfirst_words_br($data->{name});

        #print "Adding financier $name $token\n";

        $financiers_rs->create({ token => $token,
                                 name  => $name,
                                 cnpjf => $data->{cnpjf} });
    }
}

=head2 make_token

Faz tokens para politicians, financiers etc.

=cut

sub make_token {
    my ($name, $rs) = @_;
    my $token;
    my $counter = 0;
    while (1) {
        $token = lc unidecode $name;
        $token =~ s/^\s+|\s+$|\.|&|,|\(|\)|'|‘|’|-//g;
        $token =~ s/\/|\s+/-/g;
        $token .= '-' . $counter if $counter;
        $counter++;
        last unless $rs->find({ token => $token });
    }
    return $token;
}

=head2 ucfirst_words_br

Transforma CÍNTIA MOURÃO DA SILVA em Cíntia Mourão da Silva etc.

=cut

sub ucfirst_words_br {
    my $str = shift;
    my @words = split ' ', lc $str;

    for (my $i = 0; $i < @words; $i++) {
        next if $words[$i] =~ /^(da|de|di|do|du|das|dos)$/;
        $words[$i] = ucfirst $words[$i];
    }

    return join ' ', @words;
}

sub adjust_receita_valor {
    my $value = shift;
    $value =~ s/$,/0\./;
    $value =~ s/,/\./;
    return $value;
}

1;
