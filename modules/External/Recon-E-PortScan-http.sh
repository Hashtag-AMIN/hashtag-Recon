if [ $# -ne 1 ]
  then
    echo "Args is not Valid"
    echo "Usage: bash Recon-E-PortScan-http.sh <file(example.com.CIDR.txt)>"
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

echo "Start Nmap for Scan http Ports on $1"

nmap -iL $1 -T5 --min-parallelism 64 --min-hostgroup 64 --max-retries 2 --max-scan-delay 20ms --min-rate 500 -sS -Pn -p 21,22,23,25,53,80,110,161,389,443,445,465,587,631,636,664,832,990,993,995,1025,1129,1184,1701,1723,2000,2381,2483,2484,2601,3000,3001,3128,3269,3306,3389,3690,4036,4849,5060,5443,5900,5989,5990,6443,6771,6789,7443,7677,8000-8010,8080-8090,8243,8333,8443,8991,9001,9295,9333,9443,9444,9929,10000,10443,16993,18333,19333,20003 --script ssl-cert -oN $file_name-http-port.txt > /dev/null

echo "Nmap Done, result & length ==> ` wc -l $file_name-http-port.txt `"


# sort -r -k3 /usr/share/nmap/nmap-services | grep -iE http | tr "\t" " " | cut -d " " -f2 | cut -d / -f1 | sort -un | tr "\n" "," | sed -e "s/\,$//" -e "s/^From,//"
