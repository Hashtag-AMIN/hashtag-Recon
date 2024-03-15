#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash fuzz-Extractor.sh <file(subdomain-file.txt)|(*.txt)>"
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

file_name=` echo $1 |  sed "s/.txt//g" `
echo "Start Extarcting result of httpx with status code [20X, 30X, 4XX, 5XX] with txt extention"

cat $1 | grep -rhE "(20[0-8]{1})" | cut -d " " -f1 > $file_name.20X.txt
cat $1 | grep -rhE "(30[0-8]{1})" | cut -d " " -f1 > $file_name.30X.txt
cat $1 | grep -rhE "(4[0-2]{1}[0-9]{1})" | cut -d " " -f1 > $file_name.4XX.txt
cat $1 | grep -rhE "(5[0-1]{1}[0-9]{1})" | cut -d " " -f1 > $file_name.50X.txt

sleep 1

echo "Result with status Code 20X in $file_name.20X.txt & len ==> ` cat $file_name.20X.txt | wc -l `"
echo "Result with status Code 30X in $file_name.30X.txt & len ==> ` cat $file_name.30X.txt | wc -l `"
echo "Result with status Code 4XX in $file_name.4XX.txt & len ==> ` cat $file_name.4XX.txt | wc -l `"
echo "Result with status Code 50X in $file_name.50X.txt & len ==> ` cat $file_name.50X.txt | wc -l `"