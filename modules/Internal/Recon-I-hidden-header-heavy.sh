#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-I-hidden-header-heavy.sh <Url(http://example.com)> "
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

echo "Start x8 with lowercase header wordlist[GET] : x8-header-lowercase.txt ..."
x8 -u "$1" --headers --max 15 --follow-redirects --wordlist ./wordlist/x8-header-lowercase.txt --output $domain_name-header-low-get.txt
echo " x8 with x8-header-lowercase.txt wordlist Done, result & length ==> ` wc -l $domain_name-header-low-get.txt `"

sleep 5
echo "Start x8 with uppercase header wordlist[GET] : x8-header-uppercase.txt ..."
x8 -u "$1" --headers --max 15 --follow-redirects --wordlist ./wordlist/x8-header-uppercase.txt --output $domain_name-header-up-get.txt
echo " x8 with x8-header-uppercase.txt wordlist Done, result & length ==> ` wc -l $domain_name-header-up-get.txt `"

sleep 5
echo "Start x8 with lowercase header wordlist[POST] : x8-header-lowercase.txt ..."
x8 -u "$1" --headers -X POST --max 15 --follow-redirects --wordlist ./wordlist/x8-header-lowercase.txt --output $domain_name-header-low-post.txt
echo " x8 with x8-header-lowercase.txt wordlist Done, result & length ==> ` wc -l $domain_name-header-low-post.txt`"

sleep 5
echo "Start x8 with uppercase header wordlist[POST] : x8-header-uppercase.txt ..."
x8 -u "$1" --headers -X POST --max 15 --follow-redirects --wordlist ./wordlist/x8-header-uppercase.txt --output $domain_name-header-up-post.txt
echo " x8 with x8-header-uppercase.txt wordlist Done, result & length ==> ` wc -l $domain_name-header-up-post.txt `"

cat $domain_name-header-low-get.txt $domain_name-header-up-get.txt >  $domain_name-header-get.txt
cat $domain_name-header-low-post.txt $domain_name-header-up-post.txt > $domain_name-header-post.txt
rm $domain_name-header-low-get.txt $domain_name-header-up-get.txt $domain_name-header-low-post.txt $domain_name-header-up-post.txt

echo
echo "Hidden Headers Discovery Finish & result in $domain_name-header-get.txt & $domain_name-header-post.txt ..."