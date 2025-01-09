#!/bin/bash

if [ $# -ne 2 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-PortScan-ssl-cert-heavy.sh <Domain(example.com)[mainScope-for-grep]> <Ip-Range(example.com.ASN-ip-range.txt)>"
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

nmap -iL $2 -T5 --min-parallelism 64 --min-hostgroup 64 --max-retries 2 --max-scan-delay 20ms --min-rate 500 -sS -Pn -p 21,22,23,25,53,80,110,161,216,261,271,280,324,375,389,443,445,448,465,488,563,585,587,591,593,614,623,631,636,664,684,695,777,808,832,853,989,990,992,993,994,995,1025,1129,1131,1183,1184,1203,1204,1701,1723,1750,2000,2221,2252,2376,2381,2478,2479,2482,2483,2484,2601,2679,2688,2762,2793,2851,3000,3001,3077,3078,3106,3128,3183,3191,3220,3227,3269,3306,3389,3410,3424,3471,3496,3509,3529,3539,3568,3660,3661,3690,3713,3747,3766,3816,3864,3885,3896,3995,4031,4035,4036,4062,4064,4081,4083,4116,4180,4335,4336,4536,4590,4740,4755,4843,4848,4849,5007,5060,5061,5321,5349,5443,5554,5671,5684,5783,5800,5801,5802,5803,5868,5900,5986,5988,5989,5990,6116,6209,6251,6443,6480,6513,6514,6619,6636,6697,6699,6770,6771,6788,6789,6842,7123,7443,7627,7673,7674,7677,7775,7872,8000,8008,8080,8088,8232,8243,8280,8333,8443,8444,8765,8910,8989,8990,8991,9001,9089,9294,9295,9318,9333,9443,9444,9614,9762,9802,9902,9929,10000,10161,10162,10443,11751,12013,12109,14143,15002,16992,16993,16995,18333,19333,20002,20003,24680,27504,41230 --script ssl-cert -oN $1-ssl-port.txt > /dev/null

grep "ssl-cert: Subject: commonName=" $1-ssl-port.txt | cut -d = -f2 | sort -u > $1-ssl-domain-tmp.txt
grep -E "Subject Alternative Name: DNS:" $1-ssl-port.txt | cut -d : -f3 | sed s/\,\ DNS$//g | sort -u >> $1-ssl-domain-tmp.txt
grep -E "Subject Alternative Name: DNS:" $1-ssl-port.txt | cut -d : -f4 | sed s/\,\ DNS$//g | sort -u >> $1-ssl-domain-tmp.txt
sort -u $1-ssl-domain-tmp.txt | grep $1 > $1-ssl-domain.txt
rm $1-ssl-domain-tmp.txt

echo "Nmap with ssl-cert Done, result & length ==> ` wc -l $1-ssl-domain.txt `"
echo "All Result in $1-ssl-port.txt & domains in $1-ssl-domain.txt" 
echo