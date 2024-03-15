#!/bin/bash

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

mkdir tools-src
cd tools-src

echo "First we need isntall common tools"
echo "such as Nmap & jq & dos2unix & ..."
    apt update -y
    apt install nmap jq dos2unix curl wget git whois apktool -y

#===============
echo "second install External Recon Tools"
echo "Such as : subfinder, waybackurls, github-subdomains"

    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
    go install github.com/tomnomnom/waybackurls@latest&\
    go install github.com/gwen001/github-subdomains@latest

echo "ffuf, shuffledns, dnsx, cut-cdn"&\
    go install github.com/ffuf/ffuf/v2@latest
    go install -v github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest&\
	go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest
    go install github.com/ImAyrix/cut-cdn@latest&\

echo "dnsgen, Sublist3r, massdns, assetfinder, rustscan"
    python3 -m pip install dnsgen

    git clone https://github.com/aboul3la/Sublist3r.git
    cd Sublist3r
    python3 setup.py install
    cd ..

    git clone https://github.com/blechschmidt/massdns.git
    cd massdns
    make
    cp ./bin/massdns /usr/local/sbin
    cd ..

    mkdir assetfinder
    cd assetfinder
    wget https://github.com/tomnomnom/assetfinder/releases/download/v0.1.1/assetfinder-linux-amd64-0.1.1.tgz
    tar xfv assetfinder-linux-amd64-0.1.1.tgz
    cp assetfinder /usr/local/sbin
    cd ..

#===================
echo "third install Internal Recon Tools:"

echo "httpx, getJS, katana, gospider, unfurl, nuclei, gauplus"

    go install github.com/bp0lr/gauplus@latest&\
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
    go install github.com/003random/getJS@latest&\
    go install github.com/projectdiscovery/katana/cmd/katana@latest
    go install github.com/jaeles-project/gospider@latest
    go install github.com/tomnomnom/unfurl@latest&\

echo "Install whatweb wafw00f"
    apt install whatweb wafw00f -y

echo "RoboFinder, trufflehog, wad, wappy, fetchParam"

    git clone https://github.com/SadraZg/RoboFinder
    cd RoboFinder
    python3 -m pip install -r requirements.txt
    sed -i '1s/^/\#\!\/usr\/bin\/env\ python3\n/' robofinder.py
    chmod +x robofinder.py
    cp ./robofinder.py /usr/local/sbin
    cd ..

    curl -sSfL https://raw.githubusercontent.com/trufflesecurity/trufflehog/main/scripts/install.sh | sh -s -- -b /usr/local/sbin&\

    python3 -m pip install wad

    git clone https://github.com/gokulapap/wappalyzer-cli&\
    cd wappalyzer-cli
    python3 -m pip install .
    cd ..

    git clone https://github.com/Hashtag-AMIN/fetchParam
    cd fetchParam
    python3 -m pip install -r requirement.txt
    chmod +x fetchParam.py
    dos2unix fetchParam.py
    cp fetchParam.py /usr/local/sbin
    cd ..

echo "Install arjun & x8"
    python3 -m pip install arjun&\

    mkdir x8
    cd x8 
    wget https://github.com/Sh1Yo/x8/releases/download/v4.3.0/x86_64-linux-x8.gz
    gunzip x86_64-linux-x8.gz
    chmod +x x86_64-linux-x8
    cp x86_64-linux-x8 /usr/local/sbin/x8
    cd ..

    cp /root/go/bin/* /usr/local/sbin/ || cp /home/${USER}/go/bin/* /usr/local/sbin/

cd ..