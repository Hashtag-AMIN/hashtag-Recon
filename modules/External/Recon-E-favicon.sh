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

file_name=` echo $1 |  sed "s/.txt//g" `


echo "Start Run httpx for take favicon from urls in file $1"

cat $1 | httpx -favicon -follow-redirects -threads 40 -rate-limit 10 -silent -filter-code 404 -random-agent -output $file_name-favicon.txt

echo "httpx Done & result in $file_name-favicon.txt"