#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-I-tech-detect.sh <Domain(example.com)[Without-Schema]> "
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

echo "wappy" >> $1.tech-wappy.txt 
echo "Start wappy for tech-detection site on $1 :"
wappy --url $1 --writefile $1.tech-wappy.txt >> /dev/null
echo "wappy Done & result in $1.tech-wappy.txt ==> len: ` cat $1.tech-wappy.txt | wc -l `"

echo
echo "Start whatweb for tech-detection site on $1 :"
whatweb  --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/37.0.2062.94 Chrome/37.0.2062.94 Safari/537.36" --no-errors http://$1 | sed "s/,/\n/g" >> $1.tech-whatweb.txt
whatweb  --user-agent "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36" https://$1 | sed "s/,/\n/g" >> $1.tech-whatweb.txt
echo "whatweb Done & result in $1.tech-whatweb.txt ==> len: ` cat $1.tech-whatweb.txt | wc -l `"

echo
echo "Start wad for tech-detection site on $1 :"
wad -u http://$1 --format txt > $1.tech-wad.txt
wad -u https://$1 --format txt >> $1.tech-wad.txt
echo "wad Done & result in $1.tech-wad.txt ==> len: ` cat $1.tech-wad.txt | wc -l `"

echo "Start wafw00f for waf-detection site on $1 :"
wafw00f --findall --output $1.tech-wafw00f.txt $1
echo "wafw00f Done & result in $1.tech-wafw00f.txt ==> len: ` cat $1.tech-wafw00f.txt | wc -l `"

cat $1.tech-wappy.txt $1.tech-whatweb.txt $1.tech-wad.txt $1.tech-wafw00f.txt > $1.techdetect.txt
rm $1.tech-wappy.txt $1.tech-whatweb.txt $1.tech-wad.txt $1.tech-wafw00f.txt

echo "Final result in $1.techdetect.txt ==> len: ` cat $1.techdetect.txt | wc -l `"