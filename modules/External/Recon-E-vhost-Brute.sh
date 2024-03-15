#!/bin/bash

if [ $# -ne 3 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-vhost.sh <Url(http://example.com|http://1.2.3.4)> <Domain(example.com)[mainScope-for-FUZZ]> <Subdomains(example.com.Subs.txt)> "
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

echo "Start ffuf for FUZZ Host header with: \"Host: FUZZ\""
ffuf -u $1 -w ./wordlist/fuzz-vhost.txt -ac -H "Host: FUZZ" -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36" -fc 404 -t 1 -of csv -o $2.vhost-FUZZ.csv 
echo "FUZZ Host header Done & final result in $2.vhost-FUZZ.csv ==> len: ` cat $2.vhost-FUZZ.csv | wc -l `"

echo
echo "Start ffuf for FUZZ Host header with: \"Host: FUZZ.$2\""
ffuf -u $1 -w ./wordlist/fuzz-vhost.txt -ac -H "Host: FUZZ.$2" -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0" -fc 404 -t 1 -of csv -o $2.vhost-FUZZ.domain.csv
echo "FUZZ.$2 Host header Done & final result in $2.vhost-FUZZ.domain.csv ==> len: ` cat $2.vhost-FUZZ.domain.csv | wc -l `"

echo
echo "Start ffuf for FUZZ Host header with: \"Host: subdomain.$2\""
ffuf -u $1 -w $3 -ac -H "Host: FUZZ"  -H "User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36" -fc 404 -t 1 -of csv -o $2.vhost-FUZZ-subdomain.csv
echo "FUZZ.$2 Host header Done & final result in $2.vhost-FUZZ-subdomain.csv ==> len: ` cat $2.vhost-FUZZ-subdomain.csv | wc -l `"

cat $2.vhost-FUZZ.csv $2.vhost-FUZZ.domain.csv $2.vhost-FUZZ-subdomain.csv | sort -u > $2.vhostScan.csv
rm $2.vhost-FUZZ.csv $2.vhost-FUZZ.domain.csv $2.vhost-FUZZ-subdomain.csv

echo "Host Header fuzzing finish and final result in: $2.vhostScan.csv ==> len: ` cat $2.vhostScan.csv | wc -l `"
echo