use utf8;
package WikiPoliticos::Schema::Result::FinbraDespesasFuncao;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");
__PACKAGE__->table("finbra_despesas_funcao");
__PACKAGE__->add_columns(
  "ano",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "location_id",
  {
    data_type      => "text",
    is_foreign_key => 1,
    is_nullable    => 0,
    original       => { data_type => "varchar" },
  },
  "finbra_funcao_id",
  {
    data_type      => "text",
    is_foreign_key => 1,
    is_nullable    => 0,
    original       => { data_type => "varchar" },
  },
  "valor",
  { data_type => "numeric", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("ano", "location_id", "finbra_funcao_id");
__PACKAGE__->belongs_to(
  "finbra_funcao",
  "WikiPoliticos::Schema::Result::FinbraFuncao",
  { funcao_codigo => "finbra_funcao_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "CASCADE" },
);
__PACKAGE__->belongs_to(
  "location",
  "WikiPoliticos::Schema::Result::Location",
  { id => "location_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-03-31 00:25:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rAiJeuB3dI6zHUWqdfKBpQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
