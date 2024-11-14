#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-Resolver.sh <SubdomainList(example.com.subs.txt)>"
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

echo "Run shuffledns For Resolve Domains: $1"

shuffledns -l $1 -r ./wordlist/dns-resolvers.txt -silent -o $file_name.resolve.txt -mode resolve

echo "shuffledns Done & result in $file_name.resolve.txt ==> len: ` cat $file_name.resolve.txt | wc -l `"
