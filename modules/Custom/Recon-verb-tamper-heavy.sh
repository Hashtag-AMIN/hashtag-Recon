#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: Recon-verb-tamper.sh <Url(http://example.com)>"
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

methods=( "GET" "POST" "HEAD" "CONNECT" "PUT" "TRACE" "OPTIONS" "DELETE" "ACL" "ARBITRARY" "BASELINE-CONTROL" "BCOPY" "BDELETE" "BIND" "BMOVE" "BPROPFIND" "BPROPPATCH" "CHECKIN" "CHECKOUT" "COPY" "DEBUG" "INDEX" "LABEL" "LINK" "LOCK" "MERGE" "MKACTIVITY" "MKCALENDAR" "MKCOL" "MKREDIRECTREF" "MKWORKSPACE" "MOVE" "NOTIFY" "ORDERPATCH" "PATCH" "POLL" "PROPFIND" "PROPPATCH" "REBIND" "REPORT" "RPC_IN_DATA" "RPC_OUT_DATA" "SEARCH" "SUBSCRIBE" "TRACK" "UNBIND" "UNCHECKOUT" "UNLINK" "UNLOCK" "UNSUBSCRIBE" "UPDATE" "UPDATEREDIRECTREF" "VERSION-CONTROL" "X-MS-ENUMATTS" "jUNKVERB" )


domain_name=$( echo $1 | cut -d / -f3 )

for method in ${methods[@]}
do
    echo "==============================" | tee -a $domain_name-tamper.txt
    echo -e "Send request with $method http method \nHeaders:\n" | tee -a $domain_name-tamper.txt
    curl -skL -D - -o /dev/null -w "\nStatus code: %{response_code}\nResponse Lenght: %{size_download}\nType: %{content_type}\n\n" -X $method $1 | tee -a $domain_name-tamper.txt
    echo
    sleep 2 
done

echo "All result in $domain_name-tamper.txt"