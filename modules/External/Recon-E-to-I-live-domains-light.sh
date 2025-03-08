#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-I-live-domains-light.sh <SubdomainList(example.com-allsubdomain.txt)>"
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

file_name=` echo $1 | sed -e "s/.txt$//" -e "s/\//_/" -e "s/\*//" `

echo "Start Run httpx for find live subdomains, Store Response, hash & details..."

httpx -list $1 -ports 80,443,2052,2053,2082,2083,2086,2087,2095,2096,8000,8080,8180,8443,8880,10443 -status-code -content-length -content-type -hash md5 -title -web-server -tech-detect -websocket -follow-redirects -threads 40 -rate-limit 8 -vhost -store-response -cdn -silent -filter-code 404 -random-agent -no-color -store-response-dir $file_name-live -output $file_name-live.txt

echo "httpx is finish and response store in: $file_name-live directory & length ==> ` wc -l $file_name-live.txt `"