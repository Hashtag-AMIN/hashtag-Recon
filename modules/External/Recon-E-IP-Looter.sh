#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-IP-Looter.sh <IP(8.8.8.8)>"
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


echo "Send request to bgpview.io & find IP details of $1"

curl -s https://api.bgpview.io/ip/$1 | jq -r ".data | {PTR: .ptr_record, CIDR: [.prefixes[].prefix], ASN: .prefixes[0].asn, RIR_INFO: .rir_allocation }" | tee $1.txt

echo "bgpview.io request Done, result & length ==> ` wc -l $1.txt `"