use strict;
use warnings;
use WikiPoliticos::Web::Model::DB;
use WikiPoliticos::Util;
use Parallel::ForkManager;

my $schema = WikiPoliticos::Web::Model::DB->new->schema;
my $csvs_basedir = $ARGV[0];
my $fork_manager = Parallel::ForkManager->new(7);

for my $uf (@WikiPoliticos::Util::ufs) {
    $fork_manager->start and next;
    process_uf($uf);
    $fork_manager->finish;
}

sub process_uf {
    my $uf = shift;
    my $filepath = "$csvs_basedir/comite/$uf/ReceitasComites.txt";
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
      ($line, $schema->resultset('CommitteeDonation2010'));
    $schema->resultset('CommitteeDonation2010')->create(\%donation_hash);
}
