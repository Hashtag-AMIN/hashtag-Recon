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

file_name=` echo $1 |  sed "s/.txt//g" `

echo "Start Run httpx for find live subdomains, Store Response & hash..."

cat $1 | httpx -ports 80,443,8000,8080,8443 -status-code -content-length -content-type -hash md5 -title -web-server -tech-detect -websocket -follow-redirects -threads 40 -rate-limit 10 -vhost -store-response -cdn -silent -filter-code 404 -random-agent -store-response-dir $file_name-httpx -output $file_name-live-httpx.txt

echo "httpx is finish and Result in: $file_name-httpx & $file_name-live-httpx.txt ==> len: `cat $file_name-live-httpx.txt | wc -l`"