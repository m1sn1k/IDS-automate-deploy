echo -ne "\n\t${YELLOW}[!] INFO:${NOCOLOR} Now it's time to edit the ${BOLD}SNORT${NOCOLOR} configuration file.\n\n"
	echo -ne "\n\t${CYAN}[i] INFO:${NOCOLOR} Add your ${BOLD}HOME_NET${NOCOLOR} address [Ex: ipvar HOME_NET 192.168.1.0/24]"
	echo -ne "\n\t${YELLOW}[!] WARNING:${NOCOLOR} Press ${BOLD}ENTER${NOCOLOR} to continue. "
	read -n 1 -s
 	nano /etc/snort/snort.conf

	echo -ne "\n\t${CYAN}[i] INFO:${NOCOLOR} Add your ${BOLD}EXTERNAL_NET${NOCOLOR} address [Ex: ipvar EXTERNAL_NET any]"
	echo -ne "\n\t${YELLOW}[!] WARNING:${NOCOLOR} Press ${BOLD}ENTER${NOCOLOR} to continue. "
	read -n 1 -s
	nano /etc/snort/snort.conf

	echo -ne "\n\t${CYAN}[i] INFO:${NOCOLOR} Adding ${BOLD}RULE_PATH${NOCOLOR} to snort.conf file"
	 sed -i 's/RULE_PATH\ \.\.\//RULE_PATH\ \/etc\/snort\//g' /etc/snort/snort.conf
	 sed -i 's/_LIST_PATH\ \.\.\//_LIST_PATH\ \/etc\/snort\//g' /etc/snort/snort.conf

	echo -ne "\n\t${CYAN}[i] INFO:${NOCOLOR} Enabling ${BOLD}local.rules${NOCOLOR} and adding a PING detection rule..."
	 sed -i 's/#include \$RULE\_PATH\/local\.rules/include \$RULE\_PATH\/local\.rules/' /etc/snort/snort.conf
	 chmod 766 /etc/snort/rules/local.rules
	 echo 'alert icmp any any -> $HOME_NET any (msg:"PING ATTACK"; sid:10000001; rev:001;)' >> /etc/snort/rules/local.rules

	#SNORT OUTPUT: UNIFIED2 --> MANDATORY || CSV/TCPDUMP/BOTH
	 sed -i 's/# unified2/output unified2: filename snort.u2, limit 128/g' /etc/snort/snort.conf
	
	echo -ne "\n\t${YELLOW}[!] WARNING:${NOCOLOR} ${BOLD}CSV${NOCOLOR} and ${BOLD}TCPdump${NOCOLOR} output will be configured\n"
	sed -i 's/# syslog/output alert_csv: \/var\/log\/snort\/alert.csv default/g' /etc/snort/snort.conf
	sed -i 's/# pcap/output log_tcpdump: \/var\/log\/snort\/snort.log/g' /etc/snort/snort.conf
				
