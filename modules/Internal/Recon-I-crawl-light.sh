#!/bin/bash

if [ $# -ne 2 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-I-robots-sitemap.sh <Domain(example.com)[mainScope-for-grep]]> <SubdomainList(example.com.live.txt)>"
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
katana -list $2 -depth 4 -jsluice -js-crawl -known-files all -automatic-form-fill -form-extraction -xhr-extraction -silent -extension-filter css,jpg,jpeg,png,svg,img,gif,mp4,flv,pdf,doc,ogv,webm,wmv,webp,mov,mp3,m4a,m4p,ppt,pptx,scss,tif,tiff,ttf,otf,woff,woff2,bmp,ico,eot,htc,swf,rtf,image,rf -concurrency 10 -parallelism 20 -rate-limit 120 -output $1.crawl-katana.txt > /dev/null
echo "katana Done & result in $1.crawl-katana.txt ==> len: ` cat $1.crawl-katana.txt | wc -l `"

echo
echo "Start gospider for crawl site on $2 file:"
gospider --sites $2 --blacklist "\.(css|jpg|jpeg|png|svg|img|gif|exe|mp4|flv|pdf|doc|ogv|webm|wmv|webp|mov|mp3|m4a|m4p|ppt|pptx|scss|tif|tiff|ttf|otf|woff|woff2|bmp|ico|eot|htc|swf|rtf|image|rf)$" --user-agent web: random web user-agent --threads 40 --concurrent 10 --depth 4 --js --sitemap --robots --other-source --include-other-source --include-subs --subs --quiet --output $1.crawl-gospider-dir > /dev/null
cat $1.crawl-gospider.dir/* | grep -oE '(http.*)' | grep $1 > $1.crawl-gospider.txt
echo "gospider Done & result in $1.crawl-gospider.txt ==> len: ` cat $1.crawl-gospider.txt | wc -l `"

echo
echo "Start waybackurls for crawl site on $2 file:"
cat $2 | waybackurls | grep -Eiv '\.(css|jpg|jpeg|png|svg|img|gif|exe|mp4|flv|pdf|doc|ogv|webm|wmv|webp|mov|mp3|m4a|m4p|ppt|pptx|scss|tif|tiff|ttf|otf|woff|woff2|bmp|ico|eot|htc|swf|rtf|image|rf)' | sort -u >> $1.crawl-waybackurls.txt
echo "waybackurls Done & result in $1.crawl-waybackurls.txt ==> len: ` cat $1.crawl-waybackurls.txt | wc -l `"

echo Finally crawl finish !!!

cat $1.crawl-katana.txt $1.crawl-gospider.txt $1.crawl-waybackurls.txt | sort -u | grep -oE '(http.*)' | grep $1 > $1.crawl.txt
rm -rf $1.crawl-katana.txt $1.crawl-gospider.txt $1.crawl-waybackurls.txt $1.crawl-gospider-dir

echo " $1.crawl.txt is created and has ` cat $1.crawl.txt | wc -l ` value"  