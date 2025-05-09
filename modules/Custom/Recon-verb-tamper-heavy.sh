#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-verb-tamper-heavy.sh <Url(http://example.com)>"
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

methods=( "GET" "POST" "HEAD" "CONNECT" "PUT" "TRACE" "OPTIONS" "DELETE" "ACL" "ARBITRARY" "BASELINE-CONTROL" "BCOPY" "BDELETE" "BIND" "BMOVE" "BPROPFIND" "BPROPPATCH" "CHECKIN" "CHECKOUT" "COPY" "DEBUG" "INDEX" "LABEL" "LINK" "LOCK" "MERGE" "MKACTIVITY" "MKCALENDAR" "MKCOL" "MKREDIRECTREF" "MKWORKSPACE" "MOVE" "NOTIFY" "ORDERPATCH" "PATCH" "POLL" "PROPFIND" "PROPPATCH" "REBIND" "REPORT" "RPC_IN_DATA" "RPC_OUT_DATA" "SEARCH" "SUBSCRIBE" "TRACK" "UNBIND" "UNCHECKOUT" "UNLINK" "UNLOCK" "UNSUBSCRIBE" "UPDATE" "UPDATEREDIRECTREF" "VERSION-CONTROL" "X-MS-ENUMATTS" "jUNKVERB" )

domain_name=` echo $1 | cut -d / -f3 `

for method in "${methods[@]}"; 
do
    echo "Sending request with $method HTTP method..."

    response=$(curl -skL -X $method -D - -o /dev/null -w "HTTP_CODE:%{http_code}\nRESPONSE_LENGTH:%{size_download}\nCONTENT_TYPE:%{content_type}" $1)
    http_code=$(echo "$response" | grep -o "HTTP_CODE:[0-9]*" | cut -d: -f2)

    if [ "$http_code" -eq 405 ]; then
        echo "HTTP 405 (Method Not Allowed) for $method"
        continue
    fi

    echo "==============================" | tee -a "$domain_name-tamper.txt"
    echo -e "Send request with $method HTTP method\nHeaders:\n" | tee -a "$domain_name-tamper.txt"
    echo "$response" | tee -a "$domain_name-tamper.txt"
    echo
    sleep 1
done

echo "All results saved in $domain_name-tamper.txt"
