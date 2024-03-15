#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-I-crwal-extractor.sh <file(example.com-crwal.txt)|(*.crawl.txt)> "
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

echo "Start extract urls with (.php|.js|.jsp|.asp|.aspx) extention & with or without parameter"

file_neame=`echo $1 |  sed "s/.txt//g"`
cat $1 | grep -rhE "(\w+\.aspx(\?|$)|\w+\.asp(\?|$))" | sort -u > $file_neame-asp.txt
cat $1 | grep -rhE "\w+\.php(\?|$)" | sort -u > $file_neame-php.txt
cat $1 | grep -rhE "\w+\.js(\?|$)" | sort -u > $file_neame-js.txt
cat $1 | grep -rhE "\w+\.jsp(\?|$)" | sort -u > $file_neame-jsp.txt
cat $1 | grep ? | sort -u > $file_neame-hashParam.txt
cat $1 | grep -v ? | sort -u > $file_neame-noParam.txt

sleep 1

echo "Result with js extention extract in $file_neame-js.txt & len ` cat $file_neame-js.txt | wc -l `"
echo "Result with jsp extention extract in $file_neame-jsp.txt & len ` cat $file_neame-jsp.txt | wc -l `"
echo "Result with php extention extract in $file_neame-php.txt & len ` cat $file_neame-php.txt | wc -l `"
echo "Result with asp|aspx extention extract in $file_neame-asp.txt & len ` cat $file_neame-asp.txt | wc -l `"
echo "Result without parameter extract in $file_neame-noParam.txt & len ` cat $file_neame-noParam.txt | wc -l `"
echo "Result with parameter extract in $file_neame-hashParam.txt & len ` cat $file_neame-hashParam.txt | wc -l `"
echo