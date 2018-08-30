FROM debian:buster-slim

WORKDIR /app

ADD . /app

# Install Perl and required CPAN modules
RUN apt-get update && apt-get install apt-utils -y
RUN apt-get install perl ca-certificates libio-socket-ssl-perl libmojolicious-perl -y

# Install Mojolicious
# RUN curl -L cpanmin.us | perl - Mojolicious

EXPOSE 3000

CMD airport_wx/script/airport_wx daemon
