if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-PortScan-http.sh <Domain|IP|file(example.com|10.10.10.10)>"
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

file_neame=`echo $1 |  sed "s/.txt//g"`

echo "Start Nmap for Scan http Ports for $1"

nmap -iL $2 -T5 --min-parallelism 256 --min-hostgroup 1024 --max-retries 2 -sS -p 21,22,23,25,53,80,110,161,389,443,445,465,587,636,990,993,995,1025,1701,1723,2000,2483,2484,2601,3000,3001,3128,3269,3306,3389,3690,5060,5900,8000,8008,8080,8443,9001,10443 --script ssl-cert -oN $file_neame-PortScan-http.txt > /dev/null

echo "Nmap Done & final result in $file_neame-PortScan-http.txt ==> len: ` cat $file_neame-PortScan-http.txt | wc -l `"


# sort -r -k3 /usr/share/nmap/nmap-services | tr "\t" " " | cut -d " " -f1-2 |  grep -E "(https|http)" | grep -Eo "([0-9]*/tcp|[0-9]*/udp)" | cut -d / -f1 | sort -un | tr "\n" "," | sed "s/\,$//"