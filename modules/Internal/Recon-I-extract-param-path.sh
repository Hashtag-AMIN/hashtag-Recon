#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-I-extract-param.sh <Crawl-domain-file(example.com-crawl.txt)>"
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

echo "Start fetchParam for extract parameters from sorce code:"
fetchParam.py --urls $1 --output $file_name-fetchParam.txt --threads 12 --silent 2> /dev/null
echo "fetchParam Done & result in $file_name-fetchParam.txt ==> len: ` cat $file_name-fetchParam.txt | wc -l `"

echo "Start unfurl extract parameters from urls:"
cat $1 | unfurl keys | sort -u > $file_name-urlParam.txt
echo "unfurl Done & result in $file_name-urlParam.txt ==> len: ` cat $file_name-urlParam.txt | wc -l `"

echo "Start unfurl extract paths from urls:"
cat $1 | unfurl paths | grep -vE "\.(css|jpg|jpeg|png|svg|img|gif|exe|mp4|flv|pdf|doc|ogv|webm|wmv|webp|mov|mp3|m4a|m4p|ppt|pptx|scss|tif|tiff|ttf|otf|woff|woff2|bmp|ico|eot|htc|swf|rtf|image|rf)$" | sort -u > $file_name-paths.txt
echo "unfurl Done & result in $file_name-paths.txt ==> len: ` cat $file_name-paths.txt | wc -l `"


cat $file_name-fetchParam.txt $file_name-urlParam.txt | sort -u > $file_name-param-wordlist.txt
rm $file_name-fetchParam.txt $file_name-urlParam.txt

echo "finally all parameter in $file_name-param-wordlist.txt ==> len: ` cat $file_name-param-wordlist.txt | wc -l `"