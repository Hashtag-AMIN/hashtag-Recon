#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-I-robots-sitemap.sh <URLs(example.com.live.txt)>"
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

echo "Start robofinder & curl request for find sitemap.xml files on $1 file:"
for site in $( cat $1 )
do
    curl -m 5 -sLk $site/robots.txt | grep -e "Allow\|Disallow" | cut -d " " -f2 | sed "s|^|$site|" > $file_name-tmp-sitemap.txt
    robofinder.py -u $site --quite --sitemap >> $file_name-sitemap.txt 2> /dev/null
    if [ -s "$file_name-tmp-sitemap.txt" ]
    then
        cat $file_name-tmp-sitemap.txt >> $file_name-sitemap.txt
        rm $file_name-tmp-sitemap.txt
    fi
done
echo "robofinder & curl request Done, result & length ==> ` wc -l $file_name-sitemap.txt `"

echo
sleep 3

echo "Start robofinder & curl request for find robots.txt files on $1 file:"
for site in $( cat $1 )
do
    curl -m 5 -sLk $site/sitemap.xml | grep -o "http[s]\?://[^ ]\+" | sed "s/<\/loc>//" > $file_name-tmp-robots.txt
    robofinder.py -u $site --quite --address >> $file_name-robots.txt 2> /dev/null
    if [ -s "$file_name-tmp-robots.txt" ]
    then
        cat $file_name-tmp-robots.txt >> $file_name-robots.txt
        rm $file_name-tmp-robots.txt
    fi
done
echo "robofinder & curl request Done, result & length ==> ` wc -l $file_name-robots.txt`"

sort -u $file_name-sitemap.txt $file_name-robots.txt > $file_name-roboMap.txt
rm $file_name-sitemap.txt $file_name-robots.txt

echo "Final result & length ==> ` wc -l $file_name-roboMap.txt`"