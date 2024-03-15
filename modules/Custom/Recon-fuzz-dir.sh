#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: fuzz-dir.sh <Url(http://example.com)>"
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

domain_name=`echo $1 | cut -d / -f3`
echo "Start ffuf for fuzz cve dirs with: fuzz-dir-cve.txt file"
ffuf -u $1/FUZZ -w ./wordlist/fuzz-dir-cve.txt -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; MSBrowserIE; rv:11.0) like Gecko" -H "X-Forwarded-For: 127.0.0.1" -fc 404 -of csv -t 1 -o $domain_name.fuzz-dir-cve.csv
echo "fuzz cve dirs Done & final result in $domain_name.fuzz-dir-cve.csv ==> len: ` cat $domain_name.fuzz-dir-cve.csv | wc -l `"

sleep 5
echo
echo "Start ffuf for fuzz leaky-misconfigs dirs with: fuzz-dir-leaky-misconfigs.txt file"
ffuf -u $1/FUZZ -w ./wordlist/fuzz-dir-leaky-misconfigs.txt -H "User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0" -H "X-Forwarded-For: 127.0.0.1" -fc 404 -of csv -t 1 -o $domain_name.fuzz-dir-leaky-misconfigs.csv
echo "fuzz leaky-misconfigs dirs Done & final result in $domain_name.fuzz-dir-leaky-misconfigs.csv ==> len: ` cat $domain_name.fuzz-dir-leaky-misconfigs.csv | wc -l `"

sleep 5
echo
echo "Start ffuf for fuzz backup_files dirs with: fuzz-dir-backup_files.txt file"
ffuf -u $1/FUZZ -w ./wordlist/fuzz-dir-backup_files.txt -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:39.0) Gecko/20100101 Firefox/39.0" -H "X-Forwarded-For: 127.0.0.1" -fc 404 -of csv -t 1 -o $domain_name.fuzz-dir-backup_files.txt
echo "fuzz backup_files dirs Done & final result in $domain_name.fuzz-dir-backup_files.txt ==> len: ` cat $domain_name.fuzz-dir-backup_files.txt | wc -l `"

sleep 5
echo
echo "Start ffuf for fuzz backup_files & dirs with: fuzz-dir-api-info.txt file"
ffuf -u $1/FUZZ -w ./wordlist/fuzz-dir-api-info.txt -H "User-Agent: Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; WOW64; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET4.0C; .NET4.0E)" -H "X-Forwarded-For: 127.0.0.1" -fc 404 -of csv -t 1 -o $domain_name.fuzz-dir-api-info.csv
echo "fuzz backup_files & dirs Done & final result in $domain_name.fuzz-dir-api-info.csv ==> len: ` cat $domain_name.fuzz-dir-api-info.csv | wc -l `"

sleep 5
echo
echo "Start ffuf for fuzz cgi dirs with: fuzz-cgi-files.txt file"
ffuf -u $1/FUZZ -w ./wordlist/fuzz-cgi-files.txt -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; Trident/7.0; rv:11.0) like Gecko" -H "X-Forwarded-For: 127.0.0.1" -fc 404 -of csv -t 1 -o $domain_name.fuzz-dir-cgi-files.csv
echo "fuzz cgi dirs Done & final result in $domain_name.fuzz-dir-cgi-files.csv ==> len: ` cat $domain_name.fuzz-dir-cgi-files.csv | wc -l `"

cat $domain_name.fuzz-dir-cve.csv $domain_name.fuzz-dir-leaky-misconfigs.csv $domain_name.fuzz-dir-backup_files.txt $domain_name.fuzz-dir-api-info.csv $domain_name.fuzz-dir-cgi-files.csv > $domain_name-fuzz-dir.csv

rm $domain_name.fuzz-dir-cve.csv $domain_name.fuzz-dir-leaky-misconfigs.csv $domain_name.fuzz-dir-backup_files.txt $domain_name.fuzz-dir-api-info.csv $domain_name.fuzz-dir-cgi-files.csv

echo "dir fuzzing is finished and ` cat $domain_name-fuzz-dir.csv | wc -l ` Results"