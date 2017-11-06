
RED='\033[0;31m'
ORANGE='\033[0;205m'
YELLOW='\033[0;93m'
GREEN='\033[0;32m'
CYAN='\033[0;96m'
BLUE='\033[0;34m'
VIOLET='\033[0;35m'
NOCOLOR='\033[0m'
BOLD='\033[1m'

echo -ne "\n\t${CYAN}[i] INFO:${NOCOLOR} Installing dependencies.\n\n"
	 apt-get install -y --force-yes build-essential libpcap-dev libpcre3-dev libdumbnet-dev bison flex zlib1g-dev git locate vim
	
	#Downloading DAQ and SNORT
	cd $HOME && mkdir snort_src && cd snort_src
	echo -ne "\n\t${CYAN}[i] INFO:${NOCOLOR} Downloading ${BOLD}$DAQ${NOCOLOR}.\n\n"
	wget --no-check-certificate -P $HOME/snort_src https://www.snort.org/downloads/snort/daq-2.0.6.tar.gz 
	echo -ne "\n\t${CYAN}[i] INFO:${NOCOLOR} Downloading ${BOLD}$SNORT${NOCOLOR}.\n\n"
	wget --no-check-certificate -P $HOME/snort_src https://www.snort.org/downloads/snort/snort-2.9.11.tar.gz
	
	#Installing DAQ
	cd $HOME/snort_src/
	echo -ne "\n\t${CYAN}[i] INFO:${NOCOLOR} Installing ${BOLD}$DAQ${NOCOLOR}.\n\n"
	tar xvfz daq-2.0.6.tar.gz
	mv $HOME/snort_src/daq-*/ $HOME/snort_src/daq                     
	cd $HOME/snort_src/daq
	./configure && make &&  make install 
	echo -ne "\n\t${GREEN}[+] INFO:${NOCOLOR} ${BOLD}$DAQ${NOCOLOR} installed successfully.\n\n"
	
	#Installing SNORT
	cd $HOME/snort_src
	echo -ne "\n\t${CYAN}[i] INFO:${NOCOLOR} Installing ${BOLD}$SNORT${NOCOLOR}.\n\n"
	tar xvfz snort-2.9.11.tar.gz > /dev/null 2>&1
	rm -r *.tar.gz > /dev/null 2>&1
	mv snort-*/ snort           
	cd snort
	./configure --enable-sourcefire && make &&  make install
	echo -ne "\n\t${GREEN}[+] INFO:${NOCOLOR} ${BOLD}$SNORT${NOCOLOR} installed successfully.\n\n"
	cd ..
	
	 ldconfig
	 ln -s /usr/local/bin/snort /usr/sbin/snort

	#Adding SNORT user and group for running SNORT
	echo -ne "\n\t${CYAN}[i] INFO:${NOCOLOR} Adding user and group ${BOLD}SNORT${NOCOLOR}.\n\n"
	 groupadd snort
	 useradd snort -r -s /sbin/nologin -c SNORT_IDS -g snort
	 mkdir /etc/snort > /dev/null 2>&1
	 mkdir /etc/snort/rules > /dev/null 2>&1
	 mkdir /etc/snort/preproc_rules > /dev/null 2>&1
	 touch /etc/snort/rules/white_list.rules /etc/snort/rules/black_list.rules /etc/snort/rules/local.rules > /dev/null 2>&1
	 mkdir /var/log/snort > /dev/null 2>&1
	 mkdir /usr/local/lib/snort_dynamicrules > /dev/null 2>&1
	 chmod -R 5775 /etc/snort > /dev/null 2>&1
	 chmod -R 5775 /var/log/snort > /dev/null 2>&1
	 chmod -R 5775 /usr/local/lib/snort_dynamicrules > /dev/null 2>&1
	 chown -R snort:snort /etc/snort > /dev/null 2>&1
	 chown -R snort:snort /var/log/snort > /dev/null 2>&1
	 chown -R snort:snort /usr/local/lib/snort_dynamicrules > /dev/null 2>&1
	
	 cp ~/snort_src/snort/etc/*.conf* /etc/snort > /dev/null 2>&1
	sdo cp ~/snort_src/snort/etc/*.map /etc/snort > /dev/null 2>&1
	
	 sed -i 's/include \$RULE\_PATH/#include \$RULE\_PATH/' /etc/snort/snort.conf
	
	echo -ne "\n\t${CYAN}[i] INFO:${NOCOLOR} /var/log/snort and /etc/snort created and configurated.\n\n"
	 /usr/local/bin/snort -V
	echo -ne "\n\t${GREEN}[+] INFO:${NOCOLOR} ${BOLD}SNORT${NOCOLOR} is successfully installed and configurated!"



#sed -i 's/RULE_PATH\ \.\.\//RULE_PATH\ \/etc\/snort\//g' /etc/snort/snort.conf
#sed -i 's/_LIST_PATH\ \.\.\//_LIST_PATH\ \/etc\/snort\//g' /etc/snort/snort.conf
#sed -i 's/#include \$RULE\_PATH\/local\.rules/include \$RULE\_PATH\/local\.rules/' /etc/snort/snort.conf
#chmod 766 /etc/snort/rules/local.rules
#echo 'alert icmp any any -> $HOME_NET any (msg:"PING ATTACK"; sid:10000001; rev:001;)' >> /etc/snort/rules/local.rules
#sed -i 's/# unified2/output unified2: filename snort.u2, limit 128/g' /etc/snort/snort.conf
#sed -i 's/# syslog/output alert_csv: \/var\/log\/snort\/alert.csv default/g' /etc/snort/snort.conf
#sed -i 's/# pcap/output log_tcpdump: \/var\/log\/snort\/snort.log/g' /etc/snort/snort.conf
