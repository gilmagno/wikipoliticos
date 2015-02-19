use strict;
use warnings;
use WikiPoliticos::Web::Model::DB;
use WikiPoliticos::Util;
use Parallel::ForkManager;

my $schema = WikiPoliticos::Web::Model::DB->new->schema;
my $csvs_basedir = $ARGV[0];
my $fork_manager = Parallel::ForkManager->new(3);
my %checked_cnpjfs;

my $financiers_search = $schema->resultset('Financier')->search;
while ( my $financier = $financiers_search->next) {
    $checked_cnpjfs{ $financier->cnpjf } = 1;
}

for my $uf (@WikiPoliticos::Util::ufs) {
    $fork_manager->start and next;
    process_uf($uf);
    $fork_manager->finish;
}

sub process_uf {
    my $uf = shift;
    my $filepath = "$csvs_basedir/comite/$uf/ReceitasComites.txt";
    print "$filepath\n";
    open my $fh, '<:utf8', $filepath;
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
      ($line, $schema->resultset('CommitteeDonation2012'));

    return if $checked_cnpjfs{ $donation_hash{doador_cnpjf} };
    $checked_cnpjfs{ $donation_hash{doador_cnpjf} } = 1;

    my $doador_nome = $donation_hash{doador_nome_receita_federal} ?
      $donation_hash{doador_nome_receita_federal} :
      $donation_hash{doador_nome};

    WikiPoliticos::Util::add_financier
        ( { cnpjf => $donation_hash{doador_cnpjf},
            name  => $doador_nome },
          $schema->resultset('Financier') );
}
