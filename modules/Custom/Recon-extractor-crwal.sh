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
                                                          Hashtag-Recon
                                                  https://github.com/hashtag-amin
                                                  
EOF

echo "Start extract urls with (.php|.js|.jsp|.asp|.aspx|.html|.htm) extention & with or without parameter"

file_name=` echo $1 | sed -e "s/.txt$//" -e "s/\*//" `

grep -hE "(\w+\.aspx(\?|$)|\w+\.asp(\?|$))" $1 | sort -u > $file_name-asp.txt
grep -hE "(\w+\.html(\?|$)|\w+\.htm(\?|$))" $1 | sort -u > $file_name-html.txt
grep -hE "\w+\.php(\?|$)" $1 | sort -u > $file_name-php.txt
grep -hE "\w+\.js(\?|$)" $1 | sort -u > $file_name-js.txt
grep -hE "\w+\.jsp(\?|$)" $1| sort -u > $file_name-jsp.txt
grep ? $1 | sort -u > $file_name-hashParam.txt
grep -v ? $1 | sort -u > $file_name-noParam.txt

sleep 0.5

echo "Result with js extention extract & length ==> ` wc -l $file_name-js.txt `"
echo "Result with jsp extention extract & length ==> ` wc -l $file_name-jsp.txt `"
echo "Result with php extention extract & length ==> ` wc -l $file_name-php.txt `"
echo "Result with asp|aspx extention extract & length ==> ` wc -l $file_name-asp.txt `"
echo "Result with htm|html extention extract & length ==> ` wc -l $file_name-html.txt `"
echo "Result without parameter extract & length ==> ` wc -l $file_name-noParam.txt `"
echo "Result with parameter extract & length ==> ` wc -l $file_name-hashParam.txt `"
echo