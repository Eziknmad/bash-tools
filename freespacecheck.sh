#!/bin/bash

# This script checks disk usage and alerts if usage is above 80%

# Get the disk usage of root partition (/) in percentage (without % sign)
usage=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

# Print current usage
echo "Current disk usage: $usage%"

# Check if usage is greater than 80
if [ "$usage" -gt 80 ]; then
    echo "Warning: Disk usage is above 80%!"
else
    echo "Disk usage is under control."
fi
