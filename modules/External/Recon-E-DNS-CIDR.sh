#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-CIDR.sh <SubdomainList(example.com.allSubdomains.txt)>"
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

file_name=` echo $1 |  sed "s/.txt//g" `

echo "Run dnsx & Extract A record with: $1 file"
dnsx -a -resp-only -l $1 -r ./wordlist/dns-resolvers.txt -o $file_name.ip-A.txt -silent > /dev/null
echo "dnsx A-Record Done & result in $file_name.ip-A.txt ==> len: ` cat $file_name.ip-A.txt | wc -l `"

echo
echo "Run dnsx & Extract MX record with: $1 file"
dnsx -mx -resp -l $1 -r ./wordlist/dns-resolvers.txt -o $file_name-mx.txt -silent > /dev/null
echo "dnsx mx-Record Done & result in $file_name-mx.txt ==> len: ` cat $file_name-mx.txt | wc -l `"

echo
echo "Run dnsx & Extract CNAME record with: $1 file"
dnsx -cname -resp -l $1 -r ./wordlist/dns-resolvers.txt -o $file_name-cname.txt -silent > /dev/null
echo "dnsx cname-Record Done & result in $file_name-cname.txt ==> len: ` cat $file_name-cname.txt | wc -l `"

echo
echo "Run cut-cdn & Extract CND Ips from: $1 file"
cut-cdn -i $file_name.ip-A.txt -o $file_name.No-cdn.txt -silent
echo "cut-cdn Done & result in $file_name.No-cdn.txt ==> len: ` cat $file_name.No-cdn.txt | wc -l `"

echo
echo "Start request to bgpview.io & find CIDRs from $file_name.No-cdn.txt"
for ip in $( cat $file_name.No-cdn.txt )
do
    curl https://api.bgpview.io/ip/$ip -s | jq -r ".data.prefixes[].prefix" | head -n 1 >> $file_name.all-ASN-ip-range.txt
    sleep 0.2
done
cat $file_name.all-ASN-ip-range.txt | sort -un > $file_name.CIDR.txt
rm $file_name.all-ASN-ip-range.txt
echo "bgpview.io request Done & result in $file_name.CIDR.txt ==> len: ` cat $file_name.CIDR.txt | wc -l `"

echo
echo "Start dnsx to resolve by PTR Record with $file_name.No-cdn.txt"
cat $file_name.No-cdn.txt | dnsx -resp-only -ptr -r ./wordlist/dns-resolvers.txt -silent > $file_name.ptr.txt
echo "dnsx-PTR Done & result in $file_name.ptr.txt ==> len: ` cat $file_name.ptr.txt | wc -l `"
echo