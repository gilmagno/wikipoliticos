package WikiPoliticos::Web::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
    ENCODING => 'UTF-8',
    WRAPPER => 'wrapper.tt',
);

=head1 NAME

WikiPoliticos::Web::View::HTML - TT View for WikiPoliticos::Web

=head1 DESCRIPTION

TT View for WikiPoliticos::Web.

=head1 SEE ALSO

L<WikiPoliticos::Web>

=head1 AUTHOR

sgrs,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
