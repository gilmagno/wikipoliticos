use utf8;
package WikiPoliticos::Schema::Result::Financier;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");
__PACKAGE__->table("financiers");
__PACKAGE__->add_columns(
  "name",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "token",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "cnpjf",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "economic_sector",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "economic_sector_code",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("token");
__PACKAGE__->add_unique_constraint("financiers_cnpjf_key", ["cnpjf"]);
__PACKAGE__->has_many(
  "candidates_donations_2010s",
  "WikiPoliticos::Schema::Result::CandidateDonation2010",
  { "foreign.doador_cnpjf" => "self.token" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "candidates_donations_2012s",
  "WikiPoliticos::Schema::Result::CandidateDonation2012",
  { "foreign.doador_cnpjf" => "self.token" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "candidates_donations_2014s",
  "WikiPoliticos::Schema::Result::CandidateDonation2014",
  { "foreign.doador_cnpjf" => "self.token" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "committees_donations_2010s",
  "WikiPoliticos::Schema::Result::CommitteeDonation2010",
  { "foreign.doador_cnpjf" => "self.token" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "committees_donations_2012s",
  "WikiPoliticos::Schema::Result::CommitteeDonation2012",
  { "foreign.doador_cnpjf" => "self.token" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "committees_donations_2014s",
  "WikiPoliticos::Schema::Result::CommitteeDonation2014",
  { "foreign.doador_cnpjf" => "self.token" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "parties_donations_2010s",
  "WikiPoliticos::Schema::Result::PartyDonation2010",
  { "foreign.doador_cnpjf" => "self.token" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "parties_donations_2012s",
  "WikiPoliticos::Schema::Result::PartyDonation2012",
  { "foreign.doador_cnpjf" => "self.token" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "parties_donations_2014s",
  "WikiPoliticos::Schema::Result::PartyDonation2014",
  { "foreign.doador_cnpjf" => "self.token" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-02-18 14:01:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/t9xZhQ0IwD/10FOSfYZlA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
