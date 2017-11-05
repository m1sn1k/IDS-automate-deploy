FROM debian:jessie
RUN echo 'deb http://deb.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/backports.list
RUN apt-get update && apt-get install -y git curl wget
RUN git clone https://github.com/Aleksii/IDS-automate-deploy.git /home
RUN bash -x /home/IDS-automate-deploy/snort.sh
