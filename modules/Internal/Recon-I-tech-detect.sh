#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-I-tech-detect.sh <Url(http://example.com)> "
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

domain_name=` echo $1 | cut -d / -f3 `

echo
echo "whatweb" > $domain_name.tech-whatweb.txt
echo "Start whatweb for tech-detection site on $1 :"
whatweb --user-agent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:40.0) Gecko/20100101 Firefox/40.0" --no-errors $1 | sed "s/,/\n/g" >> $domain_name.tech-whatweb.txt
echo "whatweb Done, result & length ==> ` wc -l $domain_name.tech-whatweb.txt `"

echo
echo "wad" > $domain_name.tech-wad.txt
echo "Start wad for tech-detection site on $1 :"
wad -u $1 --format txt >> $domain_name.tech-wad.txt
echo "wad Done, result & length ==> ` wc -l $domain_name.tech-wad.txt `"

echo "Start wafw00f for waf-detection site on $1 :"
echo "wafw00f" > $domain_name.tech-wafw00f.txt
wafw00f --findall --output $domain_name.tech-wafw00f.txt $1
echo "wafw00f Done & result, result & length ==> ` wc -l $domain_name.tech-wafw00f.txt `"

cat $domain_name.tech-whatweb.txt $domain_name.tech-wad.txt $domain_name.tech-wafw00f.txt > $domain_name.techdetect.txt
rm $domain_name.tech-whatweb.txt $domain_name.tech-wad.txt $domain_name.tech-wafw00f.txt

echo "Final result, result & length ==> ` wc -l $domain_name.techdetect.txt `"