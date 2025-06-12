#!/bin/bash

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

# dns-wordlist-heavy.txt
# dns-wordlist-light.txt

sub_wordlist=` curl -s https://wordlists-cdn.assetnote.io/data/automated/ | grep httparchive_subdomains | tail -n 1 | grep -oE "http.*\.txt\"" | sed "s/\"//" `

echo "Start download & update assetnote dynamic wordlist"
wget https://wordlists-cdn.assetnote.io/data/automated/$sub_wordlist -O ./httparchive_subdomains.txt

head -n 500000 ./httparchive_subdomains.txt > dns-wordlist-light.txt
head -n 1000000 ./httparchive_subdomains.txt > dns-wordlist-heavy.txt

echo "Download dns-wordlist-light.txt, dns-wordlist-heavy.txt, httparchive_subdomains.txt"

echo "Now Download huge Subdomain files, best-dns-wordlist.txt and 2m-subdomains.txt"
wget https://wordlists-cdn.assetnote.io/data/manual/best-dns-wordlist.txt

wget https://wordlists-cdn.assetnote.io/data/manual/2m-subdomains.txt


# x8-param-20k.txt
# httparchive_parameters_top_1m.txt

param_wordlist=` curl -s https://wordlists-cdn.assetnote.io/data/automated/ | grep httparchive_parameters_top_1m | tail -n 1 | grep -oE "http.*\.txt\"" | sed "s/\"//" `

echo "Start download & update Parameter wordlist"
wget https://wordlists-cdn.assetnote.io/data/automated/$param_wordlist -O ./httparchive_parameters_top_1m.txt

head -n 20000 ./httparchive_parameters_top_1m.txt > x8-param-20k.txt

echo "Update wordlist is completed"