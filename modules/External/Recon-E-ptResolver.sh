#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-ptResolver.sh <SubdomainList(example.com.subs.txt)>"
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
                                                          Hashtag-Recon
                                                  https://github.com/hashtag-amin
                                                  
EOF

file_name=` echo $1 | sed -e "s/.txt$//" -e "s/\*//" `

echo "Start dnsx to resolve by PTR Record with: $1"

dnsx -l $1 -resp-only -ptr -silent -no-color -threads 200 -output $file_name.PTR-tmp.txt > /dev/null 2>&1

sort -u $file_name.PTR-tmp.txt > $file_name-PTR.txt
rm $file_name.PTR-tmp.txt

echo "dnsx-PTR Done, result & length ==> ` wc -l $file_name-PTR.txt` "