use utf8;
package WikiPoliticos::Schema::Result::FinbraFuncao;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");
__PACKAGE__->table("finbra_funcoes");
__PACKAGE__->add_columns(
  "funcao_codigo",
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
);
__PACKAGE__->set_primary_key("funcao_codigo");
__PACKAGE__->has_many(
  "finbra_despesas_funcaos",
  "WikiPoliticos::Schema::Result::FinbraDespesasFuncao",
  { "foreign.finbra_funcao_id" => "self.funcao_codigo" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "finbra_subfuncoes",
  "WikiPoliticos::Schema::Result::FinbraSubfuncao",
  { "foreign.finbra_funcao_id" => "self.funcao_codigo" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-03-31 00:25:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3uUBI9TmFj0TKPidiuA+Dw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
