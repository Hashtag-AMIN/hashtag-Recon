
#  &nbsp; 🔭  Hashtag-Recon

<h3> Reconnaissance & Footprinting framework for BugHunters & RedTeamers  </h3>

&nbsp;&nbsp;<img src="https://img.shields.io/static/v1?label=&labelColor=lightblue&message=Python&color=blue&style=flat&logo=python&logoColor=black">&nbsp;&nbsp;<img src="https://img.shields.io/static/v1?label=&labelColor=gray&message=Bash&color=orange&style=flat&logo=linux&logoColor=black">
<h4> This tool can handle almost all recon steps and have these Modules:<h4>

```text
└─# ./hashtag-Recon

           _     _          _                            ______
          (_)   (_)        | |     _                    (_____ \
          ______ _____  ___| |__ _| |_ _____  ____ _____ _____) )_____  ____ ___  ____
         | ___  (____ |/___|  _ (_   _(____ |/ _  (_____|  __  /| ___ |/ ___/ _ \|  _ \
        | |   | / ___ |___ | | | || |_/ ___ ( (_| |     | |  \ \| ____( (__| |_| | | | |
        |_|   |_\_____(___/|_| |_| \__\_____|\___ |     |_|   |_|_____)\____\___/|_| |_|
                                            (_____|
                                                                Hashtag_AMIN
                                                        https://github.com/hashtag-amin

        External:
            subdomain, Resolver, ptResolver, dnsBrute
            dnsLooter, openSSL, whois, favicon, portScan
            vhostScan, apkExtract, liveProbe, screenShoter
            
        Internal:
            crawler, JSEnum, techDetect, roboMap
            paramExtract, hiddenParam, hiddenHeader

        Custom:
            Fuzzer, Tamper, Extractor, Spliter

```

<br>
<h3> Use these tools in this Framework: </h3>

## At First:

Need to install 

    Python
    Golang

    # better lastest version

Need Github Subdomain token (optional But use in some module)

```bash
export $GITHUB_TOKEN="Your_Github_Token"
```
After Need export Golang Path or Copy in $PATH folders:

```bash
export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"

Or

cp /root/go/bin/* /usr/local/sbin/ || cp /home/${USER}/go/bin/* /usr/local/sbin/

```

## Common tools:

<h4> &nbsp;&nbsp;&nbsp;&nbsp; nmap, jq, dos2unix, curl, wget, git, whois, whatweb, wafw00f, apktool</h4>

## External tools:

&nbsp;&nbsp;&nbsp;&nbsp; [Subfinder](https://github.com/projectdiscovery/subfinder), &nbsp; [Sublist3r](https://github.com/aboul3la/Sublist3r), &nbsp; [assetfinder](https://github.com/tomnomnom/assetfinder), &nbsp;[waybackurls](https://github.com/tomnomnom/waybackurls), &nbsp; [github-subdomains](https://github.com/gwen001/github-subdomains), &nbsp; [shuffledns](https://github.com/projectdiscovery/shuffledns),  &nbsp; [dnsx](https://github.com/projectdiscovery/dnsx), &nbsp; [cut-cdn](https://github.com/ImAyrix/cut-cdn), &nbsp; [massdns](https://github.com/blechschmidt/massdns), &nbsp; [ffuf](https://github.com/ffuf/ffuf), &nbsp; [httpx](https://github.com/projectdiscovery/httpx)


## Internal tools:

&nbsp;&nbsp;&nbsp;&nbsp; [gauplus](https://github.com/bp0lr/gauplus), &nbsp; [getJS](https://github.com/003random/getJS), &nbsp; [katana](https://github.com/projectdiscovery/katana), &nbsp; [gospider](https://github.com/jaeles-project/gospider), &nbsp; [unfurl](https://github.com/tomnomnom/unfurl), &nbsp; [fetchParam](https://github.com/Hashtag-AMIN/fetchParam), &nbsp; [RoboFinder](https://github.com/SadraZg/RoboFinder), &nbsp; [trufflehog](https://github.com/trufflesecurity/trufflehog), &nbsp; [wad](https://github.com/CERN-CERT/WAD), &nbsp; [wappalyzer-cli](https://github.com/gokulapap/wappalyzer-cli), &nbsp; [arjun](https://github.com/s0md3v/Arjun), &nbsp; [x8](https://github.com/Sh1Yo/x8)


<h3> Also you can install all tools with Tools-Install.sh script</h3>

```bash
bash ./Tools-Install.sh
```

## Wordlist

a little and useful Wordlist in ./wordlist collect from [SecList](https://github.com/danielmiessler/SecLists) & [Bugbounty wordlist](https://github.com/Karanxa/Bug-Bounty-Wordlists) & [assetnote](https://wordlists.assetnote.io/)

Also has script that update wordlist with dynamic assetnote wordlist

```bash
bash ./wordlist-Updater.sh
```

<h3> Finally need Headless Browser for get a better result, But is optional (Ubuntu & Debian base)</h3>

```bash
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt update 
sudo apt install google-chrome-stable
```


Test and run on Ubuntu & Kali

Also all modules run in wsl (Windows) too, Expect Headless Browser

<h1> Let's autopsy Modules and how to use </h1>

<h2> External </h2>
<h3 > Subdomain </h3>

This module has two mode:

    Light
        - fast mode and Not use all resource such as:
            Subfinder, Subli3tr, assetfinder, jldc.me, Content-Security-Policy Header
    Heavy
        - Slow mode but has a good & deep result of subdomains list
            use all tools in fast mode , aditonal with deep flag in each tools
            So use github-subdomain, waybackurls(Archive), amass -whois (Reverse Whois Mode)
    Recursive
        - take subdomains list in Last two mode and search subdomains recursively.
            Better use resolver module then use this.

    In one lier deep this module use Providers & Project websits, certificate, seaarch Engines, whois, Reverse whois & ...


        ./hashtag-Recon subdomain -light -domain example.com
        ./hashtag-Recon subdomain -heavy -domain example.com
        ./hashtag-Recon subdomain -recursive -subs example.com.subs.txt

    Output:
        example.com.Subs-provider.txt
        example.com.recursive-Subs.txt

<h3 > Resolver </h3>

Take list of subdomains and resolve all domains that has any dns record

        ./hashtag-Recon resolver -subs example.com.subs.txt

    Output:
        example.com.Subs.resolve.txt

    Use massdns and wrapper on that shuffledns

<h3 > PtResolver </h3>

Take list of CIDRs/IPs and resolve all IPs that has ptr dns record

        ./hashtag-Recon ptresolver -ip example.com.CIDR.txt

    Output:
        example.com.ptresolver.txt

    Use dnsx in this part

<h3> DnsBrute </h3>

This module has two mode looklike subdomain module:

    Light
        - fast mode and use top 500k subdomain & efficient wordlist for dnsgen
            
    Heavy
        - Slow mode but Use top 1M subdomain & complete wordlist for dnsgen
            
    Use shuffledns & dnsgen with Custom wordlist that take & collect from almost all similar tools
    First FUZZ.domain.tld
    Then Resolve dnsgen result

        ./hashtag-Recon dnsBrute -domain example.com -subs example.com.subs.txt -light
        ./hashtag-Recon dnsBrute -domain example.com -subs example.com.subs.txt -heavy

    Output:
        example.com.dnsBrute.txt
        example.com.dnsgen.txt
        example.com.dnsBrute-gen.txt


<h3> DnsLooter </h3>

Again use dns protocol but this time, loot time :)

Extract dns record such as : A, CNAME, MX, PTR

Then Exclude CDN IPs, Find CIDR range

        ./hashtag-Recon dnsLooter -subs example.com.subs.txt

    Output:
        example.com.Subs.ip-A.txt
        example.com.Subs.mx.txt
        example.com.Subs.cname.txt
        example.com.Subs.No-cdn.txt
        example.com.Subs.CIDR.txt
        example.com.Subs.ptr.txt

    Use dnsx, cut-cdn & bgpview.io api


<h3> OpenSSL </h3>

Make TLS/SSL connection with domain & take more details

        ./hashtag-Recon dnsBrute -domain example.com -port 443

    Use openssl command in BASH

<h3> Whois </h3>

In this module Extract CIDR, Organization, Email, Inet & ...
And make Output cleaner & useful

        ./hashtag-Recon whois -subs example.com.subs.txt

    Output:
        example.com.Subs.whois.txt

    Use whois dig grep & a little creation in BASH

<h3> Favicon </h3>

Extract favicon of subdomain for search in Search Engines

        ./hashtag-Recon favicon -subs example.com.subs.txt

    Output:
        example.com.favicon.txt

    Use httpx & check simple live domains too

<h3> PortScan </h3>

In this module use Legend Nmap in 4 modes:

    - ssl-light
        Scan top ports use ssl 
    - ssl-heavy
        Scan known ports use ssl
    - http
        Scan known ports use http
    - top
        Scan 1000 top ports with --top-ports 1000 Nmap flag

        ./hashtag-Recon portscan -hosts example.com.CIDR.txt -domain example.com -ssl-heavy
        ./hashtag-Recon portscan -hosts example.com.ip.txt -domain example.com -ssl-light
        ./hashtag-Recon portscan -hosts example.com.resolve.txt -http
        ./hashtag-Recon portscan -hosts example.com.CIDR.txt -top

    Output:
        example.com-ssl-cert.all-domains.txt
        example.com-ssl-cert-domain.txt
        example.com-PortScan-http.txt
        example.com-PortScan-1000.txt

    Also use /usr/share/nmap/nmap-services file for extract port number

<h3> Some onliner for extract port numer </h3>

For extract ports that use SSL/TLS

```bash
sort -r -k3 /usr/share/nmap/nmap-services | tr "\t" " " | cut -d " " -f1-2 |  grep -E "(ssl|tls|https)" | grep -Eo "([0-9]*/tcp|[0-9]*/udp)" | cut -d / -f1 | sort -un | tr "\n" "," | sed "s/\,$//"
```
For extract ports that use http/https

```bash
sort -r -k3 /usr/share/nmap/nmap-services | tr "\t" " " | cut -d " " -f1-2 |  grep -E "(https|http)" | grep -Eo "([0-9]*/tcp|[0-9]*/udp)" | cut -d / -f1 | sort -un | tr "\n" "," | sed "s/\,$//"
```

<h3> vhostScan </h3>

Scan vitual host & fuzz in Host header in 3 mode:

    - Host: FUZZ
        Fuzz with custom wordlist ./wordlist/fuzz-vhost.txt
    
    - Host: FUZZ.domain.tld
        Fuzz wtih custom wordlist than concatinate main domain
    
    - Host: subs.domain.tld
        Fuzz with subdomain list that given

        ./hashtag-Recon vhostScan -url http://1.1.1.1 -domain example.com -subs example.com.subs.txt

    Output:
        example.com.vhostScan.csv

    Use ffuf & custom wordlist in this module

<h3> ApkExtract </h3>

Extract endpoint from Android file [.apk] when decomplie that 

        ./hashtag-Recon apkExtract -app example.apk

    Output:
        example.com.apk-Endpoint.txt

    Use apktools then grep command

<h4> Url Extract with on command !! </h4>

```bash
grep -IPhro "(https?://|http?://)[\w\.-/]+[\"'\`]"
```

<h3> LiveProbe </h3>

This modules Probe http ports in two mode

    - Light
        Scan top ports use http
    - heavy
        Scan known ports use http

        ./hashtag-Recon liveProbe -subs example.com.subs.txt -light
        ./hashtag-Recon liveProbe -subs example.com.subs.txt -heavy

    Output:
        example.com-httpx/
        example.com-live-httpx.txt
    
    Use amazing httpx and store raw response for other checks

<h3> ScreenShoter </h3>

Take screenShot from live domain for check functionality

        ./hashtag-Recon screenShoter -urls example.com.live.txt

    Output:
        example.com-shots/

    Also use httpx & if you don't install headless browser, httpx try to install that

<h2> Internal </h2>

<h3> Crawler </h3>

Crawl Live ulrs that earn in last modules & has two mode 

    - Light
        Fast crawl without headless browser
        Use katana, gospider, waybackurls

    - headless
        Deep crawl use headless browser
        Use light mode tools & katana with headless browser, aditional gauplus


        ./hashtag-Recon crawler -domain example.com -urls example.com.live.txt -headless
        ./hashtag-Recon crawler -domain example.com -urls example.com.live.txt -light

    Output:
        example.com.live.crawl.txt

<h3> JSEnum </h3>

This moment, time for JS file & has 3 mode

    - content
        Get JS urls then try to get content & hash MD5 for track changes

    - secret
        - url
            take github repo url then try to find sensetive data
            Need to set $GITHUB_TOKEN
        - dir
            take a directory that get in -content mode

    - endpoint
        Extract endpoints in JS files 

        ./hashtag-Recon jsEnum -content -urls example.com.live.txt
        ./hashtag-Recon jsEnum -secret -url http://github.com/example.git
        ./hashtag-Recon jsEnum -secret -dir example.com-JS-content-dir
        ./hashtag-Recon jsEnum -endpoint -dir example.com-JS-content-dir

    Output:
        example.com-JS-content--[date].txt
        example.com-JS-md5sum--[date].txt
        example.com-JS-SecretFinder.txt
        example.com-JS-endpoints.txt
    
    Use getJs, trufflehog, wget, grep, xargs & md5sum tools & commands in this module

<h3> Techdetect </h3>

Detect technology that use in domain name

        ./hashtag-Recon techDetect -domain example.com

    Output:
        example.com.techdetect.txt

    Use wappy, whatweb, wad & wafw00f

<h3> RoboMap </h3>

In this module use archive for find old sitemap.xml & robots.txt then try active and send request to url

        ./hashtag-Recon robomap -urls example.com.live.txt

    Output:
        example.com-robomap.txt

    Use robofinder, curl and a little BASH

<h3> Paramextract </h3>

Extract parameters use in app & make custom wordlist, also extract all path

        ./hashtag-Recon paramextract -urls example.com.crawl.txt
    Output:
        example.com-param-wordlist.txt
        example.com-paths.txt

    Use fetchParam(my first tool), unfurl

<h3> HiddenParam </h3>

This module has 2 mode

    - Light
        Fuzz parameter in url that given with custom wordlist & http method

    - Heavy
        Fuzz parameter in url with with top 20000 parameter & custom wordlist with GET & POST method

        ./hashtag-Recon hiddenParam -url "http://example.com[/param?key=value]"
                                    -wordlist example.com.param-wordlist.txt
                                    -light -method POST

        ./hashtag-Recon hiddenParam -url "http://example.com[/param?key=value]"
                                    -wordlist example.com.param-wordlist.txt
                                    -heavy
    Output:
        example.com-hparam-get.txt
        example.com-hparam-post.txt

    Use x8 & arjun and assetnote parameter wordlist

<h3>  HiddenHeader </h3>

Explain more about 2 mode

    - Light
        Fuzz header that given with custom wordlist & http method

    - Heavy
        Fuzz header with wordlists that include upper & mixcase case header with GET & POST method

        ./hashtag-Recon hiddenHeader -url http://example.com -heavy
        ./hashtag-Recon hiddenHeader -url http://example.com -light
                                     -wordlist header-wordlist.txt
                                     -method POST
    Output:
        example.com-hheader-get.txt
        example.com-hheader-post.txt

    Use x8 & Bugbounty parameter wordlist

<h2> Custom </h2>

<h3> Fuzzer </h3>

Fuzzer has 3 mode:

    - dir
        Fuzz url with sensetive directories in http://target.tld/FUZZ
    
    - file
        Fuzz url with sensetive files in http://target.tld/SOME-PATH/FUZZ

    - wordlist
        Fuzz url with Custom wordlist & need to declare FUZZ keyword in url

        ./hashtag-Recon fuzzer -url http://example.com -dir
        ./hashtag-Recon fuzzer -url http://example.com -file
        ./hashtag-Recon fuzzer -url http://example.com/FUZZ
                               -wordlist ./Custom-wordlist.txt
    Output:
        example.com-fuzz.csv
        example.com-fuzz-dir.csv
        example.com-fuzz-file.csv

    Use ffuf & bugbounty & assetnote wordlist

<h3> Tamper </h3>

Tamper url with http methods in two mode

    - Light
        Use top http methods
    
    - Heavy
        Use known & almost all http methods


        ./hashtag-Recon Tamper -url http://example.com -light
        ./hashtag-Recon Tamper -url http://example.com -heavy

    Output:
        example.com-tamper.txt


    Just use curl & a little BASH

<h3> Extractor </h3>

In this module, Extract outputs from other modules, such as:    

    - LiveProbe
        Extract result of liveprobe module with http Status code

    - Vhost
        Extract result of vhostScan module with http Status code & Parameter that FUZZ
    
    - crawl
        Extract result of Crawler module with Extention & has Parameter
    
    - Fuzz
        Extract result of Fuzzer module with http Status code
            
    - ip 
        Extract all IPs in files or directories
    
    - diff
        Check diffrence between that subdomain Just earnd by dnsBrute module and Not in Providers

        ./hashtag-Recon Extractor -liveprobe -input example.com.*
        ./hashtag-Recon Extractor -vhost -input *.vhostScan.csv
        ./hashtag-Recon Extractor -crawl -input example.com/*.txt
        ./hashtag-Recon Extractor -fuzz -input example.com.fuzz.csv
        ./hashtag-Recon Extractor -ip -input example.com.fuzz.txt
        ./hashtag-Recon Extractor -diff -provider example.com.subs.txt -dns example.com.live.txt
    Output:
        example.com.live.20X.txt
        example.com.vhostScan.4XX.txt
        example.com.crawl.hasParam.txt
        example.com.crawl.php.txt

    Use grep in this module
    And remember input can give wildcard too.

<h3> Let's Stir up emotions about grep & RegEx </h3>

```bash
#Extract with status code

grep -rhE "(20[0-8]{1})"                      # 20X
grep -rhE "(30[0-8]{1})"                      # 30X
grep -rhE "(4[0-2]{1}[0-9]{1})"               # 4XX 
grep -rhE "(5[0-1]{1}[0-9]{1})"               # 5XX

# Extract Crawler

grep -rhE "(\w+\.aspx(\?|$)|\w+\.asp(\?|$))"  # asp|aspx
grep -rhE "\w+\.php(\?|$)" >                  # php
grep -rhE "\w+\.js(\?|$)" >                   # js
grep -rhE "\w+\.jsp(\?|$)" >                  # jsp
grep ? | sort -u >                            # hashParam
grep -v ? | sort -u >                         # noParam.txt

```


<h3> Spliter </h3>

Split result of module when have huge result and need to split by:
    
    - Line
        Split file to files that contains n Lines in each file

    - File
        Split file to n files

    - Size
        Split file to files that has n size

    ./hashtag-Recon Spliter -input example.com.subs.txt -line 30
    ./hashtag-Recon Spliter -input example.com.crawl.txt -file 5
    ./hashtag-Recon Spliter -input example.com.crawl.txt -size 2M

    Output:
        example.com.crawlXX.txt ==> [XX:01-99]

    Just use split command in BASH

##  Let see Structure

You can Customize these script

And have better ideas to handle these, But educational purpose is included :)

    ├── hashtag-Recon
    ├── modules
    │   ├── Custom
    │   │   ├── Recon-extractor-crwal.sh
    │   │   ├── Recon-extractor-diffrence.sh
    │   │   ├── Recon-extractor-fuzz.sh
    │   │   ├── Recon-extractor-httpx.sh
    │   │   ├── Recon-extractor-ip.sh
    │   │   ├── Recon-extractor-vhost.sh
    │   │   ├── Recon-fuzz-custom.sh
    │   │   ├── Recon-fuzz-dir.sh
    │   │   ├── Recon-fuzz-file.sh
    │   │   ├── Recon-spliter-file.sh
    │   │   ├── Recon-spliter-line.sh
    │   │   ├── Recon-spliter-size.sh
    │   │   ├── Recon-verb-tamper-heavy.sh
    │   │   └── Recon-verb-tamper-light.sh
    │   ├── External
    │   │   ├── Recon-E-apk-extract.sh
    │   │   ├── Recon-E-dns-Brute-heavy.sh
    │   │   ├── Recon-E-dns-Brute-light.sh
    │   │   ├── Recon-E-DNS-CIDR.sh
    │   │   ├── Recon-E-favicon.sh
    │   │   ├── Recon-E-openssl-cert.sh
    │   │   ├── Recon-E-ORG-CIDR.sh
    │   │   ├── Recon-E-PortScan-http.sh
    │   │   ├── Recon-E-PortScan-ssl-cert-heavy.sh
    │   │   ├── Recon-E-PortScan-ssl-cert-light.sh
    │   │   ├── Recon-E-PortScan-top-1000.sh
    │   │   ├── Recon-E-ptResolver.sh
    │   │   ├── Recon-E-Resolver.sh
    │   │   ├── Recon-E-subdomain-heavy.sh
    │   │   ├── Recon-E-subdomain-light.sh
    │   │   ├── Recon-E-subdomain-recursive.sh
    │   │   ├── Recon-E-to-I-live-domains-heavy.sh
    │   │   ├── Recon-E-to-I-live-domains-light.sh
    │   │   ├── Recon-E-to-I-screen-shoter.sh
    │   │   └── Recon-E-vhost-Brute.sh
    │   └── Internal
    │       ├── Recon-I-crawl-headless.sh
    │       ├── Recon-I-crawl-light.sh
    │       ├── Recon-I-extract-param-path.sh
    │       ├── Recon-I-hidden-header-heavy.sh
    │       ├── Recon-I-hidden-header-light.sh
    │       ├── Recon-I-hidden-Param-heavy.sh
    │       ├── Recon-I-hidden-Param-light.sh
    │       ├── Recon-I-JS-enum-get-content.sh
    │       ├── Recon-I-JS-enum-get-endpoint.sh
    │       ├── Recon-I-JS-enum-get-secret-file.sh
    │       ├── Recon-I-JS-enum-get-secret-github.sh
    │       ├── Recon-I-robots-sitemap.sh
    │       └── Recon-I-tech-detect.sh

And wordlist directoy:


    ├── wordlist
    │   ├── arjun-param-special.json
    │   ├── dns-dnsgen-wordlist-heavy.txt
    │   ├── dns-dnsgen-wordlist-light.txt
    │   ├── dns-resolvers.txt
    │   ├── dns-wordlist-heavy.txt
    │   ├── dns-wordlist-light.txt
    │   ├── fuzz-cgi-files.txt
    │   ├── fuzz-config.txt
    │   ├── fuzz-dir-api-info.txt
    │   ├── fuzz-dir-backup_files.txt
    │   ├── fuzz-dir-cve.txt
    │   ├── fuzz-dir-leaky-misconfigs.txt
    │   ├── fuzz-dotfiles.txt
    │   ├── fuzz-env.txt
    │   ├── fuzz-keys.txt
    │   ├── fuzz-logs.txt
    │   ├── fuzz-npmrc.txt
    │   ├── fuzz-sensetive-files.txt
    │   ├── fuzz-sql.txt
    │   ├── fuzz-vhost.txt
    │   ├── fuzz-yaml.txt
    │   ├── passwords.txt
    │   ├── usernames.txt
    │   ├── x8-header-lowercase.txt
    │   ├── x8-header-uppercase.txt
    │   ├── x8-param-all.txt
    │   └── x8-param-mixescase-large.txt
    └── wordlist-Updater.sh

# Finally special thanks

<h3>

My dear & lovely Professor Mr [JADI](https://github.com/jadijadi)

</h3>

learned & learning valuable things from you both in life and on the Python & Linux

<h3>

Thansk a lot, learn many thing from both of you 🌱

</h3>

My handsome Professor [Borna](https://github.com/bnematzadeh)


And My Cute Professor [yashar](https://github.com/Voorivex)


And my friend [Mohamad Reza](https://github.com/omranisecurity) help me in this project

<hr>

Happy Learning :)

Happy Hunting 


<!-- ## License -->