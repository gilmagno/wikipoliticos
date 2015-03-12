use utf8;
package WikiPoliticos::Schema::Result::Location;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");
__PACKAGE__->table("locations");
__PACKAGE__->add_columns(
  "id",
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
  "parent_id",
  {
    data_type      => "text",
    is_foreign_key => 1,
    is_nullable    => 1,
    original       => { data_type => "varchar" },
  },
  "search_relevance",
  { data_type => "integer", is_nullable => 1 },
  "ibge_estado_codigo",
  { data_type => "integer", is_nullable => 1 },
  "ibge_municipio_codigo",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->has_many(
  "locations",
  "WikiPoliticos::Schema::Result::Location",
  { "foreign.parent_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->belongs_to(
  "parent",
  "WikiPoliticos::Schema::Result::Location",
  { id => "parent_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-03-12 15:41:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Z8FApMdUpoBXYlMHfOq5uQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
