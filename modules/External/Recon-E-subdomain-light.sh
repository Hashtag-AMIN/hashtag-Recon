#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-Subdomain-light.sh <Domain(example.com)>"
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

echo "Run Subfinder ..."
subfinder -d $1 -silent -no-color > $1-subfinder.txt
echo "Subfinder Done, result & length ==> ` wc -l $1-subfinder.txt `"

echo
echo "psql to crt.sh ..."
echo "SELECT ci.NAME_VALUE FROM certificate_and_identities ci WHERE plainto_tsquery('certwatch', '$1') @@ identities(ci.CERTIFICATE)" | psql -t -h crt.sh -p 5432 -U guest certwatch | sed 's/ //g' | grep -E ".*.\.$1" | sed 's/*\.//g' | tr '[:upper:]' '[:lower:]' | sort -u > $1-crtsh.txt 2> /dev/null
echo "psql to crt.sh Done, result & length ==> ` wc -l $1-crtsh.txt `"

echo
echo "Run assetfinder ..."
echo $1 | assetfinder -subs-only > $1-assetfinder.txt
echo "assetfinder Done, result & length ==> ` wc -l $1-assetfinder.txt `"

echo
echo "Send Request to get subdomain from content-security-policy header ..."
curl -vsLk $1 --stderr - | awk '/content-security-policy:/' | grep -Eo "[a-zA-Z0-9./?=_-]*" |  sed -e '/\./!d' -e '/[^A-Za-z0-9._-]/d' -e 's/^\.//' | sort -u > $1-csp.txt
echo "content-security-policy Done, result & length ==> ` wc -l $1-csp.txt `"

sort -u $1-subfinder.txt $1-crtsh.txt $1-assetfinder.txt $1-csp.txt > $1-provider.txt
rm $1-subfinder.txt $1-crtsh.txt $1-assetfinder.txt $1-csp.txt

echo "All Subdomains result & length ==> ` wc -l $1-provider.txt`"
echo