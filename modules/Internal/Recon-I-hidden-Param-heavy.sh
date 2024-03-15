#!/bin/bash

if [ $# -ne 2 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-I-hidden-Param-heavy.sh <Url(http://exapmle.com[/param?key=value])> <Custom-param-wordlist(params.txt)>"
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

domain_name=$( echo $1 | cut -d / -f3 )

#x8
echo "Start x8 with Custom wordlist[GET] : $2 ..."

x8 -u "$1" --wordlist $2 --max 15 --follow-redirects -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:40.0) Gecko/20100101 Firefox/40.0" --output $domain_name-x8-custom-get.txt

echo " x8 with $2 wordlist Done & result in $domain_name-x8-custom-get.txt ==> len: ` cat $domain_name-x8-custom-get.txt | wc -l `"

echo
sleep 5
echo "Start x8 with Custom wordlist[POST] : $2 ..."

x8 -u "$1" --wordlist $2 --max 15 --follow-redirects -X POST -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko" --output $domain_name-x8-custom-post.txt

echo " x8 with $2 wordlist Done & result in $domain_name-x8-custom-post.txt ==> len: ` cat $domain_name-x8-custom-post.txt | wc -l `"
echo
sleep 5
echo "Start x8 with param-mixescase-large.txt wordlist[GET] : $2 ..."

x8 -u "$1" --wordlist ./wordlist/x8-param-mixescase-large.txt --max 15 --follow-redirects -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko" --output $domain_name-x8-mcase-l-get.txt

echo " x8 with param-mixescase-large.txt wordlist Done & result in $domain_name-x8-mcase-l-get.txt ==> len: ` cat $domain_name-x8-mcase-l-get.txt | wc -l `"

echo
sleep 5
echo "Start x8 with param-mixescase-large.txt wordlist[POST] : $2 ..."

x8 -u "$1" --wordlist ./wordlist/x8-param-mixescase-large.txt --max 15 --follow-redirects -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0" -X POST --output $domain_name-x8-mcase-l-post.txt

echo " x8 with param-mixescase-large.txt wordlist Done & result in $domain_name-x8-mcase-l-post.txt ==> len: ` cat $domain_name-x8-mcase-l-post.txt | wc -l `"

#arjun
echo
sleep 5
echo "Start arjun with default json wordlist[GET]: arjun-param-special.json ..."

arjun -u $1 -c 1 -t 2 --headers "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/600.8.9 (KHTML, like Gecko) Version/8.0.8 Safari/600.8.9" -w ./wordlist/arjun-param-special.json -oT $domain_name-arjun-default-j-get.txt

echo " arjun with default wordlist Done & result in $domain_name-arjun-default-j-get.txt ==> len: ` cat $domain_name-arjun-default-j-get.txt | wc -l `"

echo
sleep 5
echo "Start arjun with default json wordlist[POST]: arjun-param-special.json ..."

arjun -u $1 -c 1 -t 2 -m POST --headers "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/600.8.9 (KHTML, like Gecko) Version/8.0.8 Safari/600.8.9" -w ./wordlist/arjun-param-special.json -oT $domain_name-arjun-default-j-post.txt

echo " arjun with default wordlist Done & result in $domain_name-arjun-default-j-post.txt ==> len: ` cat $domain_name-arjun-default-j-post.txt | wc -l `"

cat $domain_name-x8-custom-get.txt  $domain_name-x8-mcase-l-get.txt  $domain_name-arjun-default-j-get.txt > $domain_name-hparam-get.txt
cat $domain_name-x8-custom-post.txt $domain_name-x8-mcase-l-post.txt $domain_name-arjun-default-j-post.txt > $domain_name-hparam-post.txt

rm $domain_name-x8-custom-get.txt  $domain_name-x8-mcase-l-get.txt  $domain_name-arjun-default-j-get.txt $domain_name-x8-custom-post.txt $domain_name-x8-mcase-l-post.txt $domain_name-arjun-default-j-post.txt

echo "Hidden Param Discovery Finish ..."
echo "Let's Exploit... :)"