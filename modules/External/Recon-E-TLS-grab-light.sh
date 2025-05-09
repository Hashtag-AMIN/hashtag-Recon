#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-TLS-grab.sh <List of hosts(IP|CIDR|Domain)"
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

echo "Start httpx with -tls-grap flag on $1"

httpx -l $1 -p 21,22,23,25,53,80,110,161,389,443,445,465,587,636,990,993,995,1025,1701,1723,2000,2483,2484,2601,3000,3001,3128,3269,3306,3389,3690,5060,5900,8000,8008,8080,8443,9001,10443 -json -tls-grab -silent | jq -r 'select(.tls.subject_an != null) | .tls.subject_an[]' | sed 's/*\.//g' | sort -u | tee $file_name-tlsgrab.txt

echo "httpx Done, result & length ==> ` wc -l $file_name-tlsgrab.txt `"