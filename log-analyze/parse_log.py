#!/usr/bin/env python3
# 👆 This tells the system to use Python 3 to run the script.
# Using '/usr/bin/env' makes sure it finds Python 3 no matter where it’s installed.

"""
parse_log.py - Extracts failed SSH login attempts from auth.log
"""
# 👆 This is a multi-line string (called a docstring).
# It describes what the script does: it finds failed SSH login attempts from the system log file.

import re
# 👆 Imports Python's Regular Expression (regex) module.
# We'll use regex to search for patterns (like IP addresses and usernames) in text.

# Set the path of the log file we want to analyze.
logfile = "./auth.log"

# Create and compile a regex pattern that matches failed SSH login messages.
# The pattern looks for lines like:
# "Failed password for invalid user <username> from <ip>"
pattern = re.compile(r'Failed password for invalid user (\w+) from ([\d\.]+)')

# Create an empty dictionary to store failed login attempts.
# The keys will be IP addresses, and the values will be the number of failed attempts.
failed_attempts = {}

# Open the log file in read mode.
with open(logfile, "r") as file:
    # Loop through each line in the file.
    for line in file:
        # Try to find a match in the line using our regex pattern.
        match = pattern.search(line)
        
        # If a match is found, extract the username and IP address.
        if match:
            user, ip = match.groups()  # .groups() returns both captured values from the regex
            
            # If this IP address hasn't been seen before, add it to the dictionary with a count of 0.
            if ip not in failed_attempts:
                failed_attempts[ip] = 0
            
            # Increase the count of failed attempts for this IP.
            failed_attempts[ip] += 1

# Print a header before showing the results.
print("\nFailed SSH Login Attempts by IP:")

# Loop through each IP address and its count of failed attempts.
for ip, count in failed_attempts.items():
    # Only print IPs that have more than 2 failed attempts.
    # This helps ignore minor or accidental login mistakes.
    if count > 2:
        # Print the IP and the number of failed attempts using f-string formatting.
        print(f"IP: {ip} - Attempts: {count}")


