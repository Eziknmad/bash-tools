#!/bin/bash

# ------------------------------
# Log Parser v2 - With Colors and Functions
# ------------------------------

# Define the log file
LOG_FILE="/var/log/auth.log"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check file
check_log_file() {
    if [ ! -f "$LOG_FILE" ]; then
        echo -e "${RED}Error: Log file not found: $LOG_FILE${NC}"
        exit 1
    fi
}

# Function to list brute force IPs
show_brute_force_ips() {
    echo -e "${YELLOW}--- IPs with More Than 2 Failed Logins ---${NC}"
    grep "Failed password" "$LOG_FILE" | \
    awk '{print $(NF-3)}' | \
    sort | uniq -c | \
    awk '$1 > 2 {print "IP: " $2 " - Attempts: " $1}'
}

# Function to show all failed login attempts
show_all_failures() {
    echo -e "${YELLOW}--- All Failed Login Attempts ---${NC}"
    grep "Failed password" "$LOG_FILE" | \
    awk '{print $1, $2, $3, "- User:", $(NF-5), "- IP:", $(NF-3)}'
}

# Main script
check_log_file
show_brute_force_ips
show_all_failures
