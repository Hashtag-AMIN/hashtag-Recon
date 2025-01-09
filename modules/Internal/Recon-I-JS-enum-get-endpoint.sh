#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-I-JS-enum-get-endpoint.sh <Content-Dir-of-JS(example.com.JS-dir/|dir/)>"
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

file_name=` echo $1 |  sed -e "s/.txt$//" -e "s/\//_/" -e "s/\*//" `

echo "Start Extract path from raw request/response on $1 folder:"

grep -ohr "[\"\'\`]\/[a-zA-Z0-9_?&=\/\-\#\.]*[\"\'\`]" $1 | sed -e 's/^"//' -e 's/"$//' -e "s/^'//" -e "s/'$//" -e "s/^\`//" -e "s/\`$//" | sort -u | grep -Eiv '\.(css|jpg|jpeg|png|svg|img|gif|mp4|flv|pdf|doc|ogv|webm|wmv|webp|mov|mp3|m4a|m4p|ppt|pptx|scss|tif|tiff|ttf|otf|woff|woff2|bmp|ico|eot|htc|swf|rtf|image|rf|json|fnt|ogg|exe|txt|ml|ip)$' > $file_name-JS-Path.txt

sleep 1

echo "Extract endpoints Done, result & length ==> ` wc -l $file_name-JS-Path.txt`"