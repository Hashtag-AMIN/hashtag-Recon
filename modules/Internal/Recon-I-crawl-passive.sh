#!/bin/bash

if [ $# -ne 2 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-I-crawl-passive.sh <Domain(example.com)[mainScope-for-crawl]]> <UrlsList(example.com.live.txt)>"
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

echo
echo "Start waybackurls for crawl site on $2 file:"
cat $2 | waybackurls | grep -Eiv '\.(css|jpg|jpeg|png|svg|img|gif|mp4|flv|pdf|doc|ogv|webm|wmv|webp|mov|mp3|m4a|m4p|ppt|pptx|scss|tif|tiff|ttf|otf|woff|woff2|bmp|ico|eot|htc|swf|rtf|image|rf|json|fnt|ogg|exe|txt|ml|ip)(\?|$)' | sort -u > $1.crawl-waybackurls.txt
echo "waybackurls Done, result & length ==> ` wc -l $1.crawl-waybackurls.txt `"

echo
echo "Start gau for crawl site on $2 file:"
cat $2 | gau --blacklist css,jpg,jpeg,png,svg,img,gif,mp4,flv,pdf,doc,ogv,webm,wmv,webp,mov,mp3,m4a,m4p,ppt,pptx,scss,tif,tiff,ttf,otf,woff,woff2,bmp,ico,eot,htc,swf,rtf,image,rf,json,fnt,ogg,exe,txt,ml,ip --threads 3 --subs --o $1.crawl-gau.txt
echo "gau Done, result & length ==> ` wc -l $1.crawl-gau.txt `"

echo
sort -u $1.crawl-waybackurls.txt $1.crawl-gau.txt > $1.passive.txt
rm $1.crawl-waybackurls.txt $1.crawl-gau.txt

echo "passive crawl Done, result & length ==> ` wc -l $1.passive.txt `"