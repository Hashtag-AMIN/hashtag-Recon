#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-extractor-fuzz.sh <file(fuzz-file.csv)>"
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

file_name=` echo $1 | sed -e "s/.csv$//" -e "s/\//_/" -e "s/\*//" `

echo "Start Extarcting result of fuzzing files with status code [20X, 30X, 401,403,500] with csv extention"

grep -hE "(\,20[0-8]{1}\,)" $1 | cut -d , -f2 | sort -u > $file_name.20X.txt
grep -hE "(\,30[0-8]{1}\,)" $1 | cut -d , -f2 | sort -u > $file_name.30X.txt
grep -hE "(\,4[0-2]{1}[0-9]{1}\,)" $1 | cut -d , -f2 | sort -u > $file_name.4XX.txt
grep -hE "(\,5[0-1]{1}[0-9]{1}\,)" $1 | cut -d , -f2 | sort -u > $file_name.50X.txt

sleep 0.5

echo "Result with status Code 20X & length ==> ` wc -l $file_name.20X.txt `"
echo "Result with status Code 30X & length ==> ` wc -l $file_name.30X.txt `"
echo "Result with status Code 4XX & length ==> ` wc -l $file_name.4XX.txt `"
echo "Result with status Code 50X & length ==> ` wc -l $file_name.50X.txt `"