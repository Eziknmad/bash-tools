#!/bin/bash

# ----------------------------------------------
# Log Parser Script - Finds repeated failed login attempts
# By your AI Mentor :)
# ----------------------------------------------

# Define the log file (you can change to /var/log/auth.log for real-world use)
LOG_FILE="/var/log/auth.log"

# Check if log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

echo "Analyzing failed login attempts..."
sleep 1

# 1. Use grep to filter lines with 'Failed password'
# 2. Use awk to extract the IP address (field 11)
# 3. Count occurrences per IP using sort and uniq
# 4. Use awk again to print only IPs with more than 2 failures
echo -e "\n--- Top Offenders (More than 2 failed attempts) ---"
grep "Failed password" "$LOG_FILE" | \
awk '{print $(NF-3)}' | \
sort | \
uniq -c | \
awk '$1 > 2 {print "IP: " $2 " - Attempts: " $1}'

# Explanation:
# grep → filters relevant lines
# awk '{print $(NF-3)}' → prints 4th field from the end (IP address)
# sort → prepares data for counting
# uniq -c → counts unique occurrences
# awk '$1 > 2' → filters only IPs with more than 2 failures

# 5. Bonus: List all failed attempts with timestamp and username (cleaned up)
echo -e "\n--- All Failed Login Attempts ---"
grep "Failed password" "$LOG_FILE" | \
awk '{print $1, $2, $3, "- User:", $(NF-5), "- IP:", $(NF-3)}'

# Explanation:
# $1 $2 $3 → date/time (e.g., Sep 29 12:00:01)
# $(NF-5) → username attempted
# $(NF-3) → source IP address

# 6. Extra: Extract only unique usernames attempted
echo -e "\n--- Unique Usernames Attempted ---"
grep "Failed password" "$LOG_FILE" | \
awk '{print $(NF-5)}' | \
sort | uniq
