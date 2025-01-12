#!/bin/bash

if [ $# -ne 2 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-dns-Brute-light.sh <Domain(example.com)> <SubdomainList(example.com.resolve.txt)>"
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

echo "Run shuffledns & Brute force on: $1 with TOP 500k subdomain"
shuffledns -domain $1 -resolver ./wordlist/dns-resolvers.txt -wordlist ./wordlist/dns-wordlist-light.txt -mode bruteforce -massdns-cmd "-t AAAA -t CNAME -t NS -t TXT -t SRV -t SOA -t CAA" -silent -output $1.dnsBrute-1st.txt > /dev/null 2>&1
echo "shuffledns Done, result & length ==> ` wc -l $1.dnsBrute-1st.txt `"

echo "Run shuffledns & Brute force on: $1 with 3-with-char.txt wordlist:"
shuffledns -domain $1 -resolver ./wordlist/dns-resolvers.txt -wordlist ./wordlist/dns-wordlist-3-with-char.txt -mode bruteforce -massdns-cmd "-t AAAA -t CNAME -t NS -t TXT -t SRV -t SOA -t CAA" -silent -output $1.dnsBrute-2nd.txt > /dev/null 2>&1
echo "shuffledns Done, result & length ==> ` wc -l $1.dnsBrute-2nd.txt `"

echo "Run dnsgen on: $1"
sort -u $2 $1.dnsBrute-1st.txt $1.dnsBrute-2nd.txt | dnsgen --wordlist ./wordlist/dns-dnsgen-wordlist-light.txt - > $1.dnsgen.txt
echo "dnsgen Done, result & length ==> ` wc -l $1.dnsgen.txt `"

echo "Run shuffledns & Resolving on: $1.dnsgen.txt"
shuffledns -list $1.dnsgen.txt -resolver ./wordlist/dns-resolvers.txt -mode resolve -massdns-cmd "-t AAAA -t CNAME -t NS -t TXT -t SRV -t SOA -t CAA" -output $1.dnsBrute-3rd.txt > /dev/null 2>&1
echo "shuffledns Done, result & length ==> ` wc -l $1.dnsBrute-3rd.txt `"

sort -u $1.dnsBrute-1st.txt  $1.dnsBrute-2nd.txt $1.dnsBrute-3rd.txt > $1.dnsBrute.txt
rm $1.dnsBrute-1st.txt $1.dnsBrute-2nd.txt $1.dnsBrute-3rd.txt $1.dnsgen.txt

echo
echo "All Subdomain Resolve, result & length ==> ` wc -l $1.dnsBrute.txt `"
echo