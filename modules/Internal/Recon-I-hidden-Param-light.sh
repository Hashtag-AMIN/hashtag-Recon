#!/bin/bash

if [ $# -ne 3 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-I-hidden-Param-light.sh <Method(GET|POST|PUT|...)> <Url(http://exapmle.com[/param?key=value])> <Custom-param-wordlist(params.txt)>"
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

domain_name=$( echo $2 | cut -d / -f3 )

echo "Start x8 with Custom wordlist [$1]: $3 ..."

x8 -u "$2" --wordlist $3 --max 8 --follow-redirects -X $1 -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0" --output $domain_name-x8-custom-$1.txt

echo " x8 with $3 wordlist Done & result in $domain_name-x8-custom-$1.txt ==> len: ` cat $domain_name-x8-custom-$1.txt | wc -l `"