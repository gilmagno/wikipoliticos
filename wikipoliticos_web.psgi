use strict;
use warnings;

use WikiPoliticos::Web;

my $app = WikiPoliticos::Web->apply_default_middlewares(WikiPoliticos::Web->psgi_app);
$app;

