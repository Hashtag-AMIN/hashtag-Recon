#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-apktool.sh <Android-App(app.apk)>"
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

appname=` echo $1 | cut -d . -f1 `

echo "Run apktool & Extract EndPoint from apk app: $1 file"

apktool d $1 --output $appname-dir

grep -IPhro "(https?://|http?://)[\w\.-/]+[\"\'\`]" $appname-dir/ | sed -e "s/\"//g" -e "s/\'//g" -e "s/\`//g" | sort -u > $appname-apk.txt

rm -rf $appname-dir

echo "apktool Done, result & length ==> ` wc -l $appname-apk.txt `"