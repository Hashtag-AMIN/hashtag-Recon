#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-subdomain-recursive.sh <DomainFile(example.com.subs.txt)>"
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
echo "Run Subfinder & assetfinder & jldc.me with $1 subdomain file..."

for sub in $( cat $1 )
do
    subfinder -d $sub -all -silent -no-color >> passive_recursive.txt
    assetfinder --subs-only $sub  >> passive_recursive.txt
    curl -s "https://jldc.me/anubis/subdomains/$sub" | jq -r ".[]" | sort -u >> passive_recursive.txt
done

sort -u passive_recursive.txt > $file_name-recursive.txt
rm passive_recursive.txt

echo "All recursive Subdomains result & length ==> ` wc -l $file_name-recursive.txt`"
echo
