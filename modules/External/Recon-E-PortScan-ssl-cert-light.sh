#!/bin/bash

if [ $# -ne 2 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-nmap-ssl-cert-light.sh <Domain(example.com)[mainScope-for-grep]> <Ip-Range(example.com.ASN.txt)>"
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

echo "Start Nmap for Run ssl-cert script on range for $1"

nmap -iL $2 -T4 --min-parallelism 256 --min-hostgroup 1024 --max-retries 2 -sS -Pn -p 21,22,23,25,53,80,110,161,389,443,445,465,587,636,990,993,995,1025,1701,1723,2000,2483,2484,2601,3000,3001,3128,3269,3306,3389,3690,5060,5900,8000,8008,8080,8443,9001,10443 --script ssl-cert -oN $1-ssl-cert-result.txt

cat $1-ssl-cert-result.txt | grep "ssl-cert: Subject: commonName=" | cut -d = -f2 | sort -u > $1-ssl-cert.all-domains.txt
cat $1-ssl-cert-result.txt | grep -E "Subject Alternative Name: DNS:" | cut -d : -f3 | sed s/\,\ DNS$//g | sort -u >> $1-ssl-cert.all-domains.txt
cat $1-ssl-cert-result.txt | grep -E "Subject Alternative Name: DNS:" | cut -d : -f4 | sed s/\,\ DNS$//g | sort -u >> $1-ssl-cert.all-domains.txt
cat $1-ssl-cert.all-domains.txt | sort -u | grep $1 > $1-ssl-cert-domain.txt

echo "Nmap with ssl-cert Done & final result in $1-ssl-cert-domain.txt ==> len: ` cat $1-ssl-cert-domain.txt | wc -l `"
echo "All Result & domain in $1-ssl-cert-result.txt & $1-ssl-cert.all-domains.txt" 
echo