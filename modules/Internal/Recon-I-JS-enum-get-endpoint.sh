#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-I-JS-enum-get-endpointsh <Content-Dir-of-JS(example.com.JS-dir/*|dir/*/*)>"
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

echo "Start Extract endpoints on $1 folder:"

grep -ohr "[\"\']\/[a-zA-Z0-9_/?=&]*[\"\']" $1 | sed -e 's/^"//' -e 's/"$//' -e "s/^'//" -e "s/'$//" | sort -u | tee $file_name-endpoints.txt

echo "Extract endpoints Done & result in $file_name-endpoints.txt ==> len: ` cat $file_name-endpoints.txt | wc -l `"