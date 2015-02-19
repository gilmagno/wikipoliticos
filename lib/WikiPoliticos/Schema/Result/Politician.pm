use utf8;
package WikiPoliticos::Schema::Result::Politician;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");
__PACKAGE__->table("politicians");
__PACKAGE__->add_columns(
  "token",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "name",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "political_name",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "party",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "cpf",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("token");
__PACKAGE__->add_unique_constraint("politicians_cpf_key", ["cpf"]);
__PACKAGE__->has_many(
  "candidates_donations_2010s",
  "WikiPoliticos::Schema::Result::CandidateDonation2010",
  { "foreign.candidato_cpf" => "self.token" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "candidates_donations_2012s",
  "WikiPoliticos::Schema::Result::CandidateDonation2012",
  { "foreign.candidato_cpf" => "self.token" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "candidates_donations_2014s",
  "WikiPoliticos::Schema::Result::CandidateDonation2014",
  { "foreign.candidato_cpf" => "self.token" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "candidatures",
  "WikiPoliticos::Schema::Result::Candidature",
  { "foreign.politician_id" => "self.token" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-02-18 14:01:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jRpm2KKg6/gAhAMwkxzwNg

# Esse método assume que a consulta foi feita já ordenando as candidaturas
sub recent_candidature_str {
    my $self = shift;
    my $candidature = ($self->candidatures)[0];

    return unless $candidature;

    my @values = ($candidature->year, $candidature->political_position,
                  $candidature->state);
    push @values, $candidature->city
      if $candidature->year eq 2012 || $candidature->year eq 2010;

    return join ', ', @values;
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
