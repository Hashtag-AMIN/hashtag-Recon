if [ $# -ne 2 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-PortScan-top.sh <file(example.com.CIDR.txt)> <Top Ports Numer>"
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

echo "Start Nmap for Scan Top Ports for $1"

nmap -iL $1 -T5 --min-parallelism 64 --min-hostgroup 64 --max-retries 2 --max-scan-delay 20ms --min-rate 500 -sS -Pn --top-ports $2 -oN $file_name-top-Port.txt > /dev/null

echo "Nmap with Nmap Done, result & length ==> ` wc -l $file_name-top-Port.txt `"