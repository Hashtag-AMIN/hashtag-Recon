#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-extractor-crwal.sh <file(example.com-crwal.txt)> "
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

file_neame=`echo $1 |  sed -e "s/.txt$//" -e "s/\//_/" -e "s/\*//" `

grep -hE "(\w+\.aspx(\?|$)|\w+\.asp(\?|$))" $1 | sort -u > $file_neame-asp.txt
grep -hE "\w+\.php(\?|$)" $1 | sort -u > $file_neame-php.txt
grep -hE "\w+\.js(\?|$)" $1 | sort -u > $file_neame-js.txt
grep -hE "\w+\.jsp(\?|$)" $1| sort -u > $file_neame-jsp.txt
grep ? $1 | sort -u > $file_neame-hashParam.txt
grep -v ? $1 | sort -u > $file_neame-noParam.txt

sleep 0.5

echo "Result with js extention extract & length ==> ` wc -l $file_neame-js.txt `"
echo "Result with jsp extention extract & length ==> ` wc -l $file_neame-jsp.txt `"
echo "Result with php extention extract & length ==> ` wc -l $file_neame-php.txt `"
echo "Result with asp|aspx extention extract & length ==> ` wc -l $file_neame-asp.txt `"
echo "Result without parameter extract & length ==> ` wc -l $file_neame-noParam.txt `"
echo "Result with parameter extract & length ==> ` wc -l $file_neame-hashParam.txt `"
echo