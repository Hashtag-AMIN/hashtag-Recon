#!/bin/bash

if [ $# -ne 3 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-I-dorker.sh <Query('site:example.com inurl:&')> <searchEnggine(Google|bing)> <Page(1|2|3|4)>"
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

# add to hashtag-Reocn
now_date=` date "+%H-%M-%S" `

echo "Start go-dork with $1 Query on $2 Search engine $3 pages"

echo "Query: $1 on $2 Search engine $3 pages:" > $now_date-$2-dorcker.txt
go-dork --query "$1" --engine $2 --page $3 --silent >> $now_date-$2-dorcker.txt

echo "go-dork Done, result & length ==> ` wc -l $now_date-$2-dorcker.txt `"