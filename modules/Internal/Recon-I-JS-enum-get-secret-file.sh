#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-I-JS-enum-get-secrect-file.sh <Content-Dir-of-JS(example.com.JS-dir>"
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

file_name=` echo $1 |  sed -e "s/.txt//" -e "s/\*//g" -e "s/\///g" `

echo "Start trufflehog for find sensetive value on $1 folder:"

trufflehog filesystem $1 > $file_name-trufflefile.txt

echo "trufflehog Done & result in $file_name-trufflefile.txt ==> len: ` cat $file_name-trufflefile.txt | wc -l `"