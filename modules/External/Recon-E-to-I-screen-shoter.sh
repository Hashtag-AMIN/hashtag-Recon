#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-to-I-screen-shoter.sh <SubdomainList(example.com-live-domain.txt)>"
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

echo "Start Run httpx for take screenShots from urls in file $1"

httpx -list $1 -status-code -screenshot -follow-redirects -threads 40 -rate-limit 5 -silent -filter-code 404 -random-agent -no-color -store-response-dir $file_name-shot -output $file_name-shot.txt

echo "httpx Done & shots store in $file_name-shot directory & length ==> ` wc -l $file_name-shot.txt `"