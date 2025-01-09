#!/bin/bash

if [ $# -ne 2 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-I-crawl-active.sh <Domain(example.com)[mainScope-for-crawl]]> <UrlsList(example.com.live.txt)>"
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

echo "Start katana for crawl site on $2 file:"

katana -list $2 -depth 4 -jsluice -js-crawl -known-files all -automatic-form-fill -form-extraction -xhr-extraction -silent -no-color -crawl-scope $1 -extension-filter css,jpg,jpeg,png,svg,img,gif,mp4,flv,pdf,doc,ogv,webm,wmv,webp,mov,mp3,m4a,m4p,ppt,pptx,scss,tif,tiff,ttf,otf,woff,woff2,bmp,ico,eot,htc,swf,rtf,image,rf,json,fnt,ogg,exe,txt,ml,ip -concurrency 5 -parallelism 5 -rate-limit 10 -output $1.crawl.txt > /dev/null 2>&1

echo "katana Done, result & length ==> ` wc -l $1.crawl.txt `"