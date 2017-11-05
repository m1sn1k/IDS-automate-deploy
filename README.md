# IDS-automate-deploy
Snort + Barnyard2 + Pulledpork + Snorby


Script snort.sh
Deploy snort system without snort.conf (rules file)
For test need add  " alert icmp any any -> any any (msg:"Pinging...";sid:1000004;) " to /etc/snort/snort.conf file andd start 
snort -i eth0 -c /etc/snort/etc/snort.conf -A console . 




