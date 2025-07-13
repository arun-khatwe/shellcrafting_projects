#!/bin/bash

echo "Enter Your Project Name: " 
read project_name 

# Create root project folder
mkdir "$project_name"
echo "Root Folder '$project_name' created"
cd "$project_name" || exit

# Core app folders
mkdir model
mkdir controller
mkdir views
mkdir config
mkdir logs
mkdir utils
mkdir scripts
mkdir tests

# Security-related folders
mkdir exploits
mkdir payloads
mkdir reports
mkdir wordlists
mkdir recon
mkdir scans
mkdir tmp

# Public/static resources (web tools)
mkdir -p public/{css,js,img,fonts}

# Add README and starter files
touch README.md
touch .gitignore
touch requirements.txt
touch main.py

# Example usage of project name in README
echo "# $project_name" > README.md
echo "$project_name: Cybersecurity Toolkit Project" >> README.md

# Sample gitignore
cat <<EOL > .gitignore
__pycache__/
*.pyc
*.log
.env
tmp/
EOL

# Init optional Git repo
read -p "Initialize Git repo? (y/n): " init_git
if [[ $init_git == "y" ]]; then
    git init
    echo "Git repository initialized"
fi

echo "Project structure created successfully for '$project_name'"
echo "Stay Secured"
