#!/bin/bash

# ==========================================
# Automated Bug Bounty Recon Script
# ==========================================

if [ -z "$1" ]; then
    echo "[!] Usage: ./recon.sh <target.com>"
    exit 1
fi

TARGET=$1
DIR="${TARGET}_recon"
mkdir -p $DIR
cd $DIR

echo "[+] Starting Recon on: $TARGET"
echo "[+] Results will be saved in: $DIR/"
echo "---------------------------------------------------"

# Phase 1: Passive Mapping (Subdomain Enumeration)
echo "[*] Phase 1: Lightning-Fast Passive Mapping..."
subfinder -d $TARGET -silent | anew passive_subs.txt
assetfinder --subs-only $TARGET | anew passive_subs.txt
# (Assuming Chaos API is configured in your environment)
chaos -d $TARGET -silent | anew passive_subs.txt
echo "[+] Found $(wc -l < passive_subs.txt) passive subdomains."

# Phase 2: DNS Resolution (Filtering the Noise)
echo "[*] Phase 2: Resolving DNS & Filtering Dead Targets..."
cat passive_subs.txt | dnsx -silent > resolved_subs.txt
echo "[+] Found $(wc -l < resolved_subs.txt) alive subdomains."

# Phase 3: Infrastructure & Port Analysis
echo "[*] Phase 3: Port Scanning with Naabu & Nmap..."
naabu -l resolved_subs.txt -top-ports 100 -silent > open_ports.txt
echo "[+] Running Nmap on discovered open ports..."
nmap -iL open_ports.txt -sV -sC -T4 -oN nmap_scan_results.txt > /dev/null 2>&1

# Phase 4: Web Probing & Vulnerability Scanning
echo "[*] Phase 4: Probing Web Apps & Checking Subdomain Takeovers..."
cat resolved_subs.txt | httpx -silent -sc -tech -title > live_webapps.txt
subzy run --targets resolved_subs.txt > potential_takeovers.txt

# Phase 5: Deep Crawling & JS Extraction
echo "[*] Phase 5: Deep Crawling with Katana..."
cat live_webapps.txt | awk '{print $1}' | katana -silent -depth 3 > all_urls.txt

echo "[+] Extracting .js files and sensitive extensions..."
cat all_urls.txt | grep -E "\.js$" > js_files.txt
cat all_urls.txt | grep -E "\.xml$|\.bak$|\.sql$|\.pdf$|\.env$|\.git$" > sensitive_files.txt

# Phase 6: Automated Parameter Mining (XSS Prep)
echo "[*] Phase 6: Cleaning URLs & Mining Parameters..."
cat all_urls.txt | uro > clean_urls.txt
cat clean_urls.txt | grep "=" | gxss -p rxss > reflected_params_xss.txt
echo "[+] Found $(wc -l < reflected_params_xss.txt) parameters primed for testing."

# Phase 7: The Background Heavy Lifters
echo "[*] Phase 7: Firing Background Tools (Amass, ASNMap)..."
# Running these in the background so you can start hacking right away
asnmap -d $TARGET -silent > asn_results.txt &
amass enum -passive -d $TARGET -out amass_subs.txt &
# Note: OneForAll is a Python tool, assuming you have an alias or binary for it
# oneforall --target $TARGET run &

echo "---------------------------------------------------"
echo "[✔] FAST RECON COMPLETE! Heavy lifters are running in the background."
echo "[✔] Check the '$DIR' folder for your hackable attack surface."
