#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-I-JS-enum-get-secret-github.sh <github-repo(https://github.com/github>"
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

file_name=` echo $1 | cut -d / -f4 `

echo "Start trufflehog for find sensetive value on $1 github repo:"

trufflehog github --repo=$1 > $file_name-truffle-git.txt

echo "trufflehog Done, result & length ==> ` wc -l $file_name-truffle-git.txt `"