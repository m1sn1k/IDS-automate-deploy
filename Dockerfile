FROM kalilinux/kali-linux-docker:latest
RUN apt-get update && apt-get install -y git curl wget nano
RUN git clone https://github.com/Aleksii/IDS-automate-deploy.git /home
RUN bash -x /home/snort.sh
RUN bash -x /home/snort_conf.sh
