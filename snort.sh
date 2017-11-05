apt-get update && \
    apt-get install -y \
        python-setuptools \
        python-pip \
        python-dev \
        wget \
        build-essential \
        bison \
        flex \
        libpcap-dev \
        libpcre3-dev \
        libdumbnet-dev \
        zlib1g-dev \
        iptables-dev \
        libnetfilter-queue1 \
        tcpdump \
        unzip \
        vim && pip install -U pip dpkt snortunsock

# Define working directory.
cd /opt

wget https://www.snort.org/downloads/snort/daq-2.0.6.tar.gz \
    && tar xvfz daq-2.0.6.tar.gz \
    && cd daq-2* \
    && ./configure; make; make install


wget https://www.snort.org/downloads/snort/snort-2.9.11.tar.gz \
    && tar xvfz snort-2.9.11.tar.gz \
    && cd snort-2* \
    && ./configure; make; make install

ldconfig

mysnortrules /opt
mkdir -p /var/log/snort && \
    mkdir -p /usr/local/lib/snort_dynamicrules && \
    mkdir -p /etc/snort && \
    mkdir -p /etc/snort/rules && \
    mkdir -p /etc/snort/preproc_rules && \
    mkdir -p /etc/snort/so_rules && \
    mkdir -p /etc/snort/etc && \

    # mysnortrules rules
    cp -r /opt/rules /etc/snort/rules && \
    # Due to empty folder so mkdir
    mkdir -p /etc/snort/preproc_rules && \
    mkdir -p /etc/snort/so_rules && \
    cp -r /opt/preproc_rules /etc/snort/preproc_rules && \
    cp -r /opt/so_rules /etc/snort/so_rules && \
    cp -r /opt/etc /etc/snort/etc && \

    # snapshot2972 rules
    # cp -r /opt/rules /etc/snort/rules && \
    # cp -r /opt/preproc_rules /etc/snort/preproc_rules && \
    # cp -r /opt/so_rules /etc/snort/so_rules && \
    # cp -r /opt/etc /etc/snort/etc && \

    # touch /etc/snort/rules/local.rules && \
    touch /etc/snort/rules/white_list.rules /etc/snort/rules/black_list.rules

# Clean up APT when done.
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    /opt/snort-snort-2.9.11.tar.gz /opt/daq-2.0.6.tar.gz
