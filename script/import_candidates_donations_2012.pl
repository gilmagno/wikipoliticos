use strict;
use warnings;
use WikiPoliticos::Web::Model::DB;
use WikiPoliticos::Util;
use Parallel::ForkManager;

my $schema = WikiPoliticos::Web::Model::DB->new->schema;
my $csvs_basedir = $ARGV[0];
# my $fork_manager = Parallel::ForkManager->new(5);

for my $uf (@WikiPoliticos::Util::ufs) {
    # $fork_manager->start and next;
    process_uf($uf);
    # $fork_manager->finish;
}

sub process_uf {
    my $uf = shift;
    my $filepath = "$csvs_basedir/candidato/$uf/ReceitasCandidatos.txt";
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
    my $original_line = $line;

    $line =~ s/^"|"$//g;
    my @line_values = split '";"', $line;

    my @columns = $schema->resultset('CandidateDonation2012')->result_source->columns;
    shift @columns;

    my %donation_hash;
    @donation_hash{@columns} = @line_values;
    $donation_hash{receita_valor} =~ s/,/\./;
    $donation_hash{dados_originais} = $original_line;
    chomp($donation_hash{receita_descricao}, $donation_hash{dados_originais});

    # WikiPoliticos::Util::add_politician  (%donation_hash) ?????
    # WikiPoliticos::Util::add_financier   (%donation_hash) ?????
    # WikiPoliticos::Util::add_candidature (%donation_hash) ?????

    $schema->resultset('CandidateDonation2012')->create(\%donation_hash);
}
