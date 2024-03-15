#!/bin/bash

if [ $# -ne 2 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-nmap-ssl-cert-light.sh <Domain(example.com)[mainScope-for-grep]> <Ip-Range(example.com.ASN-ip-range.txt)>"
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

nmap -iL $2 -T5 --min-parallelism 256 --min-hostgroup 1024 --max-retries 2 -sS -Pn -p 21,22,23,25,53,80,110,161,216,271,280,324,375,389,443,445,448,465,488,585,587,591,593,623,636,684,695,777,808,832,990,993,995,1025,1131,1183,1184,1203,1204,1701,1723,1750,2000,2252,2381,2482,2483,2484,2601,2679,2688,2762,2793,2851,3000,3001,3077,3078,3106,3128,3183,3191,3220,3227,3269,3306,3389,3471,3496,3509,3529,3539,3660,3661,3690,3816,3864,3885,3896,3995,4035,4036,4116,4180,4335,4336,4536,4755,4843,4848,4849,5007,5060,5061,5321,5554,5783,5800,5801,5802,5803,5900,5988,5989,5990,6116,6251,6443,6480,6513,6514,6636,6770,6771,6788,6789,6842,7443,7627,7677,7872,8000,8008,8080,8088,8232,8243,8280,8443,8444,8765,8910,8990,8991,9001,9089,9294,9295,9443,9614,9762,10161,10162,10443,11751,12013,12109,15002,16992,16993,16995,20002,20003,24680,27504 --script ssl-cert -oN $1-ssl-cert-result.txt

cat $1-ssl-cert-result.txt | grep "ssl-cert: Subject: commonName=" | cut -d = -f2 | sort -u > $1-ssl-cert.all-domains.txt
cat $1-ssl-cert-result.txt | grep -E "Subject Alternative Name: DNS:" | cut -d : -f3 | sed s/\,\ DNS$//g | sort -u >> $1-ssl-cert.all-domains.txt
cat $1-ssl-cert-result.txt | grep -E "Subject Alternative Name: DNS:" | cut -d : -f4 | sed s/\,\ DNS$//g | sort -u >> $1-ssl-cert.all-domains.txt
cat $1-ssl-cert.all-domains.txt | sort -u | grep $1 > $1-ssl-cert-domain.txt

echo "Nmap with ssl-cert Done & final result in $1-ssl-cert-domain.txt ==> len: ` cat $1-ssl-cert-domain.txt | wc -l `"
echo "All Result & domain in $1-ssl-cert-result.txt & $1-ssl-cert.all-domains.txt" 
echo

# sort -r -k3 /usr/share/nmap/nmap-services | tr "\t" " " | cut -d " " -f1-2 |  grep -E "(ssl|tls|https|http)" | grep -Eo "([0-9]*/tcp|[0-9]*/udp)" | cut -d / -f1 | sort -un | tr "\n" "," | sed "s/\,$//"