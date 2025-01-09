#!/bin/bash

if [ $# -ne 2 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-spliter-size.sh <Input(example.com.subs.txt)> <size(20M|100K|3G)>"
    echo "Split Input file to files by X size"
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

echo "Start split Input to files by $2 size:"

sleep 0.5

split -e -b $2 --additional-suffix=.txt --numeric-suffixes=1 $1 $file_name

echo "Result files pattern like ==> ${file_name}XX.txt"