#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-Subdomain-heavy.sh <DomainFile(example.com.subs.txt)>"
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
echo "Run Subfinder & assetfinder & jldc.me with $1 subdomain file..."

for sub in $( cat $1 )
do
    subfinder -d $sub -all -silent >> passive_recursive.txt
    assetfinder --subs-only $sub  >> passive_recursive.txt
    curl -s "https://jldc.me/anubis/subdomains/$sub" | jq -r ".[]" | sort -u >> passive_recursive.txt
done

cat passive_recursive.txt | sort -u > $file_name.recursive-Subs.txt
echo "All recursive Subdomains in $file_name.recursive-Subs.txt ==> len: ` cat $file_name.recursive-Subs.txt | wc -l `"
echo
