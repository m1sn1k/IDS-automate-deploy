# IDS-automate-deploy
Snort + Barnyard2 + Pulledpork + Snorby

Now make.


Deploy and configeure Snort with PING rule 

#Dowload script
git clone https://github.com/Aleksii/IDS-automate-deploy.git
cd IDS-automate-deploy
#Create image
docker build -t snort .
#Run image and connect
docker run -it --rm --net=host snort /bin/bash
#Run snort IDS
snort -A console -q -u snort -g snort -c /etc/snort/snort.conf -i eth0

And try ping it and see rezult:

11/06-10:41:44.509378  [**] [1:10000001:1] PING ATTACK [**] [Priority: 0] {ICMP} 172.16.61.1 -> 172.16.61.158
11/06-10:41:44.509426  [**] [1:10000001:1] PING ATTACK [**] [Priority: 0] {ICMP} 172.16.61.158 -> 172.16.61.1
11/06-10:41:45.512404  [**] [1:10000001:1] PING ATTACK [**] [Priority: 0] {ICMP} 172.16.61.1 -> 172.16.61.158
11/06-10:41:45.512445  [**] [1:10000001:1] PING ATTACK [**] [Priority: 0] {ICMP} 172.16.61.158 -> 172.16.61.1



