#!/bin/bash

# Colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Sci-fi Intro
clear
if ! command -v figlet &> /dev/null; then
    echo -e "${RED}Missing: figlet (install it)${NC}"
    exit 1
fi

figlet "ReconDrone" | lolcat 2>/dev/null || figlet "ReconDrone"
echo -e "${CYAN}Initializing Recon Drone Intelligence Core...${NC}"
sleep 1
echo -e "${CYAN}Loading reconnaissance modules...${NC}"
sleep 1

# Input Target
read -p "Enter target (domain/IP/username): " target
echo -e "${CYAN}Target locked: $target${NC}"
sleep 1

# Log file
LOGFILE="recon-drone-$(date +%Y%m%d-%H%M%S).log"
echo "=== ReconDrone Report for $target ===" > $LOGFILE
echo "" >> $LOGFILE

# Target Type Detection
is_ip() {
    [[ $target =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
}

is_domain() {
    [[ $target =~ ^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]
}

#IP Address Recon
if is_ip; then
echo -e "${GREEN}Detected target as IP address.${NC}"

echo -e "${GREEN}Running WHOIS Lookup...${NC}"
echo ">> WHOIS Lookup" >> $LOGFILE
whois "$target" | tee -a $LOGFILE

echo -e "${GREEN}Running NSLOOKUP...${NC}"
echo ">> DNS Records" >> $LOGFILE
nslookup "$target" | tee -a $LOGFILE
echo "" >> $LOGFILE 

echo -e "${GREEN}Running Nmap Fast Scan...${NC}"
echo ">> Nmap Fast Scan" >> $LOGFILE
nmap -F "$target" | tee -a $LOGFILE

#Http Headers

echo -e "${GREEN}HTTP Headers (curl):${NC}"
echo ">> HTTP Headers" >> $LOGFILE
curl -I "$target" 2>/dev/null | tee -a $LOGFILE
echo "" >> $LOGFILE


# ───────────────────────────────
# MODULE: Domain Recon
# ───────────────────────────────
elif is_domain; then
    echo -e "${GREEN}Detected target as domain.${NC}"

    echo -e "${GREEN}Running WHOIS...${NC}"
    echo ">> WHOIS" >> $LOGFILE
    whois "$target" | tee -a $LOGFILE

    echo -e "${GREEN}Running DNS Lookup...${NC}"
    echo ">> DNS Records" >> $LOGFILE
    nslookup "$target" | tee -a $LOGFILE

    echo -e "${GREEN}Running HTTP Header Grab...${NC}"
    echo ">> HTTP Headers" >> $LOGFILE
    curl -I "$target" 2>/dev/null | tee -a $LOGFILE

    echo -e "${GREEN}Running Nmap Fast Scan...${NC}"
    echo ">> Nmap Fast Scan" >> $LOGFILE
    nmap -F "$target" | tee -a $LOGFILE

    # Optional Tools
    if command -v theHarvester &> /dev/null; then
        echo -e "${GREEN}Running theHarvester...${NC}"
        echo ">> theHarvester (bing, limit 10)" >> $LOGFILE
        theHarvester -d "$target" -b bing -l 10 | tee -a $LOGFILE
    fi

    if command -v subfinder &> /dev/null; then
        echo -e "${GREEN}Running Subfinder...${NC}"
        echo ">> Subfinder" >> $LOGFILE
        subfinder -d "$target" | tee -a $LOGFILE
    fi

    if command -v amass &> /dev/null; then
        echo -e "${GREEN}Running Amass Passive Scan...${NC}"
        echo ">> Amass Passive Scan" >> $LOGFILE
   amass enum -passive -d "$target" | tee -a $LOGFILE
    fi


# MODULE: Username OSINT
else
    echo -e "${GREEN}Detected target as possible username (OSINT).${NC}"
    echo ">> Username OSINT module (reserved for future)" >> $LOGFILE
    echo "Future: Sherlock / Socialscan / GHunt integration" >> $LOGFILE
fi

# Complete

echo -e "${CYAN}Recon Complete.${NC}"
echo -e "${CYAN}Report saved to ${LOGFILE}${NC}"
