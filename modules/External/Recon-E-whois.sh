#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-whois.sh <SubdomainList(example.com.Subdomains.txt)>"
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
                                                          Hashtag-Recon
                                                  https://github.com/hashtag-amin
                                                  
EOF

file_name=` echo $1 | sed -e "s/.txt$//" -e "s/\*//" `

for HOST in $( cat $1 )
do
    IPs=` echo $HOST | dnsx -silent -resp-only `
    if [ -n "$IPs" ];
    then
        echo "result of: $HOST:" | tee -a $file_name-whois.txt
        for ip in $IPs
        do
            echo -e "IP: $ip" | tee -a $file_name-whois.txt
            result=` whois $ip | sort -u | grep -e "^CIDR\|^inetnum\|^Organization\|^person\|^source\|^.*Email\|^Ref\|^origin\|^NetName\|^OriginAS\|^OrgTech.*\|^phone" | grep -viE "(cloudflare|Abuse|OrgNOC|Arvan)" | tr -s "\n" `
            final_res+=$result"\n"
        done
        echo -e "\n$final_res" | sort -u | tee -a $file_name-whois.txt
        echo -e "\n============================================ " | tee -a $file_name-whois.txt
    fi
done