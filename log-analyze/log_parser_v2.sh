#!/bin/bash
# Use the system's bash interpreter to run this script.

# ------------------------------
# Log Parser v2 - With Colors and Functions
# ------------------------------
# This script parses /var/log/auth.log for failed SSH login attempts,
# highlights IPs with many failures, and prints all failures.
# It's structured with small functions and uses ANSI colors for readability.

# Define the log file
LOG_FILE="/var/log/auth.log"
# 👆 Path to the log file the script will read. Change this if your auth log is elsewhere.

# Color codes (ANSI escape sequences)
RED='\033[0;31m'    # red text for errors
GREEN='\033[0;32m'  # green text (unused here, but available)
YELLOW='\033[1;33m' # bright yellow for headings
NC='\033[0m'        # "No Color" — resets color back to terminal default

# Function to check file
check_log_file() {
    # Check if the file exists and is a regular file.
    if [ ! -f "$LOG_FILE" ]; then
        # If the file doesn't exist, print an error in red and exit with code 1.
        echo -e "${RED}Error: Log file not found: $LOG_FILE${NC}"
        exit 1
    fi
}
# 👆 Ensures the script doesn't continue if the log file can't be read.

# Function to list brute force IPs
show_brute_force_ips() {
    # Print a colored heading to indicate the section.
    echo -e "${YELLOW}--- IPs with More Than 2 Failed Logins ---${NC}"

    # Pipeline explained:
    # 1) grep "Failed password" "$LOG_FILE"
    #    → Select only lines that indicate failed SSH password attempts.
    # 2) awk '{print $(NF-3)}'
    #    → For each matched line, print the field at position NF-3.
    #       - NF is the number of fields in the current record (line).
    #       - Using NF-3 picks a field relative to the line end (helps if usernames vary).
    #       - Typical `/var/log/auth.log` failed line looks like:
    #         "Oct  1 12:34:56 hostname sshd[1234]: Failed password for invalid user test from 1.2.3.4 port 22 ssh2"
    #       - In that example, NF-3 is the IP "1.2.3.4" (but exact field depends on distro/log format).
    # 3) sort
    #    → Sort IPs so duplicates are adjacent for counting.
    # 4) uniq -c
    #    → Count identical lines and prefix each with the count.
    # 5) awk '$1 > 2 {print "IP: " $2 " -

