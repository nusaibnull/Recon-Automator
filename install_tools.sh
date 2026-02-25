#!/bin/bash

# ==========================================
# nusaibSec Recon Tools Installer
# ==========================================

echo -e "\e[1;32m[🔥] Welcome to nusaibSec Recon Tools Installer [🔥]\e[0m"
echo "[*] Please wait while we set up your hacking environment..."
echo "---------------------------------------------------"

# 1. System Update & Essential Packages
echo -e "\e[1;34m[*] Installing System Dependencies (Nmap, Git, Python, Go)...\e[0m"
sudo apt-get update -y
sudo apt-get install -y git python3 python3-pip nmap curl wget jq golang-go

# Setup Go Environment path if not exists
if ! grep -q "GOPATH" ~/.bashrc; then
    echo 'export GOPATH=$HOME/go' >> ~/.bashrc
    echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
    source ~/.bashrc
fi
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# 2. Installing Go based tools (ProjectDiscovery & Tomnomnom)
echo -e "\e[1;34m[*] Installing Go-based Recon Tools...\e[0m"

go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/tomnomnom/assetfinder@latest
go install -v github.com/projectdiscovery/chaos-client/cmd/chaos@latest
go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest
go install -v github.com/tomnomnom/anew@latest
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/LukaSikic/subzy@latest
go install -v github.com/projectdiscovery/katana/cmd/katana@latest
go install -v github.com/projectdiscovery/asnmap/cmd/asnmap@latest
go install -v github.com/KathanP19/Gxss@latest
go install -v github.com/owasp-amass/amass/v4/...@master

# 3. Installing Python based tools
echo -e "\e[1;34m[*] Installing Python-based Tools...\e[0m"
pip3 install uro --break-system-packages 2>/dev/null || pip3 install uro

# 4. Installing OneForAll (Requires Git Clone)
echo -e "\e[1;34m[*] Setting up OneForAll...\e[0m"
if [ ! -d "$HOME/tools/OneForAll" ]; then
    mkdir -p $HOME/tools
    cd $HOME/tools
    git clone https://github.com/shmilylty/OneForAll.git
    cd OneForAll
    python3 -m pip install -U pip setuptools wheel --break-system-packages 2>/dev/null || python3 -m pip install -U pip setuptools wheel
    pip3 install -r requirements.txt --break-system-packages 2>/dev/null || pip3 install -r requirements.txt
    
    # Create a global execution command for OneForAll
    sudo ln -s $(pwd)/oneforall.py /usr/local/bin/oneforall 2>/dev/null
    cd - > /dev/null
else
    echo "[!] OneForAll is already installed in $HOME/tools/OneForAll"
fi

echo "---------------------------------------------------"
echo -e "\e[1;32m[✔] BOOM! All tools are installed successfully! 🚀\e[0m"
echo "[*] Run 'source ~/.bashrc' or restart your terminal to ensure all paths are loaded."
echo "[*] Now you can run: ./recon.sh <target.com>"
