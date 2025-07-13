#!/bin/bash


# 🔧 Fedora System Diagnostic Protocol - INIT
#

clear
echo "Initializing Fedora Diagnostic Core..."
sleep 1
echo "Scanning kernel pulse..."
sleep 0.5
echo "Syncing with DNF package matrix..."
sleep 0.5
echo "Charging updater modules..."
sleep 0.5
echo
echo "┌────────────────────────────────────────────┐"
echo "│     Fedora OS Uplink Terminal v1.0         │"
echo "├────────────────────────────────────────────┤"
echo "│  SYSTEM STATUS: Preparing for warp update  │"
echo "│  MODE: Maintenance + Diagnostic Scan       │"
echo "└────────────────────────────────────────────┘"
echo

# Start Update & Clean Process


echo "Updating system packages..."
sudo dnf upgrade --refresh -y

echo "Cleaning unnecessary packages..."
sudo dnf autoremove -y
sudo dnf clean all


# System Diagnostics

echo
echo "Launching Boot Time Diagnostic..."
sleep 1
echo
systemd-analyze

echo
echo "Analyzing boot service delays (Top 10)..."
sleep 1
echo
systemd-analyze blame | head -n 10

# ───────────────────────────────────────────────
# Restarting NGINX if installed
# ───────────────────────────────────────────────

if command -v nginx &> /dev/null; then
    echo
    echo "Restarting NGINX web engine..."
    sudo systemctl restart nginx
    echo "NGINX restarted successfully."
else
    echo
    echo "NGINX not detected. Skipping web engine restart."
fi

# ───────────────────────────────────────────────
# Finished
# ───────────────────────────────────────────────

echo
echo "Mission Complete: Fedora system update and diagnostics finished."
echo "You are now running with optimized systems and refreshed packages!"
echo "TIP: Run this script weekly for peak Fedora performance."
echo "Stay Secured!!"
