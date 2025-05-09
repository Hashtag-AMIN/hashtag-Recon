#!/bin/bash

if [ $# -ne 2 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-fuzz-custom.sh <Url(http://example.com/FUZZ)> <wordlist(worldlist.txt)>"
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

domain_name=` echo $1 | cut -d / -f3 `

echo "Start ffuf with: $2 wordlist:"

ffuf -u $1 -w $2 -ac -r -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; MSBrowserIE; rv:11.0) like Gecko" -H "X-Forwarded-For: 127.0.0.1" -mc all -fc 404 -of csv -t 5 -o $domain_name-fuzz.csv

echo "fuzz with Custom wordlist Done & final result & length ==> ` wc -l $domain_name-fuzz.csv `"