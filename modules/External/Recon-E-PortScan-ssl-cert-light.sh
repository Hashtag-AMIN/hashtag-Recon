#!/bin/bash

if [ $# -ne 2 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-PortScan-ssl-cert-light.sh <Domain(example.com)[mainScope-for-grep]> <Ip-Range(example.com.ASN.txt)>"
    exit
fi

cat << EOF

     _     _          _                            ______ 
    (_)   (_)        | |     _                    (_____ \\
    ______ _____  ___| |__ _| |_ _____  ____ _____ _____) )_____  ____ ___  ____
   | ___  (____ |/___|  _ (_   _(____ |/ _  (_____|  __  /| ___ |/ ___/ _ \|  _ \\
  | |   | / ___ |___ | | | || |_/ ___ ( (_| |     | |  \ \| ____( (__| |_| | | | |
  |_|   |_\_____(___/|_| |_| \__\_____|\___ |     |_|   |_|_____)\____\___/|_| |_|
                                      (_____|         
                                                          Hashtag_AMIN
                                                  https://github.com/hashtag-amin
                                                  
EOF

echo "Start Nmap for Run ssl-cert script range on $1"

nmap -iL $2 -T5 --min-parallelism 64 --min-hostgroup 64 --max-retries 2 --max-scan-delay 20ms --min-rate 500 -sS -Pn -p 21,22,23,25,53,80,110,161,389,443,445,465,587,636,990,993,995,1025,1701,1723,2000,2483,2484,2601,3000,3001,3128,3269,3306,3389,3690,5060,5900,8000,8008,8080,8443,9001,10443 --script ssl-cert -oN $1-ssl-port.txt > /dev/null

grep "ssl-cert: Subject: commonName=" $1-ssl-port.txt | cut -d = -f2 | sort -u > $1-ssl-domain-tmp.txt
grep -E "Subject Alternative Name: DNS:" $1-ssl-port.txt | cut -d : -f3 | sed s/\,\ DNS$//g | sort -u >> $1-ssl-domain-tmp.txt
grep -E "Subject Alternative Name: DNS:" $1-ssl-port.txt | cut -d : -f4 | sed s/\,\ DNS$//g | sort -u >> $1-ssl-domain-tmp.txt
sort -u $1-ssl-domain-tmp.txt | grep $1 > $1-ssl-domain.txt
rm $1-ssl-domain-tmp.txt

echo "Nmap with ssl-cert Done, result & length ==> ` wc -l $1-ssl-domain.txt `"
echo "All Result in $1-ssl-port.txt & Domains in $1-ssl-domain.txt"
echo

# sort -r -k3 /usr/share/nmap/nmap-services | grep -iE "(ssl|tls)" | tr "\t" " " | cut -d " " -f2 | cut -d / -f1 | sort -un | tr "\n" "," | sed -e "s/\,$//" -e "s/^From,//"