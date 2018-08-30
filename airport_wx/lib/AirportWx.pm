package AirportWx;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by "my_app.conf"
  my $config = $self->plugin('Config');

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer') if $config->{perldoc};

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to(controller => 'icao', action => 'airport');
  $r->get('/icao')->to(controller => 'icao', action => 'airport');
  $r->post('/icao')->to(controller => 'icao', action => 'getWx');


}

1;
