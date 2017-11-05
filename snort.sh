RED='\033[0;31m'
ORANGE='\033[0;205m'
YELLOW='\033[0;93m'
GREEN='\033[0;32m'
CYAN='\033[0;96m'
BLUE='\033[0;34m'
VIOLET='\033[0;35m'
NOCOLOR='\033[0m'
BOLD='\033[1m'
HOME=/home

echo -ne "\n\t${CYAN}[i] INFO:${NOCOLOR} Installing dependencies.\n\n"
	sudo apt-get install -y --force-yes build-essential libpcap-dev libpcre3-dev libdumbnet-dev bison flex zlib1g-dev git locate vim
	
	#Downloading DAQ and SNORT
	cd $HOME 
	mkdir snort_src && cd snort_src
	pwd

	#Installing DAQ
	wget https://www.snort.org/downloads/snort/daq-2.0.6.tar.gz
	echo -ne "\n\t${CYAN}[i] INFO:${NOCOLOR} Installing ${BOLD}$DAQ${NOCOLOR}.\n\n"
	tar xvfz $DAQ.tar.gz
	mv $HOME/snort_src/daq-*/ $HOME/snort_src/daq                     
	cd $HOME/snort_src/daq
	./configure && make && sudo make install 
	echo -ne "\n\t${GREEN}[+] INFO:${NOCOLOR} ${BOLD}$DAQ${NOCOLOR} installed successfully.\n\n"
	
	#Installing SNORT
	echo -ne "\n\t${CYAN}[i] INFO:${NOCOLOR} Installing ${BOLD}$SNORT${NOCOLOR}.\n\n"
	wget  https://www.snort.org/downloads/snort/snort-2.9.11.tar.gz
	tar xvfz $SNORT.tar.gz > /dev/null 2>&1
	rm -r *.tar.gz > /dev/null 2>&1
	mv snort-*/ snort           
	cd snort
	./configure --enable-sourcefire && make && sudo make install
	echo -ne "\n\t${GREEN}[+] INFO:${NOCOLOR} ${BOLD}$SNORT${NOCOLOR} installed successfully.\n\n"
	cd ..
	
	sudo ldconfig
	sudo ln -s /usr/local/bin/snort /usr/sbin/snort

	#Adding SNORT user and group for running SNORT
	echo -ne "\n\t${CYAN}[i] INFO:${NOCOLOR} Adding user and group ${BOLD}SNORT${NOCOLOR}.\n\n"
	sudo groupadd snort
	sudo useradd snort -r -s /sbin/nologin -c SNORT_IDS -g snort
	sudo mkdir /etc/snort > /dev/null 2>&1
	sudo mkdir /etc/snort/rules > /dev/null 2>&1
	sudo mkdir /etc/snort/preproc_rules > /dev/null 2>&1
	sudo touch /etc/snort/rules/white_list.rules /etc/snort/rules/black_list.rules /etc/snort/rules/local.rules > /dev/null 2>&1
	sudo mkdir /var/log/snort > /dev/null 2>&1
	sudo mkdir /usr/local/lib/snort_dynamicrules > /dev/null 2>&1
	sudo chmod -R 5775 /etc/snort > /dev/null 2>&1
	sudo chmod -R 5775 /var/log/snort > /dev/null 2>&1
	sudo chmod -R 5775 /usr/local/lib/snort_dynamicrules > /dev/null 2>&1
	sudo chown -R snort:snort /etc/snort > /dev/null 2>&1
	sudo chown -R snort:snort /var/log/snort > /dev/null 2>&1
	sudo chown -R snort:snort /usr/local/lib/snort_dynamicrules > /dev/null 2>&1
	
	sudo cp ~/snort_src/snort/etc/*.conf* /etc/snort > /dev/null 2>&1
	sudo cp ~/snort_src/snort/etc/*.map /etc/snort > /dev/null 2>&1
	
	sudo sed -i 's/include \$RULE\_PATH/#include \$RULE\_PATH/' /etc/snort/snort.conf
	
	echo -ne "\n\t${CYAN}[i] INFO:${NOCOLOR} /var/log/snort and /etc/snort created and configurated.\n\n"
	sudo /usr/local/bin/snort -V
	echo -ne "\n\t${GREEN}[+] INFO:${NOCOLOR} ${BOLD}SNORT${NOCOLOR} is successfully installed and configurated!"
