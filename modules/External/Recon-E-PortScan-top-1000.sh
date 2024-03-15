if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-PortScan-1000.sh <Domain|IP(example.com|10.10.10.10)>"
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

echo "Start RustScan for Scan Top 1000 Ports for $1"

nmap -iL $2 -T5 --min-parallelism 256 --min-hostgroup 1024 --max-retries 2 -sS --top-ports 1000 --script ssl-cert -oN $file_neame-PortScan-http.txt > /dev/null

echo "RustScan with Nmap Done & final result in $file_neame-PortScan-1000.txt ==> len: ` cat $file_neame-PortScan-1000.txt | wc -l `"