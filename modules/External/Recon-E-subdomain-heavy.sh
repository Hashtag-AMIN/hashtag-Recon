#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-Subdomain-heavy.sh <Domain(example.com)>"
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
subfinder -d $1 -all -silent -recursive -no-color > $1-subfinder.txt
echo "Subfinder Done, result & length ==> ` wc -l $1-subfinder.txt `"

echo
echo "psql to crt.sh ..."
echo "SELECT ci.NAME_VALUE FROM certificate_and_identities ci WHERE plainto_tsquery('certwatch', '$1') @@ identities(ci.CERTIFICATE)" | psql -t -h crt.sh -p 5432 -U guest certwatch | sed 's/ //g' | grep -E ".*.\.$1" | sed 's/*\.//g' | tr '[:upper:]' '[:lower:]' | sort -u > $1-crtsh.txt 2> /dev/null
echo "psql to crt.sh Done, result & length ==> ` wc -l $1-crtsh.txt `"

echo
echo "Run sublist3r ..."
sublist3r -d $1 -t 10 -o $1-subli3ter.txt > /dev/null 2>&1
if ! [ -f ./$1-subli3ter.txt ]; then
  touch $1-subli3ter.txt
fi
echo "sublist3r Done, result & length ==> ` wc -l $1-subli3ter.txt `"

echo
echo "Run assetfinder ..."
echo $1 | assetfinder -subs-only | sort -u > $1-assetfinder.txt
echo "assetfinder Done, result & length ==> ` wc -l $1-assetfinder.txt `"

echo
echo "Run waybackurls ..."
echo $1 | waybackurls  | cut -d / -f3 | sort -u > $1-waybackurls.txt
echo "waybackurls Done, result & length ==> ` wc -l $1-waybackurls.txt `"

echo
echo "Run github-subdomains ..."
github-subdomains -d $1 -k -e -q -o $1-github-subdomains.txt > /dev/null 2>&1
echo "github-subdomains Done, result & length ==> ` wc -l $1-github-subdomains.txt `"

echo
echo "Send Request to get subdomain from content-security-policy header ..."
curl -vsLk $1 --stderr - | awk '/content-security-policy:/' | grep -Eo "[a-zA-Z0-9./?=_-]*" |  sed -e '/\./!d' -e '/[^A-Za-z0-9._-]/d' -e 's/^\.//' > $1-csp.txt
echo "content-security-policy Done, result & length ==> ` wc -l $1-csp.txt `"

sort -u $1-subfinder.txt $1-crtsh.txt $1-subli3ter.txt $1-assetfinder.txt $1-waybackurls.txt $1-github-subdomains.txt $1-csp.txt > $1-provider.txt

rm $1-subfinder.txt $1-crtsh.txt $1-subli3ter.txt $1-assetfinder.txt $1-waybackurls.txt $1-github-subdomains.txt $1-csp.txt

echo "All Subdomains result & length ==> ` wc -l $1-provider.txt `"
echo