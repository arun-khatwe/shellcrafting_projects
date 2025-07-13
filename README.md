
# Shell Script Projects

A collection of shell projects, bash tools for hackers, sysadmins, and power users.

## Tools Included

### 1. `bioscanner.sh`
A system health visualizer showing:
- RAM, CPU, Disk usage
- Battery status
- CPU warnings if usage > 80%

### 2. `recondrone.sh`
An automated OSINT reconnaissance toolkit that:
- Accepts domain, IP, or username
- Runs whois, nslookup, nmap, curl
- Integrates `theHarvester`, `subfinder`, and `amass`

### 3. `cyber_scaffold.sh`
Creates a folder structure for offensive/defensive cybersecurity projects:
- `model`, `controller`, `views`, `img`, etc.

### 4. `system_diagnose.sh`
Auto-diagnoses and updates Fedora/Kali systems:
- Updates packages
- Shows boot time, systemd blame
- Styled as a futuristic system reboot/repair tool

### 5. `library_management.sh`
A terminal-based personal library system to track books, authors, and read status (WIP).

## Requirements
- Bash 5+
- Fedora/Kali Linux
- Tools: `nmap`, `whois`, `curl`, `figlet`, `lolcat`, `upower`, `theHarvester`, `amass`, `subfinder`

## How to Use

Make executable:
```bash
chmod +x *.sh
