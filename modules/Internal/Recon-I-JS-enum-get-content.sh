#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-I-JS-enum-get-content.sh <SubdomainList(example.com.live.txt)>"
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

file_name=` echo $1 | sed -e "s/.txt$//" -e "s/\*//" `

echo "Start getJS for crawl JSfile on $1 file:"
getJS -input $1 -complete -resolve -output $file_name-JS.txt
echo "getJS Done, result & length ==> ` wc -l $file_name-JS.txt `"

if [ ! -s "$file_name-JS.txt" ]; 
then
    echo "Can't find JS files, try more..."
    rm $file_name-JS.txt
    exit
fi

echo
now_date=`date "+%Y-%m-%d"`

echo "Start Download JSfile on $1 file:"
wget -i $file_name-JS.txt --directory-prefix $file_name-JS--$now_date/ --quiet
echo "Download JSfile Done & result in $file_name-JS--$now_date Directory & length ==> ` ls $file_name-JS--$now_date | wc -l `"

echo
echo "Start make md5sum JSfiles on $file_name-JS--$now_date Directory:"
for file in $( ls $file_name-JS--$now_date )
do
  cat $file_name-JS--$now_date/$file | md5sum | xargs -I % echo % : $file  hash-value >>  $file_name-JS-hash--$now_date.txt
done
echo "Make md5sum JSfiles Done, result & length ==> ` wc -l $file_name-JS-hash--$now_date.txt `"

echo "JS Enum is finish"
