use utf8;
package WikiPoliticos::Schema::Result::Candidature;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");
__PACKAGE__->table("candidatures");
__PACKAGE__->add_columns(
  "politician_id",
  {
    data_type      => "text",
    is_foreign_key => 1,
    is_nullable    => 0,
    original       => { data_type => "varchar" },
  },
  "year",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "state",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "city",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "ue_numero",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "political_position",
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
  "candidato_sequencial",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "candidato_numero",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("politician_id", "year");
__PACKAGE__->belongs_to(
  "politician",
  "WikiPoliticos::Schema::Result::Politician",
  { token => "politician_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-02-17 17:03:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7GVQS5CDktemxxrFnHVm5Q

sub donations_sum {
    my $self = shift;
    my $politician = $self->politician;
    my $method = 'donations_' . $self->year . '_sum';
    my $donations_sum = $politician->$method;
    return $donations_sum ? $donations_sum : undef;
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
