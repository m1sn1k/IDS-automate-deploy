	sed -i "s/include \$RULE\_PATH/#include \$RULE\_PATH/" /etc/snort/snort.conf
	snort -T -i ens160 -c /etc/snort/snort.conf
	echo "alert icmp any any -> $HOME_NET any (msg:"ICMP test detected"; GID:1; sid:10000001; rev:001; classtype:icmp-event;)" > /etc/snort/rules/local.rules
	echo "1 || 10000001 || 001 || icmp-event || 0 || ICMP Test detected || url,tools.ietf.org/html/rfc792" > /etc/snort/sid-msg.map
	snort -T -c /etc/snort/snort.conf
				
