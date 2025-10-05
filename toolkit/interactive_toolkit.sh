#!/bin/bash

# -------------------------------------------
# Linux Toolkit Script - Bash Admin Utilities
# Author: Your Name
# -------------------------------------------

# ---------------- Colors -------------------
RED='\033[0;31m'    # Red text
GREEN='\033[0;32m'  # Green text
YELLOW='\033[1;33m' # Yellow text
NC='\033[0m'        # No Color

# --------------- Trap Exit ------------------
# Ensures the script exits cleanly
trap "echo -e '\n${RED}Script interrupted! Exiting...${NC}'; exit 1" SIGINT

# -------------- Logger Function --------------
log_output() {
    # Function to log messages to a file
    local message=$1
    local logfile="toolkit.log"
    echo "$(date) | $message" >> $logfile
}

# --------------- Disk Usage ------------------
check_disk_usage() {
    echo -e "${YELLOW}Checking disk usage...${NC}"
    df -h | grep '^/dev' | awk '{print $1, $5, $6}'
    log_output "Checked disk usage"
}

# ----------- Check Logged-In Users ------------
check_users() {
    echo -e "${YELLOW}Currently logged in users:${NC}"
    who
    log_output "Listed current users"
}

# -------- Check for Failed SSH Logins ----------
check_failed_logins() {
    echo -e "${YELLOW}Recent failed SSH login attempts:${NC}"
    grep "Failed password" /var/log/auth.log | tail -n 5 | awk '{print $(NF-5), $(NF-3)}'
    log_output "Checked failed login attempts"
}

# -------- Accept Argument to Check a User ------
check_user_processes() {
    username=$1

    if [ -z "$username" ]; then
        echo -e "${RED}Error: Username not provided.${NC}"
        return 1
    fi

    echo -e "${YELLOW}Processes for user ${GREEN}$username${NC}:"
    ps -u "$username"
    log_output "Checked processes for user $username"
}

# --------- Main Menu using Case Statement --------
main_menu() {
    while true; do
        echo -e "\n${GREEN}Linux Admin Toolkit${NC}"
        echo "1. Check Disk Usage"
        echo "2. Show Logged-in Users"
        echo "3. Check Failed SSH Logins"
        echo "4. Check User's Processes (need username)"
        echo "5. Exit"

        read -rp "Choose an option [1-5]: " choice

        case $choice in
            1) check_disk_usage ;;
            2) check_users ;;
            3) check_failed_logins ;;
            4)
                read -rp "Enter username: " user_input
                check_user_processes "$user_input"
                ;;
            5)
                echo -e "${GREEN}Goodbye!${NC}"
                log_output "Exited toolkit"
                exit 0
                ;;
            *)
                echo -e "${RED}Invalid choice, try again.${NC}"
                ;;
        esac
    done
}

# --------------- Run the Menu ------------------
main_menu
