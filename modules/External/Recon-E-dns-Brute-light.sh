#!/bin/bash

if [ $# -ne 2 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-dns-Brute.sh <Domain(example.com)> <SubdomainList(example.com.resolve.txt)>"
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

echo "Run shuffledns & Brute force on: $1"
shuffledns -d $1 -r ./wordlist/dns-resolvers.txt -w ./wordlist/dns-wordlist-light.txt -silent -o $1.dnsBrute.txt
echo "shuffledns Done & result in $1.dnsBrute.txt ==> len: ` cat $1.dnsBrute.txt | wc -l `"

echo "Run dnsgen on: $1"
cat $2 $1.dnsBrute.txt | sort -u | dnsgen -w ./wordlist/dns-dnsgen-wordlist-light.txt - > $1.dnsgen.txt
echo "dnsgen Done & result in $1.dnsgen.txt ==> len: ` cat $1.dnsgen.txt | wc -l `"

echo "Run shuffledns & Resolving on: $1.dnsgen.txt"
shuffledns -l $1.dnsgen.txt -r ./wordlist/dns-resolvers.txt -silent -o $1.dnsBrute-gen.txt
echo "shuffledns Done & result in $1.dnsBrute-gen.txt ==> len: ` cat $1.dnsBrute-gen.txt | wc -l `"

echo
echo "All Resolving Subdomain in $1.dnsBrute-gen.txt $1.dnsBrute.txt ==> len: ` cat $1.dnsBrute-gen.txt $1.dnsBrute.txt | wc -l `"
echo