#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-DNS-Looter.sh <SubdomainList(example.com.allSubdomains.txt)>"
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

file_name=` echo $1 | sed -e "s/.txt$//" -e "s/\//_/" -e "s/\*//" `

echo "Run dnsx & Extract all record with: $1 file"
dnsx -l $1 -recon -o $file_name-DNS-all.txt -silent -no-color > /dev/null
echo "dnsx all record Done, result & length ==> ` wc -l $file_name-DNS-all.txt `"
echo

echo  "Let's Extract Records:"

grep "\ \[A\]\ " $file_name-DNS-all.txt | cut -d " " -f3 | sed -e "s/\[//" -e "s/\]//" | sort -u > $file_name-DNS-A.txt
echo "Extract A-Record Done, result & length ==> ` wc -l $file_name-DNS-A.txt `"

grep "\ \[AAAA\]\ " $file_name-DNS-all.txt | cut -d " " -f3 | sed -e "s/\[//" -e "s/\]//" | sort -u > $file_name-DNS-AAAA.txt
echo "Extract AAAA-Record Done, result & length ==> ` wc -l $file_name-DNS-AAAA.txt `"

grep "\ \[CNAME\]\ " $file_name-DNS-all.txt | cut -d " " -f3 | sed -e "s/\[//" -e "s/\]//" | sort -u > $file_name-DNS-CNAME.txt
echo "Extract CNAME-Record Done, result & length ==> ` wc -l $file_name-DNS-CNAME.txt `"

grep "\ \[MX\]\ " $file_name-DNS-all.txt | cut -d " " -f3 | sed -e "s/\[//" -e "s/\]//" | sort -u > $file_name-DNS-MX.txt
echo "Extract MX-Record Done, result & length ==> ` wc -l $file_name-DNS-MX.txt `"

grep "\ \[NS\]\ " $file_name-DNS-all.txt | cut -d " " -f3 | sed -e "s/\[//" -e "s/\]//" | sort -u > $file_name-DNS-NS.txt
echo "Extract NS-Record Done, result & length ==> ` wc -l $file_name-DNS-NS.txt `"

grep -v -e "\ \[A\]\ " -e "\ \[AAAA\]\ " -e "\ \[CNAME\]\ " -e "\ \[MX\]\ " -e "\ \[NS\]\ " $file_name-DNS-all.txt | sort -u > $file_name-DNS-others.txt
echo "Extract Others-Record Done, result & length ==> ` wc -l $file_name-DNS-others.txt `"

echo
echo "Run cut-cdn & exclude CND Ips from: $file_name-DNS-A.txt file"
cut-cdn -ip $file_name-DNS-A.txt -active -silent -thread 20 -o $file_name-No-cdn.txt -silent 
echo "cut-cdn Done, result & length ==> ` wc -l $file_name-No-cdn.txt `"

echo
echo "Start request to bgpview.io & find CIDRs from $file_name-No-cdn.txt"
for ip in $( cat $file_name-No-cdn.txt )
do
    curl https://api.bgpview.io/ip/$ip -s | jq -r ".data.prefixes[0].prefix" >> $file_name.all-ASN-ip-range.txt
    sleep 0.2
done
sort -un $file_name.all-ASN-ip-range.txt > $file_name-CIDR.txt
rm $file_name.all-ASN-ip-range.txt
echo "bgpview.io request Done, result & length ==> ` wc -l $file_name-CIDR.txt `"


echo
echo "Run dnsx to Extract PTR Record with $file_name-DNS-A.txt"
dnsx -l $file_name-DNS-A.txt -resp-only -ptr -silent -no-color | sort -u > $file_name-DNS-PTR.txt
echo "Extract PTR-Record Done, result & length ==> ` wc -l $file_name-DNS-PTR.txt `"
echo