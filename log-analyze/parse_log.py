#!/usr/bin/env python3

"""
parse_log.py - Extracts failed SSH login attempts from auth.log
"""

import re

logfile = "./auth.log"

pattern = re.compile(r'Failed password for invalid user (\w+) from ([\d\.]+)')
failed_attempts = {}

with open(logfile, "r") as file:
    for line in file:
        match = pattern.search(line)
        if match:
            user, ip = match.groups()
            if ip not in failed_attempts:
                failed_attempts[ip] = 0
            failed_attempts[ip] += 1

print("\nFailed SSH Login Attempts by IP:")
for ip, count in failed_attempts.items():
    if count > 2:
        print(f"IP: {ip} - Attempts: {count}")
