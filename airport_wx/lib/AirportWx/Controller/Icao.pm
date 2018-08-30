package AirportWx::Controller::Icao;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::UserAgent;
use Mojo::URL;
use Mojo::JSON 'decode_json';
use Mojo::DOM;

sub airport {
  my $self = shift;

  # Render template "icao/airport.html.ep"
  $self->render();
}

sub getWx {
  my $self = shift;
  my $ua = Mojo::UserAgent->new;

  # Get the airport code the user submitted
  my $ac = lc $self->param('airportCode');
  # Strip off any leading "K"
  $ac =~ s/^[kK](\w{3})/$1/;

  my $FAAurl = 'https://soa.smext.faa.gov/asws/api/airport/status/';
  my $AWCurl = Mojo::URL->new('https://aviationweather.gov/adds/dataserver_current/httpparam')->query(
    dataSource => 'metars',
    requestType => 'retrieve',
    format => 'xml',
    hoursBeforeNow => 1,
    mostRecent => 'true',
    stationString => "K" . uc($ac)
  );

  #Execute the query and return a decoded JSON object
  my $decodedjson = decode_json ($ua->get($FAAurl . $ac)->result->body);
  my $AWCdom = Mojo::DOM->new($ua->get($AWCurl)->result->body);

  $self->render(
    template => 'icao/results',
    decodedjson => $decodedjson,
    AWCdom => $AWCdom
  );

}

1;
