package AirportWx::Controller::Icao;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::UserAgent;
use Mojo::URL;
use Mojo::JSON 'decode_json';

sub airport {
  my $self = shift;

  # Render template "icao/airport.html.ep" with message
  $self->render(msg => 'Welcome to the ICAO airport code weather lookup!');
}

sub getWx {
  my $self = shift;
  my $ua = Mojo::UserAgent->new;
  my $url = 'https://soa.smext.faa.gov/asws/api/airport/status/';

  # Get the airport code the user submitted
  my $ac = lc $self->param('airportCode');
  # Strip off any leading "K"
  $ac =~ s/^[kK](\w{3})/$1/;
  # Combine the two
  $url = $url . $ac;

  #Execute the query and return a decoded JSON object
  my $decodedjson = decode_json ($ua->get($url)->result->body);

  $self->render(
    template => 'icao/results',
    decodedjson => $decodedjson,
  );

}

1;
