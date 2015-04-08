use strict;
use warnings;
use WikiPoliticos::Web::Model::DB;
use WikiPoliticos::Util;
use Parallel::ForkManager;

my $schema = WikiPoliticos::Web::Model::DB->new->schema;
my $csvs_basedir = $ARGV[0];
my $fork_manager = Parallel::ForkManager->new(3);
my %checked_cpfs;

my $candidatures_rs = $schema->resultset('Candidature')->search_rs
  ({ year => 2010 }, { prefetch => 'politician' });

while (my $candidature = $candidatures_rs->next) {
    $checked_cpfs{ $candidature->politician->cpf } = 1;
}

for my $uf (@WikiPoliticos::Util::ufs) {
     $fork_manager->start and next;
    process_uf($uf);
     $fork_manager->finish;
}

sub process_uf {
    my $uf = shift;
    my $filepath = "$csvs_basedir/candidato/$uf/ReceitasCandidatos.txt";
    print "$filepath\n";
    open my $fh, '<:encoding(latin1)', $filepath;
    process_fh($fh);
    close $fh;
}

sub process_fh {
    my $fh = shift;
    readline $fh; # discards first line
    for my $line (<$fh>) { process_line($line) }
}

sub process_line {
    my $line = shift;
    my %donation_hash = WikiPoliticos::Util::make_donation_hash
      ($line, $schema->resultset('CandidateDonation2010'));

    return if $checked_cpfs{ $donation_hash{candidato_cpf} };
    $checked_cpfs{ $donation_hash{candidato_cpf} } = 1;

    my $politician = $schema->resultset('Politician')->find
      ({ cpf => $donation_hash{candidato_cpf} });

    unless ($politician) {
        print "Politico nas doacoes, mas nao na tabela politicians:\n",
          "\t$donation_hash{candidato_nome} $donation_hash{candidato_cpf}\n";
          return;
    }

    my %candidature_hash =
      (politician_id        => $politician->token,
       year                 => 2010,
       state                => $donation_hash{uf},
       # city                 => $donation_hash{municipio},
       # ue_numero            => $donation_hash{ue_numero},
       political_position   => $donation_hash{cargo},
       party                => $donation_hash{partido_sigla},
       # candidato_sequencial => $donation_hash{candidato_sequencial},
       candidato_numero     => $donation_hash{candidato_numero});

    $candidatures_rs->create(\%candidature_hash);
}
