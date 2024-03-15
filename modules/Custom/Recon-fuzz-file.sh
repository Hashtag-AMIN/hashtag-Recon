#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: fuzz-file.sh <Url(http://example.com)>"
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
echo "Start ffuf for fuzz sensetive files with: fuzz-sensetive-files.txt file"
ffuf -u $1/FUZZ -w ./wordlist/fuzz-sensetive-files.txt -H "User-Agent: Mozilla/5.0 (Windows NT 6.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36" -H "X-Forwarded-For: 127.0.0.1" -fc 404 -of csv -t 1 -o $domain_name.fuzz-sensetive-file.csv
echo "fuzz sensetive files Done & final result in $domain_name.fuzz-sensetive-file.csv ==> len: ` cat $domain_name.fuzz-sensetive-file.csv | wc -l `"

sleep 5
echo
echo "Start ffuf for fuzz config files with: fuzz-config.txt file"
ffuf -u $1/FUZZ -w ./wordlist/fuzz-config.txt -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36" -H "X-Forwarded-For: 127.0.0.1" -fc 404 -of csv -t 1 -o $domain_name.fuzz-config-file.csv
echo "fuzz config files Done & final result in $domain_name.fuzz-config-file.csv ==> len: ` cat $domain_name.fuzz-config-file.csv | wc -l `"

sleep 5
echo
echo "Start ffuf for fuzz .env files with: fuzz-env.txt file"
ffuf -u $1/FUZZ -w ./wordlist/fuzz-env.txt -H "User-Agent: Mozilla/5.0 (Linux; U; Android 4.0.4; en-us; KFJWI Build/IMM76D) AppleWebKit/537.36 (KHTML, like Gecko) Silk/3.68 like Chrome/39.0.2171.93 Safari/537.36" -H "X-Forwarded-For: 127.0.0.1" -fc 404 -of csv -t 1 -o $domain_name.fuzz-env-file.csv
echo "fuzz .env files Done & final result in $domain_name.fuzz-env-file.csv ==> len: ` cat $domain_name.fuzz-env-file.csv | wc -l `"

sleep 5
echo
echo "Start ffuf for fuzz dotfiles files with: fuzz-dotfiles.txt file"
ffuf -u $1/FUZZ -w ./wordlist/fuzz-dotfiles.txt -H "User-Agent: Mozilla/5.0 (Unknown; Linux x86_64) AppleWebKit/538.1 (KHTML, like Gecko) PhantomJS/2.0.0 Safari/538.1" -H "X-Forwarded-For: 127.0.0.1" -fc 404 -of csv -t 1 -o $domain_name.fuzz-dotfiles-file.csv
echo "fuzz dotfiles files Done & final result in $domain_name.fuzz-dotfiles-file.csv ==> len: ` cat $domain_name.fuzz-dotfiles-file.csv | wc -l `"

sleep 5
echo
echo "Start ffuf for fuzz pub & priv keys files with: fuzz-keys.txt file"
ffuf -u $1/FUZZ -w ./wordlist/fuzz-keys.txt -H "User-Agent: Mozilla/5.0 (iPad; CPU OS 8_4_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) CriOS/44.0.2403.67 Mobile/12H321 Safari/600.1.4" -H "X-Forwarded-For: 127.0.0.1" -fc 404 -of csv -t 1 -o $domain_name.fuzz-keys-file.csv
echo "fuzz pub & priv keys files Done & final result in $domain_name.fuzz-keys-file.csv ==> len: ` cat $domain_name.fuzz-keys-file.csv | wc -l `"

sleep 5
echo
echo "Start ffuf for fuzz .npmrc files with: fuzz-npmrc.txt file"
ffuf -u $1/FUZZ -w ./wordlist/fuzz-npmrc.txt -H "User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:39.0) Gecko/20100101 Firefox/39.0" -H "X-Forwarded-For: 127.0.0.1" -fc 404 -of csv -t 1 -o $domain_name.fuzz-npmrc-file.csv
echo "fuzz npmrc files Done & final result in $domain_name.fuzz-npmrc-file.csv ==> len: ` cat $domain_name.fuzz-npmrc-file.csv | wc -l `"

sleep 5
echo
echo "Start ffuf for fuzz .sql files with: fuzz-sql.txt file"
ffuf -u $1/FUZZ -w ./wordlist/fuzz-sql.txt -H "User-Agent: Mozilla/5.0 (MSIE 9.0; Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko" -H "X-Forwarded-For: 127.0.0.1" -fc 404 -of csv -t 1 -o $domain_name.fuzz-sql-file.csv
echo "fuzz sql files Done & final result in $domain_name.fuzz-sql-file.csv ==> len: ` cat $domain_name.fuzz-sql-file.csv | wc -l `"

sleep 5
echo
echo "Start ffuf for fuzz .log files with: fuzz-logs.txt file"
ffuf -u $1/FUZZ -w ./wordlist/fuzz-logs.txt -H "User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; WOW64; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET4.0C; .NET4.0E)" -H "X-Forwarded-For: 127.0.0.1" -fc 404 -of csv -t 1 -o $domain_name.fuzz-logs-file.csv
echo "fuzz sql files Done & final result in $domain_name.fuzz-logs-file.csv ==> len: ` cat $domain_name.fuzz-logs-file.csv | wc -l `"

sleep 5
echo
echo "Start ffuf for fuzz .yaml & .yml files with: fuzz-yaml.txt file"
ffuf -u $1/FUZZ -w ./wordlist/fuzz-yaml.txt -H "User-Agent: Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; WOW64; Trident/6.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .NET4.0C; .NET4.0E)" -H "X-Forwarded-For: 127.0.0.1" -fc 404 -of csv -t 1 -o $domain_name.fuzz-yaml-file.csv
echo "fuzz yaml files Done & final result in $domain_name.fuzz-yaml-file.csv ==> len: ` cat $domain_name.fuzz-yaml-file.csv | wc -l `"

cat $domain_name.fuzz-sensetive-file.csv $domain_name.fuzz-config-file.csv $domain_name.fuzz-env-file.csv $domain_name.fuzz-dotfiles-file.csv $domain_name.fuzz-keys-file.csv $domain_name.fuzz-npmrc-file.csv $domain_name.fuzz-sql-file.csv $domain_name.fuzz-logs-file.csv > $domain_name-fuzz-file.csv

rm $domain_name.fuzz-sensetive-file.csv $domain_name.fuzz-config-file.csv $domain_name.fuzz-env-file.csv $domain_name.fuzz-dotfiles-file.csv $domain_name.fuzz-keys-file.csv $domain_name.fuzz-npmrc-file.csv $domain_name.fuzz-sql-file.csv $domain_name.fuzz-logs-file.csv

echo "file fuzzing is finished and ` cat $domain_name-fuzz-file.csv | wc -l ` Results"