#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-I-extract-param-path.sh <Crawl-domain-file(example.com-crawl.txt)>"
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

file_name=` echo $1 | sed -e "s/.txt$//" -e "s/\//_/" -e "s/\*//" `

echo "Start fallparams for extract parameters from sorce code:"
fallparams -u $1 -silent -thread 5 -output $file_name-fallparams.txt > /dev/null 2>&1
echo "fallparams Done, result & length ==> ` wc -l $file_name-fallparams.txt `"

echo "Start unfurl extract parameters from urls:"
cat $1 | unfurl keys | sort -u > $file_name-urlParam.txt
echo "unfurl Done, result & length ==> ` wc -l $file_name-urlParam.txt `"

echo "Start unfurl extract paths from urls:"
cat $1 | unfurl paths | grep -viE "\.(css|jpg|jpeg|png|svg|img|gif|mp4|flv|pdf|doc|ogv|webm|wmv|webp|mov|mp3|m4a|m4p|ppt|pptx|scss|tif|tiff|ttf|otf|woff|woff2|bmp|ico|eot|htc|swf|rtf|image|rf|json|fnt|ogg|exe|txt|ml|ip)$" | sort -u > $file_name-path.txt
echo "unfurl Done, result & length ==> ` wc -l $file_name-path.txt `"


sort -u $file_name-fallparams.txt $file_name-urlParam.txt > $file_name-param.txt
rm $file_name-fallparams.txt $file_name-urlParam.txt

echo "finally all parameter extract, result & length ==> ` wc -l $file_name-param.txt `"