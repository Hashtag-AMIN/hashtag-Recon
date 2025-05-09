#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-ASN-Looter.sh <ASN(AS1234|1234)>"
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


echo "Send request to bgpview.io & find ASN details of $1"

curl -s https://api.bgpview.io/asn/$1 | jq -r ".data | {ASN: .asn, Name: .name, DES: .description_full, WEBSITE: .website, COUNTRY: .country_code, EMAIL: .email_contacts, ADDRESS: .owner_address}" | tee $1.txt

echo "bgpview.io request Done, result & length ==> ` wc -l $1.txt `"