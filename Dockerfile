FROM ubuntu:16.04
RUN apt-get update && apt-get install -y git curl wget
RUN git clone https://github.com/Aleksii/IDS-automate-deploy.git /home
RUN bash -x /home/snort.sh
RUN bash -x /home/snort_conf.sh
