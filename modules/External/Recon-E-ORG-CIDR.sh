#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-ORG-CIDR.sh <SubdomainList(example.com.Subdomains.txt)>"
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

file_neame=`echo $1 |  sed "s/.txt//g"`

for HOST in $( cat $1 )
do
    echo "result of: $HOST:" | tee -a $file_neame-whois.txt 
    for ip in $(dig a $HOST +short)
        do 
            echo -e "IP: $ip" | tee -a $file_neame-whois.txt
            result=` whois $ip | sort -u | grep -e "^CIDR\|^inetnum\|^Organization\|^person\|^source\|^.*Email\|^Ref\|^origin\|^NetName" | grep -viE "(cloudflare|Abuse|Tech|OrgNOC|Arvan)" | tr -s "\n" `
            final_res+=$result"\n"
        done
    echo -e "\n$final_res" | sort -u | tee -a $file_neame-whois.txt
    echo -e "\n====================== " | tee -a $file_neame-whois.txt
done