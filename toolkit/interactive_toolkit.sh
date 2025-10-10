#!/bin/bash
# 👆 Shebang: tells the system to run this script using the Bash shell.

# -------------------------------------------
# Linux Toolkit Script - Bash Admin Utilities
# Author: Your Name
# -------------------------------------------
# 🧠 Purpose:
# This script provides a simple terminal-based toolkit
# for common Linux admin tasks like checking disk usage,
# logged-in users, failed SSH logins, and user processes.

# ---------------- Colors -------------------
# ANSI color codes to make the output visually clear and organized.
RED='\033[0;31m'    # 🔴 Red text for errors or alerts
GREEN='\033[0;32m'  # 🟢 Green text for success messages
YELLOW='\033[1;33m' # 🟡 Yellow text for warnings or section headers
NC='\033[0m'        # ⚪ No Color — resets to default terminal color

# --------------- Trap Exit ------------------
# A 'trap' command lets you capture signals (like Ctrl + C) to handle them gracefully.
# Here we catch SIGINT (Interrupt Signal) and print a message before exiting.
trap "echo -e '\n${RED}Script interrupted! Exiting...${NC}'; exit 1" SIGINT

# -------------- Logger Function --------------
log_output() {
    # 🧾 Function to log actions into a file (toolkit.log)
    # Usage: log_output "Message"
    
    local message=$1          # Store the first argument as the message to log
    local logfile="toolkit.log"  # Define the log file name

    # Append the current date and message to the logfile
    echo "$(date) | $message" >> $logfile
}

# --------------- Disk Usage ------------------
check_disk_usage() {
    echo -e "${YELLOW}Checking disk usage...${NC}"
    # 🧱 'df -h' = Disk Free command, with human-readable sizes (GB, MB)
    # 'grep "^/dev"' = Only show lines starting with /dev (physical or virtual disks)
    # 'awk' prints selected columns:
    #   $1 = filesystem name
    #   $5 = percent used
    #   $6 = mount point
    df -h | grep '^/dev' | awk '{print $1, $5, $6}'

    # Log the action
    log_output "Checked disk usage"
}

# ----------- Check Logged-In Users ------------
check_users() {
    echo -e "${YELLOW}Currently logged in users:${NC}"
    # 🧍 'who' command shows all logged-in users with their terminal and login time
    who

    # Log the action
    log_output "Listed current users"
}

# -------- Check for Failed SSH Logins ----------
check_failed_logins() {
    echo -e "${YELLOW}Recent failed SSH login attempts:${NC}"
    # 🔐 Searches /var/log/auth.log for failed SSH login messages.
    # 'grep' finds lines containing "Failed password"
    # 'tail -n 5' limits the output to the last 5 entries
    # 'awk' prints fields from the line:
    #   $(NF-5) → usually the username
    #   $(NF-3) → usually the IP address
    grep "Failed password" /var/log/auth.log | tail -n 5 | awk '{print $(NF-5), $(NF-3)}'

    # Log the action
    log_output "Checked failed login attempts"
}

# -------- Accept Argument to Check a User ------
check_user_processes() {
    username=$1  # Grab the first argument passed to the function

    # If no username was given, show an error and return with failure code (1)
    if [ -z "$username" ]; then
        echo -e "${RED}Error: Username not provided.${NC}"
        return 1
    fi

    # 🧑‍💻 Display processes running under that username
    echo -e "${YELLOW}Processes for user ${GREEN}$username${NC}:"
    ps -u "$username"   # 'ps -u username' lists all processes belonging to that user

    # Log the action
    log_output "Checked processes for user $username"
}

# --------- Main Menu using Case Statement --------
main_menu() {
    # 💡 This creates a continuous loop displaying a menu
    # and letting the user pick an option until they exit.

    while true; do
        # Display menu header
        echo -e "\n${GREEN}Linux Admin Toolkit${NC}"
        echo "1. Check Disk Usage"
        echo "2. Show Logged-in Users"
        echo "3. Check Failed SSH Logins"
        echo "4. Check User's Processes (need username)"
        echo "5. Exit"

        # Ask for user input (read input into variable 'choice')
        read -rp "Choose an option [1-5]: " choice

        # 🧩 Case statement: checks what the user typed
        case $choice in
            1)
                # Option 1: Disk usage
                check_disk_usage
                ;;
            2)
                # Option 2: Logged-in users
                check_users
                ;;
            3)
                # Option 3: Failed logins
                check_failed_logins
                ;;
            4)
                # Option 4: Ask for a username and check their processes
                read -rp "Enter username: " user_input
                check_user_processes "$user_input"
                ;;
            5)
                # Option 5: Exit cleanly
                echo -e "${GREEN}Goodbye!${NC}"
                log_output "Exited toolkit"
                exit 0
                ;;
            *)
                # Any other input → invalid choice
                echo -e "${RED}Invalid choice, try again.${NC}"
                ;;

