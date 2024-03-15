#!/bin/bash

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
# dns-wordlist-heavy.txt
# dns-wordlist-light.txt

sub_wordlist=` curl -s https://wordlists-cdn.assetnote.io/data/automated/ | grep httparchive_subdomains | tail -n 1 | grep -oE "http.*\.txt\"" | sed "s/\"//" `

echo "Start download & update Subdomain wordlist"
wget https://wordlists-cdn.assetnote.io/data/automated/$sub_wordlist

head -n 500000 $sub_wordlist > dns-wordlist-light.txt
head -n 1000000 $sub_wordlist > dns-wordlist-heavy.txt
mv $sub_wordlist ./wordlist/all-subdomain.txt
mv dns-wordlist-light.txt ./wordlist
mv dns-wordlist-heavy.txt ./wordlist

# x8-param-mixescase-large.txt
# x8-param-all.txt

param_wordlist=` curl -s https://wordlists-cdn.assetnote.io/data/automated/ | grep httparchive_parameters_top_1m | tail -n 1 | grep -oE "http.*\.txt\"" | sed "s/\"//" `

echo "Start download & update Parameter wordlist"
wget https://wordlists-cdn.assetnote.io/data/automated/$param_wordlist

head -n 20000 $param_wordlist > x8-param-mixescase-large.txt

mv $param_wordlist ./wordlist/x8-param-all.txt
mv x8-param-mixescase-large.txt ./wordlist

echo "Update wordlist is completed"