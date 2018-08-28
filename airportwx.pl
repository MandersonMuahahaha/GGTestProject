use strict;
use warnings;
use utf8;

use Mojolicious::Lite;

get '/' => sub {
  my $c = shift;
  my $icao = $c->param('icao');
  $c->render(text => "Pulling weather for $icao");
};

app->start;
