use utf8;
package WikiPoliticos::Schema::Result::FinbraSubfuncao;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");
__PACKAGE__->table("finbra_subfuncoes");
__PACKAGE__->add_columns(
  "subfuncao_codigo",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "nome",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "finbra_funcao_id",
  {
    data_type      => "text",
    is_foreign_key => 1,
    is_nullable    => 1,
    original       => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("subfuncao_codigo");
__PACKAGE__->has_many(
  "finbra_despesas_subfuncaos",
  "WikiPoliticos::Schema::Result::FinbraDespesasSubfuncao",
  { "foreign.finbra_subfuncao_id" => "self.subfuncao_codigo" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->belongs_to(
  "finbra_funcao",
  "WikiPoliticos::Schema::Result::FinbraFuncao",
  { funcao_codigo => "finbra_funcao_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-03-31 00:25:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hhozFkv6oV/0Wl5ScDDhZw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
