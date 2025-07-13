#!/bin/bash

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

# Function to create a simple bar graph (max 20 chars)
bar() {
local value=$1
local max=100
local length=20
local filled=$(( value * length / max ))
local empty=$(( length - filled ))
printf "["
for ((i=0; i<filled; i++)); do printf "#"; done
for ((i=0; i<empty; i++)); do printf " "; done
printf "]"
}

clear
echo -e "${CYAN}==== BioScan: System Health Visualizer ====${NC}"
echo ""

# Uptime
uptime_str=$(uptime -p)
echo -e "${GREEN}System Uptime:${NC} $uptime_str"

# RAM Usage
read total used free <<< $(free -m | awk 'NR==2{print $2, $3, $4}')
ram_percent=$(( used * 100 / total ))
echo -ne "${GREEN}RAM Usage:${NC} $used MB / $total MB "
bar $ram_percent
echo " $ram_percent%"

# CPU Load (1 min average)
cpu_load=$(cut -d ' ' -f1 /proc/loadavg)
cpu_cores=$(nproc)
cpu_percent=$(awk -v cpuload=$cpu_load -v cores=$cpu_cores 'BEGIN {printf "%.0f", (cpuload/cores)*100}')
echo -ne "${GREEN}CPU Load:${NC} $cpu_load (avg) "
bar $cpu_percent
echo " $cpu_percent%"

#Warning beep if CPU usage > 80%
if [[ "$cpu_percent" =~ ^[0-9]+$ ]] && [ "$cpu_percent" -gt 80 ]; then
echo -e "${RED}Warning: CPU usage above 80%!${NC}"
echo -e "\a"
fi

# Disk Usage (root partition)
disk_used=$(df -h / | awk 'NR==2 {print $3}')
disk_total=$(df -h / | awk 'NR==2 {print $2}')
disk_percent=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
echo -ne "${GREEN}Disk Usage:${NC} $disk_used / $disk_total "
bar $disk_percent
echo " $disk_percent%"

# Battery Status (if available)
if [ -d "/sys/class/power_supply/BAT0" ]; then
bat_capacity=$(cat /sys/class/power_supply/BAT0/capacity)
bat_status=$(cat /sys/class/power_supply/BAT0/status)
color=$GREEN
if [ "$bat_capacity" -le 20 ]; then
color=$RED
elif [ "$bat_capacity" -le 50 ]; then
color=$YELLOW
fi
echo -ne "${color}Battery:${NC} $bat_capacity% ($bat_status) "
bar $bat_capacity
echo ""
else
echo -e "${YELLOW}Battery: No battery detected or not on laptop.${NC}"
fi

# Warning beep if CPU usage > 80%
if [ "$cpu_percent" -gt 80 ]; then
echo -e "${RED}Warning: CPU usage above 80%!${NC}"
echo -e "\a"  # beep sound
fi

echo ""
