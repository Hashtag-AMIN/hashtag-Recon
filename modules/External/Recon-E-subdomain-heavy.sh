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
                                                          Hashtag_AMIN
                                                  https://github.com/hashtag-amin
                                                  
EOF

echo "Run Subfinder ..."
subfinder -d $1 -all -silent -recursive >> $1-subfinder.txt
echo "Subfinder Done & result in $1-subfinder.txt ==> len: ` cat $1-subfinder.txt | wc -l`"

echo
echo "Run sublist3r ..."
sublist3r -d $1 -t 10 -o $1-subli3ter.txt > /dev/null
echo "sublist3r Done & result in $1-subli3ter.txt ==> len: ` cat $1-subli3ter.txt | wc -l `"

echo
echo "Run amass ..."
amass intel -d $1 -whois -o $1-amass.txt > /dev/null
echo "amass Done & result in $1-amass.txt ==> len: ` cat $1-amass.txt | wc -l `"

echo
echo "Run assetfinder ..."
echo $1 | assetfinder -subs-only > $1-assetfinder.txt
echo "assetfinder Done & result in $1-assetfinder.txt ==> len: ` cat $1-assetfinder.txt | wc -l `"

echo
echo "Run waybackurls ..."
echo $1 | waybackurls  | cut -d / -f3 | sort -u > $1-waybackurls.txt
echo "waybackurls Done & result in $1-waybackurls.txt ==> len: ` cat $1-waybackurls.txt | wc -l `"

echo
echo "Run github-subdomains ..."
github-subdomains -d $1 -k -e -q -o $1-github-subdomains.txt > /dev/null
echo "github-subdomains Done & result in $1-github-subdomains.txt ==> len: ` cat $1-github-subdomains.txt | wc -l `"

echo
echo "Send Request to jldc.me ..."
curl -s "https://jldc.me/anubis/subdomains/$1" | jq -r ".[]" | sort -u > $1-jldc.txt
echo "jldc.me result in $1-jldc.txt ==> len: ` cat $1-jldc.txt | wc -l `"
echo "Send Request result in $1-jldc.txt ==> len: ` cat $1-jldc.txt | wc -l `"

echo
echo "Send Request to get subdomain from content-security-policy header ..."
curl -vsLk $1 --stderr - | awk '/content-security-policy:/' | grep -Eo "[a-zA-Z0-9./?=_-]*" |  sed -e '/\./!d' -e '/[^A-Za-z0-9._-]/d' -e 's/^\.//' > $1-csp.txt
echo "content-security-policy result in $1-csp.txt ==> len: ` cat $1-csp.txt | wc -l `"

cat $1-subfinder.txt $1-subli3ter.txt $1-amass.txt $1-assetfinder.txt $1-waybackurls.txt $1-github-subdomains.txt $1-jldc.txt $1-csp.txt | grep $1 | sort -u > $1.Subs-provider.txt

rm $1-subfinder.txt $1-subli3ter.txt $1-amass.txt $1-assetfinder.txt $1-waybackurls.txt $1-github-subdomains.txt $1-jldc.txt $1-csp.txt

echo "All Subdomains in $1.Subs-provider.txt ==> len: ` cat $1.Subs-provider.txt | wc -l `"
echo